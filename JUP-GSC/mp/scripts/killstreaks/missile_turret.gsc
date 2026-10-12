/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\killstreaks\missile_turret.gsc
**************************************************/

#using script_16ea1b94f0f381b3;
#using script_608c50392df8c7d1;
#using scripts\common\callbacks;
#using scripts\common\damage_tuning;
#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\killstreaks\manual_turret;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace missile_turret;

function autoexec main() {
  registerkillstreakinitfunction(getxhash("missile_turret"), &init);
}

function private init() {
  if(issharedfuncdefined("killstreak", "registerKillstreak")) {
    [[getsharedfunc("killstreak", "registerKillstreak")]]("missile_turret", &function_7b0acdb995efbcd0);
  }

  bundle = level.streakglobals.streakbundles["missile_turret"];

  if(isDefined(bundle) && isDefined(bundle.var_661e446067d68053) && issharedfuncdefined("killstreak", "registerKillstreak")) {
    [[getsharedfunc("killstreak", "registerKillstreakDamageDealingWeapon")]]("missile_turret", bundle.var_661e446067d68053, #"large");
  }

  scripts\engine\utility::registersharedfunc("missile_turret", "missile_turret_Hack", &missileturret_hack);
  function_f93272c662d381d2();
  function_a0a5114bb65fcecd();
  function_f42f083e1874b55a();
}

function function_f93272c662d381d2() {
  setdevdvarifuninitialized(@ "hash_c9bd691ce96079ac", 0);
  setdevdvarifuninitialized(@ "hash_8339cedf7d2c80b9", 0);
  setdvarifuninitialized(@ "hash_a42516bfaeb6df0f", 10);
}

function function_b750543c3bf3d80f(streakinfo, switchresult, weaponobj) {
  if(!istrue(switchresult)) {
    scripts\cp_mp\killstreaks\killstreakdeploy::getridofkillstreakdeployweapon(weaponobj);
  }
}

function function_463f566c8cfddea5(streakname) {
  streakinfo = createstreakinfo(streakname, self);
  return function_7b0acdb995efbcd0(streakinfo);
}

function function_7b0acdb995efbcd0(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  bundle = level.streakglobals.streakbundles["missile_turret"];
  var_85815f97c619c58d = default_to(bundle.var_85815f97c619c58d, 5);
  level.var_2d077aafa2380de7++;

  if(islargemap()) {
    var_85815f97c619c58d = default_to(bundle.var_72680e06cb64591c, 8);
  }

  if(level.missileturrets.size >= var_85815f97c619c58d || level.missileturrets.size + level.var_2d077aafa2380de7 > var_85815f97c619c58d) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_MISSILE_TURRETS");
    }

    level.var_2d077aafa2380de7--;
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(level.teambased) {
    var_c3f98d4efe0c03f6 = default_to(bundle.var_c3f98d4efe0c03f6, 2);

    if(islargemap()) {
      var_c3f98d4efe0c03f6 = default_to(bundle.var_e062971842dc231, 4);
    }

    level.incomingmissileturrets[self.team]++;

    if(getnumactivekillstreakperteam(self.team, level.missileturrets) + level.incomingmissileturrets[self.team] > var_c3f98d4efe0c03f6) {
      level.var_2d077aafa2380de7--;
      level.incomingmissileturrets[self.team]--;

      if(issharedfuncdefined("hud", "showErrorMessage")) {
        self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_MISSILE_TURRETS");
      }

      streakinfo notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  var_86c9d6faba954226 = default_to(bundle.var_86c9d6faba954226, 1);

  if(!isDefined(self.var_9c4245f683e3e800)) {
    self.var_9c4245f683e3e800 = 0;
  }

  self.var_9c4245f683e3e800++;

  if(self.var_9c4245f683e3e800 > var_86c9d6faba954226) {
    self.var_9c4245f683e3e800--;
    level.var_2d077aafa2380de7--;

    if(level.teambased) {
      level.incomingmissileturrets[self.team]--;
    }

    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_MISSILE_TURRETS_PLAYER");
    }

    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      self.var_35cb2404e29573ce = 0;
      self.var_9c4245f683e3e800--;
      level.var_2d077aafa2380de7--;

      if(level.teambased) {
        level.incomingmissileturrets[self.team]--;
      }

      return false;
    }
  }

  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  endonnotify = "sentry_placement_failed";
  weaponobj = makeweapon(bundle.deployweapon);

  if(issharedfuncdefined("weapons", "watchForPlacementFireState")) {
    self thread[[getsharedfunc("weapons", "watchForPlacementFireState")]](streakinfo, endonnotify, weaponobj);
  }

  bundle = level.streakglobals.streakbundles["missile_turret"];
  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, weaponobj, 1, undefined, undefined, &function_b750543c3bf3d80f);

  if(!istrue(deployresult)) {
    self notify(endonnotify);
    self.var_35cb2404e29573ce = 0;
    self.var_9c4245f683e3e800--;
    level.var_2d077aafa2380de7--;

    if(level.teambased) {
      level.incomingmissileturrets[self.team]--;
    }

    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      self.var_35cb2404e29573ce = 0;
      self.var_9c4245f683e3e800--;
      level.var_2d077aafa2380de7--;

      if(level.teambased) {
        level.incomingmissileturrets[self.team]--;
      }

      return false;
    }
  }

  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(0);
  turret = function_993008ef9f603aa6("missile_turret", streakinfo);

  if(!isDefined(turret)) {
    scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
    self.var_35cb2404e29573ce = 0;
    self.var_9c4245f683e3e800--;
    level.var_2d077aafa2380de7--;

    if(level.teambased) {
      level.incomingmissileturrets[self.team]--;
    }

    return false;
  }

  turret function_6e48da87d4a6706(bundle);
  marker = function_159a8e5fa750161c(turret, streakinfo, 0, 1.25);

  if(!isDefined(marker)) {
    scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
    turret delete();
    self.var_35cb2404e29573ce = 0;
    self.var_9c4245f683e3e800--;
    level.var_2d077aafa2380de7--;

    if(level.teambased) {
      level.incomingmissileturrets[self.team]--;
    }

    return false;
  }

  turret function_641996b5e113c5c6(turret, &function_eb7530e3d6daf2d, &function_bfdcec13005413a5, &function_4d4513e6afb21e9c);

  if(issharedfuncdefined("emp", "setEMP_Started_Callback")) {
    turret[[getsharedfunc("emp", "setEMP_Started_Callback")]](&function_bfdcec13005413a5);
  }

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    turret[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_eb7530e3d6daf2d);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    turret[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_97f5e7cad79b5ad2);
  }

  turret scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_1a2bbdf7944594d6);
  turret scripts\cp_mp\equipment\haywire::function_aa823a31304ed981(&function_9b7dfb6fd0cb0bb7);
  turret.deletefunc = &function_a54ce5cd1b4406a6;
  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
  function_56d5f8c1988c64eb(turret, marker);

  if(issharedfuncdefined("missile_turret", "munitionUsed")) {
    self[[getsharedfunc("missile_turret", "munitionUsed")]]();
  }

  self notify("munitions_used", "missile_turret");
  level.var_2d077aafa2380de7--;

  if(level.teambased) {
    level.incomingmissileturrets[self.team]--;
  }

  return true;
}

