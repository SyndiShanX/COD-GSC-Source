/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\frontend.gsc
*********************************************/

#namespace frontend;

function main() {
  level.callbackstartgametype = &callback_frontendstartgametype;
  level.callbackplayerconnect = &callback_frontendplayeractive;
  level.callbackplayerconnect = &callback_frontendplayerconnect;
  level.callbackplayerdisconnect = &callback_frontendplayerdisconnect;
  level.callbackplayerdamage = &callback_frontendplayerdamage;
  level.callbackplayerimpaled = &callback_frontendplayerimpaled;
  level.var_8f62eac141f8bdb6 = &callback_frontendplayerlaunched;
  level.callbackplayerkilled = &callback_frontendplayerkilled;
  level.callbackplayerlaststand = &callback_frontendplayerlaststand;
  level.callbackplayermigrated = &callback_frontendplayermigrated;
  level.callbackhostmigration = &callback_frontendhostmigration;
  level.var_4524771918fe585f = &callback_frontendplayerconnectrejoin;
  level.var_880cfcfec57ca836 = &function_58b6508d68b59f3f;
  level.var_16eab40d8f2ae445 = &function_b69d00f730747014;
}

function callback_frontendstartgametype() {}

function callback_frontendplayeractive() {}

function callback_frontendplayerconnect() {}

function callback_frontendplayerdisconnect(reason) {}

function callback_frontendplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_2300d396e46c0fe7, var_cdd29ad5d1362c2) {}

function callback_frontendplayerimpaled(eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_56243ba4fafee4a5, var_ea333e2537a8fa73, var_2e6727b4a3db5100) {}

function callback_frontendplayerlaunched(eattacker, objweapon, vdir, magnitude, shitloc) {}

function callback_frontendplayerkilled(einflictor, attacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {}

function callback_frontendplayerlaststand(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, var_61e4f4a3c7e15e02) {}

function callback_frontendplayermigrated() {
  assertmsg("<dev string:x24>");
}

function callback_frontendhostmigration() {
  assertmsg("<dev string:x24>");
}

function callback_frontendplayerconnectrejoin() {}

function function_58b6508d68b59f3f(reason) {}

function function_b69d00f730747014(achievementid, progressdata) {}