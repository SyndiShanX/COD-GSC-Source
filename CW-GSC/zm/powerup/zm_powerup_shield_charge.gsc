/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\powerup\zm_powerup_shield_charge.gsc
***************************************************/

#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_powerups;
#namespace zm_powerup_shield_charge;

function private autoexec __init__system__() {
  system::register(#"zm_powerup_shield_charge", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_powerups::register_powerup("shield_charge", &grab_shield_charge);

  if(zm_powerups::function_cc33adc8()) {
    zm_powerups::add_zombie_powerup("shield_charge", "p8_wz_armor_scrap", #"hash_3f5e4aa38f9aeba5", &func_drop_when_players_own, 1, 0, 0);
    zm_powerups::function_59f7f2c6("shield_charge", #"hash_6c72c13078ae03d7", #"hash_3d58d22b97f9c9b4", #"hash_53f81d6d588b9984");
    zm_powerups::powerup_set_statless_powerup("shield_charge");
  }

  thread shield_devgui();
}

function func_drop_when_players_own() {
  players = getplayers();

  foreach(player in players) {
    if((isDefined(player.armortier) ? player.armortier : 0) > 0) {
      return true;
    }
  }

  return false;
}

function grab_shield_charge(player) {
  level thread shield_charge_powerup(self, player);
}

function shield_charge_powerup(item, player) {
  var_2cacdde7 = 50;
  inventoryitem = player.inventory.items[6];

  if(isDefined(inventoryitem)) {
    var_2cacdde7 = isDefined(inventoryitem.itementry.var_a3aa1ca2) ? inventoryitem.itementry.var_a3aa1ca2 : 50;

    if(var_2cacdde7 == 0) {
      var_2cacdde7 = 50;
    }
  }

  player.armor += math::clamp(var_2cacdde7, 0, player.maxarmor);
}

function shield_devgui() {
  level flag::wait_till("<dev string:x38>");
  wait 1;
  zm_devgui::add_custom_devgui_callback(&shield_devgui_callback);
  adddebugcommand("<dev string:x54>");
  adddebugcommand("<dev string:xa8>");
}

function shield_devgui_callback(cmd) {
  players = getplayers();
  retval = 0;

  switch (cmd) {
    case # "shield_charge":
      zm_devgui::zombie_devgui_give_powerup(cmd, 1);
      break;
    case # "next_shield_charge":
      zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
      break;
  }

  return retval;
}