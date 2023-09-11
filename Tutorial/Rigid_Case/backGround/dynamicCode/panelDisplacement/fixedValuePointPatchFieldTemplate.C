/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     |
    \\  /    A nd           | www.openfoam.com
     \\/     M anipulation  |
-------------------------------------------------------------------------------
    Copyright (C) 2019-2021 OpenCFD Ltd.
    Copyright (C) YEAR AUTHOR, AFFILIATION
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

\*---------------------------------------------------------------------------*/

#include "fixedValuePointPatchFieldTemplate.H"
#include "addToRunTimeSelectionTable.H"
#include "pointPatchFieldMapper.H"
#include "pointFields.H"
#include "unitConversion.H"
#include "PatchFunction1.H"

//{{{ begin codeInclude
#line 22 "/home/grads/a/ahamada/LE_Case/backGround/system/codeDict.panelDisplacement"
#include <cmath>
//}}} end codeInclude


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * Local Functions * * * * * * * * * * * * * * //

//{{{ begin localCode

//}}} end localCode


// * * * * * * * * * * * * * * * Global Functions  * * * * * * * * * * * * * //

// dynamicCode:
// SHA1 = 4ce82851b83a54fd2a1bc9bacd7940b4dc2d6618
//
// unique function name that can be checked if the correct library version
// has been loaded
extern "C" void panelDisplacement_4ce82851b83a54fd2a1bc9bacd7940b4dc2d6618(bool load)
{
    if (load)
    {
        // Code that can be explicitly executed after loading
    }
    else
    {
        // Code that can be explicitly executed before unloading
    }
}

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

makePointPatchTypeField
(
    pointPatchVectorField,
    panelDisplacementFixedValuePointPatchVectorField
);

} // End namespace Foam


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

Foam::
panelDisplacementFixedValuePointPatchVectorField::
panelDisplacementFixedValuePointPatchVectorField
(
    const pointPatch& p,
    const DimensionedField<vector, pointMesh>& iF
)
:
    parent_bctype(p, iF)
{
    if (false)
    {
        printMessage("Construct panelDisplacement : patch/DimensionedField");
    }
}


Foam::
panelDisplacementFixedValuePointPatchVectorField::
panelDisplacementFixedValuePointPatchVectorField
(
    const panelDisplacementFixedValuePointPatchVectorField& rhs,
    const pointPatch& p,
    const DimensionedField<vector, pointMesh>& iF,
    const pointPatchFieldMapper& mapper
)
:
    parent_bctype(rhs, p, iF, mapper)
{
    if (false)
    {
        printMessage("Construct panelDisplacement : patch/DimensionedField/mapper");
    }
}


Foam::
panelDisplacementFixedValuePointPatchVectorField::
panelDisplacementFixedValuePointPatchVectorField
(
    const pointPatch& p,
    const DimensionedField<vector, pointMesh>& iF,
    const dictionary& dict,
    const bool valueRequired
)
:
    parent_bctype(p, iF, dict, valueRequired)
{
    if (false)
    {
        printMessage("Construct panelDisplacement : patch/dictionary");
    }
}


Foam::
panelDisplacementFixedValuePointPatchVectorField::
panelDisplacementFixedValuePointPatchVectorField
(
    const panelDisplacementFixedValuePointPatchVectorField& rhs
)
:
    parent_bctype(rhs),
    dictionaryContent(rhs)
{
    if (false)
    {
        printMessage("Copy construct panelDisplacement");
    }
}


