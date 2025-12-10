/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_scoreboard.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace scoreboard;

function autoexec __init__sytem__() {
  system::register("scoreboard", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&init);
}

function init() {
  if(sessionmodeiszombiesgame()) {
    setdvar("g_TeamIcon_Axis", "faction_cia");
    setdvar("g_TeamIcon_Allies", "faction_cdc");
  } else {
    setdvar("g_TeamIcon_Axis", game["icons"]["axis"]);
    setdvar("g_TeamIcon_Allies", game["icons"]["allies"]);
  }
}