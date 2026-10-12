/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\killstreaks\switchblade_drone.gsc
*****************************************************/

#using script_16ea1b94f0f381b3;
#using script_608c50392df8c7d1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\mp\objidpoolmanager;
#namespace switchblade_drone;

function autoexec main() {
  registerkillstreakinitfunction(getxhash("switchblade_drone"), &init);
}

function private init() {
  if(issharedfuncdefined("switchblade_drone", "init")) {
    [[getsharedfunc("switchblade_drone", "init")]]();
  }

  if(issharedfuncdefined("killstreak", "registerKillstreak")) {
    [[getsharedfunc("killstreak", "registerKillstreak")]]("switchblade_drone", &function_fac3964b226792c1);
  }

  scripts\engine\utility::registersharedfunc("switchblade_drone", "tryUseKillstreak", &function_fac3964b226792c1);
  function_1e5a79cefb8818fb();
  function_167cc15cd8218528();
  val::group_register("switchbladeDrone_deploy", ["melee", "offhand_weapons", "sprint", "weapon_switch", "cp_munitions_pickup"]);
  bundle = level.streakglobals.streakbundles["switchblade_drone"];
  registerkillstreakdamagedealingweaponsharedfunc("switchblade_drone", bundle.var_cd5b1623cbc6478e, #"hash_b76b2215370d2700");
  level.var_e1aa3bddc7b228e9 = 0;
  level.var_e5731fb152792de1 = [];
  level.var_cde4ae1afb90a57a = [];
}

function function_1e5a79cefb8818fb() {
  setdvarifuninitialized(@ "hash_b171aaba052d2c50", 5);
  setdvarifuninitialized(@ "hash_cda65d1126957523", 1);
  setdvarifuninitialized(@ "hash_7ad66a5bc22f0e3c", 0.4);
  setdvarifuninitialized(@ "hash_fec9a646e847f81b", 0.3);
  setdvarifuninitialized(@ "hash_bb25bfbed73b667b", 0.15);
  setdvarifuninitialized(@ "hash_aea510623d9c4c10", 1250);
  setdvarifuninitialized(@ "hash_79f9928723395f7f", -90);
  setdvarifuninitialized(@ "hash_9bb73c3ac9654260", 300);
  setdvarifuninitialized(@ "hash_7bd25800dfc29105", 65);
  setdvarifuninitialized(@ "hash_832a4160ba33c74b", 12);
  setdvarifuninitialized(@ "hash_57306177bd6ed859", 20);
  setdvarifuninitialized(@ "hash_fa505002fe5586de", 10);
  setdvarifuninitialized(@ "hash_636a1d843f1957eb", 7);
  setdvarifuninitialized(@ "hash_f10e873f6059cd5f", 20);
  setdvarifuninitialized(@ "hash_a80f427a9d36e9fe", 75);
  setdvarifuninitialized(@ "hash_d40e17bd9fa003a1", 35);
  setdvarifuninitialized(@ "hash_836eeca87d3a3d6f", 500);
  setdvarifuninitialized(@ "hash_fc2d155242a3fc25", 800);
  setdvarifuninitialized(@ "hash_1da226fe14849c74", 800);
  setdvarifuninitialized(@ "hash_22f1ccc4024de95e", 600);
  setdvarifuninitialized(@ "hash_deabefeda3824f1d", 1000);
  setdvarifuninitialized(@ "hash_c17694dce62bf907", 1000);
  setdvarifuninitialized(@ "hash_b9597bb5bad14e63", 50);
  setdvarifuninitialized(@ "hash_f956bbb2c255914f", 500);
  setdvarifuninitialized(@ "hash_b0c1d0793ae379c7", 0);
  setdvarifuninitialized(@ "hash_211a27e9e936be16", 0);
}

function function_167cc15cd8218528() {
  game["dialog"]["switchblade_ause"] = "ause";
  game["dialog"]["switchblade_euse"] = "euse";
  game["dialog"]["switchblade_lcra"] = "lcra";
  game["dialog"]["switchblade_ltim"] = "ltim";
  game["dialog"]["switchblade_earn"] = "earn";
}

function function_fac3964b226792c1(streakinfo) {
  if(!isDefined(streakinfo)) {
    streakinfo = createstreakinfo("switchblade_drone", self);
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return 0;
    }
  }

  if(!function_df1cf83495e38426()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/SWITCHBLADE_COUNT_OVER_LIMIT");
    }

    return 0;
  }

  bundle = level.streakglobals.streakbundles["switchblade_drone"];
  val::set("switchbladeDrone", "usability", 0);
  deployweaponobj = makeweapon(bundle.var_cd5b1623cbc6478e);
  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, deployweaponobj, "grenade_fire", undefined, &function_7bf1d7276d8de2c3, &function_7f27487dffce9217);

  if(!istrue(deployresult)) {
    val::reset("switchbladeDrone", "usability");
    function_44b0c510768ad13e(deployweaponobj);
    return undefined;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return 0;
    }
  }

  val::reset("switchbladeDrone", "usability");
  return 1;
}

