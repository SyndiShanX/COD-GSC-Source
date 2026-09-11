/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\threat_sight.gsc
***********************************************/

function threat_sight_set_enabled(var0) {
  var1 = isDefined(level.stealth.threat_sight_enabled) && level.stealth.threat_sight_enabled;
  level.stealth.threat_sight_enabled = var0;
  threat_sight_set_dvar(var0);

  if(!var0 && var1) {
    level notify("threat_sight_disabled");

    foreach(var3 in level.players) {
      var3.stealth.threat_thread = undefined;
    }
  } else if(var0 && !var1) {
    level notify("threat_sight_enabled");
  }

  var5 = getaiarray();

  foreach(var7 in var5) {
    if(isalive(var7) && isDefined(var7.stealth) && isDefined(var7.stealth.threat_sight_state)) {
      threat_sight_set_state(var7, var7.stealth.threat_sight_state);
    }
  }
}

function threat_sight_set_dvar(var0) {
  setdvarifuninitialized("ai_threatForcedRate", 0.4);
  setdvarifuninitialized("ai_threatForcedMax", 0.5);

  if(var0 && (!isDefined(level.stealth.threat_sight_enabled) || !level.stealth.threat_sight_enabled)) {
    return;
  }

  setsaveddvar("OKQTSOMTKT", var0);
  thread threat_sight_set_dvar_display(level);
}

function threat_sight_set_dvar_display(var0) {
  self notify("threat_sight_set_dvar_display");
  self endon("threat_sight_set_dvar_display");

  if(!var0) {
    wait 1;
  }

  if(getdvarint("ai_threatUseDisplay", 0)) {
    setsaveddvar("NPQNNOSNNL", var0);
  }

  setDvar("scr_ai_threatsightaudio", var0);
}

function threat_sight_enabled() {
  if(!getdvarint("OKQTSOMTKT")) {
    return false;
  }

  if(self == level) {
    return (isDefined(level.stealth.threat_sight_enabled) && level.stealth.threat_sight_enabled);
  }

  return isDefined(self.threatsight) && self.threatsight;
}

function threat_sight_set_state(var0) {
  if(isDefined(self.stealth)) {
    self.stealth.threat_sight_state = var0;
  }

  if(!isDefined(level.stealth.threat_sight_enabled) || !level.stealth.threat_sight_enabled) {
    if(!istrue(self.threat_sight_immediate_thread)) {
      thread threat_sight_immediate_thread();
      self.threat_sight_immediate_thread = 1;
    }

    return;
  } else if(istrue(self.threat_sight_immediate_thread)) {
    self notify("threat_sight_immediate_thread");
    self.threat_sight_immediate_thread = undefined;
  }

  switch (var0) {
    case "hidden":
      self.threatsight = 1;
      self.stealth.threat_sight_count = undefined;
      self.stealth.threat_sight_lost = undefined;
      break;
    case "investigate":
      self.threatsight = 1;
      break;
    case "combat_hunt":
    case "flashlight_in_dark":
      self.threatsight = 1;
      break;
    case "blind":
    case "spotted":
    case "death":
      self.threatsight = 0;
      break;
    default:
      break;
  }

  foreach(var2 in level.players) {
    threat_sight_player_entity_state_set(var2, self, var0);
  }

  threat_sight_set_state_parameters(var0);
}

function threat_sight_set_state_parameters(var0) {
  self[[level.stealth.fnthreatsightsetstateparameters]](var0);
}

function threat_sight_immediate_thread() {
  self notify("threat_sight_immediate_thread");
  self endon("threat_sight_immediate_thread");
  self endon("death");
  level endon("threat_sight_enabled");

  for(;;) {
    level scripts\engine\utility::flag_wait("stealth_enabled");
    level scripts\engine\utility::flag_waitopen("stealth_spotted");
    wait randomfloatrange(0.4, 0.6);

    foreach(var1 in level.players) {
      if(isDefined(var1.ignore_stealth_sight)) {
        continue;
      }

      if(var1.ignoreme) {
        continue;
      }

      if(self cansee(var1)) {
        self aieventlistenerevent("sight", var1, var1.origin);
      }
    }
  }
}

function threat_sight_player_init() {
  if(!isDefined(self.stealth.threat_entities)) {
    self.stealth.threat_entities = [];
  }

  if(!isDefined(self.stealth.threat_visible)) {
    self.stealth.threat_visible = 0;
  }

  if(!isDefined(self.stealth.threat_combat)) {
    self.stealth.threat_combat = 0;
  }

  if(!isDefined(self.stealth.threat_sighted)) {
    self.stealth.threat_sighted = [];
    return;
  }
}

