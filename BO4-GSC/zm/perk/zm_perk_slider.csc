/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_slider.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_slider;

autoexec __init__system__() {
  system::register(#"zm_perk_slider", &__init__, undefined, undefined);
}

__init__() {
  enable_slider_perk_for_level();
  level._effect[#"hash_7b8ad0ed3ef67813"] = "zombie/fx8_perk_phd_exp";
  zm_perks::function_f3c80d73("zombie_perk_bottle_slider", "zombie_perk_totem_slider");
}

enable_slider_perk_for_level() {
  zm_perks::register_perk_clientfields(#"specialty_phdflopper", &function_4bb29d61, &function_90b5e96c);
  zm_perks::register_perk_effects(#"specialty_phdflopper", "divetonuke_light");
  zm_perks::register_perk_init_thread(#"specialty_phdflopper", &init_slider);
  zm_perks::function_b60f4a9f(#"specialty_phdflopper", #"p8_zm_vapor_altar_icon_01_phdslider", "zombie/fx8_perk_altar_symbol_ambient_slider", #"zmperksphdslider");
}

init_slider() {}

function_4bb29d61() {
  clientfield::register("allplayers", "" + #"hash_7b8ad0ed3ef67813", 1, 1, "counter", &function_4feff2f7, 0, 0);
}

function_90b5e96c() {}

function_4feff2f7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_7b8ad0ed3ef67813"], self, "j_spine");
    self playSound(localclientnum, #"hash_25343ce78e1c9c6c");
  }
}