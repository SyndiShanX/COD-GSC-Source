/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_dog_control.gsc
*****************************************************/

#using_animtree("dog");

init_dog_control() {
  precachestring(&"SCRIPT_DOG_NOTARGET");
  precachestring(&"SCRIPT_DOG_NOTREADY");
  createthreatbiasgroup("dog");
  createthreatbiasgroup("dog_targets");
  setignoremegroup("dog_targets", "allies");
  level.scr_anim["dog"]["dog_bark"] = % iw6_dog_attackidle_bark;
  common_scripts\utility::flag_init("enable_dog_pip");
}

enable_dog_control(var_0) {
  var_0.animname = "dog";

  if(!var_0 maps\_utility::ent_flag_exist("dog_no_teleport")) {
    var_0 maps\_utility::ent_flag_init("dog_no_teleport");
  }

  if(!var_0 maps\_utility::ent_flag_exist("dog_cooldown")) {
    var_0 maps\_utility::ent_flag_init("dog_cooldown");
  }

  if(!var_0 maps\_utility::ent_flag_exist("running_dog_command")) {
    var_0 maps\_utility::ent_flag_init("running_dog_command");
  }

  if(!var_0 maps\_utility::ent_flag_exist("pause_dog_command")) {
    var_0 maps\_utility::ent_flag_init("pause_dog_command");
  }

  if(!var_0 maps\_utility::ent_flag_exist("cancel_command_disabled")) {
    var_0 maps\_utility::ent_flag_init("cancel_command_disabled");
  }

  self.controlled_dog = var_0;
  var_0.player_controller = self;
  childthread give_laser();
  childthread listen_for_dog_commands(var_0);

  if(!isDefined(self.notargethudelem)) {
    self.notargethudelem = maps\_hud_util::createclientfontstring("default", 1.1);
    self.notargethudelem maps\_hud_util::setpoint("CENTER", "CENTER", 0, -15, 0);
    self.notargethudelem settext("No Target");
    self.notargethudelem.alpha = 0;
  }

  self takeweapon("flash_grenade");
  self.controlled_dog.dog_marker = common_scripts\utility::spawn_tag_origin();
  setdvar("ui_dog_grenade", 1);
  thread ui_dog_grenade_logic();

  if(level.xb3) {
    maps\_dog_kinect::speechcommands();
  }
}

disable_dog_control() {
  self notify("disable_dog_control");
  self.controlled_dog = undefined;
  self.controlled_dog.dog_marker delete();
  self enableoffhandweapons();
  setdvar("ui_dog_grenade", 0);
}

listen_for_dog_commands(var_0) {
  self endon("death");
  var_0 endon("death");
  self endon("disable_dog_control");

  for(;;) {
    self waittill("issue_dog_command", var_1, var_2, var_3);

    if(var_0 maps\_utility::ent_flag("pause_dog_command")) {
      continue;
    }
    if(var_0 maps\_utility::ent_flag("dog_cooldown") || isDefined(var_0.in_melee) && var_0.in_melee) {
      thread display_no_target(&"SCRIPT_DOG_NOTREADY", 2);
      continue;
    }

    if(isDefined(var_0.animnode)) {
      var_0 stopanimscripted();
      var_0.animnode notify("stop_loop");
    }

    var_0 thread run_dog_command(var_1, var_2, var_3);
  }
}

isneargrenade() {
  var_0 = getEntArray("grenade", "classname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(var_2.model == "weapon_claymore") {
      continue;
    }
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(distancesquared(var_2.origin, var_4.origin) < 36864) {
        return 1;
      }
    }
  }

  return 0;
}

give_laser() {
  level.see_enemy_dot = 0.985;
  level.see_enemy_dot_close = 0.99;
  self endon("disable_dog_control");
  self endon("remove_laser");
  self.lastusedweapon = undefined;
  self notifyonplayercommand("fired_laser", "+smoke");
  childthread laser_designate_target();
  childthread listen_for_cancel();
}

