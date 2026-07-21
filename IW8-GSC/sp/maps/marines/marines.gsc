/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\marines\marines.gsc
***********************************************/

main() {
  scripts\sp\maps\marines\marines_anim.gsc::main();
  scripts\sp\maps\marines\gen\marines_art.gsc::main();
  scripts\sp\maps\marines\marines_fx.gsc::main();
  scripts\sp\maps\marines\marines_lighting.gsc::main();
  scripts\sp\maps\marines\marines_precache.gsc::main();
  scripts\sp\maps\marines\marines_vignettes.gsc::main();
  marines_starts();
  marines_transients();
  marines_precache();
  setsaveddvar("MRNRKKOPLN", 6);
  setsaveddvar("MQPQKNPQOK", 3);
  setsaveddvar("LQLSPQOPKM", 40);
  setsaveddvar("OLSKLTPPMR", 0.5);
  setsaveddvar("NQTLPTNSSO", 3);
  setdvarifuninitialized("scr_use_procedural_bones", 1);
  setDvar("scr_disable_civ_kills", 0);
  setsaveddvar("MMLNNQSTTL", 5);
  scripts\sp\audio::set_audio_level_fade_time(0.05);
  scripts\sp\load::main();
  level.friendlyfire["max_participation"] = level.friendlyfire["friend_kill_points"] * -2;
  level.player.participation = 0;
  scripts\sp\maps\marines\marines_utility.gsc::init_dialog_structs();
  init_threatbias_groups();
  scripts\sp\maps\marines\marines_gameplay_convoy.gsc::convoy_init();
  scripts\sp\maps\marines\marines_gameplay_streets.gsc::streets_init();
  scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::retreat_init();
  scripts\sp\maps\marines\marines_gameplay_hospital.gsc::hospital_init();
  scripts\sp\maps\marines\marines_gameplay_civ_ambush.gsc::civ_ambush_init();
  scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::hospital_upper_init();
  scripts\sp\maps\marines\marines_background.gsc::marines_background_init();
  init_hints();
  scripts\sp\maps\marines\marines_utility.gsc::marine_callsign_generate_list_init();
  helicopter_spawn_function_init();
  createthreatbiasgroup("groundfloor_aq_bias");
  createthreatbiasgroup("groundfloor_civ_bias");
  thread marines_objectives();
  marines_player_setup();
  thread scripts\sp\maps\marines\marines_utility.gsc::display_ai_count("all");
  scripts\engine\sp\utility::disable_trigger_with_targetname("gate_push_trigger");
  thread scripts\engine\sp\utility::add_global_spawn_function("axis", ::exterior_aq_face_enemy_dist_override, "face_enemy_dist_override", "retreat_bombardment_aq_left", "retreat_bombardment_aq_right");
  thread scripts\sp\maps\marines\marines_utility.gsc::death_hint_watcher_marines_tripwire_death();
  thread scripts\sp\maps\marines\marines_utility.gsc::player_underbarrel_grenade_launcher_used_monitor();
  thread scripts\sp\maps\marines\marines_utility.gsc::friendly_fire_dialogue_monitor();
  thread scripts\sp\friendlyfire::strict_ff_enable();
}

helicopter_spawn_function_init() {
  var_0 = getEntArray("script_vehicle_apache", "classname");
  scripts\engine\sp\utility::array_spawn_function(var_0, scripts\common\vehicle::vehicle_lights_off, "running");
}

