waitUntil {time > 10}; 
if (isNil "JTAC") exitWith {
	"End1" remoteExec ["endMission", 0];
};