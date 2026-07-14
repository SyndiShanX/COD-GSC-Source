/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\damage.gsc
**************************************/

#namespace damage;

function function_b96ee2a5cc5877b6(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage) {
  return scoredamage(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage);
}

function scoredamage(einflictor, eattacker, idamage, idflags, smeansofdeath, fdistance, objweapon, vpoint, vdir, shitloc, lightarmordamage, heavyarmordamage) {
  if(idamage >= 50) {
    return 2;
  } else if(idamage >= 16) {
    return 1;
  }

  return 0;
}