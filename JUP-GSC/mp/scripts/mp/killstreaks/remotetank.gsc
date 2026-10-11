/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\killstreaks\remotetank.gsc
****************************************************/

#using script_13865ca76df87ea;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\killstreaks\sentry_gun;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\turret_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\movers;
#using scripts\mp\outofbounds;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#namespace remotetank;

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("pac_sentry", &tryuseremotetankfromstruct);
  scripts\engine\utility::registersharedfunc("remoteTank", "attachXRays", &function_8cba478f80e8ac72);

  bundle = level.streakglobals.streakbundles["<dev string:x1c>"];

  if(!isDefined(bundle)) {
    setdevdvarifuninitialized(@ "hash_d429fa03fd7003ad", 60);
  } else {
    setdevdvarifuninitialized(@ "hash_d429fa03fd7003ad", bundle.lifetime);
  }

  setdevdvarifuninitialized(@ "hash_8e0e41d9572ba691", 0);
  setdevdvarifuninitialized(@ "hash_91f047e0dec87b64", 0);
  setdevdvarifuninitialized(@ "hash_fd16625ce7800c7e", 0);
  setdevdvarifuninitialized(@ "hash_a6581cfd5a4bf464", 1);
  setdevdvarifuninitialized(@ "hash_a5394f50be0dd2cf", 2);

  level function_d029f84fc08948be();
  level function_6866db861ac3911c();
  level function_1cf50b689d874cab();
  level function_67b3c8209aee7fd0();
  level function_67f9bf209b3afb75();
  level function_e46c604fe3e0c63a();
}

function function_d029f84fc08948be() {
  bundle = level.streakglobals.streakbundles["pac_sentry"];
  level.tanksettings = [];
  level.tanksettings["remote_tank"] = spawnStruct();

  if(isDefined(bundle)) {
    level.tanksettings["remote_tank"].timeout = bundle.lifetime;
    level.tanksettings["remote_tank"].maxhealth = bundle.maxhealth;
  } else {
    level.tanksettings["remote_tank"].timeout = 60;
    level.tanksettings["remote_tank"].maxhealth = 3000;
  }

  level.tanksettings["remote_tank"].hitstokill = 10;
  level.tanksettings["remote_tank"].streakname = "pac_sentry";
  level.tanksettings["remote_tank"].modelbase = "veh9_mil_lnd_whotel_v2_composite_mp";
  level.tanksettings["remote_tank"].bodymodel = "veh9_mil_lnd_whotel_v2_body_mp";
  level.tanksettings["remote_tank"].turretmodel = "veh9_mil_lnd_whotel_v2_turret_mp";
  level.tanksettings["remote_tank"].weaponinfo = "pac_sentry_turret_mp";
  level.tanksettings["remote_tank"].vehicleinfo = "veh_pac_sentry_amphibious_mp";
  level.tanksettings["remote_tank"].sentrymodeon = "sentry";
  level.tanksettings["remote_tank"].sentrymodeoff = "sentry_offline";
  level.tanksettings["remote_tank"].burstmin = 20;
  level.tanksettings["remote_tank"].burstmax = 120;
  level.tanksettings["remote_tank"].pausemin = 0.15;
  level.tanksettings["remote_tank"].pausemax = 0.35;
  level.tanksettings["remote_tank"].lockstrength = 6;
  level.tanksettings["remote_tank"].spinuptime = 0.65;
  level.tanksettings["remote_tank"].overheattime = 8;
  level.tanksettings["remote_tank"].cooldowntime = 0.3;
  level.tanksettings["remote_tank"].stringcannotplace = &"KILLSTREAKS_HINT_CANNOT_CALL_IN";
  level.tanksettings["remote_tank"].scorepopup = "destroyed_pac_sentry";
  level.tanksettings["remote_tank"].vodestroyed = "destroyed_pac_sentry";
  level.tanksettings["remote_tank"].destroyedsplash = "callout_destroyed_pac_sentry";
  level.tanksettings["remote_tank"].premoddamagefunc = &function_944f35a106cf0b72;
  level.tanksettings["remote_tank"].postmoddamagefunc = &function_75ab8f8d5f7aff1d;
  level.tanksettings["remote_tank"].deathfunc = &function_c2a6845f0336b0f1;
  level.incomingallremotetanks = 0;

  foreach(teamname in level.teamnamelist) {
    level.incomingremotetanks[teamname] = 0;
  }

  level.remotetanks = [];
  level function_94c2e83dcb13ec31();
  registervisibilityomnvarforkillstreak("pac_sentry", "third_person_hud_on", 11);
  registervisibilityomnvarforkillstreak("pac_sentry", "first_person_hud_on", 12);
  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_setclearancecheckminradius("pac_sentry", 32);
}

function function_6866db861ac3911c() {}

function function_1cf50b689d874cab() {}

function function_94c2e83dcb13ec31() {
  minedata = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("pac_sentry", 1);
  minedata.frontextents = 32;
  minedata.backextents = 32;
  minedata.leftextents = 22;
  minedata.rightextents = 22;
  minedata.bottomextents = 10;
  minedata.distancetobottom = 50;
  vehicledata = scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328("pac_sentry");
  vehicledata.occupancy = spawnStruct();
  vehicledata.occupancy.exitdirections = ["left", "right", "back", "front"];
  vehicledata.occupancy.exitoffsets = [(-5, 0, 55), (5, 0, 55), (-35, 0, 45), (29, 0, 55)];
  vehicledata.occupancy.exittopcastoffset = 45;
  vehicledata.occupancy.exitextents["left"] = 28;
  vehicledata.occupancy.exitextents["right"] = 28;
  vehicledata.occupancy.exitextents["back"] = 45;
  vehicledata.occupancy.exitextents["front"] = 45;
  vehicledata.occupancy.exitextents["top"] = 40;
  vehicledata.occupancy.exitextents["bottom"] = 0;
}

