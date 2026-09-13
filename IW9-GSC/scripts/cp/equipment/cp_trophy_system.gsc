/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_trophy_system.gsc
*****************************************************/

trophy_init() {
  _id_2FC780A60BF174FC = spawnStruct();
  _id_2FC780A60BF174FC.tags = [];
  _id_2FC780A60BF174FC.tags[0] = "j_projectile_01_base";
  _id_2FC780A60BF174FC.tags[1] = "j_projectile_02_base";
  _id_2FC780A60BF174FC.tags[2] = "j_projectile_03_base";
  _id_2FC780A60BF174FC.tags[3] = "j_projectile_04_base";
  level.trophy = _id_2FC780A60BF174FC;
}

trophy_used(grenade) {
  grenade endon("death");
  self endon("disconnect");
  thread _id_74502A9E0EF1F19C::monitordisownedequipment(self, grenade);
  grenade waittill("missile_stuck", stuckto);
  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade.usedcount = 0;
  _id_307667D0142F2035 = scripts\cp\utility::_hasperk("specialty_rugged_eqp");

  if(_id_307667D0142F2035)
    grenade.hasruggedeqp = 1;

  grenade.ammo = trophy_removestored();

  if(!isDefined(grenade.ammo))
    grenade.ammo = 2;

  _id_74502A9E0EF1F19C::ontacticalequipmentplanted(grenade, "equip_trophy");
  thread _id_74502A9E0EF1F19C::monitordisownedequipment(self, grenade);
  grenade.explosion = trophy_createexplosion(grenade);
  maxhealth = scripts\engine\utility::ter_op(_id_307667D0142F2035, 200, 100);
  damagefeedback = scripts\engine\utility::ter_op(_id_307667D0142F2035, "hitequip", "");
  grenade thread _id_74502A9E0EF1F19C::monitordamage(maxhealth, damagefeedback, ::trophy_handlefataldamage, ::trophy_handledamage, 0);
  grenade thread trophy_destroyonemp();
  grenade thread trophy_destroyongameend();
  grenade thread trophy_watchprotection();
  grenade missilethermal();
  grenade missileoutline();
  grenade thread trophy_deploysequence();
}

trophy_destroy(usedelay) {
  usedelay = istrue(usedelay);
  _id_CBF7BE4F62A0DDB2 = 0.1;

  if(usedelay)
    _id_CBF7BE4F62A0DDB2 = _id_CBF7BE4F62A0DDB2 + 0.5;

  thread trophy_delete(_id_CBF7BE4F62A0DDB2);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);

  if(usedelay)
    wait 0.5;

  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

trophy_delete(_id_CBF7BE4F62A0DDB2) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(!istrue(self.issuper)) {
    self makeunusable();
    _id_74502A9E0EF1F19C::makeexplosiveunusuabletag();
  }

  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner) && !istrue(self.issuper)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd"))
      owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_trophy", self.usedcount);

    owner.plantedtacticalequip = scripts\engine\utility::array_remove(owner.plantedtacticalequip, self);
    owner notify("trophy_update", 0);
  } else if(isDefined(self.owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd"))
      owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_trophy", self.usedcount);

    owner.activesupertrophies = scripts\engine\utility::array_remove(owner.activesupertrophies, self);
    owner notify("trophy_update", 0);
  }

  wait(_id_CBF7BE4F62A0DDB2);
  self delete();
}

trophy_deploysequence() {
  self endon("death");
  self setscriptablepartstate("effects", "activeDeployStart");
  wait 1.25;
  self setscriptablepartstate("effects", "activeDeployEnd");
}