function function_df1cf83495e38426() {
  bundle = level.streakglobals.streakbundles["switchblade_drone"];
  dronelist = level.var_cde4ae1afb90a57a;
  var_8a274ec6b6a29b4f = 0;
  var_682d15c80e654eac = 0;

  if(!isDefined(level.var_e5731fb152792de1[self.team])) {
    level.var_e5731fb152792de1[self.team] = 0;
  }

  foreach(key, drone in dronelist) {
    if(!isDefined(drone)) {
      level.var_cde4ae1afb90a57a = array_remove_key(level.var_cde4ae1afb90a57a, key);
      continue;
    }

    if(drone.owner == self) {
      var_682d15c80e654eac++;
      var_8a274ec6b6a29b4f++;
      continue;
    }

    if(drone.team == self.team) {
      var_8a274ec6b6a29b4f++;
    }
  }

  if(level.var_cde4ae1afb90a57a.size + level.var_e1aa3bddc7b228e9 > bundle.var_c29ccc18c34034e6) {
    return false;
  }

  if(var_8a274ec6b6a29b4f + level.var_e5731fb152792de1[self.team] > bundle.var_9408e94673c89c1d) {
    return false;
  }

  if(var_682d15c80e654eac >= bundle.var_21f9ab90f835561) {
    return false;
  }

  return true;
}

function function_7bf1d7276d8de2c3(streakinfo, switchresult) {
  if(istrue(switchresult)) {
    level.var_e1aa3bddc7b228e9++;
    level.var_e5731fb152792de1[self.team]++;
    thread function_fd39610812b871ee();
    thread function_cde5ec93a0a3eaad(streakinfo);
    val::group_set("switchbladeDrone_deploy", 0);
  }
}

function function_fd39610812b871ee() {
  self endon("disconnect");
  self endon("cancel_deploy");
  self endon("weapon_switch_started");
  self endon("grenade_fire");
  self endon("death");
  self notifyonplayercommand("attempt_fire", "+attack");

  while(true) {
    self waittill("attempt_fire");

    if(!self function_6052a9e1b7c3956f()) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_PLACED");
      }
    }

    wait 0.1;
  }
}

function function_cde5ec93a0a3eaad(streakinfo) {
  self endon("disconnect");
  self endon("grenade_fire");

  if(!isbot(self)) {
    self notifyonplayercommand("cancel_deploy", "+actionslot 3");
    self notifyonplayercommand("cancel_deploy", "+actionslot 4");
    self notifyonplayercommand("cancel_deploy", "+actionslot 5");
    self notifyonplayercommand("cancel_deploy", "+actionslot 6");
    self notifyonplayercommand("cancel_deploy", "killstreak1");
    self notifyonplayercommand("cancel_deploy", "killstreak2");
    self notifyonplayercommand("cancel_deploy", "killstreak3");
    self notifyonplayercommand("cancel_deploy", "killstreak4");
    self notifyonplayercommand("cancel_deploy", "+weapprev");
    self notifyonplayercommand("cancel_deploy", "+weapnext");
    self notifyonplayercommand("cancel_deploy", "selectweapon1");
    self notifyonplayercommand("cancel_deploy", "selectweapon2");
  }

  result = waittill_any_return_2("cancel_deploy", "weapon_switch_started");
  val::group_reset("switchbladeDrone_deploy");

  if(!isDefined(result)) {
    return;
  }

  self allowfire(1);
  self.var_be314f32a1d5336e = 0;
  streakinfo notify("killstreak_finished_with_deploy_weapon");
  wait 0.5;
  level.var_e1aa3bddc7b228e9--;
  level.var_e5731fb152792de1[self.team]--;
}

function function_7f27487dffce9217(streakinfo, weaponobj, projectile) {
  var_d06f735a85408be7 = 0;
  switchblade_drone = function_6fd64a7766f2f12a(projectile);
  bundle = level.streakglobals.streakbundles["switchblade_drone"];

  if(!isDefined(switchblade_drone)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/SWITCHBLADE_DRONE_CANNOT_BE_USED");
    }

    function_44b0c510768ad13e(weaponobj);
    level.var_e1aa3bddc7b228e9--;
    level.var_e5731fb152792de1[self.team]--;
    return "continue";
  }

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + "switchblade_drone", self);
  }

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    switchblade_drone[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_ea343190a5d1301e);
  }

  switchblade_drone scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_ea343190a5d1301e);
  switchblade_drone scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_3a93e509a610b4bd);
  var_d06f735a85408be7 = switchblade_drone function_f50add73e923b629();

  if(!istrue(var_d06f735a85408be7)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/SWITCHBLADE_DRONE_CANNOT_BE_USED");
    }

    function_44b0c510768ad13e(weaponobj);

    if(istrue(bundle.var_9b2586bfb4f3de46)) {
      switchblade_drone clearminimapid();
    }

    switchblade_drone thread function_a66b069993cf9abb(1);
    level.var_e1aa3bddc7b228e9--;
    level.var_e5731fb152792de1[self.team]--;
    return "continue";
  }

  level.var_cde4ae1afb90a57a = array_add(level.var_cde4ae1afb90a57a, switchblade_drone);
  level.var_e1aa3bddc7b228e9--;
  level.var_e5731fb152792de1[self.team]--;

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    switchblade_drone[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", self, 0, 1, 100);
  }

  switchblade_drone.streakinfo = streakinfo;
  var_8eee8435268b02da = getdvarfloat(@ "hash_7ad66a5bc22f0e3c");
  wait var_8eee8435268b02da;
  var_1ba7ca7ba398e6ed = getdvarfloat(@ "hash_fec9a646e847f81b");
  var_bc6e4f875380989 = getdvarfloat(@ "hash_bb25bfbed73b667b");
  thread function_44b0c510768ad13e(weaponobj, var_1ba7ca7ba398e6ed, var_bc6e4f875380989);

  if(isDefined(switchblade_drone)) {
    switchblade_drone.targetorigin = switchblade_drone.origin;
    var_d06f735a85408be7 = switchblade_drone function_f50add73e923b629();
  } else {
    if(issharedfuncdefined("switchblade_drone", "munitionUsed")) {
      self[[getsharedfunc("switchblade_drone", "munitionUsed")]]();
    }

    return "success";
  }

  params = spawnStruct();
  params.fromtrigger = 0;
  switchblade_drone thread function_47b5394a301d8c5(bundle.dronelifetime, @ "hash_211a27e9e936be16", &function_4706f9311a69b5bc, params);
  switchblade_drone function_63d1a11f8b22244(streakinfo, &function_ba6789000bf88889);
  switchblade_drone setscriptablepartstate("lockedOn", "activate", 0);
  switchblade_drone.vodestroyed = "switchblade_drone_teamleader_destroyed";
  switchblade_drone.streakname = "switchblade_drone";
  switchblade_drone.streakinfo = streakinfo;

  if(istrue(bundle.candamage) && issharedfuncdefined("damage", "monitorDamage")) {
    switchblade_drone thread[[getsharedfunc("damage", "monitorDamage")]](bundle.maxhealth, "hitequip", &function_66a7440055d386c3, &function_7bdb3610d602438d, 0);
  }

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](switchblade_drone.owner, "switchblade_drone");
  }

  if(isDefined(bundle) && isDefined(bundle.dangerzoneheight) && !istrue(bundle.var_9a08562cf535296a)) {
    var_40db97c5db5e1e3e = switchblade_drone.centerpos - (0, 0, bundle.dangerzoneheight);
    switchblade_drone function_ae53424c3a02628d(bundle, var_40db97c5db5e1e3e, switchblade_drone.owner, switchblade_drone.owner.team, bundle.dronelifetime);
  }

  self endon("death");
  self endon("disconnect");
  var_87f86cdfa5b85a16 = getdvarint(@ "hash_9bb73c3ac9654260");
  switchblade_drone thread function_6ec67c6c636c25d0(switchblade_drone.centerpos, switchblade_drone.startpos, var_87f86cdfa5b85a16);
  switchblade_drone thread function_e2cf8a8b93a4a86f();
  switchblade_drone thread function_f57f532b8644012a();

  if(istrue(bundle.var_6c802afe258bcb2f)) {
    switchblade_drone thread function_8e41e9774021d4f0("notify_switchblade_drone_explode", bundle.dronelifetime, bundle.dronemaxradius, bundle.var_eed1966ca1124f9, bundle.var_9e4f84bfa849e82b);
  }

  if(isDefined(switchblade_drone)) {
    switchblade_drone thread function_171c9b525186dfee();
  }

  if(issharedfuncdefined("switchblade_drone", "munitionUsed")) {
    self[[getsharedfunc("switchblade_drone", "munitionUsed")]]();
  }

  return "success";
}