function function_67b3c8209aee7fd0() {
  game["dialog"]["pac_sentry" + "_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["pac_sentry" + "_timeout"] = "killstreak_remote_operator" + "_timeout";
  game["dialog"]["pac_sentry" + "_destroyed"] = "killstreak_remote_operator" + "_crash";
  game["dialog"]["pac_sentry" + "_sentry"] = "killstreak_remote_operator" + "_confirm_sentry_mode";
}

function function_67f9bf209b3afb75() {}

function function_e46c604fe3e0c63a() {}

function weapongivenremotetank(streakinfo) {
  return true;
}

function deployweapontaken(streakinfo) {
  self notify("finished_deploy_weapon");
}

function tryuseremotetank() {
  streakinfo = createstreakinfo("pac_sentry", self);
  return tryuseremotetankfromstruct(streakinfo);
}

function tryuseremotetankfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("using_remote");
  var_75d0da8e536bc6e1 = function_e6904a8315db4476(streakinfo);

  if(!istrue(var_75d0da8e536bc6e1)) {
    decrementfauxvehiclecount();
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  var_f79327d5641a9504 = function_8dc34405adaf04fe(streakinfo);
  level.incomingallremotetanks--;

  if(level.teambased) {
    level.incomingremotetanks[self.team]--;
  }

  if(!istrue(var_f79327d5641a9504)) {
    decrementfauxvehiclecount();
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  result = starttankdropoff(streakinfo);
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(!istrue(result)) {
    decrementfauxvehiclecount();
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/NOT_ENOUGH_SPACE");
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  return true;
}

function function_e6904a8315db4476(streakinfo) {
  incrementfauxvehiclecount();

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    return false;
  }

  var_4440147083abaf0a = 1;

  if(currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount + var_4440147083abaf0a >= maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    return false;
  }

  level.incomingallremotetanks++;
  var_3c73b886cee8419d = 2;

  if(islargemap()) {
    var_3c73b886cee8419d = 4;
  }

  if(level.remotetanks.size >= var_3c73b886cee8419d || level.remotetanks.size + level.incomingallremotetanks > var_3c73b886cee8419d) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    level.incomingallremotetanks--;
    return false;
  }

  if(level.teambased) {
    var_deb1e3597303a7e6 = 1;

    if(islargemap()) {
      var_deb1e3597303a7e6 = 2;
    }

    level.incomingremotetanks[self.team]++;

    if(getnumactivekillstreakperteam(self.team, level.remotetanks) + level.incomingremotetanks[self.team] > var_deb1e3597303a7e6) {
      level.incomingallremotetanks--;
      level.incomingremotetanks[self.team]--;
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/MAX_FRIENDLY_WHEELSON");
      return false;
    }
  } else if(level.remotetanks.size > 0) {
    foreach(tank in level.remotetanks) {
      if(isDefined(tank.owner) && tank.owner == self) {
        level.incomingallremotetanks--;
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS/MAX_FRIENDLY_WHEELSON");
        return false;
      }
    }
  }

  if(level.gameended) {
    return false;
  }

  return true;
}

function function_8dc34405adaf04fe(streakinfo) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  deployweaponobj = makeweapon("ks_remote_device_mp");
  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, &weapongivenremotetank, undefined, undefined, &deployweapontaken);

  if(!istrue(deployresult)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  return true;
}

function starttankdropoff(streakinfo) {
  if(scripts\cp_mp\utility\player_utility::function_f8789f15330de751(self)) {
    return false;
  }

  position = function_8acee201d15f4c71(100);

  if(!isDefined(position)) {
    return false;
  }

  debugspawns = getdvarint(@ "hash_fd16625ce7800c7e", 0);

  if(debugspawns) {
    return false;
  }

  _freezecontrols(1);
  val::set("tankDropOff", "fire", 0);
  tank = createtank("remote_tank", self, streakinfo, position);
  decrementfauxvehiclecount();

  if(!isDefined(tank)) {
    _freezecontrols(0);
    val::reset_all("tankDropOff");
    return false;
  }

  val::reset_all("tankDropOff");
  thread function_cfd4851e4ca5b834(tank);

  if(function_b276be88d495440b()) {
    tank.var_aa4804cc1bc59e93 = 1;
  }

  playkillstreakoperatordialog("pac_sentry", "pac_sentry" + "_use", 1);
  utility::trycall(level.matchdata_logkillstreakevent, "pac_sentry", self.origin);
  thread teamplayercardsplash("used_pac_sentry", self);
  return true;
}

function createtank(tanktype, owner, streakinfo, spawnloc) {
  var_a84cfd847dc1f677 = level.tanksettings[tanktype];
  bundle = level.streakglobals.streakbundles["pac_sentry"];

  if(isDefined(streakinfo.mpstreaksysteminfo) && isDefined(streakinfo) && isDefined(bundle) && isDefined(streakinfo.mpstreaksysteminfo.blueprintindex)) {
    var_a84cfd847dc1f677 = function_b0f0e3d826fdb35(bundle, var_a84cfd847dc1f677, streakinfo.mpstreaksysteminfo.blueprintindex);
  }

  modelbase = var_a84cfd847dc1f677.modelbase;
  vehicletype = var_a84cfd847dc1f677.vehicleinfo;
  var_c5012e0b9ada53ca = getdvarint(@ "hash_a6581cfd5a4bf464", 1);

  if(var_c5012e0b9ada53ca == 0) {
    modelbase = var_a84cfd847dc1f677.bodymodel;
    vehicletype = "<dev string:x2a>";
  }

  tankvehicletype = getdvarint(@ "hash_a5394f50be0dd2cf", 2);

  if(tankvehicletype == 1) {
    vehicletype = "<dev string:x48>";
  } else if(tankvehicletype == 0) {
    vehicletype = "<dev string:x63>";
  }

  angles = owner.angles;
  spawndata = spawnStruct();
  spawndata.origin = spawnloc;
  spawndata.angles = angles;
  spawndata.modelname = modelbase;
  spawndata.targetname = tanktype;
  spawndata.vehicletype = vehicletype;
  spawndata.owner = owner;
  spawndata.cannotbesuspended = 1;
  faildata = spawnStruct();
  remotetank = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, faildata);

  if(!isDefined(remotetank)) {
    return undefined;
  }

  modifiedlifetime = getdvarint(@ "hash_d429fa03fd7003ad", var_a84cfd847dc1f677.timeout);

  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    modifiedlifetime = 9999;
  }

  remotetank.team = owner.team;
  remotetank.teamfriendlyto = owner.team;
  remotetank.owner = owner;
  remotetank.playerfriendlyto = owner;
  remotetank.streakinfo = streakinfo;
  remotetank.tanktype = tanktype;
  remotetank.config = var_a84cfd847dc1f677;
  remotetank.maxhealth = var_a84cfd847dc1f677.maxhealth;
  remotetank.health = var_a84cfd847dc1f677.maxhealth;
  remotetank.currenthealth = var_a84cfd847dc1f677.maxhealth;
  remotetank.lifetime = modifiedlifetime;
  remotetank.modeltype = var_c5012e0b9ada53ca;
  remotetank setotherent(owner);
  remotetank setvehicleteam(remotetank.team);
  level thread function_ee93617532d8a679(remotetank, owner, &function_4334ace787c46d9e);
  remotetank.maxspeedforward = remotetank vehicle_gettopspeedforward();
  remotetank.maxspeedreverse = remotetank vehicle_gettopspeedreverse();

  if(issharedfuncdefined("remoteTank", "attachXRays")) {
    remotetank = [[getsharedfunc("remoteTank", "attachXRays")]](remotetank);
  }

  killcament = spawn("script_model", remotetank gettagorigin("tag_aim"));
  killcament.angles = remotetank gettagangles("tag_aim");
  killcament linkTo(remotetank, "tag_aim", (-5, 0, 0), (0, 0, 0));
  killcament setscriptmoverkillcam("turret");
  remotetank.killcament = killcament;
  remotetank scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", owner);
  remotetank function_de3e4e392c558d37(streakinfo.streakname);
  setlockedoncallback(remotetank, &function_7fa9ed782d7c0734);
  setlockedonremovedcallback(remotetank, &function_13a9b220f9377bba);
  remotetank vehicle_damage_setCanDamage(0);
  remotetank function_a5a593f3ab4f7077(bundle, owner, owner.team, remotetank.lifetime);
  remotetank thread function_371a76c203bdc938();
  remotetank thread function_7f192a2a47cf2a7d();
  remotetank thread function_da556e71229fa017();
  remotetank thread function_1dcee2ab6d1348c2();
  remotetank thread function_2461578b0348aa35();
  remotetank.childoutlineents = [remotetank];

  if(remotetank.modeltype == 0) {
    var_6ec4c83e2ded9d38 = remotetank gettagorigin("tag_turret");
    mgturret = spawnturret("misc_turret", var_6ec4c83e2ded9d38, var_a84cfd847dc1f677.weaponinfo, 0);
    mgturret linkTo(remotetank, "tag_turret", (0, 0, 0), (0, 0, 0));
    mgturret setModel(var_a84cfd847dc1f677.turretmodel);
    mgturret.owner = owner;
    mgturret.angles = remotetank.angles;
    mgturret.tank = remotetank;
    mgturret.overheated = 0;
    mgturret.streakinfo = streakinfo;
    mgturret disableplayeruseforallplayers();
    mgturret setdefaultdroppitch(0);
    mgturret setmode(var_a84cfd847dc1f677.sentrymodeoff);
    mgturret setotherent(owner);
    mgturret setturretowner(owner);
    mgturret setturretteam(owner.team);
    remotetank.mgturret = mgturret;
    remotetank.childoutlineents[remotetank.childoutlineents.size] = mgturret;
  }

  remotetank thread function_a46005e27c92c2ca();
  remotetank thread function_4048c2ca00c4690();
  remotetank thread function_cba0065c10ac9099();
  lightstate = "daytime";

  if(level.mapname == "mp_jup_grandprix_pm_2" || isnightmap()) {
    lightstate = "nighttime";
  }

  remotetank setscriptablepartstate("lights", lightstate, 0);
  scripts\mp\outofbounds::registerentforoob(remotetank, "killstreak");
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(remotetank, owner, owner.team);
  level.remotetanks[level.remotetanks.size] = remotetank;
  remotetank addtoactivekillstreaklist(streakinfo.streakname, "Killstreak_Ground", owner, 0, 1, 60);
  remotetank.deletefunc = &function_4334ace787c46d9e;
  level notify("matchrecording_small_ground_vehicle", remotetank);
  return remotetank;
}

