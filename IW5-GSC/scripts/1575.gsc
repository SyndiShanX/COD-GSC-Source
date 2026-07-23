/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1575.gsc
**************************************/

_id_3F32() {
  precachestring(&"SO_SURVIVAL_SUR_CH_HEADSHOT");
  precachestring(&"SO_SURVIVAL_SUR_CH_STREAK");
  precachestring(&"SO_SURVIVAL_SUR_CH_STAGGER");
  precachestring(&"SO_SURVIVAL_SUR_CH_QUADKILL");
  precachestring(&"SO_SURVIVAL_SUR_CH_FLASH");
  precachestring(&"SO_SURVIVAL_SUR_CH_KNIFE");
}

_id_3F33() {
  var_0 = 0;
  var_1 = 20;
  var_2 = [];

  for(var_3 = var_0; var_3 <= var_1; var_3++) {
    var_4 = _id_3F57(var_3);

    if(!isDefined(var_4) || var_4 == "") {
      break;
    }

    var_5 = spawnStruct();
    var_5.repeating = var_3;
    var_5.ref = var_4;
    var_5.name = _id_3F58(var_4);
    var_5.desc = _id_3F59(var_4);
    var_5.splash = _id_3F5A(var_4);
    var_5.icon = _id_3F5B(var_4);
    var_5._id_3F35 = _id_3F5C(var_4);
    var_5.xp = _id_3F5D(var_4);
    var_5._id_3F36 = _id_3F5E(var_4);
    var_5._id_3F37 = _id_3F5F(var_4);
    var_5._id_3F38 = _id_3F60(var_4);
    var_5._id_3F39 = _id_3F61(var_4);
    var_5.func = _id_3F3F(var_4);
    var_2[var_4] = var_5;
  }

  return var_2;
}

_id_3F3A() {
  level._id_3F3B = _id_3F33();
  common_scripts\utility::flag_init("challenge_monitor_busy");
  maps\_utility::add_global_spawn_function("axis", ::_id_3F48);
  maps\_utility::add_global_spawn_function("axis", ::_id_3F46);

  foreach(var_1 in level.players) {}
  var_1 thread _id_3F3C();
}

_id_3F3C() {
  wait 0.05;

  for(var_0 = 0; var_0 < 5; var_0++) {
    maps\_specialops::surhud_challenge_label(var_0, "");
    maps\_specialops::surhud_challenge_progress(var_0, 0);
    maps\_specialops::surhud_challenge_reward(var_0, 0);
  }

  maps\_specialops::surhud_disable("challenge");
  common_scripts\utility::flag_wait("start_survival");

  for(;;) {
    var_1 = [];

    foreach(var_3 in level._id_3F3B) {
      if(var_3._id_3F38 == 0) {
        continue;
      }
      if(var_3._id_3F39 == 0) {
        if(level.current_wave >= var_3._id_3F38) {
          var_1[var_1.size] = var_3;
        }
        continue;
      }

      if(level.current_wave >= var_3._id_3F38 && level.current_wave <= var_3._id_3F39) {
        var_1[var_1.size] = var_3;
      }
    }

    var_5 = 0;
    var_1 = maps\_utility::array_randomize(var_1);
    self._id_3F3D = [];
    self._id_3F3E = [];

    foreach(var_7 in var_1) {
      if(var_5 == 2) {
        break;
      }

      self._id_3F3D[var_7.ref] = spawnStruct();
      self._id_3F3D[var_7.ref].index = var_5;
      self._id_3F3D[var_7.ref].struct = var_7;
      self._id_3F3E[var_7.ref] = 0;
      self thread[[var_7.func]](var_7.ref);
      var_5++;
    }

    maps\_specialops::surhud_animate("challenge");
    level waittill("wave_ended");
    level waittill("wave_started");
    self notify("challenge_reset");
  }
}

_id_3F3F(var_0) {
  switch (var_0) {
    case "sur_ch_headshot":
      return::_id_3F4A;
    case "sur_ch_streak":
      return::_id_3F4D;
    case "sur_ch_stagger":
      return::_id_3F4F;
    case "sur_ch_quadkill":
      return::_id_3F49;
    case "sur_ch_knife":
      return::_id_3F47;
    case "sur_ch_flash":
      return::_id_3F45;
  }

  return undefined;
}

