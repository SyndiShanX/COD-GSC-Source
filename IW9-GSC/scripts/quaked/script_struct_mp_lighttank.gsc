/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_lighttank.gsc
*********************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("light_tank", ::light_tank_init);
}

light_tank_init() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("light_tank")) {
    return;
  }
  callbacks = [];
  callbacks["spawn"] = ::light_tank_create;
  callbacks["update"] = ::light_tank_update;
  callbacks["explode"] = ::light_tank_explode;
  callbacks["delete"] = ::_id_067ECD2ABC69311E;
  callbacks["initSpawnData"] = ::light_tank_initializespawndata;
  callbacks["tankSpawn"] = ::light_tank_spawn;
  callbacks["updateHeadIconForPlayerOnJoinTeam"] = ::light_tank_updateheadiconforplayeronjointeam;
  callbacks["timeOut"] = ::light_tank_timeout;
  callbacks["capture"] = ::light_tank_capture;
  callbacks["copySpawnData"] = ::light_tank_copyspawndata;
  callbacks["tankActivate"] = ::light_tank_activate;
  callbacks["autoDestruct"] = ::light_tank_autodestruct;
  callbacks["updateTeam"] = ::light_tank_updateteam;
  callbacks["updateOwner"] = ::light_tank_updateowner;
  callbacks["enterEnd"] = ::light_tank_enterend;
  callbacks["exitEnd"] = ::light_tank_exitend;
  callbacks["reenter"] = ::light_tank_reenter;
  callbacks["spawnPostAirdrop"] = ::light_tank_create;
  callbacks["flippedEnd"] = ::light_tank_flippedendcallback;
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("light_tank", callbacks);
  level.vehicle.lighttank = spawnStruct();
  level.vehicle.lighttank.canautodestruct = 1;
  level.vehicle.lighttank.autodestructdamagepercent = 11;
  level.vehicle.lighttank.cantimeout = 1;
  level.vehicle.lighttank.timeoutduration = 165;
  level.vehicle.lighttank.cantakedamageduringcapture = 1;
  level.vehicle.lighttank.showheadicon = 1;
  level.vehicle.lighttank.showheadicontoenemy = 0;
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("light_tank");
  light_tank_initomnvars();
  light_tank_initdamage();
  light_tank_initfx();
  light_tank_initvo();
}

light_tank_initomnvars() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle("light_tank", 1);
  _id_E2818AD39A3341B4.ammoids["turret"] = 0;
  _id_E2818AD39A3341B4.ammoids["missile"] = 1;
  _id_E2818AD39A3341B4.ammoids["smoke"] = 2;
  _id_E2818AD39A3341B4.rotationids[0] = 0;
  _id_E2818AD39A3341B4.rotationids[1] = 1;
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["driver"]["lighttank_mp"] = 0;
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["driver"]["iw9_mg_light_tank_mp"] = 1;
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["gunner"]["iw9_tur_light_tank_mp"] = 0;
  _id_E2818AD39A3341B4.rotationrefsbyseatandweapon["gunner"]["iw9_mg_light_tank_mp"] = 1;
}

light_tank_initdamage() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("light_tank");
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpremoddamagecallback("light_tank", ::light_tank_premoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setpostmoddamagecallback("light_tank", ::light_tank_postmoddamagecallback);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata("iw9_tur_light_tank_mp", 2);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setweaponhitdamagedata("bradley_tow_proj_mp", 7);
}

light_tank_initfx() {
  level._effect["light_tank_cannon_dust"] = loadfx("vfx/iw8_mp/weap_kickup/vfx_wk_tank_cannon_dust_w.vfx");
}

light_tank_initvo() {
  game["dialog"]["light_tank_low_fuel"] = "light_tank_timeout_reminder";
  game["dialog"]["light_tank_destruct"] = "light_tank_self_destruct";
  game["dialog"]["light_tank_entry"] = "light_tank_chatter_01";
  game["dialog"]["light_tank_chatter_01"] = "light_tank_chatter_02";
  game["dialog"]["light_tank_chatter_02"] = "light_tank_chatter_03";
}

light_tank_create(spawndata, _id_EE8DA5624236DC89) {
  if(!isDefined(spawndata.angles))
    spawndata.angles = (0, 0, 0);

  if(isDefined(spawndata._id_14CDE247AC3313A4))
    spawndata.modelname = spawndata._id_14CDE247AC3313A4 + "::" + "veh9_mil_lnd_tank_x_vehphys_mp";
  else
    spawndata.modelname = "veh9_mil_lnd_tank_x_vehphys_mp";

  spawndata.targetname = "light_tank";
  spawndata.vehicletype = "veh9_mil_lnd_tank_physics_mp";
  spawndata.cannotbesuspended = 1;
  spawndata.startsuspended = 0;
  vehicle = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, _id_EE8DA5624236DC89);

  if(!isDefined(vehicle))
    return undefined;

  vehicle.isfromkillstreak = isDefined(spawndata.spawntype) && spawndata.spawntype == "KILLSTREAK";

  if(isDefined(spawndata._id_1AEA8EAACA8ADC25)) {
    turret = light_tank_createdriverturret(vehicle, spawndata);
    _id_CA4CD400D36CB243 = spawndata._id_1AEA8EAACA8ADC25;
    scripts\cp_mp\vehicles\vehicle::vehicle_registerturret(vehicle, turret, makeweapon(_id_CA4CD400D36CB243), 1);
  }

  vehicle.missilesleft = 2;
  vehicle.lastmissilefired = 0;
  turret = light_tank_creategunnerturret(vehicle, spawndata);
  scripts\cp_mp\vehicles\vehicle::vehicle_registerturret(vehicle, turret, makeweapon("iw9_mg_light_tank_mp"));
  scripts\cp_mp\vehicles\vehicle::vehicle_create(vehicle, "light_tank", spawndata);
  vehicle.objweapon = makeweapon("lighttank_mp");
  vehicle light_tank_updateheadicon();
  _id_B101137988B007D7 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getinstancedataforvehicle(vehicle, 1);
  _id_B101137988B007D7.destroyscoreevent = "none";
  scripts\cp_mp\vehicles\vehicle::vehicle_createlate(vehicle, spawndata);
  vehicle thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped();
  vehicle thread scripts\cp_mp\vehicles\vehicle::_id_1B69321FF9937FC5();
  vehicle thread light_tank_monitordriverturretfire();
  vehicle thread light_tank_monitordriverturretprojectilefire();
  vehicle thread light_tank_monitorgunnerturretfire();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "create"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "create")]](vehicle);

  return vehicle;
}

