/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\cp_at_mine.gsc
***********************************************/

at_mine_use(grenade) {
  self endon("death");
  self endon("disconnect");
  grenade endon("death");
  grenade.grenade_owner_name = self.name;
  thread _id_74502A9E0EF1F19C::monitordisownedequipment(self, grenade);
  grenade thread at_mine_watch_game_end();
  grenade setscriptablepartstate("visibility", "show", 0);
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(stuckto))
    grenade linkTo(stuckto);

  thread at_mine_plant(grenade);
}

at_mine_plant(grenade) {
  grenade endon("mine_destroyed");
  grenade endon("death");

  if(isPlayer(self))
    self endon("disconnect");

  if(isPlayer(self)) {
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "stat_98BD43C783A97C73");
    grenade setotherent(self);
    grenade setentityowner(self);
  }

  grenade missilethermal();
  grenade missileoutline();
  grenade setnodeploy(1);
  grenade setscriptablepartstate("plant", "active", 0);
  grenade enableplayermarks("equipment");

  if(isPlayer(self)) {
    self setscriptablepartstate("equipATMineFXView", "plant", 0);
    _id_74502A9E0EF1F19C::onlethalequipmentplanted(grenade, "equip_at_mine", 1);
    thread _id_74502A9E0EF1F19C::monitordisownedequipment(self, grenade);
  } else
    level thread _id_74502A9E0EF1F19C::add_to_mine_list(grenade);

  grenade thread scripts\cp\cp_equipment::makeexplosiveusabletag("tag_use", 1);
  grenade thread _id_74502A9E0EF1F19C::minedamagemonitor();
  grenade thread at_mine_watch_detonate();
  grenade thread at_mine_watch_emp();
  wait 1;
  playertrigger = grenade at_mine_create_player_trigger();
  grenade.playertrigger = playertrigger;
  grenade thread _id_74502A9E0EF1F19C::minedeletetrigger(playertrigger);
  grenade thread at_mine_watch_player_trigger(playertrigger);
  grenade thread at_mine_watch_vehicle_trigger();
}

at_mine_explode_from_player_trigger(owner) {
  thread at_mine_delete(1);

  if(isDefined(owner)) {
    self setentityowner(owner);
    self clearscriptabledamageowner();
  }

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    foreach(player in level.players) {
      if(player isufo()) {
        continue;
      }
      if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
        if(distance2d(self.origin, player.vehicle.origin) < 200)
          player.shouldskipdeathsshield = 1;

        continue;
      }

      if(distance2d(self.origin, player.origin) < 64)
        player.shouldskipdeathsshield = 1;
    }
  }

  self.team = "neutral";
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "fromPlayer", 0);
}

at_mine_explode_from_vehicle_trigger(ent) {
  if(isDefined(ent))
    thread at_mine_damage_manually(self.owner, ent);

  thread at_mine_delete(1);
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromVehicle", 0);
}

at_mine_explode_from_notify(attacker) {
  thread at_mine_delete(1);
  self setentityowner(attacker);
  self clearscriptabledamageowner();
  self.team = "neutral";
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromDamage", 0);
}

at_mine_destroy(attacker) {
  thread at_mine_delete(1);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

at_mine_delete(_id_CBF7BE4F62A0DDB2) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setCanDamage(0);
  _id_74502A9E0EF1F19C::makeexplosiveunusuabletag();
  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner) && isDefined(owner.plantedlethalequip))
    owner.plantedlethalequip = scripts\engine\utility::array_remove(owner.plantedlethalequip, self);

  if(isDefined(self.dangericonent))
    self.dangericonent delete();

  if(isDefined(self.useobj))
    self.useobj delete();

  if(isDefined(_id_CBF7BE4F62A0DDB2))
    wait(_id_CBF7BE4F62A0DDB2);

  level notify("grenade_exploded_during_stealth", self.origin, "at_mine_mp", self.grenade_owner_name);

  if(isDefined(self))
    self delete();
}

at_mine_create_player_trigger() {
  trigger = spawn("trigger_rotatable_radius", self.origin, 0, 100, 50);
  trigger.angles = self.angles;
  trigger enablelinkTo();
  trigger linkTo(self);
  trigger hide();
  trigger.mine = self;
  return trigger;
}

at_mine_watch_player_trigger(trigger) {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);

  for(;;) {
    trigger waittill("trigger", ent);

    if(!isDefined(ent)) {
      continue;
    }
    if(!isPlayer(ent) && !isagent(ent)) {
      continue;
    }
    if(isDefined(ent.vehicle)) {
      continue;
    }
    if(!ent scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, ent))) {
      continue;
    }
    thread at_mine_player_trigger(ent);
  }
}

