/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\remotetank.gsc
*************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("pac_sentry", &tryuseremotetankfromstruct);
  level.tanksettings = [];
  level.tanksettings["remote_tank"] = spawnStruct();
  level.tanksettings["remote_tank"].timeout = 60;
  level.tanksettings["remote_tank"].maxhealth = 3000;
  level.tanksettings["remote_tank"].hitstokill = 10;
  level.tanksettings["remote_tank"].streakname = "pac_sentry";
  level.tanksettings["remote_tank"].modelbase = "veh8_mil_lnd_whotel";
  level.tanksettings["remote_tank"].modelbasealt = "veh8_mil_lnd_whotel_east";
  level.tanksettings["remote_tank"].modeldestroyed = "veh8_mil_lnd_whotel";
  level.tanksettings["remote_tank"].mgturretmodelbase = "veh8_mil_lnd_whotel_turret";
  level.tanksettings["remote_tank"].mgturretmodelbasealt = "veh8_mil_lnd_whotel_turret_east";
  level.tanksettings["remote_tank"].mgturretinfo = "pac_sentry_turret_mp";
  level.tanksettings["remote_tank"].sentrymodeon = "manual";
  level.tanksettings["remote_tank"].sentrymodeoff = "sentry_offline";
  level.tanksettings["remote_tank"].vehicleinfo = "veh_pac_sentry_mp";
  level.tanksettings["remote_tank"].stringcannotplace = &"KILLSTREAKS_HINT_CANNOT_CALL_IN";
  level.tanksettings["remote_tank"].scorepopup = "destroyed_pac_sentry";
  level.tanksettings["remote_tank"].vodestroyed = "destroyed_pac_sentry";
  level.tanksettings["remote_tank"].destroyedsplash = "callout_destroyed_pac_sentry";
  level.tanksettings["remote_tank"].premoddamagefunc = undefined;
  level.tanksettings["remote_tank"].postmoddamagefunc = &tank_modifydamageresponse;
  level.tanksettings["remote_tank"].deathfunc = &tank_destroycallback;
  level._effect["remote_tank_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_wheelson_death_exp.vfx");
  level._effect["remote_tank_explode_alt"] = loadfx("vfx/iw8_mp/killstreak/vfx_wheelson_east_death_exp.vfx");
  level._effect["remote_tank_crate_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_wheelson_exp_imp.vfx");
  level.remote_tank_armor_bulletdamage = 0.5;
  initmines();
  init_pac_sentry_vo();
  level.incomingallremotetanks = 0;
  level.incomingremotetanks["allies"] = 0;
  level.incomingremotetanks["axis"] = 0;
  level.remotetanks = [];

  foreach(var_1 in level.tanksettings) {
    if(isDefined(var_1.hitstokill)) {
      scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var_1.streakname, var_1.hitstokill);
    }
  }

  scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_setclearancecheckminradius("pac_sentry", 32);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_bolt_mp", 1, "pac_sentry");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("pac_sentry", 18, "thermite_bolt_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_bolt_mp", 1, "pac_sentry");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("pac_sentry", 7, "semtex_bolt_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_xmike109_mp", 1, "pac_sentry");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("pac_sentry", 25, "thermite_xmike109_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_xmike109_mp", 1, "pac_sentry");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("pac_sentry", 8, "semtex_xmike109_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_aalpha12_mp", 1, "pac_sentry");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("pac_sentry", 15, "semtex_aalpha12_mp");
  }

  scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle("c4_mp_p", 5, "pac_sentry");
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("pac_sentry", "third_person_hud_on", 11);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("pac_sentry", "first_person_hud_on", 12);
}

function initmines() {
  var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("pac_sentry", 1);
  var_0.frontextents = 32;
  var_0.backextents = 32;
  var_0.leftextents = 22;
  var_0.rightextents = 22;
  var_0.bottomextents = 10;
  var_0.distancetobottom = 20;
}

function init_pac_sentry_vo() {
  game["dialog"]["pac_sentry_missile_lock"] = "pac_sentry_missile_lock";
}

function weapongivenremotetank(var_0) {
  return true;
}

function deployweapontaken(var_0) {
  self notify("finished_deploy_weapon");
}

function tryuseremotetank() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("pac_sentry", self);
  return tryuseremotetankfromstruct(var_0);
}

function tryuseremotetankfromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      return false;
    }
  }

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "use_killstreak_dronesentry");
  var_1 = getcompleteweaponname("ks_remote_device_mp");
  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, &weapongivenremotetank, undefined, undefined, &deployweapontaken);

  if(!istrue(var_2)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    scripts\mp\hud_message::showerrormessage(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return false;
  }

  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  var_3 = 1;

  if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var_3 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    var_0 notify("killstreak_finished_with_deploy_weapon");
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  level.incomingallremotetanks++;
  var_4 = 2;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var_4 = 4;
  }

  if(level.remotetanks.size >= var_4 || level.remotetanks.size + level.incomingallremotetanks > var_4) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    level.incomingallremotetanks--;
    var_0 notify("killstreak_finished_with_deploy_weapon");
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  if(level.teambased) {
    var_5 = 1;

    if(scripts\cp_mp\utility\game_utility::islargemap()) {
      var_5 = 2;
    }

    level.incomingremotetanks[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.remotetanks) + level.incomingremotetanks[self.team] > var_5) {
      level.incomingallremotetanks--;
      level.incomingremotetanks[self.team]--;
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/MAX_FRIENDLY_WHEELSON");
      var_0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  if(level.gameended) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  var_6 = starttankdropoff(var_0);
  level.incomingallremotetanks--;

  if(level.teambased) {
    level.incomingremotetanks[self.team]--;
  }

  if(!istrue(var_6)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/NOT_ENOUGH_SPACE");
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    return false;
  }

  return true;
}

function getpathstart(var_0, var_1) {
  var_2 = 100;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4) * -1 * var_3;
  var_5 += ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

function getpathend(var_0, var_1) {
  var_2 = 150;
  var_3 = 15000;
  var_4 = (0, var_1, 0);
  var_5 = var_0 + anglesToForward(var_4 + (0, 90, 0)) * var_3;
  var_5 += ((randomfloat(2) - 1) * var_2, (randomfloat(2) - 1) * var_2, 0);
  return var_5;
}

function starttankdropoff(var_0) {
  self disablephysicaldepthoffieldscripting();
  var_1 = tank_findsafespawn(100);

  if(!isDefined(var_1)) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  var_3 = getdvarint("scr_pac_sentry_instaspawn", 1);
  var_4 = undefined;
  var_5 = undefined;

  if(!var_3) {
    var_6 = scripts\engine\utility::drop_to_ground(var_1, 50, -200, (0, 0, 1));
    var_6 += (0, 0, 1);
    var_5 = spawn("script_model", var_6);
    var_5 setModel("offhand_wm_grenade_smoke");
    var_5.angles = (0, 90, 90);
    var_4 = spawn("script_model", var_6);
    var_4 setModel("ks_crate_marker_mp");
    var_4 setscriptablepartstate("smoke", "on", 0);
    var_5 playSound("smoke_grenade_expl_atmo");
  }

  self.restoreangles = self getplayerangles();
  scripts\mp\utility\player::_freezecontrols(1);
  scripts\common\utility::allow_fire(0);
  var_3 = getdvarint("scr_pac_sentry_instaspawn", 0);

  if(!var_3) {
    var_7 = self.angles[1];
    var_8 = var_1 * (1, 1, 0) + (0, 0, 850);
    var_9 = getpathstart(var_8, var_7);
    var_10 = getpathend(var_8, var_7);
    var_8 += anglesToForward((0, var_7, 0)) * -50;
    var_11 = createdropoffheli(self, var_9, var_8);
    var_11.droptype = "pac_sentry";
    var_11 setvehgoalpos(var_8, 1);
    thread tank_finishdropoffsequence(var_11, self, var_1, var_10, var_0, var_4);
  } else {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    var_12 = createtank("remote_tank", self, var_0, var_1, undefined, var_3);

    if(!isDefined(var_12)) {
      scripts\mp\utility\killstreak::decrementfauxvehiclecount();
      scripts\mp\utility\player::_freezecontrols(0);
      scripts\common\utility::allow_fire(1);
      return false;
    }

    scripts\common\utility::allow_fire(1);
    thread startusingtank(var_12, var_3);
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_0.streakname, 1);
  scripts\common\utility::ref_13E0A(level.ref_11B2A, "pac_sentry", self.origin);
  thread scripts\mp\hud_util::teamplayercardsplash("used_pac_sentry", self);
  return true;
}

