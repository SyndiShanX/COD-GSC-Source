/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\stealth\threat_sight.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace threat_sight;

function threat_sight_set_enabled(enabled) {
  assert(isDefined(level.stealth));
  wasenabled = function_7a21aa652f0613b0();
  function_24e85292b191399c(enabled);
  threat_sight_set_dvar(enabled);

  if(!enabled && wasenabled) {
    level notify("threat_sight_disabled");

    foreach(player in level.players) {
      player thread function_9b25540da1b89219();
      player thread function_e4eaeef9e706471e();
    }
  } else if(enabled && !wasenabled) {
    level notify("threat_sight_enabled");
  }

  allai = getaiarray();

  foreach(guy in allai) {
    if(isalive(guy) && isDefined(guy.threatsightstate)) {
      guy setthreatsightstate(guy.threatsightstate);
    }
  }

  if(enabled && !wasenabled) {
    level thread function_468da1365698eabf();
    level thread function_3e245e55717e286a();
  }
}

function threat_sight_set_dvar(enabled) {
  if(enabled && !function_7a21aa652f0613b0()) {
    return;
  }

  setsaveddvar(@ "ai_threatsight", enabled);
  level thread threat_sight_set_dvar_display(enabled);
}

function threat_sight_set_dvar_display(enabled) {
  self notify("threat_sight_set_dvar_display");
  self endon("threat_sight_set_dvar_display");

  if(!enabled) {
    wait 1;
  }

  if(getdvarint(@ "ai_threatusedisplay", 0)) {
    setsaveddvar(@ "hash_dfbef9bc86d93b90", enabled);
  }

  setDvar(@ "hash_21b72d8c9ff7a1b3", enabled);
}

function threat_sight_enabled() {
  if(!getdvarint(@ "ai_threatsight")) {
    return 0;
  }

  if(self == level) {
    return function_7a21aa652f0613b0();
  }

  return isDefined(self.threatsight) && self.threatsight;
}

function threat_sight_player_entity_state_set(ai, statename) {
  if(!isDefined(self.stealth)) {
    return;
  }

  switch (statename) {
    case #"hash_9a31640cc41d3ff3":
      ai setthreatsight(self, 0);
      break;
    case #"hash_e21b072df2b47f94":
      if(isDefined(ai.enemy) && ai.enemy == self) {
        ai setthreatsight(self, 1);
      }

      break;
    case #"hash_e8bc3da4af287c2d":
      ai setthreatsight(self, 0);
      break;
  }
}

function threat_sight_force_visible(othersentient, durationseconds) {
  self function_d955a85131dc6e69(othersentient, durationseconds);
  end = gettime() + int(1000 * durationseconds);
  entnum = othersentient getentitynumber();

  if(!isDefined(self.stealth.force_visible)) {
    self.stealth.force_visible = [];
  }

  if(isDefined(self.stealth.force_visible[entnum])) {
    self.stealth.force_visible[entnum].end = max(self.stealth.force_visible[entnum].end, end);
  } else {
    self.stealth.force_visible[entnum] = spawnStruct();
    self.stealth.force_visible[entnum].end = end;
  }

  self.stealth.force_visible[entnum].ent = othersentient;
  thread threat_sight_force_visible_thread();
}

function threat_sight_force_visible_thread() {
  if(istrue(self.stealth.force_visible_thread)) {
    return;
  }

  self notify("threat_sight_force_visible_thread");
  self endon("threat_sight_force_visible_thread");
  self endon("death");
  self.stealth.force_visible_thread = 1;
  waittime = 0.05;

  while(isDefined(self.stealth.force_visible) && self.stealth.force_visible.size > 0) {
    now = gettime();
    remove = [];

    foreach(key, forcedvis in self.stealth.force_visible) {
      if(now < forcedvis.end && issentient(forcedvis.ent) && !self cansee(forcedvis.ent)) {
        if(isPlayer(forcedvis.ent)) {
          newthreat = self getthreatsight(forcedvis.ent);
          stealthmaxthreat = function_910a912f327b8d34(forcedvis.ent);
          forcedvis.ent thread threat_sight_player_sight_audio(1, max(stealthmaxthreat, newthreat));
        }

        continue;
      }

      remove[remove.size] = key;
    }

    foreach(key in remove) {
      self.stealth.force_visible[key] = undefined;
    }

    wait waittime;
  }

  self.stealth.force_visible = undefined;
  self.stealth.force_visible_thread = undefined;
}

function function_468da1365698eabf() {
  level endon("threat_sight_disabled");

  if(!isDefined(level.stealth.fnthreatsightplayersightaudio)) {
    level waittill("threat_sight_audio_enabled");
    assert(isDefined(level.stealth.fnthreatsightplayersightaudio));
  }

  while(!isDefined(level.players)) {
    waitframe();
  }

  while(true) {
    if(getdvarfloat(@ "ai_threatsightfakethreat") <= 0) {
      foreach(player in level.players) {
        if(!isalive(player) || !isDefined(player.stealth)) {
          continue;
        }

        player thread threat_sight_player_sight_audio(function_8ce5803b7d377d72(player), function_910a912f327b8d34(player));
      }
    }

    waitframe();
  }
}

function function_3e245e55717e286a() {
  level endon("threat_sight_disabled");

  if(!isDefined(level.stealth.var_ed06a52046d9f7a1)) {
    level waittill("threat_sight_rumble_enabled");
    assert(isDefined(level.stealth.var_ed06a52046d9f7a1));
  }

  while(!isDefined(level.players)) {
    waitframe();
  }

  while(true) {
    if(getdvarfloat(@ "ai_threatsightfakethreat") <= 0) {
      foreach(player in level.players) {
        if(!isalive(player) || !isDefined(player.stealth)) {
          continue;
        }

        player thread function_82079fb63bda0995(function_8ce5803b7d377d72(player), function_910a912f327b8d34(player));
      }
    }

    waitframe();
  }
}

function threat_sight_fake(origin, amount) {
  self notify("threat_sight_fake");
  self endon("threat_sight_fake");
  setsaveddvar(@ "ai_threatsightfakethreat", amount);
  setsaveddvar(@ "ai_threatsightfakex", origin[0]);
  setsaveddvar(@ "ai_threatsightfakey", origin[1]);
  setsaveddvar(@ "ai_threatsightfakez", origin[2]);
  stealthmaxthreat = function_910a912f327b8d34(self);

  while(amount > 0) {
    thread threat_sight_player_sight_audio(1, max(stealthmaxthreat, amount));
    wait 0.15;
  }

  thread threat_sight_player_sight_audio(0, max(stealthmaxthreat, amount));
}

function threat_sight_player_sight_audio(anycansee, maxthreat, willdebugprint) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnthreatsightplayersightaudio)) {
    self thread[[level.stealth.fnthreatsightplayersightaudio]](anycansee, maxthreat, willdebugprint);
  }
}

function function_9b25540da1b89219() {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnthreatsightplayersightaudiocleanup)) {
    self thread[[level.stealth.fnthreatsightplayersightaudiocleanup]]();
  }
}

function function_82079fb63bda0995(anycansee, maxthreat) {
  if(isDefined(level.stealth) && isDefined(level.stealth.var_ed06a52046d9f7a1)) {
    self thread[[level.stealth.var_ed06a52046d9f7a1]](anycansee, maxthreat);
  }
}

function function_e4eaeef9e706471e() {
  if(isDefined(level.stealth) && isDefined(level.stealth.var_45cffb1cb64f32c7)) {
    self thread[[level.stealth.var_45cffb1cb64f32c7]]();
  }
}