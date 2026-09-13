/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\emp_drone.gsc
***************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp_drone", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("emp_drone", "init")]]();
}

empdrone_beginsuper() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
    return 0;

  thread empdrone_superusethink();
  return 1;
}

empdrone_superusethink() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("emp_drone", self);
  result = empdrone_tryuse(streakinfo);

  if(!result)
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  wait 0.05;

  if(result) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]]();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "stat_D661AEA88FC83C08");
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "superUseFinished"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "superUseFinished")]](1);
}

empdrone_tryuse(streakinfo) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, ::empdrone_weapongiven);

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  thread empdrone_rundrone(streakinfo);
  return 1;
}

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
  return 1;
}

empdrone_rundrone(streakinfo) {
  self endon("disconnect");
  level endon("game_ended");
  self disablephysicaldepthoffieldscripting();
  _id_3B64EB40368C1450::set("empDrone", "fire", 0);
  _id_3B64EB40368C1450::set("empDrone", "melee", 0);
  _id_3B64EB40368C1450::set("empDrone", "weapon_switch", 0);
  _id_3B64EB40368C1450::set("empDrone", "usability", 0);
  _id_3B64EB40368C1450::set("empDrone", "gesture", 0);
  drone = empdrone_createdrone(streakinfo);
  drone.iscontrolled = 1;
  drone.usedcount = 0;
  drone.superid = level.superglobals.staticsuperdata["super_emp_drone"].id;
  self controlslinkTo(drone);
  self cameralinkTo(drone, "tag_origin");
  self setplayerangles(drone.angles);
  self painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  self setclientomnvar("ui_emp_drone_overlay", 1);
}

empdrone_createdrone(streakinfo) {
  _id_45306A38C5430B1A = empdrone_findstartposition();
  _id_4C44BD3C9BAC5AE2 = vectortoangles(_id_45306A38C5430B1A.targetpos - _id_45306A38C5430B1A.startpos);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  spawndata = spawnStruct();
  spawndata.origin = _id_45306A38C5430B1A.startpos;
  spawndata.angles = _id_4C44BD3C9BAC5AE2;
  spawndata.modelname = "veh8_ind_air_bombing_drone";
  spawndata.vehicletype = "rcplane_physics_mp";
  spawndata.targetname = "rcplane";
  spawndata.cannotbesuspended = 1;
  _id_EE8DA5624236DC89 = spawnStruct();
  drone = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(drone)) {
    return;
  }
  drone setotherent(self);
  drone setentityowner(self);
  drone.owner = self;
  drone.ownerid = self getentitynumber();
  drone.team = self.team;
  drone.streakinfo = streakinfo;
  drone setCanDamage(1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle"))
    drone[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](streakinfo.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback"))
    drone[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](streakinfo.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback"))
    drone[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](streakinfo.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback"))
    drone[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](streakinfo.streakname, ::empdrone_handledeathdamage);

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(drone, drone.vehiclename);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
    drone[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", self, 0, 1, 25);

  self notifyonplayercommand("emp_drone_detonate", "+attack");
  drone playLoopSound("iw8_rc_plane_engine");
  drone thread empdrone_timeoutthink();
  drone thread empdrone_collidethink();
  drone thread empdrone_watchearlyexit();
  drone thread empdrone_watchdetonate();
  drone scripts\cp_mp\emp_debuff::set_apply_emp_callback(::empdrone_empapplied);
  return drone;
}

empdrone_findstartposition() {
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  heightoffset = (0, 0, 600);

  if(isDefined(_id_5FA1E1697A302583)) {
    _id_D274915779774224 = _id_5FA1E1697A302583.origin[2] + -100;
    heightoffset = (0, 0, _id_D274915779774224);
  }

  _id_90B08876A946FDF5 = anglesToForward(self.angles);
  _id_8A88744AB78F625F = heightoffset + self.origin;
  startpos = _id_8A88744AB78F625F - _id_90B08876A946FDF5 * 4000;
  targetpos = _id_8A88744AB78F625F;
  struct = spawnStruct();
  struct.startpos = startpos;
  struct.targetpos = targetpos;
  return struct;
}

empdrone_timeoutthink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  timeout = 20;

  while(timeout > 0) {
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(timeout * 1000));
    timeout = timeout - 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  thread empdrone_destroy();
}

empdrone_collidethink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self vehphys_enablecollisioncallback(1);
  self waittill("collision", body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent);
  thread empdrone_explode();
}

empdrone_watchdetonate() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("emp_drone_exited");
  self.owner waittill("emp_drone_detonate");
  thread empdrone_explode();
}

empdrone_watchearlyexit() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("emp_drone_exited");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("death");

  self waittill("killstreakExit");
  self setotherent(undefined);
  self setentityowner(undefined);
  thread empdrone_exit();
}

empdrone_handledeathdamage(data) {
  attacker = data.attacker;
  empdrone_givepointsfordeath(attacker);
  empdrone_destroy();
}

empdrone_explode() {
  self playSound("iw8_rc_plane_engine_exp");
  forward = anglesToForward(self.angles);
  playFX(level._effects["vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"], self.origin, forward);
  empdrone_explodeemp();
  empdrone_delete();
}

empdrone_destroy() {
  self playSound("recondrone_damaged");
  forward = anglesToForward(self.angles);
  playFX(level._effects["vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"], self.origin, forward);
  empdrone_delete();
}

empdrone_exit() {
  self.owner empdrone_returnplayer(self);
}

empdrone_delete() {
  self.owner empdrone_returnplayer(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "fieldUpgradeExpired"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self.superid, self.usedcount, 0);

  self stoploopsound("iw8_rc_plane_engine");
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

empdrone_returnplayer(drone) {
  if(!istrue(drone.iscontrolled)) {
    return;
  }
  if(isDefined(level.killstreakfinishusefunc))
    level thread[[level.killstreakfinishusefunc]](drone.streakinfo);

  self painvisionon();
  scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  self controlsunlink();
  self cameraunlink(drone);
  empdrone_clearomnvars();
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("empDrone");
  drone stoploopsound("iw8_rc_plane_engine");
  self notifyonplayercommandremove("emp_drone_detonate", "+frag");
  drone.iscontrolled = undefined;
  drone.streakinfo notify("killstreak_finished_with_deploy_weapon");
  drone notify("emp_drone_exited");
}

empdrone_clearomnvars() {
  self setclientomnvar("ui_emp_drone_overlay", 0);
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

    if(_id_457471485336C961 > 589824) {
      continue;
    }
    weapon = scripts\engine\utility::ter_op(_id_457471485336C961 > 4096, _id_ADB14FF6EDFB13E3, _id_6A96CEBAF12D3691);
    ent dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon);
    data = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, ent, 1, weapon, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(data);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("pers", "incPersStat"))
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("pers", "incPersStat")]]("empDroneHits", 1);

    self.usedcount++;
  }

  _id_D13380BB17A918C0 = makeweapon("emp_drone_player_mp");
  radiusdamage(self.origin, 64, 60, 1, self.owner, "MOD_EXPLOSIVE", _id_D13380BB17A918C0);
  players = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius"))
    players = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](self.origin, 768);

  foreach(player in players) {
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