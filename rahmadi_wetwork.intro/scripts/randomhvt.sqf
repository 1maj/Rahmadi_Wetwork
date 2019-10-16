_randomSpawn = selectRandom [true, false];
if (_randomSpawn) then {
	hvt setpos (getmarkerpos "hvtspawn");
	hvt setPosATL (hvt modelToWorld[0,0,4]);
	hvtguard1 setpos (getmarkerpos "hvtguard1spawn");
	hvtguard2 setpos (getmarkerpos "hvtguard2spawn");
	hvtguard3 setpos (getmarkerpos "hvtguard3spawn");
	hvtguard3 setdir 142;
	hvtcar setpos (getmarkerpos "hvtcarspawn");
};