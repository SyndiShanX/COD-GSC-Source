/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_743e6c2d23e7f91f.gsc
*************************************************/

#using script_4bac13d511590220;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\killstreaks\sentry_gun;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\turret_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\remotetank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#namespace namespace_d952f9ac311401b4;

function function_906e0becc84c065b(pos, patrolstruct, vehicle, model, patrolradius, name, owneroverride) {
  spawndata = spawnStruct();
  spawndata.origin = pos;
  spawndata.angles = (0, 0, 0);
  spawndata.spawntype = "veh_pac_sentry_amphibious_mp_biolab";
  spawndata.owner = undefined;
  spawndata.team = "team_hundred_ninety_five";
  spawndata.modelname = "veh9_mil_lnd_whotel_v2_composite_mp";
  spawndata.vehicletype = "veh_pac_sentry_amphibious_mp_biolab";
  spawndata.targetname = "remote_tank";
  spawndata.cancapture = 0;
  spawndata.cancaptureimmediately = 0;
  spawndata.activateimmediately = 1;
  remotetank = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata);

  if(isDefined(owneroverride)) {
    remotetank.owner = owneroverride;
    remotetank setentityowner(owneroverride);
  } else {
    fakeowner = scripts\mp\ai_mp_controller::function_af3034a7c69d7edb(scripts\cp_mp\agents\agent_utils::function_30a0d7ca3fae40cc("merc"));
    remotetank.owner = fakeowner;
    remotetank scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", spawndata.team);
  }

  remotetank.team = "team_hundred_ninety_five";
  remotetank.tanktype = "remote_tank";
  remotetank.maxhealth = 6000;
  remotetank.health = 6000;
  remotetank.currenthealth = 6000;
  remotetank.pathstruct = patrolstruct;
  remotetank.patrolstruct = patrolstruct;
  remotetank.vehiclename = "pac_sentry";
  remotetank.spinuptime = 1;
  remotetank laseron();
  remotetank addcomponent("p2p");
  remotetank setconfigvalue("p2p", "reverseGasNormal", 1.5);
  remotetank setconfigvalue("p2p", "steeringMultiplier", 15);
  remotetank setconfigvalue("p2p", "manualSpeed", 10);
  remotetank setconfigvalue("p2p", "reverseForBehindGoal", 1);
  remotetank setconfigvalue("p2p", "stuckTime", 4);
  remotetank setconfigvalue("p2p", "goalThreshold", 10);
  remotetank scripts\cp_mp\emp_debuff::set_start_emp_callback(&empstarted);
  remotetank scripts\cp_mp\emp_debuff::set_clear_emp_callback(&empcleared);
  remotetank.var_8ffa366ec68f0c8b = 10000;
  remotetank scripts\mp\killstreaks\remotetank::function_89445073f3e86e5c(remotetank.vehiclename);
  function_45c8ebe59275b96e(remotetank.vehiclename);
  playFXOnTag(getfx("vfx_dmz_Wheelson_flashlight"), remotetank, "tag_flash");
  remotetank.currentstate = "patrol";
  remotetank vehicleshowonminimap(0);
  remotetank.damagecallback = &vehicle_damagecallback;
  remotetank thread vehicle_patrol(patrolstruct);
  remotetank thread function_42bc36af24a342e();
  remotetank thread function_93dccf3096384da0();
  remotetank.damagestate = 0;
  remotetank.ignoredteams = [];
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(remotetank, remotetank.owner, remotetank.owner.team);
  return remotetank;
}

function function_45c8ebe59275b96e(streakname) {
  weaponname = "thermite_bolt_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 18;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "thermite_xmike109_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 25;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "semtex_bolt_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 7;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "semtex_xmike109_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 8;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "c4_mp";
  weaponhitsperattack = 5;
  weaponhitstokill = undefined;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "at_mine_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 4;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "thermite_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 50;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }
}

