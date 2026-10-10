/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_surge\sp_jup_surge.gsc
************************************************************/

#using script_1426fa5f49d822c8;
#using script_151f37cd7136b363;
#using script_242028d00941acd0;
#using script_389a9d54d8274d2a;
#using script_654ffaecd1155946;
#using script_7d3f97c6f5ea5711;
#using script_ff8b2e2a2a57828;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\load;
#using scripts\sp\maps\sp_jup_surge\sp_jup_surge_fx;
#using scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting;
#using scripts\sp\stealth\manager;
#using scripts\stealth\callbacks;
#namespace sp_jup_surge;

function main() {
  namespace_4268778d40c0a94::main();
  scripts\sp\maps\sp_jup_surge\sp_jup_surge_fx::main();
  namespace_2d132edcaaf1f5af::main();
  scripts\sp\maps\sp_jup_surge\sp_jup_surge_lighting::main();
  utility::transient_init("jup_surge_hideout_tr");
  utility::transient_init("jup_surge_city_periph_tr");
  utility::transient_init("jup_surge_city_park_tr");
  utility::transient_init("jup_surge_city_streets_tr");
  utility::transient_init("sp_jup_surge_water_tr");
  utility::transient_init("sp_jup_surge_script_tunnel_crossover_tr");
  utility::transient_init("jup_surge_chunnel_tr");
  utility::transient_init("surge_chunnel_post_bomb_tr");
  utility::transient_init("highspeed_train_patform_cctv_tr");
  precache();
  namespace_ced163a8b0e3e1ba::function_486c0f87d126bd24();
  setup_starts();
  level thread function_f16eda64d3d69428();
  scripts\sp\load::main();
  level thread player_manager();
  level thread setup_objectives();
  level thread function_51e465c575adc466();
  level thread namespace_fc0114e844f0b4c::function_6b1734af5c679095();
  level thread function_e8742f4c64a81042();
  level thread namespace_fc0114e844f0b4c::ammo_refill();
  setomnvar("ui_chyron_surge_chunnel", 0);
  flag_init("introscreen_start_wait");
  setomnvar("ui_cctv_camera_state", 0);
  setomnvar("ui_cctv_camera_index", 0);
  setsaveddvar(@ "hash_710ab425dbbc775", 0);
  scripts\sp\stealth\manager::main();
  scripts\stealth\callbacks::init_callbacks();
  level.var_7d3d0935e9de042a = 800;
}

function precache() {
  precachestring(&"SP_JUP_SURGE/HIDEOUT_INTEL_INSPECT");
  precachestring(&"SP_JUP_SURGE/CROSSOVER_GARAGE_DOOR");
  precachestring(&"SP_JUP_SURGE/FINALE_SNAKE_CAM");
  precachestring(&"SP_JUP_SURGE/FINALE_SNAKE_CAM_CONTROL");
  precachestring(&"SP_JUP_SURGE/FINALE_BOMB");
  precachestring(&"SP_JUP_SURGE/FINALE_WIRE_CUT");
  precachestring(&"SP_JUP_SURGE/CCTV_HINT");
  precachestring(&"SP_JUP_SURGE/CCTV_ENTER_HINT");
  precachestring(&"SP_JUP_SURGE/CCTV_EXIT_HINT");
  scripts\engine\sp\utility::add_hint_string("cctv_enter_hint", &"SP_JUP_SURGE/CCTV_ENTER_HINT");
  scripts\engine\sp\utility::add_hint_string("cctv_rewind_hint", &"SP_JUP_SURGE/CCTV_HINT");
  scripts\engine\sp\utility::add_hint_string("cctv_exit_hint", &"SP_JUP_SURGE/CCTV_EXIT_HINT");
  scripts\engine\sp\utility::add_hint_string("snake_cam_control_hint", &"SP_JUP_SURGE/FINALE_SNAKE_CAM_CONTROL", &function_ca3658dc7eec62ae);
  scripts\engine\sp\utility::add_hint_string("snake_cam_control_hint_reminder", &"SP_JUP_SURGE/FINALE_SNAKE_CAM_CONTROL", &function_db70d81bd8375b73);
  precacheshader("overlay_cctv_vignettes");
  precacheshader("ui_bomber_drone_overlay");
  precacheshader("icon_waypoint_ally_marker");
  precacheshader("icon_waypoint_enemy_marker");
  flag_init("flg_player_has_rewinded");
}

function function_a94633115d03acac() {}

