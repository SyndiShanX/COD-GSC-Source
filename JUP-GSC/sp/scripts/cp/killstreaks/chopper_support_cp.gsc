/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\killstreaks\chopper_support_cp.gsc
************************************************************/

#using scripts\common\utility;
#using scripts\cp\vehicles\damage_cp;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\parachute;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\sentientpoolmanager;
#namespace chopper_support_cp;

function init_chopper_support() {
  scripts\engine\utility::registersharedfunc("chopper_support", "set_vehicle_hit_damage_data", &chopper_support_set_vehicle_hit_damage_data);
  level.averagealliesz = 0;
}

function chopper_support_set_vehicle_hit_damage_data(ref, hitstokill) {
  scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(ref, hitstokill);
}

function chopper_support_create_enemy_chopper(owner) {
  streakinfo = spawnStruct();
  streakinfo.streakname = "chopper_support";
  streakinfo.owner = owner;
  streakinfo.score = 0;
  streakinfo.shots_fired = 0;
  streakinfo.hits = 0;
  streakinfo.damage = 0;
  streakinfo.kills = 0;
  chopper = owner spawnenemychopper(owner, streakinfo);

  if(!isDefined(chopper)) {
    iprintln(" COULD NOT SPAWN ENEMY CHOPPER. RECHECK SCRIPT ^1 chopper_support_create_enemy_chopper(...)");
    return 0;
  }

  chopper thread startenemychopper(owner, streakinfo);
}

