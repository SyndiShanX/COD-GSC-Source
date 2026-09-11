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
  var0 = &scripts\cp\cp_objectives::registerobjective;
  [[var0]]("convoy4_securearea", &obj_maj_secure_init, &obj_maj_secure_start, &obj_maj_secure_end, &debugbeatobjective, &debug_start_hostages);
  [[var0]]("convoy4_disablecomms", &obj_maj_comms_init, &obj_maj_comms_start, &obj_maj_comms_end, &debugbeatobjective, &debug_start_switches);
  [[var0]]("convoy4_secure_tower", &obj_maj_secure_tower_init, &obj_maj_secure_tower_start, &obj_maj_secure_tower_end, &debugbeatobjective, &debug_start_terminal);
  [[var0]]("convoy4_find_keys", &obj_maj_find_keys_init, &obj_maj_find_keys_start, &obj_maj_find_keys_end, &debugbeatobjective, &debug_start_keys);
  [[var0]]("convoy4_call_train", &obj_maj_call_train_init, &obj_maj_call_train_start, &obj_maj_call_train_end, &debugbeatobjective, &debug_start_call);
  [[var0]]("convoy4_take_apache", &obj_maj_take_apache_init, &obj_maj_take_apache_start, undefined, &debugbeatobjective);
  [[var0]]("convoy4_wait_train", &obj_maj_wait_train_init, &obj_maj_wait_train_start, undefined, &debugbeatobjective, &debug_start_waittrain);
  [[var0]]("convoy4_open_train", &obj_maj_open_train_init, &obj_maj_open_train_start, undefined, &debugbeatobjective);
  [[var0]]("convoy4_extraction", &obj_maj_extraction_init, &obj_maj_extraction_start, undefined, &debugbeatobjective, &debug_start_extraction);
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

function ref_131e6(var0) {
  if(isDefined(level.hideintelscriptablesfromplayer) && isDefined(scripts\engine\utility::array_find(level.hideintelscriptablesfromplayer, var0))) {
    return;
  }

  var1 = scripts\engine\utility::getStruct(var0, "script_noteworthy");
  var2 = spawn("script_model", var1.origin);
  var2.angles = var1.angles;
  var2 setModel("military_hq_crate_01_proxy_cp_spawnable");

  if(isDefined(var1.targetname)) {
    var2.targetname = var1.targetname;
  }

  if(!isDefined(level.hideintelscriptablesfromplayer)) {
    level.hideintelscriptablesfromplayer = [];
  }

  level.hideintelscriptablesfromplayer[level.hideintelscriptablesfromplayer.size] = var0;
}

function ref_131e4() {
  level.ref_11f54 = scripts\engine\utility::getStructArray("obj_a_goal", "targetname");

  foreach(var1 in level.ref_11f54) {
    var1.ref_127ea = [];

    if(!isDefined(var1.radius)) {
      var1.radius = 500;
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
  var0 = getEntArray("smuggler_loot", "targetname");

  foreach(var2 in var0) {
    if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == "armor") {
      var2 thread scripts\cp\utility::create_fake_loot(["brloot_munition_armor"]);
      continue;
    }

    var2 thread scripts\cp\utility::create_fake_loot(["brloot_munition_ammo"]);
  }
}

function ref_1321c() {
  var0 = scripts\engine\utility::getStructArray("no_wave_spawn", "targetname");

  foreach(var2 in var0) {
    scripts\cp\cp_spawning_util::balloon_deposit(var2.origin, var2.radius);
  }
}

function obj_maj_secure_init(var0) {
  level.global_stealth_broken = 0;
  thread ref_124d2();
  thread ref_11f50();
  thread ref_131f0();
}

function obj_maj_secure_start(var0) {
  thread smuggler_door_lock();
  level thread scripts\cp\maps\cp_suburbs11\cp_suburbs11_safehouse::ref_137f7();
  ref_1321c();
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  scripts\engine\utility::flag_wait("quarry_intro_vo_finished");
  var1 = scripts\engine\utility::getStruct("convoy4_advancequarry", "targetname");
  objective_setplayintro(var0.objectiveindex, 1);
  objective_setplayoutro(var0.objectiveindex, 1);
  objective_state(var0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_sethot(var0.objectiveindex, 0);
  objective_position(var0.objectiveindex, var1.origin);
  objective_setlabel(var0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_SECURE_WORLD");
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
  var2 = 163840000;

  while(!scripts\cp\utility::any_player_nearby(var1.origin, var2)) {
    wait 0.1;
  }

  level scripts\engine\utility::delaythread(3, &nextstar);
  level scripts\engine\utility::delaythread(randomintrange(60, 90), &nextstar);
  thread ref_1295d();
  scripts\engine\utility::delaythread(5, &ref_14408);
  level.ref_12959 = scripts\cp\cp_modular_spawning::run_spawn_module("quarry_intro1_chopper");
  wait 1.5;
  level.ref_1295a = scripts\cp\cp_modular_spawning::run_spawn_module("quarry_intro2_chopper");
  var2 = 81000000;

  while(!scripts\cp\utility::any_player_nearby(var1.origin, var2)) {
    wait 0.1;
  }

  level.icontrigger = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_roof_rpgs");
  var3 = ["dx_cps_lass_callout_helicopter_attacking_10", "dx_cps_lass_callout_helicopter_attacking_20"];
  thread play_vo_delay(level);
  var2 = 60840000;

  while(!scripts\cp\utility::any_player_nearby(var1.origin, var2)) {
    wait 0.1;
  }

  level thread scripts\cp\cp_wave_spawning::killstreaks(0.1, "smugg_p3_intro_no_heli");
  var2 = 30250000;
  var4 = 1;

  while(var4 > 0) {
    wait 0.5;

    if(scripts\cp\utility::any_player_nearby(var1.origin, var2)) {
      var4 -= 0.5;
    }
  }

  level notify("stop_mortars");
  play_vo_delay(level, "dx_cps_lass_quarry2_array_spotted_10");
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(undefined, "ping_response_copy");
  wait 1;
  var1 = scripts\engine\utility::getStruct("objective_convoy4_02_a", "targetname");
  var5 = scripts\engine\utility::getStruct("convoy4_investigate", "targetname");
  var6 = 2600;
  var7 = var6 * var6;

  for(;;) {
    wait 0.5;
  }

  LOC_000002e5:
    var8 = ["dx_cps_lass_callout_enemy_squad_spawning_10", "dx_cps_lass_callout_enemy_squad_spawning_20", "dx_cps_lass_callout_enemy_squad_spawning_30"];
  thread play_vo_delay(level);
  var6 = 1400;
  var7 = var6 * var6;
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_position(var0.objectiveindex, var5.origin + (0, 0, 20));
  objective_setlabel(var0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/INVESTIGATE_WORLD");
  thread scripts\cp\utility::objective_update("convoy4_investigate", undefined, undefined, undefined, 1);

  for(;;) {
    wait 0.5;
  }

  LOC_0000037f:
    scripts\cp\cp_objectives::lua_objective_complete("convoy4_investigate");
  thread scripts\cp\utility::objective_update("convoy4_restricttrain", undefined, undefined, undefined, 1);
}

function ref_12115() {
  var0 = scripts\engine\utility::getStructArray("open_this_door", "targetname");

  foreach(var2 in var0) {
    thread ref_1211b(var2);
  }
}

function ref_1211b(var0) {
  var1 = var0.origin;
  var2 = var0.radius;
  var3 = [];
  var4 = getentitylessscriptablearrayinradius(undefined, undefined, var1, var2);

  for(var5 = 0; var5 < var4.size; var5++) {
    if(var4[var5] scriptableisdoor()) {
      var3 = var4[var5];
    }
  }

  for(var6 = 0; var6 < var3.size; var6++) {
    var3[var6] setscriptablepartstate("door", "left_90", 0);
  }
}

function ref_13dbd(var0, var1, var2, var3, var4) {
  level endon("game_ended");

  if(isDefined(var2)) {
    level endon(var2);
  }

  if(isDefined(var3)) {
    level endon(var3);
  }

  if(isDefined(var4)) {
    level endon(var4);
  }

  var5 = scripts\engine\utility::getStruct(var1, "targetname");

  if(isDefined(var5.target)) {
    GscBinSkip4(0x35, var0, var5);
  }

  var6 = var5.origin;
  var7 = var5.radius;
  var8 = var7 * var7;

  for(;;) {
    wait 0.25;

    if(scripts\cp\utility::any_player_nearby(var6, var8)) {
      break;
    }
  }

  level notify(var0 + "_spawned");

  if(!isDefined(level.ref_13dbc)) {
    level.ref_13dbc = [];
  }

  level.ref_13dbc[var0] = scripts\cp\cp_modular_spawning::run_spawn_module(var0);
}

function ref_13dbe(var0, var1) {
  level endon(var0 + "_spawned");
  var2 = var1.origin;
  var3 = scripts\engine\utility::getStruct(var1.target, "targetname");
  var4 = var3.origin;
  var5 = var3.radius;
  var6 = var5 * var5;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var4, var6)) {
      break;
    }

    wait 0.25;
  }

  level notify(var0 + "_cancel");
}

function ref_1295f(var0) {
  var1 = scripts\engine\utility::getStruct("quarry_intro_wave_spawn_poi", "targetname");
  var2 = var1.radius;
  var3 = var1.origin;
  thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var3, var2, 10000);
  var4 = 20250000;

  while(!scripts\cp\utility::any_player_nearby(var0.origin, var4)) {
    wait 0.25;
  }

  thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var3);
  var1 = scripts\engine\utility::getStruct("quarry_inside_wave_spawn_poi", "targetname");
  var2 = var1.radius;
  var3 = var1.origin;
  thread scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var3, var2, 10000);
  var4 = 6760000;

  while(!scripts\cp\utility::any_player_nearby(var0.origin, var4)) {
    wait 0.25;
  }

  thread scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var3);
}

function ref_14408() {
  level.global_stealth_broken = 1;
  level notify("weapons_free");
  var0 = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(var2 in var0) {
    var2 thread scripts\cp\cp_modular_spawning::enter_combat();
  }
}

function ref_1295d() {
  level.get_mortar_impact_pos = &get_mortar_impact_spot;
  level.ref_1295d = getEntArray("quarry_mortar", "targetname");
  var0 = scripts\engine\utility::getStruct("quarry_approach", "targetname");

  foreach(var2 in level.ref_1295d) {
    var2 hidepart("j_mortar_shell", "misc_wm_mortar");
    thread mortar_think(var2);
  }

  level waittill("flare_launched");
  level scripts\engine\utility::delaythread(0.25, &scripts\cp\cp_vo::try_to_play_vo_on_team, "dx_cps_kama_callout_mortar_attacking_20", "allies");
  wait 8;
  level waittill("flare_launched");
  level scripts\engine\utility::delaythread(0.25, &scripts\cp\cp_vo::try_to_play_vo_on_team, "dx_cps_kama_callout_mortar_attacking_10", "allies");
}

function mortar_think(var0) {
  level endon("game_ended");
  level endon("started_hack_at_a");
  level endon("stop_mortars");
  self endon("death");
  var1 = 4;
  var2 = 7;
  self.targets = undefined;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(self.origin, 1000000)) {
      return;
    }

    var3 = get_players_in_area(var0.origin, var0.radius);

    if(var3.size) {
      self.targets = var3;
      scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_mortar(self, 1, 1000);
      self.targets = undefined;
      wait randomintrange(var1, var2);
      continue;
    }

    wait 1;
  }
}

function get_players_in_area(var0, var1) {
  var2 = [];

  foreach(var4 in level.players) {
    if(!var4 scripts\cp\utility::is_valid_player() || !var4 isonground()) {
      continue;
    }

    if(scripts\engine\utility::distance_2d_squared(var4.origin, var0) < var1 * var1) {
      var2 = var4;
    }
  }

  return var2;
}

function get_mortar_impact_spot(var0) {
  if(!isDefined(var0.targets)) {
    return undefined;
  }

  var1 = scripts\engine\utility::random(var0.targets);
  var2 = var1.origin + (randomintrange(-300, 300), randomintrange(-300, 300), 0);
  var3 = scripts\engine\trace::ray_trace(var2 + (0, 0, 500), var2);
  return var3["position"];
}

function nextstar() {
  level.ref_1359d = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_p3_form_a");
  level.ref_1359e = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_p3_form_b");
  level.ref_1359f = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_p3_form_c");
  wait randomintrange(4, 8);
  level.ref_135a0 = scripts\cp\cp_modular_spawning::run_spawn_module("lbravo_spawner_p3_form_d");
}

function obj_maj_secure_end(var0) {}

#using_animtree("");

function ref_13779() {
  var0 = scripts\engine\utility::getStruct("quarry_train", "targetname");
  level.scr_animtree["quarry_train_anim"] = #animtree;
  level.scr_anim["quarry_train_anim"]["approach"] = $cp_scripted_train_arrival;
  level.scr_animname["quarry_train_anim"]["approach"] = "cp_scripted_train_arrival";
  waitframe();
  level.ref_1295e = getEnt("smuggler_train", "targetname");
  level.ref_1295e.animname = "quarry_train_anim";
  level.ref_1295e useanimtree(level.scr_animtree[level.ref_1295e.animname]);
  var1 = getEnt("train1_clip", "targetname");
  var2 = getstartorigin(var0.origin, var0.angles, level.scr_anim["quarry_train_anim"]["approach"]);
  var3 = getstartangles(var0.origin, var0.angles, level.scr_anim["quarry_train_anim"]["approach"]);
  level waittill("start_anim_train");
  level.ref_1295e dontinterpolate();
  level.ref_1295e.origin = var2;
  level.ref_1295e.angles = var3;
  var1 dontinterpolate();
  var1.origin = var2;
  var1.angles = var3;
  var1 linkTo(level.ref_1295e, "tag_origin", (0, -6, 84), (0, 0, 0));
  level.ref_1295e.clipmodel = var1;
  level.ref_1295e setscriptablepartstate("anim", "anim");
  thread damage_infront_of_train(level.ref_1295e, level.ref_1295e);
}

function obj_maj_comms_init(var0) {
  level.convoy4_terminal_keys = 0;
  thread play_hack_alarms();
  thread play_hacks_interact_vo();
}

function obj_maj_comms_start(var0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(24);
  scripts\cp\cp_objectives::lua_objective_incomplete("convoy4_restricttrain");
  setomnvar("cp_objective_sub_count_2", 0);
  thread setup_enemy_sentries(level);
  obj_comms_start(level, "disable_comms_laptop", "a", var0);
  setomnvar("cp_objective_sub_count_2", 1);
  scripts\cp\cp_objectives::screenent_c("minor_objective");
  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("quarry_1", ["deployable_cover", "precision_airstrike"]);
  thread setup_enemy_sentries(level);
  wait 1.1;
  obj_comms_start(level, "disable_comms_laptop", "b", var0);
  setomnvar("cp_objective_sub_count_2", 2);
  scripts\cp\cp_objectives::screenent_c("minor_objective");
  wait 1.1;
  obj_comms_start(level, "disable_comms_laptop", "c", var0);
  setomnvar("cp_objective_sub_count_2", 3);
  scripts\cp\cp_objectives::screenent_c("minor_objective");
  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("quarry_2", ["juggernaut", "precision_airstrike", "cruise_missile"]);
  thread setup_enemy_sentries(level);
  wait 1.1;
}

