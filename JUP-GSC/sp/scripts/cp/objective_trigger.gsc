/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\objective_trigger.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_debug;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\cp_objectives;
#using scripts\cp\objective_trigger;
#using scripts\cp\utility\entity;
#using scripts\cp\utility\player;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace objective_trigger;

function function_b0637efa07ab9df9(ent, ref) {
  ent.var_4791d0f4b01a8675 = ref;

  var_40bd9ce882cc4d3a = getdvarint(@ "hash_b5c6eaf824cef623", 0);

  if(var_40bd9ce882cc4d3a) {
    function_d74114cef7502d9(ent);
  }
}

function function_51ac8764c365bc6e(ent) {
  ent.var_4791d0f4b01a8675 = undefined;
}

function function_10431805097c3712(ref, callback) {
  struct = function_e5293bf61b1e0026();
  struct.entercallbacks[ref] = callback;
}

function function_a4cf949e6a5a2f32(ref, callback) {
  struct = function_e5293bf61b1e0026();
  struct.exitcallbacks[ref] = callback;
}

function function_2c3b3ed775a05030(ref, callback) {
  struct = function_e5293bf61b1e0026();
  struct.outoftimecallbacks[ref] = callback;
}

function function_9fecba6dbcd17779(ref, callback) {
  struct = function_e5293bf61b1e0026();
  struct.clearcallbacks[ref] = callback;
}

function function_a689a50c8f318fb8(ent, var_3e36f415f762070e) {
  if(function_8546bd495f6a810d(ent)) {
    return false;
  }

  if(istrue(var_3e36f415f762070e) && function_8546bd495f6a810d(ent)) {
    return false;
  }

  return isDefined(ent.objectivetrigger) && ent.objectivetrigger > 0;
}

function function_5544f479a69046cb(ent) {
  if(!isDefined(ent.objectivetrigger)) {
    ent.objectivetrigger = 0;
  }

  ent.objectivetrigger++;

  if(ent.objectivetrigger >= 1) {
    if(!isDefined(ent.var_ec6f43aa20537aca) || ent.var_ec6f43aa20537aca <= 0) {
      function_ef917fd93ccb888b(ent);
    }
  }
}

function function_676e774a951af28a(ent, var_d5c909837fd4deb4) {
  assertex(isDefined(ent.objectivetrigger), "disableobjectiveTrigger called on an entity that was not in the Ai Region. ");

  if(!isDefined(ent.objectivetrigger)) {
    if(isDefined(ent)) {}
  }

  if(!istrue(var_d5c909837fd4deb4)) {
    assertex(ent.objectivetrigger > 0, "disableobjectiveTrigger more times than enableobjectiveTrigger.");
  }

  ent.objectivetrigger--;

  if(ent.objectivetrigger == 0) {
    ent.objectivetrigger = undefined;

    if(!isDefined(ent.var_ec6f43aa20537aca) || ent.var_ec6f43aa20537aca <= 0) {
      function_dc3ab6f4f4115f21(ent, 0);
    }
  }
}

function function_8546bd495f6a810d(ent) {
  return isDefined(ent.var_ec6f43aa20537aca) && ent.var_ec6f43aa20537aca > 0;
}

function function_d74114cef7502d9(ent) {
  if(!isDefined(ent.var_ec6f43aa20537aca)) {
    ent.var_ec6f43aa20537aca = 0;
  }

  ent.var_ec6f43aa20537aca++;

  if(ent.var_ec6f43aa20537aca == 1) {
    if(isDefined(ent.objectivetrigger) && ent.objectivetrigger > 0) {
      function_dc3ab6f4f4115f21(ent, 0);
    }
  }
}