function spawnenemychopper(owner, streakinfo) {
  heightoffset = (0, 0, 1750);

  var_ae257a52192fe977 = getdvarint(@ "hash_90c9f37b614bae4a", 0);
  heightoffset += (0, 0, var_ae257a52192fe977);

  pathstart = owner.origin - anglesToForward(owner.angles) * 15000 + heightoffset;
  pathgoal = owner.origin + anglesToForward(owner.angles) * 2000 + heightoffset;
  angles = owner.angles;
  modifiedlifetime = getdvarint(@ "hash_d992ce3d83291d98", 45);

  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    modifiedlifetime = 9999;
  }

  goalstruct = undefined;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_8013278937ff2600 = randomint(level.heli_structs_entrances.size);
    entrancestruct = level.heli_structs_entrances[var_8013278937ff2600];
    goalstruct = choppersupport_findtargetStruct(entrancestruct.script_linkto, level.heli_structs_goals);
    var_a168db747b0d79ac = entrancestruct.origin * (1, 1, 0) + heightoffset;
    var_c32e33b4d51be12f = goalstruct.origin * (1, 1, 0) + heightoffset;
    entranceforward = vectorNormalize(var_c32e33b4d51be12f - var_a168db747b0d79ac);
    pathstart = var_c32e33b4d51be12f - entranceforward * 15000;
    pathgoal = var_c32e33b4d51be12f;
    angles = vectortoangles(entranceforward);

    debugpathing = getdvarint(@ "hash_189e3806377f69dc", 0);

    if(debugpathing) {
      pathstructs = array_combine(level.heli_structs_goals, level.heli_structs_paths);

      foreach(struct in pathstructs) {
        targetstruct = choppersupport_findtargetStruct(struct.script_linkto, pathstructs);
        sphere(struct.origin, 20, (0, 1, 1), 0, modifiedlifetime * 30);
        line(struct.origin, targetstruct.origin, (1, 1, 1), 1, 0, modifiedlifetime * 30);
      }

      sphere(var_a168db747b0d79ac, 50, (1, 1, 0), 0, 1000);
      sphere(var_c32e33b4d51be12f, 50, (1, 1, 0), 0, 1000);
      line(pathgoal, pathstart, (1, 1, 1), 1, 0, 1000);
    }
  } else {
    iprintlnbold("Level is missing heli structs, please set them up!");
  }

  var_d8af13d53a9c00a0 = "veh8_mil_air_palfa_east";
  chopper = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, pathstart, angles, "veh_chopper_support_mp", var_d8af13d53a9c00a0);

  if(!isDefined(chopper)) {
    iprintln(" COULD NOT SPAWN ENEMY CHOPPER. RECHECK SCRIPT - ^1 spawnEnemyChopper(...) ");
    return undefined;
  }

  chopper.speed = 100;
  chopper.accel = 50;
  chopper.lifetime = modifiedlifetime;
  chopper.team = "axis";
  chopper.owner = owner;
  chopper.angles = angles;
  chopper.streakinfo = streakinfo;
  chopper.streakname = streakinfo.streakname;
  chopper.flaresreservecount = 666;
  chopper.currentdamagestate = 0;
  chopper.pathstart = pathstart;
  chopper.pathgoal = pathgoal;
  chopper.currentaction = "patrol";
  chopper.currenttarget = undefined;
  chopper.currentpatrolstruct = goalstruct;
  chopper.heightoffset = heightoffset;
  chopper.crashoffset = heightoffset[2] - 750;
  chopper.stage1accradius = 50;
  chopper.stage2accradius = 25;
  chopper.stage3accradius = undefined;
  chopper.minshotstostage2acc = 7;
  chopper.minshotstostage3acc = 12;
  chopper.health = 2000;
  chopper.maxhealth = 2000;
  chopper scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);

  if(issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    chopper[[getsharedfunc("killstreak", "killstreakMakeVehicle")]](streakinfo.streakname, "destroyed_chopper_support", undefined, "callout_destroyed_chopper_support");
  }

  if(issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    chopper[[getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](streakinfo.streakname);
  }

  if(issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    chopper[[getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](streakinfo.streakname, &function_400022dabdb64055);
  }

  if(issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    chopper[[getsharedfunc("killstreak", "killstreakSetDeathCallback")]](streakinfo.streakname, &choppersupport_handledeathdamage);
  }

  level.choppersupports[level.choppersupports.size] = chopper;

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    chopper[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);
  }

  chopper setmaxpitchroll(15, 15);
  chopper vehicle_setspeed(chopper.speed, chopper.accel);
  chopper sethoverparams(50, 5, 2.5);
  chopper setturningability(0.5);
  chopper setyawspeed(100, 25, 25, 0.1);
  chopper setCanDamage(1);
  chopper setneargoalnotifydist(768);
  chopper setscriptablepartstate("blinking_lights", "on", 0);
  chopper setscriptablepartstate("engine", "on", 0);
  var_9ebe5c9daec0c8c2 = "veh8_mil_air_ahotel64_turret_wm_east";
  chopper.frontturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_front"), "chopper_support_turret_mp");
  chopper.frontturret setModel(var_9ebe5c9daec0c8c2);
  chopper.frontturret.owner = owner;
  chopper.frontturret.team = "axis";
  chopper.frontturret.angles = chopper.angles;
  chopper.frontturret.streakinfo = streakinfo;
  chopper.frontturret.turreton = 1;
  chopper.frontturret.name = "front_turret";
  chopper.frontturret.attackingtarget = undefined;
  chopper.frontturret linkTo(chopper);
  chopper.frontturret setturretteam("axis");
  chopper.frontturret setturretmodechangewait(0);
  chopper.frontturret setmode("manual");
  chopper.frontturret setdefaultdroppitch(45);
  chopper.frontturret.groundtargetent = spawn("script_model", self.origin);
  chopper.frontturret.groundtargetent setModel("tag_origin");
  chopper.frontturret.groundtargetent dontinterpolate();
  chopper.rearturret = spawnturret("misc_turret", chopper gettagorigin("tag_turret_rear"), "chopper_support_turret_mp");
  chopper.rearturret setModel(var_9ebe5c9daec0c8c2);
  chopper.rearturret.owner = owner;
  chopper.rearturret.team = "axis";
  chopper.rearturret.angles = chopper.angles;
  chopper.rearturret.streakinfo = streakinfo;
  chopper.rearturret.turreton = 1;
  chopper.rearturret.name = "rear_turret";
  chopper.rearturret.attackingtarget = undefined;
  chopper.rearturret linkTo(chopper);
  chopper.rearturret setturretteam("axis");
  chopper.rearturret setturretmodechangewait(0);
  chopper.rearturret setmode("manual");
  chopper.rearturret setdefaultdroppitch(45);
  chopper.rearturret.groundtargetent = spawn("script_model", self.origin);
  chopper.rearturret.groundtargetent setModel("tag_origin");
  chopper.rearturret.groundtargetent dontinterpolate();
  chopper.killcament = spawn("script_model", chopper gettagorigin("tag_ground"));
  chopper.killcament linkTo(chopper, "tag_ground", (-600, 0, 1000), (0, 0, 0));
  chopper.frontturret.killcament = chopper.killcament;
  chopper.rearturret.killcament = chopper.killcament;
  level notify("matchrecording_chopper", chopper);
  return chopper;
}

