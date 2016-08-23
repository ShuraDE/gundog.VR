#include "defines.hpp"

private ["_idx", "_newMarker","_debug","_pos"];
params ["_houndedTarget", "_traces", "_sectors"];


//generate new marker
_newMarker = [_houndedTarget] call IFNC(newScent);

//if there is no marker, exit
if (_newMarker isEqualTo objNull) exitWith {
  LOG_DEBUG(FORMAT_1("no valid marker, scent level %1 @ pos %2", [_houndedTarget] call IFNC(getIntensityScent), getPos _houndedTarget));
}; 

LOG_DEBUG(FORMAT_2("new marker %1 @ grid %2",_newMarker, mapGridPosition (_newMarker select 1)));


//append new marker to route 
_idx = _traces pushBack (_newMarker);
//append reference to sector
[_idx, _newMarker select 1, _sectors] call IFNC(applySector);



//debug
if (DEBUG_ENABLE) then {
  _pos = (_traces select _idx) select 1;
  _debug = "Sign_Pointer_F" createVehicleLocal _pos;
  _debug setDir (getDir _houndedTarget);
  _debug setVariable ["IDX", _idx];
  _debug setVariable ["OBJ", (_traces select _idx)];
};