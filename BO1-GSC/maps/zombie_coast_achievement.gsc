/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_coast_achievement.gsc
*********************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init() {
  level thread achievement_eggs();
  level thread achievement_quiet_on_the_set();
  level thread onPlayerConnect();
}
onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread achievement_stuntman();
    player thread achievement_shooting_on_location();
  }
}
achievement_eggs() {
  level waittill("coast_easter_egg_achieved");
  level thread maps\_zombiemode::set_sidequest_completed();
  level giveachievement_wrapper("DLC3_ZOM_STAND_IN", true);
  level givegamerpicture_wrapper("DLC3_TAKEO", true);
  if(!flag("solo_game")) {
    level giveachievement_wrapper("DLC3_ZOM_ENSEMBLE_CAST", true);
    level givegamerpicture_wrapper("DLC3_NIKOLAI", true);
  }
}
achievement_quiet_on_the_set() {
  level waittill("quiet_on_the_set_achieved");
  level giveachievement_wrapper("DLC3_ZOM_QUIET_ON_THE_SET", true);
}
achievement_stuntman() {
  self waittill("stuntman_achieved");
  self giveachievement_wrapper("DLC3_ZOM_STUNTMAN");
}
achievement_shooting_on_location() {
  self waittill("shooting_on_location_achieved");
  self giveachievement_wrapper("DLC3_ZOM_SHOOTING_ON_LOCATION");
}