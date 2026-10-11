/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\killstreaks\loitering_munition.gsc
*********************************************************/

#using script_608c50392df8c7d1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace loitering_munition;

function autoexec main() {
  registerkillstreakinitfunction(getxhash("loitering_munition"), &init);
}

function private init() {
  if(issharedfuncdefined("killstreak", "registerKillstreak")) {
    [[getsharedfunc("killstreak", "registerKillstreak")]]("loitering_munition", &function_10fd15ea1cbf20d7);
  }

  if(issharedfuncdefined("loitering_munition", "init")) {
    [[getsharedfunc("loitering_munition", "init")]]();
  }

  utility::registersharedfunc("loitering_munition", "loiteringMunition_droneGunEmpApplied", &loiteringmunition_dronegunempapplied, 1);
  function_bef8cd415537722d();
  function_f127f9d5fb83d16f();
  function_ffabcdb2f67fa01();
}

function function_bef8cd415537722d() {
  level.var_e6abdc44c5b61710 = [];
  level.var_c4ad491a88892d7d = 0;

  foreach(teamname in level.teamnamelist) {
    level.var_a666d88720d5075e[teamname] = 0;
  }
}

function function_f127f9d5fb83d16f() {
  game["dialog"]["loitering_munition" + "_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["loitering_munition" + "_leave"] = "killstreak_remote_operator" + "_leave";
  game["dialog"]["loitering_munition" + "_crash"] = "killstreak_remote_operator" + "_crash";
  game["dialog"]["loitering_munition" + "_confirm"] = "killstreak_remote_operator" + "_confirm_general";
}

function function_ffabcdb2f67fa01() {
  setdvarifuninitialized(@ "hash_63717c2d49096cc0", 0);
  setdvarifuninitialized(@ "hash_ebfeaea6f20a1405", 30);
  setdvarifuninitialized(@ "hash_172e95433cf0b88e", 350);
  setdvarifuninitialized(@ "hash_cf8d560a06e3c99a", 12);
  setdvarifuninitialized(@ "hash_c7de055e8594d50d", 5);
  setdvarifuninitialized(@ "hash_78f9a29ffb7613a4", 6);
  setdvarifuninitialized(@ "hash_58038edaa16cb940", 10000);
  setdvarifuninitialized(@ "hash_9b0622c0db71da50", 6500);
  setdvarifuninitialized(@ "hash_d24a6beafc09520d", 4000);
  setdvarifuninitialized(@ "hash_d19ff3129783aaaa", 600);
  setdvarifuninitialized(@ "hash_eb1b674b807cfef7", 65);
  setdvarifuninitialized(@ "hash_8a2477633227e955", 12);
  setdvarifuninitialized(@ "hash_370e4d3dc0144183", 20);
  setdvarifuninitialized(@ "hash_42b452745ffc05e8", 10);
  setdvarifuninitialized(@ "hash_ef3d77b4896f28bd", 20);
  setdvarifuninitialized(@ "hash_c636877e41fa349a", 5000);
  setdvarifuninitialized(@ "hash_27c3395ed27ae0da", 1);
}

function function_383626d0aa423226(streakinfo) {
  if(issharedfuncdefined("killstreak", "startMapSelectSequence")) {
    self[[getsharedfunc("killstreak", "startMapSelectSequence")]](undefined, undefined, undefined, undefined, streakinfo);
  }

  return true;
}

function function_10fd15ea1cbf20d7(streakinfo) {
  if(!isDefined(streakinfo)) {
    streakinfo = createstreakinfo("loitering_munition", self);
  }

  return function_6f3c393ac15fff72(streakinfo);
}

function function_6f3c393ac15fff72(streakinfo) {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }

    return false;
  }

  team = self.team;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    return false;
  }

  if(isDefined(level.activekillstreaks)) {
    foreach(streak in level.activekillstreaks) {
      if(streak.owner != self) {
        continue;
      }

      switch (streak.streakname) {
        case #"hash_bf2f9adbd2b41d5":
          if(issharedfuncdefined("hud", "showErrorMessage")) {
            [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
          }

          return false;
      }
    }
  }

  result = function_84453b5bca0b00e2(streakinfo);

  if(!istrue(result)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  self notify("munitions_used", "loitering_munition");
  return true;
}

function function_84453b5bca0b00e2(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  if(isPlayer(self)) {
    deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, makeweapon("ks_remote_map_mp"), 1, &function_383626d0aa423226);
  } else {
    deployresult = 1;
  }

  if(!istrue(deployresult)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  mappointinfo = undefined;
  bundle = level.streakglobals.streakbundles["loitering_munition"];

  if(isPlayer(self)) {
    if(issharedfuncdefined("killstreak", "getSelectMapPoint")) {
      mappointinfo = self[[getsharedfunc("killstreak", "getSelectMapPoint")]](streakinfo, 3);
    }
  } else if(isDefined(self.enemy)) {
    mappointinfo = self.enemy.origin;
  } else {
    var_b987c81fa3701ba2 = self.origin;
  }

  streakinfo.owner notify("killstreak_deploy_finished", streakinfo.streakname);

  if(!isDefined(mappointinfo)) {
    return false;
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");
  loitering_munition = function_4db4fc3b03545fc2(streakinfo, mappointinfo);

  if(!isDefined(loitering_munition)) {
    return false;
  }

  maxrolldegrees = getdvarint(@ "hash_eb1b674b807cfef7");
  maxyawdiff = getdvarint(@ "hash_8a2477633227e955");
  var_38a541b4d6af30a9 = getdvarint(@ "hash_370e4d3dc0144183");
  var_9d60d851a7af2d4e = getdvarint(@ "hash_42b452745ffc05e8");
  var_2a86c82583ac927b = getdvarint(@ "hash_ef3d77b4896f28bd");
  loitering_munition thread function_62c1c6833c19817c(maxrolldegrees, maxyawdiff);
  loitering_munition thread function_74f5ba869b257143(var_38a541b4d6af30a9, var_9d60d851a7af2d4e, var_2a86c82583ac927b);
  loitering_munition thread function_43297bd0e3598dc5();

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    loitering_munition[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_de63e0c45173a927);
  }

  if(isPlayer(self)) {
    var_52a5be2e2f91d710 = undefined;

    if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
      var_52a5be2e2f91d710 = 2;
    }

    thread playkillstreakoperatordialog("loitering_munition", "loitering_munition" + "_use", 1, var_52a5be2e2f91d710);
    utility::trycall(level.matchdata_logkillstreakevent, "loitering_munition", self.origin);

    if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      self thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + "loitering_munition", self);
    }
  }

  return true;
}

