/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\damage_utility.gsc
****************************************************/

#namespace damage_utility;

function adddamagemodifier(id, modifier, additive, ignorefunc) {
  if(!isDefined(additive)) {
    additive = 1;
  }

  if(additive) {
    if(!isDefined(self.additivedamagemodifiers)) {
      self.additivedamagemodifiers = [];
    }

    self.additivedamagemodifiers[id] = modifier;

    if(isDefined(ignorefunc)) {
      if(!isDefined(self.additivedamagemodifierignorefuncs)) {
        self.additivedamagemodifierignorefuncs = [];
      }

      self.additivedamagemodifierignorefuncs[id] = ignorefunc;
    }

    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    self.multiplicativedamagemodifiers = [];
  }

  self.multiplicativedamagemodifiers[id] = modifier;

  if(isDefined(ignorefunc)) {
    if(!isDefined(self.multiplicativedamagemodifierignorefuncs)) {
      self.multiplicativedamagemodifierignorefuncs = [];
    }

    self.multiplicativedamagemodifierignorefuncs[id] = ignorefunc;
  }
}

function removedamagemodifier(id, additive) {
  if(!isDefined(additive)) {
    additive = 1;
  }

  if(additive) {
    if(!isDefined(self.additivedamagemodifiers)) {
      return;
    }

    self.additivedamagemodifiers[id] = undefined;

    if(!isDefined(self.additivedamagemodifierignorefuncs)) {
      return;
    }

    self.additivedamagemodifierignorefuncs[id] = undefined;
    return;
  }

  if(!isDefined(self.multiplicativedamagemodifiers)) {
    return;
  }

  self.multiplicativedamagemodifiers[id] = undefined;

  if(!isDefined(self.multiplicativedamagemodifierignorefuncs)) {
    return;
  }

  self.multiplicativedamagemodifierignorefuncs[id] = undefined;
}

function getdamagemodifiertotal(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  additivetotal = 1;

  if(isDefined(self.additivedamagemodifiers)) {
    foreach(index, modifier in self.additivedamagemodifiers) {
      ignoremodifier = 0;

      if(isDefined(self.additivedamagemodifierignorefuncs[index])) {
        ignoremodifier = [[self.additivedamagemodifierignorefuncs[index]]](inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc);
      }

      if(!ignoremodifier) {
        additivetotal += modifier - 1;
      }
    }
  }

  var_b708aeb049a91d7e = 1;

  if(isDefined(self.multiplicativedamagemodifiers)) {
    foreach(index, modifier in self.multiplicativedamagemodifiers) {
      ignoremodifier = 0;

      if(isDefined(self.multiplicativedamagemodifierignorefuncs[index])) {
        ignoremodifier = [[self.multiplicativedamagemodifierignorefuncs[index]]](inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc);
      }

      if(!ignoremodifier) {
        var_b708aeb049a91d7e *= modifier;
      }
    }
  }

  return additivetotal * var_b708aeb049a91d7e;
}

function cleardamagemodifiers() {
  self.additivedamagemodifiers = [];
  self.multiplicativedamagemodifiers = [];
  self.additivedamagemodifierignorefuncs = [];
  self.multiplicativedamagemodifierignorefuncs = [];
}

function packdamagedata(attacker, victim, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, attachtagname, partname, tagname, idflags, eventid, hitloc, lightarmordamage) {
  struct = {
    #lightarmordamage: lightarmordamage, #hitloc: hitloc, #eventid: eventid, #damageflags: idflags, #idflags: idflags, #tagname: tagname, #partname: partname, #attachtagname: attachtagname, #modelname: modelname, #direction_vec: direction_vec ?? (0, 0, 0), #point: point ?? (0, 0, 0), #inflictor: inflictor, #meansofdeath: meansofdeath ?? "MOD_UNKNOWN", #objweapon: objweapon, #damage: damage, #victim: victim, #attacker: attacker
  };

  if(isDefined(struct.attacker)) {
    struct.attacker.assistedsuicide = 0;
  }

  return struct;
}

function isstuckdamage(inflictor, meansofdeath, nonexplosivedamage) {
  if(self.forcestuckdamage) {
    return true;
  }

  if(isDefined(self.stuckbygrenade)) {
    if(inflictor == self.stuckbygrenade) {
      if(nonexplosivedamage) {
        return true;
      } else if(isexplosivedamagemod(meansofdeath) || meansofdeath == "MOD_FIRE") {
        return true;
      }
    }
  }

  return false;
}

