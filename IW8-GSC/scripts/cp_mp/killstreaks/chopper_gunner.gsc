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

function weapongivenchoppergunner(var0) {
  return true;
}

function tryusechoppergunner() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("chopper_gunner", self);
  return tryusechoppergunnerfromstruct(var0);
}

function tryusechoppergunnerfromstruct(var0) {
  self endon("disconnect");
  level endon("game_ended");

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, "use_killstreak_choppergunner");
  }

  var1 = getcompleteweaponname("ks_remote_device_mp");
  var2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var0, &weapongivenchoppergunner);

  if(!istrue(var2)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      var0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  var3 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + var3 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
      }

      var0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  level.incomingallchoppergunners++;
  var4 = 1;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var4 = 2;
  }

  if(level.choppergunners.size >= var4 || level.choppergunners.size + level.incomingallchoppergunners > var4) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    level.incomingallchoppergunners--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    var0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    var5 = 1;
    level.incomingchoppergunners[self.team]++;

    if(scripts\cp_mp\utility\killstreak_utility::getnumactivekillstreakperteam(self.team, level.choppergunners) + level.incomingchoppergunners[self.team] > var5) {
      level.incomingallchoppergunners--;
      level.incomingchoppergunners[self.team]--;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_CHOPPER_GUNNER");
      }

      var0 notify("killstreak_finished_with_deploy_weapon");
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  if(level.gameended) {
    var0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  var6 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  var7 = startchoppergunnerintro(self, var0, var6);
  level.incomingallchoppergunners--;

  if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
    level.incomingchoppergunners[self.team]--;
  }

  if(!isDefined(var7)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    var0 notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("chopper_gunner", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_chopper_gunner", self);
  }

  thread choppergunner_startremotecontrol(var7);
  return true;
}

