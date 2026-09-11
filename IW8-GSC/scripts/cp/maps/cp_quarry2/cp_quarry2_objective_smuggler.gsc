/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_quarry2\cp_quarry2_objective_smuggler.gsc
************************************************************************/

function main() {
  level.convoy4_objective_func = &register_convoy4_objectives;
  level.hackingfunc = &init_hacking_table;
  scripts\cp\cp_hacking::hacking_init();
  scripts\cp\cp_hostage::init_hostages();
  thread debug_loop_explosion();
  thread player_equipment_use_stop();
}

function init_hacking_table() {
  scripts\cp\cp_hacking::parsehackingtable("cp/cp_quarry_hacking_objective.csv");
}

function register_convoy4_objectives() {
  level endon("game_ended");
  var_0 = &scripts\cp\cp_objectives::registerobjective;
  [[var_0]]("convoy4_securearea", &obj_maj_secure_init, &obj_maj_secure_start, &obj_maj_secure_end, &debugbeatobjective, &debug_start_hostages);
  [[var_0]]("convoy4_disablecomms", &obj_maj_comms_init, &obj_maj_comms_start, &obj_maj_comms_end, &debugbeatobjective, &debug_start_switches);
  [[var_0]]("convoy4_secure_tower", &obj_maj_secure_tower_init, &obj_maj_secure_tower_start, &obj_maj_secure_tower_end, &debugbeatobjective, &debug_start_terminal);
  [[var_0]]("convoy4_find_keys", &obj_maj_find_keys_init, &obj_maj_find_keys_start, &obj_maj_find_keys_end, &debugbeatobjective, &debug_start_keys);
  [[var_0]]("convoy4_call_train", &obj_maj_call_train_init, &obj_maj_call_train_start, &obj_maj_call_train_end, &debugbeatobjective, &debug_start_call);
  [[var_0]]("convoy4_take_apache", &obj_maj_take_apache_init, &obj_maj_take_apache_start, undefined, &debugbeatobjective);
  [[var_0]]("convoy4_wait_train", &obj_maj_wait_train_init, &obj_maj_wait_train_start, undefined, &debugbeatobjective, &debug_start_waittrain);
  [[var_0]]("convoy4_open_train", &obj_maj_open_train_init, &obj_maj_open_train_start, undefined, &debugbeatobjective);
  [[var_0]]("convoy4_extraction", &obj_maj_extraction_init, &obj_maj_extraction_start, undefined, &debugbeatobjective, &debug_start_extraction);
  thread register_spawn_functions();
}

function register_interactions() {
  thread smuggler_interactions_threaded();
}

function smuggler_interactions_threaded() {
  if(!scripts\engine\utility::flag_exist("cp_quarry2_convoy4_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_quarry2_convoy4_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_quarry2_convoy4_create_script_completed");
  wait 0.25;
  thread ref_131e3();
  thread scripts\cp\cp_destruction::destructible_interactions();
  scripts\cp\cp_interaction::registerinteraction("comms_laptop_interaction_a", &hintcommslaptop, &activationcommslaptop, &initcommslaptop, 0, "duration_long");
  scripts\cp\cp_interaction::registerinteraction("comms_laptop_interaction_b", &hintcommslaptop, &activationcommslaptop, &initcommslaptop, 0, "duration_long");
  scripts\cp\cp_interaction::registerinteraction("comms_laptop_interaction_c", &hintcommslaptop, &activationcommslaptop, &initcommslaptop, 0, "duration_long");
  scripts\cp\cp_interaction::registerinteraction("obj_convoy4_call_train", &hintcalltraininteract, &activationcalltraininteract, &initcalltraininteract, 0, "duration_medium", 1);
  scripts\cp\coop_personal_ents::registerpentparams("obj_convoy4_call_train", "HINT_BUTTON", undefined, &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_USE_0", undefined, "duration_medium", "hide", 270, 65, 140, 65);
  thread spawn_objective_loot();
  waitframe();
  scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("comms_laptop_interaction_a");
  scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("comms_laptop_interaction_b");
  scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("comms_laptop_interaction_c");
  scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("destructible_door_double");
  scripts\cp\cp_interaction::removefrominteractionslistbynoteworthy("obj_convoy4_call_train");
}

function ref_131e3() {
  ref_131e6("obj_support_crate_a");
  ref_131e4();
  ref_131e5();
  ref_131e6("obj_support_crate_c");
}

function ref_131e6(var_0) {
  if(isDefined(level.hideintelscriptablesfromplayer) && isDefined(scripts\engine\utility::array_find(level.hideintelscriptablesfromplayer, var_0))) {
    return;
  }

  var_1 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");
  var_2 = spawn("script_model", var_1.origin);
  var_2.angles = var_1.angles;
  var_2 setModel("military_hq_crate_01_proxy_cp_spawnable");

  if(isDefined(var_1.targetname)) {
    var_2.targetname = var_1.targetname;
  }

  if(!isDefined(level.hideintelscriptablesfromplayer)) {
    level.hideintelscriptablesfromplayer = [];
  }

  level.hideintelscriptablesfromplayer[level.hideintelscriptablesfromplayer.size] = var_0;
}

function ref_131e4() {
  level.ref_11f54 = scripts\engine\utility::getStructArray("obj_a_goal", "targetname");

  foreach(var_1 in level.ref_11f54) {
    var_1.ref_127ea = [];

    if(!isDefined(var_1.radius)) {
      var_1.radius = 500;
    }
  }

  level.ref_11f53 = scripts\cp\cp_create_script_utility::ref_13529("obj_a_cover");
}

function ref_131e5() {
  level waittill("started_hack_at_b");
  scripts\cp\cp_create_script_utility::land_usability_disabled("obj_a_cover");
  wait 1;
}

function spawn_objective_loot() {
  var_0 = getEntArray("smuggler_loot", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "armor") {
      var_2 thread scripts\cp\utility::create_fake_loot(["brloot_munition_armor"]);
      continue;
    }

    var_2 thread scripts\cp\utility::create_fake_loot(["brloot_munition_ammo"]);
  }
}

function ref_1321c() {
  var_0 = scripts\engine\utility::getStructArray("no_wave_spawn", "targetname");

  foreach(var_2 in var_0) {
    scripts\cp\cp_spawning_util::balloon_deposit(var_2.origin, var_2.radius);
  }
}

function obj_maj_secure_init(var_0) {
  level.global_stealth_broken = 0;
  thread ref_124d2();
  thread ref_11f50();
  thread ref_131f0();
}

function obj_maj_secure_start(var_0) {
  thread smuggler_door_lock();
  level thread scripts\cp\maps\cp_suburbs11\cp_suburbs11_safehouse::ref_137f7();
  ref_1321c();
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  scripts\engine\utility::flag_wait("quarry_intro_vo_finished");
  var_1 = scripts\engine\utility::getStruct("convoy4_advancequarry", "targetname");
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_sethot(var_0.objectiveindex, 0);
  objective_position(var_0.objectiveindex, var_1.origin);
  objective_setlabel(var_0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_SECURE_WORLD");
  level.ref_12d89 = scripts\cp\cp_create_script_utility::ref_13529("roof_rpg_cover");
  level.ref_11f56 = scripts\cp\cp_modular_spawning::run_spawn_module("obj_a_roof_jugg");
  level.iconovertime = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_roof_jugg");
  level.icon_trigger_enter = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_snipers_1");
  level.icon_trigger_exit = scripts\cp\cp_modular_spawning::run_spawn_module("mortar_guys");
  thread ref_13dbd(level, "quarry_right", "quarry_right_spawn_trig", "start_hacking_comms_laptop", undefined);
  thread ref_13dbd(level, "quarry_left", "quarry_left_spawn_trig", "start_hacking_comms_laptop", undefined);
  thread ref_13dbd(level, "quarry_fight_across", "quarry_fight_across_spawn_trig", "started_hack_at_a", undefined);
  thread setup_enemy_sentries(level);
  thread ref_12115();
  var_2 = 163840000;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2)) {
    wait 0.1;
  }

  level scripts\engine\utility::delaythread(3, &nextstar);
  level scripts\engine\utility::delaythread(randomintrange(60, 90), &nextstar);
  thread ref_1295d();
  scripts\engine\utility::delaythread(5, &ref_14408);
  level.ref_12959 = scripts\cp\cp_modular_spawning::run_spawn_module("quarry_intro1_chopper");
  wait 1.5;
  level.ref_1295a = scripts\cp\cp_modular_spawning::run_spawn_module("quarry_intro2_chopper");
  var_2 = 81000000;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2)) {
    wait 0.1;
  }

  level.icontrigger = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_roof_rpgs");
  var_3 = ["dx_cps_lass_callout_helicopter_attacking_10", "dx_cps_lass_callout_helicopter_attacking_20"];
  thread play_vo_delay(level);
  var_2 = 60840000;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2)) {
    wait 0.1;
  }

  level thread scripts\cp\cp_wave_spawning::killstreaks(0.1, "smugg_p3_intro_no_heli");
  var_2 = 30250000;
  var_4 = 1;

  while(var_4 > 0) {
    wait 0.5;

    if(scripts\cp\utility::any_player_nearby(var_1.origin, var_2)) {
      var_4 -= 0.5;
    }
  }

  level notify("stop_mortars");
  play_vo_delay(level, "dx_cps_lass_quarry2_array_spotted_10");
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(undefined, "ping_response_copy");
  wait 1;
  var_1 = scripts\engine\utility::getStruct("objective_convoy4_02_a", "targetname");
  var_5 = scripts\engine\utility::getStruct("convoy4_investigate", "targetname");
  var_6 = 2600;
  var_7 = var_6 * var_6;

  for(;;) {
    wait 0.5;
  }

  LOC_000002e5:
    var_8 = ["dx_cps_lass_callout_enemy_squad_spawning_10", "dx_cps_lass_callout_enemy_squad_spawning_20", "dx_cps_lass_callout_enemy_squad_spawning_30"];
  thread play_vo_delay(level);
  var_6 = 1400;
  var_7 = var_6 * var_6;
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var_0.objectiveindex, var_5.origin + (0, 0, 20));
  objective_setlabel(var_0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/INVESTIGATE_WORLD");
  thread scripts\cp\utility::objective_update("convoy4_investigate", undefined, undefined, undefined, 1);

  for(;;) {
    wait 0.5;
  }

  LOC_0000037f:
    scripts\cp\cp_objectives::lua_objective_complete("convoy4_investigate");
  thread scripts\cp\utility::objective_update("convoy4_restricttrain", undefined, undefined, undefined, 1);
}

function ref_12115() {
  var_0 = scripts\engine\utility::getStructArray("open_this_door", "targetname");

  foreach(var_2 in var_0) {
    thread ref_1211b(var_2);
  }
}

function ref_1211b(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.radius;
  var_3 = [];
  var_4 = getentitylessscriptablearrayinradius(undefined, undefined, var_1, var_2);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    if(var_4[var_5] scriptableisdoor()) {
      var_3 = var_4[var_5];
    }
  }

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_3[var_6] setscriptablepartstate("door", "left_90", 0);
  }
}

function ref_13dbd(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");

  if(isDefined(var_2)) {
    level endon(var_2);
  }

  if(isDefined(var_3)) {
    level endon(var_3);
  }

  if(isDefined(var_4)) {
    level endon(var_4);
  }

  var_5 = scripts\engine\utility::getStruct(var_1, "targetname");

  if(isDefined(var_5.target)) {
    GscBinSkip4(0x35, var_0, var_5);
  }

  var_6 = var_5.origin;
  var_7 = var_5.radius;
  var_8 = var_7 * var_7;

  for(;;) {
    wait 0.25;

    if(scripts\cp\utility::any_player_nearby(var_6, var_8)) {
      break;
    }
  }

  level notify(var_0 + "_spawned");

  if(!isDefined(level.ref_13dbc)) {
    level.ref_13dbc = [];
  }

  level.ref_13dbc[var_0] = scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
}

function ref_13dbe(var_0, var_1) {
  level endon(var_0 + "_spawned");
  var_2 = var_1.origin;
  var_3 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_4 = var_3.origin;
  var_5 = var_3.radius;
  var_6 = var_5 * var_5;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_4, var_6)) {
      break;
    }

    wait 0.25;
  }

  level notify(var_0 + "_cancel");
}

function ref_1295f(var_0) {
  var_1 = scripts\engine\utility::getStruct("quarry_intro_wave_spawn_poi", "targetname");
  var_2 = var_1.radius;
  var_3 = var_1.origin;
  thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_3, var_2, 10000);
  var_4 = 20250000;

  while(!scripts\cp\utility::any_player_nearby(var_0.origin, var_4)) {
    wait 0.25;
  }

  thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_3);
  var_1 = scripts\engine\utility::getStruct("quarry_inside_wave_spawn_poi", "targetname");
  var_2 = var_1.radius;
  var_3 = var_1.origin;
  thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_3, var_2, 10000);
  var_4 = 6760000;

  while(!scripts\cp\utility::any_player_nearby(var_0.origin, var_4)) {
    wait 0.25;
  }

  thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_3);
}

function ref_14408() {
  level.global_stealth_broken = 1;
  level notify("weapons_free");
  var_0 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(var_2 in var_0) {
    var_2 thread scripts\cp\cp_modular_spawning::enter_combat();
  }
}

function ref_1295d() {
  level.get_mortar_impact_pos = &get_mortar_impact_spot;
  level.ref_1295d = getEntArray("quarry_mortar", "targetname");
  var_0 = scripts\engine\utility::getStruct("quarry_approach", "targetname");

  foreach(var_2 in level.ref_1295d) {
    var_2 hidepart("j_mortar_shell", "misc_wm_mortar");
    thread mortar_think(var_2);
  }

  level waittill("flare_launched");
  level scripts\engine\utility::delaythread(0.25, &scripts\cp\cp_vo::try_to_play_vo_on_team, "dx_cps_kama_callout_mortar_attacking_20", "allies");
  wait 8;
  level waittill("flare_launched");
  level scripts\engine\utility::delaythread(0.25, &scripts\cp\cp_vo::try_to_play_vo_on_team, "dx_cps_kama_callout_mortar_attacking_10", "allies");
}

function mortar_think(var_0) {
  level endon("game_ended");
  level endon("started_hack_at_a");
  level endon("stop_mortars");
  self endon("death");
  var_1 = 4;
  var_2 = 7;
  self.targets = undefined;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, 1000000)) {
      return;
    }

    var_3 = get_players_in_area(var_0.origin, var_0.radius);

    if(var_3.size) {
      self.targets = var_3;
      scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_mortar(self, 1, 1000);
      self.targets = undefined;
      wait randomintrange(var_1, var_2);
      continue;
    }

    wait 1;
  }
}

function get_players_in_area(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!var_4 scripts\cp\utility::is_valid_player() || !var_4 isonground()) {
      continue;
    }

    if(scripts\engine\utility::distance_2d_squared(var_4.origin, var_0) < var_1 * var_1) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function get_mortar_impact_spot(var_0) {
  if(!isDefined(var_0.targets)) {
    return undefined;
  }

  var_1 = scripts\engine\utility::random(var_0.targets);
  var_2 = var_1.origin + (randomintrange(-300, 300), randomintrange(-300, 300), 0);
  var_3 = scripts\engine\trace::ray_trace(var_2 + (0, 0, 500), var_2);
  return var_3["position"];
}

function nextstar() {
  level.ref_1359d = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_p3_form_a");
  level.ref_1359e = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_p3_form_b");
  level.ref_1359f = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_p3_form_c");
  wait randomintrange(4, 8);
  level.ref_135a0 = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_p3_form_d");
}

function obj_maj_secure_end(var_0) {}

#using_animtree("");

function ref_13779() {
  var_0 = scripts\engine\utility::getStruct("quarry_train", "targetname");
  level.scr_animtree["quarry_train_anim"] = #animtree;
  level.scr_anim["quarry_train_anim"]["approach"] = $cp_scripted_train_arrival;
  level.scr_animname["quarry_train_anim"]["approach"] = "cp_scripted_train_arrival";
  waitframe();
  level.ref_1295e = getEnt("smuggler_train", "targetname");
  level.ref_1295e.animname = "quarry_train_anim";
  level.ref_1295e useanimtree(level.scr_animtree[level.ref_1295e.animname]);
  var_1 = getEnt("train1_clip", "targetname");
  var_2 = getstartorigin(var_0.origin, var_0.angles, level.scr_anim["quarry_train_anim"]["approach"]);
  var_3 = getstartangles(var_0.origin, var_0.angles, level.scr_anim["quarry_train_anim"]["approach"]);
  level waittill("start_anim_train");
  level.ref_1295e dontinterpolate();
  level.ref_1295e.origin = var_2;
  level.ref_1295e.angles = var_3;
  var_1 dontinterpolate();
  var_1.origin = var_2;
  var_1.angles = var_3;
  var_1 linkTo(level.ref_1295e, "tag_origin", (0, -6, 84), (0, 0, 0));
  level.ref_1295e.clipmodel = var_1;
  level.ref_1295e setscriptablepartstate("anim", "anim");
  thread damage_infront_of_train(level.ref_1295e, level.ref_1295e);
}

function obj_maj_comms_init(var_0) {
  level.convoy4_terminal_keys = 0;
  thread play_hack_alarms();
  thread play_hacks_interact_vo();
}

