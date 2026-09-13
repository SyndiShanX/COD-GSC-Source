/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\emp_drone_targeted.gsc
************************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp_drone_targeted", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("emp_drone_targeted", "init")]]();
}

empdrone_beginsuper() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  thread empdrone_superusethink();
  return 1;
}

empdrone_superusethink() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp_drone", self);
  result = empdrone_tryuse(streakinfo);
  wait 0.05;

  if(result) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "stat_D661AEA88FC83C08");
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
}

empdrone_tryuse(streakinfo) {}

empdrone_equipment_wrapper(ref, slot, objweapon) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "takeEquipment"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "takeEquipment")]](slot);

  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp_drone", self);
  used = empdrone_tryuse(streakinfo);

  if(!used) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "giveEquipment"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "giveEquipment")]]("equip_empdrone", slot);
  }
}

empdrone_weapongiven(streakinfo) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("empDroneTargeted", "startMapSelectSequence"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("empDroneTargeted", "startMapSelectSequence")]](0, 0, undefined, 3);
  else
    return 0;

  return 1;
}

empdrone_createdrone(streakinfo, targetpos) {
  self endon("disconnect");
  level endon("game_ended");
  _id_460F06FB83940B20 = empdrone_calculatepositions(targetpos);
  drone = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("emp_drone_proj_mp"), _id_460F06FB83940B20.startpos, _id_460F06FB83940B20.targetpos, self);
  drone setentityowner(self);
  drone.owner = self;
  drone.ownerid = self getentitynumber();
  drone.team = self.team;
  drone.streakinfo = streakinfo;
  drone.usedcount = 0;
  drone.superid = level.superglobals.staticsuperdata["super_emp_drone"].id;
  drone hidepart("j_propeller");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_wingtip_red_lit.vfx"), drone, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_contrails.vfx"), drone, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8/level/safehouse/vfx_safehouse_finale_drone_heat_dist.vfx"), drone, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx/iw8_mp/killstreak/vfx_rc_plane_rotor.vfx"), drone, "j_propeller");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("empDroneTargeted", "monitorDamage"))
    drone thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("empDroneTargeted", "monitorDamage")]](25, "hitequip", ::empdrone_handledeathdamage, undefined, 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    drone[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", self, 0, 1, 25);

  drone playLoopSound("iw8_rc_plane_engine");
  drone thread empdrone_timeoutthink();
  drone thread empdrone_gameendedthink();
  drone thread empdrone_collidethink();

  if(getdvarint("dvar_9A501FD816A448B6", 0) == 0)
    drone thread empdrone_divebombthink(_id_460F06FB83940B20);
  else
    drone thread empdrone_killstreaktargetthink(_id_460F06FB83940B20);

  drone scripts\cp_mp\emp_debuff::set_apply_emp_callback(::empdrone_empapplied);
  self _meth_FD165588822885F4(drone);
  return drone;
}

empdrone_calculatepositions(targetpos) {
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  heightoffset = (0, 0, 1500);

  if(isDefined(_id_5FA1E1697A302583)) {
    _id_D274915779774224 = _id_5FA1E1697A302583.origin[2] + -1500;
    heightoffset = (0, 0, _id_D274915779774224);
  }

  _id_90B08876A946FDF5 = anglesToForward(self.angles);
  startpos = undefined;
  _id_5B36D1353E9A2B32 = 0;
  angledelta = 0;
  _id_E26FF636F4ED6943 = 0;

  for(;;) {
    _id_0B298AF09B1A0DDD = rotatevector(_id_90B08876A946FDF5, (0, angledelta, 0));
    _id_8A88744AB78F625F = heightoffset + targetpos;
    startpos = _id_8A88744AB78F625F - _id_0B298AF09B1A0DDD * 4500;
    _id_DCB2A748D623DE32 = (0, 0, 1500);
    startpos = startpos + _id_DCB2A748D623DE32;
    _id_1BFA180C6FDD09DD = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    _id_5B36D1353E9A2B32 = scripts\engine\trace::ray_trace_passed(startpos, _id_8A88744AB78F625F, undefined, _id_1BFA180C6FDD09DD);
    _id_E26FF636F4ED6943++;

    if(_id_5B36D1353E9A2B32) {
      break;
    }

    if(_id_E26FF636F4ED6943 >= 13) {
      break;
    }

    wait 0.05;
    angledelta = angledelta + 55.3;
  }

  divebombpos = vectorNormalize(startpos - _id_8A88744AB78F625F) * 1000 + _id_8A88744AB78F625F;
  struct = spawnStruct();
  struct.startpos = startpos;
  struct.divebombpos = divebombpos;
  struct.targetpos = targetpos;
  return struct;
}

empdrone_timeoutthink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  currenttime = gettime() * 0.001;
  timeouttime = currenttime + 20;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(timeouttime);
  thread empdrone_destroy();
}

empdrone_gameendedthink() {
  self.owner endon("disconnect");
  self endon("death");
  level scripts\engine\utility::waittill_any_2("game_ended", "prematch_cleanup");
  thread empdrone_destroy();
}

empdrone_collidethink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self waittill("missile_stuck");
  thread empdrone_explode();
}

