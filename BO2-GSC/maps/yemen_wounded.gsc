/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\yemen_wounded.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#using_animtree("generic_human");

autoexec _init_wounded_anims() {
  level.scr_anim["dead_male"]["floor"] = array( % ch_gen_m_floor_armdown_legspread_onback_deathpose, % ch_gen_m_floor_armdown_onback_deathpose, % ch_gen_m_floor_armdown_onfront_deathpose, % ch_gen_m_floor_armover_onrightside_deathpose, % ch_gen_m_floor_armrelaxed_onleftside_deathpose, % ch_gen_m_floor_armsopen_onback_deathpose, % ch_gen_m_floor_armspread_legaskew_onback_deathpose, % ch_gen_m_floor_armspread_legspread_onback_deathpose, % ch_gen_m_floor_armspreadwide_legspread_onback_deathpose, % ch_gen_m_floor_armstomach_onback_deathpose, % ch_gen_m_floor_armstomach_onrightside_deathpose, % ch_gen_m_floor_armstretched_onleftside_deathpose, % ch_gen_m_floor_armstretched_onrightside_deathpose, % ch_gen_m_floor_armup_legaskew_onfront_faceleft_deathpose, % ch_gen_m_floor_armup_legaskew_onfront_faceright_deathpose, % ch_gen_m_floor_armup_onfront_deathpose);
  level.scr_anim["dead_male"]["misc"] = array( % ch_gen_m_ledge_armhanging_facedown_onfront_deathpose, % ch_gen_m_ledge_armhanging_faceright_onfront_deathpose, % ch_gen_m_ledge_armspread_faceleft_onfront_deathpose, % ch_gen_m_ledge_armspread_faceright_onfront_deathpose, % ch_gen_m_ramp_armup_onfront_deathpose, % ch_gen_m_vehicle_armdown_leanforward_deathpose, % ch_gen_m_vehicle_armdown_leanright_deathpose, % ch_gen_m_vehicle_armtogether_leanright_deathpose, % ch_gen_m_vehicle_armup_leanleft_deathpose, % ch_gen_m_vehicle_armup_leanright_deathpose, % ch_gen_m_wall_armcraddle_leanleft_deathpose, % ch_gen_m_wall_armopen_leanright_deathpose, % ch_gen_m_wall_headonly_leanleft_deathpose, % ch_gen_m_wall_legin_armcraddle_hunchright_deathpose, % ch_gen_m_wall_legspread_armdown_leanleft_deathpose, % ch_gen_m_wall_legspread_armdown_leanright_deathpose, % ch_gen_m_wall_legspread_armonleg_leanright_deathpose, % ch_gen_m_wall_low_armstomach_leanleft_deathpose, % ch_gen_m_wall_rightleg_wounded);
  level.scr_anim["wounded_male"]["floor"] = array( % ch_gen_m_floor_back_wounded, % ch_gen_m_floor_chest_wounded, % ch_gen_m_floor_dullpain_wounded, % ch_gen_m_floor_head_wounded, % ch_gen_m_floor_leftleg_wounded, % ch_gen_m_floor_shellshock_wounded);
  level.scr_anim["wounded_male"]["misc"] = array( % ch_gen_m_wall_rightleg_wounded);
  level.scr_anim["dead_female"]["floor"] = array( % ch_gen_f_floor_onback_armstomach_legcurled_deathpose, % ch_gen_f_floor_onback_armup_legcurled_deathpose, % ch_gen_f_floor_onfront_armdown_legstraight_deathpose, % ch_gen_f_floor_onfront_armup_legcurled_deathpose, % ch_gen_f_floor_onfront_armup_legstraight_deathpose, % ch_gen_f_floor_onleftside_armcurled_legcurled_deathpose, % ch_gen_f_floor_onleftside_armstretched_legcurled_deathpose, % ch_gen_f_floor_onrightside_armstomach_legcurled_deathpose, % ch_gen_f_floor_onrightside_armstretched_legcurled_deathpose);
  level.scr_anim["dead_female"]["misc"] = array( % ch_gen_f_wall_leanleft_armdown_legcurled_deathpose, % ch_gen_f_wall_leanleft_armstomach_legstraight_deathpose, % ch_gen_f_wall_leanright_armstomach_legcurled_deathpose, % ch_gen_f_wall_leanright_armstomach_legstraight_deathpose);
  level._wounded_animnames = array("dead_male", "wounded_male", "dead_female");
  level._wounded_anims = [];

  foreach(animation in level.scr_anim["dead_male"]["floor"])
  level._wounded_anims[string(animation)] = animation;

  foreach(animation in level.scr_anim["dead_male"]["misc"])
  level._wounded_anims[string(animation)] = animation;

  foreach(animation in level.scr_anim["wounded_male"]["floor"])
  level._wounded_anims[string(animation)] = animation;

  foreach(animation in level.scr_anim["wounded_male"]["misc"])
  level._wounded_anims[string(animation)] = animation;

  foreach(animation in level.scr_anim["dead_female"]["floor"])
  level._wounded_anims[string(animation)] = animation;

  foreach(animation in level.scr_anim["dead_female"]["misc"])
  level._wounded_anims[string(animation)] = animation;
}

