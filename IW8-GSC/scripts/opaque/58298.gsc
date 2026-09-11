/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58298.gsc
***********************************************/

function keypad_check_levelinput() {
  if(!isDefined(level.ref_13d51)) {
    level.ref_13d51 = [];
  }

  level.ref_13d51["gunslinger"] = &init;
}

function init() {
  build_vehicle_drop_off_list();
  scripts\engine\utility::flag_init("endwave_audiocountdown_running");
  level.ref_13d26 = 0;

  if(level.trial["missionID"] == 1021) {
    init_nuke_vault((1735, 1184.25, 40), (0, 108, -90), "trial_variant_pickup", "outline", "iw8_pi_mike9+trigcust03+stockcust+reflexmini+fastreload+xmagslrg+barlong");
    level.ref_13d26 = 1;
    level.armsrace_c4_planter_super = 500;
    level.showplacementsplashesandmusic = 5;
    level.player_retry_thread = 0.4;
  } else if(level.trial["variant"] == "reflex") {
    init_nuke_vault((1735, 1184.25, 40), (0, 108, -90), "trial_variant_pickup", "outline", "iw8_pi_mike1911+fastreload+trigcust03");
    level.ref_14533 = [2500, 2500, 4000, 4000];
    level.ref_13938 = [1, 1, 1, 2];
    level.armsrace_c4_planter_super = 500;
    level.showplacementsplashesandmusic = 5;
    level.player_retry_thread = 0.4;
  } else if(level.trial["variant"] == "riffle") {
    init_nuke_vault((1737, 1180.25, 40), (0, 75, -90), "trial_variant_pickup", "outline", "iw8_sn_sbeta+barlong+comp+laserbalanced+fastreload+acog3");
    level.ref_14533 = [2500, 2500, 5500, 5500];
    level.ref_13938 = [1, 1, 1, 2];
    level.armsrace_c4_planter_super = 500;
    level.showplacementsplashesandmusic = 5;
    level.player_retry_thread = 0.4;
  } else if(level.trial["variant"] == "infinite") {
    init_nuke_vault((25.807, -553.161, 301), (180, 225, 90), "trial_variant_pickup", "outline", "iw8_ar_falima+hybrid2+gripang+barshort+pistolgrip01+fastreload");
    level.ref_14533 = [5000, 6000, 7000, 8000];
    level.ref_13938 = [2, 2, 2, 3];
    level.armsrace_c4_planter_super = 1000;
    level.showplacementsplashesandmusic = 5;
    level.player_retry_thread = 0.4;
  } else if(level.trial["variant"] == "knife") {
    level.ref_14533 = [2200, 4000, 6500, 7500];
    level.ref_13938 = [1, 1, 1, 2];
    level.armsrace_c4_planter_super = 500;
    level.showplacementsplashesandmusic = 8.5;
    level.player_retry_thread = 0.4;
    thread ref_12a8f();
    thread script_model_spawn_and_use();
    thread ref_1378e();
  } else if(level.trial["variant"] == "memory") {
    init_nuke_vault((-82, 1250, -195), (0, 180, -90), "trial_variant_pickup", "outline", "iw8_sn_sksierra+fastreload+smags+pistolgrip03+barshort+laserbalanced");
    level.ref_14533 = [4100, 5100, 6100, 6100];
    level.ref_13938 = [1, 1, 1, 2];
    level.armsrace_c4_planter_super = 500;
    level.showplacementsplashesandmusic = 5;
    level.player_retry_thread = 1.5;
  }

  level.trial_infinite_reserve_ammo = 1;
  var_0 = getEntArray("target_brushmodel", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2.targetname = "null";
    var_2.target = "null";
  }

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  weapon_xp_iw8_sn_awhiskey();
  level.course_targets = gettargetarray();
  level.movers = scripts\engine\utility::getStructArray("mover_start", "script_noteworthy");
  var_4 = ["1", "2", "3", "4"];
  var_5 = ["1", "2", "3", "4"];
  level.civilian_targets = [];
  level.enemy_targets = [];
  level.nodes_set_children = [];
  level.current_shield_tagattach = [];
  level.current_steps = [];
  level.ref_13d7c = [];
  level.ref_13d7d = [];

  foreach(var_7 in var_4) {
    if(!isDefined(level.ref_13d7c[var_7])) {
      level.ref_13d7c[var_7] = [];
    }

    foreach(var_9 in var_5) {
      if(!isDefined(level.ref_13d7c[var_7][var_9])) {
        level.ref_13d7c[var_7][var_9] = [];
      }
    }
  }

  foreach(var_13 in level.course_targets) {
    var_7 = var_13.targetname[4];
    var_9 = var_13.targetname[5];
    level.ref_13d7c[var_7][var_9][level.ref_13d7c[var_7][var_9].size] = var_13;

    if(var_7 == "4") {
      level.ref_13d7d[level.ref_13d7d.size] = var_13;
    }
  }

  dialog_init();
  progression();
}

