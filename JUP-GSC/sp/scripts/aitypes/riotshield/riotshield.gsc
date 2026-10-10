/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\aitypes\riotshield\riotshield.gsc
********************************************************/

#using scripts\aitypes\bt_util;
#using scripts\anim\shared;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace riotshield;

function riotshield_init_cp(taskid) {
  if(istrue(self.briotshieldinitialized)) {
    return anim.success;
  }

  self.secondaryweapon = makeweapon("iw9_me_riotshield_mp");
  assertex(self.secondaryweapon.basename != "none", "Unable to make weapon iw9_me_riotshield_mp. Check csv");

  if(self.secondaryweapon.basename != "none") {
    utility::initweapon(self.secondaryweapon);
    self.riotshieldmodel = getweaponmodel(self.secondaryweapon);
    self.riotshieldmodeltag = "tag_weapon_left";
    self attachshieldmodel(self.riotshieldmodel, self.riotshieldmodeltag);
    self.bhasriotshieldattached = 1;
    self.briotshieldinitialized = 1;
    self.deathfunction = &function_d4b82c6f5cae75ee;
    self.isdeathfunctiondefined = 1;
    riotshield_common();
    self aisetriotshieldweapon(self.secondaryweapon);
    return anim.success;
  }

  return anim.failure;
}

function function_8cddb6d105408617(taskid) {
  if(istrue(self.briotshieldinitialized)) {
    return anim.success;
  }

  self.secondaryweapon = makeweapon("iw9_me_riotshield_mp");
  assertex(self.secondaryweapon.basename != "none", "Unable to make weapon iw9_me_riotshield_mp. Check csv");

  if(self.secondaryweapon.basename != "none") {
    utility::initweapon(self.secondaryweapon);
    self.riotshieldmodel = getweaponmodel(self.secondaryweapon);
    self.riotshieldmodeltag = "tag_weapon_left";
    self attachshieldmodel(self.riotshieldmodel, self.riotshieldmodeltag);
    self.bhasriotshieldattached = 1;
    self.briotshieldinitialized = 1;
    self.deathfunction = &function_d4b82c6f5cae75ee;
    self.isdeathfunctiondefined = 1;
    self.var_52ab8a7c95757f64 = "soldier_jup_ob";
    riotshield_common();
    self aisetriotshieldweapon(self.secondaryweapon);
    return anim.success;
  }

  return anim.failure;
}

function riotshield_init_sp(taskid) {
  if(istrue(self.briotshieldinitialized)) {
    return anim.success;
  }

  assertex(self.secondaryweapon.basename != "none", "Unable to make weapon iw9_me_riotshield_sp. Check if the aitype GDT has a secondaryweapon");
  self function_9f82c74eb1b7caf9(0, "entity");
  self.script_goalheight = 80;

  if(self.secondaryweapon.basename != "none") {
    utility::initweapon(self.secondaryweapon);
    self.riotshieldmodel = getweaponmodel(self.secondaryweapon);
    self.riotshieldmodeltag = "tag_weapon_left";
    self attach(self.riotshieldmodel, self.riotshieldmodeltag);
    self.bhasriotshieldattached = 1;
    self.briotshieldinitialized = 1;
    self.deathfunction = &function_d4b82c6f5cae75ee;
    self.isdeathfunctiondefined = 1;
    riotshield_common();
    delaycall(0.05, &aisetriotshieldweapon, self.secondaryweapon);
    return anim.success;
  }

  return anim.failure;
}

function function_d4b82c6f5cae75ee() {
  if(!istrue(self.dropweapon) || istrue(self.bdroppingshield) || istrue(self.script_noloot) || istrue(self.script_nodrop)) {
    return false;
  }

  shieldweapon = self.secondaryweapon;

  if(isnullweapon(shieldweapon)) {
    shieldweapon = self.primaryweapon;
  }

  droppedweapon = spawn("weapon_" + getcompleteweaponname(shieldweapon), self gettagorigin(self.riotshieldmodeltag));
  droppedweapon.angles = self gettagangles(self.riotshieldmodeltag);
  droppedweapon physicslaunchserveritem(droppedweapon.origin, (0, 0, 15));
  return false;
}

function riotshield_common() {
  self allowedstances("stand");
  self.minpaindamage = 0;
  self.var_9aa77ab756fdca82 = 0;
  self.aggressivemode = 1;
  self.disablereload = 1;
  self.meleechargedistvsplayer = 120;
  self.meleechargedist = 120;
  self.meleestopattackdistsq = 14400;
  self.meleemaxzdiff = 500;
  self.meleetargetallowedoffmeshdistsq = 2500;
  self.meleetryhard = 0;
  self.meleeignorefinalzdiff = 0;
  self.meleeignoreplayerstance = 1;
  self.dontsyncmelee = 1;
  self.dontmeleeme = 1;
  self.disablebulletwhizbyreaction = 1;
  self function_9f82c74eb1b7caf9(0, "entity");
  self.disablerunngun = 1;
  self.disabledodge = 1;
  self.pathenemyfightdist = 0;
  self.maxfaceenemydist = 1200;
  self.var_54294e8bb0d07cda = 0;
  self.var_98add129a7ecb962 = 0;
  self function_ae41fbf799ba43f(1, "entity");
  self.ignoresuppression = 0;
  self.suppressionincrement = 0.03;
  self.suppressiondecrement = 0.005;
  self.suppressionthreshold = 0.5;
  self.var_9440dc8a2aa90aed = 3000;
  self.var_7d606bec79308eb5 = 512;
  self.var_85a0f6383a5dd784 = 360;
  self.var_a67833fea11a521c = 360;
  self.var_427cbd3288a2f59 = 128;
  self.var_5e7d402b7b6e5c12 = 25;
  self.var_20833644cc82839f = 200;
  self.goalheight = 80;
  self.usechokepoints = 0;
  self.cautiousnavigation = 0;
  self.var_717eb05b8fb85cff = 40;
  self.var_e2b553399f5ff8a3 = 1000;
  self.var_e2d849399f862a5d = 2000;
  self.var_7878ef8b36bc3525 = 1000;
  self.var_789bf98b36e292db = 2000;
  self.combat_func_active = 1;
  self enabletraversals(1);
}