function function_45d2e44c40437351(startnode, primarynode, secondarynode) {
  pathstruct = spawnStruct();
  pathstruct.path = [startnode];
  pathstruct.secondarynodes = [];
  pathstruct.speed = 10;
  pathstruct.direction = 1;
  pathstruct.index = 0;
  curnode = startnode;

  while(isDefined(curnode.target)) {
    curindex = pathstruct.path.size - 1;
    pathstruct.secondarynodes[curindex] = [];
    subnodes = getStructArray(curnode.target, "targetname");

    foreach(node in subnodes) {
      if(node.script_noteworthy == primarynode) {
        curnode = node;
        pathstruct.path[pathstruct.path.size] = node;
        continue;
      }

      if(node.script_noteworthy == secondarynode) {
        pathstruct.secondarynodes[curindex][pathstruct.secondarynodes[curindex].size] = function_49b628ec7b6247bd(node, secondarynode);
      }
    }
  }

  return pathstruct;
}

function private function_49b628ec7b6247bd(startnode, nodenames) {
  pathstruct = spawnStruct();
  pathstruct.path = [startnode];
  pathstruct.speed = 10;
  pathstruct.direction = 1;
  pathstruct.index = 0;
  curnode = startnode;

  while(isDefined(curnode.target)) {
    curnode = getStructArray(curnode.target, "targetname")[0];
    pathstruct.path[pathstruct.path.size] = curnode;
  }

  return pathstruct;
}

function vehicle_patrol(pathstruct) {
  if(isDefined(pathstruct.path) && pathstruct.path.size > 0) {
    self.var_13ccb567671deb18 = undefined;
    thread namespace_9246f10206f50768::function_c3889abf5cd6abbf(pathstruct, pathstruct.speed, undefined, "soldier");
  }
}

function function_b0bcd78019fa3f75() {
  if(isDefined(self.var_13ccb567671deb18)) {
    subpath = function_bb51d7fa820f19ae(0, self.var_46496c542d347ba8, self.var_13ccb567671deb18);
    namespace_9246f10206f50768::function_aa85eb39828a4d80(subpath, 10, 1, 0);
    self.var_f0f726adafb8c51a = undefined;
    self.var_13ccb567671deb18 = undefined;
    self.var_46496c542d347ba8 = undefined;
  }

  thread namespace_9246f10206f50768::function_c3889abf5cd6abbf(self.patrolstruct, self.patrolstruct.speed, undefined, "soldier");
}

function function_42bc36af24a342e() {
  self endon("death");
  thread function_2325f7cc87d0684();
  childthread function_5fa5baec6e8f8d91();

  while(true) {
    while(istrue(self.emp) || istrue(self.ishaywire)) {
      wait 0.2;
    }

    closesttarget = undefined;
    closestdistsq = undefined;
    var_7408ed52662703d3 = utility::playersinsphere(self.origin, 2048);

    foreach(target in var_7408ed52662703d3) {
      if(!function_79e58f587efe9e1f(target)) {
        continue;
      }

      totarget = target.origin - self.origin;
      angleto = vectordot(anglesToForward(self gettagangles("tag_flash")), totarget);

      if(angleto < 90) {
        continue;
      }

      distsq = distancesquared(target.origin, self.origin);

      if(!isDefined(closesttarget) || distsq < closestdistsq) {
        closesttarget = target;
        closestdistsq = distsq;
      }
    }

    if(isDefined(self.lastplayerattacker)) {
      closesttarget = self.lastplayerattacker;
    }

    if(isDefined(closesttarget)) {
      vehicle_entercombatstate();
      function_f3c822808e8cc579(closesttarget);
      thread function_2325f7cc87d0684();
      self.lastplayerattacker = undefined;
    } else {
      var_d379fc1174b381dd = getaiarrayinradius(self.origin, 500);
      validtargets = [];

      foreach(agent in var_d379fc1174b381dd) {
        if(isenemyteam(self.team, agent.team) && function_79e58f587efe9e1f(agent)) {
          validtargets[validtargets.size] = agent;
        }
      }

      closesttarget = undefined;
      closestdistsq = undefined;

      foreach(agent in validtargets) {
        totarget = agent.origin - self.origin;
        angleto = vectordot(anglesToForward(self gettagangles("tag_flash")), totarget);

        if(angleto < 90) {
          continue;
        }

        distsq = distancesquared(agent.origin, self.origin);

        if(!isDefined(closesttarget) || distsq < closestdistsq) {
          closesttarget = agent;
          closestdistsq = distsq;
        }

        if(isDefined(closesttarget)) {
          vehicle_entercombatstate();
          function_f3c822808e8cc579(closesttarget);
          thread function_2325f7cc87d0684();
          self.var_c6dfdd9743149226 = undefined;
        }
      }
    }

    wait 0.1;
  }
}