_id_3F40(var_0) {
  self endon("death");
  self endon("challenge_reset");
  var_1 = self._id_3F3D[var_0].index;
  var_2 = _id_3F5C(var_0);
  var_3 = _id_3F5D(var_0);
  var_4 = _id_3F5F(var_0);
  var_5 = _id_3F5E(var_0);
  self._id_3F3D[var_0]._id_3F41 = 0;
  self._id_3F3D[var_0]._id_3F42 = 0;
  thread _id_3F52(var_1, var_0);
  var_6 = undefined;

  for(;;) {
    while(self._id_3F3D[var_0]._id_3F42 < var_2) {
      self waittill(var_0, var_7, var_6);

      if(!isDefined(var_7)) {
        var_7 = 1;
      }
      if(var_7 < 0) {
        self._id_3F3D[var_0]._id_3F42 = 0;
      } else {
        self._id_3F3D[var_0]._id_3F42 = self._id_3F3D[var_0]._id_3F42 + var_7;
      }
      thread _id_3F53(var_0);
    }

    if(isDefined(var_6) && isai(var_6)) {
      playFX(level._effect["money"], var_6.origin + (0, 0, 32));
    }
    self._id_3F3D[var_0]._id_3F42 = 0;
    self._id_3F3D[var_0]._id_3F41++;
    var_8 = self._id_3F3D[var_0]._id_3F41 * _id_3F5D(var_0);
    maps\_utility::givexp(var_0, var_8);
    thread _id_3F54(var_0, var_8);

    while(common_scripts\utility::flag("challenge_monitor_busy")) {
      wait 0.05;
    }
    self notify("challenge_complete", var_0);
    maps\_utility::delaythread(0.05, ::_id_3F53, var_0);

    if(!var_5) {
      return;
    }
  }
}

_id_3F43(var_0, var_1) {
  self endon("death");
  self endon("challenge_reset");

  for(;;) {
    var_2 = self.stats["kills"];
    level waittill("specops_player_kill", var_3, var_4, var_5, var_6);

    if(!isalive(var_3) || var_3 != self) {
      continue;
    }
    waittillframeend;

    if(var_2 < self.stats["kills"]) {
      var_7 = self.stats["kills"] - var_2;

      for(var_8 = 0; var_8 < var_7; var_8++) {
        self notify(var_0, var_1, var_4);
        waittillframeend;
      }
    }
  }
}

_id_3F45(var_0) {
  thread _id_3F40(var_0);
}

_id_3F46() {
  level endon("special_op_terminated");

  if(!isai(self)) {
    return;
  }
  self waittill("death", var_0, var_1, var_2);

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }
  if(common_scripts\utility::isflashed()) {
    var_0 notify("sur_ch_flash", 1);
  }
}

_id_3F47(var_0) {
  thread _id_3F40(var_0);
}

_id_3F48() {
  level endon("special_op_terminated");

  if(!isai(self)) {
    return;
  }
  self waittill("death", var_0, var_1, var_2);

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    return;
  }
  if(isDefined(var_2) && weapontype(var_2) == "riotshield") {
    var_0 notify("sur_ch_knife", -1);
  } else {
    if(isDefined(var_1) && var_1 == "MOD_MELEE") {
      var_0 notify("sur_ch_knife", 1);
      return;
    }

    var_0 notify("sur_ch_knife", -1);
  }
}

_id_3F49(var_0) {
  thread _id_3F40(var_0);
}

_id_3F4A(var_0) {
  thread _id_3F40(var_0);
}

_id_3F4D(var_0) {
  self endon("death");
  self endon("challenge_reset");
  thread _id_3F40(var_0);
  waittillframeend;
  thread _id_3F43(var_0, 1);
  thread _id_3F4E(var_0);
}

_id_3F4E(var_0) {
  self endon("death");
  self endon("challenge_reset");

  for(;;) {
    self waittill("damage", var_1, var_2);

    if(isDefined(var_2) && isai(var_2)) {
      self notify(var_0, -1);
    }
  }
}

_id_3F4F(var_0) {
  self endon("death");
  self endon("challenge_reset");
  thread _id_3F40(var_0);
  waittillframeend;
  thread _id_3F43(var_0, 6);
  thread _id_3F50(var_0);
}

_id_3F50(var_0) {
  self endon("death");
  self endon("challenge_reset");
  var_1 = 5;
  var_1 = min(20, var_1);
  var_2 = 1 / var_1;

  for(;;) {
    var_3 = 2;

    while(self._id_3F3D[var_0]._id_3F42 == 0) {
      common_scripts\utility::waittill_any_timeout(var_3, var_0);
    }
    if(level.survival_wave_intermission) {
      level waittill("wave_started");
      wait(var_3);
    }

    for(var_4 = 0; var_4 < var_1; var_4++) {
      wait(1 / var_1);
      var_5 = self._id_3F3D[var_0]._id_3F42;
      self._id_3F3D[var_0]._id_3F42 = max(0, var_5 - var_2);
      thread _id_3F53(var_0);
    }
  }
}

