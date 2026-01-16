/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\black_ice_vignette.gsc
***************************************/

vignette_setup(var_0, var_1) {
  if(!isDefined(self.v))
    self.v = spawnStruct();

  self.v.active = 0;
  self.v.instant_death = vignette_isDefined(self.v.instant_death, 1);
  self.v.nogun = vignette_isDefined(self.v.nogun, 0);
  self.v.invincible = vignette_isDefined(self.v.invincible, 0);
  self.v.delete_on_end = vignette_isDefined(self.v.delete_on_end, 0);
  self.v.ignoreall_on_end = vignette_isDefined(self.v.ignoreall_on_end, 0);
  self.v.death_anim_anytime = vignette_isDefined(self.v.death_anim_anytime, 0);
  self.v.death_on_self = vignette_isDefined(self.v.death_on_self, 0);
  self.v.death_on_end = vignette_isDefined(self.v.death_on_end, 0);
  self.v.silent_script_death = vignette_isDefined(self.v.silent_script_death, 0);
  self.v.interrupt_level = vignette_isDefined(self.v.interrupt_level, 0);
  self.v.interrupt_all_notifies = vignette_isDefined(self.v.interrupt_all_notifies, 0);
  self.v.interrupt_dist = vignette_isDefined(self.v.interrupt_dist, 128);
  self.v.prop_launch = vignette_isDefined(self.v.prop_launch, 0);

  if(isDefined(var_0))
    self.animname = var_0;

  if(isDefined(var_1))
    self.v.prop = var_1;

  self.v.current_state = "none";
  self.v.current_anim = undefined;
  self.v.current_interrupt_status = "none";
}

vignette_isDefined(var_0, var_1) {
  if(isDefined(var_0))
    return var_0;
  else
    return var_1;
}

vignette_single(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_6 in var_0)
  thread vignette_single_solo(var_6, var_1, var_2, var_3, var_4);

  while(self._vignette_active > 0)
    wait 0.05;
}

vignette_single_solo(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0.v) || !isDefined(var_0.v.active))
    var_0 vignette_setup();

  if(!isDefined(self._vignette_active))
    self._vignette_active = 1;
  else
    self._vignette_active++;

  var_0 endon("death");
  var_0 endon("msg_vignette_interrupt");
  var_0 endon("msg_stop_vignette_scripts");

  if(isai(var_0)) {
    var_0 vignette_ignore_everything();

    if(!isDefined(var_0.magic_bullet_shield) || !var_0.magic_bullet_shield)
      var_0 thread maps\_utility::magic_bullet_shield();
  }

  var_0.v.anim_node = self;

  if(isDefined(var_0.v.prop))
    var_6 = [var_0, var_0.v.prop];
  else
    var_6 = [var_0];

  if(isDefined(var_1))
    var_0.v.start_anim = var_1;

  if(isDefined(var_2))
    var_0.v.idle_anim = var_2;

  if(isDefined(var_3))
    var_0.v.idle_break_anim = var_3;

  if(isDefined(var_4)) {
    var_0.v.death_anim = var_4;
    var_0.a.nodeath = 1;
  }

  if(isDefined(var_5))
    var_0.v.start_end_time = var_5;

  var_0 thread vignette_interrupt_watcher(var_6);
  var_0.v.active = 1;

  if(isDefined(var_1)) {
    var_0 vignette_state("start", var_1);
    var_0.v.anim_node maps\_anim::anim_single(var_6, var_1, undefined, var_0.v.start_end_time);
    var_0 notify("msg_vignette_start_anim_done");
  }

  if(isDefined(var_2)) {
    var_0 vignette_state("idle", var_2);
    var_0.v.anim_node thread maps\_anim::anim_loop(var_6, var_2);
  } else
    var_0 thread vignette_end();
}

vignette_interrupt(var_0, var_1) {
  thread vignette_interrupt_solo(var_0, var_1);

  if(self.v.interrupt_level)
    level notify("msg_vignette_interrupt");
}