function function_5fa5baec6e8f8d91() {
  while(true) {
    while(istrue(self.emp) || istrue(self.ishaywire)) {
      wait 0.2;
    }

    if(isDefined(self.var_c6dfdd9743149226) && isagent(self.var_c6dfdd9743149226)) {
      closesttarget = undefined;
      closestdistsq = undefined;
      var_7408ed52662703d3 = utility::playersinsphere(self.origin, 2048);

      foreach(target in var_7408ed52662703d3) {
        if(!function_79e58f587efe9e1f(target)) {
          continue;
        }

        totarget = target.origin - self.origin;
        angleto = vectordot(anglesToForward(self gettagangles("tag_flash")), totarget);

        if(angleto < 90) {
          continue;
        }

        distsq = distancesquared(target.origin, self.origin);

        if(!isDefined(closesttarget) || distsq < closestdistsq) {
          closesttarget = target;
          closestdistsq = distsq;
        }
      }

      if(isDefined(self.lastplayerattacker)) {
        closesttarget = self.lastplayerattacker;
      }

      if(isDefined(closesttarget)) {
        self notify("target_lost");
      }
    }

    wait 0.1;
  }
}

function function_2325f7cc87d0684() {
  self endon("death");
  self endon("dmz_ai_vehicle_enterCombatState");
  self.currentstate = "patrol";
  scanangle = 0;
  direction = 1;

  while(true) {
    if(istrue(self.emp)) {
      turretdir = anglesToForward(self gettagangles("tag_flash"));
      self setturrettargetvec(turretdir * 500 + (0, -800, 0));
    }

    while(istrue(self.emp) || istrue(self.ishaywire)) {
      wait 0.2;
    }

    scanangle += 90 * direction;

    if(scanangle >= 360 || scanangle <= 0) {
      direction *= -1;
    }

    targetangles = (0, scanangle, 0);
    targetvec = anglesToForward(targetangles);
    start = self.origin + (0, 0, 16);
    end = start + 6000 * targetvec;
    self setturrettargetvec(end);
    waittill_any_timeout_1(2, "turret_on_target");
  }
}

function vehicle_entercombatstate() {
  self.var_3258be7f1d1b7c7a = self.origin;
  self notify("newFollowPath");
  self notify("dmz_ai_vehicle_enterCombatState");
}

