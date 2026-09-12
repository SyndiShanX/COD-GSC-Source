/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58235.gsc
***********************************************/

function startarmsracedef2obj() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_indigo", 1);
  var_0.destroycallback = &start_trap_room_combat;
  var_0.ref_13E92 = "tur_gun_indigo_mp";
  startchallengetimer();
  startbluntwatchvfx();
  startcheck();
  startarmsracedef4obj();
  startarmsracedef3obj();
  startarmsraceopencrateobj();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_indigo", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_indigo", "init")]]();
  }

  startdeadsilence();
  level.stealth_alert_music = getdvarint("scr_br_indigo_start_in_the_air", 0);
  level.startmatchobjectiveicons = getdvarint("scr_br_indigo_drop_bomb_ammo", 1);
  level.staytoasty = getdvarint("scr_br_indigo_speed_no_damage", 75);
  level.stayfrosty = getdvarint("scr_br_indigo_speed_little_damage", 115);
  level.startpayloadexfilobjective = getdvarfloat("scr_br_indigo_gunner_time_between_bullets", 0.1);
  level.startofxptime = getdvarint("scr_br_indigo_enable_sonar", 1);
  level.stay_on_roof_until_bothered = getdvarint("scr_br_indigo_sonar_scan_angle", 30);
  level.stay_on_roof_until_bothered_internal = getdvarint("scr_br_indigo_sonar_scan_range", 8000);
  level.starttmtylapproach = getdvarfloat("scr_br_indigo_pitch_collision_value", 20);
  level.startusingbomb = getdvarfloat("scr_br_indigo_roll_collision_value", 20);
  level.startpropcirclelogic = getdvarint("scr_br_indigo_contrails_min_speed", 70);
  level.start_spawn_camera = getdvarfloat("scr_indigo_dmg_factor_fuselage", 1);
  level.start_swivelroom_obj = getdvarfloat("scr_indigo_dmg_factor_tail_stabilizer", 1);
  level.start_static_klaxon_lights = getdvarfloat("scr_indigo_dmg_factor_main_rotor", 1.2);
  level.start_static_plane_lights = getdvarfloat("scr_indigo_dmg_factor_tail_rotor", 1);
  level.start_spawn_modules = getdvarfloat("scr_indigo_dmg_factor_landing_gear", 0.5);
  level.start_solution_check_timer = getdvarfloat("scr_indigo_dmg_factor_driverless_collision", 10);
  level.startarmsracedef1obj = getdvarfloat("scr_indigo_impulse_dmg_threshold_high", 0.9);
  level.startarmsraceapproachobj = getdvarfloat("scr_indigo_impulse_dmg_threshold_mid", 0.9);
  level.startarmoryswitchbeeping = getdvarfloat("scr_indigo_impulse_dmg_threshold_low", 0.1);
  level.start_whack_a_mole_sequence = getdvarfloat("scr_indigo_impulse_dmg_factor_low", 0.1);
  level.start_with_nvgs = getdvarfloat("scr_indigo_impulse_dmg_factor_mid_low", 0.2);
  level.start_whack_a_mole_timer = getdvarfloat("scr_indigo_impulse_dmg_factor_mid_high", 0.75);
  level.starting_area_init = getdvarfloat("scr_indigo_dmg_pitch_roll_threshold", 55);
  level.startimes = getdvarfloat("scr_indigo_dmg_pitch_roll_factor", 10);
  level.startingteamcount = getdvarfloat("scr_indigo_wood_surf_dmg_scalar", 0.6);
  startbmoexfilprocess();
}

function startbmoexfilprocess() {
  thread ref_1327D();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_indigo", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_indigo", "initLate")]]();
  }

  level._effect["indigo_bomb_explode"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_indigo_exp.vfx");
}

