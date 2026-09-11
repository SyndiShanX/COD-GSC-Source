/******************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_obj_airfield.gsc
******************************************************************/

function main() {
  level.airfield_obj_func = &register_objectives;
  thread little_bird_mg_handleflarefire();
}

function obj_default_init(var0, var1) {
  scripts\cp\utility::skydivestreamhintdvars("airfield");
  level.initlocationcircle = "ba_mnu";
  level.initlethalmaxoffsetmap = "ba_mnu";
}

function obj_default_end(var0) {}

function obj_default_beat(var0) {}

function obj_default_start(var0) {
  var1 = "default_player_start_airfield";

  if(getdvarint("airfield_alt_spawn") > 0) {
    var1 = "airfield_front_spawn";
  }

  scripts\engine\utility::delaythread(3, &scripts\cp\utility::teleportallplayersinteamtostructs, "allies", var1, 1);
}

function precache_fx() {
  level._effect["milbase_exp_sm"] = loadfx("vfx/iw8_cp/vfx_base_cargo_exp_1.vfx");
  level._effect["milbase_exp_lg"] = loadfx("vfx/iw8_cp/vfx_base_cargo_exp_2.vfx");
  level._effect["cargo_exp_building"] = loadfx("vfx/iw8_cp/vfx_base_cargo_exp_building.vfx");
  level._effect["cargo_exp_door"] = loadfx("vfx/iw8_cp/vfx_base_cargo_exp_door.vfx");
  level._effect["base_wind_exp"] = loadfx("vfx/iw8_cp/vfx_base_wind_exp.vfx");
  level._effect["helidown_tailfire"] = loadfx("vfx/iw8_cp/chopper/vfx_cp_fire_fire_trail.vfx");
  level.ref_14049 = 1;
}

function register_objectives() {
  ref_12b06();
  scripts\cp\cp_objectives::registerobjective("ba_mnu", &obj_default_init, &ba_mnu_start, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_shiprecieve", &obj_default_init, &ba_shiprecieve_start, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_router", &obj_default_init, &ba_router_start, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_searchareas", &obj_default_init, &ba_searchareas_start, &obj_default_end, &obj_default_beat, &ba_searcarea_debug_start);
  scripts\cp\cp_objectives::registerobjective("ba_tower", &obj_default_init, &ba_tower_start, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_steal_tank", &obj_default_init, &ba_steal_tank_start, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_destroy_tanks", &obj_default_init, &ba_destroy_tanks_start, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_loca", &obj_default_init, &obj_default_init, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_locb", &obj_default_init, &obj_default_init, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_locc", &obj_default_init, &obj_default_init, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_obj_a_plant", &obj_default_init, &obj_default_init, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_obj_b_plant", &obj_default_init, &obj_default_init, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_obj_c_plant", &obj_default_init, &obj_default_init, &obj_default_end, &obj_default_beat, &obj_default_start);
  scripts\cp\cp_objectives::registerobjective("ba_escape", &obj_default_init, &ba_escape_start, &obj_default_end, &obj_default_beat, &ba_escape_debug_start);
  scripts\cp\cp_objectives::registerobjective("ba_escape_tank", &obj_default_init, &ba_escape_start_tank, &obj_default_end, &obj_default_beat, &obj_default_start);
}

function ba_escape_debug_start(var0) {
  scripts\engine\utility::flag_set("cp_airfield_create_script");
  scripts\engine\utility::flag_wait("cp_airfield_create_script_completed");
  wait 0.5;
  level.use_alt_b = randomint(100) > 49;
  scripts\engine\utility::flag_init("hangar_done");
  scripts\engine\utility::flag_init("maint_done");
  scripts\engine\utility::flag_init("warehouse_done");
  scripts\engine\utility::flag_init("shipping_done");
  scripts\engine\utility::flag_init("hangar_door_opened");
  scripts\engine\utility::flag_init("milbase_escape");
  scripts\engine\utility::flag_init("tanks_stolen");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("interactions_initialized");
  level.pkg_ids = [0, 1, 2, 3, 4, 5, 6, 7];
  level.pkg_lbl = [];
  level.pkg_lbl[0] = "sign_metal_ship_label_00";
  level.pkg_lbl[1] = "sign_metal_ship_label_01";
  level.pkg_lbl[2] = "sign_metal_ship_label_02";
  level.pkg_lbl[3] = "sign_metal_ship_label_03";
  level.pkg_lbl[4] = "sign_metal_ship_label_04";
  level.pkg_lbl[5] = "sign_metal_ship_label_05";
  level.pkg_lbl[6] = "sign_metal_ship_label_06";
  level.pkg_lbl[7] = "sign_metal_ship_label_07";
  level.ref_12386 = [];
  level.ref_12386[0] = "dx_cps_lass_base_assault_place_beacon_0197a";
  level.ref_12386[1] = "dx_cps_lass_base_assault_place_beacon_1275b";
  level.ref_12386[2] = "dx_cps_lass_base_assault_place_beacon_2325c";
  level.ref_12386[3] = "dx_cps_lass_base_assault_place_beacon_3446d";
  level.ref_12386[4] = "dx_cps_lass_base_assault_place_beacon_4505e";
  level.ref_12386[5] = "dx_cps_lass_base_assault_place_beacon_5623f";
  level.ref_12386[6] = "dx_cps_lass_base_assault_place_beacon_6771g";
  level.ref_12386[7] = "dx_cps_lass_base_assault_place_beacon_7808h";
  setup_search_areas();
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "tank_test_player_start");
  level scripts\engine\utility::delaythread(10, &spawn_enemy_tanks);
}

function ba_searcarea_debug_start(var0) {
  scripts\engine\utility::flag_set("cp_airfield_create_script");
  scripts\engine\utility::flag_wait("cp_airfield_create_script_completed");
  level.use_alt_b = randomint(100) > 49;
  scripts\engine\utility::flag_init("hangar_done");
  scripts\engine\utility::flag_init("maint_done");
  scripts\engine\utility::flag_init("warehouse_done");
  scripts\engine\utility::flag_init("shipping_done");
  scripts\engine\utility::flag_init("hangar_door_opened");
  scripts\engine\utility::flag_init("milbase_escape");
  scripts\engine\utility::flag_init("tanks_stolen");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("interactions_initialized");
  level.pkg_ids = [0, 1, 2, 3, 4, 5, 6, 7];
  level.pkg_lbl = [];
  level.pkg_lbl[0] = "sign_metal_ship_label_00";
  level.pkg_lbl[1] = "sign_metal_ship_label_01";
  level.pkg_lbl[2] = "sign_metal_ship_label_02";
  level.pkg_lbl[3] = "sign_metal_ship_label_03";
  level.pkg_lbl[4] = "sign_metal_ship_label_04";
  level.pkg_lbl[5] = "sign_metal_ship_label_05";
  level.pkg_lbl[6] = "sign_metal_ship_label_06";
  level.pkg_lbl[7] = "sign_metal_ship_label_07";
  level.obja = scripts\cp\cp_objectives::requestworldid("locationA");
  level.objb = scripts\cp\cp_objectives::requestworldid("locationB");
  level.objc = scripts\cp\cp_objectives::requestworldid("locationC");
  level.objplanta = scripts\cp\cp_objectives::requestworldid("locationA");
  level.objplantb = scripts\cp\cp_objectives::requestworldid("locationB");
  level.objplantc = scripts\cp\cp_objectives::requestworldid("locationC");
  level scripts\cp\cp_hacking::hacking_init();
  setup_search_areas();
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "tank_test_player_start");
  wait 5;
}

function ba_escape_start(var0) {
  scripts\engine\utility::flag_init("endgame_delay");
  thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil();
  thread scripts\cp\cp_objectives::run_objective("ba_tower");
  scripts\engine\utility::flag_wait("hangar_door_opened");
  thread old_health();
  thread scripts\cp\cp_objectives::run_objective("ba_steal_tank");
  scripts\engine\utility::flag_wait("tanks_stolen");
  wait 1;
  thread scripts\cp\cp_objectives::run_objective("ba_escape_tank");
  scripts\engine\utility::flag_wait("milbase_escape");
  level notify("call_exfil", (15809.5, 48806.5, 1172.78), 1);
  thread monitor_flag_carrier();
  scripts\cp\utility::ref_123fe("");
  level waittill("ready_to_exfil");
  level.exfil_heli.onexitfunc = 40;
  scripts\cp\utility::ref_123fe("mus_cp_landlord_mission_end");

  foreach(var2 in level.players) {
    var2 setsoundsubmix("cp_matchend_music", 5);
  }

  scripts\cp\cp_objectives::screenent_c("major_objective");
  thread vo_mission_end();
  ba_end_sequence(level.heli_trip_vehicle);
}

function ba_end_sequence(var0) {
  var1 = var0.origin + anglestoleft(var0.angles) * 30 + (0, 0, -85) + anglesToForward(var0.angles) * -20;
  var2 = spawn("script_model", var1);
  var2 setModel("tag_origin");
  var2.angles = (0, 200, 0);
  var2 linkTo(var0);

  foreach(var4 in level.players) {
    var4 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340d(2, 1, 1);
  }

  wait 2;

  foreach(var4 in level.players) {
    var4 allowfire(0);
    var4 disableoffhandweapons();
    var4 disableusability();
    var4 allowmovement(0);
    var4 setclientomnvar("ui_hide_hud", 1);
    spawn_endgame_camera(var4, var2);
    var4 thread scripts\cp_mp\xmike109::screenent_d("kuvalda");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var4 thread scripts\cp_mp\xmike109::scriptable_callback("kuvalda_mod");
      } else {
        var4 thread scripts\cp_mp\xmike109::scriptable_callback("kuvalda_mod_vet");
      }
    }

    var4 lerpfovscalefactor(0, 0);
  }

  scripts\cp\cp_achievement::update_achievement_all_players("LANDLORD", 1);
  scripts\cp\cp_achievement::update_achievement_all_players("PICKLES", 1);
  thread do_killstreaks();
  wait 2;
  thread detonate_explosives();
  wait 8;

  foreach(var9 in level.spawned_ai) {
    if(isDefined(var9)) {
      var9 dodamage(var9.health + 100, var9.origin);
    }
  }

  scripts\engine\utility::flag_set("endgame_delay");
}

