/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\killstreaks\airdrop_escort.gsc
***********************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\chopper_gunner;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\turret_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\sentientpoolmanager;
#namespace airdrop_escort;

function function_f383491974a17b9a() {
  assertex(isDefined(level.cratedropdata), "airdrop_escort_init() called before scriptscp_mpkillstreaksairdrop::initCrateDropData().");

  if(issharedfuncdefined("airdrop_escort", "init")) {
    [[getsharedfunc("airdrop_escort", "init")]]();
  }

  level function_e407a860bff9c632();
  level function_a852f44527c9d61f();
  level function_9302fd2bfe5c663c();
}

function function_e407a860bff9c632() {
  level.var_346499147c1f5c1f = 0;

  foreach(teamname in level.teamnamelist) {
    level.var_54eafc62b6ad04c8[teamname] = 0;
  }

  level.cratedropdata.escortchoppers = [];

  setdevdvarifuninitialized(@ "hash_f8c88d9bcfa63da3", 0);
  setdevdvarifuninitialized(@ "hash_e9159b47fbb642af", 0);
  setdevdvarifuninitialized(@ "hash_94edbe8b5c5b8dd0", 0);
  setdevdvarifuninitialized(@ "hash_4f4829715aa2fd22", "<dev string:x1c>");
}

function function_a852f44527c9d61f() {
  function_1f93185f55e71c3();
  function_29c55da256bfa6ba();
}

#using_animtree("script_model");

function function_1f93185f55e71c3() {
  level.scr_animtree["ks_airdrop_escort_crate"] = #animtree;
  level.scr_anim["ks_airdrop_escort_crate"]["crate_push_out_left"] = % iw9_mp_esc_airdrop_pack_l;
  level.scr_anim["ks_airdrop_escort_crate"]["crate_push_out_right"] = % iw9_mp_esc_airdrop_pack_r;
}

#using_animtree("mp_vehicles_always_loaded");

function function_29c55da256bfa6ba() {
  level.scr_animtree["ks_airdrop_escort_heli"] = #animtree;
  level.scr_anim["ks_airdrop_escort_heli"]["vehicle_doors_open"] = % iw9_mp_esc_airdrop_helidoors;
}

function function_9302fd2bfe5c663c() {
  game["dialog"]["airdrop_escort" + "_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["airdrop_escort" + "_leave"] = "killstreak_remote_operator" + "_leave";
  game["dialog"]["airdrop_escort" + "_destroyed"] = "killstreak_team_leader" + "_crash";
  game["dialog"]["airdrop_escort" + "_spotted_target"] = "killstreak_remote_operator" + "_target_spotted_single";
}

function function_e24bffeb9974833e() {
  streakinfo = createstreakinfo("airdrop_escort", self);
  return function_45378f51950e7d1f(streakinfo);
}

function function_45378f51950e7d1f(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return 0;
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return 0;
  }

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_phone_mp"));

  if(!istrue(deployresult)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  level.var_346499147c1f5c1f++;
  var_25f93ff4ca83eba9 = 1;

  if(islargemap()) {
    var_25f93ff4ca83eba9 = 2;
  }

  if(level.cratedropdata.escortchoppers.size >= var_25f93ff4ca83eba9 || level.cratedropdata.escortchoppers.size + level.incomingallchoppersupports > var_25f93ff4ca83eba9) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    level.var_346499147c1f5c1f--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return 0;
  }

  if(islargemap() && level.teambased) {
    var_abdb6af6e3ca3893 = 1;
    level.var_54eafc62b6ad04c8[self.team]++;

    if(getnumactivekillstreakperteam(self.team, level.cratedropdata.escortchoppers) + level.var_54eafc62b6ad04c8[self.team] > var_25f93ff4ca83eba9) {
      level.var_346499147c1f5c1f--;
      level.var_54eafc62b6ad04c8[self.team]--;

      if(issharedfuncdefined("hud", "showErrorMessage")) {
        [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_SUPPORT_HELO");
      }

      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  useresult = function_5867a72a727ced43(self, self.origin, "overwatch", streakinfo);
  level.var_346499147c1f5c1f--;

  if(islargemap() && level.teambased) {
    level.var_54eafc62b6ad04c8[self.team]--;
  }

  if(!istrue(useresult)) {
    return 0;
  }

  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]]("airdrop_escort", self.origin);
  }

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + "airdrop_escort", self);
  }

  var_52a5be2e2f91d710 = undefined;

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    var_52a5be2e2f91d710 = 2;
  }

  thread playkillstreakoperatordialog("airdrop_escort", "airdrop_escort" + "_use", 1, var_52a5be2e2f91d710);
  return useresult;
}

function function_5867a72a727ced43(owner, position, escorttype, streakinfo) {
  escortheli = function_e384066b8cc15be4(owner, owner.team, position, escorttype, streakinfo);

  if(!isDefined(escortheli)) {
    return false;
  }

  escortheli thread function_429ba1c88d63319c(escorttype);
  return true;
}

