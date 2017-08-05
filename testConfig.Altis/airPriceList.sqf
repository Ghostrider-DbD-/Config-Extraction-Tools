/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/

_vehiclesBase = [];
#include "vehiclesBase.sqf"
_veh = (configfile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses;
_veh sort true;
_cars = [];
_clipboard = "";
{
	if (_x isKindOf "Air" && !(_x in _vehiclesBase)) then
	{
		_cars pushback _x;
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 15000; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 15000; };%2",_x,endl];
		};		
	};
}forEach _veh;

copyToClipboard _clipboard;
systemChat "Vehicles Pricelist Generated";