/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\at_mine.gsc
***********************************************/

at_mine_init() {
  _id_F16AF5A8C61C30EE = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_at_mine", 1);
  _id_F16AF5A8C61C30EE.radius = 100;
  _id_F16AF5A8C61C30EE.triggercallback = ::at_mine_vehicle_trigger;
}

at_mine_use(grenade) {
  self endon("disconnect");
  grenade endon("death");

  if(scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp"))
    grenade.hasruggedeqp = 1;

  grenade scripts\cp_mp\ent_manager::registerspawn(2, ::deletemine);
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade thread at_mine_watch_game_end();
  _id_F99216CEE573EA7E = spawnStruct();
  _id_F99216CEE573EA7E.throwspeedforward = 100;
  _id_F99216CEE573EA7E.throwspeedup = -50;
  _id_F99216CEE573EA7E.castdivisions = 3;
  _id_F99216CEE573EA7E.castmaxtime = 0.5;
  _id_F99216CEE573EA7E.castdetail = 1;
  _id_F99216CEE573EA7E.plantmaxtime = 0.5;
  _id_F99216CEE573EA7E.plantmaxroll = 15;
  _id_F99216CEE573EA7E.plantmindistbeloweye = 12;
  _id_F99216CEE573EA7E.plantmaxdistbelowownerfeet = 20;
  _id_F99216CEE573EA7E.plantmindisteyetofeet = 45;
  _id_F99216CEE573EA7E.plantnormalcos = 0.342;
  grenade setscriptablepartstate("visibility", "show", 0);
  data = spawnStruct();
  data.endonstring = "mine_destroyed";
  data.skipdeath = 1;
  grenade thread scripts\mp\movers::handle_moving_platform_touch(data);
  grenade waittill("missile_stuck", stuckto, _id_1D9FB21B4F3023F3, surfacetype, velocity, position, normal);

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = grenade[[level._id_CA4E08767CBDAE12]]();

    if(!_id_425925A45729DEAE) {
      scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
      scripts\mp\equipment::incrementequipmentslotammo("primary");
      grenade delete();
      return;
    }
  }

  if(isDefined(stuckto)) {
    if(isent(stuckto) && is_train_ent(stuckto)) {
      grenade.origin = grenade.origin + (0, 0, 1.6);
      data._id_49CB2C45D3230ED8 = 1;
      grenade _meth_7E73001E97FE87B9(1);
    }

    grenade linkTo(stuckto);
  }

  thread at_mine_plant(grenade, surfacetype);
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

at_mine_update_danger_zone() {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }
  if(isDefined(self.dangerzone))
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);

  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(self.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

_id_427845AB37C184CD() {
  self endon("mine_destroyed");
  self endon("death");
  self waittill("missile_water_impact");
  self setscriptablepartstate("floats", "show", 0);
  self._id_B4331A150334BF61 = 1;
}

at_mine_plant(grenade, surfacetype) {
  grenade endon("mine_destroyed");
  grenade endon("death");
  grenade setotherent(self);
  grenade setentityowner(self);
  grenade missilethermal();

  if(!istrue(grenade._id_40E5B4307CB6229C))
    grenade missileoutline();

  grenade setnodeploy(1);
  grenade setscriptablepartstate("plant", "active", 0);
  self setscriptablepartstate("equipATMineFXView", "plant", 0);
  scripts\mp\weapons::onequipmentplanted(grenade, "equip_at_mine", ::at_mine_delete, isagent(self));
  thread scripts\mp\weapons::monitordisownedequipment(self, grenade);
  grenade scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", grenade.owner, 1);
  grenade thread scripts\mp\weapons::minedamagemonitor();
  grenade thread at_mine_watch_detonate();
  grenade scripts\cp_mp\emp_debuff::set_apply_emp_callback(::at_mine_empapplied);
  grenade _id_736DEC95A49487A6::_id_172D848D58051FDF(::_id_83D4163604FC28E3);
  grenade _id_49197CD063A740EA(::at_mine_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators)
    elevators thread _id_5F903436642211AF::_id_5C07037726AE5001(grenade);
  }

  grenade at_mine_update_danger_zone();
  armtime = 1.5;

  if(isDefined(grenade.armtime))
    armtime = grenade.armtime;

  wait(armtime / 2);

  if(istrue(grenade.touchedmovingplatform))
    grenade thread at_mine_movingplatform_update();

  wait(armtime / 2);
  grenade thread scripts\mp\equipment_interact::remoteinteractsetup(::at_mine_explode_from_player_trigger, 1, 1);
  grenade setscriptablepartstate("arm", "active", 0);
  grenade thread at_mine_watch_trigger();
  grenade thread scripts\mp\weapons::makeexplosiveusabletag("tag_use", 1);
  thread scripts\mp\weapons::outlineequipmentforowner(grenade);
  _id_5AE5E6CD7F0CC727 = 2;
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, _id_5AE5E6CD7F0CC727, undefined, undefined, undefined, 0.1, 1);
}

