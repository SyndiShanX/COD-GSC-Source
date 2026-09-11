/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\autosave.gsc
***********************************************/

function main() {
  if(!scripts\engine\utility::add_init_script("autosave", &main)) {
    return;
  }

  setdvarifuninitialized("scr_autosave_showPrints", "1");
  setdvarifuninitialized("scr_autosave_debug", "0");
  level.autosave = spawnStruct();
  level.autosave.lastautosavetime = 0;
  scripts\engine\utility::flag_init("game_saving");
  scripts\engine\utility::flag_init("can_save");
  scripts\engine\utility::flag_set("can_save");
  scripts\engine\utility::flag_init("disable_autosaves");
  scripts\engine\utility::flag_init("ImmediateLevelStartSave");

  if(!isDefined(level.autosave.extra_autosave_checks)) {
    level.autosave.extra_autosave_checks = [];
  }

  level.autosave.proximity_threat_func = &autosave_proximity_threat_func;
  level.autosave.enemydistcheck = 1;
  beginningoflevelsave();
  startsavedprogression(level.script);
}

function proggressionmismatchpopup(var0) {
  setomnvar("progression_invalid", 1);
}

function cheat_save() {
  wait 2;
  level.player endon("death");
  setdvarifuninitialized("scr_savetest", "0");

  for(;;) {
    if(getdvarint("scr_savetest") > 0) {
      setDvar("scr_savetest", "0");
      scripts\engine\sp\utility::autosave_by_name("cheat_save");
      wait 1;
    }

    wait 0.05;
  }
}

function getdescription() {
  return &"AUTOSAVE_AUTOSAVE";
}

function getnames(var0) {
  if(var0 == 0) {
    var1 = &"AUTOSAVE_GAME";
  } else {
    var1 = &"AUTOSAVE_NOGAME";
  }

  return var1;
}

function beginningoflevelsave() {
  if(scripts\sp\utility::is_trials_level()) {
    return;
  }

  thread immediatelevelstartsave();
  thread beginningoflevelsave_thread();
}

function immediatelevelstartsave() {
  var0 = scripts\sp\endmission::level_settle_time_get(level.script);

  if(!isDefined(var0)) {
    var0 = 0;
  }

  var0 *= 0.05;
  var1 = scripts\sp\endmission::client_settle_time_get(level.script);

  if(!isDefined(var1)) {
    var1 = 0;
  }

  var1 *= 0.001;
  wait var1 + var0 + 0.15;
  var2 = 0;

  if(isDefined(level.credits_active)) {
    autosaveprint("immediateLevelStartSave() Credits are active", 0);
    var2 = 1;
  } else if(level.missionfailed) {
    autosaveprint("immediateLevelStartSave() Mission Failed", 0);
    var2 = 1;
  } else if(scripts\engine\utility::flag("game_saving")) {
    autosaveprint("immediateLevelStartSave() In the middle of another save, aborting", 0);
    var2 = 1;
  }

  if(var2) {
    scripts\engine\utility::flag_set("ImmediateLevelStartSave");
    return;
  }

  scripts\engine\utility::flag_set("game_saving");

  if(!isalive(level.player)) {
    return;
  }

  var3 = "levelshots / autosave / autosave_" + level.script + "immediate_start";
  savegame("immediatelevelstart", &"AUTOSAVE_LEVELSTART", var3, 1);
  setDvar("ui_grenade_death", "0");
  level.player setplayeryolostate(0);
  scripts\engine\utility::flag_clear("game_saving");
  scripts\engine\utility::flag_set("ImmediateLevelStartSave");
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
    autosaveprint("beginningOfLevelSave_thread() Missiong failed", 0);
    return;
  }

  if(scripts\engine\utility::flag("game_saving")) {
    autosaveprint("beginningOfLevelSave_thread() In the middle of another save, aborting", 0);
    return;
  }

  if(!scripts\engine\utility::flag("ImmediateLevelStartSave")) {
    scripts\engine\utility::flag_wait("ImmediateLevelStartSave");
    wait 1;
  }

  scripts\engine\utility::flag_set("game_saving");
  var0 = "levelshots / autosave / autosave_" + level.script + "start";
  var1 = waitfortransientloading("beginningOfLevelSave_thread()");

  if(!isDefined(var1)) {
    autosaveprint("beginningOfLevelSave_thread() a newer save was called...", 0);
    scripts\engine\utility::flag_clear("game_saving");
    return;
  }

  if(!isalive(level.player)) {
    return;
  }

  savegame("levelstart", &"AUTOSAVE_LEVELSTART", var0, 1);
  setDvar("ui_grenade_death", "0");
  level.player setplayeryolostate(0);
  scripts\engine\utility::flag_clear("game_saving");
}

