/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\stealth_actor.gsc
*************************************************/

#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\stealth;
#using scripts\shared\stealth_aware;
#using scripts\shared\stealth_behavior;
#using scripts\shared\stealth_debug;
#using scripts\shared\stealth_event;
#using scripts\shared\stealth_status;
#using scripts\shared\stealth_tagging;
#using scripts\shared\stealth_vo;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace stealth_actor;

function init() {
  assert(isactor(self));
  if(!(isDefined(self.script_stealth) && self.script_stealth) && (!(isDefined(self.var_64f4c3f) && self.var_64f4c3f)) && (!(isDefined(self.script_stealth_dontseek) && self.script_stealth_dontseek))) {
    return;
  }
  if(isDefined(self.stealth)) {
    return;
  }
  if(!isDefined(self.stealth)) {
    self.stealth = spawnStruct();
  }
  self.stealth.enabled_actor = 1;
  self function_a860a2eb();
  self stealth_status::init();
  self stealth_aware::init();
  self stealth_event::init();
  self stealth_tagging::init();
  self stealth_vo::init();
  self.overrideactordamage = &function_ebcb7adc;
  self stealth_debug::init_debug();
  if(isDefined(self.var_64f4c3f) && self.var_64f4c3f || (isDefined(self.script_stealth_dontseek) && self.script_stealth_dontseek)) {
    self thread function_39fb9593();
  }
}

function stop() {
  if(self stealth_aware::enabled()) {
    self stealth_aware::set_awareness("combat");
    self.stealth.investigating = undefined;
    foreach(player in level.activeplayers) {
      self setignoreent(player, 0);
    }
    self stealth_status::function_180adb28();
  }
}

function reset() {
  if(self stealth_aware::enabled()) {
    self stealth_aware::set_awareness("unaware");
  }
}

function enabled() {
  return isDefined(self.stealth) && isDefined(self.stealth.enabled_actor);
}

function function_a860a2eb() {
  entnum = self getentitynumber();
  if(isDefined(self.stealth) && !isDefined(self.stealth.var_fd87ae1c) && (!isDefined(self.___archetypeonanimscriptedcallback) || self.___archetypeonanimscriptedcallback != (&function_a880fdea))) {
    self.stealth.var_fd87ae1c = self.___archetypeonanimscriptedcallback;
  }
  self.___archetypeonanimscriptedcallback = &function_a880fdea;
  switch (entnum % 4) {
    case 1: {
      blackboard::setblackboardattribute(self, "_context2", "v2");
      break;
    }
    case 2: {
      blackboard::setblackboardattribute(self, "_context2", "v3");
      break;
    }
    case 3: {
      blackboard::setblackboardattribute(self, "_context2", "v4");
      break;
    }
    default: {
      blackboard::setblackboardattribute(self, "_context2", "v1");
      break;
    }
  }
}

function function_a880fdea(entity) {
  if(isDefined(entity.stealth) && isDefined(entity.stealth.var_fd87ae1c)) {
    [[entity.stealth.var_fd87ae1c]](entity);
  }
  entity function_a860a2eb();
}

function function_ebcb7adc(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(self.awarenesslevelcurrent != "combat" && idamage > 10) {
    myeye = self getEye();
    if(isPlayer(einflictor) && isDefined(vpoint) && distancesquared(vpoint, myeye) < 100) {
      return self.health + 1;
    }
  }
  return idamage;
}

function function_39fb9593() {
  self notify("hash_39fb9593");
  self endon("hash_39fb9593");
  self endon("death");
  self.var_75a707ea = 1;
  if(!(isDefined(self.script_stealth_dontseek) && self.script_stealth_dontseek)) {
    self function_77ae41ed(1);
    if(self ai::has_behavior_attribute("sprint")) {
      self ai::set_behavior_attribute("sprint", 1);
    }
    if(self ai::has_behavior_attribute("traversals")) {
      self ai::set_behavior_attribute("traversals", "procedural");
    }
  }
  self thread function_8be8b843();
  if(level flag::get("stealth_discovered") && getdvarint("stealth_no_return")) {
    wait(0.05);
    self stealth::stop();
    return;
  }
  wait(1);
  self thread function_517ba9d2();
  self thread function_56e538df();
  while(true) {
    self waittill("hash_3dce0f1d", str_awareness);
    if(!self enabled() || !isDefined(level.stealth) || !isDefined(level.stealth.seek)) {
      return;
    }
    if(str_awareness != "combat") {
      self notify("investigate", self.origin, undefined, "infinite");
    } else if(str_awareness == "combat") {
      foreach(combatant in level.stealth.seek) {
        stealth_aware::enter_combat_with(combatant);
      }
      self stealth_behavior::investigate_stop();
    }
  }
}

function function_8be8b843() {
  self endon("hash_39fb9593");
  self endon("death");
  while(true) {
    foreach(player in level.activeplayers) {
      self getperfectinfo(player, 1);
      if(self stealth_aware::enabled()) {
        self stealth_aware::enter_combat_with(player);
      }
    }
    self clearforcedgoal();
    self cleargoalvolume();
    wait(1);
  }
}

function function_517ba9d2() {
  self endon("hash_39fb9593");
  self endon("death");
  while(true) {
    self waittill("awareness", str_awareness);
    self notify("hash_3dce0f1d", str_awareness);
  }
}

function function_56e538df() {
  self endon("hash_39fb9593");
  self endon("death");
  while(true) {
    level flag::wait_till("stealth_combat");
    self notify("hash_3dce0f1d", "combat");
    level flag::wait_till_clear("stealth_combat");
  }
}

function function_1064f733() {
  self notify("hash_1064f733");
  self endon("hash_1064f733");
  self endon("death");
  if(isDefined(self.var_75a707ea) && self.var_75a707ea) {
    return;
  }
  if(isDefined(self.var_1064f733) && self.var_1064f733) {
    return;
  }
  self.var_1064f733 = 1;
  nosighttime = 0;
  wait(randomfloatrange(0.1, 3));
  while(true) {
    var_a21c667 = 0;
    foreach(player in level.activeplayers) {
      if(self cansee(player)) {
        nosighttime = 0;
        var_a21c667 = 1;
        break;
      }
    }
    if(!var_a21c667) {
      nosighttime = nosighttime + 1;
    }
    if(nosighttime >= 8) {
      foreach(player in level.activeplayers) {
        self getperfectinfo(player, 1);
      }
      self clearforcedgoal();
      self cleargoalvolume();
      self function_77ae41ed(1);
      if(self ai::has_behavior_attribute("sprint")) {
        self ai::set_behavior_attribute("sprint", 1);
      }
    } else {
      self function_77ae41ed(0);
      if(self ai::has_behavior_attribute("sprint")) {
        self ai::set_behavior_attribute("sprint", 0);
      }
    }
    wait(1);
  }
}

function function_77ae41ed(var_e0824a47) {
  if(var_e0824a47) {
    if(self ai::has_behavior_attribute("move_mode")) {
      if(self ai::has_behavior_attribute("can_become_rusher") && self ai::get_behavior_attribute("can_become_rusher")) {
        self ai::set_behavior_attribute("move_mode", "rusher");
      } else {
        self ai::set_behavior_attribute("move_mode", "rambo");
      }
    }
  } else if(self ai::has_behavior_attribute("move_mode")) {
    self ai::set_behavior_attribute("move_mode", "normal");
  }
}