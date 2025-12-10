/*******************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_tactical_rig_emergencyreserve.gsc
*******************************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_dev;
#using scripts\cp\cybercom\_cybercom_tactical_rig;
#using scripts\cp\cybercom\_cybercom_tactical_rig_proximitydeterrent;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_save;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace cybercom_tacrig_emergencyreserve;

function init() {}

function main() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  setdvar("scr_emergency_reserve_timer", 5);
  setdvar("scr_emergency_reserve_timer_upgraded", 8);
  cybercom_tacrig::register_cybercom_rig_ability("cybercom_emergencyreserve", 3);
  cybercom_tacrig::register_cybercom_rig_possession_callbacks("cybercom_emergencyreserve", &emergencyreservegive, &emergencyreservetake);
  cybercom_tacrig::register_cybercom_rig_activation_callbacks("cybercom_emergencyreserve", &emergencyreserveactivate, &emergencyreservedeactivate);
}

function on_player_connect() {}

function on_player_spawned() {}

function emergencyreservegive(type) {
  self.lives = self savegame::get_player_data("lives", 1);
  self clientfield::set_to_player("sndTacRig", 1);
}

function emergencyreservetake(type) {
  self.lives = 0;
  self clientfield::set_to_player("sndTacRig", 0);
}

function emergencyreserveactivate(type) {
  if(self.lives < 1) {
    return;
  }
  if(self hascybercomrig("cybercom_emergencyreserve") == 2) {
    level thread cybercom_tacrig_proximitydeterrent::function_c0ba5acc(self);
  }
  self cybercom_tacrig::turn_rig_ability_off("cybercom_emergencyreserve");
  self playlocalsound("gdt_cybercore_regen_godown");
  playFX("player/fx_plyr_ability_emergency_reserve_1p", self.origin);
}

function emergencyreservedeactivate(type) {}

function validdeathtypesforemergencyreserve(smeansofdeath) {
  if(isDefined(smeansofdeath)) {
    return issubstr(smeansofdeath, "_BULLET") || issubstr(smeansofdeath, "_GRENADE") || issubstr(smeansofdeath, "_MELEE") || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_SUICIDE" || smeansofdeath == "MOD_HEAD_SHOT";
  }
  return 0;
}