function function_e384066b8cc15be4(owner, team, position, escorttype, streakinfo) {
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  heightoffset = (0, 0, 1000);
  var_f3910d9d3efd6e9d = heightoffset + (0, 0, 1000);
  approachangles = owner.angles + (0, 180, 0);
  pathgoal = position + var_f3910d9d3efd6e9d;
  pathstart = pathgoal - anglesToForward(approachangles) * 15000;

  if(!islargemap() && isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_8013278937ff2600 = randomint(level.heli_structs_entrances.size);
    entrancestruct = level.heli_structs_entrances[var_8013278937ff2600];

    if(issharedfuncdefined("chopper_gunner", "findTargetStruct")) {
      goalstruct = [[getsharedfunc("chopper_gunner", "findTargetStruct")]](entrancestruct.script_linkto, level.heli_structs_goals);

      if(isDefined(goalstruct)) {
        var_f3910d9d3efd6e9d = (0, 0, goalstruct.origin[2] + 1000);
        var_a168db747b0d79ac = entrancestruct.origin * (1, 1, 0) + var_f3910d9d3efd6e9d;
        var_c32e33b4d51be12f = goalstruct.origin * (1, 1, 0) + var_f3910d9d3efd6e9d;
        entranceforward = vectorNormalize(var_c32e33b4d51be12f - var_a168db747b0d79ac);
        pathstart = var_a168db747b0d79ac;
        pathgoal = var_c32e33b4d51be12f + entranceforward * 1000;
        approachangles = vectortoangles(entranceforward);
      } else {
        owner iprintlnbold("<dev string:x26>" + entrancestruct.script_linkto + "<dev string:x36>");
      }
    }
  }

  escortheli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, pathstart, approachangles, "veh_airdrop_escort_mp_phys", "veh9_mil_air_heli_hind_mp");

  if(!isDefined(escortheli)) {
    return undefined;
  }

  if(!isDefined(team)) {
    team = "neutral";
  }

  if(team != "neutral") {
    escortheli setvehicleteam(team);
  }

  modifiedlifetime = 60;

  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    modifiedlifetime = 9999;
  }

  escortheli.speed = 100;
  escortheli.accel = 50;
  escortheli.lifetime = modifiedlifetime;
  escortheli.health = 2000;
  escortheli.maxhealth = 2000;
  escortheli.currenthealth = 2000;
  escortheli.team = team;
  escortheli.owner = owner;
  escortheli.streakinfo = streakinfo;
  escortheli.streakname = streakinfo.streakname;
  escortheli.flaresreservecount = 1;
  escortheli.pathstart = pathstart;
  escortheli.pathgoal = pathgoal;
  escortheli.currentaction = undefined;
  escortheli.patrolradius = 1000;
  escortheli.heightoffset = heightoffset;
  escortheli.entranceheightoffset = var_f3910d9d3efd6e9d;
  escortheli.droplocation = position;
  escortheli.escorttype = escorttype;
  escortheli.animname = "ks_airdrop_escort_heli";
  escortheli function_923b24178e709fbb(streakinfo.streakname);
  escortheli setmaxpitchroll(15, 15);
  escortheli vehicle_setspeed(escortheli.speed, escortheli.accel);
  escortheli sethoverparams(50, 5, 2.5);
  escortheli setturningability(1);
  escortheli setyawspeed(50, 25, 25, 0.5);
  escortheli setotherent(owner);
  escortheli setCanDamage(1);
  escortheli setneargoalnotifydist(1000);
  escortheli function_247ad6a91f6a4ffe(1);
  level thread function_ee93617532d8a679(escortheli, owner, &function_c91a4a524a2d461d);

  if(issharedfuncdefined("airdrop_escort", "attachXRays")) {
    escortheli = [[getsharedfunc("airdrop_escort", "attachXRays")]](escortheli);
  }

  escortheli scripts\cp_mp\emp_debuff::set_start_emp_callback(&function_5555ccc5b8ca52d3);
  escortheli scripts\cp_mp\emp_debuff::set_clear_emp_callback(&function_8fc896d80a52b782);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    escortheli[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_3439dfab92e219d1);
  }

  escortheli setscriptablepartstate("blinking_lights", "on", 0);
  escortheli setscriptablepartstate("engine", "on", 0);

  escortheli thread scripts\cp_mp\killstreaks\chopper_gunner::function_dc4cb73de48ec3d6();

  escortheli.turret = spawnturret("misc_turret", escortheli gettagorigin("tag_turret"), "airdrop_escort_turret_ballistics_mp");
  escortheli.turret setModel("veh9_mil_air_heli_hind_turret_mp");
  escortheli.turret.owner = escortheli.owner;
  escortheli.turret.team = escortheli.team;
  escortheli.turret.angles = escortheli.angles;
  escortheli.turret.streakinfo = escortheli.streakinfo;
  escortheli.turret.disabled = 0;
  escortheli.turret.targetstate = undefined;
  escortheli.turret linkTo(escortheli, "tag_turret");
  escortheli.turret setturretteam(escortheli.team);
  escortheli.turret setturretmodechangewait(0);
  escortheli.turret setmode("manual");
  escortheli.turret setotherent(escortheli.owner);
  escortheli.turret setdefaultdroppitch(45);
  groundtargetorigin = escortheli.origin - (0, 0, 100) + anglesToForward(escortheli.angles) * 500;
  escortheli.turret.groundtargetent = spawn("script_model", groundtargetorigin);
  escortheli.turret.groundtargetent setModel("tag_origin");
  escortheli.turret.groundtargetent linkTo(escortheli.turret);
  escortheli.turret.groundtargetent dontinterpolate();
  escortheli.turret settargetentity(escortheli.turret.groundtargetent);
  escortheli.killcament = spawn("script_model", escortheli.turret gettagorigin("bi_center"));
  escortheli.killcament linkTo(escortheli, "tag_origin", (-500, 0, 500), (0, 0, 0));
  escortheli.turret.killcament = escortheli.killcament;

  if(isDefined(owner)) {
    if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
      escortheli[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](escortheli.streakname, "Killstreak_Air", owner, 0, 1, 100);
    }

    if(team != "neutral") {
      escortheli scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);
    }
  }

  level.cratedropdata.escortchoppers[level.cratedropdata.escortchoppers.size] = escortheli;
  return escortheli;
}