function startchallengetimer() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("veh_indigo", 1);
  var_0.enterstartcallback = &start_timer;
  var_0.enterendcallback = &start_target_move_loop;
  var_0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = &start_trans_1_obj;
  var_0.reentercallback = &starting_struct;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["front"] = 175;
  var_0.exitextents["back"] = 180;
  var_0.exitextents["left"] = 68;
  var_0.exitextents["right"] = 68;
  var_0.exitextents["top"] = 138;
  var_0.exitextents["bottom"] = 0;
  var_0.allowairexit = 1;
  var_1 = "back_left";
  var_0.exitoffsets[var_1] = (-130, 70, -45);
  var_0.exitdirections[var_1] = "left";
  var_1 = "back_right";
  var_0.exitoffsets[var_1] = (-130, -70, -45);
  var_0.exitdirections[var_1] = "right";
  var_1 = "back";
  var_0.exitoffsets[var_1] = (-255, 0, -45);
  var_0.exitdirections[var_1] = "back";
  var_2 = ["pilot", "gunner"];
  var_3 = "pilot";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("veh_indigo", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["back_left", "back_right", "back"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141D8();
  var_4.ref_13E8A = getcompleteweaponname("tur_gun_indigo_mp");
  var_4.animtag = "tag_seat_0";
  var_4.ref_12023 = "ping_vehicle_pilot";
  var_3 = "gunner";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("veh_indigo", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["back_left", "back_right", "back"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getpassivepassengerrestrictions();
  var_4.animtag = "tag_seat_2";
  var_4.ref_12023 = "ping_vehicle_gunner";
}

function startbluntwatchvfx() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("veh_indigo", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419D("veh_indigo", "single", ["pilot", "gunner"]);
}

function startcheck() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427E("veh_indigo", 1);
  var_0.id = 27;
  var_0.seatids["pilot"] = 0;
  var_0.seatids["gunner"] = 1;
  var_0.ref_12DA2[0] = 0;
  var_0.ref_12DA2[1] = 1;
  var_0.ref_12DA3["pilot"]["little_bird_mp"] = 0;
  var_0.ref_12DA3["pilot"]["tur_gun_indigo_mp"] = 1;
  var_0.ref_12DA3["gunner"]["little_bird_mp"] = 0;
  var_0.ref_12DA3["gunner"]["tur_gun_indigo_mp"] = 1;
}

function startarmsracedef4obj() {
  level.startplunderextractiontimers = getdvarfloat("scr_br_indigo_health_override", 3950);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416C("veh_indigo", level.startplunderextractiontimers, undefined, undefined, undefined, 8);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("veh_indigo");
  var_0.class = "heavy";
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414D("veh_indigo", "heavy");
  var_1.ref_12024 = &starthacktimer;
  var_1.ref_1202D = &startholowatchvfx;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413D("veh_indigo");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("veh_indigo", 17);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("veh_indigo", &starting_boxes);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("veh_indigo", &start_silo_thrust_menu);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14173("veh_indigo", "pilot", getdvarfloat("indigo_occupant_damage_scale", 0.7));
  scripts\cp_mp\vehicles\vehicle_damage::ref_14172("veh_indigo", "pilot", getdvarfloat("indigo_occupant_damage_clamp", 15));
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417B("little_bird_mp", 5);
}

function startarmsracedef3obj() {
  var_0 = _calloutmarkerping_predicted_log::ref_1410F("veh_indigo", 1);
  var_0.challengeevaluator = 2;
  var_0.keycardlocs_chosen = 0.75;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 5;
  var_0.isallowedweapon = 20;
  var_0.isakimbo = 40;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

function startarmsraceopencrateobj() {
  level._effect["indigo_explode"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_indigo_death_exp_ground");
}

function start_vault_assault_retrieve_saw() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_indigo");
  return var_0.ref_13E92;
}

function start_silo_jump_menu(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh_s4_mil_air_aindigo_wz";
  var_0.targetname = "veh_indigo";

  if(!isDefined(var_0.vehicletype)) {
    var_0.vehicletype = "indigo_mp";
  }

  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = start_vault_assault_retrieve_saw();
  var_4 = start_unstable_rocket_fuel_timer();
  var_5 = start_silo_thrust(var_2, var_3, "veh_s4_mil_air_aindigo_wz_turret_attach", var_4.tag, var_4.tagoffset);
  scripts\cp_mp\vehicles\vehicle::ref_14207(var_2, var_5, getcompleteweaponname(var_3));
  scripts\cp_mp\vehicles\vehicle::ref_14138(var_2, "veh_indigo", var_0);
  var_2.objweapon = getcompleteweaponname("little_bird_mp");
  var_2.ref_13E92 = var_3;
  var_2.ref_11B7B = 3;
  var_2.minigunbackup = level.startmatchobjectiveicons;
  var_2.shouldmodeplayfinalmoments = 0;
  thread startpayloadreturnobj();
  _calloutmarkerping_predicted_timeout::ref_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_indigo", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_indigo", "create")]](var_2);
  }

  thread helis_assault3_hangar_check_size();
  return var_2;
}

