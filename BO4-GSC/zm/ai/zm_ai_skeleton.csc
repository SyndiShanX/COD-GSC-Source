/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_skeleton.csc
***********************************************/

#include scripts\core_common\ai\systems\fx_character;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_ai_skeleton;

autoexec __init__system__() {
  system::register(#"zm_ai_skeleton", &__init__, undefined, undefined);
}

private __init__() {
  clientfield::register("scriptmover", "" + #"spartoi_reassemble_clientfield", 16000, 1, "int", &function_d83c0144, 0, 0);
  clientfield::register("actor", "" + #"hash_3a6a3e4ef0a1a999", 16000, 1, "counter", &function_9e6319c8, 0, 0);
  ai::add_archetype_spawn_function(#"skeleton", &skeletonspawnsetup);
  ai::add_archetype_spawn_function(#"skeleton", &function_3b8e5273);
}

private skeletonspawnsetup(localclientnum) {
  self util::waittill_dobj(localclientnum);

  if(isDefined(self)) {
    fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
  }
}

private function_3b8e5273(localclientnum) {
  if(self.subarchetype === #"hash_342763a42d8fbca" || self.subarchetype === #"hash_fd7b9665529dd42") {
    if(!(isDefined(level.shield_streaming) && level.shield_streaming)) {
      level.shield_streaming = 1;
      forcestreamxmodel(#"c_t8_zmb_dlc2_skeleton_shield");
      wait 3;
      stopforcestreamingxmodel(#"c_t8_zmb_dlc2_skeleton_shield");
      level.shield_streaming = 0;
    }
  }
}

private function_d83c0144(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval == 1) {
    self.fx = function_239993de(localclientnum, "zm_ai/fx8_spartoi_reassemble_displace_trail", self, "tag_origin");

    if(!isDefined(self.var_45dc5e53)) {
      self playSound(0, #"hash_6804d485c5a3300a");
      self.var_45dc5e53 = self playLoopSound(#"hash_2ee9559ba02d2e9e");
    }

    return;
  }

  stopfx(localclientnum, self.fx);

  if(isDefined(self.var_45dc5e53)) {
    self stoploopsound(self.var_45dc5e53);
    self.var_45dc5e53 = undefined;
  }
}

private function_9e6319c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(localclientnum);

  if(newval == 1) {
    point = self gettagorigin("j_skeleton_shield");

    if(!isDefined(point)) {
      return;
    }

    angles = self.angles;
    forward = anglesToForward(angles);
    up = anglestoup(angles);
    playSound(localclientnum, #"hash_72db6f3f0e602a33", point);
    playFX(localclientnum, "impacts/fx8_bul_impact_metal_sm", point, forward, up);
  }
}