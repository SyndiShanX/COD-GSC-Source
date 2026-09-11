/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\atv_mp.gsc
***********************************************/

function atv_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("atv", "spawnCallback", &atv_mp_spawncallback);
  atv_mp_initmines();
  atv_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("atv", &scripts\cp_mp\vehicles\atv::atv_explode);
}

function atv_mp_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("atv", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function atv_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("atv", 1);
  var0.frontextents = 45;
  var0.backextents = 45;
  var0.leftextents = 28;
  var0.rightextents = 28;
  var0.bottomextents = 15;
  var0.distancetobottom = 30;
  var0.loscheckoffset = (0, 0, 30);
}

function atv_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\atv::atv_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &atv_mp_ondeathrespawncallback;
  }

  return var2;
}

function atv_mp_ondeathrespawncallback() {
  thread atv_mp_waitandspawn();
}

function atv_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("atv", var1, var2);
}