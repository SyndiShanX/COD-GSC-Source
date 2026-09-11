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
  var0 = &scripts\cp\cp_objectives::registerobjective;
  [[var0]]("obj_caches", &obj_maj_cache_init, &obj_maj_cache_start, &obj_maj_cache_end, &debugbeatobjective, &debug_start_caches);
  [[var0]]("obj_caches_adv", &obj_maj_advance_init, &obj_maj_advance_start, &obj_maj_advance_end, &debugbeatobjective);
  [[var0]]("obj_caches_leads", &obj_maj_leads_init, &obj_maj_leads_start, &obj_maj_leads_end, &debugbeatobjective);
  [[var0]]("obj_caches_def", &obj_maj_defense_init, &obj_maj_defense_start, &obj_maj_defense_end, &debugbeatobjective);
  [[var0]]("obj_caches_end", &obj_maj_extract_init, &obj_maj_extract_start, &obj_maj_extract_end, &debugbeatobjective);

  if(getDvar("mapname") == "cp_smuggler") {
    [[var0]]("obj_nuke_ending");
  }

  thread register_spawn_functions();
}

function obj_maj_cache_init(var0) {
  level.ref_139b5 = 1;
  level.global_stealth_broken = 0;
  thread spawn_intro_soldiers();
  thread play_intro_vo();
  level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
}

function obj_maj_cache_start(var0) {
  level thread scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
  level thread scripts\cp\cp_modular_spawning::set_ambient_max_count(0);
  thread init_tripwires();
  thread setup_comms_obj_a_goals_and_cover();
  thread ref_131f0();
  level.initlocationcircle = "caches_obj_3";
  level.initlethalmaxoffsetmap = "caches_obj_3";
  level waittill("intro_vo_done");
}

function obj_maj_cache_end(var0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_caches_adv", "primary", "allies");
}

function obj_maj_advance_init(var0) {
  level thread scripts\cp\cp_objectives::reset_objective_timers();
  level.obj_found_lead_here_vo = 0;
  level.obj_enemy_incoming_vo = undefined;
  level.ref_139b5 = 1;
}

function obj_maj_advance_start(var0) {
  var1 = get_building_loc();
  var2 = scripts\engine\utility::getStruct(var1, "targetname");

  switch (get_cache_num()) {
    case 1:
      objective_setdescription(var0.objectiveindex, &"CP_SMUGGLER/OBJ_ADVANCE");
      break;
    case 3:
    case 2:
      objective_setdescription(var0.objectiveindex, &"CP_SMUGGLER/OBJ_ADVANCE2");
      thread scripts\cp\utility::objective_update("obj_caches_adv2", undefined, undefined, undefined, 1);
      break;
    case 4:
      objective_setdescription(var0.objectiveindex, &"CP_SMUGGLER/OBJ_ADVANCE3");
      thread scripts\cp\utility::objective_update("obj_caches_adv3", undefined, undefined, undefined, 1);
      break;
  }

  objective_setplayintro(var0.objectiveindex, 1);
  objective_setplayoutro(var0.objectiveindex, 1);
  objective_state(var0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlabel(var0.objectiveindex, &"CP_SMUGGLER/OBJ_ADVANCE_WRLD");
  objective_setlocation(var0.objectiveindex, 0, var2.origin);
  level thread scripts\cp\cp_objectives::ref_1317e(var0, var2.origin);
  objective_sethot(var0.objectiveindex, 0);
  level thread scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
  level thread scripts\cp\cp_modular_spawning::set_ambient_max_count(0);

  if(get_cache_num() == 1) {
    thread ref_13557();
  }

  approach_building_wait(level, var2.origin);
}

function obj_maj_advance_end(var0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_caches_leads", "primary", "allies");
}

function obj_maj_leads_init(var0) {
  var1 = get_cache_num(1);

  if(var1 != "1") {
    level.obj_leads_total_size = undefined;
    thread handle_leads_creation(level);
  }

  if(level.obj_cache_num == 1) {
    wait_for_first_lead_pickup(level, var0);
  }

  thread highlight_leads_in_fov_init();
  thread handle_leads_text();
}

function obj_maj_leads_start(var0) {
  var1 = get_cache_num(1);
  var2 = get_building_loc();
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;

  if(var1 == "1") {
    var3 = scripts\engine\utility::getStruct("caches_obj_1", "targetname");
    var4 = scripts\engine\utility::getStruct("caches_obj_2", "targetname");
    var5 = scripts\engine\utility::getStruct("caches_obj_3", "targetname");
    thread setup_bot_hq(level, var0);
    thread setup_bot_hq(level, var0);
    thread setup_bot_hq(level, var0);
  } else {
    var3 = scripts\engine\utility::getStruct(var2, "targetname");
  }

  if(isDefined(var3)) {
    objective_setlocation(var0.objectiveindex, 0, var3.origin);
  }

  if(isDefined(var4)) {
    objective_setlocation(var0.objectiveindex, 1, var4.origin);
  }

  if(isDefined(var5)) {
    objective_setlocation(var0.objectiveindex, 2, var5.origin);
  }

  objective_setlabel(var0.objectiveindex, &"CP_SMUGGLER/OBJ_FIND_CLUE");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  thread handle_hints_vo();
  var1 = get_cache_num(1);

  if(var1 == "2" || var1 == "3") {
    thread ref_123c7();
  }

  if(var1 == "2" || var1 == "3" || var1 == "4") {
    thread spawn_trickle_soldiers(level);
  }

  if(var1 == "4") {
    thread play_approach_tripwire_building();
  }

  level waittill(var2 + "_clues");
}

function obj_maj_leads_end(var0) {
  level thread scripts\cp\cp_objectives::run_objective("obj_caches_def", "primary", "allies");
}

function obj_maj_defense_init(var0) {
  level notify("cache_def_start");
  level.ref_139b5 = 1;
}

function obj_maj_defense_start(var0) {
  var1 = get_cache_num(1);
  level.obj_def_time = get_building_def_time();
  var2 = level.obj_def_time;
  var3 = int(level.obj_def_time * 0.66);
  var4 = int(level.obj_def_time * 0.33);
  thread scripts\cp\utility::objective_update("obj_caches_def", level.obj_def_time, var3, var4, 1);
  var5 = get_wave_name();
  level thread scripts\cp\cp_wave_spawning::killstreaks(11, var5);
  thread keycardlocs(level, var1);
  thread play_enemy_incoming(level);
  var6 = get_building_loc();
  var7 = undefined;
  var8 = undefined;
  var9 = undefined;

  if(var1 == "1") {
    var7 = scripts\engine\utility::getStruct("caches_obj_1", "targetname");
    var8 = scripts\engine\utility::getStruct("caches_obj_2", "targetname");
    var9 = scripts\engine\utility::getStruct("caches_obj_3", "targetname");
    thread killprojectileafterdelay();
  } else {
    var7 = scripts\engine\utility::getStruct(var6, "targetname");
  }

  if(isDefined(var7)) {
    objective_setlocation(var0.objectiveindex, 0, var7.origin);
  }

  if(isDefined(var8)) {
    objective_setlocation(var0.objectiveindex, 1, var8.origin);
  }

  if(isDefined(var9)) {
    objective_setlocation(var0.objectiveindex, 2, var9.origin);
  }

  objective_setbackground(var0.objectiveindex, 2);
  objective_sethot(var0.objectiveindex, 0);
  objective_setlabel(var0.objectiveindex, &"CP_SMUGGLER/OBJ_DEFEND");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  level.obj_cache_def = 1;
  level.obj_def_cur_time = level.obj_def_time;
  scripts\cp\utility::ref_123fe("mus_cp_smuggler_survive");
  thread ref_11e0f();

  while(level.obj_def_cur_time > 0) {
    wait 1;
    level.obj_def_cur_time -= 1;
  }
}

function obj_maj_defense_end(var0) {
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

  scripts\cp\cp_objectives::overridenextstep(var0, "obj_tug_of_war");
  scripts\mp\brclientmatchdata::getprophealth("tow_p1");
  level.ref_139b5 = 0;
  scripts\cp\crate_drops\cp_crate_drops::ref_12c40("cache_2a", ["deployable_cover", "ammo_crate"]);
  reset_totals_texts();
  level notify("obj_smug_1_complete");
  thread getcircleindexforpoint();
  scripts\cp\utility::ref_123fe("mus_cp_smuggler_travel_3");
}

function getcircleindexforpoint() {
  var0 = level.ref_11f66;
  var1 = int(level.ref_11f66 * 0.7);
  waitframe();

  if(level.ref_11f65 == var0) {
    scripts\cp\cp_objectives::screenent_c("minor_objective");
  }

  waitframe();

  if(level.ref_11f65 >= var1) {
    scripts\cp\cp_objectives::screenent_c("minor_objective");
    return;
  }
}

function obj_maj_extract_init(var0) {}

function obj_maj_extract_start(var0) {
  var1 = scripts\engine\utility::getStruct("obj_extract_struct_caches", "targetname");
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil("obj_extract_struct_caches");
  waitframe();
  level notify("call_exfil", var1.origin);
  thread play_extract_reminders();
  level waittill("ready_to_exfil");
}

function obj_maj_extract_end(var0) {
  for(var1 = 0; var1 < level.players.size; var1++) {
    level.players[var1].ability_invulnerable = 1;
  }

  wait 1;
  play_mission_complete(level);
  wait 1.5;
  wait 3;
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function debugbeatobjective(var0) {
  level notify("debug_beat_" + var0 + "_objective");
}

function init_building_num() {
  level.obj_cache_num = 1;
}

function iterate_building_num(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  level.obj_cache_num += var0;
}

function get_cache_num(var0) {
  var1 = level.obj_cache_num;

  if(istrue(var0)) {
    return scripts\engine\utility::string(var1);
  }

  return var1;
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
  var0 = get_cache_num(0);
  var1 = 0;
  var2 = 0;
  var2 = level.obj_leads_found_good * 45;

  switch (var0) {
    case 1:
      var1 = 720;
      break;
    case 4:
      var1 = 270;
      break;
  }

  var1 -= var2;
  var3 = getdvarint("scr_cache_speed", 0);

  if(var3 != 0) {
    var1 = var3;

    if(var1 < 10) {
      var1 = 10;
    }
  }

  return var1;
}

function get_wave_name() {
  var0 = undefined;

  switch (get_cache_num(0)) {
    case 3:
    case 2:
    case 1:
      var0 = "smugg_p1_intro";
      break;
    case 4:
      var0 = "smugg_p1_end";
      break;
  }

  return var0;
}

function get_building_support_time() {
  var0 = 0;

  switch (get_cache_num(0)) {
    case 1:
      var0 = 40;
      break;
    case 3:
    case 2:
      var0 = 30;
      break;
    case 4:
      var0 = 20;
      break;
  }

  return var0;
}

function get_num_ambient() {
  var0 = 0;

  switch (get_cache_num(0)) {
    case 1:
      var0 = 12;
      break;
    case 3:
    case 2:
      var0 = 15;
      break;
    case 4:
      var0 = 18;
      break;
  }

  return var0;
}

function approach_building_wait(var0, var1) {
  level endon("game_ended");
  var2 = 825;

  if(level.obj_cache_num == 4) {
    var2 = 2200;
  }

  var3 = var2 * var2;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var0, var3)) {
      return;
    }

    wait 0.25;
  }
}

