/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58327.gsc
***********************************************/

function ref_11d6a() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("motorcycle", "spawnCallback", &ref_11d6e);
  ref_11d6b();
  ref_11d6c();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("motorcycle", &_calloutmarkerping_poolidisentity::ref_11d5d);
}

function ref_11d6c() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("motorcycle", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function ref_11d6b() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("motorcycle", 1);
  var_0.frontextents = 45;
  var_0.backextents = 45;
  var_0.leftextents = 28;
  var_0.rightextents = 28;
  var_0.bottomextents = 15;
  var_0.distancetobottom = 30;
  var_0.loscheckoffset = (0, 0, 30);
}

function ref_11d6e(var_0, var_1) {
  var_2 = _calloutmarkerping_poolidisentity::ref_11d56(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &ref_11d6d;
  }

  return var_2;
}

function ref_11d6d() {
  thread ref_11d6f();
}

function ref_11d6f() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("motorcycle", var_1, var_2);
}