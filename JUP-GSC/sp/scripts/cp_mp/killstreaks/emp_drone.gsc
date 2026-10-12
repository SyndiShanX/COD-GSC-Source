/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\emp_drone.gsc
***************************************************/



#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace emp_drone;

function init() {
  if(issharedfuncdefined("emp_drone", "init")) {
    [[getsharedfunc("emp_drone", "init")]]();
  }
}

function empdrone_beginsuper() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return false;
  }

  thread empdrone_superusethink();
  return true;
}

function empdrone_superusethink() {
  streakinfo = createstreakinfo("emp_drone", self);
  result = empdrone_tryuse(streakinfo);

  if(!result) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }

  wait 0.05;

  if(result) {
    if(issharedfuncdefined("supers", "superUseFinished")) {
      [[getsharedfunc("supers", "superUseFinished")]]();
    }

    if(issharedfuncdefined("sound", "trySayLocalSound")) {
      level thread[[getsharedfunc("sound", "trySayLocalSound")]](self, #"bc_fieldupgrade_action_emppulse");
    }

    return;
  }

  if(issharedfuncdefined("supers", "superUseFinished")) {
    [[getsharedfunc("supers", "superUseFinished")]](1);
  }
}

function empdrone_tryuse(streakinfo) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, &empdrone_weapongiven);

  if(!istrue(deployresult)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  thread empdrone_rundrone(streakinfo);
  return true;
}

function empdrone_equipment_wrapper(ref, slot, objweapon) {
  if(issharedfuncdefined("equipment", "takeEquipment")) {
    self[[getsharedfunc("equipment", "takeEquipment")]](slot);
  }

  streakinfo = createstreakinfo("emp_drone", self);
  used = empdrone_tryuse(streakinfo);

  if(!used) {
    if(issharedfuncdefined("equipment", "giveEquipment")) {
      self[[getsharedfunc("equipment", "giveEquipment")]]("equip_empdrone", slot);
    }
  }
}

function empdrone_weapongiven(streakinfo) {
  return true;
}

function empdrone_rundrone(streakinfo) {
  self endon("disconnect");
  level endon("game_ended");
  self disablephysicaldepthoffieldscripting();
  val::set("empDrone", "fire", 0);
  val::set("empDrone", "melee", 0);
  val::set("empDrone", "weapon_switch", 0);
  val::set("empDrone", "usability", 0);
  val::set("empDrone", "gesture", 0);
  drone = empdrone_createdrone(streakinfo);
  drone.iscontrolled = 1;
  drone.usedcount = 0;
  drone.superid = level.superglobals.staticsuperdata["super_emp_drone"].id;
  self controlslinkTo(drone);
  self cameralinkTo(drone, "tag_origin");
  self setplayerangles(drone.angles);
  self painvisionoff();
  killstreak_savenvgstate();
  self setclientomnvar("ui_emp_drone_overlay", 1);
}

