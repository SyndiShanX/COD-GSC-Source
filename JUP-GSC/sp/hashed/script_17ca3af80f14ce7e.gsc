/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_17ca3af80f14ce7e.gsc
*************************************************/

#using script_17ca3af80f14ce7e;
#using scripts\aitypes\stealth;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\common\utility;
#using scripts\cp\cp_debug;
#using scripts\cp\cp_hostmigration;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\spawner_scoring;
#using scripts\cp\spawning;
#using scripts\cp\utility\entity;
#using scripts\cp\utility\player;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\stealth\enemy;
#using scripts\stealth\event;
#namespace region_spawning;

function function_68c57b54d96715be(ent, ref) {
  ent.var_5a3a4c78b256fd0c = ref;

  var_bfe622d7e1204e91 = getdvarint(@ "hash_4a011e0807fb1f84", 0);

  if(var_bfe622d7e1204e91) {
    function_de8fd4597c7de8c6(ent);
  }
}

function function_4bebbb5c8c6e784d(ent) {
  ent.var_5a3a4c78b256fd0c = undefined;
}

function function_212d8f5b276b3f7b(ref, callback) {
  struct = function_ee4ce9c0d26a5865();
  struct.entercallbacks[ref] = callback;
}

function function_6963af169a8ebf81(ref, callback) {
  struct = function_ee4ce9c0d26a5865();
  struct.exitcallbacks[ref] = callback;
}

function function_9013d3e97478c915(ref, callback) {
  struct = function_ee4ce9c0d26a5865();
  struct.outoftimecallbacks[ref] = callback;
}

function function_abe54546e3e8f240(ref, callback) {
  struct = function_ee4ce9c0d26a5865();
  struct.clearcallbacks[ref] = callback;
}

function function_c38b50e3dd763ae3(ent, var_3e36f415f762070e) {
  if(function_96378641b22bea7e(ent)) {
    return false;
  }

  if(istrue(var_3e36f415f762070e) && function_96378641b22bea7e(ent)) {
    return false;
  }

  return isDefined(ent.airegion) && ent.airegion > 0;
}

function function_6909cacfcf4034cc(ent) {
  if(!isDefined(ent.airegion)) {
    ent.airegion = 0;
  }

  ent.airegion++;

  if(ent.airegion == 1) {
    if(!isDefined(ent.var_dec3be43668a3021) || ent.var_dec3be43668a3021 <= 0) {
      function_13d1e809c6b4c18c(ent);
    }
  }
}

function function_9648a478f198a621(ent, var_d5c909837fd4deb4) {
  assertex(isDefined(ent.airegion), "disableaiRegion called on an entity that was not in the Ai Region. ");

  if(!isDefined(ent.airegion)) {
    if(isDefined(ent)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("^3 Ent -> ^1" + ent getentitynumber() + "^3 did not have .spawner variable Defined! (disableaiRegion) ");

        print3d(ent.origin + (0, 0, 50), "<dev string:x1c>" + ent getentitynumber() + "<dev string:x29>", (1, 1, 1), 1, 1, 666);

        ent hudoutlineenable("outline_cp_teleport_debug");
        iprintlnbold("ent vars:script_suspend_group: ^1" + ent.script_suspend_group + "^5 script_suspend: ^1" + ent.script_suspend);

        line(ent.origin, ent.origin + (0, 0, 1000), (1, 0, 0), 1, 0, 666);
      }
    }
  }

  if(!istrue(var_d5c909837fd4deb4)) {
    assertex(ent.airegion > 0, "disableaiRegion more times than enableaiRegion.");
  }

  ent.airegion--;

  if(ent.airegion == 0) {
    ent.airegion = undefined;

    if(!isDefined(ent.var_dec3be43668a3021) || ent.var_dec3be43668a3021 <= 0) {
      function_c87cec962c595206(ent, 0);
    }
  }
}

function function_96378641b22bea7e(ent) {
  return isDefined(ent.var_dec3be43668a3021) && ent.var_dec3be43668a3021 > 0;
}

function function_de8fd4597c7de8c6(ent) {
  if(!isDefined(ent.var_dec3be43668a3021)) {
    ent.var_dec3be43668a3021 = 0;
  }

  ent.var_dec3be43668a3021++;

  if(ent.var_dec3be43668a3021 == 1) {
    if(isDefined(ent.airegion) && ent.airegion > 0) {
      function_c87cec962c595206(ent, 0);
    }
  }
}

function function_bbd1d29bb00c640b(ent) {
  assertex(isDefined(ent.var_dec3be43668a3021), "disableaiRegionImmunity called on an entity without Ai Region immunity.");
  assertex(ent.var_dec3be43668a3021 > 0, "disableaiRegionImmunity more times than enableaiRegionImmunity.");
  ent.var_dec3be43668a3021--;

  if(ent.var_dec3be43668a3021 == 0) {
    ent.var_dec3be43668a3021 = undefined;

    if(isDefined(ent.airegion) && ent.airegion > 0) {
      function_13d1e809c6b4c18c(ent);
    }
  }
}

function function_983add621b34ed28(ent, fromdeath) {
  ent notify("clear_aiRegion");

  if(function_c38b50e3dd763ae3(ent, 1)) {
    function_c87cec962c595206(ent, fromdeath, 1);
  }

  clearcallback = undefined;

  if(isPlayer(ent)) {
    clearcallback = &playerclearcallback;
  } else if(isagent(ent)) {
    clearcallback = &playerclearcallback;
  } else if(isDefined(ent.var_5a3a4c78b256fd0c)) {
    struct = function_ee4ce9c0d26a5865();
    clearcallback = struct.clearcallbacks[ent.var_5a3a4c78b256fd0c];
  }

  if(isDefined(clearcallback)) {
    ent[[clearcallback]]();
  }

  ent.var_5a3a4c78b256fd0c = undefined;
  ent.airegion = undefined;
  ent.var_dec3be43668a3021 = undefined;
  ent.var_d9680b0125820647 = undefined;
  ent.var_bae64961a3976f9 = undefined;
  ent.var_3392ef5b6b742ad5 = undefined;

  if(isDefined(ent.var_ceb9d44b40906c4a)) {
    foreach(trigger in ent.var_ceb9d44b40906c4a) {
      trigger.entstouching[ent getentitynumber()] = undefined;
    }

    ent.var_ceb9d44b40906c4a = undefined;
  }

  if(isDefined(ent.var_2ba26fbb56cce6b5)) {
    foreach(trigger in ent.var_2ba26fbb56cce6b5) {
      trigger.entstouching[ent getentitynumber()] = undefined;
    }

    ent.var_2ba26fbb56cce6b5 = undefined;
  }
}

function function_7e9f0258159a7bd6() {
  if(istrue(self.allowedintrigger)) {
    return false;
  }

  if(!isDefined(level.var_ceb9d44b40906c4a)) {
    return false;
  }

  foreach(trigger in level.var_ceb9d44b40906c4a) {
    if(!function_84f2d42d2d646239(trigger, self)) {
      continue;
    }

    if(self istouching(trigger)) {
      return true;
    }
  }

  return false;
}

function function_528bcc710bb30998(pointtocheck, teamtocheck) {
  var_4b9d6f93b356408 = 0;

  if(!isDefined(level.var_ceb9d44b40906c4a)) {
    return var_4b9d6f93b356408;
  } else {
    foreach(trigger in level.var_ceb9d44b40906c4a) {
      if(ispointinvolume(pointtocheck, trigger)) {
        if(isDefined(trigger.script_team) && isDefined(teamtocheck) && trigger.script_team != teamtocheck) {
          continue;
        }

        var_4b9d6f93b356408 = 1;
        break;
      }
    }
  }

  return var_4b9d6f93b356408;
}

