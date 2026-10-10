/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\killstreaks\ims.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using script_608c50392df8c7d1;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace ims;

function autoexec main() {
  function_df7ab5b0f898e8bc(function_1823ff50bb28148d("ims"), &init);
}

function private init() {
  if(issharedfuncdefined("killstreak", "registerKillstreak")) {
    [[getsharedfunc("killstreak", "registerKillstreak")]]("ims", &function_81c2d38662659380);
  }

  scripts\engine\utility::registersharedfunc("ims", "tryUseKillstreak", &function_81c2d38662659380);
  scripts\engine\utility::registersharedfunc("ims", "ims_onHacked", &ims_onhacked);
  scripts\engine\utility::registersharedfunc("ims", "ims_getKillCamTime", &ims_getkillcamtime);
  bundle = level.streakglobals.streakbundles["ims"];

  if(isDefined(bundle) && isDefined(bundle.var_b081bae2811785e4)) {
    function_a41e3a211a9e37a4("ims", bundle.deployweapon, #"hash_b76b2215370d2700");
    function_a41e3a211a9e37a4("ims", bundle.var_b081bae2811785e4, #"hash_b76b2215370d2700");
    function_a41e3a211a9e37a4("ims", bundle.var_d5103347b49b5137, #"large");
  }

  val::group_register("ims_placement", ["sprint", "supersprint", "offhand_weapons", "melee", "execution_attack", "weapon_pickup", "supers", "ladder_placement", "mantle"]);
  game["dialog"]["destroyed_ims"] = "core_ims_destroyed";
  game["dialog"][#"ims"] = "core_ims_ready";
  game["dialog"]["ims_teamleader_enemy_inbound"] = "core_ims_active_hostile";
}

function function_81c2d38662659380(streakinfo) {
  if(!isDefined(streakinfo)) {
    streakinfo = createstreakinfo("ims", self);
  }

  bundle = level.streakglobals.streakbundles["ims"];

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return 0;
    }
  }

  var_b21b330507802512 = function_656b1df2883cb84a(streakinfo, bundle);

  if(isDefined(var_b21b330507802512)) {
    return function_23393407fcd8fed9(var_b21b330507802512, streakinfo, bundle);
  }

  return 0;
}

function function_656b1df2883cb84a(streakinfo, bundle) {
  level endon("game_ended");
  self endon("disconnect");
  streakinfo.var_fb58a31c756db4cc = "ims_placement";
  deployweapon = makeweapon(bundle.deployweapon);
  deployresult = streakdeploy_doweaponfireddeploy(streakinfo, deployweapon, "grenade_fire", undefined, &function_7b879fdbfe04f84d, &function_834e110adc42e4cd);

  if(!istrue(deployresult)) {
    return undefined;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return undefined;
    }
  }

  self waittill("ims_missileStuckCheck", result, var_b21b330507802512);

  if(!istrue(result)) {
    if(isDefined(var_b21b330507802512)) {
      var_b21b330507802512 delete();
    }

    return undefined;
  }

  return var_b21b330507802512;
}

function function_7b879fdbfe04f84d(streakinfo, switchresult) {
  if(istrue(switchresult)) {
    thread function_c0e0ad71fc7ea876(streakinfo);
  }
}

function function_c0e0ad71fc7ea876(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isPlayer(self) && !isbot(self)) {
    self notifyonplayercommand("cancel_deploy", "+actionslot 3");
    self notifyonplayercommand("cancel_deploy", "+actionslot 4");
    self notifyonplayercommand("cancel_deploy", "+actionslot 5");
    self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  }

  result = waittill_any_return_3("cancel_deploy", "weapon_switch_started", "ims_fired");

  if(isDefined(result) && result != "ims_fired") {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
  }

  if(isPlayer(self) && !isbot(self)) {
    self notifyonplayercommandremove("cancel_deploy", "+actionslot 3");
    self notifyonplayercommandremove("cancel_deploy", "+actionslot 4");
    self notifyonplayercommandremove("cancel_deploy", "+actionslot 5");
    self notifyonplayercommandremove("cancel_deploy", "+actionslot 6");
  }
}