function function_acb17ad29bb16600(ent) {
  assertex(isDefined(ent.var_ec6f43aa20537aca), "disableobjectiveTriggerImmunity called on an entity without Ai Region immunity.");
  assertex(ent.var_ec6f43aa20537aca > 0, "disableobjectiveTriggerImmunity more times than enableobjectiveTriggerImmunity.");
  ent.var_ec6f43aa20537aca--;

  if(ent.var_ec6f43aa20537aca == 0) {
    ent.var_ec6f43aa20537aca = undefined;

    if(isDefined(ent.objectivetrigger) && ent.objectivetrigger > 0) {
      function_ef917fd93ccb888b(ent);
    }
  }
}

function function_3c54d0e74e6305cf(ent, fromdeath) {
  ent notify("clear_objectiveTrigger");

  if(function_a689a50c8f318fb8(ent, 1)) {
    function_dc3ab6f4f4115f21(ent, fromdeath, 1);
  }

  clearcallback = undefined;

  if(isPlayer(ent)) {
    clearcallback = &playerclearcallback;
  } else if(isagent(ent)) {
    clearcallback = &playerclearcallback;
  } else if(isDefined(ent.var_4791d0f4b01a8675)) {
    struct = function_e5293bf61b1e0026();
    clearcallback = struct.clearcallbacks[ent.var_4791d0f4b01a8675];
  }

  if(isDefined(clearcallback)) {
    ent[[clearcallback]]();
  }

  ent.var_4791d0f4b01a8675 = undefined;
  ent.objectivetrigger = undefined;
  ent.var_ec6f43aa20537aca = undefined;
  ent.var_74c4fae1de63d2ac = undefined;
  ent.var_ae108624f7f46d2c = undefined;
  ent.var_86a97258f28d622c = undefined;

  if(isDefined(ent.var_b4782a67e2e204d5)) {
    foreach(trigger in ent.var_b4782a67e2e204d5) {
      trigger.entstouching[ent getentitynumber()] = undefined;
    }

    ent.var_b4782a67e2e204d5 = undefined;
  }

  if(isDefined(ent.var_4e2fc0e57edb2de)) {
    foreach(trigger in ent.var_4e2fc0e57edb2de) {
      trigger.entstouching[ent getentitynumber()] = undefined;
    }

    ent.var_4e2fc0e57edb2de = undefined;
  }
}

function function_7a59631f369cf28f() {
  if(istrue(self.allowedintrigger)) {
    return false;
  }

  if(!isDefined(level.var_b4782a67e2e204d5)) {
    return false;
  }

  foreach(trigger in level.var_b4782a67e2e204d5) {
    if(!function_5ef32e4317fcad8(trigger, self)) {
      continue;
    }

    if(self istouching(trigger)) {
      return true;
    }
  }

  return false;
}

function function_8c2ee7cb53f2d33f(pointtocheck, teamtocheck) {
  var_3d03b5c55b1367af = 0;

  if(!isDefined(level.var_b4782a67e2e204d5)) {
    return var_3d03b5c55b1367af;
  } else {
    foreach(trigger in level.var_b4782a67e2e204d5) {
      if(ispointinvolume(pointtocheck, trigger)) {
        if(isDefined(trigger.script_team) && isDefined(teamtocheck) && trigger.script_team != teamtocheck) {
          continue;
        }

        var_3d03b5c55b1367af = 1;
        break;
      }
    }
  }

  return var_3d03b5c55b1367af;
}

function function_ab29f5844aa437fb() {
  if(level.script == "cp_hydro") {
    return true;
  }

  return getdvarint(@ "hash_296c4dcd03cee72b", 0) == 1;
}

function function_ae2bc8e7d8d4fc9b() {
  create_func_ref("<dev string:x1c>", &scripts\cp\cp_debug::draw_spawner);

  if(!flag_exist("radar_scramblers_initialized")) {
    flag_init("radar_scramblers_initialized");
  }

  if(!flag_exist("ready_for_region_spawning")) {
    flag_init("ready_for_region_spawning");
  }

  if(!flag_exist("ready_for_objective_trigger")) {
    flag_init("ready_for_objective_trigger");
  }

  if(!isDefined(level.var_b4782a67e2e204d5)) {
    level.var_b4782a67e2e204d5 = [];
  }

  level.var_b4782a67e2e204d5 = array_combine(level.var_b4782a67e2e204d5, getEntArray("objective_trigger", "targetname"));
  thread function_d76603ec2ccec43c();

  if(getdvarint(@ "hash_f9ca8e1807c937d", 0) != 0) {
    thread globalobjectivechangerequests();
    return;
  }

  thread globalobjectivechangerequests(1);
}

