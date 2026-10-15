/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\dog.csc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\shoutcaster;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\killstreaks\dog_shared;
#include scripts\killstreaks\killstreak_bundles;

#namespace dog;

autoexec __init__system__() {
  system::register(#"killstreak_dog", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
  bundle = struct::get_script_bundle("killstreak", #"killstreak_dog");
  ai::add_archetype_spawn_function(#"mp_dog", &spawned, bundle);
}

spawned(local_client_num, bundle) {
  self killstreak_bundles::spawned(local_client_num, bundle);
  self function_a25e8ff(local_client_num);
}

function_a25e8ff(local_client_num) {
  if(shoutcaster::is_shoutcaster(local_client_num)) {
    self shoutcaster::function_a0b844f1(local_client_num, #"hash_16bdbd0b3de5c91a", #"hash_71fbf1094f57b910");
  }
}