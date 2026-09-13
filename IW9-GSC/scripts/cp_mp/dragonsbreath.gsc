/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\dragonsbreath.gsc
***********************************************/

_id_DF4E9A1E313EA352() {
  dragonsbreathdamage = spawnStruct();
  dragonsbreathdamage.newhitlocs = [];
  dragonsbreathdamage.hitslocs = [];
  dragonsbreathdamage.burningstate = "neutral";
  return dragonsbreathdamage;
}

_id_6DC8C5DE229E86FF(newhitlocs, attacker, objweapon) {
  foreach(part in newhitlocs) {
    if(isshield(part))
      newhitlocs = scripts\engine\utility::array_remove(newhitlocs, part);
  }

  if(newhitlocs.size == 0) {
    return;
  }
  thread _id_A0888E06AA555932(newhitlocs, attacker, objweapon);
}

_id_56A694363DA738AC() {
  _id_3741EA5B9FB53EC3 = self getcorpseentity();

  if(!isDefined(_id_3741EA5B9FB53EC3)) {
    return;
  }
  _id_3741EA5B9FB53EC3 setscriptablepartstate("burning", "flareUp", 0);
}

_id_9FD9DC9D9D3A0BC4() {
  self notify("stop_dragonsbreathDamage");
  self.dragonsbreathdamage = _id_DF4E9A1E313EA352();
}

_id_A0888E06AA555932(_id_4763836BFD4D9D8A, attacker, objweapon) {
  self notify("newBurningParts");
  self endon("disconnect");
  self endon("newBurningParts");
  self endon("stop_dragonsbreathDamage");
  _id_4763836BFD4D9D8A = scripts\engine\utility::array_remove_duplicates(_id_4763836BFD4D9D8A);

  foreach(part in _id_4763836BFD4D9D8A) {
    if(isDefined(self.dragonsbreathdamage.hitslocs[part])) {
      self.dragonsbreathdamage.hitslocs[part] = self.dragonsbreathdamage.hitslocs[part] + 0.5;
      self.dragonsbreathdamage.hitslocs[part] = min(self.dragonsbreathdamage.hitslocs[part], 4.0);
      continue;
    }

    self.dragonsbreathdamage.hitslocs[part] = 0.5;
  }

  _id_F21BFCF42E2F3E8B();

  for(;;) {
    wait 0.25;

    if(!scripts\cp_mp\utility\player_utility::isreallyalive(self) || self.dragonsbreathdamage.hitslocs.size == 0) {
      break;
    }

    _id_B400931C07D29AD6 = 0;
    _id_8B5AE6AB700339F8(attacker, objweapon);

    foreach(key, _id_FABE55B122C8DF13 in self.dragonsbreathdamage.hitslocs) {
      self.dragonsbreathdamage.hitslocs[key] = self.dragonsbreathdamage.hitslocs[key] - 0.25;

      if(self.dragonsbreathdamage.hitslocs[key] <= 0) {
        self.dragonsbreathdamage.hitslocs = scripts\engine\utility::array_remove_key(self.dragonsbreathdamage.hitslocs, key);
        _id_B400931C07D29AD6 = 1;
      }
    }

    if(_id_B400931C07D29AD6)
      _id_F21BFCF42E2F3E8B();
  }
}

_id_8B5AE6AB700339F8(attacker, objweapon) {
  if(isDefined(attacker)) {
    _id_9BECAEEDB8C6BF2C = makeweapon("dragonsbreath_mp");
    attacker scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_9BECAEEDB8C6BF2C, objweapon);
    _id_3315791B141386C1 = 5.0;
    _id_8848A3CE32577E8A = min(self.dragonsbreathdamage.hitslocs.size, 3);
    _id_76E563DB5D11A0EA = int(_id_3315791B141386C1 * _id_8848A3CE32577E8A);

    if(_id_76E563DB5D11A0EA > 0)
      self dodamage(_id_76E563DB5D11A0EA, attacker.origin, attacker, attacker, "MOD_FIRE", _id_9BECAEEDB8C6BF2C, "torso_upper");
  }
}

