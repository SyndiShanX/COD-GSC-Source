/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\little_bird.gsc
**************************************************/

function little_bird_init() {
  level.watchforapcdamage = getdvarfloat("scr_little_bird_dmg_factor_fuselage", 1);
  level.watchforcircuitbreakertriggered = getdvarfloat("scr_little_bird_dmg_factor_tail_stabilizer", 1);
  level.watchforbrsquadleadershift = getdvarfloat("scr_little_bird_dmg_factor_main_rotor", 1.2);
  level.watchforcarrierdisconnect = getdvarfloat("scr_little_bird_dmg_factor_tail_rotor", 1);
  level.watchforatvtrigger = getdvarfloat("scr_little_bird_dmg_factor_landing_gear", 0.5);
  level.watchforallnewpayloadspawners = getdvarfloat("scr_little_bird_dmg_factor_driverless_collision", 3);
  level.watchforentervehicle = getdvarfloat("scr_little_bird_impulse_dmg_threshold_high", 0.9);
  level.watchforearlyprimeexit = getdvarfloat("scr_little_bird_impulse_dmg_threshold_mid", 0.9);
  level.watchfordeposit = getdvarfloat("scr_little_bird_impulse_dmg_threshold_low", 0.1);
  level.watchforcratedrop = getdvarfloat("scr_little_bird_impulse_dmg_factor_low", 0.1);
  level.watchfordeleteleaderidleanchor = getdvarfloat("scr_little_bird_impulse_dmg_factor_mid_low", 0.2);
  level.watchfordeathwhilereviving = getdvarfloat("scr_little_bird_impulse_dmg_factor_mid_high", 0.75);
  level.watchfortapemachineinteraction = getdvarfloat("scr_little_bird_dmg_pitch_roll_threshold", 55);
  level.watchforsquadleaddisconnect = getdvarfloat("scr_little_bird_dmg_pitch_roll_factor", 10);
  level.watchforteammatedeathwhilereviving = getdvarfloat("scr_little_bird_wood_surf_dmg_scalar", 0.6);
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("little_bird", 1);
  var_0.destroycallback = &little_bird_explode;
  var_0.canfly = 1;
  little_bird_initoccupancy();
  little_bird_initinteract();
  x1opsinfilsequenceendinternal();
  x1opsinfilsequenceend();
  x1opsentercalloutarea();
  little_bird_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "init")]]();
  }

  little_bird_initspawning();
  little_bird_initlate();
}

function little_bird_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "initLate")]]();
    return;
  }
}

function little_bird_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("little_bird", 1);
  var_0.enterstartcallback = &little_bird_enterstart;
  var_0.enterendcallback = &little_bird_enterend;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &little_bird_exitend;
  var_0.reentercallback = &little_bird_reenter;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["front"] = 95;
  var_0.exitextents["back"] = 195;
  var_0.exitextents["left"] = 55;
  var_0.exitextents["right"] = 55;
  var_0.exitextents["top"] = -5;
  var_0.exitextents["bottom"] = 117;
  var_0.allowairexit = 1;
  var_1 = "front";
  var_0.exitoffsets[var_1] = (85, 0, -40);
  var_0.exitdirections[var_1] = "front";
  var_1 = "front_right";
  var_0.exitoffsets[var_1] = (40, -17, -40);
  var_0.exitdirections[var_1] = "right";
  var_1 = "middle_left";
  var_0.exitoffsets[var_1] = (0, 17, -45);
  var_0.exitdirections[var_1] = "left";
  var_1 = "middle_right";
  var_0.exitoffsets[var_1] = (0, -17, -45);
  var_0.exitdirections[var_1] = "right";
  var_1 = "back";
  var_0.exitoffsets[var_1] = (-85, 0, -65);
  var_0.exitdirections[var_1] = "back";
  var_2 = [];

  if(false) {
    var_2 = ["pilot", "gunner", "bl_platform", "fl_platform"];
  } else {
    var_2 = ["pilot", "fr_platform", "br_platform", "bl_platform", "fl_platform"];
  }

  var_3 = "pilot";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "middle_left", "front_right", "front", "back"];
  var_0.exitoffsets[var_3] = (40, 17, -40);
  var_0.exitdirections[var_3] = "left";
  var_4.animtag = "tag_seat_0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.spawnpriority = 10;
  var_4.ref_12023 = "ping_vehicle_pilot";
  var_3 = "fl_platform";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["middle_left", "pilot", "middle_right", "front", "back"];
  var_4.viewclamps["top"] = 180;
  var_4.viewclamps["bottom"] = 180;
  var_4.viewclamps["left"] = 110;
  var_4.viewclamps["right"] = 125;
  var_4.animtag = "tag_seat_2";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "bl_platform";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["middle_left", "pilot", "middle_right", "front", "back"];
  var_4.viewclamps["top"] = 180;
  var_4.viewclamps["bottom"] = 180;
  var_4.viewclamps["left"] = 120;
  var_4.viewclamps["right"] = 105;
  var_4.animtag = "tag_seat_3";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "fr_platform";

  if(!0) {
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var_3, 1);
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
    var_4.exitids = ["middle_right", "front_right", "middle_left", "front", "back"];
    var_4.viewclamps["top"] = 180;
    var_4.viewclamps["bottom"] = 180;
    var_4.viewclamps["left"] = 125;
    var_4.viewclamps["right"] = 110;
    var_4.animtag = "tag_seat_4";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
    var_4.ref_12023 = "ping_vehicle_rider";
  }

  var_3 = "br_platform";

  if(!0) {
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var_3, 1);
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
    var_4.exitids = ["middle_right", "front_right", "middle_left", "front", "back"];
    var_4.viewclamps["top"] = 180;
    var_4.viewclamps["bottom"] = 180;
    var_4.viewclamps["left"] = 105;
    var_4.viewclamps["right"] = 120;
    var_4.animtag = "tag_seat_5";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
    var_4.ref_12023 = "ping_vehicle_rider";
  }

  var_3 = "gunner";

  if(false) {
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var_3, 1);
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
    var_4.exitids = ["middle_right", "front_right", "middle_left", "front", "back"];
    var_4.ref_12023 = "ping_vehicle_gunner";
    return;
  }
}

