/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\gametypes\_scoreboard.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace scoreboard;

function autoexec __init__sytem__() {
  system::register("scoreboard", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&main);
}

function main() {
  setdvar("g_ScoresColor_Spectator", ".25 .25 .25");
  setdvar("g_ScoresColor_Free", ".76 .78 .10");
  setdvar("g_teamColor_MyTeam", ".4 .7 .4");
  setdvar("g_teamColor_EnemyTeam", "1 .315 0.35");
  setdvar("g_teamColor_MyTeamAlt", ".35 1 1");
  setdvar("g_teamColor_EnemyTeamAlt", "1 .5 0");
  setdvar("g_teamColor_Squad", ".315 0.35 1");
  if(sessionmodeiszombiesgame()) {
    setdvar("g_TeamIcon_Axis", "faction_cia");
    setdvar("g_TeamIcon_Allies", "faction_cdc");
  } else {
    setdvar("g_TeamIcon_Axis", game["icons"]["axis"]);
    setdvar("g_TeamIcon_Allies", game["icons"]["allies"]);
  }
}