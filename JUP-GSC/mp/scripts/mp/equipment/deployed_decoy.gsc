/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\deployed_decoy.gsc
******************************************************/

#using scripts\common\ae_utility;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\damage;
#using scripts\mp\equipment\claymore;
#using scripts\mp\equipment\deployed_decoy;
#using scripts\mp\hud_message;
#using scripts\mp\movers;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\weapons;
#namespace deployed_decoy;

function function_35f02578b0c90838() {
  if(istrue(game["isLaunchChunk"])) {
    return;
  }

  minetriggerdata = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_deployed_decoy", 1);
  minetriggerdata.triggercallback = &function_81d957f621cb0552;

  if(isDefined(level.superglobals.staticsuperdata["super_deployed_decoy"])) {
    level.superglobals.staticsuperdata["super_deployed_decoy"].var_f6604eebabcac6c2 = &function_f4231eed765ce56c;
  }
}

function deployeddecoy_unset() {
  self notify("deployedDecoy_unset");

  if(isDefined(self.var_7f0ad61b396c9477)) {
    foreach(decoymine in self.var_7f0ad61b396c9477) {
      decoymine thread function_183a7478c53fd2f2();
    }
  }

  function_46ff5657c998dce8();
}

function function_aba5cd3449e22124(ison) {
  if(ison) {
    scripts\mp\supers::function_7203e7aa96ff0ba9(38);
    thread function_8bf69e0818e85062();
    return;
  }

  scripts\mp\supers::function_7203e7aa96ff0ba9(0, 1);
}

function function_8bf69e0818e85062() {
  if(!isDefined(level.gametypebundle) || !istrue(level.gametypebundle.var_5b66ed80c98f795b)) {
    return;
  }

  self notify("decoy_monitor_death");
  level endon("game_ended");
  self endon("decoy_monitor_death");
  self waittill("death");
  function_46ff5657c998dce8();
}

function function_3750d0e9ad3887f2() {
  self notify("deployedDecoy_parkedReady");
  self setclientomnvar("ui_deployed_decoy_use", 1);
  function_aba5cd3449e22124(1);
}

function function_b53a82180c76b481() {
  self endon("disconnect");
  self endon("deployedDecoy_parkedReady");
  level endon("game_ended");
  self setclientomnvar("ui_deployed_decoy_use", 2);
  wait 2;
  function_aba5cd3449e22124(0);
}

function function_46ff5657c998dce8() {
  self setclientomnvar("ui_deployed_decoy_use", 0);
  function_aba5cd3449e22124(0);
}

function function_9aa20ecdd4292776() {
  thread scripts\mp\damage::monitordamage(225, "hitequip", &function_1621f495789f13e3, &function_19411386fd3d2e2d);
}