at_mine_explode_from_player_trigger(owner) {
  thread at_mine_delete(5);

  if(!isDefined(owner))
    owner = self.owner;

  self setentityowner(owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "fromPlayer", 0);
  self setscriptablepartstate("hacked", "neutral", 0);
}

at_mine_explode_from_vehicle_trigger(vehicle) {
  level endon("game_ended");
  thread at_mine_explode_from_vehicle_trigger_internal();

  if(isDefined(vehicle)) {
    vehicle dodamage(200, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon("at_mine_mp"));
    ignoredamageid = vehicle scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, makeweapon("at_mine_mp"), self, "MOD_EXPLOSIVE");
    waitframe();
    vehicle scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(ignoredamageid);
  }
}

at_mine_explode_from_vehicle_trigger_internal() {
  thread at_mine_delete(5);
  self setentityowner(self.owner);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromVehicle", 0);
}

at_mine_explode_from_notify(attacker) {
  thread at_mine_delete(5);
  self setentityowner(attacker);
  self clearscriptabledamageowner();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("explode", "fromDamage", 0);
}

at_mine_destroy(attacker) {
  self endon("death");
  thread at_mine_delete(5);
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("launch", "neutral", 0);
  self setscriptablepartstate("destroy", "active", 0);
}

at_mine_delete(_id_CBF7BE4F62A0DDB2) {
  if(istrue(self.isdestroyed) || !isDefined(self)) {
    return;
  }
  self.isdestroyed = 1;
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  self setscriptablepartstate("hack_usable", "off");
  self setCanDamage(0);
  scripts\mp\weapons::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  if(isDefined(self.owner))
    self.owner scripts\mp\weapons::removeequip(self);

  if(isDefined(self.dangericonent))
    self.dangericonent delete();

  _id_E478AC91AF0E92CB = self getlinkedchildren();

  if(isDefined(_id_E478AC91AF0E92CB)) {
    foreach(child in _id_E478AC91AF0E92CB) {
      if(isDefined(child) && isDefined(child.equipmentref) && child.equipmentref == "equip_claymore" && !istrue(child.exploding))
        child thread scripts\mp\equipment\claymore::claymore_destroy();
    }
  }

  if(isDefined(_id_CBF7BE4F62A0DDB2))
    wait(_id_CBF7BE4F62A0DDB2);

  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isDefined(self))
    self delete();
}

at_mine_movingplatform_update() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  self.attachedvelocity = (0, 0, 0);
  _id_E2A5E9ED59B3FDC0 = 0.2;

  for(;;) {
    _id_79D78DD32C9EAA49 = self.origin;
    wait(_id_E2A5E9ED59B3FDC0);
    self.attachedvelocity = 1 / _id_E2A5E9ED59B3FDC0 * (self.origin - _id_79D78DD32C9EAA49);
  }
}

is_at_mine_moving(mine) {
  return isDefined(mine) && isDefined(mine.attachedvelocity) && length2dsquared(mine.attachedvelocity) > 0.01;
}

