
_vehiclesBase = [];
_baseClasses = [];
#include "ExcludedClassNames\baseVehicles.sqf"
_veh = (configfile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses;
_veh sort true;

_cars = [];
_tanks = [];
_boats = [];
_air = [];
_helis = [];
_planes = [];
_exile = 0;
 
{
	_process = true;
	if (GRG_Root isEqualTo "") then 
	{
		_process = true;
	} else {
		_leftSTR = [toLower _x,count GRG_Root] call KRON_StrLeft;
		_process = ((toLower GRG_Root) isEqualTo _leftSTR);
		systemChat format["vehicles.sqf:: _leftSTR = %1 and _process = %2",_leftSTR, _process];		
	};
	if ([toLower _x,"base"] call KRON_StrInStr || [toLower _x,"abstract"] call KRON_StrInStr) then
	{
		if !(_x in _baseClasses) then {_baseClasses pushBack _x};
		_process = false;
		_msg = format["base class %1 processed",_x];
		systemChat _msg;
		diag_log _msg;
	};
	if (_process && !(_x in _vehiclesBase)) then
	{
		if (_x isKindOf "Tank") then {_tanks pushBack _x;systemChat format["Adding Tank %1",_x];};
		if (_x isKindOf "Car") then {_cars pushBack _x};
		if ((_x isKindOf "Plane")) then {_planes pushBack _x};
		if ((_x isKindOf "Helicopter")) then {_helis pushBack _x};
		if (_x isKindOf "Ship") then {_boats pushback _x;};	
	};
}forEach _veh;

_clipBoard = "";
_allTurrets = [];
{
	private _vics = _x select 1;
	{
		private _turrets = getArray(configfile >> "CfgVehicles" >> _x >> "weapons");
		{
			if !(_x in _allTurrets) then {
				_allTurrets pushBack _x;
				systemChat format["Adding turret %1",_x];
			};
		}forEach _turrets;
	}forEach _vics;
}forEach[
["Cars",_cars],
["Tanks",_tanks],
["Boats",_boats],
["Helis",_helis],
["Planes",_planes],
["Other Air",_air]
];

{
	_clipboard = _clipboard + format["%1,%2",_x,endl];
}forEach _allTurrets;

copyToClipboard _clipboard;
systemChat "All Turrets Processed and results copied to clipboard";
hint format["Vehicles Config Extractor Run complete%1Output copied to clipboard%1Paste it into a text editor to acces",endl];