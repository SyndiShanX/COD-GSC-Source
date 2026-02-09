/*************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_sensory_overload.gsc
*************************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_challenges;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using_animtree("generic");
#namespace cybercom_gadget_sensory_overload;

function init() {
  clientfield::register("actor", "sensory_overload", 1, 2, "int");
}

function main() {
  cybercom_gadget::registerability(2, 1);
  level._effect["sensory_disable_human"] = "electric/fx_ability_elec_sensory_ol_human";
  level._effect["sensory_disable_human_riotshield"] = "electric/fx_ability_elec_sensory_ol_human";
  level._effect["sensory_disable_warlord"] = "electric/fx_ability_elec_sensory_ol_human";
  level.cybercom.sensory_overload = spawnStruct();
  level.cybercom.sensory_overload._is_flickering = &_is_flickering;
  level.cybercom.sensory_overload._on_flicker = &_on_flicker;
  level.cybercom.sensory_overload._on_give = &_on_give;
  level.cybercom.sensory_overload._on_take = &_on_take;
  level.cybercom.sensory_overload._on_connect = &_on_connect;
  level.cybercom.sensory_overload._on = &_on;
  level.cybercom.sensory_overload._off = &_off;
  level.cybercom.sensory_overload._is_primed = &_is_primed;
}

function _is_flickering(slot) {}

function _on_flicker(slot, weapon) {}

function _on_give(slot, weapon) {
  self.cybercom.var_110c156a = getdvarint("scr_sensory_overload_count", 3);
  self.cybercom.var_bf39536d = getdvarint("scr_sensory_overload_loops", 2);
  if(self hascybercomability("cybercom_sensoryoverload") == 2) {
    self.cybercom.var_110c156a = getdvarint("scr_sensory_overload_upgraded_count", 5);
    self.cybercom.var_bf39536d = getdvarint("scr_sensory_overload_upgraded_loops", 2);
  }
  self.cybercom.targetlockcb = &_get_valid_targets;
  self.cybercom.targetlockrequirementcb = &_lock_requirement;
  self thread cybercom::function_b5f4e597(weapon);
  self cybercom::function_8257bcb3("base_rifle_stn", 8);
  self cybercom::function_8257bcb3("base_rifle_crc", 2);
  self cybercom::function_8257bcb3("fem_rifle_stn", 8);
  self cybercom::function_8257bcb3("fem_rifle_crc", 2);
}

function _on_take(slot, weapon) {
  self _off(slot, weapon);
  self.cybercom.targetlockcb = undefined;
  self.cybercom.targetlockrequirementcb = undefined;
}

function _on_connect() {}

function _on(slot, weapon) {
  self thread _activate_sensory_overload(slot, weapon);
  self _off(slot, weapon);
}

function _off(slot, weapon) {
  self thread cybercom::weaponendlockwatcher(weapon);
  self.cybercom.is_primed = undefined;
}

function _is_primed(slot, weapon) {
  if(!(isDefined(self.cybercom.is_primed) && self.cybercom.is_primed)) {
    assert(self.cybercom.activecybercomweapon == weapon);
    self thread cybercom::weaponlockwatcher(slot, weapon, self.cybercom.var_110c156a);
    self.cybercom.is_primed = 1;
  }
}

function private _lock_requirement(target) {
  if(target cybercom::cybercom_aicheckoptout("cybercom_sensoryoverload")) {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(isDefined(target.is_disabled) && target.is_disabled) {
    self cybercom::function_29bf9dee(target, 6);
    return false;
  }
  if(isvehicle(target) || !isDefined(target.archetype)) {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(target.archetype != "human" && target.archetype != "human_riotshield" && target.archetype != "warlord") {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(isactor(target) && target cybercom::function_78525729() != "stand" && target cybercom::function_78525729() != "crouch") {
    return false;
  }
  if(isactor(target) && !target isonground() && !target cybercom::function_421746e0()) {
    return false;
  }
  return true;
}

function private _get_valid_targets(weapon) {
  return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

function private _activate_sensory_overload(slot, weapon) {
  aborted = 0;
  fired = 0;
  foreach(item in self.cybercom.lock_targets) {
    if(isDefined(item.target) && (isDefined(item.inrange) && item.inrange)) {
      if(item.inrange == 1) {
        if(!cybercom::targetisvalid(item.target, weapon)) {
          continue;
        }
        self thread challenges::function_96ed590f("cybercom_uses_chaos");
        item.target thread sensory_overload(self);
        fired++;
        continue;
      }
      if(item.inrange == 2) {
        aborted++;
      }
    }
  }
  if(aborted && !fired) {
    self.cybercom.lock_targets = [];
    self cybercom::function_29bf9dee(undefined, 1, 0);
  }
  cybercom::function_adc40f11(weapon, fired);
  if(fired && isPlayer(self)) {
    itemindex = getitemindexfromref("cybercom_sensoryoverload");
    if(isDefined(itemindex)) {
      self adddstat("ItemStats", itemindex, "stats", "assists", "statValue", fired);
      self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
    }
  }
}

function ai_activatesensoryoverload(target, var_9bc2efcb = 1) {
  if(!isDefined(target)) {
    return;
  }
  if(self.archetype != "human") {
    return;
  }
  validtargets = [];
  if(isarray(target)) {
    foreach(guy in target) {
      if(!_lock_requirement(guy)) {
        continue;
      }
      validtargets[validtargets.size] = guy;
    }
  } else {
    if(!_lock_requirement(target)) {
      return;
    }
    validtargets[validtargets.size] = target;
  }
  if(isDefined(var_9bc2efcb) && var_9bc2efcb) {
    type = self cybercom::function_5e3d3aa();
    self orientmode("face default");
    self animscripted("ai_cybercom_anim", self.origin, self.angles, ("ai_base_rifle_" + type) + "_exposed_cybercom_activate", "normal", %generic::root, 1, 0.3);
    self waittillmatch("ai_cybercom_anim");
  }
  weapon = getweapon("gadget_sensory_overload");
  foreach(guy in validtargets) {
    if(!cybercom::targetisvalid(guy, weapon)) {
      continue;
    }
    guy thread sensory_overload(self);
    wait(0.05);
  }
}

function sensory_overload(attacker, var_7d4fd98c) {
  self endon("death");
  weapon = getweapon("gadget_sensory_overload");
  self notify("hash_f8c5dd60", weapon, attacker);
  if(isDefined(attacker.cybercom) && isDefined(attacker.cybercom.var_bf39536d)) {
    loops = attacker.cybercom.var_bf39536d;
  } else {
    loops = 1;
  }
  wait(randomfloatrange(0, 0.75));
  if(!attacker cybercom::targetisvalid(self, weapon)) {
    return;
  }
  if(self cybercom::function_421746e0()) {
    self kill(self.origin, (isDefined(attacker) ? attacker : undefined), undefined, weapon);
    return;
  }
  self orientmode("face default");
  self.is_disabled = 1;
  self.ignoreall = 1;
  if(isDefined(var_7d4fd98c)) {
    if(var_7d4fd98c == "cybercom_smokescreen") {
      self.var_d90f9ddb = 1;
    }
  }
  if(isPlayer(attacker) && attacker hascybercomability("cybercom_sensoryoverload") == 2) {
    self playSound("gdt_sensory_feedback_start");
    self playLoopSound("gdt_sensory_feedback_lp_upg", 0.5);
    self clientfield::set("sensory_overload", 2);
  } else {
    self playSound("gdt_sensory_feedback_start");
    self playLoopSound("gdt_sensory_feedback_lp", 0.5);
    self clientfield::set("sensory_overload", 1);
  }
  self notify("bhtn_action_notify", "reactSensory");
  if(self.archetype == "warlord") {
    self dodamage(2, self.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
    self waittillmatch("bhtn_action_terminate");
    self clientfield::set("sensory_overload", 0);
  } else {
    if(self.archetype == "human_riotshield") {
      while(loops) {
        self dodamage(2, self.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
        self waittillmatch("bhtn_action_terminate");
        loops--;
      }
      self clientfield::set("sensory_overload", 0);
    } else {
      assert(self.archetype == "");
      base = "base_rifle";
      if(isDefined(self.voiceprefix) && getsubstr(self.voiceprefix, 7) == "f") {
        base = "fem_rifle";
      }
      type = self cybercom::function_5e3d3aa();
      variant = attacker cybercom::getanimationvariant((base + "_") + type);
      self animscripted("intro_anim", self.origin, self.angles, (((("ai_" + base) + "_") + type) + "_exposed_sens_overload_react_intro") + variant, "normal", %generic::root, 1, 0.3);
      self thread cybercom::stopanimscriptedonnotify("damage_pain", "intro_anim", 1, attacker, weapon);
      self thread cybercom::stopanimscriptedonnotify("notify_melee_damage", "intro_anim", 1, attacker, weapon);
      self waittillmatch("intro_anim");
      function_58831b5a(loops, attacker, weapon, variant, base, type);
      if(isalive(self) && !self isragdoll()) {
        self clientfield::set("sensory_overload", 0);
        self animscripted("restart_anim", self.origin, self.angles, (((("ai_" + base) + "_") + type) + "_exposed_sens_overload_react_outro") + variant, "normal", %generic::root, 1, 0.3);
        self thread cybercom::stopanimscriptedonnotify("damage_pain", "restart_anim", 1, attacker, weapon);
        self thread cybercom::stopanimscriptedonnotify("notify_melee_damage", "restart_anim", 1, attacker, weapon);
        self waittillmatch("restart_anim");
      }
    }
  }
  self stoploopsound(0.75);
  self.is_disabled = undefined;
  self.ignoreall = 0;
  if(isDefined(var_7d4fd98c)) {
    if(var_7d4fd98c == "cybercom_smokescreen") {
      self.var_d90f9ddb = 0;
    }
  }
}

function function_58831b5a(loops, attacker, weapon, variant, base, type) {
  self endon("hash_8817762c");
  self thread function_53cfe88a();
  while(loops) {
    self function_e01b8059(attacker, weapon, variant, base, type);
    loops--;
  }
}

function function_e01b8059(attacker, weapon, variant, base, type) {
  self endon("death");
  self animscripted("sens_loop_anim", self.origin, self.angles, (((("ai_" + base) + "_") + type) + "_exposed_sens_overload_react_loop") + variant, "normal", %generic::body, 1, 0.2);
  self thread cybercom::stopanimscriptedonnotify("damage_pain", "sens_loop_anim", 1, attacker, weapon);
  self thread cybercom::stopanimscriptedonnotify("breakout_overload_loop", "sens_loop_anim", 0, attacker, weapon);
  self thread cybercom::stopanimscriptedonnotify("notify_melee_damage", "sens_loop_anim", 1, attacker, weapon);
  self waittillmatch("hash_3b87dc07");
}

function function_53cfe88a() {
  self endon("death");
  wait(getdvarfloat("scr_sensory_overload_loop_time", 4.7));
  self notify("hash_8817762c");
}