#include "defines.hpp"

private ["_x","_y", "_getRasterCoord"];
params ["_pos"];

_getRasterCoord = {
  private ["_raster","_sector"];
  params ["_coord"];

  _sector = _coord mod 10;
  _raster = _coord - _sector;  //ausgabe des quadrates auf 3 stelle genau, statt 1234 nur 1230

  //rückgabe ob untere bzw rechter sektor im quadrat betroffen oder oberer / linker  0|1
  _sector = round (_sector / 10);
  [_raster,_sector];
};


_x = [_pos select 0] call _getRasterCoord;
_y = [_pos select 1] call _getRasterCoord;

//diag_log format["RASTER   %1%2_%3%4", _x select 0, _y select 1, _x select 1, _y select 1];

format["%1%2_%3%4", _x select 0, _y select 1, _x select 1, _y select 1];
