/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scriptable.gsc
***********************************************/

scriptable_mpglobalcallback() {
  scripts\engine\scriptable::scriptable_setinitcallback(::scriptable_mpcallback);
}

scriptable_mpcallback() {
  scripts\mp\flags::levelflagset("_encstr_ABEC127358A564FBBB9F4A4CA5637F6A23D08A2B");
}