/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_teleporter.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace zm_castle_teleporter;

function autoexec __init__sytem__() {
  system::register("zm_castle_teleporter", & __init__, undefined, undefined);
}

function __init__() {
  visionset_mgr::register_overlay_info_style_transported("zm_castle", 1, 15, 2);
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_factory_teleport", 5000, 1, "pstfx_zm_castle_teleport");
  level thread setup_teleport_aftereffects();
  level thread wait_for_black_box();
  level thread wait_for_teleport_aftereffect();
  level._effect["ee_quest_time_travel_ready"] = "dlc1/castle/fx_demon_gate_rune_glow";
  duplicate_render::set_dr_filter_framebuffer("flashback", 90, "flashback_on", "", 0, "mc/mtl_glitch", 0);
  clientfield::register("world", "ee_quest_time_travel_ready", 5000, 1, "int", & function_ddac47c8, 0, 0);
  clientfield::register("toplayer", "ee_quest_back_in_time_teleport_fx", 5000, 1, "int", & function_f5cfa4d7, 0, 0);
  clientfield::register("toplayer", "ee_quest_back_in_time_postfx", 5000, 1, "int", & function_aa99fd7b, 0, 0);
  clientfield::register("toplayer", "ee_quest_back_in_time_sfx", 5000, 1, "int", & function_a932c4c, 0, 0);
}

function function_f5cfa4d7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!oldval || !isdemoplaying()) {
      self thread postfx::playpostfxbundle("pstfx_zm_wormhole");
    }
  } else {
    self postfx::exitpostfxbundle();
  }
}

function function_aa99fd7b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!oldval || !isdemoplaying()) {
      self thread postfx::playpostfxbundle("pstfx_backintime");
    }
  } else {
    self postfx::exitpostfxbundle();
  }
  self duplicate_render::set_dr_flag("flashback_on", newval);
  self duplicate_render::update_dr_filters(localclientnum);
}

function function_a932c4c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playSound(0, "zmb_ee_timetravel_start", (0, 0, 0));
    self.var_6e4d8282 = self playLoopSound("zmb_ee_timetravel_lp", 3);
    level notify("hash_51d7bc7c", "null");
  } else if(isDefined(self.var_6e4d8282)) {
    self stoploopsound(self.var_6e4d8282, 1);
    playSound(0, "zmb_ee_timetravel_end", (0, 0, 0));
    level notify("hash_51d7bc7c", "rocket");
  }
}

function function_ddac47c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_55ff1a9f = struct::get_array("teleport_pad_center_effect", "targetname");
  foreach(var_f92e157f in var_55ff1a9f) {
    var_f92e157f thread function_74eb9e6a(localclientnum, newval);
  }
}

function function_74eb9e6a(localclientnum, newval) {
  if(newval == 1) {
    self.var_83ef00ec = playFX(localclientnum, level._effect["ee_quest_time_travel_ready"], self.origin);
    audio::playloopat("zmb_ee_timetravel_tele_lp", self.origin);
  } else {
    if(isDefined(self.var_83ef00ec)) {
      stopfx(localclientnum, self.var_83ef00ec);
      self.var_83ef00ec = undefined;
    }
    audio::stoploopat("zmb_ee_timetravel_tele_lp", self.origin);
  }
}

function setup_teleport_aftereffects() {
  util::waitforclient(0);
  level.teleport_ae_funcs = [];
  if(getlocalplayers().size == 1) {
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = & teleport_aftereffect_fov;
  }
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = & teleport_aftereffect_shellshock;
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = & teleport_aftereffect_shellshock_electric;
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = & teleport_aftereffect_bw_vision;
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = & teleport_aftereffect_red_vision;
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = & teleport_aftereffect_flashy_vision;
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = & teleport_aftereffect_flare_vision;
}

function wait_for_black_box() {
  secondclientnum = -1;
  while(true) {
    level waittill("black_box_start", localclientnum);
    assert(isDefined(localclientnum));
    savedvis = getvisionsetnaked(localclientnum);
    playSound(0, "evt_teleport_2d_fnt", (0, 0, 0));
    visionsetnaked(localclientnum, "default", 0);
    while(secondclientnum != localclientnum) {
      level waittill("black_box_end", secondclientnum);
    }
    visionsetnaked(localclientnum, savedvis, 0);
  }
}

function wait_for_teleport_aftereffect() {
  while(true) {
    level waittill("tae", localclientnum);
    if(getdvarstring("castleAftereffectOverride") == ("-1")) {
      self thread[[level.teleport_ae_funcs[randomint(level.teleport_ae_funcs.size)]]](localclientnum);
    } else {
      self thread[[level.teleport_ae_funcs[int(getdvarstring("castleAftereffectOverride"))]]](localclientnum);
    }
  }
}

function teleport_aftereffect_shellshock(localclientnum) {
  wait(0.05);
}

function teleport_aftereffect_shellshock_electric(localclientnum) {
  wait(0.05);
}

function teleport_aftereffect_fov(localclientnum) {
  println("");
  start_fov = 30;
  end_fov = getdvarfloat("cg_fov_default");
  duration = 0.5;
  i = 0;
  while(i < duration) {
    fov = start_fov + (end_fov - start_fov) * (i / duration);
    waitrealtime(0.017);
    i = i + 0.017;
  }
}

function teleport_aftereffect_bw_vision(localclientnum) {
  println("");
  savedvis = getvisionsetnaked(localclientnum);
  visionsetnaked(localclientnum, "cheat_bw_invert_contrast", 0.4);
  wait(1.25);
  visionsetnaked(localclientnum, savedvis, 1);
}

function teleport_aftereffect_red_vision(localclientnum) {
  println("");
  savedvis = getvisionsetnaked(localclientnum);
  visionsetnaked(localclientnum, "zombie_turned", 0.4);
  wait(1.25);
  visionsetnaked(localclientnum, savedvis, 1);
}

function teleport_aftereffect_flashy_vision(localclientnum) {
  println("");
  savedvis = getvisionsetnaked(localclientnum);
  visionsetnaked(localclientnum, "cheat_bw_invert_contrast", 0.1);
  wait(0.4);
  visionsetnaked(localclientnum, "cheat_bw_contrast", 0.1);
  wait(0.4);
  wait(0.4);
  wait(0.4);
  visionsetnaked(localclientnum, savedvis, 5);
}

function teleport_aftereffect_flare_vision(localclientnum) {
  println("");
  savedvis = getvisionsetnaked(localclientnum);
  visionsetnaked(localclientnum, "flare", 0.4);
  wait(1.25);
  visionsetnaked(localclientnum, savedvis, 1);
}