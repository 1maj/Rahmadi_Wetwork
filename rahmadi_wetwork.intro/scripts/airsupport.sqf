_player	=	_this select 1; 
_target	=	laserTarget _player;
_inArea	=	_target inArea designatorZone;
_action =	_this select 2;
if (_inArea) then {
	JTAC removeAction _action;
	hintSilent "Tally.";
	remoteExec ["scripts\CAS.sqf", 2]; 
	sleep 8;
	[[getpos trgt2, 180, "RHS_A10", 3], "scripts\CAS.sqf"] remoteExec ["execVM", 2]; 
	sleep 8;
	[[getpos trgt1, 180, "RHS_A10", 3], "scripts\CAS.sqf"] remoteExec ["execVM", 2]; 
	sleep 10;
	"scripts\alarm.sqf" remoteExec ["execVM", 2];
} else {
	hintSilent "No joy.";
};