function progression() {
  _tablethide::waittill_player_isDefined();

  foreach(var_1 in level.course_targets) {
    var_1.activated = 0;
    thread target_think();
  }

  if(level.trial["variant"] == "knife") {
    thread process_struct_angle_tilt();
  }

  hud_init();

  for(;;) {
    trial_score_init();

    if(level.trial["variant"] == "memory") {
      thread serverroomrewardspawn();
    }

    level.ref_13a6e = 0;
    _tablethide::trial_ui_set_wave(1, level.ref_13d7c.size);
    course_start_wait();
    level.ref_13d64 = 0;
    thread ref_12efa();
    _tablethide::ref_13d88();
    _tablethide::ref_13d89(0);

    if(level.ref_13d26) {
      hideconesifinfil();
      level.ref_13d64 = 1;
    } else {
      ref_14523();
      thread targets_missed_calculate();
    }

    _tablethide::ref_13d89(1);
    score_calculate(1);

    foreach(var_7 in level.player.primaryinventory) {
      level.player setweaponammoclip(var_7, weaponclipsize(var_7));
    }

    _tablethide::trial_ui_waittill_retry();
  }
}

function course_start_wait() {
  if(istrue(level.trial_first_start)) {
    return;
  }

  var_0 = getEnt("outline", "script_noteworthy");

  if(isDefined(var_0)) {
    while(!isDefined(var_0.spawned_weapon)) {
      waitframe();
    }

    while(isDefined(var_0.spawned_weapon)) {
      waitframe();
    }
  } else {
    level waittill("start");
  }

  level.trial_first_start = 1;
  level notify("course_started");
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_start");
  wait 1;
}

function hideconesifinfil() {
  level.ref_13d2d = 0;
  level endon("trial_combo_died");
  level.player playSound("trial_sfx_success");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("ui_match_start_countdown", -1);
  level.player playSound("trial_sfx_start");
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_search");
  level.ref_13d6e = gettime();
  thread hidedangercircle();
  var_0 = int(level.ref_13d7d.size * 0.35);
  ref_129ff(level.ref_13d7d, var_0);
  var_1 = 0;
  level.ref_13d4f = 0;

  for(;;) {
    var_2 = scripts\engine\utility::array_randomize(level.ref_13d7d);
    var_3 = var_2[0];

    foreach(var_3 in var_2) {
      if(!var_3.state_up && !var_3.flipping) {
        if(!var_3.iscivilian) {
          var_3.script_speed = randomfloatrange(48, 128);
          var_1 = 1;
          level.ref_13d4f = min(level.ref_13d4f + 100, 3000);
        } else if(var_1 == 1) {
          var_3.script_speed = 32;
          var_1 = 0;
        } else {
          continue;
        }

        thread hidedeathicon();
        break;
      }
    }

    if(!var_3.iscivilian) {
      wait 1;
    }
  }
}

function hidedeathicon() {
  target_flip("up");
  self endon("flip_down");
  var_0 = gettime();
  var_1 = max(5000 - level.ref_13d4f, 2000);

  while(gettime() < var_0 + var_1) {
    waitframe();
  }

  thread ref_13a5f();
}

function ref_14523() {
  foreach(var_5, var_1 in level.ref_13d7c) {
    hud_inter_round_flow(int(var_5));
    _tablethide::trial_ui_set_wave(int(var_5), level.ref_13d7c.size);

    foreach(var_3 in var_1) {
      ref_1393f(var_5, var_4);
    }
  }
}

function ref_1393f(var_0, var_1) {
  var_2 = gettime();
  _tablethide::trial_ui_set_secondary_timer(var_2 + level.ref_14533[int(var_0) - 1]);
  ref_129ff(level.ref_13d7c[var_0][var_1], level.ref_13938[int(var_1) - 1]);

  foreach(var_4 in level.ref_13d7c[var_0][var_1]) {
    thread target_flip(var_4);
  }

  level notify("next_wave");

  while(gettime() < var_2 + level.ref_14533[int(var_0) - 1]) {
    waitframe();
  }

  foreach(var_4 in level.ref_13d7c[var_0][var_1]) {
    thread target_flip(var_4);
  }

  _tablethide::trial_ui_set_secondary_timer(-1);
  wait 2;
}

function ref_129ff(var_0) {
  var_1 = ["ee_military_shooting_range_plate_02_enemy_01", "ee_military_shooting_range_plate_02_enemy_02", "ee_military_shooting_range_plate_02_enemy_03", "ee_military_shooting_range_plate_02_enemy_04", "ee_military_shooting_range_plate_02_enemy_05", "ee_military_shooting_range_plate_02_enemy_06"];
  var_2 = ["ee_military_shooting_range_plate_civilian_01", "ee_military_shooting_range_plate_civilian_02", "ee_military_shooting_range_plate_civilian_03"];
  var_3 = scripts\engine\utility::array_randomize(self);

  foreach(var_5 in var_3) {
    if(var_8 < var_0) {
      var_6 = scripts\engine\utility::random(var_2);
      var_5.plate setModel(var_6);
      var_5.iscivilian = 1;
      level.civilian_targets = scripts\engine\utility::array_add(level.civilian_targets, var_5);

      if(var_0 <= var_2.size) {
        var_2 = scripts\engine\utility::array_remove(var_2, var_6);
      }
    } else {
      if(var_1.size == 0) {
        var_1 = ["ee_military_shooting_range_plate_02_enemy_01", "ee_military_shooting_range_plate_02_enemy_02", "ee_military_shooting_range_plate_02_enemy_03", "ee_military_shooting_range_plate_02_enemy_04", "ee_military_shooting_range_plate_02_enemy_05", "ee_military_shooting_range_plate_02_enemy_06"];
      }

      var_7 = scripts\engine\utility::random(var_1);
      var_5.plate setModel(var_7);
      var_5.iscivilian = 0;
      level.enemy_targets = scripts\engine\utility::array_add(level.enemy_targets, var_5);
      var_1 = scripts\engine\utility::array_remove(var_1, var_7);
    }

    waitframe();
  }
}

