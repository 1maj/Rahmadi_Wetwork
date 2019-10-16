execVM "scripts\stealth.sqf";
execVM "scripts\randomhvt.sqf";
execVM "scripts\disableAA.sqf";

[west, "infil", ["<br />Make your way to the northern shore.", "Infiltrate", "objNull"], objNull, "ASSIGNED", 1, true, "walk", false] call BIS_fnc_taskCreate;
[west, "radar", ["<br />Search and destroy the radar installation.", "Destroy Radar", "objNull"], objNull, "CREATED", 1, true, "destroy", false] call BIS_fnc_taskCreate;
[west, "airbase", ["<br />Call in the strike aircraft on the airfield.", "Call Airstrike", "objNull"], objNull, "CREATED", 1, true, "plane", false] call BIS_fnc_taskCreate;
[west, "exfil", ["<br />Exfiltrate via the SDV.", "Exfiltrate", "objNull"], objNull, "CREATED", 1, true, "run", false] call BIS_fnc_taskCreate;
[west, "hvt", ["<br /> Destroying the radar and air assets on the island is the highest priority but if you find Col. Ramirez, neutralise him. You will have to confirm the kill.", "Neutralise HVT", "objNull"], objNull, "CREATED", 1, true, "kill", false] call BIS_fnc_taskCreate;