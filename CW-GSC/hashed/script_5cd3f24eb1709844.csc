/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5cd3f24eb1709844.csc
***********************************************/

#using scripts\core_common\beam_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace namespace_178eb32b;

function init() {
  clientfield::register("scriptmover", "" + # "hash_eb1d61f9d0ab6ab", 1, 2, "int", &function_968feb60, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_4ace5aed82d35b19", 1, 1, "int", &function_63dce83f, 0, 0);
  clientfield::register("toplayer", "" + # "hash_32d35af47559b320", 1, 1, "int", &function_6c47410d, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_575d68a64ff032b2", 1, 1, "counter", &function_1fa52d9a, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_16e5e4d2ea0716b7", 1, 2, "int", &function_2879e60b, 0, 0);
}

function function_968feb60(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    if(isDefined(self.var_9fae3db4)) {
      stopfx(fieldname, self.var_9fae3db4);
      self.var_9fae3db4 = undefined;
    }

    self.var_9fae3db4 = util::playFXOnTag(fieldname, #"hash_1fb650ed35a01358", self, "tag_origin");
  }

  if(bwasdemojump == 2) {
    if(isDefined(self.var_9fae3db4)) {
      stopfx(fieldname, self.var_9fae3db4);
      self.var_9fae3db4 = undefined;
    }

    self.var_9fae3db4 = util::playFXOnTag(fieldname, #"hash_60791ecaad8f98e6", self, "tag_origin");
  }
}

function function_63dce83f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  level endon(#"end_game");
  self endon(#"death");

  if(bwasdemojump == 1) {
    self.var_dffa7aba = util::spawn_model(fieldname, "tag_origin", self.origin, self.angles);
    self.var_dffa7aba playSound(fieldname, "mpl_ultimate_turret_lockon_enemy");
    self callback::add_entity_callback(#"death", &function_3a7e8f1f);

    while(true) {
      var_abdb3f07 = anglesToForward(self.angles);
      trace_result = bulletTrace(self.origin, self.origin + var_abdb3f07 * 1000, 0, self);
      var_1328f706 = trace_result[#"position"];
      self.var_dffa7aba.origin = var_1328f706;
      waitframe(5);
    }
  }
}

function function_3a7e8f1f(params) {
  if(isDefined(self.var_dffa7aba)) {
    self.var_dffa7aba delete();
  }
}

function function_6c47410d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1 && !self postfx::function_556665f2(#"hash_6f19f661d99b2da9")) {
    self postfx::playpostfxbundle(#"hash_6f19f661d99b2da9");
    return;
  }

  if(self postfx::function_556665f2(#"hash_6f19f661d99b2da9")) {
    self postfx::exitpostfxbundle(#"hash_6f19f661d99b2da9");
  }
}

function function_2879e60b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    if(isDefined(self.var_dd37157)) {
      stopfx(fieldname, self.var_dd37157);
      self.var_dd37157 = undefined;
    }

    self.var_dd37157 = playFX(fieldname, #"hash_5e71af4ea513be2c", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }

  if(bwasdemojump == 2) {
    if(isDefined(self.var_dd37157)) {
      stopfx(fieldname, self.var_dd37157);
      self.var_dd37157 = undefined;
    }

    self.var_dd37157 = playFX(fieldname, #"hash_5e71bc4ea513d443", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }
}

function function_1fa52d9a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    playFX(fieldname, #"hash_179a76b8d709e8bb", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  }
}