/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_38867f943fb86135.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace cp_post;

function private autoexec __init__system__() {
  system::register(#"cp_post", undefined, &post_init, undefined, undefined);
}

function post_init() {
  callback::on_localplayer_spawned(&start);
}

function start(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(function_72a9e321()) {
    self.bundle = "pstfx_t9_cp_default";
  } else {
    self.bundle = "pstfx_t9_cp_current_gen";
  }

  self postfx::playpostfxbundle(self.bundle);
  self postfx::function_c8b5f318(self.bundle, "Vignette Fade", 0.5);
  self postfx::function_c8b5f318(self.bundle, "Reveal Threshold", 0.5);

  if(function_72a9e321()) {
    self postfx::function_c8b5f318(self.bundle, "Blur Amount", 0.5);
    self postfx::function_c8b5f318(self.bundle, "Aberration", 0.5);
  }

  setDvar(#"hash_7633a587d5705d08", 1);
}

function stop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(postfx::function_556665f2(self.bundle)) {
    self postfx::stoppostfxbundle(self.bundle);
  }
}

function function_d9475fc(var_dccfb95, var_72b185dd, aberration, reveal_threshold) {
  if(!postfx::function_556665f2(self.bundle)) {
    waitframe(1);
  }

  if(isDefined(var_dccfb95)) {
    self postfx::function_c8b5f318(self.bundle, "Vignette Fade", var_dccfb95);
  }

  if(isDefined(var_72b185dd) && function_72a9e321()) {
    self postfx::function_c8b5f318(self.bundle, "Blur Amount", var_72b185dd);
  }

  if(isDefined(aberration) && function_72a9e321()) {
    self postfx::function_c8b5f318(self.bundle, "Aberration", aberration);
  }

  if(isDefined(reveal_threshold)) {
    self postfx::function_c8b5f318(self.bundle, "Reveal Threshold", reveal_threshold);
  }
}