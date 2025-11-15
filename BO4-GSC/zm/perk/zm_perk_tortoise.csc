/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_tortoise.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_tortoise;

autoexec __init__system__() {
  system::register(#"zm_perk_tortoise", &__init__, undefined, undefined);
}

__init__() {
  enable_tortoise_perk_for_level();
  level._effect[#"perk_tortoise_explosion"] = "zombie/fx8_perk_vic_tort_exp";
  zm_perks::function_f3c80d73("zombie_perk_bottle_tortoise", "zombie_perk_totem_tortoise");
}

enable_tortoise_perk_for_level() {
  zm_perks::register_perk_clientfields(#"specialty_shield", &function_6dd9c0ca, &function_cdbbd4f1);
  zm_perks::register_perk_effects(#"specialty_shield", "divetonuke_light");
  zm_perks::register_perk_init_thread(#"specialty_shield", &function_3cc019d7);
  zm_perks::function_b60f4a9f(#"specialty_shield", #"p8_zm_vapor_altar_icon_01_victorioustortoise", "zombie/fx8_perk_altar_symbol_ambient_victorious_tortoise", #"zmperksvictorious");
}

function_3cc019d7() {}

function_6dd9c0ca() {
  clientfield::register("allplayers", "perk_tortoise_explosion", 1, 1, "counter", &function_f92dce50, 0, 0);
}

function_cdbbd4f1() {}

function_f92dce50(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    util::playFXOnTag(localclientnum, level._effect[#"perk_tortoise_explosion"], self, " j_spine");
  }
}