/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\killstreaks\lrad.gsc
***********************************************/

#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using script_608c50392df8c7d1;
#using scripts\common\callbacks;
#using scripts\common\damage_tuning;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\killstreaks\manual_turret;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\mp\objidpoolmanager;
#namespace lrad;

function autoexec main() {
  registerkillstreakinitfunction(getxhash("lrad"), &init);
}

function private init() {
  if(issharedfuncdefined("killstreak", "registerKillstreak")) {
    [[getsharedfunc("killstreak", "registerKillstreak")]]("lrad", &function_5dae574697e78d96);
  }

  scripts\engine\utility::registersharedfunc("lrad", "tryUseKillstreak", &function_5dae574697e78d96);
  scripts\engine\utility::registersharedfunc("lrad", "LRAD_Hack", &lrad_hack);
  bundle = level.streakglobals.streakbundles["lrad"];
  registerkillstreakdamagedealingweaponsharedfunc("lrad", bundle.deployweapon, #"hash_b76b2215370d2700");
  function_1212a209876bcd8d();
  function_795e8013831a046a();
  level.var_2d9a7cb2b0831e1e = 0;
  level.var_23bb4defc5121d06 = [];
  level.var_f22117519609ef3b = [];

  if(game_utility::isbrstylegametype()) {
    devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
    devgui::add_devgui_command("<dev string:x3a>", "<dev string:x46>");
    devgui::function_fe953f000498048f();
  }
}

function function_1212a209876bcd8d() {
  bundle = level.streakglobals.streakbundles["lrad"];

  setdvarifuninitialized(@ "hash_80d0084f17797030", 0);
  setdvarifuninitialized(@ "hash_5f9bf6b2e15e5727", 0);
  setdvarifuninitialized(@ "hash_356ad37ca5f6f115", 1000);

  setdvarifuninitialized(@ "hash_98efcf229168a436", bundle.var_3eda8aab19e89979);
  setdvarifuninitialized(@ "hash_1df62822bd2adee0", bundle.maxhealth);
  setdvarifuninitialized(@ "hash_d7fd0b0d5f62285c", 0.85);
  setdvarifuninitialized(@ "hash_6aa2e155bf9747", 16);
  setdvarifuninitialized(@ "hash_b4d9a80ce75c617", bundle.var_92418e7f80b9d06e);
  setdvarifuninitialized(@ "hash_b27192e0593d2245", bundle.var_904281521b1e0ac8);
  setdvarifuninitialized(@ "hash_791416d97b1899ba", 35);
  setdvarifuninitialized(@ "hash_1676fc44b285c55a", bundle.var_aab9b4935e5811e);
  setdvarifuninitialized(@ "hash_2ef1444b14cdcc27", bundle.var_8432cf9eeaab54a3);
  setdvarifuninitialized(@ "hash_4469252783a3ea7d", bundle.var_8bb5c785be632a16);
  setdvarifuninitialized(@ "hash_dd550cefcbd1712", bundle.maxhealth);
  setdvarifuninitialized(@ "hash_abec145fdf5e6352", 1);
}

function function_795e8013831a046a() {
  game["dialog"]["lrad_ause"] = "ause";
  game["dialog"]["lrad_euse"] = "euse";
  game["dialog"]["lrad_lcra"] = "lcra";
  game["dialog"]["lrad_ltim"] = "ltim";
  game["dialog"]["lrad_earn"] = "earn";
  game["dialog"]["lrad_friendly_online"] = "grdn_grav_kllc";
  game["dialog"]["lrad_friendly_timeout"] = "grdn_grav_ktlt";
}

function function_5dae574697e78d96(streakinfo) {
  if(!isDefined(streakinfo)) {
    streakinfo = createstreakinfo("lrad", self);
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  streakinfo.bundle = level.streakglobals.streakbundles["lrad"];
  streakinfo.weaponname = streakinfo.bundle.deployweapon;

  if(!function_f3cfedd6f1bbfd6f()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/LRAD_COUNT_OVER_LIMIT");
    }

    return false;
  }

  thread function_f2b4b6d178b092d9();
  var_6bec98cb2dcc2450 = function_52132724b2c18dc4(streakinfo);

  if(!isDefined(var_6bec98cb2dcc2450)) {
    return false;
  }

  var_6bec98cb2dcc2450.streakinfo = streakinfo;
  genericblueprintname = function_71efed8bf57f1d39(streakinfo.bundle, var_6bec98cb2dcc2450.streakinfo.mpstreaksysteminfo.blueprintindex);
  var_6bec98cb2dcc2450 function_b383c6eb771d7283(genericblueprintname);

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  maxhealth = getdvarfloat(@ "hash_1df62822bd2adee0");
  function_9469d528dd1ee44d("lrad", "destroyed_lrad", "destroyed_lrad", "callout_destroyed_lrad");

  if(issharedfuncdefined("damage", "monitorDamage")) {
    var_6bec98cb2dcc2450 thread[[getsharedfunc("damage", "monitorDamage")]](maxhealth, "hitequip", &function_66a7440055d386c3, &function_5733afc81f25372c, 1);
  }

  var_6bec98cb2dcc2450 function_e12969da21420075();
  var_6bec98cb2dcc2450 function_18633ad410bdfdfa();
  var_6bec98cb2dcc2450 scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_67a2561dc56ecc0b);
  var_6bec98cb2dcc2450 scripts\cp_mp\emp_debuff::set_start_emp_callback(&function_a054c2c62f34ac14);
  var_6bec98cb2dcc2450 scripts\cp_mp\equipment\haywire::function_aa823a31304ed981(&function_5e06c811fe28148a);
  var_6bec98cb2dcc2450 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&function_43197d230c4d9635);
  var_6bec98cb2dcc2450.colmodel callsharedfunc("escort", "registerEscortCollisionCallback", &function_d4468bb2335b0542);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    var_6bec98cb2dcc2450[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_a054c2c62f34ac14);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    var_6bec98cb2dcc2450[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_43197d230c4d9635);
  }

  thread function_5189f677d1332852(var_6bec98cb2dcc2450, streakinfo);
  thread function_9235bfde9b04fc60(var_6bec98cb2dcc2450, var_6bec98cb2dcc2450.useownerobj);
  maxlifetime = getdvarfloat(@ "hash_98efcf229168a436");
  var_6bec98cb2dcc2450 thread function_47b5394a301d8c5(maxlifetime, @ "hash_80d0084f17797030", &lrad_timeout);
  var_6bec98cb2dcc2450 thread function_e27f64a56913c64b();

  var_6bec98cb2dcc2450 thread function_1defeaf387d6e2a9(@ "hash_80d0084f17797030");

  var_6bec98cb2dcc2450 function_63d1a11f8b22244(streakinfo, &function_136ba4565fe17b8, &lrad_destroy);
  self notify("munitions_used", "lrad");
  self notify("lrad_placed");
  level.var_f22117519609ef3b = array_add(level.var_f22117519609ef3b, var_6bec98cb2dcc2450);

  if(isDefined(level.var_648cfe8e093ab1e)) {
    level thread[[level.var_648cfe8e093ab1e]](self);
  }

  return true;
}

