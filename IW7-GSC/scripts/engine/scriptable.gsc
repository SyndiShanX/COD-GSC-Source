/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\engine\scriptable.gsc
*********************************************/

func_EF33(var_0) {
  level.var_EF2E = var_0;
}

func_028A() {
  if(isDefined(level.var_EF2E)) {
    [[level.var_EF2E]]();
  }

  if(scripts\engine\utility::issp()) {
    if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
      scripts\engine\utility::flag_init("scriptables_ready");
    }

    scripts\engine\utility::flag_set("scriptables_ready");
  }
}