/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\chopper_gunner.gsc
********************************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "init")]]();
  }

  level._effect["chopper_gunner_explosion"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_explosion.vfx");
  level._effect["chopper_gunner_friendly_strobe"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_friendly_strobe.vfx");
  level.choppergunners = [];
  level.heli_pilot_mesh = scripts\cp_mp\utility\game_utility::getlocaleent("heli_pilot_mesh");

  if(isDefined(level.heli_pilot_mesh)) {
    level.heli_pilot_mesh hide();
  }

  game["dialog"]["chopper_gunner_attack_engage"] = "chopper_gunner_engage";
  game["dialog"]["chopper_gunner_attack_single"] = "chopper_gunner_attack_single";
  game["dialog"]["chopper_gunner_attack_multi"] = "chopper_gunner_attack_multi";
  game["dialog"]["chopper_gunner_flares"] = "chopper_gunner_flares";
  game["dialog"]["chopper_gunner_light_damage"] = "chopper_gunner_health_high";
  game["dialog"]["chopper_gunner_med_damage"] = "chopper_gunner_health_med";
  game["dialog"]["chopper_gunner_heavy_damage"] = "chopper_gunner_health_low";
  game["dialog"]["chopper_gunner_killconf_single"] = "chopper_gunner_killconf_single";
  game["dialog"]["chopper_gunner_killconf_multi"] = "chopper_gunner_killconf_multi";
  game["dialog"]["chopper_gunner_killconf_missile"] = "chopper_gunner_killconf_missile";
  game["dialog"]["chopper_gunner_lockedon"] = "chopper_gunner_lockedon";
  game["dialog"]["chopper_gunner_reattack"] = "chopper_gunner_reattack";
  game["dialog"]["chopper_gunner_crash"] = "chopper_gunner_crash";
  choppergunner_pilotanims();
  choppergunner_vehicleanims();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "set_vehicle_hit_damage_data")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "set_vehicle_hit_damage_data")]]("chopper_gunner", 12);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_bolt_mp", 1, "chopper_gunner");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_gunner", 30, "thermite_bolt_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_bolt_mp", 1, "chopper_gunner");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_gunner", 11, "semtex_bolt_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("thermite_xmike109_mp", 1, "chopper_gunner");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_gunner", 80, "thermite_xmike109_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_xmike109_mp", 1, "chopper_gunner");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_gunner", 18, "semtex_xmike109_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]]("semtex_aalpha12_mp", 1, "chopper_gunner");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]]("chopper_gunner", 23, "semtex_aalpha12_mp");
  }

  level.incomingallchoppergunners = 0;
  level.incomingchoppergunners["allies"] = 0;
  level.incomingchoppergunners["axis"] = 0;
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("chopper_gunner", "on", 6);
}

#using_animtree("");

function choppergunner_pilotanims() {
  level.scr_animtree["ks_chopper_gunner_pilot"] = #animtree;
  level.scr_anim["ks_chopper_gunner_pilot"]["pilot_intro"] = $mp_player_ahotel64_intro_01;
  level.scr_animname["ks_chopper_gunner_pilot"]["pilot_intro"] = "mp_player_ahotel64_intro_01";
  level.scr_anim["ks_chopper_gunner_pilot"]["pilot_crash"] = % mp_player_ahotel64_crash_01;
  level.scr_animname["ks_chopper_gunner_pilot"]["pilot_crash"] = "mp_player_ahotel64_crash_01";
}

function choppergunner_vehicleanims() {
  level.scr_animtree["ks_chopper_gunner_vehicle_camera"] = #animtree;
  level.scr_anim["ks_chopper_gunner_vehicle_camera"]["vehicle_intro"] = $mp_ahotel64_intro_01;
  level.scr_anim["ks_chopper_gunner_vehicle_camera"]["vehicle_crash"] = % mp_ahotel64_crash_01;
}

function weapongivenchoppergunner(var_0) {
  return true;
}

function tryusechoppergunner() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("chopper_gunner", self);
  return tryusechoppergunnerfromstruct(var_0);
}

function tryusechoppergunnerfromstruct(var_0) {
  self endon("disconnect");
  level endon("game_ended");

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_killstreak_choppergunner");
  }

  var_1 = getcompleteweaponname("ks_remote_device_mp");
  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0, &weapongivenchoppergunner);

  if(!istrue(var_2)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  var_3 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + var_3 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
      }

      var_0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  level.incomingallchoppergunners++;
  var_4 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var_4 = 2;
  }

  if(level.choppergunners.size >= var_4 || level.choppergunners.size + level.incomingallchoppergunners > var_4) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    level.incomingallchoppergunners--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    var_5 = 1;
    level.incomingchoppergunners[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.choppergunners) + level.incomingchoppergunners[self.team] > var_5) {
      level.incomingallchoppergunners--;
      level.incomingchoppergunners[self.team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_CHOPPER_GUNNER");
      }

      var_0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  if(level.gameended) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  var_6 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  var_7 = startchoppergunnerintro(self, var_0, var_6);
  level.incomingallchoppergunners--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    level.incomingchoppergunners[self.team]--;
  }

  if(!isDefined(var_7)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    var_0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("chopper_gunner", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_chopper_gunner", self);
  }

  thread choppergunner_startremotecontrol(var_7);
  return true;
}

