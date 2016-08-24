#include "defines.hpp"

params ["_fncParams"]; //pfh params
_hunter = _fncParams select 0;
_target = _fncParams select 1;


LOG_DEBUG(FORMAT_2("follow %1 with %2", _target, _hunter));


//end if dead
if (!(alive _hunter)) exitWith {
  //remove pfh
  [_hunter getVariable [QIVAR(PFH),-1]] call FNC_CBA(removePerFrameHandler);
  _hunter setVariable [QIVAR(PFH),-1];
};

//if target ist nearby, head directly to target (has
if ((getPos _hunter distance getPos _target) < GRAD_GUNDOG_DIRECT_CONTACT_RANGE) exitWith {
  LOG_DEBUG(FORMAT_2("doFollow %1 as %2", _target, _hunter));
  [_hunter] joinSilent (group _target);
  _hunter doFollow _target;
  _hunter setVariable [QIVAR(HUNTER_STATE), GRAD_GUNDOG_ENUM_HUNTER_STATE_SNIF];
  _hunter getVariable [QIVAR(FOLLOWING_POS), getPos _target];
  _hunter getVariable [QIVAR(FOLLOWING_IDX), -1];
};


//wait until hunter is nearby last active scent
_tmp_dist = (getPos _hunter) distance (_hunter getVariable [QIVAR(FOLLOWING_POS),[0,0,100]]);
if (_tmp_dist < GRAD_GUNDOG_FOLLOW_PRECISION) exitWith {
  _tmp_1 = _hunter getVariable [QIVAR(FOLLOWING_IDX), -1];
  _tmp_2 = _hunter getVariable [QIVAR(FOLLOWING_POS), -1];
  LOG_DEBUG(FORMAT_2("heading to scent %1 @ %2", _tmp_1, _tmp_2));
};

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


//remove  follow script not done yet
LOG_DEBUG(FORMAT_2("WIP followScent",_hunter,_target));
[_hunter getVariable [QIVAR(PFH),-1]] call FNC_CBA(removePerFrameHandler);
_hunter setVariable [QIVAR(PFH),-1];
