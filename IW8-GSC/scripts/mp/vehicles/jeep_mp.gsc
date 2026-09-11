/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\jeep_mp.gsc
***********************************************/

function jeep_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("jeep", "spawnCallback", &jeep_mp_spawncallback);
  jeep_mp_initmines();
  jeep_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("jeep", &scripts\cp_mp\vehicles\jeep::jeep_explode);
}

function jeep_mp_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("jeep", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function jeep_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("jeep", 1);
  var0.frontextents = 98;
  var0.backextents = 89;
  var0.leftextents = 36;
  var0.rightextents = 36;
  var0.bottomextents = 23;
  var0.distancetobottom = 38;
  var0.loscheckoffset = (0, 0, 55);
}

function jeep_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\jeep::jeep_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &jeep_mp_ondeathrespawncallback;
  }

  return var2;
}

function jeep_mp_ondeathrespawncallback() {
  thread jeep_mp_waitandspawn();
}

function jeep_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("jeep", var1, var2);
}