#include "defines.hpp"
private ["_chasePos","_activeSector","_dist","_nearest","_nearestIdx","_activeHauntingGround"];
params ["_chaser"];
// #TODO:0 timed loop CBA_fnc_addPerFrameHandler mit delay x

_chasePos = getPos _chaser;
_activeSector = [_chasePos] call FNC(getSector);
hint _activeSector;

if (!HASH_HAS_KEY(GRAD_GUNDOG_HUNTING_GROUND_2,_activeSector)) exitWith {
  LOG_DEBUG(FORMAT_1("no active hunting ground @ %1", _activeSector));
  -1;
};  //no one in sector

_activeHauntingGround = HASH_GET(GRAD_GUNDOG_HUNTING_GROUND,_activeSector);
_nearest = 9999;
_nearestIdx = -1;

LOG_DEBUG(FORMAT_1("active hunting ground @ %1", _activeHauntingGround));

{
  _dist = _chasePos distance ((GRAD_GUNDOG_TRACK select _x) select 1);

  if ((_dist < GRAD_GUNDOG_MAX_RANGE) && (_dist < _nearest)) then {
    _nearest = _dist;
    _nearestIdx = _x;
  };

} forEach _activeHauntingGround;

  LOG_DEBUG(FORMAT_2("nearest scent  %1 with idx %2", _nearest, _nearestIdx));
_nearestIdx;
