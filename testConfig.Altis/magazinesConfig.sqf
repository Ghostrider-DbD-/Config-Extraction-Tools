/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/

_baseMagazines = [];
#include "baseMagazines.sqf"
_veh = (configfile >> "CfgMagazines") call BIS_fnc_getCfgSubClasses;
//_veh sort true;
systemChat format[" _veh contains %1 entries",count _veh];
_cars = [];
_clipboard = "";
_wpnSmokeShell = [];  //  "B_IR_Grenade"
_wpnLauncherRound = [];
_wpnMagazines = [];
_wpnVehicleAmmo = [];
_wpnMines = [];  //  "ATMine_Range_Mag"  "SatchelCharge_Remote_Mag" "DemoCharge_Remote_Mag" "IEDUrbanSmall_Remote_Mag"
_isMagazine = true;

_scannedMags = [];
{
	//diag_log format["Magazine = %1",_x];
	_isKindOf = (_x isKindOF ["CA_Magazine", configFile >> "CfgMagazines"]); 
	if (true) then
	{
		//diag_log format["Acceptable Magazine = %1",_x];
		if (_isKindOf and !(_x in _baseMagazines)) then
		{
			//diag_log format["Evaluated Magazine = %1",_x];
			//if (!(_x isKindOF ["CA_LauncherMagazine", configFile >> "CfgMagazines"]) && !(_x isKindOF ["HandGrenade", configFile >> "CfgMagazines"]) && !(_x isKindOf ["VehicleMagazine", configFile >> "CfgMagazines"]) && !(_x isKindOf ["Exile_AbstractItem", configFile >> "CfgMagazines"])) then {_wpnMagazines pushBack _x};
			if (_x isKindOF ["CA_LauncherMagazine", configFile >> "CfgMagazines"]) then {_wpnLauncherRound pushBack _x; _scannedMags pushBack _x;};
			if(_x isKindOF ["HandGrenade", configFile >> "CfgMagazines"]) then {_wpnSmokeShell pushBack _x; _scannedMags pushBack _x;};
			if (_x isKindOf ["VehicleMagazine", configFile >> "CfgMagazines"]) then {_wpnVehicleAmmo pushBack _x; _scannedMags pushBack _x;};
			if (_x isKindOf ["Exile_AbstractItem", configFile >> "CfgMagazines"]) then { _scannedMags pushBack _x;};  // Ignore these for now
			if !(_x in _scannedMags) then {_wpnMagazines pushBack _x; _scannedMags pushBack _x;};
		};
	};
}forEach _veh;
_clipBoard = _clipBoard + format["%1%2//  Magazines%3",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1",%2',_x,endl];
}forEach _wpnMagazines;
_clipBoard = _clipBoard + format["%1%2//  Grenades, Smoke Grenades, Chemlights and Flares%3",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1",%2',_x,endl];
}forEach _wpnSmokeShell;
_clipBoard = _clipBoard + format["%1%2//  Launcher Rounds%3",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1",%2',_x,endl];
}forEach _wpnLauncherRound;
_clipBoard = _clipBoard + format["%1%2//  Vehicle Ammo%3",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1",%2',_x,endl];
}forEach _wpnVehicleAmmo;

copyToClipboard _clipboard;
