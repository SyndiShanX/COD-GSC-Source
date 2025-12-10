/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_ee_main.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\beam_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_stalingrad_ee_main;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_ee_main", &__init__, undefined, undefined);
}

function __init__() {
  level._effect["ee_anomaly_hit"] = "dlc3/stalingrad/fx_main_anomoly_hit";
  level._effect["ee_anomaly_pulse"] = "dlc3/stalingrad/fx_main_anomoly_emp_pulse";
  level._effect["ee_anomaly_loop"] = "dlc3/stalingrad/fx_main_anomoly_loop_trail";
  level._effect["ee_anomaly_talk"] = "dlc3/stalingrad/fx_main_anomoly_loop_trail_talk";
  level._effect["ee_drone_cam"] = "dlc3/stalingrad/fx_main_sentinel_drone_scanner";
  level._effect["ee_raz_eye"] = "dlc3/stalingrad/fx_main_raz_eye_glow_friendly";
  level._effect["ee_sewer_switch"] = "dlc3/stalingrad/fx_main_impact_success";
  level._effect["post_outro_smoke"] = "dlc3/stalingrad/fx_mech_vdest_smoke_column";
  clientfield::register("scriptmover", "ee_anomaly_hit", 12000, 1, "counter", &function_f5deabb1, 0, 0);
  clientfield::register("scriptmover", "ee_anomaly_loop", 12000, 1, "int", &function_d1216748, 0, 0);
  clientfield::register("scriptmover", "ee_cargo_explosion", 12000, 1, "int", &function_9a9410ac, 0, 0);
  clientfield::register("vehicle", "ee_drone_cam_override", 12000, 1, "int", &function_5bdec411, 0, 0);
  clientfield::register("scriptmover", "ee_generator_kill", 12000, 1, "int", &function_2a4222fe, 0, 0);
  clientfield::register("scriptmover", "ee_generator_target", 12000, 1, "int", &function_3a96f955, 0, 0);
  clientfield::register("scriptmover", "ee_koth_light_1", 12000, 2, "int", &function_ee9d73b7, 0, 0);
  clientfield::register("scriptmover", "ee_koth_light_2", 12000, 2, "int", &function_7c96047c, 0, 0);
  clientfield::register("scriptmover", "ee_koth_light_3", 12000, 2, "int", &function_a2987ee5, 0, 0);
  clientfield::register("scriptmover", "ee_koth_light_4", 12000, 2, "int", &function_30910faa, 0, 0);
  clientfield::register("toplayer", "ee_lockdown_fog", 12000, 1, "int", &function_1616098c, 0, 0);
  clientfield::register("actor", "ee_raz_eye_override", 12000, 1, "int", &function_17268d90, 0, 0);
  clientfield::register("scriptmover", "ee_sewer_switch", 12000, 1, "int", &function_f1804aa5, 0, 0);
  clientfield::register("world", "ee_eye_beam_rumble", 12000, 1, "int", &function_ae73f9d5, 0, 0);
  clientfield::register("toplayer", "ee_hatch_strain_rumble", 12000, 1, "int", &function_fb18b2da, 0, 0);
  clientfield::register("scriptmover", "ee_hatch_break_rumble", 12000, 1, "int", &function_ebc93656, 0, 0);
  clientfield::register("scriptmover", "ee_safe_smash_rumble", 12000, 1, "int", &function_61ba3846, 0, 0);
  clientfield::register("scriptmover", "ee_timed_explosion_rumble", 12000, 1, "counter", &function_fa9a5ecf, 0, 0);
  clientfield::register("scriptmover", "post_outro_smoke", 12000, 1, "int", &function_725d353b, 0, 0);
}

function function_f5deabb1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["ee_anomaly_hit"], self.origin);
  }
}

function function_d1216748(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(localclientnum, level._effect["ee_anomaly_pulse"], self.origin);
  playrumbleonposition(localclientnum, "zm_stalingrad_ee_pursue_pulse", self.origin);
  if(newval == 1) {
    if(isDefined(self.n_fx_id)) {
      stopfx(localclientnum, self.n_fx_id);
    }
    self.n_fx_id = playFXOnTag(localclientnum, level._effect["ee_anomaly_loop"], self, "tag_origin");
  } else {
    if(isDefined(self.n_fx_id)) {
      stopfx(localclientnum, self.n_fx_id);
    }
    self.n_fx_id = playFXOnTag(localclientnum, level._effect["ee_anomaly_talk"], self, "tag_origin");
  }
}

