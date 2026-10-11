/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\radar_scrambler.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_debug;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\damagefeedback;
#using scripts\cp\radar_scrambler;
#using scripts\cp\utility\entity;
#using scripts\cp\utility\player;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace radar_scrambler;

function function_5e22f6eb6e70e147(ent, ref) {
  ent.var_61e67dd981e04fa7 = ref;

  var_39cbc9721c434ec0 = getdvarint(@ "hash_3b476633c9786299", 0);

  if(var_39cbc9721c434ec0) {
    function_718f576400d123ab(ent);
  }
}

function function_685226f608467ebc(ent) {
  ent.var_61e67dd981e04fa7 = undefined;
}

function function_1cbb16c6ba553df4(ref, callback) {
  struct = function_ba2c0913938c899c();
  struct.entercallbacks[ref] = callback;
}

function function_6fc424055f4e95e8(ref, callback) {
  struct = function_ba2c0913938c899c();
  struct.exitcallbacks[ref] = callback;
}

function function_f4f717f11d752bd6(ref, callback) {
  struct = function_ba2c0913938c899c();
  struct.outoftimecallbacks[ref] = callback;
}

function function_b312d240cf7de0ab(ref, callback) {
  struct = function_ba2c0913938c899c();
  struct.clearcallbacks[ref] = callback;
}

function function_115a3eaee4810f76(ent, var_3e36f415f762070e) {
  if(function_9a757451ba80f667(ent)) {
    return false;
  }

  if(istrue(var_3e36f415f762070e) && function_9a757451ba80f667(ent)) {
    return false;
  }

  return isDefined(ent.radarscrambler) && ent.radarscrambler > 0;
}

function function_d064e7371ba358c1(ent) {
  if(!isDefined(ent.radarscrambler)) {
    ent.radarscrambler = 0;
  }

  ent.radarscrambler++;

  if(ent.radarscrambler == 1) {
    if(!isDefined(ent.var_1ac0aed2528825d4) || ent.var_1ac0aed2528825d4 <= 0) {
      function_b96aa092dca79d81(ent);
    }
  }
}

function function_8f7ba87b5415ac10(ent, var_d5c909837fd4deb4) {
  assertex(isDefined(ent.radarscrambler), "disableradarScrambler called on an entity that was not in the Ai Region. ");

  if(!isDefined(ent.radarscrambler)) {
    if(isDefined(ent)) {
      print3d(ent.origin + (0, 0, 50), "<dev string:x1c>" + ent getentitynumber() + "<dev string:x29>", (1, 1, 1), 1, 1, 666);

      ent hudoutlineenable("outline_cp_teleport_debug");
      iprintlnbold("ent vars:script_suspend_group: ^1" + ent.script_suspend_group + "^5 script_suspend: ^1" + ent.script_suspend);

      line(ent.origin, ent.origin + (0, 0, 1000), (1, 0, 0), 1, 0, 666);
    }
  }

  if(!istrue(var_d5c909837fd4deb4)) {
    assertex(ent.radarscrambler > 0, "disableradarScrambler more times than enableradarScrambler.");
  }

  ent.radarscrambler--;

  if(ent.radarscrambler == 0) {
    ent.radarscrambler = undefined;

    if(!isDefined(ent.var_1ac0aed2528825d4) || ent.var_1ac0aed2528825d4 <= 0) {
      function_dde838674be7ab8f(ent, 0);
    }
  }
}

function function_9a757451ba80f667(ent) {
  return isDefined(ent.var_1ac0aed2528825d4) && ent.var_1ac0aed2528825d4 > 0;
}

function function_718f576400d123ab(ent) {
  if(!isDefined(ent.var_1ac0aed2528825d4)) {
    ent.var_1ac0aed2528825d4 = 0;
  }

  ent.var_1ac0aed2528825d4++;

  if(ent.var_1ac0aed2528825d4 == 1) {
    if(isDefined(ent.radarscrambler) && ent.radarscrambler > 0) {
      function_dde838674be7ab8f(ent, 0);
    }
  }
}

