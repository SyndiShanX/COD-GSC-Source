/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_shrimps.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include animscripts\utility;

start_shrimp_path(shrimp_effect, str_path_start, min_speed, max_speed, min_respawn_delay, max_respawn_delay, start_delay, str_kill_flag, activate_all_paths) {
  level endon("stop_shrimps");

  if(isDefined(start_delay))
    wait(start_delay);

  a_all_path_starts = getstructarray(str_path_start, "targetname");
  assert(isDefined(a_all_path_starts), "Shrimp missing start struct - " + str_path_start);

  if(!isDefined(activate_all_paths))
    only_one_path_required = randomint(a_all_path_starts.size);
  else
    only_one_path_required = undefined;

  for(i = 0; i < a_all_path_starts.size; i++) {
    if(!isDefined(only_one_path_required) || only_one_path_required == i) {
      s_path_start = a_all_path_starts[i];
      level thread _setup_shrimp_path(shrimp_effect, s_path_start, min_speed, max_speed, min_respawn_delay, max_respawn_delay, str_kill_flag);
    }
  }
}

_setup_shrimp_path(shrimp_effect, s_path_start, min_speed, max_speed, min_respawn_delay, max_respawn_delay, str_kill_flag) {
  level endon("stop_shrimps");

  while(true) {
    if(isDefined(str_kill_flag)) {
      if(flag(str_kill_flag))
        return;
    }

    speed = randomfloatrange(min_speed, max_speed);
    level thread shrimp_move_down_spline(shrimp_effect, s_path_start, speed, 0, str_kill_flag);
    delay = randomfloatrange(min_respawn_delay, max_respawn_delay);
    wait(delay);
  }
}

shrimp_move_down_spline(shrimp_effect, s_path_start, move_speed, start_delay, str_kill_flag) {
  level endon("stop_shrimps");

  if(isDefined(start_delay))
    wait(start_delay);

  e_move = spawn("script_model", s_path_start.origin);
  e_move setmodel("tag_origin");
  playfxontag(shrimp_effect, e_move, "tag_origin");

  for(s_dest_struct = getstruct(s_path_start.target, "targetname"); isDefined(s_dest_struct); s_dest_struct = getstruct(s_dest_struct.target, "targetname")) {
    v_dir = vectornormalize(s_dest_struct.origin - e_move.origin);
    dist = distance(s_dest_struct.origin, e_move.origin);
    last_dist = dist;

    while(dist > move_speed && dist <= last_dist) {
      v_fwd = vectornormalize(level.player.origin - e_move.origin);
      v_fwd = anglestoforward(v_fwd);
      e_move.angles = v_fwd;
      e_move.origin = e_move.origin + v_dir * move_speed;
      dist = distance(s_dest_struct.origin, e_move.origin);

      if(isDefined(str_kill_flag)) {
        if(flag(str_kill_flag)) {
          e_move delete();
          return;
        }
      }

      wait 0.01;
    }

    if(!isDefined(s_dest_struct.target)) {
      break;
    }
  }

  e_move delete();
}