/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
  var_0 = cos(85);
  for(;;) {
    var_1 = getEntArray("door_buy", "targetname");
    var_2 = sortbydistance(var_1, self.origin);
    if(var_2.size > 0) {
      if(distancesquared(var_2[0].origin, self.origin) < 9216 && scripts\engine\utility::within_fov(self.origin, self.angles, var_2[0].origin, var_0)) {
        thread scripts\cp\cp_hud_message::tutorial_lookup_func("door_buy");
        self notify("saw_door_tutorial");
        wait(1);
      }
    }

    wait(0.1);
  }
}

init_door_buys() {
  var_0 = getEntArray("door_buy", "targetname");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.var_EEAA)) {
      var_2 setuserange(var_2.var_EEAA);
    }

    level thread func_95B5(var_2);
    wait(0.05);
  }

  level.door_trigs = var_0;
}

func_95B5(var_0) {
  var_0 sethintstring(level.interaction_hintstrings[var_0.script_noteworthy]);
  var_1 = [];
  foreach(var_3 in level.current_interaction_structs) {
    if(!isDefined(var_3.target)) {
      continue;
    }

    if(var_3.target == var_0.target) {
      var_1[var_1.size] = var_3;
    }
  }

  var_5 = func_7E81(var_1[0].script_noteworthy);
  if(isDefined(level.enter_area_hint)) {
    var_0 sethintstringparams(level.enter_area_hint, var_5);
  } else {
    var_0 sethintstringparams(&"CP_ZMB_INTERACTIONS_ENTER_THIS_AREA", var_5);
  }

  if(isDefined(level.door_properties_func)) {
    [[level.door_properties_func]](var_0);
  }

  for(;;) {
    var_0 waittill("trigger", var_6);
    if(isent(var_6) && !var_6 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isplayer(var_6)) {
      if(!var_6 scripts\cp\cp_interaction::can_purchase_interaction(var_1[0], level.interactions[var_1[0].script_noteworthy].cost, level.interactions[var_1[0].script_noteworthy].spend_type)) {
        level notify("interaction", "purchase_denied", level.interactions[var_1[0].script_noteworthy], var_6);
        var_6 func_100F4();
        continue;
      }

      var_0 notify("purchased");
      level notify("door_opened_notify");
      if(!scripts\engine\utility::flag("can_drop_coins")) {
        scripts\engine\utility::flag_set("can_drop_coins");
      }

      var_6 scripts\cp\cp_merits::processmerit("mt_purchase_doors");
      var_6 notify("door_opened_notify");
      var_6 scripts\cp\cp_persistence::take_player_currency(level.interactions[var_1[0].script_noteworthy].cost, 1, "door");
      scripts\cp\zombies\zombie_analytics::func_AF7E(1, var_6, var_1[0].script_area, level.interactions[var_1[0].script_noteworthy].cost, level.wave_num);
      var_7 = int(250);
      if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
        var_6 scripts\cp\cp_persistence::give_player_xp(var_7, 1);
      }
    }

    if(isDefined(level.escape_objective_notify)) {
      level notify(level.escape_objective_notify);
    }

    if(!scripts\engine\utility::flag("first_door_opened")) {
      scripts\engine\utility::flag_set("first_door_opened");
    }

    if((isplayer(var_6) && var_6 scripts\cp\utility::is_valid_player()) || isDefined(var_0.allow_nonplayer_trigger)) {
      foreach(var_9 in var_1) {
        if(!isDefined(level.spawn_volume_array[var_9.script_area])) {
          continue;
        }

        if(level.spawn_volume_array[var_9.script_area].var_19) {
          if(isDefined(level.purchase_area_vo) && !isDefined(var_0.allow_nonplayer_trigger)) {
            level[[level.purchase_area_vo]](var_9.script_area, var_6);
          }
        }
      }
    }

    level thread[[level.interactions[var_1[0].script_noteworthy].activation_func]](var_1[0], var_6);
    foreach(var_9 in var_1) {
      scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_9);
      scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_9.script_area);
      wait(0.05);
    }

    break;
  }

  if(isDefined(var_0.target)) {
    var_0D = var_0.target;
    if(isDefined(var_0.var_336)) {
      var_0E = getEntArray(var_0.var_336, "targetname");
      foreach(var_10 in var_0E) {
        if(var_10.target == var_0D) {
          var_10 delete();
        }
      }
    }
  }
}

