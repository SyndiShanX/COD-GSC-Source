/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_jungle_stealth_carry.gsc
************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\angola_2_util;
#include maps\_anim;

debug_draw_star() {
  for(count = 0; 1; count++) {
    record3dtext("Woods Origin " + count + "\\no:" + self.origin + "\\na:" + self.angles, self.origin, (0.9, 0.7, 0.6));

    wait 0.05;
  }
}

set_player_rig(str_startup_scene) {
  level.m_player_rig = get_model_or_models_from_scene(str_startup_scene, "player_body_river");
  level.ai_woods thread debug_draw_star();
  level.ai_woods anim_set_blend_in_time(0.0);
  level.ai_woods anim_set_blend_out_time(0.0);
  level.m_player_rig anim_set_blend_in_time(0.0);
  level.m_player_rig anim_set_blend_out_time(0.0);
}

mason_carry_woods(str_startup_scene) {
  if(isDefined(str_startup_scene)) {
    level thread run_scene_first_frame(str_startup_scene);

    if(!isDefined(level.m_player_rig))
      level.m_player_rig = get_model_or_models_from_scene(str_startup_scene, "player_body_river");

    level.ai_woods thread debug_draw_star();
    level.ai_woods anim_set_blend_in_time(0.0);
    level.ai_woods anim_set_blend_out_time(0.0);
    level.m_player_rig anim_set_blend_in_time(0.0);
    level.m_player_rig anim_set_blend_out_time(0.0);
  }

  level.m_player_spot = spawn("script_model", level.m_player_rig.origin);
  level.m_player_spot setmodel("tag_origin");
  level.m_player_spot.angles = level.m_player_rig.angles;
  level.m_player_spot thread carry_movement_sounds();
  level.default_mason_carry_crouch_speed = 155;
  level.mason_carry_crouch_speed = level.default_mason_carry_crouch_speed;
  flag_set("js_mason_is_carrying_woods");
  setup_mason_carry_woods();
}

carry_movement_sounds() {
  wait 0.2;
  self thread carry_sound_watcher();

  while(true) {
    self waittill("sound_run");
    self playsound("evt_anim_woods_carry_lp", 0.7);
    self playsound("fly_gear_run_plr");
    wait(randomfloatrange(0.45, 0.65));
  }
}

set_carry_crouch_speed(speed) {
  level.mason_carry_crouch_speed = speed;
}

carry_sound_watcher() {
  while(true) {
    self waittill("sound_stop");
    self stoploopsound(1);
    wait 0.5;
  }
}

is_mason_stealth_crouched() {
  return level.woods_carry_is_crouched;
}

setup_mason_carry_woods() {
  level.m_player_rig linkto(level.m_player_spot, "tag_origin");
  level.m_player_rig.animname = "player_body_river";
  level.m_player_spot thread anim_loop_aligned(level.m_player_rig, "mason_carry_idle");
  link_player_and_woods_together();
  level.ai_woods.animname = "woods";
  level.m_player_rig thread anim_loop_aligned(level.ai_woods, "mason_carry_idle");
  wait 0.1;
  level thread mason_movement();
}

link_player_and_woods_together() {
  level.ai_woods linkto(level.m_player_rig, "tag_origin");
}

