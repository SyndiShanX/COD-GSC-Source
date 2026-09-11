/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58236.gsc
***********************************************/

function x1stash_removequestinstance() {
  level.watchforhelistatus = getdvarfloat("scr_little_bird_dmg_factor_fuselage", 1);
  level.watchforlowpopmatchstart = getdvarfloat("scr_little_bird_dmg_factor_tail_stabilizer", 1);
  level.watchforjuggernautgameend = getdvarfloat("scr_little_bird_dmg_factor_main_rotor", 1.2);
  level.watchforleapfrogpathdisconnect = getdvarfloat("scr_little_bird_dmg_factor_tail_rotor", 1);
  level.watchforjuggernautdisconnect = getdvarfloat("scr_little_bird_dmg_factor_landing_gear", 0.5);
  level.watchforexfilallyturntoside = getdvarfloat("scr_little_bird_dmg_factor_driverless_collision", 3);
  level.watchforpayloadstage = getdvarfloat("scr_little_bird_impulse_dmg_threshold_high", 0.9);
  level.watchfornewdrop = getdvarfloat("scr_little_bird_impulse_dmg_threshold_mid", 0.9);
  level.watchfornearmisswhizby = getdvarfloat("scr_little_bird_impulse_dmg_threshold_low", 0.1);
  level.watchformoralespickedup = getdvarfloat("scr_little_bird_impulse_dmg_factor_low", 0.1);
  level.watchfornagstootherplayers = getdvarfloat("scr_little_bird_impulse_dmg_factor_mid_low", 0.2);
  level.watchformoralesunderfire = getdvarfloat("scr_little_bird_impulse_dmg_factor_mid_high", 0.75);
  level.watchforplayertouchingwater = getdvarfloat("scr_little_bird_dmg_pitch_roll_threshold", 55);
  level.watchforpayloadtriggersuperwave = getdvarfloat("scr_little_bird_dmg_pitch_roll_factor", 10);
  level.watchforscriptabledoorsinradius = getdvarfloat("scr_little_bird_wood_surf_dmg_scalar", 0.6);
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("little_bird_mg", 1);
  var_0.destroycallback = &x1spyplane;
  var_0.canfly = 1;
  xanimlength();
  x1timehandler();
  xmike109();
  x1stashlootcacheused();
  x1stash_respawn();
  x1timedivision();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird_mg", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird_mg", "init")]]();
  }

  xmike109projectiles();
  x1unittimedivision();
}

function x1unittimedivision() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird_mg", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird_mg", "initLate")]]();
    return;
  }
}

function xanimlength() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("little_bird_mg", 1);
  var_0.enterstartcallback = &x1playertransition;
  var_0.enterendcallback = &x1opsunitrespawnselection;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &x1questmanager;
  var_0.reentercallback = &z_delta;
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
  var_0.exitoffsets[var_1] = (-40, 17, -45);
  var_0.exitdirections[var_1] = "left";
  var_1 = "middle_right";
  var_0.exitoffsets[var_1] = (-40, -17, -45);
  var_0.exitdirections[var_1] = "right";
  var_1 = "back";
  var_0.exitoffsets[var_1] = (-85, 0, -65);
  var_0.exitdirections[var_1] = "back";
  var_2 = ["pilot", "copilot", "br_gunner", "bl_gunner"];
  var_3 = "pilot";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird_mg", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "middle_left", "front_right", "front", "back"];
  var_0.exitoffsets[var_3] = (40, 17, -40);
  var_0.exitdirections[var_3] = "left";
  var_4.animtag = "tag_seat_0";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.spawnpriority = 10;
  var_4.ref_12023 = "ping_vehicle_pilot";
  var_3 = "bl_gunner";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird_mg", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["middle_left", "pilot", "middle_right", "front", "back"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4.viewclamps["top"] = 180;
  var_4.viewclamps["bottom"] = 180;
  var_4.viewclamps["left"] = 120;
  var_4.viewclamps["right"] = 105;
  var_4.ref_12023 = "ping_vehicle_rider";
  var_4.ref_13e92 = "tur_gun_little_bird_left_mp";
  var_3 = "copilot";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird_mg", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "middle_right", "front_right", "middle_left", "front", "back"];
  var_0.exitoffsets[var_3] = (40, -17, -40);
  var_0.exitdirections[var_3] = "right";
  var_4.viewclamps["top"] = 27;
  var_4.viewclamps["bottom"] = 42;
  var_4.viewclamps["left"] = 125;
  var_4.viewclamps["right"] = 125;
  var_4.animtag = "tag_seat_1";
  var_4.ref_12023 = "ping_vehicle_rider";
  var_3 = "br_gunner";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird_mg", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["middle_right", "front_right", "middle_left", "front", "back"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4.viewclamps["top"] = 180;
  var_4.viewclamps["bottom"] = 180;
  var_4.viewclamps["left"] = 105;
  var_4.viewclamps["right"] = 120;
  var_4.ref_12023 = "ping_vehicle_rider";
  var_4.ref_13e92 = "tur_gun_little_bird_right_mp";
}