function play_bonus_time_sound() {
  if(soundexists("cp_collect_lead_bonus_01")) {
    foreach(var1 in level.players) {
      var1 playlocalsound("cp_collect_lead_bonus_01");
    }

    return;
  }
}

function update_leads_timer(var0) {
  var1 = level.obj_def_time;
  var2 = undefined;

  if(level.obj_def_cur_time - var0 <= 0) {
    if(level.obj_def_cur_time > 5) {
      level.obj_def_cur_time = 5;
    } else {
      return;
    }
  } else {
    level.obj_def_cur_time -= var0;
  }

  var2 = level.obj_def_cur_time;
  var3 = undefined;
  var4 = undefined;
  var5 = 1;

  if(var2 < var1 * 0.33 - var5) {
    var3 = var2 - 1;
    var4 = var2 - 2;
  } else if(var2 < var1 * 0.66 - var5) {
    var3 = var2 - 1;
    var4 = int(var1 * 0.33);
  } else {
    var3 = int(var1 * 0.66);
    var4 = int(var1 * 0.33);
  }

  thread scripts\cp\utility::objective_update("obj_caches_def", var2, var3, var4, 1);
}

function handle_leads_creation(var0, var1) {
  level.obj_leads_found = 0;

  if(scripts\engine\utility::flag_exist("spawned_all_leads")) {
    scripts\engine\utility::flag_clear("spawned_all_leads");
  }

  var2 = get_leads_type(int(var0));

  if(isDefined(var1)) {
    var2 = var1;
  }

  var3 = scripts\engine\utility::getStructArray("obj_cache_goodlead_" + var0, "targetname");
  var4 = scripts\engine\utility::getStructArray("obj_cache_lead_" + var0, "targetname");
  var5 = scripts\engine\utility::getStructArray("obj_cache_obvlead_" + var0, "targetname");

  foreach(var7 in var4) {
    if(isDefined(var7.script_side) && var7.script_side != var2) {
      var4 = scripts\engine\utility::array_remove(var4, var7);
    }
  }

  foreach(var7 in var3) {
    if(isDefined(var7.script_side) && var7.script_side != var2) {
      var3 = scripts\engine\utility::array_remove(var3, var7);
    }
  }

  var3 = scripts\engine\utility::array_randomize(var3);
  var4 = scripts\engine\utility::array_randomize(var4);
  var11 = 9;
  var12 = 1;

  if(var4.size < var11) {}

  if(get_cache_num(0) == 4) {
    var11 += 2;
    level.print_leads_text_max = 12;
  } else {
    level.print_leads_text_max = 10;
  }

  var13 = 0;

  if(var5.size > 0) {
    for(var14 = 0; var14 < var5.size; var14++) {
      thread spawn_lead_model(level, var5[var14], "obvious");
      var13++;
    }

    var11 -= var13;
  }

  for(var14 = 0; var14 < var11; var14++) {
    thread spawn_lead_model(level, var4[var14], "regular");
  }

  for(var14 = 0; var14 < var12; var14++) {
    thread spawn_lead_model(level, var3[var14], "good");
  }

  var15 = 0;

  if(isDefined(level.obj_leads_total_size)) {
    var15 = level.obj_leads_total_size;
  }

  level.obj_leads_total_size = var11 + var12 + var13 + var15;
  level waittill("spawned_lead");

  while(level.obj_leads_models.size < level.obj_leads_total_size) {
    waitframe();
  }

  thread give_one_lead_to_each_player(level);
  scripts\engine\utility::flag_set("spawned_all_leads");
}

