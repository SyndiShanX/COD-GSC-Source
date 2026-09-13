/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\frontend.gsc
***********************************************/

main() {
  level.callbackstartgametype = ::callback_frontendstartgametype;
  level.callbackplayerconnect = ::callback_frontendplayeractive;
  level.callbackplayerconnect = ::callback_frontendplayerconnect;
  level.callbackplayerdisconnect = ::callback_frontendplayerdisconnect;
  level.callbackplayerdamage = ::callback_frontendplayerdamage;
  level.callbackplayerimpaled = ::callback_frontendplayerimpaled;
  level.callbackplayerkilled = ::callback_frontendplayerkilled;
  level.callbackplayerlaststand = ::callback_frontendplayerlaststand;
  level.callbackplayermigrated = ::callback_frontendplayermigrated;
  level.callbackhostmigration = ::callback_frontendhostmigration;
  level._id_42D9B617BBCA6A42 = ::_id_BFB9C6B70FC8F235;
  level._id_935C97AA3757676F = ::_id_8901CA5831CE6438;
  level._id_CDA3AF1F73639C7C = ::_id_2A643088582C8BE3;
}

callback_frontendstartgametype() {}

callback_frontendplayeractive() {}

callback_frontendplayerconnect() {}

callback_frontendplayerdisconnect(_id_401C3A2E68AAB0FD) {}

callback_frontendplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {}

callback_frontendplayerimpaled(eattacker, objweapon, _id_F98A651C69C13CBA, vpoint, vdir, shitloc, _id_920FF4456CE9A2FC, _id_19F6F25777706F34) {}

callback_frontendplayerkilled(einflictor, attacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration) {}

callback_frontendplayerlaststand(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_318ADE4970C8F647) {}

callback_frontendplayermigrated() {}

callback_frontendhostmigration() {}

_id_BFB9C6B70FC8F235() {}

_id_8901CA5831CE6438(_id_401C3A2E68AAB0FD) {}

_id_2A643088582C8BE3(_id_4B86A4E17C656399, progress, _id_0ABC57BB73D4BF1A) {}