function function_834e110adc42e4cd(streakinfo, weaponobj, projectile) {
  self notify("ims_fired");
  streakinfo notify("killstreak_finished_with_deploy_weapon");

  if(!isDefined(projectile)) {
    return "failure";
  }

  thread function_614dcd3acccb0ef8(projectile);
  return "success";
}

function function_614dcd3acccb0ef8(var_b21b330507802512) {
  level endon("game_ended");
  self endon("disconnect");
  result = var_b21b330507802512 waittill_any_timeout_1(10, "missile_stuck");

  if(!isDefined(result) || result == "timeout") {
    self notify("ims_missileStuckCheck", 0, var_b21b330507802512);
    return;
  }

  ishit = function_7480e044dad105d3(var_b21b330507802512);
  self notify("ims_missileStuckCheck", !ishit, var_b21b330507802512);
}

function function_7480e044dad105d3(var_b21b330507802512) {
  bundle = level.streakglobals.streakbundles["ims"];
  verticaloffset = getdvarfloat(@ "hash_f4da9af39e4b013e", 30);
  startpos = var_b21b330507802512.origin + (0, 0, verticaloffset);
  maxheight = getdvarfloat(@ "hash_c4ea2188934a7074", bundle.var_ddc0fa239714c263) - verticaloffset;
  minheight = getdvarfloat(@ "hash_4f29060321502b96", bundle.var_6425d998181ae311) - verticaloffset;
  radius = getdvarfloat(@ "hash_26d52d1f90cea54c", 15);
  ishit = 0;

  for(i = 0; i < 3; i++) {
    lerpval = (2 - i) / 2;
    height = math::lerp(minheight, maxheight, lerpval);
    ishit = physics_spherecast(startpos, startpos + (0, 0, height), radius, function_2c64943762efc5b3(), [self], "physicsquery_any");

    if(!ishit) {
      var_b21b330507802512.var_e91c2cea91022dd7 = startpos[2] + height - getdvarfloat(@ "hash_46238b5b95d2b806", 10);
      break;
    }
  }

  if(ishit && issharedfuncdefined("hud", "showErrorMessage")) {
    self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_PLACED_VERTICAL");
  }

  return ishit;
}

function function_23393407fcd8fed9(var_b21b330507802512, streakinfo, bundle) {
  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.streakname, self.origin);
  }

  var_b21b330507802512.team = self.team;
  var_b21b330507802512.owner = self;
  var_b21b330507802512.bundle = bundle;
  var_b21b330507802512.streakinfo = streakinfo;
  var_b21b330507802512 function_5226227bce83ebe9(3, var_b21b330507802512.team);
  var_b21b330507802512 setscriptablepartstate("main", "active");
  triggerheight = getdvarfloat(@ "hash_c9a02b1b4788fdad", bundle.var_cdbb10f266b1b353);
  triggerradius = getdvarfloat(@ "hash_80e13919a9eda3e4", bundle.var_453a3fbfc6c8bfde);
  triggerorigin = var_b21b330507802512.origin - (0, 0, triggerheight / 2);
  var_b21b330507802512.trigger = spawn("trigger_radius", triggerorigin, 0, triggerradius, triggerheight);
  var_b21b330507802512.trigger enablelinkTo();
  var_b21b330507802512.trigger linkTo(var_b21b330507802512);
  var_b21b330507802512.killstreakref = "ims";
  var_f16af5a8c61c30ee = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("ims", 1);
  var_f16af5a8c61c30ee.radius = triggerradius;
  var_b21b330507802512 setnodeploy(1);
  var_b21b330507802512 setnonstick(1);

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_b21b330507802512[[getsharedfunc("killstreak", "addToActiveKillstreakList")]]("ims", "Killstreak_Ground", self, 0, 1, 20, "picked_up");
  }

  if(issharedfuncdefined("game", "createObjective")) {
    var_b21b330507802512.minimapid = var_b21b330507802512[[getsharedfunc("game", "createObjective")]]("jup_hud_icon_minimap_killstreak_ims", var_b21b330507802512.team, 1, 1, 1);
  }

  var_b21b330507802512 function_ae53424c3a02628d(bundle, var_b21b330507802512.origin, self, self.team);

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](var_b21b330507802512.owner, "ims");
  }

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    thread function_f3bb4f4911a1beb2("hud", "teamPlayerCardSplash", "used_" + "ims", self);
  }

  level.mines[var_b21b330507802512 getentitynumber()] = var_b21b330507802512;
  var_b21b330507802512 function_5135b43ac04db778(streakinfo);
  var_b21b330507802512.var_7b74576b3641cd0e = 1;
  var_b21b330507802512 thread function_18649ada89b35500(streakinfo);
  var_b21b330507802512.deletefunc = &function_c334dc3fbd181380;
  var_b21b330507802512 scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_4eb4ab5799798bd);
  var_b21b330507802512 scripts\cp_mp\equipment\haywire::function_aa823a31304ed981(&function_fac556ff047c5d0c);
  var_b21b330507802512 scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_f48d50b96e53d41e);
  var_b21b330507802512 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&function_5911b997c2c053cf);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    var_b21b330507802512[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_f48d50b96e53d41e);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    var_b21b330507802512[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_5911b997c2c053cf);
  }

  self notify("munitions_used", "ims");
  return true;
}

