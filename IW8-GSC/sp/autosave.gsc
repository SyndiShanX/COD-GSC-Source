/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\autosave.gsc
***********************************************/

main() {
  if(!scripts\engine\utility::add_init_script("autosave", ::main)) {
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

  if(!isDefined(level.autosave.extra_autosave_checks))
    level.autosave.extra_autosave_checks = [];

  level.autosave.proximity_threat_func = ::autosave_proximity_threat_func;
  level.autosave.enemydistcheck = 1;
  beginningoflevelsave();
  startsavedprogression(level.script);
}

proggressionmismatchpopup(var_0) {
  setomnvar("progression_invalid", 1);
}

cheat_save() {
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

getdescription() {
  return &"AUTOSAVE_AUTOSAVE";
}

getnames(var_0) {
  if(var_0 == 0)
    var_1 = &"AUTOSAVE_GAME";
  else
    var_1 = &"AUTOSAVE_NOGAME";

  return var_1;
}

beginningoflevelsave() {
  if(scripts\sp\utility::is_trials_level()) {
    return;
  }
  thread immediatelevelstartsave();
  thread beginningoflevelsave_thread();
}

immediatelevelstartsave() {
  var_0 = scripts\sp\endmission::level_settle_time_get(level.script);

  if(!isDefined(var_0))
    var_0 = 0;

  var_0 = var_0 * 0.05;
  var_1 = scripts\sp\endmission::client_settle_time_get(level.script);

  if(!isDefined(var_1))
    var_1 = 0;

  var_1 = var_1 * 0.001;
  wait(var_1 + var_0 + 0.15);
  var_2 = 0;

  if(isDefined(level.credits_active)) {
    autosaveprint("immediateLevelStartSave() Credits are active", 0);
    var_2 = 1;
  } else if(level.missionfailed) {
    autosaveprint("immediateLevelStartSave() Mission Failed", 0);
    var_2 = 1;
  } else if(scripts\engine\utility::flag("game_saving")) {
    autosaveprint("immediateLevelStartSave() In the middle of another save, aborting", 0);
    var_2 = 1;
  }

  if(var_2) {
    scripts\engine\utility::flag_set("ImmediateLevelStartSave");
    return;
  }

  scripts\engine\utility::flag_set("game_saving");

  if(!isalive(level.player)) {
    return;
  }
  var_3 = "levelshots / autosave / autosave_" + level.script + "immediate_start";
  savegame("immediatelevelstart", &"AUTOSAVE_LEVELSTART", var_3, 1);
  setDvar("ui_grenade_death", "0");
  level.player setplayeryolostate(0);
  scripts\engine\utility::flag_clear("game_saving");
  scripts\engine\utility::flag_set("ImmediateLevelStartSave");
}

beginningoflevelsave_thread() {
  if(isDefined(level.beginningoflevelsavedelay))
    wait(level.beginningoflevelsavedelay);
  else
    wait 2;

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
  var_0 = "levelshots / autosave / autosave_" + level.script + "start";
  var_1 = waitfortransientloading("beginningOfLevelSave_thread()");

  if(!isDefined(var_1)) {
    autosaveprint("beginningOfLevelSave_thread() a newer save was called...", 0);
    scripts\engine\utility::flag_clear("game_saving");
    return;
  }

  if(!isalive(level.player)) {
    return;
  }
  savegame("levelstart", &"AUTOSAVE_LEVELSTART", var_0, 1);
  setDvar("ui_grenade_death", "0");
  level.player setplayeryolostate(0);
  scripts\engine\utility::flag_clear("game_saving");
}

trigger_autosave_stealth(var_0) {
  var_0 waittill("trigger");
  scripts\engine\sp\utility::autosave_stealth();
}

trigger_autosave_tactical(var_0) {
  var_0 waittill("trigger");
  scripts\engine\sp\utility::autosave_tactical();
}

trigger_autosave(var_0) {
  thread autosave_think(var_0);
}

autosave_think(var_0) {
  var_0 endon("death");

  if(!isDefined(var_0.script_autosave))
    var_0.script_autosave = 1;

  var_1 = getnames(var_0.script_autosave);

  if(!isDefined(var_1)) {
    return;
  }
  wait 1;
  var_0 waittill("trigger");
  var_2 = undefined;

  if(isDefined(var_0.script_autosavename))
    var_2 = var_0.script_autosavename;

  scripts\engine\sp\utility::autosave_by_name(var_2);

  if(isDefined(var_0))
    var_0 delete();
}

autosaveprint(var_0, var_1, var_2) {
  if(!getdvarint("scr_autosave_debug") && !getdvarint("scr_autosave_showPrints")) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = -1;

  var_3 = "^5AUTOSAVE";

  if(isDefined(var_2))
    var_3 = var_3 + "[" + var_2 + "]";

  var_3 = var_3 + ":^7 ";

  if(var_1 == 0)
    var_0 = var_3 + "^1[ FAILED] " + "^7" + var_0;
  else if(var_1 == 1)
    var_0 = var_3 + "^2[ SUCCEEDED ] " + "^7" + var_0;
  else if(var_1 == 2)
    var_0 = var_3 + "^7" + var_0;
  else
    var_0 = var_3 + var_0;

  if(var_1 == 0 || var_1 == 1 || var_1 == 2)
    thread autosave_hudprint(var_0);

  if(getdvarint("scr_autosave_debug"))
    iprintln(var_0);
}

autosave_hudprint(var_0) {
  var_1 = getbuildversion();

  if(var_1 == "IW8") {
    return;
  }
  if(!getdvarint("scr_autosave_showPrints")) {
    return;
  }
  if(getdvarint("debug_hud_disable") > 0) {
    return;
  }
  if(!isDefined(level.autosave.fail_huds))
    level.autosave.fail_huds = [];

  if(level.autosave.fail_huds.size == 3) {
    var_2 = level.autosave.fail_huds[0];
    level.autosave.fail_huds = scripts\engine\utility::array_remove_index(level.autosave.fail_huds, 0);
    autosave_hudfail_update();
    var_2 thread autosave_hudfail_destroy();
  }

  var_3 = newhudelem();
  var_3.elemtype = "font";
  var_3.font = "default";
  var_3.fontscale = 0.7;
  var_3.width = 0;
  var_3.height = int(8.4);
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_4 = level.autosave.fail_huds.size;
  level.autosave.fail_huds[var_4] = var_3;
  var_3.foreground = 1;
  var_3.sort = 20;
  var_3.x = 130;
  var_3.y = 5 + var_4 * 8.4;
  var_3.label = var_0;
  var_3.alpha = 0;
  var_3 fadeovertime(0.2);
  var_3.alpha = 1;
  var_3 endon("death");
  wait 5;
  level.autosave.fail_huds = scripts\engine\utility::array_remove(level.autosave.fail_huds, var_3);
  autosave_hudfail_update();
  var_3 thread autosave_hudfail_destroy();
}

autosave_hudfail_destroy() {
  var_0 = 1;
  self endon("death");
  self fadeovertime(0.1);
  self moveovertime(0.1);
  self.y = self.y - 8.4;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

autosave_hudfail_update() {
  level.autosave.fail_huds = scripts\engine\utility::array_removeundefined(level.autosave.fail_huds);

  foreach(var_2, var_1 in level.autosave.fail_huds) {
    var_1 moveovertime(0.1);
    var_1.y = 5 + var_2 * 12 * 0.7;
  }
}

_autosave_game_now(var_0, var_1) {
  if(scripts\sp\utility::is_trials_level())
    return 0;

  autosaveprint("_autosave_game_now() called...", 2);

  if(gettime() < 3300)
    autosaveprint("tryAutoSave() cannot save during before immediatelevelsave and beginningoflevelsave", 0);
  else {
    if(isDefined(level.missionfailed) && level.missionfailed)
      return 0;

    if(!isDefined(var_1) || !var_1)
      level notify("trying_new_autosave");

    if(scripts\engine\utility::flag("game_saving")) {
      autosaveprint("_autosave_game_now() game_saving in progress, aborting...", 0);
      return 0;
    }

    scripts\engine\utility::flag_set("game_saving");
    var_2 = waitfortransientloading("_autosave_game_now()");

    if(!isDefined(var_2)) {
      autosaveprint("_autosave_game_now() a newer save was called...", 0);
      scripts\engine\utility::flag_clear("game_saving");
      return 0;
    }

    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(!isalive(var_4))
        return 0;
    }

    var_5 = "save_now";
    var_6 = getdescription();

    if(getdvarint("reloading") != 0) {
      autosaveprint("_autosave_game_now() Game is restarting", 0);
      return 0;
    }

    if(isDefined(level.nextmission)) {
      autosaveprint("_autosave_game_now() Game is going to next mission", 0);
      return 0;
    }

    if(isDefined(var_0))
      var_7 = savegamenocommit(var_5, var_6, "$default", 1);
    else
      var_7 = savegamenocommit(var_5, var_6);

    autosaveprint("_autosave_game_now() Saving", undefined, var_7);
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

    if(var_7 < 0) {
      autosaveprint("_autosave_game_now() save error", 0, var_7);
      scripts\engine\utility::flag_clear("game_saving");
      return 0;
    }

    if(!try_to_autosave_now(var_7)) {
      scripts\engine\utility::flag_clear("game_saving");
      return 0;
    }

    wait 2;
    scripts\engine\utility::flag_clear("game_saving");

    if(isloadinganytransients()) {
      autosaveprint("_autosave_game_now() transient is loading, retrying (2)...", 0);
      return 0;
    }

    if(!commitwouldbevalid(var_7)) {
      autosaveprint("_autosave_game_now() SaveGame is no longer valid, another save was run from elsewhere", 0, var_7);
      return 0;
    }

    if(try_to_autosave_now(var_7)) {
      autosaveprint("_autosave_game_now() committed", 1, var_7);
      commitsave(var_7);
      level.player setplayeryolostate(0);
      setDvar("ui_grenade_death", "0");
      scripts\sp\gameskill::auto_adjust_save_committed();
    }
  }
}

autosave_now_trigger(var_0) {
  var_0 waittill("trigger");
  scripts\engine\sp\utility::autosave_now();
}

try_to_autosave_now(var_0) {
  if(!issavesuccessful())
    return 0;

  if(!level.player autosavehealthcheck(var_0))
    return 0;

  if(!scripts\engine\utility::flag("can_save")) {
    autosaveprint("Can_save flag was clear", 0, var_0);
    return 0;
  }

  return 1;
}

tryautosave(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(scripts\sp\utility::is_trials_level())
    return 0;

  autosaveprint("tryAutoSave() called filename=" + var_0, 2);

  if(gettime() < 3300)
    autosaveprint("tryAutoSave() cannot save during before immediatelevelsave and beginningoflevelsave", 0);
  else {
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

    if(isDefined(level.nextmission))
      return 0;

    var_7 = 0.05;
    var_8 = 1.25;
    var_9 = 1.25;

    if(isDefined(var_3) && var_3 < var_7 + var_8 + var_9) {}

    if(!isDefined(var_5))
      var_5 = 0;

    if(!isDefined(var_2))
      var_2 = "$default";

    if(!isDefined(var_4))
      var_4 = 0;

    scripts\engine\utility::flag_set("game_saving");
    var_10 = getdescription();
    var_11 = gettime();
    var_12 = undefined;

    if(isDefined(var_3))
      var_12 = gettime() + var_3 * 1000;

    var_13 = 0;
    var_14 = 0;

    for(;;) {
      if(scripts\engine\utility::flag("disable_autosaves")) {
        autosaveprint("tryAutoSave() autosaves disabled (2)", 0);
        break;
      }

      if(istrue(var_6) && var_13 > 0) {
        autosaveprint("tryAutoSave() Tried once and failed", 0);
        break;
      }

      if(isDefined(var_12) && gettime() > var_12) {
        autosaveprint("tryAutoSave() Autosave timed out after " + (gettime() - var_11) + " milliseconds", 0);
        break;
      }

      var_13++;

      if(autosavecheck(undefined, var_4)) {
        waitfortransientloading("tryAutoSave()");

        if(getdvarint("reloading") != 0) {
          autosaveprint("tryAutoSave() Game is restarting", 0);
          break;
        }

        if(isDefined(level.nextmission)) {
          autosaveprint("tryAutoSave() Game is going to next mission", 0);
          break;
        }

        var_15 = savegamenocommit(var_0, var_10, var_2, var_5);
        autosaveprint("tryAutoSave() Saving no commit", 2, var_15);

        if(var_15 < 0) {
          autosaveprint("tryAutoSave() save error", 0, var_15);
          break;
        }

        wait(var_7);

        if(isDefined(var_12) && gettime() > var_12) {
          autosaveprint("tryAutoSave() Autosave timed out after " + (gettime() - var_11) + " milliseconds", 0);
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

        wait(var_8);

        if(isDefined(var_12) && gettime() > var_12) {
          autosaveprint("tryAutoSave() Autosave timed out after " + (gettime() - var_11) + " milliseconds", 0);
          break;
        }

        if(isloadinganytransients()) {
          autosaveprint("tryAutoSave() transient is loading, retrying (2)...", 0);
          continue;
        }

        if(extra_autosave_checks_failed(var_15)) {
          continue;
        }
        if(!autosavecheck(undefined, var_4, var_15)) {
          autosaveprint("tryAutoSave() SaveGame invalid: 1.25 second check failed", 0, var_15);
          continue;
        }

        wait(var_9);

        if(isDefined(var_12) && gettime() > var_12) {
          autosaveprint("tryAutoSave() Autosave timed out after " + (gettime() - var_11) + " milliseconds", 0);
          break;
        }

        if(isloadinganytransients()) {
          autosaveprint("tryAutoSave() transient is loading, retrying (3)...", 0);
          continue;
        }

        if(!autosavecheck_not_picky(var_15)) {
          autosaveprint("tryAutoSave() SaveGame invalid: 2.5 second check failed", 0, var_15);
          continue;
        }

        if(!scripts\engine\utility::flag("can_save")) {
          autosaveprint("tryAutoSave() Can_save flag was clear", 0, var_15);
          break;
        }

        if(!commitwouldbevalid(var_15)) {
          autosaveprint("tryAutoSave() SaveGame is no longer valid, another save was run from elsewhere", 0, var_15);
          scripts\engine\utility::flag_clear("game_saving");
          return 0;
        }

        if(scripts\engine\utility::flag("disable_autosaves")) {
          autosaveprint("tryAutoSave() autosaves disabled (3)", 0);
          break;
        }

        var_14 = 1;
        autosaveprint("tryAutoSave() committed", 1, var_15);
        commitsave(var_15);
        level.player setplayeryolostate(0);
        level.lastsavetime = gettime();
        setDvar("ui_grenade_death", "0");
        scripts\sp\gameskill::auto_adjust_save_committed();
        break;
      }

      wait 0.25;
    }

    scripts\engine\utility::flag_clear("game_saving");
  }
}

startsavedprogression(var_0) {
  if(isprogressionlevel(var_0)) {
    if(isprogressionmismatch(var_0))
      proggressionmismatchpopup();
    else if(getdvarint("MSSSNONPLS") == 0) {
      level.player setplayerprogression("currentMission", var_0);
      var_1 = level.player getplayerprogression("missionStateData", var_0);

      if(var_1 == "locked")
        level.player setplayerprogression("missionStateData", var_0, "incomplete");
    }
  }
}

isprogressionmismatch(var_0) {
  var_1 = scripts\sp\endmission::getlevelindex(var_0);

  if(previouslevelcompleted(var_1) || isdevbuild())
    return 0;
  else
    return 1;

  return 0;
}

isprogressionlevel(var_0) {
  var_1 = scripts\sp\endmission::getlevelindex(var_0);
  return isDefined(var_1);
}

isdevbuild() {
  var_0 = 0;
  setdvarifuninitialized("scr_treat_progression_as_ship_build", 0);
  return var_0;
}

previouslevelcompleted(var_0) {
  if(var_0 == 0)
    return 1;

  var_0--;
  var_1 = level.missionsettings.levels[var_0].name;
  var_2 = level.player getplayerprogression("missionStateData", var_1);

  if(var_2 != "complete")
    return 0;
  else
    return 1;
}

waitfortransientloading(var_0) {
  level endon("trying_new_autosave");
  var_1 = 0;

  if(waspreloadzonesstarted()) {
    while(!ispreloadzonescomplete()) {
      if(gettime() > var_1)
        var_1 = gettime() + 2000;

      wait 0.05;
    }
  }

  while(isloadinganytransients()) {
    if(gettime() > var_1)
      var_1 = gettime() + 2000;

    wait 0.05;
  }

  return 1;
}

extra_autosave_checks_failed(var_0) {
  foreach(var_2 in level.autosave.extra_autosave_checks) {
    if(![[var_2["func"]]]()) {
      autosaveprint("Extra Autosave Check: " + var_2["msg"] + "", 0, var_0);
      return 1;
    }
  }

  return 0;
}

autosavecheck_not_picky(var_0) {
  return autosavecheck(0, 0, var_0);
}

autosavecheck(var_0, var_1, var_2) {
  if(isDefined(level.autosave_check_override))
    return [[level.autosave_check_override]]();

  if(isDefined(level.special_autosavecondition) && ![[level.special_autosavecondition]]()) {
    autosaveprint("autoSaveCheck() special_autosavecondition failed", 0);
    return 0;
  }

  if(level.missionfailed)
    return 0;

  if(!isDefined(var_0))
    var_0 = level.dopickyautosavechecks;

  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1) {
    if(![[level.global_callbacks["_autosave_stealthcheck"]]]())
      return 0;
  }

  if(!level.player autosavehealthcheck(var_2))
    return 0;

  if(var_0 && !level.player autosaveammocheck(var_2))
    return 0;

  if(level.autosave_threat_check_enabled) {
    if(!autosavethreatcheck(var_0, var_2))
      return 0;
  }

  if(!level.player autosaveplayercheck(var_0, var_2))
    return 0;

  if(!level.player autosavefriendlyfirecheck(var_2))
    return 0;

  if(level.player recentunresolvedcollision())
    return 0;

  if(!issavesuccessful()) {
    autosaveprint("autoSaveCheck() save call was unsuccessful", 0, var_2);
    return 0;
  }

  return 1;
}

autosaveplayercheck(var_0, var_1) {
  if(self ismeleeing() && var_0) {
    autosaveprint("player is meleeing", 0, var_1);
    return 0;
  }

  if(istrue(self.in_melee_death)) {
    autosaveprint("player is in context melee", 0, var_1);
    return 0;
  }

  if(self isthrowinggrenade()) {
    autosaveprint("player is throwing a grenade", 0, var_1);
    return 0;
  }

  if(isDefined(self.shellshocked) && self.shellshocked) {
    autosaveprint("player is in shellshock", 0, var_1);
    return 0;
  }

  if(!self islinked() && !scripts\sp\utility::in_zero_gravity() && !self isonground()) {
    if(scripts\engine\trace::_bullet_trace_passed(level.player.origin + (0, 0, 5), level.player.origin + (0, 0, -200), 0, self)) {
      autosaveprint("player is too high off the ground", 0, var_1);
      return 0;
    }
  }

  if(scripts\engine\utility::isflashed()) {
    autosaveprint("player is flashbanged", 0, var_1);
    return 0;
  }

  if(isDefined(self.hackingblockautosave) && self.hackingblockautosave == 1) {
    autosaveprint("player is controlling a hacked robot", 0, var_1);
    return 0;
  }

  return 1;
}

recentunresolvedcollision() {
  var_0 = gettime();

  if(isDefined(self.last_unresolved_collision_time) && var_0 - self.last_unresolved_collision_time < 500)
    return 1;

  return 0;
}

autosavefriendlyfirecheck(var_0) {
  var_1 = getEntArray("grenade", "classname");

  if(var_1.size == 0)
    return 1;

  var_2 = [];

  foreach(var_4 in var_1) {
    if(isvalidmissile(var_4) && isPlayer(getmissileowner(var_4)))
      var_2[var_2.size] = var_4;
  }

  if(var_2.size == 0)
    return 1;

  if(playernadessafe(var_2))
    return 1;

  var_6 = getaiarray("allies");

  foreach(var_8 in var_6) {
    foreach(var_10 in var_2) {
      if(distancesquared(var_8.origin, var_10.origin) < 6400) {
        autosaveprint("autoSaveFriendlyFireCheck() player nade is too close to friendlies", 0, var_0);
        return 0;
      }
    }
  }

  return 1;
}

playernadessafe(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\sp\utility::offhand_is_dangerous(var_2))
      return 0;
  }

  return 1;
}

