/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\hoopty_mp.gsc
***********************************************/

hoopty_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_91CD07D045CF0B0BB8", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::hoopty_mp_spawncallback);
  hoopty_mp_initmines();
  hoopty_mp_initspawning();
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data("_encstr_91CD07D045CF0B0BB8", 6);
  scripts\mp\vehicles\damage::set_death_callback("_encstr_91CD07D045CF0B0BB8", scripts\cp_mp\vehicles\hoopty::hoopty_deathcallback);
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_91CD07D045CF0B0BB8", scripts\cp_mp\vehicles\hoopty::hoopty_explode);
}

hoopty_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_91CD07D045CF0B0BB8", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

hoopty_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_91CD07D045CF0B0BB8", 1);
  var_0.frontextents = 90;
  var_0.backextents = 115;
  var_0.leftextents = 38;
  var_0.rightextents = 38;
  var_0.bottomextents = 20;
  var_0.distancetobottom = 35;
  var_0.loscheckoffset = (0, 0, 37);
}

hoopty_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\hoopty::hoopty_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::hoopty_mp_ondeathrespawncallback;

  return var_2;
}

hoopty_mp_ondeathrespawncallback() {
  thread hoopty_mp_waitandspawn();
}

hoopty_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_91CD07D045CF0B0BB8", var_1, var_2);
}