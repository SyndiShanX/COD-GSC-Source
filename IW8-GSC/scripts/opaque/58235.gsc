/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58235.gsc
***********************************************/

function startarmsracedef2obj() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_indigo", 1);
  var0.destroycallback = &start_trap_room_combat;
  var0.ref_13e92 = "tur_gun_indigo_mp";
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
  thread ref_1327d();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_indigo", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_indigo", "initLate")]]();
  }

  level._effect["indigo_bomb_explode"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_indigo_exp.vfx");
}

function startchallengetimer() {
  var0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("veh_indigo", 1);
  var0.enterstartcallback = &start_timer;
  var0.enterendcallback = &start_target_move_loop;
  var0.exitstartcallback = &scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var0.exitendcallback = &start_trans_1_obj;
  var0.reentercallback = &starting_struct;
  var0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var0.exitextents["front"] = 175;
  var0.exitextents["back"] = 180;
  var0.exitextents["left"] = 68;
  var0.exitextents["right"] = 68;
  var0.exitextents["top"] = 138;
  var0.exitextents["bottom"] = 0;
  var0.allowairexit = 1;
  var1 = "back_left";
  var0.exitoffsets[var1] = (-130, 70, -45);
  var0.exitdirections[var1] = "left";
  var1 = "back_right";
  var0.exitoffsets[var1] = (-130, -70, -45);
  var0.exitdirections[var1] = "right";
  var1 = "back";
  var0.exitoffsets[var1] = (-255, 0, -45);
  var0.exitdirections[var1] = "back";
  var2 = ["pilot", "gunner"];
  var3 = "pilot";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("veh_indigo", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["back_left", "back_right", "back"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141d8();
  var4.ref_13e8a = getcompleteweaponname("tur_gun_indigo_mp");
  var4.animtag = "tag_seat_0";
  var4.ref_12023 = "ping_vehicle_pilot";
  var3 = "gunner";
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("veh_indigo", var3, 1);
  var4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var3, var2);
  var4.exitids = ["back_left", "back_right", "back"];
  var4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getpassivepassengerrestrictions();
  var4.animtag = "tag_seat_2";
  var4.ref_12023 = "ping_vehicle_gunner";
}

function startbluntwatchvfx() {
  var0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("veh_indigo", 1);
  scripts\cp_mp\vehicles\vehicle_interact::ref_1419d("veh_indigo", "single", ["pilot", "gunner"]);
}

function startcheck() {
  var0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_1427e("veh_indigo", 1);
  var0.id = 27;
  var0.seatids["pilot"] = 0;
  var0.seatids["gunner"] = 1;
  var0.ref_12da2[0] = 0;
  var0.ref_12da2[1] = 1;
  var0.ref_12da3["pilot"]["little_bird_mp"] = 0;
  var0.ref_12da3["pilot"]["tur_gun_indigo_mp"] = 1;
  var0.ref_12da3["gunner"]["little_bird_mp"] = 0;
  var0.ref_12da3["gunner"]["tur_gun_indigo_mp"] = 1;
}

function startarmsracedef4obj() {
  level.startplunderextractiontimers = getdvarfloat("scr_br_indigo_health_override", 3950);
  scripts\cp_mp\vehicles\vehicle_damage::ref_1416c("veh_indigo", level.startplunderextractiontimers, undefined, undefined, undefined, 8);
  var0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("veh_indigo");
  var0.class = "heavy";
  var1 = scripts\cp_mp\vehicles\vehicle_damage::ref_1414d("veh_indigo", "heavy");
  var1.ref_12024 = &starthacktimer;
  var1.ref_1202d = &startholowatchvfx;
  scripts\cp_mp\vehicles\vehicle_damage::ref_1413d("veh_indigo");
  scripts\cp_mp\vehicles\vehicle_damage::ref_14178("veh_indigo", 17);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14175("veh_indigo", &starting_boxes);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14171("veh_indigo", &start_silo_thrust_menu);
  scripts\cp_mp\vehicles\vehicle_damage::ref_14173("veh_indigo", "pilot", getdvarfloat("indigo_occupant_damage_scale", 0.7));
  scripts\cp_mp\vehicles\vehicle_damage::ref_14172("veh_indigo", "pilot", getdvarfloat("indigo_occupant_damage_clamp", 15));
  scripts\cp_mp\vehicles\vehicle_damage::ref_1417b("little_bird_mp", 5);
}

function startarmsracedef3obj() {
  var0 = _calloutmarkerping_predicted_log::ref_1410f("veh_indigo", 1);
  var0.challengeevaluator = 2;
  var0.keycardlocs_chosen = 0.75;
  var0.is_using_stealth_debug = 350;
  var0.is_valid_station_name = 525;
  var0.is_two_hit_melee_weapon = 875;
  var0.isakimbomeleeweapon = 5;
  var0.isallowedweapon = 20;
  var0.isakimbo = 40;
  var0.isattachmentgrenadelauncher = 0;
  var0.isattachmentselectfire = 0;
  var0.isassaulting = 0;
}

function startarmsraceopencrateobj() {
  level._effect["indigo_explode"] = loadfx("vfx/iw8_br/island/veh/vfx_br3_indigo_death_exp_ground");
}

function start_vault_assault_retrieve_saw() {
  var0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_indigo");
  return var0.ref_13e92;
}

function start_silo_jump_menu(var0, var1) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var0.modelname = "veh_s4_mil_air_aindigo_wz";
  var0.targetname = "veh_indigo";

  if(!isDefined(var0.vehicletype)) {
    var0.vehicletype = "indigo_mp";
  }

  var2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var0, var1);

  if(!isDefined(var2)) {
    return undefined;
  }

  var3 = start_vault_assault_retrieve_saw();
  var4 = start_unstable_rocket_fuel_timer();
  var5 = start_silo_thrust(var2, var3, "veh_s4_mil_air_aindigo_wz_turret_attach", var4.tag, var4.tagoffset);
  scripts\cp_mp\vehicles\vehicle::ref_14207(var2, var5, getcompleteweaponname(var3));
  scripts\cp_mp\vehicles\vehicle::ref_14138(var2, "veh_indigo", var0);
  var2.objweapon = getcompleteweaponname("little_bird_mp");
  var2.ref_13e92 = var3;
  var2.ref_11b7b = 3;
  var2.minigunbackup = level.startmatchobjectiveicons;
  var2.shouldmodeplayfinalmoments = 0;
  thread startpayloadreturnobj();
  _calloutmarkerping_predicted_timeout::ref_1412b(var2);
  scripts\cp_mp\vehicles\vehicle::ref_14139(var2, var0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("veh_indigo", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("veh_indigo", "create")]](var2);
  }

  thread helis_assault3_hangar_check_size();
  return var2;
}