function little_bird_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("little_bird", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419D("little_bird", "single", ["pilot", "fl_platform", "fr_platform", "bl_platform", "br_platform"]);
}

function x1opsinfilsequenceendinternal() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("little_bird", 1);
  var_0.brtruck_initdialog["flares"] = 1;
  var_0.id = 2;

  if(!0) {
    var_0.seatids["pilot"] = 0;
    var_0.seatids["fl_platform"] = 1;
    var_0.seatids["bl_platform"] = 3;
    var_0.seatids["fr_platform"] = 2;
    var_0.seatids["br_platform"] = 4;
    return;
  }

  var_0.seatids["pilot"] = 0;
  var_0.seatids["fl_platform"] = 1;
  var_0.seatids["bl_platform"] = 3;
  var_0.seatids["gunner"] = 5;
}

function x1opsinfilsequenceend() {
  if(level.gametype == "br") {
    var_0 = 3000;
  } else {
    var_0 = 2500;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("little_bird", var_0);
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("little_bird");
  var_1.class = "medium_heavy";
  var_2 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414D("little_bird", "heavy");
  var_2.ref_12024 = &zombiehealth;
  var_2.ref_1202D = &zombiehud;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("little_bird");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("little_bird", 12);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("little_bird", &little_bird_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("little_bird_mp", 5);
}

function x1opsentercalloutarea() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410F("little_bird", 1);
  var_0.challengeevaluator = 1.5;
  var_0.keycardlocs_chosen = 0.875;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 8.75;
  var_0.isallowedweapon = 35;
  var_0.isakimbo = 70;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function little_bird_initfx() {
  level._effect["little_bird_explode"] = loadfx("vfx/iw8/prop/scriptables/vfx_vh8_mil_air_lbravo_debris.vfx");
}

function little_bird_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_mil_air_lbravo_personnel_mp_flyable";
  var_0.targetname = "little_bird";
  var_0.vehicletype = "lbravo_physics_mp";
  var_0.cannotbesuspended = 1;
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_2.currentdestindex = gettime();
  var_2.flareslive = [];
  var_2.player_is_trying_self_revive = 1;

  if(isDefined(level.littlebird_overrideoobseconds)) {
    var_2.ref_120B4 = level.littlebird_overrideoobseconds;
  }

  if(level.gametype == "br") {
    var_2.player_is_pressing_attack = 35;
  } else {
    var_2.player_is_pressing_attack = 10;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "little_bird", var_0);
  var_2.objweapon = getcompleteweaponname("little_bird_mp");
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "create")]](var_2);
  }

  thread ref_14195();
  thread helis_assault3_hangar_check_size();
  return var_2;
}

