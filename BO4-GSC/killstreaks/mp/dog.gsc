/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\dog.gsc
***********************************************/

#include scripts\abilities\ability_power;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\killstreaks\dog_shared;
#include scripts\killstreaks\killstreaks_shared;

#namespace dog;

autoexec __init__system__() {
  system::register(#"killstreak_dog", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
  bundle = struct::get_script_bundle("killstreak", #"killstreak_dog");

  if(isDefined(bundle)) {
    bundle.var_32f64ba3 = "actor_spawner_boct_mp_dog";
  }

  killstreaks::register_bundle(bundle, &spawned);
  killstreaks::allow_assists(bundle.kstype, 1);
  level.var_e2174183 = getweapon(#"ability_dog");
  level.var_da7fa0b = getweapon(#"dog_ai_defaultmelee");
  ability_power::function_9d78823f(level.var_e2174183, level.var_da7fa0b);
}