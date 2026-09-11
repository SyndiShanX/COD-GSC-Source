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
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("little_bird_mg", 1);
  var0.destroycallback = &x1spyplane;
  var0.canfly = 1;
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
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("little_bird_mg", 1);
  var0.enterstartcallback = &x1playertransition;
  var0.enterendcallback = &x1opsunitrespawnselection;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &x1questmanager;
  var0.reentercallback = &z_delta;
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
  var0.exitoffsets[var1] = (-40, 17, -45);
  var0.exitdirections[var1] = "left";
  var1 = "middle_right";
  var0.exitoffsets[var1] = (-40, -17, -45);
  var0.exitdirections[var1] = "right";
  var1 = "back";
  var0.exitoffsets[var1] = (-85, 0, -65);
  var0.exitdirections[var1] = "back";
  var2 = ["pilot", "copilot", "br_gunner", "bl_gunner"];
  var3 = "pilot";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird_mg", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "middle_left", "front_right", "front", "back"];
  var0.exitoffsets[var3] = (40, 17, -40);
  var0.exitdirections[var3] = "left";
  var4.animtag = "tag_seat_0";
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var4.spawnpriority = 10;
  var4.ref_12023 = "ping_vehicle_pilot";
  var3 = "bl_gunner";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird_mg", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["middle_left", "pilot", "middle_right", "front", "back"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var4.viewclamps["top"] = 180;
  var4.viewclamps["bottom"] = 180;
  var4.viewclamps["left"] = 120;
  var4.viewclamps["right"] = 105;
  var4.ref_12023 = "ping_vehicle_rider";
  var4.ref_13e92 = "tur_gun_little_bird_left_mp";
  var3 = "copilot";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird_mg", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = [var3, "middle_right", "front_right", "middle_left", "front", "back"];
  var0.exitoffsets[var3] = (40, -17, -40);
  var0.exitdirections[var3] = "right";
  var4.viewclamps["top"] = 27;
  var4.viewclamps["bottom"] = 42;
  var4.viewclamps["left"] = 125;
  var4.viewclamps["right"] = 125;
  var4.animtag = "tag_seat_1";
  var4.ref_12023 = "ping_vehicle_rider";
  var3 = "br_gunner";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("little_bird_mg", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["middle_right", "front_right", "middle_left", "front", "back"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var4.viewclamps["top"] = 180;
  var4.viewclamps["bottom"] = 180;
  var4.viewclamps["left"] = 105;
  var4.viewclamps["right"] = 120;
  var4.ref_12023 = "ping_vehicle_rider";
  var4.ref_13e92 = "tur_gun_little_bird_right_mp";
}

function x1timehandler() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("little_bird_mg", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("little_bird_mg", "single", ["pilot", "copilot", "bl_gunner", "br_gunner"]);
}

function x1stash_respawn() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("little_bird_mg", 1);
  var0.challengeevaluator = 1.66666;
  var0.keycardlocs_chosen = 0.83333;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 7.5;
  var0.isallowedweapon = 30;
  var0.isakimbo = 60;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function xmike109() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("little_bird_mg", 1);
  var0.brtruck_initdialog["flares"] = 1;
  var0.id = 17;
  var0.seatids["pilot"] = 0;
  var0.seatids["copilot"] = 1;
  var0.seatids["br_gunner"] = 2;
  var0.seatids["bl_gunner"] = 3;
  var0.ref_12da2[0] = 0;
  var0.ref_12da2[1] = 1;
  var0.ref_12da3["pilot"]["little_bird_mg_mp"] = 0;
  var0.ref_12da3["pilot"]["tur_gun_little_bird_left_mp"] = 0;
  var0.ref_12da3["pilot"]["tur_gun_little_bird_right_mp"] = 1;
  var0.ref_12da3["copilot"]["little_bird_mg_mp"] = 0;
  var0.ref_12da3["copilot"]["tur_gun_little_bird_left_mp"] = 0;
  var0.ref_12da3["copilot"]["tur_gun_little_bird_right_mp"] = 1;
  var0.ref_12da3["br_gunner"]["little_bird_mg_mp"] = 0;
  var0.ref_12da3["br_gunner"]["tur_gun_little_bird_left_mp"] = 0;
  var0.ref_12da3["br_gunner"]["tur_gun_little_bird_right_mp"] = 1;
  var0.ref_12da3["bl_gunner"]["little_bird_mg_mp"] = 0;
  var0.ref_12da3["bl_gunner"]["tur_gun_little_bird_left_mp"] = 0;
  var0.ref_12da3["bl_gunner"]["tur_gun_little_bird_right_mp"] = 1;
}

