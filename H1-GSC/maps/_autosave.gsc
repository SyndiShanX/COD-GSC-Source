/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_autosave.gsc
********************************/

main() {
  level.lastautosavetime = 0;
  level.lasttimeplayedregister = 0;
  common_scripts\utility::flag_init("game_saving");
  common_scripts\utility::flag_init("being_spotted");
  common_scripts\utility::flag_init("can_save");
  common_scripts\utility::flag_set("can_save");
  common_scripts\utility::flag_init("disable_autosaves");

  if(!isdefined(level._extra_autosave_checks))
    level._extra_autosave_checks = [];

  level.autosave_proximity_threat_func = ::autosave_proximity_threat_func;
}

getdescription() {
  return & "AUTOSAVE_AUTOSAVE";
}

getnames(var_0) {
  if(var_0 == 0)
    var_1 = & "AUTOSAVE_GAME";
  else
    var_1 = & "AUTOSAVE_NOGAME";

  return var_1;
}

beginningoflevelsave() {
  common_scripts\utility::flag_wait("introscreen_complete");

  if(isdefined(level.introscreen_complete_delay))
    wait(level.introscreen_complete_delay);

  if(level.missionfailed) {
    return;
  }
  if(maps\_arcademode::arcademode_complete()) {
    return;
  }
  if(common_scripts\utility::flag("game_saving")) {
    return;
  }
  common_scripts\utility::flag_set("game_saving");
  var_0 = "levelshots / autosave / autosave_" + level.script + "start";
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", var_0, 1);
  setdvar("ui_grenade_death", "0");
  common_scripts\utility::flag_clear("game_saving");
}

trigger_autosave_stealth(var_0) {
  var_0 waittill("trigger");
  maps\_utility::autosave_stealth();
}

trigger_autosave_tactical(var_0) {
  var_0 waittill("trigger");
  maps\_utility::autosave_tactical();
}

trigger_autosave(var_0) {
  if(!isdefined(var_0.script_autosave))
    var_0.script_autosave = 0;

  autosaves_think(var_0);
}

autosaves_think(var_0) {
  var_1 = getnames(var_0.script_autosave);

  if(!isdefined(var_1)) {
    return;
  }
  var_0 waittill("trigger");
  var_2 = var_0.script_autosave;
  var_3 = "levelshots / autosave / autosave_" + level.script + var_2;
  tryautosave(var_2, var_1, var_3);

  if(isdefined(var_0))
    var_0 delete();
}

autosavenamethink(var_0) {
  if(maps\_utility::is_no_game_start()) {
    return;
  }
  var_0 waittill("trigger");

  if(!isdefined(var_0)) {
    return;
  }
  var_1 = var_0.script_autosavename;
  var_0 delete();

  if(isdefined(level.customautosavecheck)) {
    if(![
        [level.customautosavecheck]
      ]())
      return;
  }

  maps\_utility::autosave_by_name(var_1);
}

trigger_autosave_immediate(var_0) {
  var_0 waittill("trigger");
}

autosaveprint(var_0, var_1) {
  if(isdefined(var_1)) {
    return;
  }
  return;
}

autosave_timeout(var_0) {
  level endon("trying_new_autosave");
  level endon("autosave_complete");
  wait(var_0);
  common_scripts\utility::flag_clear("game_saving");
  level notify("autosave_timeout");
}

_autosave_game_now_nochecks() {
  var_0 = "levelshots / autosave / autosave_" + level.script + "start";
  savegame("levelstart", & "AUTOSAVE_LEVELSTART", var_0, 1);
  autosave_recon(0);
}

_autosave_game_now_notrestart() {
  var_0 = "levelshots / autosave / autosave_" + level.script + "start";

  if(getdvarint("g_reloading") == 0) {
    savegame("levelstart", & "AUTOSAVE_LEVELSTART", var_0, 1);
    autosave_recon(0);
  }
}

_autosave_game_now(var_0) {
  if(isdefined(level.missionfailed) && level.missionfailed) {
    return;
  }
  if(common_scripts\utility::flag("game_saving"))
    return 0;

  if(maps\_arcademode::arcademode_complete())
    return 0;

  for (var_1 = 0; var_1 < level.players.size; var_1++) {
    var_2 = level.players[var_1];

    if(!isalive(var_2))
      return 0;
  }

  var_3 = "save_now";
  var_4 = getdescription();

  if(isdefined(var_0))
    var_5 = savegamenocommit(var_3, var_4, "$default", 1);
  else
    var_5 = savegamenocommit(var_3, var_4);

  wait 0.05;

  if(issaverecentlyloaded()) {
    level.lastautosavetime = gettime();
    level.lasttimeplayedregister = level.lastautosavetime;
    return 0;
  }

  if(var_5 < 0)
    return 0;

  if(!try_to_autosave_now())
    return 0;

  common_scripts\utility::flag_set("game_saving");
  wait 2;
  common_scripts\utility::flag_clear("game_saving");

  if(!commitwouldbevalid(var_5))
    return 0;

  if(try_to_autosave_now()) {
    autosave_recon(var_5);

    if(!isdefined(var_0))
      thread maps\_arcademode::arcademode_checkpoint_print();

    commitsave(var_5);
    level.timeplayeddelta = gettime();
    setdvar("ui_grenade_death", "0");
  }

  return 1;
}

