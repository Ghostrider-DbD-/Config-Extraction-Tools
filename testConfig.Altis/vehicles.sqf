/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/
			
_excludedVehicles = [];
_baseClasses = [];
#include "ExcludedClassNames\excludedVehicles.sqf"
_veh = (configfile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses;
_veh sort true;
_index = 0;
_cars = [];
_tanks = [];
_boats = [];
_air = [];
_helis = [];
_planes = [];
processVehicle = true;
_n = count _veh;
_index = 0;
_counter = 1;
_interval = 25;
systemChat "Classname Extraction tool for vehicles initialized";
{
	processVehicle = true;
	if (GRG_Root isEqualTo "") then 
	{
		processVehicle = true;
	};
	if (count GRG_Root > 0) then
	{
		_leftSTR = [toLower _x,count GRG_Root] call KRON_StrLeft;
		processVehicle = ((toLower GRG_Root) isEqualTo _leftSTR);
		_msg = format["vehicles.sqf:: _leftSTR = %1 and processVehicle = %2",_leftSTR, processVehicle];
		//systemChat _msg;
		diag_log _msg;
	};
	if (processVehicle) then
	{
		if (GRG_addIttemsMissingFromPricelistOnly) then
		{
			if(GRG_mod isEqualTo "Exile") then
			{
				if (isNumber (missionConfigFile >> "CfgExileArsenal" >> _x >> "price")) then
				{
					diag_log format["price for item %1 = %2 tabs",_x,getNumber(missionConfigFile >> "CfgExileArsenal" >> _x >> "price")];
					processVehicle = false; // Item already listed and assumed to be included in both trader lists and price lists
					diag_log format["Item %1 already has a price: Not processing item %1",_x];
				} else {
					diag_log format["price for item %1 = %2 tabs",_x,getNumber(missionConfigFile >> "CfgExileArsenal" >> _x >> "price")];
					diag_log format["Item %1 has no price: processing item %1",_x];
					processVehicle = true;
				};
			};
			if (GRG_mod isEqualTo "Epoch") then
			{
				if (isNumber (missionConfigFile >> "CfgPricing" >> _x >> "price")) then
				{
					processVehicle = false; // Item already listed and assumed to be included in both trader lists and price lists
					
				} else {
					processVehicle = true;
				};
			};
		};	
	};
	if ([toLower _x,"base"] call KRON_StrInStr || [toLower _x,"abstract"] call KRON_StrInStr) then
	{
		if !(_x in _baseClasses) then {_baseClasses pushBack _x};
		processVehicle = false;
		_msg = format["base class %1 ignored",_x];
		systemChat _msg;
		//diag_log _msg;
	};
	if (processVehicle && !(_x in _excludedVehicles)) then
	{
		if (_index == 1) then 
		{
			_msg = format["Classname: %1 %2 out of %3",_x, _counter, _n];
			systemChat _msg;
			//diag_log _msg;		
		};
		if (_index == _interval) then {_index = 0};
		_index = _index + 1;
		_counter = _counter + 1;
		if (_x isKindOf "Tank") then {_tanks pushBack _x;/*systemChat format["Adding Tank %1",_x];*/};
		if (_x isKindOf "Car") then {_cars pushBack _x};
		if ((_x isKindOf "Plane")) then {_planes pushBack _x};
		if ((_x isKindOf "Helicopter")) then {_helis pushBack _x};
		if (_x isKindOf "Ship") then {_boats pushback _x;};	
	};
}forEach _veh;

systemChat format["%1 classnames processed, formating trader entries",count _veh];

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
systemChat "All Vehicles Process and results copied to clipboard";
copyToClipboard _clipboard;

hint format["Vehicles Config Extractor Run complete%1Output copied to clipboard%1Paste it into a text editor to acces",endl];