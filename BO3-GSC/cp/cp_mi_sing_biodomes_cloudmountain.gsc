/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_biodomes_cloudmountain.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_hacking;
#using scripts\cp\_laststand;
#using scripts\cp\_load;
#using scripts\cp\_objectives;
#using scripts\cp\_skipto;
#using scripts\cp\_spawn_manager;
#using scripts\cp\_squad_control;
#using scripts\cp\_util;
#using scripts\cp\cp_mi_sing_biodomes;
#using scripts\cp\cp_mi_sing_biodomes_accolades;
#using scripts\cp\cp_mi_sing_biodomes_fighttothedome;
#using scripts\cp\cp_mi_sing_biodomes_sound;
#using scripts\cp\cp_mi_sing_biodomes_util;
#using scripts\cp\cp_mi_sing_biodomes_warehouse;
#using scripts\cp\cybercom\_cybercom_gadget_security_breach;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_battlechatter;
#using scripts\cp\gametypes\_save;
#using scripts\shared\ai\archetype_warlord_interface;
#using scripts\shared\ai\robot_phalanx;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\colors_shared;
#using scripts\shared\compass;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#namespace cp_mi_sing_biodomes_cloudmountain;

function precache() {}

function main() {
  spawner::add_spawn_function_group("rambo", "script_noteworthy", & rambo_robots);
  spawner::add_spawn_function_group("rusher", "script_noteworthy", & rusher_robots);
  spawner::add_spawn_function_group("hunter_flybys", "script_noteworthy", & hunter_flyby_cloud_mountain);
  spawner::add_spawn_function_group("cloud_mountain_reinforcements", "script_noteworthy", & cloud_mountain_reinforcements_spawn);
  spawner::add_spawn_function_group("cloud_mountain_retreaters", "script_noteworthy", & cloud_mountain_retreaters_spawn);
  spawner::add_spawn_function_group("level_3_surprised_enemies", "script_noteworthy", & cloud_mountain_level_3_surprised);
  spawner::add_spawn_function_group("pod_spawners", "script_noteworthy", & robot_pod_spawn);
  spawner::add_spawn_function_group("sp_cloudmountain_level_2_warlord", "targetname", & function_a288e474);
  level thread catwalk_goal_control();
}

function cloudmountain_breadcrumbs() {
  objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_warehouse"));
  objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain01"));
  objectives::hide("cp_waypoint_breadcrumb");
  trigger::wait_till("trig_level_2_enemy_spawns_1");
  objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain01"));
  objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain02"));
  trigger::wait_till("trig_breadcrumb_cloudmountain_03");
  objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain02"));
  objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain03"));
  trigger::wait_till("trig_breadcrumb_cloudmountain_04");
  objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain03"));
  objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_04"));
  trigger::wait_till("trig_level_3_catwalk_reinforcements");
  objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain04"));
  objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_end"));
  trigger::wait_till("trig_breadcrumb_cloudmountain_end");
  objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_end"));
}

function objective_cloudmountain_init(str_objective, b_starting) {
  cp_mi_sing_biodomes_util::objective_message("objective_cloudmountain_init");
  if(b_starting) {
    load::function_73adcefc();
    cp_mi_sing_biodomes_util::init_hendricks(str_objective);
    cp_mi_sing_biodomes::function_cef897cf(str_objective);
    level flag::set("back_door_opened");
    e_player_clip = getent("back_door_player_clip", "targetname");
    e_player_clip delete();
    spawn_manager::enable("cloud_mountain_siegebot_manager");
    level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
    level thread cp_mi_sing_biodomes_warehouse::function_cb52a73();
    level thread cp_mi_sing_biodomes_warehouse::squad_control_final_orders();
    level thread cp_mi_sing_biodomes_util::function_cc20e187("warehouse");
    level thread cp_mi_sing_biodomes_util::function_cc20e187("cloudmountain", 1);
    load::function_a2995f22();
  }
  hidemiscmodels("fxanim_markets2");
  level thread namespace_f1b4cbbc::function_2e34977e();
  level thread cloudmountain_main();
}

function cloudmountain_main() {
  level thread cloudmountain_breadcrumbs();
  level thread cloudmountain_elevators();
  level thread catwalk_supertree_spawns();
  level thread function_d532cc21();
  spawner::add_spawn_function_ai_group("cloud_mountain_entrance_bridge", & function_4df7264d);
  spawn_manager::enable("manager_phalanx_humans_bridge");
  level thread function_a234f527();
  level thread function_efae47c8();
  level thread function_9a10cb7d();
  level thread cloud_mountain_reinforcements();
  level thread function_333f5b5b();
  level thread cp_mi_sing_biodomes_warehouse::glass_break("trig_cloudmountain_glass1");
  level thread cp_mi_sing_biodomes_warehouse::glass_break("trig_cloudmountain_glass2");
  level thread cp_mi_sing_biodomes_warehouse::glass_break("trig_cloudmountain_glass3");
  trigger::wait_till("trig_cloud_mountain_level_2_start");
  level.ai_hendricks colors::enable();
  level.ai_hendricks clearforcedgoal();
  skipto::objective_completed("objective_cloudmountain");
}

function function_9a10cb7d() {
  level endon("hash_19af2c9a");
  level waittill("hash_ce48e0c4");
  spawn_manager::enable("manager_phalanx_humans_overhead");
}

function function_efae47c8() {
  spawn_manager::wait_till_complete("cloud_mountain_siegebot_manager");
  var_c81e3075 = spawn_manager::get_ai("cloud_mountain_siegebot_manager");
  objectives::set("cp_level_biodomes_siegebot", var_c81e3075);
  foreach(var_51a7831a in var_c81e3075) {
    var_51a7831a thread function_7ec07da9();
  }
  var_60104d0b = level util::waittill_any_return("cloudmountain_siegebots_dead", "cloudmountain_siegebots_skipped");
  if(var_60104d0b == "cloudmountain_siegebots_skipped") {
    level thread function_f6a70610(var_c81e3075);
  }
  objectives::set("cp_level_biodomes_servers");
  objectives::complete("cp_level_biodomes_siegebot");
}

function function_7ec07da9() {
  level endon("hash_1530fdbd");
  level endon("hash_b6c3b80a");
  self waittill("death", e_attacker);
  objectives::hide_for_target("cp_level_biodomes_siegebot", self);
  wait(1);
  battlechatter::function_d9f49fba(0);
  if(isplayer(e_attacker)) {
    level dialog::player_say("plyr_siege_bot_is_s_o_l_0");
    var_7a45cb6d = "hendricks";
  } else {
    level.ai_hendricks dialog::say("hend_that_fucker_s_done_0");
    var_7a45cb6d = "player";
  }
  battlechatter::function_d9f49fba(1);
  var_dcd92b65 = spawner::get_ai_group_ai("cloudmountain_siegebots");
  if(var_dcd92b65.size) {
    var_dcd92b65[0] thread function_1932917(var_7a45cb6d);
    level notify("hash_1530fdbd");
  } else {
    level function_a1fa89a2();
  }
}

function function_1932917(var_f7824075) {
  self waittill("death");
  level endon("hash_b6c3b80a");
  objectives::hide_for_target("cp_level_biodomes_siegebot", self);
  wait(1);
  battlechatter::function_d9f49fba(0);
  if(var_f7824075 == "player") {
    level dialog::player_say("plyr_siege_bot_is_s_o_l_0");
  } else if(var_f7824075 == "hendricks") {
    level.ai_hendricks dialog::say("hend_that_fucker_s_done_0");
  }
  battlechatter::function_d9f49fba(1);
  level function_a1fa89a2();
}

function function_f6a70610(var_c81e3075) {
  level waittill("hash_69d6458d");
  foreach(var_51a7831a in var_c81e3075) {
    if(isalive(var_51a7831a)) {
      var_51a7831a kill();
    }
  }
}

function function_a1fa89a2() {
  level flag::set("cloudmountain_siegebots_dead");
  level thread namespace_f1b4cbbc::function_973b77f9();
  level thread cp_mi_sing_biodomes_util::aigroup_retreat("cloud_mountain_entrance_bridge", "cloudmountain_lobby_retreat_volume", 2, 4);
  trigger::use("trig_hendricks_lobby_entrance_colors", "targetname", undefined, 0);
  savegame::checkpoint_save();
}