function terminateriotshield() {
  self allowedstances("stand", "crouch", "prone");
  self.minpaindamage = 0;
  self.aggressivemode = 0;
  self.ignoresuppression = 0;
  self.disablereload = 0;
  self.meleedamageoverride = undefined;
  self.meleemaxzdiff = 36;
  self.meleeignoreplayerstance = 0;
  self.dontsyncmelee = undefined;
  self.dontmeleeme = 0;
  self.disablebulletwhizbyreaction = 0;
  self.combatmode = "cover";
  self.disablerunngun = 0;
  self.disabledodge = 0;
  self.pathenemyfightdist = 0;
  self enabletraversals(1);
}

function resetstuckthermite() {
  self.bhasthermitestucktoshield = 0;
  self.thermitestucktoshield = undefined;
  self.thermitestuckpains = undefined;
}

function removeriotshield() {
  if(istrue(self.bhasriotshieldattached)) {
    if(utility::issp()) {
      self detach(self.riotshieldmodel, self.riotshieldmodeltag);
    } else {
      self detachshieldmodel(self.riotshieldmodel, self.riotshieldmodeltag);
    }

    self.riotshieldmodel = undefined;
    self.riotshieldmodeltag = undefined;
    self.bhasriotshieldattached = undefined;
  }
}

function function_a43626a85e6614f0(taskid) {
  if(!self.bdroppingshield) {
    thread dropshield();
  }
}

function function_97dbc630c790bfb3(taskid) {
  if(self.bdroppingshield) {
    assert(isDefined(self.weapon) && weaponclass(self.weapon) != "mg");
    self._blackboard.weaponrequest = "mg";
    self setbtgoalpos(4, self.origin);
    return anim.running;
  }

  return anim.failure;
}

function dropshield() {
  self endon("death");
  self.bdroppingshield = 1;
  ctimeout = 10000;
  var_47a17cb6c73a2a = gettime();

  while(!self asmeventfired(self.asmname, "drop_shield") && var_47a17cb6c73a2a + ctimeout > gettime()) {
    waitframe();
  }

  btimedout = var_47a17cb6c73a2a + ctimeout <= gettime();

  if(btimedout) {
    resetstuckthermite();
    self._blackboard.weaponrequest = "none";
    self.bdroppingshield = 0;
    self clearbtgoal(4);
    return;
  }

  self setbasearchetype("soldier");
  self setoverridearchetype("default", "soldier");
  scripts\asm\soldier\script_funcs::initanimspeedthresholds_soldier("soldier");
  shieldorigin = self gettagorigin(self.riotshieldmodeltag);
  shieldangles = self gettagangles(self.riotshieldmodeltag);

  if(!istrue(level.var_e97d3de5b99775a6)) {
    droppedweapon = spawn("weapon_" + getcompleteweaponname(self.secondaryweapon), self gettagorigin(self.riotshieldmodeltag));
    droppedweapon.angles = self gettagangles(self.riotshieldmodeltag);
    droppedweapon physicslaunchserveritem(droppedweapon.origin, (0, 0, 15));
    droppedweapon thread deleteaftertime(10);
  } else {
    shielddrop = spawn("script_model", shieldorigin);
    shielddrop.angles = shieldangles;
    shielddrop setModel(self.riotshieldmodel);
    shielddrop physicslaunchserver(shieldorigin, anglesToForward(self.angles) * 5);
    shielddrop thread deleteaftertime(3);
  }

  if(isDefined(self.thermitestucktoshield)) {
    foreach(thermite in self.thermitestucktoshield) {
      if(isDefined(thermite)) {
        thermite delete();
      }
    }
  }

  self.var_98add129a7ecb962 = 1;
  removeriotshield();
  resetstuckthermite();
  self.bdroppingshield = 0;
  self clearbtgoal(4);
  terminateriotshield();
  self._blackboard.weaponrequest = "none";
  soldiertype = default_to(self.var_52ab8a7c95757f64, "soldier_agent");
  scripts\aitypes\bt_util::bt_terminateandreplace(soldiertype);
  weapclass = weaponclass(self.weapon);
  scripts\anim\shared::updateweaponarchetype(weapclass);
}

function deleteaftertime(t) {
  self endon("death");
  wait t;
  self delete();
}