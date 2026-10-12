/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\autosave.gsc
***********************************************/



#using script_575fda2758b0a36e;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\sp\utility_code;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\endmission;
#using scripts\sp\equipment\tripwire;
#using scripts\sp\gameskill;
#using scripts\sp\player;
#using scripts\sp\utility;
#namespace autosave;

function main() {
  if(!add_init_script("autosave", &main)) {
    return;
  }

  setdvarifuninitialized(@ "hash_6af159684591cb79", "0");

  if(getprojectname() == "T10") {
    setdvarifuninitialized(@ "hash_1fbf179e197540f3", "0");
  } else {
    setdvarifuninitialized(@ "hash_1fbf179e197540f3", "1");
  }

  level.autosave = spawnStruct();
  level.autosave.lastautosavetime = 0;
  flag_init("game_saving");
  flag_init("can_save");
  flag_set("can_save");
  flag_init("disable_autosaves");
  flag_init("ImmediateLevelStartSave");

  if(!isDefined(level.autosave.extra_autosave_checks)) {
    level.autosave.extra_autosave_checks = [];
  }

  level.autosave.proximity_threat_func = &autosave_proximity_threat_func;
  level.autosave.enemydistcheck = 1;

  thread cheat_save();

  beginningoflevelsave();
  startsavedprogression(level.script);
}

function proggressionmismatchpopup(levelname) {
  setomnvar("progression_invalid", 1);
}

function cheat_save() {
  wait 2;
  level.player endon("death");
  setdvarifuninitialized(@ "hash_6e05061c38987036", "0");

  while(true) {
    if(getdvarint(@ "hash_6e05061c38987036") > 0) {
      setDvar(@ "hash_6e05061c38987036", "0");
      autosave_by_name("cheat_save");
      wait 1;
    }

    wait 0.05;
  }
}

function getdescription() {
  return &"AUTOSAVE/AUTOSAVE";
}

function beginningoflevelsave() {
  if(is_trials_level()) {
    return;
  }

  thread immediatelevelstartsave();
  thread beginningoflevelsave_thread();
}

function immediatelevelstartsave() {
  servertime = scripts\sp\endmission::level_settle_time_get(level.script);

  if(!isDefined(servertime)) {
    servertime = 0;
  }

  servertime *= 0.05;
  clienttime = scripts\sp\endmission::client_settle_time_get(level.script);

  if(!isDefined(clienttime)) {
    clienttime = 0;
  }

  clienttime *= 0.001;
  wait clienttime + servertime + 0.15;
  exit = 0;

  if(isDefined(level.credits_active)) {
    autosaveprint("immediateLevelStartSave() Credits are active", 0);
    exit = 1;
  } else if(level.missionfailed) {
    autosaveprint("immediateLevelStartSave() Mission Failed", 0);
    exit = 1;
  } else if(flag("game_saving")) {
    autosaveprint("immediateLevelStartSave() In the middle of another save, aborting", 0);
    exit = 1;
  }

  if(exit) {
    flag_set("ImmediateLevelStartSave");
    return;
  }

  flag_set("game_saving");

  if(!isalive(level.player)) {
    return;
  }

  imagename = "levelshots / autosave / autosave_" + level.script + "immediate_start";
  savegame("immediatelevelstart", &"AUTOSAVE/LEVELSTART", imagename, 1);
  setDvar(@ "hash_228e280524e6d278", "0");
  println("<dev string:x1c>");
  level.player setplayeryolostate(0);
  autosaveprint("immediateLevelStartSave() Saved", 1);
  flag_clear("game_saving");
  flag_set("ImmediateLevelStartSave");
}