function helis_assault3_hangar_check_size() {
  self endon("death");
  self vehphys_enablecollisioncallback(1);
  jumpiffalse(getdvarint("scr_br_indigo_invincible", 0)) LOC_0000001c;
  return;
}

function start_unstable_rocket_fuel_timer() {
  var0 = spawnStruct();

  if(getdvarint("indigo_turret_tag_animate", 0) == 1) {
    iprintlnbold("=== tag_body_animate ===");
    var0.tag = "tag_body_animate";
    var0.tagoffset = (58.87, 0, 60.052);
  } else {
    var0.tag = "tag_turret";
    var0.tagoffset = (0, 0, 0);
  }

  return var0;
}

function start_silo_thrust(var0, var1, var2, var3, var4) {
  var5 = spawnturret("misc_turret", var0 gettagorigin(var3), var1, 0);
  var5 linkTo(var0, var3, var4, (0, 0, 0));
  var5 setModel(var2);
  var5 setmode("sentry_offline");
  var5 setsentryowner(undefined);
  var5 makeunusable();
  var5 setdefaultdroppitch(0);
  var5 setturretmodechangewait(1);
  var5.angles = var0.angles;
  var5.vehicle = var0;
  var5.maxhealth = 999999;
  var5.health = var5.maxhealth;
  return var5;
}

