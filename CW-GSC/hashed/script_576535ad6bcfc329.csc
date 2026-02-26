/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_576535ad6bcfc329.csc
***********************************************/

#using scripts\core_common\ai\archetype_skeleton;
#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_d1abdcb5;

function init() {
  function_cae618b4("spawner_zombietron_skeleton");
  function_cae618b4("spawner_zombietron_skeleton_giant");
  clientfield::register("scriptmover", "" + # "spartoi_reassemble_clientfield", 1, 1, "int", &function_d83c0144, 0, 0);
  clientfield::register("actor", "" + # "hash_3a6a3e4ef0a1a999", 1, 1, "counter", &function_9e6319c8, 0, 0);
  clientfield::register("actor", "skel_spawn_fx", 1, 1, "counter", &skel_spawn_fx, 0, 0);
  ai::add_archetype_spawn_function(#"skeleton", &skeletonspawnsetup);
  ai::add_archetype_spawn_function(#"skeleton", &function_3b8e5273);
}

function skel_spawn_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(bwasdemojump, level._effect[#"lightning_dog_spawn"], self, "j_spine2");
}

function private skeletonspawnsetup(localclientnum) {
  self util::waittill_dobj(localclientnum);

  if(isDefined(self)) {
    fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
  }
}

function private function_3b8e5273(localclientnum) {
  if(self.subarchetype === # "hash_342763a42d8fbca" || self.subarchetype === # "hash_fd7b9665529dd42") {
    if(!is_true(level.shield_streaming)) {
      level.shield_streaming = 1;
      forcestreamxmodel(#"c_t8_zmb_dlc2_skeleton_shield");
      wait 3;
      stopforcestreamingxmodel(#"c_t8_zmb_dlc2_skeleton_shield");
      level.shield_streaming = 0;
    }
  }
}

function private function_d83c0144(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump == 1) {
    self.fx = function_239993de(fieldname, "zm_ai/fx8_spartoi_reassemble_displace_trail", self, "tag_origin");
    return;
  }

  stopfx(fieldname, self.fx);
}

function private function_9e6319c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump == 1) {
    point = self gettagorigin("j_skeleton_shield");

    if(!isDefined(point)) {
      return;
    }

    angles = self.angles;
    forward = anglesToForward(angles);
    up = anglestoup(angles);
    playFX(fieldname, "impacts/fx8_bul_impact_metal_lg", point, forward, up);
  }
}