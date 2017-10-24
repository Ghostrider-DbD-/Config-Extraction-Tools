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
GRG_Root = "CUP"; // Scripts will test if the leftmost N characters of a classname are equal to GRG_Root
GRG_addIttemsMissingFromPricelistOnly = true;  // when true will process only class names for which there is not already a price listed for that mod time. for this to work you need to include the description.ext and any price lists for your server in this misison folder.
GRG_includedWeaponMagazines = false;
GRG_configuratorPathName = "ExcludedClassNames\";

#include "Code\variables.sqf";
#include "Code\functions.sqf";
#include "Code\KRON_Strings.sqf";

player addAction ["Vehicles","vehicles.sqf", [], 9];
player addAction ["Weapons","weapons.sqf",[], 8.9];
player addAction ["Magazines","magazines.sqf", 8.7];
player addAction ["Wearables","wearables.sqf", 8.8];
player addAction ["Items","items.sqf",8.6];
player addAction ["Turrets","vehiclesTurrets.sqf", 8.5];