function startchoppergunnerintro(var_0, var_1, var_2) {
  var_0 disablephysicaldepthoffieldscripting();
  var_3 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var_4 = (0, 0, 0);

  if(isDefined(var_3)) {
    var_4 = (0, 0, var_3.origin[2] - 1000);
  } else {
    var_4 = (0, 0, 1500);
  }

  var_6 = 9000;

  if(level.mapname == "mp_port2_gw") {
    var_6 = 7000;
  }

  var_7 = var_0.origin - anglesToForward(var_0.angles) * var_6 + var_4;
  var_8 = var_0.origin + anglesToForward(var_0.angles) * 2000 + var_4;
  var_9 = var_0.angles;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_10 = randomint(level.heli_structs_entrances.size);
    var_11 = level.heli_structs_entrances[var_10];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "findTargetStruct")) {
      var_12 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "findTargetStruct")]](var_11.script_linkto, level.heli_structs_goals);

      if(isDefined(var_12)) {
        var_4 = (0, 0, var_12.origin[2] + 200);
        var_13 = var_11.origin * (1, 1, 0) + var_4;
        var_14 = var_12.origin * (1, 1, 0) + var_4;
        var_15 = vectorNormalize(var_14 - var_13);
        var_16 = 9000;

        if(level.mapname == "mp_shipment") {
          var_16 = 8000;
        }

        var_7 = var_14 - var_15 * var_16;
        var_8 = var_14 + var_15 * 1000;
        var_9 = vectortoangles(var_15);
      }
    }
  } else if(istrue(var_0.stopcirclesatgameend) && level.script == "cp_so_aniyah") {
    if(level.players.size > 1) {
      var_17 = scripts\engine\utility::array_remove(level.players, var_0);
    } else {
      var_17 = level.players;
    }

    var_18 = scripts\engine\utility::random(var_17);
    var_19 = (var_18.origin[0], var_18.origin[1], 1750);

    while(level.ref_11F7E.size == 0) {
      waitframe();
    }

    var_20 = scripts\engine\utility::getclosest(var_19, level.ref_11F7E);
    var_21 = (var_20.origin[0], var_20.origin[1], 1750);
    var_22 = vectorNormalize(var_19 - var_21);
    var_8 = var_21 - var_22 * 11000;
    var_9 = var_21 - var_22 * 1000;
    var_17 = vectortoangles(var_22);
  } else {
    var_1 iprintlnbold("Level is missing heli structs, please set them up!");
  }

  var_23 = "veh8_mil_air_ahotel64_ks_mp";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_1)) {
    var_23 = "veh8_mil_air_ahotel64_ks_east_mp";
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(istrue(var_1.stopcirclesatgameend) && level.script == "cp_so_aniyah") {
    var_24 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_1, var_8, var_17, "veh_apache_cp_so_aniyah", var_23);
  } else {
    var_24 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_2, var_9, var_23, "veh_apache_mp", var_24);
  }

  if(!isDefined(var_24)) {
    return;
  }

  var_25 = 45;
  var_24.speed = 100;
  var_24.accel = 50;
  var_24.lifetime = var_25;
  var_24.team = var_2.team;
  var_24.owner = var_2;
  var_24.angles = var_23;
  var_24.streakinfo = var_3;
  var_24.streakname = var_3.streakname;
  var_24.flaresreservecount = 1;
  var_24.currentdamagestate = 0;
  var_24.pathstart = var_9;
  var_24.pathgoal = var_17;
  var_24.missilesleft = 8;
  var_24.animname = "ks_chopper_gunner_vehicle_camera";
  var_24.stopcirclesatgameend = istrue(var_2.stopcirclesatgameend);
  var_24 setvehicleteam(var_24.team);
  thread goal_shotgun(var_24, "disconnect");
  thread goal_shotgun(var_24, "joined_team");
  thread goal_shotgun(var_24, "joined_spectator");
  var_27 = 2000;

  if(istrue(level.istacops)) {
    var_27 = 1000;
  }

  var_24.health = var_27;
  var_24.maxhealth = var_27;
  var_24 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_2);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var_3.streakname, "destroyed_chopper_gunner", undefined, "timeout_chopper_gunner", "callout_destroyed_chopper_gunner");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var_3.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var_3.streakname, &choppergunner_modifydamage);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var_3.streakname, &choppergunner_handledeathdamage);
  }

  level.choppergunners[level.choppergunners.size] = var_24;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_3.streakname, "Killstreak_Air", var_2, 0, 1, 100);
  }

  var_24 setmaxpitchroll(15, 15);
  var_24 vehicle_setspeed(var_24.speed, var_24.accel);
  var_24 sethoverparams(50, 5, 2.5);
  var_24 setturningability(1);
  var_24 setyawspeed(500, 100, 25, 0.5);
  var_24 setotherent(var_2);
  var_24 setCanDamage(1);
  var_24 setneargoalnotifydist(5000);
  var_24 scripts\cp_mp\emp_debuff::set_start_emp_callback(&choppergunner_empstarted);
  var_24 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&choppergunner_empcleared);
  var_24 setscriptablepartstate("blinking_lights", "on", 0);
  var_24 setscriptablepartstate("interior_light", "on", 0);
  var_24 setscriptablepartstate("engine", "on", 0);
  var_28 = "veh8_mil_air_ahotel64_turret_wm";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_2)) {
    var_28 = "veh8_mil_air_ahotel64_turret_wm_east";
  }

  var_24.turret = spawnturret("misc_turret", var_24 gettagorigin("tag_turret"), "apache_turret_mp");
  var_24.turret setModel(var_28);
  var_24.turret.owner = var_2;
  var_24.turret.team = var_2.team;
  var_24.turret.angles = var_24.angles;
  var_24.turret.streakinfo = var_3;
  var_24.turret linkTo(var_24, "tag_turret");
  var_24.turret setturretteam(var_2.team);
  var_24.turret setturretmodechangewait(0);
  var_24.turret setmode("manual");
  var_24.turret setotherent(var_2);
  var_24.turret setdefaultdroppitch(45);
  var_24.mpod1 = spawn("script_model", var_24 gettagorigin("tag_gun_l"));
  var_24.mpod1 setModel("ks_apache_turret_mp");
  var_24.mpod1.angles = var_24.angles;
  var_24.mpod1.owner = var_24.owner;
  var_24.mpod1.team = var_24.team;
  var_24.mpod1 linkTo(var_24, "tag_gun_l");
  var_24.mpod1 setentityowner(var_2);
  var_24.mpod1 setotherent(var_2);
  var_24.mpod2 = spawn("script_model", var_24 gettagorigin("tag_gun_r"));
  var_24.mpod2 setModel("ks_apache_turret_mp");
  var_24.mpod2.angles = var_24.angles;
  var_24.mpod2.owner = var_24.owner;
  var_24.mpod2.team = var_24.team;
  var_24.mpod2 linkTo(var_24, "tag_gun_r");
  var_24.mpod2 setentityowner(var_2);
  var_24.mpod2 setotherent(var_2);
  var_24.turretfx = spawn("script_model", var_24.turret.origin);
  var_24.turretfx setModel("ks_apache_turret_mp");
  var_24.turretfx.angles = var_24.angles;
  var_24.turretfx linkTo(var_24.turret, "tag_player");
  var_24.turretfx setotherent(var_2);
  var_24.pilot = spawn("script_model", var_24 gettagorigin("tag_origin"));
  var_24.pilot setModel("pilot_viewmodel_arms");
  var_24.pilot.angles = var_24.angles;
  var_24.pilot linkTo(var_24, "tag_origin");
  var_24.pilot.animname = "ks_chopper_gunner_pilot";
  var_24.pilot scripts\common\anim::setanimtree();
  level notify("matchrecording_chopper", var_24);
  self notify("chopper_gunner_used");
  thread choppergunner_updateflyingspeed(var_24);

  if(!istrue(var_4)) {
    var_24 setvehgoalpos(var_24.pathgoal, 0);
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    self.restoreangles = self getplayerangles();
    scripts\common\utility::allow_fire(0);
    scripts\common\utility::allow_melee(0);
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_usability(0);
    scripts\common\utility::allow_shellshock(0);
    thread choppergunner_camerashake(var_24);
    self setclientomnvar("ui_apache_screens_state", 1);
    self playerlinkweaponviewtodelta(var_24, "tag_player", 1, 0, 0, 0, 0, 1);
    self playerlinkedsetviewznear(0);
    self painvisionoff();
    scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    var_24 playsoundtoplayer("mp_killstreak_apache_transition_lr", self);
  } else {
    var_24 setvehgoalpos(var_24.pathgoal, 1);
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_3.streakname, 1);
  thread choppergunner_playdofintroeffects();
  var_24 thread scripts\common\anim::anim_single_solo(var_24, "vehicle_intro");
  var_24 thread scripts\common\anim::anim_single_solo(var_24.pilot, "pilot_intro", "body_animate_jnt");
  thread choppergunner_startfadetransition(var_24);
  var_29 = goal_ar(var_24, 4.25);

  if(!istrue(var_29)) {
    return;
  }

  var_24 notify("start_chopper_use");
  return var_24;
}

