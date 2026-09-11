/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_donetsk\cp_donetsk_obj_smugglercaches.gsc
************************************************************************/

function smugglercache_init() {
  init_building_num();
  level.ref_11f66 = 0;
  level.ref_11f65 = 0;
  scripts\engine\utility::flag_init("spawned_all_leads");
}

function init_tripwires() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  wait 3;
  tripwire_randomize(level);
  scripts\cp_mp\tripwire::init();
}

function register_smugglercache_objective() {
  level endon("game_ended");
  smugglercache_init();
  scripts\engine\utility::flag_wait("objectives_registered");
  var_0 = &scripts\cp\cp_objectives::registerobjective;
  [[var_0]]("obj_caches", &obj_maj_cache_init, &obj_maj_cache_start, &obj_maj_cache_end, &debugbeatobjective, &debug_start_caches);
  [[var_0]]("obj_caches_adv", &obj_maj_advance_init, &obj_maj_advance_start, &obj_maj_advance_end, &debugbeatobjective);
  [[var_0]]("obj_caches_leads", &obj_maj_leads_init, &obj_maj_leads_start, &obj_maj_leads_end, &debugbeatobjective);
  [[var_0]]("obj_caches_def", &obj_maj_defense_init, &obj_maj_defense_start, &obj_maj_defense_end, &debugbeatobjective);
  [[var_0]]("obj_caches_end", &obj_maj_extract_init, &obj_maj_extract_start, &obj_maj_extract_end, &debugbeatobjective);

  if(getDvar("mapname") == "cp_smuggler") {
    [[var_0]]("obj_nuke_ending");
  }

  thread register_spawn_functions();
}

function obj_maj_cache_init(var_0) {
  level.ref_139b5 = 1;
  level.global_stealth_broken = 0;
  thread spawn_intro_soldiers();
  thread play_intro_vo();
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
}

function obj_maj_cache_start(var_0) {
  level thread scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
  level thread scripts\cp\cp_modular_spawning::set_ambient_max_count(0);
  thread init_tripwires();
  thread setup_comms_obj_a_goals_and_cover();
  thread ref_131f0();
  level.initlocationcircle = "caches_obj_3";
  level.initlethalmaxoffsetmap = "caches_obj_3";
  level waittill("intro_vo_done");
}

function obj_maj_cache_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_caches_adv", "primary", "allies");
}

function obj_maj_advance_init(var_0) {
  level thread scripts\cp\cp_objectives::reset_objective_timers();
  level.obj_found_lead_here_vo = 0;
  level.obj_enemy_incoming_vo = undefined;
  level.ref_139b5 = 1;
}

function obj_maj_advance_start(var_0) {
  var_1 = get_building_loc();
  var_2 = scripts\engine\utility::getStruct(var_1, "targetname");

  switch (get_cache_num()) {
    case 1:
      objective_setdescription(var_0.objectiveindex, &"CP_SMUGGLER/OBJ_ADVANCE");
      break;
    case 3:
    case 2:
      objective_setdescription(var_0.objectiveindex, &"CP_SMUGGLER/OBJ_ADVANCE2");
      thread scripts\cp\utility::objective_update("obj_caches_adv2", undefined, undefined, undefined, 1);
      break;
    case 4:
      objective_setdescription(var_0.objectiveindex, &"CP_SMUGGLER/OBJ_ADVANCE3");
      thread scripts\cp\utility::objective_update("obj_caches_adv3", undefined, undefined, undefined, 1);
      break;
  }

  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlabel(var_0.objectiveindex, &"CP_SMUGGLER/OBJ_ADVANCE_WRLD");
  objective_setlocation(var_0.objectiveindex, 0, var_2.origin);
  level thread scripts\cp\cp_objectives::ref_1317e(var_0, var_2.origin);
  objective_sethot(var_0.objectiveindex, 0);
  level thread scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
  level thread scripts\cp\cp_modular_spawning::set_ambient_max_count(0);

  if(get_cache_num() == 1) {
    thread ref_13557();
  }

  approach_building_wait(level, var_2.origin);
}

function obj_maj_advance_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_caches_leads", "primary", "allies");
}

function obj_maj_leads_init(var_0) {
  var_1 = get_cache_num(1);

  if(var_1 != "1") {
    level.obj_leads_total_size = undefined;
    thread handle_leads_creation(level);
  }

  if(level.obj_cache_num == 1) {
    wait_for_first_lead_pickup(level, var_0);
  }

  thread highlight_leads_in_fov_init();
  thread handle_leads_text();
}

function obj_maj_leads_start(var_0) {
  var_1 = get_cache_num(1);
  var_2 = get_building_loc();
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(var_1 == "1") {
    var_3 = scripts\engine\utility::getStruct("caches_obj_1", "targetname");
    var_4 = scripts\engine\utility::getStruct("caches_obj_2", "targetname");
    var_5 = scripts\engine\utility::getStruct("caches_obj_3", "targetname");
    thread setup_bot_hq(level, var_0);
    thread setup_bot_hq(level, var_0);
    thread setup_bot_hq(level, var_0);
  } else {
    var_3 = scripts\engine\utility::getStruct(var_2, "targetname");
  }

  if(isDefined(var_3)) {
    objective_setlocation(var_0.objectiveindex, 0, var_3.origin);
  }

  if(isDefined(var_4)) {
    objective_setlocation(var_0.objectiveindex, 1, var_4.origin);
  }

  if(isDefined(var_5)) {
    objective_setlocation(var_0.objectiveindex, 2, var_5.origin);
  }

  objective_setlabel(var_0.objectiveindex, &"CP_SMUGGLER/OBJ_FIND_CLUE");
  scripts\cp\cp_objectives::ref_11f80(var_0.objectiveindex);
  thread handle_hints_vo();
  var_1 = get_cache_num(1);

  if(var_1 == "2" || var_1 == "3") {
    thread ref_123c7();
  }

  if(var_1 == "2" || var_1 == "3" || var_1 == "4") {
    thread spawn_trickle_soldiers(level);
  }

  if(var_1 == "4") {
    thread play_approach_tripwire_building();
  }

  level waittill(var_2 + "_clues");
}

function obj_maj_leads_end(var_0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_caches_def", "primary", "allies");
}

function obj_maj_defense_init(var_0) {
  level notify("cache_def_start");
  level.ref_139b5 = 1;
}

function obj_maj_defense_start(var_0) {
  var_1 = get_cache_num(1);
  level.obj_def_time = get_building_def_time();
  var_2 = level.obj_def_time;
  var_3 = int(level.obj_def_time * 0.66);
  var_4 = int(level.obj_def_time * 0.33);
  thread scripts\cp\utility::objective_update("obj_caches_def", level.obj_def_time, var_3, var_4, 1);
  var_5 = get_wave_name();
  level thread scripts\cp\cp_wave_spawning::killstreaks(11, var_5);
  thread keycardlocs(level, var_1);
  thread play_enemy_incoming(level);
  var_6 = get_building_loc();
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  if(var_1 == "1") {
    var_7 = scripts\engine\utility::getStruct("caches_obj_1", "targetname");
    var_8 = scripts\engine\utility::getStruct("caches_obj_2", "targetname");
    var_9 = scripts\engine\utility::getStruct("caches_obj_3", "targetname");
    thread killprojectileafterdelay();
  } else {
    var_7 = scripts\engine\utility::getStruct(var_6, "targetname");
  }

  if(isDefined(var_7)) {
    objective_setlocation(var_0.objectiveindex, 0, var_7.origin);
  }

  if(isDefined(var_8)) {
    objective_setlocation(var_0.objectiveindex, 1, var_8.origin);
  }

  if(isDefined(var_9)) {
    objective_setlocation(var_0.objectiveindex, 2, var_9.origin);
  }

  objective_setbackground(var_0.objectiveindex, 2);
  objective_sethot(var_0.objectiveindex, 0);
  objective_setlabel(var_0.objectiveindex, &"CP_SMUGGLER/OBJ_DEFEND");
  scripts\cp\cp_objectives::ref_11f80(var_0.objectiveindex);
  level.obj_cache_def = 1;
  level.obj_def_cur_time = level.obj_def_time;
  scripts\cp\utility::ref_123fe("mus_cp_smuggler_survive");
  thread ref_11e0f();

  while(level.obj_def_cur_time > 0) {
    wait 1;
    level.obj_def_cur_time -= 1;
  }
}