function beginningoflevelsave_thread() {
  if(isDefined(level.beginningoflevelsavedelay)) {
    wait level.beginningoflevelsavedelay;
  } else {
    wait 2;
  }

  if(isDefined(level.credits_active)) {
    autosaveprint("beginningOfLevelSave_thread() Credits are active", 0);
    return;
  }

  if(level.missionfailed) {
    autosaveprint("beginningOfLevelSave_thread() Mission failed", 0);
    return;
  }

  if(flag("game_saving")) {
    autosaveprint("beginningOfLevelSave_thread() In the middle of another save, aborting", 0);
    return;
  }

  if(!flag("ImmediateLevelStartSave")) {
    flag_wait("ImmediateLevelStartSave");
    wait 1;
  }

  flag_set("game_saving");
  imagename = "levelshots / autosave / autosave_" + level.script + "start";
  result = waitfortransientloading("beginningOfLevelSave_thread()");

  if(!isDefined(result)) {
    autosaveprint("beginningOfLevelSave_thread() a newer save was called...", 0);
    flag_clear("game_saving");
    return;
  }

  if(!isalive(level.player)) {
    return;
  }

  savegame("levelstart", &"AUTOSAVE/LEVELSTART", imagename, 1);
  setDvar(@ "hash_228e280524e6d278", "0");
  println("<dev string:x38>");
  level.player setplayeryolostate(0);
  autosaveprint("beginningOfLevelSave_thread() beginningOfLevelSave Saved", 1);
  flag_clear("game_saving");
}

function function_e96f7708c1775016(trigger) {
  trigger waittill("trigger");
  autosave_silent();
}

function trigger_autosave_stealth(trigger) {
  trigger waittill("trigger");
  autosave_stealth();
}

function trigger_autosave_tactical(trigger) {
  trigger waittill("trigger");
  autosave_tactical();
}

function trigger_autosave(trigger) {
  thread function_806ee0c06769f6f(trigger);
}

function function_806ee0c06769f6f(trigger) {
  trigger endon("death");
  wait 1;

  if(istrue(trigger.script_repeat)) {
    delay = 30;

    if(isDefined(trigger.script_delay)) {
      delay = trigger.script_delay;
    }

    while(true) {
      function_b55c93a657439f8a(trigger);
      wait delay;
    }

    return;
  }

  function_b55c93a657439f8a(trigger, 1);
}

function function_b55c93a657439f8a(trigger, var_d8ec40ff894a8d81) {
  trigger waittill("trigger", other);
  name = undefined;

  if(isDefined(trigger.script_autosavename)) {
    name = trigger.script_autosavename;
  }

  scripts\engine\sp\utility::autosave_by_name(name);

  if(isDefined(trigger) && istrue(var_d8ec40ff894a8d81)) {
    trigger delete();
  }
}

function autosaveprint(msg, type, saveid) {
  if(!getdvarint(@ "hash_6af159684591cb79") && !getdvarint(@ "hash_1fbf179e197540f3")) {
    return;
  }

  if(!isDefined(type)) {
    type = -1;
  }

  prefix = "^5AUTOSAVE";

  if(isDefined(saveid)) {
    prefix = prefix + "[" + saveid + "]";
  }

  prefix += ":^7 ";

  if(type == 0) {
    msg = prefix + "^1[ FAILED] " + "^7" + msg;
  } else if(type == 1) {
    msg = prefix + "^2[ SUCCEEDED ] " + "^7" + msg;
  } else if(type == 2) {
    msg = prefix + "^7" + msg;
  } else {
    msg = prefix + msg;
  }

  if(type == 0 || type == 1 || type == 2) {
    thread autosave_hudprint(msg);
  }

  if(getdvarint(@ "hash_6af159684591cb79")) {
    iprintln(msg);
    return;
  }

  println(msg);
}

function autosave_hudprint(msg) {
  version = getbuildversion();

  if(version == "SHIP") {
    return;
  }

  if(getdvarint(@ "loc_warningsaserrors")) {
    return;
  }

  if(!getdvarint(@ "hash_1fbf179e197540f3")) {
    return;
  }

  if(!isDefined(level.autosave.fail_huds)) {
    level.autosave.fail_huds = [];
  }

  if(level.autosave.fail_huds.size == 3) {
    oldhud = level.autosave.fail_huds[0];
    level.autosave.fail_huds = array_remove_index(level.autosave.fail_huds, 0);
    autosave_hudfail_update();
    oldhud thread autosave_hudfail_destroy();
  }

  hud = newhudelem();
  hud.elemtype = "font";
  hud.font = "default";
  hud.fontscale = 0.7;
  hud.width = 0;
  hud.height = int(8.4);
  hud.horzalign = "fullscreen";
  hud.vertalign = "fullscreen";
  index = level.autosave.fail_huds.size;
  level.autosave.fail_huds[index] = hud;
  hud.foreground = 1;
  hud.sort = 20;
  hud.x = 130;
  hud.y = 5 + index * 8.4;
  hud.label = msg;
  hud.alpha = 0;
  hud fadeovertime(0.2);
  hud.alpha = 1;
  hud endon("death");
  wait 5;
  level.autosave.fail_huds = array_remove(level.autosave.fail_huds, hud);
  autosave_hudfail_update();
  hud thread autosave_hudfail_destroy();
}

