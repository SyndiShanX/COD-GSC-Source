/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\supers\smokeairdrop.gsc
*************************************************/

#using scripts\common\ae_utility;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\superdeploy;
#using scripts\cp_mp\supers\supers;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\bots\bots;
#using scripts\mp\damage;
#using scripts\mp\killstreaks\mapselect;
#using scripts\mp\supers;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\points;
#namespace smokeairdrop;

function function_d1f6522bc93ed94e() {
  level._effect["vfx/iw9/fieldupgrades/smokeairdrop/vfx_fieldup_smokeairdrop.vfx"] = loadfx("vfx/iw9/fieldupgrades/smokeairdrop/vfx_fieldup_smokeairdrop.vfx");
  function_7fcfdd32159bbacc();
  level.var_92e2c130a8ea2b6c = [];
}

#using_animtree("script_model");

function function_7fcfdd32159bbacc() {
  level.scr_animtree["super_smoke_airdrop"] = #animtree;
  level.scr_anim["super_smoke_airdrop"]["activate_drone_1"] = % wm_smoke_airdrop_drone_01;
  level.scr_anim["super_smoke_airdrop"]["activate_drone_2"] = % wm_smoke_airdrop_drone_02;
  level.scr_anim["super_smoke_airdrop"]["activate_drone_3"] = % wm_smoke_airdrop_drone_03;
  level.scr_anim["super_smoke_airdrop"]["activate_drone_4"] = % wm_smoke_airdrop_drone_04;
}

function function_685e618d30da1588() {
  result = thread function_5e73f80daa45f50c();
  return true;
}

function function_cd3021441020e8e5(superinfo) {
  scripts\mp\killstreaks\mapselect::function_90f093ca8576232f(0, 1, "short_arrow", undefined, superinfo);
  return true;
}

function function_269055d8846e4665() {
  self notify("cancel_all_super_deployments");
}

function function_21c87ff403d1baf6() {
  while(!istrue(scripts\mp\supers::getcurrentsuper().isinuse)) {
    waitframe();
  }

  scripts\mp\supers::refundsuper();
}

function function_9815deed1e75ef69() {
  if(!self isonground() && !self isswimming()) {
    return false;
  }

  if(self isonladder()) {
    return false;
  }

  if(istrue(self.super.isdeploying)) {
    return false;
  }

  return true;
}

function function_5e73f80daa45f50c() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("remove_super");

  if(!function_9815deed1e75ef69()) {
    function_21c87ff403d1baf6();
    return;
  }

  superinfo = scripts\mp\supers::getcurrentsuper();
  deployresult = scripts\cp_mp\superdeploy::function_8300ec48c43363d6(superinfo, makeweapon("super_remote_map_mp"), 1, &function_cd3021441020e8e5);

  if(!istrue(deployresult)) {
    function_21c87ff403d1baf6();
    return;
  }

  self playlocalsound("iw9_ks_tablet_ui_screen_plr");
  mappointinfo = scripts\mp\killstreaks\mapselect::function_a5839924b6723eac(superinfo, 1, 1);

  if(!isDefined(mappointinfo)) {
    function_21c87ff403d1baf6();
    return;
  }

  self notify("super_finished_with_deploy_weapon");
  self playlocalsound("iw9_ks_tablet_ui_select_final_plr");
  thread function_5ea4c63126ad14fc(superinfo, mappointinfo);

  if(issharedfuncdefined("supers", "superUseFinished")) {
    self[[getsharedfunc("supers", "superUseFinished")]]();
  }
}

function function_5ea4c63126ad14fc(streakinfo, mappointinfo) {
  level endon("game_ended");
  self endon("disconnect");
  waittime = getdvarfloat(@ "hash_9c4a873bf6fcab41", 1.5);
  wait waittime;

  foreach(pointinfo in mappointinfo) {
    mappt = pointinfo.location;
    directionyaw = pointinfo.angles;
    function_645ff6d87a68eb7e(mappt, directionyaw, streakinfo);
    wait 1;
  }
}