function function_e27f64a56913c64b() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnected");
  self endon("isCarried");
  self.owner waittill("joined_team");
  callback::callback("on_functional_death");
}

function function_f2b4b6d178b092d9(var_6bec98cb2dcc2450) {
  self endon("lrad_placed");
  self endon("lrad_put_away");
  ownerteam = self.team;

  while(true) {
    if(!isreallyalive(self)) {
      level.var_2d9a7cb2b0831e1e--;

      if(isDefined(level.var_23bb4defc5121d06[ownerteam])) {
        level.var_23bb4defc5121d06[ownerteam]--;
      }

      if(isDefined(var_6bec98cb2dcc2450)) {
        var_6bec98cb2dcc2450 lrad_destroy();
      }

      break;
    }

    waitframe();
  }
}

function function_f3cfedd6f1bbfd6f() {
  bundle = level.streakglobals.streakbundles["lrad"];

  if(level.var_f22117519609ef3b.size >= bundle.var_c98e519f70bf4a5f || level.var_f22117519609ef3b.size + level.var_2d9a7cb2b0831e1e > bundle.var_c98e519f70bf4a5f) {
    return false;
  }

  var_25e613b55682a30c = 0;
  var_175fecc960f5f281 = 0;
  var_b3daaaea66bc9eee = 0;

  foreach(lrad in level.var_f22117519609ef3b) {
    if(distance2d(lrad.origin, self.origin) <= bundle.var_4c564e3e500a1723) {
      var_b3daaaea66bc9eee++;
    }

    if(lrad.owner == self) {
      var_175fecc960f5f281++;
      var_25e613b55682a30c++;
      continue;
    }

    if(lrad.team == self.team) {
      var_25e613b55682a30c++;
    }
  }

  if(var_b3daaaea66bc9eee >= bundle.var_6ec1ad14e28e99a1) {
    return false;
  }

  if(isDefined(level.var_23bb4defc5121d06[self.team])) {
    if(var_25e613b55682a30c >= bundle.var_17b7b6fe6675fb64 || var_25e613b55682a30c + level.var_23bb4defc5121d06[self.team] > bundle.var_17b7b6fe6675fb64) {
      return false;
    }
  }

  if(var_175fecc960f5f281 >= bundle.var_479d98641f857668) {
    return false;
  }

  return true;
}

function function_52132724b2c18dc4(streakinfo) {
  self endon("death");
  self endon("disconnect");
  endonnotify = "sentry_placement_failed";
  weaponobj = makeweapon(streakinfo.bundle.deployweapon);

  if(issharedfuncdefined("weapons", "watchForPlacementFireState")) {
    self thread[[getsharedfunc("weapons", "watchForPlacementFireState")]](streakinfo, endonnotify, weaponobj);
  }

  deployresult = streakdeploy_doweaponswitchdeploy(streakinfo, weaponobj, 1, undefined, undefined, &function_5a68b8ee35170bf9);

  if(!istrue(deployresult)) {
    self notify(endonnotify);
    return undefined;
  }

  function_8703bc55951530be(1);
  level.var_2d9a7cb2b0831e1e++;

  if(!isDefined(level.var_23bb4defc5121d06[self.team])) {
    level.var_23bb4defc5121d06[self.team] = 1;
  } else {
    level.var_23bb4defc5121d06[self.team]++;
  }

  var_6bec98cb2dcc2450 = lrad_place(streakinfo);
  function_8703bc55951530be(0);
  return var_6bec98cb2dcc2450;
}

