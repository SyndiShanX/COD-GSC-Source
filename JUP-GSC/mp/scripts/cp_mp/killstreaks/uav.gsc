/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\killstreaks\uav.gsc
************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\killstreaks\uav_bigmap;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace uav;

function init() {
  if(issharedfuncdefined("uav", "init")) {
    [[getsharedfunc("uav", "init")]]();
  }

  level thread function_83bbd4aad5a34b6b();
  level function_ac005e67449bfdf8();
  level function_d4fc9b64ffec9e4e();
  level thread onplayerconnect();
  level thread uav_tracker();

  setdevdvarifuninitialized(@ "hash_fe0a46289ab091e1", level.radarviewtime);
  setdevdvarifuninitialized(@ "hash_ac7f6a636682c52f", 0);
}

function function_83bbd4aad5a34b6b() {
  level endon("game_ended");
  flag_wait("onStartGameTypeFinished");

  if(isDefined(level.mapcenter)) {
    level.uavrotationorigin = level.mapcenter;
    return;
  }

  level.uavrotationorigin = (0, 0, 0);
}

function function_ac005e67449bfdf8() {
  level.uavworstid = getuavstrengthmin();
  level.uavbestid = getuavstrengthmax();
  level.uavdirectionalid = getuavstrengthlevelshowenemydirectional();
  level.uavnoneid = getuavstrengthlevelneutral();
  level.uavfastsweepid = getuavstrengthlevelshowenemyfastsweep();

  if(level.teambased) {
    for(i = 0; i < level.teamnamelist.size; i++) {
      level.radarmode[level.teamnamelist[i]] = "normal_radar";
      level.activeuavs[level.teamnamelist[i]] = 0;
      level.activecounteruavs[level.teamnamelist[i]] = 0;
      level.activeadvanceduavs[level.teamnamelist[i]] = 0;
      level.uavmodels[level.teamnamelist[i]] = [];

      if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
        level.var_48c4edf71e075321[level.teamnamelist[i]] = 0;
      }
    }
  } else {
    level.radarmode = [];
    level.activeuavs = [];
    level.activecounteruavs = [];
    level.activeadvanceduavs = [];
    level.uavmodels = [];

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      level.var_48c4edf71e075321 = [];
    }
  }

  level.uavrigs = [];
  level.totalactiveuavs = 0;
  level.totalactivecounteruavs = 0;
  level.activeadvanceduavcount = 0;
}

function function_d4fc9b64ffec9e4e() {
  game["dialog"]["uav_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["uav_use_friendly_br"] = "frns_grav_uav1";
  game["dialog"]["uav_use_enemy_br"] = "nmys_grav_uav1";
  game["dialog"]["uav_leave"] = "killstreak_remote_operator" + "_leave";
  game["dialog"]["uav_destroyed"] = "killstreak_remote_operator" + "_crash";
  game["dialog"]["directional_uav_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["directional_uav_leave"] = "killstreak_remote_operator" + "_leave";
}

function onplayerconnect() {
  var_f0d1eb8b608ecb81 = getuavstrengthlevelneutral();

  while(true) {
    level waittill("connected", player);
    level.activeuavs[player.guid] = 0;
    level.activeuavs[player.guid + "_radarStrength"] = var_f0d1eb8b608ecb81;
    level.activecounteruavs[player.guid] = 0;
    level.radarmode[player.guid] = "normal_radar";
    player.radarstrength = var_f0d1eb8b608ecb81;
  }
}

function onplayerspawned() {
  level notify("uav_update");
}

function function_3166f86d25686055() {
  level endon("uav_update");
  uav_throttle = throttle::function_af33edfaf05fc572("uav", getdvarint(@ "hash_533830ccd327d251", 16));

  foreach(entry in level.teamnamelist) {
    throttle::function_6f7b33660ae155ef(uav_throttle);
    uav_updateteamstatus(entry);
  }
}

function uav_tracker() {
  level endon("game_ended");

  while(true) {
    level waittill("uav_update");

    if(level.teambased) {
      level thread function_3166f86d25686055();
      continue;
    }

    function_f9caa46aa98b7c6b();
  }
}

function tryuseuav(streakname) {
  streakinfo = createstreakinfo(streakname, self);
  return tryuseuavfromstruct(streakinfo);
}

function tryuseuavfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(streakinfo.streakname == "uav" && isbrstylegametype() && getdvarint(@ "scr_uav_bigmap_enabled", 0)) {
    return scripts\cp_mp\killstreaks\uav_bigmap::function_e5931b9f76ed6cda(streakinfo);
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return 0;
    }
  }

  var_300a4922baa10548 = 0;

  if(level.teambased && isDefined(level.teamdata) && isDefined(level.teamdata[self.team]) && isDefined(level.teamdata[self.team]["activeSupplySweeps"])) {
    activesupplysweeps = level.teamdata[self.team]["activeSupplySweeps"].size;
    var_300a4922baa10548 = activesupplysweeps > 0;
  }

  if(var_300a4922baa10548) {
    useresult = "KILLSTREAKS/SUPPLY_SWEEP_IN_PROGRESS";

    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]](useresult);
    }

    return 0;
  }

  bundle = level.streakglobals.streakbundles["uav"];
  id = function_2336488258354fbc(#"scriptbundle_killstreak", bundle.var_19fb085453713468);
  self setclientomnvar("uav_radar_ping", id);
  subgametype = scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5();

  if(isDefined(bundle) && isDefined(bundle.deployweaponname)) {
    var_dd21567fdd9a3a6a = bundle.deployweaponname;
  } else if(subgametype == "vanilla" || subgametype == "mini_mgl") {
    var_dd21567fdd9a3a6a = "ks_gesture_generic_mp";
  } else {
    var_dd21567fdd9a3a6a = "ks_gesture_phone_mp";
  }

  var_32cd77f7f836e8e4 = 1;

  if(isDefined(streakinfo.var_32cd77f7f836e8e4)) {
    var_32cd77f7f836e8e4 = streakinfo.var_32cd77f7f836e8e4;
  }

  if(var_32cd77f7f836e8e4) {
    deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon(var_dd21567fdd9a3a6a));

    if(!istrue(deployresult)) {
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return 0;
    }
  }

  useresult = uav_use(streakinfo.streakname, streakinfo);

  if(useresult && streakinfo.streakname == "directional_uav" && isbrstylegametype()) {
    scripts\cp_mp\killstreaks\uav_bigmap::function_88ddbfdd01726127(self.team);
  }

  return istrue(useresult);
}

