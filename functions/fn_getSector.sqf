#include "defines.hpp"

private ["_x","_y", "_getRasterCoord"];
params ["_pos","_precision"];

_getRasterCoord = {
  private ["_raster","_sector","_i"];
  params ["_coord"];

  _sector = _coord mod 10;
  _raster = _coord - _sector;  //ausgabe des quadrates auf 3. stelle genau, statt 1234 nur 1230

  //rückgabe ob untere bzw rechter sektor im quadrat betroffen oder oberer / linker  0|1
  _sector = round (_sector / 10);
  [_raster,_sector];
};

_x = [_pos select 0] call _getRasterCoord;
_y = [_pos select 1] call _getRasterCoord;


//diag_log format["RASTER   %1%2_%3%4", _x select 0, _y select 1, _x select 1, _y select 1];

if (isNil "_precision") exitWith {
  _ret = format["%1%2_%3%4", _x select 0, _y select 0, _x select 1, _y select 1];
  LOG_TRACE(FORMAT_2("request sector data for pos %1, return sector %2 ",  _pos, _ret));
  _ret;
};

_ret = format["%1%2_%3%4", [str (_x select 0) , 0, _precision] call FNC_BIS(trimString) ,[str (_y select 0) , 0, _precision] call FNC_BIS(trimString), _x select 1, _y select 1];
LOG_TRACE(FORMAT_3("request sector data for pos %1 with precision %2, return sector %3",  _pos, _precision, _ret));
_ret;
