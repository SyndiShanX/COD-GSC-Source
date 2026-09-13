/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\scripted_trophy.gsc
*******************************************************/

trophy_init() {
  _id_2FC780A60BF174FC = spawnStruct();
  _id_2FC780A60BF174FC.tags = [];
  _id_2FC780A60BF174FC.tags[0] = "tag_barrel_1";
  _id_2FC780A60BF174FC.tags[1] = "tag_barrel_2";
  _id_2FC780A60BF174FC.tags[3] = "tag_barrel_3";
  level.trophy = _id_2FC780A60BF174FC;
}

_id_233602CC27D9FCF8(loc, _id_D60CC6DA4FB4A98C, ammocount, _id_D528BB5C61E19C2F, _id_C8251387149387A0) {
  trophy = magicgrenademanual("trophy_mp", loc.origin, (0, 0, 0));
  trophy._id_C5ED7E1AF63FB508 = 1;
  trophy.team = "axis";

  if(isDefined(_id_C8251387149387A0))
    trophy.team = _id_C8251387149387A0;

  trophy.owner = trophy;
  loc.trophy = trophy;
  trophy setscriptablepartstate("effects", "activeDeployStart");
  wait 1.25;
  trophy setscriptablepartstate("effects", "activeDeployEnd");

  if(istrue(_id_D60CC6DA4FB4A98C)) {
    maxhealth = 100;

    if(isDefined(_id_D528BB5C61E19C2F))
      maxhealth = _id_D528BB5C61E19C2F;

    damagefeedback = "hitequip";

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "monitorDamage"))
      trophy thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "monitorDamage")]](maxhealth, damagefeedback, ::trophy_handlefataldamage, ::trophy_handledamage, 0);

    trophy thread trophy_destroyonemp();
  }

  if(isDefined(ammocount))
    trophy._id_8529009219E1AD48 = ammocount;

  trophy.ammo = trophy._id_8529009219E1AD48;
  trophy.usedcount = 0;
  trophy thread trophy_destroyongameend();
  trophy.explosion = trophy_createexplosion(trophy);
  trophy thread trophy_watchprotection(45, 105625, ::_id_9F13CC66529C6E8F, ::_id_0509F8C901A3AE35);
}

trophy_destroyongameend() {
  self endon("death");
  self.owner endon("disconnect");
  level scripts\engine\utility::waittill_any_2("game_ended", "bro_shot_start");
  thread trophy_destroy();
}

trophy_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_applied", data);
  attacker = data.attacker;
  thread trophy_destroy(1);
}

trophy_deployanimation() {
  self endon("death");
}

trophy_remote_destroy(player) {
  trophy_destroy(1);
}

sweeptrophy() {
  thread trophy_delete(0);
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

trophy_destroy(_id_4FAC8B8CE36E09F1) {
  thread trophy_delete(0.1, _id_4FAC8B8CE36E09F1);
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

trophy_shutdownanddestroy(_id_4FAC8B8CE36E09F1) {
  thread trophy_delete(2.6, _id_4FAC8B8CE36E09F1);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);
  wait 2.5;
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

trophy_delete(_id_CBF7BE4F62A0DDB2, _id_4FAC8B8CE36E09F1) {
  self notify("death");
  self setscriptablepartstate("hack_usable", "off");
  self setCanDamage(0);
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(_id_CBF7BE4F62A0DDB2))
    wait(_id_CBF7BE4F62A0DDB2);

  scripts\cp_mp\ent_manager::deregisterspawn();
  self delete();
}

trophy_watchprotection(_id_69E07C42D3E11801, _id_05B95596970B49B4, _id_B701D494F3AE184F, _id_D0B9C256CE9D59F4) {
  self endon("death");
  trophy_castcontents = trophy_castcontents();

  while([[_id_B701D494F3AE184F]]()) {
    if(istrue(self.isdisabled)) {
      waitframe();
      continue;
    }

    _id_2CC97E113610CA14 = trophy_castorigin(_id_69E07C42D3E11801);
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
      if(_id_1DBABE317739127E == self) {
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

      _id_F31940D93AFC41DB = 1;

      if(_id_F31940D93AFC41DB) {
        if(isDefined(_id_1BA7B2D16DC215E1) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, _id_1BA7B2D16DC215E1)))
          continue;
      }

      if(distancesquared(_id_1DBABE317739127E.origin, self.origin) > trophy_modifiedprotectiondistsqr(_id_1DBABE317739127E, _id_05B95596970B49B4)) {
        continue;
      }
      _id_E021C2744CC7ED68 = physics_raycast(_id_2CC97E113610CA14, _id_1DBABE317739127E.origin, trophy_castcontents, [self, _id_1DBABE317739127E], 0, "physicsquery_closest");

      if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
        continue;
      }
      self[[_id_D0B9C256CE9D59F4]](_id_1DBABE317739127E);
    }

    waitframe();
  }
}