laser_designate_target() {
  for(;;) {
    self waittill("fired_laser");
    var_0 = get_laser_designated_trace();
    var_1 = undefined;
    var_2 = getaiarray("axis");
    var_3 = [];
    var_4 = self;
    var_5 = var_4 get_eye();

    if(isDefined(var_0["entity"]) && isai(var_0["entity"])) {
      if(isalive(var_0["entity"]) && var_0["entity"].team != "allies" && var_0["entity"].type != "dog") {
        var_1 = var_0["entity"];
      }
    }

    if(!isDefined(var_1)) {
      var_6 = level.see_enemy_dot_close;

      foreach(var_8 in var_2) {
        if(var_8.type == "dog") {
          continue;
        }
        var_9 = var_8 gettagorigin("J_SpineUpper");
        var_10 = vectortoangles(var_9 - var_5);
        var_11 = anglesToForward(var_10);
        var_12 = var_4 getplayerangles();
        var_13 = anglesToForward(var_12);
        var_14 = vectordot(var_11, var_13);

        if(var_14 > var_6) {
          var_3 = common_scripts\utility::array_add(var_3, var_8);
        }
      }

      if(var_3.size > 0) {
        var_3 = sortbydistance(var_3, var_5);

        foreach(var_8 in var_3) {
          if(test_trace(var_8 getEye(), var_5, var_4.controlled_dog)) {
            var_1 = var_8;
            break;
          }
        }
      }
    }

    if(!isDefined(var_1)) {
      var_6 = level.see_enemy_dot;

      foreach(var_8 in var_2) {
        if(var_8.type == "dog") {
          continue;
        }
        var_9 = var_8 gettagorigin("J_SpineUpper");
        var_10 = vectortoangles(var_9 - var_5);
        var_11 = anglesToForward(var_10);
        var_12 = var_4 getplayerangles();
        var_13 = anglesToForward(var_12);
        var_14 = vectordot(var_11, var_13);

        if(var_14 > var_6 && test_trace(var_8 getEye(), var_5, var_4.controlled_dog)) {
          var_1 = var_8;
          var_6 = var_14;
        }
      }
    }

    self notify("issue_dog_command", var_0, undefined, var_1);

    if(isDefined(var_1)) {
      wait 2;
    }
  }
}

test_trace(var_0, var_1, var_2) {
  var_3 = bulletTrace(var_0, var_1, 0, var_2);
  return var_3["fraction"] == 1;
}

listen_for_cancel() {
  for(;;) {
    self waittill("cancel_command");

    if(!self.controlled_dog maps\_utility::ent_flag("cancel_command_disabled")) {
      var_0 = get_laser_designated_trace();
      self notify("issue_dog_command", var_0, self);
    }

    wait 0.1;
  }
}

get_laser_designated_trace() {
  var_0 = get_eye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_0 = var_0 + var_2 * 20;
  var_3 = var_0 + var_2 * 7000;
  var_4 = bulletTrace(var_0, var_3, 1, self.controlled_dog);
  var_5 = var_4["entity"];

  if(isDefined(var_5)) {
    var_4["position"] = var_5.origin;
  }

  return var_4;
}

