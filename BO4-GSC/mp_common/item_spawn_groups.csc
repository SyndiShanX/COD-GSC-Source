/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\item_spawn_groups.csc
***********************************************/

#include script_68c78107b4aa059c;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;

#namespace item_spawn_group;

setup(localclientnum, seedvalue, reset = 1) {
  if(!namespace_65181344::is_enabled()) {
    return;
  }

  level.var_8c615e33 = [];
  function_1f4464c0(seedvalue);

  if(reset) {
    level callback::callback(#"hash_11bd48298bde44a4", undefined);
  }

  namespace_65181344::setup_groups(reset);
}