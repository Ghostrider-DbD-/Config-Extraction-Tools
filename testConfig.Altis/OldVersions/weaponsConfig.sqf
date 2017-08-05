/*
	Original script by KiloSwiss
	https://epochmod.com/forum/topic/32239-howto-get-available-weapons-mod-independent/
	Modified and enhanced by GhostriderDbD
	7/20/17
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/	
*/

_knownWeapons = [];

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

_wpnMagazines = [];
_wpnOptics = [];
_wpnPointers = [];
_wpnMuzzles = [];

_aBaseNames = [];
_wpList = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
_wpList sort true;
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
			diag_log format["pullWepClassNames::  _itemType = %1 || _itemCategory = %2",_itemType, _itemCategory];
			if (((_itemType select 0) == "Weapon") && ((_itemType select 1) in _allWeaponTypes)) then {
				_baseName = _x call BIS_fnc_baseWeapon;
				diag_log format["pullWepClassNames:: Processing for _baseName %3 || _itemType = %1 || _itemCategory = %2",_itemType, _itemCategory, _baseName];
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

_clipBoard = format["%2%3// // Assault Rifles %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl];
}forEach _wpnAR;

_clipBoard = _clipBoard + format["%2%3// Assault Rifles with GL %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnARG;

_clipBoard = _clipBoard + format["%2%3// LMGs %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnLMG;

_clipBoard = _clipBoard + format["%2%3// SMGs %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnSMG;

_clipBoard = _clipBoard + format["%2%3// Snipers %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnSniper;

_clipBoard = _clipBoard + format["%2%3// DMRs %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnDMR;

_clipBoard = _clipBoard + format["%2%3// Launchers %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnLauncher;

_clipBoard = _clipBoard + format["%2%3// Handguns %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnHandGun;

_clipBoard = _clipBoard + format["%2%3// Shotguns %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnShotGun;

_clipBoard = _clipBoard + format["%2%3// Throwables %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnThrow;

_clipBoard = _clipBoard + format["%2%3// Unknown %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnUnknown;

_clipBoard = _clipBoard + format["%2%3// Magazines %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnMagazines;

_clipBoard = _clipBoard + format["%2%3// Optics %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnOptics;

_clipBoard = _clipBoard + format["%2%3// Muzzles %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnMuzzles;

_clipBoard = _clipBoard + format["%2%3// Pointers %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnPointers;

_clipBoard = _clipBoard + format["%2%3// Underbarrel %1",endl,endl,endl];
{
	_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
}forEach _wpnUnderbarrel;

copyToClipboard _clipBoard;
