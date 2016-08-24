#include "defines.hpp"
params ["_hunter"];
//PVEH call if value QIVAR(HUNTER_STATE)  variable  is changed
/*
#define GRAD_GUNDOG_ENUM_HUNTER_STATE_NONE 0;
#define GRAD_GUNDOG_ENUM_HUNTER_STATE_SEARCH 1;
#define GRAD_GUNDOG_ENUM_HUNTER_STATE_FOLLOW 2;
#define GRAD_GUNDOG_ENUM_HUNTER_STATE_SNIF 3;
#define GRAD_GUNDOG_ENUM_HUNTER_STATE_SIGHT 4;
*/

LOG_DEBUG(FORMAT_1("whats up here ? %1", _hunter));
//LOG_DEBUG(FORMAT_2("Hunter %1 has changed state to %2", _hunter, (_hunter getVariable[QIVAR(HUNTER_STATE),GRAD_GUNDOG_ENUM_HUNTER_STATE_NONE])));