_id_9F13CC66529C6E8F() {
  return isDefined(self.owner);
}

_id_0509F8C901A3AE35(_id_1DBABE317739127E) {
  thread _id_DF73A01C76DE4B5C(_id_1DBABE317739127E);
}

_id_0BA83E8DC816C34B(_id_1DBABE317739127E) {
  _id_F081F86B3A475009 = 1;

  if(isDefined(_id_1DBABE317739127E) && isDefined(_id_1DBABE317739127E.weapon_name)) {
    switch (_id_1DBABE317739127E.weapon_name) {
      case "cruise_proj_mp":
        _id_F081F86B3A475009 = 3;
        break;
      case "iw9_la_juliet_mp":
        _id_F081F86B3A475009 = 3;
        break;
    }
  }

  return _id_F081F86B3A475009;
}

_id_DF73A01C76DE4B5C(_id_1DBABE317739127E) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_end");

  if(!isDefined(self.usedcount))
    self.usedcount = 0;

  self.usedcount++;
  _id_EDAD871174AA4C18 = _id_1DBABE317739127E.origin;
  _id_89F949A75D92E1A4 = _id_0BA83E8DC816C34B(_id_1DBABE317739127E);

  if(self.ammo >= _id_89F949A75D92E1A4) {
    _id_477783276EA16601(_id_1DBABE317739127E);
    logtrophysuccesful(_id_1DBABE317739127E);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_89F949A75D92E1A4; _id_AC0E594AC96AA3A8++) {
    childthread _id_363A32A7A77C9FE0(_id_EDAD871174AA4C18, _id_AC0E594AC96AA3A8);
    wait 0.2;
  }
}

_id_363A32A7A77C9FE0(_id_1DBABE317739127E, _id_305B1B326D21E99F) {
  if(self.ammo <= 0) {
    thread trophy_shutdownanddestroy(0);
    return 0;
  }

  _id_D7030318CA9E674A = _id_1DBABE317739127E;

  if(_id_305B1B326D21E99F > 1)
    _id_D7030318CA9E674A = _id_B2E78337C5DF1C34(_id_D7030318CA9E674A);

  tag = trophy_getbesttag(_id_D7030318CA9E674A);
  part = trophy_getpartbytag(tag);
  self setscriptablepartstate(part, "active", 0);
  _id_01331AEFD6D9A100 = vectortoangles(self gettagorigin(tag) - _id_D7030318CA9E674A);
  _id_CC29543DE9737588 = combineangles(_id_01331AEFD6D9A100, (-90, 0, 0));
  self.explosion thread trophy_explode(_id_D7030318CA9E674A, _id_CC29543DE9737588);
  self.ammo--;

  if(self.ammo <= 0)
    thread trophy_shutdownanddestroy(0);
}

_id_B2E78337C5DF1C34(_id_5C1A8852FEFEBEF5) {
  _id_F95C4B9D1740F23B = 0.05;
  _id_E5006C8CD0E8153A = randomfloatrange(0.9, 1.1);
  _id_8413896733593A21 = randomfloatrange(0.9, 1.1);
  _id_AB91C9EC1FAE3AB8 = randomfloatrange(0.8, 1.2);
  x = _id_5C1A8852FEFEBEF5[0];
  y = _id_5C1A8852FEFEBEF5[1];
  z = _id_5C1A8852FEFEBEF5[2];
  _id_B5C4765694E99F2A = x * _id_E5006C8CD0E8153A;
  _id_7898D81EAE47ECE1 = y * _id_8413896733593A21;
  z_delta = z * _id_AB91C9EC1FAE3AB8;

  if(abs(x - _id_B5C4765694E99F2A) < x * _id_F95C4B9D1740F23B)
    _id_B5C4765694E99F2A = _id_B5C4765694E99F2A + _id_B5C4765694E99F2A * _id_F95C4B9D1740F23B;

  if(abs(y - _id_7898D81EAE47ECE1) < y * _id_F95C4B9D1740F23B)
    _id_7898D81EAE47ECE1 = _id_7898D81EAE47ECE1 + _id_7898D81EAE47ECE1 * _id_F95C4B9D1740F23B;

  if(abs(z - z_delta) < z * _id_F95C4B9D1740F23B)
    z_delta = z_delta + z_delta * _id_F95C4B9D1740F23B;

  return (_id_B5C4765694E99F2A, _id_7898D81EAE47ECE1, z_delta);
}

