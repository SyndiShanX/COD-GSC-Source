/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\stealth_level.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\ai_sniper_shared;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\stealth;
#using scripts\shared\stealth_actor;
#using scripts\shared\stealth_aware;
#using scripts\shared\stealth_debug;
#using scripts\shared\stealth_player;
#using scripts\shared\stealth_vo;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace stealth_level;

function init() {
  assert(!isDefined(self.stealth));
  if(!isDefined(self.stealth)) {
    self.stealth = spawnStruct();
  }
  self.stealth.enabled_level = 1;
  self.stealth.enemies = [];
  self.stealth.awareness_index = [];
  self.stealth.awareness_index["unaware"] = 0;
  self.stealth.awareness_index["low_alert"] = 1;
  self.stealth.awareness_index["high_alert"] = 1;
  self.stealth.awareness_index["combat"] = 2;
  level flag::init("stealth_alert", 0);
  level flag::init("stealth_combat", 0);
  level flag::init("stealth_discovered", 0);
  init_parms();
  spawner::add_global_spawn_function("axis", &stealth::agent_init);
  self stealth_vo::init();
  self thread function_7bf2f7ba();
  self thread update_thread();
  self thread function_a3cf57bf();
  self thread function_f8b0594a();
  self thread stealth_music_thread();
  self thread function_945a718();
  self stealth_debug::init_debug();
  level.using_awareness = 1;
  setdvar("ai_stumbleSightRange", 200);
  setdvar("ai_awarenessenabled", 1);
  setdvar("stealth_display", 0);
  setdvar("stealth_audio", 1);
  if(getdvarstring("stealth_indicator") == "") {
    setdvar("stealth_indicator", 0);
  }
  setdvar("stealth_group_radius", 1000);
  setdvar("stealth_all_aware", 1);
  setdvar("stealth_no_return", 1);
  setdvar("stealth_events", "sentientevents_vengeance_default");
}

function stop() {
  spawner::remove_global_spawn_function("axis", &stealth::agent_init);
  level.using_awareness = 0;
  setdvar("ai_stumbleSightRange", 0);
  setdvar("ai_awarenessenabled", 0);
  if(isDefined(level.stealth.music_ent)) {
    foreach(ent in level.stealth.music_ent) {
      ent stoploopsound(1);
      ent util::deleteaftertime(1.5);
    }
    level.stealth.music_ent = undefined;
  }
}

function reset() {
  level flag::clear("stealth_alert");
  level flag::clear("stealth_combat");
  level flag::clear("stealth_discovered");
  self thread function_f8b0594a();
}

function enabled() {
  return isDefined(self.stealth) && isDefined(self.stealth.enabled_level);
}

function init_parms() {
  assert(self enabled());
  if(!isDefined(self.stealth.parm)) {
    self.stealth.parm = spawnStruct();
  }
  self.stealth.parm.awareness["unaware"] = spawnStruct();
  self.stealth.parm.awareness["low_alert"] = spawnStruct();
  self.stealth.parm.awareness["high_alert"] = spawnStruct();
  self.stealth.parm.awareness["combat"] = spawnStruct();
  vals = self.stealth.parm.awareness["unaware"];
  vals.fovcosine = cos(45);
  vals.fovcosinez = cos(10);
  vals.maxsightdist = 600;
  setstealthsight("unaware", 4, 0.5, 5, 100, 600, 0);
  vals = self.stealth.parm.awareness["low_alert"];
  vals.fovcosine = cos(60);
  vals.fovcosinez = cos(20);
  vals.maxsightdist = 800;
  setstealthsight("low_alert", 0, 0, 1, 100, 800, 0);
  vals = self.stealth.parm.awareness["high_alert"];
  vals.fovcosine = cos(60);
  vals.fovcosinez = cos(20);
  vals.maxsightdist = 1000;
  setstealthsight("high_alert", 16, 0.25, 4, 100, 1000, 0);
  vals = self.stealth.parm.awareness["combat"];
  vals.fovcosine = 0;
  vals.fovcosinez = 0;
  vals.maxsightdist = 8192;
  setstealthsight("combat", 32, 0.01, 0.01, 100, 1500, 1);
}

function get_parms(strawareness) {
  assert(isDefined(level.stealth));
  return level.stealth.parm.awareness[strawareness];
}