function function_44b0c510768ad13e(weaponobj, swapdelay, takedelay) {
  if(isDefined(takedelay)) {
    wait takedelay;
  }

  val::group_reset("switchbladeDrone_deploy");
  currentweapon = self getcurrentweapon();

  if(isDefined(currentweapon) && scripts\cp_mp\killstreaks\killstreakdeploy::function_b752eaae4d806c4c(currentweapon.basename)) {
    return;
  }

  if(!isDefined(self.lastdroppableweaponobj) || !self hasweapon(self.lastdroppableweaponobj)) {
    lastweaponobj = "iw9_me_fists_mp";
  } else {
    var_cf06a44e7221edbb = getdvarint(@ "hash_dba4a054e67dd255", 0) == 1;
    lastweaponobj = scripts\cp_mp\utility\weapon_utility::restoreweaponstates(self.lastdroppableweaponobj, var_cf06a44e7221edbb);
  }

  if(isDefined(swapdelay)) {
    wait swapdelay;
  }

  _switchtoweaponimmediate(lastweaponobj);
  _takeweapon(weaponobj);
}

function function_a66b069993cf9abb(var_b7fd22ccc4fb4299) {
  self hide();

  if(istrue(var_b7fd22ccc4fb4299)) {
    level.var_cde4ae1afb90a57a = array_remove(level.var_cde4ae1afb90a57a, self);
  }

  wait 1;

  if(isDefined(self)) {
    self delete();
  }
}

function function_6fd64a7766f2f12a(grenade) {
  grenade thread function_a66b069993cf9abb();
  var_8eee8435268b02da = getdvarfloat(@ "hash_7ad66a5bc22f0e3c");
  facingangles = self getgunangles();
  launchpoint = grenade.origin;
  startpointdistance = 100;
  endpointdistance = 1250 * var_8eee8435268b02da;
  var_8db1219df8466cef = launchpoint + anglesToForward(facingangles) * startpointdistance;
  var_c56004b641a6e904 = launchpoint + anglesToForward(facingangles) * endpointdistance;
  startvelocity = anglesToForward(facingangles) * 1250;
  collisioncontents = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  tracehit = physics_raycast(self gettagorigin("tag_eye"), var_8db1219df8466cef, collisioncontents, self, 0, "physicsquery_any");

  if(istrue(tracehit)) {
    return;
  }

  bundle = level.streakglobals.streakbundles["switchblade_drone"];
  switchblade_drone = self launchgrenade(bundle.droneweapon, var_8db1219df8466cef, startvelocity);
  switchblade_drone setscriptablepartstate("visibility", "show");
  switchblade_drone.angles = grenade.angles;
  switchblade_drone.team = self.team;
  switchblade_drone.owner = self;
  switchblade_drone.targetorigin = var_c56004b641a6e904;

  if(istrue(bundle.var_9b2586bfb4f3de46) && issharedfuncdefined("game", "createObjective")) {
    switchblade_drone.minimapid = switchblade_drone[[getsharedfunc("game", "createObjective")]](bundle.minimapicon, switchblade_drone.team, 1, 1, 1);
    scripts\mp\objidpoolmanager::function_2946e9eb07acb3f1(switchblade_drone.minimapid, &"KILLSTREAKS/SWITCHBLADE_DRONE");
  }

  return switchblade_drone;
}