function function_645ff6d87a68eb7e(droplocation, directionyaw, streakinfo) {
  level endon("game_ended");
  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_smoke_airdrop");
  midpoint = droplocation;
  halfdistance = 1000;
  missileorientation = (0, directionyaw, 0);
  missileforward = anglesToForward(missileorientation);
  smokeforward = anglestoright(missileorientation);
  startpoint = midpoint + missileforward * -1 * halfdistance;
  endpoint = midpoint + missileforward * halfdistance;
  currentpoint = startpoint;
  totaldistance = halfdistance * 2;
  var_c622144d94ae6d95 = getdvarint(@ "hash_d6117e0006347933", bundle.var_c622144d94ae6d95);
  var_ecb39c9eecbd70ad = getdvarint(@ "hash_80d60fd8731d5fbf", 2000);
  contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 0, 0, 0, 0);
  smokepoints = [];
  var_e767d0cb155a0e85 = [];

  for(i = 0; i < var_c622144d94ae6d95; i++) {
    level thread scripts\mp\utility\debug::drawsphere(currentpoint, 10, 100, (1, 0, 0));

    smokefail = 0;
    surfaceup = anglestoup(missileorientation);
    smokepoint = currentpoint;
    starttracedown = currentpoint + anglestoup(missileorientation) * var_ecb39c9eecbd70ad;
    endtracedown = currentpoint + anglestoup(missileorientation) * var_ecb39c9eecbd70ad * -1;
    tracedown = scripts\engine\trace::ray_trace(starttracedown, endtracedown, undefined, contents);

    if(tracedown["hittype"] != "hittype_none") {
      smokepoint = tracedown["position"];

      level thread scripts\mp\utility\debug::drawsphere(smokepoint, 10, 100, (0, 1, 0));
    }

    var_5573665c23482d35 = getdvarfloat(@ "hash_fae98b333c47d007", 2000);
    var_5573665c23482d35 *= var_5573665c23482d35;

    if(distancesquared(smokepoint, currentpoint) > var_5573665c23482d35) {
      smokefail = 1;
    }

    if(!smokefail) {
      index = var_e767d0cb155a0e85.size;
      var_e767d0cb155a0e85[index] = function_495ebe31c275c3c5(smokepoint, missileorientation, var_ecb39c9eecbd70ad, index);
      smokepoints[index] = smokepoint;
    }

    currentpoint += totaldistance / var_c622144d94ae6d95 * missileforward;
  }

  var_7e544f0d6d580e78 = 0;
  var_a093aaec0039f208 = 100;
  var_35efd96aa054a86f = 300;

  for(j = 0; j < var_e767d0cb155a0e85.size; j++) {
    var_e767d0cb155a0e85[j].var_70cb65f6b1d7d192 = 0;

    if(!var_7e544f0d6d580e78 && distancesquared(smokepoints[j], droplocation) < squared(var_a093aaec0039f208)) {
      var_e767d0cb155a0e85[j].var_70cb65f6b1d7d192 = 1;
      var_7e544f0d6d580e78 = 1;
    }

    for(p = 0; p < smokepoints.size; p++) {
      if(distancesquared(smokepoints[p], smokepoints[j]) < squared(var_35efd96aa054a86f) && smokepoints[j] != smokepoints[p] && var_e767d0cb155a0e85[p].playsmokesound == 1) {
        var_e767d0cb155a0e85[j].playsmokesound = 0;
        break;
      }
    }

    var_e767d0cb155a0e85[j] childthread function_1ebb9b9e63a4df54(smokepoints[j], smokeforward);
  }

  scripts\cp_mp\challenges::function_d997435895422ecc("super_smoke_airdrop", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
}

function function_495ebe31c275c3c5(smokepoint, missileorientation, var_ecb39c9eecbd70ad, index) {
  bundle = scripts\cp_mp\supers\supers::function_bf9c7e9dd30180e3("super_smoke_airdrop");
  smokedrone = spawn("script_model", smokepoint + anglestoup(missileorientation) * var_ecb39c9eecbd70ad);
  smokedrone setModel(bundle.var_a42506617ec25a81);
  smokedrone.owner = self;
  smokedrone.angles = missileorientation;
  smokedrone.playsmokesound = 1;
  smokedrone.index = index + 1;
  smokedrone.animname = "super_smoke_airdrop";
  smokedrone scripts\common\anim::setanimtree();
  smokedrone setscriptablepartstate("smokeDeploy", "deployStart", 0);
  smokedrone scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_1d7362315a15c932);
  smokedrone scripts\cp_mp\emp_debuff::set_start_emp_callback(&function_14e878fafff171e9);
  smokedrone setentityhudoutlinedata(3, smokedrone.owner.team);
  function_6ae953c4b9e1cd89(smokedrone);

  if(getdvarint(@ "hash_819d904fd33aad", bundle.var_3718be0adde01a9d)) {
    smokedrone thread scripts\mp\damage::monitordamage(bundle.var_f823fa9135f1f5a2, "hitequip", &function_7a3c1b282cbfd3ab);
  }

  return smokedrone;
}

