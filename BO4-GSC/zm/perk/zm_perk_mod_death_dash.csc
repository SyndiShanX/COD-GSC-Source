/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_death_dash.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_mod_death_dash;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_death_dash", &__init__, undefined, undefined);
}

__init__() {
  function_27473e44();
}

function_27473e44() {
  zm_perks::register_perk_clientfields(#"specialty_mod_death_dash", &client_field_func, &code_callback_func);
  zm_perks::register_perk_init_thread(#"specialty_mod_death_dash", &init);
  zm_perks::function_b60f4a9f(#"specialty_mod_death_dash", #"p8_zm_vapor_altar_icon_01_blaze_phase", "zombie/fx8_perk_altar_symbol_ambient_blaze_phase", #"zmperksdeathdash");
}

init() {}

client_field_func() {
  clientfield::register("allplayers", "death_dash_pulse", 24000, 1, "counter", &play_death_dash_pulse, 0, 0);
}

code_callback_func() {}

play_death_dash_pulse(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, "zombie/fx8_perk_blaze_phase_flame_pulse", self, "j_spine4");
  self playSound(localclientnum, #"hash_531770ad2c5bf052");
}