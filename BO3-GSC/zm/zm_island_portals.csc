/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_portals.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using_animtree("generic");
#namespace zm_island_portals;

function autoexec __init__sytem__() {
  system::register("zm_island_portals", & __init__, undefined, undefined);
}

function __init__() {
  visionset_mgr::register_overlay_info_style_transported("zm_zod", 9000, 15, 2);
  n_bits = getminbitcountfornum(3);
  clientfield::register("toplayer", "player_stargate_fx", 9000, 1, "int", & player_stargate_fx, 0, 0);
  clientfield::register("world", "portal_state_ending_0", 9000, 1, "int", & portal_state_ending_0, 0, 0);
  clientfield::register("world", "portal_state_ending_1", 9000, 1, "int", & portal_state_ending_1, 0, 0);
  clientfield::register("world", "portal_state_ending_2", 9000, 1, "int", & portal_state_ending_2, 0, 0);
  clientfield::register("world", "portal_state_ending_3", 9000, 1, "int", & portal_state_ending_3, 0, 0);
  clientfield::register("world", "pulse_ee_boat_portal_top", 9000, 1, "counter", & function_b040f607, 0, 0);
  clientfield::register("world", "pulse_ee_boat_portal_bottom", 9000, 1, "counter", & function_bfbf92fb, 0, 0);
}

function player_stargate_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("player_stargate_fx");
  self endon("player_stargate_fx");
  if(newval == 1) {
    if(isdemoplaying() && demoisanyfreemovecamera()) {
      return;
    }
    if(isspectating(localclientnum)) {
      return;
    }
    self thread function_e7a8756e(localclientnum);
    self thread postfx::playpostfxbundle("pstfx_zm_wormhole");
  } else {
    self notify("player_portal_complete");
  }
}

function function_e7a8756e(localclientnum) {
  self util::waittill_any("player_stargate_fx", "player_portal_complete");
  self postfx::exitpostfxbundle();
}

function portal_3p(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("death");
  if(newval == 1) {
    self.fx_portal_3p = playFXOnTag(localclientnum, level._effect["portal_3p"], self, "j_spineupper");
  } else {
    stop_fx_if_defined(localclientnum, self.fx_portal_3p);
  }
}

function function_e962c05f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  portal_state_internal(localclientnum, "ee_boat", newval);
}

function portal_state_internal(localclientnum, str_areaname, newval) {
  s_loc_upper = get_portal_fx_loc("teleport_effect_origin", str_areaname, 1);
  s_loc_lower = get_portal_fx_loc("teleport_effect_origin", str_areaname, 0);
  switch (newval) {
    case 0: {
      level thread function_c0c1771a(localclientnum, s_loc_upper, 0, 0);
      level thread function_c0c1771a(localclientnum, s_loc_lower, 0, 1);
      level thread function_a2d0d0e4(s_loc_upper.origin, s_loc_lower.origin, "amb_teleporter_off_lp", "amb_teleporter_on_lp");
      exploder::stop_exploder("lgt_portal_" + str_areaname);
      break;
    }
    case 1: {
      level thread function_c0c1771a(localclientnum, s_loc_upper, 1, 0);
      level thread function_c0c1771a(localclientnum, s_loc_lower, 1, 1);
      level thread function_a2d0d0e4(s_loc_upper.origin, s_loc_lower.origin, "amb_teleporter_on_lp", "amb_teleporter_off_lp", "amb_teleporter_activate");
      exploder::exploder("lgt_portal_" + str_areaname);
      break;
    }
    case 2: {
      level thread function_c0c1771a(localclientnum, s_loc_upper, 1, 0);
      level thread function_c0c1771a(localclientnum, s_loc_lower, 1, 1);
      level thread function_a2d0d0e4(s_loc_upper.origin, s_loc_lower.origin, "amb_teleporter_on_lp", "amb_teleporter_off_lp", "amb_teleporter_activate");
      exploder::exploder("lgt_portal_" + str_areaname);
      break;
    }
  }
}

function function_b040f607(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_11ac3c33(localclientnum, "ee_boat", 1);
}

function function_bfbf92fb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_11ac3c33(localclientnum, "ee_boat", 0);
}

