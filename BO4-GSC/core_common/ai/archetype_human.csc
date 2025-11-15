/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_human.csc
***********************************************/

#include scripts\core_common\clientfield_shared;

#namespace archetype_human;

autoexec

autoexec main() {
  clientfield::register("actor", "facial_dial", 1, 1, "int", &humanclientutils::facialdialoguehandler, 0, 1);
}

#namespace humanclientutils;

facialdialoguehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    self.facialdialogueactive = 1;
    return;
  }

  if(isDefined(self.facialdialogueactive) && self.facialdialogueactive) {
    self clearanim(#"faces", 0);
  }
}