function function_b0f0e3d826fdb35(bundle, var_a84cfd847dc1f677, blueprintindex) {
  genericblueprintname = undefined;

  if(isDefined(bundle.genericblueprintlist.blueprints) && bundle.genericblueprintlist.blueprints.size > 0 && blueprintindex > 0) {
    genericblueprintname = bundle.genericblueprintlist.blueprints[blueprintindex - 1].genericblueprint;
  } else if(isDefined(bundle.genericblueprintlist.blueprint_default)) {
    genericblueprintname = bundle.genericblueprintlist.blueprint_default;
  }

  bodymodel = function_29e16a88682086b2(genericblueprintname, #"xmodel", "bodyModel");
  turretmodel = function_29e16a88682086b2(genericblueprintname, #"xmodel", "turretModel");
  compositemodel = function_29e16a88682086b2(genericblueprintname, #"xmodel", "xcompositeModel");
  var_a84cfd847dc1f677.bodymodel = bodymodel;
  var_a84cfd847dc1f677.turretmodel = turretmodel;
  var_a84cfd847dc1f677.modelbase = compositemodel;
  return var_a84cfd847dc1f677;
}

function function_de3e4e392c558d37(streakname) {
  killstreakvehicle = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = undefined;
  destroyedsplash = "callout_destroyed_" + streakname;
  var_8dfc256103cce53e = &function_89445073f3e86e5c;
  var_191284e2e2837328 = &function_e2797fdb403c45e0;
  premoddamagecallback = &function_944f35a106cf0b72;
  postmoddamagecallback = &function_75ab8f8d5f7aff1d;
  deathcallback = &function_c2a6845f0336b0f1;
  killstreak_setupvehicledamagefunctionality(streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  function_cfc5e3633ef950fd(1, 2750, &function_30214d9ff0a7ec22);
  function_cfc5e3633ef950fd(2, 1500, &function_d0fc0ddcbaeef567);
  function_cfc5e3633ef950fd(3, 500, &function_b89384926b7b6217);
}

function function_89445073f3e86e5c(streakname) {
  config = level.tanksettings[self.tanktype];

  if(issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, config.hitstokill);
  }
}

function function_e2797fdb403c45e0(streakname) {
  weaponname = "thermite_bolt_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 18;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "thermite_xmike109_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 25;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "semtex_bolt_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 7;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "semtex_xmike109_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 8;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "c4_mp";
  weaponhitsperattack = 5;
  weaponhitstokill = undefined;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }
}

function function_7fa9ed782d7c0734() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

function function_13a9b220f9377bba() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

function function_cfd4851e4ca5b834(remotetank) {
  level endon("game_ended");
  self endon("disconnect");
  self disablephysicaldepthoffieldscripting();
  self.restoreangles = self getplayerangles();
  remotetank vehicle_damage_setCanDamage(1);
  data = spawnStruct();
  data.deathoverridecallback = &function_f49e3a7cfdb07f52;
  remotetank thread scripts\mp\movers::handle_moving_platforms(data);
  remotetank setotherent(self);

  if(remotetank.modeltype == 0) {
    remotetank setentityowner(self);
  }

  remotetank.driver = self;
  remotetank.ispiloted = 1;
  self unlink();

  if(isDefined(remotetank.empcount) && remotetank.empcount > 0) {
    _freezelookcontrols(1);
  } else if(remotetank.modeltype == 0) {
    self controlslinkTo(remotetank);
    self remotecontrolturret(remotetank.mgturret);
  } else {
    if(remotetank scripts\cp_mp\emp_debuff::is_empd()) {
      function_db443c859c55e450(1);
    }

    remotetank vehicle_turnengineon();
    self usevehicle(remotetank, 0);
  }

  remotetank.controlslinked = 1;
  self painvisionoff();
  killstreak_savenvgstate();
  viewstate = 1;
  var_a6f4657e2f8d1d39 = "third_person_hud_on";

  if(isDefined(self.previousremotetankviewstate)) {
    viewstate = self.previousremotetankviewstate;

    if(var_a6f4657e2f8d1d39 == 2) {
      var_a6f4657e2f8d1d39 = "first_person_hud_on";
    }
  }

  _setvisibiilityomnvarforkillstreak(remotetank.streakinfo.streakname, var_a6f4657e2f8d1d39);
  self setclientomnvar("ui_pac_sentry_controls", viewstate);
  self setclientomnvar("ui_pac_sentry_speed", 0);
  self setclientomnvar("ui_killstreak_health", remotetank.health / remotetank.maxhealth);
  self setclientomnvar("ui_killstreak_damage_state", 0);
  _stopshellshock();
  val::set("remoteTank", "shellshock", 0);
  scripts\mp\outofbounds::registerentforoob(remotetank, "killstreak");
  remotetank thread function_6f3f7278c3e229d7();
  val::set("remoteTank_spawn", "player_for_spawn_logic", 0);
  scripts\mp\spawnlogic::addspawnviewer(remotetank);
  remotetank scripts\cp_mp\emp_debuff::set_start_emp_callback(&function_766f7c743d266217);
  remotetank scripts\cp_mp\emp_debuff::set_clear_emp_callback(&function_a05d4cd1fe21c586);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    remotetank[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_766f7c743d266217);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    remotetank[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_8c02e338af14541c);
  }

  remotetank scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_f149e9383f183cf0);
  remotetank scripts\cp_mp\equipment\haywire::function_aa823a31304ed981(&function_5c67fa91fe5b79);
  remotetank callsharedfunc("escort", "registerEscortCollisionCallback", &function_ec5cf58c50eedc47);
  _freezecontrols(0);
}