function function_f50add73e923b629(streakname, location) {
  level notify("stop_switchblade_droneMoveCircle_thread");
  level endon("game_ended");

  if(!isDefined(location)) {
    self endon("death");
  }

  if(!isDefined(streakname)) {
    streakname = "switchblade_drone";
  }

  bundle = level.streakglobals.streakbundles[streakname];
  var_3174aa0f12ab01af = getdvarint(@ "hash_22f1ccc4024de95e");
  var_e605bf7deeb6a128 = getdvarint(@ "hash_a80f427a9d36e9fe");
  var_2b9d8028c0dcbb6d = getdvarint(@ "hash_f10e873f6059cd5f");
  var_9e6c0acf6618c0a = getdvarint(@ "hash_b171aaba052d2c50");
  debugactive = getdvarint(@ "hash_211a27e9e936be16");
  var_603716bcd61d52f9 = getdvarint(@ "hash_f956bbb2c255914f");
  radius = bundle.dronemaxradius;
  height = bundle.droneminheight;
  centerpos = undefined;
  launchheight = undefined;

  if(isDefined(location)) {
    centerpos = location;
    launchheight = location[2];
  } else {
    centerpos = self.targetorigin;
    launchheight = self.targetorigin[2];
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_ainoshoot"]);
  var_d06f735a85408be7 = 0;

  while(!var_d06f735a85408be7) {
    radiusvector = (radius + var_9e6c0acf6618c0a, radius + var_9e6c0acf6618c0a, var_9e6c0acf6618c0a);
    centerpos = (centerpos[0], centerpos[1], launchheight + height);
    aabbmin = centerpos - radiusvector;
    aabbmax = centerpos + radiusvector;
    hits = physics_aabbquery(aabbmin, aabbmax, contents, [], "physicsquery_all");

    if(debugactive > 0) {
      function_36c55ae71072bd03(aabbmin, aabbmax, var_603716bcd61d52f9);
    }

    if(hits.size == 0) {
      var_d06f735a85408be7 = 1;
    }

    while(!var_d06f735a85408be7 && height <= bundle.dronemaxheight) {
      height += var_e605bf7deeb6a128;
      centerpos = (centerpos[0], centerpos[1], launchheight + height);
      aabbmin = centerpos - radiusvector;
      aabbmax = centerpos + radiusvector;
      hits = physics_aabbquery(aabbmin, aabbmax, contents, [], "physicsquery_all");

      if(debugactive > 0) {
        function_36c55ae71072bd03(aabbmin, aabbmax, var_603716bcd61d52f9);
      }

      if(hits.size == 0) {
        var_d06f735a85408be7 = 1;
        break;
      }
    }

    if(var_d06f735a85408be7 && !isDefined(location)) {
      startlocation = centerpos + anglesToForward(self.angles) * radius;
      self.startpos = startlocation;
      self.centerpos = centerpos;
      continue;
    }

    if(!var_d06f735a85408be7 && radius >= bundle.droneminradius + var_2b9d8028c0dcbb6d) {
      radius -= var_2b9d8028c0dcbb6d;
      height = bundle.droneminheight;
      continue;
    }

    break;
  }

  return var_d06f735a85408be7;
}

function function_e2cf8a8b93a4a86f() {
  self notify("stop_switchblade_tilt_thread");
  self endon("death");
  level endon("game_ended");
  self endon("stop_switchblade_tilt_thread");
  maxrolldegrees = getdvarint(@ "hash_7bd25800dfc29105");
  maxyawdiff = getdvarint(@ "hash_832a4160ba33c74b");
  var_cf4febe91831ea56 = (1, 0, 0);
  unityvector = (0, 1, 0);
  var_d2f1914cf518b7e0 = (0, 0, -1);
  waitframe();
  self.previousorigin = self.origin;
  self.targetangles = self.angles;

  while(true) {
    stepvector = self.origin - self.previousorigin;
    stepunit = vectorNormalize(stepvector);
    pitch = asin(vectordot(stepunit, var_d2f1914cf518b7e0));
    stepunit = (stepunit[0], stepunit[1], 0);
    stepunit = vectorNormalize(stepunit);
    yaw = acos(vectordot(stepunit, var_cf4febe91831ea56));

    if(vectordot(stepunit, unityvector) < 0) {
      yaw = 360 - yaw;
    }

    yawdiff = yaw - self.targetangles[1];

    if(abs(yawdiff) > 300) {
      yawdiff -= 360;
    }

    yawdiffclamped = clamp(yawdiff, maxyawdiff * -1, maxyawdiff);
    turnproportion = yawdiffclamped / maxyawdiff;
    roll = maxrolldegrees * turnproportion * -1;
    self.previousorigin = self.origin;
    newangles = (pitch, yaw, roll);
    self.targetangles = newangles;
    wait 0.05;
  }
}

function function_f57f532b8644012a() {
  self notify("stop_switchblade_step_thread");
  self endon("death");
  level endon("game_ended");
  self endon("stop_switchblade_step_thread");
  var_38a541b4d6af30a9 = getdvarint(@ "hash_57306177bd6ed859");
  var_9d60d851a7af2d4e = getdvarint(@ "hash_fa505002fe5586de");
  var_2a86c82583ac927b = getdvarint(@ "hash_636a1d843f1957eb");
  self.previousangles = self.angles;
  lastsign = 1;

  while(true) {
    if(isDefined(self.targetangles)) {
      fixedtargetpitch = angleclamp(self.targetangles[0]);
      fixedcurrentpitch = angleclamp(self.angles[0]);
      fixedtargetyaw = angleclamp(self.targetangles[1]);
      fixedcurrentyaw = angleclamp(self.angles[1]);
      var_9f3eda8daa0eda03 = angleclamp(self.targetangles[2]);
      var_641a388819ce1d85 = angleclamp(self.angles[2]);
      pitcherror = fixedtargetpitch - fixedcurrentpitch;
      yawerror = fixedtargetyaw - fixedcurrentyaw;
      rollerror = var_9f3eda8daa0eda03 - var_641a388819ce1d85;
      var_a5a7ce89b43ee10c = fixedtargetpitch - fixedcurrentpitch + 360;
      var_3ef2bd1018948fcc = fixedtargetpitch - fixedcurrentpitch - 360;

      if(abs(var_a5a7ce89b43ee10c) < abs(pitcherror)) {
        pitcherror = var_a5a7ce89b43ee10c;
      } else if(abs(var_3ef2bd1018948fcc) < abs(pitcherror)) {
        pitcherror = var_3ef2bd1018948fcc;
      }

      var_cd314f4801f94ceb = fixedtargetyaw - fixedcurrentyaw + 360;
      var_8a83d2c73960daab = fixedtargetyaw - fixedcurrentyaw - 360;

      if(abs(var_cd314f4801f94ceb) < abs(yawerror)) {
        yawerror = var_cd314f4801f94ceb;
      } else if(abs(var_8a83d2c73960daab) < abs(yawerror)) {
        yawerror = var_8a83d2c73960daab;
      }

      var_fe6c7708be15720b = var_9f3eda8daa0eda03 - var_641a388819ce1d85 + 360;
      var_26e224b6a576bacb = var_9f3eda8daa0eda03 - var_641a388819ce1d85 - 360;

      if(abs(var_fe6c7708be15720b) < abs(rollerror)) {
        rollerror = var_fe6c7708be15720b;
      } else if(abs(var_26e224b6a576bacb) < abs(rollerror)) {
        rollerror = var_26e224b6a576bacb;
      }

      pitchstep = self.angles[0] + clamp(pitcherror, var_9d60d851a7af2d4e * -1, var_9d60d851a7af2d4e);
      yawstep = self.angles[1] + clamp(yawerror, var_38a541b4d6af30a9 * -1, var_38a541b4d6af30a9);
      rollstep = self.angles[2] + clamp(rollerror, var_2a86c82583ac927b * -1, var_2a86c82583ac927b);
      newangles = (pitchstep, yawstep, rollstep);
      self.angles = newangles;
      lastsign = sign(yawerror);
    }

    wait 0.05;
  }
}

function function_6ec67c6c636c25d0(centerpos, startpos, flyvelocity) {
  self endon("death");
  level endon("game_ended");
  var_df9cc7f461e385d2 = getdvarint(@ "hash_aea510623d9c4c10");
  var_279949c8caf22661 = getdvarint(@ "hash_79f9928723395f7f");
  anglevector = centerpos - startpos;
  flytotaltime = var_df9cc7f461e385d2;
  flystarttime = gettime();
  flystartpoint = self.origin;
  var_265da53443f3b69a = (flystartpoint[0], flystartpoint[1], 0);
  var_94f5017ed47bc92c = flystartpoint[2];
  targetpos = centerpos - anglevector;
  targetposhorizontal = (targetpos[0], targetpos[1], 0);
  targetposvertical = targetpos[2];
  flytimepassed = 0;
  collisioncontents = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);

  while(flytimepassed < flytotaltime) {
    flytimepassed = gettime() - flystarttime;
    proportion = flytimepassed / flytotaltime;
    var_913e217a8e75ee8b = math::lerp(var_94f5017ed47bc92c, targetposvertical, easesine(proportion, 1, 1));
    var_fb260238a1374a21 = (0, math::angle_lerp(0, var_279949c8caf22661, proportion), 0);
    linearcomponent = vectorlerp(var_265da53443f3b69a, targetposhorizontal, proportion);
    anglevector = var_265da53443f3b69a - targetposhorizontal;
    circlecomponent = var_265da53443f3b69a - rotatevector(anglevector, var_fb260238a1374a21);
    var_cdd4af79a13df11d = vectorlerp(linearcomponent, circlecomponent, proportion);
    newpos = (var_cdd4af79a13df11d[0], var_cdd4af79a13df11d[1], var_913e217a8e75ee8b);
    tracehit = physics_raycast(self.origin, newpos, collisioncontents, self, 0, "physicsquery_any");

    if(istrue(tracehit)) {
      function_344501824416bd86(0);
      return;
    }

    self.origin = newpos;
    waitframe();
  }

  var_757932149c26a130 = (0, var_279949c8caf22661, 0);
  anglevector = centerpos - startpos;
  rotatedstartpos = centerpos - rotatevector(anglevector, var_757932149c26a130);
  thread function_5c89eb12f323ab1e(centerpos, rotatedstartpos, flyvelocity);
}

