/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\agents\agent_juggernaut.gsc
*****************************************************/

_id_A414FBF48AE645F4() {
  level._id_A4123E1A53DEA557 = getdvarint("dvar_86C85CFC843C0B68", 1);
  level._id_D49C99AD85354BD6 = getdvarint("dvar_A433661E4F79E427", 100);
}

_id_93288F91F5AABD02() {
  juggcontext = spawnStruct();
  juggcontext._id_46AD94F231CD4EF3 = [];
  juggcontext._id_46AD94F231CD4EF3["head_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["torso_upper_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["torso_lower_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["right_upper_arm_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["right_lower_arm_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["left_upper_arm_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["left_lower_arm_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["right_leg_health"] = 100;
  juggcontext._id_46AD94F231CD4EF3["left_leg_health"] = 100;
  juggcontext._id_5F03CAD2B199E1BC = ::_id_0F75BC5C067F4015;
  juggcontext.lastpaintime = 0;
  juggcontext.paindamage = 0;
  juggcontext._id_1BEA7C00EB868A40 = 1000;
  juggcontext._id_3D1BBEF280EA37B4 = 5000;
  juggcontext._id_A35692B629483499 = 10;
  juggcontext._id_F8236448EB258010 = 0.1;
  juggcontext.lastdamagedtime = 0;
  juggcontext._id_A4DCEEAB66EC6A3C = 1000;
  self.juggcontext = juggcontext;
}

_id_0F75BC5C067F4015(part, damage) {
  if(isDefined(part) && part == "head_health" && !isDefined(self.juggcontext._id_46AD94F231CD4EF3[part])) {
    if(isDefined(self.juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"])) {
      self.juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"] = self.juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"] - damage;

      if(self.juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"] <= 0) {
        self.juggcontext._id_46AD94F231CD4EF3["damaged_helmet_health"] = undefined;
        _id_FD38D13EC4CF6449("head_health", "destroyed");
      }
    }
  }
}

_id_FD38D13EC4CF6449(parts, state) {
  if(istrue(self._id_8081D864DC563057)) {
    return;
  }
  if(!isDefined(state)) {
    return;
  }
  _id_3D1C10F919CD5AF0 = [];

  if(isarray(parts))
    _id_3D1C10F919CD5AF0 = scripts\engine\utility::array_combine(_id_3D1C10F919CD5AF0, parts);
  else
    _id_3D1C10F919CD5AF0[_id_3D1C10F919CD5AF0.size] = parts;

  foreach(part in _id_3D1C10F919CD5AF0)
  self setscriptablepartstate(part, state, 0);
}

_id_1CBB19FC0CAEAB00(subtype) {
  weapon = undefined;
  _id_93288F91F5AABD02();
  thread _id_CA2D7204B750D78B();

  if(!isDefined(level._id_ED61C38F5C8BB414))
    level._id_ED61C38F5C8BB414 = ["pristine", "damaged"];

  if(!isDefined(level._id_13819795C6EE9FF8))
    level._id_13819795C6EE9FF8 = ["helmet", "neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "forearmpad_l", "forearmpad_r", "qamis", "thighpad_l", "thighpad_r"];

  if(isDefined(subtype) && subtype == "merc")
    _id_1D63AFDAD83BCDAD = ["neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "forearmpad_l", "forearmpad_r", "qamis", "thighpad_l", "thighpad_r"];
  else
    _id_1D63AFDAD83BCDAD = level._id_13819795C6EE9FF8;

  _id_FD38D13EC4CF6449(_id_1D63AFDAD83BCDAD, "pristine");
  self setperk("specialty_melee_invulnerable", 1);
}

_id_0507D39027ACAF53(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(isDefined(self._id_A4738C70736D3A61))
    [[self._id_A4738C70736D3A61]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
  else
    _id_1AB798A528080DB2(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_1AB798A528080DB2(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(isDefined(level._id_A4123E1A53DEA557) && level._id_A4123E1A53DEA557 == 1) {
    _id_80A8390CD1D9716F = idamage - level._id_D49C99AD85354BD6;

    if(_id_80A8390CD1D9716F > 0)
      idamage = level._id_D49C99AD85354BD6 + sqrt(_id_80A8390CD1D9716F);
  } else if(isDefined(level._id_D49C99AD85354BD6))
    idamage = min(idamage, level._id_D49C99AD85354BD6);

  if(getdvarint("dvar_2BE93DD484220A45", 0) == 1 && isPlayer(eattacker) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("jupiter_reveal", "onAgentBossDamage"))
    scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("jupiter_reveal", "onAgentBossDamage", eattacker, idamage);

  _id_CFABC0D1AB1AB2E9 = self.health - idamage;

  if(_id_CFABC0D1AB1AB2E9 <= 0) {
    if(isDefined(self._id_68C43B3FFEE58999))
      self notify(self._id_68C43B3FFEE58999);
  }

  if(isDefined(self.juggcontext)) {
    self.juggcontext.lastdamagedtime = gettime();

    if(self.juggcontext.lastpaintime < gettime()) {
      if(self.allowpain == 0)
        self.allowpain = 1;

      self.juggcontext.paindamage = self.juggcontext.paindamage + idamage;
    }

    if(self.juggcontext.paindamage > self.juggcontext._id_1BEA7C00EB868A40) {
      self.juggcontext.lastpaintime = gettime() + self.juggcontext._id_3D1BBEF280EA37B4;
      self.juggcontext.paindamage = 0;
      self asmevalpaintransition(self.asmname);
      self.allowpain = 0;
    }

    _id_FA4F1A412AB12028(idamage, shitloc, smeansofdeath, eattacker);
  }

  _id_24FBEDBA9A7A1EF4::_id_DFFAC413ED66BCD0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

_id_CA2D7204B750D78B() {
  self endon("death");

  for(;;) {
    if(gettime() - self.juggcontext.lastdamagedtime > self.juggcontext._id_A4DCEEAB66EC6A3C)
      self.juggcontext.paindamage = max(self.juggcontext.paindamage - self.juggcontext._id_A35692B629483499, 0);

    wait(self.juggcontext._id_F8236448EB258010);
  }
}

_id_FA4F1A412AB12028(damage, shitloc, smeansofdeath, attacker) {
  _id_1F48003B8E69560C = _id_C0AA811F7B45687C(shitloc, smeansofdeath, attacker);

  if(!isDefined(_id_1F48003B8E69560C)) {
    if(isDefined(attacker) && isDefined(shitloc) && isPlayer(attacker)) {}

    return;
  }

  _id_94B7ECF1273BA3C0(_id_1F48003B8E69560C, damage);
}

_id_C0AA811F7B45687C(shitloc, smeansofdeath, attacker) {
  _id_1F48003B8E69560C = undefined;

  if(scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "head_health";
  else if(scripts\cp_mp\utility\damage_utility::istorsouppershot(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "torso_upper_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_77ED09D75C0C7165(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "torso_lower_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_24278EB0EC1E2953(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "right_upper_arm_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_BF1EFC7185168448(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "right_lower_arm_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_82850161196DF912(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "left_upper_arm_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_D7395809E0049A49(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "left_lower_arm_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_C0BD16DEEB47765B(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "right_leg_health";
  else if(scripts\cp_mp\utility\damage_utility::_id_F15A47528FFFCE28(shitloc, smeansofdeath, attacker))
    _id_1F48003B8E69560C = "left_leg_health";

  return _id_1F48003B8E69560C;
}

_id_94B7ECF1273BA3C0(part, damage) {
  if(isDefined(self.juggcontext._id_5F03CAD2B199E1BC))
    self[[self.juggcontext._id_5F03CAD2B199E1BC]](part, damage);

  if(isDefined(self.juggcontext._id_46AD94F231CD4EF3[part])) {
    if(part == "head_health") {
      if(isDefined(self.helmethealth))
        self.juggcontext._id_46AD94F231CD4EF3[part] = self.helmethealth / self._id_CFC69E5588A5BED6 * 10;
      else
        self.juggcontext._id_46AD94F231CD4EF3[part] = self.juggcontext._id_46AD94F231CD4EF3[part] - damage;

      if(self.juggcontext._id_46AD94F231CD4EF3[part] <= 0) {
        self.juggcontext._id_46AD94F231CD4EF3[part] = undefined;

        if(issubstr(self.agent_type, "merc"))
          _id_24FBEDBA9A7A1EF4::_id_59EA6B2F800CB082(self);
        else
          _id_FD38D13EC4CF6449(part, "destroyed");
      } else if(self.juggcontext._id_46AD94F231CD4EF3[part] <= 50) {
        if(issubstr(self.agent_type, "merc")) {
          return;
        }
        _id_FD38D13EC4CF6449(part, "damaged");
        return;
      }
    } else {
      self.juggcontext._id_46AD94F231CD4EF3[part] = self.juggcontext._id_46AD94F231CD4EF3[part] - damage;

      if(self.juggcontext._id_46AD94F231CD4EF3[part] <= 0) {
        self.juggcontext._id_46AD94F231CD4EF3[part] = undefined;

        if(issubstr(self.agent_type, "merc")) {
          return;
        }
        _id_FD38D13EC4CF6449(part, "damaged");
        return;
      }
    }
  }
}