at_mine_watch_trigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  for(;;) {
    self waittill("trigger_grenade", _id_F9B008542CD70A05);

    if(istrue(self.isdisabled)) {
      continue;
    }
    foreach(ent in _id_F9B008542CD70A05) {
      if(!isDefined(ent) || !isDefined(ent.classname)) {
        continue;
      }
      if(ent.classname == "script_vehicle") {
        if(ent scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_isfriendlytomine(self)) {
          continue;
        }
        if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(ent, self)) {
          continue;
        }
        scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(ent, self);
        break;
      }

      if(ent.classname == "agent" || ent.classname == "player") {
        if(!isPlayer(ent) && !isagent(ent)) {
          continue;
        }
        if(isDefined(ent.vehicle)) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(ent)) {
          continue;
        }
        thread at_mine_player_trigger(ent);
        break;
      }
    }
  }
}

at_mine_player_trigger(ent) {
  self endon("mine_destroyed");
  self endon("death");
  self notify("mine_triggered");
  self.triggeredbyplayer = 1;
  scripts\mp\weapons::makeexplosiveunusuabletag();
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  _id_9B1B9F121A84A4A1("at_mine_ap_mp", 100);
  scripts\mp\weapons::explosivetrigger(ent, 0.1);
  thread at_mine_watch_flight();
}

_id_9B1B9F121A84A4A1(_id_5DB09CF670B9EC64, fusetime) {
  dangericonent = scripts\mp\utility\weapon::_launchgrenade(_id_5DB09CF670B9EC64, self.origin, (0, 0, 0), fusetime, 1);
  dangericonent linkTo(self);
  thread at_mine_cleanup_danger_icon_ent(dangericonent);
  dangericonent.weapon_object = makeweapon(_id_5DB09CF670B9EC64);
  self.dangericonent = dangericonent;
}

at_mine_vehicle_trigger(vehicle, mine) {
  mine endon("mine_destroyed");
  mine endon("death");
  mine.owner endon("disconnect");
  mine notify("mine_triggered");
  mine scripts\mp\weapons::makeexplosiveunusuabletag();
  mine setscriptablepartstate("arm", "neutral", 0);
  mine setscriptablepartstate("trigger", "active", 0);
  wait 0.2;
  mine thread at_mine_explode_from_vehicle_trigger(vehicle);
}

at_mine_watch_flight_mover(flighttime) {
  self endon("death");
  self.grenade scripts\engine\utility::waittill_any_timeout_2(flighttime, "death", "mine_destroyed");

  if(isDefined(self.grenade))
    self moveTo(self.origin, 0.05, 0, 0);

  while(isDefined(self.grenade))
    waitframe();

  self delete();
}

deletemine() {
  at_mine_delete(0);
}

at_mine_watch_flight() {
  self endon("mine_destroyed");
  self endon("death");
  flighttime = 0.8;

  if(flighttime > 0) {
    flightdir = (0, 0, 1);
    _id_497EE714438FC27B = self.origin + flightdir * 64;
    contents = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle", "physicscontents_missileclip"]);
    ignorelist = scripts\mp\utility\equipment::get_mine_ignore_list();
    caststart = self.origin;
    castend = _id_497EE714438FC27B;
    _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1);

    if(isDefined(_id_E021C2744CC7ED68) && _id_E021C2744CC7ED68.size > 0) {
      _id_64B62CB5DC1E7AF6 = vectordot(_id_E021C2744CC7ED68[0]["position"] - caststart, flightdir);
      _id_64B62CB5DC1E7AF6 = max(0, _id_64B62CB5DC1E7AF6 - 1);
      flighttime = 0;
      _id_497EE714438FC27B = self.origin;

      if(_id_64B62CB5DC1E7AF6 > 0) {
        flighttime = _id_64B62CB5DC1E7AF6 / 64 * 0.8;
        _id_497EE714438FC27B = self.origin + flightdir * _id_64B62CB5DC1E7AF6;
      }
    }

    if(is_at_mine_moving(self))
      _id_497EE714438FC27B = _id_497EE714438FC27B + self.attachedvelocity * flighttime;

    if(flighttime > 0) {
      _id_3C08499BEED332CE = flighttime;
      _id_FC211CB9F7AE83CD = _id_3C08499BEED332CE * 0.81;

      if(is_at_mine_moving(self))
        _id_FC211CB9F7AE83CD = _id_FC211CB9F7AE83CD * 0.25;

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
      _id_9E0F9DB6CE29A5A9();
      childthread scripts\mp\utility\equipment::watch_flight_collision();
      scripts\engine\utility::waittill_any_timeout_1(flighttime, "collision_with_platform");
      thread at_mine_explode_from_player_trigger();
      return;
    }
  }
}