vignette_stop_interrupt_scripts(var_0) {
  if(!isDefined(var_0))
    var_0 = ["damage", "player_close", "other"];
  else if(isstring(var_0))
    var_0 = [var_0];

  self.v.current_interrupt_status = "";

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    switch (var_0[var_1]) {
      case "damage":
        self notify("msg_vignette_stop_interrupt_damage");
        break;
      case "player_close":
        self notify("msg_vignette_stop_interrupt_player_close");
        break;
      case "other":
        self notify("msg_vignette_stop_interrupt_other");
        break;
      default:
        self notify("msg_vignette_stop_interrupt_" + var_0[var_1]);
    }

    self.v.current_interrupt_status = self.v.current_interrupt_status + var_0[var_1];

    if(var_1 + 1 < var_0.size)
      self.v.current_interrupt_status = self.v.current_interrupt_status + " ";
  }
}

vignette_kill(var_0, var_1) {
  if(isDefined(var_0))
    thread vignette_end("kill: " + var_0, 1, var_1);
  else
    thread vignette_end("kill", 1, var_1);
}

vignette_interrupt_solo(var_0, var_1) {
  self notify("msg_vignette_interrupt");

  if(self != level) {
    self.v.anim_node notify("stop_loop");

    if(isDefined(self.v.idle_break_anim)) {
      if(isDefined(self.v.prop))
        var_3 = [self, self.v.prop];
      else
        var_3 = [self];

      vignette_state("idle_break", self.v.idle_break_anim);
      self.v.idle_break_anim_active = 1;
      self.v.anim_node maps\_anim::anim_single(var_3, self.v.idle_break_anim);
      self.v.idle_break_anim_played = 1;
      self notify("msg_vignette_interrupt_break_done");
    }

    var_2 = "interrupt";

    if(isDefined(var_0))
      var_2 = var_0;

    if(isDefined(var_1))
      vignette_kill(var_2, var_1);
    else
      thread vignette_end(var_2);
  }
}

vignette_end(var_0, var_1, var_2) {
  self notify("msg_stop_vignette_scripts");

  if(self.v.interrupt_level)
    level notify("msg_vignette_interrupt");

  if(self.v.active) {
    self.v.anim_node notify("stop_loop");

    if(self.v.silent_script_death)
      self.a.nodeath = 1;
    else {
      if((isDefined(var_1) && var_1 || self.v.death_on_end) && isDefined(self.v.death_anim)) {
        if(self.v.current_state == "idle" || self.v.death_anim_anytime) {
          self notify("msg_vignette_death_anim_start");
          vignette_state("death_anim", self.v.death_anim);

          if(isDefined(self.v.prop))
            var_3 = [self, self.v.prop];
          else
            var_3 = [self];

          if(self.v.death_on_self)
            maps\_anim::anim_single(var_3, self.v.death_anim);
          else
            self.v.anim_node maps\_anim::anim_single(var_3, self.v.death_anim);

          self.v.death_anim_played = 1;
          self.a.nodeath = 1;
        } else
          self.a.nodeath = 0;
      }

      if(!isDefined(self.v.idle_break_anim_played) && !isDefined(self.v.death_anim_played) && self._animactive) {
        self stopanimscripted();
        self.a.nodeath = 0;
      }
    }

    if(isDefined(self.v.prop) && !isDefined(self.v.death_anim_played) && !isDefined(self.v.idle_break_anim_played)) {
      self.v.prop stopanimscripted();

      if(self.v.prop_launch) {
        self.v.prop stopanimscripted();
        self.v.prop physicslaunchclient(self.v.prop.origin, (0, 0, 0));
      } else if(self.v.current_anim != "none") {
        var_4 = self.v.prop getanimtime(level.scr_anim[self.v.prop.animname][self.v.current_anim]);
        self.v.anim_node maps\_anim::anim_first_frame([self.v.prop], self.v.current_anim);
        self.v.anim_node maps\_anim::anim_set_time([self.v.prop], self.v.current_anim, var_4);
      }
    }

    if(isDefined(var_0))
      vignette_state(var_0);
    else
      vignette_state("none");

    if(!isDefined(var_1) && !self.v.death_on_end && !self.v.delete_on_end && isDefined(self.v.nogun) && self.v.nogun)
      maps\_utility::gun_recall();

    if(!isDefined(var_1) && isai(self) && !self.v.ignoreall_on_end)
      vignette_unignore_everything();

    self.v.active = 0;
  }

  if(!isDefined(self.hero) && isDefined(self.magic_bullet_shield))
    maps\_utility::stop_magic_bullet_shield();

  self notify("msg_vignette_end", var_2);

  if(isDefined(self.v.anim_node))
    self.v.anim_node._vignette_active--;

  if(isDefined(var_1) && var_1 || self.v.death_on_end) {
    vignette_state("kill");
    self.allowdeath = 1;
    self kill();
  }

  if(self.v.delete_on_end)
    self delete();
}

