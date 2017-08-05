/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	7/20/17
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/

_baseMagazines = [];
//#include "ExcludedClassNames\baseMagazines.sqf"
_cfgMagazines = (configfile >> "CfgMagazines") call BIS_fnc_getCfgSubClasses;
//_cfgMagazines sort true;
_sortedMagazines = [];
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
}forEach _cfgMagazines;


if (GRG_mod == "Exile") then 
{
	_clipboard = _clipboard + GRG_Exile_TraderItemLists_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipboard + GRG_Epoch_ItemLists_Header;
};

_clipboard = _clipboard + format["%1%2//  Grenades, Smoke Grenades, Chemlights and Flares%3",endl,endl,endl];
_temp = [_wpnSmokeShell] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1%2//  Launcher Rounds%3",endl,endl,endl];
_temp = [_wpnLauncherRound] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1%2//  Vehicle Ammo%3",endl,endl,endl];
_temp = [_wpnVehicleAmmo] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipBoard + GRG_Exile_Pricelist_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipBoard + GRG_Epoch_Pricelist_Header;
};
_clipboard = _clipboard + format["%1%2//  Grenades, Smoke Grenades, Chemlights and Flares%3",endl,endl,endl];
_temp = [_wpnSmokeShell] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1%2//  Launcher Rounds%3",endl,endl,endl];
_temp = [_wpnLauncherRound] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1%2//  Vehicle Ammo%3",endl,endl,endl];
_temp = [_wpnVehicleAmmo] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipBoard + GRG_Exile_Loottable_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipBoard + GRG_Epoch_Loottable_Header;
};
_clipboard = _clipboard + format["%1%2//  Grenades, Smoke Grenades, Chemlights and Flares%3",endl,endl,endl];
_temp = [_wpnSmokeShell] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1%2//  Launcher Rounds%3",endl,endl,endl];
_temp = [_wpnLauncherRound] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1%2//  Vehicle Ammo%3",endl,endl,endl];
_temp = [_wpnVehicleAmmo] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

copyToClipboard _clipboard;

hint format["Special Magazines Config Extractor Run complete%1Output copied to clipboard%1Paste it into a text editor to acces",endl];