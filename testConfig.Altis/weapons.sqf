/*
	Original script by KiloSwiss
	https://epochmod.com/forum/topic/32239-howto-get-available-weapons-mod-independent/
	Modified and enhanced by GhostriderDbD
	7/20/17
	
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
private["_process"];
_weaponsBase = [];
_knownWeapons = [];
#include "ExcludedClassNames\excludedWeapons.sqf"


_allWeaponRoots = ["Pistol","Rifle","Launcher"];
_allWeaponTypes = ["AssaultRifle","MachineGun","SniperRifle","Shotgun","Rifle","Pistol","SubmachineGun","Handgun","MissileLauncher","RocketLauncher","Throw","GrenadeCore"];
_addedBaseNames = [];
_allBannedWeapons = [];
_wpnAR = []; //Assault Rifles
_wpnARG = []; //Assault Rifles with GL
_wpnLMG = []; //Light Machine Guns
_wpnSMG = []; //Sub Machine Guns
_wpnDMR = []; //Designated Marksman Rifles
_wpnLauncher = [];
_wpnSniper = []; //Sniper rifles
_wpnHandGun = []; //HandGuns/Pistols
_wpnShotGun = []; //Shotguns
_wpnThrow = []; // throwables
_wpnUnknown = []; //Misc
_wpnUnderbarrel = [];
_wpnMagazines = [];
_wpnOptics = [];
_wpnPointers = [];
_wpnMuzzles = [];
_baseClasses = [];
processWeapon = false;
processAttachment = false;
_wpList = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
//_wpList sort true;
diag_log"//////////////////////////////////////////////////////////////";
diag_log" ///   START OF RUN //////////////////////////////////////////";

{
	_item = _x;
	_isWeap = false;
	_isWeapon = false;
	processWeapon = false;
	
	{
		_isWeapon = (_item isKindOF [_x, configFile >> "CfgWeapons"]);
		if (_isWeapon) exitWith {processWeapon = true};
	} forEach _allWeaponRoots;

	if (processWeapon && (count GRG_Root > 0)) then
	{
		_leftSTR = [toLower _x,count GRG_Root] call KRON_StrLeft;
		processWeapon = ((toLower GRG_Root) isEqualTo _leftSTR);
		_msg = format["weapons.sqf:: _leftSTR = %1 and processWeapon = %2",_leftSTR, processWeapon];
		//systemChat _msg;
		diag_log _msg;
	};
	if (processWeapon) then
	{
		if (GRG_addIttemsMissingFromPricelistOnly) then
		{
			if(GRG_mod isEqualTo "Exile") then
			{
				if (isNumber (missionConfigFile >> "CfgExileArsenal" >> _x >> "price")) then
				{
					diag_log format["price for item %1 = %2 tabs",_x,getNumber(missionConfigFile >> "CfgExileArsenal" >> _x >> "price")];
					processWeapon = false; // Item already listed and assumed to be included in both trader lists and price lists
					diag_log format["Item %1 already has a price: Not processing item %1",_x];
				} else {
					diag_log format["price for item %1 = %2 tabs",_x,getNumber(missionConfigFile >> "CfgExileArsenal" >> _x >> "price")];
					diag_log format["Item %1 has no price: processing item %1",_x];
					processWeapon = true;
				};
			};
			if (GRG_mod isEqualTo "Epoch") then
			{
				if (isNumber (missionConfigFile >> "CfgPricing" >> _x >> "price")) then
				{
					processWeapon = false; // Item already listed and assumed to be included in both trader lists and price lists
					
				} else {
					processWeapon = true;
				};
			};
		};	
	};
	if (processWeapon) then
	{
		if ([toLower _x,"base"] call KRON_StrInStr || [toLower _x,"abstract"] call KRON_StrInStr) then
		{
			if !(_x in _baseClasses) then {_baseClasses pushBack _x};
			processWeapon = false;
			systemChat format["base class %1 ignored",_x];
		};			
	};
	diag_log format["for item %1, price of %2, root of %3, processWeapon = %4",_x, getNumber(missionConfigFile >> "CfgExileArsenal" >> _x >> "price"),[toLower _x,count GRG_Root] call KRON_StrLeft,processWeapon];

	_fn_includeItem = {
		params["_item"];
		private _include = false;
		private _leftSTR = [toLower _item,count GRG_Root] call KRON_StrLeft;
		if (count GRG_Root > 0) then {_include = ((toLower GRG_Root) isEqualTo _leftSTR);};
		if (_include) then
		{
			if (GRG_addIttemsMissingFromPricelistOnly) then
			{
				if(GRG_mod isEqualTo "Exile") then
				{
					if (isNumber (missionConfigFile >> "CfgExileArsenal" >> _item >> "price")) then
					{
						diag_log format["price for item %1 = %2 tabs",_item,getNumber(missionConfigFile >> "CfgExileArsenal" >> _item >> "price")];
						_include = false; // Item already listed and assumed to be included in both trader lists and price lists
						diag_log format["Item %1 already has a price: Not processing item %1",_item];
					} else {
						diag_log format["price for item %1 = %2 tabs",_item,getNumber(missionConfigFile >> "CfgExileArsenal" >> _item >> "price")];
						diag_log format["Item %1 has no price: processing item %1",_item];
						_include = true;
					};
				};
				if (GRG_mod isEqualTo "Epoch") then
				{
					if (isNumber (missionConfigFile >> "CfgPricing" >> _item >> "price")) then
					{
						_include = false; // Item already listed and assumed to be included in both trader lists and price lists
						
					} else {
						_include = true;
					};
				};
			};		
		};
		_include
	};

	if (processWeapon) then 
	{
		//_msg = format["weapons classname extractor:  _item = %1",_item];
		//diag_log _msg;
		//systemChat _msg;
		if !(_item in _excludedWeapons) then
		{
			_excludedWeapons pushBack _item;
			_itemType = _x call bis_fnc_itemType;
			_itemCategory = _itemType select 1;
			//diag_log format["pullWepClassNames::  _itemType = %1 || _itemCategory = %2",_itemType, _itemCategory];
			if (((_itemType select 0) == "Weapon") && ((_itemType select 1) in _allWeaponTypes)) then 
			{
				_baseName = _x call BIS_fnc_baseWeapon;
				systemChat format["pullWepClassNames:: Processing for _baseName %3 || _itemType = %1 || _itemCategory = %2",_itemType, _itemCategory, _baseName];
				if (!(_baseName in _addedBaseNames) && !(_baseName in _allBannedWeapons)) then 
				{
					_addedBaseNames pushBack _baseName;
					
					switch(_itemCategory)do{
					case "AssaultRifle" :{
						if(count getArray(configfile >> "cfgWeapons" >> _baseName >> "muzzles") > 1)then[{_wpnARG pushBack _baseName},{_wpnAR pushBack _baseName}];
					};
					case "MachineGun" :{_wpnLMG pushBack _baseName};
					case "SubmachineGun" :{_wpnSMG pushBack _baseName};
					case "Rifle" :{_wpnDMR pushBack _baseName};
					case "SniperRifle" :{_wpnSniper pushBack _baseName};
					case "Shotgun" :{_wpnShotGun pushBack _baseName};
					case "Handgun" :{_wpnHandGun pushBack _baseName};
					case "MissileLauncher" :{_wpnLauncher pushBack _baseName};
					case "RocketLauncher" :{_wpnLauncher pushBack _baseName};
					case "DMR" : {_wpnDMR pushBack _baseName};
					case "Throw" : {_wpnThrow pushBack _baseName};
					default{_wpnUnknown pushBack _baseName};
					};
	
					//  Get options for magazines and attachments for that weapon and store these if they are not duplicates for items already listed.
					_ammoChoices = getArray (configFile >> "CfgWeapons" >> _baseName >> "magazines");
					{
						if ([_x] call _fn_includeItem && !(_x in _wpnMagazines)) then {_wpnMagazines pushback _x};
					}forEach _ammoChoices;
					_optics = getArray (configfile >> "CfgWeapons" >> _baseName >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
					{
						if ([_x] call _fn_includeItem && !(_x in _wpnOptics)) then {_wpnOptics pushback _x};
					}forEach _optics;
					_pointers = getArray (configFile >> "CfgWeapons" >> _baseName >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
					{
						if ([_x] call _fn_includeItem && !(_x in _wpnPointers)) then {_wpnPointers pushback _x};
					}forEach _pointers;
					_muzzles = getArray (configFile >> "CfgWeapons" >> _baseName >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
					{
						if ([_x] call _fn_includeItem && !(_x in _wpnMuzzles)) then {_wpnMuzzles pushback _x};
					}forEach _muzzles;
					_underbarrel = getArray (configFile >> "CfgWeapons" >> _baseName >> "WeaponSlotsInfo" >> "UnderBarrelSlot" >> "compatibleItems");
					{
						if ([_x] call _fn_includeItem && !(_x in _wpnUnderbarrel)) then {_wpnUnderbarrel pushback _x};
					}forEach _underbarrel;
				};
			};
		};
	};
} foreach _wpList;

_clipboard = "";

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipBoard + GRG_Exile_TraderItemLists_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipBoard + GRG_Epoch_ItemLists_Header;
};

{
	_clipboard = _clipboard + format["%2%2// %1 %2%2",_x select 0, endl];
	_temp = [_x select 1] call fn_generateItemList;
	_clipBoard = _clipBoard + _temp;
} foreach
[
	["Assault Rifles ",_wpnAR],
	["Assault Rifles with GL",_wpnARG],
	["LMGs",_wpnLMG],
	[" SMGs ",_wpnSMG],
	["Snipers ",_wpnSniper],
	["DMRs ",_wpnDMR],	
	["Launchers ",_wpnLauncher],	
	["Handguns ",_wpnHandGun],	
	["Shotguns ",_wpnShotGun],	
	["Throwables ",_wpnThrow],	
	["Magazines ",_wpnMagazines],	
	["Optics ",_wpnOptics],	
	["Muzzles ",_wpnMuzzles],	
	["Pointers ",_wpnPointers],	
	["Underbarrel ",_wpnUnderbarrel],	
	["Unknown ",_wpnUnknown]
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
	["Assault Rifles ",_wpnAR],
	["Assault Rifles with GL",_wpnARG],
	["LMGs",_wpnLMG],
	[" SMGs ",_wpnSMG],
	["Snipers ",_wpnSniper],
	["DMRs ",_wpnDMR],	
	["Launchers ",_wpnLauncher],	
	["Handguns ",_wpnHandGun],	
	["Shotguns ",_wpnShotGun],	
	["Throwables ",_wpnThrow],	
	["Magazines ",_wpnMagazines],	
	["Optics ",_wpnOptics],	
	["Muzzles ",_wpnMuzzles],	
	["Pointers ",_wpnPointers],	
	["Underbarrel ",_wpnUnderbarrel],	
	["Unknown ",_wpnUnknown]
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
	["Assault Rifles ",_wpnAR],
	["Assault Rifles with GL",_wpnARG],
	["LMGs",_wpnLMG],
	[" SMGs ",_wpnSMG],
	["Snipers ",_wpnSniper],
	["DMRs ",_wpnDMR],	
	["Launchers ",_wpnLauncher],	
	["Handguns ",_wpnHandGun],	
	["Shotguns ",_wpnShotGun],	
	["Throwables ",_wpnThrow],	
	["Magazines ",_wpnMagazines],	
	["Optics ",_wpnOptics],	
	["Muzzles ",_wpnMuzzles],	
	["Pointers ",_wpnPointers],	
	["Underbarrel ",_wpnUnderbarrel],	
	["Unknown ",_wpnUnknown]
];
copyToClipboard _clipBoard;
systemChat "All Weapons Processws and results copied to clipboard";
hint format["Weapons Config Extractor Run complete%1Output copied to clipboard%1Paste it into a text editor to acces",endl];