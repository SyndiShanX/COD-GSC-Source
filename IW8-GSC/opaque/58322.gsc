/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58322.gsc
***********************************************/

get_player_aggro_score() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::get_player_defusing_zone);
  get_player_array();
  get_player_closest_to_any_goal();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", _calloutmarkerping_iskiosk::get_num_dogtag_in_kill_zone_or_under_bridge_zone);
}

get_player_closest_to_any_goal() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

get_player_array() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", 1);
  var_0.frontextents = 165;
  var_0.backextents = 168;
  var_0.leftextents = 57;
  var_0.rightextents = 57;
  var_0.bottomextents = 35;
  var_0.distancetobottom = 50;
  var_0.loscheckoffset = (0, 0, 70);
}

get_player_defusing_zone(var_0, var_1) {
  var_2 = _calloutmarkerping_iskiosk::get_next_available_wire_for_bomb(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::get_player_cumulative_damage;

  return var_2;
}

get_player_cumulative_damage() {
  thread get_player_drone();
}

get_player_drone() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", var_1, var_2);
}