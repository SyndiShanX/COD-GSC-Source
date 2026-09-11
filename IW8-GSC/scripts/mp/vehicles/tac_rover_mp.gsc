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
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("tac_rover", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function tacrover_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("tac_rover", 1);
  var0.frontextents = 90;
  var0.backextents = 115;
  var0.leftextents = 38;
  var0.rightextents = 38;
  var0.bottomextents = 20;
  var0.distancetobottom = 35;
  var0.loscheckoffset = (0, -8, 50);
}

function tac_rover_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &tac_rover_mp_ondeathrespawncallback;
  }

  return var2;
}

function tac_rover_mp_ondeathrespawncallback() {
  thread tac_rover_mp_waitandspawn();
}

function tac_rover_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("tac_rover", var1, var2);
}