autosaveammocheck(var_0) {
  var_1 = self getweaponslistprimaries();

  if(var_1.size == 0)
    return 1;

  var_2 = 1;
  var_3 = 0;
  var_4 = "";

  foreach(var_6 in var_1) {
    if(nullweapon(var_6)) {
      continue;
    }
    if(weaponmaxammo(var_6) > 0)
      var_2 = 0;

    var_7 = self getweaponammoclip(var_6);
    var_8 = weaponclipsize(var_6);
    var_9 = self getweaponammostock(var_6);
    var_10 = weaponmaxammo(var_6);
    var_11 = var_7 + var_9;
    var_12 = var_8 + var_10;

    if(var_12 <= 0) {
      continue;
    }
    var_13 = var_11 / var_12;
    var_14 = 0.0714286;

    if(var_13 > var_3) {
      var_3 = var_13;
      var_4 = var_6.classname;

      if(var_6.classname == "grenade" || var_6.classname == "rocketlauncher") {
        var_14 = 0.5;
        var_4 = "explosive";
      }
    }

    if(var_13 >= var_14)
      return 1;
  }

  if(var_2)
    return 1;

  autosaveprint("Highest stock+clip ammo fraction: " + var_3 + " for " + var_4 + " weapon. Too low to save.", 0, var_0);
  return 0;
}