function target_think() {
  self.initial_up = anglestoup(self.angles);
  self.parts = getEntArray(self.script_linkname, "script_linkto");
  self.parts = scripts\engine\utility::array_remove(self.parts, self);

  foreach(var_1 in self.parts) {
    switch (var_1.script_noteworthy) {
      case "target_plate":
        self.plate = var_1;
        break;
      case "target_arm":
        self.arm = var_1;
        break;
      case "target_base":
        self.base = var_1;
        break;
      case "target_wheels":
        self.wheels = var_1;
        break;
      default:
        break;
    }

    var_1.target = "null";
    var_1.targetname = "null";
  }

  self.plate linkTo(self);
  self.arm linkTo(self);

  if(isDefined(self.wheels)) {
    self.wheels linkTo(self.base);
  }

  self.state_up = 0;
  self.flipping = 0;
  self.thermiteboltstuckto = self.angles;
  thread target_damage();
  self.activated = 0;
  waitframe();

  if(issubstr(self.script_noteworthy, "moving")) {
    thread moving_target_think();
    return;
  }
}

function gettargetarray() {
  var_0 = ["standard_target", "moving_target"];
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = scripts\engine\utility::getStructArray(var_0[var_2], "script_noteworthy");

    foreach(var_5 in var_3[var_2]) {
      var_6 = spawn("script_origin", var_5.origin);
      var_6.angles = var_5.angles;
      var_6.script_gameobjectname = var_5.script_gameobjectname;
      var_6.script_linkname = var_5.script_linkname;
      var_6.script_noteworthy = var_5.script_noteworthy;
      var_6.target = var_5.target;
      var_6.targetname = var_5.targetname;
      var_6.script_delay = var_5.script_delay;
    }
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = getEntArray(var_0[var_2], "script_noteworthy");
  }

  return scripts\engine\utility::array_combine_multiple(var_1);
}

function target_damage() {
  for(;;) {
    self.activated = 0;
    self.spawn_infil_lbravo = 0;
    self.plate waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    level.ref_13d77 = 1;
    self.plate setCanDamage(0);
    self.plate playSound("trial_sfx_target_report_metal");

    if(self.iscivilian) {
      self.spawn_infil_lbravo = 1;
      self.activated = 1;
      level.player thread _tablethide::ref_13d4b(self, 0, 1, 0);
      level.player thread scripts\mp\rank::scoreeventpopup("trial_civilian_killed");
      self playSound("trial_sfx_buzzer_bad_1");
      ref_12efe();
    } else {
      self.spawn_infil_lbravo = 1;
      level.player thread _tablethide::ref_13d4b(self, 1, 0, 0);
      self.activated = 1;
      thread score_event_target_hit();
      var_10 = self.plate gettagorigin("tag_head");
      var_11 = distance(var_3, var_10);
      thread targets_missed_calculate();

      if(var_11 < level.showplacementsplashesandmusic) {
        level.nodes_set_children = level.nodes_set_children scripts\engine\utility::array_add(level.nodes_set_children, self);
        thread ref_12f02();
      }
    }

    if(!isDefined(level.targethitsinaframecount)) {
      level.targethitsinaframecount = 0;
    }

    self.activated = 1;
    level.targethitsinaframecount++;

    if(isDefined(level.lasttargethitinaframe) && level.lasttargethitinaframe.iscivilian && !self.iscivilian && level.targethitsinaframecount > 1) {
      level.shots_fired++;
    }

    level.lasttargethitinaframe = self;
    level.shotsmissedcount = 0;
    level.last_hit_target = self;

    if(level.targethitsinaframecount > 1 && level.lasttargethitinaframe == self) {
      if(!level.lasttargethitinaframe.iscivilian && !level.last_hit_target.iscivilian) {
        level.player scripts\engine\utility::delaythread(0.5, &scripts\mp\utility\dialog::leaderdialogonplayer, "sniper_nice_shot");
        thread score_event_collateral(level.targethitsinaframecount);
      }
    }

    var_12 = weaponfiretime(var_9);

    if(var_12 > 0.05) {
      wait var_12;
    } else {
      waittillframeend();
    }

    thread ref_13a5f();
    waittillframeend();

    if(level.targethitsinaframecount > 1 && self.iscivilian) {
      level.shots_fired++;
    }

    level notify("accuracy_update");
    level.targethitsinaframecount = 0;

    if(level.ref_13d26) {
      self waittill("flip_up");
      continue;
    }

    level waittill("course_ended");
  }
}

