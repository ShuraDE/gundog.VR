#include "defines.hpp"
private ["_searchFromPos","_checkSector","_activeSector","_shortestIdx","_nearest","_dist"];
params ["_maxRange"];

_checkSector = {
  params ["_precision", "_hash"];

  _sector = [_searchFromPos, _precision] call FNC(getSector);
  //check entry exists
  if (HASH_HAS_KEY(_hash,_sector)) then {
    _activeSector = HASH_GET(_hash,_sector);
  } else {
    false;
  };

};

_searchFromPos = getPos GRAD_GUNDOG_CHASER;
_activeSector = objNull;
_nearest = 999999;
_nearestIdx = -1;

//set maxRange to default if not set
if (isNil "_maxRange") then {_maxRange = GRAD_GUNDOG_MAX_RANGE };

//aktuell keine aktive spur
if (!GRAD_GUNDOG_HAVE_SCENT) then {


  // #TODO:0 gefällt mir nicht
  if (GRAD_GUNDOG_SECTOR_1 && !isNil "GRAD_GUNDOG_HUNTING_GROUND_1") then {
    [1,GRAD_GUNDOG_HUNTING_GROUND_1] call _checkSector;
    //if (([1,GRAD_GUNDOG_HUNTING_GROUND_1] call _checkSector)==false) exitWith { false; };
  };
  if (GRAD_GUNDOG_SECTOR_2 && !isNil "GRAD_GUNDOG_HUNTING_GROUND_2") then {
    [2,GRAD_GUNDOG_HUNTING_GROUND_2] call _checkSector;
    //if (([2,GRAD_GUNDOG_HUNTING_GROUND_2] call _checkSector)==false) exitWith { false; };
  };
  if (GRAD_GUNDOG_SECTOR_3 && !isNil "GRAD_GUNDOG_HUNTING_GROUND_3") then {
    [3,GRAD_GUNDOG_HUNTING_GROUND_3] call _checkSector;
    //if (([3,GRAD_GUNDOG_HUNTING_GROUND_3] call _checkSector)==false) exitWith { false; };
  };

  if (_activeSector isEqualTo objNull ) exitWith {
    LOG_DEBUG(FORMAT_1("failed activeSector %1", _activeSector));

    // #TODO:0 look in neighbor sector if max distance is possible

    false;
  };

  {
    LOG_DEBUG(FORMAT_1("check %1",_x));

    _dist = _searchFromPos distance ((GRAD_GUNDOG_TRACK select _x) select 1);
    LOG_DEBUG(FORMAT_1("dist %1",_dist));

    if ((_dist < _maxRange) && (_dist < _nearest)) then {
      _nearest = _dist;
      _nearestIdx = _x;
    };

  } forEach _activeSector; //get all index from select sector

  LOG_DEBUG(FORMAT_2("found trace distance %1 @ %2",_nearest, _nearestIdx));
} else {
  // #TODO:1 handler
  LOG_DEBUG("Spur bereits gefunden und soll Fährte folgen");
};