function function_2461578b0348aa35() {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");

  while(true) {
    wait 1;
    angle = scripts\engine\math::anglebetweenvectorsunit((0, 0, 1), anglestoup(self.angles));

    if(angle > 90) {
      self vehicle_teleport(self.origin + (0, 0, 10), (0, 0, 1));
    }
  }
}

function function_944f35a106cf0b72(data) {
  damage = data.damage;
  attacker = data.attacker;
  return true;
}

function function_75ab8f8d5f7aff1d(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;

  if(isDefined(self.owner) && self.owner isusingremote()) {
    if(isexplosivedamagemod(type)) {
      if(ceil(damage / self.maxhealth) >= 0.33) {
        self.owner earthquakeforplayer(0.25, 0.2, self.origin, 150);
        self.owner playrumbleonpositionforclient("damage_heavy", self.owner getEye());
      }
    } else {
      self.owner earthquakeforplayer(0.15, 0.15, self.origin, 150);
      self.owner playrumbleonpositionforclient("damage_light", self.owner getEye());
    }
  }

  self.currenthealth -= damage;
  killstreak_updatedamagestate(self.currenthealth);
  return true;
}

function function_30214d9ff0a7ec22() {
  self setscriptablepartstate("body_damage_light", "on", 0);
}

function function_d0fc0ddcbaeef567() {
  self setscriptablepartstate("body_damage_medium", "on", 0);
}

function function_b89384926b7b6217() {
  self setscriptablepartstate("body_damage_heavy", "on", 0);
  self setscriptablepartstate("turret_damage", "on", 0);
}

function function_c2a6845f0336b0f1(data) {
  self.killedbyweapon = data.objweapon;
  playkillstreakoperatordialog("pac_sentry", "pac_sentry" + "_destroyed", 1);
  thread function_4334ace787c46d9e();
  return false;
}

function function_f49e3a7cfdb07f52(data) {
  thread function_4334ace787c46d9e();
}

function function_371a76c203bdc938() {
  self endon("death");
  level endon("game_ended");
  function_cee9be98157cd644();
  playkillstreakoperatordialog("pac_sentry", "pac_sentry" + "_timeout", 1);
  thread function_4334ace787c46d9e();
}

function function_cee9be98157cd644() {
  self endon("killstreakExit");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.owner endon("team_kill_punish");
  level endon("game_ended");
  self.owner setclientomnvar("ui_killstreak_countdown", 100);
  timeelapsed = 0;
  timeoutduration = self.lifetime;

  while(timeelapsed < timeoutduration) {
    timepercent = (timeoutduration - timeelapsed) / timeoutduration;
    timepercent = int(ceil(clamp(timepercent, 0, 1) * 100));

    if(istrue(self.ispiloted)) {
      self.owner setclientomnvar("ui_killstreak_countdown", timepercent);
    }

    timeelapsed += level.framedurationseconds;
    waitframe();
  }
}

function function_7f192a2a47cf2a7d() {
  self endon("death");
  level waittill_any_2("start_game_ended", "game_ended");
  thread function_4334ace787c46d9e();
}

