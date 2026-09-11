/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\scriptable.gsc
***********************************************/

function scriptable_initialize() {
  scripts\engine\scriptable::scriptable_engineinitialize();
}

function scriptable_post_initialize() {
  scripts\engine\scriptable::scriptable_enginepostinitialize();
}

function scriptable_used(var0, var1, var2, var3, var4, var5) {
  scripts\engine\scriptable::scriptable_engineused(var0, var1, var2, var3, var4, var5);
}

function riotshield_damaged(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  scripts\engine\scriptable::ref_12f69(var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12);
}

function scriptable_touched(var0, var1, var2, var3) {
  scripts\engine\scriptable::scriptable_enginetouched(var0, var1, var2, var3);
}

function scriptable_notify_callback(var0, var1, var2) {
  scripts\engine\scriptable::scriptable_enginenotifycallback(var0, var1, var2);
}