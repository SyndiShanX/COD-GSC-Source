/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mystery.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mystery;

autoexec __init__system__() {
  system::register(#"zm_perk_mystery", &__init__, undefined, undefined);
}

__init__() {
  function_27473e44();
}

function_27473e44() {
  if(function_8b1a219a()) {
    zm_perks::register_perk_basic_info(#"specialty_mystery", #"perk_mystery", 1500, #"hash_7db4db936bc2abe6", getweapon("zombie_perk_bottle_mystery"), getweapon("zombie_perk_vapor_juggernaut"), #"zmperkssecretsauce");
  } else {
    zm_perks::register_perk_basic_info(#"specialty_mystery", #"perk_mystery", 1500, #"zombie/perk_mystery", getweapon("zombie_perk_bottle_mystery"), getweapon("zombie_perk_vapor_juggernaut"), #"zmperkssecretsauce");
  }

  zm_perks::register_perk_mod_basic_info(#"hash_23c63c9a3acb397", "perk_mod_mystery", #"perk_mystery", #"specialty_mystery", 2500);
}