light_tank_createdriverturret(vehicle, spawndata) {
  _id_962A30A9BB8C0F09 = light_tank_getleveldata();
  weaponname = undefined;

  if(isDefined(spawndata._id_1AEA8EAACA8ADC25)) {
    weaponname = spawndata._id_1AEA8EAACA8ADC25;
    vehicle._id_A94FABD846E764F2 = weaponname;
  }

  weaponname = "iw9_tur_light_tank_mp";
  turret = spawnturret("misc_turret", vehicle gettagorigin("tag_turret"), weaponname, 0);
  turret linkTo(vehicle, "tag_turret", (0, 0, 0), (0, 0, 0));
  turret setModel("veh9_mil_lnd_tank_turret");
  turret setmode("sentry_offline");
  turret setsentryowner(undefined);
  turret makeunusable();
  turret setdefaultdroppitch(0);
  turret setturretmodechangewait(1);
  turret.angles = vehicle.angles;
  turret.vehicle = vehicle;
  return turret;
}

light_tank_creategunnerturret(vehicle, spawndata) {
  weaponname = undefined;

  if(isDefined(spawndata._id_6D497EA17C312778))
    weaponname = spawndata._id_6D497EA17C312778;

  weaponname = "iw9_mg_light_tank_mp";
  turret = spawnturret("misc_turret", vehicle gettagorigin("turret_animate_jnt"), weaponname, 0);
  turret linkTo(vehicle, "turret_animate_jnt", (0, 0, 0), (0, 0, 0));
  turret setModel("veh9_mil_lnd_tank_turret_gun");
  turret setmode("sentry_offline");
  turret setsentryowner(undefined);
  turret makeunusable();
  turret setdefaultdroppitch(0);
  turret setturretmodechangewait(1);
  turret.angles = vehicle.angles;
  turret.vehicle = vehicle;
  return turret;
}

light_tank_activate() {
  if(istrue(self.isactivated)) {
    return;
  }
  self.isactivated = 1;
  _id_962A30A9BB8C0F09 = light_tank_getleveldata();
  showheadicon = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    showheadicon = 0;
  else if(isDefined(self.spawndata.showheadicon))
    showheadicon = self.spawndata.showheadicon;
  else
    showheadicon = _id_962A30A9BB8C0F09.showheadicon;

  if(showheadicon) {
    light_tank_createheadicon();
    light_tank_updateheadicon();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "activate"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "activate")]](self);
}

light_tank_explode(data, immediate, _id_EAD0561C114B3BE8) {
  attacker = undefined;
  inflictor = undefined;
  objweapon = undefined;
  meansofdeath = undefined;

  if(isDefined(data)) {
    inflictor = data.inflictor;
    meansofdeath = data.meansofdeath;
    streakname = "bradley";
    attacker = data.attacker;
    objweapon = data.objweapon;
    _id_D95DA0355CF4CCB4 = undefined;
    damage = data.damage;
    _id_92D090CE35588AD2 = "destroyed_" + streakname;
    leaderdialog = streakname + "_destroyed";
    _id_6342E2DA1DC12454 = "callout_destroyed_" + streakname;
    _id_DC695757F69ED065 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled"))
      _id_3737240CEFE2C793 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](streakname, attacker, objweapon, _id_D95DA0355CF4CCB4, damage, _id_92D090CE35588AD2, leaderdialog, _id_6342E2DA1DC12454, _id_DC695757F69ED065);
  } else {
    data = spawnStruct();
    data.inflictor = self;
    data.objweapon = "lighttank_mp";
    data.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(scripts\cp_mp\vehicles\vehicle::_id_B7148A3BFC4DEFB2())
    scripts\cp_mp\vehicles\vehicle::_id_E3FF0A92AD2BF58D(data, immediate);
  else
    scripts\cp_mp\vehicles\vehicle::_id_9672DA471530B44A(data, immediate);
}

_id_067ECD2ABC69311E(vehicle) {
  thread light_tank_endcapture(self);
  light_tank_destroyheadicon();

  if(isDefined(self.objent)) {
    light_tank_destroyobjective(self.objent);
    self.objent = undefined;
  }
}

light_tank_initializespawndata(spawndata) {
  if(!isDefined(spawndata))
    spawndata = spawnStruct();

  if(!isDefined(spawndata.spawnmethod))
    spawndata.spawnmethod = "airdrop_at_position_unsafe";

  if(!isDefined(spawndata.cancapture))
    spawndata.cancapture = 0;

  if(!isDefined(spawndata.cancaptureimmediately))
    spawndata.cancaptureimmediately = 0;

  if(!isDefined(spawndata.activateimmediately))
    spawndata.activateimmediately = 1;

  if(!isDefined(spawndata.faceawayfromowner))
    spawndata.faceawayfromowner = 0;

  return spawndata;
}