function function_5135b43ac04db778(streakinfo) {
  if(issharedfuncdefined("damage", "onKillstreakKilled")) {
    function_9469d528dd1ee44d("ims", "destroyed_ims", "destroyed_ims", "callout_destroyed_ims");
  }

  if(issharedfuncdefined("damage", "monitorDamage")) {
    maxhealth = getdvarfloat(@ "hash_b222a9d8ac2c3cca", self.bundle.maxhealth);
    self thread[[getsharedfunc("damage", "monitorDamage")]](maxhealth, "hitequip", &function_66a7440055d386c3, &function_e8455a055dd3291e, 1);
  }

  thread function_8ea10054f46819ff();
  function_63d1a11f8b22244(streakinfo, &function_1289945a339f4036, &ims_destroy);
}

function function_8ea10054f46819ff() {
  self endon("death");
  self endon("beingDestroyed");
  lifetime = getdvarfloat(@ "hash_53e414eab9e6ac98", self.bundle.var_67a026a185f5acc7);

  if(issharedfuncdefined("hostmigration", "waitLongDurationWithPause")) {
    [[getsharedfunc("hostmigration", "waitLongDurationWithPause")]](lifetime);
  } else {
    wait lifetime;
  }

  if(isDefined(self)) {
    function_5d0eaa8d307bf8eb(1);
  }
}

function function_e8455a055dd3291e(data) {
  if(isDefined(data.objweapon) && data.objweapon.basename == self.bundle.var_d5103347b49b5137) {
    return 0;
  }

  modifieddamage = function_7bdb3610d602438d(data);
  newhealth = self.health - modifieddamage;
  percentage = newhealth / self.maxhealth;

  if(percentage <= 0.5 && self getscriptablepartstate("damaged") == "not_damaged") {
    self setscriptablepartstate("damaged", "damaged");
  }

  return modifieddamage;
}

function function_c334dc3fbd181380() {
  if(!istrue(self.var_acab919caaee35b)) {
    thread function_5d0eaa8d307bf8eb();
    self.var_acab919caaee35b = 1;
  }
}

function function_5d0eaa8d307bf8eb(var_82e1f0da54b6a7c2) {
  params = spawnStruct();
  params.var_cb0905963902d9f2 = var_82e1f0da54b6a7c2;
  callback::callback("on_functional_death", params);
}