function start_trap_room_combat(var0, var1) {
  if(!isDefined(var0)) {
    var0 = spawnStruct();
    var0.inflictor = self;
    var0.objweapon = "little_bird_mp";
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(!istrue(level.suppressvehicleexplosion)) {
    self notify("predeath");
    wait 0.2;
  }

  scripts\cp_mp\vehicles\vehicle_damage::ref_14162(var0);

  if(!istrue(level.suppressvehicleexplosion)) {
    waitframe();
  }

  self setscriptablepartstate("fx", "base");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread start_smoke_door_fx();

  if(!istrue(level.suppressvehicleexplosion)) {
    var2 = self gettagorigin("tag_origin");
    var3 = scripts\engine\utility::ter_op(isDefined(var0.attacker), var0.attacker, self);
    self radiusdamage(var2, 256, 200, 80, var3, "MOD_EXPLOSIVE", "little_bird_mp");
    playFX(scripts\engine\utility::getfx("indigo_explode"), var2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var2, "car_explode");
    earthquake(0.4, 800, var2, 0.7);
    playrumbleonposition("grenade_rumble", var2);
    physicsexplosionsphere(var2, 500, 200, 1);
    return;
  }
}

function startpayloadreturnobj() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  var0.shouldoperatorhideaccessoryworldmodel = 0;

  for(;;) {
    var1 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
    var2 = [var0];
    var3 = scripts\engine\trace::ray_trace(var0.origin, var0.origin - (0, 0, 250), var2, var1, 0);

    if(isDefined(var3)) {
      if(var3["hittype"] == "hittype_none") {
        var0.shouldmodeplayfinalmoments = 1;
      }
    }

    if(self vehicle_getspeed() < 35) {
      var0.shouldmodeplayfinalmoments = 0;
      var0.shouldoperatorhideaccessoryworldmodel = 0;
    }

    if(self vehicle_getspeed() > 35 && var0.shouldoperatorhideaccessoryworldmodel == 0) {
      var0 playsoundonmovingent("s4_dalpha_takeoff_rev");
      var0.shouldoperatorhideaccessoryworldmodel = 1;
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

function starting_boxes(var0) {
  if(scripts\cp_mp\vehicles\vehicle_interact::ref_141ac(self, "armor")) {
    var0.damage *= start_trap_timer();
  }

  if(isDefined(var0.damage) && var0.damage > 0) {
    self notify("damage_taken", var0);
  }

  return true;
}

function start_trap_timer() {
  return 0.8333;
}

function start_silo_thrust_menu(var0) {
  thread start_trap_room_combat(var0);
  return true;
}

function starthacktimer(var0, var1) {
  scripts\cp_mp\vehicles\vehicle_damage::ref_14163(var0, var1);
}

function startholowatchvfx(var0, var1) {
  scripts\cp_mp\vehicles\vehicle_damage::ref_14169(var0, var1);
}

function ref_1327d() {
  level.startjuggdelivery = spawnStruct();
  level.startjuggdelivery.powers = [];
  bhadriotshield(level.startjuggdelivery, "pilotgunner", "+attack", &startptui);
}

function ref_14231(var0) {
  if(isbot(self)) {
    return;
  }

  foreach(var2 in var0.powers) {
    foreach(var4 in var2.clients_hacked) {
      self notifyonplayercommand(var6, var4);
    }
  }
}

function ref_14230(var0) {
  if(isbot(self)) {
    return;
  }

  foreach(var2 in var0.powers) {
    foreach(var4 in var2.clients_hacked) {
      self notifyonplayercommandremove(var6, var4);
    }
  }
}

function bhadriotshield(var0, var1, var2, var3) {
  if(isstring(var2)) {
    var2 = [var2];
  }

  var0.powers[var1] = spawnStruct();
  var0.powers[var1].clients_hacked = var2;
  var0.powers[var1].func = var3;
}

function startptui(var0, var1) {
  var2 = self;

  if(!isDefined(var2.vehicle)) {
    return;
  }

  var2.vehicle.turret.turreton = 1;
  var2.vehicle.turret setmode("manual");
  thread startstruct();
}

function startstruct() {
  var0 = self;
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("exiting_pilot_seat_indigo");
  var0.vehicle endon("death");
  var1 = var0.vehicle.turret;
  var2 = 6;

  for(;;) {
    var1 shootturret("tag_flash", var2);
    wait level.startpayloadexfilobjective;

    if(!var0 attackButtonPressed()) {
      return;
    }
  }
}

function ref_12636(var0, var1) {
  var2 = self;
  level endon("game_ended");
  var2 endon("death_or_disconnect");
  var2 endon("exiting_indigo");
  var2 endon("exiting_pilot_seat_indigo");

  for(;;) {
    var2 waittill(var1);
    waittillframeend();
    var2 thread[[var0.powers[var1].func]](var0, var1);
  }
}

function ref_12635(var0) {
  var1 = self;
  level endon("game_ended");
  var1 endon("death_or_disconnect");
  var1 endon("exiting_indigo");
  var1 endon("exiting_pilot_seat_indigo");

  if(isbot(var1)) {
    return;
  }

  foreach(var3 in var0.powers) {
    thread ref_12636(var1, var0);
  }
}

function start_timer(var0, var1, var2, var3, var4) {
  if(isDefined(level.stealth_alert_music) && level.stealth_alert_music > 0) {
    var0.origin += (0, 0, level.stealth_alert_music);
  }

  if(istrue(level.startofxptime)) {
    init_respawns(var3);
    thread ref_1315f();
  }

  thread start_safehouse_quarry();

  if(var1 == "pilot") {
    thread ref_14231(var3);
    thread ref_12635(var3);
    thread staticcircle();
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var3, var0.ref_13e92, var4, 1);
  }

  if(var1 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
    return;
  }

  if(isDefined(var2) && var2 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
    return;
  }
}

function start_safehouse_quarry() {
  var0 = self;
  var0 endon("death");
  level endon("game_ended");
  var0.hours = 0;

  for(;;) {
    if(istrue(var0.hours)) {
      if(var0 vehicle_getspeed() < level.startpropcirclelogic) {
        var0.hours = 0;
        var0 setscriptablepartstate("fx", "base", 0);
      }
    } else if(var0 vehicle_getspeed() > level.startpropcirclelogic) {
      var0.hours = 1;
      var0 setscriptablepartstate("fx", "trails", 0);
    }

    wait 5;
  }
}

function start_target_move_loop(var0, var1, var2, var3, var4) {
  if(istrue(var4.success)) {
    thread start_timed_event_on_detection(var0, var1, var2, var3, var4);
    return;
  }

  if(!istrue(var4.playerdisconnect) && !istrue(var4.playerdeath)) {
    if(var1 == "pilot") {
      startingcodephone(var3);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, var0.ref_13e92, var4, 1);
      return;
    }

    return;
  }
}

function start_timed_event_on_detection(var0, var1, var2, var3, var4) {
  if(!isDefined(var3.should_hide_buried_mother_corpse)) {
    var3.should_hide_buried_mother_corpse = 1;
  } else {
    var3.should_hide_buried_mother_corpse += 1;
  }

  var3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_pickup_origin(var0, var1, var2, var4);
  var5 = undefined;
  var6 = undefined;

  if(isDefined(var2) && var2 == "gunner") {
    var5 = "indigo_mp";
    var6 = 3;
  }

  if(var1 == "pilot") {
    var0 setotherent(var3);
    var0 setentityowner(var3);
    var3 controlslinkTo(var0);

    if(getdvarint("scr_br_indigo_uav_enabled", 1)) {
      startusbanim(var0, var3);
    }

    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var3, 0);
    var7 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, var0.ref_13e92);
    var7.owner = var3;
    var3.vehicle.turret = var7;
    start_safehouse_gunshop(var3);
  }

  var3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var0, var1, var2, undefined, var5, var6);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6(var4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var0, var2, var1, var3);
}