function startenemychopper(owner, streakinfo) {
  self endon("death");
  assert(isDefined(self));
  self setvehgoalpos(self.pathgoal, 1);
  owner playkillstreakoperatordialog("chopper_support", "use_" + streakinfo.streakname, 1);
  thread choppersupport_neargoalsettings_enemy();
  self playsoundonmovingent("ks_chopper_support_approach");

  debugtargeting = getdvarint(@ "hash_f91acea7f6a68742", 1);

  if(istrue(debugtargeting)) {
    thread function_9480f8b8d48d0f59(owner);
  }

  if(issharedfuncdefined("flares", "handleIncomingStinger")) {
    self thread[[getsharedfunc("flares", "handleIncomingStinger")]](&choppersupport_handlemissiledetection);
  }
}

function choppersupport_neargoalsettings_enemy() {
  self endon("leaving");
  self endon("death");
  self waittill("near_goal");
  self vehicle_setspeed(int(self.speed / 2), int(self.accel / 3));
  thread choppersupport_watchdestoyed();
  thread choppersupport_watchgameendleave();
  thread choppersupport_leaveoncommand_enemy();
  thread choppersupport_patrolfield_enemy(1);
  thread choppersupport_engageturrettarget_enemy(self.frontturret);
  thread choppersupport_engageturrettarget_enemy(self.rearturret);
}

function choppersupport_leaveoncommand_enemy() {
  self endon("death");
  self endon("leaving");
  level waittill("all_enemy_vehicles_leave");
  choppersupport_cleanup();
}