function function_923b24178e709fbb(streakname) {
  killstreakvehicle = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = "airdrop_escort" + "_destroyed";
  destroyedsplash = "callout_destroyed_" + streakname;
  var_8dfc256103cce53e = &function_a4b7038df66c4b58;
  var_191284e2e2837328 = &function_350eb9923f9e2a74;
  premoddamagecallback = &function_3e6225ef4efc799e;
  postmoddamagecallback = &function_e687e809e9570d59;
  deathcallback = &function_1fe4e6fd1f673f2d;
  killstreak_setupvehicledamagefunctionality(streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  function_cfc5e3633ef950fd(1, 1500, &function_6e785f240ca1205e);
  function_cfc5e3633ef950fd(2, 1000, &function_71b13dc22e6c70cb);
  function_cfc5e3633ef950fd(3, 500, &function_a58186566a85e2db);
}

function function_a4b7038df66c4b58(streakname) {
  if(issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, 12);
  }
}

function function_350eb9923f9e2a74(streakname) {}

function function_3e6225ef4efc799e(data) {
  damage = data.damage;
  attacker = data.attacker;
  return true;
}

function function_e687e809e9570d59(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  self.currenthealth -= damage;
  killstreak_updatedamagestate(self.currenthealth);
  return true;
}

function function_6e785f240ca1205e() {
  self setscriptablepartstate("body_damage_light", "on");
}

function function_71b13dc22e6c70cb() {
  self setscriptablepartstate("body_damage_medium", "on");
}

function function_a58186566a85e2db() {
  self setscriptablepartstate("body_damage_heavy", "on");
}

function function_1fe4e6fd1f673f2d(data) {
  self.killedbyweapon = data.objweapon;
  thread function_46088aa13d962f89(self.killedbyweapon);
  return true;
}

function function_46088aa13d962f89(weaponkilledby) {
  self endon("explode");

  if(issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if(![[getsharedfunc("killstreak", "isKillstreakWeapon")]](weaponkilledby)) {
      function_51beb9374f4650ab(150, weaponkilledby);
    }
  }

  thread function_c91a4a524a2d461d();
}

function function_51beb9374f4650ab(speed, weaponkilledby, var_c5adb13be635c61a) {
  self endon("explode");
  self clearlookatent();
  self notify("crashing");
  playsoundatpos(self.origin, "exp_escort_helo");
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  var_6847739e80fb4e81 = scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_findcrashposition(2500);

  if(!isDefined(var_6847739e80fb4e81)) {
    return;
  }

  if(istrue(var_c5adb13be635c61a)) {
    sphere(var_6847739e80fb4e81, 100, (0, 1, 0), 0, 500);
    line(self.origin, var_6847739e80fb4e81, (0, 1, 0), 1, 0, 500);
  }

  self setvehgoalpos(var_6847739e80fb4e81, 0);
  thread scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_spinout(speed);
  function_5a9772411551e56e("airdrop_escort");
}

function function_962725f71407f96f(position) {
  return position;
}

function function_429ba1c88d63319c(escorttype) {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  thread function_35c660a3f2bc49e();
  thread function_7fc680f960d38005();
  self setvehgoalpos(self.pathgoal, 1);
  self waittill("near_goal");
  self vehicle_setspeed(int(self.speed / 4), int(self.accel / 4));
  self setneargoalnotifydist(300);
  thread function_acdc6c19714b6bb8();
  self waittill("goal");
  defaultaction = undefined;
  defaultactionfunc = undefined;

  if(escorttype == "crate") {
    self.defaultaction = "heli_patrol";
    self.defaultactionfunc = &function_6af592b35966f02a;
    thread function_ba7e24ee1aaf05e3();
    wait 1;
  } else {
    self.defaultaction = "heli_overwatch";
    self.defaultactionfunc = &function_365529b3985c87d4;
    thread function_365529b3985c87d4();
  }

  thread function_e46fb5b1144140e(self.turret);
}

