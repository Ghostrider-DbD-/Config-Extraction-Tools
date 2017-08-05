_airBase = [];
#include "airBase.sqf"
_veh = (configfile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses;
_veh sort true;
systemChat format[" _veh contains %1 entries",count _veh];
_index = 0;
_aircraft = [];

_clipboard = "";
{
	if ( (_x isKindOf "Air") && !(_x in _airBase) ) then
	{
		//_air pushback _x;
		_clipboard = _clipboard + format['"%1",%2',_x,endl];
	};
}forEach _veh;

copyToClipboard _clipboard;