function createdropoffheli(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_1);
  var_4 = "veh_airdrop_mp";
  var_5 = spawnhelicopter(var_0, var_1, var_3, var_4, "veh8_mil_air_lbravo");

  if(!isDefined(var_5)) {
    return;
  }

  var_5 playLoopSound("veh_apache_killstreak_amb_lr");
  var_5.maxhealth = 500;
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5.isairdrop = 1;
  var_5 setmaxpitchroll(15, 15);
  var_5 vehicle_setspeed(250, 175);
  var_5.helitype = "airdrop";
  var_5.boxmodel = spawn("script_model", var_5.origin - (0, 0, 100));
  var_5.boxmodel setModel("veh8_mil_lnd_whotel_crate");
  var_5.boxmodel.angles = var_5.angles;
  var_5.boxmodel linkTo(var_5);
  var_5.intromodel = spawn("script_model", var_5.boxmodel.origin);
  var_5.intromodel setModel("veh8_mil_lnd_whotel");
  var_5.intromodel.angles = var_5.boxmodel.angles;
  var_5.intromodel.owner = var_5.owner;
  var_5.intromodel linkTo(var_5.boxmodel);
  var_5.turretmodel = spawn("script_model", var_5.intromodel gettagorigin("tag_turret"));
  var_5.turretmodel setModel("veh8_mil_lnd_whotel_turret");
  var_5.turretmodel.angles = var_5.intromodel.angles;
  var_5.turretmodel setotherent(var_5.owner);
  var_5.turretmodel linkTo(var_5.intromodel);
  var_5.owner playerlinkweaponviewtodelta(var_5.turretmodel, "tag_player", 1, 0, 0, 0, 0, 1);
  var_5.owner playerlinkedsetviewznear(0);
  var_5.intromodel scriptmodelplayanim("mp_wheelson_drop_intro");
  var_5.owner setclientomnvar("ui_pac_sentry_controls", 1);
  var_5.owner setclientomnvar("ui_pac_sentry_speed", 0);
  var_5.owner setclientomnvar("ui_killstreak_health", 3000);
  var_5 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("pac_sentry");
  var_5 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var_5.helitype, "Killstreak_Air", var_0, 0, 1, 100);
  thread tank_handlehelidamage();
  return var_5;
}

function createtank(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = level.tanksettings[var_0];
  var_7 = var_1.angles;

  if(isDefined(var_4)) {
    var_7 = var_4.angles;
  }

  var_8 = spawnStruct();
  var_8.origin = var_3;
  var_8.angles = var_7;
  var_8.modelname = var_6.modelbase;
  var_9 = scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_1);

  if(var_9) {
    var_8.modelname = var_6.modelbasealt;
  }

  var_8.targetname = var_0;
  var_8.vehicletype = var_6.vehicleinfo;
  var_8.owner = var_1;
  var_8.cannotbesuspended = 1;
  var_10 = spawnStruct();
  var_11 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_8, var_10);

  if(!isDefined(var_11)) {
    return undefined;
  }

  var_12 = getdvarint("scr_pac_sentry_lifetime", var_6.timeout);
  var_11.team = var_1.team;
  var_11.owner = var_1;
  var_11.streakinfo = var_2;
  var_11.tanktype = var_0;
  var_11.config = var_6;
  var_11.maxhealth = var_6.maxhealth;
  var_11.health = var_11.maxhealth;
  var_11.lifetime = var_12;
  var_11.superfaction = var_9;
  var_11.currentdamagestate = 0;
  var_11.objweapon = getcompleteweaponname(var_6.mgturretinfo);
  var_11 setotherent(var_1);
  var_11 setvehicleteam(var_11.team);
  var_11 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", var_1);
  var_11 scripts\mp\utility\killstreak::killstreak_make_vehicle(var_2.streakname, var_6.scorepopup, var_6.vodestroyed, undefined, var_6.destroyedsplash);
  var_11 scripts\mp\utility\killstreak::killstreak_set_pre_mod_damage_callback(var_2.streakname, var_6.premoddamagefunc);
  var_11 scripts\mp\utility\killstreak::killstreak_set_post_mod_damage_callback(var_2.streakname, var_6.postmoddamagefunc);
  var_11 scripts\mp\utility\killstreak::killstreak_set_death_callback(var_2.streakname, var_6.deathfunc);
  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(var_11, &tank_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(var_11, &tank_lockedonremovedcallback);
  var_11.useobj = spawn("script_model", var_11 gettagorigin("tag_body"));
  var_11.useobj linkTo(var_11, "tag_body");
  var_14 = var_11 gettagorigin("tag_turret");
  var_15 = var_6.mgturretmodelbase;

  if(var_9) {
    var_15 = var_6.mgturretmodelbasealt;
  }

  var_16 = spawnturret("misc_turret", var_14, var_6.mgturretinfo, 0);
  var_16 linkTo(var_11, "tag_turret", (0, 0, 0), (0, 0, 0));
  var_16 setModel(var_15);
  var_16.owner = var_1;
  var_16.angles = var_11.angles;
  var_16.tank = var_11;
  var_16 makeusable();
  var_16 setdefaultdroppitch(0);
  var_16 setmode("manual");
  var_16 setotherent(var_1);
  var_11 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  var_11.mgturret = var_16;

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_11.mgturret setscriptablepartstate("lights", "on");
  }

  thread tank_watchfortimeoutdisowned();
  thread ref_13A50();
  thread ref_13A51();
  thread tank_handleairburst();
  thread tank_handlewheeldustfx();
  thread tank_updatehudchassisangles();
  thread tank_updatehudviewstate();
  thread wheelson_enginesfx();
  var_11.childoutlineents = [var_11, var_16];

  if(istrue(var_5)) {
    var_17 = 1;
    var_18 = "third_person_hud_on";

    if(isDefined(var_1.previousremotetankviewstate)) {
      var_17 = var_1.previousremotetankviewstate;

      if(var_18 == 2) {
        var_18 = "first_person_hud_on";
      }
    }

    var_1 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var_11.streakinfo.streakname, var_18);
    var_1 setclientomnvar("ui_pac_sentry_controls", var_17);
    var_1 setclientomnvar("ui_pac_sentry_speed", 0);
    var_1 setclientomnvar("ui_killstreak_health", 3000);
    scripts\mp\outofbounds::registerentforoob(var_11, "killstreak");
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var_11, var_1, var_1.team);
  level.remotetanks[level.remotetanks.size] = var_11;
  var_11 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var_2.streakname, "Killstreak_Ground", var_1, 0, 1, 60);
  level notify("matchrecording_small_ground_vehicle", var_11);
  return var_11;
}