function function_5555ccc5b8ca52d3() {
  self.turret.disabled = 1;
}

function function_8fc896d80a52b782() {
  self.turret.disabled = 0;
}

function function_3439dfab92e219d1(data) {
  if(isDefined(self)) {
    function_1fe4e6fd1f673f2d(data);
  }
}

function function_dbfa95f808879295(data, time) {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  self notify("airdrop_escort_droneGunHit");
  self endon("airdrop_escort_droneGunHit");
  self.turret notify("lost_target");
  function_5555ccc5b8ca52d3();
  self.var_69894ea4b6754d6f = 1;
  wait time;
  self.var_69894ea4b6754d6f = undefined;
  function_8fc896d80a52b782();
}

function function_acdc6c19714b6bb8() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  wait self.lifetime;
  thread function_94ca0444f2efd147();
}

function function_35c660a3f2bc49e() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread function_94ca0444f2efd147();
    return;
  }

  self.owner waittill_any_2("joined_team", "disconnect");
  thread function_94ca0444f2efd147();
}

function function_7fc680f960d38005() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  level waittill("game_ended");

  if(isDefined(self.owner)) {
    self.recordedgameendstats = 1;
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  thread function_94ca0444f2efd147();
}

function function_ba7e24ee1aaf05e3() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  self.owner endon("disconnect");
  dooranim = level.scr_anim["ks_airdrop_escort_heli"]["vehicle_doors_open"];
  var_6a5dc0fc2710ad84 = getanimlength(dooranim);
  thread scripts\common\anim::anim_single_solo(self, "vehicle_doors_open");
  wait var_6a5dc0fc2710ad84;
  streaknames = [];
  numcrates = 2;
  crateindex = 0;
  crateowner = self.owner;
  crateteam = self.team;
  cratetype = ter_op(isDefined(self.owner), "killstreak", "killstreak_no_owner");
  crateorigin = self gettagorigin("body_animate_jnt");
  var_90d4fe050e6864d4 = self.angles;
  cratedestination = self.droplocation;
  hasnophysics = 0;
  var_6244a1d5b282bb6c = 0;
  skipminimapicon = 0;
  scenenode = self;
  animbasename = "ks_airdrop_escort_crate";
  animname = "crate_push_out_left";

  for(i = 0; i < numcrates; i++) {
    streakname = undefined;

    if(streaknames.size > 0) {
      streakname = getrandomkillstreak(streaknames);
    } else {
      streakname = getrandomkillstreak();
    }

    cratedropdata = getkillstreakcratedatabystreakname(streakname, 0);

    if(crateindex >= 1) {
      animname = "crate_push_out_right";
      crateindex = 0;
    }

    crate = createcrate(crateowner, crateteam, cratetype, crateorigin, var_90d4fe050e6864d4, cratedestination, hasnophysics, var_6244a1d5b282bb6c, cratedropdata, skipminimapicon);
    crate.streakinfo = self.streakinfo;
    crate.animname = "ks_airdrop_escort_crate";
    crate scripts\common\anim::setanimtree();
    thread function_96e5dfe9c1aa7de0(crate, animname, "body_animate_jnt");
    streaknames[streaknames.size] = streakname;
    crateindex++;
    wait 0.5;
  }
}

function function_96e5dfe9c1aa7de0(crate, animname, animtag) {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  scripts\common\anim::anim_single_solo(crate, animname, animtag);
  crate stopanimScripted();
  crate cratephysicson();
}

function function_e44ce535d38f95a(startingpos, currenttarget) {
  return distance2dsquared(startingpos, currenttarget.origin) <= 25000000;
}

function function_ff7aba975a027d9b(startingpos, currenttarget) {
  return distance2dsquared(startingpos, currenttarget.origin) <= 16000000;
}

function function_6af592b35966f02a() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  self endon("heli_attack");
  level endon("game_ended");
  self notify("heli_patrol");
  self.currentaction = "heli_patrol";
  self clearlookatent();
  self setneargoalnotifydist(300);
  var_65af68838583c396 = 0;
  var_b9a46106a6a99ee8 = 0;

  while(true) {
    if(self.currentaction == "heli_attack") {
      waitframe();
      continue;
    }

    newgoal = self.pathgoal + anglesToForward((0, var_b9a46106a6a99ee8, 0)) * int(self.patrolradius / 1.2);

    level thread drawsphere(newgoal, 100, 5, (1, 1, 1));

    var_b9a46106a6a99ee8 += 90;
    function_112064acba6603c3(newgoal, 0);

    if(var_b9a46106a6a99ee8 >= 360) {
      var_b9a46106a6a99ee8 = 0;
    }

    wait 0.5;
  }
}

