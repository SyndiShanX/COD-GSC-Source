/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\frontend.gsc
***********************************************/

function main() {
  level.callbackstartgametype = &callback_frontendstartgametype;
  level.callbackplayerconnect = &friendlyicon;
  level.callbackplayerconnect = &callback_frontendplayerconnect;
  level.callbackplayerdisconnect = &callback_frontendplayerdisconnect;
  level.callbackplayerdamage = &callback_frontendplayerdamage;
  level.callbackplayerimpaled = &callback_frontendplayerimpaled;
  level.callbackplayerkilled = &callback_frontendplayerkilled;
  level.callbackplayerlaststand = &callback_frontendplayerlaststand;
  level.callbackplayermigrated = &callback_frontendplayermigrated;
  level.callbackhostmigration = &callback_frontendhostmigration;
}

function callback_frontendstartgametype() {}

function friendlyicon() {}

function callback_frontendplayerconnect() {}

function callback_frontendplayerdisconnect(var0) {}

function callback_frontendplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {}

function callback_frontendplayerimpaled(var0, var1, var2, var3, var4, var5, var6, var7) {}

function callback_frontendplayerkilled(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {}

function callback_frontendplayerlaststand(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {}

function callback_frontendplayermigrated() {}

function callback_frontendhostmigration() {}