function function_5c89eb12f323ab1e(centerpos, startpos, flyvelocity) {
  self notify("flyingNewCircle");
  self endon("death");
  self endon("foundBestTarget");
  self endon("diveBombing");
  self endon("flyingNewCircle");
  level endon("game_ended");
  anglevector = centerpos - startpos;
  flyradius = distance(startpos, centerpos);
  totaltime = float(6.28 * flyradius / flyvelocity) * 1000;
  starttime = gettime();
  startangle = 0;
  endangle = 180;

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    timepassed = gettime() - starttime;
    fraction = min(timepassed / totaltime, 1);
    var_fb338f3adaa14f2c = math::angle_lerp(startangle, endangle, fraction);
    newvector = rotatevector(anglevector, (0, var_fb338f3adaa14f2c, 0));
    newpos = centerpos - newvector;
    self.origin = newpos;

    if(fraction >= 1) {
      starttime = gettime();
      anglevector = newvector;
    }

    waitframe();
  }
}

function function_171c9b525186dfee(streakname, centerposzoffset) {
  self endon("death");
  self endon("notify_switchblade_drone_explode");
  self.owner endon("disconnect");
  level endon("game_end");
  var_6ffab0b1f38dae17 = getdvarint(@ "hash_cda65d1126957523");
  wait var_6ffab0b1f38dae17;
  contents = physics_createcontents(["physicscontents_characterproxy", "physicscontents_vehicle"]);

  while(true) {
    centerpos = (self.origin[0], self.origin[1], self.origin[2] / 1.5);

    if(level.mapname == "mp_jup_vertigo" || level.mapname == "mp_jup_observatory") {
      centerpos = (self.origin[0], self.origin[1], self.origin[2] - 500);
    }

    if(!isDefined(streakname)) {
      streakname = "switchblade_drone";
    }

    if(isDefined(centerposzoffset)) {
      centerpos += (0, 0, centerposzoffset);
    }

    bundle = level.streakglobals.streakbundles["switchblade_drone"];
    var_9e6c0acf6618c0a = getdvarint(@ "hash_b171aaba052d2c50");
    lengthvector = (bundle.var_eed1966ca1124f9 / 2 + var_9e6c0acf6618c0a, bundle.var_9e4f84bfa849e82b / 2 + var_9e6c0acf6618c0a, bundle.var_95c9f93c7b737ac6 + var_9e6c0acf6618c0a);
    aabbmin = centerpos - lengthvector;
    aabbmax = centerpos + lengthvector;
    hits = physics_aabbquery(aabbmin, aabbmax, contents, [], "physicsquery_all");

    var_7d5a24fd00c5eed = getdvarint(@ "hash_b0c1d0793ae379c7");
    debugactive = getdvarint(@ "hash_211a27e9e936be16");

    if(debugactive > 0) {
      var_603716bcd61d52f9 = getdvarint(@ "hash_f956bbb2c255914f");
      function_36c55ae71072bd03(aabbmin, aabbmax, var_603716bcd61d52f9);
    }

    validtargets = [];
    index = 0;

    foreach(hit in hits) {
      if(isPlayer(hit) || isagent(hit)) {
        if(hit hasperksharedfunc("specialty_blindeye")) {
          continue;
        }

        if(!istrue(callsharedfunc("player", "isReallyAlive", hit))) {
          continue;
        }
      }

      if(isDefined(hit.team) && hit.team != self.team) {
        function_47bd4689d0d9b39e(hit.origin);

        if(isPlayer(hit) || isagent(hit)) {
          validtargets[index] = hit;
          index++;
        } else if(isDefined(hit.owner) && isDefined(hit.ownerteam) && hit.ownerteam != self.team) {
          validtargets[index] = hit;
          index++;
        } else if(isDefined(hit.vehicletype) && hit.team != "neutral") {
          validtargets[index] = hit;
          index++;
        }
      }

      if(istrue(var_7d5a24fd00c5eed)) {
        if((isPlayer(hit) || isagent(hit)) && isDefined(hit.team) && hit.team == self.team) {
          function_47bd4689d0d9b39e(hit.origin);
          validtargets[index] = hit;
          index++;
          continue;
        }

        if(isDefined(hit.owner) && isDefined(hit.ownerteam) && hit.ownerteam == self.team) {
          function_47bd4689d0d9b39e(hit.origin);
          validtargets[index] = hit;
          index++;
        }
      }

    }

    if(validtargets.size > 0) {
      function_a831421d6d91a68(validtargets);
    }

    wait bundle.var_2855f87b9236ea60;
  }
}