function startchoppergunnerintro(var0, var1, var2) {
  var0 disablephysicaldepthoffieldscripting();
  var3 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
  var4 = (0, 0, 0);

  if(isDefined(var3)) {
    var4 = (0, 0, var3.origin[2] - 1000);
  } else {
    var4 = (0, 0, 1500);
  }

  var6 = 9000;

  if(level.mapname == "mp_port2_gw") {
    var6 = 7000;
  }

  var7 = var0.origin - anglesToForward(var0.angles) * var6 + var4;
  var8 = var0.origin + anglesToForward(var0.angles) * 2000 + var4;
  var9 = var0.angles;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var10 = randomint(level.heli_structs_entrances.size);
    var11 = level.heli_structs_entrances[var10];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "findTargetStruct")) {
      var12 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "findTargetStruct")]](var11.script_linkto, level.heli_structs_goals);

      if(isDefined(var12)) {
        var4 = (0, 0, var12.origin[2] + 200);
        var13 = var11.origin * (1, 1, 0) + var4;
        var14 = var12.origin * (1, 1, 0) + var4;
        var15 = vectorNormalize(var14 - var13);
        var16 = 9000;

        if(level.mapname == "mp_shipment") {
          var16 = 8000;
        }

        var7 = var14 - var15 * var16;
        var8 = var14 + var15 * 1000;
        var9 = vectortoangles(var15);
      }
    }
  } else if(istrue(var0.stopcirclesatgameend) && level.script == "cp_so_aniyah") {
    if(level.players.size > 1) {
      var17 = scripts\engine\utility::array_remove(level.players, var0);
    } else {
      var17 = level.players;
    }

    var18 = scripts\engine\utility::random(var17);
    var19 = (var18.origin[0], var18.origin[1], 1750);

    while(level.ref_11f7e.size == 0) {
      waitframe();
    }

    var20 = scripts\engine\utility::getclosest(var19, level.ref_11f7e);
    var21 = (var20.origin[0], var20.origin[1], 1750);
    var22 = vectorNormalize(var19 - var21);
    var8 = var21 - var22 * 11000;
    var9 = var21 - var22 * 1000;
    var17 = vectortoangles(var22);
  } else {
    var1 iprintlnbold("Level is missing heli structs, please set them up!");
  }

  var23 = "veh8_mil_air_ahotel64_ks_mp";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var1)) {
    var23 = "veh8_mil_air_ahotel64_ks_east_mp";
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(istrue(var1.stopcirclesatgameend) && level.script == "cp_so_aniyah") {
    var24 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var1, var8, var17, "veh_apache_cp_so_aniyah", var23);
  } else {
    var24 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var2, var9, var23, "veh_apache_mp", var24);
  }

  if(!isDefined(var24)) {
    return;
  }

  var25 = 45;
  var24.speed = 100;
  var24.accel = 50;
  var24.lifetime = var25;
  var24.team = var2.team;
  var24.owner = var2;
  var24.angles = var23;
  var24.streakinfo = var3;
  var24.streakname = var3.streakname;
  var24.flaresreservecount = 1;
  var24.currentdamagestate = 0;
  var24.pathstart = var9;
  var24.pathgoal = var17;
  var24.missilesleft = 8;
  var24.animname = "ks_chopper_gunner_vehicle_camera";
  var24.stopcirclesatgameend = istrue(var2.stopcirclesatgameend);
  var24 setvehicleteam(var24.team);
  thread goal_shotgun(var24, "disconnect");
  thread goal_shotgun(var24, "joined_team");
  thread goal_shotgun(var24, "joined_spectator");
  var27 = 2000;

  if(istrue(level.istacops)) {
    var27 = 1000;
  }

  var24.health = var27;
  var24.maxhealth = var27;
  var24 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var2);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](var3.streakname, "destroyed_chopper_gunner", undefined, "timeout_chopper_gunner", "callout_destroyed_chopper_gunner");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](var3.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](var3.streakname, &choppergunner_modifydamage);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](var3.streakname, &choppergunner_handledeathdamage);
  }

  level.choppergunners[level.choppergunners.size] = var24;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var24[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var3.streakname, "Killstreak_Air", var2, 0, 1, 100);
  }

  var24 setmaxpitchroll(15, 15);
  var24 vehicle_setspeed(var24.speed, var24.accel);
  var24 sethoverparams(50, 5, 2.5);
  var24 setturningability(1);
  var24 setyawspeed(500, 100, 25, 0.5);
  var24 setotherent(var2);
  var24 setCanDamage(1);
  var24 setneargoalnotifydist(5000);
  var24 scripts\cp_mp\emp_debuff::set_start_emp_callback(&choppergunner_empstarted);
  var24 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&choppergunner_empcleared);
  var24 setscriptablepartstate("blinking_lights", "on", 0);
  var24 setscriptablepartstate("interior_light", "on", 0);
  var24 setscriptablepartstate("engine", "on", 0);
  var28 = "veh8_mil_air_ahotel64_turret_wm";

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(var2)) {
    var28 = "veh8_mil_air_ahotel64_turret_wm_east";
  }

  var24.turret = spawnturret("misc_turret", var24 gettagorigin("tag_turret"), "apache_turret_mp");
  var24.turret setModel(var28);
  var24.turret.owner = var2;
  var24.turret.team = var2.team;
  var24.turret.angles = var24.angles;
  var24.turret.streakinfo = var3;
  var24.turret linkTo(var24, "tag_turret");
  var24.turret setturretteam(var2.team);
  var24.turret setturretmodechangewait(0);
  var24.turret setmode("manual");
  var24.turret setotherent(var2);
  var24.turret setdefaultdroppitch(45);
  var24.mpod1 = spawn("script_model", var24 gettagorigin("tag_gun_l"));
  var24.mpod1 setModel("ks_apache_turret_mp");
  var24.mpod1.angles = var24.angles;
  var24.mpod1.owner = var24.owner;
  var24.mpod1.team = var24.team;
  var24.mpod1 linkTo(var24, "tag_gun_l");
  var24.mpod1 setentityowner(var2);
  var24.mpod1 setotherent(var2);
  var24.mpod2 = spawn("script_model", var24 gettagorigin("tag_gun_r"));
  var24.mpod2 setModel("ks_apache_turret_mp");
  var24.mpod2.angles = var24.angles;
  var24.mpod2.owner = var24.owner;
  var24.mpod2.team = var24.team;
  var24.mpod2 linkTo(var24, "tag_gun_r");
  var24.mpod2 setentityowner(var2);
  var24.mpod2 setotherent(var2);
  var24.turretfx = spawn("script_model", var24.turret.origin);
  var24.turretfx setModel("ks_apache_turret_mp");
  var24.turretfx.angles = var24.angles;
  var24.turretfx linkTo(var24.turret, "tag_player");
  var24.turretfx setotherent(var2);
  var24.pilot = spawn("script_model", var24 gettagorigin("tag_origin"));
  var24.pilot setModel("pilot_viewmodel_arms");
  var24.pilot.angles = var24.angles;
  var24.pilot linkTo(var24, "tag_origin");
  var24.pilot.animname = "ks_chopper_gunner_pilot";
  var24.pilot scripts\common\anim::setanimtree();
  level notify("matchrecording_chopper", var24);
  self notify("chopper_gunner_used");
  thread choppergunner_updateflyingspeed(var24);

  if(!istrue(var4)) {
    var24 setvehgoalpos(var24.pathgoal, 0);
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
    self.restoreangles = self getplayerangles();
    scripts\common\utility::allow_fire(0);
    scripts\common\utility::allow_melee(0);
    scripts\common\utility::allow_weapon_switch(0);
    scripts\common\utility::allow_usability(0);
    scripts\common\utility::allow_shellshock(0);
    thread choppergunner_camerashake(var24);
    self setclientomnvar("ui_apache_screens_state", 1);
    self playerlinkweaponviewtodelta(var24, "tag_player", 1, 0, 0, 0, 0, 1);
    self playerlinkedsetviewznear(0);
    self painvisionoff();
    scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    var24 playsoundtoplayer("mp_killstreak_apache_transition_lr", self);
  } else {
    var24 setvehgoalpos(var24.pathgoal, 1);
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var3.streakname, 1);
  thread choppergunner_playdofintroeffects();
  var24 thread scripts\common\anim::anim_single_solo(var24, "vehicle_intro");
  var24 thread scripts\common\anim::anim_single_solo(var24.pilot, "pilot_intro", "body_animate_jnt");
  thread choppergunner_startfadetransition(var24);
  var29 = goal_ar(var24, 4.25);

  if(!istrue(var29)) {
    return;
  }

  var24 notify("start_chopper_use");
  return var24;
}

