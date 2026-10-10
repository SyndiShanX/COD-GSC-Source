/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_dog_electric.csc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#namespace zm_ai_dog_electric;

autoexec __init__system__() {
  system::register(#"zm_ai_dog_electric", &__init__, undefined, #"zombie_dog_util");
}

__init__() {
  level thread function_b2801783();
}

function_b2801783() {
  level._effect[#"hash_33fd6545401e3622"] = #"zm_ai/fx8_dog_elec_belly_glow";
  level._effect[#"hash_55d6ab2c7eecbad4"] = #"zm_ai/fx8_dog_elec_eye_glow";
  level._effect[#"dog_head_glow"] = #"zm_ai/fx8_dog_elec_head_glow";
  level._effect[#"hash_5e4d4083a69396b8"] = #"zm_ai/fx8_dog_elec_tail_glow";
  level._effect[#"dog_torso_glow"] = #"zm_ai/fx8_dog_elec_torso_glow";
  level._effect[#"dog_gib"] = #"zm_ai/fx8_dog_elec_death_exp";
  level.var_17c4823f = #"hash_6a3a7714a2c454fb";
}