function autosave_hudfail_destroy() {
  scale = 1;
  self endon("death");
  self fadeovertime(0.1);
  self moveovertime(0.1);
  self.y -= 8.4;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

function autosave_hudfail_update() {
  level.autosave.fail_huds = array_removeundefined(level.autosave.fail_huds);

  foreach(hud in level.autosave.fail_huds) {
    hud moveovertime(0.1);
    hud.y = 5 + index * 12 * 0.7;
  }
}

function _autosave_game_now(suppress_print, suppress_notify, var_bc910db033e0a289) {
  if(is_trials_level()) {
    return 0;
  }

  autosaveprint("_autosave_game_now() called...", 2);

  if(gettime() < 3300) {
    autosaveprint("_autosave_game_now() cannot save during before immediatelevelsave and beginningoflevelsave", 0);
    return;
  }

  if(isDefined(level.missionfailed) && level.missionfailed) {
    return 0;
  }

  if(!isDefined(suppress_notify) || !suppress_notify) {
    level notify("trying_new_autosave");
  }

  if(flag("game_saving")) {
    autosaveprint("_autosave_game_now() game_saving in progress, aborting...", 0);
    return 0;
  }

  flag_set("game_saving");
  result = waitfortransientloading("_autosave_game_now()");

  if(!isDefined(result)) {
    autosaveprint("_autosave_game_now() a newer save was called...", 0);
    flag_clear("game_saving");
    return 0;
  }

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(!isalive(player)) {
      return 0;
    }
  }

  filename = "save_now";
  descriptionstring = getdescription();

  if(getdvarint(@ "map_reloading") != 0) {
    autosaveprint("_autosave_game_now() Game is restarting", 0);
    return 0;
  }

  if(isDefined(level.nextmission)) {
    autosaveprint("_autosave_game_now() Game is going to next mission", 0);
    return 0;
  }

  if(isDefined(suppress_print)) {
    saveid = savegamenocommit(filename, descriptionstring, "$default", 1);
  } else {
    saveid = savegamenocommit(filename, descriptionstring);
  }

  autosaveprint("_autosave_game_now() Saving", undefined, saveid);
  wait 0.05;

  if(issaverecentlyloaded()) {
    autosaveprint("_autosave_game_now() Save recently loaded...", 0);
    level.autosave.lastautosavetime = gettime();
    flag_clear("game_saving");
    return 0;
  }

  if(isloadinganytransients()) {
    autosaveprint("_autosave_game_now() transient is loading, retrying (1)...", 0);
    flag_clear("game_saving");
    return 0;
  }

  if(saveid < 0) {
    autosaveprint("_autosave_game_now() save error", 0, saveid);
    flag_clear("game_saving");
    return 0;
  }

  if(!try_to_autosave_now(saveid)) {
    flag_clear("game_saving");
    return 0;
  }

  assertex(!istrue(var_bc910db033e0a289) || level.script == "<dev string:x56>", "<dev string:x5d>");

  if(istrue(var_bc910db033e0a289) && level.script == "strike") {} else {
    wait 2;
  }

  flag_clear("game_saving");

  if(isloadinganytransients()) {
    autosaveprint("_autosave_game_now() transient is loading, retrying (2)...", 0);
    return 0;
  }

  if(!commitwouldbevalid(saveid)) {
    autosaveprint("_autosave_game_now() SaveGame is no longer valid, another save was run from elsewhere", 0, saveid);
    return 0;
  }

  if(try_to_autosave_now(saveid)) {
    autosaveprint("_autosave_game_now() committed", 1, saveid);
    commitsave(saveid);
    level.player setplayeryolostate(0);
    setDvar(@ "hash_228e280524e6d278", "0");
    scripts\sp\gameskill::auto_adjust_save_committed();
  }

  return 1;
}