function empdrone_createdrone(streakinfo) {
  startposstruct = empdrone_findstartposition();
  forwardangles = vectortoangles(startposstruct.targetpos - startposstruct.startpos);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  spawndata = spawnStruct();
  spawndata.origin = startposstruct.startpos;
  spawndata.angles = forwardangles;
  spawndata.modelname = "veh8_ind_air_bombing_drone";
  spawndata.vehicletype = "rcplane_physics_mp";
  spawndata.targetname = "rcplane";
  spawndata.cannotbesuspended = 1;
  faildata = spawnStruct();
  drone = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, faildata);

  if(!isDefined(drone)) {
    thread scripts\engine\utility::error("<dev string:x1c>");

    return;
  }

  drone setotherent(self);
  drone setentityowner(self);
  drone.owner = self;
  drone.ownerid = self getentitynumber();
  drone.team = self.team;
  drone.streakinfo = streakinfo;
  drone setCanDamage(1);

  if(issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    drone[[getsharedfunc("killstreak", "killstreakMakeVehicle")]](streakinfo.streakname);
  }

  if(issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    drone[[getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](streakinfo.streakname);
  }

  if(issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    drone[[getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](streakinfo.streakname);
  }

  if(issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    drone[[getsharedfunc("killstreak", "killstreakSetDeathCallback")]](streakinfo.streakname, &empdrone_handledeathdamage);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(drone, drone.vehiclename);

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    drone[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", self, 0, 1, 25);
  }

  self notifyonplayercommand("emp_drone_detonate", "+attack");
  drone playLoopSound("iw8_rc_plane_engine");
  drone thread empdrone_timeoutthink();
  drone thread empdrone_collidethink();
  drone thread empdrone_watchearlyexit();
  drone thread empdrone_watchdetonate();
  drone scripts\cp_mp\emp_debuff::set_apply_emp_callback(&empdrone_empapplied);
  return drone;
}

function empdrone_findstartposition() {
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  heightoffset = (0, 0, 600);

  if(isDefined(heightent)) {
    heightz = heightent.origin[2] + -100;
    heightoffset = (0, 0, heightz);
  }

  forwardvector = anglesToForward(self.angles);
  aboveplayerpos = heightoffset + self.origin;
  startpos = aboveplayerpos - forwardvector * 4000;
  targetpos = aboveplayerpos;
  struct = spawnStruct();
  struct.startpos = startpos;
  struct.targetpos = targetpos;
  return struct;
}

function empdrone_timeoutthink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  timeout = 20;

  while(timeout > 0) {
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(timeout * 1000));
    timeout -= 0.05;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  }

  thread empdrone_destroy();
}

function empdrone_collidethink() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self vehphys_enablecollisioncallback(1);
  self waittill("collision", body0, body1, flag0, flag1, position, normal, impulse, ent);
  thread empdrone_explode();
}

function empdrone_watchdetonate() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("emp_drone_exited");
  self.owner waittill("emp_drone_detonate");
  thread empdrone_explode();
}

function empdrone_watchearlyexit() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("emp_drone_exited");

  if(issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("death");
  }

  self waittill("killstreakExit");
  self setotherent(undefined);
  self setentityowner(undefined);
  thread empdrone_exit();
}

function empdrone_handledeathdamage(data) {
  attacker = data.attacker;
  empdrone_givepointsfordeath(attacker);
  empdrone_destroy();
}

function empdrone_explode() {
  self playSound("iw8_rc_plane_engine_exp");
  forward = anglesToForward(self.angles);
  playFX(level._effects["vfx/iw8_mp/perk/vfx_emp_drone_exp_fieldupgrades.vfx"], self.origin, forward);
  empdrone_explodeemp();
  empdrone_delete();
}

function empdrone_destroy() {
  self playSound("recondrone_damaged");
  forward = anglesToForward(self.angles);
  playFX(level._effects["vfx/iw8_mp/perk/vfx_emp_drone_airexp.vfx"], self.origin, forward);
  empdrone_delete();
}

function empdrone_exit() {
  self.owner empdrone_returnplayer(self);
}

