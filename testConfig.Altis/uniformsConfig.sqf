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
//_veh sort true;
systemChat format[" _veh contains %1 entries",count _veh];
_index = 0;
_cars = [];
_exile = 0;
_clipboard = "";
{
	_isKindOf = _x isKindOF ["Uniform_Base", configFile >> "CfgWeapons"];
	if (_isKindOf and !(_x in _baseUniforms)) then
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

copyToClipboard _clipboard;