function function_a234f527() {
  battlechatter::function_d9f49fba(0);
  level.ai_hendricks dialog::say("hend_they_gotta_siege_bot_0");
  level.ai_hendricks dialog::say("hend_we_don_t_have_the_fi_0", 2);
  level dialog::remote("kane_it_s_heavily_armored_0");
  battlechatter::function_d9f49fba(1);
  level util::waittill_either("cloudmountain_siegebots_dead", "cloudmountain_siegebots_skipped");
  wait(2);
  level thread vo_cloud_mountain_intro();
}

function vo_cloud_mountain_intro(var_b146902 = 0) {
  if(!var_b146902) {
    battlechatter::function_d9f49fba(0);
    level dialog::remote("kane_server_room_s_locate_0", 1);
    objectives::show("cp_waypoint_breadcrumb");
    level.ai_hendricks dialog::say("hend_guess_we_re_going_up_0");
    battlechatter::function_d9f49fba(1);
  }
  level thread function_170b0353(var_b146902);
  level thread namespace_f1b4cbbc::function_6c35b4f3();
  trigger::wait_till("trig_cloud_mountain_level_2_start");
  wait(2);
  battlechatter::function_d9f49fba(0);
  level dialog::player_say("plyr_third_floor_where_n_0");
  level dialog::remote("kane_server_room_directly_0");
  battlechatter::function_d9f49fba(1);
  level notify("hash_e36f3648");
}

function function_170b0353(var_b146902 = 0) {
  level endon("hash_be472a4a");
  if(!var_b146902) {
    if(!level flag::get("cloudmountain_second_floor_vo")) {
      trigger::wait_till("trig_cloudmountain_second_floor_vo");
      battlechatter::function_d9f49fba(0);
      level.ai_hendricks dialog::say("hend_take_the_second_floo_0");
      level dialog::remote("kane_ex_fil_on_marker_bi_0", 1);
      level.ai_hendricks dialog::say("hend_copy_that_0");
      battlechatter::function_d9f49fba(1);
    }
  }
  level waittill("hash_e36f3648");
  wait(5);
  battlechatter::function_d9f49fba(0);
  level dialog::remote("kane_you_need_to_hustle_0");
  battlechatter::function_d9f49fba(1);
  level flag::wait_till("cloudmountain_hunter_spawned");
  battlechatter::function_d9f49fba(0);
  level.ai_hendricks dialog::say("hend_kane_they_gotta_hun_0", 2);
  level dialog::remote("kane_do_not_engage_the_hu_1");
  level dialog::remote("kane_long_as_you_re_in_th_0");
  level.ai_hendricks dialog::say("hend_fan_fucking_tastic_1");
  level.ai_hendricks dialog::say("hend_more_reinforcements_0", 2);
  level dialog::remote("kane_leave_em_goh_xiula_0");
  battlechatter::function_d9f49fba(1);
  if(!level flag::get("end_level_2_sniper_vo")) {
    foreach(player in level.activeplayers) {
      player thread function_e2e19ed7("cm_level_2_snipers", "end_level_2_sniper_vo");
    }
  }
  level flag::wait_till("cloudmountain_level_3_catwalk_vo");
  level flag::set("end_level_2_sniper_vo");
  if(!level flag::get("end_level_3_sniper_vo")) {
    battlechatter::function_d9f49fba(0);
    level.ai_hendricks dialog::say("hend_they_re_on_the_walkw_0", 1);
    battlechatter::function_d9f49fba(1);
    foreach(player in level.activeplayers) {
      player thread function_e2e19ed7("cm_level_3_snipers", "end_level_3_sniper_vo");
    }
  }
}

function function_e2e19ed7(str_ai_group, str_endon_flag) {
  level endon(str_endon_flag);
  self endon("death");
  var_4d8945 = 0;
  while(!var_4d8945) {
    self waittill("damage", n_damage, e_attacker);
    a_ai_snipers = spawner::get_ai_group_ai(str_ai_group);
    if(a_ai_snipers.size) {
      foreach(ai_sniper in a_ai_snipers) {
        if(ai_sniper == e_attacker) {
          a_dialogue_lines = [];
          if(str_ai_group == "cm_level_2_snipers") {
            a_dialogue_lines[0] = "hend_sniper_spotted_on_th_0";
            a_dialogue_lines[1] = "hend_i_got_a_sniper_on_th_0";
          } else {
            a_dialogue_lines[0] = "hend_54i_sniper_on_the_ba_0";
            a_dialogue_lines[1] = "hend_sniper_on_the_walkwa_0";
          }
          battlechatter::function_d9f49fba(0);
          level.ai_hendricks dialog::say(cp_mi_sing_biodomes_util::vo_pick_random_line(a_dialogue_lines));
          battlechatter::function_d9f49fba(1);
          var_4d8945 = 1;
          break;
        }
      }
    } else {
      break;
    }
  }
  level flag::set(str_endon_flag);
}

function function_333f5b5b() {
  level endon("hash_a68d9993");
  trigger::wait_till("trig_cloudmountain_first_floor_backup");
  spawn_manager::enable("sm_cloudmountain_level_2_amws");
  spawn_manager::enable("sm_cloudmountain_level_2_warlord");
  savegame::checkpoint_save();
  spawn_manager::wait_till_complete("sm_cloudmountain_level_2_amws");
  spawner::waittill_ai_group_ai_count("cloudmountain_first_floor_backup", 0);
  var_f62f0db4 = getnode("hendricks_cloudmountain_stairs", "targetname");
  level.ai_hendricks colors::disable();
  level.ai_hendricks setgoal(var_f62f0db4, 1);
}

function function_a288e474() {
  self endon("death");
  self.goalradius = 1024;
  self.goalheight = 320;
  self setgoal(level.activeplayers[0]);
  self warlordinterface::setwarlordaggressivemode(1);
  self cp_mi_sing_biodomes_util::function_f61c0df8("node_cloud_mountain_warlord_preferred", 1, 2);
}

function function_7dffd386() {
  trigger::wait_till("trig_cloudmountain_first_floor_backup");
  if(!level flag::get("stalagtites_dropped")) {
    trigger::use("cloudmountain_entrance_stalagmite_01");
  }
}

function objective_cloudmountain_done(str_objective, b_starting, b_direct, player) {
  cp_mi_sing_biodomes_util::objective_message("objective_cloudmountain_done");
}

function function_8ce887a2(str_objective, b_starting, b_direct, player) {
  if(b_starting) {
    load::function_73adcefc();
    objectives::set("cp_level_biodomes_servers");
    cp_mi_sing_biodomes_util::init_hendricks(str_objective);
    level flag::set("back_door_opened");
    e_player_clip = getent("back_door_player_clip", "targetname");
    e_player_clip delete();
    var_31861e2e = getent("trig_level_2_robot_spawns", "targetname");
    if(isDefined(var_31861e2e)) {
      var_31861e2e delete();
    }
    function_8232942d();
    function_56019233();
    level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
    level.ai_hendricks colors::enable();
    level thread cloudmountain_breadcrumbs();
    level thread catwalk_supertree_spawns();
    level thread cloud_mountain_reinforcements();
    level thread cp_mi_sing_biodomes_util::function_cc20e187("cloudmountain");
    load::function_a2995f22();
    level thread vo_cloud_mountain_intro(1);
    level thread function_170b0353(1);
  }
  spawn_manager::enable("sm_cloud_mountain_riot_shield");
  level.ai_hendricks.goalradius = 256;
  trigger::wait_till("trig_turret_hallway_enemy_spawns");
  skipto::objective_completed("objective_cloudmountain_level_2");
}

function function_2013f39c(str_objective, b_starting, b_direct, player) {
  cp_mi_sing_biodomes_util::objective_message("objective_cloudmountain_level_2_done");
}

function function_8232942d() {
  var_82ac908a = getent("trig_cloudmountain_left_stairs_spawns", "targetname");
  var_82ac908a delete();
  var_7870fb88 = getent("trig_sm_level_1_rushers", "targetname");
  var_7870fb88 delete();
}

function function_56019233() {
  var_b6a97ee5 = getEntArray("cloudmountain_level_1_glass_triggers", "script_noteworthy");
  foreach(t_glass in var_b6a97ee5) {
    glassradiusdamage(t_glass.origin, 100, 500, 500);
    t_glass delete();
  }
}