run_dog_command(var_0, var_1, var_2) {
  self endon("death");

  if(var_0["fraction"] >= 0.98 && !isDefined(var_1)) {
    if(!maps\_utility::ent_flag("running_dog_command")) {
      self.player_controller thread display_no_target(&"SCRIPT_DOG_NOTARGET", 1.75);
    }

    return;
  }

  var_3 = var_0["position"];

  if(isDefined(var_2)) {
    var_4 = var_2;
  } else {
    var_4 = enemy_near_position(var_0["position"]);
  }

  var_5 = get_flush_volume(var_3);

  if(!isDefined(var_2) && !isDefined(var_1) && !isDefined(var_5)) {
    if(!maps\_utility::ent_flag("running_dog_command")) {
      self.player_controller thread display_no_target(&"SCRIPT_DOG_NOTARGET", 1.75);
    }

    return;
  }

  self notify("new_dog_command");
  self hudoutlinedisable();
  self endon("new_dog_command");
  maps\_utility::ent_flag_set("running_dog_command");
  var_6 = isDefined(self.script_forcecolor) || isDefined(self.script_old_forcecolor);

  if(var_6 && isDefined(self.script_forcecolor)) {
    self.script_old_forcecolor = self.script_forcecolor;
  }

  if(isDefined(self.current_follow_path)) {
    self.old_path = self.current_follow_path;
    self notify("stop_path");
  }

  if(isDefined(self.doghandler)) {
    self.oldhandler = self.doghandler;
    self setdoghandler();
  }

  maps\_utility::disable_ai_color();
  self.dog_marker unlink();
  self.dog_marker.origin = var_3;
  self.dog_marker.angles = vectortoangles(var_0["normal"]);

  if(!isDefined(self.dc_old_moveplaybackrate)) {
    self.dc_old_moveplaybackrate = self.moveplaybackrate;
  }

  self.moveplaybackrate = 1;

  if(self.a.movement == "walk") {
    self.was_walking = 1;
    maps\_utility::clear_run_anim();
  }

  if(isDefined(var_1)) {
    dog_command_cancel(var_1);
  } else if(isDefined(var_5)) {
    dog_command_flush(var_5, var_0);
  } else if(isDefined(var_4)) {
    self.script_nostairs = 1;
    maps\_utility::set_hudoutline("friendly", 0);
    self.moveplaybackrate = 1;
    maps\_utility::enable_sprint();
    var_7 = dog_command_attack(var_4);

    if(isDefined(var_7) && var_7 == "attack") {
      if(isalive(var_4)) {
        if(isDefined(self.in_melee) && self.in_melee) {
          var_4 waittill("death");
        }
      }
    } else {
      wait 0.5;

      if(!isDefined(self.in_melee) || !self.in_melee) {
        self clearenemy();
      }
    }

    if(isDefined(self.old_ai_target)) {
      self.old_ai_target hudoutlinedisable();
      self.favoriteenemy = undefined;
    }

    maps\_utility::disable_sprint();
    self hudoutlinedisable();
  } else
    dog_command_goto(var_0);

  self.script_nostairs = undefined;
  self hudoutlinedisable();

  if(isDefined(self.oldhandler)) {
    self setdoghandler(self.oldhandler);
    self setgoalentity(self.oldhandler);
  } else if(var_6 && isDefined(self.script_old_forcecolor)) {
    var_8 = undefined;

    if(isDefined(self.script_color_delay_override)) {
      var_8 = self.script_color_delay_override;
      self.script_color_delay_override = undefined;
    }

    maps\_utility::enable_ai_color();
    self.script_old_forcecolor = undefined;
    self.old_path = undefined;

    if(isDefined(var_8)) {
      self.script_color_delay_override = var_8;
    }
  } else if(isDefined(self.old_path)) {
    thread maps\_utility::follow_path_and_animate(self.old_path);
    self.old_path = undefined;
  }

  if(isDefined(self.dc_old_moveplaybackrate)) {
    common_scripts\utility::waittill_notify_or_timeout("goal", 5);

    if(isDefined(self.dc_old_moveplaybackrate)) {
      self.moveplaybackrate = self.dc_old_moveplaybackrate;
      self.dc_old_moveplaybackrate = undefined;
    }
  }

  if(isDefined(self.was_walking) && self.was_walking) {
    self.was_walking = undefined;
    maps\_utility::set_dog_walk_anim();
  }

  self.oldhandler = undefined;
  maps\_utility::ent_flag_clear("running_dog_command");
  self notify("dog_command_complete");
}

