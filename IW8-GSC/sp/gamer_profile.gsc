/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\gamer_profile.gsc
***********************************************/

init_gamer_profile() {
  if(level.script == level.missionsettings.levels[0].name && !level.player getlocalplayerprofiledata("hasEverPlayed_SP"))
    scripts\engine\utility::delaythread(0.1, ::update_gamer_profile);
}

update_gamer_profile() {
  level.player setlocalplayerprofiledata("hasEverPlayed_SP", 1);
  updategamerprofile();
}