function tank_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("pac_sentry_missile_lock");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

function tank_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

function tank_finishdropoffsequence(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self waittill("goal");
  self setyawspeed(40, 20, 20, 0.3);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  self notify("drop_crate");
  self.boxmodel unlink();
  self.boxmodel moveTo(var_1, 1.5, 1);
  self.intromodel scriptmodelplayanim("mp_wheelson_drop_release");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self.intromodel scriptmodelplayanim("mp_wheelson_drop_land");
  earthquake(0.3, 0.1, self.intromodel.origin, 400);
  playrumbleonposition("artillery_rumble", self.intromodel.origin);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.7);
  var_6 = self.turretmodel gettagorigin("tag_player");
  var_7 = self.turretmodel.angles;
  var_8 = var_6 - anglesToForward(var_7) * 100;
  var_9 = var_7;
  playFX(scripts\engine\utility::getfx("remote_tank_crate_explode"), self.intromodel.origin);
  earthquake(0.3, 0.1, self.intromodel.origin, 400);
  playrumbleonposition("damage_heavy", self.intromodel.origin);
  self.boxmodel delete();
  self.intromodel delete();
  self.turretmodel delete();
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var_10 = createtank("remote_tank", var_0, var_3, var_1, self);

  if(!isDefined(var_10)) {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    var_0 scripts\mp\utility\player::_freezecontrols(0);
    var_0 scripts\common\utility::allow_fire(1);
    return 0;
  }

  tank_playercameratransition(var_10, var_6, var_7, var_8, var_9);
  var_0 scripts\common\utility::allow_fire(1);
  thread startusingtank(var_0);
  self setvehgoalpos(var_2, 1);
  self.leaving = 1;
  self waittill("goal");
  self delete();
  var_4 delete();
  var_5 delete();
}

function tank_playercameratransition(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self.owner unlink();
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_player");
  var_4.owner = self.owner;
  var_4.angles = var_1;
  self.owner playerlinkweaponviewtodelta(var_4, "tag_player", 1, 0, 0, 0, 0, 1);
  self.owner playerlinkedsetviewznear(0);
  self.owner visionsetkillstreakforplayer("tac_ops_slamzoom", 0.2);
  var_2 += (0, 0, 20);
  var_3 = vectortoangles(var_0 - var_2);
  var_4 moveTo(var_2, 0.5);
  var_4 rotateTo(var_3, 0.5);
  thread tank_startfadetransition();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  self.owner visionsetkillstreakforplayer("", 0.2);
  self.owner unlink();
  var_4 delete();
}

function tank_startfadetransition() {
  self endon("disconnect");
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.5);
  wait 0.5;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
}

function tank_turrethandleuse(var_0) {
  self endon("death");
  tank_disableturretuseforenemies(var_0);

  for(;;) {
    var_0 waittill("trigger", var_1);
    var_1 setplayerangles(var_0.angles);
    var_1 playerlinkTo(self, "tag_playerride");
    thread tank_watchstopuseturret(var_1, var_0);
  }
}

function tank_disableturretuseforenemies(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2.team) && var_2.team == self.team) {
      continue;
    }

    var_2 disableplayeruse();
  }

  thread tank_disableturretforfutureenemies(var_0);
}

function tank_disableturretforfutureenemies(var_0) {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_1);

    if(isDefined(var_1.team) && var_1.team == self.team) {
      var_0 enableplayeruse(var_1);
      continue;
    }

    var_0 disableplayeruse(var_1);
  }
}

function tank_watchstopuseturret(var_0, var_1) {
  level endon("game_ended");
  self endon("death");

  while(isDefined(var_0) && self isusingturret()) {
    waitframe();
  }

  var_2 = tank_findsafedetach(var_1);
  self unlink();
  self dontinterpolate();
  self.origin = var_2;
  self.angles = var_0.angles;
  self notify("done_using_turret");
}

