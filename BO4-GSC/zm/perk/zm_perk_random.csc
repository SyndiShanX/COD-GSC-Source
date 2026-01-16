/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_random.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;

#namespace zm_perk_random;

autoexec __init__system__() {
  system::register(#"zm_perk_random", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "perk_bottle_cycle_state", 1, 2, "int", &start_bottle_cycling, 0, 0);
  clientfield::register("zbarrier", "set_client_light_state", 1, 2, "int", &set_light_state, 0, 0);
  clientfield::register("zbarrier", "init_perk_random_machine", 1, 1, "int", &perk_random_machine_init, 0, 0);
  clientfield::register("zbarrier", "client_stone_emmissive_blink", 1, 1, "int", &perk_random_machine_rock_emissive, 0, 0);
  clientfield::register("scriptmover", "turn_active_perk_light_green", 1, 1, "int", &turn_on_active_light_green, 0, 0);
  clientfield::register("scriptmover", "turn_on_location_indicator", 1, 1, "int", &turn_on_location_indicator, 0, 0);
  clientfield::register("zbarrier", "lightning_bolt_FX_toggle", 1, 1, "int", &lightning_bolt_fx_toggle, 0, 0);
  clientfield::register("scriptmover", "turn_active_perk_ball_light", 1, 1, "int", &turn_on_active_ball_light, 0, 0);
  clientfield::register("scriptmover", "zone_captured", 1, 1, "int", &zone_captured_cb, 0, 0);
  level._effect[#"perk_machine_light_yellow"] = #"hash_63cff764b54ceca2";
  level._effect[#"perk_machine_light_red"] = #"hash_5b7d2edb8392ef21";
  level._effect[#"perk_machine_light_green"] = #"hash_130f1aaf8384975";
  level._effect[#"perk_machine_location"] = #"hash_53e8ba7551663778";
}

init_animtree() {}

turn_on_location_indicator(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

lightning_bolt_fx_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isdemoplaying() && getdemoversion() < 17) {
    return;
  }

  self notify("lightning_bolt_fx_toggle" + localclientnum);
  self endon("lightning_bolt_fx_toggle" + localclientnum);
  player = function_5c10bd79(localclientnum);
  player endon(#"death");

  if(!isDefined(self._location_indicator)) {
    self._location_indicator = [];
  }

  while(true) {
    if(newval == 1 && !isigcactive(localclientnum)) {
      if(!isDefined(self._location_indicator[localclientnum])) {
        self._location_indicator[localclientnum] = playFX(localclientnum, level._effect[#"perk_machine_location"], self.origin);
      }
    } else if(isDefined(self._location_indicator[localclientnum])) {
      stopfx(localclientnum, self._location_indicator[localclientnum]);
      self._location_indicator[localclientnum] = undefined;
    }

    wait 1;
  }
}

zone_captured_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.mapped_const)) {
    self mapshaderconstant(localclientnum, 1, "ScriptVector0");
    self.mapped_const = 1;
  }

  if(newval == 1) {
    return;
  }

  self.artifact_glow_setting = 1;
  self.machinery_glow_setting = 0;
  self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
}

perk_random_machine_rock_emissive(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    piece = self zbarriergetpiece(3);
    piece.blinking = 1;
    piece thread rock_emissive_think(localclientnum);
    return;
  }

  if(newval == 0) {
    self.blinking = 0;
  }
}

rock_emissive_think(localclientnum) {
  level endon(#"demo_jump");

  while(isDefined(self.blinking) && self.blinking) {
    self rock_emissive_fade(localclientnum, 8, 0);
    self rock_emissive_fade(localclientnum, 0, 8);
  }
}

rock_emissive_fade(localclientnum, n_max_val, n_min_val) {
  n_start_time = gettime();
  n_end_time = n_start_time + 0.5 * 1000;
  b_is_updating = 1;

  while(b_is_updating) {
    n_time = gettime();

    if(n_time >= n_end_time) {
      n_shader_value = mapfloat(n_start_time, n_end_time, n_min_val, n_max_val, n_end_time);
      b_is_updating = 0;
    } else {
      n_shader_value = mapfloat(n_start_time, n_end_time, n_min_val, n_max_val, n_time);
    }

    if(isDefined(self)) {
      self mapshaderconstant(localclientnum, 0, "scriptVector2", n_shader_value, 0, 0);
      self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, n_shader_value, 0);
      self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, 0, n_shader_value);
    }

    wait 0.01;
  }
}

private perk_random_machine_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.perk_random_machine_fx)) {
    return;
  }

  if(!isDefined(self)) {
    return;
  }

  self.perk_random_machine_fx = [];
  self.perk_random_machine_fx["tag_animate" + 1] = [];
  self.perk_random_machine_fx["tag_animate" + 2] = [];
  self.perk_random_machine_fx["tag_animate" + 3] = [];
}

