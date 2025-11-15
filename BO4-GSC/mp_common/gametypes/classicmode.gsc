/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\classicmode.gsc
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
  setdvar(#"doublejump_enabled", 0);
  setdvar(#"wallrun_enabled", 0);
  setdvar(#"slide_maxtime", 550);
  setdvar(#"playerenergy_slideenergyenabled", 0);
  setdvar(#"trm_maxsidemantleheight", 0);
  setdvar(#"trm_maxbackmantleheight", 0);
  setdvar(#"player_swimming_enabled", 0);
  setdvar(#"player_swimheightratio", 0.9);
  setdvar(#"player_sprintspeedscale", 1.5);
  setdvar(#"jump_slowdownenable", 1);
  setdvar(#"sprint_allowrestore", 0);
  setdvar(#"sprint_allowreload", 0);
  setdvar(#"sprint_allowrechamber", 0);
  setdvar(#"cg_blur_time", 500);
  setdvar(#"tu11_enableclassicmode", 1);
}