function function_4334ace787c46d9e(attacker, wasdestroyed) {
  var_a84cfd847dc1f677 = level.tanksettings[self.tanktype];

  if(istrue(self.destroyed)) {
    return;
  } else {
    self.destroyed = 1;
  }

  self notify("death");
  self.controlslinked = undefined;

  if(self.modeltype == 0) {
    self.mgturret setturretowner(undefined);
    self.mgturret notify("kill_turret");
    self.mgturret notify("death");
    self.mgturret setmode(var_a84cfd847dc1f677.sentrymodeoff);
  }

  level callback::callback("killstreak_finish_use", {
    #streakinfo: self.streakinfo
  });

  if(!isDefined(attacker)) {
    attacker = self.owner;
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  self.health = 0;
  vehicle_damage_setCanDamage(0);
  scripts\cp_mp\emp_debuff::clear_emp(1);
  scripts\cp_mp\emp_debuff::allow_emp(0);

  if(isDefined(self.owner.empscramblelevels) && isDefined(self.owner.empscramblelevels[5])) {
    self.owner thread scripts\cp_mp\emp_debuff::stop_emp_scramble(5);
  }

  scripts\mp\outofbounds::clearoob(self, 1);
  self.streakinfo.expiredbydeath = istrue(wasdestroyed);
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);

  if(isDefined(self.driver)) {
    self.driver thread function_fd5a2ca6a710c2c8(self);
  }

  self playSound("veh_ks_wheelson_explode");
  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  decrementfauxvehiclecount();

  if(self.modeltype == 0) {
    if(isDefined(self.mgturret)) {
      self.mgturret delete();
    }
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  level.remotetanks = array_remove(level.remotetanks, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function function_fd5a2ca6a710c2c8(tank) {
  self endon("disconnect");
  var_a84cfd847dc1f677 = level.tanksettings[tank.tanktype];
  tank function_13a9b220f9377bba();

  if(isDefined(tank.empcount) && tank.empcount > 0) {
    _freezelookcontrols(0);
  }

  tank setotherent(undefined);
  tank.driver = undefined;
  tank.ispiloted = undefined;

  if(tank.modeltype == 0) {
    tank setentityowner(undefined);
    self controlsunlink();
    self remotecontrolturretoff(tank.mgturret);
  } else {
    tank function_db443c859c55e450(0);
    tank notify("driver_exited");
    self leavevehicle(0);
  }

  _setvisibiilityomnvarforkillstreak(tank.streakinfo.streakname, "off");
  self setclientomnvar("ui_pac_sentry_controls", 0);

  if(isusingremote()) {
    tank.streakinfo notify("killstreak_finished_with_deploy_weapon");
  }

  self painvisionon();
  killstreak_restorenvgstate();
  val::reset_all("remoteTank_spawn");
  scripts\mp\spawnlogic::removespawnviewer(tank);

  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    _stopshellshock();
    val::reset_all("remoteTank");
    level thread restorekillstreakplayerangles(self);
  }
}

function function_717645ad31e6b064() {
  self endon("death");

  while(true) {
    self.mgturret waittill("missile_fire", projectile);
    projectile.owner = self.owner;
    projectile.streakinfo = self.streakinfo;
    explosionent = spawn("script_model", projectile.origin);
    explosionent setModel("ks_pac_sentry_mp");
    explosionent.angles = projectile.angles;
    explosionent.team = self.team;
    explosionent.owner = self.owner;
    explosionent.streakinfo = self.streakinfo;
    explosionent setentityowner(self.owner);
    explosionent dontinterpolate();
    self.streakinfo.shots_fired++;
    function_93c80ddc3857d00d(projectile, explosionent);
  }
}

function function_93c80ddc3857d00d(var_ee356ed81b5cb7f4, explosionent) {
  projforward = anglesToForward(var_ee356ed81b5cb7f4.angles);
  startpos = var_ee356ed81b5cb7f4.origin;
  endpos = startpos + projforward * 22500;
  ignorelist = [var_ee356ed81b5cb7f4, explosionent, self.owner];
  contentlist = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0, 0, 0);
  spheretrace = scripts\engine\trace::sphere_trace_get_all_results(startpos, endpos, 60, ignorelist, contentlist);
  foundtarget = 0;

  if(isDefined(spheretrace[0])) {
    for(i = 0; i < spheretrace.size - 1; i++) {
      potentialtarget = spheretrace[i]["entity"];
      entityhitpos = spheretrace[i]["position"];
      burstpos = spheretrace[i]["shape_position"];

      if(isDefined(potentialtarget)) {
        if(level.teambased) {
          if(potentialtarget.team == explosionent.team) {
            continue;
          }
        }

        if(!ray_trace_passed(burstpos, entityhitpos, explosionent)) {
          continue;
        }
      }

      foundtarget = 1;
      traveltime = distance(startpos, burstpos) / 7500;
      var_ee356ed81b5cb7f4 thread function_21526388ce8cfe7c(entityhitpos, burstpos, traveltime, explosionent, self);
      break;
    }
  }

  if(!istrue(foundtarget)) {
    if(isDefined(explosionent)) {
      explosionent delete();
    }
  }
}

function function_21526388ce8cfe7c(entityhitpos, burstpos, traveltime, explosionent, tank) {
  level endon("game_ended");

  if(isDefined(self)) {
    self delete();
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(traveltime);
  explosionent.origin = burstpos;
  explosionent setscriptablepartstate("airburst", "airExpl");

  if(issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[getsharedfunc("spawn", "addSpawnDangerZone")]](burstpos, 100, 100, explosionent.team, 1, explosionent.owner, 1);
  }

  explosionent thread function_a2d262a682ad5e0();

  var_4117f5f8086a687e = getdvarint(@ "hash_91f047e0dec87b64", 0);

  if(var_4117f5f8086a687e) {
    explosionent thread function_257b6f1cf0249339(entityhitpos, tank);
  }
}

function function_1dcee2ab6d1348c2() {
  level endon("game_ended");
  var_a84cfd847dc1f677 = level.tanksettings[self.tanktype];
  updaterate = level.framedurationseconds;
  holdtime = ter_op(ismagellanmode(), 0.01, 0.25);
  self.autosentry = 0;
  hinticon = undefined;

  if(ismagellanmode()) {
    hinticon = "hud_icon_killstreak_wheelson";
  }

  function_e68434bdb941ed1e(self.streakinfo.streakname, self.owner, &"KILLSTREAKS_HINTS/REMOTE_TANK_SENTRY_OFF", undefined, hinticon);

  if(isDefined(self.useobj)) {
    self.useobj setuseholdduration(250);
  }

  while(isDefined(self)) {
    if(!istrue(self.autosentry)) {
      timeused = 0;

      while(isDefined(self) && isDefined(self.owner) && self.owner useButtonPressed()) {
        timeused += updaterate;

        if(!istrue(self.autosentry)) {
          self.owner setclientomnvar("ui_exit_progress", timeused / holdtime);
        }

        if(timeused >= holdtime) {
          function_66cd16d1ea616b67();
          break;
        }

        wait updaterate;
      }

      if(isDefined(self) && isDefined(self.owner) && !istrue(self.autosentry)) {
        self.owner setclientomnvar("ui_exit_progress", 0);
      }
    } else {
      if(isDefined(self.useobj)) {
        self.useobj waittill("trigger", player);
      }

      if(!istrue(self.owner.ksempd)) {
        function_bd237957848037c8();
      }
    }

    waitframe();
  }
}

function function_44208c5a6449e697(target) {
  if(!isDefined(target)) {
    return 0;
  }

  if(isPlayer(target)) {
    if(isDefined(self) && isDefined(target.team) && isDefined(self.ignoredteams) && array_contains(self.ignoredteams, target.team)) {
      return 0;
    }

    if(!target scripts\cp_mp\utility\player_utility::_isalive() || target.sessionstate != "playing") {
      return 0;
    }

    if(istrue(target.notarget)) {
      return 0;
    }

    if(target == self.owner) {
      return 0;
    }

    if(!isDefined(target.pers["team"])) {
      return 0;
    }

    if(target.pers["team"] == "spectator") {
      return 0;
    }

    if(level.teambased) {
      if(target.pers["team"] == self.team) {
        return 0;
      }
    }

    if(issharedfuncdefined("perk", "hasPerk")) {
      if(target[[getsharedfunc("perk", "hasPerk")]]("specialty_blindeye")) {
        return 0;
      }
    }

    if(isDefined(target.team) && isDefined(self.ignoredteams) && array_contains(self.ignoredteams, target.team)) {
      return 0;
    }
  } else if(isagent(target)) {
    if(!isalive(target)) {
      return 0;
    }

    if(isDefined(target.agent_type) && issubstr(target.agent_type, "civilian")) {
      return 0;
    }

    teamtocheck = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(target, "team");

    if(!isDefined(teamtocheck)) {
      teamtocheck = target.team;
    }

    if(level.teambased) {
      if(isDefined(teamtocheck) && teamtocheck == self.team) {
        return 0;
      }
    }
  }

  return self vehicle_canturrettargetpoint(target gettagorigin("j_mainroot"), 1, self);
}

function function_d8ff9ab17cba9862() {
  bundle = level.streakglobals.streakbundles["pac_sentry"];
  closesttarget = undefined;
  closestdistsq = undefined;
  var_c81c8e185fc6d4eb = undefined;

  if(isDefined(bundle)) {
    var_c81c8e185fc6d4eb = utility::function_2d7fd59d039fa69b(self.origin, bundle.var_7a91dfa9031fe491);
  } else {
    var_c81c8e185fc6d4eb = utility::function_2d7fd59d039fa69b(self.origin, 4096);
  }

  foreach(target in var_c81c8e185fc6d4eb) {
    if(!function_44208c5a6449e697(target)) {
      continue;
    }

    distsq = distancesquared(target.origin, self.origin);

    if(!isDefined(closesttarget) || distsq < closestdistsq) {
      closesttarget = target;
      closestdistsq = distsq;
    }
  }

  self.currentenemy = closesttarget;
}

function function_b1ccab9347662a31() {
  self endon("death");
  self endon("entering_control");
  self.owner endon("disconnect");
  level endon("game_ended");
  scanside = 0;

  while(true) {
    if(istrue(self.var_158f2fb396c0cccb)) {
      waitframe();
      continue;
    }

    oldenemy = self.currentenemy;
    function_d8ff9ab17cba9862();

    if(isDefined(self.currentenemy)) {
      self setturrettargetEnt(self.currentenemy, self.currentenemy gettagorigin("j_mainroot") - self.currentenemy.origin);

      while(function_44208c5a6449e697(self.currentenemy) && !function_bb61346fda4278e5(self, self.currentenemy, "j_mainroot", 5)) {
        waitframe();
      }

      if(function_44208c5a6449e697(self.currentenemy)) {
        var_a84cfd847dc1f677 = level.tanksettings[self.tanktype];
        firetime = weaponfiretime(var_a84cfd847dc1f677.weaponinfo);
        minshots = var_a84cfd847dc1f677.burstmin;
        maxshots = var_a84cfd847dc1f677.burstmax;
        minpause = var_a84cfd847dc1f677.pausemin;
        maxpause = var_a84cfd847dc1f677.pausemax;
        numshots = randomintrange(minshots, maxshots + 1);
        function_416e1c2f79fce693(var_a84cfd847dc1f677);

        while(function_44208c5a6449e697(self.currentenemy) && numshots > 0) {
          self fireweapon();
          numshots--;
          self.streakinfo.shots_fired++;
          wait firetime;
        }

        wait randomfloatrange(minpause, maxpause);
      }

      continue;
    }

    function_6add0f629e59f222();
    scanyaw = randomfloatrange(-5 + 180 * scanside, 5 + 180 * scanside);
    scanside++;
    scanside %= 2;
    targetangles = (0, scanyaw, 0);
    targetvec = anglesToForward(targetangles);
    start = self.origin + (0, 0, 16);
    end = start + 1000 * targetvec;
    self setturrettargetvec(end);
    waittill_any_timeout_1(2, "turret_on_target");
    wait 0.25;
  }
}

function function_416e1c2f79fce693(var_a84cfd847dc1f677) {
  self endon("death");
  spinuptime = var_a84cfd847dc1f677.spinuptime;
  self laseron();
  thread scripts\cp_mp\killstreaks\sentry_gun::sentry_targetlocksound();
  self setvehweaponspinning(1);
  self.turretspinning = 1;

  while(function_44208c5a6449e697(self.currentenemy) && spinuptime > 0) {
    spinuptime -= 0.05;
    wait 0.05;
  }
}

function function_6add0f629e59f222() {
  if(istrue(self.turretspinning)) {
    self laseroff();
    self setvehweaponspinning(0);
    self.turretspinning = undefined;
  }
}

function function_66cd16d1ea616b67() {
  self endon("death");
  self.owner endon("disconnect");

  if(istrue(self.destroyed)) {
    return;
  }

  var_a84cfd847dc1f677 = level.tanksettings[self.tanktype];
  childthread function_79479ff61f57b90b();
  self.owner function_fd5a2ca6a710c2c8(self);
  self notify("leaving_control");
  playkillstreakoperatordialog("pac_sentry", "pac_sentry" + "_sentry", 1);
  function_3c864cee6ca51e89(1);

  if(self.modeltype == 0) {
    self.mgturret setmode(var_a84cfd847dc1f677.sentrymodeon);
    self.mgturret thread scripts\cp_mp\killstreaks\sentry_gun::sentry_attacktargets(var_a84cfd847dc1f677);

    self.mgturret thread scripts\cp_mp\killstreaks\sentry_gun::function_c057f52574c94670(var_a84cfd847dc1f677);
  } else {
    thread function_b1ccab9347662a31();
  }

  self.autosentry = 1;
  self setscriptablepartstate("auto_spin_sfx", "on");
  function_86ff095469a70cd2();
}

function function_79479ff61f57b90b() {
  level endon("game_ended");
  function_3f55c1fb553a4775(self.owner, self.useobj);
  wait 0.1;
  function_17576a4cdcd447a7(self.owner);
}

function function_bd237957848037c8() {
  self.owner endon("disconnect");
  self.owner notify("using_remote");
  var_a84cfd847dc1f677 = level.tanksettings[self.tanktype];
  streakinfo = self.streakinfo;
  deployweaponobj = makeweapon("ks_remote_device_mp");
  deployresult = self.owner scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(self.streakinfo, &weapongivenremotetank, undefined, undefined, &deployweapontaken, undefined, undefined, undefined, 0, 1);

  if(!istrue(deployresult)) {
    self.owner scripts\mp\hud_message::showerrormessage("KILLSTREAKS/CANNOT_RECONNECT");
    return;
  }

  if(!isDefined(self) || istrue(self.destroyed)) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return;
  }

  if(self.modeltype == 0) {
    self.mgturret setmode(var_a84cfd847dc1f677.sentrymodeoff);
    self.mgturret notify("kill_turret");
  } else {
    self notify("entering_control");
    self clearturrettarget();
  }

  function_3c864cee6ca51e89(0);
  self setscriptablepartstate("auto_spin_sfx", "off");
  self.owner function_cfd4851e4ca5b834(self);
  self.autosentry = 0;
  function_a91ebb0263d086f3();
}