at_mine_player_trigger(ent) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  self.triggeredbyplayer = 1;
  _id_74502A9E0EF1F19C::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  dangericonent = scripts\cp\utility::_launchgrenade("at_mine_ap_mp", self.origin, (0, 0, 0), 100, 1);
  dangericonent linkTo(self);
  thread at_mine_cleanup_danger_icon_ent(dangericonent);
  dangericonent.weapon_object = makeweapon("at_mine_ap_mp");
  self.dangericonent = dangericonent;
  graceperiod = 0.1;

  if(isPlayer(ent))
    graceperiod = graceperiod + 0.5;

  _id_74502A9E0EF1F19C::explosivetrigger(ent, graceperiod);
  thread at_mine_watch_flight();
}

at_mine_watch_vehicle_trigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  _id_EB84E55F9641A972 = [(0, 0, 0), (60, 0, 0), (-60, 0, 0)];
  _id_530EA3B256EB4800 = 75;
  _id_09AA2B3C8A147D8E = _id_530EA3B256EB4800 * _id_530EA3B256EB4800;
  _id_2E9381E1A66202EE = 30;
  _id_C4CF8191F6BAB561 = [(0, 0, 0), (22, 0, 0), (-22, 0, 0)];
  _id_FA65C6B8AD0E1249 = 96;
  _id_687D10FCBA24910D = _id_FA65C6B8AD0E1249 * _id_FA65C6B8AD0E1249;
  _id_9787897A564D9409 = 15;

  for(;;) {
    _id_DDDC24BA34981C53 = getactivebradleys();

    if(isDefined(_id_DDDC24BA34981C53)) {
      foreach(bradley in _id_DDDC24BA34981C53) {
        if(!isDefined(bradley)) {
          continue;
        }
        if(level.teambased) {
          if(bradley.team == self.owner.team)
            continue;
        } else if(isDefined(bradley.owner) && bradley.owner == self.owner) {
          continue;
        }
        _id_996A07FD7388DB1C = anglestoaxis(bradley.angles);

        foreach(offset in _id_EB84E55F9641A972) {
          _id_A862BFA81AEE2A1B = bradley.origin;
          _id_A862BFA81AEE2A1B = _id_A862BFA81AEE2A1B + _id_996A07FD7388DB1C["right"] * offset[0];
          _id_A862BFA81AEE2A1B = _id_A862BFA81AEE2A1B + _id_996A07FD7388DB1C["forward"] * offset[1];
          _id_A862BFA81AEE2A1B = _id_A862BFA81AEE2A1B + _id_996A07FD7388DB1C["up"] * offset[2];
          _id_340D59422336E85A = self.origin - _id_A862BFA81AEE2A1B;
          _id_4504CCE2AD14F2B2 = vectordot(_id_340D59422336E85A, _id_996A07FD7388DB1C["up"]);

          if(abs(_id_4504CCE2AD14F2B2) > _id_2E9381E1A66202EE) {
            continue;
          }
          _id_6602B5E32BB277D4 = _id_340D59422336E85A - _id_996A07FD7388DB1C["up"] * _id_4504CCE2AD14F2B2;

          if(lengthsquared(_id_6602B5E32BB277D4) > _id_09AA2B3C8A147D8E) {
            continue;
          }
          thread at_mine_vehicle_trigger(bradley);
          return;
        }
      }
    }

    remotetanks = level.assaultdrones;

    if(isDefined(remotetanks)) {
      foreach(_id_F5E7C5E12051B3EB in remotetanks) {
        if(!isDefined(_id_F5E7C5E12051B3EB)) {
          continue;
        }
        if(!isDefined(_id_F5E7C5E12051B3EB.streakname) || _id_F5E7C5E12051B3EB.streakname != "pac_sentry") {
          continue;
        }
        if(isDefined(_id_F5E7C5E12051B3EB.owner) && !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(_id_F5E7C5E12051B3EB.owner, self.owner))) {
          continue;
        }
        _id_996A07FD7388DB1C = anglestoaxis(_id_F5E7C5E12051B3EB.angles);

        foreach(offset in _id_C4CF8191F6BAB561) {
          _id_43C0A159A5F31309 = _id_F5E7C5E12051B3EB.origin;
          _id_43C0A159A5F31309 = _id_43C0A159A5F31309 + _id_996A07FD7388DB1C["right"] * offset[0];
          _id_43C0A159A5F31309 = _id_43C0A159A5F31309 + _id_996A07FD7388DB1C["forward"] * offset[1];
          _id_43C0A159A5F31309 = _id_43C0A159A5F31309 + _id_996A07FD7388DB1C["up"] * offset[2];
          _id_340D59422336E85A = self.origin - _id_43C0A159A5F31309;
          _id_4504CCE2AD14F2B2 = vectordot(_id_340D59422336E85A, _id_996A07FD7388DB1C["up"]);

          if(abs(_id_4504CCE2AD14F2B2) > _id_9787897A564D9409) {
            continue;
          }
          _id_6602B5E32BB277D4 = _id_340D59422336E85A - _id_996A07FD7388DB1C["up"] * _id_4504CCE2AD14F2B2;

          if(lengthsquared(_id_6602B5E32BB277D4) > _id_687D10FCBA24910D) {
            continue;
          }
          thread at_mine_vehicle_trigger(_id_F5E7C5E12051B3EB);
          return;
        }
      }
    }

    waitframe();
  }
}