function exhibit_audio(str_ident) {
  level endon("turret_hallway_clear");
  t_exhibit = getent("trig_exhibit_" + str_ident, "targetname");
  while(true) {
    t_exhibit trigger::wait_till();
    switch (str_ident) {
      case "A": {
        t_exhibit dialog::say("Welcome to the Cloud Forest wildlife exhibit. Please take a moment to read the rules of conduct.", 0, 1);
        break;
      }
      case "B": {
        t_exhibit dialog::say("Hundreds of different animal species make their home among the flora of Cloud Forests across Southeast Asia.", 0, 1);
        break;
      }
      case "C": {
        t_exhibit dialog::say("Amphibians such as this Spotted Tree Frog are particularly well suited to the unique climate found here.", 0, 1);
        break;
      }
      case "D": {
        t_exhibit dialog::say("Tree Shrews are descended from one of the earliest known mammals on earth. They forage in the dense undergrowth at all hours of the day.", 0, 1);
        break;
      }
      case "E": {
        t_exhibit dialog::say("Up ahead is the overlook and elevator access to the Cloud Walk. Watch your step! Walkways are slippery when wet.", 0, 1);
        break;
      }
    }
    wait(15);
  }
}

function catwalk_supertree_spawns() {
  trigger::wait_till("level_2_catwalk_spawns", "targetname");
  e_door = getent("dome_side_door", "targetname");
  e_door connectpaths();
  e_door movez(100, 2);
  e_door waittill("movedone");
  level flag::wait_till("supertree_door_close");
  e_door movez(-100, 2);
}

function function_d532cc21() {
  level flag::init("stalagtites_dropped");
  var_897e5d1 = struct::get("stalactite_kill_zone", "targetname");
  trigger::wait_till("cloudmountain_entrance_stalagmite_01");
  level thread scene::play("p7_fxanim_cp_biodomes_stalagmite_01_bundle");
  level waittill("hash_422a3570");
  var_2ef43a6a = getdamageableentarray(var_897e5d1.origin, var_897e5d1.radius);
  var_2ef43a6a = array::exclude(var_2ef43a6a, level.activeplayers);
  if(var_2ef43a6a.size > 0) {
    namespace_769dc23f::function_8ca89944();
    foreach(victim in var_2ef43a6a) {
      victim kill();
    }
  }
  level flag::set("stalagtites_dropped");
}

function hunter_flyby_cloud_mountain() {
  self endon("death");
  level flag::set("cloudmountain_hunter_spawned");
  self ai::set_ignoreme(1);
  self ai::set_ignoreall(1);
  self.nocybercom = 1;
  nd_start = getvehiclenode(self.target, "targetname");
  if(isDefined(nd_start)) {
    self vehicle_ai::start_scripted();
    self vehicle::get_on_and_go_path(nd_start);
    self delete();
  }
}

function cloud_mountain_reinforcements_spawn() {
  self endon("death");
  self ai::set_ignoreme(1);
}

function cloud_mountain_retreaters_spawn() {
  self endon("death");
  self ai::set_ignoreme(1);
  nd_goal = getnode(self.target, "targetname");
  if(isDefined(nd_goal)) {
    self setgoal(nd_goal, 1);
    self waittill("goal");
  }
  self delete();
}

function cloud_mountain_level_3_surprised() {
  self endon("death");
  self.goalradius = 4;
  self ai::set_ignoreall(1);
  trigger::wait_till("trig_lookat_level_3_surprised");
  wait(randomfloatrange(0.1, 0.5));
  self scene::play("cin_gen_vign_confusion_02", self);
  t_goal = getent("trig_level_3_catwalks_goal", "targetname");
  if(isDefined(t_goal)) {
    self setgoal(t_goal);
    self waittill("goal");
  }
  self ai::set_ignoreall(0);
  self.goalradius = 1024;
}

function robot_pod_spawn() {
  self endon("death");
  self ai::set_ignoreme(1);
  self thread cleanup_pod_robots();
  e_pod = getent(self.target, "targetname");
  e_pod thread scene::init("p7_fxanim_cp_sgen_charging_station_open_01_bundle", e_pod);
  str_scene = "cin_bio_07_03_climb_aie_charging_station";
  s_align = struct::get(e_pod.target, "targetname");
  s_align thread scene::init(str_scene, self);
  while(true) {
    b_player_sees_me = 0;
    foreach(player in level.players) {
      n_distance_sq = distance2dsquared(self.origin, player.origin);
      if(player util::is_player_looking_at(self.origin) && n_distance_sq < 1000000 || n_distance_sq < 360000) {
        b_player_sees_me = 1;
        break;
      }
    }
    if(b_player_sees_me) {
      break;
    }
    wait(0.05);
  }
  s_align thread scene::play(str_scene, self);
  self waittill("glass_break");
  e_pod thread scene::play("p7_fxanim_cp_sgen_charging_station_open_01_bundle", e_pod);
  self ai::set_ignoreme(0);
  nd_best = self findbestcovernode();
  if(isDefined(nd_best)) {
    self setgoal(nd_best);
  }
}

function cleanup_pod_robots() {
  self endon("death");
  level waittill("cleanup_pod_robots");
  self delete();
}

function cloudmountain_elevators() {
  function_6f311542();
  trigger::wait_till("trig_cloudmountain_elevators");
  spawner::simple_spawn("cloudmountain_elevator_enemy", & elevator_spawning, "cloudmountain");
}

function catwalk_goal_control() {
  a_catwalk_spawners = getspawnerarray("catwalk", "script_noteworthy");
  for(i = 0; i < a_catwalk_spawners.size; i++) {
    a_catwalk_spawners[i] spawner::add_spawn_function( & catwalk_goal_radius);
  }
}

function catwalk_goal_radius() {
  self.goalradius = 400;
}

function disable_cloudmountain_triggers() {
  a_spawn_triggers = getEntArray("cloudmountain_spawn_trigger", "script_noteworthy");
  foreach(trigger in a_spawn_triggers) {
    trigger delete();
  }
  function_8232942d();
}

function cloud_mountain_reinforcements() {
  trigger::wait_till("trig_cloud_mountain_reinforcements");
  spawner::add_spawn_function_group("sp_cloud_mountain_reinforcements_wasps", "targetname", & function_947a1ae8);
  spawn_manager::enable("sm_cloud_mountain_reinforcements");
  spawn_manager::enable("sm_cloud_mountain_reinforcements_wasps");
  spawn_manager::enable("sm_cloud_mountain_retreaters");
}

function objective_turret_hallway_init(str_objective, b_starting) {
  cp_mi_sing_biodomes_util::objective_message("turret_hallway_init");
  if(!sessionmodeiscampaignzombiesgame()) {
    level scene::init("server_room_access_start", "targetname");
  }
  objectives::complete("cp_waypoint_breadcrumb", struct::get("breadcrumb_cloudmountain_end"));
  if(b_starting) {
    load::function_73adcefc();
    cp_mi_sing_biodomes_util::init_hendricks(str_objective);
    level.ai_hendricks notify("stop_following");
    level.ai_hendricks colors::enable();
    objectives::set("cp_level_biodomes_servers");
    level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
    level thread cp_mi_sing_biodomes_util::function_cc20e187("cloudmountain");
    disable_cloudmountain_triggers();
    load::function_a2995f22();
    level thread namespace_f1b4cbbc::function_6c35b4f3();
  }
  level flag::init("turret_hallway_phalanx_dead");
  level thread function_ee13f890();
  level thread function_3679c70a();
  level thread turret_hallway_phalanx();
  level thread turret_hallway_lights();
  spawner::waittill_ai_group_cleared("turret_hallway_group");
  function_58b4a5d6();
  level flag::set("turret_hall_clear");
  foreach(player in level.players) {
    if(player laststand::player_is_in_laststand()) {
      player laststand::auto_revive(player, 0);
    }
    if(isalive(player.hijacked_vehicle_entity)) {
      player.hijacked_vehicle_entity cybercom_gadget_security_breach::function_664c9cd6();
    }
  }
  skipto::objective_completed("objective_turret_hallway");
}

