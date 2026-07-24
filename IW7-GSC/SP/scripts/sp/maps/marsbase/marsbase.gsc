/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase.gsc
*************************************************/

main() {
  scripts\sp\utility::_id_116CB("marsbase");
  scripts\sp\utility::_id_F343("base_intro");
  _id_12649();
  scripts\sp\utility::_id_1749("base_intro", scripts\sp\maps\marsbase\marsbase_intro::_id_10BB9, "Base Intro", scripts\sp\maps\marsbase\marsbase_intro::_id_B190, level._id_B3B0["intro"], scripts\sp\maps\marsbase\marsbase_intro::_id_3B43);
  scripts\sp\utility::_id_1749("aa1", scripts\sp\maps\marsbase\marsbase_intro::_id_10B91, "AA Gun 1", scripts\sp\maps\marsbase\marsbase_intro::_id_B174, level._id_B3B0["intro"], scripts\sp\maps\marsbase\marsbase_intro::_id_3B27);
  scripts\sp\utility::_id_1749("gate_support_1", scripts\sp\maps\marsbase\marsbase_intro::_id_10C5D, "Engineers Open Gate", scripts\sp\maps\marsbase\marsbase_intro::_id_B1E8, level._id_B3B0["intro"], scripts\sp\maps\marsbase\marsbase_intro::_id_3B6A);
  scripts\sp\utility::_id_1749("greenhouse_approach", scripts\sp\maps\marsbase\marsbase_greenhouse::_id_10C66, "Greenhouse Approach", scripts\sp\maps\marsbase\marsbase_greenhouse::_id_B1EB, level._id_B3B0["intro"], ::_id_5F1B);
  scripts\sp\utility::_id_1749("greenhouse_battle", scripts\sp\maps\marsbase\marsbase_greenhouse::_id_10C67, "Greenhouse Battle", scripts\sp\maps\marsbase\marsbase_greenhouse::_id_B1EC, level._id_B3B0["greenhouse"], scripts\sp\maps\marsbase\marsbase_greenhouse::_id_8555);
  scripts\sp\utility::_id_1749("greenhouse_enter", scripts\sp\maps\marsbase\marsbase_caves::_id_10C68, "Greenhouse Enter", scripts\sp\maps\marsbase\marsbase_caves::_id_B1ED, level._id_B3B0["gator_door"], scripts\sp\maps\marsbase\marsbase_caves::_id_8567);
  scripts\sp\utility::_id_1749("aa2", scripts\sp\maps\marsbase\marsbase_caves::_id_10B92, "AA Gun 2", scripts\sp\maps\marsbase\marsbase_caves::_id_B175, level._id_B3B0["aa2_start"], scripts\sp\maps\marsbase\marsbase_caves::_id_14C9);
  scripts\sp\utility::_id_1749("gate_support_2", scripts\sp\maps\marsbase\marsbase_caves::_id_10C5E, "Jackal Opens Caves", scripts\sp\maps\marsbase\marsbase_caves::_id_B1E9, level._id_B3B0["aa2_end"], scripts\sp\maps\marsbase\marsbase_caves::_id_3B6B);
  scripts\sp\utility::_id_1749("burning_man", scripts\sp\maps\marsbase\marsbase_burning_man::_id_10BC4, "Hilltop", scripts\sp\maps\marsbase\marsbase_burning_man::_id_B19A, level._id_B3B0["airlock"], scripts\sp\maps\marsbase\marsbase_burning_man::_id_3B44);
  scripts\sp\utility::_id_1749("hill_intro", scripts\sp\maps\marsbase\marsbase_hill_intro::_id_10C7F, "Hilltop", scripts\sp\maps\marsbase\marsbase_hill_intro::_id_B1F9, level._id_B3B0["airlock"], scripts\sp\maps\marsbase\marsbase_hill_intro::_id_8F8D);
  scripts\sp\utility::_id_1749("hill_battle", scripts\sp\maps\marsbase\marsbase_hill_battle::_id_10C7B, "Hilltop", scripts\sp\maps\marsbase\marsbase_hill_battle::_id_B1F5, level._id_B3B0["hill_battle"], scripts\sp\maps\marsbase\marsbase_hill_battle::_id_3B6E);
  scripts\sp\utility::_id_1749("hill_cargofall", scripts\sp\maps\marsbase\marsbase_hill_battle::_id_10C7D, "Hilltop", scripts\sp\maps\marsbase\marsbase_hill_battle::_id_B1F7, level._id_B3B0["hill_battle"], scripts\sp\maps\marsbase\marsbase_hill_battle::_id_3B71);
  scripts\sp\utility::_id_1749("hill_c8", scripts\sp\maps\marsbase\marsbase_hill_battle::_id_10C7C, "Hilltop", scripts\sp\maps\marsbase\marsbase_hill_battle::_id_B1F6, level._id_B3B0["hill_battle"], scripts\sp\maps\marsbase\marsbase_hill_battle::_id_3B70);
  scripts\sp\utility::_id_1749("hill_gate", scripts\sp\maps\marsbase\marsbase_hill_gate::_id_10C5B, "Hilltop", scripts\sp\maps\marsbase\marsbase_hill_gate::_id_B1E6, level._id_B3B0["hill_battle"], scripts\sp\maps\marsbase\marsbase_hill_gate::_id_3B72);
  scripts\sp\utility::_id_1749("hill_gate_open", scripts\sp\maps\marsbase\marsbase_hill_gate::_id_10C5C, "Hilltop", scripts\sp\maps\marsbase\marsbase_hill_gate::_id_B1E7, level._id_B3B0["hill_battle"], scripts\sp\maps\marsbase\marsbase_hill_gate::_id_3B73);
  scripts\sp\utility::_id_1749("elevator_retreat", scripts\sp\maps\marsbase\marsbase_elevator_retreat::_id_10C34, "Elevator", scripts\sp\maps\marsbase\marsbase_elevator_retreat::_id_B1D3, level._id_B3B0["hill_battle"], scripts\sp\maps\marsbase\marsbase_elevator_retreat::_id_60BE);
  scripts\sp\utility::_id_1749("elevator_igc", scripts\sp\maps\marsbase\marsbase_elevator_igc::_id_10C30, "Elevator", scripts\sp\maps\marsbase\marsbase_elevator_igc::_id_B1CE, level._id_B3B0["hill_battle"], scripts\sp\maps\marsbase\marsbase_elevator_igc::_id_6085);
  scripts\sp\utility::_id_1749("elevator_enter", scripts\sp\maps\marsbase\marsbase_elevator::_id_10C2E, "Elevator Enter", scripts\sp\maps\marsbase\marsbase_elevator::_id_B1CD, level._id_B3B0["elevator"], scripts\sp\maps\marsbase\marsbase_elevator::_id_3B5E);
  scripts\sp\utility::_id_1749("elevator_load", scripts\sp\maps\marsbase\marsbase_elevator::_id_10C32, "Elevator Load", scripts\sp\maps\marsbase\marsbase_elevator::_id_B1D1, level._id_B3B0["elevator_load"], scripts\sp\maps\marsbase\marsbase_elevator::_id_3B61);
  scripts\sp\utility::_id_1749("elevator_move", scripts\sp\maps\marsbase\marsbase_elevator::_id_10C31, "Elevator Move", scripts\sp\maps\marsbase\marsbase_elevator::_id_B1D0, level._id_B3B0["elevator_load"], scripts\sp\maps\marsbase\marsbase_elevator::_id_3B60);
  _id_D83F();
  scripts\sp\load::main();
  _id_D704();
}