function function_f3c822808e8cc579(target) {
  self endon("death");
  self endon("enter_patrol");
  self endon("target_lost");
  self.var_c6dfdd9743149226 = target;
  childthread function_66ef3bd97ce18687();
  var_a84cfd847dc1f677 = level.tanksettings[self.tanktype];

  while(true) {
    if(!isalive(target)) {
      break;
    }

    riottarget = undefined;

    if(istrue(target.hasriotshieldequipped)) {
      riottarget = target;
    }

    if(!function_79e58f587efe9e1f(target) || istrue(target.hasriotshieldequipped) || isDefined(self.lastplayerattacker) && self.lastplayerattacker != target) {
      if(isDefined(self.lastplayerattacker) && self.lastplayerattacker != target) {
        target = self.lastplayerattacker;
      } else {
        var_7408ed52662703d3 = utility::playersinsphere(self.origin, 2048);
        var_7408ed52662703d3 = sortbydistance(var_7408ed52662703d3, self.origin);

        foreach(nearbytarget in var_7408ed52662703d3) {
          if(!function_79e58f587efe9e1f(nearbytarget)) {
            continue;
          }

          if(istrue(nearbytarget.hasriotshieldequipped) && !isDefined(riottarget)) {
            riottarget = nearbytarget;
            continue;
          }

          target = nearbytarget;
          break;
        }
      }

      if(!function_79e58f587efe9e1f(target) && isDefined(riottarget)) {
        target = riottarget;
      }
    }

    self.currentstate = "attack";
    vehicle_fireweapon(target, var_a84cfd847dc1f677);
    function_55f73871378d7cea();
    wait 0.2;
  }
}

function function_6a5482361557e17b(var_a84cfd847dc1f677) {
  self endon("death");
  spinuptime = self.spinuptime;
  thread scripts\cp_mp\killstreaks\sentry_gun::sentry_targetlocksound();
  self setvehweaponspinning(1);
  self.turretspinning = 1;

  while(spinuptime > 0) {
    spinuptime -= 0.05;
    wait 0.05;
  }
}

function function_55f73871378d7cea() {
  if(istrue(self.turretspinning)) {
    spinuptime = self.spinuptime;
    self setvehweaponspinning(0);
    self.turretspinning = undefined;

    while(spinuptime > 0) {
      spinuptime -= 0.05;
      wait 0.05;
    }
  }
}

function function_66ef3bd97ce18687() {
  targetfails = 0;
  maxfails = 4;

  if(isDefined(self.var_d04bb72230a5a308)) {
    maxfails = self.var_d04bb72230a5a308;
  }

  while(true) {
    if(!function_8e9091d778558441(self.var_c6dfdd9743149226)) {
      thread function_b0bcd78019fa3f75();
      self notify("target_lost");
      waitframe();
    }

    if(function_c17cf83f13647859(self.var_c6dfdd9743149226)) {
      targetfails = 0;
      wait 0.5;
      continue;
    }

    if(function_a1618f0c0bc81103(self.var_c6dfdd9743149226)) {
      targetfails = 0;
      waitframe();
      continue;
    }

    targetfails += 1;

    if(targetfails > maxfails) {
      thread function_b0bcd78019fa3f75();
      self notify("target_lost");
    }

    wait 1;
  }
}

function private function_8e9091d778558441(target) {
  if(!isDefined(target)) {
    return false;
  }

  if(isPlayer(target)) {
    if(isDefined(self.ignoredteams) && array_contains(self.ignoredteams, target.team)) {
      return false;
    }

    if(!target scripts\cp_mp\utility\player_utility::_isalive() || target.sessionstate != "playing") {
      return false;
    }

    if(scripts\mp\utility\player::isinlaststand(target)) {
      return false;
    }

    if(istrue(target.notarget)) {
      return false;
    }

    if(target == self.owner) {
      return false;
    }

    if(istrue(target.disguised)) {
      return false;
    }
  } else if(isagent(target)) {
    if(!isalive(target)) {
      return false;
    }

    if(issubstr(target.agent_type, "schematic_soldier_buddy")) {
      return false;
    }

    if(istrue(target.ignoreme)) {
      return false;
    }
  }

  return true;
}

function private function_c17cf83f13647859(target) {
  if(!isDefined(target)) {
    return 0;
  }

  if(isPlayer(target)) {
    return self vehicle_canturrettargetpoint(target gettagorigin("j_mainroot"), 1, self);
  } else if(isagent(target)) {
    return self vehicle_canturrettargetpoint(target getcentroid(), 1, self);
  }

  return 0;
}

