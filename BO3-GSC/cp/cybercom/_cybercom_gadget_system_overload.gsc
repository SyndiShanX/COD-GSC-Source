/************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_system_overload.gsc
************************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_challenges;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using_animtree("generic");
#namespace cybercom_gadget_system_overload;

function init() {}

function main() {
  cybercom_gadget::registerability(0, 1);
  level.cybercom.system_overload = spawnStruct();
  level.cybercom.system_overload._is_flickering = &_is_flickering;
  level.cybercom.system_overload._on_flicker = &_on_flicker;
  level.cybercom.system_overload._on_give = &_on_give;
  level.cybercom.system_overload._on_take = &_on_take;
  level.cybercom.system_overload._on_connect = &_on_connect;
  level.cybercom.system_overload._on = &_on;
  level.cybercom.system_overload._off = &_off;
  level.cybercom.system_overload._is_primed = &_is_primed;
}

function _is_flickering(slot) {}

function _on_flicker(slot, weapon) {}

function _on_give(slot, weapon) {
  self.cybercom.var_110c156a = getdvarint("scr_system_overload_count", 3);
  self.cybercom.system_overload_lifetime = getdvarfloat("scr_system_overload_lifetime", 6.3) * 1000;
  if(self hascybercomability("cybercom_systemoverload") == 2) {
    self.cybercom.var_110c156a = getdvarint("scr_system_overload_upgraded_count", 5);
    self.cybercom.system_overload_lifetime = getdvarfloat("scr_system_overload_upgraded_lifetime", 6.3) * 1000;
  }
  self.cybercom.targetlockcb = &_get_valid_targets;
  self.cybercom.targetlockrequirementcb = &_lock_requirement;
  self thread cybercom::function_b5f4e597(weapon);
}

function _on_take(slot, weapon) {
  self _off(slot, weapon);
  self.cybercom.is_primed = undefined;
  self.cybercom.targetlockcb = undefined;
  self.cybercom.targetlockrequirementcb = undefined;
}

function _on_connect() {}

function _on(slot, weapon) {
  self thread _activate_system_overload(slot, weapon);
  self _off(slot, weapon);
}

function _off(slot, weapon) {
  self thread cybercom::weaponendlockwatcher(weapon);
  self.cybercom.is_primed = undefined;
  self notify("hash_8e37d611");
}

function _is_primed(slot, weapon) {
  if(!(isDefined(self.cybercom.is_primed) && self.cybercom.is_primed)) {
    assert(self.cybercom.activecybercomweapon == weapon);
    self notify("hash_eec19461");
    self thread cybercom::weaponlockwatcher(slot, weapon, self.cybercom.var_110c156a);
    self.cybercom.is_primed = 1;
  }
}

function private _lock_requirement(target) {
  if(!isDefined(target)) {
    return false;
  }
  if(target cybercom::cybercom_aicheckoptout("cybercom_systemoverload")) {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(isDefined(target.hijacked) && target.hijacked) {
    self cybercom::function_29bf9dee(target, 4);
    return false;
  }
  if(isDefined(target.is_disabled) && target.is_disabled) {
    self cybercom::function_29bf9dee(target, 6);
    return false;
  }
  if(isactor(target) && target cybercom::function_78525729() != "stand" && target cybercom::function_78525729() != "crouch") {
    return false;
  }
  if(isactor(target) && target.archetype != "robot") {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(!isactor(target) && !isvehicle(target)) {
    self cybercom::function_29bf9dee(target, 2);
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

function private _activate_system_overload(slot, weapon) {
  aborted = 0;
  fired = 0;
  foreach(item in self.cybercom.lock_targets) {
    if(isDefined(item.target) && (isDefined(item.inrange) && item.inrange)) {
      if(item.inrange == 1) {
        if(!cybercom::targetisvalid(item.target, weapon)) {
          continue;
        }
        self thread challenges::function_96ed590f("cybercom_uses_control");
        item.target thread system_overload(self, undefined, weapon);
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
  if(fired && isplayer(self)) {
    itemindex = getitemindexfromref("cybercom_systemoverload");
    if(isDefined(itemindex)) {
      self adddstat("ItemStats", itemindex, "stats", "assists", "statValue", fired);
      self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
    }
  }
}

function private _system_overload_vehicle(attacker, weapon) {
  if(isDefined(self.var_7c04bee3) && gettime() < self.var_7c04bee3) {
    return;
  }
  self clientfield::set("cybercom_sysoverload", 1);
  self stopsounds();
  damage = 5;
  if(isDefined(self.archetype)) {
    if(self.archetype == "wasp") {
      damage = 25;
    }
  }
  self dodamage(damage, self.origin, attacker, undefined, "none", "MOD_GRENADE_SPLASH", 0, getweapon("emp_grenade"), -1, 1);
  self.var_7c04bee3 = gettime() + (getdvarint("scr_system_overload_vehicle_cooldown_seconds", 5) * 1000);
}

function ai_activatesystemoverload(target, var_9bc2efcb = 1, disabletimemsec) {
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
    self animscripted("ai_cybercom_anim", self.origin, self.angles, ("ai_base_rifle_" + type) + "_exposed_cybercom_activate");
    self waittillmatch("ai_cybercom_anim");
  }
  weapon = getweapon("gadget_system_overload");
  foreach(guy in validtargets) {
    if(!cybercom::targetisvalid(guy, weapon)) {
      continue;
    }
    guy thread system_overload(self, disabletimemsec);
    wait(0.05);
  }
}

function system_overload(attacker, disabletimemsec, weapon = getweapon("gadget_system_overload"), checkvalid = 1) {
  self endon("death");
  self notify("hash_f8c5dd60", weapon, attacker);
  if(isvehicle(self)) {
    self thread _system_overload_vehicle(attacker, weapon);
    return;
  }
  if(!cybercom::function_76e3026d(self)) {
    self kill(self.origin, (isDefined(attacker) ? attacker : undefined), undefined, weapon);
    return;
  }
  if(self cybercom::function_421746e0()) {
    self kill(self.origin, (isDefined(attacker) ? attacker : undefined), undefined, weapon);
    return;
  }
  self.is_disabled = 1;
  if(isDefined(disabletimemsec)) {
    disabletime = disabletimemsec;
  } else {
    if(isDefined(attacker.cybercom) && isDefined(attacker.cybercom.system_overload_lifetime)) {
      disabletime = attacker.cybercom.system_overload_lifetime;
    } else {
      disabletime = getdvarfloat("scr_system_overload_lifetime", 6.3) * 1000;
    }
  }
  self clientfield::set("cybercom_sysoverload", 1);
  wait(randomfloatrange(0, 0.75));
  disablefor = (gettime() + disabletime) + randomint(3000);
  type = self cybercom::function_5e3d3aa();
  var_c60a5dd5 = type == "crc";
  var_fea6d69a = 0;
  var_243ca3e3 = self.pathgoalpos;
  if(self ai::has_behavior_attribute("move_mode")) {
    var_fea6d69a = self ai::get_behavior_attribute("move_mode") == "marching";
  }
  self thread function_53cfe88a();
  self orientmode("face default");
  self ai::set_behavior_attribute("robot_lights", 1);
  self animscripted("shutdown_anim", self.origin, self.angles, ("ai_robot_base_" + type) + "_shutdown", "normal", % generic::root, 1, 0.2);
  self thread cybercom::stopanimscriptedonnotify("damage_pain", "shutdown_anim", 1, attacker, weapon);
  self thread cybercom::stopanimscriptedonnotify("notify_melee_damage", "shutdown_anim", 1, attacker, weapon);
  self thread cybercom::stopanimscriptedonnotify("breakout_sysoverload_loop", "shutdown_anim", 0, attacker, weapon);
  self waittillmatch("shutdown_anim");
  waittillframeend();
  self ai::set_behavior_attribute("robot_lights", 2);
  self.ignoreall = 1;
  while(gettime() < disablefor) {
    if(var_c60a5dd5) {
      blackboard::setblackboardattribute(self, "_stance", "crouch");
    }
    self dodamage(2, self.origin, (isDefined(attacker) ? attacker : undefined), undefined, "none", "MOD_UNKNOWN", 0, weapon, -1, 1);
    self waittillmatch("bhtn_action_terminate");
  }
  if(isalive(self) && !self isragdoll()) {
    self ai::set_behavior_attribute("robot_lights", 0);
    self.ignoreall = 0;
    self clientfield::set("cybercom_sysoverload", 2);
    self animscripted("restart_anim", self.origin, self.angles, ("ai_robot_base_" + type) + "_shutdown_2_alert");
    self thread cybercom::stopanimscriptedonnotify("damage_pain", "restart_anim", 1, attacker, weapon);
    self thread cybercom::stopanimscriptedonnotify("notify_melee_damage", "restart_anim", 1, attacker, weapon);
    self waittillmatch("restart_anim");
    if(var_c60a5dd5) {
      blackboard::setblackboardattribute(self, "_stance", "crouch");
    }
    if(var_fea6d69a) {
      self ai::set_behavior_attribute("move_mode", "marching");
    }
    if(isDefined(var_243ca3e3)) {
      self useposition(var_243ca3e3);
      self clearpath();
    }
    self.is_disabled = undefined;
  }
}

function function_53cfe88a() {
  self endon("death");
  wait(getdvarfloat("scr_system_overload_loop_time", 5.9));
  self notify("hash_355afb47");
}