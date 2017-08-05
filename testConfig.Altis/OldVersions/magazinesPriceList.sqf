/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	7/20/17
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/

_baseMagazines = [];
#include "baseMagazines.sqf"
_veh = (configfile >> "CfgMagazines") call BIS_fnc_getCfgSubClasses;
_veh sort true;
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
	_isKindOf = (_x isKindOF ["CA_Magazine", configFile >> "CfgMagazines"]); 
	if (true) then
	{
		if (_isKindOf and !(_x in _baseMagazines)) then
		{
			if (_x isKindOF ["CA_LauncherMagazine", configFile >> "CfgMagazines"]) then {_wpnLauncherRound pushBack _x; _scannedMags pushBack _x;};
			if(_x isKindOF ["HandGrenade", configFile >> "CfgMagazines"]) then {_wpnSmokeShell pushBack _x; _scannedMags pushBack _x;};
			if (_x isKindOf ["VehicleMagazine", configFile >> "CfgMagazines"]) then {_wpnVehicleAmmo pushBack _x; _scannedMags pushBack _x;};
			if (_x isKindOf ["Exile_AbstractItem", configFile >> "CfgMagazines"]) then { _scannedMags pushBack _x;};  // Ignore these for now
			if !(_x in _scannedMags) then {_wpnMagazines pushBack _x; _scannedMags pushBack _x;};
		};
	};
}forEach _veh;

_clipBoard = _clipBoard + format["%1%2//  Grenades, Smoke Grenades, Chemlights and Flares%3",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 15; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 15; };%2",_x,endl];
		};	
}forEach _wpnSmokeShell;
_clipBoard = _clipBoard + format["%1%2//  Launcher Rounds%3",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 15; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 15; };%2",_x,endl];
		};	
}forEach _wpnLauncherRound;
_clipBoard = _clipBoard + format["%1%2//  Vehicle Ammo%3",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};	
}forEach _wpnVehicleAmmo;

_clipBoard = _clipBoard + format["%1%2//  Magazines%3",endl,endl,endl];
_clipBoard = _clipBoard + format["%1%2//  Includes Weapon Magazines and anything not captured above%3",endl,endl,endl];
_clipBoard = _clipBoard + format["%1%2//  Check for duplicates if you also run the extraction tool for weapons%3",endl,endl,endl];
_clipBoard = _clipBoard + format["%1%2//  Which extracts all magazines available for player weapons%3",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 15; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 15; };%2",_x,endl];
		};	
}forEach _wpnMagazines;

copyToClipboard _clipboard;
systemChat "Magazines Pricelist Generated";