/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\trophy_system.gsc
**************************************************/

trophy_init() {
  _id_2FC780A60BF174FC = spawnStruct();
  _id_2FC780A60BF174FC.tags = [];
  _id_2FC780A60BF174FC.tags[0] = "tag_barrel_1";
  _id_2FC780A60BF174FC.tags[1] = "tag_barrel_2";
  _id_2FC780A60BF174FC.tags[2] = "tag_barrel_3";
  _id_2FC780A60BF174FC.timeout = getdvarfloat("dvar_D9B119233DF13AC1", 45.0);
  level.trophy = _id_2FC780A60BF174FC;
}

trophy_set(equipmentref, slot, variantid) {
  trophy_clearstored();
  trophy_populatestored();
}

trophy_onsuperset() {}

trophy_unset(equipmentref, slot) {
  trophy_clearstored();
}

_id_1D2418D7AA544534() {
  self endon("death");
  self.owner endon("disconnect");
  self endon("missile_stuck");
  self waittill("missile_water_impact", _id_850FDF3FB1C7EB84, _id_53F81081D4E7F40B, _id_71C76F81EB0C95EE);
  thread _id_74C86105E1BFE367(_id_53F81081D4E7F40B);
}

_id_74C86105E1BFE367(_id_53F81081D4E7F40B) {
  self endon("death");
  self.owner endon("disconnect");
  self endon("missile_stuck");
  _id_2D760AB785734B07 = 0;

  while(_id_2D760AB785734B07 < 20) {
    _id_2D760AB785734B07 = abs(_id_53F81081D4E7F40B[2] - self.origin[2]);

    if(_id_2D760AB785734B07 > 20) {
      self.owner thread _id_90DFE835641CA526();
      thread trophy_shutdownanddestroy(0);
    }

    waitframe();
  }
}

_id_90DFE835641CA526() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    scripts\engine\utility::delaythread(2.5, ::_id_FFB7ECAF8FCE4A9A);
  else
    scripts\mp\supers::refundsuper();
}

_id_FFB7ECAF8FCE4A9A() {
  _id_60227BFF1E9478CC = spawnStruct();
  _id_60227BFF1E9478CC.scriptablename = "brloot_offhand_trophysystem";
  _id_60227BFF1E9478CC.origin = self.origin;
  _id_60227BFF1E9478CC.count = 1;
  _id_60227BFF1E9478CC._id_8598D3D3BC3D9CEB = 1;
  _id_1A33360665B6BB36 = 0;

  if(isDefined(self.super) && istrue(self._id_1066FBD86C88A6DF))
    _id_1A33360665B6BB36 = 1;

  _id_7E52B56769FA7774::_id_B5F5576A0017C089(_id_60227BFF1E9478CC, undefined, self, undefined, undefined, undefined, _id_1A33360665B6BB36);
}

_id_857AFDA0A870989F(grenade) {
  level endon("game_ended");
  self endon("disconnect");
  grenade endon("death");
  _id_5F0B7D8E7D0627B8 = getdvarint("dvar_0D57482B850330A6", 150);
  grenade childthread _id_1D2418D7AA544534();

  for(;;) {
    grenade childthread trophy_watch_flight(self);
    grenade waittill("missile_stuck", _id_82D5E3B42D0191C9, _id_B3FCD958F4D7876E, surfacetype, velocity, position, _id_3E293ABD063AA9F5);
    _id_CB4D3248C7F2EADF = 0;

    if(isDefined(_id_82D5E3B42D0191C9)) {
      if(_id_82D5E3B42D0191C9 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(isDefined(_id_B3FCD958F4D7876E)) {
          _id_B3FCD958F4D7876E = scripts\common\vehicle::_id_8ED0FFA3F8BE7C75(_id_B3FCD958F4D7876E);
          _id_394B941C42B43BA0 = issubstr(_id_B3FCD958F4D7876E, "wheel");

          if(_id_394B941C42B43BA0)
            _id_CB4D3248C7F2EADF = 1;
        }
      }
    }

    if(_id_CB4D3248C7F2EADF) {
      grenade unlink();
      _id_F36436FA7801BB1C = _id_3E293ABD063AA9F5 + (self gettagorigin("j_spineupper") - grenade.origin);
      _id_A9706ADAF7C52E27 = grenade.origin + vectorNormalize(_id_F36436FA7801BB1C) * 10;
      grenade = scripts\mp\utility\weapon::_launchgrenade("trophy_mp", _id_A9706ADAF7C52E27, _id_3E293ABD063AA9F5 * _id_5F0B7D8E7D0627B8, undefined, 1, grenade);
      continue;
    }

    break;
  }

  return;
}