function function_4db4fc3b03545fc2(streakinfo, mappointinfo) {
  bundle = level.streakglobals.streakbundles["loitering_munition"];

  if(isarray(mappointinfo)) {
    if(mappointinfo.size == 1) {
      maplocation = mappointinfo[0].location;
    } else {
      xvalue = 0;
      yvalue = 0;
      zvalue = 0;

      foreach(mappoint in mappointinfo) {
        xvalue += mappoint.location[0];
        yvalue += mappoint.location[1];
        zvalue += mappoint.location[2];
      }

      xvalue /= mappointinfo.size;
      yvalue /= mappointinfo.size;
      zvalue /= mappointinfo.size;
      maplocation = (xvalue, yvalue, zvalue);
    }
  } else {
    maplocation = mappointinfo;
  }

  droneflyheight = getdvarint(@ "hash_9b0622c0db71da50");
  var_a5dd4bcdfac5c613 = getdvarint(@ "hash_58038edaa16cb940");

  if(istrue(bundle.var_ee82a52d1d3eaf91) && isDefined(bundle.var_caac57476330e68c) && bundle.var_caac57476330e68c.size > 0) {
    foreach(map in bundle.var_caac57476330e68c) {
      if(issubstr(level.mapname, map.name)) {
        if(isDefined(map.var_de509f5295976bb4)) {
          droneflyheight += map.var_de509f5295976bb4;
          zoffset = map.var_de509f5295976bb4;
        }

        break;
      }
    }
  }

  var_46517af2dcdd1619 = getdvarint(@ "hash_d24a6beafc09520d");
  spawnpathstart = (maplocation[0], maplocation[1], droneflyheight) + (var_46517af2dcdd1619, 0, 0) + (0, var_a5dd4bcdfac5c613, 0);
  var_6b43387e451b23c7 = bundle.var_562c96bcc5cb13ac;
  loitering_munition = spawn("script_model", spawnpathstart + (0, 0, droneflyheight));

  if(!isDefined(loitering_munition)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  loitering_munition setModel(var_6b43387e451b23c7);
  loitering_munition.owner = self;
  loitering_munition.team = self.team;
  loitering_munition.health = 999999;
  loitering_munition.maxhealth = bundle.maxhealth;
  loitering_munition.currenthealth = loitering_munition.maxhealth;
  loitering_munition.streakinfo = streakinfo;
  loitering_munition.streakname = streakinfo.streakname;
  loitering_munition.flaresreservecount = bundle.var_94b105020336a135;
  loitering_munition.entrylocation = loitering_munition.origin;
  loitering_munition.maplocation = maplocation;
  loitering_munition.targetlocations = mappointinfo;

  if(isDefined(zoffset)) {
    loitering_munition.zoffset = zoffset;
  }

  loitering_munition setscriptablepartstate("blinking_lights", "on", 0);
  loitering_munition setscriptablepartstate("thrusters", "active", 0);
  loitering_munition setscriptablepartstate("contrails", "on", 0);
  loitering_munition.killcament = spawn("script_model", loitering_munition gettagorigin("tag_turret"));
  loitering_munition.killcament linkTo(loitering_munition, "tag_origin", (-500, 0, 500), (0, 0, 0));
  level.var_e6abdc44c5b61710[level.var_e6abdc44c5b61710.size] = loitering_munition;

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    loitering_munition[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", self, 0, 1, 100);
  }

  if(issharedfuncdefined("game", "createObjective")) {
    loitering_munition.minimapid = loitering_munition[[getsharedfunc("game", "createObjective")]](bundle.minimapicon, loitering_munition.team, undefined, 1, 1);
  }

  loitering_munition.centerpos = (maplocation[0], maplocation[1], droneflyheight);
  loitering_munition.startpos = loitering_munition.centerpos + (var_46517af2dcdd1619, 0, 0);
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  var_f8ed036dd833070a = 0;

  if(isDefined(heightent)) {
    var_f8ed036dd833070a = heightent.origin[2] + 750;
  }

  loitering_munition.flyheight = droneflyheight;
  loitering_munition.attackheight = var_f8ed036dd833070a;

  if(issharedfuncdefined("damage", "monitorDamage")) {
    loitering_munition thread[[getsharedfunc("damage", "monitorDamage")]](loitering_munition.maxhealth, "hitequip", &function_66a7440055d386c3, &function_9190a53712ac6557, 0);
  }

  loitering_munition function_63d1a11f8b22244(streakinfo, undefined, &function_ab26c91383cb6029);
  return loitering_munition;
}

function function_43297bd0e3598dc5() {
  var_4659ac69102900ff = getdvarint(@ "hash_c7de055e8594d50d");
  self moveTo(self.startpos, var_4659ac69102900ff, var_4659ac69102900ff * 0.1, 2);
  self setscriptablepartstate("movement_sfx", "enter", 0);
  wait var_4659ac69102900ff;
  thread function_a6e6d62bd87beaae();
}

function function_a6e6d62bd87beaae() {
  level endon("game_ended");
  bundle = level.streakglobals.streakbundles["loitering_munition"];
  flyvelocity = getdvarint(@ "hash_d19ff3129783aaaa");
  thread function_1694bb799481d4d9(self.centerpos, self.startpos, flyvelocity);

  if(isPlayer(self.owner)) {
    thread function_deb2b377a055cca2();
  } else {
    if(issubstr(self.owner.agent_type, "maestro")) {
      if(isDefined(level.exgm.bossparameters["Maestro"].warlordparameters)) {
        params = level.exgm.bossparameters["Maestro"].warlordparameters;
      }

      thread callsharedfunc("warlord_maestro", "loiteringDeathMonitor", self);
    }

    thread function_9b0f13da4e5d2aa2(params);
  }

  thread function_9cf03ad1c46c99ba();
  thread function_deb2ff6757e3f032();

  if(isPlayer(self.owner)) {
    var_48ed56ece1e9c39 = bundle.var_dc4c4ad00e024744;
    thread function_b36b89b7443ed55c(var_48ed56ece1e9c39);
  }

  thread function_8ccbdcb7c4391a3e();

  if(issharedfuncdefined("flares", "handleIncomingStinger")) {
    self thread[[getsharedfunc("flares", "handleIncomingStinger")]](&function_7828ae21b80db901);
  }
}

function function_1694bb799481d4d9(centerpos, startpos, flyvelocity) {
  self notify("flyingNewCircle");
  self endon("death");
  self endon("flyingNewCircle");
  self endon("diveBombStart");
  self endon("leaveSequence");
  self endon("moveToLocation");
  level endon("game_ended");
  anglevector = centerpos - startpos;
  flyradius = distance(startpos, centerpos);
  totaltime = float(6.28 * flyradius / flyvelocity) * 1000;
  starttime = gettime();
  startangle = 0;
  endangle = -180;

  while(true) {
    timepassed = gettime() - starttime;
    assert(totaltime > 0);
    fraction = min(timepassed / totaltime, 1);
    var_fb338f3adaa14f2c = math::angle_lerp(startangle, endangle, fraction);
    newvector = rotatevector(anglevector, (0, var_fb338f3adaa14f2c, 0));
    newpos = centerpos - newvector;
    self.origin = newpos;

    if(fraction == 1) {
      starttime = gettime();
      anglevector = newvector;
    }

    waitframe();
  }
}

function function_9cf03ad1c46c99ba() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_b7550113928779b5 = self.owner;
  bundle = level.streakglobals.streakbundles["loitering_munition"];
  self.missilefireside = undefined;
  armdelay = getdvarint(@ "hash_27c3395ed27ae0da");
  wait armdelay;

  if(isPlayer(var_b7550113928779b5)) {
    hintref = &"KILLSTREAKS_HINTS/LOITERING_MUNITION_HINT_3";
    function_e68434bdb941ed1e(self.streakinfo.streakname, self.owner, hintref, 1);
    self.useobj setuseholdduration(100);
    self.useobj setCursorHint("HINT_NOICON");
    self.owner playsoundtoplayer("kls_loitering_munition_ready_beep", self.owner);
  }

  while(true) {
    self.useobj waittill("trigger", player);
    self.owner playsoundtoplayer("kls_loitering_munition_location_move_confirm", self.owner);

    if(!isreallyalive(self.owner)) {
      continue;
    }

    if(!isDefined(self.ismoving) || !istrue(self.ismoving)) {
      if(isPlayer(var_b7550113928779b5)) {
        function_3f55c1fb553a4775(self.owner, self.useobj, 1);
      }

      function_4ffdf897638f08bd();
    }
  }
}