init_hints() {
  scripts\engine\sp\utility::add_hint_string("smoke_hint", &"MARINES/SMOKE_HINT", scripts\sp\maps\marines\marines_gameplay_streets.gsc::smoke_check);
  scripts\engine\sp\utility::add_hint_string("smoke_nag", &"MARINES/SMOKE_NAG", scripts\sp\maps\marines\marines_gameplay_streets.gsc::smoke_nag);
  scripts\engine\sp\utility::add_hint_string("grenade_swap", &"SCRIPT/LEARN_GRENADE_LAUNCHER", scripts\sp\maps\marines\marines_gameplay_streets.gsc::grenade_swap_clear);
  scripts\engine\sp\utility::add_hint_string("grenade_swap_kbm", &"SCRIPT/LEARN_GRENADE_LAUNCHER_KBM", scripts\sp\maps\marines\marines_gameplay_streets.gsc::grenade_swap_clear);
  scripts\engine\sp\utility::add_hint_string("tripwire_hint", &"MARINES/TRIPWIRE_HINT", scripts\sp\maps\marines\marines_gameplay_convoy.gsc::tripwire_check);
  scripts\engine\sp\utility::add_hint_string("civ_trap_hint", &"MARINES/FRIEND_OR_FOE_DEATH", scripts\sp\maps\marines\marines_gameplay_civ_ambush.gsc::civ_trap_hint_clear);
  scripts\engine\sp\utility::add_hint_string("snakecam_controls_hint", &"MARINES/SNAKECAM_CONTROLS", scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::snakecam_controls_hint_clear);
  scripts\engine\sp\utility::add_hint_string("snakecam_controls_hint_kbm", &"MARINES/SNAKECAM_CONTROLS_KBM", scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::snakecam_controls_hint_clear);
  scripts\engine\sp\utility::add_hint_string("marines_wolf_tripwire_hint", &"MARINES/WOLF_TRIPWIRE", scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::marines_wolf_tripwire_hint_clear);
  scripts\engine\sp\utility::add_hint_string("marines_wolf_takedown_hint", &"MARINES/WOLF_TAKEDOWN", scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::marines_wolf_takedown_hint_clear);
  scripts\engine\sp\utility::add_hint_string("marines_snakecam_exit", &"MARINES/SNAKECAM_EXIT", scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::marines_snakecam_exit_clear);
}

init_threatbias_groups() {
  createthreatbiasgroup("retreat_allies");
  createthreatbiasgroup("retreat_enemies");
  setthreatbias("retreat_allies", "retreat_enemies", 1000);
  setthreatbias("retreat_enemies", "retreat_allies", 1000);
}

marines_precache() {
  precachemodel("veh8_mil_lnd_asierra_tan_no_col");
  precachemodel("veh8_mil_lnd_stango");
  precachemodel("veh8_mil_lnd_stango_slats");
  precachemodel("veh8_mil_lnd_stango_turret");
  precachemodel("veh8_mil_lnd_bromeo_animated_dst");
  scripts\sp\equipment\tripwire::precachetrap("tripwire_trap_frag", "offhand_wm_grenade_mike67", 1);
}

