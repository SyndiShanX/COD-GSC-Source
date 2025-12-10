/***********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_doors.gsc
***********************************************/

func_97B1() {
  scripts\engine\utility::flag_init("doors_initialized");
  scripts\engine\utility::flag_init("first_door_opened");
  if(!scripts\engine\utility::flag("init_interaction_done")) {
    scripts\engine\utility::flag_wait("init_interaction_done");
  }

  init_door_buys();
  init_team_killdoors();
  init_chi_doors();
  scripts\engine\utility::flag_set("doors_initialized");
}

func_59FA() {
  self endon("death");
  self endon("disconnect");
  self endon("saw_door_tutorial");
  wait(5);
  var_00 = cos(85);
  for(;;) {
    var_01 = getEntArray("door_buy", "targetname");
    var_02 = sortbydistance(var_01, self.origin);
    if(var_02.size > 0) {
      if(distancesquared(var_02[0].origin, self.origin) < 9216 && scripts\engine\utility::within_fov(self.origin, self.angles, var_02[0].origin, var_00)) {
        thread scripts\cp\cp_hud_message::tutorial_lookup_func("door_buy");
        self notify("saw_door_tutorial");
        wait(1);
      }
    }

    wait(0.1);
  }
}

init_door_buys() {
  var_00 = getEntArray("door_buy", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_EEAA)) {
      var_02 setuserange(var_02.var_EEAA);
    }

    level thread func_95B5(var_02);
    wait(0.05);
  }

  level.door_trigs = var_00;
}

func_95B5(param_00) {
  param_00 sethintstring(level.interaction_hintstrings[param_00.script_noteworthy]);
  var_01 = [];
  foreach(var_03 in level.current_interaction_structs) {
    if(!isDefined(var_03.target)) {
      continue;
    }

    if(var_03.target == param_00.target) {
      var_01[var_01.size] = var_03;
    }
  }

  var_05 = func_7E81(var_01[0].script_noteworthy);
  if(isDefined(level.enter_area_hint)) {
    param_00 sethintstringparams(level.enter_area_hint, var_05);
  } else {
    param_00 sethintstringparams(&"CP_ZMB_INTERACTIONS_ENTER_THIS_AREA", var_05);
  }

  if(isDefined(level.door_properties_func)) {
    [[level.door_properties_func]](param_00);
  }

  for(;;) {
    param_00 waittill("trigger", var_06);
    if(isent(var_06) && !var_06 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isplayer(var_06)) {
      if(!var_06 scripts\cp\cp_interaction::can_purchase_interaction(var_01[0], level.interactions[var_01[0].script_noteworthy].cost, level.interactions[var_01[0].script_noteworthy].spend_type)) {
        level notify("interaction", "purchase_denied", level.interactions[var_01[0].script_noteworthy], var_06);
        var_06 func_100F4();
        continue;
      }

      param_00 notify("purchased");
      level notify("door_opened_notify");
      if(!scripts\engine\utility::flag("can_drop_coins")) {
        scripts\engine\utility::flag_set("can_drop_coins");
      }

      var_06 scripts\cp\cp_merits::processmerit("mt_purchase_doors");
      var_06 notify("door_opened_notify");
      var_06 scripts\cp\cp_persistence::take_player_currency(level.interactions[var_01[0].script_noteworthy].cost, 1, "door");
      scripts\cp\zombies\zombie_analytics::func_AF7E(1, var_06, var_01[0].script_area, level.interactions[var_01[0].script_noteworthy].cost, level.wave_num);
      var_07 = int(250);
      if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
        var_06 scripts\cp\cp_persistence::give_player_xp(var_07, 1);
      }
    }

    if(isDefined(level.escape_objective_notify)) {
      level notify(level.escape_objective_notify);
    }

    if(!scripts\engine\utility::flag("first_door_opened")) {
      scripts\engine\utility::flag_set("first_door_opened");
    }

    if((isplayer(var_06) && var_06 scripts\cp\utility::is_valid_player()) || isDefined(param_00.allow_nonplayer_trigger)) {
      foreach(var_09 in var_01) {
        if(!isDefined(level.spawn_volume_array[var_09.script_area])) {
          continue;
        }

        if(level.spawn_volume_array[var_09.script_area].var_19) {
          if(isDefined(level.purchase_area_vo) && !isDefined(param_00.allow_nonplayer_trigger)) {
            level[[level.purchase_area_vo]](var_09.script_area, var_06);
          }
        }
      }
    }

    level thread[[level.interactions[var_01[0].script_noteworthy].activation_func]](var_01[0], var_06);
    foreach(var_09 in var_01) {
      scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_09);
      scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_09.script_area);
      wait(0.05);
    }

    break;
  }

  if(isDefined(param_00.target)) {
    var_0D = param_00.target;
    if(isDefined(param_00.var_336)) {
      var_0E = getEntArray(param_00.var_336, "targetname");
      foreach(var_10 in var_0E) {
        if(var_10.target == var_0D) {
          var_10 delete();
        }
      }
    }
  }
}

