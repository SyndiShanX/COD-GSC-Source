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
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("little_bird", 1);
  var0.destroycallback = &little_bird_explode;
  var0.canfly = 1;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("little_bird", 1);
  var0.enterstartcallback = &little_bird_enterstart;
  var0.enterendcallback = &little_bird_enterend;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &little_bird_exitend;
  var0.reentercallback = &little_bird_reenter;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var0.exitextents["front"] = 95;
  var0.exitextents["back"] = 195;
  var0.exitextents["left"] = 55;
  var0.exitextents["right"] = 55;
  var0.exitextents["top"] = -5;
  var0.exitextents["bottom"] = 117;
  var0.allowairexit = 1;
  var1 = "front";
  var0.exitoffsets[var1] = (85, 0, -40);
  var0.exitdirections[var1] = "front";
  var1 = "front_right";
  var0.exitoffsets[var1] = (40, -17, -40);
  var0.exitdirections[var1] = "right";
  var1 = "middle_left";
  var0.exitoffsets[var1] = (0, 17, -45);
  var0.exitdirections[var1] = "left";
  var1 = "middle_right";
  var0.exitoffsets[var1] = (0, -17, -45);
  var0.exitdirections[var1] = "right";
  var1 = "back";
  var0.exitoffsets[var1] = (-85, 0, -65);
  var0.exitdirections[var1] = "back";
  var2 = [];

  if(false) {
    var2 = ["pilot", "gunner", "bl_platform", "fl_platform"];
  } else {
    var2 = ["pilot", "fr_platform", "br_platform", "bl_platform", "fl_platform"];
  }

  var3 = "pilot";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "middle_left", "front_right", "front", "back"];
  var0.exitoffsets[var3] = (40, 17, -40);
  var0.exitdirections[var3] = "left";
  var4.animtag = "tag_seat_0";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.spawnpriority = 10;
  var4.ref_12023 = "ping_vehicle_pilot";
  var3 = "fl_platform";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["middle_left", "pilot", "middle_right", "front", "back"];
  var4.viewclamps["top"] = 180;
  var4.viewclamps["bottom"] = 180;
  var4.viewclamps["left"] = 110;
  var4.viewclamps["right"] = 125;
  var4.animtag = "tag_seat_2";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "bl_platform";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["middle_left", "pilot", "middle_right", "front", "back"];
  var4.viewclamps["top"] = 180;
  var4.viewclamps["bottom"] = 180;
  var4.viewclamps["left"] = 120;
  var4.viewclamps["right"] = 105;
  var4.animtag = "tag_seat_3";
  var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "fr_platform";

  if(!0) {
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var3, 1);
    var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
    var4.exitids = ["middle_right", "front_right", "middle_left", "front", "back"];
    var4.viewclamps["top"] = 180;
    var4.viewclamps["bottom"] = 180;
    var4.viewclamps["left"] = 125;
    var4.viewclamps["right"] = 110;
    var4.animtag = "tag_seat_4";
    var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
    var4.ref_12023 = "ping_vehicle_rider";
  }

  var3 = "br_platform";

  if(!0) {
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var3, 1);
    var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
    var4.exitids = ["middle_right", "front_right", "middle_left", "front", "back"];
    var4.viewclamps["top"] = 180;
    var4.viewclamps["bottom"] = 180;
    var4.viewclamps["left"] = 105;
    var4.viewclamps["right"] = 120;
    var4.animtag = "tag_seat_5";
    var4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var4.animtag);
    var4.ref_12023 = "ping_vehicle_rider";
  }

  var3 = "gunner";

  if(false) {
    var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird", var3, 1);
    var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
    var4.exitids = ["middle_right", "front_right", "middle_left", "front", "back"];
    var4.ref_12023 = "ping_vehicle_gunner";
    return;
  }
}

function little_bird_initinteract() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("little_bird", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("little_bird", "single", ["pilot", "fl_platform", "fr_platform", "bl_platform", "br_platform"]);
}

function x1opsinfilsequenceendinternal() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("little_bird", 1);
  var0.brtruck_initdialog["flares"] = 1;
  var0.id = 2;

  if(!0) {
    var0.seatids["pilot"] = 0;
    var0.seatids["fl_platform"] = 1;
    var0.seatids["bl_platform"] = 3;
    var0.seatids["fr_platform"] = 2;
    var0.seatids["br_platform"] = 4;
    return;
  }

  var0.seatids["pilot"] = 0;
  var0.seatids["fl_platform"] = 1;
  var0.seatids["bl_platform"] = 3;
  var0.seatids["gunner"] = 5;
}

