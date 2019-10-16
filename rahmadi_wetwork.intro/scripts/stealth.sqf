/*
WIP stealth script by Green for Tacsalmon.

Allows stealthy shit.

Rememebr it's very WIP don't even look at this code it'll give you eye cancer pls.
You shouldn't even be here, why did you de-pbo my beautiful mission?
It's for a low intensity mission so optimisation went out the window.

Run in initPlayerLocal.sqf;

0 is list of muzzle devices that arne't suppressors and grenades that trigger alarm, rounds and their distances.
1 is eventhandler to check for unsuppressed shots.
2 is loop to check if enemy spots you then waits 10 seconds and check if enemy still alive.

all run an alarm script if it returns true.

TODO: 
blacklist certain grenades like IR ligths.
add NVG implementation to check if enemy has NVG and spot IR ligths.
optimise.
ghillie suit implementation.
implement thunder system, if there's a lighting strike you can shoot unsuppressed. 
dead body spotting.
flesh out vehicle system.
flesh out gunshot system, 12.7 can be heard at 1km, or 250m suppressed, 5.56 can be heard at 500, or 25 suppressed, 9mm can be at 250, or 5 suppressed etc..
add support for mounted guns like techies, mg nests etc.
*/

//0
salmon_muzzles =  [
	"rhs_mag_rgo",
	"rhs_mag_rgn",
	"rhsgref_mag_rkg3em",
	"MiniGrenade",
	"rhs_mag_rgd5",
	"rhs_mag_m67",
	"HandGrenade",
	"rhs_mag_m69",
	"rhs_mag_f1",
	"rhsusf_acc_SF3P556",
	"rhsusf_acc_SFMB556",
	"rhsgref_acc_zendl",
	"rhs_acc_pgs64",
	"rhs_acc_pgs64_74u",
	"rhs_acc_pgs64_74un",
	"rhsusf_acc_m24_muzzlehider_wd",
	"rhsusf_acc_m24_muzzlehider_d",
	"rhsusf_acc_m24_muzzlehider_black",
	"ACE_muzzle_mzls_93mmg",
	"ACE_muzzle_mzls_smg_02",
	"ACE_muzzle_mzls_H",
	"ACE_muzzle_mzls_B",
	"ACE_muzzle_mzls_L",
	"ACE_muzzle_mzls_smg_01",
	"ACE_muzzle_mzls_338",
	"rhs_acc_dtk3",
	"rhs_acc_dtk2",
	"rhs_acc_dtk1",
	"rhs_acc_dtk1p",
	"rhs_acc_dtk1983",
	"rhs_acc_dtk",
	"rhs_acc_dtkakm",
	"rhs_acc_ak5",
	"rhs_acc_dtk1l",
	"rhsusf_acc_ARDEC_M240",
	"rhs_acc_uuk",
	""
];
salmon_grenades = [
	"rhs_mag_rgo",
	"rhs_mag_rgn",
	"rhsgref_mag_rkg3em",
	"MiniGrenade",
	"rhs_mag_rgd5",
	"rhs_mag_m67",
	"HandGrenade",
	"rhs_mag_m69",
	"rhs_mag_f1"
];

