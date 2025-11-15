/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_staff_revive.gsc
*************************************************/

#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_weap_staff_common;
#namespace zm_weap_staff_revive;

function autoexec __init__sytem__() {
  system::register("zm_weap_staff_revive", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_spawned( & onplayerspawned);
}

function onplayerspawned() {
  self endon("disconnect");
  self thread watch_staff_revive_fired();
}

function watch_staff_revive_fired() {
  self endon("disconnect");
  while(true) {
    self waittill("missile_fire", e_projectile, str_weapon);
    if(!str_weapon.name == "staff_revive") {
      continue;
    }
    self waittill("projectile_impact", e_ent, v_explode_point, n_radius, str_name, n_impact);
    self thread staff_revive_impact(v_explode_point);
  }
}

function staff_revive_impact(v_explode_point) {
  self endon("disconnect");
  e_closest_player = undefined;
  n_closest_dist_sq = 1024;
  playsoundatposition("wpn_revivestaff_proj_impact", v_explode_point);
  a_e_players = getplayers();
  foreach(e_player in a_e_players) {
    if(e_player == self || !e_player laststand::player_is_in_laststand()) {
      continue;
    }
    n_dist_sq = distancesquared(v_explode_point, e_player.origin);
    if(n_dist_sq < n_closest_dist_sq) {
      e_closest_player = e_player;
    }
  }
  if(isDefined(e_closest_player)) {
    e_closest_player notify("remote_revive", self);
    e_closest_player playsoundtoplayer("wpn_revivestaff_revive_plr", e_player);
    self notify("revived_player_with_upgraded_staff");
  }
}