trophy_watchprotection() {
  self endon("death");
  self.owner endon("disconnect");

  if(!isDefined(level.grenades))
    level.grenades = [];

  if(!isDefined(level.missiles))
    level.missiles = [];

  if(!isDefined(level.mines))
    level.mines = [];

  if(!isDefined(level.mortars))
    level.mortars = [];

  trophy_castcontents = trophy_castcontents();

  for(;;) {
    _id_2CC97E113610CA14 = trophy_castorigin();
    _id_C70B9ADBC218860A = [];
    _id_C70B9ADBC218860A[0] = level.grenades;
    _id_C70B9ADBC218860A[1] = level.missiles;
    _id_C70B9ADBC218860A[2] = level.mines;
    _id_C70B9ADBC218860A[3] = level.mortars;
    _id_9AC253C93282B297 = scripts\engine\utility::array_combine_multiple(_id_C70B9ADBC218860A);

    foreach(_id_1DBABE317739127E in _id_9AC253C93282B297) {
      if(!isDefined(_id_1DBABE317739127E)) {
        continue;
      }
      if(istrue(_id_1DBABE317739127E.exploding)) {
        continue;
      }
      if(trophy_checkignorelist(_id_1DBABE317739127E)) {
        continue;
      }
      _id_1BA7B2D16DC215E1 = _id_1DBABE317739127E.owner;

      if(!isDefined(_id_1BA7B2D16DC215E1) && isDefined(_id_1DBABE317739127E.vehicle))
        _id_1BA7B2D16DC215E1 = _id_1DBABE317739127E.vehicle.owner;

      if(!isDefined(_id_1BA7B2D16DC215E1) && isDefined(_id_1DBABE317739127E.weapon_name) && weaponclass(_id_1DBABE317739127E.weapon_name) == "grenade")
        _id_1BA7B2D16DC215E1 = getmissileowner(_id_1DBABE317739127E);

      if(isDefined(_id_1BA7B2D16DC215E1) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, _id_1BA7B2D16DC215E1))) {
        continue;
      }
      if(distancesquared(_id_1DBABE317739127E.origin, self.origin) > trophy_modifiedprotectiondistsqr(_id_1DBABE317739127E, 65536)) {
        continue;
      }
      _id_E021C2744CC7ED68 = physics_raycast(_id_2CC97E113610CA14, _id_1DBABE317739127E.origin, trophy_castcontents, [self, _id_1DBABE317739127E], 0, "physicsquery_closest");

      if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
        continue;
      }
      trophy_protectionsuccessful(_id_1DBABE317739127E);
    }

    waitframe();
  }
}

trophy_protectionsuccessful(_id_1DBABE317739127E) {
  _id_1DBABE317739127E setCanDamage(0);
  _id_1DBABE317739127E.exploding = 1;
  _id_1DBABE317739127E stopsounds();
  trophy_startcooldownlist(_id_1DBABE317739127E);
  trophy_notifytrophytargetowner(_id_1DBABE317739127E, "trophy_cp", self.owner);
  _id_D7030318CA9E674A = _id_1DBABE317739127E.origin;
  _id_CC29543DE9737588 = _id_1DBABE317739127E.angles;

  if(_id_74502A9E0EF1F19C::isplantedequipment(_id_1DBABE317739127E))
    _id_1DBABE317739127E _id_74502A9E0EF1F19C::deleteexplosive();
  else
    _id_1DBABE317739127E delete();

  tag = trophy_getbesttag(_id_D7030318CA9E674A);
  part = trophy_getpartbytag(tag);
  self setscriptablepartstate(part, "active", 0);
  self.explosion thread trophy_explode(_id_D7030318CA9E674A, _id_CC29543DE9737588);
  self.usedcount++;
  self.ammo--;

  if(self.ammo <= 0)
    thread trophy_destroy(1);
}

trophy_handledamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  _id_702BFC08FABD86CB = damage;
  return _id_702BFC08FABD86CB;
}

trophy_handlefataldamage(data) {
  attacker = data.attacker;
  trophy_givepointsfordeath(attacker);
  thread trophy_destroy();
}

trophy_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_applied", data);
  attacker = data.attacker;
  trophy_givepointsfordeath(attacker);
  trophy_givedamagefeedback(attacker);
  thread trophy_destroy(1);
}