function function_b661f9fca2d11cdb() {
  if(!flag_exist("level_ready_for_script")) {
    flag_init("level_ready_for_script");
  }

  flag_wait("level_ready_for_script");

  if(isDefined(level.var_fc46cd90f0a40c87)) {
    [[level.var_fc46cd90f0a40c87]]();
  }

  if(!isDefined(level.var_b4782a67e2e204d5)) {
    level.var_b4782a67e2e204d5 = [];
  }

  level.var_b4782a67e2e204d5 = array_combine(level.var_b4782a67e2e204d5, getEntArray("objective_trigger", "targetname"));
  thread function_d76603ec2ccec43c();

  if(getdvarint(@ "hash_f9ca8e1807c937d", 0) != 0) {
    thread globalobjectivechangerequests();
    return;
  }

  thread globalobjectivechangerequests(1);
}

function function_ef917fd93ccb888b(ent) {
  entercallback = undefined;
  trigger = function_76d6f049ca4670ce(ent);
  triggertype = gettriggertype(ent, trigger);

  if(isPlayer(ent)) {
    entercallback = &playerentercallback;
  } else if(isDefined(ent.owner)) {
    if(isPlayer(ent.owner)) {
      entercallback = &playerentercallback;
    }
  } else if(isDefined(ent.var_4791d0f4b01a8675)) {
    struct = function_e5293bf61b1e0026();
    entercallback = struct.entercallbacks[ent.var_4791d0f4b01a8675];
  }

  ent notify("objectiveTrigger_cooldown_end");

  if(isDefined(ent.var_74c4fae1de63d2ac) && previouslytouchedtriggertype(ent, triggertype)) {
    var_644a8646988ebac1 = ent.var_74c4fae1de63d2ac / 1000;
    ent.var_ae108624f7f46d2c = int(gettime() + ent.var_74c4fae1de63d2ac);
    ent.var_74c4fae1de63d2ac = undefined;
    thread function_214637c8c6d3c1c7(ent, var_644a8646988ebac1);
  } else {
    ent.var_74c4fae1de63d2ac = undefined;
    ent.var_86a97258f28d622c = triggertype;
    var_644a8646988ebac1 = function_7854a56a0f3cad3f(triggertype);
    ent.var_ae108624f7f46d2c = int(gettime() + var_644a8646988ebac1 * 1000);
    thread function_214637c8c6d3c1c7(ent, var_644a8646988ebac1);
  }

  if(isDefined(entercallback)) {
    ent thread[[entercallback]]("exit_objectiveTrigger", "clear_objectiveTrigger", triggertype, trigger);
  }
}

function function_dc3ab6f4f4115f21(ent, fromdeath, fromclear) {
  ent notify("exit_objectiveTrigger");
  exitcallback = undefined;

  if(isPlayer(ent)) {
    exitcallback = &playerexitcallback;
  } else if(isDefined(ent.owner)) {
    if(isPlayer(ent.owner)) {
      exitcallback = &playerexitcallback;
    }
  } else if(isDefined(ent.var_4791d0f4b01a8675)) {
    struct = function_e5293bf61b1e0026();
    exitcallback = struct.exitcallbacks[ent.var_4791d0f4b01a8675];
  }

  ent notify("objectiveTrigger_timeout_end");

  if(!istrue(fromclear)) {
    if(isDefined(ent.var_ae108624f7f46d2c)) {
      ent.var_74c4fae1de63d2ac = int(max(0, ent.var_ae108624f7f46d2c - gettime()));
      ent.var_ae108624f7f46d2c = undefined;
      trigger = function_76d6f049ca4670ce(ent);
      triggertype = gettriggertype(ent, trigger);
      cooldowntime = getcooldowntime(triggertype);
      thread function_20f4b12ae43eb94c(ent, cooldowntime);
    }
  }

  if(isDefined(exitcallback)) {
    ent thread[[exitcallback]](fromdeath, fromclear, "clear_objectiveTrigger");
  }
}

