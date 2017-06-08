/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/
_baseUniforms = [];
#include "baseUniforms.sqf"
_veh = (configfile >> "CfgWeapons") call BIS_fnc_getCfgSubClasses;
_veh sort true;
systemChat format[" _veh contains %1 entries",count _veh];
_cars = [];
_clipboard = "";
{
	_isKindOf = _x isKindOF ["Uniform_Base", configFile >> "CfgWeapons"];
	if (_isKindOf and !(_x in _baseUniforms)) then
	{
		_cars pushback _x;
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 50; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 50; };%2",_x,endl];
		};
	};
}forEach _veh;

copyToClipboard _clipboard;
systemChat "Uniforms Pricelist Generated";