marines_starts() {
  scripts\engine\sp\utility::set_default_start("intro");
  var_0 = undefined;
  scripts\engine\sp\utility::add_start("intro", scripts\sp\maps\marines\marines_gameplay_convoy.gsc::intro_start, var_0, scripts\sp\maps\marines\marines_gameplay_convoy.gsc::intro_main, "11000_011101000000", scripts\sp\maps\marines\marines_gameplay_convoy.gsc::intro_catchup);
  scripts\engine\sp\utility::add_start("convoy_ambush", scripts\sp\maps\marines\marines_gameplay_convoy.gsc::convoy_ambush_start, var_0, scripts\sp\maps\marines\marines_gameplay_convoy.gsc::convoy_ambush_main, "11000_111100100000", scripts\sp\maps\marines\marines_gameplay_convoy.gsc::convoy_ambush_catchup);
  scripts\engine\sp\utility::add_start("murderhole", scripts\sp\maps\marines\marines_gameplay_streets.gsc::murderhole_start, var_0, scripts\sp\maps\marines\marines_gameplay_streets.gsc::murderhole_main, "11000_111110100000", scripts\sp\maps\marines\marines_gameplay_streets.gsc::murderhole_catchup);
  scripts\engine\sp\utility::add_start("alley", scripts\sp\maps\marines\marines_gameplay_streets.gsc::alley_start, var_0, scripts\sp\maps\marines\marines_gameplay_streets.gsc::alley_main, "11000_111110100000", scripts\sp\maps\marines\marines_gameplay_streets.gsc::alley_catchup);
  scripts\engine\sp\utility::add_start("murderhole_breach", scripts\sp\maps\marines\marines_gameplay_streets.gsc::murderhole_breach_start, var_0, scripts\sp\maps\marines\marines_gameplay_streets.gsc::murderhole_breach_main, "11110_111110100000", scripts\sp\maps\marines\marines_gameplay_streets.gsc::murderhole_breach_catchup);
  scripts\engine\sp\utility::add_start("retreat", scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::retreat_start, var_0, scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::retreat_main, "11110_111111011000", scripts\sp\maps\marines\marines_gameplay_parkinglot.gsc::retreat_catchup);
  scripts\engine\sp\utility::add_start("lobby", scripts\sp\maps\marines\marines_gameplay_hospital.gsc::lobby_start, var_0, scripts\sp\maps\marines\marines_gameplay_hospital.gsc::lobby_main, "11110_101111011000", scripts\sp\maps\marines\marines_gameplay_hospital.gsc::lobby_catchup);
  scripts\engine\sp\utility::add_start("groundfloor", scripts\sp\maps\marines\marines_gameplay_hospital.gsc::groundfloor_start, var_0, scripts\sp\maps\marines\marines_gameplay_hospital.gsc::groundfloor_main, "11110_101111011000", scripts\sp\maps\marines\marines_gameplay_hospital.gsc::groundfloor_catchup);
  scripts\engine\sp\utility::add_start("civ_ambush", scripts\sp\maps\marines\marines_gameplay_civ_ambush.gsc::civ_ambush_start, var_0, scripts\sp\maps\marines\marines_gameplay_civ_ambush.gsc::civ_ambush_main, "01110_000001011110", scripts\sp\maps\marines\marines_gameplay_civ_ambush.gsc::civ_ambush_catchup);
  scripts\engine\sp\utility::add_start("mg_hall", scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::mg_hall_start, var_0, scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::mg_hall_main, "01110_000001011111", scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::mg_hall_catchup);
  scripts\engine\sp\utility::add_start("snakecam", scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::snakecam_start, var_0, scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::snakecam_main, "01111_000001000011", scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::snakecam_catchup);
  scripts\engine\sp\utility::add_start("wolf", scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::wolf_start, var_0, scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::wolf_main, "00011_000001000001", scripts\sp\maps\marines\marines_gameplay_hospital_upper.gsc::wolf_catchup);
}

marines_transients() {
  scripts\engine\sp\utility::transient_init("marines_streets_script_tr");
  scripts\engine\sp\utility::transient_init("marines_streets_hospital_shared_script_tr");
  scripts\engine\sp\utility::transient_init("marines_hospital_script_tr");
  scripts\engine\sp\utility::transient_init("marines_hospital_wolf_shared_script_tr");
  scripts\engine\sp\utility::transient_init("marines_wolf_script_tr");
  scripts\engine\sp\utility::transient_init("marines_introhack_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_convoy_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_streets_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_ridge_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_parkinglot_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_hospital_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_hospital_fake_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_lobby_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_groundfloor_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_stairwell_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_civambush_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_mghall_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_pediatrics_geo_tr");
  scripts\engine\sp\utility::transient_init("marines_wolf_geo_tr");
}

marines_player_setup() {
  setplayerviewmodel("viewmodel_arms_alex_desert", undefined, "default_character_shadow");
  scripts\sp\utility::context_melee_set_arms("viewmodel_arms_alex_desert");
  var_0 = ["frag", "smoke_tall"];
  scripts\engine\sp\utility::offhandprecache(var_0);
  level.primaryweapon = scripts\sp\utility::make_weapon("iw8_ar_mike4", ["hybrid_west02", "ub_mike203_sp"]);
  var_1 = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
  var_1 = var_1 withoutattachment("slide_mike1911");
  var_1 = var_1 withattachment("slide_tritium_mike1911");
  level.secondaryweapon = var_1;
  level.player giveweapon(level.secondaryweapon);
  level.player giveweapon(level.primaryweapon, 0, 0, 0, 1);
  level.player switchtoweaponimmediate(level.primaryweapon);
  level.player scripts\engine\sp\utility::give_offhand("frag");
  level.player givemaxammo("frag");
  level.player scripts\engine\sp\utility::give_offhand("smoke_tall", 4);
  thread give_player_max_ammo();
  scripts\sp\maps\marines\marines_background.gsc::init_bg_tracer_fx();
  level.smoke_fx = loadfx("vfx/iw8/level/marines/vfx_smoke_gren_marines.vfx");
  setup_player_rig();
}