light_tank_copyspawndata(from, to) {
  to.spawnmethod = from.spawnmethod;
  to.cancapture = from.cancapture;
  to.cancaptureimmediately = from.cancaptureimmediately;
  to.activateimmediately = from.activateimmediately;
  to.faceawayfromowner = from.faceawayfromowner;
  to.cantimeout = from.cantimeout;
  to.showheadicon = from.showheadicon;
}

light_tank_spawn(spawndata, _id_EE8DA5624236DC89, streakinfo) {
  spawnposition = undefined;
  spawnangles = undefined;
  _id_A50521AED4831F1C = undefined;
  _id_3EE18B54B626DBA8 = undefined;
  spawndata = light_tank_initializespawndata(spawndata);
  isairdrop = issubstr(spawndata.spawnmethod, "airdrop_");
  spawnposition = spawndata.origin;
  spawnangles = spawndata.angles;

  if(isDefined(spawndata.owner) && istrue(spawndata.faceawayfromowner)) {
    _id_8423818ECF85A883 = spawnposition - spawndata.owner.origin;

    if(length2dsquared(_id_8423818ECF85A883) > 0)
      spawnangles = vectortoangles(spawnposition - spawndata.owner.origin);
    else
      spawnangles = spawndata.owner getplayerangles(1);
  }

  if(!isDefined(spawnangles))
    spawnangles = (0, randomint(360), 0);
  else
    spawnangles = spawnangles * (0, 1, 0);

  vehicle = undefined;

  if(isairdrop)
    vehicle = light_tank_airdrop(spawnposition, spawnangles, _id_A50521AED4831F1C, _id_3EE18B54B626DBA8, spawndata, _id_EE8DA5624236DC89);
  else
    vehicle = light_tank_place(spawnposition, spawnangles, spawndata, _id_EE8DA5624236DC89);

  return vehicle;
}

light_tank_place(spawnposition, spawnangles, spawndata, _id_EE8DA5624236DC89) {
  _id_E5D77BF46A926594 = spawndata.origin;
  _id_C36E41058FF56216 = spawndata.angles;
  spawndata.origin = spawnposition;
  spawndata.angles = spawnangles;
  vehicle = light_tank_create(spawndata, _id_EE8DA5624236DC89);
  spawndata.origin = _id_E5D77BF46A926594;
  spawndata.angles = _id_C36E41058FF56216;

  if(!isDefined(vehicle))
    return undefined;

  if(spawndata.cancapture) {
    if(spawndata.cancaptureimmediately)
      thread light_tank_startcapture(vehicle, spawndata.owner, spawndata.team);
  } else if(spawndata.activateimmediately)
    vehicle thread light_tank_activate();

  return vehicle;
}

light_tank_airdrop(position, angles, _id_246648A337842D7D, _id_4F8BAD3CFC982AF1, spawndata, _id_EE8DA5624236DC89) {
  spawndata.origin = position;
  spawndata.angles = angles;
  objent = undefined;

  if(isDefined(_id_246648A337842D7D)) {
    if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
      objent = light_tank_createobjective(_id_246648A337842D7D, _id_4F8BAD3CFC982AF1, spawndata);
  }

  vehicle = _id_721EE99D7A8F9168::_id_66C684FEA143FBFD("light_tank", spawndata, _id_EE8DA5624236DC89);
  vehicle.objent = objent;
  vehicle thread _id_9E0C2CD85FA8C581();
  return vehicle;
}

_id_9E0C2CD85FA8C581() {
  self waittill("landed");

  if(isDefined(self.objent)) {
    light_tank_destroyobjective(self.objent);
    self.objent = undefined;
  }

  while(lengthsquared(self vehicle_getvelocity()) > 400)
    waitframe();

  spawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(spawndata.cancapture) {
    if(spawndata.cancaptureimmediately)
      thread light_tank_startcapture(self, self.owner, self.team);
  } else if(spawndata.activateimmediately)
    thread light_tank_activate();
}

light_tank_createobjective(_id_246648A337842D7D, _id_4F8BAD3CFC982AF1, spawndata) {
  objid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
  objent = spawn("script_model", _id_246648A337842D7D);
  objent setModel("ks_airstrike_marker_mp");
  forward = (1, 0, 0);
  right = vectorcross(forward, _id_4F8BAD3CFC982AF1);
  forward = vectorcross(_id_4F8BAD3CFC982AF1, right);
  angles = axistoangles(forward, right, _id_4F8BAD3CFC982AF1);
  objent.angles = angles;

  if(objid != -1) {
    objent.objid = objid;
    objective_onentity(objid, objent);
    objective_icon(objid, "icon_waypoint_tank");
    objective_setzoffset(objid, 55);
    objective_setplayintro(objid, 0);
    objective_setplayoutro(objid, 0);
    objective_setbackground(objid, 1);
    objective_showtoplayersinmask(objid);
    objective_state(objid, "current");

    if(level.teambased) {
      _id_9A6FCCC729B4650A = spawndata.team;

      if(!isDefined(_id_9A6FCCC729B4650A) || _id_9A6FCCC729B4650A == "neutral") {
        if(isDefined(spawndata.owner))
          _id_9A6FCCC729B4650A = spawndata.owner.team;
      }

      if(!isDefined(_id_9A6FCCC729B4650A) || _id_9A6FCCC729B4650A == "neutral") {
        objective_addalltomask(objid);
        objent setscriptablepartstate("marker_placed", "onEveryone", 0);
      } else {
        objective_addteamtomask(objid, _id_9A6FCCC729B4650A);
        light_tank_setteamotherent(objent, _id_9A6FCCC729B4650A);
        objent setscriptablepartstate("marker_placed", "onTeam", 0);
      }
    } else if(!isDefined(spawndata.owner)) {
      objective_addalltomask(objid);
      objent setscriptablepartstate("marker_placed", "onEveryone", 0);
    } else {
      objective_setownerclient(objid, spawndata.owner);
      objective_addclienttomask(objid, spawndata.owner);
      objent setotherent(spawndata.owner);
      objent setscriptablepartstate("marker_placed", "on", 0);
    }
  }

  return objent;
}