function function_11ac3c33(localclientnum, str_areaname, b_is_top) {
  s_loc = get_portal_fx_loc("teleport_effect_origin", str_areaname, b_is_top);
  if(isDefined(s_loc)) {
    var_836f2873 = function_86743484(localclientnum, s_loc);
    for(i = 1; i < 25; i++) {
      if((i % 5) === 0) {
        playFXOnTag(localclientnum, level._effect["portal_shortcut_pulse"], var_836f2873, "tag_fx_ring_" + i);
      }
    }
  }
}

function function_c0c1771a(localclientnum, s_loc, b_open, var_9c9cfb54 = 0) {
  v_fwd = anglesToForward(s_loc.angles);
  if(!isDefined(s_loc.var_7c0ed442)) {
    s_loc.var_7c0ed442 = [];
  }
  if(!isDefined(s_loc.var_20dc3b64)) {
    s_loc.var_20dc3b64 = [];
  }
  if(!isDefined(s_loc.var_1db71ac6)) {
    s_loc.var_1db71ac6 = [];
  }
  stop_fx_if_defined(localclientnum, s_loc.var_7c0ed442[localclientnum]);
  stop_fx_if_defined(localclientnum, s_loc.var_20dc3b64[localclientnum]);
  if(isDefined(b_open) && b_open) {
    s_loc.var_1db71ac6[localclientnum] = playFX(localclientnum, level._effect["portal_shortcut_opening"], s_loc.origin, v_fwd);
  }
  var_836f2873 = function_86743484(localclientnum, s_loc);
  var_836f2873 hidepart(localclientnum, "tag_portal_open");
  if(b_open) {
    wait(1.3);
    var_836f2873 showpart(localclientnum, "tag_portal_open");
    for(i = 1; i < 25; i++) {
      playFXOnTag(localclientnum, level._effect["portal_shortcut_open_border"], var_836f2873, "tag_fx_ring_" + i);
    }
  } else {
    var_836f2873 hidepart(localclientnum, "tag_portal_open");
  }
  stop_fx_if_defined(localclientnum, s_loc.var_1db71ac6[localclientnum]);
  if(isDefined(b_open) && b_open) {
    s_loc.var_7c0ed442[localclientnum] = playFX(localclientnum, level._effect["portal_shortcut_ambient"], s_loc.origin, v_fwd);
  }
}

function function_86743484(localclientnum, s_loc) {
  if(!isDefined(level.var_ef51ee6d)) {
    level.var_ef51ee6d = [];
  }
  if(!isDefined(level.var_ef51ee6d[localclientnum])) {
    level.var_ef51ee6d[localclientnum] = [];
  }
  str_name = s_loc.script_noteworthy;
  if(isDefined(level.var_ef51ee6d[localclientnum][str_name])) {
    return level.var_ef51ee6d[localclientnum][str_name].var_836f2873;
  }
  level.var_ef51ee6d[localclientnum][str_name] = spawnStruct();
  level.var_ef51ee6d[localclientnum][str_name].var_836f2873 = spawn(localclientnum, s_loc.origin, "script_model");
  level.var_ef51ee6d[localclientnum][str_name].var_836f2873.angles = s_loc.angles;
  level.var_ef51ee6d[localclientnum][str_name].var_836f2873 setModel("p7_zm_zod_keeper_portal_01");
  return level.var_ef51ee6d[localclientnum][str_name].var_836f2873;
}

function get_portal_fx_loc(str_targetname, str_areaname, b_is_top) {
  a_s_portal_locs = struct::get_array(str_targetname, "targetname");
  s_return_loc = undefined;
  str_top_or_bottom = undefined;
  if(isDefined(b_is_top) && b_is_top) {
    str_top_or_bottom = "top";
  } else {
    str_top_or_bottom = "bottom";
  }
  foreach(s_portal_loc in a_s_portal_locs) {
    if(s_portal_loc.script_noteworthy === ((str_areaname + "_portal_") + str_top_or_bottom)) {
      s_return_loc = s_portal_loc;
    }
  }
  return s_return_loc;
}

function stop_fx_if_defined(localclientnum, fx_reference) {
  if(isDefined(fx_reference)) {
    stopfx(localclientnum, fx_reference);
  }
}

