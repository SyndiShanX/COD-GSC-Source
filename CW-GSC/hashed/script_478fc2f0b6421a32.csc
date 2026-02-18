/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_478fc2f0b6421a32.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace namespace_60bf0cf2;

function init() {
  init_clientfields();
}

function init_clientfields() {
  clientfield::register("scriptmover", "" + # "hash_5808d23568bc787", 1, 1, "int", &function_f1c7d9e3, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_50dd9d9bf6b71a00", 1, 1, "counter", &function_2518f379, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_464c0289eeaff2a8", 1, 1, "int", &function_35a58b7, 0, 0);
}

function function_f1c7d9e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_ddd3b139 = util::playFXOnTag(fieldname, #"hash_67ab48748fb2d398", self, "j_eyeball_le");
    return;
  }

  if(isDefined(self.var_ddd3b139)) {
    stopfx(fieldname, self.var_ddd3b139);
    self.var_ddd3b139 = undefined;
  }
}

function function_2518f379(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    util::playFXOnTag(fieldname, #"hash_1a0fe6e34e30e968", self, "j_mainroot");
  }
}

function function_35a58b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    util::playFXOnTag(fieldname, #"hash_1eade7553747299a", self, "j_mainroot");
  }
}