/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_idle_phone.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  maps\_props::add_cellphone_notetracks("generic");
  level.scr_anim["generic"]["phone_idle"][0] = % patrol_bored_idle_cellphone;
  level.scr_anim["generic"]["phone_react"] = % patrol_bored_react_look_retreat;
}