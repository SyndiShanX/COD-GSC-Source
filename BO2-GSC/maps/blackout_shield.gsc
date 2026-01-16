/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_shield.gsc
**************************************/

#include common_scripts\utility;
#include maps\_anim;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_objectives;
#include maps\_scene;
#include maps\_utility;
#include maps\blackout_util;

get_align_ent() {
  assert(isDefined(level.m_shield.player_rig));

  if(!isDefined(level.m_shield.align)) {
    level.m_shield.align = spawn("script_model", level.m_shield.player_rig.origin);
    level.m_shield.align.angles = level.m_shield.player_rig.angles;
  }

  return level.m_shield.align;
}

shield_raise_or_lower_gun() {
  state = level.meatshield_state;
  level.meatshield_state = "nil";

  if(state == "standing")
    shield_anim_stand();
  else
    shield_anim_move();
}

shield_anim_stand() {
  if(level.meatshield_state == "standing") {
    return;
  }
  level.m_shield.player_rig thread anim_loop(level.m_shield.player_rig, "mason_stand_loop");
  level.m_shield.player_rig thread anim_loop(level.m_shield.victim, "victim_stand_loop");
  level.m_shield.player_rig thread anim_loop(level.m_shield.weapon, "gun_stand_loop");
  level.meatshield_state = "standing";
}

shield_anim_move() {
  if(level.meatshield_state == "moving") {
    return;
  }
  level.m_shield.player_rig thread anim_loop(level.m_shield.player_rig, "mason_move_loop");
  level.m_shield.player_rig thread anim_loop(level.m_shield.victim, "victim_move_loop");
  level.m_shield.player_rig thread anim_loop(level.m_shield.weapon, "gun_move_loop");
  level.meatshield_state = "moving";
}

shield_add_enemy(ai_enemy) {
  if(!isDefined(level.m_shield.enemies))
    level.m_shield.enemies = [];

  arrayinsert(level.m_shield.enemies, ai_enemy, 0);
}

shield_run(e_victim, str_volume, str_scene_name) {
  level thread run_scene_and_delete(str_scene_name);
  level.m_shield = spawnstruct();
  wait 0.1;
  a_rigs = getentarray("player_body", "targetname");
  m_player_rig = a_rigs[0];
  end_pos = getstruct("meat_shield_end_struct", "targetname");
  max_turn_dot = cos(40);
  turning_center_vec = anglestoforward(end_pos.angles);
  level.m_shield.player_rig = m_player_rig;
  level.m_shield.victim = e_victim;
  level.m_shield.weapon = getent("shield_gun", "targetname");
  scene_wait(str_scene_name);
  flag_set("meat_shield_start");
  level.m_shield.fwd = 0.0;
  level.m_shield.turn = 0.0;
  level thread meatshield_input(1.2, 2.0);
  e_victim teleport(level.m_shield.player_rig.origin, level.m_shield.player_rig.angles);
  level.m_shield.weapon.origin = level.m_shield.player_rig.origin;
  level.meatshield_state = "nil";
  shield_anim_stand();
  wait_network_frame();
  link_offset = (0, 0, 0);
  e_victim linkto(level.m_shield.player_rig, "tag_origin", link_offset);
  level.m_shield.weapon linkto(level.m_shield.player_rig, "tag_origin", link_offset);
  align_ent = get_align_ent();
  level.m_shield.player_rig linkto(align_ent);
  level.player hideviewmodel();
  level.player disableweapons();
  level.player playerlinktodelta(level.m_shield.player_rig, "tag_player", 1, 0, 0, 30, 0, 0);
  valid_spaces = getentarray(str_volume, "targetname");

  while(!flag("meat_shield_done")) {
    invalid_space_fwd = 0;

    if(0) {
      pos_player = align_ent.origin;
      fvec_player = anglestoforward(align_ent.angles);
      pos_victim = e_victim gettagorigin("tag_origin");
      fvec_victim = anglestoforward(e_victim gettagangles("tag_origin"));
      draw_arrow_time(pos_player, pos_player + fvec_player * 64, (0, 1, 0), 0.1);
      draw_arrow_time(pos_victim, pos_victim + fvec_victim * 64, (1, 0, 0), 0.1);
    }

    if(level.m_shield.turn != 0.0) {
      new_vec = anglestoforward((0, align_ent.angles[1] + level.m_shield.turn, 0));
      new_vec_dot = vectordot(new_vec, turning_center_vec);

      if(new_vec_dot > max_turn_dot)
        align_ent rotateyaw(level.m_shield.turn, 0.05);
    }

    if(level.m_shield.fwd != 0.0) {
      rvec = anglestoright(level.player.angles);
      fvec = vectornormalize(end_pos.origin - level.player.origin);
      dist_sq_to_end = distance2dsquared(align_ent.origin, end_pos.origin);

      if(dist_sq_to_end < 256) {
        shield_anim_move();
        flag_set("meat_shield_done");
        end_pos = getstruct("meat_shield_end_struct", "targetname");
        align_node = get_align_ent();
        align_node moveto(end_pos.origin, 3.0);
        align_node rotateto(end_pos.angles, 3.0);
        wait 3.2;
        shield_anim_stand();
        invalid_space_fwd = 1;
      }

      v_newpos = align_ent.origin;

      if(!invalid_space_fwd)
        v_newpos = v_newpos + level.m_shield.fwd * fvec;

      if(!invalid_space_fwd)
        align_ent moveto(v_newpos, 0.05);
    }

    if(level.m_shield.fwd == 0 || invalid_space_fwd)
      shield_anim_stand();
    else
      shield_anim_move();

    wait 0.01;
  }

  level.m_shield.victim unlink();
  level.m_shield.weapon unlink();
  level.m_shield.player_rig unlink();

  if(isDefined(level.m_shield.align))
    level.m_shield.align delete();

  level.m_shield = undefined;
}

meatshield_process_proximity_speed_scalar() {
  while(!flag("meat_shield_done")) {
    if(isDefined(level.m_shield.enemies)) {
      dist_closest = 128;

      foreach(ai in level.m_shield.enemies) {
        dist = distance2d(level.m_shield.player_rig.origin, ai.origin);

        if(dist < dist_closest)
          dist_closest = dist;
      }

      level.m_shield.proximity_speed_scalar = dist_closest / 128;
    }

    wait 0.5;
  }
}

meatshield_input(move_scale, turn_scale) {
  level.m_shield.proximity_speed_scalar = 1.0;
  level thread meatshield_process_proximity_speed_scalar();

  while(!flag("meat_shield_done")) {
    v_lstick = level.player getnormalizedmovement();
    v_rstick = level.player getnormalizedcameramovement();
    fwd_back = v_lstick[0];

    if(fwd_back < 0.02)
      fwd_back = 0.0;

    level.m_shield.fwd = fwd_back * move_scale * level.m_shield.proximity_speed_scalar;
    turn_val = v_rstick[1];

    if(turn_val < 0.02 && turn_val > 0.02 * -1)
      turn_val = 0.0;

    level.m_shield.turn = turn_val * -1 * turn_scale;
    wait_network_frame();
  }
}