function function_365529b3985c87d4() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  self endon("heli_attack");
  level endon("game_ended");
  self notify("heli_overwatch");
  self.currentaction = "heli_overwatch";
  self clearlookatent();
  self setlookatent(self.owner);

  while(true) {
    function_112064acba6603c3(self.owner, 1);
    waitframe();
  }
}

function function_112064acba6603c3(target, forcestopatgoal) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  self notify("escort_moving");
  self endon("escort_moving");
  newpos = undefined;
  testtarget = target;

  if(!isvector(target)) {
    testtarget = target.origin;
  }

  ignorelist = [self, self.turret];

  while(true) {
    currentpos = self.origin;
    initialgoalpos = testtarget * (1, 1, 0) + (0, 0, self.origin[2]);
    obstructiontrace = sphere_trace(currentpos, initialgoalpos, 350, ignorelist);
    obstructed = 0;
    xpos = testtarget[0];
    ypos = testtarget[1];

    if(isDefined(obstructiontrace)) {
      if(obstructiontrace["hittype"] != "hittype_none") {
        xpos = obstructiontrace["position"][0];
        ypos = obstructiontrace["position"][1];
        obstructed = 1;
      }
    }

    properz = scripts\cp_mp\killstreaks\chopper_support::getcorrectheight(xpos, ypos, 20, 512);
    newpos = (xpos, ypos, properz);
    stopatgoal = 0;

    if(istrue(forcestopatgoal) && !istrue(obstructed)) {
      stopatgoal = forcestopatgoal;
    }

    self setvehgoalpos(newpos, stopatgoal);
    waittill_any_2("near_goal");

    if(!istrue(obstructed)) {
      break;
    }
  }
}

function function_94ca0444f2efd147() {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self clearlookatent();
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  playkillstreakoperatordialog("airdrop_escort", "airdrop_escort" + "_leave", 1);
  var_df6c75d1a1e4ff18 = 3;
  flightheightoffset = (0, 0, 1000);
  var_bb0e78a73b33d580 = self.origin + flightheightoffset;
  leavestart = undefined;
  leavegoal = undefined;
  var_ec0c66c48e6f8304 = undefined;

  while(var_df6c75d1a1e4ff18 > 0) {
    flightpath = function_999fe3838d6b6f8c(var_bb0e78a73b33d580, self.angles, 350, 25000);

    if(isDefined(flightpath.end)) {
      leavestart = flightpath.start;
      leavegoal = flightpath.end;
      var_ec0c66c48e6f8304 = flightpath.angles;
      break;
    }

    var_bb0e78a73b33d580 += (0, 0, 1000);
    var_df6c75d1a1e4ff18--;
    wait 0.05;
  }

  if(!isDefined(leavegoal)) {
    thread function_c91a4a524a2d461d();
    return;
  }

  turnspeed = 150;
  ascendspeed = 50;
  self setyawspeed(turnspeed, 50, 25, 0);
  self settargetyaw(var_ec0c66c48e6f8304[1]);
  self vehicle_setspeed(ascendspeed, 25);
  pathgoal = leavestart;
  self setvehgoalpos(pathgoal, 1);
  waittill_any_timeout_1(3, "goal");
  failsafetime = 0;

  while(failsafetime < 2) {
    currentyaw = (0, self.angles[1], 0);
    yawdiff = var_ec0c66c48e6f8304 - currentyaw;

    if(abs(yawdiff[1]) < 5) {
      break;
    }

    failsafetime += level.framedurationseconds;
    waitframe();
  }

  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(150, self.accel);
  self setvehgoalpos(leavegoal, 1);
  self setneargoalnotifydist(1000);
  waittill_any_timeout_1(10, "near_goal");
  thread function_334e82bd0e14dcf4(0);
}

function function_c91a4a524a2d461d() {
  if(istrue(self.isexploding)) {
    return;
  }

  self notify("explode");
  self.isexploding = 1;
  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  function_334e82bd0e14dcf4(1);
}