function function_79e58f587efe9e1f(target) {
  if(!function_8e9091d778558441(target)) {
    return 0;
  }

  return function_c17cf83f13647859(target);
}

function function_a7f393dd1e9a679b(target) {
  if(!isDefined(target)) {
    return undefined;
  }

  if(isPlayer(target)) {
    return target gettagorigin("j_mainroot");
  } else if(isagent(target)) {
    return target getcentroid();
  }

  return undefined;
}

function function_a1618f0c0bc81103(target) {
  newpath = undefined;
  curnode = self.patrolstruct.path[self.patrolstruct.index];

  for(i = 0; i < 4; i++) {
    forwardindex = self.patrolstruct.index + i;
    forwardindex = ter_op(forwardindex >= self.patrolstruct.path.size, forwardindex - self.patrolstruct.path.size, forwardindex);

    if(function_3e8010501de305fa(self.patrolstruct.path[forwardindex], target)) {
      newpath = function_b4908dc2cbec66a6(forwardindex, 1);
      self.var_f0f726adafb8c51a = undefined;
      self.var_13ccb567671deb18 = undefined;
      self.var_46496c542d347ba8 = undefined;
      self.patrolstruct.index = forwardindex;

      vehicle_drawpath(newpath.path);

      namespace_9246f10206f50768::function_aa85eb39828a4d80(newpath.path, newpath.speed, 1, 0);
      return true;
    }

    if(isDefined(self.patrolstruct.secondarynodes[forwardindex]) && self.patrolstruct.secondarynodes[forwardindex].size > 0) {
      foreach(parentindex, parentnode in self.patrolstruct.secondarynodes[forwardindex]) {
        foreach(index, node in parentnode.path) {
          if(function_3e8010501de305fa(node, target)) {
            if(i != 0) {
              newpath = function_b4908dc2cbec66a6(forwardindex, 1, index, parentindex);
              self.var_f0f726adafb8c51a = index;
              self.var_13ccb567671deb18 = parentindex;
              self.var_46496c542d347ba8 = forwardindex;
              self.patrolstruct.index = forwardindex;

              vehicle_drawpath(newpath.path);

              namespace_9246f10206f50768::function_aa85eb39828a4d80(newpath.path, newpath.speed, 1, 0);
            } else {
              subpath = function_bb51d7fa820f19ae(index, forwardindex, parentindex);
              self.var_f0f726adafb8c51a = index;
              self.var_13ccb567671deb18 = parentindex;
              self.var_46496c542d347ba8 = forwardindex;
              self.patrolstruct.index = forwardindex;

              vehicle_drawpath(subpath);

              namespace_9246f10206f50768::function_aa85eb39828a4d80(subpath, 10, 1, 0);
            }

            return true;
          }
        }
      }
    }

    if(i == 0) {
      continue;
    }

    backwardsindex = self.patrolstruct.index - i;
    backwardsindex = ter_op(backwardsindex < 0, backwardsindex + self.patrolstruct.path.size, backwardsindex);

    if(function_3e8010501de305fa(self.patrolstruct.path[backwardsindex], target)) {
      newpath = function_b4908dc2cbec66a6(backwardsindex, 0);
      self.var_f0f726adafb8c51a = undefined;
      self.var_13ccb567671deb18 = undefined;
      self.var_46496c542d347ba8 = undefined;
      self.patrolstruct.index = backwardsindex;

      vehicle_drawpath(newpath.path);

      namespace_9246f10206f50768::function_aa85eb39828a4d80(newpath.path, newpath.speed, 1, 0);
      return true;
    }

    if(isDefined(self.patrolstruct.secondarynodes[backwardsindex]) && self.patrolstruct.secondarynodes[backwardsindex].size > 0) {
      foreach(parentindex, parentnode in self.patrolstruct.secondarynodes[backwardsindex]) {
        foreach(index, node in parentnode.path) {
          if(function_3e8010501de305fa(node, target)) {
            newpath = function_b4908dc2cbec66a6(backwardsindex, 1, index, parentindex);
            self.var_f0f726adafb8c51a = index;
            self.var_13ccb567671deb18 = parentindex;
            self.var_46496c542d347ba8 = backwardsindex;
            self.patrolstruct.index = backwardsindex;

            vehicle_drawpath(newpath.path);

            namespace_9246f10206f50768::function_aa85eb39828a4d80(newpath.path, newpath.speed, 1, 0);
            return true;
          }
        }
      }
    }
  }

  return false;
}