function function_395f3346be3d7df7(ent) {
  outoftimecallback = undefined;

  if(isPlayer(ent)) {
    var_775c9a68f9c00019 = 1;

    if(var_775c9a68f9c00019) {
      outoftimecallback = &playeroutoftimecallback;
    }
  } else if(isagent(ent)) {
    var_775c9a68f9c00019 = 1;

    if(var_775c9a68f9c00019) {
      outoftimecallback = &playeroutoftimecallback;
    }
  } else if(isDefined(ent.var_4791d0f4b01a8675)) {
    struct = function_e5293bf61b1e0026();
    outoftimecallback = struct.outoftimecallbacks[ent.var_4791d0f4b01a8675];
  }

  if(isDefined(outoftimecallback)) {
    ent thread[[outoftimecallback]]("objectiveTrigger_timeout_end", "clear_objectiveTrigger");
  }
}

function function_214637c8c6d3c1c7(ent, timeleft) {
  if(isPlayer(ent) || isagent(ent)) {
    ent endon("death");
  }

  ent notify("objectiveTrigger_timeout_end");
  ent endon("objectiveTrigger_timeout_end");
  ent endon("clear_objectiveTrigger");
  wait timeleft;
  thread function_395f3346be3d7df7(ent);
}

function function_20f4b12ae43eb94c(ent, timeleft) {
  if(isPlayer(ent) || isagent(ent)) {
    ent endon("death");
  }

  ent notify("objectiveTrigger_cooldown_end");
  ent endon("objectiveTrigger_cooldown_end");
  ent endon("clear_objectiveTrigger");
  wait timeleft;
  ent.var_74c4fae1de63d2ac = undefined;
  ent.var_86a97258f28d622c = undefined;
}

function playerentercallback(exitnotify, clearnotify, triggertype, trigger) {
  var_7e02c245f06f3ca0 = 1;

  if(isDefined(triggertype) && triggertype == "restricted") {
    var_7e02c245f06f3ca0 = 2;
  }

  self.objective_trigger = trigger;

  if(scripts\cp\objective_trigger::function_df7e197c7e058e4b()) {
    self iprintln("<dev string:x29>");
  }

  level notify("global_objective_request", trigger, 1);
}

function function_b2a14335ecf202f8(exitnotify, clearnotify, triggertype, trigger) {
  var_7e02c245f06f3ca0 = 1;

  if(isDefined(triggertype) && triggertype == "restricted") {
    var_7e02c245f06f3ca0 = 2;
  }

  function_86afcfb8eb7bf0d2(trigger);
  self.objective_trigger = trigger;
}

function playerexitcallback(fromdeath, fromclear, clearnotify) {
  var_bbba777adf94982f = 0;

  foreach(player in level.players) {
    if(player != self) {
      if(isDefined(player.objective_trigger)) {
        var_bbba777adf94982f = 1;
      }
    }
  }

  if(istrue(var_bbba777adf94982f)) {
    level notify("global_objective_request", undefined, undefined, var_bbba777adf94982f);
  }

  self.objective_trigger = undefined;

  if(scripts\cp\objective_trigger::function_df7e197c7e058e4b()) {
    self iprintln("<dev string:x54>");
  }
}

function function_d405dee230e91b4(fromdeath, fromclear, clearnotify) {
  self.objective_trigger = undefined;
  function_d55ed59c0ce164d3();
}

function playeroutoftimecallback(timeoutendnotify, clearnotify) {
  trigger = function_76d6f049ca4670ce(self);
  triggertype = gettriggertype(self, trigger);
}