function obj_maj_defense_end(var_0) {
  thread stop_leads_texts();
  thread delete_all_leads();
  level.obj_cache_def = 0;
  level.obj_def_time = undefined;
  level notify("stop_leads");
  level notify("end_wave_cache_spawners");
  scripts\cp\utility::ref_123fe("");
  play_investigation_done(level);
  scripts\cp\cp_objectives::screenent_c("minor_objective");

  if(level.obj_cache_num < 4) {
    if(level.obj_cache_num == 1) {
      iterate_building_num(3);
      scripts\cp\crate_drops\cp_crate_drops::ref_12c40("cache_1", ["precision_airstrike", "cruise_missile"]);
    } else if(level.obj_cache_num == 2) {
      iterate_building_num(2);
    } else {
      iterate_building_num();
    }

    level thread scripts\cp\cp_kidnapper::togglekidnappers(1);
    reset_totals_texts();
    level thread scripts\cp\cp_objectives::run_objective("obj_caches_adv", "primary", "allies");
    scripts\cp\utility::ref_123fe("mus_cp_smuggler_travel_2");
    return;
  }

  scripts\cp\cp_objectives::overridenextstep(var_0, "obj_tug_of_war");
  scripts\mp\brclientmatchdata::getprophealth("tow_p1");
  level.ref_139b5 = 0;
  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("cache_2a", ["deployable_cover", "ammo_crate"]);
  reset_totals_texts();
  level notify("obj_smug_1_complete");
  thread getcircleindexforpoint();
  scripts\cp\utility::ref_123fe("mus_cp_smuggler_travel_3");
}

function getcircleindexforpoint() {
  var_0 = level.ref_11f66;
  var_1 = int(level.ref_11f66 * 0.7);
  waitframe();

  if(level.ref_11f65 == var_0) {
    scripts\cp\cp_objectives::screenent_c("minor_objective");
  }

  waitframe();

  if(level.ref_11f65 >= var_1) {
    scripts\cp\cp_objectives::screenent_c("minor_objective");
    return;
  }
}

function obj_maj_extract_init(var_0) {}

function obj_maj_extract_start(var_0) {
  var_1 = scripts\engine\utility::getStruct("obj_extract_struct_caches", "targetname");
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("obj_extract_struct_caches");
  waitframe();
  level notify("call_exfil", var_1.origin);
  thread play_extract_reminders();
  level waittill("ready_to_exfil");
}

function obj_maj_extract_end(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    level.players[var_1].ability_invulnerable = 1;
  }

  wait 1;
  play_mission_complete(level);
  wait 1.5;
  wait 3;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function debugbeatobjective(var_0) {
  level notify("debug_beat_" + var_0 + "_objective");
}

function init_building_num() {
  level.obj_cache_num = 1;
}

function iterate_building_num(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  level.obj_cache_num += var_0;
}

function get_cache_num(var_0) {
  var_1 = level.obj_cache_num;

  if(istrue(var_0)) {
    return scripts\engine\utility::string(var_1);
  }

  return var_1;
}

function get_building_loc() {
  return "caches_obj_" + get_cache_num(1);
}

function get_hint_timer() {
  if(!isDefined(level.obj_leads_hint_timer)) {
    level.obj_leads_hint_timer = 50;
  }

  return level.obj_leads_hint_timer;
}

function decrease_hint_timer() {
  if(!isDefined(level.obj_leads_hint_timer)) {
    level.obj_leads_hint_timer = 50;
  }

  if(level.obj_leads_hint_timer > 33) {
    level.obj_leads_hint_timer -= 3;
    return;
  }
}

function get_building_def_time() {
  var_0 = get_cache_num(0);
  var_1 = 0;
  var_2 = 0;
  var_2 = level.obj_leads_found_good * 45;

  switch (var_0) {
    case 1:
      var_1 = 720;
      break;
    case 4:
      var_1 = 270;
      break;
  }

  var_1 -= var_2;
  var_3 = getdvarint("scr_cache_speed", 0);

  if(var_3 != 0) {
    var_1 = var_3;

    if(var_1 < 10) {
      var_1 = 10;
    }
  }

  return var_1;
}

function get_wave_name() {
  var_0 = undefined;

  switch (get_cache_num(0)) {
    case 3:
    case 2:
    case 1:
      var_0 = "smugg_p1_intro";
      break;
    case 4:
      var_0 = "smugg_p1_end";
      break;
  }

  return var_0;
}

function get_building_support_time() {
  var_0 = 0;

  switch (get_cache_num(0)) {
    case 1:
      var_0 = 40;
      break;
    case 3:
    case 2:
      var_0 = 30;
      break;
    case 4:
      var_0 = 20;
      break;
  }

  return var_0;
}

function get_num_ambient() {
  var_0 = 0;

  switch (get_cache_num(0)) {
    case 1:
      var_0 = 12;
      break;
    case 3:
    case 2:
      var_0 = 15;
      break;
    case 4:
      var_0 = 18;
      break;
  }

  return var_0;
}

function approach_building_wait(var_0, var_1) {
  level endon("game_ended");
  var_2 = 825;

  if(level.obj_cache_num == 4) {
    var_2 = 2200;
  }

  var_3 = var_2 * var_2;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_3)) {
      return;
    }

    wait 0.25;
  }
}

function play_bonus_time_sound() {
  if(soundexists("cp_collect_lead_bonus_01")) {
    foreach(var_1 in level.players) {
      var_1 playlocalsound("cp_collect_lead_bonus_01");
    }

    return;
  }
}

function update_leads_timer(var_0) {
  var_1 = level.obj_def_time;
  var_2 = undefined;

  if(level.obj_def_cur_time - var_0 <= 0) {
    if(level.obj_def_cur_time > 5) {
      level.obj_def_cur_time = 5;
    } else {
      return;
    }
  } else {
    level.obj_def_cur_time -= var_0;
  }

  var_2 = level.obj_def_cur_time;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 1;

  if(var_2 < var_1 * 0.33 - var_5) {
    var_3 = var_2 - 1;
    var_4 = var_2 - 2;
  } else if(var_2 < var_1 * 0.66 - var_5) {
    var_3 = var_2 - 1;
    var_4 = int(var_1 * 0.33);
  } else {
    var_3 = int(var_1 * 0.66);
    var_4 = int(var_1 * 0.33);
  }

  thread scripts\cp\utility::objective_update("obj_caches_def", var_2, var_3, var_4, 1);
}

function handle_leads_creation(var_0, var_1) {
  level.obj_leads_found = 0;

  if(scripts\engine\utility::flag_exist("spawned_all_leads")) {
    scripts\engine\utility::flag_clear("spawned_all_leads");
  }

  var_2 = get_leads_type(int(var_0));

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  var_3 = scripts\engine\utility::getStructArray("obj_cache_goodlead_" + var_0, "targetname");
  var_4 = scripts\engine\utility::getStructArray("obj_cache_lead_" + var_0, "targetname");
  var_5 = scripts\engine\utility::getStructArray("obj_cache_obvlead_" + var_0, "targetname");

  foreach(var_7 in var_4) {
    if(isDefined(var_7.script_side) && var_7.script_side != var_2) {
      var_4 = scripts\engine\utility::array_remove(var_4, var_7);
    }
  }

  foreach(var_7 in var_3) {
    if(isDefined(var_7.script_side) && var_7.script_side != var_2) {
      var_3 = scripts\engine\utility::array_remove(var_3, var_7);
    }
  }

  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_4 = scripts\engine\utility::array_randomize(var_4);
  var_11 = 9;
  var_12 = 1;

  if(var_4.size < var_11) {}

  if(get_cache_num(0) == 4) {
    var_11 += 2;
    level.print_leads_text_max = 12;
  } else {
    level.print_leads_text_max = 10;
  }

  var_13 = 0;

  if(var_5.size > 0) {
    for(var_14 = 0; var_14 < var_5.size; var_14++) {
      thread spawn_lead_model(level, var_5[var_14], "obvious");
      var_13++;
    }

    var_11 -= var_13;
  }

  for(var_14 = 0; var_14 < var_11; var_14++) {
    thread spawn_lead_model(level, var_4[var_14], "regular");
  }

  for(var_14 = 0; var_14 < var_12; var_14++) {
    thread spawn_lead_model(level, var_3[var_14], "good");
  }

  var_15 = 0;

  if(isDefined(level.obj_leads_total_size)) {
    var_15 = level.obj_leads_total_size;
  }

  level.obj_leads_total_size = var_11 + var_12 + var_13 + var_15;
  level waittill("spawned_lead");

  while(level.obj_leads_models.size < level.obj_leads_total_size) {
    waitframe();
  }

  thread give_one_lead_to_each_player(level);
  scripts\engine\utility::flag_set("spawned_all_leads");
}