function lrad_place(streakinfo) {
  marker = function_3c44a60f10088e51(streakinfo, 0, 0.25);
  var_6bec98cb2dcc2450 = undefined;

  if(isDefined(marker)) {
    var_6bec98cb2dcc2450 = function_cce8da1f44d40890(marker);

    if(isDefined(marker.moving_platform)) {
      var_6bec98cb2dcc2450.moving_platform = marker.moving_platform;
      var_6bec98cb2dcc2450.moving_platform_offset = marker.moving_platform_offset;
      var_6bec98cb2dcc2450.moving_platform_angles_offset = marker.moving_platform_angles_offset;
      var_6bec98cb2dcc2450 linkTo(marker.moving_platform, "", marker.moving_platform_offset, marker.moving_platform_angles_offset);
    }

    var_6bec98cb2dcc2450.colmodel show();
    var_6bec98cb2dcc2450.colmodel.angles = var_6bec98cb2dcc2450.angles;
    var_6bec98cb2dcc2450.colmodel.origin = var_6bec98cb2dcc2450.origin;
    var_6bec98cb2dcc2450.colmodel linkTo(var_6bec98cb2dcc2450);
    var_6bec98cb2dcc2450 setscriptablepartstate("beam", "active", 0);
    var_6bec98cb2dcc2450 thread function_481e1d72fdaac162();
    var_6bec98cb2dcc2450.vodestroyed = "lrad_teamleader_destroyed";
    var_6bec98cb2dcc2450.streakinfo = streakinfo;
    var_6bec98cb2dcc2450.deletefunc = &function_405ae182beea4b1c;

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      if(issharedfuncdefined("audio", "brLeaderDialogTeam")) {
        level thread[[getsharedfunc("audio", "brLeaderDialogTeam")]]("lrad_friendly_online", var_6bec98cb2dcc2450.owner.team, 1, undefined, undefined, "dx_br_jpbm_");
      }
    } else if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[getsharedfunc("sound", "playKillstreakDeployDialog")]](var_6bec98cb2dcc2450.owner, "lrad");
    }

    if(issharedfuncdefined("game", "handlemovingplatforms")) {
      data = spawnStruct();
      data.deathoverridecallback = &function_405ae182beea4b1c;

      if(isDefined(level.wztrain_info) && isDefined(var_6bec98cb2dcc2450.moving_platform) && scripts\cp_mp\utility\train_utility::is_train_ent(var_6bec98cb2dcc2450.moving_platform)) {
        data.plantedontrain = 1;
      }

      var_6bec98cb2dcc2450 thread[[getsharedfunc("game", "handlemovingplatforms")]](data);
    }
  }

  return var_6bec98cb2dcc2450;
}

function function_18633ad410bdfdfa() {
  self setscriptablepartstate("beam", "active", 0);
  thread function_481e1d72fdaac162();
  thread function_d2368d84391b6a68();
  thread function_9c3226ae596454e6();
}

function function_6402ac006cab5c40() {
  self setscriptablepartstate("beam", "idle", 0);
  self stoploopsound("jup_kls_lrad_beam_outside");
  self notify("beamStop");
}

function function_481e1d72fdaac162() {
  level endon("game_ended");
  self endon("death");
  self.owner endon("disconnected");
  self endon("isCarried");

  if(!isDefined(self.ishaywire) || !istrue(self.ishaywire)) {
    wait 0.6;
  }
}

function function_cce8da1f44d40890(marker, var_6bec98cb2dcc2450) {
  bundle = level.streakglobals.streakbundles["lrad"];
  verticalspawnoffset = getdvarint(@ "hash_6aa2e155bf9747");

  if(!isDefined(var_6bec98cb2dcc2450)) {
    var_6bec98cb2dcc2450 = self launchgrenade(bundle.spawnweapon, marker.location + (0, 0, verticalspawnoffset), (0, 0, 0));

    if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      self thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + "lrad", self);
    }
  } else {
    var_6bec98cb2dcc2450.origin = marker.location + (0, 0, verticalspawnoffset);
  }

  var_6bec98cb2dcc2450.angles = self.angles;
  var_6bec98cb2dcc2450.team = self.team;
  var_6bec98cb2dcc2450.owner = self;
  var_6bec98cb2dcc2450 setentityhudoutlinedata(3, var_6bec98cb2dcc2450.team);
  var_6bec98cb2dcc2450 show();
  var_6bec98cb2dcc2450.colmodel = spawn("script_model", var_6bec98cb2dcc2450.origin);
  var_6bec98cb2dcc2450.colmodel.team = var_6bec98cb2dcc2450.team;
  var_6bec98cb2dcc2450.colmodel.owner = var_6bec98cb2dcc2450.owner;
  var_6bec98cb2dcc2450.colmodel setModel("vm_jup_2h_lrad_00_invis_base");
  var_6bec98cb2dcc2450.colmodel dontinterpolate();
  var_6bec98cb2dcc2450.colmodel hide();
  var_6bec98cb2dcc2450.colmodel.lrad = var_6bec98cb2dcc2450;

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_6bec98cb2dcc2450[[getsharedfunc("killstreak", "addToActiveKillstreakList")]]("lrad", "Killstreak_Ground", self, 0, 1, 55, "isCarried");
  }

  function_f74b0080a679742b(var_6bec98cb2dcc2450);

  if(issharedfuncdefined("game", "createObjective")) {
    var_6bec98cb2dcc2450.minimapid = var_6bec98cb2dcc2450[[getsharedfunc("game", "createObjective")]](bundle.minimapicon, var_6bec98cb2dcc2450.team, 1, 1, 1);
    scripts\mp\objidpoolmanager::function_2946e9eb07acb3f1(var_6bec98cb2dcc2450.minimapid, &"KILLSTREAKS/LRAD");
  }

  var_6bec98cb2dcc2450 setscriptablepartstate("spawned", "deploy", 0);
  return var_6bec98cb2dcc2450;
}

function function_f74b0080a679742b(var_6bec98cb2dcc2450) {
  hinttag = "j_mount";
  hintpos = var_6bec98cb2dcc2450 gettagorigin(hinttag);

  if(!isDefined(var_6bec98cb2dcc2450.useownerobj)) {
    if(issharedfuncdefined("game", "createHintObject")) {
      var_6bec98cb2dcc2450.useownerobj = [[getsharedfunc("game", "createHintObject")]](hintpos, "HINT_BUTTON", undefined, &"KILLSTREAKS_HINTS/LRAD_USE", undefined, undefined, "show");
    }
  } else {
    hintpos = var_6bec98cb2dcc2450 gettagorigin(hinttag);
    var_6bec98cb2dcc2450.useownerobj function_dfb78b3e724ad620(1);
    var_6bec98cb2dcc2450.useownerobj dontinterpolate();
    var_6bec98cb2dcc2450.useownerobj.origin = hintpos;
  }

  foreach(player in level.players) {
    if(player != self) {
      var_6bec98cb2dcc2450.useownerobj disableplayeruse(player);
      continue;
    }

    var_6bec98cb2dcc2450.useownerobj enableplayeruse(player);
  }

  var_6bec98cb2dcc2450.useownerobj linkTo(var_6bec98cb2dcc2450, hinttag);
}

