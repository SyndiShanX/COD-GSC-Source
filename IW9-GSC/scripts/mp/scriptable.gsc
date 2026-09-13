/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\scriptable.gsc
***********************************************/

scriptable_mpglobalcallback() {
  scripts\engine\scriptable::scriptable_setinitcallback(::scriptable_mpcallback);
}

scriptable_mpcallback() {
  scripts\mp\flags::levelflagset("scriptables_ready");

  if(!scripts\engine\utility::flag_exist("scriptables_ready"))
    scripts\engine\utility::flag_init("scriptables_ready");

  scripts\engine\utility::flag_set("scriptables_ready");
}