/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_49e18fd5437112e.gsc
***********************************************/

#using script_c8d806d2487b617;
#using scripts\core_common\radiation;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#namespace namespace_2b1568cc;

function private autoexec __init__system__() {
  system::register(#"hash_380b7703a79220e8", &preinit, undefined, undefined, #"radiation");
}

function private preinit() {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  function_d90ea0e7();
}

function function_d90ea0e7() {}

function private function_41d40455() {
  self val::set(#"hash_668c27c4f08f8d26", "allow_ads", 0);
}

function private function_c11b3d17() {
  self val::set(#"hash_668c27c4f08f8d26", "allow_ads", 1);
}

function private function_b3c2eb77() {
  self val::set(#"hash_668c27c4f08f8d26", "health_regen", 0);
}

function private function_b375f04e() {
  self val::set(#"hash_668c27c4f08f8d26", "health_regen", 1);
}

function private function_3df85b7() {
  self val::set(#"hash_668c27c4f08f8d26", "allow_melee", 0);
}

function private function_3213dd79() {
  self val::set(#"hash_668c27c4f08f8d26", "allow_melee", 1);
}

function private function_e1e646f0() {
  self val::set(#"hash_668c27c4f08f8d26", "allow_sprint", 0);
}

function private function_a6beb2ea() {
  self val::set(#"hash_668c27c4f08f8d26", "allow_sprint", 1);
}