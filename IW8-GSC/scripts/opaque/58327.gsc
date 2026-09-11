/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58327.gsc
***********************************************/

function ref_11d6a() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("motorcycle", "spawnCallback", &ref_11d6e);
  ref_11d6b();
  ref_11d6c();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("motorcycle", &_calloutmarkerping_poolidisentity::ref_11d5d);
}

function ref_11d6c() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("motorcycle", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function ref_11d6b() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("motorcycle", 1);
  var0.frontextents = 45;
  var0.backextents = 45;
  var0.leftextents = 28;
  var0.rightextents = 28;
  var0.bottomextents = 15;
  var0.distancetobottom = 30;
  var0.loscheckoffset = (0, 0, 30);
}

function ref_11d6e(var0, var1) {
  var2 = _calloutmarkerping_poolidisentity::ref_11d56(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &ref_11d6d;
  }

  return var2;
}

function ref_11d6d() {
  thread ref_11d6f();
}

function ref_11d6f() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("motorcycle", var1, var2);
}