/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1626cbe6741a772b.gsc
*************************************************/

#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_4b7698942d6f679a;
#using script_53f4e6352b0b2425;
#using script_6bf6c8e2e1fdccaa;
#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_vip\sp_jup_vip_lighting;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#namespace namespace_a6d3081fd5d2d172;

function function_5d084583d28da7ff() {
  utility::set_start_location("start_escape_run", [level.player]);
  thread namespace_9c93a5b828db4a4b::function_e39d8a96b86719ce(0);
}

function function_3eb536d67b1ad828() {
  utility::set_start_location("start_escape_run", [level.player]);
  level.player shellshock("default_nosound", 5);
  level.player hud_util::fade_in(4, "black");
}

function function_16e7e34592d39ad4(array, notif) {
  guy1 = array[0];
  guy2 = array[1];

  foreach(guy in array) {
    guy linkTo(self);
    guy utility::set_baseaccuracy(0.25);
    guy.health = 25;
    guy utility::set_ignoreall(1);
  }

  wait 3;

  foreach(guy in array) {
    guy utility::set_ignoreall(0);
  }

  utility::waittill_multiple_ents(guy1, "death", guy2, "death");
  level notify(notif);
}

function function_fca1f15e44a27511() {}

function function_fb1d5e80f330c65() {
  utility::set_start_location("outro", [level.player]);
  setsaveddvar(@ "hash_e3b392663b07939c", 1);
  thread namespace_9c93a5b828db4a4b::function_e39d8a96b86719ce(1);
}

function function_42267542ddd353e() {}

function function_8fd119d2b021a4b7() {}