function goal_shotgun(var_0, var_1) {
  var_2 = self.owner;
  self endon("death");
  self endon("exit_chopper_intro");
  self endon("start_chopper_use");
  level endon("game_ended");
  var_2 waittill(var_0);

  if(var_0 == "disconnect") {
    level.incomingallchoppergunners--;

    if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
      level.incomingchoppergunners[self.team]--;
    }
  }

  if(isDefined(var_2)) {
    var_2 unlink();
    var_2 disablephysicaldepthoffieldscripting();
    var_2 scripts\common\utility::allow_fire(1);
    var_2 scripts\common\utility::allow_melee(1);
    var_2 scripts\common\utility::allow_weapon_switch(1);
    var_2 scripts\common\utility::allow_usability(1);
    var_2 scripts\common\utility::allow_shellshock(1);
    var_2 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var_1.streakname, "off");
    var_2 setclientomnvar("ui_apache_screens_state", 0);
    var_2 painvisionon();
    var_2 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    var_2 visionsetkillstreakforplayer("");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_2, 0);
  }

  thread choppergunner_explode();
  self notify("exit_chopper_intro");
}

function goal_ar(var_0) {
  self endon("death");
  self endon("exit_chopper_intro");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  return true;
}

function choppergunner_playdofintroeffects() {
  self endon("death");
  self endon("exit_chopper_intro");
  self.owner endon("disconnect");
  self.owner enablephysicaldepthoffieldscripting();
  self.owner setphysicaldepthoffield(4, 5000, 10, 10);
  wait 2;
  self.owner setphysicaldepthoffield(4, 20, 5, 10);
  wait 1.5;
  self.owner setphysicaldepthoffield(4, 1, 3, 10);
}