function function_9b0f13da4e5d2aa2(ai_params) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  while(true) {
    while(!isDefined(self.owner.enemy)) {
      wait 2;
    }

    thread function_b17ae5fa4c850521(1, self.owner.enemy, ai_params);
    delay = ai_params.var_a78135ca02e63469;
    wait delay;
  }
}

function function_4ffdf897638f08bd() {
  self notify("attackSequence_started");
  bundle = level.streakglobals.streakbundles["loitering_munition"];
  totalswoops = bundle.var_c0b748698c447651;
  var_5f115cdf23e1676d = bundle.var_8742511635165b49;

  if(!isDefined(self.var_4c4d6e577c688eb2)) {
    self.var_4c4d6e577c688eb2 = 0;
  }

  self playsoundonmovingent("kls_loitering_munition_dive");
  targetlocation = function_e603f6eeea780ef2();
  thread function_b17ae5fa4c850521(1, targetlocation);
  function_9b1ccbca322b8707(targetlocation);
  flyvelocity = getdvarint(@ "hash_d19ff3129783aaaa");
  self.startpos = self.origin;
  self.var_4c4d6e577c688eb2++;
  thread function_1694bb799481d4d9(self.centerpos, self.startpos, flyvelocity);
  wait var_5f115cdf23e1676d;

  if(self.var_4c4d6e577c688eb2 >= totalswoops) {
    function_6ba72911f4a2d09b(1);
    return;
  }

  if(self.var_4c4d6e577c688eb2 == 1) {
    hintref = &"KILLSTREAKS_HINTS/LOITERING_MUNITION_HINT_2";
    self.owner playsoundtoplayer("kls_loitering_munition_ready_beep", self.owner);
  } else {
    hintref = &"KILLSTREAKS_HINTS/LOITERING_MUNITION_HINT_1";
    self.owner playsoundtoplayer("kls_loitering_munition_ready_beep", self.owner);
  }

  self.useobj setHintString(hintref);
  function_17576a4cdcd447a7(self.owner);
}