function obj_maj_comms_start(var_0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(24);
  scripts\cp\cp_objectives::lua_objective_incomplete("convoy4_restricttrain");
  setomnvar("cp_objective_sub_count_2", 0);
  thread setup_enemy_sentries(level);
  obj_comms_start(level, "disable_comms_laptop", "a", var_0);
  setomnvar("cp_objective_sub_count_2", 1);
  scripts\cp\cp_objectives::screenent_c("minor_objective");
  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("quarry_1", ["deployable_cover", "precision_airstrike"]);
  thread setup_enemy_sentries(level);
  wait 1.1;
  obj_comms_start(level, "disable_comms_laptop", "b", var_0);
  setomnvar("cp_objective_sub_count_2", 2);
  scripts\cp\cp_objectives::screenent_c("minor_objective");
  wait 1.1;
  obj_comms_start(level, "disable_comms_laptop", "c", var_0);
  setomnvar("cp_objective_sub_count_2", 3);
  scripts\cp\cp_objectives::screenent_c("minor_objective");
  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("quarry_2", ["juggernaut", "precision_airstrike", "cruise_missile"]);
  thread setup_enemy_sentries(level);
  wait 1.1;
}

function waittill_all_valid_ai_are_gone(var_0) {
  thread waittill_any_2(var_0);
}

function waittill_any_2(var_0) {
  wait 1;
  self notify("basic_combat");

  if(isDefined(self.aitype) && self.aitype == "ar_heavy_laser") {
    var_1 = [];

    foreach(var_3 in level.players) {
      if(!var_3 scripts\cp\utility::is_valid_player() || !var_3 isonground()) {
        continue;
      }

      self getenemyinfo(var_3);
      var_1 = var_3;
    }

    if(isDefined(var_1) && var_1.size > 0) {
      var_5 = scripts\engine\utility::getStruct("objective_convoy4_02_c", "targetname");
      var_1 = sortbydistance(var_1, var_5.origin);

      if(isDefined(var_1[0])) {
        scripts\cp\cp_modular_spawning::set_goal_pos(var_1[0].origin);
      }
    }

    thread scripts\cp\cp_modular_spawning::enter_combat();
    wait 0.5;
    scripts\cp\cp_modular_spawning::set_goal_radius(500);
    return;
  }
}

function obj_maj_comms_end(var_0) {
  scripts\cp\cp_objectives::lua_objective_complete("convoy4_restricttrain");
}

function obj_maj_secure_tower_init(var_0) {
  level notify("stop_auto_smokes");
  thread spawn_soldiers_attack_tower();
  level notify("obj_alarm_trigger");
}

function obj_maj_secure_tower_start(var_0) {
  ref_131e6("obj_support_crate_c");
  thread ref_131f1();
  scripts\mp\brclientmatchdata::getprophealth("convoy4_secure_tower");
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(25);
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(3, "jugg_spawn");
  level.obj_reserved_juggs = 1;
  var_1 = scripts\engine\utility::getStruct("objective_convoy4_04_a", "targetname");
  objective_setlocation(var_0.objectiveindex, 0, var_1.origin);
  level thread scripts\cp\cp_objectives::ref_1317e(var_0, var_1.origin);
  scripts\cp\cp_objectives::ref_11f80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  level thread scripts\cp\cp_wave_spawning::killstreaks(1, "smugg_p3_intro");
  thread ref_12dd5(level);
  var_2 = 220;
  var_3 = var_2 * var_2;

  for(;;) {
    wait 0.25;
  }
}

function obj_maj_secure_tower_end(var_0) {}

function obj_maj_find_keys_init(var_0) {}

function wait_if_fail_calltrain(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("obj_called_train");
  thread remind_calltrain(level, var_0, var_1, var_2);
  level waittill("convoy4_call_train_failed");
  objective_state(var_0, "failed");
  level.convoy4_failed_calltrain = 1;
  wait 3;
  scripts\cp\cp_objectives::ref_12868("convoy4_call_train");
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function remind_calltrain(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("obj_called_train");
  level endon("convoy4_call_train_failed");
  thread remind_calltrain_sethot(level);
  wait var_1 - var_2;
  setomnvar("cp_countdown_color", 1);
  wait var_2 - var_3;
  setomnvar("cp_countdown_color", 2);
  wait var_3;
  level notify("convoy4_call_train_failed");
}

function remind_calltrain_sethot(var_0) {
  level endon("game_ended");
  level endon("obj_called_train");
  level endon("convoy4_call_train_failed");
  wait 300;

  for(;;) {
    wait 1;
    objective_sethot(var_0, 1);
    wait 1;
    objective_sethot(var_0, 0);
  }
}

function obj_maj_find_keys_start(var_0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(25);
  level thread scripts\cp\cp_wave_spawning::killstreaks(5, "smugg_p3_tower");
  var_1 = scripts\engine\utility::getStruct("objective_convoy4_04_a", "targetname");
  objective_setlocation(var_0.objectiveindex, 0, var_1.origin);
  objective_icon(var_0.objectiveindex, "icon_waypoint_locked");
  objective_setdescription(var_0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_DISABLE_ARMS_0");
  thread delay_objective_update(level, "convoy4_keys_0");
  thread spawn_soldiers_juggs();
  thread play_keys_intro_vo();
  thread start_smoke_in_attic();
  thread setup_enemy_sentries(level);

  if(!isDefined(level.convoy4_terminal_keys)) {
    level.convoy4_terminal_keys = 0;
  }

  thread scripts\cp\utility::objective_update("convoy4_call_train", 360, 180, 60, 0, undefined);
  thread wait_if_fail_calltrain(var_0.objectiveindex, 360, 180, 60);
  wait 1;
  var_2 = 0;

  while(!isDefined(level.convoy4_module_juggs_1) || !isDefined(level.convoy4_module_juggs_1.ai_spawned)) {
    wait 0.05;
    var_2 += 0.05;
  }

  LOC_000000fd:
    thread ref_135cf(level, level.convoy4_module_juggs_1, "convoy4_juggs_1", "convoy4_04a_1");
  thread ref_135cf(level, level.convoy4_module_juggs_2, "convoy4_juggs_2", "convoy4_04a_2");
  thread ref_135cf(level, level.convoy4_module_juggs_3, "convoy4_juggs_3", "convoy4_04a_3");

  while(level.convoy4_terminal_keys < 3) {
    wait 0.2;
  }

  level notify("obj_collected_all_keys");
  wait 1.5;
  level notify("end_wave_convoy4_spawners");
}

function ref_135cf(var_0, var_1, var_2, var_3) {
  level endon("jugg_" + var_2 + "_stop");
  thread ref_13575(var_0, var_1, var_2, var_3);
  thread ref_13dd0(var_0, var_1, var_2, var_3);

  while(!isDefined(var_0) || var_0.ai_spawned.size == 0) {
    wait 0.05;
  }

  ref_13576(var_0, var_1, var_2);
}

function ref_13576(var_0, var_1, var_2) {
  if(istrue(var_0.patrolfunc)) {
    return;
  }

  if(isDefined(var_0.ai_spawned) && var_0.ai_spawned.size > 0) {
    var_3 = var_0.ai_spawned[0];
    thread spawn_key_objective(level, var_1, var_3);
    level notify("jugg_" + var_2 + "_stop");
    return;
  }
}

function ref_13575(var_0, var_1, var_2, var_3) {
  level endon("jugg_" + var_2 + "_stop");
  var_4 = 0;

  while(!isDefined(var_0) || var_0.ai_spawned.size == 0 && var_4 < 5) {
    wait 0.05;
    var_4 += 0.05;
  }

  if(var_0.ai_spawned.size > 0) {
    return;
  }

  thread scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_1);
  var_0 = scripts\cp\cp_modular_spawning::run_spawn_module(var_3);
  var_4 = 0;

  while(!isDefined(var_0) || var_0.ai_spawned.size == 0 && var_4 < 120) {
    wait 0.5;
    var_4 += 0.5;
  }

  if(var_0.ai_spawned.size == 0) {
    level notify("jugg_" + var_2 + "_failsafe");
    return;
  }

  ref_13576(var_0, var_1, var_2);
  level notify("jugg_" + var_2 + "_stop");
}

function ref_13dd0(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("jugg_" + var_2 + "_stop");
  level waittill("jugg_" + var_2 + "_failsafe");
  wait randomfloat(10);

  if(!isDefined(var_0) || var_0.ai_spawned.size == 0) {
    level.convoy4_terminal_keys += 1;
    var_0.patrolfunc = 1;
    thread ref_123d7();
    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_2);
    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_1);
    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_3);
    level notify("jugg_" + var_2 + "_stop");
    scripts\cp\utility::objective_update("convoy4_keys_" + level.convoy4_terminal_keys);
    return;
  }
}

function obj_maj_find_keys_end(var_0) {
  level notify("stop_attic_smoke");
}

function spawn_key_objective(var_0, var_1, var_2) {
  var_3 = scripts\cp\cp_objectives::requestworldid(var_0, 15);
  objective_setplayintro(var_3, 1);
  objective_setplayoutro(var_3, 1);
  objective_setownerteam(var_3, undefined);
  objective_setlabel(var_3, &"CP_QUARRY2_OBJECTIVES/CONVOY4_KEY_LOC");
  var_4 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_4 notsolid();
  var_4 show();
  var_4 linkTo(var_1, "tag_origin", (0, 0, 90), (0, 0, 0));
  var_1.jugg_obj_pos = var_4;
  objective_setlocation(var_3, 0, var_4);
  thread disable_jugg_objective_position_on_death(level, var_1, var_3, 0);
  thread jugg_hold(var_1);
  objective_state(var_3, "current");
  scripts\cp\cp_objectives::ref_11f80(var_3);
  objective_icon(var_3, "icon_waypoint_objective_general");
  objective_sethot(var_3, 0);
  objective_setbackground(var_3, 0);
  objective_showtoplayersinmask(var_3);
  objective_addalltomask(var_3);
  objective_setshowoncompass(var_3, 1);
}

function jugg_hold(var_0) {
  var_0 endon("death");
  var_0 endon("enter_combat");
  var_0 notify("watch_for_ai_events");
  var_0 notify("enter_combat_after_stealth");
  var_0.ignoreall = 1;
  var_0 scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
  thread watch_for_player_damage();
  jugg_hold_loop(var_0);
  var_0.ignoreall = 0;
  scripts\cp\cp_modular_spawning::remove_pacifist_from_guy();
  thread scripts\cp\cp_modular_spawning::enter_combat();
}

function watch_for_player_damage() {
  self endon("enter_combat");
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isPlayer(var_1)) {
      self notify("player_damage");
      return;
    }
  }
}

function jugg_hold_loop() {
  self endon("death");
  self endon("player_damage");
  self endon("enter_combat");
  var_0 = getdvarint("scr_jugg_hold_dist", 1000);
  var_1 = var_0 * var_0;

  for(;;) {
    if(!isDefined(self.maxhealth)) {
      return;
    }

    if(self.health < self.maxhealth - 10) {
      return;
    }

    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      if(distancesquared(level.players[var_2].origin, self.origin) < var_1) {
        return;
      }

      if(scripts\engine\utility::within_fov(self getEye(), self.angles, level.players[var_2].origin, cos(65))) {
        if(distancesquared(level.players[var_2].origin, self.origin) < var_1 && self cansee(level.players[var_2])) {
          return;
        }
      }
    }

    wait 0.5;
  }
}

function obj_maj_call_train_init(var_0) {
  level.obj_can_call_train = 1;
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_ovl_quarry2_keys_20");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_ovl_quarry2_keys_30");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_ovl_quarry2_keys_60");
}

function obj_maj_call_train_start(var_0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(16);

  if(isDefined(level.obj_reserved_juggs)) {
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(3, "jugg_spawn");
    level.obj_reserved_juggs = undefined;
  }

  level.obj_allow_call_train = 1;
  scripts\cp\cp_interaction::addtointeractionslistbynoteworthy("obj_convoy4_call_train");
  var_1 = scripts\engine\utility::getStruct("objective_convoy4_04_a", "targetname");
  objective_position(var_0.objectiveindex, var_1.origin);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlabel(var_0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_WORLD");
  scripts\cp\cp_objectives::ref_11f80(var_0.objectiveindex);
  level waittill("obj_called_train");

  if(istrue(level.convoy4_failed_calltrain)) {
    wait 99;
  }

  scripts\cp\utility::ref_123fe("mus_cp_smuggler_traincall");
  scripts\cp\cp_objectives::lua_objective_complete("convoy4_call_train");
  scripts\cp\cp_objectives::reset_objective_timers();
  scripts\cp\cp_objectives::screenent_c("major_objective");
  play_vo_delay(level, "dx_cps_lass_quarry2_keys_10", undefined, undefined, undefined, 0.4);
}

function obj_maj_call_train_end(var_0) {}

function obj_maj_take_apache_init(var_0) {}

function obj_maj_take_apache_start() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStruct("obj_apache_tablet", "targetname").origin;
  wait 13;
  var_1 = 3000;
  var_2 = var_1 * var_1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_2)) {
      break;
    }

    wait 0.1;
  }

  level notify("activate_near_apache");
  var_3 = "convoy4_apache";
  var_4 = getEnt("convoy4_apache", "targetname");
  var_5 = scripts\cp\cp_objectives::requestworldid(var_3, 15);
  objective_setlocation(var_5, 0, var_0);
  objective_setbackground(var_5, 2);
  objective_setplayintro(var_5, 1);
  objective_setplayoutro(var_5, 1);
  objective_state(var_5, "current");
  scripts\cp\cp_objectives::ref_11f80(var_5);
  objective_icon(var_5, "icon_waypoint_objective_general");
  objective_sethot(var_5, 0);
  objective_setlabel(var_5, &"CP_QUARRY2_OBJECTIVES/CONVOY4_TAKEAPACHE");
  thread set_apache_desc_delay(level, 1);
  var_6 = spawn("script_model", var_0 + (0, 0, -200));
  var_6 setModel("veh8_mil_air_ahotel64_ks_mp");
  var_7 = spawn("script_model", var_0 + (0, 0, -210));
  var_7 setModel("veh8_mil_air_ahotel64_ks_east_mp");
  thread activate_ks_on_use();
  level scripts\engine\utility::ref_143a5("player_used_quarry_ks", "players_near_exfil");
  objective_state(var_5, "done");
  scripts\cp\cp_objectives::freeworldid(var_3);

  if(isDefined(var_6)) {
    var_6 scripts\engine\utility::delaycall(4, &delete);
  }

  if(isDefined(var_7)) {
    var_7 scripts\engine\utility::delaycall(4, &delete);
    return;
  }
}

function set_apache_desc_delay(var_0, var_1) {
  wait var_0;
  objective_setlabel(var_1, &"CP_QUARRY2_OBJECTIVES/CONVOY4_TAKEAPACHE");
}

function activate_ks_on_use() {
  level endon("game_ended");
  level endon("launched_player_fultons");
  var_0 = &"CP_QUARRY2_OBJECTIVES/USE_APACHE";
  self setHintString(var_0);
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayrange(500);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("show");
  self setuseholdduration("duration_none");
  self makeusable();

  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\cp\cp_weapon::ref_124ad(var_1)) {
      scripts\cp\cp_weapon::minigamefinishcount(var_1);
      continue;
    }

    thread activate_apache_on_player(level);
    thread make_traindoors_outlines_disabled_ks(var_1);
    self makeunusable();
    break;
  }

  self delete();
}

function make_traindoors_outlines_disabled_ks(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");

  if(isDefined(level.convoy4_train_doors)) {
    for(var_1 = 0; var_1 < level.convoy4_train_doors.size; var_1++) {
      if(isent(level.convoy4_train_doors[var_1])) {
        level.convoy4_train_doors[var_1] hudoutlinedisableforclient(var_0);
      }
    }
  }

  self waittill("stop_remote_sequence");

  if(!istrue(level.obj_train_stopped)) {
    return;
  }

  if(isDefined(level.convoy4_train_doors)) {
    for(var_1 = 0; var_1 < level.convoy4_train_doors.size; var_1++) {
      if(isent(level.convoy4_train_doors[var_1])) {
        level.convoy4_train_doors[var_1] hudoutlineenableforclient(var_0, "outline_nodepth_red");
      }
    }

    return;
  }
}

function obj_maj_wait_train_init(var_0) {
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "convoy4_the_smuggler");
  thread ref_131f0();
}