function tank_findsafedetach(var_0) {
  var_1 = undefined;
  var_2 = anglesToForward(var_0.angles);
  var_3 = anglestoright(var_0.angles);
  var_4 = var_0.origin + var_2 * 100;
  var_5 = var_0.origin - var_2 * 100;
  var_6 = var_0.origin + var_3 * 100;
  var_7 = var_0.origin - var_3 * 100;
  var_8 = [var_5, var_6, var_7, var_4];

  foreach(var_10 in var_8) {
    if(capsuletracepassed(var_10, 40, 80, var_0, 0, 1)) {
      var_1 = var_10;
      break;
    }
  }

  return var_1;
}

function startusingtank(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  var_2 = spawnStruct();
  var_2.playdeathfx = 1;
  var_2.deathoverridecallback = &tank_override_moving_platform_death;
  var_0 thread scripts\mp\movers::handle_moving_platforms(var_2);
  var_0 setotherent(self);
  var_0 setentityowner(self);
  var_0.driver = self;

  if(istrue(var_1)) {
    self unlink();
  }

  self controlslinkTo(var_0);
  self remotecontrolturret(var_0.mgturret);
  self painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(var_0.lifetime * 1000));
  self setclientomnvar("ui_killstreak_health", var_0.health / var_0.maxhealth);
  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  scripts\common\utility::allow_shellshock(0);
  scripts\mp\outofbounds::registerentforoob(var_0, "killstreak");
  thread tank_earthquake();
  var_0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit("death");
  scripts\mp\utility\player::enableplayerforspawnlogic(0, "remoteTank");
  scripts\mp\spawnlogic::addspawnviewer(var_0);
  var_0 scripts\cp_mp\emp_debuff::set_start_emp_callback(&tank_empstarted);
  var_0 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&tank_empcleared);
  scripts\mp\utility\player::_freezecontrols(0);
}

function tank_handlehelidamage() {
  self endon("death");
  scripts\mp\damage::monitordamage(self.maxhealth, "", &tank_handlehelideathdamage, &tank_modifyhelidamage, 1);
}

function tank_modifyhelidamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var_1, var_2, var_3, var_6, self.maxhealth, 1, 1, 1);
  return var_6;
}

function tank_handlehelideathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(isDefined(self.intromodel)) {
    self.intromodel delete();
  }

  self notify("death");
}

function tank_modifydamageresponse(var_0) {
  thread tank_modifydamagestate(var_0);
  var_1 = var_0.damage;
  var_2 = var_0.meansofdeath;

  if(isDefined(self.owner) && self.owner scripts\mp\utility\player::isusingremote()) {
    if(isexplosivedamagemod(var_2)) {
      if(ceil(var_1 / self.maxhealth) >= 0.33) {
        self.owner earthquakeforplayer(0.25, 0.2, self.mgturret.origin, 150);
        self.owner playrumbleonpositionforclient("damage_heavy", self.owner getEye());
      }
    } else {
      self.owner earthquakeforplayer(0.15, 0.15, self.mgturret.origin, 150);
      self.owner playrumbleonpositionforclient("damage_light", self.owner getEye());
    }
  }

  return true;
}

function tank_modifydamagestate(var_0) {
  var_1 = var_0.damage;
  self.currenthealth = self.health - var_1;

  if(self.currenthealth <= int(self.maxhealth / 1.2) && self.currentdamagestate == 0) {
    self.currentdamagestate = 1;
    self setscriptablepartstate("body_damage_light", "on");
  } else if(self.currenthealth <= int(self.maxhealth / 2) && self.currentdamagestate == 1) {
    self.currentdamagestate = 2;
    self setscriptablepartstate("body_damage_medium", "on");
  } else if(self.currenthealth <= int(self.maxhealth / 3) && self.currentdamagestate == 2) {
    self.currentdamagestate = 3;
    self setscriptablepartstate("body_damage_heavy", "on");
    self.mgturret setscriptablepartstate("turret_damage", "on");
  }

  self.owner setclientomnvar("ui_killstreak_health", self.currenthealth / self.maxhealth);
  return true;
}

function tank_override_moving_platform_death(var_0) {
  thread tank_destroy();
}

function tank_watchfortimeoutdisowned() {
  self endon("death");
  level endon("game_ended");
  tank_watchfortimeoutdisownedendearly();
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("timeout_pac_sentry", 1);
  thread tank_destroy();
}

function tank_watchfortimeoutdisownedendearly() {
  self endon("killstreakExit");
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  self.owner endon("team_kill_punish");
  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(self.lifetime);
}

function ref_13A50() {
  self endon("death");
  level waittill("game_ended");
  thread tank_destroy();
}

function ref_13A51() {
  self endon("death");

  for(;;) {
    scripts\cp_mp\vehicles\vehicle::ref_14103(self);
    waitframe();
  }
}

