#include "defines.hpp"
params ["_hunter", "_newState"];

/*
#define GRAD_GUNDOG_ENUM_HUNTER_STATE_NONE 0;
#define GRAD_GUNDOG_ENUM_HUNTER_STATE_SEARCH 1;
#define GRAD_GUNDOG_ENUM_HUNTER_STATE_FOLLOW 2;
#define GRAD_GUNDOG_ENUM_HUNTER_STATE_SNIF 3;
#define GRAD_GUNDOG_ENUM_HUNTER_STATE_SIGHT 4;
*/

//dont do anything if equal
if ((_hunter getVariable [QIVAR(HUNTER_STATE), -1]) isEqualTo _newState) exitWith { };

_hunter setVariable [QIVAR(HUNTER_STATE), _newState];

//do some shit
_tmp = _hunter getVariable [QIVAR(HUNTER_STATE), GRAD_GUNDOG_ENUM_HUNTER_STATE_NONE];
LOG_DEBUG(FORMAT_2("Hunter %1 has changed state to %2", _hunter, _tmp));
