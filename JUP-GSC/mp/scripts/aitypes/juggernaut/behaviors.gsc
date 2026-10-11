/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\aitypes\juggernaut\behaviors.gsc
*******************************************************/

#using scripts\aitypes\bt_util;
#using scripts\anim\utility_common;
#using scripts\anim\weaponlist;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace behaviors;

function juggernaut_init(taskid) {
  self.spec = "juggernaut";
  self.wearing_helmet = 1;
  self allowedstances("stand");
  self.juggernaut = 1;
  self.dontmeleeme = 1;
  self.minpaindamage = 1000;
  self.grenadeammo = 0;
  self.doorflashchance = 0.05;
  self.aggressivemode = 1;
  self.ignoresuppression = 1;
  self.disablepistol = 1;
  self.norunngun = 1;
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
  self.disablebulletwhizbyreaction = 1;
  self setcanusecover(0, "entity");
  self.disablerunngun = 1;
  self.disabledodge = 1;
  self.pathenemyfightdist = 0;
  self.var_274d3a7704e351ef = 1;
  self.allowlongdeath = 0;
  self.pursueruncooldown = 3000;
  self.var_7d606bec79308eb5 = 750;
  self.pursuestopdistance = 300;
  self.var_a67833fea11a521c = 750;
  self.var_427cbd3288a2f59 = 300;
  self.pursuegoalradius = 25;
  self.var_20833644cc82839f = 200;
  self.goalheight = 80;
  self.usechokepoints = 0;
  self.cautiousnavigation = 0;
  self.cornercheckenabled = 0;
  self.pursueacceleration = 40;
  self.var_e2b553399f5ff8a3 = 1000;
  self.var_e2d849399f862a5d = 2000;
  self.var_7878ef8b36bc3525 = 1000;
  self.var_789bf98b36e292db = 2000;
  self.var_2d670e4d288c86fb = 1;
  self.combat_func_active = 1;
  self function_ae41fbf799ba43f(1, "entity");
  self function_8bbcaeb23a1512ef("all", 0, "bt");
  self allowvehiclepredictiveragdoll(0);

  if(!issp() && !is_equal(level.gametype, "trial")) {
    self giveweapon("iw9_lm_dblmg_execution_mp");
    self giveexecution("jug_execution_000_stand_8", "iw9_lm_dblmg_execution_mp");
  }

  setdvarifuninitialized(@ "hash_45b89b729718bd15", 0);
  setdvarifuninitialized(@ "hash_55cdffcdb283c0cd", -1);
}

function juggernaut_shouldexecute(taskid) {
  var_dc17de3aad9b4859 = 10000;
  var_fd17b339e3ecf73c = 1;

  if(getdvarint(@ "hash_45b89b729718bd15")) {
    var_fd17b339e3ecf73c = 0;
  }

  if(var_fd17b339e3ecf73c && !istrue(self.ballowexecutions)) {
    return anim.failure;
  }

  if(isDefined(self.timeoflastexecute) && gettime() - self.timeoflastexecute < var_dc17de3aad9b4859) {
    return anim.failure;
  }

  if(istrue(self.onlyexecutefromthefront)) {
    assert(isDefined(self.enemy));
    targettome = self.origin - self.enemy.origin;
    var_f38131fb9a95561a = vectortoyaw(targettome);
    angledelta = angleclamp180(var_f38131fb9a95561a - self.enemy.angles[1]);

    if(angledelta < -45 || angledelta > 45) {
      return anim.failure;
    }
  }

  return anim.success;
}

function juggernaut_setupexecute(taskid) {
  self.timeoflastexecute = gettime();
  assert(isDefined(self.enemy));
  targettome = self.origin - self.enemy.origin;
  var_f38131fb9a95561a = vectortoyaw(targettome);
  angledelta = angleclamp180(var_f38131fb9a95561a - self.enemy.angles[1]);
  execrootname = "jug_execution_";
  execstance = "_stand_";
  execnumber = "00";
  dir = "8";

  if(angledelta < 45 && angledelta > -45) {
    iexec = randomint(4);
    execnumber += iexec;
  } else {
    iexec = randomint(2);
    execnumber += iexec;

    if(angledelta < -135 || angledelta > 135) {
      dir = "2";
    } else if(angledelta >= 45) {
      dir = "4";
    } else {
      dir = "6";
    }
  }

  overridenumber = getdvarint(@ "hash_55cdffcdb283c0cd");

  if(overridenumber >= 0) {
    execnumber = "<dev string:x1c>" + overridenumber;
  }

  execname = execrootname + execnumber + execstance + dir;
  self giveexecution(execname, "iw9_lm_dblmg_execution_mp");
  return anim.success;
}

function function_aad2563e98827b23(taskid) {
  self.jailer_waiting = 1;

  if(self pathdisttogoal() > 256 && self aigetdesiredspeed() > 70) {
    self.var_8b54fc69d81b03cf = 1;
  }

  self._blackboard.bseqphase = undefined;
  thread scripts\common\cap::cap_start("cap_jugg_sweep", "caps/common/cap_jugg_sweep");
  thread function_9db78f7b52b4ad06();
}

function function_c082b9efbf242464(taskid) {
  if(isDefined(self.jailer_waiting)) {
    return anim.running;
  }

  return anim.success;
}

function function_e1138cce8b2f28d4(taskid) {
  if(isDefined(self.jailer_waiting)) {
    self.jailer_waiting = undefined;

    if(!isDefined(self._blackboard.bseqphase)) {
      self._blackboard.bseqphase = "abort";
    }
  }
}

function function_9db78f7b52b4ad06() {
  self endon("death");
  self waittill("cap_exit_completed");
  self.jailer_waiting = undefined;
}