empdrone_divebombthink(_id_460F06FB83940B20) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self missile_settargetpos(_id_460F06FB83940B20.divebombpos);
  _id_4F2DE6F2A328C0DF = 50;

  while(distancesquared(_id_460F06FB83940B20.divebombpos, self.origin) > _id_4F2DE6F2A328C0DF * _id_4F2DE6F2A328C0DF)
    wait 0.05;

  _id_90B08876A946FDF5 = anglesToForward(self.angles);
  dist = distance(_id_460F06FB83940B20.targetpos, self.origin);
  _id_E62541575739DECF = self.origin + _id_90B08876A946FDF5 * dist;
  starttime = gettime();
  _id_6C469F968A8BFE3E = 0;
  _id_736AD6F118478397 = 0;

  for(;;) {
    wait 0.05;
    _id_6C469F968A8BFE3E = (gettime() - starttime) / 1300.0;
    _id_6C469F968A8BFE3E = clamp(_id_6C469F968A8BFE3E, 0, 1);
    relativepoint = _id_E62541575739DECF * (1 - _id_6C469F968A8BFE3E) + _id_460F06FB83940B20.targetpos * _id_6C469F968A8BFE3E;
    self missile_settargetpos(relativepoint);
  }
}

empdrone_killstreaktargetthink(_id_460F06FB83940B20) {}

empdrone_handledeathdamage(attacker, weapon, _id_D95DA0355CF4CCB4) {
  empdrone_givepointsfordeath(attacker);
  empdrone_destroy();
}

empdrone_explode() {
  self playSound("iw8_rc_plane_engine_exp");
  forward = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"), self.origin, forward);
  empdrone_explodeemp();
  empdrone_delete();
}

empdrone_destroy() {
  self playSound("recondrone_damaged");
  forward = anglesToForward(self.angles);
  playFX(scripts\engine\utility::getfx("vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"), self.origin, forward);
  empdrone_delete();
}

empdrone_delete() {
  self stoploopsound("iw8_rc_plane_engine");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onFieldUpgradeEnd"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onFieldUpgradeEnd")]]("super_emp_drone", self.usedcount);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "fieldUpgradeExpired"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self.superid, self.usedcount, 0);

  self delete();
}

empdrone_empapplied(data) {
  attacker = data.attacker;
  empdrone_givepointsfordeath(attacker);
  empdrone_destroy();
}

empdrone_givepointsfordeath(attacker) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("destroyed_equipment");
  }
}

empdrone_explodeemp() {
  _id_ADB14FF6EDFB13E3 = makeweapon("emp_drone_non_player_mp");
  _id_6A96CEBAF12D3691 = makeweapon("emp_drone_non_player_direct_mp");
  _id_9644D3F7DC618EAB = [];
  ents = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(ent in ents) {
    if(ent == self) {
      continue;
    }
    entowner = ent.owner;

    if(isDefined(entowner)) {
      if(entowner != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, entowner))
        continue;
    }

    _id_457471485336C961 = distancesquared(self.origin, ent.origin);

    if(_id_457471485336C961 > 640000) {
      continue;
    }
    isvehicle = ent scripts\cp_mp\vehicles\vehicle::isvehicle();
    _id_609019899015ED5D = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered(ent);

    if(isvehicle && _id_609019899015ED5D) {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

      foreach(_id_F85572CD5F6117C6 in occupants)
      _id_9644D3F7DC618EAB[_id_9644D3F7DC618EAB.size] = _id_F85572CD5F6117C6;
    }

    weapon = scripts\engine\utility::ter_op(_id_457471485336C961 > 6400, _id_ADB14FF6EDFB13E3, _id_6A96CEBAF12D3691);
    ent dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon);
    data = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, ent, 1, weapon, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(data);
  }

  _id_D13380BB17A918C0 = makeweapon("emp_drone_player_mp");
  self radiusdamage(self.origin, 80, 120, 80, self.owner, "MOD_EXPLOSIVE", _id_D13380BB17A918C0);
  players = scripts\common\utility::playersinsphere(self.origin, 800);
  players = scripts\engine\utility::array_combine_unique(players, _id_9644D3F7DC618EAB);

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }
    if(!player scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }
    if(player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, player)) {
      continue;
    }
    player dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", _id_D13380BB17A918C0);
    data = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, player, 1, _id_D13380BB17A918C0, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(data);
  }

  _id_7EF2F0C3237EAD8C = scripts\common\utility::playersinsphere(self.origin, 2000);
  _id_7EF2F0C3237EAD8C = scripts\engine\utility::array_combine_unique(_id_7EF2F0C3237EAD8C, _id_9644D3F7DC618EAB);

  foreach(player in _id_7EF2F0C3237EAD8C) {
    if(!isDefined(player)) {
      continue;
    }
    if(player == self.owner) {
      continue;
    }
    player earthquakeforplayer(0.3, 1, self.origin, 2000);
    player setclientomnvar("ui_hud_shake", 1);
    player playrumbleonpositionforclient("artillery_rumble_light", self.origin);
  }

  self.owner earthquakeforplayer(0.2, 1, self.owner.origin, 2000);
  self.owner setclientomnvar("ui_hud_shake", 1);
  self.owner playrumbleonpositionforclient("artillery_rumble_light", self.origin);
}

empdrone_applyemp(data) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(data);
  duration = 8;

  if(isPlayer(data.victim)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
      if(data.victim != self.owner && data.victim[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_emp_resist")) {
        duration = 2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback"))
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback")]]("hittacresist");
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "trackDebuffAssist"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "trackDebuffAssist")]](data.attacker, data.victim, data.objweapon.basename);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("empDroneHits", 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "combatRecordSuperMisc"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "combatRecordSuperMisc")]]("super_emp_drone");

  self.usedcount++;
  empdrone_empendearly(data, duration);

  if(isDefined(data.victim)) {
    data.victim scripts\cp_mp\emp_debuff::remove_emp();

    if(isDefined(data.attacker) && isPlayer(data.victim)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("gamescore", "untrackDebuffAssist"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("gamescore", "untrackDebuffAssist")]](data.attacker, data.victim, data.objweapon.basename);
    }
  }
}

empdrone_empendearly(data, duration) {
  data.victim endon("death_or_disconnect");
  level endon("game_ended");
  result = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", duration);

  if(result != "emp_cleared")
    data.empremoved = 1;
}