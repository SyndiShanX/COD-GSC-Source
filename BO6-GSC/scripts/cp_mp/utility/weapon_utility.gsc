/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\weapon_utility.gsc
****************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace weapon_utility;

function _magicbullet(objweapon, start, end, owner, event_ent) {
  assert(!isstring(objweapon), "<dev string:x24>");
  missile = magicbullet(objweapon, start, end, owner, event_ent);

  if(isDefined(missile) && isDefined(owner)) {
    missile setotherent(owner);
  }

  return missile;
}

function islockonlauncher(objweapon) {
  if(!function_c1972d0d01397a22(objweapon)) {
    return 0;
  }

  return getweaponcanlockon(objweapon);
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
    assert(!isDefined(attacker.entlockedonto), "<dev string:x67>");
    attacker.entlockedonto = entity;
    assert(!isDefined(entity.attackerslockedon[attacker getentitynumber()]), "<dev string:xb9>");
    entity.attackerslockedon[attacker getentitynumber()] = attacker;

    if(isPlayer(attacker)) {
      attacker utility::callsharedfunc(#"game", #"hash_b59823ee25c7e338");
    }
  }

  entity.islockedon++;
}

function removelockedon(entity, attacker) {
  if(!isDefined(entity.islockedon)) {
    return;
  }

  assert(islockedonto(entity), "<dev string:x108>");

  if(entity.islockedon == 1) {
    if(isDefined(entity.lockedonremovedcallback)) {
      entity thread[[entity.lockedonremovedcallback]]();
    }
  }

  if(isDefined(attacker)) {
    if(attacker.entlockedonto == entity) {
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
        if(attacker.entlockedonto == entity) {
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
  return entity.islockedon > 0;
}

function isinflictorstucktoplayer(inflictor, victim, equipref) {
  if(isDefined(inflictor)) {
    if(isDefined(inflictor.equipmentref) && isDefined(equipref) && inflictor.equipmentref != equipref) {
      return false;
    }

    if(inflictor.stuckto == victim) {
      return true;
    }
  }

  return false;
}

function function_46f7fffc626f2e7b(allowed) {
  self.var_46f7fffc626f2e7b = allowed;
}

function isMissileLauncherLockOnAllowed() {
  if(isDefined(self.var_46f7fffc626f2e7b)) {
    return self.var_46f7fffc626f2e7b;
  }

  return 1;
}

function hasBunkerBustersAttached(entity) {
  return isDefined(entity.bunkerbustersattached) && entity.bunkerbustersattached.size > 0;
}

function function_3bb81d4e40d27159(entity, var_55a7086fe1e5fcdd) {
  entity.var_55a7086fe1e5fcdd = var_55a7086fe1e5fcdd;
}

function function_d6464586cc293251(entity, var_d9221ef5bff7298d) {
  entity.var_d9221ef5bff7298d = var_d9221ef5bff7298d;
}

function function_b2f98346d4b4da5(entity, ownerteam) {
  if(!isDefined(entity.bunkerbustersattached)) {
    entity.bunkerbustersattached = [];
  }

  entity.bunkerbustersattached[entity.bunkerbustersattached.size] = ownerteam;

  if(isDefined(entity.var_55a7086fe1e5fcdd)) {
    entity thread[[entity.var_55a7086fe1e5fcdd]]();
  }
}

function function_83acd124c7845a3e(entity, ownerteam) {
  if(!isDefined(entity.bunkerbustersattached)) {
    return;
  }

  assert(hasBunkerBustersAttached(entity), "<dev string:x147>");
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

  if(isDefined(entity.var_d9221ef5bff7298d)) {
    entity thread[[entity.var_d9221ef5bff7298d]]();
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

  assert(hasincoming(entity), "<dev string:x1a4>");

  if(entity.hasincoming == 1) {
    if(isDefined(entity.incomingremovedcallback)) {
      entity thread[[entity.incomingremovedcallback]]();
    }
  }

  entity.hasincoming--;
}

function giveandfireoffhandreliable(objweapon, var_48e9b160167e8daf) {
  self endon("death");
  self endon("disconnect");
  heldoffhand = weapon::getgrenadeinpullback();

  if(isDefined(heldoffhand) && !isnullweapon(heldoffhand)) {
    self notify("giveAndFireOffhandReliableFailed", objweapon);
    return 0;
  }

  objweapon = utility::function_64003742d8f5c781(objweapon);

  if(!isDefined(objweapon)) {
    self notify("giveAndFireOffhandReliableFailed", objweapon);
    return 0;
  }

  self giveandfireoffhand(objweapon);

  if(!self hasweapon(objweapon)) {
    self notify("giveAndFireOffhandReliableFailed", objweapon);
    return 0;
  }

  if(isDefined(var_48e9b160167e8daf)) {
    self notify(var_48e9b160167e8daf);
  }

  result = spawnStruct();
  result childthread function_34d323a1366782ec(self, objweapon);
  result childthread function_5fe9c9d0b33ce41d(self, objweapon);
  result waittill("race_start");
  waittillframeend();
  result notify("race_end");

  if(result.success) {
    self notify("giveAndFireOffhandReliableSucceeded", objweapon);
    return 1;
  }

  if(result.failure) {
    self notify("giveAndFireOffhandReliableFailed", objweapon);
    return 0;
  }
}

function function_34d323a1366782ec(player, objweapon) {
  self endon("race_end");
  player waittillmatch("offhand_fired", objweapon);
  self.success = 1;
  self notify("race_start");
}

function function_5fe9c9d0b33ce41d(player, objweapon) {
  self endon("race_end");
  timeouttime = gettime() + 5000;

  if(level.gamemodebundle.var_236bc7922709ea15) {
    timeouttime = gettime() + function_8cef655bb1c925da(objweapon) + weaponfiretime(objweapon) * 1000 + 1000;
  }

  waitframe();

  for(hasweapon = player hasweapon(objweapon); hasweapon && gettime() < timeouttime; hasweapon = player hasweapon(objweapon)) {
    player utility::waittill_notify_or_timeout("weapon_taken", (timeouttime - gettime()) * 0.001);
  }

  if(hasweapon) {
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
  return entity.hasincoming > 0;
}

function watchtargetlockedontobyprojectile(target, projectile) {
  target endon("clearLockedOn");
  addlockedon(target);
  addincoming(target);
  projectile utility::waittill_any("death", "clearTargetLockedOntoByProjectile");

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

  if(weapongroup == "weapon_melee2") {
    var_f97d42f076ad0ffe = randomfloatrange(25, 100);
    var_56038b786eb34e7 = randomfloatrange(75, 175);
    var_21060ccead987aae = math::factor_value(450, 800, normalizeddamage);
    var_95ba8343f05e0134 = math::factor_value(-1.16667, -0.833333, normalizeddamage);
    var_fa44270a600bd3d3 = math::factor_value(0.125, 0.183333, normalizeddamage);
  } else if(weapongroup == "weapon_pistol") {
    var_f97d42f076ad0ffe = randomfloatrange(100, 200);
    var_56038b786eb34e7 = randomfloatrange(150, 250);
    var_21060ccead987aae = math::factor_value(950, 1300, normalizeddamage);
    var_95ba8343f05e0134 = math::factor_value(-1.75, -1.25, normalizeddamage);
    var_fa44270a600bd3d3 = math::factor_value(0.5625, 0.825, normalizeddamage);
  } else {
    var_f97d42f076ad0ffe = randomfloatrange(150, 350);
    var_56038b786eb34e7 = randomfloatrange(150, 250);
    var_21060ccead987aae = math::factor_value(950, 1300, normalizeddamage);
    var_95ba8343f05e0134 = math::factor_value(-7, -5, normalizeddamage);
    var_fa44270a600bd3d3 = math::factor_value(0.75, 1.1, normalizeddamage);
  }

  if(utility::cointoss()) {
    var_56038b786eb34e7 *= -1;
  }

  if(!isDefined(item)) {
    println("<dev string:x1e7>");
    return;
  }

  itemcenterofmass = item physics_getentitycenterofmass();

  if(isDefined(itemcenterofmass)) {
    itemcenterofmass = itemcenterofmass["unscaled"];
  } else {
    itemcenterofmass = item.origin;
  }

  launchvelocity = (0, 0, 0);
  launchvelocity += anglesToForward(angles) * var_f97d42f076ad0ffe;
  launchvelocity += anglestoright(angles) * var_56038b786eb34e7;
  launchvelocity += anglestoup(angles) * var_21060ccead987aae;
  weaponangles = item gettagangles("tag_flash", 1);

  if(!isDefined(weaponangles)) {
    weaponangles = item.angles;
  }

  if(utility::cointoss()) {
    var_fa44270a600bd3d3 *= -1;
  }

  launchorigin = itemcenterofmass;
  launchorigin += anglesToForward(weaponangles) * var_95ba8343f05e0134;
  launchorigin += anglestoright(weaponangles) * var_fa44270a600bd3d3;
  logprint("PhysicsLaunchServerItem");
  logprint("item.classname = " + item.classname);
  logprint("launchOrigin = " + launchorigin);
  logprint("launchVelocity = " + launchvelocity);
  item physicslaunchserveritem(launchorigin, launchvelocity);
}

function function_cd7fc4f6ba97876c(droppeditem, weaponobj) {
  if(!isDefined(droppeditem)) {
    return;
  }

  weaponname = getcompleteweaponname(weaponobj);

  if(self.tookweaponfrom[weaponname].var_3a1cc6241650f669) {
    droppeditem.owner = self.tookweaponfrom[weaponname].var_3a1cc6241650f669;
    self.tookweaponfrom[weaponname].var_3a1cc6241650f669 = undefined;
  } else {
    droppeditem.owner = self;
  }

  droppeditem.targetname = "dropped_weapon";
  droppeditem.objweapon = weaponobj;
}

function function_b6883e5e149bdb1f() {
  self.tookweaponfrom = [];
}

function function_6901d4a87ebafa4f(weaponobj, targetplayer) {
  weaponname = getcompleteweaponname(weaponobj);
  return self.tookweaponfrom[weaponname].var_3a1cc6241650f669.team == targetplayer.team;
}

function isbulletweaponobject(weaponobj) {
  if(!isDefined(weaponobj) || isnullweapon(weaponobj)) {
    return 0;
  }

  if(isriotshieldobject(weaponobj) || isknifeonly(weaponobj)) {
    return 0;
  }

  if(weaponobj.inventorytype === "model_only") {
    return 0;
  }

  switch (weaponclass(weaponobj)) {
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

function isbulletweapon(weapon) {
  if(!isDefined(weapon)) {
    assertmsg("<dev string:x220>");
    return 0;
  }

  weaponobj = utility::function_64003742d8f5c781(weapon);
  return isbulletweaponobject(weaponobj);
}

function function_186e07887b6bbeb1(weapon) {
  weapon = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weapon)) {
    assertmsg("<dev string:x262>");
    return false;
  }

  if(isnullweapon(weapon)) {
    return false;
  }

  if(weapon.type == "projectile") {
    return true;
  }

  return false;
}

function function_72753cbca8f2699f(weapon) {
  weapon = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weapon)) {
    assertmsg("<dev string:x2a6>");
    return false;
  }

  if(isnullweapon(weapon)) {
    return false;
  }

  return weapon.classname == "sniper";
}

function function_c1972d0d01397a22(weapon) {
  weapon = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weapon)) {
    assertmsg("<dev string:x262>");
    return false;
  }

  if(isnullweapon(weapon)) {
    return false;
  }

  if(weapon.classname == "rocketlauncher") {
    return true;
  }

  return false;
}

function isgrenadeweapon(weapon) {
  weapon = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weapon)) {
    assertmsg("<dev string:x2ed>");
    return false;
  }

  if(isnullweapon(weapon)) {
    return false;
  }

  return weapon.classname == "grenade";
}