_id_F21BFCF42E2F3E8B() {
  burningstate = "";
  points = [];
  points["al_"] = 0;
  points["to_"] = 0;
  points["ar_"] = 0;
  points["ll_"] = 0;
  points["lr"] = 0;

  if(!isDefined(self.dragonsbreathdamage)) {
    return;
  }
  _id_A68E09AA749D3C69 = self.dragonsbreathdamage.hitslocs;

  if(isDefined(self._id_7E2ABE421347DD30)) {
    foreach(_id_419E24DBC44963ED in self._id_7E2ABE421347DD30) {
      if(!isDefined(_id_A68E09AA749D3C69[_id_419E24DBC44963ED.hitloc])) {
        _id_A68E09AA749D3C69[_id_419E24DBC44963ED.hitloc] = 1;
        continue;
      }

      _id_A68E09AA749D3C69[_id_419E24DBC44963ED.hitloc] = _id_A68E09AA749D3C69[_id_419E24DBC44963ED.hitloc] + 1;
    }
  }

  if(isDefined(self.dragonsbreathdamage._id_07B9FEFFAAFCE932)) {
    foreach(_id_6193680DB4166136 in self.dragonsbreathdamage._id_07B9FEFFAAFCE932) {
      if(!isDefined(_id_A68E09AA749D3C69[_id_6193680DB4166136])) {
        _id_A68E09AA749D3C69[_id_6193680DB4166136] = 2;
        continue;
      }

      _id_A68E09AA749D3C69[_id_6193680DB4166136] = _id_A68E09AA749D3C69[_id_6193680DB4166136] + 1;
    }
  }

  foreach(_id_6BC1CACFCA73BCC3, _id_1FD61B140D0A59F1 in _id_A68E09AA749D3C69) {
    _id_B8C1BD5E260F7F81 = _id_3D9255AF28A82F08(_id_6BC1CACFCA73BCC3);

    if(isDefined(_id_B8C1BD5E260F7F81))
      points[_id_B8C1BD5E260F7F81] = points[_id_B8C1BD5E260F7F81] + _id_1FD61B140D0A59F1;
  }

  if(points["al_"] > 0 || points["to_"] >= 2)
    burningstate = burningstate + "al_";

  if(points["to_"] > 0 || points["al_"] >= 2 || points["ar_"] >= 2)
    burningstate = burningstate + "to_";

  if(points["ar_"] > 0 || points["to_"] >= 2)
    burningstate = burningstate + "ar_";

  if(points["ll_"] > 0 || points["lr"] >= 2)
    burningstate = burningstate + "ll_";

  if(points["lr"] > 0 || points["ll_"] >= 2)
    burningstate = burningstate + "lr";

  if(burningstate == "al_to_ar_ll_" || burningstate == "al_to_ar_lr" || burningstate == "al_to_ll_lr" || burningstate == "al_ar_ll_lr" || burningstate == "to_ar_ll_lr" || burningstate == "al_to_ar_ll_lr")
    burningstate = "all_parts";
  else if(burningstate == "")
    burningstate = "neutral";

  if(burningstate != self.dragonsbreathdamage.burningstate) {
    if(burningstate == "neutral")
      scripts\mp\weapons::disableburnfx(1, self.dragonsbreathdamage.burningstate);
    else
      scripts\mp\weapons::enableburnfx(1, burningstate);

    self.dragonsbreathdamage.burningstate = burningstate;
  }
}

_id_3D9255AF28A82F08(hitloc) {
  switch (hitloc) {
    case "helmet":
      return "to_";
    case "head":
      return "to_";
    case "neck":
      return "to_";
    case "torso_upper":
      return "to_";
    case "torso_lower":
      return "to_";
    case "right_arm_upper":
      return "ar_";
    case "left_arm_upper":
      return "al_";
    case "right_arm_lower":
      return "ar_";
    case "left_arm_lower":
      return "al_";
    case "right_hand":
      return "ar_";
    case "left_hand":
      return "al_";
    case "right_leg_upper":
      return "lr";
    case "left_leg_upper":
      return "ll_";
    case "right_leg_lower":
      return "lr";
    case "left_leg_lower":
      return "ll_";
    case "right_foot":
      return "lr";
    case "left_foot":
      return "ll_";
  }
}

isdragonsbreathweapon(objweapon) {
  if(istrue(objweapon.isalternate)) {
    if(_func_F30A6D3194F97C09(objweapon, "specialty_incendiary_alt"))
      return 1;
  } else if(_func_F30A6D3194F97C09(objweapon, "specialty_incendiary"))
    return 1;

  return 0;
}

_id_0CFD2E1E48EDAF93(objweapon) {
  if(!istrue(objweapon.isalternate)) {
    if(objweapon.basename == "dragonsbreath_mp")
      return 1;
  }

  return 0;
}

isshield(hitloc) {
  if(hitloc == "shield")
    return 1;
  else
    return 0;
}

_id_0C206C109A26F598(idamage, attacker, objweapon, hitloc) {
  if(!isDefined(self._id_7E2ABE421347DD30))
    self._id_7E2ABE421347DD30 = [];

  if(!isDefined(self.dragonsbreathdamage))
    self.dragonsbreathdamage = _id_DF4E9A1E313EA352();

  _id_F5C8FEF008FFF1DD = idamage * getdvarfloat("dvar_BA97C3BE3B58A828", 0.2);
  _id_F25B10D0D2D8664C = getdvarint("dvar_632C2D7B6B4C3771", 2);
  _id_C42F14360A123E9D = getdvarfloat("dvar_A55CC107911A0CE0", 0.75);
  _id_60D435C6357875EA = _id_C42F14360A123E9D / _id_F25B10D0D2D8664C;
  _id_419E24DBC44963ED = spawnStruct();
  _id_419E24DBC44963ED._id_F25B10D0D2D8664C = _id_F25B10D0D2D8664C;
  _id_419E24DBC44963ED._id_76E563DB5D11A0EA = _func_C5CF558181E12D1F(_id_F5C8FEF008FFF1DD / _id_419E24DBC44963ED._id_F25B10D0D2D8664C);
  _id_419E24DBC44963ED.attacker = attacker;
  _id_419E24DBC44963ED.objweapon = objweapon;
  _id_419E24DBC44963ED.hitloc = hitloc;
  self._id_7E2ABE421347DD30[self._id_7E2ABE421347DD30.size] = _id_419E24DBC44963ED;
  thread _id_1A50056B16521C9E(attacker, _id_60D435C6357875EA);
}

