/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_apache_player_targeting.gsc
********************************************************/

_precache() {
  precacheshader("apache_friendly_ai_diamond_s_w");
  precacheshader("apache_target_vehicle");
  precacheshader("apache_enemy_ai_target_s_w");
  precacheshader("apache_friendly_vehicle_diamond_s_w");
  precacheshader("apache_enemy_vehicle_target_empty");
  precacheshader("apache_enemy_vehicle_target_offscreen");
  precacheshader("apache_friendly_vehicle_target_offscreen");
}

_init(var_0) {
  var_1 = spawnStruct();
  var_1.owner = var_0;
  var_1.type = "targeting";
  return var_1;
}

hud_color_ally() {
  return (0.3, 0.3, 0.3);
}

hud_set_target_locked(var_0) {
  if(var_0 maps\_vehicle::isvehicle()) {
    target_setdelay(var_0, 0.0, 1, 1, 0.0);
    target_setminsize(var_0, 32, 0);
  }
}

hud_set_target_default(var_0) {
  if(var_0 maps\_vehicle::isvehicle()) {
    target_setdelay(var_0, 0.6, 10, 25, randomfloatrange(1.25, 2.75));
    target_setminsize(var_0, 16, common_scripts\utility::ter_op(isDefined(var_0.hud_player_target_hide_at_min), var_0.hud_player_target_hide_at_min, 1));
  }
}

hud_addtargets(var_0, var_1) {
  if(!isDefined(var_0) || !isarray(var_0)) {
    return;
  }
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, 0.0);
  var_2 = "apache_friendly_ai_diamond_s_w";
  var_3 = undefined;
  var_4 = undefined;
  var_5 = (0, 0, 0);
  var_6 = "both";
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = -1;
  var_11 = -1;
  var_12 = 1;
  var_13 = 1;
  var_14 = 0;
  var_15 = undefined;
  var_16 = -1;
  var_17 = undefined;

  foreach(var_19 in var_0) {
    if(target_istarget(var_19)) {
      target_remove(var_19);
    }

    if(!isDefined(var_19) || isDefined(var_19.shader) || target_getarray().size >= 64) {
      continue;
    }
    if(ismissile(var_19)) {
      var_2 = "apache_enemy_vehicle_target_empty";
      var_7 = 1;
      var_9 = 1;
      var_14 = 1;
      var_16 = 60;
    } else if(isai(var_19) || isscriptmodel(var_19)) {
      if(var_19 onteam("allies")) {
        var_2 = "apache_enemy_vehicle_target_empty";
        var_7 = 1;
        var_5 = (0, 0, 32);
        var_9 = 1;
        var_14 = 1;
        var_16 = 45;
        var_15 = hud_color_ally();
      } else {
        var_2 = "apache_enemy_vehicle_target_empty";
        var_6 = "enhanced";
        var_5 = (0, 0, 32);
        var_9 = 1;
        var_14 = 1;
        var_11 = 24;
      }
    } else if(var_19 maps\_vehicle::isvehicle()) {
      var_6 = "enhanced";
      var_2 = "apache_enemy_vehicle_target_empty";
      var_14 = 1;
      var_9 = 1;
      var_8 = 0;
      var_15 = undefined;
      var_5 = (0, 0, 64);
      var_11 = 64;
      var_16 = 150;
      var_17 = 0.6;

      if(var_19 onteam("allies")) {
        var_2 = "apache_enemy_vehicle_target_empty";
        var_3 = "apache_friendly_vehicle_target_offscreen";
        var_7 = 1;
        var_9 = 1;
        var_14 = 1;
        var_15 = hud_color_ally();

        if(issubstr(var_19.classname, "apache")) {
          var_5 = (0, 0, -72);
          var_16 = 100;
        }
      } else {
        var_3 = "apache_enemy_vehicle_target_offscreen";

        if(issubstr(var_19.classname, "hind")) {
          var_5 = (0, 0, -72);
          var_12 = isDefined(var_19.script_parameters) && issubstr(var_19.script_parameters, "target_hide_at_min");
        }
      }
    } else {
      var_2 = "apache_friendly_ai_diamond_s_w";
      var_5 = (0, 0, 32);
    }

    var_20 = spawnStruct();
    var_20.active_mode = var_6;
    var_20.active = var_7;
    var_20.offscreen_shader = var_3;
    var_20.offscreen_shader_blink = var_4;

    if(var_13) {
      if(!target_alloc_limit_fail_passed(var_19, var_5)) {
        return;
      }
      target_setshader(var_19, var_2);
      target_setscaledrendermode(var_19, 0);

      if(var_9) {
        target_drawsingle(var_19);
      }

      if(var_14) {
        target_drawsquare(var_19, var_16);
      }

      if(var_8) {
        target_drawcornersonly(var_19, 1);
      }

      if(isDefined(var_15)) {
        target_setcolor(var_19, var_15);
      }

      if(isDefined(var_17)) {
        target_setdelay(var_19, var_17, 10, 25, randomfloatrange(1.25, 2.75));
      }

      target_setmaxsize(var_19, var_11);
      target_setminsize(var_19, var_10, var_12);
      target_flush(var_19);

      if(!var_12) {
        var_19.hud_player_target_hide_at_min = var_12;
      }
    } else {
      target_set(var_19, var_5);
      target_setshader(var_19, var_2);
    }

    if(isDefined(var_3)) {
      target_setoffscreenshader(var_19, var_3);
    }

    var_20.visibleto = [];

    foreach(var_22 in level.players) {
      var_20.visibleto[var_22 getentitynumber()] = undefined;
    }

    if(!isDefined(var_20.weapon)) {
      var_20.weapon = [];
    }

    var_20.weapon["lockOn_missile"] = spawnStruct();
    var_20.weapon["lockOn_missile"].islockedon = [];
    var_19._target = var_20;
    thread hud_target_ondeath(var_19);

    if(var_1 > 0) {
      wait(var_1);
    }
  }
}