function function_1621f495789f13e3(data) {
  attacker = data.attacker;

  if(!isDefined(self.owner) || istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker thread scripts\mp\utility\points::doscoreevent(#"destroyed_equipment");
    attacker thread scripts\mp\battlechatter_mp::onfieldupgradedestroy(#"bc_fieldupgrade_killfirm_inflatabledecoy");
  }

  function_5d24d48d0b8eb170(1);
}

function function_19411386fd3d2e2d(data) {
  outdamage = 0;

  if(isDefined(data.objweapon.basename)) {
    if(data.objweapon.basename == "deployed_decoy_mp") {
      return outdamage;
    }
  }

  if(!isDefined(self)) {
    return outdamage;
  }

  selforigin = self.origin;
  selfteam = self.team;
  selfowner = self.owner;
  selfmaxhealth = self.maxhealth;
  hits = function_1e1a5a07121e30f8(data);

  if(isDefined(hits)) {
    if(isDefined(selforigin) && isDefined(selfteam) && isDefined(selfowner)) {
      pinglocationenemyteams(selforigin, selfteam, selfowner);
    }

    thread function_3972a29b456ebeec(data);
    outdamage = int(ceil(min(1, hits / 10) * selfmaxhealth));
  }

  if(isDefined(data.attacker) && !function_69adb0b10bae1be4(data)) {
    data.attacker scripts\cp_mp\damagefeedback::updatedamagefeedback("hitequip", 0, 0, "hitequip", 0, 1);
  }

  thread deployeddecoy_animatehitreact(data);

  if(false) {
    outdamage = 0;
  }

  return outdamage;

  return outdamage;
}

function private deployeddecoy_animatehitreact(data) {
  self endon("death");
  self notify("deployedDecoy_animateHitReact");
  self endon("deployedDecoy_animateHitReact");
  self endon("deployedDecoy_queueDummyDestroy_Interupt");

  if(istrue(self.var_3fe87ed1237724cc)) {
    return 0;
  }

  switchstring = function_5d2ce17e3de0719b(data);

  if(isDefined(switchstring)) {
    self setscriptablepartstate("hitreact", "neutral", 0);
    waitframe();

    switch (switchstring) {
      case #"hash_d64fcbeaa252845e":
        thread function_6f3c08a3a1b58895();
        break;
      case #"hash_68a4a9ece8b99b1e":
        thread function_b6e412b5e07835a5();
        break;
      case #"hash_c3e0c50d649e2385":
        thread function_aff778ccce490bae();
        break;
      case #"hash_db4f1eafb9d628c1":
        thread function_2fc8c731d6bfd24a();
        break;
      default:
        break;
    }
  } else {
    function_46bfca70cc1648f8(data);
  }

  thread function_1c5e39beb07f8bb3();
}

function private function_5d2ce17e3de0719b(data) {
  forward = anglesToForward(self.angles);
  right = anglestoright(self.angles);
  direction = data.direction_vec;
  var_dd4fec1f7555332c = vectordot(forward, direction);
  var_8bbcf51ff5504b0d = vectordot(right, direction);

  if(var_dd4fec1f7555332c <= -0.705) {
    return "frontToBack";
  }

  if(var_dd4fec1f7555332c >= 0.705) {
    return "backToFront";
  }

  if(var_8bbcf51ff5504b0d >= 0.705) {
    return "leftToRight";
  }

  if(var_8bbcf51ff5504b0d <= -0.705) {
    return "rightToLeft";
  }
}

#using_animtree("scriptables");

function private function_6f3c08a3a1b58895() {
  self endon("deployedDecoy_animateHitReact");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  switch (self.var_9aadbd8d704d2fab) {
    case #"hash_e2fb276aea336c4c":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_front", 0);
      wait getanimlength(%iw9_mp_decoymine_hitreac_front);
      break;
    case #"hash_cb01a8c73dfd3d8e":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_crouch_hitreac_front", 0);
      wait getanimlength(%iw9_mp_decoymine_crouch_hitreac_front);
      break;
    case #"hash_db29f8f85388749":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_swim_hitreac_front", 0);
      wait getanimlength(%iw9_mp_decoymine_swim_hitreac_front);
      break;
    default:
      break;
  }
}

function private function_b6e412b5e07835a5() {
  self endon("deployedDecoy_animateHitReact");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  switch (self.var_9aadbd8d704d2fab) {
    case #"hash_e2fb276aea336c4c":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_back", 0);
      wait getanimlength(%iw9_mp_decoymine_hitreac_back);
      break;
    case #"hash_cb01a8c73dfd3d8e":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_crouch_hitreac_back", 0);
      wait getanimlength(%iw9_mp_decoymine_crouch_hitreac_back);
      break;
    case #"hash_db29f8f85388749":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_swim_hitreac_back", 0);
      wait getanimlength(%iw9_mp_decoymine_swim_hitreac_back);
      break;
    default:
      break;
  }
}

function private function_aff778ccce490bae() {
  self endon("deployedDecoy_animateHitReact");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  switch (self.var_9aadbd8d704d2fab) {
    case #"hash_e2fb276aea336c4c":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_right", 0);
      wait getanimlength(%iw9_mp_decoymine_hitreac_right);
      break;
    case #"hash_cb01a8c73dfd3d8e":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_crouch_hitreac_right", 0);
      wait getanimlength(%iw9_mp_decoymine_crouch_hitreac_right);
      break;
    case #"hash_db29f8f85388749":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_swim_hitreac_right", 0);
      wait getanimlength(%iw9_mp_decoymine_crouch_hitreac_right);
      break;
    default:
      break;
  }
}

function private function_2fc8c731d6bfd24a() {
  self endon("deployedDecoy_animateHitReact");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  switch (self.var_9aadbd8d704d2fab) {
    case #"hash_e2fb276aea336c4c":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_hitreac_left", 0);
      wait getanimlength(%iw9_mp_decoymine_hitreac_left);
      break;
    case #"hash_cb01a8c73dfd3d8e":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_crouch_hitreac_left", 0);
      wait getanimlength(%iw9_mp_decoymine_crouch_hitreac_left);
      break;
    case #"hash_db29f8f85388749":
      self setscriptablepartstate("hitreact", "iw9_mp_decoymine_swim_hitreac_left", 0);
      wait getanimlength(%iw9_mp_decoymine_swim_hitreac_left);
      break;
    default:
      break;
  }
}

function private function_1c5e39beb07f8bb3() {
  self endon("deployedDecoy_animateHitReact");
  self endon("deployedDecoy_resumeIdleAnimation_cancel");
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  wait 2;

  if(!isDefined(self)) {
    return 0;
  }

  if(istrue(self.var_3fe87ed1237724cc)) {
    return 0;
  }

  self setscriptablepartstate("idle", "neutral", 0);
  waitframe();

  switch (self.var_9aadbd8d704d2fab) {
    case #"hash_e2fb276aea336c4c":
      self setscriptablepartstate("idle", "iw9_mp_decoymine_idle", 0);
      break;
    case #"hash_cb01a8c73dfd3d8e":
      self setscriptablepartstate("idle", "iw9_mp_decoymine_crouch_idle", 0);
      break;
    case #"hash_db29f8f85388749":
      self setscriptablepartstate("idle", "iw9_mp_decoymine_swim_idle", 0);
      break;
    default:
      break;
  }
}

function function_69adb0b10bae1be4(data) {
  if(istrue(0)) {
    return false;
  }

  if(!isDefined(self.owner)) {
    return false;
  }

  if(self.owner == data.attacker) {
    return false;
  }

  return !scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, data.attacker);
}

function function_1e1a5a07121e30f8(data) {
  var_7e6d3acf41d01437 = ["MOD_GRENADE_SPLASH", "MOD_GRENADE", "MOD_EXPLOSIVE"];

  if(isDefined(data.inflictor) && isDefined(data.inflictor.classname) && data.inflictor.classname == "script_vehicle") {
    return 10;
  }

  if(function_69adb0b10bae1be4(data)) {
    return 0;
  }

  if(array_contains(var_7e6d3acf41d01437, data.meansofdeath)) {
    return 10;
  }

  if(data.meansofdeath == "MOD_IMPACT") {
    return 2;
  }

  hits = 0;

  if(data.damage >= 100) {
    return (hits + 9);
  }

  if(data.damage >= 40) {
    return (hits + 4);
  }

  return hits + 2;
}

function function_255bed505249bc85(grenade) {
  grenade endon("death");
  grenade.usedtimestamp = gettime();
  self.var_7f0ad61b396c9477[grenade.usedtimestamp] = grenade;

  if(self.var_7f0ad61b396c9477.size > 2) {
    var_37239b3e8021e7c1 = array_get_first_item(self.var_7f0ad61b396c9477);

    if(isDefined(var_37239b3e8021e7c1)) {
      var_37239b3e8021e7c1 thread function_183a7478c53fd2f2();
    }
  }

  if(isDefined(self.var_b79b9aa464c929bd)) {
    if(self.var_b79b9aa464c929bd.size > 1) {
      var_10987e27e7131c9a = array_get_first_item(self.var_b79b9aa464c929bd);
      var_10987e27e7131c9a thread function_5d24d48d0b8eb170();
    }
  }

  grenade.var_2fd40475457dffdf = grenade.owner.angles;
  grenade.triggering = 0;
  grenade.issuper = 1;
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);
  grenade thread function_2482348a6042306();
  grenade waittill("missile_stuck", stuckto);

  if(isDefined(level.var_ca4e08767cbdae12)) {
    canplant = grenade[[level.var_ca4e08767cbdae12]]();

    if(!canplant) {
      scripts\mp\supers::refundsuper();
      scripts\mp\hud_message::showerrormessage("EQUIPMENT/PLANT_FAILED");
      grenade delete();
      return;
    }
  }

  if(isDefined(stuckto)) {
    grenade.var_4e068e1c487dbebc = stuckto;
  }

  grenade.angles = grenade.var_2fd40475457dffdf;
  grenade.var_2fd40475457dffdf = undefined;

  if(!scripts\cp_mp\utility\killstreak_utility::function_3c5c5d86ef14420e(grenade.var_4e068e1c487dbebc)) {
    grenade function_85364189c6f041d7();
  }

  grenade thread function_d030dd50ce502ce4();
  scripts\cp_mp\challenges::function_d997435895422ecc("super_deployed_decoy", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));

  if(true) {
    grenade thread function_fa6a545da2197663();
  }
}