function function_334e82bd0e14dcf4(wasdestroyed) {
  if(istrue(self.var_bf178f6894d17b96)) {
    return;
  }

  self.var_bf178f6894d17b96 = 1;

  if(issharedfuncdefined("player", "printGameAction")) {
    [[getsharedfunc("player", "printGameAction")]]("killstreak ended - airdrop_escort", self.owner);
  }

  self.streakinfo.expiredbydeath = istrue(wasdestroyed);

  if(!istrue(self.recordedgameendstats)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  self stoploopsound();

  if(isDefined(self.turret)) {
    if(isDefined(self.turret.groundtargetent)) {
      self.turret.groundtargetent delete();
    }

    self.turret setentityowner(undefined);
    self.turret delete();
  }

  if(isDefined(self.testtarget)) {
    self.testtarget delete();
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  level.cratedropdata.escortchoppers = array_remove(level.cratedropdata.escortchoppers, self);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function function_e46fb5b1144140e(turret) {
  self endon("death");
  self endon("explode");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");

  thread function_12e7f2f1edff81ed();
  thread function_1a2daa72951eb0a4();

  childthread function_5a040540bee50d81();

  while(true) {
    var_868c91589c5db1ab = getdvarint(@ "hash_94edbe8b5c5b8dd0", 0);

    if(istrue(turret.disabled)) {
      waitframe();
      continue;
    }

    if(self.currentaction == "heli_overwatch") {
      self waittill("near_goal");
    }

    if(!var_868c91589c5db1ab) {
      besttargetdata = function_770a14e56b03b067(turret, 4000, 1, 0, 0, "lost_target", @ "hash_f8c88d9bcfa63da3");

      if(isDefined(besttargetdata)) {
        function_cade8c61df282de5(besttargetdata);
      }

      if(!isDefined(self.currentaction) || self.currentaction != self.defaultaction) {
        self thread[[self.defaultactionfunc]]();
        wait 2;
      }
    }

    wait 0.05;
  }
}

function function_5a040540bee50d81() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self.turret waittill("missile_fire", projectile);
    projectile.streakinfo = self.streakinfo;
    projectile.killcament = self.killcament;
  }
}

function function_cade8c61df282de5(targetdata) {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("heli_patrol");
  self endon("heli_overwatch");

  if(isDefined(self.owner) && self.owner _isalive() && (!isDefined(self.lastfiretime) || self.lastfiretime + 15000 <= gettime())) {
    playkillstreakoperatordialog("airdrop_escort", "airdrop_escort" + "_spotted_target", 1);
    self.lastfiretime = gettime();
  }

  self notify("heli_attack");
  self.currentaction = "heli_attack";
  turret = self.turret;
  playertotarget = function_70b8756e9fc03c44(targetdata);
  var_f14a9b1e9835aeaf = function_effebb9076efbdb(targetdata);
  function_82d3da0197ef0362("target_normal");
  self setlookatent(playertotarget);
  self setvehgoalpos(self.origin + anglesToForward(self.angles) * 500, 1);

  if(!isDefined(self.previousbesttarget) || isDefined(self.previousbesttarget) && self.previousbesttarget != playertotarget && !isDefined(self.var_69894ea4b6754d6f)) {
    var_e207676f4fa3c931 = playertotarget;
    newpingindex = self.owner scripts\cp_mp\calloutmarkerping::calloutmarkerping_createcallout(6, var_e207676f4fa3c931.origin + (0, 0, 50), var_e207676f4fa3c931 getentitynumber());
    self.owner thread scripts\cp_mp\calloutmarkerping::_calloutmarkerping_predicted_timeout(newpingindex);
    thread function_7fa1ed261ae2f5e3(playertotarget);
  }

  function_2e5b122bd53f3e85(targetdata);
  function_aa86f3f7fe0f419b(targetdata);

  while(function_b42ad7e3bd84c2a7() && function_bc2021c62b0d43cc(turret, playertotarget)) {
    wait 1;
    function_8e4e16bbbfa26efc(targetdata);
  }

  return "stopped_firing";
}

function function_7fa1ed261ae2f5e3(playertotarget) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  level endon("game_ended");
  self notify("new_prev_target");
  self endon("new_prev_target");
  self.previousbesttarget = playertotarget;
  wait 5;
  self.previousbesttarget = undefined;
}

function function_aa86f3f7fe0f419b(targetdata) {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("heli_patrol");
  turret = self.turret;
  var_de95d26a97999b92 = undefined;
  var_f14a9b1e9835aeaf = function_effebb9076efbdb(targetdata);
  playertotarget = function_70b8756e9fc03c44(targetdata);

  if(isDefined(var_f14a9b1e9835aeaf)) {
    var_de95d26a97999b92 = var_f14a9b1e9835aeaf.origin;
  } else if(isPlayer(playertotarget)) {
    var_de95d26a97999b92 = playertotarget gettagorigin("j_mainroot");
  } else {
    var_de95d26a97999b92 = playertotarget.origin;
  }

  thread function_8e6abc3776d35863(var_de95d26a97999b92);

  function_36694823ba9ec40a(var_de95d26a97999b92);

  while(!function_46ba72dfa1f04939(turret.groundtargetent.origin)) {
    waitframe();
  }
}

function function_8e4e16bbbfa26efc(targetdata) {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("heli_patrol");
  turret = self.turret;
  turret endon("lost_target");
  var_de95d26a97999b92 = undefined;
  var_f14a9b1e9835aeaf = function_effebb9076efbdb(targetdata);
  playertotarget = function_70b8756e9fc03c44(targetdata);
  var_dbc5aeb90480b355 = 0;
  turretfiretime = weaponfiretime("airdrop_escort_turret_ballistics_mp");
  attackradius = 80;
  var_546d410fced2a7dc = 5;
  var_b7f1b7d94522544f = 12;

  while(turret_hastarget(turret) && var_dbc5aeb90480b355 < 15) {
    if(isDefined(var_f14a9b1e9835aeaf)) {
      var_de95d26a97999b92 = var_f14a9b1e9835aeaf.origin;
    } else if(isPlayer(playertotarget)) {
      var_de95d26a97999b92 = playertotarget gettagorigin("j_mainroot");
    } else {
      var_de95d26a97999b92 = playertotarget.origin;
    }

    function_36694823ba9ec40a(var_de95d26a97999b92, attackradius);

    if(var_dbc5aeb90480b355 == var_546d410fced2a7dc) {
      attackradius = int(40);
    } else if(var_dbc5aeb90480b355 >= var_b7f1b7d94522544f) {
      attackradius = undefined;
    }

    turret shootturret();
    var_dbc5aeb90480b355++;

    if(isDefined(turret.streakinfo)) {
      turret.streakinfo.shots_fired++;
    }

    wait turretfiretime;
  }
}