function function_8370af6cf6e65620(spawner, trigger) {
  pointtocheck = spawner.origin;
  var_4b9d6f93b356408 = 0;

  if(!isDefined(level.var_ceb9d44b40906c4a)) {
    return undefined;
  } else if(namespace_1fdb557af4bcd29e::function_44a315340c86e09(pointtocheck, trigger.origin, trigger.struct.radius)) {
    var_4b9d6f93b356408 = 1;
    trigger = namespace_1fdb557af4bcd29e::function_bac68a34c968c639(spawner, trigger);
  }

  return trigger;
}

function function_44a315340c86e09(point, circlecenter, circleradius) {
  x = point[0];
  y = point[1];

  if((x - circlecenter[0]) * (x - circlecenter[0]) + (y - circlecenter[1]) * (y - circlecenter[1]) <= circleradius * circleradius) {
    return 1;
  }

  return 0;
}

function function_4becaa200ddc0956() {
  create_func_ref("<dev string:x68>", &scripts\cp\cp_debug::draw_spawner);

  if(!flag_exist("ai_regions_initialized")) {
    flag_init("ai_regions_initialized");
  }

  if(!flag_exist("ready_for_region_spawning")) {
    flag_init("ready_for_region_spawning");
  }

  if(!isDefined(level.var_ceb9d44b40906c4a)) {
    level.var_ceb9d44b40906c4a = [];
  }

  level.var_ceb9d44b40906c4a = array_combine(level.var_ceb9d44b40906c4a, getEntArray("ai_region", "targetname"));
  thread function_aaa58df7db9699e7();
  level thread function_1a3fb64b55b6e6ee();
}

function function_2b1e89bbebab6964() {
  if(!flag_exist("level_ready_for_script")) {
    flag_init("level_ready_for_script");
  }

  flag_wait("level_ready_for_script");

  if(isDefined(level.var_fc46cd90f0a40c87)) {
    [[level.var_fc46cd90f0a40c87]]();
  }

  if(!isDefined(level.var_ceb9d44b40906c4a)) {
    level.var_ceb9d44b40906c4a = [];
  }

  level.var_ceb9d44b40906c4a = array_combine(level.var_ceb9d44b40906c4a, getEntArray("ai_region", "targetname"));
  thread function_aaa58df7db9699e7();
}

function function_13d1e809c6b4c18c(ent) {
  entercallback = undefined;
  trigger = function_f4e12eccaefc243(ent);
  triggertype = gettriggertype(ent, trigger);

  if(isPlayer(ent)) {
    entercallback = &playerentercallback;
  } else if(isagent(ent)) {
    entercallback = &function_b2a14335ecf202f8;
  } else if(isDefined(ent.var_5a3a4c78b256fd0c)) {
    struct = function_ee4ce9c0d26a5865();
    entercallback = struct.entercallbacks[ent.var_5a3a4c78b256fd0c];
  }

  ent notify("aiRegion_cooldown_end");

  if(isDefined(ent.var_d9680b0125820647) && previouslytouchedtriggertype(ent, triggertype)) {
    var_37dc2f766a2fa2a = ent.var_d9680b0125820647 / 1000;
    ent.var_bae64961a3976f9 = int(gettime() + ent.var_d9680b0125820647);
    ent.var_d9680b0125820647 = undefined;
    thread function_269a6b999cb5f292(ent, var_37dc2f766a2fa2a);
  } else {
    ent.var_d9680b0125820647 = undefined;
    ent.var_3392ef5b6b742ad5 = triggertype;
    var_37dc2f766a2fa2a = function_661d1b3cc3d5a2e4(triggertype);
    ent.var_bae64961a3976f9 = int(gettime() + var_37dc2f766a2fa2a * 1000);
    thread function_269a6b999cb5f292(ent, var_37dc2f766a2fa2a);
  }

  if(isDefined(entercallback)) {
    ent thread[[entercallback]]("exit_aiRegion", "clear_aiRegion", triggertype, trigger);
  }
}

function function_c87cec962c595206(ent, fromdeath, fromclear) {
  ent notify("exit_aiRegion");
  exitcallback = undefined;

  if(isPlayer(ent)) {
    exitcallback = &playerexitcallback;
  } else if(isagent(ent)) {
    exitcallback = &function_d405dee230e91b4;
  } else if(isDefined(ent.var_5a3a4c78b256fd0c)) {
    struct = function_ee4ce9c0d26a5865();
    exitcallback = struct.exitcallbacks[ent.var_5a3a4c78b256fd0c];
  }

  ent notify("aiRegion_timeout_end");

  if(!istrue(fromclear)) {
    if(isDefined(ent.var_bae64961a3976f9)) {
      ent.var_d9680b0125820647 = int(max(0, ent.var_bae64961a3976f9 - gettime()));
      ent.var_bae64961a3976f9 = undefined;
      trigger = function_f4e12eccaefc243(ent);
      triggertype = gettriggertype(ent, trigger);
      cooldowntime = getcooldowntime(triggertype);
      thread function_a0c5231a5482846f(ent, cooldowntime);
    }
  }

  if(isDefined(exitcallback)) {
    ent thread[[exitcallback]](fromdeath, fromclear, "clear_aiRegion");
  }
}

function function_a02fd06df65094c2(ent) {
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
  } else if(isDefined(ent.var_5a3a4c78b256fd0c)) {
    struct = function_ee4ce9c0d26a5865();
    outoftimecallback = struct.outoftimecallbacks[ent.var_5a3a4c78b256fd0c];
  }

  if(isDefined(outoftimecallback)) {
    ent thread[[outoftimecallback]]("aiRegion_timeout_end", "clear_aiRegion");
  }
}

function function_269a6b999cb5f292(ent, timeleft) {
  if(isPlayer(ent) || isagent(ent)) {
    ent endon("death");
  }

  ent notify("aiRegion_timeout_end");
  ent endon("aiRegion_timeout_end");
  ent endon("clear_aiRegion");
  wait timeleft;
  thread function_a02fd06df65094c2(ent);
}

function function_a0c5231a5482846f(ent, timeleft) {
  if(isPlayer(ent) || isagent(ent)) {
    ent endon("death");
  }

  ent notify("aiRegion_cooldown_end");
  ent endon("aiRegion_cooldown_end");
  ent endon("clear_aiRegion");
  wait timeleft;
  ent.var_d9680b0125820647 = undefined;
  ent.var_3392ef5b6b742ad5 = undefined;
}

function playerentercallback(exitnotify, clearnotify, triggertype, trigger) {
  var_ee954ef8140d304b = 1;

  if(isDefined(triggertype) && triggertype == "restricted") {
    var_ee954ef8140d304b = 2;
  }

  self.region_trigger = trigger;

  self iprintln("<dev string:x75>");

  trigger notify("spawning_request");
}

function function_b2a14335ecf202f8(exitnotify, clearnotify, triggertype, trigger) {
  var_ee954ef8140d304b = 1;

  if(isDefined(triggertype) && triggertype == "restricted") {
    var_ee954ef8140d304b = 2;
  }

  function_86afcfb8eb7bf0d2(trigger);
  self.region_trigger = trigger;
}

function playerexitcallback(fromdeath, fromclear, clearnotify) {
  self.region_trigger = undefined;

  self iprintln("<dev string:x91>");
}

function function_d405dee230e91b4(fromdeath, fromclear, clearnotify) {
  self.region_trigger = undefined;
  function_d55ed59c0ce164d3();
}

