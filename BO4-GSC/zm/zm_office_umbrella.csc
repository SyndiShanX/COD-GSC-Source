/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_office_umbrella.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;

#namespace zm_office_umbrella;

autoexec __init__system__() {
  system::register(#"zm_office_umbrella", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 1, 1, "counter", &function_87d68f99, 0, 0);
  clientfield::register("world", "" + #"narrative_room", 1, 1, "int", &narrative_room, 0, 0);
}

function_87d68f99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self thread postfx::playpostfxbundle(#"hash_5e9232163a119c6b");
    playSound(localclientnum, #"hash_50a56f17fc412b92", (0, 0, 0));
  }
}

narrative_room(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    function_a5777754(localclientnum, "lab_supply");
    return;
  }

  function_73b1f242(localclientnum, "lab_supply");
}