function x1stashlootcacheused() {
  if(level.gametype == "br") {
    var0 = 3000;
  } else {
    var0 = 2500;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("little_bird_mg", var0);
  var1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("little_bird_mg");
  var1.class = "medium_heavy";
  var2 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d("little_bird_mg", "heavy");
  var2.ref_12024 = &xyzoffset;
  var2.ref_1202d = &yaw_delta;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("little_bird_mg");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("little_bird_mg", 12);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("little_bird_mg", &x1opstransbink);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("little_bird_mg_mp", 5);
}

function x1timedivision() {
  level._effect["little_bird_mg_explode"] = loadfx("vfx/iw8/prop/scriptables/vfx_vh8_mil_air_lbravo_debris.vfx");
}

function x1opsruntoicon(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh8_mil_air_lbravo_mp_flyable_mg";
  var0.targetname = "little_bird_mg";
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

  var3 = x1opsspawnnpc(var2, "tur_gun_little_bird_right_mp", "weapon_wm_mg_dblmg_air", "tag_turret_right", (16, -11, 0));
  scripts\cp_mp\vehicles\vehicle::ref_14207(var2, var3, getcompleteweaponname("tur_gun_little_bird_right_mp"));
  var4 = x1opsspawnnpc(var2, "tur_gun_little_bird_left_mp", "weapon_wm_mg_dblmg_air", "tag_turret_left", (16, 0, 0));
  scripts\cp_mp\vehicles\vehicle::ref_14207(var2, var4, getcompleteweaponname("tur_gun_little_bird_left_mp"));
  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "little_bird_mg", var0);
  var2.objweapon = getcompleteweaponname("little_bird_mg_mp");
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird_mg", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird_mg", "create")]](var2);
  }

  thread x1stash_playerdisconnect();
  thread x1opsnpc();
  return var2;
}

function x1opsnpc() {
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
        var9 = level.watchforhelistatus;
        break;
      case 1:
        var9 = level.watchforlowpopmatchstart;
        break;
      case 2:
        var9 = level.watchforjuggernautgameend;
        break;
      case 3:
        var9 = level.watchforleapfrogpathdisconnect;
        break;
      case 4:
        var9 = level.watchforjuggernautdisconnect;
        break;
    }

    var10 = var6 * var9;
    var11 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

    if(!isDefined(var11)) {
      var10 *= level.watchforexfilallyturntoside;
    }

    var12 = self.angles[0];

    if(var12 > 180) {
      var12 -= 360;
    }

    if(abs(var12 > level.watchforplayertouchingwater)) {
      var10 *= level.watchforpayloadtriggersuperwave;
    }

    var13 = self.angles[2];

    if(var13 > 180) {
      var13 -= 360;
    }

    if(abs(var13 > level.watchforplayertouchingwater)) {
      var10 *= level.watchforpayloadtriggersuperwave;
    }

    var14 = 0;

    if(var10 > level.watchforpayloadstage) {
      var14 = self.maxhealth;
    } else if(var10 > level.watchfornewdrop) {
      var15 = level.watchforpayloadstage - level.watchfornewdrop;
      var16 = (var10 - level.watchfornewdrop) / var15;
      var17 = self.maxhealth * level.watchfornagstootherplayers;
      var18 = self.maxhealth * level.watchformoralesunderfire;
      var14 = scripts\engine\math::lerp(var17, var18, var16);
    } else if(var10 > level.watchfornearmisswhizby) {
      var14 = self.maxhealth * level.watchformoralespickedup;
    }

    if(var14 > 0) {
      if(isDefined(var11) && var3 == 11534336) {
        var14 *= level.watchforscriptabledoorsinradius;
      }

      scripts\cp_mp\vehicles\vehicle_damage::ref_14143(1);
      self dodamage(var14, var4, undefined, undefined, "MOD_CRUSH");
      scripts\cp_mp\vehicles\vehicle_damage::ref_14143(0);
    }

    wait 0.5;
  }
}