function vehicle_drawpath(newpath) {
  for(i = 0; i <= newpath.size - 1; i++) {
    if(i == newpath.size - 1) {
      draw_arrow_time(self.origin, newpath[i], (255, 0, 0), 10);
      continue;
    }

    draw_arrow_time(newpath[i], newpath[i + 1], (255, 0, 0), 10);
  }
}

function function_b4908dc2cbec66a6(index, forward, subindex, var_ad1e1e856375b447) {
  pathstruct = spawnStruct();
  pathstruct.path = function_bb51d7fa820f19ae(0, self.var_46496c542d347ba8, self.var_13ccb567671deb18);
  pathstruct.speed = 10;
  pathstruct.index = 0;
  curindex = self.patrolstruct.index;

  if(istrue(forward)) {
    while(index >= curindex) {
      pathstruct.path[pathstruct.path.size] = self.patrolstruct.path[curindex].origin;
      curindex += 1;
    }
  } else {
    curindex -= 1;

    while(curindex >= index) {
      pathstruct.path[pathstruct.path.size] = self.patrolstruct.path[curindex].origin;
      curindex -= 1;
    }
  }

  if(isDefined(var_ad1e1e856375b447)) {
    for(i = 0; i < subindex; i++) {
      pathstruct.path[pathstruct.path.size] = self.patrolstruct.secondarynodes[index][var_ad1e1e856375b447].path[i].origin;
    }
  }

  return pathstruct;
}

function function_bb51d7fa820f19ae(index, parentindex, var_ad1e1e856375b447) {
  newpath = [];

  if(isDefined(self.var_13ccb567671deb18)) {
    if(var_ad1e1e856375b447 == self.var_13ccb567671deb18) {
      direction = ter_op(self.var_f0f726adafb8c51a > index, -1, 1);
      i = self.var_f0f726adafb8c51a;

      while(i != index + direction) {
        newpath[newpath.size] = self.patrolstruct.secondarynodes[parentindex][var_ad1e1e856375b447].path[i].origin;
        i += direction;
      }
    } else {
      for(i = self.var_f0f726adafb8c51a; i >= 0; i--) {
        newpath[newpath.size] = self.patrolstruct.secondarynodes[parentindex][self.var_13ccb567671deb18].path[i].origin;
      }

      newpath[newpath.size] = self.patrolstruct.path[self.patrolstruct.index].origin;

      for(i = 0; i < index; i++) {
        newpath[newpath.size] = self.patrolstruct.secondarynodes[parentindex][var_ad1e1e856375b447].path[i].origin;
      }
    }
  } else if(isDefined(parentindex) && isDefined(var_ad1e1e856375b447)) {
    newpath[newpath.size] = self.patrolstruct.secondarynodes[parentindex][var_ad1e1e856375b447].path[0].origin;
  }

  return newpath;
}

