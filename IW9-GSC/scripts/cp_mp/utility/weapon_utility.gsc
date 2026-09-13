/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\weapon_utility.gsc
****************************************************/

_magicbullet(objweapon, start, end, owner, _id_2DD9A5AE31CA66C1) {
  missile = magicbullet(objweapon, start, end, owner, _id_2DD9A5AE31CA66C1);

  if(isDefined(missile) && isDefined(owner))
    missile setotherent(owner);

  return missile;
}

islockonlauncher(objweapon) {
  _id_149A0FE48B2F9247 = undefined;
  basename = undefined;

  if(isstring(objweapon))
    basename = objweapon;
  else
    basename = objweapon.basename;

  switch (basename) {
    case "iw8_la_juliet_mp":
    case "iw9_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_gromeo_mp":
    case "iw9_la_juliet_mp":
      _id_149A0FE48B2F9247 = 1;
      break;
    default:
      _id_149A0FE48B2F9247 = 0;
  }

  return _id_149A0FE48B2F9247;
}

addlockedon(entity, attacker) {
  if(!isDefined(entity.islockedon)) {
    entity.islockedon = 0;
    entity.attackerslockedon = [];
  }

  if(entity.islockedon == 0) {
    if(isDefined(entity.lockedoncallback))
      entity thread[[entity.lockedoncallback]]();
  }

  if(isDefined(attacker)) {
    attacker.entlockedonto = entity;
    entity.attackerslockedon[attacker getentitynumber()] = attacker;
  }

  entity.islockedon++;
}

removelockedon(entity, attacker) {
  if(!isDefined(entity.islockedon)) {
    return;
  }
  if(entity.islockedon == 1) {
    if(isDefined(entity.lockedonremovedcallback))
      entity thread[[entity.lockedonremovedcallback]]();
  }

  if(isDefined(attacker)) {
    if(isDefined(attacker.entlockedonto) && attacker.entlockedonto == entity)
      attacker.entlockedonto = undefined;

    entity.attackerslockedon[attacker getentitynumber()] = undefined;
  }

  entity.islockedon--;
}

setlockedoncallback(entity, lockedoncallback) {
  entity.lockedoncallback = lockedoncallback;
}

setlockedonremovedcallback(entity, lockedonremovedcallback) {
  entity.lockedonremovedcallback = lockedonremovedcallback;
}

clearlockedon(entity) {
  entity notify("clearLockedOn");

  if(islockedonto(entity)) {
    if(isDefined(entity.lockedonremovedcallback))
      entity thread[[entity.lockedonremovedcallback]]();

    foreach(_id_AC0E594AC96AA3A8, attacker in entity.attackerslockedon) {
      if(isDefined(attacker)) {
        if(isDefined(attacker.entlockedonto) && attacker.entlockedonto == entity)
          attacker.entlockedonto = undefined;
      }
    }
  }

  entity.islockedon = undefined;
  entity.attackerslockedon = undefined;
  entity.lockedoncallback = undefined;
  entity.lockedonremovedcallback = undefined;

  if(hasincoming(entity)) {
    if(isDefined(entity.incomingremovedcallback))
      entity thread[[entity.incomingremovedcallback]]();
  }

  entity.hasincoming = undefined;
  entity.incomingcallback = undefined;
  entity.incomingremovedcallback = undefined;
}

clearlockedonondisconnect(player) {
  if(isDefined(self.entlockedonto))
    removelockedon(self.entlockedonto, self);

  self.entlockedonto = undefined;
}

islockedonto(entity) {
  return isDefined(entity.islockedon) && entity.islockedon > 0;
}

_id_97DB16DE04046C2B(inflictor, victim, _id_1189BD7FBE2861F8) {
  if(isDefined(inflictor)) {
    if(isDefined(inflictor.equipmentref) && isDefined(_id_1189BD7FBE2861F8) && inflictor.equipmentref != _id_1189BD7FBE2861F8)
      return 0;

    if(isDefined(inflictor.stuckto) && inflictor.stuckto == victim)
      return 1;
  }

  return 0;
}