function ref_13a5f() {
  while(self.flipping) {
    waitframe();
  }

  if(!self.state_up) {
    return;
  }

  thread target_flip("down");
}

function target_flip(var_0) {
  if(var_0 == "up") {
    if(!level.ref_13d26 && isDefined(self.script_delay)) {
      wait self.script_delay;
    }

    self.plate setCanDamage(1);

    if(self.state_up) {
      return;
    }

    self.state_up = 1;
    var_1 = 1;
    self.activated = 0;
    self notify("flip_up");
  } else {
    if(!self.state_up) {
      return;
    }

    self.state_up = 0;
    var_1 = -1;
    self notify("flip_down");
  }

  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  switch (self.script_noteworthy) {
    case "moving_target":
    case "standard_target":
      var_3 = 90;
      var_4 = 180;
      var_2 = 0.15;
      var_5 = 0.15;
      break;
    default:
      break;
  }

  self.flipping = 1;

  if(issubstr(self.script_noteworthy, "moving")) {
    waitframe();
  }

  if(var_1 == "up") {
    self playsoundonmovingent("trial_sfx_target_flipup");
  }

  if(self.initial_up[1] != 0) {
    self rotateYaw(-1 * self.initial_up[1] * var_3 * var_1, var_2);
  } else if(!self.state_up && !istrue(self.spawn_infil_lbravo)) {
    self rotateroll(self.initial_up[2] * var_4 * var_1, var_5);
    wait 0.4;
    self.plate setCanDamage(0);
    self rotatepitch(self.initial_up[2] * var_3 * var_1, var_2);
  } else if(!self.state_up && isDefined(level.lasttargethitinaframe) && level.lasttargethitinaframe.spawn_infil_lbravo && !level.ref_13d26) {
    self rotatepitch(self.initial_up[2] * var_3 * var_1, var_2);
    self.plate setCanDamage(0);
    level.lasttargethitinaframe.spawn_infil_lbravo = 0;

    if(!level.ref_13d26) {
      level waittill("course_ended");
      wait 6;
      self rotateroll(self.initial_up[2] * var_4 * var_1, var_5);
    } else {
      wait var_2;
      wait 0.5;
      self.angles = self.thermiteboltstuckto;
    }
  } else {
    self rotatepitch(self.initial_up[2] * var_3 * var_1, var_2);
    wait level.player_retry_thread;
    waitframe();
    self rotateroll(self.initial_up[2] * var_4 * var_1, var_5);
  }

  if(var_1 == "down") {
    self playsoundonmovingent("trial_sfx_target_flipdown");
  }

  wait var_2;
  waitframe();
  self.flipping = 0;
}

function moving_target_think() {
  self.mover = scripts\engine\utility::getclosest(self.origin, level.movers, 32);

  if(!isDefined(self.mover)) {
    return;
  }

  self.mover_ends = scripts\engine\utility::getStructArray(self.mover.targetname, "target");
  self.mover_ends = sortbydistance(self.mover_ends, self.mover.origin);
  self.moveforward = 1;
  self.moving = 0;

  if(isDefined(self.script_speed)) {
    self.move_speed = self.script_speed;
  } else {
    self.move_speed = 32;
  }

  thread moving_target_reset();

  for(;;) {
    if(self.moving && (90 > distance(level.players[0].origin, self.origin) || !self.state_up)) {
      self notify("stop_moving");
      self.moving = 0;
      self.dummy delete();
      self.plate playSound("trial_sfx_target_move_stop");
      self.dummy thread scripts\engine\utility::stop_loop_sound_on_entity("trial_sfx_target_move_loop");
    } else if(!self.flipping && !self.moving && 90 < distance(level.players[0].origin, self.origin) && self.state_up) {
      thread moving_target_mover();
    }

    waitframe();
  }
}

function moving_target_mover() {
  self endon("stop_moving");
  self.moving = 1;
  self.dummy = spawn("script_origin", self.origin);
  GscBinSkip4(0x35);
}

function moving_target_reset() {
  for(;;) {
    level waittill("trial_results_screen_opened");
    waitframe();
    self.origin = self.mover.origin;
    self.base.origin = self.mover.origin;
    self.moveforward = 1;
  }
}

function target_follow_dummy() {
  for(;;) {
    self.origin = self.dummy.origin;
    self.base.origin = self.dummy.origin;
    waitframe();
  }
}