func_7E81(param_00) {
  return int(level.interactions[param_00].cost);
}

func_100F4() {
  self endon("disconnect");
  thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
  self forceusehinton(&"COOP_INTERACTIONS_NEED_MONEY");
  wait(1);
  self getrigindexfromarchetyperef();
}

init_team_killdoors() {
  level.team_killdoors = [];
  foreach(var_01 in getEntArray("team_killdoor", "targetname")) {
    var_02 = level.team_killdoors.size;
    var_03 = spawnStruct();
    var_03.name = var_02;
    var_03.trigger = var_01;
    if(isDefined(var_01.var_C1)) {
      var_03.base_kill_goal = var_01.var_C1;
    } else {
      var_03.base_kill_goal = 10;
    }

    var_03.kill_goal = var_03.base_kill_goal;
    var_03.goal_mult = 1;
    var_03.kill_captured = 0;
    var_03.players = [];
    var_03.var_E0E2 = 0;
    var_03.var_ED9A = "flag_" + var_02;
    scripts\engine\utility::flag_init(var_03.var_ED9A);
    var_03.var_4348 = undefined;
    var_03.physics_capsulecast = undefined;
    var_03.progress_meters = [];
    var_03.progress_meter_start_pos = undefined;
    foreach(var_05 in getEntArray(var_01.target, "targetname")) {
      var_05 setnonstick(1);
      if(issubstr(var_05.classname, "brushmodel")) {
        if(isDefined(var_05.script_noteworthy) && var_05.script_noteworthy == "progress") {
          var_05.start_pos = var_05.origin;
          var_03.progress_meters[var_03.progress_meters.size] = var_05;
        } else {
          var_03.var_4348 = var_05;
        }

        continue;
      }

      if(issubstr(var_05.classname, "scriptable")) {
        var_03.physics_capsulecast = var_05;
      }
    }

    var_03.activation_areas = [];
    if(isDefined(var_01.script_area)) {
      foreach(var_08 in strtok(var_01.script_area, ",")) {
        var_03.activation_areas[var_03.activation_areas.size] = var_08;
      }
    }

    level.team_killdoors[var_02] = var_03;
    var_03 thread team_killdoor_think();
    wait(0.05);
  }
}

team_killdoor_think() {
  level endon("open_killdoor_" + self.name);
  childthread team_killdoor_activate();
  for(;;) {
    scripts\engine\utility::flag_wait(self.var_ED9A);
    level waittill("zombie_killed", var_00, var_01, var_02, var_03);
    if(scripts\engine\utility::istrue(var_03.is_skeleton) && isDefined(var_03.playerowner)) {
      var_03 = var_03.playerowner;
    }

    if(!isent(var_03) || !var_03 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!var_03 istouching(self.trigger)) {
      continue;
    }

    thread capture_soul(var_00, var_03);
  }
}

