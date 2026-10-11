/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\ob\points.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\cash;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\weapon;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#using scripts\mp\gamescore;
#using scripts\mp\rank;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\ob\points;
#namespace points;

function init() {
  registersharedfunc("points", "get_points", &function_b86115649d705017);
  registersharedfunc("points", "set_points", &function_5fb17ad4d286b0d5);
  registersharedfunc("points", "take_points", &function_e04a2325dbe8153c);
  registersharedfunc("points", "add_points", &function_b5b4f530f1c579aa);
  level.modifyunifiedpointscallback = &function_c7f9db170bb3828b;
  level.var_9871526022516e0b = &function_cf6a439e1dd8049f;
  level callback::add("on_ai_killed", &function_269657aa69da2b38);
  level callback::add("zombie_score_event", &function_ccac14f2510dd65a);
  level callback::add("player_connect", &on_player_connect);
  level callback::add("player_damaged", &on_player_damaged);
  level callback::add("lootcache_looted", &function_8b134141131f364a);
}

function function_8b134141131f364a(params) {
  if(isDefined(params.cacheinstance) && isDefined(params.cacheinstance.type) && !istrue(params.cacheinstance.openedbefore)) {
    scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_f0bd5f0d32453556");
  }
}

function on_player_damaged(params) {
  if(isPlayer(params.victim)) {
    params.victim.var_b57b122cb903fddf = default_to(params.victim.var_b57b122cb903fddf, 0);
    params.victim.var_b57b122cb903fddf = 0;
  }
}

function on_player_connect(params) {
  var_79d8c8dc68beb094 = default_to(scripts\cp_mp\currency::function_7dfe1b812431019f("essence"), 0);
  scripts\cp_mp\currency::function_adc47eed1b02ec05("essence", var_79d8c8dc68beb094);
  callback::add("safe_opened_nearby", &on_safe_open);
}