function function_3679c70a() {
  level flag::wait_till("hendricks_near_turrets");
  battlechatter::function_d9f49fba(0);
  var_9d979b27 = getaiarray("hallway_turret", "script_noteworthy");
  if(var_9d979b27.size > 0) {
    level.ai_hendricks dialog::say("hend_focus_on_the_turrets_0");
  }
  var_9d979b27 = getaiarray("hallway_turret", "script_noteworthy");
  if(var_9d979b27.size > 0) {
    var_653d9a07 = 0;
    var_85ee3d97 = 0;
    foreach(player in level.activeplayers) {
      if(isDefined(player.grenadetypesecondary.isemp) && player.grenadetypesecondary.isemp && player.grenadetypesecondarycount > 0) {
        var_653d9a07 = 1;
      }
      if(isDefined(player.grenadetypeprimary) && player.grenadetypeprimarycount > 0) {
        var_85ee3d97 = 1;
      }
    }
    if(var_653d9a07) {
      level dialog::remote("kane_your_emp_grenade_sho_0");
    } else if(var_85ee3d97) {
      level dialog::remote("kane_toss_a_frag_in_there_0");
    }
  }
}

function turret_hallway_phalanx() {
  level flag::wait_till("turret_hallway_phalanx");
  level flag::set("end_level_3_sniper_vo");
  v_start = struct::get("turret_hallway_phalanx_start").origin;
  v_end = struct::get("turret_hallway_phalanx_end").origin;
  n_phalanx = 2;
  if(level.a_ai_squad.size > 0) {
    n_phalanx = 3;
  }
  phalanx = new robotphalanx();
  [[phalanx]] - > initialize("phalanx_diagonal_left", v_start, v_end, 1, n_phalanx);
  while(((phalanx.tier1robots_.size + phalanx.tier2robots_.size) + phalanx.tier3robots_.size) > 0) {
    wait(0.25);
  }
  level flag::set("turret_hallway_phalanx_dead");
}

function turret_hallway_lights() {
  exploder::exploder("turret_light");
  trigger::wait_till("trig_turret_lights_damaged", "targetname");
  exploder::kill_exploder("turret_light");
  exploder::exploder("fx_turrethallway_turret_smk");
  scene::play("p7_fxanim_gp_floodlight_01_bundle");
}

function function_2c72fa5a() {
  self turret::enable_laser(1, 0);
  switch (self.script_string) {
    case "turret_left": {
      objectives::set("cp_level_biodomes_cloud_mountain_turret_left", self);
      self waittill("death");
      objectives::complete("cp_level_biodomes_cloud_mountain_turret_left", self);
      break;
    }
    case "turret_right": {
      objectives::set("cp_level_biodomes_cloud_mountain_turret_right", self);
      self waittill("death");
      objectives::complete("cp_level_biodomes_cloud_mountain_turret_right", self);
      break;
    }
  }
}

function function_d8eaa27f(var_9d979b27) {
  level endon("turret_hall_clear");
  function_c80e1213("turret_left");
  function_c80e1213("turret_right");
}

function function_c80e1213(str_turret) {
  nd_cover = getnode("hendricks_" + str_turret, "targetname");
  level.ai_hendricks setgoal(nd_cover, 1);
  a_turrets = getaiarray(str_turret, "script_label");
  if(isalive(a_turrets[0])) {
    level.ai_hendricks settargetentity(a_turrets[0]);
    while(isalive(a_turrets[0])) {
      wait(0.05);
    }
  }
}

function function_ee13f890() {
  level flag::wait_till("a_player_sees_hallway_turrets");
  objectives::complete("cp_level_biodomes_servers");
  objectives::set("cp_level_biodomes_destroy_hallway_turrets");
  var_9d979b27 = getaiarray("hallway_turret", "script_noteworthy");
  foreach(var_c316ad54 in var_9d979b27) {
    var_c316ad54 thread function_2c72fa5a();
  }
  level flag::wait_till("turret_hallway_phalanx_dead");
  function_d8eaa27f(var_9d979b27);
}

function function_58b4a5d6() {
  var_a4854031 = 1;
  while(var_a4854031) {
    wait(1);
    var_a4854031 = function_50c932d0();
  }
}

function function_50c932d0() {
  var_53efc9b3 = getent("turret_hallway_enemy_check_volume", "targetname");
  a_enemy_ai = getaispeciesarray("axis", "all");
  foreach(e_enemy in a_enemy_ai) {
    if(e_enemy istouching(var_53efc9b3)) {
      return true;
    }
  }
  return false;
}

function objective_turret_hallway_done(str_objective, b_starting, b_direct, player) {
  objectives::complete("cp_level_biodomes_destroy_hallway_turrets");
  objectives::set("cp_level_biodomes_awaiting_update");
  cp_mi_sing_biodomes_util::objective_message("turret_hallway_done");
  getent("trig_turret_hallway_enemy_spawns", "targetname") delete();
  getent("trig_turret_hallway_defender_spawns", "targetname") delete();
}

function objective_xiulan_vignette_init(str_objective, b_starting) {
  cp_mi_sing_biodomes_util::objective_message("xiulan_vignette_init");
  cp_mi_sing_biodomes_util::enable_traversals(0, "server_room_window_mantle", "script_noteworthy");
  level thread util::set_streamer_hint(2);
  if(b_starting) {
    load::function_73adcefc();
    cp_mi_sing_biodomes_util::init_hendricks(str_objective);
    level.ai_hendricks.goalradius = 32;
    objectives::set("cp_level_biodomes_awaiting_update");
    disable_cloudmountain_triggers();
    level scene::init("server_room_access_start", "targetname");
    level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
    var_777355da = getEntArray("hallway_turret", "script_noteworthy");
    a_turrets = spawner::simple_spawn(var_777355da);
    array::run_all(a_turrets, & kill);
    level thread cp_mi_sing_biodomes_util::function_cc20e187("cloudmountain");
    load::function_a2995f22();
  }
  level.ai_hendricks colors::disable();
  var_5cb57398 = getnode("nd_turret_win_idle", "targetname");
  level.ai_hendricks setgoal(var_5cb57398);
  level thread setup_server_room_door_use_object();
  e_clip = getent("turret_hallway_door_ai_clip", "targetname");
  e_clip delete();
  var_e5214b43 = getent("server_room_initial_bullet_brush_outer", "targetname");
  var_e5214b43 hide();
  var_f3ad8f26 = getent("server_room_initial_bullet_brush_inner", "targetname");
  var_f3ad8f26 hide();
  level thread scene::init("p7_fxanim_cp_biodomes_server_room_window_break_01_bundle");
  level vo_xiulan_intro();
}

function vo_xiulan_intro() {
  level thread namespace_f1b4cbbc::function_973b77f9();
  battlechatter::function_d9f49fba(0);
  level dialog::remote("kane_shit_she_s_uploadi_0");
  level dialog::remote("kane_it_s_uploading_direc_0");
  level notify("hash_9b74c38e");
  battlechatter::function_d9f49fba(1);
}

function look_down_hallway() {
  self endon("death");
  self waittill("goal");
  v_look = struct::get("hallway_look_target").origin;
  self orientmode("face direction", self.origin - v_look);
  self waittill("enemy");
  self orientmode("face enemy");
}

function xiulan_init() {
  self.ignoreme = 1;
}

function setup_server_room_door_use_object() {
  level waittill("hash_9b74c38e");
  v_offset = (0, 0, 0);
  t_door_use_object = getent("trig_server_room_door_use_object", "targetname");
  t_door_use_object show();
  e_door_use_object = util::init_interactive_gameobject(t_door_use_object, & "cp_level_biodomes_server_door", & "CP_MI_SING_BIODOMES_CLOUDMOUNTAIN_ACCESS_TERMINAL", & function_9a82e132);
  level waittill("hash_69d6458d");
  a_enemies = getaiteamarray("axis");
  array::run_all(a_enemies, & delete);
  level clientfield::set("set_exposure_bank", 1);
  level thread function_d28364c1();
  level thread dialog::player_say("plyr_we_have_to_take_her_0", 1);
  level thread namespace_f1b4cbbc::function_3919d226();
  level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh010", & function_2db7566e, "play");
  level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh020", & function_3de47a8b, "play");
  level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh090", & function_cbdd0b50, "play");
  level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh170", & function_7dedb1f0, "play");
  level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh190", & function_f1df85b9, "play");
  level scene::add_scene_func("cin_bio_09_accessdrives_3rd_sh260", & function_d065fdd0, "done");
  level.ai_hendricks.ignoreall = 1;
  if(isDefined(level.bzm_biodialogue3callback)) {
    level thread[[level.bzm_biodialogue3callback]]();
  }
  level scene::play("server_room_access_start", "targetname", level.var_f2be4c1f);
  skipto::objective_completed("objective_xiulan_vignette");
}

