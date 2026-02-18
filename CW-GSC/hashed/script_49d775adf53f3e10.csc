/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_49d775adf53f3e10.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_ping;
#namespace namespace_47809ab2;

function init() {
  init_clientfields();
}

function init_clientfields() {
  clientfield::register("toplayer", "" + # "flinger_pad_fling", 1, 1, "int", &function_9199e921, 0, 0);
  clientfield::register("allplayers", "" + # "hash_31c153af499657fd", 1, 1, "int", &function_4a0e5efb, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_5822132672ad230f", 1, 1, "int", &function_2c087855, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_6219dce209d171ed", 1, 2, "int", &function_fccba5d0, 0, 0);
  zm_ping::function_5ae4a10c("p9_zm_gold_jumppads_machine_mod", "gold_jump_pad", #"hash_7f09cfa60a53e5da", undefined, #"hash_78c19a4e1e68d0c4", 1, -20);
  zm_ping::function_5ae4a10c("p9_zm_gold_jumppads_machine_sub", "gold_landing_pad", #"hash_5d6fe9e2bb10532d", undefined, #"hash_3a19bc129f8b2b4b");
}

function function_9199e921(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self thread postfx::playpostfxbundle("pstfx_jump_pad_launch");
    return;
  }

  self thread postfx::exitpostfxbundle("pstfx_jump_pad_launch");
  self playrumbleonentity(fieldname, #"hash_17a7c0691c65e722");
}

function function_4a0e5efb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_1749c2a9 = self playLoopSound(#"hash_64c2dcc38c5547e2");
    return;
  }

  if(isDefined(self.var_1749c2a9)) {
    self stoploopsound(self.var_1749c2a9);
    self.var_1749c2a9 = undefined;
  }
}

function function_2c087855(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(!isDefined(self.var_c9480534)) {
      self.var_c9480534 = self playLoopSound(#"hash_67d068901551222c");
    }

    return;
  }

  if(isDefined(self.var_c9480534)) {
    self stoploopsound(self.var_c9480534);
    self.var_c9480534 = undefined;
  }
}

function function_fccba5d0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_4b81d3a7)) {
    stopfx(fieldname, self.var_4b81d3a7);
    self.var_4b81d3a7 = undefined;
  }

  if(isDefined(self.var_510ae6c9)) {
    stopfx(fieldname, self.var_510ae6c9);
    self.var_510ae6c9 = undefined;
  }

  switch (bwastimejump) {
    case 0:
      break;
    case 1:
      self.var_510ae6c9 = util::playFXOnTag(fieldname, #"hash_425a20b3838488b9", self, "tag_light_right_fx");
      self.var_4b81d3a7 = util::playFXOnTag(fieldname, #"hash_425a20b3838488b9", self, "tag_light_left_fx");
      break;
    case 2:
      self.var_510ae6c9 = util::playFXOnTag(fieldname, #"hash_2fa753029cdd63bd", self, "tag_light_right_fx");
      self.var_4b81d3a7 = util::playFXOnTag(fieldname, #"hash_2fa753029cdd63bd", self, "tag_light_left_fx");
      break;
    default:
      break;
  }
}