function function_a831421d6d91a68(validtargets) {
  validtargets = sortbydistance(validtargets, self.origin);
  var_68e6f05a4ee24dee = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);
  var_2fd6147a345c3d71 = physics_createcontents(["physicscontents_item", "physicscontents_ainoshoot"]);

  if(level.mapname == "mp_jup_elevated") {
    var_68e6f05a4ee24dee = physics_createcontents(["physicscontents_item", "physicscontents_ainoshoot"]);
  }

  foreach(target in validtargets) {
    debugactive = getdvarint(@ "hash_211a27e9e936be16");

    if(debugactive > 0) {
      var_603716bcd61d52f9 = getdvarint(@ "hash_f956bbb2c255914f");
      line(self.origin, target.origin, (0, 0, 100), 1, 0, var_603716bcd61d52f9);
    }

    var_97db5d48f2509e02 = undefined;

    if(isPlayer(target) || isagent(target)) {
      var_97db5d48f2509e02 = physics_raycast(self.origin, target.origin, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_closest");
    } else {
      var_97db5d48f2509e02 = physics_raycast(self.origin, target.origin, var_2fd6147a345c3d71, undefined, 0, "physicsquery_closest");
    }

    if(var_97db5d48f2509e02.size == 0) {
      self notify("foundBestTarget");
      function_1c87d0008280beb0(target);
      break;
    }
  }
}

function function_e99de59922a658c2(besttarget) {
  var_68e6f05a4ee24dee = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot"]);
  var_2fd6147a345c3d71 = physics_createcontents(["physicscontents_item", "physicscontents_ainoshoot"]);
  var_97db5d48f2509e02 = undefined;

  if(isPlayer(besttarget) || isagent(besttarget)) {
    var_97db5d48f2509e02 = physics_raycast(self.origin, besttarget.origin, var_68e6f05a4ee24dee, undefined, 0, "physicsquery_closest", 1);
  } else {
    var_97db5d48f2509e02 = physics_raycast(self.origin, besttarget.origin, var_2fd6147a345c3d71, undefined, 0, "physicsquery_closest", 1);
  }

  if(var_97db5d48f2509e02.size == 0) {
    return true;
  }

  return false;
}

