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

  foreach(var1 in level.tanksettings) {
    if(isDefined(var1.hitstokill)) {
      scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var1.streakname, var1.hitstokill);
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
  var0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle("pac_sentry", 1);
  var0.frontextents = 32;
  var0.backextents = 32;
  var0.leftextents = 22;
  var0.rightextents = 22;
  var0.bottomextents = 10;
  var0.distancetobottom = 20;
}

function init_pac_sentry_vo() {
  game["dialog"]["pac_sentry_missile_lock"] = "pac_sentry_missile_lock";
}

function weapongivenremotetank(var0) {
  return true;
}

function deployweapontaken(var0) {
  self notify("finished_deploy_weapon");
}

function tryuseremotetank() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("pac_sentry", self);
  return tryuseremotetankfromstruct(var0);
}

function tryuseremotetankfromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return false;
    }
  }

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "use_killstreak_dronesentry");
  var1 = getcompleteweaponname("ks_remote_device_mp");
  var2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var0, &weapongivenremotetank, undefined, undefined, &deployweapontaken);

  if(!istrue(var2)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      var0 notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    scripts\mp\hud_message::showerrormessage(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    return false;
  }

  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  var3 = 1;

  if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var3 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    var0 notify("killstreak_finished_with_deploy_weapon");
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  level.incomingallremotetanks++;
  var4 = 2;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var4 = 4;
  }

  if(level.remotetanks.size >= var4 || level.remotetanks.size + level.incomingallremotetanks > var4) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/TOO_MANY_VEHICLES");
    level.incomingallremotetanks--;
    var0 notify("killstreak_finished_with_deploy_weapon");
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  if(level.teambased) {
    var5 = 1;

    if(scripts\cp_mp\utility\game_utility::islargemap()) {
      var5 = 2;
    }

    level.incomingremotetanks[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.remotetanks) + level.incomingremotetanks[self.team] > var5) {
      level.incomingallremotetanks--;
      level.incomingremotetanks[self.team]--;
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS/MAX_FRIENDLY_WHEELSON");
      var0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  if(level.gameended) {
    var0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  var6 = starttankdropoff(var0);
  level.incomingallremotetanks--;

  if(level.teambased) {
    level.incomingremotetanks[self.team]--;
  }

  if(!istrue(var6)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS/NOT_ENOUGH_SPACE");
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    return false;
  }

  return true;
}

function getpathstart(var0, var1) {
  var2 = 100;
  var3 = 15000;
  var4 = (0, var1, 0);
  var5 = var0 + anglesToForward(var4) * -1 * var3;
  var5 += ((randomfloat(2) - 1) * var2, (randomfloat(2) - 1) * var2, 0);
  return var5;
}

function getpathend(var0, var1) {
  var2 = 150;
  var3 = 15000;
  var4 = (0, var1, 0);
  var5 = var0 + anglesToForward(var4 + (0, 90, 0)) * var3;
  var5 += ((randomfloat(2) - 1) * var2, (randomfloat(2) - 1) * var2, 0);
  return var5;
}

function starttankdropoff(var0) {
  self disablephysicaldepthoffieldscripting();
  var1 = tank_findsafespawn(100);

  if(!isDefined(var1)) {
    var0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  var3 = getdvarint("scr_pac_sentry_instaspawn", 1);
  var4 = undefined;
  var5 = undefined;

  if(!var3) {
    var6 = scripts\engine\utility::drop_to_ground(var1, 50, -200, (0, 0, 1));
    var6 += (0, 0, 1);
    var5 = spawn("script_model", var6);
    var5 setModel("offhand_wm_grenade_smoke");
    var5.angles = (0, 90, 90);
    var4 = spawn("script_model", var6);
    var4 setModel("ks_crate_marker_mp");
    var4 setscriptablepartstate("smoke", "on", 0);
    var5 playSound("smoke_grenade_expl_atmo");
  }

  self.restoreangles = self getplayerangles();
  scripts\mp\utility\player::_freezecontrols(1);
  scripts\common\utility::allow_fire(0);
  var3 = getdvarint("scr_pac_sentry_instaspawn", 0);

  if(!var3) {
    var7 = self.angles[1];
    var8 = var1 * (1, 1, 0) + (0, 0, 850);
    var9 = getpathstart(var8, var7);
    var10 = getpathend(var8, var7);
    var8 += anglesToForward((0, var7, 0)) * -50;
    var11 = createdropoffheli(self, var9, var8);
    var11.droptype = "pac_sentry";
    var11 setvehgoalpos(var8, 1);
    thread tank_finishdropoffsequence(var11, self, var1, var10, var0, var4);
  } else {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    var12 = createtank("remote_tank", self, var0, var1, undefined, var3);

    if(!isDefined(var12)) {
      scripts\mp\utility\killstreak::decrementfauxvehiclecount();
      scripts\mp\utility\player::_freezecontrols(0);
      scripts\common\utility::allow_fire(1);
      return false;
    }

    scripts\common\utility::allow_fire(1);
    thread startusingtank(var12, var3);
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var0.streakname, 1);
  scripts\common\utility::ref_13e0a(level.ref_11b2a, "pac_sentry", self.origin);
  thread scripts\mp\hud_util::teamplayercardsplash("used_pac_sentry", self);
  return true;
}

function createdropoffheli(var0, var1, var2) {
  var3 = vectortoangles(var2 - var1);
  var4 = "veh_airdrop_mp";
  var5 = spawnhelicopter(var0, var1, var3, var4, "veh8_mil_air_lbravo");

  if(!isDefined(var5)) {
    return;
  }

  var5 playLoopSound("veh_apache_killstreak_amb_lr");
  var5.maxhealth = 500;
  var5.owner = var0;
  var5.team = var0.team;
  var5.isairdrop = 1;
  var5 setmaxpitchroll(15, 15);
  var5 vehicle_setspeed(250, 175);
  var5.helitype = "airdrop";
  var5.boxmodel = spawn("script_model", var5.origin - (0, 0, 100));
  var5.boxmodel setModel("veh8_mil_lnd_whotel_crate");
  var5.boxmodel.angles = var5.angles;
  var5.boxmodel linkTo(var5);
  var5.intromodel = spawn("script_model", var5.boxmodel.origin);
  var5.intromodel setModel("veh8_mil_lnd_whotel");
  var5.intromodel.angles = var5.boxmodel.angles;
  var5.intromodel.owner = var5.owner;
  var5.intromodel linkTo(var5.boxmodel);
  var5.turretmodel = spawn("script_model", var5.intromodel gettagorigin("tag_turret"));
  var5.turretmodel setModel("veh8_mil_lnd_whotel_turret");
  var5.turretmodel.angles = var5.intromodel.angles;
  var5.turretmodel setotherent(var5.owner);
  var5.turretmodel linkTo(var5.intromodel);
  var5.owner playerlinkweaponviewtodelta(var5.turretmodel, "tag_player", 1, 0, 0, 0, 0, 1);
  var5.owner playerlinkedsetviewznear(0);
  var5.intromodel scriptmodelplayanim("mp_wheelson_drop_intro");
  var5.owner setclientomnvar("ui_pac_sentry_controls", 1);
  var5.owner setclientomnvar("ui_pac_sentry_speed", 0);
  var5.owner setclientomnvar("ui_killstreak_health", 3000);
  var5 thread scripts\mp\killstreaks\helicopter::heli_damage_monitor("pac_sentry");
  var5 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var5.helitype, "Killstreak_Air", var0, 0, 1, 100);
  thread tank_handlehelidamage();
  return var5;
}

function createtank(var0, var1, var2, var3, var4, var5) {
  var6 = level.tanksettings[var0];
  var7 = var1.angles;

  if(isDefined(var4)) {
    var7 = var4.angles;
  }

  var8 = spawnStruct();
  var8.origin = var3;
  var8.angles = var7;
  var8.modelname = var6.modelbase;
  var9 = scripts\cp_mp\utility\player_utility::getplayersuperfaction(var1);

  if(var9) {
    var8.modelname = var6.modelbasealt;
  }

  var8.targetname = var0;
  var8.vehicletype = var6.vehicleinfo;
  var8.owner = var1;
  var8.cannotbesuspended = 1;
  var10 = spawnStruct();
  var11 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var8, var10);

  if(!isDefined(var11)) {
    return undefined;
  }

  var12 = getdvarint("scr_pac_sentry_lifetime", var6.timeout);
  var11.team = var1.team;
  var11.owner = var1;
  var11.streakinfo = var2;
  var11.tanktype = var0;
  var11.config = var6;
  var11.maxhealth = var6.maxhealth;
  var11.health = var11.maxhealth;
  var11.lifetime = var12;
  var11.superfaction = var9;
  var11.currentdamagestate = 0;
  var11.objweapon = getcompleteweaponname(var6.mgturretinfo);
  var11 setotherent(var1);
  var11 setvehicleteam(var11.team);
  var11 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", var1);
  var11 scripts\mp\utility\killstreak::killstreak_make_vehicle(var2.streakname, var6.scorepopup, var6.vodestroyed, undefined, var6.destroyedsplash);
  var11 scripts\mp\utility\killstreak::killstreak_set_pre_mod_damage_callback(var2.streakname, var6.premoddamagefunc);
  var11 scripts\mp\utility\killstreak::killstreak_set_post_mod_damage_callback(var2.streakname, var6.postmoddamagefunc);
  var11 scripts\mp\utility\killstreak::killstreak_set_death_callback(var2.streakname, var6.deathfunc);
  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(var11, &tank_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(var11, &tank_lockedonremovedcallback);
  var11.useobj = spawn("script_model", var11 gettagorigin("tag_body"));
  var11.useobj linkTo(var11, "tag_body");
  var14 = var11 gettagorigin("tag_turret");
  var15 = var6.mgturretmodelbase;

  if(var9) {
    var15 = var6.mgturretmodelbasealt;
  }

  var16 = spawnturret("misc_turret", var14, var6.mgturretinfo, 0);
  var16 linkTo(var11, "tag_turret", (0, 0, 0), (0, 0, 0));
  var16 setModel(var15);
  var16.owner = var1;
  var16.angles = var11.angles;
  var16.tank = var11;
  var16 makeusable();
  var16 setdefaultdroppitch(0);
  var16 setmode("manual");
  var16 setotherent(var1);
  var11 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  var11.mgturret = var16;

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var11.mgturret setscriptablepartstate("lights", "on");
  }

  thread tank_watchfortimeoutdisowned();
  thread ref_13a50();
  thread ref_13a51();
  thread tank_handleairburst();
  thread tank_handlewheeldustfx();
  thread tank_updatehudchassisangles();
  thread tank_updatehudviewstate();
  thread wheelson_enginesfx();
  var11.childoutlineents = [var11, var16];

  if(istrue(var5)) {
    var17 = 1;
    var18 = "third_person_hud_on";

    if(isDefined(var1.previousremotetankviewstate)) {
      var17 = var1.previousremotetankviewstate;

      if(var18 == 2) {
        var18 = "first_person_hud_on";
      }
    }

    var1 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var11.streakinfo.streakname, var18);
    var1 setclientomnvar("ui_pac_sentry_controls", var17);
    var1 setclientomnvar("ui_pac_sentry_speed", 0);
    var1 setclientomnvar("ui_killstreak_health", 3000);
    scripts\mp\outofbounds::registerentforoob(var11, "killstreak");
  }

  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(var11, var1, var1.team);
  level.remotetanks[level.remotetanks.size] = var11;
  var11 scripts\mp\utility\killstreak::addtoactivekillstreaklist(var2.streakname, "Killstreak_Ground", var1, 0, 1, 60);
  level notify("matchrecording_small_ground_vehicle", var11);
  return var11;
}

