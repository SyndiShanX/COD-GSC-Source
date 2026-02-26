/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_51f076d69a1d85d2.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_8af9269b;

function private autoexec __init__system__() {
  system::register(#"hash_2261850aec98f6f8", &preload, &postload, undefined, undefined);
}

function preload() {
  clientfield::register("toplayer", "zipline_postfx", 1, 1, "int", &zipline_postfx, 0, 0);
  clientfield::register("toplayer", "zipline_gesture_strap_visibility", 1, 1, "int", &zipline_gesture_strap_visibility, 0, 0);
  clientfield::register("toplayer", "zipline_player_landing_fx", 1, 2, "counter", &zipline_player_landing_fx, 0, 0);
  clientfield::register("actor", "zipline_ai_landing_fx", 1, 2, "counter", &zipline_ai_landing_fx, 0, 0);
  clientfield::register("scriptmover", "zipline_strap_visibility", 1, 1, "int", &zipline_strap_visibility, 0, 0);
}

function postload() {
  level._effect[#"zipline_ai_landing_fx"] = # "hash_62e38c7e6420e59d";
  level._effect[#"zipline_player_landing_fx"] = # "hash_62e38c7e6420e59d";
}

function zipline_postfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(self postfx::function_556665f2("pstfx_ice_slide_motion_blur")) {
      self postfx::stoppostfxbundle("pstfx_ice_slide_motion_blur");
    }

    self postfx::playpostfxbundle("pstfx_ice_slide_motion_blur");
    return;
  }

  self notify(#"hash_4075bb1fa37309a0");
  self postfx::exitpostfxbundle("pstfx_ice_slide_motion_blur");
}

function function_17e2302() {
  self endon(#"hash_4075bb1fa37309a0");
  n_blur_amount = 0;

  while(n_blur_amount < 2) {
    self postfx::function_c8b5f318("pstfx_ice_slide_motion_blur", #"blur amount", n_blur_amount);
    wait 0.2;
    n_blur_amount += 0.2;
  }
}

function zipline_player_landing_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump === 1) {
    util::playFXOnTag(fieldname, level._effect[#"zipline_player_landing_fx"], self, "tag_origin");
    return;
  }

  if(bwastimejump === 2) {
    util::playFXOnTag(fieldname, level._effect[#"zipline_player_landing_fx"], self, "tag_origin");
  }
}

function zipline_ai_landing_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump === 1) {
    util::playFXOnTag(fieldname, level._effect[#"zipline_ai_landing_fx"], self, "tag_origin");
    return;
  }

  if(bwastimejump === 2) {
    util::playFXOnTag(fieldname, level._effect[#"zipline_ai_landing_fx"], self, "tag_origin");
  }
}

function zipline_strap_visibility(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self playrenderoverridebundle("rob_zipline_strap_fade_out");
    wait 1.8;
    self hide();
    return;
  }

  if(bwastimejump == 0) {
    self stoprenderoverridebundle("rob_zipline_strap_fade_out");
    self show();
  }
}

function zipline_gesture_strap_visibility(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self playrenderoverridebundle("rob_zipline_gesture_strap_fade_out", "tag_torso");
  }

  if(bwastimejump == 0) {
    self playrenderoverridebundle("rob_zipline_gesture_strap_fade_in", "tag_torso");
  }
}