function function_e603f6eeea780ef2() {
  if(self.targetlocations.size == 1) {
    return self.targetlocations[0];
  }

  bundle = level.streakglobals.streakbundles["loitering_munition"];
  missileradius = bundle.var_eec8a18ac19421ef;
  contentoverride = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  radius = 16;
  height = 64;
  heightvector = (0, 0, height);
  getsurfacetype = 0;
  var_a993d59bb6e4abd2 = [];
  targetindex = 0;

  if(istrue(level.teambased)) {
    enemyteam = get_enemy_team(self.owner.team);
  } else {
    enemyteam = ["allies", "axis"];
  }

  foreach(location in self.targetlocations) {
    targetlist = getplayersandaiarrayinradius(location.location, missileradius, enemyteam);
    index = var_a993d59bb6e4abd2.size;
    var_a993d59bb6e4abd2[index] = 0;

    foreach(ent in targetlist) {
      trace = scripts\engine\trace::capsule_trace(self.origin, ent.origin, radius, height, (0, 0, 0), [], contentoverride, getsurfacetype);

      if(getdvarint(@ "hash_aa7e6ce09e5c3a10", 0) == 1) {
        var_34fb5f21bc6e423d = self.origin;
        var_3292b1174fe87384 = ent.origin;
        var_bc8dc8693bdfd6f5 = var_34fb5f21bc6e423d + heightvector;
        var_db689ed52d5f374c = var_3292b1174fe87384 + heightvector;
        function_90a556e6f70ba1e5(var_34fb5f21bc6e423d, var_3292b1174fe87384, radius);
        function_90a556e6f70ba1e5(var_bc8dc8693bdfd6f5, var_db689ed52d5f374c, radius);
      }

      if(trace["hittype"] != "hittype_world") {
        var_a993d59bb6e4abd2[index] += 1;
        continue;
      }

      var_a993d59bb6e4abd2[index] += 2;
    }

    if(!isDefined(targetindex) || var_a993d59bb6e4abd2[index] > var_a993d59bb6e4abd2[targetindex]) {
      targetindex = index;
    }
  }

  return self.targetlocations[targetindex].location;
}

