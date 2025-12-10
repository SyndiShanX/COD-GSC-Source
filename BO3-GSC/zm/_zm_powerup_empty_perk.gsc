/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_empty_perk.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_powerup_empty_perk;

function autoexec __init__sytem__() {
  system::register("zm_powerup_empty_perk", &__init__, undefined, undefined);
}

function __init__() {
  zm_powerups::register_powerup("empty_perk", &function_59e7b1f8);
  if(tolower(getdvarstring("g_gametype")) != "zcleansed") {
    zm_powerups::add_zombie_powerup("empty_perk", "zombie_pickup_perk_bottle", &"", &zm_powerups::func_should_never_drop, 1, 0, 0);
    zm_powerups::powerup_set_statless_powerup("empty_perk");
  }
  level.get_player_perk_purchase_limit = &function_c396add0;
  thread function_ac499d74();
}

function function_59e7b1f8(player) {
  player thread function_ba8751f2();
}

function function_ba8751f2() {
  if(!isDefined(self.player_perk_purchase_limit)) {
    self.player_perk_purchase_limit = level.perk_purchase_limit;
  }
  if(self.player_perk_purchase_limit < level.var_1eddc9ee) {
    self.player_perk_purchase_limit++;
  }
}

function function_c396add0() {
  if(!isDefined(self.player_perk_purchase_limit)) {
    self.player_perk_purchase_limit = level.perk_purchase_limit;
  }
  return self.player_perk_purchase_limit;
}

function function_ac499d74() {
  level flagsys::wait_till("");
  wait(1);
  zm_devgui::add_custom_devgui_callback(&function_5d69c3e);
  adddebugcommand("");
  adddebugcommand("");
}

function function_5d69c3e(cmd) {
  players = getplayers();
  retval = 0;
  switch (cmd) {
    case "": {
      zm_devgui::zombie_devgui_give_powerup(cmd, 1);
      break;
    }
    case "": {
      zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
      break;
    }
  }
  return retval;
}