function function_3c864cee6ca51e89(var_93c07017fa762d2b) {
  drivingstate = self function_962a6476fe1c33ee();

  if(isDefined(drivingstate)) {
    if(drivingstate == "veh_amphibious_water") {
      if(istrue(var_93c07017fa762d2b)) {
        self function_481c2a63f2ba3332(-1, 0, 0);
      } else {
        self function_481c2a63f2ba3332(0);
      }
    } else {
      self vehphys_parkingbrake(var_93c07017fa762d2b);
    }
  }

  if(istrue(var_93c07017fa762d2b)) {
    function_c5b2e0bb2a8d5f68();
  }
}

function function_257b6f1cf0249339(entityhitpos, tank) {
  self endon("<dev string:x7f>");
  tank endon("<dev string:x7f>");
  var_7de35540c250a948 = 120;
  tankorigin = tank.origin;
  var_2d7a2733c414e4df = self.origin;
  sphere(var_2d7a2733c414e4df, 60, (1, 1, 1), 0, var_7de35540c250a948);
  sphere(var_2d7a2733c414e4df, 100, (1, 0, 0), 0, var_7de35540c250a948);
  line(tank.mgturret gettagorigin("<dev string:x88>"), var_2d7a2733c414e4df, (1, 0, 0), 1, 0, var_7de35540c250a948);
  anglesforward = vectorNormalize(var_2d7a2733c414e4df - tank.mgturret gettagorigin("<dev string:x88>"));
  framecounter = 0;

  while(framecounter < var_7de35540c250a948) {
    print3d(tankorigin + anglesforward * 200, "<dev string:x95>" + var_2d7a2733c414e4df, (1, 0, 0));
    print3d(tankorigin + anglesforward * 200 - (0, 0, 20), "<dev string:xa7>" + distance2d(var_2d7a2733c414e4df, entityhitpos));
    waitframe();
    framecounter += 1;
  }
}