function choppergunner_playercameratransition(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_5 = self getEye();
  var_6 = self.angles;

  if(isDefined(var_1)) {
    var_5 = var_1;
  }

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  var_7 = spawn("script_model", var_5);
  var_7 setModel("tag_player");
  var_7.owner = self;
  var_7.angles = var_6;
  var_8 = undefined;
  var_9 = undefined;

  if(isDefined(var_0)) {
    var_8 = var_0.origin;
    var_9 = var_0.angles;
  }

  if(isDefined(var_3)) {
    var_8 = var_3;
  }

  if(isDefined(var_4)) {
    var_9 = var_4;
  }

  if(isDefined(var_0)) {
    choppergunner_startfadetransition();
  } else {
    thread choppergunner_startfadetransition();
  }

  self playerlinkweaponviewtodelta(var_7, "tag_player", 1, 0, 0, 0, 0, 1);
  self playerlinkedsetviewznear(0);
  self visionsetkillstreakforplayer("tac_ops_slamzoom", 0.2);
  var_7 moveTo(var_8, 0.5);
  var_7 rotateTo(var_9, 0.5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self visionsetkillstreakforplayer("", 0.2);
  self unlink();
  self setplayerangles(var_9);

  if(isDefined(var_0)) {
    self playerlinkweaponviewtodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
    self playerlinkedsetviewznear(0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
    var_0 vehicleplayanim(%mp_ahotel64_intro_01);
    var_0.pilot scriptmodelplayanim("mp_player_ahotel64_intro_01");
  }

  var_7 delete();
}

function choppergunner_updateflyingspeed(var_0) {
  var_0 endon("death");
  var_0 endon("near_goal");
  level endon("game_ended");
  var_1 = var_0.speed;
  var_2 = 0.25;

  for(;;) {
    var_1 += var_2;
    var_0 vehicle_setspeed(var_1, var_0.accel);
    wait 0.05;
  }
}

function choppergunner_camerashake(var_0) {
  var_0 endon("death");
  var_0 endon("explode");
  var_0 endon("leaving");
  var_0 endon("crashing");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self earthquakeforplayer(0.07, 0.1, var_0 gettagorigin("tag_origin"), 700);
    wait 0.1;
  }
}

function choppergunner_startremotecontrol(var_0) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  var_1 = self.owner;
  var_1 disablephysicaldepthoffieldscripting();

  if(!istrue(var_0)) {
    var_1.usingchoppergunner = 1;
    var_1 scripts\common\utility::allow_fire(1);
    var_1 scripts\common\utility::allow_ads(1);
    var_1 unlink();
    var_1 remotecontrolvehicle(self);
    var_1 remotecontrolturret(self.turret);
    var_1 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
    choppergunner_updatetargetmarkergroups();
  }

  if(!isDefined(self.playersfx)) {
    self.playersfx = spawn("script_origin", self.origin);
    self.playersfx linkTo(self);
  }

  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(self, &choppergunner_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(self, &choppergunner_lockedonremovedcallback);
  self setCanDamage(1);
  thread choppergunner_handlethermalswitch(var_0);
  thread choppergunner_handlemissilefire(var_0);
  thread choppergunner_watchturretfire(var_0);
  thread choppergunner_watchgameendleave(var_0);
  thread goal_smg("disconnect");
  thread goal_smg("joined_team");
  thread goal_smg("joined_spectator");
  thread goal_smg("team_kill_punish");
  thread choppergunner_watchkills();
  thread choppergunner_handledestroyed(var_0);
  thread choppergunner_notifyonkillstreakover();

  if(!self.stopcirclesatgameend) {
    thread choppergunner_removetargetmarkergroupsonkillstreakover();
    thread choppergunner_watchearlyexit(var_0);
    thread choppergunner_watchlifetime(var_0);
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.lifetime * 1000));
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](&choppergunner_handlemissiledetection);
  }

  if(!istrue(var_0)) {
    var_1 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
    var_1 setclientomnvar("ui_apache_screens_state", 0);
    var_1 setclientomnvar("ui_apache_controls", 1);
    var_1 setclientomnvar("ui_killstreak_weapon_1_ammo", self.missilesleft);
    var_1 setclientomnvar("ui_killstreak_health", self.health / self.maxhealth);
    self.playersfx playLoopSound("veh_apache_killstreak_amb_lr");
    var_1 setclienttriggeraudiozonepartialwithfade("apache_killstreak", 1.5, "mix", "filter");
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);

  if(isDefined(level.heli_pilot_mesh)) {
    level.heli_pilot_mesh show();
    return;
  }
}

