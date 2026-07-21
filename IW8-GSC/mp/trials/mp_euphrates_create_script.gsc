/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\mp_euphrates_create_script.gsc
****************************************************/

_id_12D4B(var_0) {
  if(istrue(self.disabledstate))
    return anim.success;

  self.secondaryweapon = getcompleteweaponname("_encstr_A16718D2BB07F5DAACD7394BB73A37A196CA8D8CEBB11CAF85A5");
  _id_12D4A();
  self.disabledstate = 1;
  return anim.success;
}

_id_12D4C(var_0) {
  if(istrue(self.disabledstate))
    return anim.success;

  self.secondaryweapon = getcompleteweaponname("_encstr_B4E0182DBB70FAD6B2BE935ADB3ACD435ACAB1197DCDE0FAB05A");
  _id_12D4A();
  self.disabledstate = 1;
  return anim.success;
}

_id_12D4A() {
  self allowedstances("_encstr_A5AD069B231F0BAF");
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
  self.combatmode = "_encstr_821109FAE81117DA568730";
  self.disablerunngun = 1;
  self.disabledodge = 1;
  self.pathenemyfightdist = 0;
  self.maxfaceenemydist = 768;

  if(isDefined(self.a))
    self.a.disablelongdeath = 1;

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
  self.riotshieldmodel = "_encstr_8DE81D573DE263B0A87764582E6A6C028B686C7082EBE71F28A0968B6FCA70";
  self._id_12D50 = "_encstr_A98C10F0117A694307579828C090CC85ED33";
  self attachshieldmodel(self.riotshieldmodel, self._id_12D50);
  self.clearsoundsubmixmpbrinfilanim = 1;
}

_id_13AF8() {
  self allowedstances("_encstr_A5AD069B231F0BAF", "_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05");
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
  self.combatmode = "_encstr_B68E06D8F6B3CA27";
  self.disablerunngun = 0;
  self.disabledodge = undefined;
  self.pathenemyfightdist = 0;
  self enabletraversals(1);
}

_id_12C80() {
  self.clearspaceforscriptableinstance = undefined;
  self._id_13B2C = undefined;
  self._id_13B2A = undefined;
}

_id_12C1C() {
  if(istrue(self.clearsoundsubmixmpbrinfilanim)) {
    self detachshieldmodel(self.riotshieldmodel, self._id_12D50);
    self.riotshieldmodel = undefined;
    self._id_12D50 = undefined;
    self.clearsoundsubmixmpbrinfilanim = undefined;
  }
}

_id_12D49(var_0) {
  if(istrue(self.clear_kill_off_flags_after_unload_wait)) {
    self._blackboard.weaponrequest = "_encstr_BE0703A54C";
    self setbtgoalpos(2, self.origin);
    return anim.running;
  }

  if(istrue(self.clearspaceforscriptableinstance)) {
    if(self._id_13B2A > 3) {
      thread modifybrvehicledamage();
      return anim.running;
    }
  }

  return anim.success;
}

modifybrvehicledamage() {
  self endon("_encstr_AD75063D571AE108");
  self.clear_kill_off_flags_after_unload_wait = 1;
  var_0 = 10000;
  var_1 = gettime();

  while(!self asmeventfired(self.asmname, "_encstr_9B830C23E4ED07BE9B0DD2ACB18C") && var_1 + var_0 > gettime())
    waitframe();

  var_2 = var_1 + var_0 <= gettime();

  if(var_2) {
    _id_12C80();
    self._blackboard.weaponrequest = "_encstr_8BBA05185F8B99";
    self.clear_kill_off_flags_after_unload_wait = undefined;
    self clearbtgoal(2);
    return;
  }

  scripts\asm\shared\utility::setbasearchetype("_encstr_ACF80B97CFB24530E51A66F982");
  scripts\asm\shared\utility::setoverridearchetype("_encstr_8B1608EC43B8D647A113", "_encstr_ACF80B97CFB24530E51A66F982");
  scripts\asm\soldier\script_funcs::initanimspeedthresholds_soldier("_encstr_ACF80B97CFB24530E51A66F982");
  var_3 = self gettagorigin(self._id_12D50);
  var_4 = self gettagangles(self._id_12D50);
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  var_5.angles = var_4;
  var_5 setModel(self.riotshieldmodel);
  var_5 physicslaunchserver(var_3, anglesToForward(self.angles) * 5);
  var_5 thread deleteaftertime(10);

  if(isDefined(self._id_13B2C)) {
    foreach(var_7 in self._id_13B2C) {
      if(isDefined(var_7))
        var_7 delete();
    }
  }

  self.a.disablelongdeath = 0;
  _id_12C1C();
  _id_12C80();
  self.clear_kill_off_flags_after_unload_wait = undefined;
  self clearbtgoal(2);
  _id_13AF8();
  self._blackboard.weaponrequest = "_encstr_8BBA05185F8B99";
  scripts\aitypes\bt_util::bt_terminateandreplace("_encstr_A7E80E1818902B623DBA872BD4C1184C");
  var_9 = weaponclass(self.weapon);
  _encstr_842518E6D8395A38A3B9BC0B73B4AD5EB9862CE4AC8CE23BDC1B::updateweaponarchetype(var_9);
}

deleteaftertime(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);
  self delete();
}