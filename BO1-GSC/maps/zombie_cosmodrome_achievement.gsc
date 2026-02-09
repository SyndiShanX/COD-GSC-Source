/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cosmodrome_achievement.gsc
**************************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init() {
  level thread achievement_the_eagle_has_landers();
  level thread achievement_chimp_on_the_barbie();
  level thread onPlayerConnect();
}
onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread achievement_all_dolled_up();
    player thread achievement_black_hole();
    player thread achievement_space_race();
  }
}
achievement_the_eagle_has_landers() {
  flag_wait("lander_a_used");
  flag_wait("lander_b_used");
  flag_wait("lander_c_used");
  level giveachievement_wrapper("DLC2_ZOM_LUNARLANDERS", true);
}
achievement_chimp_on_the_barbie() {
  for(;;) {
    level waittill("trap_kill", zombie, trap);
    if(!isPlayer(zombie) && "monkey_zombie" == zombie.animname && "fire" == trap._trap_type) {
      giveachievement_wrapper("DLC2_ZOM_FIREMONKEY", true);
      return;
    }
  }
}
achievement_all_dolled_up() {
  self waittill("nesting_doll_kills_achievement");
  self giveachievement_wrapper("DLC2_ZOM_PROTECTEQUIP");
}
achievement_black_hole() {
  self waittill("black_hole_kills_achievement");
  self giveachievement_wrapper("DLC2_ZOM_BLACKHOLE");
}
achievement_space_race() {
  self waittill("pap_taken");
  if(8 > level.round_number) {
    self giveachievement_wrapper("DLC2_ZOM_PACKAPUNCH");
  }
}