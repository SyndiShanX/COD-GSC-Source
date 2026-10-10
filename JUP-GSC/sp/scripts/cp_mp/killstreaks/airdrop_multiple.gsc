/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\killstreaks\airdrop_multiple.gsc
*************************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\sentientpoolmanager;
#namespace airdrop_multiple;

function airdrop_multiple_init() {
  assertex(isDefined(level.cratedropdata), "airdrop_multiple_init() called before scriptscp_mpkillstreaksairdrop::initCrateDropData().");
  level.cratedropdata.ac130s = [];

  if(issharedfuncdefined("airdrop_multiple", "init")) {
    [[getsharedfunc("airdrop_multiple", "init")]]();
  }

  airdrop_multiple_initanimations();
  function_4d3d5b47e3ef44cd();

  setdevdvarifuninitialized(@ "hash_2a4cc37411737c83", 0);
  setdevdvarifuninitialized(@ "hash_ca9066b6383c5a0e", -1);
}

function airdrop_multiple_initanimations() {
  function_dd9c6b6a52a14c8d();
  function_cff636ac94a2febc();
  function_64d1f666aecf56f0();
  function_86d69a3dbc763cb9();
}

function function_4d3d5b47e3ef44cd() {
  game["dialog"]["airdrop_multiple_use"] = "killstreak_remote_operator" + "_request_response";
}

#using_animtree("script_model");

function function_dd9c6b6a52a14c8d() {
  animname = "care_package_drop_multiple";
  animbasename = undefined;
  animbasename = "ac130";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % mp_eadrop_acharlie130;
  animbasename = "care_package" + "_1";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % mp_eadrop_cpkg_01;
  animbasename = "care_package" + "_2";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % mp_eadrop_cpkg_02;
  animbasename = "care_package" + "_3";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % mp_eadrop_cpkg_03;
  animbasename = "care_package_chute" + "_1";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % mp_eadrop_parachute_01;
  animbasename = "care_package_chute" + "_2";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % mp_eadrop_parachute_02;
  animbasename = "care_package_chute" + "_3";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % mp_eadrop_parachute_03;
}

#using_animtree("mp_vehicles_always_loaded");

function function_cff636ac94a2febc() {
  animbasename = "care_package_drop_multiple";
  animname = "heli_multi";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % iw9_air_heli_dropoff;
}

#using_animtree("script_model");

function function_64d1f666aecf56f0() {
  animbasename = "care_package_drop_multiple";
  animname = "heli_multi_rope" + "_1";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % iw9_air_heli_rope_dropoff_1;
  animname = "heli_multi_rope" + "_2";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % iw9_air_heli_rope_dropoff_2;
  animname = "heli_multi_rope" + "_3";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % iw9_air_heli_rope_dropoff_3;
}

function function_86d69a3dbc763cb9() {
  animbasename = "care_package_drop_multiple";
  animname = "heli_multi_crate" + "_1";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % iw9_air_heli_crate_dropoff_1;
  animname = "heli_multi_crate" + "_2a";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % iw9_air_heli_crate_dropoff_2a;
  animname = "heli_multi_crate" + "_2b";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % iw9_air_heli_crate_dropoff_2b;
  animname = "heli_multi_crate" + "_3a";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % iw9_air_heli_crate_dropoff_3a;
  animname = "heli_multi_crate" + "_3b";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % iw9_air_heli_crate_dropoff_3b;
  animname = "heli_multi_crate" + "_3c";
  level.scr_animtree[animbasename] = #animtree;
  level.scr_anim[animbasename][animname] = % iw9_air_heli_crate_dropoff_3c;
}