_id_F18DBD353F3E1570(entity) {
  return isDefined(entity._id_F2F04BCC448FAB3A) && entity._id_F2F04BCC448FAB3A.size > 0;
}

_id_53FD22613EA65204(entity, _id_5EC2DA3D1D27E716) {
  entity._id_5EC2DA3D1D27E716 = _id_5EC2DA3D1D27E716;
}

_id_B55A664E824540D2(entity, _id_0218D5FB97D94F2C) {
  entity._id_0218D5FB97D94F2C = _id_0218D5FB97D94F2C;
}

_id_69D45A21A6D4E9F8(entity, ownerteam) {
  if(!isDefined(entity._id_F2F04BCC448FAB3A))
    entity._id_F2F04BCC448FAB3A = [];

  entity._id_F2F04BCC448FAB3A[entity._id_F2F04BCC448FAB3A.size] = ownerteam;

  if(isDefined(entity._id_5EC2DA3D1D27E716))
    entity thread[[entity._id_5EC2DA3D1D27E716]]();
}

_id_28E583BFECC38A25(entity, ownerteam) {
  if(!isDefined(entity._id_F2F04BCC448FAB3A)) {
    return;
  }
  teams = entity._id_F2F04BCC448FAB3A;
  entity._id_F2F04BCC448FAB3A = [];
  removed = 0;

  foreach(team in teams) {
    if(!removed && team == ownerteam) {
      removed = 1;
      continue;
    }

    entity._id_F2F04BCC448FAB3A[entity._id_F2F04BCC448FAB3A.size] = team;
  }

  if(entity._id_F2F04BCC448FAB3A.size == 0)
    entity._id_F2F04BCC448FAB3A = undefined;

  if(isDefined(entity._id_0218D5FB97D94F2C))
    entity thread[[entity._id_0218D5FB97D94F2C]]();
}

addincoming(entity) {
  if(!isDefined(entity.hasincoming))
    entity.hasincoming = 0;

  if(entity.hasincoming == 0) {
    if(isDefined(entity.incomingcallback))
      entity thread[[entity.incomingcallback]]();
  }

  entity.hasincoming++;
}

removeincoming(entity) {
  if(!isDefined(entity.hasincoming)) {
    return;
  }
  if(entity.hasincoming == 1) {
    if(isDefined(entity.incomingremovedcallback))
      entity thread[[entity.incomingremovedcallback]]();
  }

  entity.hasincoming--;
}