function function_7bf2f7ba() {
  array::thread_all(getEntArray("_stealth_shadow", "targetname"), &stealth_shadow_volumes);
  array::thread_all(getEntArray("stealth_shadow", "targetname"), &stealth_shadow_volumes);
}

function stealth_shadow_volumes() {
  self endon("death");
  while(true) {
    self waittill("trigger", other);
    if(!isalive(other)) {
      continue;
    }
    if(!isDefined(other.stealth) || (isDefined(other.stealth.in_shadow) && other.stealth.in_shadow)) {
      continue;
    }
    other thread function_9f3c4fa(self);
  }
}

function function_9f3c4fa(volume) {
  self endon("death");
  if(!isDefined(self.stealth)) {
    return;
  }
  self.stealth.in_shadow = 1;
  while(isDefined(volume) && self istouching(volume)) {
    wait(0.05);
  }
  self.stealth.in_shadow = 0;
}

function update_thread() {
  assert(self enabled());
  self endon("stop_stealth");
  while(true) {
    self update_arrays();
    sentientevents = getdvarstring("stealth_events");
    if(sentientevents != "" && (!isDefined(level.var_1e44252f) || level.var_1e44252f != sentientevents)) {
      loadsentienteventparameters(sentientevents);
    }
    level.var_1e44252f = sentientevents;
    wait(0.25);
  }
}

function update_arrays() {
  assert(self enabled());
  self.stealth.enemies["axis"] = [];
  self.stealth.enemies["allies"] = [];
  self.stealth.seek = [];
  playerlist = getplayers();
  ailist = getaiarray();
  foreach(player in playerlist) {
    if(!isDefined(player.stealth)) {
      player stealth::agent_init();
    }
    if(isDefined(player.ignoreme) && player.ignoreme) {
      continue;
    }
    if(player.team == "allies") {
      self.stealth.enemies["axis"][player getentitynumber()] = player;
    }
    player stealth_player::function_b9393d6c("high_alert");
    player.stealth.incombat = 0;
  }
  alertcount = 0;
  level.combatcount = 0;
  level.stealth.var_e7ad9c1f = 0;
  foreach(ai in ailist) {
    if(isDefined(ai.ignoreme) && ai.ignoreme) {
      continue;
    }
    entnum = ai getentitynumber();
    counted = 0;
    if(isalive(ai) && ai stealth_aware::enabled() && (!(isDefined(ai.silenced) && ai.silenced))) {
      var_96b139a9 = isactor(ai) && ai_sniper::is_firing(ai) && isDefined(ai.lase_ent) && isplayer(ai.lase_ent.lase_override);
      if(!(isDefined(ai.ignoreall) && ai.ignoreall) && ai stealth_aware::get_awareness() != "unaware") {
        alertcount = alertcount + 1;
      }
      if(ai stealth_aware::get_awareness() == "combat" || var_96b139a9) {
        if(var_96b139a9) {
          ai.stealth.aware_combat[ai.lase_ent.lase_override getentitynumber()] = ai.lase_ent.lase_override;
        }
        counted = 0;
        if(isDefined(ai.stealth.aware_combat)) {
          foreach(combatant in ai.stealth.aware_combat) {
            if(!isalive(combatant)) {
              continue;
            }
            var_146dd427 = combatant getentitynumber();
            if(!isDefined(self.stealth.seek[var_146dd427])) {
              self.stealth.seek[var_146dd427] = combatant;
            }
            if(isplayer(combatant)) {
              if(!counted && (!(isDefined(ai.ignoreall) && ai.ignoreall))) {
                level.combatcount = level.combatcount + 1;
                counted = 1;
              }
              combatant stealth_player::function_b9393d6c("combat");
              if(!combatant.stealth.incombat) {
                level.stealth.var_e7ad9c1f++;
              }
              combatant.stealth.incombat = 1;
            }
          }
        }
      }
    }
    if(ai.team == "allies") {
      self.stealth.enemies["axis"][entnum] = ai;
      continue;
    }
    if(ai.team == "axis") {
      self.stealth.enemies["allies"][entnum] = ai;
    }
  }
  if(alertcount > 0) {
    level flag::set("stealth_alert");
  } else {
    level flag::clear("stealth_alert");
  }
  if(level.combatcount > 0) {
    level flag::set("stealth_combat");
  } else {
    level flag::clear("stealth_combat");
  }
}

