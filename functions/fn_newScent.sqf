#include "defines.hpp"

private ["_entry","_modX","_modY","_time","_scentPower"];
//overkill speicherung (erstmal nur zum testen)
_entry = [];

//fix, 0-2 nicht mehr ändern!
_time = if (isServer && hasInterface) then { time } else { serverTime };
_scentPower = [] call FNC(intensityScent);

_entry pushBack _time;                                        //0 zeitstempel
_entry pushBack (getPos GRAD_GUNDOG_TARGET);                  //1 position der beute
_entry pushBack GRAD_GUNDOG_INITIAL_SCENT * _scentPower;                  //2 initialler witterungswert * %

_entry;