function function_6e48da87d4a6706(bundle) {
  var_2eca6d053cb3e049 = istrue(bundle.var_fa645b2a1b308dac);

  if(var_2eca6d053cb3e049) {
    self.shootingpositions = [1, 2, 3, 4, 5, 6, 7, 8];
    return;
  }

  self.shootingpositions = [1, 5, 2, 6, 3, 7, 4, 8];
}

function function_159a8e5fa750161c(turret, streakinfo, ignorecancel, var_290b1442271ab369) {
  self.var_35cb2404e29573ce = 1;
  turret laseroff();
  thread function_3133daa58b56fb69(var_290b1442271ab369);
  marker = undefined;

  if(issharedfuncdefined("missile_turret", "watchForPlayerEnteringLastStand")) {
    self thread[[getsharedfunc("missile_turret", "watchForPlayerEnteringLastStand")]]();
  }

  marker = function_98c72b3604b1124d(streakinfo, ignorecancel);
  self notify("turret_placement_finished");
  bundle = level.streakglobals.streakbundles["missile_turret"];

  if(!isDefined(marker) || !isDefined(marker.location)) {
    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      killstreak_switchbacklastweapon(bundle.deployweapon);
    }

    return undefined;
  }

  turret thread scripts\cp_mp\killstreaks\manual_turret::manualturret_disablefire(self, 1, 1);

  if(self hasweapon(bundle.deployweapon)) {
    thread killstreak_switchbacklastweapon(bundle.deployweapon, 1, 1);
  }

  delayspawntime = 0.85;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delayspawntime);

  if(!isalive(self)) {
    return undefined;
  }

  return marker;
}

function function_3133daa58b56fb69(delaytime) {
  self endon("death_or_disconnect");
  self endon("turret_placement_finished");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  self setclientomnvar("ui_turret_placement", 1);
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("death");
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("turret_placement_finished");
}

function function_993008ef9f603aa6(turrettype, streakinfo) {
  config = level.missilesettings[turrettype];
  verticalspawnoffset = getdvarint(@ "hash_a42516bfaeb6df0f");
  turret = spawnturret("misc_turret", self.origin + (0, 0, verticalspawnoffset), level.missilesettings[turrettype].weaponinfo);
  turret.owner = self;
  turret.team = self.team;

  forceenemyteam = getdvarint(@ "hash_8339cedf7d2c80b9", 0);

  if(forceenemyteam) {
    turret.team = ter_op(self.team == "<dev string:x1c>", "<dev string:x26>", "<dev string:x1c>");
  }

  turret.angles = self.angles;
  turret.health = 9999;
  turret.maxhealth = config.maxhealth;
  turret.streakinfo = streakinfo;
  turret.turrettype = turrettype;
  turret.shouldsplash = 1;
  turret.ammocount = config.ammo;
  turret.timeout = config.timeout;
  turret.var_8f7ba18bc776be33 = config.nummissiles;
  turret.var_e9da564de0d3ae0a = config.nummissiles;
  turret.var_54085e2c71f12344 = config.var_54085e2c71f12344;
  turret.var_ab491918db8f34a = 0;

  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    turret.timeout = 9999;
  }

  turret.carriedby = self;
  turret function_70c8684c2c29bf59("placed");
  turret setturretowner(turret.owner);
  turret setturretteam(turret.team);
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret hide();
  turret setautorotationdelay(0.2);
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 0.1;

  switch (turrettype) {
    case #"hash_b571a6187bf67f9e":
    default:
      turret maketurretinoperable();
      turret setleftarc(180);
      turret setrightarc(180);
      turret setbottomarc(50);
      turret settoparc(120);
      turret setconvergencetime(0.2, "pitch");
      turret setconvergencetime(0.2, "yaw");
      turret setconvergenceheightpercent(0.65);
      turret setdefaultdroppitch(-89);
      break;
  }

  turret setturretmodechangewait(1);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  killcamforward = anglesToForward(turret.angles);
  killcampos = turret gettagorigin("tag_laser") + (0, 0, 10);
  killcampos -= killcamforward * 20;
  killcament = spawn("script_model", killcampos);
  killcament linkTo(turret);
  turret.killcament = killcament;
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel("vm_jup_2h_sam_turret_00_ivisi_base");
  turret.colmodel dontinterpolate();
  turret.colmodel hide();
  return turret;
}