function function_9b1ccbca322b8707(targetlocation) {
  self notify("diveBombStart");
  divestartposition = self.origin;
  diveheight = 3250;
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

  if(isDefined(heightent)) {
    diveheight = heightent.origin[2];
  }

  if(!isDefined(targetlocation)) {
    targetlocation = self.centerpos;
  }

  var_7e19d0c0148b19e9 = (targetlocation[0], targetlocation[1], diveheight);
  circlemidpoint = divestartposition - (divestartposition - var_7e19d0c0148b19e9) / 2;
  divetime = getdvarint(@ "hash_c636877e41fa349a");
  var_c3fec9b95b46dd6b = divetime / 2;
  elapsedtime = 0;
  var_3806086dd5fdeed6 = 1.6;
  var_7c63520eb7e18880 = 1.6;
  divestarttime = gettime();

  while(elapsedtime < divetime) {
    elapsedtime = gettime() - divestarttime;
    var_e7a3675855463c39 = 0;

    if(elapsedtime < var_c3fec9b95b46dd6b) {
      var_e7a3675855463c39 = elapsedtime / var_c3fec9b95b46dd6b;
      verticalcomponent = vectorlerp(divestartposition, var_7e19d0c0148b19e9, easepower(var_e7a3675855463c39, var_3806086dd5fdeed6, 1, 0));
    } else {
      var_e7a3675855463c39 = (elapsedtime - var_c3fec9b95b46dd6b) / var_c3fec9b95b46dd6b;
      verticalcomponent = vectorlerp(var_7e19d0c0148b19e9, divestartposition, easepower(var_e7a3675855463c39, var_3806086dd5fdeed6, 1, 1));
    }

    var_c679688b48e87c37 = easepower(elapsedtime / divetime, var_7c63520eb7e18880, 1, 1);
    var_fb260238a1374a21 = (0, math::lerp(360, 0, var_c679688b48e87c37), 0);
    anglevector = divestartposition - circlemidpoint;
    circlecomponent = circlemidpoint + rotatevector(anglevector, var_fb260238a1374a21);
    self.origin = (circlecomponent[0], circlecomponent[1], verticalcomponent[2]);
    waitframe();
  }
}

function function_b17ae5fa4c850521(delaytime, targetoverride, ai_params) {
  self endon("death");
  level endon("game_ended");
  bundle = level.streakglobals.streakbundles["loitering_munition"];
  var_942eea14d031c96a = bundle.var_be180dad16337504;
  var_de379aee30fead15 = bundle.var_e62e108574ec8584;
  missileradius = bundle.var_eec8a18ac19421ef;
  var_9052e244d25ee16c = 3;

  if(isDefined(delaytime)) {
    wait delaytime;
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.owner) && !isPlayer(self.owner)) {
    if(isDefined(ai_params)) {
      var_942eea14d031c96a = ai_params.var_973aa26aca2df1b5;
      var_de379aee30fead15 = ai_params.var_7cbd0c1c8a409888;
      missileradius = ai_params.var_b191f50cd3d7ea7a;
      var_9052e244d25ee16c = ai_params.var_5a29d4a844609c83;
    }
  }

  var_bf137eb6a362469 = ceil(float(var_942eea14d031c96a - 1) / float(var_9052e244d25ee16c));
  var_dbb85cb998808bd5 = missileradius / var_bf137eb6a362469;
  radiusbuffer = var_dbb85cb998808bd5 * 0.2;
  var_cebc3efa503855f5 = 360 / var_9052e244d25ee16c;
  anglebuffer = var_cebc3efa503855f5 * 0.2;
  thread function_c7ee8ae86699fdf1(radiusbuffer, var_dbb85cb998808bd5 - radiusbuffer, 0, 360, targetoverride);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_de379aee30fead15);

  for(var_e27f175749f1e185 = 1; var_e27f175749f1e185 < var_bf137eb6a362469; var_e27f175749f1e185++) {
    if(!isDefined(self)) {
      return;
    }

    var_976e58552e422f88 = var_e27f175749f1e185 * var_dbb85cb998808bd5 + radiusbuffer;
    var_716c81cf71cd941d = var_976e58552e422f88 + var_dbb85cb998808bd5 - radiusbuffer;
    var_fa80af920013741e = min(var_9052e244d25ee16c, var_942eea14d031c96a - 1 - (var_e27f175749f1e185 - 1) * var_9052e244d25ee16c);

    for(var_4e33f5f3a5777266 = 0; var_4e33f5f3a5777266 < var_fa80af920013741e; var_4e33f5f3a5777266++) {
      startangle = var_4e33f5f3a5777266 * var_cebc3efa503855f5 + anglebuffer;
      endangle = (var_4e33f5f3a5777266 + 1) * var_cebc3efa503855f5 - anglebuffer;
      thread function_c7ee8ae86699fdf1(var_976e58552e422f88, var_716c81cf71cd941d, startangle, endangle, targetoverride, var_4e33f5f3a5777266);
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_de379aee30fead15);
    }
  }
}

