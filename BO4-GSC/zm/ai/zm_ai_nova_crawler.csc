/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_nova_crawler.csc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;

#namespace zm_ai_nova_crawler;

autoexec __init__system__() {
  system::register(#"zm_ai_nova_crawler", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("actor", "nova_crawler_burst_clientfield", 1, 1, "int", &function_d8505ab6, 0, 0);
  clientfield::register("toplayer", "nova_crawler_burst_postfx_clientfield", 1, 1, "int", &function_c81db9a1, 0, 0);
  clientfield::register("toplayer", "nova_crawler_gas_cloud_postfx_clientfield", 1, 1, "int", &function_f8947dfe, 0, 0);
  ai::add_archetype_spawn_function(#"nova_crawler", &function_1d34f2b6);
}

private function_1d34f2b6(localclientnum) {
  if(!isDefined(self._effect)) {
    self._effect = [];
    self._effect[#"hash_219e13e8868d7af4"] = "zm_ai/fx8_nova_crawler_gas_release";
  }
}

function_d8505ab6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1 && isDefined(self._effect) && isDefined(self._effect[#"hash_219e13e8868d7af4"])) {
    playFX(localclientnum, self._effect[#"hash_219e13e8868d7af4"], self.origin);
  }
}

function_c81db9a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle(#"hash_2083fc2cc0fee308");
    return;
  }

  self postfx::exitpostfxbundle(#"hash_2083fc2cc0fee308");
}

function_f8947dfe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self thread function_4b3c6d28();
    return;
  }

  self postfx::exitpostfxbundle(#"hash_78fa24e9920e1e07");
}

private function_4b3c6d28() {
  self notify("4d967cb582990a00");
  self endon("4d967cb582990a00");
  level endon(#"game_ended");
  self endoncallback(&function_fa939efb, #"death");
  self thread postfx::playpostfxbundle(#"hash_78fa24e9920e1e07");

  while(isalive(self)) {
    waitframe(1);
  }
}

function_fa939efb(str_notify) {
  if(isDefined(self)) {
    self thread postfx::exitpostfxbundle(#"hash_78fa24e9920e1e07");
  }
}