function on_safe_open(sparams) {
  function_ddee59d6b1a2b9e(#"hash_c02c8c802f07c908");
}

function function_bd0c9022c796f049(eventstring, sweapon) {
  if(!isxhash(eventstring)) {
    eventstring = getxhash(eventstring);
  }

  xp = scripts\mp\rank::getscoreinfoxp(eventstring);

  if(isDefined(xp) && xp != 0) {}

  return xp;
}

function function_ef5d482e9930a774(eventstring, sweapon, var_527bff0c92d4a0aa) {
  if(!isxhash(eventstring)) {
    eventstring = getxhash(eventstring);
  }

  points = scripts\mp\rank::getscoreinfovalue(eventstring);

  if(isDefined(points) && points != 0) {
    if(isDefined(var_527bff0c92d4a0aa)) {
      return (points * var_527bff0c92d4a0aa);
    }
  }

  return undefined;
}

function function_c7f9db170bb3828b(points, event, player, objweapon) {
  return points * player function_1b86539a6f213fc3();
}

function function_ddee59d6b1a2b9e(scoreevent, sweapon, var_7594386ec6f06936, reason, var_527bff0c92d4a0aa) {
  if(!isDefined(var_7594386ec6f06936)) {
    var_7594386ec6f06936 = 0;
  }

  if(!isDefined(reason)) {
    reason = #"none";
  }

  if(!isPlayer(self) || scripts\mp\utility\player::isinlaststand(self) && !var_7594386ec6f06936) {
    return;
  }

  xpoverride = function_bd0c9022c796f049(scoreevent, sweapon);
  pointsoverride = function_ef5d482e9930a774(scoreevent, sweapon, var_527bff0c92d4a0aa);
  scripts\mp\utility\points::doscoreevent(scoreevent, undefined, pointsoverride, xpoverride, undefined, undefined, undefined, undefined, undefined, 1);
  essence = function_b86115649d705017();
  scripts\cp_mp\currency::function_d0948454b7f94d18("essence", essence, reason);
  self setclientomnvar("zm_essence", essence);
}

function function_8c80bfd5eb313b22(eventstring, points, victim) {
  if(!isPlayer(self) || scripts\mp\utility\player::isinlaststand(self)) {
    return;
  }

  scripts\mp\utility\points::doscoreevent(eventstring, undefined, points, undefined, victim, undefined, undefined, undefined, undefined, 1);
  essence = function_b86115649d705017();
  self.currency["essence"] = essence;
  self setclientomnvar("zm_essence", essence);
}

function function_e04a2325dbe8153c(points) {
  currentpoints = scripts\mp\gamescore::_getplayerscore(self);
  points = currentpoints - points;

  if(points < 0) {
    points = 0;
  }

  scripts\mp\gamescore::_setplayerscore(self, points);
  essence = function_b86115649d705017();
  self.currency["essence"] = essence;
  self setclientomnvar("zm_essence", essence);
}

function function_5ef7bc993b154224() {
  self.scoreondeath = scripts\mp\gamescore::_getplayerscore(self);
  function_5fb17ad4d286b0d5(0);
}

function function_d57de844b62e642b() {
  if(!isDefined(self.scoreondeath)) {
    return;
  }

  function_5fb17ad4d286b0d5(self.scoreondeath);
}

function function_b86115649d705017() {
  currentpoints = scripts\mp\gamescore::_getplayerscore(self);
  scripts\cp_mp\cash::function_52bea99a5c38fbe5(currentpoints);
  return currentpoints;
}

function function_b5b4f530f1c579aa(points) {
  currentpoints = scripts\mp\gamescore::_getplayerscore(self);
  totalpoints = currentpoints + points;
  function_5fb17ad4d286b0d5(totalpoints);
}

function function_5fb17ad4d286b0d5(points) {
  if(points > 999999) {
    println("<dev string:x1c>" + points + "<dev string:x43>" + 999999 + "<dev string:x8a>");
    points = 999999;
  }

  scripts\mp\gamescore::_setplayerscore(self, points);
  essence = function_b86115649d705017();
  self.currency["essence"] = essence;
  self setclientomnvar("zm_essence", essence);
}

function function_be68f708692f876f(value) {
  assert(isPlayer(self), "<dev string:x8f>");
  self.zombie_point_scalar = value;
}

function function_1b86539a6f213fc3() {
  assert(isPlayer(self), "<dev string:xbf>");

  if(isnumber(self.zombie_point_scalar)) {
    return self.zombie_point_scalar;
  }

  return 1;
}

function function_818ac0c0b8f0b22(var_2267bb02be780ba4, string_add) {
  if(var_2267bb02be780ba4 == #"zombie_kia") {
    returnstring = hashcat(#"zombie_kia", string_add);
  } else if(var_2267bb02be780ba4 == #"zombie_kia_special") {
    returnstring = hashcat(#"zombie_kia_special", string_add);
  } else if(var_2267bb02be780ba4 == #"zombie_kia_elite") {
    returnstring = hashcat(#"zombie_kia_elite", string_add);
  } else if(var_2267bb02be780ba4 == #"hellhound_kia") {
    returnstring = hashcat(#"hellhound_kia", string_add);
  } else if(var_2267bb02be780ba4 == #"soldier_kia") {
    returnstring = hashcat(#"soldier_kia", string_add);
  } else {
    returnstring = var_2267bb02be780ba4;
  }

  returnstring = getxhash(returnstring);

  if(!array_contains_key(level.scoreinfo, returnstring)) {
    returnstring = var_2267bb02be780ba4;
  }

  return returnstring;
}

function function_191e620389d99b8e(weapon) {
  if(isDefined(weapon) && isDefined(weapon.basename)) {
    switch (weapon.basename) {
      case #"hash_e69f44ae97e8fc97":
        return "_monkeybomb";
      case #"hash_3e6715cf4cbc46d0":
        return "_turret_trap";
      case #"hash_15f465447f809c29":
        return "_kazimir";
      default:
        return undefined;
    }
  }

  return undefined;
}

function function_cf6a439e1dd8049f(victim, eattacker, einflictor, smeansofdeath, sweapon, shitloc, typestring, kiastring) {
  if(isDefined(self.var_d37b75616f7c2ee) && isPlayer(self.var_d37b75616f7c2ee.var_941802a0997e0c42) || isPlayer(self.var_941802a0997e0c42)) {
    return;
  }

  basekillstring = kiastring;
  var_8c817724af28fb4d = function_191e620389d99b8e(sweapon);

  if(isDefined(var_8c817724af28fb4d)) {
    kiastring = function_818ac0c0b8f0b22(kiastring, var_8c817724af28fb4d);
  } else if(isDefined(einflictor.weapon_name) && isDefined(level.killstreakweaponmap[einflictor.weapon_name])) {
    end_string = "_" + level.killstreakweaponmap[einflictor.weapon_name];
    kiastring = function_818ac0c0b8f0b22(kiastring, end_string);
  } else if(eattacker scripts\mp\utility\killstreak::isjuggernaut()) {
    kiastring = function_818ac0c0b8f0b22(kiastring, "_juggernaut");
  } else if(scripts\cp_mp\weapon::iskillstreakweapon(sweapon)) {
    end_string = "_" + level.killstreakweaponmap[sweapon.basename];
    kiastring = function_818ac0c0b8f0b22(kiastring, end_string);
  } else if(is_equal(einflictor.weapon_name, "hellhound_molotov")) {
    end_string = "_hellhound_flame";
    kiastring = function_818ac0c0b8f0b22(kiastring, end_string);
  } else {
    binvehicle = 0;

    if(isDefined(einflictor.vehicletype)) {
      kiastring = function_818ac0c0b8f0b22(kiastring, "_vehicle");
    }

    if(smeansofdeath == "MOD_MELEE") {
      kiastring = function_818ac0c0b8f0b22(kiastring, "_melee");
    }

    if(isDefined(self.var_d37b75616f7c2ee) && istrue(self.var_d37b75616f7c2ee.biscritical)) {
      kiastring = function_818ac0c0b8f0b22(kiastring, "_critical");
    }
  }

  if(isDefined(self.var_5ede61272f442abd)) {
    kiastring = self.var_5ede61272f442abd;
  }

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXECUTION" && self.unittype == "zombie") {
    kiastring = #"zombie_kia_executed";
  }

  eattacker thread function_97bd8649553541e9(kiastring, sweapon, self);

  if(isDefined(self.var_21a8839dd03e31cd)) {
    if(self.var_21a8839dd03e31cd.size > 0) {
      foreach(player in self.var_21a8839dd03e31cd) {
        if(eattacker == player) {
          continue;
        }

        player thread function_97bd8649553541e9(basekillstring, sweapon);
      }
    }
  }

  eattacker function_b5679c2e3399669d(victim, smeansofdeath, sweapon);
}

function function_97bd8649553541e9(basekillstring, sweapon, eai) {
  var_dfb32fa12d928f0b = 0;

  if(isDefined(eai) && istrue(eai.var_f405191d4605c15c)) {
    var_dfb32fa12d928f0b = 1;
  }

  if(ent_flag("powerup_insta_kill_active")) {
    var_dfb32fa12d928f0b = 1;
  }

  if(!isDefined(level.var_fe43fca6e0f2c11a)) {
    level.var_fe43fca6e0f2c11a = throttle_initialize("ob_killing_score_event", 2, level.framedurationseconds);
  }

  killing_event = spawnStruct();
  function_f632348cbb773537(level.var_fe43fca6e0f2c11a, killing_event);

  if(basekillstring == "zombie_kia_executed") {
    wait 1;
  }

  if(isDefined(self)) {
    if(var_dfb32fa12d928f0b) {
      val::set("zm_allow_give_super_point", "allow_give_super_point", 0);
    }

    scripts\ob\points::function_ddee59d6b1a2b9e(basekillstring, sweapon, 0, #"kill");
    val::reset_all("zm_allow_give_super_point");
  }
}

function function_b5679c2e3399669d(victim, smeansofdeath, sweapon) {
  if(isDefined(self.var_b57b122cb903fddf) && self.var_b57b122cb903fddf != 0 && (self.var_b57b122cb903fddf + 1) % 30 == 0) {
    scripts\ob\points::function_ddee59d6b1a2b9e(#"medal_jackrabbit");
  }

  if(!isDefined(self.rapidkill_data)) {
    return;
  }

  if(isDefined(self.rapidkill_data["MOD_MELEE"]) && self.rapidkill_data["MOD_MELEE"].rapidkill_count != 0) {
    if(self.rapidkill_data["MOD_MELEE"].rapidkill_count % 15 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_934604e5ebee53a5");
    } else if(self.rapidkill_data["MOD_MELEE"].rapidkill_count % 10 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_9345ffe5ebee4b26");
    } else if(self.rapidkill_data["MOD_MELEE"].rapidkill_count % 5 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_d586c80f3dbf32a6");
    }
  }

  if(isDefined(self.rapidkill_data["primary"]) && self.rapidkill_data["primary"].rapidkill_count != 0) {
    if(self.rapidkill_data["primary"].rapidkill_count % 20 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"medal_rapidkill_20");
    } else if(self.rapidkill_data["primary"].rapidkill_count % 15 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"medal_rapidkill_15");
    } else if(self.rapidkill_data["primary"].rapidkill_count % 10 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"medal_rapidkill_10");
    }
  }

  if(isDefined(self.rapidkill_data["vehicle_crush_or_kill"]) && self.rapidkill_data["vehicle_crush_or_kill"].rapidkill_count != 0) {
    if(self.rapidkill_data["vehicle_crush_or_kill"].rapidkill_count % 20 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_2ff2bec46b4deb91");
    } else if(self.rapidkill_data["vehicle_crush_or_kill"].rapidkill_count % 15 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_2ff641c46b510001");
    } else if(self.rapidkill_data["vehicle_crush_or_kill"].rapidkill_count % 10 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_2ff644c46b51051a");
    }
  }

  if(isDefined(self.rapidkill_data["single_explosive_kill"]) && self.rapidkill_data["single_explosive_kill"].rapidkill_count != 0) {
    if(self.rapidkill_data["single_explosive_kill"].rapidkill_count % 20 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_54f28fa9ddf9b769");
    } else if(self.rapidkill_data["single_explosive_kill"].rapidkill_count % 15 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_54f592a9ddfbf259");
    } else if(self.rapidkill_data["single_explosive_kill"].rapidkill_count % 10 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_54f595a9ddfbf772");
    }
  }

  if(isDefined(self.rapidkill_data["killstreak_kill"]) && self.rapidkill_data["killstreak_kill"].rapidkill_count != 0) {
    if(self.rapidkill_data["killstreak_kill"].rapidkill_count % 20 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_6ded9a614605c2b0");
    } else if(self.rapidkill_data["killstreak_kill"].rapidkill_count % 15 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_6df7af61460e3ae4");
    } else if(self.rapidkill_data["killstreak_kill"].rapidkill_count % 10 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_6df7ac61460e35cb");
    }
  }

  if(isDefined(self.rapidkill_data["elemental_kill_fire"]) && self.rapidkill_data["elemental_kill_fire"].rapidkill_count != 0) {
    if(self.rapidkill_data["elemental_kill_fire"].rapidkill_count % 10 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_1d16a90346898202");
    }
  }

  if(isDefined(self.rapidkill_data["elemental_kill_cold"]) && self.rapidkill_data["elemental_kill_cold"].rapidkill_count != 0) {
    if(self.rapidkill_data["elemental_kill_cold"].rapidkill_count % 10 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_a12b45eb4f1d0138");
    }
  }

  if(isDefined(self.rapidkill_data["elemental_kill_electrical"]) && self.rapidkill_data["elemental_kill_electrical"].rapidkill_count != 0) {
    if(self.rapidkill_data["elemental_kill_electrical"].rapidkill_count % 10 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_deefad4fef3853c");
    }
  }

  if(isDefined(self.rapidkill_data["elemental_kill_toxic"]) && self.rapidkill_data["elemental_kill_toxic"].rapidkill_count != 0) {
    if(self.rapidkill_data["elemental_kill_toxic"].rapidkill_count % 10 == 0) {
      scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_2d04f4b7c3b707");
    }
  }
}

function function_ccac14f2510dd65a(sparams) {
  if(isPlayer(self) && isDefined(sparams.scoreevent)) {
    scoreevent = sparams.scoreevent;
    scripts\ob\points::function_ddee59d6b1a2b9e(scoreevent);
  }
}

function function_591305dc9c07499b(objweapon, eattacker, smeansofdeath) {
  element = "none";
  var_225a577cbeda65c2 = objweapon.var_9d7facbe889e667c;
  var_4c1dfbfd3368cae6 = level.sharedfuncs["zombie"]["has_ammo_mod"];

  if(isPlayer(eattacker) && istrue(level.var_bfa98c9dd6edb929) && isDefined(var_4c1dfbfd3368cae6) && eattacker[[var_4c1dfbfd3368cae6]](objweapon)) {
    var_87acb5f0ae5e6d72 = level.sharedfuncs["zombie"]["get_ammo_mod_name"];

    if(isDefined(var_87acb5f0ae5e6d72)) {
      ammomod_name = eattacker[[var_87acb5f0ae5e6d72]](objweapon);

      if(isDefined(level.ammo_mods[ammomod_name].element)) {
        element = level.ammo_mods[ammomod_name].element;
      }
    }
  } else {
    weaponbundle = undefined;

    if(isDefined(level.weaponmetadata)) {
      weaponbundle = level.weaponmetadata[var_225a577cbeda65c2];
    }

    if(isDefined(weaponbundle) && isDefined(weaponbundle.elementdamagetype)) {
      element = weaponbundle.elementdamagetype;
    }
  }

  if(isDefined(smeansofdeath)) {
    if(smeansofdeath == "MOD_FIRE" || smeansofdeath == "MOD_ELEMENTAL_FIRE") {
      element = "fire";
    }

    if(smeansofdeath == "MOD_ELEMENTAL_ELEC") {
      element = "electrical";
    }

    if(smeansofdeath == "MOD_ELEMENTAL_COLD") {
      element = "cold";
    }

    if(smeansofdeath == "MOD_ELEMENTAL_TOXIC") {
      element = "toxic";
    }

    if(smeansofdeath == "MOD_ELEMENTAL_DARK") {
      element = "dark";
    }

    if(smeansofdeath == "MOD_ELEMENTAL_LIGHT") {
      element = "light";
    }
  }

  return element;
}

function function_269657aa69da2b38(sparams) {
  var_8a9445752cf5f1c9 = self.var_941802a0997e0c42;
  var_d8d142881fb224 = isDefined(sparams.eattacker) ? sparams.eattacker.var_941802a0997e0c42 : undefined;
  elementalweakness = self.elementalweakness;

  if(!isDefined(level.ob_ai_killed_points_throttle)) {
    level.ob_ai_killed_points_throttle = throttle_initialize("ob_ai_killed_points_throttle", 1, level.framedurationseconds);
  }

  var_c11d6c177d7ab5a2 = spawnStruct();
  function_f632348cbb773537(level.ob_ai_killed_points_throttle, var_c11d6c177d7ab5a2);

  if(isPlayer(var_d8d142881fb224)) {
    var_d8d142881fb224 scripts\ob\points::function_ddee59d6b1a2b9e(#"brainrot_kill", undefined, 0, #"kill");
  }

  if(isPlayer(var_8a9445752cf5f1c9)) {
    var_8a9445752cf5f1c9 scripts\ob\points::function_ddee59d6b1a2b9e(#"brainrot_kill", undefined, 0, #"kill");
  }

  if(isPlayer(sparams.eattacker)) {
    sparams.eattacker.rapidkill_data = isDefined(sparams.eattacker.rapidkill_data) ? sparams.eattacker.rapidkill_data : [];

    if(isDefined(sparams.smeansofdeath)) {
      sparams.eattacker function_54de0dcded063f2d(sparams.smeansofdeath);
    }

    var_38a9d32b5a5ad939 = function_9da9c82aa52d0513(sparams);
    is_killstreak = function_135f1d917020589a(sparams.sweapon);

    if(isDefined(sparams.sweapon) && sparams.sweapon.classname != "turret" && is_equal(sparams.sweapon.inventorytype, "primary") && isDefined(sparams.smeansofdeath) && sparams.smeansofdeath != "MOD_MELEE" && !var_38a9d32b5a5ad939) {
      sparams.eattacker function_54de0dcded063f2d("primary");
    }

    if(isDefined(sparams.smeansofdeath) && !is_killstreak && !var_38a9d32b5a5ad939 && sparams.smeansofdeath == "MOD_EXPLOSIVE" || sparams.smeansofdeath == "MOD_PROJECTILE" || sparams.smeansofdeath == "MOD_PROJECTILE_SPLASH" || sparams.smeansofdeath == "MOD_GRENADE_SPLASH") {
      sparams.eattacker function_54de0dcded063f2d("single_explosive_kill", sparams.sweapon);
    }

    if(isDefined(sparams.eattacker.vehicle) && is_equal(sparams.eattacker.currentweapon.classname, "turret")) {
      sparams.eattacker function_54de0dcded063f2d("vehicle_crush_or_kill");
    }

    if(sparams.eattacker scripts\mp\utility\killstreak::isjuggernaut() || is_killstreak) {
      sparams.eattacker function_54de0dcded063f2d("killstreak_kill");
    }

    sparams.eattacker.var_b57b122cb903fddf = isDefined(sparams.eattacker.var_b57b122cb903fddf) ? sparams.eattacker.var_b57b122cb903fddf : 0;
    sparams.eattacker.var_b57b122cb903fddf++;
  }

  if(isDefined(sparams.eattacker) && isPlayer(sparams.eattacker.owner)) {
    sparams.eattacker.owner.rapidkill_data = isDefined(sparams.eattacker.owner.rapidkill_data) ? sparams.eattacker.owner.rapidkill_data : [];

    if(isDefined(sparams.eattacker.streakname) && sparams.eattacker.streakname == "sentry_turret") {
      sparams.eattacker.owner function_54de0dcded063f2d("killstreak_kill");
    }

    if(is_equal(sparams.eattacker.classname, "script_vehicle")) {
      sparams.eattacker.owner function_54de0dcded063f2d("vehicle_crush_or_kill");
    }
  }

  if(isDefined(sparams.sweapon) && isDefined(sparams.smeansofdeath) && isPlayer(sparams.eattacker)) {
    weaponelementtype = function_591305dc9c07499b(sparams.sweapon, sparams.eattacker, sparams.smeansofdeath);
    var_4106d2021e226fcd = "none";

    if(weaponelementtype == "fire" || sparams.smeansofdeath == "MOD_ELEMENTAL_FIRE") {
      if(!isDefined(sparams.einflictor) || !is_equal(sparams.einflictor.weapon_name, "hellhound_molotov")) {
        sparams.eattacker function_54de0dcded063f2d("elemental_kill_fire");
        var_4106d2021e226fcd = #"hash_f09b4f756df11aa4";
      }
    } else if(weaponelementtype == "cold" || sparams.smeansofdeath == "MOD_ELEMENTAL_COLD") {
      sparams.eattacker function_54de0dcded063f2d("elemental_kill_cold");
      var_4106d2021e226fcd = #"hash_a62035653525d27e";
    } else if(weaponelementtype == "electrical" || sparams.smeansofdeath == "MOD_ELEMENTAL_ELEC") {
      sparams.eattacker function_54de0dcded063f2d("elemental_kill_electrical");
      var_4106d2021e226fcd = #"hash_f48e7e053c787be5";
    } else if(weaponelementtype == "toxic" || sparams.smeansofdeath == "MOD_ELEMENTAL_TOXIC") {
      sparams.eattacker function_54de0dcded063f2d("elemental_kill_toxic");
      var_4106d2021e226fcd = #"hash_e1c37b28b02f43bf";
    }

    if(isDefined(elementalweakness) && isarray(elementalweakness) && istrue(elementalweakness[weaponelementtype]) && var_4106d2021e226fcd != "none") {
      sparams.eattacker scripts\ob\points::function_ddee59d6b1a2b9e(var_4106d2021e226fcd, undefined, 0, #"kill");
    }
  }

  if(isPlayer(sparams.eattacker) && isDefined(sparams.einflictor) && is_equal(sparams.einflictor.weapon_name, "hellhound_molotov")) {
    einflictor = sparams.einflictor;

    if(isDefined(einflictor.var_6f3cee3c008da525)) {
      einflictor[[einflictor.var_6f3cee3c008da525]]();
    }
  }

  if(isDefined(sparams.eattacker) && istrue(sparams.eattacker.var_66c8cd2e51badc67)) {
    if(isPlayer(sparams.eattacker.var_66c1831357048c02)) {
      sparams.eattacker.var_66c1831357048c02 scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_32cb50a92afed17f", undefined, 0, #"kill");
    }
  }

  if(isDefined(sparams.eattacker) && istrue(sparams.eattacker.var_873d30685528d962)) {
    if(isPlayer(sparams.eattacker.var_66c1831357048c02)) {
      sparams.eattacker.var_66c1831357048c02 scripts\ob\points::function_ddee59d6b1a2b9e(#"hash_9c375574d4a407ec", undefined, 0, #"kill");
    }
  }
}

function function_de67925b7692fe3d(var_444cec370990f32) {
  self notify(var_444cec370990f32 + "recent_zombie_rapid_kill");
  self endon(var_444cec370990f32 + "recent_zombie_rapid_kill");
  level endon("game_ended");
  wait 2;

  if(isPlayer(self) && isDefined(self.rapidkill_data) && isDefined(self.rapidkill_data[var_444cec370990f32])) {
    self.rapidkill_data[var_444cec370990f32].rapidkill_count = 0;
  }
}

function function_54de0dcded063f2d(var_444cec370990f32, sweapon) {
  self.rapidkill_data[var_444cec370990f32] = default_to(self.rapidkill_data[var_444cec370990f32], spawnStruct());
  self.rapidkill_data[var_444cec370990f32].rapidkill_count = default_to(self.rapidkill_data[var_444cec370990f32].rapidkill_count, 0);

  if(isDefined(sweapon)) {
    if(!isDefined(self.rapidkill_data[var_444cec370990f32].weapon)) {
      self.rapidkill_data[var_444cec370990f32].weapon = sweapon;
    } else if(self.rapidkill_data[var_444cec370990f32].weapon != sweapon) {
      self.rapidkill_data[var_444cec370990f32].rapidkill_count = 0;
      return;
    }
  }

  self.rapidkill_data[var_444cec370990f32].rapidkill_count++;
  thread function_de67925b7692fe3d(var_444cec370990f32);
}

function function_135f1d917020589a(sweapon) {
  return isDefined(sweapon) && isDefined(sweapon.basename) && issubstr(sweapon.basename, "cluster_spike") || issubstr(sweapon.basename, "toma_proj") || issubstr(sweapon.basename, "artillery_mp");
}

function function_9da9c82aa52d0513(sparams) {
  var_e012ae5b74d203e4 = [%"energy_mine", %"tesla_storm", %"frost_blast"];

  if(isDefined(sparams.sweapon)) {
    foreach(field_upgrade in var_e012ae5b74d203e4) {
      if(isDefined(level.weaponmetadata[field_upgrade]) && isDefined(level.weaponmetadata[field_upgrade].weaponobj) && level.weaponmetadata[field_upgrade].weaponobj == sparams.sweapon) {
        return true;
      }
    }
  }

  return false;
}