team_killdoor_activate() {
  for(;;) {
    self.trigger waittill("trigger", var_00);
    if(!isplayer(var_00)) {
      continue;
    }

    scripts\engine\utility::flag_set(self.var_ED9A);
    self.physics_capsulecast setscriptablepartstate("fx", "active");
    team_killdoor_deactivate();
    scripts\engine\utility::flag_clear(self.var_ED9A);
    self.physics_capsulecast setscriptablepartstate("fx", "normal");
  }
}

team_killdoor_deactivate() {
  self endon("killdoor_deactivate");
  for(;;) {
    self.trigger waittill("trigger", var_00);
    if(isplayer(var_00)) {
      create_killdoor_hud(var_00);
      childthread killdoor_timeout();
      thread player_timeout(var_00);
    }
  }
}

create_killdoor_hud(param_00) {
  if(isDefined(param_00.killdoor_hud)) {
    return;
  }

  param_00.killdoor_hud = newclienthudelem(param_00);
  param_00.killdoor_hud.location = 0;
  param_00.killdoor_hud.foreground = 1;
  param_00.killdoor_hud.fontscale = 1;
  param_00.killdoor_hud.sort = 20;
  param_00.killdoor_hud.alpha = 1;
  param_00.killdoor_hud.y = 120;
  param_00.killdoor_hud.alignx = "center";
  param_00.killdoor_hud.horzalign = "center";
  param_00.killdoor_hud.color = (1, 0, 1);
  self.players = scripts\engine\utility::array_removeundefined(self.players);
  self.players[self.players.size] = param_00;
}

killdoor_timeout() {
  self notify("stop_killdoor_timeout");
  self endon("stop_killdoor_timeout");
  wait(1);
  self notify("killdoor_deactivate");
}

player_timeout(param_00) {
  param_00 endon("disconnect");
  param_00 notify("stop_player_killdoor_timeout");
  param_00 endon("stop_player_killdoor_timeout");
  wait(1);
  self.players = scripts\engine\utility::array_remove(self.players, param_00);
  param_00.killdoor_hud destroy();
}

capture_soul(param_00, param_01) {
  soul_to_door(param_00);
  if(self.var_E0E2) {
    return;
  }

  scripts\cp\zombies\zombie_analytics::log_purchasingforateamdoor(1, param_01, self.name, self.kill_goal, level.wave_num);
  foreach(param_01 in self.players) {
    if(isDefined(param_01)) {}
  }

  foreach(var_05 in self.progress_meters) {
    var_05 moveto(var_05.start_pos + (0, 0, 16 / self.kill_goal) * self.kill_captured, 0.1);
  }

  if(self.kill_captured >= self.kill_goal) {
    thread open_team_killdoor(param_01);
  }
}

soul_to_door(param_00) {
  var_01 = spawn("script_model", param_00);
  var_01 setModel("tag_origin_soultrail");
  var_02 = self.physics_capsulecast.origin + (0, 0, 50);
  for(;;) {
    var_03 = distance(param_00, var_02);
    var_04 = var_03 / 600;
    if(var_04 < 0.05) {
      var_04 = 0.05;
    }

    var_01 moveto(var_02, var_04);
    wait(0.05);
    if(!self.var_E0E2 && distancesquared(var_01.origin, var_02) > 256) {
      continue;
    } else {
      break;
    }
  }

  if(!self.var_E0E2) {
    self.kill_captured++;
  }

  var_01 delete();
}

open_team_killdoor(param_00) {
  level notify("open_killdoor_" + self.name);
  self.var_E0E2 = 1;
  foreach(param_00 in self.players) {
    if(isDefined(param_00.killdoor_hud)) {
      param_00.killdoor_hud destroy();
    }
  }

  foreach(var_04 in self.activation_areas) {
    scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_04);
  }

  if(isDefined(self.var_4348)) {
    self.var_4348 connectpaths();
    self.var_4348 notsolid();
  }

  foreach(var_07 in self.progress_meters) {
    var_07 delete();
  }

  thread open_team_killdoor_sfx(self.var_9A3E);
  self.physics_capsulecast setscriptablepartstate("fx", "normal");
  self.physics_capsulecast setscriptablepartstate("default", "hide");
  scripts\cp\zombies\zombie_analytics::func_AF7E(1, param_00, self.name, self.kill_goal, level.wave_num);
  param_00 scripts\cp\cp_merits::processmerit("mt_purchase_doors");
  param_00 notify("door_opened_notify");
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("door_kill_purchase", "disco_comment_vo");
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
      param_00 scripts\cp\cp_persistence::give_player_xp(250, 1);
      return;
    }

    return;
  }

  if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    param_00 scripts\cp\cp_persistence::give_player_xp(75, 1);
  }
}