function playerclearcallback(clearnotify) {}

function playeroutoftimeminefield(timeoutendnotify, clearnotify) {
  minespawnpos = self.origin;
  minetrace = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 1000), self);

  if(isDefined(minetrace["hittype"] != "hittype_none") && isDefined(minetrace["position"])) {
    minespawnpos = minetrace["position"];
  }

  mine = spawn("script_model", minespawnpos);
  mine setModel("ks_minefield_mp");
  mine setentityowner(self);
  mine setotherent(self);
  mine setscriptablepartstate("warning_click", "on", 0);
  mineexploded = playeroutoftimeminefieldinternal(mine, timeoutendnotify, clearnotify);

  if(istrue(mineexploded)) {
    wait 2;
  }

  mine delete();
}

function playeroutoftimeminefieldinternal(mine, timeoutendnotify, clearnotify) {
  self endon("death_or_disconnect");

  if(isDefined(timeoutendnotify)) {
    self endon(timeoutendnotify);
  }

  if(isDefined(clearnotify)) {
    self endon(clearnotify);
  }

  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  mine setscriptablepartstate("explosion", "on", 0);
  wait 0.05;
  self dodamage(2000, self.origin, self, mine, "MOD_EXPLOSIVE", "minefield_mp");
  return true;
}

function killstreakentercallback(exitnotify, clearnotify, triggertype, trigger) {
  var_7e02c245f06f3ca0 = 1;

  if(islargemap() && level.gametype == "arm" && isDefined(triggertype) && triggertype == "restricted") {
    var_7e02c245f06f3ca0 = 2;
  }

  if(isDefined(self.owner)) {
    if(isPlayer(self.owner)) {
      self.owner playerentercallback(exitnotify, clearnotify, triggertype, trigger);
      return;
    }

    if(isagent(self.owner)) {
      self.owner function_b2a14335ecf202f8(exitnotify, clearnotify, triggertype, trigger);
    }
  }
}

function killstreakexitcallback(fromdeath, fromclear, clearnotify) {
  if(isDefined(self.owner)) {
    if(isPlayer(self.owner)) {
      self.owner playerexitcallback(fromdeath, fromclear, clearnotify);
      return;
    }

    if(isagent(self.owner)) {
      self.owner function_d405dee230e91b4(fromdeath, fromclear, clearnotify);
    }
  }
}

function killstreakoutoftimecallback(timeoutendnotify, clearnotify) {}

function killstreakclearcallback() {
  if(isDefined(self.owner)) {
    if(isPlayer(self.owner)) {
      self.owner playerclearcallback();
      return;
    }

    if(isagent(self.owner)) {
      self.owner playerclearcallback();
    }
  }
}

function function_eadc517453265031() {
  function_10431805097c3712("killstreak", &killstreakentercallback);
  function_a4cf949e6a5a2f32("killstreak", &killstreakexitcallback);
  function_2c3b3ed775a05030("killstreak", &killstreakoutoftimecallback);
  function_9fecba6dbcd17779("killstreak", &killstreakclearcallback);
}

function function_d76603ec2ccec43c() {
  updated_array = [];

  if(isDefined(level.var_b4782a67e2e204d5)) {
    foreach(trigger in level.var_b4782a67e2e204d5) {
      thread watchobjectivetriggertrigger(trigger);
    }

    if(isDefined(level.var_7ad9bda566c961e2)) {
      foreach(trigger in level.var_7ad9bda566c961e2) {
        thread watchobjectivetriggersuppressiontrigger(trigger);
      }
    }
  }
}

