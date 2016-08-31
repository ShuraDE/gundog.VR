#include "defines.hpp"
params ["_hunter"];

_fncResetPFH = {
  //remove pfh
  [_hunter getVariable [QIVAR(PFH),-1]] call FNC_CBA(removePerFrameHandler);
  _hunter setVariable [QIVAR(PFH),-1];
};

/*
 * PreChecks
 */

//end if dead
if (!(alive _hunter)) exitWith {
  [] call _fncResetPFH;
  false;
};

//end search if state is NONE
if (_hunter getVariable QIVAR(HUNTER_STATE) isEqualTo GRAD_GUNDOG_ENUM_HUNTER_STATE_NONE) exitWith {
  [] call _fncResetPFH;
  false;
};

true;