_id_F19F8B4CF085ECBD(objweapon) {
  self endon("death");
  self endon("disconnect");
  _id_F24845EEAEEDC946 = _id_2669878CF5A1B6BC::getgrenadeinpullback();

  if(isDefined(_id_F24845EEAEEDC946) && !isnullweapon(_id_F24845EEAEEDC946))
    return 0;

  if(!isweapon(objweapon)) {
    if(isstring(objweapon))
      objweapon = makeweapon(objweapon);
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
  result childthread _id_8EA8B6459D144947(self, objweapon);
  result childthread _id_158897145D2EFB26(self, objweapon);
  result waittill("race_start");
  waittillframeend;
  result notify("race_end");

  if(istrue(result.success)) {
    self notify("giveAndFireOffhandReliableSucceeded", objweapon);
    return 1;
  } else if(istrue(result.failure)) {
    self notify("giveAndFireOffhandReliableFailed", objweapon);
    return 0;
  }
}

_id_8EA8B6459D144947(player, objweapon) {
  self endon("race_end");
  player waittillmatch("offhand_fired", objweapon);
  self.success = 1;
  self notify("race_start");
}

_id_158897145D2EFB26(player, objweapon) {
  self endon("race_end");

  for(timeelapsed = 0; player hasweapon(objweapon) && timeelapsed < 5.0; timeelapsed = timeelapsed + level.framedurationseconds)
    waitframe();

  if(player hasweapon(objweapon))
    player takeweapon(objweapon);

  self.failure = 1;
  self notify("race_start");
}

setincomingcallback(entity, incomingcallback) {
  entity.incomingcallback = incomingcallback;
}

setincomingremovedcallback(entity, incomingremovedcallback) {
  entity.incomingremovedcallback = incomingremovedcallback;
}

hasincoming(entity) {
  return isDefined(entity.hasincoming) && entity.hasincoming > 0;
}

watchtargetlockedontobyprojectile(target, projectile) {
  target endon("clearLockedOn");
  addlockedon(target);
  addincoming(target);
  projectile scripts\engine\utility::waittill_any_2("death", "clearTargetLockedOntoByProjectile");

  if(isDefined(target)) {
    removelockedon(target);
    removeincoming(target);
  }
}

clearprojectilelockedon(projectile) {
  projectile notify("clearTargetLockedOntoByProjectile");
}

dropweaponfordeathlaunch(item, _id_CF4209C200F8BBF4, damage, angles) {
  if(!isDefined(angles))
    angles = self.angles;

  if(!isDefined(damage))
    damage = 0;

  _id_198B31BBA82C76D5 = scripts\engine\math::normalize_value(0, 200, damage);

  if(isDefined(_id_CF4209C200F8BBF4) && _id_CF4209C200F8BBF4 == "weapon_melee2") {
    _id_4148F5F633BFCF19 = randomfloatrange(25, 100);
    _id_5DE19BFA9BB86F0C = randomfloatrange(75, 175);
    _id_B8A13F3AF0CBE01B = scripts\engine\math::factor_value(450, 800, _id_198B31BBA82C76D5);
    _id_EAC2B0512D0B1C55 = scripts\engine\math::factor_value(-1.16667, -0.833333, _id_198B31BBA82C76D5);
    _id_8282854EC42283A2 = scripts\engine\math::factor_value(0.125, 0.183333, _id_198B31BBA82C76D5);
  } else if(isDefined(_id_CF4209C200F8BBF4) && _id_CF4209C200F8BBF4 == "weapon_pistol") {
    _id_4148F5F633BFCF19 = randomfloatrange(100, 200);
    _id_5DE19BFA9BB86F0C = randomfloatrange(150, 250);
    _id_B8A13F3AF0CBE01B = scripts\engine\math::factor_value(950, 1300, _id_198B31BBA82C76D5);
    _id_EAC2B0512D0B1C55 = scripts\engine\math::factor_value(-1.75, -1.25, _id_198B31BBA82C76D5);
    _id_8282854EC42283A2 = scripts\engine\math::factor_value(0.5625, 0.825, _id_198B31BBA82C76D5);
  } else {
    _id_4148F5F633BFCF19 = randomfloatrange(150, 350);
    _id_5DE19BFA9BB86F0C = randomfloatrange(150, 250);
    _id_B8A13F3AF0CBE01B = scripts\engine\math::factor_value(950, 1300, _id_198B31BBA82C76D5);
    _id_EAC2B0512D0B1C55 = scripts\engine\math::factor_value(-7.0, -5.0, _id_198B31BBA82C76D5);
    _id_8282854EC42283A2 = scripts\engine\math::factor_value(0.75, 1.1, _id_198B31BBA82C76D5);
  }

  if(scripts\engine\utility::cointoss())
    _id_5DE19BFA9BB86F0C = _id_5DE19BFA9BB86F0C * -1;

  if(!isDefined(item)) {
    return;
  }
  _id_2E3A4C6FAF317522 = item physics_getentitycenterofmass();

  if(isDefined(_id_2E3A4C6FAF317522))
    _id_2E3A4C6FAF317522 = _id_2E3A4C6FAF317522["unscaled"];
  else
    _id_2E3A4C6FAF317522 = item.origin;

  _id_7331D469160F6A41 = (0, 0, 0);
  _id_7331D469160F6A41 = _id_7331D469160F6A41 + anglesToForward(angles) * _id_4148F5F633BFCF19;
  _id_7331D469160F6A41 = _id_7331D469160F6A41 + anglestoright(angles) * _id_5DE19BFA9BB86F0C;
  _id_7331D469160F6A41 = _id_7331D469160F6A41 + anglestoup(angles) * _id_B8A13F3AF0CBE01B;
  _id_9CBCD63169EBE6B9 = item gettagangles("tag_flash", 1);

  if(!isDefined(_id_9CBCD63169EBE6B9))
    _id_9CBCD63169EBE6B9 = item.angles;

  if(scripts\engine\utility::cointoss())
    _id_8282854EC42283A2 = _id_8282854EC42283A2 * -1;

  _id_51C1B45046E1647C = _id_2E3A4C6FAF317522;
  _id_51C1B45046E1647C = _id_51C1B45046E1647C + anglesToForward(_id_9CBCD63169EBE6B9) * _id_EAC2B0512D0B1C55;
  _id_51C1B45046E1647C = _id_51C1B45046E1647C + anglestoright(_id_9CBCD63169EBE6B9) * _id_8282854EC42283A2;
  logprint("PhysicsLaunchServerItem");
  logprint("item.classname = " + item.classname);
  logprint("launchOrigin = " + _id_51C1B45046E1647C);
  logprint("launchVelocity = " + _id_7331D469160F6A41);
  item physicslaunchserveritem(_id_51C1B45046E1647C, _id_7331D469160F6A41);
}

isbulletweapon(weapon) {
  if(!isDefined(weapon))
    return 0;

  if(isweapon(weapon) && isnullweapon(weapon))
    return 0;

  if(isstring(weapon) && weapon == "none")
    return 0;

  if(isriotshield(weapon) || isknifeonly(weapon))
    return 0;

  if(isDefined(weapon.inventorytype) && weapon.inventorytype == "model_only")
    return 0;

  switch (weaponclass(weapon)) {
    case "mg":
    case "spread":
    case "sniper":
    case "rifle":
    case "pistol":
    case "smg":
      return 1;
    default:
      return 0;
  }
}

_id_102D677621400199(weapon) {
  if(!isDefined(weapon))
    return 0;

  if(isweapon(weapon) && isnullweapon(weapon))
    return 0;

  if(isstring(weapon) && weapon == "none")
    return 0;

  if(isriotshield(weapon) || isknifeonly(weapon))
    return 0;

  if(isDefined(weapon.inventorytype) && weapon.inventorytype == "model_only")
    return 0;

  if(!isDefined(weapon.basename))
    return 0;

  _id_496432274D3CA31E = strtok(weapon.basename, "_");

  if(_id_496432274D3CA31E[1] != "la")
    return 0;

  return 1;
}

_id_38642DB3C423BCDC(weapon) {
  _id_1BAE199AE2509F57 = ["riotshield", "iw9_me_riotshield_mp", "iw9_la_juliet_mp", "iw9_la_gromeo_mp", "iw9_me_sword01_mp"];

  if(isweapon(weapon) && isnullweapon(weapon))
    return 0;

  if(isstring(weapon) && weapon == "none")
    return 0;

  _id_3F481EF57656312C = weapon.basename;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1BAE199AE2509F57.size; _id_AC0E594AC96AA3A8++) {
    if(_id_1BAE199AE2509F57[_id_AC0E594AC96AA3A8] == _id_3F481EF57656312C)
      return 1;
  }

  return 0;
}