_id_3F52(var_0, var_1) {
  maps\_specialops::surhud_challenge_label(var_0, _id_3F58(var_1));
  thread _id_3F53(var_1);
}

_id_3F53(var_0) {
  var_1 = self._id_3F3D[var_0].index;
  var_2 = self._id_3F3D[var_0]._id_3F42;
  var_3 = self._id_3F3D[var_0]._id_3F41 + 1;
  var_4 = _id_3F5C(var_0);
  maps\_specialops::surhud_challenge_reward(var_1, _id_3F5D(var_0) * var_3);
  maps\_specialops::surhud_challenge_progress(var_1, int(var_2 / var_4 * 100) / 100);
}

_id_3F54(var_0, var_1) {
  if(isDefined(self.doingnotify) && self.doingnotify) {
    while(self.doingnotify) {
      wait 0.05;
    }
  }

  var_2 = spawnStruct();
  var_2.duration = 2.5;
  var_2.sound = "survival_bonus_splash";
  var_2.type = "wave";
  var_2.title_font = "hudbig";
  var_2.playsoundlocally = 1;
  var_2.zoomin = 1;
  var_2.zoomout = 1;
  var_2.fadein = 1;
  var_2.fadeout = 1;
  var_2.title_glowcolor = (0.85, 0.35, 0.15);
  var_2.title_color = (0.95, 0.95, 0.9);
  var_2.title = _id_3F5A(var_0);
  var_2.title_set_value = var_1;

  if(issplitscreen()) {
    var_2.title_basefontscale = 1;
  } else {
    var_2.title_basefontscale = 1.1;
  }
  maps/_so_survival_code::splash_notify_message(var_2);
}

_id_3F55(var_0) {
  return isDefined(level._id_3F3B) && isDefined(level._id_3F3B[var_0]);
}

_id_3F56(var_0) {
  if(_id_3F55(var_0)) {
    return level._id_3F3B[var_0].repeating;
  }
  return tablelookup("sp/survival_challenge.csv", 1, var_0, 0);
}

_id_3F57(var_0) {
  return tablelookup("sp/survival_challenge.csv", 0, var_0, 1);
}

_id_3F58(var_0) {
  if(_id_3F55(var_0)) {
    return level._id_3F3B[var_0].name;
  }
  return tablelookup("sp/survival_challenge.csv", 1, var_0, 2);
}

_id_3F59(var_0) {
  if(_id_3F55(var_0)) {
    return level._id_3F3B[var_0].desc;
  }
  return tablelookup("sp/survival_challenge.csv", 1, var_0, 3);
}

_id_3F5A(var_0) {
  if(_id_3F55(var_0)) {
    return level._id_3F3B[var_0].splash;
  }
  return tablelookupistring("sp/survival_challenge.csv", 1, var_0, 4);
}

_id_3F5B(var_0) {
  if(_id_3F55(var_0)) {
    return level._id_3F3B[var_0].icon;
  }
  return tablelookup("sp/survival_challenge.csv", 1, var_0, 5);
}

_id_3F5C(var_0) {
  if(_id_3F55(var_0)) {
    return level._id_3F3B[var_0]._id_3F35;
  }
  return int(tablelookup("sp/survival_challenge.csv", 1, var_0, 6));
}

_id_3F5D(var_0) {
  if(_id_3F55(var_0)) {
    return level._id_3F3B[var_0].xp;
  }
  return int(tablelookup("sp/survival_challenge.csv", 1, var_0, 7));
}

_id_3F5E(var_0) {
  if(_id_3F55(var_0)) {
    return level._id_3F3B[var_0]._id_3F36;
  }
  return int(tablelookup("sp/survival_challenge.csv", 1, var_0, 8));
}

_id_3F5F(var_0) {
  if(_id_3F55(var_0)) {
    return level._id_3F3B[var_0]._id_3F37;
  }
  return int(tablelookup("sp/survival_challenge.csv", 1, var_0, 9));
}

_id_3F60(var_0) {
  if(_id_3F55(var_0)) {
    return level._id_3F3B[var_0]._id_3F38;
  }
  return int(tablelookup("sp/survival_challenge.csv", 1, var_0, 10));
}

_id_3F61(var_0) {
  if(_id_3F55(var_0)) {
    return level._id_3F3B[var_0]._id_3F39;
  }
  return int(tablelookup("sp/survival_challenge.csv", 1, var_0, 11));
}