function uav_use(uavtype, streakinfo) {
  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]](uavtype, self.origin);
  }

  team = self.pers["team"];
  usetime = level.uavsettings[uavtype].timeout;
  var_da662696203dc431 = 0;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    var_da662696203dc431 = 1;
  }

  launchresult = uav_launch(self, uavtype, streakinfo, var_da662696203dc431);

  if(!istrue(launchresult)) {
    if(scripts\engine\utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\engine\utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    return false;
  }

  uaveventname = "uavUsed";
  bundle = level.streakglobals.streakbundles[uavtype];
  var_eaa4be49ac36f006 = istrue(bundle.var_8cfb8995372b9fea);
  self.var_7daf8331a040c860 = var_eaa4be49ac36f006;

  switch (uavtype) {
    case #"hash_e171e5b86ef0a4cc":
      self.radarshowenemydirection = 1;

      if(level.teambased) {
        foreach(player in level.players) {
          if(player.pers["team"] == team) {
            player.radarshowenemydirection = 1;
            player.var_7daf8331a040c860 = var_eaa4be49ac36f006;
          }
        }
      }

      uaveventname = "directionalUavUsed";
      break;
    case #"hash_10e585c25e7e9f60":
      uaveventname = "counterUavUsed";
    default:
      if(level.teambased) {
        radarstrength = function_5ec24d236512fd7a(team);
      }

      break;
  }

  if(issharedfuncdefined("player", "doOnActionScoreEvent")) {
    self[[getsharedfunc("player", "doOnActionScoreEvent")]](2, uaveventname);
  }

  return true;
}

function function_8e9a430c17ddcd55(uavtype) {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return false;
  }

  if(uavtype != "uav") {
    return false;
  }

  index = undefined;

  if(level.teambased) {
    index = self.team;
  } else {
    index = self.guid;
  }

  assert(isDefined(index));
  var_f19f07f386cd9119 = level.activeadvanceduavs[index];

  if(isDefined(var_f19f07f386cd9119) && var_f19f07f386cd9119 > 0) {
    return false;
  }

  var_a23be9fd896cb2ca = level.activeuavs[index];
  var_990d56bda9bcdf66 = function_933df49e9a291165(var_a23be9fd896cb2ca, 0, 0);
  directionalstrength = getuavstrengthlevelshowenemydirectional();
  return var_990d56bda9bcdf66 >= directionalstrength;
}

function uav_launch(owner, uavtype, streakinfo, var_da662696203dc431) {
  team = owner.team;
  launchorigin = level.uavrotationorigin;

  if(islargemap()) {
    if(level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "gwtdm") {
      if(isDefined(level.hqmidpoint)) {
        launchorigin = level.hqmidpoint;
      }
    } else {
      launchorigin = owner.origin;
    }
  }

  if(isDefined(streakinfo.overridetime)) {
    uavmodel = uav_create(launchorigin, owner, uavtype, streakinfo, var_da662696203dc431, streakinfo.overridetime);
  } else {
    uavmodel = uav_create(launchorigin, owner, uavtype, streakinfo, var_da662696203dc431);
  }

  if(!isDefined(uavmodel)) {
    return false;
  }

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    uavmodel[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_b9f0ee21053d4057);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    uavmodel[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_669abde8621d826e);
  }

  uavmodel thread function_fd8473db50408aa8();
  return true;
}