function spawn_endgame_camera(var0) {
  self.ignoreme = 1;
  self cameralinkTo(var0, "tag_origin", 1);
  self setclientdvar("LQKPQMPRQN", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("QTSPTNLOL", "50");
    return;
  }
}

function do_killstreaks() {
  level endon("game_ended");
  var0 = level.airfield_plant_spots;

  for(;;) {
    var1 = scripts\engine\utility::random(var0).origin;
    var2 = level.players[0] scripts\cp_mp\utility\killstreak_utility::createstreakinfo("toma_strike", level.players[0]);
    level.players[0] scripts\cp_mp\killstreaks\toma_strike::tomastrike_attacktarget(3, undefined, var1, var2);
    wait 5;
  }

  wait 5;
}

function get_direction_override() {
  var0 = (5017.1, 46621.4, 1184.12) - self.origin;
  return var0;
}

function ba_escape_start_tank(var0) {
  scripts\cp\utility::ref_123fe("mus_cp_landlord_helo_exfil");
  var1 = var0.objectiveindex;
  objective_icon(var1, "icon_waypoint_objective_general");
  var2 = scripts\engine\utility::getStruct("obj_escape", "targetname");
  objective_position(var1, getgroundposition(scripts\engine\utility::getStruct("exfil_location", "targetname").origin, 8) + (0, 0, 60));
  objective_setplayintro(var1, 1);
  scripts\cp\cp_objectives::ref_11f80(var1);
  objective_setlabel(var1, &"CP_MILBASE_DIALOGUE/ESCAPE_BASE");
  ref_1436d(scripts\engine\utility::getStruct("obj_escape", "targetname").origin, 1500);
  scripts\engine\utility::flag_set("milbase_escape");
}

function ref_1436d(var0, var1) {
  for(;;) {
    var2 = 0;

    foreach(var4 in level.players) {
      if(distance(var4.origin, var0) < var1) {
        var2 = 1;
      }
    }

    if(var2) {
      break;
    }

    wait 0.25;
  }
}

function brdoesloadoutoptionusedropbags(var0, var1) {
  var2 = 0;
  var3 = 0;
  var4 = [];
  var5 = [];

  foreach(var7 in level.players) {
    if(var7.team == "axis") {
      var4 = var7;
      continue;
    }

    var5 = var7;
  }

  foreach(var7 in var5) {
    if(scripts\cp\cp_laststand::player_in_laststand(var7)) {
      var3++;
    }

    if(distance(var7.origin, var0) < var1) {
      var2++;
    }
  }

  return var2 > 0 && var5.size == var2 + var3;
}

function ba_mnu_start(var0) {
  scripts\cp\maps\cp_donetsk\cp_donetsk_safehouse_landlord::ref_13776();
}

function ba_shiprecieve_start(var0) {
  scripts\engine\utility::flag_set("cp_airfield_create_script");
  scripts\engine\utility::flag_wait("cp_airfield_create_script_completed");
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_overwatch_heli");
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_overwatch_tanks");
  scripts\cp\coop_stealth::coop_stealth_init();
  level.ref_139b5 = 1;
  level.use_alt_b = randomint(100) > 49;
  level.pkg_lbl = [];
  level.pkg_lbl[0] = "sign_metal_ship_label_00";
  level.pkg_lbl[1] = "sign_metal_ship_label_01";
  level.pkg_lbl[2] = "sign_metal_ship_label_02";
  level.pkg_lbl[3] = "sign_metal_ship_label_03";
  level.pkg_lbl[4] = "sign_metal_ship_label_04";
  level.pkg_lbl[5] = "sign_metal_ship_label_05";
  level.pkg_lbl[6] = "sign_metal_ship_label_06";
  level.pkg_lbl[7] = "sign_metal_ship_label_07";
  level.ref_12386 = [];
  level.ref_12386[0] = "dx_cps_lass_base_assault_place_beacon_0197a";
  level.ref_12386[1] = "dx_cps_lass_base_assault_place_beacon_1275b";
  level.ref_12386[2] = "dx_cps_lass_base_assault_place_beacon_2325c";
  level.ref_12386[3] = "dx_cps_lass_base_assault_place_beacon_3446d";
  level.ref_12386[4] = "dx_cps_lass_base_assault_place_beacon_4505e";
  level.ref_12386[5] = "dx_cps_lass_base_assault_place_beacon_5623f";
  level.ref_12386[6] = "dx_cps_lass_base_assault_place_beacon_6771g";
  level.ref_12386[7] = "dx_cps_lass_base_assault_place_beacon_7808h";
  thread spawn_intro_choppers();
  thread init_alarm_system();
  init_ba_objective();
  scripts\cp\cp_computerscreen::init_computer_anims();
  var1 = setup_router_objective(var0);
  var2 = var0.objectiveindex;
  level.ba_router = var1;
  thread sniper_interaction();
  thread ref_142f2();

  while(!scripts\cp\utility::any_player_nearby(var1.origin, squared(250))) {
    wait 0.1;
  }

  var3 = scripts\engine\utility::getclosest(var1.origin, level.players);
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var3, "obj_visual");

  for(;;) {
    var1 waittill("trigger", var3);
    var3 playlocalsound("cp_generic_placement");
    wait 0.5;
    scripts\cp\cp_player_battlechatter::trysaylocalsound(var3, "obj_device_setting");
    break;
  }

  level.ref_12dbe = var1;
  level notify("router_placed");
  level.ref_12dbd = 1;
  level notify("weapons_free");
}

function ba_router_start(var0) {
  scripts\cp\cp_modular_spawning::run_spawn_module("hill_top_1");
  var1 = var0.objectiveindex;
  objective_setlabel(var1, &"CP_MILBASE_DIALOGUE/XFER_DATA");
  objective_position(var1, level.ref_12dbe.origin + (0, 0, 10));
  scripts\cp\cp_objectives::ref_11f80(var1);
  level.ba_router makeunusable();
  level.ba_router setModel("equipment_router_flat_invisi");
  level.ba_router setscriptablepartstate("transfer", "start");
  level.hack_duration = 30;

  if(getdvarint("scr_quickhack") != 0) {
    level.hack_duration = getdvarint("scr_quickhack");
  }

  wait 1;
  level scripts\cp\cp_hacking::hacking_init();
  level thread scripts\cp\cp_hacking::hacking_objective_time();
  wait 1;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_snr_hacking_10", "allies");
  var2 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var2, "obj_sitrep_clock_start");
  thread friendly_hvi_vehicle_extra_riders_getin_scene(level);
  level waittill("cpu_hacking_done");
  scripts\cp\cp_objectives::screenent_c("minor_objective");
  level.ba_router setscriptablepartstate("transfer", "finish");
  wait 1;
  scripts\engine\utility::flag_set("shipping_done");
  thread ref_142e0();
}

function init_ba_objective() {
  level.flare_lifetime = 10;
  scripts\engine\utility::flag_init("hangar_done");
  scripts\engine\utility::flag_init("maint_done");
  scripts\engine\utility::flag_init("warehouse_done");
  scripts\engine\utility::flag_init("shipping_done");
  scripts\engine\utility::flag_init("hangar_door_opened");
  scripts\engine\utility::flag_init("milbase_escape");
  scripts\engine\utility::flag_init("tanks_stolen");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("interactions_initialized");
  thread wait_for_combat_start();
  level.obja = scripts\cp\cp_objectives::requestworldid("locationA");
  level.objb = scripts\cp\cp_objectives::requestworldid("locationB");
  level.objc = scripts\cp\cp_objectives::requestworldid("locationC");
  level.objplanta = scripts\cp\cp_objectives::requestworldid("locationA");
  level.objplantb = scripts\cp\cp_objectives::requestworldid("locationB");
  level.objplantc = scripts\cp\cp_objectives::requestworldid("locationC");
  level.pkg_ids = [0, 1, 2, 3, 4, 5, 6, 7];
  setup_search_areas();
}

function setup_router_objective(var0) {
  scripts\engine\utility::flag_wait("airfield_safehouse_open");
  wait 1;
  thread ref_142df();
  var1 = getEnt("router_placement", "targetname");
  var1 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "cp_tac_waypoint_router", &"CP_MILBASE_DIALOGUE/PLACE_ROUTER", 25, "duration_medium", "hide", 256, 45, 72, 45);
  var1 setModel("tag_origin");
  var2 = var0.objectiveindex;
  objective_icon(var2, "icon_waypoint_objective_general");
  objective_position(var2, var1.origin + (0, 0, 20));
  objective_setplayintro(var2, 1);
  scripts\cp\cp_objectives::ref_11f80(var2);
  objective_setlabel(var2, &"CP_LANDLORD/OBJ_ACCESS_SERVER_LBL");
  objective_setdescription(var2, &"CP_LANDLORD/OBJ_ACCESS_SERVER");
  wait 2;
  return var1;
}