function wait_for_first_lead_pickup(var_0) {
  scripts\engine\utility::flag_wait("spawned_all_leads");

  for(var_1 = 0; var_1 < level.obj_leads_models.size; var_1++) {
    level.obj_leads_models[var_1] makeunusable();
  }

  var_2 = undefined;
  var_3 = scripts\engine\utility::getStructArray("obj_cache_lead_0", "targetname");

  foreach(var_5 in var_3) {
    if(var_5.script_side == "cash") {
      var_2 = var_5;
      break;
    }
  }

  level.obj_leads_found_reg = 0;
  var_7 = spawn_lead_model(level, var_2, "regular", "1");
  var_8 = 0.5;

  foreach(var_10 in level.players) {
    thread highlight_leads_loop(var_10, var_7);
  }

  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setplayoutro(var_0.objectiveindex, 1);
  objective_state(var_0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var_0.objectiveindex);
  objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlabel(var_0.objectiveindex, &"CP_SMUGGLER/INVESTIGATE");
  objective_setlocation(var_0.objectiveindex, 0, var_7.origin + (0, 0, 12));
  objective_sethot(var_0.objectiveindex, 0);
  var_7 makeunusable();
  level waittill("obj_cash_nearby");
  objective_sethot(var_0.objectiveindex, 0);
  objective_setlabel(var_0.objectiveindex, &"CP_SMUGGLER/ANALYZING");
  level waittill("obj_cash_seen");
  var_7 makeusable();
  objective_setlabel(var_0.objectiveindex, &"CP_SMUGGLER/CAPTURE");
  objective_sethot(var_0.objectiveindex, 0);
  level waittill("lead_collected");
  level.ref_13e9f = 1;

  for(var_1 = 0; var_1 < level.obj_leads_models.size; var_1++) {
    level.obj_leads_models[var_1] makeusable();
  }
}

function get_leads_type(var_0) {
  var_1 = ["paper", "cash"];
  var_2 = undefined;
  var_3 = level.obj_cache_num;

  if(isDefined(var_0)) {
    var_3 = var_0;
  }

  switch (var_3) {
    case 1:
      var_2 = "cash";
      break;
    case 3:
    case 2:
      var_2 = "paper";
      break;
    case 4:
      var_2 = "cash";
      break;
  }

  level.obj_leads_type = var_2;
  return var_2;
}

function spawn_lead_model(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0.origin);
  var_3 setModel(var_0.script_noteworthy);
  var_4 = var_0.angles;

  if(!isDefined(var_4)) {
    var_4 = (0, 0, 0);
  }

  var_3.angles = var_4;
  var_3.type = var_1;
  waitframe();
  var_5 = &"CP_SMUGGLER/COLLECT_LEAD";
  var_3 setHintString(var_5);
  var_3 setCursorHint("HINT_BUTTON");
  var_3 sethintdisplayrange(70);
  var_3 sethintdisplayfov(40);
  var_3 setuserange(70);
  var_3 setusefov(35);

  if(var_1 == "obvious") {
    var_3 sethintdisplayfov(150);
  }

  if(isDefined(var_0.script_parameters) && var_0.script_parameters == "true") {
    var_3 sethintonobstruction("show");
  } else {
    var_3 sethintonobstruction("hide");
  }

  if(isDefined(var_0.script_label)) {
    var_3.script_label = var_0.script_label;
  }

  var_3 setuseholdduration("duration_none");
  var_3 makeusable();
  thread lead_use_think(var_3, var_1);

  if(!isDefined(level.obj_leads_models)) {
    level.obj_leads_models = [];
  }

  level.obj_leads_models[level.obj_leads_models.size] = var_3;
  level.ref_11f66++;
  level notify("spawned_lead");
  return var_3;
}

function ref_13557() {
  level.obj_leads_total_size = undefined;
  thread handle_leads_creation(level);
  thread handle_leads_creation(level);
  thread handle_leads_creation(level);
  scripts\engine\utility::flag_wait("spawned_all_leads");
  wait 1;

  for(var_0 = 0; var_0 < level.obj_leads_models.size; var_0++) {
    level.obj_leads_models[var_0] makeunusable();
  }
}

function lead_debug_show(var_0, var_1) {
  self endon("lead_taken");
  var_2 = (1, 0, 0);

  if(var_1 == "good") {
    var_2 = (0, 1, 0);
  }

  for(;;) {
    waitframe();
  }
}

function lead_use_think(var_0, var_1) {
  self endon("death");
  self endon("lead_taken");

  for(;;) {
    self waittill("trigger", var_2);

    if(isDefined(var_2)) {
      if(!var_2 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(istrue(var_2.isdeploying)) {
        continue;
      }

      if(istrue(var_2.listen_for_adrenaline_use)) {
        continue;
      }

      thread collect_lead(level, self, var_0, var_2);
    }
  }
}

function collect_lead(var_0, var_1, var_2, var_3) {
  var_4 = level.obj_cache_num;
  var_5 = var_0.origin;

  if(var_1 == "regular" || var_1 == "obvious") {
    thread play_find_lead(level);
  } else if(var_1 == "good") {
    thread play_find_lead_good(level);
  }

  var_2.listen_for_adrenaline_use = 1;
  var_0 makeunusable();

  if(var_2 scripts\cp\utility::playerplaytakephotoanim() == 0) {
    var_0 makeusable();

    if(isDefined(var_2) && isPlayer(var_2)) {
      var_2.listen_for_adrenaline_use = undefined;
    }

    return;
  }

  level.obj_leads_found++;
  level.ref_11f65++;

  if(var_1 == "regular" || var_1 == "obvious") {
    level.obj_leads_found_reg++;
    thread play_find_lead(level, undefined);
  } else if(var_1 == "good") {
    level.obj_leads_found_good++;
    thread play_find_lead_good(level, undefined);
  }

  if(isDefined(level.obj_def_time)) {
    thread print_bonus_time_text(level, var_1);
    thread play_bonus_time_sound();
    thread update_leads_timer(level);
  }

  if(soundexists("cp_collect_lead_01")) {
    if(isent(var_0)) {
      var_0 playSound("cp_collect_lead_01");
    } else {
      playsoundatpos(var_5, "cp_collect_lead_01");
    }
  }

  var_2 thread scripts\cp\drone\emp_drone::giverankxp("assist_marked", 50);
  thread ref_124df();

  if(isent(var_0)) {
    remove_lead(var_0);
  }

  level notify("lead_collected", var_1, var_3);
  thread ref_123e6();
  level.smuggler_last_collector = var_2;
}

function ref_124df() {
  self endon("disconnect");
  wait 1;

  if(isDefined(self) && isPlayer(self)) {
    self.listen_for_adrenaline_use = undefined;
    return;
  }
}

function remove_lead() {
  playFX(level._effect["equipment_smoke"], self.origin);
  self notify("lead_taken");
  thread hasdonestartmusic();
  var_0 = scripts\engine\utility::array_find(level.obj_leads_models, self);

  if(isDefined(var_0) && isDefined(level.obj_leads_models[var_0].script_label)) {
    level.obj_leads_models[var_0].script_label = undefined;
  }

  self makeusable();
  var_1 = &"CP_SMUGGLER/LEAD_ALREADY";
  self setHintString(var_1);
  self setCursorHint("HINT_NOBUTTON");
  self sethinticon("hud_icon_head_equipment_friendly");
  self sethintdisplayfov(80);
  self setuseholdduration("duration_none");
  self hudoutlinedisable();
  self.is_collected = 1;
}

function delete_all_leads() {
  foreach(var_1 in level.obj_leads_models) {
    level.obj_leads_models = scripts\engine\utility::array_remove(level.obj_leads_models, var_1);
    hasdonestartmusic(var_1);
    var_1 delete();
  }
}

function give_one_lead_to_each_player(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2].type == "obvious") {
      var_1 = var_0[var_2];
    }
  }

  if(var_1.size == 0) {
    return;
  }

  var_3 = 0;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(level.players[var_2].team == "allies") {
      associate_lead_with_player(var_1[var_3], level.players[var_2]);
      thread handle_associated_lead_disconnect(var_1[var_3], level.players[var_2]);
      thread handle_associated_lead_lookat(var_1[var_3], level.players[var_2]);
      var_3++;
    }
  }
}

function associate_lead_with_player(var_0, var_1) {
  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(level.players[var_2] != var_1) {
      var_0 hidefromplayer(var_1);
      continue;
    }

    var_0.associated_player = var_1;
  }
}

function dissociate_from_player(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(isent(var_0) && isPlayer(level.players[var_1])) {
      var_0 showtoplayer(level.players[var_1]);
    }
  }
}

function handle_associated_lead_disconnect(var_0, var_1) {
  level endon("game_ended");
  level endon("stop_leads");
  var_1 waittill("disconnect");

  if(isDefined(var_0) && isent(var_0)) {
    dissociate_from_player(var_0);
    return;
  }
}