light_tank_destroyobjective(objent) {
  if(isDefined(objent.objid))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](objent.objid);

  objent delete();
}

light_tank_setteamotherent(objent, team) {
  objent notify("light_tank_setTeamOtherEnt");
  objent endon("light_tank_setTeamOtherEnt");
  _id_AE9ACDDA1C693FA6 = undefined;

  foreach(player in level.players) {
    if(player.team == team) {
      _id_AE9ACDDA1C693FA6 = player;
      break;
    }
  }

  if(isDefined(_id_AE9ACDDA1C693FA6)) {
    objent setotherent(_id_AE9ACDDA1C693FA6);
    childthread light_tank_monitorotherentjoined(objent, _id_AE9ACDDA1C693FA6);
    childthread light_tank_monitorotherentdisconnect(objent, _id_AE9ACDDA1C693FA6);
  }
}

light_tank_monitorotherentjoined(objent, _id_AE9ACDDA1C693FA6) {
  objent endon("death");
  _id_8A04AA0E0755E7E3 = _id_AE9ACDDA1C693FA6.team;
  _id_AE9ACDDA1C693FA6 scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  thread light_tank_setteamotherent(objent, _id_8A04AA0E0755E7E3);
}

light_tank_monitorotherentdisconnect(objent, _id_AE9ACDDA1C693FA6) {
  _id_8A04AA0E0755E7E3 = _id_AE9ACDDA1C693FA6.team;
  _id_AE9ACDDA1C693FA6 waittill("disconnect");
  thread light_tank_setteamotherent(objent, _id_8A04AA0E0755E7E3);
}

light_tank_startcapture(vehicle, owner, team) {
  _id_962A30A9BB8C0F09 = light_tank_getleveldata();
  showheadicon = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    showheadicon = 0;
  else if(isDefined(vehicle.spawndata.showheadicon))
    showheadicon = vehicle.spawndata.showheadicon;
  else
    showheadicon = _id_962A30A9BB8C0F09.showheadicon;

  if(showheadicon) {
    vehicle light_tank_createheadicon(1);
    vehicle light_tank_updateheadicon(owner, team);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "startCapture"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "startCapture")]](vehicle, owner, team);
}

light_tank_endcapture(vehicle) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "endCapture"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "endCapture")]](vehicle);
}

light_tank_capture(vehicle, player) {
  thread light_tank_endcapture(vehicle);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, player.team);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setowner(vehicle, player);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(vehicle, "driver", player);
  vehicle thread light_tank_activate();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "capture"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "capture")]](player, vehicle);
}

light_tank_update(data) {
  if(scripts\cp_mp\vehicles\vehicle::isvehicledestroyed()) {
    return;
  }
  light_tank_updatetimeout();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_updatemovefeedback("driver");
}

light_tank_monitordriverturretfire() {
  self endon("death");
  light_tank_updatedriverturretammoui();
  light_tank_updatemissileammoui();

  for(;;) {
    message = scripts\engine\utility::waittill_any_return_2("vehicle_turret_fire", "vehicle_turret_reload_end");

    if(message == "vehicle_turret_fire")
      light_tank_turretdustkickup();

    light_tank_updatedriverturretammoui();
  }
}

light_tank_monitordriverturretprojectilefire() {
  self endon("death");

  for(;;) {
    self waittill("vehicle_turret_fire", param1, param2, projectile);
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");
    projectile thread light_tank_watchprojectileexplosion(driver);
    projectile.vehicle = self;

    if(isDefined(self.streakinfo)) {
      projectile.streakinfo = self.streakinfo;
      self.streakinfo.shots_fired++;
    }
  }
}

light_tank_watchprojectileexplosion(driver) {
  level endon("game_ended");
  self waittill("explode", position);

  if(!isDefined(driver)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](position, 175, 175, driver.team, 1, driver, 1);
}

light_tank_monitordriverturretreload(driver) {
  self endon("death");

  if(isDefined(driver)) {
    driver endon("vehicle_change_seat");
    driver endon("vehicle_seat_exit");
    driver endon("death_or_disconnect");

    while(driver reloadbuttonPressed())
      waitframe();

    _id_33193F537B85B6D4 = getdvarint("bg_useholdtimeshort", 250) / 1000;

    for(;;) {
      holdtime = 0.0;
      _id_930201649EAF32AF = driver getcurrentusereloadconfig();
      _id_72E25A59FCEF57B5 = 0;

      while(driver reloadbuttonPressed()) {
        if(!driver usinggamepad() && self _meth_AB2BDDB6CD03A29D() < weaponclipsize("iw9_tur_light_tank_mp")) {
          self _meth_4012509DBD1CEE6F();
          _id_72E25A59FCEF57B5 = 1;
          light_tank_updatedriverturretammoui();
          break;
        } else {
          if(self _meth_AB2BDDB6CD03A29D() < weaponclipsize("iw9_tur_light_tank_mp") && _id_930201649EAF32AF > 0 && holdtime >= _id_33193F537B85B6D4) {
            self _meth_4012509DBD1CEE6F();
            _id_72E25A59FCEF57B5 = 1;
            light_tank_updatedriverturretammoui();
          }

          holdtime = holdtime + level.framedurationseconds;
          waitframe();
        }
      }

      if(!_id_72E25A59FCEF57B5 && driver usinggamepad() && self _meth_AB2BDDB6CD03A29D() < weaponclipsize("iw9_tur_light_tank_mp") && (_id_930201649EAF32AF == 0 && holdtime > 0.0 && holdtime < 0.2 || _id_930201649EAF32AF > 0 && holdtime >= _id_33193F537B85B6D4)) {
        self _meth_4012509DBD1CEE6F();
        light_tank_updatedriverturretammoui();
      }

      waitframe();
    }
  }
}