function function_85364189c6f041d7() {
  self endon("death");
  forward = anglesToForward(self.angles);
  up = anglestoup(self.angles);
  self.var_21b8be41b5b72905 = [self.origin];
  ignorelist = [];
  ignorelist[0] = self;
  contents = scripts\engine\trace::create_default_contents(1);
  var_2c7cfe7b49cabd76 = scripts\cp_mp\utility\killstreak_utility::function_3c5c5d86ef14420e(self.var_4e068e1c487dbebc);
  var_628c601da57430da = var_2c7cfe7b49cabd76 ? 4 : 8;
  var_2da991e151cfb17f = var_2c7cfe7b49cabd76 ? 90 : 45;

  for(i = 0; i <= var_628c601da57430da; i++) {
    degrees = 0 + var_2da991e151cfb17f * i;
    rot = rotatepointaroundvector(up, forward, degrees);
    rot = vectorNormalize(rot) * 28;
    rot = self.origin + rot;
    castresults = scripts\engine\trace::ray_trace(self.origin, rot, ignorelist, contents, 0, 1, 0);
    hadhit = isDefined(castresults) && castresults.size > 0 && castresults["hittype"] != "hittype_none";

    if(hadhit) {
      var_92890a1f9c92f102 = castresults["position"] - rot;
      var_92890a1f9c92f102 *= 2;
      var_92890a1f9c92f102 = self.origin + var_92890a1f9c92f102;
      self.var_21b8be41b5b72905[self.var_21b8be41b5b72905.size] = var_92890a1f9c92f102;
    }

    if(true) {
      colorred = (1, 0, 0);
      colorgreen = (0, 1, 0);
      spherecolor = colorgreen;
      drawduration = level.framedurationseconds * 60 * 10;

      if(hadhit) {
        spherecolor = colorred;
        drawpoint = castresults["<dev string:x1c>"];

        if(isDefined(drawpoint)) {
          thread scripts\cp_mp\utility\debug_utility::drawsphere(drawpoint, 0.5, drawduration, spherecolor);
        }
      }

      thread scripts\cp_mp\utility\debug_utility::drawsphere(rot, 1, drawduration, spherecolor);
      thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, rot, drawduration, spherecolor);
    }

    if(!var_2c7cfe7b49cabd76) {
      waitframe();
    }
  }

  self.var_94981af7e247f403 = undefined;

  while(isDefined(self.var_21b8be41b5b72905) && self.var_21b8be41b5b72905.size > 0) {
    avgpoint = undefined;

    if(isDefined(self.var_21b8be41b5b72905) && self.var_21b8be41b5b72905.size > 1) {
      avgpoint = averagepoint(self.var_21b8be41b5b72905);
    } else {
      avgpoint = self.var_21b8be41b5b72905[0];
    }

    tracedown = ray_trace(avgpoint, avgpoint + (0, 0, -24), ignorelist, contents);
    hadhit = isDefined(tracedown) && tracedown.size > 0 && tracedown["hittype"] != "hittype_none";

    if(hadhit) {
      self.var_94981af7e247f403 = tracedown["position"];

      if(true) {
        coloryellow = (1, 1, 0);
        drawduration = level.framedurationseconds * 60 * 10;
        thread scripts\cp_mp\utility\debug_utility::drawsphere(tracedown["position"], 1, drawduration, coloryellow);
      }

      candeploy = function_db978960f126d2b();

      if(candeploy != 0) {
        break;
      }
    }

    closest = self.var_21b8be41b5b72905[0];

    foreach(point in self.var_21b8be41b5b72905) {
      if(distancesquared(closest, avgpoint) > distancesquared(point, avgpoint)) {
        closest = point;
      }
    }

    self.var_21b8be41b5b72905 = array_remove(self.var_21b8be41b5b72905, closest);
  }

  if(true) {
    colorpurple = (1, 0, 1);
    drawduration = level.framedurationseconds * 60 * 10;

    if(isDefined(self.var_94981af7e247f403)) {
      thread scripts\cp_mp\utility\debug_utility::drawsphere(self.var_94981af7e247f403, 1, drawduration, colorpurple);
    }
  }

}

function function_2482348a6042306() {
  self endon("explode");
  self endon("death");
  self endon("missile_stuck");
  self waittill("missile_water_impact", var_850fdf3fb1c7eb84, var_53f81081d4e7f40b, var_71c76f81eb0c95ee);

  if(isDefined(var_53f81081d4e7f40b)) {
    self.waterimpactpos = var_53f81081d4e7f40b;
    self.ownerwasunderwater = self.owner isswimunderwater();
  }
}

function function_d030dd50ce502ce4() {
  self.owner endon("disconnect");
  self endon("death");
  self endon("mine_destroyed");
  scripts\cp_mp\ent_manager::registerspawn(1, &function_ec4ed8b35f49093);
  self.owner onequipmentplanted(self, "equip_deployed_decoy", &function_ec4ed8b35f49093);
  thread monitordisownedequipment(self.owner, self);
  function_536a359e6fa67df2();
  self setentityowner(self.owner);
  self setotherent(self.owner);
  self setnodeploy(1);
  self missilethermal();
  self missileoutline();
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1, 1);
  thread minedamagemonitor();
  thread function_9b581bb90dfe8e0f();

  if(!isbot(self.owner)) {
    self.owner thread function_60135177a2faec7c(self);
  }

  scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_3bf15b6532c44f8d);
  scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_a6d1fd8a98751a36);
  self.owner function_3750d0e9ad3887f2();
  function_49197cd063a740ea(&function_183a7478c53fd2f2);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      elevators thread scripts\common\elevators::isentitytouchingdoortrigger(self);
    }
  }

  function_fc9eaf4f16837717();
  self setscriptablepartstate("plant", "active", 0);
  function_91b48467f9da9f0e();
  self.deletefunc = &function_183a7478c53fd2f2;
  self.armed = 1;
  self.owner thread deployeddecoy_watchfordetonate();
  wait 0.5;
  thread function_8bf9fb0f704eceb0();
}

function function_536a359e6fa67df2() {
  if(isDefined(self.waterimpactpos)) {
    uptracestart = self.origin + (0, 0, 2000);
    ignorelist = function_3ad49688e4d76bf0();
    contents = scripts\engine\trace::function_b88b8bd51ea7fe24();
    castresults = scripts\engine\trace::ray_trace(self.origin, uptracestart, ignorelist, contents, 0, 1, 0);

    if(isDefined(castresults) && castresults["hittype"] != "hittype_none") {
      self.stuckwaterdepth = distance(self.origin, castresults["position"]);

      if(istrue(0)) {
        drawduration = 10;
        printduration = int(drawduration / level.framedurationseconds);
        printscale = 0.15;
        thread scripts\cp_mp\utility\debug_utility::drawsphere(uptracestart, 15, level.framedurationseconds * 60 * 5, (255, 0, 0));
        thread scripts\cp_mp\utility\debug_utility::drawsphere(castresults["<dev string:x1c>"], 15, level.framedurationseconds * 60 * 5, (0, 0, 255));
        print3d(self.origin + (0, 0, 24), "<dev string:x28>" + self.stuckwaterdepth, (0, 255, 0), 1, printscale, printduration, 1);
        thread scripts\cp_mp\utility\debug_utility::drawline(uptracestart, self.origin, level.framedurationseconds * 60 * 5, (0, 0, 255));
        thread scripts\cp_mp\utility\debug_utility::drawsphere(self.origin, 15, level.framedurationseconds * 60 * 5, (0, 255, 0));
      }
    } else {
      self.stuckwaterdepth = undefined;
    }
  }

  return self.stuckwaterdepth;
}

function function_8bf9fb0f704eceb0() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  var_a7c5aff6be6dce49 = 0;

  while(!var_a7c5aff6be6dce49) {
    self waittill("trigger_grenade", entarr);
    assert(isDefined(entarr));

    if(istrue(self.stunned) || istrue(self.owner.ksempd)) {
      continue;
    }

    foreach(ent in entarr) {
      if(!function_b49d2e0eca61db98(ent)) {
        continue;
      }

      function_5fa9e8666a1b8da(ent);

      if(self.triggerdata.btriggers) {
        thread function_81d957f621cb0552(ent);
        var_a7c5aff6be6dce49 = 1;
        break;
      }
    }
  }
}

function function_b49d2e0eca61db98(ent) {
  if(istrue(0)) {
    return false;
  }

  if(ent == self.owner) {
    return false;
  }

  if(!isDefined(ent.team) || ent.team == self.team) {
    return false;
  }

  if(!isDefined(ent.classname)) {
    return false;
  }

  if(!isPlayer(ent) && !isagent(ent)) {
    return false;
  }

  if(!isreallyalive(ent)) {
    return false;
  }

  return true;
}

