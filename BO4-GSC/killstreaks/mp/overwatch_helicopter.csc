/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\overwatch_helicopter.csc
***************************************************/

#include script_324d329b31b9b4ec;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\renderoverridebundle;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\killstreak_bundles;

#namespace swat_team;

autoexec __init__system__() {
  system::register(#"overwatch_helicopter", &__init__, undefined, #"killstreaks");
}

__init__() {
  bundle = struct::get_script_bundle("killstreak", "killstreak_overwatch_helicopter");
  ai::add_archetype_spawn_function("human", &spawned, bundle);
}

function_555b0649(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self disablevisioncircle(localclientnum);
  }
}

spawned(local_client_num, bundle) {
  if(self.subarchetype === #"human_sniper") {
    self killstreak_bundles::spawned(local_client_num, bundle);
  }
}