/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\toy_sp_panel_box.gsc
*****************************************************/

main() {
  common_scripts\_destructible::destructible_create("toy_sp_panel_box", "tag_origin", 15, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_splash_damage_scaler(15);
  common_scripts\_destructible::destructible_fx("tag_fx", "fx/props/electricbox4_explode", undefined, undefined, undefined, 1);
  common_scripts\_destructible::destructible_sound("exp_fusebox_sparks");
  common_scripts\_destructible::destructible_explode(5, 2000, 132, 32, 1, 1, undefined, 0);
  common_scripts\_destructible::destructible_state(undefined, "me_electricbox4_dest", undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_part("tag_fx", "me_electricbox4_door", undefined, undefined, undefined, undefined, 1.0, 1.0);
}