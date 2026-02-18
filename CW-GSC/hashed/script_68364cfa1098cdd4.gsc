/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_68364cfa1098cdd4.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace namespace_e85e312c;
class class_6e09f777 {
  var var_5ee36218;

  function function_860ebd20(var_8f7a5c75) {
    var_5ee36218 = var_8f7a5c75;
    var_5ee36218 flag::wait_till("vehicle_spawn_setup_complete");
  }
}

function private autoexec __init__system__() {
  system::register(#"hash_4bbb330ecd0b67a8", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  vehicle::add_spawn_function_group("turret_dead_system", "script_turret_type", &function_33dd3fda);
}

function private postinit() {}

function function_33dd3fda() {
  var_e85e312c = new class_6e09f777();
  [[var_e85e312c]] - > function_860ebd20(self);
}