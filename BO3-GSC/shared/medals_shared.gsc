/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\medals_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace medals;

function autoexec __init__sytem__() {
  system::register("medals", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&init);
}

function init() {
  level.medalinfo = [];
  level.medalcallbacks = [];
  level.numkills = 0;
  callback::on_connect(&on_player_connect);
}

function on_player_connect() {
  self.lastkilledby = undefined;
}

function setlastkilledby(attacker) {
  self.lastkilledby = attacker;
}

function offenseglobalcount() {
  level.globalteammedals++;
}

function defenseglobalcount() {
  level.globalteammedals++;
}

function codecallback_medal(medalindex) {
  self luinotifyevent(&"medal_received", 1, medalindex);
  self luinotifyeventtospectators(&"medal_received", 1, medalindex);
}