Foam::
panelDisplacementFixedValuePointPatchVectorField::
panelDisplacementFixedValuePointPatchVectorField
(
    const panelDisplacementFixedValuePointPatchVectorField& rhs,
    const DimensionedField<vector, pointMesh>& iF
)
:
    parent_bctype(rhs, iF)
{
    if (false)
    {
        printMessage("Construct panelDisplacement : copy/DimensionedField");
    }
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

Foam::
panelDisplacementFixedValuePointPatchVectorField::
~panelDisplacementFixedValuePointPatchVectorField()
{
    if (false)
    {
        printMessage("Destroy panelDisplacement");
    }
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void
Foam::
panelDisplacementFixedValuePointPatchVectorField::updateCoeffs()
{
    if (this->updated())
    {
        return;
    }

    if (false)
    {
        printMessage("updateCoeffs panelDisplacement");
    }

//{{{ begin code
    #line 26 "/home/grads/a/ahamada/LE_Case/backGround/system/codeDict.panelDisplacement"
double x = 0.0;
     double y = 0.0;
     double xr = 0.0;
     double yr = 0.0;
     
     const double lc = 1.0/3.0; // pivot location 
     double c = 1.0;  // chord length 
     double alpf = 15.0; // local AoA at the leading edge in body-fixed coordinate system (deg)
     double Db = 0.0 ;  // foil displacement at trailing edge (m)
     const scalar n_le = 3.0; // flexibility coefficient at LE 
     const scalar n_te = 2.0; // flexibility coefficient at LE 
     double Pi=3.141593;
     double H=0.0; // heave amplitude 
     double theta0=0; // 
     double theta=0; 
     double t = 0.0; 
     //Oscillation frequency
     double fr = 0.0; //rotation frequency 
     double ft = 0.0; //translation frequency 
     double f = 0.3183098861837907; // 
     double xo=0.0;
     double yo=0.01;
     double Yo=0.0;
     double xd=0;
     double yd=0; 
  
     
	// Create output displacement field from patch points coordinates
	vectorField d(0.0*this->patch().localPoints()); 
	//Get the number of points
        const int N = this->patch().localPoints().size();
	//Get the index and name of the current patch
        const int Ind = this->patch().index();
        const word Name = this->patch().name();
	//Get the list of patch points indexes
	const labelList List = this->patch().meshPoints();
	//Get the complete displacement field at each point
	const pointVectorField& D = this->db().objectRegistry::lookupObject<pointVectorField>("pointDisplacement");

	//std::cout<<"*******  Patch#"<<Ind<<" : "<<Name<< " ( "<< N <<" : "<<List[0]<<" -> "<<List[N-1]<<")   ********"<<std::endl;
	
	//Info<<D<<endl;
  for(label I = 0; I < N; I++)
        {

            y = this->patch().localPoints()[I].y();
            x = this->patch().localPoints()[I].x(); 
	    d[I].z() = 0.0;
            //Yo=0+H*sin(this->db().time().value()*2*Pi*f);
         
            
        	 if (x<0){
		       // cout<<"x<0.3  "<<x<<"\n";
		    	d[I].y() =(Yo-lc*pow((x/lc), n_le)*sin(alpf*Pi/180))*sin(this->db().time().value()*2*Pi*f-Pi/2); 
		      
	             
         	         }
      		 else{  
      		      //  cout<<"x>0.3  "<<x<<"\n";
		       d[I].y() = (Yo+(c-lc)*pow(x/(c-lc), n_te)*Db)*sin(this->db().time().value()*2*Pi*f-Pi/2);
		       
		        
	             }  
         
	               
        }
	
	operator==(d);  
	
	
	
	for(label I = 0; I < N; I++)
        {

       	  y = this->patch().localPoints()[I].y();
         	  x = this->patch().localPoints()[I].x(); 
         	 
                
          	d[I].y() =d[I].y()+H*sin(this->db().time().value()*2*Pi*ft); 
          	 
          	
	}    
	operator==(d);  
	
	/*
	
       
       for(label I = 0; I < N; I++)
        {
	          d[I].z() = 0.0;
	          y = this->patch().localPoints()[I].y();
        	  x = this->patch().localPoints()[I].x(); 
       	
         	  theta=theta0*sin(this->db().time().value()*2*Pi*fr);
         	  yo=0.01+H*sin(this->db().time().value()*2*Pi*ft);
         	  xd=x-xo;     
         	  yd=y-yo;
          	  yr =(xd*sin(theta)+yd*cos(theta)); 
          	  xr=(xd*cos(theta)-yd*sin(theta)); 
          	  d[I].x()=d[I].x()+(x-(xr+xo));
          	  d[I].y()=d[I].y()+(y-(yr+yo));
          	  //cout<<"x"<<x<<"\n";
          	  cout<<"yd  "<<yd;
          	  cout<<"  y  "<<y;
          	  cout<<"  yo  "<<yo<<"\n";
          	 // cout<<"theta"<<theta<<"\n";    
	}    
	
	operator==(d); */
//}}} end code

    this->parent_bctype::updateCoeffs();
}


// ************************************************************************* //

