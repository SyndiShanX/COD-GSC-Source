/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\weapon_utility.gsc
****************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace weapon_utility;

function _magicbullet(objweapon, start, end, owner, event_ent) {
  assertex(!isstring(objweapon), "<dev string:x1c>");
  missile = magicbullet(objweapon, start, end, owner, event_ent);

  if(isDefined(missile) && isDefined(owner)) {
    missile setotherent(owner);
  }

  return missile;
}

function islockonlauncher(objweapon) {
  islockon = undefined;
  basename = undefined;

  if(isstring(objweapon)) {
    basename = objweapon;
  } else {
    basename = objweapon.basename;
  }

  switch (basename) {
    case #"hash_13a265ac820ea0df":
    case #"hash_3e782fd775b72022":
    case #"hash_5c272c0617caebf0":
    case #"hash_5cbb3a1a84d47f1d":
    case #"hash_6b9700922cc910a9":
    case #"hash_a9e31b8ffd42a67b":
      islockon = 1;
      break;
    default:
      islockon = 0;
      break;
  }

  return islockon;
}

function addlockedon(entity, attacker) {
  if(!isDefined(entity.islockedon)) {
    entity.islockedon = 0;
    entity.attackerslockedon = [];
  }

  if(entity.islockedon == 0) {
    if(isDefined(entity.lockedoncallback)) {
      entity thread[[entity.lockedoncallback]]();
    }
  }

  if(isDefined(attacker)) {
    assertex(!isDefined(attacker.entlockedonto), "<dev string:x5f>");
    attacker.entlockedonto = entity;
    assertex(!isDefined(entity.attackerslockedon[attacker getentitynumber()]), "<dev string:xb1>");
    entity.attackerslockedon[attacker getentitynumber()] = attacker;

    if(isPlayer(attacker)) {
      attacker callsharedfunc("game", "clearSpawnProtection");
    }
  }

  entity.islockedon++;
}

function removelockedon(entity, attacker) {
  if(!isDefined(entity.islockedon)) {
    return;
  }

  assert(islockedonto(entity), "<dev string:x100>");

  if(entity.islockedon == 1) {
    if(isDefined(entity.lockedonremovedcallback)) {
      entity thread[[entity.lockedonremovedcallback]]();
    }
  }

  if(isDefined(attacker)) {
    if(isDefined(attacker.entlockedonto) && attacker.entlockedonto == entity) {
      attacker.entlockedonto = undefined;
    }

    entity.attackerslockedon[attacker getentitynumber()] = undefined;
  }

  entity.islockedon--;
}

function setlockedoncallback(entity, lockedoncallback) {
  entity.lockedoncallback = lockedoncallback;
}

function setlockedonremovedcallback(entity, lockedonremovedcallback) {
  entity.lockedonremovedcallback = lockedonremovedcallback;
}

function clearlockedon(entity) {
  entity notify("clearLockedOn");

  if(islockedonto(entity)) {
    if(isDefined(entity.lockedonremovedcallback)) {
      entity thread[[entity.lockedonremovedcallback]]();
    }

    foreach(attacker in entity.attackerslockedon) {
      if(isDefined(attacker)) {
        if(isDefined(attacker.entlockedonto) && attacker.entlockedonto == entity) {
          attacker.entlockedonto = undefined;
        }
      }
    }
  }

  entity.islockedon = undefined;
  entity.attackerslockedon = undefined;
  entity.lockedoncallback = undefined;
  entity.lockedonremovedcallback = undefined;

  if(hasincoming(entity)) {
    if(isDefined(entity.incomingremovedcallback)) {
      entity thread[[entity.incomingremovedcallback]]();
    }
  }

  entity.hasincoming = undefined;
  entity.incomingcallback = undefined;
  entity.incomingremovedcallback = undefined;
}

function clearlockedonondisconnect(player) {
  if(isDefined(self.entlockedonto)) {
    removelockedon(self.entlockedonto, self);
  }

  self.entlockedonto = undefined;
}

function islockedonto(entity) {
  return isDefined(entity.islockedon) && entity.islockedon > 0;
}

function isinflictorstucktoplayer(inflictor, victim, equipref) {
  if(isDefined(inflictor)) {
    if(isDefined(inflictor.equipmentref) && isDefined(equipref) && inflictor.equipmentref != equipref) {
      return false;
    }

    if(isDefined(inflictor.stuckto) && inflictor.stuckto == victim) {
      return true;
    }
  }

  return false;
}