function tank_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("pac_sentry_missile_lock");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

function tank_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

function tank_finishdropoffsequence(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  self waittill("goal");
  self setyawspeed(40, 20, 20, 0.3);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  self notify("drop_crate");
  self.boxmodel unlink();
  self.boxmodel moveTo(var1, 1.5, 1);
  self.intromodel scriptmodelplayanim("mp_wheelson_drop_release");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self.intromodel scriptmodelplayanim("mp_wheelson_drop_land");
  earthquake(0.3, 0.1, self.intromodel.origin, 400);
  playrumbleonposition("artillery_rumble", self.intromodel.origin);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.7);
  var6 = self.turretmodel gettagorigin("tag_player");
  var7 = self.turretmodel.angles;
  var8 = var6 - anglesToForward(var7) * 100;
  var9 = var7;
  playFX(scripts\engine\utility::getfx("remote_tank_crate_explode"), self.intromodel.origin);
  earthquake(0.3, 0.1, self.intromodel.origin, 400);
  playrumbleonposition("damage_heavy", self.intromodel.origin);
  self.boxmodel delete();
  self.intromodel delete();
  self.turretmodel delete();
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  var10 = createtank("remote_tank", var0, var3, var1, self);

  if(!isDefined(var10)) {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
    var0 scripts\mp\utility\player::_freezecontrols(0);
    var0 scripts\common\utility::allow_fire(1);
    return 0;
  }

  tank_playercameratransition(var10, var6, var7, var8, var9);
  var0 scripts\common\utility::allow_fire(1);
  thread startusingtank(var0);
  self setvehgoalpos(var2, 1);
  self.leaving = 1;
  self waittill("goal");
  self delete();
  var4 delete();
  var5 delete();
}