function wait_for_first_lead_pickup(var0) {
  scripts\engine\utility::flag_wait("spawned_all_leads");

  for(var1 = 0; var1 < level.obj_leads_models.size; var1++) {
    level.obj_leads_models[var1] makeunusable();
  }

  var2 = undefined;
  var3 = scripts\engine\utility::getStructArray("obj_cache_lead_0", "targetname");

  foreach(var5 in var3) {
    if(var5.script_side == "cash") {
      var2 = var5;
      break;
    }
  }

  level.obj_leads_found_reg = 0;
  var7 = spawn_lead_model(level, var2, "regular", "1");
  var8 = 0.5;

  foreach(var10 in level.players) {
    thread highlight_leads_loop(var10, var7);
  }

  objective_setplayintro(var0.objectiveindex, 1);
  objective_setplayoutro(var0.objectiveindex, 1);
  objective_state(var0.objectiveindex, "current");
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
  objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
  objective_setlabel(var0.objectiveindex, &"CP_SMUGGLER/INVESTIGATE");
  objective_setlocation(var0.objectiveindex, 0, var7.origin + (0, 0, 12));
  objective_sethot(var0.objectiveindex, 0);
  var7 makeunusable();
  level waittill("obj_cash_nearby");
  objective_sethot(var0.objectiveindex, 0);
  objective_setlabel(var0.objectiveindex, &"CP_SMUGGLER/ANALYZING");
  level waittill("obj_cash_seen");
  var7 makeusable();
  objective_setlabel(var0.objectiveindex, &"CP_SMUGGLER/CAPTURE");
  objective_sethot(var0.objectiveindex, 0);
  level waittill("lead_collected");
  level.ref_13e9f = 1;

  for(var1 = 0; var1 < level.obj_leads_models.size; var1++) {
    level.obj_leads_models[var1] makeusable();
  }
}

function get_leads_type(var0) {
  var1 = ["paper", "cash"];
  var2 = undefined;
  var3 = level.obj_cache_num;

  if(isDefined(var0)) {
    var3 = var0;
  }

  switch (var3) {
    case 1:
      var2 = "cash";
      break;
    case 3:
    case 2:
      var2 = "paper";
      break;
    case 4:
      var2 = "cash";
      break;
  }

  level.obj_leads_type = var2;
  return var2;
}

function spawn_lead_model(var0, var1, var2) {
  var3 = spawn("script_model", var0.origin);
  var3 setModel(var0.script_noteworthy);
  var4 = var0.angles;

  if(!isDefined(var4)) {
    var4 = (0, 0, 0);
  }

  var3.angles = var4;
  var3.type = var1;
  waitframe();
  var5 = &"CP_SMUGGLER/COLLECT_LEAD";
  var3 setHintString(var5);
  var3 setCursorHint("HINT_BUTTON");
  var3 sethintdisplayrange(70);
  var3 sethintdisplayfov(40);
  var3 setuserange(70);
  var3 setusefov(35);

  if(var1 == "obvious") {
    var3 sethintdisplayfov(150);
  }

  if(isDefined(var0.script_parameters) && var0.script_parameters == "true") {
    var3 sethintonobstruction("show");
  } else {
    var3 sethintonobstruction("hide");
  }

  if(isDefined(var0.script_label)) {
    var3.script_label = var0.script_label;
  }

  var3 setuseholdduration("duration_none");
  var3 makeusable();
  thread lead_use_think(var3, var1);

  if(!isDefined(level.obj_leads_models)) {
    level.obj_leads_models = [];
  }

  level.obj_leads_models[level.obj_leads_models.size] = var3;
  level.ref_11f66++;
  level notify("spawned_lead");
  return var3;
}

function ref_13557() {
  level.obj_leads_total_size = undefined;
  thread handle_leads_creation(level);
  thread handle_leads_creation(level);
  thread handle_leads_creation(level);
  scripts\engine\utility::flag_wait("spawned_all_leads");
  wait 1;

  for(var0 = 0; var0 < level.obj_leads_models.size; var0++) {
    level.obj_leads_models[var0] makeunusable();
  }
}

function lead_debug_show(var0, var1) {
  self endon("lead_taken");
  var2 = (1, 0, 0);

  if(var1 == "good") {
    var2 = (0, 1, 0);
  }

  for(;;) {
    waitframe();
  }
}

function lead_use_think(var0, var1) {
  self endon("death");
  self endon("lead_taken");

  for(;;) {
    self waittill("trigger", var2);

    if(isDefined(var2)) {
      if(!var2 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(istrue(var2.isdeploying)) {
        continue;
      }

      if(istrue(var2.listen_for_adrenaline_use)) {
        continue;
      }

      thread collect_lead(level, self, var0, var2);
    }
  }
}

function collect_lead(var0, var1, var2, var3) {
  var4 = level.obj_cache_num;
  var5 = var0.origin;

  if(var1 == "regular" || var1 == "obvious") {
    thread play_find_lead(level);
  } else if(var1 == "good") {
    thread play_find_lead_good(level);
  }

  var2.listen_for_adrenaline_use = 1;
  var0 makeunusable();

  if(var2 scripts\cp\utility::playerplaytakephotoanim() == 0) {
    var0 makeusable();

    if(isDefined(var2) && isPlayer(var2)) {
      var2.listen_for_adrenaline_use = undefined;
    }

    return;
  }

  level.obj_leads_found++;
  level.ref_11f65++;

  if(var1 == "regular" || var1 == "obvious") {
    level.obj_leads_found_reg++;
    thread play_find_lead(level, undefined);
  } else if(var1 == "good") {
    level.obj_leads_found_good++;
    thread play_find_lead_good(level, undefined);
  }

  if(isDefined(level.obj_def_time)) {
    thread print_bonus_time_text(level, var1);
    thread play_bonus_time_sound();
    thread update_leads_timer(level);
  }

  if(soundexists("cp_collect_lead_01")) {
    if(isent(var0)) {
      var0 playSound("cp_collect_lead_01");
    } else {
      playsoundatpos(var5, "cp_collect_lead_01");
    }
  }

  var2 thread scripts\cp\drone\emp_drone::giverankxp("assist_marked", 50);
  thread ref_124df();

  if(isent(var0)) {
    remove_lead(var0);
  }

  level notify("lead_collected", var1, var3);
  thread ref_123e6();
  level.smuggler_last_collector = var2;
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
  var0 = scripts\engine\utility::array_find(level.obj_leads_models, self);

  if(isDefined(var0) && isDefined(level.obj_leads_models[var0].script_label)) {
    level.obj_leads_models[var0].script_label = undefined;
  }

  self makeusable();
  var1 = &"CP_SMUGGLER/LEAD_ALREADY";
  self setHintString(var1);
  self setCursorHint("HINT_NOBUTTON");
  self sethinticon("hud_icon_head_equipment_friendly");
  self sethintdisplayfov(80);
  self setuseholdduration("duration_none");
  self hudoutlinedisable();
  self.is_collected = 1;
}

function delete_all_leads() {
  foreach(var1 in level.obj_leads_models) {
    level.obj_leads_models = scripts\engine\utility::array_remove(level.obj_leads_models, var1);
    hasdonestartmusic(var1);
    var1 delete();
  }
}

function give_one_lead_to_each_player(var0) {
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    if(var0[var2].type == "obvious") {
      var1 = var0[var2];
    }
  }

  if(var1.size == 0) {
    return;
  }

  var3 = 0;

  for(var2 = 0; var2 < level.players.size; var2++) {
    if(level.players[var2].team == "allies") {
      associate_lead_with_player(var1[var3], level.players[var2]);
      thread handle_associated_lead_disconnect(var1[var3], level.players[var2]);
      thread handle_associated_lead_lookat(var1[var3], level.players[var2]);
      var3++;
    }
  }
}