function uav_create(launchorigin, owner, uavtype, streakinfo, var_da662696203dc431, lifetimeoverride) {
  uavmodel = undefined;
  var_88d3d00bf003f331 = undefined;

  if(istrue(var_da662696203dc431)) {
    uavmodel = spawnStruct();
    uavmodel.damagetaken = 0;
  } else {
    uavmodel = spawn("script_model", launchorigin + (0, 0, 5000));
    var_88d3d00bf003f331 = uavmodel function_972967e0c0a0fa8(uavtype, launchorigin);

    if(!isDefined(var_88d3d00bf003f331)) {
      uavmodel delete();
      return undefined;
    }
  }

  if(getdvarint(@ "hash_da4afb1bdf19df26")) {
    uavmodel thread function_6467f4a6c5a005d4();
    uavmodel thread function_e6d0ffaec6506528();
  }

  model = level.uavsettings[uavtype].modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(owner) && isDefined(level.uavsettings[uavtype].modelbasealt)) {
    model = level.uavsettings[uavtype].modelbasealt;
  }

  maxhealth = level.uavsettings[uavtype].maxhealth;
  calloutsplash = level.uavsettings[uavtype].teamsplash;

  if(isent(uavmodel)) {
    uavmodel setModel(model);
  }

  uavmodel.team = owner.team;
  uavmodel.owner = owner;
  uavmodel.timetoadd = 0;
  uavmodel.uavtype = uavtype;
  uavmodel.health = level.uavsettings[uavtype].health;
  uavmodel.maxhealth = maxhealth;
  uavmodel.currenthealth = maxhealth;
  uavmodel.streakinfo = streakinfo;
  uavmodel thread function_c926982ff07fdea5();
  uavmodel thread function_d45f5cf5bfce96df();
  uavmodel thread function_e58c525d5d3a7482();
  uavmodel thread function_225e3594843d2ac(uavtype, lifetimeoverride, owner);

  if(isent(uavmodel)) {
    uavmodel setotherent(owner);
    uavmodel scriptmoveroutline();
    uavmodel scriptmoverthermal();

    if(issharedfuncdefined("uav", "attachXRays")) {
      uavmodel = [[getsharedfunc("uav", "attachXRays")]](uavmodel);
    }

    if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
      uavmodel[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](uavtype, "Killstreak_Air", owner);
    }

    uavmodel thread uav_watchdamage();
    uavmodel thread uav_handleincomingstinger();
    uavmodel thread uav_trackvelocity();
    bundle = level.streakglobals.streakbundles[uavmodel.uavtype];
    uavmodel thread scripts\cp_mp\utility\killstreak_utility::killstreak_registerminimapinfo(bundle, getxhash(uavmodel.uavtype));
    uavmodel setscriptablepartstate("lights", "on", 0);

    if(uavmodel.uavtype == "counter_uav") {
      uavmodel setscriptablepartstate("rotors", "on", 0);
    }

    range_min = default_to(bundle.var_a0dba1d8d8484cea, 6000);
    range_max = default_to(bundle.var_a0feabd8d86eaaa0, 6500);
    zoffset = randomintrange(range_min, range_max);

    if(uavmodel.uavtype == "counter_uav") {
      range_min = default_to(bundle.var_5aabe3dc355c0975, 2000);
      range_max = default_to(bundle.var_5acecddc358220cb, 2500);
      zoffset = randomintrange(range_min, range_max);
    } else if(uavmodel.uavtype == "directional_uav") {
      zoffset = randomintrange(30000, 31000);
    }

    if(issubstr(level.mapname, "mp_catedral")) {
      zoffset += 5000;
    }

    angle = randomint(360);
    range_min = default_to(bundle.var_fe6c5d5f5bb37316, 0);
    range_max = default_to(bundle.var_fe904f5f5bdbcf04, 1000);
    baseradiusoffset = randomintrange(range_min, range_max);

    if(uavmodel.uavtype == "counter_uav") {
      range_min = default_to(bundle.var_6261e0ab618b4ff5, 300);
      range_max = default_to(bundle.var_6284caab61b1674b, 550);
      baseradiusoffset = randomintrange(range_min, range_max);
    } else if(uavmodel.uavtype == "directional_uav") {
      baseradiusoffset = randomintrange(20000, 22000);
    }

    radiusoffset = baseradiusoffset + 4000;
    xoffset = cos(angle) * radiusoffset;
    yoffset = sin(angle) * radiusoffset;
    anglevector = vectorNormalize((xoffset, yoffset, zoffset));
    anglevector *= zoffset;
    isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();

    if(isbr) {
      var_d00af7864022039c = (0, 0, 3000);
      anglevector += var_d00af7864022039c;
    }

    uavmodel linkTo(var_88d3d00bf003f331, "tag_origin", anglevector, (0, angle - 90, 0));
    uavmodel thread function_48e2105afd534b62();
    uavmodel function_cfc5e3633ef950fd(1, uavmodel.maxhealth * 0.75, &function_1c832b851ca3a96a);
    uavmodel function_cfc5e3633ef950fd(2, uavmodel.maxhealth * 0.5, &function_4db3b85258da27bf);
    uavmodel function_cfc5e3633ef950fd(3, uavmodel.maxhealth * 0.25, &function_aece0522af7087ef);
  }

  uavmodel[[level.uavsettings[uavtype].addfunc]]();

  if(uavtype == "uav" || uavtype == "directional_uav") {
    uavmodel function_172c4412dde1696(1);
    uavmodel thread function_e9a20f47c6b49bd7();
  }

  if(isDefined(level.activeuavs[uavmodel.team]) && level.activeuavs[uavmodel.team] > 0) {
    if(isent(uavmodel)) {
      foreach(uav in level.uavmodels[uavmodel.team]) {
        if(uav == uavmodel) {
          continue;
        }

        if(isDefined(uav.timetoadd)) {
          uav.timetoadd += 5;
        }
      }
    } else {
      uavmodel.timetoadd = 5 * (level.activeuavs[uavmodel.team] - 1);
    }
  }

  vostreakname = streakinfo.streakname;

  if(owner function_8e9a430c17ddcd55(uavtype)) {
    vostreakname = "directional_uav";
    scripts\cp_mp\challenges::function_8359cadd253f9604(owner, "br_three_uav", 1);
  }

  var_52a5be2e2f91d710 = undefined;

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](owner, vostreakname);
    var_52a5be2e2f91d710 = 2;
  }

  isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();

  if(isbr) {
    killstreak_dangernotifyplayersinrange(owner, uavmodel.team, 15000, vostreakname);
  }

  owner thread playkillstreakoperatordialog(vostreakname, vostreakname + "_use", 1, var_52a5be2e2f91d710);

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[getsharedfunc("hud", "teamPlayerCardSplash")]](calloutsplash, owner);
  }

  level notify("uav_update");
  level notify("uav_started", owner, uavtype);
  return uavmodel;
}

function function_fd8473db50408aa8(worldspawned) {
  level endon("game_ended");
  uavtype = self.uavtype;
  uavowner = self.owner;
  uavteam = self.team;
  result = waittill_any_return_2("explode", "timeout");
  bundle = level.streakglobals.streakbundles[self.uavtype];

  if(isDefined(result) && result == "timeout") {
    if(isent(self)) {
      self unlink();
      exitdistance = default_to(bundle.var_d4db4bfbc99f31f6, 50000);
      self.destpoint = self.origin + anglesToForward(self.angles) * exitdistance;
      var_e811fd5fd6bf8823 = default_to(bundle.var_d4ed8cc7cbb67b7d, exitdistance / 50);
      var_1d80fd99cdd64eb4 = exitdistance / var_e811fd5fd6bf8823;
      self moveTo(self.destpoint, var_1d80fd99cdd64eb4);
    }

    if(isDefined(uavowner) && !istrue(level.gameended)) {
      uavowner playkillstreakoperatordialog(self.uavtype, self.uavtype + "_leave", 1);
    }

    exitdelay = default_to(bundle.var_7a74314e075c8cc6, 3);
    scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause("death", exitdelay);

    if(isDefined(self) && self.damagetaken < self.maxhealth) {
      self notify("leaving");
      self.isleaving = 1;

      if(isent(self)) {
        var_d9e9b47f09bf90bb = distance2d(self.destpoint, self.origin);
        var_aa2e3b2f5723b73c = default_to(bundle.var_3b51b0350f3922b2, var_d9e9b47f09bf90bb / 15);
        var_f088dfbe58063db9 = var_d9e9b47f09bf90bb / var_aa2e3b2f5723b73c;
        self moveTo(self.destpoint, var_f088dfbe58063db9);
      }

      var_35f4d8db65386407 = default_to(bundle.var_9c8bdfefbb219413, 4);
      scripts\cp_mp\hostmigration::hostmigration_waittillnotifyortimeoutpause("death", var_35f4d8db65386407 + self.timetoadd);

      if(isDefined(self) && self.damagetaken < self.maxhealth) {
        self.leftplayspace = 1;
      }
    }
  }

  if(isDefined(self)) {
    if(isDefined(uavowner)) {
      uavowner notify("uav_finished");
    }

    if(uavtype == "uav" || uavtype == "directional_uav") {
      function_172c4412dde1696(level.minimaponbydefault);
    }

    self[[level.uavsettings[uavtype].removefunc]]();

    if(!istrue(worldspawned)) {
      level callback::callback("killstreak_finish_use", {
        #streakinfo: self.streakinfo
      });
    }

    if(isDefined(self.enemyobjid)) {
      if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
        [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](self.enemyobjid);
      }

      self notify("uav_deleteObjective");
    }

    self.streakinfo.expiredbydeath = !istrue(self.leftplayspace);

    if(!istrue(self.recordedgameendstats) && isDefined(uavowner)) {
      uavowner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
    }

    if(isent(self)) {
      thread function_e2fce5a833321770();
    } else {
      self notify("death");
    }
  }

  if(uavtype == "directional_uav") {
    if(isDefined(uavowner) && !(uavowner player_hasperk("specialty_overwatch") || uavowner player_hasperk("specialty_pc_comms"))) {
      uavowner.radarshowenemydirection = 0;
    }

    if(level.teambased) {
      foreach(player in level.players) {
        if(isDefined(player) && player.pers["team"] == uavteam && !(player player_hasperk("specialty_overwatch") || player player_hasperk("specialty_pc_comms"))) {
          player.radarshowenemydirection = 0;
        }
      }
    }
  }

  if(issharedfuncdefined("player", "printGameAction")) {
    [[getsharedfunc("player", "printGameAction")]]("killstreak ended - " + uavtype, uavowner);
  }

  level notify("uav_update");

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    level notify("uav_finished", uavowner);
  }
}

