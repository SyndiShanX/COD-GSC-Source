/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_spectre.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace wz_spectre;

autoexec __init__system__() {
  system::register(#"wz_spectre", &__init__, undefined, undefined);
}

__init__() {
  if(!(isDefined(getgametypesetting(#"wzspectrerising")) && getgametypesetting(#"wzspectrerising"))) {
    return;
  }

  clientfield::register("allplayers", "hasspectrebody", 16000, 1, "int", &function_14430aff, 0, 0);
  clientfield::register("toplayer", "spectrebladebonus", 16000, 1, "int", &function_4695335, 0, 0);
  clientfield::register("clientuimodel", "hudItems.isSpectre", 16000, 1, "int", undefined, 0, 0);
  clientfield::register("world", "showSpectreSwordBeams", 16000, 1, "int", undefined, 0, 0);
}

function_14430aff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify(#"hash_2e4cc87f4b3a6396");
  self endon(#"death", #"hash_2e4cc87f4b3a6396");

  if(bwastimejump || bnewent) {
    if(self function_d2503806(#"hash_79bdfb09e317953")) {
      self function_f6e99a8d(#"hash_79bdfb09e317953");
    }

    return;
  }

  if(self ishidden()) {
    return;
  }

  if(!self function_d2503806(#"hash_79bdfb09e317953")) {
    self playrenderoverridebundle(#"hash_79bdfb09e317953");

    if(function_5c10bd79(localclientnum) == self) {
      playSound(localclientnum, #"hash_2a2ce981dd655c9d");
    } else {
      self playSound(localclientnum, #"hash_15fe9b5adcf69ee1");
    }
  }

  self thread function_49c88376(localclientnum, newval);
  wait 0.5;

  if(self function_d2503806(#"hash_79bdfb09e317953")) {
    if(self ishidden()) {
      self function_f6e99a8d(#"hash_79bdfb09e317953");
      return;
    }

    self stoprenderoverridebundle(#"hash_79bdfb09e317953");

    if(function_5c10bd79(localclientnum) == self) {
      playSound(localclientnum, #"hash_1e69f4ab3ad9d506");
      return;
    }

    self playSound(localclientnum, #"hash_6920e6c1de254c0a");
  }
}

private function_49c88376(localclientnum, value) {
  self endon(#"death");

  if(!value && function_5c10bd79(localclientnum) == self) {
    wait 0.3;

    if(self hasdobj(localclientnum)) {
      playtagfxset(localclientnum, "tagfx8_plyr_spectre_transformation_wz_1p", self);
    }

    return;
  }

  wait 0.1;

  if(self hasdobj(localclientnum)) {
    playtagfxset(localclientnum, "tagfx8_plyr_spectre_transformation_wz_3p", self);
  }
}

private function_4695335(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playSound(localclientnum, #"hash_11ab19e8dda10854");

    if(!self function_d2503806(#"hash_62ee6965d1ee1724")) {
      self playrenderoverridebundle(#"hash_62ee6965d1ee1724");
    }
  }
}