function isoffhandweapon(weapon) {
  weapon = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weapon)) {
    assertmsg("<dev string:x335>");
    return false;
  }

  if(isnullweapon(weapon)) {
    return false;
  }

  return weapon.inventorytype == "offhand";
}

function function_1bf655fc8f1fda2d(weapon) {
  if(getdvarint(@ "hash_86c5f9dae77ee49e", 1) == 0) {
    return false;
  }

  var_7536c5e941b0d00c = [%"riotshield", %"iw9_me_riotshield_mp", %"iw9_la_juliet_mp", %"iw9_la_gromeo_mp", %"iw9_me_sword01_mp", %"iw9_me_kamas_mp"];
  weaponobj = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weaponobj) || isnullweapon(weaponobj)) {
    return false;
  }

  if(weapon::isakimbo(weapon)) {
    return true;
  }

  for(i = 0; i < var_7536c5e941b0d00c.size; i++) {
    if(var_7536c5e941b0d00c[i] == weaponobj.basenamehash) {
      return true;
    }
  }

  return false;
}

function isriotshieldobject(weaponobj) {
  return weapontype(weaponobj) == "riotshield";
}

function isriotshield(weapon) {
  weaponobj = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weaponobj)) {
    return false;
  }

  return isriotshieldobject(weaponobj);
}