function autosave_now_trigger(trigger) {
  trigger waittill("trigger");
  autosave_now();
}

function try_to_autosave_now(saveid) {
  if(!issavesuccessful()) {
    return false;
  }

  if(!level.player autosavehealthcheck(saveid)) {
    return false;
  }

  if(!flag("can_save")) {
    autosaveprint("Can_save flag was clear", 0, saveid);
    return false;
  }

  return true;
}

function tryautosave(name, description, image, timeout, var_f78389d2b10c1f26, suppress_print, tryonce) {
  if(is_trials_level()) {
    return 0;
  }

  if(!isDefined(level.autosavecount)) {
    level.autosavecount = 0;
  }

  autosaveprint("tryAutoSave() called name = " + name, 2);

  if(gettime() < 3300) {
    autosaveprint("tryAutoSave() cannot save during before immediatelevelsave and beginningoflevelsave", 0);
    return;
  }

  if(flag("disable_autosaves")) {
    autosaveprint("tryAutoSave() autosaves disabled", 0);
    return 0;
  }

  level endon("nextmission");
  level.player endon("death");

  if(flag("game_saving")) {
    autosaveprint("tryAutoSave() game_saving in progress, aborting...", 0);
    return 0;
  }

  level notify("trying_new_autosave");

  if(isDefined(level.nextmission)) {
    return 0;
  }

  time0 = 0.05;
  time1 = 1.25;
  time2 = 1.25;

  if(isDefined(timeout) && timeout < time0 + time1 + time2) {
    assertmsg("Warning, tried to do an autosave_or_timeout with a time less than " + time0 + time1 + time2 + " (the minimum time it takes to do autosave checks)");
  }

  if(!isDefined(suppress_print)) {
    suppress_print = 0;
  }

  if(!isDefined(image)) {
    image = "$default";
  }

  if(!isDefined(var_f78389d2b10c1f26)) {
    var_f78389d2b10c1f26 = 0;
  }

  flag_set("game_saving");
  descriptionstring = getdescription();
  start_save_time = gettime();
  timeout_time = undefined;

  if(isDefined(timeout)) {
    timeout_time = gettime() + timeout * 1000;
  }

  trycount = 0;
  result = 0;

  while(true) {
    if(flag("disable_autosaves")) {
      autosaveprint("tryAutoSave() autosaves disabled (2)", 0);
      break;
    }

    if(istrue(tryonce) && trycount > 0) {
      autosaveprint("tryAutoSave() Tried once and failed", 0);
      break;
    }

    if(isDefined(timeout_time) && gettime() > timeout_time) {
      autosaveprint("tryAutoSave() Autosave timed out after " + gettime() - start_save_time + " milliseconds", 0);
      break;
    }

    trycount++;

    if(autosavecheck(undefined, var_f78389d2b10c1f26)) {
      waitfortransientloading("tryAutoSave()");

      if(getdvarint(@ "map_reloading") != 0) {
        autosaveprint("tryAutoSave() Game is restarting", 0);
        break;
      }

      if(isDefined(level.nextmission)) {
        autosaveprint("tryAutoSave() Game is going to next mission", 0);
        break;
      }

      saveid = savegamenocommit(level.autosavecount, descriptionstring, image, suppress_print);
      autosaveprint("tryAutoSave() Saving no commit", 2, saveid);

      if(saveid < 0) {
        autosaveprint("tryAutoSave() save error", 0, saveid);
        break;
      }

      wait time0;

      if(isDefined(timeout_time) && gettime() > timeout_time) {
        autosaveprint("tryAutoSave() Autosave timed out after " + gettime() - start_save_time + " milliseconds", 0);
        break;
      }

      if(issaverecentlyloaded()) {
        autosaveprint("tryAutoSave() Save recently loaded...", 0);
        level.autosave.lastautosavetime = gettime();
        break;
      }

      if(isloadinganytransients()) {
        autosaveprint("tryAutoSave() transient is loading, retrying (1)...", 0);
        continue;
      }

      wait time1;

      if(isDefined(timeout_time) && gettime() > timeout_time) {
        autosaveprint("tryAutoSave() Autosave timed out after " + gettime() - start_save_time + " milliseconds", 0);
        break;
      }

      if(isloadinganytransients()) {
        autosaveprint("tryAutoSave() transient is loading, retrying (2)...", 0);
        continue;
      }

      if(extra_autosave_checks_failed(saveid)) {
        continue;
      }

      if(!autosavecheck(undefined, var_f78389d2b10c1f26, saveid)) {
        autosaveprint("tryAutoSave() SaveGame invalid: 1.25 second check failed", 0, saveid);
        continue;
      }

      wait time2;

      if(isDefined(timeout_time) && gettime() > timeout_time) {
        autosaveprint("tryAutoSave() Autosave timed out after " + gettime() - start_save_time + " milliseconds", 0);
        break;
      }

      if(isloadinganytransients()) {
        autosaveprint("tryAutoSave() transient is loading, retrying (3)...", 0);
        continue;
      }

      if(!autosavecheck_not_picky(saveid)) {
        autosaveprint("tryAutoSave() SaveGame invalid: 2.5 second check failed", 0, saveid);
        continue;
      }

      if(!flag("can_save")) {
        autosaveprint("tryAutoSave() Can_save flag was clear", 0, saveid);
        break;
      }

      if(!commitwouldbevalid(saveid)) {
        autosaveprint("tryAutoSave() SaveGame is no longer valid, another save was run from elsewhere", 0, saveid);
        flag_clear("game_saving");
        return 0;
      }

      if(flag("disable_autosaves")) {
        autosaveprint("tryAutoSave() autosaves disabled (3)", 0);
        break;
      }

      result = 1;
      autosaveprint("tryAutoSave() committed", 1, saveid);
      commitsave(saveid);
      level.player setplayeryolostate(0);
      level.lastsavetime = gettime();
      setDvar(@ "hash_228e280524e6d278", "0");
      scripts\sp\gameskill::auto_adjust_save_committed();
      break;
    }

    wait 0.25;
  }

  flag_clear("game_saving");

  if(isDefined(result) && result) {
    level.autosavecount++;
  }

  return result;
}