dog_command_flush(var_0, var_1) {
  self endon("new_dog_command");
  var_2 = var_1["position"];
  wait 0.05;
  playFXOnTag(common_scripts\utility::getfx("target_marker_yellow"), self.dog_marker, "tag_origin");
  thread maps\_utility::play_sound_on_entity("anml_dog_bark");
  var_3 = level.dog_flush_functions[var_0.script_noteworthy];
  self childthread[[var_3]](var_0, var_1);
  level waittill("dog_flush_started");
  var_0.done_flushing = 1;
  level waittill("dog_flush_done");
}

dog_command_cancel(var_0) {
  if(isDefined(self.favoriteenemy)) {
    if(isDefined(self.favoriteenemy.oldignoreme)) {
      self.favoriteenemy.ignoreme = self.favoriteenemy.oldignoreme;
    }

    self.favoriteenemy = undefined;
  }

  if(isDefined(self.old_moveplaybackrate)) {
    self.moveplaybackrate = self.old_moveplaybackrate;
    self.old_moveplaybackrate = undefined;
  }
}

dog_command_attack(var_0) {
  self endon("damage");
  self endon("cancel_dog_attack");
  self notify("dog_command_attack", var_0);
  self.dog_marker linkto(var_0, "tag_origin", (0, 0, 0), (-90, 0, -90));
  wait 0.05;

  if(!isalive(var_0)) {
    return "bail";
  }

  self.script_nostairs = 1;

  if(isDefined(self.old_ai_target) && self.old_ai_target != var_0) {
    self.old_ai_target hudoutlinedisable();
  }

  var_0 thread hud_outlineenable();

  if(isDefined(var_0.dog_attack_alt_func)) {
    self[[var_0.dog_attack_alt_func]](var_0);
  } else {
    self.old_ai_target = var_0;
    var_0.old_ignoreme = var_0.ignoreme;
    var_0.ignoreme = 0;
    var_0 setthreatbiasgroup("dog_targets");
    var_0 thread maps\_utility::set_battlechatter(0);
    self.favoriteenemy = var_0;

    if(common_scripts\utility::flag_exist("_stealth_spotted") && !common_scripts\utility::flag("_stealth_spotted")) {
      thread maps\_utility::play_sound_on_entity("anml_dog_growl");
    } else {
      thread maps\_utility::play_sound_on_entity("anml_dog_bark_attack_start_npc");
    }

    self setgoalentity(var_0, 50);
    thread temporary_disable_pain();
    thread dog_attack_damage_tracking();

    if(!maps\_utility::ent_flag("dog_no_teleport")) {
      var_1 = self gettagorigin("spine2_jnt");

      if(!maps\_utility::player_looking_at(var_1, 0.5, 1)) {
        var_2 = var_0 gettagorigin("J_SpineUpper");
        var_3 = level.player getEye();
        var_4 = distance(var_1, var_2);
        var_5 = distance(var_3, var_2);

        if(var_4 > var_5) {
          var_6 = getnodesinradius(var_3, 128, 32, 128, "Path");

          foreach(var_8 in var_6) {
            if(!maps\_utility::player_looking_at(var_8.origin, 0.5, 1)) {
              if(test_trace(var_3, var_8.origin, level.player)) {
                var_9 = var_2 - var_1;
                var_9 = (var_9[0], var_9[1], 0);
                var_10 = vectortoangles(var_9);
                self forceteleport(var_8.origin, var_10);
                break;
              }
            }
          }
        }
      }
    }

    self.player_controller notify("displaying_no_target");
    self.player_controller notify("clear_no_target");
    self.player_controller.notargethudelem.alpha = 0;
    var_12 = dog_waitfor_attack_or_bail(var_0);

    if(isDefined(var_12)) {
      self notify("stop_disable_pain");
    }

    self notify("dog_attack_damage_tracking");

    if(!isDefined(var_12) || var_12 == "bail") {
      return "bail";
    }
  }
}

