/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mystery.csc
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
  zm_perks::register_perk_clientfields(#"specialty_mystery", &function_12161a30, &function_b10a7225);
  zm_perks::function_b60f4a9f(#"specialty_mystery", #"p8_zm_vapor_altar_icon_01_secretsauce", "zombie/fx8_perk_altar_symbol_ambient_secret_sauce", #"zmperkssecretsauce");
}

function_12161a30() {}

function_b10a7225() {}