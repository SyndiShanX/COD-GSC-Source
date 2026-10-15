/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_bandolier.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_bandolier;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_bandolier", &__init__, undefined, undefined);
}

__init__() {
  function_27473e44();
}

function_27473e44() {
  zm_perks::register_perk_clientfields(#"specialty_mod_extraammo", &function_12161a30, &function_b10a7225);
  zm_perks::register_perk_effects(#"specialty_mod_extraammo", "sleight_light");
  zm_perks::register_perk_init_thread(#"specialty_mod_extraammo", &init_perk);
}

init_perk() {
  if(isDefined(level.enable_magic) && level.enable_magic) {}
}

function_12161a30() {}

function_b10a7225() {}