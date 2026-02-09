/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_temple_achievement.gsc
**********************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init() {
  level thread achievement_temple_sidequest();
  level thread achievement_zomb_disposal();
  level thread achievement_monkey_see_monkey_dont();
  level thread onPlayerConnect();
}
onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread achievement_blinded_by_the_fright();
    player thread achievement_small_consolation();
  }
}
achievement_temple_sidequest() {
  level waittill("temple_sidequest_achieved");
  level thread maps\_zombiemode::set_sidequest_completed("EOA");
  level giveachievement_wrapper("DLC4_ZOM_TEMPLE_SIDEQUEST", true);
  level givegamerpicture_wrapper("DLC4_DEMPSEY", true);
  level givegamerpicture_wrapper("DLC4_RICHTOFEN", true);
}
achievement_zomb_disposal() {
  level endon("end_game");
  level waittill("zomb_disposal_achieved");
  level giveachievement_wrapper("DLC4_ZOM_ZOMB_DISPOSAL", true);
}
achievement_monkey_see_monkey_dont() {
  level waittill("monkey_see_monkey_dont_achieved");
  level giveachievement_wrapper("DLC4_ZOM_MONKEY_SEE_MONKEY_DONT", true);
}
achievement_blinded_by_the_fright() {
  self waittill("blinded_by_the_fright_achieved");
  self giveachievement_wrapper("DLC4_ZOM_BLINDED_BY_THE_FRIGHT");
}
achievement_small_consolation() {
  while(true) {
    self waittill("weapon_fired");
    currentweapon = self GetCurrentWeapon();
    if(currentweapon != "shrink_ray_zm" && currentweapon != "shrink_ray_upgraded_zm") {
      continue;
    }
    waittillframeend;
    if(isDefined(self.shrinked_zombies) && is_true(self.shrinked_zombies["zombie"]) && is_true(self.shrinked_zombies["sonic_zombie"]) && is_true(self.shrinked_zombies["napalm_zombie"]) && is_true(self.shrinked_zombies["monkey_zombie"])) {
      break;
    }
  }
  self giveachievement_wrapper("DLC4_ZOM_SMALL_CONSOLATION");
}