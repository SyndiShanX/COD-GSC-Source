/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6cb0280f7aa7d3cd.gsc
*************************************************/

#namespace namespace_33a47cc54fbe0ab9;

function function_d1e4826b0a4db6ee(einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_fcdf19e3cdd29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname) {
  if(!isDefined(level.var_808c7a20e8c01b63)) {
    level.var_808c7a20e8c01b63 = [];
  }

  foreach(callback in level.var_808c7a20e8c01b63) {
    [[callback]](einflictor, eattacker, victim, idamage, idflags, smeansofdeath, objweapon, var_fcdf19e3cdd29669, vpoint, vdir, shitloc, psoffsettime, modelindex, partname);
  }
}

function registerpostplayerdamagecallback(callback) {
  if(!isDefined(level.var_808c7a20e8c01b63)) {
    level.var_808c7a20e8c01b63 = [];
  }

  level.var_808c7a20e8c01b63[level.var_808c7a20e8c01b63.size] = callback;
}