function function_56d5f8c1988c64eb(turret, marker) {
  bundle = level.streakglobals.streakbundles["missile_turret"];
  config = level.missilesettings[turret.turrettype];
  level.missileturrets = function_6d6af8144a5131f1(level.missileturrets, turret);
  turret function_70c8684c2c29bf59("placed");

  if(!isDefined(self.placedsentries)) {
    self.placedsentries = [];
  }

  if(!isDefined(self.placedsentries[turret.turrettype])) {
    self.placedsentries[turret.turrettype] = [];
  }

  if(istrue(turret.shouldsplash)) {
    if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, turret.streakinfo.streakname);
    }

    splashname = config.teamsplash;

    if(issharedfuncdefined("hud", "teamPlayerCardSplash") && isDefined(splashname)) {
      level thread[[getsharedfunc("hud", "teamPlayerCardSplash")]](splashname, self);
    }

    turret.shouldsplash = 0;
  }

  turret show();
  turret dontinterpolate();
  turret.angles = marker.angles;
  turret.carriedby = undefined;

  if(isDefined(marker.moving_platform)) {
    turret.moving_platform = marker.moving_platform;
    turret.moving_platform_offset = marker.moving_platform_offset;
    turret.moving_platform_angles_offset = marker.moving_platform_angles_offset;
  }

  self.var_35cb2404e29573ce = 0;
  turret.origin = marker.location;
  turret setscriptablepartstate("turret_carry_state", "turret_plant");
  turret.colmodel show();
  turret.colmodel.angles = turret.angles;
  turret.colmodel.origin = turret.origin;
  turret.colmodel linkTo(turret, "tag_aim_pivot");
  turreticon = bundle.minimapicon;

  if(issharedfuncdefined("game", "createObjective")) {
    turret.minimapid = turret.colmodel[[getsharedfunc("game", "createObjective")]](turreticon, turret.team, undefined, 1, 1);
  }

  turretcount = self.placedsentries[turret.turrettype].size;
  self.placedsentries[turret.turrettype][turretcount] = turret;

  if(turretcount + 1 > 2) {
    self.placedsentries[turret.turrettype][0] notify("kill_turret", 0, 0);
  }

  headiconoffset = 70;

  if(isDefined(level.missilesettings[turret.turrettype].modelbasecover)) {
    if(turret.model == level.missilesettings[turret.turrettype].modelbasecover) {
      headiconoffset = 35;
    }
  }

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    turret[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](turret.turrettype, "Killstreak_Ground", self, 0, 1, headiconoffset, "carried");
  }

  turret setmode(level.missilesettings[turret.turrettype].sentrymodeon);
  hinttag = "bi_base";
  var_803338ee7c91a3e6 = anglestoup(turret gettagangles(hinttag)) * 20;
  hintpos = turret gettagorigin(hinttag) + var_803338ee7c91a3e6;

  if(!isDefined(turret.useownerobj)) {
    turret.useownerobj = function_f43b6a78213dbae8(hintpos, "HINT_BUTTON", undefined, config.ownerusehintstring, undefined, undefined, "show");
  } else {
    turret.useownerobj function_dfb78b3e724ad620(1);
    turret.useownerobj dontinterpolate();
    turret.useownerobj.origin = hintpos;
  }

  turret.useownerobj linkTo(turret, hinttag);

  foreach(guy in level.players) {
    if(guy != turret.owner) {
      turret.useownerobj disableplayeruse(guy);
    }
  }

  if(issharedfuncdefined("killstreak", "handleMovingPlatform")) {
    [[getsharedfunc("killstreak", "handleMovingPlatform")]](turret);
  }

  turret scripts\cp_mp\emp_debuff::allow_emp(1);

  if(issharedfuncdefined("game", "registerSentient")) {
    turret[[getsharedfunc("game", "registerSentient")]]("Killstreak_Static", self);
  }

  turret function_e0abe4175b72981c(turret);
  turret thread function_973e8bbeddc12392(undefined, self);

  turret thread function_9ca3664d52343397();

  turret thread function_c27484ca7994b7d0();
  thread function_755aebb2552f8720(turret, marker);
  thread function_d02d69714fbaffc1(turret);
  thread function_389ebc5025c28934(turret);
  thread function_14aa40ae092fe7b1(turret);
  thread function_7f22f5f0ae012bd4(turret);
  thread function_35a05b3758e712cd(turret);
  thread function_abae0285afe8aa60(turret);
  turret notify("turret_place_successful");
  thread function_a3afddcd4aa1ebf8(turret);

  if(issharedfuncdefined(#"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672")) {
    turret[[getsharedfunc(#"hash_d8976e21a6adafba", #"hash_ca0042e3cac99672")]](turret, &function_e0abe4175b72981c, &function_e0abe4175b72981c);
  }
}

function function_a3afddcd4aa1ebf8(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  level endon("game_ended");
  bundle = level.streakglobals.streakbundles["missile_turret"];
  vehicletargetscategory = [];

  if(!isDefined(bundle) || !istrue(bundle.var_ef14fc78cac39a77)) {
    vehicletargetscategory = ["chopper_gunner", "counter_uav", "scrambler_drone_guard", "uav", "valkyrie_rocket", "switchblade_drone", "loitering_munition", "hover_jet", "gunship", "airdrop_escort"];
  } else {
    foreach(vehicleentry in bundle.vehicleentries) {
      if(isDefined(vehicleentry.name)) {
        vehicletargetscategory[vehicletargetscategory.size] = vehicleentry.name;
      }
    }
  }

  while(true) {
    wait 1;

    if(istrue(turret.isdisabled)) {
      turret cleartargetentity();
      turret.targetentityref = undefined;
      continue;
    }

    targetent = turret gettargetentity();

    if(!isDefined(targetent)) {
      entitiesfound = [];
      var_6d3e2e28d8d8c23f = [];
      targetcategory = undefined;

      if(isDefined(level.activekillstreaks)) {
        foreach(ent in level.activekillstreaks) {
          isdifferentteam = isDefined(ent.team) && ent.team != turret.team;

          if(!isdifferentteam) {
            continue;
          }

          isvalidtarget = 0;

          foreach(category in vehicletargetscategory) {
            if(isDefined(ent.streakname) && ent.streakname == category || isDefined(ent.vehiclename) && ent.vehiclename == category) {
              isvalidtarget = 1;
              targetcategory = category;
              break;
            }
          }

          if(isdifferentteam && isvalidtarget) {
            var_6d3e2e28d8d8c23f[var_6d3e2e28d8d8c23f.size] = ent;
          }
        }
      }

      if(isDefined(level.vehicle.instances)) {
        foreach(category in vehicletargetscategory) {
          if(isDefined(level.vehicle.instances[category])) {
            foreach(vehicle in level.vehicle.instances[category]) {
              if(isDefined(vehicle.ownerteam) && isenemyteam(vehicle.ownerteam, turret.team)) {
                var_6d3e2e28d8d8c23f[var_6d3e2e28d8d8c23f.size] = vehicle;
                targetcategory = category;
                continue;
              }

              if(vehicle.team != "neutral" && isenemyteam(vehicle.team, turret.team)) {
                if(is_equal(vehicle.owner, turret.owner)) {
                  continue;
                }

                var_6d3e2e28d8d8c23f[var_6d3e2e28d8d8c23f.size] = vehicle;
                targetcategory = category;
              }
            }
          }
        }
      }

      targetent = undefined;

      foreach(ent in var_6d3e2e28d8d8c23f) {
        if(isDefined(ent) && function_3bed722fed1cd528(turret, ent)) {
          targetent = ent;
          break;
        }

        waitframe();
      }

      if(isDefined(targetent)) {
        turret setmode(level.missilesettings[turret.turrettype].sentrymodeon);
        wait 0.5;
        turret settargetentity(targetent);
        turret.var_ab491918db8f34a = 1;
        turret.var_5e4c393ce44a423e = targetent.health;
        turret.var_8438670ee6829534 = targetent.maxhealth;
        turret.var_b5df436f25658cbc = function_163e8e495678ee10(targetcategory);
        turret.var_5da08662e2b1cff6 = turret.var_b5df436f25658cbc;
      }

      turret.targetentityref = targetent;
    }
  }
}

function function_163e8e495678ee10(targetcategory) {
  bundle = level.streakglobals.streakbundles["missile_turret"];
  nummissiles = 0;

  if(!isDefined(bundle) || !istrue(bundle.var_ef14fc78cac39a77)) {
    switch (targetcategory) {
      case #"hash_349713b5ad494dda":
        nummissiles = 3;
        break;
      case #"hash_10e585c25e7e9f60":
      case #"hash_27002778019fb447":
        nummissiles = 1;
        break;
      case #"hash_634b246c3da5c56f":
        nummissiles = 1;
        break;
      case #"hash_1fd582647e25c2c1":
        nummissiles = 1;
        break;
      case #"hash_7a687f6a4d685110":
        nummissiles = 1;
        break;
      case #"hash_a1031216158c7882":
        nummissiles = 3;
        break;
      case #"hash_bf2f9adbd2b41d5":
        nummissiles = 3;
        break;
      case #"hash_413c38e72fe8b5bf":
        nummissiles = 3;
        break;
      case #"hash_887ad77192b9c4fb":
        nummissiles = 3;
        break;
      case #"hash_9e36e3bd3a9dd00d":
        nummissiles = 1;
        break;
    }
  } else {
    foreach(vehicleentry in bundle.vehicleentries) {
      if(isDefined(vehicleentry.name) && isDefined(vehicleentry.nummissiles)) {
        if(vehicleentry.name == targetcategory) {
          nummissiles = vehicleentry.nummissiles;
          break;
        }
      }
    }
  }

  return nummissiles;
}

function function_3bed722fed1cd528(turret, ent) {
  bundle = level.streakglobals.streakbundles["missile_turret"];
  contentoverride = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  flashid = (turret.var_e9da564de0d3ae0a - turret.var_8f7ba18bc776be33) % bundle.var_b870b20baede47ae;
  muzzletag = "tag_fx_0" + turret.shootingpositions[flashid];
  var_d2007693a45b2567 = turret gettagorigin(muzzletag);
  radius = 16;
  height = 64;
  heightvector = (0, 0, height);
  getsurfacetype = 0;
  trace = scripts\engine\trace::capsule_trace(var_d2007693a45b2567, ent.origin, radius, height, (0, 0, 0), [], contentoverride, getsurfacetype);

  if(getdvarint(@ "hash_c9bd691ce96079ac", 0) == 1) {
    var_34fb5f21bc6e423d = var_d2007693a45b2567;
    var_3292b1174fe87384 = ent.origin;
    var_bc8dc8693bdfd6f5 = var_34fb5f21bc6e423d + heightvector;
    var_db689ed52d5f374c = var_3292b1174fe87384 + heightvector;
    function_6269f6a8c1c151dc(var_34fb5f21bc6e423d, var_3292b1174fe87384, radius);
    function_6269f6a8c1c151dc(var_bc8dc8693bdfd6f5, var_db689ed52d5f374c, radius);
  }

  result = 0;

  if(trace["hittype"] != "hittype_world") {
    result = 1;
  }

  return result;
}

function function_74ce833622f356f8(turret, player) {
  var_b8bcdc58b18df00d = 0;

  if(isDefined(turret) && isDefined(turret.targetentityref) && isDefined(turret.canshootmissile) && istrue(turret.canshootmissile)) {
    distancetotarget = distance(turret.origin, turret.targetentityref.origin);

    if(distancetotarget <= level.missilesettings[turret.turrettype].attackrange) {
      bundle = level.streakglobals.streakbundles["missile_turret"];
      flashid = (turret.var_e9da564de0d3ae0a - turret.var_8f7ba18bc776be33) % bundle.var_b870b20baede47ae;
      muzzletag = "tag_fx_0" + turret.shootingpositions[flashid];
      var_d2007693a45b2567 = turret gettagorigin(muzzletag);
      missilestart = var_d2007693a45b2567;
      missileend = turret.targetentityref.origin;
      missileweapon = "chopper_gunner_proj_mp";

      if(isDefined(bundle) && isDefined(bundle.var_dbfc786f395886e7)) {
        missileweapon = bundle.var_dbfc786f395886e7;
      }

      missile = _magicbullet(makeweapon(missileweapon), missilestart, missileend, player, turret.targetentityref);
      offsetlocal = (0, 0, 0);
      targettag = turret.targetentityref.var_e54550e04b65ef78;
      targettag = ter_op(!isDefined(targettag), "tag_deathfx", targettag);
      tagvalue = undefined;
      hastag = turret.targetentityref tagexists(targettag);

      if(hastag) {
        tagvalue = turret.targetentityref gettagorigin(targettag);
      }

      if(isDefined(tagvalue)) {
        offsetwc = tagvalue - turret.targetentityref.origin;
        offsetlocal = rotatevectorinverted(offsetwc, turret.targetentityref.angles);
      }

      missile missile_settargetEnt(turret.targetentityref, offsetlocal);
      turret.var_ab491918db8f34a = 0;
      turret.var_8f7ba18bc776be33--;
      turret.var_5da08662e2b1cff6--;
      level notify("stinger_fired", player, missile, turret.targetentityref);
      var_b8bcdc58b18df00d = 1;
      turret setscriptablepartstate("turret_firing_state", "turret_firing");
      wait 0.05;
      turret setscriptablepartstate("turret_firing_state", "off");
    }
  }

  return var_b8bcdc58b18df00d;
}

function function_ad3bcd8ec77ba7a0(turret) {
  turret endon("kill_turret");
  level endon("game_ended");

  if(issharedfuncdefined(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")) {
    turret[[getsharedfunc(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")]](turret);
  }

  if(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
    self notify("switched_from_minigun");

    while(getcompleteweaponname(self getcurrentweapon()) == "iw8_lm_dblmg_mp") {
      waitframe();
    }
  }

  if(isDefined(turret.moving_platform)) {
    turret.moving_platform = undefined;
    turret.moving_platform_offset = undefined;
    turret.moving_platform_angles_offset = undefined;
    turret unlink();
  }

  turret scripts\cp_mp\emp_debuff::allow_emp(0);

  if(issharedfuncdefined("game", "unregisterSentient")) {
    turret[[getsharedfunc("game", "unregisterSentient")]](turret.sentientpool, turret.sentientpoolindex);
  }

  linkedchildren = turret getlinkedchildren();

  foreach(child in linkedchildren) {
    if(isDefined(child)) {
      child unlink();
    }
  }

  if(isDefined(turret.minimapid)) {
    if(issharedfuncdefined("game", "returnObjectiveID")) {
      [[getsharedfunc("game", "returnObjectiveID")]](turret.minimapid);
    }

    turret.minimapid = undefined;
  }

  turret.colmodel unlink();
  turret.colmodel hide();
  function_2239198274531067(turret);
  turret hide();
  turret.carriedby = self;
  turret notify("carried");
  turret playSound("kls_sam_turret_pickup");
  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  endonnotify = "sentry_placement_failed";

  if(issharedfuncdefined("weapons", "watchForPlacementFireState")) {
    self thread[[getsharedfunc("weapons", "watchForPlacementFireState")]](turret.streakinfo, endonnotify);
  }

  bundle = level.streakglobals.streakbundles["missile_turret"];
  switchresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(turret.streakinfo, makeweapon(bundle.deployweapon), 1, undefined, undefined, &function_b750543c3bf3d80f);

  if(!istrue(switchresult)) {
    self notify(endonnotify);
    level.missileturrets = array_remove(level.missileturrets, turret);
    self.var_9c4245f683e3e800--;
    turret delete();
    self.var_35cb2404e29573ce = 0;
    callsharedfunc("killstreak", "refundKillstreak", "missile_turret", 1, 0, 0, 1);
    return 0;
  }

  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(0);
  marker = function_159a8e5fa750161c(turret, turret.streakinfo, 1, 2);

  if(!isDefined(marker)) {
    scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
    level.missileturrets = array_remove(level.missileturrets, turret);
    self.var_9c4245f683e3e800--;
    turret delete();
    self.var_35cb2404e29573ce = 0;
    callsharedfunc("killstreak", "refundKillstreak", "missile_turret", 1, 0, 0, 1);
    return 0;
  }

  scripts\cp_mp\killstreaks\manual_turret::manualturret_toggleallowplacementactions(1);
  function_56d5f8c1988c64eb(turret, marker);
}

function function_6b113bca399df0c9(immediateswitch) {
  if(istrue(immediateswitch)) {
    _switchtoweaponimmediate(self.lastdroppableweaponobj);
  } else {
    _switchtoweapon(self.lastdroppableweaponobj);
  }

  bundle = level.streakglobals.streakbundles["missile_turret"];
  _takeweapon(bundle.deployweapon);
}

function function_2239198274531067(turret) {
  turret setdefaultdroppitch(30);
  turret setmode(level.missilesettings[turret.turrettype].sentrymodeoff);
  turret.useownerobj function_dfb78b3e724ad620(0);
  turret.useownerobj unlink();
}

function function_755aebb2552f8720(turret, marker) {
  turret endon("kill_turret");
  level endon("game_ended");
  wait 0.25;

  if(isDefined(marker.visual)) {
    marker.visual delete();
  }
}

function function_c118279c97ae457f(turret, useobj) {
  if(isDefined(turret)) {
    turret endon("kill_turret");
    turret endon("carried");
  }

  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    useobj disableplayeruse(player);
  }
}

function function_d02d69714fbaffc1(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  turret endon("missile_turret_hacked");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    turret.useownerobj waittill("trigger", player);

    if(player != self) {
      continue;
    }

    if(!player function_aabcea95d6584154()) {
      continue;
    }

    if(istrue(player.isjuggernaut)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        player[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
      }

      continue;
    }

    turret.useownerobj function_dfb78b3e724ad620(0);
    turret setmode(level.missilesettings[turret.turrettype].sentrymodeoff);
    self.placedsentries[turret.turrettype] = array_remove(self.placedsentries[turret.turrettype], turret);
    thread function_ad3bcd8ec77ba7a0(turret);
  }
}

function function_cd59a28cbd743b74(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    player waittill("spawned_player");
    turret.useownerobj disableplayeruse(player);
  }
}

function function_919c2cb7cf831eb8(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  foreach(player in level.players) {
    if(level.teambased) {
      if(player.team != self.team) {
        continue;
      }

      continue;
    }

    if(player != self) {}
  }

  thread function_b78b342431eef863(turret);

  while(true) {
    turret.dismantleobj waittill("trigger", player);
    turret notify("kill_turret", 0, 1);
    break;
  }
}

function function_a54ce5cd1b4406a6() {
  self notify("kill_turret", 0, 1);
}

function function_389ebc5025c28934(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");
  function_3073d3141c30bbe5(turret);
}

function function_b78b342431eef863(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);
    player waittill("spawned_player");

    if(level.teambased) {
      if(player.team != self.team) {
        continue;
      }
    }
  }
}

function private function_eb7530e3d6daf2d(data) {
  if(scripts\cp_mp\emp_debuff::emp_debuff_get_emp_count() >= 2) {
    turret = data.victim;
    turret notify("kill_turret", 1, 1);
  }
}

function function_bfdcec13005413a5(data) {
  if(isDefined(data.attacker)) {
    data.attacker thread callsharedfunc("player", "doScoreEvent", #"emp_disable");
  }

  self turretfiredisable();
  self setmode(level.missilesettings[self.turrettype].sentrymodeoff);
  self laseroff();
}

function function_4d4513e6afb21e9c(isdeath) {
  if(isdeath) {
    return;
  }

  function_e0abe4175b72981c(self);
}

function function_97f5e7cad79b5ad2(data) {
  self turretfireenable();
  self setmode(level.missilesettings[self.turrettype].sentrymodeon);
}

function function_e0abe4175b72981c(turret) {
  turret.isdisabled = turret scripts\cp_mp\emp_debuff::is_empd() || istrue(turret.isjammed) || istrue(turret.ishaywire);

  if(turret.isdisabled) {
    turret turretfiredisable();
    turret setmode(level.missilesettings[turret.turrettype].sentrymodeoff);
    turret laseroff();
    return;
  }

  turret turretfireenable();
  turret setmode(level.missilesettings[turret.turrettype].sentrymodeon);
}

function function_1a2bbdf7944594d6(data) {
  attacker = data.attacker;

  if(!isDefined(self.ishaywire) || !istrue(self.ishaywire)) {
    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
      self.ishaywire = 1;

      if(isDefined(attacker)) {}

      function_e0abe4175b72981c(self);
    }
  }
}

function function_9b7dfb6fd0cb0bb7(data) {
  self.ishaywire = 0;
  function_e0abe4175b72981c(self);
}

function missileturret_hack(newowner, oldowner) {
  if(isDefined(newowner)) {
    self notify("missile_turret_hacked");
    self setturretowner(newowner);
    self setturretteam(newowner.team);
    self.owner = newowner;
    self.team = newowner.team;
    bundle = level.streakglobals.streakbundles["missile_turret"];

    if(isDefined(oldowner)) {
      oldowner.placedsentries[self.turrettype] = array_remove(oldowner.placedsentries[self.turrettype], self);
    }

    if(!isDefined(newowner.placedsentries)) {
      newowner.placedsentries = [];
    }

    if(!isDefined(newowner.placedsentries[self.turrettype])) {
      newowner.placedsentries[self.turrettype] = [];
    }

    turretcount = newowner.placedsentries[self.turrettype].size;
    newowner.placedsentries[self.turrettype][turretcount] = self;

    if(turretcount + 1 > 2) {
      newowner.placedsentries[self.turrettype][0] notify("kill_turret", 0, 0);
    }

    if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[getsharedfunc("sound", "playKillstreakDeployDialog")]](newowner, self.streakinfo.streakname);
    }

    killstreak_dangernotifyplayersinrange(newowner, newowner.team, 2000, self.streakinfo.streakname);
    hinttag = "bi_base";
    config = level.missilesettings[self.turrettype];
    var_803338ee7c91a3e6 = anglestoup(self gettagangles(hinttag)) * 20;
    hintpos = self gettagorigin(hinttag) + var_803338ee7c91a3e6;

    if(!isDefined(self.useownerobj)) {
      self.useownerobj = function_f43b6a78213dbae8(hintpos, "HINT_BUTTON", undefined, config.ownerusehintstring, undefined, undefined, "show");
    } else {
      self.useownerobj function_dfb78b3e724ad620(1);
      self.useownerobj dontinterpolate();
      self.useownerobj.origin = hintpos;
    }

    self.useownerobj linkTo(self, hinttag);

    foreach(guy in level.players) {
      if(guy != self.owner) {
        self.useownerobj disableplayeruse(guy);
        continue;
      }

      self.useownerobj enableplayeruse(guy);
    }

    newowner thread function_d02d69714fbaffc1(self);
    namespace_37987c2865e1a627::clearminimapid();

    if(issharedfuncdefined("game", "createObjective")) {
      self.minimapid = self[[getsharedfunc("game", "createObjective")]](bundle.minimapicon, newowner.team, undefined, 1, 1);
    }

    if(level.teambased) {
      self filteroutplayermarks(newowner.team);
      return;
    }

    self filteroutplayermarks(newowner);
  }
}

