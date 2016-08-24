#include "defines.hpp"
private ["_sector", "_entities","_recognizedTargets","_nearestScent","_activeCheck", "_activeTarget", "_activeSector", "_baseSector", "_impact", "_hunterData"];
params ["_fncParams"]; //pfh params
_hunter = _fncParams select 0;
_targets = _fncParams select 1;

LOG_DEBUG(FORMAT_1("exec find for %1", _hunter));

_fnc_checkForValidTargets = {

  _recognizedTargets = [];
  _entities = GET_HASH(IVAR(SECTOR),_activeSector);

  if (count _entities > 0) exitWith {};

  //filter out all relevant targets
  {
    if (_x in _entities) then {
      _recognizedTargets pushBack _x;
    };
  } forEach _targets;

  //check nearby target in range
  {
    _activeTarget = _x;
    {
      _trace = (HASH_GET(IVAR(HOUNDED),_activeTarget) select 0) select _x;
      _dist = (_trace select 1) distance getPos _hunter;
      
      //impact == value how strong scent in relation to distance
      _impact = _dist - (_trace select 2) / GRAD_GUNDOG_IMPACT_SCENT;
      if ((_impact < (_nearestScent select 4)) && (_dist < GRAD_GUNDOG_MAX_RANGE)) then {
        _nearestScent = [_dist, _x, _activeTarget, _trace select 2, _impact, _trace select 1];
      };
      
    } forEach HASH_GET((HASH_GET(IVAR(HOUNDED),_x) select 1),_activeSector); //get all idx from target sector array 
  } forEach _recognizedTargets;
};

//end if dead
if (!(alive _hunter)) exitWith {
  //remove pfh
  [_hunter getVariable [QIVAR(PFH),-1]] call FNC_CBA(removePerFrameHandler);
};


/*
 check any target is in globalSector
*/

//distance, idx, target, power, factor, pos
_nearestScent = [9999, -1, objNull, 0, 9999];
_searchPos = getPos _hunter;
_baseSector = [_searchPos] call IFNC(getSector);
_activeSector = _baseSector;

[] call _fnc_checkForValidTargets;

//check nearby sectors if in range, BEWARE if max range > sector size !!!!!!!
{
  _activeSector = [_searchPos vectorAdd [_x select 0 * GRAD_GUNDOG_MAX_RANGE, _x select 1 * GRAD_GUNDOG_MAX_RANGE,0]] call IFNC(getSector);
  if (!(_activeSector isEqualTo _baseSector)) then {
    [] call _fnc_checkForValidTargets;
  };
} forEach [[-1,1],[1,1],[-1,-1],[1,-1]];

if (count _nearestScent == 0) exitWith { }; //nothing nearby

//valid scent found
// #TODO:0 add signal "scent found"

//move to, change pfh from find to follow
_hunter moveTo (_nearestScent select 5);
_hunter setVariable [QIVAR(FOLLOWING_NODE),_nearestScent select 5];

//replace pfh for follow trace
[_hunter getVariable [QIVAR(PFH),-1]] call FNC_CBA(removePerFrameHandler);
_pfhMarker = [IFNC(followScent), GRAD_GUNDOG_INITIAL_FOLLOW, [_hunter, _nearestScent select 2]] call FNC_CBA(addPerFrameHandler);
_hunter setVariable [QIVAR(PFH),_pfhMarker];


//bye