function function_1c87d0008280beb0(besttarget, targetloc) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_end");
  self.var_c69028d21747744b = 1;
  starttime = gettime();
  timepassed = 0;
  var_90f8682d56eb4664 = getdvarint(@ "hash_836eeca87d3a3d6f");
  var_a4e60d1f42b38d56 = getdvarint(@ "hash_fc2d155242a3fc25");

  if(isDefined(self.streakname) && self.streakname == "drone_swarm") {
    var_90f8682d56eb4664 = getdvarint(@ "hash_f065b6bad78c93b9");
    var_a4e60d1f42b38d56 = getdvarint(@ "hash_b6455b787cd7cbab");
  }

  assert(var_90f8682d56eb4664 > 0);
  assert(var_a4e60d1f42b38d56 > 0);
  var_433184866bfb7ebc = getdvarint(@ "hash_3bc605f5a6462807");
  self setscriptablepartstate("lockedOn", "preparing", 1);
  startpos = self.origin;
  lowertargetpos = startpos - anglestoup(self.angles) * var_433184866bfb7ebc;
  var_e054a30a6db5956c = getdvarint(@ "hash_9bb73c3ac9654260");
  var_211bf2b19120d8ab = getdvarint(@ "hash_d40e17bd9fa003a1");
  preparecenter = self.origin + vectorNormalize(self.centerpos - self.origin) * var_211bf2b19120d8ab;
  thread function_5c89eb12f323ab1e(preparecenter, self.origin, var_e054a30a6db5956c);

  while(timepassed < var_90f8682d56eb4664) {
    timepassed = gettime() - starttime;

    if(isent(besttarget)) {
      isinlos = function_e99de59922a658c2(besttarget);
    }

    if(isDefined(isinlos) && !istrue(isinlos)) {
      self setscriptablepartstate("lockedOn", "idle", 1);
      thread function_5c89eb12f323ab1e(self.centerpos, self.origin, var_e054a30a6db5956c);
      self.var_c69028d21747744b = 0;
      return;
    }

    wait 0.1;
  }

  while(timepassed < var_a4e60d1f42b38d56) {
    timepassed = gettime() - starttime;

    if(function_b6d0baeed8dac51(besttarget, targetloc)) {
      function_3c15b092a77b0142(besttarget, targetloc);
      return;
    }

    wait 0.1;
  }

  function_3c15b092a77b0142(besttarget, targetloc);
}

function function_b6d0baeed8dac51(target, targetloc) {
  targetorigin = undefined;

  if(isDefined(target)) {
    targetorigin = target.origin;
  } else if(isDefined(targetloc)) {
    targetorigin = targetloc;
  } else {
    assertmsg("<dev string:x1c>");
    return false;
  }

  var_6d2275b0b1b6da95 = (targetorigin[0], targetorigin[1], targetorigin[2]);
  fromtarget = vectorNormalize(var_6d2275b0b1b6da95 - self.origin);
  var_1ebe75779c2d5f96 = vectorNormalize(anglesToForward(self.angles));
  dot = vectordot(fromtarget, var_1ebe75779c2d5f96);

  if(dot <= 0) {
    return false;
  }

  dotthreshold = 0.7;

  if(dot > dotthreshold) {
    return true;
  }

  return false;
}

function function_3c15b092a77b0142(target, targetloc) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_end");
  self notify("diveBombing");
  assert(isDefined(target) || isDefined(targetloc));
  targetpos = undefined;

  if(isDefined(target)) {
    targetpos = target.origin;
  } else if(isDefined(targetloc)) {
    targetpos = targetloc;
  } else {
    assertmsg("<dev string:x60>");
    function_344501824416bd86(1);
    return;
  }

  starttime = gettime();
  startpos = self.origin;
  totaldistance = distance(self.origin, targetpos);
  self setscriptablepartstate("lockedOn", "moving", 1);
  var_3174aa0f12ab01af = getdvarint(@ "hash_22f1ccc4024de95e");
  var_134d0390a5b98256 = getdvarint(@ "hash_1da226fe14849c74");
  var_39a9b19eabdfe7d = getdvarint(@ "hash_b9597bb5bad14e63");

  if(isDefined(self.streakname) && self.streakname == "drone_swarm") {
    var_134d0390a5b98256 = getdvarint(@ "hash_9719cfd50a1766ee");
  }

  totaltime = float(totaldistance / var_134d0390a5b98256 * 1000);
  assert(totaltime > 0);
  collisioncontents = undefined;

  if(isPlayer(target) || isagent(target)) {
    collisioncontents = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  } else {
    collisioncontents = physics_createcontents(["physicscontents_missileclip", "physicscontents_clipshot"]);
  }

  if(isDefined(level.var_b67b5f9dfe488c2f)) {
    thread[[level.var_b67b5f9dfe488c2f]](self.streakinfo);
  }

  while(distance(self.origin, targetpos) > var_39a9b19eabdfe7d) {
    timepassed = gettime() - starttime;
    fraction = float(min(timepassed / totaltime, 1));
    var_24c703f3c8ab20f8 = (startpos[0], startpos[1], 0);
    var_31924601a0fd6ef2 = startpos[2];
    targetposhorizontal = (targetpos[0], targetpos[1], 0);
    targetposvertical = targetpos[2];
    var_cdd4af79a13df11d = vectorlerp(var_24c703f3c8ab20f8, targetposhorizontal, fraction);
    var_913e217a8e75ee8b = math::lerp(var_31924601a0fd6ef2, targetposvertical, easesine(fraction, 1, 1));
    targetlocation = math::lerp(startpos, targetpos, easepower(fraction, 2, 1, 1));
    tracehit = physics_raycast(self.origin, targetlocation, collisioncontents, self, 0, "physicsquery_any");

    if(istrue(tracehit)) {
      function_344501824416bd86(1);
      return;
    }

    self.origin = targetlocation;
    waitframe();
  }

  self.var_c69028d21747744b = 0;
  function_344501824416bd86(1);

  if(isDefined(level.var_f56a88761038798b)) {
    thread[[level.var_f56a88761038798b]](self.streakinfo);
  }
}

