/*
	some of the algorithm/script is based on a script by KiloSwiss
	https://epochmod.com/forum/topic/32239-howto-get-available-weapons-mod-independent/
	Modified and enhanced by GhostriderDbD
	5/22/17
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
/*

	Description:
	Return item category and type. Recognized types are:

		Weapon / VehicleWeapon
			AssaultRifle
			BombLauncher
			Cannon
			GrenadeLauncher
			Handgun
			Launcher
			MachineGun
			Magazine
			MissileLauncher
			Mortar
			RocketLauncher
			Shotgun
			Throw
			Rifle
			SubmachineGun
			SniperRifle
		VehicleWeapon
			Horn
			CounterMeasuresLauncher
			LaserDesignator
		Item
			AccessoryMuzzle
			AccessoryPointer
			AccessorySights
                        AccessoryBipod
			Binocular
			Compass
			FirstAidKit
			GPS
			LaserDesignator
			Map
			Medikit
			MineDetector
			NVGoggles
			Radio
			Toolkit
			UAVTerminal
			VehicleWeapon
			Unknown
			UnknownEquipment
			UnknownWeapon
			Watch
		Equipment
			Glasses
			Headgear
			Vest
			Uniform
			Backpack
		Magazine
			Artillery
			Bullet
			CounterMeasures
			Flare
			Grenade
			Laser
			Missile
			Rocket
			Shell
			ShotgunShell
			SmokeShell
			UnknownMagazine
		Mine
			Mine
			MineBounding
			MineDirectional

	Parameter(s):
		0: STRING - item class

	Returns:
	ARRAY in format [category,type]
*/
_excludedWearables = [];
#include "ExcludedClassNames\excludedWearables.sqf"
_baseClasses = [];
_allBannedWearables = [];
_uniforms = [];
_headgear = []; 
_glasses = []; 
_masks = []; 
_backpacks = []; 
_vests = [];
_goggles = []; 
_NVG = []; 

_wearablesList = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
_temp = (configFile >> "cfgVehicles") call BIS_fnc_getCfgSubClasses;
_wearablesList = _wearablesList + _temp;
_temp = (configFile >> "CfgGlasses") call BIS_fnc_getCfgSubClasses;
_wearablesList = _wearablesList + _temp;
_wearablesList sort true;
{
	_itemType = _x call BIS_fnc_itemType;
	//diag_log format["for Item %1 its ItemType [0] is %2",_x,_itemType select 0];
	if (_itemType select 0 isEqualTo "Equipment") then
	{
		_process = true;
		if (GRG_Root isEqualTo "") then 
		{
			_process = true;
		} else {
			_leftSTR = [toLower _x,count GRG_Root] call KRON_StrLeft;
			_process = ((toLower GRG_Root) isEqualTo _leftSTR);
			//systemChat format["wearables.sqf:: _leftSTR = %1 and _process = %2",_leftSTR, _process];		
		};
		if ([toLower _x,"base"] call KRON_StrInStr || [toLower _x,"abstract"] call KRON_StrInStr) then
		{
			if !(_x in _baseClasses) then {_baseClasses pushBack _x};
			_process = false;
			_msg = format["base class %1 ignored",_x];
			systemChat _msg;
			//diag_log _msg;
		};	
		if ( !(_x in _excludedWearables) && _process) then
		{	
			_excludedWearables pushBack _x;

				systemChat format["classname = %1, _itemType = %2",_x, _itemType select 1];		
				// Uniforms
				if (_itemType select 1 isEqualTo "Uniform") then {_uniforms pushBack _x};
				// Headgear / Masks
				//if ( (_x isKindOF ["HelmetBase", configFile >> "CfgWeapons"]) or (_x isKindOF ["H_HelmetB", configFile >> "CfgWeapons"]) ) then {_headgear pushBack _x};
				if (_itemType select 1 isEqualTo "Headgear") then {_headgear pushBack _x};				
				
				//if (_x isKindOF ["GoggleItem", configFile >> "CfgWeapons"]) then {_goggles pushBack _x};
				if (_itemType select 1 isEqualTo "Glasses") then {_glasses pushBack _x};
				// Vests
				//if ( (_x isKindOF ["Vest_Camo_Base", configFile >> "CfgWeapons"]) or (_x isKindOF ["Vest_NoCamo_Base", configFile >> "CfgWeapons"]) ) then {_vests pushBack _x};
				if (_itemType select 1 isEqualTo "Vest") then {_vests pushBack _x};
				// Backpacks	
				//if (_x isKindOF ["Bag_Base", configFile >> "CfgVehicles"]) then {_backpacks pushBack _x};
				if (_itemType select 1 isEqualTo "Backpack") then {_backpacks pushBack _x};
		};
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
{
	_clipboard = _clipboard + format["%2%2// %1 %2%2",_x select 0, endl];
	_temp = [_x select 1] call fn_generateItemList;
	_clipBoard = _clipBoard + _temp;
} foreach
[
	["Uniforms",_uniforms],
	["Headgear",_headgear],
	["Vests",_vests],
	["Backpacks",_backpacks],
	["Glasses",_glasses]
];

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipBoard + GRG_Exile_Pricelist_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipBoard + GRG_Epoch_Pricelist_Header;
};

{
	_clipboard = _clipboard + format["%2%2// %1 %2%2",_x select 0, endl];
	_temp = [_x select 1] call fn_generatePriceList;
	_clipBoard = _clipBoard + _temp;
} foreach
[
	["Uniforms",_uniforms],
	["Headgear",_headgear],
	["Vests",_vests],
	["Backpacks",_backpacks],
	["Glasses",_glasses]
];

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipBoard + GRG_Exile_Loottable_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipBoard + GRG_Epoch_Loottable_Header;
};
{
	_clipboard = _clipboard + format["%2%2// %1 %2%2",_x select 0, endl];
	_temp = [_x select 1] call fn_generateLootTableEntries;
	_clipBoard = _clipBoard + _temp;
} foreach
[
	["Uniforms",_uniforms],
	["Headgear",_headgear],
	["Vests",_vests],
	["Backpacks",_backpacks],
	["Glasses",_glasses]
];
copyToClipboard _clipBoard;
systemChat "All wearables Processed and results copied to clipboard";
hint format["Wearables Config Extractor Run complete%1Output copied to clipboard%1Paste it into a text editor to acces",endl];