function empdrone_delete() {
  self.owner empdrone_returnplayer(self);

  if(issharedfuncdefined("dlog", "fieldUpgradeExpired")) {
    self thread[[getsharedfunc("dlog", "fieldUpgradeExpired")]](self.owner, self.superid, self.usedcount, 0);
  }

  self stoploopsound("iw8_rc_plane_engine");
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function empdrone_returnplayer(drone) {
  if(!istrue(drone.iscontrolled)) {
    return;
  }

  level callback::callback("killstreak_finish_use", {
    #streakinfo: drone.streakinfo
  });
  self painvisionon();
  killstreak_restorenvgstate();
  self controlsunlink();
  self cameraunlink(drone);
  empdrone_clearomnvars();
  val::reset_all("empDrone");
  drone stoploopsound("iw8_rc_plane_engine");
  self notifyonplayercommandremove("emp_drone_detonate", "+frag");
  drone.iscontrolled = undefined;
  drone.streakinfo notify("killstreak_finished_with_deploy_weapon");
  drone notify("emp_drone_exited");
}

function empdrone_clearomnvars() {
  self setclientomnvar("ui_emp_drone_overlay", 0);
}

function empdrone_empapplied(data) {
  attacker = data.attacker;
  empdrone_givepointsfordeath(attacker);
  empdrone_destroy();
}

function empdrone_givepointsfordeath(attacker) {
  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");

    if(issharedfuncdefined("player", "doScoreEvent")) {
      attacker thread[[getsharedfunc("player", "doScoreEvent")]]("destroyed_equipment");
    }
  }
}

function empdrone_explodeemp() {
  indirectweapon = makeweapon("emp_drone_non_player_mp");
  directhitweapon = makeweapon("emp_drone_non_player_direct_mp");
  ents = empdebuff_get_emp_ents(self.origin, 768);

  foreach(ent in ents) {
    if(ent == self) {
      continue;
    }

    entowner = ent.owner;

    if(isDefined(entowner)) {
      if(entowner != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, entowner)) {
        continue;
      }
    }

    distsqr = distancesquared(self.origin, ent.origin);
    weapon = ter_op(distsqr > 4096, indirectweapon, directhitweapon);
    ent dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", weapon);
    data = packdamagedata(self.owner, ent, 1, weapon, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(data);

    if(issharedfuncdefined("pers", "incPersStat")) {
      self.owner[[getsharedfunc("pers", "incPersStat")]]("empDroneHits", 1);
    }

    self.usedcount++;
  }

  playerweapon = makeweapon("emp_drone_player_mp");
  radiusdamage(self.origin, 64, 60, 1, self.owner, "MOD_EXPLOSIVE", playerweapon);
  players = getplayersinradiussharedfunc(self.origin, 768);

  foreach(player in players) {
    if(!player can_be_empd()) {
      continue;
    }

    if(player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, player)) {
      continue;
    }

    player dodamage(1, self.origin, self.owner, self, "MOD_EXPLOSIVE", playerweapon);
    data = packdamagedata(self.owner, player, 1, playerweapon, "MOD_EXPLOSIVE", self, self.origin);
    thread empdrone_applyemp(data);
  }
}

function empdrone_applyemp(data) {
  apply_emp_struct(data);
  duration = 8;

  if(isPlayer(data.victim)) {
    if(issharedfuncdefined("perk", "hasPerk")) {
      if(data.victim != self.owner && data.victim[[getsharedfunc("perk", "hasPerk")]]("specialty_emp_resist")) {
        duration = 2;

        if(issharedfuncdefined("damage", "updateDamageFeedback")) {
          self.owner[[getsharedfunc("damage", "updateDamageFeedback")]]("hittacresist");
        }
      }
    }

    if(issharedfuncdefined("gamescore", "trackDebuffAssist")) {
      [[getsharedfunc("gamescore", "trackDebuffAssist")]](data.attacker, data.victim, data.objweapon.basename);
    }
  }

  empdrone_empendearly(data, duration);

  if(isDefined(data.victim)) {
    data.victim remove_emp();

    if(isDefined(data.attacker) && isPlayer(data.victim)) {
      if(issharedfuncdefined("gamescore", "untrackDebuffAssist")) {
        [[getsharedfunc("gamescore", "untrackDebuffAssist")]](data.attacker, data.victim, data.objweapon.basename);
      }
    }
  }
}

function empdrone_empendearly(data, duration) {
  data.victim endon("death_or_disconnect");
  level endon("game_ended");
  result = waittill_notify_or_timeout_return("emp_cleared", duration);

  if(result != "emp_cleared") {
    data.empremoved = 1;
  }
}