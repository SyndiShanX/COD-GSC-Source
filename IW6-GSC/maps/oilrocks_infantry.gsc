/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_infantry.gsc
**************************************/

start() {
  maps\oilrocks_infantry_code::infantry_teleport_start("infantry_player_start");
}

catchup_function() {
  thread objective();
  chopper_infantry_tweak();
  maps\oilrocks_infantry_code::init_color_helper_triggers();
  thread maps\oilrocks_proximity_spawned_vehicles::end();
  thread maps\oilrocks_proximity_spawned_ai::end();
  maps\oilrocks_apache_code::send_apaches_to_hangout("hangout_volume_infantry_a");
  bcs_on();
  level.player maps\_utility::vision_set_fog_changes("oilrocks_infantry", 0);
}

chopper_infantry_tweak() {
  var_0 = maps\oilrocks_apache_code::get_apache_allies();

  foreach(var_2 in var_0) {
    var_2 sethoverparams(70, 20, 10);
    var_2 maps\_chopperboss_utility::build_data_override("min_target_dist2d", 350);
  }
}

bcs_on() {
  thread maps\_utility::battlechatter_on();
  thread maps\_utility::set_team_bcvoice("allies", "delta");
}

main() {
  level.player maps\_utility::vision_set_fog_changes("oilrocks_infantry", 1);
  thread cleanup_at_landing_zone();
  maps\_utility::musicplaywrapper("mus_oilrocks_ground_battle");
  bcs_on();
  thread maps\oilrocks_proximity_spawned_vehicles::end();
  thread maps\oilrocks_proximity_spawned_ai::end();
  thread objective();
  thread dialog_on_deck();
  maps\oilrocks_infantry_code::init_color_helper_triggers();
  chopper_infantry_tweak();
  maps\oilrocks_apache_code::send_apaches_to_hangout("hangout_volume_infantry_a");
  maps\_utility::autosave_by_name();
  common_scripts\utility::flag_wait("infantry_a_traversed");
}

_precache() {
  common_scripts\utility::flag_init("infantry_a_traversed");
}

dialog_on_deck() {
  maps\_utility::smart_radio_dialogue("oilrocks_hp2_stalkerunitison");
  maps\_utility::smart_radio_dialogue("oilrocks_hp2_outlawtwoonegoingin");
  maps\_utility::smart_radio_dialogue("oilrocks_hp5_rogerthatcontinuescanning");
}

hide_start_createfx() {}

objective() {
  var_0 = maps\_utility::obj("find_rorke");
  objective_add(var_0, "active", &"OILROCKS_FIND_RORKE");
  objective_current(var_0);
}

cleanup_at_landing_zone() {
  maps\_utility::array_delete(getcorpsearray());

  foreach(var_1 in getEntArray("script_vehicle_corpse", "classname")) {
    if(distance(var_1.origin, level.player getEye()) > 10000)
      var_1 delete();
  }
}