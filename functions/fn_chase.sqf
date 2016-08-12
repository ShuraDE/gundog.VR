#include "defines.hpp"
private ["_chasePos","_activeSector","_dist","_nearest","_nearestIdx","_activeHauntingGround"];
params ["_chaser"];
// #TODO:0 timed loop CBA_fnc_addPerFrameHandler mit delay x

_chasePos = getPos _chaser;
_activeSector = [_chasePos] call FNC(getSector);
hint _activeSector;

if (!HASH_HAS_KEY(GRAD_GUNDOG_HUNTING_GROUND,_activeSector)) exitWith {
  diag_log FORMAT["no active hunting ground @ %1", _activeSector];
  -1;
};  //no one in sector

_activeHauntingGround = HASH_GET(GRAD_GUNDOG_HUNTING_GROUND,_activeSector);
_nearest = 9999;
_nearestIdx = -1;

diag_log FORMAT["active hunting ground @ %1", _activeHauntingGround];

{
  _dist = _chasePos distance ((GRAD_GUNDOG_TRACK select _x) select 1);

  if ((_dist < GRAD_GUNDOG_MAX_RANGE) && (_dist < _nearest)) then {
    _nearest = _dist;
    _nearestIdx = _x;
  };

} forEach _activeHauntingGround;


  diag_log FORMAT["nearest scent  %1 with idx %2", _nearest, _nearestIdx];
_nearestIdx;