trophy_used(grenade) {
  grenade endon("death");
  self endon("disconnect");
  scripts\mp\utility\print::printgameaction("trophy spawned", self);
  grenade._id_D442547D75DFFD09 = scripts\mp\supers::_id_BF9C7E9DD30180E3("super_trophy");
  grenade scripts\cp_mp\ent_manager::registerspawn(2, ::sweeptrophy);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade thread _id_1D2418D7AA544534();
  grenade thread trophy_hideandshowaftertime();
  _id_857AFDA0A870989F(grenade);

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = grenade[[level._id_CA4E08767CBDAE12]]();

    if(!_id_425925A45729DEAE) {
      scripts\mp\supers::refundsuper();
      scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
      grenade delete();
      return;
    }
  }

  grenade setotherent(self);
  grenade setnodeploy(1);
  grenade.issuper = isDefined(self.super) && self.super.staticdata.ref == "super_trophy";
  grenade.superid = level.superglobals.staticsuperdata["super_trophy"].id;
  grenade.usedcount = 0;
  grenade.deployingplayer = self;
  _id_307667D0142F2035 = scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");

  if(_id_307667D0142F2035)
    grenade.hasruggedeqp = 1;

  if(!istrue(grenade.issuper)) {
    grenade.ammo = trophy_removestored();

    if(!isDefined(grenade.ammo))
      grenade.ammo = 3;

    grenade thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  } else
    grenade.ammo = 3;

  scripts\mp\weapons::onequipmentplanted(grenade, "equip_trophy", ::trophy_shutdownanddestroy);
  thread scripts\mp\weapons::monitordisownedequipment(self, grenade);
  grenade scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self);
  grenade.explosion = trophy_createexplosion(grenade);
  _id_B466B364114D5AE5 = scripts\engine\utility::_id_53C4C53197386572(grenade._id_D442547D75DFFD09._id_F96F1B8352A4D4E9, 100);
  _id_E2FD764179DE2D27 = scripts\engine\utility::_id_53C4C53197386572(grenade._id_D442547D75DFFD09._id_D37A7103C63003C4, 200);
  maxhealth = scripts\engine\utility::ter_op(_id_307667D0142F2035, _id_E2FD764179DE2D27, _id_B466B364114D5AE5);
  damagefeedback = "hitequip";
  grenade thread scripts\mp\damage::monitordamage(maxhealth, damagefeedback, ::trophy_handlefataldamage, ::trophy_handledamage, 0);
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::trophy_applyempcallback);
  grenade _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_FA497EA83E7ADC8C);
  grenade _id_49197CD063A740EA(::trophy_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      if(!isDefined(elevators)) {
        continue;
      }
      elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(grenade);
    }
  }

  grenade setscriptablepartstate("visibility", "show", 0);
  grenade thread trophy_deploy();
}

trophy_watch_flight(player) {
  self endon("death");
  self endon("missile_stuck");
  player endon("disconnect");
  msg = scripts\engine\utility::waittill_any_timeout_1(2, "touching_platform");

  if(msg == "timeout") {
    return;
  }
  groundentity = undefined;
  ignoreents = vehicle_getarrayinradius(self.origin, 500, 500);
  ignoreents[ignoreents.size] = self;
  _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
  tracestart = self.origin;
  _id_3A7F0173B03F5767 = -2000.0;
  _id_8B39E5984DA1FFAF = self.origin + (0.0, 0.0, _id_3A7F0173B03F5767);
  traceresults = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, _id_FBCABD62B8F66EB8);

  if(traceresults["fraction"] < 1.0) {
    groundentity = traceresults["entity"];

    if(isDefined(groundentity)) {
      if(is_train_ent(groundentity))
        self.origin = player.origin;
    }
  }
}

is_train_ent(_id_1D9FB21B4F3023F3) {
  if(isDefined(level.wztrain_info)) {
    foreach(ent in level.wztrain_info.train_array) {
      if(ent == _id_1D9FB21B4F3023F3)
        return 1;
      else if(isDefined(ent.linked_model) && ent.linked_model == _id_1D9FB21B4F3023F3)
        return 1;
    }
  }

  return 0;
}