function private deployeddecoy_watchfordetonate() {
  self notify("deployedDecoy_watchForDetonate");
  self endon("deployedDecoy_watchForDetonate");
  self endon("mine_destroyed");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("detonate");

    if(!istrue(self.ksempd)) {
      if(self getheldoffhand().basename == "deployed_decoy_mp" || self getheldoffhand().basename == "none" && istrue(self.isusingcamera)) {
        function_8c54dff0ad6753d4();
        break;
      }
    }
  }
}

function private function_8c54dff0ad6753d4() {
  self.var_972e08bb6f0816f1 = undefined;

  if(isDefined(self.var_7f0ad61b396c9477)) {
    foreach(decoymine in self.var_7f0ad61b396c9477) {
      decoymine function_a5577c168f2cd487();
    }
  }
}

function private function_6438a3c103f573ee(ent) {
  eorigins = [];

  if(isDefined(ent)) {
    var_ad283a45677a1ea3 = ent gettagorigin("j_mainroot");
    eorigins = [var_ad283a45677a1ea3];
    eorigins[eorigins.size] = ent gettagorigin("j_spineupper");
    eorigins[eorigins.size] = ent.origin;
  }

  return eorigins;
}

function private function_5fa9e8666a1b8da(ent) {
  self.triggerdata = undefined;
  triggerdata = spawnStruct();
  triggerdata.iscomplete = 0;
  eorigins = function_6438a3c103f573ee(ent);

  foreach(eorigin in eorigins) {
    triggerdata = spawnStruct();
    triggerdata.targetpos = eorigin;
    triggerdata.iscomplete = 1;
    triggerdata.var_f2a216076f977490 = 0;
    triggerdata.var_37e9b11a3f0f2afc = 0;
    triggerdata.var_d1fd51d0f7befd26 = 0;
    triggerdata.var_e9b7d63908996c9e = 0;
    triggerdata.var_3045266dfc71b133 = 0;
    triggerdata.btriggers = 0;
    triggerdata.var_f2a216076f977490 = function_1f54beb17865d9c2(eorigin);
    triggerdata.var_37e9b11a3f0f2afc = function_284789987babce6e(eorigin);
    triggerdata.var_d1fd51d0f7befd26 = function_5992cd0b16e52700(eorigin, 58);
    triggerdata.var_e9b7d63908996c9e = function_5992cd0b16e52700(eorigin, 40);

    if(isDefined(self.stuckwaterdepth) && istrue(self.stuckwaterdepth >= 72)) {
      triggerdata.var_3045266dfc71b133 = function_5992cd0b16e52700(eorigin, self.stuckwaterdepth);
    }

    if(isDefined(self.waterimpactpos)) {
      triggerdata.btriggers = triggerdata.var_37e9b11a3f0f2afc && (triggerdata.var_3045266dfc71b133 || triggerdata.var_d1fd51d0f7befd26);
    } else {
      triggerdata.btriggers = triggerdata.var_f2a216076f977490 && triggerdata.var_37e9b11a3f0f2afc && (triggerdata.var_d1fd51d0f7befd26 || triggerdata.var_e9b7d63908996c9e);
    }

    if(triggerdata.btriggers) {
      break;
    }
  }

  triggerdata.headroom = 0;
  triggerdata.headroom = function_db978960f126d2b();
  self.triggerdata = triggerdata;
  return self.triggerdata;
}

function private function_db978960f126d2b() {
  ignorelist = function_3ad49688e4d76bf0();
  contents = function_fb584d71af834f48();
  caststart = ter_op(isDefined(self.var_94981af7e247f403), self.var_94981af7e247f403, self.origin);
  caststart += (0, 0, 17);
  castend = caststart + (0, 0, 66);
  castresults = scripts\engine\trace::ray_trace(caststart, castend, ignorelist, contents, 0, 0);
  var_e229e51f9ff9a0e = 0;
  var_5700902c7edd5163 = undefined;

  if(isDefined(castresults["hittype"])) {
    if(castresults["hittype"] == "hittype_world" && isDefined(castresults["position"])) {
      var_5700902c7edd5163 = distance(caststart, castresults["position"]);
      thread scripts\cp_mp\utility\debug_utility::drawsphere(castresults["position"], 1, 100, (1, 0, 0));
    }
  }

  if(isDefined(var_5700902c7edd5163)) {
    if(var_5700902c7edd5163 >= 53) {
      var_e229e51f9ff9a0e = 1;
    }

    if(var_5700902c7edd5163 >= 66) {
      var_e229e51f9ff9a0e = 2;
    }
  } else {
    var_e229e51f9ff9a0e = 2;
  }

  if(true) {
    thread scripts\cp_mp\utility\debug_utility::drawline(caststart, caststart + (0, 0, 66), 5, (127, 0, 0));
  }

  return var_e229e51f9ff9a0e;
}

function private function_5992cd0b16e52700(eorigin, var_aa95611290376282) {
  ignorelist = function_3ad49688e4d76bf0();
  contents = function_ba2606cfb4c66281();
  castresults = scripts\engine\trace::ray_trace(self.origin + (0, 0, var_aa95611290376282), eorigin, ignorelist, contents, 0, 1, 0);
  hadhit = isDefined(castresults) && castresults.size > 0 && castresults["hittype"] == "hittype_entity";

  if(true) {
    if(hadhit) {
      thread scripts\cp_mp\utility\debug_utility::drawline(self.origin + (0, 0, var_aa95611290376282), eorigin, level.framedurationseconds, (0, 127, 0));
    } else {
      thread scripts\cp_mp\utility\debug_utility::drawline(self.origin + (0, 0, var_aa95611290376282), eorigin, level.framedurationseconds, (127, 0, 0));
    }
  }

  return hadhit;
}

function private function_74514723c815eeca(entorigin) {
  if(!isDefined(entorigin)) {
    return false;
  }

  forward = anglesToForward(self.angles);
  var_1650a941c8770f2f = vectorNormalize(entorigin - self.origin);
  var_3fe3a3dd483d56c9 = vectordot(forward, var_1650a941c8770f2f);
  return var_3fe3a3dd483d56c9 > 0.866 && var_3fe3a3dd483d56c9 > -0.866;
}

function private function_284789987babce6e(eorigin) {
  var_27789e85bfa3ea1f = abs(self.origin[2] - eorigin[2]);
  return 384 >= var_27789e85bfa3ea1f;
}

function private function_1f54beb17865d9c2(eorigin) {
  return 350 >= distance2d(eorigin, self.origin);
}

function function_81d957f621cb0552(attacker, ent) {
  if(isDefined(attacker)) {
    attacker endon("death_or_disconnect");
  } else {
    attacker = self.owner;
  }

  printgameaction("Decoy triggered", self.owner);
  makeexplosiveunusuabletag();
  self setscriptablepartstate("trigger", "active", 0);
  thread function_a5577c168f2cd487(attacker);
  self notify("mine_triggered");
}

function private function_9b581bb90dfe8e0f() {
  self endon("death");
  level endon("game_ended");
  owner = self.owner;
  self waittill("detonateExplosive", attacker);
  self.detonatingplayer = attacker;

  if(istrue(self.owner.ksempd)) {
    owner notify("deployedDecoy_unset");
    thread function_183a7478c53fd2f2();
    owner function_46ff5657c998dce8();
    return;
  }

  thread function_a5577c168f2cd487(attacker);
}