function waittill_all_valid_ai_are_gone(var0) {
  thread waittill_any_2(var0);
}

function waittill_any_2(var0) {
  wait 1;
  self notify("basic_combat");

  if(isDefined(self.aitype) && self.aitype == "ar_heavy_laser") {
    var1 = [];

    foreach(var3 in level.players) {
      if(!var3 scripts\cp\utility::is_valid_player() || !var3 isonground()) {
        continue;
      }

      self getenemyinfo(var3);
      var1 = var3;
    }

    if(isDefined(var1) && var1.size > 0) {
      var5 = scripts\engine\utility::getStruct("objective_convoy4_02_c", "targetname");
      var1 = sortbydistance(var1, var5.origin);

      if(isDefined(var1[0])) {
        scripts\cp\cp_modular_spawning::set_goal_pos(var1[0].origin);
      }
    }

    thread scripts\cp\cp_modular_spawning::enter_combat();
    wait 0.5;
    scripts\cp\cp_modular_spawning::set_goal_radius(500);
    return;
  }
}

function obj_maj_comms_end(var0) {
  scripts\cp\cp_objectives::lua_objective_complete("convoy4_restricttrain");
}

function obj_maj_secure_tower_init(var0) {
  level notify("stop_auto_smokes");
  thread spawn_soldiers_attack_tower();
  level notify("obj_alarm_trigger");
}

function obj_maj_secure_tower_start(var0) {
  ref_131e6("obj_support_crate_c");
  thread ref_131f1();
  scripts\mp\brclientmatchdata::getprophealth("convoy4_secure_tower");
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(25);
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(3, "jugg_spawn");
  level.obj_reserved_juggs = 1;
  var1 = scripts\engine\utility::getStruct("objective_convoy4_04_a", "targetname");
  objective_setlocation(var0.objectiveindex, 0, var1.origin);
  level thread scripts\cp\cp_objectives::ref_1317e(var0, var1.origin);
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  level thread scripts\cp\cp_wave_spawning::killstreaks(1, "smugg_p3_intro");
  thread ref_12dd5(level);
  var2 = 220;
  var3 = var2 * var2;

  for(;;) {
    wait 0.25;
  }
}

function obj_maj_secure_tower_end(var0) {}

function obj_maj_find_keys_init(var0) {}

function wait_if_fail_calltrain(var0, var1, var2, var3) {
  level endon("game_ended");
  level endon("obj_called_train");
  thread remind_calltrain(level, var0, var1, var2);
  level waittill("convoy4_call_train_failed");
  objective_state(var0, "failed");
  level.convoy4_failed_calltrain = 1;
  wait 3;
  scripts\cp\cp_objectives::ref_12868("convoy4_call_train");
  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function remind_calltrain(var0, var1, var2, var3) {
  level endon("game_ended");
  level endon("obj_called_train");
  level endon("convoy4_call_train_failed");
  thread remind_calltrain_sethot(level);
  wait var1 - var2;
  setomnvar("cp_countdown_color", 1);
  wait var2 - var3;
  setomnvar("cp_countdown_color", 2);
  wait var3;
  level notify("convoy4_call_train_failed");
}

function remind_calltrain_sethot(var0) {
  level endon("game_ended");
  level endon("obj_called_train");
  level endon("convoy4_call_train_failed");
  wait 300;

  for(;;) {
    wait 1;
    objective_sethot(var0, 1);
    wait 1;
    objective_sethot(var0, 0);
  }
}

function obj_maj_find_keys_start(var0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(25);
  level thread scripts\cp\cp_wave_spawning::killstreaks(5, "smugg_p3_tower");
  var1 = scripts\engine\utility::getStruct("objective_convoy4_04_a", "targetname");
  objective_setlocation(var0.objectiveindex, 0, var1.origin);
  objective_icon(var0.objectiveindex, "icon_waypoint_locked");
  objective_setdescription(var0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_DISABLE_ARMS_0");
  thread delay_objective_update(level, "convoy4_keys_0");
  thread spawn_soldiers_juggs();
  thread play_keys_intro_vo();
  thread start_smoke_in_attic();
  thread setup_enemy_sentries(level);

  if(!isDefined(level.convoy4_terminal_keys)) {
    level.convoy4_terminal_keys = 0;
  }

  thread scripts\cp\utility::objective_update("convoy4_call_train", 360, 180, 60, 0, undefined);
  thread wait_if_fail_calltrain(var0.objectiveindex, 360, 180, 60);
  wait 1;
  var2 = 0;

  while(!isDefined(level.convoy4_module_juggs_1) || !isDefined(level.convoy4_module_juggs_1.ai_spawned)) {
    wait 0.05;
    var2 += 0.05;
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

function ref_135cf(var0, var1, var2, var3) {
  level endon("jugg_" + var2 + "_stop");
  thread ref_13575(var0, var1, var2, var3);
  thread ref_13dd0(var0, var1, var2, var3);

  while(!isDefined(var0) || var0.ai_spawned.size == 0) {
    wait 0.05;
  }

  ref_13576(var0, var1, var2);
}

function ref_13576(var0, var1, var2) {
  if(istrue(var0.patrolfunc)) {
    return;
  }

  if(isDefined(var0.ai_spawned) && var0.ai_spawned.size > 0) {
    var3 = var0.ai_spawned[0];
    thread spawn_key_objective(level, var1, var3);
    level notify("jugg_" + var2 + "_stop");
    return;
  }
}

function ref_13575(var0, var1, var2, var3) {
  level endon("jugg_" + var2 + "_stop");
  var4 = 0;

  while(!isDefined(var0) || var0.ai_spawned.size == 0 && var4 < 5) {
    wait 0.05;
    var4 += 0.05;
  }

  if(var0.ai_spawned.size > 0) {
    return;
  }

  thread scripts\cp\cp_modular_spawning::stop_module_by_groupname(var1);
  var0 = scripts\cp\cp_modular_spawning::run_spawn_module(var3);
  var4 = 0;

  while(!isDefined(var0) || var0.ai_spawned.size == 0 && var4 < 120) {
    wait 0.5;
    var4 += 0.5;
  }

  if(var0.ai_spawned.size == 0) {
    level notify("jugg_" + var2 + "_failsafe");
    return;
  }

  ref_13576(var0, var1, var2);
  level notify("jugg_" + var2 + "_stop");
}

function ref_13dd0(var0, var1, var2, var3) {
  level endon("game_ended");
  level endon("jugg_" + var2 + "_stop");
  level waittill("jugg_" + var2 + "_failsafe");
  wait randomfloat(10);

  if(!isDefined(var0) || var0.ai_spawned.size == 0) {
    level.convoy4_terminal_keys += 1;
    var0.patrolfunc = 1;
    thread ref_123d7();
    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var2);
    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var1);
    scripts\cp\cp_modular_spawning::stop_module_by_groupname(var3);
    level notify("jugg_" + var2 + "_stop");
    scripts\cp\utility::objective_update("convoy4_keys_" + level.convoy4_terminal_keys);
    return;
  }
}

function obj_maj_find_keys_end(var0) {
  level notify("stop_attic_smoke");
}

function spawn_key_objective(var0, var1, var2) {
  var3 = scripts\cp\cp_objectives::requestworldid(var0, 15);
  objective_setplayintro(var3, 1);
  objective_setplayoutro(var3, 1);
  objective_setownerteam(var3, undefined);
  objective_setlabel(var3, &"CP_QUARRY2_OBJECTIVES/CONVOY4_KEY_LOC");
  var4 = var1 scripts\engine\utility::spawn_tag_origin();
  var4 notsolid();
  var4 show();
  var4 linkTo(var1, "tag_origin", (0, 0, 90), (0, 0, 0));
  var1.jugg_obj_pos = var4;
  objective_setlocation(var3, 0, var4);
  thread disable_jugg_objective_position_on_death(level, var1, var3, 0);
  thread jugg_hold(var1);
  objective_state(var3, "current");
  scripts\cp\cp_objectives::ref_11f80(var3);
  objective_icon(var3, "icon_waypoint_objective_general");
  objective_sethot(var3, 0);
  objective_setbackground(var3, 0);
  objective_showtoplayersinmask(var3);
  objective_addalltomask(var3);
  objective_setshowoncompass(var3, 1);
}

function jugg_hold(var0) {
  var0 endon("death");
  var0 endon("enter_combat");
  var0 notify("watch_for_ai_events");
  var0 notify("enter_combat_after_stealth");
  var0.ignoreall = 1;
  var0 scripts\cp\cp_modular_spawning::set_goal_pos(var0.origin);
  thread watch_for_player_damage();
  jugg_hold_loop(var0);
  var0.ignoreall = 0;
  scripts\cp\cp_modular_spawning::remove_pacifist_from_guy();
  thread scripts\cp\cp_modular_spawning::enter_combat();
}

function watch_for_player_damage() {
  self endon("enter_combat");
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1);

    if(isPlayer(var1)) {
      self notify("player_damage");
      return;
    }
  }
}

function jugg_hold_loop() {
  self endon("death");
  self endon("player_damage");
  self endon("enter_combat");
  var0 = getdvarint("scr_jugg_hold_dist", 1000);
  var1 = var0 * var0;

  for(;;) {
    if(!isDefined(self.maxhealth)) {
      return;
    }

    if(self.health < self.maxhealth - 10) {
      return;
    }

    for(var2 = 0; var2 < level.players.size; var2++) {
      if(distancesquared(level.players[var2].origin, self.origin) < var1) {
        return;
      }

      if(scripts\engine\utility::within_fov(self getEye(), self.angles, level.players[var2].origin, cos(65))) {
        if(distancesquared(level.players[var2].origin, self.origin) < var1 && self cansee(level.players[var2])) {
          return;
        }
      }
    }

    wait 0.5;
  }
}

function obj_maj_call_train_init(var0) {
  level.obj_can_call_train = 1;
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_ovl_quarry2_keys_20");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_ovl_quarry2_keys_30");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_ovl_quarry2_keys_60");
}

function obj_maj_call_train_start(var0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(16);

  if(isDefined(level.obj_reserved_juggs)) {
    scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(3, "jugg_spawn");
    level.obj_reserved_juggs = undefined;
  }

  level.obj_allow_call_train = 1;
  scripts\cp\cp_interaction::addtointeractionslistbynoteworthy("obj_convoy4_call_train");
  var1 = scripts\engine\utility::getStruct("objective_convoy4_04_a", "targetname");
  objective_position(var0.objectiveindex, var1.origin);
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlabel(var0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_WORLD");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
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

function obj_maj_call_train_end(var0) {}

function obj_maj_take_apache_init(var0) {}

function obj_maj_take_apache_start() {
  level endon("game_ended");
  var0 = scripts\engine\utility::getStruct("obj_apache_tablet", "targetname").origin;
  wait 13;
  var1 = 3000;
  var2 = var1 * var1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var0, var2)) {
      break;
    }

    wait 0.1;
  }

  level notify("activate_near_apache");
  var3 = "convoy4_apache";
  var4 = getEnt("convoy4_apache", "targetname");
  var5 = scripts\cp\cp_objectives::requestworldid(var3, 15);
  objective_setlocation(var5, 0, var0);
  objective_setbackground(var5, 2);
  objective_setplayintro(var5, 1);
  objective_setplayoutro(var5, 1);
  objective_state(var5, "current");
  scripts\cp\cp_objectives::ref_11f80(var5);
  objective_icon(var5, "icon_waypoint_objective_general");
  objective_sethot(var5, 0);
  objective_setlabel(var5, &"CP_QUARRY2_OBJECTIVES/CONVOY4_TAKEAPACHE");
  thread set_apache_desc_delay(level, 1);
  var6 = spawn("script_model", var0 + (0, 0, -200));
  var6 setModel("veh8_mil_air_ahotel64_ks_mp");
  var7 = spawn("script_model", var0 + (0, 0, -210));
  var7 setModel("veh8_mil_air_ahotel64_ks_east_mp");
  thread activate_ks_on_use();
  level scripts\engine\utility::ref_143a5("player_used_quarry_ks", "players_near_exfil");
  objective_state(var5, "done");
  scripts\cp\cp_objectives::freeworldid(var3);

  if(isDefined(var6)) {
    var6 scripts\engine\utility::delaycall(4, &delete);
  }

  if(isDefined(var7)) {
    var7 scripts\engine\utility::delaycall(4, &delete);
    return;
  }
}

function set_apache_desc_delay(var0, var1) {
  wait var0;
  objective_setlabel(var1, &"CP_QUARRY2_OBJECTIVES/CONVOY4_TAKEAPACHE");
}

function activate_ks_on_use() {
  level endon("game_ended");
  level endon("launched_player_fultons");
  var0 = &"CP_QUARRY2_OBJECTIVES/USE_APACHE";
  self setHintString(var0);
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayrange(500);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("show");
  self setuseholdduration("duration_none");
  self makeusable();

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\cp\cp_weapon::ref_124ad(var1)) {
      scripts\cp\cp_weapon::minigamefinishcount(var1);
      continue;
    }

    thread activate_apache_on_player(level);
    thread make_traindoors_outlines_disabled_ks(var1);
    self makeunusable();
    break;
  }

  self delete();
}

function make_traindoors_outlines_disabled_ks(var0) {
  var0 endon("disconnect");
  level endon("game_ended");

  if(isDefined(level.convoy4_train_doors)) {
    for(var1 = 0; var1 < level.convoy4_train_doors.size; var1++) {
      if(isent(level.convoy4_train_doors[var1])) {
        level.convoy4_train_doors[var1] hudoutlinedisableforclient(var0);
      }
    }
  }

  self waittill("stop_remote_sequence");

  if(!istrue(level.obj_train_stopped)) {
    return;
  }

  if(isDefined(level.convoy4_train_doors)) {
    for(var1 = 0; var1 < level.convoy4_train_doors.size; var1++) {
      if(isent(level.convoy4_train_doors[var1])) {
        level.convoy4_train_doors[var1] hudoutlineenableforclient(var0, "outline_nodepth_red");
      }
    }

    return;
  }
}

function obj_maj_wait_train_init(var0) {
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "convoy4_the_smuggler");
  thread ref_131f0();
}