function function_e2fce5a833321770() {
  level endon("game_ended");
  wait 1;

  if(isDefined(self)) {
    self delete();
  }
}

function function_c926982ff07fdea5() {
  self endon("death");
  self endon("explode");

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && isDefined(self.uavtype) && self.uavtype != "directional_uav") {
    self.owner waittill_any_2("death_or_disconnect", "joined_team");
  } else {
    self.owner waittill_any_2("disconnect", "joined_team");
  }

  if(isent(self)) {
    self setscriptablepartstate("explode", "on", 0);
    self.damagetaken = self.maxhealth;
  }

  self notify("explode");
}

function function_d45f5cf5bfce96df() {
  self endon("death");
  self endon("explode");

  while(true) {
    level waittill("host_migration_end");

    if(level.teambased) {
      foreach(entry in level.teamnamelist) {
        currentradar = function_5ec24d236512fd7a(entry);
        function_484d86ce003c2526(entry, currentradar);
      }
    }
  }
}

function function_48e2105afd534b62() {
  self endon("death");
  self endon("explode");

  while(true) {
    level waittill_either("joined_team", "uav_update");

    if(getdvarint(@ "hash_ac7f6a636682c52f", 0) == 1) {
      self show();
      continue;
    }

    self hide();

    foreach(player in level.players) {
      if(level.teambased) {
        if(player.team != self.team) {
          self showtoplayer(player);
        }

        continue;
      }

      if(isDefined(self.owner) && player == self.owner) {
        continue;
      }

      self showtoplayer(player);
    }
  }
}