function x1opsspawnnpc(var0, var1, var2, var3, var4) {
  var5 = spawnturret("misc_turret", var0 gettagorigin(var3), var1, 0);
  var5 linkTo(var0, var3, var4, (0, 0, 0));
  var5 setModel(var2);
  var5 setmode("sentry_offline");
  var5 setsentryowner(undefined);
  var5 makeunusable();
  var5 setdefaultdroppitch(0);
  var5 setturretmodechangewait(1);
  var5 hidepart("tag_scope");
  var5 hidepart("tag_glass_hip");
  var5 hidepart("tag_red_dot_stencil");
  var5.angles = var0.angles;
  var5.vehicle = var0;
  var5.maxhealth = 999999;
  var5.health = var5.maxhealth;
  return var5;
}

function x1spyplane(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "little_bird_mg_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(!istrue(level.suppressvehicleexplosion)) {
    self notify("predeath");
    wait 0.2;
  }

  if(!isDefined(self)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);

  if(!istrue(level.suppressvehicleexplosion)) {
    waitframe();
  }

  if(!isDefined(self)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread x1opstransition();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_detach");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker) && isent(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 140, 70, var3, "MOD_EXPLOSIVE", "little_bird_mg_mp");
    playFX(scripts\engine\utility::getfx("little_bird_mg_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "veh_lbravo_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
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

function x1opstransbink(var0) {
  thread x1spyplane(var0);
  return true;
}

function xyzoffset(var0, var1) {
  self setscriptablepartstate("alarm", "engineFailure", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var0, var1);
}

function yaw_delta(var0, var1) {
  self setscriptablepartstate("alarm", "off", 0);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var0, var1);
}

function x1playertransition(var0, var1, var2, var3, var4) {
  if(isDefined(var3.javelin)) {
    if(isDefined(var3.javelin.state) && var3.javelin.state != "off" || isDefined(var3.javelin.target) || isDefined(var3.javelin.groundlockonent)) {
      var4.success = 0;
      return;
    }
  }

  var3 skydive_setbasejumpingstatus(0);
  var3 skydive_setdeploymentstatus(0);

  if(isDefined(var2)) {
    if(var2 == "br_gunner") {
      scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
      z_below_check(var0, var3, var4, "tur_gun_little_bird_right_mp", var2, var1);
    } else if(var2 == "bl_gunner") {
      scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
      z_below_check(var0, var3, var4, "tur_gun_little_bird_left_mp", var2, var1);
    } else if(var1 == "bl_gunner" || var1 == "br_gunner") {
      scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
    }
  }

  if(var1 == "br_gunner") {
    var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var3, "tur_gun_little_bird_right_mp", var4, 1);
  } else if(var1 == "bl_gunner") {
    var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var3, "tur_gun_little_bird_left_mp", var4, 1);
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

function x1opsunitrespawnselection(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    var3 scripts\cp_mp\parachute::ref_121ca();
    x1playerspawnoverride(var0, var1, var2, var3, var4);
  }

  if(!istrue(level.client_activate)) {
    var3 skydive_setbasejumpingstatus(1);
    var3 skydive_setdeploymentstatus(1);
    return;
  }
}

function x1playerspawnoverride(var0, var1, var2, var3, var4) {
  var5 = undefined;
  var6 = undefined;

  if(isDefined(var2)) {
    var7 = var2 == "bl_gunner" || var2 == "br_gunner";
    var8 = var1 != "bl_gunner" && var1 != "br_gunner";

    if(var7 && var8) {
      var5 = "lbravo_physics_mp";
      var6 = 7;
    }
  }

  if(var1 == "pilot") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);
    var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2, undefined, var5, var6);
    thread x1stash_ontimerexpired(var0);
  } else if(var1 == "br_gunner") {
    yaw_updater(var0, var3, "tur_gun_little_bird_right_mp");
  } else if(var1 == "bl_gunner") {
    yaw_updater(var0, var3, "tur_gun_little_bird_left_mp");
  } else {
    var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2, undefined, var5, var6);
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6(var4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("little_bird_mg", "endEnterInternal", 0)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird_mg", "endEnterInternal")]](var0, var1, var2, var3, var4);
    return;
  }
}

