/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_22a36cbdf7e3bd31.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#namespace namespace_45690bb8;

function init() {
  init_clientfields();
}

function init_clientfields() {
  clientfield::register("scriptmover", "" + # "hash_18735ccb22cdefb5", 1, 1, "int", &function_d9576449, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_1df73c94e87e145c", 1, 1, "int", &function_7d5ce4d9, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_615d25f799b80ed7", 1, 1, "int", &function_672b008a, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7e481cd16f021d79", 1, 1, "int", &function_5402e221, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_acf98ff6d976e10", 1, 1, "int", &function_1a90da2b, 0, 0);
  clientfield::register("world", "" + # "hash_58dd30074d399de5", 1, 1, "int", &function_8772dde6, 0, 0);
  clientfield::register("world", "" + # "hash_195f6fa038980aca", 1, 1, "int", &function_38a832d2, 0, 0);
  clientfield::register("actor", "" + # "hash_3d14472eb7838c71", 1, 1, "int", &function_33d52b21, 0, 0);
  clientfield::register("toplayer", "" + # "hash_734d80bbfc2cb595", 1, 2, "counter", &function_ccd8d6e0, 0, 0);
  clientfield::register("toplayer", "" + # "hash_802934d416ac981", 1, 1, "int", &function_6b8c4c36, 0, 0);
}

function function_d9576449(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_c0049122 = util::playFXOnTag(fieldname, #"hash_50611dced846f036", self, "tag_origin");

    if(!isDefined(self.var_8aee9835)) {
      self playSound(fieldname, #"hash_6d99a1e0c2b22c3d");
      self.var_8aee9835 = self playLoopSound(#"hash_7f631a3f8ad73dc0");
    }

    return;
  }

  if(isDefined(self.var_8aee9835)) {
    stopfx(fieldname, self.var_c0049122);
    self playSound(fieldname, #"hash_554b4bdae5c4f739");
    self stoploopsound(self.var_8aee9835);
    self.var_8aee9835 = undefined;
  }
}

function function_7d5ce4d9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_805054e7 = util::playFXOnTag(fieldname, #"hash_58d5e856ce222a5d", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_805054e7)) {
    stopfx(fieldname, self.var_805054e7);
    self.var_805054e7 = undefined;
  }
}

function function_8772dde6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    playSound(fieldname, #"hash_2a8b12ffa840219e", (-245, 1121, 588));
    soundlineemitter(#"hash_141c67065ba502c5", (2009, 553, 659), (-245, 1121, 588));
    soundlineemitter(#"hash_141c67065ba502c5", (-2115, 5914, 1682), (-245, 1121, 588));
    soundlineemitter(#"hash_141c67065ba502c5", (-4142, -1021, 1064), (-245, 1121, 588));
    return;
  }

  soundstoplineemitter(#"hash_141c67065ba502c5", (2009, 553, 659), (-245, 1121, 588));
  soundstoplineemitter(#"hash_141c67065ba502c5", (-2115, 5914, 1682), (-245, 1121, 588));
  soundstoplineemitter(#"hash_141c67065ba502c5", (-4142, -1021, 1064), (-245, 1121, 588));
}

function function_38a832d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    soundloopemitter(#"hash_65f5a97a9265ad32", (562, -98, -315));
    return;
  }

  soundstoploopemitter(#"hash_65f5a97a9265ad32", (562, -98, -315));
}

function function_672b008a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_551198af = playFX(fieldname, #"hash_6836aff4dcf79417", self.origin);
    return;
  }

  if(isDefined(self.var_551198af)) {
    stopfx(fieldname, self.var_551198af);
    self.var_551198af = undefined;
  }
}

function function_5402e221(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {}
}

function function_1a90da2b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_5d366358 = util::playFXOnTag(fieldname, #"hash_23a6fc6ed48651f9", self, "j_eyeball_le");
    return;
  }

  if(isDefined(self.var_5d366358)) {
    stopfx(fieldname, self.var_5d366358);
  }
}

function function_6b8c4c36(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self playrumbleonentity(fieldname, #"hash_431e56f34a345079");
    self postfx::playpostfxbundle(#"hash_1c01122f6d0510cf");
    return;
  }

  self postfx::stoppostfxbundle(#"hash_1c01122f6d0510cf");
}

function function_ccd8d6e0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self playrumbleonentity(fieldname, #"hash_575c14596fbb0902");
    return;
  }

  if(bwastimejump == 2) {
    self playrumbleonentity(fieldname, #"hash_701661f6699fd075");
  }
}

function function_33d52b21(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self function_c2e69953(1);
    return;
  }

  self function_c2e69953(0);
}