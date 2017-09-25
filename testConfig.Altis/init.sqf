/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/

// load string library
//nul=[] execVM "KRON_Strings.sqf";
GRG_mod = "Exile";  // Options are "Exile" or "Epoch".  This configuration pertains only to generating pre-formated price lists.
GRG_includedWeaponMagazines = false;
GRG_configuratorPathName = "ExcludedClassNames\";

#include "code\variables.sqf";
#include "code\functions.sqf";

player addAction ["Vehicles","vehicles.sqf", [], 9];
player addAction ["Weapons","weapons.sqf",[], 8.9];
player addAction ["Magazines","magazines.sqf", 8.7];
player addAction ["Wearables","wearables.sqf", 8.8];
player addAction ["Items","items.sqf",8.6];
player addAction ["Turrets","vehiclesTurrets.sqf", 8.5];