isriotshield(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon))
    return 0;

  if(isstring(weapon) && weapon == "none")
    return 0;

  return weapontype(weapon) == "riotshield";
}

isknifeonly(weapon) {
  return _id_2669878CF5A1B6BC::getweaponrootname(weapon) == "iw9_me_knife";
}

_id_CFAC6D60B7A14AB9(weapon) {
  if(!isDefined(weapon) || !isDefined(weapon.basename))
    return 0;

  basename = weapon.basename;
  return basename == "iw9_me_knife_mp" || basename == "iw9_knifestab_mp" || basename == "iw9_me_sword01_mp";
}

saveweaponstates() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "saveToggleScopeStates"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "saveToggleScopeStates")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "saveAltStates"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "saveAltStates")]]();
}

restoreweaponstates(lastweaponobj) {
  if(self isalternatemode(lastweaponobj)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "updateSavedAltState"))
      lastweaponobj = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "updateSavedAltState")]](lastweaponobj);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "updateToggleScopeState"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "updateToggleScopeState")]](lastweaponobj);

  return lastweaponobj;
}

_id_C9E5C511B923A42F(idamage, attacker, victim, smeansofdeath, shitloc, inflictor, vpoint, _id_1DA1A66B5C6A06A7, _id_986B2E0350629522, _id_25359C8E0B5022A5) {
  if(isDefined(level._id_B39EDA08D7912835)) {
    _id_78B43647BC863F62 = "";

    if(isexplosivedamagemod(smeansofdeath) && isDefined(victim.origin)) {
      _id_DD2FC1BD72AF4B7D = vpoint;

      if(isDefined(inflictor) && isDefined(inflictor.origin))
        _id_DD2FC1BD72AF4B7D = inflictor.origin;

      _id_78B43647BC863F62 = " EXPL_DIST: " + int(distance(_id_DD2FC1BD72AF4B7D, victim.origin));
    } else if(isDefined(vpoint))
      _id_78B43647BC863F62 = " DIST:" + int(distance(attacker.origin, vpoint));

    _id_FB25FF31E4E88929 = "";

    if(isDefined(_id_1DA1A66B5C6A06A7) && _id_1DA1A66B5C6A06A7 > 0)
      _id_FB25FF31E4E88929 = " ArmorDmg: " + _id_1DA1A66B5C6A06A7;
    else if(isDefined(_id_986B2E0350629522) && _id_986B2E0350629522 > 0)
      _id_FB25FF31E4E88929 = " ArmorDmg: " + _id_986B2E0350629522;

    _id_9EAEA3D379E435AD = "";

    if(isDefined(_id_25359C8E0B5022A5) && _id_25359C8E0B5022A5 > 0)
      _id_9EAEA3D379E435AD = " HelmetDmg: " + _id_25359C8E0B5022A5;

    _id_383D064ABE36A06A = scripts\engine\utility::ter_op(isai(victim), "AI-", "Plyr-");
    iprintln(_id_383D064ABE36A06A + "DMG:" + idamage + " LOC:" + shitloc + " HEALTH: " + victim.health + "/" + victim.maxhealth + _id_78B43647BC863F62 + _id_FB25FF31E4E88929 + _id_9EAEA3D379E435AD);
  }
}