function function_605b121f1fadd46c(allowed) {
  self.var_605b121f1fadd46c = allowed;
}

function ismissilelauncherlockonallowed() {
  if(isDefined(self.var_605b121f1fadd46c)) {
    return self.var_605b121f1fadd46c;
  }

  return 1;
}

function hasbunkerbustersattached(entity) {
  return isDefined(entity.bunkerbustersattached) && entity.bunkerbustersattached.size > 0;
}

function function_53fd22613ea65204(entity, var_5ec2da3d1d27e716) {
  entity.var_5ec2da3d1d27e716 = var_5ec2da3d1d27e716;
}

function function_b55a664e824540d2(entity, var_218d5fb97d94f2c) {
  entity.var_218d5fb97d94f2c = var_218d5fb97d94f2c;
}

function function_69d45a21a6d4e9f8(entity, ownerteam) {
  if(!isDefined(entity.bunkerbustersattached)) {
    entity.bunkerbustersattached = [];
  }

  entity.bunkerbustersattached[entity.bunkerbustersattached.size] = ownerteam;

  if(isDefined(entity.var_5ec2da3d1d27e716)) {
    entity thread[[entity.var_5ec2da3d1d27e716]]();
  }
}

function function_28e583bfecc38a25(entity, ownerteam) {
  if(!isDefined(entity.bunkerbustersattached)) {
    return;
  }

  assert(hasbunkerbustersattached(entity), "<dev string:x13f>");
  teams = entity.bunkerbustersattached;
  entity.bunkerbustersattached = [];
  removed = 0;

  foreach(team in teams) {
    if(!removed && team == ownerteam) {
      removed = 1;
      continue;
    }

    entity.bunkerbustersattached[entity.bunkerbustersattached.size] = team;
  }

  if(entity.bunkerbustersattached.size == 0) {
    entity.bunkerbustersattached = undefined;
  }

  if(isDefined(entity.var_218d5fb97d94f2c)) {
    entity thread[[entity.var_218d5fb97d94f2c]]();
  }
}

function addincoming(entity) {
  if(!isDefined(entity.hasincoming)) {
    entity.hasincoming = 0;
  }

  if(entity.hasincoming == 0) {
    if(isDefined(entity.incomingcallback)) {
      entity thread[[entity.incomingcallback]]();
    }
  }

  entity.hasincoming++;
}

function removeincoming(entity) {
  if(!isDefined(entity.hasincoming)) {
    return;
  }

  assert(hasincoming(entity), "<dev string:x19c>");

  if(entity.hasincoming == 1) {
    if(isDefined(entity.incomingremovedcallback)) {
      entity thread[[entity.incomingremovedcallback]]();
    }
  }

  entity.hasincoming--;
}

function giveandfireoffhandreliable(objweapon) {
  self endon("death");
  self endon("disconnect");
  heldoffhand = scripts\cp_mp\weapon::getgrenadeinpullback();

  if(isDefined(heldoffhand) && !isnullweapon(heldoffhand)) {
    return 0;
  }

  assert(isweapon(objweapon), "<dev string:x1df>");

  if(!isweapon(objweapon)) {
    if(isstring(objweapon)) {
      objweapon = makeweapon(objweapon);
    }
  }

  if(!isweapon(objweapon)) {
    self notify("giveAndFireOffhandReliableFailed", objweapon);
    return 0;
  }

  self giveandfireoffhand(objweapon);

  if(!self hasweapon(objweapon)) {
    self notify("giveAndFireOffhandReliableFailed", objweapon);
    return 0;
  }

  result = spawnStruct();
  result childthread function_8ea8b6459d144947(self, objweapon);
  result childthread function_158897145d2efb26(self, objweapon);
  result waittill("race_start");
  waittillframeend();
  result notify("race_end");

  if(istrue(result.success)) {
    self notify("giveAndFireOffhandReliableSucceeded", objweapon);
    return 1;
  }

  if(istrue(result.failure)) {
    self notify("giveAndFireOffhandReliableFailed", objweapon);
    return 0;
  }
}

function function_8ea8b6459d144947(player, objweapon) {
  self endon("race_end");
  player waittillmatch("offhand_fired", objweapon);
  self.success = 1;
  self notify("race_start");
}