function wait_for_combat_start() {
  scripts\engine\utility::flag_init("stealth_over");
  wait 3;
  scripts\cp\cp_modular_spawning::registerambientgroup("base_jugg_reinforce", 1, 1, 1, 0, 0, "jugg_reinforce", &end_spawn_group, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("base_jugg_reinforce", &vehicle_damage_onenterstatemedium);
  scripts\cp\cp_modular_spawning::registerambientgroup("tank_hangar_enemies", 8, 8, 8, 0.1, 0, "tank_hangar_enemies");
  scripts\cp\cp_modular_spawning::registerambientgroup("parachute_group_1", 4, 4, 4, 0.5, 0, "parachute_group_1", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("parachute_group_2", 4, 4, 4, 0.5, 0, "parachute_group_2", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("parachute_group_3", 4, 4, 4, 0.5, 0, "parachute_group_3", undefined, undefined, 5);
  thread targets_killed();
  scripts\engine\utility::flag_wait("stealth_over");
  level notify("stealth_over");
  level.ref_139b5 = 0;
  wait 2;
  thread mortar_launch_think();
  thread paratrooper_logic(level);
  call_in_reinforcements();
  wait 3;
  level thread scripts\cp\cp_wave_spawning::killstreaks(1, "airfield_default_1");
  wait 60;
  thread spawn_enemy_chopper();
}

function reinforcement_loop() {
  level endon("stop_reinforcements");

  for(;;) {
    while(level.spawned_ai.size >= 8) {
      wait 1;
    }

    call_in_reinforcements();
    wait randomintrange(30, 45);
  }
}

function paratrooper_logic(var0) {
  level endon("stop_paratroopers");
  wait 90;

  for(;;) {
    while(level.spawned_ai.size >= 8) {
      wait 1;
    }

    var1 = scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(var0), undefined, (-13512, 66432, 5904));

    if(isDefined(var1) && var1.size > 0) {
      thread ref_142ec();
    }

    wait 30;
  }
}

function ba_searchareas_start(var0) {
  foreach(var2 in level.all_search_areas) {
    if(var2.script_noteworthy == "obj_b_alt" && !level.use_alt_b) {
      continue;
    }

    if(var2.script_noteworthy == "obj_b" && level.use_alt_b) {
      continue;
    }

    var2.useobj makeusable();
  }

  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_MILBASE_DIALOGUE/JACKPOT_2");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_ovl_base_assault_snr_hacking_complete2_10");
  wait 1;
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_MILBASE_DIALOGUE/JACKPOT_4");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_ovl_base_assault_snr_hacking_complete3_10");
  objective_state(level.obja, "current");
  objective_state(level.objb, "current");
  objective_state(level.objc, "current");
  objective_setshowoncompass(level.obja, 1);
  objective_setshowoncompass(level.objb, 1);
  objective_setshowoncompass(level.objc, 1);
  objective_setplayintro(level.obja, 1);
  objective_setplayintro(level.objb, 1);
  objective_setplayintro(level.objc, 1);
  objective_setlabel(level.obja, &"CP_MILBASE_DIALOGUE/LOC_B");
  objective_setlabel(level.objb, &"CP_MILBASE_DIALOGUE/LOC_A");
  objective_setlabel(level.objc, &"CP_MILBASE_DIALOGUE/LOC_C");
  objective_icon(level.obja, "icon_waypoint_objective_general");
  objective_icon(level.objb, "icon_waypoint_objective_general");
  objective_icon(level.objc, "icon_waypoint_objective_general");

  if(!level.use_alt_b) {
    objective_position(level.objb, scripts\engine\utility::getStruct("obj_b", "script_noteworthy").origin);
  } else {
    objective_position(level.objb, scripts\engine\utility::getStruct("obj_b_alt", "script_noteworthy").origin);
  }

  objective_position(level.obja, scripts\engine\utility::getStruct("obj_a", "script_noteworthy").origin);
  objective_position(level.objc, scripts\engine\utility::getStruct("obj_c", "script_noteworthy").origin);

  if(!level.use_alt_b) {
    scripts\cp\utility::objective_update("ba_locb");
  } else {
    scripts\cp\utility::objective_update("ba_locb");
  }

  scripts\cp\utility::objective_update("ba_loca");
  scripts\cp\utility::objective_update("ba_locc");

  if(!level.use_alt_b) {
    objective_setdescription(level.objb, &"CP_STRIKE/OBJ_SCAN_LOC_A");
  } else {
    objective_setdescription(level.objb, &"CP_STRIKE/OBJ_SCAN_LOC_A");
  }

  objective_setdescription(level.obja, &"CP_STRIKE/OBJ_SCAN_LOC_B");
  objective_setdescription(level.objc, &"CP_STRIKE/OBJ_SCAN_LOC_C");
  objective_setdescription(var0.objectiveindex, &"CP_MILBASE_DIALOGUE/HINT_SEARCH_LOCATIONS");
  scripts\cp\cp_objectives::ref_11f80(level.obja);
  scripts\cp\cp_objectives::ref_11f80(level.objb);
  scripts\cp\cp_objectives::ref_11f80(level.objc);
  wait 3;
  scripts\engine\utility::flag_wait_all("maint_done", "hangar_done", "warehouse_done");
  level scripts\engine\utility::delaythread(45, &spawn_enemy_tanks);
  ref_142d7(level);
}

function setup_search_areas() {
  level.all_search_areas = scripts\engine\utility::getStructArray("milbase_search_area", "targetname");

  foreach(var1 in level.all_search_areas) {
    if(var1.script_noteworthy == "obj_b_alt" && !level.use_alt_b) {
      continue;
    }

    if(var1.script_noteworthy == "obj_b" && level.use_alt_b) {
      continue;
    }

    setup_search_area(var1);
  }
}

function setup_search_area(var0, var1) {
  var0.useobj = spawn("script_model", scripts\engine\utility::getclosest(var0.origin, scripts\engine\utility::getStructArray("interaction_computer", "targetname")).origin);
  wait 1;
  var0.useobj scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "icon_waypoint_cyber_bombsite", &"CP_STRIKE/SCAN_AREA", 25, "duration_none", "hide", 256, 120, 72, 50);
  var0.useobj makeunusable();
  var2 = [0, 1, 2, 3, 4, 5, 6, 7];

  switch (var0.script_noteworthy) {
    case "obj_a":
      var0.useobj.objindex = level.obja;
      var0.useobj.objplant = level.objplanta;
      var0.plantobjstr = &"CP_STRIKE/OBJ_PLANT_LOC_B";
      var0.hint_obj_id = &"CP_STRIKE/OBJ_PLANT_LOC_B_COMPLETE";
      var0.flagname = "warehouse_done";
      var0.tutorial = &"CP_STRIKE/AIRFIELD_B_TUT";
      var0.pkg_id = scripts\engine\utility::random(level.pkg_ids);
      var0.omnvar = "cpu_manifest1_idx";
      var0.get_dropkit_price = "milbase_4";
      var0.popup_omnvar = 1;
      break;
    case "obj_b_alt":
      var0.useobj.objindex = level.objb;
      var0.useobj.objplant = level.objplantb;
      var0.plantobjstr = &"CP_STRIKE/OBJ_PLANT_LOC_A";
      var0.hint_obj_id = &"CP_STRIKE/OBJ_PLANT_LOC_A_COMPLETE";
      var0.flagname = "hangar_done";
      var0.tutorial = &"CP_STRIKE/AIRFIELD_A_TUT";
      var0.pkg_id = scripts\engine\utility::random(level.pkg_ids);
      var0.omnvar = "cpu_manifest2_idx";
      var0.popup_omnvar = 2;
      var0.get_dropkit_price = "milbase_5";
      break;
    case "obj_b":
      var0.useobj.objindex = level.objb;
      var0.useobj.objplant = level.objplantb;
      var0.plantobjstr = &"CP_STRIKE/OBJ_PLANT_LOC_A";
      var0.hint_obj_id = &"CP_STRIKE/OBJ_PLANT_LOC_A_COMPLETE";
      var0.flagname = "hangar_done";
      var0.pkg_id = scripts\engine\utility::random(level.pkg_ids);
      var0.omnvar = "cpu_manifest2_idx";
      var0.popup_omnvar = 2;
      var0.tutorial = &"CP_STRIKE/AIRFIELD_A_TUT";
      var0.get_dropkit_price = "milbase_3";
      break;
    case "obj_c":
      var0.useobj.objindex = level.objc;
      var0.useobj.objplant = level.objplantc;
      var0.plantobjstr = &"CP_STRIKE/OBJ_PLANT_LOC_C";
      var0.hint_obj_id = &"CP_STRIKE/OBJ_PLANT_LOC_C_COMPLETE";
      var0.flagname = "maint_done";
      var0.pkg_id = scripts\engine\utility::random(level.pkg_ids);
      var0.omnvar = "cpu_manifest3_idx";
      var0.popup_omnvar = 3;
      var0.get_dropkit_price = "milbase_2";
      var0.tutorial = &"CP_STRIKE/AIRFIELD_C_TUT";
      break;
  }

  var0.ref_11e20 = scripts\engine\utility::getStruct(var0.script_noteworthy + "_nag_area", "targetname");
  var2 = scripts\engine\utility::array_remove(var2, var0.pkg_id);
  var0.useobj thread scripts\cp\cp_computerscreen::computer_think(var0.popup_omnvar, var0.omnvar, var0.pkg_id);
  var3 = "cpu" + var0.popup_omnvar + "_search_result";
  var0.useobj thread scripts\cp\cp_computerscreen::computer_event_listener(var3);
  var0.useobj thread scripts\cp\cp_computerscreen::computer_watch_for_search(var3);
  thread wait_for_manifest_searched(var0.useobj);
  thread usability_think(var0.useobj);
  thread ref_131e7(var0, var0, var1);
  level.pkg_ids = scripts\engine\utility::array_remove(level.pkg_ids, var0.pkg_id);
}