function tank_playercameratransition(var0, var1, var2, var3) {
  level endon("game_ended");
  self.owner unlink();
  var4 = spawn("script_model", var0);
  var4 setModel("tag_player");
  var4.owner = self.owner;
  var4.angles = var1;
  self.owner playerlinkweaponviewtodelta(var4, "tag_player", 1, 0, 0, 0, 0, 1);
  self.owner playerlinkedsetviewznear(0);
  self.owner visionsetkillstreakforplayer("tac_ops_slamzoom", 0.2);
  var2 += (0, 0, 20);
  var3 = vectortoangles(var0 - var2);
  var4 moveTo(var2, 0.5);
  var4 rotateTo(var3, 0.5);
  thread tank_startfadetransition();
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  self.owner visionsetkillstreakforplayer("", 0.2);
  self.owner unlink();
  var4 delete();
}

function tank_startfadetransition() {
  self endon("disconnect");
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.5);
  wait 0.5;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
}

function tank_turrethandleuse(var0) {
  self endon("death");
  tank_disableturretuseforenemies(var0);

  for(;;) {
    var0 waittill("trigger", var1);
    var1 setplayerangles(var0.angles);
    var1 playerlinkTo(self, "tag_playerride");
    thread tank_watchstopuseturret(var1, var0);
  }
}

