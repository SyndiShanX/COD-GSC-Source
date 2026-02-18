/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_damage_utility.gsc
*******************************************************/

#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#namespace aiutility;

function autoexec registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&explosivekilled));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"explosivekilled", &explosivekilled);
  assert(isscriptfunctionptr(&electrifiedkilled));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"electrifiedkilled", &electrifiedkilled);
  assert(isscriptfunctionptr(&burnedkilled));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"burnedkilled", &burnedkilled);
  assert(isscriptfunctionptr(&rapskilled));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"rapskilled", &rapskilled);
  assert(isscriptfunctionptr(&tookflashbangdamage));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"tookflashbangdamage", &tookflashbangdamage);
  assert(isscriptfunctionptr(&function_95482e2b));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5b6a2e66dc5bf7a7", &function_95482e2b);
  assert(isscriptfunctionptr(&function_f9a1ea10));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7e18cc452c8ecce8", &function_f9a1ea10);
  assert(isscriptfunctionptr(&function_ebf05a38));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2bb2abb5b247ba91", &function_ebf05a38);
  assert(isscriptfunctionptr(&function_d63ff497));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_49371f9efa84972e", &function_d63ff497);
  assert(isscriptfunctionptr(&function_26b6e27e));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7c8fbf66eeb51ccb", &function_26b6e27e);
  assert(isscriptfunctionptr(&function_603389de));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_1b92b6b5f1705db3", &function_603389de);
  assert(isscriptfunctionptr(&function_13b0963e));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_62a8709f08c68d60", &function_13b0963e);
}

function function_95482e2b(entity) {
  shitloc = entity.damagelocation;

  if(isDefined(shitloc)) {
    return isinarray(array("helmet", "head", "neck"), shitloc);
  }

  return 0;
}

function function_f9a1ea10(entity) {
  shitloc = entity.damagelocation;

  if(isDefined(shitloc)) {
    return (isinarray(array("torso_upper", "torso_mid"), shitloc) || isinarray(array("torso_lower", "groin"), shitloc));
  }

  return false;
}

function function_ebf05a38(entity) {
  shitloc = entity.damagelocation;

  if(isDefined(shitloc)) {
    return isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc);
  }

  return 0;
}

function function_d63ff497(entity) {
  shitloc = entity.damagelocation;

  if(isDefined(shitloc)) {
    return isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc);
  }

  return 0;
}

function function_26b6e27e(entity) {
  shitloc = entity.damagelocation;

  if(isDefined(shitloc)) {
    return isinarray(array("torso_lower", "groin"), shitloc);
  }

  return 0;
}

function function_603389de(entity) {
  shitloc = entity.damagelocation;

  if(isDefined(shitloc)) {
    return isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), shitloc);
  }

  return 0;
}

function function_13b0963e(entity) {
  shitloc = entity.damagelocation;

  if(isDefined(shitloc)) {
    return isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), shitloc);
  }

  return 0;
}

function explosivekilled(entity) {
  if(entity getblackboardattribute("_damage_weapon_class") == "explosive" && entity getblackboardattribute("_damage_taken") != "light") {
    return true;
  }

  return false;
}

function electrifiedkilled(entity) {
  if(entity.damageweapon.rootweapon.name == "shotgun_pump_taser") {
    return true;
  }

  if(entity getblackboardattribute("_damage_mod") == "mod_electrocuted") {
    return true;
  }

  return false;
}

function burnedkilled(entity) {
  if(entity getblackboardattribute("_damage_mod") == "mod_burned") {
    return true;
  }

  return false;
}

function rapskilled(entity) {
  if(isDefined(self.attacker) && isDefined(self.attacker.archetype) && self.attacker.archetype == # "raps") {
    return true;
  }

  return false;
}

function function_e2010f4c(entity, var_515373f2) {
  if(isDefined(entity) && isDefined(var_515373f2.durations) && var_515373f2.durations.size > 0) {
    foreach(var_4e73c1e in var_515373f2.durations) {
      if(var_4e73c1e.archetype === entity.archetype) {
        return var_4e73c1e;
      }
    }
  }
}

