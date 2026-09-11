/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58329.gsc
***********************************************/

function ref_1210b() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("open_jeep", "spawnCallback", &ref_1210e);
  ref_12127();
  ref_1210c();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("open_jeep", &_calloutmarkerping_poolidisloot::ref_12100);
}

function ref_1210c() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("open_jeep", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function ref_12127() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("open_jeep", 1);
  var0.frontextents = 90;
  var0.backextents = 115;
  var0.leftextents = 38;
  var0.rightextents = 38;
  var0.bottomextents = 20;
  var0.distancetobottom = 35;
  var0.loscheckoffset = (0, -8, 50);
}

function ref_1210e(var0, var1) {
  var2 = _calloutmarkerping_poolidisloot::ref_120f9(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &ref_1210d;
  }

  return var2;
}

function ref_1210d() {
  thread ref_1210f();
}

function ref_1210f() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("open_jeep", var1, var2);
}