function tank_disableturretuseforenemies(var0) {
  foreach(var2 in level.players) {
    if(isDefined(var2.team) && var2.team == self.team) {
      continue;
    }

    var2 disableplayeruse();
  }

  thread tank_disableturretforfutureenemies(var0);
}

function tank_disableturretforfutureenemies(var0) {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var1);

    if(isDefined(var1.team) && var1.team == self.team) {
      var0 enableplayeruse(var1);
      continue;
    }

    var0 disableplayeruse(var1);
  }
}

function tank_watchstopuseturret(var0, var1) {
  level endon("game_ended");
  self endon("death");

  while(isDefined(var0) && self isusingturret()) {
    waitframe();
  }

  var2 = tank_findsafedetach(var1);
  self unlink();
  self dontinterpolate();
  self.origin = var2;
  self.angles = var0.angles;
  self notify("done_using_turret");
}

function tank_findsafedetach(var0) {
  var1 = undefined;
  var2 = anglesToForward(var0.angles);
  var3 = anglestoright(var0.angles);
  var4 = var0.origin + var2 * 100;
  var5 = var0.origin - var2 * 100;
  var6 = var0.origin + var3 * 100;
  var7 = var0.origin - var3 * 100;
  var8 = [var5, var6, var7, var4];

  foreach(var10 in var8) {
    if(capsuletracepassed(var10, 40, 80, var0, 0, 1)) {
      var1 = var10;
      break;
    }
  }

  return var1;
}