function function_3c44a60f10088e51(streakinfo, ignorecancel, delaytime) {
  thread function_73b3147446ea5f18(delaytime);
  marker = undefined;

  if(issharedfuncdefined("killstreak", "getTargetMarker")) {
    marker = [[getsharedfunc("killstreak", "getTargetMarker")]](streakinfo, ignorecancel);
  }

  if(!isDefined(marker) || !isDefined(marker.location)) {
    if(_isalive()) {
      function_9f6045ef775e961c(streakinfo.bundle.deployweapon, undefined, undefined, 1);
    }

    return undefined;
  }

  if(isDefined(self) && _isalive()) {
    self freezecontrols(1);
  } else {
    return undefined;
  }

  if(self hasweapon(streakinfo.bundle.deployweapon)) {
    thread function_9f6045ef775e961c(streakinfo.bundle.deployweapon, 1, 1);
  }

  delayspawntime = getdvarfloat(@ "hash_d7fd0b0d5f62285c");
  wait delayspawntime;
  self freezecontrols(0);
  return marker;
}

function function_73b3147446ea5f18(delaytime) {
  self endon("death_or_disconnect");
  self endon("lrad_placed");
  self endon("lrad_put_away");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  self setclientomnvar("ui_turret_placement", 1);
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("death");
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("lrad_placed");
  thread scripts\cp_mp\killstreaks\manual_turret::manualturret_clearplacementinstructions("lrad_put_away");
}

function function_136ba4565fe17b8(callbackparams) {
  meansofdeath = callbackparams.meansofdeath;

  if(isDefined(self.useownerobj)) {
    self.useownerobj function_dfb78b3e724ad620(0);
  }

  if(isDefined(meansofdeath) && (meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_GRENADE_SPLASH")) {
    self setscriptablepartstate("explode", "violent");
  } else {
    self playSound("sentry_explode_smoke");
    self setscriptablepartstate("explode", "regular");
  }

  wait 0.2;
  self setscriptablepartstate("visibility", "hide");
  self setscriptablepartstate("beam", "idle");
  self hide();
}

function lrad_destroy(delaytime) {
  if(isDefined(delaytime)) {
    wait delaytime;
  }

  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);

  if(isDefined(self.useownerobj)) {
    self.useownerobj delete();
  }

  if(isDefined(self.colmodel)) {
    self.colmodel delete();
  }

  if(isDefined(self.stuntrigger)) {
    foreach(player in self.stuntrigger.playersintrigger) {
      if(!isDefined(player)) {
        continue;
      }

      self.stuntrigger.playersintrigger[player getentitynumber()] = undefined;

      if(isalive(player)) {
        player function_56da58bd9ea3d08d();
      }
    }

    self.stuntrigger delete();
  }

  level.var_f22117519609ef3b = array_remove(level.var_f22117519609ef3b, self);

  if(isDefined(self)) {
    self delete();
  }
}

function function_405ae182beea4b1c(data) {
  if(!isDefined(data)) {
    data = spawnStruct();
  }

  data.meansofdeath = "MOD_CRUSH";
  function_136ba4565fe17b8(data);
  lrad_destroy();
  namespace_37987c2865e1a627::clearminimapid();
}

function lrad_timeout(params) {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(issharedfuncdefined("audio", "brLeaderDialogTeam")) {
      level thread[[getsharedfunc("audio", "brLeaderDialogTeam")]]("lrad_friendly_timeout", self.owner.team, 1, undefined, undefined, "dx_br_jpbm_");
    }

    return;
  }

  self.owner playkillstreakteamleaderdialog("lrad", "lrad_teamleader_timeout");
}

function function_9f6045ef775e961c(deployweapon, immediateswitch, optionaltimedelay, var_f1f211606ccd1b6e) {
  if(isDefined(optionaltimedelay) && optionaltimedelay > 0) {
    self endon("death_or_disconnect");
    level endon("game_ended");
    wait optionaltimedelay;
  }

  var_cf06a44e7221edbb = getdvarint(@ "hash_dba4a054e67dd255", 0) == 1;
  lastweaponobj = restoreweaponstates(self.lastdroppableweaponobj, var_cf06a44e7221edbb);
  level.var_2d9a7cb2b0831e1e--;
  level.var_23bb4defc5121d06[self.team]--;

  if(istrue(immediateswitch)) {
    _switchtoweaponimmediate(lastweaponobj);
  } else {
    _switchtoweapon(lastweaponobj);
  }

  _takeweapon(deployweapon);

  if(istrue(var_f1f211606ccd1b6e)) {
    self notify("lrad_put_away");
  }
}

function function_5a68b8ee35170bf9(streakinfo, switchresult, weaponobj) {
  if(!istrue(switchresult)) {
    getridofkillstreakdeployweapon(weaponobj);
  }
}

function function_8703bc55951530be(var_5c911c4e7ce59792) {
  if(_isalive()) {
    if(var_5c911c4e7ce59792) {
      val::set("lrad_placement", "sprint", 0);
      val::set("lrad_placement", "weapon_switch", 0);
      val::set("lrad_placement", "offhand_weapons", 0);
      val::set("lrad_placement", "melee", 0);
      val::set("lrad_placement", "execution_attack", 0);
      val::set("lrad_placement", "ladder_placement", 0);
      val::set("lrad_placement", "mantle", 0);
      val::set("lrad_placement", "armor", 0);
      val::set("lrad_placement", "ladder", 0);
      return;
    }

    val::reset_all("lrad_placement");
  }
}