function start_trans_1_obj(var0, var1, var2, var3, var4) {
  if(!isDefined(var2)) {
    if(isDefined(var1) && var1 == "pilot") {
      var3 notify("exiting_pilot_seat_indigo");
    }

    thread ref_14230(var3);
    startlastsurvivorsuavsweep(var3);
    var3 notify("exiting_indigo");
  } else if(var2 != "pilot") {
    thread ref_14230(var3);
    startlastsurvivorsuavsweep(var3);
    var3 notify("exiting_pilot_seat_indigo");
  }

  if(istrue(var3.startplayer)) {
    var3 cameraunlink();
    var3.startplayer = 0;
  }

  if(istrue(var4.success)) {
    start_trap_room(var0, var1, var2, var3, var4);
    return;
  }
}

function start_trap_room(var0, var1, var2, var3, var4) {
  var3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_protect_hq_zone(var0, var1, var2, var4);

  if(var1 == "pilot") {
    var0 setotherent(undefined);
    var0 setentityowner(undefined);

    if(getdvarint("scr_br_indigo_uav_enabled", 1)) {
      thread startuseweapon();
    }
  }

  var5 = !isDefined(var2);

  if(var1 == "pilot" || var5 && var3 hasweapon(var0.ref_13e92)) {
    var6 = scripts\cp_mp\vehicles\vehicle::ref_14192(var0, var0.ref_13e92);

    if(!istrue(var4.playerdisconnect)) {
      var3 enableturretdismount();
      var3 controlturretoff(var6);

      if(!istrue(var4.playerdeath)) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var3, var0, var0.ref_13e92, var4, 1);
      }

      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var3, var4.playerdeath);
    }

    var6.owner = undefined;
    var6 setotherent(undefined);
    var6 setentityowner(undefined);
    startingcodephone(var3);
  }

  if(!istrue(var4.playerdisconnect)) {
    var3 controlsunlink();

    if(istrue(var4.playerdeath)) {
      var3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();
    }

    var3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var3, var2, var4);

    if(!var7) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var3);
      } else {
        var3 suicide();
      }
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var0, var1, var2, var3);
}