function startusingtank(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  var0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  var2 = spawnStruct();
  var2.playdeathfx = 1;
  var2.deathoverridecallback = &tank_override_moving_platform_death;
  var0 thread scripts\mp\movers::handle_moving_platforms(var2);
  var0 setotherent(self);
  var0 setentityowner(self);
  var0.driver = self;

  if(istrue(var1)) {
    self unlink();
  }

  self controlslinkTo(var0);
  self remotecontrolturret(var0.mgturret);
  self painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(var0.lifetime * 1000));
  self setclientomnvar("ui_killstreak_health", var0.health / var0.maxhealth);
  scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
  scripts\common\utility::allow_shellshock(0);
  scripts\mp\outofbounds::registerentforoob(var0, "killstreak");
  thread tank_earthquake();
  var0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit("death");
  scripts\mp\utility\player::enableplayerforspawnlogic(0, "remoteTank");
  scripts\mp\spawnlogic::addspawnviewer(var0);
  var0 scripts\cp_mp\emp_debuff::set_start_emp_callback(&tank_empstarted);
  var0 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&tank_empcleared);
  scripts\mp\utility\player::_freezecontrols(0);
}

function tank_handlehelidamage() {
  self endon("death");
  scripts\mp\damage::monitordamage(self.maxhealth, "", &tank_handlehelideathdamage, &tank_modifyhelidamage, 1);
}

function tank_modifyhelidamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;
  var6 = scripts\mp\utility\killstreak::getmodifiedantikillstreakdamage(var1, var2, var3, var6, self.maxhealth, 1, 1, 1);
  return var6;
}

function tank_handlehelideathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;

  if(isDefined(self.intromodel)) {
    self.intromodel delete();
  }

  self notify("death");
}