function function_9235bfde9b04fc60(var_6bec98cb2dcc2450, useobj) {
  if(isDefined(var_6bec98cb2dcc2450)) {
    var_6bec98cb2dcc2450 endon("death");
    var_6bec98cb2dcc2450 endon("lrad_dying");
  }

  self endon("disconnect");
  level endon("game_ended");
  self endon("lrad_hacked");

  while(true) {
    level waittill("connected", player);
    useobj disableplayeruse(player);
  }
}

function function_5189f677d1332852(var_6bec98cb2dcc2450, streakinfo) {
  self endon("disconnect");
  self endon("lrad_hacked");
  var_6bec98cb2dcc2450 endon("lrad_dying");
  level endon("game_ended");

  while(true) {
    var_6bec98cb2dcc2450.useownerobj waittill("trigger", player);

    if(isDefined(player) && !function_21550b5260803f0b(player)) {
      continue;
    }

    var_6bec98cb2dcc2450.useownerobj function_dfb78b3e724ad620(0);
    level.var_2d9a7cb2b0831e1e++;
    level.var_23bb4defc5121d06[self.team]++;
    thread function_43adb6908f665a51(var_6bec98cb2dcc2450, streakinfo);
    thread function_883487704e982cda();
  }
}

function function_883487704e982cda() {
  var_5fec53c49890f027 = self.var_9717afbc6163113;

  if(!isDefined(var_5fec53c49890f027)) {
    return;
  }

  foreach(ent in var_5fec53c49890f027) {
    if(isDefined(ent) && isalive(ent)) {
      ent thread function_56da58bd9ea3d08d();
    }
  }
}

function function_21550b5260803f0b(player) {
  if(player != self) {
    return false;
  }

  if(istrue(player.insertingarmorplate)) {
    return false;
  }

  if(istrue(player.isjuggernaut)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      player[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_PICKED_UP");
    }

    return false;
  }

  return true;
}

function function_43adb6908f665a51(var_6bec98cb2dcc2450, streakinfo) {
  self endon("disconnect");
  level endon("game_ended");
  function_c87fe068955bfe05(var_6bec98cb2dcc2450);
  function_484aa2a4c15a015c(var_6bec98cb2dcc2450);
  var_6bec98cb2dcc2450 clearminimapid();
  function_fa22ff0405c3d06e(var_6bec98cb2dcc2450);
  var_6bec98cb2dcc2450 function_f4e488f7d8918d26();
  self playSound("jup_kls_lrad_pickup");
  saveweaponstates();
  endonnotify = "sentry_placement_failed";

  if(issharedfuncdefined("weapons", "watchForPlacementFireState")) {
    self thread[[getsharedfunc("weapons", "watchForPlacementFireState")]](streakinfo, endonnotify);
  }

  _giveweapon(streakinfo.bundle.deployweapon);
  switchsuccess = domonitoredweaponswitch(streakinfo.bundle.deployweapon, 1);

  if(!istrue(switchsuccess)) {
    self notify(endonnotify);
    _takeweapon(streakinfo.bundle.deployweapon);
    level.var_2d9a7cb2b0831e1e--;

    if(isDefined(self.owner) && isDefined(level.var_23bb4defc5121d06[self.owner])) {
      level.var_23bb4defc5121d06[self.owner]--;
    }

    if(isDefined(var_6bec98cb2dcc2450)) {
      var_6bec98cb2dcc2450 lrad_destroy();
    }

    return 0;
  }

  function_8703bc55951530be(1);
  thread function_f2b4b6d178b092d9(var_6bec98cb2dcc2450);
  marker = function_3c44a60f10088e51(streakinfo, 1, 0.25);
  function_8703bc55951530be(0);

  if(!isDefined(marker)) {
    return 0;
  }

  function_75ba96a892796b34(marker, var_6bec98cb2dcc2450);
  maxlifetime = getdvarfloat(@ "hash_98efcf229168a436");
  var_6bec98cb2dcc2450 thread function_47b5394a301d8c5(maxlifetime, @ "hash_80d0084f17797030");

  var_6bec98cb2dcc2450 thread function_1defeaf387d6e2a9(@ "hash_80d0084f17797030");
}

function function_484aa2a4c15a015c(var_6bec98cb2dcc2450) {
  linkedchildren = var_6bec98cb2dcc2450 getlinkedchildren();

  foreach(child in linkedchildren) {
    if(isDefined(child) && child != var_6bec98cb2dcc2450.stuntrigger) {
      child unlink();
    }
  }
}

function function_fa22ff0405c3d06e(var_6bec98cb2dcc2450) {
  var_6bec98cb2dcc2450 hide();
  var_6bec98cb2dcc2450.colmodel unlink();
  var_6bec98cb2dcc2450.colmodel hide();
  var_6bec98cb2dcc2450.stuntrigger hide();
  var_6bec98cb2dcc2450.iscarried = 1;
  var_6bec98cb2dcc2450 notify("isCarried");
  var_6bec98cb2dcc2450 allow_emp(0);
}

function function_75ba96a892796b34(marker, var_6bec98cb2dcc2450) {
  function_cce8da1f44d40890(marker, var_6bec98cb2dcc2450);
  var_6bec98cb2dcc2450.colmodel show();
  var_6bec98cb2dcc2450.colmodel.angles = var_6bec98cb2dcc2450.angles;
  var_6bec98cb2dcc2450.colmodel.origin = var_6bec98cb2dcc2450.origin;
  var_6bec98cb2dcc2450.colmodel linkTo(var_6bec98cb2dcc2450);
  var_6bec98cb2dcc2450.stuntrigger show();
  var_6bec98cb2dcc2450.iscarried = 0;
  var_6bec98cb2dcc2450 allow_emp(1);
  var_6bec98cb2dcc2450 function_dd6257eba7b4a3b2();
  self notify("lrad_placed");
}

