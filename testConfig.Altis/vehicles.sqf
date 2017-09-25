/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/
_allTanks =
[	
	"B_APC_Tracked_01_rcws_F",
	"B_APC_Tracked_01_CRV_F",
	"B_APC_Tracked_01_AA_F",
	"B_MBT_01_arty_F",
	"B_MBT_01_mlrs_F",
	"B_MBT_01_TUSK_F",
	"O_APC_Tracked_02_cannon_F", 
	"O_APC_Tracked_02_AA_F",
	"O_MBT_02_cannon_F",
	"O_MBT_02_arty_F",
	"O_APC_Wheeled_02_rcws_F", 
	"I_APC_tracked_03_cannon_F",
	"I_MBT_03_cannon_F"
];
			
_vehiclesBase = [];
#include "ExcludedClassNames\baseVehicles.sqf"
_veh = (configfile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses;
_veh sort true;
_index = 0;
_cars = [];
_tanks = [];
_boats = [];
_air = [];
_helis = [];
_planes = [];
_exile = 0;
 
{
	if !(_x in _vehiclesBase) then
	{
		if (_x isKindOf "Tank") then {_tanks pushBack _x;systemChat format["Adding Tank %1",_x];};
		if (_x isKindOf "Car") then {_cars pushBack _x};
		if ((_x isKindOf "Plane")) then {_planes pushBack _x};
		if ((_x isKindOf "Helicopter")) then {_helis pushBack _x};
		if (_x isKindOf "Ship") then {_boats pushback _x;};	
	};
}forEach _veh;

systemChat format["%1 tanks found",count _tanks];

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
	private _t = "";
	_clipboard = _clipboard + format["%2%2// %1%2%2",_x select 0,endl];
	_t = [_x select 1] call fn_generateItemList;
	_clipBoard = _clipBoard + _t;
}forEach[
["Cars",_cars],
["Tanks",_tanks],
["Boats",_boats],
["Helis",_helis],
["Planes",_planes],
["Other Air",_air]
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
	private _t = "";
	_clipboard = _clipboard + format["%2%2// %1%2%2",_x select 0,endl];
	_t = [_x select 1] call fn_generatePriceList;
	_clipBoard = _clipBoard + _t;
}forEach[
["Cars",_cars],
["Tanks",_tanks],
["Boats",_boats],
["Helis",_helis],
["Planes",_planes],
["Other Air",_air]
];

copyToClipboard _clipboard;

hint format["Vehicles Config Extractor Run complete%1Output copied to clipboard%1Paste it into a text editor to acces",endl];