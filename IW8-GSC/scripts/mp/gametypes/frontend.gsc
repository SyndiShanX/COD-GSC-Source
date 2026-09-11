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

function callback_frontendplayerdisconnect(var_0) {}

function callback_frontendplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {}

function callback_frontendplayerimpaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {}

function callback_frontendplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

function callback_frontendplayerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

function callback_frontendplayermigrated() {}

function callback_frontendhostmigration() {}