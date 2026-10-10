/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_31629c16ddf56ebc.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_airdrop;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace namespace_a204188ec750e835;

function main() {
  function_c0b3ddc9a6bdcc46("light_tank", &light_tank_init);
}

function private light_tank_init() {
  if(!function_9697379150687859("light_tank")) {
    return;
  }

  assertex(isDefined(level.vehicle), "<dev string:x1c>");
  assertex(!isDefined(level.vehicle.lighttank), "<dev string:x4f>");
  callbacks = [];
  callbacks["spawn"] = &light_tank_create;
  callbacks["update"] = &light_tank_update;
  callbacks["explode"] = &light_tank_explode;
  callbacks["delete"] = &function_67ecd2abc69311e;
  callbacks["initSpawnData"] = &light_tank_initializespawndata;
  callbacks["tankSpawn"] = &light_tank_spawn;
  callbacks["updateHeadIconForPlayerOnJoinTeam"] = &light_tank_updateheadiconforplayeronjointeam;
  callbacks["timeOut"] = &light_tank_timeout;
  callbacks["capture"] = &light_tank_capture;
  callbacks["copySpawnData"] = &light_tank_copyspawndata;
  callbacks["tankActivate"] = &light_tank_activate;
  callbacks["autoDestruct"] = &light_tank_autodestruct;
  callbacks["updateTeam"] = &light_tank_updateteam;
  callbacks["updateOwner"] = &light_tank_updateowner;
  callbacks["enterEnd"] = &light_tank_enterend;
  callbacks["exitEnd"] = &light_tank_exitend;
  callbacks["reenter"] = &light_tank_reenter;
  callbacks["spawnPostAirdrop"] = &light_tank_create;
  callbacks["flippedEnd"] = &light_tank_flippedendcallback;
  function_8497e7e46b5e397("light_tank", callbacks);
  level.vehicle.lighttank = spawnStruct();
  level.vehicle.lighttank.canautodestruct = 1;
  level.vehicle.lighttank.autodestructdamagepercent = 11;
  level.vehicle.lighttank.cantimeout = 1;
  level.vehicle.lighttank.timeoutduration = 165;
  level.vehicle.lighttank.cantakedamageduringcapture = 1;
  level.vehicle.lighttank.showheadicon = 1;
  level.vehicle.lighttank.showheadicontoenemy = 0;
  leveldataforvehicle = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("light_tank");
  light_tank_initomnvars();
  light_tank_initdamage();
  light_tank_initfx();
  light_tank_initvo();

  issharedfuncdefined("<dev string:x80>", "<dev string:x88>", 1);
}

function private light_tank_initomnvars() {
  leveldataforvehicle = vehomn_getleveldataforvehicle("light_tank", 1);
  leveldataforvehicle.ammoids["turret"] = 0;
  leveldataforvehicle.ammoids["missile"] = 1;
  leveldataforvehicle.ammoids["smoke"] = 2;
  leveldataforvehicle.rotationids[0] = 0;
  leveldataforvehicle.rotationids[1] = 1;
  leveldataforvehicle.rotationrefsbyseatandweapon["driver"]["lighttank_mp"] = 0;
  leveldataforvehicle.rotationrefsbyseatandweapon["driver"]["iw9_mg_light_tank_mp"] = 1;
  leveldataforvehicle.rotationrefsbyseatandweapon["gunner"]["iw9_tur_light_tank_mp"] = 0;
  leveldataforvehicle.rotationrefsbyseatandweapon["gunner"]["iw9_mg_light_tank_mp"] = 1;
}

function private light_tank_initdamage() {
  leveldataforvehicle = vehicle_damage_getleveldataforvehicle("light_tank");
  vehicle_damage_setpremoddamagecallback("light_tank", &light_tank_premoddamagecallback);
  vehicle_damage_setpostmoddamagecallback("light_tank", &light_tank_postmoddamagecallback);
  vehicle_damage_setweaponhitdamagedata("iw9_tur_light_tank_mp", 2);
  vehicle_damage_setweaponhitdamagedata("bradley_tow_proj_mp", 7);
}

function private light_tank_initfx() {
  level._effect["light_tank_cannon_dust"] = loadfx("vfx/iw8_mp/weap_kickup/vfx_wk_tank_cannon_dust_w.vfx");
}

function private light_tank_initvo() {
  game["dialog"]["light_tank_low_fuel"] = "light_tank_timeout_reminder";
  game["dialog"]["light_tank_destruct"] = "light_tank_self_destruct";
  game["dialog"]["light_tank_entry"] = "light_tank_chatter_01";
  game["dialog"]["light_tank_chatter_01"] = "light_tank_chatter_02";
  game["dialog"]["light_tank_chatter_02"] = "light_tank_chatter_03";
}