function player_manager() {
  var_2f7136cf6c5b1b14 = ["frag", "flash", "semtex", "smoke"];
  utility::offhandprecache(var_2f7136cf6c5b1b14);
  level.loot.types["smoke"].weapon = "smoke";
  level.player setcinematicmotionoverride("iw9_creep_montage");
  level.player allowsupersprint(0);
  level.player.movementstate = "creep";
  level.player setsuit("iw9_creep_montage");
  player_speed_set(85, 0.5);
  level.player.name = "Soap";
  function_7d89f98164b6df3d("viewmodel_arms_sp_soap_party");
  flag_wait("flg_pov_price_tac");
  level thread function_837bb2142379dbfb("default");
  level.player.name = "Price";
  function_7d89f98164b6df3d("vm_c_jup_sp_hero_price_london_tactical");
  level.player function_c4ec7d985422ce24("vm_c_jup_sp_hero_price_london_tactical");
}

function function_7d89f98164b6df3d(viewmodel, legmodel, shadowmodel) {
  if(isDefined(viewmodel)) {
    level.player setviewmodel(viewmodel);
  }

  if(isDefined(legmodel)) {
    level.player setlegsmodel(legmodel);
  }

  if(isDefined(shadowmodel)) {
    level.player setshadowmodel(shadowmodel);
  }
}

function function_f16eda64d3d69428() {
  var_1b7cd9bfbb466cba = ["jup_surge_hideout_tr", "jup_surge_city_periph_tr", "jup_surge_city_park_tr", "jup_surge_city_streets_tr", "sp_jup_surge_water_tr", "sp_jup_surge_script_tunnel_crossover_tr", "jup_surge_chunnel_tr", "surge_chunnel_post_bomb_tr", "highspeed_train_patform_cctv_tr"];

  if(getDvar(@ "hash_e6afce2cf5cf7515") == "1") {
    waitframe();
    transient_load_array(var_1b7cd9bfbb466cba);
  }
}

function setup_starts() {
  set_default_start("park_igc");
  add_start("park_igc", &function_5f33caa564c8cc9c, &function_1d5893b30c552e0d, ["jup_surge_city_park_tr", "jup_surge_city_periph_tr", "sp_jup_surge_water_tr", "jup_surge_city_streets_tr"], &function_17a6747844ea0572);
  add_start("park_stealth", &function_babb342ff0e219c6, &function_20297f8e1c35f50f, ["jup_surge_city_park_tr", "jup_surge_city_periph_tr", "sp_jup_surge_water_tr", "jup_surge_city_streets_tr"], &function_f5f722059582babc);
  add_start("streets_cctv_rewind", &function_fd1d689754af745, &function_b43e8582d88f7e9e, ["jup_surge_city_park_tr", "jup_surge_city_periph_tr", "sp_jup_surge_water_tr", "jup_surge_city_streets_tr", "jup_surge_hideout_tr"], &function_54ab7590d2f1297);
  add_start("hideout_intro", &function_5597cff585479739, &function_4dde5fec8c66abba, ["jup_surge_hideout_tr", "jup_surge_city_streets_tr", "jup_surge_city_park_tr"], &function_c62d194cbba5e51b);
  add_start("hideout_cqc", &function_4adbe5d4d260e906, &function_297b8c42f0cd844f, ["jup_surge_hideout_tr"], &function_b0a9d93caead2efc);
  add_start("hideout_finale", &hideout_finale_start, &function_ee4d03c179ce24c9, ["jup_surge_hideout_tr"], &function_12ac0e282e4517c6);
  add_start("hideout_intel", &function_16be1bad30b8579b, &function_d16344accb85972c, ["jup_surge_hideout_tr", "highspeed_train_patform_cctv_tr"], undefined);
  add_start("hideout_igc", &function_4788a2d1a5d3742a, &function_1de99b4a320b0c1b, ["jup_surge_chunnel_tr", "sp_jup_surge_script_tunnel_crossover_tr"], undefined);
  add_start("chunnel_intro", &function_f8dd3611e9c34c96, &function_374107677e68907f, ["jup_surge_chunnel_tr", "sp_jup_surge_script_tunnel_crossover_tr"], undefined);
  add_start("chunnel_advance", &function_3fc8a536dbeae662, &function_2dcfbff5767f7f73, ["jup_surge_chunnel_tr", "sp_jup_surge_script_tunnel_crossover_tr"], &function_8d668a205bad23e8);
  add_start("chunnel_vents", &function_db2aeb0917913640, &function_9b7d604d11c44759, ["jup_surge_chunnel_tr", "sp_jup_surge_script_tunnel_crossover_tr"], &function_7dbb4634438e3a96);
  add_start("chunnel_crossover", &chunnel_crossover_start, &function_b9a1c98e258e862f, ["jup_surge_chunnel_tr", "sp_jup_surge_script_tunnel_crossover_tr"], &function_58a8d8eec289795c);
  add_start("chunnel_finale", &function_9f8ff5c7872a880d, &function_933c5b68b5a0d566, ["jup_surge_chunnel_tr", "sp_jup_surge_script_tunnel_crossover_tr", "surge_chunnel_post_bomb_tr"], &function_967e11f5b6c7962f);
  add_start("chunnel_finale_outro", &function_b6cabeecb8392d35, &function_904a6347b9eaafee, ["jup_surge_chunnel_tr", "sp_jup_surge_script_tunnel_crossover_tr", "surge_chunnel_post_bomb_tr"], undefined);
  add_start("credits_only", &function_fd457bdd6c88318b, &function_904a6347b9eaafee, ["jup_surge_chunnel_tr", "sp_jup_surge_script_tunnel_crossover_tr", "surge_chunnel_post_bomb_tr"], undefined);
}