function function_934481ae(e_door) {
  objectives::set("cp_level_biodomes_server_door", e_door);
}

function function_9a82e132(e_player) {
  level.var_f2be4c1f = e_player;
  var_485a1dbf = struct::get("s_server_room_hack_pos");
  playsoundatposition("evt_hack_panel", var_485a1dbf.origin);
  self gameobjects::disable_object();
  objectives::complete("cp_level_biodomes_server_door");
  level notify("hash_69d6458d");
}

function function_2db7566e(a_ents) {
  foreach(player in level.players) {
    player cybercom::cybercom_armpulse(1);
    player clientfield::increment_to_player("hack_dni_fx");
  }
}

function function_7dedb1f0(a_ents) {
  level waittill("hash_f7774ee4");
  level thread hendricks_server_control_room_door_open(1);
  level waittill("hash_127c12ee");
  level flag::wait_till("server_control_room_door_open");
  level thread hendricks_server_control_room_door_open(0);
}

function function_d065fdd0(a_ents) {
  level notify("hash_d065fdd0");
  level clientfield::set("set_exposure_bank", 0);
  level util::teleport_players_igc("s_server_room_scene_end_warps");
  level thread util::clear_streamer_hint();
  videostart("cp_biodomes_env_serverhackvid4looping", 1);
}

function server_room_door_open(team, player, success) {
  if(isDefined(success) && success) {
    self gameobjects::disable_object();
    e_server_room_door = getent("server_room_door", "targetname");
    e_server_room_door movez(100, 2);
    e_server_room_door connectpaths();
    e_server_room_door waittill("movedone");
    e_server_room_door delete();
  }
}

function function_3de47a8b(a_ents) {
  videostart("cp_biodomes_env_serverhackvid1");
}

function function_cbdd0b50(a_ents) {
  videostart("cp_biodomes_env_serverhackvid2");
}

function function_f1df85b9(a_ents) {
  videostart("cp_biodomes_env_serverhackvid3");
}

function hendricks_server_control_room_door_open(b_open) {
  e_server_control_room_door = getent("server_control_room_door", "targetname");
  if(b_open) {
    e_server_control_room_door movey(50, 0.5);
    e_server_control_room_door waittill("movedone");
    level flag::set("server_control_room_door_open");
  } else {
    e_server_control_room_door movey(-50, 0.5);
    e_server_control_room_door waittill("movedone");
    level flag::clear("server_control_room_door_open");
  }
}

function objective_xiulan_vignette_done(str_objective, b_starting, b_direct, player) {
  cp_mi_sing_biodomes_util::objective_message("xiulan_vignette_done");
  objectives::complete("cp_level_biodomes_mainobj_capture_data_drives");
  e_server_room_door = getent("server_room_door", "targetname");
  if(isDefined(e_server_room_door)) {
    e_server_room_door connectpaths();
    e_server_room_door delete();
  }
  e_server_room_door_clip = getent("server_room_door_clip", "targetname");
  if(isDefined(e_server_room_door_clip)) {
    e_server_room_door_clip connectpaths();
    e_server_room_door_clip delete();
  }
  getent("trig_server_room_door_use_object", "targetname") delete();
}

function function_d28364c1() {
  level waittill("hash_67213d76");
  var_e5214b43 = getent("server_room_initial_bullet_brush_outer", "targetname");
  var_f3ad8f26 = getent("server_room_initial_bullet_brush_inner", "targetname");
  var_1c634edb = spawner::simple_spawn_single("server_room_initial_bullet_shooter");
  var_1c634edb endon("death");
  var_6b372cba = getnode("initial_shooter_node", "targetname");
  var_1c634edb setgoal(var_6b372cba, 1);
  if(!scene::is_skipping_in_progress()) {
    var_1c634edb ai::set_ignoreme(1);
    var_1c634edb ai::set_ignoreall(1);
    var_1c634edb.perfectaim = 1;
    level waittill("hash_ab045282");
    var_1c634edb ai::set_ignoreall(0);
    var_1c634edb ai::shoot_at_target("normal", var_e5214b43, "tag_origin");
    var_18ee9c37 = getent("trig_initial_bullet_damage", "targetname");
    var_18ee9c37 util::waittill_notify_or_timeout("damage", 3);
    var_1c634edb.perfectaim = 0;
    var_1c634edb ai::set_ignoreme(0);
    var_1c634edb clearforcedgoal();
  }
  var_1c634edb.script_accuracy = 0.05;
  var_e5214b43 show();
  var_f3ad8f26 show();
  wait(5);
  var_1c634edb.script_accuracy = 1;
}

function objective_server_room_defend_init(str_objective, b_starting) {
  cp_mi_sing_biodomes_util::objective_message("server_room_defend_init");
  objectives::complete("cp_level_biodomes_awaiting_update");
  getent("server_koolaid", "targetname") disconnectpaths();
  level thread function_a78ec4a();
  if(b_starting) {
    cp_mi_sing_biodomes_util::init_hendricks(str_objective);
    disable_cloudmountain_triggers();
    level hendricks_server_control_room_door_open(0);
    level thread scene::init("p7_fxanim_cp_biodomes_server_room_window_break_01_bundle");
    cp_mi_sing_biodomes_util::enable_traversals(0, "server_room_window_mantle", "script_noteworthy");
    var_777355da = getEntArray("hallway_turret", "script_noteworthy");
    a_turrets = spawner::simple_spawn(var_777355da);
    array::run_all(a_turrets, & kill);
    e_clip = getent("turret_hallway_door_ai_clip", "targetname");
    e_clip delete();
    level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
    level flag::wait_till("all_players_spawned");
    level thread util::delay_notify(1, "server_room_intro_done");
  }
  hidemiscmodels("fxanim_cloud_mountain");
  level thread function_17d3780e();
  level thread hendricks_works_the_computer(b_starting);
  level thread top_floor_flag();
  server_room_spawning();
  foreach(player in level.players) {
    if(player laststand::player_is_in_laststand()) {
      player laststand::auto_revive(player, 0);
    }
  }
  skipto::objective_completed("objective_server_room_defend");
}

function function_17d3780e() {
  level waittill("hash_d065fdd0");
  level notify("hash_5891b40a");
  objectives::set("cp_level_biodomes_defend_server_room", level.ai_hendricks);
}

function function_a78ec4a() {
  level trigger::wait_till("server_room_all_players_in");
  var_2d1826b2 = getent("turret_hallway_front_door", "targetname");
  var_f2087d4a = getent("turret_hallway_door_clip", "targetname");
  var_f2087d4a linkto(var_2d1826b2);
  var_2d1826b2 connectpaths();
  var_2d1826b2 movez(-100, 1);
  var_2d1826b2 waittill("movedone");
  var_2d1826b2 disconnectpaths();
}