function trial_score_init() {
  if(!isDefined(level.score_initialized_once)) {
    level.score = [];
    level.score["best"] = 0;
    _tablethide::trial_ui_set_best_score(level.score["best"]);
    level.score_initialized_once = 1;
  }

  level.score["total"] = 0;
  level.score["subtotal"] = 0;
  level.score["target_hit"] = 0;
  level.score["civilian_targets_hit"] = 0;
  level.score["accuracy"] = 0;
  level.score["head_shot"] = 0;
  level.score["collateral"] = 0;
  level.score["trickshot"] = 0;
  level.civilian_targets = [];
  level.enemy_targets = [];
  level.nodes_set_children = [];
  level.enemies_missed = level.enemy_targets.size;
  level.enemies_killed = 0;
  level.civs_killed = 0;
  level.shots_fired = 0;
  level.course_accuracy = 0;
  level.headshot = 0;
  level.current_tablet = 0;
  level.ref_13d2c = 0;
  level.current_tablet = 0;
  _tablethide::trial_ui_set_stat_and_bonus_score(1, "accuracy", 100 * level.course_accuracy, level.score["accuracy"]);
  _tablethide::trial_ui_set_stat_and_bonus_score(2, "head_shot", level.headshot, level.score["head_shot"]);
  _tablethide::trial_ui_set_stat_and_bonus_score(3, "civilian_targets_hit", level.civs_killed, -1 * level.score["civilian_targets_hit"]);

  if(level.trial["variant"] == "knife") {
    _tablethide::trial_ui_set_stat_and_bonus_score(4, "special_target_hit", level.current_tablet, 0);
  }

  score_calculate();
}

function score_event_target_hit() {
  if(istrue(level.ref_13d64)) {
    return;
  }

  level.score["target_hit"] = level.score["target_hit"] + 100;
  level.player thread scripts\mp\rank::scorepointspopup(100);
  level.enemies_killed++;

  if(level.ref_13d26) {
    thread hidedangercircle();
  }

  score_calculate();
}

function ref_12efe() {
  if(istrue(level.ref_13d64)) {
    return;
  }

  if(!level.civilian_targets.size) {
    return;
  }

  level notify("civ_hit");
  level.civs_killed++;
  level.score["civilian_targets_hit"] = level.score["civilian_targets_hit"] + 200;
  _tablethide::trial_ui_set_stat_and_bonus_score(3, "civilian_targets_hit", level.civs_killed, -1 * level.score["civilian_targets_hit"]);
}

function ref_12f02() {
  if(istrue(level.ref_13d64)) {
    return;
  }

  level endon("course_ended");

  if(!level.enemy_targets.size) {
    return;
  }

  level.player thread scripts\mp\rank::scoreeventpopup("headshot");
  level.player thread scripts\mp\rank::scorepointspopup(50);
  level notify("headshot");
  level.headshot = 0;

  foreach(var_1 in level.nodes_set_children) {
    level.headshot++;
  }

  level.score["head_shot"] = level.score["head_shot"] + 50;
  _tablethide::trial_ui_set_stat_and_bonus_score(2, "head_shot", level.headshot, 0);
}

function ref_12efa() {
  level endon("course_ended");
  level.shots_fired = 0;

  for(;;) {
    level.player scripts\engine\utility::ref_143a6("weapon_fired", "fake_weapon_fired", "grenade_fire");
    level.shots_fired++;
    waittillframeend();

    if(istrue(level.ref_13d77)) {
      level waittill("accuracy_update");
      level.ref_13d77 = 0;
    }

    if(level.trial["variant"] == "knife") {
      level.course_accuracy = (level.enemy_targets.size + level.current_steps.size - level.enemies_missed) / max(1, level.shots_fired);
    } else if(level.ref_13d26) {
      if(istrue(level.ref_13d64)) {
        continue;
      }

      level.course_accuracy = level.enemies_killed / max(1, level.shots_fired);
    } else {
      level.course_accuracy = (level.enemy_targets.size - level.enemies_missed) / max(1, level.shots_fired);
    }

    var_0 = level.course_accuracy * level.armsrace_c4_planter_super;
    level.score["accuracy"] = var_0 % 1300;
    _tablethide::trial_ui_set_stat_and_bonus_score(1, "accuracy", 100 * level.course_accuracy, level.score["accuracy"]);
  }
}

function targets_missed_calculate() {
  level.enemies_missed = 0;

  foreach(var_1 in level.enemy_targets) {
    if(!var_1.activated) {
      level.enemies_missed++;
    }
  }
}

function score_event_collateral(var_0) {
  var_1 = 50 * (var_0 - 1);
  level.score["collateral"] = level.score["collateral"] + var_1;

  switch (var_0) {
    case 3:
      var_2 = "trial_collateral_triple";
      break;
    case 4:
      var_2 = "trial_collateral_quad";
      break;
    default:
      var_2 = "trial_collateral";
      break;
  }

  level.player thread scripts\mp\rank::scoreeventpopup(var_2);
  level.player thread scripts\mp\rank::scorepointspopup(var_2);
}

function score_calculate(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  level.score["subtotal"] = level.score["target_hit"] + level.score["head_shot"] + level.score["trickshot"] + level.score["collateral"];
  level.score["before_total"] = level.score["subtotal"] + level.score["accuracy"] - level.score["civilian_targets_hit"];
  level.score["total"] = clamp(level.score["before_total"], 0, 999999);
  _tablethide::trial_ui_set_subscore(level.score["subtotal"]);
  hud_set_reward_tier();

  if(var_0) {
    _tablethide::trial_ui_set_secondary_timer(-1);
    wait 1;
    _tablethide::trial_ui_set_main_score(level.score["total"]);

    if(level.score["best"] < level.score["total"]) {
      level.score["best"] = level.score["total"];
      _tablethide::trial_ui_set_best_score(level.score["best"]);
      game["trial"]["analytics"]["accuracy"] = level.course_accuracy;
      game["trial"]["analytics"]["missed"] = level.enemies_missed;
      game["trial"]["analytics"]["civilians"] = level.civs_killed;
    }

    hud_set_reward_tier(1);
    level notify("course_ended");

    if(istrue(level.ref_13d6c)) {
      wait 5;
    }

    thread _tablethide::trial_ui_open_results_screen();
    return;
  }
}