function function_786a7189ad105a77(var_b8f96bd12748f572) {
  if(!isDefined(self.var_7f0ad61b396c9477) || self.var_7f0ad61b396c9477.size == 0) {
    return false;
  }

  _takeweapon(var_b8f96bd12748f572);
  self clearoffhandspecial();
  self.var_972e08bb6f0816f1 = 1;
  self notify("activateDecoy", "success");
  _giveweapon(var_b8f96bd12748f572);
  self assignweaponoffhandspecial(var_b8f96bd12748f572);
  return true;
}

function private function_7168b5644ecfc7b7() {
  if(istrue(self.isjuggernaut)) {
    return false;
  }

  if(self isinfreefall()) {
    return false;
  }

  if(scripts\mp\supers::issuperready() && !istrue(self.var_972e08bb6f0816f1)) {
    return false;
  }

  if(self ishanging()) {
    return false;
  }

  if(self isthrowinggrenade()) {
    return false;
  }

  if(!val::get("supers")) {
    return false;
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    return false;
  }

  return true;
}

function private function_60135177a2faec7c(mine) {
  level endon("game_ended");
  self endon("deployedDecoy_unset");
  self notify("deployedDecoy_monitoringDetonation");
  self endon("deployedDecoy_monitoringDetonation");
  self endon("disconnect");

  if(isDefined(level.gametypebundle) && istrue(level.gametypebundle.var_5b66ed80c98f795b)) {
    self endon("death");
  }

  weaponobj = makeweapon("iw9_detonator_mp");

  while(true) {
    success = function_91132a4fd7767609();

    if(!success) {
      continue;
    }

    if(!function_7168b5644ecfc7b7()) {
      continue;
    }

    if(isDefined(mine.empcount) && mine.empcount > 0) {
      continue;
    }

    superinfo = scripts\mp\supers::getcurrentsuper();

    if(!isDefined(superinfo)) {
      continue;
    }

    if(superinfo.staticdata.ref == "super_select") {
      val::reset_all("ppmenu");
      waitframe();
    }

    var_b8518d272e4c3423 = scripts\cp_mp\utility\weapon_utility::giveandfireoffhandreliable(weaponobj);

    if(!var_b8518d272e4c3423) {
      print("<dev string:x33>");
    }

    thread function_8c54dff0ad6753d4();
    return;
  }
}

function private function_91132a4fd7767609() {
  childthread function_8711cc188d381233();
  childthread function_2708229faea7e5fd();
  self waittill("activateDecoy", msg);
  self notifyonplayercommandremove("tacButtonPress", "+smoke");
  self notifyonplayercommandremove("fragButtonPress", "+frag");
  self notifyonplayercommandremove("cameraActive", "+special");
  return msg == "success";
}

function private function_8711cc188d381233() {
  self endon("activateDecoy");
  self notifyonplayercommand("decoyExplodeKBM", "+special");
  self waittill("decoyExplodeKBM");
  self notify("activateDecoy", "success");
}

function private function_2708229faea7e5fd() {
  self endon("activateDecoy");
  self notifyonplayercommand("tacButtonPress", "+smoke");
  self notifyonplayercommand("fragButtonPress", "+frag");
  var_bd1267e9dea3dba9 = ["tacButtonPress", "fragButtonPress"];
  thread scripts\mp\supers::function_8d6d95114b2c9b0d(var_bd1267e9dea3dba9, [], 0.75);
  self waittill("controllerSuperPress", msg);
  self notify("activateDecoy", msg);
}

function private function_ba2606cfb4c66281() {
  contents = scripts\engine\trace::create_contents(1, 1, 0, 1, 1, 1, 1, 1, 1);
  return contents;
}

function private function_fb584d71af834f48() {
  contents = scripts\engine\trace::create_contents(1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0);
  return contents;
}

function private function_3ad49688e4d76bf0() {
  ignorelist = function_e0f66654476dc4f4();
  return ignorelist;
}

function private function_e0f66654476dc4f4() {
  var_f755fddcdbf39420 = 1;

  var_f755fddcdbf39420 = 1;

  ignorelist = [];

  if(var_f755fddcdbf39420) {
    ignorelist[ignorelist.size] = self.owner;
    linkedents = self getlinkedchildren(1);

    if(!isDefined(linkedents)) {
      linkedents = [];
    }

    linkedents[linkedents.size] = self getlinkedparent();

    foreach(linkedent in linkedents) {
      if(isDefined(linkedent) && linkedent.classname == "grenade") {
        ignorelist[ignorelist.size] = linkedent;
      }
    }
  }

  if(isDefined(level.dynamicladders)) {
    foreach(struct in level.dynamicladders) {
      ignorelist[ignorelist.size] = struct.ents[0];
    }
  }

  return ignorelist;
}

function private function_3bf15b6532c44f8d(data) {
  scripts\mp\equipment\claymore::claymore_empapplied(data);
}

function private function_a6d1fd8a98751a36(data) {
  function_a5577c168f2cd487(data.attacker);
}

function private function_3b1d270b83dcdd41() {
  if(!istrue(self.armed)) {
    return false;
  }

  return true;
}

function private function_2a3abc2b830ff7d2(dummy) {
  if(isDefined(dummy.nearbydoors)) {
    foreach(door in dummy.nearbydoors) {
      door thread function_3033ebeb29280a95(dummy);
    }
  }
}

function private function_3033ebeb29280a95(dummy) {
  doorstate = self getscriptablepartstate("door", 1);

  if(isDefined(doorstate) && doorstate != "frozen" && doorstate != "locked") {
    self function_c7f3ac96dd01424("away", dummy.origin);
  }
}

function private function_fab47ae10a7ec712(stuckto) {
  self endon("death");
  level endon("game_ended");
  stuckto waittill("death");
  function_5d24d48d0b8eb170(1);
}

