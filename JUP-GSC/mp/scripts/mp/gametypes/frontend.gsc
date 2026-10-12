/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\frontend.gsc
***********************************************/

#namespace frontend;

function main() {
  level.callbackstartgametype = &callback_frontendstartgametype;
  level.callbackplayerconnect = &callback_frontendplayeractive;
  level.callbackplayerconnect = &callback_frontendplayerconnect;
  level.callbackplayerdisconnect = &callback_frontendplayerdisconnect;
  level.callbackplayerdamage = &callback_frontendplayerdamage;
  level.callbackplayerimpaled = &callback_frontendplayerimpaled;
  level.var_189d24c2bbeed3f5 = &callback_frontendplayerlaunched;
  level.callbackplayerkilled = &callback_frontendplayerkilled;
  level.callbackplayerlaststand = &callback_frontendplayerlaststand;
  level.callbackplayermigrated = &callback_frontendplayermigrated;
  level.callbackhostmigration = &callback_frontendhostmigration;
  level.var_42d9b617bbca6a42 = &function_bfb9c6b70fc8f235;
  level.var_935c97aa3757676f = &function_8901ca5831ce6438;
  level.var_cda3af1f73639c7c = &function_2a643088582c8be3;
}

function callback_frontendstartgametype() {}

function callback_frontendplayeractive() {}

function callback_frontendplayerconnect() {}

function callback_frontendplayerdisconnect(reason) {}

function callback_frontendplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname, var_b0fc59ff15058522, var_be4285b26ed99ab1) {}

function callback_frontendplayerimpaled(eattacker, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_19f6f25777706f34, var_d3564b2364cb59e6, var_a4d8eb0a63f60f6b) {}

function callback_frontendplayerlaunched(eattacker, objweapon, vdir, magnitude, shitloc) {}

function callback_frontendplayerkilled(einflictor, attacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {}

function callback_frontendplayerlaststand(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, var_318ade4970c8f647) {}

function callback_frontendplayermigrated() {
  assertmsg("<dev string:x1c>");
}

function callback_frontendhostmigration() {
  assertmsg("<dev string:x1c>");
}

function function_bfb9c6b70fc8f235() {}

function function_8901ca5831ce6438(reason) {}

function function_2a643088582c8be3(achievementid, progressdata) {}