function x1timehandler() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("little_bird_mg", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("little_bird_mg", "single", ["pilot", "copilot", "bl_gunner", "br_gunner"]);
}

function x1stash_respawn() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410f("little_bird_mg", 1);
  var_0.challengeevaluator = 1.66666;
  var_0.keycardlocs_chosen = 0.83333;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 7.5;
  var_0.isallowedweapon = 30;
  var_0.isakimbo = 60;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function xmike109() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("little_bird_mg", 1);
  var_0.brtruck_initdialog["flares"] = 1;
  var_0.id = 17;
  var_0.seatids["pilot"] = 0;
  var_0.seatids["copilot"] = 1;
  var_0.seatids["br_gunner"] = 2;
  var_0.seatids["bl_gunner"] = 3;
  var_0.ref_12da2[0] = 0;
  var_0.ref_12da2[1] = 1;
  var_0.ref_12da3["pilot"]["little_bird_mg_mp"] = 0;
  var_0.ref_12da3["pilot"]["tur_gun_little_bird_left_mp"] = 0;
  var_0.ref_12da3["pilot"]["tur_gun_little_bird_right_mp"] = 1;
  var_0.ref_12da3["copilot"]["little_bird_mg_mp"] = 0;
  var_0.ref_12da3["copilot"]["tur_gun_little_bird_left_mp"] = 0;
  var_0.ref_12da3["copilot"]["tur_gun_little_bird_right_mp"] = 1;
  var_0.ref_12da3["br_gunner"]["little_bird_mg_mp"] = 0;
  var_0.ref_12da3["br_gunner"]["tur_gun_little_bird_left_mp"] = 0;
  var_0.ref_12da3["br_gunner"]["tur_gun_little_bird_right_mp"] = 1;
  var_0.ref_12da3["bl_gunner"]["little_bird_mg_mp"] = 0;
  var_0.ref_12da3["bl_gunner"]["tur_gun_little_bird_left_mp"] = 0;
  var_0.ref_12da3["bl_gunner"]["tur_gun_little_bird_right_mp"] = 1;
}

function x1stashlootcacheused() {
  if(level.gametype == "br") {
    var_0 = 3000;
  } else {
    var_0 = 2500;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("little_bird_mg", var_0);
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("little_bird_mg");
  var_1.class = "medium_heavy";
  var_2 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d("little_bird_mg", "heavy");
  var_2.ref_12024 = &xyzoffset;
  var_2.ref_1202d = &yaw_delta;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("little_bird_mg");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("little_bird_mg", 12);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("little_bird_mg", &x1opstransbink);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("little_bird_mg_mp", 5);
}

function x1timedivision() {
  level._effect["little_bird_mg_explode"] = loadfx("vfx/iw8/prop/scriptables/vfx_vh8_mil_air_lbravo_debris.vfx");
}

function x1opsruntoicon(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh8_mil_air_lbravo_mp_flyable_mg";
  var_0.targetname = "little_bird_mg";
  var_0.vehicletype = "lbravo_physics_mp";
  var_0.cannotbesuspended = 1;
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_2.currentdestindex = gettime();
  var_2.flareslive = [];
  var_2.player_is_trying_self_revive = 1;

  if(isDefined(level.…S© ÄÛq õ Èèã7°½ ª£¢ ? Úo hç.©ï)) {
    var_2.ref_120b4 = level.…S© ÄÛq õ Èèã7°½ ª£¢ ? Úo hç.©ï;
  }

  if(level.gametype == "br") {
    var_2.player_is_pressing_attack = 35;
  } else {
    var_2.player_is_pressing_attack = 10;
  }

  var_3 = x1opsspawnnpc(var_2, "tur_gun_little_bird_right_mp", "weapon_wm_mg_dblmg_air", "tag_turret_right", (16, -11, 0));
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_3, getcompleteweaponname("tur_gun_little_bird_right_mp"));
  var_4 = x1opsspawnnpc(var_2, "tur_gun_little_bird_left_mp", "weapon_wm_mg_dblmg_air", "tag_turret_left", (16, 0, 0));
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_4, getcompleteweaponname("tur_gun_little_bird_left_mp"));
  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "little_bird_mg", var_0);
  var_2.objweapon = getcompleteweaponname("little_bird_mg_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird_mg", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird_mg", "create")]](var_2);
  }

  thread x1stash_playerdisconnect();
  thread x1opsnpc();
  return var_2;
}

