/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_office_ww_quest.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace zm_office_ww_quest;

autoexec __init__system__() {
  system::register(#"zm_office_ww_quest", &__init__, undefined, undefined);
}

__init__() {
  init_clientfields();
}

init_clientfields() {
  clientfield::register("toplayer", "" + #"hash_61ff06b1f8850806", 1, 1, "int", &drawer_rumble, 0, 0);
}

drawer_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrumbleonentity(localclientnum, #"zm_office_drawer_rumble");
  }
}