//1
["All", "Fired", {
	params ["_unit", "_weapon", "_barrel", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
	"fired EH" remoteExec ["systemChat", 0];
	if !(_unit isKindOf "CAManBase") exitWith {
		"static fired" remoteExec ["systemChat", 0];
		if (75 > random 100) then {
			[] spawn {
				sleep 5 + random 5;
				"scripts\alarm.sqf" remoteExec ["execVM", 2];
			};
		};
	};
	//checks suppressor slot and if unit fired any of the items in salmon_muzzles
	_muzzle = _unit weaponAccessories currentMuzzle _unit param [0, ""]; 
	if (_weapon == currentWeapon _unit && salmon_muzzles find _muzzle >=0) then {
		"unsuppressed" remoteExec ["systemChat", 0];
		if (75 > random 100) then {
			[] spawn {
				sleep 5 + random 5;
				"scripts\alarm.sqf" remoteExec ["execVM", 2];
			};
		};
	};
	//Throws grenades (not working for ace throw)
	//if ({_x == _weapon} count ["throw", "rhs_throw_grenade", "rhsusf_throw_grenade"] > 0) then {
	if (toLower _weapon in ["throw", "rhs_throw_grenade", "rhsusf_throw_grenade"]) then {
		"throw" remoteExec ["systemChat", 0];
		//explosives
		if ({_x == _magazine} count salmon_grenades > 0) then {
			"grenade" remoteExec ["systemChat", 0];
			[] spawn {
				if (75 > random 100) then {
					sleep 5 + random 5;
					"scripts\alarm.sqf" remoteExec ["execVM", 2];
				};
			};
		} else {
			//smokes
			"smoke" remoteExec ["systemChat", 0];
			[_unit, _projectile] spawn {
				params ["_unit", "_projectile"];
				sleep 10;
				_searcher = _unit findNearestEnemy _projectile;
				if (_searcher distance _projectile < 150) then {
					[format ["%1 found closest within 150m", _searcher]] remoteExec ["systemChat", 0];
					_searcher doMove getpos _projectile;
					while {true} do {
						sleep 1;
						if (!alive _searcher) exitWith {
							"searcher killed" remoteExec ["systemChat", 0];
						};
						if (_searcher distance getpos _projectile < 7) then {
							"unit at grenade" remoteExec ["systemChat", 0];
							group _searcher setBehaviour "AWARE";
							sleep 3;
							_searcher reveal [_unit, 1.6]; 
						};
					};
				};
			};
		};
	};
}] call CBA_fnc_addClassEventHandler;

//2
_spotted = false;
_time = 0;
_timeSet = false;
while {true} do {
	if (alive player) then {
		_enemies = [];
		_spotted = false;
		_entities = player nearEntities [["Man","Tank", "Air", "Car"], 1500];
		{
			if (side _x == east && alive _x) then {
				_enemies pushBack _x
			};
		} forEach _entities;		
		{
			if (_x knowsAbout player > 1.5) then {
				_spotted = true;
			};
		} forEach _enemies;
		if (_spotted) then {
			if !(_timeSet) then {
				_time = time;
				_timeSet = true;
			};
			if (_timeSet && time > _time + 5 + random 10) then {
				"scripts\alarm.sqf" remoteExec ["execVM", 2];
			};
		} else	{
			_timeSet = false;
		};
	};
	sleep 1;
};

/*

configfile >> "CfgWeapons" >> "muzzle_snds_M" >> "ItemInfo" >> "AmmoCoef" >> "audibleFire"
configfile >> "CfgWeapons" >> "muzzle_snds_338_black"

{
	//vanilla
	_x addEventHandler ["firedMan", {
		params ["_unit", "_weapon", "_barrel", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
		systemChat "fired EH";
		//checks suppressor slot and if unit fired any of the items in salmon_muzzles
		_muzzle = _unit weaponAccessories currentMuzzle _unit param [0, ""]; 
		if (_weapon == currentWeapon _unit && salmon_muzzles find _muzzle >=0) then {
			systemChat "unsuppressed";
			if (75 > random 100) then {
				[] spawn {
					sleep 10;
					"scripts\alarm.sqf" remoteExec ["execVM", 2];
				};
			};
		};
		//Throws grenades (not working for ace throw)
		if ({_x == _weapon} count ["throw", "rhs_throw_grenade", "rhsusf_throw_grenade"] > 0) then {
			systemChat "throw";
			//explosives
			if ({_x == _magazine} count salmon_grenades > 0) then {
				systemChat "grenade";
				[] spawn {
					sleep 10;
					"scripts\alarm.sqf" remoteExec ["execVM", 2];
				};
			} else {
				//misc
				systemChat "smoke";
				[_unit, _projectile] spawn {
					params ["_unit", "_projectile"];
					sleep 10;
					_searcher = _unit findNearestEnemy _projectile;
					if (_searcher distance _projectile < 150) then {
						systemChat format ["%1", _searcher];
						_searcher doMove getpos _projectile;
						_searcher moveTo getpos _projectile;
						while {true} do {
							sleep 1;
							if (!alive _searcher) exitWith {systemChat "searcher killed";};
							if (_searcher distance getpos _projectile < 7) then {
								systemChat "near";
								group _searcher setBehaviour "AWARE";
								sleep 3;
								_searcher reveal [_unit, 1.6]; 
							};
						};
					};
				};
			};
		};
	}];
} forEach allUnits;
*/