function hidedangercircle() {
  level notify("combo_reset");
  level endon("combo_reset");

  if(istrue(level.ref_13d2d)) {
    return;
  }

  waitframe();
  var_0 = hideassassinationtargethud();
  level.ref_13d2c++;
  _tablethide::ref_13d8c(var_0);
  _tablethide::ref_13d8b(max(level.ref_13d2c, 1));
  var_1 = gettime();

  while(gettime() < var_1 + var_0) {
    waitframe();
  }

  wait 0.25;
  level notify("trial_combo_died");
  level.ref_13d2d = 1;
  _tablethide::ref_13d8b(0);

  foreach(var_3 in level.ref_13d7d) {
    thread ref_13a5f();
  }
}

function hideassassinationtargethud() {
  var_0 = gettime() - level.ref_13d6e;
  var_1 = int(var_0 / 10);
  var_2 = level.civs_killed * 750;
  var_3 = clamp(7500 - var_1 - var_2, 1250, 7500);

  if(level.player isreloading() || level.player getcurrentweaponclipammo() == 0) {
    var_3 = max(var_3, 1750);
  }

  return var_3;
}

function hud_init() {
  level.ref_13a6e = 0;
  level.wave_time = 30;
  level.timer_paused = 0;
  level.score["trickshot"] = 0;
  _tablethide::trial_ui_set_subscore(0);
  _tablethide::trial_ui_set_wave(1, level.ref_13d7c.size);
  _tablethide::trial_ui_set_reward_tier_preview(0);
  _tablethide::trial_ui_set_objective_icon_index(1);
}

function hud_set_reward_tier(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
    var_1 = level.score["best"];
  } else {
    var_1 = level.score["subtotal"];
  }

  if(var_1 >= level.trial["tier3"]) {
    var_2 = 3;
  } else if(var_2 >= level.trial["tier2"]) {
    var_3 = level.trial["tier3"] - level.trial["tier2"];
    var_4 = var_2 - level.trial["tier2"];
    var_2 = 2 + var_4 / var_3;
  } else if(var_2 >= level.trial["tier1"]) {
    var_3 = level.trial["tier2"] - level.trial["tier1"];
    var_4 = var_2 - level.trial["tier1"];
    var_2 = 1 + var_4 / var_3;
  } else {
    var_2 /= level.trial["tier1"];
  }

  if(var_2) {
    _tablethide::trial_ui_set_reward_tier(var_2);

    if(var_2 >= level.trial["tier3"]) {
      var_5 = game["music"]["trials_win_high"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["music"]["trials_win_high"][var_6]);
      return;
    }

    if(var_5 >= level.trial["tier2"]) {
      var_5 = game["music"]["trials_win_mid"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][var_6]);
      return;
    }

    if(var_5 >= level.trial["tier1"]) {
      var_5 = game["music"]["trials_win_low"].size;
      var_6 = randomint(var_5);
      level.player setplayermusicstate(game["music"]["trials_win_low"][var_6]);
      return;
    }

    var_5 = game["music"]["trials_loss"].size;
    var_6 = randomint(var_5);
    level.player setplayermusicstate(game["music"]["trials_loss"][var_6]);
    return;
  }

  _tablethide::trial_ui_set_reward_tier_preview(var_6);
}

function hud_inter_round_flow(var_0) {
  _tablethide::trial_ui_freeze_secondary_timer(1);
  setomnvar("ui_match_start_text", "wave_" + var_0 + "_start");
  level.player playSound("trial_sfx_success");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("ui_match_start_countdown", -1);
  setomnvar("ui_match_start_text", "none");
  level.player playSound("trial_sfx_start");
  _tablethide::trial_ui_set_wave(int(var_0), level.ref_13d7c.size);
  _tablethide::trial_ui_freeze_secondary_timer(0);
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("kh_sniper_search");
}