mason_movement() {
  level.woods_carry_complete = 0;
  level.woods_carry_height_offset = vectorscale((0, 0, 1), 16.0);
  level.woods_carry_delay_walk_frames = 0;
  level.woods_carry_is_moving = 0;
  level.woods_carry_is_crouched = 0;
  level.woods_carry_disable_movement = 0;
  level.woods_carry_disable_crouch = 0;
  level.m_player_rig anim_set_blend_in_time(0.2);
  level.m_player_rig anim_set_blend_out_time(0.2);
  level.ai_woods anim_set_blend_in_time(0.2);
  level.ai_woods anim_set_blend_out_time(0.2);
  level thread mason_movement_rotation(level.m_player_rig);
  level thread mason_movement_translation(level.m_player_rig);
  level.player thread mason_carry_crouch_button();

  while(!level.woods_carry_complete) {
    if(flag("pause_woods_carry")) {
      wait 0.05;
      continue;
    }

    if(flag("woods_carry_cough")) {
      level.woods_carry_disable_movement = 1;
      level.m_player_spot notify("sound_stop");
      level.m_player_spot notify("stop_loop");
      level.m_player_rig notify("stop_loop");
      level.woods_carry_is_moving = 1;
      level.m_player_spot thread anim_single(level.m_player_rig, "mason_carry_coughing");
      level.m_player_rig anim_single(level.ai_woods, "mason_carry_coughing");
      flag_clear("woods_carry_cough");
      level.woods_carry_delay_walk_frames = 2;
      level.woods_carry_disable_movement = 0;
    } else if(level.mason_carry_button_pressed && (isDefined(level.woods_carry_disable_crouch) && !level.woods_carry_disable_crouch)) {
      level.woods_carry_is_crouched = 1;
      level.player setstance("crouch");
      level.woods_carry_disable_movement = 1;
      level.m_player_spot notify("stop_loop");
      level.m_player_rig notify("stop_loop");
      level.m_player_rig thread anim_single(level.ai_woods, "mason_carry_crouch_in");
      level.m_player_spot anim_single(level.m_player_rig, "mason_carry_crouch_in");
      level.m_player_spot thread anim_loop(level.m_player_rig, "mason_carry_crouch_idle");
      level.m_player_rig thread anim_loop(level.ai_woods, "mason_carry_crouch_idle");
      level.woods_carry_disable_movement = 0;
      level.woods_carry_is_moving = 0;
      level.woods_carry_delay_walk_frames = 2;
      wait 0.15;

      while(true) {
        if(level.mason_carry_button_pressed || flag("woods_carry_cough") || level.player buttonpressed("BUTTON_A")) {
          break;
        }

        wait 0.05;
      }

      while(flag("pause_woods_carry"))
        wait 0.05;

      level.woods_carry_is_crouched = 0;
      level.player setstance("stand");
      level.woods_carry_disable_movement = 1;
      level.m_player_spot notify("stop_loop");
      level.m_player_rig notify("stop_loop");
      level.m_player_spot thread anim_single_aligned(level.m_player_rig, "mason_carry_crouch_out");
      level.m_player_rig anim_single_aligned(level.ai_woods, "mason_carry_crouch_out");
      level.m_player_spot thread anim_loop_aligned(level.m_player_rig, "mason_carry_idle");
      level.m_player_rig thread anim_loop_aligned(level.ai_woods, "mason_carry_idle");
      level.woods_carry_disable_movement = 0;
      level.woods_carry_is_moving = 0;
      level.woods_carry_delay_walk_frames = 2;
      wait 0.15;
    }

    wait 0.05;
  }
}

