/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3798db193e76a866.gsc
*************************************************/

#using script_232f31def1450dbb;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\sp\utility;
#namespace killstreaks;

function init() {
  if(isDefined(level.streakglobals)) {
    return;
  }

  level.streakglobals = spawnStruct();
  level.streakglobals.nextid = 1;
  var_3c0a35811a241880 = hashcat(%"killstreaklist:", "killstreak_list_t10_sp");

  if(killstreak_shared::function_1f9e754f6b690e33(var_3c0a35811a241880)) {
    killstreak_shared::function_aa5200593ca327d2();
  }
}

function createstreakinfo(streakname, owner) {
  streakinfo = spawnStruct();
  streakinfo.streakname = streakname;
  streakinfo.owner = owner;
  streakinfo.id = level.streakglobals.nextid;
  streakinfo.lifeid = 0;
  streakinfo.score = 0;
  streakinfo.shots_fired = 0;
  streakinfo.hits = 0;
  streakinfo.damage = 0;
  streakinfo.kills = 0;
  level.streakglobals.nextid += 1;

  if(utility::issharedfuncdefined("killstreak", "createCustomStreakData")) {
    streakinfo = [[utility::getsharedfunc("killstreak", "createCustomStreakData")]](streakinfo, streakname);
  }

  if(isDefined(streakname) && isDefined(level.streakglobals)) {
    streakindex = level.streakglobals.var_2150da9328528bb9[streakname];
  } else {
    streakindex = 0;
  }

  if(!isDefined(streakindex)) {
    streakindex = -1;
  }

  streakinfo.streakindex = streakindex;
  return streakinfo;
}

function getkillstreakairstrikeheightent() {
  level.mapcenter = level.player.origin;
  return level.player;
}

function function_8eafa4c9894723a3(streakinfo, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b, var_f6a32dcc4b19aad9, var_67a06b4ea269058e, var_afe464c242489272, var_818a18147626dfbf, var_c2a00d4f077ebd87) {
  level.player notify("killstreak_deploy");
  wait 1.75;
  return true;
}

function killstreak_setmainvision(visionsetname) {
  if(visionsetname == "") {
    visionsetnaked("", 0);
    visionsetthermal("", 0);
    return;
  }

  visionsetinfo = killstreak_shared::function_3de44eb7cdde2614(visionsetname);

  if(!isDefined(visionsetinfo)) {
    return;
  }

  fadeintime = visionsetinfo.fadeintime;

  if(isDefined(visionsetinfo.type) && visionsetinfo.type == "thermal") {
    visionsetthermal(visionsetname, fadeintime);
    return;
  }

  visionsetnaked(visionsetname, fadeintime);
}

function killstreak_setsubvision(visionsetinfo) {}

function restorekillstreakplayerangles(player) {
  if(player.health <= 0) {
    return;
  }

  if(isDefined(player.restoreangles)) {
    player setplayerangles((player.restoreangles[0], player.restoreangles[1], 0));
  }

  player.restoreangles = undefined;
}

function function_ceb8da3185ad3803(user) {
  enemies = getaiarray("axis", "team3");
  friendlies = getaiarray("allies", "civilian");
  friendlies[friendlies.size] = level.player;
  groupsstruct = spawnStruct();
  groupsstruct.enemytargetmarkergroup = enemies;
  groupsstruct.friendlytargetmarkergroup = friendlies;
  return groupsstruct;
}