function isprogressionlevel(levelname) {
  levelindex = namespace_d6cca25f4b0ab62::getlevelindex(levelname);
  return isDefined(levelindex);
}

function waitfortransientloading(prefix) {
  level endon("trying_new_autosave");
  nextprinttime = 0;

  if(waspreloadzonesstarted()) {
    while(!ispreloadzonescomplete()) {
      if(gettime() > nextprinttime) {
        autosaveprint(prefix + " Waiting for Preload to complete...", undefined);
        nextprinttime = gettime() + 2000;
      }

      wait 0.05;
    }
  }

  while(isloadinganytransients()) {
    if(gettime() > nextprinttime) {
      autosaveprint(prefix + " Waiting for transient to load...", undefined);
      nextprinttime = gettime() + 2000;
    }

    wait 0.05;
  }

  return true;
}

function extra_autosave_checks_failed(saveid) {
  foreach(func in level.autosave.extra_autosave_checks) {
    if(![[func["func"]]]()) {
      autosaveprint("Extra Autosave Check: " + func["msg"] + "", 0, saveid);
      return true;
    }
  }

  return false;
}

function autosavecheck_not_picky(saveid) {
  return autosavecheck(0, 0, saveid);
}

function autosavecheck(dopickychecks, var_f78389d2b10c1f26, saveid) {
  if(isDefined(level.autosave_check_override)) {
    autosavecheckparams = spawnStruct();
    autosavecheckparams.dopickychecks = dopickychecks;
    autosavecheckparams.var_f78389d2b10c1f26 = var_f78389d2b10c1f26;
    autosavecheckparams.saveid = saveid;
    return [[level.autosave_check_override]](autosavecheckparams);
  }

  if(isDefined(level.special_autosavecondition) && ![[level.special_autosavecondition]]()) {
    autosaveprint("autoSaveCheck() special_autosavecondition failed", 0);
    return 0;
  }

  if(level.missionfailed) {
    return 0;
  }

  if(!isDefined(dopickychecks)) {
    dopickychecks = level.dopickyautosavechecks;
  }

  if(!isDefined(var_f78389d2b10c1f26)) {
    var_f78389d2b10c1f26 = 0;
  }

  if(var_f78389d2b10c1f26) {
    if(![[level.global_callbacks["_autosave_stealthcheck"]]]()) {
      return 0;
    }
  }

  if(!level.player autosavehealthcheck(saveid)) {
    return 0;
  }

  if(dopickychecks && !level.player autosaveammocheck(saveid)) {
    return 0;
  }

  if(level.autosave_threat_check_enabled) {
    if(!autosavethreatcheck(dopickychecks, saveid)) {
      return 0;
    }
  }

  if(!level.player autosaveplayercheck(dopickychecks, saveid)) {
    return 0;
  }

  if(!level.player autosavefriendlyfirecheck(saveid)) {
    return 0;
  }

  if(level.player recentunresolvedcollision()) {
    return 0;
  }

  if(!issavesuccessful()) {
    autosaveprint("autoSaveCheck() save call was unsuccessful", 0, saveid);
    return 0;
  }

  return 1;
}