function playeroutoftimecallback(timeoutendnotify, clearnotify) {
  trigger = function_f4e12eccaefc243(self);
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
  var_ee954ef8140d304b = 1;

  if(islargemap() && level.gametype == "arm" && isDefined(triggertype) && triggertype == "restricted") {
    var_ee954ef8140d304b = 2;
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

function function_d1f0b7aa511a0() {
  function_212d8f5b276b3f7b("killstreak", &killstreakentercallback);
  function_6963af169a8ebf81("killstreak", &killstreakexitcallback);
  function_9013d3e97478c915("killstreak", &killstreakoutoftimecallback);
  function_abe54546e3e8f240("killstreak", &killstreakclearcallback);
}

function function_aaa58df7db9699e7() {
  updated_array = [];

  if(isDefined(level.var_ceb9d44b40906c4a)) {
    foreach(trigger in level.var_ceb9d44b40906c4a) {
      if(!isDefined(trigger.var_9f9f230946bd8faf)) {
        trigger.var_9f9f230946bd8faf = [];
      }

      updated_trigger = function_afc5010effb06a46(trigger);
      updated_array = array_add(updated_array, updated_trigger);
    }

    level.var_ceb9d44b40906c4a = updated_array;
    flag_set("ai_regions_initialized");

    foreach(trigger in level.var_ceb9d44b40906c4a) {
      if(!isDefined(trigger.var_9f9f230946bd8faf)) {
        trigger.var_9f9f230946bd8faf = [];
      }

      thread watchairegiontrigger(trigger);
    }

    if(isDefined(level.var_acf3fd19390fc26d)) {
      foreach(trigger in level.var_acf3fd19390fc26d) {
        thread watchairegionsuppressiontrigger(trigger);
      }
    }

    thread stealth_event_propagator();
  }
}

function function_afc5010effb06a46(trigger) {
  var_d1facff1e900673 = [];

  foreach(module_struct in level.ambientgroups) {
    if(isarray(module_struct)) {
      continue;
    }

    if(isarray(module_struct.spawn_points)) {
      foreach(struct in module_struct.spawn_points) {
        if(isDefined(struct.script_suspend)) {
          var_11879c5af01a1cde = ter_op(isDefined(level.var_e9363e4bb08955e4), level.var_e9363e4bb08955e4, "region_spawning_test");

          if(var_11879c5af01a1cde != module_name) {
            continue;
          }

          var_cd2708a4b9d60bb9 = namespace_1fdb557af4bcd29e::function_8370af6cf6e65620(struct, trigger);

          if(isDefined(var_cd2708a4b9d60bb9)) {
            trigger = var_cd2708a4b9d60bb9;

            if(namespace_1fdb557af4bcd29e::function_34be418b2813a498()) {
              [[level.func["<dev string:x68>"]]](struct.origin, struct.angles, (0, 1, 0));
            }
          }
        }
      }
    }
  }

  return trigger;
}

function watchairegiontrigger(trigger) {
  trigger notify("watchaiRegionTrigger");
  trigger endon("watchaiRegionTrigger");
  trigger.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread watchairegiontriggerexit(trigger);
  thread watchairegiontriggerenter(trigger);
  thread watchairegiontriggerrequests(trigger);
}

function watchairegiontriggerenter(trigger) {
  level endon("game_ended");
  trigger notify("watchaiRegionTriggerEnter");
  trigger endon("watchaiRegionTriggerEnter");

  while(true) {
    trigger waittill("trigger", ent);

    if(isPlayer(ent) && isDefined(ent.c130)) {
      continue;
    }

    if(!function_84f2d42d2d646239(trigger, ent)) {
      continue;
    }

    if(!function_693b7e3703225a8b(ent)) {
      continue;
    }

    function_8dd05df654cdbbb0(trigger, ent);
  }
}

function watchairegiontriggerexit(trigger) {
  level endon("game_ended");
  trigger notify("watchaiRegionTriggerExit");
  trigger endon("watchaiRegionTriggerExit");

  while(true) {
    temparr = trigger.entstouching;

    foreach(ent in temparr) {
      if(!isDefined(ent)) {
        trigger.entstouching[id] = undefined;
      }

      if(isDefined(ent) && !trigger istouching(ent)) {
        function_985d2edf83e8270e(trigger, ent);
      }
    }

    waitframe();
  }
}

function function_8dd05df654cdbbb0(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }

  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent.var_ceb9d44b40906c4a)) {
    ent.var_ceb9d44b40906c4a = [];
  }

  temparr = [trigger];

  foreach(airegiontrigger in ent.var_ceb9d44b40906c4a) {
    temparr[temparr.size] = airegiontrigger;
  }

  ent.var_ceb9d44b40906c4a = temparr;
  function_6909cacfcf4034cc(ent);

  if(isagent(ent)) {
    if(!isDefined(ent.spawner)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("^3 Ent -> ^1" + ent getentitynumber() + "^3 did not have .spawner variable Defined! (onEnteraiRegionTrigger) ");

        print3d(ent.origin + (0, 0, 50), "<dev string:x1c>" + ent getentitynumber() + "<dev string:xaa>", (1, 1, 1), 1, 1, 666);
        line(ent.origin, ent.origin + (0, 0, 1000), (0.4, 0.3, 0), 1, 0, 666);

        ent hudoutlineenable("outline_cp_teleport_debug");
      }
    }

    if(!array_contains(trigger.var_9f9f230946bd8faf, ent.spawner)) {
      trigger.var_9f9f230946bd8faf = array_add(trigger.var_9f9f230946bd8faf, ent.spawner);
    }

    ent thread function_402c5f663ff803c();
  }
}

function function_402c5f663ff803c() {
  self endon("clean_up_exit_threads");
  self waittill("death");

  if(istrue(self.nocorpse) || self.damagemod == "MOD_SUICIDE") {
    return;
  }

  foreach(trigger in level.var_ceb9d44b40906c4a) {
    trigger.entstouching[self getentitynumber()] = undefined;

    if(isDefined(self.spawner)) {
      if(array_contains(trigger.var_9f9f230946bd8faf, self.spawner)) {
        trigger.var_9f9f230946bd8faf = array_remove(trigger.var_9f9f230946bd8faf, self.spawner);
      }
    }
  }
}

function function_3b55a5779a740df1() {
  if(istrue(self.nocorpse) || self.damagemod == "MOD_SUICIDE") {
    return;
  }

  foreach(trigger in level.var_ceb9d44b40906c4a) {
    trigger.entstouching[self getentitynumber()] = undefined;

    if(isDefined(self.spawner)) {
      if(array_contains(trigger.var_9f9f230946bd8faf, self.spawner)) {
        trigger.var_9f9f230946bd8faf = array_remove(trigger.var_9f9f230946bd8faf, self.spawner);
      }
    }
  }

  var_89f2489a97a98d30 = namespace_1fdb557af4bcd29e::function_56a6214ab214d8b1();

  if(isarray(var_89f2489a97a98d30) && var_89f2489a97a98d30.size > 0) {
    foreach(trig in var_89f2489a97a98d30) {
      trig notify("spawning_request");
    }
  }
}

function function_985d2edf83e8270e(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;

  if(isagent(ent)) {
    if(!isDefined(ent.spawner)) {
      iprintlnbold("^3 Ent -> ^1" + ent getentitynumber() + "^3 did not have .spawner variable Defined! (onExitaiRegionTrigger)");

      print3d(ent.origin + (0, 0, 50), "<dev string:x1c>" + ent getentitynumber() + "<dev string:xef>", (1, 1, 1), 1, 1, 666);
      line(ent.origin, ent.origin + (0, 0, 1000), (0.4, 0.3, 0), 1, 0, 666);

      ent hudoutlineenable("outline_cp_teleport_debug");
    }

    if(isDefined(ent.spawner)) {
      if(array_contains(trigger.var_9f9f230946bd8faf, ent.spawner)) {
        trigger.var_9f9f230946bd8faf = array_remove(trigger.var_9f9f230946bd8faf, ent.spawner);
      }
    }
  }

  if(isDefined(ent.airegion)) {
    function_9648a478f198a621(ent);
  }

  ent notify("clean_up_exit_threads");

  if(isDefined(ent.var_ceb9d44b40906c4a)) {
    ent.var_ceb9d44b40906c4a = array_remove(ent.var_ceb9d44b40906c4a, trigger);

    if(ent.var_ceb9d44b40906c4a.size == 0) {
      ent.var_ceb9d44b40906c4a = undefined;
    }
  }
}

