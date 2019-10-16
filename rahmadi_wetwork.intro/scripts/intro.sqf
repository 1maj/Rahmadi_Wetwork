if (isDedicated) exitWith {};
waitUntil {time > 0};
titleCut ["", "BLACK FADED", 9999];
0 fadeSound 0;
player moveinAny SDV;
playMusic "intro_music";
enableRadio false;
enableEnvironment [false, true];
sleep 2;
[ 
	["Rahmadi","font = 'PuristaMedium'"], 
	["", "<br/>"], 
	["<br/>", "<br/>"], 
	["OP. Wetwork","font = 'PuristaSemiBold'"], 
	["","<br/>"], 
	["Target: Radar installation and Airbase","font = 'PuristaLight'"], 
	["","<br/>"], 
	["CTRG 41 is infiltrating the island","font = 'PuristaLight'"],
	["","<br/>"], 
	["500 metres offshore","font = 'PuristaLight'"]
] execVM "\a3\missions_f_bootcamp\Campaign\Functions\GUI\fn_SITREP.sqf";
sleep 7;
player action ["nvGoggles", player];
titleCut ["", "BLACK IN", 10];
7 fadeSound 1;