function helis_assault3_hangar_check_size() {
  self endon("death");
  self vehphys_enablecollisioncallback(1);

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(gettime() - self.currentdestindex < 5000) {
      continue;
    }

    if(isDefined(var_7) && isDefined(var_7.helperdronetype) && var_7.helperdronetype == "radar_drone_recon") {
      continue;
    }

    var_9 = 1;

    switch (var_8) {
      case 0:
        var_9 = level.watchforapcdamage;
        break;
      case 1:
        var_9 = level.watchforcircuitbreakertriggered;
        break;
      case 2:
        var_9 = level.watchforbrsquadleadershift;
        break;
      case 3:
        var_9 = level.watchforcarrierdisconnect;
        break;
      case 4:
        var_9 = level.watchforatvtrigger;
        break;
    }

    var_10 = var_6 * var_9;
    var_11 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

    if(!isDefined(var_11)) {
      var_10 *= level.watchforallnewpayloadspawners;
    }

    var_12 = self.angles[0];

    if(var_12 > 180) {
      var_12 -= 360;
    }

    if(abs(var_12 > level.watchfortapemachineinteraction)) {
      var_10 *= level.watchforsquadleaddisconnect;
    }

    var_13 = self.angles[2];

    if(var_13 > 180) {
      var_13 -= 360;
    }

    if(abs(var_13 > level.watchfortapemachineinteraction)) {
      var_10 *= level.watchforsquadleaddisconnect;
    }

    var_14 = 0;

    if(var_10 > level.watchforentervehicle) {
      var_14 = self.maxhealth;
    } else if(var_10 > level.watchforearlyprimeexit) {
      var_15 = level.watchforentervehicle - level.watchforearlyprimeexit;
      var_16 = (var_10 - level.watchforearlyprimeexit) / var_15;
      var_17 = self.maxhealth * level.watchfordeleteleaderidleanchor;
      var_18 = self.maxhealth * level.watchfordeathwhilereviving;
      var_14 = scripts\engine\math::lerp(var_17, var_18, var_16);
    } else if(var_10 > level.watchfordeposit) {
      var_14 = self.maxhealth * level.watchforcratedrop;
    }

    if(var_14 > 0) {
      if(isDefined(var_11) && var_3 == 11534336) {
        var_14 *= level.watchforteammatedeathwhilereviving;
      }

      scripts\cp_mp\vehicles\vehicle_damage::ref_14143(1);
      self dodamage(var_14, var_4, undefined, undefined, "MOD_CRUSH");
      scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
    }

    wait 0.5;
  }
}

function little_bird_creategunnerturret(var_0) {
  var_1 = spawnturret("misc_turret", var_0 gettagorigin("tag_origin"), "tur_gun_lighttank_mp", 0);
  var_1 linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 setModel("veh8_mil_lnd_coscar_west_turret_gun");
  var_1 setmode("sentry_offline");
  var_1 setsentryowner(undefined);
  var_1 makeunusable();
  var_1 setdefaultdroppitch(0);
  var_1 setturretmodechangewait(1);
  var_1.angles = var_0.angles;
  var_1.vehicle = var_0;
  var_1.maxhealth = 999999;
  var_1.health = var_1.maxhealth;
  return var_1;
}

function little_bird_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "little_bird_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread little_bird_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_detach");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "little_bird_mp");
    playFX(scripts\engine\utility::getfx("little_bird_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "veh_lbravo_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function little_bird_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function little_bird_deathcallback(var_0) {
  thread little_bird_explode(var_0);
  return true;
}

function zombiehealth(var_0, var_1) {
  self setscriptablepartstate("alarm", "engineFailure", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var_0, var_1);
}

function zombiehud(var_0, var_1) {
  self setscriptablepartstate("alarm", "off", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var_0, var_1);
}

function little_bird_enterstart(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "gunner") {
    little_bird_givegunnerturret(var_3, var_0, var_4, 1);
  }

  if(istrue(var_0.israllypointvehicle)) {
    foreach(var_6 in level.players) {
      if(istrue(var_0.revealed) || var_6.team == var_0.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_6);
      }
    }

    foreach(var_9 in var_0.occupants) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_9);
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_3);
    return;
  }
}

function little_bird_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    var_3 scripts\cp_mp\parachute::ref_121CA();
    little_bird_enterendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function little_bird_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "pilot") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
    thread ref_14194(var_0);
  } else if(var_1 == "gunner") {
    var_0.gunnerturret.owner = var_3;
    var_0.gunnerturret setotherent(var_3);
    var_0.gunnerturret setentityowner(var_3);
    var_0.gunnerturret setsentryowner(var_3);
    var_3 disableturretdismount();
    var_3 controlturreton(var_0.gunnerturret);
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
  } else {
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "endEnterInternal", 0)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "endEnterInternal")]](var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function little_bird_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    little_bird_exitendinternal(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function little_bird_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "pilot") {
    var_0 notify("little_bird_driver_exit");
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 controlsunlink();
    }
  }

  if(var_1 == "gunner") {
    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_0.gunnerturret);

      if(!istrue(var_4.playerdeath)) {
        thread little_bird_takegunnerturret(var_3, var_0, var_4);
      }
    }

    var_0.gunnerturret.owner = undefined;
    var_0.gunnerturret setotherent(undefined);
    var_0.gunnerturret setentityowner(undefined);
    var_0.gunnerturret setsentryowner(undefined);
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_5) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    } else if(istrue(var_0.israllypointvehicle)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_3);
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