light_tank_updatedriverturretammoui() {
  driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(driver))
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("light_tank", "turret", self _meth_AB2BDDB6CD03A29D(), driver);
}

light_tank_watchmissileinputchange() {
  self notify("watch_missile_input_change");
  self endon("watch_missile_input_change");

  for(;;) {
    _id_6B65638B1A820F6C = light_tank_getmissileplayercommand();
    self notifyonplayercommand("light_tank_missile", _id_6B65638B1A820F6C);
    _id_FD99CC32B0AC87B4 = scripts\engine\utility::waittill_any_return_no_endon_death_2("input_type_changed", "missile_handling_ended");
    self notifyonplayercommandremove("light_tank_missile", _id_6B65638B1A820F6C);

    if(!isDefined(_id_FD99CC32B0AC87B4) || _id_FD99CC32B0AC87B4 == "missile_handling_ended") {
      break;
    }
  }
}

light_tank_stopwatchingmissileinputchange() {
  self notify("missile_handling_ended");
}

light_tank_getmissileplayercommand() {
  return "+melee_zoom";
}

light_tank_monitordrivermissilefire(player) {
  self endon("death");
  self endon("light_tank_driver_exit");

  for(;;) {
    player waittill("light_tank_missile");

    if(gettime() - self.lastmissilefired >= 1330.0) {
      if(isDefined(self.missilesleft) && self.missilesleft > 0) {
        self.lastmissilefired = gettime();
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_fadeoutcontrols(player);
        light_tank_firemissile(player, player.stingertarget);
        light_tank_adjustmissileammo(-1);
        continue;
      }
    }
  }
}

light_tank_firemissile(player, target) {
  wait 0.33;
  self setscriptablepartstate("towMissileFX", "active");
  start = self gettagorigin("tag_flash");
  angles = self gettagangles("tag_flash");
  end = start + anglesToForward(angles);
  player childthread light_tank_playmissilefireplayerfx();
  weaponname = undefined;
  weaponname = "bradley_tow_proj_mp";

  if(isDefined(self.streakinfo))
    self.streakinfo.shots_fired++;

  missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(weaponname), start, end, player);
  missile.vehicle = self;
  missile.streakinfo = self.streakinfo;

  if(isDefined(target)) {
    missile missile_settargetEnt(target);
    thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile(target, missile);
  }
}

light_tank_adjustmissileammo(amount) {
  self.missilesleft = self.missilesleft + amount;
  self.missilesleft = int(clamp(self.missilesleft, 0, 2));
  light_tank_updatemissileammoui();
}

light_tank_updatemissileammoui() {
  driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(driver))
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("light_tank", "missile", self.missilesleft, driver);
}

light_tank_playmissilefireplayerfx() {
  self endon("disconnect");
  self setblurforplayer(0.333, 0.1);
  wait 0.15;
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_heavydamagefeedbackforplayer();
  wait 0.35;
  light_tank_endmissilefireplayerfx();
}

light_tank_endmissilefireplayerfx(immediate) {
  if(!istrue(immediate))
    self setblurforplayer(0.0, 0.1);
  else
    self setblurforplayer(0.0, 0.0);
}

light_tank_monitorgunnerturretfire() {
  self endon("death");
  turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(self, "iw9_mg_light_tank_mp");

  for(;;) {
    turret waittill("turret_fire");

    if(isDefined(self.streakinfo))
      self.streakinfo.shots_fired++;
  }
}

light_tank_updateautodestructui(player) {
  _id_962A30A9BB8C0F09 = light_tank_getleveldata();

  if(_id_962A30A9BB8C0F09.canautodestruct) {
    if(istrue(self.autodestructactivated))
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("burningDown", player, "light_tank");
    else
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", player, "light_tank");
  } else
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", player, "light_tank");
}

light_tank_updatetimeoutui(player, _id_77B3F0514A25C019) {
  _id_962A30A9BB8C0F09 = light_tank_getleveldata();

  if(light_tank_cantimeout()) {
    if(!isDefined(_id_77B3F0514A25C019)) {
      _id_77B3F0514A25C019 = (_id_962A30A9BB8C0F09.timeoutduration - self.timeelapsed) / _id_962A30A9BB8C0F09.timeoutduration;
      _id_77B3F0514A25C019 = clamp(_id_77B3F0514A25C019, 0, 1);
    }

    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_settimepercent(_id_77B3F0514A25C019, player);
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showtime(player);
  } else {
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_cleartimepercent(player);
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidetime(player);
  }
}