function goal_shotgun(var0, var1) {
  var2 = self.owner;
  self endon("death");
  self endon("exit_chopper_intro");
  self endon("start_chopper_use");
  level endon("game_ended");
  var2 waittill(var0);

  if(var0 == "disconnect") {
    level.incomingallchoppergunners--;

    if(scripts\cp_mp\utility\game_utility::islargemap() && level.teambased) {
      level.incomingchoppergunners[self.team]--;
    }
  }

  if(isDefined(var2)) {
    var2 unlink();
    var2 disablephysicaldepthoffieldscripting();
    var2 scripts\common\utility::allow_fire(1);
    var2 scripts\common\utility::allow_melee(1);
    var2 scripts\common\utility::allow_weapon_switch(1);
    var2 scripts\common\utility::allow_usability(1);
    var2 scripts\common\utility::allow_shellshock(1);
    var2 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(var1.streakname, "off");
    var2 setclientomnvar("ui_apache_screens_state", 0);
    var2 painvisionon();
    var2 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
    var2 visionsetkillstreakforplayer("");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var2, 0);
  }

  thread choppergunner_explode();
  self notify("exit_chopper_intro");
}

function goal_ar(var0) {
  self endon("death");
  self endon("exit_chopper_intro");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
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

function choppergunner_playercameratransition(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  var5 = self getEye();
  var6 = self.angles;

  if(isDefined(var1)) {
    var5 = var1;
  }

  if(isDefined(var2)) {
    var5 = var2;
  }

  var7 = spawn("script_model", var5);
  var7 setModel("tag_player");
  var7.owner = self;
  var7.angles = var6;
  var8 = undefined;
  var9 = undefined;

  if(isDefined(var0)) {
    var8 = var0.origin;
    var9 = var0.angles;
  }

  if(isDefined(var3)) {
    var8 = var3;
  }

  if(isDefined(var4)) {
    var9 = var4;
  }

  if(isDefined(var0)) {
    choppergunner_startfadetransition();
  } else {
    thread choppergunner_startfadetransition();
  }

  self playerlinkweaponviewtodelta(var7, "tag_player", 1, 0, 0, 0, 0, 1);
  self playerlinkedsetviewznear(0);
  self visionsetkillstreakforplayer("tac_ops_slamzoom", 0.2);
  var7 moveTo(var8, 0.5);
  var7 rotateTo(var9, 0.5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self visionsetkillstreakforplayer("", 0.2);
  self unlink();
  self setplayerangles(var9);

  if(isDefined(var0)) {
    self playerlinkweaponviewtodelta(var0, "tag_player", 1, 0, 0, 0, 0, 1);
    self playerlinkedsetviewznear(0);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);
    var0 vehicleplayanim(%mp_ahotel64_intro_01);
    var0.pilot scriptmodelplayanim("mp_player_ahotel64_intro_01");
  }

  var7 delete();
}

function choppergunner_updateflyingspeed(var0) {
  var0 endon("death");
  var0 endon("near_goal");
  level endon("game_ended");
  var1 = var0.speed;
  var2 = 0.25;

  for(;;) {
    var1 += var2;
    var0 vehicle_setspeed(var1, var0.accel);
    wait 0.05;
  }
}

function choppergunner_camerashake(var0) {
  var0 endon("death");
  var0 endon("explode");
  var0 endon("leaving");
  var0 endon("crashing");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self earthquakeforplayer(0.07, 0.1, var0 gettagorigin("tag_origin"), 700);
    wait 0.1;
  }
}

