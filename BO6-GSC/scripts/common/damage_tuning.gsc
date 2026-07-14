/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\damage_tuning.gsc
********************************************/

#namespace damage_tuning;

function init() {
  level.var_deb9d2b3de25799b = isDefined(level.gametypebundle) && level.gametypebundle.var_82bc75c9ed13b34d;

  if(getdvarint(@ "hash_e600610a3da3e873", 0) > 0) {
    level.var_deb9d2b3de25799b = 0;
  }

  if(level.var_deb9d2b3de25799b && !function_c28ff33f9f675615()) {
    function_79901b4637c83c86(#"damage tuning");
    level.var_deb9d2b3de25799b = 0;
    return;
  }
}

function function_c851d31a9ad2e67(bundle) {
  if(isarray(bundle.var_20cb8f4e47f3353e.damagemultipliers) && bundle.var_20cb8f4e47f3353e.damagemultipliers.size == 0) {
    bundle.var_20cb8f4e47f3353e.damagemultipliers = undefined;
  }

  if(isarray(bundle.var_20cb8f4e47f3353e.var_468292eb981ddd5e) && bundle.var_20cb8f4e47f3353e.var_468292eb981ddd5e.size == 0) {
    bundle.var_20cb8f4e47f3353e.var_468292eb981ddd5e = undefined;
  }

  if(isarray(bundle.var_20cb8f4e47f3353e.var_16354dd59a9c5500) && bundle.var_20cb8f4e47f3353e.var_16354dd59a9c5500.size == 0) {
    bundle.var_20cb8f4e47f3353e.var_16354dd59a9c5500 = undefined;
  }

  if(!isDefined(bundle.var_20cb8f4e47f3353e.damagemultipliers) && !isDefined(bundle.var_20cb8f4e47f3353e.var_468292eb981ddd5e) && !isDefined(bundle.var_20cb8f4e47f3353e.var_16354dd59a9c5500)) {
    bundle.var_20cb8f4e47f3353e = undefined;
  }
}

function function_8118e38bf1ed06de(damagedata, var_20cb8f4e47f3353e) {
  if(!level.var_deb9d2b3de25799b) {
    return 0;
  }

  var_468292eb981ddd5e = var_20cb8f4e47f3353e.var_468292eb981ddd5e;

  if(!isDefined(var_468292eb981ddd5e)) {
    return 0;
  }

  meansofdeath = damagedata.meansofdeath;

  if(isstring(meansofdeath)) {
    meansofdeath = getxhash(meansofdeath);
  }

  thisweaponclass = weaponclass(damagedata.objweapon);

  if(isstring(thisweaponclass)) {
    thisweaponclass = getxhash(thisweaponclass);
  }

  if(!isDefined(thisweaponclass)) {
    thisweaponclass = #"unspecified_weapon_class";
  }

  if(!isDefined(meansofdeath)) {
    meansofdeath = #"unspecified_mod";
  }

  var_f79fbe845fe4b22e = damagedata.objweapon.damagemodcategory ?? #"";

  foreach(var_bc51cf55c449daf4 in var_468292eb981ddd5e) {
    if(var_bc51cf55c449daf4.weaponclass && var_bc51cf55c449daf4.weaponclass != thisweaponclass) {
      continue;
    }

    if(var_bc51cf55c449daf4.meansofdeath && var_bc51cf55c449daf4.meansofdeath != meansofdeath) {
      continue;
    }

    if(var_bc51cf55c449daf4.damagemodcategory && var_bc51cf55c449daf4.damagemodcategory != var_f79fbe845fe4b22e) {
      continue;
    }

    return var_bc51cf55c449daf4.var_468292eb981ddd5e;
  }

  return 0;
}

function getmodifieddamageusingdamagetuning(attacker, objweapon, mod, damageamount, maxhealth, var_20cb8f4e47f3353e, data) {
  inflictor = data.inflictor;
  iskillstreak = data.iskillstreak || data.biskillstreak;
  hitstokill = var_20cb8f4e47f3353e.var_16354dd59a9c5500;

  if(hitstokill) {
    if(!isDefined(maxhealth)) {
      assertmsg("<dev string:x24>");
    }
  }

  if(isDefined(hitstokill) && isDefined(maxhealth)) {
    if(isstring(mod)) {
      mod = getxhash(mod);
    }

    thisweaponclass = weaponclass(objweapon);

    if(isstring(thisweaponclass)) {
      thisweaponclass = getxhash(thisweaponclass);
    }

    if(!isDefined(thisweaponclass)) {
      thisweaponclass = #"unspecified_weapon_class";
    }

    if(!isDefined(mod)) {
      mod = #"unspecified_mod";
    }

    var_f79fbe845fe4b22e = objweapon.damagemodcategory ?? #"";

    foreach(var_6b65935644fbd600 in hitstokill) {
      if(var_6b65935644fbd600.weaponclass && var_6b65935644fbd600.weaponclass != thisweaponclass) {
        continue;
      }

      if(var_6b65935644fbd600.meansofdeath && var_6b65935644fbd600.meansofdeath != mod) {
        continue;
      }

      if(var_6b65935644fbd600.damagemodcategory && var_6b65935644fbd600.damagemodcategory != var_f79fbe845fe4b22e) {
        continue;
      }

      hitstokillamount = var_6b65935644fbd600.hitstokill;

      if(hitstokillamount <= 0) {
        assertmsg("<dev string:x6e>" + hitstokillamount + "<dev string:x7e>");
        continue;
      }

      var_7ee550b53f0a7079 = 1;

      if(iskillstreak && inflictor.var_7ee550b53f0a7079) {
        var_7ee550b53f0a7079 = inflictor.var_7ee550b53f0a7079;
      }

      return int(ceil(float(maxhealth) / hitstokillamount * var_7ee550b53f0a7079));
    }
  }

  multipliers = var_20cb8f4e47f3353e.damagemultipliers;

  if(isDefined(multipliers)) {
    if(isstring(mod)) {
      mod = getxhash(mod);
    }

    if(!isDefined(thisweaponclass)) {
      thisweaponclass = weaponclass(objweapon);
    }

    if(isstring(thisweaponclass)) {
      thisweaponclass = getxhash(thisweaponclass);
    }

    if(!isDefined(thisweaponclass)) {
      thisweaponclass = #"unspecified_weapon_class";
    }

    if(!isDefined(mod)) {
      mod = #"unspecified_mod";
    }

    if(!isDefined(var_f79fbe845fe4b22e)) {
      var_f79fbe845fe4b22e = objweapon.damagemodcategory ?? #"";
    }

    foreach(currentmultiplier in multipliers) {
      if(currentmultiplier.weaponclass && currentmultiplier.weaponclass != thisweaponclass) {
        continue;
      }

      if(currentmultiplier.meansofdeath && currentmultiplier.meansofdeath != mod) {
        continue;
      }

      if(currentmultiplier.damagemodcategory && currentmultiplier.damagemodcategory != var_f79fbe845fe4b22e) {
        continue;
      }

      return int(ceil(currentmultiplier.multiplier * damageamount));
    }
  }

  return int(damageamount);
}

function setupdamagetuning(var_20cb8f4e47f3353e, maxhealth) {
  if(!level.var_deb9d2b3de25799b) {
    return;
  }

  self.var_20cb8f4e47f3353e = var_20cb8f4e47f3353e;
  self.maxhealth = maxhealth;
}