dog_waitfor_attack_or_bail(var_0) {
  var_0 endon("death");

  if(isDefined(self.in_melee) && self.in_melee) {
    if(isDefined(self.enemy) && self.enemy == var_0) {
      return "dog_attacks_ai";
    }

    return "bail";
  }

  level waittill("dog_attacks_ai", var_1, var_2, var_3);

  if(var_2 == var_0) {
    return "dog_attacks_ai";
  }

  return "bail";
}

temporary_disable_pain() {
  self endon("stop_disable_pain");
  self notify("temporary_disable_pain");
  self endon("temporary_disable_pain");
  self setCanDamage(0);
  wait 2;

  if(!isDefined(self.in_melee) || self.in_melee == 0) {
    self setCanDamage(1);
  }
}

dog_attack_damage_tracking() {
  self notify("dog_attack_damage_tracking");
  self endon("dog_attack_damage_tracking");
  common_scripts\utility::waittill_either("damage", "cancel_dog_attack");

  if(!isDefined(self.in_melee) || !self.in_melee) {
    thread dog_got_hit();
  }
}

dog_got_hit() {
  self notify("dog_got_hit");
  self endon("dog_got_hit");
  maps\_utility::disable_pain();
  maps\_utility::ent_flag_set("dog_cooldown");
  var_0 = self.ignoreall;
  self.ignoreall = 0;
  self clearenemy();
  wait 8;
  self.ignoreall = var_0;
  maps\_utility::enable_pain();
  maps\_utility::ent_flag_clear("dog_cooldown");
}

ai_remove_outline_waiter(var_0) {
  self endon("death");
  self endon("dog_attacks_ai");
  var_0 waittill("new_dog_command");
  self hudoutlinedisable();
}

dog_command_goto(var_0) {
  var_1 = var_0["position"];
  wait 0.05;
  playFXOnTag(common_scripts\utility::getfx("target_marker_yellow"), self.dog_marker, "tag_origin");
  thread maps\_utility::play_sound_on_entity("anml_dog_bark");
  self setgoalpos(var_1);
  common_scripts\utility::waittill_notify_or_timeout("goal", 0.2);

  if(isDefined(self.pathgoalpos)) {
    self waittill("goal");
  } else if(distance2d(self.origin, var_1) > self.goalradius) {
    var_2 = getnodesinradius(var_1, 96, 0, 96);
    var_2 = sortbydistance(var_2, level.player get_eye());

    if(var_2.size > 0) {
      var_3 = var_2[0];
      self setgoalpos(var_3.origin);
      self waittill("goal");
    }
  }

  wait(randomfloatrange(1, 3));
}

enemy_near_position(var_0) {
  var_1 = getaiarray("axis");

  if(var_1.size > 0) {
    var_1 = sortbydistance(var_1, var_0);

    if(distance(var_1[0].origin, var_0) < 196) {
      return var_1[0];
    }
  }

  return undefined;
}

get_flush_volume(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0;
  var_2 = getEntArray("dog_flush_volume", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy) && (!isDefined(var_4.done_flushing) || var_4.done_flushing == 0)) {
      if(var_1 istouching(var_4)) {
        var_1 delete();
        return var_4;
      }
    }
  }

  var_1 delete();
  return undefined;
}

