/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\scriptable.gsc
***********************************************/

scriptable_cpglobalcallback() {
  scripts\engine\scriptable::scriptable_setinitcallback(::scriptable_cpcallback);
}

scriptable_cpcallback() {
  if(!scripts\engine\utility::flag_exist("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B"))
    scripts\engine\utility::flag_init("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");

  scripts\engine\utility::flag_set("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
}