function function_ea343190a5d1301e(data) {
  attacker = data.attacker;
  function_344501824416bd86(0);
}

function function_3a93e509a610b4bd(data) {
  attacker = data.attacker;
  function_344501824416bd86(0);
}

function function_344501824416bd86(fromtrigger) {
  params = spawnStruct();
  params.fromtrigger = fromtrigger;
  switchblade_drone_explode(params);
  callback::callback("on_functional_death");
}

function function_ba6789000bf88889(params) {
  params = spawnStruct();
  params.fromtrigger = 0;
  switchblade_drone_explode(params);
}

function function_4706f9311a69b5bc(params) {
  self.owner playkillstreakteamleaderdialog("switchblade_drone", "switchblade_drone_teamleader_timeout");
  switchblade_drone_explode(params);
}

function switchblade_drone_explode(params, var_f543b7749f9023af) {
  if(isDefined(level.var_ca1a76fbc0ba0bef)) {
    thread[[level.var_ca1a76fbc0ba0bef]](self.streakinfo, self.origin, 0);
  }

  if(!istrue(var_f543b7749f9023af)) {
    level.var_cde4ae1afb90a57a = array_remove(level.var_cde4ae1afb90a57a, self);
    bundle = level.streakglobals.streakbundles["switchblade_drone"];
  } else {
    level.var_f37653d229f1f1c4 = array_remove(level.var_f37653d229f1f1c4, self);
    bundle = level.streakglobals.streakbundles["drone_swarm"];
  }

  fromtrigger = params.fromtrigger;

  if(!isDefined(self)) {
    return;
  }

  forward = anglestoup(self.angles);
  right = -1 * anglestoright(self.angles);
  up = anglesToForward(self.angles);
  var_13e4641b8cbb438e = "explode";

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    var_13e4641b8cbb438e = "explode_noDamage";
  }

  var_f451f1efd8b651c8 = self getscriptablepartstate(var_13e4641b8cbb438e);

  if(var_f451f1efd8b651c8 == "fromtrigger") {
    return;
  }

  if(self.streakname == "switchblade_drone") {
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  var_7410e124269a94e1 = bundle.var_c871fa4ec0859926;
  maxdmg = bundle.var_eddb2ebe11eeda74;
  mindmg = bundle.var_7103fcd230ad81b6;
  var_de000fcd5162bbd2 = bundle.var_e9a78aad297298b;
  var_392f2adc951f611a = bundle.var_da4afb96fb921fd1;
  var_ed0a64c15fcaaa38 = bundle.var_b0ea710334746aa7;
  var_3433b360988a2327 = istrue(fromtrigger) ? "fromtrigger" : "fromdamage";

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    owner = self.owner;

    if(!isDefined(owner)) {
      owner = undefined;
    }

    if(var_3433b360988a2327 == "fromtrigger") {
      self radiusdamage(self.origin, var_7410e124269a94e1, maxdmg, mindmg, owner, "MOD_EXPLOSIVE", "switchblade_drone_mp");
    } else {
      self radiusdamage(self.origin, var_de000fcd5162bbd2, var_392f2adc951f611a, var_ed0a64c15fcaaa38, owner, "MOD_EXPLOSIVE", "switchblade_drone_mp");
    }
  }

  self setscriptablepartstate(var_13e4641b8cbb438e, var_3433b360988a2327, 0);
  self notify("notify_switchblade_drone_explode");
}

function function_8e41e9774021d4f0(msg, timer, radius, targetlength, targetwidth) {
  level endon("game_ended");
  drone = self;
  alliedplayers = [];
  alliedplayers = utility::callsharedfunc("game", "getTeamData", drone.owner.team, "players");
  circleradius = int(int(min(targetlength, targetwidth) / 2) + radius);
  drone.enemycircle = spawnStruct();
  drone.var_8014ebffbb88822b = spawnStruct();
  drone.enemycircle scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("switchblade_drone_danger_radius", drone.origin, circleradius);
  drone.enemycircle scripts\cp_mp\utility\game_utility::function_6988310081de7b45();

  foreach(player in alliedplayers) {
    drone.enemycircle scripts\cp_mp\utility\game_utility::function_d7d113d56ef0ef5b(player);
  }

  drone.var_8014ebffbb88822b scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522("switchblade_drone_ally_radius", drone.origin, circleradius);

  foreach(player in alliedplayers) {
    drone.var_8014ebffbb88822b scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f(player);
  }

  waittill_any_timeout_2(timer, msg, "game_ended");
  drone.enemycircle scripts\cp_mp\utility\game_utility::function_4eaf685bc40a3b9();
  drone.enemycircle scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
  drone.var_8014ebffbb88822b scripts\cp_mp\utility\game_utility::function_4eaf685bc40a3b9();
  drone.var_8014ebffbb88822b scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
}

function function_47bd4689d0d9b39e(center) {
  var_603716bcd61d52f9 = getdvarint(@ "hash_f956bbb2c255914f");
  sphere(center, 15, (0, 0, 255), 0, var_603716bcd61d52f9);
}

# /