function private tookflashbangdamage(entity) {
  if(isDefined(entity.damageweapon) && isDefined(entity.damagemod)) {
    weapon = entity.damageweapon;

    if(entity.damagemod == "MOD_GRENADE_SPLASH" && isDefined(self.var_40543c03)) {
      if(self.var_40543c03 == "foam" || self.var_40543c03 == "flash") {
        return true;
      }
    }
  }

  return false;
}

function bb_getdamagedirection() {
  if(isDefined(level._debug_damage_direction)) {
    return level._debug_damage_direction;
  }

  if(self.damageyaw > 135 || self.damageyaw <= -135) {
    self.damage_direction = "front";
    return "front";
  }

  if(self.damageyaw > 45 && self.damageyaw <= 135) {
    self.damage_direction = "right";
    return "right";
  }

  if(self.damageyaw > -45 && self.damageyaw <= 45) {
    self.damage_direction = "back";
    return "back";
  }

  self.damage_direction = "left";
  return "left";
}

function function_7e269d82() {
  if(isDefined(self.var_40543c03)) {
    return self.var_40543c03;
  }

  return "normal";
}

function bb_actorgetdamagelocation() {
  if(isDefined(level._debug_damage_pain_location)) {
    return level._debug_damage_pain_location;
  }

  damagelocation = undefined;

  if(isDefined(self.var_b7884e7f)) {
    damagelocation = self[[self.var_b7884e7f]]();
  }

  if(!isDefined(damagelocation)) {
    shitloc = self.damagelocation;
    possiblehitlocations = array();

    if(isDefined(shitloc) && shitloc != "none") {
      if(isinarray(array("helmet", "head", "neck"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "head";
      } else if(isinarray(array("torso_upper", "torso_mid"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "chest";
      } else if(isinarray(array("torso_lower", "groin"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "groin";
      } else if(isinarray(array("torso_lower", "groin"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "legs";
      } else if(isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "left_arm";
      } else if(isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "right_arm";
      } else if(isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "legs";
      }
    }

    if(possiblehitlocations.size == 0) {
      possiblehitlocations[possiblehitlocations.size] = "chest";
      possiblehitlocations[possiblehitlocations.size] = "groin";
    }

    assert(possiblehitlocations.size > 0, possiblehitlocations.size);
    damagelocation = possiblehitlocations[randomint(possiblehitlocations.size)];
  }

  return damagelocation;
}

function bb_getdamageweaponclass() {
  if(isDefined(level.var_1516eaca)) {
    special = self[[level.var_1516eaca]]();

    if(isDefined(special)) {
      return special;
    }
  }

  if(isDefined(self.damagemod)) {
    if(isinarray(array("mod_rifle_bullet"), tolower(self.damagemod))) {
      return "rifle";
    }

    if(isinarray(array("mod_pistol_bullet"), tolower(self.damagemod))) {
      return "pistol";
    }

    if(isinarray(array("mod_melee", "mod_melee_assassinate", "mod_melee_weapon_butt"), tolower(self.damagemod))) {
      return "melee";
    }

    if(isinarray(array("mod_grenade", "mod_grenade_splash", "mod_projectile", "mod_projectile_splash", "mod_explosive"), tolower(self.damagemod))) {
      return "explosive";
    }
  }

  return "rifle";
}

function bb_getdamageweapon() {
  if(isDefined(self.special_weapon) && isDefined(self.special_weapon.name)) {
    return self.special_weapon.name;
  }

  if(isDefined(self.damageweapon) && isDefined(self.damageweapon.name)) {
    return self.damageweapon.name;
  }

  return "unknown";
}

function bb_getdamagemod() {
  if(isDefined(self.damagemod)) {
    return tolower(self.damagemod);
  }

  return "unknown";
}

function function_9144ba8() {
  damagetakentype = "none";

  if(gettime() - self.damagetime < 500) {
    if(isDefined(self.var_ec422675)) {
      return self.var_ec422675;
    }

    ratio = self.damagetaken / 100;

    if(isDefined(self.var_fe72f961)) {
      damagetakentype = self[[self.var_fe72f961]](ratio);
    } else if(ratio >= 0.7) {
      damagetakentype = "heavy";
    } else {
      damagetakentype = "light";
    }
  }

  return damagetakentype;
}

function bb_getdamagetaken() {
  if(isDefined(level._debug_damage_intensity)) {
    return level._debug_damage_intensity;
  }

  if(isDefined(self.var_ec422675)) {
    return self.var_ec422675;
  }

  damagetaken = self.damagetaken;

  if(isDefined(self.var_27feb91e)) {
    damagetaken = self.var_27feb91e;
  }

  maxhealth = self.maxhealth;
  damagetakentype = "light";

  if(isalive(self)) {
    ratio = damagetaken / 100;

    if(isDefined(self.var_fe72f961)) {
      damagetakentype = self[[self.var_fe72f961]](ratio);
    } else if(ratio > 0.7) {
      damagetakentype = "heavy";
    }

    self.lastdamagetime = gettime();
  } else {
    ratio = damagetaken / 100;

    if(isDefined(self.var_fe72f961)) {
      damagetakentype = self[[self.var_fe72f961]](ratio);
    } else if(ratio > 0.7) {
      damagetakentype = "heavy";
    }
  }

  return damagetakentype;
}

function bb_idgungetdamagedirection() {
  if(isDefined(self.damage_direction)) {
    return self.damage_direction;
  }

  return self bb_getdamagedirection();
}

function bb_actorgetfataldamagelocation() {
  if(isDefined(level._debug_damage_location)) {
    return level._debug_damage_location;
  }

  shitloc = self.damagelocation;

  if(isDefined(shitloc)) {
    if(isinarray(array("helmet", "head", "neck"), shitloc)) {
      return "head";
    }

    if(isinarray(array("torso_upper", "torso_mid"), shitloc)) {
      return "chest";
    }

    if(isinarray(array("torso_lower", "groin"), shitloc)) {
      return "hips";
    }

    if(isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
      return "right_arm";
    }

    if(isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
      return "left_arm";
    }

    if(isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc)) {
      return "legs";
    }
  }

  randomlocs = array("chest", "hips");
  return randomlocs[randomint(randomlocs.size)];
}

function addaioverridedamagecallback(entity, callback, addtofront) {
  assert(isentity(entity));
  assert(isfunctionptr(callback));
  assert(!isDefined(entity.aioverridedamage) || isarray(entity.aioverridedamage));

  if(!isDefined(entity.aioverridedamage)) {
    entity.aioverridedamage = [];
  } else if(!isarray(entity.aioverridedamage)) {
    entity.aioverridedamage = array(entity.aioverridedamage);
  }

  if(is_true(addtofront)) {
    damageoverrides = [];
    damageoverrides[damageoverrides.size] = callback;

    foreach(override in entity.aioverridedamage) {
      damageoverrides[damageoverrides.size] = override;
    }

    entity.aioverridedamage = damageoverrides;
    return;
  }

  if(!isDefined(entity.aioverridedamage)) {
    entity.aioverridedamage = [];
  } else if(!isarray(entity.aioverridedamage)) {
    entity.aioverridedamage = array(entity.aioverridedamage);
  }

  entity.aioverridedamage[entity.aioverridedamage.size] = callback;
}

function removeaioverridedamagecallback(entity, callback) {
  assert(isentity(entity));
  assert(isfunctionptr(callback));
  assert(isarray(entity.aioverridedamage));
  currentdamagecallbacks = entity.aioverridedamage;
  entity.aioverridedamage = [];

  foreach(value in currentdamagecallbacks) {
    if(value != callback) {
      entity.aioverridedamage[entity.aioverridedamage.size] = value;
    }
  }
}

function clearaioverridedamagecallbacks(entity) {
  entity.aioverridedamage = [];
}

function addaioverridekilledcallback(entity, callback) {
  assert(isentity(entity));
  assert(isfunctionptr(callback));
  assert(!isDefined(entity.aioverridekilled) || isarray(entity.aioverridekilled));

  if(!isDefined(entity.aioverridekilled)) {
    entity.aioverridekilled = [];
  } else if(!isarray(entity.aioverridekilled)) {
    entity.aioverridekilled = array(entity.aioverridekilled);
  }

  entity.aioverridekilled[entity.aioverridekilled.size] = callback;
}