function dialog_init() {
  game["dialog"]["trial_intro"] = "mp_m_speedball_gc3_intro";
  game["dialog"]["trial_intro_short"] = "mp_m_speedball_gc3_intro";
  game["dialog"]["trial_end_tier_0"] = "kh_sniper_star0";
  game["dialog"]["trial_end_tier_1"] = "kh_sniper_star1";
  game["dialog"]["trial_end_tier_2"] = "kh_sniper_star2";
  game["dialog"]["trial_end_tier_3"] = "kh_sniper_star3";
  game["dialog"]["trial_retry"] = "kh_sniper_retry";
  game["dialog"]["sniper_start"] = "kh_sniper_start";
  game["dialog"]["sniper_search"] = "kh_sniper_search";
  game["dialog"]["sniper_nice_shot"] = "kh_sniper_goodshot";
  game["dialog"]["sniper_hurry_up"] = "kh_sniper_hurryup";
  game["dialog"]["sniper_try_again"] = "kh_sniper_retry";
  game["dialog"]["good_shot"] = "mp_m_speedball_gc3_good";
  game["dialog"]["course_start"] = "mp_m_speedball_obj_nag_start";
  game["dialog"]["course_nice_shot"] = "mp_m_speedball_obj_nag_nice";
  game["dialog"]["course_civilian_shot"] = "kh_guncourse_checkfire";
  game["dialog"]["course_hurry_up"] = "mp_m_speedball_obj_nag_hurry";
  game["dialog"]["trickshot"] = "mp_spear_throw_special";
  thread light_tank_monitordriverturretprojectilefire();
  thread dialog_kill_watcher();
  thread light_tank_monitorgunnerturretfire();
  thread levelonlaststandfunc();
}

function init_nuke_vault(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", var_0);

  if(isDefined(var_1)) {
    var_5.angles = var_1;
  }

  if(isDefined(var_2)) {
    var_5.script_gameobjectname = var_2;
  } else {
    var_5.script_gameobjectname = "trial";
  }

  if(isDefined(var_3)) {
    var_5.script_noteworthy = var_3;
  }

  var_5.targetname = "trial_weapon";
  var_5.script_parameters = var_4;
  return var_5;
}

function weapon_xp_iw8_sn_awhiskey() {
  level.ref_12d3a = getEntArray("rifle", "targetname");
  level.ref_12382 = getEntArray("pitcher", "targetname");
  wait 0.05;
  jumpiffalse(level.trial["missionID"] == 1002) LOC_00000095;

  foreach(var_1 in level.ref_12d3a) {
    var_1 setlightintensity(1);
  }

  foreach(var_1 in level.ref_12382) {
    var_1 setlightintensity(0);
  }

  return;
}

function build_vehicle_drop_off_list() {
  level.ref_13d32 = &ref_13d34;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["accuracy"] = 0;
    game["trial"]["analytics"]["missed"] = 0;
    game["trial"]["analytics"]["civilians"] = 0;
    return;
  }
}

