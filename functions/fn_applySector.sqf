#include "defines.hpp"
private ["_sector"];
params ["_idx", "_pos", "_sectors"];

_sector = [_pos, 2] call IFNC(getSector);

LOG_DEBUG(FORMAT_2("Append %1 to sector(1) %2", _idx, _sector));

//get data and append
if (HASH_HAS_KEY(_sectors,_sector)) exitWith {
  HASH_SET(_sectors, _sector, HASH_GET(_sectors,_sector) + [_idx]);
};

//create new hashentry with 1st index
HASH_SET(_sectors, _sector, [_idx]);          //append to sector