function choppergunner_startremotecontrol(var0) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  var1 = self.owner;
  var1 disablephysicaldepthoffieldscripting();

  if(!istrue(var0)) {
    var1.usingchoppergunner = 1;
    var1 scripts\common\utility::allow_fire(1);
    var1 scripts\common\utility::allow_ads(1);
    var1 unlink();
    var1 remotecontrolvehicle(self);
    var1 remotecontrolturret(self.turret);
    var1 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
    choppergunner_updatetargetmarkergroups();
  }

  if(!isDefined(self.playersfx)) {
    self.playersfx = spawn("script_origin", self.origin);
    self.playersfx linkTo(self);
  }

  scripts\cp_mp\utility\weapon_utility::setlockedoncallback(self, &choppergunner_lockedoncallback);
  scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(self, &choppergunner_lockedonremovedcallback);
  self setCanDamage(1);
  thread choppergunner_handlethermalswitch(var0);
  thread choppergunner_handlemissilefire(var0);
  thread choppergunner_watchturretfire(var0);
  thread choppergunner_watchgameendleave(var0);
  thread goal_smg("disconnect");
  thread goal_smg("joined_team");
  thread goal_smg("joined_spectator");
  thread goal_smg("team_kill_punish");
  thread choppergunner_watchkills();
  thread choppergunner_handledestroyed(var0);
  thread choppergunner_notifyonkillstreakover();

  if(!self.stopcirclesatgameend) {
    thread choppergunner_removetargetmarkergroupsonkillstreakover();
    thread choppergunner_watchearlyexit(var0);
    thread choppergunner_watchlifetime(var0);
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.lifetime * 1000));
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "handleIncomingStinger")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "handleIncomingStinger")]](&choppergunner_handlemissiledetection);
  }

  if(!istrue(var0)) {
    var1 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
    var1 setclientomnvar("ui_apache_screens_state", 0);
    var1 setclientomnvar("ui_apache_controls", 1);
    var1 setclientomnvar("ui_killstreak_weapon_1_ammo", self.missilesleft);
    var1 setclientomnvar("ui_killstreak_health", self.health / self.maxhealth);
    self.playersfx playLoopSound("veh_apache_killstreak_amb_lr");
    var1 setclienttriggeraudiozonepartialwithfade("apache_killstreak", 1.5, "mix", "filter");
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

function choppergunner_updatetargetmarkergroups(var0) {
  if(self.stopcirclesatgameend) {
    return;
  }

  if(istrue(level.loadoutsecondaryaddblueprintattachments)) {
    return;
  }

  var1 = isDefined(self.enemytargetmarkergroup);
  var2 = !scripts\cp_mp\emp_debuff::is_empd() && !istrue(var0);

  if(var2 && !var1) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("chopper_gunner", "assignTargetMarkers")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("chopper_gunner", "assignTargetMarkers")]]();
      return;
    }

    return;
  }

  if(!var2 && var1) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);
    self.enemytargetmarkergroup = undefined;
    self.friendlytargetmarkergroup = undefined;
    return;
  }
}

