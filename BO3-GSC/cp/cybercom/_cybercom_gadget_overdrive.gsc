/******************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_overdrive.gsc
******************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace namespace_f388b961;

function init() {}

function main() {
  cybercom_gadget::registerability(1, 16);
  level.cybercom.overdrive = spawnStruct();
  level.cybercom.overdrive._on_give = &_on_give;
  level.cybercom.overdrive._on_take = &_on_take;
  level.cybercom.overdrive._on = &_on;
  level.cybercom.overdrive._off = &_off;
}

function _on_flicker(slot, weapon) {}

function _on_give(slot, weapon) {
  self.cybercom.targetlockcb = undefined;
  self.cybercom.targetlockrequirementcb = undefined;
  self thread cybercom::function_b5f4e597(weapon);
}

function _on_take(slot, weapon) {
  _off(slot, weapon);
}

function _on_connect() {}

function _on_disconnect() {
  self notify("hash_3ca9ab77");
}

function _on(slot, weapon) {
  self endon("hash_3ca9ab77");
  self endon("death");
  self endon("disconnect");
  if(flagsys::get("gadget_overdrive_on")) {
    return;
  }
  wait(getdvarfloat("scr_overdrive_activationDelay_sec", 0.4));
  self.var_7d73f4ba = self hasperk("specialty_deadshot");
  if(!(isDefined(self.var_7d73f4ba) && self.var_7d73f4ba)) {
    self setperk("specialty_deadshot");
  }
  self clientfield::set_to_player("overdrive_state", 1);
  visionset_mgr::activate("visionset", "overdrive", self, 0.4, 0.1, 1.35);
  self notify(weapon.name + "_fired");
  level notify(weapon.name + "_fired");
  if(self.health < (self.maxhealth * getdvarfloat("scr_overdrive_min_health", 0.35))) {
    self setnormalhealth(getdvarfloat("scr_overdrive_min_health", 0.35));
  }
  self playrumbleonentity("tank_rumble");
  if(isPlayer(self)) {
    itemindex = getitemindexfromref("cybercom_overdrive");
    if(isDefined(itemindex)) {
      self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
    }
  }
}

function _off(slot, weapon) {
  self notify("hash_3ca9ab77");
  if(!(isDefined(self.var_7d73f4ba) && self.var_7d73f4ba)) {
    self unsetperk("specialty_deadshot");
  }
  self clientfield::set_to_player("overdrive_state", 0);
}