function autosaveplayercheck(dopickychecks, saveid) {
  assert(isPlayer(self));

  if(function_db03dec8d1dd5a3c()) {
    autosaveprint("player is outofbounds", 0, saveid);
    return false;
  }

  if(self ismeleeing() && dopickychecks) {
    autosaveprint("player is meleeing", 0, saveid);
    return false;
  }

  if(istrue(self.in_melee_death)) {
    autosaveprint("player is in context melee", 0, saveid);
    return false;
  }

  if(!function_58929539ece45ce1()) {
    autosaveprint("player is throwing a grenade", 0, saveid);
    return false;
  }

  if(isDefined(self.shellshocked) && self.shellshocked) {
    autosaveprint("player is in shellshock", 0, saveid);
    return false;
  }

  if(isflashed()) {
    autosaveprint("player is flashbanged", 0, saveid);
    return false;
  }

  if(self isswimming()) {
    if(scripts\common\swim_common::isbreathcritical()) {
      autosaveprint(" player's remaining breath is too low ", 0, saveid);
      return false;
    }
  } else if(!self islinked() && !self isonground()) {
    if(scripts\engine\trace::_bullet_trace_passed(level.player.origin + (0, 0, 5), level.player.origin + (0, 0, -200), 0, self)) {
      autosaveprint("player is too high off the ground", 0, saveid);
      return false;
    }
  }

  return true;
}

function function_db03dec8d1dd5a3c() {
  if(getomnvar("ui_out_of_bounds_countdown") > 0) {
    return true;
  }

  return false;
}

function function_58929539ece45ce1() {
  if(!self isthrowinggrenade()) {
    return true;
  }

  offhand = self getheldoffhand();

  switch (offhand.basename) {
    case #"hash_d675a16354a5298":
    case #"hash_10953bbdc9373206":
    case #"hash_22041fc502090af7":
    case #"hash_7983828e72e83a3e":
    case #"hash_cebe5cc9d61c966c":
      return true;
  }

  return false;
}

function recentunresolvedcollision() {
  currtime = gettime();

  if(isDefined(self.last_unresolved_collision_time) && currtime - self.last_unresolved_collision_time < 500) {
    return true;
  }

  return false;
}

function autosavefriendlyfirecheck(saveid) {
  nades = getEntArray("grenade", "classname");

  if(nades.size == 0) {
    return true;
  }

  playernades = [];

  foreach(nade in nades) {
    if(isvalidmissile(nade) && isPlayer(getmissileowner(nade))) {
      playernades[playernades.size] = nade;
    }
  }

  if(playernades.size == 0) {
    return true;
  }

  if(playernadessafe(playernades)) {
    return true;
  }

  allies = getaiarray("allies");

  foreach(ally in allies) {
    foreach(playernade in playernades) {
      if(distancesquared(ally.origin, playernade.origin) < 6400) {
        autosaveprint("autoSaveFriendlyFireCheck() player nade is too close to friendlies", 0, saveid);
        return false;
      }
    }
  }

  return true;
}

function playernadessafe(playernades) {
  foreach(nade in playernades) {
    if(offhand_is_dangerous(nade)) {
      return false;
    }
  }

  return true;
}