function yaw_updater(var0, var1, var2) {
  var3 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, var2);
  var3.owner = var1;
  var3 setotherent(var1);
  var3 setentityowner(var1);
  var3 setsentryowner(var1);
  var1 disableturretdismount();
  var1 controlturreton(var3);
}

function x1questmanager(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    x1spawnlocationoverride(var0, var1, var2, var3, var4);
    return;
  }
}

function x1spawnlocationoverride(var0, var1, var2, var3, var4) {
  if(var1 == "pilot") {
    var0 notify("little_bird_driver_exit");
    var0 setotherent(undefined);
    var0 setentityowner(undefined);

    if(!istrue(var4.playerdisconnect)) {
      var3 controlsunlink();
    }
  }

  var5 = !isDefined(var2);
  var6 = 0;

  if(isDefined(var3)) {
    var6 = var3 hasweapon("tur_gun_little_bird_right_mp");
  }

  var7 = 0;

  if(isDefined(var3)) {
    var7 = var3 hasweapon("tur_gun_little_bird_left_mp");
  }

  if(var1 == "br_gunner" || var5 && var6) {
    z_below_check(var0, var3, var4, "tur_gun_little_bird_right_mp", var1, var2);
  }

  if(var1 == "bl_gunner" || var5 && var7) {
    z_below_check(var0, var3, var4, "tur_gun_little_bird_left_mp", var1, var2);
  }

  if(!istrue(var4.playerdisconnect)) {
    if(istrue(var4.playerdeath)) {
      var3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();
    }

    var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var3, var2, var4);

    if(!var8) {
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

function z_below_check(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, var3);

  if(!istrue(var2.playerdisconnect)) {
    var1 enableturretdismount();
    var1 controlturretoff(var6);

    if(!istrue(var2.playerdeath)) {
      thread zlimit(var1, var0, var2, var3, 1, var4);
    }
  }

  var6.owner = undefined;
  var6 setotherent(undefined);
  var6 setentityowner(undefined);
  var6 setsentryowner(undefined);
}

function z_delta(var0, var1, var2, var3, var4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6(var4);
  thread zdrop(var0, var1, var2, var3, var4);
}

function zdrop(var0, var1, var2, var3, var4) {
  if(!isDefined(level.watchforteammaterevivedwhilereviving)) {
    level.watchforteammaterevivedwhilereviving = getdvarint("scr_lbmgTakeTurretOnReenter", 1) > 0;
  }

  if(level.watchforteammaterevivedwhilereviving) {
    var4.raceendon = "turretGiveTakeTimeout";
    var4.raceendnotify = "turretGiveTakeTimeout";
    var4.success = 1;

    if(isDefined(var2)) {
      if(var2 == "br_gunner") {
        var5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, "tur_gun_little_bird_right_mp", var4, 1);

        if(!var4.success && isDefined(var3) && var3 scripts\cp_mp\utility\player_utility::_isalive()) {
          var3 suicide();
        }

        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var5);
      } else if(var2 == "bl_gunner") {
        var5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, "tur_gun_little_bird_left_mp", var4, 1);

        if(!var4.success && isDefined(var3) && var3 scripts\cp_mp\utility\player_utility::_isalive()) {
          var3 suicide();
        }

        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var5);
      }
    }

    if(isDefined(var3) && var3 scripts\cp_mp\utility\player_utility::_isalive()) {
      if(var1 == "br_gunner") {
        var5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var3, "tur_gun_little_bird_right_mp", var4, 1);

        if(!var4.success && isDefined(var3) && var3 scripts\cp_mp\utility\player_utility::_isalive()) {
          var3 suicide();
        } else {
          yaw_updater(var0, var3, "tur_gun_little_bird_right_mp");
        }

        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var5);
        return;
      }

      if(var1 == "bl_gunner") {
        var5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var3, "tur_gun_little_bird_left_mp", var4, 1);

        if(!var4.success && isDefined(var3) && var3 scripts\cp_mp\utility\player_utility::_isalive()) {
          var3 suicide();
        } else {
          yaw_updater(var0, var3, "tur_gun_little_bird_left_mp");
        }

        scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var5);
        return;
      }

      return;
    }

    return;
  }
}