_id_12649() {
  level._id_B3B0 = [];
  level._id_B3B0["load"] = ["marsbase_dropship_hero_tr", "marsbase_combat_intro_tr", "marsbase_combat_to_grinder_tr", "marsbase_elevator_lowres_tr"];
  level._id_B3B0["intro"] = ["marsbase_prime_tr", "marsbase_dropship_hero_tr", "marsbase_combat_intro_tr", "marsbase_combat_to_grinder_tr", "marsbase_elevator_lowres_tr"];
  level._id_B3B0["greenhouse"] = ["marsbase_prime_tr", "marsbase_dropship_hero_tr", "marsbase_combat_intro_tr", "marsbase_combat_to_grinder_tr", "marsbase_olympus_mons_guts_tr", "marsbase_elevator_lowres_tr"];
  level._id_B3B0["gator_door"] = ["marsbase_prime_tr", "marsbase_dropship_hero_tr", "marsbase_combat_intro_tr", "marsbase_combat_to_grinder_tr", "marsbase_combat_meatgrinder_tr", "marsbase_olympus_mons_guts_tr", "marsbase_vista_train_station_tr", "marsbase_elevator_lowres_tr"];
  level._id_B3B0["aa2_start"] = ["marsbase_prime_tr", "marsbase_dropship_hero_tr", "marsbase_combat_to_grinder_tr", "marsbase_combat_meatgrinder_tr", "marsbase_vista_train_station_tr", "marsbase_elevator_lowres_tr"];
  level._id_B3B0["aa2_end"] = ["marsbase_prime_tr", "marsbase_dropship_hero_tr", "marsbase_combat_to_grinder_tr", "marsbase_combat_meatgrinder_tr", "marsbase_tunnel_airlock_tr", "marsbase_vista_train_station_tr", "marsbase_elevator_lowres_tr"];
  level._id_B3B0["airlock"] = ["marsbase_prime_tr", "marsbase_dropship_hero_tr", "marsbase_combat_to_grinder_tr", "marsbase_combat_meatgrinder_tr", "marsbase_tunnel_airlock_tr", "marsbase_vista_train_station_tr", "marsbase_combat_pre_elevator_tr", "marsbase_combat_elevator_tr", "marsbase_elevator_lowres_tr"];
  level._id_B3B0["airlock_end"] = ["marsbase_prime_tr", "marsbase_dropship_hero_tr", "marsbase_combat_to_grinder_tr", "marsbase_combat_meatgrinder_tr", "marsbase_tunnel_airlock_tr", "marsbase_vista_train_station_tr", "marsbase_combat_pre_elevator_tr", "marsbase_combat_elevator_tr"];
  level._id_B3B0["hill_battle_airlock"] = ["marsbase_prime_tr", "marsbase_dropship_hero_tr", "marsbase_tunnel_airlock_tr", "marsbase_vista_train_station_tr", "marsbase_combat_pre_elevator_tr", "marsbase_combat_elevator_tr"];
  level._id_B3B0["hill_battle"] = ["marsbase_prime_tr", "marsbase_dropship_hero_tr", "marsbase_tunnel_airlock_tr", "marsbase_vista_train_station_tr", "marsbase_combat_pre_elevator_tr", "marsbase_combat_elevator_tr"];
  level._id_B3B0["elevator"] = ["marsbase_vista_train_station_tr", "marsbase_tunnel_airlock_tr", "marsbase_combat_pre_elevator_tr", "marsbase_combat_elevator_tr"];
  level._id_B3B0["elevator_load"] = ["marsbase_combat_pre_elevator_tr", "marsbase_combat_elevator_tr"];
  level._id_B3B0["elevator_ride"] = ["marsbase_combat_elevator_tr"];
}