function helis_assault3_hangar_check_size() {
  self endon("death");
  self vehphys_enablecollisioncallback(1);
  jumpiffalse(getdvarint("scr_br_indigo_invincible", 0)) LOC_0000001c;
  return;
}

function start_unstable_rocket_fuel_timer() {
  var_0 = spawnStruct();

  if(getdvarint("indigo_turret_tag_animate", 0) == 1) {
    iprintlnbold("=== tag_body_animate ===");
    var_0.tag = "tag_body_animate";
    var_0.tagoffset = (58.87, 0, 60.052);
  } else {
    var_0.tag = "tag_turret";
    var_0.tagoffset = (0, 0, 0);
  }

  return var_0;
}

function start_silo_thrust(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnturret("misc_turret", var_0 gettagorigin(var_3), var_1, 0);
  var_5 linkTo(var_0, var_3, var_4, (0, 0, 0));
  var_5 setModel(var_2);
  var_5 setmode("sentry_offline");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 setturretmodechangewait(1);
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  var_5.maxhealth = 999999;
  var_5.health = var_5.maxhealth;
  return var_5;
}

function start_trap_room_combat(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "little_bird_mp";
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(!istrue(level.suppressvehicleexplosion)) {
    self notify("predeath");
    wait 0.2;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var_0);

  if(!istrue(level.suppressvehicleexplosion)) {
    waitframe();
  }

  self setscriptablepartstate("fx", "base");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread start_smoke_door_fx();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 200, 80, var_3, "MOD_EXPLOSIVE", "little_bird_mp");
    playFX(scripts\engine\utility::getfx("indigo_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "car_explode");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
    return;
  }
}

function startpayloadreturnobj() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0.shouldoperatorhideaccessoryworldmodel = 0;

  for(;;) {
    var_1 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
    var_2 = [var_0];
    var_3 = scripts\engine\trace::ray_trace(var_0.origin, var_0.origin - (0, 0, 250), var_2, var_1, 0);

    if(isDefined(var_3)) {
      if(var_3["hittype"] == "hittype_none") {
        var_0.shouldmodeplayfinalmoments = 1;
      }
    }

    if(self vehicle_getspeed() < 35) {
      var_0.shouldmodeplayfinalmoments = 0;
      var_0.shouldoperatorhideaccessoryworldmodel = 0;
    }

    if(self vehicle_getspeed() > 35 && var_0.shouldoperatorhideaccessoryworldmodel == 0) {
      var_0 playsoundonmovingent("s4_dalpha_takeoff_rev");
      var_0.shouldoperatorhideaccessoryworldmodel = 1;
    }

    wait 1.5;
  }
}

function start_smoke_door_fx() {
  scripts\cp_mp\vehicles\vehicle::ref_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_indigo", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_indigo", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::ref_14186(self);
}

function starting_boxes(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141AC(self, "armor")) {
    var_0.damage *= start_trap_timer();
  }

  if(isDefined(var_0.damage) && var_0.damage > 0) {
    self notify("damage_taken", var_0);
  }

  return true;
}

function start_trap_timer() {
  return 0.8333;
}

function start_silo_thrust_menu(var_0) {
  thread start_trap_room_combat(var_0);
  return true;
}

function starthacktimer(var_0, var_1) {
  scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var_0, var_1);
}

