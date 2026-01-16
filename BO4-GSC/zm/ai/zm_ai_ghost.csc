/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_ghost.csc
***********************************************/

#include scripts\core_common\ai\systems\fx_character;
#include scripts\core_common\ai_shared;
#include scripts\core_common\system_shared;

#namespace zm_ai_ghost;

autoexec __init__system__() {
  system::register(#"zm_ai_ghost", &__init__, undefined, undefined);
}

__init__() {
  ai::add_archetype_spawn_function(#"ghost", &function_e7d2a256);
}

private function_e7d2a256(localclientnum) {
  self thread function_20705e4c(localclientnum);
}

private function_20705e4c(localclientnum) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"set_invisible", #"set_visible", #"hash_6ab654a4c018818c");

    switch (waitresult._notify) {
      case #"set_invisible":
        self fxclientutils::function_ae92446(localclientnum, self, self.fxdef);
        break;
      case #"set_visible":
      case #"hash_6ab654a4c018818c":
        self fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
        break;
    }
  }
}