function function_158897145d2efb26(player, objweapon) {
  self endon("race_end");
  timeelapsed = 0;

  while(player hasweapon(objweapon) && timeelapsed < 5) {
    waitframe();
    timeelapsed += level.framedurationseconds;
  }

  if(player hasweapon(objweapon)) {
    player takeweapon(objweapon);
  }

  self.failure = 1;
  self notify("race_start");
}

function setincomingcallback(entity, incomingcallback) {
  entity.incomingcallback = incomingcallback;
}

function setincomingremovedcallback(entity, incomingremovedcallback) {
  entity.incomingremovedcallback = incomingremovedcallback;
}

function hasincoming(entity) {
  return isDefined(entity.hasincoming) && entity.hasincoming > 0;
}

function watchtargetlockedontobyprojectile(target, projectile) {
  target endon("clearLockedOn");
  addlockedon(target);
  addincoming(target);
  projectile waittill_any_2("death", "clearTargetLockedOntoByProjectile");

  if(isDefined(target)) {
    removelockedon(target);
    removeincoming(target);
  }
}

function clearprojectilelockedon(projectile) {
  projectile notify("clearTargetLockedOntoByProjectile");
}

function dropweaponfordeathlaunch(item, weapongroup, damage, angles) {
  if(item physics_getnumbodies() == 0) {
    return;
  }

  if(!isDefined(angles)) {
    angles = self.angles;
  }

  if(!isDefined(damage)) {
    damage = 0;
  }

  normalizeddamage = math::normalize_value(0, 200, damage);

  if(isDefined(weapongroup) && weapongroup == "weapon_melee2") {
    var_4148f5f633bfcf19 = randomfloatrange(25, 100);
    var_5de19bfa9bb86f0c = randomfloatrange(75, 175);
    var_b8a13f3af0cbe01b = math::factor_value(450, 800, normalizeddamage);
    var_eac2b0512d0b1c55 = math::factor_value(-7 / 6, -5 / 6, normalizeddamage);
    var_8282854ec42283a2 = math::factor_value(0.125, 0.183333, normalizeddamage);
  } else if(isDefined(weapongroup) && weapongroup == "weapon_pistol") {
    var_4148f5f633bfcf19 = randomfloatrange(100, 200);
    var_5de19bfa9bb86f0c = randomfloatrange(150, 250);
    var_b8a13f3af0cbe01b = math::factor_value(950, 1300, normalizeddamage);
    var_eac2b0512d0b1c55 = math::factor_value(-7 / 4, -5 / 4, normalizeddamage);
    var_8282854ec42283a2 = math::factor_value(0.5625, 0.825, normalizeddamage);
  } else {
    var_4148f5f633bfcf19 = randomfloatrange(150, 350);
    var_5de19bfa9bb86f0c = randomfloatrange(150, 250);
    var_b8a13f3af0cbe01b = math::factor_value(950, 1300, normalizeddamage);
    var_eac2b0512d0b1c55 = math::factor_value(-7, -5, normalizeddamage);
    var_8282854ec42283a2 = math::factor_value(0.75, 1.1, normalizeddamage);
  }

  if(cointoss()) {
    var_5de19bfa9bb86f0c *= -1;
  }

  if(!isDefined(item)) {
    println("<dev string:x218>");
    return;
  }

  itemcenterofmass = item physics_getentitycenterofmass();

  if(isDefined(itemcenterofmass)) {
    itemcenterofmass = itemcenterofmass["unscaled"];
  } else {
    itemcenterofmass = item.origin;
  }

  launchvelocity = (0, 0, 0);
  launchvelocity += anglesToForward(angles) * var_4148f5f633bfcf19;
  launchvelocity += anglestoright(angles) * var_5de19bfa9bb86f0c;
  launchvelocity += anglestoup(angles) * var_b8a13f3af0cbe01b;
  weaponangles = item gettagangles("tag_flash", 1);

  if(!isDefined(weaponangles)) {
    weaponangles = item.angles;
  }

  if(cointoss()) {
    var_8282854ec42283a2 *= -1;
  }

  launchorigin = itemcenterofmass;
  launchorigin += anglesToForward(weaponangles) * var_eac2b0512d0b1c55;
  launchorigin += anglestoright(weaponangles) * var_8282854ec42283a2;
  logprint("PhysicsLaunchServerItem");
  logprint("item.classname = " + item.classname);
  logprint("launchOrigin = " + launchorigin);
  logprint("launchVelocity = " + launchvelocity);
  item physicslaunchserveritem(launchorigin, launchvelocity);
}