function choppergunner_notifyonkillstreakover() {
  level endon("game_ended");
  scripts\engine\utility::ref_143a6("leaving", "death", "explode");
  self notify("chopper_gunner_ended");

  if(isDefined(self.owner)) {
    self.owner notify("chopper_gunner_ended");
    return;
  }
}

function choppergunner_watchendstrobefx(var0) {
  self endon("death");
  level endon("game_ended");
  var0 scripts\engine\utility::ref_143a5("death", "leaving");
  self delete();
}

function choppergunner_startfadetransition(var0, var1) {
  self endon("death");
  self endon("exit_chopper_intro");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  var2 = 0.5;

  if(istrue(var1)) {
    var2 = 0;
  }

  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self.owner, 1, var2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var2);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self.owner, 0, var2);
}

function go_to_exit_spots(var0) {
  self endon("leaving");
  self endon("crashing");
  self endon("death");
  level endon("game_ended");
  var1 = undefined;
  var2 = self.origin;
  var3 = 750;
  var4 = 2000;
  var5 = self.team;
  var6 = self.lifetime;
  var7 = self.owner;
  var8 = 1;
  var9 = self;
  var10 = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    var1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var2, var3, var4, var5, var6, var7, var8, var9, var10);
  }

  if(isDefined(var1) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "getCodeHandleFromScriptHandle")) {
    var11 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "getCodeHandleFromScriptHandle")]](var1);

    for(;;) {
      var12 = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 20000), self);

      if(var12["hittype"] != "hittype_none") {
        dlog_recordevent(var11, var12["position"]);
      }

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
    }

    return;
  }
}

function choppergunner_handlethermalswitch(var0) {
  if(!istrue(var0)) {
    var1 = self.owner;
    var1 thread scripts\cp_mp\utility\player_utility::watchthermalinputchange();
    choppergunner_handlethermalswitchinternal();

    if(isDefined(var1)) {
      var1 scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();
      return;
    }

    return;
  }
}

function choppergunner_handlethermalswitchinternal(var0, var1) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var2 = self.owner;
  var0 = 0;
  var1 = ["chopper_color", "flir_0_black_to_white", "flir_1_white_to_black", "flir_2_color_gradient", "flir_3_color_gradient"];
  self.currentvisionset = "chopper_color";
  var2 visionsetkillstreakforplayer(self.currentvisionset);

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    var0 = 1;
    var2 scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
    self.currentvisionset = var1[var0];
    var2 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.lifetime, 0);
  }

  var3 = 1;

  for(;;) {
    var2 setclientomnvar("ui_killstreak_thermal_mode", var0);
    var2 visionsetthermalforplayer(var1[var0]);
    var2 waittill("switch_thermal_mode");
    var0++;

    if(var0 == 1) {
      var2 scripts\cp_mp\utility\player_utility::setthermalvision(1, 12, 1000);
      self.currentvisionset = var1[var0];
      var2 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_flir_mp", "top", self.lifetime, 0);
      continue;
    }

    if(var0 > var3) {
      var0 = 0;
      var2 scripts\cp_mp\utility\player_utility::setthermalvision(0);
      self.currentvisionset = "chopper_color";
      var2 scripts\cp_mp\utility\shellshock_utility::_shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
    }
  }
}