getactivebradleys() {
  vehicles = [];

  foreach(_id_2E5DD95DB315D919 in level.vehicle.instances) {
    foreach(vehicle in _id_2E5DD95DB315D919)
    vehicles[vehicles.size] = vehicle;
  }

  if(isDefined(level.bradley))
    vehicles = scripts\engine\utility::array_combine(vehicles, level.bradley.activevehicles["total"]);

  if(vehicles.size == 0)
    return undefined;

  return vehicles;
}

at_mine_vehicle_trigger(ent) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");
  self notify("mine_triggered");
  _id_74502A9E0EF1F19C::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  wait 0.2;
  thread at_mine_explode_from_vehicle_trigger(ent);
}

at_mine_watch_flight_mover(flighttime) {
  self endon("death");
  self.grenade scripts\engine\utility::waittill_any_timeout_2(flighttime, "death", "mine_destroyed");

  if(isDefined(self.grenade))
    self moveTo(self.origin, 0.05, 0, 0);

  wait 2;
  self delete();
}

at_mine_watch_flight() {
  self endon("mine_destroyed");
  self endon("death");
  flighttime = 0.7;

  if(flighttime > 0) {
    flightdir = (0, 0, 1);
    _id_497EE714438FC27B = self.origin + flightdir * 64;
    contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
    caststart = self.origin;
    castend = _id_497EE714438FC27B;
    _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, self, 0, "physicsquery_closest", 1);

    if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
      _id_64B62CB5DC1E7AF6 = vectordot(_id_E021C2744CC7ED68[0]["position"] - caststart, flightdir);
      _id_64B62CB5DC1E7AF6 = max(0, _id_64B62CB5DC1E7AF6 - 1);
      flighttime = 0;
      _id_497EE714438FC27B = self.origin;

      if(_id_64B62CB5DC1E7AF6 > 0) {
        flighttime = _id_64B62CB5DC1E7AF6 / 64 * 0.7;
        _id_497EE714438FC27B = self.origin + flightdir * _id_64B62CB5DC1E7AF6;
      }
    }

    if(flighttime > 0) {
      _id_3C08499BEED332CE = flighttime;
      _id_FC211CB9F7AE83CD = _id_3C08499BEED332CE * 0.93;
      _id_3C08499BEED332CE = _id_3C08499BEED332CE - _id_FC211CB9F7AE83CD;
      _id_7162EC9DD06A7BB8 = 0;

      if(_id_3C08499BEED332CE > 0)
        _id_7162EC9DD06A7BB8 = _id_3C08499BEED332CE * 0;

      mover = spawn("script_model", self.origin);
      mover.angles = vectortoangles(anglesToForward(self.angles) * (1, 1, 0));
      mover setModel("tag_origin");
      self.mover = mover;
      mover.grenade = self;
      self linkTo(mover, "tag_origin", (0, 0, 0), (0, 0, 0));
      mover moveTo(_id_497EE714438FC27B, flighttime, _id_7162EC9DD06A7BB8, _id_FC211CB9F7AE83CD);
      mover thread at_mine_watch_flight_mover(flighttime);
      thread at_mine_watch_flight_effects(flighttime);
      wait(flighttime);
      thread at_mine_explode_from_player_trigger();
      return;
    }
  }
}

at_mine_watch_flight_effects(flighttime) {
  self endon("mine_destroyed");
  self endon("death");
  self setscriptablepartstate("launch", "active", 0);
}

at_mine_watch_emp() {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");

  for(;;) {
    self waittill("emp_applied", data);
    attacker = data.attacker;

    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
      attacker notify("destroyed_equipment");

      if(isPlayer(attacker))
        attacker _id_354C862768CFE202::updatedamagefeedback("standard");

      thread at_mine_destroy();
    }
  }
}

at_mine_watch_detonate() {
  self endon("death");
  self.owner endon("disconnect");
  owner = self.owner;
  self waittill("detonateExplosive", attacker);

  if(isDefined(attacker))
    thread at_mine_explode_from_notify(attacker);
  else
    thread at_mine_explode_from_notify(owner);
}