setplayerviewmodel(var_0, var_1, var_2) {
  if(isDefined(var_0))
    level.player setviewmodel(var_0);

  if(isDefined(var_1)) {}

  if(isDefined(var_2))
    level.player setshadowmodel(var_2);
}

marines_objectives() {
  level.player endon("death");
  var_0 = getEnt("objective_marker_retreat_stackup", "targetname");
  var_1 = getEnt("objective_marker_hospital_entrance", "targetname");
  var_2 = getEnt("objective_hospital_lobby_breach_marker", "targetname");
  var_3 = getEnt("objective_hospital_snakecam_marker", "targetname");
  var_4 = getEnt("objective_hospital_wolf_flank_1", "targetname");

  if(!scripts\sp\starts::is_after_start("convoy_ambush")) {
    if(!scripts\engine\sp\objectives::objective_exists("objective_convoy_start")) {
      scripts\engine\utility::flag_wait("intro_cinematic_complete");
      scripts\engine\sp\objectives::objective_add("objective_convoy_start", "current", undefined, &"MARINES/OBJ_REACH_HOSPITAL");
      scripts\engine\utility::flag_wait("play_IED_explosion");
      scripts\engine\utility::exploder("ied_impact_wave");
      wait 0.5;
      scripts\engine\utility::exploder("ied_linger");
      wait 2.0;
      scripts\engine\sp\objectives::objective_remove("objective_convoy_start");
    }
  }

  if(!scripts\sp\starts::is_after_start("murderhole")) {
    scripts\engine\sp\objectives::objective_add("objective_convoy_start_ied", "current", undefined, &"MARINES/OBJ_REACH_HOSPITAL");
    wait 1.0;
    scripts\engine\sp\objectives::objective_remove("objective_convoy_start_ied");
    var_5 = getEnt("objective_marker_humvee", "targetname");
    scripts\engine\sp\objectives::objective_add("objective_humvee", "current", var_5.origin, &"MARINES/OBJ_HELP_MARINE");
    scripts\engine\utility::flag_wait_any("murderhole_spawn", "marine_01_reached_IED", "marine_02_reached_IED", "marine_03_reached_IED", "griggs_at_mg_cover_node");
    wait 5;
    scripts\engine\sp\objectives::objective_remove("objective_humvee");
    var_6 = getEnt("objective_marker_alley", "targetname");
    scripts\engine\sp\objectives::objective_add("objective_alley", "current", var_6.origin, &"MARINES/OBJ_REACH_MG");
    scripts\engine\utility::flag_wait("objective_marker_switch");
    scripts\engine\sp\objectives::objective_remove("objective_alley");
  }

  if(!scripts\sp\starts::is_after_start("alley")) {
    var_7 = getEnt("objective_marker_general_MH", "targetname");
    var_8 = getEnt("objective_marker_MH_right", "targetname");

    if(!scripts\engine\sp\objectives::objective_exists("objective_alley"))
      scripts\engine\sp\objectives::objective_add("objective_alley", "current", var_7.origin, &"MARINES/OBJ_REACH_MG", undefined);
    else
      scripts\engine\sp\objectives::objective_update("objective_alley", "current", var_7.origin, &"MARINES/OBJ_REACH_MG", undefined);

    scripts\engine\utility::flag_wait("ready_to_cross_street");
    scripts\engine\sp\objectives::objective_update("objective_alley", "current", var_8.origin, &"MARINES/OBJ_REACH_MG");
    scripts\engine\utility::flag_wait("murderhole_breach_save_point");
    scripts\engine\sp\objectives::objective_remove("objective_alley");
  }

  if(!scripts\sp\starts::is_after_start("murderhole_breach")) {
    scripts\engine\sp\objectives::objective_add("objective_reach_3rd", "current", undefined, &"MARINES/OBJ_TAKE_OUT_MG");
    scripts\engine\utility::flag_wait("mg_guys_dead");
    wait 1.0;
    scripts\engine\sp\objectives::objective_remove("objective_reach_3rd");
  }

  if(!scripts\sp\starts::is_after_start("retreat")) {
    scripts\engine\sp\objectives::objective_add("objective_retreat_stackup", "current", var_0.origin, &"MARINES/OBJ_REGROUP_GRIGGS");
    scripts\engine\utility::flag_wait("flag_retreat_exiting_mg_house");
    scripts\engine\sp\objectives::objective_set_on_entity("objective_retreat_stackup", "griggs", level.griggs);
    scripts\engine\utility::flag_wait("flag_retreat_smash_gate_tank_hitting_gate");
    scripts\engine\utility::flag_wait_or_timeout("flag_retreat_bombardment_start", 4.0);
    scripts\engine\sp\objectives::objective_remove("objective_retreat_stackup");
    scripts\engine\sp\objectives::objective_add("objective_retreat_bombardment", "current", undefined, &"MARINES/OBJ_HOLD_POSITION");
    scripts\engine\utility::flag_wait("flag_retreat_bombardment_complete");
    scripts\engine\sp\objectives::objective_remove("objective_retreat_bombardment");
    scripts\engine\sp\objectives::objective_add("objective_retreat_hospital_enter", "current", var_1.origin, &"MARINES/OBJ_ADVANCE_HOSPITAL");
    scripts\engine\utility::flag_wait("flag_set_push_hospital_objective");
    scripts\engine\sp\objectives::objective_remove("objective_retreat_hospital_enter");
    scripts\engine\sp\objectives::objective_add("objective_hospital_lobby_breach", "current", var_2.origin, &"MARINES/OBJ_ENTER_HOSPITAL");
    scripts\engine\utility::flag_wait("flag_lobby_entered");
    scripts\engine\sp\objectives::objective_remove("objective_hospital_lobby_breach");
  }

  if(!scripts\sp\starts::is_after_start("lobby")) {
    scripts\engine\sp\objectives::objective_add("objective_hospital_lobby_secure", "current", undefined, &"MARINES/OBJ_SECURE_LOBBY");
    scripts\engine\utility::flag_wait("flag_lobby_secured");
    scripts\engine\sp\objectives::objective_complete("objective_hospital_lobby_secure");
  }

  if(!scripts\sp\starts::is_after_start("groundfloor")) {
    scripts\engine\sp\objectives::objective_add("objective_hospital_reach_upperfloor", "current", undefined, &"MARINES/OBJ_REACH_3RD_FLOOR");
    scripts\engine\utility::flag_wait("flag_stairwell_reached");
    scripts\engine\sp\objectives::objective_complete("objective_hospital_reach_upperfloor");
  }

  if(!scripts\sp\starts::is_after_start("civ_ambush"))
    scripts\engine\sp\objectives::objective_add("objective_hospital_reach_pediatrics", "current", undefined, &"MARINES/OBJ_REACH_PEDIATRICS", undefined);

  if(!scripts\sp\starts::is_after_start("mg_hall")) {
    if(!scripts\engine\sp\objectives::objective_exists("objective_hospital_reach_pediatrics"))
      scripts\engine\sp\objectives::objective_add("objective_hospital_reach_pediatrics", "current", undefined, &"MARINES/OBJ_REACH_PEDIATRICS", undefined);

    scripts\engine\utility::flag_wait("flag_upperfloor_pediatrics_reached");
    scripts\engine\sp\objectives::objective_remove("objective_hospital_reach_pediatrics");
  }

  if(!scripts\sp\starts::is_after_start("snakecam")) {
    if(!scripts\engine\sp\objectives::objective_exists("objective_snakecam_locate_wolf"))
      scripts\engine\sp\objectives::objective_add("objective_snakecam_locate_wolf", "current", undefined, &"MARINES/OBJ_CAPTURE_WOLF", undefined);

    scripts\engine\utility::flag_wait("snakecam_enable_flag");
    scripts\engine\sp\objectives::objective_complete("objective_snakecam_locate_wolf");
    scripts\engine\sp\objectives::objective_add("objective_hospital_snakecam_1", "current", var_3.origin, &"MARINES/OBJ_SNAKECAM_DOOR");
    scripts\engine\utility::flag_wait("flag_wolf_snakecam_starting");
    scripts\engine\sp\objectives::objective_remove("objective_hospital_snakecam_1");
    scripts\engine\sp\objectives::objective_add("objective_hospital_snakecam_2", "current", undefined, &"MARINES/OBJ_SNAKECAM_DOOR");
    wait 3;
    scripts\engine\sp\objectives::objective_complete("objective_hospital_snakecam_2");

    if(!scripts\engine\utility::flag("flag_wolf_snakecam_complete")) {
      scripts\engine\sp\objectives::objective_add("objective_hospital_wolf_get_to_1", "current", level.proxy_wolf getEye() + (0, 0, 20), &"MARINES/OBJ_REACH_WOLF");
      objective_hospital_snakecam_wolf_marker_manager();
      scripts\engine\sp\objectives::objective_remove("objective_hospital_wolf_get_to_1");
    }

    scripts\engine\sp\objectives::objective_add("objective_hospital_wolf_get_to_2", "current", undefined, &"MARINES/OBJ_REACH_WOLF");
  }

  if(!scripts\sp\starts::is_after_start("wolf")) {
    if(!scripts\engine\sp\objectives::objective_exists("objective_hospital_wolf_get_to_2"))
      scripts\engine\sp\objectives::objective_add("objective_hospital_wolf_get_to_2", "current", undefined, &"MARINES/OBJ_REACH_WOLF");

    scripts\engine\utility::flag_wait("flag_wolf_cleanup_snakecam_marine");
    wait 6;
    scripts\engine\sp\objectives::objective_remove("objective_hospital_wolf_get_to_2");
    scripts\engine\sp\objectives::objective_add("objective_hospital_wolf_get_to_3", "current", getEnt("objective_hospital_wolf_flank_1", "targetname").origin, &"MARINES/OBJ_REACH_WOLF");
    scripts\engine\utility::flag_wait("flag_wolf_roof_advance");
    scripts\engine\sp\objectives::objective_remove("objective_hospital_wolf_get_to_3");
    scripts\engine\sp\objectives::objective_add("objective_hospital_wolf_get_to_4", "current", undefined, &"MARINES/OBJ_REACH_WOLF");
    scripts\engine\utility::flag_wait("flag_wolf_tripwire_cleared");
    scripts\engine\sp\objectives::objective_remove("objective_hospital_wolf_get_to_4");
    scripts\engine\sp\objectives::objective_add("objective_hospital_wolf_secure", "current", undefined, &"MARINES/OBJ_GRAB_WOLF", &"MARINES/OBJ_ICON_NAME_WOLF");
    thread scripts\sp\maps\marines\marines_utility.gsc::objective_wolf_los("objective_hospital_wolf_secure", "wolf_los_fallback_struct", "wolf_takedown_volume", 1);
    scripts\engine\utility::flag_wait("flag_wolf_player_hit_ground");
    wait 2;
    level notify("objective_wolf_los_end");
    scripts\engine\sp\objectives::objective_complete("objective_hospital_wolf_secure");
  }
}

give_player_max_ammo() {
  waitframe();
  level.player givemaxammo(level.player getweaponslistprimaries()[0]);
  level.player givemaxammo(level.player getweaponslistprimaries()[1]);
}

setup_player_rig() {
  level.player.rig = scripts\engine\sp\utility::spawn_anim_model("player_rig", (0, 0, 0), level.player.angles);
  level.player.rig hide();
  level.player.rig dontcastshadows();
}

objective_hospital_snakecam_wolf_marker_manager() {
  level endon("flag_wolf_snakecam_complete");

  while(isDefined(level.proxy_wolf)) {
    scripts\engine\sp\objectives::objective_set_position("objective_hospital_wolf_get_to_1", level.proxy_wolf getEye() + (0, 0, 20));
    waitframe();
  }
}

exterior_aq_face_enemy_dist_override(var_0, var_1, var_2) {
  if(isDefined(self.spawner.script_parameters)) {
    if(self.spawner.script_parameters == var_0 || self.spawner.script_parameters == var_1 || self.spawner.script_parameters == var_2) {
      self.maxfaceenemydist = 0;
      self.maxfacenewenemydist = 0;
    }
  }
}