function uav_watchdamage() {
  self endon("death");
  self endon("explode");
  level endon("game_ended");
  self setCanDamage(1);
  self.damagetaken = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    debugdamage = undefined;

    debugdamage = istrue(self.debugdamage);

    if(issharedfuncdefined("weapons", "mapWeapon")) {
      objweapon = [[getsharedfunc("weapons", "mapWeapon")]](objweapon, inflictor);
    }

    if(!isPlayer(attacker)) {
      if(!isDefined(self)) {
        return;
      }

      continue;
    }

    if(self.uavtype == "directional_uav" && (meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET")) {
      continue;
    }

    if(isDefined(idflags) && idflags & 8) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    if(isDefined(idflags) && idflags & 256) {
      self.wasdamagedfrombulletricochet = 1;
    }

    self.wasdamaged = 1;
    modifieddamage = damage;

    if(isPlayer(attacker)) {
      if(issharedfuncdefined("damage", "updateDamageFeedback")) {
        attacker[[getsharedfunc("damage", "updateDamageFeedback")]]("hitequip");
      }
    }

    divisorlrg = 1;
    divisormed = 1;
    divisorlow = 1;
    divisormelee = 0;
    divisortick = 3;

    if(self.uavtype == "counter_uav") {
      divisorlrg = 1;
      divisormed = 2;
      divisorlow = 3;
      divisormelee = 0;
      divisortick = 0;
    } else if(self.uavtype == "directional_uav") {
      divisorlrg = 5;
      divisormed = 6;
      divisorlow = 7;
      divisormelee = 0;
      divisortick = 0;
    }

    if(isDefined(objweapon)) {
      if(istrue(debugdamage)) {
        modifieddamage = damage;
      } else if(istrue(level.var_be6a42242be00b66) && issharedfuncdefined("killstreak", "getModifiedDamageUsingDamageTuning")) {
        bundle = level.streakglobals.streakbundles[self.uavtype];
        modifieddamage = self[[getsharedfunc("killstreak", "getModifiedDamageUsingDamageTuning")]](attacker, objweapon, meansofdeath, modifieddamage, self.maxhealth, bundle.var_e913079a5ffda56d);
      } else if(issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
        modifieddamage = self[[getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, meansofdeath, modifieddamage, self.maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, divisortick);
      }

      if(issharedfuncdefined("killstreak", "killstreakHit")) {
        [[getsharedfunc("killstreak", "killstreakHit")]](attacker, objweapon, self, meansofdeath, modifieddamage);
      }

      if(issharedfuncdefined("damage", "logAttackerKillstreak")) {
        self[[getsharedfunc("damage", "logAttackerKillstreak")]](self, damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, getcompleteweaponname(objweapon));
      }
    }

    self.damagetaken += modifieddamage;

    if(isDefined(self) && getdvarint(@ "g_debugdamage")) {
      println("<dev string:x1c>" + self getentitynumber() + "<dev string:x24>" + self.health - self.damagetaken + "<dev string:x30>" + attacker.clientid + "<dev string:x3e>" + isPlayer(attacker) + "<dev string:x57>" + modifieddamage + "<dev string:x63>" + distance(attacker.origin, self.origin));
    }

    self.currenthealth -= modifieddamage;
    killstreak_updatedamagestate(self.currenthealth);

    if(self.damagetaken >= self.maxhealth) {
      if(isPlayer(attacker) && (!isDefined(self.owner) || attacker != self.owner)) {
        var_75b67453a730bb0d = level.uavsettings[self.uavtype].calloutdestroyed;
        var_f444e68339293717 = "destroyed_" + self.uavtype;

        if(self.uavtype == "uav") {
          var_f444e68339293717 = undefined;
          self.owner playkillstreakoperatordialog(self.uavtype, self.uavtype + "_destroyed", 1);
        }

        if(issharedfuncdefined("damage", "onKillstreakKilled")) {
          self[[getsharedfunc("damage", "onKillstreakKilled")]](self.uavtype, attacker, objweapon, meansofdeath, damage, "destroyed_" + self.uavtype, var_f444e68339293717, var_75b67453a730bb0d, 1);
        }

        if(isDefined(self.uavremotemarkedby) && self.uavremotemarkedby != attacker) {
          if(issharedfuncdefined("uav", "remoteUAV_processTaggedAssist")) {
            self.uavremotemarkedby thread[[getsharedfunc("uav", "remoteUAV_processTaggedAssist")]]();
          }
        }
      }

      self setscriptablepartstate("explode", "on", 0);
      self notify("explode");
      return;
    }
  }
}

function uav_destroy() {
  var_75b67453a730bb0d = level.uavsettings[self.uavtype].calloutdestroyed;
  var_f444e68339293717 = "destroyed_" + self.uavtype;

  if(self.uavtype == "uav") {
    var_f444e68339293717 = undefined;
    self.owner playkillstreakoperatordialog(self.uavtype, self.uavtype + "_destroyed", 1);
  }

  self setscriptablepartstate("explode", "on", 0);
  self notify("explode");
}

function function_1c832b851ca3a96a() {
  self setscriptablepartstate("body_damage_light", "on");
}

function function_4db3b85258da27bf() {
  self setscriptablepartstate("body_damage_medium", "on");
}

function function_aece0522af7087ef() {
  self setscriptablepartstate("body_damage_heavy", "on");
}

function function_709bafcc745fa088() {
  foreach(player in level.players) {
    if(isDefined(self.streakname) && (self.streakname == "directional_uav" || self.streakname == "counter_uav")) {
      return;
    }

    if(issharedfuncdefined("perk", "hasPerk")) {
      if(!player[[getsharedfunc("perk", "hasPerk")]]("specialty_expanded_minimap")) {
        continue;
      }
    }

    if(player.team == self.team) {
      continue;
    }

    thread function_dc407442aceae01e(player);
  }
}

function function_dc407442aceae01e(enemyaffected) {
  level endon("game_ended");
  enemyaffected endon("disconnect");
  triggeroneoffradarsweep(enemyaffected);
  self waittill("death");
  triggeroneoffradarsweep(enemyaffected);
}

function function_5ec24d236512fd7a(team) {
  forcedradar = getdvarint(@ "scr_game_forceuav", 0);

  if(forcedradar) {
    return forcedradar;
  }

  activeuavs = level.activeuavs[team];
  var_6f923ce59f2dba50 = level.activeadvanceduavs[team];
  activecounteruavs = level.totalactivecounteruavs - level.activecounteruavs[team];
  return function_933df49e9a291165(activeuavs, var_6f923ce59f2dba50, activecounteruavs);
}

function function_933df49e9a291165(activeuavs, var_6f923ce59f2dba50, activecounteruavs) {
  uavowner = undefined;

  foreach(player in level.players) {
    if(isDefined(player)) {
      uavowner = player;
      break;
    }
  }

  if(isDefined(uavowner) && istrue(uavowner.var_f39d717b31ec5af9)) {
    activecounteruavs = 1;
  }

  strengthmin = getuavstrengthmin();
  strengthmax = getuavstrengthmax();

  if(var_6f923ce59f2dba50) {
    activeuavs = strengthmax - getuavstrengthlevelneutral();
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73() && activecounteruavs > 0) {
      radarstrength = strengthmin;
    } else {
      radarstrength = int(clamp(activeuavs + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemydirectional()));
    }
  } else if(activecounteruavs > 0) {
    radarstrength = strengthmin;
  } else if(var_6f923ce59f2dba50 > 0) {
    radarstrength = strengthmax;
  } else {
    radarstrength = int(clamp(activeuavs + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemyfastsweep()));
  }

  radarstrength = int(clamp(radarstrength, strengthmin, strengthmax));
  return radarstrength;
}

function function_484d86ce003c2526(team, override) {
  uav_updateteamstatus(team, override);
}

function function_8abf717874ce81d4(radarstrength, var_70d48b6b51ff2964) {
  isradarblocked = radarstrength == level.uavworstid;
  hasradar = !isradarblocked;
  radarshowenemydirection = radarstrength >= level.uavdirectionalid;
  showconstant = radarstrength >= level.uavbestid || radarshowenemydirection || radarstrength == 1;

  if(radarstrength == level.uavnoneid) {
    radarmode = "normal_radar";
    hasradar = 0;
  } else if(showconstant) {
    radarmode = "constant_radar";
  } else if(radarstrength == level.uavfastsweepid || var_70d48b6b51ff2964 && getdvarint(@ "hash_61964e46cab20802", 1) == 1) {
    radarmode = "fast_radar";
  } else {
    radarmode = "normal_radar";
  }

  radardata = {
    #var_70d48b6b51ff2964: var_70d48b6b51ff2964, #radarmode: radarmode, #radarshowenemydirection: radarshowenemydirection, #hasradar: hasradar, #isradarblocked: isradarblocked, #radarstrength: radarstrength
  };
  return radardata;
}