function handle_associated_lead_lookat(var_0, var_1) {
  level endon("game_ended");
  level endon("stop_leads");
  var_1 endon("disconnect");

  for(;;) {
    var_0 waittill("seen", var_2);

    if(var_2 != var_1) {
      continue;
    }

    dissociate_from_player(var_0);
    return;
  }
}

function handle_leads_text() {
  level endon("game_ended");
  level endon("stop_leads");
  var_0 = get_building_loc();
  level.obj_leads_found_reg = 0;
  level.obj_leads_found_good = 0;
  level.print_leads_text_max = 3;
  print_total_leads_text(level.obj_leads_found);
  print_type_text(level.obj_leads_type);

  for(;;) {
    level waittill("lead_collected", var_1);
    print_total_leads_text(level.obj_leads_found);
    print_type_text(level.obj_leads_type);

    if(level.obj_leads_found == level.obj_leads_total_size) {
      thread change_texts_green();
    }

    if(level.obj_leads_found == 3) {
      thread collected_enough_leads(level);
    }
  }
}

function collected_enough_leads(var_0) {
  level notify(var_0 + "_clues");
}

function print_total_leads_text(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 2:
    case 1:
    case 0:
      var_1 = "obj_caches_collect_total_1";
      thread scripts\cp\utility::objective_update(var_1, undefined, undefined, undefined, undefined, var_0);
      break;
    case 12:
    case 11:
    case 10:
    case 9:
    case 8:
    case 7:
    case 6:
    case 5:
    case 4:
    case 3:
      thread ref_12c63();
      break;
  }
}

function print_type_text(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "paper":
      var_1 = "obj_caches_collect_type_1";
      break;
    case "cash":
      var_1 = "obj_caches_collect_type_2";
      break;
  }

  thread scripts\cp\utility::objective_update(var_1);
}

function print_bonus_time_text(var_0, var_1) {
  var_2 = &"CP_SMUGGLER/LEADS_BONUS_REG";
  var_3 = 30;
  var_1 thread scripts\cp\cp_hud_message::tutorialprint(var_2, 3.75);
}

function fade_text_over_time(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  if(!isDefined(var_2)) {
    var_2 = 0.2;
  }

  if(isDefined(var_3)) {
    wait var_3;
  }

  if(var_1 <= 0) {
    var_1 = 0.1;
  }

  var_0.alpha = 1;
  var_4 = var_2 / var_1;
  var_5 = 1;

  while(var_5 > 0) {
    var_0.alpha = var_5;
    wait var_2;
    var_5 -= var_4;
  }

  var_0.alpha = 0;
}

function change_texts_green() {
  if(isDefined(level.obj_hud_text_leadstotal)) {
    level.obj_hud_text_leadstotal.color = (0, 1, 0);
    thread fade_text_over_time(level.obj_hud_text_leadstotal, level.obj_hud_text_leadstotal, 4, undefined);
  }

  if(isDefined(level.obj_hud_text_type)) {
    level.obj_hud_text_type.color = (0, 1, 0);
    thread fade_text_over_time(level.obj_hud_text_type, level.obj_hud_text_type, 4, undefined);
  }

  thread reset_totals_texts();
}

function reset_totals_texts() {
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_caches_collect_type_1");
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_caches_collect_type_2");
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_caches_collect_total_1");
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_caches_collect_total_2");
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_caches_collect_total_3");
}

function ref_12c63() {
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_caches_collect_total_1");
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_caches_collect_total_2");
  scripts\cp\cp_objectives::reset_subobjective_slot("obj_caches_collect_total_3");
}

function stop_leads_texts() {
  if(isDefined(level.obj_hud_text_leadstotal)) {
    level.obj_hud_text_leadstotal destroy();
  }

  if(isDefined(level.obj_hud_text_type)) {
    level.obj_hud_text_type destroy();
    return;
  }
}

function propchangeto() {
  var_0 = "caches_obj_1";

  switch (level.obj_cache_num) {
    case 1:
      var_0 = "caches_obj_1";
      break;
    case 2:
      var_0 = "caches_obj_2";
      break;
    case 3:
      var_0 = "caches_obj_3";
      break;
    case 4:
      var_0 = "caches_obj_4";
      break;
  }

  return var_0;
}

function setup_comms_obj_a_goals_and_cover() {
  var_0 = 600;
  var_1 = scripts\engine\utility::getStruct("caches_obj_4", "targetname");
  var_2 = createnavbadplacebybounds(var_1.origin, (var_0, var_0, var_0), (0, 0, 0));
  level waittill("stop_leads");
  destroynavobstacle(var_2);
}

function highlight_leads_in_fov_init() {
  foreach(var_1 in level.players) {
    thread highlight_leads_in_fov_player();
  }
}

function highlight_leads_in_fov_player() {
  level endon("game_ended");
  level endon("stop_leads");
  self endon("disconnect");
  var_0 = 0.5;
  scripts\engine\utility::flag_wait("spawned_all_leads");

  for(;;) {
    var_1 = level.obj_leads_models;
    thread highlight_leads_loop(var_1, var_0);
    level waittill("lead_collected");
  }
}

function setup_bot_hq(var_0, var_1) {
  level endon("game_ended");
  level endon("stop_leads");
  self endon("disconnect");
  var_2 = undefined;
  var_3 = 10;

  if(var_1 == "4") {
    var_3 = 12;
  }

  var_4 = 0;
  var_5 = undefined;

  switch (var_1) {
    case "1":
      var_5 = 0;
      break;
    case "2":
      var_5 = 1;
      break;
    case "3":
      var_5 = 2;
      break;
  }

  if(!isDefined(var_5)) {
    return;
  }

  scripts\engine\utility::flag_wait("spawned_all_leads");

  for(;;) {
    level waittill("lead_collected", var_6, var_2);

    if(isDefined(var_2) && var_2 == var_1) {
      var_4++;
    }

    if(var_4 >= var_3) {
      objective_unsetlocation(var_0.objectiveindex, var_5);
    }
  }
}

function highlight_leads_loop(var_0, var_1) {
  level endon("game_ended");
  level endon("stop_leads");
  level endon("lead_collected");
  self endon("disconnect");
  var_2 = 120;
  var_3 = var_2 * var_2;
  jumpiftrue(isarray(var_0)) LOC_0000003a;
  var_4 = var_0;
  var_0 = [var_4];

  for(;;) {
    var_5 = self getEye();
    var_6 = self getplayerangles();

    for(var_7 = 0; var_7 < var_0.size; var_7++) {
      if(istrue(var_0[var_7].is_collected)) {
        continue;
      }

      if(distancesquared(var_5, var_0[var_7].origin) > var_3) {
        var_0[var_7] hudoutlinedisableforclient(self);
        continue;
      }

      if(scripts\engine\utility::within_fov(var_5, var_6, var_0[var_7].origin, var_1)) {
        var_0[var_7] hudoutlineenableforclient(self, "outline_intel_capture");

        if(isDefined(var_0[var_7].associated_player) && self == var_0[var_7].associated_player) {
          var_0[var_7] notify("seen", self);
        }

        continue;
      }

      var_0[var_7] hudoutlinedisableforclient(self);
    }

    waitframe();
  }
}

function tripwire_randomize() {
  var_0 = scripts\engine\utility::getStructArray("tripwires_1", "targetname");
  var_1 = scripts\engine\utility::getStructArray("tripwires_2", "targetname");
  var_2 = scripts\engine\utility::getStructArray("tripwires_3", "targetname");
  var_3 = scripts\engine\utility::getStructArray("tripwires_4", "targetname");
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = scripts\engine\utility::array_randomize(var_1);
  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_4 = 0;
  var_5 = 3;
  var_6 = 4;
  var_7 = 18;
  var_8 = var_0.size - var_4;
  var_9 = var_1.size - var_5;
  var_10 = var_2.size - var_6;
  var_11 = var_3.size - var_7;

  for(var_12 = 0; var_12 < var_8; var_12++) {
    remove_from_struct_array("script_noteworthy", var_0[var_12].script_noteworthy, var_0[var_12]);
  }

  for(var_12 = 0; var_12 < var_9; var_12++) {
    remove_from_struct_array("script_noteworthy", var_1[var_12].script_noteworthy, var_1[var_12]);
  }

  for(var_12 = 0; var_12 < var_10; var_12++) {
    remove_from_struct_array("script_noteworthy", var_2[var_12].script_noteworthy, var_2[var_12]);
  }

  for(var_12 = 0; var_12 < var_11; var_12++) {
    remove_from_struct_array("script_noteworthy", var_3[var_12].script_noteworthy, var_3[var_12]);
  }
}