trophy_deploy() {
  self endon("death");
  self setscriptablepartstate("effects", "activeLand");
  wait 0.1;
  thread trophy_deployanimation();
  wait 0.2;
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 25, undefined, undefined, undefined, undefined, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  thread trophy_watchprotection(45, 105625, ::_id_9F13CC66529C6E8F, ::_id_0509F8C901A3AE35);
  thread trophy_watchtimeoutorgameended();
  thread scripts\mp\equipment_interact::remoteinteractsetup(::trophy_remote_destroy, 1, 1);
  thread scripts\mp\perks\perk_equipmentping::runequipmentping();
  self.owner scripts\cp_mp\challenges::_id_D997435895422ECC("super_trophy", 0);
}

trophy_deployanimation() {
  self endon("death");
  self setscriptablepartstate("effects", "activeDeployStart");
  wait(trophy_getdeployanimtime());
  self setscriptablepartstate("effects", "activeDeployEnd");
}

trophy_hideandshowaftertime() {
  self endon("death");
  self endon("missile_stuck");
  _id_722684AF55E05749 = getdvarfloat("scr_trophy_proj_hide_duration", 0);
  self setscriptablepartstate("visibility", "hide", 0);
  wait(_id_722684AF55E05749);
  self setscriptablepartstate("visibility", "show", 0);
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
  level endon("game_ended");
  thread trophy_delete(2.6, _id_4FAC8B8CE36E09F1);
  self setscriptablepartstate("effects", "activeDestroyStart", 0);
  wait 2.5;
  self setscriptablepartstate("effects", "activeDestroyEnd", 0);
}

trophy_delete(_id_CBF7BE4F62A0DDB2, _id_4FAC8B8CE36E09F1) {
  self notify("death");
  self setscriptablepartstate("hack_usable", "off");
  self.owner scripts\cp_mp\challenges::_id_D997435895422ECC("super_trophy", 3, self.usedcount);
  scripts\mp\analyticslog::logevent_fieldupgradeexpired(self.owner, self.superid, self.usedcount, istrue(_id_4FAC8B8CE36E09F1));
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);

  if(!istrue(self.issuper)) {
    self makeunusable();
    scripts\mp\weapons::makeexplosiveunusuabletag();
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.owner)) {
    self.owner notify("trophy_update", 0);
    self.owner scripts\mp\weapons::removeequip(self);
  }

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
    scripts\cp_mp\utility\game_utility::_id_F5E8B13ACC5B4E24();

    foreach(targetarray in level._id_715AA7F8DE54C394 scripts\engine\utility::_id_0DF633F460888A47(self.origin)) {
      foreach(_id_1DBABE317739127E in targetarray) {
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
          if(isDefined(_id_1BA7B2D16DC215E1) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, _id_1BA7B2D16DC215E1)))
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

  if(!isDefined(_id_1DBABE317739127E))
    return _id_F081F86B3A475009;

  if(!isDefined(_id_1DBABE317739127E.weapon_name))
    return _id_F081F86B3A475009;

  switch (_id_1DBABE317739127E.weapon_name) {
    case "cruise_proj_mp":
      _id_F081F86B3A475009 = 3;
      break;
    case "iw9_la_juliet_mp":
      _id_F081F86B3A475009 = 3;
      break;
  }

  return _id_F081F86B3A475009;
}

_id_DF73A01C76DE4B5C(_id_1DBABE317739127E) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_end");
  self.owner thread scripts\mp\gamelogic::threadedsetweaponstatbyname("trophy_mp", 1, "hits");
  self.owner scripts\mp\utility\stats::incpersstat("trophySystemHits", 1);
  self.owner scripts\mp\supers::combatrecordsupermisc("super_trophy");
  self.usedcount++;
  _id_EDAD871174AA4C18 = _id_1DBABE317739127E.origin;
  _id_4F60747B7042E21F = trophy_modifiedprotectiondistsqr(_id_1DBABE317739127E, 105625);
  _id_72638B7E8B50D411 = _id_1DBABE317739127E.spawnpos;
  _id_89F949A75D92E1A4 = _id_0BA83E8DC816C34B(_id_1DBABE317739127E);

  if(self.ammo >= _id_89F949A75D92E1A4) {
    _id_477783276EA16601(_id_1DBABE317739127E);
    self.owner scripts\mp\killstreaks\killstreaks::givescorefortrophyblocks();
    logtrophysuccesful(_id_1DBABE317739127E);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_89F949A75D92E1A4; _id_AC0E594AC96AA3A8++) {
    childthread _id_363A32A7A77C9FE0(_id_EDAD871174AA4C18, _id_AC0E594AC96AA3A8, _id_4F60747B7042E21F);
    wait 0.2;
  }
}