function wait_for_manifest_searched(var0) {
  for(;;) {
    self waittill("computer_event", var1, var2);

    if(int(var1) != 2) {
      var2 playlocalsound("cp_computer_fail");
      continue;
    }

    if(!isDefined(level.ref_11ab7)) {
      scripts\cp\utility::ref_123fe("mus_cp_landlord_manifest");
      level.ref_11ab7 = 1;
    }

    var0 notify("scanned", var2);
    return;
  }
}

function usability_think(var0) {
  for(;;) {
    self waittill("computer_searching", var1, var2);

    if(getdvarint("scr_area_vehicles_active", 1)) {
      thread called75percentprogress(level);
    }

    return;
  }
}

function ref_131e7(var0, var1, var2) {
  var3 = scripts\engine\utility::getStructArray(var0.target, "targetname");

  if(!isDefined(level.airfield_plant_spots)) {
    level.airfield_plant_spots = [];
  }

  var3 = scripts\engine\utility::array_randomize(var3);
  var4 = 0;

  for(var5 = 0;; var5++) {
    jumpiffalse(var5 < var3.size) LOC_00000153;
    var6 = scripts\engine\utility::getStruct(var3[var5].target, "targetname");

    if(!isDefined(var6.angles)) {
      var6.angles = (0, 0, 0);
    }

    if(var5 <= 2) {
      var3[var5].pkg_id_lbl = spawn("script_model", var6.origin);
      var3[var5].pkg_id_lbl.angles = var6.angles;
      var3[var5].pkg_id_lbl setModel(level.pkg_lbl[var0.pkg_id]);
      var3[var5].plant_spot = 1;
      var4++;
      level.airfield_plant_spots[level.airfield_plant_spots.size] = var3[var5];
      waitframe();
      continue;
    }

    var7 = scripts\engine\utility::random(var2);
    var6 = scripts\engine\utility::getStruct(var3[var5].target, "targetname");
    var3[var5].pkg_id_lbl = spawn("script_model", var6.origin);
    var3[var5].pkg_id_lbl.angles = var6.angles;
    var3[var5].pkg_id_lbl setModel(level.pkg_lbl[var7]);
    waitframe();
  }

  var0 waittill("scanned", var8);
  var0.useobj playSound("cp_computer_success");
  scripts\cp\utility::objective_update("ba_" + var0.script_noteworthy + "_plant", undefined, undefined, undefined, undefined, 3 - var4);
  wait 1;
  objective_setlabel(var0.useobj.objindex, var0.tutorial);
  objective_setplayintro(var0.useobj.objindex, 1);
  var0.charges_planted = 0;
  var0.num_charges_to_plant = var4;

  foreach(var10 in var3) {
    if(!isDefined(var10.plant_spot)) {
      continue;
    }

    var10.planted_explosive = spawn("script_model", var10.origin);

    if(!isDefined(var10.angles)) {
      var10.angles = (0, 0, 0);
    }

    var10.planted_explosive.angles = var10.angles;
    var10.planted_explosive makeusable();
    var10.planted_explosive scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "icon_waypoint_cyber_bombsite", &"CP_STRIKE/PLACE_BEACON", 25, "duration_medium", "show", 70, 45, 70, 45);
    var10.planted_explosive.objindex = var11;
    var10.area = var0;
    thread waittill_planted();
  }

  ref_142e7(level, level.ref_12386[var0.pkg_id]);
  thread ref_142e9(level);
  thread friendly_hvi_vehicle_extra_riders_getin_scene(level);
}

function waittill_planted() {
  for(;;) {
    self.planted_explosive waittill("trigger", var0);
    var0 playlocalsound("cp_generic_placement");
    self.planted_explosive setModel("parts_radio_small_cp");
    thread blink_beacon();
    self.planted_explosive makeunusable();
    self.area.charges_planted++;
    scripts\cp\cp_objectives::screenent_c("small_event");
    var1 = self.area.num_charges_to_plant - self.area.charges_planted;
    scripts\cp\utility::objective_update("ba_" + self.area.script_noteworthy + "_plant", undefined, undefined, undefined, undefined, 3 - var1);
    thread ref_142d8(self.area, var1);
  }

  LOC_000000c2:
    scripts\cp\cp_objectives::screenent_c("minor_objective");
  objective_state(self.area.useobj.objindex, "done");
  scripts\cp\cp_objectives::lua_objective_complete("ba_" + self.area.script_noteworthy + "_plant");
  scripts\engine\utility::flag_set(self.area.flagname);
  level notify("area_cleared");
  self.area notify("area_cleared");
  scripts\cp\utility::ref_123fe("");

  if(!isDefined(level.calloutmarkerping_enemytodangerdecaycreate)) {
    level.calloutmarkerping_enemytodangerdecaycreate = 3;
    scripts\engine\utility::delaythread(4, &ref_142da, "dx_cps_land_base_assault_beacons_complete_1st_20");
  }

  level.calloutmarkerping_enemytodangerdecaycreate--;
  thread ref_142d5(self.area, level.calloutmarkerping_enemytodangerdecaycreate);
}

function blink_beacon() {
  wait 1;
  self setModel("parts_radio_small_cp_2");
  self playSound("breach_warning_beep_01");

  for(;;) {
    wait 3;
    self setModel("parts_radio_small_cp");
    wait 1;
    self setModel("parts_radio_small_cp_2");
    self playSound("breach_warning_beep_01");
  }
}

function ba_tower_start(var0) {
  var1 = getEnt("hangar_door_button", "targetname");
  objective_state(var0.objectiveindex, "current");
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var0.objectiveindex, var1.origin + (0, 0, 10));
  objective_setplayintro(var0.objectiveindex, 1);
  objective_setlabel(var0.objectiveindex, &"CP_MILBASE_DIALOGUE/LBL_TOWER");
  thread hangar_door_button();
  scripts\engine\utility::flag_wait("hangar_door_opened");
}

function ba_steal_tank_start(var0) {
  var1 = getEnt("hangar_beacon_cargo", "targetname");
  var1 setModel("tag_origin");
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var0.objectiveindex, var1.origin + (0, 0, 10));
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_setplayintro(var0.objectiveindex, 1);
  objective_setdescription(var0.objectiveindex, &"CP_MILBASE_DIALOGUE/STEAL_TANK");
  var1 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", "icon_waypoint_cyber_bombsite", &"CP_STRIKE/PLACE_BEACON", 25, "duration_medium", "show", 70, 45, 70, 45);
  var1 makeunusable();
  waittill_emp_beacon_planted(var1);
  objective_state(var0.objectiveindex, "done");
  scripts\cp\cp_objectives::lua_objective_complete("ba_steal_tank");
  scripts\engine\utility::flag_set("tanks_stolen");
  level notify("hangar_beacon_planted");
}

function waittill_emp_beacon_planted() {
  self waittill("trigger", var0);
  scripts\cp\cp_objectives::screenent_c("small_event");
  var0 playlocalsound("cp_generic_placement");
  self setModel("parts_radio_small_cp");
  thread blink_beacon();
  self makeunusable();
}

function ba_destroy_tanks_start(var0) {
  while(!isDefined(level.enemy_tanks) || level.enemy_tanks.size < 4) {
    wait 1;
  }

  for(var1 = 0; var1 < level.enemy_tanks.size; var1++) {
    objective_setlocation(var0.objectiveindex, var1, level.enemy_tanks[var1]);
  }

  while(level.enemy_tanks.size > 0) {
    wait 1;
  }
}

function init_alarm_system() {
  level.alarm_box_structs = scripts\engine\utility::getStructArray("alarm_box", "targetname");
  level.flare_launchers = getEntArray("ai_flare", "targetname");

  foreach(var1 in level.flare_launchers) {
    var1 hidepart("j_mortar_shell", "misc_wm_mortar");
  }

  foreach(var4 in level.alarm_box_structs) {
    scripts\cp\maps\cp_donetsk\milbase\ai_flare::initialize_alarm_box(var4);
  }
}

function call_in_reinforcements() {
  if(!scripts\engine\utility::flag_exist("call_reinforcements")) {
    scripts\engine\utility::flag_init("call_reinforcements");
  }

  if(scripts\engine\utility::flag("call_reinforcements")) {
    return;
  }

  scripts\engine\utility::flag_set("call_reinforcements");

  foreach(var1 in level.alarm_box_structs) {
    thread scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_alarm(var1, var1.alarm_box);
  }

  level scripts\engine\utility::waittill_notify_or_timeout("alarm_on", 45);

  foreach(var1 in level.alarm_box_structs) {
    var1 notify("stop_attracting");
  }

  foreach(var6 in level.flare_launchers) {
    var6 notify("stop_attracting");
    var6.attracting = 0;
  }

  foreach(var9 in level.agentarray) {
    if(isDefined(var9.going_to_object)) {
      var9.going_to_object = undefined;
      var9.goalradius = 2048;
      var9 scripts\cp\maps\cp_donetsk\milbase\ai_flare::clear_custom_anim();
    }
  }

  level.calling_reinforcements = 0;
  scripts\engine\utility::flag_clear("call_reinforcements");
  level notify("paratroopers");
}

function waittill_both_or_timeout(var0, var1, var2) {
  self endon("timedout");
  thread dotimer(var0);
  scripts\engine\utility::ref_1439f(var1, var2);
  self notify("notified");
}

function dotimer(var0) {
  self endon("notified");
  wait var0;
  self notify("timedout");
}