autoexec _init_wounded() {
  level.a_wounded = [];

  foreach(trig in get_triggers()) {
    if(isDefined(trig.target)) {
      a_structs = getstructarray(trig.target);
      a_structs = _process_structs(a_structs);

      if(a_structs.size > 0) {
        a_structs = array_reverse(sort_by_distance(a_structs, trig.origin));
        trig thread _spawn_wounded_trigger(a_structs);
      }
    }
  }
}

_process_structs(a_structs) {
  a_wounded_structs = [];

  foreach(struct in a_structs) {
    if(isDefined(struct.script_animation)) {
      if(isDefined(level._wounded_anims[struct.script_animation]))
        struct.animation = level._wounded_anims[struct.script_animation];
      else {
        a_toks = strtok(struct.script_animation, ", ");

        if(isinarray(level._wounded_animnames, a_toks[0])) {
          struct.animation = getanim_from_animname(a_toks[1], a_toks[0]);

          if(isarray(struct.animation))
            struct.animation = random(struct.animation);
        } else
          continue;
      }

      if(issubstr(string(struct.animation), "floor")) {
        struct.origin = physicstrace(struct.origin + vectorscale((0, 0, 1), 64.0), struct.origin - vectorscale((0, 0, 1), 500.0));
        struct.b_trace_done = 1;
      }

      a_spawners = strtok(struct.spawner_id, ", ");
      struct.e_spawner = getent(random(a_spawners), "targetname");
      struct.spawner_id = undefined;
      a_wounded_structs[a_wounded_structs.size] = struct;
    }
  }

  return a_wounded_structs;
}

_spawn_wounded_trigger(a_structs) {
  self endon("death");
  self trigger_wait();
  level thread _spawn_wounded_trigger_spawn(a_structs, self.script_trace);
}

_spawn_wounded_trigger_spawn(a_structs, b_sight_trace) {
  foreach(struct in a_structs) {
    struct spawn_wounded_at_struct(b_sight_trace);
    wait 0.05;
  }
}

spawn_wounded(v_org, v_ang, str_animname, str_scene, str_anim_override, str_targetname, do_phys_trace) {
  if(!isDefined(v_ang))
    v_ang = (0, 0, 0);

  if(!isDefined(do_phys_trace))
    do_phys_trace = 1;

  if(isDefined(str_anim_override))
    animation = level._wounded_anims[str_anim_override];
  else {
    animation = getanim_from_animname(str_scene, str_animname);

    if(isarray(animation))
      animation = random(animation);
  }

  b_alive = 0;

  if(issubstr(string(animation), "wounded"))
    b_alive = 1;

  e_wounded = self spawn_drone(1, str_targetname, 0, b_alive);

  if(b_alive)
    e_wounded.takedamage = 1;
  else {
    e_wounded.takedamage = 0;
    e_wounded setlookattext("", & "");
    e_wounded notify("no_friendly_fire");
  }

  if(do_phys_trace && issubstr(string(animation), "floor")) {
    floor_pos = physicstrace(v_org + vectorscale((0, 0, 1), 64.0), v_org - vectorscale((0, 0, 1), 500.0));
    e_wounded.origin = (v_org[0], v_org[1], floor_pos[2]);
  } else
    e_wounded.origin = v_org;

  e_wounded.angles = v_ang;
  e_wounded setanim(animation, 1, 0, 1);
  level.a_wounded[level.a_wounded.size] = e_wounded;
  return e_wounded;
}

spawn_wounded_at_struct(b_sight_trace) {
  if(!isDefined(b_sight_trace))
    b_sight_trace = 0;

  e_wounded = self.e_spawner spawn_wounded(self.origin, self.angles, self.str_animname, self.str_scene, self.animation, self.str_targetname, !(isDefined(self.b_trace_done) && self.b_trace_done));

  if(isDefined(self.script_noteworthy))
    e_wounded.script_noteworthy = self.script_noteworthy;

  if(b_sight_trace) {
    e_wounded hide();

    if(e_wounded sightconetrace(level.player geteye(), level.player) < 0.05)
      e_wounded show();
    else
      e_wounded delete();
  }
}

set_wounded_auto_delete(n_count) {
  level.n_max_wounded = n_count;
  level thread _wounded_auto_delete_thread();
}

_wounded_auto_delete_thread() {
  level notify("_wounded_auto_delete_thread");
  level endon("_wounded_auto_delete_thread");

  if(!isDefined(level.n_max_wounded))
    level.n_max_wounded = 10;

  while(true) {
    wait 0.05;
    n_kill = level.a_wounded.size - level.n_max_wounded;

    if(n_kill > 0) {
      n_now = gettime();
      v_eye = level.player geteye();
      v_player_forward = anglestoforward(level.player getplayerangles());
      i = 0;

      while(n_kill > 0 && i < level.a_wounded.size) {
        e_wounded = level.a_wounded[i];

        if(isDefined(e_wounded)) {
          v_to_wounded = vectornormalize(e_wounded.origin - v_eye);
          n_dot = vectordot(v_to_wounded, v_player_forward);
          n_seconds_alive = (n_now - e_wounded.birthtime) / 1000;

          if(n_seconds_alive > 10 && n_dot < 0 && e_wounded sightconetrace(v_eye, level.player) < 0.1) {
            e_wounded delete();
            n_kill--;
            arrayremoveindex(level.a_wounded, i);
          } else
            i++;
        } else
          arrayremoveindex(level.a_wounded, i);

        wait 0.05;
      }
    }
  }
}