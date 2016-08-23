#include "defines.hpp"

private ["_entry","_time","_scentPower"];
params ["_target"];
//overkill speicherung (erstmal nur zum testen)
_entry = [];

//fix, 0-2 nicht mehr ändern!
_time = if (isServer && hasInterface) then { time } else { serverTime };
_scentPower = [_target] call IFNC(getIntensityScent);

//return null if there is no scent possible
if (_scentPower<=0) exitWith { objNull; };

//return new scent
_entry pushBack _time;                                //0 zeitstempel
_entry pushBack (getPos _target);                     //1 position der beute
_entry pushBack IVAR(INITIAL_SCENT) * _scentPower;    //2 initialler witterungswert * %

_entry;
