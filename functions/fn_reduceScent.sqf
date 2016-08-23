#include "defines.hpp"

// #TODO:1 Alle x sekunden scent wert (witterung) senken
// #CHECK:0 geht das, reduce scent by 1 ????


if ((isNil "GRAD_GUNDOG_TRACK") || (count GRAD_GUNDOG_TRACK < 1)) exitWith {LOG_ERR("downtick scent abort");};


//didnt work, return [<null>,<null>] :/
//GRAD_GUNDOG_TRACK = GRAD_GUNDOG_TRACK apply {_x set [2, ((_x select 2) - GRAD_GUNDOG_DECREASE_SCENT)]};


{
  if (count _x == 3) then {
    LOG_DEBUG(FORMAT_3("decrease scent from %1 with %2 by %3",_x select 0, _x select 2, GRAD_GUNDOG_DECREASE_SCENT));
    _x set [2,(_x select 2) - GRAD_GUNDOG_DECREASE_SCENT];
  } else {
    LOG_ERR("ERROR reduceScent, elements missmatch");
  };
} forEach GRAD_GUNDOG_TRACK;


if (DEBUG_ENABLE) then {
  {
      LOG_DEBUG(FORMAT_4("idx %1; Time %2, POS %3, Scent %4",  _forEachIndex, _x select 0, _x select 1, _x select 2));
  } forEach GRAD_GUNDOG_TRACK;
};