function function_1d7362315a15c932(data) {
  attacker = data.attacker;

  if(!isDefined(attacker)) {
    return;
  }

  self dodamage(self.maxhealth / 10, self.origin, attacker, data.inflictor);

  if(isDefined(self.damagetaken) && self.damagetaken >= 100) {
    if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
      attacker notify("destroyed_equipment");
      attacker thread scripts\mp\utility\points::doscoreevent(#"destroyed_equipment");
      attacker scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    }

    function_7a3c1b282cbfd3ab(data);
  }
}

function function_14e878fafff171e9(data) {
  attacker = data.attacker;

  if(!isDefined(attacker)) {
    return;
  }

  if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker) || getdvarint(@ "hash_58254c61de76bffe", 0)) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::doscoreevent(#"hash_6408c284f316c1d9");
    attacker scripts\mp\battlechatter_mp::equipmentdestroyed(self);
  }

  function_7a3c1b282cbfd3ab(data);
}

function function_799d835745d0b892() {
  if(self.index == 1) {
    return 4.3;
  } else if(self.index == 2) {
    return 5.5;
  } else if(self.index == 3) {
    return 5.5;
  } else if(self.index == 4) {
    return 4.8;
  }

  return 0;
}

function function_3f0235f3c067371d(drone) {
  level endon("game_ended");
  drone endon("death");
  animstring = "activate_drone_" + drone.index;
  scripts\common\anim::anim_single_solo(drone, animstring);
  drone thread function_9353aa49397987c8();
}

function function_1ebb9b9e63a4df54(point, smokeforward) {
  self endon("death");
  returnpoint = self.origin;
  mindeploytime = getdvarfloat(@ "hash_96d7e827843e457", 3);
  offset = getdvarfloat(@ "hash_320be90fa91ee74b", 1.5);
  deploytime = function_799d835745d0b892();
  dronepoint = point + anglestoup(self.angles) * 350;
  var_7622a5ad898bdbd1 = vectortoangles(smokeforward);
  scriptnode = spawnStruct();
  scriptnode.origin = dronepoint;
  scriptnode.angles = var_7622a5ad898bdbd1;
  scriptnode thread function_3f0235f3c067371d(self);

  if(self.var_70cb65f6b1d7d192) {
    self playSound("iw9_smoke_airdrop_center_incoming");
  } else {
    self playSound("iw9_smoke_airdrop_travel_incoming");
  }

  wait deploytime;
  self setscriptablepartstate("smokeDeploy", "settle", 0);

  if(getdvarint(@ "hash_abe45e35ef030a56") == 1) {
    if(getdvarint(@ "mgl", 0)) {
      thread scripts\common\ai::mgladdactivesmoke(point, 3);
    } else {
      function_8a09c0e5fa78a48c(point, 18, 300, 250);
    }
  } else {
    thread scripts\mp\bots\bots::create_smoke_occluder(point, 18);
  }

  if(self.index == 1) {
    self.owner thread scripts\mp\utility\points::doscoreevent(#"super_smoke_airdrop");
  }

  self playSound("iw9_smoke_airdrop_release");

  if(self.playsmokesound) {
    thread function_1f3e2f430f67a00b(23, self.origin - (0, 0, 100));
  }

  if(self.var_70cb65f6b1d7d192) {
    self playSound("iw9_smoke_airdrop_center_outgoing");
    return;
  }

  self playSound("iw9_smoke_airdrop_travel_outgoing");
}

function function_1f3e2f430f67a00b(smoketime, position) {
  soundorg = spawn("script_origin", position);
  soundorg playSound("iw9_smoke_airdrop_smoke_start");
  soundorg playLoopSound("iw9_smoke_airdrop_smoke_lp");
  soundorg scripts\cp_mp\ent_manager::registerspawncount(1);
  wait smoketime - 3;
  thread play_sound_in_space("iw9_smoke_airdrop_smoke_tail", position);
  wait 0.3;
  soundorg scripts\cp_mp\ent_manager::deregisterspawn();
  soundorg stoploopsound();
  soundorg delete();
}

function function_9353aa49397987c8(data) {
  level endon("game_ended");

  if(istrue(self.isdestroyed)) {
    return;
  }

  self.isdestroyed = 1;
  self notify("death");
  self setscriptablepartstate("smokeDeploy", "deployEnd", 0);
  wait 0.35;
  function_d0326bad3508b303(self);
  self delete();
}

function function_7a3c1b282cbfd3ab(data) {
  self setscriptablepartstate("destroy", "on", 0);
  function_9353aa49397987c8(data);
}

function function_6ae953c4b9e1cd89(drone) {
  level.var_92e2c130a8ea2b6c[drone getentitynumber()] = drone;
}

function function_d0326bad3508b303(drone) {
  level.var_92e2c130a8ea2b6c[drone getentitynumber()] = undefined;
}