#include "defines.hpp"

params ["_fncParams"]; //pfh params
_hunter = _fncParams select 0;
_target = _fncParams select 1;


LOG_DEBUG(FORMAT_2("follow %1 as %2", _target, _hunter));


//end if dead
if (!(alive _hunter)) exitWith {
  //remove pfh
  [_hunter getVariable [QIVAR(PFH),-1]] call FNC_CBA(removePerFrameHandler);
  _hunter setVariable [QIVAR(PFH),-1];
};

//if target ist nearby, head directly to target
if (getPos _hunter distance getPos _target < GRAD_GUNDOG_MAX_RANGE) exitWith {
  _hunter moveTo getPos _target;
  // #TODO:0  hunt target signal
  _hunter setVariable [QIVAR(HUNTER_STATE), GRAD_GUNDOG_ENUM_HUNTER_STATE_SNIF];
  _hunter getVariable [QIVAR(FOLLOWING_POS), getPos _target];
  _hunter getVariable [QIVAR(FOLLOWING_IDX), -1];
}


//wait until hunter is nearby last active scent
if ((getPos _hunter distance _hunter getVariable [QIVAR(FOLLOWING_POS),[999,999,999]]) < GRAD_GUNDOG_FOLLOW_PRECISION) exitWith { };

//append this to vistied scents
if (_hunter getVariable [QIVAR(FOLLOWING_IDX), -1] != -1) then {
  _hunter setVariable [QIVAR(VISITED_NODES), (_hunter getVariable [QIVAR(VISITED_NODES),-1] pushBack _hunter getVariable [QIVAR(FOLLOWING_IDX), -1])]
};


/*
//if trace is found, follow trace 
  + with waypoints ?
  + bypass scents in route
  
//lost if every node (with enough intensity) is visited 
*/


//remove  nothing to do here atm
LOG_DEBUG(FORMAT_2("WIP followScent",_hunter,_target));
[_hunter getVariable [QIVAR(PFH),-1]] call FNC_CBA(removePerFrameHandler);
_hunter setVariable [QIVAR(PFH),-1];

