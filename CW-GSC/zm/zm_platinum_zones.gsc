/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_platinum_zones.gsc
***********************************************/

#using script_2f560596a9a134ab;
#using script_4ce5d94e8c797350;
#using script_5b190e6124417f5a;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\rappel;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\zipline_player;
#using scripts\zm\zm_platinum;
#using scripts\zm_common\zm_hud;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_platinum_zones;

function autoexec init() {
  callback::on_spawned(&function_44b1279a);
  level.var_28a7d418 = ["zone_american_sector_street", "zone_american_sector_right_building", "zone_american_sector_left_building"];
  level.var_57c0b4c1 = ["zone_american_sector_street", "zone_american_sector_right_building", "zone_american_sector_left_building", "zone_no_mans_land_1", "zone_no_mans_land_2", "zone_no_mans_land_3", "zone_sewers_and_escape_tunnel", "zone_secret_spy_tunnel", "zone_power_substation"];
  level.var_27028b8e = &function_27028b8e;
  level.var_aa3b88c5 = &function_27028b8e;
  level.var_662dc783 = &function_6e486b1;
}

function zone_init() {
  level flag::set("always_on");
  zm_zonemgr::zone_init("zone_rooftops_start");
  zm_zonemgr::zone_init("zone_destroyed_upper_floors");
  zm_zonemgr::zone_init("zone_american_sector_street");
  zm_zonemgr::zone_init("zone_american_sector_right_building");
  zm_zonemgr::zone_init("zone_american_sector_left_building");
  zm_zonemgr::zone_init("zone_no_mans_land_1");
  zm_zonemgr::zone_init("zone_bunny_club");
  zm_zonemgr::enable_zone("zone_rooftops_start");
  zm_zonemgr::add_adjacent_zone("zone_rooftops_start", "zone_rooftops_interior", "always_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_hotel_1", "zone_east_berlin_hotel_2", "connect_rooftops_interior_to_east_berlin_hotel", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_hotel_1", "zone_korber_roof", "connect_east_berlin_hotel_to_korber_roof", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_hotel_3", "zone_hotel_jack_room", "connect_east_berlin_hotel_to_jack_room", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_hotel_1", "zone_east_berlin_hotel_2", "connect_hotel_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_hotel_2", "zone_east_berlin_hotel_3", "connect_hotel_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_hotel_3", "zone_east_berlin_hotel_4", "connect_hotel_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_hotel_1", "zone_east_berlin_hotel_4", "connect_hotel_zone", 0);
  zm_zonemgr::add_zone_flags("connect_east_berlin_hotel_to_korber_roof", "connect_hotel_zone");
  zm_zonemgr::add_zone_flags("connect_rooftops_interior_to_east_berlin_hotel", "connect_hotel_zone");
  zm_zonemgr::add_adjacent_zone("zone_korber_sewing_room", "zone_korber_stairs", "connect_korber_roof_to_korber_interior", 0);
  zm_zonemgr::add_adjacent_zone("zone_korber_roof", "zone_korber_roof2", "enable_korber_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_korber_roof", "zone_korber_sewing_room", "enable_korber_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_korber_roof2", "zone_korber_sewing_room", "enable_korber_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_korber_stairs", "zone_east_berlin_street_alley", "connect_korber_roof_to_korber_interior", 0);
  zm_zonemgr::add_zone_flags("connect_east_berlin_hotel_to_korber_roof", "enable_korber_zone");
  zm_zonemgr::add_zone_flags("connect_korber_roof_to_korber_interior", "enable_korber_zone");
  zm_zonemgr::add_adjacent_zone("zone_destroyed_upper_floors", "zone_destroyed_upper_floors2", "enable_destroyed_upper_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_destroyed_upper_floors", "zone_destroyed_upper_room", "enable_destroyed_upper_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_destroyed_upper_floors2", "zone_destroyed_upper_room", "enable_destroyed_upper_zone", 0);
  zm_zonemgr::add_zone_flags("power_on", "enable_destroyed_upper_zone");
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_street_alley", "zone_east_berlin_street_1", "connect_east_berlin_street_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_street_1", "zone_east_berlin_street_2", "connect_east_berlin_street_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_street_1", "zone_east_berlin_street_3", "connect_east_berlin_street_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_street_1", "zone_east_berlin_street_4", "connect_east_berlin_street_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_street_2", "zone_bar", "connect_east_berlin_street_zone", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_street_3", "zone_bar", "connect_east_berlin_street_zone", 0);
  zm_zonemgr::add_zone_flags("connect_korber_roof_to_korber_interior", "connect_east_berlin_street_zone");
  zm_zonemgr::add_adjacent_zone("zone_bar", "zone_electronics_store", "connect_korber_roof_to_korber_interior", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_street_3", "zone_electronics_store", "connect_korber_roof_to_korber_interior", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_street_1", "zone_market", "power_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_street_3", "zone_market", "power_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_east_berlin_street_3", "zone_ghost_station_stairs", "connect_east_berlin_street_to_ghost_station", 0);
  zm_zonemgr::add_adjacent_zone("zone_ghost_station_3", "zone_basement_2", "connect_east_berlin_street_to_ghost_station2", 0);
  zm_zonemgr::add_adjacent_zone("zone_basement_1", "zone_basement_2", "connect_east_berlin_street_to_ghost_station2", 0);
  zm_zonemgr::add_adjacent_zone("zone_ghost_station_4", "zone_sewers_and_escape_tunnel", "connect_ghost_station_to_sewers_and_escape_tunnel", 0);
  zm_zonemgr::add_adjacent_zone("zone_ghost_station", "zone_ghost_station_stairs", "connect_east_berlin_street_to_ghost_station", 0);
  zm_zonemgr::add_adjacent_zone("zone_ghost_station", "zone_ghost_station_2", "connect_ghost_station", 0);
  zm_zonemgr::add_adjacent_zone("zone_ghost_station", "zone_ghost_station_3", "connect_ghost_station", 0);
  zm_zonemgr::add_adjacent_zone("zone_ghost_station_2", "zone_ghost_station_4", "connect_ghost_station", 0);
  zm_zonemgr::add_adjacent_zone("zone_ghost_station_3", "zone_ghost_station_4", "connect_ghost_station", 0);
  zm_zonemgr::add_zone_flags("connect_east_berlin_street_to_ghost_station", "connect_ghost_station");
  zm_zonemgr::add_zone_flags("connect_ghost_station_to_sewers_and_escape_tunnel", "connect_ghost_station");
  zm_zonemgr::add_zone_flags("connect_east_berlin_street_to_ghost_station2", "connect_ghost_station");
  zm_zonemgr::add_zone_flags("connect_ghost_station_to_secret_spy_tunnel", "connect_ghost_station");
  zm_zonemgr::add_adjacent_zone("zone_secret_spy_tunnel", "zone_power_substation2", "connect_secret_spy_tunnel_to_power_substation", 0);
  zm_zonemgr::add_adjacent_zone("zone_sewers_stairs", "zone_power_substation", "connect_sewers_and_escape_tunnel_to_power_substation", 0);
  zm_zonemgr::add_adjacent_zone("zone_sewers_and_escape_tunnel", "zone_sewers_stairs", "connect_sewers_and_escape_tunnel_to_power_substation", 0);
  zm_zonemgr::add_adjacent_zone("zone_power_substation", "zone_power_substation2", "connect_power_substation", 0);
  zm_zonemgr::add_zone_flags("connect_secret_spy_tunnel_to_power_substation", "connect_power_substation");
  zm_zonemgr::add_zone_flags("connect_sewers_and_escape_tunnel_to_power_substation", "connect_power_substation");
  zm_zonemgr::add_adjacent_zone("zone_ghost_station_2", "zone_control_room", "connect_ghost_station_to_secret_spy_tunnel", 0);
  zm_zonemgr::add_adjacent_zone("zone_control_room", "zone_secret_spy_tunnel", "connect_spy_tunnel", 0);
  zm_zonemgr::add_adjacent_zone("zone_secret_spy_tunnel", "zone_safe_house", "connect_spy_tunnel", 0);
  zm_zonemgr::add_zone_flags("connect_secret_spy_tunnel_to_power_substation", "connect_spy_tunnel");
  zm_zonemgr::add_zone_flags("connect_ghost_station_to_secret_spy_tunnel", "connect_spy_tunnel");
  zm_zonemgr::add_adjacent_zone("zone_sewers_and_escape_tunnel2", "zone_sewers_and_escape_tunnel", "connect_sewers", 0);
  zm_zonemgr::add_adjacent_zone("zone_sewers_and_escape_tunnel2", "zone_hidden_lab", "connect_sewers_and_power_substation_to_hidden_lab", 0);
  zm_zonemgr::add_zone_flags("connect_ghost_station_to_sewers_and_escape_tunnel", "connect_sewers");
  zm_zonemgr::add_zone_flags("connect_sewers_and_escape_tunnel_to_power_substation", "connect_sewers");
  zm_zonemgr::add_adjacent_zone("zone_american_sector_street", "zone_no_mans_land_1", "power_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_no_mans_land_1", "zone_no_mans_land_2", "power_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_no_mans_land_1", "zone_no_mans_land_3", "power_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_american_sector_street", "zone_american_sector_right_building", "power_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_american_sector_street", "zone_american_sector_left_building", "power_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_no_mans_land_1", "zone_east_berlin_street_4", "connect_no_mans_land_to_east_berlin_street", 0);
  level clientfield::set("" + # "hash_2971ea22ea5a646a", 1);
  scene::add_scene_func(#"p9_fxanim_zm_platinum_zipline_bundle", &function_f63d1381, "init");
  scene::add_scene_func(#"p9_fxanim_zm_platinum_rappel_bundle", &function_f63d1381, "init");
  level thread function_59d4fec2();
  level thread function_fc7b3c20();
  level thread function_6453e9bd();
  level thread function_89bc492d();
  level thread function_3bc94680();
  level.ascendstarts = struct::get_array("zm_ascend_begin", "script_noteworthy");

  if(isDefined(level.ascendstarts)) {
    array::thread_all(level.ascendstarts, &function_8aecc4f0);
  }

  level thread function_2d8fd70b();
  namespace_f0b43eb5::create_challenge(#"hash_6f756be1d18c8aa2", 90, "zone_market", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_market", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_184d4b8beb6f528b", 90, "zone_electronics_store", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_electronics_store", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_3e9969bc134d9826", 90, array("zone_korber_roof", "zone_korber_roof2"), undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_korber_roof", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_105665bf3108e0b7", 90, "zone_rooftops_start", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_rooftops_start", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_56e1564956312dad", 90, "zone_no_mans_land_1", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_no_mans_land", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::function_f528e34a("s_obj_challenge_zone_ghost_station");
  namespace_f0b43eb5::create_challenge(#"hash_7469b8c6c972754c", 90, "zone_safe_house", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_safe_house", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_5df8fa6c4c17d16e", 90, array("zone_sewers_and_escape_tunnel", "zone_sewers_and_escape_tunnel2", "zone_sewers_stairs"), undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_sewers_and_escape_tunnel", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_5a916e5585f562bb", 90, "zone_bar", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_bar", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_609e7b937084ee81", 90, "zone_east_berlin_street_alley", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_east_berlin_street_alley", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  namespace_f0b43eb5::create_challenge(#"hash_79a18115e7a94cdd", 90, "zone_korber_stairs", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_korber_stairs", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  s_challenge = namespace_f0b43eb5::create_challenge(#"hash_23841799ddb023fe", 90, "zone_korber_sewing_room", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_korber_sewing_room", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  s_challenge = namespace_f0b43eb5::create_challenge(#"hash_30b2182903bf4a9", 90, "zone_room_304", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_room_304", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  s_challenge.var_4e0096cd = # "hash_2f701c656c4a37e0";
  s_challenge = namespace_f0b43eb5::create_challenge(#"hash_30b2482903bf9c2", 90, "zone_room_301", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_room_301", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  s_challenge.var_4e0096cd = # "hash_3b15d4ce09e80704";
  s_challenge = namespace_f0b43eb5::create_challenge(#"hash_7bd66f77ab96b799", 90, "zone_front_desk", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_front_desk", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  s_challenge.var_4e0096cd = # "hash_125b84bfef4e5ff0";
  namespace_f0b43eb5::create_challenge(#"hash_6d988452168d217a", 90, "zone_rooftops_interior", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_rooftops_interior", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  namespace_f0b43eb5::function_f528e34a("s_obj_challenge_zone_american_sector_street");
  namespace_f0b43eb5::create_challenge(#"hash_449daf451df68085", 90, "zone_american_sector_left_building", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_american_sector_left_building", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  namespace_f0b43eb5::create_challenge(#"hash_5e2bac25865464f2", 90, "zone_american_sector_right_building", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_american_sector_right_building", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  namespace_f0b43eb5::create_challenge(#"hash_db5019e43406bdd", 90, array("zone_basement_1", "zone_basement_2"), undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_ghost_station_2", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  namespace_f0b43eb5::create_challenge(#"hash_49b405ab99ad6f84", 90, "zone_control_room", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_control_room", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
}

function function_44b1279a() {
  self notify("7088b04e5517e48d");
  self endon("7088b04e5517e48d");
  self endon(#"disconnect");
  var_7002212e = self zm_zonemgr::is_player_in_zone(level.var_65c43c31, 0);

  if(var_7002212e) {
    self clientfield::set_to_player("" + # "hash_3c8a07f3b4eaf129", 0);
    util::wait_network_frame();
    self clientfield::set_to_player("" + # "hash_3c8a07f3b4eaf129", 1);
  } else {
    self clientfield::set_to_player("" + # "hash_3c8a07f3b4eaf129", 1);
    util::wait_network_frame();
    self clientfield::set_to_player("" + # "hash_3c8a07f3b4eaf129", 0);
  }

  var_63ee6d40 = self zm_zonemgr::is_player_in_zone(level.var_aeef5b56, 0);

  if(var_63ee6d40) {
    self.var_ed2e19c8 = 1;
    self clientfield::set_to_player("" + # "music_underscore", 0);
    util::wait_network_frame();
    self clientfield::set_to_player("" + # "music_underscore", 1);
  } else if(!var_63ee6d40) {
    self.var_ed2e19c8 = 0;
    self clientfield::set_to_player("" + # "music_underscore", 1);
    util::wait_network_frame();
    self clientfield::set_to_player("" + # "music_underscore", 0);
  }

  while(true) {
    is_player_in_zone = self zm_zonemgr::is_player_in_zone(level.var_65c43c31, 0);
    minimap_underground = self clientfield::get_to_player("" + # "hash_3c8a07f3b4eaf129");

    if(is_player_in_zone && minimap_underground == 0) {
      self clientfield::set_to_player("" + # "hash_3c8a07f3b4eaf129", 1);
    } else if(!is_player_in_zone && minimap_underground == 1) {
      self clientfield::set_to_player("" + # "hash_3c8a07f3b4eaf129", 0);
      self clientfield::set_to_player("" + # "music_underscore", 0);
    }

    var_63ee6d40 = self zm_zonemgr::is_player_in_zone(level.var_aeef5b56, 0);

    if(var_63ee6d40 && !is_true(self.var_ed2e19c8)) {
      self.var_ed2e19c8 = 1;
      self clientfield::set_to_player("" + # "music_underscore", 1);
    } else if(!var_63ee6d40 && is_true(self.var_ed2e19c8)) {
      self.var_ed2e19c8 = 0;
      self clientfield::set_to_player("" + # "music_underscore", 0);
    }

    s_waitresult = self waittill(#"zone_change");
  }
}

function function_eb29ebc0() {
  self notify(#"hash_57b465b557811eb7");
}

function function_5b3aabe6() {
  self flag::wait_till("elec_trigger_can_remove");

  if(isDefined(self)) {
    self delete();
  }
}

function private function_f63d1381(a_ents) {
  e_door = a_ents[# "zipline_door"];
  e_door function_619a5c20();
}

function private function_88c5fdab(a_ents) {
  e_door = a_ents[# "zipline_door"];
  e_door function_23a29590();
}

function function_59d4fec2() {
  var_659010cf = struct::get_array("rooftop_to_destroy_door");

  foreach(e_door in var_659010cf) {
    e_door thread scene::init("p9_fxanim_zm_platinum_zipline_bundle");
  }

  level flag::wait_till("connect_rooftops_to_destroyed_upper_floors");
  scene::add_scene_func(#"p9_fxanim_zm_platinum_zipline_bundle", &function_88c5fdab, "play");
  level flag::set("enable_destroyed_upper_zone");
  var_25e85afd = array(getent("connect_rooftops_to_destroyed_upper_floors", "script_flag"), getent("connect_destroyed_upper_floors_to_rooftops", "script_flag"));
  array::thread_all(var_25e85afd, &function_eb29ebc0);

  foreach(e_door in var_659010cf) {
    e_door thread scene::play("p9_fxanim_zm_platinum_zipline_bundle");
  }

  var_4eb19bad = struct::get("zipline_destroyed_rooftops_upper");
  var_8b0c7673 = struct::get(var_4eb19bad.target);
  level clientfield::set("" + # "hash_2971ea22ea5a646a", 2);
  zipline_player::function_2a1bd467(var_4eb19bad);
  zipline_player::function_2a1bd467(var_8b0c7673);
}

function function_fc7b3c20() {
  var_659010cf = struct::get_array("rooftop_to_hotel_door");

  foreach(e_door in var_659010cf) {
    e_door thread scene::init("p9_fxanim_zm_platinum_zipline_bundle");
  }

  level flag::wait_till("connect_hotel_zone");
  zm_zonemgr::enable_zone("zone_east_berlin_hotel_1");
  zm_zonemgr::enable_zone("zone_east_berlin_hotel_2");
  var_25e85afd = array(getent("connect_east_berlin_hotel_to_rooftops_interior", "script_flag"), getent("connect_rooftops_interior_to_east_berlin_hotel", "script_flag"));
  array::thread_all(var_25e85afd, &function_eb29ebc0);
  level flag::wait_till("connect_rooftops_interior_to_east_berlin_hotel");

  foreach(e_door in var_659010cf) {
    e_door thread scene::play("p9_fxanim_zm_platinum_zipline_bundle");
  }

  var_4eb19bad = struct::get("zipline_rooftop_interior");
  var_8b0c7673 = struct::get(var_4eb19bad.target);
  level clientfield::set("" + # "hash_2971ea22ea5a646a", 3);
  zipline_player::function_2a1bd467(var_4eb19bad);
  zipline_player::function_2a1bd467(var_8b0c7673);
}

function function_6453e9bd() {
  var_659010cf = struct::get_array("korber_to_destroy_door");

  foreach(e_door in var_659010cf) {
    e_door thread scene::init("p9_fxanim_zm_platinum_zipline_bundle");
  }

  level flag::wait_till("connect_korber_roof_to_destroyed_upper_floors");
  level flag::set("enable_korber_zone");
  level flag::set("enable_destroyed_upper_zone");
  var_25e85afd = array(getent("connect_destroyed_upper_floors_to_korber_roof", "script_flag"), getent("connect_korber_roof_to_destroyed_upper_floors", "script_flag"));
  array::thread_all(var_25e85afd, &function_eb29ebc0);

  foreach(e_door in var_659010cf) {
    e_door thread scene::play("p9_fxanim_zm_platinum_zipline_bundle");
  }

  var_4eb19bad = struct::get("zipline_korber_rooftop");
  var_8b0c7673 = struct::get(var_4eb19bad.target);
  level clientfield::set("" + # "hash_2971ea22ea5a646a", 4);
  zipline_player::function_2a1bd467(var_4eb19bad);
  zipline_player::function_2a1bd467(var_8b0c7673);
}

function function_2d8fd70b() {
  var_20f6a6a3 = getEntArray("electric_door", "script_noteworthy");
  array::thread_all(var_20f6a6a3, &function_5b3aabe6);
}

function function_89bc492d() {
  var_f3e03c80 = struct::get_array("rappel_power_door");

  foreach(e_door in var_f3e03c80) {
    e_door thread scene::init("p9_fxanim_zm_platinum_rappel_bundle");
  }

  level thread scene::init(#"hash_1aaf6533fa8de56");
  level flag::wait_till("power_on");
  level clientfield::set("" + # "hash_2971ea22ea5a646a", 0);
  zm_zonemgr::enable_zone("zone_secret_spy_tunnel");
  zm_zonemgr::enable_zone("zone_sewers_and_escape_tunnel");
  zm_zonemgr::enable_zone("zone_destroyed_upper_floors");
  zm_zonemgr::enable_zone("zone_american_sector_street");
  zm_zonemgr::enable_zone("zone_american_sector_right_building");
  zm_zonemgr::enable_zone("zone_american_sector_left_building");
  zm_zonemgr::enable_zone("zone_no_mans_land_1");
  var_4eb19bad = struct::get("zipline_nomans_wberlinhotel");
  zipline_player::function_2a1bd467(var_4eb19bad);
  var_4eb19bad = struct::get("zipline_nomans_cafe");
  zipline_player::function_2a1bd467(var_4eb19bad);
  wait 1;

  foreach(e_door in var_f3e03c80) {
    e_door thread scene::play("p9_fxanim_zm_platinum_rappel_bundle");
    waitframe(1);
  }

  scene::add_scene_func(#"hash_1aaf6533fa8de56", &function_d8b4a70b, "play");
  level thread scene::play(#"hash_1aaf6533fa8de56");
}

function private function_d8b4a70b(a_ents) {
  var_4e7f8723 = a_ents[# "rappel_cable"];
  var_4e7f8723 function_619a5c20();
}

function function_8aecc4f0() {
  if(isDefined(self.script_flag)) {
    level flag::wait_till(self.script_flag);
  }

  rappel::function_731b9325(self, 1);
}

function function_27028b8e(str_zone) {
  if(!isDefined(str_zone)) {
    return undefined;
  }

  if(isarray(str_zone)) {
    str_zone = str_zone[0];
  }

  switch (str_zone) {
    case # "zone_rooftops_start":
      str_display = # "hash_2c209ce1cd9bd3ce";
      break;
    case # "zone_rooftops_interior":
      str_display = # "hash_5e96e2ef2c8950d2";
      break;
    case # "zone_destroyed_upper_floors":
      str_display = # "hash_1a8c74e3aeacbefc";
      break;
    case # "zone_east_berlin_hotel_1":
    case # "zone_east_berlin_hotel_2":
      str_display = # "hash_3b15d4ce09e80704";
      break;
    case # "zone_east_berlin_hotel_4":
    case # "zone_east_berlin_hotel_3":
      str_display = # "hash_5b0cd266588cd410";
      break;
    case # "zone_korber_roof2":
    case # "zone_korber_roof":
      str_display = # "hash_40f2768ae57e622a";
      break;
    case # "zone_korber_stairs":
      str_display = # "hash_1218344774c0d52d";
      break;
    case # "zone_korber_sewing_room":
      str_display = # "hash_31277f2032fd4275";
      break;
    case # "zone_east_berlin_street_alley":
      str_display = # "hash_663a898d9c4368d2";
      break;
    case # "zone_east_berlin_street_4":
    case # "zone_east_berlin_street_2":
    case # "zone_east_berlin_street_3":
    case # "zone_east_berlin_street_1":
      str_display = # "hash_366de72e1c7f10e3";
      break;
    case # "zone_bar":
      str_display = # "hash_5f70123180ddedbf";
      break;
    case # "zone_market":
      str_display = # "hash_6bbc9c396cab4166";
      break;
    case # "zone_electronics_store":
      str_display = # "hash_c517c13dd73a87f";
      break;
    case # "zone_ghost_station":
    case # "zone_ghost_station_3":
    case # "zone_ghost_station_2":
    case # "zone_ghost_station_4":
      str_display = # "hash_3354615b6b73090a";
      break;
    case # "zone_basement_1":
    case # "zone_basement_2":
      str_display = # "hash_10f6d2cdd4e18f44";
      break;
    case # "zone_safe_house":
      str_display = # "hash_5e16c141529c6a38";
      break;
    case # "zone_sewers_and_escape_tunnel2":
    case # "zone_sewers_and_escape_tunnel":
    case # "zone_sewers_stairs":
      str_display = # "hash_1ed5ed99b953f70f";
      break;
    case # "zone_power_substation":
    case # "zone_power_substation2":
      str_display = # "hash_503c96cc7237c4f";
      break;
    case # "zone_hidden_lab":
      str_display = # "hash_128f08319d9463fd";
      break;
    case # "zone_american_sector_street":
      str_display = # "hash_7d30c2e28970d40f";
      break;
    case # "zone_american_sector_right_building":
      str_display = # "hash_1d8344d97c9165a";
      break;
    case # "zone_american_sector_left_building":
      str_display = # "hash_383b8711d6edd6bd";
      break;
    case # "zone_no_mans_land_1":
      str_display = # "hash_6f4cc791adc72201";
      break;
    case # "zone_no_mans_land_3":
    case # "zone_no_mans_land_2":
      str_display = # "hash_75adba86a5dd13c1";
      break;
    case # "zone_control_room":
      str_display = # "hash_3e9e52ed3360a871";
      break;
    default:
      str_display = undefined;
      break;
  }

  return str_display;
}

function function_3bc94680() {
  level endon(#"end_game");

  if(!zm_utility::is_ee_enabled()) {
    level flag::wait_till("begin_spawning");
    a_e_doors = getEntArray("zombie_door", "targetname");

    if(isarray(a_e_doors)) {
      foreach(e_door in a_e_doors) {
        if(is_true(e_door.var_93617f16)) {
          e_door notify(#"kill_door_think");
          e_door setinvisibletoall();
        }
      }
    }
  }
}

function function_6e486b1() {
  var_74de2d96 = self zm_zonemgr::is_player_in_zone(level.var_65c43c31);
  return var_74de2d96;
}