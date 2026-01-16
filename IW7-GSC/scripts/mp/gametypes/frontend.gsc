/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\frontend.gsc
*********************************************/

main() {
  level.callbackstartgametype = ::callback_frontendstartgametype;
  level.callbackplayerconnect = ::callback_frontendplayerconnect;
  level.callbackplayerdisconnect = ::callback_frontendplayerdisconnect;
  level.callbackplayerdamage = ::callback_frontendplayerdamage;
  level.callbackplayerimpaled = ::callback_frontendplayerimpaled;
  level.callbackplayerkilled = ::callback_frontendplayerkilled;
  level.callbackplayerlaststand = ::callback_frontendplayerlaststand;
  level.callbackplayermigrated = ::callback_frontendplayermigrated;
  level.callbackhostmigration = ::callback_frontendhostmigration;
}

callback_frontendstartgametype() {}

callback_frontendplayerconnect() {}

callback_frontendplayerdisconnect(var_0) {}

callback_frontendplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {}

callback_frontendplayerimpaled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {}

callback_frontendplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

callback_frontendplayerlaststand(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

callback_frontendplayermigrated() {}

callback_frontendhostmigration() {}