function obj_maj_wait_train_start(var_0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(22);
  level thread scripts\cp\cp_wave_spawning::killstreaks(5, "smugg_p3_train");
  thread train_handler();
  thread spawn_soldiers_rooftops();
  thread play_cargo_intro();
  thread setup_enemy_sentries(level);
  var_1 = scripts\engine\utility::getStruct("convoy4_obj_train", "targetname");
  objective_setdescription(var_0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_WAITTRAIN");
  objective_position(var_0.objectiveindex, var_1.origin);
  level thread scripts\cp\cp_objectives::ref_1317e(var_0, var_1.origin);
  scripts\cp\cp_objectives::ref_11f80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_sethot(var_0.objectiveindex, 0);
  thread obj_maj_take_apache_start();
  level waittill("convoy4_train_stopped");
}

function obj_maj_open_train_init(var_0) {
  level.trial_target_thread_func = 1;
}

function obj_maj_open_train_start(var_0) {
  objective_setdescription(var_0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_TRAIN_DOOR");
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(22);
  var_1 = scripts\cp\cp_breach_c4::setup_c4(scripts\engine\utility::getStruct("traindoor_c4_1", "targetname"));
  var_2 = scripts\cp\cp_breach_c4::setup_c4(scripts\engine\utility::getStruct("traindoor_c4_2", "targetname"));
  thread wait_for_door_breach(level);
  thread wait_for_door_breach(level);
  thread patrol_in_stealth();
  level.convoy4_train_c4s = 0;
  var_3 = scripts\engine\utility::getStructArray("train_loot_struct", "targetname");
  var_4 = undefined;
  level.convoy4_train_c4objs = thread spawn_train_c4_objects();
  var_5 = scripts\engine\utility::getStructArray("train_step_coll", "targetname");
  var_6 = (0, 0, 175);

  for(var_7 = 0; var_7 < level.convoy4_train_doors.size; var_7++) {
    foreach(var_9 in level.players) {
      level.convoy4_train_doors[var_7] hudoutlineenableforclient(var_9, "outline_nodepth_red");
      LOC_000000ec:
    }

    level.convoy4_train_doors[var_7].obj_index = var_7;
    objective_setlocation(var_0.objectiveindex, var_7, level.convoy4_train_doors[var_7].origin + var_6);
    thread hacking_magicgrenade_watcher(level, undefined, level.convoy4_train_doors[var_7].origin);
  }

  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_sethot(var_0.objectiveindex, 1);
  var_11 = undefined;
  level waittill("c4_exploded", var_11);
  var_12 = scripts\engine\utility::getclosest(var_11, level.convoy4_train_doors, 400);
  playFX(scripts\engine\utility::getfx("vfx_train_breach"), var_12.origin + (0, 0, 52), var_12.angles, anglestoup(var_12.angles));
  level.convoy4_train_doors = scripts\engine\utility::array_remove(level.convoy4_train_doors, var_12);
  var_12 hudoutlinedisable();

  if(isDefined(var_12.open_tut_gate)) {
    var_12.open_tut_gate delete();
  }

  var_12 delete();
  objective_unsetlocation(var_0.objectiveindex, var_12.obj_index);
  var_4 = thread spawn_train_stairs(level, var_11);
  thread spawn_c4_interacts_for_train(level, var_4);
  level waittill("c4_exploded", var_11);
  var_12 = scripts\engine\utility::getclosest(var_11, level.convoy4_train_doors, 400);
  playFX(scripts\engine\utility::getfx("vfx_train_breach"), var_12.origin + (0, 0, 52), var_12.angles, anglestoup(var_12.angles));
  objective_setdescription(var_0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_TRAIN_LOOT");
  scripts\cp\utility::objective_update("convoy4_take_loot");
  level notify("obj_take_loot");
  level.obj_take_loot = 1;
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_kama_quarry2_nag_train_10");
  thread play_cargo_c4_nags();
  var_12 hudoutlinedisable();

  if(isDefined(var_12.open_tut_gate)) {
    var_12.open_tut_gate delete();
  }

  var_12 delete();
  objective_unsetlocation(var_0.objectiveindex, var_12.obj_index);
  var_4 = thread spawn_train_stairs(level, var_11);
  thread spawn_c4_interacts_for_train(level, var_4);

  while(level.convoy4_train_c4s < 4) {
    wait 0.1;
  }

  level notify("all_c4_placed");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_ovl_quarry2_train_30");
  scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function patrol_in_stealth() {
  level endon("game_ended");
  level waittill("used_c4", var_0);
  thread patrol_think(level);
  level waittill("used_c4", var_1);
  thread patrol_think(level);
}

function patrol_think(var_0) {
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_1 = 2500;
  wait 6;
  var_2 = var_0.origin;
  var_3 = 0;
  var_4 = 0;

  while(var_4 < 5) {
    if(distancesquared(var_0.origin, var_2) <= var_1) {
      var_3 += 1;
    }

    var_4 += 1;
    wait 1;
  }

  if(var_3 > 3) {
    if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_5 = scripts\engine\utility::getStructArray("quarry_unstuck_spot", "targetname");
      var_6 = scripts\engine\utility::getclosest(var_0.origin, var_5);
      var_0 setOrigin(var_6.origin);
      return;
    }

    return;
  }
}

function wait_for_door_breach(var_0) {
  var_0 scripts\engine\utility::ent_flag_wait("c4_exploded");
  level notify("c4_exploded", var_0.origin);
}

function spawn_train_stairs(var_0, var_1) {
  var_2 = scripts\engine\utility::getclosest(var_0, var_1, 200).script_noteworthy;
  return var_2;
}

function spawn_train_c4_objects() {
  var_0 = scripts\engine\utility::getStructArray("obj_c4_mdl", "targetname");
  var_1 = [];
  var_2 = getEnt("clip64x64x64", "targetname");

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.angles)) {
      var_4.angles = (0, 0, 0);
    }

    var_5 = spawn("script_model", var_4.origin);
    var_5 setModel(var_4.script_noteworthy);
    var_5.angles = var_4.angles;
    var_1 = var_5;
    waitframe();
    var_6 = spawn("script_model", var_4.origin);
    var_6 clonebrushmodeltoscriptmodel(var_2);
    var_6.angles = var_4.angles;
    var_1 = var_6;
    waitframe();
  }

  return var_1;
}

function spawn_c4_interacts_for_train(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2].script_noteworthy == var_0) {
      create_usable_c4_model(var_1[var_2], var_2);
      wait 0.05;
    }
  }
}

function create_usable_c4_model(var_0) {
  var_1 = scripts\cp\cp_objectives::requestworldid("obj_loot_pickup_" + var_0, 15);
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 1);
  objective_state(var_1, "current");
  scripts\cp\cp_objectives::ref_11f80(var_1);
  objective_setbackground(var_1, 0);
  objective_setlabel(var_1, &"CP_QUARRY2_OBJECTIVES/LABEL_LOOT");
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_sethot(var_1, 1);
  var_2 = spawn("script_model", self.origin + (0, 0, 4));
  var_2 setModel("tag_origin");
  var_2.angles = self.angles;
  var_2.ref_12ead = var_2.angles;

  if(isDefined(self.script_parameters)) {
    var_2.script_parameters = self.script_parameters;
  }

  waitframe();
  var_3 = &"CP_QUARRY2_OBJECTIVES/COLLECT_LOOT";
  objective_position(var_1, var_2.origin + (0, 0, 12));
  var_2 setHintString(var_3);
  var_2 setCursorHint("HINT_BUTTON");
  var_2 sethinticon("hud_icon_c4_plant");
  var_2 sethintdisplayrange(500);
  var_2 sethintdisplayfov(65);
  var_2 setuserange(72);
  var_2 setusefov(65);
  var_2 sethintonobstruction("hide");
  var_2 setuseholdduration("duration_medium");
  var_2 sethintrequiresholding(1);
  var_2 makeusable();
  thread c4_use_think(var_2, var_1);
  return var_2;
}

function c4_use_think(var_0, var_1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_2);

    if(isDefined(var_2)) {
      if(!var_2 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      var_2 playSound("cp_generic_pickup");

      if(level.convoy4_train_c4s < 3) {
        thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_2, "obj_device_setting");
      } else {
        thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_2, "obj_collect_complete");
      }

      thread placed_c4_train(var_0, var_1);
      scripts\cp\cp_objectives::freeworldid("obj_loot_pickup_" + var_1);
    }
  }
}

function placed_c4_train(var_0, var_1) {
  self setModel("offhand_wm_c4_cp");

  if(isDefined(self.script_parameters)) {
    var_2 = self.script_parameters;
    self.angles = (self.angles[0], self.angles[1], int(var_2));
  }

  self.origin -= (0, 0, 4);
  self setscriptablepartstate("effects", "plant", 0);
  self playLoopSound("cp_bombsite_beep");
  level.convoy4_train_c4s += 1;
  objective_state(var_0, "done");
  self makeunusable();
  level waittill("players_fultoned");
  remove_c4_train();
}

function remove_c4_train() {
  self stoploopsound("cp_bombsite_beep");
  playFX(level._effect["equipment_smoke"], self.origin);
  self delete();
}

function obj_maj_extraction_init(var_0) {
  thread spawn_soldiers_ending();
  thread start_smuggler_heli_flyin();
  level.obj_used_extract_num = 0;
  level.trial_target_thread_func = 1;
}

function obj_maj_extraction_start(var_0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(24);
  var_1 = scripts\engine\utility::getStruct("objective_convoy4_05_a", "targetname");
  objective_position(var_0.objectiveindex, var_1.origin);
  level thread scripts\cp\cp_objectives::ref_1317e(var_0, var_1.origin);
  scripts\cp\cp_objectives::ref_11f80(var_0.objectiveindex);
  objective_setownerteam(var_0.objectiveindex, "allies");
  objective_sethot(var_0.objectiveindex, 0);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_setdescription(var_0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_REGROUP_EXTRACT");
  objective_setlabel(var_0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/LABEL_REGROUP");
  scripts\cp\utility::ref_123fe("mus_cp_smuggler_mission_end");
  thread spawn_map_ac130();
  thread disable_nearby_vehicles(level, var_1.origin);
  thread ref_123e3(level);
  thread ref_1240e(level);
  wait_for_start_extraction(level, var_1.origin, var_0.objectiveindex);
  level.obj_allow_fulton = 0;
  thread kiosksearchradiusidealmin();
}

function delayed_disable_respawns(var_0) {
  wait var_0;
  level.disable_respawns = 1;
}

function kiosksearchradiusidealmin() {
  wait 2;

  if(istrue(level.i_see_player_vehicle_watcher)) {
    return;
  }

  thread play_outro_vo();
  wait 4.5;
  thread mp_shipment_patch();
  wait 2;
  thread complete_game_win();
}

function smuggler_door_lock() {
  wait 10;
  var_0 = scripts\engine\utility::getStruct("smuggler_base_room", "targetname").origin;
  var_1 = "scriptable_construction_doors_metal_b_02_mp";
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var_0, 128, var_1, "classname");
}

function smuggler_door_unlock() {
  var_0 = scripts\engine\utility::getStruct("smuggler_base_room", "targetname").origin;
  var_1 = "scriptable_construction_doors_metal_b_02_mp";
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, var_0, 128, var_1, "classname");
}

function start_smuggler_heli_flyin() {
  wait 1;
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("infil_complete");
  waitframe();
  scripts\engine\utility::flag_init("smuggler_aboard");
  wait 5;
  thread spawn_smuggler_javelin();
  thread smuggler_door_unlock();
  var_0 = scripts\engine\utility::getStruct("convoy4_smuggler_heli_start", "targetname");
  var_1 = scripts\engine\utility::getStruct("convoy4_smuggler_heli_landing", "targetname");
  var_0.team = "axis";

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.classname_mp = "script_vehicle_iw8_lbravo";
  var_0.script_modelname = "veh8_mil_air_lbravo";
  var_0.vehicletype = "lbravo_infil_cp";
  wait 15;
  level.smuggler_heli = spawn_objective_heli(var_0);
  thread spawn_smuggler_heli_pilot();
  level.smuggler_heli thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var_0);
  level.smuggler_heli playLoopSound("cp_br_syrk_chopper_engine_donut_dist");
  level thread scripts\common\vehicle_paths::gopath(level.smuggler_heli);
  thread spawn_smuggler_and_board_heli();
  scripts\engine\utility::flag_wait("smuggler_aboard");
  thread smuggler_heli_objective(level);
}

function spawn_smuggler_heli_pilot() {
  waitframe();
  level.smuggler_heli.pilot = thread setup_pilot(level.smuggler_heli, "tag_pilot2");
}

function spawn_objective_heli(var_0) {
  var_1 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_1.vehicle_skipdeathmodel = 1;
  var_1.death_fx_on_self = 1;
  var_1.vehicle_skipdeathcrash = 0;
  var_1.health += 1500;
  var_1.team = "axis";
  var_1.affectedbylockon = 1;
  level thread scripts\cp\cp_weapon::add_to_special_lockon_target_list(var_1);
  thread set_smuggler_crash_loc(level);
  thread smuggler_heli_waittill_javelined();
  thread isplayeronintelchallenge();
  return var_1;
}

function isplayeronintelchallenge() {
  level endon("game_ended");

  while(getdvarint("scr_debug_heli_lockon", 0) == 0) {
    wait 1;
  }

  announcement("lockonspecialsize: " + level.special_lockon_target_list.size);
  wait 3;
  var_0 = 0;

  foreach(var_2 in level.special_lockon_target_list) {
    var_0++;
    announcement("#" + var_0 + "=" + var_2.targetname);
    wait 1;
  }
}

function smuggler_heli_waittill_javelined() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isPlayer(var_1) && isDefined(var_9) && getweaponbasename(var_9) == "iw8_la_juliet_mp") {
      self dodamage(5000, self.origin, var_1);
      self notify("death");
    }

    if(isPlayer(var_1)) {
      var_1 scripts\cp\cp_damagefeedback::updatehitmarker("standard", 1, var_0, 0, 0);
    }
  }
}

function set_smuggler_crash_loc(var_0) {
  var_0 waittill("death", var_1);
  var_2 = scripts\engine\utility::getStructArray("smuggler_heli_crash", "targetname");
  var_0.perferred_crash_location = scripts\engine\utility::getclosest(var_0.origin, var_2);
  var_3 = var_0.perferred_crash_location.origin;
  thread getcurrentxp();
  var_4 = var_0 scripts\engine\utility::ref_143b9(25, "vehicle_crashDone");

  foreach(var_6 in level.players) {
    if(isDefined(var_1) && isPlayer(var_1) && var_6 == var_1) {
      thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_6, "obj_sitrep_success");
      continue;
    }

    thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_6, "obj_target_eliminated");
  }

  if(isDefined(var_0) && isent(var_0)) {
    playFX(level._effect["helidown_groundexp"], var_0.origin);
    playsoundatpos(var_0.origin, "cp_br_syrk_chopper_crash");
  } else {
    playFX(level._effect["helidown_groundexp"], var_3);
    playsoundatpos(var_3, "cp_br_syrk_chopper_crash");
  }

  if(isDefined(var_0.pilot) && isent(var_0.pilot)) {
    var_0.pilot delete();
  }

  if(isDefined(level.smuggler_heli.smugglermdl) && isent(level.smuggler_heli.smugglermdl)) {
    level.smuggler_heli.smugglermdl delete();
  }

  if(isent(var_0)) {
    var_0 delete();
    return;
  }
}

function getcurrentxp() {
  self endon("entitydeleted");
  self endon("vehicle_crashDone");

  for(;;) {
    var_0 = self.origin;
    wait 0.5;

    if(self.origin == var_0) {
      self notify("vehicle_crashDone");
    }
  }
}

function setup_pilot(var_0, var_1, var_2) {
  var_3 = "tag_pilot";

  if(isDefined(var_0)) {
    var_3 = var_0;
  }

  var_4 = (0, 0, 0);

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  var_5 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  var_6 = spawn("script_model", self gettagorigin(var_3));
  var_6 setModel("aq_pilot_fullbody_1");
  var_6 linkTo(self, var_3, var_4, var_5);
  var_6 scriptmodelplayanim("vh_blima_rappel_pilot");
  return var_6;
}

function spawn_smuggler_and_board_heli() {
  var_0 = smuggler_spawn();
  var_0.script_startingposition = 3;
  var_0.dontkilloff = 1;
  var_0.ignoreall = 1;
  var_0.ignoreme = 1;
  var_0 scripts\common\utility::demeanor_override("sprint");
  var_0.scripted_mode = 1;
  thread ref_1342b(level);
  thread smuggler_base_room();
  wait 18;

  if(!isalive(self)) {
    return;
  }

  var_1 = scripts\engine\utility::getStruct("obj_smuggler_gotopos", "targetname");
  var_2 = getclosestpointonnavmesh(var_1.origin);
  var_0 setgoalpos(var_2);
  thread scripts\cp\utility::drawsphere(var_2, 25, 9999, (1, 0, 0));
  thread smuggler_timeout_backup(var_0);
  wait_for_soldier_at_heli(var_0, var_2);

  if(!isDefined(level.smuggler_heli) || !isent(level.smuggler_heli) || !isalive(var_0)) {
    level waittill("continue_fulton_extraction");

    if(isent(var_0)) {
      var_0 kill();
    }

    scripts\engine\utility::flag_set("smuggler_aboard");
    return;
  }

  var_0 notify("got_to_heli");
  var_0 hide();
  var_0.origin = (34917, 29465, 562);
  var_2 = getclosestpointonnavmesh(var_0.origin);
  var_0 setgoalpos(var_2);
  thread ref_1342c();
  level.smuggler_heli.smugglermdl = thread setup_pilot(level.smuggler_heli, "tag_pilot1");
  wait 0.5;
  scripts\engine\utility::flag_set("smuggler_aboard");
}

function ref_1342b(var_0) {
  var_0 endon("got_to_heli");
  var_0 waittill("death");
  level.ref_11f79 = 1;
}

function ref_1342c() {
  self endon("death");
  wait 5;
  self kill();
}