function choppergunner_lockedoncallback() {
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_lockedon");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

function choppergunner_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

function choppergunner_removetargetmarkergroupsonkillstreakover() {
  level endon("game_ended");
  self waittill("chopper_gunner_ended");
  choppergunner_updatetargetmarkergroups(1);
}

function choppergunner_updatetargetmarkergroups(var_0) {
  if(self.stopcirclesatgameend) {
    return;
  }

  if(istrue(level.loadoutsecondaryaddblueprintattachments)) {
    return;
  }

  var_1 = isDefined(self.enemytargetmarkergroup);
  var_2 = !scripts\cp_mp\emp_debuff::is_empd() && !istrue(var_0);

  if(var_2 && !var_1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "assignTargetMarkers")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "assignTargetMarkers")]]();
      return;
    }

    return;
  }

  if(!var_2 && var_1) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);
    self.enemytargetmarkergroup = undefined;
    self.friendlytargetmarkergroup = undefined;
    return;
  }
}

function choppergunner_notifyonkillstreakover() {
  level endon("game_ended");
  scripts\engine\utility::ref_143A6("leaving", "death", "explode");
  self notify("chopper_gunner_ended");

  if(isDefined(self.owner)) {
    self.owner notify("chopper_gunner_ended");
    return;
  }
}

function choppergunner_watchendstrobefx(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 scripts\engine\utility::ref_143A5("death", "leaving");
  self delete();
}

function choppergunner_startfadetransition(var_0, var_1) {
  self endon("death");
  self endon("exit_chopper_intro");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  var_2 = 0.5;

  if(istrue(var_1)) {
    var_2 = 0;
  }

  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self.owner, 1, var_2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_2);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self.owner, 0, var_2);
}

function go_to_exit_spots(var_0) {
  self endon("leaving");
  self endon("crashing");
  self endon("death");
  level endon("game_ended");
  var_1 = undefined;
  var_2 = self.origin;
  var_3 = 750;
  var_4 = 2000;
  var_5 = self.team;
  var_6 = self.lifetime;
  var_7 = self.owner;
  var_8 = 1;
  var_9 = self;
  var_10 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(isDefined(var_1) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "getCodeHandleFromScriptHandle")) {
    var_11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "getCodeHandleFromScriptHandle")]](var_1);

    for(;;) {
      var_12 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 20000), self);

      if(var_12["hittype"] != "hittype_none") {
        dlog_recordevent(var_11, var_12["position"]);
      }

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
    }

    return;
  }
}

function choppergunner_handlethermalswitch(var_0) {
  if(!istrue(var_0)) {
    var_1 = self.owner;
    var_1 thread scripts\cp_mp\utility\player_utility::watchthermalinputchange();
    choppergunner_handlethermalswitchinternal();

    if(isDefined(var_1)) {
      var_1 scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();
      return;
    }

    return;
  }
}

function choppergunner_handlethermalswitchinternal(var_0, var_1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_2 = self.owner;
  var_0 = 0;
  var_1 = ["chopper_color", "flir_0_black_to_white", "flir_1_white_to_black", "flir_2_color_gradient", "flir_3_color_gradient"];
  self.currentvisionset = "chopper_color";
  var_2 visionsetkillstreakforplayer(self.currentvisionset);

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var_0 = 1;
    var_2 scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
    self.currentvisionset = var_1[var_0];
    var_2 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.lifetime, 0);
  }

  var_3 = 1;

  for(;;) {
    var_2 setclientomnvar("ui_killstreak_thermal_mode", var_0);
    var_2 visionsetthermalforplayer(var_1[var_0]);
    var_2 waittill("switch_thermal_mode");
    var_0++;

    if(var_0 == 1) {
      var_2 scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
      self.currentvisionset = var_1[var_0];
      var_2 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.lifetime, 0);
      continue;
    }

    if(var_0 > var_3) {
      var_0 = 0;
      var_2 scripts\cp_mp\utility\player_utility::setthermalvision(0);
      self.currentvisionset = "chopper_color";
      var_2 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
    }
  }
}

