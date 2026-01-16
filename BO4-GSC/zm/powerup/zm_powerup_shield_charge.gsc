/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_shield_charge.gsc
***************************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_powerup_shield_charge;

autoexec __init__system__() {
  system::register(#"zm_powerup_shield_charge", &__init__, undefined, undefined);
}

__init__() {
  zm_powerups::register_powerup("shield_charge", &grab_shield_charge);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("shield_charge", "p7_zm_zod_nitrous_tank", #"hash_3f5e4aa38f9aeba5", &func_drop_when_players_own, 1, 0, 0);
    zm_powerups::powerup_set_statless_powerup("shield_charge");
  }

  thread shield_devgui();

}

func_drop_when_players_own() {
  return false;
}

grab_shield_charge(player) {
  level thread shield_charge_powerup(self, player);
}

shield_charge_powerup(item, player) {
  if(isDefined(player.hasriotshield) && player.hasriotshield) {
    player givestartammo(player.weaponriotshield);
  }

  level thread shield_on_hud(item, player.team);
}

shield_on_hud(drop_item, player_team) {

  self endon(#"disconnect");
  hudelem = hud::function_f5a689d("<dev string:x38>", 2);
  hudelem hud::setpoint("<dev string:x44>", undefined, 0, zombie_utility::get_zombie_var(#"zombie_timer_offset") - zombie_utility::get_zombie_var(#"zombie_timer_offset_interval") * 2);
  hudelem.sort = 0.5;
  hudelem.alpha = 0;
  hudelem fadeovertime(0.5);
  hudelem.alpha = 1;

  if(isDefined(drop_item)) {
    hudelem.label = drop_item.hint;
  }

  hudelem thread full_ammo_move_hud(player_team);

}

full_ammo_move_hud(player_team) {
  players = getplayers(player_team);
  players[0] playsoundtoteam("<dev string:x4a>", player_team);
  wait 0.5;
  move_fade_time = 1.5;
  self fadeovertime(move_fade_time);
  self moveovertime(move_fade_time);
  self.y = 270;
  self.alpha = 0;
  wait move_fade_time;
  self destroy();
}

shield_devgui() {
  level flagsys::wait_till("<dev string:x5a>");
  wait 1;
  zm_devgui::add_custom_devgui_callback(&shield_devgui_callback);
  adddebugcommand("<dev string:x75>");
  adddebugcommand("<dev string:xc8>");
}

shield_devgui_callback(cmd) {
  players = getplayers();
  retval = 0;

  switch (cmd) {
    case #"shield_charge":
      zm_devgui::zombie_devgui_give_powerup(cmd, 1);
      break;
    case #"next_shield_charge":
      zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
      break;
  }

  return retval;
}