function function_c7ee8ae86699fdf1(startradius, endradius, startangle, endangle, targetoverride, missilenum) {
  bundle = level.streakglobals.streakbundles["loitering_munition"];
  randomradius = randomintrange(int(startradius), int(endradius));
  randomangle = (0, randomintrange(int(startangle), int(endangle)), 0);

  if(isDefined(targetoverride)) {
    if(isvector(targetoverride)) {
      radiuscenter = targetoverride;
    } else if(isDefined(targetoverride.origin)) {
      radiuscenter = targetoverride.origin;
    } else {
      radiuscenter = self.centerpos;
    }
  } else {
    radiuscenter = self.centerpos;
  }

  anglevector = (randomradius, 0, 0);
  anglevector = rotatevector(anglevector, randomangle);
  targetvector = radiuscenter + anglevector;
  targetvector = (targetvector[0], targetvector[1], 0);

  if(isDefined(self.zoffset)) {
    targetvector += (0, 0, self.zoffset);
  }

  if(!isDefined(missilenum)) {
    missilenum = 1;
  }

  index = missilenum % 4 + 1;
  self setscriptablepartstate("fire_missile_" + index, "off", 0);
  self setscriptablepartstate("fire_missile_" + index, "on", 0);
  thread function_d922267e4ad96226(targetvector);
  self playSound("kls_loitering_munition_fire");
}

function function_d922267e4ad96226(targetlocation) {
  bundle = level.streakglobals.streakbundles["loitering_munition"];
  firedirection = vectorNormalize(targetlocation - self.origin);
  missilestart = self.origin + firedirection * 250;
  missile_ref = bundle.var_b5798e1a5232bfed;
  missile = _magicbullet(makeweapon(missile_ref), missilestart, targetlocation, self.owner);
  missile.streakinfo = self.streakinfo;
  missile playsoundonmovingent("kls_loitering_munition_proj_travel");
  missile.killcament = spawn("script_model", missile.origin);
  missile.killcament linkTo(missile, "tag_origin", (-100, 0, 500), (0, 0, 0));
  missile.killcament thread function_82b1fd06b2e37252(targetlocation, missile.angles);
  missile thread function_769e917ac9e39efa(targetlocation);
  missile thread function_9e19665e571e16ad(self.owner, 2, 300, 300);
  self notify("fired_missile", missile);
  debugactive = getdvarint(@ "hash_63717c2d49096cc0");

  debugduration = getdvarint(@ "hash_ebfeaea6f20a1405");

  if(istrue(debugactive)) {
    line(missilestart, targetlocation, (255, 0, 0), 1, 0, debugduration);
  }
}

function function_769e917ac9e39efa(missiletargetpos) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(isDefined(self)) {
    self missile_settargetpos(missiletargetpos);
  }
}

function function_9e19665e571e16ad(owner, lifetime, radius, height) {
  owner endon("disconnect");
  level endon("game_ended");
  self waittill("explode", position);
  owner notify("loitering_munition_rocket_impact", position);

  if(issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[getsharedfunc("spawn", "addSpawnDangerZone")]](position, radius, height, owner.team, lifetime, owner, 1);
  }
}