function private light_tank_create(spawndata, faildata) {
  if(!isDefined(spawndata.angles)) {
    spawndata.angles = (0, 0, 0);
  }

  if(isDefined(spawndata.var_14cde247ac3313a4)) {
    spawndata.modelname = spawndata.var_14cde247ac3313a4 + "::" + "veh9_mil_lnd_tank_x_vehphys_mp";
  } else {
    spawndata.modelname = "veh9_mil_lnd_tank_x_vehphys_mp";
  }

  spawndata.targetname = "light_tank";
  spawndata.vehicletype = "veh9_mil_lnd_tank_physics_mp";
  spawndata.cannotbesuspended = 1;
  spawndata.startsuspended = 0;

  function_b6f3b5fca0f8c2b2(spawndata);

  vehicle = _spawnVehicle(spawndata, faildata);

  if(!isDefined(vehicle)) {
    return undefined;
  }

  vehicle.isfromkillstreak = isDefined(spawndata.spawntype) && spawndata.spawntype == "KILLSTREAK";

  if(isDefined(spawndata.var_1aea8eaaca8adc25)) {
    turret = light_tank_createdriverturret(vehicle, spawndata);
    var_ca4cd400d36cb243 = spawndata.var_1aea8eaaca8adc25;
    vehicle_registerturret(vehicle, turret, makeweapon(var_ca4cd400d36cb243), 1);
  }

  vehicle.missilesleft = 2;
  vehicle.lastmissilefired = 0;
  turret = light_tank_creategunnerturret(vehicle, spawndata);
  vehicle_registerturret(vehicle, turret, makeweapon("iw9_mg_light_tank_mp"));
  vehicle_create(vehicle, "light_tank", spawndata);
  vehicle.objweapon = makeweapon("lighttank_mp");
  vehicle light_tank_updateheadicon();
  var_b101137988b007d7 = vehicle_damage_getinstancedataforvehicle(vehicle, 1);
  var_b101137988b007d7.destroyscoreevent = "none";
  vehicle_createlate(vehicle, spawndata);
  vehicle thread vehicle_watchflipped();
  vehicle thread function_1b69321ff9937fc5();
  vehicle thread light_tank_monitordriverturretfire();
  vehicle thread light_tank_monitordriverturretprojectilefire();
  vehicle thread light_tank_monitorgunnerturretfire();

  if(issharedfuncdefined("light_tank", "create")) {
    [[getsharedfunc("light_tank", "create")]](vehicle);
  }

  return vehicle;
}