function function_a2d262a682ad5e0() {
  self endon("death");
  self.dying = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  self delete();
}

function function_da556e71229fa017() {
  self endon("death");
  var_2bdc3e3680df74eb = 0;

  while(true) {
    currentvehiclespeed = self vehicle_getspeed();
    var_46c9a177682cfdd2 = currentvehiclespeed * 1.60934;

    if(currentvehiclespeed > 1 && !istrue(var_2bdc3e3680df74eb)) {
      var_2bdc3e3680df74eb = 1;
      self setscriptablepartstate("dust", "on");
    } else if(currentvehiclespeed <= 1 && istrue(var_2bdc3e3680df74eb)) {
      var_2bdc3e3680df74eb = 0;
      self setscriptablepartstate("dust", "off");
    }

    self.owner setclientomnvar("ui_pac_sentry_speed", int(var_46c9a177682cfdd2));
    waitframe();
  }
}

function function_cba0065c10ac9099() {
  self endon("death");
  level endon("game_ended");
  thread function_c495d6715028bedf();

  while(true) {
    if(istrue(self.autosentry)) {
      waitframe();
      continue;
    }

    driver = self.owner;

    if(isDefined(driver)) {
      movementinput = driver getnormalizedmovement();
      var_58724d69ca657b30 = abs(movementinput[0]);

      if(var_58724d69ca657b30 >= 0.15) {
        function_cf71eb6e0611096c();
      } else {
        function_c5b2e0bb2a8d5f68();
      }
    } else {
      function_c5b2e0bb2a8d5f68();
    }

    waitframe();
  }
}

function function_cf71eb6e0611096c() {
  self endon("death");
  self endon("wheelson_stop_engine");
  level endon("game_ended");

  if(istrue(self.engine_audio_active)) {
    return;
  }

  self.engine_audio_active = 1;
  self playsoundonmovingent("veh_wheelson_engine_start");
  wait 0.5;
  self playLoopSound("veh_wheelson_engine_lp");
}

function function_c5b2e0bb2a8d5f68(fromdeath) {
  if(istrue(fromdeath)) {
    self notify("wheelson_stop_engine");
    self.engine_audio_active = undefined;
    self stoploopsound("veh_wheelson_engine_lp");
    return;
  }

  if(istrue(self.engine_audio_active)) {
    self notify("wheelson_stop_engine");
    self endon("wheelson_stop_engine");
    self.engine_audio_active = undefined;
    self playsoundonmovingent("veh_wheelson_engine_stop");
    wait 0.5;

    if(isDefined(self)) {
      self stoploopsound("veh_wheelson_engine_lp");
    }
  }
}

function function_c495d6715028bedf() {
  self endon("death");
  level waittill("game_ended");
  thread function_c5b2e0bb2a8d5f68();
}