function choppergunner_handlemissilefire(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var1 = self.owner;
  var1 notifyonplayercommand("shoot_missile", "+frag");
  self.missilefireside = undefined;
  var2 = 0;
  var3 = 4;

  for(;;) {
    var1 waittill("shoot_missile", var4);

    if(self.stopcirclesatgameend && self.missilesleft == 8) {
      GscBinSkip4(0x35);
    }

    var2++;
    self.streakinfo.shots_fired++;

    if(var2 > var3) {
      var2 = 1;
    }

    self.owner earthquakeforplayer(0.25, 0.4, self.turret.origin, 150);
    self.owner playRumbleOnEntity("damage_heavy");
    var5 = self.mpod1;

    if(!isDefined(self.missilefireside) || self.missilefireside == "right") {
      self.missilefireside = "left";
      thread choppergunner_firemissilefx(self.mpod1);
      var5 = self.mpod1;
    } else {
      self.missilefireside = "right";
      thread choppergunner_firemissilefx(self.mpod2);
      var5 = self.mpod2;
    }

    var6 = self.turret gettagorigin("tag_pivot");
    var7 = anglesToForward(self.turret gettagangles("tag_player"));
    var8 = var5.origin * (1, 1, 0) + (0, 0, var6[2]);
    var9 = var8 + var7 * 100;
    var10 = var8 + var7 * 1000;
    var11 = self.owner getvieworigin();
    var12 = anglesToForward(self.owner getplayerangles());
    var13 = var11 + var12 * 50000;
    var14 = [self, self.turret, var5];
    var15 = scripts\engine\trace::ray_trace(var11, var13, var14, scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1));
    var16 = var15["position"];

    if(isDefined(var4)) {
      var16 = var4;
    }

    var17 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("apache_proj_mp"), var9, var10, var1);
    thread choppergunner_watchmissilestate(var17);
    thread goal_default(var17, self.owner, 2, 300);
    var17.streakinfo = self.streakinfo;
    self.missilesleft--;
    var1 setclientomnvar("ui_killstreak_weapon_1_ammo", self.missilesleft);

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

function choppergunner_watchturretfire(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  for(;;) {
    self.turret waittill("missile_fire", var1);
    self.owner earthquakeforplayer(0.15, 0.1, self.turret.origin, 150);
    var1.streakinfo = self.streakinfo;
    self.streakinfo.shots_fired++;
    thread goal_default(var1, self.owner, 0.5, 256);
  }
}

function choppergunner_firemissilefx(var0) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("fire_missile_" + var0, "on", 0);
  wait 1;
  self setscriptablepartstate("fire_missile_" + var0, "off", 0);
}

function choppergunner_watchmissilestate(var0) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(isDefined(self)) {
    self missile_settargetpos(var0);
    return;
  }
}

function choppergunner_watchlifetime(var0) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var1 = self.lifetime;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);
  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("timeout_chopper_gunner", 1);
  thread choppergunner_leave(var0);
}

function choppergunner_watchgameendleave(var0) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  self.ref_12aa4 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
  thread choppergunner_leave(var0);
}

function goal_smg(var0) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner waittill(var0);
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
    var0 = [];

    foreach(var2 in level.players) {
      if(self.owner worldpointinreticle_circle(var2.origin, 80, 100)) {
        if(level.teambased && var2.team == self.team) {
          continue;
        }

        if(var2 == self.owner) {
          continue;
        }

        var3 = [self, self.turret];

        if(!scripts\cp_mp\utility\killstreak_utility::streakcanseetarget(self.turret gettagorigin("tag_flash"), var2 gettagorigin("j_head"), var3)) {
          continue;
        }

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
          if(var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
            continue;
          }
        }

        var0 = choppergunner_getnearbytargets(var2);
        break;
      }

      wait 0.05;
    }

    if(var0.size > 0 && var0.size < 2) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_attack_single");
    } else if(var0.size >= 2) {
      scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_attack_multi");
    }

    wait randomintrange(5, 15);
  }
}

function choppergunner_getnearbytargets(var0) {
  var1 = scripts\common\utility::playersincylinder(var0.origin, 300);
  var2 = [];

  foreach(var4 in var1) {
    if(level.teambased && var4.team != var0.team) {
      continue;
    }

    if(!level.teambased && var4 == self.owner) {
      continue;
    }

    var2 = var4;
  }

  return var2;
}