open_team_killdoor_sfx(param_00) {
  wait(0.5);
  playsoundatpos(self.physics_capsulecast.origin, "zmb_clear_barricade");
  wait(0.5);
}

init_chi_doors() {
  foreach(var_01 in getEntArray("chi_door", "targetname")) {
    var_01 thread chi_door_think();
    wait(0.05);
  }
}

chi_door_think() {
  foreach(var_01 in getEntArray(self.target, "targetname")) {
    if(issubstr(var_01.classname, "scriptable")) {
      self.physics_capsulecast = var_01;
    }
  }

  var_03 = [];
  foreach(var_05 in level.current_interaction_structs) {
    if(!isDefined(var_05.target)) {
      continue;
    }

    if(var_05.target == self.target) {
      var_03[var_03.size] = var_05;
    }
  }

  if(var_03.size == 0) {
    return;
  }

  self sethintstring(level.interaction_hintstrings[self.script_noteworthy]);
  var_07 = func_7E81(var_03[0].script_noteworthy);
  if(isDefined(level.enter_area_hint)) {
    self sethintstringparams(level.enter_area_hint, var_07);
  } else {
    self sethintstringparams(&"CP_ZMB_INTERACTIONS_ENTER_THIS_AREA", var_07);
  }

  if(isDefined(level.door_properties_func)) {
    [[level.door_properties_func]](self);
  }

  for(;;) {
    self.physics_capsulecast waittill("damage", var_08, var_09, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11);
    if(!isDefined(level.open_sesame) || !level.open_sesame) {
      if(!var_09 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(issubstr(var_11, "fists_zm_")) {} else if(!issubstr(var_11, "shuriken")) {
        var_12 = ["door_chi_none_1", "door_chi_none", "door_chi_notenough"];
        var_09 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_12), "disco_comment_vo");
        continue;
      }

      var_09 scripts\cp\cp_merits::processmerit("mt_purchase_doors");
      var_09 notify("door_opened_notify");
      scripts\cp\zombies\zombie_analytics::func_AF7E(1, var_09, var_03[0].script_area, level.interactions[var_03[0].script_noteworthy].cost, level.wave_num);
      var_13 = int(250);
      if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
        var_09 scripts\cp\cp_persistence::give_player_xp(var_13, 1);
      }
    }

    if(isplayer(var_09) && var_09 scripts\cp\utility::is_valid_player()) {
      foreach(var_15 in var_03) {
        if(!isDefined(level.spawn_volume_array[var_15.script_area])) {
          continue;
        }

        if(level.spawn_volume_array[var_15.script_area].var_19) {
          if(isDefined(level.purchase_area_vo)) {
            level[[level.purchase_area_vo]](var_15.script_area, var_09, 1);
          }
        }
      }
    }

    level thread[[level.interactions[var_03[0].script_noteworthy].activation_func]](var_03[0], var_09);
    foreach(var_15 in var_03) {
      scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_15);
      scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_15.script_area);
      wait(0.05);
    }

    break;
  }

  if(isDefined(self.target)) {
    var_19 = self.target;
    if(isDefined(self.var_336)) {
      var_1A = getEntArray(self.var_336, "targetname");
      foreach(var_1C in var_1A) {
        if(var_1C.target == var_19) {
          var_1C delete();
        }
      }
    }
  }
}

show_purchase_deny_chi(param_00) {
  self endon("disconnect");
  var_01 = ["door_kill_notenough", "door_wooden_fail", "door_chi_notenough"];
  thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_01), "disco_comment_vo");
}