function choppersupport_patrolfield_enemy(initialpatrol) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self endon("engaging_target");

  if(self.currentaction != "patrol") {
    self.currentaction = "patrol";
  } else if(self.currentaction == "patrol" && !istrue(initialpatrol)) {
    return;
  }

  self setneargoalnotifydist(100);
  var_65af68838583c396 = 0;

  while(true) {
    if(self.currentaction == "attacking") {
      if(!istrue(var_65af68838583c396)) {
        var_65af68838583c396 = 1;
      }

      waitframe();
      continue;
    }

    if(!istrue(initialpatrol) && istrue(var_65af68838583c396)) {
      playkillstreakoperatordialog("chopper_support", "chopper_support_patrol");
      var_65af68838583c396 = 0;
    }

    patrolstruct = choppersupport_findclosestpatrolstruct();

    if(isDefined(patrolstruct)) {
      debugpathing = getdvarint(@ "hash_189e3806377f69dc", 0);

      if(debugpathing) {
        sphere(patrolstruct.origin, 100, (0, 1, 0), 0, 60);
      }

      choppersupport_movetolocation(patrolstruct, 1);
    } else {
      allenemies = [];
      sumvectors = (0, 0, 0);
      spawncenterpos = self.pathgoal;

      foreach(player in level.players) {
        if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
          continue;
        }

        sumvectors += player.origin;
        allenemies[allenemies.size] = player;
      }

      if(isDefined(sumvectors) && allenemies.size > 0) {
        newlocation = sumvectors / allenemies.size;

        debugpathing = getdvarint(@ "hash_189e3806377f69dc", 0);

        if(debugpathing) {
          self.owner iprintlnbold("<dev string:x1c>");
          sphere(newlocation, 100, (0, 1, 0), 0, 120);
        }

        choppersupport_movetolocation(newlocation);
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

function choppersupport_engageturrettarget_enemy(turret) {
  self endon("leaving");
  self endon("death");

  while(true) {
    if(!istrue(turret.turreton) || istrue(turret.turretdisabled)) {
      waitframe();
      continue;
    }

    targets = choppersupport_gettargets_enemy(turret, 6000, 1, 1);

    if(isDefined(targets) && targets.size > 0) {
      result = choppersupport_acquireturrettarget_enemy(turret, targets);

      if(isDefined(result) && result == "stopped_firing") {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
      }

      if(!choppersupport_checkifactivetargets()) {
        thread choppersupport_patrolfield();
      }
    }

    wait 0.05;
  }
}

function choppersupport_gettargets_enemy(turret, rangeoverride, var_f8c5d9ba90c73623, var_f537b27c366f06c9) {
  self endon("death");
  self endon("leaving");
  targets = [];
  players = level.players;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var_397eb484dfddd2da = 4500;

    if(isDefined(rangeoverride)) {
      var_397eb484dfddd2da = rangeoverride;
    }

    players = utility::playersinsphere(self.origin, var_397eb484dfddd2da);
  }

  for(i = 0; i < players.size; i++) {
    potentialtarget = players[i];
    [isvalidtarget, var_4631fdfcabb28e61, invehicle] = choppersupport_istarget_enemy(turret, potentialtarget, var_f8c5d9ba90c73623, var_f537b27c366f06c9);

    if(istrue(isvalidtarget)) {
      newtarget = spawnStruct();
      newtarget.player = potentialtarget;
      newtarget.searchfortarget = var_4631fdfcabb28e61;
      newtarget.targetvehicle = invehicle;
      targets[targets.size] = newtarget;
    } else {
      continue;
    }

    wait 0.05;
  }

  return targets;
}

function choppersupport_istarget_enemy(turret, potentialtarget, var_f8c5d9ba90c73623, var_f537b27c366f06c9) {
  self endon("death");
  self endon("leaving");

  if(!choppersupport_isplayeractive(potentialtarget)) {
    return [0, 0, 0];
  }

  if(isDefined(self.owner) && potentialtarget == self.owner && self.team == self.owner.team) {
    var_4dbe11d3bda81e4a = getdvarint(@ "hash_48714771f0d0b941", 0);

    if(var_4dbe11d3bda81e4a) {
      var_e5fedff34deb3853 = 0;

      if(istrue(var_f8c5d9ba90c73623)) {
        if(distance2dsquared(self.origin, potentialtarget.origin) > 20250000) {
          if(distance2dsquared(self.origin, potentialtarget.origin) > 36000000) {
            return [0, 0, 0];
          }

          var_e5fedff34deb3853 = 1;
        }
      }

      contentsoverride = create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
      var_b9d5783a4f34efbc = [turret];
      var_15c3c1d963654f89 = 0;

      if(istrue(var_f537b27c366f06c9)) {
        var_15c3c1d963654f89 = potentialtarget scripts\cp_mp\utility\player_utility::isinvehicle();

        if(istrue(var_15c3c1d963654f89)) {
          occupiedvehicle = potentialtarget scripts\cp_mp\utility\player_utility::getvehicle();
          var_b9d5783a4f34efbc[var_b9d5783a4f34efbc.size] = occupiedvehicle;
          linkedmodels = occupiedvehicle getlinkedchildren();

          if(isDefined(linkedmodels) && linkedmodels.size > 0) {
            var_b9d5783a4f34efbc = array_combine(var_b9d5783a4f34efbc, linkedmodels);
          }
        }
      }

      canseetarget = ray_trace_passed(turret gettagorigin("<dev string:x79>"), potentialtarget gettagorigin("<dev string:x84>"), var_b9d5783a4f34efbc, contentsoverride);

      if(!istrue(canseetarget)) {
        return [0, 0, 0];
      }

      return [1, var_e5fedff34deb3853, var_15c3c1d963654f89];
    }

    return [0, 0, 0];
  }

  if(!isDefined(potentialtarget.pers["team"])) {
    return [0, 0, 0];
  }

  if(level.teambased && potentialtarget.pers["team"] == self.team) {
    return [0, 0, 0];
  }

  if(potentialtarget.pers["team"] == "spectator") {
    return [0, 0, 0];
  }

  if(issharedfuncdefined("perk", "hasPerk")) {
    if(potentialtarget[[getsharedfunc("perk", "hasPerk")]]("specialty_blindeye")) {
      return [0, 0, 0];
    }
  }

  if(istrue(potentialtarget.inlaststand)) {
    return [0, 0, 0];
  }

  if(scripts\cp_mp\parachute::isparachutegametype() && (potentialtarget isparachuting() || potentialtarget isskydiving())) {
    return [0, 0, 0];
  }

  var_e5fedff34deb3853 = 0;

  if(istrue(var_f8c5d9ba90c73623)) {
    if(distance2dsquared(self.origin, potentialtarget.origin) > 20250000) {
      if(distance2dsquared(self.origin, potentialtarget.origin) > 36000000) {
        return [0, 0, 0];
      }

      var_e5fedff34deb3853 = 1;
    }
  }

  contentsoverride = create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_b9d5783a4f34efbc = [turret];
  var_15c3c1d963654f89 = 0;

  if(istrue(var_f537b27c366f06c9)) {
    var_15c3c1d963654f89 = potentialtarget scripts\cp_mp\utility\player_utility::isinvehicle();

    if(istrue(var_15c3c1d963654f89)) {
      occupiedvehicle = potentialtarget scripts\cp_mp\utility\player_utility::getvehicle();
      var_b9d5783a4f34efbc[var_b9d5783a4f34efbc.size] = occupiedvehicle;
      linkedmodels = occupiedvehicle getlinkedchildren();

      if(isDefined(linkedmodels) && linkedmodels.size > 0) {
        var_b9d5783a4f34efbc = array_combine(var_b9d5783a4f34efbc, linkedmodels);
      }
    }
  }

  canseetarget = ray_trace_passed(turret gettagorigin("tag_barrel"), potentialtarget gettagorigin("j_head"), var_b9d5783a4f34efbc, contentsoverride);

  if(!istrue(canseetarget)) {
    return [0, 0, 0];
  }

  return [1, var_e5fedff34deb3853, var_15c3c1d963654f89];
}

function choppersupport_acquireturrettarget_enemy(turret, targets) {
  self notify("engaging_target");
  result = undefined;
  [besttarget, searchfortarget, targetvehicle] = choppersupport_getbesttarget_enemy(turret, targets);

  if(isDefined(besttarget)) {
    var_f14a9b1e9835aeaf = undefined;

    if(istrue(targetvehicle)) {
      var_f14a9b1e9835aeaf = besttarget scripts\cp_mp\utility\player_utility::getvehicle();
    }

    choppersupport_setcurrenttarget(turret, besttarget);

    if(istrue(searchfortarget) && self.currenttarget == besttarget) {
      thread choppersupport_movetolocation(besttarget, 1);
    }

    choppersupport_fireonturrettarget(turret, besttarget, var_f14a9b1e9835aeaf, 1, searchfortarget);
    result = "stopped_firing";
  } else {
    result = "continue_searching";
  }

  return result;
}

function choppersupport_getbesttarget_enemy(turret, targets) {
  bestyaw = undefined;
  besttarget = undefined;
  var_f6227b830478253f = undefined;
  besttargetvehicle = undefined;

  foreach(targ in targets) {
    if(!choppersupport_isplayeractive(targ.player)) {
      continue;
    }

    if(choppersupport_isactivetarget(targ.player) && !istrue(targ.targetvehicle)) {
      continue;
    }

    searchfortarget = 0;
    targetvehicle = 0;
    angle = abs(vectortoangles(targ.player.origin - self.origin)[1]);
    var_a6f54781e7e6cb25 = abs(self gettagangles("tag_flash")[1]);
    angle = abs(angle - var_a6f54781e7e6cb25);
    weaponsarray = targ.player getweaponslistitems();

    foreach(weapon in weaponsarray) {
      weaponclassname = weaponclass(weapon);

      if(weaponclassname == "rocketlauncher") {
        angle -= 40;
      }
    }

    if(istrue(targ.searchfortarget)) {
      searchfortarget = 1;
      angle += 40;
    }

    if(istrue(targ.targetvehicle)) {
      targetvehicle = 1;
      angle += 20;
    }

    if(!isDefined(bestyaw) || bestyaw > angle) {
      bestyaw = angle;
      besttarget = targ.player;
      besttargetvehicle = targetvehicle;
      var_f6227b830478253f = searchfortarget;
    }
  }

  return [besttarget, var_f6227b830478253f, besttargetvehicle];
}