ismissile(var_0) {
  if(isDefined(var_0) && isDefined(var_0.classname) && issubstr(var_0.classname, "rocket")) {
    return 1;
  }

  return 0;
}

isscriptmodel(var_0) {
  if(isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "script_model") {
    return 1;
  }

  return 0;
}

hud_showtargets(var_0) {
  var_1 = self.owner;

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && target_istarget(var_3)) {
      var_4 = var_3._target;
      var_4.visibleto[var_1 getentitynumber()] = 1;
      var_3 thread hud_outlineenable();
    }
  }
}

hud_outlineenable() {
  if(isDefined(self.team) && self.team == "allies" || isDefined(self.script_team) && self.script_team == "allies") {
    if(!isai(self)) {
      thread hud_outline_enable_withinview("friendly", cos(20));
    }

    return;
  }

  var_0 = "enemy";

  if(isDefined(level.player.riding_heli) && self == level.player.riding_heli) {
    return;
  }
  if(isDefined(self.mgturret)) {
    foreach(var_2 in self.mgturret) {
      var_2 maps\_utility::set_hudoutline(var_0, 1);
    }
  }

  maps\_utility::set_hudoutline(var_0, 1);
  self waittill("death");

  if(isDefined(self)) {
    self hudoutlinedisable();
  }
}

hud_outline_enable_withinview(var_0, var_1) {
  self notify("hud_outline_enable_withinView");
  self endon("hud_outline_enable_withinView");
  self endon("death");
  var_2 = 0;
  var_3 = 1;

  while(var_3) {
    wait 0.05;
    var_4 = (target_isincircle(self, level.player, 66, 130) || distancesquared(level.player getEye(), self.origin) < 9000000) && (level.player attackbuttonpressed() || level.player fragbuttonpressed());
    var_3 = isDefined(level.player.riding_heli);

    if(var_2) {
      if(!var_4 || !var_3) {
        var_2 = 0;
        self hudoutlinedisable();

        if(isDefined(self.mgturret)) {
          foreach(var_6 in self.mgturret) {
            var_6 hudoutlinedisable();
          }
        }
      }

      continue;
    }

    if(var_4 && var_3) {
      var_2 = 1;
      maps\_utility::set_hudoutline(var_0, 1);

      if(isDefined(self.mgturret)) {
        foreach(var_6 in self.mgturret) {
          var_6 maps\_utility::set_hudoutline(var_0, 1);
        }
      }
    }
  }
}

hud_hidetargets(var_0) {
  var_1 = self.owner;

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && target_istarget(var_3)) {
      var_4 = var_3._target;
      var_4.visibleto[var_1 getentitynumber()] = undefined;

      if(isDefined(var_3.mgturret)) {
        common_scripts\utility::array_call(var_3.mgturret, ::hudoutlinedisable);
      }

      var_3 hudoutlinedisable();
      target_hidefromplayer(var_3, var_1);
    }
  }
}

onteam(var_0) {
  if(maps\_vehicle::isvehicle()) {
    return isDefined(self.script_team) && self.script_team == var_0;
  } else {
    return isDefined(self.team) && self.team == var_0;
  }

  return 0;
}

hud_target_ondeath(var_0) {
  var_0 waittill("death");

  if(isDefined(var_0) && target_istarget(var_0)) {
    if(!isai(var_0)) {
      hud_hidetargets([var_0]);
    }

    target_remove(var_0);
  }
}

target_islockedontome(var_0) {
  if(!isDefined(self._target)) {
    return 0;
  }

  var_1 = var_0 getentitynumber();
  var_2 = 0;

  foreach(var_4 in self._target.weapon) {
    if(isDefined(var_4.islockedon[var_1])) {
      return 1;
    }
  }

  return 0;
}

_end() {
  var_0 = self.owner;
  var_0 notify("LISTEN_end_targeting");
  var_1 = target_getarray();
  var_2 = var_0 getentitynumber();

  if(level.players.size > 1) {
    foreach(var_4 in var_1) {
      target_remove(var_4);

      if(isDefined(var_4._target)) {
        var_4._target = undefined;
      }
    }
  } else {
    foreach(var_4 in var_1) {
      target_hidefromplayer(var_4, var_0);

      if(isDefined(var_4._target)) {
        foreach(var_8 in var_4._target.weapon) {
          var_8.islockedon[var_2] = undefined;
        }
      }
    }
  }
}

gt_op(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1)) {
    return common_scripts\utility::ter_op(var_0 > var_1, var_0, var_1);
  }

  if(isDefined(var_0) && !isDefined(var_1)) {
    return var_0;
  }

  if(!isDefined(var_0) && isDefined(var_1)) {
    return var_1;
  }

  return var_2;
}

target_alloc_limit_fail_passed(var_0, var_1) {
  if(target_getarray().size >= 64) {
    thread maps\_utility::missionfailedwrapper();
    return 0;
  }

  target_alloc(var_0, var_1);
  return 1;
}