_id_363A32A7A77C9FE0(_id_75B2197D2C846C44, _id_305B1B326D21E99F, _id_28EC07131B11812B) {
  if(self.ammo <= 0) {
    thread trophy_shutdownanddestroy(0);
    return 0;
  }

  _id_D7030318CA9E674A = _id_75B2197D2C846C44;
  _id_C96A7E0D1EC7BC53 = _id_EF4A284B37373510(_id_D7030318CA9E674A, _id_28EC07131B11812B);

  if(_id_C96A7E0D1EC7BC53)
    _id_D7030318CA9E674A = _id_514A12868913D9B7(_id_D7030318CA9E674A);

  if(_id_305B1B326D21E99F > 1)
    _id_D7030318CA9E674A = _id_B2E78337C5DF1C34(_id_D7030318CA9E674A);

  tag = trophy_getbesttag(_id_D7030318CA9E674A);
  part = trophy_getpartbytag(tag);
  self setscriptablepartstate(part, "active", 0);
  _id_01331AEFD6D9A100 = vectortoangles(self gettagorigin(tag) - _id_D7030318CA9E674A);
  _id_CC29543DE9737588 = combineangles(_id_01331AEFD6D9A100, (-90, 0, 0));
  self.explosion thread trophy_explode(_id_D7030318CA9E674A, _id_CC29543DE9737588);
  self setscriptablepartstate("sfx_" + part, "fire", 0);
  self.ammo--;

  if(self.ammo <= 0)
    thread trophy_shutdownanddestroy(0);
}

_id_EF4A284B37373510(_id_B4EFCFBD69FC05E4, _id_28EC07131B11812B) {
  return distancesquared(_id_B4EFCFBD69FC05E4, self.origin) < _id_28EC07131B11812B;
}

_id_514A12868913D9B7(_id_D7030318CA9E674A) {
  _id_CF6CCB76C65463E3 = _id_D7030318CA9E674A;
  _id_6BDB8335862F56EE = min(1 - 24 / length(self.origin - _id_D7030318CA9E674A), 1);
  _id_CF6CCB76C65463E3 = vectorlerp(self.origin, _id_CF6CCB76C65463E3, _id_6BDB8335862F56EE);
  return _id_CF6CCB76C65463E3;
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
  trophy_notifytrophytargetowner(_id_1DBABE317739127E, "trophy_mp", self.owner);
  trophy_tryreflectsnapshot(_id_1DBABE317739127E, _id_1DBABE317739127E.owner, self.owner);

  if(!_id_1DBABE317739127E scripts\mp\equipment::ondestroyedbytrophy()) {
    if(isDefined(_id_1DBABE317739127E.streakname) && _id_1DBABE317739127E.streakname == "cruise_predator")
      _id_1DBABE317739127E notify("trophy_blocked");
    else
      _id_1DBABE317739127E delete();
  }
}

trophy_tryreflectsnapshot(_id_1DBABE317739127E, victim, attacker) {
  if(!isDefined(_id_1DBABE317739127E.equipmentref) || _id_1DBABE317739127E.equipmentref != "equip_snapshot_grenade") {
    return;
  }
  if(!isDefined(_id_1DBABE317739127E.owner) || !isDefined(self.owner)) {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(victim)) {
    return;
  }
  owner = attacker;
  position = victim.origin;
  _id_7AA1FF687CFC30D1 = scripts\mp\equipment\snapshot_grenade::snapshot_grenade_createoutlinedata(owner, position);
  scripts\mp\equipment\snapshot_grenade::snapshot_grenade_applysnapshot(victim, attacker, _id_7AA1FF687CFC30D1);
}

trophy_watchtimeoutorgameended() {
  self endon("death");
  trophy_watchtimeoutorgameendedinternal();
  thread trophy_shutdownanddestroy(0);
}

trophy_watchtimeoutorgameendedinternal() {
  level endon("game_ended");
  timeout = level.trophy.timeout;

  if(!isDefined(timeout))
    timeout = 45.0;

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(timeout);
}

trophy_handledamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  _id_702BFC08FABD86CB = damage;
  _id_702BFC08FABD86CB = scripts\mp\damage::handlemeleedamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = scripts\mp\damage::handleapdamage(objweapon, type, _id_702BFC08FABD86CB, attacker);
  scripts\mp\weapons::equipmenthit(self.owner, attacker, objweapon, type);
  return _id_702BFC08FABD86CB;
}