function airdrop_multiple_dropcrates(owner, team, position, angles, destination, vehiclereserved, streakinfo) {
  if(level.cratedropdata.ac130s.size >= 2) {
    if(isDefined(owner) && isDefined(streakinfo)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        owner[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
      }

      if(issharedfuncdefined("killstreak", "awardKillstreakFromStruct")) {
        owner[[getsharedfunc("killstreak", "awardKillstreakFromStruct")]](streakinfo.mpstreaksysteminfo, "other");
      }
    }

    return;
  }

  streaknames = [];
  cratetype = ter_op(isDefined(owner), "killstreak", "killstreak_no_owner");
  numcrates = 3;

  var_acbbc84523b93bbf = getdvarint(@ "hash_ca9066b6383c5a0e", -1);

  if(isDefined(var_acbbc84523b93bbf) && var_acbbc84523b93bbf > 0) {
    numcrates = var_acbbc84523b93bbf;
  }

  usephysics = undefined;

  if(isDefined(streakinfo.cratetype)) {
    cratetype = streakinfo.cratetype;
  }

  if(isDefined(streakinfo.numcrates)) {
    numcrates = streakinfo.numcrates;
  }

  if(isDefined(streakinfo.usephysics)) {
    usephysics = streakinfo.usephysics;
  }

  for(i = 0; i < numcrates; i++) {
    streakname = undefined;

    if(streaknames.size > 0) {
      streakname = getrandomkillstreak(streaknames);
    } else {
      streakname = getrandomkillstreak();
    }

    streaknames[streaknames.size] = streakname;
  }

  if(isDefined(owner)) {
    owner thread scripts\cp_mp\killstreaks\airdrop::airdrop_playdeploydialog(streakinfo);

    if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + "airdrop_multiple", owner);
    }
  }

  var_ebb5c644a3f5cfbc = function_ad08ac92f283b91e(position);
  var_46d5f28d2724bf1f = angles * (0, 1, 0);
  scenenode = spawn("script_model", var_ebb5c644a3f5cfbc);
  scenenode.angles = var_46d5f28d2724bf1f;
  scenenode setModel("tag_origin");
  scenenode.owner = owner;
  scenenode.team = team;
  scenenode.hasowner = isDefined(owner);
  scenenode.latestanimendtime = -1;
  heli = function_1c989718d26b182d(scenenode, vehiclereserved, streakinfo);

  if(!isDefined(heli)) {
    scenenode function_d1443844f7590343();
    return undefined;
  }

  rope = function_a1c4a7ca871dcdf5(scenenode, streaknames);

  if(!isDefined(rope)) {
    scenenode function_d1443844f7590343();
    return undefined;
  }

  crates = function_af5c454f08db45e1(cratetype, scenenode, streaknames, streakinfo, position);

  if(scenenode.crates.size < numcrates) {
    scenenode function_d1443844f7590343(1);
    return undefined;
  }

  scenenode thread function_8e3fa08965432cfa();
  return scenenode;
}

function airdrop_multiple_watchdropcrates() {
  self endon("death");
  scripts\common\anim::anim_first_frame_solo(self.ac130, "care_package_drop_multiple");

  foreach(crate in self.crates) {
    scripts\common\anim::anim_first_frame_solo(crate, "care_package_drop_multiple");
  }

  foreach(chute in self.chutes) {
    scripts\common\anim::anim_first_frame_solo(chute, "care_package_drop_multiple");
  }

  airdrop_multiple_watchdropcratesinternal();
  thread airdrop_multiple_watchdropcratesend();
}