function choppergunner_handlemissilefire(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_1 = self.owner;
  var_1 notifyonplayercommand("shoot_missile", "+frag");
  self.missilefireside = undefined;
  var_2 = 0;
  var_3 = 4;

  for(;;) {
    var_1 waittill("shoot_missile", var_4);

    if(self.stopcirclesatgameend && self.missilesleft == 8) {
      GscBinSkip4(0x35);
    }

    var_2++;
    self.streakinfo.shots_fired++;

    if(var_2 > var_3) {
      var_2 = 1;
    }

    self.owner earthquakeforplayer(0.25, 0.4, self.turret.origin, 150);
    self.owner playRumbleOnEntity("damage_heavy");
    var_5 = self.mpod1;

    if(!isDefined(self.missilefireside) || self.missilefireside == "right") {
      self.missilefireside = "left";
      thread choppergunner_firemissilefx(self.mpod1);
      var_5 = self.mpod1;
    } else {
      self.missilefireside = "right";
      thread choppergunner_firemissilefx(self.mpod2);
      var_5 = self.mpod2;
    }

    var_6 = self.turret gettagorigin("tag_pivot");
    var_7 = anglesToForward(self.turret gettagangles("tag_player"));
    var_8 = var_5.origin * (1, 1, 0) + (0, 0, var_6[2]);
    var_9 = var_8 + var_7 * 100;
    var_10 = var_8 + var_7 * 1000;
    var_11 = self.owner getvieworigin();
    var_12 = anglesToForward(self.owner getplayerangles());
    var_13 = var_11 + var_12 * 50000;
    var_14 = [self, self.turret, var_5];
    var_15 = scripts\engine\trace::ray_trace(var_11, var_13, var_14, scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1));
    var_16 = var_15["position"];

    if(isDefined(var_4)) {
      var_16 = var_4;
    }

    var_17 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("apache_proj_mp"), var_9, var_10, var_1);
    thread choppergunner_watchmissilestate(var_17);
    thread goal_default(var_17, self.owner, 2, 300);
    var_17.streakinfo = self.streakinfo;
    self.missilesleft--;
    var_1 setclientomnvar("ui_killstreak_weapon_1_ammo", self.missilesleft);

    if(self.missilesleft == 0) {
      if(self.stopcirclesatgameend) {
        self waittill("missiles_refilled");
        continue;
      }

      break;
    }
  }
}

function go_to_node_callback() {
  self endon("missiles_refilled");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(8);
  self.missilesleft = 8;
  self.owner setclientomnvar("ui_killstreak_weapon_1_ammo", self.missilesleft);
  self notify("missiles_refilled");
}

function choppergunner_watchturretfire(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  for(;;) {
    self.turret waittill("missile_fire", var_1);
    self.owner earthquakeforplayer(0.15, 0.1, self.turret.origin, 150);
    var_1.streakinfo = self.streakinfo;
    self.streakinfo.shots_fired++;
    thread goal_default(var_1, self.owner, 0.5, 256);
  }
}

function choppergunner_firemissilefx(var_0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("fire_missile_" + var_0, "on", 0);
  wait 1;
  self setscriptablepartstate("fire_missile_" + var_0, "off", 0);
}

function choppergunner_watchmissilestate(var_0) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(isDefined(self)) {
    self missile_settargetpos(var_0);
    return;
  }
}

function choppergunner_watchlifetime(var_0) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_1 = self.lifetime;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("timeout_chopper_gunner", 1);
  thread choppergunner_leave(var_0);
}

function choppergunner_watchgameendleave(var_0) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  self.ref_12AA4 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::ref_12AA7(self.streakinfo);
  thread choppergunner_leave(var_0);
}

function goal_smg(var_0) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner waittill(var_0);
  thread choppergunner_returnplayer(0, 0);
  thread choppergunner_explode();
}

function choppergunner_watchtargets() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_attack_engage");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  for(;;) {
    var_0 = [];

    foreach(var_2 in level.players) {
      if(self.owner worldpointinreticle_circle(var_2.origin, 80, 100)) {
        if(level.teambased && var_2.team == self.team) {
          continue;
        }

        if(var_2 == self.owner) {
          continue;
        }

        var_3 = [self, self.turret];

        if(!scripts\cp_mp\utility\killstreak_utility::streakcanseetarget(self.turret gettagorigin("tag_flash"), var_2 gettagorigin("j_head"), var_3)) {
          continue;
        }

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
            continue;
          }
        }

        var_0 = choppergunner_getnearbytargets(var_2);
        break;
      }

      wait 0.05;
    }

    if(var_0.size > 0 && var_0.size < 2) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_attack_single");
    } else if(var_0.size >= 2) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_attack_multi");
    }

    wait randomintrange(5, 15);
  }
}

function choppergunner_getnearbytargets(var_0) {
  var_1 = scripts\common\utility::playersincylinder(var_0.origin, 300);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(level.teambased && var_4.team != var_0.team) {
      continue;
    }

    if(!level.teambased && var_4 == self.owner) {
      continue;
    }

    var_2 = var_4;
  }

  return var_2;
}

function choppergunner_watchkills() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner endon("disconnect");

  for(;;) {
    self.owner waittill("update_rapid_kill_buffered", var_0, var_1);
    wait 1;

    if(isDefined(self.owner.recentkillcount)) {
      if(self.owner.recentkillcount >= 1 && var_1 == "apache_proj_mp") {
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_killconf_missile");
        continue;
      }

      if(self.owner.recentkillcount == 1) {
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_killconf_single");
        continue;
      }

      if(self.owner.recentkillcount >= 2) {
        scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_killconf_multi");
      }
    }
  }
}