function ref_13d34() {
  var_0 = level.trial["missionID"];
  var_1 = getomnvar("ui_trial_reward_tier");
  var_2 = getomnvar("ui_trial_best_score");
  var_3 = float(game["trial"]["analytics"]["accuracy"]);
  var_4 = int(game["trial"]["analytics"]["missed"]);
  var_5 = int(game["trial"]["analytics"]["civilians"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_gunslinger", ["id", var_0, "tier", var_1, "score", var_2, "accuracy", var_3, "missed", var_4, "civilians", var_5]);
}

function ref_12a90(var_0, var_1) {
  var_2 = var_0.rechargeequipmentstate;

  if(!isDefined(var_2.progress[var_1])) {
    var_2.progress[var_1] = 0;
  }

  var_2.recharged[var_1] = undefined;
  var_3 = var_0 scripts\mp\equipment::getcurrentequipment(var_1);

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = var_0 scripts\mp\equipment::getequipmentammo(var_3);
  var_5 = var_0 scripts\mp\equipment::getequipmentmaxammo(var_3);
  var_6 = var_0 scripts\mp\equipment::getequipmentstartammo(var_3);

  if(var_4 < var_5) {
    var_2.progress[var_1] += 0.333333;
  } else {
    var_2.progress[var_1] = 0;
  }

  if(var_2.progress[var_1] >= 1) {
    var_0 scripts\mp\equipment::incrementequipmentslotammo(var_1, 1);
    var_2.progress[var_1] = 0;
    var_2.recharged[var_1] = 1;
    return;
  }
}

function ref_12a8f() {
  while(!isalive(level.player)) {
    waitframe();
  }

  for(;;) {
    while(isalive(level.player)) {
      ref_12a91(level.player);
      wait 0.1;
    }

    waitframe();
  }
}

function ref_12a91(var_0) {
  if(!isDefined(var_0.rechargeequipmentstate)) {
    var_0.rechargeequipmentstate = spawnStruct();
    var_0.rechargeequipmentstate.progress = [];
    var_0.rechargeequipmentstate.recharged = [];
  }

  ref_12a90(var_0, "primary");
  ref_12a90(var_0, "secondary");
  ref_12a92(var_0);
}

function ref_12a92(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = -1;

  if(isDefined(var_0) && isDefined(var_0.rechargeequipmentstate)) {
    var_0 scripts\mp\utility\stats::initpersstat("restockCount");
    var_4 = var_0.rechargeequipmentstate;

    if(isDefined(var_4.progress["primary"])) {
      var_1 = var_4.progress["primary"];
    }

    if(isDefined(var_4.progress["secondary"])) {
      var_2 = var_4.progress["secondary"];
    }

    foreach(var_6 in var_4.recharged) {
      if(var_7 == "primary") {
        var_3 += 1;
        var_0 playlocalsound("ui_restock_lethals");
        var_0 scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }

      if(var_7 == "secondary") {
        var_3 += 2;
        var_0 playlocalsound("ui_restock_tactical");
        var_0 scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }
    }
  }

  var_0 setclientomnvar("ui_lethal_recharge_progress", var_1);
  var_0 setclientomnvar("ui_tactical_recharge_progress", var_2);
  var_0 setclientomnvar("ui_recharge_notify", var_3);
}

function script_model_spawn_and_use() {
  level waittill("start");

  for(;;) {
    if(!isalive(level.player)) {
      while(!isalive(level.player)) {
        waitframe();
      }

      var_0 = "primary";
      level.player scripts\mp\equipment::giveequipment("equip_throwing_knife", var_0);
    }

    waitframe();
  }
}

function ref_1378e() {
  var_0 = getEnt("grenade_box_knife", "targetname");
  var_0 setHintString(&"MP_INGAME_ONLY/PRESS_TO_START_GAME");
  var_0 setCursorHint("hint_button");
  var_0 sethintdisplayrange(200);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(72);
  var_0 setusefov(120);
  var_0 sethintonobstruction("show");
  var_0 setuseholdduration("duration_short");
  var_0 makeusable();
  var_0 waittill("trigger");
  level notify("start");
  level.player scripts\mp\equipment::giveequipment("equip_throwing_knife", "primary");
  level.player playSound("gren_pickup_frag");
  var_0 makeunusable();
}

function process_struct_angle_tilt() {
  level.current_tablet = [];
  level.current_shield_tagattach = getEntArray("bonus_target", "targetname");

  if(level.current_shield_tagattach.size <= 0) {
    return;
  }

  level.explosion = loadfx("vfx/iw8/prop/scriptables/vfx_ee_food_fruit_watermelon_02_debris.vfx");

  foreach(var_1 in level.current_shield_tagattach) {
    var_1.ref_11e37 = 1;
    var_1 hide();
  }

  for(;;) {
    foreach(var_1 in level.current_shield_tagattach) {
      if(istrue(var_1.ref_11e37)) {
        var_1.ref_11e37 = 0;
        var_4 = spawn("script_model", var_1.origin);
        var_4 setModel(var_1.model);
        var_4.angles = var_1.angles;
        var_4.script_noteworthy = var_1.script_noteworthy;
        var_4.isbonus = 1;
        thread current_spawner(var_4);
        var_4 setCanDamage(1);
      }
    }

    level waittill("course_ended");
    wait 5;
  }
}

function current_spawner(var_0) {
  level endon("target_hit");
  self.activated = 0;
  self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  level.player thread scripts\mp\rank::scorepointspopup(int(self.script_noteworthy));
  level.player thread scripts\mp\utility\dialog::leaderdialogonplayer("good_shot");
  playFXOnTag(level.explosion, self, "TAG_ORIGIN");
  waitframe();
  self.activated = 1;
  self hide();
  level.current_tablet++;
  thread current_struct();
  self setCanDamage(0);
  var_0.ref_11e37 = 1;
  self delete();
}

function current_struct() {
  level.score["trickshot"] = level.score["trickshot"] + int(self.script_noteworthy);
  _tablethide::trial_ui_set_stat_and_bonus_score(4, "special_target_hit", level.current_tablet, 0);
  score_calculate();
}

function dialog_kill_watcher() {
  level waittill("course_started");

  for(;;) {
    level waittill("headshot");

    if(level.light_tank_initdamage) {
      level.player scripts\engine\utility::delaythread(0.25, &scripts\mp\utility\dialog::leaderdialogonplayer, "trickshot");
      level.light_tank_initdamage = 0;
    }

    waitframe();
  }
}

function light_tank_monitordriverturretprojectilefire() {
  level.light_tank_initdamage = 1;

  for(;;) {
    level waittill("headshot");
    wait 7;
    level.light_tank_initdamage = 1;
  }
}

function levelonlaststandfunc() {
  level waittill("course_started");

  for(;;) {
    level waittill("civ_hit");

    if(level.light_tank_initomnvars) {
      level.player scripts\engine\utility::delaythread(0.5, &scripts\mp\utility\dialog::leaderdialogonplayer, "course_civilian_shot");
      level.light_tank_initomnvars = 0;
    }

    waitframe();
  }
}

function light_tank_monitorgunnerturretfire() {
  level.light_tank_initomnvars = 1;

  for(;;) {
    level waittill("civ_hit");
    wait 7;
    level.light_tank_initomnvars = 1;
  }
}

function serverroomrewardspawn() {
  var_0 = scripts\engine\utility::getStructArray("grenade_effect", "script_noteworthy");

  for(var_1 = 1;; var_1++) {
    level waittill("next_wave");

    foreach(var_3 in var_0) {
      if(var_3.script_index == scripts\engine\utility::string(var_1)) {
        if(isDefined(var_3.script_delay)) {
          wait var_3.script_delay;
        }

        magicgrenademanual("smoke_grenade_mp", var_3.origin, (0, 0, -1), 0.05);
      }
    }
  }

  level waittill("course_ended");
  var_1 = 0;
}