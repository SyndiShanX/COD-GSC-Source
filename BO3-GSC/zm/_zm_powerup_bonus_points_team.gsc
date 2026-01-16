/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_bonus_points_team.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\clientfield_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_powerup_bonus_points_team;

function autoexec __init__sytem__() {
  system::register("zm_powerup_bonus_points_team", & __init__, undefined, undefined);
}

function __init__() {
  zm_powerups::register_powerup("bonus_points_team", & grab_bonus_points_team);
  if(tolower(getdvarstring("g_gametype")) != "zcleansed") {
    zm_powerups::add_zombie_powerup("bonus_points_team", "zombie_z_money_icon", & "ZOMBIE_POWERUP_BONUS_POINTS", & zm_powerups::func_should_never_drop, 0, 0, 0);
  }
}

function grab_bonus_points_team(player) {
  level thread bonus_points_team_powerup(self);
  player thread zm_powerups::powerup_vo("bonus_points_team");
}

function bonus_points_team_powerup(item) {
  points = randomintrange(1, 25) * 100;
  if(isdefined(level.bonus_points_powerup_override)) {
    points = [
      [level.bonus_points_powerup_override]
    ]();
  }
  players = getplayers();
  for (i = 0; i < players.size; i++) {
    if(!players[i] laststand::player_is_in_laststand() && !players[i].sessionstate == "spectator") {
      players[i] zm_score::player_add_points("bonus_points_powerup", points);
    }
  }
}