function iscrossbowdamage(objweapon) {
  return objweapon.basename == "iw9_dm_crossbow_mp";
}

function function_607262ae5e772af4(objweapon) {
  return objweapon.basename == "iw9_dm_crossbow_mp" && objweapon hasattachment("ammo_bolt_he");
}

function function_5d5d34b1df1e383d(objweapon) {
  return objweapon.basename == "iw9_dm_crossbow_mp" && objweapon hasattachment("ammo_bolt_db");
}

function isstuckdamagekill(data) {
  if(self.nostuckdamagekill) {
    return false;
  }

  if(!isstuckdamage(data.inflictor, data.meansofdeath, 0)) {
    return false;
  }

  if(data.inflictor.var_b36f1004c0031c91 == 0) {
    return false;
  }

  if(issubstr(data.objweapon.basename, "molotov_mp")) {
    return false;
  } else if(issubstr(data.objweapon.basename, "thermite_mp")) {
    return false;
  } else if(issubstr(data.objweapon.basename, "thermite_ap_mp")) {
    return false;
  } else if(issubstr(data.objweapon.basename, "thermite_av_mp")) {
    return false;
  } else if(issubstr(data.objweapon.basename, "bunkerbuster_mp")) {
    return false;
  } else if(issubstr(data.objweapon.basename, "bunkerbuster_burrowed_mp")) {
    return false;
  }

  return true;
}

function forcestuckdamage() {
  self.forcestuckdamage = 1;
}

function forcestuckdamageclear() {
  self.forcestuckdamage = undefined;
}

function isheadshot(shitloc, smeansofdeath, attacker, validshot = validshotcheck(smeansofdeath, attacker)) {
  if(!validshot) {
    return false;
  }

  if(smeansofdeath == "MOD_GRENADE") {
    return false;
  }

  return shitloc == "head" || shitloc == "helmet";
}

function function_5d1c04cbc4da6bc4(partname) {
  switch (partname ?? #"") {
    case #"j_neck":
    case #"j_head":
    case #"tag_eye":
    case #"j_helmet":
      return true;
  }

  return false;
}

function validshotcheck(smeansofdeath, attacker) {
  if(isDefined(attacker.owner)) {
    switch (attacker.code_classname) {
      case #"hash_3872eb7d97592cac":
      case #"hash_4af55147c6098215":
      case #"hash_81903cb95a447b8c":
        return false;
    }
  }

  switch (smeansofdeath) {
    case #"hash_a5123f4d02745600":
    case #"hash_a911a1880d996edb":
    case #"hash_abb1587cdc6def23":
    case #"hash_b1078ff213fddba6":
    case #"hash_d8646db4e6ee3658":
      return false;
  }

  return true;
}

function istorsoshot(shitloc, smeansofdeath, attacker, validshot = validshotcheck(smeansofdeath, attacker)) {
  if(!validshot) {
    return false;
  }

  return istorsouppershot(shitloc, smeansofdeath, attacker, validshot) || function_fa01c95c6c80017a(shitloc, smeansofdeath, attacker, validshot);
}

function istorsouppershot(shitloc, smeansofdeath, attacker, validshot = validshotcheck(smeansofdeath, attacker)) {
  if(!validshot) {
    return false;
  }

  return shitloc == "neck" || shitloc == "torso_upper";
}

function function_facff8bb3d8f891b(partname) {
  switch (partname ?? #"") {
    case #"j_chest":
    case #"j_spineupper":
    case #"j_clavicle_ri":
    case #"j_clavicle_le":
    case #"j_elbow_ri":
    case #"j_elbow_le":
    case #"j_wrist_ri":
    case #"j_wrist_le":
    case #"j_spine4":
    case #"j_shoulder_ri":
    case #"j_shoulder_le":
      return true;
  }

  return false;
}

function function_fa01c95c6c80017a(shitloc, smeansofdeath, attacker, validshot = validshotcheck(smeansofdeath, attacker)) {
  if(!validshot) {
    return false;
  }

  return shitloc == "torso_lower";
}

function function_b2a4878e3ff817a6(partname) {
  switch (partname ?? #"") {
    case #"j_spinelower":
    case #"j_spinelower2":
      return true;
  }

  return false;
}

function isarmshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return isrightarmshot(shitloc, smeansofdeath, attacker) || isleftarmshot(shitloc, smeansofdeath, attacker);
}

function isrightarmshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return function_b44f28c3d528a4a(shitloc, smeansofdeath, attacker) || function_462b5d72062e80c1(shitloc, smeansofdeath, attacker);
}

function isleftarmshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return function_389f8e73c452ef7d(shitloc, smeansofdeath, attacker) || function_b00a5e646e1b246a(shitloc, smeansofdeath, attacker);
}

function function_b44f28c3d528a4a(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "right_arm_upper";
}

function function_389f8e73c452ef7d(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "left_arm_upper";
}

function function_462b5d72062e80c1(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "right_arm_lower" || shitloc == "right_hand";
}

function function_b00a5e646e1b246a(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "left_arm_lower" || shitloc == "left_hand";
}

function islegshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return isrightlegshot(shitloc, smeansofdeath, attacker) || isleftlegshot(shitloc, smeansofdeath, attacker);
}

function isrightlegshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return function_695b99288411f6a4(shitloc, smeansofdeath, attacker) || function_5e3362cb238c2583(shitloc, smeansofdeath, attacker);
}

function isleftlegshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return function_461caa7e312a3f2f(shitloc, smeansofdeath, attacker) || function_9ba0500b00234c4(shitloc, smeansofdeath, attacker);
}

function function_695b99288411f6a4(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "right_leg_upper";
}

function function_461caa7e312a3f2f(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "left_leg_upper";
}

function function_5e3362cb238c2583(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "right_leg_lower" || shitloc == "right_foot";
}

function function_9ba0500b00234c4(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "left_leg_lower" || shitloc == "left_foot";
}

function islefthandshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "right_hand" || shitloc == "left_hand" || shitloc == "right_arm_lower" || shitloc == "left_arm_lower" || shitloc == "gun";
}

function function_7fd412252b766245(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "right_hand" || shitloc == "left_hand" || shitloc == "right_arm_lower" || shitloc == "left_arm_lower" || shitloc == "gun";
}

function ishandshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "right_hand" || shitloc == "left_hand" || shitloc == "right_arm_lower" || shitloc == "left_arm_lower" || shitloc == "gun";
}

function function_89505f1535b03678(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "right_foot";
}

function function_24e8c4f79eab4f63(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "left_foot";
}

function isfootshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "right_foot" || shitloc == "left_foot";
}

function isneckshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  return shitloc == "neck";
}

function isupperbodyshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  switch (shitloc) {
    case #"hash_da51cc36a471058":
    case #"hash_1cbc508a2fe01b79":
    case #"hash_51d5d0b9add9cc5a":
    case #"hash_5d5aac570f6fd382":
    case #"hash_810a7426c8bac3ac":
    case #"hash_92bbfe494d03d772":
    case #"hash_a7980c387477e7bb":
    case #"hash_b275b50677dcf6cb":
    case #"hash_d42e71cd9f1e822f":
    case #"hash_da2f35145aa58933":
    case #"hash_fbb61fc356f3c75e":
      return true;
  }

  return false;
}

function islowerbodyshot(shitloc, smeansofdeath, attacker) {
  if(!validshotcheck(smeansofdeath, attacker)) {
    return false;
  }

  switch (shitloc) {
    case #"hash_168c74e879f0ba11":
    case #"hash_1cbc508a2fe01b79":
    case #"hash_7b36142458a6c2d5":
    case #"hash_810a7426c8bac3ac":
    case #"hash_9536712388e65bce":
    case #"hash_a638fec9040cfcf4":
      return true;
  }

  return false;
}

function function_7c59274be5208560(attacker_angles, target_angles, threshold_angle) {
  attacker_forward = vectorNormalize(anglesToForward(attacker_angles));
  target_forward = vectorNormalize(anglesToForward(target_angles));
  var_9d592b3c8ebdee3b = vectordot(attacker_forward, target_forward);
  threshold = cos(threshold_angle) * -1;
  var_6b36a7cb674fe419 = var_9d592b3c8ebdee3b >= threshold;
  return var_6b36a7cb674fe419;
}

function function_9144ab79884c5758(objweapon) {
  return isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "danger_circle_br";
}

function register_vehicle_damage_callback(func) {
  if(!isDefined(level.var_6c2fb896a2ebe7d9)) {
    level.var_6c2fb896a2ebe7d9 = [];
  }

  level.var_6c2fb896a2ebe7d9[level.var_6c2fb896a2ebe7d9.size] = func;
}