function startholowatchvfx(var_0, var_1) {
  scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var_0, var_1);
}

function ref_1327D() {
  level.startjuggdelivery = spawnStruct();
  level.startjuggdelivery.powers = [];
  bhadriotshield(level.startjuggdelivery, "pilotgunner", "+attack", &startptui);
}

function ref_14231(var_0) {
  if(isbot(self)) {
    return;
  }

  foreach(var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked) {
      self notifyonplayercommand(var_6, var_4);
    }
  }
}

function ref_14230(var_0) {
  if(isbot(self)) {
    return;
  }

  foreach(var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked) {
      self notifyonplayercommandremove(var_6, var_4);
    }
  }
}

function bhadriotshield(var_0, var_1, var_2, var_3) {
  if(isstring(var_2)) {
    var_2 = [var_2];
  }

  var_0.powers[var_1] = spawnStruct();
  var_0.powers[var_1].clients_hacked = var_2;
  var_0.powers[var_1].func = var_3;
}

function startptui(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.vehicle)) {
    return;
  }

  var_2.vehicle.turret.turreton = 1;
  var_2.vehicle.turret setmode("manual");
  thread startstruct();
}

function startstruct() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("exiting_pilot_seat_indigo");
  var_0.vehicle endon("death");
  var_1 = var_0.vehicle.turret;
  var_2 = 6;

  for(;;) {
    var_1 shootturret("tag_flash", var_2);
    wait level.startpayloadexfilobjective;

    if(!var_0 attackButtonPressed()) {
      return;
    }
  }
}

function ref_12636(var_0, var_1) {
  var_2 = self;
  level endon("game_ended");
  var_2 endon("death_or_disconnect");
  var_2 endon("exiting_indigo");
  var_2 endon("exiting_pilot_seat_indigo");

  for(;;) {
    var_2 waittill(var_1);
    waittillframeend();
    var_2 thread[[var_0.powers[var_1].func]](var_0, var_1);
  }
}

function ref_12635(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_1 endon("exiting_indigo");
  var_1 endon("exiting_pilot_seat_indigo");

  if(isbot(var_1)) {
    return;
  }

  foreach(var_3 in var_0.powers) {
    thread ref_12636(var_1, var_0);
  }
}

function start_timer(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.stealth_alert_music) && level.stealth_alert_music > 0) {
    var_0.origin += (0, 0, level.stealth_alert_music);
  }

  if(istrue(level.startofxptime)) {
    init_respawns(var_3);
    thread ref_1315F();
  }

  thread start_safehouse_quarry();

  if(var_1 == "pilot") {
    thread ref_14231(var_3);
    thread ref_12635(var_3);
    thread staticcircle();
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DC(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, var_0.ref_13E92, var_4, 1);
  }

  if(var_1 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DC(var_3, var_4);
    return;
  }

  if(isDefined(var_2) && var_2 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DC(var_3, var_4);
    return;
  }
}

function start_safehouse_quarry() {
  var_0 = self;
  var_0 endon("death");
  level endon("game_ended");
  var_0.hours = 0;

  for(;;) {
    if(istrue(var_0.hours)) {
      if(var_0 vehicle_getspeed() < level.startpropcirclelogic) {
        var_0.hours = 0;
        var_0 setscriptablepartstate("fx", "base", 0);
      }
    } else if(var_0 vehicle_getspeed() > level.startpropcirclelogic) {
      var_0.hours = 1;
      var_0 setscriptablepartstate("fx", "trails", 0);
    }

    wait 5;
  }
}

function start_target_move_loop(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    thread start_timed_event_on_detection(var_0, var_1, var_2, var_3, var_4);
    return;
  }

  if(!istrue(var_4.playerdisconnect) && !istrue(var_4.playerdeath)) {
    if(var_1 == "pilot") {
      startingcodephone(var_3);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0.ref_13E92, var_4, 1);
      return;
    }

    return;
  }
}

