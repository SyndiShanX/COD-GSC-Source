/****************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cybercom\_cybercom_tactical_rig_sensorybuffer.gsc
****************************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_dev;
#using scripts\cp\cybercom\_cybercom_tactical_rig;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace cybercom_tacrig_sensorybuffer;

function init() {}

function main() {
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  cybercom_tacrig::register_cybercom_rig_ability("cybercom_sensorybuffer", 4);
  cybercom_tacrig::register_cybercom_rig_possession_callbacks("cybercom_sensorybuffer", &sensorybuffergive, &sensorybuffertake);
  cybercom_tacrig::register_cybercom_rig_activation_callbacks("cybercom_sensorybuffer", &sensorybufferactivate, &sensorybufferdeactivate);
}

function on_player_connect() {}

function on_player_spawned() {}

function sensorybuffergive(type) {
  self thread cybercom_tacrig::turn_rig_ability_on(type);
}

function sensorybuffertake(type) {
  self thread cybercom_tacrig::turn_rig_ability_off(type);
}

function sensorybufferactivate(type) {
  self setperk("specialty_bulletflinch");
  self setperk("specialty_flashprotection");
  if(self hascybercomrig(type) == 2) {
    self setperk("specialty_flakjacket");
  }
}

function sensorybufferdeactivate(type) {
  self unsetperk("specialty_bulletflinch");
  self unsetperk("specialty_flashprotection");
  if(self hascybercomrig(type) == 2) {
    self unsetperk("specialty_flakjacket");
  }
}