function obj_maj_wait_train_start(var0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(22);
  level thread scripts\cp\cp_wave_spawning::killstreaks(5, "smugg_p3_train");
  thread train_handler();
  thread spawn_soldiers_rooftops();
  thread play_cargo_intro();
  thread setup_enemy_sentries(level);
  var1 = scripts\engine\utility::getStruct("convoy4_obj_train", "targetname");
  objective_setdescription(var0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_WAITTRAIN");
  objective_position(var0.objectiveindex, var1.origin);
  level thread scripts\cp\cp_objectives::ref_1317e(var0, var1.origin);
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_sethot(var0.objectiveindex, 0);
  thread obj_maj_take_apache_start();
  level waittill("convoy4_train_stopped");
}

function obj_maj_open_train_init(var0) {
  level.trial_target_thread_func = 1;
}

function obj_maj_open_train_start(var0) {
  objective_setdescription(var0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_TRAIN_DOOR");
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(22);
  var1 = scripts\cp\cp_breach_c4::setup_c4(scripts\engine\utility::getStruct("traindoor_c4_1", "targetname"));
  var2 = scripts\cp\cp_breach_c4::setup_c4(scripts\engine\utility::getStruct("traindoor_c4_2", "targetname"));
  thread wait_for_door_breach(level);
  thread wait_for_door_breach(level);
  thread patrol_in_stealth();
  level.convoy4_train_c4s = 0;
  var3 = scripts\engine\utility::getStructArray("train_loot_struct", "targetname");
  var4 = undefined;
  level.convoy4_train_c4objs = thread spawn_train_c4_objects();
  var5 = scripts\engine\utility::getStructArray("train_step_coll", "targetname");
  var6 = (0, 0, 175);

  for(var7 = 0; var7 < level.convoy4_train_doors.size; var7++) {
    foreach(var9 in level.players) {
      level.convoy4_train_doors[var7] hudoutlineenableforclient(var9, "outline_nodepth_red");
      LOC_000000ec:
    }

    level.convoy4_train_doors[var7].obj_index = var7;
    objective_setlocation(var0.objectiveindex, var7, level.convoy4_train_doors[var7].origin + var6);
    thread hacking_magicgrenade_watcher(level, undefined, level.convoy4_train_doors[var7].origin);
  }

  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_sethot(var0.objectiveindex, 1);
  var11 = undefined;
  level waittill("c4_exploded", var11);
  var12 = scripts\engine\utility::getclosest(var11, level.convoy4_train_doors, 400);
  playFX(scripts\engine\utility::getfx("vfx_train_breach"), var12.origin + (0, 0, 52), var12.angles, anglestoup(var12.angles));
  level.convoy4_train_doors = scripts\engine\utility::array_remove(level.convoy4_train_doors, var12);
  var12 hudoutlinedisable();

  if(isDefined(var12.open_tut_gate)) {
    var12.open_tut_gate delete();
  }

  var12 delete();
  objective_unsetlocation(var0.objectiveindex, var12.obj_index);
  var4 = thread spawn_train_stairs(level, var11);
  thread spawn_c4_interacts_for_train(level, var4);
  level waittill("c4_exploded", var11);
  var12 = scripts\engine\utility::getclosest(var11, level.convoy4_train_doors, 400);
  playFX(scripts\engine\utility::getfx("vfx_train_breach"), var12.origin + (0, 0, 52), var12.angles, anglestoup(var12.angles));
  objective_setdescription(var0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_TRAIN_LOOT");
  scripts\cp\utility::objective_update("convoy4_take_loot");
  level notify("obj_take_loot");
  level.obj_take_loot = 1;
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_kama_quarry2_nag_train_10");
  thread play_cargo_c4_nags();
  var12 hudoutlinedisable();

  if(isDefined(var12.open_tut_gate)) {
    var12.open_tut_gate delete();
  }

  var12 delete();
  objective_unsetlocation(var0.objectiveindex, var12.obj_index);
  var4 = thread spawn_train_stairs(level, var11);
  thread spawn_c4_interacts_for_train(level, var4);

  while(level.convoy4_train_c4s < 4) {
    wait 0.1;
  }

  level notify("all_c4_placed");
  level thread scripts\cp\cp_vo::remove_from_nag_vo("dx_cps_ovl_quarry2_train_30");
  scripts\cp\cp_objectives::screenent_c("minor_objective");
}

function patrol_in_stealth() {
  level endon("game_ended");
  level waittill("used_c4", var0);
  thread patrol_think(level);
  level waittill("used_c4", var1);
  thread patrol_think(level);
}

function patrol_think(var0) {
  level endon("game_ended");
  var0 endon("death_or_disconnect");
  var1 = 2500;
  wait 6;
  var2 = var0.origin;
  var3 = 0;
  var4 = 0;

  while(var4 < 5) {
    if(distancesquared(var0.origin, var2) <= var1) {
      var3 += 1;
    }

    var4 += 1;
    wait 1;
  }

  if(var3 > 3) {
    if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
      var5 = scripts\engine\utility::getStructArray("quarry_unstuck_spot", "targetname");
      var6 = scripts\engine\utility::getclosest(var0.origin, var5);
      var0 setOrigin(var6.origin);
      return;
    }

    return;
  }
}

function wait_for_door_breach(var0) {
  var0 scripts\engine\utility::ent_flag_wait("c4_exploded");
  level notify("c4_exploded", var0.origin);
}

function spawn_train_stairs(var0, var1) {
  var2 = scripts\engine\utility::getclosest(var0, var1, 200).script_noteworthy;
  return var2;
}

function spawn_train_c4_objects() {
  var0 = scripts\engine\utility::getStructArray("obj_c4_mdl", "targetname");
  var1 = [];
  var2 = getEnt("clip64x64x64", "targetname");

  foreach(var4 in var0) {
    if(!isDefined(var4.angles)) {
      var4.angles = (0, 0, 0);
    }

    var5 = spawn("script_model", var4.origin);
    var5 setModel(var4.script_noteworthy);
    var5.angles = var4.angles;
    var1 = var5;
    waitframe();
    var6 = spawn("script_model", var4.origin);
    var6 clonebrushmodeltoscriptmodel(var2);
    var6.angles = var4.angles;
    var1 = var6;
    waitframe();
  }

  return var1;
}

function spawn_c4_interacts_for_train(var0, var1) {
  for(var2 = 0; var2 < var1.size; var2++) {
    if(var1[var2].script_noteworthy == var0) {
      create_usable_c4_model(var1[var2], var2);
      wait 0.05;
    }
  }
}

function create_usable_c4_model(var0) {
  var1 = scripts\cp\cp_objectives::requestworldid("obj_loot_pickup_" + var0, 15);
  objective_setplayintro(var1, 1);
  objective_setplayoutro(var1, 1);
  objective_state(var1, "current");
  scripts\cp\cp_objectives::ref_11f80(var1);
  objective_setbackground(var1, 0);
  objective_setlabel(var1, &"CP_QUARRY2_OBJECTIVES/LABEL_LOOT");
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_sethot(var1, 1);
  var2 = spawn("script_model", self.origin + (0, 0, 4));
  var2 setModel("tag_origin");
  var2.angles = self.angles;
  var2.ref_12ead = var2.angles;

  if(isDefined(self.script_parameters)) {
    var2.script_parameters = self.script_parameters;
  }

  waitframe();
  var3 = &"CP_QUARRY2_OBJECTIVES/COLLECT_LOOT";
  objective_position(var1, var2.origin + (0, 0, 12));
  var2 setHintString(var3);
  var2 setCursorHint("HINT_BUTTON");
  var2 sethinticon("hud_icon_c4_plant");
  var2 sethintdisplayrange(500);
  var2 sethintdisplayfov(65);
  var2 setuserange(72);
  var2 setusefov(65);
  var2 sethintonobstruction("hide");
  var2 setuseholdduration("duration_medium");
  var2 sethintrequiresholding(1);
  var2 makeusable();
  thread c4_use_think(var2, var1);
  return var2;
}

function c4_use_think(var0, var1) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var2);

    if(isDefined(var2)) {
      if(!var2 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      var2 playSound("cp_generic_pickup");

      if(level.convoy4_train_c4s < 3) {
        thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var2, "obj_device_setting");
      } else {
        thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var2, "obj_collect_complete");
      }

      thread placed_c4_train(var0, var1);
      scripts\cp\cp_objectives::freeworldid("obj_loot_pickup_" + var1);
    }
  }
}

function placed_c4_train(var0, var1) {
  self setModel("offhand_wm_c4_cp");

  if(isDefined(self.script_parameters)) {
    var2 = self.script_parameters;
    self.angles = (self.angles[0], self.angles[1], int(var2));
  }

  self.origin -= (0, 0, 4);
  self setscriptablepartstate("effects", "plant", 0);
  self playLoopSound("cp_bombsite_beep");
  level.convoy4_train_c4s += 1;
  objective_state(var0, "done");
  self makeunusable();
  level waittill("players_fultoned");
  remove_c4_train();
}

function remove_c4_train() {
  self stoploopsound("cp_bombsite_beep");
  playFX(level._effect["equipment_smoke"], self.origin);
  self delete();
}

function obj_maj_extraction_init(var0) {
  thread spawn_soldiers_ending();
  thread start_smuggler_heli_flyin();
  level.obj_used_extract_num = 0;
  level.trial_target_thread_func = 1;
}

function obj_maj_extraction_start(var0) {
  thread scripts\cp\cp_modular_spawning::set_ambient_max_count(24);
  var1 = scripts\engine\utility::getStruct("objective_convoy4_05_a", "targetname");
  objective_position(var0.objectiveindex, var1.origin);
  level thread scripts\cp\cp_objectives::ref_1317e(var0, var1.origin);
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_setownerteam(var0.objectiveindex, "allies");
  objective_sethot(var0.objectiveindex, 0);
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_setdescription(var0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CONVOY4_REGROUP_EXTRACT");
  objective_setlabel(var0.objectiveindex, &"CP_QUARRY2_OBJECTIVES/LABEL_REGROUP");
  scripts\cp\utility::ref_123fe("mus_cp_smuggler_mission_end");
  thread spawn_map_ac130();
  thread disable_nearby_vehicles(level, var1.origin);
  thread ref_123e3(level);
  thread ref_1240e(level);
  wait_for_start_extraction(level, var1.origin, var0.objectiveindex);
  level.obj_allow_fulton = 0;
  thread kiosksearchradiusidealmin();
}

function delayed_disable_respawns(var0) {
  wait var0;
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
  var0 = scripts\engine\utility::getStruct("smuggler_base_room", "targetname").origin;
  var1 = "scriptable_construction_doors_metal_b_02_mp";
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(1, var0, 128, var1, "classname");
}

function smuggler_door_unlock() {
  var0 = scripts\engine\utility::getStruct("smuggler_base_room", "targetname").origin;
  var1 = "scriptable_construction_doors_metal_b_02_mp";
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_13bc1(0, var0, 128, var1, "classname");
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
  var0 = scripts\engine\utility::getStruct("convoy4_smuggler_heli_start", "targetname");
  var1 = scripts\engine\utility::getStruct("convoy4_smuggler_heli_landing", "targetname");
  var0.team = "axis";

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.classname_mp = "script_vehicle_iw8_lbravo";
  var0.script_modelname = "veh8_mil_air_lbravo";
  var0.vehicletype = "lbravo_infil_cp";
  wait 15;
  level.smuggler_heli = spawn_objective_heli(var0);
  thread spawn_smuggler_heli_pilot();
  level.smuggler_heli thread scripts\common\vehicle_paths::vehicle_paths_helicopter(var0);
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

function spawn_objective_heli(var0) {
  var1 = scripts\common\vehicle::vehicle_spawn(var0);
  var1.vehicle_skipdeathmodel = 1;
  var1.death_fx_on_self = 1;
  var1.vehicle_skipdeathcrash = 0;
  var1.health += 1500;
  var1.team = "axis";
  var1.affectedbylockon = 1;
  level thread scripts\cp\cp_weapon::add_to_special_lockon_target_list(var1);
  thread set_smuggler_crash_loc(level);
  thread smuggler_heli_waittill_javelined();
  thread isplayeronintelchallenge();
  return var1;
}

function isplayeronintelchallenge() {
  level endon("game_ended");

  while(getdvarint("scr_debug_heli_lockon", 0) == 0) {
    wait 1;
  }

  announcement("lockonspecialsize: " + level.special_lockon_target_list.size);
  wait 3;
  var0 = 0;

  foreach(var2 in level.special_lockon_target_list) {
    var0++;
    announcement("#" + var0 + "=" + var2.targetname);
    wait 1;
  }
}

function smuggler_heli_waittill_javelined() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isPlayer(var1) && isDefined(var9) && getweaponbasename(var9) == "iw8_la_juliet_mp") {
      self dodamage(5000, self.origin, var1);
      self notify("death");
    }

    if(isPlayer(var1)) {
      var1 scripts\cp\cp_damagefeedback::updatehitmarker("standard", 1, var0, 0, 0);
    }
  }
}

function set_smuggler_crash_loc(var0) {
  var0 waittill("death", var1);
  var2 = scripts\engine\utility::getStructArray("smuggler_heli_crash", "targetname");
  var0.perferred_crash_location = scripts\engine\utility::getclosest(var0.origin, var2);
  var3 = var0.perferred_crash_location.origin;
  thread getcurrentxp();
  var4 = var0 scripts\engine\utility::ref_143b9(25, "vehicle_crashDone");

  foreach(var6 in level.players) {
    if(isDefined(var1) && isPlayer(var1) && var6 == var1) {
      thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var6, "obj_sitrep_success");
      continue;
    }

    thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var6, "obj_target_eliminated");
  }

  if(isDefined(var0) && isent(var0)) {
    playFX(level._effect["helidown_groundexp"], var0.origin);
    playsoundatpos(var0.origin, "cp_br_syrk_chopper_crash");
  } else {
    playFX(level._effect["helidown_groundexp"], var3);
    playsoundatpos(var3, "cp_br_syrk_chopper_crash");
  }

  if(isDefined(var0.pilot) && isent(var0.pilot)) {
    var0.pilot delete();
  }

  if(isDefined(level.smuggler_heli.smugglermdl) && isent(level.smuggler_heli.smugglermdl)) {
    level.smuggler_heli.smugglermdl delete();
  }

  if(isent(var0)) {
    var0 delete();
    return;
  }
}

function getcurrentxp() {
  self endon("entitydeleted");
  self endon("vehicle_crashDone");

  for(;;) {
    var0 = self.origin;
    wait 0.5;

    if(self.origin == var0) {
      self notify("vehicle_crashDone");
    }
  }
}

function setup_pilot(var0, var1, var2) {
  var3 = "tag_pilot";

  if(isDefined(var0)) {
    var3 = var0;
  }

  var4 = (0, 0, 0);

  if(isDefined(var1)) {
    var4 = var1;
  }

  var5 = (0, 0, 0);

  if(isDefined(var2)) {
    var5 = var2;
  }

  var6 = spawn("script_model", self gettagorigin(var3));
  var6 setModel("aq_pilot_fullbody_1");
  var6 linkTo(self, var3, var4, var5);
  var6 scriptmodelplayanim("vh_blima_rappel_pilot");
  return var6;
}

function spawn_smuggler_and_board_heli() {
  var0 = smuggler_spawn();
  var0.script_startingposition = 3;
  var0.dontkilloff = 1;
  var0.ignoreall = 1;
  var0.ignoreme = 1;
  var0 scripts\common\utility::demeanor_override("sprint");
  var0.scripted_mode = 1;
  thread ref_1342b(level);
  thread smuggler_base_room();
  wait 18;

  if(!isalive(self)) {
    return;
  }

  var1 = scripts\engine\utility::getStruct("obj_smuggler_gotopos", "targetname");
  var2 = getclosestpointonnavmesh(var1.origin);
  var0 setgoalpos(var2);
  thread scripts\cp\utility::drawsphere(var2, 25, 9999, (1, 0, 0));
  thread smuggler_timeout_backup(var0);
  wait_for_soldier_at_heli(var0, var2);

  if(!isDefined(level.smuggler_heli) || !isent(level.smuggler_heli) || !isalive(var0)) {
    level waittill("continue_fulton_extraction");

    if(isent(var0)) {
      var0 kill();
    }

    scripts\engine\utility::flag_set("smuggler_aboard");
    return;
  }

  var0 notify("got_to_heli");
  var0 hide();
  var0.origin = (34917, 29465, 562);
  var2 = getclosestpointonnavmesh(var0.origin);
  var0 setgoalpos(var2);
  thread ref_1342c();
  level.smuggler_heli.smugglermdl = thread setup_pilot(level.smuggler_heli, "tag_pilot1");
  wait 0.5;
  scripts\engine\utility::flag_set("smuggler_aboard");
}