function airdrop_multiple_watchdropcratesinternal() {
  firstframe = undefined;

  while(gettime() <= self.latestanimendtime) {
    if(self.hasowner) {
      if(!isDefined(self.ownerdisconnected)) {
        if(isDefined(self.owner)) {
          if(!isDefined(self.ownerjoinedteam)) {
            if(self.team != self.owner.team) {
              self.ownerjoinedteam = 1;
            }
          }
        } else {
          self.ownerdisconnected = 1;
        }
      }
    }

    if(!isDefined(firstframe)) {
      firstframe = 1;
    } else if(firstframe) {
      if(isDefined(self.ac130)) {
        self.ac130 thread airdrop_multiple_ac130firstframe();
        thread scripts\common\anim::anim_single_solo(self.ac130, "care_package_drop_multiple");
      }

      foreach(crate in self.crates) {
        if(isDefined(crate)) {
          crate setscriptablepartstate("visibility", "show", 0);
          thread scripts\common\anim::anim_single_solo(crate, "care_package_drop_multiple");
        }
      }

      foreach(chute in self.chutes) {
        if(isDefined(chute)) {
          chute show();
          thread scripts\common\anim::anim_single_solo(chute, "care_package_drop_multiple");
        }
      }

      firstframe = 0;
    } else {
      disowned = istrue(self.ownerdisconnected) || istrue(self.ownerjoinedteam);

      if(isDefined(self.ac130)) {
        if(disowned || gettime() > self.ac130.animendtime) {
          self.ac130 airdrop_multiple_destroyac130();
        }
      }

      foreach(crate in self.crates) {
        if(isDefined(crate)) {
          if(gettime() > crate.animendtime) {
            if(disowned) {
              crate thread destroycrate();
            }

            thread docratedropfromscripted(crate);
            continue;
          }

          if(gettime() > crate.animdroptime) {
            if(gettime() > crate.animstoptrailtime) {
              crate setscriptablepartstate("trail", "neutral", 1);
            } else {
              crate setscriptablepartstate("trail", "active", 1);
            }

            if(disowned) {
              crate thread destroycrate();
            }

            continue;
          }

          if(disowned) {
            crate thread destroycrate();
            continue;
          }

          if(!isDefined(self.ac130) || istrue(self.ac130.isdestroyed)) {
            thread docratedropfromscripted(crate);
          }
        }
      }

      foreach(chute in self.chutes) {
        if(isDefined(chute)) {
          if(gettime() > chute.animendtime) {
            chute thread destroychute();
            continue;
          }

          if(gettime() <= chute.crateanimdroptime && (!isDefined(chute.crate) || !isDefined(self.crates[chute.crate getentitynumber()]))) {
            chute thread destroychute();
            continue;
          }

          if(gettime() > chute.animunhidetime) {
            chute setscriptablepartstate("visibility", "show", 0);
          }
        }
      }
    }

    waitframe();
  }
}

function airdrop_multiple_watchdropcratesend() {
  if(isDefined(self.ac130)) {
    self.ac130 thread airdrop_multiple_destroyac130();
  }

  foreach(crate in self.crates) {
    if(isDefined(crate)) {
      crate thread destroycrate();
    }
  }

  foreach(chute in self.chutes) {
    if(isDefined(chute)) {
      chute thread destroychute();
    }
  }

  self delete();
}

function airdrop_multiple_createac130(scenenode) {
  ac130 = spawn("script_model", scenenode.origin);
  ac130.angles = scenenode.angles;
  ac130.owner = scenenode.owner;
  ac130.team = scenenode.team;
  ac130.scenenode = scenenode;
  scenenode.ac130 = ac130;
  ac130 scriptmoveroutline();
  ac130 scriptmoverthermal();
  ac130 setotherent(scenenode.owner);
  ac130 setentityowner(scenenode.owner);
  ac130 hide();
  airdrop_multiple_addac130tolist(ac130);
  ac130.animname = "ac130";
  ac130 scripts\common\anim::setanimtree();
  var_96668adb78c5aa8a = level.scr_anim["ac130"]["care_package_drop_multiple"];
  ac130.animendtime = gettime() + getanimlength(var_96668adb78c5aa8a) * 1000;
  scenenode.latestanimendtime = ter_op(ac130.animendtime > scenenode.latestanimendtime, ac130.animendtime, scenenode.latestanimendtime);
  minimapid = -1;

  if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
    minimapid = ac130[[scripts\engine\utility::getsharedfunc("game", "createObjective")]]("icon_minimap_dropship", scenenode.team, 1, 1, 1);
  }

  if(minimapid != -1) {
    ac130.minimapid = minimapid;
  }

  return ac130;
}

function airdrop_multiple_ac130firstframe() {
  self show();
  self playLoopSound("iw8_bradley_drop_c130");
  self setscriptablepartstate("lights2", "on", 0);
  self setscriptablepartstate("contrails", "on", 0);

  if(scripts\engine\utility::issharedfuncdefined("airdrop_multiple", "monitorDamage")) {
    self thread[[scripts\engine\utility::getsharedfunc("airdrop_multiple", "monitorDamage")]](1000, "hitequip", &airdrop_multiple_ac130handlefataldamage, &airdrop_multiple_ac130handledamage, 1);
  }
}

