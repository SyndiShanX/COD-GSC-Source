/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_escape_util.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace zm_escape_util;

init_clientfields() {
  clientfield::register("scriptmover", "" + #"hash_7327d0447d656234", 1, 1, "int", &function_6799fbc4, 0, 0);
  clientfield::register("item", "" + #"hash_76662556681a502c", 1, 1, "int", &function_e2c78db9, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_59be891b288663cc", 1, 1, "int", &function_41f46060, 0, 0);
  clientfield::register("toplayer", "" + #"hash_257c215ab25a21c5", 1, 1, "counter", &function_b334fc71, 0, 0);
  level._effect[#"hash_7e0daf8faf89bbcf"] = #"hash_1f101b4b415639bb";
}

function_6799fbc4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(!isDefined(level.var_22a393d4)) {
      level.var_22a393d4 = [];
    } else if(!isarray(level.var_22a393d4)) {
      level.var_22a393d4 = array(level.var_22a393d4);
    }

    if(!isinarray(level.var_22a393d4, self)) {
      level.var_22a393d4[level.var_22a393d4.size] = self;
    }

    self.show_function = &function_c06aed2;
    self.hide_function = &function_59cd4ca1;
    self hide();
    return;
  }

  arrayremovevalue(level.var_22a393d4, self);
  self show();
  self notify(#"hash_6ab654a4c018818c");
}

private function_c06aed2(localclientnum) {
  self show();
  self notify(#"set_visible");
}

private function_59cd4ca1(localclientnum) {
  self hide();
  self notify(#"set_invisible");
}

function_e2c78db9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.n_fx_id)) {
    stopfx(localclientnum, self.n_fx_id);
    self.n_fx_id = undefined;
  }

  if(isDefined(self.var_b3673abf)) {
    self stoploopsound(self.var_b3673abf);
    self.var_b3673abf = undefined;
  }

  if(newval) {
    self.n_fx_id = util::playFXOnTag(localclientnum, level._effect[#"hash_4d2e5c87bde94856"], self, "tag_origin");
    self.var_b3673abf = self playLoopSound(#"hash_2f017f6ef4550155");
  }
}

function_41f46060(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_aa4114ee)) {
    stopfx(localclientnum, self.var_aa4114ee);
    self.var_aa4114ee = undefined;
  }

  if(newval == 1) {
    self.var_aa4114ee = util::playFXOnTag(localclientnum, level._effect[#"hash_7e0daf8faf89bbcf"], self, "tag_origin");
  }
}

function_b334fc71(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!function_65b9eb0f(localclientnum)) {
    self playrumbleonentity(localclientnum, #"hash_2be72209069697d0");
  }
}