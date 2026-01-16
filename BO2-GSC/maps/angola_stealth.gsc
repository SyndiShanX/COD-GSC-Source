/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_stealth.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\angola_2_util;
#include maps\angola_stealth;

player_start_stealth_battle() {
  level endon("player_position_located");
  level endon("reset_patrol");
  level thread monitor_player_stealth_state();
  level thread patrol_check_for_player_firing();
  level.player.stealth_num_times_player_seen = 0;
  level.player.stealth_visible_dot = 0.7;
  level.player.ground_visible_distance = 1000;
  level.player.stealth_visible_distance = level.player.ground_visible_distance;
  level.stealth_spotted_time_scale = 1.0;

  while(true) {
    if(isDefined(level.player.climbing_tree))
      level.player.stealth_visible_distance = 60;
    else
      level.player.stealth_visible_distance = level.player.ground_visible_distance;

    wait 0.01;
  }
}

patrol_set_ground_visibility_distance(new_distance) {
  level.player.ground_visible_distance = new_distance;
}

monitor_player_stealth_state() {
  level endon("reset_patrol");
  level.player.stealth_cover_broken = 0;
  level waittill("player_position_located");
  level.player.stealth_cover_broken = 1;
}

is_player_in_stealth_mode() {
  if(isDefined(level.player.stealth_cover_broken) && level.player.stealth_cover_broken == 0)
    return true;

  return false;
}

spawn_fn_ai_jungle_patrol(player_favourate_enemy, str_category, ignore_surpression, attack_player_if_located, kill_if_path_ends) {
  if(!is_player_in_stealth_mode()) {
    self entity_common_spawn_setup(player_favourate_enemy, str_category, ignore_surpression, 0);
    self.goalradius = 2048;
    return;
  }

  self endon("death");
  level endon("player_position_located");
  self entity_common_spawn_setup(player_favourate_enemy, str_category, ignore_surpression, 0);
  self.attack_player_if_located = attack_player_if_located;
  self thread patrol_search_for_player();
  self thread ai_patrol_return_to_combat();
  self.animname = "misc_patrol";

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "walk")
    self change_movemode("cqb_walk");
  else
    self set_run_anim("walk");

  nd_node = getnode(self.script_string, "targetname");
  self.goalradius = 48;
  self waittill("goal");
  self.target = undefined;
  self.disable_node_arrivals = 0;
  change_route_frac = 40;

  if(isDefined(self.script_int))
    change_arrivals_anim_frac = self.script_int;
  else
    change_arrivals_anim_frac = 60;

  min_node_wait_time = 1.0;
  max_node_wait_time = 3.5;

  while(isDefined(nd_node.target)) {
    str_next_node_name = nd_node.target;

    if(isDefined(nd_node.script_noteworthy)) {
      if(randomfloatrange(0, 100) <= change_route_frac)
        str_next_node_name = nd_node.script_noteworthy;
    }

    nd_node = getnode(str_next_node_name, "targetname");
    self.goalradius = 48;
    self setgoalpos(nd_node.origin);
    self update_node_arrivals(change_arrivals_anim_frac);
    self waittill("goal");

    if(isDefined(nd_node.script_string) && nd_node.script_string == "break_patrol")
      level notify("player_position_located");

    if(self.disable_node_arrivals == 0) {
      delay = randomfloatrange(min_node_wait_time, max_node_wait_time);
      wait(delay);
    }
  }

  if(isDefined(kill_if_path_ends) && kill_if_path_ends == 1) {
    self delete();
    return;
  }

  level notify("player_position_located");
  self.goalradius = 2048;
}

update_node_arrivals(disable_frac) {
  if(self.disable_node_arrivals == 0)
    self.disable_node_arrivals = 1;
  else {
    frac = randomfloatrange(0, 100);

    if(frac <= disable_frac)
      self.disable_node_arrivals = 0;
  }

  self ai_set_node_approach_anims(self.disable_node_arrivals);
}

ai_set_node_approach_anims(active) {
  self.disablearrivals = active;
  self.disableexits = active;
  self.disableturns = active;
}