function function_c87fe068955bfe05(var_6bec98cb2dcc2450) {
  if(isDefined(var_6bec98cb2dcc2450)) {
    if(isDefined(var_6bec98cb2dcc2450.moving_platform)) {
      var_6bec98cb2dcc2450.moving_platform = undefined;
      var_6bec98cb2dcc2450.moving_platform_offset = undefined;
      var_6bec98cb2dcc2450.moving_platform_angles_offset = undefined;
    }

    var_6bec98cb2dcc2450 unlink();
  }
}

function function_4444ec0cb29ca814(weaponref) {
  bundle = level.streakglobals.streakbundles["lrad"];
  return weaponref == bundle.spawnweapon || weaponref == bundle.deployweapon;
}

function function_67a2561dc56ecc0b(data) {
  attacker = data.attacker;

  if(!isDefined(self.ishaywire) || !istrue(self.ishaywire)) {
    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
      self.ishaywire = 1;
      thread function_355f8536758cc7c7();
    }
  }

  self setscriptablepartstate("haywire", "active", 0);
}

function function_a054c2c62f34ac14(data) {
  attacker = data.attacker;

  if(!isDefined(self.ishaywire) || !istrue(self.ishaywire)) {
    if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
      self.ishaywire = 1;
      function_6402ac006cab5c40();
    }
  }

  self setscriptablepartstate("haywire", "active", 0);
}

function function_5e06c811fe28148a(data) {
  self.ishaywire = 0;
  self setscriptablepartstate("haywire", "neutral", 0);
}

function function_43197d230c4d9635(data) {
  self.ishaywire = 0;
  function_18633ad410bdfdfa();
  self setscriptablepartstate("haywire", "neutral", 0);
}

function function_355f8536758cc7c7() {
  self endon("death");
  self.var_bd3a6d82c1789913 = 1;

  while(self.ishaywire) {
    if(istrue(self.var_bd3a6d82c1789913)) {
      self.var_bd3a6d82c1789913 = 0;
      function_6402ac006cab5c40();
      waittime = randomfloatrange(0.75, 1.75);
      wait waittime;
    } else {
      self.var_bd3a6d82c1789913 = 1;
      function_18633ad410bdfdfa();
      waittime = randomfloatrange(0.15, 0.35);
      wait waittime;
    }

    waitframe();
  }

  if(!istrue(self.var_bd3a6d82c1789913)) {
    function_18633ad410bdfdfa();
  }
}

function function_d4468bb2335b0542(var_9f1f082eeef5d90b) {
  data = spawnStruct();
  data.meansofdeath = "MOD_CRUSH";
  self.lrad function_136ba4565fe17b8(data);
  self.lrad lrad_destroy();
}

function function_e12969da21420075() {
  trigger_length = getdvarint(@ "hash_b4d9a80ce75c617");
  trigger_radius = getdvarint(@ "hash_b27192e0593d2245");
  height_offset = getdvarint(@ "hash_791416d97b1899ba");
  self.stuntrigger = spawn("trigger_rotatable_radius", self.origin, 0, trigger_radius, trigger_length);
  function_dd6257eba7b4a3b2();
  self.stuntrigger.angles = self.angles + (90, 0, 0);
  self.stuntrigger.origin = self.origin + (0, 0, height_offset);
  self.stuntrigger.playersintrigger = [];
  self.stuntrigger enablelinkTo();
  self.stuntrigger linkTo(self);
}

function function_dd6257eba7b4a3b2() {
  if(issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    forward = anglesToForward(self.angles);
    trigger_length = getdvarint(@ "hash_b4d9a80ce75c617");
    var_ef9723a4a88c0c37 = self.origin + forward * trigger_length;
    contents = physics_createcontents(["physicscontents_ainoshoot", "physicscontents_ainosight", "physicscontents_explosionclip", "physicscontents_vehicle"]);
    castresult = physics_raycast(self.origin, var_ef9723a4a88c0c37, contents, undefined, 0, "physicsquery_closest");

    if(isDefined(castresult) && castresult.size > 0) {
      castend = castresult[0]["position"];
      var_bf382be336fe4f11 = distance(self.origin, castend);
    } else {
      var_bf382be336fe4f11 = trigger_length;
    }

    bundle = level.streakglobals.streakbundles["lrad"];
    var_27f3a8e03d3dc5e7 = getdvarint(@ "hash_c6ad55369ab9a6c8", bundle.var_ff9463f1d381ff0);
    var_fa2a279646b5006b = ceil(var_bf382be336fe4f11 / var_27f3a8e03d3dc5e7);
    self.dangerzones = [];
    currentorigin = self.origin + var_27f3a8e03d3dc5e7 / 2 * forward;
    lifetime = getdvarfloat(@ "hash_98efcf229168a436");

    for(i = 0; i < var_fa2a279646b5006b; i++) {
      self.dangerzones[i] = callsharedfunc("spawn", "addSpawnDangerZone", currentorigin, bundle.dangerzoneradius, bundle.dangerzoneheight, self.ownerteam, lifetime, self.owner, 0, self, 1);
      currentorigin += var_27f3a8e03d3dc5e7 * forward;
    }
  }
}

function function_f4e488f7d8918d26() {
  if(!isDefined(self.dangerzones)) {
    return;
  }

  foreach(dangerzone in self.dangerzones) {
    callsharedfunc("spawn", "removeSpawnDangerZone", dangerzone);
  }
}