function remove_from_struct_array(var_0, var_1, var_2) {
  if(isDefined(level.struct_class_names[var_0]) && isDefined(level.struct_class_names[var_0][var_1]) && scripts\engine\utility::array_contains(level.struct_class_names[var_0][var_1], var_2)) {
    level.struct_class_names[var_0][var_1] = scripts\engine\utility::array_remove(level.struct_class_names[var_0][var_1], var_2);
    return;
  }
}

function spawn_trickle_soldiers(var_0) {
  level endon("stop_leads");
  wait 5;
  level.ref_135a2 = scripts\cp\cp_modular_spawning::run_spawn_module("soldier_cache_" + var_0 + "_trickle");
}

function keycardlocs(var_0, var_1) {
  wait var_1;
  level.spawn_module_current = scripts\cp\cp_modular_spawning::run_spawn_module("soldier_cache_" + var_0);
}

function wait_for_near_extract(var_0, var_1) {
  var_2 = var_1 * var_1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0, var_2)) {
      break;
    }

    wait 0.5;
  }
}

function spawn_intro_soldiers() {
  scripts\engine\utility::flag_wait("cp_smugglercaches_north_create_script_completed");
  wait 0.5;
  level.spawn_module_intro = scripts\cp\cp_modular_spawning::run_spawn_module("first_house_guards");
}