function tank_destroy(var_0, var_1) {
  if(istrue(self.destroyed)) {
    return;
  } else {
    self.destroyed = 1;
  }

  self notify("death");
  self.mgturret notify("death");

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);
  }

  if(!isDefined(var_0)) {
    var_0 = self.owner;
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);

  if(isDefined(self.driver)) {
    thread tank_driverexit(self.driver);
  }

  self.useobj delete();
  self.health = 0;
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  self.mgturret setmode("sentry_offline");
  removefromugvlist(self getentitynumber());
  scripts\cp_mp\emp_debuff::clear_emp(1);
  scripts\cp_mp\emp_debuff::allow_emp(0);
  scripts\mp\outofbounds::clearoob(self, 1);
  self.streakinfo.onspray = istrue(var_1);
  self.owner scripts\cp_mp\utility\killstreak_utility::ref_12AA7(self.streakinfo);
  waitframe();
  self playSound("mp_killstreak_disappear");
  var_2 = level._effect["remote_tank_explode"];

  if(self.superfaction) {
    var_2 = level._effect["remote_tank_explode_alt"];
  }

  playFX(var_2, self.origin);
  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self.mgturret setscriptablepartstate("lights", "off");
  self.mgturret delete();
  level.remotetanks = scripts\engine\utility::array_remove(level.remotetanks, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function tank_destroycallback(var_0) {
  thread tank_destroy(var_0.attacker, 1);
  return false;
}

function tank_driverexit(var_0) {
  var_0 endon("disconnect");
  tank_lockedonremovedcallback();
  self.driver = undefined;
  var_0 controlsunlink();

  if(isDefined(self.mgturret)) {
    var_0 remotecontrolturretoff(self.mgturret);
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
  var_0 setclientomnvar("ui_pac_sentry_controls", 0);

  if(var_0 scripts\mp\utility\player::isusingremote()) {
    self.streakinfo notify("killstreak_finished_with_deploy_weapon");
  }

  var_0 painvisionon();
  var_0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  var_0 scripts\mp\utility\player::enableplayerforspawnlogic(1, "remoteTank");
  scripts\mp\spawnlogic::removespawnviewer(self);

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var_0 scripts\common\utility::allow_shellshock(1);
    level thread scripts\cp_mp\utility\killstreak_utility::ref_12CC6(var_0);
    return;
  }
}

function tank_riderexit(var_0, var_1) {
  var_0 unlink();
}

function tank_handleairburst() {
  self endon("death");

  for(;;) {
    self.mgturret waittill("missile_fire", var_0);
    var_0.owner = self.owner;
    var_0.streakinfo = self.streakinfo;
    var_1 = spawn("script_model", var_0.origin);
    var_1 setModel("ks_pac_sentry_mp");
    var_1.angles = var_0.angles;
    var_1.team = self.team;
    var_1.owner = self.owner;
    var_1.streakinfo = self.streakinfo;
    var_1 setentityowner(self.owner);
    var_1 dontinterpolate();
    self.streakinfo.shots_fired++;
    tank_findclosestairbursttarget(var_0, var_1);
  }
}

function tank_findclosestairbursttarget(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = var_0.origin;
  var_4 = var_3 + var_2 * 22500;
  var_5 = [var_0, var_1, self.owner];
  var_6 = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0, 0, 0);
  var_7 = scripts\engine\trace::sphere_trace_get_all_results(var_3, var_4, 60, var_5, var_6);
  var_8 = 0;

  if(isDefined(var_7[0])) {
    for(var_9 = 0; var_9 < var_7.size - 1; var_9++) {
      var_10 = var_7[var_9]["entity"];
      var_11 = var_7[var_9]["position"];
      var_12 = var_7[var_9]["shape_position"];

      if(isDefined(var_10)) {
        if(level.teambased) {
          if(var_10.team == var_1.team) {
            continue;
          }
        }

        if(!scripts\engine\trace::ray_trace_passed(var_12, var_11, var_1)) {
          continue;
        }
      }

      var_8 = 1;
      var_13 = distance(var_3, var_12) / 7500;
      thread tank_watchforairburstdetonate(var_0, var_11, var_12, var_13, var_1);
      break;
    }
  }

  if(!istrue(var_8)) {
    if(isDefined(var_1)) {
      var_1 delete();
      return;
    }

    return;
  }
}

function tank_watchforairburstdetonate(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");

  if(isDefined(self)) {
    self delete();
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  var_3.origin = var_1;
  var_3 setscriptablepartstate("airburst", "airExpl");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_1, 100, 100, var_3.team, 1, var_3.owner, 1);
  }

  thread tank_delayairburstscriptabledeath();
}

function tank_delayairburstscriptabledeath() {
  self endon("death");
  self.dying = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  self delete();
}

