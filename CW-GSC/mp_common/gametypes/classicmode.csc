/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\classicmode.csc
***********************************************/

#using scripts\core_common\system_shared;
#namespace classicmode;

function private autoexec __init__system__() {
  system::register(#"classicmode", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.classicmode = getgametypesetting(#"classicmode");

  if(level.classicmode) {
    enableclassicmode();
  }
}

function enableclassicmode() {
  setDvar(#"playerenergy_slideenergyenabled", 0);
  setDvar(#"trm_maxsidemantleheight", 0);
  setDvar(#"trm_maxbackmantleheight", 0);
  setDvar(#"player_swimming_enabled", 0);
  setDvar(#"player_swimheightratio", 0.9);
  setDvar(#"jump_slowdownenable", 1);
  setDvar(#"sprint_allowrestore", 0);
  setDvar(#"sprint_allowrechamber", 0);
  setDvar(#"cg_blur_time", 500);
  setDvar(#"tu11_enableclassicmode", 1);
}