function function_3e8010501de305fa(node, target) {
  if(isDefined(self.var_8ffa366ec68f0c8b)) {
    var_8ffa366ec68f0c8b = self.var_8ffa366ec68f0c8b;
  }

  if(distancesquared(self.origin, node.origin) < var_8ffa366ec68f0c8b) {
    return 0;
  }

  contentsoverride = create_contents(0, 1, 0, 1, 0, 0, 0, 1, 1);
  canseetarget = ray_trace_passed(target.origin, node.origin + (0, 0, 50), [self], contentsoverride);

  if(canseetarget) {
    draw_arrow_time(node.origin + (0, 0, 50), target.origin, (0, 255, 0), 2);
  } else {
    draw_arrow_time(node.origin + (0, 0, 50), target.origin, (255, 0, 0), 2);
  }

  return canseetarget;
}

function vehicle_fireweapon(target, cfg) {
  self endon("death");
  self endon("enter_patrol");
  self endon("target_lost");
  firetime = weaponfiretime(cfg.weaponinfo);
  minshots = 50;
  maxshots = 65;
  minpause = cfg.pausemin;
  maxpause = cfg.pausemax;
  numshots = randomintrange(minshots, maxshots + 1);

  if(!function_79e58f587efe9e1f(target)) {
    return;
  }

  self setturrettargetEnt(target, function_a7f393dd1e9a679b(target) - target.origin);
  var_a84cfd847dc1f677 = level.tanksettings[self.tanktype];

  if(!istrue(self.turretspinning)) {
    function_6a5482361557e17b();
  }

  while(function_79e58f587efe9e1f(target) && !scripts\cp_mp\utility\turret_utility::function_bb61346fda4278e5(self, target, "j_mainroot", 5)) {
    waitframe();
  }

  shootingfails = 0;

  while(numshots > 0) {
    if(!isDefined(target) || !isDefined(target.origin)) {
      return;
    }

    if(isDefined(self.lastvalidloc) && function_79e58f587efe9e1f(target)) {
      shootingfails = 0;
      self.lastvalidloc = undefined;
      self setturrettargetEnt(target, function_a7f393dd1e9a679b(target) - target.origin);
    } else if(!isDefined(self.lastvalidloc) && !function_79e58f587efe9e1f(target)) {
      shootingfails += 1;
      self.lastvalidloc = function_a7f393dd1e9a679b(target);
      self setturrettargetvec(self.lastvalidloc);

      if(isDefined(self.var_7cfe1b189bcf3cad) && shootingfails > self.var_7cfe1b189bcf3cad) {
        return;
      }
    }

    self fireweapon();
    numshots--;
    wait firetime;
  }
}

function empstarted(data) {
  scripts\mp\killstreaks\remotetank::function_db443c859c55e450(1);
  function_55f73871378d7cea();
  self.emp = 1;
  self notify("target_lost");

  if(isDefined(self.onemphit)) {
    self[[self.onemphit]]();
  }
}

function empcleared(isdeath) {
  scripts\mp\killstreaks\remotetank::function_db443c859c55e450(0);
  self.emp = 0;
  function_b0bcd78019fa3f75();

  if(isDefined(self.onempend)) {
    self[[self.onempend]]();
  }
}

function function_f149e9383f183cf0(data) {
  wheelson = data.victim;

  if(!isDefined(wheelson)) {
    return;
  }

  if(istrue(wheelson.ishaywire)) {
    return;
  }

  wheelson.ishaywire = 1;
  wheelson thread function_e6cbf8131b64e6db();
  wheelson setconfigvalue("p2p", "manualSpeed", mph_to_ips(wheelson.pathstruct.speed / 3));
}

function function_5c67fa91fe5b79(data) {
  wheelson = data.victim;

  if(!isDefined(wheelson)) {
    return;
  }

  wheelson setconfigvalue("p2p", "manualSpeed", mph_to_ips(wheelson.pathstruct.speed));
  wheelson.ishaywire = 0;
}

function function_e6cbf8131b64e6db() {
  level endon("game_ended");
  var_a84cfd847dc1f677 = level.tanksettings[self.tanktype];
  firetime = randomfloatrange(0.2, 0.4);
  childthread function_4973f20495f7d1ff(firetime);
  self.var_158f2fb396c0cccb = 1;

  if(!isDefined(self.driver)) {
    self.var_c6dfdd9743149226 = undefined;
    self clearturrettarget();
    self.currentenemy = undefined;
  }

  msg = waittill_any_return_2("death", "haywire_cleared");
  self.var_158f2fb396c0cccb = undefined;
}