function function_904c55fe002f0632(ent) {
  assertex(isDefined(ent.var_1ac0aed2528825d4), "disableradarScramblerImmunity called on an entity without Ai Region immunity.");
  assertex(ent.var_1ac0aed2528825d4 > 0, "disableradarScramblerImmunity more times than enableradarScramblerImmunity.");
  ent.var_1ac0aed2528825d4--;

  if(ent.var_1ac0aed2528825d4 == 0) {
    ent.var_1ac0aed2528825d4 = undefined;

    if(isDefined(ent.radarscrambler) && ent.radarscrambler > 0) {
      function_b96aa092dca79d81(ent);
    }
  }
}

function function_9701c5af0ae46cd(ent, fromdeath) {
  ent notify("clear_radarScrambler");

  if(function_115a3eaee4810f76(ent, 1)) {
    function_dde838674be7ab8f(ent, fromdeath, 1);
  }

  clearcallback = undefined;

  if(isPlayer(ent)) {
    clearcallback = &playerclearcallback;
  } else if(isagent(ent)) {
    clearcallback = &playerclearcallback;
  } else if(isDefined(ent.var_61e67dd981e04fa7)) {
    struct = function_ba2c0913938c899c();
    clearcallback = struct.clearcallbacks[ent.var_61e67dd981e04fa7];
  }

  if(isDefined(clearcallback)) {
    ent[[clearcallback]]();
  }

  ent.var_61e67dd981e04fa7 = undefined;
  ent.radarscrambler = undefined;
  ent.var_1ac0aed2528825d4 = undefined;
  ent.var_c0dca0d832b0fed6 = undefined;
  ent.var_cebd9d0b4638aeda = undefined;
  ent.var_7a3a633f3137ee = undefined;

  if(isDefined(ent.var_f676be7150162ca7)) {
    foreach(trigger in ent.var_f676be7150162ca7) {
      trigger.entstouching[ent getentitynumber()] = undefined;
    }

    ent.var_f676be7150162ca7 = undefined;
  }

  if(isDefined(ent.var_540861e2af03a290)) {
    foreach(trigger in ent.var_540861e2af03a290) {
      trigger.entstouching[ent getentitynumber()] = undefined;
    }

    ent.var_540861e2af03a290 = undefined;
  }
}

function function_9ecb03c3e2b1a959() {
  if(istrue(self.allowedintrigger)) {
    return false;
  }

  if(!isDefined(level.var_f676be7150162ca7)) {
    return false;
  }

  foreach(trigger in level.var_f676be7150162ca7) {
    if(!function_7b13ee86bdaaeba(trigger, self)) {
      continue;
    }

    if(self istouching(trigger)) {
      return true;
    }
  }

  return false;
}

function function_29955ef665e7793d(pointtocheck, teamtocheck) {
  var_85aa6256b13776ad = 0;

  if(!isDefined(level.var_f676be7150162ca7)) {
    return var_85aa6256b13776ad;
  } else {
    foreach(trigger in level.var_f676be7150162ca7) {
      if(ispointinvolume(pointtocheck, trigger)) {
        if(isDefined(trigger.script_team) && isDefined(teamtocheck) && trigger.script_team != teamtocheck) {
          continue;
        }

        var_85aa6256b13776ad = 1;
        break;
      }
    }
  }

  return var_85aa6256b13776ad;
}

function function_44a315340c86e09(point, circlecenter, circleradius) {
  x = point[0];
  y = point[1];

  if((x - circlecenter[0]) * (x - circlecenter[0]) + (y - circlecenter[1]) * (y - circlecenter[1]) <= circleradius * circleradius) {
    return 1;
  }

  return 0;
}

function function_d86f905b2efc08b9() {
  create_func_ref("<dev string:x74>", &scripts\cp\cp_debug::draw_spawner);

  level.overwatch_emp_low = 0.8;
  level.overwatch_emp_high = 1.2;
  level.overwatch_emp_free = 5;

  if(!flag_exist("radar_scramblers_initialized")) {
    flag_init("radar_scramblers_initialized");
  }

  if(!flag_exist("ready_for_region_spawning")) {
    flag_init("ready_for_region_spawning");
  }

  if(!isDefined(level.var_f676be7150162ca7)) {
    level.var_f676be7150162ca7 = [];
  }

  level.var_f676be7150162ca7 = array_combine(level.var_f676be7150162ca7, getEntArray("radar_scrambler", "targetname"));
  thread function_60ec8aa27cc049e6();
}

