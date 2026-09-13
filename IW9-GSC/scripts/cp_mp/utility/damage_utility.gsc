/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\damage_utility.gsc
****************************************************/

adddamagemodifier(id, modifier, _id_B3D6E2C2DB2FB4A9, _id_9E3A69E8E82478BD) {
  if(!isDefined(_id_B3D6E2C2DB2FB4A9))
    _id_B3D6E2C2DB2FB4A9 = 1;

  if(_id_B3D6E2C2DB2FB4A9) {
    if(!isDefined(self.additivedamagemodifiers))
      self.additivedamagemodifiers = [];

    self.additivedamagemodifiers[id] = modifier;

    if(isDefined(_id_9E3A69E8E82478BD)) {
      if(!isDefined(self.additivedamagemodifierignorefuncs))
        self.additivedamagemodifierignorefuncs = [];

      self.additivedamagemodifierignorefuncs[id] = _id_9E3A69E8E82478BD;
    }
  } else {
    if(!isDefined(self.multiplicativedamagemodifiers))
      self.multiplicativedamagemodifiers = [];

    self.multiplicativedamagemodifiers[id] = modifier;

    if(isDefined(_id_9E3A69E8E82478BD)) {
      if(!isDefined(self.multiplicativedamagemodifierignorefuncs))
        self.multiplicativedamagemodifierignorefuncs = [];

      self.multiplicativedamagemodifierignorefuncs[id] = _id_9E3A69E8E82478BD;
    }
  }
}

removedamagemodifier(id, _id_B3D6E2C2DB2FB4A9) {
  if(!isDefined(_id_B3D6E2C2DB2FB4A9))
    _id_B3D6E2C2DB2FB4A9 = 1;

  if(_id_B3D6E2C2DB2FB4A9) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }
    self.additivedamagemodifiers[id] = undefined;

    if(!isDefined(self.additivedamagemodifierignorefuncs)) {
      return;
    }
    self.additivedamagemodifierignorefuncs[id] = undefined;
  } else {
    if(!isDefined(self.multiplicativedamagemodifiers)) {
      return;
    }
    self.multiplicativedamagemodifiers[id] = undefined;

    if(!isDefined(self.multiplicativedamagemodifierignorefuncs)) {
      return;
    }
    self.multiplicativedamagemodifierignorefuncs[id] = undefined;
  }
}

getdamagemodifiertotal(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  _id_C8E219B403B2E789 = 1.0;

  if(isDefined(self.additivedamagemodifiers)) {
    foreach(index, modifier in self.additivedamagemodifiers) {
      _id_8411C7D6AC406B06 = 0;

      if(isDefined(self.additivedamagemodifierignorefuncs) && isDefined(self.additivedamagemodifierignorefuncs[index]))
        _id_8411C7D6AC406B06 = [[self.additivedamagemodifierignorefuncs[index]]](inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc);

      if(!_id_8411C7D6AC406B06)
        _id_C8E219B403B2E789 = _id_C8E219B403B2E789 + (modifier - 1.0);
    }
  }

  _id_1CBF01D0DF82CDE7 = 1.0;

  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(index, modifier in self.multiplicativedamagemodifiers) {
      _id_8411C7D6AC406B06 = 0;

      if(isDefined(self.multiplicativedamagemodifierignorefuncs) && isDefined(self.multiplicativedamagemodifierignorefuncs[index]))
        _id_8411C7D6AC406B06 = [[self.multiplicativedamagemodifierignorefuncs[index]]](inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc);

      if(!_id_8411C7D6AC406B06)
        _id_1CBF01D0DF82CDE7 = _id_1CBF01D0DF82CDE7 * modifier;
    }
  }

  return _id_C8E219B403B2E789 * _id_1CBF01D0DF82CDE7;
}

cleardamagemodifiers() {
  self.additivedamagemodifiers = [];
  self.multiplicativedamagemodifiers = [];
  self.additivedamagemodifierignorefuncs = [];
  self.multiplicativedamagemodifierignorefuncs = [];
}

packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, _id_799F234362ADB813, partname, tagname, idflags, eventid, hitloc) {
  struct = spawnStruct();
  struct.attacker = attacker;
  struct.victim = victim;
  struct.damage = damage;
  struct.objweapon = objweapon;
  struct.meansofdeath = meansofdeath;
  struct.inflictor = inflictor;
  struct.point = point;
  struct.direction_vec = direction_vec;
  struct.modelname = modelname;
  struct._id_799F234362ADB813 = _id_799F234362ADB813;
  struct.partname = partname;
  struct.tagname = tagname;
  struct.idflags = idflags;
  struct.damageflags = idflags;
  struct.eventid = eventid;
  struct.hitloc = hitloc;

  if(isDefined(struct.attacker))
    struct.attacker.assistedsuicide = 0;

  return struct;
}