function function_4973f20495f7d1ff(firetime) {
  self endon("death");
  self endon("haywire_cleared");

  while(true) {
    self fireweapon();
    wait firetime;
  }
}

function function_aa6f0c2c4f3559c0(targetloc) {
  self endon("death");
  self notify("dmz_ai_vehicle_check_stuck");
  self endon("dmz_ai_vehicle_check_stuck");
  prevloc = self.origin;
  fails = 0;

  while(true) {
    wait 1;

    if(istrue(self.isemped) || istrue(self.ishaywire) || isDefined(self.var_c6dfdd9743149226)) {
      wait 0.25;
      continue;
    }

    currentloc = self.origin;

    if(distancesquared(currentloc, prevloc) < 100) {
      fails += 1;

      if(fails > 3) {
        fails = 0;
        function_b0bcd78019fa3f75();
      }
    }

    prevloc = currentloc;
  }
}

function function_602b08f8ddab1906() {
  self notify("target_lost");
  namespace_9246f10206f50768::function_aa85eb39828a4d80([self.lastvalidorigin], 10, 1, 0);
  mindist = 100000000;
  subnode = undefined;
  var_8f51101f14c01979 = undefined;
  pathindex = undefined;

  foreach(index, node in self.patrolstruct.path) {
    dist = distancesquared(node.origin, self.origin);

    if(dist < mindist) {
      mindist = dist;
      pathindex = index;
    }
  }

  foreach(index, var_c2fbb71a3a796005 in self.patrolstruct.secondarynodes) {
    foreach(subindex, var_be64712b6ece7aa5 in var_c2fbb71a3a796005) {
      foreach(var_908f3939d47bd887, node in var_be64712b6ece7aa5.path) {
        dist = distancesquared(node.origin, self.origin);

        if(dist < mindist) {
          mindist = dist;
          subnode = subindex;
          var_8f51101f14c01979 = var_908f3939d47bd887;
          pathindex = index;
        }
      }
    }
  }

  self.var_f0f726adafb8c51a = var_8f51101f14c01979;
  self.var_13ccb567671deb18 = subnode;
  self.var_46496c542d347ba8 = pathindex;
  self.patrolstruct.index = pathindex;
}

function function_93dccf3096384da0() {
  self endon("death");

  while(true) {
    self waittill("near_goal");
    self.lastvalidorigin = self.origin;
    wait 0.1;
    thread function_aa6f0c2c4f3559c0(self.goalpoint);
  }
}

function private vehicle_damagecallback(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid) {
  if(isagent(attacker)) {
    return;
  }

  if(isPlayer(attacker)) {
    self.lastplayerattacker = attacker;
  }

  if(isDefined(level.vehicles) && isDefined(level.vehicles.damagecallback)) {
    self[[level.vehicles.damagecallback]](inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid);
  } else {
    self vehicle_finishdamage(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname);
  }

  if(self.damagestate == 0 && self.health / self.maxhealth < 0.6) {
    self setscriptablepartstate("body_damage_light", "on", 0);

    if(isDefined(self.interact)) {
      self.interact setscriptablepartstate("body_damage_light", "on", 0);
    }

    self.damagestate = 1;
    return;
  }

  if(self.damagestate == 1 && self.health / self.maxhealth < 0.3) {
    self setscriptablepartstate("body_damage_medium", "on", 0);

    if(isDefined(self.interact)) {
      self.interact setscriptablepartstate("body_damage_light", "off", 0);
      self.interact setscriptablepartstate("body_damage_medium", "on", 0);
    }

    self.damagestate = 2;
  }
}