function register_spawn_functions() {
  if(!scripts\engine\utility::flag_exist("cp_smugglercaches_north_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_smugglercaches_north_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_smugglercaches_north_create_script_completed");
  scripts\cp\cp_destruction::destructible_interactions();
  var_0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  scripts\cp\coop_stealth::coop_stealth_init();
  [[var_0]]("first_house_guards", 10, 10, 10, 0.1, 0, "first_house_guards", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("first_house_guards", &ref_1320c);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("first_house_guards", &scripts\cp\coop_stealth::regular_enemy_death_func);
  [[var_0]]("soldier_cache_1", 10, 10, 30, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_1", &watchforstopwaves, undefined, undefined);
  [[var_0]]("soldier_cache_2", 10, 10, 30, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_2", &watchforstopwaves, undefined, undefined);
  [[var_0]]("soldier_cache_2_trickle", 2, 5, 100, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_2", &watchforstopwaves, undefined, undefined);
  [[var_0]]("soldier_cache_3", 10, 10, 30, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_3", &watchforstopwaves, undefined, undefined);
  [[var_0]]("soldier_cache_3_trickle", 2, 5, 100, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_3", &watchforstopwaves, undefined, undefined);
  [[var_0]]("school_guards", 8, 10, 40, 0.1, 0, "school_guards", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("school_guards", &ref_12ee9);
  [[var_0]]("soldier_cache_4", 10, 10, 30, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_4", &watchforstopwaves, undefined, undefined);
  [[var_0]]("soldier_cache_4_trickle", 3, 6, 100, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_4", &watchforstopwaves, undefined, undefined);
  [[var_0]]("school_guards_chopper", 6, 6, 6, 0.1, 0, "school_guards_chopper", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("school_guards_chopper", undefined, 20000, 30000);
  setup_enemy_sentry(var_0, "obj_cache_techo_1");
  setup_enemy_sentry(var_0, "obj_cache_techo_2");
  setup_enemy_sentry(var_0, "techo_phys_cache2");
  setup_enemy_sentry(var_0, "techo_phys_cache3");
  setup_enemy_sentry(var_0, "techo_phys_cache4");
  setup_enemy_sentry(var_0, "techo_phys_cache1");
  setup_enemy_sentry(var_0, "techo_phys_cache5");
  setup_enemy_sentry(var_0, "techo_phys_cache6");
}

function ref_12ee9(var_0) {
  var_1 = "school_guards_pursue";
  thread ref_12eea(var_1);
  thread ref_12eec(var_1);
  thread ref_12eed(var_1);
}

function ref_12eec(var_0) {
  self endon(var_0);
  level endon("game_ended");
  self endon("death");

  if(!isDefined(self.aitype) || self.aitype != "rpg") {
    return;
  }

  if(!isDefined(level.ref_12eeb)) {
    level.ref_12eeb = [];
  }

  level.ref_12eeb[level.ref_12eeb.size] = self;
  jumpiftrue(isDefined(level.ref_12dca)) LOC_000000a9;
  level.ref_12dca = getEntArray("rpg_shoot_at_trig", "targetname");

  if(!isDefined(level.ref_12dca) || level.ref_12dca.size == 0) {
    return;
  }

  foreach(var_2 in level.ref_12dca) {
    thread ref_12dc9();
  }

  for(;;) {
    self waittill("fire_rpg_at", var_4);
    var_5 = spawn("script_model", var_4.origin);
    var_5 setModel("tag_origin");
    self setentitytarget(var_5, 1);
    var_6 = scripts\engine\utility::ref_143b9(5, "shooting");
    self clearentitytarget();
    var_5 delete();
  }
}

function ref_12dc9() {
  level endon("game_ended");
  self endon("death");
  self notify("rpg_shoot_at_trig_watch");
  self endon("rpg_shoot_at_trig_watch");
  level.ref_11fa7 = undefined;

  for(;;) {
    self waittill("trigger", var_0);

    if(!isDefined(level.ref_12eeb) || level.ref_12eeb.size == 0) {
      continue;
    }

    if(isDefined(var_0) && isPlayer(var_0)) {
      var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");
      var_1 = sortbydistance(var_1, var_0.origin);
      level.ref_12eeb = scripts\engine\utility::array_randomize(level.ref_12eeb);
      var_2 = 0;

      foreach(var_4 in level.ref_12eeb) {
        if(isDefined(var_4) && isalive(var_4)) {
          for(var_5 = 0; var_5 < var_1.size; var_5++) {
            var_6 = var_1[var_5];

            if(sighttracepassed(var_4.origin + (0, 0, 62), var_6.origin, 0, var_4, 0)) {
              var_4 notify("fire_rpg_at", var_6);
              var_7 = var_4 getEye();
              var_8 = var_4 scripts\engine\utility::ref_143b9(5, "shooting");

              if(isDefined(var_8) && var_8 == "shooting") {
                var_2 = 1;
              }

              break;
            }
          }
        }

        if(var_2) {
          break;
        }

        waitframe();
      }
    }

    wait randomintrange(6, 10);
  }
}

function ref_12eea(var_0) {
  self endon(var_0);
  level endon("game_ended");
  self endon("death");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    var_1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");

    if(isDefined(var_1)) {
      self.script_origin_other = var_1.origin;
      scripts\cp\cp_modular_spawning::set_goal_pos(var_1.origin);
      var_2 = 128;
      jumpiffalse(isDefined(var_1.radius)) LOC_0000007c;
      var_2 = int(var_1.radius);

      for(;;) {
        scripts\cp\cp_modular_spawning::set_goal_radius(var_2);
        var_3 = 280;
        var_4 = 48;
        var_5 = scripts\cp\utility::get_closest_living_player(36000000);

        if(isDefined(var_5)) {
          var_6 = var_5.origin - self.origin;
          var_7 = length2dsquared(var_6) < var_3 * var_3;
          var_8 = abs(var_5.origin[2] - self.origin[2]) < var_4;

          if(var_7 && var_8) {
            self notify(var_0);
            return;
          }
        }

        wait 2;
      }

      return;
    }

    return;
  }
}

function ref_12eed(var_0) {
  level endon("game_ended");
  self endon("death");
  wait 1;
  self waittill(var_0);
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(900);
  thread scripts\cp\cp_modular_spawning::prepdoorsforunload();
  level waittill("stop_leads");

  while(scripts\cp\cp_modular_spawning::has_seen_any_player_recently()) {
    wait 0.5;
  }

  scripts\cp\cp_modular_spawning::script_kill_ai();
}

function setup_enemy_sentry(var_0, var_1) {
  [[var_0]](var_1, 6, 6, 6, 0.1, 0, var_1, &watchforstopwaves, undefined, undefined);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, var_1);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group(var_1, undefined, 20000, 30000);
}

function watchforstopwaves(var_0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var_0) {
  level endon("game_ended");
  level waittill("end_wave_cache_spawners");
  level notify("spawn_module_" + var_0.moduleid + "_completed");
}

function stopwaveandstartthisone(var_0) {
  level notify("end_wave_cache_spawners");
  wait 0.5;
  [[var_0]]();
}

function ref_1320c(var_0, var_1) {
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
}

function spawn_support_wave_handler() {
  level endon("game_ended");
  level endon("stop_leads");
  var_0 = get_cache_num(1);
  var_1 = get_building_support_time();
  var_2 = 0;
  var_3 = get_num_ambient();

  for(;;) {
    var_4 = level scripts\engine\utility::ref_143ba(var_1, "lead_collected", "cache_def_start");

    if(var_4 == "timeout" || var_4 == "cache_def_start") {
      if(var_4 == "cache_def_start") {
        wait 10;
      }

      return;
    }
  }
}

function ref_12df9() {
  level endon("game_ended");
  level endon("stop_leads");
  var_0 = get_cache_num(1);

  if(var_0 == "1") {
    thread play_vo_delay(level);
    thread ref_12dd5(level);
    thread ref_12dd5(level);
    wait 60;
    thread ref_12dd5(level);
    thread ref_12dd5(level);
    thread watchbrc130airdropchuteanimend();
    return;
  }

  if(var_0 == "2" || var_0 == "3") {
    thread ref_12dd5(level);
    thread ref_12dd5(level);
    thread watchbrc130airdropchuteanimend();
    return;
  }

  if(var_0 == "4") {
    thread ref_12e01(level, "techo_phys_cache1", 45);
    thread ref_12e01(level, "techo_phys_cache5", 45);
    thread ref_12e01(level, "techo_phys_cache6", 100);
    return;
  }
}

function ref_12deb() {
  level endon("game_ended");
  level endon("stop_leads");
  var_0 = get_cache_num(1);

  if(var_0 == "4") {
    for(;;) {
      var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("school_guards_chopper");
      wait 45;
      ref_143a0(18);
    }

    return;
  }
}

function ref_143a0(var_0) {
  level endon("game_ended");

  for(;;) {
    var_1 = 0;
    var_2 = 0;

    if(!isDefined(level.agentarray)) {
      break;
    }

    foreach(var_4 in level.agentarray) {
      if(isDefined(var_4.isactive) && var_4.isactive) {
        var_1++;
      }

      if(isDefined(var_4.never_kill_off) && var_4.never_kill_off) {
        var_2++;
      }
    }

    if(var_1 < var_0) {
      break;
    }

    wait 1;
  }
}

function ref_12de5() {
  var_0 = get_cache_num(1);

  if(var_0 == "4") {
    var_1 = scripts\cp\cp_modular_spawning::run_spawn_module("school_guards");
    return;
  }
}

function watchbrc130airdropchuteanimend() {
  wait 10;
  thread ref_12dd5(level);
}

function ref_12e01(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("stop_leads");
  var_3 = 30;

  if(isDefined(var_1)) {
    wait var_1;
  }

  var_4 = scripts\cp\cp_modular_spawning::run_spawn_module(var_0);

  while(var_3 > 0) {
    if(isDefined(var_4.module_vehicles[0]) && isent(var_4.module_vehicles[0])) {
      break;
    }

    wait 1;
    var_3--;
  }

  if(var_3 <= 0) {
    return;
  }

  var_5 = var_4.module_vehicles[0];
  thread ref_14350();

  if(isDefined(var_2) && var_2 > 0) {
    thread ref_12cae(var_5, var_4, var_0);
  }

  var_5 scripts\engine\utility::ref_143a5("unloading", "death");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_0);
}

function ref_12cae(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("stop_leads");
  var_3 = scripts\engine\utility::ref_143ad("death", "unloaded");
  var_4 = self.origin;

  if(isDefined(var_3) && var_3 == "death") {
    wait 1;

    if(isDefined(var_0) && isDefined(var_0.ai_spawned)) {
      var_5 = 0;

      foreach(var_7 in var_0.ai_spawned) {
        if(isDefined(var_7) && isalive(var_7) && !var_7 scripts\engine\utility::doinglongdeath()) {
          var_5++;
        }
      }

      if(var_5 <= 1) {
        var_2--;
        thread ref_12e01(level, var_1, 1);
        return;
      }

      return;
    }

    return;
  }
}

function ref_12dd5(var_0) {
  level endon("game_ended");
  level endon("stop_leads");
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
      scripts\common\vehicle::vehicle_unload("default");
      self stoppath(1);
      return;
    }
  }
}

function play_intro_vo() {
  wait 4;
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
  thread max_steps_before_stability_loss();

  if(getdvarint("intro_vo") < 1) {
    scripts\mp\vehicles\vehicle_damage_mp::ref_12409("kama");
    play_vo_delay(level, "dx_cps_kama_cache_collection_brief_10");
    wait 0.1;
    play_vo_delay(level, "dx_cps_lass_cache_collection_brief_20");
    wait 0.4;
    play_vo_delay(level, "dx_cps_kama_cache_collection_brief_30");
    wait 0.1;
    scripts\mp\vehicles\vehicle_damage_mp::ref_12408(undefined, "conv_generic_affirm");
    thread play_vo_delay(level);
    setDvar("intro_vo", 1);
  }

  level notify("intro_vo_done");
  var_0 = scripts\engine\utility::getStruct("caches_obj_1", "targetname");
  var_1 = 7840000;

  while(!scripts\cp\utility::any_player_nearby(var_0.origin, var_1)) {
    wait 0.2;
  }

  wait 0.2;
  play_vo_delay(level, "dx_cps_lass_cache_collection_intro_10");
  var_2 = scripts\engine\utility::getStruct("obj_cache_1_investigate", "targetname");
  var_1 = 9216;
  var_3 = undefined;

  for(;;) {
    var_3 = var_2 scripts\cp\utility::get_closest_living_player(var_1);
    wait 0.1;
  }

  LOC_00000103:
    level notify("obj_cash_nearby");
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_3, "obj_collect_generic");
  thread play_vo_delay(level);
  wait 3.4;
  level notify("obj_cash_seen");
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
}

function previouscarepackagekillstreaks() {
  wait 1;
}

function max_steps_before_stability_loss() {
  level waittill("safehouse_door_opened");
  scripts\cp\utility::ref_123fe("mus_cp_smuggler_start");
}

function ref_123e5(var_0) {
  if(isDefined(level.ref_11f58)) {
    return;
  }

  level.ref_11f58 = 1;
  wait 0.1;
  play_vo_delay(level, "dx_cps_lass_cache_collection_hints_cash_10", undefined, undefined);
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var_0, "ping_response_copy");
  thread ref_119da();
}

function ref_119da() {
  level endon("game_ended");
  level endon("lead_collected");
  wait 3;
  var_0 = randomint(3);
  var_1 = 10;

  for(;;) {
    var_2 = undefined;

    if(var_0 == 0) {
      var_2 = "dx_cps_kama_cache_collection_search_nag_10";
    } else if(var_0 == 1) {
      var_2 = "dx_cps_lass_cache_collection_search_nag_20";
    } else if(var_0 == 2) {
      var_2 = "dx_cps_kama_cache_collection_search_nag_30";
    }

    var_0++;

    if(var_0 >= 3) {
      var_0 = 0;
    }

    if(!istrue(level.announcer_vo_playing) && !istrue(level.validatealivecount)) {
      play_vo_delay(level, var_2, undefined, undefined);
    }

    wait var_1;
    var_1 += 2;
  }
}

function play_enemy_incoming(var_0) {
  if(isDefined(level.obj_enemy_incoming_vo)) {
    return;
  }

  level.obj_enemy_incoming_vo = 1;
  var_1 = undefined;
  var_2 = propchangeto();

  switch (level.obj_cache_num) {
    case 1:
      var_1 = "dx_cps_lass_cache_collection_enemy_incoming_10";
      break;
    case 2:
      var_1 = "dx_cps_lass_cache_collection_enemy_incoming_20";
      break;
    case 4:
    case 3:
      var_1 = "dx_cps_kama_cache_collection_enemy_incoming_40";
      break;
  }

  wait var_0;
  thread ref_12deb();
  thread ref_12df9();
  thread ref_12de5();
  wait 12;
  thread play_vo_delay(level, var_1, undefined);
  var_3 = scripts\engine\utility::getStruct(var_2, "targetname");
  wait vo_length(var_1);
  var_4 = var_3 scripts\cp\utility::get_closest_living_player();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_4, "obj_sitrep_wave_start", undefined, 1);
}

function play_extract_reminders() {
  level endon("ready_to_exfil");
  wait 60;
  thread play_vo_delay(level, "dx_cps_ovl_cache_collection_extract_nag_10", undefined);
}

function player_attempt_say_foundlead(var_0) {
  if(level.obj_found_lead_here_vo > 0) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_collect_another");
    return;
  }
}

function play_find_lead(var_0, var_1) {
  if(isDefined(var_0)) {
    if(level.obj_found_lead_here_vo > 0) {
      if(level.obj_leads_found == level.obj_leads_total_size) {
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_collect_complete");
        return;
      }

      thread player_attempt_say_foundlead(level);
      level.obj_found_lead_here_vo++;
      return;
    }

    if(level.obj_cache_num != 1) {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_collect_first");
    }

    level.obj_found_lead_here_vo++;
    return;
  }

  if(level.obj_found_lead_here_vo <= 1 && level.obj_cache_num == 1) {
    thread ref_123e5(level);
    return;
  }
}

function play_find_lead_good(var_0, var_1) {
  if(isDefined(var_0)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_confirm");
    return;
  }
}

function ref_123e6() {
  var_0 = level.obj_cache_num;

  switch (var_0) {
    case 1:
      ref_123e7();
      break;
    case 3:
    case 2:
      ref_123e9();
      break;
    case 4:
      ref_123e8();
      break;
  }
}

function ref_123e7() {
  var_0 = level.obj_leads_found;

  if(!istrue(level.ref_13e9f)) {
    return;
  }

  switch (var_0) {
    case 1:
      play_vo_delay("dx_cps_kama_cache_collection_finding_leads_cash_10", undefined, undefined, undefined, 1);
      break;
    case 2:
      play_vo_delay("dx_cps_kama_cache_collection_finding_leads_cash_20", undefined, undefined, undefined, 1);
      break;
    case 3:
      play_vo_delay("dx_cps_lass_cache_collection_found_enough_cash_10", undefined, undefined, undefined, 1);
      break;
  }
}

function ref_123e9() {
  var_0 = level.obj_leads_found;

  switch (var_0) {
    case 1:
      play_vo_delay("dx_cps_lass_cache_collection_hints_documents_10", undefined, undefined, undefined, 1);
      break;
    case 2:
      play_vo_delay("dx_cps_kama_cache_collection_finding_leads_documents_20", undefined, undefined, undefined, 1);
      break;
    case 3:
      play_vo_delay("dx_cps_lass_cache_collection_found_enough_documents_10", undefined, undefined, undefined, 1);
      break;
    case 4:
      play_vo_delay("dx_cps_kama_cache_collection_finding_leads_documents_10", undefined, undefined, undefined, 1);
      break;
  }
}

function ref_123e8() {
  var_0 = level.obj_leads_found;

  switch (var_0) {
    case 1:
      play_vo_delay("dx_cps_kama_cache_collection_finding_leads_schoolhouse_10", undefined, undefined, undefined, 1);
      break;
    case 2:
      play_vo_delay("dx_cps_kama_cache_collection_finding_leads_schoolhouse_20", undefined, undefined, undefined, 1);
      break;
    case 3:
      play_vo_delay("dx_cps_lass_cache_collection_found_enough_schoolhouse_10", undefined, undefined, undefined, 1);
      break;
  }
}

function play_found_enough_leads() {
  var_0 = undefined;

  switch (level.obj_cache_num) {
    case 1:
      var_0 = "dx_cps_ovl_cache_collection_found_enough_10";
      break;
    case 2:
      var_0 = "dx_cps_ovl_cache_collection_found_enough_20";
      break;
    case 3:
      var_0 = "dx_cps_ovl_cache_collection_found_enough_30";
      break;
    case 4:
      var_0 = "dx_cps_ovl_cache_collection_found_enough_40";
      break;
  }

  thread play_vo_delay(level, var_0, undefined);
  wait vo_length(var_0);
  wait 1;
  thread play_enemy_incoming();
}

function play_investigation_done() {
  var_0 = undefined;
  var_1 = "conv_generic_affirm";

  switch (level.obj_cache_num) {
    case 1:
      var_0 = "dx_cps_lass_cache_collection_complete_cash_10";
      break;
    case 3:
    case 2:
      var_0 = "dx_cps_lass_cache_collection_complete_documents_10";
      break;
    case 4:
      var_0 = "dx_cps_kama_cache_collection_complete_schoolhouse_10";
      var_1 = "ping_response_affirm";
      thread ref_11e1f();
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
      break;
  }

  var_2 = undefined;

  if(isDefined(level.smuggler_last_collector)) {
    var_2 = level.smuggler_last_collector;
  }

  play_vo_delay(level, var_0);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_2, var_1, undefined, 0.75);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_2, "obj_moveout_nag", undefined, 5);
}