function function_a8000c9cbf395db1() {
  if(!flag_exist("level_ready_for_script")) {
    flag_init("level_ready_for_script");
  }

  flag_wait("level_ready_for_script");

  if(isDefined(level.var_fc46cd90f0a40c87)) {
    [[level.var_fc46cd90f0a40c87]]();
  }

  if(!isDefined(level.var_f676be7150162ca7)) {
    level.var_f676be7150162ca7 = [];
  }

  level.var_f676be7150162ca7 = array_combine(level.var_f676be7150162ca7, getEntArray("radar_scrambler", "targetname"));
  thread function_60ec8aa27cc049e6();
}

function function_b96aa092dca79d81(ent) {
  entercallback = undefined;
  trigger = function_3d92e694ec2d0078(ent);
  triggertype = gettriggertype(ent, trigger);

  if(isPlayer(ent)) {
    entercallback = &playerentercallback;
  } else if(isagent(ent)) {
    entercallback = &function_b2a14335ecf202f8;
  } else if(isDefined(ent.var_61e67dd981e04fa7)) {
    struct = function_ba2c0913938c899c();
    entercallback = struct.entercallbacks[ent.var_61e67dd981e04fa7];
  }

  ent notify("radarScrambler_cooldown_end");

  if(isDefined(ent.var_c0dca0d832b0fed6) && previouslytouchedtriggertype(ent, triggertype)) {
    var_24ab8327af3f90df = ent.var_c0dca0d832b0fed6 / 1000;
    ent.var_cebd9d0b4638aeda = int(gettime() + ent.var_c0dca0d832b0fed6);
    ent.var_c0dca0d832b0fed6 = undefined;
    thread function_c9da074c99cdad85(ent, var_24ab8327af3f90df);
  } else {
    ent.var_c0dca0d832b0fed6 = undefined;
    ent.var_7a3a633f3137ee = triggertype;
    var_24ab8327af3f90df = function_11982fa04c4ade15(triggertype);
    ent.var_cebd9d0b4638aeda = int(gettime() + var_24ab8327af3f90df * 1000);
    thread function_c9da074c99cdad85(ent, var_24ab8327af3f90df);
  }

  if(isDefined(entercallback)) {
    ent thread[[entercallback]]("exit_radarScrambler", "clear_radarScrambler", triggertype, trigger);
  }
}

function function_dde838674be7ab8f(ent, fromdeath, fromclear) {
  ent notify("exit_radarScrambler");
  exitcallback = undefined;

  if(isPlayer(ent)) {
    exitcallback = &playerexitcallback;
  } else if(isagent(ent)) {
    exitcallback = &function_d405dee230e91b4;
  } else if(isDefined(ent.var_61e67dd981e04fa7)) {
    struct = function_ba2c0913938c899c();
    exitcallback = struct.exitcallbacks[ent.var_61e67dd981e04fa7];
  }

  ent notify("radarScrambler_timeout_end");

  if(!istrue(fromclear)) {
    if(isDefined(ent.var_cebd9d0b4638aeda)) {
      ent.var_c0dca0d832b0fed6 = int(max(0, ent.var_cebd9d0b4638aeda - gettime()));
      ent.var_cebd9d0b4638aeda = undefined;
      trigger = function_3d92e694ec2d0078(ent);
      triggertype = gettriggertype(ent, trigger);
      cooldowntime = getcooldowntime(triggertype);
      thread function_e209a39163f0883a(ent, cooldowntime);
    }
  }

  if(isDefined(exitcallback)) {
    ent thread[[exitcallback]](fromdeath, fromclear, "clear_radarScrambler");
  }
}

function function_42daab738a799575(ent) {
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
  } else if(isDefined(ent.var_61e67dd981e04fa7)) {
    struct = function_ba2c0913938c899c();
    outoftimecallback = struct.outoftimecallbacks[ent.var_61e67dd981e04fa7];
  }

  if(isDefined(outoftimecallback)) {
    ent thread[[outoftimecallback]]("radarScrambler_timeout_end", "clear_radarScrambler");
  }
}

function function_c9da074c99cdad85(ent, timeleft) {
  if(isPlayer(ent) || isagent(ent)) {
    ent endon("death");
  }

  ent notify("radarScrambler_timeout_end");
  ent endon("radarScrambler_timeout_end");
  ent endon("clear_radarScrambler");
  wait timeleft;
  thread function_42daab738a799575(ent);
}