function start_timed_event_on_detection(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3.should_hide_buried_mother_corpse)) {
    var_3.should_hide_buried_mother_corpse = 1;
  } else {
    var_3.should_hide_buried_mother_corpse += 1;
  }

  var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_pickup_origin(var_0, var_1, var_2, var_4);
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2) && var_2 == "gunner") {
    var_5 = "indigo_mp";
    var_6 = 3;
  }

  if(var_1 == "pilot") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);

    if(getdvarint("scr_br_indigo_uav_enabled", 1)) {
      startusbanim(var_0, var_3);
    }

    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_0.ref_13E92);
    var_7.owner = var_3;
    var_3.vehicle.turret = var_7;
    start_safehouse_gunshop(var_3);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::ref_141F6(var_4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

function start_trans_1_obj(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    if(isDefined(var_1) && var_1 == "pilot") {
      var_3 notify("exiting_pilot_seat_indigo");
    }

    thread ref_14230(var_3);
    startlastsurvivorsuavsweep(var_3);
    var_3 notify("exiting_indigo");
  } else if(var_2 != "pilot") {
    thread ref_14230(var_3);
    startlastsurvivorsuavsweep(var_3);
    var_3 notify("exiting_pilot_seat_indigo");
  }

  if(istrue(var_3.startplayer)) {
    var_3 cameraunlink();
    var_3.startplayer = 0;
  }

  if(istrue(var_4.success)) {
    start_trap_room(var_0, var_1, var_2, var_3, var_4);
    return;
  }
}

function start_trap_room(var_0, var_1, var_2, var_3, var_4) {
  var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_protect_hq_zone(var_0, var_1, var_2, var_4);

  if(var_1 == "pilot") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(getdvarint("scr_br_indigo_uav_enabled", 1)) {
      thread startuseweapon();
    }
  }

  var_5 = !isDefined(var_2);

  if(var_1 == "pilot" || var_5 && var_3 hasweapon(var_0.ref_13E92)) {
    var_6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_0, var_0.ref_13E92);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_6);

      if(!istrue(var_4.playerdeath)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0.ref_13E92, var_4, 1);
      }

      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var_3, var_4.playerdeath);
    }

    var_6.owner = undefined;
    var_6 setotherent(undefined);
    var_6 setentityowner(undefined);
    startingcodephone(var_3);
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 controlsunlink();

    if(istrue(var_4.playerdeath)) {
      var_3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();
    }

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_7) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

function start_safehouse_gunshop(var_0) {
  if(isDefined(var_0.set_thirdperson)) {
    return;
  }

  var_0.set_thirdperson = 1;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_indigo");

  if(istrue(var_1.ref_133D3)) {
    return;
  }

  var_0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("ctmgGunnerMissileRedux", 0.4, 0, &start_waypoint);
}

function startingcodephone(var_0) {
  if(!isDefined(var_0.set_thirdperson)) {
    return;
  }

  var_0.set_thirdperson = undefined;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_indigo");

  if(istrue(var_1.ref_133D3)) {
    return;
  }

  var_0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("ctmgGunnerMissileRedux", 0);
}

function start_waypoint(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "MOD_PROJECTILE_SPLASH" && var_4 != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(var_5)) {
    return 1;
  }

  switch (var_5.basename) {
    case "tur_gun_indigo_mp":
    case "iw8_la_t9launcher_mp":
    case "iw8_la_t9freefire_mp":
    case "lighttank_tur_mp":
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeo_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_mike32_mp":
    case "iw8_la_t9standard_mp":
      return 0;
    default:
      return 1;
  }
}

function starting_struct(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141F6(var_4);
  thread starting_trigger_fix(var_0, var_1, var_2, var_3, var_4);
}

function starting_trigger_fix(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "pilot") {
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141DC(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141F7(var_5);
    return;
  }
}

function ref_13DDA() {
  return true;
}