_id_D83F() {
  scripts\sp\maps\marsbase\gen\marsbase_art::main();
  scripts\sp\maps\marsbase\marsbase_fx::main();
  scripts\sp\maps\marsbase\marsbase_precache::main();
  scripts\sp\maps\marsbase\marsbase_anim::main();
  scripts\sp\maps\marsbase\marsbase_code::_id_D83F();
  scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_1DF2();
  _id_0B0F::_id_9543();
  scripts\sp\maps\marsbase\marsbase_elevator::_id_60A6();
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A8("dropship3_destroyed");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A8("fxanim_sp_mars_crane");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A9("aa2_destruction");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A9("aa2_rubble");
  precacherumble("light_steady");
  precacherumble("mars_dropship_hard_landing");
  precachestring(&"MARSBASE_KILLSTREAK_NOT_READY");
  precachestring(&"MARSBASE_KILLSTREAK_READY");
  precachestring(&"MARSBASE_KILLSTREAK_NOT_READY_CENTER");
  precachestring(&"MARSBASE_KILLSTREAK_READY_CENTER");
  precachestring(&"MARSBASE_KILLSTREAK_OFFLINE");
  precachestring(&"MARSBASE_OPEN_DOOR_HILL");
  precachestring(&"MARSBASE_OPEN_GATE_ELEVATOR");
  precachestring(&"MARSBASE_GRAB_DOOR_GATOR");
  precachestring(&"MARSBASE_ELEVATOR_SEAT");
  _id_9809();
  scripts\sp\utility::_id_1263F("marsbase_olympus_mons_guts_tr");
  scripts\sp\utility::_id_1263F("marsbase_vista_train_station_tr");
  scripts\sp\utility::_id_1263F("marsbase_tunnel_airlock_tr");
  scripts\sp\utility::_id_1263F("marsbase_prime_tr");
  scripts\sp\utility::_id_1263F("marsbase_elevator_lowres_tr");
  scripts\sp\utility::_id_1263F("marsbase_combat_intro_tr");
  scripts\sp\utility::_id_1263F("marsbase_combat_to_grinder_tr");
  scripts\sp\utility::_id_1263F("marsbase_combat_meatgrinder_tr");
  scripts\sp\utility::_id_1263F("marsbase_combat_pre_elevator_tr");
  scripts\sp\utility::_id_1263F("marsbase_combat_elevator_tr");
  scripts\sp\utility::_id_1263F("marsbase_dropship_hero_tr");
  setsaveddvar("r_spotlightEntityShadows", 1);
  setsaveddvar("r_offloadPrimaryLights", 2);
}