mason_movement_translation(m_player_rig) {
  level endon("kill_player_carry");
  n_movement_crouch_speed = 35;
  v_up = (0, 0, 1);
  use_frac = 0;
  use_normal = 0;
  a_rig_and_woods = array(m_player_rig, level.ai_woods);

  while(!level.woods_carry_complete) {
    if(flag("pause_woods_carry")) {
      wait 0.05;
      continue;
    }

    if(level.woods_carry_disable_movement == 0) {
      if(level.woods_carry_is_crouched == 0)
        n_speed = level.mason_carry_crouch_speed;
      else
        n_speed = n_movement_crouch_speed;

      a_normalized_movement = level.player getnormalizedmovement();
      n_movement_strength = length(a_normalized_movement);
      rig_angles = m_player_rig.angles;
      forward = anglestoforward(rig_angles);
      right = anglestoright(rig_angles);
      speed_forward = n_speed * a_normalized_movement[0];
      speed_right = n_speed * a_normalized_movement[1];
      movement_vector = forward * speed_forward + right * speed_right;

      if(level.woods_carry_delay_walk_frames > 0) {
        level.woods_carry_delay_walk_frames--;
        n_movement_strength = 0;
      }

      if(n_movement_strength > 0) {
        v_start_pos = level.m_player_spot.origin;

        if(level.woods_carry_is_crouched == 0) {
          str_move_anim_name = "mason_carry_run";
          level.m_player_spot notify("sound_run");
        } else
          str_move_anim_name = "mason_carry_crouch_walk";

        if(!level.woods_carry_is_moving) {
          level.m_player_spot notify("sound_stop");
          level.m_player_spot notify("stop_loop");
          m_player_rig notify("stop_loop");
          level.m_player_spot thread anim_loop(m_player_rig, str_move_anim_name);
          m_player_rig thread anim_loop(level.ai_woods, str_move_anim_name);
        }

        array_thread(a_rig_and_woods, ::woods_carry_set_rate, str_move_anim_name, n_movement_strength);
        level.woods_carry_is_moving = 1;
        level.m_player_spot notify("sound_run");
        v_velocity = movement_vector;
        v_collision_velocity = movement_vector * 0.2;
        v_projected_spot = level.m_player_spot.origin + v_collision_velocity;
        v_woods_projected_spot = level.ai_woods.origin + v_collision_velocity;
        trace_start = level.m_player_spot.origin + level.woods_carry_height_offset;
        trace_end = v_projected_spot + level.woods_carry_height_offset;
        v_forward_trace = playerphysicstrace(trace_start, trace_end);
        v_final_spot = undefined;

        if(v_forward_trace != trace_end) {
          a_forward_trace = physicstrace(trace_start, trace_end);

          if(a_forward_trace == trace_end) {
            v_movement = v_forward_trace - trace_start;
            v_movement_perp = vectorcross(vectornormalize(v_movement), v_up);
            v_movement_perp_inverse = v_movement_perp * -1;
            a_movement_perp_trace = physicstrace(v_forward_trace, v_forward_trace + v_movement_perp * speed_forward);
            a_movement_perp_inverse_trace = physicstrace(v_forward_trace, v_forward_trace + v_movement_perp_inverse * speed_forward);
            bt_movement_perp_trace = bullettrace(v_forward_trace, v_forward_trace + v_movement_perp * speed_forward, 0, m_player_rig);
            bt_movement_perp_inverse_trace = bullettrace(v_forward_trace, v_forward_trace + v_movement_perp_inverse * speed_forward, 0, m_player_rig);
            frac0 = calc_frac(v_forward_trace, v_forward_trace + v_movement_perp * speed_forward, a_movement_perp_trace);
            frac1 = calc_frac(v_forward_trace, v_forward_trace + v_movement_perp_inverse * speed_forward, a_movement_perp_inverse_trace);
            a_forward_trace = a_movement_perp_trace;
            use_frac = frac0;
            use_normal = bt_movement_perp_trace["normal"];

            if(frac0 > frac1 && frac0 != 0 && frac1 != 0) {
              use_frac = frac1;
              use_normal = bt_movement_perp_inverse_trace["normal"];
              a_forward_trace = a_movement_perp_inverse_trace;
            }
          }

          v_collision_normal = use_normal;
          n_projection = 1 - use_frac;
          v_velocity = v_velocity + v_collision_normal * n_speed;
          v_collision_parallel = vectorcross(vectornormalize(v_collision_normal), v_up);
          v_collision_to_player = vectornormalize(v_forward_trace - level.player.origin);
          n_parallel_dot = vectordot(v_collision_parallel, v_collision_to_player);

          if(n_parallel_dot < 0)
            v_collision_parallel = v_collision_parallel * -1;

          v_velocity = v_velocity + v_collision_parallel * (n_projection * abs(n_parallel_dot));
        }

        v_woods_spot = level.m_player_spot.origin + vectornormalize(right) * -1 * 8;
        v_final_spot = playerphysicstrace(level.m_player_spot.origin + level.woods_carry_height_offset, level.m_player_spot.origin + v_velocity * 0.05 + level.woods_carry_height_offset);
        v_final_woods_spot = v_woods_spot + vectornormalize(v_velocity) * 16 + level.woods_carry_height_offset;
        v_final_woods_trace = playerphysicstrace(v_woods_spot + level.woods_carry_height_offset, v_final_woods_spot);

        if(v_final_woods_spot != v_final_woods_trace)
          v_final_spot = level.m_player_spot.origin;

        v_start = v_final_spot + level.woods_carry_height_offset + vectorscale((0, 0, 1), 32.0);
        v_end = v_final_spot - vectorscale((0, 0, 1), 100.0);
        ground_trace = physicstrace(v_start, v_end);
        v_final_spot = (v_final_spot[0], v_final_spot[1], ground_trace[2]);
        n_to_hudson = distance2dsquared(v_final_spot, level.ai_hudson gettagorigin("tag_eye"));

        if(n_to_hudson > 1024)
          level.m_player_spot.origin = v_final_spot;

        v_start = level.m_player_spot.origin + vectorscale((0, 0, 1), 32.0);
        v_end = level.m_player_spot.origin - vectorscale((0, 0, 1), 32.0);
        ground_trace = physicstrace(v_start, v_end);

        if(ground_trace == v_end)
          level.m_player_spot.origin = v_start_pos;
      } else {
        if(level.woods_carry_is_moving) {
          if(level.woods_carry_is_crouched == 0)
            str_anim_name = "mason_carry_idle";
          else
            str_anim_name = "mason_carry_crouch_idle";

          level.m_player_spot notify("sound_stop");
          level.m_player_spot notify("stop_loop");
          m_player_rig notify("stop_loop");
          level.m_player_spot thread anim_loop_aligned(m_player_rig, str_anim_name);
          level.m_player_rig thread anim_loop_aligned(level.ai_woods, str_anim_name);
        }

        level.woods_carry_is_moving = 0;
      }
    }

    wait 0.05;
  }
}