function server_room_spawning() {
  level.a_window_targets = [];
  level.a_window_targets[0] = getent("server_room_window_target0", "targetname");
  level.a_window_targets[1] = getent("server_room_window_target1", "targetname");
  level.a_window_targets[2] = getent("server_room_window_target2", "targetname");
  level.a_window_targets[3] = getent("server_room_window_target3", "targetname");
  a_nodes = getnodearray("swat_node", "script_noteworthy");
  foreach(node in a_nodes) {
    setenablenode(node, 0);
  }
  spawner::add_spawn_function_group("server_room_enemy_window", "targetname", & function_229a8bc9);
  spawner::add_spawn_function_group("server_room_enemy_elevator1", "targetname", & elevator_spawning, "server_room");
  spawner::add_spawn_function_group("server_room_enemy_elevator2", "targetname", & elevator_backup, "server_room");
  spawner::add_spawn_function_group("server_room_enemy_swat1", "targetname", & swat_team_ai);
  level waittill("hash_d065fdd0");
  level thread dialog::remote("kane_he_s_fine_0");
  savegame::checkpoint_save();
  level thread namespace_f1b4cbbc::function_46333a8a();
  playsoundatposition("evt_server_def_walla_1st", (603, 12812, 1184));
  playsoundatposition("evt_server_def_walla_2nd", (900, 12750, 1140));
  level notify("hash_f3c45157");
  wait(2);
  spawner::simple_spawn("server_room_enemy_window");
  spawner::add_spawn_function_ai_group("top_floor", & top_floor_door);
  spawn_manager::enable("server_room_wave_2_1");
  level util::waittill_notify_or_timeout("top_floor_breached", 10);
  spawn_manager::enable("server_room_wave_2_2");
  if(level flag::get("top_floor_breached")) {
    level thread dialog::player_say("plyr_breach_on_the_second_0");
  }
  if(level.players.size < 3) {
    wave_wait(1, 15, "top_floor");
  } else {
    wave_wait(2, 10, "top_floor");
  }
  savegame::checkpoint_save();
  level thread dialog::remote("kane_download_at_twenty_p_0");
  playsoundatposition("evt_server_def_walla_3rd", (900, 12750, 1140));
  spawner::add_spawn_function_group("sp_server_room_background", "targetname", & cp_mi_sing_biodomes_fighttothedome::function_76c56ee1);
  spawn_manager::enable("sm_server_room_background");
  level thread function_963807b1();
  level waittill("zipline_spawning_done");
  if(level.players.size > 2) {
    wave_wait(3, 10, "window", "top_floor", "hallway");
  } else {
    wave_wait(3, 45, "window", "top_floor");
  }
  savegame::checkpoint_save();
  level dialog::remote("kane_download_at_forty_pe_0");
  playsoundatposition("evt_server_def_walla_bots_a", (1117, 13871, 1116));
  level function_88e395d2();
  spawner::simple_spawn("server_room_enemy_elevator1");
  if(level.players.size > 2) {
    spawner::simple_spawn("server_room_enemy_elevator2");
  }
  level thread swat_team_control();
  if(level.players.size > 2) {
    wave_wait(5, 45, "hallway", "top_floor");
  } else {
    wave_wait(8, 30, "hallway");
  }
  savegame::checkpoint_save();
  level function_88e395d2();
  spawner::simple_spawn("server_room_enemy_elevator1");
  if(level.players.size > 2) {
    spawner::simple_spawn("server_room_enemy_elevator2");
    wait(2);
    spawn_manager::enable("server_room_topfloor_fodder_manager", & set_goal_server_room);
  }
  level dialog::player_say("plyr_more_hostiles_from_t_0");
  level thread dialog::remote("kane_download_at_sixty_pe_0", 1);
  playsoundatposition("evt_server_def_walla_bots_b", (1117, 13871, 1116));
  wave_wait(2, 5, "hallway");
  if(level.players.size > 1) {
    spawn_manager::enable("server_room_fodder_manager_stairs", & set_goal_server_room);
  }
  spawn_manager::kill("server_room_topfloor_fodder_manager");
  wave_wait(0, 25, "top_floor", "hallway", "window");
  savegame::checkpoint_save();
  level dialog::player_say("plyr_we_gotta_get_the_hel_0");
  level thread dialog::remote("kane_download_at_eighty_p_0");
  playsoundatposition("evt_server_def_walla_4th", (1278, 13578, 1276));
  wait(3);
  function_560d15cf();
  wait(3);
  spawn_manager::enable("server_room_final_wave_manager", & set_goal_server_room);
  wave_wait(2, 2, "final_wave");
  spawn_manager::enable("server_room_fodder_manager_stairs", & set_goal_server_room);
  if(level.players.size > 2) {
    wait(0.25);
    spawner::simple_spawn("server_room_enemy_hallway_final");
    a_hallway_guys = getEntArray("server_room_enemy_hallway_final_ai", "targetname");
    level thread toss_smoke_grenade(a_hallway_guys, "smoke_grenade_final_hallway1_start");
    wait(2);
    a_hallway_guys = getEntArray("server_room_enemy_hallway_final_ai", "targetname");
  }
  wave_wait(3, 30, "hallway", "top_floor", "final_wave");
  spawn_manager::kill("server_room_fodder_manager_stairs");
  if(isalive(level.ai_warlord)) {
    level.ai_warlord waittill("death");
    level.ai_warlord warlordinterface::clearallpreferedpoints();
  }
  if(isDefined(level.bzmutil_waitforallzombiestodie)) {
    [[level.bzmutil_waitforallzombiestodie]]();
  }
  wait(2);
  savegame::checkpoint_save();
  level thread dialog::remote("kane_download_complete_e_0");
  spawn_manager::kill("server_room_final_wave_manager");
  function_7ed3a33e();
  wave_wait(0, 60, "window", "top_floor", "hallway", "final_wave");
  do {
    var_70369b18 = 0;
    a_enemies = getaiteamarray("axis");
    foreach(ai_enemy in a_enemies) {
      if(isalive(ai_enemy)) {
        if(ai_enemy.archetype === "human" || ai_enemy.archetype === "robot") {
          var_70369b18 = 1;
        }
      }
    }
    wait(0.05);
  }
  while(var_70369b18);
  level notify("server_defend_done");
}

function function_229a8bc9() {
  self endon("death");
  self ai::set_behavior_attribute("sprint", 1);
  self util::waittill_any("goal", "near_goal");
  self ai::set_behavior_attribute("sprint", 0);
  str_scene_name = "cin_bio_10_01_serverroom_aie_breakin_enemy0" + self.script_int;
  self scene::init(str_scene_name, self);
  level waittill("vtol_spawned");
  self scene::play(str_scene_name, self);
  level flag::wait_till("window_broken");
  self setgoal(getent("server_room_entrance_goal_volume", "targetname"));
}

function toss_smoke_grenade(a_enemies, str_grenade_start_struct) {
  w_smoke_grenade = getweapon("willy_pete_nd");
  s_throw_start = struct::get(str_grenade_start_struct, "targetname");
  s_throw_end = struct::get(s_throw_start.target, "targetname");
  v_throw = (vectornormalize(s_throw_end.origin - s_throw_start.origin)) * 200;
  foreach(ai in a_enemies) {
    if(isalive(ai) && isweapon(w_smoke_grenade)) {
      s_throw_end fx::play("smoke_grenade", s_throw_end.origin);
      break;
      continue;
    }
    s_throw_end fx::play("smoke_grenade", s_throw_end.origin);
    break;
  }
}

function function_560d15cf() {
  s_smash = struct::get("warlord_smash", "targetname");
  playsoundatposition("evt_breach_warning", s_smash.origin);
  wait(2);
  level thread scene::play("p7_fxanim_cp_biodomes_warlord_breach_01_bundle");
  playrumbleonposition("cp_biodomes_server_room_breach_rumble", s_smash.origin);
  spawn_manager::enable("sm_server_room_riot_shield_breach");
  e_warlord_entrance = getent("server_koolaid", "targetname");
  e_warlord_entrance connectpaths();
  e_warlord_entrance delete();
  level thread dialog::remote("kane_hostiles_breaching_t_0", 1);
}

function function_7ed3a33e() {
  var_e17601b = [];
  var_ca9eeae1 = spawner::get_ai_group_ai("window");
  var_4ba8bf11 = spawner::get_ai_group_ai("top_floor");
  var_ef02bf0d = spawner::get_ai_group_ai("hallway");
  var_be5f20b9 = spawner::get_ai_group_ai("final_wave");
  var_e17601b = arraycombine(var_ca9eeae1, var_4ba8bf11, 1, 0);
  var_e17601b = arraycombine(var_e17601b, var_ef02bf0d, 1, 0);
  var_e17601b = arraycombine(var_e17601b, var_be5f20b9, 1, 0);
  e_goal = getent("server_room_window_goal_volume", "targetname");
  foreach(enemy in var_e17601b) {
    enemy setgoal(e_goal, 1);
  }
}

function wait_for_position(ai_shooter) {
  ai_shooter endon("death");
  ai_shooter.ignoreall = 1;
  e_window_volume = getent("server_room_window_goal_volume", "targetname");
  while(ai_shooter istouching(e_window_volume) == 0) {
    wait(0.1);
    if(self getvelocity() == 0) {
      ai_shooter setgoal(getnode("server_window_node", "targetname"));
    }
  }
  ai_shooter.ignoreall = 0;
}