_id_477783276EA16601(_id_1DBABE317739127E) {
  _id_1DBABE317739127E setCanDamage(0);
  _id_1DBABE317739127E.exploding = 1;
  _id_1DBABE317739127E stopsounds();
  attacker = undefined;

  if(isDefined(_id_1DBABE317739127E.owner))
    attacker = _id_1DBABE317739127E.owner;

  _id_D7030318CA9E674A = _id_1DBABE317739127E.origin;
  _id_CC29543DE9737588 = _id_1DBABE317739127E.angles;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "isPlantedEquipment")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "isPlantedEquipment")]](_id_1DBABE317739127E)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "deleteExplosive"))
        _id_1DBABE317739127E[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "deleteExplosive")]]();
    } else
      _id_1DBABE317739127E delete();
  } else
    _id_1DBABE317739127E delete();

  self.explosion thread trophy_explode(_id_D7030318CA9E674A, _id_CC29543DE9737588);

  if(!isDefined(self._id_780FCD96E8F599E0))
    self._id_780FCD96E8F599E0 = 0;

  self._id_780FCD96E8F599E0++;

  if(isDefined(attacker)) {
    level notify("trophyused", attacker);
    attacker thread _id_5762AC2F22202BA2::updatedamagefeedback("hittrophysystem");
  }
}

_id_8A10502DA0DED9AB() {
  self endon("death");
  _id_087F41F420EA77FA();
  thread trophy_shutdownanddestroy(0);
}

_id_087F41F420EA77FA() {
  level endon("game_ended");
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
  if(isDefined(data.attacker) && isPlayer(data.attacker))
    trophy_givepointsfordeath(data.attacker);

  thread trophy_destroy(1);
}

trophy_givepointsfordeath(attacker) {
  attacker notify("destroyed_equipment");
  attacker thread _id_098B53A7358927D9::_id_E800498086E36C29("stat_521EDEBB385E3753");
}

trophy_applyempcallback(data) {
  data.victim thread _id_EF909A912567CBD8(data);
}

_id_FA497EA83E7ADC8C(data) {
  data.victim trophy_givepointsfordeath(data.attacker);
  data.victim thread trophy_destroy(1);
}

_id_EF909A912567CBD8(data) {
  self endon("death");
  self.isdisabled = 1;
  self setscriptablepartstate("empd", "active", 0);
  wait 6.0;
  self.isdisabled = 0;
  self setscriptablepartstate("empd", "neutral", 0);
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
  explosion setModel("trophy_system_mp_explode");
  explosion.explode1available = 1;
  explosion thread trophy_cleanuponparentdeath(trophy, 0.1);
  return explosion;
}

trophy_explode(position, angles) {
  self dontinterpolate();
  self.origin = position;
  self.angles = angles;

  if(istrue(self.explode1available)) {
    self setscriptablepartstate("explode1", "activeDirectional", 0);
    self.explode1available = 0;
  } else {
    self setscriptablepartstate("explode2", "activeDirectional", 0);
    self.explode1available = 1;
  }
}

trophy_castorigin(_id_69E07C42D3E11801) {
  return self.origin + anglestoup(self.angles) * _id_69E07C42D3E11801;
}

trophy_castcontents() {
  return physics_createcontents(["physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_item"]);
}

