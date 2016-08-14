#include "defines.hpp"

private ["_idx", "_previous", "_sector","_scent","_newMarker","_debug","_pos","_oldValue","_newValue"];

/*
variablen

GRAD_GUNDOG_TARGET = Beute
GRAD_GUNDOG_TRACK = array aller positionen vom target
GRAD_GUNDOG_HUNTING_GROUND = areale / sektoren mit markern, syntax [x ersten 3 stellen, y ersten 3 stellen, 0|1 rechter/linker bereich, 0|1 unterer/oberer bereich
        (z.B.  123 033 1 0 steht für den breich 1235/0330 bis 1239/0334)
*/

//check are really ready
if (isNil "GRAD_GUNDOG_TRACK") then {GRAD_GUNDOG_TRACK = []; };
//if (!HASH_IS_HASH(GRAD_GUNDOG_HUNTING_GROUND)) then { GRAD_GUNDOG_HUNTING_GROUND = HASH_CREATE; };

// #TODO:0 Alle X sekunden neue spur anfügen  CBA_fnc_addPerFrameHandler mit delay x
_scent = [] call FNC(intensityScent);
_newMarker = [] call FNC(newScent);


LOG_DEBUG(FORMAT_2("new marker %1 %2",  _scent, _newMarker));

if (_scent > 0) then {
  //add scent to track
  _idx = GRAD_GUNDOG_TRACK pushBack (_newMarker);

  //append reference to sector
  [_idx] call FNC(newSector);

  //debug
  if (DEBUG_ENABLE) then {
    _pos = (GRAD_GUNDOG_TRACK select _idx) select 1;
    _debug = "Sign_Pointer_F" createVehicleLocal _pos;
    _debug setDir (getDir GRAD_GUNDOG_TARGET);
    _debug setVariable ["IDX", _idx];
    _debug setVariable ["OBJ", (GRAD_GUNDOG_TRACK select _idx)];
  };

} else {
  LOG_DEBUG(FORMAT_1("ignore SCENT : %1", GRAD_GUNDOG_TRACK select _idx));
};
