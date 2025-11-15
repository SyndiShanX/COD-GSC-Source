/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_weaponobjects.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weaponobjects;
#using scripts\shared\weapons_shared;
#namespace weaponobjects;

function autoexec __init__sytem__() {
  system::register("weaponobjects", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
  callback::on_start_gametype( & start_gametype);
}

function start_gametype() {
  callback::on_connect( & on_player_connect);
  callback::on_spawned( & on_player_spawned);
}

function on_player_spawned() {
  for(watcher = 0; watcher < self.weaponobjectwatcherarray.size; watcher++) {
    if(self.weaponobjectwatcherarray[watcher].name == "spike_charge") {
      arrayremoveindex(self.weaponobjectwatcherarray, watcher);
    }
  }
  self createspikelauncherwatcher("spike_launcher");
}