function trigger_autosave_stealth(var0) {
  var0 waittill("trigger");
  scripts\engine\sp\utility::autosave_stealth();
}

function trigger_autosave_tactical(var0) {
  var0 waittill("trigger");
  scripts\engine\sp\utility::autosave_tactical();
}

function trigger_autosave(var0) {
  thread autosave_think(var0);
}

function autosave_think(var0) {
  var0 endon("death");

  if(!isDefined(var0.script_autosave)) {
    var0.script_autosave = 1;
  }

  var1 = getnames(var0.script_autosave);

  if(!isDefined(var1)) {
    return;
  }

  wait 1;
  var0 waittill("trigger");
  var2 = undefined;

  if(isDefined(var0.script_autosavename)) {
    var2 = var0.script_autosavename;
  }

  scripts\engine\sp\utility::autosave_by_name(var2);

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function autosaveprint(var0, var1, var2) {
  if(!getdvarint("scr_autosave_debug") && !getdvarint("scr_autosave_showPrints")) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = -1;
  }

  var3 = "^5AUTOSAVE";

  if(isDefined(var2)) {
    var3 = var3 + "[" + var2 + "]";
  }

  var3 += ":^7 ";

  if(var1 == 0) {
    var0 = var3 + "^1[ FAILED] " + "^7" + var0;
  } else if(var1 == 1) {
    var0 = var3 + "^2[ SUCCEEDED ] " + "^7" + var0;
  } else if(var1 == 2) {
    var0 = var3 + "^7" + var0;
  } else {
    var0 = var3 + var0;
  }

  if(var1 == 0 || var1 == 1 || var1 == 2) {
    thread autosave_hudprint(var0);
  }

  if(getdvarint("scr_autosave_debug")) {
    iprintln(var0);
    return;
  }
}

function autosave_hudprint(var0) {
  var1 = getbuildversion();

  if(var1 == "IW8") {
    return;
  }

  if(!getdvarint("scr_autosave_showPrints")) {
    return;
  }

  if(getdvarint("debug_hud_disable") > 0) {
    return;
  }

  if(!isDefined(level.autosave.fail_huds)) {
    level.autosave.fail_huds = [];
  }

  if(level.autosave.fail_huds.size == 3) {
    var2 = level.autosave.fail_huds[0];
    level.autosave.fail_huds = scripts\engine\utility::array_remove_index(level.autosave.fail_huds, 0);
    autosave_hudfail_update();
    thread autosave_hudfail_destroy();
  }

  var3 = newhudelem();
  var3.elemtype = "font";
  var3.font = "default";
  var3.fontscale = 0.7;
  var3.width = 0;
  var3.height = int(8.4);
  var3.horzalign = "fullscreen";
  var3.vertalign = "fullscreen";
  var4 = level.autosave.fail_huds.size;
  level.autosave.fail_huds[var4] = var3;
  var3.foreground = 1;
  var3.sort = 20;
  var3.x = 130;
  var3.y = 5 + var4 * 8.4;
  var3.label = var0;
  var3.alpha = 0;
  var3 fadeovertime(0.2);
  var3.alpha = 1;
  var3 endon("death");
  wait 5;
  level.autosave.fail_huds = scripts\engine\utility::array_remove(level.autosave.fail_huds, var3);
  autosave_hudfail_update();
  thread autosave_hudfail_destroy();
}

