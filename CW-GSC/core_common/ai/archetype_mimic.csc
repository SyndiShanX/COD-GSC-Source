/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_mimic.csc
***********************************************/

#using script_197da0bce1da228f;
#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace archetype_mimic;

function private autoexec __init__system__() {
  system::register(#"archetype_mimic", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!isarchetypeloaded(#"mimic")) {
    return;
  }

  clientfield::register("actor", "" + # "hash_2f1c34ea62d86c57", 1, 1, "int", &function_ef33ecb7, 0, 0);
  clientfield::register("toplayer", "mimic_force_stream", 1, 1, "int", &mimic_force_stream, 0, 0);
  clientfield::register("actor", "mimic_emerge_fx", 1, 1, "int", &function_807a046, 0, 0);
  clientfield::register("toplayer", "mimic_attack_hit", 1, 1, "int", &mimic_attack_hit, 0, 0);
  clientfield::register("toplayer", "mimic_grab_hit", 1, 1, "int", &mimic_grab_hit, 0, 0);
  clientfield::register("actor", "mimic_weakpoint_fx", 1, 1, "int", &mimic_weakpoint_fx, 0, 0);
  clientfield::register("scriptmover", "mimic_prop_lure_fx", 16000, 1, "int", &mimic_prop_lure_fx, 0, 0);
  clientfield::register("actor", "mimic_death_gib_fx", 1, 1, "int", &mimic_death_gib_fx, 0, 0);
  clientfield::register("toplayer", "mimic_bite_hit", 16000, 1, "counter", &function_90fb7f1f, 0, 0);
  ai::add_archetype_spawn_function(#"mimic", &function_c50aa4b2);
}

function function_c50aa4b2(localclientnum) {
  self fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

function function_ef33ecb7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(self.archetype !== # "mimic") {
    return;
  }

  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  foreach(bone in ["j_tentacle_01_le", "j_tentacle_01_ri", "j_tentacle_02_le", "j_tentacle_02_ri", "j_tentacle_03_le", "j_tentacle_03_ri", "j_tentacle_04_le", "j_tentacle_04_ri"]) {
    self function_d309e55a(bone, bwastimejump);
  }
}

function mimic_force_stream(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    util::lock_model(#"c_t9_zmb_mimic_body");
    return;
  }

  util::unlock_model(#"c_t9_zmb_mimic_body");
}

function function_807a046(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_e50d2931 = self.origin;
  var_675c08c1 = anglesToForward(self.angles);
  playFX(bwastimejump, "zm_ai/fx9_mimic_emerge_base", var_e50d2931, var_675c08c1);
  playSound(bwastimejump, #"hash_4f37c259b7d6bd76", var_e50d2931 + (0, 0, 20));
  playSound(bwastimejump, #"hash_10d33a1d9ba04133", var_e50d2931);
}

function mimic_attack_hit(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    earthquake(fieldname, 0.5, 0.8, self.origin, 500);
  }
}

function mimic_grab_hit(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  util::waittill_dobj(fieldname);

  if(bwastimejump) {
    if(!isDefined(self.var_a0d6f528)) {
      self.var_a0d6f528 = playfxoncamera(fieldname, #"hash_37726d87afd1fe2", (0, 0, 0), (1, 0, 0));
    }

    return;
  }

  if(isDefined(self.var_a0d6f528)) {
    stopfx(fieldname, self.var_a0d6f528);
    self.var_a0d6f528 = undefined;
  }
}

function mimic_weakpoint_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump === 1) {
    self.mimic_weakpoint_fx = util::playFXOnTag(fieldname, "zm_ai/fx9_mimic_weak_point", self, "tag_weakpoint_mouth");
  }

  if(bwastimejump === 0 && isDefined(self.mimic_weakpoint_fx)) {
    stopfx(fieldname, self.mimic_weakpoint_fx);
  }
}

function mimic_prop_lure_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    if(!self function_d2503806("rob_sr_item_gold")) {
      self playrenderoverridebundle("rob_sr_item_gold");
    }

    return;
  }

  if(self function_d2503806("rob_sr_item_gold")) {
    self function_f6e99a8d("rob_sr_item_gold");
  }

  playFX(fieldname, #"zm_ai/fx9_mimic_prop_spawn_out", self.origin);
}

function mimic_death_gib_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }
}

function function_90fb7f1f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  util::waittill_dobj(bwastimejump);

  if(!isDefined(self)) {
    return;
  }

  var_86b3d9b7 = # "hash_5e666010ee5cb822";

  if(self postfx::function_556665f2(var_86b3d9b7)) {
    self postfx::stoppostfxbundle(var_86b3d9b7);
  }

  self postfx::playpostfxbundle(var_86b3d9b7);
}