function ref_123c7() {
  play_vo_delay(level, "dx_cps_kama_cache_collection_intro_documents_10");
  wait 1;
  play_vo_delay(level, "dx_cps_kama_cache_collection_ied_documents_10");
}

function play_approach_tripwire_building() {
  level endon("game_ended");
  level endon("obj_smug_1_complete");
  play_vo_delay(level, "dx_cps_lass_cache_collection_intro_schoolhouse_10", undefined, undefined, undefined, 2);
  var_0 = propchangeto();
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = 4000000;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2)) {
    wait 0.2;
  }

  wait 0.5;
  play_vo_delay(level, "dx_cps_kama_cache_collection_ied_schoolhouse_10");
  var_2 = 2560000;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2)) {
    wait 0.2;
  }

  wait 1;
  play_vo_delay(level, "dx_cps_lass_cache_collection_hints_schoolhouse_10");
  wait 1;
  var_1 = scripts\engine\utility::getStruct("building_4_body", "targetname");
  var_2 = 16384;

  while(!scripts\cp\utility::any_player_nearby(var_1.origin, var_2)) {
    wait 0.1;
  }

  play_vo_delay(level, "dx_cps_lass_cache_collection_find_body_schoolhouse_10");
}

function handle_hints_vo() {
  level endon("game_ended");
  level endon("stop_leads");
  var_0 = get_hint_timer();

  for(;;) {
    var_1 = undefined;
    var_0 = get_hint_timer();
    var_2 = level scripts\engine\utility::ref_143b9(var_0, "lead_collected");

    if(var_2 == "timeout") {
      for(var_3 = 0; var_3 < level.obj_leads_models.size; var_3++) {
        if(istrue(var_1)) {
          break;
        }

        if(isDefined(level.obj_leads_models[var_3].associated_player)) {
          continue;
        }

        if(istrue(level.obj_leads_models[var_3].is_collected)) {
          continue;
        }

        if(istrue(level.obj_leads_models[var_3].type == "good")) {
          if(level.obj_leads_found < level.obj_leads_total_size - 1) {
            continue;
          }
        }

        if(isDefined(level.obj_leads_models[var_3].script_label)) {
          thread hints_vo_visual_send_to();
          var_1 = spawn_group_in_safe_region(level.obj_leads_models[var_3]);
          decrease_hint_timer(level);
        }
      }
    }
  }
}

function spawn_group_in_safe_region() {
  var_0 = undefined;
  var_1 = ["dx_cps_kama_cache_collection_search_nag_10", "dx_cps_lass_cache_collection_search_nag_20", "dx_cps_kama_cache_collection_search_nag_30"];

  switch (self.script_label) {
    case "rooftop":
      if(get_cache_num() == 4) {
        var_0 = "dx_cps_lass_cache_collection_hints_schoolhouse_20";
        break;
      }
    case "stairwell":
      var_0 = scripts\engine\utility::random(var_1);
      break;
    case "outside":
      var_0 = "dx_cps_kama_cache_collection_hints_10";
      break;
    case "upstairs":
      var_0 = "dx_cps_kama_cache_collection_hints_20";
      break;
  }

  if(isDefined(var_0)) {
    if(!istrue(level.announcer_vo_playing) && !istrue(level.validatealivecount)) {
      thread play_vo_delay(level, var_0, undefined);
    }

    wait vo_length(var_0);
    return 1;
  }

  return 0;
}

function hints_vo_visual_send_to() {
  self endon("lead_collected");
  self endon("hide_lead_hint");
  self endon("death");
  var_0 = "cache_hint_visual";
  var_1 = scripts\cp\cp_objectives::requestworldid(var_0, 2);
  self.spawn_finale_wave = var_0;
  self.spawn_field_ai_manager_wall = var_1;
  objective_setplayintro(var_1, 1);
  objective_setplayoutro(var_1, 0);
  objective_setbackground(var_1, 0);
  objective_position(var_1, self.origin);
  objective_state(var_1, "current");
  scripts\cp\cp_objectives::ref_11f80(var_1);
  objective_icon(var_1, "icon_waypoint_objective_general");
  objective_setlabel(var_1, &"CP_SMUGGLER/INVESTIGATE");
  objective_setownerteam(var_1, "allies");
  objective_addalltomask(var_1);
  objective_showtoplayersinmask(var_1);
  var_2 = get_hint_timer();

  if(var_2 > 44) {
    thread ref_1431f(self, 0.4);
    objective_setbackground(var_1, 0);
    wait 6;
  } else if(var_2 > 38) {
    thread ref_1431f(self, 0.25);
    objective_setbackground(var_1, 0);
    wait 10;
  } else if(var_2 > 35) {
    thread ref_1431f(self, 0.25);
    objective_setbackground(var_1, 0);
    objective_sethot(var_1, 0);
    wait 18;
  } else {
    thread ref_1431f(self, 0.25);
    objective_setbackground(var_1, 0);
    objective_sethot(var_1, 0);
    wait 30;
  }

  thread hasdonestartmusic();
}

