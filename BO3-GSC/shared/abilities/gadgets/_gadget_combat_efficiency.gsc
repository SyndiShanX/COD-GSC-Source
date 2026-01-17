/******************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_combat_efficiency.gsc
******************************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace _gadget_combat_efficiency;

function autoexec __init__sytem__() {
  system::register("gadget_combat_efficiency", &__init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(15, &gadget_combat_efficiency_on_activate, &gadget_combat_efficiency_on_off);
  ability_player::register_gadget_possession_callbacks(15, &gadget_combat_efficiency_on_give, &gadget_combat_efficiency_on_take);
  ability_player::register_gadget_flicker_callbacks(15, &gadget_combat_efficiency_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(15, &gadget_combat_efficiency_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(15, &gadget_combat_efficiency_is_flickering);
  ability_player::register_gadget_ready_callbacks(15, &gadget_combat_efficiency_ready);
}

function gadget_combat_efficiency_is_inuse(slot) {
  return self gadgetisactive(slot);
}

function gadget_combat_efficiency_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function gadget_combat_efficiency_on_flicker(slot, weapon) {}

function gadget_combat_efficiency_on_give(slot, weapon) {}

function gadget_combat_efficiency_on_take(slot, weapon) {}

function gadget_combat_efficiency_on_connect() {}

function gadget_combat_efficiency_on_spawn() {
  self.combatefficiencylastontime = 0;
}

function gadget_combat_efficiency_on_activate(slot, weapon) {
  self._gadget_combat_efficiency = 1;
  self._gadget_combat_efficiency_success = 0;
  self.scorestreaksearnedperuse = 0;
  self.combatefficiencylastontime = gettime();
}

function gadget_combat_efficiency_on_off(slot, weapon) {
  self._gadget_combat_efficiency = 0;
  self.combatefficiencylastontime = gettime();
  self addweaponstat(self.heroability, "scorestreaks_earned_2", int(self.scorestreaksearnedperuse / 2));
  self addweaponstat(self.heroability, "scorestreaks_earned_3", int(self.scorestreaksearnedperuse / 3));
  if(isalive(self) && isDefined(level.playgadgetsuccess)) {
    self[[level.playgadgetsuccess]](weapon);
  }
}

function gadget_combat_efficiency_ready(slot, weapon) {}

function set_gadget_combat_efficiency_status(weapon, status, time) {
  timestr = "";
  if(isDefined(time)) {
    timestr = (("^3") + ", time: ") + time;
  }
  if(getdvarint("scr_cpower_debug_prints") > 0) {
    self iprintlnbold(((("Gadget Combat Efficiency " + weapon.name) + ": ") + status) + timestr);
  }
}