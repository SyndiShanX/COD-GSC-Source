/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58323.gsc
***********************************************/

function get_random_primary_weapon_obj() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp", "spawnCallback", &get_randomize_bomb_label_list);
  get_random_search_node();
  get_random_starting_station_name_on_track();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("cargo_truck_susp", &_calloutmarkerping_isenemy::get_power_ref_from_weapon);
}

function get_random_starting_station_name_on_track() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_susp", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function get_random_search_node() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("cargo_truck_susp", 1);
  var0.frontextents = 165;
  var0.backextents = 168;
  var0.leftextents = 57;
  var0.rightextents = 57;
  var0.bottomextents = 35;
  var0.distancetobottom = 50;
  var0.loscheckoffset = (0, 0, 70);
}

function get_randomize_bomb_label_list(var0, var1) {
  var2 = _calloutmarkerping_isenemy::get_players_in_mortar_range(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &get_random_station_names_on_track;
  }

  return var2;
}

function get_random_station_names_on_track() {
  thread get_recent_spawn_time_threshold();
}

function get_recent_spawn_time_threshold() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("cargo_truck_susp", var1, var2);
}