func_7E81(var_0) {
  return int(level.interactions[var_0].cost);
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
  foreach(var_1 in getEntArray("team_killdoor", "targetname")) {
    var_2 = level.team_killdoors.size;
    var_3 = spawnStruct();
    var_3.name = var_2;
    var_3.trigger = var_1;
    if(isDefined(var_1.var_C1)) {
      var_3.base_kill_goal = var_1.var_C1;
    } else {
      var_3.base_kill_goal = 10;
    }

    var_3.kill_goal = var_3.base_kill_goal;
    var_3.goal_mult = 1;
    var_3.kill_captured = 0;
    var_3.players = [];
    var_3.var_E0E2 = 0;
    var_3.var_ED9A = "flag_" + var_2;
    scripts\engine\utility::flag_init(var_3.var_ED9A);
    var_3.var_4348 = undefined;
    var_3.physics_capsulecast = undefined;
    var_3.progress_meters = [];
    var_3.progress_meter_start_pos = undefined;
    foreach(var_5 in getEntArray(var_1.target, "targetname")) {
      var_5 setnonstick(1);
      if(issubstr(var_5.classname, "brushmodel")) {
        if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "progress") {
          var_5.start_pos = var_5.origin;
          var_3.progress_meters[var_3.progress_meters.size] = var_5;
        } else {
          var_3.var_4348 = var_5;
        }

        continue;
      }

      if(issubstr(var_5.classname, "scriptable")) {
        var_3.physics_capsulecast = var_5;
      }
    }

    var_3.activation_areas = [];
    if(isDefined(var_1.script_area)) {
      foreach(var_8 in strtok(var_1.script_area, ",")) {
        var_3.activation_areas[var_3.activation_areas.size] = var_8;
      }
    }

    level.team_killdoors[var_2] = var_3;
    var_3 thread team_killdoor_think();
    wait(0.05);
  }
}

team_killdoor_think() {
  level endon("open_killdoor_" + self.name);
  childthread team_killdoor_activate();
  for(;;) {
    scripts\engine\utility::flag_wait(self.var_ED9A);
    level waittill("zombie_killed", var_0, var_1, var_2, var_3);
    if(scripts\engine\utility::istrue(var_3.is_skeleton) && isDefined(var_3.playerowner)) {
      var_3 = var_3.playerowner;
    }

    if(!isent(var_3) || !var_3 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!var_3 istouching(self.trigger)) {
      continue;
    }

    thread capture_soul(var_0, var_3);
  }
}

team_killdoor_activate() {
  for(;;) {
    self.trigger waittill("trigger", var_0);
    if(!isplayer(var_0)) {
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
    self.trigger waittill("trigger", var_0);
    if(isplayer(var_0)) {
      create_killdoor_hud(var_0);
      childthread killdoor_timeout();
      thread player_timeout(var_0);
    }
  }
}

create_killdoor_hud(var_0) {
  if(isDefined(var_0.killdoor_hud)) {
    return;
  }

  var_0.killdoor_hud = newclienthudelem(var_0);
  var_0.killdoor_hud.location = 0;
  var_0.killdoor_hud.foreground = 1;
  var_0.killdoor_hud.fontscale = 1;
  var_0.killdoor_hud.sort = 20;
  var_0.killdoor_hud.alpha = 1;
  var_0.killdoor_hud.y = 120;
  var_0.killdoor_hud.alignx = "center";
  var_0.killdoor_hud.horzalign = "center";
  var_0.killdoor_hud.color = (1, 0, 1);
  self.players = scripts\engine\utility::array_removeundefined(self.players);
  self.players[self.players.size] = var_0;
}

killdoor_timeout() {
  self notify("stop_killdoor_timeout");
  self endon("stop_killdoor_timeout");
  wait(1);
  self notify("killdoor_deactivate");
}

player_timeout(var_0) {
  var_0 endon("disconnect");
  var_0 notify("stop_player_killdoor_timeout");
  var_0 endon("stop_player_killdoor_timeout");
  wait(1);
  self.players = scripts\engine\utility::array_remove(self.players, var_0);
  var_0.killdoor_hud destroy();
}

capture_soul(var_0, var_1) {
  soul_to_door(var_0);
  if(self.var_E0E2) {
    return;
  }

  scripts\cp\zombies\zombie_analytics::log_purchasingforateamdoor(1, var_1, self.name, self.kill_goal, level.wave_num);
  foreach(var_1 in self.players) {
    if(isDefined(var_1)) {}
  }

  foreach(var_5 in self.progress_meters) {
    var_5 moveto(var_5.start_pos + (0, 0, 16 / self.kill_goal) * self.kill_captured, 0.1);
  }

  if(self.kill_captured >= self.kill_goal) {
    thread open_team_killdoor(var_1);
  }
}

soul_to_door(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin_soultrail");
  var_2 = self.physics_capsulecast.origin + (0, 0, 50);
  for(;;) {
    var_3 = distance(var_0, var_2);
    var_4 = var_3 / 600;
    if(var_4 < 0.05) {
      var_4 = 0.05;
    }

    var_1 moveto(var_2, var_4);
    wait(0.05);
    if(!self.var_E0E2 && distancesquared(var_1.origin, var_2) > 256) {
      continue;
    } else {
      break;
    }
  }

  if(!self.var_E0E2) {
    self.kill_captured++;
  }

  var_1 delete();
}

open_team_killdoor(var_0) {
  level notify("open_killdoor_" + self.name);
  self.var_E0E2 = 1;
  foreach(var_0 in self.players) {
    if(isDefined(var_0.killdoor_hud)) {
      var_0.killdoor_hud destroy();
    }
  }

  foreach(var_4 in self.activation_areas) {
    scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_4);
  }

  if(isDefined(self.var_4348)) {
    self.var_4348 connectpaths();
    self.var_4348 notsolid();
  }

  foreach(var_7 in self.progress_meters) {
    var_7 delete();
  }

  thread open_team_killdoor_sfx(self.var_9A3E);
  self.physics_capsulecast setscriptablepartstate("fx", "normal");
  self.physics_capsulecast setscriptablepartstate("default", "hide");
  scripts\cp\zombies\zombie_analytics::func_AF7E(1, var_0, self.name, self.kill_goal, level.wave_num);
  var_0 scripts\cp\cp_merits::processmerit("mt_purchase_doors");
  var_0 notify("door_opened_notify");
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("door_kill_purchase", "disco_comment_vo");
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
      var_0 scripts\cp\cp_persistence::give_player_xp(250, 1);
      return;
    }

    return;
  }

  if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    var_0 scripts\cp\cp_persistence::give_player_xp(75, 1);
  }
}

