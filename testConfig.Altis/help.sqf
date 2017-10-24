disableSerialization;
["",0,0.2,10,0,0,8] spawn BIS_fnc_dynamicText;
createDialog "RscDisplayWelcome";
_display = findDisplay 999999;
_text1 = _display displayCtrl 1100;
_buttonSpoiler = _display displayCtrl 2400;
_textSpoiler = _display displayCtrl 1101;
_text2 = _display displayCtrl 1102;

_message = _message + "<t align='left' size='1' shadow='0'><t color='#ff9900'>General rules:</t><br/><br/>";
_message = _message + "We ask that you follow just a few basic rules.<br/><br/>";
_message = _message + "<br/>";
_message = _message + "* There is NO PVP allowed except in designated PVP Zones, should these be present on the server.<br/><br/>";
_message = _message + "* STEALING from players, vehicles, bases or corpses is not allowed.<br/><br/>";
_message = _message + "* Please be respectful toward other players<br/>";
_message = _message + "* Foul language will result in an automatick kick.<br/>";
_message = _message + "* Hacking, taking advantage of glitches or dupping is just a no-no.<br/>";
_message = _message + "* Please Respect Admins: They work hard to keep order and help players with issues.<br/><br/><br/>";
_message = _message + "* To keep language respectful you will be kicked for using certain words in chat. <br/>";
_message = _message + "* This is not intended to stiffle play but to maintain a polite decorum.<br/>";

_message = _message + "<a color='#ff9900'>Base Building Rules:</a><br/><br/>";
_message = _message + "* Please do not build closer thaan 150 meeters from the nearest building or structure.<br/>";
_message = _message + "* Your flag or frequency jammer may block spawning of loot for other players.<br/>";
_message = _message + "* Please do Not block roads.<br/><br/>";
_message = _message + "* Do Not build in airfields or place safes at these locations.<br/><br/>";
_message = _message + "* Please do not build snipping towers at strongholds.<br/>";

_message = _message + "<a color='#ff9900'>Mission Rules:</a><br/><br/>";
_message = _message + "* Call Missions in Side Chat AND place a marker with your name on the map in Side Chat.<br/><br/>";
_message = _message + "* Call missions once you are ready to go there.<br/><br/>";
_message = _message + "* Each player or group may only claim one mission at a time.<br/><br/>";

_message = _message + "<a color='#ff9900'>PVP Zone Rules:</a><br/><br/>";
_message = _message + "* Anything goes in PVP Zones.<br/><br/>";

_message = _message + "<a color='#ff9900'>Player Tips:</a><br/><br/>";
_message = _message + "* AI are sneaky and the last few AI at a mission often lay hidden and waiting for unwary players<br/><br/>";
_message = _message + "* Grenades and HE rounds are your friend, especially at town invasions<br/><br/>";
_message = _message + "* You can starve or die of thrist in Exile - never leave home without snacks<br/><br/>";
_message = _message + "* You can die of hypothermia on Namalsk - bundle up, light fires, bring thermal buddies<br/><br/>";
_message = _message + "* Missions tend to spawn in certain locations. If you build there do not be surprised if AI are waiting<br/><br/>";
_message = _message + "* If you build near missions or Mafia locations the AI may destroy any vehicles left outside even if you are not in-game<br/><br/>";
_message = _message + "* Arma and Exile are glitchy. Do not park vehicles/aircraft on roofs if you are not prepared for them to go Boom<br/><br/>";
_message = _message + "* Use the grid function to place pieces oriented north/south and park vehicles headed North to reduce issues with them going Boom<br/><br/>";
_message = _message + "* Remember that players and AI share the same roads.<br/><br/>";
_message = _message + "* Admins are here to keep order and enforce rules. They volunteer their time based on a love of Arma. Please respect them.<br/><br/>";

_message = _message + "<a color='#ff9900'>Roles of our Admins:</a><br/><br/>";
_message = _message + "* Our Admins volunteer their time to keep our servers running smoothly<br/><br/>";
_message = _message + "* Please treat them with the respect you would ask if you fulfilled their roles<br/><br/>";
_message = _message + "* Admins are responsible for ensuring that players adhere to our rules as stated above<br/><br/>";
_message = _message + "* If you have an issue with a player please check our teamspeak or post a report of the incident on our website or discord<br/><br/>";
_message = _message + "* Admins MAY offer assistance to players who are getting started, or who lost gear or vehicles. <br/><br/>";
_message = _message + "* However, we are not responsible for damaged or destroyed vehicles, missing gear or lost tabs or respect<br/><br/>";

_message = _message + "Have fun and play fair. <a color='#ff9900'></a><br/><br/><t/>";

_text1 ctrlSetStructuredText (parseText _message);
_positionText1 = ctrlPosition _text1;
_yText1 = _positionText1 select 1;
_hText1 = ctrlTextHeight _text1;
_text1 ctrlSetPosition [_positionText1 select 0, _yText1, _positionText1 select 2, _hText1];
_text1 ctrlCommit 0;
_buttonSpoiler ctrlSetFade 1;
_buttonSpoiler ctrlCommit 0;
_buttonSpoiler ctrlEnable false;
_textSpoiler ctrlSetFade 1;
_textSpoiler ctrlCommit 0;
_text2 ctrlSetFade 1;
_text2 ctrlCommit 0;
