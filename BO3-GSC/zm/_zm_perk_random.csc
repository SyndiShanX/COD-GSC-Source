/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_random.csc
*************************************************/

#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#namespace zm_perk_random;

function autoexec __init__sytem__() {
  system::register("zm_perk_random", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "perk_bottle_cycle_state", 5000, 2, "int", & start_bottle_cycling, 0, 0);
  clientfield::register("zbarrier", "set_client_light_state", 5000, 2, "int", & set_light_state, 0, 0);
  clientfield::register("zbarrier", "init_perk_random_machine", 5000, 1, "int", & perk_random_machine_init, 0, 0);
  clientfield::register("zbarrier", "client_stone_emmissive_blink", 5000, 1, "int", & perk_random_machine_rock_emissive, 0, 0);
  clientfield::register("scriptmover", "turn_active_perk_light_green", 5000, 1, "int", & turn_on_active_light_green, 0, 0);
  clientfield::register("scriptmover", "turn_on_location_indicator", 5000, 1, "int", & turn_on_location_indicator, 0, 0);
  clientfield::register("zbarrier", "lightning_bolt_FX_toggle", 10000, 1, "int", & lightning_bolt_fx_toggle, 0, 0);
  clientfield::register("scriptmover", "turn_active_perk_ball_light", 5000, 1, "int", & turn_on_active_ball_light, 0, 0);
  clientfield::register("scriptmover", "zone_captured", 5000, 1, "int", & zone_captured_cb, 0, 0);
  level._effect["perk_machine_light_yellow"] = "dlc1/castle/fx_wonder_fizz_light_yellow";
  level._effect["perk_machine_light_red"] = "dlc1/castle/fx_wonder_fizz_light_red";
  level._effect["perk_machine_light_green"] = "dlc1/castle/fx_wonder_fizz_light_green";
  level._effect["perk_machine_location"] = "zombie/fx_wonder_fizz_lightning_all";
}

function init_animtree() {}

function turn_on_location_indicator(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function lightning_bolt_fx_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isdemoplaying() && getdemoversion() < 17) {
    return;
  }
  self notify("lightning_bolt_fx_toggle" + localclientnum);
  self endon("lightning_bolt_fx_toggle" + localclientnum);
  player = getlocalplayer(localclientnum);
  player endon("entityshutdown");
  if(!isdefined(self._location_indicator)) {
    self._location_indicator = [];
  }
  while (true) {
    if(newval == 1 && !isigcactive(localclientnum)) {
      if(!isdefined(self._location_indicator[localclientnum])) {
        self._location_indicator[localclientnum] = playfx(localclientnum, level._effect["perk_machine_location"], self.origin);
      }
    } else if(isdefined(self._location_indicator[localclientnum])) {
      stopfx(localclientnum, self._location_indicator[localclientnum]);
      self._location_indicator[localclientnum] = undefined;
    }
    wait(1);
  }
}

function zone_captured_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isdefined(self.mapped_const)) {
    self mapshaderconstant(localclientnum, 1, "ScriptVector0");
    self.mapped_const = 1;
  }
  if(newval == 1) {} else {
    self.artifact_glow_setting = 1;
    self.machinery_glow_setting = 0;
    self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
  }
}

function perk_random_machine_rock_emissive(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    piece = self zbarriergetpiece(3);
    piece.blinking = 1;
    piece thread rock_emissive_think(localclientnum);
  } else if(newval == 0) {
    self.blinking = 0;
  }
}

function rock_emissive_think(localclientnum) {
  level endon("demo_jump");
  while (isdefined(self.blinking) && self.blinking) {
    self rock_emissive_fade(localclientnum, 8, 0);
    self rock_emissive_fade(localclientnum, 0, 8);
  }
}

function rock_emissive_fade(localclientnum, n_max_val, n_min_val) {
  n_start_time = gettime();
  n_end_time = n_start_time + (0.5 * 1000);
  b_is_updating = 1;
  while (b_is_updating) {
    n_time = gettime();
    if(n_time >= n_end_time) {
      n_shader_value = mapfloat(n_start_time, n_end_time, n_min_val, n_max_val, n_end_time);
      b_is_updating = 0;
    } else {
      n_shader_value = mapfloat(n_start_time, n_end_time, n_min_val, n_max_val, n_time);
    }
    if(isdefined(self)) {
      self mapshaderconstant(localclientnum, 0, "scriptVector2", n_shader_value, 0, 0);
      self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, n_shader_value, 0);
      self mapshaderconstant(localclientnum, 0, "scriptVector0", 0, 0, n_shader_value);
    }
    wait(0.01);
  }
}