function function_9a9410ac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["generic_explosion"], self.origin);
  }
}

function function_5bdec411(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self.camerascannerfx)) {
      stopfx(localclientnum, self.camerascannerfx);
    }
    if(!isDefined(self.var_734c069)) {
      self.var_734c069 = self playLoopSound("zmb_scenario_magneto_ping");
    }
    self.camerascannerfx = playFXOnTag(localclientnum, level._effect["ee_drone_cam"], self, "tag_flash");
  } else {
    if(isDefined(self.camerascannerfx)) {
      stopfx(localclientnum, self.camerascannerfx);
      self.camerascannerfx = undefined;
    }
    if(isDefined(self.var_734c069)) {
      self stoploopsound(self.var_734c069);
      self.var_734c069 = undefined;
    }
  }
}

function function_2a4222fe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    var_b4349698 = level.var_346f70b8[localclientnum];
    level beam::launch(self, "tag_origin", var_b4349698, "tag_origin", "electric_arc_zombie_to_drop_pod");
    var_b4349698 playSound(0, "zmb_pod_electrocute");
    wait(0.2);
    level beam::kill(self, "tag_origin", var_b4349698, "tag_origin", "electric_arc_zombie_to_drop_pod");
    self playSound(0, "zmb_pod_electrocute_zmb");
  }
}

function function_3a96f955(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level.var_346f70b8[localclientnum] = self;
  } else {
    level.var_346f70b8 = undefined;
  }
}

function function_ee9d73b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_b1ffcb5c(localclientnum, 0, newval);
}

function function_7c96047c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_b1ffcb5c(localclientnum, 1, newval);
}

function function_a2987ee5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_b1ffcb5c(localclientnum, 2, newval);
}

function function_30910faa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_b1ffcb5c(localclientnum, 3, newval);
}

function function_b1ffcb5c(localclientnum, var_46ab6018, newval) {
  if(!isDefined(self.var_b3ab5e19)) {
    self.var_b3ab5e19 = [];
  }
  if(isDefined(self.var_b3ab5e19[var_46ab6018])) {
    stopfx(localclientnum, self.var_b3ab5e19[var_46ab6018]);
  }
  if(newval == 0) {
    return;
  }
  if(newval == 1) {
    str_fx = "dlc3/stalingrad/fx_glow_red_dragonstrike";
  } else if(newval == 2) {
    str_fx = "dlc3/stalingrad/fx_glow_green_dragonstrike";
  }
  n_tag_index = var_46ab6018 + 1;
  str_tag = "tag_dragon_network_console_terminal_light_green_0" + n_tag_index;
  v_position = self gettagorigin(str_tag) + (1.25, -1.25, -0.25);
  self.var_b3ab5e19[var_46ab6018] = playFX(localclientnum, str_fx, v_position);
}

function function_1616098c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    setlitfogbank(localclientnum, -1, 2, -1);
    setworldfogactivebank(localclientnum, 4);
  } else {
    setlitfogbank(localclientnum, -1, 0, -1);
    setworldfogactivebank(localclientnum, 1);
  }
}

function function_17268d90(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    if(isDefined(self._eyearray)) {
      if(isDefined(self._eyearray[localclientnum])) {
        deletefx(localclientnum, self._eyearray[localclientnum], 1);
      }
    }
    self._eyearray[localclientnum] = playFXOnTag(localclientnum, level._effect["ee_raz_eye"], self, "tag_eye_glow");
  }
}

function function_f1804aa5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    playFX(localclientnum, level._effect["ee_sewer_switch"], self.origin);
  }
}

function function_ae73f9d5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    var_1f9211a4 = struct::get("ee_core_end_struct", "targetname");
    playrumbleonposition(localclientnum, "zm_stalingrad_ee_eye_beam", var_1f9211a4.origin);
  }
}

function function_fb18b2da(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrumblelooponentity(localclientnum, "zm_stalingrad_ee_hatch");
  } else {
    self stoprumble(localclientnum, "zm_stalingrad_ee_hatch");
  }
}

function function_ebc93656(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playrumbleonposition(localclientnum, "zm_stalingrad_ee_sophia_small", self.origin);
  }
}

function function_61ba3846(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playrumbleonposition(localclientnum, "zm_stalingrad_ee_safe_smash", self.origin);
  }
}

function function_fa9a5ecf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playrumbleonposition(localclientnum, "zm_stalingrad_drop_pod_explosion", self.origin);
  }
}

function function_725d353b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFXOnTag(localclientnum, level._effect["post_outro_smoke"], self, "tag_body");
  }
}