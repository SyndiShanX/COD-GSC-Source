/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\flags.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\engine\flags;
#using scripts\engine\utility;
#namespace flags;

function init_sp_flags() {
  if(!isDefined(level.flag)) {
    scripts\engine\flags::init_flags();
  }

  flags = ["missionfailed", "load_finished", "scriptables_ready"];

  foreach(flag in flags) {
    if(!flag_exist(flag)) {
      flag_init(flag);
    }
  }
}