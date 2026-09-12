/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\threat_sight.gsc
***********************************************/

function threat_sight_set_enabled(var_0) {
  var_1 = isDefined(level.stealth.threat_sight_enabled) && level.stealth.threat_sight_enabled;
  level.stealth.threat_sight_enabled = var_0;
  threat_sight_set_dvar(var_0);

  if(!var_0 && var_1) {
    level notify("threat_sight_disabled");

    foreach(var_3 in level.players) {
      var_3.stealth.threat_thread = undefined;
    }
  } else if(var_0 && !var_1) {
    level notify("threat_sight_enabled");
  }

  var_5 = getaiarray();

  foreach(var_7 in var_5) {
    if(isalive(var_7) && isDefined(var_7.stealth) && isDefined(var_7.stealth.threat_sight_state)) {
      threat_sight_set_state(var_7, var_7.stealth.threat_sight_state);
    }
  }
}

function threat_sight_set_dvar(var_0) {
  setdvarifuninitialized("ai_threatForcedRate", 0.4);
  setdvarifuninitialized("ai_threatForcedMax", 0.5);

  if(var_0 && (!isDefined(level.stealth.threat_sight_enabled) || !level.stealth.threat_sight_enabled)) {
    return;
  }

  setsaveddvar("ai_threatSight", var_0);
  thread threat_sight_set_dvar_display(level);
}

function threat_sight_set_dvar_display(var_0) {
  self notify("threat_sight_set_dvar_display");
  self endon("threat_sight_set_dvar_display");

  if(!var_0) {
    wait 1;
  }

  if(getdvarint("ai_threatUseDisplay", 0)) {
    setsaveddvar("ai_threatSightDisplay", var_0);
  }

  setDvar("scr_ai_threatsightaudio", var_0);
}

function threat_sight_enabled() {
  if(!getdvarint("ai_threatSight")) {
    return false;
  }

  if(self == level) {
    return (isDefined(level.stealth.threat_sight_enabled) && level.stealth.threat_sight_enabled);
  }

  return isDefined(self.threatsight) && self.threatsight;
}

