/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_4da75c87643c8b07.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace namespace_3d0f1be7;

autoexec __init__system__() {
  system::register(#"hash_411c8f5d7f8749b9", &__init__, undefined, undefined);
}

__init__() {}

event_handler[event_9673dc9a] function_3981d015(eventstruct) {
  if(eventstruct.ent.targetname === "blast_door") {
    if(eventstruct.state == 0) {
      eventstruct.ent thread function_feb37b9f("red");
      return;
    }

    eventstruct.ent thread function_feb37b9f("green");
  }
}

function_feb37b9f(color) {
  var_807d6589 = struct::get_array("blast_door_light", "targetname");

  foreach(s_light in var_807d6589) {
    light_pos = s_light.origin;

    if(isDefined(s_light.var_cb9d8af)) {
      stopfx(0, s_light.var_cb9d8af);
      s_light.var_cb9d8af = undefined;
    }

    s_light.var_cb9d8af = playFX(0, #"hash_787d9cfa8f97976a" + color, light_pos);
  }
}