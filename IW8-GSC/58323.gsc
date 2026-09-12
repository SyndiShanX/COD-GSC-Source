/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58323.gsc
***********************************************/

function get_random_primary_weapon_obj() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp", "spawnCallback", &get_randomize_bomb_label_list);
  get_random_search_node();
  get_random_starting_station_name_on_track();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("cargo_truck_susp", &_calloutmarkerping_isenemy::get_power_ref_FROM_weapon);
}

function get_random_starting_station_name_on_track() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_susp", 1);
  var_0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function get_random_search_node() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("cargo_truck_susp", 1);
  var_0.frontextents = 165;
  var_0.backextents = 168;
  var_0.leftextents = 57;
  var_0.rightextents = 57;
  var_0.bottomextents = 35;
  var_0.distancetobottom = 50;
  var_0.loscheckoffset = (0, 0, 70);
}

function get_randomize_bomb_label_list(var_0, var_1) {
  var_2 = _calloutmarkerping_isenemy::get_players_in_mortar_range(var_0, var_1);

  if(isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var_2.ondeathrespawn = &get_random_station_names_on_track;
  }

  return var_2;
}

function get_random_station_names_on_track() {
  thread get_recent_spawn_time_threshold();
}

function get_recent_spawn_time_threshold() {
  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var_1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var_0, var_1);
  var_2 = spawnStruct();
  var_3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421C("cargo_truck_susp", var_1, var_2);
}