open_team_killdoor_sfx(var_0) {
  wait(0.5);
  playsoundatpos(self.physics_capsulecast.origin, "zmb_clear_barricade");
  wait(0.5);
}

init_chi_doors() {
  foreach(var_1 in getEntArray("chi_door", "targetname")) {
    var_1 thread chi_door_think();
    wait(0.05);
  }
}

chi_door_think() {
  foreach(var_1 in getEntArray(self.target, "targetname")) {
    if(issubstr(var_1.classname, "scriptable")) {
      self.physics_capsulecast = var_1;
    }
  }

  var_3 = [];
  foreach(var_5 in level.current_interaction_structs) {
    if(!isDefined(var_5.target)) {
      continue;
    }

    if(var_5.target == self.target) {
      var_3[var_3.size] = var_5;
    }
  }

  if(var_3.size == 0) {
    return;
  }

  self sethintstring(level.interaction_hintstrings[self.script_noteworthy]);
  var_7 = func_7E81(var_3[0].script_noteworthy);
  if(isDefined(level.enter_area_hint)) {
    self sethintstringparams(level.enter_area_hint, var_7);
  } else {
    self sethintstringparams(&"CP_ZMB_INTERACTIONS_ENTER_THIS_AREA", var_7);
  }

  if(isDefined(level.door_properties_func)) {
    [[level.door_properties_func]](self);
  }

  for(;;) {
    self.physics_capsulecast waittill("damage", var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11);
    if(!isDefined(level.open_sesame) || !level.open_sesame) {
      if(!var_9 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(issubstr(var_11, "fists_zm_")) {} else if(!issubstr(var_11, "shuriken")) {
        var_12 = ["door_chi_none_1", "door_chi_none", "door_chi_notenough"];
        var_9 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_12), "disco_comment_vo");
        continue;
      }

      var_9 scripts\cp\cp_merits::processmerit("mt_purchase_doors");
      var_9 notify("door_opened_notify");
      scripts\cp\zombies\zombie_analytics::func_AF7E(1, var_9, var_3[0].script_area, level.interactions[var_3[0].script_noteworthy].cost, level.wave_num);
      var_13 = int(250);
      if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
        var_9 scripts\cp\cp_persistence::give_player_xp(var_13, 1);
      }
    }

    if(isplayer(var_9) && var_9 scripts\cp\utility::is_valid_player()) {
      foreach(var_15 in var_3) {
        if(!isDefined(level.spawn_volume_array[var_15.script_area])) {
          continue;
        }

        if(level.spawn_volume_array[var_15.script_area].var_19) {
          if(isDefined(level.purchase_area_vo)) {
            level[[level.purchase_area_vo]](var_15.script_area, var_9, 1);
          }
        }
      }
    }

    level thread[[level.interactions[var_3[0].script_noteworthy].activation_func]](var_3[0], var_9);
    foreach(var_15 in var_3) {
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

show_purchase_deny_chi(var_0) {
  self endon("disconnect");
  var_1 = ["door_kill_notenough", "door_wooden_fail", "door_chi_notenough"];
  thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_1), "disco_comment_vo");
}