/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\classicmode.csc
***********************************************/

#include scripts\core_common\system_shared;
#namespace classicmode;

autoexec __init__system__() {
  system::register(#"classicmode", &__init__, undefined, undefined);
}

__init__() {
  level.classicmode = getgametypesetting(#"classicmode");

  if(level.classicmode) {
    enableclassicmode();
  }
}

enableclassicmode() {
  setDvar(#"doublejump_enabled", 0);
  setDvar(#"wallrun_enabled", 0);
  setDvar(#"slide_maxtime", 550);
  setDvar(#"playerenergy_slideenergyenabled", 0);
  setDvar(#"trm_maxsidemantleheight", 0);
  setDvar(#"trm_maxbackmantleheight", 0);
  setDvar(#"player_swimming_enabled", 0);
  setDvar(#"player_swimheightratio", 0.9);
  setDvar(#"player_sprintspeedscale", 1.5);
  setDvar(#"jump_slowdownenable", 1);
  setDvar(#"sprint_allowrestore", 0);
  setDvar(#"sprint_allowreload", 0);
  setDvar(#"sprint_allowrechamber", 0);
  setDvar(#"cg_blur_time", 500);
  setDvar(#"tu11_enableclassicmode", 1);
}