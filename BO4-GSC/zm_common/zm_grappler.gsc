/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_grappler.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_grappler;

autoexec __init__system__() {
  system::register(#"zm_grappler", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("scriptmover", "grappler_beam_source", 1, getminbitcountfornum(5), "int");
  clientfield::register("scriptmover", "grappler_beam_target", 1, getminbitcountfornum(5), "int");
  level.grapple_ids = [];

  for(id = 1; id < 5; id++) {
    level.grapple_ids[id] = 0;
  }
}

__main__() {}

private function_5f5a3405() {
  foreach(key, value in level.grapple_ids) {
    if(value === 0) {
      level.grapple_ids[key] = 1;
      return key;
    }
  }

  return undefined;
}

function_56813755() {
  foreach(value in level.grapple_ids) {
    if(value === 0) {
      return false;
    }
  }

  return true;
}

private function_2772f623(id) {
  assert(isDefined(level.grapple_ids[id]) && level.grapple_ids[id] === 1);
  level.grapple_ids[id] = 0;
}

start_grapple(prone_2_run_roll, e_grapplee, n_type, n_speed = 1800) {
  assert(n_type == 2);
  e_source = create_mover(prone_2_run_roll function_f21c3519(), prone_2_run_roll.angles);
  e_beamend = create_mover(prone_2_run_roll function_f21c3519(), prone_2_run_roll.angles * -1);
  thread function_30a5f5c1(e_source, e_beamend);

  if(isDefined(e_beamend)) {
    e_grapplee function_a60cb756(1, 1);
    util::wait_network_frame();
    n_time = function_b9937e84(prone_2_run_roll, e_grapplee, n_speed);
    e_beamend.origin = prone_2_run_roll function_f21c3519();
    var_5f04bf66 = e_grapplee function_f21c3519();
    e_beamend playSound(#"zmb_grapple_start");
    e_beamend moveto(var_5f04bf66, n_time);
    e_beamend waittill(#"movedone");
    var_7fdf7771 = var_5f04bf66 - e_grapplee.origin;
    e_beamend.origin = e_grapplee.origin;

    if(isplayer(e_grapplee)) {
      e_grapplee playerlinkto(e_beamend, "tag_origin");
    } else {
      e_grapplee linkto(e_beamend);
    }

    e_grapplee playSound(#"zmb_grapple_grab");
    var_b7f19309 = prone_2_run_roll function_f21c3519() - var_7fdf7771;
    e_beamend moveto(var_b7f19309, n_time);
    e_beamend playSound(#"zmb_grapple_pull");
    e_beamend waittill(#"movedone");
    function_c43e7cab();
    e_beamend clientfield::set("grappler_beam_target", 0);
    e_grapplee unlink();
    e_grapplee function_a60cb756(0, 1);
    util::wait_network_frame();
    destroy_mover(e_beamend);
    destroy_mover(e_source);
  }
}

function_c43e7cab() {
  while(isDefined(level.var_acec7a44) && level.var_acec7a44) {
    waitframe(1);
  }
}

private function_1b905efa(e_source, e_target, id) {
  if(isDefined(e_source) && isDefined(e_target)) {
    util::waittill_any_ents_two(e_source, "death", e_target, "death");
  } else if(isDefined(e_source)) {
    e_source waittill(#"death");
  } else if(isDefined(e_target)) {
    e_target waittill(#"death");
  }

  util::wait_network_frame();
  function_2772f623(id);
}

function_30a5f5c1(e_source, e_target) {
  function_c43e7cab();
  level.var_acec7a44 = 1;
  grapple_id = function_5f5a3405();

  if(isDefined(e_source)) {
    e_source clientfield::set("grappler_beam_source", grapple_id);
  }

  util::wait_network_frame();

  if(isDefined(e_target)) {
    e_target clientfield::set("grappler_beam_target", grapple_id);
  }

  thread function_1b905efa(e_source, e_target, grapple_id);
  util::wait_network_frame();
  level.var_acec7a44 = 0;
}

private function_b9937e84(e_from, e_to, n_speed) {
  n_distance = distance(e_from function_f21c3519(), e_to function_f21c3519());
  return n_distance / n_speed;
}

function_a60cb756(var_b4666218, var_e9f8c8f3) {
  if(!isDefined(self)) {
    return;
  }

  if(var_b4666218 != (isDefined(self.var_564dec14) && self.var_564dec14)) {
    if(isDefined(var_b4666218) && var_b4666218) {
      self notify(#"hash_3219c34bb024ffb7");
    } else {
      self notify(#"hash_5d85f16cb4fd5a32");
    }

    self.var_564dec14 = var_b4666218;

    if(isplayer(self)) {
      self freezecontrols(var_b4666218);
      self setplayercollision(!var_b4666218);

      if(var_b4666218) {
        self val::set(#"zm_grappler", "ignoreme");

        if(isDefined(var_e9f8c8f3) && var_e9f8c8f3) {
          self.var_d6723cbc = self enableinvulnerability();
        }

        return;
      }

      self val::reset(#"zm_grappler", "ignoreme");

      if(!(isDefined(self.var_d6723cbc) && self.var_d6723cbc) && isDefined(var_e9f8c8f3) && var_e9f8c8f3) {
        self disableinvulnerability();
      }
    }
  }
}

function_f21c3519() {
  if(isDefined(self.grapple_tag)) {
    v_origin = self gettagorigin(self.grapple_tag);
    return v_origin;
  }

  return self.origin;
}

create_mover(v_origin, v_angles) {
  model = "tag_origin";
  e_ent = util::spawn_model(model, v_origin, v_angles);
  return e_ent;
}

destroy_mover(e_beamend) {
  if(isDefined(e_beamend)) {
    e_beamend delete();
  }
}