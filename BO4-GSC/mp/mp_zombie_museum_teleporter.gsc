/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\mp_zombie_museum_teleporter.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace mp_zombie_museum_teleporter;

autoexec __init__system__() {
  system::register(#"mp_zombie_museum_teleporter", &__main__, undefined, undefined);
}

__main__() {
  if(getdvarint(#"hash_6360671422e5591a", 1)) {
    level thread teleporters_init();
  }
}

teleporters_init() {
  var_92b18f69 = getEntArray("teleporter", "targetname");
  var_6d7fa02e = struct::get_array("teleporter");

  foreach(trigger in var_92b18f69) {
    trigger.destinations = var_6d7fa02e;
    trigger.triggers = getEntArray("teleporter", "targetname");
    trigger callback::on_trigger(&function_18d7622a);
  }

  level flag::wait_till("first_player_spawned");
  exploder::exploder("fxexp_teleporter_a_light_ready");
  exploder::exploder("fxexp_teleporter_b_light_ready");
}

function_18d7622a(info) {
  player = info.activator;

  if(isalive(player) && !(isDefined(self.var_2c3d4111) && self.var_2c3d4111)) {
    foreach(trig in self.triggers) {
      trig.var_2c3d4111 = 1;
    }

    destinations = arraysort(self.destinations, self.origin, 0, 1);
    destination = destinations[0];
    tell = "fxexp_teleporter_a_tell";
    inuse = "fxexp_teleporter_b_inuse";

    if(destination.var_362fcf1d === "b") {
      tell = "fxexp_teleporter_b_tell";
      inuse = "fxexp_teleporter_a_inuse";
    }

    exploder::exploder(inuse);
    exploder::exploder(tell);
    exploder::stop_exploder("fxexp_teleporter_a_light_ready");
    exploder::exploder("fxexp_teleporter_a_light_active");
    exploder::stop_exploder("fxexp_teleporter_b_light_ready");
    exploder::exploder("fxexp_teleporter_b_light_active");
    level util::delay(2, undefined, &exploder::stop_exploder, tell);
    level util::delay(2, undefined, &exploder::stop_exploder, "fxexp_teleporter_a_light_active");
    level util::delay(2.5, undefined, &exploder::exploder, "fxexp_teleporter_a_light_cooldwn");
    level util::delay(2, undefined, &exploder::stop_exploder, "fxexp_teleporter_b_light_active");
    level util::delay(2.5, undefined, &exploder::exploder, "fxexp_teleporter_b_light_cooldwn");
    player setorigin(groundtrace(destination.origin, destination.origin + (0, 0, -16), 0, player)[#"position"]);
    player setplayerangles(destination.angles);
    wait 10;

    if(isDefined(self)) {
      foreach(trig in self.triggers) {
        trig.var_2c3d4111 = 0;
      }
    }

    exploder::exploder("fxexp_teleporter_a_light_ready");
    exploder::stop_exploder("fxexp_teleporter_a_light_cooldwn");
    exploder::exploder("fxexp_teleporter_b_light_ready");
    exploder::stop_exploder("fxexp_teleporter_b_light_cooldwn");
  }
}