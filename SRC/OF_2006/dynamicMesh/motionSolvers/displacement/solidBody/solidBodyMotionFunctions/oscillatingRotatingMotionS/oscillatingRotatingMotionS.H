/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | www.openfoam.com
     \\/     M anipulation  |
-------------------------------------------------------------------------------
    Copyright (C) 2011-2016 OpenFOAM Foundation
    Copyright (C) 2020 OpenCFD Ltd.
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

Class
    Foam::solidBodyMotionFunctions::oscillatingRotatingMotionS

Description
    SolidBodyMotionFvMesh 6DoF motion function. Oscillating rotation shifted.

SourceFiles
    oscillatingRotatingMotionS.C

\*---------------------------------------------------------------------------*/

#ifndef oscillatingRotatingMotionS_H
#define oscillatingRotatingMotionS_H

#include "solidBodyMotionFunction.H"
#include "primitiveFields.H"
#include "point.H"

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{
namespace solidBodyMotionFunctions
{

/*---------------------------------------------------------------------------*\
                          Class oscillatingRotatingMotion Declaration
\*---------------------------------------------------------------------------*/

class oscillatingRotatingMotionS
:
    public solidBodyMotionFunction
{
    // Private Data

        //- Centre of gravity
        point origin_;

        //- Amplitude
        vector amplitude_;

        //- Radial velocity
        scalar omega_;

	//- Angle shift between two motions (degree)
	scalar epsilon_;

    // Private Member Functions

        //- No copy construct
        oscillatingRotatingMotionS(const oscillatingRotatingMotionS&) = delete;

        //- No copy assignment
        void operator=(const oscillatingRotatingMotionS&) = delete;


public:

    //- Runtime type information
    TypeName("oscillatingRotatingMotionS");


    // Constructors

        //- Construct from components
        oscillatingRotatingMotionS
        (
            const dictionary& SBMFCoeffs,
            const Time& runTime
        );

        //- Construct and return a clone
        virtual autoPtr<solidBodyMotionFunction> clone() const
        {
            return autoPtr<solidBodyMotionFunction>
            (
                new oscillatingRotatingMotionS
                (
                    SBMFCoeffs_,
                    time_
                )
            );
        }


    //- Destructor
    virtual ~oscillatingRotatingMotionS() = default;


    // Member Functions

        //- Return the solid-body motion transformation septernion
        virtual septernion transformation() const;

        //- Update properties from given dictionary
        virtual bool read(const dictionary& SBMFCoeffs);
};


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace solidBodyMotionFunctions
} // End namespace Foam

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

#endif

// ************************************************************************* //