isstuckdamage(data, _id_9B97F4BA6BDC58BE) {
  if(istrue(self.forcestuckdamage))
    return 1;

  if(isDefined(self.stuckbygrenade)) {
    if(isDefined(data.inflictor) && data.inflictor == self.stuckbygrenade) {
      if(istrue(_id_9B97F4BA6BDC58BE))
        return 1;
      else if(isexplosivedamagemod(data.meansofdeath) || data.meansofdeath == "MOD_FIRE")
        return 1;
    }
  }

  return 0;
}

iscrossbowdamage(objweapon) {
  return objweapon.basename == "iw9_dm_crossbow_mp";
}

_id_0006065FCE6CDCAD(objweapon) {
  return objweapon.basename == "iw9_dm_crossbow_mp" && objweapon hasattachment("ammo_bolt_he");
}

_id_D49206E61AC4F6DE(objweapon) {
  return objweapon.basename == "iw9_dm_crossbow_mp" && objweapon hasattachment("ammo_bolt_db");
}

isstuckdamagekill(data) {
  if(istrue(self.nostuckdamagekill))
    return 0;

  if(!isstuckdamage(data, 0))
    return 0;

  switch (data.objweapon.basename) {
    case "thermite_mp":
    case "thermite_ap_mp":
    case "bunkerbuster_burrowed_mp":
    case "bunkerbuster_mp":
    case "thermite_av_mp":
    case "molotov_mp":
      return 0;
    default:
      break;
  }

  return 1;
}

forcestuckdamage() {
  self.forcestuckdamage = 1;
}

forcestuckdamageclear() {
  self.forcestuckdamage = undefined;
}

isheadshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "head" || shitloc == "helmet";
}

_id_B656251147D7D40B(partname) {
  if(!isDefined(partname))
    return 0;

  return partname == "j_head" || partname == "j_helmet" || partname == "j_neck" || partname == "tag_eye";
}

validshotcheck(smeansofdeath, attacker) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner)) {
      switch (attacker.code_classname) {
        case "misc_turret":
        case "script_model":
        case "script_vehicle":
          return 0;
      }
    }
  }

  switch (smeansofdeath) {
    case "MOD_CRUSH":
    case "MOD_MELEE":
    case "MOD_IMPACT":
    case "MOD_FIRE":
    case "MOD_EXPLOSIVE":
      return 0;
  }

  return 1;
}

_id_0ABFCDEE8FDA20A4() {
  if(!isDefined(level._id_D43E78E513933216))
    level._id_D43E78E513933216 = [];

  _id_8BBA4C474CB4043A("j_head");
  _id_8BBA4C474CB4043A("j_helmet");
  _id_8BBA4C474CB4043A("j_neck");
  _id_8BBA4C474CB4043A("tag_eye");
  _id_8BBA4C474CB4043A("j_chest");
  _id_8BBA4C474CB4043A("j_spineupper");
  _id_8BBA4C474CB4043A("j_spine4");
  _id_8BBA4C474CB4043A("j_spinelower");
  _id_8BBA4C474CB4043A("j_spinelower2");
  _id_8BBA4C474CB4043A("j_clavicle_ri");
  _id_8BBA4C474CB4043A("j_clavicle_le");
  _id_8BBA4C474CB4043A("j_shoulder_ri");
  _id_8BBA4C474CB4043A("j_shoulder_le");
  _id_8BBA4C474CB4043A("j_elbow_le");
  _id_8BBA4C474CB4043A("j_elbow_ri");
  _id_8BBA4C474CB4043A("j_wrist_le");
  _id_8BBA4C474CB4043A("j_wrist_ri");
  _id_8BBA4C474CB4043A("j_hip_ri");
  _id_8BBA4C474CB4043A("j_hip_le");
  _id_8BBA4C474CB4043A("j_knee_ri");
  _id_8BBA4C474CB4043A("j_knee_le");
  _id_8BBA4C474CB4043A("j_ankle_ri");
  _id_8BBA4C474CB4043A("j_ankle_le");
  _id_8BBA4C474CB4043A("j_mainroot");
}

_id_8BBA4C474CB4043A(str) {
  level._id_D43E78E513933216[_func_3DB00F01CDBA4538(str)] = str;
}

_id_EDEFA1E693DD3C7D(_id_F46544D32B6B992E) {
  if(!_func_28EEFFCB2337321E(_id_F46544D32B6B992E))
    return _id_F46544D32B6B992E;

  if(!isDefined(level._id_D43E78E513933216) || !isDefined(level._id_D43E78E513933216[_id_F46544D32B6B992E]))
    return _id_F46544D32B6B992E;

  return level._id_D43E78E513933216[_id_F46544D32B6B992E];
}

istorsoshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return istorsouppershot(shitloc, smeansofdeath, attacker) || _id_77ED09D75C0C7165(shitloc, smeansofdeath, attacker);
}

