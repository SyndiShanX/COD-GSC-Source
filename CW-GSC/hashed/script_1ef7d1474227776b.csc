/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1ef7d1474227776b.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\system_shared;
#namespace namespace_8c89a9e9;

function init() {
  ai::add_archetype_spawn_function(#"ghost", &function_e7d2a256);
}

function private function_e7d2a256(localclientnum) {
  self thread function_20705e4c(localclientnum);
}

function private function_20705e4c(localclientnum) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"set_invisible", #"set_visible", #"hash_6ab654a4c018818c");

    switch (waitresult._notify) {
      case # "set_invisible":
        self fxclientutils::function_ae92446(localclientnum, self, self.fxdef);
        break;
      case # "set_visible":
      case # "hash_6ab654a4c018818c":
        self fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
        break;
    }
  }
}