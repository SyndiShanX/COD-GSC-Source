/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\flags.gsc
***********************************************/

function init_sp_flags() {
  if(!isDefined(level.flag)) {
    scripts\engine\flags::init_flags();
  }

  var0 = ["missionfailed", "load_finished", "scriptables_ready"];

  foreach(var2 in var0) {
    if(!scripts\engine\utility::flag_exist(var2)) {
      scripts\engine\utility::flag_init(var2);
    }
  }
}