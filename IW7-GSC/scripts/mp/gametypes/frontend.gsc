/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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

callback_frontendplayerdisconnect(param_00) {}

callback_frontendplayerdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {}

callback_frontendplayerimpaled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {}

callback_frontendplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {}

callback_frontendplayerlaststand(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {}

callback_frontendplayermigrated() {}

callback_frontendhostmigration() {}