function function_ddcbf96c5ef69597(team, override) {
  if(isDefined(override)) {
    radarstrength = override;
  } else {
    radarstrength = function_5ec24d236512fd7a(team);
  }

  var_70d48b6b51ff2964 = scripts\cp_mp\utility\game_utility::isbrstylegametype() && level.var_48c4edf71e075321[team];
  radardata = function_8abf717874ce81d4(radarstrength, var_70d48b6b51ff2964);
  return radardata;
}

function function_13b8682b55619852(player, radardata) {
  if(player function_a237aba99cf26050() && getdvarint(@ "hash_c06ce4e11c644c9b", 0) == 1) {
    strengthmin = getuavstrengthmin();
    strengthmax = getuavstrengthmax();
    radarstrength = int(clamp(radardata.radarstrength + 1, strengthmin, strengthmax));
    radardata = function_8abf717874ce81d4(radarstrength, radardata.var_70d48b6b51ff2964);
  }

  player.radarstrength = radardata.radarstrength;
  player.isradarblocked = radardata.isradarblocked;
  player.hasradar = radardata.hasradar;
  player.radarshowenemydirection = radardata.radarshowenemydirection;
  player.radarmode = radardata.radarmode;
  player setclientomnvar("ui_radar_blocked", !istrue(player.hasradar));

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(radardata.var_70d48b6b51ff2964 || player player_hasperk("specialty_pc_comms")) {
      player.radarshowenemydirection = 1;
    }
  }

  if(player player_hasperk("specialty_overwatch")) {
    player.radarshowenemydirection = 1;
  }
}

function uav_updateteamstatus(team, override) {
  radardata = function_ddcbf96c5ef69597(team, override);
  players = level.players;

  if(issharedfuncdefined("game", "getTeamData")) {
    players = [[getsharedfunc("game", "getTeamData")]](team, "players");
  }

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    if(istrue(player.insidecuavbunker)) {
      continue;
    }

    if(istrue(player.skipuavupdate)) {
      continue;
    }

    if(istrue(player.var_8fee5ee1de16c41f)) {
      continue;
    }

    function_13b8682b55619852(player, radardata);
  }
}

function function_1cd3cd7ad2b1a683(team, override) {
  teamplayers = level.players;

  if(issharedfuncdefined("game", "getTeamData")) {
    teamplayers = [[getsharedfunc("game", "getTeamData")]](team, "players");
  }

  foreach(player in teamplayers) {
    player.hasradar = 0;
    player setclientomnvar("ui_radar_blocked", 1);
  }
}

function function_96d4526d5886ee74(team, override) {
  teamplayers = level.players;

  if(issharedfuncdefined("game", "getTeamData")) {
    teamplayers = [[getsharedfunc("game", "getTeamData")]](team, "players");
  }

  foreach(player in teamplayers) {
    player.hasradar = 1;
    player setclientomnvar("ui_radar_blocked", 0);
  }
}

function function_b9f0ee21053d4057(data) {
  thread uav_destroy();
}

function function_669abde8621d826e(data) {}

function function_f9caa46aa98b7c6b() {
  foreach(player in level.players) {
    if(istrue(player.insidecuavbunker)) {
      continue;
    }

    radarstrength = level.activeuavs[player.guid + "_radarStrength"];
    var_9983d3aba5d16152 = level.totalactivecounteruavs - level.activecounteruavs[player.guid];

    if(istrue(player.var_f39d717b31ec5af9)) {
      var_9983d3aba5d16152 = 1;
    }

    if(var_9983d3aba5d16152 > 0) {
      radarstrength = level.uavworstid;
    }

    radarstrength = int(max(min(radarstrength, level.uavbestid), level.uavworstid));
    player.radarstrength = radarstrength;
    teamhidden = player.team == "spectator" || player.team == "codcaster" || player.team == "free";

    if(radarstrength <= level.uavnoneid || teamhidden) {
      player.hasradar = 0;
      player.radarshowenemydirection = 0;
      player setclientomnvar("ui_radar_blocked", !istrue(player.hasradar));

      if(isDefined(player.radarmode) && player.radarmode == "constant_radar" && player.radarstrength != 1) {
        player.radarmode = "normal_radar";
      }

      continue;
    }

    if(radarstrength >= level.uavfastsweepid) {
      player.radarmode = "fast_radar";
    } else if(radarstrength == 1) {
      player.radarmode = "constant_radar";
    } else {
      player.radarmode = "normal_radar";
    }

    player.radarshowenemydirection = radarstrength >= level.uavdirectionalid;

    if(istrue(player.radarshowenemydirection)) {
      player.radarmode = "constant_radar";
    }

    player.hasradar = 1;
    player setclientomnvar("ui_radar_blocked", !istrue(player.hasradar));

    if(player player_hasperk("specialty_overwatch") || player player_hasperk("specialty_pc_comms")) {
      player.radarshowenemydirection = 1;
    }
  }
}

function uav_handleincomingstinger() {
  level endon("game_ended");
  self endon("death");
  self endon("explode");

  while(true) {
    level waittill("stinger_fired", player, missile, locktarget);

    if(!isDefined(locktarget) || locktarget != self) {
      continue;
    }

    missile thread function_247294e52128e3e7(locktarget, player);
  }
}

function uav_trackvelocity() {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self.velocity = (0, 0, 0);

  while(true) {
    self.lastorigin = self.origin;
    wait 0.05;
    self.velocity = (self.origin - self.lastorigin) / 0.05;
  }
}

function function_e58c525d5d3a7482() {
  self endon("death");
  self endon("explode");
  self.owner endon("uav_finished");
  level waittill("game_ended");
  self.recordedgameendstats = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
}

function function_225e3594843d2ac(uavtype, lifetimeoverride, owner) {
  duration = level.uavsettings[uavtype].timeout;

  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    duration = 9999;
  }

  if(isDefined(lifetimeoverride)) {
    duration = lifetimeoverride;
  } else if(isDefined(owner) && owner namespace_53fc9ddbb516e6e1::hasperksharedfunc("specialty_uav_buff")) {
    duration *= ter_op(isDefined(level.var_1408c77a4f773854), level.var_1408c77a4f773854, 1);
  }

  self endon("death");
  self endon("explode");
  wait duration;
  self notify("timeout");
}

