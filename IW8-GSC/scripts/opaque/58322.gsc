/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58322.gsc
***********************************************/

function get_player_aggro_score() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("cargo_truck_susp_aa", "spawnCallback", &get_player_defusing_zone);
  get_player_array();
  get_player_closest_to_any_goal();
  scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback("cargo_truck_susp_aa", &_calloutmarkerping_iskiosk::get_num_dogtag_in_kill_zone_or_under_bridge_zone);
}

function get_player_closest_to_any_goal() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("cargo_truck_susp_aa", 1);
  var0.arenavday = &scripts\cp_mp\vehicles\vehicle_spawn::ref_14211;
}

function get_player_array() {
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("cargo_truck_susp_aa", 1);
  var0.frontextents = 165;
  var0.backextents = 168;
  var0.leftextents = 57;
  var0.rightextents = 57;
  var0.bottomextents = 35;
  var0.distancetobottom = 50;
  var0.loscheckoffset = (0, 0, 70);
}

function get_player_defusing_zone(var0, var1) {
  var2 = _calloutmarkerping_iskiosk::get_next_available_wire_for_bomb(var0, var1);

  if(isDefined(var2) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn()) {
    var2.ondeathrespawn = &get_player_cumulative_damage;
  }

  return var2;
}

function get_player_cumulative_damage() {
  thread get_player_drone();
}

function get_player_drone() {
  var0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);
  var1 = spawnStruct();
  scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata(var0, var1);
  var2 = spawnStruct();
  var3 = scripts\cp_mp\vehicles\vehicle_spawn::ref_1421c("cargo_truck_susp_aa", var1, var2);
}