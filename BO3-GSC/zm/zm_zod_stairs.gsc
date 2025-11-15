/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_stairs.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_zod_poweronswitch;
#using_animtree("generic");

class cstair {
  var origin;
  var m_str_areaname;
  var var_f2f66550;
  var var_39624e3b;
  var m_n_state;
  var m_a_e_clip;
  var m_a_e_blockers;
  var m_a_e_steps;
  var m_n_pause_between_steps;
  var m_n_power_index;
  var m_b_discovered;

  constructor() {}

  destructor() {}

  function move_blocker() {
    self moveto(origin - vectorscale((0, 0, 1), 10000), 0.05);
    wait(0.05);
  }

  function function_15ee241e(e_mover, v_angles, n_rotate, n_duration) {
    e_mover rotateto(v_angles + (0, n_rotate, 0), n_duration);
  }

  function element_move(e_mover, b_is_extending, n_step_rise_distance, n_duration) {
    if(!b_is_extending) {
      n_step_rise_distance = n_step_rise_distance * -1;
    }
    v_offset = anglestoup((0, 0, 0)) * n_step_rise_distance;
    e_mover moveto(e_mover.origin + v_offset, n_duration);
  }

  function stair_move(b_is_extending, b_is_instant) {
    if(m_str_areaname != "underground" && m_str_areaname != "club" && b_is_extending && !b_is_instant) {
      var_f2f66550[0] scene::play("p7_fxanim_zm_zod_mechanical_stairs_bundle");
      foreach(e_gate in var_39624e3b) {
        e_gate thread scene::play("p7_fxanim_zm_zod_gate_scissor_short_bundle");
      }
      m_n_state = 2;
      m_a_e_clip[0] move_blocker();
      m_a_e_clip[0] connectpaths();
      return;
    }
    if(b_is_instant) {
      n_step_rise_duration = 0.05;
      n_barricade_duration = 0.05;
    } else {
      n_step_rise_duration = 0.5;
      n_barricade_duration = 0.25;
    }
    if(b_is_extending) {
      m_n_state = 1;
    } else {
      m_n_state = 3;
    }
    if(!b_is_extending) {
      foreach(e_blocker in m_a_e_blockers) {
        self thread element_move(e_blocker, !b_is_extending, 64, n_barricade_duration);
      }
    }
    foreach(e_step in m_a_e_steps) {
      if(b_is_extending && isDefined(e_step.script_noteworthy) && e_step.script_noteworthy == "swing_door" && isDefined(e_step.angles) && isDefined(e_step.script_float)) {
        self thread function_15ee241e(e_step, e_step.angles, e_step.script_float, 0.5);
      } else {
        self thread element_move(e_step, b_is_extending, e_step.script_int, n_step_rise_duration);
      }
      if(isDefined(m_n_pause_between_steps)) {
        wait(m_n_pause_between_steps);
      }
    }
    wait(n_step_rise_duration);
    if(b_is_extending) {
      foreach(e_blocker in m_a_e_blockers) {
        self thread element_move(e_blocker, !b_is_extending, 64, n_barricade_duration);
      }
    }
    if(b_is_extending) {
      m_n_state = 2;
      m_a_e_clip[0] move_blocker();
      m_a_e_clip[0] connectpaths();
    } else {
      m_n_state = 0;
      m_a_e_clip[0] setvisibletoall();
      m_a_e_clip[0] disconnectpaths();
    }
    if(b_is_extending) {
      if(isDefined(m_a_e_steps[0].script_flag_set)) {
        level flag::set(m_a_e_steps[0].script_flag_set);
      }
    }
  }

  function stair_wait() {
    level flag::wait_till("power_on" + m_n_power_index);
  }

  function stair_think() {
    stair_wait();
    stair_move(1, 0);
  }

  function get_blocker() {
    return m_a_e_blockers[0];
  }

  function filter_areaname(e_entity, str_areaname) {
    if(!isDefined(e_entity.script_string) || e_entity.script_string != str_areaname) {
      return false;
    }
    return true;
  }

  function start_stair() {
    stair_move(0, 1);
    self thread stair_think();
  }

  function init_stair(str_areaname, n_power_index) {
    m_n_state = 0;
    m_n_pause_between_steps = 0.1;
    m_str_areaname = str_areaname;
    m_a_e_steps = getEntArray("stair_step", "targetname");
    m_a_e_blockers = getEntArray("stair_blocker", "targetname");
    m_a_e_clip = getEntArray("stair_clip", "targetname");
    var_f2f66550 = struct::get_array("stair_staircase", "targetname");
    var_39624e3b = struct::get_array("stair_gate", "targetname");
    m_a_e_steps = array::filter(m_a_e_steps, 0, & filter_areaname, str_areaname);
    m_a_e_blockers = array::filter(m_a_e_blockers, 0, & filter_areaname, str_areaname);
    m_a_e_clip = array::filter(m_a_e_clip, 0, & filter_areaname, str_areaname);
    var_f2f66550 = array::filter(var_f2f66550, 0, & filter_areaname, str_areaname);
    var_39624e3b = array::filter(var_39624e3b, 0, & filter_areaname, str_areaname);
    m_n_power_index = n_power_index;
    m_b_discovered = 0;
  }

}

#namespace zm_zod_stairs;

function autoexec __init__sytem__() {
  system::register("zm_zod_stairs", undefined, & __main__, undefined);
}

function __main__() {
  level thread init_stairs();
}

function init_stairs() {
  if(!isDefined(level.a_o_stair)) {
    level.a_o_stair = [];
    init_stair("slums", 11);
    init_stair("canal", 12);
    init_stair("theater", 13);
    init_stair("start", 14);
    init_stair("brothel", 16);
    init_stair("underground", 15);
  }
}

function init_stair(str_areaname, n_power_index) {
  if(!isDefined(level.a_o_stair[n_power_index])) {
    level.a_o_stair[n_power_index] = new cstair();
    [[level.a_o_stair[n_power_index]]] - > init_stair(str_areaname, n_power_index);
    [[level.a_o_stair[n_power_index]]] - > start_stair();
  }
}