function choppergunner_watchkills() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner endon("disconnect");

  for(;;) {
    self.owner waittill("update_rapid_kill_buffered", var0, var1);
    wait 1;

    if(isDefined(self.owner.recentkillcount)) {
      if(self.owner.recentkillcount >= 1 && var1 == "apache_proj_mp") {
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

function choppergunner_leave(var0) {
  self endon("death");
  self endon("crashing");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  thread choppergunner_returnplayer(0, var0);
  self vehicle_setspeed(50, 25);
  var1 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
  var1 += (0, 0, 1000);
  self setvehgoalpos(var1, 1);
  self setneargoalnotifydist(100);
  self waittill("near_goal");
  var2 = choppergunner_getpathend();
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(150, 50);
  self setvehgoalpos(var2, 1);
  self waittill("goal");
  self notify("gone");
  thread choppergunner_delete(0);
}

function choppergunner_getpathend() {
  var0 = 150;
  var1 = 15000;
  var2 = self.angles[1];
  var3 = (0, var2, 0);
  var4 = self.origin + anglesToForward(var3) * var1;
  return var4;
}

function choppergunner_handledamage() {
  self setCanDamage(1);
}

function choppergunner_modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;

  if(isDefined(self.owner) && isusingchoppergunner(self.owner)) {
    var6 = "light";

    if(isexplosivedamagemod(var3)) {
      if(ceil(var4 / self.maxhealth) >= 0.33) {
        self.owner earthquakeforplayer(0.25, 0.2, self.turret.origin, 150);
        self.owner playRumbleOnEntity("damage_heavy");
        var6 = "heavy";
      } else {
        self.owner earthquakeforplayer(0.15, 0.15, self.turret.origin, 150);
        self.owner playRumbleOnEntity("damage_light");
      }
    }

    thread choppergunner_screeninterference(0.2, var6);
  }

  self.currenthealth = self.health - var4;

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

function choppergunner_handledeathdamage(var0) {
  self.killedbyweapon = var0.objweapon;
  return true;
}

function choppergunner_handledestroyed(var0) {
  self endon("gone");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.owner) && isusingchoppergunner(self.owner)) {
    thread choppergunner_returnplayer(1, var0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](self.killedbyweapon)) {
      choppergunner_crash(150);
    }
  }

  thread choppergunner_explode();
}

function choppergunner_crash(var0, var1) {
  self endon("explode");
  self clearlookatent();
  self notify("crashing");
  self playsoundonmovingent("veh_apache_explode_mp");
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(var0, 20, 20);
  self setneargoalnotifydist(100);
  var2 = choppergunner_findcrashposition(1250);

  if(!isDefined(var2)) {
    return;
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_crash", 1);
  self setvehgoalpos(var2, 0);
  thread choppergunner_spinout(var0);
  thread scripts\common\anim::anim_single_solo(self, "vehicle_crash");
  scripts\common\anim::anim_single_solo(self.pilot, "pilot_crash", "body_animate_jnt");
  scripts\cp_mp\utility\dialog_utility::playoperatorstaticinterrupt();
}

function choppergunner_spinout(var0) {
  self endon("death");
  self setyawspeed(var0, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + var0 * 0.6);
    wait 0.5;
  }
}