function function_e209a39163f0883a(ent, timeleft) {
  if(isPlayer(ent) || isagent(ent)) {
    ent endon("death");
  }

  ent notify("radarScrambler_cooldown_end");
  ent endon("radarScrambler_cooldown_end");
  ent endon("clear_radarScrambler");
  wait timeleft;
  ent.var_c0dca0d832b0fed6 = undefined;
  ent.var_7a3a633f3137ee = undefined;
}

function playerentercallback(exitnotify, clearnotify, triggertype, trigger) {
  var_3a44172702973ab6 = 1;

  if(isDefined(triggertype) && triggertype == "restricted") {
    var_3a44172702973ab6 = 2;
  }

  self.radar_trigger = trigger;

  self iprintln("<dev string:x81>");

  scripts\cp\radar_scrambler::emp_effects_flickering(self);
}

function function_b2a14335ecf202f8(exitnotify, clearnotify, triggertype, trigger) {
  var_3a44172702973ab6 = 1;

  if(isDefined(triggertype) && triggertype == "restricted") {
    var_3a44172702973ab6 = 2;
  }

  function_86afcfb8eb7bf0d2(trigger);
  self.radar_trigger = trigger;
}

function playerexitcallback(fromdeath, fromclear, clearnotify) {
  self.radar_trigger = undefined;

  self iprintln("<dev string:xaa>");

  scripts\cp\radar_scrambler::function_11011e6292a21c15(self);
}

function function_d405dee230e91b4(fromdeath, fromclear, clearnotify) {
  self.radar_trigger = undefined;
  function_d55ed59c0ce164d3();
}

function playeroutoftimecallback(timeoutendnotify, clearnotify) {
  trigger = function_3d92e694ec2d0078(self);
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
  var_3a44172702973ab6 = 1;

  if(islargemap() && level.gametype == "arm" && isDefined(triggertype) && triggertype == "restricted") {
    var_3a44172702973ab6 = 2;
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

function function_831c13bfee564637() {
  function_1cbb16c6ba553df4("killstreak", &killstreakentercallback);
  function_6fc424055f4e95e8("killstreak", &killstreakexitcallback);
  function_f4f717f11d752bd6("killstreak", &killstreakoutoftimecallback);
  function_b312d240cf7de0ab("killstreak", &killstreakclearcallback);
}

function function_60ec8aa27cc049e6() {
  updated_array = [];

  if(isDefined(level.var_f676be7150162ca7)) {
    flag_set("radar_scramblers_initialized");

    foreach(trigger in level.var_f676be7150162ca7) {
      thread watchradarscramblertrigger(trigger);
    }

    if(isDefined(level.var_c03cdc5f3ad34ee0)) {
      foreach(trigger in level.var_c03cdc5f3ad34ee0) {
        thread watchradarscramblersuppressiontrigger(trigger);
      }
    }
  }
}

function watchradarscramblertrigger(trigger) {
  trigger notify("watchradarScramblerTrigger");
  trigger endon("watchradarScramblerTrigger");
  trigger.entstouching = [];

  if(isDefined(trigger.target)) {
    trigger.var_3efe1b3a9ef1aba0 = getEnt(trigger.target, "targetname");
    trigger.var_3efe1b3a9ef1aba0.parent_trigger = trigger;
    trigger.var_3efe1b3a9ef1aba0 thread scripts\cp\radar_scrambler::function_e849523551c4f041();
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  thread watchradarscramblertriggerexit(trigger);
  thread watchradarscramblertriggerenter(trigger);
}

function watchradarscramblertriggerenter(trigger) {
  level endon("game_ended");
  trigger notify("watchradarScramblerTriggerEnter");
  trigger endon("watchradarScramblerTriggerEnter");
  trigger endon("death");

  while(true) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent) && isDefined(ent.c130)) {
      continue;
    }

    if(!function_7b13ee86bdaaeba(trigger, ent)) {
      continue;
    }

    if(!function_2e7a2d85639052ea(ent)) {
      continue;
    }

    function_1916e100f11c7787(trigger, ent);
  }
}

