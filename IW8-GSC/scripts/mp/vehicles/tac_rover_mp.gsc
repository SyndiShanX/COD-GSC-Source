/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\tac_rover_mp.gsc
************************************************/

function tac_rover_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("tac_rover", "spawnCallback", &tac_rover_mp_spawncallback);
  tacrover_mp_initmines();
  tac_rover_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("tac_rover", &scripts\cp_mp\vehicles\tac_rover::tac_rover_explode);
}

function tac_rover_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("tac_rover", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function tacrover_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("tac_rover", 1);
  var_0.frontextents = 90;
  var_0.backextents = 115;
  var_0.leftextents = 38;
  var_0.rightextents = 38;
  var_0.bottomextents = 20;
  var_0.distancetobottom = 35;
  var_0.loscheckoffset = (0, -8, 50);
}

function tac_rover_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &tac_rover_mp_ondeathrespawncallback;
  }

  return var_2;
}

function tac_rover_mp_ondeathrespawncallback() {
  thread tac_rover_mp_waitandspawn();
}

function tac_rover_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421C("tac_rover", var_1, var_2);
}