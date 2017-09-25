_itemTypes = [];
_itemInformation=[];
_clips = "";
{
	_itemInformation = [_x] call BIS_fnc_itemType;
	_itemTypes pushBack [_x,_itemInformation select 0, _itemInformation select 1];
	_clips = _clips + format["%1,%2,%3%4",_x,_itemInformation select 0, _itemInformation select 1,endl];
}forEach 
[
"Launcher",
"Launcher_Base_F",
"launch_NLAW_F",
"launch_RPG32_F",
"launch_Titan_base",
"launch_Titan_short_base",
"launch_B_Titan_F",
"launch_I_Titan_F",
"launch_O_Titan_F",
"launch_Titan_F",
"launch_B_Titan_short_F",
"launch_I_Titan_short_F",
"launch_O_Titan_short_F",
"launch_Titan_short_F",
"CUP_launch_M72A6",
"CUP_launch_M72A6_Special",
"CUP_launch_Igla",
"CUP_launch_Javelin",
"CUP_launch_M136",
"CUP_launch_M47",
"CUP_launch_MAAWS",
"CUP_launch_Metis",
"CUP_launch_NLAW",
"CUP_launch_RPG18",
"CUP_launch_Mk153Mod0",
"CUP_launch_FIM92Stinger",
"CUP_launch_9K32Strela",
"launch_RPG32_ghex_F",
"launch_RPG7_F",
"launch_B_Titan_tna_F",
"launch_B_Titan_short_tna_F",
"launch_O_Titan_ghex_F",
"launch_O_Titan_short_ghex_F",
"CUP_launch_RPG7V",
"CUP_Igla",
"CUP_Javelin",
"CUP_M47Launcher_EP1",
"CUP_M136",
"CUP_MetisLauncher",
"CUP_BAF_NLAW_Launcher",
"CUP_RPG7V",
"CUP_RPG18",
"CUP_Stinger",
"CUP_Strela"
];
copyToClipboard  _clips;