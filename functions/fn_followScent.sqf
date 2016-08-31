#include "defines.hpp"

params ["_fncParams"]; //pfh params
_hunter = _fncParams select 0;
_target = _fncParams select 1;


LOG_DEBUG(FORMAT_2("follow %1 as %2", _target, _hunter));

//check hunter can continue
if (!([_hunter] call IFNC(checkHunter))) exitWith {};


if (lineIntersects [ eyePos _hunter, getPosASL _target, _hunter, _target]) exitWith {
  [_hunter, GRAD_GUNDOG_ENUM_HUNTER_STATE_SIGHT] call IFNC(hunterStateChange);
  _hunter moveTo (getPos _target);
  _hunter setVariable [QIVAR(FOLLOWING_POS), getPos _target];
  _hunter setVariable [QIVAR(FOLLOWING_IDX), -1];
};

//if target ist nearby, head directly to target (has
if (((getPos _hunter) distance (getPos _target)) < GRAD_GUNDOG_DIRECT_CONTACT_RANGE) exitWith {
  //doFollow didnt work without group up
  _hunter moveTo getPos _target;
  //_hunter setVariable [QIVAR(HUNTER_STATE), GRAD_GUNDOG_ENUM_HUNTER_STATE_SNIF];
  [_hunter, GRAD_GUNDOG_ENUM_HUNTER_STATE_SNIF] call IFNC(hunterStateChange);
  _hunter setVariable [QIVAR(FOLLOWING_POS), getPos _target];
  _hunter setVariable [QIVAR(FOLLOWING_IDX), -1];
};


//wait until hunter is nearby last active scent
if (((getPos _hunter) distance (_hunter getVariable [QIVAR(FOLLOWING_POS),[0,0,999]])) < GRAD_GUNDOG_FOLLOW_PRECISION) exitWith {
  _tmp_1 = _hunter getVariable [QIVAR(FOLLOWING_IDX), -1];
  _tmp_2 = _hunter getVariable [QIVAR(FOLLOWING_POS),[0,0,999]];
  LOG_DEBUG(FORMAT_2("heading to scent %1 @ %2", _tmp_1, _tmp_2));
};

//append this to visted nodes
if (_hunter getVariable [QIVAR(FOLLOWING_IDX), -1] != -1) then {
  _hunter setVariable [QIVAR(VISITED_NODES), (_hunter getVariable [QIVAR(VISITED_NODES),[]] pushBack _hunter getVariable [QIVAR(FOLLOWING_IDX), -1])]
};


/*
//if trace is found, follow trace
  + with waypoints ?
  + bypass scents in route

//lost if every node (with enough intensity) is visited
*/

// ????
//follow stupid each node or optimize search by nearst x nodes and research after  ???
// ????


//remove  follow script, it's not done yet
LOG_DEBUG(FORMAT_2("WIP followScent",_hunter,_target));
[_hunter getVariable [QIVAR(PFH),-1]] call FNC_CBA(removePerFrameHandler);
_hunter setVariable [QIVAR(PFH),-1];
