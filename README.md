/*
	=========================================
	GhostriderDBD' className extraction tool.
	=========================================
*/

How To Use This Tool.

1) Start Arma 3 with any mods for which you wish to extract class names.
2) Start the Eden Editor.
3) Open the testConfig.Altis mission.

You are now ready to generate the class names. The tools copy these to the clipboard. All you need to do to generate a list of classnames is select the tool, Alt-Tab out of Arma, and paste the contents of the clipboard into a text editor such as notepad ++.
For each category (e.g., uniforms, weapons, vehicles) there are two tools. 
One generates a simple list of class names which could be used when configuring traders for Exile.
The second will generate a pre-configured price list using either Epoch or Exile formats.
You can determine which format of price list will be generated by changing DBD_priceConfiguration in init.sqf.

Credits:
	This tool uses Kronzky's string library: http://www.kronzky.info/snippets/strings/index.htm
	The algorithm for extracting weapons class names is derived from one posted by KiloSwiss on EpochMod:
	https://epochmod.com/forum/topic/32239-howto-get-available-weapons-mod-independent/
	
License
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
	
	
	There is no charge to use these tools.
	Please do not charge for items available to players through the use of these tools.
	You may modify any of the tools as you like.
	Please give credit to me and those listed above if redistributing modified code.
	
--------------------------
License
--------------------------
All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

http://creativecommons.org/licenses/by-nc-sa/4.0/