function watchairegionsuppressiontrigger(trigger) {
  trigger notify("watchaiRegionSuppressionTrigger");
  trigger endon("watchaiRegionSuppressionTrigger");
  trigger.entstouching = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  thread watchairegionsuppressiontriggerexit(trigger);
  thread watchairegionsupressiontriggerenter(trigger);
}

function watchairegionsupressiontriggerenter(trigger) {
  level endon("game_ended");
  trigger notify("watchaiRegionSupressionTriggerEnter");
  trigger endon("watchaiRegionSupressionTriggerEnter");

  while(true) {
    trigger waittill("trigger", ent);

    if(!function_693b7e3703225a8b(ent)) {
      continue;
    }

    function_77576856c3a8fff5(trigger, ent);
  }
}

function watchairegionsuppressiontriggerexit(trigger) {
  level endon("game_ended");
  trigger notify("watchaiRegionSuppressionTriggerExit");
  trigger endon("watchaiRegionSuppressionTriggerExit");

  while(true) {
    temparr = trigger.entstouching;

    if(isDefined(temparr)) {
      foreach(ent in temparr) {
        if(!isDefined(ent)) {
          trigger.entstouching[id] = undefined;
        }

        if(isDefined(ent) && !trigger istouching(ent)) {
          function_37227d6593dcc483(trigger, ent);
        }
      }
    }

    waitframe();
  }
}

function function_77576856c3a8fff5(trigger, ent) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }

  trigger.entstouching[entnum] = ent;

  if(!isDefined(ent.var_2ba26fbb56cce6b5)) {
    ent.var_2ba26fbb56cce6b5 = [];
  }

  temparr = [trigger];

  foreach(airegionsuppressiontrigger in ent.var_2ba26fbb56cce6b5) {
    temparr[temparr.size] = airegionsuppressiontrigger;
  }

  ent.var_2ba26fbb56cce6b5 = temparr;
  function_de8fd4597c7de8c6(ent);
}

function function_37227d6593dcc483(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  ent.var_2ba26fbb56cce6b5[trigger getentitynumber()] = undefined;

  if(ent.var_2ba26fbb56cce6b5.size == 0) {
    ent.var_2ba26fbb56cce6b5 = undefined;
  }

  function_bbd1d29bb00c640b(ent);
}

function function_84f2d42d2d646239(trigger, ent) {
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

function function_693b7e3703225a8b(ent) {
  if(isDefined(ent)) {
    if(isPlayer(ent) || isagent(ent)) {
      if(ent scripts\cp_mp\utility\player_utility::_isalive()) {
        return true;
      }
    }

    if(isDefined(ent.var_5a3a4c78b256fd0c)) {
      if(ent scripts\cp_mp\vehicles\vehicle::isvehicle()) {
        if(!istrue(ent.isdestroyed)) {
          return true;
        }
      }

      if(isDefined(ent.streakinfo) && function_51bbce44958b49f0(ent.streakinfo.streakname)) {
        return true;
      }
    }
  }

  return false;
}

function function_ee4ce9c0d26a5865() {
  struct = level.var_332fb47555f99f3b;

  if(!isDefined(struct)) {
    struct = spawnStruct();
    struct.entercallbacks = [];
    struct.exitcallbacks = [];
    struct.outoftimecallbacks = [];
    struct.clearcallbacks = [];
    level.var_332fb47555f99f3b = struct;
  }

  return struct;
}

function function_51bbce44958b49f0(streakname) {
  var_43265c6bad4d9e1e = 0;

  switch (streakname) {
    case #"hash_cf0ef5bef19a311b":
    case #"hash_e40585107590f016":
      var_43265c6bad4d9e1e = 1;
      break;
  }

  return var_43265c6bad4d9e1e;
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
      return function_661d1b3cc3d5a2e4(triggertype);
  }

  return undefined;
}

function function_661d1b3cc3d5a2e4(triggertype) {
  switch (triggertype) {
    case #"hash_18ad1d5da2e56d4c":
    case #"hash_6b15362474c2e2b2":
    case #"hash_7038dec66d8275be":
    case #"hash_fa21c4f6bd5e3815":
      return function_8dd63b9a4a182f0c();
  }

  return undefined;
}

function function_8dd63b9a4a182f0c() {
  return max(0, getdvarfloat(@ "hash_d7e4068edfedb9d4", 3));

  var_37dc2f766a2fa2a = level.var_37dc2f766a2fa2a;

  if(!isDefined(var_37dc2f766a2fa2a)) {
    var_37dc2f766a2fa2a = max(0, getdvarfloat(@ "hash_d7e4068edfedb9d4", 3));
    level.var_37dc2f766a2fa2a = var_37dc2f766a2fa2a;
  }

  return var_37dc2f766a2fa2a;
}

function function_f4e12eccaefc243(ent) {
  if(isDefined(ent.var_ceb9d44b40906c4a)) {
    return ent.var_ceb9d44b40906c4a[0];
  }

  return undefined;
}

function previouslytouchedtriggertype(var_7edface381884ca9, currenttriggertype) {
  var_1b99bb6cc4aec0fe = 0;

  if(isDefined(var_7edface381884ca9.var_3392ef5b6b742ad5)) {
    previoustriggertype = var_7edface381884ca9.var_3392ef5b6b742ad5;

    if(currenttriggertype == previoustriggertype) {
      var_1b99bb6cc4aec0fe = 1;
    } else if((currenttriggertype == "default" || currenttriggertype == "minefield") && (previoustriggertype == "default" || previoustriggertype == "minefield")) {
      var_1b99bb6cc4aec0fe = 1;
    }
  }

  return var_1b99bb6cc4aec0fe;
}

function function_86afcfb8eb7bf0d2(trigger) {
  self.script_suspend_group = trigger.script_noteworthy;

  if(isDefined(self.spawner)) {
    self.spawner.script_suspend_group = trigger.script_noteworthy;
  }
}

function function_d55ed59c0ce164d3() {
  self.script_suspend_group = undefined;

  if(isDefined(self.spawner)) {
    self.spawner.script_suspend_group = undefined;
  }
}

function watchairegiontriggerrequests(trigger) {
  level endon("game_ended");
  trigger notify("watchaiRegionTriggerRequests");
  trigger endon("watchaiRegionTriggerRequests");

  while(true) {
    trigger waittill("spawning_request", var_d97be0fb72fca8a9);

    if(!function_5e1050e3208c8c06()) {
      continue;
    }

    level notify("global_spawning_request", trigger, var_d97be0fb72fca8a9);
  }
}

function function_1a3fb64b55b6e6ee() {
  level endon("game_ended");

  while(true) {
    level waittill("global_spawning_request", airegiontrigger, var_d97be0fb72fca8a9);

    if(!isDefined(airegiontrigger)) {
      assertex(isDefined(airegiontrigger), "A Valid AI Region Trigger Entity MUST be passed in");

      if(!isDefined(airegiontrigger)) {
        continue;
      }
    }

    var_854a7e665d4adab2 = [];
    deleted_ai = 0;
    var_fedb346f9b68ce66 = [];
    var_89f2489a97a98d30 = namespace_1fdb557af4bcd29e::function_56a6214ab214d8b1(airegiontrigger);

    if(isarray(var_89f2489a97a98d30) && var_89f2489a97a98d30.size > 0) {
      foreach(trigger in var_89f2489a97a98d30) {
        var_fedb346f9b68ce66 = array_combine(var_fedb346f9b68ce66, trigger.var_9f9f230946bd8faf);
      }
    }

    requested_count = function_fee22980f1be9191(airegiontrigger);

    if(isDefined(var_d97be0fb72fca8a9) && isint(var_d97be0fb72fca8a9)) {
      requested_count = var_d97be0fb72fca8a9;
    }

    var_673d056f46675a63 = ter_op(scripts\cp\spawning::get_max_agent_count() < getaiarray("axis").size + requested_count, 1, 0);

    if(function_34be418b2813a498()) {
      iprintlnbold("<dev string:x133>" + var_673d056f46675a63 + "<dev string:x154>" + requested_count + "<dev string:x179>" + getaiarray("<dev string:x1a9>").size);
    }

    if(!var_673d056f46675a63) {
      function_98d19cc13a08f9e1(airegiontrigger, requested_count);
      continue;
    }

    function_5f974f12d8b7cb29(airegiontrigger, var_fedb346f9b68ce66);
    function_98d19cc13a08f9e1(airegiontrigger, requested_count);
  }
}

