/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_chamber.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\zm_tomb_utility;
#namespace zm_tomb_chamber;

function autoexec __init__sytem__() {
  system::register("zm_tomb_chamber", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "divider_fx", 21000, 1, "counter");
}

function main() {
  level thread chamber_wall_change_randomly();
  a_walls = getEntArray("chamber_wall", "script_noteworthy");
  foreach(e_wall in a_walls) {
    e_wall.down_origin = e_wall.origin;
    e_wall.up_origin = (e_wall.origin[0], e_wall.origin[1], e_wall.origin[2] + 1000);
  }
  level.n_chamber_wall_active = 0;
  level flag::wait_till("start_zombie_round_logic");
  wait(3);
  foreach(e_wall in a_walls) {
    e_wall moveto(e_wall.up_origin, 0.05);
    e_wall connectpaths();
  }
  level thread chamber_devgui();
}

function chamber_devgui() {
  setDvar("", 5);
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  level thread watch_chamber_wall();
}

function watch_chamber_wall() {
  while(true) {
    if(getdvarint("") != 5) {
      chamber_change_walls(getdvarint(""));
      setDvar("", 5);
    }
    wait(0.05);
  }
}

function cap_value(val, min, max) {
  if(val < min) {
    return min;
  }
  if(val > max) {
    return max;
  }
  return val;
}

function chamber_change_walls(n_element) {
  if(n_element == level.n_chamber_wall_active) {
    return;
  }
  e_current_wall = undefined;
  e_new_wall = undefined;
  playsoundatposition("zmb_chamber_wallchange", (10342, -7921, -272));
  a_walls = getEntArray("chamber_wall", "script_noteworthy");
  foreach(e_wall in a_walls) {
    if(e_wall.script_int == n_element) {
      e_wall thread move_wall_down();
      continue;
    }
    if(e_wall.script_int == level.n_chamber_wall_active) {
      e_wall thread move_wall_up();
    }
  }
  level.n_chamber_wall_active = n_element;
}

function is_chamber_occupied() {
  a_players = getplayers();
  foreach(e_player in a_players) {
    if(is_point_in_chamber(e_player.origin)) {
      return true;
    }
  }
  return false;
}

function is_point_in_chamber(v_origin) {
  if(!isDefined(level.s_chamber_center)) {
    level.s_chamber_center = struct::get("chamber_center", "targetname");
    level.s_chamber_center.radius_sq = level.s_chamber_center.script_float * level.s_chamber_center.script_float;
  }
  return distance2dsquared(level.s_chamber_center.origin, v_origin) < level.s_chamber_center.radius_sq;
}

function chamber_wall_change_randomly() {
  level flag::wait_till("start_zombie_round_logic");
  a_element_enums = array(1, 2, 3, 4);
  level endon("stop_random_chamber_walls");
  n_elem_prev = undefined;
  while(true) {
    while(!is_chamber_occupied()) {
      wait(1);
    }
    level flag::wait_till("any_crystal_picked_up");
    n_round = cap_value(level.round_number, 10, 30);
    f_progression_pct = (n_round - 10) / (30 - 10);
    n_change_wall_time = lerpfloat(15, 5, f_progression_pct);
    n_elem = array::random(a_element_enums);
    arrayremovevalue(a_element_enums, n_elem, 0);
    if(isDefined(n_elem_prev)) {
      a_element_enums[a_element_enums.size] = n_elem_prev;
    }
    chamber_change_walls(n_elem);
    wait(n_change_wall_time);
    n_elem_prev = n_elem;
  }
}

function move_wall_up() {
  self moveto(self.up_origin, 1);
  self waittill("movedone");
  self connectpaths();
}

function move_wall_down() {
  self moveto(self.down_origin, 1);
  self waittill("movedone");
  zm_tomb_utility::rumble_players_in_chamber(2, 0.1);
  self clientfield::increment("divider_fx");
  self disconnectpaths();
}

function random_shuffle(a_items, item) {
  b_done_shuffling = undefined;
  if(!isDefined(item)) {
    item = a_items[a_items.size - 1];
  }
  while(!(isDefined(b_done_shuffling) && b_done_shuffling)) {
    a_items = array::randomize(a_items);
    if(a_items[0] != item) {
      b_done_shuffling = 1;
    }
    wait(0.05);
  }
  return a_items;
}

function tomb_chamber_find_exit_point() {
  self endon("death");
  player = getplayers()[0];
  dist_zombie = 0;
  dist_player = 0;
  dest = 0;
  away = vectornormalize(self.origin - player.origin);
  endpos = self.origin + vectorscale(away, 600);
  locs = array::randomize(level.zm_loc_types["wait_location"]);
  for(i = 0; i < locs.size; i++) {
    dist_zombie = distancesquared(locs[i].origin, endpos);
    dist_player = distancesquared(locs[i].origin, player.origin);
    if(dist_zombie < dist_player) {
      dest = i;
      break;
    }
  }
  self notify("stop_find_flesh");
  self notify("zombie_acquire_enemy");
  if(isDefined(locs[dest])) {
    self setgoalpos(locs[dest].origin);
  }
  self.b_wandering_in_chamber = 1;
  level flag::wait_till("player_active_in_chamber");
  self.b_wandering_in_chamber = 0;
}

function chamber_zombies_find_poi() {
  zombies = getaiteamarray(level.zombie_team);
  for(i = 0; i < zombies.size; i++) {
    if(isDefined(zombies[i].b_wandering_in_chamber) && zombies[i].b_wandering_in_chamber) {
      continue;
    }
    if(!is_point_in_chamber(zombies[i].origin)) {
      continue;
    }
    zombies[i] thread tomb_chamber_find_exit_point();
  }
}

function tomb_is_valid_target_in_chamber() {
  a_players = getplayers();
  foreach(e_player in a_players) {
    if(e_player laststand::player_is_in_laststand()) {
      continue;
    }
    if(isDefined(e_player.b_zombie_blood) && e_player.b_zombie_blood || (isDefined(e_player.ignoreme) && e_player.ignoreme)) {
      continue;
    }
    if(!is_point_in_chamber(e_player.origin)) {
      continue;
    }
    return true;
  }
  return false;
}

function is_player_in_chamber() {
  if(is_point_in_chamber(self.origin)) {
    return true;
  }
  return false;
}

function tomb_watch_chamber_player_activity() {
  level flag::init("player_active_in_chamber");
  level flag::wait_till("start_zombie_round_logic");
  while(true) {
    wait(1);
    if(is_chamber_occupied()) {
      if(tomb_is_valid_target_in_chamber()) {
        level flag::set("player_active_in_chamber");
      } else {
        level flag::clear("player_active_in_chamber");
        chamber_zombies_find_poi();
      }
    }
  }
}