function function_82b1fd06b2e37252(impactlocation, missileangles) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self unlink();
  self moveTo(impactlocation - anglesToForward(missileangles) * 750, 6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

function function_66e849b2e19dcfbf(missileindex) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("fire_missile_" + missileindex, "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  self setscriptablepartstate("fire_missile_" + missileindex, "off", 0);
}

function function_7828ae21b80db901(player, missileteam, missiletarget, fxtagoverride) {
  self endon("death");
  missiletarget endon("death");
  missiletarget endon("crashing");
  level endon("game_ended");

  while(true) {
    if(!isDefined(missiletarget) || !isDefined(missiletarget.flaresreservecount)) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < 4000 && missiletarget.flaresreservecount > 0) {
      if(issharedfuncdefined("flares", "reduceReserves")) {
        [[getsharedfunc("flares", "reduceReserves")]](missiletarget);
      }

      if(issharedfuncdefined("flares", "playFx")) {
        missiletarget thread[[getsharedfunc("flares", "playFx")]]("jet_flares", fxtagoverride);
      }

      newtarget = undefined;

      if(issharedfuncdefined("flares", "deploy")) {
        newtarget = missiletarget[[getsharedfunc("flares", "deploy")]]();
      }

      if(issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        missiletarget[[getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](player);
      }

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function function_c43bc3874ebb495c() {
  self endon("death");
  self endon("leaving");
  level endon("game_ended");

  while(isDefined(self.useobj)) {
    timeused = 0;
    self.useobj waittill("trigger", player);

    if(player isusingremote()) {
      continue;
    }

    self setscriptablepartstate("thrusters", "active", 0);

    debugon = getdvarint(@ "hash_63717c2d49096cc0");

    if(isDefined(debugon) && debugon) {
      player iprintlnbold("<dev string:x1c>");
    }

    if(isDefined(player)) {
      goalposition = (player.origin[0], player.origin[1], self.origin[2]);
      thread function_17ff76d29019fb07(goalposition);
    }
  }
}

function function_17ff76d29019fb07(targetpos) {
  self notify("moveToLocation");
  self.ismoving = 1;
  function_3f55c1fb553a4775(self.owner, self.useobj);
  flyradius = getdvarfloat(@ "hash_d24a6beafc09520d");
  flyvelocity = getdvarfloat(@ "hash_d19ff3129783aaaa");
  movestartpos = self.origin;
  self.centerpos = targetpos;
  self.startpos = self.centerpos + vectorNormalize(movestartpos - self.centerpos) * flyradius;
  movedistance = distance(targetpos, movestartpos);
  movetime = movedistance / flyvelocity;
  self moveTo(self.startpos, movetime);
  wait movetime;
  self.ismoving = 0;
  function_17576a4cdcd447a7(self.owner);
  thread function_1694bb799481d4d9(self.centerpos, self.startpos, flyvelocity);
  wait 0.5;
}

function function_b36b89b7443ed55c(lifetime) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(lifetime);
  playkillstreakoperatordialog("loitering_munition", "loitering_munition" + "_leave", 1);
  thread function_6ba72911f4a2d09b(0);
}

function function_deb2ff6757e3f032() {
  self endon("death");
  level waittill("game_ended");
  self.recordedgameendstats = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
}

function function_deb2b377a055cca2() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  thread function_72fe13a5b1035c50("disconnect");
  thread function_72fe13a5b1035c50("joined_team");
}

function function_72fe13a5b1035c50(notifymsg) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner waittill(notifymsg);
  thread function_6ba72911f4a2d09b(0);
}

function function_6ba72911f4a2d09b(hastriggered) {
  bundle = level.streakglobals.streakbundles["loitering_munition"];
  function_3f55c1fb553a4775(self.owner, self.useobj);

  if(!istrue(hastriggered) && istrue(bundle.var_4707e64d9d8605d7)) {
    targetlocation = function_e603f6eeea780ef2();
    thread function_b17ae5fa4c850521(1, targetlocation);
    function_9b1ccbca322b8707(targetlocation);
  }

  self notify("leaveSequence");
  var_77b76ae62f912bb0 = getdvarint(@ "hash_78f9a29ffb7613a4");
  exitlocation = self.origin + anglesToForward(self.angles) * 10000;
  self moveTo(exitlocation, var_77b76ae62f912bb0, 1);
  self setscriptablepartstate("movement_sfx", "exit", 0);
  wait var_77b76ae62f912bb0;
  function_fe6411544dd4c6f8(0);
}

function function_8ccbdcb7c4391a3e() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  thread function_7df983371cd48d23();
  self setscriptablepartstate("thrusters", "idle", 0);
}

function function_9190a53712ac6557(data) {
  if(!isDefined(self.currenthealth)) {
    self.currenthealth = self.maxhealth;
  }

  modifieddamage = function_7bdb3610d602438d(data);
  bundle = level.streakglobals.streakbundles["loitering_munition"];

  if(isDefined(bundle) && istrue(bundle.var_30ffeba5007cf73f)) {
    modifieddamage = self[[getsharedfunc("killstreak", "getModifiedDamageUsingDamageTuning")]](data.attacker, data.objweapon, data.meansofdeath, modifieddamage, self.maxhealth, bundle.var_e913079a5ffda56d);
  }

  self.currenthealth -= modifieddamage;
  killstreak_updatedamagestate(self.currenthealth);
  return modifieddamage;
}

function function_6e2ef534469c7d9a() {
  self setscriptablepartstate("body_damage_light", "on");
}

