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
_process = false;
_wpList = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
//_wpList sort true;
{
	_item = _x;
	_isWeap = false;
	_isWeapon = false;
	_process = false;
	{
		_isWeapon = (_item isKindOF [_x, configFile >> "CfgWeapons"]);
		if (_isWeapon) exitWith {};
	} forEach _allWeaponRoots;
	
	if (_isWeapon && GRG_Root isEqualTo "") then 
	{
		_process = true;
	};
	if (_isWeapon && (count GRG_Root > 0)) then
	{
		_leftSTR = [toLower _x,count GRG_Root] call KRON_StrLeft;
		_process = ((toLower GRG_Root) isEqualTo _leftSTR);
		//_msg = format["weaponss.sqf:: _leftSTR = %1 and _process = %2",_leftSTR, _process];
		//systemChat _msg;
		//diag_log _msg;
	};
	
	if (_isWeapon  && _process) then
	{
		if ([toLower _x,"base"] call KRON_StrInStr || [toLower _x,"abstract"] call KRON_StrInStr) then
		{
			if !(_x in _baseClasses) then {_baseClasses pushBack _x};
			_process = false;
			systemChat format["base class %1 ignored",_x];
		};			
	};
	
	if (_isWeapon && _process) then 
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