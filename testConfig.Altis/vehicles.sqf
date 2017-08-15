/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/

_vehiclesBase = [];
#include "ExcludedClassNames\baseVehicles.sqf"
_veh = (configfile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses;
//_veh sort true;
systemChat format[" _veh contains %1 entries",count _veh];
_index = 0;
_cars = [];
_boats = [];
_air = [];
_exile = 0;
 
{
	if (_x isKindOf "Car" && !(_x in _vehiclesBase)) then
	{
		_cars pushback _x;
	};
	if (_x isKindOf "Air" && !(_x in _vehiclesBase)) then
	{
		_air pushback _x;
	};
	if (_x isKindOf "Boat" && !(_x in _vehiclesBase)) then
	{
		_boat pushback _x;
	};	
}forEach _veh;

_clipBoard = "";

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipboard + GRG_Exile_TraderItemLists_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipboard + GRG_Epoch_ItemLists_Header;
};

_clipboard = _clipboard + format["// Cars%1%2",endl,endl,endl];
_temp = [_cars] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1// Boats%2%3",endl,endl,endl];
_temp = [_boats] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1// Air%2%3",endl,endl,endl];
_temp = [_air] call fn_generateItemList;
_clipBoard = _clipBoard + _temp;

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipBoard + GRG_Exile_Pricelist_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipBoard + GRG_Epoch_Pricelist_Header;
};
_clipboard = _clipboard + format["// Cars%1%2",endl,endl,endl];
_temp = [_cars] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1// Boats%2%3",endl,endl,endl];
_temp = [_boats] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1// Air%2%3",endl,endl,endl];
_temp = [_air] call fn_generatePriceList;
_clipBoard = _clipBoard + _temp;

if (GRG_mod == "Exile") then 
{
	_clipboard = _clipBoard + GRG_Exile_Loottable_Header;
};
if (GRG_mod == "Epoch") then 
{
	_clipboard = _clipBoard + GRG_Epoch_Loottable_Header;
};
_clipboard = _clipboard + format["// Cars%1%2",endl,endl,endl];
_temp = [_cars] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1// Boats%2%3",endl,endl,endl];
_temp = [_boats] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;
_clipboard = _clipboard + format["%1// Air%2%3",endl,endl,endl];
_temp = [_air] call fn_generateLootTableEntries;
_clipBoard = _clipBoard + _temp;

copyToClipboard _clipboard;

hint format["Vehicles Config Extractor Run complete%1Output copied to clipboard%1Paste it into a text editor to acces",endl];