/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58328.gsc
***********************************************/

function ref_120DC() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep_carpoc", "spawnCallback", &ref_120E0);
  ref_120DD();
  ref_120DE();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("open_jeep_carpoc", &_calloutmarkerping_predicted_isanypingactive::ref_120CB);
}

function ref_120DE() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("open_jeep_carpoc", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function ref_120DD() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("open_jeep_carpoc", 1);
  var_0.frontextents = 98;
  var_0.backextents = 89;
  var_0.leftextents = 36;
  var_0.rightextents = 36;
  var_0.bottomextents = 23;
  var_0.distancetobottom = 38;
  var_0.loscheckoffset = (0, 0, 55);
}

function ref_120E0(var_0, var_1) {
  var_2 = _calloutmarkerping_predicted_isanypingactive::ref_120C1(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &ref_120DF;
  }

  return var_2;
}

function ref_120DF() {
  thread ref_120E1();
}

function ref_120E1() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421C("open_jeep_carpoc", var_1, var_2);
}