function spawn_smuggler_javelin() {
  var_0 = scripts\engine\utility::getStructArray("smuggler_javelin", "targetname");
  var_1 = "icon_weapon_la_juliet";
  var_2 = &scripts\cp_mp\entityheadicons::setheadicon_singleimage;

  foreach(var_4 in var_0) {
    var_5 = scripts\cp\cp_weapon::buildweapon("iw8_la_juliet_mp", [], "none", "none", -1);
    var_6 = createheadicon(var_5);
    var_7 = spawn("weapon_" + var_6, var_4.origin);
    var_7.angles = var_4.angles;
    var_7 itemweaponsetammo(weaponclipsize(var_5), weaponmaxammo(var_5));
    var_7.boxiconid = var_7 thread[[var_2]]("allies", var_1, 12, 1, 800, 100, undefined, undefined, 1);
    thread wait_for_player_pickup();
  }
}

function wait_for_player_pickup() {
  self endon("death");
  self waittill("trigger", var_0);
  setheadiconimage(self.boxiconid);
}

function wait_for_soldier_at_heli(var_0) {
  self endon("death");
  self endon("heli_go_timeout");
  var_1 = 1600;

  for(;;) {
    var_2 = distance2dsquared(self.origin, var_0);

    if(var_2 < var_1) {
      break;
    }

    wait 0.1;
  }

  wait 0.5;
}

function smuggler_timeout_backup(var_0) {
  self endon("death");
  self endon("got_to_heli");
  wait var_0;
  self notify("heli_go_timeout");
}

function smuggler_spawn() {
  level.convoy4_module_smugg_1 = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_the_smuggler");
  var_0 = undefined;

  while(!isDefined(level.convoy4_module_smugg_1) || !isDefined(level.convoy4_module_smugg_1.ai_spawned)) {
    wait 0.05;
  }

  while(level.convoy4_module_smugg_1.ai_spawned.size == 0) {
    wait 0.05;
  }

  if(isDefined(level.convoy4_module_smugg_1.ai_spawned) && level.convoy4_module_smugg_1.ai_spawned.size > 0) {
    var_0 = level.convoy4_module_smugg_1.ai_spawned[0];
  }

  return var_0;
}

function smuggler_heli_objective(var_0) {
  level endon("end_smuggler_objective");
  var_1 = "smuggler_kill";
  var_2 = scripts\cp\cp_objectives::requestworldid(var_1, 15);
  objective_setplayintro(var_2, 1);
  objective_setplayoutro(var_2, 1);

  if(isDefined(var_0) && isent(var_0)) {
    var_3 = var_0 scripts\engine\utility::spawn_tag_origin();
    var_3 notsolid();
    var_3 show();
    var_3 linkTo(var_0, "tag_origin", (0, 0, 256), (0, 0, 0));
    var_0.obj_pos = var_3;
    objective_setlocation(var_2, 0, var_0.obj_pos);
  }

  objective_state(var_2, "current");
  scripts\cp\cp_objectives::ref_11f80(var_2);
  objective_setlabel(var_2, &"CP_QUARRY2_OBJECTIVES/KILL_SMUGGLER");
  objective_icon(var_2, "icon_waypoint_objective_general");
  objective_sethot(var_2, 1);
  objective_setbackground(var_2, 0);
  objective_addalltomask(var_2);
  objective_showtoplayersinmask(var_2);

  if(istrue(level.ref_11f79)) {
    level thread scripts\cp\utility::objective_update("convoy4_kill_smuggler", undefined, undefined, undefined, 1, undefined, 2);
    wait 1;
  } else {
    level thread scripts\cp\utility::objective_update("convoy4_kill_smuggler", undefined, undefined, undefined, 1, undefined, 2);

    if(isDefined(var_0) && isent(var_0)) {
      thread ref_1241e();
      thread smuggler_too_far_fail(level, 60, var_1, var_2);
    }

    if(isDefined(var_0) && isent(var_0)) {
      var_0 waittill("death");
    } else {
      wait 1;
    }
  }

  scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "convoy4_the_smuggler");
  scripts\cp\cp_objectives::lua_objective_complete("convoy4_kill_smuggler");
  objective_state(var_2, "done");
  scripts\cp\cp_objectives::freeworldid(var_1);
}

function smuggler_too_far_fail(var_0, var_1, var_2, var_3) {
  var_3 endon("death");
  wait var_0;
  objective_unsetlocation(var_2, 0);
  wait 10;
  level notify("end_smuggler_objective");
  objective_state(var_2, "failed");
  scripts\cp\cp_objectives::fail_objective("smuggler_kill");
  scripts\cp\cp_objectives::freeworldid(var_1);
}

function smuggler_base_room() {
  var_0 = scripts\engine\utility::getStruct("smuggler_base_room", "targetname").origin;
  var_1 = 2304;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_1)) {
      break;
    }

    wait 3;
  }
}

function disable_nearby_vehicles(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = level.vehicle.instances["technical"];
  jumpiftrue(isDefined(var_3)) LOC_00000022;
  return;
}

function game_ended_fadeout() {
  self.endgame_overlay = newclienthudelem(self);
  self.endgame_overlay.x = 0;
  self.endgame_overlay.y = 0;
  self.endgame_overlay setshader("black", 640, 480);
  self.endgame_overlay.alignx = "left";
  self.endgame_overlay.aligny = "top";
  self.endgame_overlay.sort = 1;
  self.endgame_overlay.horzalign = "fullscreen";
  self.endgame_overlay.vertalign = "fullscreen";
  self.endgame_overlay.alpha = 0;
  self.endgame_overlay.foreground = 1;
  self.endgame_overlay fadeovertime(3);
  self.endgame_overlay.alpha = 1;
}

function delay_objective_update(var_0, var_1) {
  wait 0.05;

  if(istrue(var_1)) {
    level thread scripts\cp\utility::objective_update(var_0);
    return;
  }

  level thread scripts\cp\utility::objective_update(var_0, 30, 25, 15);
}

function debugbeatobjective(var_0) {
  level notify("debug_beat_" + var_0 + "_objective");
}

function make_civ_usable(var_0, var_1) {
  scripts\cp\cp_hostage::civ_init(self);
  self.onuse = &civ_try_go_to_extract;
  self.trigger = spawn("script_model", self.origin + (-1, 0, 35));
  self.trigger linkTo(self, "j_wrist_le");
  self.trigger makeusable();
  self.trigger setuseprioritymax();
  self.trigger setCursorHint("HINT_BUTTON");
  self.trigger sethintdisplayrange(148);
  self.trigger sethintdisplayfov(90);
  self.trigger setuserange(72);
  self.trigger setusefov(45);
  self.trigger sethintonobstruction("show");
  self.trigger sethintrequiresholding(1);
  self.trigger setuseholdduration("duration_short");
  scripts\engine\utility::set_movement_speed(170);
  thread scripts\engine\utility::delete_on_death(self.trigger);
  thread scripts\cp\cp_hostage::ai_used_think();
}

function civ_try_go_to_extract(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("gotten_to_extract");
  self endon("at_extract");
  self notify("vip_used");
  self notify("following_player");
  var_2 = self.extractloc;
  var_3 = 350;
  var_4 = 250;
  var_5 = 1000000;
  var_6 = var_3 * var_3;
  var_7 = var_4 * var_4;
  self.combatmode = "no_cover";
  self.trigger makeunusable();
  wait 2;

  for(;;) {
    wait 0.5;
    var_2 = self.extractloc;
    scripts\cp\cp_modular_spawning::set_goal_radius(32);

    if(!scripts\cp\utility::any_player_nearby(self.origin, var_6)) {
      objective_sethot(self.objectiveindex, 1);
      objective_setlabel(self.objectiveindex, &"CP_QUARRY2_OBJECTIVES/HVI_NO_PLAYER_NEARBY");
      self allowedstances("crouch");
      var_8 = getclosestpointonnavmesh(self.origin);
      scripts\cp\cp_modular_spawning::set_goal_pos(var_8);
      waitframe();
      continue;
    }

    if(are_enemies_nearby(var_7, var_5)) {
      objective_sethot(self.objectiveindex, 1);
      objective_setlabel(self.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CLEAR_HOSTAGE");
      self allowedstances("crouch");
      var_8 = getclosestpointonnavmesh(self.origin);
      scripts\cp\cp_modular_spawning::set_goal_pos(var_8);
      waitframe();
      continue;
    }

    if(distancesquared(var_2, self.origin) > 16384) {
      objective_sethot(self.objectiveindex, 0);
      objective_setlabel(self.objectiveindex, &"CP_QUARRY2_OBJECTIVES/FOLLOWING_PLAYER");
      var_8 = getclosestpointonnavmesh(var_2);
      scripts\cp\cp_modular_spawning::set_goal_pos(var_8);
      waitframe();
    }
  }
}

function obj_comms_start(var_0, var_1, var_2) {
  var_3 = var_2.objectiveindex;
  objective_setownerteam(var_2.objectiveindex, undefined);
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = 0;

  switch (var_1) {
    case "a":
      var_4 = "objective_convoy4_02_a";
      var_5 = "comms_laptop_interaction_a";
      var_6 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_SWITCH_1";
      var_7 = "icon_waypoint_sp_generic";
      var_8 = &spawn_soldiers_switch_01;
      var_9 = 0;
      var_10 = 1;
      break;
    case "b":
      var_4 = "objective_convoy4_02_b";
      var_5 = "comms_laptop_interaction_b";
      var_6 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_SWITCH_2";
      var_7 = "icon_waypoint_sp_generic";
      var_8 = &spawn_soldiers_switch_02;
      var_9 = 150;
      var_10 = 2;
      break;
    case "c":
      var_4 = "objective_convoy4_02_c";
      var_5 = "comms_laptop_interaction_c";
      var_6 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_SWITCH_3";
      var_7 = "icon_waypoint_sp_generic";
      var_8 = &spawn_soldiers_switch_03;
      var_9 = 100;
      var_10 = 3;
      break;
  }

  thread stopwaveandstartthisone(level);
  level notify("started_hack_at_" + var_1);
  thread handle_remind_hack();
  thread hacking_magicgrenade_watcher(level, undefined, var_4);
  thread quarry_hacking_sfx(level, var_5);
  scripts\cp\cp_interaction::addtointeractionslistbynoteworthy(var_5);
  level.convoy4_comms_laptop_int_struct = scripts\cp\utility::getinteractionbynoteworthy(var_5);
  level.convoy4_comms_laptop_int_struct.objectivestruct = var_2;
  level.convoy4_comms_laptop_sn = var_4;

  if(isDefined(level.convoy4_comms_laptop_int_struct)) {
    level.convoy4_comms_laptop_int_struct.laptopactive = 1;
  }

  var_11 = scripts\engine\utility::getStruct(var_4, "targetname");
  objective_setplayintro(var_2.objectiveindex, 1);
  objective_setplayoutro(var_2.objectiveindex, 1);
  objective_position(var_2.objectiveindex, var_11.origin);
  level thread scripts\cp\cp_objectives::ref_1317e(var_2, var_11.origin);
  objective_state(var_2.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var_2.objectiveindex);
  objective_icon(var_2.objectiveindex, var_7);
  objective_sethot(var_2.objectiveindex, 0);
  objective_setlabel(var_2.objectiveindex, var_6);

  if(var_1 == "b") {
    thread handle_players_near_hack_b(level, var_11.origin);
    thread spawn_smoke_when_near_struct(level, "convoy4_smokehint", 150, undefined);
  }

  if(var_1 == "c") {
    thread spawn_smoke_when_near_struct(level, "convoy4_hack3_smoke1", undefined);
    thread spawn_smoke_when_near_struct(level, "convoy4_hack3_smoke2", undefined);
    thread spawn_smoke_when_near_struct(level, "convoy4_hack3_smoke3", undefined);
    thread spawn_smoke_when_near_struct(level, "convoy4_hack3_smoke4", undefined);
  }

  level waittill("cpu_hacking_done");
  level notify("comms_laptop_hacked");
  scripts\cp\utility::ref_123fe("");
  thread play_hack_vo(level);
  playsoundatpos(var_11.origin, "cp_hacking_success");
  level.i_see_player_shield_watcher = 0;
}

function activationcommslaptop(var_0, var_1) {
  if(!istrue(level.convoy4_comms_laptop_int_struct.laptopactive)) {
    return;
  }

  thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_1, "obj_interact");
  var_2 = 1;

  if(getdvarint("scr_quarry2_speed", 0) != 0) {
    var_2 = 0.03;
  }

  if(!isDefined(level.ref_12958)) {
    level.ref_12958 = 1;
  } else {
    level.ref_12958++;
  }

  var_3 = 120;

  switch (level.ref_12958) {
    case 1:
      scripts\cp\utility::ref_123fe("mus_cp_smuggler_files_copied_1");
      var_3 = 220;
      break;
    case 2:
      scripts\cp\utility::ref_123fe("mus_cp_smuggler_files_copied_2");
      var_3 = 120;
      break;
    case 3:
      scripts\cp\utility::ref_123fe("mus_cp_smuggler_files_copied_3");
      var_3 = 120;
      break;
  }

  var_0.objectivestruct = level.convoy4_comms_laptop_int_struct.objectivestruct;
  var_0.disabled = 1;
  var_0.objectivestruct notify("start_hacking_comms_laptop", var_0);
  level notify("start_hacking_comms_laptop", var_0);
  level.i_see_player_shield_watcher = 1;
  var_4 = &scripts\cp\cp_objective_mechanics::starthackingdefense;
  var_5 = scripts\engine\utility::getStruct(level.convoy4_comms_laptop_sn, "targetname").origin;
  [[var_4]](var_0.objectivestruct, var_5, 120 * var_2, "comms_laptop_hacked", var_3);
}

function quarry_hacking_sfx(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");

  if(var_1 == "b") {
    thread his_respawn(level);
  }

  var_3 = spawn("script_origin", var_2.origin);
  wait 0.05;
  var_3 playLoopSound("cp_hacking_struct_lp");
  level waittill("start_hacking_comms_laptop");
  thread computer_animation(level);
  var_3 stoploopsound("cp_hacking_struct_lp");
}

function hacking_magicgrenade_watcher(var_0, var_1, var_2) {
  level endon("cpu_hacking_done");
  level endon("stop_grenade_watcher");
  level endon("game_ended");

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.currentteam = "allies";
  }

  var_3 = 300;
  var_4 = var_3 * var_3;
  var_5 = 500 + var_2;
  var_6 = ["frag_grenade_mp", "frag_grenade_mp", "smoke_grenade_mp"];
  jumpiftrue(isvector(var_1)) LOC_00000078;
  var_1 = scripts\engine\utility::getStruct(var_1, "targetname").origin;

  for(;;) {
    var_7 = scripts\cp\utility::getplayersinteam(var_0.currentteam);
    var_8 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_9 = scripts\engine\utility::getclosest(var_1, var_8, var_5);

    if(isDefined(var_9) && isalive(var_9)) {
      foreach(var_11 in var_7) {
        if(distancesquared(var_11.origin, var_1) <= var_4) {
          var_12 = var_11.origin - var_9.origin;
          var_13 = scripts\engine\utility::random(var_6);
          var_14 = randomfloatrange(1, 3);
          var_15 = var_9 launchgrenade(var_13, var_11.origin, (0, 0, 0), var_14);
          break;
        }
      }
    }

    wait randomfloat(10) + 5;
  }
}

function spawn_smoke_when_near_struct(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("stop_auto_smokes");
  var_4 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_4)) {
    return;
  }

  if(isDefined(var_3)) {
    var_5 = var_3 * var_3;

    while(!scripts\cp\utility::any_player_nearby(var_4.origin, var_5)) {
      wait 0.5;
    }
  }

  if(!isDefined(var_1)) {
    if(isDefined(var_4.radius)) {
      var_1 = int(var_4.radius);
    } else {
      var_1 = 150;
    }
  }

  var_6 = var_1 * var_1;

  for(;;) {
    if(any_soldiers_nearby(var_4.origin, var_6)) {
      thread magic_smoke_launch(level, var_4.origin, (0, 0, 10));

      if(!isDefined(var_2)) {
        return;
      }

      wait var_2;
    }

    wait 1;
  }
}

function any_soldiers_nearby(var_0, var_1) {
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(distancesquared(var_2[var_3].origin, var_0) <= var_1) {
      return true;
    }
  }

  return false;
}

function magic_smoke_launch(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = spawn("script_model", var_0);
    var_5 setModel("tag_origin");
    wait var_2;
    var_6 = anglesToForward(var_5.angles);
    var_7 = (0, 0, 1);
    var_0 = var_5.origin + (0, 0, 2);
    var_5 delete();
    magicgrenademanual("smoke_grenade_mp", var_0, (0, 0, 0), 0.3);
    thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", var_0);
    wait 7;
  }
}

function start_smoke_in_attic() {
  level endon("game_ended");
  level endon("stop_attic_smoke");
  var_0 = scripts\engine\utility::getStruct("attic_smoke_trigger", "targetname");
  var_1 = scripts\engine\utility::getStructArray("attic_smoke", "targetname");
  var_2 = 72;
  var_3 = var_2 * var_2;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0.origin, var_3)) {
      break;
    }

    wait 0.2;
  }

  foreach(var_5 in var_1) {
    thread magic_smoke_launch(level, var_5.origin, (0, 0, 10), 1);
  }
}

function spawn_extra_collision(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 dontinterpolate();
  var_2.angles = var_1;
  var_3 = getEnt("clip128x128x8", "targetname");
  var_2 clonebrushmodeltoscriptmodel(var_3);
  var_2 linkTo(self);
  self.open_tut_gate = var_2;
  return var_2;
}