function shoot_at_window() {
  self endon("death");
  e_server_room = getent("server_room_entrance_goal_volume", "targetname");
  if(level flag::get("window_broken") == 0) {
    wait_for_position(self);
  } else {
    self setgoal(e_server_room);
    return;
  }
  while(level flag::get("window_broken") == 0) {
    e_window_target = arraygetclosest(self.origin, level.a_window_targets);
    self ai::shoot_at_target("normal", e_window_target, undefined, 1);
    wait(1);
  }
  self setgoal(getnode("server_room_goal", "targetname"), 0, 256);
  self util::waittill_any("goal", "near_goal");
  self setgoal(e_server_room);
}

function hendricks_works_the_computer(b_starting) {
  if(level scene::is_active("cin_bio_09_02_accessdrives_1st_sever_end_loop")) {
    level scene::stop("cin_bio_09_02_accessdrives_1st_sever_end_loop");
  }
  level waittill("hash_d065fdd0");
  level.ai_hendricks notify("stop_following");
  level.ai_hendricks colors::disable();
  level.ai_hendricks.ignoreall = 1;
  level.ai_hendricks ai::set_ignoreme(1);
  level.ai_hendricks.goalradius = 1;
  s_hendricks = struct::get("hendricks_works_computer", "script_noteworthy");
  if(b_starting) {
    level thread hendricks_server_control_room_door_open(1);
  }
  level.ai_hendricks skipto::teleport_single_ai(s_hendricks);
  level.ai_hendricks setgoal(level.ai_hendricks.origin);
  level thread scene::init("cin_bio_10_01_serverroom_vign_hack_loop");
}

function objective_server_room_defend_done(str_objective, b_starting, b_direct, player) {
  cp_mi_sing_biodomes_util::objective_message("server_room_defend_done");
  objectives::complete("cp_level_biodomes_defend_server_room", level.ai_hendricks);
  objectives::complete("cp_level_biodomes_mainobj_upload_data");
  e_window = getent("server_window", "targetname");
  if(isDefined(e_window)) {
    e_window delete();
  }
  if(level scene::is_active("cin_bio_09_02_accessdrives_1st_sever_end_loop")) {
    level scene::stop("cin_bio_09_02_accessdrives_1st_sever_end_loop");
  }
  if(isDefined(level.ai_hendricks)) {
    level.ai_hendricks clearforcedgoal();
    level.ai_hendricks.goalradius = 1024;
  }
}

function elevator_spawning(str_location) {
  self endon("death");
  e_my_elevator_l = getent(self.script_noteworthy + "_l", "targetname");
  e_my_elevator_r = getent(self.script_noteworthy + "_r", "targetname");
  self ai::set_ignoreall(1);
  self.goalradius = 1;
  level thread elevator_light(str_location);
  playsoundatposition("evt_elevator_ding", e_my_elevator_l.origin);
  e_my_elevator_l.v_closed = e_my_elevator_l.origin;
  e_my_elevator_r.v_closed = e_my_elevator_r.origin;
  s_elevator_l_open = struct::get(e_my_elevator_l.target, "targetname");
  s_elevator_r_open = struct::get(e_my_elevator_r.target, "targetname");
  e_my_elevator_l.v_open = s_elevator_l_open.origin;
  e_my_elevator_r.v_open = s_elevator_r_open.origin;
  e_my_elevator_l moveto(e_my_elevator_l.v_open, 1);
  e_my_elevator_r moveto(e_my_elevator_r.v_open, 1);
  e_my_elevator_l waittill("movedone");
  level thread elevator_close(self, e_my_elevator_l, e_my_elevator_r);
  nd_target = getnode(self.target, "targetname");
  self setgoal(nd_target);
  elevator_wait(self);
  self ai::set_ignoreall(0);
  if(str_location == "cloudmountain") {
    self ai::set_behavior_attribute("move_mode", "rusher");
  } else {
    self util::waittill_any("goal", "near_goal");
    self.goalradius = 2048;
    self util::waittill_any_timeout(5, "damage", "pain");
    e_volume = getent("server_room_entrance_goal_volume", "targetname");
    self setgoal(e_volume);
  }
}

function elevator_backup() {
  self endon("death");
  e_my_elevator_l = getent(self.script_noteworthy + "_l", "targetname");
  e_my_elevator_r = getent(self.script_noteworthy + "_r", "targetname");
  self ai::set_ignoreall(1);
  self.goalradius = 1;
  e_my_elevator_l waittill("movedone");
  wait(0.1);
  nd_target = getnode(self.target, "targetname");
  self setgoal(nd_target, 0, 200);
  elevator_wait(self);
  self ai::set_ignoreall(0);
  self ai::set_behavior_attribute("move_mode", "rusher");
}

function function_88e395d2() {
  var_5a7d265d = getEntArray("turret_elevator_doors", "script_noteworthy");
  foreach(e_elevator_door in var_5a7d265d) {
    e_elevator_door connectpaths();
  }
  wait(0.5);
}

function elevator_light(str_location) {
  if((level flag::get("elevator_light_on_" + str_location)) == 0) {
    n_duration = 3;
    level flag::set("elevator_light_on_" + str_location);
    if(str_location == "server_room") {
      exploder::exploder_duration("objective_server_room_def_elevator_lights", n_duration);
    } else if(str_location == "cloudmountain") {
      exploder::exploder_duration("fx_cloudmt_elevator_1st_l", n_duration);
    }
    wait(n_duration);
    level flag::clear("elevator_light_on_" + str_location);
  }
}

function swat_team_control() {
  spawner::simple_spawn("server_room_enemy_swat1");
  if(level.players.size > 2) {
    spawner::simple_spawn("server_room_enemy_swat2");
  }
  e_staging_area = getent("staging_area", "targetname");
  b_gotime = 0;
  while(b_gotime == 0) {
    wait(1);
    n_ready_attackers = 0;
    a_swat_team = getaiarray("server_room_enemy_swat1_ai", "targetname");
    n_attackers = a_swat_team.size;
    foreach(ai in a_swat_team) {
      if(ai istouching(e_staging_area)) {
        n_ready_attackers++;
      }
    }
    if(n_attackers < 4 || n_ready_attackers >= (n_attackers * 0.7)) {
      b_gotime = 1;
    }
    if(n_ready_attackers > 0 || b_gotime == 1) {
      level thread toss_smoke_grenade(a_swat_team, "smoke_grenade_final_hallway2_start");
    }
  }
  level notify("swat_go_time");
}

function swat_team_ai() {
  self endon("death");
  self.goalradius = 1;
  nd_staging_area = getnode(self.target, "targetname");
  setenablenode(nd_staging_area);
  self setgoal(nd_staging_area, 0, 1);
  level waittill("swat_go_time");
  a_server_room_nodes = getnodearray("swat_node_" + self.script_noteworthy, "targetname");
  nd_server_room = array::random(a_server_room_nodes);
  self setgoal(nd_server_room, 0, 200);
  setenablenode(nd_staging_area, 0);
  self util::waittill_any("goal", "pain", "near_goal", "damage");
  self setgoal(self.origin, 0, 512);
}

function set_goal_server_room() {
  e_goal = getent("server_room_entrance_goal_volume", "targetname");
  self setgoal(e_goal);
}

function top_floor_door() {
  self endon("death");
  s_door = struct::get("top_floor_door");
  self setgoal(s_door.origin, 0, 100);
  self waittill("goal");
  if(level flag::get("top_floor_breached") == 0) {
    if(!level scene::is_playing("p7_fxanim_gp_door_broken_open_01_bundle")) {
      level thread scene::play("p7_fxanim_gp_door_broken_open_01_bundle");
    }
    e_door = getent("top_floor_door_clip", "targetname");
    if(isDefined(e_door)) {
      playrumbleonposition("cp_biodomes_server_room_top_floor_door_rumble", e_door.origin);
      e_door delete();
    }
    level flag::wait_till("top_floor_breached");
  }
  self setgoal(getent("server_room_entrance_goal_volume", "targetname"));
}

function top_floor_flag() {
  level waittill("top_floor_door_open");
  level flag::set("top_floor_breached");
}

