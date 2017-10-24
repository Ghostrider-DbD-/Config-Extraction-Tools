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
_baseItems = [];
_baseClasses = [];
_mines = [];
_lasers = [];
_items = [];
_allItemTypes = ["Equipment"];
_excludedItemTypes = [
			"AccessoryMuzzle",
			"AccessoryPointer",
			"AccessorySights",
            "AccessoryBipod"
];
_addedBaseNames = [];
_itemsList = (configFile >> "cfgWeapons") call BIS_fnc_getCfgSubClasses;
_temp = (configfile >> "CfgMagazines") call BIS_fnc_getCfgSubClasses;
_itemsList = _itemsList + _temp;
//_wearablesList sort true;
{
	_itemType = _x call BIS_fnc_itemType;
	diag_log format["for Item %1 its ItemType [0] is %2",_x,_itemType select 0];
	if ((_itemType select 0) in _allItemTypes) then
	{
		processItem = true;
		if (GRG_Root isEqualTo "") then 
		{
			processItem = true;
		} else {
			_leftSTR = [toLower _x,count GRG_Root] call KRON_StrLeft;
			processItem = ((toLower GRG_Root) isEqualTo _leftSTR);
			//systemChat format["wearables.sqf:: _leftSTR = %1 and processItem = %2",_leftSTR, processItem];		
		};
		if ([toLower _x,"base"] call KRON_StrInStr || [toLower _x,"abstract"] call KRON_StrInStr) then
		{
			if !(_x in _baseClasses) then {_baseClasses pushBack _x};
			processItem = false;
			_msg = format["base class %1 ignored",_x];
			systemChat _msg;
			//diag_log _msg;
		};	
		if (processItem) then
		{
			if (GRG_addIttemsMissingFromPricelistOnly) then
			{
				if(GRG_mod isEqualTo "Exile") then
				{
					if (isNumber (missionConfigFile >> "CfgExileArsenal" >> _x >> "price")) then
					{
						diag_log format["price for item %1 = %2 tabs",_x,getNumber(missionConfigFile >> "CfgExileArsenal" >> _x >> "price")];
						processItem = false; // Item already listed and assumed to be included in both trader lists and price lists
						diag_log format["Item %1 already has a price: Not processing item %1",_x];
					} else {
						diag_log format["price for item %1 = %2 tabs",_x,getNumber(missionConfigFile >> "CfgExileArsenal" >> _x >> "price")];
						diag_log format["Item %1 has no price: processing item %1",_x];
						processItem = true;
					};
				};
				if (GRG_mod isEqualTo "Epoch") then
				{
					if (isNumber (missionConfigFile >> "CfgPricing" >> _x >> "price")) then
					{
						processItem = false; // Item already listed and assumed to be included in both trader lists and price lists
						
					} else {
						processItem = true;
					};
				};
			};	
		};		
		if ( !(_x in _baseItems) && processItem) then
		{
			_baseItems pushBack _x;
			systemChat format["classname = %1, _itemType [0] = %2 _itemType[1] = %3",_x, _itemType select 0, _itemType select 1];		
			if (_itemType select 0 isEqualTo "Mine" && !(_itemType select 1 in _excludedItemTypes)) then {_mines pushBack _x};
			if (_itemType select 0 isEqualTo "Item" && !(_itemType select 1 in _excludedItemTypes)) then {_items pushBack _x};
		};
	};
} foreach _itemsList;

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
	["Mines",_mines],
	["Lasers",_lasers],
	["Items",_items]
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
	["Mines",_mines],
	["Lasers",_lasers],
	["Items",_items]
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
	["Mines",_mines],
	["Lasers",_lasers],
	["Items",_items]
];
copyToClipboard _clipBoard;
systemChat "All items Processed and results copied to clipboard";
hint format["Wearables Config Extractor Run complete%1Output copied to clipboard%1Paste it into a text editor to acces",endl];