function watchobjectivetriggertrigger(trigger) {
  trigger notify("watchobjectiveTriggerTrigger");
  trigger endon("watchobjectiveTriggerTrigger");
  trigger.entstouching = [];

  if(isDefined(trigger.target)) {
    trigger.var_3efe1b3a9ef1aba0 = getEnt(trigger.target, "targetname");
    trigger.var_3efe1b3a9ef1aba0.parent_trigger = trigger;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  thread watchobjectivetriggertriggerexit(trigger);
  thread watchobjectivetriggertriggerenter(trigger);
}

function watchobjectivetriggertriggerenter(trigger) {
  level endon("game_ended");
  trigger notify("watchobjectiveTriggerTriggerEnter");
  trigger endon("watchobjectiveTriggerTriggerEnter");
  trigger endon("death");

  while(true) {
    trigger waittill("trigger", ent);

    if(!function_5ef32e4317fcad8(trigger, ent)) {
      continue;
    }

    if(!function_230474edd3a1d4d8(ent)) {
      continue;
    }

    function_d5ace299257de7d5(trigger, ent);
  }
}

function watchobjectivetriggertriggerexit(trigger) {
  level endon("game_ended");
  trigger notify("watchobjectiveTriggerTriggerExit");
  trigger endon("watchobjectiveTriggerTriggerExit");
  trigger endon("death");

  while(true) {
    temparr = trigger.entstouching;

    foreach(ent in temparr) {
      if(!isDefined(ent)) {
        trigger.entstouching[id] = undefined;
      }

      if(isDefined(ent) && !trigger istouching(ent)) {
        function_6d0bd2b7230b50a7(trigger, ent);
      }
    }

    waitframe();
  }
}

function function_d5ace299257de7d5(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }

  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent.var_b4782a67e2e204d5)) {
    ent.var_b4782a67e2e204d5 = [];
  }

  temparr = [trigger];

  foreach(objectivetriggertrigger in ent.var_b4782a67e2e204d5) {
    temparr[temparr.size] = objectivetriggertrigger;
  }

  ent.var_b4782a67e2e204d5 = temparr;
  function_5544f479a69046cb(ent);
}

function function_6d0bd2b7230b50a7(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;

  if(isDefined(ent.objectivetrigger)) {
    function_676e774a951af28a(ent);
  }

  ent notify("clean_up_exit_threads");

  if(isDefined(ent.var_b4782a67e2e204d5)) {
    ent.var_b4782a67e2e204d5 = array_remove(ent.var_b4782a67e2e204d5, trigger);

    if(ent.var_b4782a67e2e204d5.size == 0) {
      ent.var_b4782a67e2e204d5 = undefined;
    }
  }
}

function watchobjectivetriggersuppressiontrigger(trigger) {
  trigger notify("watchobjectiveTriggerSuppressionTrigger");
  trigger endon("watchobjectiveTriggerSuppressionTrigger");
  trigger.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread watchobjectivetriggersuppressiontriggerexit(trigger);
  thread watchobjectivetriggersupressiontriggerenter(trigger);
}

function watchobjectivetriggersupressiontriggerenter(trigger) {
  level endon("game_ended");
  trigger notify("watchobjectiveTriggerSupressionTriggerEnter");
  trigger endon("watchobjectiveTriggerSupressionTriggerEnter");
  trigger endon("death");

  while(true) {
    trigger waittill("trigger", ent);

    if(!function_230474edd3a1d4d8(ent)) {
      continue;
    }

    function_5793b781f72eb2b2(trigger, ent);
  }
}

function watchobjectivetriggersuppressiontriggerexit(trigger) {
  level endon("game_ended");
  trigger notify("watchobjectiveTriggerSuppressionTriggerExit");
  trigger endon("watchobjectiveTriggerSuppressionTriggerExit");
  trigger endon("death");

  while(true) {
    temparr = trigger.entstouching;

    if(isDefined(temparr)) {
      foreach(ent in temparr) {
        if(!isDefined(ent)) {
          trigger.entstouching[id] = undefined;
        }

        if(isDefined(ent) && !trigger istouching(ent)) {
          function_1e6c93c4667a5a56(trigger, ent);
        }
      }
    }

    waitframe();
  }
}