function private function_a5577c168f2cd487(attacker) {
  self endon("death");
  self endon("mine_destroyed");

  if(!isDefined(self)) {
    return;
  }

  cachedorigin = self.origin;
  cachedteam = self.team;
  cachedowner = self.owner;
  var_2c7cfe7b49cabd76 = scripts\cp_mp\utility\killstreak_utility::function_3c5c5d86ef14420e(self.var_4e068e1c487dbebc);

  if(!function_3b1d270b83dcdd41()) {
    return;
  }

  level.mines[self getentitynumber()] = undefined;
  scripts\cp_mp\ent_manager::deregisterspawn();
  makeexplosiveunusuabletag();

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self.exploding = 1;
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  var_a199d96200a367d6 = self.angles;

  if(isDefined(attacker)) {
    if(!isDefined(self.triggerdata) || !istrue(self.triggerdata.iscomplete)) {
      function_5fa9e8666a1b8da(attacker);
    }

    if(attacker == self.owner) {
      var_a199d96200a367d6 = self.angles;
    } else {
      var_a199d96200a367d6 = vectortoangles(attacker.origin - self.origin);
      var_a199d96200a367d6 = (0, var_a199d96200a367d6[1], 0);
    }
  } else {
    function_5fa9e8666a1b8da(undefined);
  }

  if(true) {
    if(isDefined(attacker)) {
      thread scripts\cp_mp\utility\debug_utility::drawsphere(attacker.origin, 15, level.framedurationseconds, (255, 0, 0));
    }

    thread scripts\cp_mp\utility\debug_utility::drawangles(self.origin, var_a199d96200a367d6, 10, 1);
  }

  if(var_2c7cfe7b49cabd76) {
    function_85364189c6f041d7();
  }

  self.dummy = function_8958b19a2ecc8d46();
  self.owner.var_b79b9aa464c929bd[self.usedtimestamp] = self.dummy;
  self.dummy.var_9aadbd8d704d2fab = self.var_9aadbd8d704d2fab;
  self.dummy.angles = var_a199d96200a367d6;
  self.dummy.usedtimestamp = self.usedtimestamp;
  self.dummy.nearbydoors = self.nearbydoors;

  if(isDefined(self.var_4e068e1c487dbebc) && var_2c7cfe7b49cabd76) {
    self.dummy linkTo(self.var_4e068e1c487dbebc);
  } else if(isDefined(self.var_4e068e1c487dbebc)) {
    self.dummy thread function_fab47ae10a7ec712(self.var_4e068e1c487dbebc);
  }

  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
  thread scripts\mp\equipment\deployed_decoy::function_ecf65e63998a0845();
  glassradiusdamage(self.origin, 85, 75, 25);
  function_2a3abc2b830ff7d2(self.dummy);

  if(isDefined(self.dummy)) {
    self.dummy thread function_2ae474eb2c763dca(self.var_9aadbd8d704d2fab);
    self.dummy thread function_38042b771a7de69d(1);
    self.dummy function_49197cd063a740ea(&function_5d24d48d0b8eb170);

    if(isDefined(self.var_4e068e1c487dbebc)) {
      self.dummy.moving_platform = self.var_4e068e1c487dbebc;
      data = spawnStruct();
      data.linkparent = self.dummy.moving_platform;
      data.deathoverridecallback = &function_56a30ebf54077e71;
      data.validateaccuratetouching = 1;
      self.dummy thread scripts\mp\movers::handle_moving_platforms(data);
      self.dummy thread function_19c1fff6756bca97();
      self.dummy.deletefunc = &function_56a30ebf54077e71;
    } else if(isDefined(level.wztrain_info)) {
      data = spawnStruct();
      data.deathoverridecallback = &function_56a30ebf54077e71;
      self.dummy thread scripts\mp\movers::handle_moving_platforms(data);
    }
  }

  if(isDefined(cachedorigin) && isDefined(cachedteam) && isDefined(cachedowner)) {
    pinglocationenemyteams(cachedorigin, cachedteam, cachedowner);
  }

  if(isDefined(level) && isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      if(!isDefined(elevators)) {
        continue;
      }

      if(!isDefined(self)) {
        continue;
      }

      if(!isDefined(self.dummy)) {
        continue;
      }

      elevators thread scripts\common\elevators::function_29de8f099a0a63df(self.dummy);
    }
  }

  self.owner thread function_b53a82180c76b481();

  if(isDefined(self.dummy) && isDefined(self.triggerdata) && self.triggerdata.headroom == 0) {
    self.dummy thread function_5d24d48d0b8eb170(1);
  }

  function_183a7478c53fd2f2();
}

function private function_ecf65e63998a0845() {
  level endon("game_ended");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(player.team == self.team) {
      continue;
    }

    if(16 >= distance2dsquared(self.origin, player.origin)) {
      player dodamage(125, self.origin, self.owner, self, undefined, "deployed_decoy_mp", undefined, undefined);
    }
  }
}

function function_19c1fff6756bca97() {
  self endon("death");

  while(isDefined(self getlinkedparent())) {
    waitframe();
  }

  function_5d24d48d0b8eb170(1);
}