function rpg_interaction() {
  var0 = getEnt("rpg_crate", "targetname");
  var1 = getEnt("care_package_col", "targetname");
  var2 = spawn("script_model", var0.origin);
  var2.angles = var0.angles;
  var2 clonebrushmodeltoscriptmodel(var1);
  var2 linkTo(var0);
  var3 = scripts\engine\utility::getStructArray("rpg_interaction", "targetname");

  foreach(var5 in var3) {
    thread ref_12dcb();
  }
}

function ref_12dcb() {
  var0 = ref_135b3(self.origin, self.angles, "iw8_la_rpapa7_mp");
  var0 thread scripts\cp\cp_weapon::watchweaponpickup();
}

function sniper_interaction() {
  var0 = getEntArray("take_sniper", "targetname");

  foreach(var2 in var0) {
    thread sniper_pickup();
  }
}

function sniper_pickup() {
  scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/PICKUP_SNIPER", 25, "duration_short", "show", 70, 45, 70, 45);

  for(;;) {
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var0 scripts\cp\cp_weapons::minigun_track_target_think();
    self hide();
    self makeunusable();
    var1 = scripts\cp\cp_weapon::buildweapon("iw8_sn_kilo98_mp", ["scope"], "none", "none", -1);
    var0 giveweapon(var1);
    var0 switchtoweaponimmediate(var1);
  }
}

function hangar_door_button() {
  wait 1;
  thread rpg_interaction();
  var0 = getEnt("hangar_door_button", "targetname");
  var0 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/OPEN_HANGAR", 25, "duration_none", "show", 150, 45, 70, 45);
  var0 waittill("trigger");
  var0 makeunusable();
  var0 setModel("electrical_cell_door_button_green");
  thread ref_142e1();
  scripts\engine\utility::flag_set("hangar_door_opened");
  var0 playSound("scn_cp_landlord_hangar_button");
  ref_12b50(level.airfield_mortar_1);
  ref_12b50(level.airfield_mortar_2);
  scripts\cp\cp_modular_spawning::run_spawn_module("tank_hangar_enemies");
  var1 = scripts\engine\utility::getStructArray("milbase_player_tanks", "targetname");

  foreach(var3 in var1) {
    thread spawn_light_tank(var3);
  }

  wait 0.5;
  level.ref_124f6 = 1;
  var5 = getEnt("airfield_hangar_door", "script_noteworthy");
  var5 setscriptablepartstate("base", "opening");
  var6 = getEntArray("airfield_hangar_roller_doors", "script_noteworthy");

  foreach(var8 in var6) {
    var8 setscriptablepartstate("base", "opening");
  }
}

function spawn_light_tank(var0) {
  if(istrue(level.ref_124f6)) {
    return;
  }

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var1 = spawnStruct();
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.spawntype = "GAME_MODE";
  var1.owner = undefined;
  var1.team = "axis";
  var1.faceawayfromowner = 0;
  var1.cancapture = 0;
  var1.cancaptureimmediately = 0;
  var1.spawnmethod = "place_at_position";
  var1.activateimmediately = 1;
  var1.cantimeout = 0;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var1);
  var2 = scripts\cp_mp\vehicles\light_tank::light_tank_create(var1);
  var2.maxhealth = int(var2.health * 2.5);
  var2.health = var2.maxhealth;

  if(!isDefined(level.airfield_player_tanks)) {
    level.airfield_player_tanks = [];
  }

  level.airfield_player_tanks[level.airfield_player_tanks.size] = var2;
  var3 = spawn("script_model", var2.origin + (0, 0, 40));
  var3 makeusable();
  var3 sethinticon("icon_door_locked");
  var3 setHintString(&"CP_STRIKE/STEAL_TANK");
  var3 sethintdisplayrange(256);
  var3 setuserange(148);
  var3 setCursorHint("HINT_BUTTON");
  var3 sethintdisplayfov(120);
  var3 sethintonobstruction("show");
  var3 sethintrequiresholding(1);
  var3 setuseholdduration("duration_medium");
  var3 waittill("trigger", var4);
  var2.team = "allies";
  var2.ref_13aad = "allies";
  var2 setvehicleteam("allies");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(var2, "allies");
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var2);
  var2 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var2 makeentitysentient("allies");
  var3 delete();
  level notify("tank_stolen", var2);
  var5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getavailablevehicleseats(var2, 1);

  if(var5.size > 0 && scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_vehiclecanbeused(var2) == 1) {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var2, var5[0], var4);
    return;
  }
}

function spawn_enemy_chopper() {
  level endon("stop_exfil_spawning");

  for(;;) {
    var0 = scripts\engine\utility::getStruct("airfield_boss_heli_spawn", "targetname");
    var0.classname_mp = "script_vehicle_apache_east";
    var0.script_modelname = "veh8_mil_air_ahotel64_ks_east_mp";
    var0.vehicletype = "veh_apache_cp";
    var1 = scripts\common\vehicle::vehicle_spawn(var0);
    var1.death_fx_on_self = 1;
    var1.circle_radius = 2500;
    var1 scripts\cp\helicopter\cp_helicopter::heli_mg_create("veh8_mil_air_ahotel64_turret_wm", "apache_turret_cp", "tag_turret");
    thread setup_pilot(var1);
    var1.isheli = 1;
    var1.health = 50000;
    var1.maxhealth = 50000;
    var1.team = "axis";
    var1 setvehicleteam(var1.team);
    var1 setmaxpitchroll(15, 15);
    var1.health_remaining = 2250;
    level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(var1, undefined, "heli_search_airfield");
    var1 sethoverparams(25, 15, 10);
    var1.headicon = deleteheadicon(var1);
    setheadiconfriendlyimage(var1.headicon, "hud_icon_head_equipment_enemy");
    setheadiconsnaptoedges(var1.headicon, 12000);
    setheadiconmaxdistance(var1.headicon, 1500);
    addclienttoheadiconmask(var1.headicon, 10);
    setheadicondrawthroughgeo(var1.headicon, 1);

    if(!isDefined(level.special_lockon_target_list)) {
      level.special_lockon_target_list = [];
    }

    level.special_lockon_target_list[level.special_lockon_target_list.size] = var1;
    thread ref_142dc();
    level.cashtypes = var1;
    var1 waittill("death");
    wait randomintrange(220, 260);
  }
}

function setup_pilot(var0) {
  var1 = "tag_pilot";

  if(!self tagexists(var1)) {
    var1 = "tag_pilot1";
  }

  self.pilot = spawn("script_model", self gettagorigin(var1));
  self.pilot setModel("aq_pilot_fullbody_1");
  self.pilot linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  self.pilot scriptmodelplayanimdeltamotion("vh_mindia8_pilot_idle");

  if(isDefined(var0)) {
    thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor();
    return;
  }
}

function end_spawn_group(var0) {
  level endon("game_ended");
  thread _end_spawn_group(level);
}