function train_handler() {
  level.train_nav_blocks = thread spawn_train_nav_blockers_all();
  level.convoy4_train_doors = [];
  var_0 = scripts\engine\utility::getStruct("smuggler_train_path_start", "targetname");
  var_1 = 19;
  var_2 = undefined;

  if(isDefined(var_0.target)) {
    var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  }

  var_3 = undefined;

  if(isDefined(var_2)) {
    var_4 = vectortoangles(var_2.origin - var_0.origin + (0, 0, 54));
    var_3 = (0, var_4[1], 0);
  }

  var_5 = (0, 0, 0);
  var_3 += (0, 262, 0);
  level notify("stop_arrows");
  var_6 = 2;
  thread ref_13779();
  var_7 = spawn_train_car(var_0.origin + (0, 0, 54), var_3, undefined, undefined, undefined, 1);
  var_7.script_noteworthy = "1";
  thread move_train_along_struct_path(level, var_7, var_1);
  thread train_sfx_1();
  wait var_6 + 0.2;
  var_8 = spawn_train_car(var_0.origin + (0, 0, 54), var_3, 1);
  var_8.script_noteworthy = "2";
  thread move_train_along_struct_path(level, var_8, var_1);
  wait var_6;
  var_9 = spawn_train_car(var_0.origin + (0, 0, 54), var_3);
  var_9.script_noteworthy = "3";
  thread move_train_along_struct_path(level, var_9, var_1);
  level.convoy4_train_follow = var_9;
  wait var_6;
  var_10 = spawn_train_car(var_0.origin + (0, 0, 54), var_3, 1);
  var_10.script_noteworthy = "4";
  thread move_train_along_struct_path(level, var_10, var_1);
  thread train_sfx_2();
  wait var_6;
  var_11 = [];
  GscBinSkip0(0x2e, var_11.size, var_7, var_10, var_5, var_5, var_5, var_7, var_5, level, level);
}

function ref_13c9b(var_0) {
  wait 37.1;
  level notify("start_anim_train");
  level notify("convoy4_stop_train");
  var_1 = 0;

  foreach(var_3 in var_0) {
    foreach(var_5 in var_3.train_parts) {
      if(var_5.type != "hatch") {
        var_5 hide();
        var_5 notsolid();
      }
    }

    thread show_headicon_to(var_3);
  }
}

function show_headicon_to(var_0) {
  wait 1;

  if(var_0.script_noteworthy == "2") {
    var_1 = level.ref_1295e gettagorigin("cargo_03_tag_body");
    var_2 = level.ref_1295e gettagangles("cargo_03_tag_body");
    var_0.origin = var_1;
    var_0.angles = var_2;
    var_0 linkTo(level.ref_1295e, "cargo_03_tag_body", (0, 0, 56), (0, 0, 0));
    return;
  }

  if(var_0.script_noteworthy == "4") {
    var_1 = level.ref_1295e gettagorigin("cargo_02_tag_body");
    var_2 = level.ref_1295e gettagangles("cargo_02_tag_body");
    var_0.origin = var_1;
    var_0.angles = var_2;
    var_0 linkTo(level.ref_1295e, "cargo_02_tag_body", (0, 0, 56), (0, 0, 0));
    return;
  }
}

function ref_13cbb() {
  wait 73;
  ref_130fb();
}

function train_sfx_1() {
  wait 30;
  var_0 = spawn("script_model", self.origin);
  var_0 linkTo(self);
  wait 0.5;
  var_0 playsoundonmovingent("cp_quarry_train_1_arrive");
  wait 20;
  var_0 unlink();
  var_0.origin = level.ref_1295e gettagorigin("engine_01_tag_origin");
  var_0 linkTo(level.ref_1295e, "engine_01_tag_origin");
  wait 41;
  var_0 delete();
}

function train_sfx_2() {
  wait 30;
  var_0 = spawn("script_model", self.origin);
  var_0 linkTo(self);
  wait 0.5;
  var_0 playsoundonmovingent("cp_quarry_train_2_arrive");
  wait 55;
  var_0 delete();
}

function spawn_train_car(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_origin", var_0);
  var_7 = var_1;
  var_8 = var_7 + (0, 180, 90);
  var_9 = 80;
  var_10 = istrue(var_3);
  var_11 = &spawn_train_car_part;
  var_12 = [];

  if(!istrue(var_5)) {
    GscBinSkip0(0x2e, var_12.size, [[var_11]]("bed", "stationary_train_car_chassis_01", var_0 - (0, 0, var_9), var_7, var_6));
  }

  GscBinSkip0(0x2e, var_12.size, [[var_11]]("whole", "veh8_ind_lnd_enovember_train_static", var_0 - (0, 0, var_9), var_7, var_6));
}

function offset_ang(var_0, var_1) {
  var_2 = rotatevector(var_0, var_1);
  return var_2;
}

function spawn_train_car_part(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawn("script_model", var_2);
  var_7.angles = var_3;
  var_7 setModel(var_1);
  var_7 solid();
  var_7 show();
  var_7.type = var_0;
  var_7 linkTo(var_4);

  if(var_0 == "hatch") {
    var_8 = var_7.origin;
    var_9 = (-40, 0, 0);
    var_10 = rotatevector(var_9, var_7.angles);
    var_8 += var_10;
    var_11 = var_7.angles + (90, 90, 0);
    thread spawn_extra_collision(var_7, var_8);
  }

  return var_7;
}

function spawn_train_nav_blockers_all() {
  var_0 = scripts\engine\utility::getStructArray("convoy4_train_block", "script_noteworthy");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = thread spawn_train_nav_blocker(var_3);
    var_1 = var_4;
    waitframe();
  }

  return var_1;
}

function spawn_train_nav_blocker(var_0) {
  var_1 = var_0.origin;
  var_1 -= 24;
  var_2 = createnavobstaclebybounds(var_1, (196, 196, 64), (0, 0, 0));
  return var_2;
}

function waitfor_train_explode() {
  wait 3;

  if(!isDefined(level.ref_1295e)) {
    return;
  }

  var_0 = level.ref_1295e gettagorigin("engine_01_tag_origin");
  var_1 = level.ref_1295e gettagorigin("cargo_03_tag_origin");
  var_2 = level.ref_1295e gettagorigin("loader_02_tag_origin");
  var_3 = level.ref_1295e gettagorigin("cargo_02_tag_origin");
  thread explode_results(level);
  thread explode_results(level);
  thread explode_results(level);
  thread explode_results(level);
  level notify("obj_train_exploded");
  waitframe();

  if(isDefined(level.convoy4_train_c4objs)) {
    foreach(var_5 in level.convoy4_train_c4objs) {
      if(isent(var_5)) {
        var_5 delete();
      }
    }
  }

  waitframe();

  if(isDefined(level.train_nav_blocks)) {
    foreach(var_8 in level.train_nav_blocks) {
      destroynavobstacle(var_8);
    }

    return;
  }
}

function explode_results(var_0) {
  wait randomfloat(0.2);
  playFX(level._effect["vfx_wp_train_explosion"], var_0 + (0, 0, 12));

  if(soundexists("cp_quarry_train_explode_01")) {
    playsoundatpos(var_0, "cp_quarry_train_explode_01");
  }

  var_1 = 4000000;
  var_2 = scripts\cp\utility::give_all_players_nearby(var_0, var_1);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] scripts\cp_mp\utility\player_utility::_isalive()) {
      if(!istrue(var_2[var_3].used_fulton_interact)) {
        var_2[var_3] dodamage(200, var_0, var_2[var_3], var_2[var_3], "MOD_EXPLOSIVE");
      }
    }
  }

  scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(var_0, 0.09, 1.5, 3000);
  wait 0.25;
}

function debug_loop_explosion() {
  level endon("game_ended");
  wait 5;
  var_0 = scripts\engine\utility::getStructArray("train_explosions_debug", "targetname");

  for(;;) {
    if(getDvar("scr_quarry2_trainexplode", "") == "") {
      wait 0.5;
      continue;
    }

    setDvar("scr_quarry2_trainexplode", "");

    foreach(var_2 in var_0) {
      var_3 = var_2.origin;
      playFX(level._effect["vfx_wp_train_explosion"], var_3 + (0, 0, 12));

      if(soundexists("cp_quarry_train_explode_01")) {
        playsoundatpos(var_3, "cp_quarry_train_explode_01");
      }

      scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(var_3, 0.09, 1.5, 3000);
      wait 0.25;
    }
  }
}

function complete_game_win() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0].ability_invulnerable = 1;
  }

  foreach(var_2 in level.players) {
    var_2 scripts\cp_mp\xmike109::scriptable_callback("smuggler");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var_2 thread scripts\cp_mp\xmike109::scriptable_callback("brimstone_mod");
        continue;
      }

      var_2 thread scripts\cp_mp\xmike109::scriptable_callback("brimstone_mod_vet");
    }
  }

  scripts\cp\cp_objectives::screenent_c("major_objective");
  level notify("obj_quarry_complete");
  wait 4;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function mp_shipment_patch() {
  wait 1.8;
  thread ref_130a8();
}

function move_train_along_struct_path(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("convoy4_train_stopped");
  level endon("convoy4_stop_train");
  var_1 *= 17.6;
  var_3 = scripts\engine\utility::getStruct("smuggler_train_path_start", "targetname");
  thread damage_infront_of_train(var_0);
  var_4 = 0;

  while(isDefined(var_3.target)) {
    var_4++;
    var_5 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    var_6 = distance(var_3.origin, var_5.origin);
    var_7 = var_6 / var_1;

    if(var_7 <= 0.1) {
      var_7 = 0.15;
    }

    var_8 = 0;

    if(isDefined(var_5.speed) && isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "1") {
      var_9 = get_train_special_speed(var_5.speed);
      var_7 = var_9.timetomove;

      for(var_4 = 0; var_4 < level.convoy4_train.size; var_4++) {
        if(level.convoy4_train[var_4].script_noteworthy != "1") {
          level.convoy4_train[var_4].speed = var_7;
        }
      }
    }

    if(isDefined(var_0.speed)) {
      if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy != "1") {
        switch (var_0.script_noteworthy) {
          case "2":
            var_7 = var_0.speed + 0.15;
            break;
          case "3":
            var_7 = var_0.speed - 0.125;
            break;
          case "4":
            var_7 = var_0.speed - 0.225;
            break;
          case "5":
            var_7 = var_0.speed - 0.325;
            break;
        }
      }
    }

    var_10 = var_7;

    if(var_10 > 2) {
      var_10 = var_7 * 0.25;

      if(var_10 < 0.05) {
        var_10 = 0.05;
      }
    }

    var_11 = abs((var_5.origin - var_3.origin)[2]);

    if(var_11 > 20) {
      var_10 *= 0.35;

      if(var_10 < 0.05) {
        var_10 = 0.05;
      }
    }

    var_12 = var_5.origin + (0, 0, 54);
    var_13 = vectortoangles(var_5.origin - var_3.origin);
    var_13 += var_2;
    var_0 moveTo(var_12, var_7);
    var_0 rotateTo(var_13, var_10);
    wait var_7;
    var_3 = var_5;
  }

  ref_130fb();
}

function ref_130fb() {
  level.obj_train_stopped = 1;
  level notify("convoy4_train_stopped");
}

function get_train_special_speed(var_0) {
  var_1 = spawnStruct();
  var_2 = "" + var_0;

  switch (var_2) {
    case "1":
      var_1.timetomove = 0.5;
      var_1.decc = 0.2;
      break;
    case "2":
      var_1.timetomove = 0.55;
      var_1.decc = 0.2;
      break;
    case "3":
      var_1.timetomove = 0.6;
      var_1.decc = 0.2;
      break;
    case "4":
      var_1.timetomove = 0.65;
      var_1.decc = 0.2;
      break;
    case "5":
      var_1.timetomove = 0.7;
      var_1.decc = 0.2;
      break;
    case "6":
      var_1.timetomove = 0.75;
      var_1.decc = 0.2;
      break;
    case "7":
      var_1.timetomove = 0.8;
      var_1.decc = 0.2;
      break;
    case "8":
      var_1.timetomove = 0.85;
      var_1.decc = 0.2;
      break;
    case "9":
      var_1.timetomove = 0.9;
      var_1.decc = 0.2;
      break;
    case "10":
      var_1.timetomove = 0.95;
      var_1.decc = 0.2;
      break;
  }

  return var_1;
}

function damage_infront_of_train(var_0, var_1, var_2) {
  level endon("convoy4_train_stopped");
  level endon("game_ended");
  var_3 = 170;

  if(isDefined(var_2)) {
    var_3 = var_2;
  }

  var_4 = var_3 * var_3;
  var_5 = var_0.origin;

  for(;;) {
    var_5 = var_0.origin;

    if(isDefined(var_1)) {
      var_5 = var_0 gettagorigin(var_1);
    }

    var_6 = [];

    foreach(var_8 in level.players) {
      if(isDefined(var_8.placedsentries)) {
        foreach(var_10 in var_8.placedsentries) {
          foreach(var_12 in var_10) {
            var_6 = var_12;
          }
        }
      }
    }

    var_16 = [];
    var_16 = scripts\engine\utility::array_combine(level.players, level.turrets, var_6);

    foreach(var_18 in var_16) {
      if(isPlayer(var_18) && !var_18 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(!isalive(var_18)) {
        continue;
      }

      if(distancesquared(var_18.origin, var_5) > var_4) {
        continue;
      }

      if(isDefined(var_18.turrettype)) {
        var_18 notify("kill_turret", 1);
        continue;
      }

      var_18 dodamage(200, var_5);
    }

    wait 0.25;
  }
}

function wait_for_start_extraction(var_0, var_1) {
  level endon("game_ended");
  var_2 = (0, 0, 90);
  var_3 = var_0 - (0, 0, 64);
  thread ondefuse(level);
  objective_sethot(var_1, 1);
  var_4 = 180;

  if(getdvarint("scr_fultontime", 0) > 0) {
    var_4 = getdvarint("scr_fultontime", 0);
  }

  thread all_players_fulton();
  thread wait_for_all_extracts();
  thread init_bombs();
  var_5 = (-97.881, -441.68, 1024);
  var_6 = var_4 - 32;
  level thread scripts\cp\infilexfil\cp_fulton::fulton_group_exfil_at_pos(var_0 - (0, 0, 64), (0, 237, 0), var_6, var_5);
  thread wait_extraction_timer(level, var_4 - 2);
  level thread scripts\cp\utility::objective_update("convoy4_extraction", var_4, var_4 - 1, var_4 * 0.08333, 1);
  level thread scripts\cp\infilexfil\cp_fulton::ref_123be(var_4);
  level waittill("launched_player_fultons");
  level notify("players_fultoned");
  level.obj_players_fultoning = 1;
  wait 0.5;
}

function wait_for_all_extracts() {
  level endon("continue_fulton_extraction");
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2.team == "allies") {
      var_0++;
    }
  }

  while(level.obj_used_extract_num < var_0) {
    wait 0.1;
  }
}

function wait_extraction_timer(var_0, var_1) {
  level endon("continue_fulton_extraction");
  thread player_move(level, var_0);

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    level.players[var_2] playLoopSound("bomb_tick");
  }

  wait var_0;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    level.players[var_2] stoploopsound("bomb_tick");
  }
}

function player_move(var_0, var_1) {
  level endon("game_ended");
  level endon("continue_fulton_extraction");
  var_2 = var_0 - 15;
  wait var_2;
  objective_setownerteam(var_1, "neutral");

  for(;;) {
    objective_sethot(var_1, 1);
    wait 0.65;
    objective_sethot(var_1, 0);
    wait 0.65;
  }
}

function ondefuse(var_0) {
  level endon("game_ended");
  level endon("continue_fulton_extraction");

  for(var_1 = 0; var_1 < 15; var_1++) {
    magicgrenademanual("deploy_airdrop_mp", getgroundposition(var_0, 16), (0, 0, 0), 0.01);
    wait 10;
  }
}

function init_bombs() {
  level endon("game_ended");
  var_0 = scripts\engine\utility::getStruct("objective_convoy4_05_a", "targetname");
  level waittill("player_used_extract", var_1);
  var_2 = 900;
  var_3 = createnavbadplacebybounds(var_0.origin, (var_2, var_2, var_2), (0, 0, 0));
  level waittill("player_used_extract", var_1);
  wait 1;
  destroynavobstacle(var_3);
  var_2 = 3500;
  var_3 = createnavbadplacebybounds(var_0.origin, (var_2, var_2, var_2), (0, 0, 0));
}

function all_players_fulton() {
  level endon("game_ended");
  level waittill("continue_fulton_extraction");
  level.ref_139b5 = 1;
  wait 0.1;
  thread waitfor_train_explode();
  level thread scripts\cp\utility::objective_update("convoy4_extraction");
  level notify("launched_player_fultons");
}

function are_enemies_nearby(var_0, var_1) {
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var_4 in var_2) {
    if(!isDefined(var_4) || var_4 == self) {
      continue;
    }

    var_5 = distance2dsquared(self.origin, var_4.origin);

    if(var_5 > var_1) {
      continue;
    }

    if(var_5 <= var_0) {
      return true;
    }

    var_6 = sighttracepassed(var_4 getEye(), self getEye(), 0, var_4);

    if(var_6) {
      return true;
    }
  }

  return false;
}