function function_1289945a339f4036(callbackparams) {
  self notify("beingDestroyed");

  if(istrue(callbackparams.var_cb0905963902d9f2)) {
    self setscriptablepartstate("explode", "regular");
  } else {
    self setscriptablepartstate("explode", "violent");
  }

  wait 0.2;
}

function ims_destroy(delaytime) {
  if(isDefined(delaytime)) {
    wait delaytime;
  }

  level.mines[self getentitynumber()] = undefined;
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function function_989c61d885969255() {
  if(issharedfuncdefined("damage", "monitorDamage")) {
    var_4e32ba8da52b0408 = isDefined(self.ims.bundle.var_a47f1b01d6aa5776) ? self.ims.bundle.var_a47f1b01d6aa5776 : 0;
    maxhealth = getdvarfloat(@ "hash_48bba04fea7ee0c2", var_4e32ba8da52b0408);

    if(maxhealth > 0) {
      self thread[[getsharedfunc("damage", "monitorDamage")]](maxhealth, "hitequip", &function_b6c9429f69da8547, &function_5c030b265dec36c1, 0);
    }
  }
}

function function_5c030b265dec36c1(data) {
  modifieddamage = function_7bdb3610d602438d(data);
  return modifieddamage;
}

function function_b6c9429f69da8547(data) {
  thread function_64dc6cc90969788e();
}

function function_64dc6cc90969788e() {
  level endon("game_ended");

  if(!isDefined(self)) {
    return;
  }

  ims = self.ims;
  targetstruct = self.targetstruct;
  chargeindex = self.chargeindex;
  self notify("premature_detonate");
  waitframe();

  if(isDefined(self)) {
    self detonate();
  }

  ims function_9deaa23e63eed3aa(targetstruct, chargeindex);
}

function private function_2c64943762efc5b3(var_872d2e62cee02ee4) {
  resultarray = ["physicscontents_missileclip", "physicscontents_clipshot", "physicscontents_glass"];

  if(isDefined(var_872d2e62cee02ee4) && var_872d2e62cee02ee4) {
    resultarray = array_add(resultarray, "physicscontents_characterproxy");
  }

  return physics_createcontents(resultarray);
}

function function_18649ada89b35500(streakinfo) {
  self endon("death");
  level endon("game_ended");
  self.chargesleft = 4;
  self.var_56fb7fd3dba474a8 = [];
  var_c2eff716d026f5b9 = 0;

  var_c2eff716d026f5b9 = getdvarint(@ "hash_9fbc814198194d10", 0) == 1;

  while(self.chargesleft > 0 || var_c2eff716d026f5b9) {
    self.trigger waittill("trigger", ent);

    if(!self.var_7b74576b3641cd0e) {
      continue;
    }

    entitynumber = ent getentitynumber();

    if(array_contains(self.var_56fb7fd3dba474a8, entitynumber)) {
      continue;
    }

    var_3c3a2218a2004953 = 0;

    if(ent.classname == "script_vehicle") {
      if(ent function_7301c72ad9f3a95b(self)) {
        continue;
      }

      var_3c3a2218a2004953 = function_e806ce4a6f3d2032(streakinfo, ent, 0);
    }

    if(isagent(ent) || isPlayer(ent)) {
      if(ent function_a139d7d429ed5794(self)) {
        continue;
      }

      var_3c3a2218a2004953 = function_e806ce4a6f3d2032(streakinfo, ent, 1);
    }

    if(var_3c3a2218a2004953) {
      self.var_56fb7fd3dba474a8 = array_add(self.var_56fb7fd3dba474a8, entitynumber);
      self.chargesleft--;

      if(self.chargesleft == 0 && !var_c2eff716d026f5b9) {
        function_ed3cf13f3ab6b459();
      }
    }
  }
}

function function_ed3cf13f3ab6b459() {
  self.selfdestructing = 1;
  wait 3;
  function_5d0eaa8d307bf8eb(1);
}

function function_7301c72ad9f3a95b(grenade) {
  if(scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_isfriendlytomine(grenade)) {
    return true;
  }

  if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(self, grenade)) {
    return true;
  }

  return false;
}

