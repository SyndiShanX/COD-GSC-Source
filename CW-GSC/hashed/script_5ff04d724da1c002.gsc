/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5ff04d724da1c002.gsc
***********************************************/

#using script_355c6e84a79530cb;
#using scripts\core_common\content_manager;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_7a9f67c8;

function private autoexec __init__system__() {
  system::register(#"hash_3617acb8b856566f", &preinit, undefined, undefined, #"content_manager");
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  content_manager::register_script(#"upgrade_machines", &function_f14de68);
}

function private function_f14de68(instance) {
  instance endon(#"cleanup");
  namespace_73df937d::function_ae44cb3d(instance, #"perk_machine_choice");
  namespace_73df937d::function_ae44cb3d(instance, #"armor_machine");
  namespace_73df937d::function_ae44cb3d(instance, #"weapon_machine");
  namespace_73df937d::function_ae44cb3d(instance, #"crafting_table");
}