function isbulletweapon(weapon) {
  if(!isDefined(weapon)) {
    assertmsg("<dev string:x251>");
    return 0;
  }

  if(isweapon(weapon) && isnullweapon(weapon)) {
    return 0;
  }

  if(isstring(weapon) && weapon == "none") {
    return 0;
  }

  if(isriotshield(weapon) || isknifeonly(weapon)) {
    return 0;
  }

  if(isDefined(weapon.inventorytype) && weapon.inventorytype == "model_only") {
    return 0;
  }

  switch (weaponclass(weapon)) {
    case #"hash_690c0d6a821b42e":
    case #"hash_6191aaef9f922f96":
    case #"hash_719417cb1de832b6":
    case #"hash_8cdaf2e4ecfe5b51":
    case #"hash_900cb96c552c5e8e":
    case #"hash_fa24dff6bd60a12d":
      return 1;
    default:
      return 0;
  }
}

function islauncherweapon(weapon) {
  if(!isDefined(weapon)) {
    assertmsg("<dev string:x293>");
    return false;
  }

  if(isweapon(weapon) && isnullweapon(weapon)) {
    return false;
  }

  if(isstring(weapon) && weapon == "none") {
    return false;
  }

  if(isriotshield(weapon) || isknifeonly(weapon)) {
    return false;
  }

  if(isDefined(weapon.inventorytype) && weapon.inventorytype == "model_only") {
    return false;
  }

  if(!isDefined(weapon.basename)) {
    return false;
  }

  weaponstrtok = strtok(weapon.basename, "_");

  if(isDefined(weaponstrtok) && array_contains(weaponstrtok, "la")) {
    return true;
  }

  return false;
}

function function_38642db3c423bcdc(weapon) {
  if(getdvarint(@ "hash_86c5f9dae77ee49e", 1) == 0) {
    return false;
  }

  var_1bae199ae2509f57 = ["riotshield", "iw9_me_riotshield_mp", "iw9_la_juliet_mp", "iw9_la_gromeo_mp", "iw9_me_sword01_mp", "iw9_me_kamas_mp"];

  if(isweapon(weapon) && isnullweapon(weapon)) {
    return false;
  }

  if(isstring(weapon) && weapon == "none") {
    return false;
  }

  theweapontype = weapon.basename;

  if(scripts\cp_mp\weapon::isakimbo(weapon)) {
    return true;
  }

  theweapontype = weapon.basename;

  for(i = 0; i < var_1bae199ae2509f57.size; i++) {
    if(var_1bae199ae2509f57[i] == theweapontype) {
      return true;
    }
  }

  return false;
}

function isriotshield(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon)) {
    return false;
  }

  if(isstring(weapon) && weapon == "none") {
    return false;
  }

  return weapontype(weapon) == "riotshield";
}

function isknifeonly(weapon) {
  rootname = scripts\cp_mp\weapon::getweaponrootname(weapon);
  isknife = scripts\cp_mp\weapon::function_b8811a0fc04e4b9d(rootname, #"isknife", 0);
  var_5e65eddfd622acca = isDefined(weapon) && isweapon(weapon) ? weapon.basename : undefined;
  return isknife || rootname == "iw9_me_knife" || rootname == "jup_jp23_me_knife" || rootname == "iw9_knifestab" || isDefined(var_5e65eddfd622acca) && var_5e65eddfd622acca == "jup_amp_knifestab_mp";
}

function issharpmeleeweapon(weapon) {
  if(!isDefined(weapon) || !isDefined(weapon.basename)) {
    return false;
  }

  basename = weapon.basename;
  rootname = scripts\cp_mp\weapon::getweaponrootname(weapon);
  issharpmelee = scripts\cp_mp\weapon::function_b8811a0fc04e4b9d(rootname, #"hash_dde08416ce76e9f9", 0);
  return issharpmelee || basename == "iw9_me_knife_mp" || basename == "iw9_knifestab_mp" || basename == "iw9_me_sword01_mp";
}

function ischainsword(weapon) {
  if(!isDefined(weapon)) {
    assertmsg("<dev string:x2d7>");
    return 0;
  }

  weapname = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon)) {
      return 0;
    }

    weapname = weapon.basename;
  } else {
    if(weapon == "none") {
      return 0;
    }

    weapname = weapon;
  }

  return issubstr(weapname, "me_swhiskey");
}