function function_5f974f12d8b7cb29(var_fd11088f77720495, var_fedb346f9b68ce66) {
  deleted_ai = 0;
  var_854a7e665d4adab2 = function_f4117c23b5c99c0b(var_fd11088f77720495);

  foreach(ai in getaiarray("axis")) {
    if(isDefined(ai.spawner) && array_contains(var_fd11088f77720495.var_9f9f230946bd8faf, ai.spawner)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x1c>" + ai getentitynumber() + "<dev string:x1ae>");
        print3d(ai.origin + (0, 0, 50), "<dev string:x1c>" + ai getentitynumber() + "<dev string:x1ae>", (1, 0, 1), 1, 1, 666);
      }

      continue;
    }

    if(isDefined(ai.spawner) && array_contains(var_fedb346f9b68ce66, ai.spawner)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x20f>" + ai getentitynumber() + "<dev string:x21c>");
        print3d(ai.origin + (0, 0, 50), "<dev string:x20f>" + ai getentitynumber() + "<dev string:x263>", (1, 0, 1), 1, 1, 666);
      }

      continue;
    }

    if(ai scripts\anim\utility::hasenemysightpos()) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x1c>" + ai getentitynumber() + "<dev string:x2ab>");
        print3d(ai.origin + (0, 0, 50), "<dev string:x1c>" + ai getentitynumber() + "<dev string:x2ab>", (1, 0, 1), 1, 1, 666);
      }

      continue;
    }

    if(ai scripts\anim\utility_common::recentlysawenemy()) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x2e2>" + ai getentitynumber() + "<dev string:x2ef>");
        print3d(ai.origin + (0, 0, 50), "<dev string:x2e2>" + ai getentitynumber() + "<dev string:x2ef>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    if(check_player_proximity(ai.origin)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x325>");
        print3d(ai.origin + (0, 0, 50), "<dev string:x325>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    if(ai function_14f781e51502cc47()) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x37f>" + ai getentitynumber() + "<dev string:x38c>");
        print3d(ai.origin + (0, 0, 50), "<dev string:x37f>" + ai getentitynumber() + "<dev string:x38c>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    if(!ai scripts\cp\spawning::killoff_vis_passed()) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x37f>" + ai getentitynumber() + "<dev string:x3cd>");
        print3d(ai.origin + (0, 0, 50), "<dev string:x37f>" + ai getentitynumber() + "<dev string:x3cd>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    if(function_70328e9769b9750f(ai.origin)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x37f>" + ai getentitynumber() + "<dev string:x406>");
        print3d(ai.origin + (0, 0, 50), "<dev string:x43e>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    if(function_70328e9769b9750f(ai.origin + (0, 0, 50))) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x37f>" + ai getentitynumber() + "<dev string:x486>");
        print3d(ai.origin + (0, 0, 50), "<dev string:x4cc>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    if(function_34be418b2813a498()) {
      iprintlnbold("<dev string:x37f>" + ai getentitynumber() + "<dev string:x523>");
      print3d(ai.origin, "<dev string:x54a>", (0, 1, 1), 1, 1, 666);
      [[level.func["<dev string:x68>"]]](ai.origin, ai.angles, (1, 0, 0));
    }

    if(isDefined(ai.script_suspend)) {
      deleted_ai = function_7bd38c394517ff87(ai, var_fd11088f77720495, deleted_ai);
      continue;
    }

    deleted_ai = function_4cbe4ba6bc116f99(ai, var_fd11088f77720495, deleted_ai);
  }

  if(function_34be418b2813a498()) {
    iprintln("<dev string:x567>" + deleted_ai);
  }
}

