/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_tiger.csc
***********************************************/

#include scripts\core_common\ai\systems\fx_character;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_utility;

#namespace zm_ai_tiger;

autoexec __init__system__() {
  system::register(#"zm_ai_tiger", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "" + #"hash_14c746e550d9f3ca", 1, 2, "counter", &function_76110e92, 0, 0);
  ai::add_archetype_spawn_function(#"tiger", &function_6d7e1f79);
}

function_6d7e1f79(localclientnum) {
  self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_red", #"zm_ai/fx8_zombie_tiger_eye_glow_red");
  self.var_4703d488 = &function_3be6531a;
  self callback::on_shutdown(&on_entity_shutdown);
}

function_76110e92(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(abs(newval - oldval) == 1) {
    self postfx::playpostfxbundle("pstfx_tiger_slash");
  } else {
    self postfx::playpostfxbundle("pstfx_tiger_slash_r_to_l");
  }

  self playSound(localclientnum, #"hash_53d906ab01cb30a1");
}

function_3be6531a(localclientnum, turned) {
  if(turned) {
    self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_green", #"zm_ai/fx8_zombie_tiger_eye_glow_green");
    return;
  }

  self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_red", #"zm_ai/fx8_zombie_tiger_eye_glow_red");
}

on_entity_shutdown(localclientnum) {
  if(isDefined(self)) {
    self zm_utility::good_barricade_damaged(localclientnum);
    origin = self gettagorigin("j_spine2");
    angles = self gettagangles("j_spine2");

    if(!isDefined(origin)) {
      origin = self.origin;
    }

    if(!isDefined(angles)) {
      angles = self.angles;
    }

    playFX(localclientnum, "zm_ai/fx8_zombie_tiger_death_exp", origin, anglesToForward(angles));
    playSound(0, #"hash_5f574d847a1ca1f0", self.origin);
  }
}