function private light_tank_createdriverturret(vehicle, spawndata) {
  leveldata = light_tank_getleveldata();
  weaponname = undefined;

  if(isDefined(spawndata.var_1aea8eaaca8adc25)) {
    weaponname = spawndata.var_1aea8eaaca8adc25;
    vehicle.var_a94fabd846e764f2 = weaponname;
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

function private light_tank_creategunnerturret(vehicle, spawndata) {
  weaponname = undefined;

  if(isDefined(spawndata.var_6d497ea17c312778)) {
    weaponname = spawndata.var_6d497ea17c312778;
  }

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

function private light_tank_activate() {
  if(istrue(self.isactivated)) {
    return;
  }

  self.isactivated = 1;
  leveldata = light_tank_getleveldata();
  showheadicon = undefined;

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    showheadicon = 0;
  } else if(isDefined(self.spawndata.showheadicon)) {
    showheadicon = self.spawndata.showheadicon;
  } else {
    showheadicon = leveldata.showheadicon;
  }

  if(showheadicon) {
    light_tank_createheadicon();
    light_tank_updateheadicon();
  }

  if(issharedfuncdefined("light_tank", "activate")) {
    [[getsharedfunc("light_tank", "activate")]](self);
  }
}

function private light_tank_explode(data, immediate, autodestruct) {
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
    damagetype = undefined;
    damage = data.damage;
    scorepopupname = "destroyed_" + streakname;
    leaderdialog = streakname + "_destroyed";
    cardsplash = "callout_destroyed_" + streakname;
    skipdeathnotify = 1;

    if(issharedfuncdefined("damage", "onKillstreakKilled")) {
      notifyattacker = self[[getsharedfunc("damage", "onKillstreakKilled")]](streakname, attacker, objweapon, damagetype, damage, scorepopupname, leaderdialog, cardsplash, skipdeathnotify);
    }
  } else {
    data = spawnStruct();
    data.inflictor = self;
    data.objweapon = "lighttank_mp";
    data.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(isvehiclehusk()) {
    function_e3ff0a92ad2bf58d(data, immediate);
    return;
  }

  function_9672da471530b44a(data, immediate);
}

function private function_67ecd2abc69311e(vehicle) {
  thread light_tank_endcapture(self);
  light_tank_destroyheadicon();

  if(isDefined(self.objent)) {
    light_tank_destroyobjective(self.objent);
    self.objent = undefined;
  }
}

function private light_tank_initializespawndata(spawndata) {
  if(!isDefined(spawndata)) {
    spawndata = spawnStruct();
  }

  if(!isDefined(spawndata.spawnmethod)) {
    spawndata.spawnmethod = "airdrop_at_position_unsafe";
  }

  if(!isDefined(spawndata.cancapture)) {
    spawndata.cancapture = 0;
  }

  if(!isDefined(spawndata.cancaptureimmediately)) {
    spawndata.cancaptureimmediately = 0;
  }

  if(!isDefined(spawndata.activateimmediately)) {
    spawndata.activateimmediately = 1;
  }

  if(!isDefined(spawndata.faceawayfromowner)) {
    spawndata.faceawayfromowner = 0;
  }

  return spawndata;
}

function private light_tank_copyspawndata(from, to) {
  to.spawnmethod = from.spawnmethod;
  to.cancapture = from.cancapture;
  to.cancaptureimmediately = from.cancaptureimmediately;
  to.activateimmediately = from.activateimmediately;
  to.faceawayfromowner = from.faceawayfromowner;
  to.cantimeout = from.cantimeout;
  to.showheadicon = from.showheadicon;
}

function private light_tank_spawn(spawndata, faildata, streakinfo) {
  spawnposition = undefined;
  spawnangles = undefined;
  var_a50521aed4831f1c = undefined;
  var_3ee18b54b626dba8 = undefined;
  spawndata = light_tank_initializespawndata(spawndata);
  assertex(isDefined(spawndata) && (isDefined(spawndata.origin) || spawndata.spawnmethod == "<dev string:x97>"), "<dev string:xae>");
  isairdrop = issubstr(spawndata.spawnmethod, "airdrop_");
  spawnposition = spawndata.origin;
  spawnangles = spawndata.angles;

  if(isDefined(spawndata.owner) && istrue(spawndata.faceawayfromowner)) {
    between = spawnposition - spawndata.owner.origin;

    if(length2dsquared(between) > 0) {
      spawnangles = vectortoangles(spawnposition - spawndata.owner.origin);
    } else {
      spawnangles = spawndata.owner getplayerangles(1);
    }
  }

  if(!isDefined(spawnangles)) {
    spawnangles = (0, randomint(360), 0);
  } else {
    spawnangles *= (0, 1, 0);
  }

  vehicle = undefined;

  if(isairdrop) {
    vehicle = light_tank_airdrop(spawnposition, spawnangles, var_a50521aed4831f1c, var_3ee18b54b626dba8, spawndata, faildata);
  } else {
    vehicle = light_tank_place(spawnposition, spawnangles, spawndata, faildata);
  }

  return vehicle;
}

function private light_tank_place(spawnposition, spawnangles, spawndata, faildata) {
  oldorigin = spawndata.origin;
  oldangles = spawndata.angles;
  spawndata.origin = spawnposition;
  spawndata.angles = spawnangles;
  vehicle = light_tank_create(spawndata, faildata);
  spawndata.origin = oldorigin;
  spawndata.angles = oldangles;

  if(!isDefined(vehicle)) {
    return undefined;
  }

  if(spawndata.cancapture) {
    if(spawndata.cancaptureimmediately) {
      thread light_tank_startcapture(vehicle, spawndata.owner, spawndata.team);
    }
  } else if(spawndata.activateimmediately) {
    vehicle thread light_tank_activate();
  }

  return vehicle;
}

function private light_tank_airdrop(position, angles, groundposition, groundnormal, spawndata, faildata) {
  spawndata.origin = position;
  spawndata.angles = angles;
  objent = undefined;

  if(isDefined(groundposition)) {
    if(!scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
      objent = light_tank_createobjective(groundposition, groundnormal, spawndata);
    }
  }

  vehicle = scripts\cp_mp\vehicles\vehicle_airdrop::vehicle_airdrop("light_tank", spawndata, faildata);
  vehicle.objent = objent;
  vehicle thread function_9e0c2cd85fa8c581();
  return vehicle;
}

function private function_9e0c2cd85fa8c581() {
  self waittill("landed");

  if(isDefined(self.objent)) {
    light_tank_destroyobjective(self.objent);
    self.objent = undefined;
  }

  while(lengthsquared(self vehicle_getvelocity()) > 400) {
    waitframe();
  }

  spawndata = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata(self);

  if(spawndata.cancapture) {
    if(spawndata.cancaptureimmediately) {
      thread light_tank_startcapture(self, self.owner, self.team);
    }

    return;
  }

  if(spawndata.activateimmediately) {
    thread light_tank_activate();
  }
}

function private light_tank_createobjective(groundposition, groundnormal, spawndata) {
  objid = [[getsharedfunc("game", "requestObjectiveID")]](99);
  objent = spawn("script_model", groundposition);
  objent setModel("ks_airstrike_marker_mp");
  forward = (1, 0, 0);
  right = vectorcross(forward, groundnormal);
  forward = vectorcross(groundnormal, right);
  angles = axistoangles(forward, right, groundnormal);
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
      var_9a6fccc729b4650a = spawndata.team;

      if(!isDefined(var_9a6fccc729b4650a) || var_9a6fccc729b4650a == "neutral") {
        if(isDefined(spawndata.owner)) {
          var_9a6fccc729b4650a = spawndata.owner.team;
        }
      }

      if(!isDefined(var_9a6fccc729b4650a) || var_9a6fccc729b4650a == "neutral") {
        objective_addalltomask(objid);
        objent setscriptablepartstate("marker_placed", "onEveryone", 0);
      } else {
        objective_addteamtomask(objid, var_9a6fccc729b4650a);
        light_tank_setteamotherent(objent, var_9a6fccc729b4650a);
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

function private light_tank_destroyobjective(objent) {
  if(isDefined(objent.objid)) {
    [[getsharedfunc("game", "returnObjectiveID")]](objent.objid);
  }

  objent delete();
}

function private light_tank_setteamotherent(objent, team) {
  objent notify("light_tank_setTeamOtherEnt");
  objent endon("light_tank_setTeamOtherEnt");
  otherent = undefined;

  foreach(player in level.players) {
    if(player.team == team) {
      otherent = player;
      break;
    }
  }

  if(isDefined(otherent)) {
    objent setotherent(otherent);
    childthread light_tank_monitorotherentjoined(objent, otherent);
    childthread light_tank_monitorotherentdisconnect(objent, otherent);
  }
}

function private light_tank_monitorotherentjoined(objent, otherent) {
  objent endon("death");
  oldteam = otherent.team;
  otherent waittill_any_2("joined_team", "joined_spectators");
  thread light_tank_setteamotherent(objent, oldteam);
}

function private light_tank_monitorotherentdisconnect(objent, otherent) {
  oldteam = otherent.team;
  otherent waittill("disconnect");
  thread light_tank_setteamotherent(objent, oldteam);
}

function private light_tank_startcapture(vehicle, owner, team) {
  leveldata = light_tank_getleveldata();
  showheadicon = undefined;

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    showheadicon = 0;
  } else if(isDefined(vehicle.spawndata.showheadicon)) {
    showheadicon = vehicle.spawndata.showheadicon;
  } else {
    showheadicon = leveldata.showheadicon;
  }

  if(showheadicon) {
    vehicle light_tank_createheadicon(1);
    vehicle light_tank_updateheadicon(owner, team);
  }

  if(issharedfuncdefined("light_tank", "startCapture")) {
    [[getsharedfunc("light_tank", "startCapture")]](vehicle, owner, team);
  }
}

function private light_tank_endcapture(vehicle) {
  if(issharedfuncdefined("light_tank", "endCapture")) {
    [[getsharedfunc("light_tank", "endCapture")]](vehicle);
  }
}

function private light_tank_capture(vehicle, player) {
  thread light_tank_endcapture(vehicle);
  vehicle_occupancy_setteam(vehicle, player.team);
  vehicle_occupancy_setowner(vehicle, player);
  thread vehicle_occupancy_enter(vehicle, "driver", player);
  vehicle thread light_tank_activate();

  if(issharedfuncdefined("light_tank", "capture")) {
    [[getsharedfunc("light_tank", "capture")]](player, vehicle);
  }
}

function private light_tank_update(data) {
  if(isvehicledestroyed()) {
    return;
  }

  light_tank_updatetimeout();
  vehicle_occupancy_updatemovefeedback("driver");
}

function private light_tank_monitordriverturretfire() {
  self endon("death");
  light_tank_updatedriverturretammoui();
  light_tank_updatemissileammoui();

  while(true) {
    message = waittill_any_return_2("vehicle_turret_fire", "vehicle_turret_reload_end");

    if(message == "vehicle_turret_fire") {
      light_tank_turretdustkickup();
    }

    light_tank_updatedriverturretammoui();
  }
}

function private light_tank_monitordriverturretprojectilefire() {
  self endon("death");

  while(true) {
    self waittill("vehicle_turret_fire", param1, param2, projectile);
    driver = vehicle_occupancy_getseatoccupant(self, "driver");
    projectile thread light_tank_watchprojectileexplosion(driver);
    projectile.vehicle = self;

    if(isDefined(self.streakinfo)) {
      projectile.streakinfo = self.streakinfo;
      self.streakinfo.shots_fired++;
    }
  }
}

function private light_tank_watchprojectileexplosion(driver) {
  level endon("game_ended");
  self waittill("explode", position);

  if(!isDefined(driver)) {
    return;
  }

  if(issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[getsharedfunc("spawn", "addSpawnDangerZone")]](position, 175, 175, driver.team, 1, driver, 1);
  }
}

function private light_tank_monitordriverturretreload(driver) {
  self endon("death");

  if(isDefined(driver)) {
    driver endon("vehicle_change_seat");
    driver endon("vehicle_seat_exit");
    driver endon("death_or_disconnect");

    while(driver reloadbuttonPressed()) {
      waitframe();
    }

    var_33193f537b85b6d4 = getdvarint(@ "hash_9402582f8123db99", 250) / 1000;

    while(true) {
      holdtime = 0;
      usereloadconfig = driver getcurrentusereloadconfig();
      var_72e25a59fcef57b5 = 0;

      while(driver reloadbuttonPressed()) {
        if(!driver usinggamepad() && self function_ab2bddb6cd03a29d() < weaponclipsize("iw9_tur_light_tank_mp")) {
          self function_4012509dbd1cee6f();
          var_72e25a59fcef57b5 = 1;
          light_tank_updatedriverturretammoui();
          break;
        }

        if(self function_ab2bddb6cd03a29d() < weaponclipsize("iw9_tur_light_tank_mp") && usereloadconfig > 0 && holdtime >= var_33193f537b85b6d4) {
          self function_4012509dbd1cee6f();
          var_72e25a59fcef57b5 = 1;
          light_tank_updatedriverturretammoui();
        }

        holdtime += level.framedurationseconds;
        waitframe();
      }

      if(!var_72e25a59fcef57b5 && driver usinggamepad() && self function_ab2bddb6cd03a29d() < weaponclipsize("iw9_tur_light_tank_mp") && (usereloadconfig == 0 && holdtime > 0 && holdtime < 0.2 || usereloadconfig > 0 && holdtime >= var_33193f537b85b6d4)) {
        self function_4012509dbd1cee6f();
        light_tank_updatedriverturretammoui();
      }

      waitframe();
    }
  }
}

function private light_tank_updatedriverturretammoui() {
  driver = vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(driver)) {
    vehomn_setammo("light_tank", "turret", self function_ab2bddb6cd03a29d(), driver);
  }
}

function private light_tank_watchmissileinputchange() {
  self notify("watch_missile_input_change");
  self endon("watch_missile_input_change");

  while(true) {
    var_6b65638b1a820f6c = light_tank_getmissileplayercommand();
    self notifyonplayercommand("light_tank_missile", var_6b65638b1a820f6c);
    returnednotif = waittill_any_return_no_endon_death_2("input_type_changed", "missile_handling_ended");
    self notifyonplayercommandremove("light_tank_missile", var_6b65638b1a820f6c);

    if(!isDefined(returnednotif) || returnednotif == "missile_handling_ended") {
      break;
    }
  }
}

function private light_tank_stopwatchingmissileinputchange() {
  self notify("missile_handling_ended");
}

function private light_tank_getmissileplayercommand() {
  return "+melee_zoom";
}

function private light_tank_monitordrivermissilefire(player) {
  self endon("death");
  self endon("light_tank_driver_exit");

  while(true) {
    player waittill("light_tank_missile");

    if(gettime() - self.lastmissilefired >= 1330) {
      if(isDefined(self.missilesleft) && self.missilesleft > 0) {
        self.lastmissilefired = gettime();
        vehicle_occupancy_fadeoutcontrols(player);
        light_tank_firemissile(player, player.stingertarget);
        light_tank_adjustmissileammo(-1);

        if(getdvarint(@ "hash_684118f4e2ed5dfd", 0) != 0) {
          light_tank_adjustmissileammo(999999);
        }

        continue;
      }

      player iprintlnbold("<dev string:xd3>");
    }
  }
}

function private light_tank_firemissile(player, target) {
  wait 0.33;
  self setscriptablepartstate("towMissileFX", "active");
  start = self gettagorigin("tag_flash");
  angles = self gettagangles("tag_flash");
  end = start + anglesToForward(angles);
  player childthread light_tank_playmissilefireplayerfx();
  weaponname = undefined;
  weaponname = "bradley_tow_proj_mp";

  if(isDefined(self.streakinfo)) {
    self.streakinfo.shots_fired++;
  }

  missile = _magicbullet(makeweapon(weaponname), start, end, player);
  missile.vehicle = self;
  missile.streakinfo = self.streakinfo;

  if(isDefined(target)) {
    missile missile_settargetEnt(target);
    thread watchtargetlockedontobyprojectile(target, missile);
  }
}

function private light_tank_adjustmissileammo(amount) {
  self.missilesleft += amount;
  self.missilesleft = int(clamp(self.missilesleft, 0, 2));
  light_tank_updatemissileammoui();
}

function private light_tank_updatemissileammoui() {
  driver = vehicle_occupancy_getseatoccupant(self, "driver");

  if(isDefined(driver)) {
    vehomn_setammo("light_tank", "missile", self.missilesleft, driver);
  }
}

function private light_tank_playmissilefireplayerfx() {
  self endon("disconnect");
  self setblurforplayer(0.333, 0.1);
  wait 0.15;
  vehicle_occupancy_heavydamagefeedbackforplayer();
  wait 0.35;
  light_tank_endmissilefireplayerfx();
}

function private light_tank_endmissilefireplayerfx(immediate) {
  if(!istrue(immediate)) {
    self setblurforplayer(0, 0.1);
    return;
  }

  self setblurforplayer(0, 0);
}

function private light_tank_monitorgunnerturretfire() {
  self endon("death");
  turret = vehicle_getturretbyweapon(self, "iw9_mg_light_tank_mp");

  while(true) {
    turret waittill("turret_fire");

    if(isDefined(self.streakinfo)) {
      self.streakinfo.shots_fired++;
    }
  }
}

function private light_tank_updateautodestructui(player) {
  leveldata = light_tank_getleveldata();

  if(leveldata.canautodestruct) {
    if(istrue(self.autodestructactivated)) {
      vehomn_showwarning("burningDown", player, "light_tank");
    } else {
      vehomn_hidewarning("burningDown", player, "light_tank");
    }

    return;
  }

  vehomn_hidewarning("burningDown", player, "light_tank");
}

function private light_tank_updatetimeoutui(player, timepercent) {
  leveldata = light_tank_getleveldata();

  if(light_tank_cantimeout()) {
    if(!isDefined(timepercent)) {
      timepercent = (leveldata.timeoutduration - self.timeelapsed) / leveldata.timeoutduration;
      timepercent = clamp(timepercent, 0, 1);
    }

    vehomn_settimepercent(timepercent, player);
    vehomn_showtime(player);
    return;
  }

  vehomn_cleartimepercent(player);
  vehomn_hidetime(player);
}

function private light_tank_updatetimeout() {
  if(light_tank_cantimeout()) {
    if(!isDefined(self.timeelapsed)) {
      self.timeelapsed = 0;
    }

    if(istrue(self.isactivated)) {
      self.timeelapsed += level.framedurationseconds;
      leveldata = light_tank_getleveldata();
      timepercent = (leveldata.timeoutduration - self.timeelapsed) / leveldata.timeoutduration;
      timepercent = int(ceil(clamp(timepercent, 0, 1) * 100));

      if(self.timeelapsed >= leveldata.timeoutduration) {
        thread light_tank_timeout();
      } else {
        occupants = vehicle_occupancy_getalloccupants(self);

        foreach(occupant in occupants) {
          light_tank_updatetimeoutui(occupant, timepercent);
        }
      }
    } else {
      occupants = vehicle_occupancy_getalloccupants(self);

      foreach(occupant in occupants) {
        light_tank_updatetimeoutui(occupant, 1);
      }
    }

    return;
  }

  self.timeelapsed = undefined;
}

function private light_tank_timeout() {
  if(light_tank_canautodestruct()) {
    thread light_tank_autodestruct();
    occupants = vehicle_occupancy_getalloccupants(self);

    foreach(occupant in occupants) {
      light_tank_updatetimeoutui(occupant, undefined);
    }

    return;
  }

  thread light_tank_explode(undefined, 0, 1);
}

function private light_tank_enterend(vehicle, seatid, var_fc7c7a874b43a31a, player, data) {
  if(istrue(data.success)) {
    thread light_tank_enterendinternal(vehicle, seatid, var_fc7c7a874b43a31a, player, data);
  }
}

function private light_tank_enterendinternal(vehicle, seatid, var_fc7c7a874b43a31a, player, data) {
  if(seatid == "driver") {
    thread vehicle_occupancy_disablefirefortime(player, 100);
    player thread light_tank_watchmissileinputchange();
    vehicle thread light_tank_monitordrivermissilefire(player);
    player killstreak_savenvgstate();
  } else if(seatid == "gunner") {
    level thread vehicle_occupancy_disablefirefortime(player, ter_op(istrue(vehicle.var_ecc491f42aaceaf4), 850, 2200));
    player thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(player, vehicle, "iw9_mg_light_tank_mp", 1);
    vehicle.var_ecc491f42aaceaf4 = 1;
    light_tank_addgunnerdamagemod(player);
  }

  if(!isDefined(var_fc7c7a874b43a31a)) {
    vehicle light_tank_updateheadiconforplayer(player);
  }

  vehomn_updateomnvarsonseatenter(vehicle, var_fc7c7a874b43a31a, seatid, player);
  light_tank_updateplayeromnvarsonenter(vehicle, var_fc7c7a874b43a31a, seatid, player);

  if(seatid == "driver") {
    vehicle thread light_tank_monitordriverturretreload(player);
  }
}

function private light_tank_exitend(vehicle, seatid, var_7558f98f3236963d, player, data) {
  if(istrue(data.success)) {
    thread light_tank_exitendinternal(vehicle, seatid, var_7558f98f3236963d, player, data);
  }
}

function private light_tank_exitendinternal(vehicle, seatid, var_7558f98f3236963d, player, data) {
  if(seatid == "driver") {
    vehicle notify("light_tank_driver_exit");
    light_tank_stopwatchingmissileinputchange();

    if(!istrue(data.playerdisconnect)) {
      if(!istrue(data.playerdeath)) {
        player light_tank_endmissilefireplayerfx(1);
      }

      player killstreak_restorenvgstate();
    }
  } else if(seatid == "gunner") {
    turret = vehicle_getturretbyweapon(vehicle, "iw9_mg_light_tank_mp");

    if(!istrue(data.playerdisconnect)) {
      player enableturretdismount();
      player controlturretoff(turret);
      thread vehicle_occupancy_cleardisablefirefortime(player, data.playerdeath);

      if(!istrue(data.playerdeath)) {
        thread vehicle_occupancy_taketurret(player, vehicle, "iw9_mg_light_tank_mp", data, 1);
      }
    }

    turret.owner = undefined;
    turret setotherent(undefined);
    turret setentityowner(undefined);
    turret setsentryowner(undefined);
    light_tank_removegunnerdamagemod(player);
  }

  if(!istrue(data.playerdisconnect)) {
    if(!isDefined(var_7558f98f3236963d)) {
      vehicle light_tank_updateheadiconforplayer(player);
    }

    success = vehicle_occupancy_moveplayertoexit(vehicle, seatid, var_7558f98f3236963d, player, data);

    if(!success) {
      if(issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      } else {
        player suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(vehicle, seatid, var_7558f98f3236963d, player);
}

function private light_tank_reenter(vehicle, var_9de41f2ee77c33ba, var_3f68c37bafd38606, player, data) {
  if(var_9de41f2ee77c33ba == "driver") {
    vehicle thread light_tank_monitordrivermissilefire(player);
  }

  if(isDefined(var_3f68c37bafd38606) && var_3f68c37bafd38606 == "gunner") {
    thread vehicle_occupancy_taketurret(player, vehicle, "iw9_mg_light_tank_mp", data, 1);
  }
}

function private light_tank_addgunnerdamagemod(player) {
  if(isDefined(player.gunnerdamagemodifier)) {
    return;
  }

  player scripts\cp_mp\utility\damage_utility::adddamagemodifier("ltGunnerMissileRedux", 0.4, 0, &light_tank_gunnerdamagemodignorefunc);
}

function private light_tank_removegunnerdamagemod(player) {
  if(!isDefined(player.gunnerdamagemodifier)) {
    return;
  }

  player.gunnerdamagemodifier = undefined;
  player scripts\cp_mp\utility\damage_utility::removedamagemodifier("ltGunnerMissileRedux", 0);
}

function private light_tank_gunnerdamagemodignorefunc(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(meansofdeath != "MOD_PROJECTILE_SPLASH" && meansofdeath != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(objweapon)) {
    return 1;
  }

  switch (objweapon.basename) {
    case #"hash_2f1a9d8e2f127205":
    case #"hash_3e782fd775b72022":
    case #"hash_5c272c0617caebf0":
    case #"hash_5cbb3a1a84d47f1d":
    case #"hash_6b9700922cc910a9":
    case #"hash_a622e958420b92a0":
    case #"hash_a9e31b8ffd42a67b":
    case #"hash_b5e9f2d6fac1a505":
    case #"hash_d2d2f2854b7d8b7d":
    case #"hash_e704ecf8710c6f57":
    case #"hash_f55c20924061bd15":
    case #"hash_fd9c279f85990dad":
      return 0;
    default:
      return 1;
  }
}

function private light_tank_premoddamagecallback(data) {
  if(vehicle_damage_isselfdamage(self, data)) {
    return false;
  }

  var_6b11d3047f506fb6 = self.origin - data.point;
  normal = anglestoup(self.angles);
  dist = vectordot(var_6b11d3047f506fb6, normal);
  var_d74074ad5396e58a = data.point + normal * dist;
  var_c47f1816352556dd = vectorNormalize(var_d74074ad5396e58a - self.origin);
  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);

  if(vectordot(var_c47f1816352556dd, forward) < -0.83) {
    data.isrearcriticaldamage = function_1989bd346c21b68a(data);
  }

  return true;
}

function private light_tank_postmoddamagecallback(data) {
  if(istrue(data.isrearcriticaldamage)) {
    data.damage = int(data.damage * 1.6);
  }

  return true;
}

function private light_tank_autodestruct(attacker) {
  self endon("death");
  self notify("flipped_end");

  if(!istrue(self.autodestructactivated)) {
    self.autodestructactivated = 1;

    if(!utility::iscp()) {
      maxhealth = vehicle_damage_getheavystatemaxhealth(self);
      self.health = int(min(self.health, maxhealth));
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
      vehicle_damage_updatestate();
      return;
    }

    occupants = vehicle_occupancy_getalloccupants(self);

    foreach(occupant in occupants) {
      light_tank_updateautodestructui(occupant);
    }

    wait 5.5;
    thread light_tank_explode(undefined, undefined, 1);
  }
}

function private light_tank_turretdustkickup() {
  contents = physics_createcontents(["physicscontents_itemclip", "physicscontents_water", "physicscontents_glass", "physicscontents_item"]);
  ignorelist = self getlinkedchildren();

  if(!isDefined(ignorelist)) {
    ignorelist = [];
  }

  ignorelist[ignorelist.size] = self;
  caststart = self gettagorigin("tag_flash");
  castend = caststart + (0, 0, 1) * -1 * 200;
  castresults = physics_raycast(caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1);

  if(!isDefined(castresults) || !castresults.size) {
    return;
  }

  forward = anglesToForward(self gettagangles("tag_flash") * (0, 1, 0));
  up = castresults[0]["normal"];
  right = vectorcross(forward, up);
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  playFX(getfx("light_tank_cannon_dust"), castresults[0]["position"], anglesToForward(angles), anglestoup(angles));
}

function private light_tank_createheadicon(var_45c9b66826527876) {
  icon = self.headicon;

  if(!isDefined(icon)) {
    icon = scripts\cp_mp\entityheadicons::setheadicon_createnewicon();

    if(!isDefined(icon)) {
      return 0;
    }

    self.headicon = icon;
    setheadiconzoffset(icon, 110);
  }

  self.headiconforcapture = istrue(var_45c9b66826527876);
  naturaldist = ter_op(istrue(var_45c9b66826527876), 0, 0);
  maxdist = ter_op(istrue(var_45c9b66826527876), 2250, 2250);
  var_94dc5deab609fdc9 = ter_op(istrue(var_45c9b66826527876), 1, 0);
  var_c18f8868bd35fee2 = ter_op(istrue(var_45c9b66826527876), 1, 0);
  setheadiconnaturaldistance(icon, naturaldist);
  setheadiconmaxdistance(icon, maxdist);
  setheadicondrawthroughgeo(icon, var_94dc5deab609fdc9);
  setheadiconsnaptoedges(icon, var_c18f8868bd35fee2);

  if(istrue(level.var_32fe21b3c5052471) && level.teambased) {
    function_ce9d0299637c2c24(icon, 1);
  }
}

function private light_tank_destroyheadicon() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;
  self.headiconowneroverride = undefined;
  self.headiconteamoverride = undefined;
}

function private light_tank_updateheadicon(owneroverride, teamoverride) {
  if(!isDefined(self.headicon)) {
    return;
  }

  if(isDefined(owneroverride)) {
    if(isstring(owneroverride) && owneroverride == "none") {
      self.headiconowneroverride = undefined;
    } else {
      self.headiconowneroverride = owneroverride;
    }
  }

  if(isDefined(teamoverride)) {
    if(teamoverride == "none") {
      self.headiconteamoverride = undefined;
    } else {
      self.headiconteamoverride = teamoverride;
    }
  }

  light_tank_updateheadiconowner();
  light_tank_updateheadiconteam();
  light_tank_updateheadiconimage();

  foreach(player in level.players) {
    light_tank_updateheadiconforplayer(player);
  }
}

function private light_tank_updateheadiconforplayer(player) {
  if(!isDefined(self.headicon)) {
    return;
  }

  vehicle = player scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle) && vehicle == self) {
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
    return;
  }

  owner = undefined;

  if(isDefined(self.headiconowneroverride)) {
    owner = self.headiconowneroverride;
  } else {
    owner = self.owner;
  }

  team = undefined;

  if(isDefined(self.headiconteamoverride)) {
    team = self.headiconteamoverride;
  } else {
    team = self.team;
  }

  leveldata = light_tank_getleveldata();

  if(level.teambased) {
    if(team == "neutral") {
      if(!isDefined(owner)) {
        if(true) {
          scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
          return;
        }

        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
        return;
      } else {
        team = owner.team;
      }
    }

    if(isenemyteam(team, player.team)) {
      if(istrue(leveldata.showheadicontoenemy)) {
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
      } else {
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
      }
    } else {
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
    }

    return;
  }

  if(!isDefined(owner)) {
    if(true) {
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
      return;
    }

    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
    return;
  }

  if(player != owner) {
    if(leveldata.showheadicontoenemy) {
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
    } else {
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
    }

    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
}

function private light_tank_updateheadiconforplayeronjointeam(player) {
  lighttanks = vehicle_tracking_getgameinstances("light_tank");

  foreach(lighttank in lighttanks) {
    lighttank light_tank_updateheadiconforplayer(player);
  }
}

function private light_tank_updateheadiconowner() {
  if(level.teambased) {
    return false;
  }

  owner = undefined;

  if(isDefined(self.headiconowneroverride)) {
    owner = self.headiconowneroverride;
  } else {
    owner = self.owner;
  }

  if(isDefined(owner)) {
    setheadiconowner(self.headicon, owner);
  } else {
    setheadiconowner(self.headicon, undefined);
  }

  return true;
}

function private light_tank_updateheadiconteam() {
  if(!level.teambased) {
    return;
  }

  team = light_tank_getheadiconteam();

  if(isDefined(team) && team != "neutral") {
    setheadiconteam(self.headicon, team);
    return;
  }

  setheadiconteam(self.headicon, undefined);
}

function private light_tank_updateheadiconimage() {
  leveldata = light_tank_getleveldata();
  var_9318d957cb71a518 = ter_op(istrue(self.headiconforcapture), 1, 1);

  if(var_9318d957cb71a518) {
    setheadiconfriendlyimage(self.headicon, level.factionfriendlyheadicon);

    if(true) {
      setheadiconneutralimage(self.headicon, level.factionenemyheadicon);
    }

    if(leveldata.showheadicontoenemy) {
      setheadiconenemyimage(self.headicon, level.factionenemyheadicon);
    }

    return;
  }

  var_c3e202acf77e4dd4 = ter_op(istrue(self.headiconforcapture), 1, 1);
  var_f1a0dcc04676e92f = ter_op(istrue(self.headiconforcapture), 0, leveldata.showheadicontoenemy);
  friendlyimage = ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_friendly", "hud_icon_killstreak_bradley_friendly");
  neutralimage = ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley", "hud_icon_killstreak_bradley");
  enemyimage = ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_enemy", "hud_icon_killstreak_bradley_enemy");
  setheadiconfriendlyimage(self.headicon, friendlyimage);

  if(var_c3e202acf77e4dd4) {
    setheadiconneutralimage(self.headicon, neutralimage);
  }

  if(var_f1a0dcc04676e92f) {
    setheadiconenemyimage(self.headicon, enemyimage);
  }
}

function private light_tank_getheadiconteam() {
  owner = undefined;

  if(isDefined(self.headiconowneroverride)) {
    owner = self.headiconowneroverride;
  } else {
    owner = self.owner;
  }

  team = undefined;

  if(isDefined(self.headiconteamoverride)) {
    team = self.headiconteamoverride;
  } else {
    team = self.team;
  }

  var_9a6fccc729b4650a = team;

  if(!isDefined(var_9a6fccc729b4650a) || team == "neutral") {
    if(isDefined(owner)) {
      var_9a6fccc729b4650a = owner.team;
    }
  }

  return var_9a6fccc729b4650a;
}

function private light_tank_getleveldata() {
  assertex(isDefined(level.vehicle), "<dev string:x1c>");
  assertex(isDefined(level.vehicle.lighttank), "<dev string:xe6>");
  return level.vehicle.lighttank;
}

function private light_tank_updateteam(vehicle, team, teamchanged) {
  turrets = vehicle_getturrets(vehicle);

  foreach(turret in turrets) {
    turret.team = team;
  }

  if(isDefined(vehicle.headicon)) {
    if(teamchanged) {
      vehicle light_tank_updateheadiconteam();
      vehicle light_tank_updateheadiconimage();

      foreach(player in level.players) {
        vehicle light_tank_updateheadiconforplayer(player);
      }
    }
  }
}

function private light_tank_updateowner(vehicle, owner, ownerchanged, ownerteamchanged) {
  if(isDefined(vehicle.headicon)) {
    if(ownerchanged) {
      vehicle light_tank_updateheadiconowner();
    }

    if(ownerteamchanged) {
      vehicle light_tank_updateheadiconteam();
      vehicle light_tank_updateheadiconimage();
    }

    if(ownerchanged || ownerteamchanged) {
      foreach(player in level.players) {
        vehicle light_tank_updateheadiconforplayer(player);
      }
    }
  }
}

function private light_tank_canautodestruct() {
  if(istrue(self.autodestructactivated)) {
    return false;
  }

  leveldata = light_tank_getleveldata();

  if(!leveldata.canautodestruct) {
    return false;
  }

  return true;
}

function private light_tank_cantimeout() {
  if(!light_tank_cantimeoutinternal()) {
    return false;
  }

  spawndata = getvehiclespawndata(self);

  if(isDefined(spawndata.cantimeout) && spawndata.cantimeout == 0) {
    return false;
  }

  leveldata = light_tank_getleveldata();

  if(!leveldata.cantimeout) {
    return false;
  }

  if(leveldata.timeoutduration <= 0) {
    return false;
  }

  return true;
}

function private light_tank_cantimeoutinternal() {
  if(istrue(self.autodestructactivated)) {
    return false;
  }

  return true;
}

function private light_tank_updateplayeromnvarsonenter(vehicle, var_fc7c7a874b43a31a, var_7558f98f3236963d, player) {
  if(var_7558f98f3236963d == "driver") {
    vehicle light_tank_updatedriverturretammoui();
    vehicle light_tank_updatemissileammoui();
  }

  vehicle light_tank_updatetimeoutui(player);
  vehicle light_tank_updateautodestructui(player);
}

function private light_tank_flippedendcallback(vehicle, timedout) {
  if(timedout) {
    vehicle light_tank_timeout();
  }
}

function private function_b6f3b5fca0f8c2b2(spawndata) {
  if(!function_3a040ff591c32b5c(spawndata)) {
    return 0;
  }

  if(!isDefined(spawndata.spawnmethod)) {
    thread error("<dev string:x11c>");
    return 0;
  }

  if(spawndata.spawnmethod != "<dev string:x97>" && spawndata.spawnmethod != "<dev string:x146>" && spawndata.spawnmethod != "<dev string:x15d>" && spawndata.spawnmethod != "<dev string:x17b>" && spawndata.spawnmethod != "<dev string:x190>") {
    thread error("<dev string:x1ac>");
    return 0;
  }

  if(spawndata.spawnmethod == "<dev string:x97>") {
    if(!isDefined(spawndata.owner)) {
      thread error("<dev string:x256>");
      return 0;
    }
  } else if(spawndata.spawnmethod == "<dev string:x146>") {
    if(!isDefined(spawndata.origin) || !isDefined(spawndata.angles)) {
      thread error("<dev string:x2ab>");
      return 0;
    }
  } else if(spawndata.spawnmethod == "<dev string:x17b>") {
    if(!isDefined(spawndata.origin)) {
      thread error("<dev string:x316>");
      return 0;
    }
  }

  if(issubstr(spawndata.spawnmethod, "<dev string:x36a>")) {
    if(!isDefined(spawndata.origin) || !isDefined(spawndata.angles)) {
      thread error("<dev string:x375>");
      return 0;
    }
  }
}

# /