function function_a2d0d0e4(origin1, origin2, var_4358f968, var_2978dbc6, activation) {}

function function_c968dcbc(origin1, var_4358f968, oneshot, activate = 0) {}

function portal_state_ending_0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isspectating(localclientnum)) {
    return;
  }
  if(!isDefined(level.var_2cc3341a)) {
    level.var_2cc3341a = struct::get("ending_igc_portal_0");
  }
  if(newval) {
    level.var_2cc3341a.var_92f13ff4 = spawn(localclientnum, level.var_2cc3341a.origin, "script_model");
    level.var_2cc3341a.var_92f13ff4.angles = level.var_2cc3341a.angles;
    level.var_2cc3341a.var_92f13ff4 setModel("p7_zm_zod_keeper_portal_01");
    level.var_2cc3341a.var_2f0937c1 = [];
    for(i = 1; i < 25; i++) {
      fx_id = playFXOnTag(localclientnum, level._effect["portal_shortcut_open_border"], level.var_2cc3341a.var_92f13ff4, "tag_fx_ring_" + i);
      if(!isDefined(level.var_2cc3341a.var_2f0937c1)) {
        level.var_2cc3341a.var_2f0937c1 = [];
      } else if(!isarray(level.var_2cc3341a.var_2f0937c1)) {
        level.var_2cc3341a.var_2f0937c1 = array(level.var_2cc3341a.var_2f0937c1);
      }
      level.var_2cc3341a.var_2f0937c1[level.var_2cc3341a.var_2f0937c1.size] = fx_id;
    }
    level thread function_c968dcbc(level.var_2cc3341a.origin, "zmb_teleporter_igc_lp", "zmb_teleporter_igc_start", 1);
  } else {
    foreach(fx_id in level.var_2cc3341a.var_2f0937c1) {
      stopfx(localclientnum, fx_id);
    }
    playFX(localclientnum, level._effect["portal_shortcut_ending"], level.var_2cc3341a.origin, level.var_2cc3341a.angles);
    level thread function_c968dcbc(level.var_2cc3341a.origin, "zmb_teleporter_igc_lp", "zmb_teleporter_igc_end");
    level.var_2cc3341a.var_92f13ff4 delete();
  }
}

function portal_state_ending_1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isspectating(localclientnum)) {
    return;
  }
  if(!isDefined(level.var_52c5ae83)) {
    level.var_52c5ae83 = struct::get("ending_igc_portal_1");
  }
  if(newval) {
    level.var_52c5ae83.var_92f13ff4 = spawn(localclientnum, level.var_52c5ae83.origin, "script_model");
    level.var_52c5ae83.var_92f13ff4.angles = level.var_52c5ae83.angles;
    level.var_52c5ae83.var_92f13ff4 setModel("p7_zm_zod_keeper_portal_01");
    level.var_52c5ae83.var_2f0937c1 = [];
    for(i = 1; i < 25; i++) {
      fx_id = playFXOnTag(localclientnum, level._effect["portal_shortcut_open_border"], level.var_52c5ae83.var_92f13ff4, "tag_fx_ring_" + i);
      if(!isDefined(level.var_52c5ae83.var_2f0937c1)) {
        level.var_52c5ae83.var_2f0937c1 = [];
      } else if(!isarray(level.var_52c5ae83.var_2f0937c1)) {
        level.var_52c5ae83.var_2f0937c1 = array(level.var_52c5ae83.var_2f0937c1);
      }
      level.var_52c5ae83.var_2f0937c1[level.var_52c5ae83.var_2f0937c1.size] = fx_id;
    }
    level thread function_c968dcbc(level.var_52c5ae83.origin, "zmb_teleporter_igc_lp", "zmb_teleporter_igc_start", 1);
  } else {
    foreach(fx_id in level.var_52c5ae83.var_2f0937c1) {
      stopfx(localclientnum, fx_id);
    }
    playFX(localclientnum, level._effect["portal_shortcut_ending"], level.var_52c5ae83.origin, level.var_52c5ae83.angles);
    level thread function_c968dcbc(level.var_52c5ae83.origin, "zmb_teleporter_igc_lp", "zmb_teleporter_igc_end");
    level.var_52c5ae83.var_92f13ff4 delete();
  }
}