function choppergunner_findcrashposition(var0) {
  var1 = self.origin;
  var2 = 1000;
  var3 = undefined;
  var4 = anglesToForward(self.angles);
  var5 = anglestoright(self.angles);
  var6 = var1 + var4 * var0 - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 - var4 * var0 - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 + var5 * var0 - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 - var5 * var0 - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 + 0.707 * var0 * (var4 + var5) - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 + 0.707 * var0 * (var4 - var5) - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 + 0.707 * var0 * (var5 - var4) - (0, 0, var2);
  var7 = scripts\engine\trace::ray_trace(var1, var6, self);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  var6 = var1 + 0.707 * var0 * (-1 * var4 - var5) - (0, 0, var2);

  if(scripts\engine\trace::ray_trace_passed(var1, var6, self)) {
    var3 = var6;
    return var3;
  }

  return var3;
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

function choppergunner_delete(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - chopperGunner", self.owner);
  }

  self.streakinfo.onspray = istrue(var0);

  if(!istrue(self.ref_12aa4)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::ref_12aa7(self.streakinfo);
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

function choppergunner_returnplayer(var0, var1) {
  var2 = self.owner;
  var2 endon("disconnect");
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
  var2 clearclienttriggeraudiozone(0.5);

  if(isDefined(level.killstreakfinishusefunc)) {
    level thread[[level.killstreakfinishusefunc]](self.streakinfo);
  }

  if(isDefined(var2)) {
    if(!istrue(var1)) {
      var2 visionsetthermalforplayer("");
      var2 scripts\cp_mp\utility\player_utility::setthermalvision(0);
      var2 scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "off");
      var2 setclientomnvar("ui_apache_controls", 0);
      var2 remotecontrolvehicleoff();
      var2 remotecontrolturretoff(self.turret);
      var2 visionsetkillstreakforplayer("");
      var2 scripts\cp_mp\utility\shellshock_utility::_stopshellshock();
      var2 scripts\common\utility::allow_melee(1);
      var2 scripts\common\utility::allow_weapon_switch(1);
      var2 scripts\common\utility::allow_usability(1);
      var2 scripts\common\utility::allow_ads(0);
      var2 scripts\common\utility::allow_shellshock(1);

      if(istrue(var0)) {
        var2 setclientomnvar("ui_apache_screens_state", 2);
        var2 setplayerangles(self.angles);
        var2 playerlinkweaponviewtodelta(self, "tag_player", 1, 0, 0, 0, 0, 1);
        var2 playerlinkedsetviewznear(0);
        var2 playlocalsound("mp_killstreak_apache_death_plr");
        self waittill("explode");
        var2 unlink();
      }

      level thread scripts\cp_mp\utility\killstreak_utility::ref_12cc6(var2);
      var2 setclientomnvar("ui_apache_screens_state", 0);
      var2 painvisionon();
      var2 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
      var2.usingchoppergunner = undefined;
    }
  }

  self.streakinfo notify("killstreak_finished_with_deploy_weapon");
}

function choppergunner_watchearlyexit(var0) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("leaving");
  }

  self waittill("killstreakExit");
  thread choppergunner_leave(var0);
}

function choppergunner_handlemissiledetection(var0, var1, var2, var3) {
  self endon("death");

  for(;;) {
    if(!isDefined(var2)) {
      break;
    }

    var4 = var2 getpointinbounds(0, 0, 0);
    var5 = distance(self.origin, var4);

    if(var5 < 4000 && var2.flaresreservecount > 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "reduceReserves")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "reduceReserves")]](var2);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "playFx")) {
        var2 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "playFx")]](undefined, var3);
      }

      var2 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("chopper_gunner_flares");
      var6 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("flares", "deploy")) {
        var6 = var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("flares", "deploy")]]();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        var2[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](var0);
      }

      self missile_settargetEnt(var6);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function isusingchoppergunner() {
  return isDefined(self.usingchoppergunner);
}

function choppergunner_screeninterference(var0, var1) {
  var2 = self.owner;
  var2 endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("leaving");

  if(isDefined(var2)) {
    var3 = choppergunner_getvisionsetformat(self.currentvisionset);
    var4 = choppergunner_getvisionsetbystrength(var3, var1);

    if(var3 == "flir") {
      var2 visionsetthermalforplayer(var4);
    } else {
      var2 visionsetkillstreakforplayer(var4);
    }

    if(isDefined(var0) && isDefined(self.currentvisionset)) {
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);

      if(var3 == "flir") {
        var2 visionsetthermalforplayer(self.currentvisionset);
        return;
      }

      var2 visionsetkillstreakforplayer(self.currentvisionset);
      return;
    }

    return;
  }
}

function choppergunner_getvisionsetformat(var0) {
  return scripts\engine\utility::ter_op(issubstr(var0, "flir"), "flir", "color");
}

function choppergunner_getvisionsetbystrength(var0, var1) {
  var2 = undefined;

  if(var0 == "flir") {
    var2 = var0 + "_0_black_to_white_" + var1 + "_damage";
  } else {
    var2 = "chopper_color_" + var1 + "_damage";
  }

  return var2;
}

function choppergunner_empstarted(var0) {
  thread scripts\cp_mp\emp_debuff::ref_1241a(self.owner, 5);
  choppergunner_updatetargetmarkergroups();
}

function choppergunner_empcleared(var0) {
  choppergunner_updatetargetmarkergroups();
}

function goal_default(var0, var1, var2, var3) {
  level endon("game_ended");
  self waittill("explode", var4);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var4, var2, var3, var0.team, var1, var0, 1);
    return;
  }
}