autosave_now_trigger(var_0) {
  var_0 waittill("trigger");
  maps\_utility::autosave_now();
}

try_to_autosave_now() {
  if(!issavesuccessful())
    return 0;

  for (var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(!var_1 autosavehealthcheck())
      return 0;
  }

  if(!common_scripts\utility::flag("can_save"))
    return 0;

  return 1;
}

tryautosave(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(common_scripts\utility::flag("disable_autosaves"))
    return 0;

  level endon("nextmission");
  level.player endon("death");

  if(maps\_utility::is_coop())
    level.player2 endon("death");

  level notify("trying_new_autosave");

  if(common_scripts\utility::flag("game_saving"))
    return 0;

  if(isdefined(level.nextmission))
    return 0;

  var_7 = 1.25;
  var_8 = 1.25;

  if(isdefined(var_3) && var_3 < var_7 + var_8) {}

  if(!isdefined(var_5))
    var_5 = 0;

  if(!isdefined(var_2))
    var_2 = "$default";

  if(!isdefined(var_4))
    var_4 = 0;

  common_scripts\utility::flag_set("game_saving");
  var_9 = getdescription();
  var_10 = gettime();

  for (;;) {
    if(autosavecheck(undefined, var_4)) {
      var_11 = savegamenocommit(var_0, var_9, var_2, var_5);

      if(var_11 < 0) {
        break;
      }

      wait 0.05;

      if(issaverecentlyloaded()) {
        level.lastautosavetime = gettime();
        level.lasttimeplayedregister = level.lastautosavetime;
        break;
      }

      wait(var_7);

      if(!autosavecheck(undefined, var_4)) {
        continue;
      }
      wait(var_8);

      if(!autosavecheck_not_picky()) {
        continue;
      }
      if(isdefined(var_3)) {
        if(gettime() > var_10 + var_3 * 1000) {
          break;
        }
      }

      if(!common_scripts\utility::flag("can_save")) {
        break;
      }

      if(common_scripts\utility::flag("being_spotted")) {
        break;
      }

      if(!commitwouldbevalid(var_11)) {
        common_scripts\utility::flag_clear("game_saving");
        return 0;
      }

      if(level.script == "scoutsniper" && isdefined(var_6) && var_6 == "cargo2") {
        if(common_scripts\utility::flag("_stealth_spotted"))
          continue;
      }

      autosave_recon(var_11);
      thread maps\_arcademode::arcademode_checkpoint_print();
      commitsave(var_11);
      maps\_utility::save_time_played();
      level.lastsavetime = gettime();
      level.lasttimeplayedregister = gettime();
      setdvar("ui_grenade_death", "0");
      break;
    }

    wait 0.25;
  }

  common_scripts\utility::flag_clear("game_saving");
  return 1;
}

extra_autosave_checks_failed() {
  foreach(var_1 in level._extra_autosave_checks) {
    if(![
        [var_1["func"]]
      ]()) {
      autosaveprint("autosave failed: " + var_1["msg"]);
      return 1;
    }
  }

  return 0;
}

autosavecheck_not_picky() {
  return autosavecheck(0, 0);
}

autosavecheck(var_0, var_1) {
  if(isdefined(level.autosave_check_override))
    return [
      [level.autosave_check_override]
    ]();

  if(isdefined(level.special_autosavecondition) && ![
      [level.special_autosavecondition]
    ]())
    return 0;

  if(level.missionfailed)
    return 0;

  if(maps\_arcademode::arcademode_complete())
    return 0;

  if(!isdefined(var_0))
    var_0 = level.dopickyautosavechecks;

  if(!isdefined(var_1))
    var_1 = 0;

  if(var_1) {
    if(![
        [level.global_callbacks["_autosave_stealthcheck"]]
      ]())
      return 0;
  }

  for (var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(!var_3 autosavehealthcheck())
      return 0;

    if(var_0 && !var_3 autosaveammocheck())
      return 0;
  }

  if(level.autosave_threat_check_enabled) {
    if(!autosavethreatcheck(var_0))
      return 0;
  }

  for (var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(!var_3 autosaveplayercheck(var_0))
      return 0;
  }

  if(isdefined(level.cansave) && !level.cansave)
    return 0;

  if(extra_autosave_checks_failed())
    return 0;

  if(!issavesuccessful()) {
    autosaveprint("autosave failed: save call was unsuccessful");
    return 0;
  }

  return 1;
}

