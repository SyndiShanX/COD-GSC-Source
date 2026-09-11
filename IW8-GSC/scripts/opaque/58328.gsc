/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58328.gsc
***********************************************/

function ref_120dc() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep_carpoc", "spawnCallback", &ref_120e0);
  ref_120dd();
  ref_120de();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("open_jeep_carpoc", &_calloutmarkerping_predicted_isanypingactive::ref_120cb);
}

function ref_120de() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("open_jeep_carpoc", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function ref_120dd() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("open_jeep_carpoc", 1);
  var0.frontextents = 98;
  var0.backextents = 89;
  var0.leftextents = 36;
  var0.rightextents = 36;
  var0.bottomextents = 23;
  var0.distancetobottom = 38;
  var0.loscheckoffset = (0, 0, 55);
}

function ref_120e0(var0, var1) {
  var2 = _calloutmarkerping_predicted_isanypingactive::ref_120c1(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &ref_120df;
  }

  return var2;
}

function ref_120df() {
  thread ref_120e1();
}

function ref_120e1() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("open_jeep_carpoc", var1, var2);
}