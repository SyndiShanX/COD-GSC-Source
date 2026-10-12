/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\killstreaks\loitering_munition.gsc
******************************************************/



#using script_608c50392df8c7d1;
#using scripts\common\utility;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\airstrike;
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
  setdvarifuninitialized(@ "hash_c5f0368d419f8310", 1000);
  setdvarifuninitialized(@ "hash_83ba042d81b2b120", 45);
  setdvarifuninitialized(@ "hash_e3ab68c71611ce49", 1);
  setdvarifuninitialized(@ "hash_172e95433cf0b88e", 350);
  setdvarifuninitialized(@ "hash_cf8d560a06e3c99a", 12);
  setdvarifuninitialized(@ "hash_c7de055e8594d50d", 3);
  setdvarifuninitialized(@ "hash_78f9a29ffb7613a4", 3);
  setdvarifuninitialized(@ "hash_9b0622c0db71da50", 5500);
  setdvarifuninitialized(@ "hash_d24a6beafc09520d", 3000);
  setdvarifuninitialized(@ "hash_d19ff3129783aaaa", 500);
  setdvarifuninitialized(@ "hash_eb1b674b807cfef7", 65);
  setdvarifuninitialized(@ "hash_8a2477633227e955", 12);
  setdvarifuninitialized(@ "hash_370e4d3dc0144183", 20);
  setdvarifuninitialized(@ "hash_42b452745ffc05e8", 10);
  setdvarifuninitialized(@ "hash_ef3d77b4896f28bd", 20);
  setdvarifuninitialized(@ "hash_c636877e41fa349a", 5000);
  setdvarifuninitialized(@ "hash_27c3395ed27ae0da", 1);
  setdvarifuninitialized(@ "hash_b51efdad28c50ea2", 400);
  setdvarifuninitialized(@ "hash_6857560fa901c7b2", 3);
  setdvarifuninitialized(@ "hash_5e1222e42a107858", 10);
  setdvarifuninitialized(@ "hash_f5ca68385a8223bd", 2);
  setdvarifuninitialized(@ "hash_7f01901e93aa8023", 0.3);
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
  team = self.team;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    return false;
  }

  level.var_c4ad491a88892d7d++;
  var_5dff9ede4f9dd559 = 1;

  if(islargemap()) {
    var_5dff9ede4f9dd559 = 2;
  }

  if(level.var_e6abdc44c5b61710.size >= var_5dff9ede4f9dd559 || level.var_e6abdc44c5b61710.size + level.var_c4ad491a88892d7d > var_5dff9ede4f9dd559) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      if(isPlayer(self)) {
        [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }
    }

    level.var_c4ad491a88892d7d--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  if(islargemap() && level.teambased) {
    var_8c9491b09f17c452 = 1;
    level.var_a666d88720d5075e[team]++;

    if(getnumactivekillstreakperteam(team, level.var_e6abdc44c5b61710) + level.var_a666d88720d5075e[team] > var_8c9491b09f17c452) {
      level.var_c4ad491a88892d7d--;
      level.var_a666d88720d5075e[team]--;

      if(issharedfuncdefined("hud", "showErrorMessage")) {
        [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_LOITERING_MUNITION");
      }

      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  result = function_84453b5bca0b00e2(streakinfo);
  level.var_c4ad491a88892d7d--;

  if(islargemap() && level.teambased) {
    level.var_a666d88720d5075e[team]--;
  }

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

  if(isPlayer(self)) {
    if(issharedfuncdefined("killstreak", "getSelectMapPoint")) {
      mappointinfo = self[[getsharedfunc("killstreak", "getSelectMapPoint")]](streakinfo, 1);
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
  if(isarray(mappointinfo)) {
    maplocation = mappointinfo[0].location;
  } else {
    maplocation = mappointinfo;
  }

  droneflyheight = getdvarint(@ "hash_9b0622c0db71da50");
  var_a5dd4bcdfac5c613 = 10000;
  direction = scripts\cp_mp\killstreaks\airstrike::callstrike_findoptimaldirection(self, maplocation, droneflyheight, var_a5dd4bcdfac5c613);
  spawnpathstart = maplocation - var_a5dd4bcdfac5c613 * direction;
  var_6b43387e451b23c7 = "jup_misc_loitering_munitions_mp";
  loitering_munition = spawn("script_model", spawnpathstart + (0, 0, droneflyheight));

  if(!isDefined(loitering_munition)) {
    return;
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  loitering_munition setModel(var_6b43387e451b23c7);
  loitering_munition.owner = self;
  loitering_munition.team = self.team;
  loitering_munition.health = 999999;
  loitering_munition.maxhealth = getdvarint(@ "hash_c5f0368d419f8310");
  loitering_munition.currenthealth = loitering_munition.maxhealth;
  loitering_munition.streakinfo = streakinfo;
  loitering_munition.streakname = streakinfo.streakname;
  loitering_munition.entrylocation = loitering_munition.origin;
  loitering_munition.entrydirection = direction;
  loitering_munition.maplocation = maplocation;
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
    loitering_munition.minimapid = loitering_munition[[getsharedfunc("game", "createObjective")]]("icon_killstreak_hover_jet_small", loitering_munition.team, 1, 1, 1);
  }

  var_46517af2dcdd1619 = getdvarint(@ "hash_d24a6beafc09520d");
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
  self moveTo(self.startpos, var_4659ac69102900ff, var_4659ac69102900ff * 0.1, var_4659ac69102900ff * 0.3);
  self setscriptablepartstate("movement_sfx", "enter", 0);
  wait var_4659ac69102900ff;
  thread function_a6e6d62bd87beaae();
}

function function_a6e6d62bd87beaae() {
  level endon("game_ended");
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
    var_48ed56ece1e9c39 = getdvarint(@ "hash_83ba042d81b2b120");
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

  if(isPlayer(var_b7550113928779b5)) {
    var_b7550113928779b5 thread function_de9902ea1186bf33();
    var_b7550113928779b5 notifyonplayercommand("loitering_munition_trigger", "+loitering_munition_trigger");
  }

  self.missilefireside = undefined;
  armdelay = getdvarint(@ "hash_27c3395ed27ae0da");
  wait armdelay;

  if(isPlayer(var_b7550113928779b5)) {
    isusinggamepad = self.owner is_player_gamepad_enabled();
    hintref = &"KILLSTREAKS_HINTS/LOITERING_MUNITION_KBM_HINT";

    if(istrue(isusinggamepad)) {
      hintref = &"KILLSTREAKS_HINTS/LOITERING_MUNITION_CONTROLLER_HINT";
    }

    function_e68434bdb941ed1e(self.streakinfo.streakname, self.owner, hintref, 1);
    self.useobj setuseholdduration(250);
    self.useobj setCursorHint("HINT_NOICON");
    thread function_c43bc3874ebb495c();
  }

  while(true) {
    var_b7550113928779b5 waittill("loitering_munition_trigger");

    if(!isDefined(self.ismoving) || !istrue(self.ismoving)) {
      if(isPlayer(var_b7550113928779b5)) {
        function_3f55c1fb553a4775(self.owner, self.useobj);
      }

      thread function_4ffdf897638f08bd();
      break;
    }
  }

  var_b7550113928779b5 notifyonplayercommandremove("loitering_munition_trigger", "+loitering_munition_trigger");
}

function function_de9902ea1186bf33() {
  self endon("attackSequence_started");
  self notifyonplayercommand("LStickPress", "+breath_sprint");
  self notifyonplayercommand("LStickPress", "+actionslot 1");
  self notifyonplayercommand("RStickPress", "+melee_zoom");
  self notifyonplayercommand("RStickPress", "+stance");
  self.var_51c7406d8d778871 = 0;
  self.var_f159ccc5cfa778c3 = 0;
  thread function_1b61a9122d01d5f9();
  thread function_3a3177c4efb62a9f();

  while(true) {
    if(istrue(self.var_51c7406d8d778871) && istrue(self.var_f159ccc5cfa778c3)) {
      self notify("loitering_munition_trigger");
    }

    waitframe();
  }
}

function function_1b61a9122d01d5f9() {
  while(true) {
    self waittill("LStickPress");
    self.var_51c7406d8d778871 = 1;
    wait 0.1;
    self.var_51c7406d8d778871 = 0;
    waitframe();
  }
}

function function_3a3177c4efb62a9f() {
  while(true) {
    self waittill("RStickPress");
    self.var_f159ccc5cfa778c3 = 1;
    wait 0.1;
    self.var_f159ccc5cfa778c3 = 0;
    waitframe();
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
  totalswoops = getdvarint(@ "hash_6857560fa901c7b2");
  var_5f115cdf23e1676d = getdvarfloat(@ "hash_f5ca68385a8223bd");

  for(var_aaced5265eda4ac9 = 0; var_aaced5265eda4ac9 < totalswoops; var_aaced5265eda4ac9++) {
    self playsoundonmovingent("kls_loitering_munition_dive");
    thread function_b17ae5fa4c850521(1);
    function_9b1ccbca322b8707();
    flyvelocity = getdvarint(@ "hash_d19ff3129783aaaa");
    self.startpos = self.origin;
    thread function_1694bb799481d4d9(self.centerpos, self.startpos, flyvelocity);
    wait var_5f115cdf23e1676d;
  }

  function_6ba72911f4a2d09b(1);
}

function function_9b1ccbca322b8707() {
  self notify("diveBombStart");
  divestartposition = self.origin;
  diveheight = 3250;
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

  if(isDefined(heightent)) {
    diveheight = heightent.origin[2];
  }

  var_7e19d0c0148b19e9 = (self.centerpos[0], self.centerpos[1], diveheight);
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
  var_942eea14d031c96a = getdvarint(@ "hash_5e1222e42a107858");
  var_de379aee30fead15 = getdvarfloat(@ "hash_7f01901e93aa8023");
  missileradius = getdvarint(@ "hash_b51efdad28c50ea2");
  var_9052e244d25ee16c = 3;

  if(isDefined(delaytime)) {
    wait delaytime;
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
  randomradius = randomintrange(int(startradius), int(endradius));
  randomangle = (0, randomintrange(int(startangle), int(endangle)), 0);

  if(isDefined(targetoverride)) {
    if(isvector(targetoverride)) {
      radiuscenter = targetoverride;
    } else if(isDefined(targetoverride.origin)) {
      radiuscenter = targetoverride.origin;
    } else {
      var_b210de76083c5b0a = self.centerpos;
    }
  } else {
    radiuscenter = self.centerpos;
  }

  anglevector = (randomradius, 0, 0);
  anglevector = rotatevector(anglevector, randomangle);
  targetvector = radiuscenter + anglevector;
  targetvector = (targetvector[0], targetvector[1], 0);

  if(!isDefined(missilenum)) {
    missilenum = 1;
  }

  index = missilenum % 4 + 1;
  self setscriptablepartstate("fire_missile_" + index, "off", 0);
  self setscriptablepartstate("fire_missile_" + index, "on", 0);
  thread function_d922267e4ad96226(targetvector);
}

function function_d922267e4ad96226(targetlocation) {
  firedirection = vectorNormalize(targetlocation - self.origin);
  missilestart = self.origin + firedirection * 250;
  missile_ref = ter_op(utility::iscp(), "loitering_munition_proj_mp", "loitering_munition_proj_mp");
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
    if(!isDefined(missiletarget)) {
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
  if(!istrue(hastriggered)) {
    var_e07710f2160dc2ca = getdvarint(@ "hash_e3ab68c71611ce49");

    if(istrue(var_e07710f2160dc2ca)) {
      function_9b1ccbca322b8707();
    }
  }

  self notify("leaveSequence");
  var_77b76ae62f912bb0 = getdvarint(@ "hash_78f9a29ffb7613a4");
  self moveTo(self.entrylocation, var_77b76ae62f912bb0);
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

  self setscriptablepartstate("blinking_lights", "off", 0);
  self setscriptablepartstate("thrusters", "off", 0);
  var_b7550113928779b5 = self.owner;
  var_b7550113928779b5 notifyonplayercommandremove("LStickPress", "+breath_sprint");
  var_b7550113928779b5 notifyonplayercommandremove("LStickPress", "+actionslot 1");
  var_b7550113928779b5 notifyonplayercommandremove("RStickPress", "+melee_zoom");
  var_b7550113928779b5 notifyonplayercommandremove("RStickPress", "+stance");
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

  self delete();
}

function function_c50a1e52a02c0164(aabbmin, aabbmax, duration) {
  self notify("<dev string:x3b>");
  level endon("<dev string:x51>");
  self endon("<dev string:x5c>");
  self endon("<dev string:x3b>");
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