/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_lights.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_orange_lights;

autoexec __init__system__() {
  system::register(#"zm_orange_lights", &__init__, &__main__, undefined);
}

__init__() {
  init_clientfields();
  level thread function_3d4e24ea();
  level.var_13a6af33 = &function_35b30784;
}

__main__() {
  level thread ship_lights_control();
  level thread lighthouse_lights_control();
  level thread facility_lights_control();
  level thread infusion_lights_hot();
  level thread infusion_lights_cold();
}

init_clientfields() {
  clientfield::register("world", "ship_lights_control", 24000, 1, "int");
  clientfield::register("world", "lighthouse_lights_control", 24000, 1, "int");
  clientfield::register("world", "facility_lights_control", 24000, 1, "int");
  clientfield::register("world", "infusion_lights_hot", 24000, 1, "int");
  clientfield::register("world", "infusion_lights_cold", 24000, 1, "int");
  clientfield::register("world", "orange_deactivate_radiant_exploders_client", 24000, 1, "counter");
}

function_3d4e24ea() {
  level._effect[#"hash_723a7c4a495d1008"] = #"hash_17207501ee73a374";
}

ship_lights_control() {
  level waittill(#"power_on2");
  level clientfield::set("ship_lights_control", 1);
}

lighthouse_lights_control() {
  level waittill(#"power_on1");
  level clientfield::set("lighthouse_lights_control", 1);
}

facility_lights_control() {
  level waittill(#"power_on3");
  level clientfield::set("facility_lights_control", 1);
}

infusion_lights_hot() {
  level flag::wait_till(#"hash_57d2cbf7d6c2035a");
  level clientfield::set("infusion_lights_hot", 1);
  level flag::wait_till_clear(#"hash_57d2cbf7d6c2035a");
  level clientfield::set("infusion_lights_hot", 0);
}

infusion_lights_cold() {
  level flag::wait_till(#"hash_238e5c8b416f855");
  level clientfield::set("infusion_lights_cold", 1);
  level flag::wait_till_clear(#"hash_238e5c8b416f855");
  level clientfield::set("infusion_lights_cold", 0);
}

function_e9f6e0f7() {
  e_sam = getent("sam", "targetname");
  s_lgt_spawner = struct::get("s_lgt_spawner", "targetname");
  e_sam.tag = util::spawn_model("tag_origin", s_lgt_spawner.origin);
  e_sam.tag.angles = s_lgt_spawner.angles;
  level.registerglass_railing_kickedleader = level._effect[#"hash_723a7c4a495d1008"];
  e_sam.var_82acd734 = playFXOnTag(level.registerglass_railing_kickedleader, e_sam.tag, "tag_origin");
  e_sam.var_82acd734 linkto(e_sam);
}

private function_35b30784(string) {
  if(!isDefined(level.var_7b4e19aa)) {
    level.var_7b4e19aa = [];
  }

  array::add(level.var_7b4e19aa, string, 0);
}

function_b1c6d4f2() {
  if(isDefined(level.var_7b4e19aa)) {
    foreach(exploder_id in level.var_7b4e19aa) {
      exploder::kill_exploder(exploder_id);
      wait 0.3;
    }

    level.var_7b4e19aa = undefined;
  }

  level clientfield::increment("orange_deactivate_radiant_exploders_client", 1);
}