/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_45d238a595862e40.gsc
***********************************************/

_id_2FCE2F81588A2462() {
  if(!isDefined(level._id_BF8AA3F39F981625))
    level._id_BF8AA3F39F981625 = [];

  level._id_BF8AA3F39F981625[level._id_BF8AA3F39F981625.size] = ::_id_56BC2530B5374D3E;
}

_id_56BC2530B5374D3E() {
  self.damage_functions[self.damage_functions.size] = ::_id_4142A252055B545A;
}

_id_4142A252055B545A(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon) {
  if(!isalive(self)) {
    return;
  }
  if(juggernaut_isspecialweapon()) {
    return;
  }
  if(self.damageweapon.basename == "iw8_pi_decho") {
    if(partname == "j_head" || partname == "j_neck" || partname == "j_helmet")
      _id_56F249FD2BF57724 = 70;
    else
      _id_56F249FD2BF57724 = 40;
  } else
    _id_56F249FD2BF57724 = 40;

  if(damage < _id_56F249FD2BF57724)
    _id_56F249FD2BF57724 = max(0, damage - 5);

  self.health = self.health + int(_id_56F249FD2BF57724);
}

juggernaut_isspecialweapon() {
  return self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_EXPLOSIVE" || self.damagemod == "MOD_GRENADE_SPLASH" || self.damagemod == "MOD_PROJECTILE_SPLASH" || (self.damageweapon.classname == "sniper" || self.damageweapon.classname == "pistol" && self.damageweapon.basename != "iw8_pi_decho" && self.damagemod != "MOD_MELEE");
}