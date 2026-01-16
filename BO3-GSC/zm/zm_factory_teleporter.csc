/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_factory_teleporter.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace zm_factory_teleporter;

function autoexec __init__sytem__() {
  system::register("zm_factory_teleporter", & __init__, undefined, undefined);
}

function __init__() {
  visionset_mgr::register_overlay_info_style_postfx_bundle("zm_factory_teleport", 1, 1, "pstfx_zm_der_teleport");
  level thread setup_teleport_aftereffects();
  level thread wait_for_black_box();
  level thread wait_for_teleport_aftereffect();
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
  while (true) {
    level waittill("black_box_start", localclientnum);
    assert(isdefined(localclientnum));
    savedvis = getvisionsetnaked(localclientnum);
    visionsetnaked(localclientnum, "default", 0);
    while (secondclientnum != localclientnum) {
      level waittill("black_box_end", secondclientnum);
    }
    visionsetnaked(localclientnum, savedvis, 0);
  }
}

function wait_for_teleport_aftereffect() {
  while (true) {
    level waittill("tae", localclientnum);
    if(getdvarstring("factoryAftereffectOverride") == ("-1")) {
      self thread[[level.teleport_ae_funcs[randomint(level.teleport_ae_funcs.size)]]](localclientnum);
    } else {
      self thread[[level.teleport_ae_funcs[int(getdvarstring("factoryAftereffectOverride"))]]](localclientnum);
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
  while (i < duration) {
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