function airdrop_multiple_destroyac130() {
  airdrop_multiple_deleteac130();
}

function airdrop_multiple_deleteac130(deletiondelay) {
  self notify("death");

  if(isDefined(self.scenenode)) {
    self.scenenode.ac130 = undefined;
  }

  airdrop_multiple_removeac130fromlist(self getentitynumber());
  self.scenenode = undefined;
  self.animendtime = undefined;
  self stoploopsound();

  if(isDefined(self.minimapid)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  if(isDefined(deletiondelay) && deletiondelay > 0) {
    wait deletiondelay;
  }

  self delete();
}

function airdrop_multiple_ac130handledamage(data) {
  if(isDefined(data.attacker) && isPlayer(data.attacker)) {
    if(issharedfuncdefined("damage", "updateDamageFeedback")) {
      data.attacker[[getsharedfunc("damage", "updateDamageFeedback")]]("");
    }
  }

  return false;
}

function airdrop_multiple_ac130handlefataldamage(data) {
  if(isPlayer(data.attacker)) {
    friendlydamage = 0;

    if(level.teambased && data.attacker.team == self.team) {
      friendlydamage = 1;
    } else if(data.attacker == self.owner) {
      friendlydamage = 1;
    }

    if(!friendlydamage) {
      if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
        thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("callout_destroyed_ac130", data.attacker);
      }

      if(issharedfuncdefined("player", "doScoreEvent")) {
        data.attacker thread[[getsharedfunc("player", "doScoreEvent")]]("kill", data.objweapon, 400);
      }
    }
  }

  airdrop_multiple_destroyac130();
}

function function_1c989718d26b182d(scenenode, vehiclereserved, streakinfo) {
  if(istrue(vehiclereserved)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }

  helipos = scenenode.origin;
  heliangles = scenenode.angles;
  heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, helipos, heliangles, "veh_airdrop_mp_phys", "veh9_mil_air_heli_medium_airdrop_mp");

  if(!isDefined(heli)) {
    return undefined;
  }

  if(!isDefined(scenenode.team)) {
    scenenode.team = "neutral";
  }

  if(scenenode.team != "neutral") {
    heli setvehicleteam(scenenode.team);
  }

  heli.owner = scenenode.owner;
  heli.team = scenenode.team;
  heli.health = 999999;
  heli.scenenode = scenenode;
  heli.animname = "care_package_drop_multiple";
  heli.animindex = "heli_multi";
  heli.animtoplay = level.scr_anim[heli.animname][heli.animindex];
  scenenode.heli = heli;
  scenenode.heliendtime = gettime() + getanimlength(heli.animtoplay) * 1000;
  scenenode.var_79ac0ff6c36a088d = getanimlength(heli.animtoplay);
  scenenode.latestanimendtime = scenenode.heliendtime;
  destroyedsplash = undefined;
  vodestroyed = undefined;
  scorepopup = undefined;

  if(isDefined(level.heliconfigs) && isDefined(level.heliconfigs["airdrop_multiple"])) {
    config = level.heliconfigs["airdrop_multiple"];
    heli.maxhealth = config.maxhealth;
    heli.currenthealth = config.maxhealth;
    vocallout = config.callout;
    vodestroyed = config.vodestroyed;
    scorepopup = config.scorepopup;
  } else {
    heli.maxhealth = 1200;
    heli.currenthealth = heli.maxhealth;
  }

  heli.helitype = "airdrop_multiple";
  heli setscriptablepartstate("engine", "on", 0);
  heli setscriptablepartstate("lights", "active", 1);

  if(isDefined(heli.owner)) {
    if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
      heli[[getsharedfunc("killstreak", "addToActiveKillstreakList")]]("airdrop_multiple", "Killstreak_Air", heli.owner, 0, 0);
    }

    if(scenenode.team != "neutral") {
      heli scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", heli.owner);
    }
  }

  heli function_3856d0dd250dd766(streakinfo.streakname);
  heli thread scripts\cp_mp\killstreaks\airdrop::watchhelidestroyearly();
  return heli;
}