light_tank_updatetimeout() {
  if(light_tank_cantimeout()) {
    if(!isDefined(self.timeelapsed))
      self.timeelapsed = 0;

    if(istrue(self.isactivated)) {
      self.timeelapsed = self.timeelapsed + level.framedurationseconds;
      _id_962A30A9BB8C0F09 = light_tank_getleveldata();
      _id_77B3F0514A25C019 = (_id_962A30A9BB8C0F09.timeoutduration - self.timeelapsed) / _id_962A30A9BB8C0F09.timeoutduration;
      _id_77B3F0514A25C019 = int(ceil(clamp(_id_77B3F0514A25C019, 0, 1) * 100));

      if(self.timeelapsed >= _id_962A30A9BB8C0F09.timeoutduration) {
        thread light_tank_timeout();
        return;
      }

      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

      foreach(_id_F85572CD5F6117C6 in occupants)
      light_tank_updatetimeoutui(_id_F85572CD5F6117C6, _id_77B3F0514A25C019);

      return;
    } else {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

      foreach(_id_F85572CD5F6117C6 in occupants)
      light_tank_updatetimeoutui(_id_F85572CD5F6117C6, 1);
    }
  } else
    self.timeelapsed = undefined;
}

light_tank_timeout() {
  if(light_tank_canautodestruct()) {
    thread light_tank_autodestruct();
    occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

    foreach(_id_F85572CD5F6117C6 in occupants)
    light_tank_updatetimeoutui(_id_F85572CD5F6117C6, undefined);
  } else
    thread light_tank_explode(undefined, 0, 1);
}

light_tank_enterend(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(istrue(data.success))
    thread light_tank_enterendinternal(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
}

light_tank_enterendinternal(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(seatid == "driver") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, 100);
    player thread light_tank_watchmissileinputchange();
    vehicle thread light_tank_monitordrivermissilefire(player);
    player scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  } else if(seatid == "gunner") {
    level thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, scripts\engine\utility::ter_op(istrue(vehicle._id_ECC491F42AACEAF4), 850, 2200));
    player thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(player, vehicle, "iw9_mg_light_tank_mp");
    vehicle._id_ECC491F42AACEAF4 = 1;
    light_tank_addgunnerdamagemod(player);
  }

  if(!isDefined(_id_FC7C7A874B43A31A))
    vehicle light_tank_updateheadiconforplayer(player);

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, seatid, player);
  light_tank_updateplayeromnvarsonenter(vehicle, _id_FC7C7A874B43A31A, seatid, player);

  if(seatid == "driver")
    vehicle thread light_tank_monitordriverturretreload(player);
}

light_tank_exitend(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(istrue(data.success))
    thread light_tank_exitendinternal(vehicle, seatid, _id_7558F98F3236963D, player, data);
}

light_tank_exitendinternal(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(seatid == "driver") {
    vehicle notify("light_tank_driver_exit");
    light_tank_stopwatchingmissileinputchange();

    if(!istrue(data.playerdisconnect)) {
      if(!istrue(data.playerdeath))
        player light_tank_endmissilefireplayerfx(1);

      player scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    }
  } else if(seatid == "gunner") {
    turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(vehicle, "iw9_mg_light_tank_mp");

    if(!istrue(data.playerdisconnect)) {
      player enableturretdismount();
      player controlturretoff(turret);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(player, data.playerdeath);

      if(!istrue(data.playerdeath))
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, "iw9_mg_light_tank_mp", data, 1);
    }

    turret.owner = undefined;
    turret setotherent(undefined);
    turret setentityowner(undefined);
    turret setsentryowner(undefined);
    light_tank_removegunnerdamagemod(player);
  }

  if(!istrue(data.playerdisconnect)) {
    if(!isDefined(_id_7558F98F3236963D))
      vehicle light_tank_updateheadiconforplayer(player);

    success = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(vehicle, seatid, _id_7558F98F3236963D, player, data);

    if(!success) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      else
        player suicide();
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(vehicle, seatid, _id_7558F98F3236963D, player);
}

light_tank_reenter(vehicle, _id_9DE41F2EE77C33BA, _id_3F68C37BAFD38606, player, data) {
  if(_id_9DE41F2EE77C33BA == "driver")
    vehicle thread light_tank_monitordrivermissilefire(player);

  if(isDefined(_id_3F68C37BAFD38606) && _id_3F68C37BAFD38606 == "gunner")
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, "iw9_mg_light_tank_mp", data, 1);
}

light_tank_addgunnerdamagemod(player) {
  if(isDefined(player.gunnerdamagemodifier)) {
    return;
  }
  player scripts\cp_mp\utility\damage_utility::adddamagemodifier("ltGunnerMissileRedux", 0.4, 0, ::light_tank_gunnerdamagemodignorefunc);
}

light_tank_removegunnerdamagemod(player) {
  if(!isDefined(player.gunnerdamagemodifier)) {
    return;
  }
  player.gunnerdamagemodifier = undefined;
  player scripts\cp_mp\utility\damage_utility::removedamagemodifier("ltGunnerMissileRedux", 0);
}

light_tank_gunnerdamagemodignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(meansofdeath != "MOD_PROJECTILE_SPLASH" && meansofdeath != "MOD_GRENADE_SPLASH")
    return 1;

  if(!isDefined(objweapon))
    return 1;

  switch (objweapon.basename) {
    case "bradley_tow_proj_mp":
    case "iw8_la_mike32_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw9_tur_light_tank_mp":
    case "iw9_tur_apc_russian_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_gromeo_mp":
    case "iw9_la_juliet_mp":
    case "iw8_la_juliet_mp":
    case "iw9_la_gromeo_mp":
      return 0;
    default:
      return 1;
  }
}