function choppergunner_leave(var_0) {
  self endon("death");
  self endon("crashing");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  thread choppergunner_returnplayer(0, var_0);
  self vehicle_setspeed(50, 25);
  var_1 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var_1 += (0, 0, 1000);
  self setvehgoalpos(var_1, 1);
  self setneargoalnotifydist(100);
  self waittill("near_goal");
  var_2 = choppergunner_getpathend();
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(150, 50);
  self setvehgoalpos(var_2, 1);
  self waittill("goal");
  self notify("gone");
  thread choppergunner_delete(0);
}

function choppergunner_getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

function choppergunner_handledamage() {
  self setCanDamage(1);
}

function choppergunner_modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(isDefined(self.owner) && isusingchoppergunner(self.owner)) {
    var_6 = "light";

    if(isexplosivedamagemod(var_3)) {
      if(ceil(var_4 / self.maxhealth) >= 0.33) {
        self.owner earthquakeforplayer(0.25, 0.2, self.turret.origin, 150);
        self.owner playRumbleOnEntity("damage_heavy");
        var_6 = "heavy";
      } else {
        self.owner earthquakeforplayer(0.15, 0.15, self.turret.origin, 150);
        self.owner playRumbleOnEntity("damage_light");
      }
    }

    thread choppergunner_screeninterference(0.2, var_6);
  }

  self.currenthealth = self.health - var_4;

  if(self.currenthealth <= 1500 && self.currentdamagestate == 0) {
    self.currentdamagestate = 1;
    self setscriptablepartstate("body_damage_light", "on");

    if(isDefined(self.owner) && isusingchoppergunner(self.owner)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_light_damage");
    }
  } else if(self.currenthealth <= 1000 && self.currentdamagestate == 1) {
    self.currentdamagestate = 2;
    self setscriptablepartstate("body_damage_medium", "on");

    if(isDefined(self.owner) && isusingchoppergunner(self.owner)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_med_damage");
    }
  } else if(self.currenthealth <= 500 && self.currentdamagestate == 2) {
    self.currentdamagestate = 3;
    self setscriptablepartstate("body_damage_heavy", "on");

    if(isDefined(self.owner) && isusingchoppergunner(self.owner)) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_heavy_damage");
    }
  }

  self.owner setclientomnvar("ui_killstreak_health", self.currenthealth / self.maxhealth);
  return true;
}

function choppergunner_handledeathdamage(var_0) {
  self.killedbyweapon = var_0.objweapon;
  return true;
}

function choppergunner_handledestroyed(var_0) {
  self endon("gone");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.owner) && isusingchoppergunner(self.owner)) {
    thread choppergunner_returnplayer(1, var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](self.killedbyweapon)) {
      choppergunner_crash(150);
    }
  }

  thread choppergunner_explode();
}

function choppergunner_crash(var_0, var_1) {
  self endon("explode");
  self clearlookatent();
  self notify("crashing");
  self playsoundonmovingent("veh_apache_explode_mp");
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(var_0, 20, 20);
  self setneargoalnotifydist(100);
  var_2 = choppergunner_findcrashposition(1250);

  if(!isDefined(var_2)) {
    return;
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_crash", 1);
  self setvehgoalpos(var_2, 0);
  thread choppergunner_spinout(var_0);
  thread scripts\common\anim::anim_single_solo(self, "vehicle_crash");
  scripts\common\anim::anim_single_solo(self.pilot, "pilot_crash", "body_animate_jnt");
  scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
}

function choppergunner_spinout(var_0) {
  self endon("death");
  self setyawspeed(var_0, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var_0 * 0.6);
    wait 0.5;
  }
}

function choppergunner_findcrashposition(var_0) {
  var_1 = self.origin;
  var_2 = 1000;
  var_3 = undefined;
  var_4 = anglesToForward(self.angles);
  var_5 = anglestoright(self.angles);
  var_6 = var_1 + var_4 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 - var_4 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + var_5 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 - var_5 * var_0 - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_4 + var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_4 - var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (var_5 - var_4) - (0, 0, var_2);
  var_7 = scripts\engine\trace::ray_trace(var_1, var_6, self);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  var_6 = var_1 + 0.707 * var_0 * (-1 * var_4 - var_5) - (0, 0, var_2);

  if(scripts\engine\trace::ray_trace_passed(var_1, var_6, self)) {
    var_3 = var_6;
    return var_3;
  }

  return var_3;
}

function choppergunner_explode() {
  self notify("explode");

  if(isDefined(self.owner)) {
    self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "apache_turret_mp");
  }

  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  thread choppergunner_delete(1);
}