function isknifeonly(weapon) {
  rootname = weapon::getweaponrootname(weapon);
  isknife = level.weaponmapdata[rootname].isknife;
  return isknife || rootname == "iw9_me_knife" || rootname == "jup_jp23_me_knife";
}

function isSharpMeleeWeapon(weapon) {
  weaponobj = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weaponobj)) {
    return false;
  }

  rootname = weapon::getweaponrootname(weaponobj);
  issharpmelee = istrue(level.weaponmapdata[rootname].issharpmelee);
  return issharpmelee || weaponobj.basenamehash == % "iw9_me_knife_mp" || weaponobj == level.defaultknifestab || weaponobj.basenamehash == % "iw9_me_sword01_mp";
}

function function_724ac858ee9ecfb8(weapon) {
  if(weapon.isalternate) {
    if(getweaponhasperk(weapon, "specialty_molotov_shots")) {
      return true;
    }
  }

  return false;
}

function ischainsword(weapon) {
  weapon = utility::function_64003742d8f5c781(weapon);

  if(!isDefined(weapon)) {
    assertmsg("<dev string:x37d>");
    return 0;
  }

  return issubstr(weapon.basename, "me_swhiskey");
}

function function_50055d29b455bc79(objweapon) {
  if(isDefined(objweapon) && getweaponhasperk(objweapon, "specialty_stealth_shot")) {
    return 1;
  }
}