function function_2e5b122bd53f3e85(targetdata) {
  turret = self.turret;
  playertarget = function_70b8756e9fc03c44(targetdata);
  thread function_a4da6e59481303f(playertarget, "death_or_disconnect");
  thread function_a4da6e59481303f(turret, "target_broke_los");
  thread function_a4da6e59481303f(turret, "target_outside_valid_range");
  thread function_a4da6e59481303f(turret, "target_timeout");
  thread function_a4da6e59481303f(turret, "target_last_stand");
  thread function_d8910badec564fa0(targetdata);
  thread function_3e4e3769f386a9a3(targetdata);
  thread function_a39bc57828127be1(targetdata);
  thread function_cc44cc73f134622e(targetdata);
}

function function_a4da6e59481303f(ent, actionnotify) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("crashing");
  turret = self.turret;
  turret endon("lost_target");
  ent waittill(actionnotify);
  function_7303808c08dbaae1();
  turret notify("lost_target");
}

function function_b42ad7e3bd84c2a7() {
  turret = self.turret;
  hastarget = turret_hastarget(turret);
  canattack = !isDefined(self.iscrashing) && !isDefined(self.isleaving);
  return istrue(hastarget) && istrue(canattack);
}

function function_36694823ba9ec40a(attackpoint, attackradius) {
  point = attackpoint;
  turret = self.turret;
  ignorelist = [self, self.turret];
  groundtarget = turret.groundtargetent;

  if(isDefined(attackradius)) {
    if(groundtarget islinked()) {
      groundtarget unlink();
    }

    randdist = randomint(attackradius);
    randangle = randomint(360);
    x = attackpoint[0] + randdist * cos(randangle);
    y = attackpoint[1] + randdist * sin(randangle);
    z = attackpoint[2];
    point = (x, y, z);
    groundtarget.origin = point;
    return;
  }

  if(groundtarget islinked()) {
    groundtarget unlink();
  }

  groundtarget linkTo(function_2adff40b591b5758(turret), "tag_origin", (0, 0, 30), (0, 0, 0));
}

function function_46ba72dfa1f04939(targetorigin) {
  turret = self.turret;
  turretforward = anglesToForward(turret gettagangles("tag_flash"));
  targetdisplace = targetorigin - turret.origin;
  anglediff = math::anglebetweenvectors(turretforward, targetdisplace);

  if(anglediff <= 10) {
    return true;
  }

  return false;
}

function function_d8910badec564fa0(targetdata) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret = self.turret;
  turret endon("lost_target");
  losttime = undefined;
  tolerance = 500;
  targetplayer = function_70b8756e9fc03c44(targetdata);
  attackvehicle = function_f6926785e402b9fe(targetdata);

  while(true) {
    canseetarget = turret_canseetarget(turret, targetplayer);

    if(!istrue(canseetarget)) {
      if(!isDefined(losttime)) {
        losttime = gettime();
      }

      if(gettime() - losttime > tolerance) {
        function_82d3da0197ef0362("target_broke_los");
        break;
      }
    } else {
      losttime = undefined;
    }

    wait 0.05;
  }
}

function function_3e4e3769f386a9a3(targetdata) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret = self.turret;
  turret endon("lost_target");
  targetplayer = function_70b8756e9fc03c44(targetdata);

  while(true) {
    startingpos = self.owner.origin;

    if(self.escorttype == "crate") {
      startingpos = self.pathgoal;
    }

    if(function_e44ce535d38f95a(startingpos, targetplayer)) {
      if(!function_ff7aba975a027d9b(startingpos, targetplayer)) {
        function_112064acba6603c3(targetplayer, 1);
        wait 1;
      }
    } else {
      function_82d3da0197ef0362("target_outside_valid_range");
      break;
    }

    wait 0.05;
  }
}

function function_a39bc57828127be1(targetdata) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret = self.turret;
  turret endon("lost_target");
  wait 5;
  function_82d3da0197ef0362("target_timeout");
}

function function_cc44cc73f134622e(targetdata) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  turret = self.turret;
  turret endon("lost_target");
  targetplayer = function_70b8756e9fc03c44(targetdata);
  var_24e9cece4bc538db = function_d463678ccf4beeda(targetdata);

  if(istrue(var_24e9cece4bc538db)) {
    return;
  }

  targetplayer waittill("last_stand_start");
  function_82d3da0197ef0362("target_last_stand");
}