function private function_fc9eaf4f16837717() {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(self.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

function private function_a6856182b82cbc63(scriptmodelname, var_a50d4ac45ec0f007) {
  if(!isDefined(var_a50d4ac45ec0f007)) {
    spawnpos = ter_op(isDefined(self.var_94981af7e247f403), self.var_94981af7e247f403, self.origin);
  } else {
    spawnpos = ter_op(isDefined(self.var_94981af7e247f403), self.var_94981af7e247f403, self.origin) + var_a50d4ac45ec0f007;
  }

  model = spawn("script_model", spawnpos);
  model setModel(scriptmodelname);
  model.weapon_name = "deployed_decoy_mp";
  model.team = self.owner.team;
  model.owner = self.owner;
  model scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", self.owner, 1);
  return model;
}

function private function_8958b19a2ecc8d46() {
  dummy = undefined;

  if(isDefined(self.stuckwaterdepth) && self.stuckwaterdepth > 40) {
    dummy = function_120277e9245abef8();
  } else if(isDefined(self.triggerdata) && istrue(self.triggerdata.iscomplete) && istrue(self.triggerdata.var_d1fd51d0f7befd26 && !self.triggerdata.var_e9b7d63908996c9e && self.triggerdata.headroom >= 2)) {
    dummy = function_65bab2b826c7c79f();
  } else if(isDefined(self.triggerdata) && istrue(self.triggerdata.iscomplete) && istrue(!self.triggerdata.var_d1fd51d0f7befd26 && self.triggerdata.var_e9b7d63908996c9e && self.triggerdata.headroom >= 1)) {
    dummy = function_a9b9f466bd2859c7();
  } else {
    randint = randomint(2);

    if(randint > 0) {
      dummy = function_65bab2b826c7c79f();
    } else {
      dummy = function_a9b9f466bd2859c7();
    }
  }

  dummy function_9aa20ecdd4292776();
  dummy scripts\cp_mp\ent_manager::registerspawn(1, &function_d3862975bb307ee3);
  return dummy;
}

function private function_65bab2b826c7c79f() {
  outmodel = function_a6856182b82cbc63("offhand_2h_wm_decoy_mine_dummy01_v0_mp");
  self.var_9aadbd8d704d2fab = "dummy_standing";
  return outmodel;
}

function private function_a9b9f466bd2859c7() {
  outmodel = function_a6856182b82cbc63("offhand_2h_wm_decoy_mine_dummy02_v0_mp");
  self.var_9aadbd8d704d2fab = "dummy_crouching";
  return outmodel;
}

function private function_120277e9245abef8() {
  outmodel = function_a6856182b82cbc63("offhand_2h_wm_decoy_mine_dummy03_v0_mp", (0, 0, self.stuckwaterdepth - 8));
  self.var_9aadbd8d704d2fab = "dummy_swimming";
  return outmodel;
}

function private function_2ae474eb2c763dca(instring) {
  self.owner endon("disconnect");
  self endon("death");
  level endon("endgame");

  if(!isDefined(instring)) {
    return 0;
  }

  switch (instring) {
    case #"hash_e2fb276aea336c4c":
      self setscriptablepartstate("inflate", "iw9_mp_decoymine_inflate", 0);
      wait getanimlength(%iw9_mp_decoymine_inflate);
      self setscriptablepartstate("idle", "iw9_mp_decoymine_idle", 0);
      self setscriptablepartstate("inflate", "neutral", 0);
      break;
    case #"hash_cb01a8c73dfd3d8e":
      self setscriptablepartstate("inflate", "iw9_mp_decoymine_crouch_inflate", 0);
      wait getanimlength(%iw9_mp_decoymine_crouch_inflate);
      self setscriptablepartstate("idle", "iw9_mp_decoymine_crouch_idle", 0);
      self setscriptablepartstate("inflate", "neutral", 0);
      break;
    case #"hash_db29f8f85388749":
      self setscriptablepartstate("inflate", "iw9_mp_decoymine_swim_inflate", 0);
      wait getanimlength(%iw9_mp_decoymine_swim_inflate);
      self setscriptablepartstate("idle", "iw9_mp_decoymine_swim_idle", 0);
      self setscriptablepartstate("inflate", "neutral", 0);
      break;
    default:
      break;
  }
}

function private function_3f3ce37397b66e92(instring, var_4ba1c61df5b425cc) {
  self endon("death");

  switch (instring) {
    case #"hash_e2fb276aea336c4c":
      if(istrue(var_4ba1c61df5b425cc)) {
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_pop", 0);
        wait getanimlength(%iw9_mp_decoymine_pop);
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        wait 0.4;
        glassradiusdamage(self.origin, 72, 75, 25);
        self setscriptablepartstate("deflate", "neutral", 0);
      } else {
        self setscriptablepartstate("hitreact", "neutral", 0);
        self setscriptablepartstate("idle", "neutral", 0);
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_deflate", 0);
        wait getanimlength(%iw9_mp_decoymine_deflate);
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        self setscriptablepartstate("deflate", "neutral", 0);
      }

      break;
    case #"hash_cb01a8c73dfd3d8e":
      if(istrue(var_4ba1c61df5b425cc)) {
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_crouch_pop", 0);
        wait getanimlength(%iw9_mp_decoymine_crouch_pop);
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        wait 0.4;
        glassradiusdamage(self.origin, 72, 75, 25);
        self setscriptablepartstate("deflate", "neutral", 0);
      } else {
        self setscriptablepartstate("hitreact", "neutral", 0);
        self setscriptablepartstate("idle", "neutral", 0);
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_crouch_deflate", 0);
        wait getanimlength(%iw9_mp_decoymine_crouch_deflate);
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        self setscriptablepartstate("deflate", "neutral", 0);
      }

      break;
    case #"hash_db29f8f85388749":
      if(istrue(var_4ba1c61df5b425cc)) {
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_swim_pop", 0);
        wait getanimlength(%iw9_mp_decoymine_swim_pop);
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        wait 0.4;
        glassradiusdamage(self.origin, 72, 75, 25);
        self setscriptablepartstate("dummy_vis", "dummy_vis_hide", 0);
        self setscriptablepartstate("deflate", "neutral", 0);
      } else {
        self setscriptablepartstate("hitreact", "neutral", 0);
        self setscriptablepartstate("idle", "neutral", 0);
        self setscriptablepartstate("deflate", "iw9_mp_decoymine_swim_deflate", 0);
        wait getanimlength(%iw9_mp_decoymine_swim_deflate);
        self setscriptablepartstate("deflate", "neutral", 0);
      }

      break;
    default:
      assertmsg("<dev string:x78>");
      break;
  }
}

function private function_38042b771a7de69d(delay) {
  level endon("game_ended");
  self endon("death");
  self endon("destroy");

  if(isDefined(delay)) {
    wait delay;
  }

  switch (self.var_9aadbd8d704d2fab) {
    case #"hash_e2fb276aea336c4c":
      self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 65, undefined, undefined, undefined, 0, 1, 0, undefined, 0);
      break;
    case #"hash_cb01a8c73dfd3d8e":
      self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 52, undefined, undefined, undefined, 0, 1, 0, undefined, 0);
      break;
    case #"hash_db29f8f85388749":
      self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 29, undefined, undefined, undefined, 0, 1, 0, undefined, 0);
      break;
    default:
      break;
  }
}

function private function_91b48467f9da9f0e() {
  var_913576e1dc1762b5 = getentitylessscriptablearray(undefined, undefined, self.origin, 75);
  self.nearbydoors = [];

  foreach(foundentity in var_913576e1dc1762b5) {
    if(foundentity scriptableisdoor() || foundentity scriptabledoorisdouble()) {
      self.nearbydoors[self.nearbydoors.size] = foundentity;
    }
  }
}

function function_183a7478c53fd2f2() {
  level endon("endgame");

  if(isDefined(self)) {
    self setscriptablepartstate("destroy", "active", 0);
    childthread function_ec4ed8b35f49093();
  }
}

function function_ec4ed8b35f49093() {
  self endon("death");
  level endon("endgame");

  if(isDefined(self)) {
    self setscriptablepartstate("hack_usable", "off");

    if(isDefined(self.owner) && isDefined(self.owner.var_7f0ad61b396c9477)) {
      self.owner.var_7f0ad61b396c9477 = array_remove(self.owner.var_7f0ad61b396c9477, self);
    }

    scripts\mp\damage::monitordamageend();
    level.mines[self getentitynumber()] = undefined;
    self setCanDamage(0);
    makeexplosiveunusuabletag();
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
    self.headiconid = undefined;
    self.exploding = 1;

    if(isDefined(self.dangerzone)) {
      scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
      self.dangerzone = undefined;
    }

    if(isDefined(self.dummy)) {
      self.dummy thread function_13249d21f9c1c453(30);
      self.dummy thread function_954e9d8fc6c1e0c6();
    }

    scripts\cp_mp\ent_manager::deregisterspawn();

    if(isDefined(self.owner)) {
      self.owner removeequip(self);
    }

    waitframe();
    self delete();
  }
}

function private function_d3862975bb307ee3() {
  self endon("death");
  level endon("game_ended");
  scripts\mp\damage::monitordamageend();
  scripts\cp_mp\ent_manager::deregisterspawn();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;

  if(isDefined(self.owner) && isDefined(self.owner.var_b79b9aa464c929bd)) {
    self.owner.var_b79b9aa464c929bd = array_remove(self.owner.var_b79b9aa464c929bd, self);
  }

  waittillframeend();
  self delete();

  if(isDefined(self.owner)) {
    self.owner notify("super_deployedDecoy_deleted");
  }
}

function function_56a30ebf54077e71(data) {
  function_5d24d48d0b8eb170(1);
}

function private function_5d24d48d0b8eb170(var_4ba1c61df5b425cc) {
  if(!isDefined(self)) {
    return;
  }

  self endon("death");
  self.var_3fe87ed1237724cc = 1;
  self notify("deployedDecoy_resumeIdleAnimation_cancel");
  self notify("deployedDecoy_queueDummyDestroy_Interupt");
  self setscriptablepartstate("hitreact", "neutral", 0);
  self notify("destroy");
  function_3f3ce37397b66e92(self.var_9aadbd8d704d2fab, var_4ba1c61df5b425cc);
  waittillframeend();
  function_d3862975bb307ee3();
}

function private function_13249d21f9c1c453(deletiondelay) {
  self endon("deployedDecoy_queueDummyDestroy_Interupt");

  if(!isDefined(deletiondelay)) {
    deletiondelay = 0;
  }

  wait deletiondelay;
  thread function_5d24d48d0b8eb170();
}

function private function_954e9d8fc6c1e0c6() {
  if(!isDefined(level.gametypebundle) || !istrue(level.gametypebundle.var_5b66ed80c98f795b)) {
    return;
  }

  self endon("deployedDecoy_queueDummyDestroy_Interupt");
  self.owner waittill("death_or_disconnect");
  thread function_5d24d48d0b8eb170();
}

