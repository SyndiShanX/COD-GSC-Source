/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58329.gsc
***********************************************/

function ref_1210B() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep", "spawnCallback", &ref_1210E);
  ref_12127();
  ref_1210C();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("open_jeep", &_calloutmarkerping_poolidisloot::ref_12100);
}

function ref_1210C() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("open_jeep", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function ref_12127() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("open_jeep", 1);
  var_0.frontextents = 90;
  var_0.backextents = 115;
  var_0.leftextents = 38;
  var_0.rightextents = 38;
  var_0.bottomextents = 20;
  var_0.distancetobottom = 35;
  var_0.loscheckoffset = (0, -8, 50);
}

function ref_1210E(var_0, var_1) {
  var_2 = _calloutmarkerping_poolidisloot::ref_120F9(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &ref_1210D;
  }

  return var_2;
}

function ref_1210D() {
  thread ref_1210F();
}

function ref_1210F() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421C("open_jeep", var_1, var_2);
}