function ref_1342b(var0) {
  var0 endon("got_to_heli");
  var0 waittill("death");
  level.ref_11f79 = 1;
}

function ref_1342c() {
  self endon("death");
  wait 5;
  self kill();
}

function spawn_smuggler_javelin() {
  var0 = scripts\engine\utility::getStructArray("smuggler_javelin", "targetname");
  var1 = "icon_weapon_la_juliet";
  var2 = &scripts\cp_mp\entityheadicons::setheadicon_singleimage;

  foreach(var4 in var0) {
    var5 = scripts\cp\cp_weapon::buildweapon("iw8_la_juliet_mp", [], "none", "none", -1);
    var6 = createheadicon(var5);
    var7 = spawn("weapon_" + var6, var4.origin);
    var7.angles = var4.angles;
    var7 itemweaponsetammo(weaponclipsize(var5), weaponmaxammo(var5));
    var7.boxiconid = var7 thread[[var2]]("allies", var1, 12, 1, 800, 100, undefined, undefined, 1);
    thread wait_for_player_pickup();
  }
}

function wait_for_player_pickup() {
  self endon("death");
  self waittill("trigger", var0);
  setheadiconimage(self.boxiconid);
}

function wait_for_soldier_at_heli(var0) {
  self endon("death");
  self endon("heli_go_timeout");
  var1 = 1600;

  for(;;) {
    var2 = distance2dsquared(self.origin, var0);

    if(var2 < var1) {
      break;
    }

    wait 0.1;
  }

  wait 0.5;
}

function smuggler_timeout_backup(var0) {
  self endon("death");
  self endon("got_to_heli");
  wait var0;
  self notify("heli_go_timeout");
}

function smuggler_spawn() {
  level.convoy4_module_smugg_1 = scripts\cp\cp_modular_spawning::run_spawn_module("convoy4_the_smuggler");
  var0 = undefined;

  while(!isDefined(level.convoy4_module_smugg_1) || !isDefined(level.convoy4_module_smugg_1.ai_spawned)) {
    wait 0.05;
  }

  while(level.convoy4_module_smugg_1.ai_spawned.size == 0) {
    wait 0.05;
  }

  if(isDefined(level.convoy4_module_smugg_1.ai_spawned) && level.convoy4_module_smugg_1.ai_spawned.size > 0) {
    var0 = level.convoy4_module_smugg_1.ai_spawned[0];
  }

  return var0;
}

function smuggler_heli_objective(var0) {
  level endon("end_smuggler_objective");
  var1 = "smuggler_kill";
  var2 = scripts\cp\cp_objectives::requestworldid(var1, 15);
  objective_setplayintro(var2, 1);
  objective_setplayoutro(var2, 1);

  if(isDefined(var0) && isent(var0)) {
    var3 = var0 scripts\engine\utility::spawn_tag_origin();
    var3 notsolid();
    var3 show();
    var3 linkTo(var0, "tag_origin", (0, 0, 256), (0, 0, 0));
    var0.obj_pos = var3;
    objective_setlocation(var2, 0, var0.obj_pos);
  }

  objective_state(var2, "current");
  scripts\cp\cp_objectives::ref_11f80(var2);
  objective_setlabel(var2, &"CP_QUARRY2_OBJECTIVES/KILL_SMUGGLER");
  objective_icon(var2, "icon_waypoint_objective_general");
  objective_sethot(var2, 1);
  objective_setbackground(var2, 0);
  objective_addalltomask(var2);
  objective_showtoplayersinmask(var2);

  if(istrue(level.ref_11f79)) {
    level thread scripts\cp\utility::objective_update("convoy4_kill_smuggler", undefined, undefined, undefined, 1, undefined, 2);
    wait 1;
  } else {
    level thread scripts\cp\utility::objective_update("convoy4_kill_smuggler", undefined, undefined, undefined, 1, undefined, 2);

    if(isDefined(var0) && isent(var0)) {
      thread ref_1241e();
      thread smuggler_too_far_fail(level, 60, var1, var2);
    }

    if(isDefined(var0) && isent(var0)) {
      var0 waittill("death");
    } else {
      wait 1;
    }
  }

  scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "convoy4_the_smuggler");
  scripts\cp\cp_objectives::lua_objective_complete("convoy4_kill_smuggler");
  objective_state(var2, "done");
  scripts\cp\cp_objectives::freeworldid(var1);
}

function smuggler_too_far_fail(var0, var1, var2, var3) {
  var3 endon("death");
  wait var0;
  objective_unsetlocation(var2, 0);
  wait 10;
  level notify("end_smuggler_objective");
  objective_state(var2, "failed");
  scripts\cp\cp_objectives::fail_objective("smuggler_kill");
  scripts\cp\cp_objectives::freeworldid(var1);
}

function smuggler_base_room() {
  var0 = scripts\engine\utility::getStruct("smuggler_base_room", "targetname").origin;
  var1 = 2304;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var0, var1)) {
      break;
    }

    wait 3;
  }
}

function disable_nearby_vehicles(var0, var1) {
  var2 = var1 * var1;
  var3 = level.vehicle.instances["technical"];
  jumpiftrue(isDefined(var3)) LOC_00000022;
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

function delay_objective_update(var0, var1) {
  wait 0.05;

  if(istrue(var1)) {
    level thread scripts\cp\utility::objective_update(var0);
    return;
  }

  level thread scripts\cp\utility::objective_update(var0, 30, 25, 15);
}

function debugbeatobjective(var0) {
  level notify("debug_beat_" + var0 + "_objective");
}

function make_civ_usable(var0, var1) {
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

function civ_try_go_to_extract(var0, var1) {
  level endon("game_ended");
  self endon("death");
  self endon("gotten_to_extract");
  self endon("at_extract");
  self notify("vip_used");
  self notify("following_player");
  var2 = self.extractloc;
  var3 = 350;
  var4 = 250;
  var5 = 1000000;
  var6 = var3 * var3;
  var7 = var4 * var4;
  self.combatmode = "no_cover";
  self.trigger makeunusable();
  wait 2;

  for(;;) {
    wait 0.5;
    var2 = self.extractloc;
    scripts\cp\cp_modular_spawning::set_goal_radius(32);

    if(!scripts\cp\utility::any_player_nearby(self.origin, var6)) {
      objective_sethot(self.objectiveindex, 1);
      objective_setlabel(self.objectiveindex, &"CP_QUARRY2_OBJECTIVES/HVI_NO_PLAYER_NEARBY");
      self allowedstances("crouch");
      var8 = getclosestpointonnavmesh(self.origin);
      scripts\cp\cp_modular_spawning::set_goal_pos(var8);
      waitframe();
      continue;
    }

    if(are_enemies_nearby(var7, var5)) {
      objective_sethot(self.objectiveindex, 1);
      objective_setlabel(self.objectiveindex, &"CP_QUARRY2_OBJECTIVES/CLEAR_HOSTAGE");
      self allowedstances("crouch");
      var8 = getclosestpointonnavmesh(self.origin);
      scripts\cp\cp_modular_spawning::set_goal_pos(var8);
      waitframe();
      continue;
    }

    if(distancesquared(var2, self.origin) > 16384) {
      objective_sethot(self.objectiveindex, 0);
      objective_setlabel(self.objectiveindex, &"CP_QUARRY2_OBJECTIVES/FOLLOWING_PLAYER");
      var8 = getclosestpointonnavmesh(var2);
      scripts\cp\cp_modular_spawning::set_goal_pos(var8);
      waitframe();
    }
  }
}

function obj_comms_start(var0, var1, var2) {
  var3 = var2.objectiveindex;
  objective_setownerteam(var2.objectiveindex, undefined);
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;
  var8 = undefined;
  var9 = undefined;
  var10 = 0;

  switch (var1) {
    case "a":
      var4 = "objective_convoy4_02_a";
      var5 = "comms_laptop_interaction_a";
      var6 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_SWITCH_1";
      var7 = "icon_waypoint_sp_generic";
      var8 = &spawn_soldiers_switch_01;
      var9 = 0;
      var10 = 1;
      break;
    case "b":
      var4 = "objective_convoy4_02_b";
      var5 = "comms_laptop_interaction_b";
      var6 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_SWITCH_2";
      var7 = "icon_waypoint_sp_generic";
      var8 = &spawn_soldiers_switch_02;
      var9 = 150;
      var10 = 2;
      break;
    case "c":
      var4 = "objective_convoy4_02_c";
      var5 = "comms_laptop_interaction_c";
      var6 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_SWITCH_3";
      var7 = "icon_waypoint_sp_generic";
      var8 = &spawn_soldiers_switch_03;
      var9 = 100;
      var10 = 3;
      break;
  }

  thread stopwaveandstartthisone(level);
  level notify("started_hack_at_" + var1);
  thread handle_remind_hack();
  thread hacking_magicgrenade_watcher(level, undefined, var4);
  thread quarry_hacking_sfx(level, var5);
  scripts\cp\cp_interaction::addtointeractionslistbynoteworthy(var5);
  level.convoy4_comms_laptop_int_struct = scripts\cp\utility::getinteractionbynoteworthy(var5);
  level.convoy4_comms_laptop_int_struct.objectivestruct = var2;
  level.convoy4_comms_laptop_sn = var4;

  if(isDefined(level.convoy4_comms_laptop_int_struct)) {
    level.convoy4_comms_laptop_int_struct.laptopactive = 1;
  }

  var11 = scripts\engine\utility::getStruct(var4, "targetname");
  objective_setplayintro(var2.objectiveindex, 1);
  objective_setplayoutro(var2.objectiveindex, 1);
  objective_position(var2.objectiveindex, var11.origin);
  level thread scripts\cp\cp_objectives::ref_1317e(var2, var11.origin);
  objective_state(var2.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var2.objectiveindex);
  objective_icon(var2.objectiveindex, var7);
  objective_sethot(var2.objectiveindex, 0);
  objective_setlabel(var2.objectiveindex, var6);

  if(var1 == "b") {
    thread handle_players_near_hack_b(level, var11.origin);
    thread spawn_smoke_when_near_struct(level, "convoy4_smokehint", 150, undefined);
  }

  if(var1 == "c") {
    thread spawn_smoke_when_near_struct(level, "convoy4_hack3_smoke1", undefined);
    thread spawn_smoke_when_near_struct(level, "convoy4_hack3_smoke2", undefined);
    thread spawn_smoke_when_near_struct(level, "convoy4_hack3_smoke3", undefined);
    thread spawn_smoke_when_near_struct(level, "convoy4_hack3_smoke4", undefined);
  }

  level waittill("cpu_hacking_done");
  level notify("comms_laptop_hacked");
  scripts\cp\utility::ref_123fe("");
  thread play_hack_vo(level);
  playsoundatpos(var11.origin, "cp_hacking_success");
  level.i_see_player_shield_watcher = 0;
}

function activationcommslaptop(var0, var1) {
  if(!istrue(level.convoy4_comms_laptop_int_struct.laptopactive)) {
    return;
  }

  thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var1, "obj_interact");
  var2 = 1;

  if(getdvarint("scr_quarry2_speed", 0) != 0) {
    var2 = 0.03;
  }

  if(!isDefined(level.ref_12958)) {
    level.ref_12958 = 1;
  } else {
    level.ref_12958++;
  }

  var3 = 120;

  switch (level.ref_12958) {
    case 1:
      scripts\cp\utility::ref_123fe("mus_cp_smuggler_files_copied_1");
      var3 = 220;
      break;
    case 2:
      scripts\cp\utility::ref_123fe("mus_cp_smuggler_files_copied_2");
      var3 = 120;
      break;
    case 3:
      scripts\cp\utility::ref_123fe("mus_cp_smuggler_files_copied_3");
      var3 = 120;
      break;
  }

  var0.objectivestruct = level.convoy4_comms_laptop_int_struct.objectivestruct;
  var0.disabled = 1;
  var0.objectivestruct notify("start_hacking_comms_laptop", var0);
  level notify("start_hacking_comms_laptop", var0);
  level.i_see_player_shield_watcher = 1;
  var4 = &scripts\cp\cp_objective_mechanics::starthackingdefense;
  var5 = scripts\engine\utility::getStruct(level.convoy4_comms_laptop_sn, "targetname").origin;
  [[var4]](var0.objectivestruct, var5, 120 * var2, "comms_laptop_hacked", var3);
}

function quarry_hacking_sfx(var0, var1) {
  var2 = scripts\engine\utility::getStruct(var0, "script_noteworthy");

  if(var1 == "b") {
    thread his_respawn(level);
  }

  var3 = spawn("script_origin", var2.origin);
  wait 0.05;
  var3 playLoopSound("cp_hacking_struct_lp");
  level waittill("start_hacking_comms_laptop");
  thread computer_animation(level);
  var3 stoploopsound("cp_hacking_struct_lp");
}

function hacking_magicgrenade_watcher(var0, var1, var2) {
  level endon("cpu_hacking_done");
  level endon("stop_grenade_watcher");
  level endon("game_ended");

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.currentteam = "allies";
  }

  var3 = 300;
  var4 = var3 * var3;
  var5 = 500 + var2;
  var6 = ["frag_grenade_mp", "frag_grenade_mp", "smoke_grenade_mp"];
  jumpiftrue(isvector(var1)) LOC_00000078;
  var1 = scripts\engine\utility::getStruct(var1, "targetname").origin;

  for(;;) {
    var7 = scripts\cp\utility::getplayersinteam(var0.currentteam);
    var8 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var9 = scripts\engine\utility::getclosest(var1, var8, var5);

    if(isDefined(var9) && isalive(var9)) {
      foreach(var11 in var7) {
        if(distancesquared(var11.origin, var1) <= var4) {
          var12 = var11.origin - var9.origin;
          var13 = scripts\engine\utility::random(var6);
          var14 = randomfloatrange(1, 3);
          var15 = var9 launchgrenade(var13, var11.origin, (0, 0, 0), var14);
          break;
        }
      }
    }

    wait randomfloat(10) + 5;
  }
}

function spawn_smoke_when_near_struct(var0, var1, var2, var3) {
  level endon("game_ended");
  level endon("stop_auto_smokes");
  var4 = scripts\engine\utility::getStruct(var0, "targetname");

  if(!isDefined(var4)) {
    return;
  }

  if(isDefined(var3)) {
    var5 = var3 * var3;

    while(!scripts\cp\utility::any_player_nearby(var4.origin, var5)) {
      wait 0.5;
    }
  }

  if(!isDefined(var1)) {
    if(isDefined(var4.radius)) {
      var1 = int(var4.radius);
    } else {
      var1 = 150;
    }
  }

  var6 = var1 * var1;

  for(;;) {
    if(any_soldiers_nearby(var4.origin, var6)) {
      thread magic_smoke_launch(level, var4.origin, (0, 0, 10));

      if(!isDefined(var2)) {
        return;
      }

      wait var2;
    }

    wait 1;
  }
}