function function_14aa40ae092fe7b1(turret) {
  turret endon("carried");
  turret waittill("kill_turret", skipshutdown, wasdestroyed);

  if(issharedfuncdefined(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")) {
    turret[[getsharedfunc(#"hash_d8976e21a6adafba", #"hash_c33ceb91d0ca7a9d")]](turret);
  }

  turret function_83cebe0ae5318a7f(turret);
  level.missileturrets = array_remove(level.missileturrets, turret);

  if(isDefined(self)) {
    self.placedsentries[turret.turrettype] = array_remove(self.placedsentries[turret.turrettype], turret);
    function_2239198274531067(turret);

    if(issharedfuncdefined("player", "printGameAction")) {
      self[[getsharedfunc("player", "printGameAction")]]("killstreak ended - manual_turret", self);
    }

    self.var_9c4245f683e3e800--;
    turret.streakinfo.expiredbydeath = istrue(wasdestroyed);
    scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(turret.streakinfo);
  }

  turret function_70c8684c2c29bf59("destroyed");
  turret setturretowner(undefined);

  if(!istrue(skipshutdown)) {
    turret setscriptablepartstate("shutdown", "on");
    turret setscriptablepartstate("turret_carry_state", "off");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
    turret setscriptablepartstate("explode", "regular");
  } else {
    turret setscriptablepartstate("explode", "violent");
  }

  level callback::callback("killstreak_finish_use", {
    #streakinfo: turret.streakinfo
  });

  if(isDefined(turret.killcament)) {
    turret.killcament delete();
  }

  if(isDefined(turret.useownerobj)) {
    turret.useownerobj delete();
  }

  if(isDefined(turret.useotherobj)) {
    turret.useotherobj delete();
  }

  if(isDefined(turret.colmodel)) {
    turret.colmodel delete();
  }

  if(isDefined(turret.minimapid)) {
    if(issharedfuncdefined("game", "returnObjectiveID")) {
      [[getsharedfunc("game", "returnObjectiveID")]](turret.minimapid);
    }

    turret.minimapid = undefined;
  }

  wait 0.2;
  turret delete();
}

function function_7f22f5f0ae012bd4(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  self endon("disconnect");
  level endon("game_ended");

  while(turret.var_8f7ba18bc776be33 > 0 && turret.timeout > 0) {
    turret.timeout -= 0.5;
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(turret.var_54085e2c71f12344);

  if(turret.timeout > 0) {
    playkillstreakteamleaderdialog(turret.streakinfo.streakname, "destroyed_" + turret.streakinfo.streakname);
  } else {
    playkillstreakteamleaderdialog(turret.streakinfo.streakname, turret.streakinfo.streakname + "_teamleader_timeout");
  }

  turret notify("kill_turret", 0, 0);
}

function function_35a05b3758e712cd(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  waittill_any_3("disconnect", "joined_team", "joined_spectators");
  turret notify("kill_turret", 0, 0);
}

function function_abae0285afe8aa60(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  level waittill("game_ended");
  turret notify("kill_turret", 0, 0);
}

function function_70c8684c2c29bf59(type) {
  turretmodel = undefined;

  if(type == "placed") {
    turretmodel = level.missilesettings[self.turrettype].modelbaseground;
  } else {
    turretmodel = level.missilesettings[self.turrettype].modeldestroyedground;
  }

  assertex(isDefined(turretmodel), "<dev string:x2e>");
  self setModel(turretmodel);
}

function function_973e8bbeddc12392(configoverride, player) {
  self.owner endon("<dev string:x76>");

  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  self.momentum = 0;

  while(true) {
    self waittill("turretstatechange");

    if(self isfiringturret()) {
      self laseron();
      thread function_d335a0d787014372(configoverride, player);
      continue;
    }

    self laseroff();
    function_bb2747086c8be5e4();
    thread function_471af36224e1ceb2();
  }
}

function function_9ca3664d52343397(configoverride) {
  self endon("<dev string:x90>");
  self endon("<dev string:x9f>");
  level endon("<dev string:xaa>");
  self.turrettarget = spawn("<dev string:xb8>", self gettagorigin("<dev string:xc8>") + anglesToForward(self gettagangles("<dev string:xc8>") * 300));
  self.turrettarget.targeton = 0;
  self.turrettarget dontinterpolate();
  self.turrettarget thread function_f77183de0101e64(self);
  self.turrettarget thread function_150429e3a1a34f4c(self);
  turretconfig = undefined;

  if(isDefined(configoverride)) {
    turretconfig = configoverride;
  } else {
    turretconfig = level.missilesettings[self.turrettype];
  }

  sentrymode = turretconfig.sentrymodeon;
  manualmode = "<dev string:xd5>";
  turretmode = sentrymode;
  notifyon = 0;

  while(true) {
    if(getdvarint(@ "hash_c9bd691ce96079ac", 0) == 1) {
      if(!istrue(notifyon)) {
        self.owner notifyonplayercommand("<dev string:x76>", "<dev string:xe6>");
        notifyon = 1;
      }

      self.owner waittill("<dev string:x76>");

      if(turretmode != manualmode) {
        self setmode(manualmode);
        turretmode = manualmode;
        starttrace = self.owner getvieworigin();
        endtrace = starttrace + anglesToForward(self.owner getplayerangles()) * 50000;
        trace = scripts\engine\trace::ray_trace(starttrace, endtrace, self.owner);
        endpos = undefined;

        if(isDefined(trace["<dev string:xf6>"]) && trace["<dev string:xf6>"] != "<dev string:x101>") {
          endpos = trace["<dev string:x111>"];
        }

        if(isDefined(endpos)) {
          thread function_295d25dc7b9680be(endpos);
        }
      } else {
        function_12e1880e082f372a();
        turretmode = sentrymode;
        self setmode(turretmode);
        thread function_973e8bbeddc12392();
      }

      continue;
    }

    notifyon = 0;

    if(turretmode != sentrymode) {
      self.owner notifyonplayercommandremove("<dev string:x76>", "<dev string:xe6>");
      function_12e1880e082f372a();
      turretmode = sentrymode;
      self setmode(turretmode);
      thread function_973e8bbeddc12392();
    }

    waitframe();
  }
}

function function_295d25dc7b9680be(firepos) {
  self.owner endon("<dev string:x11d>");
  self.owner endon("<dev string:x76>");
  self endon("<dev string:x90>");
  self endon("<dev string:x9f>");
  level endon("<dev string:xaa>");
  self laseroff();
  thread function_471af36224e1ceb2();
  self.turrettarget.origin = firepos;
  self settargetentity(self.turrettarget);
  self.turrettarget.targeton = 1;
  starttag = "<dev string:x133>";

  if(self.streakinfo.streakname == "<dev string:x147>") {
    starttag = "<dev string:x155>";
  }

  endtag = "<dev string:xc8>";
  wait 1;
  self laseron();

  while(true) {
    var_30c9c9336ef2caaf = self gettagorigin(starttag);
    var_831cc1b8f4225351 = self gettagangles(starttag);
    thread drawsphere(var_30c9c9336ef2caaf, 2, 1, (0, 1, 1));
    thread drawline(var_30c9c9336ef2caaf, var_30c9c9336ef2caaf + anglesToForward(var_831cc1b8f4225351) * 1800, 1, (0, 1, 1));
    flashtagorigin = self gettagorigin(endtag);
    flashtagangles = self gettagangles(endtag);
    thread drawsphere(flashtagorigin, 2, 1, (1, 1, 0));
    thread drawline(flashtagorigin, flashtagorigin + anglesToForward(flashtagangles) * 1800, 1, (1, 1, 0));
    wait 1;
  }
}

function function_12e1880e082f372a() {
  self cleartargetentity();
  self laseroff();
  thread function_471af36224e1ceb2();
  self.turrettarget.targeton = 0;
  self.owner notify("<dev string:x11d>");
}

function function_f77183de0101e64(turret) {
  turret endon("<dev string:x90>");
  turret endon("<dev string:x9f>");
  self endon("<dev string:x16b>");
  level endon("<dev string:xaa>");

  while(true) {
    if(istrue(self.targeton)) {
      sphere(self.origin, 20, (1, 1, 0), 0, 1);
    }

    waitframe();
  }
}

function function_150429e3a1a34f4c(turret) {
  turret endon("<dev string:x90>");
  turret endon("<dev string:x9f>");
  self endon("<dev string:x16b>");
  level endon("<dev string:xaa>");
  turret waittill("<dev string:x16b>");
  self delete();
}

function function_d60ffc368c740a5() {
  self endon("death");
  self setscriptablepartstate("turret_target_found", "target_found");
}

function missile_spinup(configoverride) {
  thread function_d60ffc368c740a5();

  while(self.momentum < configoverride.spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function function_bb2747086c8be5e4() {
  self.momentum = 0;
  self setscriptablepartstate("turret_target_found", "off");
}

function function_d335a0d787014372(configoverride, player) {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  turretconfig = undefined;

  if(isDefined(configoverride)) {
    turretconfig = configoverride;
  } else {
    turretconfig = level.missilesettings[self.turrettype];
  }

  missile_spinup(turretconfig);
  firetime = weaponfiretime(turretconfig.weaponinfo);

  while(true) {
    if(self.var_8f7ba18bc776be33 == turretconfig.nummissiles) {
      wait turretconfig.lockontime;
    }

    if(self.var_8f7ba18bc776be33 > 0 && isDefined(self.targetentityref)) {
      diffhealth = self.var_5e4c393ce44a423e - self.targetentityref.health;

      if(diffhealth < self.targetentityref.maxhealth) {
        if(self.var_ab491918db8f34a || self.var_5da08662e2b1cff6 <= 0) {
          wait turretconfig.lockontime;
        }

        if(self.var_5da08662e2b1cff6 <= 0) {
          self.var_5da08662e2b1cff6 = self.var_b5df436f25658cbc;
        }

        self.canshootmissile = 1;
        function_74ce833622f356f8(self, player);
      }
    }

    wait turretconfig.cooldowntime;
  }
}

function function_471af36224e1ceb2() {
  self.canshootmissile = 0;
  self notify("stop_shooting");
}

function turret_heatmonitor() {
  self.owner endon("<dev string:x76>");

  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");
  overheattime = level.missilesettings[self.turrettype].overheattime;

  while(true) {
    if(self.heatlevel > overheattime) {
      self.overheated = 1;

      while(self.heatlevel) {
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    wait 0.05;
  }
}

function playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  while(true) {
    playFXOnTag(getfx("sentry_overheat_mp"), self, "tag_flash");
    wait level.missilesettings[self.turrettype].fxtime;
  }
}

function turret_coolmonitor() {
  self.owner endon("<dev string:x76>");

  self endon("kill_turret");
  self endon("carried");
  level endon("game_ended");

  while(true) {
    if(self.heatlevel > 0) {
      if(self.cooldownwaittime <= 0) {
        self.heatlevel = max(0, self.heatlevel - 0.05);
      } else {
        self.cooldownwaittime = max(0, self.cooldownwaittime - 0.05);
      }
    }

    wait 0.05;
  }
}

function function_c27484ca7994b7d0() {
  self endon("death");
  self endon("carried");
  self endon("kill_turret");
  level endon("game_ended");

  while(true) {
    wait 3;

    if(self isfiringturret()) {
      waitframe();
      continue;
    }

    self setscriptablepartstate("turret_target_search", "target_search");
    wait 0.05;
    self setscriptablepartstate("turret_target_search", "off");
  }
}

function function_98c72b3604b1124d(streakinfo, ignorecancel) {
  assertex(isPlayer(self), "<dev string:x174>");

  if(issharedfuncdefined("killstreak", "getTargetMarker")) {
    return self[[getsharedfunc("killstreak", "getTargetMarker")]](streakinfo, ignorecancel);
  }
}

function function_f43b6a78213dbae8(hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  if(issharedfuncdefined("game", "createHintObject")) {
    return [[getsharedfunc("game", "createHintObject")]](hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov);
  }
}

function function_3073d3141c30bbe5(turret) {
  assertex(isPlayer(self), "<dev string:x174>");

  if(issharedfuncdefined("damage", "monitorDamage")) {
    turret thread[[getsharedfunc("damage", "monitorDamage")]](turret.maxhealth, "hitequip", &function_242ded3cfe2e5d3b, &function_6886c78f9664c089, 1);
  }
}

function function_242ded3cfe2e5d3b(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level.missilesettings[self.turrettype];
  notifyattacker = 0;

  if(issharedfuncdefined("damage", "onKillstreakKilled")) {
    notifyattacker = self[[getsharedfunc("damage", "onKillstreakKilled")]](config.streakname, attacker, objweapon, type, damage, config.scorepopup, config.vodestroyed, config.destroyedsplash);
  }

  if(notifyattacker) {
    attacker notify("destroyed_equipment");
  }

  explosivedamage = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH") {
    explosivedamage = 1;
  }

  self notify("enemy_destroyed_equipment", attacker);
  self notify("kill_turret", explosivedamage, 1);
}

function function_6886c78f9664c089(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;

  if(istrue(level.var_be6a42242be00b66)) {
    bundle = level.streakglobals.streakbundles["missile_turret"];
    modifieddamage = getmodifieddamageusingdamagetuning(attacker, objweapon, type, modifieddamage, self.maxhealth, bundle.var_e913079a5ffda56d);
  } else if(issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    modifieddamage = self[[getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, type, modifieddamage, self.maxhealth, 2, 3, 4, 3, 400);
  }

  return modifieddamage;
}

function function_a0a5114bb65fcecd() {
  bundle = level.streakglobals.streakbundles["missile_turret"];
  assertex(isDefined(bundle), "<dev string:x1ab>");

  if(!isDefined(bundle)) {
    bundle = spawnStruct();
  }

  level.missilesettings["missile_turret"] = spawnStruct();
  level.missilesettings["missile_turret"].health = 999999;
  level.missilesettings["missile_turret"].maxhealth = isDefined(bundle.maxhealth) ? bundle.maxhealth : 650;
  level.missilesettings["missile_turret"].burstmin = 10;
  level.missilesettings["missile_turret"].burstmax = 20;
  level.missilesettings["missile_turret"].pausemin = 1;
  level.missilesettings["missile_turret"].pausemax = 1.25;
  level.missilesettings["missile_turret"].lockstrength = 6;
  level.missilesettings["missile_turret"].sentrymodeon = "sentryManual";
  level.missilesettings["missile_turret"].sentrymodeoff = "sentry_offline";
  level.missilesettings["missile_turret"].timeout = 75;
  level.missilesettings["missile_turret"].spinuptime = 0.65;
  level.missilesettings["missile_turret"].overheattime = 8;
  level.missilesettings["missile_turret"].cooldowntime = default_to(bundle.var_1d3aef3fc310dff4, 1.25);
  level.missilesettings["missile_turret"].fxtime = 0.3;
  level.missilesettings["missile_turret"].streakname = "missile_turret";
  level.missilesettings["missile_turret"].weaponinfo = bundle.var_661e446067d68053;
  level.missilesettings["missile_turret"].playerweaponinfo = bundle.var_661e446067d68053;
  level.missilesettings["missile_turret"].scriptable = "ks_sentry_turret_mp";
  level.missilesettings["missile_turret"].modelbaseground = bundle.var_5a6fd584b4611973;
  level.missilesettings["missile_turret"].modeldestroyedground = bundle.var_d5a88876b95fb971;
  level.missilesettings["missile_turret"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level.missilesettings["missile_turret"].ownerusehintstring = &"KILLSTREAKS_HINTS/MISSILE_TURRET_USE";
  level.missilesettings["missile_turret"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.missilesettings["missile_turret"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.missilesettings["missile_turret"].headicon = 1;

  if(!isDefined(bundle.var_c9456bf1b15d2038)) {
    level.missilesettings["missile_turret"].teamsplash = "used_missile_turret";
  } else {
    level.missilesettings["missile_turret"].teamsplash = bundle.var_c9456bf1b15d2038;
  }

  level.missilesettings["missile_turret"].destroyedsplash = "callout_destroyed_sentry_gun";
  level.missilesettings["missile_turret"].shouldsplash = 1;
  level.missilesettings["missile_turret"].votimeout = "missile_turret_teamleader_destroyed";
  level.missilesettings["missile_turret"].vodestroyed = "missile_turret_teamleader_destroyed";
  level.missilesettings["missile_turret"].scorepopup = "destroyed_sentry";
  level.missilesettings["missile_turret"].lightfxtag = "tag_fx";
  level.missilesettings["missile_turret"].iskillstreak = 1;
  level.missilesettings["missile_turret"].headiconoffset = (0, 0, 75);
  level.missilesettings["missile_turret"].nummissiles = default_to(bundle.var_b870b20baede47ae, 3);
  level.missilesettings["missile_turret"].attackrange = default_to(bundle.var_fabd4037e21eaae, 100000);
  level.missilesettings["missile_turret"].lockontime = default_to(bundle.var_ba2ce898bfb0a9e, 3);
  level.missilesettings["missile_turret"].var_54085e2c71f12344 = default_to(bundle.var_5db04d284952849c, 10);
  level.var_2d077aafa2380de7 = 0;

  foreach(teamname in level.teamnamelist) {
    level.incomingmissileturrets[teamname] = 0;
  }

  level.missileturrets = [];
}

function function_f42f083e1874b55a() {
  bundle = level.streakglobals.streakbundles["missile_turret"];

  if(!isDefined(bundle) || !issharedfuncdefined("vehicle", "get_weapon_hit_damage_data") || !issharedfuncdefined("vehicle", "get_vehicle_hit_damage_data") || !issharedfuncdefined("vehicle", "set_vehicle_hit_damage_data_for_weapon")) {
    return;
  }

  foreach(vehicleentry in bundle.vehicleentries) {
    if(istrue(vehicleentry.isvehicle) && isDefined(vehicleentry.name) && isDefined(vehicleentry.nummissiles) && isDefined(bundle.var_dbfc786f395886e7)) {
      weapondata = [[getsharedfunc("vehicle", "get_weapon_hit_damage_data")]](bundle.var_dbfc786f395886e7);
      vehicledata = [[getsharedfunc("vehicle", "get_vehicle_hit_damage_data")]](vehicleentry.name);
      var_71a662cd1563bca2 = undefined;

      if(isDefined(weapondata) && weapondata.hitsperattack > 0) {
        var_71a662cd1563bca2 = weapondata.hitsperattack * vehicleentry.nummissiles;
        [[getsharedfunc("vehicle", "set_vehicle_hit_damage_data_for_weapon")]](vehicleentry.name, var_71a662cd1563bca2, bundle.var_dbfc786f395886e7);
      }
    }
  }
}

function function_aabcea95d6584154() {
  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    return false;
  }

  if(scripts\cp_mp\utility\killstreak_utility::iskillstreakdeployweapon(self getcurrentweapon())) {
    return false;
  }

  return true;
}

function function_6269f6a8c1c151dc(raycaststart, raycastend, radius) {
  duration = 100;
  red = (255, 0, 0);
  green = (0, 255, 0);
  blue = (0, 0, 255);
  sphere(raycaststart, radius, red, 0, duration);
  sphere(raycastend, radius, blue, 0, duration);
  line(raycaststart, raycastend, green, 1, 0, duration);
}

# /