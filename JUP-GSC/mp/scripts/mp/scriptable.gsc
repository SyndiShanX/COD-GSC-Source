/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\scriptable.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace scriptable;

function scriptable_mpglobalcallback() {
  scripts\engine\scriptable::scriptable_setinitcallback(&scriptable_mpcallback);
}

function scriptable_mpcallback() {
  scripts\mp\flags::levelflagset("scriptables_ready");

  if(!flag_exist("scriptables_ready")) {
    flag_init("scriptables_ready");
  }

  flag_set("scriptables_ready");
}