function autosave_hudfail_destroy() {
  var0 = 1;
  self endon("death");
  self fadeovertime(0.1);
  self moveovertime(0.1);
  self.y -= 8.4;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

function autosave_hudfail_update() {
  level.autosave.fail_huds = scripts\engine\utility::array_removeundefined(level.autosave.fail_huds);

  foreach(var1 in level.autosave.fail_huds) {
    var1 moveovertime(0.1);
    var1.y = 5 + var2 * 12 * 0.7;
  }
}

function _autosave_game_now(var0, var1) {
  if(scripts\sp\utility::is_trials_level()) {
    return 0;
  }

  autosaveprint("_autosave_game_now() called...", 2);

  if(gettime() < 3300) {
    autosaveprint("tryAutoSave() cannot save during before immediatelevelsave and beginningoflevelsave", 0);
    return;
  }

  if(isDefined(level.missionfailed) && level.missionfailed) {
    return 0;
  }

  if(!isDefined(var1) || !var1) {
    level notify("trying_new_autosave");
  }

  if(scripts\engine\utility::flag("game_saving")) {
    autosaveprint("_autosave_game_now() game_saving in progress, aborting...", 0);
    return 0;
  }

  scripts\engine\utility::flag_set("game_saving");
  var2 = waitfortransientloading("_autosave_game_now()");

  if(!isDefined(var2)) {
    autosaveprint("_autosave_game_now() a newer save was called...", 0);
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  for(var3 = 0; var3 < level.players.size; var3++) {
    var4 = level.players[var3];

    if(!isalive(var4)) {
      return 0;
    }
  }

  var5 = "save_now";
  var6 = getdescription();

  if(getdvarint("reloading") != 0) {
    autosaveprint("_autosave_game_now() Game is restarting", 0);
    return 0;
  }

  if(isDefined(level.nextmission)) {
    autosaveprint("_autosave_game_now() Game is going to next mission", 0);
    return 0;
  }

  if(isDefined(var0)) {
    var7 = savegamenocommit(var5, var6, "$default", 1);
  } else {
    var7 = savegamenocommit(var6, var7);
  }

  autosaveprint("_autosave_game_now() Saving", undefined, var7);
  wait 0.05;

  if(issaverecentlyloaded()) {
    autosaveprint("_autosave_game_now() Save recently loaded...", 0);
    level.autosave.lastautosavetime = gettime();
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  if(isloadinganytransients()) {
    autosaveprint("_autosave_game_now() transient is loading, retrying (1)...", 0);
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  if(var7 < 0) {
    autosaveprint("_autosave_game_now() save error", 0, var7);
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  if(!try_to_autosave_now(var7)) {
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  wait 2;
  scripts\engine\utility::flag_clear("game_saving");

  if(isloadinganytransients()) {
    autosaveprint("_autosave_game_now() transient is loading, retrying (2)...", 0);
    return 0;
  }

  if(!commitwouldbevalid(var7)) {
    autosaveprint("_autosave_game_now() SaveGame is no longer valid, another save was run from elsewhere", 0, var7);
    return 0;
  }

  if(try_to_autosave_now(var7)) {
    autosaveprint("_autosave_game_now() committed", 1, var7);
    commitsave(var7);
    level.player setplayeryolostate(0);
    setDvar("ui_grenade_death", "0");
    scripts\sp\gameskill::auto_adjust_save_committed();
  }

  return 1;
}

function autosave_now_trigger(var0) {
  var0 waittill("trigger");
  scripts\engine\sp\utility::autosave_now();
}

function try_to_autosave_now(var0) {
  if(!issavesuccessful()) {
    return false;
  }

  if(!autosavehealthcheck(level.player, var0)) {
    return false;
  }

  if(!scripts\engine\utility::flag("can_save")) {
    autosaveprint("Can_save flag was clear", 0, var0);
    return false;
  }

  return true;
}

function tryautosave(var0, var1, var2, var3, var4, var5, var6) {
  if(scripts\sp\utility::is_trials_level()) {
    return 0;
  }

  autosaveprint("tryAutoSave() called filename=" + var0, 2);

  if(gettime() < 3300) {
    autosaveprint("tryAutoSave() cannot save during before immediatelevelsave and beginningoflevelsave", 0);
    return;
  }

  if(scripts\engine\utility::flag("disable_autosaves")) {
    autosaveprint("tryAutoSave() autosaves disabled", 0);
    return 0;
  }

  level endon("nextmission");
  level.player endon("death");

  if(scripts\engine\utility::flag("game_saving")) {
    autosaveprint("tryAutoSave() game_saving in progress, aborting...", 0);
    return 0;
  }

  level notify("trying_new_autosave");

  if(isDefined(level.nextmission)) {
    return 0;
  }

  var7 = 0.05;
  var8 = 1.25;
  var9 = 1.25;

  if(isDefined(var3) && var3 < var7 + var8 + var9) {}

  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(!isDefined(var2)) {
    var2 = "$default";
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  scripts\engine\utility::flag_set("game_saving");
  var10 = getdescription();
  var11 = gettime();
  var12 = undefined;

  if(isDefined(var3)) {
    var12 = gettime() + var3 * 1000;
  }

  var13 = 0;
  var14 = 0;

  for(;;) {
    if(scripts\engine\utility::flag("disable_autosaves")) {
      autosaveprint("tryAutoSave() autosaves disabled (2)", 0);
      break;
    }

    if(istrue(var6) && var13 > 0) {
      autosaveprint("tryAutoSave() Tried once and failed", 0);
      break;
    }

    if(isDefined(var12) && gettime() > var12) {
      autosaveprint("tryAutoSave() Autosave timed out after " + gettime() - var11 + " milliseconds", 0);
      break;
    }

    var13++;

    if(autosavecheck(undefined, var4)) {
      waitfortransientloading("tryAutoSave()");

      if(getdvarint("reloading") != 0) {
        autosaveprint("tryAutoSave() Game is restarting", 0);
        break;
      }

      if(isDefined(level.nextmission)) {
        autosaveprint("tryAutoSave() Game is going to next mission", 0);
        break;
      }

      var15 = savegamenocommit(var0, var10, var2, var5);
      autosaveprint("tryAutoSave() Saving no commit", 2, var15);

      if(var15 < 0) {
        autosaveprint("tryAutoSave() save error", 0, var15);
        break;
      }

      wait var7;

      if(isDefined(var12) && gettime() > var12) {
        autosaveprint("tryAutoSave() Autosave timed out after " + gettime() - var11 + " milliseconds", 0);
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

      wait var8;

      if(isDefined(var12) && gettime() > var12) {
        autosaveprint("tryAutoSave() Autosave timed out after " + gettime() - var11 + " milliseconds", 0);
        break;
      }

      if(isloadinganytransients()) {
        autosaveprint("tryAutoSave() transient is loading, retrying (2)...", 0);
        continue;
      }

      if(extra_autosave_checks_failed(var15)) {
        continue;
      }

      if(!autosavecheck(undefined, var4, var15)) {
        autosaveprint("tryAutoSave() SaveGame invalid: 1.25 second check failed", 0, var15);
        continue;
      }

      wait var9;

      if(isDefined(var12) && gettime() > var12) {
        autosaveprint("tryAutoSave() Autosave timed out after " + gettime() - var11 + " milliseconds", 0);
        break;
      }

      if(isloadinganytransients()) {
        autosaveprint("tryAutoSave() transient is loading, retrying (3)...", 0);
        continue;
      }

      if(!autosavecheck_not_picky(var15)) {
        autosaveprint("tryAutoSave() SaveGame invalid: 2.5 second check failed", 0, var15);
        continue;
      }

      if(!scripts\engine\utility::flag("can_save")) {
        autosaveprint("tryAutoSave() Can_save flag was clear", 0, var15);
        break;
      }

      if(!commitwouldbevalid(var15)) {
        autosaveprint("tryAutoSave() SaveGame is no longer valid, another save was run from elsewhere", 0, var15);
        scripts\engine\utility::flag_clear("game_saving");
        return 0;
      }

      if(scripts\engine\utility::flag("disable_autosaves")) {
        autosaveprint("tryAutoSave() autosaves disabled (3)", 0);
        break;
      }

      var14 = 1;
      autosaveprint("tryAutoSave() committed", 1, var15);
      commitsave(var15);
      level.player setplayeryolostate(0);
      level.lastsavetime = gettime();
      setDvar("ui_grenade_death", "0");
      scripts\sp\gameskill::auto_adjust_save_committed();
      break;
    }

    wait 0.25;
  }

  scripts\engine\utility::flag_clear("game_saving");
  return var14;
}

function startsavedprogression(var0) {
  if(isprogressionlevel(var0)) {
    if(isprogressionmismatch(var0)) {
      proggressionmismatchpopup();
      return;
    }

    if(getdvarint("MSSSNONPLS") == 0) {
      level.player setplayerprogression("currentMission", var0);
      var1 = level.player getplayerprogression("missionStateData", var0);

      if(var1 == "locked") {
        level.player setplayerprogression("missionStateData", var0, "incomplete");
        return;
      }

      return;
    }

    return;
  }
}

function isprogressionmismatch(var0) {
  var1 = scripts\sp\endmission::getlevelindex(var0);

  if(previouslevelcompleted(var1) || isdevbuild()) {
    return false;
  } else {
    return true;
  }

  return false;
}

function isprogressionlevel(var0) {
  var1 = scripts\sp\endmission::getlevelindex(var0);
  return isDefined(var1);
}

function isdevbuild() {
  var0 = 0;
  setdvarifuninitialized("scr_treat_progression_as_ship_build", 0);
  return var0;
}

function previouslevelcompleted(var0) {
  if(var0 == 0) {
    return 1;
  }

  var0--;
  var1 = level.missionsettings.levels[var0].name;
  var2 = level.player getplayerprogression("missionStateData", var1);

  if(var2 != "complete") {
    return 0;
  }

  return 1;
}

function waitfortransientloading(var0) {
  level endon("trying_new_autosave");
  var1 = 0;

  if(waspreloadzonesstarted()) {
    while(!ispreloadzonescomplete()) {
      if(gettime() > var1) {
        var1 = gettime() + 2000;
      }

      wait 0.05;
    }
  }

  while(isloadinganytransients()) {
    if(gettime() > var1) {
      var1 = gettime() + 2000;
    }

    wait 0.05;
  }

  return true;
}

function extra_autosave_checks_failed(var0) {
  foreach(var2 in level.autosave.extra_autosave_checks) {
    if(![[var2["func"]]]()) {
      autosaveprint("Extra Autosave Check: " + var2["msg"] + "", 0, var0);
      return true;
    }
  }

  return false;
}

function autosavecheck_not_picky(var0) {
  return autosavecheck(0, 0, var0);
}

function autosavecheck(var0, var1, var2) {
  if(isDefined(level.autosave_check_override)) {
    return [[level.autosave_check_override]]();
  }

  if(isDefined(level.special_autosavecondition) && ![[level.special_autosavecondition]]()) {
    autosaveprint("autoSaveCheck() special_autosavecondition failed", 0);
    return 0;
  }

  if(level.missionfailed) {
    return 0;
  }

  if(!isDefined(var0)) {
    var0 = level.dopickyautosavechecks;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(var1) {
    if(![[level.global_callbacks["_autosave_stealthcheck"]]]()) {
      return 0;
    }
  }

  if(!autosavehealthcheck(level.player, var2)) {
    return 0;
  }

  if(var0 && !autosaveammocheck(level.player, var2)) {
    return 0;
  }

  if(level.autosave_threat_check_enabled) {
    if(!autosavethreatcheck(var0, var2)) {
      return 0;
    }
  }

  if(!autosaveplayercheck(level.player, var0, var2)) {
    return 0;
  }

  if(!autosavefriendlyfirecheck(level.player, var2)) {
    return 0;
  }

  if(recentunresolvedcollision(level.player)) {
    return 0;
  }

  if(!issavesuccessful()) {
    autosaveprint("autoSaveCheck() save call was unsuccessful", 0, var2);
    return 0;
  }

  return 1;
}

function autosaveplayercheck(var0, var1) {
  if(self ismeleeing() && var0) {
    autosaveprint("player is meleeing", 0, var1);
    return false;
  }

  if(istrue(self.in_melee_death)) {
    autosaveprint("player is in context melee", 0, var1);
    return false;
  }

  if(self isthrowinggrenade()) {
    autosaveprint("player is throwing a grenade", 0, var1);
    return false;
  }

  if(isDefined(self.shellshocked) && self.shellshocked) {
    autosaveprint("player is in shellshock", 0, var1);
    return false;
  }

  if(!self islinked() && !scripts\sp\utility::in_zero_gravity() && !self isonground()) {
    if(scripts\engine\trace::_bullet_trace_passed(level.player.origin + (0, 0, 5), level.player.origin + (0, 0, -200), 0, self)) {
      autosaveprint("player is too high off the ground", 0, var1);
      return false;
    }
  }

  if(scripts\engine\utility::isflashed()) {
    autosaveprint("player is flashbanged", 0, var1);
    return false;
  }

  if(isDefined(self.hackingblockautosave) && self.hackingblockautosave == 1) {
    autosaveprint("player is controlling a hacked robot", 0, var1);
    return false;
  }

  return true;
}

function recentunresolvedcollision() {
  var0 = gettime();

  if(isDefined(self.last_unresolved_collision_time) && var0 - self.last_unresolved_collision_time < 500) {
    return true;
  }

  return false;
}

function autosavefriendlyfirecheck(var0) {
  var1 = getEntArray("grenade", "classname");

  if(var1.size == 0) {
    return true;
  }

  var2 = [];

  foreach(var4 in var1) {
    if(isvalidmissile(var4) && isPlayer(getmissileowner(var4))) {
      var2 = var4;
    }
  }

  if(var2.size == 0) {
    return true;
  }

  if(playernadessafe(var2)) {
    return true;
  }

  var6 = getaiarray("allies");

  foreach(var8 in var6) {
    foreach(var10 in var2) {
      if(distancesquared(var8.origin, var10.origin) < 6400) {
        autosaveprint("autoSaveFriendlyFireCheck() player nade is too close to friendlies", 0, var0);
        return false;
      }
    }
  }

  return true;
}

function playernadessafe(var0) {
  foreach(var2 in var0) {
    if(scripts\sp\utility::offhand_is_dangerous(var2)) {
      return false;
    }
  }

  return true;
}

function autosaveammocheck(var0) {
  var1 = self getweaponslistprimaries();

  if(var1.size == 0) {
    return true;
  }

  var2 = 1;
  var3 = 0;
  var4 = "";

  foreach(var6 in var1) {
    if(nullweapon(var6)) {
      continue;
    }

    if(weaponmaxammo(var6) > 0) {
      var2 = 0;
    }

    var7 = self getweaponammoclip(var6);
    var8 = weaponclipsize(var6);
    var9 = self getweaponammostock(var6);
    var10 = weaponmaxammo(var6);
    var11 = var7 + var9;
    var12 = var8 + var10;

    if(var12 <= 0) {
      continue;
    }

    var13 = var11 / var12;
    var14 = 0.0714286;

    if(var13 > var3) {
      var3 = var13;
      var4 = var6.classname;

      if(var6.classname == "grenade" || var6.classname == "rocketlauncher") {
        var14 = 0.5;
        var4 = "explosive";
      }
    }

    if(var13 >= var14) {
      return true;
    }
  }

  if(var2) {
    return true;
  }

  autosaveprint("Highest stock+clip ammo fraction: " + var3 + " for " + var4 + " weapon. Too low to save.", 0, var0);
  return false;
}

function autosavehealthcheck(var0) {
  if(scripts\sp\player::belowcriticalhealththreshold()) {
    autosaveprint("player is below critical health threshold", 0, var0);
    return false;
  }

  if(istrue(self.damage.firedamage)) {
    autosaveprint("player is on fire!", 0, var0);
    return false;
  }

  if(self isonladder()) {
    autosaveprint("player is on ladder! TU1 HACK!", 0, var0);
    return false;
  }

  return true;
}

function autosavethreatcheck(var0, var1) {
  var2 = getaiunittypearray("bad_guys", "all");

  foreach(var4 in var2) {
    if(isDefined(level.player.stealth) && isDefined(var4.stealth) && var4.threatsight && var4 getthreatsight(level.player) > 0) {
      autosaveprint("AI cansee player, stealth meter is up", 0, var1);
      return false;
    }

    if(!isDefined(var4.enemy)) {
      continue;
    }

    if(!isPlayer(var4.enemy)) {
      if(level.autosave.enemydistcheck && playermaybecomemyenemy(var4)) {
        autosaveprint("Player close to AI's enemy", 0, var1);
        return false;
      }

      continue;
    }

    if(isDefined(var4.melee) && isDefined(var4.melee.target) && isPlayer(var4.melee.target)) {
      autosaveprint("AI meleeing player", 0, var1);
      return false;
    }

    var5 = [[level.autosave.proximity_threat_func]](var4);

    if(var5 == "return_even_if_low_accuracy") {
      autosaveprint("AI too close to player, so close we're ignoring his accuracy", 0, var1);
      return false;
    }

    if(var4.finalaccuracy < 0.021 && var4.finalaccuracy > -1) {
      continue;
    }

    if(var5 == "none") {
      continue;
    }

    var6 = undefined;
    var7 = var4.a.lastshoottime > gettime() - 1500;

    if(var7) {
      var6 = getcanshootandsee(var4);

      if(var6) {
        autosaveprint("AI firing on player", 0, var1);
        return false;
      }
    }

    if(!isDefined(var6)) {
      var6 = getcanshootandsee(var4);
    }

    if(isDefined(var4.asm.trackasm) && var4 scripts\asm\asm::asm_currentstatehasflag(var4.asm.trackasm, "aim") && var6) {
      autosaveprint("AI aiming at player", 0, var1);
      return false;
    }
  }

  if(scripts\sp\equipment\tripwire::playerintripwiredangerzone()) {
    autosaveprint("player in tripwire danager zone", 0);
    return false;
  }

  if(scripts\sp\utility::player_is_near_live_offhand()) {
    return false;
  }

  if(isDefined(level.phys_barrels)) {
    foreach(var10 in level.phys_barrels) {
      if(!isDefined(var10.onfire)) {
        continue;
      }

      if(var10.subtype == "antigrav") {
        continue;
      }

      if(distancesquared(var10.origin, level.player.origin) < 122500) {
        autosaveprint(var10.subtype + " barrel is onfire and too close to player", 0, var1);
        return false;
      }
    }
  }

  var12 = getEntArray("scriptable", "code_classname");

  foreach(var14 in var12) {
    if(!isDefined(var14.destructible_type) || var14.destructible_type != "vehicle") {
      continue;
    }

    if(!isDefined(var14.onfire)) {
      continue;
    }

    if(distancesquared(var14.origin, level.player.origin) < 160000) {
      autosaveprint("burning car too close to player", 0, var1);
      return false;
    }
  }

  return true;
}

function playermaybecomemyenemy() {
  if(isalive(self.enemy) && distancesquared(self.enemy.origin, level.player.origin) < 40000) {
    return true;
  }

  if(isalive(self.enemy) && self cansee(level.player)) {
    var0 = distancesquared(self.enemy.origin, self.origin);
    var1 = distancesquared(level.player.origin, self.origin);

    if(var1 <= var0 + 200) {
      return true;
    }
  }

  return false;
}

function getcanshootandsee() {
  return scripts\anim\utility_common::canseeenemy(0) && self canshootenemy(0);
}

function enemy_is_a_threat() {
  if(self.finalaccuracy >= 0.021) {
    return true;
  }

  foreach(var1 in level.players) {
    if(distance(self.origin, var1.origin) < 500) {
      return true;
    }
  }

  return false;
}

function autosave_proximity_threat_func(var0) {
  foreach(var2 in level.players) {
    var3 = distancesquared(var0.origin, var2.origin);

    if(var3 < 10000) {
      return "return_even_if_low_accuracy";
    }

    if(var3 < 129600) {
      return "return";
    }

    if(var3 < 1000000) {
      return "threat_exists";
    }
  }

  return "none";
}