function function_a139d7d429ed5794(ims) {
  if(!isreallyalive(self) || !isenemy(ims.owner) || isDefined(self.vehicle) || istrue(function_f3bb4f4911a1beb2("perk", "hasPerk", "specialty_blindeye"))) {
    return true;
  }

  return false;
}

function function_e806ce4a6f3d2032(streakinfo, target, targetisplayer) {
  var_80a4c3c82be14d8b = ["j_lids_01", "j_lids_02", "j_lids_03", "j_lids_04"];
  chargeindex = (4 - self.chargesleft) % 4;
  up = (0, 0, 1);
  chargestartpos = self gettagorigin(var_80a4c3c82be14d8b[chargeindex]) + up * 10;
  targetpos = target.origin + (0, 0, getdvarfloat(@ "hash_e08464464d929411", self.bundle.var_e331ff54ff2cd850));
  var_bcf224d10d5a475a = (chargestartpos[0], chargestartpos[1], self.var_e91c2cea91022dd7);
  castresults = physics_raycast(var_bcf224d10d5a475a, targetpos, function_2c64943762efc5b3(), [], 0, "physicsquery_closest", 1);

  if(isDefined(castresults) && castresults.size > 0) {
    return false;
  }

  thread function_bad0139fc2b1a50a(streakinfo, target, targetisplayer, chargeindex, chargestartpos, var_bcf224d10d5a475a);
  return true;
}

function function_bad0139fc2b1a50a(streakinfo, target, targetisplayer, chargeindex, chargestartpos, var_bcf224d10d5a475a) {
  level endon("game_ended");
  bundle = self.bundle;
  owner = self.owner;
  targetstruct = target function_644649e9a1a7cbd5(bundle);

  if(isDefined(target) && targetisplayer && issharedfuncdefined("perk", "hasPerk") && target[[getsharedfunc("perk", "hasPerk")]]("specialty_delaymine")) {
    wait level.delayminetime;
  }

  self setscriptablepartstate("charge_" + chargeindex, "used");
  assert(isDefined(bundle.var_b081bae2811785e4));
  var_8dbdaa141f4b9787 = getdvarfloat(@ "hash_d2d758f71d991a51", bundle.var_da265e5e2b97837e);
  gravity = (0, 0, getdvarfloat(@ "hash_a55083bd04392924", bundle.var_fb30ab192f5c9944));
  charge = owner launchgrenade(bundle.var_b081bae2811785e4, chargestartpos, (0, 0, 0), var_8dbdaa141f4b9787);
  charge.streakinfo = streakinfo;
  charge.ims = self;
  charge.chargeindex = chargeindex;
  charge.targetstruct = targetstruct;
  charge endon("premature_detonate");
  charge thread function_a7717005df7f9bfe(owner, chargestartpos, var_bcf224d10d5a475a, var_8dbdaa141f4b9787, gravity);
  charge function_989c61d885969255();
  killcament = function_c622b2349376bb11(target, var_bcf224d10d5a475a, bundle);
  charge.killcament = killcament;
  charge waittill("explode", explodepos);
  timetotarget = getdvarfloat(@ "hash_db9763666846c7b2", bundle.var_be7e2889fb89c2d);
  gravity = (0, 0, getdvarint(@ "bg_gravity") * -1);
  velocity = trajectorycalculateinitialvelocity(explodepos, targetstruct function_cf9631cd88628853(), gravity, timetotarget);
  explosive = owner launchgrenade(bundle.var_d5103347b49b5137, explodepos, velocity, timetotarget);
  explosive.streakinfo = streakinfo;
  explosive.killcament = killcament;
  explosive thread function_ee6f840d2c3768a0(bundle, owner, targetstruct);
  explosive thread function_8c3c6c363d29a4d1(self, targetstruct, chargeindex);
}