function associate_lead_with_player(var0, var1) {
  for(var2 = 0; var2 < level.players.size; var2++) {
    if(level.players[var2] != var1) {
      var0 hidefromplayer(var1);
      continue;
    }

    var0.associated_player = var1;
  }
}

function dissociate_from_player(var0) {
  for(var1 = 0; var1 < level.players.size; var1++) {
    if(isent(var0) && isPlayer(level.players[var1])) {
      var0 showtoplayer(level.players[var1]);
    }
  }
}

function handle_associated_lead_disconnect(var0, var1) {
  level endon("game_ended");
  level endon("stop_leads");
  var1 waittill("disconnect");

  if(isDefined(var0) && isent(var0)) {
    dissociate_from_player(var0);
    return;
  }
}

function handle_associated_lead_lookat(var0, var1) {
  level endon("game_ended");
  level endon("stop_leads");
  var1 endon("disconnect");

  for(;;) {
    var0 waittill("seen", var2);

    if(var2 != var1) {
      continue;
    }

    dissociate_from_player(var0);
    return;
  }
}

function handle_leads_text() {
  level endon("game_ended");
  level endon("stop_leads");
  var0 = get_building_loc();
  level.obj_leads_found_reg = 0;
  level.obj_leads_found_good = 0;
  level.print_leads_text_max = 3;
  print_total_leads_text(level.obj_leads_found);
  print_type_text(level.obj_leads_type);

  for(;;) {
    level waittill("lead_collected", var1);
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

function collected_enough_leads(var0) {
  level notify(var0 + "_clues");
}

function print_total_leads_text(var0) {
  var1 = undefined;

  switch (var0) {
    case 2:
    case 1:
    case 0:
      var1 = "obj_caches_collect_total_1";
      thread scripts\cp\utility::objective_update(var1, undefined, undefined, undefined, undefined, var0);
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

function print_type_text(var0) {
  var1 = undefined;

  switch (var0) {
    case "paper":
      var1 = "obj_caches_collect_type_1";
      break;
    case "cash":
      var1 = "obj_caches_collect_type_2";
      break;
  }

  thread scripts\cp\utility::objective_update(var1);
}

function print_bonus_time_text(var0, var1) {
  var2 = &"CP_SMUGGLER/LEADS_BONUS_REG";
  var3 = 30;
  var1 thread scripts\cp\cp_hud_message::tutorialprint(var2, 3.75);
}

function fade_text_over_time(var0, var1, var2, var3) {
  var0 endon("death");

  if(!isDefined(var2)) {
    var2 = 0.2;
  }

  if(isDefined(var3)) {
    wait var3;
  }

  if(var1 <= 0) {
    var1 = 0.1;
  }

  var0.alpha = 1;
  var4 = var2 / var1;
  var5 = 1;

  while(var5 > 0) {
    var0.alpha = var5;
    wait var2;
    var5 -= var4;
  }

  var0.alpha = 0;
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
  var0 = "caches_obj_1";

  switch (level.obj_cache_num) {
    case 1:
      var0 = "caches_obj_1";
      break;
    case 2:
      var0 = "caches_obj_2";
      break;
    case 3:
      var0 = "caches_obj_3";
      break;
    case 4:
      var0 = "caches_obj_4";
      break;
  }

  return var0;
}

function setup_comms_obj_a_goals_and_cover() {
  var0 = 600;
  var1 = scripts\engine\utility::getStruct("caches_obj_4", "targetname");
  var2 = createnavbadplacebybounds(var1.origin, (var0, var0, var0), (0, 0, 0));
  level waittill("stop_leads");
  destroynavobstacle(var2);
}

function highlight_leads_in_fov_init() {
  foreach(var1 in level.players) {
    thread highlight_leads_in_fov_player();
  }
}

function highlight_leads_in_fov_player() {
  level endon("game_ended");
  level endon("stop_leads");
  self endon("disconnect");
  var0 = 0.5;
  scripts\engine\utility::flag_wait("spawned_all_leads");

  for(;;) {
    var1 = level.obj_leads_models;
    thread highlight_leads_loop(var1, var0);
    level waittill("lead_collected");
  }
}

function setup_bot_hq(var0, var1) {
  level endon("game_ended");
  level endon("stop_leads");
  self endon("disconnect");
  var2 = undefined;
  var3 = 10;

  if(var1 == "4") {
    var3 = 12;
  }

  var4 = 0;
  var5 = undefined;

  switch (var1) {
    case "1":
      var5 = 0;
      break;
    case "2":
      var5 = 1;
      break;
    case "3":
      var5 = 2;
      break;
  }

  if(!isDefined(var5)) {
    return;
  }

  scripts\engine\utility::flag_wait("spawned_all_leads");

  for(;;) {
    level waittill("lead_collected", var6, var2);

    if(isDefined(var2) && var2 == var1) {
      var4++;
    }

    if(var4 >= var3) {
      objective_unsetlocation(var0.objectiveindex, var5);
    }
  }
}

function highlight_leads_loop(var0, var1) {
  level endon("game_ended");
  level endon("stop_leads");
  level endon("lead_collected");
  self endon("disconnect");
  var2 = 120;
  var3 = var2 * var2;
  jumpiftrue(isarray(var0)) LOC_0000003a;
  var4 = var0;
  var0 = [var4];

  for(;;) {
    var5 = self getEye();
    var6 = self getplayerangles();

    for(var7 = 0; var7 < var0.size; var7++) {
      if(istrue(var0[var7].is_collected)) {
        continue;
      }

      if(distancesquared(var5, var0[var7].origin) > var3) {
        var0[var7] hudoutlinedisableforclient(self);
        continue;
      }

      if(scripts\engine\utility::within_fov(var5, var6, var0[var7].origin, var1)) {
        var0[var7] hudoutlineenableforclient(self, "outline_intel_capture");

        if(isDefined(var0[var7].associated_player) && self == var0[var7].associated_player) {
          var0[var7] notify("seen", self);
        }

        continue;
      }

      var0[var7] hudoutlinedisableforclient(self);
    }

    waitframe();
  }
}

function tripwire_randomize() {
  var0 = scripts\engine\utility::getStructArray("tripwires_1", "targetname");
  var1 = scripts\engine\utility::getStructArray("tripwires_2", "targetname");
  var2 = scripts\engine\utility::getStructArray("tripwires_3", "targetname");
  var3 = scripts\engine\utility::getStructArray("tripwires_4", "targetname");
  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = scripts\engine\utility::array_randomize(var1);
  var2 = scripts\engine\utility::array_randomize(var2);
  var3 = scripts\engine\utility::array_randomize(var3);
  var4 = 0;
  var5 = 3;
  var6 = 4;
  var7 = 18;
  var8 = var0.size - var4;
  var9 = var1.size - var5;
  var10 = var2.size - var6;
  var11 = var3.size - var7;

  for(var12 = 0; var12 < var8; var12++) {
    remove_from_struct_array("script_noteworthy", var0[var12].script_noteworthy, var0[var12]);
  }

  for(var12 = 0; var12 < var9; var12++) {
    remove_from_struct_array("script_noteworthy", var1[var12].script_noteworthy, var1[var12]);
  }

  for(var12 = 0; var12 < var10; var12++) {
    remove_from_struct_array("script_noteworthy", var2[var12].script_noteworthy, var2[var12]);
  }

  for(var12 = 0; var12 < var11; var12++) {
    remove_from_struct_array("script_noteworthy", var3[var12].script_noteworthy, var3[var12]);
  }
}

function remove_from_struct_array(var0, var1, var2) {
  if(isDefined(level.struct_class_names[var0]) && isDefined(level.struct_class_names[var0][var1]) && scripts\engine\utility::array_contains(level.struct_class_names[var0][var1], var2)) {
    level.struct_class_names[var0][var1] = scripts\engine\utility::array_remove(level.struct_class_names[var0][var1], var2);
    return;
  }
}

function spawn_trickle_soldiers(var0) {
  level endon("stop_leads");
  wait 5;
  level.ref_135a2 = scripts\cp\cp_modular_spawning::run_spawn_module("soldier_cache_" + var0 + "_trickle");
}

function keycardlocs(var0, var1) {
  wait var1;
  level.spawn_module_current = scripts\cp\cp_modular_spawning::run_spawn_module("soldier_cache_" + var0);
}

function wait_for_near_extract(var0, var1) {
  var2 = var1 * var1;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var0, var2)) {
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
  var0 = &scripts\cp\cp_modular_spawning::registerambientgroup;
  scripts\cp\coop_stealth::coop_stealth_init();
  [[var0]]("first_house_guards", 10, 10, 10, 0.1, 0, "first_house_guards", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("first_house_guards", &ref_1320c);
  scripts\cp\cp_modular_spawning::register_module_ai_death_func("first_house_guards", &scripts\cp\coop_stealth::regular_enemy_death_func);
  [[var0]]("soldier_cache_1", 10, 10, 30, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_1", &watchforstopwaves, undefined, undefined);
  [[var0]]("soldier_cache_2", 10, 10, 30, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_2", &watchforstopwaves, undefined, undefined);
  [[var0]]("soldier_cache_2_trickle", 2, 5, 100, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_2", &watchforstopwaves, undefined, undefined);
  [[var0]]("soldier_cache_3", 10, 10, 30, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_3", &watchforstopwaves, undefined, undefined);
  [[var0]]("soldier_cache_3_trickle", 2, 5, 100, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_3", &watchforstopwaves, undefined, undefined);
  [[var0]]("school_guards", 8, 10, 40, 0.1, 0, "school_guards", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("school_guards", &ref_12ee9);
  [[var0]]("soldier_cache_4", 10, 10, 30, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_4", &watchforstopwaves, undefined, undefined);
  [[var0]]("soldier_cache_4_trickle", 3, 6, 100, [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 30, 2], 0, "soldier_cache_4", &watchforstopwaves, undefined, undefined);
  [[var0]]("school_guards_chopper", 6, 6, 6, 0.1, 0, "school_guards_chopper", &watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("school_guards_chopper", undefined, 20000, 30000);
  setup_enemy_sentry(var0, "obj_cache_techo_1");
  setup_enemy_sentry(var0, "obj_cache_techo_2");
  setup_enemy_sentry(var0, "techo_phys_cache2");
  setup_enemy_sentry(var0, "techo_phys_cache3");
  setup_enemy_sentry(var0, "techo_phys_cache4");
  setup_enemy_sentry(var0, "techo_phys_cache1");
  setup_enemy_sentry(var0, "techo_phys_cache5");
  setup_enemy_sentry(var0, "techo_phys_cache6");
}

function ref_12ee9(var0) {
  var1 = "school_guards_pursue";
  thread ref_12eea(var1);
  thread ref_12eec(var1);
  thread ref_12eed(var1);
}

function ref_12eec(var0) {
  self endon(var0);
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

  foreach(var2 in level.ref_12dca) {
    thread ref_12dc9();
  }

  for(;;) {
    self waittill("fire_rpg_at", var4);
    var5 = spawn("script_model", var4.origin);
    var5 setModel("tag_origin");
    self setentitytarget(var5, 1);
    var6 = scripts\engine\utility::ref_143b9(5, "shooting");
    self clearentitytarget();
    var5 delete();
  }
}

function ref_12dc9() {
  level endon("game_ended");
  self endon("death");
  self notify("rpg_shoot_at_trig_watch");
  self endon("rpg_shoot_at_trig_watch");
  level.ref_11fa7 = undefined;

  for(;;) {
    self waittill("trigger", var0);

    if(!isDefined(level.ref_12eeb) || level.ref_12eeb.size == 0) {
      continue;
    }

    if(isDefined(var0) && isPlayer(var0)) {
      var1 = scripts\engine\utility::getStructArray(self.target, "targetname");
      var1 = sortbydistance(var1, var0.origin);
      level.ref_12eeb = scripts\engine\utility::array_randomize(level.ref_12eeb);
      var2 = 0;

      foreach(var4 in level.ref_12eeb) {
        if(isDefined(var4) && isalive(var4)) {
          for(var5 = 0; var5 < var1.size; var5++) {
            var6 = var1[var5];

            if(sighttracepassed(var4.origin + (0, 0, 62), var6.origin, 0, var4, 0)) {
              var4 notify("fire_rpg_at", var6);
              var7 = var4 getEye();
              var8 = var4 scripts\engine\utility::ref_143b9(5, "shooting");

              if(isDefined(var8) && var8 == "shooting") {
                var2 = 1;
              }

              break;
            }
          }
        }

        if(var2) {
          break;
        }

        waitframe();
      }
    }

    wait randomintrange(6, 10);
  }
}

function ref_12eea(var0) {
  self endon(var0);
  level endon("game_ended");
  self endon("death");

  if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.target)) {
    var1 = scripts\engine\utility::getStruct(self.spawnpoint.target, "targetname");

    if(isDefined(var1)) {
      self.script_origin_other = var1.origin;
      scripts\cp\cp_modular_spawning::set_goal_pos(var1.origin);
      var2 = 128;
      jumpiffalse(isDefined(var1.radius)) LOC_0000007c;
      var2 = int(var1.radius);

      for(;;) {
        scripts\cp\cp_modular_spawning::set_goal_radius(var2);
        var3 = 280;
        var4 = 48;
        var5 = scripts\cp\utility::get_closest_living_player(36000000);

        if(isDefined(var5)) {
          var6 = var5.origin - self.origin;
          var7 = length2dsquared(var6) < var3 * var3;
          var8 = abs(var5.origin[2] - self.origin[2]) < var4;

          if(var7 && var8) {
            self notify(var0);
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

function ref_12eed(var0) {
  level endon("game_ended");
  self endon("death");
  wait 1;
  self waittill(var0);
  self.script_origin_other = undefined;
  scripts\cp\cp_modular_spawning::set_goal_radius(900);
  thread scripts\cp\cp_modular_spawning::prepdoorsforunload();
  level waittill("stop_leads");

  while(scripts\cp\cp_modular_spawning::has_seen_any_player_recently()) {
    wait 0.5;
  }

  scripts\cp\cp_modular_spawning::script_kill_ai();
}

function setup_enemy_sentry(var0, var1) {
  [[var0]](var1, 6, 6, 6, 0.1, 0, var1, &watchforstopwaves, undefined, undefined);
  level.stack_patch_waittill_leaf = scripts\engine\utility::array_add(level.stack_patch_waittill_leaf, var1);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group(var1, undefined, 20000, 30000);
}

function watchforstopwaves(var0) {
  level endon("game_ended");
  thread _watchforstopwaves(level);
}

function _watchforstopwaves(var0) {
  level endon("game_ended");
  level waittill("end_wave_cache_spawners");
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function stopwaveandstartthisone(var0) {
  level notify("end_wave_cache_spawners");
  wait 0.5;
  [[var0]]();
}

function ref_1320c(var0, var1) {
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
}

function spawn_support_wave_handler() {
  level endon("game_ended");
  level endon("stop_leads");
  var0 = get_cache_num(1);
  var1 = get_building_support_time();
  var2 = 0;
  var3 = get_num_ambient();

  for(;;) {
    var4 = level scripts\engine\utility::ref_143ba(var1, "lead_collected", "cache_def_start");

    if(var4 == "timeout" || var4 == "cache_def_start") {
      if(var4 == "cache_def_start") {
        wait 10;
      }

      return;
    }
  }
}

function ref_12df9() {
  level endon("game_ended");
  level endon("stop_leads");
  var0 = get_cache_num(1);

  if(var0 == "1") {
    thread play_vo_delay(level);
    thread ref_12dd5(level);
    thread ref_12dd5(level);
    wait 60;
    thread ref_12dd5(level);
    thread ref_12dd5(level);
    thread watchbrc130airdropchuteanimend();
    return;
  }

  if(var0 == "2" || var0 == "3") {
    thread ref_12dd5(level);
    thread ref_12dd5(level);
    thread watchbrc130airdropchuteanimend();
    return;
  }

  if(var0 == "4") {
    thread ref_12e01(level, "techo_phys_cache1", 45);
    thread ref_12e01(level, "techo_phys_cache5", 45);
    thread ref_12e01(level, "techo_phys_cache6", 100);
    return;
  }
}

function ref_12deb() {
  level endon("game_ended");
  level endon("stop_leads");
  var0 = get_cache_num(1);

  if(var0 == "4") {
    for(;;) {
      var1 = scripts\cp\cp_modular_spawning::run_spawn_module("school_guards_chopper");
      wait 45;
      ref_143a0(18);
    }

    return;
  }
}

function ref_143a0(var0) {
  level endon("game_ended");

  for(;;) {
    var1 = 0;
    var2 = 0;

    if(!isDefined(level.agentarray)) {
      break;
    }

    foreach(var4 in level.agentarray) {
      if(isDefined(var4.isactive) && var4.isactive) {
        var1++;
      }

      if(isDefined(var4.never_kill_off) && var4.never_kill_off) {
        var2++;
      }
    }

    if(var1 < var0) {
      break;
    }

    wait 1;
  }
}

function ref_12de5() {
  var0 = get_cache_num(1);

  if(var0 == "4") {
    var1 = scripts\cp\cp_modular_spawning::run_spawn_module("school_guards");
    return;
  }
}

function watchbrc130airdropchuteanimend() {
  wait 10;
  thread ref_12dd5(level);
}

function ref_12e01(var0, var1, var2) {
  level endon("game_ended");
  level endon("stop_leads");
  var3 = 30;

  if(isDefined(var1)) {
    wait var1;
  }

  var4 = scripts\cp\cp_modular_spawning::run_spawn_module(var0);

  while(var3 > 0) {
    if(isDefined(var4.module_vehicles[0]) && isent(var4.module_vehicles[0])) {
      break;
    }

    wait 1;
    var3--;
  }

  if(var3 <= 0) {
    return;
  }

  var5 = var4.module_vehicles[0];
  thread ref_14350();

  if(isDefined(var2) && var2 > 0) {
    thread ref_12cae(var5, var4, var0);
  }

  var5 scripts\engine\utility::ref_143a5("unloading", "death");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var0);
}

function ref_12cae(var0, var1, var2) {
  level endon("game_ended");
  level endon("stop_leads");
  var3 = scripts\engine\utility::ref_143ad("death", "unloaded");
  var4 = self.origin;

  if(isDefined(var3) && var3 == "death") {
    wait 1;

    if(isDefined(var0) && isDefined(var0.ai_spawned)) {
      var5 = 0;

      foreach(var7 in var0.ai_spawned) {
        if(isDefined(var7) && isalive(var7) && !var7 scripts\engine\utility::doinglongdeath()) {
          var5++;
        }
      }

      if(var5 <= 1) {
        var2--;
        thread ref_12e01(level, var1, 1);
        return;
      }

      return;
    }

    return;
  }
}

function ref_12dd5(var0) {
  level endon("game_ended");
  level endon("stop_leads");
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
  var0 = scripts\engine\utility::getStruct("caches_obj_1", "targetname");
  var1 = 7840000;

  while(!scripts\cp\utility::any_player_nearby(var0.origin, var1)) {
    wait 0.2;
  }

  wait 0.2;
  play_vo_delay(level, "dx_cps_lass_cache_collection_intro_10");
  var2 = scripts\engine\utility::getStruct("obj_cache_1_investigate", "targetname");
  var1 = 9216;
  var3 = undefined;

  for(;;) {
    var3 = var2 scripts\cp\utility::get_closest_living_player(var1);
    wait 0.1;
  }

  LOC_00000103:
    level notify("obj_cash_nearby");
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var3, "obj_collect_generic");
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

function ref_123e5(var0) {
  if(isDefined(level.ref_11f58)) {
    return;
  }

  level.ref_11f58 = 1;
  wait 0.1;
  play_vo_delay(level, "dx_cps_lass_cache_collection_hints_cash_10", undefined, undefined);
  scripts\mp\vehicles\vehicle_damage_mp::ref_12408(var0, "ping_response_copy");
  thread ref_119da();
}

function ref_119da() {
  level endon("game_ended");
  level endon("lead_collected");
  wait 3;
  var0 = randomint(3);
  var1 = 10;

  for(;;) {
    var2 = undefined;

    if(var0 == 0) {
      var2 = "dx_cps_kama_cache_collection_search_nag_10";
    } else if(var0 == 1) {
      var2 = "dx_cps_lass_cache_collection_search_nag_20";
    } else if(var0 == 2) {
      var2 = "dx_cps_kama_cache_collection_search_nag_30";
    }

    var0++;

    if(var0 >= 3) {
      var0 = 0;
    }

    if(!istrue(level.announcer_vo_playing) && !istrue(level.validatealivecount)) {
      play_vo_delay(level, var2, undefined, undefined);
    }

    wait var1;
    var1 += 2;
  }
}

function play_enemy_incoming(var0) {
  if(isDefined(level.obj_enemy_incoming_vo)) {
    return;
  }

  level.obj_enemy_incoming_vo = 1;
  var1 = undefined;
  var2 = propchangeto();

  switch (level.obj_cache_num) {
    case 1:
      var1 = "dx_cps_lass_cache_collection_enemy_incoming_10";
      break;
    case 2:
      var1 = "dx_cps_lass_cache_collection_enemy_incoming_20";
      break;
    case 4:
    case 3:
      var1 = "dx_cps_kama_cache_collection_enemy_incoming_40";
      break;
  }

  wait var0;
  thread ref_12deb();
  thread ref_12df9();
  thread ref_12de5();
  wait 12;
  thread play_vo_delay(level, var1, undefined);
  var3 = scripts\engine\utility::getStruct(var2, "targetname");
  wait vo_length(var1);
  var4 = var3 scripts\cp\utility::get_closest_living_player();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var4, "obj_sitrep_wave_start", undefined, 1);
}

function play_extract_reminders() {
  level endon("ready_to_exfil");
  wait 60;
  thread play_vo_delay(level, "dx_cps_ovl_cache_collection_extract_nag_10", undefined);
}

function player_attempt_say_foundlead(var0) {
  if(level.obj_found_lead_here_vo > 0) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_collect_another");
    return;
  }
}

function play_find_lead(var0, var1) {
  if(isDefined(var0)) {
    if(level.obj_found_lead_here_vo > 0) {
      if(level.obj_leads_found == level.obj_leads_total_size) {
        level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_collect_complete");
        return;
      }

      thread player_attempt_say_foundlead(level);
      level.obj_found_lead_here_vo++;
      return;
    }

    if(level.obj_cache_num != 1) {
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_collect_first");
    }

    level.obj_found_lead_here_vo++;
    return;
  }

  if(level.obj_found_lead_here_vo <= 1 && level.obj_cache_num == 1) {
    thread ref_123e5(level);
    return;
  }
}

function play_find_lead_good(var0, var1) {
  if(isDefined(var0)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_confirm");
    return;
  }
}

function ref_123e6() {
  var0 = level.obj_cache_num;

  switch (var0) {
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
  var0 = level.obj_leads_found;

  if(!istrue(level.ref_13e9f)) {
    return;
  }

  switch (var0) {
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
  var0 = level.obj_leads_found;

  switch (var0) {
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
  var0 = level.obj_leads_found;

  switch (var0) {
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
  var0 = undefined;

  switch (level.obj_cache_num) {
    case 1:
      var0 = "dx_cps_ovl_cache_collection_found_enough_10";
      break;
    case 2:
      var0 = "dx_cps_ovl_cache_collection_found_enough_20";
      break;
    case 3:
      var0 = "dx_cps_ovl_cache_collection_found_enough_30";
      break;
    case 4:
      var0 = "dx_cps_ovl_cache_collection_found_enough_40";
      break;
  }

  thread play_vo_delay(level, var0, undefined);
  wait vo_length(var0);
  wait 1;
  thread play_enemy_incoming();
}

function play_investigation_done() {
  var0 = undefined;
  var1 = "conv_generic_affirm";

  switch (level.obj_cache_num) {
    case 1:
      var0 = "dx_cps_lass_cache_collection_complete_cash_10";
      break;
    case 3:
    case 2:
      var0 = "dx_cps_lass_cache_collection_complete_documents_10";
      break;
    case 4:
      var0 = "dx_cps_kama_cache_collection_complete_schoolhouse_10";
      var1 = "ping_response_affirm";
      thread ref_11e1f();
      scripts\cp\cp_modular_spawning::stop_module_by_groupname("wave_spawning");
      break;
  }

  var2 = undefined;

  if(isDefined(level.smuggler_last_collector)) {
    var2 = level.smuggler_last_collector;
  }

  play_vo_delay(level, var0);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var2, var1, undefined, 0.75);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var2, "obj_moveout_nag", undefined, 5);
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
  var0 = propchangeto();
  var1 = scripts\engine\utility::getStruct(var0, "targetname");
  var2 = 4000000;

  while(!scripts\cp\utility::any_player_nearby(var1.origin, var2)) {
    wait 0.2;
  }

  wait 0.5;
  play_vo_delay(level, "dx_cps_kama_cache_collection_ied_schoolhouse_10");
  var2 = 2560000;

  while(!scripts\cp\utility::any_player_nearby(var1.origin, var2)) {
    wait 0.2;
  }

  wait 1;
  play_vo_delay(level, "dx_cps_lass_cache_collection_hints_schoolhouse_10");
  wait 1;
  var1 = scripts\engine\utility::getStruct("building_4_body", "targetname");
  var2 = 16384;

  while(!scripts\cp\utility::any_player_nearby(var1.origin, var2)) {
    wait 0.1;
  }

  play_vo_delay(level, "dx_cps_lass_cache_collection_find_body_schoolhouse_10");
}

function handle_hints_vo() {
  level endon("game_ended");
  level endon("stop_leads");
  var0 = get_hint_timer();

  for(;;) {
    var1 = undefined;
    var0 = get_hint_timer();
    var2 = level scripts\engine\utility::ref_143b9(var0, "lead_collected");

    if(var2 == "timeout") {
      for(var3 = 0; var3 < level.obj_leads_models.size; var3++) {
        if(istrue(var1)) {
          break;
        }

        if(isDefined(level.obj_leads_models[var3].associated_player)) {
          continue;
        }

        if(istrue(level.obj_leads_models[var3].is_collected)) {
          continue;
        }

        if(istrue(level.obj_leads_models[var3].type == "good")) {
          if(level.obj_leads_found < level.obj_leads_total_size - 1) {
            continue;
          }
        }

        if(isDefined(level.obj_leads_models[var3].script_label)) {
          thread hints_vo_visual_send_to();
          var1 = spawn_group_in_safe_region(level.obj_leads_models[var3]);
          decrease_hint_timer(level);
        }
      }
    }
  }
}

function spawn_group_in_safe_region() {
  var0 = undefined;
  var1 = ["dx_cps_kama_cache_collection_search_nag_10", "dx_cps_lass_cache_collection_search_nag_20", "dx_cps_kama_cache_collection_search_nag_30"];

  switch (self.script_label) {
    case "rooftop":
      if(get_cache_num() == 4) {
        var0 = "dx_cps_lass_cache_collection_hints_schoolhouse_20";
        break;
      }
    case "stairwell":
      var0 = scripts\engine\utility::random(var1);
      break;
    case "outside":
      var0 = "dx_cps_kama_cache_collection_hints_10";
      break;
    case "upstairs":
      var0 = "dx_cps_kama_cache_collection_hints_20";
      break;
  }

  if(isDefined(var0)) {
    if(!istrue(level.announcer_vo_playing) && !istrue(level.validatealivecount)) {
      thread play_vo_delay(level, var0, undefined);
    }

    wait vo_length(var0);
    return 1;
  }

  return 0;
}

function hints_vo_visual_send_to() {
  self endon("lead_collected");
  self endon("hide_lead_hint");
  self endon("death");
  var0 = "cache_hint_visual";
  var1 = scripts\cp\cp_objectives::requestworldid(var0, 2);
  self.spawn_finale_wave = var0;
  self.spawn_field_ai_manager_wall = var1;
  objective_setplayintro(var1, 1);
  objective_setplayoutro(var1, 0);
  objective_setbackground(var1, 0);
  objective_position(var1, self.origin);
  objective_state(var1, "current");
  scripts\cp\cp_objectives::ref_11f80(var1);
  objective_icon(var1, "icon_waypoint_objective_general");
  objective_setlabel(var1, &"CP_SMUGGLER/INVESTIGATE");
  objective_setownerteam(var1, "allies");
  objective_addalltomask(var1);
  objective_showtoplayersinmask(var1);
  var2 = get_hint_timer();

  if(var2 > 44) {
    thread ref_1431f(self, 0.4);
    objective_setbackground(var1, 0);
    wait 6;
  } else if(var2 > 38) {
    thread ref_1431f(self, 0.25);
    objective_setbackground(var1, 0);
    wait 10;
  } else if(var2 > 35) {
    thread ref_1431f(self, 0.25);
    objective_setbackground(var1, 0);
    objective_sethot(var1, 0);
    wait 18;
  } else {
    thread ref_1431f(self, 0.25);
    objective_setbackground(var1, 0);
    objective_sethot(var1, 0);
    wait 30;
  }

  thread hasdonestartmusic();
}

function ref_1431f(var0, var1) {
  self endon("lead_collected");
  self endon("hide_lead_hint");
  self endon("death");
  var2 = scripts\cp\utility::get_closest_living_player();
  var3 = distance2dsquared(var2.origin, var0.origin);

  if(!isDefined(var1)) {
    var1 = 0.25;
  }

  var3 *= var1;

  for(;;) {
    wait 0.5;

    if(scripts\cp\utility::any_player_nearby(var0.origin, var3)) {
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
  var0 = scripts\engine\utility::getStruct("tugofwar_cancel_vo", "targetname");
  var1 = 64000000;

  for(;;) {
    if(scripts\cp\utility::any_player_nearby(var0.origin, var1)) {
      break;
    }

    wait 1;
  }

  level notify("tugofwar_players_approaching");
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
  }

  previouscarepackagekillstreaks();
}

function vo_length(var0) {
  var1 = lookupsoundlength(var0);
  var1 /= 1000;
  return var1;
}

function ref_11e0f() {
  level endon("game_ended");
  level endon("stop_leads");

  for(var0 = get_hint_timer(); var0 > 10; var0 = get_hint_timer()) {
    wait 1;
  }

  scripts\cp\utility::ref_123fe("mus_cp_smuggler_travel_1");
}

function debug_start_caches(var0) {
  thread debug_start_caches_threaded();
}

function debug_start_caches_threaded() {
  scripts\engine\utility::flag_wait("cp_smugglercaches_north_create_script_completed");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "caches_debug_start_loc", 1);
}

function killprojectileafterdelay() {
  level endon("game_ended");
  level endon("stop_leads");
  var0 = 45;

  if(getdvarint("scr_caches_tankdroptime", 0) > 0) {
    var0 = getdvarint("scr_caches_tankdroptime", 0);
  }

  level.ref_11f57 = [];
  wait var0;
  var1 = spawnStruct();
  var1.origin = (-6888, 32484, -136);
  var1.angles = (0, 0, 0);
  thread ref_13516(level);
  wait var0;
  var2 = spawnStruct();
  var2.origin = (-5832, 31152, -203.252);
  var2.angles = (0, 0, 0);
  thread ref_13516(level);
  wait var0;
  ref_1433d(level);
  var3 = spawnStruct();
  var3.origin = (-4372, 32680, 121.278);
  var3.angles = (0, 0, 0);
  thread ref_13516(level);
  wait var0;
  ref_1433d(level);
  var4 = spawnStruct();
  var4.origin = (-4824, 31836, -162.932);
  var4.angles = (0, 0, 0);
  thread ref_13516(level);
}

function ref_1433d() {
  var0 = level.obj_leads_found;

  while(getcirclerangemax(var0)) {
    wait 5;
  }
}

function getcirclerangemax(var0) {
  if(level.obj_leads_found > var0 + 5) {
    if(level.ref_11f57.size <= 3) {
      return false;
    }
  }

  if(level.ref_11f57.size > 1) {
    return true;
  }

  return false;
}

function ref_13516(var0, var1) {
  level endon("game_ended");

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  if(!isDefined(var1)) {
    var1 = 50;
  }

  var2 = spawnStruct();
  var3 = spawnStruct();
  var2.origin = var0.origin;
  var2.angles = var0.angles;
  var2.spawntype = "GAME_MODE";
  var2.owner = undefined;
  var2.team = "axis";
  var2.faceawayfromowner = 0;
  var2.cancapture = 0;
  var2.cancaptureimmediately = 0;
  var2.activateimmediately = 1;
  var2.cantimeout = 0;
  var2.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var2);
  var2.spawnmethod = "airdrop_at_position_unsafe";
  var4 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var2, var3);

  if(!isDefined(var4)) {
    return;
  }

  var5 = ["dx_cps_kama_callout_tank_spawning_10", "dx_cps_kama_callout_tank_spawning_20", "dx_cps_lass_callout_tank_spawning_10", "dx_cps_lass_callout_tank_spawning_20"];
  thread play_vo_delay(level, scripts\engine\utility::random(var5), undefined, undefined, undefined);
  level.ref_11f57[level.ref_11f57.size] = var4;
  wait 6.5;
  thread tank_waittill_death();
  var4 endon("death");
  var4 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  thread tank_hitmarkers();
  setheadiconsnaptoedges(var4.headicon, 8000);
  var6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var4, "tur_bradley_mp");
  var7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var4, "tur_gun_lighttank_mp");
  var8 = 250000;
  var9 = 4840000;
  wait 5;

  for(;;) {
    var10 = var4 scripts\cp\utility::get_closest_living_player(var9);

    if(!isDefined(var10)) {
      wait 1;
      continue;
    }

    var11 = var4.origin + (0, 0, 160);
    var12 = var10.origin + (0, 0, 32);
    var13 = scripts\engine\trace::_bullet_trace(var11, var12, 1, var7);

    if(!isDefined(var13["entity"]) || !isPlayer(var13["entity"])) {
      wait 1;
      continue;
    }

    if(istrue(var10.binvehicle) && isDefined(var10.vehicle)) {
      if(var6 turretcantarget(var10.vehicle.origin + (0, 0, 50))) {
        var6 settargetentity(var10.vehicle);
      }

      if(var7 turretcantarget(var10.vehicle.origin + (0, 0, 50))) {
        var7 settargetentity(var10.vehicle);
      }
    } else {
      ref_130f2(var6, var10, 9, var1, var8);
      var7 settargetentity(var10);
    }

    thread tank_shoot_at_target(var4, var7);
    thread tank_shoot_at_target(var4, var6, undefined);
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

function tank_shoot_at_target(var0, var1, var2) {
  level endon("game_ended");
  var0 endon("death");
  var3 = 4;
  var4 = 4;

  if(istrue(var1)) {
    var3 = randomintrange(80, 120);
    var4 = 0.05;
  }

  if(isDefined(var2)) {
    wait var2;
  }

  for(var5 = 0; var5 < var3; var5++) {
    var0 shootturret();
    wait weaponfiretime("tur_gun_lighttank_mp") + var4;
  }
}

function tank_hitmarkers() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var1) && isPlayer(var1)) {
      var1.lasthitmarkertime = undefined;
      var1 scripts\cp\cp_damagefeedback::updatedamagefeedback("standard");
    }
  }
}

function ref_130f2(var0, var1, var2, var3) {
  if(distancesquared(self.origin, var0.origin) < var3) {
    self settargetentity(var0);
    return;
  }

  if(var1 > randomint(9)) {
    if(!isDefined(var2)) {
      var2 = 20;
    }

    var4 = randomfloatrange(var2 * -1, var2);
    var5 = randomfloatrange(var2 * -1, var2);
    var6 = randomfloatrange(var2 * -1, var2);
    self settargetentity(var0, (var4, var5, var6));
    return;
  }

  self settargetentity(var0);
}