function start_safehouse_gunshop(var0) {
  if(isDefined(var0.set_thirdperson)) {
    return;
  }

  var0.set_thirdperson = 1;
  var1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_indigo");

  if(istrue(var1.ref_133d3)) {
    return;
  }

  var0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("ctmgGunnerMissileRedux", 0.4, 0, &start_waypoint);
}

function startingcodephone(var0) {
  if(!isDefined(var0.set_thirdperson)) {
    return;
  }

  var0.set_thirdperson = undefined;
  var1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_indigo");

  if(istrue(var1.ref_133d3)) {
    return;
  }

  var0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("ctmgGunnerMissileRedux", 0);
}

function start_waypoint(var0, var1, var2, var3, var4, var5, var6) {
  if(var4 != "MOD_PROJECTILE_SPLASH" && var4 != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(var5)) {
    return 1;
  }

  switch (var5.basename) {
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

function starting_struct(var0, var1, var2, var3, var4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f6(var4);
  thread starting_trigger_fix(var0, var1, var2, var3, var4);
}

function starting_trigger_fix(var0, var1, var2, var3, var4) {
  if(isDefined(var2) && var2 == "pilot") {
    var5 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141dc(var3, var4);
    scripts\cp_mp\vehicles\vehicle_occupancy::ref_141f7(var5);
    return;
  }
}

function ref_13dda() {
  return true;
}

function trophy_protectionsuccessful(var0) {
  self.ref_13ddf--;
  var1 = var0.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyDestroyTarget", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyDestroyTarget", "init")]](var0);
  }

  var2 = trophy_getbesttag(var1);
  self setscriptablepartstate("trophy_detonate", var2);
  var3 = vectortoangles(self gettagorigin(var2) - var1);
  var4 = combineangles(var3, (-90, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_trophyExplode", "init")) {
    self.explosion thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_trophyExplode", "init")]](var1, var4);
  }

  if(self.ref_13ddf == 0) {
    self notify("upgrade_message", "trophy_no_ammo");
    self waittill("trophy_ammo_refill");
    return;
  }

  self notify("upgrade_message", "trophy_ammo_used");
}