_id_9809() {
  scripts\sp\maps\marsbase\marsbase_code::_id_9809();
  scripts\sp\maps\marsbase\marsbase_elevator::_id_6E6C();
}

_id_D704() {
  foreach(var_1 in getspawnerteamarray("axis", "allies")) {
    var_1._id_EDB0 = 1;
  }

  scripts\sp\maps\marsbase\marsbase_code::_id_D704();
  thread scripts\sp\maps\marsbase\marsbase_code::_id_C2A9();
  createthreatbiasgroup("player");
  createthreatbiasgroup("c12");
  createthreatbiasgroup("ignore_player");
  createthreatbiasgroup("allies_left");
  createthreatbiasgroup("allies_right");
  createthreatbiasgroup("axis_left");
  createthreatbiasgroup("axis_right");
  createthreatbiasgroup("allies_c12_focus");
  level.player setthreatbiasgroup("player");
  setignoremegroup("player", "ignore_player");
  setignoremegroup("c12", "allies");
  setignoremegroup("allies", "c12");
  setignoremegroup("axis", "allies_c12_focus");
  setignoremegroup("allies_c12_focus", "axis");
  scripts\sp\pip_util::_id_CBAA();
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A3();
  scripts\sp\maps\marsbase\marsbase_util::_id_B39D();
  scripts\sp\maps\marsbase\marsbase_util::_id_B3A6();
  scripts\sp\utility::_id_16D5("mars_killstreak", scripts\sp\maps\marsbase\marsbase_util::_id_266E, "Autosave failed: Player is in killstreak");
  scripts\sp\maps\marsbase\marsbase_util::_id_10687();
  level thread scripts\sp\maps\marsbase\marsbase_hill_battle::_id_8F20();
  scripts\sp\maps\marsbase\marsbase_hill_gate::_id_301C();
  scripts\sp\maps\marsbase\marsbase_hill_gate::_id_A537();
  var_3 = getEntArray("rocket_launcher_pickups", "targetname");

  if(var_3.size > 0) {
    foreach(var_5 in var_3) {
      var_5 itemweaponsetammo(1, 2);
    }
  }

  scripts\sp\utility::_id_F44E(0);
  scripts\sp\utility::_id_241F(1);
  _id_0E4B::helmethud_on();
  level thread _id_0A2F::_id_3D61();
}

_id_22FA() {
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_aa1", "targetname"));
  scripts\engine\utility::waitframe();
  level.player scripts\sp\utility::_id_F526("normal");
  level.player allowfire(1);
  wait 1;
  level notify("stop_ambient_jackals_intro");
  level notify("stop_ambient_jackals_elevator");
  level notify("hill_battle_jackals_stop");
  level notify("stop_ambient_jackals");
  var_0 = getaiarray("allies");
  scripts\sp\utility::_id_228A(var_0);
  var_1 = getEntArray("trigger_multiple_spawn", "classname");
  scripts\sp\utility::_id_228A(var_1);
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_4");
}

_id_5F26() {}

_id_5F20() {}

_id_5F1B() {}