autosavehealthcheck(var_0) {
  if(scripts\sp\player::belowcriticalhealththreshold()) {
    autosaveprint("player is below critical health threshold", 0, var_0);
    return 0;
  }

  if(istrue(self.damage.firedamage)) {
    autosaveprint("player is on fire!", 0, var_0);
    return 0;
  }

  if(self isonladder()) {
    autosaveprint("player is on ladder! TU1 HACK!", 0, var_0);
    return 0;
  }

  return 1;
}

autosavethreatcheck(var_0, var_1) {
  var_2 = getaiunittypearray("bad_guys", "all");

  foreach(var_4 in var_2) {
    if(isDefined(level.player.stealth) && isDefined(var_4.stealth) && var_4.threatsight && var_4 getthreatsight(level.player) > 0) {
      autosaveprint("AI cansee player, stealth meter is up", 0, var_1);
      return 0;
    }

    if(!isDefined(var_4.enemy)) {
      continue;
    }
    if(!isPlayer(var_4.enemy)) {
      if(level.autosave.enemydistcheck && var_4 playermaybecomemyenemy()) {
        autosaveprint("Player close to AI's enemy", 0, var_1);
        return 0;
      }
    } else {
      if(isDefined(var_4.melee) && isDefined(var_4.melee.target) && isPlayer(var_4.melee.target)) {
        autosaveprint("AI meleeing player", 0, var_1);
        return 0;
      }

      var_5 = [[level.autosave.proximity_threat_func]](var_4);

      if(var_5 == "return_even_if_low_accuracy") {
        autosaveprint("AI too close to player, so close we're ignoring his accuracy", 0, var_1);
        return 0;
      }

      if(var_4.finalaccuracy < 0.021 && var_4.finalaccuracy > -1) {
        continue;
      }
      if(var_5 == "none") {
        continue;
      }
      var_6 = undefined;
      var_7 = var_4.a.lastshoottime > gettime() - 1500;

      if(var_7) {
        var_6 = var_4 getcanshootandsee();

        if(var_6) {
          autosaveprint("AI firing on player", 0, var_1);
          return 0;
        }
      }

      if(!isDefined(var_6))
        var_6 = var_4 getcanshootandsee();

      if(isDefined(var_4.asm.trackasm) && var_4 scripts\asm\asm::asm_currentstatehasflag(var_4.asm.trackasm, "aim") && var_6) {
        autosaveprint("AI aiming at player", 0, var_1);
        return 0;
      } else
        continue;
    }
  }

  if(scripts\sp\equipment\tripwire::playerintripwiredangerzone()) {
    autosaveprint("player in tripwire danager zone", 0);
    return 0;
  }

  if(scripts\sp\utility::player_is_near_live_offhand())
    return 0;

  if(isDefined(level.phys_barrels)) {
    foreach(var_10 in level.phys_barrels) {
      if(!isDefined(var_10.onfire)) {
        continue;
      }
      if(var_10.subtype == "antigrav") {
        continue;
      }
      if(distancesquared(var_10.origin, level.player.origin) < 122500) {
        autosaveprint(var_10.subtype + " barrel is onfire and too close to player", 0, var_1);
        return 0;
      }
    }
  }

  var_12 = getEntArray("scriptable", "code_classname");

  foreach(var_14 in var_12) {
    if(!isDefined(var_14.destructible_type) || var_14.destructible_type != "vehicle") {
      continue;
    }
    if(!isDefined(var_14.onfire)) {
      continue;
    }
    if(distancesquared(var_14.origin, level.player.origin) < 160000) {
      autosaveprint("burning car too close to player", 0, var_1);
      return 0;
    }
  }

  return 1;
}

playermaybecomemyenemy() {
  if(isalive(self.enemy) && distancesquared(self.enemy.origin, level.player.origin) < 40000)
    return 1;

  if(isalive(self.enemy) && self cansee(level.player)) {
    var_0 = distancesquared(self.enemy.origin, self.origin);
    var_1 = distancesquared(level.player.origin, self.origin);

    if(var_1 <= var_0 + 200)
      return 1;
  }

  return 0;
}

getcanshootandsee() {
  return scripts\anim\utility_common.gsc::canseeenemy(0) && self canshootenemy(0);
}

enemy_is_a_threat() {
  if(self.finalaccuracy >= 0.021)
    return 1;

  foreach(var_1 in level.players) {
    if(distance(self.origin, var_1.origin) < 500)
      return 1;
  }

  return 0;
}

autosave_proximity_threat_func(var_0) {
  foreach(var_2 in level.players) {
    var_3 = distancesquared(var_0.origin, var_2.origin);

    if(var_3 < 10000)
      return "return_even_if_low_accuracy";
    else if(var_3 < 129600)
      return "return";
    else if(var_3 < 1000000)
      return "threat_exists";
  }

  return "none";
}