function watchradarscramblertriggerexit(trigger) {
  level endon("game_ended");
  trigger notify("watchradarScramblerTriggerExit");
  trigger endon("watchradarScramblerTriggerExit");
  trigger endon("death");

  while(true) {
    temparr = trigger.entstouching;

    foreach(ent in temparr) {
      if(!isDefined(ent)) {
        trigger.entstouching[id] = undefined;
      }

      if(isDefined(ent) && !trigger istouching(ent)) {
        function_45efa9bc7f471ef1(trigger, ent);
      }
    }

    waitframe();
  }
}

function function_1916e100f11c7787(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }

  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent.var_f676be7150162ca7)) {
    ent.var_f676be7150162ca7 = [];
  }

  temparr = [trigger];

  foreach(radarscramblertrigger in ent.var_f676be7150162ca7) {
    temparr[temparr.size] = radarscramblertrigger;
  }

  ent.var_f676be7150162ca7 = temparr;
  function_d064e7371ba358c1(ent);
}

function function_45efa9bc7f471ef1(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  function_8f7ba87b5415ac10(ent);
  ent notify("clean_up_exit_threads");

  if(isDefined(ent.var_f676be7150162ca7)) {
    ent.var_f676be7150162ca7 = array_remove(ent.var_f676be7150162ca7, trigger);

    if(ent.var_f676be7150162ca7.size == 0) {
      ent.var_f676be7150162ca7 = undefined;
    }
  }
}

function watchradarscramblersuppressiontrigger(trigger) {
  trigger notify("watchradarScramblerSuppressionTrigger");
  trigger endon("watchradarScramblerSuppressionTrigger");
  trigger.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread watchradarscramblersuppressiontriggerexit(trigger);
  thread watchradarscramblersupressiontriggerenter(trigger);
}

function watchradarscramblersupressiontriggerenter(trigger) {
  level endon("game_ended");
  trigger notify("watchradarScramblerSupressionTriggerEnter");
  trigger endon("watchradarScramblerSupressionTriggerEnter");
  trigger endon("death");

  while(true) {
    trigger waittill("trigger", ent);

    if(!function_2e7a2d85639052ea(ent)) {
      continue;
    }

    function_1d37828868e98950(trigger, ent);
  }
}

function watchradarscramblersuppressiontriggerexit(trigger) {
  level endon("game_ended");
  trigger notify("watchradarScramblerSuppressionTriggerExit");
  trigger endon("watchradarScramblerSuppressionTriggerExit");
  trigger endon("death");

  while(true) {
    temparr = trigger.entstouching;

    if(isDefined(temparr)) {
      foreach(ent in temparr) {
        if(!isDefined(ent)) {
          trigger.entstouching[id] = undefined;
        }

        if(isDefined(ent) && !trigger istouching(ent)) {
          function_2aad14c8236ac768(trigger, ent);
        }
      }
    }

    waitframe();
  }
}

function function_1d37828868e98950(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }

  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent.var_540861e2af03a290)) {
    ent.var_540861e2af03a290 = [];
  }

  temparr = [trigger];

  foreach(radarscramblersuppressiontrigger in ent.var_540861e2af03a290) {
    temparr[temparr.size] = radarscramblersuppressiontrigger;
  }

  ent.var_540861e2af03a290 = temparr;
  function_718f576400d123ab(ent);
}

function function_2aad14c8236ac768(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  ent.var_540861e2af03a290[trigger getentitynumber()] = undefined;

  if(ent.var_540861e2af03a290.size == 0) {
    ent.var_540861e2af03a290 = undefined;
  }

  function_904c55fe002f0632(ent);
}

function function_7b13ee86bdaaeba(trigger, ent) {
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

function function_2e7a2d85639052ea(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent) || isagent(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive()) {
        return true;
      }
    }

    if(isDefined(ent.var_61e67dd981e04fa7)) {
      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(ent.isdestroyed)) {
          return true;
        }
      }

      if(isDefined(ent.streakinfo) && function_a8c8f4079a8961f5(ent.streakinfo.streakname)) {
        return true;
      }
    }
  }

  return false;
}

function function_ba2c0913938c899c() {
  struct = level.var_918019b3bb20e3c6;

  if(!isDefined(struct)) {
    struct = spawnStruct();
    struct.entercallbacks = [];
    struct.exitcallbacks = [];
    struct.outoftimecallbacks = [];
    struct.clearcallbacks = [];
    level.var_918019b3bb20e3c6 = struct;
  }

  return struct;
}

