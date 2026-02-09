/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes_zm\_scoreboard.gsc
************************************************/

init() {
  setDvar("g_ScoresColor_Spectator", ".25 .25 .25");
  setDvar("g_ScoresColor_Free", ".76 .78 .10");
  setDvar("g_teamColor_MyTeam", ".4 .7 .4");
  setDvar("g_teamColor_EnemyTeam", "1 .315 0.35");
  setDvar("g_teamColor_MyTeamAlt", ".35 1 1");
  setDvar("g_teamColor_EnemyTeamAlt", "1 .5 0");
  setDvar("g_teamColor_Squad", ".315 0.35 1");

  if(level.createfx_enabled) {
    return;
  }
  if(sessionmodeiszombiesgame()) {
    setDvar("g_TeamIcon_Axis", "faction_cia");
    setDvar("g_TeamIcon_Allies", "faction_cdc");
  } else {
    setDvar("g_TeamIcon_Axis", game["icons"]["axis"]);
    setDvar("g_TeamIcon_Allies", game["icons"]["allies"]);
  }
}