function autosaveammocheck(saveid) {
  assert(isPlayer(self));
  weapons = self getweaponslistprimaries();

  if(weapons.size == 0) {
    return true;
  }

  var_50e880f4569c48c8 = 1;
  highestfrac = 0;
  classname = "";

  foreach(weapon in weapons) {
    if(isnullweapon(weapon)) {
      continue;
    }

    if(weaponmaxammo(weapon) > 0) {
      var_50e880f4569c48c8 = 0;
    }

    myclip = self getweaponammoclip(weapon);
    maxclip = weaponclipsize(weapon);
    mystock = self getweaponammostock(weapon);
    maxstock = weaponmaxammo(weapon);
    myammo = myclip + mystock;
    maxammo = maxclip + maxstock;

    if(maxammo <= 0) {
      continue;
    }

    myfraction = myammo / maxammo;
    fractioncompare = 0.0714286;

    if(myfraction > highestfrac) {
      highestfrac = myfraction;
      classname = weapon.classname;

      if(weapon.classname == "grenade" || weapon.classname == "rocketlauncher") {
        fractioncompare = 0.5;
        classname = "explosive";
      }
    }

    if(myfraction >= fractioncompare) {
      return true;
    }
  }

  if(var_50e880f4569c48c8) {
    return true;
  }

  autosaveprint("Highest stock+clip ammo fraction: " + highestfrac + " for " + classname + " weapon. Too low to save.", 0, saveid);
  return false;
}

function autosavehealthcheck(saveid) {
  assert(isPlayer(self));

  if(scripts\sp\player::belowcriticalhealththreshold()) {
    autosaveprint("player is below critical health threshold", 0, saveid);
    return false;
  }

  if(istrue(self.damage.firedamage)) {
    autosaveprint("player is on fire!", 0, saveid);
    return false;
  }

  if(self isonladder()) {
    autosaveprint("player is on ladder! TU1 HACK!", 0, saveid);
    return false;
  }

  return true;
}