function _end_spawn_group(var0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait_all("maint_done", "hangar_done", "warehouse_done");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function end_heli_spawn_group(var0) {
  level endon("game_ended");
  thread _end_spawn_group(level);
}

function _end_heli_spawn_group(var0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("boss_heli");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function mortar_launch_think() {
  level.get_mortar_impact_pos = &get_mortar_impact_spot;
  level.airfield_mortar_1 = getEnt("airfield_mortar_1", "targetname");
  level.airfield_mortar_2 = getEnt("airfield_mortar_2", "targetname");
  level.airfield_mortar_1 hidepart("j_mortar_shell", "misc_wm_mortar");
  level.airfield_mortar_2 hidepart("j_mortar_shell", "misc_wm_mortar");
  wait 30;
  thread mortar_think(level.airfield_mortar_1);
  thread mortar_think(level.airfield_mortar_2);
}

function mortar_think(var0) {
  level endon("game_ended");
  level endon("hangar_door_opened");
  var1 = scripts\engine\utility::getStruct(var0, "targetname");
  var2 = spawn("trigger_radius", var1.origin, 0, int(var1.radius), int(var1.height));
  var2.targetname = var0;
  self.targets = undefined;

  for(;;) {
    var3 = get_players_in_area(var2);

    if(var3.size) {
      self.targets = var3;
      scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_mortar(self, 1);
      self.targets = undefined;
      wait randomintrange(5, 8);
      continue;
    }

    wait 1;
  }
}

function get_players_in_area(var0) {
  var1 = [];

  foreach(var3 in level.players) {
    if(!var3 scripts\cp\utility::is_valid_player() || !var3 isonground()) {
      continue;
    }

    if(var3 istouching(var0)) {
      var1 = var3;
    }
  }

  return var1;
}

function get_mortar_impact_spot(var0) {
  if(!isDefined(var0.targets)) {
    return undefined;
  }

  var1 = scripts\engine\utility::random(var0.targets);
  var2 = var1.origin + (randomintrange(-100, 100), randomintrange(-100, 100), 0);
  var3 = scripts\engine\trace::ray_trace(var2 + (0, 0, 500), var2);
  return var3["position"];
}

function spawn_intro_choppers() {
  var0 = getEnt("heli_flyoff", "targetname");

  for(;;) {
    var0 waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  var2 = scripts\engine\utility::getStructArray("intro_heli_spawn", "targetname");

  foreach(var4 in var2) {
    var4.classname_mp = "script_vehicle_iw8_mindia8";
    var4.script_modelname = "veh8_mil_air_mindia8";
    var4.vehicletype = "mindia8_cp";
    var5 = scripts\common\vehicle::vehicle_spawn(var4);
    thread setup_pilot();
    var5.isheli = 1;
    var5.health = 50000;
    var5.maxhealth = 50000;
    var5.team = "axis";
    var5 setvehicleteam(var5.team);
    var5 setmaxpitchroll(15, 15);
    var5 sethoverparams(25, 15, 10);
    thread intro_chopper();
    wait 2;
  }
}

function intro_chopper() {
  self endon("death");
  self vehicle_setspeed(20, 15, 15);
  self setvehgoalpos(self.origin + (0, 0, 1200), 1);
  scripts\engine\utility::ref_143bb(10, "goal", "goal_reached", "near_goal");
  var0 = scripts\engine\utility::getStruct("intro_chopper_delete", "targetname");
  self vehicle_setspeed(90, 30, 30);
  self setvehgoalpos(var0.origin, 1);
  scripts\engine\utility::ref_143bb(45, "goal", "goal_reached", "near_goal");
  self.pilot delete();
  self delete();
}

function tank_battle_test() {
  wait 10;
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "tank_test_player_start");
  thread hangar_door_button();
  wait 30;
  thread spawn_enemy_tanks();
}

function spawn_enemy_tanks() {
  var0 = scripts\engine\utility::getStructArray("airfield_enemy_tank", "targetname");
  level.altgunnerturret = "sentry_minigun_mp";
  level.enemy_tanks = [];
  thread ref_142db();

  foreach(var2 in var0) {
    thread spawn_enemy_tank(level);
    wait randomintrange(3, 7);
  }
}

function spawn_enemy_tank(var0) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var1 = spawnStruct();
  var2 = spawnStruct();
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.spawntype = "GAME_MODE";
  var1.owner = undefined;
  var1.team = "axis";
  var1.faceawayfromowner = 0;
  var1.cancapture = 0;
  var1.cancaptureimmediately = 0;
  var1.spawnmethod = "airdrop_at_position_unsafe";
  var1.activateimmediately = 1;
  var1.cantimeout = 0;
  var1.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var1);
  var3 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var1, var2);

  if(!isDefined(var3)) {
    return;
  }

  wait 10;
  level.enemy_tanks[level.enemy_tanks.size] = var3;
  thread tank_waittill_death();
  thread ref_14350();
  var3 endon("death");
  var3 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var4 = scripts\engine\utility::getStructArray("enemy_tank_path", "targetname");
  var5 = sortbydistance(var4, var3.origin)[0];
  var6 = build_tank_path(var5);
  var7 = build_tank_duration(var5);
  var3 startpathnodes(var6, var7);
  setheadiconsnaptoedges(var3.headicon, 8088);
  var8 = scripts\cp_mp\vehicles\vehicle::ref_14192(var3, "tur_bradley_mp");
  var9 = scripts\cp_mp\vehicles\vehicle::ref_14192(var3, "tur_gun_lighttank_mp");

  if(!isDefined(level.vo_paratroopers)) {
    level.vo_paratroopers = [];
  }

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var3);

  for(;;) {
    var10 = var3 scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var10)) {
      wait 1;
      continue;
    }

    if(istrue(var10.binvehicle) && isDefined(var10.vehicle)) {
      if(var8 turretcantarget(var10.vehicle.origin + (0, 0, 50))) {
        var8 settargetentity(var10.vehicle, (0, 0, 50));
      }

      if(var9 turretcantarget(var10.vehicle.origin + (0, 0, 50))) {
        var9 settargetentity(var10.vehicle, (0, 0, 50));
      }
    } else {
      var8 settargetentity(var10);
      var9 settargetentity(var10);
    }

    thread tank_shoot_at_target(var3, var9);
    thread tank_shoot_at_target(var3);
    wait randomfloatrange(3, 5);
  }
}

function tank_shoot_at_target(var0, var1) {
  self endon("death");
  var0 endon("death");
  var2 = 1;
  var3 = getcompleteweaponname("tur_bradley_mp");

  if(istrue(var1)) {
    var2 = randomintrange(15, 25);
    var3 = getcompleteweaponname("tur_gun_lighttank_mp");
  }

  var4 = weaponfiretime(var3);

  for(var5 = 0; var5 < var2; var5++) {
    var0 shootturret();
    wait var4;
  }
}

function build_tank_path(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = var2.origin; isDefined(var2) && isDefined(var2.target); var1 = var2.origin) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
}

function build_tank_duration(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = 10; isDefined(var2) && isDefined(var2.target); var1 = 10) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
}

function tank_waittill_death() {
  self waittill("death");

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
    self.headicon = undefined;
  }

  level.enemy_tanks = scripts\engine\utility::array_remove(level.enemy_tanks, self);
  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, self);
}

function base_explosion_test() {
  scripts\engine\utility::flag_set("cp_airfield_create_script");
  scripts\engine\utility::flag_wait("cp_airfield_create_script_completed");
  wait 0.5;
  level.use_alt_b = randomint(100) > 49;
  scripts\engine\utility::flag_init("hangar_done");
  scripts\engine\utility::flag_init("maint_done");
  scripts\engine\utility::flag_init("warehouse_done");
  scripts\engine\utility::flag_init("shipping_done");
  scripts\engine\utility::flag_init("hangar_door_opened");
  scripts\engine\utility::flag_init("milbase_escape");
  scripts\engine\utility::flag_init("tanks_stolen");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("interactions_initialized");
  level.pkg_ids = [0, 1, 2, 3, 4, 5, 6, 7];
  level.pkg_lbl = [];
  level.pkg_lbl[0] = "sign_metal_ship_label_00";
  level.pkg_lbl[1] = "sign_metal_ship_label_01";
  level.pkg_lbl[2] = "sign_metal_ship_label_02";
  level.pkg_lbl[3] = "sign_metal_ship_label_03";
  level.pkg_lbl[4] = "sign_metal_ship_label_04";
  level.pkg_lbl[5] = "sign_metal_ship_label_05";
  level.pkg_lbl[6] = "sign_metal_ship_label_06";
  level.pkg_lbl[7] = "sign_metal_ship_label_07";
  level.ref_12386 = [];
  level.ref_12386[0] = "dx_cps_lass_base_assault_place_beacon_0197a";
  level.ref_12386[1] = "dx_cps_lass_base_assault_place_beacon_1275b";
  level.ref_12386[2] = "dx_cps_lass_base_assault_place_beacon_2325c";
  level.ref_12386[3] = "dx_cps_lass_base_assault_place_beacon_3446d";
  level.ref_12386[4] = "dx_cps_lass_base_assault_place_beacon_4505e";
  level.ref_12386[5] = "dx_cps_lass_base_assault_place_beacon_5623f";
  level.ref_12386[6] = "dx_cps_lass_base_assault_place_beacon_6771g";
  level.ref_12386[7] = "dx_cps_lass_base_assault_place_beacon_7808h";
  setup_search_areas();

  while(!level.players[0] meleeButtonPressed()) {
    wait 0.05;
  }

  while(level.players[0] meleeButtonPressed()) {
    wait 0.05;
  }

  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "tank_test_player_start");
  wait 3;
  thread do_killstreaks();
  wait 2;
  thread detonate_explosives();
  level waittill("forever");
}

function detonate_explosives() {
  var0 = level.airfield_plant_spots;
  var0 = scripts\engine\utility::array_randomize(var0);

  for(;;) {
    foreach(var2 in var0) {
      thread detonate_explosive();
      wait randomfloatrange(0.75, 1.5);
    }

    wait randomfloatrange(1, 2.5);
  }
}

function detonate_explosive() {
  level endon("game_ended");
  var0 = [level._effect["milbase_exp_sm"], level._effect["milbase_exp_lg"], level._effect["milbase_exp_lg"]];
  playFX(scripts\engine\utility::random(var0), self.origin);
  earthquake(randomfloatrange(0.2, 0.3), 1, self.origin, 10000);
  playsoundatpos(self.origin, "scn_cp_airfield_base_expl");
  thread kill_nearby_ai_enemies(self.origin, 1000);
}

function kill_nearby_ai_enemies(var0, var1) {
  foreach(var3 in level.agentarray) {
    if(!istrue(var3.isactive)) {
      continue;
    }

    if(distance2dsquared(var0, var3.origin) > var1 * var1) {
      continue;
    }

    var3 dodamage(var3.health + 1000, var0, undefined, undefined, "MOD_EXPLOSIVE", "iw8_la_rpapa7_mp_friendly");
  }
}

function targets_killed(var0) {
  var1 = getEntArray("trigger_spawner", "targetname");
  var2 = getEntArray("trigger_spawner_extra", "targetname");
  var3 = getEnt("trigger_spawner_jug", "targetname");

  foreach(var5 in var1) {
    targetoverride(var5, var0);
  }

  foreach(var5 in var2) {
    targetoverride(var5, var0);
  }

  thread vehicle_damage_onexitstatelight();
  var9 = scripts\engine\utility::getStructArray("jug_guardian", "targetname").size;
  scripts\cp\cp_modular_spawning::registerambientgroup("jug_guardian", 1, var9, var9, 0.1, undefined, "jug_guardian");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("jug_guardian", &vehicle_damage_onenterstatemedium);
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func("jug_guardian", &bot_choose_defend_role);
  var10 = scripts\cp\cp_modular_spawning::run_spawn_module("jug_guardian");
}