function saveweaponstates() {
  if(scripts\engine\utility::issharedfuncdefined("weapons", "saveToggleScopeStates")) {
    self[[scripts\engine\utility::getsharedfunc("weapons", "saveToggleScopeStates")]]();
  }

  if(scripts\engine\utility::issharedfuncdefined("weapons", "saveAltStates")) {
    self[[scripts\engine\utility::getsharedfunc("weapons", "saveAltStates")]]();
  }
}

function restoreweaponstates(lastweaponobj, updatetogglescopestate) {
  if(self isalternatemode(lastweaponobj)) {
    if(scripts\engine\utility::issharedfuncdefined("weapons", "updateSavedAltState")) {
      lastweaponobj = self[[scripts\engine\utility::getsharedfunc("weapons", "updateSavedAltState")]](lastweaponobj);
    }
  }

  if(updatetogglescopestate && scripts\engine\utility::issharedfuncdefined("weapons", "updateToggleScopeState")) {
    self[[scripts\engine\utility::getsharedfunc("weapons", "updateToggleScopeState")]](lastweaponobj);
  }

  return lastweaponobj;
}

function function_c9e5c511b923a42f(idamage, attacker, victim, smeansofdeath, shitloc, inflictor, vpoint, lightarmordamage, heavyarmordamage, helmetdamage) {
  if(isDefined(level.var_b39eda08d7912835)) {
    distmsg = "";

    if(isexplosivedamagemod(smeansofdeath) && isDefined(victim.origin)) {
      dmgorigin = vpoint;

      if(isDefined(inflictor) && isDefined(inflictor.origin)) {
        dmgorigin = inflictor.origin;
      }

      distmsg = " EXPL_DIST: " + int(distance(dmgorigin, victim.origin));
    } else if(isDefined(vpoint)) {
      distmsg = " DIST:" + int(distance(attacker.origin, vpoint));
    }

    armormsg = "";

    if(isDefined(lightarmordamage) && lightarmordamage > 0) {
      armormsg = " ArmorDmg: " + lightarmordamage;
    } else if(isDefined(heavyarmordamage) && heavyarmordamage > 0) {
      armormsg = " ArmorDmg: " + heavyarmordamage;
    }

    helmetmsg = "";

    if(isDefined(helmetdamage) && helmetdamage > 0) {
      helmetmsg = " HelmetDmg: " + helmetdamage;
    }

    victimtext = ter_op(isai(victim), "AI-", "Plyr-");
    iprintln(victimtext + "DMG:" + idamage + " LOC:" + shitloc + " HEALTH: " + victim.health + "/" + victim.maxhealth + distmsg + armormsg + helmetmsg);
  }
}

function function_eeaa22f0cd1ff845(weaponstring) {
  attachments = getweapondefaultattachments(weaponstring);
  weaponobj = makeweapon(weaponstring, attachments);
  return weaponobj;
}

function function_8cda2444c7d142df() {
  if(isagent(self)) {
    cachevalue = "ai_" + self getentitynumber();
  } else {
    cachevalue = self.guid;
  }

  return cachevalue;
}

function function_49967318fbd12317(objweapon, var_76b470a332915556) {
  if(!isDefined(level.var_b5224f533f8fffb0)) {
    level.var_b5224f533f8fffb0 = [];
  }

  if(!array_contains_key(level.var_b5224f533f8fffb0, objweapon.basename)) {
    weaponowners = [];
    level.var_b5224f533f8fffb0[objweapon.basename] = weaponowners;
  }

  level.var_b5224f533f8fffb0[objweapon.basename][self.guid] = var_76b470a332915556;
  thread function_820fe7d9e7ec7c65(objweapon);
}

function function_820fe7d9e7ec7c65(objweapon) {
  note = "removeWeaponParent_" + objweapon.basename;
  self notify(note);
  self endon(note);
  uniqueid = self.guid;
  wait 12;
  level.var_b5224f533f8fffb0[objweapon.basename] = array_remove_key(level.var_b5224f533f8fffb0[objweapon.basename], uniqueid);
}

function function_1e3102980c3a4cc1(objweapon) {
  weaponname = undefined;

  if(isweapon(objweapon)) {
    weaponname = objweapon.basename;
  } else {
    assert(isstring(objweapon));
    weaponname = objweapon;
  }

  if(!isDefined(weaponname)) {
    return objweapon;
  }

  if(isDefined(level.var_b5224f533f8fffb0) && array_contains_key(level.var_b5224f533f8fffb0, weaponname)) {
    if(!isDefined(level.var_b5224f533f8fffb0[weaponname][self.guid])) {
      assertmsg("<dev string:x318>" + weaponname + "<dev string:x353>");
    }

    return level.var_b5224f533f8fffb0[weaponname][self.guid];
  }

  return objweapon;
}