trophy_handlefataldamage(data) {
  data.victim trophy_givepointsfordeath(data.attacker);
  data.victim thread trophy_destroy(1);
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

trophy_pickup() {
  if(self.owner scripts\mp\equipment::hasequipment("equip_trophy"))
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
  if(!isDefined(_id_1DBABE317739127E))
    return _id_05B95596970B49B4;

  if(isDefined(_id_1DBABE317739127E.weapon_name)) {
    switch (_id_1DBABE317739127E.weapon_name) {
      case "iw9_la_kgolf_mp":
        if(126750.0 > _id_05B95596970B49B4)
          _id_05B95596970B49B4 = 126750.0;

        break;
      case "cruise_proj_mp":
        if(237656.0 > _id_05B95596970B49B4)
          _id_05B95596970B49B4 = 237656.0;

        break;
    }
  }

  if(isDefined(_id_1DBABE317739127E.classname)) {
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

  if(isDefined(weaponname)) {
    if(istrue(_id_FC792B373D83F8D4(weaponname)))
      return 1;

    if(scripts\mp\utility\weapon::isaxeweapon(weaponname))
      return 1;

    switch (weaponname) {
      case "trophy_mp":
        if(scripts\mp\weapons::isplantedequipment(_id_1DBABE317739127E))
          return 1;

        break;
      case "iw8_fulton_bag_mp":
      case "offhand_spotter_scope_mp":
      case "hb_sensor_mp":
      case "supply_box_mp":
      case "snapshot_grenade_danger_mp":
      case "uplinkball_tracking_mp":
      case "tac_cover_mp":
      case "throwingknife_electric_mp":
      case "lighttank_mp":
      case "micro_turret_mp":
      case "tac_insert_trigger":
      case "throwingknife_fire_mp":
      case "throwstar_mp":
      case "throwingknife_mp":
      case "at_mine_ap_mp":
      case "bunkerbuster_burrowed_mp":
      case "pop_rocket_mp":
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
      case "jackal_cannon_mp":
      case "switch_blade_child_mp":
      case "drone_hive_projectile_mp":
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

trophy_givepointsfordeath(attacker) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
    attacker thread scripts\mp\battlechatter_mp::_id_883240EB5234490E("stat_2A7B7FEA9428CD37");
  }
}

#using_animtree("scriptables");

trophy_getdeployanimtime() {
  return getanimlength(%wm_trophy_system_deploy);
}

trophy_givedamagefeedback(attacker) {
  damagefeedback = "";

  if(istrue(self.hasruggedeqp))
    damagefeedback = "hitequip";

  if(isPlayer(attacker))
    attacker _id_5762AC2F22202BA2::updatedamagefeedback(damagefeedback);
}

trophy_addstored(ammo) {
  if(!isDefined(self.trophies))
    self.trophies = [];

  if(self.trophies.size < trophy_maxstored()) {
    if(!isDefined(ammo))
      ammo = 3;

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
  maxcharges = scripts\mp\equipment::getequipmentmaxammo("equip_trophy");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < maxcharges; _id_AC0E594AC96AA3A8++)
    trophy_addstored();
}

trophy_maxstored() {
  return scripts\mp\equipment::getequipmentmaxammo("equip_trophy");
}

trophy_modifieddamage(attacker, victim, sweapon, damage, _id_6CAC94B6632AA667) {
  if(!isDefined(sweapon))
    return [damage, _id_6CAC94B6632AA667];

  if(damage == 0)
    return [damage, _id_6CAC94B6632AA667];

  _id_512D1BC7ADD3EAA3 = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19()) {
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

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}

_id_FC792B373D83F8D4(weaponname) {
  _id_C3B3F1E6760E03F1 = undefined;

  if(_id_2669878CF5A1B6BC::iskillstreakweapon(weaponname)) {
    _id_C3B3F1E6760E03F1 = 1;

    switch (weaponname) {
      case "cruise_proj_mp":
      case "chopper_gunner_proj_mp":
      case "cluster_spike_proj_mp":
      case "cluster_spike_mp":
        _id_C3B3F1E6760E03F1 = 0;
        break;
    }
  }

  return _id_C3B3F1E6760E03F1;
}

_id_D70F6FA2C37C1230(_id_C0F9139FFD72E62D) {
  self setscriptablepartstate("hacked", "active", 0);
  sentientpool = self.sentientpool;
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  scripts\mp\sentientpoolmanager::registersentient(sentientpool, self.owner);
  thread scripts\mp\weapons::monitordisownedequipment(self.owner, self);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
}