function zlimit(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var1.raceendon)) {
    var1 endon(var1.raceendon);
  }

  if(istrue(var3)) {
    GscBinSkip4(0x35, var1, 1.5);
  }

  var6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, var2);
  var7 = undefined;

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var2)) {
    var8 = getcompleteweaponname(var2);
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var8);
    var7 = 1;
  } else {
    self controlturretoff(var6);

    if(self hasweapon(var2)) {
      var9 = scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var2);

      if(var9) {
        scripts\cp_mp\utility\inventory_utility::_takeweapon(var2);

        if(!ref_13324(self, var4, var5)) {
          thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
        }
      } else {
        thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var2, 1);
      }
    }

    var7 = 1;
  }

  if(isDefined(var7) && !var7) {
    var1.success = 0;
    var1 notify(var1.raceendnotify);
    return;
  }
}

function ref_13324(var0, var1, var2) {
  if(istrue(var0.isjuggernaut)) {
    if(isDefined(var1) && var1 == "br_gunner" && isDefined(var2) && var2 == "bl_gunner") {
      return true;
    }

    if(isDefined(var1) && var1 == "bl_gunner" && isDefined(var2) && var2 == "br_gunner") {
      return true;
    }
  }

  return false;
}

function x1stash_entergulag(var0, var1) {
  wait var1;
  var0.success = 0;
  var0 notify(var0.raceendnotify);
}

function x1stash_playerdisconnect() {
  self endon("death");

  for(;;) {
    if(!self.player_is_trying_self_revive) {
      wait self.player_is_pressing_attack;
      self.player_is_trying_self_revive = 1;
      var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

      if(isDefined(var0)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird_mg", "flares", 1, var0);
      }
    }

    waitframe();
  }
}

function x1stash_ontimerexpired(var0) {
  self endon("death");
  self endon("little_bird_driver_exit");
  var0 endon("death_or_disconnect");
  var0 endon("vehicle_exit");
  var0 notifyonplayercommand("shoot_flare", "+attack");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird_mg", "flares", scripts\engine\utility::ter_op(self.player_is_trying_self_revive, 1, 0), var0);

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
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("little_bird_mg", "flares", 0, var0);
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d2(var0);
  }
}

function xmike109projectiles() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("little_bird_mg", 1);
  var0.maxinstancecount = 5;
  var0.priority = 100;
  var0.getspawnstructscallback = &x1stash_detectplayers;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("little_bird_mg", "spawnCallback");
  var0.clearancecheckradius = 185;
  var0.clearancecheckheight = 100;
  var0.clearancecheckoffsetz = -100;
  var0.clearancecheckminradius = 185;
}

function x1stash_detectplayers() {
  var0 = scripts\engine\utility::getStructArray("littlebird_mg_spawn", "targetname");

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}