function function_20bc864cde4580cf() {
  self setscriptablepartstate("body_damage_medium", "on");
}

function function_4e8f651c045cd5bf() {
  self setscriptablepartstate("body_damage_heavy", "on");
}

function function_7df983371cd48d23() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("missile_fire", projectile);
    projectile.streakinfo = self.streakinfo;
    projectile.killcament = self.killcament;
  }
}

function function_ab26c91383cb6029() {
  self notify("explode");
  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  thread function_fe6411544dd4c6f8(1);
}

function function_fe6411544dd4c6f8(wasdestroyed) {
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(!isDefined(self)) {
    return;
  }

  self setscriptablepartstate("blinking_lights", "off", 0);
  self setscriptablepartstate("thrusters", "off", 0);
  self.streakinfo.expiredbydeath = istrue(wasdestroyed);

  if(!istrue(self.recordedgameendstats)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  level.var_e6abdc44c5b61710 = array_remove(level.var_e6abdc44c5b61710, self);

  if(isDefined(self.minimapid)) {
    if(issharedfuncdefined("game", "returnObjectiveID")) {
      [[getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  level callback::callback("killstreak_finish_use", {
    #streakinfo: self.streakinfo
  });
  self delete();
}

function function_de63e0c45173a927(data) {
  if(isDefined(self)) {
    thread function_ab26c91383cb6029();
  }
}

function loiteringmunition_dronegunempapplied(data) {
  self endon("death");
  self notify("loitering_mini_emp_hit");
  self endon("loitering_mini_emp_hit");
  childthread function_e4fc57397c1b18d0();

  if(self.flaresreservecount > 0 && (!isDefined(self.var_e8d88b601e41fba5) || self.var_e8d88b601e41fba5 <= gettime() - 10000)) {
    if(!isDefined(self.var_e8d88b601e41fba5)) {
      self.var_e8d88b601e41fba5 = gettime();
    }

    if(issharedfuncdefined("flares", "reduceReserves")) {
      [[getsharedfunc("flares", "reduceReserves")]](self);
    }

    if(issharedfuncdefined("flares", "playFx")) {
      self thread[[getsharedfunc("flares", "playFx")]]("jet_flares");
    }

    if(issharedfuncdefined("flares", "deploy")) {
      self[[getsharedfunc("flares", "deploy")]]();
    }

    if(issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
      self[[getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](data.attacker);
    }

    if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]]("emped_killstreak");
    }
  }
}

function function_e4fc57397c1b18d0() {
  function_3f55c1fb553a4775(self.owner, self.useobj);
  wait 3;

  if(isDefined(self) && isDefined(self.owner)) {
    function_17576a4cdcd447a7(self.owner);
  }
}

function function_90a556e6f70ba1e5(raycaststart, raycastend, radius) {
  duration = 100;
  red = (255, 0, 0);
  green = (0, 255, 0);
  blue = (0, 0, 255);
  sphere(raycaststart, radius, red, 0, duration);
  sphere(raycastend, radius, blue, 0, duration);
  line(raycaststart, raycastend, green, 1, 0, duration);
}

function function_c50a1e52a02c0164(aabbmin, aabbmax, duration) {
  self notify("<dev string:x3e>");
  level endon("<dev string:x57>");
  self endon("<dev string:x65>");
  self endon("<dev string:x3e>");
  drawcolor = (0, 255, 0);
  var_eb404bf9ac5040f0 = (aabbmax[0] - aabbmin[0], 0, 0);
  var_a6c378e90c169b15 = (0, aabbmax[1] - aabbmin[1], 0);
  var_5b9a5467ae4bf353 = (0, 0, aabbmax[2] - aabbmin[2]);
  line(aabbmin, aabbmin + (aabbmax - aabbmin) / 2, drawcolor, 1, 0, duration);
  line(aabbmin, aabbmin + var_eb404bf9ac5040f0, drawcolor, 1, 0, duration);
  line(aabbmin, aabbmin + var_a6c378e90c169b15, drawcolor, 1, 0, duration);
  line(aabbmin, aabbmin + var_5b9a5467ae4bf353, drawcolor, 1, 0, duration);
  sphere(aabbmin, 5, drawcolor, 0, duration);
  drawcolor = (255, 0, 0);
  line(aabbmax, aabbmax + (aabbmin - aabbmax) / 2, drawcolor, 1, 0, duration);
  line(aabbmax, aabbmax - var_eb404bf9ac5040f0, drawcolor, 1, 0, duration);
  line(aabbmax, aabbmax - var_a6c378e90c169b15, drawcolor, 1, 0, duration);
  line(aabbmax, aabbmax - var_5b9a5467ae4bf353, drawcolor, 1, 0, duration);
  sphere(aabbmax, 5, drawcolor, 0, duration);
}

# /