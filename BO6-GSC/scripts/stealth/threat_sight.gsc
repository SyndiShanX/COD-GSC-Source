/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\threat_sight.gsc
********************************************/

#namespace threat_sight;

function threat_sight_set_enabled(enabled) {
  assert(isDefined(level.stealth));
  wasenabled = function_70ef105273263dd1();
  function_612318c38ee5b4b5(enabled);
  threat_sight_set_dvar(enabled);

  if(!enabled && wasenabled) {
    level notify("X\xcci\xad\x95Z\x96e\xf1\xb6[\xc3\xc9\a\xa9-W.\xe6\xdf\xad");

    foreach(player in level.players) {
      player thread function_6e83d9bed5ee310c();
      player thread function_1ed6ad941982b6cb();
    }
  } else if(enabled && !wasenabled) {
    level notify("\x97\x84<,\xbc\xab\xa4.\xd8\x18\xa8\xbfn\x8f\xba4U_%=");
  }

  allai = getaiarray();

  foreach(guy in allai) {
    if(isalive(guy) && isDefined(guy.threatsightstate)) {
      guy setthreatsightstate(guy.threatsightstate);
    }
  }

  if(enabled && !wasenabled) {
    level thread function_740ed1d2434ecf36();
    level thread function_50e6b1baded7ccef();
  }
}

function threat_sight_set_dvar(enabled) {
  if(enabled && !function_70ef105273263dd1()) {
    return;
  }

  setsaveddvar(@ "ai_threatsight", enabled);
  level thread threat_sight_set_dvar_display(enabled);
}

function threat_sight_set_dvar_display(enabled) {
  self notify("\xa3h9+,\x8e\xd7sK\xech\x1d\xaf\x9b+\xd1_\xc8\xce\vr\xf5\x19i7\xe0\xc6\xb0\xf2");
  self endon("\xa3h9+,\x8e\xd7sK\xech\x1d\xaf\x9b+\xd1_\xc8\xce\vr\xf5\x19i7\xe0\xc6\xb0\xf2");

  if(!enabled) {
    wait 1;
  }

  if(getdvarint(@ "ai_threatusedisplay", 0)) {
    setsaveddvar(@ "ai_threatsightdisplay", enabled);
  }

  setDvar(@ "hash_21b72d8c9ff7a1b3", enabled);
}

function threat_sight_enabled() {
  if(!getdvarint(@ "ai_threatsight")) {
    return 0;
  }

  if(self == level) {
    return function_70ef105273263dd1();
  }

  return 1;
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
  self function_addc15ba1c4c1884(othersentient, durationseconds);
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

  self notify("ey\x82\xe4=\xebh;\xa1\x8ao\x11_\xcb/\xf2h8\xd3\f\x05\x1fpc\x8d\x97\xc3Y\xa3\x1e\xf1\n.");
  self endon("ey\x82\xe4=\xebh;\xa1\x8ao\x11_\xcb/\xf2h8\xd3\f\x05\x1fpc\x8d\x97\xc3Y\xa3\x1e\xf1\n.");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.stealth.force_visible_thread = 1;
  waittime = 0.05;

  while(isDefined(self.stealth.force_visible) && self.stealth.force_visible.size > 0) {
    now = gettime();
    remove = [];

    foreach(key, forcedvis in self.stealth.force_visible) {
      if(now < forcedvis.end && issentient(forcedvis.ent) && !self cansee(forcedvis.ent)) {
        if(isPlayer(forcedvis.ent)) {
          newthreat = self getthreatsight(forcedvis.ent);
          stealthmaxthreat = function_d04b7ed3ce995a49(forcedvis.ent);
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

function function_740ed1d2434ecf36() {
  level endon("X\xcci\xad\x95Z\x96e\xf1\xb6[\xc3\xc9\a\xa9-W.\xe6\xdf\xad");

  if(!isDefined(level.stealth.fnthreatsightplayersightaudio)) {
    level waittill("\x1d\x1b0\x1a\x8c\x98\xc3p\x98& 0\x90\x8fz\xc9\xc7\xee\xa6\x89\x85\xe8_\x15X\xdb\xa7");
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

        player thread threat_sight_player_sight_audio(function_e9ae696ebc2edbff(player), function_d04b7ed3ce995a49(player));
      }
    }

    waitframe();
  }
}

function function_50e6b1baded7ccef() {
  level endon("X\xcci\xad\x95Z\x96e\xf1\xb6[\xc3\xc9\a\xa9-W.\xe6\xdf\xad");

  if(!isDefined(level.stealth.var_d7c0c88cfdabd5a8)) {
    level waittill("qFT\xacH\xdb:\x15\x83\xe4@A\x16\x11f\xd5o\xc5*o6T\xd8XP\xafJ");
    assert(isDefined(level.stealth.var_d7c0c88cfdabd5a8));
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

        player thread function_511c0c4464213104(function_e9ae696ebc2edbff(player), function_d04b7ed3ce995a49(player));
      }
    }

    waitframe();
  }
}

function threat_sight_fake(origin, amount) {
  self notify("\xc1\xf0\xb4\xaf\xdb^\xd1m\xfe\xaf\x15\xf4\xd0\xb316\xa7");
  self endon("\xc1\xf0\xb4\xaf\xdb^\xd1m\xfe\xaf\x15\xf4\xd0\xb316\xa7");
  setsaveddvar(@ "ai_threatsightfakethreat", amount);
  setsaveddvar(@ "ai_threatsightfakex", origin[0]);
  setsaveddvar(@ "ai_threatsightfakey", origin[1]);
  setsaveddvar(@ "ai_threatsightfakez", origin[2]);
  stealthmaxthreat = function_d04b7ed3ce995a49(self);

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

function function_6e83d9bed5ee310c() {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnthreatsightplayersightaudiocleanup)) {
    self thread[[level.stealth.fnthreatsightplayersightaudiocleanup]]();
  }
}

function function_511c0c4464213104(anycansee, maxthreat) {
  if(isDefined(level.stealth) && isDefined(level.stealth.var_d7c0c88cfdabd5a8)) {
    self thread[[level.stealth.var_d7c0c88cfdabd5a8]](anycansee, maxthreat);
  }
}

function function_1ed6ad941982b6cb() {
  if(isDefined(level.stealth) && isDefined(level.stealth.var_4c9be84f33b1416e)) {
    self thread[[level.stealth.var_4c9be84f33b1416e]]();
  }
}