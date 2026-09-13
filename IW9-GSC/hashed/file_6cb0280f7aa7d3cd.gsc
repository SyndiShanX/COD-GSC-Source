/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6cb0280f7aa7d3cd.gsc
***********************************************/

_id_D1E4826B0A4DB6EE(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, _id_FCDF19E3CDD29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  if(!isDefined(level._id_808C7A20E8C01B63))
    level._id_808C7A20E8C01B63 = [];

  foreach(callback in level._id_808C7A20E8C01B63)[[callback]](einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, _id_FCDF19E3CDD29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
}

_id_95C943D6949814D1(callback) {
  if(!isDefined(level._id_808C7A20E8C01B63))
    level._id_808C7A20E8C01B63 = [];

  level._id_808C7A20E8C01B63[level._id_808C7A20E8C01B63.size] = callback;
}