function ref_1431f(var_0, var_1) {
  self endon("lead_collected");
  self endon("hide_lead_hint");
  self endon("death");
  var_2 = scripts\cp\utility::get_closest_living_player();
  var_3 = distance2dsquared(var_2.origin, var_0.origin);

  if(!isDefined(var_1)) {
    var_1 = 0.25;
  }

  var_3 *= var_1;

  for(;;) {
    wait 0.5;

    if(scripts\cp\utility::any_player_nearby(var_0.origin, var_3)) {
      break;
    }
  }

  thread hasdonestartmusic();
}

function hasdonestartmusic() {
  if(isDefined(self.spawn_field_ai_manager_wall)) {
    self notify("hide_lead_hint");
    objective_state(self.spawn_field_ai_manager_wall, "done");
    scripts\cp\cp_objectives::freeworldid(self.spawn_finale_wave);
    self.spawn_field_ai_manager_wall = undefined;
    self.spawn_finale_wave = undefined;
    return;
  }
}

function ref_131f0() {
  scripts\cp\utility::skydivestreamhintdvars("caches");
}

function play_mission_complete() {
  thread play_vo_delay(level, "dx_cps_ovl_cache_collection_mission_complete_10", undefined);
  wait vo_length("dx_cps_ovl_cache_collection_mission_complete_10");
  wait 0.1;
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(undefined, "ping_response_affirm");
}

function ref_11e1f() {
  level endon("game_ended");
  level endon("tugofwar_players_approaching");
  level endon("players_looking_for_informant");

  for(;;) {
    play_vo_delay(level, "dx_cps_kama_cache_collection_complete_schoolhouse_10");
    wait randomfloatrange(90, 110);
  }
}

function ref_1446c() {
  level endon("game_ended");
  level endon("tugofwar_players_approaching");
  var_0 = scripts\engine\utility::getStruct("tugofwar_cancel_vo", "targetname");
  var_1 = 64000000;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var_0.origin, var_1)) {
      break;
    }

    wait 1;
  }

  level notify("tugofwar_players_approaching");
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
  }

  previouscarepackagekillstreaks();
}

function vo_length(var_0) {
  var_1 = lookupsoundlength(var_0);
  var_1 /= 1000;
  return var_1;
}

function ref_11e0f() {
  level endon("game_ended");
  level endon("stop_leads");

  for(var_0 = get_hint_timer(); var_0 > 10; var_0 = get_hint_timer()) {
    wait 1;
  }

  scripts\cp\utility::ref_123fe("mus_cp_smuggler_travel_1");
}

function debug_start_caches(var_0) {
  thread debug_start_caches_threaded();
}

function debug_start_caches_threaded() {
  scripts\engine\utility::flag_wait("cp_smugglercaches_north_create_script_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "caches_debug_start_loc", 1);
}

function killprojectileafterdelay() {
  level endon("game_ended");
  level endon("stop_leads");
  var_0 = 45;

  if(getdvarint("scr_caches_tankdroptime", 0) > 0) {
    var_0 = getdvarint("scr_caches_tankdroptime", 0);
  }

  level.ref_11f57 = [];
  wait var_0;
  var_1 = spawnStruct();
  var_1.origin = (-6888, 32484, -136);
  var_1.angles = (0, 0, 0);
  thread ref_13516(level);
  wait var_0;
  var_2 = spawnStruct();
  var_2.origin = (-5832, 31152, -203.252);
  var_2.angles = (0, 0, 0);
  thread ref_13516(level);
  wait var_0;
  ref_1433d(level);
  var_3 = spawnStruct();
  var_3.origin = (-4372, 32680, 121.278);
  var_3.angles = (0, 0, 0);
  thread ref_13516(level);
  wait var_0;
  ref_1433d(level);
  var_4 = spawnStruct();
  var_4.origin = (-4824, 31836, -162.932);
  var_4.angles = (0, 0, 0);
  thread ref_13516(level);
}

function ref_1433d() {
  var_0 = level.obj_leads_found;

  while(getcirclerangemax(var_0)) {
    wait 5;
  }
}

function getcirclerangemax(var_0) {
  if(level.obj_leads_found > var_0 + 5) {
    if(level.ref_11f57.size <= 3) {
      return false;
    }
  }

  if(level.ref_11f57.size > 1) {
    return true;
  }

  return false;
}

function ref_13516(var_0, var_1) {
  level endon("game_ended");

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(!isDefined(var_1)) {
    var_1 = 50;
  }

  var_2 = spawnStruct();
  var_3 = spawnStruct();
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2.spawntype = "GAME_MODE";
  var_2.owner = undefined;
  var_2.team = "axis";
  var_2.faceawayfromowner = 0;
  var_2.cancapture = 0;
  var_2.cancaptureimmediately = 0;
  var_2.activateimmediately = 1;
  var_2.cantimeout = 0;
  var_2.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_2);
  var_2.spawnmethod = "airdrop_at_position_unsafe";
  var_4 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_2, var_3);

  if(!isDefined(var_4)) {
    return;
  }

  var_5 = ["dx_cps_kama_callout_tank_spawning_10", "dx_cps_kama_callout_tank_spawning_20", "dx_cps_lass_callout_tank_spawning_10", "dx_cps_lass_callout_tank_spawning_20"];
  thread play_vo_delay(level, scripts\engine\utility::random(var_5), undefined, undefined, undefined);
  level.ref_11f57[level.ref_11f57.size] = var_4;
  wait 6.5;
  thread tank_waittill_death();
  var_4 endon("death");
  var_4 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  thread tank_hitmarkers();
  setheadiconsnaptoedges(var_4.headicon, 8000);
  var_6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_4, "tur_bradley_mp");
  var_7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_4, "tur_gun_lighttank_mp");
  var_8 = 250000;
  var_9 = 4840000;
  wait 5;

  for(;;) {
    var_10 = var_4 scripts\cp\utility::get_closest_living_player(var_9);

    if(!isDefined(var_10)) {
      wait 1;
      continue;
    }

    var_11 = var_4.origin + (0, 0, 160);
    var_12 = var_10.origin + (0, 0, 32);
    var_13 = scripts\engine\trace::_bullet_trace(var_11, var_12, 1, var_7);

    if(!isDefined(var_13["entity"]) || !isPlayer(var_13["entity"])) {
      wait 1;
      continue;
    }

    if(istrue(var_10.binvehicle) && isDefined(var_10.vehicle)) {
      if(var_6 turretcantarget(var_10.vehicle.origin + (0, 0, 50))) {
        var_6 settargetentity(var_10.vehicle);
      }

      if(var_7 turretcantarget(var_10.vehicle.origin + (0, 0, 50))) {
        var_7 settargetentity(var_10.vehicle);
      }
    } else {
      ref_130f2(var_6, var_10, 9, var_1, var_8);
      var_7 settargetentity(var_10);
    }

    thread tank_shoot_at_target(var_4, var_7);
    thread tank_shoot_at_target(var_4, var_6, undefined);
    wait randomfloatrange(11, 16);
  }
}

function tank_waittill_death() {
  self waittill("death");

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
  }

  if(isDefined(level.ref_11f57)) {
    level.ref_11f57 = scripts\engine\utility::array_remove(level.ref_11f57, self);
    return;
  }
}

function tank_shoot_at_target(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("death");
  var_3 = 4;
  var_4 = 4;

  if(istrue(var_1)) {
    var_3 = randomintrange(80, 120);
    var_4 = 0.05;
  }

  if(isDefined(var_2)) {
    wait var_2;
  }

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_0 shootturret();
    wait weaponfiretime("tur_gun_lighttank_mp") + var_4;
  }
}

function tank_hitmarkers() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_1.lasthitmarkertime = undefined;
      var_1 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }
  }
}

function ref_130f2(var_0, var_1, var_2, var_3) {
  if(distancesquared(self.origin, var_0.origin) < var_3) {
    self settargetentity(var_0);
    return;
  }

  if(var_1 > randomint(9)) {
    if(!isDefined(var_2)) {
      var_2 = 20;
    }

    var_4 = randomfloatrange(var_2 * -1, var_2);
    var_5 = randomfloatrange(var_2 * -1, var_2);
    var_6 = randomfloatrange(var_2 * -1, var_2);
    self settargetentity(var_0, (var_4, var_5, var_6));
    return;
  }

  self settargetentity(var_0);
}