function function_963807b1() {
  level endon("server_room_fail");
  level notify("vtol_spawned");
  level thread scene::play("p7_fxanim_cp_biodomes_server_room_window_break_01_bundle");
  level waittill("hash_53ff6d53");
  e_window = getent("server_window", "targetname");
  foreach(player in level.activeplayers) {
    if(player util::is_looking_at(e_window, 0.3)) {
      player thread dialog::player_say("plyr_shit_they_re_blowin_0", 0.25);
    }
  }
  level waittill("hash_578006af");
  level flag::set("window_broken");
  if(isDefined(e_window)) {
    earthquake(1, 1, e_window.origin, 1000);
    playrumbleonposition("cp_biodomes_server_room_window_rumble", e_window.origin);
    e_window delete();
  }
  level thread cp_mi_sing_biodomes_util::enable_traversals(1, "server_room_window_mantle", "script_noteworthy");
  level waittill("hash_99d5298d");
  wait(1);
  level thread zipline_spawning();
  level thread dialog::remote("kane_hostiles_ziplining_i_0");
}

function zipline_spawning() {
  level endon("server_room_fail");
  level.var_1a0f3432 = 0;
  spawner::simple_spawn("server_room_enemy_rope2_guy1", & rope_guy_init);
  wait(randomfloat(0.5));
  spawner::simple_spawn("server_room_enemy_rope1_guy1", & rope_guy_init);
  wait(randomfloatrange(1, 4));
  spawner::simple_spawn("server_room_enemy_rope2_guy2", & rope_guy_init);
  wait(randomfloat(0.5));
  spawner::simple_spawn("server_room_enemy_rope1_guy2", & rope_guy_init);
  wait(randomfloatrange(1, 4));
  spawner::simple_spawn("server_room_enemy_rope2_guy3", & rope_guy_init);
  wait(randomfloat(0.5));
  spawner::simple_spawn("server_room_enemy_rope1_guy3", & rope_guy_init);
  if(level.players.size > 2) {
    wait(randomfloatrange(1, 3));
    spawner::simple_spawn("server_room_enemy_rope2_guy1", & rope_guy_init);
    wait(randomfloat(0.5));
    spawner::simple_spawn("server_room_enemy_rope1_guy1", & rope_guy_init);
    wait(randomfloatrange(1, 3));
    spawner::simple_spawn("server_room_enemy_rope2_guy2", & rope_guy_init);
    wait(randomfloat(0.5));
    spawner::simple_spawn("server_room_enemy_rope1_guy2", & rope_guy_init);
  }
  spawner::add_spawn_function_ai_group("top_floor", & set_goal_server_room);
  spawn_manager::enable("server_room_topfloor_fodder_manager");
  level notify("zipline_spawning_done");
  wait(10);
  level notify("zipline_attack_done");
}

function rope_guy_init() {
  self endon("death");
  s_vtol = struct::get("vtol_dropoff_" + self.script_noteworthy);
  s_landing = struct::get("vtol_landing_" + self.script_noteworthy);
  self forceteleport(s_vtol.origin, s_vtol.angles);
  var_c312dab9 = util::spawn_model("tag_origin", s_vtol.origin, s_vtol.angles);
  var_c312dab9 thread scene::play("cin_gen_traversal_zipline_enemy02_idle", self);
  var_b39127dd = util::spawn_model("wpn_t7_zipline_trolley_prop", self gettagorigin("tag_weapon_left"), self gettagangles("tag_weapon_left"));
  var_b39127dd linkto(self, "tag_weapon_left");
  self thread function_e87de176(array(var_c312dab9, var_b39127dd));
  n_dist = distance(s_vtol.origin, s_landing.origin);
  n_time = n_dist / 500;
  var_c312dab9 moveto(s_landing.origin, n_time);
  var_c312dab9 playLoopSound("evt_vtol_npc_move");
  self thread rope_guy_stop_snd(var_c312dab9);
  var_c312dab9 waittill("movedone");
  var_c312dab9 stoploopsound(0.5);
  var_c312dab9 playSound("evt_vtol_npc_detach");
  v_on_navmesh = getclosestpointonnavmesh(var_c312dab9.origin, 100, 48);
  if(isDefined(v_on_navmesh)) {
    var_c312dab9 moveto(v_on_navmesh, 0.25);
  }
  var_c312dab9 scene::play("cin_gen_traversal_zipline_enemy02_dismount", self);
  self notify("dismount_zipline");
  self unlink();
  util::wait_network_frame();
  var_c312dab9 delete();
  var_b39127dd delete();
  self setgoal(getent("server_room_entrance_goal_volume", "targetname"));
  level waittill("server_defend_done");
}

function rope_guy_stop_snd(var_c312dab9) {
  var_c312dab9 endon("movedone");
  self waittill("death");
  var_c312dab9 stoploopsound(0.5);
}

function function_e87de176(a_e_cleanup) {
  self endon("dismount_zipline");
  self waittill("death");
  namespace_769dc23f::function_72f8596b();
  self unlink();
  self startragdoll(1);
  foreach(entity in a_e_cleanup) {
    entity delete();
  }
}

function rambo_robots() {
  self ai::set_behavior_attribute("move_mode", "rambo");
}

function rusher_robots() {
  self ai::set_behavior_attribute("move_mode", "rusher");
}

function function_4df7264d() {
  self ai::set_behavior_attribute("sprint", 1);
  util::waittill_either("goal", "damage");
  self ai::set_behavior_attribute("sprint", 0);
}

function elevator_close(ai_spawn, e_my_elevator_l, e_my_elevator_r) {
  level flag::wait_till(ai_spawn.script_noteworthy + "_cleared");
  e_my_elevator_l moveto(e_my_elevator_l.v_closed, 1);
  e_my_elevator_r moveto(e_my_elevator_r.v_closed, 1);
  e_my_elevator_l waittill("movedone");
  e_my_elevator_l disconnectpaths();
  e_my_elevator_r disconnectpaths();
}

function elevator_wait(ai_spawn) {
  ai_spawn endon("death");
  t_elevator = getent(ai_spawn.script_noteworthy + "_elevator_trigger", "targetname");
  while(ai_spawn istouching(t_elevator) || util::any_player_is_touching(t_elevator, "allies")) {
    wait(0.5);
  }
}

function function_6f311542() {
  var_b05a0766 = getent("lobby_elevator_door_01_l", "targetname");
  var_c3cad8fd = getent("lobby_elevator_door_01_r", "targetname");
  var_b05a0766 disconnectpaths();
  var_c3cad8fd disconnectpaths();
}

function wave_wait(n_new_wave_threshold, n_timer, str_ai_group1, str_ai_group2, str_ai_group3, var_f0bb9dad) {
  wait(1);
  if(isDefined(var_f0bb9dad)) {
    while(n_timer > 0 && (spawner::get_ai_group_sentient_count(str_ai_group1) + spawner::get_ai_group_sentient_count(str_ai_group2)) + spawner::get_ai_group_sentient_count(str_ai_group3) + spawner::get_ai_group_sentient_count(var_f0bb9dad) > n_new_wave_threshold) {
      wait(1);
      n_timer = n_timer - 1;
    }
  } else {
    if(isDefined(str_ai_group3)) {
      while(n_timer > 0 && (spawner::get_ai_group_sentient_count(str_ai_group1) + spawner::get_ai_group_sentient_count(str_ai_group2)) + spawner::get_ai_group_sentient_count(str_ai_group3) > n_new_wave_threshold) {
        wait(1);
        n_timer = n_timer - 1;
      }
    } else {
      if(isDefined(str_ai_group2)) {
        while(n_timer > 0 && (spawner::get_ai_group_sentient_count(str_ai_group1) + spawner::get_ai_group_sentient_count(str_ai_group2)) > n_new_wave_threshold) {
          wait(1);
          n_timer = n_timer - 1;
        }
      } else {
        while(n_timer > 0 && spawner::get_ai_group_sentient_count(str_ai_group1) > n_new_wave_threshold) {
          wait(1);
          n_timer = n_timer - 1;
        }
      }
    }
  }
  wait(3);
}

function function_947a1ae8() {
  self endon("death");
  e_volume = getent(self.target, "targetname");
  self setgoal(e_volume, 1);
}