function function_5793b781f72eb2b2(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }

  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent.var_4e2fc0e57edb2de)) {
    ent.var_4e2fc0e57edb2de = [];
  }

  temparr = [trigger];

  foreach(objectivetriggersuppressiontrigger in ent.var_4e2fc0e57edb2de) {
    temparr[temparr.size] = objectivetriggersuppressiontrigger;
  }

  ent.var_4e2fc0e57edb2de = temparr;
  function_d74114cef7502d9(ent);
}

function function_1e6c93c4667a5a56(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  ent.var_4e2fc0e57edb2de[trigger getentitynumber()] = undefined;

  if(ent.var_4e2fc0e57edb2de.size == 0) {
    ent.var_4e2fc0e57edb2de = undefined;
  }

  function_acb17ad29bb16600(ent);
}

function function_5ef32e4317fcad8(trigger, ent) {
  if(isDefined(trigger.script_team)) {
    isvehicle = 0;

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      isvehicle = 1;
    }

    if(isvehicle) {
      if(isvehicle && isDefined(ent.team) && ent.team != "neutral" && ent.team != trigger.script_team) {
        return false;
      }

      if(isvehicle && isDefined(ent.owner) && ent.owner.team != trigger.script_team) {
        return false;
      }

      if(isvehicle && isDefined(ent.occupants)) {
        foreach(occupant in ent.occupants) {
          if(occupant.team != trigger.script_team) {
            return false;
          }
        }
      }
    } else if(ent.team != trigger.script_team) {
      return false;
    }
  }

  return true;
}

function function_230474edd3a1d4d8(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive()) {
        return true;
      }
    }

    if(isDefined(ent.var_4791d0f4b01a8675)) {
      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(ent.isdestroyed)) {
          return true;
        }
      }

      if(isDefined(ent.streakinfo) && function_988f25f45fdfea57(ent.streakinfo.streakname)) {
        return true;
      }
    }
  }

  return false;
}

function function_e5293bf61b1e0026() {
  struct = level.var_d16604d2a4be9b50;

  if(!isDefined(struct)) {
    struct = spawnStruct();
    struct.entercallbacks = [];
    struct.exitcallbacks = [];
    struct.outoftimecallbacks = [];
    struct.clearcallbacks = [];
    level.var_d16604d2a4be9b50 = struct;
  }

  return struct;
}

function function_988f25f45fdfea57(streakname) {
  if(level.script == "cp_hydro") {
    return 1;
  }

  var_4528d83c55f68159 = 0;

  switch (streakname) {
    case #"hash_cf0ef5bef19a311b":
    case #"hash_e40585107590f016":
      var_4528d83c55f68159 = 1;
      break;
  }

  return var_4528d83c55f68159;
}

function gettriggertype(ent, trigger) {
  triggertype = "default";

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return "br";
  }

  if(isDefined(trigger) && isDefined(trigger.script_team)) {
    return "restricted";
  }

  if(isDefined(ent) && ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return "default";
  }

  if(isDefined(ent) && isDefined(ent.streakinfo)) {
    return "default";
  }

  if(isDefined(trigger) && isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "MineField") {
    triggertype = "minefield";
  }

  return triggertype;
}

function getcooldowntime(triggertype) {
  switch (triggertype) {
    case #"hash_18ad1d5da2e56d4c":
    case #"hash_6b15362474c2e2b2":
    case #"hash_7038dec66d8275be":
    case #"hash_fa21c4f6bd5e3815":
      return function_7854a56a0f3cad3f(triggertype);
  }

  return undefined;
}

function function_7854a56a0f3cad3f(triggertype) {
  switch (triggertype) {
    case #"hash_18ad1d5da2e56d4c":
    case #"hash_6b15362474c2e2b2":
    case #"hash_7038dec66d8275be":
    case #"hash_fa21c4f6bd5e3815":
      return function_d92bc82cf09792e7();
  }

  return undefined;
}

