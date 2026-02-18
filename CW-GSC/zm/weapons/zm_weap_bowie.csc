/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_bowie.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_maptable;
#namespace zm_weap_bowie;

function private autoexec __init__system__() {
  system::register(#"bowie_knife", &preinit, &postinit, undefined, undefined);
}

function private preinit() {}

function private postinit() {
  level.var_8e4168e9 = "bowie_knife";
  level.var_63af3e00 = "bowie_flourish";
  var_57858dd5 = "zombie_fists_bowie";

  if(zm_maptable::get_story() == 1) {
    level.var_8e4168e9 = "bowie_knife_story_1";
    level.var_63af3e00 = "bowie_flourish_story_1";
    var_57858dd5 = "zombie_fists_bowie_story_1";
  }

  level.w_bowie_knife = getweapon(hash(level.var_8e4168e9));
}