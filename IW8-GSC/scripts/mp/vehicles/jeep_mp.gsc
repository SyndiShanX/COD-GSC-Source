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
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("jeep", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function jeep_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("jeep", 1);
  var_0.frontextents = 98;
  var_0.backextents = 89;
  var_0.leftextents = 36;
  var_0.rightextents = 36;
  var_0.bottomextents = 23;
  var_0.distancetobottom = 38;
  var_0.loscheckoffset = (0, 0, 55);
}

function jeep_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\jeep::jeep_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &jeep_mp_ondeathrespawncallback;
  }

  return var_2;
}

function jeep_mp_ondeathrespawncallback() {
  thread jeep_mp_waitandspawn();
}

function jeep_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421C("jeep", var_1, var_2);
}