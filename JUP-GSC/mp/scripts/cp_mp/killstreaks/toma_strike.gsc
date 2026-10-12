/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\toma_strike.gsc
*****************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace toma_strike;

function function_1ad414b91ae3a040(var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val) {
  function_2ad245efb6cf07aa(var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val, #"int");
}

function function_7b9978e4325e037b(var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val) {
  function_2ad245efb6cf07aa(var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val, #"float");
}

function function_2ad245efb6cf07aa(var_fd773ed7f8ab59de, dvar_str, bundle_val, default_val, value_type) {
  level.toma_tunables[var_fd773ed7f8ab59de] = function_892aec72bcbbbc96(dvar_str, bundle_val, default_val);

  if(isDefined(value_type)) {
    level.toma_tunables[var_fd773ed7f8ab59de].type = value_type;
  }
}

function function_892aec72bcbbbc96(dvar_str, bundle_val, default_val) {
  var_cc2712a8519a8fd1 = spawnStruct();

  if(isDefined(dvar_str)) {
    var_cc2712a8519a8fd1.dvarstr = dvar_str;
  }

  if(isDefined(bundle_val)) {
    var_cc2712a8519a8fd1.bundle_val = bundle_val;
  }

  if(isDefined(default_val)) {
    var_cc2712a8519a8fd1.default_val = default_val;
  } else {
    var_cc2712a8519a8fd1.default_val = 0;
  }

  return var_cc2712a8519a8fd1;
}

function function_2fbfcadcc628d1a9(var_fd773ed7f8ab59de) {
  var_cc2712a8519a8fd1 = level.toma_tunables[var_fd773ed7f8ab59de];

  if(!isDefined(var_cc2712a8519a8fd1)) {
    return 0;
  }

  if(isDefined(var_cc2712a8519a8fd1.bundle_val)) {
    return var_cc2712a8519a8fd1.bundle_val;
  }

  if(!isDefined(var_cc2712a8519a8fd1.dvarstr) || !isDefined(var_cc2712a8519a8fd1.type)) {
    return var_cc2712a8519a8fd1.default_val;
  }

  if(var_cc2712a8519a8fd1.type == #"float") {
    return getdvarfloat(var_cc2712a8519a8fd1.dvarstr, var_cc2712a8519a8fd1.default_val);
  } else if(var_cc2712a8519a8fd1.type == #"int") {
    return getdvarint(var_cc2712a8519a8fd1.dvarstr, var_cc2712a8519a8fd1.default_val);
  }

  return var_cc2712a8519a8fd1.default_val;
}

function init() {
  if(issharedfuncdefined("toma_strike", "init")) {
    [[getsharedfunc("toma_strike", "init")]]();
  }

  level.toma_strikes = [];
  level.var_2512ecdb67f24156 = 0;
  level.var_eb94e9ccd3da6b2e = getdvarint(@ "scr_toma_strike_notify_time", 0);
  init_toma_strike_vo();
  function_f690e3ac50d71008();
  function_23d581c2a3bc96b3();

  setdevdvarifuninitialized(@ "hash_1eb5365bdad13b78", 0);
  setdevdvarifuninitialized(@ "hash_604652367665c1e0", 1);
}

function init_toma_strike_vo() {
  game["dialog"]["toma_strike" + "_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["toma_strike" + "_hit_target"] = "killstreak_remote_operator" + "_hit_target";
  game["dialog"]["toma_strike" + "_miss_target"] = "killstreak_remote_operator" + "_miss_target";
}

function function_f690e3ac50d71008() {
  level.var_d05191e44c57d2f7 = "toma_strike_placement";
  val::group_register(level.var_d05191e44c57d2f7, ["offhand_weapons", "melee", "execution_attack", "weapon_pickup", "cp_munitions_pickup", "supers"]);
}

function function_75667e2fe77b75c5(tomastriketype) {
  bundle = isDefined(level.streakglobals.streakbundles["toma_strike"]) ? level.streakglobals.streakbundles["toma_strike"] : {
    #var_d2a6e2899c72649b: undefined
  };
  level.var_d2a6e2899c72649b = isDefined(bundle.var_d2a6e2899c72649b) ? bundle.var_d2a6e2899c72649b : "toma_proj_jup_mp";

  if(tomastriketype == 1) {
    function_1ad414b91ae3a040(#"selection_radius", @ "hash_ca710d92e3e6f796", bundle.var_ef6057a8dee4db1a, 900);
    function_7b9978e4325e037b(#"launch_delay", @ "hash_fa567925d565ce1f", bundle.var_a20f464e59b5af88, 5);
    function_1ad414b91ae3a040(#"num_waves", @ "hash_5f34f197c71def3c", bundle.toma_waves, 4);
    function_1ad414b91ae3a040(#"hash_3082f1a04b68416a", @ "hash_9d9d004060864d1f", bundle.var_11743a7230976341, 4);
    function_7b9978e4325e037b(#"hash_6f7dfd81108ea213", @ "hash_791db5592ca32e41", bundle.var_977070ec24e2ee7d, 3.25);
    function_7b9978e4325e037b(#"hash_38f03def4a4b6115", @ "hash_6b6230528e92a697", bundle.var_80df958a7ebd91eb, 4);
    function_7b9978e4325e037b(#"hash_de33a7ef4ddea7d8", @ "hash_4539fb841b0d72ce", bundle.var_d2dd5ea126e7f952, 0.5);
    function_7b9978e4325e037b(#"hash_fd5d123893ddc96a", @ "hash_32f455fe26173e84", bundle.var_79d55329c3be1430, 0.75);
    return;
  }

  if(tomastriketype == 2) {
    function_1ad414b91ae3a040(#"selection_radius", @ "hash_ca710d92e3e6f796", bundle.var_ef6057a8dee4db1a, 50);
    function_7b9978e4325e037b(#"launch_delay", @ "hash_fa567925d565ce1f", bundle.var_a20f464e59b5af88, 0);
    function_1ad414b91ae3a040(#"num_waves", @ "hash_5f34f197c71def3c", bundle.toma_waves, 1);
    function_1ad414b91ae3a040(#"hash_3082f1a04b68416a", @ "hash_9d9d004060864d1f", bundle.var_11743a7230976341, 14);
    function_7b9978e4325e037b(#"hash_6f7dfd81108ea213", @ "hash_791db5592ca32e41", bundle.var_977070ec24e2ee7d, 3.25);
    function_7b9978e4325e037b(#"hash_38f03def4a4b6115", @ "hash_6b6230528e92a697", bundle.var_80df958a7ebd91eb, 4);
    function_7b9978e4325e037b(#"hash_de33a7ef4ddea7d8", @ "hash_4539fb841b0d72ce", bundle.var_d2dd5ea126e7f952, 0.2);
    function_7b9978e4325e037b(#"hash_fd5d123893ddc96a", @ "hash_32f455fe26173e84", bundle.var_79d55329c3be1430, 0.8);
    return;
  }

  function_1ad414b91ae3a040(#"selection_radius", @ "hash_ca710d92e3e6f796", bundle.var_ef6057a8dee4db1a, 450);
  function_7b9978e4325e037b(#"launch_delay", @ "hash_fa567925d565ce1f", bundle.var_a20f464e59b5af88, 2);
  function_1ad414b91ae3a040(#"num_waves", @ "hash_5f34f197c71def3c", bundle.toma_waves, 4);
  function_1ad414b91ae3a040(#"hash_3082f1a04b68416a", @ "hash_9d9d004060864d1f", bundle.var_11743a7230976341, 4);
  function_7b9978e4325e037b(#"hash_6f7dfd81108ea213", @ "hash_791db5592ca32e41", bundle.var_977070ec24e2ee7d, 3.25);
  function_7b9978e4325e037b(#"hash_38f03def4a4b6115", @ "hash_6b6230528e92a697", bundle.var_80df958a7ebd91eb, 4);
  function_7b9978e4325e037b(#"hash_de33a7ef4ddea7d8", @ "hash_4539fb841b0d72ce", bundle.var_d2dd5ea126e7f952, 0.5);
  function_7b9978e4325e037b(#"hash_fd5d123893ddc96a", @ "hash_32f455fe26173e84", bundle.var_79d55329c3be1430, 0.75);
}

function function_23d581c2a3bc96b3() {
  setdvarifuninitialized(@ "hash_1eb5365bdad13b78", 0);
  setdvarifuninitialized(@ "hash_ca710d92e3e6f796", 450);
  setdvarifuninitialized(@ "hash_fa567925d565ce1f", 2);
  setdvarifuninitialized(@ "hash_3417b331cd0f5b4f", 6);
  setdvarifuninitialized(@ "hash_5f34f197c71def3c", 4);
  setdvarifuninitialized(@ "hash_9d9d004060864d1f", 4);
  setdvarifuninitialized(@ "hash_791db5592ca32e41", 3.25);
  setdvarifuninitialized(@ "hash_6b6230528e92a697", 4);
  setdvarifuninitialized(@ "hash_4539fb841b0d72ce", 0.5);
  setdvarifuninitialized(@ "hash_32f455fe26173e84", 0.75);
  setdvarifuninitialized(@ "hash_a394734820792b88", 3);
}

function function_cad492faa20c3feb(var_f3f8aa78862a0804) {
  tomastriketype = getdvarint(@ "hash_1eb5365bdad13b78", 0);

  if(tomastriketype == var_f3f8aa78862a0804) {
    return;
  }

  if(var_f3f8aa78862a0804 == 0) {
    setDvar(@ "hash_1eb5365bdad13b78", 0);
    setDvar(@ "hash_ca710d92e3e6f796", 450);
    setDvar(@ "hash_fa567925d565ce1f", 2);
    setDvar(@ "hash_3417b331cd0f5b4f", 6);
    setDvar(@ "hash_5f34f197c71def3c", 4);
    setDvar(@ "hash_9d9d004060864d1f", 4);
    setDvar(@ "hash_791db5592ca32e41", 3.25);
    setDvar(@ "hash_6b6230528e92a697", 4);
    setDvar(@ "hash_4539fb841b0d72ce", 0.5);
    setDvar(@ "hash_32f455fe26173e84", 0.75);
    setDvar(@ "hash_a394734820792b88", 3);
  } else if(var_f3f8aa78862a0804 == 1) {
    setDvar(@ "hash_1eb5365bdad13b78", 1);
    setDvar(@ "hash_ca710d92e3e6f796", 900);
    setDvar(@ "hash_fa567925d565ce1f", 5);
    setDvar(@ "hash_3417b331cd0f5b4f", 6);
    setDvar(@ "hash_5f34f197c71def3c", 4);
    setDvar(@ "hash_9d9d004060864d1f", 4);
    setDvar(@ "hash_791db5592ca32e41", 3.25);
    setDvar(@ "hash_6b6230528e92a697", 4);
    setDvar(@ "hash_4539fb841b0d72ce", 0.5);
    setDvar(@ "hash_32f455fe26173e84", 0.75);
    setDvar(@ "hash_a394734820792b88", 4);
  } else if(var_f3f8aa78862a0804 == 2) {
    setDvar(@ "hash_1eb5365bdad13b78", 2);
    setDvar(@ "hash_ca710d92e3e6f796", 50);
    setDvar(@ "hash_fa567925d565ce1f", 0);
    setDvar(@ "hash_3417b331cd0f5b4f", 14);
    setDvar(@ "hash_5f34f197c71def3c", 1);
    setDvar(@ "hash_9d9d004060864d1f", 14);
    setDvar(@ "hash_791db5592ca32e41", 3.25);
    setDvar(@ "hash_6b6230528e92a697", 4);
    setDvar(@ "hash_4539fb841b0d72ce", 0.2);
    setDvar(@ "hash_32f455fe26173e84", 0.8);
    setDvar(@ "hash_a394734820792b88", 1.5);
  }

  self.var_70b761d63979e102 = getdvarfloat(@ "hash_a394734820792b88", 3) - 0.075;
}

function trytomastriketriggered(streakinfo) {
  streakname = streakinfo.streakname;
  tomastriketype = getdvarint(@ "hash_1eb5365bdad13b78", 0);
  return true;
}

function gettimeremaining() {
  shortestleft = undefined;

  foreach(strike in level.toma_strikes) {
    timeleft = int(max(1, strike.starttimems + strike.totaltimesec * 1000 - gettime()));

    if(!isDefined(shortestleft) || timeleft < shortestleft) {
      shortestleft = timeleft;
    }
  }

  return int(function_c89ed1840c8d0f0f(shortestleft)) + 1;
}

function weapongiventomastrike(streakinfo) {
  if(isDefined(level.toma_strikes) && level.toma_strikes.size >= 2) {
    if(istrue(level.var_eb94e9ccd3da6b2e)) {
      timesec = gettimeremaining();

      if(issharedfuncdefined("hud", "showErrorMessage")) {
        [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED_TIME", timesec);
      }
    } else if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(function_b1412f0ab907bab7()) {
    self setclientomnvar("ui_using_clusterstrike", 1);
  }

  return true;
}

function weaponfiredtomastrike(streakinfo, firedweaponobj, firedprojectile) {
  if(!isDefined(streakinfo.targetoverride)) {
    mappoint = tomastrike_getownerlookat(self);

    if(!isDefined(mappoint)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");
      }

      return "continue";
    }
  }

  if(function_f3890748bda5f813()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      if(iscp()) {
        self[[getsharedfunc("hud", "showErrorMessage")]]("EQUIPMENT/ARMAMENT_CANNOT_BE_USED");
      } else {
        self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
      }
    }

    return "continue";
  }

  var_52a5be2e2f91d710 = undefined;

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    var_52a5be2e2f91d710 = 3;
  }

  thread function_d1b8339c6ab7b1fa("toma_strike", "toma_strike" + "_use", 1, var_52a5be2e2f91d710);

  if(function_b1412f0ab907bab7()) {
    self setclientomnvar("ui_using_clusterstrike", 0);
  }

  return "success";
}

function tryusetomastrike() {
  streakinfo = createstreakinfosharedfunc("toma_strike", self);
  return tryusetomastrikefromstruct(streakinfo);
}

function tryusetomastrikefromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  tomastriketype = function_717a6e5e13464b20();
  function_75667e2fe77b75c5(tomastriketype);

  if(tomastriketype == 1 && isDefined(self.kstargetlocation)) {
    streakinfo.targetoverride = self.kstargetlocation;
    self.kstargetlocation = undefined;
    firedresult = weaponfiredtomastrike(streakinfo, undefined, undefined);

    if(firedresult != "success") {
      return false;
    }
  } else {
    if(isDefined(level.var_d05191e44c57d2f7)) {
      streakinfo.var_fb58a31c756db4cc = level.var_d05191e44c57d2f7;
    }

    deployresult = function_de31b76c1bf488e8(streakinfo, makeweapon("iw9_laser_large_ir_mp"), "weapon_fired", &weapongiventomastrike, undefined, &weaponfiredtomastrike);

    if(!istrue(deployresult)) {
      if(function_b1412f0ab907bab7()) {
        self setclientomnvar("ui_using_clusterstrike", 0);
      }

      return false;
    }
  }

  self playlocalsound("kls_location_select");

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_toma_strike", self);
  }

  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.streakname, self.origin);
  }

  starttomastrike(tomastriketype, streakinfo);
  return true;
}

function function_717a6e5e13464b20() {
  tomastriketype = getdvarint(@ "hash_1eb5365bdad13b78", 0);
  isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();

  if(isbr && isPlayer(self)) {
    tomastriketype = 1;
  } else if(isagent(self)) {
    tomastriketype = 2;
  } else {
    tomastriketype = 0;
  }

  function_cad492faa20c3feb(tomastriketype);
  return tomastriketype;
}

function function_5d38cccb518046f6(target, var_44b5105c6f71bc85, var_6530ac0c11cac0f8, traveltimeoverwrite) {
  tomastriketype = function_717a6e5e13464b20();
  function_75667e2fe77b75c5(tomastriketype);

  if(tomastriketype == 2) {
    if(isDefined(var_44b5105c6f71bc85)) {
      self.attackrange = var_44b5105c6f71bc85;
      self.var_6ac9ab8269fb85d1 = var_6530ac0c11cac0f8;
    }

    if(isDefined(traveltimeoverwrite)) {
      if(isDefined(target) && isPlayer(target) && isDefined(target.vehicle) && isDefined(target.vehicle.vehiclename)) {
        setDvar(@ "hash_a394734820792b88", traveltimeoverwrite.vehiclesetting);
        self.var_70b761d63979e102 = traveltimeoverwrite.vehiclesetting - 0.075;
      } else {
        setDvar(@ "hash_a394734820792b88", traveltimeoverwrite.walksetting);
        self.var_70b761d63979e102 = traveltimeoverwrite.walksetting - 0.075;
      }
    }
  }

  streakinfo = createstreakinfosharedfunc("toma_strike", self);
  tomaid = tomastrike_getid();
  level.toma_strikes[tomaid] = self;
  function_e744d4edafed7523(tomaid, tomastriketype, target);
  tomastrike_attacktarget(tomastriketype, undefined, target, streakinfo, tomaid);
  level.toma_strikes[tomaid] = undefined;
}

function starttomastrike(striketype, streakinfo) {
  tomaid = tomastrike_getid();
  function_e744d4edafed7523(tomaid, striketype);
  thread tomastrike_watchgameend(tomaid, streakinfo);
  thread function_817d8b8f6d28b2b7(tomaid, streakinfo);
  thread tomastrike_watchkills(tomaid);
  thread tomastrike_attacktarget(striketype, undefined, undefined, streakinfo, tomaid);
  streakinfo notify("killstreak_finished_with_deploy_weapon");
  level callback::callback("killstreak_finish_use", {
    #streakinfo: streakinfo
  });

  if(issharedfuncdefined("toma_strike", "munitionUsed")) {
    self[[getsharedfunc("toma_strike", "munitionUsed")]]();
  }

  if(issharedfuncdefined("player", "doOnActionScoreEvent")) {
    self[[getsharedfunc("player", "doOnActionScoreEvent")]](2, "tomaStrikeUsed");
  }
}

function tomastrike_getownerlookat(owner) {
  content = ["physicscontents_water", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  contentoverride = physics_createcontents(content);
  starttrace = owner getvieworigin();

  if(owner function_2f8556207c6fd79f()) {
    starttrace = owner function_aef9ca498b472945();
  }

  endtrace = starttrace + anglesToForward(owner getplayerangles()) * 50000;
  ignoreents = owner playerkillstreakgetownerlookatignoreentssharedfunc();
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, ignoreents, contentoverride);
  endpos = undefined;

  if(isDefined(trace["hittype"]) && trace["hittype"] != "hittype_none") {
    endpos = trace["position"];
  }

  return endpos;
}

function tomastrike_getid() {
  level.var_2512ecdb67f24156++;

  if(getdvarint(@ "hash_1eb5365bdad13b78", 0) == 2) {
    return (self getentitynumber() + "_" + level.var_2512ecdb67f24156);
  }

  return self getxuid() + "_" + level.var_2512ecdb67f24156;
}

function tomastrike_watchgameend(tomaid, streakinfo) {
  level endon("toma_strike_clean_up_" + tomaid);
  level waittill("game_ended");

  if(isDefined(self)) {
    recordkillstreakendstatssharedfunc(streakinfo);
  }
}

function function_817d8b8f6d28b2b7(tomaid, streakinfo) {
  level endon("game_ended");
  level thread function_9bdb853be512d3ed("disconnect", tomaid, self);
  level thread function_9bdb853be512d3ed("toma_strike_finished_" + tomaid, tomaid);
  level waittill("toma_strike_clean_up_" + tomaid);

  if(isDefined(self)) {
    recordkillstreakendstatssharedfunc(streakinfo);
  }

  level.toma_strikes[tomaid] = undefined;
}

function function_9bdb853be512d3ed(actionnotify, tomaid, player) {
  level endon("toma_strike_clean_up_" + tomaid);
  notifyobject = level;

  if(isDefined(player)) {
    notifyobject = player;
  }

  notifyobject waittill(actionnotify);
  level notify("toma_strike_clean_up_" + tomaid);
}

function tomastrike_watchkills(tomaid) {
  level endon("game_ended");
  self notify("toma_strike_watch_kills");
  self endon("toma_strike_watch_kills");
  self.tomastrikekillcount = 0;
  childthread tomastrike_watchkillscount(tomaid);
  childthread function_9b8a16f9169ac8b2(tomaid);
  level waittill("toma_strike_finished_" + tomaid);

  if(isDefined(self)) {
    if(self.tomastrikekillcount >= 1) {
      function_d1b8339c6ab7b1fa("toma_strike", "toma_strike" + "_hit_target", 1);
      return;
    }

    function_d1b8339c6ab7b1fa("toma_strike", "toma_strike" + "_miss_target", 1);
  }
}

function tomastrike_watchkillscount(tomaid) {
  level endon("toma_strike_finished_" + tomaid);

  while(isDefined(self)) {
    self waittill("update_rapid_kill_buffered", recentkillcount, fullweaponstring);

    if(isDefined(fullweaponstring) && fullweaponstring == level.var_d2a6e2899c72649b) {
      self.tomastrikekillcount++;
    }
  }
}

function function_9b8a16f9169ac8b2(tomaid) {
  level endon("toma_strike_finished_" + tomaid);

  while(isDefined(self)) {
    self waittill("update_rapid_agent_kill_buffered", recentkillcount, fullweaponstring);

    if(isDefined(fullweaponstring) && fullweaponstring == level.var_d2a6e2899c72649b) {
      self.tomastrikekillcount++;
    }
  }
}

function function_e744d4edafed7523(tomaid, striketype, target) {
  level.toma_strikes[tomaid] = spawnStruct();
  level.toma_strikes[tomaid].starttimems = gettime();
  level.toma_strikes[tomaid].totaltimesec = function_2fbfcadcc628d1a9(#"launch_delay");
  level.toma_strikes[tomaid].strikedelay = [];
  explosiontype = getdvarint(@ "hash_604652367665c1e0", 1);
  var_4cb267f38b5de2f2 = function_2fbfcadcc628d1a9(#"num_waves");
  var_c1ca10e800f3bb3b = function_2fbfcadcc628d1a9(#"hash_3082f1a04b68416a");
  var_9e29352ba1d54508 = function_2fbfcadcc628d1a9(#"hash_6f7dfd81108ea213");
  var_fbc8bef50e9d8f8a = function_2fbfcadcc628d1a9(#"hash_38f03def4a4b6115");
  var_55811e2f54b0b1 = function_2fbfcadcc628d1a9(#"hash_de33a7ef4ddea7d8");
  var_61ef97f2418800cb = function_2fbfcadcc628d1a9(#"hash_fd5d123893ddc96a");

  if(explosiontype == 1) {
    if(striketype == 2) {
      if(isDefined(level.ob.warlordparameters["Rainmaker"])) {
        var_c1ca10e800f3bb3b = level.ob.warlordparameters["Rainmaker"].var_4dd5c4885e94aaaa;
        var_4cb267f38b5de2f2 = level.ob.warlordparameters["Rainmaker"].var_a8b72b0b7f481d0b;
      }
    }

    level.toma_strikes[tomaid].wavedelay = [];

    for(i = 0; i < var_4cb267f38b5de2f2; i++) {
      level.toma_strikes[tomaid].strikedelay[i] = [];

      for(j = 0; j < var_c1ca10e800f3bb3b; j++) {
        timetowait = randomfloatrange(var_55811e2f54b0b1, var_61ef97f2418800cb);
        level.toma_strikes[tomaid].totaltimesec += timetowait;
        level.toma_strikes[tomaid].strikedelay[i][j] = timetowait;
      }

      timetowait = randomfloatrange(var_9e29352ba1d54508, var_fbc8bef50e9d8f8a);
      level.toma_strikes[tomaid].totaltimesec += timetowait;
      level.toma_strikes[tomaid].wavedelay[i] = timetowait;
    }

    return;
  }

  [numstrikes, radius] = function_19051844ba5d9143(striketype);

  for(i = 0; i < numstrikes; i++) {
    timetowait = randomfloatrange(1.35, 2.5);
    level.toma_strikes[tomaid].totaltimesec += timetowait;
    level.toma_strikes[tomaid].strikedelay[i] = timetowait;
  }
}

function function_f05afcd1f818600(tomaid, explosiontype, strikeindex) {
  assert(explosiontype != 1);
  return level.toma_strikes[tomaid].strikedelay[strikeindex];
}

function function_db43c64d90389bec(tomaid, explosiontype, waveindex, strikeindex) {
  assert(explosiontype == 1);
  return level.toma_strikes[tomaid].strikedelay[waveindex][strikeindex];
}

function function_2a08e4b3be6f5721(tomaid, explosiontype, waveindex) {
  assert(explosiontype == 1);
  return level.toma_strikes[tomaid].wavedelay[waveindex];
}

function function_19051844ba5d9143(striketype) {
  numstrikes = getdvarint(@ "hash_3417b331cd0f5b4f");
  radius = function_2fbfcadcc628d1a9(#"selection_radius");
  return [numstrikes, radius];
}

function function_79762e7627b23945(tomaid) {
  return level.toma_strikes[tomaid].strikedelay.size;
}

function function_8e60d713e3da2f08(tomaid, waveid) {
  return level.toma_strikes[tomaid].strikedelay[waveid].size;
}

function tomastrike_attacktarget(striketype, vehicle, marker, streakinfo, tomaid) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("drone_target_placed");
  streakinfo.shots_fired++;
  bombingsourcepos = self.origin + (0, 0, 5000) - anglesToForward(self.angles) * 5000;
  var_773a048a6c827187 = anglestoright(self.angles);
  markerorigin = undefined;

  if(isDefined(marker)) {
    if(isvector(marker)) {
      markerorigin = marker;
    } else {
      markerorigin = marker.origin;
    }
  } else {
    if(striketype == 1 && isDefined(streakinfo.targetoverride)) {
      markerorigin = streakinfo.targetoverride;
    } else {
      markerorigin = tomastrike_getownerlookat(self);
    }

    bundle = isDefined(level.streakglobals.streakbundles["toma_strike"]) ? level.streakglobals.streakbundles["toma_strike"] : {
      #var_fcca389ece98b4a3: undefined
    };
    marker = spawn("script_model", markerorigin);
    marker setModel(isDefined(bundle.var_fcca389ece98b4a3) ? bundle.var_fcca389ece98b4a3 : "ks_toma_strike_marker_mp");
    marker.objidnum = 0;

    if(scripts\engine\utility::issharedfuncdefined("game", "requestObjectiveID")) {
      marker.objidnum = [[scripts\engine\utility::getsharedfunc("game", "requestObjectiveID")]](99);
    }

    marker.icon = "icon_waypoint_clusterstrike";
    marker setotherent(self);
    marker toma_strike_setmarkerobjective(marker.objidnum, marker.icon, self, 50);
    marker thread toma_strike_handlemarkerscriptable();
  }

  if(function_ccf98e6391dd38b9()) {
    self.marker = marker;
    thread function_99347dc58ab12b57(marker.origin);
  }

  numstrikes = getdvarint(@ "hash_3417b331cd0f5b4f", 6);
  radius = function_2fbfcadcc628d1a9(#"selection_radius");

  if(striketype == 1) {
    if(issharedfuncdefined("br", "challengeEvaluator")) {
      paramstruct = spawnStruct();
      paramstruct.streakinfo = streakinfo;
      paramstruct.targetsite = markerorigin;
      self[[getsharedfunc("br", "challengeEvaluator")]]("br_mastery_pointBlank_tomahawk", paramstruct);
    }
  }

  function_940b2080e171a9d3(self, self.team, radius + 300, streakinfo.streakname, markerorigin);
  delaytime = function_2fbfcadcc628d1a9(#"launch_delay");
  ownerlookforward = anglesToForward(self getplayerangles());
  ownerforward = anglesToForward(self.angles);
  ownerright = anglestoright(self.angles);
  function_2284137aa92dbd16(delaytime);

  clusterdebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(clusterdebugon) {
    thread scripts\common\debug::debug_sphere(markerorigin, 20, (1, 1, 1), 20);
  }

  explosiontype = getdvarint(@ "hash_604652367665c1e0", 1);

  if(!isDefined(self.attackrange)) {
    self.attackrange = 4000;
  }

  attackrangesq = self.attackrange * self.attackrange;

  if(!isDefined(self.var_6ac9ab8269fb85d1)) {
    self.var_6ac9ab8269fb85d1 = 0;
  }

  var_ab7ba1695185b1f5 = self.var_6ac9ab8269fb85d1 * self.var_6ac9ab8269fb85d1;

  if(explosiontype == 1) {
    if(isDefined(level.var_b67b5f9dfe488c2f)) {
      thread[[level.var_b67b5f9dfe488c2f]](streakinfo);
    }

    var_4cb267f38b5de2f2 = function_79762e7627b23945(tomaid);

    for(i = 0; i < var_4cb267f38b5de2f2; i++) {
      var_c1ca10e800f3bb3b = function_8e60d713e3da2f08(tomaid, i);
      var_61ef97f2418800cb = undefined;
      var_55811e2f54b0b1 = undefined;
      var_fbc8bef50e9d8f8a = undefined;
      var_9e29352ba1d54508 = undefined;

      if(isDefined(level.ob) && isDefined(level.ob.warlordparameters) && isDefined(level.ob.warlordparameters["Rainmaker"])) {
        if(isDefined(marker) && isPlayer(marker) && isDefined(marker.vehicle) && isDefined(marker.vehicle.vehiclename)) {
          var_61ef97f2418800cb = level.ob.warlordparameters["Rainmaker"].var_4b6686b7eee42901.vehiclesetting;
          var_55811e2f54b0b1 = level.ob.warlordparameters["Rainmaker"].var_55811e2f54b0b1.vehiclesetting;
          var_fbc8bef50e9d8f8a = level.ob.warlordparameters["Rainmaker"].var_fbc8bef50e9d8f8a.vehiclesetting;
          var_9e29352ba1d54508 = level.ob.warlordparameters["Rainmaker"].var_9e29352ba1d54508.vehiclesetting;
        } else {
          var_61ef97f2418800cb = level.ob.warlordparameters["Rainmaker"].var_4b6686b7eee42901.walksetting;
          var_55811e2f54b0b1 = level.ob.warlordparameters["Rainmaker"].var_55811e2f54b0b1.walksetting;
          var_fbc8bef50e9d8f8a = level.ob.warlordparameters["Rainmaker"].var_fbc8bef50e9d8f8a.walksetting;
          var_9e29352ba1d54508 = level.ob.warlordparameters["Rainmaker"].var_9e29352ba1d54508.walksetting;
        }
      }

      for(j = 0; j < var_c1ca10e800f3bb3b; j++) {
        if(striketype == 2) {
          enemyplayer = marker;
          targetposition = enemyplayer.origin;

          if(isDefined(self.strikelocationsetfunc)) {
            targetposition = [[self.strikelocationsetfunc]](j, tomastrike_getid(), enemyplayer);
          }

          if(isDefined(targetposition)) {
            bombinginfo = findunobstructedfiringinfo(targetposition, radius, ownerlookforward, ownerforward, ownerright);
            thread tomastrike_firestrike(striketype, bombinginfo, streakinfo);
          }
        } else {
          bombinginfo = findunobstructedfiringinfo(markerorigin, radius, ownerlookforward, ownerforward, ownerright);
          thread tomastrike_firestrike(striketype, bombinginfo, streakinfo);
        }

        if(isDefined(var_61ef97f2418800cb) && isDefined(var_55811e2f54b0b1)) {
          timetowait = randomfloatrange(var_55811e2f54b0b1, var_61ef97f2418800cb);
          wait timetowait;
          continue;
        }

        timetowait = function_db43c64d90389bec(tomaid, explosiontype, i, j);
        wait timetowait;
      }

      if(isDefined(var_fbc8bef50e9d8f8a) && isDefined(var_9e29352ba1d54508)) {
        timetowait = randomfloatrange(var_9e29352ba1d54508, var_fbc8bef50e9d8f8a);
        wait timetowait;
        continue;
      }

      timetowait = function_2a08e4b3be6f5721(tomaid, explosiontype, i);
      wait timetowait;
    }
  } else {
    for(i = 0; i < numstrikes; i++) {
      if(striketype == 2) {
        bombinginfo = findunobstructedfiringinfo(marker.origin, radius, ownerlookforward, ownerforward, ownerright);
      } else {
        bombinginfo = findunobstructedfiringinfo(markerorigin, radius, ownerlookforward, ownerforward, ownerright);
      }

      thread tomastrike_firestrike(striketype, bombinginfo, streakinfo);
      function_2284137aa92dbd16(randomfloatrange(1.35, 2.5));
    }
  }

  if(isDefined(level.var_f56a88761038798b)) {
    thread[[level.var_f56a88761038798b]](streakinfo);
  }

  level notify("toma_strike_finished_" + tomaid);
}

function function_99347dc58ab12b57(center) {
  wait 6;
  var_6bb1b1677e0a4cf2 = createnavbadplacebyshape(center, (0, 0, 0), 8, 400, 500);
  wait 4;

  if(isDefined(var_6bb1b1677e0a4cf2)) {
    destroynavobstacle(var_6bb1b1677e0a4cf2);
  }

  var_6bb1b0677e0a4abf = createnavbadplacebyshape(center, (0, 0, 0), 8, 600, 500);
  wait 4;

  if(isDefined(var_6bb1b0677e0a4abf)) {
    destroynavobstacle(var_6bb1b0677e0a4abf);
  }

  var_6bb1af677e0a488c = createnavbadplacebyshape(center, (0, 0, 0), 8, 800, 500);
  wait 22;

  if(isDefined(var_6bb1af677e0a488c)) {
    destroynavobstacle(var_6bb1af677e0a488c);
  }
}

function findunobstructedfiringinfo(var_27c77d35f1de2019, bombingradius, ownerlookforward, ownerforward, ownerright) {
  gravity = getdvarint(@ "bg_gravity", 800);

  if(getdvarint(@ "hash_12ca000dd2976ebc", 0)) {
    gravity = getdvarfloat(@ "hash_2f4cf62df1af9a6", 125);
  }

  bombinginfo = spawnStruct();
  bombingsourcepos = tomastrike_findoptimallaunchpos(var_27c77d35f1de2019, ownerlookforward, ownerforward, ownerright);
  bombingdirection = vectorNormalize(var_27c77d35f1de2019 - (bombingsourcepos[0], bombingsourcepos[1], 0));
  bombinggoalinfo = tomastrike_getrandombombingpoint(var_27c77d35f1de2019, bombingradius, bombingdirection);
  bombinggravity = (0, 0, -1 * gravity);
  traveltime = getdvarfloat(@ "hash_a394734820792b88", 3);
  bombingvelocity = (bombinggoalinfo.point - 0.5 * bombinggravity * squared(traveltime) - bombingsourcepos) / traveltime;

  clusterdebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(clusterdebugon) {
    thread scripts\common\debug::debug_sphere(bombinggoalinfo.point, 20, (1, 1, 0), 20);
    thread scripts\common\debug::debug_line(bombingsourcepos, bombinggoalinfo.point, (1, 1, 0), 20);
  }

  if(!isDefined(self.var_70b761d63979e102)) {
    self.var_70b761d63979e102 = getdvarfloat(@ "hash_a394734820792b88", 3) - 0.075;
  }

  var_f69efd87385e55 = bombingsourcepos + bombingvelocity * self.var_70b761d63979e102 + 0.5 * bombinggravity * squared(self.var_70b761d63979e102);
  bombinginfo.sourcepos = bombingsourcepos;
  bombinginfo.entityhit = bombinggoalinfo.entityhit;
  bombinginfo.entityhittype = bombinggoalinfo.entityhittype;
  bombinginfo.goalpos = bombinggoalinfo.point;
  bombinginfo.preexplpos = var_f69efd87385e55;
  bombinginfo.initvelocity = bombingvelocity;
  return bombinginfo;
}

function delayscriptablechangethread(delaytime) {
  self.owner endon("disconnect");
  self endon("death");
  self.owner waittill_any_timeout_1(delaytime, "stop_marker_guide");
  self setscriptablepartstate("target", "off", 0);
  self delete();
}

function tomastrike_getrandombombingpoint(var_27c77d35f1de2019, bombingradius, bombingdirection) {
  randdist = randomint(bombingradius);
  randangle = randomint(360);
  x = var_27c77d35f1de2019[0] + randdist * cos(randangle);
  y = var_27c77d35f1de2019[1] + randdist * sin(randangle);
  z = var_27c77d35f1de2019[2];
  point = (x, y, z);

  if(isDefined(bombingdirection)) {
    point -= bombingdirection * 100;
  }

  traceheightoffset = 10000;

  if(isDefined(level.toma_strike_trace_offset)) {
    traceheightoffset = level.toma_strike_trace_offset;
  }

  pointinfo = spawnStruct();
  contents = scripts\engine\trace::create_default_contents(1);
  trace = scripts\engine\trace::ray_trace(point + (0, 0, traceheightoffset), point - (0, 0, traceheightoffset), undefined, contents);

  if(isDefined(trace["entity"])) {
    entity = trace["entity"];
    pointinfo.entityhit = entity;

    if(tomastrike_isflyingvehicle(entity) || tomastrike_isflyingkillstreak(entity)) {
      pointinfo.entityhittype = "flying";
    }
  }

  if(isDefined(trace["position"])) {
    point = trace["position"];
  }

  pointinfo.point = point;
  return pointinfo;
}

function tomastrike_isflyingvehicle(entity) {
  return isDefined(self.vehiclename) && istrue(entity function_d7d7db3140b95ce3());
}

function tomastrike_isflyingkillstreak(entity) {
  return isDefined(entity.streakinfo) && isDefined(entity.sentientpool) && entity.sentientpool == "Killstreak_Air";
}

function tomastrike_firestrike(striketype, bombinginfo, streakinfo, vehicle) {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(vehicle)) {
    self earthquakeforplayer(0.35, 1, vehicle.origin, 1000);
    self playlocalsound("weap_cluster_fire");
  }

  if(!isDefined(level.var_d2a6e2899c72649b)) {
    function_75667e2fe77b75c5(striketype);
  }

  missile = magicgrenademanual(level.var_d2a6e2899c72649b, bombinginfo.sourcepos, bombinginfo.initvelocity, getdvarfloat(@ "hash_a394734820792b88", 3) + 2, self);
  missile forcenetfieldhighlod(1);
  tomastrikeicontype = getdvarint(@ "hash_2cfbf02c634789ea", 1);

  if(tomastrikeicontype == 0) {
    missile setmissileminimapvisiblesharedfunc(1);
  } else {
    minimapid = undefined;

    if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
      minimapid = missile[[scripts\engine\utility::getsharedfunc("game", "createObjective")]]("hud_icon_minimap_killstreak_mortar_strike", self.team, undefined, 1, 1);
    }

    missile.minimapid = minimapid;
  }

  missile setentityowner(self);
  missile setotherent(self);
  missile.owner = self;
  missile.streakinfo = streakinfo;
  killcament = spawn("script_model", bombinginfo.sourcepos);
  killcament linkTo(missile, "tag_origin", (10, 0, 10), (0, 0, 0));
  missile.killcament = killcament;
  bundle = isDefined(level.streakglobals.streakbundles["toma_strike"]) ? level.streakglobals.streakbundles["toma_strike"] : {
    #var_7e5ed6a828e0ed8f: undefined
  };
  missile.explodeent = spawn("script_model", missile.origin);
  missile.explodeent setModel(isDefined(bundle.var_7e5ed6a828e0ed8f) ? bundle.var_7e5ed6a828e0ed8f : "ks_toma_strike_missile_mp");
  missile.explodeent linkTo(missile);
  missile.explodeent dontinterpolate();
  missile.explodeent setentityowner(self);
  missile.explodeent.killcament = killcament;

  if(!istrue(self.isfakestreakent) && issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[getsharedfunc("spawn", "addSpawnDangerZone")]](bombinginfo.goalpos, 512, 300, self.team, 6, self, 1);
  }

  missile setscriptablepartstate("launch", "active", 0);
  missile setscriptablepartstate("trail", "active", 0);
  missile thread toma_strike_watch_owner();
  missile thread function_dd555baddc036858();
  explosiontype = getdvarint(@ "hash_604652367665c1e0", 1);
  var_63160bef0a2103d3 = getdvarfloat(@ "hash_a394734820792b88", 3) - 0.5;
  killcamendpos = bombinginfo.preexplpos;

  if(explosiontype != 1) {
    missile thread toma_strike_watch_airexplosion(bombinginfo.preexplpos, bombinginfo.entityhit, bombinginfo.entityhittype, self.var_70b761d63979e102);
  } else {
    missile thread toma_strike_watch_airexplosion(undefined, undefined, undefined, getdvarfloat(@ "hash_a394734820792b88", 3) + 1);
  }

  missile thread toma_strike_watch_stuck(explosiontype, vectortoangles(bombinginfo.initvelocity), gettime(), bombinginfo.initvelocity);
  missile.killcament thread toma_strike_move_killcam(var_63160bef0a2103d3, killcamendpos);
}

function function_6153b8a392d10771(groundexplodepos, var_63d5339e498e6f77, stuckto, owner, starttime, streakinfo) {
  level endon("game_ended");
  self.exploding = 1;
  groundexplodeent = toma_strike_create_explosion(groundexplodepos, var_63d5339e498e6f77, stuckto, owner, starttime, streakinfo);
  groundexplodeent.killcament = self.killcament;
  explodepart = "explode_large";

  if(istrue(self.waterimpact)) {
    explodepart += "_water";
  }

  groundexplodeent setscriptablepartstate(explodepart, "active", 0);

  if(isDefined(self.explodeent)) {
    self.explodeent delete();
  }

  self delete();
  function_2284137aa92dbd16(3);

  if(isDefined(groundexplodeent)) {
    if(isDefined(groundexplodeent.killcament)) {
      groundexplodeent.killcament delete();
    }

    groundexplodeent delete();
  }
}

function function_441a028592c3ca77(airexplosionpos) {
  self endon("death");
  self.exploding = 1;
  self.explodeent unlink();
  self.explodeent.origin = airexplosionpos;
  self.explodeent setscriptablepartstate("explode", "active", 0);
  thread toma_strike_delay_hide();
  function_2284137aa92dbd16(3);

  if(isDefined(self.explodeent)) {
    self.explodeent delete();
  }

  if(isDefined(self.minimapid)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self delete();
}

function toma_strike_delay_hide() {
  self endon("death");
  wait 0.05;
  self setscriptablepartstate("visibility", "hide", 0);
}

function toma_strike_watch_owner() {
  self endon("missile_empd");
  self endon("death");
  self endon("missile_dest_succeed");
  owner = self.owner;
  owner waittill("disconnect");

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  setmissileminimapvisiblesharedfunc(0);
  thread function_441a028592c3ca77(self.origin);
  self notify("missile_dest_failed");
}

function function_dd555baddc036858() {
  self endon("death");
  owner = self.owner;
  owner endon("disconnect");

  while(true) {
    if(istrue(owner.ksempd)) {
      self notify("missile_empd");

      if(isDefined(self.killcament)) {
        self.killcament delete();
      }

      setmissileminimapvisiblesharedfunc(0);
      thread function_441a028592c3ca77(self.origin);
      self notify("missile_dest_failed");
      break;
    }

    waitframe();
  }
}

function toma_strike_watch_airexplosion(airexplosionpos, entityhit, entityhittype, explosiondelay) {
  self endon("death");
  self endon("missile_dest_failed");
  self endon("missile_dest_succeed");
  function_2284137aa92dbd16(explosiondelay);
  setmissileminimapvisiblesharedfunc(0);

  if(!isDefined(airexplosionpos)) {
    airexplosionpos = self.origin;
  }

  thread function_441a028592c3ca77(airexplosionpos);

  if(isDefined(entityhit) && isDefined(entityhittype) && entityhittype == "flying") {
    entityhit dodamage(500, airexplosionpos, self.owner, self, "MOD_EXPLOSIVE", makeweapon(level.var_d2a6e2899c72649b));
  }
}

function toma_strike_move_killcam(timetounlink, endpos) {
  if(isDefined(self)) {
    self endon("death");
    function_2284137aa92dbd16(timetounlink);
    self unlink();
    self moveTo(endpos, 5);
    function_2284137aa92dbd16(7);
    self delete();
  }
}

function toma_strike_watch_stuck(explosiontype, launchangles, launchtimems, launchvelocity) {
  self endon("death");
  self endon("missile_dest_failed");
  stuckto = function_7ef768a282337b03();
  tomastrikeicontype = getdvarint(@ "hash_2cfbf02c634789ea", 1);

  if(tomastrikeicontype == 0) {
    setmissileminimapvisiblesharedfunc(0);
  } else {
    setmissileminimapvisiblesharedfunc(1);
  }

  if(isDefined(self.minimapid)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  if(explosiontype != 1 && gettime() - launchtimems < self.var_70b761d63979e102 * 1000) {
    thread function_441a028592c3ca77(self.origin);
    self notify("missile_dest_failed");
    return;
  }

  wait 0.05;
  gravityaccel = -1 * getdvarint(@ "bg_gravity", 800);
  traveltime = (gettime() - launchtimems) / 1000;
  impactvelocity = launchvelocity + (0, 0, gravityaccel * traveltime);

  if(isDefined(stuckto) && isPlayer(stuckto)) {
    toma_strike_stuck_player(explosiontype, self, stuckto, launchangles, impactvelocity);
  } else {
    toma_strike_stuck(explosiontype, stuckto, launchangles, impactvelocity);
  }

  self notify("missile_dest_succeed");
}

function function_7ef768a282337b03() {
  self endon("death");
  self endon("missile_dest_failed");
  impactinfo = function_675ba1ee79efdc70("missile_stuck", "missile_water_impact");

  if(isDefined(level.var_ca1a76fbc0ba0bef)) {
    thread[[level.var_ca1a76fbc0ba0bef]](self.streakinfo, self.origin, 0);
  }

  stuckto = undefined;

  if(isDefined(impactinfo)) {
    if(impactinfo.msg == "missile_stuck") {
      stuckto = impactinfo.param1;
    } else if(impactinfo.msg == "missile_water_impact") {
      self.waterimpact = 1;
    }
  }

  return stuckto;
}

function toma_strike_stuck(explosiontype, stuckto, launchangles, impactvelocity) {
  angles = undefined;
  forward = vectorNormalize(impactvelocity);
  up = anglestoup(self.angles);
  right = anglestoright(launchangles);

  if(istrue(self.waterimpact)) {
    up = (0, 0, 1);
  }

  if(abs(vectordot(forward, up)) >= 0.9848) {
    angles = toma_strike_rebuild_angles_up_right(up, right);
  } else {
    angles = toma_strike_rebuild_angles_up_forward(up, forward);
  }

  self.angles = angles;

  if(explosiontype == 1) {
    thread function_6153b8a392d10771(self.origin, angles, stuckto, self.owner, gettime(), self.streakinfo);
    return;
  }

  thread toma_strike_launch_cluster(self, self.origin, angles, stuckto, gettime());
}

function toma_strike_stuck_player(explosiontype, grenade, stuckto, launchangles, impactvelocity) {
  impactvelocity *= (0, 0, 1);
  caststart = grenade.origin;
  castdir = (0, 0, -1);
  castend = caststart + castdir * 128;
  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  castresults = physics_raycast(caststart, castend, contents, grenade, 0, "physicsquery_closest", 1);

  if(isDefined(castresults) && castresults.size > 0) {
    castend = castresults[0]["position"];
    casthitnorm = castresults[0]["normal"];
    casthitent = castresults[0]["entity"];
    castend -= casthitnorm * 1;
    gravityaccel = -1 * getdvarint(@ "bg_gravity", 800);
    d = vectordot(castend - caststart, castdir);
    t = sqrt(2 * d / -1 * gravityaccel);
    up = casthitnorm;
    right = anglestoright(launchangles);
    impactangles = toma_strike_rebuild_angles_up_right(up, right);

    if(explosiontype == 1) {
      thread function_6153b8a392d10771(self.origin, impactangles, stuckto, self.owner, gettime(), self.streakinfo);
      return;
    }

    thread toma_strike_launch_cluster(grenade, castend, impactangles, casthitent, gettime() + t * 1000);
  }
}

function toma_strike_launch_cluster(grenade, impactorigin, impactangles, impactent, impacttime) {
  owner = grenade.owner;
  killcament = grenade.killcament;
  impactnormal = anglestoup(impactangles);
  caststart = impactorigin + impactnormal * 1;
  castend = caststart + impactnormal * 25;
  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  castresults = physics_raycast(caststart, castend, contents, grenade, 0, "physicsquery_closest", 1);

  if(isDefined(castresults) && castresults.size > 0) {
    castend = castresults[0]["position"] - impactnormal * 1;
  }

  borigin = castend;
  shareddata = toma_strike_get_shared_data(owner, grenade.streakinfo, impacttime, killcament);
  castdata = toma_strike_get_cast_data();
  branch = toma_strike_create_branch(shareddata, castdata, undefined, borigin, impactangles, impactent, 0, undefined, undefined);
  shareddata.branches[shareddata.branches.size] = branch;
  branch.killcament = killcament;
  forward = anglesToForward(impactangles);
  right = anglestoright(impactangles);
  up = anglestoup(impactangles);
  bforward = rotatepointaroundvector(up, forward, 30);
  bright = vectorNormalize(vectorcross(bforward, up));
  bup = vectorcross(bright, forward);
  bangles = axistoangles(bforward, bright, bup);
  castdata = toma_strike_get_cast_data();
  branch = toma_strike_create_branch(shareddata, castdata, undefined, borigin, bangles, impactent, 0, undefined, undefined);
  branch.killcament = killcament;
  shareddata.branches[shareddata.branches.size] = branch;
  bforward = rotatepointaroundvector(up, forward, -30);
  bright = vectorNormalize(vectorcross(bforward, up));
  bup = vectorcross(bright, forward);
  bangles = axistoangles(bforward, bright, bup);
  castdata = toma_strike_get_cast_data();
  branch = toma_strike_create_branch(shareddata, castdata, undefined, borigin, bangles, impactent, 0, undefined, undefined);
  branch.killcament = killcament;
  shareddata.branches[shareddata.branches.size] = branch;
  shareddata toma_strike_shared_data_register_cast();

  foreach(branch in shareddata.branches) {
    branch thread toma_strike_start_branch();
  }
}

function toma_strike_start_branch() {
  killcament = self.killcament;

  if(issharedfuncdefined("<dev string:x1c>", "<dev string:x2b>")) {
    self thread[[getsharedfunc("<dev string:x1c>", "<dev string:x2b>")]]();
  }

  if(!isDefined(self.preventstarttime)) {
    self.preventstarttime = gettime();
  }

  if(!isDefined(self.startingcasttype)) {
    if(!self.shareddata toma_strike_shared_data_is_complete()) {
      explent = toma_strike_branch_create_explosion(self.startingorigin, self.startingangles, self.startingstuckto, self.shareddata.streakinfo);
      explent.killcament = killcament;
      explent thread toma_strike_start_explosion();
      self.iscomplete = 1;
      self.shareddata toma_strike_shared_data_is_complete(1);

      self.hitpositions[self.hitpositions.size] = self.startingorigin;
      self.hittypes[self.hittypes.size] = 1;
    }

    return;
  }

  self.caststart = self.startingorigin;
  self.castend = undefined;
  self.castangles = self.startingangles;
  self.castdir = undefined;
  self.casttype = self.startingcasttype;
  self.startingorigin = undefined;
  self.startingangles = undefined;
  self.startingcasttype = undefined;

  while(true) {
    if(self.shareddata toma_strike_shared_data_is_complete()) {
      break;
    }

    if(toma_strike_branch_is_complete()) {
      break;
    }

    if(!self.shareddata toma_strike_shared_data_can_cast_this_frame()) {
      waitframe();
      continue;
    }

    if(self.casttype == 0) {
      firstforwardmodanglesfunc = self.castdata.firstforwardmodanglesfunc;

      if(isDefined(firstforwardmodanglesfunc)) {
        self.castangles = [[firstforwardmodanglesfunc]](self.castangles);
        self.castdata.firstforwardmodanglesfunc = undefined;
      }
    }

    self.castdir = toma_strike_get_cast_dir(self.castangles, self.casttype);
    self.castend = self.caststart + self.castdir * toma_strike_get_cast_dist(self.casttype, self.castdata);
    casthit = undefined;
    casthitpos = undefined;
    casthitnorm = undefined;
    casthitent = undefined;
    casthitangles = undefined;
    castresults = physics_raycast(self.caststart, self.castend, self.shareddata.castcontents, undefined, 0, "physicsquery_closest", 1);

    if(isDefined(castresults) && castresults.size > 0) {
      casthit = 1;
      casthitpos = castresults[0]["position"];
      casthitnorm = castresults[0]["normal"];
      casthitent = castresults[0]["entity"];
    }

    switch (self.casttype) {
      case 0:
        if(istrue(casthit)) {
          toma_strike_branch_register_cast(self.casttype, 0, casthitpos);
          shouldcreateexplosion = 1;

          if(isDefined(self.castdata.firstforwarddist)) {
            castvec = casthitpos - self.caststart;
            castdist = vectordot(castvec, self.castdir);
            self.castdata.firstforwarddist -= castdist;

            if(self.castdata.firstforwarddist > self.castdata.firstforwardmindist) {
              shouldcreateexplosion = 0;
            } else {
              self.castdata.firstforwarddist = undefined;
            }
          }

          casthitangles = toma_strike_rebuild_angles_up_right(casthitnorm, anglestoright(self.castangles));

          if(shouldcreateexplosion) {
            explent = toma_strike_branch_create_explosion(casthitpos, casthitangles, casthitent, self.shareddata.streakinfo);
            explent.killcament = killcament;
            explent thread toma_strike_start_explosion();
          }

          self.casttype = 2;
          self.caststart = casthitpos + casthitnorm * 1;
          self.castangles = casthitangles;
        } else {
          toma_strike_branch_register_cast(self.casttype, undefined, undefined);

          if(isDefined(self.castdata.firstforwarddist)) {
            castvec = self.castend - self.caststart;
            castdist = vectordot(castvec, self.castdir);
            self.castdata.firstforwarddist -= castdist;

            if(self.castdata.firstforwarddist <= self.castdata.firstforwardmindist) {
              self.castdata.firstforwarddist = undefined;
            }
          }

          self.casttype = 1;
          self.caststart = self.castend;
        }

        break;
      case 1:
        if(istrue(casthit)) {
          casthitangles = toma_strike_rebuild_angles_up_right(casthitnorm, anglestoright(self.castangles));
          explent = toma_strike_branch_create_explosion(casthitpos, casthitangles, casthitent, self.shareddata.streakinfo);
          explent.killcament = killcament;
          explent thread toma_strike_start_explosion();
          normdot = vectordot(anglestoup(self.castangles), casthitnorm);

          if(normdot < 0.9848) {
            toma_strike_branch_register_cast(self.casttype, 2, casthitpos);
            self.casttype = 2;
            self.caststart = casthitpos + casthitnorm * 1;
            self.castangles = casthitangles;
          } else {
            toma_strike_branch_register_cast(self.casttype, 1, casthitpos);
            self.casttype = 0;
          }
        } else {
          toma_strike_branch_register_cast(self.casttype, undefined, undefined);
          self.caststart = self.castend;
        }

        break;
      case 2:
        if(istrue(casthit)) {
          toma_strike_branch_register_cast(self.casttype, 3, casthitpos);
          self.casttype = 0;
          self.caststart = casthitpos + casthitnorm * 1;
        } else {
          toma_strike_branch_register_cast(self.casttype, undefined, undefined);
          self.casttype = 0;
        }

        break;
    }

    waittillframeend();
  }

  self.iscomplete = 1;
  self.shareddata toma_strike_shared_data_is_complete(1);
  self.shareddata.branches = [];
}

function toma_strike_branch_create_explosion(origin, angles, stuckto, streakinfo) {
  delayms = 50;

  if(true) {
    delayms = randomintrange(50, 350);
  }

  starttime = self.preventstarttime + delayms;
  ent = toma_strike_create_explosion(origin + anglestoup(angles), angles, stuckto, self.shareddata.owner, starttime, streakinfo);
  self.preventstarttime = starttime;
  self.ents[self.ents.size] = ent;
  self.shareddata toma_strike_shared_data_register_ent();
  return ent;
}

function toma_strike_create_explosion(origin, angles, stuckto, owner, starttime, streakinfo) {
  bundle = isDefined(level.streakglobals.streakbundles["toma_strike"]) ? level.streakglobals.streakbundles["toma_strike"] : {
    #var_3a1a5610b3e228c0: undefined
  };
  ent = spawn("script_model", origin);
  ent.angles = angles;
  ent.stuckto = stuckto;
  ent.owner = owner;
  ent.starttime = starttime;
  ent.streakinfo = streakinfo;
  ent setModel(isDefined(bundle.var_3a1a5610b3e228c0) ? bundle.var_3a1a5610b3e228c0 : "ks_toma_strike_cluster_mp");
  ent setotherent(owner);
  ent setentityowner(owner);

  if(isDefined(stuckto)) {
    ent linkTo(stuckto);
  }

  return ent;
}

function toma_strike_start_explosion() {
  self endon("death");
  self.owner endon("disconnect");
  self.owner endon("joined_team");

  if(isDefined(self.stuckto)) {
    self.stuckto endon("death");
  }

  while(gettime() < self.starttime) {
    waitframe();
  }

  thread toma_strike_explosion_end();
}

function toma_strike_explosion_end() {
  self setscriptablepartstate("explode", "active", 0);
  wait 1;
  self delete();
}

function toma_strike_shared_data_register_cast() {
  self.caststotal++;
  self.caststhisframe++;
  self.frametimestamp = gettime();
}

function toma_strike_shared_data_register_ent() {
  self.entstotal++;
}

function toma_strike_shared_data_can_cast_this_frame() {
  if(self.frametimestamp < gettime()) {
    self.frametimestamp = gettime();
    self.caststhisframe = 0;
  }

  return self.caststhisframe < 3;
}

function toma_strike_shared_data_is_complete(var_af8745e2185687a8) {
  iscomplete = 0;

  if(self.caststotal >= 60) {
    iscomplete = 1;
  } else if(self.entstotal >= 20) {
    iscomplete = 1;
  } else if(istrue(var_af8745e2185687a8)) {
    var_3ce5d6eb962629fa = 1;

    foreach(branch in self.branches) {
      if(!branch toma_strike_branch_is_complete()) {
        var_3ce5d6eb962629fa = 0;
        break;
      }
    }

    if(var_3ce5d6eb962629fa) {
      iscomplete = 1;
    }
  }

  if(iscomplete) {
    self.iscomplete = 1;
  }

  return iscomplete;
}

function toma_strike_branch_register_cast(casttype, casthittype, hitposition) {
  self.shareddata toma_strike_shared_data_register_cast();
  self.casts++;

  if(isDefined(casthittype)) {
    if(casthittype == 0 || casthittype == 1 || casthittype == 2) {
      self.castfails = 0;
    }
  } else if(casttype == 1) {
    self.castfails++;
  }

  debugmsg = undefined;

  if(isDefined(casthittype)) {
    debugmsg = undefined;

    switch (casthittype) {
      case 0:
        debugmsg = "<dev string:x47>";
        break;
      case 1:
        debugmsg = "<dev string:x56>";
        break;
      case 2:
        debugmsg = "<dev string:x62>";
        break;
      case 3:
        debugmsg = "<dev string:x75>";
        break;
    }

    self.hitpositions[self.hitpositions.size] = hitposition;
    self.hittypes[self.hittypes.size] = casthittype;
  } else {
    switch (casttype) {
      case 0:
        debugmsg = "<dev string:x7f>";
        break;
      case 1:
        debugmsg = "<dev string:x8a>";
        break;
      case 2:
        debugmsg = "<dev string:x97>";
        break;
    }
  }

  if(istrue(level.var_4482770c326f1498)) {
    if(isDefined(debugmsg)) {
      println(debugmsg);
    }
  }

}

function toma_strike_branch_is_complete(var_af8745e2185687a8) {
  iscomplete = 0;
  var_3ce5d6eb962629fa = undefined;

  if(self.shareddata toma_strike_shared_data_is_complete()) {
    iscomplete = 1;
  } else if(isDefined(self.castdata) && self.castfails >= self.castdata.maxfails) {
    iscomplete = 1;
  } else if(isDefined(self.castdata) && self.casts >= self.castdata.maxcasts) {
    iscomplete = 1;
  } else if(isDefined(self.castdata) && self.ents.size >= self.castdata.maxents) {
    iscomplete = 1;
  } else if(istrue(var_af8745e2185687a8)) {
    var_3ce5d6eb962629fa = 1;

    foreach(branch in self.branches) {
      if(!branch toma_strike_branch_is_complete()) {
        var_3ce5d6eb962629fa = 0;
        break;
      }
    }

    if(var_3ce5d6eb962629fa) {
      iscomplete = 1;
    }
  }

  if(iscomplete && !istrue(self.iscomplete)) {
    oncompletedfunc = self.oncompletedfunc;

    if(isDefined(oncompletedfunc)) {
      self[[oncompletedfunc]]();
    }

    println("<dev string:x9d>");

    if(istrue(var_3ce5d6eb962629fa)) {
      iscomplete = 0;

      foreach(branch in self.branches) {
        if(!branch toma_strike_branch_is_complete()) {
          var_3ce5d6eb962629fa = 0;
          break;
        }
      }

      if(var_3ce5d6eb962629fa) {
        iscomplete = 1;
      }
    }
  }

  if(iscomplete) {
    self.iscomplete = 1;
  }

  return iscomplete;
}

function toma_strike_create_branch(shareddata, castdata, parent, startingorigin, startingangles, startingstuckto, startingcasttype, preventstarttime, oncompletedfunc) {
  branch = spawnStruct();
  branch.shareddata = shareddata;
  branch.castdata = castdata;
  branch.startingorigin = startingorigin;
  branch.startingangles = startingangles;
  branch.startingstuckto = startingstuckto;
  branch.startingcasttype = startingcasttype;
  branch.oncompletedfunc = oncompletedfunc;
  branch.ents = [];
  branch.branches = [];
  branch.hitpositions = [];
  branch.hittypes = [];
  branch.casts = 0;
  branch.castfails = 0;
  branch.preventstarttime = preventstarttime;
  return branch;
}

function toma_strike_get_shared_data(owner, streakinfo, impacttime, killcament) {
  shareddata = spawnStruct();
  shareddata.owner = owner;
  shareddata.team = owner.team;
  shareddata.streakinfo = streakinfo;
  shareddata.impacttime = impacttime;
  shareddata.branches = [];
  shareddata.entstotal = 0;
  shareddata.caststotal = 0;
  shareddata.caststhisframe = 0;
  shareddata.frametimestamp = gettime();
  shareddata.castcontents = physics_createcontents(["physicscontents_missileclip", "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_vehicle"]);
  return shareddata;
}

function toma_strike_get_cast_data() {
  castdata = spawnStruct();
  castdata.distforward = 125;
  castdata.distdown = 50;
  castdata.distup = 25;
  castdata.maxcasts = 12;
  castdata.maxfails = 3;
  castdata.maxents = 4;
  return castdata;
}

function toma_strike_get_cast_dir(angles, casttype) {
  switch (casttype) {
    case 0:
      return anglesToForward(angles);
    case 1:
      return (-1 * anglestoup(angles));
    case 2:
      return anglestoup(angles);
  }

  return undefined;
}

function toma_strike_get_cast_dist(casttype, castdata) {
  switch (casttype) {
    case 0:
      if(isDefined(castdata.firstforwarddist)) {
        return castdata.firstforwarddist;
      } else {
        return castdata.distforward;
      }
    case 1:
      return castdata.distdown;
    case 2:
      return castdata.distup;
  }

  return undefined;
}

function toma_strike_rebuild_angles_up_right(up, right) {
  forward = vectorNormalize(vectorcross(up, right));
  right = vectorcross(forward, up);
  return axistoangles(forward, right, up);
}

function toma_strike_rebuild_angles_up_forward(up, forward) {
  right = vectorNormalize(vectorcross(forward, up));
  forward = vectorcross(up, right);
  return axistoangles(forward, right, up);
}

function toma_strike_setmarkerobjective(objid, icon, owner, offset) {
  if(issp()) {
    return;
  }

  objective_icon(objid, icon);
  objective_showtoplayersinmask(objid);
  objective_addclienttomask(objid, owner);
  objective_onentity(objid, self);
  objective_setzoffset(objid, offset);
  objective_setplayintro(objid, 0);
  objective_setplayoutro(objid, 0);
  objective_setbackground(objid, 1);

  if(level.teambased) {
    objective_setownerteam(objid, owner.team);
  } else {
    objective_setownerclient(objid, owner);
  }

  objective_state(objid, "current");
}

function toma_strike_handlemarkerscriptable() {
  self endon("death");
  self setscriptablepartstate("target", "on", 0);
  function_2284137aa92dbd16(10);

  if(isDefined(self)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](self.objidnum);
    }

    self delete();
  }
}

function tomastrike_findoptimallaunchpos(markerorigin, ownerlookforward, ownerforward, ownerright) {
  contents = scripts\engine\trace::create_default_contents(1);
  trace = scripts\engine\trace::ray_trace(markerorigin - ownerlookforward * 30, markerorigin + ownerlookforward * 1000, undefined, contents);
  coord = trace["position"] + trace["normal"] * 20;
  targetpos = coord;
  targetheightoffset = 5000;
  targetforwardoffset = 5000;
  positionchecklist = [targetpos + ownerforward * 100, targetpos - ownerforward * 100, targetpos + ownerright * 100, targetpos - ownerright * 100, targetpos + (ownerforward + ownerright) * 100, targetpos + (ownerforward - ownerright) * 100, targetpos + (ownerright - ownerforward) * 100, targetpos + (-1 * ownerforward - ownerright) * 100];
  defaultlaunchdir = vectorNormalize(positionchecklist[0] - targetpos);
  bestlaunchpos = targetpos + (0, 0, targetheightoffset) - defaultlaunchdir * targetforwardoffset;

  foreach(dirpos in positionchecklist) {
    direction = vectorNormalize(dirpos - targetpos);
    starttracepos = targetpos + (0, 0, targetheightoffset) - direction * targetforwardoffset;
    endtracepos = targetpos;
    traceresult = scripts\engine\trace::ray_trace_passed(starttracepos, endtracepos, undefined, contents);

    if(!istrue(traceresult)) {
      continue;
    }

    bestlaunchpos = starttracepos;
    break;
  }

  return bestlaunchpos;
}