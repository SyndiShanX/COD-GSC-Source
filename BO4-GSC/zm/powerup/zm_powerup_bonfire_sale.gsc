/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_bonfire_sale.gsc
**************************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;

#namespace zm_powerup_bonfire_sale;

autoexec __init__system__() {
  system::register(#"zm_powerup_bonfire_sale", &__init__, &__main__, undefined);
}

__init__() {
  zm_powerups::register_powerup("bonfire_sale", &grab_bonfire_sale);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("bonfire_sale", "p8_zm_power_up_bonfire_sale", #"zombie/powerup_max_ammo", &zm_powerups::func_should_never_drop, 0, 0, 0, undefined, "powerup_bon_fire", "zombie_powerup_bonfire_sale_time", "zombie_powerup_bonfire_sale_on");
  }
}

__main__() {}

grab_bonfire_sale(player) {
  level thread start_bonfire_sale(self);
  player thread zm_powerups::powerup_vo("bonfiresale");
}

start_bonfire_sale(item) {
  level notify(#"powerup bonfire sale");
  level endon(#"powerup bonfire sale");
  temp_ent = spawn("script_origin", (0, 0, 0));
  temp_ent playLoopSound(#"zmb_double_point_loop");
  zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_on", 1);
  level thread toggle_bonfire_sale_on();
  zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_time", 30);

  if(bgb::is_team_enabled("zm_bgb_temporal_gift")) {
    zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_time", zombie_utility::get_zombie_var(#"zombie_powerup_bonfire_sale_time") + 30);
  }

  while(zombie_utility::get_zombie_var(#"zombie_powerup_bonfire_sale_time") > 0) {
    waitframe(1);
    zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_time", zombie_utility::get_zombie_var(#"zombie_powerup_bonfire_sale_time") - 0.05);
  }

  zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_on", 0);
  level notify(#"bonfire_sale_off");
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    players[i] playSound(#"zmb_points_loop_off");
  }

  temp_ent delete();
}

toggle_bonfire_sale_on() {
  level endon(#"powerup bonfire sale");

  if(!isDefined(zombie_utility::get_zombie_var(#"zombie_powerup_bonfire_sale_on"))) {
    return;
  }

  if(zombie_utility::get_zombie_var(#"zombie_powerup_bonfire_sale_on")) {
    if(isDefined(level.bonfire_init_func)) {
      level thread[[level.bonfire_init_func]]();
    }

    level waittill(#"bonfire_sale_off");
  }
}

setup_bonfiresale_audio() {
  wait 2;
  intercom = getEntArray("intercom", "targetname");

  while(true) {
    while(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") == 0) {
      wait 0.2;
    }

    for(i = 0; i < intercom.size; i++) {
      intercom[i] thread play_bonfiresale_audio();
    }

    while(zombie_utility::get_zombie_var(#"zombie_powerup_fire_sale_on") == 1) {
      wait 0.1;
    }

    level notify(#"firesale_over");
  }
}

play_bonfiresale_audio() {
  if(isDefined(level.sndfiresalemusoff) && level.sndfiresalemusoff) {
    return;
  }

  if(isDefined(level.sndannouncerisrich) && level.sndannouncerisrich) {
    self playLoopSound(#"mus_fire_sale_rich");
  } else {
    self playLoopSound(#"mus_fire_sale");
  }

  level waittill(#"firesale_over");
  self stoploopsound();
}