function function_c14e8044664565ad(objweapon) {
  weaponname = undefined;

  if(isweapon(objweapon)) {
    weaponname = objweapon.basename;
  } else if(isstring(objweapon)) {
    weaponname = objweapon;
  }

  if(!isDefined(weaponname)) {
    return false;
  }

  if(isDefined(level.var_b5224f533f8fffb0) && array_contains_key(level.var_b5224f533f8fffb0, weaponname)) {
    if(!isDefined(level.var_b5224f533f8fffb0[weaponname][self.guid])) {
      return false;
    } else {
      return true;
    }
  }

  return false;
}

function function_f0cf737b5d0ccda5(weapon) {
  weapname = getweaponbasename(weapon);
  result = issubstr(weapname, "sword01") || issubstr(weapname, "kamas") || issubstr(weapname, "pickaxe");
  return result;
}

function function_a3fc7ebc9fc3e9a3(eattacker, victim, idflags) {
  hand = function_88e9e2299bd29fd1(idflags);
  victimentnum = function_d77e6b2580f74622(victim);

  if(isDefined(eattacker.pelletweaponvictimids) && isDefined(eattacker.pelletweaponvictimids[hand]) && isDefined(eattacker.pelletweaponvictimids[hand][victimentnum])) {
    return eattacker.pelletweaponvictimids[hand][victimentnum].var_7981f7d372990a2b;
  }

  return 0;
}

function function_88e9e2299bd29fd1(idflags) {
  if(idflags & 2048) {
    return "lHandWeap";
  }

  return "rHandWeap";
}

function function_d77e6b2580f74622(victim) {
  return "" + victim getentitynumber();
}

function function_1113fc99a0327d7d(eattacker, victim, idflags, idamage) {
  hand = function_88e9e2299bd29fd1(idflags);
  victimentnum = function_d77e6b2580f74622(victim);

  if(!isDefined(eattacker.pelletweaponvictimids) || !isDefined(eattacker.pelletweaponvictimids[hand]) || !isDefined(eattacker.pelletweaponvictimids[hand][victimentnum])) {
    return idamage;
  }

  var_52f16f4c9cdbf165 = eattacker.pelletweaponvictimids[hand][victimentnum].var_52f16f4c9cdbf165;
  var_9bb59738d095536e = eattacker.pelletweaponvictimids[hand][victimentnum].var_9bb59738d095536e;

  if(var_9bb59738d095536e < var_52f16f4c9cdbf165) {
    idamage = clamp(idamage, 0, var_52f16f4c9cdbf165 - eattacker.pelletweaponvictimids[hand][victimentnum].var_9bb59738d095536e);
    eattacker.pelletweaponvictimids[hand][victimentnum].var_9bb59738d095536e += idamage;
    return idamage;
  }

  return 0;
}

function function_ad15087050f05b04(eattacker, victim, idflags, idamage) {
  hand = function_88e9e2299bd29fd1(idflags);
  victimentnum = function_d77e6b2580f74622(victim);

  if(!isDefined(eattacker.pelletweaponvictimids) || !isDefined(eattacker.pelletweaponvictimids[hand]) || !isDefined(eattacker.pelletweaponvictimids[hand][victimentnum])) {
    return;
  }

  eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed[0] = idamage;
}

function function_9665cbeba4d776f7(eattacker, victim, idflags, amount) {
  hand = function_88e9e2299bd29fd1(idflags);
  victimentnum = function_d77e6b2580f74622(victim);

  if(!isDefined(eattacker.pelletweaponvictimids) || !isDefined(eattacker.pelletweaponvictimids[hand]) || !isDefined(eattacker.pelletweaponvictimids[hand][victimentnum])) {
    return 0;
  }

  eattacker.pelletweaponvictimids[hand][victimentnum].var_9bb59738d095536e += amount;
}

function cleanupconcussionstun(time) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait time;
  utility::setplayerunstunned();
  self notify("concussion_unstunned");
}

function isaxeweapon(weapon) {
  if(!isDefined(weapon)) {
    assertmsg("<dev string:x3d8>");
    return false;
  }

  rootname = getweaponrootname(weapon);
  return rootname == "iw7_axe" || rootname == "jup_jp23_me_spear";
}