function trophy_protectionsuccessful(var_0) {
  self.ref_13DDF--;
  var_1 = var_0.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyDestroyTarget", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyDestroyTarget", "init")]](var_0);
  }

  var_2 = trophy_getbesttag(var_1);
  self setscriptablepartstate("trophy_detonate", var_2);
  var_3 = vectortoangles(self gettagorigin(var_2) - var_1);
  var_4 = combineangles(var_3, (-90, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyExplode", "init")) {
    self.explosion thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyExplode", "init")]](var_1, var_4);
  }

  if(self.ref_13DDF == 0) {
    self notify("upgrade_message", "trophy_no_ammo");
    self waittill("trophy_ammo_refill");
    return;
  }

  self notify("upgrade_message", "trophy_ammo_used");
}

function trophy_getbesttag(var_0) {
  var_1 = ["tag_trophy_1", "tag_trophy_2", "tag_trophy_3", "tag_trophy_4"];
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = distancesquared(var_6, var_0);

    if(var_8 == 0 || var_7 < var_2) {
      var_2 = var_7;
      var_3 = var_5;
    }
  }

  return var_3;
}

function startusbanim(var_0) {
  var_1 = self;
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  var_2 linkTo(var_1);
  var_2 makeportableradar(var_0);
  var_1.radar = var_2;
}

function startuseweapon() {
  level endon("game_ended");
  var_0 = self;

  if(isDefined(var_0.radar)) {
    var_0.radar delete();
    return;
  }
}

function startdeadsilence() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("veh_indigo", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = &start_unlock_silo;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("veh_indigo", "spawnCallback");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

function start_unlock_silo() {
  if(isDefined(level.ref_1218C) && level.ref_1218C.size != 0) {
    var_0 = level.ref_1218C;
  } else {
    var_0 = scripts\engine\utility::getStructArray("veh_indigo", "targetname");
  }

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}

function staticcircle() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("exiting_pilot_seat_indigo");
  var_1 = -40;
  var_2 = -135;
  var_3 = 40;
  var_4 = -135;
  var_0.startpayloadtanksobjective = ref_12530(var_0, var_3, var_4, "left", "middle", "center", "bottom", &"MP_WZ_ISLAND/FD_IN_AIR_COUNTER");

  while(!isDefined(var_0.vehicle)) {
    wait 0.5;
  }

  thread stealth_alert_music_index();
}

function startlastsurvivorsuavsweep() {
  var_0 = self;

  if(isDefined(var_0.startpayloadtanksobjective)) {
    var_0.startpayloadtanksobjective destroy();
  }

  var_0.startpayloadtanksobjective = undefined;
}

function stealth_alert_music_index() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("exiting_pilot_seat_indigo");

  for(;;) {
    if(!isDefined(var_0.vehicle)) {
      return;
    }

    var_1 = 0;

    foreach(var_3 in level.vehicle.instances["veh_indigo"]) {
      if(istrue(var_3.shouldmodeplayfinalmoments)) {
        var_1++;
      }
    }

    var_0.startpayloadtanksobjective setvalue(var_1);
    wait 3;
  }
}

function ref_12530(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = init_rpg_spawns("default", 1.5);
  var_8.x = var_0;
  var_8.y = var_1;
  var_8.alignx = var_2;
  var_8.aligny = var_3;
  var_8.horzalign = var_4;
  var_8.vertalign = var_5;
  var_8.alpha = 1;
  var_8.glowalpha = 0;
  var_8.hidewheninmenu = 1;
  var_8.archived = 0;

  if(isDefined(var_6)) {
    var_8.label = var_6;
  }

  if(isDefined(var_7)) {
    var_8 setvalue(var_7);
  }

  return var_8;
}

function init_rpg_spawns(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "font";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2.hidden = 0;
  return var_2;
}

function init_respawns() {
  self.startteamcontractchallenge = spawnStruct();
  self.startteamcontractchallenge.ref_13A72 = [];
}

