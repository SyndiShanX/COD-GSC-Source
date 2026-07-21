/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58323.gsc
***********************************************/

get_random_primary_weapon_obj() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784", ::get_randomize_bomb_label_list);
  get_random_search_node();
  get_random_starting_station_name_on_track();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", _calloutmarkerping_isenemy::get_power_ref_from_weapon);
}

get_random_starting_station_name_on_track() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", 1);
  var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

get_random_search_node() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", 1);
  var_0.frontextents = 165;
  var_0.backextents = 168;
  var_0.leftextents = 57;
  var_0.rightextents = 57;
  var_0.bottomextents = 35;
  var_0.distancetobottom = 50;
  var_0.loscheckoffset = (0, 0, 70);
}

get_randomize_bomb_label_list(var_0, var_1) {
  var_2 = _calloutmarkerping_isenemy::get_players_in_mortar_range(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn())
    var_2.ondeathrespawn = ::get_random_station_names_on_track;

  return var_2;
}

get_random_station_names_on_track() {
  thread get_recent_spawn_time_threshold();
}

get_recent_spawn_time_threshold() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", var_1, var_2);
}