/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_euphrates_create_script.gsc
************************************************************/

function ref_12d4b(var0) {
  if(istrue(self.disabledstate)) {
    return anim.success;
  }

  self.secondaryweapon = getcompleteweaponname("iw8_me_riotshield_cp_ai");
  ref_12d4a();
  self.disabledstate = 1;
  return anim.success;
}

function ref_12d4c(var0) {
  if(istrue(self.disabledstate)) {
    return anim.success;
  }

  self.secondaryweapon = getcompleteweaponname("iw8_me_riotshield_sp_ai");
  ref_12d4a();
  self.disabledstate = 1;
  return anim.success;
}

function ref_12d4a() {
  self allowedstances("stand");
  self.minpaindamage = 200;
  self.aggressivemode = 1;
  self.ignoresuppression = 1;
  self.disablereload = 1;
  self.meleechargedistvsplayer = 120;
  self.meleechargedist = 120;
  self.meleestopattackdistsq = 14400;
  self.meleedamageoverride = 400;
  self.meleemaxzdiff = 500;
  self.meleetargetallowedoffmeshdistsq = 2500;
  self.meleetryhard = 0;
  self.meleeignorefinalzdiff = 0;
  self.meleeignoreplayerstance = 1;
  self.dontsyncmelee = 1;
  self.dontmeleeme = 1;
  self.disablebulletwhizbyreaction = 1;
  self.combatmode = "no_cover";
  self.disablerunngun = 1;
  self.disabledodge = 1;
  self.pathenemyfightdist = 0;
  self.maxfaceenemydist = 768;

  if(isDefined(self.a)) {
    self.a.disablelongdeath = 1;
  }

  self.runcooldown = 3000;
  self.juggernautwalkdist = 750;
  self.juggernautstopdistance = 300;
  self.juggernautvisionobscuredwalkdist = 750;
  self.juggernautvisionobscuredstopdistance = 300;
  self.juggernautgoalradius = 25;
  self.vehicle_occupancy_errormessage = 200;
  self.goalheight = 80;
  self.usechokepoints = 0;
  self.cautiousnavigation = 0;
  self.juggernautacceleration = 40;
  self.juggernautcanseeenemydelaymin = 1000;
  self.juggernautcanseeenemydelaymax = 2000;
  self.juggernautrundelaymin = 1000;
  self.juggernautrundelaymax = 2000;
  self.combat_func_active = 1;
  self enabletraversals(0);
  self clearvehiclecamo(self.secondaryweapon);
  self.riotshieldmodel = "weapon_wm_riotshield_left_cp";
  self.ref_12d50 = "tag_weapon_left";
  self attachshieldmodel(self.riotshieldmodel, self.ref_12d50);
  self.clearsoundsubmixmpbrinfilanim = 1;
}

function ref_13af8() {
  self allowedstances("stand", "crouch", "prone");
  self.minpaindamage = 0;
  self.aggressivemode = 0;
  self.ignoresuppression = 0;
  self.disablereload = 0;
  self.meleedamageoverride = undefined;
  self.meleemaxzdiff = 36;
  self.meleeignoreplayerstance = 0;
  self.dontsyncmelee = undefined;
  self.dontmeleeme = undefined;
  self.disablebulletwhizbyreaction = undefined;
  self.combatmode = "cover";
  self.disablerunngun = 0;
  self.disabledodge = undefined;
  self.pathenemyfightdist = 0;
  self enabletraversals(1);
}

function ref_12c80() {
  self.clearspaceforscriptableinstance = undefined;
  self.ref_13b2c = undefined;
  self.ref_13b2a = undefined;
}

function ref_12c1c() {
  if(istrue(self.clearsoundsubmixmpbrinfilanim)) {
    self detachshieldmodel(self.riotshieldmodel, self.ref_12d50);
    self.riotshieldmodel = undefined;
    self.ref_12d50 = undefined;
    self.clearsoundsubmixmpbrinfilanim = undefined;
    return;
  }
}

function ref_12d49(var0) {
  if(istrue(self.clear_kill_off_flags_after_unload_wait)) {
    self._blackboard.weaponrequest = "mg";
    self setbtgoalpos(2, self.origin);
    return anim.running;
  }

  if(istrue(self.clearspaceforscriptableinstance)) {
    if(self.ref_13b2a > 3) {
      thread modifybrvehicledamage();
      return anim.running;
    }
  }

  return anim.success;
}

function modifybrvehicledamage() {
  self endon("death");
  self.clear_kill_off_flags_after_unload_wait = 1;
  var0 = 10000;
  var1 = gettime();

  while(!self asmeventfired(self.asmname, "drop_shield") && var1 + var0 > gettime()) {
    waitframe();
  }

  var2 = var1 + var0 <= gettime();

  if(var2) {
    ref_12c80();
    self._blackboard.weaponrequest = "none";
    self.clear_kill_off_flags_after_unload_wait = undefined;
    self clearbtgoal(2);
    return;
  }

  scripts\asm\shared\utility::setbasearchetype("soldier_cp");
  scripts\asm\shared\utility::setoverridearchetype("default", "soldier_cp");
  scripts\asm\soldier\script_funcs::initanimspeedthresholds_soldier("soldier_cp");
  var3 = self gettagorigin(self.ref_12d50);
  var4 = self gettagangles(self.ref_12d50);
  var5 = spawn("script_model", var3);
  var5.angles = var4;
  var5 setModel(self.riotshieldmodel);
  var5 physicslaunchserver(var3, anglesToForward(self.angles) * 5);
  thread deleteaftertime(var5);

  if(isDefined(self.ref_13b2c)) {
    foreach(var7 in self.ref_13b2c) {
      if(isDefined(var7)) {
        var7 delete();
      }
    }
  }

  self.a.disablelongdeath = 0;
  ref_12c1c();
  ref_12c80();
  self.clear_kill_off_flags_after_unload_wait = undefined;
  self clearbtgoal(2);
  ref_13af8();
  self._blackboard.weaponrequest = "none";
  scripts\aitypes\bt_util::bt_terminateandreplace("soldier_agent");
  var9 = weaponclass(self.weapon);
  scripts\anim\shared::updateweaponarchetype(var9);
}

function deleteaftertime(var0) {
  self endon("death");
  wait var0;
  self delete();
}