function function_34669788fde2926b(objweapon, var_7004db721e68783e) {
  if(istrue(var_7004db721e68783e)) {
    return (isDefined(objweapon) && istrue(objweapon.basename == "deployed_decoy_mp"));
  }

  return isDefined(objweapon) && istrue(objweapon.basename == "deployed_decoy_mp");
}

function private function_31abc24ceaa8d163(var_f357880cc9acabda) {
  if(!isDefined(var_f357880cc9acabda) || !isDefined(var_f357880cc9acabda.owner)) {
    return 0;
  }

  self notify("deployedDecoy_watchScoringThread");
  self endon("deployedDecoy_watchScoringThread");
  var_f357880cc9acabda.owner endon("disconnect");
  level endon("game_ended");
  self.var_a4d803f0a1114e87 = var_f357880cc9acabda getentitynumber();
  self.var_b8b8b6b0af551e03 = var_f357880cc9acabda.owner;
  waittill_any_timeout_1(10, "decoyDummyEndScoring");
  self.var_a4d803f0a1114e87 = undefined;
  self.var_b8b8b6b0af551e03 = undefined;
}

function private function_3972a29b456ebeec(data) {
  if(data.attacker != self.owner) {
    if(!data.attacker function_a26953a3e8e58a3f(self)) {
      if(isDefined(self.owner)) {
        self.owner thread scripts\mp\utility\points::doscoreevent(#"hash_218b72ef391e7f09");
      }
    }

    data.attacker thread function_31abc24ceaa8d163(self);
  }
}

function function_a22d831b624cccd2() {
  if(function_a26953a3e8e58a3f()) {
    self.var_b8b8b6b0af551e03 thread scripts\mp\utility\points::doscoreevent(#"hash_63ddb3737fcc850d");
    self notify("decoyDummyEndScoring");
  }

  self.var_a4d803f0a1114e87 = undefined;
  self.var_b8b8b6b0af551e03 = undefined;
}

function private function_a26953a3e8e58a3f(indummy) {
  if(!isDefined(indummy) && isDefined(self.var_a4d803f0a1114e87)) {
    indummy = getentbynum(self.var_a4d803f0a1114e87);
  }

  return isDefined(self.var_a4d803f0a1114e87) && isDefined(self.var_b8b8b6b0af551e03) && isDefined(indummy) && istrue(indummy getentitynumber() == self.var_a4d803f0a1114e87);
}

function function_f4231eed765ce56c() {
  return isDefined(self.var_7f0ad61b396c9477) && self.var_7f0ad61b396c9477.size > 0;
}

function function_49197cd063a740ea(callbackfunction) {
  self.elevatordoorsclosecallback = callbackfunction;
}

function private function_fa6a545da2197663() {
  self endon("<dev string:xcb>");
  self endon("<dev string:xdd>");
  self endon("<dev string:xef>");

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(!isDefined(self.origin)) {
      return;
    }

    thread scripts\cp_mp\utility\debug_utility::drawcylinder(self.origin, 720, 384, level.framedurationseconds, (0, 0, 255));
    thread scripts\cp_mp\utility\debug_utility::drawcylinder(self.origin, 350, 384, level.framedurationseconds, (0, 0, 255));
    thread scripts\cp_mp\utility\debug_utility::drawcylinder(self.origin, 15, 40, level.framedurationseconds, (0, 0, 127));
    thread scripts\cp_mp\utility\debug_utility::drawcylinder(self.origin, 15, 58, level.framedurationseconds, (0, 0, 127));
    thread scripts\cp_mp\utility\debug_utility::drawangles(self.origin, self.angles, level.framedurationseconds, 1);

    if(isDefined(self.dummy)) {
      thread scripts\cp_mp\utility\debug_utility::drawsphere(self.dummy.origin, 1, level.framedurationseconds, (0, 0, 127));
      thread scripts\cp_mp\utility\debug_utility::drawangles(self.dummy.origin, self.dummy.angles, level.framedurationseconds, 1);
    }

    if(isDefined(self.waterimpactpos)) {
      thread scripts\cp_mp\utility\debug_utility::drawcylinder(self.waterimpactpos, 350, 5, level.framedurationseconds, (255, 0, 255));
    }

    waitframe();
  }
}

function private function_46bfca70cc1648f8(data) {
  if(false) {
    drawduration = 10;
    printduration = int(drawduration / level.framedurationseconds);
    printscale = 0.15;
    colorred = (1, 0, 0);
    colorgreen = (0, 1, 0);
    colorblue = (0, 0, 1);
    var_6a7c727cda8dbc21 = (1, 0, 1);
    up = anglestoup(self.angles);
    pointup = self.origin + up;
    forward = anglesToForward(self.angles);
    pointforward = self.origin + forward;
    var_b752aa0da59ae52c = self.origin + forward * 72;
    thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, var_b752aa0da59ae52c, drawduration, var_6a7c727cda8dbc21);
    right = anglestoright(self.angles);
    pointright = self.origin + right;
    direction = data.direction_vec;
    pointdirection = self.origin + vectorNormalize(direction);
    var_7de45188a78bcccc = self.origin + vectorNormalize(direction) * 72;
    angledelta = anglesdelta(vectortoangles(direction), vectortoangles(forward));
    var_dd4fec1f7555332c = vectordot(forward, direction);
    var_8bbcf51ff5504b0d = vectordot(right, direction);
    hitstring = default_to(function_5d2ce17e3de0719b(data), "<dev string:xf8>");
    thread scripts\cp_mp\utility\debug_utility::drawcylinder(self.origin, 72, 10, drawduration, colorgreen);

    for(i = 0; i <= 3; i++) {
      degrees = 45 + 90 * i;
      rot = rotatepointaroundvector(up, forward, degrees);
      rot = vectorNormalize(rot) * 72;
      thread scripts\cp_mp\utility\debug_utility::drawsphere(self.origin + rot, 1, drawduration, colorgreen);
      thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, self.origin + rot, drawduration, colorgreen);
    }

    if(isDefined(data)) {
      if(isDefined(data.point)) {
        thread scripts\cp_mp\utility\debug_utility::drawsphere(data.point, 1, drawduration, colorred);

        if(isDefined(data.attacker)) {
          thread scripts\cp_mp\utility\debug_utility::drawline(data.point, data.attacker.origin, drawduration, colorred);
        }
      }

      if(isDefined(data.direction_vec)) {
        thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, var_7de45188a78bcccc, drawduration, colorblue);
      }

      var_bce79209c754c068 = data.attacker.origin;
      print3d(var_bce79209c754c068 + (0, 0, 24), "<dev string:x100>" + angledelta, colorgreen, 1, printscale, printduration, 1);
      print3d(var_bce79209c754c068 + (0, 0, 18), "<dev string:x10b>" + var_dd4fec1f7555332c, colorgreen, 1, printscale, printduration, 1);
      print3d(var_bce79209c754c068 + (0, 0, 12), "<dev string:x119>" + var_8bbcf51ff5504b0d, colorgreen, 1, printscale, printduration, 1);
      print3d(var_bce79209c754c068 + (0, 0, 6), "<dev string:x127>" + hitstring, colorgreen, 1, printscale, printduration, 1);
    }
  }
}

# /