function function_98d19cc13a08f9e1(airegiontrigger, var_cc45c3ac6ec69fec) {
  level endon("game_ended");
  c = 0;
  var_854a7e665d4adab2 = function_f4117c23b5c99c0b(airegiontrigger);

  foreach(spawner_struct in airegiontrigger.var_9f9f230946bd8faf) {
    if(c > var_cc45c3ac6ec69fec) {
      break;
    }

    if(array_contains(var_854a7e665d4adab2, spawner_struct)) {
      continue;
    }

    var_a9237f88bd342861 = function_4b44dce2ffdbcc48(spawner_struct);
    var_5e8b303608f19b8c = var_a9237f88bd342861 + (0, 0, 50);

    if(getdvarint(@ "hash_5f7c7350754fbff0", 0) != 0) {
      var_a9237f88bd342861 = var_5e8b303608f19b8c;
    }

    if(check_player_proximity(var_a9237f88bd342861)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x59c>");
        print3d(var_a9237f88bd342861 + (0, 0, 50), "<dev string:x5f2>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    if(function_d43bb847cab4433f(var_a9237f88bd342861)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x64d>");
        print3d(var_a9237f88bd342861 + (0, 0, 50), "<dev string:x64d>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    if(function_70328e9769b9750f(var_a9237f88bd342861)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x43e>");
        print3d(var_a9237f88bd342861 + (0, 0, 50), "<dev string:x43e>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    if(function_70328e9769b9750f(var_a9237f88bd342861 + (0, 0, 50))) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x6a9>");
        print3d(var_a9237f88bd342861 + (0, 0, 50), "<dev string:x6ff>", (0, 1, 1), 1, 1, 2500);
      }

      continue;
    }

    var_11879c5af01a1cde = ter_op(isDefined(level.var_e9363e4bb08955e4), level.var_e9363e4bb08955e4, "region_spawning_test");
    module_struct = scripts\cp\spawning::create_module_struct(var_11879c5af01a1cde);
    scripts\cp\cp_spawning_util::set_recent_spawn_time_threshold_override(module_struct, 1000);
    spawn_point = module_struct scripts\cp\spawner_scoring::score_ai_spawns([spawner_struct]);
    module_struct.position_ref = undefined;
    module_struct scripts\cp\spawner_scoring::print_spawner_score_for_factor(spawn_point);

    if(!isDefined(spawn_point)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x754>");
        print3d(var_a9237f88bd342861 + (0, 0, 50), "<dev string:x78e>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    spawn_soldier(module_struct, spawner_struct);
    c++;
  }

  if(c > 0) {
    if(function_34be418b2813a498()) {
      iprintln("<dev string:x7c9>" + var_cc45c3ac6ec69fec + "<dev string:x7e5>" + c);
    }
  }
}

function function_f4117c23b5c99c0b(airegiontrigger) {
  var_854a7e665d4adab2 = [];

  foreach(ai in getaiarray("axis")) {
    if(isDefined(ai.spawner) && array_contains(airegiontrigger.var_9f9f230946bd8faf, ai.spawner)) {
      var_854a7e665d4adab2 = array_add(var_854a7e665d4adab2, ai.spawner);
    }
  }

  return var_854a7e665d4adab2;
}

function function_fee22980f1be9191(airegiontrigger, var_fedb346f9b68ce66) {
  var_fd1227d9f622aaa4 = 0;
  var_854a7e665d4adab2 = function_f4117c23b5c99c0b(airegiontrigger);

  foreach(spawner_struct in airegiontrigger.var_9f9f230946bd8faf) {
    if(array_contains(var_854a7e665d4adab2, spawner_struct)) {
      continue;
    }

    var_a9237f88bd342861 = function_4b44dce2ffdbcc48(spawner_struct);

    if(check_player_proximity(var_a9237f88bd342861)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x59c>");
        print3d(var_a9237f88bd342861 + (0, 0, 50), "<dev string:x5f2>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    if(function_d43bb847cab4433f(var_a9237f88bd342861)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x64d>");
        print3d(var_a9237f88bd342861 + (0, 0, 50), "<dev string:x64d>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    if(function_70328e9769b9750f(var_a9237f88bd342861)) {
      if(function_34be418b2813a498()) {
        iprintlnbold("<dev string:x43e>");
        print3d(var_a9237f88bd342861 + (0, 0, 50), "<dev string:x43e>", (0, 1, 1), 1, 1, 666);
      }

      continue;
    }

    var_fd1227d9f622aaa4++;
  }

  if(var_fd1227d9f622aaa4 > 0) {
    if(function_34be418b2813a498()) {
      iprintln("<dev string:x807>" + var_fd1227d9f622aaa4);
    }
  }

  return var_fd1227d9f622aaa4;
}

function function_4b44dce2ffdbcc48(spawner) {
  if(isDefined(spawner.suspended_ai)) {
    return spawner.suspended_ai.origin;
  }

  return spawner.origin;
}

function function_56a6214ab214d8b1(var_2fc2f07166ae0e33) {
  active_triggers = [];

  foreach(trigger in level.var_ceb9d44b40906c4a) {
    if(isDefined(var_2fc2f07166ae0e33) && isent(var_2fc2f07166ae0e33)) {
      continue;
    }

    if(isDefined(trigger.entstouching) && isarray(trigger.entstouching)) {
      if(function_5969df6a64608c4b(trigger)) {
        active_triggers = array_add(active_triggers, trigger);
      }
    }
  }

  return active_triggers;
}

function function_5969df6a64608c4b(trigger) {
  if(isDefined(trigger.entstouching) && isarray(trigger.entstouching)) {
    foreach(ent in trigger.entstouching) {
      if(isPlayer(ent)) {
        return true;
      }
    }
  }

  return false;
}

function function_14f781e51502cc47() {
  foreach(player in level.players) {
    if(self seerecently(player, 5)) {
      return true;
    }
  }

  return false;
}

function check_player_proximity(spawner_origin) {
  foreach(player in level.players) {
    if(distancesquared(player.origin, spawner_origin) < 2250000) {
      if(namespace_1fdb557af4bcd29e::function_70328e9769b9750f(spawner_origin)) {
        return true;
      }

      continue;
    }

    if(namespace_1fdb557af4bcd29e::function_70328e9769b9750f(spawner_origin)) {
      return true;
    }
  }

  return false;
}

function function_d43bb847cab4433f(spawner_origin) {
  foreach(player in level.players) {
    if(player hastacvis(spawner_origin, 0, 64, 1)) {
      return true;
    }
  }

  return false;
}

function function_70328e9769b9750f(spawner_origin) {
  contents = scripts\engine\trace::create_contents(1, 1, 1, 1, 1, 1, 1, 1, 1);

  foreach(player in level.players) {
    if(scripts\engine\trace::ray_trace_passed(player getEye(), spawner_origin, [player], contents)) {
      if(player within_fov(player getEye(), player getplayerangles(), spawner_origin, cos(120))) {
        return true;
      }

      return false;
    }
  }

  return false;
}

function function_5e1050e3208c8c06() {
  return getdvarint(@ "hash_9804c42649d377c6", 0) == 1;
}

function function_34be418b2813a498() {
  return getdvarint(@ "hash_91f8d0a94101ee4", 0) == 1;
}

function function_bac68a34c968c639(spawner, trigger) {
  if(!isDefined(trigger.var_9f9f230946bd8faf)) {
    trigger.var_9f9f230946bd8faf = [];
  }

  if(!array_contains(trigger.var_9f9f230946bd8faf, spawner)) {
    trigger.var_9f9f230946bd8faf = array_add(trigger.var_9f9f230946bd8faf, spawner);

    if(function_34be418b2813a498()) {
      [[level.func["<dev string:x68>"]]](spawner.origin, spawner.angles, (0, 1, 0));
    }
  } else {
    if(function_34be418b2813a498()) {
      iprintlnbold("<dev string:x824>");
      [[level.func["<dev string:x68>"]]](spawner.origin, spawner.angles, (0.5, 1, 0.5));
    }
  }

  return trigger;
}

function function_6b44ee764600d649() {
  self.script_suspend = 1;
}

function prespawn_suspended_ai() {
  if(!isDefined(self.script_suspend)) {
    return undefined;
  }

  if(!isDefined(self.suspended_ai)) {
    return 0;
  }

  self.count++;

  if(!isDefined(self.og_spawner_origin)) {
    self.og_spawner_origin = self.origin;
  }

  if(!isDefined(self.og_spawner_angles)) {
    self.og_spawner_angles = self.angles;
  }

  if(isDefined(self.try_og_origin)) {
    self.origin = self.og_spawner_origin;
    self.angles = self.og_spawner_angles;
  } else {
    self.origin = self.suspended_ai.origin;
    self.angles = self.suspended_ai.angles;
  }

  if(isDefined(self.suspended_ai.suspendvars)) {
    self.suspendvars = self.suspended_ai.suspendvars;
  }

  return 1;
}

function postspawn_suspended_ai() {
  suspendstruct = self.spawner.suspended_ai;

  if(isDefined(self.spawner.postspawnresetorigin)) {
    self.spawner.origin = self.og_spawner_origin;
    self.spawner.angles = self.og_spawner_angles;
  }

  thread postspawn_suspend_ai_framedelay(suspendstruct);

  if(!isDefined(suspendstruct.suspendvars)) {
    return;
  }

  self.suspendvars = suspendstruct.suspendvars;
  self.spawner.suspended_ai = undefined;
}

function postspawn_suspend_ai_framedelay(suspendstruct) {
  waittillframeend();
  waittillframeend();

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(suspendstruct.stealth)) {
    assertex(self.team == "axis", "postspawn_suspended_ai() currently does not support non AXIS AI");
    bsmstate = suspendstruct.stealth.bsmstate;

    if(bsmstate > 1) {
      bsmstate = suspendstruct.stealth.bsmstate - int((gettime() - suspendstruct.suspendtime) / 10000);
      bsmstate = int(max(2, bsmstate));
    } else if(bsmstate > 0) {
      bsmstate = suspendstruct.stealth.bsmstate - int((gettime() - suspendstruct.suspendtime) / 5000);
      bsmstate = int(max(0, bsmstate));
    }

    state = int_to_stealth_state(bsmstate);
    scripts\stealth\enemy::bt_set_stealth_state(state, suspendstruct.stealth.investigateevent);
  }
}

function int_to_stealth_state(num) {
  switch (num) {
    case 0:
      return "idle";
    case 1:
      return "investigate";
    case 2:
      return "hunt";
    case 3:
      return "combat";
  }
}

function function_7bd38c394517ff87(ai, trigger, deleted_ai) {
  return ai free_expendable(deleted_ai);
}

function function_4cbe4ba6bc116f99(ai, trigger, deleted_ai) {
  ai kill();
  deleted_ai++;
  return deleted_ai;
}

function free_expendable(deleted_ai) {
  if(!isDefined(self.spawner) || !isDefined(self.script_suspend)) {
    return deleted_ai;
  }

  spawner = self.spawner;
  struct = spawnStruct();
  struct.origin = self.origin;
  struct.angles = self.angles;
  struct.suspendtime = gettime();

  if(isDefined(self.suspendvars)) {
    struct.suspendvars = self.suspendvars;
  } else {
    struct.suspendvars = spawnStruct();
  }

  if(isDefined(self.stealth)) {
    struct.stealth = spawnStruct();
    struct.stealth_enabled = 1;
    struct.stealth.bsmstate = self.stealth_bsmstate;
    struct.stealth.investigateevent = scripts\aitypes\stealth::function_9c4a08f7dcd2796b();
  }

  if(isDefined(self.node)) {
    if(isDefined(self.using_goto_node)) {
      if(isDefined(self.node.targetname)) {
        struct.target = self.node.targetname;
      }

      struct.node = self.node;
    }

    struct.target = self.node.targetname;
  }

  spawner.suspended_ai = struct;

  if(isDefined(self.script_suspend_group) && !isDefined(self.script_free)) {
    deleted_ai = free_groupname(self.script_suspend_group, deleted_ai);
  }

  spawner thread function_1ef621491ffaeede();

  return deleted_ai;
}

function free_groupname(groupname, deleted_ai) {
  if(!isDefined(level.processfreegroupname)) {
    level.processfreegroupname = [];
  }

  if(isDefined(level.processfreegroupname[groupname])) {
    return deleted_ai;
  }

  level.processfreegroupname[groupname] = 1;
  aiarray = getaiarray("axis");

  if(function_34be418b2813a498()) {
    println("<dev string:x870>" + groupname);
    iprintlnbold("^2groupname Processing - ^1" + groupname);
  }

  foreach(ai in aiarray) {
    if(!isDefined(ai.script_suspend_group)) {
      if(function_34be418b2813a498()) {
        println("<dev string:x88c>" + groupname + "<dev string:x8ae>");
        iprintlnbold("^2skipped Group Processing for ^1" + groupname + "^2 due to ^1 NO .script_suspend_group ^2var defined");

        line(ai.origin, ai.origin + (0, 0, 1000), (0, 1, 0), 1, 0, 666);
      }

      continue;
    }

    if(ai.script_suspend_group != groupname) {
      if(function_34be418b2813a498()) {
        println("<dev string:x88c>" + groupname);

        if(isDefined(ai.script_suspend)) {
          println("<dev string:x8e2>" + ai.script_suspend_group + "<dev string:x907>" + ai.script_suspend);
        } else {
          println("<dev string:x8e2>" + ai.script_suspend_group + "<dev string:x91d>");
        }

        if(isDefined(ai.script_suspend)) {
          iprintlnbold("^5ai vars:script_suspend_group: ^1" + ai.script_suspend_group + "^5 script_suspend: ^1" + ai.script_suspend);
        } else {
          iprintlnbold("^5ai vars:script_suspend_group: ^1" + ai.script_suspend_group + "^5 script_suspend: NOT DEFINED");
        }

        line(ai.origin, ai.origin + (0, 0, 1000), (0, 0, 1), 1, 0, 666);
      }

      continue;
    }

    ai.script_free = 1;
    deleted_ai = ai free_expendable(deleted_ai);

    if(function_34be418b2813a498()) {
      println("<dev string:x93c>" + groupname + "<dev string:x950>" + ai.origin);
      println("<dev string:x8e2>" + ai.script_suspend_group + "<dev string:x907>" + ai.script_suspend);

      iprintlnbold("^2free_groupname ^1" + groupname + "^2 origin: ^1" + ai.origin);
      iprintlnbold("^5ai vars:script_suspend_group: ^1" + ai.script_suspend_group + "^5 script_suspend: ^1" + ai.script_suspend);

      line(ai.origin, ai.origin + (0, 0, 1000), (1, 0, 0), 1, 0, 666);
    }

    ai.nocorpse = 1;
    function_983add621b34ed28(ai, 1);
    ai kill();
    deleted_ai++;
  }

  level.processfreegroupname[groupname] = undefined;
  return deleted_ai;
}

function function_1ef621491ffaeede(spawner) {
  self endon("<dev string:x95e>");

  if(!isDefined(level.func)) {
    return;
  }

  if(!isDefined(level.func["<dev string:x68>"])) {
    return;
  }

  while(true) {
    waitframe();

    if(!isDefined(self.suspended_ai)) {
      return;
    }

    if(getdvarint(@ "hash_91f8d0a94101ee4", 0) == 0) {
      continue;
    }

    [[level.func["<dev string:x68>"]]](self.suspended_ai.origin, self.suspended_ai.angles, (1, 0.5, 0.25));
  }
}

function stealth_event_propagator() {
  level notify("stealth_event_propagator");
  level endon("stealth_event_propagator");
  flag_wait("stealth_enabled");
  level endon("stealth_enabled");
  event_dists["gunshot"] = geteventdefaultdistance("gunshot");
  event_dists["gunshot_teammate"] = geteventdefaultdistance("gunshot_teammate");
  event_dists["explosion"] = geteventdefaultdistance("explosion");
  event_dists["glass_destroyed"] = geteventdefaultdistance("glass_destroyed");
  event_dists["light_killed"] = 800;
  event_dists["bulletwhizby"] = 3000;
  spawners = [];

  foreach(area in level.var_ceb9d44b40906c4a) {
    if(isDefined(area.var_9f9f230946bd8faf)) {
      foreach(spawner in area.var_9f9f230946bd8faf) {
        if(!isDefined(spawner)) {
          continue;
        }

        if(is_equal(spawner.script_noteworthy, "interrogator")) {
          continue;
        }

        if(is_equal(spawner.script_noteworthy, "escalation_patroller")) {
          continue;
        }

        if(isendstr(spawner.targetname, "ambush_spawner")) {
          continue;
        }

        if(is_equal(spawner.script_noteworthy, "extra_patrol")) {
          spawner.dont_propagate_events_prespawn = 1;
        }

        if(isendstr(spawner.targetname, "backup_spawner")) {
          spawner.dont_propagate_events_prespawn = 1;
        }

        spawners[spawners.size] = spawner;
      }
    }
  }

  event_cache = [];
  var_81e55cd489351a8e = -10000;

  while(true) {
    level waittill("stealth_event", event, receiver);

    if(!array_contains_key(event_dists, event.typeorig)) {
      continue;
    }

    if(time_has_passed(var_81e55cd489351a8e, 10)) {
      event_cache = [];
    } else {
      duplicate = 0;

      foreach(e in event_cache) {
        if(e.typeorig == event.typeorig && e.origin == event.origin) {
          duplicate = 1;
          break;
        }
      }

      if(duplicate) {
        if(getdvarint(@ "hash_91f8d0a94101ee4")) {
          iprintlnbold("<dev string:x964>" + event.typeorig + "<dev string:x97a>" + receiver getentitynumber() + "<dev string:x98a>");
        }

        continue;
      }
    }

    event_cache[event_cache.size] = event;
    var_81e55cd489351a8e = gettime();
    event_copy = spawnStruct();
    event_copy.typeorig = event.typeorig;
    event_copy.entity = event.entity;
    event_copy.origin = event.origin;
    event_copy.receiver = event.receiver;
    event_copy.type = scripts\stealth\event::event_severity_get(event.typeorig);
    event_copy.investigate_pos = event.investigate_pos;
    spawners = array_removeundefined(spawners);
    spawners = sortbydistance(spawners, event.origin);
    childthread propagate_event_thread(event_copy, event_dists, spawners);
  }
}

function propagate_event_thread(event, event_dists, spawners) {
  foreach(spawner in spawners) {
    if(!isDefined(spawner)) {
      continue;
    }

    if(distancesquared(spawner.origin, event.origin) > event_dists[event.typeorig] * event_dists[event.typeorig]) {
      break;
    }

    if(is_equal(spawner.script_noteworthy, "lone_patroller") && flag(spawner.script_stealthgroup + "_spawned")) {
      continue;
    }

    if(!isDefined(spawner.suspended_ai)) {
      if(istrue(spawner.dont_propagate_events_prespawn)) {
        continue;
      }
    }

    if(event.typeorig == "light_killed" && distancesquared(spawner.origin, event.origin) > 160000) {
      waitframe();

      if(!isDefined(spawner)) {
        continue;
      }

      if(!sighttracepassed(spawner.origin + (0, 0, 60), event.origin, 0, event.entity)) {
        continue;
      }
    }

    guy = undefined;

    if(isDefined(guy)) {
      if(getdvarint(@ "hash_91f8d0a94101ee4")) {
        iprintlnbold("<dev string:x98d>" + guy getentitynumber() + "<dev string:x993>" + event.typeorig + "<dev string:x98a>");
      }

      guy aieventlistenerevent(event.typeorig, event.entity, event.origin);
      continue;
    }

    if(isDefined(spawner.suspended_ai)) {
      if(getdvarint(@ "hash_91f8d0a94101ee4")) {
        iprintlnbold("<dev string:x9a7>" + spawner.origin + "<dev string:x9d1>" + event.typeorig + "<dev string:x98a>");
      }

      if(event.type == "combat") {
        spawner.suspended_ai.stealth.bsmstate = 3;
      } else {
        spawner.suspended_ai.stealth.bsmstate = max(1, spawner.suspended_ai.stealth.bsmstate);
        spawner.suspended_ai scripts\aitypes\stealth::function_6bdcfa57946930c7(event);
      }

      continue;
    }

    if(getdvarint(@ "hash_91f8d0a94101ee4")) {
      iprintlnbold("<dev string:x9dd>" + spawner.origin + "<dev string:x9d1>" + event.typeorig + "<dev string:x98a>");
    }

    struct = spawnStruct();
    struct.origin = spawner.origin;
    struct.angles = spawner.angles;
    struct.suspendtime = gettime();
    struct.stealth = spawnStruct();
    struct.stealth_enabled = 1;

    if(event.type == "combat") {
      struct.stealth.bsmstate = 3;
    } else {
      struct.stealth.bsmstate = 1;
      struct.stealth.investigateevent = event;
    }

    struct.suspendvars = spawnStruct();
    spawner.suspended_ai = struct;
    spawner.count = 0;
  }
}

function spawn_soldier(module_struct, spawnpoint, is_debug, spec_override, spawn_parameter_array, var_3a308e048fa5cec7) {
  spec = undefined;
  spawnpoint_override = undefined;
  angle_override = undefined;
  spec_override = undefined;

  if(isDefined(spawnpoint.pos_override_struct)) {
    spawnpoint_override = spawnpoint.pos_override_struct.origin;
    angle_override = spawnpoint.pos_override_struct.angles;
  } else if(isDefined(spawnpoint.vehicle_position)) {
    spawnpoint_override = spawnpoint.origin;
    angle_override = spawnpoint.angles;
  }

  if(isDefined(spawnpoint.specs)) {
    if(!isarray(spawnpoint.specs)) {
      spawnpoint.specs = [spawnpoint.specs];
    }

    spec_override = random(spawnpoint.specs);
    spec = spec_override;
  }

  var_7208fc96ea182f6 = 0;

  if(!isDefined(spawnpoint.count)) {
    spawnpoint.count = 1;
  }

  if(isDefined(spawnpoint.script_suspend)) {
    var_7208fc96ea182f6 = spawnpoint namespace_1fdb557af4bcd29e::prespawn_suspended_ai();

    if(spawnpoint.count == 0 && !var_7208fc96ea182f6) {
      return undefined;
    }
  }

  soldier = spawnpoint scripts\cp\spawning::spawn_ai(spawnpoint_override, angle_override, spec_override, module_struct);

  if(isDefined(soldier)) {
    soldier.suspended_ai = spawnpoint.suspended_ai;
    soldier.script_suspend = spawnpoint.script_suspend;
    soldier.script_suspend_group = spawnpoint.script_suspend_group;
    soldier.spawner = spawnpoint;
    spawnpoint notify("spawn_success", spawnpoint);
    level notify("spawned_group_soldier", soldier);
    level notify("ai_spawn_successful", soldier, spawnpoint, spawnpoint.origin, module_struct);
    return scripts\cp\spawning::run_ai_post_spawn_init(module_struct, soldier, spawnpoint, spawn_parameter_array, spec, is_debug, var_3a308e048fa5cec7);
  }
}

function function_192f8a34d0ae130f(ai_array, leaders) {
  if(!isDefined(level.squad_leader)) {
    level.squad_leader = [];
  }

  leader = random(ai_array);

  if(getdvarint(@ "squad_debug", 0) > 0) {
    leader hudoutlineenable("<dev string:xa07>");
  }

  if(isDefined(leaders)) {
    if(isarray(leaders)) {
      leader = random(leaders);
    } else {
      leader = leaders;
    }
  }

  level.squad_leader[leader.enemy_group] = leader;

  while(true) {
    alive = 0;

    foreach(ai in ai_array) {
      if(!isalive(ai) || ai.health < 1) {
        continue;
      }

      alive = 1;
    }

    if(!alive) {
      return;
    }

    if(isDefined(leader) && isalive(leader)) {
      foreach(ai in ai_array) {
        if(!isDefined(ai)) {
          continue;
        }

        if(ai == leader) {
          continue;
        }

        if(!isalive(ai) || ai.health < 1) {
          continue;
        }

        if(!isDefined(ai.goalent) || ai.goalent != leader) {
          if(getDvar(@ "squad_debug") != "") {
            ai hudoutlineenable("outline_nodepth_white");
          }

          ai setgoalentity(leader);
          ai.goalent = leader;
        }

        var_4666c0e35742bc07 = 0;

        foreach(player in level.players) {
          if(distance2dsquared(leader.origin, player.origin) < squared(leader.goalradius)) {
            var_4666c0e35742bc07 = 1;
          }
        }

        if(var_4666c0e35742bc07 || distance2dsquared(leader.origin, ai.origin) < squared(ai.goalradius)) {
          if(distance2dsquared(leader.origin, ai.origin) < squared(ai.goalradius)) {
            ai setcoverselectionfocusent(leader);
          }
        }
      }
    } else {
      ai_array = array_removeundefined(ai_array);

      if(ai_array.size == 0) {
        return;
      }

      leader = random(ai_array);

      if(isDefined(leaders)) {
        alive = 0;

        foreach(guy in leaders) {
          if(!isalive(guy) || guy.health < 1) {
            continue;
          }

          alive = 1;
        }

        if(alive) {
          if(isarray(leaders)) {
            leader = random(leaders);
          } else {
            leader = leaders;
          }

          level.squad_leader[leader.enemy_group] = leader;
        }
      }

      if(getDvar(@ "squad_debug") != "") {
        leader hudoutlineenable("outline_nodepth_green");
      }
    }

    wait 1;
  }
}

function function_9c0fbe62c1b9d660() {
  self endon("death");
  self endon("stop_hunting");
  player = random(level.players);

  while(true) {
    if(!isDefined(player) || istrue(player.inlaststand)) {
      selected = 0;

      foreach(new_player in level.players) {
        if(istrue(new_player.inlaststand)) {
          continue;
        }

        player = new_player;
        selected = 1;
      }

      if(!selected) {
        wait 3;
        player = undefined;
        continue;
      }
    }

    foreach(player_ent in level.players) {
      self getenemyinfo(player_ent);
    }

    org = player.origin;
    self setgoalpos(player.origin);
    wait 3;
  }
}

function function_48ea085692abdacf(module_struct) {
  completed_group = module_struct.group_name;
}