_id_1A50056B16521C9E(attacker, _id_60D435C6357875EA) {
  self notify("db_damage");
  self endon("db_damage");
  self endon("death_or_disconnect");
  self._id_35116E057346139E = 1;
  _id_F21BFCF42E2F3E8B();
  _id_9BECAEEDB8C6BF2C = makeweapon("dragonsbreath_mp");
  _id_56EBC7F3844CB706 = getdvarfloat("dvar_DE9E421A9BB5C99A", 0.3);
  wait(_id_56EBC7F3844CB706);

  while(isDefined(self._id_7E2ABE421347DD30) && self._id_7E2ABE421347DD30.size > 0) {
    _id_5AE1CEEB2401DBD5 = self._id_7E2ABE421347DD30[0];

    while(_id_5AE1CEEB2401DBD5._id_F25B10D0D2D8664C > 0 && isDefined(_id_5AE1CEEB2401DBD5.attacker)) {
      wait(_id_60D435C6357875EA);
      damage = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_7E2ABE421347DD30.size; _id_AC0E594AC96AA3A8++) {
        attacker = self._id_7E2ABE421347DD30[_id_AC0E594AC96AA3A8].attacker;
        objweapon = self._id_7E2ABE421347DD30[_id_AC0E594AC96AA3A8].objweapon;
        hitloc = self._id_7E2ABE421347DD30[_id_AC0E594AC96AA3A8].hitloc;

        if(isDefined(attacker)) {
          attacker scripts\cp_mp\utility\weapon_utility::_id_49967318FBD12317(_id_9BECAEEDB8C6BF2C, objweapon);
          damage = self._id_7E2ABE421347DD30[_id_AC0E594AC96AA3A8]._id_76E563DB5D11A0EA;
          self dodamage(damage, attacker.origin, attacker, attacker, "MOD_FIRE", _id_9BECAEEDB8C6BF2C, "torso_lower");
          self._id_7E2ABE421347DD30[_id_AC0E594AC96AA3A8]._id_F25B10D0D2D8664C--;
        }
      }
    }

    self._id_7E2ABE421347DD30 = scripts\engine\utility::array_remove(self._id_7E2ABE421347DD30, _id_5AE1CEEB2401DBD5);
    _id_F21BFCF42E2F3E8B();
    waitframe();
  }

  _id_D36940AA00B20558();
  _id_F21BFCF42E2F3E8B();
}

_id_22D1FCED237D6878() {
  self notify("db_damage");
  _id_D36940AA00B20558();
}

_id_D36940AA00B20558() {
  self._id_7E2ABE421347DD30 = undefined;
  self._id_35116E057346139E = undefined;
}

_id_5A05899BB304A6D4(hitloc, _id_3F160C063BBC3525) {
  if(!isPlayer(self)) {
    return;
  }
  _id_A234A65C378F3289 = "crossbowBurning" + hitloc;
  self notify(_id_A234A65C378F3289);
  self endon(_id_A234A65C378F3289);
  self endon("death_or_disconnect");
  self endon("stop_dragonsbreathDamage");

  if(!isDefined(self.dragonsbreathdamage))
    self.dragonsbreathdamage = _id_DF4E9A1E313EA352();

  if(!isDefined(self.dragonsbreathdamage._id_07B9FEFFAAFCE932))
    self.dragonsbreathdamage._id_07B9FEFFAAFCE932 = [];

  self.dragonsbreathdamage._id_07B9FEFFAAFCE932 = scripts\engine\utility::array_add(self.dragonsbreathdamage._id_07B9FEFFAAFCE932, hitloc);
  _id_F21BFCF42E2F3E8B();
  wait(_id_3F160C063BBC3525);

  if(isDefined(self) && isDefined(self.dragonsbreathdamage) && isDefined(self.dragonsbreathdamage._id_07B9FEFFAAFCE932))
    self.dragonsbreathdamage._id_07B9FEFFAAFCE932 = scripts\engine\utility::array_remove(self.dragonsbreathdamage._id_07B9FEFFAAFCE932, hitloc);

  _id_F21BFCF42E2F3E8B();
}