function function_3856d0dd250dd766(streakname) {
  killstreakvehicle = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = undefined;
  destroyedsplash = "callout_destroyed_" + streakname;
  var_8dfc256103cce53e = &function_abf972f8c94ee5a4;
  var_191284e2e2837328 = &function_6ad0d2b89ebccb68;
  premoddamagecallback = &function_cc5032d2f9d08d1a;
  postmoddamagecallback = &function_f1e65202514970c5;
  deathcallback = &function_71d81f98f8638b99;
  killstreak_setupvehicledamagefunctionality(streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback);

  if(isDefined(self.owner)) {
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  }

  function_cfc5e3633ef950fd(1, 1000, &function_36159d21c49360ca);
  function_cfc5e3633ef950fd(2, 500, &function_870290238449589f);
  function_cfc5e3633ef950fd(3, 250, &function_1a3db0d03ec0014f);
}

function function_abf972f8c94ee5a4(streakname) {
  if(issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, 7);
  }
}

function function_6ad0d2b89ebccb68(streakname) {}

function function_cc5032d2f9d08d1a(data) {
  damage = data.damage;
  attacker = data.attacker;
  return true;
}

function function_f1e65202514970c5(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  self.currenthealth -= damage;
  killstreak_updatedamagestate(self.currenthealth);
  return true;
}

function function_36159d21c49360ca() {}

function function_870290238449589f() {}

function function_1a3db0d03ec0014f() {}

function function_71d81f98f8638b99(data) {
  self.killedbyweapon = data.objweapon;
  thread destroyheli();
  return true;
}

function function_a1c4a7ca871dcdf5(scenenode, streaklist) {
  heli = scenenode.heli;
  rope = spawn("script_model", heli.origin);
  rope setModel("veh9_mil_air_heli_airdrop_rig_mp");
  rope.animname = "care_package_drop_multiple";
  rope.animindex = function_6624058bac19055d(streaklist);
  rope.animtoplay = level.scr_anim[rope.animname][rope.animindex];
  rope.scenenode = scenenode;
  rope scripts\common\anim::setanimtree();
  scenenode.rope = rope;
  numcrates = streaklist.size;

  if(numcrates < 3) {
    rope setscriptablepartstate("rope_visibility", "show_" + numcrates);
  }

  return rope;
}

function function_af5c454f08db45e1(cratetype, scenenode, streaklist, streakinfo, markerposition) {
  owner = scenenode.owner;
  team = scenenode.team;
  destination = scenenode.origin;
  usephysics = 0;
  animbasename = "care_package_drop_multiple";
  crates = [];

  for(i = 0; i < streaklist.size; i++) {
    animindex = function_e23eb6d57186432c(i, streaklist);
    data = getkillstreakcratedatabystreakname(streaklist[i], 0);
    crate = createcrateforscripteddrop(owner, team, cratetype, destination, usephysics, 0, data, streakinfo, scenenode, animbasename, animindex, 1, markerposition);

    if(!isDefined(crate)) {
      break;
    }

    crate.animindex = animindex;
    crate.animtoplay = level.scr_anim[crate.animname][crate.animindex];
    crate.var_79ac0ff6c36a088d = getanimlength(crate.animtoplay);
    crate.scenenode = scenenode;
    crates[crates.size] = crate;
  }

  return crates;
}

function function_d1443844f7590343(var_c5701227f7f0d907) {
  if(isDefined(self.heli)) {
    self.heli thread destroyheli();
  }

  if(isDefined(self.rope)) {
    self.rope delete();
  }

  if(istrue(var_c5701227f7f0d907)) {
    if(isDefined(self.crates)) {
      foreach(crate in self.crates) {
        if(isDefined(crate)) {
          crate thread destroycrate();
        }
      }
    }
  }

  self delete();
}