function x1opsinfilsequenceend() {
  if(level.gametype == "br") {
    var0 = 3000;
  } else {
    var0 = 2500;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("little_bird", var0);
  var1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("little_bird");
  var1.class = "medium_heavy";
  var2 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d("little_bird", "heavy");
  var2.ref_12024 = &zombiehealth;
  var2.ref_1202d = &zombiehud;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("little_bird");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("little_bird", 12);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("little_bird", &little_bird_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("little_bird_mp", 5);
}

function x1opsentercalloutarea() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("little_bird", 1);
  var0.challengeevaluator = 1.5;
  var0.keycardlocs_chosen = 0.875;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 8.75;
  var0.isallowedweapon = 35;
  var0.isakimbo = 70;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function little_bird_initfx() {
  level._effect["little_bird_explode"] = loadfx("vfx/iw8/prop/scriptables/vfx_vh8_mil_air_lbravo_debris.vfx");
}

function little_bird_create(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_mil_air_lbravo_personnel_mp_flyable";
  var0.targetname = "little_bird";
  var0.vehicletype = "lbravo_physics_mp";
  var0.cannotbesuspended = 1;
  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  var2.currentdestindex = gettime();
  var2.flareslive = [];
  var2.player_is_trying_self_revive = 1;

  if(isDefined(level.…S© ÄÛq õ Èèã7°½ ª£¢ ? Úo hç.©ï)) {
    var2.ref_120b4 = level.…S© ÄÛq õ Èèã7°½ ª£¢ ? Úo hç.©ï;
  }

  if(level.gametype == "br") {
    var2.player_is_pressing_attack = 35;
  } else {
    var2.player_is_pressing_attack = 10;
  }

  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "little_bird", var0);
  var2.objweapon = getcompleteweaponname("little_bird_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "create")]](var2);
  }

  thread ref_14195();
  thread helis_assault3_hangar_check_size();
  return var2;
}

function helis_assault3_hangar_check_size() {
  self endon("death");
  self vehphys_enablecollisioncallback(1);

  for(;;) {
    self waittill("collision", var0, var1, var2, var3, var4, var5, var6, var7, var8);

    if(gettime() - self.currentdestindex < 5000) {
      continue;
    }

    if(isDefined(var7) && isDefined(var7.helperdronetype) && var7.helperdronetype == "radar_drone_recon") {
      continue;
    }

    var9 = 1;

    switch (var8) {
      case 0:
        var9 = level.watchforapcdamage;
        break;
      case 1:
        var9 = level.watchforcircuitbreakertriggered;
        break;
      case 2:
        var9 = level.watchforbrsquadleadershift;
        break;
      case 3:
        var9 = level.watchforcarrierdisconnect;
        break;
      case 4:
        var9 = level.watchforatvtrigger;
        break;
    }

    var10 = var6 * var9;
    var11 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

    if(!isDefined(var11)) {
      var10 *= level.watchforallnewpayloadspawners;
    }

    var12 = self.angles[0];

    if(var12 > 180) {
      var12 -= 360;
    }

    if(abs(var12 > level.watchfortapemachineinteraction)) {
      var10 *= level.watchforsquadleaddisconnect;
    }

    var13 = self.angles[2];

    if(var13 > 180) {
      var13 -= 360;
    }

    if(abs(var13 > level.watchfortapemachineinteraction)) {
      var10 *= level.watchforsquadleaddisconnect;
    }

    var14 = 0;

    if(var10 > level.watchforentervehicle) {
      var14 = self.maxhealth;
    } else if(var10 > level.watchforearlyprimeexit) {
      var15 = level.watchforentervehicle - level.watchforearlyprimeexit;
      var16 = (var10 - level.watchforearlyprimeexit) / var15;
      var17 = self.maxhealth * level.watchfordeleteleaderidleanchor;
      var18 = self.maxhealth * level.watchfordeathwhilereviving;
      var14 = scripts\engine\math::lerp(var17, var18, var16);
    } else if(var10 > level.watchfordeposit) {
      var14 = self.maxhealth * level.watchforcratedrop;
    }

    if(var14 > 0) {
      if(isDefined(var11) && var3 == 11534336) {
        var14 *= level.watchforteammatedeathwhilereviving;
      }

      scripts\cp_mp\vehicles\vehicle_damage::ref_14143(1);
      self dodamage(var14, var4, undefined, undefined, "MOD_CRUSH");
      scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
    }

    wait 0.5;
  }
}

function little_bird_creategunnerturret(var0) {
  var1 = spawnturret("misc_turret", var0 gettagorigin("tag_origin"), "tur_gun_lighttank_mp", 0);
  var1 linkTo(var0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var1 setModel("veh8_mil_lnd_coscar_west_turret_gun");
  var1 setmode("sentry_offline");
  var1 setsentryowner(undefined);
  var1 makeunusable();
  var1 setdefaultdroppitch(0);
  var1 setturretmodechangewait(1);
  var1.angles = var0.angles;
  var1.vehicle = var0;
  var1.maxhealth = 999999;
  var1.health = var1.maxhealth;
  return var1;
}

function little_bird_explode(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "little_bird_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread little_bird_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_detach");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "little_bird_mp");
    playFX(scripts\engine\utility::getfx("little_bird_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "veh_lbravo_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function little_bird_deathcallback(var0) {
  thread little_bird_explode(var0);
  return true;
}

function zombiehealth(var0, var1) {
  self setscriptablepartstate("alarm", "engineFailure", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var0, var1);
}

function zombiehud(var0, var1) {
  self setscriptablepartstate("alarm", "off", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var0, var1);
}

function little_bird_enterstart(var0, var1, var2, var3, var4) {
  if(var1 == "gunner") {
    little_bird_givegunnerturret(var3, var0, var4, 1);
  }

  if(istrue(var0.israllypointvehicle)) {
    foreach(var6 in level.players) {
      if(istrue(var0.revealed) || var6.team == var0.team) {
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var0.marker.objidnum, var6);
      }
    }

    foreach(var9 in var0.occupants) {
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var0.marker.objidnum, var9);
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var0.marker.objidnum, var3);
    return;
  }
}

function little_bird_enterend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    var3 scripts\cp_mp\parachute::ref_121ca();
    little_bird_enterendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function little_bird_enterendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "pilot") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
    var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
    thread ref_14194(var0);
  } else if(var1 == "gunner") {
    var0.gunnerturret.owner = var3;
    var0.gunnerturret setotherent(var3);
    var0.gunnerturret setentityowner(var3);
    var0.gunnerturret setsentryowner(var3);
    var3 disableturretdismount();
    var3 controlturreton(var0.gunnerturret);
    var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
  } else {
    var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird", "endEnterInternal", 0)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "endEnterInternal")]](var0, var1, var2, var3, var4);
    return;
  }
}

