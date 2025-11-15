/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_shield_charge.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_powerup_shield_charge;

function autoexec __init__sytem__() {
  system::register("zm_powerup_shield_charge", & __init__, undefined, undefined);
}

function __init__() {
  zm_powerups::register_powerup("shield_charge", & grab_shield_charge);
  if(tolower(getdvarstring("g_gametype")) != "zcleansed") {
    zm_powerups::add_zombie_powerup("shield_charge", "p7_zm_zod_nitrous_tank", & "ZOMBIE_POWERUP_SHIELD_CHARGE", & func_drop_when_players_own, 1, 0, 0);
    zm_powerups::powerup_set_statless_powerup("shield_charge");
  }
  thread function_f3127c4f();
}

function func_drop_when_players_own() {
  return false;
}

function grab_shield_charge(player) {
  level thread shield_charge_powerup(self, player);
  player thread zm_powerups::powerup_vo("bonus_points_solo");
}

function shield_charge_powerup(item, player) {
  if(isDefined(player.hasriotshield) && player.hasriotshield) {
    player givestartammo(player.weaponriotshield);
  }
  level thread shield_on_hud(item, player.team);
}

function shield_on_hud(drop_item, player_team) {
  self endon("disconnect");
  hudelem = hud::createserverfontstring("objective", 2, player_team);
  hudelem hud::setpoint("TOP", undefined, 0, level.zombie_vars["zombie_timer_offset"] - (level.zombie_vars["zombie_timer_offset_interval"] * 2));
  hudelem.sort = 0.5;
  hudelem.alpha = 0;
  hudelem fadeovertime(0.5);
  hudelem.alpha = 1;
  if(isDefined(drop_item)) {
    hudelem.label = drop_item.hint;
  }
  hudelem thread full_ammo_move_hud(player_team);
}

function full_ammo_move_hud(player_team) {
  players = getplayers(player_team);
  players[0] playsoundtoteam("zmb_full_ammo", player_team);
  wait(0.5);
  move_fade_time = 1.5;
  self fadeovertime(move_fade_time);
  self moveovertime(move_fade_time);
  self.y = 270;
  self.alpha = 0;
  wait(move_fade_time);
  self destroy();
}

function function_f3127c4f() {
  level flagsys::wait_till("");
  wait(1);
  zm_devgui::add_custom_devgui_callback( & function_b6937313);
  adddebugcommand("");
  adddebugcommand("");
}

function function_b6937313(cmd) {
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