function threat_sight_player_entity_state_set(var0, var1) {
  threat_sight_player_init();
  var2 = var0 getentitynumber();

  switch (var1) {
    case "hidden":
      self.stealth.threat_sighted[var2] = undefined;
      break;
    case "combat_hunt":
      var0 setthreatsight(self, 0);
      break;
    case "investigate":
      if(isDefined(var0.enemy) && var0.enemy == self) {
        var0 setthreatsight(self, 1);
      }

      break;
    case "death":
      var0 setthreatsight(self, 0);
      break;
  }

  switch (var1) {
    case "death":
      self.stealth.threat_entities[var2] = undefined;
      self.stealth.threat_sighted[var2] = undefined;
      break;
    default:
      self.stealth.threat_entities[var2] = var0;
      break;
  }

  if(!isDefined(self.stealth.threat_thread)) {
    self.stealth.threat_thread = 1;
    thread threat_sight_player_entity_state_thread();
    return;
  }
}

function threat_sight_sighted(var0) {
  self endon("death");
  self endon("stealth_idle");
  var0 endon("disconnect");
  var0 endon("death");
  var1 = self getentitynumber();

  if(self[[self.fnisinstealthhunt]]()) {
    self getenemyinfo(var0);
    self aieventlistenerevent("combat", var0, var0.origin);
    return;
  }

  var0.stealth.threat_sighted[var1] = self;
  self aieventlistenerevent("sight", var0, var0.origin);
  var2 = var0 getentitynumber();

  if(!isDefined(self.stealth.threat_sight_count)) {
    self.stealth.threat_sight_count = [];
  }

  if(!isDefined(self.stealth.threat_sight_count[var2])) {
    self.stealth.threat_sight_count[var2] = 0;
  } else {
    self.stealth.threat_sight_count[var2]++;
  }

  var3 = scripts\stealth\utility::alert_delay_distance_time(var0);
  var3 /= pow(2, self.stealth.threat_sight_count[var2]);
  var3 *= 1000;
  var4 = gettime();

  if(scripts\common\utility::issp()) {
    self.stealth.reactendtime = var4 + var3;
  }

  var5 = var4;
  var6 = var4 + var3;

  while(gettime() < var6) {
    if(istrue(self.stealth.blind) || !isDefined(self.stealth.threat_sight_count) || !isDefined(self.stealth.threat_sight_count[var2])) {
      break;
    }

    var3 = scripts\stealth\utility::alert_delay_distance_time(var0);
    var3 /= pow(2, self.stealth.threat_sight_count[var2]);
    var3 *= 1000;

    if(var5 + var3 < var6) {
      var6 = var5 + var3;
    }

    waitframe();
  }

  thread threat_sight_sighted_wait_lost(var0);
}

function threat_sight_sighted_wait_lost(var0) {
  var1 = var0 getentitynumber();
  self notify("threat_sight_sighted_wait_lost_" + var1);
  self endon("threat_sight_sighted_wait_lost_" + var1);
  self endon("death");
  var0 endon("disconnect");
  var0 endon("death");
  var2 = self getentitynumber();
  var0.stealth.threat_sighted[var2] = undefined;

  for(;;) {
    self.stealth.threat_sight_lost[var1] = self getthreatsight(var0) < 0.75;

    if(self.stealth.threat_sight_lost[var1]) {
      return;
    }

    wait 0.05;
  }
}

