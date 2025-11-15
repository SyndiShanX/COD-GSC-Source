/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\intro_pac.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;

main() {
  flag_init("all_players_connected");
  level thread maps\_load::all_players_connected();
  maps\_callbackglobal::init();
  maps\_callbacksetup::SetupCallbacks();
  setsaveddvar("hud_drawhud", 0);
  SetSavedDvar("g_speed", 0);
  flag_wait("all_players_connected");
  ChangeLevel("mak");
}