calc_frac(v_start, v_end, v_midpoint) {
  dist = distance(v_start, v_end);
  mag = distance(v_start, v_midpoint);

  if(dist == 0 || mag == 0)
    return 0;

  frac = mag / dist;
  return frac;
}

mason_movement_rotation(m_player_rig) {
  v_rotate_speed = vectorscale((0, 1, 0), 5.0);
  v_up = (0, 0, 1);

  while(!level.woods_carry_complete) {
    if(flag("pause_woods_carry")) {
      wait 0.05;
      continue;
    }

    if(flag("woods_carry_cough")) {
      wait 0.05;
      continue;
    }

    rig_angles = m_player_rig.angles;
    forward = anglestoforward(rig_angles);
    right = anglestoright(rig_angles);
    a_normalized_rotation = level.player getnormalizedcameramovement();

    if(a_normalized_rotation[1] >= 0.2) {
      v_rotate_vel = v_rotate_speed * a_normalized_rotation[1];
      v_woods_spot = level.m_player_spot.origin + vectornormalize(right) * -1 * 16;
      v_rotate_radius = v_woods_spot - level.m_player_spot.origin;
      v_rotation_movement = v_rotate_vel + vectorcross(v_rotate_radius, v_up);
      v_rotation_point = v_woods_spot + v_rotation_movement;
      v_final_woods_rotation = playerphysicstrace(v_woods_spot + level.woods_carry_height_offset, v_rotation_point + level.woods_carry_height_offset);
      v_difference = v_rotation_point + level.woods_carry_height_offset - v_final_woods_rotation;

      if(length(v_difference) < 0.01) {
        v_final_angles = level.m_player_spot.angles - v_rotate_speed * abs(a_normalized_rotation[1]);
        level.m_player_spot rotateto(v_final_angles, 0.05);
      }
    } else if(a_normalized_rotation[1] <= -0.2) {
      v_rotate_vel = v_rotate_speed * a_normalized_rotation[1];
      v_woods_spot = level.m_player_spot.origin + vectornormalize(right) * -1 * 16;
      v_rotate_radius = v_woods_spot - level.m_player_spot.origin;
      v_rotation_movement = v_rotate_vel + vectorcross(v_rotate_radius, v_up);
      v_rotation_point = v_woods_spot + v_rotation_movement;
      v_final_woods_rotation = playerphysicstrace(v_woods_spot + level.woods_carry_height_offset, v_rotation_point + level.woods_carry_height_offset);
      v_difference = v_rotation_point + level.woods_carry_height_offset - v_final_woods_rotation;

      if(length(v_difference) < 0.01) {
        v_final_angles = level.m_player_spot.angles + v_rotate_speed * abs(a_normalized_rotation[1]);
        level.m_player_spot rotateto(v_final_angles, 0.05);
      }
    }

    wait 0.05;
  }
}