function threat_sight_force_visible(var0, var1) {
  var2 = gettime() + int(1000 * var1);
  var3 = var0 getentitynumber();

  if(!isDefined(self.stealth.force_visible)) {
    self.stealth.force_visible = [];
  }

  if(isDefined(self.stealth.force_visible[var3])) {
    self.stealth.force_visible[var3].end = max(self.stealth.force_visible[var3].end, var2);
  } else {
    self.stealth.force_visible[var3] = spawnStruct();
    self.stealth.force_visible[var3].end = var2;
  }

  self.stealth.force_visible[var3].ent = var0;
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
  var0 = 0.05;
  var1 = 0;

  while(isDefined(self.stealth.force_visible) && self.stealth.force_visible.size > 0) {
    var2 = gettime();
    var3 = [];
    var4 = getdvarfloat("ai_threatForcedRate") * var0;

    foreach(var8, var6 in self.stealth.force_visible) {
      if(var2 < var6.end && issentient(var6.ent) && !self cansee(var6.ent)) {
        var7 = self getthreatsight(var6.ent);

        if(isPlayer(var6.ent)) {
          thread threat_sight_player_sight_audio(var6.ent, 1);
        }

        if(var7 + var4 < getdvarfloat("ai_threatForcedMax")) {
          var7 += var4;
          self setthreatsight(var6.ent, var7);

          if(getdvarfloat("ai_threatForcedMax") >= 1 && var7 >= 1 && !var1) {
            self aieventlistenerevent("sight", var6.ent, var6.ent.origin);
            var1 = 1;
          } else if(var7 < 0.75 && var1) {
            var1 = 0;
          }
        }

        continue;
      }

      var3 = var8;
    }

    foreach(var8 in var3) {
      self.stealth.force_visible[var8] = undefined;
    }

    wait var0;
  }

  self.stealth.force_visible = undefined;
  self.stealth.force_visible_thread = undefined;
}

function threat_sight_player_entity_state_thread() {
  self endon("death");
  self endon("disconnect");
  self endon("death");
  level endon("threat_sight_disabled");
  var0 = 0;

  for(;;) {
    var1 = 0;
    var2 = 0;
    self.stealth.maxthreat = 0;
    self.stealth.maxalertlevel = -1;
    var3 = self getEye();
    var4 = cos(75);

    foreach(var6 in self.stealth.threat_entities) {
      if(!isalive(var6)) {
        continue;
      }

      var7 = var6 getentitynumber();
      self.stealth.maxalertlevel = max(self.stealth.maxalertlevel, var6.alertlevelint);

      if(getdvarint("OKQTSOMTKT", 1)) {
        if(var6[[var6.fnisinstealthcombat]]()) {
          continue;
        }

        var8 = var6 getthreatsight(self);
        var9 = var6 cansee(self);

        if(var9) {
          var0 = gettime();
        }

        if(var9 && isPlayer(self) && var8 > 0.09 && player_is_sprinting_at_me(var6)) {
          var6 aieventlistenerevent("sight", self, self.origin);
          var1 = 1;
        } else if(var8 >= 1) {
          if(!isDefined(self.stealth.threat_sighted[var7])) {
            thread threat_sight_sighted(var6);
          }

          var1 = 1;
        }

        var10 = self.stealth.maxthreat;
        self.stealth.maxthreat = max(self.stealth.maxthreat, var6 getthreatsight(self));

        if(self.stealth.maxthreat > 0.05) {
          if(!isDefined(self.stealth.maxthreat_enemy) || self.stealth.maxthreat != var10) {
            self.stealth.maxthreat_enemy = var6;
          }
        }
      }

      if(var6.alertlevel == "combat" || !var6.threatsight) {
        var2 = 1;
      }
    }

    var12 = !var2 && var0 > 0 && gettime() - var0 < 250;

    if(getdvarfloat("LONMKRQKOM") <= 0) {
      thread threat_sight_player_sight_audio(var12, self.stealth.maxthreat);
    }

    self.stealth.threat_visible = var12;
    wait 0.05;
  }
}

function player_is_sprinting_at_me(var0) {
  return self issprinting() && scripts\engine\utility::within_fov(self.origin, self.angles, var0.origin, cos(20));
}

function threat_sight_fake(var0, var1) {
  self notify("threat_sight_fake");
  self endon("threat_sight_fake");
  setsaveddvar("LONMKRQKOM", var1);
  setsaveddvar("LTQTQNSRQK", var0[0]);
  setsaveddvar("OKOMMPSLTN", var0[1]);
  setsaveddvar("LSLTTLKNNK", var0[2]);

  if(!isDefined(self.stealth.maxthreat)) {
    self.stealth.maxthreat = 0;
  }

  while(var1 > 0) {
    thread threat_sight_player_sight_audio(1, max(self.stealth.maxthreat, var1));
    wait 0.05;
  }

  thread threat_sight_player_sight_audio(0, max(self.stealth.maxthreat, var1));
}

function threat_sight_player_sight_audio(var0, var1, var2) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnthreatsightplayersightaudio)) {
    self thread[[level.stealth.fnthreatsightplayersightaudio]](var0, var1, var2);
    return;
  }
}