function autosavethreatcheck(dopickychecks, saveid) {
  enemies = getaiunittypearray("bad_guys", "all");

  foreach(enemy in enemies) {
    if(isDefined(level.player.stealth) && isDefined(enemy.stealth) && enemy.threatsight && enemy getthreatsight(level.player) > 0) {
      autosaveprint("AI (" + enemy getentitynumber() + ") cansee player, stealth meter is up", 0, saveid);
      return false;
    }

    if(!isalive(enemy.enemy)) {
      continue;
    }

    if(!isPlayer(enemy.enemy)) {
      if(level.autosave.enemydistcheck && enemy playermaybecomemyenemy()) {
        autosaveprint("Player close to AI's enemy", 0, saveid);

        if(getdvarint(@ "hash_6af159684591cb79")) {
          enemy thread scripts\sp\debug::function_e31e954e5ae9ad1d("<dev string:x76>", (0, 0, 85), 0.8);
        }

        return false;
      }

      continue;
    }

    if(enemy.in_melee && isDefined(enemy.meleetarget) && isPlayer(enemy.meleetarget)) {
      autosaveprint("AI (" + enemy getentitynumber() + ") meleeing player", 0, saveid);
      return false;
    }

    proximity_threat = [[level.autosave.proximity_threat_func]](enemy);

    if(proximity_threat == "return_even_if_low_accuracy") {
      autosaveprint("AI (" + enemy getentitynumber() + ") too close to player, so close we're ignoring his accuracy", 0, saveid);
      return false;
    }

    if(enemy.baseaccuracy < 0.1) {
      if(getdvarint(@ "hash_6af159684591cb79")) {
        enemy thread scripts\sp\debug::function_e31e954e5ae9ad1d("<dev string:x8f>", (0, 0, 85), 0.8);
      }

      continue;
    }

    if(proximity_threat == "none") {
      if(getdvarint(@ "hash_6af159684591cb79")) {
        enemy thread scripts\sp\debug::function_e31e954e5ae9ad1d("<dev string:x98>", (0, 0, 85), 0.8, (0, 1, 0));
      }

      continue;
    }

    canshootandsee = undefined;
    shotrecently = enemy._blackboard.shootparams_lastshoottime > gettime() - 1500;

    if(shotrecently) {
      canshootandsee = enemy getcanshootandsee();

      if(canshootandsee) {
        if(getdvarint(@ "hash_6af159684591cb79")) {
          enemy thread scripts\sp\debug::function_e31e954e5ae9ad1d("<dev string:xa0>", (0, 0, 85), 0.8, (1, 0, 0));
        }

        autosaveprint("AI (" + enemy getentitynumber() + ") firing on player", 0, saveid);
        return false;
      }
    }

    if(!isDefined(canshootandsee)) {
      canshootandsee = enemy getcanshootandsee();
    }

    if(canshootandsee && isDefined(enemy.asmtrackasm)) {
      if(enemy scripts\asm\asm::asm_currentstatehasflag(enemy.asmtrackasm, "aim")) {
        if(getdvarint(@ "hash_6af159684591cb79")) {
          enemy thread scripts\sp\debug::function_e31e954e5ae9ad1d("<dev string:xb3>", (0, 0, 85), 0.8, (1, 0, 0));
        }

        autosaveprint("AI (" + enemy getentitynumber() + ") aiming at player", 0, saveid);
        return false;
      } else if(enemy scripts\asm\asm::asm_currentstatehasflag(enemy.asmtrackasm, "notetrackaim")) {
        if(getdvarint(@ "hash_6af159684591cb79")) {
          enemy thread scripts\sp\debug::function_e31e954e5ae9ad1d("<dev string:xca>", (0, 0, 85), 0.8, (1, 0, 0));
        }

        autosaveprint("AI (" + enemy getentitynumber() + ") about to aim at player", 0, saveid);
        return false;
      }
    }

    if(getdvarint(@ "hash_6af159684591cb79")) {
      enemy thread scripts\sp\debug::function_e31e954e5ae9ad1d("<dev string:xe7>", (0, 0, 85), 0.8, (0, 1, 0));
    }
  }

  if(scripts\sp\equipment\tripwire::playerintripwiredangerzone()) {
    autosaveprint("player in tripwire danager zone", 0);
    return false;
  }

  if(player_is_near_live_offhand(1)) {
    return false;
  }

  if(isDefined(level.phys_barrels)) {
    foreach(barrel in level.phys_barrels) {
      if(!isDefined(barrel.onfire)) {
        continue;
      }

      if(barrel.subtype == "antigrav") {
        continue;
      }

      if(distancesquared(barrel.origin, level.player.origin) < 122500) {
        autosaveprint(barrel.subtype + " barrel is onfire and too close to player", 0, saveid);
        return false;
      }
    }
  }

  vehicles = getEntArray("scriptable", "code_classname");

  foreach(vehicle in vehicles) {
    if(!isDefined(vehicle.destructible_type) || vehicle.destructible_type != "vehicle") {
      continue;
    }

    if(!isDefined(vehicle.onfire)) {
      continue;
    }

    if(distancesquared(vehicle.origin, level.player.origin) < 160000) {
      autosaveprint("burning car too close to player", 0, saveid);
      return false;
    }
  }

  return true;
}

function playermaybecomemyenemy() {
  if(self.enemy scripts\common\vehicle::isvehicle()) {
    return false;
  }

  if(distancesquared(self.enemy.origin, level.player.origin) < 4900) {
    return true;
  }

  if(self cansee(level.player)) {
    disttoenemy = distancesquared(self.enemy.origin, self.origin);
    disttoplayer = distancesquared(level.player.origin, self.origin);

    if(disttoplayer <= disttoenemy + 10000) {
      return true;
    }
  }

  return false;
}

function getcanshootandsee() {
  return scripts\anim\utility_common::canseeenemy(0) && self canshootenemy(0);
}

function autosave_proximity_threat_func(enemy) {
  foreach(player in level.players) {
    dist = distancesquared(enemy.origin, player.origin);

    if(dist < 10000) {
      return "return_even_if_low_accuracy";
    }

    if(dist < 129600) {
      return "return";
    }

    if(dist < 1000000) {
      return "threat_exists";
    }
  }

  return "none";
}

function function_4574815d2a5a1376() {
  setdevdvarifuninitialized(@ "hash_625a91d4e43b3929", 0);
  wait 1;
  adddebugcommand("<dev string:xf1>");

  while(true) {
    if(getdvarint(@ "hash_625a91d4e43b3929", 0)) {
      setDvar(@ "hash_625a91d4e43b3929", 0);
      thread autosave_now();
    }

    waitframe();
  }
}

# /