light_tank_premoddamagecallback(data) {
  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isselfdamage(self, data))
    return 0;

  _id_6B11D3047F506FB6 = self.origin - data.point;
  normal = anglestoup(self.angles);
  dist = vectordot(_id_6B11D3047F506FB6, normal);
  _id_D74074AD5396E58A = data.point + normal * dist;
  _id_C47F1816352556DD = vectorNormalize(_id_D74074AD5396E58A - self.origin);
  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);

  if(vectordot(_id_C47F1816352556DD, forward) < -0.83)
    data.isrearcriticaldamage = scripts\cp_mp\vehicles\vehicle_damage::_id_1989BD346C21B68A(data);

  return 1;
}

light_tank_postmoddamagecallback(data) {
  if(istrue(data.isrearcriticaldamage))
    data.damage = int(data.damage * 1.6);

  return 1;
}

light_tank_autodestruct(attacker) {
  self endon("death");
  self notify("flipped_end");

  if(!istrue(self.autodestructactivated)) {
    self.autodestructactivated = 1;

    if(!scripts\common\utility::iscp()) {
      maxhealth = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getheavystatemaxhealth(self);
      self.health = int(min(self.health, maxhealth));
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
      scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_updatestate();
    } else {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

      foreach(_id_F85572CD5F6117C6 in occupants)
      light_tank_updateautodestructui(_id_F85572CD5F6117C6);

      wait 5.5;
      thread light_tank_explode(undefined, undefined, 1);
    }
  }
}

light_tank_turretdustkickup() {
  contents = physics_createcontents(["physicscontents_itemclip", "physicscontents_water", "physicscontents_glass", "physicscontents_item"]);
  ignorelist = self getlinkedchildren();

  if(!isDefined(ignorelist))
    ignorelist = [];

  ignorelist[ignorelist.size] = self;
  caststart = self gettagorigin("tag_flash");
  castend = caststart + (-0, -0, -200);
  _id_E021C2744CC7ED68 = physics_raycast(caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1);

  if(!isDefined(_id_E021C2744CC7ED68) || !_id_E021C2744CC7ED68.size) {
    return;
  }
  forward = anglesToForward(self gettagangles("tag_flash") * (0, 1, 0));
  up = _id_E021C2744CC7ED68[0]["normal"];
  right = vectorcross(forward, up);
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  playFX(scripts\engine\utility::getfx("light_tank_cannon_dust"), _id_E021C2744CC7ED68[0]["position"], anglesToForward(angles), anglestoup(angles));
}

light_tank_createheadicon(_id_45C9B66826527876) {
  icon = self.headicon;

  if(!isDefined(icon)) {
    icon = scripts\cp_mp\entityheadicons::setheadicon_createnewicon();

    if(!isDefined(icon))
      return 0;

    self.headicon = icon;
    setheadiconzoffset(icon, 110);
  }

  self.headiconforcapture = istrue(_id_45C9B66826527876);
  _id_30516B4AFD1763DE = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 0, 0);
  maxdist = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 2250, 2250);
  _id_94DC5DEAB609FDC9 = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 1, 0);
  _id_C18F8868BD35FEE2 = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 1, 0);
  setheadiconnaturaldistance(icon, _id_30516B4AFD1763DE);
  setheadiconmaxdistance(icon, maxdist);
  setheadicondrawthroughgeo(icon, _id_94DC5DEAB609FDC9);
  setheadiconsnaptoedges(icon, _id_C18F8868BD35FEE2);

  if(istrue(level._id_32FE21B3C5052471) && level.teambased)
    _func_CE9D0299637C2C24(icon, 1);
}

light_tank_destroyheadicon() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;
  self.headiconowneroverride = undefined;
  self.headiconteamoverride = undefined;
}

light_tank_updateheadicon(_id_26EBC4AB45D7E908, _id_C8251387149387A0) {
  if(!isDefined(self.headicon)) {
    return;
  }
  if(isDefined(_id_26EBC4AB45D7E908)) {
    if(isstring(_id_26EBC4AB45D7E908) && _id_26EBC4AB45D7E908 == "none")
      self.headiconowneroverride = undefined;
    else
      self.headiconowneroverride = _id_26EBC4AB45D7E908;
  }

  if(isDefined(_id_C8251387149387A0)) {
    if(_id_C8251387149387A0 == "none")
      self.headiconteamoverride = undefined;
    else
      self.headiconteamoverride = _id_C8251387149387A0;
  }

  light_tank_updateheadiconowner();
  light_tank_updateheadiconteam();
  light_tank_updateheadiconimage();

  foreach(player in level.players)
  light_tank_updateheadiconforplayer(player);
}

light_tank_updateheadiconforplayer(player) {
  if(!isDefined(self.headicon)) {
    return;
  }
  vehicle = player scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle) && vehicle == self)
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
  else {
    owner = undefined;

    if(isDefined(self.headiconowneroverride))
      owner = self.headiconowneroverride;
    else
      owner = self.owner;

    team = undefined;

    if(isDefined(self.headiconteamoverride))
      team = self.headiconteamoverride;
    else
      team = self.team;

    _id_962A30A9BB8C0F09 = light_tank_getleveldata();

    if(level.teambased) {
      if(team == "neutral") {
        if(!isDefined(owner)) {
          if(1)
            scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
          else
            scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);

          return;
        } else
          team = owner.team;
      }

      if(isenemyteam(team, player.team)) {
        if(istrue(_id_962A30A9BB8C0F09.showheadicontoenemy))
          scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
        else
          scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
      } else
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
    } else {
      if(!isDefined(owner)) {
        if(1)
          scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
        else
          scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);

        return;
      }

      if(player != owner) {
        if(_id_962A30A9BB8C0F09.showheadicontoenemy) {
          scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
          return;
        }

        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
        return;
        return;
      }

      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
    }
  }
}