chopper_air_support_activate() {
  level endon("air_support_canceled");
  level endon("air_support_called");
  level.chopperattackarrow = spawn("script_model", (0, 0, 0));
  level.chopperattackarrow setModel("tag_origin");
  level.chopperattackarrow.angles = (-90, 0, 0);
  level.chopperattackarrow.offset = 4;
  level.playeractivatedairsupport = 1;
  var_0 = undefined;
  var_1 = 15;
  var_2 = 15000;
  var_3 = 90000;
  var_4 = [];
  var_4[0] = spawnStruct();
  var_4[0].offsetdir = "vertical";
  var_4[0].offsetdist = var_1;
  var_4[1] = spawnStruct();
  var_4[1].offsetdir = "vertical";
  var_4[1].offsetdist = var_1 * -1;
  var_4[2] = spawnStruct();
  var_4[2].offsetdir = "horizontal";
  var_4[2].offsetdist = var_1;
  var_4[3] = spawnStruct();
  var_4[3].offsetdir = "horizontal";
  var_4[3].offsetdist = var_1 * -1;
  var_5 = 0;

  for(;;) {
    wait 0.05;
    var_6 = level.player getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = level.player get_eye();

    for(var_9 = 0; var_9 < var_4.size; var_9++) {
      var_10 = var_8;
      var_11 = undefined;

      if(var_4[var_9].offsetdir == "vertical") {
        var_11 = anglestoup(var_6);
      } else if(var_4[var_9].offsetdir == "horizontal") {
        var_11 = anglestoright(var_6);
      }

      var_10 = var_10 + var_11 * var_4[var_9].offsetdist;
      var_4[var_9].trace = bulletTrace(var_10, var_10 + var_7 * var_2, 0, undefined);
      var_4[var_9].length = distancesquared(var_10, var_4[var_9].trace["position"]);

      if(getdvar("village_assault_debug_marker") == "1") {
        thread common_scripts\utility::draw_line_for_time(var_10, var_4[var_9].trace["position"], 1, 1, 1, 0.05);
      }
    }

    var_12 = [];
    var_13 = [];

    for(var_9 = 0; var_9 < var_4.size; var_9++) {
      if(var_4[var_9].length < var_3) {
        continue;
      }
      var_14 = var_12.size;
      var_12[var_14] = var_4[var_9].trace["position"];
      var_13[var_14] = var_4[var_9].trace["normal"];

      if(getdvar("village_assault_debug_marker") == "1") {
        thread common_scripts\utility::draw_line_for_time(level.player get_eye(), var_12[var_14], 0, 1, 0, 0.05);
      }
    }

    if(var_12.size == 0) {
      for(var_9 = 0; var_9 < var_4.size; var_9++) {
        var_12[var_9] = var_4[var_9].trace["position"];
        var_13[var_9] = var_4[var_9].trace["normal"];
      }
    }

    if(var_12.size == 4) {
      var_15 = findaveragepointvec(var_12[0], var_12[1], var_12[2], var_12[3]);
      var_16 = findaveragepointvec(var_13[0], var_13[1], var_13[2], var_13[3]);
    } else if(var_12.size == 3) {
      var_15 = findaveragepointvec(var_12[0], var_12[1], var_12[2]);
      var_16 = findaveragepointvec(var_13[0], var_13[1], var_13[2]);
    } else if(var_12.size == 2) {
      var_15 = findaveragepointvec(var_12[0], var_12[1]);
      var_16 = findaveragepointvec(var_13[0], var_13[1]);
    } else {
      var_15 = var_12[0];
      var_16 = var_13[0];
    }

    if(getdvar("village_assault_debug_marker") == "1") {
      thread common_scripts\utility::draw_line_for_time(level.player get_eye(), var_15, 1, 0, 0, 0.05);
    }

    thread drawchopperattackarrow(var_15, var_16, var_5);
    var_5 = 0.2;
  }
}

findaveragepointvec(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_4 = findaveragepoint(var_0[0], var_1[0], var_2[0], var_3[0]);
    var_5 = findaveragepoint(var_0[1], var_1[1], var_2[1], var_3[1]);
    var_6 = findaveragepoint(var_0[2], var_1[2], var_2[2], var_3[2]);
  } else if(isDefined(var_2)) {
    var_4 = findaveragepoint(var_0[0], var_1[0], var_2[0]);
    var_5 = findaveragepoint(var_0[1], var_1[1], var_2[1]);
    var_6 = findaveragepoint(var_0[2], var_1[2], var_2[2]);
  } else {
    var_4 = findaveragepoint(var_0[0], var_1[0]);
    var_5 = findaveragepoint(var_0[1], var_1[1]);
    var_6 = findaveragepoint(var_0[2], var_1[2]);
  }

  return (var_4, var_5, var_6);
}