function targetoverride(var0) {
  var1 = scripts\engine\utility::getStructArray(self.target, "targetname").size;
  scripts\cp\cp_modular_spawning::registerambientgroup(self.target, 1, var1, var1, 0.1, undefined, self.target, undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(self.target, &ai_spawn_func);
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func(self.target, &bot_choose_defend_role);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group(self.target, undefined, undefined, self.script_maxdist, undefined);
  thread trigger_spawn(var0);
}

function trigger_spawn(var0) {
  level endon("stealth_over");
  self endon("stop_spawning");
  self endon("death");

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  var2 = self.target;
  var3 = scripts\cp\cp_modular_spawning::run_spawn_module(var2);
  self delete();
}

function bot_choose_defend_role(var0) {
  self endon("death");

  if(!scripts\engine\utility::flag("stealth_over")) {
    scripts\engine\utility::flag_set("stealth_over");
    var1 = getEntArray("trigger_spawner", "targetname");
    var2 = getEntArray("trigger_spawner_extra", "targetname");

    foreach(var4 in var1) {
      var4 delete();
    }

    foreach(var4 in var2) {
      var4 delete();
    }

    thread ref_142ed();
  }

  self.sightmaxdistance = 10000;
}

function ai_spawn_func(var0) {
  if(!isDefined(self.spawnpoint)) {
    return;
  }

  if(istrue(self.spawnpoint.script_noteworthy == "sniper")) {
    self.sightmaxdistance = 4096;
    self.pacifist_override = 1;
    self.ref_133b9 = 1;
    thread scripts\cp\coop_stealth::run_common_functions(self, 0, 0, 75, 1440000);
    return;
  }

  self.sightmaxdistance = 2048;
  self.pacifist_override = 1;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 75, 147456);
}

function vehicle_damage_onexitstatelight() {
  thread vehicle_damage_onexitstateheavy();
}

function vehicle_damage_onexitstateheavy() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);

    if(!var0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_server_approach_10", "allies");
  thread ref_142ea();
  self delete();
}

function vehicle_damage_onenterstatemedium(var0) {
  if(!isDefined(self.spawnpoint)) {
    return;
  }

  if(!istrue(level.global_stealth_broken)) {
    thread ref_142e5();
  }

  self.sightmaxdistance = 2048;
  self.pacifist_override = 1;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 75, 262144);
  thread vehicle_damage_onenterstatelight();
}

function vehicle_damage_onenterstatelight(var0) {
  level endon("game_ended");
  self waittill("death");
  wait 120;
  scripts\cp\cp_modular_spawning::run_spawn_module("base_jugg_reinforce");
}

function ref_142df() {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_rendezvous_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_base_assault_rendezvous_20", "allies");
  wait randomintrange(7, 12);
  thread ref_142ee();
}

function ref_142e0() {
  level endon("game_ended");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_snr_hacking_complete_10");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_base_assault_snr_hacking_complete_20");
}

function ref_142e7(var0) {
  scripts\cp\cp_vo::try_to_play_vo_on_team(var0 + "_10", "allies");
}

function ref_142d8(var0, var1) {
  var2 = "_10";

  if(var1 == 1) {
    var2 = "_20";
  }

  var3 = scripts\cp\utility::give_all_players_nearby(var0.ref_11e20.origin, squared(int(var0.ref_11e20.radius)));

  if(var3.size) {
    foreach(var5 in var3) {
      var5 scripts\cp\cp_vo::try_to_play_vo("dx_cps_lass_base_assault_beacon_planted" + var2, "cp_comment_vo", "highest", 10, 0, 0, 1, 100);
    }

    return;
  }
}

function ref_142d5(var0, var1) {
  var2 = "dx_cps_lass_base_assault_beacons_complete_1st_10";

  if(var1 == 1) {
    var2 = "dx_cps_lass_base_assault_beacons_complete_2nd_20";
  }

  var3 = scripts\cp\utility::give_all_players_nearby(var0.ref_11e20.origin, squared(int(var0.ref_11e20.radius)));

  if(var3.size) {
    foreach(var5 in var3) {
      var5 scripts\cp\cp_vo::try_to_play_vo(var2, "cp_comment_vo", "highest", 10, 0, 0, 1, 100);
    }

    return;
  }
}

function ref_142d7() {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_beacons_complete_3rd_30", "allies");
  ref_142da(level, "dx_cps_land_base_assault_hangars_redirect_10");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_base_assault_hangars_redirect_20", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_base_assault_hangars_redirect_30", "allies");
  var0 = scripts\engine\utility::random(scripts\cp\utility::getplayersinteam("allies"));
  wait level scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "conv_generic_reply");
}

function ref_142e1() {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_base_assault_control_tower_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_control_tower_20", "allies");
  thread ref_142e8();
  level waittill("hangar_beacon_planted");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_base_assault_hangar_interior_complete_10", "allies");
}

function ref_142ed() {
  wait 5;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_base_assault_detected_10", "allies");
  wait 5;
  ref_142da(level, "dx_cps_land_base_assault_detected_20");
  wait 3;
  ref_142da(level, "dx_cps_land_base_assault_detected_20");
}

function ref_142e5() {
  level endon("game_ended");
  var0 = cos(75);

  for(;;) {
    foreach(var2 in level.players) {
      if(istrue(level.global_stealth_broken)) {
        return;
      }

      if(scripts\engine\utility::within_fov(var2 getEye(), var2.angles, self.origin, var0) && var2 scripts\engine\utility::can_trace_to_ai(var2 getEye(), self)) {
        thread ref_142e6();
        return;
      }
    }

    wait 1;
  }
}

function ref_142e6() {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_base_assault_juggernaut_spotted_stealth_10", "allies");
}

function ref_142da(var0) {
  var1 = scripts\engine\utility::getStructArray("milbase_pa", "targetname");

  foreach(var3 in var1) {
    playsoundatpos(var3.origin, var0);
  }

  var5 = lookupsoundlength(var0) / 1000;
  wait var5 + 1;
}

function ref_142ee() {
  level endon("game_ended");

  while(!istrue(level.global_stealth_broken)) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_aqlie_base_assault_stealth_exchange_1_10", "allies");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_land_base_assault_stealth_exchange_1_20", "allies");
    wait 3;
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_land_base_assault_stealth_exchange_2_10", "allies");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_aqlie_base_assault_stealth_exchange_2_20", "allies");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_land_base_assault_stealth_exchange_2_30", "allies");
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_aqlie_base_assault_stealth_exchange_2_40", "allies");
    return;
  }
}

function monitor_flag_carrier() {
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_land_base_assault_egress_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_aqlie_base_assault_egress_20", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_land_base_assault_egress_30", "allies");
}

function vo_mission_end() {
  level endon("game_ended");
  wait 2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_incoming_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_land_base_assault_incoming_20", "allies");
  wait 3;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_mission_complete_10", "allies");
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_kama_base_assault_mission_complete_20", "allies");
}

