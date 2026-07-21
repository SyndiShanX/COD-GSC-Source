/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\tac_rover_mp.gsc
***********************************************/

tac_rover_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::tac_rover_mp_spawncallback);
  tacrover_mp_initmines();
  tac_rover_mp_initspawning();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_9A120A1D8536F5E4ED3BB293", scripts\cp_mp\vehicles\tac_rover::tac_rover_explode);
}

tac_rover_mp_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_9A120A1D8536F5E4ED3BB293", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

tacrover_mp_initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_9A120A1D8536F5E4ED3BB293", 1);
  var_0.frontextents = 90;
  var_0.backextents = 115;
  var_0.leftextents = 38;
  var_0.rightextents = 38;
  var_0.bottomextents = 20;
  var_0.distancetobottom = 35;
  var_0.loscheckoffset = (0, -8, 50);
}

tac_rover_mp_spawncallback(var_0, var_1) {
  var_2 = scripts\cp_mp\vehicles\tac_rover::tac_rover_create(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::tac_rover_mp_ondeathrespawncallback;

  return var_2;
}

tac_rover_mp_ondeathrespawncallback() {
  thread tac_rover_mp_waitandspawn();
}

tac_rover_mp_waitandspawn() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_9A120A1D8536F5E4ED3BB293", var_1, var_2);
}