function function_a7717005df7f9bfe(owner, startpos, endpos, timetotarget, gravity) {
  level endon("game_ended");
  self endon("explode");
  self endon("premature_detonate");
  velocity = trajectorycalculateinitialvelocity(startpos, endpos, gravity, timetotarget);
  newposition = startpos;
  previoustime = gettime();
  collisioncontents = function_2c64943762efc5b3(1);

  while(true) {
    owner waittill("grenade_thrown", throwngrenade);

    if(throwngrenade == self) {
      break;
    }
  }

  while(true) {
    deltatime = (gettime() - previoustime) / 1000;
    previoustime = gettime();
    velocity += gravity * deltatime;
    newposition += velocity * deltatime;
    self.origin = newposition;
    var_e3ab46d4e385e1a1 = getdvarfloat(@ "hash_bbe98d05a761d42", 20);
    raycastend = newposition + var_e3ab46d4e385e1a1 * (0, 0, 1);
    ishit = physics_raycast(newposition, raycastend, collisioncontents, [], 0, "physicsquery_any");

    if(ishit) {
      self detonate();
      break;
    }

    waitframe();
  }
}

function function_644649e9a1a7cbd5(bundle) {
  targetstruct = spawnStruct();
  targetstruct.entity = self;
  targetstruct.originalpos = self.origin;
  targetstruct.entitynumber = self getentitynumber();
  targetstruct.targetverticaloffset = (0, 0, getdvarfloat(@ "hash_e08464464d929411", bundle.var_e331ff54ff2cd850));
  targetstruct childthread function_fb4f0e1e2c6baa4d();
  return targetstruct;
}

function function_fb4f0e1e2c6baa4d() {
  self endon("stop_watching");

  if(self.entity.classname == "script_vehicle") {
    self.entity waittill("death");
  } else {
    self.entity waittill("death_or_disconnect");
  }

  self.entity = undefined;
}

function function_cf9631cd88628853() {
  if(isDefined(self.entity)) {
    targetorigin = self.entity.origin;
  } else {
    targetorigin = self.originalpos;
  }

  return targetorigin + self.targetverticaloffset;
}

function function_ee6f840d2c3768a0(bundle, owner, targetstruct) {
  level endon("game_ended");
  self endon("explode");

  while(true) {
    owner waittill("grenade_thrown", throwngrenade);

    if(throwngrenade == self) {
      break;
    }
  }

  maxdistancesquared = squared(getdvarfloat(@ "hash_ce278dab5476cc61", bundle.var_8fa13aa5f07d036b));

  while(true) {
    targetposition = targetstruct function_cf9631cd88628853();
    distancesquared = distancesquared(self.origin, targetposition);

    if(distancesquared <= maxdistancesquared) {
      break;
    }

    waitframe();
  }

  self detonate(owner);
}

function function_8c3c6c363d29a4d1(var_b21b330507802512, targetstruct, chargeindex) {
  level endon("game_ended");
  self waittill("explode", org);
  var_b21b330507802512 function_9deaa23e63eed3aa(targetstruct, chargeindex);
}

function function_9deaa23e63eed3aa(targetstruct, chargeindex) {
  targetstruct notify("stop_watching");

  if(isDefined(self)) {
    thread function_727a02b074493b23(targetstruct);

    if(getdvarint(@ "hash_9fbc814198194d10", 0) == 1) {
      self setscriptablepartstate("<dev string:x1c>" + chargeindex, "<dev string:x27>");
    }
  }
}

function function_727a02b074493b23(targetstruct) {
  level endon("game_ended");
  self endon("death");
  delay = getdvarfloat(@ "hash_6460f7743a26cb23", self.bundle.var_83d7d1f966fae7c7);
  wait delay;

  if(isDefined(self)) {
    self.var_56fb7fd3dba474a8 = array_remove(self.var_56fb7fd3dba474a8, targetstruct.entitynumber);
  }
}

