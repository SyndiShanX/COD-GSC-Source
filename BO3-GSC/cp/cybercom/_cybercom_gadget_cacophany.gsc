/******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_cacophany.gsc
******************************************************/

#using scripts\codescripts\struct;
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
#namespace namespace_6dcc04c7;

function init() {}

function main() {
  cybercom_gadget::registerability(2, 16);
  level.cybercom.cacophany = spawnStruct();
  level.cybercom.cacophany._is_flickering = & _is_flickering;
  level.cybercom.cacophany._on_flicker = & _on_flicker;
  level.cybercom.cacophany._on_give = & _on_give;
  level.cybercom.cacophany._on_take = & _on_take;
  level.cybercom.cacophany._on_connect = & _on_connect;
  level.cybercom.cacophany._on = & _on;
  level.cybercom.cacophany._off = & _off;
  level.cybercom.cacophany._is_primed = & _is_primed;
}

function _is_flickering(slot) {}

function _on_flicker(slot, weapon) {}

function _on_give(slot, weapon) {
  self.cybercom.var_110c156a = getdvarint("scr_cacophany_count", 4);
  self.cybercom.var_f72b478f = getdvarfloat("scr_cacophany_fov", 0.95);
  self.cybercom.var_23d4a73a = getdvarfloat("scr_cacophany_lock_radius", 330);
  if(self hascybercomability("cybercom_cacophany") == 2) {
    self.cybercom.var_110c156a = getdvarint("scr_cacophany_upgraded_count", 5);
    self.cybercom.var_f72b478f = getdvarfloat("scr_cacophany_upgraded_fov", 0.5);
    self.cybercom.var_23d4a73a = getdvarfloat("scr_cacophany_lock_radius", 330);
  }
  self.cybercom.targetlockcb = & _get_valid_targets;
  self.cybercom.targetlockrequirementcb = & _lock_requirement;
  self thread cybercom::function_b5f4e597(weapon);
}

function _on_take(slot, weapon) {
  self _off(slot, weapon);
  self.cybercom.targetlockcb = undefined;
  self.cybercom.targetlockrequirementcb = undefined;
  self.cybercom.var_f72b478f = undefined;
  self.cybercom.var_23d4a73a = undefined;
}

function _on_connect() {}

function _on(slot, weapon) {
  self thread function_7f3f3bde(slot, weapon);
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
  if(target cybercom::cybercom_aicheckoptout("cybercom_cacophany")) {
    self cybercom::function_29bf9dee(target, 2);
    return false;
  }
  if(isDefined(target.destroyingweapon)) {
    return false;
  }
  if(isDefined(target.var_37915be0) && target.var_37915be0) {
    return false;
  }
  if(isDefined(target.is_disabled) && target.is_disabled) {
    self cybercom::function_29bf9dee(target, 6);
    return false;
  }
  return true;
}

function private _get_valid_targets(weapon) {
  return getEntArray("destructible", "targetname");
}

function private function_7f3f3bde(slot, weapon) {
  aborted = 0;
  fired = 0;
  foreach(item in self.cybercom.lock_targets) {
    if(isDefined(item.target) && (isDefined(item.inrange) && item.inrange)) {
      if(item.inrange == 1) {
        if(!cybercom::targetisvalid(item.target, weapon)) {
          continue;
        }
        item.target thread function_41e98fcc(self, fired);
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
    itemindex = getitemindexfromref("cybercom_cacophany");
    if(isDefined(itemindex)) {
      self adddstat("ItemStats", itemindex, "stats", "assists", "statValue", fired);
      self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
    }
  }
}

function function_41e98fcc(attacker, offset) {
  if(offset == 0) {
    wait(0.1);
  } else {
    var_f5aa368a = 0.15 + (randomfloatrange(0.1, 0.25) * offset);
    wait(var_f5aa368a);
  }
  self dodamage(self.health + 100, self.origin, attacker, attacker);
  self.var_37915be0 = 1;
}