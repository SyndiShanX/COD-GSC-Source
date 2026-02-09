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
  setDvar("g_ScoresColor_Spectator", ".25 .25 .25");
  setDvar("g_ScoresColor_Free", ".76 .78 .10");
  setDvar("g_teamColor_MyTeam", ".4 .7 .4");
  setDvar("g_teamColor_EnemyTeam", "1 .315 0.35");
  setDvar("g_teamColor_MyTeamAlt", ".35 1 1");
  setDvar("g_teamColor_EnemyTeamAlt", "1 .5 0");
  setDvar("g_teamColor_Squad", ".315 0.35 1");
  if(sessionmodeiszombiesgame()) {
    setDvar("g_TeamIcon_Axis", "faction_cia");
    setDvar("g_TeamIcon_Allies", "faction_cdc");
  } else {
    setDvar("g_TeamIcon_Axis", game["icons"]["axis"]);
    setDvar("g_TeamIcon_Allies", game["icons"]["allies"]);
  }
}