function trophy_getbesttag(var0) {
  var1 = ["tag_trophy_1", "tag_trophy_2", "tag_trophy_3", "tag_trophy_4"];
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var1) {
    var6 = self gettagorigin(var5);
    var7 = distancesquared(var6, var0);

    if(var8 == 0 || var7 < var2) {
      var2 = var7;
      var3 = var5;
    }
  }

  return var3;
}

function startusbanim(var0) {
  var1 = self;
  var2 = spawn("script_model", var1.origin);
  var2 setModel("tag_origin");
  var2 linkTo(var1);
  var2 makeportableradar(var0);
  var1.radar = var2;
}

function startuseweapon() {
  level endon("game_ended");
  var0 = self;

  if(isDefined(var0.radar)) {
    var0.radar delete();
    return;
  }
}

function startdeadsilence() {
  var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("veh_indigo", 1);
  var0.maxinstancecount = 2;
  var0.priority = 75;
  var0.getspawnstructscallback = &start_unlock_silo;
  var0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("veh_indigo", "spawnCallback");
  var0.clearancecheckradius = 185;
  var0.clearancecheckheight = 138;
  var0.clearancecheckminradius = 185;
}

function start_unlock_silo() {
  if(isDefined(level.ref_1218c) && level.ref_1218c.size != 0) {
    var0 = level.ref_1218c;
  } else {
    var0 = scripts\engine\utility::getStructArray("veh_indigo", "targetname");
  }

  if(var0.size > 0) {
    var0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var0, 1);

    if(var0.size > 1) {
      var0 = scripts\engine\utility::array_randomize(var0);
    }
  }

  return var0;
}

function staticcircle() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  var0 endon("exiting_pilot_seat_indigo");
  var1 = -40;
  var2 = -135;
  var3 = 40;
  var4 = -135;
  var0.startpayloadtanksobjective = ref_12530(var0, var3, var4, "left", "middle", "center", "bottom", &"MP_WZ_ISLAND/FD_IN_AIR_COUNTER");

  while(!isDefined(var0.vehicle)) {
    wait 0.5;
  }

  thread stealth_alert_music_index();
}

function startlastsurvivorsuavsweep() {
  var0 = self;

  if(isDefined(var0.startpayloadtanksobjective)) {
    var0.startpayloadtanksobjective destroy();
  }

  var0.startpayloadtanksobjective = undefined;
}

function stealth_alert_music_index() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  var0 endon("exiting_pilot_seat_indigo");

  for(;;) {
    if(!isDefined(var0.vehicle)) {
      return;
    }

    var1 = 0;

    foreach(var3 in level.vehicle.instances["veh_indigo"]) {
      if(istrue(var3.shouldmodeplayfinalmoments)) {
        var1++;
      }
    }

    var0.startpayloadtanksobjective setvalue(var1);
    wait 3;
  }
}

function ref_12530(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = init_rpg_spawns("default", 1.5);
  var8.x = var0;
  var8.y = var1;
  var8.alignx = var2;
  var8.aligny = var3;
  var8.horzalign = var4;
  var8.vertalign = var5;
  var8.alpha = 1;
  var8.glowalpha = 0;
  var8.hidewheninmenu = 1;
  var8.archived = 0;

  if(isDefined(var6)) {
    var8.label = var6;
  }

  if(isDefined(var7)) {
    var8 setvalue(var7);
  }

  return var8;
}

function init_rpg_spawns(var0, var1) {
  var2 = newclienthudelem(self);
  var2.elemtype = "font";
  var2.font = var0;
  var2.fontscale = var1;
  var2.basefontscale = var1;
  var2.x = 0;
  var2.y = 0;
  var2.width = 0;
  var2.height = int(level.fontheight * var1);
  var2.xoffset = 0;
  var2.yoffset = 0;
  var2.children = [];
  var2.hidden = 0;
  return var2;
}

function init_respawns() {
  self.startteamcontractchallenge = spawnStruct();
  self.startteamcontractchallenge.ref_13a72 = [];
}