_id_EEAA22F0CD1FF845(_id_C094DB262CE4DFA0) {
  attachments = _func_6527364C1ECCA6C6(_id_C094DB262CE4DFA0);
  weaponobj = makeweapon(_id_C094DB262CE4DFA0, attachments);
  return weaponobj;
}

_id_8CDA2444C7D142DF() {
  if(isagent(self))
    _id_E993250A341E26AE = "ai_" + self getentitynumber();
  else
    _id_E993250A341E26AE = self.guid;

  return _id_E993250A341E26AE;
}

_id_49967318FBD12317(objweapon, _id_76B470A332915556) {
  if(!isDefined(level._id_B5224F533F8FFFB0))
    level._id_B5224F533F8FFFB0 = [];

  if(!scripts\engine\utility::array_contains_key(level._id_B5224F533F8FFFB0, objweapon.basename)) {
    _id_CD63361C3D62090D = [];
    level._id_B5224F533F8FFFB0[objweapon.basename] = _id_CD63361C3D62090D;
  }

  uniqueid = _id_8CDA2444C7D142DF();
  level._id_B5224F533F8FFFB0[objweapon.basename][uniqueid] = _id_76B470A332915556;
  thread _id_820FE7D9E7EC7C65(objweapon);
}

_id_820FE7D9E7EC7C65(objweapon) {
  _id_A234A65C378F3289 = "removeWeaponParent_" + objweapon.basename;
  self notify(_id_A234A65C378F3289);
  self endon(_id_A234A65C378F3289);
  uniqueid = _id_8CDA2444C7D142DF();
  wait 5.0;
  level._id_B5224F533F8FFFB0[objweapon.basename] = scripts\engine\utility::array_remove_key(level._id_B5224F533F8FFFB0[objweapon.basename], uniqueid);
}