function disable_jugg_objective_position_on_death(var_0, var_1, var_2, var_3) {
  var_4 = thread create_usable_key_model(var_0, var_0, var_1, var_2);
}

function create_usable_key_model(var_0, var_1, var_2, var_3) {
  self waittill("death");
  var_4 = spawn("script_model", self.origin + (0, 0, 5));
  var_4 setModel("offhand_wm_cellphone_old");
  var_4.angles = (270, 0, 0);
  waitframe();
  var_5 = &"CP_QUARRY2_OBJECTIVES/COLLECT_KEY";
  objective_unsetlocation(var_1, var_2);
  objective_setlocation(var_1, var_2, self.origin + (0, 0, 15));
  objective_sethot(var_1, 1);
  var_4 setHintString(var_5);
  var_4 setCursorHint("HINT_BUTTON");
  var_4 sethintdisplayrange(500);
  var_4 sethintdisplayfov(65);
  var_4 setuserange(72);
  var_4 setusefov(65);
  var_4 sethintonobstruction("show");
  var_4 setuseholdduration("duration_none");
  var_4 makeusable();
  thread key_use_think(var_4, var_0, var_1, var_2);
  return var_4;
}

function key_use_think(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_4);

    if(isDefined(var_4)) {
      if(!var_4 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      collect_jugg_key(var_0, var_1, var_2, var_3, var_4);
      scripts\cp\cp_objectives::freeworldidbyobjid(var_1);
      remove_jugg_key();
    }
  }
}

function collect_jugg_key(var_0, var_1, var_2, var_3, var_4) {
  thread play_keys_vo(level);
  level.convoy4_terminal_keys += 1;
  level notify("stop_module_" + var_3);
  objective_unsetlocation(var_1, var_2);
  var_4 thread scripts\cp\utility::playerplaypickupanim();
  thread ref_123d7();
  objective_setdescription(var_1, &"CP_QUARRY2_OBJECTIVES/CONVOY4_KEYS_1");
  scripts\cp\utility::objective_update("convoy4_keys_" + level.convoy4_terminal_keys);
}

function ref_123d7() {
  var_0 = undefined;

  switch (level.convoy4_terminal_keys) {
    case 1:
      var_0 = &"CP_QUARRY2_OBJECTIVES/KEYS_HUD_1";
      scripts\cp\utility::ref_123fe("mus_cp_smuggler_keyfound");
      break;
    case 2:
      var_0 = &"CP_QUARRY2_OBJECTIVES/KEYS_HUD_2";
      break;
    case 3:
      var_0 = &"CP_QUARRY2_OBJECTIVES/KEYS_HUD_3";
      scripts\cp\utility::ref_123fe("mus_cp_smuggler_terminal_activated");
      break;
  }

  if(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      var_2 thread scripts\cp\cp_hud_message::tutorialprint(var_0, 4);
    }

    return;
  }
}

function remove_jugg_key() {
  if(isDefined(self.jugg_obj_pos)) {
    if(isent(self.jugg_obj_pos)) {
      self.jugg_obj_pos delete();
    }

    self.jugg_obj_pos = undefined;
  }

  playFX(level._effect["equipment_smoke"], self.origin);
  self delete();
}

function spawn_map_ac130() {
  var_0 = level.players[0];
  level.convoy4_ac130 = var_0 scripts\cp\inventory\cp_ac130::spawn_ambient_ac130(var_0);
}

function activate_apache_on_player(var_0) {
  var_1 = scripts\engine\utility::getStruct("obj_apache_dir", "targetname");
  level notify("player_used_quarry_ks");
  var_0 thread scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunner();
}

function register_spawn_functions() {
  if(scripts\engine\utility::flag_exist("interactions_initialized")) {
    scripts\engine\utility::flag_wait("interactions_initialized");
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("cp_quarry2_convoy4_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_quarry2_convoy4_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_quarry2_convoy4_create_script_completed");
  wait 0.5;
  scripts\cp\coop_stealth::coop_stealth_init();
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("lbravo_spawner_p3_form_a", 0, 1, 1, 0.1, 0, "lbravo_spawner_p3_form_a", &scripts\cp\cp_modular_spawning::ref_13bac, undefined, undefined);
  [[var_0]]("lbravo_spawner_p3_form_b", 0, 1, 1, 0.1, 0, "lbravo_spawner_p3_form_b", &scripts\cp\cp_modular_spawning::ref_13bac, undefined, undefined);
  [[var_0]]("lbravo_spawner_p3_form_c", 0, 1, 1, 0.1, 0, "lbravo_spawner_p3_form_c", &scripts\cp\cp_modular_spawning::ref_13bac, undefined, undefined);
  [[var_0]]("lbravo_spawner_p3_form_d", 0, 1, 1, 0.1, 0, "lbravo_spawner_p3_form_d", &scripts\cp\cp_modular_spawning::ref_13bac, undefined, undefined);
  [[var_0]]("quarry_intro1_chopper", 5, 5, 5, 0.1, 0, "quarry_intro1_chopper", undefined, undefined, undefined);
  [[var_0]]("quarry_intro2_chopper", 4, 4, 4, 0.1, 0, "quarry_intro2_chopper", undefined, undefined, undefined);
  [[var_0]]("obj_a_roof_jugg", 1, 1, 1, 0.1, 0, "obj_a_roof_jugg", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("obj_a_roof_jugg", &ref_12926);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("obj_a_roof_jugg", undefined, 20000, 30000);
  [[var_0]]("convoy4_roof_jugg", 1, 1, 1, 0.1, 0, "convoy4_roof_jugg", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_roof_jugg", &ref_13890);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_roof_jugg", undefined, 20000, 30000);
  [[var_0]]("convoy4_roof_rpgs", 4, 6, 10, 0.1, 0, "convoy4_roof_rpgs", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_roof_rpgs", &ref_12d87);
  [[var_0]]("convoy4_01a_1", 7, 11, 40, 0.1, 0, "convoy4_01a_1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_01b_1", 7, 9, 40, 0.1, 0, "convoy4_01b_1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_01c_1", 7, 9, 40, 0.1, 0, "convoy4_01c_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_01a_1", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_01b_1", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_01c_1", &setup_manual_goalpos);
  [[var_0]]("quarry_left", 12, 12, 12, 0.25, 0, "quarry_left", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("quarry_left", &ks_pointsperkingslain);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("quarry_left", undefined, 20000, 30000);
  [[var_0]]("quarry_right", 10, 10, 10, 0.25, 0, "quarry_right", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("quarry_right", &ks_pointsperkingslain);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("quarry_right", undefined, 20000, 30000);
  [[var_0]]("quarry_fight_across", 12, 12, 12, 0.1, 0, "quarry_fight_across", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("quarry_fight_across", &ref_12956);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("quarry_fight_across", undefined, 20000, 30000);
  [[var_0]]("convoy4_snipers_1", 7, 7, 7, 0.1, 0, "convoy4_snipers_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_snipers_1", &ks_pointsperkingslain);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_snipers_1", &ks_pointkingsgetnobonus);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_snipers_1", undefined, 20000, 30000);
  [[var_0]]("mortar_guys", 4, 4, 4, 0.1, 0, "mortar_guys", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mortar_guys", &ref_1295b);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("mortar_guys", undefined, 20000, 30000);
  [[var_0]]("spawned_hostage_a", 1, 1, 1, 0.1, 0, "spawned_hostage_a", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_a", &make_civ_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_a", &scripts\cp\cp_hostage::setup_hostage_anims);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_a", &setup_hostage_fulton_anims);
  [[var_0]]("spawned_hostage_b", 1, 1, 1, 0.1, 0, "spawned_hostage_b", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_b", &make_civ_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_b", &scripts\cp\cp_hostage::setup_hostage_anims);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_b", &setup_hostage_fulton_anims);
  [[var_0]]("spawned_hostage_c", 1, 1, 1, 0.1, 0, "spawned_hostage_c", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_c", &make_civ_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_c", &scripts\cp\cp_hostage::setup_hostage_anims);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_c", &setup_hostage_fulton_anims);
  [[var_0]]("spawned_hostages_a", 5, 5, 5, 0.1, 0, "spawned_hostages_a", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_a", &scripts\cp\cp_hostage::make_hostage_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_a", &scripts\cp\cp_hostage::setup_hostage_anims);
  [[var_0]]("spawned_hostages_b", 5, 5, 5, 0.1, 0, "spawned_hostages_b", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_b", &scripts\cp\cp_hostage::make_hostage_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_b", &scripts\cp\cp_hostage::setup_hostage_anims);
  [[var_0]]("spawned_hostages_c", 5, 5, 5, 0.1, 0, "spawned_hostages_c", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_c", &scripts\cp\cp_hostage::make_hostage_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_c", &scripts\cp\cp_hostage::setup_hostage_anims);
  [[var_0]]("convoy4_02a_1_pre", 8, 8, 10, 2, 0, "convoy4_02a_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_02a_1_pre", &ref_11f52);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_02a_1_pre", &ks_pointsperkingslain);
  [[var_0]]("convoy4_02a_1", 6, 12, 200, 2, 0, "convoy4_02a_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_02a_1", &ref_11f52);
  [[var_0]]("convoy4_02b_1_pre", 4, 6, 12, 2.25, 0, "convoy4_02b_1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_02b_2_pre", 4, 8, 10, 1, 0, "convoy4_02b_2", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_02b_1", 4, [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "group_test", 28, 20], 150, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 25, 2], 0, "convoy4_02b_1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_02b_2", 4, [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "group_test", 28, 8], 250, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 25, 2], 0, "convoy4_02b_2", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_02c_1_pre", 2, 12, 36, 0.1, 0, "convoy4_02c_1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_02c_1", 2, 28, 250, 0.1, 0, "convoy4_02c_1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_02c_bomber", 1, 2, 25, 0.1, 0, "convoy4_02c_bomber", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_02c_bomber_mean", 1, 3, 25, 5, 0, "convoy4_02c_bomber_mean", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_03a_1", 1, 24, 250, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_03a_1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_03a_pre", 5, 5, 5, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_03a_2", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_03a_1", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_03a_pre", undefined, 20000, 30000);
  [[var_0]]("convoy4_04a_1", 0, 7, 50, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_04a_1", &watchforjuggstop, undefined, undefined);
  [[var_0]]("convoy4_04a_2", 0, 7, 50, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_04a_2", &watchforjuggstop, undefined, undefined);
  [[var_0]]("convoy4_04a_3", 0, 7, 50, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_04a_3", &watchforjuggstop, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_04a_1", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_04a_2", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_04a_3", &setup_manual_goalpos);
  [[var_0]]("convoy4_juggs_1", 1, 1, 1, 0.05, 0, "convoy4_juggs_1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_juggs_2", 1, 1, 1, 0.05, 0, "convoy4_juggs_2", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_juggs_3", 1, 1, 1, 0.05, 0, "convoy4_juggs_3", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_1", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_2", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_3", undefined, 20000, 30000);
  [[var_0]]("convoy4_juggs_1_backup", 1, 1, 1, 0.05, 0, "convoy4_juggs_1_backup", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_juggs_2_backup", 1, 1, 1, 0.05, 0, "convoy4_juggs_2_backup", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_juggs_3_backup", 1, 1, 1, 0.05, 0, "convoy4_juggs_3_backup", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_1_backup", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_2_backup", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_3_backup", undefined, 20000, 30000);
  [[var_0]]("convoy4_roofs_1", 8, [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "group_ending", 24, 8], 250, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_roofs_1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_roofs_2", 14, [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "group_ending", 24, 16], 250, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_roofs_2", &watchforstopwaves, undefined, undefined);
  [[var_0]]("convoy4_ending_1", 19, 19, 250, 0.5, 0, "convoy4_ending_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_roofs_1", undefined, 20000, 30000);
  [[var_0]]("juggheli_spawner_exfil", 2, 2, 2, 0.1, 0, "juggheli_spawner_exfil", &scripts\cp\cp_modular_spawning::disable_kill_off, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("juggheli_spawner_exfil", undefined, 20000, 30000);
  [[var_0]]("convoy4_the_smuggler", 1, 1, 1, 0.05, 0, "convoy4_the_smuggler", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_the_smuggler", undefined, 20000, 30000);
  [[var_0]]("techo_phys_quarry1", 3, 6, 6, 0.1, 0, "techo_phys_quarry1", undefined, undefined, undefined);
  [[var_0]]("techo_phys_quarry2", 3, 6, 6, 0.1, 0, "techo_phys_quarry2", undefined, undefined, undefined);
  [[var_0]]("techo_phys_quarry3", 3, 6, 6, 0.1, 0, "techo_phys_quarry3", undefined, undefined, undefined);
  [[var_0]]("techo_phys_quarry4", 3, 6, 6, 0.1, 0, "techo_phys_quarry4", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("wave_spawning", &ref_11e4f);
  [[var_0]]("cover_guys_debug", 1, 1, 50, 0.1, 0, "cover_guys_debug", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("cover_guys_debug", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("cover_guys_debug", &spawn_in_cover);
}

function ref_11e4f(var_0) {
  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    self.never_kill_off = 1;
    self.dont_kill_off = 1;
    return;
  }
}

function ref_1295b(var_0) {
  ref_1295c(var_0);
}

function ref_1295c(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\common\utility::demeanor_override("sprint");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    self.goalheight = 512;
    var_1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
    var_2 = getgroundposition(var_1.origin, 16) + (0, 0, 8);
    self.script_origin_other = var_2;
    scripts\cp\cp_modular_spawning::set_goal_pos(var_2);

    if(isDefined(var_1.radius)) {
      scripts\cp\cp_modular_spawning::set_goal_radius(var_1.radius);
    }

    thread blueprintextract_beforepickupspawned("stop_mortars");
    level waittill("stop_mortars");
    self.dont_kill_off = 0;
    self.never_kill_off = 0;
    self.script_origin_other = undefined;
    scripts\cp\cp_modular_spawning::set_goal_radius(1000);
    return;
  }
}

function ref_12956(var_0) {
  thread ks_pointsperkingslain(var_0);
  thread blueprintextract_beforepickupspawned("quarry_right_spawned", "quarry_right_spawned", "started_hack_at_a");
  thread ref_12957();
}

function ref_12957() {
  self endon("death");
  level endon("game_ended");
  wait 1;
  scripts\common\utility::demeanor_override("cqb");

  foreach(var_1 in level.players) {
    if(!var_1 scripts\cp\utility::is_valid_player() || !var_1 isonground()) {
      continue;
    }

    self getenemyinfo(var_1);
  }

  var_3 = randomintrange(15, 20);

  while(var_3 > 0) {
    if(scripts\cp\utility::any_player_nearby(self.origin, 640000)) {
      break;
    }

    wait 1;
    var_3 -= 1;
  }

  scripts\common\utility::demeanor_override("combat");
}

function ks_pointkingsgetnobonus(var_0) {
  thread blueprintextract_beforepickupspawned("quarry_left_spawned", "quarry_right_spawned");
}

function ks_pointsperkingslain(var_0) {
  setup_manual_goalpos(var_0);
  thread blueprintextract_beforepickupspawned("started_hack_at_a");
}

function blueprintextract_beforepickupspawned(var_0, var_1, var_2) {
  self endon("death");
  level endon("game_ended");
  var_3 = 20;

  if(!isDefined(var_1)) {
    var_1 = "forever";
  }

  if(!isDefined(var_2)) {
    var_2 = "forever";
  }

  level scripts\engine\utility::ref_143a6(var_0, var_1, var_2);

  while(scripts\cp\cp_modular_spawning::has_seen_any_player_recently()) {
    var_3 -= 0.25;
    wait 0.25;

    if(scripts\cp\utility::any_player_nearby(self.origin, 360000)) {
      return;
    }

    if(var_3 <= 0) {
      return;
    }
  }

  scripts\cp\cp_modular_spawning::script_kill_ai();
}

function watchforstopwaves(var_0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var_0) {
  level endon("game_ended");
  level waittill("end_wave_convoy4_spawners");
  level notify("spawn_module_" + var_0.moduleid + "_completed");
}

function stopwaveandstartthisone(var_0) {
  level notify("end_wave_convoy4_spawners");
  wait 0.5;
  [[var_0]]();
}

function watchforjuggstop(var_0) {
  level endon("game_ended");
  thread _watchforjuggstop(level);
}

function ref_11f52(var_0) {
  if(!isDefined(level.ref_11f54)) {
    return;
  }

  var_1 = "cpu_hacking_done";
  thread bomb_label(level.ref_11f54, var_1);
  thread ref_11f55(var_1);
}

function bomb_label(var_0, var_1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(var_1)) {
    level endon(var_1);
  }

  var_2 = printdata(var_0);
  thread bomb_plant_allowed(var_2);

  for(;;) {
    scripts\common\utility::demeanor_override("sprint");
    var_3 = getclosestpointonnavmesh(var_2.origin);
    var_4 = var_2.radius;
    self.script_origin_other = var_3;
    scripts\cp\cp_modular_spawning::set_goal_pos(var_3);
    scripts\cp\cp_modular_spawning::set_goal_radius(var_4);
    wait 2;
  }
}

function bomb_on_vehicle_clean_up_monior(var_0) {
  var_0 notify("ai_goal_distribution_debug");
  var_0 endon("ai_goal_distribution_debug");

  for(;;) {
    var_1 = var_0.origin;
    var_2 = var_0.radius;
    level thread scripts\engine\utility::draw_circle(var_1, var_2, (1, 1, 0), 0.5, 0, 20);

    if(isDefined(var_0.ref_127ea) && var_0.ref_127ea.size) {
      foreach(var_4 in var_0.ref_127ea) {
        if(isDefined(var_4) && isai(var_4) && isalive(var_4)) {
          var_5 = var_4 getentitynumber();

          if(!isDefined(var_5)) {
            var_5 = "agent";
          }
        }
      }
    }

    wait 1;
  }
}

function bomb_plant_allowed(var_0) {
  handlemeleekillsteelballs(var_0);
  var_0.ref_127ea[var_0.ref_127ea.size] = self;
  self waittill("death");
  handlemeleekillsteelballs(var_0);
}

function printdata(var_0) {
  var_1 = var_0[0];
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_0[var_3];

    if(isDefined(var_4.script_count_max) && int(var_4.script_count_max) <= var_4.ref_127ea.size) {
      if(var_1 == var_4 && var_3 < var_0.size - 1) {
        var_1 = var_0[var_3 + 1];
      }

      continue;
    } else {
      var_2 = var_4;
    }

    if(var_1.ref_127ea.size > var_4.ref_127ea.size) {
      var_1 = var_4;
    }
  }

  return var_1;
}

function ref_11f55(var_0) {
  self endon("death");
  level endon("game_ended");
  level waittill(var_0);
  wait 1;
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_pos(scripts\engine\utility::random(level.players).origin);
  scripts\cp\cp_modular_spawning::set_goal_radius(500);
}

function handlemeleekillsteelballs(var_0) {
  var_1 = [];

  foreach(var_3 in var_0.ref_127ea) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_1 = var_3;
    }
  }

  var_0.ref_127ea = var_1;
}

function ref_12926(var_0) {
  thread ref_12927(var_0);
}

function isplayerinsiderectangularzonebasedonent() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    wait 0.1;
  }
}

function ref_12927(var_0) {
  level endon("game_ended");
  self endon("death");
  scripts\cp\cp_modular_spawning::set_goal_pos(self.script_origin_other);
  scripts\cp\cp_modular_spawning::set_goal_radius(32);
  ref_143cf(1);
  level waittill("cpu_hacking_done");
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(2048);
  var_1 = scripts\cp\utility::get_closest_living_player(16000000);

  if(isDefined(var_1)) {
    self setgoalpos(var_1.origin);
    return;
  }
}

function ref_143cf(var_0) {
  for(;;) {
    level waittill("start_hacking_comms_laptop", var_1);

    if(isDefined(var_1) && isDefined(level.ref_12958) && level.ref_12958 == var_0) {
      break;
    }

    wait 0.05;
  }
}

function ref_12d87(var_0) {
  thread ref_12d88(var_0);
}

function ref_12d88(var_0) {
  self endon("death");
  level endon("game_ended");
  wait 0.5;
  thread scripts\common\utility::demeanor_override("sprint");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    var_1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");

    if(isDefined(var_1)) {
      self.script_origin_other = var_1.origin;
      scripts\cp\cp_modular_spawning::set_goal_radius(64);
    }
  } else {
    self.script_origin_other = self.origin;
    scripts\cp\cp_modular_spawning::set_goal_radius(128);
  }

  level waittill("started_hack_at_a");
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(2048);
  var_2 = scripts\cp\utility::get_closest_living_player();

  if(isDefined(var_2)) {
    self setgoalpos(var_2.origin);
    return;
  }
}

function ref_13890(var_0) {
  thread ref_13891(var_0);
  thread ref_14409();
}

function ref_14409() {
  level endon("game_ended");
  self endon("death");
  level waittill("started_hack_at_b");
  self.ref_14409 = 1;
}

function ref_13891(var_0) {
  level endon("game_ended");
  self endon("death");
  scripts\cp\cp_modular_spawning::set_goal_radius(52);

  while(!istrue(self.ref_14409)) {
    wait 1;
    var_1 = 650;
    var_2 = 64;
    var_3 = scripts\cp\utility::get_closest_living_player(var_1 * var_1);

    if(isDefined(var_3) && abs(self.origin[2] - var_3.origin[2]) < var_2) {
      break;
    }

    if(isDefined(self.maxhealth) && self.health < self.maxhealth / 2) {
      break;
    }
  }

  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(2048);

  for(;;) {
    var_4 = scripts\cp\utility::get_closest_living_player();

    if(isDefined(var_4)) {
      self setgoalpos(var_4.origin);
    }

    wait 10;
  }
}

function _watchforjuggstop(var_0) {
  level endon("game_ended");
  level endon("stop_watching_jugg_modules");
  var_1 = var_0.group_name;
  level waittill("stop_module_" + var_1);
  level notify("spawn_module_" + var_0.moduleid + "_completed");
}

function spawn_soldiers_switch_01() {
  level thread scripts\cp\cp_wave_spawning::killstreaks(1, "smugg_p3_hack1");
  level.convoy4_module_02a_pre = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_02a_1_pre");
  level waittill("start_hacking_comms_laptop");
  level notify("end_wave_convoy4_spawners");
  scripts\cp\cp_spawning_util::ref_13bbd(0);
  wait 0.5;
  level.convoy4_module_02a = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_02a_1");
}

function spawn_soldiers_switch_02() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
  level.convoy4_module_02b_pre = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_02b_1_pre");
  level.convoy4_module_02b2_pre = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_02b_2_pre");
  level waittill("start_hacking_comms_laptop");
  level notify("end_wave_convoy4_spawners");
  level thread scripts\cp\cp_wave_spawning::killstreaks(0.1, "smugg_p3_hack1");
  wait 1;
  level.convoy4_module_02b = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_02b_1");
  level.convoy4_module_02b2 = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_02b_2");
}

function spawn_soldiers_switch_03() {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
  level.convoy4_module_02c_pre = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_02c_1_pre");
  level waittill("start_hacking_comms_laptop");
  level notify("end_wave_convoy4_spawners");
  wait 0.5;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("convoy4_02c_1_pre");
  level thread scripts\cp\cp_wave_spawning::killstreaks(0.5, "smugg_p3_hack3_bomber");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("wave_spawning", &waittill_all_valid_ai_are_gone);
}

function spawn_soldiers_attack_tower() {
  level notify("end_wave_convoy4_spawners");
  wait 0.5;
  level.convoy4_module_03a = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_03a_1");
  level.convoy4_module_03b = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_03a_pre");
}

function spawn_soldiers_juggs() {
  level notify("end_wave_convoy4_spawners");
  wait 0.5;
  level.convoy4_module_juggs_1 = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_juggs_1");
  level.convoy4_module_juggs_2 = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_juggs_2");
  level.convoy4_module_juggs_3 = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_juggs_3");
  wait 3;
  level.convoy4_module_04a_1 = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_04a_1");
  level.convoy4_module_04a_2 = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_04a_2");
  level.convoy4_module_04a_3 = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_04a_3");
}

function spawn_soldiers_rooftops() {
  level notify("end_wave_convoy4_spawners");
  wait 1;
  level.convoy4_module_roofs = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_roofs_1");
  level.convoy4_module_roofs2 = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_roofs_2");
}

function spawn_soldiers_ending() {
  level notify("end_wave_convoy4_spawners");
  wait 1;
  level.convoy4_module_roofs2 = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_ending_1");
}

function setup_manual_goalpos(var_0, var_1) {
  self notify("basic_combat");
  var_2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var_2);

  switch (var_0.group_name) {
    case "quarry_right":
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      break;
    case "convoy4_01c_1":
    case "convoy4_01b_1":
    case "convoy4_01a_1":
      scripts\cp\cp_modular_spawning::set_goal_radius(1000);
      self.goalheight = 1024;
      break;
    case "convoy4_04a_3":
    case "convoy4_04a_2":
    case "convoy4_04a_1":
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      self.goalheight = 128;
      break;
    case "convoy4_snipers_1":
      scripts\cp\cp_modular_spawning::set_goal_radius(384);
      self.goalheight = 128;
      self.sightmaxdistance = 2200;
      thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
      break;
    case "convoy4_roof_jugg":
      scripts\cp\cp_modular_spawning::set_goal_radius(64);
      self.goalheight = 128;
      break;
  }
}

function initcommslaptop(var_0) {}

function hintcommslaptop(var_0, var_1) {
  if(istrue(level.convoy4_comms_laptop_int_struct.laptopactive)) {
    return &"CP_OBJECTIVES/HACK";
  }

  return "";
}

function hintcalltraininteract(var_0, var_1) {
  if(!istrue(level.obj_allow_call_train)) {
    return "";
  }

  var_2 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_USE_0";

  switch (level.obj_call_train_count) {
    case 0:
      var_2 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_USE_0";
      break;
    case 1:
      var_2 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_USE_1";
      break;
    case 2:
      var_2 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_USE_2";
      break;
    case 8:
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
      var_2 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_USE_3";
      break;
  }

  return var_2;
}

function initcalltraininteract(var_0) {
  level.obj_call_train_count = 0;

  foreach(var_2 in var_0) {
    var_2.p_ent_skip_fov = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var_2);
  }
}

function activationcalltraininteract(var_0, var_1) {
  if(!istrue(level.obj_allow_call_train)) {
    return;
  }

  level.obj_call_train_count++;
  scripts\cp\utility::playsoundatpos_safe(var_0.origin, "cp_quarry_train_call_0" + level.obj_call_train_count);
  var_2 = hintcalltraininteract(var_0, var_1);
  scripts\cp\coop_personal_ents::update_pent_hintstring(var_0, var_2);
  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();

  if(level.obj_call_train_count >= 3) {
    var_0.disabled = 1;
    level.obj_allow_call_train = 0;
    level.tracking_hints_calltrain = undefined;
    scripts\cp\coop_personal_ents::delayed_remove_peent_interaction(var_0);
    level.obj_called_train = 1;
    level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_kama_quarry2_keys_obtained_10");
    level notify("obj_called_train");
    return;
  }
}

function ref_124d2() {
  level endon("game_ended");
  level endon("start_hacking_comms_laptop");
  level endon("player_triggered_obit");
  var_0 = scripts\engine\utility::getStruct("quarry_obit", "targetname");
  var_1 = 10000;

  for(;;) {
    var_2 = scripts\cp\utility::give_all_players_nearby(var_0.origin, var_1);

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(var_2[var_3] getclantag() == "egan") {
        thread ref_1436b(var_2[var_3], var_0.origin);
      }
    }

    wait 5;
  }
}

function ref_1436b(var_0, var_1) {
  level endon("player_triggered_obit");
  self endon("death_or_disconnect");

  if(istrue(self.ref_13c51)) {
    return;
  }

  self.ref_13c51 = 1;
  var_2 = 0;

  for(;;) {
    if(distance2dsquared(self.origin, var_0) > var_1) {
      self.ref_13c51 = undefined;
      return;
    }

    if(var_2 > 60) {
      thread ref_11f51();
      return;
    }

    wait 1;
    var_2 += 1;
  }
}

function ref_11f51() {
  level notify("player_triggered_obit");
  var_0 = getEnt("obit_model", "targetname");
  var_0 makeusable();
  var_0 setCursorHint("HINT_BUTTON");
  var_0 sethintdisplayrange(265);
  var_0 sethintdisplayfov(80);
  var_0 setuserange(95);
  var_0 setusefov(35);
  var_0 sethintonobstruction("show");
  var_0 setuseholdduration("duration_long");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1)) {
      if(!var_1 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      var_1 playlocalsound("grenade_pickup");
      thread ref_11f4f(level);
      var_0 makeunusable();
    }
  }
}