function function_766f7c743d266217(data) {
  if(!isDefined(self.owner)) {
    return;
  }

  if(isDefined(data.attacker)) {
    data.attacker thread scripts\mp\utility\points::doscoreevent(#"hash_e5ce77cfae268ab3", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  }

  self.var_158f2fb396c0cccb = 1;

  if(istrue(self.ispiloted)) {
    function_db443c859c55e450(1);
  }

  self vehicle_turnengineoff();
  self.useobj disableplayeruse(self.owner);

  if(isPlayer(self.owner)) {
    self.owner thread scripts\cp_mp\emp_debuff::play_emp_scramble(5);
  }
}

function function_db443c859c55e450(isenabled) {
  var_e796719320e13e49 = self hascomponent("p2p");

  if(!var_e796719320e13e49) {
    self.owner _freezelookcontrols(isenabled);
    self.owner _freezecontrols(isenabled);
  }

  function_e4adb8dfbd1e62dd(isenabled, var_e796719320e13e49);
}

function function_e4adb8dfbd1e62dd(isdisable, var_e796719320e13e49) {
  if(isdisable) {
    if(var_e796719320e13e49) {
      self setconfigvalue("p2p", "pause", 1);
    } else {
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("movementDisabled", self.owner, scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd());
      self function_64d8ae560c3ec9b6(1);
      self.veh_throttle = 0;
    }

    return;
  }

  if(var_e796719320e13e49) {
    self setconfigvalue("p2p", "resume", 1);
    return;
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("movementDisabled", self.owner, scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd());
  self function_64d8ae560c3ec9b6(0);
}

function function_a05d4cd1fe21c586(isdeath) {
  if(!isDefined(self.owner)) {
    return;
  }

  self vehicle_turnengineon();
  self.var_158f2fb396c0cccb = 0;

  if(!isdeath && istrue(self.ispiloted)) {
    function_db443c859c55e450(0);
  }

  self.owner thread scripts\cp_mp\emp_debuff::stop_emp_scramble(5);
  self.useobj enableplayeruse(self.owner);
}

function function_8c02e338af14541c(data) {
  if(!isDefined(self.owner)) {
    return;
  }

  self vehicle_turnengineon();
  self.var_158f2fb396c0cccb = 0;

  if(istrue(self.ispiloted)) {
    function_db443c859c55e450(0);
  }

  self.owner thread scripts\cp_mp\emp_debuff::stop_emp_scramble(5);
  self.useobj enableplayeruse(self.owner);
}

function function_f149e9383f183cf0(data) {
  wheelson = data.victim;

  if(!isDefined(wheelson)) {
    return;
  }

  if(!isDefined(wheelson.owner)) {
    return;
  }

  if(istrue(wheelson.ishaywire)) {
    return;
  }

  wheelson.ishaywire = 1;
  wheelson thread function_e6cbf8131b64e6db();
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("shockStickAttached", wheelson.owner, wheelson.vehiclename);
  wheelson vehicle_settopspeedforward(wheelson.maxspeedforward / 3);
  wheelson vehicle_settopspeedreverse(wheelson.maxspeedreverse / 3);
}

function function_5c67fa91fe5b79(data) {
  wheelson = data.victim;

  if(!isDefined(wheelson)) {
    return;
  }

  if(!isDefined(wheelson.owner)) {
    return;
  }

  wheelson vehicle_settopspeedforward(wheelson.maxspeedforward);
  wheelson vehicle_settopspeedreverse(wheelson.maxspeedreverse);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("shockStickAttached", wheelson.owner, wheelson.vehiclename);
  wheelson.ishaywire = 0;
}

function function_ec5cf58c50eedc47(var_9f1f082eeef5d90b) {
  function_4334ace787c46d9e();
}

function function_e6cbf8131b64e6db() {
  level endon("game_ended");
  self.owner endon("disconnect");
  var_a84cfd847dc1f677 = level.tanksettings[self.tanktype];
  firetime = weaponfiretime(var_a84cfd847dc1f677.weaponinfo);
  childthread function_4973f20495f7d1ff(firetime);
  self.var_158f2fb396c0cccb = 1;

  if(!isDefined(self.driver)) {
    self clearturrettarget();
    self.currentenemy = undefined;
  }

  msg = waittill_any_return_2("death", "haywire_cleared");
  self.var_158f2fb396c0cccb = undefined;
}

function function_4973f20495f7d1ff(firetime) {
  self endon("death");
  self endon("haywire_cleared");

  while(true) {
    self fireweapon();
    wait firetime;
  }
}

function function_6f3f7278c3e229d7() {
  self endon("death");
  self.owner endon("end_remote");
  self.owner endon("disconnect");

  while(true) {
    self.owner earthquakeforplayer(0.05, 0.05, self gettagorigin("tag_body"), 500);
    wait 0.05;
  }
}

function function_8acee201d15f4c71(spawndist) {
  result = undefined;
  startpos = self.origin;
  startang = self.angles;
  forward = anglesToForward(startang);
  right = anglestoright(startang);
  spawnposchecks = [startpos + spawndist * forward, startpos - spawndist * forward, startpos + spawndist * right, startpos - spawndist * right, startpos + 0.707 * spawndist * (forward + right), startpos + 0.707 * spawndist * (forward - right), startpos + 0.707 * spawndist * (right - forward), startpos + 0.707 * spawndist * (-1 * forward - right)];

  foreach(curpos in spawnposchecks) {
    result = function_a03fd14f53c89e53(startpos, curpos);

    if(isDefined(result)) {
      break;
    }
  }

  return result;
}

function function_a03fd14f53c89e53(startpoint, spawnpoint) {
  result = undefined;
  zoffset = (0, 0, 45);
  collisioncontents = create_contents(1, 1, 1, 1, 1, 1, 1, 0, 1);
  tracestart = startpoint + zoffset;
  traceend = spawnpoint + zoffset;
  spheretestradius = 40;
  forwardtracepassed = ray_trace_passed(tracestart, traceend, self, collisioncontents);

  if(!istrue(forwardtracepassed)) {
    return result;
  }

  groundtrace = ray_trace(traceend, traceend - (0, 0, 500), level.players, collisioncontents);

  if(isDefined(groundtrace["position"]) && groundtrace["hittype"] != "hittype_none") {
    testspawnpos = groundtrace["position"] + zoffset;
    var_2db6453133b55e73 = sphere_trace_passed(testspawnpos, testspawnpos, spheretestradius, level.players, collisioncontents);
    teamtocheck = undefined;

    if(level.teambased) {
      teamtocheck = self.team;
    }

    if(istrue(var_2db6453133b55e73) && !scripts\mp\outofbounds::ispointinoutofbounds(groundtrace["position"], teamtocheck)) {
      result = groundtrace["position"];

      debugspawns = getdvarint(@ "hash_fd16625ce7800c7e", 0);

      if(debugspawns) {
        line(tracestart, traceend, (0, 1, 0), 1, 0, 300);
        line(traceend, result, (0, 1, 0), 1, 0, 300);
        sphere(testspawnpos, spheretestradius, (0, 1, 0), 0, 300);
        self iprintlnbold("<dev string:xc1>");
      }
    } else {
      debugspawns = getdvarint(@ "hash_fd16625ce7800c7e", 0);

      if(debugspawns) {
        line(tracestart, traceend, (1, 0, 0), 1, 0, 300);
        line(traceend, testspawnpos, (1, 0, 0), 1, 0, 300);
        sphere(testspawnpos, spheretestradius, (1, 0, 0), 0, 300);
      }
    }
  }

  return result;
}

function function_a46005e27c92c2ca() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  while(true) {
    turretangles = undefined;

    if(self.modeltype == 0) {
      turretangles = self.mgturret gettagangles("tag_flash");
    } else {
      turretangles = self gettagangles("tag_flash");
    }

    var_5f1a5a32f3d81ce2 = invertangles(self.angles);
    var_d550ebe8b9a1bb32 = combineangles(var_5f1a5a32f3d81ce2, turretangles);
    var_bbb9076182480914 = var_d550ebe8b9a1bb32[1] * -1;
    self.owner setclientomnvar("ui_pac_sentry_degrees", var_bbb9076182480914);
    waitframe();
  }
}

function function_4048c2ca00c4690() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  thread function_865318fe12d890e8();

  if(!isbot(self.owner)) {
    self.owner notifyonplayercommand("toggle_view", "+togglevehcam");
  }

  viewstate = 1;
  var_a6f4657e2f8d1d39 = "third_person_hud_on";

  if(isDefined(self.owner.previousremotetankviewstate)) {
    viewstate = self.owner.previousremotetankviewstate;

    if(var_a6f4657e2f8d1d39 == 2) {
      var_a6f4657e2f8d1d39 = "first_person_hud_on";
    }
  }

  while(true) {
    self.owner waittill("toggle_view");
    viewstate++;

    if(viewstate == 2) {
      self.owner _shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
      var_a6f4657e2f8d1d39 = "first_person_hud_on";
    } else if(viewstate > 2) {
      self.owner _stopshellshock();
      viewstate = 1;
      var_a6f4657e2f8d1d39 = "third_person_hud_on";
    }

    self.owner.previousremotetankviewstate = viewstate;
    self.owner _setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, var_a6f4657e2f8d1d39);
    self.owner setclientomnvar("ui_pac_sentry_controls", viewstate);
  }
}

function function_865318fe12d890e8() {
  tankowner = self.owner;
  tankowner endon("disconnect");
  level endon("game_ended");
  tankowner notify("tank_reset_viewState");
  tankowner endon("tank_reset_viewState");
  tankowner waittill("death");

  if(isDefined(tankowner.previousremotetankviewstate)) {
    tankowner.previousremotetankviewstate = undefined;
  }
}

function function_8cba478f80e8ac72(remotetank) {
  remotetank setentityhudoutlinedata(3, remotetank.team);
  return remotetank;
}

function function_876be54dd49f69a9(data) {
  self endon("death");
  self.owner endon("disconnect");
  self notify("remoteTanke_dronegun_emp_start");
  self endon("remoteTanke_dronegun_emp_start");

  if(!isDefined(self.owner)) {
    return;
  }

  if(isDefined(data.attacker)) {
    data.attacker thread scripts\mp\utility\points::doscoreevent(#"emped_killstreak");
  }

  self.var_158f2fb396c0cccb = 1;
  self.var_195cf5a953ae9265 = 1;

  if(istrue(self.ispiloted)) {
    function_db443c859c55e450(1);

    if(isPlayer(self.owner)) {
      thread scripts\cp_mp\emp_debuff::function_9d31a370d60f86da(self.owner, 4);
    }
  }

  self vehicle_turnengineoff();
  childthread function_6f35c67c1d78b1d5();
  wait 4;
  self vehicle_turnengineon();
  self.var_158f2fb396c0cccb = 0;

  if(istrue(self.ispiloted)) {
    function_db443c859c55e450(0);
  }

  self.var_195cf5a953ae9265 = undefined;
  self notify("dronegun_emp_cleared");
}

function function_6f35c67c1d78b1d5() {
  self endon("death");
  self endon("dronegun_emp_cleared");
  self.owner endon("disconnect");
  self waittill("driver_exited");
  self notify("dronegun_emp_cleared");
}