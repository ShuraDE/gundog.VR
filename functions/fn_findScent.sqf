#include "defines.hpp"
private ["_checkSector","_activeSector","_shortestIdx","_nearest","_dist"];
params ["_searchPos","_maxRange"];

_checkSector = {
  params ["_precision", "_hash"];

  _sector = [_searchPos, _precision] call FNC(getSector);
  //check entry exists
  if (HASH_HAS_KEY(_hash,_sector)) then {
    _activeSector = _hash;
  } else {
    false;
  };

};

_activeSector = objNull;
_shortestRange = 999999;

//set maxRange to default if not set
if (isNull "_maxRange") then {_maxRange = GRAD_GUNDOG_MAX_RANGE; };

//aktuell keine aktive spur
if (!GRAD_GUNDOG_HAVE_SCENT) then {


  // #TODO:0 gefällt mir nicht
  if (GRAD_GUNDOG_SECTOR_1 && !isNil "GRAD_GUNDOG_HUNTING_GROUND_1") then {
    [1,GRAD_GUNDOG_HUNTING_GROUND_1] call _checkSector;
    //if (([1,GRAD_GUNDOG_HUNTING_GROUND_1] call _checkSector)==false) exitWith { false; };
  };
  if (GRAD_GUNDOG_SECTOR_2) then {
    [2,GRAD_GUNDOG_HUNTING_GROUND_2] call _checkSector;
    //if (([2,GRAD_GUNDOG_HUNTING_GROUND_2] call _checkSector)==false) exitWith { false; };
  };
  if (GRAD_GUNDOG_SECTOR_3) then {
    [3,GRAD_GUNDOG_HUNTING_GROUND_3] call _checkSector;
    //if (([3,GRAD_GUNDOG_HUNTING_GROUND_3] call _checkSector)==false) exitWith { false; };
  };

  if (isNull _activeSector) exitWith { false; };

  {
    LOG_DEBUG(FORMAT_1("check %1",_x));

    _dist = _chasePos distance ((GRAD_GUNDOG_TRACK select _x) select 1);

    if ((_dist < _maxRange) && (_dist < _nearest)) then {
      _nearest = _dist;
      _nearestIdx = _x;
    };

  } forEach _activeSector;


  if (!isNil "_activeSector") exitWith {
    LOG_DEBUG("Missed exit ??  Search Scent");
  };

  LOG_DEBUG(FORMAT_1("Spur gefunden, distance %1",_shortestRange));
  LOG_DEBUG(str _activeSector);

} else {
  LOG_DEBUG("Spur bereits gefunden und soll Fährte folgen");
};