function tank_handlewheeldustfx() {
  self endon("death");
  var_0 = 0;

  for(;;) {
    var_1 = self vehicle_getspeed();
    var_2 = var_1 * 1.60934;

    if(var_1 > 1 && !istrue(var_0)) {
      var_0 = 1;
      self setscriptablepartstate("dust", "on");
    } else if(var_1 <= 1 && istrue(var_0)) {
      var_0 = 0;
      self setscriptablepartstate("dust", "off");
    }

    self.owner setclientomnvar("ui_pac_sentry_speed", int(var_2));
    waitframe();
  }
}

function wheelson_enginesfx() {
  self endon("death");
  level endon("game_ended");
  thread wheelson_engine_audio_game_end();

  for(;;) {
    var_0 = self.owner;

    if(isDefined(var_0)) {
      var_1 = var_0 getnormalizedmovement();
      var_2 = abs(var_1[0]);

      if(var_2 >= 0.15) {
        wheelson_start_engine_audio();
      } else {
        wheelson_stop_engine_audio();
      }
    } else {
      wheelson_stop_engine_audio();
    }

    waitframe();
  }
}

function wheelson_start_engine_audio() {
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

function wheelson_stop_engine_audio(var_0) {
  if(istrue(var_0)) {
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
      return;
    }

    return;
  }
}

function wheelson_engine_audio_game_end() {
  self endon("death");
  level waittill("game_ended");
  thread wheelson_stop_engine_audio();
}

function tank_empstarted(var_0) {
  if(!isDefined(self.owner)) {
    return;
  }

  self.owner controlsunlink();
  thread scripts\cp_mp\emp_debuff::ref_1241A(self.owner, 5);
}

function tank_empcleared(var_0) {
  if(!isDefined(self.owner)) {
    return;
  }

  if(!istrue(var_0)) {
    self.owner controlslinkTo(self);
    return;
  }
}

function tank_watchfiring(var_0) {
  self endon("disconnect");
  self endon("end_remote");
  var_0 endon("death");
  var_1 = 50;
  var_2 = var_1;
  var_3 = weaponfiretime(level.tanksettings[var_0.tanktype].mgturretinfo);

  for(;;) {
    if(var_0.mgturret isfiringvehicleturret()) {
      var_2--;

      if(var_2 <= 0) {
        var_0.mgturret turretfiredisable();
        wait 2.5;
        var_0 playSound("talon_reload");
        self playlocalsound("talon_reload_plr");
        var_2 = var_1;
        var_0.mgturret turretfireenable();
      }
    }

    wait var_3;
  }
}

function tank_earthquake() {
  self endon("death");
  self.owner endon("end_remote");
  self.owner endon("disconnect");

  for(;;) {
    self.owner earthquakeforplayer(0.05, 0.05, self gettagorigin("tag_body"), 500);
    wait 0.05;
  }
}

function addtougvlist(var_0) {
  level.ugvs[var_0] = self;
}

function removefromugvlist(var_0) {
  level.ugvs[var_0] = undefined;
}

function tank_watchridermount() {
  self endon("death");
  level endon("game_ended");
  self.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(self.owner, &"KILLSTREAKS_HINTS/PAC_SENTRY_MOUNT", 90, 90, 150, 150, 3, 1);
  tank_enableriderprompt();

  for(;;) {
    self.useobj waittill("trigger", var_0);

    if(isDefined(self.rider) && self.rider == var_0) {
      var_0 unlink();
      self.rider = undefined;
      tank_enableriderprompt();
      continue;
    }

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    if(!var_0 scripts\common\utility::is_usability_allowed()) {
      continue;
    }

    self.rider = var_0;
    var_0 playerlinkTo(self, "tag_playerride", 0.8);
    thread tank_watchriderturn(var_0, 20);
    thread tank_watchriderabandon(var_0);
    thread tank_watchriderautodismount(var_0);
    tank_disableriderprompt(var_0);
  }
}

function tank_watchriderturn(var_0, var_1) {
  var_0 endon("death_or_disconnect");
  self endon("death");
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_4 = var_0 getplayerangles();
    var_5 = var_4[1];
    var_6 = self.angles[1];

    switch (var_2) {
      case 0:
        var_7 = 90 - var_1 * 0.5;
        var_8 = angleclamp180(var_5 - var_6);

        if(abs(var_8) >= var_7) {
          var_3 = 2;
          var_2 = 1;
        }

        break;
      case 1:
        var_9 = vectordot(anglesToForward(var_4), anglestoright(self.angles));
        var_10 = -1 * var_1;

        if(var_9 > 0) {
          var_11 = angleclamp180(var_5 - var_6 + 90);

          if(var_11 < var_10) {
            var_3 = 2;
            var_2 = 2;
          } else if(var_11 > var_1) {
            var_3 = 0;
            var_2 = 0;
          }
        } else {
          var_11 = angleclamp180(var_6 - var_9 - 90);

          if(var_11 > var_2) {
            var_4 = 2;
            var_3 = 2;
          } else if(var_11 < var_11) {
            var_4 = 0;
            var_3 = 0;
          }
        }

        break;
      case 2:
        var_7 = 90 - var_2 * 0.5;
        var_11 = angleclamp180(var_6 - var_9 + 180);

        if(abs(var_11) >= var_7) {
          var_4 = 0;
          var_3 = 1;
        }

        break;
    }

    waitframe();
  }
}