function threat_sight_set_state(var_0) {
  if(isDefined(self.stealth)) {
    self.stealth.threat_sight_state = var_0;
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

  switch (var_0) {
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

  foreach(var_2 in level.players) {
    threat_sight_player_entity_state_set(var_2, self, var_0);
  }

  threat_sight_set_state_parameters(var_0);
}

function threat_sight_set_state_parameters(var_0) {
  self[[level.stealth.fnthreatsightsetstateparameters]](var_0);
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

    foreach(var_1 in level.players) {
      if(isDefined(var_1.ignore_stealth_sight)) {
        continue;
      }

      if(var_1.ignoreme) {
        continue;
      }

      if(self cansee(var_1)) {
        self aieventlistenerevent("sight", var_1, var_1.origin);
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

function threat_sight_player_entity_state_set(var_0, var_1) {
  threat_sight_player_init();
  var_2 = var_0 getentitynumber();

  switch (var_1) {
    case "hidden":
      self.stealth.threat_sighted[var_2] = undefined;
      break;
    case "combat_hunt":
      var_0 setthreatsight(self, 0);
      break;
    case "investigate":
      if(isDefined(var_0.enemy) && var_0.enemy == self) {
        var_0 setthreatsight(self, 1);
      }

      break;
    case "death":
      var_0 setthreatsight(self, 0);
      break;
  }

  switch (var_1) {
    case "death":
      self.stealth.threat_entities[var_2] = undefined;
      self.stealth.threat_sighted[var_2] = undefined;
      break;
    default:
      self.stealth.threat_entities[var_2] = var_0;
      break;
  }

  if(!isDefined(self.stealth.threat_thread)) {
    self.stealth.threat_thread = 1;
    thread threat_sight_player_entity_state_thread();
    return;
  }
}

function threat_sight_sighted(var_0) {
  self endon("death");
  self endon("stealth_idle");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_1 = self getentitynumber();

  if(self[[self.fnisinstealthhunt]]()) {
    self getenemyinfo(var_0);
    self aieventlistenerevent("combat", var_0, var_0.origin);
    return;
  }

  var_0.stealth.threat_sighted[var_1] = self;
  self aieventlistenerevent("sight", var_0, var_0.origin);
  var_2 = var_0 getentitynumber();

  if(!isDefined(self.stealth.threat_sight_count)) {
    self.stealth.threat_sight_count = [];
  }

  if(!isDefined(self.stealth.threat_sight_count[var_2])) {
    self.stealth.threat_sight_count[var_2] = 0;
  } else {
    self.stealth.threat_sight_count[var_2]++;
  }

  var_3 = scripts\stealth\utility::alert_delay_distance_time(var_0);
  var_3 /= pow(2, self.stealth.threat_sight_count[var_2]);
  var_3 *= 1000;
  var_4 = gettime();

  if(scripts\common\utility::issp()) {
    self.stealth.reactendtime = var_4 + var_3;
  }

  var_5 = var_4;
  var_6 = var_4 + var_3;

  while(gettime() < var_6) {
    if(istrue(self.stealth.blind) || !isDefined(self.stealth.threat_sight_count) || !isDefined(self.stealth.threat_sight_count[var_2])) {
      break;
    }

    var_3 = scripts\stealth\utility::alert_delay_distance_time(var_0);
    var_3 /= pow(2, self.stealth.threat_sight_count[var_2]);
    var_3 *= 1000;

    if(var_5 + var_3 < var_6) {
      var_6 = var_5 + var_3;
    }

    waitframe();
  }

  thread threat_sight_sighted_wait_lost(var_0);
}

function threat_sight_sighted_wait_lost(var_0) {
  var_1 = var_0 getentitynumber();
  self notify("threat_sight_sighted_wait_lost_" + var_1);
  self endon("threat_sight_sighted_wait_lost_" + var_1);
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_2 = self getentitynumber();
  var_0.stealth.threat_sighted[var_2] = undefined;

  for(;;) {
    self.stealth.threat_sight_lost[var_1] = self getthreatsight(var_0) < 0.75;

    if(self.stealth.threat_sight_lost[var_1]) {
      return;
    }

    wait 0.05;
  }
}

function threat_sight_force_visible(var_0, var_1) {
  var_2 = gettime() + int(1000 * var_1);
  var_3 = var_0 getentitynumber();

  if(!isDefined(self.stealth.force_visible)) {
    self.stealth.force_visible = [];
  }

  if(isDefined(self.stealth.force_visible[var_3])) {
    self.stealth.force_visible[var_3].end = max(self.stealth.force_visible[var_3].end, var_2);
  } else {
    self.stealth.force_visible[var_3] = spawnStruct();
    self.stealth.force_visible[var_3].end = var_2;
  }

  self.stealth.force_visible[var_3].ent = var_0;
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
  var_0 = 0.05;
  var_1 = 0;

  while(isDefined(self.stealth.force_visible) && self.stealth.force_visible.size > 0) {
    var_2 = gettime();
    var_3 = [];
    var_4 = getdvarfloat("ai_threatForcedRate") * var_0;

    foreach(var_8, var_6 in self.stealth.force_visible) {
      if(var_2 < var_6.end && issentient(var_6.ent) && !self cansee(var_6.ent)) {
        var_7 = self getthreatsight(var_6.ent);

        if(isPlayer(var_6.ent)) {
          thread threat_sight_player_sight_audio(var_6.ent, 1);
        }

        if(var_7 + var_4 < getdvarfloat("ai_threatForcedMax")) {
          var_7 += var_4;
          self setthreatsight(var_6.ent, var_7);

          if(getdvarfloat("ai_threatForcedMax") >= 1 && var_7 >= 1 && !var_1) {
            self aieventlistenerevent("sight", var_6.ent, var_6.ent.origin);
            var_1 = 1;
          } else if(var_7 < 0.75 && var_1) {
            var_1 = 0;
          }
        }

        continue;
      }

      var_3 = var_8;
    }

    foreach(var_8 in var_3) {
      self.stealth.force_visible[var_8] = undefined;
    }

    wait var_0;
  }

  self.stealth.force_visible = undefined;
  self.stealth.force_visible_thread = undefined;
}

function threat_sight_player_entity_state_thread() {
  self endon("death");
  self endon("disconnect");
  self endon("death");
  level endon("threat_sight_disabled");
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = 0;
    self.stealth.maxthreat = 0;
    self.stealth.maxalertlevel = -1;
    var_3 = self getEye();
    var_4 = cos(75);

    foreach(var_6 in self.stealth.threat_entities) {
      if(!isalive(var_6)) {
        continue;
      }

      var_7 = var_6 getentitynumber();
      self.stealth.maxalertlevel = max(self.stealth.maxalertlevel, var_6.alertlevelint);

      if(getdvarint("ai_threatSight", 1)) {
        if(var_6[[var_6.fnisinstealthcombat]]()) {
          continue;
        }

        var_8 = var_6 getthreatsight(self);
        var_9 = var_6 cansee(self);

        if(var_9) {
          var_0 = gettime();
        }

        if(var_9 && isPlayer(self) && var_8 > 0.09 && player_is_sprinting_at_me(var_6)) {
          var_6 aieventlistenerevent("sight", self, self.origin);
          var_1 = 1;
        } else if(var_8 >= 1) {
          if(!isDefined(self.stealth.threat_sighted[var_7])) {
            thread threat_sight_sighted(var_6);
          }

          var_1 = 1;
        }

        var_10 = self.stealth.maxthreat;
        self.stealth.maxthreat = max(self.stealth.maxthreat, var_6 getthreatsight(self));

        if(self.stealth.maxthreat > 0.05) {
          if(!isDefined(self.stealth.maxthreat_enemy) || self.stealth.maxthreat != var_10) {
            self.stealth.maxthreat_enemy = var_6;
          }
        }
      }

      if(var_6.alertlevel == "combat" || !var_6.threatsight) {
        var_2 = 1;
      }
    }

    var_12 = !var_2 && var_0 > 0 && gettime() - var_0 < 250;

    if(getdvarfloat("ai_threatSightFakeThreat") <= 0) {
      thread threat_sight_player_sight_audio(var_12, self.stealth.maxthreat);
    }

    self.stealth.threat_visible = var_12;
    wait 0.05;
  }
}

function player_is_sprinting_at_me(var_0) {
  return self issprinting() && scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, cos(20));
}

function threat_sight_fake(var_0, var_1) {
  self notify("threat_sight_fake");
  self endon("threat_sight_fake");
  setsaveddvar("ai_threatSightFakeThreat", var_1);
  setsaveddvar("ai_threatSightFakeX", var_0[0]);
  setsaveddvar("ai_threatSightFakeY", var_0[1]);
  setsaveddvar("ai_threatSightFakeZ", var_0[2]);

  if(!isDefined(self.stealth.maxthreat)) {
    self.stealth.maxthreat = 0;
  }

  while(var_1 > 0) {
    thread threat_sight_player_sight_audio(1, max(self.stealth.maxthreat, var_1));
    wait 0.05;
  }

  thread threat_sight_player_sight_audio(0, max(self.stealth.maxthreat, var_1));
}

function threat_sight_player_sight_audio(var_0, var_1, var_2) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnthreatsightplayersightaudio)) {
    self thread[[level.stealth.fnthreatsightplayersightaudio]](var_0, var_1, var_2);
    return;
  }
}