/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\stealth\threat_sight.gsc
************************************************/

#using script_3dc93ca9902a9cda;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\stealth\player;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace threat_sight;

function scalevolume(ent, vol) {}

#namespace stealth_threat_sight;

function private autoexec __init__system__() {
  system::register(#"stealth_threat_sight", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  register_clientfields();
  level.var_53ad6e22 = [];
  util::init_dvar("ai_threatForcedRate", 0.4, &function_4c75a19);
  util::init_dvar("ai_threatForcedMax", 0.5, &function_4c75a19);
  util::init_dvar("ai_threatsight", 0, &function_4c75a19);
  util::init_dvar("ai_threatForcedRate", 0, &function_4c75a19);
  util::init_dvar("ai_threatsightFakeThreat", 0, &function_4c75a19);
  util::init_dvar("ai_threatsightFakeX", 0, &function_4c75a19);
  util::init_dvar("ai_threatsightFakeY", 0, &function_4c75a19);
  util::init_dvar("ai_threatsightFakeZ", 0, &function_4c75a19);
  util::init_dvar("ai_threatUseDisplay", 0, &function_4c75a19);
}

function private register_clientfields() {
  clientfield::register("actor", "threat_sight", 1, 6, "int");
  clientfield::register("actor", "threat_state", 1, 2, "int");
}

function private function_4c75a19(dvar) {
  level.var_53ad6e22[dvar.name] = dvar.value;
}

function threat_sight_set_enabled(enabled) {
  assert(isDefined(level.stealth));
  wasenabled = isDefined(level.stealth.threat_sight_enabled) && level.stealth.threat_sight_enabled;
  level.stealth.threat_sight_enabled = enabled;
  threat_sight_set_dvar(enabled);

  if(!enabled && wasenabled) {
    level notify(#"hash_34d443ce908d0498");

    foreach(player in getplayers()) {
      player.stealth.threat_thread = undefined;
    }
  } else if(enabled && !wasenabled) {
    level notify(#"threat_sight_enabled");
  }

  allai = getactorarray();

  foreach(guy in allai) {
    if(isalive(guy) && isDefined(guy.stealth) && isDefined(guy.stealth.threat_sight_state)) {
      guy threat_sight_set_state(guy.stealth.threat_sight_state);
    }
  }
}

function threat_sight_set_dvar(enabled) {
  if(enabled && (!isDefined(level.stealth.threat_sight_enabled) || !level.stealth.threat_sight_enabled)) {
    return;
  }

  setsaveddvar(#"ai_threatsight", enabled);
  level thread threat_sight_set_dvar_display(enabled);
}

function threat_sight_set_dvar_display(enabled) {
  self notify(#"threat_sight_set_dvar_display");
  self endon(#"threat_sight_set_dvar_display");

  if(!enabled) {
    wait 1;
  }

  if(level.var_53ad6e22[# "ai_threatusedisplay"]) {
    setsaveddvar(#"hash_7bf40e4b6a830d11", enabled);
  }

  setDvar(#"hash_28758912434b7866", enabled);
}

function threat_sight_enabled() {
  if(!level.var_53ad6e22[# "ai_threatsight"]) {
    return false;
  }

  if(self == level) {
    return (isDefined(level.stealth.threat_sight_enabled) && level.stealth.threat_sight_enabled);
  }

  return isDefined(self.threatsight) && self.threatsight;
}

function threat_sight_set_state(statename) {
  if(isDefined(self.stealth)) {
    self.stealth.threat_sight_state = statename;
  }

  if(!isDefined(level.stealth.threat_sight_enabled) || !level.stealth.threat_sight_enabled) {
    if(!is_true(self.threat_sight_immediate_thread)) {
      self thread threat_sight_immediate_thread();
      self.threat_sight_immediate_thread = 1;
    }

    return;
  } else if(is_true(self.threat_sight_immediate_thread)) {
    self notify(#"threat_sight_immediate_thread");
    self.threat_sight_immediate_thread = undefined;
  }

  switch (statename) {
    case # "hidden":
      self.threatsight = 1;
      self.stealth.threat_sight_count = undefined;
      self.stealth.threat_sight_lost = undefined;
      break;
    case # "investigate":
      self.threatsight = 1;
      break;
    case # "hash_5689f41e8c0ad00":
    case # "combat_hunt":
      self.threatsight = 1;
      break;
    case # "blind":
      break;
    case # "spotted":
      self.threatsight = 0;
      break;
    case # "death":
      self.threatsight = 0;
      break;
    default:

      iprintlnbold("<dev string:x38>" + statename + "<dev string:x5e>");

      break;
  }

  foreach(player in getplayers()) {
    if(isDefined(player)) {
      player threat_sight_player_entity_state_set(self, statename);
    }
  }

  if(statename != "death") {
    self threat_sight_set_state_parameters(statename);
  }

  if(self.threatsight) {
    self thread function_3a739b35();
  }
}

function threat_sight_set_state_parameters(statename) {
  assert(isDefined(level.stealth));
  assert(isDefined(level.stealth.fnthreatsightsetstateparameters));
  self[[level.stealth.fnthreatsightsetstateparameters]](statename);
}

function private function_eefd0bb3(str_notify) {
  self clientfield::set("threat_sight", 0);
  self clientfield::set("threat_state", 0);
}

function function_60514e0b() {
  self notify(#"hash_247b691774e7a2e2");
}

function private function_3a739b35() {
  self notify(#"hash_3b836f1c1e601c4d");
  self endoncallback(&function_eefd0bb3, #"hash_3b836f1c1e601c4d", #"hash_247b691774e7a2e2", #"death");
  var_403d799 = 0;

  while(true) {
    waitframe(1);

    if(!self namespace_979752dc::function_b60a878a()) {
      self clientfield::set("threat_sight", 0);
      self clientfield::set("threat_state", 0);
      continue;
    }

    if(level flag::get("stealth_spotted") && level flag::get("stealth_meter_combat_alerted")) {
      self clientfield::set("threat_sight", 0);
      self clientfield::set("threat_state", 0);
      continue;
    }

    if(getplayers().size > 0) {
      player = getplayers()[0];
      threat_sight = self getthreatsight(player);
      var_97c4563c = 0;

      if(self.awarenesslevelcurrent === "combat") {
        var_97c4563c = 3;
        level flag::set("stealth_meter_combat_alerted");
      } else if(self.stealth.bsmstate === 2) {
        var_97c4563c = 2;
      } else if(self.awarenesslevelcurrent !== "unaware") {
        if(self namespace_979752dc::function_d58e1c1c() && self.awarenesslevelcurrent == "high_alert" && threat_sight > 0) {
          threat_sight = 1;
        }

        if(threat_sight >= 1) {
          var_97c4563c = 1;
        }
      }

      var_91b6ad45 = int(threat_sight * ((1 << 6) - 1));

      if((var_97c4563c == 1 || var_97c4563c == 2) && var_91b6ad45 == 0) {
        var_403d799 += float(function_60d95f53()) / 1000;

        if(var_403d799 > 1) {
          var_97c4563c = 0;
        }
      } else {
        var_403d799 = 0;
      }

      self clientfield::set("threat_sight", var_91b6ad45);
      self clientfield::set("threat_state", var_97c4563c);
    }
  }
}

function threat_sight_immediate_thread() {
  self notify(#"threat_sight_immediate_thread");
  self endon(#"threat_sight_immediate_thread", #"death");
  level endon(#"threat_sight_enabled");

  while(true) {
    level flag::wait_till("stealth_enabled");
    level flag::wait_till_clear("stealth_spotted");
    wait randomfloatrange(0.4, 0.6);

    foreach(player in getplayers()) {
      if(isDefined(player.ignore_stealth_sight)) {
        continue;
      }

      if(player.ignoreme) {
        continue;
      }

      if(self cansee(player)) {
        self function_a3fcf9e0("sight", player, player.origin);
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
  }
}

function threat_sight_player_entity_state_set(ai, statename) {
  if(!isDefined(self.stealth)) {
    self thread stealth_player::main();
  }

  self threat_sight_player_init();
  entid = ai getentitynumber();

  switch (statename) {
    case # "hidden":
      self.stealth.threat_sighted[entid] = undefined;
      break;
    case # "combat_hunt":
      ai setthreatsight(self, 0);
      break;
    case # "investigate":
      break;
    case # "death":
      ai setthreatsight(self, 0);
      break;
  }

  switch (statename) {
    case # "death":
      self.stealth.threat_entities[entid] = undefined;
      self.stealth.threat_sighted[entid] = undefined;
      break;
    default:
      self.stealth.threat_entities[entid] = ai;
      break;
  }

  if(!isDefined(self.stealth.threat_thread)) {
    self.stealth.threat_thread = 1;
    self thread threat_sight_player_entity_state_thread();
  }
}

function function_36a6a90() {
  return is_true(self.stealth.var_56d82ea8);
}

function function_79fc894b(player) {
  if(self namespace_979752dc::function_a54113fb()) {
    snd::play("uin_stealth_alert", [self, "j_head"]);
  }

  self.stealth.var_56d82ea8 = 1;
  self threat_sight_sighted(player);
}

function function_ee9635fa(player) {
  if(self namespace_979752dc::function_a54113fb()) {
    snd::play("uin_stealth_grace", [self, "j_head"]);
  }

  self threat_sight_sighted(player);
}

function function_740f4859(player) {
  if(self namespace_979752dc::function_a54113fb()) {
    snd::play("uin_stealth_spotted", [self, "j_head"]);
  }

  self threat_sight_sighted(player);
}

function threat_sight_sighted(player) {
  self endon(#"death", #"stealth_idle");
  player endon(#"death");
  assert(isDefined(player.stealth));
  assert(isDefined(player.stealth.threat_sighted));
  entid = self getentitynumber();

  if(self[[self.fnisinstealthhunt]]()) {
    self getenemyinfo(player);
    self function_a3fcf9e0("combat", player, player.origin);
    return;
  }

  player.stealth.threat_sighted[entid] = self;
  self function_a3fcf9e0("sight", player, player.origin);

  if(!isDefined(self.stealth.threat_sight_count)) {
    self.stealth.threat_sight_count = 0;
  } else {
    self.stealth.threat_sight_count++;
  }

  waittime = self namespace_979752dc::alert_delay_distance_time(player);
  waittime /= pow(2, self.stealth.threat_sight_count);
  waittime *= 1000;
  curtime = gettime();
  self.stealth.reactendtime = curtime + waittime;
  starttime = curtime;
  reactendtime = curtime + waittime;

  while(gettime() < reactendtime) {
    if(is_true(self.stealth.blind) || !isDefined(self.stealth.threat_sight_count)) {
      break;
    }

    waittime = self namespace_979752dc::alert_delay_distance_time(player);
    waittime /= pow(2, self.stealth.threat_sight_count);
    waittime *= 1000;

    if(starttime + waittime < reactendtime) {
      reactendtime = starttime + waittime;
    }

    waitframe(1);
  }

  self thread threat_sight_sighted_wait_lost(player);
}

function threat_sight_sighted_wait_lost(player) {
  var_4897dbc7 = player getentitynumber();
  self notify("threat_sight_sighted_wait_lost_" + var_4897dbc7);
  self endon("threat_sight_sighted_wait_lost_" + var_4897dbc7, #"death");
  player endon(#"death");
  entid = self getentitynumber();
  player.stealth.threat_sighted[entid] = undefined;

  while(true) {
    self.stealth.threat_sight_lost = self getthreatsight(player) < 0.75;

    if(self.stealth.threat_sight_lost) {
      return;
    }

    wait 0.05;
  }
}

function threat_sight_force_visible(othersentient, durationseconds) {
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
  self thread threat_sight_force_visible_thread();
}

function threat_sight_force_visible_thread() {
  if(is_true(self.stealth.force_visible_thread)) {
    return;
  }

  self notify(#"threat_sight_force_visible_thread");
  self endon(#"threat_sight_force_visible_thread", #"death");
  self.stealth.force_visible_thread = 1;
  waittime = 0.05;
  notified = 0;

  while(isDefined(self.stealth.force_visible) && self.stealth.force_visible.size > 0) {
    now = gettime();
    remove = [];
    delta = level.var_53ad6e22[# "ai_threatforcedrate"] * waittime;

    foreach(key, forcedvis in self.stealth.force_visible) {
      if(now < forcedvis.end && issentient(forcedvis.ent) && !self cansee(forcedvis.ent)) {
        newthreat = self getthreatsight(forcedvis.ent);

        if(isPlayer(forcedvis.ent)) {
          forcedvis.ent thread threat_sight_player_sight_audio(1, max(forcedvis.ent.stealth.maxthreat, newthreat));
        }

        if(newthreat + delta < level.var_53ad6e22[# "ai_threatforcedmax"]) {
          newthreat += delta;
          self setthreatsight(forcedvis.ent, newthreat);

          if(level.var_53ad6e22[# "ai_threatforcedmax"] >= 1 && newthreat >= 1 && !notified) {
            self function_a3fcf9e0("sight", forcedvis.ent, forcedvis.ent.origin);
            notified = 1;
          } else if(newthreat < 0.75 && notified) {
            notified = 0;
          }
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

function function_7af4fa05(entity) {
  self setthreatsight(entity, 0.05);
}

function threat_sight_player_entity_state_thread() {
  self endon(#"death");
  level endon(#"hash_34d443ce908d0498");
  var_94603cb7 = 0;

  while(true) {
    var_6330dd7b = 0;
    self.stealth.maxthreat = 0;
    self.stealth.maxalertlevel = -1;
    playereye = self getplayercamerapos();
    var_2efc79ea = 0.2588;

    foreach(entity in self.stealth.threat_entities) {
      if(!isalive(entity)) {
        continue;
      }

      if(is_true(entity.in_melee_death)) {
        continue;
      }

      entid = entity getentitynumber();
      self.stealth.maxalertlevel = max(self.stealth.maxalertlevel, entity.alertlevelint);

      if(level.var_53ad6e22[# "ai_threatsight"]) {
        if(!isDefined(entity.fnisinstealthcombat) || entity[[entity.fnisinstealthcombat]]()) {
          continue;
        }

        var_17c874ba = entity getthreatsight(self);
        var_3f0097e8 = isDefined(entity.stealth.investigateevent) && entity.stealth.investigateevent.typeorig == "sight";
        var_566de12 = entity cansee(self);

        if(var_566de12) {
          var_94603cb7 = gettime();
        }

        if(var_566de12 && isPlayer(self) && var_17c874ba > 0.09 && self player_is_sprinting_at_me(entity)) {
          entity function_a3fcf9e0("sight", self, self.origin);
        } else if(!isDefined(entity.stealth.investigateevent) && !is_true(entity.var_c5553760) && !entity function_36a6a90() && var_17c874ba >= 0.5) {
          if(!isDefined(self.stealth.threat_sighted[entid])) {
            entity thread function_79fc894b(self);
          }
        } else if(var_17c874ba >= 1) {
          if(entity namespace_979752dc::function_d58e1c1c() && entity.awarenesslevelcurrent != "high_alert") {
            entity thread function_ee9635fa(self);
          } else if(!isDefined(self.stealth.threat_sighted[entid])) {
            entity thread function_740f4859(self);
          }
        } else if(var_3f0097e8 && entity namespace_979752dc::function_d58e1c1c() && entity.alertlevel == "high_alert") {
          var_751fc2b7 = entity namespace_979752dc::function_196ad164();

          if(var_17c874ba > 0) {
            if(!var_751fc2b7) {
              entity namespace_979752dc::function_3249d5ff();
            }
          } else if(var_751fc2b7) {
            entity namespace_979752dc::function_64608a78();
          }
        }

        var_8735c97f = self.stealth.maxthreat;
        self.stealth.maxthreat = max(self.stealth.maxthreat, entity getthreatsight(self));

        if(self.stealth.maxthreat > 0.05) {
          if(!isDefined(self.stealth.maxthreat_enemy) || self.stealth.maxthreat !== var_8735c97f) {
            self.stealth.maxthreat_enemy = entity;
          }
        }
      }

      if(entity.alertlevel == "combat" || !entity.threatsight) {
        var_6330dd7b = 1;
      }
    }

    anycansee = !var_6330dd7b && var_94603cb7 > 0 && gettime() - var_94603cb7 < 250;

    if(level.var_53ad6e22[# "ai_threatsightfakethreat"] <= 0) {
      self thread threat_sight_player_sight_audio(anycansee, self.stealth.maxthreat);
    }

    self.stealth.threat_visible = anycansee;
    wait 0.05;
  }
}

function player_is_sprinting_at_me(ai) {
  if(!self issprinting()) {
    return false;
  }

  if(isDefined(level.stealth.var_6fd6463b)) {
    distancesq = distancesquared(self.origin, ai.origin);

    if(distancesq > level.stealth.var_6fd6463b) {
      return false;
    }
  }

  return util::within_fov(self.origin, self.angles, ai.origin, 0.93969);
}

function threat_sight_fake(origin, amount) {
  self notify(#"threat_sight_fake");
  self endon(#"threat_sight_fake");
  setsaveddvar(#"ai_threatsightfakethreat", amount);
  setsaveddvar(#"ai_threatsightfakex", origin[0]);
  setsaveddvar(#"ai_threatsightfakey", origin[1]);
  setsaveddvar(#"ai_threatsightfakez", origin[2]);

  if(!isDefined(self.stealth.maxthreat)) {
    self.stealth.maxthreat = 0;
  }

  while(amount > 0) {
    self thread threat_sight_player_sight_audio(1, max(self.stealth.maxthreat, amount));
    wait 0.05;
  }

  self thread threat_sight_player_sight_audio(0, max(self.stealth.maxthreat, amount));
}

function threat_sight_player_sight_audio(anycansee, maxthreat, var_2107b994) {
  if(isDefined(level.stealth) && isDefined(level.stealth.fnthreatsightplayersightaudio)) {
    self thread[[level.stealth.fnthreatsightplayersightaudio]](anycansee, maxthreat, var_2107b994);
  }
}