vignette_interrupt_watcher(var_0) {
  self endon("death");
  self endon("msg_stop_vignette_scripts");

  if(!self.v.invincible) {
    thread vignette_interrupt_watcher_damage();

    if(self.v.interrupt_all_notifies) {
      thread vignette_interrupt_watcher_other("bulletwhizby", level.player);
      thread vignette_interrupt_watcher_other("flashbang");
      thread vignette_interrupt_watcher_other("grenade danger");
      thread vignette_interrupt_watcher_player_close();
    }

    level waittill("msg_vignette_interrupt");
    vignette_interrupt("level");
  }
}

vignette_interrupt_watcher_damage() {
  self endon("death");
  self endon("msg_vignette_end");
  self endon("msg_vignette_death_anim_start");
  self endon("msg_vignette_stop_interrupt_damage");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(self.v.invincible) {
      continue;
    }
    if(self.v.instant_death && var_4 != "MOD_IMPACT" || var_0 >= self.health) {
      vignette_kill("interrupt_damage", var_1);
      return;
    }

    if(self.v.instant_death) {
      continue;
    }
    if(!isDefined(self.hero) && isDefined(self.magic_bullet_shield))
      maps\_utility::stop_magic_bullet_shield();

    self dodamage(var_0, var_2, var_1);
    vignette_interrupt("damage");
  }
}

vignette_interrupt_watcher_other(var_0, var_1) {
  self endon("death");
  self endon("msg_stop_vignette_scripts");
  self endon("msg_vignette_interrupt");
  self endon("msg_vignette_stop_interrupt_other");
  self endon("msg_vignette_stop_interrupt_other_" + var_0);

  for(;;) {
    self waittill(var_0, var_2);

    if(isDefined(var_1) && var_2 != var_1) {
      continue;
    }
    wait 0.1;
    vignette_interrupt(var_0, var_1);
  }
}

vignette_interrupt_watcher_player_close() {
  self endon("death");
  self endon("msg_stop_vignette_scripts");
  self endon("msg_vignette_interrupt");
  self endon("msg_vignette_stop_interrupt_player_close");
  var_0 = self.v.interrupt_dist;
  var_1 = var_0 * var_0;

  for(;;) {
    var_2 = distancesquared(self.origin, level.player.origin);

    if(var_2 <= var_1) {
      vignette_interrupt("playerclose");
      return;
    }

    wait 0.1;
  }
}

vignette_state(var_0, var_1) {
  if(isDefined(var_0))
    self.v.current_state = var_0;
  else
    self.v.current_state = "none";

  if(isDefined(var_1))
    self.v.current_anim = var_1;
  else
    self.v.current_anim = "none";

  self notify("msg_vignette_state_" + var_0);

  if(0) {
    var_2 = "";

    if(isDefined(self.animname))
      var_2 = " (" + self.animname + ")";

    iprintln("VIGNETTE" + var_2 + ": " + var_0);
  }
}