function little_bird_reenter(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "gunner") {
    thread little_bird_takegunnerturret(var_3, var_0, var_4);
    return;
  }
}

function little_bird_givegunnerturret(var_0, var_1, var_2) {
  if(isDefined(var_1.raceendon)) {
    var_1 endon(var_1.raceendon);
  }

  if(istrue(var_2)) {
    GscBinSkip4(0x35, var_1, 1.5);
  }

  if(!self hasweapon("tur_gun_lighttank_mp")) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon("tur_gun_lighttank_mp");
  }

  var_3 = undefined;

  if(scripts\cp_mp\utility\inventory_utility::iscurrentweapon("tur_gun_lighttank_mp")) {
    var_3 = 1;
  } else {
    var_3 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("tur_gun_lighttank_mp", 1);
  }

  if(isDefined(var_1) && isDefined(var_3) && !var_3) {
    var_1.success = 0;
    var_1 notify(var_1.raceendnotify);
    return;
  }
}

function little_bird_takegunnerturret(var_0, var_1, var_2) {
  if(isDefined(var_1.raceendon)) {
    var_1 endon(var_1.raceendon);
  }

  if(istrue(var_2)) {
    GscBinSkip4(0x35, var_1, 1.5);
  }

  if(self hasweapon("tur_gun_lighttank_mp")) {
    var_3 = undefined;

    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring("tur_gun_lighttank_mp")) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch("tur_gun_lighttank_mp");
      var_3 = 1;
    } else {
      if(isDefined(var_0.gunnerturret)) {
        self controlturretoff(var_0.gunnerturret);
      }

      if(self hasweapon("tur_gun_lighttank_mp")) {
        var_4 = scripts\cp_mp\utility\inventory_utility::iscurrentweapon("tur_gun_lighttank_mp");

        if(var_4) {
          scripts\cp_mp\utility\inventory_utility::_takeweapon("tur_gun_lighttank_mp");
          thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
        } else {
          thread scripts\cp_mp\utility\inventory_utility::getridofweapon("tur_gun_lighttank_mp", 1);
        }
      }

      var_3 = 1;
    }

    if(isDefined(var_3) && !var_3) {
      var_1.success = 0;
      var_1 notify(var_1.raceendnotify);
      return;
    }

    return;
  }
}

function little_bird_givetakegunnerturrettimeout(var_0, var_1) {
  wait var_1;
  var_0.success = 0;
  var_0 notify(var_0.raceendnotify);
}

function ref_14195() {
  self endon("death");

  for(;;) {
    if(!self.player_is_trying_self_revive) {
      wait self.player_is_pressing_attack;
      self.player_is_trying_self_revive = 1;
      var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

      if(isDefined(var_0)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird", "flares", 1, var_0);
      }
    }

    waitframe();
  }
}

function ref_14194(var_0) {
  self endon("death");
  self endon("little_bird_driver_exit");
  var_0 endon("death_or_disconnect");
  var_0 endon("vehicle_exit");
  var_0 notifyonplayercommand("shoot_flare", "+attack");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird", "flares", scripts\engine\utility::ter_op(self.player_is_trying_self_revive, 1, 0), var_0);

  for(;;) {
    var_0 waittill("shoot_flare");

    if(!self.player_is_trying_self_revive) {
      self playsoundtoplayer("lbravo_noflares_warning", var_0);
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]]();
    }

    var_1 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
      var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
    }

    if(isDefined(level.missiles)) {
      foreach(var_3 in level.missiles) {
        if(!isDefined(var_3.ref_119A0) || var_3.ref_119A0 != self) {
          continue;
        }

        var_4 = distance(self.origin, var_3.origin);

        if(var_4 < 4000) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
            var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("manual_flare_missile_redirect");
          }

          scripts\cp_mp\utility\weapon_utility::clearprojectilelockedon(var_3);
          var_3 missile_settargetEnt(var_1);
          var_3 notify("missile_pairedWithFlare");
        }
      }
    }

    self.player_is_trying_self_revive = 0;
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird", "flares", 0, var_0);
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141D2(var_0);
  }
}

function little_bird_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("little_bird", 1);
  var_0.maxinstancecount = 5;
  var_0.priority = 100;
  var_0.getspawnstructscallback = &little_bird_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "spawnCallback");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 100;
  var_0.clearancecheckoffsetz = -100;
  var_0.clearancecheckminradius = 185;
}

function little_bird_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("littlebird_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}