light_tank_updateheadiconforplayeronjointeam(player) {
  lighttanks = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("light_tank");

  foreach(lighttank in lighttanks)
  lighttank light_tank_updateheadiconforplayer(player);
}

light_tank_updateheadiconowner() {
  if(level.teambased)
    return 0;

  owner = undefined;

  if(isDefined(self.headiconowneroverride))
    owner = self.headiconowneroverride;
  else
    owner = self.owner;

  if(isDefined(owner))
    setheadiconowner(self.headicon, owner);
  else
    setheadiconowner(self.headicon, undefined);

  return 1;
}

light_tank_updateheadiconteam() {
  if(!level.teambased) {
    return;
  }
  team = light_tank_getheadiconteam();

  if(isDefined(team) && team != "neutral")
    setheadiconteam(self.headicon, team);
  else
    setheadiconteam(self.headicon, undefined);
}

light_tank_updateheadiconimage() {
  _id_962A30A9BB8C0F09 = light_tank_getleveldata();
  _id_9318D957CB71A518 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);

  if(_id_9318D957CB71A518) {
    setheadiconfriendlyimage(self.headicon, level.factionfriendlyheadicon);

    if(1)
      setheadiconneutralimage(self.headicon, level.factionenemyheadicon);

    if(_id_962A30A9BB8C0F09.showheadicontoenemy)
      setheadiconenemyimage(self.headicon, level.factionenemyheadicon);
  } else {
    _id_C3E202ACF77E4DD4 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);
    _id_F1A0DCC04676E92F = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 0, _id_962A30A9BB8C0F09.showheadicontoenemy);
    _id_74CE33B771C6CA07 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_friendly", "hud_icon_killstreak_bradley_friendly");
    _id_9830D857024187A1 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley", "hud_icon_killstreak_bradley");
    _id_36A93664071874B4 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_enemy", "hud_icon_killstreak_bradley_enemy");
    setheadiconfriendlyimage(self.headicon, _id_74CE33B771C6CA07);

    if(_id_C3E202ACF77E4DD4)
      setheadiconneutralimage(self.headicon, _id_9830D857024187A1);

    if(_id_F1A0DCC04676E92F)
      setheadiconenemyimage(self.headicon, _id_36A93664071874B4);
  }
}

light_tank_getheadiconteam() {
  owner = undefined;

  if(isDefined(self.headiconowneroverride))
    owner = self.headiconowneroverride;
  else
    owner = self.owner;

  team = undefined;

  if(isDefined(self.headiconteamoverride))
    team = self.headiconteamoverride;
  else
    team = self.team;

  _id_9A6FCCC729B4650A = team;

  if(!isDefined(_id_9A6FCCC729B4650A) || team == "neutral") {
    if(isDefined(owner))
      _id_9A6FCCC729B4650A = owner.team;
  }

  return _id_9A6FCCC729B4650A;
}

light_tank_getleveldata() {
  return level.vehicle.lighttank;
}

light_tank_updateteam(vehicle, team, _id_4BCF5A0C6C1E3A44) {
  turrets = scripts\cp_mp\vehicles\vehicle::vehicle_getturrets(vehicle);

  foreach(turret in turrets)
  turret.team = team;

  if(isDefined(vehicle.headicon)) {
    if(_id_4BCF5A0C6C1E3A44) {
      vehicle light_tank_updateheadiconteam();
      vehicle light_tank_updateheadiconimage();

      foreach(player in level.players)
      vehicle light_tank_updateheadiconforplayer(player);
    }
  }
}

light_tank_updateowner(vehicle, owner, _id_443185A3B7BBA89C, _id_1FBDA3BED6B9855F) {
  if(isDefined(vehicle.headicon)) {
    if(_id_443185A3B7BBA89C)
      vehicle light_tank_updateheadiconowner();

    if(_id_1FBDA3BED6B9855F) {
      vehicle light_tank_updateheadiconteam();
      vehicle light_tank_updateheadiconimage();
    }

    if(_id_443185A3B7BBA89C || _id_1FBDA3BED6B9855F) {
      foreach(player in level.players)
      vehicle light_tank_updateheadiconforplayer(player);
    }
  }
}

light_tank_canautodestruct() {
  if(istrue(self.autodestructactivated))
    return 0;

  _id_962A30A9BB8C0F09 = light_tank_getleveldata();

  if(!_id_962A30A9BB8C0F09.canautodestruct)
    return 0;

  return 1;
}

light_tank_cantimeout() {
  if(!light_tank_cantimeoutinternal())
    return 0;

  spawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(isDefined(spawndata.cantimeout) && spawndata.cantimeout == 0)
    return 0;

  _id_962A30A9BB8C0F09 = light_tank_getleveldata();

  if(!_id_962A30A9BB8C0F09.cantimeout)
    return 0;

  if(_id_962A30A9BB8C0F09.timeoutduration <= 0)
    return 0;

  return 1;
}

light_tank_cantimeoutinternal() {
  if(istrue(self.autodestructactivated))
    return 0;

  return 1;
}

light_tank_updateplayeromnvarsonenter(vehicle, _id_FC7C7A874B43A31A, _id_7558F98F3236963D, player) {
  if(_id_7558F98F3236963D == "driver") {
    vehicle light_tank_updatedriverturretammoui();
    vehicle light_tank_updatemissileammoui();
  }

  vehicle light_tank_updatetimeoutui(player);
  vehicle light_tank_updateautodestructui(player);
}

light_tank_flippedendcallback(vehicle, _id_DD9707A466EFA528) {
  if(_id_DD9707A466EFA528)
    vehicle light_tank_timeout();
}