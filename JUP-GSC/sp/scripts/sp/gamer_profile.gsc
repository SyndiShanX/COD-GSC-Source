/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\gamer_profile.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace gamer_profile;

function init_gamer_profile() {
  assert(isDefined(level.missionsettings) && isDefined(level.missionsettings.levels));
  assert(isDefined(level.script));

  if(level.script == level.missionsettings.levels[0].name && !level.player getlocalplayerprofiledata("hasEverPlayed_SP")) {
    delaythread(0.1, &update_gamer_profile);
  }
}

function update_gamer_profile() {
  level.player setlocalplayerprofiledata("hasEverPlayed_SP", 1);
  updategamerprofile();
}