function ref_1315F() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  wait 2;

  while(isDefined(var_0.vehicle)) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0.team) {
        continue;
      }

      if(isDefined(var_2.vehicle) && isDefined(var_2.vehicle.targetname) && var_2.vehicle.targetname == "veh_indigo") {
        thread staticmodelid(var_0);
      }
    }

    var_4 = rooftop_active();
    var_5 = var_4[0];
    var_6 = var_4[1];
    var_4 = undefined;

    foreach(var_2 in level.players) {
      if(isDefined(level.startpayloadpunish)) {
        if(var_2[[level.startpayloadpunish]]("specialty_guerrilla") || var_2[[level.startpayloadpunish]]("specialty_covert_ops")) {
          continue;
        }
      }

      var_8 = ref_13D9C(var_2.origin, var_0.vehicle.origin, var_5, var_6);

      if(istrue(var_8)) {
        thread staticmodelid(var_0);
        LOC_0000014c:
      }
      LOC_0000014c:
    }

    wait 5;
  }
}

function rooftop_active() {
  var_0 = self;
  var_0 notify("get_sonar_cone_scan_vertices");
  var_0 endon("get_sonar_cone_scan_vertices");
  var_1 = var_0.vehicle.origin;
  var_2 = anglesToForward(var_0.vehicle.angles);
  var_3 = vectorcross(var_2, (0, 0, 1));
  var_4 = var_2 * level.stay_on_roof_until_bothered_internal * cos(level.stay_on_roof_until_bothered);
  var_5 = level.stay_on_roof_until_bothered_internal * sin(level.stay_on_roof_until_bothered);
  var_6 = [];
  var_7 = (0, 0, 0);
  var_8 = undefined;
  var_9 = undefined;

  for(var_10 = 0; var_10 < 2; var_10++) {
    var_11 = var_10 / 2 * 360;
    var_12 = var_1 + var_4 + var_5 * var_3 * cos(var_11);
    var_7 = var_12;

    if(isDefined(var_9)) {
      var_8 = var_12;
      continue;
    }

    var_9 = var_12;
  }

  return [var_8, var_9];
}

function ref_13D9C(var_0, var_1, var_2, var_3) {
  var_4 = updatescrapassistdataforcecredit(var_0, var_1, var_2, var_3);

  if(var_4) {
    return 1;
  }

  return 0;
}

function updatescrapassistdataforcecredit(var_0, var_1, var_2, var_3) {
  if(!use_nvg_think(var_0, var_1, var_2)) {
    return false;
  }

  if(!use_nvg_think(var_0, var_2, var_3)) {
    return false;
  }

  if(!use_nvg_think(var_0, var_3, var_1)) {
    return false;
  }

  return true;
}

function use_nvg_think(var_0, var_1, var_2) {
  return (var_2[0] - var_1[0]) * (var_0[1] - var_1[1]) - (var_0[0] - var_1[0]) * (var_2[1] - var_1[1]) < 0;
}

function staticmodelid(var_0) {
  var_1 = self;
  level endon("game_ended");
  var_1 endon("death_or_disconnect");
  var_2 = "hud_icon_head_marked";
  var_3 = 8;
  var_4 = 1;
  var_5 = 500;
  var_6 = 40000;
  var_1.startteamcontractchallenge.ref_13A72[var_0 getentitynumber()] = var_0;
  var_7 = var_0;
  var_7.headicon = var_0 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_1, var_2, var_3, var_4, var_6, var_5, undefined, 1, 1);
  station_names(var_1, var_0);
  station_name_chosen_as_starting(var_1, var_0);
}

function station_names(var_0) {
  var_1 = self;
  var_1 endon("death_or_disconnect");
  var_2 = var_0 getentitynumber();
  var_0 scripts\engine\utility::waittill_notify_or_timeout("death_or_disconnect", 4);
}

function station_name_chosen_as_starting(var_0) {
  var_1 = self;
  var_2 = var_0 getentitynumber();

  if(isDefined(var_1.startteamcontractchallenge) && isDefined(var_1.startteamcontractchallenge.ref_13A72)) {
    var_3 = var_1.startteamcontractchallenge.ref_13A72[var_2];

    if(isDefined(var_3) && isDefined(var_3.headicon)) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_3.headicon);
      var_1.startteamcontractchallenge.ref_13A72[var_2] = undefined;
      return;
    }

    return;
  }
}

function unset_force_aitype_riotshield() {
  var_0 = self;

  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(var_0.targetname) && var_0.targetname == "veh_indigo") {
    return true;
  }

  return false;
}