function function_a8c8f4079a8961f5(streakname) {
  var_1990e52ab5821aa7 = 0;

  switch (streakname) {
    case #"hash_cf0ef5bef19a311b":
    case #"hash_e40585107590f016":
      var_1990e52ab5821aa7 = 1;
      break;
  }

  return var_1990e52ab5821aa7;
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
      return function_11982fa04c4ade15(triggertype);
  }

  return undefined;
}

function function_11982fa04c4ade15(triggertype) {
  switch (triggertype) {
    case #"hash_18ad1d5da2e56d4c":
    case #"hash_6b15362474c2e2b2":
    case #"hash_7038dec66d8275be":
    case #"hash_fa21c4f6bd5e3815":
      return function_f301b665c2864e7d();
  }

  return undefined;
}

function function_f301b665c2864e7d() {
  return max(0, getdvarfloat(@ "hash_9c25e05a8010d645", 3));

  var_24ab8327af3f90df = level.var_24ab8327af3f90df;

  if(!isDefined(var_24ab8327af3f90df)) {
    var_24ab8327af3f90df = max(0, getdvarfloat(@ "hash_9c25e05a8010d645", 3));
    level.var_24ab8327af3f90df = var_24ab8327af3f90df;
  }

  return var_24ab8327af3f90df;
}

function function_3d92e694ec2d0078(ent) {
  if(isDefined(ent.var_f676be7150162ca7)) {
    return ent.var_f676be7150162ca7[0];
  }

  return undefined;
}

function previouslytouchedtriggertype(var_7edface381884ca9, currenttriggertype) {
  var_1b99bb6cc4aec0fe = 0;

  if(isDefined(var_7edface381884ca9.var_7a3a633f3137ee)) {
    previoustriggertype = var_7edface381884ca9.var_7a3a633f3137ee;

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

function function_417718db737858b7() {
  wait 5;
  level.overwatch_emp_low = 0.8;
  level.overwatch_emp_high = 1.2;
  level.overwatch_emp_free = 5;
  level.var_3d1e30b1d4cdea65 = getEntArray("emp_jammer", "targetname");

  foreach(location_ent in level.var_3d1e30b1d4cdea65) {
    location_ent hudoutlineenable("outline_nodepth_red");
    location_ent thread function_e849523551c4f041();
  }
}

function function_e849523551c4f041() {
  self endon("death");
  self setCanDamage(1);
  self.health = 9999;
  self.maxhealth = 9999;
  self.var_abbaa2fc2b3da347 = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isPlayer(attacker)) {
      continue;
    }

    if(meansofdeath == "MOD_GRENADE_SPLASH") {
      continue;
    }

    attacker thread scripts\cp\damagefeedback::updatedamagefeedback("hitturret", undefined, damage, 1);
    self.var_abbaa2fc2b3da347++;

    if(self.var_abbaa2fc2b3da347 < 5) {
      continue;
    }

    attacker iprintln("<dev string:xcf>");

    if(isDefined(self.parent_trigger)) {
      foreach(ent in self.parent_trigger.entstouching) {
        function_45efa9bc7f471ef1(self.parent_trigger, ent);
      }
    }

    self.parent_trigger delete();
    self delete();
  }
}

function emp_effects_flickering(player) {
  level endon("stop_overwatch_emp_effects");
  player endon("stop_overwatch_emp_effects");
  player endon("disconnect");
  player notify("emp_effects_flickering");
  player endon("emp_effects_flickering");
  var_3996095e0b23a557 = 0.75;

  while(true) {
    randomtime = randomfloatrange(level.overwatch_emp_low, level.overwatch_emp_high);
    player thread scripts\cp_mp\emp_debuff::play_scramble_for_player_until_cleared(player, 5);
    randomdelay = randomfloat(level.overwatch_emp_free);
    wait randomtime + var_3996095e0b23a557 + randomdelay;
  }
}

function function_11011e6292a21c15(player) {
  player notify("stop_overwatch_emp_effects");
  player notify("emp_cleared");
  player.mark_emp_effects = undefined;
}

function stop_emp_effects_on_players() {
  level notify("stop_overwatch_emp_effects");

  for(i = 0; i < level.players.size; i++) {
    level notify("emp_cleared");
    level.players[i].mark_emp_effects = undefined;
  }
}