trophy_destroyongameend() {
  self endon("death");
  self.owner endon("disconnect");
  level scripts\engine\utility::waittill_any_2("game_ended", "bro_shot_start");
  thread trophy_destroy();
}

trophy_pickup() {
  if(self.owner scripts\cp\cp_equipment::hasequipment("equip_trophy"))
    self.owner trophy_addstored(self.ammo);
}

trophy_createexplosion(trophy) {
  explosion = spawn("script_model", trophy.origin);
  explosion.killcament = trophy;
  explosion.owner = trophy.owner;
  explosion.team = trophy.team;
  explosion.equipmentref = trophy.equipmentref;
  explosion.weapon_name = trophy.weapon_name;
  explosion setotherent(explosion.owner);
  explosion setentityowner(explosion.owner);
  explosion setModel("trophy_system_cp_explode");
  explosion.explode1available = 1;
  explosion.explode2available = 1;
  explosion thread trophy_cleanuponparentdeath(trophy, 0.1);
  return explosion;
}

trophy_explode(position, angles) {
  self dontinterpolate();
  self.origin = position;
  self.angles = angles;

  if(self.explode1available) {
    self setscriptablepartstate("explode1", "activeDirectional", 0);
    self.explode1available = 0;
  } else if(self.explode2available) {
    self setscriptablepartstate("explode2", "activeDirectional", 0);
    self.explode1available = 0;
  }
}

trophy_castorigin() {
  return self.origin + anglestoup(self.angles) * 45;
}

trophy_castcontents() {
  return physics_createcontents(["physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_item"]);
}

trophy_modifiedprotectiondistsqr(_id_1DBABE317739127E, _id_05B95596970B49B4) {
  if(isDefined(_id_1DBABE317739127E.weapon_name) && isDefined(_id_1DBABE317739127E.owner)) {
    switch (_id_1DBABE317739127E.weapon_name) {
      case "drone_hive_projectile_mp":
      case "jackal_cannon_mp":
      case "switch_blade_child_mp":
        if(147456 > _id_05B95596970B49B4)
          _id_05B95596970B49B4 = 147456;

        break;
      case "iw7_arclassic_mp":
      case "pop_rocket_proj_mp":
      case "iw8_la_kgolf_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_mike32_mp":
      case "iw8_la_gromeoks_mp":
      case "iw8_la_gromeo_mp":
      case "iw8_la_juliet_mp":
      case "iw9_la_gromeo_mp":
        if(65536 > _id_05B95596970B49B4)
          _id_05B95596970B49B4 = 65536;

        break;
    }
  }

  return _id_05B95596970B49B4;
}

trophy_checkignorelist(_id_1DBABE317739127E) {
  weaponname = _id_1DBABE317739127E.weapon_name;

  if(!isDefined(weaponname) && isDefined(_id_1DBABE317739127E.weapon_object))
    weaponname = _id_1DBABE317739127E.weapon_object.basename;

  if(isDefined(weaponname)) {
    if(_id_2669878CF5A1B6BC::iskillstreakweapon(weaponname))
      return 1;

    switch (weaponname) {
      case "trophy_cp":
      case "trophy_mp":
        if(_id_74502A9E0EF1F19C::isplantedequipment(_id_1DBABE317739127E))
          return 1;

        break;
      case "uplinkball_tracking_mp":
      case "snapshot_grenade_danger_mp":
      case "micro_turret_mp":
      case "lighttank_mp":
      case "throwingknife_mp":
      case "at_mine_ap_mp":
      case "pop_rocket_mp":
        return 1;
    }
  }

  return 0;
}

trophy_startcooldownlist(_id_1DBABE317739127E) {
  if(getdvarint("showarchetypes", 0) > 0)
    return;
}

