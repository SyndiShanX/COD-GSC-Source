/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_human.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#namespace archetype_human;

function autoexec precache() {}

function autoexec main() {
  clientfield::register("actor", "facial_dial", 1, 1, "int", &humanclientutils::facialdialoguehandler, 0, 1);
  clientfield::register("actor", "lipflap_anim", 1, 2, "int", undefined, 0, 1);
}

#namespace humanclientutils;

function facialdialoguehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    self.facialdialogueactive = 1;
    return;
  }

  if(is_true(self.facialdialogueactive)) {
    self clearanim(#"faces", 0);
  }
}