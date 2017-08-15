/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/

_baseHeadgear = [];
#include "baseHeadgear.sqf"
_veh = (configfile >> "CfgWeapons") call BIS_fnc_getCfgSubClasses;
_veh sort true;

_cars = [];

_clipboard = "";
{
	_isKindOf = (_x isKindOF ["HelmetBase", configFile >> "CfgWeapons"]) or (_x isKindOF ["H_HelmetB", configFile >> "CfgWeapons"]);
	if (_isKindOf and !(_x in _baseHeadgear)) then
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
systemChat format["number of type of Man = %1", _index];

copyToClipboard _clipboard;

systemChat "Headgear Pricelist Generated";