function x1opsnpc() {
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
        var_9 = level.watchforhelistatus;
        break;
      case 1:
        var_9 = level.watchforlowpopmatchstart;
        break;
      case 2:
        var_9 = level.watchforjuggernautgameend;
        break;
      case 3:
        var_9 = level.watchforleapfrogpathdisconnect;
        break;
      case 4:
        var_9 = level.watchforjuggernautdisconnect;
        break;
    }

    var_10 = var_6 * var_9;
    var_11 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

    if(!isDefined(var_11)) {
      var_10 *= level.watchforexfilallyturntoside;
    }

    var_12 = self.angles[0];

    if(var_12 > 180) {
      var_12 -= 360;
    }

    if(abs(var_12 > level.watchforplayertouchingwater)) {
      var_10 *= level.watchforpayloadtriggersuperwave;
    }

    var_13 = self.angles[2];

    if(var_13 > 180) {
      var_13 -= 360;
    }

    if(abs(var_13 > level.watchforplayertouchingwater)) {
      var_10 *= level.watchforpayloadtriggersuperwave;
    }

    var_14 = 0;

    if(var_10 > level.watchforpayloadstage) {
      var_14 = self.maxhealth;
    } else if(var_10 > level.watchfornewdrop) {
      var_15 = level.watchforpayloadstage - level.watchfornewdrop;
      var_16 = (var_10 - level.watchfornewdrop) / var_15;
      var_17 = self.maxhealth * level.watchfornagstootherplayers;
      var_18 = self.maxhealth * level.watchformoralesunderfire;
      var_14 = scripts\engine\math::lerp(var_17, var_18, var_16);
    } else if(var_10 > level.watchfornearmisswhizby) {
      var_14 = self.maxhealth * level.watchformoralespickedup;
    }

    if(var_14 > 0) {
      if(isDefined(var_11) && var_3 == 11534336) {
        var_14 *= level.watchforscriptabledoorsinradius;
      }

      scripts\cp_mp\vehicles\vehicle_damage::ref_14143(1);
      self dodamage(var_14, var_4, undefined, undefined, "MOD_CRUSH");
      scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
    }

    wait 0.5;
  }
}

function x1opsspawnnpc(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnturret("misc_turret", var_0 gettagorigin(var_3), var_1, 0);
  var_5 linkTo(var_0, var_3, var_4, (0, 0, 0));
  var_5 setModel(var_2);
  var_5 setmode("sentry_offline");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 setturretmodechangewait(1);
  var_5 hidepart("tag_scope");
  var_5 hidepart("tag_glass_hip");
  var_5 hidepart("tag_red_dot_stencil");
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  var_5.maxhealth = 999999;
  var_5.health = var_5.maxhealth;
  return var_5;
}

