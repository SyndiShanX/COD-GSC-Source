/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2625.gsc
***************************************/

func_EF33(var_00) {
  level.func_EF2E = var_00;
}

func_028A() {
  if(isDefined(level.func_EF2E)) {
    [[level.func_EF2E]]();
  }

  if(scripts\engine\utility::issp()) {
    if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
      scripts\engine\utility::flag_init("scriptables_ready");
    }

    scripts\engine\utility::flag_set("scriptables_ready");
  }
}