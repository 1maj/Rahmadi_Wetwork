_aa = [aa1, aa2];
waituntil {sleep 0.1; (!alive radar || !alive radar2)};
rblown = true;
if !(rsabotage) then {
	{_x setVehicleAmmo 0;} forEach _aa;
	[JTAC, ["Call Airstrike", "scripts\AirSupport.sqf"]] remoteExec ["addAction", JTAC, true];
};