function x1spyplane(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "little_bird_mg_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(!istrue(level.suppressvehicleexplosion)) {
    self notify("predeath");
    wait 0.2;
  }

  if(!isDefined(self)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);

  if(!istrue(level.suppressvehicleexplosion)) {
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread x1opstransition();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_detach");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "little_bird_mg_mp");
    playFX(scripts\engine\utility::getfx("little_bird_mg_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "veh_lbravo_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function x1opstransition() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird_mg", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird_mg", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function x1opstransbink(var_0) {
  thread x1spyplane(var_0);
  return true;
}

function xyzoffset(var_0, var_1) {
  self setscriptablepartstate("alarm", "engineFailure", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var_0, var_1);
}

function yaw_delta(var_0, var_1) {
  self setscriptablepartstate("alarm", "off", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var_0, var_1);
}

function x1playertransition(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3.javelin)) {
    if(isDefined(var_3.javelin.state) && var_3.javelin.state != "off" || isDefined(var_3.javelin.target) || isDefined(var_3.javelin.groundlockonent)) {
      var_4.success = 0;
      return;
    }
  }

  var_3 skydive_setbasejumpingstatus(0);
  var_3 skydive_setdeploymentstatus(0);

  if(isDefined(var_2)) {
    if(var_2 == "br_gunner") {
      scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var_3, var_4);
      z_below_check(var_0, var_3, var_4, "tur_gun_little_bird_right_mp", var_2, var_1);
    } else if(var_2 == "bl_gunner") {
      scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var_3, var_4);
      z_below_check(var_0, var_3, var_4, "tur_gun_little_bird_left_mp", var_2, var_1);
    } else if(var_1 == "bl_gunner" || var_1 == "br_gunner") {
      scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var_3, var_4);
    }
  }

  if(var_1 == "br_gunner") {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "tur_gun_little_bird_right_mp", var_4, 1);
  } else if(var_1 == "bl_gunner") {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "tur_gun_little_bird_left_mp", var_4, 1);
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

function x1opsunitrespawnselection(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    var_3 scripts\cp_mp\parachute::ref_121ca();
    x1playerspawnoverride(var_0, var_1, var_2, var_3, var_4);
  }

  if(!istrue(level.client_activate)) {
    var_3 skydive_setbasejumpingstatus(1);
    var_3 skydive_setdeploymentstatus(1);
    return;
  }
}

function x1playerspawnoverride(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2)) {
    var_7 = var_2 == "bl_gunner" || var_2 == "br_gunner";
    var_8 = var_1 != "bl_gunner" && var_1 != "br_gunner";

    if(var_7 && var_8) {
      var_5 = "lbravo_physics_mp";
      var_6 = 7;
    }
  }

  if(var_1 == "pilot") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
    thread x1stash_ontimerexpired(var_0);
  } else if(var_1 == "br_gunner") {
    yaw_updater(var_0, var_3, "tur_gun_little_bird_right_mp");
  } else if(var_1 == "bl_gunner") {
    yaw_updater(var_0, var_3, "tur_gun_little_bird_left_mp");
  } else {
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6(var_4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird_mg", "endEnterInternal", 0)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird_mg", "endEnterInternal")]](var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function yaw_updater(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_2);
  var_3.owner = var_1;
  var_3 setotherent(var_1);
  var_3 setentityowner(var_1);
  var_3 setsentryowner(var_1);
  var_1 disableturretdismount();
  var_1 controlturreton(var_3);
}

function x1questmanager(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    x1spawnlocationoverride(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function x1spawnlocationoverride(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "pilot") {
    var_0 notify("little_bird_driver_exit");
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 controlsunlink();
    }
  }

  var_5 = !isDefined(var_2);
  var_6 = 0;

  if(isDefined(var_3)) {
    var_6 = var_3 hasweapon("tur_gun_little_bird_right_mp");
  }

  var_7 = 0;

  if(isDefined(var_3)) {
    var_7 = var_3 hasweapon("tur_gun_little_bird_left_mp");
  }

  if(var_1 == "br_gunner" || var_5 && var_6) {
    z_below_check(var_0, var_3, var_4, "tur_gun_little_bird_right_mp", var_1, var_2);
  }

  if(var_1 == "bl_gunner" || var_5 && var_7) {
    z_below_check(var_0, var_3, var_4, "tur_gun_little_bird_left_mp", var_1, var_2);
  }

  if(!istrue(var_4.playerdisconnect)) {
    if(istrue(var_4.playerdeath)) {
      var_3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();
    }

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_8) {
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

function z_below_check(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_3);

  if(!istrue(var_2.playerdisconnect)) {
    var_1 enableturretdismount();
    var_1 controlturretoff(var_6);

    if(!istrue(var_2.playerdeath)) {
      thread zlimit(var_1, var_0, var_2, var_3, 1, var_4);
    }
  }

  var_6.owner = undefined;
  var_6 setotherent(undefined);
  var_6 setentityowner(undefined);
  var_6 setsentryowner(undefined);
}

function z_delta(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6(var_4);
  thread zdrop(var_0, var_1, var_2, var_3, var_4);
}

function zdrop(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.watchforteammaterevivedwhilereviving)) {
    level.watchforteammaterevivedwhilereviving = getdvarint("scr_lbmgTakeTurretOnReenter", 1) > 0;
  }

  if(level.watchforteammaterevivedwhilereviving) {
    var_4.raceendon = "turretGiveTakeTimeout";
    var_4.raceendnotify = "turretGiveTakeTimeout";
    var_4.success = 1;

    if(isDefined(var_2)) {
      if(var_2 == "br_gunner") {
        var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var_3, var_4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "tur_gun_little_bird_right_mp", var_4, 1);

        if(!var_4.success && isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
          var_3 suicide();
        }

        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var_5);
      } else if(var_2 == "bl_gunner") {
        var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var_3, var_4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "tur_gun_little_bird_left_mp", var_4, 1);

        if(!var_4.success && isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
          var_3 suicide();
        }

        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var_5);
      }
    }

    if(isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
      if(var_1 == "br_gunner") {
        var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var_3, var_4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "tur_gun_little_bird_right_mp", var_4, 1);

        if(!var_4.success && isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
          var_3 suicide();
        } else {
          yaw_updater(var_0, var_3, "tur_gun_little_bird_right_mp");
        }

        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var_5);
        return;
      }

      if(var_1 == "bl_gunner") {
        var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var_3, var_4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "tur_gun_little_bird_left_mp", var_4, 1);

        if(!var_4.success && isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
          var_3 suicide();
        } else {
          yaw_updater(var_0, var_3, "tur_gun_little_bird_left_mp");
        }

        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var_5);
        return;
      }

      return;
    }

    return;
  }
}

