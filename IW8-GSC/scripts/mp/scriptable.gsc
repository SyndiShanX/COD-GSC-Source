/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\scriptable.gsc
***********************************************/

function scriptable_mpglobalcallback() {
  scripts\engine\scriptable::scriptable_setinitcallback(&scriptable_mpcallback);
}

function scriptable_mpcallback() {
  scripts\mp\flags::levelflagset("scriptables_ready");
}