function function_d92bc82cf09792e7() {
  return max(0, getdvarfloat(@ "hash_4385c822d0f7ff6f", 3));

  var_644a8646988ebac1 = level.var_644a8646988ebac1;

  if(!isDefined(var_644a8646988ebac1)) {
    var_644a8646988ebac1 = max(0, getdvarfloat(@ "hash_4385c822d0f7ff6f", 3));
    level.var_644a8646988ebac1 = var_644a8646988ebac1;
  }

  return var_644a8646988ebac1;
}

function function_76d6f049ca4670ce(ent) {
  if(isDefined(ent.var_b4782a67e2e204d5)) {
    return ent.var_b4782a67e2e204d5[0];
  }

  return undefined;
}

function previouslytouchedtriggertype(var_7edface381884ca9, currenttriggertype) {
  var_1b99bb6cc4aec0fe = 0;

  if(isDefined(var_7edface381884ca9.var_86a97258f28d622c)) {
    previoustriggertype = var_7edface381884ca9.var_86a97258f28d622c;

    if(currenttriggertype == previoustriggertype) {
      var_1b99bb6cc4aec0fe = 1;
    } else if((currenttriggertype == "default" || currenttriggertype == "minefield") && (previoustriggertype == "default" || previoustriggertype == "minefield")) {
      var_1b99bb6cc4aec0fe = 1;
    }
  }

  return var_1b99bb6cc4aec0fe;
}

function function_86afcfb8eb7bf0d2(trigger) {}

function function_d55ed59c0ce164d3() {}

function globalobjectivechangerequests(var_cad5e66c0a5dc607) {
  level endon("game_ended");
  level notify("globalObjectiveChangeRequests");
  level endon("globalObjectiveChangeRequests");
  level.var_92accdcd4283f715 = [];

  while(true) {
    level waittill("global_objective_request", objective_trigger, var_3948981ff1dd7af6, var_bbba777adf94982f);

    if(istrue(var_cad5e66c0a5dc607)) {
      if(isDefined(objective_trigger)) {
        requested_objective = objective_trigger.script_noteworthy;
        level thread[[level.var_6b67b924a327783]](requested_objective);
      }

      continue;
    }

    assertmsg(" this area of script should not be run at all ");

    if(istrue(var_bbba777adf94982f)) {
      if(scripts\cp\objective_trigger::function_df7e197c7e058e4b()) {
        iprintln("<dev string:x7c>" + "<dev string:x96>");
      }

      thread scripts\cp\cp_objectives::run_objective("stealth_container", "primary");
      continue;
    }

    if(!isDefined(objective_trigger)) {
      assertex(isDefined(objective_trigger), "A Valid Objective Trigger Entity MUST be passed in");

      if(!isDefined(objective_trigger)) {
        continue;
      }
    }

    requested_objective = objective_trigger.script_noteworthy;

    if(array_contains(level.var_92accdcd4283f715, requested_objective)) {
      if(scripts\cp\objective_trigger::function_df7e197c7e058e4b()) {
        iprintln("<dev string:xa8>" + requested_objective + "<dev string:xc1>");
      }

      continue;
    }

    if(istrue(var_3948981ff1dd7af6)) {
      function_da21af5d15c8dc18(requested_objective);
    }

    level.var_92accdcd4283f715 = array_add(level.var_92accdcd4283f715, requested_objective);

    if(scripts\cp\objective_trigger::function_df7e197c7e058e4b()) {
      iprintln("<dev string:x7c>" + requested_objective);
    }

    thread scripts\cp\cp_objectives::run_objective(requested_objective, "primary");
  }
}

function function_da21af5d15c8dc18(requested_objective) {
  foreach(struct in level.activequests) {
    name = struct.objname;

    if(name == requested_objective) {
      continue;
    }

    objectivestruct = scripts\cp\cp_objectives::getobjectivestructfromref(name);
    scripts\cp\cp_objectives::function_4312a455bfdaa469(objectivestruct, name);
    level.var_92accdcd4283f715 = array_remove(level.var_92accdcd4283f715, name);
  }
}

function function_df7e197c7e058e4b() {
  return getdvarint(@ "hash_c4abdd14bce1e11c", 0) != 0;
}