function ref_11f4f(var_0) {
  var_1 = &ref_135a7;
  var_2 = [];
  var_2 = [[[var_1]]((7488, -11168, 224), (0, 267.5, 0)), [[var_1]]((7488, -11120, 224), (0, 267.5, 0)), [[var_1]]((7504, -11120, 224), (0, 267.5, 0)), [[var_1]]((7472, -11120, 224), (0, 267.5, 0)), [[var_1]]((7536, -11120, 224), (0, 267.5, 0)), [[var_1]]((7552, -11120, 224), (0, 267.5, 0)), [[var_1]]((7568, -11120, 224), (0, 267.5, 0)), [[var_1]]((7568, -11144, 224), (0, 267.5, 0)), [[var_1]]((7536, -11144, 224), (0, 267.5, 0)), [[var_1]]((7536, -11168, 224), (0, 267.5, 0)), [[var_1]]((7552, -11168, 224), (0, 267.5, 0)), [[var_1]]((7568, -11168, 224), (0, 267.5, 0)), [[var_1]]((7608, -11120, 224), (0, 267.5, 0)), [[var_1]]((7608, -11144, 224), (0, 267.5, 0)), [[var_1]]((7608, -11168, 224), (0, 267.5, 0)), [[var_1]]((7624, -11136, 224), (0, 267.5, 0)), [[var_1]]((7640, -11144, 224), (0, 267.5, 0)), [[var_1]]((7656, -11136, 224), (0, 267.5, 0)), [[var_1]]((7672, -11120, 224), (0, 267.5, 0)), [[var_1]]((7672, -11144, 224), (0, 267.5, 0)), [[var_1]]((7672, -11168, 224), (0, 267.5, 0)), [[var_1]]((7448, -11208, 224), (0, 267.5, 0)), [[var_1]]((7464, -11200, 224), (0, 357.5, 0)), [[var_1]]((7520, -11232, 224), (0, 267.5, 0)), [[var_1]]((7448, -11232, 224), (0, 267.5, 0)), [[var_1]]((7448, -11256, 224), (0, 267.5, 0)), [[var_1]]((7464, -11264, 224), (0, 357.5, 0)), [[var_1]]((7528, -11256, 224), (0, 327.5, 0)), [[var_1]]((7464, -11232, 224), (0, 357.5, 0)), [[var_1]]((7524, -11208, 224), (0, 252.5, 0)), [[var_1]]((7552, -11252, 224), (0, 222.5, 0)), [[var_1]]((7560, -11232, 224), (0, 177.5, 0)), [[var_1]]((7540, -11196, 224), (0, 182.5, 0)), [[var_1]]((7600, -11248, 224), (0, 267.5, 0)), [[var_1]]((7608, -11224, 224), (0, 267.5, 0)), [[var_1]]((7616, -11200, 224), (0, 267.5, 0)), [[var_1]]((7632, -11224, 224), (0, 267.5, 0)), [[var_1]]((7640, -11248, 224), (0, 267.5, 0)), [[var_1]]((7616, -11232, 224), (0, 357.5, 0)), [[var_1]]((7672, -11248, 224), (0, 267.5, 0)), [[var_1]]((7672, -11224, 224), (0, 267.5, 0)), [[var_1]]((7680, -11208, 224), (0, 282.5, 0)), [[var_1]]((7688, -11232, 224), (0, 282.5, 0)), [[var_1]]((7696, -11248, 224), (0, 282.5, 0)), [[var_1]]((7712, -11248, 224), (0, 267.5, 0)), [[var_1]]((7712, -11224, 224), (0, 267.5, 0)), [[var_1]]((7712, -11200, 224), (0, 267.5, 0)), [[var_1]]((7352, -11304, 224), (0, 267.5, 0)), [[var_1]]((7352, -11328, 224), (0, 267.5, 0)), [[var_1]]((7352, -11352, 224), (0, 267.5, 0)), [[var_1]]((7352, -11376, 224), (0, 267.5, 0)), [[var_1]]((7392, -11320, 224), (0, 267.5, 0)), [[var_1]]((7424, -11320, 224), (0, 267.5, 0)), [[var_1]]((7408, -11312, 224), (0, 192.5, 0)), [[var_1]]((7408, -11344, 224), (0, 327.5, 0)), [[var_1]]((7424, -11344, 224), (0, 267.5, 0)), [[var_1]]((7424, -11368, 224), (0, 267.5, 0)), [[var_1]]((7456, -11320, 224), (0, 267.5, 0)), [[var_1]]((7456, -11344, 224), (0, 267.5, 0)), [[var_1]]((7472, -11352, 224), (0, 297.5, 0)), [[var_1]]((7488, -11368, 224), (0, 267.5, 0)), [[var_1]]((7472, -11384, 224), (0, 177.5, 0)), [[var_1]]((7472, -11312, 224), (0, 267.5, 0)), [[var_1]]((7488, -11312, 224), (0, 267.5, 0)), [[var_1]]((7528, -11304, 224), (0, 177.5, 0)), [[var_1]]((7536, -11312, 224), (0, 282.5, 0)), [[var_1]]((7544, -11336, 224), (0, 267.5, 0)), [[var_1]]((7528, -11344, 224), (0, 177.5, 0)), [[var_1]]((7544, -11360, 224), (0, 267.5, 0)), [[var_1]]((7528, -11376, 224), (0, 357.5, 0)), [[var_1]]((7584, -11352, 224), (0, 177.5, 0)), [[var_1]]((7608, -11352, 224), (0, 177.5, 0)), [[var_1]]((7632, -11304, 224), (0, 267.5, 0)), [[var_1]]((7664, -11304, 224), (0, 267.5, 0)), [[var_1]]((7680, -11328, 224), (0, 267.5, 0)), [[var_1]]((7656, -11344, 224), (0, 222.5, 0)), [[var_1]]((7632, -11368, 224), (0, 267.5, 0)), [[var_1]]((7656, -11376, 224), (0, 177.5, 0)), [[var_1]]((7680, -11376, 224), (0, 177.5, 0)), [[var_1]]((7720, -11320, 224), (0, 267.5, 0)), [[var_1]]((7736, -11304, 224), (0, 267.5, 0)), [[var_1]]((7760, -11320, 224), (0, 267.5, 0)), [[var_1]]((7760, -11344, 224), (0, 267.5, 0)), [[var_1]]((7720, -11344, 224), (0, 267.5, 0)), [[var_1]]((7728, -11368, 224), (0, 267.5, 0)), [[var_1]]((7752, -11368, 224), (0, 267.5, 0)), [[var_1]]((7792, -11304, 224), (0, 267.5, 0)), [[var_1]]((7792, -11328, 224), (0, 267.5, 0)), [[var_1]]((7792, -11352, 224), (0, 267.5, 0)), [[var_1]]((7792, -11376, 224), (0, 267.5, 0)), [[var_1]]((7864, -11304, 224), (0, 267.5, 0)), [[var_1]]((7856, -11328, 224), (0, 267.5, 0)), [[var_1]]((7848, -11352, 224), (0, 267.5, 0)), [[var_1]]((7840, -11376, 224), (0, 267.5, 0)), [[var_1]]((7848, -11296, 224), (0, 177.5, 0)), [[var_1]]((7832, -11296, 224), (0, 177.5, 0))];
  level.breakerstate = [];

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    level.breakerstate[level.breakerstate.size] = thread ref_135a6(var_2[var_3]);
    wait 0.25;
  }

  wait 30;

  for(var_3 = 0; var_3 < level.breakerstate.size; var_3++) {
    level.breakerstate[var_3] delete();
    wait 0.25;
  }
}

