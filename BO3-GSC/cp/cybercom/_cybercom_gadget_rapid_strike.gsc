/*********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_gadget_rapid_strike.gsc
*********************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_battlechatter;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\ai_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace namespace_328b6406;

function init() {}

function main() {
  cybercom_gadget::registerability(1, 64);
  callback::on_spawned(&on_player_spawned);
  level.cybercom.rapid_strike = spawnStruct();
  level.cybercom.rapid_strike._is_flickering = &_is_flickering;
  level.cybercom.rapid_strike._on_flicker = &_on_flicker;
  level.cybercom.rapid_strike._on_give = &_on_give;
  level.cybercom.rapid_strike._on_take = &_on_take;
  level.cybercom.rapid_strike._on_connect = &_on_connect;
  level.cybercom.rapid_strike._on = &_on;
  level.cybercom.rapid_strike._off = &_off;
}

function on_player_spawned() {}

function _is_flickering(slot) {}

function _on_flicker(slot, weapon) {}

function _on_give(slot, weapon) {
  self thread function_677ed44f(weapon);
}

function _on_take(slot, weapon) {
  self notify("hash_343d4580");
}

function _on_connect() {}

function _on(slot, weapon) {}

function _off(slot, weapon) {}

function function_677ed44f(weapon) {
  self notify("hash_677ed44f");
  self endon("hash_677ed44f");
  self endon("hash_343d4580");
  self endon("disconnect");
  while(true) {
    level waittill("rapid_strike", target, attacker, damage, weapon, hitorigin);
    self notify(weapon.name + "_fired");
    level notify(weapon.name + "_fired");
    wait(0.05);
    if(isPlayer(self)) {
      itemindex = getitemindexfromref("cybercom_rapidstrike");
      if(isDefined(itemindex)) {
        self adddstat("ItemStats", itemindex, "stats", "kills", "statValue", 1);
        self adddstat("ItemStats", itemindex, "stats", "used", "statValue", 1);
      }
    }
  }
}