trophy_notifytrophytargetowner(_id_1DBABE317739127E, _id_C1D3B25C841AF510, _id_6B21EA0780AA76FE) {
  if(!isDefined(_id_1DBABE317739127E.owner) || !isPlayer(_id_1DBABE317739127E.owner)) {
    return;
  }
  _id_1DBABE317739127E.owner thread _id_354C862768CFE202::updatedamagefeedback("hittrophysystem");

  if(isDefined(_id_1DBABE317739127E.weapon_name)) {
    switch (_id_1DBABE317739127E.weapon_name) {
      case "drone_hive_projectile_mp":
      case "jackal_cannon_mp":
      case "switch_blade_child_mp":
        _id_1DBABE317739127E.owner notify("destroyed_by_trophy", _id_6B21EA0780AA76FE, _id_C1D3B25C841AF510, _id_1DBABE317739127E.weapon_name, _id_1DBABE317739127E.origin, _id_1DBABE317739127E.angles);
        break;
    }
  }
}

trophy_getbesttag(position) {
  tags = level.trophy.tags;
  _id_445ACA8C2C95592E = undefined;
  _id_5D32298B837DFF31 = undefined;

  foreach(id, tag in tags) {
    origin = self gettagorigin(tag);
    angles = self gettagangles(tag);
    forward = anglesToForward(angles);
    dot = vectordot(vectorNormalize(position - origin), forward);

    if(id == 0 || dot > _id_445ACA8C2C95592E) {
      _id_445ACA8C2C95592E = dot;
      _id_5D32298B837DFF31 = tag;
    }
  }

  return _id_5D32298B837DFF31;
}

trophy_getpartbytag(tag) {
  tags = level.trophy.tags;

  foreach(id, t in tags) {
    if(t == tag)
      return "protect" + (id + 1);
  }

  return undefined;
}

trophy_givepointsfordeath(attacker) {}

trophy_givedamagefeedback(attacker) {
  damagefeedback = "";

  if(istrue(self.hasruggedeqp))
    damagefeedback = "hitequip";

  if(isPlayer(attacker))
    attacker _id_354C862768CFE202::updatedamagefeedback(damagefeedback);
}

trophy_addstored(ammo) {
  if(!isDefined(self.trophies))
    self.trophies = [];

  if(self.trophies.size < trophy_maxstored()) {
    if(!isDefined(ammo))
      ammo = 2;

    self.trophies[self.trophies.size] = ammo;
  }
}

trophy_removestored() {
  if(isDefined(self.trophies) && self.trophies.size > 0) {
    trophy = self.trophies[self.trophies.size - 1];
    self.trophies[self.trophies.size - 1] = undefined;
    return trophy;
  }

  return undefined;
}

trophy_clearstored() {
  self.trophies = undefined;
}

trophy_populatestored() {
  maxcharges = 4;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < maxcharges; _id_AC0E594AC96AA3A8++)
    trophy_addstored();
}

trophy_maxstored() {
  return 4;
}

trophy_modifieddamage(attacker, victim, sweapon, damage, _id_6CAC94B6632AA667) {
  if(!isDefined(sweapon))
    return [damage, _id_6CAC94B6632AA667];

  if(damage == 0)
    return [damage, _id_6CAC94B6632AA667];

  _id_512D1BC7ADD3EAA3 = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()) {
    switch (sweapon) {
      case "super_trophy_mp":
      case "player_trophy_system_mp":
      case "trophy_cp":
      case "trophy_mp":
        maxhealth = getdvarint("scr_player_maxhealth", 100);
        _id_512D1BC7ADD3EAA3 = 0.66 * maxhealth;
        break;
    }
  }

  _id_B85FF186894BA31E = _id_6CAC94B6632AA667;

  if(isDefined(_id_512D1BC7ADD3EAA3))
    _id_B85FF186894BA31E = _id_512D1BC7ADD3EAA3 - damage;

  _id_B85FF186894BA31E = min(_id_B85FF186894BA31E, _id_6CAC94B6632AA667);
  return [damage, _id_B85FF186894BA31E];
}

trophy_cleanuponparentdeath(parent, delay) {
  self endon("death");
  parent waittill("death");
  wait(delay);
  self delete();
}