/*
	Class Name Extraction Tool
	By GhostriderDbD
	For Arma 3
	
	All the code and information provided here is provided under an Attribution Non-Commercial ShareAlike 4.0 Commons License.

	http://creativecommons.org/licenses/by-nc-sa/4.0/		
*/

fn_generateItemList = {
	params["_items"];
	private["_clipBoard"];
	_clipBoard = "";
	{
		_clipBoard = _clipBoard + format['"%1%",%2',_x,endl]
	}forEach _items;
	_clipBoard;
};

fn_generatePriceList = {
	params["_items"];
	private["_clipBoard"];
	_clipBoard = "";
	{
		if (GRG_mod == "Exile") then 
		{
			_clipboard = _clipboard + format["class %1 { quality = 3; price = 150; };%2",_x,endl];
			//_clipboard = _clipboard + format["5, %1 %2",_x,endl];
		};
		if (GRG_mod == "Epoch") then 
		{
			_clipboard = _clipboard + format["class %1 { price = 100; };%2",_x,endl];
		};	
	}forEach _items;
	_clipBoard
};

fn_generateLootTableEntries = {
	params["_items"];
	private["_clipBoard"];
	_clipBoard = "";
	{
		if (GRG_mod == "Exile") then 
		{
			_clipboard = _clipboard + format["5, %1 %2",_x,endl];
		};
		if (GRG_mod == "Epoch") then 
		{
			_clipboard = _clipboard + format['{ { "%1", "item" /*"backpack" "magazine" "item" "weapon"*/ }, 5 },%2',_x,endl];
		};	
	}forEach _items;
	_clipBoard
};