_id_1E3102980C3A4CC1(objweapon) {
  if(!isDefined(objweapon))
    return nullweapon();

  weaponname = undefined;

  if(isweapon(objweapon))
    weaponname = objweapon.basename;
  else
    weaponname = objweapon;

  if(!isDefined(weaponname))
    return objweapon;

  uniqueid = _id_8CDA2444C7D142DF();

  if(isDefined(level._id_B5224F533F8FFFB0) && scripts\engine\utility::array_contains_key(level._id_B5224F533F8FFFB0, weaponname))
    return level._id_B5224F533F8FFFB0[weaponname][uniqueid];

  return objweapon;
}

_id_F0CF737B5D0CCDA5(weapon) {
  _id_C27E2A04BAB78C1F = getweaponbasename(weapon);
  result = issubstr(_id_C27E2A04BAB78C1F, "sword01") || issubstr(_id_C27E2A04BAB78C1F, "kamas") || issubstr(_id_C27E2A04BAB78C1F, "pickaxe");
  return result;
}

_id_A3FC7EBC9FC3E9A3(eattacker, victim, idflags) {
  _id_A9F996CAF54DD68C = _id_88E9E2299BD29FD1(idflags);
  _id_BDA9C6703DCFCC16 = _id_D77E6B2580F74622(victim);

  if(isDefined(eattacker.pelletweaponvictimids) && isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C]) && isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]))
    return eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_7981F7D372990A2B;

  return 0;
}

_id_88E9E2299BD29FD1(idflags) {
  if(idflags &level.idflags_source_left_hand)
    return "lHandWeap";
  else
    return "rHandWeap";
}

_id_D77E6B2580F74622(victim) {
  return "" + victim getentitynumber();
}

_id_1113FC99A0327D7D(eattacker, victim, idflags, idamage) {
  _id_A9F996CAF54DD68C = _id_88E9E2299BD29FD1(idflags);
  _id_BDA9C6703DCFCC16 = _id_D77E6B2580F74622(victim);

  if(!isDefined(eattacker.pelletweaponvictimids) || !isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C]) || !isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]))
    return idamage;

  _id_52F16F4C9CDBF165 = eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_52F16F4C9CDBF165;
  _id_9BB59738D095536E = eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_9BB59738D095536E;

  if(_id_9BB59738D095536E < _id_52F16F4C9CDBF165) {
    idamage = clamp(idamage, 0, _id_52F16F4C9CDBF165 - eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_9BB59738D095536E);
    eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_9BB59738D095536E = eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_9BB59738D095536E + idamage;
    return idamage;
  } else
    return 0;
}

_id_AD15087050F05B04(eattacker, victim, idflags, idamage) {
  _id_A9F996CAF54DD68C = _id_88E9E2299BD29FD1(idflags);
  _id_BDA9C6703DCFCC16 = _id_D77E6B2580F74622(victim);

  if(!isDefined(eattacker.pelletweaponvictimids) || !isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C]) || !isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16])) {
    return;
  }
  eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16].pelletdmgpassed[0] = idamage;
}

_id_9665CBEBA4D776F7(eattacker, victim, idflags, amount) {
  _id_A9F996CAF54DD68C = _id_88E9E2299BD29FD1(idflags);
  _id_BDA9C6703DCFCC16 = _id_D77E6B2580F74622(victim);

  if(!isDefined(eattacker.pelletweaponvictimids) || !isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C]) || !isDefined(eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]))
    return 0;

  eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_9BB59738D095536E = eattacker.pelletweaponvictimids[_id_A9F996CAF54DD68C][_id_BDA9C6703DCFCC16]._id_9BB59738D095536E + amount;
}