function zlimit(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1.raceendon)) {
    var_1 endon(var_1.raceendon);
  }

  if(istrue(var_3)) {
    GscBinSkip4(0x35, var_1, 1.5);
  }

  var_6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_2);
  var_7 = undefined;

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_2)) {
    var_8 = getcompleteweaponname(var_2);
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_8);
    var_7 = 1;
  } else {
    self controlturretoff(var_6);

    if(self hasweapon(var_2)) {
      var_9 = scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_2);

      if(var_9) {
        scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);

        if(!ref_13324(self, var_4, var_5)) {
          thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
        }
      } else {
        thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2, 1);
      }
    }

    var_7 = 1;
  }

  if(isDefined(var_7) && !var_7) {
    var_1.success = 0;
    var_1 notify(var_1.raceendnotify);
    return;
  }
}

function ref_13324(var_0, var_1, var_2) {
  if(istrue(var_0.isjuggernaut)) {
    if(isDefined(var_1) && var_1 == "br_gunner" && isDefined(var_2) && var_2 == "bl_gunner") {
      return true;
    }

    if(isDefined(var_1) && var_1 == "bl_gunner" && isDefined(var_2) && var_2 == "br_gunner") {
      return true;
    }
  }

  return false;
}

function x1stash_entergulag(var_0, var_1) {
  wait var_1;
  var_0.success = 0;
  var_0 notify(var_0.raceendnotify);
}

function x1stash_playerdisconnect() {
  self endon("death");

  for(;;) {
    if(!self.player_is_trying_self_revive) {
      wait self.player_is_pressing_attack;
      self.player_is_trying_self_revive = 1;
      var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

      if(isDefined(var_0)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird_mg", "flares", 1, var_0);
      }
    }

    waitframe();
  }
}

function x1stash_ontimerexpired(var_0) {
  self endon("death");
  self endon("little_bird_driver_exit");
  var_0 endon("death_or_disconnect");
  var_0 endon("vehicle_exit");
  var_0 notifyonplayercommand("shoot_flare", "+attack");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird_mg", "flares", scripts\engine\utility::ter_op(self.player_is_trying_self_revive, 1, 0), var_0);

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
        if(!isDefined(var_3.ref_119a0) || var_3.ref_119a0 != self) {
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
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird_mg", "flares", 0, var_0);
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d2(var_0);
  }
}

function xmike109projectiles() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("little_bird_mg", 1);
  var_0.maxinstancecount = 5;
  var_0.priority = 100;
  var_0.getspawnstructscallback = &x1stash_detectplayers;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird_mg", "spawnCallback");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 100;
  var_0.clearancecheckoffsetz = -100;
  var_0.clearancecheckminradius = 185;
}

function x1stash_detectplayers() {
  var_0 = scripts\engine\utility::getStructArray("littlebird_mg_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}