function any_soldiers_nearby(var0, var1) {
  var2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  for(var3 = 0; var3 < var2.size; var3++) {
    if(distancesquared(var2[var3].origin, var0) <= var1) {
      return true;
    }
  }

  return false;
}

function magic_smoke_launch(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 1;
  }

  for(var4 = 0; var4 < var3; var4++) {
    var5 = spawn("script_model", var0);
    var5 setModel("tag_origin");
    wait var2;
    var6 = anglesToForward(var5.angles);
    var7 = (0, 0, 1);
    var0 = var5.origin + (0, 0, 2);
    var5 delete();
    magicgrenademanual("smoke_grenade_mp", var0, (0, 0, 0), 0.3);
    thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", var0);
    wait 7;
  }
}

function start_smoke_in_attic() {
  level endon("game_ended");
  level endon("stop_attic_smoke");
  var0 = scripts\engine\utility::getStruct("attic_smoke_trigger", "targetname");
  var1 = scripts\engine\utility::getStructArray("attic_smoke", "targetname");
  var2 = 72;
  var3 = var2 * var2;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var0.origin, var3)) {
      break;
    }

    wait 0.2;
  }

  foreach(var5 in var1) {
    thread magic_smoke_launch(level, var5.origin, (0, 0, 10), 1);
  }
}

function spawn_extra_collision(var0, var1) {
  var2 = spawn("script_model", var0);
  var2 dontinterpolate();
  var2.angles = var1;
  var3 = getEnt("clip128x128x8", "targetname");
  var2 clonebrushmodeltoscriptmodel(var3);
  var2 linkTo(self);
  self.open_tut_gate = var2;
  return var2;
}

function train_handler() {
  level.train_nav_blocks = thread spawn_train_nav_blockers_all();
  level.convoy4_train_doors = [];
  var0 = scripts\engine\utility::getStruct("smuggler_train_path_start", "targetname");
  var1 = 19;
  var2 = undefined;

  if(isDefined(var0.target)) {
    var2 = scripts\engine\utility::getStruct(var0.target, "targetname");
  }

  var3 = undefined;

  if(isDefined(var2)) {
    var4 = vectortoangles(var2.origin - var0.origin + (0, 0, 54));
    var3 = (0, var4[1], 0);
  }

  var5 = (0, 0, 0);
  var3 += (0, 262, 0);
  level notify("stop_arrows");
  var6 = 2;
  thread ref_13779();
  var7 = spawn_train_car(var0.origin + (0, 0, 54), var3, undefined, undefined, undefined, 1);
  var7.script_noteworthy = "1";
  thread move_train_along_struct_path(level, var7, var1);
  thread train_sfx_1();
  wait var6 + 0.2;
  var8 = spawn_train_car(var0.origin + (0, 0, 54), var3, 1);
  var8.script_noteworthy = "2";
  thread move_train_along_struct_path(level, var8, var1);
  wait var6;
  var9 = spawn_train_car(var0.origin + (0, 0, 54), var3);
  var9.script_noteworthy = "3";
  thread move_train_along_struct_path(level, var9, var1);
  level.convoy4_train_follow = var9;
  wait var6;
  var10 = spawn_train_car(var0.origin + (0, 0, 54), var3, 1);
  var10.script_noteworthy = "4";
  thread move_train_along_struct_path(level, var10, var1);
  thread train_sfx_2();
  wait var6;
  var11 = [];
  GscBinSkip0(0x2e, var11.size, var7, var10, var5, var5, var5, var7, var5, level, level);
}

function ref_13c9b(var0) {
  wait 37.1;
  level notify("start_anim_train");
  level notify("convoy4_stop_train");
  var1 = 0;

  foreach(var3 in var0) {
    foreach(var5 in var3.train_parts) {
      if(var5.type != "hatch") {
        var5 hide();
        var5 notsolid();
      }
    }

    thread show_headicon_to(var3);
  }
}

function show_headicon_to(var0) {
  wait 1;

  if(var0.script_noteworthy == "2") {
    var1 = level.ref_1295e gettagorigin("cargo_03_tag_body");
    var2 = level.ref_1295e gettagangles("cargo_03_tag_body");
    var0.origin = var1;
    var0.angles = var2;
    var0 linkTo(level.ref_1295e, "cargo_03_tag_body", (0, 0, 56), (0, 0, 0));
    return;
  }

  if(var0.script_noteworthy == "4") {
    var1 = level.ref_1295e gettagorigin("cargo_02_tag_body");
    var2 = level.ref_1295e gettagangles("cargo_02_tag_body");
    var0.origin = var1;
    var0.angles = var2;
    var0 linkTo(level.ref_1295e, "cargo_02_tag_body", (0, 0, 56), (0, 0, 0));
    return;
  }
}

function ref_13cbb() {
  wait 73;
  ref_130fb();
}

function train_sfx_1() {
  wait 30;
  var0 = spawn("script_model", self.origin);
  var0 linkTo(self);
  wait 0.5;
  var0 playsoundonmovingent("cp_quarry_train_1_arrive");
  wait 20;
  var0 unlink();
  var0.origin = level.ref_1295e gettagorigin("engine_01_tag_origin");
  var0 linkTo(level.ref_1295e, "engine_01_tag_origin");
  wait 41;
  var0 delete();
}

function train_sfx_2() {
  wait 30;
  var0 = spawn("script_model", self.origin);
  var0 linkTo(self);
  wait 0.5;
  var0 playsoundonmovingent("cp_quarry_train_2_arrive");
  wait 55;
  var0 delete();
}

function spawn_train_car(var0, var1, var2, var3, var4, var5) {
  var6 = spawn("script_origin", var0);
  var7 = var1;
  var8 = var7 + (0, 180, 90);
  var9 = 80;
  var10 = istrue(var3);
  var11 = &spawn_train_car_part;
  var12 = [];

  if(!istrue(var5)) {
    GscBinSkip0(0x2e, var12.size, [[var11]]("bed", "stationary_train_car_chassis_01", var0 - (0, 0, var9), var7, var6));
  }

  GscBinSkip0(0x2e, var12.size, [[var11]]("whole", "veh8_ind_lnd_enovember_train_static", var0 - (0, 0, var9), var7, var6));
}

function offset_ang(var0, var1) {
  var2 = rotatevector(var0, var1);
  return var2;
}

function spawn_train_car_part(var0, var1, var2, var3, var4, var5, var6) {
  var7 = spawn("script_model", var2);
  var7.angles = var3;
  var7 setModel(var1);
  var7 solid();
  var7 show();
  var7.type = var0;
  var7 linkTo(var4);

  if(var0 == "hatch") {
    var8 = var7.origin;
    var9 = (-40, 0, 0);
    var10 = rotatevector(var9, var7.angles);
    var8 += var10;
    var11 = var7.angles + (90, 90, 0);
    thread spawn_extra_collision(var7, var8);
  }

  return var7;
}

function spawn_train_nav_blockers_all() {
  var0 = scripts\engine\utility::getStructArray("convoy4_train_block", "script_noteworthy");
  var1 = [];

  foreach(var3 in var0) {
    var4 = thread spawn_train_nav_blocker(var3);
    var1 = var4;
    waitframe();
  }

  return var1;
}

function spawn_train_nav_blocker(var0) {
  var1 = var0.origin;
  var1 -= 24;
  var2 = createnavobstaclebybounds(var1, (196, 196, 64), (0, 0, 0));
  return var2;
}

function waitfor_train_explode() {
  wait 3;

  if(!isDefined(level.ref_1295e)) {
    return;
  }

  var0 = level.ref_1295e gettagorigin("engine_01_tag_origin");
  var1 = level.ref_1295e gettagorigin("cargo_03_tag_origin");
  var2 = level.ref_1295e gettagorigin("loader_02_tag_origin");
  var3 = level.ref_1295e gettagorigin("cargo_02_tag_origin");
  thread explode_results(level);
  thread explode_results(level);
  thread explode_results(level);
  thread explode_results(level);
  level notify("obj_train_exploded");
  waitframe();

  if(isDefined(level.convoy4_train_c4objs)) {
    foreach(var5 in level.convoy4_train_c4objs) {
      if(isent(var5)) {
        var5 delete();
      }
    }
  }

  waitframe();

  if(isDefined(level.train_nav_blocks)) {
    foreach(var8 in level.train_nav_blocks) {
      destroynavobstacle(var8);
    }

    return;
  }
}

function explode_results(var0) {
  wait randomfloat(0.2);
  playFX(level._effect["vfx_wp_train_explosion"], var0 + (0, 0, 12));

  if(soundexists("cp_quarry_train_explode_01")) {
    playsoundatpos(var0, "cp_quarry_train_explode_01");
  }

  var1 = 4000000;
  var2 = scripts\cp\utility::give_all_players_nearby(var0, var1);

  for(var3 = 0; var3 < var2.size; var3++) {
    if(var2[var3] scripts\cp_mp\utility\player_utility::_isalive()) {
      if(!istrue(var2[var3].used_fulton_interact)) {
        var2[var3] dodamage(200, var0, var2[var3], var2[var3], "MOD_EXPLOSIVE");
      }
    }
  }

  scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(var0, 0.09, 1.5, 3000);
  wait 0.25;
}

function debug_loop_explosion() {
  level endon("game_ended");
  wait 5;
  var0 = scripts\engine\utility::getStructArray("train_explosions_debug", "targetname");

  for(;;) {
    if(getDvar("scr_quarry2_trainexplode", "") == "") {
      wait 0.5;
      continue;
    }

    setDvar("scr_quarry2_trainexplode", "");

    foreach(var2 in var0) {
      var3 = var2.origin;
      playFX(level._effect["vfx_wp_train_explosion"], var3 + (0, 0, 12));

      if(soundexists("cp_quarry_train_explode_01")) {
        playsoundatpos(var3, "cp_quarry_train_explode_01");
      }

      scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake(var3, 0.09, 1.5, 3000);
      wait 0.25;
    }
  }
}

function complete_game_win() {
  for(var0 = 0; var0 < level.players.size; var0++) {
    level.players[var0].ability_invulnerable = 1;
  }

  foreach(var2 in level.players) {
    var2 scripts\cp_mp\xmike109::scriptable_callback("smuggler");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var2 thread scripts\cp_mp\xmike109::scriptable_callback("brimstone_mod");
        continue;
      }

      var2 thread scripts\cp_mp\xmike109::scriptable_callback("brimstone_mod_vet");
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

function move_train_along_struct_path(var0, var1, var2) {
  level endon("game_ended");
  level endon("convoy4_train_stopped");
  level endon("convoy4_stop_train");
  var1 *= 17.6;
  var3 = scripts\engine\utility::getStruct("smuggler_train_path_start", "targetname");
  thread damage_infront_of_train(var0);
  var4 = 0;

  while(isDefined(var3.target)) {
    var4++;
    var5 = scripts\engine\utility::getStruct(var3.target, "targetname");
    var6 = distance(var3.origin, var5.origin);
    var7 = var6 / var1;

    if(var7 <= 0.1) {
      var7 = 0.15;
    }

    var8 = 0;

    if(isDefined(var5.speed) && isDefined(var0.script_noteworthy) && var0.script_noteworthy == "1") {
      var9 = get_train_special_speed(var5.speed);
      var7 = var9.timetomove;

      for(var4 = 0; var4 < level.convoy4_train.size; var4++) {
        if(level.convoy4_train[var4].script_noteworthy != "1") {
          level.convoy4_train[var4].speed = var7;
        }
      }
    }

    if(isDefined(var0.speed)) {
      if(isDefined(var0.script_noteworthy) && var0.script_noteworthy != "1") {
        switch (var0.script_noteworthy) {
          case "2":
            var7 = var0.speed + 0.15;
            break;
          case "3":
            var7 = var0.speed - 0.125;
            break;
          case "4":
            var7 = var0.speed - 0.225;
            break;
          case "5":
            var7 = var0.speed - 0.325;
            break;
        }
      }
    }

    var10 = var7;

    if(var10 > 2) {
      var10 = var7 * 0.25;

      if(var10 < 0.05) {
        var10 = 0.05;
      }
    }

    var11 = abs((var5.origin - var3.origin)[2]);

    if(var11 > 20) {
      var10 *= 0.35;

      if(var10 < 0.05) {
        var10 = 0.05;
      }
    }

    var12 = var5.origin + (0, 0, 54);
    var13 = vectortoangles(var5.origin - var3.origin);
    var13 += var2;
    var0 moveTo(var12, var7);
    var0 rotateTo(var13, var10);
    wait var7;
    var3 = var5;
  }

  ref_130fb();
}

function ref_130fb() {
  level.obj_train_stopped = 1;
  level notify("convoy4_train_stopped");
}

function get_train_special_speed(var0) {
  var1 = spawnStruct();
  var2 = "" + var0;

  switch (var2) {
    case "1":
      var1.timetomove = 0.5;
      var1.decc = 0.2;
      break;
    case "2":
      var1.timetomove = 0.55;
      var1.decc = 0.2;
      break;
    case "3":
      var1.timetomove = 0.6;
      var1.decc = 0.2;
      break;
    case "4":
      var1.timetomove = 0.65;
      var1.decc = 0.2;
      break;
    case "5":
      var1.timetomove = 0.7;
      var1.decc = 0.2;
      break;
    case "6":
      var1.timetomove = 0.75;
      var1.decc = 0.2;
      break;
    case "7":
      var1.timetomove = 0.8;
      var1.decc = 0.2;
      break;
    case "8":
      var1.timetomove = 0.85;
      var1.decc = 0.2;
      break;
    case "9":
      var1.timetomove = 0.9;
      var1.decc = 0.2;
      break;
    case "10":
      var1.timetomove = 0.95;
      var1.decc = 0.2;
      break;
  }

  return var1;
}

function damage_infront_of_train(var0, var1, var2) {
  level endon("convoy4_train_stopped");
  level endon("game_ended");
  var3 = 170;

  if(isDefined(var2)) {
    var3 = var2;
  }

  var4 = var3 * var3;
  var5 = var0.origin;

  for(;;) {
    var5 = var0.origin;

    if(isDefined(var1)) {
      var5 = var0 gettagorigin(var1);
    }

    var6 = [];

    foreach(var8 in level.players) {
      if(isDefined(var8.placedsentries)) {
        foreach(var10 in var8.placedsentries) {
          foreach(var12 in var10) {
            var6 = var12;
          }
        }
      }
    }

    var16 = [];
    var16 = scripts\engine\utility::array_combine(level.players, level.turrets, var6);

    foreach(var18 in var16) {
      if(isPlayer(var18) && !var18 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }

      if(!isalive(var18)) {
        continue;
      }

      if(distancesquared(var18.origin, var5) > var4) {
        continue;
      }

      if(isDefined(var18.turrettype)) {
        var18 notify("kill_turret", 1);
        continue;
      }

      var18 dodamage(200, var5);
    }

    wait 0.25;
  }
}

function wait_for_start_extraction(var0, var1) {
  level endon("game_ended");
  var2 = (0, 0, 90);
  var3 = var0 - (0, 0, 64);
  thread ondefuse(level);
  objective_sethot(var1, 1);
  var4 = 180;

  if(getdvarint("scr_fultontime", 0) > 0) {
    var4 = getdvarint("scr_fultontime", 0);
  }

  thread all_players_fulton();
  thread wait_for_all_extracts();
  thread init_bombs();
  var5 = (-97.881, -441.68, 1024);
  var6 = var4 - 32;
  level thread scripts\cp\infilexfil\cp_fulton::fulton_group_exfil_at_pos(var0 - (0, 0, 64), (0, 237, 0), var6, var5);
  thread wait_extraction_timer(level, var4 - 2);
  level thread scripts\cp\utility::objective_update("convoy4_extraction", var4, var4 - 1, var4 * 0.08333, 1);
  level thread scripts\cp\infilexfil\cp_fulton::ref_123be(var4);
  level waittill("launched_player_fultons");
  level notify("players_fultoned");
  level.obj_players_fultoning = 1;
  wait 0.5;
}

function wait_for_all_extracts() {
  level endon("continue_fulton_extraction");
  var0 = 0;

  foreach(var2 in level.players) {
    if(var2.team == "allies") {
      var0++;
    }
  }

  while(level.obj_used_extract_num < var0) {
    wait 0.1;
  }
}

function wait_extraction_timer(var0, var1) {
  level endon("continue_fulton_extraction");
  thread player_move(level, var0);

  for(var2 = 0; var2 < level.players.size; var2++) {
    level.players[var2] playLoopSound("bomb_tick");
  }

  wait var0;

  for(var2 = 0; var2 < level.players.size; var2++) {
    level.players[var2] stoploopsound("bomb_tick");
  }
}

function player_move(var0, var1) {
  level endon("game_ended");
  level endon("continue_fulton_extraction");
  var2 = var0 - 15;
  wait var2;
  objective_setownerteam(var1, "neutral");

  for(;;) {
    objective_sethot(var1, 1);
    wait 0.65;
    objective_sethot(var1, 0);
    wait 0.65;
  }
}

function ondefuse(var0) {
  level endon("game_ended");
  level endon("continue_fulton_extraction");

  for(var1 = 0; var1 < 15; var1++) {
    magicgrenademanual("deploy_airdrop_mp", getgroundposition(var0, 16), (0, 0, 0), 0.01);
    wait 10;
  }
}

function init_bombs() {
  level endon("game_ended");
  var0 = scripts\engine\utility::getStruct("objective_convoy4_05_a", "targetname");
  level waittill("player_used_extract", var1);
  var2 = 900;
  var3 = createnavbadplacebybounds(var0.origin, (var2, var2, var2), (0, 0, 0));
  level waittill("player_used_extract", var1);
  wait 1;
  destroynavobstacle(var3);
  var2 = 3500;
  var3 = createnavbadplacebybounds(var0.origin, (var2, var2, var2), (0, 0, 0));
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

function are_enemies_nearby(var0, var1) {
  var2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var4 in var2) {
    if(!isDefined(var4) || var4 == self) {
      continue;
    }

    var5 = distance2dsquared(self.origin, var4.origin);

    if(var5 > var1) {
      continue;
    }

    if(var5 <= var0) {
      return true;
    }

    var6 = sighttracepassed(var4 getEye(), self getEye(), 0, var4);

    if(var6) {
      return true;
    }
  }

  return false;
}

function disable_jugg_objective_position_on_death(var0, var1, var2, var3) {
  var4 = thread create_usable_key_model(var0, var0, var1, var2);
}

function create_usable_key_model(var0, var1, var2, var3) {
  self waittill("death");
  var4 = spawn("script_model", self.origin + (0, 0, 5));
  var4 setModel("offhand_wm_cellphone_old");
  var4.angles = (270, 0, 0);
  waitframe();
  var5 = &"CP_QUARRY2_OBJECTIVES/COLLECT_KEY";
  objective_unsetlocation(var1, var2);
  objective_setlocation(var1, var2, self.origin + (0, 0, 15));
  objective_sethot(var1, 1);
  var4 setHintString(var5);
  var4 setCursorHint("HINT_BUTTON");
  var4 sethintdisplayrange(500);
  var4 sethintdisplayfov(65);
  var4 setuserange(72);
  var4 setusefov(65);
  var4 sethintonobstruction("show");
  var4 setuseholdduration("duration_none");
  var4 makeusable();
  thread key_use_think(var4, var0, var1, var2);
  return var4;
}

function key_use_think(var0, var1, var2, var3) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var4);

    if(isDefined(var4)) {
      if(!var4 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      collect_jugg_key(var0, var1, var2, var3, var4);
      scripts\cp\cp_objectives::freeworldidbyobjid(var1);
      remove_jugg_key();
    }
  }
}

