#include "defines.hpp"
private ["_sector"];
params ["_idx", "_sectors", "_houndedTarget"];

_sector = [getPos _houndedTarget, 2] call IFNC(getSector);

LOG_DEBUG(FORMAT_2("Append %1 to sector(1) %2", _idx, _sector));

//append sector to target's sector hashArray
if (HASH_HAS_KEY(_sectors,_sector)) then {
  HASH_SET(_sectors, _sector, HASH_GET(_sectors,_sector) + [_idx]);
} else {
  //create new hashentry with 1st index
  HASH_SET(_sectors, _sector, [_idx]);
};

//append sector to globalSector hashArray
if (HASH_HAS_KEY(IVAR(SECTOR),_sector)) exitWith {
  _tmp = HASH_GET(IVAR(SECTOR),_sector);
  _tmp pushBackUnique _houndedTarget;
  HASH_SET(IVAR(SECTOR), _sector, _tmp);
};

HASH_SET(IVAR(SECTOR), _sector, [_houndedTarget]);
