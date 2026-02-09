/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_cosmodrome_achievement.gsc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\zm\_zm_utility;
#namespace zm_cosmodrome_achievement;

function init() {
  level thread achievement_the_eagle_has_landers();
  level thread achievement_chimp_on_the_barbie();
  level thread callback::on_connect(&onplayerconnect);
}

function onplayerconnect() {
  self thread achievement_all_dolled_up();
  self thread achievement_black_hole();
  self thread achievement_space_race();
}

function achievement_the_eagle_has_landers() {
  level flag::wait_till_all(array("lander_a_used", "lander_b_used", "lander_c_used"));
  level zm_utility::giveachievement_wrapper("DLC2_ZOM_LUNARLANDERS", 1);
}

function achievement_chimp_on_the_barbie() {
  level endon("end_game");
  for(;;) {
    level waittill("trap_kill", zombie, trap);
    if(!isPlayer(zombie) && "monkey_zombie" == zombie.animname && "fire" == trap._trap_type) {
      zm_utility::giveachievement_wrapper("DLC2_ZOM_FIREMONKEY", 1);
      return;
    }
  }
}

function achievement_all_dolled_up() {
  level endon("end_game");
  self endon("disconnect");
  self waittill("nesting_doll_kills_achievement");
}

function achievement_black_hole() {
  level endon("end_game");
  self endon("disconnect");
  self waittill("black_hole_kills_achievement");
}

function achievement_space_race() {
  level endon("end_game");
  self endon("disconnect");
  self waittill("pap_taken");
}