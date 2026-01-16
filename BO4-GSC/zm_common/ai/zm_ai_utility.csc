/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\ai\zm_ai_utility.csc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\system_shared;

#namespace zm_ai_utility;

autoexec __init__system__() {
  system::register(#"zm_ai_utility", &__init__, undefined, undefined);
}

private __init__() {
  ai::add_ai_spawn_function(&function_f3a051c6);
}

private function_f3a051c6(localclientnum) {}