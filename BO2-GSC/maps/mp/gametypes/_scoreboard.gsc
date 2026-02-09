/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_scoreboard.gsc
*********************************************/

init() {
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