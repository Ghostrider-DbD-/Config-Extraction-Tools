/*
	Original script by KiloSwiss
	https://epochmod.com/forum/topic/32239-howto-get-available-weapons-mod-independent/
	Modified and enhanced by GhostriderDbD
	7/20/17
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/
_weaponsBase = [];
_knownWeapons = [];
#include "ExcludedClassNames\baseWeapons.sqf"


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

_aBaseNames = [];
_wpList = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
//_wpList sort true;
{
	_item = _x;
	_isWeap = false;
	_isKindOf = false;
	{
		_isKindOf = (_item isKindOF [_x, configFile >> "CfgWeapons"]);
		if (_isKindOf) exitWith {};
	} forEach _allWeaponRoots;
	if (_isKindOf) then
	{
		//if (getnumber (configFile >> "cfgWeapons" >> _x >> "scope") == 2) then {
			_itemType = _x call bis_fnc_itemType;
			_itemCategory = _itemType select 1;
			//diag_log format["pullWepClassNames::  _itemType = %1 || _itemCategory = %2",_itemType, _itemCategory];
			if (((_itemType select 0) == "Weapon") && ((_itemType select 1) in _allWeaponTypes)) then {
				_baseName = _x call BIS_fnc_baseWeapon;
				//diag_log format["pullWepClassNames:: Processing for _baseName %3 || _itemType = %1 || _itemCategory = %2",_itemType, _itemCategory, _baseName];
				if (!(_baseName in _addedBaseNames) && !(_baseName in _allBannedWeapons)) then {
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
						if !(_x in _wpnMagazines) then {_wpnMagazines pushback _x};
					}forEach _ammoChoices;
					_optics = getArray (configfile >> "CfgWeapons" >> _baseName >> "WeaponSlotsInfo" >> "CowsSlot" >> "compatibleItems");
					{
						if !(_x in _wpnOptics) then {_wpnOptics pushback _x};
					}forEach _optics;
					_pointers = getArray (configFile >> "CfgWeapons" >> _baseName >> "WeaponSlotsInfo" >> "PointerSlot" >> "compatibleItems");
					{
						if !(_x in _wpnPointers) then {_wpnPointers pushback _x};
					}forEach _pointers;
					_muzzles = getArray (configFile >> "CfgWeapons" >> _baseName >> "WeaponSlotsInfo" >> "MuzzleSlot" >> "compatibleItems");
					{
						if !(_x in _wpnMuzzles) then {_wpnMuzzles pushback _x};
					}forEach _muzzles;
					_underbarrel = getArray (configFile >> "CfgWeapons" >> _baseName >> "WeaponSlotsInfo" >> "UnderBarrelSlot" >> "compatibleItems");
					{
						if !(_x in _wpnUnderbarrel) then {_wpnUnderbarrel pushback _x};
					}forEach _underbarrel;
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

_clipboard = _clipboard + format["%2%3// // Assault Rifles %1",endl,endl,endl];
_temp = [_wpnAR] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Assault Rifles with GL %1",endl,endl,endl];
_temp = [_wpnARG] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// LMGs %1",endl,endl,endl];
_temp = [_wpnLMG] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// SMGs %1",endl,endl,endl];
_temp = [_wpnSMG] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Snipers %1",endl,endl,endl];
_temp = [_wpnSniper] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// DMRs %1",endl,endl,endl];
_temp = [_wpnDMR] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Launchers %1",endl,endl,endl];
_temp = [_wpnLauncher] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Handguns %1",endl,endl,endl];
_temp = [_wpnHandGun] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Shotguns %1",endl,endl,endl];
_temp = [_wpnShotGun] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Throwables %1",endl,endl,endl];
_temp = [_wpnThrow] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Unknown %1",endl,endl,endl];
_temp = [_wpnUnknown] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Magazines %1",endl,endl,endl];
_temp = [_wpnMagazines] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Optics %1",endl,endl,endl];
_temp = [_wpnOptics] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Muzzles %1",endl,endl,endl];
_temp = [_wpnMuzzles] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Pointers %1",endl,endl,endl];
_temp = [_wpnPointers] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Underbarrel %1",endl,endl,endl];
_temp = [_wpnUnderbarrel] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipBoard + GRG_Exile_Pricelist_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipBoard + GRG_Epoch_Pricelist_Header;
};

_clipboard = _clipboard + format["%2%3// // Assault Rifles %1",endl,endl,endl];
_temp = [_wpnAR] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Assault Rifles with GL %1",endl,endl,endl];
_temp = [_wpnARG] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// LMGs %1",endl,endl,endl];
_temp = [_wpnLMG] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// SMGs %1",endl,endl,endl];
_temp = [_wpnSMG] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Snipers %1",endl,endl,endl];
_temp = [_wpnSniper] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// DMRs %1",endl,endl,endl];
_temp = [_wpnDMR] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Launchers %1",endl,endl,endl];
_temp = [_wpnLauncher] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Handguns %1",endl,endl,endl];
_temp = [_wpnHandGun] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Shotguns %1",endl,endl,endl];
_temp = [_wpnShotGun] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Throwables %1",endl,endl,endl];
_temp = [_wpnThrow] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Unknown %1",endl,endl,endl];
_temp = [_wpnUnknown] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Magazines %1",endl,endl,endl];
_temp = [_wpnMagazines] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Optics %1",endl,endl,endl];
_temp = [_wpnOptics] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Muzzles %1",endl,endl,endl];
_temp = [_wpnMuzzles] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Pointers %1",endl,endl,endl];
_temp = [_wpnPointers] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Underbarrel %1",endl,endl,endl];
_temp = [_wpnUnderbarrel] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;


if (GRG_mod == "Exile") then 
{
	_clipboard = _clipBoard + GRG_Exile_Loottable_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipBoard + GRG_Epoch_Loottable_Header;
};

_clipboard = _clipboard + format["%2%3// // Assault Rifles %1",endl,endl,endl];
_temp = [_wpnAR] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Assault Rifles with GL %1",endl,endl,endl];
_temp = [_wpnARG] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// LMGs %1",endl,endl,endl];
_temp = [_wpnLMG] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// SMGs %1",endl,endl,endl];
_temp = [_wpnSMG] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Snipers %1",endl,endl,endl];
_temp = [_wpnSniper] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// DMRs %1",endl,endl,endl];
_temp = [_wpnDMR] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Launchers %1",endl,endl,endl];
_temp = [_wpnLauncher] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Handguns %1",endl,endl,endl];
_temp = [_wpnHandGun] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Shotguns %1",endl,endl,endl];
_temp = [_wpnShotGun] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Throwables %1",endl,endl,endl];
_temp = [_wpnThrow] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Unknown %1",endl,endl,endl];
_temp = [_wpnUnknown] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Magazines %1",endl,endl,endl];
_temp = [_wpnMagazines] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Optics %1",endl,endl,endl];
_temp = [_wpnOptics] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Muzzles %1",endl,endl,endl];
_temp = [_wpnMuzzles] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Pointers %1",endl,endl,endl];
_temp = [_wpnPointers] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

_clipboard = _clipboard + format["%2%3// Underbarrel %1",endl,endl,endl];
_temp = [_wpnUnderbarrel] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

copyToClipboard _clipBoard;

hint format["Weapons Config Extractor Run complete%1Output copied to clipboard%1Paste it into a text editor to acces",endl];