function function_d2368d84391b6a68() {
  self endon("death");
  self endon("disconnected");
  self endon("beamStop");

  while(true) {
    self.stuntrigger waittill("trigger");
    entities_players = level.players;
    entities_ai = getaiarray();
    allentities = array_combine_unique(entities_players, entities_ai);
    var_f4fc390187305987 = self.stuntrigger getistouchingentities(allentities);

    if(isDefined(self.owner)) {
      self.owner.var_9717afbc6163113 = var_f4fc390187305987;
    }

    foreach(ent in var_f4fc390187305987) {
      var_18d1eaac8a573748 = 0;

      debugactive = getdvarint(@ "hash_80d0084f17797030");

      if(debugactive > 0) {
        iprintlnbold(ent.name + "<dev string:x83>");
        var_18d1eaac8a573748 = getdvarint(@ "hash_5f9bf6b2e15e5727");
      }

      if(function_f636f503f2312823(ent, var_18d1eaac8a573748)) {
        var_97db5d48f2509e02 = function_5dcb36314d1abe55(ent);

        if(var_97db5d48f2509e02.size == 0) {
          stuntime = getdvarfloat(@ "hash_2ef1444b14cdcc27");
          ent function_bb2a979de475a65(stuntime, self);
          self.stuntrigger.playersintrigger[ent getentitynumber()] = ent;
        } else if(function_7fbe85f0fd784b4c(var_97db5d48f2509e02)) {
          stuntime = getdvarfloat(@ "hash_4469252783a3ea7d");
          ent function_bb2a979de475a65(stuntime, self);
          self.stuntrigger.playersintrigger[ent getentitynumber()] = ent;
        }
      }

      waitframe();
    }

    var_d72b86407ed6514b = getdvarfloat(@ "hash_1676fc44b285c55a");
    wait var_d72b86407ed6514b;
  }
}

function function_9c3226ae596454e6() {
  self endon("death");
  self endon("beamStop");

  while(true) {
    foreach(id, player in self.stuntrigger.playersintrigger) {
      if(!isDefined(player)) {
        self.stuntrigger.playersintrigger[id] = undefined;
        continue;
      }

      if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
        self.stuntrigger.playersintrigger[id] = undefined;
        continue;
      }

      if(player istouching(self.stuntrigger)) {
        continue;
      }

      self.stuntrigger.playersintrigger[player getentitynumber()] = undefined;
      player function_56da58bd9ea3d08d();
    }

    waitframe();
  }
}

function function_f636f503f2312823(ent, var_18d1eaac8a573748) {
  playercheck = 0;

  if(isPlayer(ent) || isai(ent)) {
    playercheck = 1;
  }

  return playercheck && isalive(ent) && (var_18d1eaac8a573748 || ent.team != self.owner.team || !istrue(level.teambased) && ent != self.owner) && !istrue(self.iscarried) && !istrue(self.issmoking);
}