vignette_ignore_everything() {
  if(isDefined(self._ignore_settings_old))
    vignette_unignore_everything();

  self._ignore_settings_old = [];
  self.disableplayeradsloscheck = vignette_set_ignore_setting(self.disableplayeradsloscheck, "disableplayeradsloscheck", 1);
  self.ignoreall = vignette_set_ignore_setting(self.ignoreall, "ignoreall", 1);
  self.ignoreme = vignette_set_ignore_setting(self.ignoreme, "ignoreme", 1);
  self.grenadeawareness = vignette_set_ignore_setting(self.grenadeawareness, "grenadeawareness", 0);
  self.ignoreexplosionevents = vignette_set_ignore_setting(self.ignoreexplosionevents, "ignoreexplosionevents", 1);
  self.ignorerandombulletdamage = vignette_set_ignore_setting(self.ignorerandombulletdamage, "ignorerandombulletdamage", 1);
  self.ignoresuppression = vignette_set_ignore_setting(self.ignoresuppression, "ignoresuppression", 1);
  self.dontavoidplayer = vignette_set_ignore_setting(self.dontavoidplayer, "dontavoidplayer", 1);
  self.newenemyreactiondistsq = vignette_set_ignore_setting(self.newenemyreactiondistsq, "newEnemyReactionDistSq", 0);
  self.disablebulletwhizbyreaction = vignette_set_ignore_setting(self.disablebulletwhizbyreaction, "disableBulletWhizbyReaction", 1);
  self.disablefriendlyfirereaction = vignette_set_ignore_setting(self.disablefriendlyfirereaction, "disableFriendlyFireReaction", 1);
  self.dontmelee = vignette_set_ignore_setting(self.dontmelee, "dontMelee", 1);
  self.flashbangimmunity = vignette_set_ignore_setting(self.flashbangimmunity, "flashBangImmunity", 1);
  self.dodangerreact = vignette_set_ignore_setting(self.dodangerreact, "doDangerReact", 0);
  self.neversprintforvariation = vignette_set_ignore_setting(self.neversprintforvariation, "neverSprintForVariation", 1);
  self.a.disablepain = vignette_set_ignore_setting(self.a.disablepain, "a.disablePain", 1);
  self.allowpain = vignette_set_ignore_setting(self.allowpain, "allowPain", 0);
  self pushplayer(1);
}

vignette_set_ignore_setting(var_0, var_1, var_2) {
  if(isDefined(var_0))
    self._ignore_settings_old[var_1] = var_0;
  else
    self._ignore_settings_old[var_1] = "none";

  return var_2;
}

vignette_unignore_everything(var_0) {
  if(isDefined(var_0) && var_0) {
    if(isDefined(self._ignore_settings_old))
      self._ignore_settings_old = undefined;
  }

  self.disableplayeradsloscheck = vignette_restore_ignore_setting("disableplayeradsloscheck", 0);
  self.ignoreall = vignette_restore_ignore_setting("ignoreall", 0);
  self.ignoreme = vignette_restore_ignore_setting("ignoreme", 0);
  self.grenadeawareness = vignette_restore_ignore_setting("grenadeawareness", 1);
  self.ignoreexplosionevents = vignette_restore_ignore_setting("ignoreexplosionevents", 0);
  self.ignorerandombulletdamage = vignette_restore_ignore_setting("ignorerandombulletdamage", 0);
  self.ignoresuppression = vignette_restore_ignore_setting("ignoresuppression", 0);
  self.dontavoidplayer = vignette_restore_ignore_setting("dontavoidplayer", 0);
  self.newenemyreactiondistsq = vignette_restore_ignore_setting("newEnemyReactionDistSq", 262144);
  self.disablebulletwhizbyreaction = vignette_restore_ignore_setting("disableBulletWhizbyReaction", undefined);
  self.disablefriendlyfirereaction = vignette_restore_ignore_setting("disableFriendlyFireReaction", undefined);
  self.dontmelee = vignette_restore_ignore_setting("dontMelee", undefined);
  self.flashbangimmunity = vignette_restore_ignore_setting("flashBangImmunity", undefined);
  self.dodangerreact = vignette_restore_ignore_setting("doDangerReact", 1);
  self.neversprintforvariation = vignette_restore_ignore_setting("neverSprintForVariation", undefined);
  self.a.disablepain = vignette_restore_ignore_setting("a.disablePain", 0);
  self.allowpain = vignette_restore_ignore_setting("allowPain", 1);
  self._ignore_settings_old = undefined;
}

vignette_restore_ignore_setting(var_0, var_1) {
  if(isDefined(self._ignore_settings_old)) {
    if(isstring(self._ignore_settings_old[var_0]) && self._ignore_settings_old[var_0] == "none")
      return var_1;
    else
      return self._ignore_settings_old[var_0];
  }

  return var_1;
}