set_light_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_n_piece_indices = array(1, 2, 3);

  foreach(n_piece_index in a_n_piece_indices) {
    if(newval == 0) {
      perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", undefined);
      continue;
    }

    if(newval == 3) {
      perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", level._effect[#"perk_machine_light_red"]);
      continue;
    }

    if(newval == 1) {
      perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", level._effect[#"perk_machine_light_green"]);
      continue;
    }

    if(newval == 2) {}
  }
}

private perk_random_machine_play_fx(localclientnum, piece_index, tag, fx, deleteimmediate = 1) {
  piece = self zbarriergetpiece(piece_index);

  if(isDefined(self.perk_random_machine_fx[tag + piece_index][localclientnum])) {
    deletefx(localclientnum, self.perk_random_machine_fx[tag + piece_index][localclientnum], deleteimmediate);
    self.perk_random_machine_fx[tag + piece_index][localclientnum] = undefined;
  }

  if(isDefined(fx)) {
    self.perk_random_machine_fx[tag + piece_index][localclientnum] = util::playFXOnTag(localclientnum, fx, piece, tag);
  }
}

turn_on_active_light_green(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.artifact_glow_setting = 1;
    self.machinery_glow_setting = 0.7;
    self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
  }
}

turn_on_active_ball_light(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.artifact_glow_setting = 1;
    self.machinery_glow_setting = 1;
    self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
  }
}

start_bottle_cycling(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread start_vortex_fx(localclientnum);
    return;
  }

  self thread stop_vortex_fx(localclientnum);
}

start_vortex_fx(localclientnum) {
  self endon(#"activation_electricity_finished");
  self endon(#"death");

  if(!isDefined(self.glow_location)) {
    self.glow_location = spawn(localclientnum, self.origin, "script_model");
    self.glow_location.angles = self.angles;
    self.glow_location setModel(#"tag_origin");
  }

  self thread fx_activation_electric_loop(localclientnum);
  self thread fx_artifact_pulse_thread(localclientnum);
  wait 0.5;
  self thread fx_bottle_cycling(localclientnum);
}

stop_vortex_fx(localclientnum) {
  self endon(#"death");
  self notify(#"bottle_cycling_finished");
  wait 0.5;

  if(!isDefined(self)) {
    return;
  }

  self notify(#"activation_electricity_finished");

  if(isDefined(self.glow_location)) {
    self.glow_location delete();
  }

  self.artifact_glow_setting = 1;
  self.machinery_glow_setting = 0.7;
  self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
}

fx_artifact_pulse_thread(localclientnum) {
  self endon(#"activation_electricity_finished");
  self endon(#"death");

  while(isDefined(self)) {
    shader_amount = sin(getrealtime() * 0.2);

    if(shader_amount < 0) {
      shader_amount *= -1;
    }

    shader_amount = 0.75 - shader_amount * 0.75;
    self.artifact_glow_setting = shader_amount;
    self.machinery_glow_setting = 1;
    self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
    waitframe(1);
  }
}

fx_activation_electric_loop(localclientnum) {
  self endon(#"activation_electricity_finished");
  self endon(#"death");

  while(true) {
    if(isDefined(self.glow_location)) {}

    wait 0.1;
  }
}

fx_bottle_cycling(localclientnum) {
  self endon(#"bottle_cycling_finished");

  while(true) {
    if(isDefined(self.glow_location)) {}

    wait 0.1;
  }
}

function_6a9b1884(localclientnum) {
  self endon(#"hash_fcaf7071581a306");
  self endon(#"death");
  level endon(#"demo_jump");

  while(isDefined(self)) {
    if(isDefined(self)) {}

    wait randomfloatrange(3, 4);
  }
}