function function_5dcb36314d1abe55(target) {
  var_68e6f05a4ee24dee = physics_createcontents(["physicscontents_ainoshoot", "physicscontents_ainosight", "physicscontents_explosionclip", "physicscontents_vehicle"]);
  raycaststart = self.origin + (0, 0, 50);
  raycastend = target getEye();
  var_97db5d48f2509e02 = physics_raycast(raycaststart, raycastend, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_all");

  debugactive = getdvarint(@ "hash_80d0084f17797030");

  if(debugactive > 0) {
    duration = getdvarint(@ "hash_356ad37ca5f6f115");
    line(raycaststart, raycastend, (0, 0, 100), 1, 0, duration);
    drawcolor = (0, 255, 0);

    foreach(result in var_97db5d48f2509e02) {
      sphere(result["<dev string:x97>"], 5, drawcolor, 0, duration);
    }
  }

  return var_97db5d48f2509e02;
}

function function_7fbe85f0fd784b4c(var_97db5d48f2509e02) {
  var_c8af87991ff22645 = 1;

  foreach(result in var_97db5d48f2509e02) {
    if(!isDefined(result["entity"]) || !isDefined(result["entity"].vehiclemodel)) {
      var_c8af87991ff22645 = 0;
      break;
    }
  }

  return var_c8af87991ff22645;
}

function function_bb2a979de475a65(stuntime, var_ef9733a4a88c2f67) {
  if(!player_hasperk("specialty_stun_resistance")) {
    if(!istrue(self.var_c4c1555acea960b5)) {
      thread function_c33bfcf6e1403531(var_ef9733a4a88c2f67);
    }

    self.var_c4c1555acea960b5 = 1;

    if(isai(self)) {
      if(!isDefined(self.subclass)) {
        utility::setplayerstunned();
      } else if(self.subclass == "zombie_base") {
        if(issharedfuncdefined("zombie", "stunZombie")) {
          self[[getsharedfunc("zombie", "stunZombie")]](10000);
        }
      } else {
        self notify("flashbang", self.origin, 1, undefined, var_ef9733a4a88c2f67.owner, var_ef9733a4a88c2f67.owner.team, undefined);
      }
    } else {
      utility::setplayerstunned();
    }

    if(issharedfuncdefined("damage", "fx_stun_damage")) {
      self thread[[getsharedfunc("damage", "fx_stun_damage")]](self, var_ef9733a4a88c2f67.owner);
    }

    _shellshock("lrad_mp", "gas", stuntime, 1);

    if(issharedfuncdefined("sound", "CodcasterSetPlayerStatusEffect")) {
      self[[getsharedfunc("sound", "CodcasterSetPlayerStatusEffect")]]("stun", stuntime);
    }

    if(issharedfuncdefined("damage", "updateDamageFeedback")) {
      var_ef9733a4a88c2f67.owner[[getsharedfunc("damage", "updateDamageFeedback")]]("hitsoundveil");
    }

    if(getdvarint(@ "hash_abec145fdf5e6352") == 1) {
      if(!isai(self)) {
        if(isPlayer(self)) {
          utility::hidehudenable();
        }
      }
    }
  } else if(player_hasperk("specialty_stun_resistance")) {
    attackerowner = utility::ter_op(isDefined(var_ef9733a4a88c2f67.owner), var_ef9733a4a88c2f67.owner, var_ef9733a4a88c2f67);
    victimowner = utility::ter_op(isDefined(self.owner), self.owner, self);
    currenttime = gettime();

    if(!isDefined(var_ef9733a4a88c2f67.var_8ca2aec32c2b0356) || currenttime > var_ef9733a4a88c2f67.var_8ca2aec32c2b0356 + 2000) {
      if(isPlayer(attackerowner) && attackerowner != self) {
        attackerowner damagefeedback::updatedamagefeedback("hittacresist", undefined, undefined, undefined, 1);
      }

      var_ef9733a4a88c2f67.var_8ca2aec32c2b0356 = currenttime;
    }

    if(istrue(player_utility::playersareenemies(attackerowner, victimowner))) {
      namespace_53fc9ddbb516e6e1::activateperksharedfunc("specialty_tac_resist");
    }
  }

  debugactive = getdvarint(@ "hash_80d0084f17797030");

  if(debugactive > 0) {
    fullstuntime = getdvarfloat(@ "hash_2ef1444b14cdcc27");

    if(stuntime == fullstuntime) {
      iprintlnbold(self.name + "<dev string:xa3>");
      return;
    }

    iprintlnbold(self.name + "<dev string:xbd>");
  }
}

function function_56da58bd9ea3d08d() {
  if(istrue(self.var_c4c1555acea960b5)) {
    self.var_c4c1555acea960b5 = undefined;
    self notify("unstunned");

    if(getdvarint(@ "hash_abec145fdf5e6352") == 1) {
      if(!isai(self)) {
        if(isPlayer(self)) {
          if(isDefined(self.hidehudenabled) && self.hidehudenabled > 0) {
            utility::hidehuddisable();
          }
        }
      }
    }

    if(isai(self)) {
      if(!isDefined(self.subclass)) {
        utility::setplayerstunned();
      } else if(self.subclass == "zombie_base") {
        if(issharedfuncdefined("zombie", "clearStunZombie")) {
          self[[getsharedfunc("zombie", "clearStunZombie")]]();
        }
      }

      return;
    }

    utility::setplayerstunned();
  }
}

function function_c33bfcf6e1403531(var_ef9733a4a88c2f67) {
  self endon("unstunned");
  level endon("game_ended");
  self waittill("death", attacker);

  if(level.var_d11891ea093da336 && isDefined(var_ef9733a4a88c2f67) && isDefined(var_ef9733a4a88c2f67.owner) && attacker != var_ef9733a4a88c2f67.owner) {
    var_ef9733a4a88c2f67.owner utility::callsharedfunc("killstreak", "rewardAssistPoints");
  }
}

function lrad_hack(newowner) {
  self notify("lrad_hacked");
  self.owner = newowner;
  self.team = newowner.team;
  self.ownerid = newowner getxuid();
  self setentityowner(newowner);
  self setotherent(newowner);

  if(level.teambased) {
    self filteroutplayermarks(newowner.team);
  } else {
    self filteroutplayermarks(newowner);
  }

  if(issharedfuncdefined("killstreak", "giveScoreForHack")) {
    newowner[[getsharedfunc("killstreak", "giveScoreForHack")]]();
  }

  self.owner function_f74b0080a679742b(self);
  self.owner thread function_5189f677d1332852(self, self.streakinfo);
  clearminimapid();

  if(issharedfuncdefined("game", "createObjective")) {
    self.minimapid = self[[getsharedfunc("game", "createObjective")]](self.streakinfo.bundle.minimapicon, self.team, 1, 1, 1);
  }
}

function function_5733afc81f25372c(data) {
  if(!isDefined(self.totaldamagetaken)) {
    self.totaldamagetaken = 0;
  }

  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;

  if(istrue(level.var_be6a42242be00b66)) {
    bundle = level.streakglobals.streakbundles["lrad"];
    modifieddamage = getmodifieddamageusingdamagetuning(attacker, objweapon, type, modifieddamage, self.maxhealth, bundle.var_e913079a5ffda56d);
  } else if(issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    modifieddamage = self[[getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, type, modifieddamage, self.maxhealth, 2, 3, 3, 4, 400);
  }

  self.totaldamagetaken += modifieddamage;

  if(self.totaldamagetaken >= self.maxhealth * 0.5) {
    self setscriptablepartstate("damage", "on");
    self notify("lrad_dying");
    self.useownerobj function_dfb78b3e724ad620(0);
  }

  return modifieddamage;
}

function function_1defeaf387d6e2a9(debugactivedvar) {
  level endon("<dev string:xda>");
  self endon("<dev string:xe8>");
  self.owner endon("<dev string:xf1>");
  self endon("<dev string:x101>");
  debugactive = getdvarint(debugactivedvar);

  while(true) {
    if(debugactive > 0) {
      healthremaining = self.maxhealth - self.damagetaken;
      print3d(self.origin + (0, 0, 20), "<dev string:x10e>" + healthremaining, (0, 1, 0), 1, 0.5, 1);
      trigger_length = getdvarint(@ "hash_b4d9a80ce75c617");
      trigger_radius = getdvarint(@ "hash_b27192e0593d2245");
      lifetime = getdvarint(@ "hash_98efcf229168a436");
      duration = 100;
      startpoint = self.stuntrigger.origin;
      endpoint = self.stuntrigger.origin + anglestoup(self.stuntrigger.angles) * trigger_length;
      cylinder(startpoint, endpoint, trigger_radius, (0, 1, 0), 0, duration);
    }

    waitframe();
  }
}

# /