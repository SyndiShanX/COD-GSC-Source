/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\hoopty_mp.gsc
***********************************************/

function hoopty_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("hoopty", "spawnCallback", &hoopty_mp_spawncallback);
  hoopty_mp_initmines();
  hoopty_mp_initspawning();
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data("hoopty", 6);
  scripts\mp\vehicles\damage::set_death_callback("hoopty", &scripts\cp_mp\vehicles\hoopty::hoopty_deathcallback);
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("hoopty", &scripts\cp_mp\vehicles\hoopty::hoopty_explode);
}

function hoopty_mp_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("hoopty", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function hoopty_mp_initmines() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("hoopty", 1);
  var0.frontextents = 90;
  var0.backextents = 115;
  var0.leftextents = 38;
  var0.rightextents = 38;
  var0.bottomextents = 20;
  var0.distancetobottom = 35;
  var0.loscheckoffset = (0, 0, 37);
}

function hoopty_mp_spawncallback(var0, var1) {
  var2 = scripts\cp_mp\vehicles\hoopty::hoopty_create(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &hoopty_mp_ondeathrespawncallback;
  }

  return var2;
}

function hoopty_mp_ondeathrespawncallback() {
  thread hoopty_mp_waitandspawn();
}

function hoopty_mp_waitandspawn() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("hoopty", var1, var2);
}