function little_bird_exitend(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    little_bird_exitendinternal(var0, var1, var2, var3, var4);
    return;
  }
}

function little_bird_exitendinternal(var0, var1, var2, var3, var4) {
  if(var1 == "pilot") {
    var0 notify("little_bird_driver_exit");
    var0 setotherent(undefined);
    var0 setentityowner(undefined);

    if(!istrue(var4.playerdisconnect)) {
      var3 controlsunlink();
    }
  }

  if(var1 == "gunner") {
    if(!istrue(var4.playerdisconnect)) {
      var3 enableturretdismount();
      var3 controlturretoff(var0.gunnerturret);

      if(!istrue(var4.playerdeath)) {
        thread little_bird_takegunnerturret(var3, var0, var4);
      }
    }

    var0.gunnerturret.owner = undefined;
    var0.gunnerturret setotherent(undefined);
    var0.gunnerturret setentityowner(undefined);
    var0.gunnerturret setsentryowner(undefined);
  }

  if(!istrue(var4.playerdisconnect)) {
    var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var3, var2, var4);

    if(!var5) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var3);
      } else {
        var3 suicide();
      }
    } else if(istrue(var0.israllypointvehicle)) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var0.marker.objidnum, var3);
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var0, var1, var2, var3);
}

function little_bird_reenter(var0, var1, var2, var3, var4) {
  if(isDefined(var2) && var2 == "gunner") {
    thread little_bird_takegunnerturret(var3, var0, var4);
    return;
  }
}