function function_247294e52128e3e7(targetent, player) {
  self endon("death");
  mindist = distance(self.origin, targetent getpointinbounds(0, 0, 0));
  lastcenter = targetent getpointinbounds(0, 0, 0);

  while(true) {
    if(!isDefined(targetent)) {
      center = lastcenter;
    } else {
      center = targetent getpointinbounds(0, 0, 0);
    }

    lastcenter = center;
    curdist = distance(self.origin, center);

    if(curdist < mindist) {
      mindist = curdist;
    }

    if(curdist > mindist) {
      if(curdist > 1536) {
        return;
      }

      radiusdamage(self.origin, 1536, 600, 600, player, "MOD_EXPLOSIVE", "iw9_la_gromeo_mp");
      self hide();
      self notify("deleted");
      waitframe();
      self delete();
      player notify("killstreak_destroyed");
    }

    waitframe();
  }
}

function uav_addactiveuav() {
  level.totalactiveuavs++;

  if(level.teambased) {
    level.activeuavs[self.team]++;

    if(function_456cd43a5602eaab()) {
      level.var_48c4edf71e075321[self.team]++;
      self.var_90a35439909226ce = 1;
    }

    if(self.uavtype == "directional_uav") {
      level.activeadvanceduavs[self.team]++;
      level.activeadvanceduavcount++;
    }

    return;
  }

  level.activeuavs[self.owner.guid]++;
  level.activeuavs[self.owner.guid + "_radarStrength"]++;

  if(function_456cd43a5602eaab()) {
    level.var_48c4edf71e075321[self.owner.guid] = default_to(level.var_48c4edf71e075321[self.owner.guid], 0) + 1;
    self.var_90a35439909226ce = 1;
  }

  if(self.uavtype == "directional_uav") {
    level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] + 2;

    if(!isDefined(level.activeadvanceduavs[self.owner.guid])) {
      level.activeadvanceduavs[self.owner.guid] = 0;
    }

    level.activeadvanceduavs[self.owner.guid]++;
    level.activeadvanceduavcount++;
  }
}

function uav_addactivecounteruav() {
  if(level.teambased) {
    if(!isDefined(level.activecounteruavs[self.team])) {
      level.activecounteruavs[self.team] = 0;
    }

    level.activecounteruavs[self.team]++;
  } else {
    if(!isDefined(level.activecounteruavs[self.owner.guid])) {
      level.activecounteruavs[self.owner.guid] = 0;
    }

    level.activecounteruavs[self.owner.guid]++;
  }

  level.totalactivecounteruavs++;
}

function uav_removeactiveuav() {
  if(level.teambased) {
    level.activeuavs[self.team]--;
    level.totalactiveuavs--;

    if(istrue(self.var_90a35439909226ce)) {
      level.var_48c4edf71e075321[self.team]--;
    }

    if(self.uavtype == "directional_uav") {
      level.activeadvanceduavs[self.team]--;
      level.activeadvanceduavcount--;
    }

    return;
  }

  if(isDefined(self.owner)) {
    level.activeuavs[self.owner.guid]--;
    level.totalactiveuavs--;
    level.activeuavs[self.owner.guid + "_radarStrength"]--;

    if(istrue(self.var_90a35439909226ce)) {
      level.var_48c4edf71e075321[self.owner.guid]--;
    }

    if(self.uavtype == "directional_uav") {
      level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] - 2;
      level.activeadvanceduavs[self.owner.guid]--;
      level.activeadvanceduavcount--;
    }
  }
}

function uav_removeactivecounteruav() {
  if(level.teambased) {
    level.activecounteruavs[self.team]--;
  } else if(isDefined(self.owner)) {
    level.activecounteruavs[self.owner.guid]--;
  }

  level.totalactivecounteruavs--;
}

function function_456cd43a5602eaab() {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && isDefined(self.owner) && isPlayer(self.owner)) {
    if(issharedfuncdefined("perk", "hasPerk")) {
      if(self.owner[[getsharedfunc("perk", "hasPerk")]]("specialty_overwatch")) {
        return true;
      }
    }
  }

  return false;
}

function function_972967e0c0a0fa8(uavtype, launchorigin) {
  uavrig = undefined;

  if(!islargemap()) {
    foreach(rig in level.uavrigs) {
      if(uavtype == rig.uavtype) {
        uavrig = rig;
        break;
      }
    }
  } else if(isDefined(level.uavrigs) && level.uavrigs.size >= 30) {
    return undefined;
  }

  if(!isDefined(uavrig)) {
    uavrig = spawn("script_model", launchorigin);
    uavrig setModel("tag_origin");
    uavrig.angles = (0, 115, 0);
    uavrig.uavtype = uavtype;
    uavrig hide();
    bundle = level.streakglobals.streakbundles[uavtype];
    rotatetime = default_to(bundle.var_d61b6a0bbde40dce, 70);

    switch (uavtype) {
      case #"hash_10e585c25e7e9f60":
        rotatetime = default_to(bundle.var_903eeb7b9aee843b, 125);
        break;
      case #"hash_e171e5b86ef0a4cc":
        rotatetime = 200;
        break;
      case #"hash_7038dec66d8275be":
        break;
    }

    level.uavrigs[level.uavrigs.size] = uavrig;
    uavrig thread uav_rotaterig(rotatetime);

    if(islargemap()) {
      uavrig thread function_f30469aca36707f(self);
    } else {
      uavrig thread function_6d00913d6f8c862e();
    }
  }

  return uavrig;
}

function uav_rotaterig(rotatetime) {
  self endon("death");

  while(true) {
    self rotateYaw(-360, rotatetime);
    wait rotatetime;
  }
}

function function_f30469aca36707f(ent) {
  self endon("death");
  ent waittill_any_3("leaving", "explode", "death");
  level.uavrigs = array_remove(level.uavrigs, self);
  self delete();
}

function function_6d00913d6f8c862e() {
  self endon("death");
  level waittill("game_ended");
  level.uavrigs = array_remove(level.uavrigs, self);
  self delete();
}