function function_c622b2349376bb11(target, var_a5642a3ed2115a4e, bundle) {
  var_925638aaf2dda0c = getdvarint(@ "hash_1be02ff78e57bf2", bundle.var_fa1d073397256fd1);
  var_2548ffb4d6a005a6 = getdvarint(@ "hash_8a2d11d62a20830c", bundle.var_81b7d14ea6d899a3);
  var_edf23aecf7a9eb55 = getdvarint(@ "hash_c7d138292495ffbc", bundle.var_e196dc13f46b6c9);
  var_93ad4dfa706c1ff5 = vectorNormalize((self.origin - target.origin) * (1, 1, 0));
  var_6b18820ef4ccf790 = vectorNormalize(vectorcross(var_93ad4dfa706c1ff5, (0, 0, 1)));
  maxoffset = var_93ad4dfa706c1ff5 * var_925638aaf2dda0c + (0, 0, var_2548ffb4d6a005a6);
  var_b31d7710d7a5ac7a = self.origin + maxoffset;
  var_9c36528e948bb378 = var_a5642a3ed2115a4e;
  collisioncontents = function_2c64943762efc5b3(1);
  killcampos = undefined;

  for(i = 0; i < 5; i++) {
    if(i < 3) {
      var_c12696933a3cf460 = vectorlerp(var_b31d7710d7a5ac7a, var_9c36528e948bb378, i / 3);
    } else if(i == 3) {
      var_c12696933a3cf460 = var_9c36528e948bb378 + var_6b18820ef4ccf790 * var_edf23aecf7a9eb55;
    } else if(i == 4) {
      var_c12696933a3cf460 = var_9c36528e948bb378 + var_6b18820ef4ccf790 * var_edf23aecf7a9eb55 * -1;
    }

    var_2b15c83ccf05be33 = physics_raycast(var_c12696933a3cf460, target.origin, collisioncontents, [self, target], 0, "physicsquery_any", 1);

    if(!var_2b15c83ccf05be33) {
      killcampos = var_c12696933a3cf460;
      break;
    }
  }

  if(!isDefined(killcampos)) {
    killcampos = var_9c36528e948bb378;
  }

  killcament = spawn("script_model", killcampos);
  killcament setscriptmoverkillcam("explosive");
  return killcament;
}

function ims_getkillcamtime() {
  bundle = level.streakglobals.streakbundles["ims"];
  var_8dbdaa141f4b9787 = getdvarfloat(@ "hash_d2d758f71d991a51", bundle.var_da265e5e2b97837e);
  timetotarget = getdvarfloat(@ "hash_db9763666846c7b2", bundle.var_be7e2889fb89c2d);
  return var_8dbdaa141f4b9787 + timetotarget;
}

function function_ee16e883a9e4d919(isactive, var_e817b0ad69ffec4c) {
  if(self.var_7b74576b3641cd0e == isactive) {
    return;
  }

  self.var_7b74576b3641cd0e = isactive;

  if(isactive) {
    scriptablestate = "active";
  } else {
    scriptablestate = "inactive";

    if(isDefined(var_e817b0ad69ffec4c) && scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      var_e817b0ad69ffec4c thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]]("disabled_ims");
    }
  }

  self setscriptablepartstate("main", scriptablestate, 1);
}

function function_4eb4ab5799798bd(data) {
  function_ee16e883a9e4d919(0, data.attacker);
  self.ishaywire = 1;
}

function function_fac556ff047c5d0c(data) {
  function_ee16e883a9e4d919(1);
}

function function_f48d50b96e53d41e(data) {
  function_ee16e883a9e4d919(0, data.attacker);
}

function function_5911b997c2c053cf(data) {
  function_ee16e883a9e4d919(1);
}

function ims_onhacked(newowner, oldowner) {
  function_2eff4cd94c3243e8();

  if(issharedfuncdefined("game", "createObjective")) {
    self.minimapid = self[[getsharedfunc("game", "createObjective")]]("jup_hud_icon_minimap_killstreak_ims", newowner.team, 1, 1, 1);
  }
}