function choppergunner_delete(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - chopperGunner", self.owner);
  }

  self.streakinfo.onspray = istrue(var_0);

  if(!istrue(self.ref_12AA4)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::ref_12AA7(self.streakinfo);
  }

  self stoploopsound();

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  if(isDefined(self.turretfx)) {
    self.turretfx delete();
  }

  if(isDefined(self.cockpitcamera)) {
    self.cockpitcamera delete();
  }

  if(isDefined(self.firetarget)) {
    self.firetarget delete();
  }

  if(isDefined(self.turret)) {
    self.turret setentityowner(undefined);
    self.turret delete();
  }

  if(isDefined(self.mpod1)) {
    self.mpod1 setentityowner(undefined);
    self.mpod1 delete();
  }

  if(isDefined(self.mpod2)) {
    self.mpod2 setentityowner(undefined);
    self.mpod2 delete();
  }

  level.choppergunners = scripts\engine\utility::array_remove(level.choppergunners, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function choppergunner_returnplayer(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("disconnect");
  self.turretfx setscriptablepartstate("camera_damage_light", "off");
  self.turretfx setscriptablepartstate("camera_damage_medium", "off");
  self.turretfx setscriptablepartstate("camera_damage_heavy", "off");

  if(isDefined(level.heli_pilot_mesh)) {
    level.heli_pilot_mesh hide();
  }

  if(isDefined(self.playersfx)) {
    self.playersfx stoploopsound();
    self.playersfx delete();
  }

  choppergunner_lockedonremovedcallback();
  var_2 clearclienttriggeraudiozone(0.5);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);
  }

  if(isDefined(var_2)) {
    if(!istrue(var_1)) {
      var_2 visionsetthermalforplayer("");
      var_2 scripts\cp_mp\utility\player_utility::setthermalvision(0);
      var_2 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
      var_2 setclientomnvar("ui_apache_controls", 0);
      var_2 remotecontrolvehicleoff();
      var_2 remotecontrolturretoff(self.turret);
      var_2 visionsetkillstreakforplayer("");
      var_2 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
      var_2 scripts\common\utility::allow_melee(1);
      var_2 scripts\common\utility::allow_weapon_switch(1);
      var_2 scripts\common\utility::allow_usability(1);
      var_2 scripts\common\utility::allow_ads(0);
      var_2 scripts\common\utility::allow_shellshock(1);

      if(istrue(var_0)) {
        var_2 setclientomnvar("ui_apache_screens_state", 2);
        var_2 setplayerangles(self.angles);
        var_2 playerlinkweaponviewtodelta(self, "tag_player", 1, 0, 0, 0, 0, 1);
        var_2 playerlinkedsetviewznear(0);
        var_2 playlocalsound("mp_killstreak_apache_death_plr");
        self waittill("explode");
        var_2 unlink();
      }

      level thread scripts\cp_mp\utility\killstreak_utility::ref_12CC6(var_2);
      var_2 setclientomnvar("ui_apache_screens_state", 0);
      var_2 painvisionon();
      var_2 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
      var_2.usingchoppergunner = undefined;
    }
  }

  self.streakinfo notify("killstreak_finished_with_deploy_weapon");
}

function choppergunner_watchearlyexit(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("leaving");
  }

  self waittill("killstreakExit");
  thread choppergunner_leave(var_0);
}

function choppergunner_handlemissiledetection(var_0, var_1, var_2, var_3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var_2)) {
      break;
    }

    var_4 = var_2 getpointinbounds(0, 0, 0);
    var_5 = distance(self.origin, var_4);

    if(var_5 < 4000 && var_2.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](var_2);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
        var_2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, var_3);
      }

      var_2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_flares");
      var_6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
        var_6 = var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](var_0);
      }

      self missile_settargetEnt(var_6);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function isusingchoppergunner() {
  return isDefined(self.usingchoppergunner);
}

function choppergunner_screeninterference(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("leaving");

  if(isDefined(var_2)) {
    var_3 = choppergunner_getvisionsetformat(self.currentvisionset);
    var_4 = choppergunner_getvisionsetbystrength(var_3, var_1);

    if(var_3 == "flir") {
      var_2 visionsetthermalforplayer(var_4);
    } else {
      var_2 visionsetkillstreakforplayer(var_4);
    }

    if(isDefined(var_0) && isDefined(self.currentvisionset)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

      if(var_3 == "flir") {
        var_2 visionsetthermalforplayer(self.currentvisionset);
        return;
      }

      var_2 visionsetkillstreakforplayer(self.currentvisionset);
      return;
    }

    return;
  }
}

function choppergunner_getvisionsetformat(var_0) {
  return scripts\engine\utility::ter_op(issubstr(var_0, "flir"), "flir", "color");
}

function choppergunner_getvisionsetbystrength(var_0, var_1) {
  var_2 = undefined;

  if(var_0 == "flir") {
    var_2 = var_0 + "_0_black_to_white_" + var_1 + "_damage";
  } else {
    var_2 = "chopper_color_" + var_1 + "_damage";
  }

  return var_2;
}

function choppergunner_empstarted(var_0) {
  thread scripts\cp_mp\emp_debuff::ref_1241A(self.owner, 5);
  choppergunner_updatetargetmarkergroups();
}

function choppergunner_empcleared(var_0) {
  choppergunner_updatetargetmarkergroups();
}

function goal_default(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self waittill("explode", var_4);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_4, var_2, var_3, var_0.team, var_1, var_0, 1);
    return;
  }
}