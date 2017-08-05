/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/

// load string library
nul=[] execVM "KRON_Strings.sqf";
DBD_priceConfiguration = "Exile";  // Options are "Exile" or "Epoch".  This configuration pertains only to generating pre-formated price lists.

player addAction["Run vehiclesConfig","vehiclesConfig.sqf"];
player addAction["Run vehiclesPricelist","vehiclesPriceList.sqf"];
player addAction["Run airConfig","airConfig.sqf"];
player addAction["Run airPriceList","airPriceList.sqf"];
player addAction["Run weaponsConfig","weaponsConfig.sqf"];
player addAction["Run weaponsPriceList","weaponsPriceList.sqf"];
player addAction["Run magazinesConfig","magazinesConfig.sqf"];
player addAction["Run magazinesPriceList","magazinesPriceList.sqf"];
player addAction["Run wearablesConfig","wearablesConfig.sqf"];
player addAction["Run wearablesPriceList","wearablesPriceList.sqf"];

player addAction["Run headgearConfig","headgearConfig.sqf"];
player addAction["Run headgearPriceList","headgearPriceList.sqf"];
player addAction["Run vestsConfig","vestsConfig.sqf"];
player addAction["Run vestsPriceList","vestsPriceList.sqf"];
player addAction["Run uniformsConfig","uniformsConfig.sqf"];
player addAction["Run uniformsPriceList","uniformsPriceList.sqf"];

