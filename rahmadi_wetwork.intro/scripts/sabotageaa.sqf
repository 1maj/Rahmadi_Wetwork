_action =	_this select 2;
radar2 removeAction _action;
radar2 say3D "electric_broken";
if (rblown) exitWith {};
rsabotage = true; 
_aa = [aa1, aa2];
{_x setVehicleAmmo 0;} forEach _aa;
salmon_airsupportAction	= [JTAC, ["Call Airstrike", "scripts\AirSupport.sqf"]] remoteExec ["addAction", JTAC, true];