function function_82d3da0197ef0362(targetstate) {
  turret = self.turret;
  function_46c1ea4a69ad33d6(turret, targetstate);
  turret notify(targetstate);
}

function function_7303808c08dbaae1() {
  turret = self.turret;

  if(turret.groundtargetent islinked()) {
    turret.groundtargetent unlink();
  }

  groundtargetorigin = self.origin - (0, 0, 100) + anglesToForward(self.angles) * 500;
  turret.groundtargetent.origin = groundtargetorigin;
  turret.groundtargetent linkTo(self);
}

function function_12e7f2f1edff81ed() {
  level endon("<dev string:x45>");
  self endon("<dev string:x50>");
  self endon("<dev string:x56>");
  self endon("<dev string:x5e>");
  turret = self.turret;

  while(true) {
    debugtarget = getdvarint(@ "hash_e9159b47fbb642af", 0);

    if(!debugtarget) {
      waitframe();
      continue;
    }

    level thread drawsphere(turret.groundtargetent.origin, 25, 0.05, (1, 0, 0));
    wait 0.05;
  }
}

function function_8e6abc3776d35863(var_3609de6106cc37a6) {
  level endon("<dev string:x45>");
  self endon("<dev string:x50>");
  self endon("<dev string:x56>");
  self endon("<dev string:x5e>");
  self.owner endon("<dev string:x66>");
  turret = self.turret;
  turret endon("<dev string:x7b>");

  while(true) {
    debugtarget = getdvarint(@ "hash_e9159b47fbb642af", 0);

    if(!debugtarget) {
      waitframe();
      continue;
    }

    level thread drawsphere(var_3609de6106cc37a6, 50, 0.05, (1, 1, 0));
    wait 0.05;
  }
}

function function_1a2daa72951eb0a4() {
  level endon("<dev string:x45>");
  self endon("<dev string:x50>");
  self endon("<dev string:x56>");
  self endon("<dev string:x5e>");
  turret = self.turret;
  escortowner = self.owner;
  escortowner notifyonplayercommand("<dev string:x66>", "<dev string:x87>");
  escortowner notifyonplayercommand("<dev string:x66>", "<dev string:x91>");

  while(true) {
    debugtarget = getdvarint(@ "hash_94edbe8b5c5b8dd0", 0);

    if(!debugtarget) {
      waitframe();
      continue;
    }

    escortowner waittill("<dev string:x66>");

    if(!turret_hastarget(turret)) {
      childthread function_190c881f4cd38bf2();
      continue;
    }

    function_7303808c08dbaae1();
    self.owner iprintlnbold("<dev string:x9c>" + self.defaultaction);
    turret_cleartarget(turret);
    self thread[[self.defaultactionfunc]]();
  }
}

function function_190c881f4cd38bf2() {
  self notify("<dev string:xae>");
  self endon("<dev string:xae>");
  self endon("<dev string:xc4>");
  self notify("<dev string:xd0>");
  self.currentaction = "<dev string:xd0>";
  turretfiretime = weaponfiretime("<dev string:xdc>");
  var_de95d26a97999b92 = undefined;
  attackradius = 80;
  targettracestart = self.owner getvieworigin();
  targettraceend = targettracestart + anglesToForward(self.owner getplayerangles()) * 50000;
  targettrace = scripts\engine\trace::ray_trace(targettracestart, targettraceend, self, scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1));

  if(targettrace["<dev string:x100>"] != "<dev string:x108>") {
    var_de95d26a97999b92 = targettrace["<dev string:x115>"];
  } else {
    return;
  }

  testtarget = undefined;

  if(!isDefined(self.testtarget)) {
    testtarget = spawn("<dev string:x11e>", var_de95d26a97999b92);
    testtarget setModel("<dev string:x12b>");
    testtarget dontinterpolate();
    testtarget.angles = self.owner.angles;
    self.testtarget = testtarget;
  } else {
    testtarget = self.testtarget;
    testtarget.origin = var_de95d26a97999b92;
  }

  targetdata = spawnStruct();
  targetdata.targetplayer = testtarget;
  targetdata.targetvehicle = undefined;
  targetdata.attackvehicle = 0;
  targetdata.attacklaststand = 0;
  targetdata.attackparachute = 0;
  turret = self.turret;
  playertotarget = function_70b8756e9fc03c44(targetdata);
  self.owner iprintlnbold("<dev string:x136>");
  turret_settarget(turret, targetdata);
  self setlookatent(testtarget);
  self setvehgoalpos(self.origin + anglesToForward(self.angles) * 500, 1);
  function_aa86f3f7fe0f419b(targetdata);

  while(function_b42ad7e3bd84c2a7() && function_bc2021c62b0d43cc(turret, playertotarget)) {
    wait 1;
    function_8e4e16bbbfa26efc(targetdata);
  }
}

# /