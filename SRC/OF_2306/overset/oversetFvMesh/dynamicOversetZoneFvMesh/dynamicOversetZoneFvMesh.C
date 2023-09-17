/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | www.openfoam.com
     \\/     M anipulation  |
-------------------------------------------------------------------------------
    Copyright (C) 2022 OpenCFD Ltd.
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

#include "dynamicOversetZoneFvMesh.H"
#include "addToRunTimeSelectionTable.H"

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

namespace Foam
{
    defineTypeNameAndDebug(dynamicOversetZoneFvMesh, 0);
    addToRunTimeSelectionTable(dynamicFvMesh, dynamicOversetZoneFvMesh, IOobject);
}


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::dynamicOversetZoneFvMesh::dynamicOversetZoneFvMesh
(
    const IOobject& io,
    const bool doInit
)
:
    dynamicMultiMotionSolverFvMesh(io, doInit),
    oversetFvMeshBase(static_cast<const fvMesh&>(*this))
{}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::dynamicOversetZoneFvMesh::~dynamicOversetZoneFvMesh()
{}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

bool Foam::dynamicOversetZoneFvMesh::update()
{
    if (!dynamicMultiMotionSolverFvMesh::update())
    {
        return false;
    }

    oversetFvMeshBase::update();

    return true;
}


bool Foam::dynamicOversetZoneFvMesh::writeObject
(
    IOstreamOption streamOpt,
    const bool valid
) const
{
    bool ok = dynamicMultiMotionSolverFvMesh::writeObject(streamOpt, valid);
    ok = oversetFvMeshBase::writeObject(streamOpt, valid) && ok;
    return ok;
}


// ************************************************************************* //
