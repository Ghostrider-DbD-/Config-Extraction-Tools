/*
	some of the algorithm/script is based on a script by KiloSwiss
	https://epochmod.com/forum/topic/32239-howto-get-available-weapons-mod-independent/
	Modified and enhanced by GhostriderDbD
	5/22/17
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

_baseWearables = [];
#include "baseWearables.sqf"
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
//_wpnThrow = []; // throwables
//_wpnUnknown = []; //Misc

_wpList = (configfile >> "cfgGlasses") call BIS_fnc_getCfgSubClasses;
{
	if ( !(_x in _baseWearables) && !(_x in _addedBaseNames) ) then
	{	
		_addedBaseNames pushBack _x;
		_glasses pushBack _x;
	};
}forEach _wpList;

_aBaseNames = [];
_wpList = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
//_wpList sort true;
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
} foreach _wpList;

_clipBoard = format["%2%3// // Uniforms %1",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};		
}forEach _uniforms;

_clipBoard = _clipBoard + format["%2%3// Headgear / Masks %1",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};		
}forEach _headgear;

_clipBoard = _clipBoard + format["%2%3// Goggles %1",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};		
}forEach _goggles;

_clipBoard = _clipBoard + format["%2%3// Vests %1",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};		
}forEach _vests;

_clipBoard = _clipBoard + format["%2%3// Backpacks %1",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};		
}forEach _backpacks;

_clipBoard = _clipBoard + format["%2%3//Glasses %1",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};		
}forEach _glasses;

_clipBoard = _clipBoard + format["%2%3// NVG %1",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};		
}forEach _NVG;
/*
_clipBoard = _clipBoard + format["%2%3// Handguns %1",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};		
}forEach _wpnHandGun;

_clipBoard = _clipBoard + format["%2%3// Shotguns %1",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};		
}forEach _wpnShotGun;

_clipBoard = _clipBoard + format["%2%3// Throwables %1",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};		
}forEach _wpnThrow;

_clipBoard = _clipBoard + format["%2%3// Unknown %1",endl,endl,endl];
{
		if (DBD_priceConfiguration == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
		};
		if (DBD_priceConfiguration == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 150; };%2",_x,endl];
		};		
}forEach _wpnUnknown;
*/
copyToClipboard _clipBoard;

_clipBoard