function function_a3cf57bf() {
  self endon("stop_stealth");
  grace_period = 6;
  while(true) {
    level flag::wait_till("stealth_combat");
    if(level.stealth.var_e7ad9c1f == 0) {
      wait(0.05);
      continue;
    }
    level.stealth.var_30d9fcc6 = 1;
    wait(grace_period);
    level.stealth.var_30d9fcc6 = 0;
    if(flag::get("stealth_combat")) {
      level flag::set("stealth_discovered");
      thread function_959a64c9();
    }
    level flag::wait_till_clear("stealth_combat");
    if(isDefined(level.combatcount)) {
      level.combatcount = 0;
    }
  }
}

function function_f8b0594a() {
  self notify("hash_f8b0594a");
  self endon("hash_f8b0594a");
  self endon("stop_stealth");
  while(true) {
    level flag::wait_till("stealth_alert");
    level flag::wait_till_clear("stealth_alert");
    wait(randomfloatrange(1.5, 3));
    var_c6d0ac06 = isDefined(level.stealth) && (isDefined(level.stealth.var_30d9fcc6) && level.stealth.var_30d9fcc6);
    while(isDefined(level.stealth) && (isDefined(level.stealth.var_30d9fcc6) && level.stealth.var_30d9fcc6)) {
      wait(0.05);
    }
    if(!level flag::get("stealth_alert") && !level flag::get("stealth_discovered") && !level flag::get("stealth_combat")) {
      foreach(player in level.activeplayers) {
        if(player stealth_player::enabled()) {
          if(var_c6d0ac06) {
            player stealth_vo::function_e3ae87b3("close_call");
            continue;
          }
          player stealth_vo::function_e3ae87b3("returning");
        }
      }
    }
    wait(randomfloatrange(1.5, 3));
  }
}

function function_959a64c9() {
  self notify("hash_959a64c9");
  self endon("hash_959a64c9");
  if(getdvarint("stealth_no_return")) {
    enemies = getaiteamarray("axis");
    foreach(enemy in enemies) {
      if(!isalive(enemy)) {
        continue;
      }
      if(isDefined(enemy.stealth)) {
        enemy notify("hash_959a64c9");
        enemy notify("alert", "combat", enemy.origin, undefined, "wake_all");
        enemy stealth::stop();
      }
      foreach(player in level.activeplayers) {
        enemy getperfectinfo(player, 1);
      }
      enemy stopanimscripted();
      if(isDefined(enemy.patroller) && enemy.patroller) {
        enemy ai::end_and_clean_patrol_behaviors();
      }
      enemy ai_sniper::actor_lase_stop();
      if(isactor(enemy)) {
        enemy thread stealth_actor::function_1064f733();
      }
      wait(0.25);
    }
  }
}

function stealth_music_thread() {
  self endon("stop_stealth");
  stealth::function_862e861f();
  while(true) {
    if(!level flag::get("stealth_discovered")) {
      if(level flag::get("stealth_combat")) {
        stealth::function_e0319e51("combat");
      } else {
        if(level flag::get("stealth_alert")) {
          stealth::function_e0319e51("high_alert");
        } else {
          stealth::function_e0319e51("unaware");
        }
      }
    }
    wait(0.05);
  }
}

function function_945a718() {
  wait(0.05);
  var_e3fe91b2 = struct::get_array("stealth_callout", "targetname");
  foreach(ent in var_e3fe91b2) {
    ent stealth_vo::function_4970c8b8(ent.script_parameters);
  }
  var_e3fe91b2 = struct::get_array("stealth_callout", "script_noteworthy");
  foreach(ent in var_e3fe91b2) {
    ent stealth_vo::function_4970c8b8(ent.script_parameters);
  }
  var_e3fe91b2 = getEntArray("stealth_callout", "targetname");
  foreach(ent in var_e3fe91b2) {
    ent stealth_vo::function_4970c8b8(ent.script_parameters);
  }
  var_e3fe91b2 = getEntArray("stealth_callout", "script_noteworthy");
  foreach(ent in var_e3fe91b2) {
    ent stealth_vo::function_4970c8b8(ent.script_parameters);
  }
}