function function_f54b6539dc6a4a1c() {
  self.owner endon("disconnect");
  self endon("uav_deleteObjective");
  self endon("death");

  switch (self.uavtype) {
    case #"hash_634b246c3da5c56f":
      enemyicon = "hud_icon_minimap_killstreak_uav";
      break;
    case #"hash_10e585c25e7e9f60":
      enemyicon = "hud_icon_minimap_killstreak_cuav";
      break;
    case #"hash_e171e5b86ef0a4cc":
      enemyicon = "hud_icon_minimap_killstreak_auav";
      break;
    default:
      enemyicon = "hud_icon_minimap_killstreak_uav";
      break;
  }

  createfunc = undefined;

  if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
    createfunc = scripts\engine\utility::getsharedfunc("game", "createObjectiveEngineer");
  }

  if(isDefined(createfunc)) {
    self.enemyobjid = self[[createfunc]](enemyicon, 1, 1);
  }

  var_67c48e4d4e56afec = 0;

  while(true) {
    playercount = level.players.size;

    for(i = 0; i < 10; i++) {
      if(var_67c48e4d4e56afec >= level.players.size) {
        var_67c48e4d4e56afec = 0;
      }

      player = level.players[var_67c48e4d4e56afec];
      var_67c48e4d4e56afec++;

      if(!isDefined(player)) {
        continue;
      }

      if(self.enemyobjid != -1) {
        if(issharedfuncdefined("perk", "hasPerk")) {
          if(player[[getsharedfunc("perk", "hasPerk")]]("specialty_engineer") && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner))) {
            scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.enemyobjid, player);
            continue;
          }

          scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.enemyobjid, player);
        }
      }
    }

    waitframe();
  }
}

function function_172c4412dde1696(reveal) {
  assertex(isDefined(reveal), "<dev string:x6e>");
  index = undefined;

  if(level.teambased) {
    index = self.team;
  } else {
    index = self.owner.guid;
  }

  foreach(player in level.players) {
    if(isai(player)) {
      continue;
    }

    if(level.teambased && self.team != player.team) {
      continue;
    }

    if(!level.teambased && self.owner != player) {
      continue;
    }

    if(!player _isalive()) {
      continue;
    }

    if(istrue(reveal)) {
      if(issharedfuncdefined("player", "showMiniMap")) {
        player[[getsharedfunc("player", "showMiniMap")]]();
      }

      continue;
    }

    if(issharedfuncdefined("player", "hideMiniMap")) {
      player[[getsharedfunc("player", "hideMiniMap")]]();
    }
  }
}

function function_e9a20f47c6b49bd7() {
  self.owner endon("disconnect");
  self endon("death");
  self endon("explode");
  level endon("game_ended");

  if(istrue(level.istacops)) {
    return;
  }

  while(true) {
    level waittill("player_spawned", player);

    if(isai(player)) {
      continue;
    }

    if(level.teambased && self.team != player.team) {
      continue;
    }

    if(!level.teambased && self.owner != player) {
      continue;
    }

    if(issharedfuncdefined("player", "showMiniMap")) {
      player[[getsharedfunc("player", "showMiniMap")]]();
    }

    player.showuavminimaponspawn = 1;
  }
}

function function_c11936b9c6c3a076(player, waittime) {
  if(isDefined(waittime)) {
    wait waittime;
  }

  forceradarstrength = getdvarint(@ "scr_game_forceuav");
  radartype = "normal_radar";
  activeuav = 1;
  activeadvanceduavs = 0;

  switch (forceradarstrength) {
    case 1:
      radartype = "constant_radar";
      break;
    case 3:
      radartype = "normal_radar";
      break;
    case 5:
      radartype = "fast_radar";
      activeuav = 2;
      break;
    case 6:
      radartype = "constant_radar";
      activeadvanceduavs = 1;
      break;
    default:
      break;
  }

  if(level.teambased) {
    foreach(entry in level.teamnamelist) {
      level.radarmode[entry] = radartype;
      level.activeuavs[entry] = activeuav;
      level.activeadvanceduavs[entry] = activeadvanceduavs;
      level.activeadvanceduavcount = level.teamnamelist.size;
      function_484d86ce003c2526(entry, forceradarstrength);
    }

    return;
  }

  activeuav = forceradarstrength;
  level.radarmode[player.guid] = radartype;
  player.radarstrength = activeuav;
  level.activeuavs[player.guid + "_radarStrength"] = activeuav;
  level.activeadvanceduavs[player.guid] = activeadvanceduavs;
  level.activeadvanceduavcount = level.teamnamelist.size;
  function_f9caa46aa98b7c6b();
}

function function_6394127938ed8257(sweeptime) {
  level endon("game_ended");

  while(true) {
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        triggeroneoffradarsweep(player);
      }
    }

    wait sweeptime;
  }
}

function function_6467f4a6c5a005d4() {
  self endon("<dev string:xa9>");

  while(true) {
    print3d(self.origin, "<dev string:xb2>", (1, 0, 0));
    print3d(self.origin, "<dev string:xb9>" + self.origin[0] + "<dev string:xc9>" + self.origin[1] + "<dev string:xc9>" + self.origin[2], (1, 0, 0));
    print3d(level.uavrig.origin, "<dev string:xcf>", (1, 0, 0));
    print3d(level.uavrig.origin, "<dev string:xda>" + level.uavrig.origin[0] + "<dev string:xc9>" + level.uavrig.origin[1] + "<dev string:xc9>" + level.uavrig.origin[2], (1, 0, 0));
    print3d(level.uavrig.origin - (0, 0, 50), "<dev string:xee>" + distance(level.uavrig.origin, self.origin), (1, 0, 0));
    line(level.uavrig.origin, self.origin, (0, 0, 1));
    anglesforward = anglesToForward(level.players[0].angles);
    scalar = (anglesforward[0] * 200, anglesforward[1] * 200, anglesforward[2]);
    print3d(level.players[0].origin + scalar, "<dev string:xee>" + distance(level.players[0].origin, self.origin), (1, 0, 0));
    waitframe();
  }
}

function function_e6d0ffaec6506528() {
  self endon("<dev string:xa9>");

  while(true) {
    result = scripts\engine\trace::_bullet_trace(level.players[0].origin, self.origin, 0, undefined);

    if(isDefined(result) && isDefined(result["<dev string:xfc>"])) {
      println("<dev string:x10b>" + result["<dev string:xfc>"]);
    }

    wait 1;
  }
}

# /