trophy_modifiedprotectiondistsqr(_id_1DBABE317739127E, _id_05B95596970B49B4) {
  if(isDefined(_id_1DBABE317739127E.weapon_name) && isDefined(_id_1DBABE317739127E.owner)) {
    switch (_id_1DBABE317739127E.classname) {
      case "script_vehicle":
        if(211250.0 > _id_05B95596970B49B4)
          _id_05B95596970B49B4 = 211250.0;

        break;
      case "rocket":
        if(126750.0 > _id_05B95596970B49B4)
          _id_05B95596970B49B4 = 126750.0;

        break;
    }

    switch (_id_1DBABE317739127E.weapon_name) {
      case "iw9_la_kgolf_mp":
        if(126750.0 > _id_05B95596970B49B4)
          _id_05B95596970B49B4 = 126750.0;

        break;
    }
  }

  return _id_05B95596970B49B4;
}

trophy_checkignorelist(_id_1DBABE317739127E) {
  if(isDefined(_id_1DBABE317739127E._id_D442547D75DFFD09)) {
    if(istrue(_id_1DBABE317739127E._id_D442547D75DFFD09._id_0C3333778EC49A2C))
      return 1;
  }

  weaponname = _id_1DBABE317739127E.weapon_name;

  if(!isDefined(weaponname) && isDefined(_id_1DBABE317739127E.weapon_object))
    weaponname = _id_1DBABE317739127E.weapon_object.basename;

  if(isDefined(_id_1DBABE317739127E._id_835D1CD2262DAD74))
    return 1;

  if(isDefined(weaponname)) {
    if(_id_2669878CF5A1B6BC::iskillstreakweapon(weaponname) && weaponname != "cruise_proj_mp" && weaponname != "chopper_gunner_proj_mp")
      return 1;

    switch (weaponname) {
      case "trophy_mp":
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "isPlantedEquipment")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "isPlantedEquipment")]](_id_1DBABE317739127E))
            return 1;
        }

        break;
      case "iw8_fulton_bag_mp":
      case "offhand_spotter_scope_mp":
      case "supply_box_mp":
      case "uplinkball_tracking_mp":
      case "throwingknife_electric_mp":
      case "snapshot_grenade_danger_mp":
      case "micro_turret_mp":
      case "lighttank_mp":
      case "hb_sensor_mp":
      case "tac_cover_mp":
      case "throwingknife_fire_mp":
      case "tac_insert_trigger":
      case "throwingknife_mp":
      case "throwstar_mp":
      case "at_mine_ap_mp":
      case "pop_rocket_mp":
      case "bunkerbuster_burrowed_mp":
        return 1;
    }
  }

  return 0;
}

trophy_notifytrophytargetowner(_id_1DBABE317739127E, _id_C1D3B25C841AF510, _id_6B21EA0780AA76FE) {
  if(!isDefined(_id_1DBABE317739127E.owner) || !isPlayer(_id_1DBABE317739127E.owner)) {
    return;
  }
  _id_1DBABE317739127E.owner _id_5762AC2F22202BA2::updatedamagefeedback("hittrophysystem");

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
      return "barrel" + (id + 1);
  }

  return undefined;
}

#using_animtree("scriptables");

trophy_getdeployanimtime() {
  return getanimlength(%wm_trophy_system_deploy_landing);
}

trophy_givedamagefeedback(attacker) {
  damagefeedback = "";

  if(istrue(self.hasruggedeqp))
    damagefeedback = "hitequip";

  if(isPlayer(attacker))
    attacker _id_5762AC2F22202BA2::updatedamagefeedback(damagefeedback);
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

logtrophysuccesful(_id_1DBABE317739127E) {
  if(!isDefined(_id_1DBABE317739127E)) {
    return;
  }
  if(!isDefined(self.deployingplayer)) {
    return;
  }
  if(isDefined(_id_1DBABE317739127E.owner) && !isPlayer(_id_1DBABE317739127E.owner)) {
    return;
  }
  if(isDefined(_id_1DBABE317739127E.weapon_object))
    weaponname = _id_2669878CF5A1B6BC::getweaponrootname(_id_1DBABE317739127E.weapon_object);
  else
    return;

  if(!isDefined(weaponname)) {
    return;
  }
  dlog_recordevent("dlog_event_trophy_successful", ["deploying_player", self.deployingplayer, "grenade_owner", _id_1DBABE317739127E.owner, "negated_target", weaponname]);
}