_id_9E0F9DB6CE29A5A9() {
  _id_6ECC08067178676F = "land";

  if(istrue(self._id_B4331A150334BF61))
    _id_6ECC08067178676F = "water";

  self setscriptablepartstate("launch", _id_6ECC08067178676F, 0);
}

at_mine_empapplied(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  if(isPlayer(attacker))
    attacker _id_5762AC2F22202BA2::updatedamagefeedback("");

  thread _id_416F3F7ADA048FF9(attacker);
}

_id_83D4163604FC28E3(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  if(isPlayer(attacker))
    attacker _id_5762AC2F22202BA2::updatedamagefeedback("");

  self notify("detonateExplosive", attacker);
}

at_mine_watch_detonate() {
  self endon("death");
  self waittill("detonateExplosive", attacker);

  if(isDefined(attacker))
    thread at_mine_explode_from_notify(attacker);
  else if(isDefined(self.owner))
    thread at_mine_explode_from_notify(self.owner);
  else
    thread at_mine_destroy();
}

at_mine_watch_game_end() {
  self endon("mine_destroyed");
  self endon("death");
  level scripts\engine\utility::waittill_any_2("game_ended", "bro_shot_start");
  thread at_mine_destroy();
}

at_mine_damage_vehicle_manually(vehicle) {
  vehicle dodamage(200, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon("at_mine_mp"));
  ignoredamageid = vehicle scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, makeweapon("at_mine_mp"), self, "MOD_EXPLOSIVE");
  waitframe();

  if(isDefined(vehicle))
    vehicle scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(ignoredamageid);
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

  if(_id_D14EEC85AC39C1CB > 60)
    return 0;

  _id_340D59422336E85A = self.origin - inflictor.origin;
  _id_F4EF78DE9CF3220A = vectordot(_id_340D59422336E85A, up);

  if(_id_F4EF78DE9CF3220A > 60)
    return 0;

  if(objweapon.basename == "at_mine_ap_mp" || istrue(inflictor.triggeredbyplayer)) {
    if(_id_D14EEC85AC39C1CB >= 0) {
      if(isDefined(level.gametype) && level.gametype == "br") {
        _id_BA53FEA232B95F20 = 75;
        _id_395702F102833BEE = 100;
      } else {
        _id_BA53FEA232B95F20 = 35;
        _id_395702F102833BEE = 35;
      }

      stance = victim getstance();

      if(stance == "prone" || self _meth_E40102956C887F7C())
        damage = int(min(damage, _id_BA53FEA232B95F20));
      else if(stance == "crouch" || self issprintsliding())
        damage = int(min(damage, _id_395702F102833BEE));
    }
  }

  if(isDefined(victim) && victim _meth_E5BF22923D0004BC()) {
    if(damage >= victim.health)
      damage = victim.health - 1;
  }

  return damage;
}

at_mine_cleanup_danger_icon_ent(dangericonent) {
  dangericonent endon("death");
  self waittill("death");
  dangericonent delete();
}

at_mine_onownerchanged(_id_C0F9139FFD72E62D) {
  self setscriptablepartstate("hacked", "active", 0);
  at_mine_update_danger_zone();
  sentientpool = self.sentientpool;
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  scripts\mp\sentientpoolmanager::registersentient(sentientpool, self.owner, 1);
  thread scripts\mp\weapons::monitordisownedequipment(self.owner, self);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
}

_id_416F3F7ADA048FF9(attacker) {
  self endon("death");
  attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_61A2D32E72064A0F");
  self.isdisabled = 1;
  self setscriptablepartstate("empd", "active", 0);
  wait 6.0;
  self.isdisabled = 0;
  self setscriptablepartstate("empd", "neutral", 0);
}

_id_49197CD063A740EA(_id_960061306B2CAAA6) {
  self._id_D1659ED0A33BF98F = _id_960061306B2CAAA6;
}