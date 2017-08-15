/*
	some of the algorithm/script is based on a script by KiloSwiss
	https://epochmod.com/forum/topic/32239-howto-get-available-weapons-mod-independent/
	Modified and enhanced by GhostriderDbD
	5/22/17
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

_baseWearables = [];
#include "ExcludedClassNames\baseWearables.sqf"
_allWearableRoots = ["Pistol","Rifle","Launcher"];
_allWearableTypes = ["AssaultRifle","MachineGun","SniperRifle","Shotgun","Rifle","Pistol","SubmachineGun","Handgun","MissileLauncher","RocketLauncher","Throw","GrenadeCore"];
_addedBaseNames = [];
_allBannedWearables = [];
_uniforms = [];
_headgear = []; 
_glasses = []; 
_masks = []; 
_backpacks = []; 
_vests = [];
_goggles = []; 
_binocs = []; 
_NVG = []; 

_wearablesList = (configfile >> "cfgGlasses") call BIS_fnc_getCfgSubClasses;
{
	if ( !(_x in _baseWearables) && !(_x in _addedBaseNames) ) then
	{	
		_addedBaseNames pushBack _x;
		_glasses pushBack _x;
	};
}forEach _wearablesList;

_aBaseNames = [];
_wearablesList = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
//_wearablesList sort true;
{
	if ( !(_x in _baseWearables) && !(_x in _addedBaseNames) ) then
	{
		_addedBaseNames pushBack _x;
		// Uniforms
		if (_x isKindOF ["Uniform_Base", configFile >> "CfgWeapons"]) then {_uniforms pushBack _x};
		// Headgear / Masks
		if ( (_x isKindOF ["HelmetBase", configFile >> "CfgWeapons"]) or (_x isKindOF ["H_HelmetB", configFile >> "CfgWeapons"]) ) then {_headgear pushBack _x};
		// Goggles
		if (_x isKindOF ["GoggleItem", configFile >> "CfgWeapons"]) then {_goggles pushBack _x};
		// NVG
		if (_x isKindOF ["NVGoggles", configFile >> "CfgWeapons"]) then {_NVG pushBack _x};
		// Masks
		
		// Vests
		if ( (_x isKindOF ["Vest_Camo_Base", configFile >> "CfgWeapons"]) or (_x isKindOF ["Vest_NoCamo_Base", configFile >> "CfgWeapons"]) ) then {_vests pushBack _x};
		// Backpacks	
		if (_x isKindOF ["Bag_Base", configFile >> "CfgVehicles"]) then {_backpacks pushBack _x};
	};
} foreach _wearablesList;

_clipBoard = "";

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipboard + GRG_Exile_TraderItemLists_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipboard + GRG_Epoch_ItemLists_Header;
};

_clipboard = _clipboard + format["%2%3// // Uniforms %1",endl,endl,endl];
_temp = [_uniforms] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%2%3// Headgear / Masks %1",endl,endl,endl];
_temp = [_headgear] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%2%3// Goggles %1",endl,endl,endl];
_temp = [_goggles] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;
_clipBoard = _clipBoard + format["%2%3// Vests %1",endl,endl,endl];
_temp = [_vests] call fn_generateItemList;
_clipBoard = _clipBoard + _temp; 
_clipBoard = _clipBoard + format["%2%3// Backpacks %1",endl,endl,endl];
_temp = [_backpacks] call fn_generateItemList;
_clipBoard = _clipBoard + _temp; 
_clipBoard = _clipBoard + format["%2%3//Glasses %1",endl,endl,endl];
_temp = [_glasses] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;
_clipBoard = _clipBoard + format["%2%3// NVG %1",endl,endl,endl];
_temp = [_NVG] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipBoard + GRG_Exile_Pricelist_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipBoard + GRG_Epoch_Pricelist_Header;
};

_clipboard = _clipboard + format["%2%3// // Uniforms %1",endl,endl,endl];
_temp = [_uniforms] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%2%3// Headgear / Masks %1",endl,endl,endl];
_temp = [_headgear] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%2%3// Goggles %1",endl,endl,endl];
_temp = [_goggles] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;
_clipBoard = _clipBoard + format["%2%3// Vests %1",endl,endl,endl];
_temp = [_vests] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp; 
_clipBoard = _clipBoard + format["%2%3// Backpacks %1",endl,endl,endl];
_temp = [_backpacks] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp; 
_clipBoard = _clipBoard + format["%2%3//Glasses %1",endl,endl,endl];
_temp = [_glasses] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;
_clipBoard = _clipBoard + format["%2%3// NVG %1",endl,endl,endl];
_temp = [_NVG] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipBoard + GRG_Exile_Loottable_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipBoard + GRG_Epoch_Loottable_Header;
};

_clipboard = _clipboard + format["%2%3// // Uniforms %1",endl,endl,endl];
_temp = [_uniforms] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%2%3// Headgear / Masks %1",endl,endl,endl];
_temp = [_headgear] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%2%3// Goggles %1",endl,endl,endl];
_temp = [_goggles] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;
_clipBoard = _clipBoard + format["%2%3// Vests %1",endl,endl,endl];
_temp = [_vests] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp; 
_clipBoard = _clipBoard + format["%2%3// Backpacks %1",endl,endl,endl];
_temp = [_backpacks] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp; 
_clipBoard = _clipBoard + format["%2%3//Glasses %1",endl,endl,endl];
_temp = [_glasses] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;
_clipBoard = _clipBoard + format["%2%3// NVG %1",endl,endl,endl];
_temp = [_NVG] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

copyToClipboard _clipBoard;

hint format["Wearables Config Extractor Run complete%1Output copied to clipboard%1Paste it into a text editor to acces",endl];