function killstreak_setupvehicledamagefunctionality(streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback) {
  if(isDefined(var_8dfc256103cce53e)) {
    [[var_8dfc256103cce53e]](streakname);
  }

  if(isDefined(var_191284e2e2837328)) {
    [[var_191284e2e2837328]](streakname);
  }

  if(utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    killstreakvehicle[[utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](streakname, scorepopup, vodestroyed, destroyedsplash);
  }

  if(utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    killstreakvehicle[[utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](streakname, premoddamagecallback);
  }

  if(utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    killstreakvehicle[[utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](streakname, postmoddamagecallback);
  }

  if(isDefined(postmoddamagecallback)) {
    thread function_4631ece86c93520(postmoddamagecallback);
  }

  if(isDefined(deathcallback)) {
    thread function_3a8380a61a37e123(deathcallback);
  }
}

function function_4631ece86c93520(damagefunc) {
  if(isDefined(self.var_fb4b1c31a5e79d48)) {
    return;
  }

  self endon("death");
  self.var_fb4b1c31a5e79d48 = spawnStruct();

  while(true) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid);
    self.var_fb4b1c31a5e79d48.attacker = eattacker;
    self.var_fb4b1c31a5e79d48.objweapon = objweapon;
    self.var_fb4b1c31a5e79d48.meansofdeath = smeansofdeath;
    self.var_fb4b1c31a5e79d48.damage = idamage;
    self.var_fb4b1c31a5e79d48.idflags = idflags;
    self.var_fb4b1c31a5e79d48.origin = origin;
    self.var_fb4b1c31a5e79d48.angles = angles;

    if(isDefined(damagefunc)) {
      self[[damagefunc]](self.var_fb4b1c31a5e79d48);
    }
  }
}

function function_3a8380a61a37e123(deathfunc) {
  thread function_4631ece86c93520(undefined);
  self waittill("death");
  self[[deathfunc]](self.var_fb4b1c31a5e79d48);
}

function function_edd13bb02e6204e4(streakinfo, weaponobj, firednotify, weapongivencallback, var_8fd4d93dd619da88, weaponfiredcallback, var_91f739c2c51347d4, var_d55d8445518099b) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  firedresult = 1;
  self.lastdroppableweaponobj = self getcurrentweapon();
  switchresult = switchtodeployweapon(weaponobj, streakinfo, &waituntilfinishedwithdeployweapon, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b);

  if(!istrue(switchresult)) {
    return false;
  }

  if(isDefined(streakinfo) && isDefined(streakinfo.var_fb58a31c756db4cc)) {
    val::group_set(streakinfo.var_fb58a31c756db4cc, 0);
    firedresult = watchdeployweaponfired(streakinfo, firednotify, weaponobj, weaponfiredcallback);
    val::group_reset(streakinfo.var_fb58a31c756db4cc);
  } else {
    val::set("firedDeploy", "offhand_weapons", 0);
    firedresult = watchdeployweaponfired(streakinfo, firednotify, weaponobj, weaponfiredcallback);
    val::reset_all("firedDeploy");
  }

  return istrue(firedresult);
}

function switchtodeployweapon(deployweaponobj, streakinfo, cleanupwaitfunc, weapongivencallback, var_8fd4d93dd619da88, var_91f739c2c51347d4, var_d55d8445518099b, skipfirstraise) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(self hasweapon(deployweaponobj)) {
    return 0;
  }

  if(!isDefined(skipfirstraise)) {
    skipfirstraise = 1;
  }

  self giveweapon(deployweaponobj, 0, 0, 0, skipfirstraise);
  switchresult = 1;
  var_137e8ca1e47954dc = callweapongivencallback(streakinfo, weapongivencallback);

  if(!istrue(var_137e8ca1e47954dc)) {
    level.player takeweapon(deployweaponobj);
    return 0;
  }

  thread watchforcancelduringweaponswitch(streakinfo, deployweaponobj);
  thread watchformeleeduringweaponswitch(streakinfo, deployweaponobj);
  switchresult = namespace_dc526c68c9ba2b83::domonitoredweaponswitch(deployweaponobj, isbot(self), streakinfo.var_9d7c6ee83f507a26);
  streakinfo notify("deploy_weapon_switch_ended");

  if(isDefined(var_8fd4d93dd619da88)) {
    self thread[[var_8fd4d93dd619da88]](streakinfo, switchresult);
  }

  waitframe();

  if(!switchresult) {
    cleanupwaitfunc = undefined;
  }

  if(!isalive(self)) {
    return 0;
  }

  thread cleanupdeployweapon(switchresult, streakinfo, deployweaponobj, cleanupwaitfunc, var_91f739c2c51347d4, var_d55d8445518099b);
  return switchresult;
}

function callweapongivencallback(streakinfo, weapongivencallback) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("cancel_all_killstreak_deployments");

  if(isDefined(weapongivencallback)) {
    return self[[weapongivencallback]](streakinfo);
  }

  return 1;
}

function private waituntilfinishedwithdeployweapon(streakinfo) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  childthread function_2bff7042844c915b(streakinfo, "killstreak_finished_with_deploy_weapon");
  childthread function_2bff7042844c915b(self, "cancel_all_killstreak_deployments");
  childthread function_2bff7042844c915b(self, "weapon_change");

  while(true) {
    self waittill("potential_killstreak_deployment_finish", result);

    if(isDefined(result) && result == "weapon_change") {
      if(isusingremote()) {
        continue;
      }
    }

    break;
  }

  self notify("killstreak_really_finished_with_deploy_weapon");
}

