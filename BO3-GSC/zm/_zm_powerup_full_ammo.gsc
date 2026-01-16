/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_full_ammo.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\clientfield_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_placeable_mine;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#namespace zm_powerup_full_ammo;

function autoexec __init__sytem__() {
  system::register("zm_powerup_full_ammo", & __init__, undefined, undefined);
}

function __init__() {
  zm_powerups::register_powerup("full_ammo", & grab_full_ammo);
  if(tolower(getdvarstring("g_gametype")) != "zcleansed") {
    zm_powerups::add_zombie_powerup("full_ammo", "p7_zm_power_up_max_ammo", & "ZOMBIE_POWERUP_MAX_AMMO", & zm_powerups::func_should_always_drop, 0, 0, 0);
  }
}

function grab_full_ammo(player) {
  level thread full_ammo_powerup(self, player);
  player thread zm_powerups::powerup_vo("full_ammo");
}

function full_ammo_powerup(drop_item, player) {
  players = getplayers(player.team);
  if(isdefined(level._get_game_module_players)) {
    players = [
      [level._get_game_module_players]
    ](player);
  }
  level notify("zmb_max_ammo_level");
  for (i = 0; i < players.size; i++) {
    if(players[i] laststand::player_is_in_laststand()) {
      continue;
    }
    if(isdefined(level.check_player_is_ready_for_ammo)) {
      if([
          [level.check_player_is_ready_for_ammo]
        ](players[i]) == 0) {
        continue;
      }
    }
    primary_weapons = players[i] getweaponslist(1);
    players[i] notify("zmb_max_ammo");
    players[i] notify("zmb_lost_knife");
    players[i] zm_placeable_mine::disable_all_prompts_for_player();
    for (x = 0; x < primary_weapons.size; x++) {
      if(level.headshots_only && zm_utility::is_lethal_grenade(primary_weapons[x])) {
        continue;
      }
      if(isdefined(level.zombie_include_equipment) && isdefined(level.zombie_include_equipment[primary_weapons[x]]) && (!(isdefined(level.zombie_equipment[primary_weapons[x]].refill_max_ammo) && level.zombie_equipment[primary_weapons[x]].refill_max_ammo))) {
        continue;
      }
      if(isdefined(level.zombie_weapons_no_max_ammo) && isdefined(level.zombie_weapons_no_max_ammo[primary_weapons[x].name])) {
        continue;
      }
      if(zm_utility::is_hero_weapon(primary_weapons[x])) {
        continue;
      }
      if(players[i] hasweapon(primary_weapons[x])) {
        players[i] givemaxammo(primary_weapons[x]);
      }
    }
  }
  level thread full_ammo_on_hud(drop_item, player.team);
}

function full_ammo_on_hud(drop_item, player_team) {
  players = getplayers(player_team);
  players[0] playsoundtoteam("zmb_full_ammo", player_team);
  if(isdefined(drop_item)) {
    luinotifyevent(&"zombie_notification", 1, drop_item.hint);
  }
}