function ref_135a7(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = var_1;
  return var_2;
}

function ref_135a6(var_0) {
  var_1 = spawn("script_model", var_0 + self.origin + (-7500, 11182, 512));
  var_1 setModel("toy_teddy_bear_01_brown");

  if(isDefined(self.angles)) {
    var_1.angles = self.angles;
  }

  return var_1;
}

function ref_11f50() {
  var_0 = scripts\engine\utility::getStruct("quarry_obit", "targetname");
  var_1 = vehicle_getarray();
  var_2 = 2250000;

  foreach(var_4 in var_1) {
    if(distance2dsquared(var_4.origin, var_0.origin) < var_2) {
      if(isDefined(var_4.spawndata) && var_4.birthtime < gettime() - 20000) {
        scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(var_4);
      }
    }

    wait 0.1;
  }
}

function ref_131f0() {
  scripts\cp\utility::skydivestreamhintdvars("quarry");
}

function ref_131f1() {
  scripts\cp\utility::skydivestreamhintdvars("quarry_deep");
}

function setup_enemy_sentries(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 1:
      var_1 = "spawner_quarry_1";
      break;
    case 2:
      var_1 = "spawner_quarry_2";
      break;
    case 3:
      var_1 = "spawner_quarry_3";
      break;
    case 4:
      var_1 = "spawner_quarry_4";
      break;
    case 5:
      var_1 = "spawner_quarry_5";
      break;
  }

  if(isDefined(var_1)) {
    level.initlocationcircle = var_1;
    level.initlethalmaxoffsetmap = var_1;
    return;
  }
}

function ref_130a8() {
  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340d(2, 1, 1);
  }

  wait 2;

  foreach(var_1 in level.players) {
    var_4 = scripts\engine\utility::getStruct("camera_ending", "targetname");
    var_5 = var_4.origin;
    var_6 = scripts\engine\utility::getStruct(var_4.target, "targetname");
    var_7 = spawn("script_model", var_5);
    var_7 setModel("tag_origin");
    var_7.angles = var_4.angles;
    var_7 moveTo(var_6.origin, 20, 1, 1);
    var_1 playerhide();
    var_1 allowfire(0);
    var_1 disableoffhandweapons();
    var_1 disableusability();
    var_1 allowmovement(0);
    var_1 setclientomnvar("ui_hide_hud", 1);
    spawn_endgame_camera(var_1, var_7);
    var_1 lerpfovscalefactor(0, 0);
  }
}

function spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "tag_origin", 1);
  self setclientdvar("LQKPQMPRQN", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("QTSPTNLOL", "50");
    return;
  }
}

function setup_hostage_fulton_anims(var_0, var_1) {
  thread thread_hostage_fulton_anims();
}

function thread_hostage_fulton_anims() {
  level scripts\cp\cp_hostage::anim_init_hostage();
  level waittill("gotten_to_extract");
  thread scripts\cp\cp_hostage::anim_fulton_hostage_player_scene(self);
}

function play_vo_delay(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4)) {
    wait var_4;
  }

  if(isDefined(var_0)) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team(var_0, "allies", var_3, var_5, var_6);
  }

  if(isDefined(var_1)) {
    wait var_1;
  }

  if(isDefined(var_2)) {
    level thread scripts\cp\utility::cp_add_dialogue_line(var_2);
    return;
  }
}

function vo_length(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 /= 1000;
  return var_1;
}

function play_intro_vo() {
  level endon("stop_searching_vo");
  wait 5;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12409("lass");
  play_vo_delay(level, "dx_cps_lass_quarry2_mission_intro_10");
  wait 1.5;
  play_vo_delay(level, "dx_cps_kama_quarry2_brief_10");
  wait 0.75;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(undefined, "conv_generic_affirm");
}

function play_hacks_interact_vo() {
  level waittill("start_hacking_comms_laptop");
  wait 2;
  thread play_vo_delay(level, "dx_cps_kama_quarry2_hacking_10", undefined);
  level waittill("players_near_hack_b");
  thread play_vo_delay(level, "dx_cps_lass_quarry2_soldiers_roof_10", undefined);
}

function handle_players_near_hack_b(var_0, var_1) {
  level endon("game_ended");
  var_2 = var_1 * var_1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_2)) {
      break;
    }

    wait 0.15;
  }

  level notify("players_near_hack_b");
}

function handle_remind_hack() {
  level notify("convoy4_tracking_hack_nags");
  level endon("convoy4_tracking_hack_nags");
  level endon("game_ended");
  level endon("cpu_hacking_done");
  level waittill("start_hacking_comms_laptop");
  var_0 = 0.25;
  var_1 = 0.1;

  for(;;) {
    if(!istrue(level.i_see_player_shield_watcher)) {
      return;
    }

    var_2 = 0;

    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      if(istrue(level.players[var_3].inhackring)) {
        var_2++;
      }
    }

    if(var_2 <= 1) {
      var_1 += var_0;
    }

    if(var_1 > 15) {
      thread play_nag_hack_vo();
      var_1 = 0.1;
    }

    wait var_0;
  }
}

function play_nag_hack_vo() {
  var_0 = ["dx_cps_kama_quarry2_nag_stay_on_hack_10", "dx_cps_kama_quarry2_nag_stay_on_hack_20"];
  thread play_vo_delay(level);
}

function play_hack_vo(var_0) {
  if(!isDefined(level.convoy4_vo_hacks)) {
    level.convoy4_vo_hacks = 0;
  }

  if(level.convoy4_vo_hacks == 0) {
    play_vo_delay(level, "dx_cps_kama_quarry2_one_hack_down_10", undefined, undefined);
    thread ref_123f0();
  } else if(level.convoy4_vo_hacks == 1) {
    play_vo_delay(level, "dx_cps_kama_quarry2_two_hacks_down_10", undefined, undefined);
    thread ref_123f1();
  } else if(level.convoy4_vo_hacks == 2) {
    level.convoy4_vo_hacks = undefined;
    var_1 = var_0 scripts\cp\utility::get_closest_living_player();
    scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_1, "obj_sitrep_success");
    play_vo_delay(level, "dx_cps_kama_quarry2_final_hack_down_10");
  }

  if(isDefined(level.convoy4_vo_hacks)) {
    level.convoy4_vo_hacks += 1;
    return;
  }
}

function ref_123f0() {
  level endon("game_ended");
  level endon("start_hacking_comms_laptop");
  wait 20;
  thread play_vo_delay(level);
}

function ref_123f1() {
  level endon("game_ended");
  level endon("start_hacking_comms_laptop");
  wait 20;
  thread play_vo_delay(level);
}

function play_keys_intro_vo() {
  play_vo_delay(level, "dx_cps_lass_quarry2_controls_locked_10");
  wait 0.75;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(undefined, "conv_generic_affirm");
}

function play_keys_vo(var_0) {
  if(!isDefined(level.convoy4_vo_keys)) {
    level.convoy4_vo_keys = 0;
  }

  if(level.convoy4_vo_keys == 0) {
    thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_0, "obj_collect_first");
    thread play_vo_delay(level, "dx_cps_kama_quarry2_two_keys_left_10", undefined, undefined, undefined);
  } else if(level.convoy4_vo_keys == 1) {
    thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_0, "obj_collect_another");
    thread play_vo_delay(level, "dx_cps_kama_quarry2_one_key_left_10", undefined, undefined, undefined);
  } else if(level.convoy4_vo_keys == 2) {
    thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_0, "obj_collect_complete");
    level.convoy4_vo_keys = undefined;
    thread play_final_key_vo();
  }

  if(isDefined(level.convoy4_vo_keys)) {
    level.convoy4_vo_keys += 1;
    return;
  }
}

function play_final_key_vo() {
  level endon("game_ended");
  level endon("obj_called_train");
  play_vo_delay(level, "dx_cps_kama_quarry2_keys_obtained_10");
  wait 0.75;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(undefined, "conv_generic_affirm");
  thread play_vo_delay(level, "dx_cps_kama_quarry2_keys_obtained_10", undefined, undefined, 1, undefined);
}

function play_cargo_intro() {
  thread play_cargo_train_stopped();
  level waittill("activate_near_apache");
  thread play_vo_delay(level, "dx_cps_kama_quarry2_train_10", undefined);
}

function play_cargo_train_stopped() {
  level endon("game_ended");
  level waittill("convoy4_train_stopped");
  thread play_vo_delay(level, "dx_cps_lass_quarry2_train_20", undefined);
}

function play_cargo_c4_nags() {
  level endon("game_ended");
  level endon("all_c4_placed");

  for(;;) {
    thread play_vo_delay(level);
    wait randomfloatrange(20, 30);
  }
}

function ref_1241e() {
  thread play_vo_delay(level);
}

function ref_123e3(var_0) {
  level endon("game_ended");
  level.obj_got_extract = 1;
  wait 0.5;
  thread play_vo_delay(level, "dx_cps_lass_quarry2_extraction_10", undefined);
  wait 90;
  thread play_vo_delay(level, "dx_cps_lass_quarry2_player_fulton_release_10", undefined);
  wait 75;
  thread play_vo_delay(level, "dx_cps_lass_quarry2_extraction_20", undefined);
  wait 18;
  var_1 = 0;
  var_2 = level.players.size;

  foreach(var_4 in level.players) {
    if(!istrue(var_4.used_fulton_interact)) {
      var_1++;
      level thread scripts\cp\cp_vo::try_to_play_vo_for_one_player("dx_cps_lass_quarry2_extraction_30", var_4, 0);
    }
  }

  if(var_2 == var_1) {
    level notify("convoy4_extraction_failed");
    objective_state(var_0, "failed");
    level.i_see_player_vehicle_watcher = 1;
    wait 3;
    scripts\cp\cp_objectives::ref_12868("convoy4_extraction");
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    return;
  }
}

function ref_1240e(var_0) {
  level endon("game_ended");
  level endon("players_fultoned");
  var_1 = 14400;

  for(;;) {
    var_2 = var_0 scripts\cp\utility::get_closest_living_player(var_1);

    if(isDefined(var_2)) {
      break;
    }

    wait 1;
  }

  level notify("players_near_exfil");
  level thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_2, "obj_holding");
  thread ref_12dfa();
  thread ref_12de8();
}

function ref_12de8() {
  level.vehicle_occupancy_getteamfriendlyto = scripts\cp\cp_modular_spawning::run_spawn_module("juggheli_spawner_exfil");
  thread ref_138bd(level, 60);
}

function ref_12dfa() {
  thread ref_12dd5(level);
  wait randomfloatrange(10, 15);
  thread ref_12dd5(level);
  wait randomfloatrange(10, 15);
  thread ref_12dd5(level);
}

function ref_138bd(var_0, var_1) {
  wait var_0;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_1);
}

function ref_12dd5(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_0);

  if(isDefined(var_1.module_vehicles[0]) && isent(var_1.module_vehicles[0])) {
    var_2 = var_1.module_vehicles[0];
    thread ref_14350();
    return;
  }
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

function play_outro_vo() {
  wait 1.8;
  play_vo_delay(level, "dx_cps_kama_quarry2_extraction_40", undefined, undefined);
  wait 0.25;
  play_vo_delay(level, "dx_cps_lass_quarry2_mission_success_10", undefined, undefined);
}

function play_hack_alarms() {
  level endon("game_ended");
  level waittill("start_hacking_comms_laptop", var_0);
  var_1 = scripts\engine\utility::getStruct("obj_alarm_struct", "targetname");
  thread play_alarm_pos(level);
}

function play_alarm_pos(var_0) {
  if(isDefined(level.obj_alarm)) {
    level notify("obj_alarm_trigger");
    level.obj_alarm stoploopsound();
    level.obj_alarm delete();
    waitframe();
  }

  level.obj_alarm = scripts\engine\utility::spawn_tag_origin(var_0, (0, 0, 0));
  level.obj_alarm show();
  wait 1;
  level.obj_alarm playLoopSound("cp_quarry_alarm_hot_01");
  level waittill("obj_alarm_trigger");
  level.obj_alarm stoploopsound();
  waitframe();
  var_1 = lookupsoundlength("cp_quarry_alarm_off_01");
  var_1 /= 1000;

  for(var_2 = 0; var_2 < 6; var_2++) {
    level.obj_alarm playSound("cp_quarry_alarm_off_01");
    wait var_1;
  }

  level.obj_alarm delete();
}

function his_respawn(var_0) {
  level endon("game_ended");

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = getscriptablearrayinradius("model_hackcrate", "targetname", var_0.origin, 1000);

  if(!isDefined(var_1)) {
    return;
  }

  if(var_1.size == 0) {
    return;
  }

  var_2 = var_1[0];
  var_2 setscriptablepartstate("main", "off");
}

function computer_animation(var_0) {
  level endon("game_ended");

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = getscriptablearrayinradius("model_hackcrate", "targetname", var_0.origin, 1000);

  if(!isDefined(var_1)) {
    return;
  }

  if(var_1.size == 0) {
    return;
  }

  var_2 = var_1[0];
  var_2 setscriptablepartstate("main", "on");
  level waittill("cpu_hacking_done");
  var_2 setscriptablepartstate("main", "off");
}

function debug_start_hostages(var_0) {
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc");
}

function debug_start_switches(var_0) {
  wait 0.5;
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc2");
}

function debug_start_terminal(var_0) {
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc3");
}

function debug_start_keys(var_0) {
  wait 0.5;
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc4");
}

function debug_start_call(var_0) {
  wait 0.5;
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc4");
}

function debug_start_waittrain(var_0) {
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc5");
}

function debug_start_extraction(var_0) {
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc5");
}

function teleportstructs_threadedwait(var_0, var_1) {
  scripts\engine\utility::flag_wait(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", var_1, 1);
}

function player_equipment_use_stop() {
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("infil_complete");
  waitframe();
  var_0 = (29097, 33602, 496);
  var_1 = getnodesinradius(var_0, 30, 0, 128);

  foreach(var_3 in var_1) {
    var_3 disconnectnode();
  }
}

function israndomnoattachmentloadouts() {
  while(getdvarint("scr_testbadquarrycover", 0) == 0) {
    wait 1;
  }

  wait 1;
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("infil_complete");
  waitframe();
  var_0 = (29097, 33602, 496);
  var_1 = 2250000;

  while(!scripts\cp\utility::any_player_nearby(var_0, var_1)) {
    wait 0.1;
  }

  announcement("Spawn Debug BadCover Guy");
  level.incomingcallback = scripts\cp\cp_modular_spawning::run_spawn_module("cover_guys_debug");
}

function spawn_in_cover(var_0) {
  var_1 = self getnearestnode();

  if(isDefined(var_1)) {
    var_2 = var_1.angles;
    var_3 = var_1.origin;

    if(!issubstr(var_1.type, "Prone")) {
      if(issubstr(var_1.type, "Left")) {
        var_2 += (0, 90, 0);
      } else if(issubstr(var_1.type, "Right") || issubstr(var_1.type, "Cover Crouch") || issubstr(var_1.type, "Conceal") || issubstr(var_1.type, "Cover Stand")) {
        var_2 -= (0, 90, 0);
      }
    }

    self forceteleport(var_3, var_2);
    self usecovernode(var_1, 1);
    self setgoalnode(var_1);
    self.goalradius = 8;
    self.script_origin_other = var_3;
    scripts\cp\cp_modular_spawning::set_goal_pos(self.script_origin_other);
    scripts\cp\cp_modular_spawning::set_goal_radius(32);
    self.sniperaccuracyset = 1;
    self.baseaccuracy = 1;
    self.aggressivemode = 1;
    self.mgbursttimemin = 15;
    self.mgbursttimemax = 20;
    self.aggressiveblindfire = 1;
    return;
  }
}