function tank_watchriderabandon(var_0) {
  self endon("death");
  var_0 waittill("death_or_disconnect");
  self.rider = undefined;
  tank_enableriderprompt();
}

function tank_watchriderautodismount(var_0) {
  self waittill("death");

  if(isDefined(self.rider) && var_0 == self.rider) {
    var_0 unlink();
    return;
  }
}

function tank_enableriderprompt() {
  if(level.teambased) {
    foreach(var_1 in level.players) {
      if(var_1.team != self.team) {
        continue;
      }

      self enableplayeruse(var_1);
    }

    return;
  }
}

function tank_disableriderprompt(var_0) {
  if(level.teambased) {
    foreach(var_2 in level.players) {
      if(var_2.team != self.team) {
        continue;
      }

      if(var_2 == var_0) {
        continue;
      }

      self disableplayeruse(var_2);
    }

    return;
  }
}

function tank_findsafespawn(var_0) {
  var_1 = undefined;
  var_2 = self.origin;
  var_3 = self.angles;
  var_4 = anglesToForward(var_3);
  var_5 = anglestoright(var_3);
  var_6 = [var_2 + var_0 * var_4, var_2 - var_0 * var_4, var_2 + var_0 * var_5, var_2 - var_0 * var_5, var_2 + 0.707 * var_0 * (var_4 + var_5), var_2 + 0.707 * var_0 * (var_4 - var_5), var_2 + 0.707 * var_0 * (var_5 - var_4), var_2 + 0.707 * var_0 * (-1 * var_4 - var_5)];

  foreach(var_8 in var_6) {
    var_1 = tank_checkspawnpoint(var_2, var_8);

    if(isDefined(var_1)) {
      break;
    }
  }

  return var_1;
}

function tank_checkspawnpoint(var_0, var_1) {
  var_2 = undefined;
  var_3 = (0, 0, 45);
  var_4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 0, 1);
  var_5 = var_0 + var_3;
  var_6 = var_1 + var_3;
  var_7 = 40;
  var_8 = scripts\engine\trace::ray_trace_passed(var_5, var_6, self, var_4);

  if(!istrue(var_8)) {
    return var_2;
  }

  var_9 = scripts\engine\trace::ray_trace(var_6, var_6 - (0, 0, 500), level.players, var_4);

  if(isDefined(var_9["position"]) && var_9["hittype"] != "hittype_none") {
    var_10 = var_9["position"] + var_3;
    var_11 = scripts\engine\trace::sphere_trace_passed(var_10, var_10, var_7, level.players, var_4);
    var_12 = undefined;

    if(level.teambased) {
      var_12 = self.team;
    }

    if(istrue(var_11) && !scripts\mp\outofbounds::ispointinoutofbounds(var_9["position"], var_12)) {
      var_2 = var_9["position"];
    }
  }

  return var_2;
}

function tank_updatehudchassisangles() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_0 = self.mgturret gettagangles("tag_flash");
    var_1 = invertangles(self.angles);
    var_2 = combineangles(var_1, var_0);
    var_3 = var_2[1] * -1;
    self.owner setclientomnvar("ui_pac_sentry_degrees", var_3);
    waitframe();
  }
}

function tank_updatehudviewstate() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  thread tank_watchownerdeath();
  self.owner notifyonplayercommand("toggle_view", "+togglevehcam");
  var_0 = 1;
  var_1 = "third_person_hud_on";

  if(isDefined(self.owner.previousremotetankviewstate)) {
    var_0 = self.owner.previousremotetankviewstate;

    if(var_1 == 2) {
      var_1 = "first_person_hud_on";
    }
  }

  for(;;) {
    self.owner waittill("toggle_view");
    var_0++;

    if(var_0 == 2) {
      self.owner scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
      var_1 = "first_person_hud_on";
    } else if(var_0 > 2) {
      self.owner scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
      var_0 = 1;
      var_1 = "third_person_hud_on";
    }

    self.owner.previousremotetankviewstate = var_0;
    self.owner scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, var_1);
    self.owner setclientomnvar("ui_pac_sentry_controls", var_0);
  }
}

function tank_watchownerdeath() {
  var_0 = self.owner;
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 notify("tank_reset_viewState");
  var_0 endon("tank_reset_viewState");
  var_0 waittill("death");

  if(isDefined(var_0.previousremotetankviewstate)) {
    var_0.previousremotetankviewstate = undefined;
    return;
  }
}