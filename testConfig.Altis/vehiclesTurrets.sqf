
_vehiclesBase = [];
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
	if !(_x in _vehiclesBase) then
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

hint format["Vehicles Config Extractor Run complete%1Output copied to clipboard%1Paste it into a text editor to acces",endl];