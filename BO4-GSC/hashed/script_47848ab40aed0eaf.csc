/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_47848ab40aed0eaf.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\item_world_fixup;
#include scripts\wz_common\character_unlock_fixup;

#namespace namespace_b7ee637a;

autoexec __init__system__() {
  system::register(#"hash_7710b10c0110b17", &__init__, undefined, #"hash_5d70c94021e00856");
}

__init__() {
  if(isDefined(getgametypesetting(#"hash_6fb11b1e304d533c")) ? getgametypesetting(#"hash_6fb11b1e304d533c") : 0) {
    item_world_fixup::function_e70fa91c(#"supply_stash_parent", #"world_hw_event_tags_supply_drop", 3);
  }
}