function tank_modifydamageresponse(var0) {
  thread tank_modifydamagestate(var0);
  var1 = var0.damage;
  var2 = var0.meansofdeath;

  if(isDefined(self.owner) && self.owner scripts\mp\utility\player::isusingremote()) {
    if(isexplosivedamagemod(var2)) {
      if(ceil(var1 / self.maxhealth) >= 0.33) {
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

function tank_modifydamagestate(var0) {
  var1 = var0.damage;
  self.currenthealth = self.health - var1;

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

function tank_override_moving_platform_death(var0) {
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

function ref_13a50() {
  self endon("death");
  level waittill("game_ended");
  thread tank_destroy();
}

function ref_13a51() {
  self endon("death");

  for(;;) {
    scripts\cp_mp\vehicles\vehicle::ref_14103(self);
    waitframe();
  }
}

function tank_destroy(var0, var1) {
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

  if(!isDefined(var0)) {
    var0 = self.owner;
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
  self.streakinfo.onspray = istrue(var1);
  self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
  waitframe();
  self playSound("mp_killstreak_disappear");
  var2 = level._effect["remote_tank_explode"];

  if(self.superfaction) {
    var2 = level._effect["remote_tank_explode_alt"];
  }

  playFX(var2, self.origin);
  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self.mgturret setscriptablepartstate("lights", "off");
  self.mgturret delete();
  level.remotetanks = scripts\engine\utility::array_remove(level.remotetanks, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function tank_destroycallback(var0) {
  thread tank_destroy(var0.attacker, 1);
  return false;
}

function tank_driverexit(var0) {
  var0 endon("disconnect");
  tank_lockedonremovedcallback();
  self.driver = undefined;
  var0 controlsunlink();

  if(isDefined(self.mgturret)) {
    var0 remotecontrolturretoff(self.mgturret);
  }

  var0 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
  var0 setclientomnvar("ui_pac_sentry_controls", 0);

  if(var0 scripts\mp\utility\player::isusingremote()) {
    self.streakinfo notify("killstreak_finished_with_deploy_weapon");
  }

  var0 painvisionon();
  var0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  var0 scripts\mp\utility\player::enableplayerforspawnlogic(1, "remoteTank");
  scripts\mp\spawnlogic::removespawnviewer(self);

  if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var0 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    var0 scripts\common\utility::allow_shellshock(1);
    level thread scripts\cp_mp\utility\killstreak_utility::ref_12cc6(var0);
    return;
  }
}

function tank_riderexit(var0, var1) {
  var0 unlink();
}

function tank_handleairburst() {
  self endon("death");

  for(;;) {
    self.mgturret waittill("missile_fire", var0);
    var0.owner = self.owner;
    var0.streakinfo = self.streakinfo;
    var1 = spawn("script_model", var0.origin);
    var1 setModel("ks_pac_sentry_mp");
    var1.angles = var0.angles;
    var1.team = self.team;
    var1.owner = self.owner;
    var1.streakinfo = self.streakinfo;
    var1 setentityowner(self.owner);
    var1 dontinterpolate();
    self.streakinfo.shots_fired++;
    tank_findclosestairbursttarget(var0, var1);
  }
}

function tank_findclosestairbursttarget(var0, var1) {
  var2 = anglesToForward(var0.angles);
  var3 = var0.origin;
  var4 = var3 + var2 * 22500;
  var5 = [var0, var1, self.owner];
  var6 = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0, 0, 0);
  var7 = scripts\engine\trace::sphere_trace_get_all_results(var3, var4, 60, var5, var6);
  var8 = 0;

  if(isDefined(var7[0])) {
    for(var9 = 0; var9 < var7.size - 1; var9++) {
      var10 = var7[var9]["entity"];
      var11 = var7[var9]["position"];
      var12 = var7[var9]["shape_position"];

      if(isDefined(var10)) {
        if(level.teambased) {
          if(var10.team == var1.team) {
            continue;
          }
        }

        if(!scripts\engine\trace::ray_trace_passed(var12, var11, var1)) {
          continue;
        }
      }

      var8 = 1;
      var13 = distance(var3, var12) / 7500;
      thread tank_watchforairburstdetonate(var0, var11, var12, var13, var1);
      break;
    }
  }

  if(!istrue(var8)) {
    if(isDefined(var1)) {
      var1 delete();
      return;
    }

    return;
  }
}

function tank_watchforairburstdetonate(var0, var1, var2, var3, var4) {
  level endon("game_ended");

  if(isDefined(self)) {
    self delete();
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var2);
  var3.origin = var1;
  var3 setscriptablepartstate("airburst", "airExpl");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var1, 100, 100, var3.team, 1, var3.owner, 1);
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
  var0 = 0;

  for(;;) {
    var1 = self vehicle_getspeed();
    var2 = var1 * 1.60934;

    if(var1 > 1 && !istrue(var0)) {
      var0 = 1;
      self setscriptablepartstate("dust", "on");
    } else if(var1 <= 1 && istrue(var0)) {
      var0 = 0;
      self setscriptablepartstate("dust", "off");
    }

    self.owner setclientomnvar("ui_pac_sentry_speed", int(var2));
    waitframe();
  }
}

function wheelson_enginesfx() {
  self endon("death");
  level endon("game_ended");
  thread wheelson_engine_audio_game_end();

  for(;;) {
    var0 = self.owner;

    if(isDefined(var0)) {
      var1 = var0 getnormalizedmovement();
      var2 = abs(var1[0]);

      if(var2 >= 0.15) {
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

function wheelson_stop_engine_audio(var0) {
  if(istrue(var0)) {
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

function tank_empstarted(var0) {
  if(!isDefined(self.owner)) {
    return;
  }

  self.owner controlsunlink();
  thread scripts\cp_mp\emp_debuff::ref_1241a(self.owner, 5);
}

function tank_empcleared(var0) {
  if(!isDefined(self.owner)) {
    return;
  }

  if(!istrue(var0)) {
    self.owner controlslinkTo(self);
    return;
  }
}

function tank_watchfiring(var0) {
  self endon("disconnect");
  self endon("end_remote");
  var0 endon("death");
  var1 = 50;
  var2 = var1;
  var3 = weaponfiretime(level.tanksettings[var0.tanktype].mgturretinfo);

  for(;;) {
    if(var0.mgturret isfiringvehicleturret()) {
      var2--;

      if(var2 <= 0) {
        var0.mgturret turretfiredisable();
        wait 2.5;
        var0 playSound("talon_reload");
        self playlocalsound("talon_reload_plr");
        var2 = var1;
        var0.mgturret turretfireenable();
      }
    }

    wait var3;
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

function addtougvlist(var0) {
  level.ugvs[var0] = self;
}

function removefromugvlist(var0) {
  level.ugvs[var0] = undefined;
}

function tank_watchridermount() {
  self endon("death");
  level endon("game_ended");
  self.useobj scripts\mp\utility\killstreak::setkillstreakcontrolpriority(self.owner, &"KILLSTREAKS_HINTS/PAC_SENTRY_MOUNT", 90, 90, 150, 150, 3, 1);
  tank_enableriderprompt();

  for(;;) {
    self.useobj waittill("trigger", var0);

    if(isDefined(self.rider) && self.rider == var0) {
      var0 unlink();
      self.rider = undefined;
      tank_enableriderprompt();
      continue;
    }

    if(var0 scripts\mp\utility\player::isusingremote()) {
      continue;
    }

    if(!var0 scripts\common\utility::is_usability_allowed()) {
      continue;
    }

    self.rider = var0;
    var0 playerlinkTo(self, "tag_playerride", 0.8);
    thread tank_watchriderturn(var0, 20);
    thread tank_watchriderabandon(var0);
    thread tank_watchriderautodismount(var0);
    tank_disableriderprompt(var0);
  }
}

function tank_watchriderturn(var0, var1) {
  var0 endon("death_or_disconnect");
  self endon("death");
  var2 = 0;
  var3 = 0;

  for(;;) {
    var4 = var0 getplayerangles();
    var5 = var4[1];
    var6 = self.angles[1];

    switch (var2) {
      case 0:
        var7 = 90 - var1 * 0.5;
        var8 = angleclamp180(var5 - var6);

        if(abs(var8) >= var7) {
          var3 = 2;
          var2 = 1;
        }

        break;
      case 1:
        var9 = vectordot(anglesToForward(var4), anglestoright(self.angles));
        var10 = -1 * var1;

        if(var9 > 0) {
          var11 = angleclamp180(var5 - var6 + 90);

          if(var11 < var10) {
            var3 = 2;
            var2 = 2;
          } else if(var11 > var1) {
            var3 = 0;
            var2 = 0;
          }
        } else {
          var11 = angleclamp180(var6 - var9 - 90);

          if(var11 > var2) {
            var4 = 2;
            var3 = 2;
          } else if(var11 < var11) {
            var4 = 0;
            var3 = 0;
          }
        }

        break;
      case 2:
        var7 = 90 - var2 * 0.5;
        var11 = angleclamp180(var6 - var9 + 180);

        if(abs(var11) >= var7) {
          var4 = 0;
          var3 = 1;
        }

        break;
    }

    waitframe();
  }
}

function tank_watchriderabandon(var0) {
  self endon("death");
  var0 waittill("death_or_disconnect");
  self.rider = undefined;
  tank_enableriderprompt();
}

function tank_watchriderautodismount(var0) {
  self waittill("death");

  if(isDefined(self.rider) && var0 == self.rider) {
    var0 unlink();
    return;
  }
}

function tank_enableriderprompt() {
  if(level.teambased) {
    foreach(var1 in level.players) {
      if(var1.team != self.team) {
        continue;
      }

      self enableplayeruse(var1);
    }

    return;
  }
}

function tank_disableriderprompt(var0) {
  if(level.teambased) {
    foreach(var2 in level.players) {
      if(var2.team != self.team) {
        continue;
      }

      if(var2 == var0) {
        continue;
      }

      self disableplayeruse(var2);
    }

    return;
  }
}

function tank_findsafespawn(var0) {
  var1 = undefined;
  var2 = self.origin;
  var3 = self.angles;
  var4 = anglesToForward(var3);
  var5 = anglestoright(var3);
  var6 = [var2 + var0 * var4, var2 - var0 * var4, var2 + var0 * var5, var2 - var0 * var5, var2 + 0.707 * var0 * (var4 + var5), var2 + 0.707 * var0 * (var4 - var5), var2 + 0.707 * var0 * (var5 - var4), var2 + 0.707 * var0 * (-1 * var4 - var5)];

  foreach(var8 in var6) {
    var1 = tank_checkspawnpoint(var2, var8);

    if(isDefined(var1)) {
      break;
    }
  }

  return var1;
}

function tank_checkspawnpoint(var0, var1) {
  var2 = undefined;
  var3 = (0, 0, 45);
  var4 = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 0, 1);
  var5 = var0 + var3;
  var6 = var1 + var3;
  var7 = 40;
  var8 = scripts\engine\trace::ray_trace_passed(var5, var6, self, var4);

  if(!istrue(var8)) {
    return var2;
  }

  var9 = scripts\engine\trace::ray_trace(var6, var6 - (0, 0, 500), level.players, var4);

  if(isDefined(var9["position"]) && var9["hittype"] != "hittype_none") {
    var10 = var9["position"] + var3;
    var11 = scripts\engine\trace::sphere_trace_passed(var10, var10, var7, level.players, var4);
    var12 = undefined;

    if(level.teambased) {
      var12 = self.team;
    }

    if(istrue(var11) && !scripts\mp\outofbounds::ispointinoutofbounds(var9["position"], var12)) {
      var2 = var9["position"];
    }
  }

  return var2;
}

function tank_updatehudchassisangles() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var0 = self.mgturret gettagangles("tag_flash");
    var1 = invertangles(self.angles);
    var2 = combineangles(var1, var0);
    var3 = var2[1] * -1;
    self.owner setclientomnvar("ui_pac_sentry_degrees", var3);
    waitframe();
  }
}

function tank_updatehudviewstate() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  thread tank_watchownerdeath();
  self.owner notifyonplayercommand("toggle_view", "+togglevehcam");
  var0 = 1;
  var1 = "third_person_hud_on";

  if(isDefined(self.owner.previousremotetankviewstate)) {
    var0 = self.owner.previousremotetankviewstate;

    if(var1 == 2) {
      var1 = "first_person_hud_on";
    }
  }

  for(;;) {
    self.owner waittill("toggle_view");
    var0++;

    if(var0 == 2) {
      self.owner scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
      var1 = "first_person_hud_on";
    } else if(var0 > 2) {
      self.owner scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
      var0 = 1;
      var1 = "third_person_hud_on";
    }

    self.owner.previousremotetankviewstate = var0;
    self.owner scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, var1);
    self.owner setclientomnvar("ui_pac_sentry_controls", var0);
  }
}

function tank_watchownerdeath() {
  var0 = self.owner;
  var0 endon("disconnect");
  level endon("game_ended");
  var0 notify("tank_reset_viewState");
  var0 endon("tank_reset_viewState");
  var0 waittill("death");

  if(isDefined(var0.previousremotetankviewstate)) {
    var0.previousremotetankviewstate = undefined;
    return;
  }
}