function function_8e3fa08965432cfa() {
  self endon("death");
  thread scripts\common\anim::anim_first_frame_solo(self.heli, self.heli.animindex);
  thread scripts\common\anim::anim_first_frame_solo(self.rope, self.rope.animindex);

  foreach(crate in self.crates) {
    thread scripts\common\anim::anim_first_frame_solo(crate, crate.animindex);
  }

  function_de1cce0b2d73d436();
}

function function_de1cce0b2d73d436() {
  self endon("death");
  animendtime = self.var_79ac0ff6c36a088d;
  thread scripts\common\anim::anim_single_solo(self.heli, self.heli.animindex);
  thread scripts\common\anim::anim_single_solo(self.rope, self.rope.animindex);

  foreach(crate in self.crates) {
    if(isDefined(crate)) {
      thread function_26877d0b1b30bd68(crate);
    }
  }

  wait animendtime;
  function_d1443844f7590343();
}

function function_26877d0b1b30bd68(crate) {
  self endon("death");
  crate endon("death");
  animendtime = randomfloatrange(crate.var_79ac0ff6c36a088d - 0.1, crate.var_79ac0ff6c36a088d + 0.1);
  crate setscriptablepartstate("visibility", "show", 0);
  thread scripts\common\anim::anim_single_solo(crate, crate.animindex);
  wait animendtime;
  docratedropfromscripted(crate);
}

function function_ad08ac92f283b91e(position) {
  var_7f9dadf5916fce9 = position * (1, 1, 0) + (0, 0, getscriptedhelidropheightbase());
  var_b7e56bad82bef358 = var_7f9dadf5916fce9 + (0, 0, -30000);
  var_b50cc6792fa30eff = scripts\cp_mp\killstreaks\airdrop::getcratedropdestination(var_7f9dadf5916fce9, var_b7e56bad82bef358, position);
  var_b50cc6792fa30eff += (0, 0, 1000);
  return var_b50cc6792fa30eff;
}

function airdrop_multiple_getcratedropcaststart(position) {
  position *= (1, 1, 0);
  position += (0, 0, getscriptedhelidropheightbase() + 200);
  position += (0, 0, level.cratedropdata.ac130s.size * 300);
  return position;
}

function airdrop_multiple_getdropheight() {
  assertex(isDefined(level.cratedropdata), "airdrop_multiple_getDropHeight() called before initCrateDropData().");
  return level.cratedropdata.ac130height + level.cratedropdata.ac130s.size * level.cratedropdata.ac130heightoffset;
}

function airdrop_multiple_addac130tolist(ac130) {
  assertex(isDefined(level.cratedropdata), "airdrop_multiple_addAC130DroppingCratesToList() called before initCrateDropData().");
  entnum = ac130 getentitynumber();
  level.cratedropdata.ac130s[entnum] = ac130;
}

function airdrop_multiple_removeac130fromlist(entnum) {
  level.cratedropdata.ac130s[entnum] = undefined;
}

function function_6624058bac19055d(streaklist) {
  animindex = "heli_multi_rope" + "_1";
  numcrates = streaklist.size;
  assertex(numcrates > 0 && numcrates <= 3, "<dev string:x1c>");

  if(numcrates == 2) {
    animindex = "heli_multi_rope" + "_2";
  } else if(numcrates == 3) {
    animindex = "heli_multi_rope" + "_3";
  }

  return animindex;
}

function function_e23eb6d57186432c(index, streaklist) {
  animindex = "heli_multi_crate" + "_1";
  numcrates = streaklist.size;
  assertex(numcrates > 0 && numcrates <= 3, "<dev string:x85>");

  if(numcrates == 2) {
    switch (index) {
      case 0:
        animindex = "heli_multi_crate" + "_2a";
        break;
      case 1:
        animindex = "heli_multi_crate" + "_2b";
        break;
    }
  } else if(numcrates == 3) {
    switch (index) {
      case 0:
        animindex = "heli_multi_crate" + "_3a";
        break;
      case 1:
        animindex = "heli_multi_crate" + "_3b";
        break;
      case 2:
        animindex = "heli_multi_crate" + "_3c";
        break;
    }
  }

  return animindex;
}