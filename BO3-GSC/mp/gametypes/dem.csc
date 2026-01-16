/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\dem.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\gametypes\_globallogic;
#using scripts\shared\callbacks_shared;
#namespace dem;

function main() {
  callback::on_spawned( & on_player_spawned);
  if(getgametypesetting("silentPlant") != 0) {
    setsoundcontext("bomb_plant", "silent");
  }
}

function onprecachegametype() {}

function onstartgametype() {}

function on_player_spawned(localclientnum) {
  self thread globallogic::watch_plant_sound(localclientnum);
}