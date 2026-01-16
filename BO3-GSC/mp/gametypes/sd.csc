/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\sd.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\gametypes\_globallogic;
#using scripts\shared\callbacks_shared;
#namespace sd;

function main() {
  callback::on_spawned( & on_player_spawned);
  if(getgametypesetting("silentPlant") != 0) {
    setsoundcontext("bomb_plant", "silent");
  }
}

function onstartgametype() {}

function on_player_spawned(localclientnum) {
  self thread player_sound_context_hack();
  self thread globallogic::watch_plant_sound(localclientnum);
}

function player_sound_context_hack() {
  if(getgametypesetting("silentPlant") != 0) {
    self endon("entityshutdown");
    self notify("player_sound_context_hack");
    self endon("player_sound_context_hack");
    while (true) {
      self setsoundentcontext("bomb_plant", "silent");
      wait(1);
    }
  }
}