patrol_search_for_player() {
  self endon("death");
  self endon("kill_patrol");
  level endon("player_position_located");
  level endon("reset_patrol");
  self.ignoreall = 1;
  self.can_see_player_start_time = undefined;

  while(true) {
    str_message = undefined;
    dist_to_player = distance(level.player.origin, self.origin);

    if(dist_to_player < level.player.stealth_visible_distance) {
      str_message = "Player Behind Me: " + dist_to_player;
      v_ai_forward = anglestoforward(self.angles);
      v_dir_to_player = vectornormalize(level.player.origin - self.origin);
      dot = vectordot(v_ai_forward, v_dir_to_player);

      if(dot > level.player.stealth_visible_dot) {
        up = anglestoup(vectorscale((0, 1, 0), 90.0));
        v_start = self.origin + up * 60;
        v_end = level.player geteye();
        trace = bullettrace(v_start, v_end, 0, self);

        if(trace["fraction"] == 1) {
          str_message = "Looking at Player: " + dist_to_player;

          if(!isDefined(self.can_see_player_start_time)) {
            self.can_see_player_start_time = gettime();
            level.player.stealth_num_times_player_seen++;
          }
        } else {
          str_message = "Player Hidden: " + dist_to_player;
          self.can_see_player_start_time = undefined;
        }
      }
    } else {
      str_message = "OUT OF RANGE";
      self.can_see_player_start_time = undefined;
    }

    if(isDefined(str_message)) {
    }

    if(isDefined(self.can_see_player_start_time)) {
      time = gettime();
      alerted_time = (time - self.can_see_player_start_time) / 1000;

      if(level.player.stealth_num_times_player_seen == 1)
        can_see_player_time = 2.0;
      else if(level.player.stealth_num_times_player_seen == 2)
        can_see_player_time = 1.5;
      else
        can_see_player_time = 1.25;

      can_see_player_time = can_see_player_time * level.stealth_spotted_time_scale;

      if(alerted_time > can_see_player_time) {
        if(isDefined(self.attack_player_if_located) && self.attack_player_if_located == 1) {
          self thread aim_at_target(level.player);
          self thread shoot_at_target(level.player);
        }

        level notify("player_position_located");
        return;
      }
    }

    wait 0.01;
  }
}

patrol_check_for_player_firing() {
  level endon("player_position_located");
  level endon("patrol_dont_check_player_fire");
  level endon("reset_patrol");
  level.player thread fire_grenade_watch();

  while(true) {
    level.player waittill("weapon_fired");
    str_current_weapon = level.player getcurrentweapon();

    if(str_current_weapon != "beartrap_sp") {
      break;
    }
  }

  patrol_alerted_find_player_quickly(10, 0.5);
}

fire_grenade_watch() {
  level endon("reset_patrol");

  while(true) {
    self waittill("grenade_fire", grenade, weapon_name);

    if(isDefined(weapon_name)) {
      if(weapon_name != "beartrap_sp") {
        patrol_alerted_find_player_quickly(5, 0.5);
        return;
      }
    }
  }
}

patrol_alerted_find_player_quickly(tree_search_time, ground_search_time) {
  level endon("player_position_located");

  if(!is_player_in_stealth_mode()) {
    return;
  }
  if(isDefined(level.player.climbing_tree)) {
    a_enemies = getaiarray("axis");

    for(i = 0; i < a_enemies.size; i++) {
      a_enemies[i].animname = "alerted_patrol";
      a_enemies[i] set_run_anim("walk");
    }

    wait(tree_search_time);
  } else
    wait(ground_search_time);

  level notify("player_position_located");
}

ai_patrol_return_to_combat() {
  self endon("death");
  self endon("kill_patrol");
  level waittill("player_position_located");
  wait 0.1;
  self.ignoreall = 0;
  self.goalradius = 2048;
  self clear_run_anim();
}

player_climbs_tree_confuses_ai() {
  if(!is_player_in_stealth_mode()) {
    a_enemies = getaiarray("axis");

    for(i = 0; i < a_enemies.size; i++)
      a_enemies[i] thread temp_confuse_ai_by_tree_climb(randomfloatrange(8.0, 9.0));
  }
}

temp_confuse_ai_by_tree_climb(delay_time) {
  self endon("death");
  self.ignoreall = 1;
  self.animname = "alerted_patrol";
  self set_run_anim("walk");
  wait(delay_time);
  self.ignoreall = 0;
  self.goalradius = 2048;
  self clear_run_anim();
}

setup_stealth_event(str_save_name, str_patrol_spawner_targetname, str_category, kill_guy_if_path_ends, fail_mission_if_stealth_broken) {
  level notify("reset_patrol");
  level thread player_start_stealth_event(str_save_name);
  wait 0.01;
  a_spawners = getentarray(str_patrol_spawner_targetname, "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, maps\angola_stealth::spawn_fn_ai_jungle_patrol, 0, str_category, 0, 1, kill_guy_if_path_ends);

  if(isDefined(fail_mission_if_stealth_broken) && fail_mission_if_stealth_broken == 1)
    player_fails_mission_if_stealth_broken(1);
}

player_start_stealth_event(str_stealth_name) {
  if(isDefined(str_stealth_name))
    autosave_by_name(str_stealth_name);

  maps\angola_stealth::player_start_stealth_battle();
}

player_stealth_override_spotted_params(time_scale, vis_dot) {
  level.stealth_spotted_time_scale = time_scale;

  if(isDefined(vis_dot))
    level.player.stealth_visible_dot = vis_dot;
}

player_fails_mission_if_stealth_broken(delay) {
  level endon("reset_patrol");
  level waittill("player_position_located");
  wait(delay);
  missionfailedwrapper(&"ANGOLA_2_PLAYER_COVER_BROKEN_SPOTTED");
}