function private function_2bff7042844c915b(ent, finishednotify) {
  self endon("killstreak_really_finished_with_deploy_weapon");
  ent waittill(finishednotify);
  self notify("potential_killstreak_deployment_finish", finishednotify);
}

function watchforcancelduringweaponswitch(streakinfo, deployweaponobj) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  streakinfo endon("deploy_weapon_switch_ended");
  self waittill("cancel_all_killstreak_deployments");

  if(namespace_dc526c68c9ba2b83::isswitchingtoweaponwithmonitoring(deployweaponobj)) {
    namespace_dc526c68c9ba2b83::abortmonitoredweaponswitch(deployweaponobj);
  }
}

function watchformeleeduringweaponswitch(streakinfo, deployweaponobj) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  streakinfo endon("deploy_weapon_switch_ended");
  self waittill("melee_swipe_start");

  if(namespace_dc526c68c9ba2b83::isswitchingtoweaponwithmonitoring(deployweaponobj)) {
    namespace_dc526c68c9ba2b83::abortmonitoredweaponswitch(deployweaponobj);
    return;
  }

  self takeweapon(deployweaponobj);
  thread namespace_dc526c68c9ba2b83::domonitoredweaponswitch(self.lastdroppableweaponobj, isbot(self));
}

function watchdeployweaponfired(streakinfo, firednotify, var_4ef1099365450bae, weaponfiredcallback) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("weapon_change");
  self endon("cancel_all_killstreak_deployments");

  while(true) {
    var_a9dd4e8c5e5c7178 = undefined;
    firedprojectile = undefined;

    switch (firednotify) {
      case #"hash_21a23ad4b32e4f8e":
        self waittill(firednotify, var_a9dd4e8c5e5c7178);
        break;
      case #"hash_77f5cb8818a754f0":
        self waittill(firednotify, var_a9dd4e8c5e5c7178);
        break;
      case #"hash_3989359e2b52d1ba":
        self waittill(firednotify, firedprojectile, var_a9dd4e8c5e5c7178);
        break;
      default:
        self waittill(firednotify);
        break;
    }

    if(var_a9dd4e8c5e5c7178 == var_4ef1099365450bae) {
      if(isDefined(weaponfiredcallback)) {
        firedresult = [[weaponfiredcallback]](streakinfo, var_a9dd4e8c5e5c7178, firedprojectile);

        if(!isDefined(firedresult)) {
          assertex(isDefined(firedresult), "weaponFiredCallback returned undefined, please make sure it returns success || failure || continue");
          return false;
        } else if(firedresult == "failure") {
          return false;
        } else if(firedresult == "continue") {
          if(isDefined(level.killstreakweaponfiredcontinue)) {
            [[level.killstreakweaponfiredcontinue]]();
          }

          continue;
        } else if(firedresult == "success") {
          return true;
        } else {
          assertmsg("weaponFiredCallback returned an unrecognized string value.Please make sure it returns success || failure || continue");
          return false;
        }
      }

      return true;
    }
  }

  return false;
}

function private cleanupdeployweapon(switchresult, streakinfo, weaponobj, cleanupwaitfunc, var_91f739c2c51347d4, var_d55d8445518099b) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isDefined(cleanupwaitfunc)) {
    self[[cleanupwaitfunc]](streakinfo);
  }

  if(self hasweapon(weaponobj)) {
    var_cd5c5ac9105ab0d7 = 0;
    mapselectkillstreak = 0;
    var_d110628a2924ac08 = 0;
    val::set("deployCleanup", "melee", 0);
    val::set("deployCleanup", "offhand_weapons", 0);

    if(isDefined(var_91f739c2c51347d4)) {
      self[[var_91f739c2c51347d4]](streakinfo, switchresult, weaponobj);
    } else {
      getridofkillstreakdeployweapon(weaponobj);
    }

    val::reset_all("deployCleanup");
  }

  if(isDefined(var_d55d8445518099b)) {
    self[[var_d55d8445518099b]](streakinfo);
  }
}

function getridofkillstreakdeployweapon(weaponobj) {
  namespace_dc526c68c9ba2b83::getridofweapon(weaponobj, istrue(self.var_4a2f2f50a9020e2e));
  self.var_4a2f2f50a9020e2e = undefined;
  currentweapon = self getcurrentweapon();

  if(currentweapon.basename == "none") {
    namespace_dc526c68c9ba2b83::forcevalidweapon();
  }
}