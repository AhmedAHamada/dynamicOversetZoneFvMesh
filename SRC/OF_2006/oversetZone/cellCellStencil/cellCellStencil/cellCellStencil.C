/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | www.openfoam.com
     \\/     M anipulation  |
-------------------------------------------------------------------------------
    Copyright (C) 2017-2019 OpenCFD Ltd.
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify i
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "cellCellStencil.H"
#include "addToRunTimeSelectionTable.H"
#include "volFields.H"
#include "syncTools.H"
#include "globalIndex.H"

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

namespace Foam
{
    defineTypeNameAndDebug(cellCellStencil, 0);
    defineRunTimeSelectionTable(cellCellStencil, mesh);
}

const Foam::Enum
<
    Foam::cellCellStencil::cellType
>
Foam::cellCellStencil::cellTypeNames_
({
    { cellType::CALCULATED, "calculated" },
    { cellType::INTERPOLATED, "interpolated" },
    { cellType::HOLE, "hole" },
});


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::cellCellStencil::cellCellStencil(const fvMesh& mesh)
:
    mesh_(mesh),
    nonInterpolatedFields_({"zoneID"})
{}


Foam::autoPtr<Foam::cellCellStencil> Foam::cellCellStencil::New
(
    const fvMesh& mesh,
    const dictionary& dict,
    const bool update
)
{
    DebugInFunction << "Constructing cellCellStencil" << endl;

    const word stencilType(dict.get<word>("method"));

    auto cstrIter = meshConstructorTablePtr_->cfind(stencilType);

    if (!cstrIter.found())
    {
        FatalIOErrorInLookup
        (
            dict,
            "cellCellStencil",
            stencilType,
            *meshConstructorTablePtr_
        ) << exit(FatalIOError);
    }

    return autoPtr<cellCellStencil>(cstrIter()(mesh, dict, update));
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::cellCellStencil::~cellCellStencil()
{}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

const Foam::labelIOList& Foam::cellCellStencil::zoneID(const fvMesh& mesh)
{
    if (!mesh.foundObject<labelIOList>("zoneID"))
    {
        labelIOList* zoneIDPtr = new labelIOList
        (
            IOobject
            (
                "zoneID",
                mesh.facesInstance(),
                polyMesh::meshSubDir,
                mesh,
                IOobject::NO_READ,
                IOobject::NO_WRITE
            ),
            mesh.nCells()
        );
        labelIOList& zoneID = *zoneIDPtr;

        volScalarField volZoneID
        (
            IOobject
            (
                "zoneID",
                mesh.time().findInstance(mesh.dbDir(), "zoneID"),
                mesh,
                IOobject::MUST_READ,
                IOobject::NO_WRITE,
                false
            ),
            mesh
        );
        forAll(volZoneID, cellI)
        {
            zoneID[cellI] = label(volZoneID[cellI]);
        }

        zoneIDPtr->store();
    }
    return mesh.lookupObject<labelIOList>("zoneID");
}


Foam::labelList Foam::cellCellStencil::count
(
    const label size,
    const labelUList& lst
)
{
    labelList count(size, Zero);
    forAll(lst, i)
    {
        count[lst[i]]++;
    }
    Pstream::listCombineGather(count, plusEqOp<label>());
    return count;
}


const Foam::wordHashSet& Foam::cellCellStencil::nonInterpolatedFields() const
{
    return nonInterpolatedFields_;
}


Foam::wordHashSet& Foam::cellCellStencil::nonInterpolatedFields()
{
    return nonInterpolatedFields_;
}


bool Foam::cellCellStencil::localStencil(const labelUList& slots) const
{
    forAll(slots, i)
    {
        if (slots[i] >= mesh_.nCells())
        {
            return false;
        }
    }
    return true;
}


void Foam::cellCellStencil::globalCellCells
(
    const globalIndex& gi,
    const polyMesh& mesh,
    const boolList& isValidCell,
    const labelList& selectedCells,
    labelListList& cellCells,
    pointListList& cellCellCentres
)
{
    // For selected cells determine the face neighbours (in global numbering)

    const pointField& cellCentres = mesh.cellCentres();
    const labelList& faceOwner = mesh.faceOwner();
    const labelList& faceNeighbour = mesh.faceNeighbour();
    const cellList& cells = mesh.cells();


    // 1. Determine global cell number on other side of coupled patches

    labelList globalCellIDs(identity(gi.localSize(), gi.localStart()));

    labelList nbrGlobalCellIDs;
    syncTools::swapBoundaryCellList
    (
        mesh,
        globalCellIDs,
        nbrGlobalCellIDs
    );
    pointField nbrCellCentres;
    syncTools::swapBoundaryCellList
    (
        mesh,
        cellCentres,
        nbrCellCentres
    );

    boolList nbrIsValidCell;
    syncTools::swapBoundaryCellList
    (
        mesh,
        isValidCell,
        nbrIsValidCell
    );


    // 2. Collect cell and all its neighbours

    cellCells.setSize(mesh.nCells());
    cellCellCentres.setSize(cellCells.size());

    forAll(selectedCells, i)
    {
        label celli = selectedCells[i];

        const cell& cFaces = cells[celli];
        labelList& stencil = cellCells[celli];
        pointList& stencilPoints = cellCellCentres[celli];
        stencil.setSize(cFaces.size()+1);
        stencilPoints.setSize(stencil.size());
        label compacti = 0;

        // First entry is cell itself
        if (isValidCell[celli])
        {
            stencil[compacti] = globalCellIDs[celli];
            stencilPoints[compacti++] = cellCentres[celli];
        }

        // Other entries are cell neighbours
        forAll(cFaces, i)
        {
            label facei = cFaces[i];
            label bFacei = facei-mesh.nInternalFaces();
            label own = faceOwner[facei];
            label nbrCelli;
            point nbrCc;
            bool isValid = false;
            if (bFacei >= 0)
            {
                nbrCelli = nbrGlobalCellIDs[bFacei];
                nbrCc = nbrCellCentres[bFacei];
                isValid = nbrIsValidCell[bFacei];
            }
            else
            {
                if (own != celli)
                {
                    nbrCelli = gi.toGlobal(own);
                    nbrCc = cellCentres[own];
                    isValid = isValidCell[own];
                }
                else
                {
                    label nei = faceNeighbour[facei];
                    nbrCelli = gi.toGlobal(nei);
                    nbrCc = cellCentres[nei];
                    isValid = isValidCell[nei];
                }
            }

            if (isValid)
            {
                SubList<label> current(stencil, compacti);
                if (!current.found(nbrCelli))
                {
                    stencil[compacti] = nbrCelli;
                    stencilPoints[compacti++] = nbrCc;
                }
            }
        }
        stencil.setSize(compacti);
        stencilPoints.setSize(compacti);
    }
}


// ************************************************************************* //
