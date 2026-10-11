/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_24fbedba9a7a1ef4.gsc
*************************************************/

#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_collision;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_965527752cbd4cca;

function callbacksoldieragentdamaged(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(isDefined(self.var_970170ffd4b081ac)) {
    idamage = self[[self.var_970170ffd4b081ac]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
  }

  if(isDefined(self.callbackdamaged)) {
    [[self.callbackdamaged]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
    return;
  }

  function_dffac413ed66bcd0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

function function_34672e1ee2e90cf8(objweapon, idamage) {
  if(!isDefined(objweapon)) {
    return idamage;
  }

  class = weaponclass(objweapon);

  if(isDefined(class) && class == "spread") {
    idamagemax = getdvarint(@ "hash_877c52caf0f9aa8c", 35);
    idamage = int(min(idamage, idamagemax));
  }

  return idamage;
}

function function_dffac413ed66bcd0(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  evictim = self;
  initial_damage = idamage;
  armordelta = 0;
  helmetdelta = 0;
  shouldoneshot = function_b8c245105cc37f9e(objweapon);
  unmodifieddamage = idamage;

  if(function_62213f6e7b9da1e7(evictim, eattacker, einflictor, smeansofdeath)) {
    return;
  }

  if(!function_84a1aec445b03580(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon)) {
    return;
  }

  if(handleriotshielddamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon)) {
    return;
  }

  if(smeansofdeath == "MOD_TRIGGER_HURT") {
    if(isDefined(eattacker) && eattacker.spawnflags & 2) {
      return;
    }
  }

  isplayerdamage = isDefined(eattacker) && isPlayer(eattacker);
  var_7543d4fe49c53684 = isDefined(eattacker) && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  isplayervehicle = isDefined(eattacker) && isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
  isplayervehicledamage = isplayervehicle && smeansofdeath == "MOD_CRUSH";

  if(isDefined(evictim.forcehitlocation)) {
    shitloc = evictim.forcehitlocation;
    evictim.forcehitlocation = undefined;
  }

  if(isplayervehicledamage) {
    rangeauto = getdvarfloat(@ "hash_e58868d4f3626e25", 500);
    rangesight = getdvarfloat(@ "hash_4ca14712d81d0747", 1500);

    if(isDefined(self.stealth)) {
      if(isDefined(self.stealth.override_damage_auto_range)) {
        rangeauto = self.stealth.override_damage_auto_range;
      } else if(isDefined(level.stealth.override_damage_auto_range)) {
        rangeauto = level.stealth.override_damage_auto_range;
      }

      if(isDefined(self.stealth.override_damage_sight_range)) {
        rangesight = self.stealth.override_damage_sight_range;
      } else if(isDefined(level.stealth.override_damage_sight_range)) {
        rangesight = level.stealth.override_damage_sight_range;
      }
    }

    if(idamage >= self.health) {
      stealtheventbroadcast("ally_killed", self, eattacker.owner, rangeauto, rangesight);
    }

    if(iscp() && soundexists("vehicle_body_hit")) {
      playsoundatpos(self.origin, "vehicle_body_hit");
    }
  }

  if(scripts\engine\utility::issharedfuncdefined("player", "gulagTrackPlayerBulletHitAI")) {
    [[scripts\engine\utility::getsharedfunc("player", "gulagTrackPlayerBulletHitAI")]](eattacker, idamage);
  }

  if(smeansofdeath == "MOD_CRUSH" && isDefined(einflictor) && isDefined(einflictor.var_746334c2ac85aacc)) {
    idamage = einflictor.var_746334c2ac85aacc;
  }

  if(getdvarint(@ "hash_f40118cb927a0802", 0) == 1) {
    idamage = function_34672e1ee2e90cf8(objweapon, idamage);
  }

  headshot = scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker);

  if(smeansofdeath == "MOD_MELEE") {
    specialmelee = 0;

    if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "iw9_me_buzzsaw_mp") {
      specialmelee = 1;
    }

    if(!specialmelee) {
      idamage = int(min(idamage, 135));
    }
  } else if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(objweapon) && isDefined(objweapon.basename) && (objweapon.basename == "throwingknife_mp" || objweapon.basename == "throwingknife_cp" || objweapon.basename == "shuriken_mp" || objweapon.basename == "throwstar_mp")) {
    shouldoneshot = istrue(self.var_685390c6753c2cc7);
    var_66efe6ff4098c684 = istrue(self.var_282d867559c07771);

    if(iscp()) {
      var_b656251147d7d40b = isDefined(partname) && scripts\cp_mp\utility\damage_utility::function_b656251147d7d40b(partname);

      if(shouldoneshot || var_66efe6ff4098c684 && (istrue(headshot) || istrue(var_b656251147d7d40b))) {
        idamage = self.health;
      } else if(var_66efe6ff4098c684) {
        idamage = int(self.maxhealth / 2);
      } else {
        idamage = 400;
      }
    } else {
      idamage = ter_op(shouldoneshot, int(max(400, self.health + self.armorhealth)), 400);

      if(var_66efe6ff4098c684) {
        idamage = ter_op(var_66efe6ff4098c684, int(max(400, self.health / 2 + self.armorhealth / 2)), 400);
      }
    }
  }

  if(isexplosivedamagemod(smeansofdeath)) {
    if(issharedfuncdefined("thermobaric_grenade", "thermobaric_additional_explosive_damage")) {
      idamage += [[getsharedfunc("thermobaric_grenade", "thermobaric_additional_explosive_damage")]](evictim, eattacker, idamage);
    }
  }

  if(!headshot && isDefined(self.armorhealth) && self.armorhealth > 0 && smeansofdeath != "MOD_CRUSH" && (!isDefined(self.var_f8ecc64162438d76) || !array_contains(self.var_f8ecc64162438d76, einflictor))) {
    [idamage, lightarmordamage] = scripts\cp_mp\armor::function_90ce8eb3ddaa4943(eattacker, einflictor, evictim, idamage, objweapon, smeansofdeath, shitloc, idflags, initial_damage, unmodifieddamage);
    armordelta = lightarmordamage;

    if(iscp() && damage_isexplosive(smeansofdeath) && idamage <= 0 && !istrue(self.var_c7b10080abf06d59)) {
      armordelta = self.armorhealth;

      if(idamage <= 0) {
        scripts\cp_mp\armor::breakarmor();
        self notify("flashbang", (0, 0, 0), 1, 1, eattacker);
      }
    }

    if(idamage <= 0) {
      idamage = 1;
      self.health += 1;
    }
  }

  if(headshot && smeansofdeath != "MOD_CRUSH" && !scripts\cp_mp\utility\damage_utility::function_cb9ba92488b23c5(objweapon)) {
    hashelmet = istrue(self.helmethealth) && self.helmethealth > 0;

    if(hashelmet) {
      if(istrue(self.var_895dae193cfaac3a)) {
        helmetdelta = idamage;
        scripts\cp_mp\armor::function_e71f062243ea8827(idamage, 0, eattacker);
        idamage = 1;
        self.health += 1;
      } else {
        helmetdelta = 1;
        var_798ca175be748e74 = 0;

        if(!istrue(self.var_ef3bfd0243258e2f)) {
          if(scripts\common\utility::getdamagetype(smeansofdeath) == "splash") {
            var_798ca175be748e74 = 1;
          }

          if((sweapon.classname == "sniper" || sweapon.classname == "dmr") && idamage > 1000 || sweapon.classname == "turret") {
            if(self.helmethealth == 1) {
              var_798ca175be748e74 = 1;
            }

            helmetdelta = self.helmethealth;
          }
        }

        if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "iw9_dm_crossbow_mp" && iscp()) {
          var_798ca175be748e74 = 1;
          shouldoneshot = 1;
        }

        scripts\cp_mp\armor::function_e71f062243ea8827(helmetdelta, 0, eattacker);

        if(!istrue(var_798ca175be748e74)) {
          idamage = 1;
          self.health += 1;
        }
      }
    }
  }

  if(armordelta == 0 && helmetdelta == 0 && isbulletdamage(smeansofdeath) && scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker)) {
    idamage = int(max(idamage, self.health));
  }

  if(shouldoneshot) {
    idamage = self.health;
  }

  if(scripts\engine\utility::issharedfuncdefined("relics", "modify_agent_damage")) {
    idamage = self[[scripts\engine\utility::getsharedfunc("relics", "modify_agent_damage")]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
  }

  armorhit = armordelta > 0;
  helmethit = helmetdelta > 0;

  if(armorhit || helmethit) {
    idflags |= 512;
  }

  if(getdvarint(@ "scr_agent_hitmarkers", 1) == 1) {
    lightarmordamage = armordelta + helmetdelta;
    heavyarmordamage = 0;
    iskillstreakweapon = 0;

    if(scripts\engine\utility::issharedfuncdefined("ai_mp_controller", "handleDamageFeedback")) {
      var_974fefea31f1fabe = scripts\engine\utility::getsharedfunc("ai_mp_controller", "handleDamageFeedback");
      [[var_974fefea31f1fabe]](einflictor, eattacker, self, idamage, smeansofdeath, objweapon, shitloc, idflags, lightarmordamage, heavyarmordamage, iskillstreakweapon);
    }
  }

  scripts\cp_mp\utility\weapon_utility::function_c9e5c511b923a42f(idamage, eattacker, evictim, smeansofdeath, shitloc, einflictor, vpoint, armordelta, undefined, helmetdelta);

  idamage = int(idamage);

  if(utility::getdamagetype(smeansofdeath) == "splash") {
    idamage *= 2;
  }

  if(istrue(evictim.gulagjailer)) {
    var_2d776dde0a657b53 = idamage + armordelta;
    self function_136d20776df768d2(var_2d776dde0a657b53, eattacker, vdir, vpoint);

    if(isDefined(level.var_c0f958f7943f0cde)) {
      evictim[[level.var_c0f958f7943f0cde]](var_2d776dde0a657b53);
    }
  }

  if(isplayerdamage || var_7543d4fe49c53684 || isplayervehicledamage) {
    if(isDefined(objweapon)) {
      attacker = eattacker;

      if(var_7543d4fe49c53684) {
        attacker = eattacker.owner;
      }

      attacker.pers["lastDamageTime"] = gettime();

      if(isDefined(level.var_238d7505b0146b84)) {
        [[level.var_238d7505b0146b84]](self, attacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, timeoffset, smeansofdeath);
      }

      if(issharedfuncdefined("player", "checkHit")) {
        attacker thread[[getsharedfunc("player", "checkHit")]](objweapon, evictim, shitloc, idamage);
      }

      if(isPlayer(attacker)) {
        fullweaponstring = getcompleteweaponname(objweapon);
        var_ba9dc00e6d5896dc = int(min(idamage, self.health));

        if(scripts\engine\utility::issharedfuncdefined("weaponstats", "threadedSetWeaponStatByName")) {
          attacker thread[[scripts\engine\utility::getsharedfunc("weaponstats", "threadedSetWeaponStatByName")]](fullweaponstring, var_ba9dc00e6d5896dc, "damage", self);
        }
      }
    }
  }

  if(istrue(evictim.agentdamagefeedback)) {
    biskillstreakweapon = 0;

    if(scripts\engine\utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
      biskillstreakweapon = isDefined(objweapon) && [[scripts\engine\utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](objweapon.basename);

      if(scripts\engine\utility::issharedfuncdefined("damage", "handleDamageFeedback")) {
        eattacker[[scripts\engine\utility::getsharedfunc("damage", "handleDamageFeedback")]](einflictor, eattacker, evictim, idamage, smeansofdeath, objweapon, shitloc, idflags, 0, 0, biskillstreakweapon);
      }
    }
  }

  if(isDefined(sweapon) && !sweapon issilenced()) {
    agentpers_setagentpersdata(self, "lastNonSilencedDamageTime", gettime());
  }

  if(isbulletdamage(smeansofdeath) && isalive(evictim)) {
    addbattlechatternotify(evictim, undefined, "wounded");
  }

  if(scripts\engine\utility::issharedfuncdefined("damage", "process_events_and_challenges_on_death")) {
    self[[scripts\engine\utility::getsharedfunc("damage", "process_events_and_challenges_on_death")]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
  }

  if(getdvarint(@ "g_debugdamage") != 0) {
    if(idamage != initial_damage) {
      println("<dev string:x1c>" + idamage);
    }
  }

  if(getdvarint(@ "hash_81d89e4abec64203", 0) != 0) {
    dmg_data = [];
    dmg_data["<dev string:x30>"] = einflictor;
    dmg_data["<dev string:x3b>"] = eattacker;
    dmg_data["<dev string:x45>"] = idamage;
    dmg_data["<dev string:x4d>"] = smeansofdeath;
    dmg_data["<dev string:x5b>"] = sweapon;
    dmg_data["<dev string:x63>"] = vpoint;
    dmg_data["<dev string:x6a>"] = vdir;
    dmg_data["<dev string:x6f>"] = shitloc;
    dmg_data["<dev string:x77>"] = objweapon;
    dmg_data["<dev string:x81>"] = partname;
    scripts\common\debug::function_8245dce28f1f395c(dmg_data, initial_damage, 1);
  }

  if(isDefined(evictim.unittype) && isDefined(level.agent_funcs[evictim.unittype]) && isDefined(level.agent_funcs[evictim.unittype]["on_damaged_finished"])) {
    evictim[[level.agent_funcs[evictim.unittype]["on_damaged_finished"]]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname, armorhit);
    return;
  }

  assert(isDefined(level.agent_funcs[evictim.agent_type]["on_damaged_finished"]));
  evictim[[level.agent_funcs[evictim.agent_type]["on_damaged_finished"]]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname, armorhit);
}

function damage_isexplosive(smeansofdeath) {
  if(!isDefined(smeansofdeath)) {
    return 0;
  }

  switch (smeansofdeath) {
    case #"hash_3c20f39c73a1422b":
    case #"hash_571e46e17a3cf2e3":
    case #"hash_66cb246f3e55fbe2":
    case #"hash_a911a1880d996edb":
    case #"hash_c22b13f81bed11f0":
      return 1;
    default:
      return 0;
  }
}

function function_62213f6e7b9da1e7(agent, attacker, inflictor, meansofdeath) {
  if(isDefined(attacker) && istrue(attacker.var_eb504fc7e1cfeb4c)) {
    return 0;
  }

  if(isDefined(inflictor) && istrue(inflictor.var_eb504fc7e1cfeb4c)) {
    return 0;
  }

  if(isDefined(attacker) && isDefined(agent) && isDefined(agent.team)) {
    if(isDefined(attacker.team) && attacker.team == agent.team) {
      return 1;
    }

    if(isDefined(attacker.owner) && isDefined(attacker.owner.team) && attacker.owner.team == agent.team) {
      return 1;
    }

    if(isDefined(attacker.vehicle) && isDefined(attacker.vehicle.team) && attacker.vehicle.team == agent.team) {
      return 1;
    }
  }

  if(isDefined(inflictor) && isDefined(agent) && isDefined(agent.team)) {
    if(isDefined(inflictor.team) && inflictor.team == agent.team) {
      return 1;
    }

    if(isDefined(inflictor.owner) && isDefined(inflictor.owner.team) && inflictor.owner.team == agent.team) {
      return 1;
    }

    if(isDefined(inflictor.vehicle) && isDefined(inflictor.vehicle.team) && inflictor.vehicle.team == agent.team) {
      return 1;
    }
  }

  if(scripts\engine\utility::issharedfuncdefined("threat_bias", "customFriendlyCheck")) {
    return [[scripts\engine\utility::getsharedfunc("threat_bias", "customFriendlyCheck")]](agent, attacker, inflictor, meansofdeath);
  }

  return 0;
}

function function_84a1aec445b03580(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  var_86c7c655ad6283d7 = isDefined(smeansofdeath) && smeansofdeath == "MOD_CRUSH" && isDefined(einflictor) && isent(einflictor) && einflictor scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle_collision::function_6eb1fba746b72f46(einflictor) < 3;
  var_663299b134fb78d = isDefined(self.origin) && isDefined(level.var_f0872e42daf6d4d5) && distancesquared(level.var_f0872e42daf6d4d5, self.origin) < 250000;
  var_abb16a8745308d16 = isPlayer(eattacker) && isDefined(sweapon.basename) && sweapon.basename == "iw9_pi_stimpistol_mp" && isbulletdamage(smeansofdeath);
  var_10effa490054d61e = isDefined(self.var_d9134148f9bb887) && isDefined(self.var_f39c6b01b1d95542) && gettime() >= self.var_f39c6b01b1d95542 && gettime() < self.var_d9134148f9bb887;
  return !istrue(self.invulnerable) && !var_86c7c655ad6283d7 && !var_663299b134fb78d && !var_abb16a8745308d16 && !var_10effa490054d61e;
}

function function_7d0d24665d72f13c(agent, attacker) {
  function_1920867ddf76810c(agent, 0);
}

function function_59ea6b2f800cb082(agent, attacker) {
  hidebone = "j_helmet_hide";
  function_1920867ddf76810c(agent, 0);

  if(agent.subclass == "tier2") {
    fx = getfx("vfx_gameplay_tier2_helmet_pop");
  } else {
    fx = getfx("vfx_gameplay_tier3_helmet_pop");
  }

  playFX(fx, agent gettagorigin("j_helmet"));

  if(!istrue(agent.var_668b72f41e87c75a)) {
    if(istrue(agent.var_895dae193cfaac3a) && !issubstr(agent.agent_type, "merc")) {
      agent setscriptablepartstate("helmet", "off");
      agent.helmetdamaged = undefined;
      agent.helmetbroken = 1;
      return;
    }

    if(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.var_55b13c315ab289c8)) {
      hidebone = level.gamemodebundle.var_55b13c315ab289c8;
    }

    if(agent hastag(agent.headmodel, hidebone)) {
      agent hidepart(hidebone, agent.headmodel);
    }
  }
}

function function_b8c245105cc37f9e(objweapon) {
  shouldoneshot = 0;
  overrideoneshot = getdvarint(@ "hash_a5eac9a0f544c3cf", 1);

  if(istrue(overrideoneshot)) {
    if(isDefined(objweapon) && isDefined(objweapon.basename)) {
      agenttier = agentpers_getagentpersdata(self, "tier");
      agentcategory = agentpers_getagentpersdata(self, "category");

      if(isDefined(agentcategory) && agentcategory != "bosses" && isDefined(agenttier)) {
        switch (objweapon.basename) {
          case #"hash_91a48ebfd2d03a40":
            shouldoneshot = 1;
            break;
        }
      }
    }
  }

  return shouldoneshot;
}

function handleriotshielddamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(!istrue(self.bhasriotshieldattached)) {
    return false;
  }

  if(isDefined(sweapon) && sweapon.basename == "super_laser_charge_mp") {
    self.forcehitlocation = "none";
    return false;
  }

  weaponbasename = objweapon.basename;
  bthermite = 0;

  if(isDefined(einflictor) && (issubstr(weaponbasename, "thermite") || isDefined(objweapon.magazine) && issubstr(objweapon.magazine, "boltfire") || isDefined(einflictor.weapon_name) && issubstr(einflictor.weapon_name, "incendiary"))) {
    bthermite = 1;
    var_35af7dae0105a3e3 = shitloc == "shield";

    if(var_35af7dae0105a3e3) {
      contents = scripts\engine\trace::create_character_contents();
      dirnormalized = vectorNormalize(vdir);
      startpos = vpoint - dirnormalized * 12;
      endpos = vpoint + dirnormalized * 12;
      results = scripts\engine\trace::ray_trace_detail(startpos, endpos, undefined, contents);

      if(results["fraction"] > 0 && results["fraction"] < 1) {
        metopoint = vpoint - self.origin;
        metopoint = (metopoint[0], metopoint[1], 0);

        if(vectordot(metopoint, results["normal"]) < 0) {
          var_35af7dae0105a3e3 = 0;
        }
      } else {
        var_35af7dae0105a3e3 = 0;
      }
    }

    if(var_35af7dae0105a3e3) {
      parent = einflictor getlinkedparent();

      if(isDefined(parent) && parent == self) {
        self.bhasthermitestucktoshield = 1;
        self.thermitestuckpains = 0;
      }
    } else if(shitloc != "none") {
      self.bhasthermitestucktoshield = 0;
      self.thermitestuckpains = undefined;
    }
  } else if(isDefined(einflictor) && issubstr(weaponbasename, "bunkerbuster")) {
    if(shitloc == "shield") {
      einflictor.riotshieldvictim = self;
      einflictor.riotshieldhit = 1;
    }
  }

  if(shitloc == "shield") {
    if(bthermite) {
      if(getdvarint(@ "g_debugdamage") != 0) {
        println("<dev string:x8a>");
      }

      return true;
    }
  } else if(shitloc == "none" && isDefined(einflictor)) {
    inflictorparent = einflictor getlinkedparent();

    if(self.bhasthermitestucktoshield && bthermite && isDefined(inflictorparent) && inflictorparent == self) {
      if(!isDefined(self.thermitestucktoshield)) {
        self.thermitestucktoshield = [einflictor];
      } else if(!array_contains(self.thermitestucktoshield, einflictor)) {
        self.thermitestucktoshield[self.thermitestucktoshield.size] = einflictor;
      }

      assert(isDefined(self.thermitestuckpains));

      if(getdvarint(@ "g_debugdamage") != 0) {
        println("<dev string:xa3>");
      }

      self.thermitestuckpains++;
      return true;
    } else if(issubstr(weaponbasename, "molotov")) {
      var_289cb9fcbd6aa7c8 = einflictor.origin - self.origin;
      var_8b5b7d7c1e6793de = vectorNormalize((var_289cb9fcbd6aa7c8[0], var_289cb9fcbd6aa7c8[1], 0));
      var_289cb9fcbd6aa7c8 = vectorNormalize(var_289cb9fcbd6aa7c8);

      if(vectordot(anglesToForward(self.angles), var_8b5b7d7c1e6793de) > 0.5 && -0.98 < var_289cb9fcbd6aa7c8[2] && var_289cb9fcbd6aa7c8[2] < 0.98) {
        if(getdvarint(@ "g_debugdamage") != 0) {
          println("<dev string:xc0>");
        }

        return true;
      }
    }
  }

  if(smeansofdeath == "MOD_MELEE") {
    if(isDefined(eattacker)) {
      metodamage = vectorNormalize(eattacker.origin - self.origin);
    } else {
      metodamage = vectorNormalize(vpoint - self.origin);
    }

    meforward = anglesToForward(self.angles);

    if(vectordot(meforward, metodamage) > 0.5) {
      if(getdvarint(@ "g_debugdamage") != 0) {
        println("<dev string:xe1>");
      }

      return true;
    }
  }

  return false;
}