function function_b6badfad142e5fef() {}

function setup_objectives() {
  switch (level.start_point) {
    case #"hash_88f4d9b62e76ffa3":
      flag_wait("flg_intro_done");
    case #"hash_a98a96c01179d4e9":
      scripts\engine\sp\objectives::objective_add("park_streets_obj", "current", undefined, &"SP_JUP_SURGE/OBJ_PARK_MEET_ALLY", undefined, "icon_waypoint_objective_general", 80);

      while(!isDefined(level.var_d18d63c6d75cd1e)) {
        waitframe();
      }

      objective_set_on_entity("park_streets_obj", "waypoint_gaz", level.var_d18d63c6d75cd1e);
      flag_wait_any("flg_park_follow_hacker_obj_start", "flg_park_whiskey_leave_1");
      scripts\engine\sp\objectives::objective_remove_location("park_streets_obj", "waypoint_gaz");
      scripts\engine\sp\objectives::objective_set_description("park_streets_obj", &"SP_JUP_SURGE/OBJ_PARK_LOCATE_TARGET_DESC");

      while(!isDefined(level.ai_hacker)) {
        waitframe();
      }

      objective_set_on_entity("park_streets_obj", "waypoint_hacker", level.ai_hacker);
      flag_wait("flg_park_obj_listen_to_call_show");
      scripts\engine\sp\objectives::objective_set_description("park_streets_obj", &"SP_JUP_SURGE/OBJ_PARK_LISTEN_TO_CALL_DESC");
      flag_wait("flg_park_cctv_1_start");
      objective_remove_location("park_streets_obj", "waypoint_hacker");
      scripts\engine\sp\objectives::objective_set_description("park_streets_obj", &"SP_JUP_SURGE/OBJ_STREETS_LOCATE_DESC");
    case #"hash_70347d15a0bdcc56":
      if(!objectives::objective_exists("park_streets_obj")) {
        scripts\engine\sp\objectives::objective_add("park_streets_obj", "current", undefined, &"SP_JUP_SURGE/OBJ_STREETS_LOCATE_DESC", undefined, "icon_waypoint_objective_general", 80);
      }

      flag_wait("flg_rewind_target_first_seen");
      scripts\engine\sp\objectives::objective_set_description("park_streets_obj", &"SP_JUP_SURGE/OBJ_STREETS_TRACK_TARGET_DESC");
      flag_wait("flg_streets_cctv_track_done");
      scripts\engine\sp\objectives::objective_complete("park_streets_obj");
      objectives::objective_remove("park_streets_obj");
    case #"hash_161c0901add9c62a":
      scripts\engine\sp\objectives::objective_add("hideout_obj", "current", undefined, &"SP_JUP_SURGE/OBJ_HIDEOUT_INVESTIGATE_DESC", undefined, "icon_waypoint_objective_general");
      s_streets_tunnel_hideout_entrance_ref = getStruct("s_streets_tunnel_hideout_entrance_ref", "targetname");
      objective_add_location_position("hideout_obj", "hideout_entrance_wp", s_streets_tunnel_hideout_entrance_ref.origin);
      flag_wait("flg_hideout_breached");
      objective_remove_location("hideout_obj", "hideout_entrance_wp");
    case #"hash_9834861649d37959":
      if(!objectives::objective_exists("hideout_obj")) {
        scripts\engine\sp\objectives::objective_add("hideout_obj", "current", undefined, &"SP_JUP_SURGE/OBJ_HIDEOUT_FOLLOW_TEAM_DESC", undefined, "icon_waypoint_objective_general");
      }

      flag_wait_any("flg_hideout_clear_obj_start", "flg_hideout_bathroom_start", "flg_hideout_main_path_corridor00", "flg_hideout_servicehall_start");
      scripts\engine\sp\objectives::objective_set_description("hideout_obj", &"SP_JUP_SURGE/OBJ_HIDEOUT_CLEAR_ROOMS_DESC");
    case #"hash_a1a5774db6068e0f":
      if(!objectives::objective_exists("hideout_obj")) {
        scripts\engine\sp\objectives::objective_add("hideout_obj", "current", undefined, &"SP_JUP_SURGE/OBJ_HIDEOUT_CLEAR_ROOMS_DESC", undefined, "icon_waypoint_objective_general");
      }

      level flag_wait_any("flg_hideout_final_room_clear", "flg_hideout_final_guy_aware");
      scripts\engine\sp\objectives::objective_set_description("hideout_obj", &"SP_JUP_SURGE/OBJ_HIDEOUT_BREACH_OFFICE_DESC");
    case #"hash_15ec0601adb35d98":
      if(!objective_exists("hideout_obj")) {
        scripts\engine\sp\objectives::objective_add("hideout_obj", "current", undefined, &"SP_JUP_SURGE/OBJ_HIDEOUT_BREACH_OFFICE_DESC", undefined, "icon_waypoint_objective_general");
      }

      s_hideout_obj_1 = getStruct("s_hideout_lightson_door_cursor_hint", "targetname");
      objective_add_location_position("hideout_obj", "s_hideout_obj_1", s_hideout_obj_1.origin);
      level flag_wait_all("flg_hideout_intel_enter", "flg_hideout_office_enemies_dead");
      objective_remove_location("hideout_obj", "s_hideout_obj_1");
      scripts\engine\sp\objectives::objective_set_description("hideout_obj", &"SP_JUP_SURGE/OBJ_HIDEOUT_INTERACT_EVIDENCE_DESC");
      s_inspect_cursor_hint = getStruct("s_inspect_cursor_hint", "targetname");
      objective_add_location_position("hideout_obj", "s_hideout_obj_2", s_inspect_cursor_hint.origin);
    case #"hash_4fa7a4162439e38d":
      if(!objective_exists("hideout_obj")) {
        scripts\engine\sp\objectives::objective_add("hideout_obj", "current", undefined, &"SP_JUP_SURGE/OBJ_HIDEOUT_INTERACT_EVIDENCE_DESC", undefined, "icon_waypoint_objective_general");
        s_inspect_cursor_hint = getStruct("s_inspect_cursor_hint", "targetname");
        objective_add_location_position("hideout_obj", "s_hideout_obj_2", s_inspect_cursor_hint.origin);
      }

      level flag_wait("hideout_interact_evidence_complete");
      objective_remove_location("hideout_obj", "s_hideout_obj_2");
      objectives::objective_remove("hideout_obj");
      flag_wait("flg_chunnel_obj_start");
    case #"hash_4b49a6590f0dc731":
    case #"hash_d975b4d6ec2bcdfd":
      scripts\engine\sp\objectives::objective_add("chunnel_obj", "current", undefined, &"SP_JUP_SURGE/OBJ_CHUNNEL_START_DESC", undefined, "icon_waypoint_objective_general");
      s_chunnel_advance_obj_1 = getStruct("s_chunnel_advance_obj_1", "targetname");
      objective_add_location_position("chunnel_obj", "chunnel_advance_obj_1", s_chunnel_advance_obj_1.origin);
      flag_wait("flg_chunnel_intro_allies_adv_1");
      objective_remove_location("chunnel_obj", "chunnel_advance_obj_1");
      s_chunnel_advance_obj_2 = getStruct("s_chunnel_advance_obj_2", "targetname");
      objective_add_location_position("chunnel_obj", "chunnel_advance_obj_2", s_chunnel_advance_obj_2.origin);
      flag_wait("flg_chunnel_intro_allies_adv_5");
      objective_remove_location("chunnel_obj", "chunnel_advance_obj_2");
      s_chunnel_advance_obj_3 = getStruct("s_chunnel_advance_obj_3", "targetname");
      objective_add_location_position("chunnel_obj", "chunnel_advance_obj_3", s_chunnel_advance_obj_3.origin);
      flag_wait_any("flg_chunnel_intro_track_complete", "flg_chunnel_intro_track_laststand_right", "flg_chunnel_intro_track_laststand_left");
      objective_remove_location("chunnel_obj", "chunnel_advance_obj_3");
      flag_wait_any("flg_chunnel_intro_track_complete", "flg_chunnel_intro_vents_01");
      scripts\engine\sp\objectives::objective_set_description("chunnel_obj", &"SP_JUP_SURGE/OBJ_TUNNEL_ENTER_VENT_DESC");
    case #"hash_92bcd2f1b168aa57":
      if(!objective_exists("chunnel_obj")) {
        scripts\engine\sp\objectives::objective_add("chunnel_obj", "current", undefined, &"SP_JUP_SURGE/OBJ_TUNNEL_ENTER_VENT_DESC", undefined, "icon_waypoint_objective_general");
      }

      s_chunnel_vents_obj_1 = getStruct("s_chunnel_vents_obj_1", "targetname");
      objective_add_location_position("chunnel_obj", "chunnel_vents_obj_1", s_chunnel_vents_obj_1.origin);
      flag_wait("flg_chunnel_intro_vents_start");
      objective_remove_location("chunnel_obj", "chunnel_vents_obj_1");
      s_chunnel_vents_obj_2 = getStruct("s_chunnel_vents_obj_2", "targetname");
      objective_add_location_position("chunnel_obj", "chunnel_vents_obj_2", s_chunnel_vents_obj_2.origin);
      flag_wait("flg_chunnel_intro_vents_13");
      objective_remove_location("chunnel_obj", "chunnel_vents_obj_2");
      s_chunnel_vents_obj_3 = getStruct("s_chunnel_vents_obj_3", "targetname");
      objective_add_location_position("chunnel_obj", "chunnel_vents_obj_3", s_chunnel_vents_obj_3.origin);
      flag_wait_any("flg_chunnel_intro_garage_02", "flg_chunnel_intro_garage_complete");
      objective_remove_location("chunnel_obj", "chunnel_vents_obj_3");
      flag_wait_all("flg_chunnel_intro_garage_complete", "flg_chunnel_garage_vo_complete");
      scripts\engine\sp\objectives::objective_set_description("chunnel_obj", &"SP_JUP_SURGE/OBJ_CROSSOVER_ENTER_DESC");
    case #"hash_266c2e7e308b3c69":
      if(!objective_exists("chunnel_obj")) {
        scripts\engine\sp\objectives::objective_add("chunnel_obj", "current", undefined, &"SP_JUP_SURGE/OBJ_CROSSOVER_ENTER_DESC", undefined, "icon_waypoint_objective_general");
      }

      s_crossover_garage_door_interact_ref = getStruct("s_crossover_garage_door_interact_ref", "targetname");
      objective_add_location_position("chunnel_obj", "chunnel_crossover_garage_door", s_crossover_garage_door_interact_ref.origin + (0, 0, 20));
      flag_wait("flg_chunnel_crossover_open_door");
      objective_remove_location("chunnel_obj", "chunnel_crossover_garage_door");
      flag_wait("flg_crossover_clear_obj_show");
      scripts\engine\sp\objectives::objective_set_description("chunnel_obj", &"SP_JUP_SURGE/OBJ_TUNNEL_SECURE_CROSSOVER_DESC");
      flag_wait_any("flg_crossover_finale_enter", "flg_crossover_elites_clear");
      scripts\engine\sp\objectives::objective_set_description("chunnel_obj", &"SP_JUP_SURGE/OBJ_CHUNNEL_HOSTAGES_DESC");
      flag_wait("flg_chunnel_middle_crossed");
      s_chunnel_hostage_rescue_obj = getStruct("s_chunnel_hostage_rescue_obj", "targetname");
      objective_add_location_position("chunnel_obj", "waypoint_hostages", s_chunnel_hostage_rescue_obj.origin);
    case #"hash_5ea2cd7a96667c16":
      if(!objective_exists("chunnel_obj")) {
        scripts\engine\sp\objectives::objective_add("chunnel_obj", "current", undefined, &"SP_JUP_SURGE/OBJ_CHUNNEL_HOSTAGES_DESC", undefined, "icon_waypoint_objective_general");
      }

      flag_wait("flag_chunnel_finale_wave_1_dead");
      scripts\engine\sp\objectives::objective_set_description("chunnel_obj", &"SP_JUP_SURGE/OBJ_CHUNNEL_FINALE_DESC");
      flag_wait("flg_bomb_defused");
      scripts\engine\sp\objectives::objective_complete("chunnel_obj");
      break;
  }
}