function collect_jugg_key(var0, var1, var2, var3, var4) {
  thread play_keys_vo(level);
  level.convoy4_terminal_keys += 1;
  level notify("stop_module_" + var3);
  objective_unsetlocation(var1, var2);
  var4 thread scripts\cp\utility::playerplaypickupanim();
  thread ref_123d7();
  objective_setdescription(var1, &"CP_QUARRY2_OBJECTIVES/CONVOY4_KEYS_1");
  scripts\cp\utility::objective_update("convoy4_keys_" + level.convoy4_terminal_keys);
}

function ref_123d7() {
  var0 = undefined;

  switch (level.convoy4_terminal_keys) {
    case 1:
      var0 = &"CP_QUARRY2_OBJECTIVES/KEYS_HUD_1";
      scripts\cp\utility::ref_123fe("mus_cp_smuggler_keyfound");
      break;
    case 2:
      var0 = &"CP_QUARRY2_OBJECTIVES/KEYS_HUD_2";
      break;
    case 3:
      var0 = &"CP_QUARRY2_OBJECTIVES/KEYS_HUD_3";
      scripts\cp\utility::ref_123fe("mus_cp_smuggler_terminal_activated");
      break;
  }

  if(isDefined(var0)) {
    foreach(var2 in level.players) {
      var2 thread scripts\cp\cp_hud_message::tutorialprint(var0, 4);
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
  var0 = level.players[0];
  level.convoy4_ac130 = var0 scripts\cp\inventory\cp_ac130::spawn_ambient_ac130(var0);
}

function activate_apache_on_player(var0) {
  var1 = scripts\engine\utility::getStruct("obj_apache_dir", "targetname");
  level notify("player_used_quarry_ks");
  var0 thread scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunner();
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
  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var0]]("lbravo_spawner_p3_form_a", 0, 1, 1, 0.1, 0, "lbravo_spawner_p3_form_a", &scripts\cp\cp_modular_spawning::ref_13bac, undefined, undefined);
  [[var0]]("lbravo_spawner_p3_form_b", 0, 1, 1, 0.1, 0, "lbravo_spawner_p3_form_b", &scripts\cp\cp_modular_spawning::ref_13bac, undefined, undefined);
  [[var0]]("lbravo_spawner_p3_form_c", 0, 1, 1, 0.1, 0, "lbravo_spawner_p3_form_c", &scripts\cp\cp_modular_spawning::ref_13bac, undefined, undefined);
  [[var0]]("lbravo_spawner_p3_form_d", 0, 1, 1, 0.1, 0, "lbravo_spawner_p3_form_d", &scripts\cp\cp_modular_spawning::ref_13bac, undefined, undefined);
  [[var0]]("quarry_intro1_chopper", 5, 5, 5, 0.1, 0, "quarry_intro1_chopper", undefined, undefined, undefined);
  [[var0]]("quarry_intro2_chopper", 4, 4, 4, 0.1, 0, "quarry_intro2_chopper", undefined, undefined, undefined);
  [[var0]]("obj_a_roof_jugg", 1, 1, 1, 0.1, 0, "obj_a_roof_jugg", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("obj_a_roof_jugg", &ref_12926);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("obj_a_roof_jugg", undefined, 20000, 30000);
  [[var0]]("convoy4_roof_jugg", 1, 1, 1, 0.1, 0, "convoy4_roof_jugg", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_roof_jugg", &ref_13890);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_roof_jugg", undefined, 20000, 30000);
  [[var0]]("convoy4_roof_rpgs", 4, 6, 10, 0.1, 0, "convoy4_roof_rpgs", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_roof_rpgs", &ref_12d87);
  [[var0]]("convoy4_01a_1", 7, 11, 40, 0.1, 0, "convoy4_01a_1", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_01b_1", 7, 9, 40, 0.1, 0, "convoy4_01b_1", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_01c_1", 7, 9, 40, 0.1, 0, "convoy4_01c_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_01a_1", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_01b_1", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_01c_1", &setup_manual_goalpos);
  [[var0]]("quarry_left", 12, 12, 12, 0.25, 0, "quarry_left", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("quarry_left", &ks_pointsperkingslain);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("quarry_left", undefined, 20000, 30000);
  [[var0]]("quarry_right", 10, 10, 10, 0.25, 0, "quarry_right", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("quarry_right", &ks_pointsperkingslain);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("quarry_right", undefined, 20000, 30000);
  [[var0]]("quarry_fight_across", 12, 12, 12, 0.1, 0, "quarry_fight_across", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("quarry_fight_across", &ref_12956);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("quarry_fight_across", undefined, 20000, 30000);
  [[var0]]("convoy4_snipers_1", 7, 7, 7, 0.1, 0, "convoy4_snipers_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_snipers_1", &ks_pointsperkingslain);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_snipers_1", &ks_pointkingsgetnobonus);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_snipers_1", undefined, 20000, 30000);
  [[var0]]("mortar_guys", 4, 4, 4, 0.1, 0, "mortar_guys", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("mortar_guys", &ref_1295b);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("mortar_guys", undefined, 20000, 30000);
  [[var0]]("spawned_hostage_a", 1, 1, 1, 0.1, 0, "spawned_hostage_a", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_a", &make_civ_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_a", &scripts\cp\cp_hostage::setup_hostage_anims);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_a", &setup_hostage_fulton_anims);
  [[var0]]("spawned_hostage_b", 1, 1, 1, 0.1, 0, "spawned_hostage_b", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_b", &make_civ_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_b", &scripts\cp\cp_hostage::setup_hostage_anims);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_b", &setup_hostage_fulton_anims);
  [[var0]]("spawned_hostage_c", 1, 1, 1, 0.1, 0, "spawned_hostage_c", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_c", &make_civ_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_c", &scripts\cp\cp_hostage::setup_hostage_anims);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostage_c", &setup_hostage_fulton_anims);
  [[var0]]("spawned_hostages_a", 5, 5, 5, 0.1, 0, "spawned_hostages_a", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_a", &scripts\cp\cp_hostage::make_hostage_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_a", &scripts\cp\cp_hostage::setup_hostage_anims);
  [[var0]]("spawned_hostages_b", 5, 5, 5, 0.1, 0, "spawned_hostages_b", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_b", &scripts\cp\cp_hostage::make_hostage_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_b", &scripts\cp\cp_hostage::setup_hostage_anims);
  [[var0]]("spawned_hostages_c", 5, 5, 5, 0.1, 0, "spawned_hostages_c", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_c", &scripts\cp\cp_hostage::make_hostage_usable);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("spawned_hostages_c", &scripts\cp\cp_hostage::setup_hostage_anims);
  [[var0]]("convoy4_02a_1_pre", 8, 8, 10, 2, 0, "convoy4_02a_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_02a_1_pre", &ref_11f52);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_02a_1_pre", &ks_pointsperkingslain);
  [[var0]]("convoy4_02a_1", 6, 12, 200, 2, 0, "convoy4_02a_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_02a_1", &ref_11f52);
  [[var0]]("convoy4_02b_1_pre", 4, 6, 12, 2.25, 0, "convoy4_02b_1", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_02b_2_pre", 4, 8, 10, 1, 0, "convoy4_02b_2", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_02b_1", 4, [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "group_test", 28, 20], 150, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 25, 2], 0, "convoy4_02b_1", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_02b_2", 4, [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "group_test", 28, 8], 250, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 25, 2], 0, "convoy4_02b_2", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_02c_1_pre", 2, 12, 36, 0.1, 0, "convoy4_02c_1", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_02c_1", 2, 28, 250, 0.1, 0, "convoy4_02c_1", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_02c_bomber", 1, 2, 25, 0.1, 0, "convoy4_02c_bomber", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_02c_bomber_mean", 1, 3, 25, 5, 0, "convoy4_02c_bomber_mean", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_03a_1", 1, 24, 250, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_03a_1", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_03a_pre", 5, 5, 5, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_03a_2", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_03a_1", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_03a_pre", undefined, 20000, 30000);
  [[var0]]("convoy4_04a_1", 0, 7, 50, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_04a_1", &watchforjuggstop, undefined, undefined);
  [[var0]]("convoy4_04a_2", 0, 7, 50, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_04a_2", &watchforjuggstop, undefined, undefined);
  [[var0]]("convoy4_04a_3", 0, 7, 50, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_04a_3", &watchforjuggstop, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_04a_1", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_04a_2", &setup_manual_goalpos);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("convoy4_04a_3", &setup_manual_goalpos);
  [[var0]]("convoy4_juggs_1", 1, 1, 1, 0.05, 0, "convoy4_juggs_1", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_juggs_2", 1, 1, 1, 0.05, 0, "convoy4_juggs_2", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_juggs_3", 1, 1, 1, 0.05, 0, "convoy4_juggs_3", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_1", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_2", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_3", undefined, 20000, 30000);
  [[var0]]("convoy4_juggs_1_backup", 1, 1, 1, 0.05, 0, "convoy4_juggs_1_backup", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_juggs_2_backup", 1, 1, 1, 0.05, 0, "convoy4_juggs_2_backup", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_juggs_3_backup", 1, 1, 1, 0.05, 0, "convoy4_juggs_3_backup", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_1_backup", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_2_backup", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_juggs_3_backup", undefined, 20000, 30000);
  [[var0]]("convoy4_roofs_1", 8, [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "group_ending", 24, 8], 250, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_roofs_1", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_roofs_2", 14, [ &scripts\cp\cp_modular_spawning::set_count_based_on_grouped_modules, "group_ending", 24, 16], 250, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "convoy4_roofs_2", &watchforstopwaves, undefined, undefined);
  [[var0]]("convoy4_ending_1", 19, 19, 250, 0.5, 0, "convoy4_ending_1", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_roofs_1", undefined, 20000, 30000);
  [[var0]]("juggheli_spawner_exfil", 2, 2, 2, 0.1, 0, "juggheli_spawner_exfil", &scripts\cp\cp_modular_spawning::disable_kill_off, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("juggheli_spawner_exfil", undefined, 20000, 30000);
  [[var0]]("convoy4_the_smuggler", 1, 1, 1, 0.05, 0, "convoy4_the_smuggler", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("convoy4_the_smuggler", undefined, 20000, 30000);
  [[var0]]("techo_phys_quarry1", 3, 6, 6, 0.1, 0, "techo_phys_quarry1", undefined, undefined, undefined);
  [[var0]]("techo_phys_quarry2", 3, 6, 6, 0.1, 0, "techo_phys_quarry2", undefined, undefined, undefined);
  [[var0]]("techo_phys_quarry3", 3, 6, 6, 0.1, 0, "techo_phys_quarry3", undefined, undefined, undefined);
  [[var0]]("techo_phys_quarry4", 3, 6, 6, 0.1, 0, "techo_phys_quarry4", undefined, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("wave_spawning", &ref_11e4f);
  [[var0]]("cover_guys_debug", 1, 1, 50, 0.1, 0, "cover_guys_debug", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("cover_guys_debug", undefined, 20000, 30000);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("cover_guys_debug", &spawn_in_cover);
}

function ref_11e4f(var0) {
  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    self.never_kill_off = 1;
    self.dont_kill_off = 1;
    return;
  }
}

function ref_1295b(var0) {
  ref_1295c(var0);
}

function ref_1295c(var0) {
  self endon("death");
  level endon("game_ended");
  scripts\common\utility::demeanor_override("sprint");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    self.goalheight = 512;
    var1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");
    var2 = getgroundposition(var1.origin, 16) + (0, 0, 8);
    self.script_origin_other = var2;
    scripts\cp\cp_modular_spawning::set_goal_pos(var2);

    if(isDefined(var1.radius)) {
      scripts\cp\cp_modular_spawning::set_goal_radius(var1.radius);
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

function ref_12956(var0) {
  thread ks_pointsperkingslain(var0);
  thread blueprintextract_beforepickupspawned("quarry_right_spawned", "quarry_right_spawned", "started_hack_at_a");
  thread ref_12957();
}

function ref_12957() {
  self endon("death");
  level endon("game_ended");
  wait 1;
  scripts\common\utility::demeanor_override("cqb");

  foreach(var1 in level.players) {
    if(!var1 scripts\cp\utility::is_valid_player() || !var1 isonground()) {
      continue;
    }

    self getenemyinfo(var1);
  }

  var3 = randomintrange(15, 20);

  while(var3 > 0) {
    if(scripts\cp\utility::any_player_nearby(self.origin, 640000)) {
      break;
    }

    wait 1;
    var3 -= 1;
  }

  scripts\common\utility::demeanor_override("combat");
}

function ks_pointkingsgetnobonus(var0) {
  thread blueprintextract_beforepickupspawned("quarry_left_spawned", "quarry_right_spawned");
}

function ks_pointsperkingslain(var0) {
  setup_manual_goalpos(var0);
  thread blueprintextract_beforepickupspawned("started_hack_at_a");
}

function blueprintextract_beforepickupspawned(var0, var1, var2) {
  self endon("death");
  level endon("game_ended");
  var3 = 20;

  if(!isDefined(var1)) {
    var1 = "forever";
  }

  if(!isDefined(var2)) {
    var2 = "forever";
  }

  level scripts\engine\utility::ref_143a6(var0, var1, var2);

  while(scripts\cp\cp_modular_spawning::has_seen_any_player_recently()) {
    var3 -= 0.25;
    wait 0.25;

    if(scripts\cp\utility::any_player_nearby(self.origin, 360000)) {
      return;
    }

    if(var3 <= 0) {
      return;
    }
  }

  scripts\cp\cp_modular_spawning::script_kill_ai();
}

function watchforstopwaves(var0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var0) {
  level endon("game_ended");
  level waittill("end_wave_convoy4_spawners");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function stopwaveandstartthisone(var0) {
  level notify("end_wave_convoy4_spawners");
  wait 0.5;
  [[var0]]();
}

function watchforjuggstop(var0) {
  level endon("game_ended");
  thread _watchforjuggstop(level);
}

function ref_11f52(var0) {
  if(!isDefined(level.ref_11f54)) {
    return;
  }

  var1 = "cpu_hacking_done";
  thread bomb_label(level.ref_11f54, var1);
  thread ref_11f55(var1);
}

function bomb_label(var0, var1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(var1)) {
    level endon(var1);
  }

  var2 = printdata(var0);
  thread bomb_plant_allowed(var2);

  for(;;) {
    scripts\common\utility::demeanor_override("sprint");
    var3 = getclosestpointonnavmesh(var2.origin);
    var4 = var2.radius;
    self.script_origin_other = var3;
    scripts\cp\cp_modular_spawning::set_goal_pos(var3);
    scripts\cp\cp_modular_spawning::set_goal_radius(var4);
    wait 2;
  }
}

function bomb_on_vehicle_clean_up_monior(var0) {
  var0 notify("ai_goal_distribution_debug");
  var0 endon("ai_goal_distribution_debug");

  for(;;) {
    var1 = var0.origin;
    var2 = var0.radius;
    level thread scripts\engine\utility::draw_circle(var1, var2, (1, 1, 0), 0.5, 0, 20);

    if(isDefined(var0.ref_127ea) && var0.ref_127ea.size) {
      foreach(var4 in var0.ref_127ea) {
        if(isDefined(var4) && isai(var4) && isalive(var4)) {
          var5 = var4 getentitynumber();

          if(!isDefined(var5)) {
            var5 = "agent";
          }
        }
      }
    }

    wait 1;
  }
}

function bomb_plant_allowed(var0) {
  handlemeleekillsteelballs(var0);
  var0.ref_127ea[var0.ref_127ea.size] = self;
  self waittill("death");
  handlemeleekillsteelballs(var0);
}

function printdata(var0) {
  var1 = var0[0];
  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    var4 = var0[var3];

    if(isDefined(var4.script_count_max) && int(var4.script_count_max) <= var4.ref_127ea.size) {
      if(var1 == var4 && var3 < var0.size - 1) {
        var1 = var0[var3 + 1];
      }

      continue;
    } else {
      var2 = var4;
    }

    if(var1.ref_127ea.size > var4.ref_127ea.size) {
      var1 = var4;
    }
  }

  return var1;
}

function ref_11f55(var0) {
  self endon("death");
  level endon("game_ended");
  level waittill(var0);
  wait 1;
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_pos(scripts\engine\utility::random(level.players).origin);
  scripts\cp\cp_modular_spawning::set_goal_radius(500);
}

function handlemeleekillsteelballs(var0) {
  var1 = [];

  foreach(var3 in var0.ref_127ea) {
    if(isDefined(var3) && isalive(var3)) {
      var1 = var3;
    }
  }

  var0.ref_127ea = var1;
}

function ref_12926(var0) {
  thread ref_12927(var0);
}

function isplayerinsiderectangularzonebasedonent() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    wait 0.1;
  }
}

function ref_12927(var0) {
  level endon("game_ended");
  self endon("death");
  scripts\cp\cp_modular_spawning::set_goal_pos(self.script_origin_other);
  scripts\cp\cp_modular_spawning::set_goal_radius(32);
  ref_143cf(1);
  level waittill("cpu_hacking_done");
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(2048);
  var1 = scripts\cp\utility::get_closest_living_player(16000000);

  if(isDefined(var1)) {
    self setgoalpos(var1.origin);
    return;
  }
}

function ref_143cf(var0) {
  for(;;) {
    level waittill("start_hacking_comms_laptop", var1);

    if(isDefined(var1) && isDefined(level.ref_12958) && level.ref_12958 == var0) {
      break;
    }

    wait 0.05;
  }
}

function ref_12d87(var0) {
  thread ref_12d88(var0);
}

function ref_12d88(var0) {
  self endon("death");
  level endon("game_ended");
  wait 0.5;
  thread scripts\common\utility::demeanor_override("sprint");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    var1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");

    if(isDefined(var1)) {
      self.script_origin_other = var1.origin;
      scripts\cp\cp_modular_spawning::set_goal_radius(64);
    }
  } else {
    self.script_origin_other = self.origin;
    scripts\cp\cp_modular_spawning::set_goal_radius(128);
  }

  level waittill("started_hack_at_a");
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(2048);
  var2 = scripts\cp\utility::get_closest_living_player();

  if(isDefined(var2)) {
    self setgoalpos(var2.origin);
    return;
  }
}

function ref_13890(var0) {
  thread ref_13891(var0);
  thread ref_14409();
}

function ref_14409() {
  level endon("game_ended");
  self endon("death");
  level waittill("started_hack_at_b");
  self.ref_14409 = 1;
}

function ref_13891(var0) {
  level endon("game_ended");
  self endon("death");
  scripts\cp\cp_modular_spawning::set_goal_radius(52);

  while(!istrue(self.ref_14409)) {
    wait 1;
    var1 = 650;
    var2 = 64;
    var3 = scripts\cp\utility::get_closest_living_player(var1 * var1);

    if(isDefined(var3) && abs(self.origin[2] - var3.origin[2]) < var2) {
      break;
    }

    if(isDefined(self.maxhealth) && self.health < self.maxhealth / 2) {
      break;
    }
  }

  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(2048);

  for(;;) {
    var4 = scripts\cp\utility::get_closest_living_player();

    if(isDefined(var4)) {
      self setgoalpos(var4.origin);
    }

    wait 10;
  }
}

function _watchforjuggstop(var0) {
  level endon("game_ended");
  level endon("stop_watching_jugg_modules");
  var1 = var0.group_name;
  level waittill("stop_module_" + var1);
  level notify("spawn_module_" + var0.moduleid + "_completed");
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

function setup_manual_goalpos(var0, var1) {
  self notify("basic_combat");
  var2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var2);

  switch (var0.group_name) {
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

function initcommslaptop(var0) {}

function hintcommslaptop(var0, var1) {
  if(istrue(level.convoy4_comms_laptop_int_struct.laptopactive)) {
    return &"CP_OBJECTIVES/HACK";
  }

  return "";
}

function hintcalltraininteract(var0, var1) {
  if(!istrue(level.obj_allow_call_train)) {
    return "";
  }

  var2 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_USE_0";

  switch (level.obj_call_train_count) {
    case 0:
      var2 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_USE_0";
      break;
    case 1:
      var2 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_USE_1";
      break;
    case 2:
      var2 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_USE_2";
      break;
    case 8:
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
      var2 = &"CP_QUARRY2_OBJECTIVES/CONVOY4_CALL_TRAIN_USE_3";
      break;
  }

  return var2;
}

function initcalltraininteract(var0) {
  level.obj_call_train_count = 0;

  foreach(var2 in var0) {
    var2.p_ent_skip_fov = 1;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var2);
    scripts\cp\coop_personal_ents::addtopersonalinteractionlist(var2);
  }
}

function activationcalltraininteract(var0, var1) {
  if(!istrue(level.obj_allow_call_train)) {
    return;
  }

  level.obj_call_train_count++;
  scripts\cp\utility::playsoundatpos_safe(var0.origin, "cp_quarry_train_call_0" + level.obj_call_train_count);
  var2 = hintcalltraininteract(var0, var1);
  scripts\cp\coop_personal_ents::update_pent_hintstring(var0, var2);
  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();

  if(level.obj_call_train_count >= 3) {
    var0.disabled = 1;
    level.obj_allow_call_train = 0;
    level.tracking_hints_calltrain = undefined;
    scripts\cp\coop_personal_ents::delayed_remove_peent_interaction(var0);
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
  var0 = scripts\engine\utility::getStruct("quarry_obit", "targetname");
  var1 = 10000;

  for(;;) {
    var2 = scripts\cp\utility::give_all_players_nearby(var0.origin, var1);

    for(var3 = 0; var3 < var2.size; var3++) {
      if(var2[var3] getclantag() == "egan") {
        thread ref_1436b(var2[var3], var0.origin);
      }
    }

    wait 5;
  }
}

function ref_1436b(var0, var1) {
  level endon("player_triggered_obit");
  self endon("death_or_disconnect");

  if(istrue(self.ref_13c51)) {
    return;
  }

  self.ref_13c51 = 1;
  var2 = 0;

  for(;;) {
    if(distance2dsquared(self.origin, var0) > var1) {
      self.ref_13c51 = undefined;
      return;
    }

    if(var2 > 60) {
      thread ref_11f51();
      return;
    }

    wait 1;
    var2 += 1;
  }
}

function ref_11f51() {
  level notify("player_triggered_obit");
  var0 = getEnt("obit_model", "targetname");
  var0 makeusable();
  var0 setCursorHint("HINT_BUTTON");
  var0 sethintdisplayrange(265);
  var0 sethintdisplayfov(80);
  var0 setuserange(95);
  var0 setusefov(35);
  var0 sethintonobstruction("show");
  var0 setuseholdduration("duration_long");

  for(;;) {
    var0 waittill("trigger", var1);

    if(isDefined(var1)) {
      if(!var1 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      var1 playlocalsound("grenade_pickup");
      thread ref_11f4f(level);
      var0 makeunusable();
    }
  }
}

function ref_11f4f(var0) {
  var1 = &ref_135a7;
  var2 = [];
  var2 = [[[var1]]((7488, -11168, 224), (0, 267.5, 0)), [[var1]]((7488, -11120, 224), (0, 267.5, 0)), [[var1]]((7504, -11120, 224), (0, 267.5, 0)), [[var1]]((7472, -11120, 224), (0, 267.5, 0)), [[var1]]((7536, -11120, 224), (0, 267.5, 0)), [[var1]]((7552, -11120, 224), (0, 267.5, 0)), [[var1]]((7568, -11120, 224), (0, 267.5, 0)), [[var1]]((7568, -11144, 224), (0, 267.5, 0)), [[var1]]((7536, -11144, 224), (0, 267.5, 0)), [[var1]]((7536, -11168, 224), (0, 267.5, 0)), [[var1]]((7552, -11168, 224), (0, 267.5, 0)), [[var1]]((7568, -11168, 224), (0, 267.5, 0)), [[var1]]((7608, -11120, 224), (0, 267.5, 0)), [[var1]]((7608, -11144, 224), (0, 267.5, 0)), [[var1]]((7608, -11168, 224), (0, 267.5, 0)), [[var1]]((7624, -11136, 224), (0, 267.5, 0)), [[var1]]((7640, -11144, 224), (0, 267.5, 0)), [[var1]]((7656, -11136, 224), (0, 267.5, 0)), [[var1]]((7672, -11120, 224), (0, 267.5, 0)), [[var1]]((7672, -11144, 224), (0, 267.5, 0)), [[var1]]((7672, -11168, 224), (0, 267.5, 0)), [[var1]]((7448, -11208, 224), (0, 267.5, 0)), [[var1]]((7464, -11200, 224), (0, 357.5, 0)), [[var1]]((7520, -11232, 224), (0, 267.5, 0)), [[var1]]((7448, -11232, 224), (0, 267.5, 0)), [[var1]]((7448, -11256, 224), (0, 267.5, 0)), [[var1]]((7464, -11264, 224), (0, 357.5, 0)), [[var1]]((7528, -11256, 224), (0, 327.5, 0)), [[var1]]((7464, -11232, 224), (0, 357.5, 0)), [[var1]]((7524, -11208, 224), (0, 252.5, 0)), [[var1]]((7552, -11252, 224), (0, 222.5, 0)), [[var1]]((7560, -11232, 224), (0, 177.5, 0)), [[var1]]((7540, -11196, 224), (0, 182.5, 0)), [[var1]]((7600, -11248, 224), (0, 267.5, 0)), [[var1]]((7608, -11224, 224), (0, 267.5, 0)), [[var1]]((7616, -11200, 224), (0, 267.5, 0)), [[var1]]((7632, -11224, 224), (0, 267.5, 0)), [[var1]]((7640, -11248, 224), (0, 267.5, 0)), [[var1]]((7616, -11232, 224), (0, 357.5, 0)), [[var1]]((7672, -11248, 224), (0, 267.5, 0)), [[var1]]((7672, -11224, 224), (0, 267.5, 0)), [[var1]]((7680, -11208, 224), (0, 282.5, 0)), [[var1]]((7688, -11232, 224), (0, 282.5, 0)), [[var1]]((7696, -11248, 224), (0, 282.5, 0)), [[var1]]((7712, -11248, 224), (0, 267.5, 0)), [[var1]]((7712, -11224, 224), (0, 267.5, 0)), [[var1]]((7712, -11200, 224), (0, 267.5, 0)), [[var1]]((7352, -11304, 224), (0, 267.5, 0)), [[var1]]((7352, -11328, 224), (0, 267.5, 0)), [[var1]]((7352, -11352, 224), (0, 267.5, 0)), [[var1]]((7352, -11376, 224), (0, 267.5, 0)), [[var1]]((7392, -11320, 224), (0, 267.5, 0)), [[var1]]((7424, -11320, 224), (0, 267.5, 0)), [[var1]]((7408, -11312, 224), (0, 192.5, 0)), [[var1]]((7408, -11344, 224), (0, 327.5, 0)), [[var1]]((7424, -11344, 224), (0, 267.5, 0)), [[var1]]((7424, -11368, 224), (0, 267.5, 0)), [[var1]]((7456, -11320, 224), (0, 267.5, 0)), [[var1]]((7456, -11344, 224), (0, 267.5, 0)), [[var1]]((7472, -11352, 224), (0, 297.5, 0)), [[var1]]((7488, -11368, 224), (0, 267.5, 0)), [[var1]]((7472, -11384, 224), (0, 177.5, 0)), [[var1]]((7472, -11312, 224), (0, 267.5, 0)), [[var1]]((7488, -11312, 224), (0, 267.5, 0)), [[var1]]((7528, -11304, 224), (0, 177.5, 0)), [[var1]]((7536, -11312, 224), (0, 282.5, 0)), [[var1]]((7544, -11336, 224), (0, 267.5, 0)), [[var1]]((7528, -11344, 224), (0, 177.5, 0)), [[var1]]((7544, -11360, 224), (0, 267.5, 0)), [[var1]]((7528, -11376, 224), (0, 357.5, 0)), [[var1]]((7584, -11352, 224), (0, 177.5, 0)), [[var1]]((7608, -11352, 224), (0, 177.5, 0)), [[var1]]((7632, -11304, 224), (0, 267.5, 0)), [[var1]]((7664, -11304, 224), (0, 267.5, 0)), [[var1]]((7680, -11328, 224), (0, 267.5, 0)), [[var1]]((7656, -11344, 224), (0, 222.5, 0)), [[var1]]((7632, -11368, 224), (0, 267.5, 0)), [[var1]]((7656, -11376, 224), (0, 177.5, 0)), [[var1]]((7680, -11376, 224), (0, 177.5, 0)), [[var1]]((7720, -11320, 224), (0, 267.5, 0)), [[var1]]((7736, -11304, 224), (0, 267.5, 0)), [[var1]]((7760, -11320, 224), (0, 267.5, 0)), [[var1]]((7760, -11344, 224), (0, 267.5, 0)), [[var1]]((7720, -11344, 224), (0, 267.5, 0)), [[var1]]((7728, -11368, 224), (0, 267.5, 0)), [[var1]]((7752, -11368, 224), (0, 267.5, 0)), [[var1]]((7792, -11304, 224), (0, 267.5, 0)), [[var1]]((7792, -11328, 224), (0, 267.5, 0)), [[var1]]((7792, -11352, 224), (0, 267.5, 0)), [[var1]]((7792, -11376, 224), (0, 267.5, 0)), [[var1]]((7864, -11304, 224), (0, 267.5, 0)), [[var1]]((7856, -11328, 224), (0, 267.5, 0)), [[var1]]((7848, -11352, 224), (0, 267.5, 0)), [[var1]]((7840, -11376, 224), (0, 267.5, 0)), [[var1]]((7848, -11296, 224), (0, 177.5, 0)), [[var1]]((7832, -11296, 224), (0, 177.5, 0))];
  level.breakerstate = [];

  for(var3 = 0; var3 < var2.size; var3++) {
    level.breakerstate[level.breakerstate.size] = thread ref_135a6(var2[var3]);
    wait 0.25;
  }

  wait 30;

  for(var3 = 0; var3 < level.breakerstate.size; var3++) {
    level.breakerstate[var3] delete();
    wait 0.25;
  }
}

function ref_135a7(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0;
  var2.angles = var1;
  return var2;
}

function ref_135a6(var0) {
  var1 = spawn("script_model", var0 + self.origin + (-7500, 11182, 512));
  var1 setModel("toy_teddy_bear_01_brown");

  if(isDefined(self.angles)) {
    var1.angles = self.angles;
  }

  return var1;
}

function ref_11f50() {
  var0 = scripts\engine\utility::getStruct("quarry_obit", "targetname");
  var1 = vehicle_getarray();
  var2 = 2250000;

  foreach(var4 in var1) {
    if(distance2dsquared(var4.origin, var0.origin) < var2) {
      if(isDefined(var4.spawndata) && var4.birthtime < gettime() - 20000) {
        scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(var4);
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

function setup_enemy_sentries(var0) {
  var1 = undefined;

  switch (var0) {
    case 1:
      var1 = "spawner_quarry_1";
      break;
    case 2:
      var1 = "spawner_quarry_2";
      break;
    case 3:
      var1 = "spawner_quarry_3";
      break;
    case 4:
      var1 = "spawner_quarry_4";
      break;
    case 5:
      var1 = "spawner_quarry_5";
      break;
  }

  if(isDefined(var1)) {
    level.initlocationcircle = var1;
    level.initlethalmaxoffsetmap = var1;
    return;
  }
}

function ref_130a8() {
  foreach(var1 in level.players) {
    var1 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340d(2, 1, 1);
  }

  wait 2;

  foreach(var1 in level.players) {
    var4 = scripts\engine\utility::getStruct("camera_ending", "targetname");
    var5 = var4.origin;
    var6 = scripts\engine\utility::getStruct(var4.target, "targetname");
    var7 = spawn("script_model", var5);
    var7 setModel("tag_origin");
    var7.angles = var4.angles;
    var7 moveTo(var6.origin, 20, 1, 1);
    var1 playerhide();
    var1 allowfire(0);
    var1 disableoffhandweapons();
    var1 disableusability();
    var1 allowmovement(0);
    var1 setclientomnvar("ui_hide_hud", 1);
    spawn_endgame_camera(var1, var7);
    var1 lerpfovscalefactor(0, 0);
  }
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

function setup_hostage_fulton_anims(var0, var1) {
  thread thread_hostage_fulton_anims();
}

function thread_hostage_fulton_anims() {
  level scripts\cp\cp_hostage::anim_init_hostage();
  level waittill("gotten_to_extract");
  thread scripts\cp\cp_hostage::anim_fulton_hostage_player_scene(self);
}

function play_vo_delay(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(var4)) {
    wait var4;
  }

  if(isDefined(var0)) {
    level scripts\cp\cp_vo::try_to_play_vo_on_team(var0, "allies", var3, var5, var6);
  }

  if(isDefined(var1)) {
    wait var1;
  }

  if(isDefined(var2)) {
    level thread scripts\cp\utility::cp_add_dialogue_line(var2);
    return;
  }
}

function vo_length(var0) {
  var1 = lookupsoundlength(var0);
  var1 /= 1000;
  return var1;
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

function handle_players_near_hack_b(var0, var1) {
  level endon("game_ended");
  var2 = var1 * var1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var0, var2)) {
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
  var0 = 0.25;
  var1 = 0.1;

  for(;;) {
    if(!istrue(level.i_see_player_shield_watcher)) {
      return;
    }

    var2 = 0;

    for(var3 = 0; var3 < level.players.size; var3++) {
      if(istrue(level.players[var3].inhackring)) {
        var2++;
      }
    }

    if(var2 <= 1) {
      var1 += var0;
    }

    if(var1 > 15) {
      thread play_nag_hack_vo();
      var1 = 0.1;
    }

    wait var0;
  }
}

function play_nag_hack_vo() {
  var0 = ["dx_cps_kama_quarry2_nag_stay_on_hack_10", "dx_cps_kama_quarry2_nag_stay_on_hack_20"];
  thread play_vo_delay(level);
}

function play_hack_vo(var0) {
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
    var1 = var0 scripts\cp\utility::get_closest_living_player();
    scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var1, "obj_sitrep_success");
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

function play_keys_vo(var0) {
  if(!isDefined(level.convoy4_vo_keys)) {
    level.convoy4_vo_keys = 0;
  }

  if(level.convoy4_vo_keys == 0) {
    thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var0, "obj_collect_first");
    thread play_vo_delay(level, "dx_cps_kama_quarry2_two_keys_left_10", undefined, undefined, undefined);
  } else if(level.convoy4_vo_keys == 1) {
    thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var0, "obj_collect_another");
    thread play_vo_delay(level, "dx_cps_kama_quarry2_one_key_left_10", undefined, undefined, undefined);
  } else if(level.convoy4_vo_keys == 2) {
    thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var0, "obj_collect_complete");
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

function ref_123e3(var0) {
  level endon("game_ended");
  level.obj_got_extract = 1;
  wait 0.5;
  thread play_vo_delay(level, "dx_cps_lass_quarry2_extraction_10", undefined);
  wait 90;
  thread play_vo_delay(level, "dx_cps_lass_quarry2_player_fulton_release_10", undefined);
  wait 75;
  thread play_vo_delay(level, "dx_cps_lass_quarry2_extraction_20", undefined);
  wait 18;
  var1 = 0;
  var2 = level.players.size;

  foreach(var4 in level.players) {
    if(!istrue(var4.used_fulton_interact)) {
      var1++;
      level thread scripts\cp\cp_vo::try_to_play_vo_for_one_player("dx_cps_lass_quarry2_extraction_30", var4, 0);
    }
  }

  if(var2 == var1) {
    level notify("convoy4_extraction_failed");
    objective_state(var0, "failed");
    level.i_see_player_vehicle_watcher = 1;
    wait 3;
    scripts\cp\cp_objectives::ref_12868("convoy4_extraction");
    level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
    return;
  }
}

function ref_1240e(var0) {
  level endon("game_ended");
  level endon("players_fultoned");
  var1 = 14400;

  for(;;) {
    var2 = var0 scripts\cp\utility::get_closest_living_player(var1);

    if(isDefined(var2)) {
      break;
    }

    wait 1;
  }

  level notify("players_near_exfil");
  level thread scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var2, "obj_holding");
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

function ref_138bd(var0, var1) {
  wait var0;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var1);
}

function ref_12dd5(var0) {
  var1 = scripts\cp\cp_modular_spawning::run_spawn_module(var0);
  wait 2;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var0);

  if(isDefined(var1.module_vehicles[0]) && isent(var1.module_vehicles[0])) {
    var2 = var1.module_vehicles[0];
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
  level waittill("start_hacking_comms_laptop", var0);
  var1 = scripts\engine\utility::getStruct("obj_alarm_struct", "targetname");
  thread play_alarm_pos(level);
}

function play_alarm_pos(var0) {
  if(isDefined(level.obj_alarm)) {
    level notify("obj_alarm_trigger");
    level.obj_alarm stoploopsound();
    level.obj_alarm delete();
    waitframe();
  }

  level.obj_alarm = scripts\engine\utility::spawn_tag_origin(var0, (0, 0, 0));
  level.obj_alarm show();
  wait 1;
  level.obj_alarm playLoopSound("cp_quarry_alarm_hot_01");
  level waittill("obj_alarm_trigger");
  level.obj_alarm stoploopsound();
  waitframe();
  var1 = lookupsoundlength("cp_quarry_alarm_off_01");
  var1 /= 1000;

  for(var2 = 0; var2 < 6; var2++) {
    level.obj_alarm playSound("cp_quarry_alarm_off_01");
    wait var1;
  }

  level.obj_alarm delete();
}

function his_respawn(var0) {
  level endon("game_ended");

  if(!isDefined(var0)) {
    return;
  }

  var1 = getscriptablearrayinradius("model_hackcrate", "targetname", var0.origin, 1000);

  if(!isDefined(var1)) {
    return;
  }

  if(var1.size == 0) {
    return;
  }

  var2 = var1[0];
  var2 setscriptablepartstate("main", "off");
}

function computer_animation(var0) {
  level endon("game_ended");

  if(!isDefined(var0)) {
    return;
  }

  var1 = getscriptablearrayinradius("model_hackcrate", "targetname", var0.origin, 1000);

  if(!isDefined(var1)) {
    return;
  }

  if(var1.size == 0) {
    return;
  }

  var2 = var1[0];
  var2 setscriptablepartstate("main", "on");
  level waittill("cpu_hacking_done");
  var2 setscriptablepartstate("main", "off");
}

function debug_start_hostages(var0) {
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc");
}

function debug_start_switches(var0) {
  wait 0.5;
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc2");
}

function debug_start_terminal(var0) {
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc3");
}

function debug_start_keys(var0) {
  wait 0.5;
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc4");
}

function debug_start_call(var0) {
  wait 0.5;
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc4");
}

function debug_start_waittrain(var0) {
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc5");
}

function debug_start_extraction(var0) {
  thread teleportstructs_threadedwait("cp_quarry2_convoy4_create_script_completed", "convoy4_debug_start_loc5");
}

function teleportstructs_threadedwait(var0, var1) {
  scripts\engine\utility::flag_wait(var0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", var1, 1);
}

function player_equipment_use_stop() {
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("infil_complete");
  waitframe();
  var0 = (29097, 33602, 496);
  var1 = getnodesinradius(var0, 30, 0, 128);

  foreach(var3 in var1) {
    var3 disconnectnode();
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
  var0 = (29097, 33602, 496);
  var1 = 2250000;

  while(!scripts\cp\utility::any_player_nearby(var0, var1)) {
    wait 0.1;
  }

  announcement("Spawn Debug BadCover Guy");
  level.incomingcallback = scripts\cp\cp_modular_spawning::run_spawn_module("cover_guys_debug");
}

function spawn_in_cover(var0) {
  var1 = self getnearestnode();

  if(isDefined(var1)) {
    var2 = var1.angles;
    var3 = var1.origin;

    if(!issubstr(var1.type, "Prone")) {
      if(issubstr(var1.type, "Left")) {
        var2 += (0, 90, 0);
      } else if(issubstr(var1.type, "Right") || issubstr(var1.type, "Cover Crouch") || issubstr(var1.type, "Conceal") || issubstr(var1.type, "Cover Stand")) {
        var2 -= (0, 90, 0);
      }
    }

    self forceteleport(var3, var2);
    self usecovernode(var1, 1);
    self setgoalnode(var1);
    self.goalradius = 8;
    self.script_origin_other = var3;
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