istorsouppershot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "neck" || shitloc == "torso_upper";
}

_id_DCDDE2598F1BDFC0(partname) {
  _id_EE272D22135E6099 = 0;

  if(isDefined(partname) && !_func_28EEFFCB2337321E(partname)) {
    switch (partname) {
      case "j_clavicle_ri":
      case "j_clavicle_le":
      case "j_wrist_ri":
      case "j_wrist_le":
      case "j_elbow_le":
      case "j_elbow_ri":
      case "j_shoulder_le":
      case "j_shoulder_ri":
      case "j_spine4":
      case "j_chest":
      case "j_spineupper":
        _id_EE272D22135E6099 = 1;
        break;
    }
  }

  return _id_EE272D22135E6099;
}

_id_77ED09D75C0C7165(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "torso_lower";
}

_id_255C1A4A52956161(partname) {
  _id_9A4F72B70E38D234 = 0;

  if(isDefined(partname)) {
    switch (partname) {
      case "j_spinelower2":
      case "j_spinelower":
        _id_9A4F72B70E38D234 = 1;
        break;
    }
  }

  return _id_9A4F72B70E38D234;
}

_id_2DEB4955AA2D2BC1(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return _id_6F291533530EDC79(shitloc, smeansofdeath, attacker) || _id_D5C75FD1228282EE(shitloc, smeansofdeath, attacker);
}

_id_6F291533530EDC79(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return _id_24278EB0EC1E2953(shitloc, smeansofdeath, attacker) || _id_BF1EFC7185168448(shitloc, smeansofdeath, attacker);
}

_id_D5C75FD1228282EE(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return _id_82850161196DF912(shitloc, smeansofdeath, attacker) || _id_D7395809E0049A49(shitloc, smeansofdeath, attacker);
}

_id_24278EB0EC1E2953(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "right_arm_upper";
}

_id_82850161196DF912(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "left_arm_upper";
}

_id_BF1EFC7185168448(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "right_arm_lower" || shitloc == "right_hand";
}

_id_D7395809E0049A49(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "left_arm_lower" || shitloc == "left_hand";
}

_id_45F34EAEC78AD083(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return _id_C0BD16DEEB47765B(shitloc, smeansofdeath, attacker) || _id_F15A47528FFFCE28(shitloc, smeansofdeath, attacker);
}

_id_C0BD16DEEB47765B(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return _id_4536856E83718DBD(shitloc, smeansofdeath, attacker) || _id_2EEF344E0F951A1A(shitloc, smeansofdeath, attacker);
}

_id_F15A47528FFFCE28(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return _id_275E2A90A59B872C(shitloc, smeansofdeath, attacker) || _id_DA1A82D3AE010F8B(shitloc, smeansofdeath, attacker);
}

_id_4536856E83718DBD(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "right_leg_upper";
}

_id_275E2A90A59B872C(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "left_leg_upper";
}

_id_2EEF344E0F951A1A(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "right_leg_lower" || shitloc == "right_foot";
}

_id_DA1A82D3AE010F8B(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "left_leg_lower" || shitloc == "left_foot";
}

_id_457F72C1DA9B8F7D(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "right_hand" || shitloc == "left_hand" || shitloc == "right_arm_lower" || shitloc == "left_arm_lower" || shitloc == "gun";
}

_id_6720F01C6ABBCAD4(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "right_hand" || shitloc == "left_hand" || shitloc == "right_arm_lower" || shitloc == "left_arm_lower" || shitloc == "gun";
}

_id_AB8B1BD1015C043C(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "right_hand" || shitloc == "left_hand" || shitloc == "right_arm_lower" || shitloc == "left_arm_lower" || shitloc == "gun";
}

_id_8AEA541C52417DFD(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "right_foot";
}

_id_079DADDB5D9B1B30(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "left_foot";
}

_id_A09F9E84B9E51885(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "right_foot" || shitloc == "left_foot";
}

_id_E39711C54E2E8B06(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  return shitloc == "neck";
}

isupperbodyshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  switch (shitloc) {
    case "neck":
    case "left_arm_lower":
    case "right_hand":
    case "right_arm_upper":
    case "right_arm_lower":
    case "left_hand":
    case "torso_upper":
    case "left_arm_upper":
    case "left_leg_upper":
    case "torso_lower":
    case "right_leg_upper":
      return 1;
  }

  return 0;
}

islowerbodyshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker))
    return 0;

  switch (shitloc) {
    case "left_leg_upper":
    case "left_leg_lower":
    case "right_leg_lower":
    case "right_foot":
    case "left_foot":
    case "right_leg_upper":
      return 1;
  }

  return 0;
}

_id_0CB9BA92488B23C5(objweapon) {
  return isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "danger_circle_br";
}