function ref_1315f() {
  var0 = self;
  level endon("game_ended");
  var0 endon("death");
  wait 2;

  while(isDefined(var0.vehicle)) {
    foreach(var2 in level.players) {
      if(var2.team == var0.team) {
        continue;
      }

      if(isDefined(var2.vehicle) && isDefined(var2.vehicle.targetname) && var2.vehicle.targetname == "veh_indigo") {
        thread staticmodelid(var0);
      }
    }

    var4 = rooftop_active();
    var5 = var4[0];
    var6 = var4[1];
    var4 = undefined;

    foreach(var2 in level.players) {
      if(isDefined(level.startpayloadpunish)) {
        if(var2[[level.startpayloadpunish]]("specialty_guerrilla") || var2[[level.startpayloadpunish]]("specialty_covert_ops")) {
          continue;
        }
      }

      var8 = ref_13d9c(var2.origin, var0.vehicle.origin, var5, var6);

      if(istrue(var8)) {
        thread staticmodelid(var0);
        LOC_0000014c:
      }
      LOC_0000014c:
    }

    wait 5;
  }
}

function rooftop_active() {
  var0 = self;
  var0 notify("get_sonar_cone_scan_vertices");
  var0 endon("get_sonar_cone_scan_vertices");
  var1 = var0.vehicle.origin;
  var2 = anglesToForward(var0.vehicle.angles);
  var3 = vectorcross(var2, (0, 0, 1));
  var4 = var2 * level.stay_on_roof_until_bothered_internal * cos(level.stay_on_roof_until_bothered);
  var5 = level.stay_on_roof_until_bothered_internal * sin(level.stay_on_roof_until_bothered);
  var6 = [];
  var7 = (0, 0, 0);
  var8 = undefined;
  var9 = undefined;

  for(var10 = 0; var10 < 2; var10++) {
    var11 = var10 / 2 * 360;
    var12 = var1 + var4 + var5 * var3 * cos(var11);
    var7 = var12;

    if(isDefined(var9)) {
      var8 = var12;
      continue;
    }

    var9 = var12;
  }

  return [var8, var9];
}

function ref_13d9c(var0, var1, var2, var3) {
  var4 = updatescrapassistdataforcecredit(var0, var1, var2, var3);

  if(var4) {
    return 1;
  }

  return 0;
}

function updatescrapassistdataforcecredit(var0, var1, var2, var3) {
  if(!use_nvg_think(var0, var1, var2)) {
    return false;
  }

  if(!use_nvg_think(var0, var2, var3)) {
    return false;
  }

  if(!use_nvg_think(var0, var3, var1)) {
    return false;
  }

  return true;
}

function use_nvg_think(var0, var1, var2) {
  return (var2[0] - var1[0]) * (var0[1] - var1[1]) - (var0[0] - var1[0]) * (var2[1] - var1[1]) < 0;
}

function staticmodelid(var0) {
  var1 = self;
  level endon("game_ended");
  var1 endon("death_or_disconnect");
  var2 = "hud_icon_head_marked";
  var3 = 8;
  var4 = 1;
  var5 = 500;
  var6 = 40000;
  var1.startteamcontractchallenge.ref_13a72[var0 getentitynumber()] = var0;
  var7 = var0;
  var7.headicon = var0 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var1, var2, var3, var4, var6, var5, undefined, 1, 1);
  station_names(var1, var0);
  station_name_chosen_as_starting(var1, var0);
}

function station_names(var0) {
  var1 = self;
  var1 endon("death_or_disconnect");
  var2 = var0 getentitynumber();
  var0 scripts\engine\utility::waittill_notify_or_timeout("death_or_disconnect", 4);
}

function station_name_chosen_as_starting(var0) {
  var1 = self;
  var2 = var0 getentitynumber();

  if(isDefined(var1.startteamcontractchallenge) && isDefined(var1.startteamcontractchallenge.ref_13a72)) {
    var3 = var1.startteamcontractchallenge.ref_13a72[var2];

    if(isDefined(var3) && isDefined(var3.headicon)) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var3.headicon);
      var1.startteamcontractchallenge.ref_13a72[var2] = undefined;
      return;
    }

    return;
  }
}

function unset_force_aitype_riotshield() {
  var0 = self;

  if(var0 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(var0.targetname) && var0.targetname == "veh_indigo") {
    return true;
  }

  return false;
}