function portal_state_ending_2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isspectating(localclientnum)) {
    return;
  }
  if(!isDefined(level.var_e0be3f48)) {
    level.var_e0be3f48 = struct::get("ending_igc_portal_2");
  }
  if(newval) {
    level.var_e0be3f48.var_92f13ff4 = spawn(localclientnum, level.var_e0be3f48.origin, "script_model");
    level.var_e0be3f48.var_92f13ff4.angles = level.var_e0be3f48.angles;
    level.var_e0be3f48.var_92f13ff4 setModel("p7_zm_zod_keeper_portal_01");
    level.var_e0be3f48.var_2f0937c1 = [];
    for(i = 1; i < 25; i++) {
      fx_id = playFXOnTag(localclientnum, level._effect["portal_shortcut_open_border"], level.var_e0be3f48.var_92f13ff4, "tag_fx_ring_" + i);
      if(!isDefined(level.var_e0be3f48.var_2f0937c1)) {
        level.var_e0be3f48.var_2f0937c1 = [];
      } else if(!isarray(level.var_e0be3f48.var_2f0937c1)) {
        level.var_e0be3f48.var_2f0937c1 = array(level.var_e0be3f48.var_2f0937c1);
      }
      level.var_e0be3f48.var_2f0937c1[level.var_e0be3f48.var_2f0937c1.size] = fx_id;
    }
    level thread function_c968dcbc(level.var_e0be3f48.origin, "zmb_teleporter_igc_lp", "zmb_teleporter_igc_start", 1);
  } else {
    foreach(fx_id in level.var_e0be3f48.var_2f0937c1) {
      stopfx(localclientnum, fx_id);
    }
    playFX(localclientnum, level._effect["portal_shortcut_ending"], level.var_e0be3f48.origin, level.var_e0be3f48.angles);
    level thread function_c968dcbc(level.var_e0be3f48.origin, "zmb_teleporter_igc_lp", "zmb_teleporter_igc_end");
    level.var_e0be3f48.var_92f13ff4 delete();
  }
}

function portal_state_ending_3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isspectating(localclientnum)) {
    return;
  }
  if(!isDefined(level.var_6c0b9b1)) {
    level.var_6c0b9b1 = struct::get("ending_igc_portal_3");
  }
  if(newval) {
    level.var_6c0b9b1.var_92f13ff4 = spawn(localclientnum, level.var_6c0b9b1.origin, "script_model");
    level.var_6c0b9b1.var_92f13ff4.angles = level.var_6c0b9b1.angles;
    level.var_6c0b9b1.var_92f13ff4 setModel("p7_zm_zod_keeper_portal_01");
    level.var_6c0b9b1.var_2f0937c1 = [];
    for(i = 1; i < 25; i++) {
      fx_id = playFXOnTag(localclientnum, level._effect["portal_shortcut_open_border"], level.var_6c0b9b1.var_92f13ff4, "tag_fx_ring_" + i);
      if(!isDefined(level.var_6c0b9b1.var_2f0937c1)) {
        level.var_6c0b9b1.var_2f0937c1 = [];
      } else if(!isarray(level.var_6c0b9b1.var_2f0937c1)) {
        level.var_6c0b9b1.var_2f0937c1 = array(level.var_6c0b9b1.var_2f0937c1);
      }
      level.var_6c0b9b1.var_2f0937c1[level.var_6c0b9b1.var_2f0937c1.size] = fx_id;
    }
    level thread function_c968dcbc(level.var_6c0b9b1.origin, "zmb_teleporter_igc_lp", "zmb_teleporter_igc_start", 1);
  } else {
    foreach(fx_id in level.var_6c0b9b1.var_2f0937c1) {
      stopfx(localclientnum, fx_id);
    }
    playFX(localclientnum, level._effect["portal_shortcut_ending"], level.var_6c0b9b1.origin, level.var_6c0b9b1.angles);
    level thread function_c968dcbc(level.var_6c0b9b1.origin, "zmb_teleporter_igc_lp", "zmb_teleporter_igc_end");
    level.var_6c0b9b1.var_92f13ff4 delete();
  }
}