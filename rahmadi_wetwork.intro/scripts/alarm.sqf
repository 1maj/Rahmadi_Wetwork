if !(isServer) exitWith {};
if (alarm) exitWith {};
alarm = true; 
{
	_x setBehaviour (selectRandom ["AWARE", "COMBAT"]);
} forEach allGroups;
while {alive ACT} do {
playSound3D ["A3\Sounds_F\sfx\alarm_independent.wss", ACT, false, ACT, 4, 1, 1700]; 
sleep 6.7;
};