/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\medals_shared.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#namespace medals;

function private autoexec __init__system__() {
  system::register(#"medals", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
}

function init() {
  level.medalinfo = [];
  level.medalcallbacks = [];
  level.numkills = 0;
  level.prevlastkilltime = 0;
  level.lastkilltime = 0;
  callback::on_connect(&on_player_connect);
}

function on_player_connect() {
  self.lastkilledby = undefined;
}

function setlastkilledby(attacker, inflictor) {
  self.lastkilledby = attacker;
  self.var_e78602fc = inflictor;
}

function offenseglobalcount() {
  level.globalteammedals++;
}

function defenseglobalcount() {
  level.globalteammedals++;
}

function event_handler[player_medal] codecallback_medal(eventstruct) {
  self luinotifyevent(#"medal_received", 1, eventstruct.medal_index);
  self function_8ba40d2f(#"medal_received", 1, eventstruct.medal_index);
}