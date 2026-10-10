/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\scriptable.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace scriptable;

function scriptable_cpglobalcallback() {
  scripts\engine\scriptable::scriptable_setinitcallback(&scriptable_cpcallback);
}

function scriptable_cpcallback() {
  if(!flag_exist("scriptables_ready")) {
    flag_init("scriptables_ready");
  }

  flag_set("scriptables_ready");
}