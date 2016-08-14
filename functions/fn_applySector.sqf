#include "defines.hpp"
private ["_sector"];
params ["_idx"];

_applyToSector = {
  params ["_idx","_precision","_hash"];
  private ["_sector","_oldValue","_newValue"];

  _sector = [((GRAD_GUNDOG_TRACK select _idx) select 1), _precision] call FNC(getSector);

  if (HASH_HAS_KEY(_hash,_sector)) then {
    _oldValue = HASH_GET(_hash,_sector);
    _newValue = _oldValue + [_idx];
  } else {
    _newValue = [_idx];
  };
  LOG_DEBUG(FORMAT_2("sector %1 value %2",  _sector, _newValue));

  HASH_SET(_hash, _sector, _newValue);          //append to sector

  LOG_DEBUG(FORMAT_2("append scent in %1 : %2",  _sector, GRAD_GUNDOG_TRACK select _idx));

  _sector;
};

if (GRAD_GUNDOG_SECTOR_1) then {
  _sector = [_idx, 1, GRAD_GUNDOG_HUNTING_GROUND_1] call _applyToSector;
  LOG_DEBUG(FORMAT_2("Append %1 to sector(1) %2", _idx, _sector));
};
if (GRAD_GUNDOG_SECTOR_2) then {
  _sector = [_idx, 2, GRAD_GUNDOG_HUNTING_GROUND_2] call _applyToSector;
  LOG_DEBUG(FORMAT_2("Append %1 to sector(2) %2", _idx, _sector));
};
if (GRAD_GUNDOG_SECTOR_3) then {
  _sector = [_idx, 3, GRAD_GUNDOG_HUNTING_GROUND_3] call _applyToSector;
  LOG_DEBUG(FORMAT_2("Append %1 to sector(3) %2", _idx, _sector));
};
