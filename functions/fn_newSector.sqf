#include "defines.hpp"
params ["_idx"];

_applyToSector = {
  params ["_idx","_precision"];
  private ["_sector","_oldValue","_newValue"];

  _sector = [((GRAD_GUNDOG_TRACK select _idx) select 1), _precision] call FNC(getSector);

  if (HASH_HAS_KEY(GRAD_GUNDOG_HUNTING_GROUND,_sector)) then {
    _oldValue = HASH_GET(GRAD_GUNDOG_HUNTING_GROUND,_sector);
    _newValue = _oldValue + [_idx];
  } else {
    _newValue = [_idx];
  };
  LOG_DEBUG(FORMAT_2("sector %1 value %2",  _sector, _newValue));

  HASH_SET(GRAD_GUNDOG_HUNTING_GROUND, _sector, _newValue);          //append to sector

  LOG_DEBUG(FORMAT_2("append scent in %1 : %2",  _sector, GRAD_GUNDOG_TRACK select _idx));
};

if (GRAD_GUNDOG_SECTOR_1) then { [_idx, 1] call _applyToSector; };
if (GRAD_GUNDOG_SECTOR_2) then { [_idx, 2] call _applyToSector; };
if (GRAD_GUNDOG_SECTOR_3) then { [_idx, 3] call _applyToSector; };