function little_bird_givegunnerturret(var0, var1, var2) {
  if(isDefined(var1.raceendon)) {
    var1 endon(var1.raceendon);
  }

  if(istrue(var2)) {
    GscBinSkip4(0x35, var1, 1.5);
  }

  if(!self hasweapon("tur_gun_lighttank_mp")) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon("tur_gun_lighttank_mp");
  }

  var3 = undefined;

  if(scripts\cp_mp\utility\inventory_utility::iscurrentweapon("tur_gun_lighttank_mp")) {
    var3 = 1;
  } else {
    var3 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("tur_gun_lighttank_mp", 1);
  }

  if(isDefined(var1) && isDefined(var3) && !var3) {
    var1.success = 0;
    var1 notify(var1.raceendnotify);
    return;
  }
}

function little_bird_takegunnerturret(var0, var1, var2) {
  if(isDefined(var1.raceendon)) {
    var1 endon(var1.raceendon);
  }

  if(istrue(var2)) {
    GscBinSkip4(0x35, var1, 1.5);
  }

  if(self hasweapon("tur_gun_lighttank_mp")) {
    var3 = undefined;

    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring("tur_gun_lighttank_mp")) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch("tur_gun_lighttank_mp");
      var3 = 1;
    } else {
      if(isDefined(var0.gunnerturret)) {
        self controlturretoff(var0.gunnerturret);
      }

      if(self hasweapon("tur_gun_lighttank_mp")) {
        var4 = scripts\cp_mp\utility\inventory_utility::iscurrentweapon("tur_gun_lighttank_mp");

        if(var4) {
          scripts\cp_mp\utility\inventory_utility::_takeweapon("tur_gun_lighttank_mp");
          thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
        } else {
          thread scripts\cp_mp\utility\inventory_utility::getridofweapon("tur_gun_lighttank_mp", 1);
        }
      }

      var3 = 1;
    }

    if(isDefined(var3) && !var3) {
      var1.success = 0;
      var1 notify(var1.raceendnotify);
      return;
    }

    return;
  }
}

function little_bird_givetakegunnerturrettimeout(var0, var1) {
  wait var1;
  var0.success = 0;
  var0 notify(var0.raceendnotify);
}

function ref_14195() {
  self endon("death");

  for(;;) {
    if(!self.player_is_trying_self_revive) {
      wait self.player_is_pressing_attack;
      self.player_is_trying_self_revive = 1;
      var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

      if(isDefined(var0)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird", "flares", 1, var0);
      }
    }

    waitframe();
  }
}

function ref_14194(var0) {
  self endon("death");
  self endon("little_bird_driver_exit");
  var0 endon("death_or_disconnect");
  var0 endon("vehicle_exit");
  var0 notifyonplayercommand("shoot_flare", "+attack");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird", "flares", scripts\engine\utility::ter_op(self.player_is_trying_self_revive, 1, 0), var0);

  for(;;) {
    var0 waittill("shoot_flare");

    if(!self.player_is_trying_self_revive) {
      self playsoundtoplayer("lbravo_noflares_warning", var0);
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]]();
    }

    var1 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
      var1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
    }

    if(isDefined(level.missiles)) {
      foreach(var3 in level.missiles) {
        if(!isDefined(var3.ref_119a0) || var3.ref_119a0 != self) {
          continue;
        }

        var4 = distance(self.origin, var3.origin);

        if(var4 < 4000) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
            var0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("manual_flare_missile_redirect");
          }

          scripts\cp_mp\utility\weapon_utility::clearprojectilelockedon(var3);
          var3 missile_settargetEnt(var1);
          var3 notify("missile_pairedWithFlare");
        }
      }
    }

    self.player_is_trying_self_revive = 0;
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird", "flares", 0, var0);
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d2(var0);
  }
}

function little_bird_initspawning() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("little_bird", 1);
  var0.maxinstancecount = 5;
  var0.priority = 100;
  var0.getspawnstructscallback = &little_bird_getspawnstructscallback;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird", "spawnCallback");
  var0.clearancecheckradius = 185;
  var0.clearancecheckheight = 100;
  var0.clearancecheckoffsetz = -100;
  var0.clearancecheckminradius = 185;
}

function little_bird_getspawnstructscallback() {
  var0 = scripts\engine\utility::getStructArray("littlebird_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}