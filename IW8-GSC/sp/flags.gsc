/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\flags.gsc
***********************************************/

init_sp_flags() {
  if(!isDefined(level.flag))
    scripts\engine\flags::init_flags();

  var_0 = ["missionfailed", "load_finished", "scriptables_ready"];

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::flag_exist(var_2))
      scripts\engine\utility::flag_init(var_2);
  }
}