function private perk_random_machine_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isdefined(self.perk_random_machine_fx)) {
    return;
  }
  if(!isdefined(self)) {
    return;
  }
  self.perk_random_machine_fx = [];
  self.perk_random_machine_fx["tag_animate" + 1] = [];
  self.perk_random_machine_fx["tag_animate" + 2] = [];
  self.perk_random_machine_fx["tag_animate" + 3] = [];
}

function set_light_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_n_piece_indices = array(1, 2, 3);
  foreach(n_piece_index in a_n_piece_indices) {
    if(newval == 0) {
      perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", undefined);
      continue;
    }
    if(newval == 3) {
      perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", level._effect["perk_machine_light_red"]);
      continue;
    }
    if(newval == 1) {
      perk_random_machine_play_fx(localclientnum, n_piece_index, "tag_animate", level._effect["perk_machine_light_green"]);
      continue;
    }
  }
}

function private perk_random_machine_play_fx(localclientnum, piece_index, tag, fx, deleteimmediate = 1) {
  piece = self zbarriergetpiece(piece_index);
  if(isdefined(self.perk_random_machine_fx[tag + piece_index][localclientnum])) {
    deletefx(localclientnum, self.perk_random_machine_fx[tag + piece_index][localclientnum], deleteimmediate);
    self.perk_random_machine_fx[tag + piece_index][localclientnum] = undefined;
  }
  if(isdefined(fx)) {
    self.perk_random_machine_fx[tag + piece_index][localclientnum] = playfxontag(localclientnum, fx, piece, tag);
  }
}

function turn_on_active_light_green(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.artifact_glow_setting = 1;
    self.machinery_glow_setting = 0.7;
    self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
  }
}

function turn_on_active_ball_light(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.artifact_glow_setting = 1;
    self.machinery_glow_setting = 1;
    self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
  }
}

function start_bottle_cycling(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread start_vortex_fx(localclientnum);
  } else {
    self thread stop_vortex_fx(localclientnum);
  }
}

function start_vortex_fx(localclientnum) {
  self endon("activation_electricity_finished");
  self endon("entityshutdown");
  if(!isdefined(self.glow_location)) {
    self.glow_location = spawn(localclientnum, self.origin, "script_model");
    self.glow_location.angles = self.angles;
    self.glow_location setmodel("tag_origin");
  }
  self thread fx_activation_electric_loop(localclientnum);
  self thread fx_artifact_pulse_thread(localclientnum);
  wait(0.5);
  self thread fx_bottle_cycling(localclientnum);
}

function stop_vortex_fx(localclientnum) {
  self endon("entityshutdown");
  self notify("bottle_cycling_finished");
  wait(0.5);
  if(!isdefined(self)) {
    return;
  }
  self notify("activation_electricity_finished");
  if(isdefined(self.glow_location)) {
    self.glow_location delete();
  }
  self.artifact_glow_setting = 1;
  self.machinery_glow_setting = 0.7;
  self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
}

function fx_artifact_pulse_thread(localclientnum) {
  self endon("activation_electricity_finished");
  self endon("entityshutdown");
  while (isdefined(self)) {
    shader_amount = sin(getrealtime() * 0.2);
    if(shader_amount < 0) {
      shader_amount = shader_amount * -1;
    }
    shader_amount = 0.75 - (shader_amount * 0.75);
    self.artifact_glow_setting = shader_amount;
    self.machinery_glow_setting = 1;
    self setshaderconstant(localclientnum, 1, self.artifact_glow_setting, 0, self.machinery_glow_setting, 0);
    wait(0.05);
  }
}

function fx_activation_electric_loop(localclientnum) {
  self endon("activation_electricity_finished");
  self endon("entityshutdown");
  while (true) {
    wait(0.1);
  }
}

function fx_bottle_cycling(localclientnum) {
  self endon("bottle_cycling_finished");
  while (true) {
    wait(0.1);
  }
}