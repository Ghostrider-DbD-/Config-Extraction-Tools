/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/

_baseVests = [];
#include "baseVests.sqf"
//systemChat format["%1%2 end",_baseUniforms,endl];
//uiSleep 5;
_veh = (configfile >> "CfgWeapons") call BIS_fnc_getCfgSubClasses;
_veh sort true;
systemChat format[" _veh contains %1 entries",count _veh];
_index = 0;
_cars = [];
_exile = 0;
_clipboard = "";
{
	_isKindOf = (_x isKindOF ["Vest_Camo_Base", configFile >> "CfgWeapons"]) or (_x isKindOF ["Vest_NoCamo_Base", configFile >> "CfgWeapons"]);
	if (_isKindOf and !(_x in _baseVests)) then
	{
		_cars pushback _x;
		diag_log format["%1",_x];
		_index = _index + 1;
		_left = [_x,5] call KRON_StrLeft;
		if (_left in ["Exile"]) then {
			_exile = _exile + 1; 
			systemChat format["%1",_x];
			
		};
		_clipboard = _clipboard + format['"%1",%2',_x,endl];
	};
}forEach _veh;
systemChat format["number of type of Vests = %1", _index];
systemChat format["number of Exile Vests = %1",_exile];

copyToClipboard _clipboard;