at_mine_watch_game_end() {
  self endon("mine_destroyed");
  self endon("death");
  level scripts\engine\utility::waittill_any_2("game_ended", "bro_shot_start");
  thread at_mine_destroy();
}

at_mine_damage_manually(attacker, _id_1DE3E0EA1C8B2ABA) {
  _id_1DE3E0EA1C8B2ABA endon("death");
  weapon = makeweapon("at_mine_mp");
  waitframe();
  _id_FBFF02C9C978437F = 200;

  if(isDefined(_id_1DE3E0EA1C8B2ABA.mine_damage_override))
    _id_FBFF02C9C978437F = _id_1DE3E0EA1C8B2ABA.mine_damage_override;

  if(isDefined(attacker) && isDefined(self)) {
    _id_1DE3E0EA1C8B2ABA dodamage(_id_FBFF02C9C978437F, self.origin, attacker, self, "MOD_EXPLOSIVE", weapon);
    _id_1DE3E0EA1C8B2ABA notify("damage", _id_FBFF02C9C978437F, self.origin, attacker, self, "MOD_EXPLOSIVE", weapon);
  }
}

at_mine_modified_damage(victim, inflictor, objweapon, meansofdeath, damage) {
  if(!isDefined(inflictor))
    return damage;

  if(meansofdeath != "MOD_EXPLOSIVE")
    return damage;

  if(!isDefined(objweapon))
    return damage;

  if(isnullweapon(objweapon))
    return damage;

  if(objweapon.basename != "at_mine_mp" && objweapon.basename != "at_mine_ap_mp")
    return damage;

  up = anglestoup(inflictor.angles);
  _id_340D59422336E85A = inflictor.origin - self getEye();
  _id_D14EEC85AC39C1CB = vectordot(_id_340D59422336E85A, up);

  if(_id_D14EEC85AC39C1CB > 46)
    return 0;

  _id_340D59422336E85A = self.origin - inflictor.origin;
  _id_F4EF78DE9CF3220A = vectordot(_id_340D59422336E85A, up);

  if(_id_F4EF78DE9CF3220A > 46)
    return 0;

  if(objweapon.basename == "at_mine_ap_mp" || istrue(inflictor.triggeredbyplayer)) {
    if(_id_D14EEC85AC39C1CB >= 0) {
      stance = victim getstance();

      if(stance == "prone")
        damage = int(min(damage, 35));
      else if(stance == "crouch")
        damage = int(min(damage, 55));
    }
  }

  return damage;
}

at_mine_cleanup_danger_icon_ent(dangericonent) {
  dangericonent endon("death");
  self waittill("death");
  dangericonent delete();
}

remotedetonatethink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("remote_detonate", player);
    thread at_mine_explode_from_player_trigger(player);
  }
}

remotedefusesetup() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  hintstring = &"PERKS/REMOTE_DEFUSE_HINT";
  _id_E213CDC03C01A000 = 0;
  self.useobj = scripts\cp\utility::createhintobject(self.origin + anglestoup(self.angles) * 7, "HINT_BUTTON", undefined, hintstring, _id_E213CDC03C01A000, undefined, "show", 250, 160, 200, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(player in level.players)
  self.useobj disableplayeruse(player);

  thread defusethink();
  thread defuseusemonitoring();

  for(;;) {
    self waittill("defused", player);

    if(isPlayer(player))
      thread at_mine_explode_from_player_trigger(player);
  }
}

defuseusemonitoring() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    wait 0.1;

    foreach(player in level.players) {
      if(player.team == self.team || !player scripts\cp\utility::_hasperk("specialty_remote_defuse")) {
        self.useobj disableplayeruse(player);
        continue;
      }

      self.useobj enableplayeruse(player);
    }
  }
}

defusethink() {
  self endon("restarting_physics");
  _id_88032DC5704DA634 = self.useobj;
  _id_DBCE45A33308630D = undefined;

  if(istrue(level.gameended) && !isDefined(_id_88032DC5704DA634)) {
    return;
  }
  while(isDefined(self)) {
    _id_88032DC5704DA634 waittill("trigger", player);

    if(isDefined(self.owner) && player == self.owner) {
      continue;
    }
    player.iscapturingcrate = 1;
    _id_DBCE45A33308630D = scripts\cp\utility::createuseent();
    _id_DBCE45A33308630D.id = "breach_defuse";
    result = _id_DBCE45A33308630D scripts\cp\cp_deployablebox::useholdthink(player, getdvarfloat("perk_defuse_equipment_time"));

    if(!isDefined(player)) {
      return;
    }
    if(!result) {
      player.iscapturingcrate = 0;
      continue;
    }

    player.iscapturingcrate = 0;
    self notify("defused", player);
  }
}