findaveragepoint(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    return (var_0 + var_1 + var_2 + var_3) / 4;
  } else if(isDefined(var_2)) {
    return (var_0 + var_1 + var_2) / 3;
  } else {
    return (var_0 + var_1) / 2;
  }
}

drawchopperattackarrow(var_0, var_1, var_2) {
  var_0 = var_0 + var_1 * level.chopperattackarrow.offset;
  level.chopperattackarrow.origin = var_0;

  if(var_2 > 0) {
    level.chopperattackarrow rotateto(vectortoangles(var_1), 0.2);
  } else {
    level.chopperattackarrow.angles = vectortoangles(var_1);
  }
}

get_eye() {
  if(isDefined(self.controlled_dog.controlling_dog) && self.controlled_dog.controlling_dog) {
    var_0 = self.controlled_dog gettagorigin("TAG_CAMERA");
    return var_0;
  } else
    return self getEye();
}

hud_outlineenable() {
  if(!isDefined(self)) {
    return;
  }
  self notify("outline_enable");
  self endon("outline_enable");
  thread hudoutline_blink();
  thread hudoutline_wait_death();
  self endon("death");
  self waittill("dog_attacks_ai");
  wait 0.1;
  maps\_utility::set_hudoutline("enemy", 0);
  wait 5;

  if(isDefined(self)) {
    self.no_more_outlines = 1;
    self hudoutlinedisable();
  }
}

hudoutline_blink() {
  self endon("outline_enable");
  self endon("dog_attacks_ai");
  self endon("death");
  maps\_utility::set_hudoutline("enemy", 0);
  wait 0.8;
  self hudoutlinedisable();
  wait 0.1;

  for(var_0 = 0; var_0 < 3; var_0++) {
    maps\_utility::set_hudoutline("enemy", 0);
    wait 0.1;
    self hudoutlinedisable();
    wait 0.1;
  }

  self hudoutlinedisable();
}

hudoutline_wait_death() {
  self endon("outline_enable");
  self waittill("death");
  wait 2.5;

  if(isDefined(self)) {
    self.no_more_outlines = 1;
    self hudoutlinedisable();
  }

  var_0 = getcorpsearray();

  foreach(var_2 in var_0) {
    var_2 hudoutlinedisable();
  }
}

display_no_target(var_0, var_1) {
  self notify("displaying_no_target");
  self endon("displaying_no_target");
  self.notargethudelem settext(var_0);
  self.notargethudelem fadeovertime(0.1);
  self.notargethudelem.alpha = 0.5;
  wait 0.1;
  thread notargethudelem_pulse();
  wait(var_1);
  self notify("clear_no_target");
  self.notargethudelem fadeovertime(0.25);
  self.notargethudelem.alpha = 0.0;
}

notargethudelem_pulse() {
  self endon("displaying_no_target");
  self endon("clear_no_target");

  for(;;) {
    self.notargethudelem fadeovertime(0.2);
    self.notargethudelem.alpha = 0.7;
    wait 0.2;
    self.notargethudelem fadeovertime(0.2);
    self.notargethudelem.alpha = 0.5;
    wait 0.2;
  }
}

ui_dog_grenade_logic() {
  self.controlled_dog endon("death");

  for(;;) {
    self.controlled_dog maps\_utility::ent_flag_wait_either("pause_dog_command", "dog_cooldown");
    setdvar("ui_dog_grenade", 0);
    self.controlled_dog maps\_utility::ent_flag_waitopen("pause_dog_command");
    self.controlled_dog maps\_utility::ent_flag_waitopen("dog_cooldown");
    setdvar("ui_dog_grenade", 1);
  }
}