function saveweaponstates() {
  if(utility::issharedfuncdefined(#"weapons", #"savetogglescopestates")) {
    self[[utility::getsharedfunc(#"weapons", #"savetogglescopestates")]]();
  }

  if(utility::issharedfuncdefined(#"weapons", #"savealtstates")) {
    self[[utility::getsharedfunc(#"weapons", #"savealtstates")]]();
  }
}

function restoreweaponstates(lastweaponobj, updatetogglescopestate) {
  if(self isalternatemode(lastweaponobj)) {
    if(utility::issharedfuncdefined(#"weapons", #"updatesavedaltstate")) {
      lastweaponobj = self[[utility::getsharedfunc(#"weapons", #"updatesavedaltstate")]](lastweaponobj);
    }
  }

  if(updatetogglescopestate && utility::issharedfuncdefined(#"weapons", #"updatetogglescopestate")) {
    self[[utility::getsharedfunc(#"weapons", #"updatetogglescopestate")]](lastweaponobj);
  }

  return lastweaponobj;
}

function function_926700ffa3fbe9e(idamage, attacker, victim, smeansofdeath, shitloc, inflictor, vpoint, lightarmordamage, heavyarmordamage, helmetdamage) {
  if(isDefined(level.var_dc4402d991756a00)) {
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

    if(lightarmordamage > 0) {
      armormsg = " ArmorDmg: " + lightarmordamage;
    } else if(heavyarmordamage > 0) {
      armormsg = " ArmorDmg: " + heavyarmordamage;
    }

    helmetmsg = "";

    if(helmetdamage > 0) {
      helmetmsg = " HelmetDmg: " + helmetdamage;
    }

    victimtext = isai(victim) ? "AI-" : "Plyr-";
    iprintln(victimtext + "DMG:" + idamage + " LOC:" + shitloc + " HEALTH: " + victim.health + "/" + victim.maxhealth + distmsg + armormsg + helmetmsg);
  }
}

function function_d2c8356dc369d9ce(weaponstring) {
  attachments = getweapondefaultattachments(weaponstring);
  weaponobj = makeweapon(weaponstring, attachments);

  if(isDefined(level.var_cfde89929188f64e) && isDefined(weaponobj) && isweapon(weaponobj)) {
    weaponobj = self[[level.var_cfde89929188f64e]](weaponobj);
  }

  return weaponobj;
}

function makedefaultweapon(weaponstring) {
  attachments = getweapondefaultattachments(weaponstring);
  weaponobj = function_80745a4905e8ac4c(weaponstring, attachments);
  return weaponobj;
}

function function_dbe865d63516d5e8() {
  if(isagent(self)) {
    cachevalue = "ai_" + self getentitynumber();
  } else {
    cachevalue = self.guid;
  }

  return cachevalue;
}

function function_502496613f00eb2a(objweapon, var_938188821853c1eb) {
  if(!isDefined(level.var_e14b75034d106d4b)) {
    level.var_e14b75034d106d4b = [];
  }

  if(!isDefined(level.var_e14b75034d106d4b[objweapon.basenamehash])) {
    weaponowners = [];
    level.var_e14b75034d106d4b[objweapon.basenamehash] = weaponowners;
  }

  level.var_e14b75034d106d4b[objweapon.basenamehash][self.guid] = var_938188821853c1eb;
  thread function_848d1fe899fe91c4(objweapon);
}

function function_848d1fe899fe91c4(objweapon) {
  weapname = weapon::getweaponname(objweapon);
  note = "removeWeaponParent_" + weapname;
  self notify(note);
  self endon(note);
  uniqueid = self.guid;
  wait 5;
  level.var_e14b75034d106d4b[objweapon.basenamehash][uniqueid] = undefined;
}

function function_8097c50c526bd683(objweapon) {
  if(!isDefined(objweapon)) {
    return nullweapon();
  }

  if(isstring(objweapon)) {
    return objweapon;
  }

  weaponnamehash = objweapon.basenamehash;

  if(!isDefined(level.var_e14b75034d106d4b[weaponnamehash])) {
    return objweapon;
  }

  if(!isDefined(level.var_e14b75034d106d4b[weaponnamehash][self.guid])) {
    assertmsg("<dev string:x3be>" + weaponnamehash + "<dev string:x3f9>");
    return objweapon;
  }

  return level.var_e14b75034d106d4b[weaponnamehash][self.guid];
}

function function_5ba4049e1c74f6a8(objweapon) {
  objweapon = utility::function_64003742d8f5c781(objweapon);
  return function_8097c50c526bd683(objweapon);
}

function function_433cd8ffe864ddc8(eattacker, victim, idflags) {
  hand = function_deff5471cdf04d56(idflags);
  victimentnum = function_4ec08fffae2d922d(victim);
  return istrue(eattacker.pelletweaponvictimids[hand][victimentnum].var_77e7ce207984d5d8);
}

function function_deff5471cdf04d56(idflags) {
  if(idflags & 2048) {
    return "lHandWeap";
  }

  return "rHandWeap";
}

function function_4ec08fffae2d922d(victim) {
  return victim getentitynumber();
}

function function_ceb194a906bf4a4c(eattacker, victim, idflags, idamage) {
  hand = function_deff5471cdf04d56(idflags);
  victimentnum = function_4ec08fffae2d922d(victim);
  var_76e29d4e61df4835 = eattacker.pelletweaponvictimids[hand][victimentnum];

  if(!isDefined(var_76e29d4e61df4835)) {
    return idamage;
  }

  var_57dfd4c4337d402e = var_76e29d4e61df4835.var_57dfd4c4337d402e;
  var_8c8eb6b39a4c19ad = var_76e29d4e61df4835.var_8c8eb6b39a4c19ad;

  if(var_8c8eb6b39a4c19ad < var_57dfd4c4337d402e) {
    idamage = clamp(idamage, 0, var_57dfd4c4337d402e - var_8c8eb6b39a4c19ad);
    var_76e29d4e61df4835.var_8c8eb6b39a4c19ad += idamage;
    return idamage;
  }

  return 0;
}

function function_853dbbe8f0c9de3(eattacker, victim, idflags, idamage) {
  hand = function_deff5471cdf04d56(idflags);
  victimentnum = function_4ec08fffae2d922d(victim);

  if(!isDefined(eattacker.pelletweaponvictimids[hand][victimentnum])) {
    return;
  }

  eattacker.pelletweaponvictimids[hand][victimentnum].pelletdmgpassed[0] = idamage;
}

function function_f6354e5e65144a2e(eattacker, victim, idflags, amount) {
  hand = function_deff5471cdf04d56(idflags);
  victimentnum = function_4ec08fffae2d922d(victim);

  if(!isDefined(eattacker.pelletweaponvictimids[hand][victimentnum])) {
    return 0;
  }

  eattacker.pelletweaponvictimids[hand][victimentnum].var_8c8eb6b39a4c19ad += amount;
}

function cleanupconcussionstun(time) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  wait time;

  if(!self || !isDefined(self.isstunned)) {
    return;
  }

  utility::setplayerunstunned();
}

function function_3044cc8c7b9a712a(time, var_4d6be7f39ac22259) {
  self endon("disconnect");
  level endon("game_ended");
  wait time;

  if(!self) {
    return;
  }

  utility::function_f6dbf59c1adea4c2(var_4d6be7f39ac22259);
}

function function_73b6be1968a97ac3(weaponobj, scaleoverride) {
  shellshockdata = spawnStruct();

  if(isDefined(scaleoverride)) {
    shellshockdata.scalemin = scaleoverride;
    shellshockdata.scalemid = scaleoverride;
    shellshockdata.scalemax = scaleoverride;
  }

  if(weapon::iskillstreakweapon(weaponobj)) {
    shellshockdata.enable = 1;
    shellshockdata.duration = 1;
    shellshockdata.scalemin = 0.05;
    shellshockdata.scalemid = 0.15;
    shellshockdata.scalemax = 0.25;
    shellshockdata.rumbletype = "artillery_rumble_heavy";
    shellshockdata.rangemin = 1200;
    shellshockdata.rangemid = 1000;
    shellshockdata.rangemax = 800;
    shellshockdata.screenshakerange = shellshockdata.rangemin;
  }

  return shellshockdata;
}

function function_66f7c63df61623d9(weapon) {
  gametypename = getgametypenamekey();
  gametypeattachment = getgametypeattachment(weapon, gametypename);

  if(isDefined(gametypeattachment) && weapon hasattachment(gametypeattachment)) {
    return weapon withoutattachment(gametypeattachment);
  }

  return weapon;
}

function function_82abd5dde633d1a3(weapon, pickup_source) {
  if(!weapon::iswonderweapon(weapon)) {
    return weapon;
  }

  weaponvariantindex = getweaponvariantindex(weapon);

  if(isDefined(weaponvariantindex)) {
    return weapon;
  }

  weaponrootname = weapon::getweaponrootname(weapon);

  if(isenumvaluevalid(level.loadoutsgroup, "WonderWeapon", getxhashasset(weaponrootname))) {
    blueprintname = self getplayerdata(level.loadoutsgroup, "customizationSetup", "wonderWeaponCustomization", weaponrootname, "blueprintName");
    weaponassetname = level.weaponmapdata[weaponrootname].assetname;

    if(isDefined(weaponassetname) && isxhashasset(blueprintname) && blueprintname != % "") {
      camo = getweaponcamoname(weapon);
      blueprintweapon = weapon::function_bfc8095d723355fa(weaponassetname, blueprintname, camo);

      if(isDefined(pickup_source)) {
        callback::callback(#"hash_ab8dca76e6e4b303", {
          #source: pickup_source, #objweapon: blueprintweapon
        });
      }

      return blueprintweapon;
    }
  }

  return weapon;
}

function function_7f3fdce4d25dd061(grenade) {
  var_d458b9253595dffa = level.scoreeventglobals.var_d458b9253595dffa ?? 800;

  if(gettime() - grenade.birthtime >= var_d458b9253595dffa) {
    return true;
  }

  return false;
}

function registeragentusedcallback(weaponrootstring, callback) {
  if(!isDefined(level.var_70894b09d7ed4da0)) {
    level.var_70894b09d7ed4da0 = [];
  }

  assert(!isDefined(level.var_70894b09d7ed4da0[weaponrootstring]), "<dev string:x47e>");
  level.var_70894b09d7ed4da0[weaponrootstring] = callback;
}

function function_5a4e4e85b51159b6(inflictor, limbfx, torsofx, headfx, sfx, deletebody) {
  if(!isDefined(inflictor)) {
    assertmsg("<dev string:x4a4>");
    return;
  }

  fxdata = spawnStruct();
  fxdata.limbfx = limbfx;
  fxdata.torsofx = torsofx;
  fxdata.headfx = headfx;
  fxdata.sfx = sfx;
  fxdata.deletebody = deletebody ?? 1;
  inflictor.var_1e131f764e128ab1 = fxdata;
}

function function_4472360fbd7a5812(inflictor) {
  if(isDefined(inflictor.var_1e131f764e128ab1)) {
    inflictor.var_1e131f764e128ab1 = undefined;
  }
}

function function_584becf6a5ddf5f0(inflictor, victim) {
  if(isDefined(inflictor.var_1e131f764e128ab1)) {
    fxdata = inflictor.var_1e131f764e128ab1;

    if(isDefined(victim)) {
      playdeathvfx(victim, victim.body, fxdata.limbfx, fxdata.torsofx, fxdata.headfx, fxdata.sfx, fxdata.deletebody);
      return true;
    }

    return false;
  }

  return false;
}

function playdeathvfx(victim, corpstable, limbfx, torsofx, headfx, sfx, deletebody) {
  if(!isDefined(victim)) {
    return;
  }

  function_626fe75ad9d2d09b(victim, "j_shoulder_ri", limbfx);
  function_626fe75ad9d2d09b(victim, "j_shoulder_le", limbfx);
  function_626fe75ad9d2d09b(victim, "j_elbow_ri", limbfx);
  function_626fe75ad9d2d09b(victim, "j_elbow_le", limbfx);
  function_626fe75ad9d2d09b(victim, "j_hip_ri", limbfx);
  function_626fe75ad9d2d09b(victim, "j_hip_le", limbfx);
  function_626fe75ad9d2d09b(victim, "j_knee_ri", limbfx);
  function_626fe75ad9d2d09b(victim, "j_knee_le", limbfx);
  function_626fe75ad9d2d09b(victim, "j_spineupper", torsofx);
  function_626fe75ad9d2d09b(victim, "j_head", headfx);

  if(isDefined(sfx)) {
    victim playSound(sfx);
  }

  if(deletebody) {
    function_f1337d8a77853c84(victim, corpstable);
  }
}

function function_626fe75ad9d2d09b(fxent, fxtag, fxref) {
  if(fxent tagexists(fxtag)) {
    org = fxent gettagorigin(fxtag);
    ang = fxent gettagangles(fxtag);
    playFX(level._effect[fxref], org, anglesToForward(ang), anglestoup(ang));
  }
}

function function_f1337d8a77853c84(victim, corpstable) {
  if(!isDefined(corpstable)) {
    return;
  }

  function_ac43a34a98fd15f(corpstable);

  if(corpstable.targetname == "player_corpse") {
    corpstable hide();
    return;
  }

  if(isagent(victim)) {
    victim thread function_552743d7a3bb3776(corpstable);
  }
}

function private function_ac43a34a98fd15f(corpstable) {
  linkedchildren = corpstable getlinkedchildren();

  foreach(child in linkedchildren) {
    if(child.iscrossbowbolt) {
      child utility::callsharedfunc("crossbow", "boltUnlink");
    }

    if(isDefined(child.equipmentref)) {
      switch (child.equipmentref) {
        case #"hash_8df9cfc147eb2d86":
        case #"hash_9ba0a6ff6081954e":
        case #"hash_de4641ddbc44a7ba":
        case #"hash_e156752cb79526e8":
        case #"hash_f0907f858c134cb4":
          child unlink();
          break;
        default:
          break;
      }
    }
  }
}

function private function_552743d7a3bb3776(corpsetable) {
  waitframe();

  if(isDefined(corpsetable)) {
    corpsetable delete();
  }
}