carry_crouch_buttonpressed() {
  if(!level.console) {
    pressed = self stancebuttonpressed();

    if(!pressed && !self gamepadusedlast()) {
      binding = getkeybinding("togglecrouch");

      if(isDefined(binding)) {
        if(binding["count"])
          pressed = self buttonpressed(tolower(binding["key1"]));

        if(!pressed && binding["count"] == 2)
          pressed = self buttonpressed(tolower(binding["key2"]));
      }

      if(!pressed) {
        binding = undefined;
        binding = getkeybinding("gocrouch");

        if(isDefined(binding)) {
          if(binding["count"])
            pressed = self buttonpressed(tolower(binding["key1"]));

          if(!pressed && binding["count"] == 2)
            pressed = self buttonpressed(tolower(binding["key2"]));
        }
      }
    }

    return pressed;
  } else {
    binding = getkeybinding("+stance");
    return self buttonpressed(binding["key1"]);
  }
}

mason_carry_crouch_button() {
  level endon("kill_player_carry");
  level.mason_carry_button_pressed = 0;
  wait 1.5;

  while(!level.woods_carry_complete) {
    if(self carry_crouch_buttonpressed() || isDefined(level.__force_stand_up) && level.__force_stand_up) {
      level.__force_stand_up = undefined;
      level.mason_carry_button_pressed = 1;
      wait 0.1;
    }

    if(level.mason_carry_button_pressed == 1) {
      level.mason_carry_button_pressed = 0;

      while(true) {
        if(!self carry_crouch_buttonpressed()) {
          break;
        }

        wait 0.01;
      }
    }

    wait 0.01;
  }
}

woods_carry_set_rate(anime, n_rate) {
  self setflaggedanim("looping anim", level.scr_anim[self.animname][anime][0], 1, 0, n_rate);
}

move_player_spot_with_rig() {
  level endon("stop_player_spot");

  while(true) {
    level.m_player_spot.origin = level.m_player_rig.origin;
    level.m_player_spot.angles = level.m_player_rig.angles;
    wait 0.05;
  }
}

hide_player_carry() {
  flag_set("pause_woods_carry");
  level.ai_woods anim_set_blend_in_time(0.0);
  level.ai_woods anim_set_blend_out_time(0.0);
  level.m_player_rig anim_set_blend_in_time(0.0);
  level.m_player_rig anim_set_blend_out_time(0.0);
  level thread move_player_spot_with_rig();
  level.player unlink();
  level.ai_woods unlink();
  level.m_player_rig unlink();
  level.m_player_spot notify("sound_stop");
}

unhide_player_carry() {
  level notify("stop_player_spot");
  link_player_and_woods_together();
  level.ai_woods anim_set_blend_in_time(0.2);
  level.ai_woods anim_set_blend_out_time(0.2);
  level.m_player_rig anim_set_blend_in_time(0.2);
  level.m_player_rig anim_set_blend_out_time(0.2);
  level.m_player_spot.origin = level.m_player_rig.origin;
  level.m_player_spot.angles = level.m_player_rig.angles;
  level.m_player_rig linkto(level.m_player_spot);
  level.m_player_spot thread anim_loop_aligned(level.m_player_rig, "mason_carry_idle");
  level.m_player_rig thread anim_loop_aligned(level.ai_woods, "mason_carry_idle");
  wait 0.2;
  level.woods_carry_is_moving = 0;
  level.woods_carry_delay_walk_frames = 2;
  level.woods_carry_disable_movement = 0;
  flag_clear("pause_woods_carry");
}

kill_player_carry() {
  level notify("kill_player_carry");
  level.player unlink();
  level.ai_woods unlink();
  level.m_player_rig delete();
  level.woods_carry_complete = 1;
  level.m_player_spot notify("sound_stop");
}