autosaveplayercheck(var_0) {
  if(level.script == "ac130")
    return 1;

  if(isdefined(level.ac130gunner) && level.ac130gunner == self)
    return 1;

  if(self ismeleeing() && var_0) {
    autosaveprint("autosave failed:player is meleeing");
    return 0;
  }

  if(self isthrowinggrenade() && var_0) {
    autosaveprint("autosave failed:player is throwing a grenade");
    return 0;
  }

  if(self isfiring() && var_0) {
    autosaveprint("autosave failed:player is firing");
    return 0;
  }

  if(isdefined(self.shellshocked) && self.shellshocked) {
    autosaveprint("autosave failed:player is in shellshock");
    return 0;
  }

  if(common_scripts\utility::isflashed()) {
    autosaveprint("autosave failed:player is flashbanged");
    return 0;
  }

  return 1;
}

autosaveammocheck() {
  if(isdefined(level.noautosaveammocheck) && level.noautosaveammocheck)
    return 1;

  if(level.script == "ac130")
    return 1;

  if(isdefined(level.ac130gunner) && level.ac130gunner == self)
    return 1;

  var_0 = self getweaponslistprimaries();

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = self getfractionmaxammo(var_0[var_1]);

    if(var_2 > 0.1)
      return 1;
  }

  autosaveprint("autosave failed: ammo too low");
  return 0;
}

autosavehealthcheck() {
  if(level.script == "ac130")
    return 1;

  if(isdefined(level.ac130gunner) && level.ac130gunner == self)
    return 1;

  if(maps\_utility::ent_flag_exist("laststand_downed") && maps\_utility::ent_flag("laststand_downed"))
    return 0;

  var_0 = self.health / self.maxhealth;

  if(var_0 < 0.5)
    return 0;

  if(maps\_utility::ent_flag("_radiation_poisoning"))
    return 0;

  if(maps\_utility::ent_flag("player_has_red_flashing_overlay"))
    return 0;

  return 1;
}

autosavethreatcheck(var_0) {
  if(level.script == "ac130")
    return 1;

  if(isdefined(level.ac130gunner) && level.ac130gunner == self)
    return 1;

  var_1 = getaispeciesarray("bad_guys", "all");

  foreach(var_3 in var_1) {
    if(!isdefined(var_3.enemy)) {
      continue;
    }
    if(!isplayer(var_3.enemy)) {
      continue;
    }
    if(var_3.type == "dog") {
      foreach(var_5 in level.players) {
        if(distance(var_3.origin, var_5.origin) < 384)
          return 0;
      }

      continue;
    }

    if(isdefined(var_3.melee) && isdefined(var_3.melee.target) && isplayer(var_3.melee.target))
      return 0;

    var_7 = [
      [level.autosave_proximity_threat_func]
    ](var_3);

    if(var_7 == "return_even_if_low_accuracy")
      return 0;

    if(var_3.finalaccuracy < 0.021 && var_3.finalaccuracy > -1) {
      continue;
    }
    if(var_7 == "return")
      return 0;

    if(var_7 == "none") {
      continue;
    }
    if(var_3.a.lastshoottime > gettime() - 500) {
      if(var_0 || var_3 animscripts\utility::canseeenemy(0) && var_3 canshootenemy(0))
        return 0;
    }

    if(isdefined(var_3.a.aimidlethread) && var_3 animscripts\utility::canseeenemy(0) && var_3 canshootenemy(0))
      return 0;
  }

  if(maps\_utility::player_is_near_live_grenade())
    return 0;

  var_9 = getentarray("destructible", "classname");

  foreach(var_11 in var_9) {
    if(!isdefined(var_11.healthdrain)) {
      continue;
    }
    foreach(var_5 in level.players) {
      if(distance(var_11.origin, var_5.origin) < 400)
        return 0;
    }
  }

  return 1;
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
    var_3 = distance(var_0.origin, var_2.origin);

    if(var_3 < 200)
      return "return_even_if_low_accuracy";
    else if(var_3 < 360)
      return "return";
    else if(var_3 < 1000)
      return "threat_exists";
  }

  return "none";
}

autosave_recon(var_0) {
  if(!maps\_utility::is_default_start()) {
    return;
  }
  var_1 = maps\_utility_code::get_leveltime();
  var_2 = var_1;

  if(isdefined(level.recon_checkpoint_lasttime))
    var_2 = var_1 - level.recon_checkpoint_lasttime;

  level.recon_checkpoint_lasttime = var_1;
  reconevent("script_checkpoint: id %d, leveltime %d, deltatime %d", var_0, var_1, var_2);
}