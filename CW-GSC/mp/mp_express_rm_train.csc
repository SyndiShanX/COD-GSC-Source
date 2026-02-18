/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp\mp_express_rm_train.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\util_shared;
#namespace namespace_af0fb818;

function function_39da2f0() {
  clientfield::register("vehicle", "" + # "hash_7882b7772f4ea0a8", 9000, 1, "int", &train_move, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7882b7772f4ea0a8", 9000, 1, "int", &train_move, 0, 0);
  clientfield::register("vehicle", "" + # "hash_5dd246706762931", 9000, 1, "int", &function_e8c79645, 0, 0);
}

function main() {}

function train_move(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");

  if(bwasdemojump) {
    self playrumblelooponentity(fieldname, #"hash_41dcb918f58061f6");
    return;
  }

  self stoprumble(fieldname, #"hash_41dcb918f58061f6");
}

function function_e8c79645(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");

  if(bwasdemojump) {
    self.var_995f9c5 = util::playFXOnTag(fieldname, #"hash_443e406921d9df87", self, "tag_linkage_front");
    return;
  }

  if(isDefined(self.var_995f9c5)) {
    stopfx(fieldname, self.var_995f9c5);
    self.var_995f9c5 = undefined;
  }
}