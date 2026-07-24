/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2625.gsc
**************************************/

_id_EF33(var_0) {
  level._id_EF2E = var_0;
}

_id_028A() {
  if(isDefined(level._id_EF2E)) {
    [[level._id_EF2E]]();
  }

  if(scripts\engine\utility::issp()) {
    if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
      scripts\engine\utility::flag_init("scriptables_ready");
    }

    scripts\engine\utility::flag_set("scriptables_ready");
  }
}