function ref_142db() {
  var0 = ["dx_cps_kama_callout_tank_spawning_10", "dx_cps_kama_callout_tank_spawning_20", "dx_cps_lass_callout_tank_spawning_10", "dx_cps_lass_callout_tank_spawning_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var0), "allies");
}

function ref_142ec() {
  if(!isDefined(level.ref_121d5)) {
    level.ref_121d5 = gettime() - 1000;
  }

  if(level.ref_121d5 > gettime()) {
    return;
  }

  var0 = ["dx_cps_kama_callout_paratrooper_spawning_10", "dx_cps_kama_callout_paratrooper_spawning_20", "dx_cps_lass_callout_paratrooper_spawning_10", "dx_cps_lass_callout_paratrooper_spawning_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var0), "allies");
  level.ref_121d5 = gettime() + 30000;
}

function ref_142dc() {
  var0 = ["dx_cps_kama_callout_helicopter_attacking_10", "dx_cps_kama_callout_helicopter_attacking_20", "dx_cps_lass_callout_helicopter_attacking_10", "dx_cps_lass_callout_helicopter_attacking_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var0), "allies");
}

function ref_142ea() {
  level endon("game_ended");
  level endon("router_placed");

  for(;;) {
    wait randomintrange(25, 45);

    if(istrue(level.ref_12dbd)) {
      return;
    }

    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_snr_nag_10", "allies");
  }
}

function ref_142e9(var0) {
  var0 endon("area_cleared");
  level endon("game_ended");

  for(;;) {
    wait randomintrange(30, 45);
    var1 = scripts\cp\utility::give_all_players_nearby(var0.ref_11e20.origin, squared(int(var0.ref_11e20.radius)));

    if(var1.size) {
      foreach(var3 in var1) {
        var3 scripts\cp\cp_vo::try_to_play_vo(level.ref_12386[var0.pkg_id] + "_20", "cp_comment_vo", "highest", 10, 0, 0, 1, 100);
      }
    }
  }
}

function ref_142e8() {
  level endon("game_ended");
  level endon("hangar_beacon_planted");
  var0 = getEnt("hangar_beacon_cargo", "targetname");

  while(!scripts\cp\utility::any_player_nearby(var0.origin, squared(1024))) {
    wait 0.1;
  }

  var1 = scripts\engine\utility::getclosest(var0.origin, level.players);
  wait scripts\cp\cp_player_battlechatter::trysaylocalsound(var1, "obj_inform_confirm");
  wait 0.2;
  level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_hangar_interior_10", "allies");
  var0 makeusable();

  for(;;) {
    wait randomintrange(17, 28);
    level scripts\cp\cp_vo::try_to_play_vo_on_team("dx_cps_lass_base_assault_hangar_interior_20", "allies");
  }
}

function ref_142f2() {
  level endon("game_ended");

  for(;;) {
    level waittill("manifest_computer_used", var0);
    scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_interact");
  }
}

function old_health() {
  level endon("game_ended");
  var0 = getEnt("start_exfil_spawning", "targetname");

  for(;;) {
    var0 waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    break;
  }

  thread onenterfunc();
  level waittill("call_exfil");
  wait 5;
  level notify("stop_exfil_spawning");
  thread oncratedestroy();
}

function onenterfunc() {
  level endon("stop_exfil_spawning");
  scripts\cp\cp_modular_spawning::stop_all_groups();
  level notify("stop_paratroopers");
  level notify("stop_reinforcements");
  scripts\cp\cp_modular_spawning::registerambientgroup("parachute_exfil_group_1", 4, 4, 4, 0.5, 0, "parachute_exfil_group_1", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("parachute_exfil_group_2", 4, 4, 4, 0.5, 0, "parachute_exfil_group_2", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("parachute_exfil_group_3", 4, 4, 4, 0.5, 0, "parachute_exfil_group_3", undefined, undefined, 5);
  ref_135e3();
  wait 2;
  scripts\engine\utility::delaythread(5, &ref_13535);
  wait 5;
  ref_135d1();
  scripts\engine\utility::delaythread(10, &ref_135e4);
  var0 = 24;
  var1 = 12;
  var2 = 2;
  var3 = 1;

  for(;;) {
    var4 = level.spawned_ai;

    if(var4.size < var1) {
      if(var3) {
        wait 1;
        var3 = 0;
        goto LOC_000000d5;
      }

      wait var2;

      while(var4.size < var0) {
        var4 = level.spawned_ai;
        var5 = var0 - var4.size;

        if(var5 >= 4) {
          thread ref_1354c();
          level waittill("exfil_paratroopers_spawned");
        }

        wait 0.1;
      }
    }

    wait 0.1;
  }
}

function ref_1354c() {
  var0 = scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(["parachute_exfil_group_1", "parachute_exfil_group_2", "parachute_exfil_group_3"]), undefined, (-13512, 66432, 5904));
  thread ref_142ec();
  level notify("exfil_paratroopers_spawned");
}

function ref_135e3() {
  var0 = scripts\engine\utility::getStruct("convoy_start_airfield_exfil", "targetname");
  var1 = "single-techo-turret";
  var2 = "convoy_01";
  thread spawn_convoy(level, var2, var1);
}

function ref_135e4() {
  level endon("game_ended");

  while(level.spawned_ai.size > 16) {
    wait 0.1;
  }

  var0 = scripts\engine\utility::getStruct("convoy_start_airfield_exfil_4", "targetname");
  var1 = "single-techo-turret";
  var2 = "convoy_04";
  thread spawn_convoy(level, var2, var1);
}

function ref_13535() {
  var0 = scripts\engine\utility::getStruct("convoy_start_airfield_exfil_2", "targetname");
  var1 = "double-techo-cargo";
  var2 = "convoy_02";
  thread spawn_convoy(level, var2, var1);
}

function ref_135d1() {
  var0 = scripts\engine\utility::getStruct("convoy_start_airfield_exfil_3", "targetname");
  var1 = "single-techo-cargo";
  var2 = "convoy_03";
  thread spawn_convoy(level, var2, var1);
}

function spawn_convoy(var0, var1, var2) {
  var3 = &scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var4 = level[[var3]](var0, var1, var2);
  thread allow_driver_exit(level);
  var4 scripts\cp\cp_convoy_manager::set_use_path_speeds_modifier(1);
  level waittill("despawn_" + var0);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_at_distance(1);
  var4 thread scripts\cp\cp_convoy_manager::set_despawn_distance(5000);
  var4 thread scripts\cp\cp_convoy_manager::delay_kill_convoy_ents(0.05, 1);
}

function allow_driver_exit(var0) {
  wait 1;
  var0 notify("able_to_deposit_driver");
  var0 scripts\cp\cp_convoy_manager::ref_1307d(0);
}

function oncratedestroy() {
  foreach(var1 in level.spawned_ai) {
    thread ref_12dfc();
  }

  if(isDefined(level.cashtypes)) {
    level.cashtypes notify("leave_area");
    wait 0.05;
    level.cashtypes notify("needs_to_evade");
    var3 = scripts\engine\utility::getStruct("airfield_boss_heli_spawn", "targetname");
    level.cashtypes cleargoalyaw();
    level.cashtypes vehicle_setspeed(50, 30);
    level.cashtypes setvehgoalpos(var3.origin, 1);
    level.cashtypes waittill("goal");
    level.cashtypes delete();
    return;
  }
}

function ref_12dfc() {
  self endon("death");
  level endon("game_ended");
  var0 = scripts\engine\utility::random(scripts\engine\utility::getStructArray("retreat_spots", "targetname"));
  self.ignoreall = 1;
  self.playing_skit = 1;
  self.goalradius = 64;
  self setgoalpos(var0.origin);
  self waittill("goal");
  self dodamage(self.health + 100, self.origin);
}

function ref_14350() {
  self endon("death");
  wait 5;

  for(;;) {
    wait 1;

    if(self vehicle_getspeed() < 1) {
      self stoppath(1);
      return;
    }
  }
}

function ref_12b06() {
  scripts\cp\cp_modular_spawning::registerambientgroup("barracks_heli_1", 3, 9, 9, 0.1, undefined, "barracks_heli_1", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("barracks_heli_2", 3, 6, 6, 0.1, undefined, "barracks_heli_2", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("road_heli_1", 3, 9, 9, 0.1, undefined, "road_heli_1", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("road_heli_2", 3, 9, 9, 0.1, undefined, "road_heli_2", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("cargo_road_1", 3, 6, 6, 0.1, undefined, "cargo_road_1", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("cargo_swamp_1", 3, 9, 9, 0.1, undefined, "cargo_swamp_1", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("field_heli_1", 3, 9, 9, 0.1, undefined, "field_heli_1", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("tarmac_heli_1", 3, 6, 6, 0.1, undefined, "tarmac_heli_1", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("hill_top_1", 3, 6, 6, 0.1, undefined, "hill_top_1", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("bunker_truck_1", 3, 9, 9, 0.1, undefined, "bunker_truck_1", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("bunker_truck_2", 3, 9, 9, 0.1, undefined, "bunker_truck_2", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("barracks_road_1", 3, 9, 9, 0.1, undefined, "barracks_road_1", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("lower_road_1", 3, 9, 9, 0.1, undefined, "lower_road_1", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("lower_road_3", 3, 9, 9, 0.1, undefined, "lower_road_3", undefined, undefined, 15);
  scripts\cp\cp_modular_spawning::registerambientgroup("lower_road_2", 3, 9, 9, 0.1, undefined, "lower_road_2", undefined, undefined, 15);
}

function called75percentprogress(var0) {
  level endon("game_ended");

  if(isDefined(var0.ref_1425f)) {
    return;
  }

  var0.ref_1425f = 1;

  switch (var0.script_noteworthy) {
    case "obj_a":
      scripts\cp\cp_modular_spawning::run_spawn_module("bunker_truck_1");
      scripts\cp\cp_modular_spawning::run_spawn_module("tarmac_heli_1");
      wait 5;
      scripts\cp\cp_modular_spawning::run_spawn_module("field_heli_1");
      wait 10;
      scripts\cp\cp_modular_spawning::run_spawn_module("bunker_truck_2");
      break;
    case "obj_b":
      scripts\cp\cp_modular_spawning::run_spawn_module("cargo_road_1");
      scripts\cp\cp_modular_spawning::run_spawn_module("cargo_swamp_1");
      wait 10;
      scripts\cp\cp_modular_spawning::run_spawn_module("lower_road_2");
      break;
    case "obj_b_alt":
      scripts\cp\cp_modular_spawning::run_spawn_module("cargo_road_1");
      scripts\cp\cp_modular_spawning::run_spawn_module("cargo_swamp_1");
      wait 10;
      scripts\cp\cp_modular_spawning::run_spawn_module("hill_top_1");
      break;
    case "obj_c":
      scripts\cp\cp_modular_spawning::run_spawn_module("barracks_road_1");
      wait 5;
      scripts\cp\cp_modular_spawning::run_spawn_module("barracks_heli_1");
      wait 10;
      scripts\cp\cp_modular_spawning::run_spawn_module("barracks_heli_2");
      wait 10;
      scripts\cp\cp_modular_spawning::run_spawn_module("lower_road_1");
      break;
  }
}

function ref_12b50(var0) {
  if(isDefined(var0.operator) && isalive(var0.operator)) {
    var0.operator.goalradius = 2048;
    var0.operator = undefined;
    return;
  }
}

function ref_135b3(var0, var1, var2) {
  var3 = undefined;
  var3 = scripts\cp\utility::getweaponrootname(var2);
  var4 = [];
  var5 = scripts\cp\cp_weapon::buildweapon(var3, var4, "none", "none", -1);
  var6 = createheadicon(var5);
  var2 = spawn("weapon_" + var6, var0, 17);
  var2 sethintdisplayrange(96);
  var2 setuserange(96);
  var2 setuseholdduration("duration_short");
  var2 setusefov(210);
  var2.targetname = "dropped_weapon";
  var2.objweapon = var5;
  var2.angles = var1;
  var2 itemweaponsetammo(weaponclipsize(var2), weaponmaxammo(var2));
  return var2;
}

function friendly_hvi_vehicle_extra_riders_getin_scene(var0) {
  wait randomintrange(10, 20);
  scripts\cp\crate_drops\cp_crate_drops::ref_12c40(var0);
}

function little_bird_mg_handleflarefire() {
  level endon("game_ended");
  wait 10;
  var0 = scripts\cp\cp_spawning_util::balloon_deposit((4491.52, 49455, 1035.5), 825);

  while(!scripts\engine\utility::flag_exist("hangar_door_opened")) {
    wait 1;
  }

  scripts\engine\utility::flag_wait("hangar_door_opened");
  scripts\cp\cp_spawning_util::ref_12bf2(var0);
}