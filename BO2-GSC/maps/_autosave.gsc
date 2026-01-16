/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_autosave.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_laststand;
#include animscripts\utility;

main() {
  level.lastautosavetime = 0;
  flag_init("game_saving");
  flag_init("can_save", 1);
}

block_save() {
  if(!isDefined(level.block_save_count))
    level.block_save_count = 0;

  level.block_save_count++;
  flag_clear("can_save");
}

allow_save() {
  if(!isDefined(level.block_save_count))
    level.block_save_count = 0;

  if(level.block_save_count > 0)
    level.block_save_count--;

  if(level.block_save_count == 0)
    flag_set("can_save");
}

autosave_description() {
  return & "AUTOSAVE_AUTOSAVE";
}

autosave_names(num) {
  if(num == 0)
    savedescription = & "AUTOSAVE_GAME";
  else
    savedescription = & "AUTOSAVE_NOGAME";

  return savedescription;
}

start_level_save() {
  flag_wait("all_players_connected");
  flag_wait("starting final intro screen fadeout");
  wait 0.5;
  players = get_players();
  players[0] player_flag_wait("loadout_given");

  if(level.createfx_enabled) {
    return;
  }
  if(level.missionfailed) {
    return;
  }
  if(flag("game_saving")) {
    return;
  }
  flag_set("game_saving");
  imagename = "levelshots/autosave/autosave_" + level.script + "start";

  for(i = 0; i < players.size; i++)
    players[i].savedvisionset = players[i] getvisionsetnaked();

  auto_save_print("start_level_save: Start of level save");

  savegame("levelstart", 0, & "AUTOSAVE_LEVELSTART", imagename, 1);
  setdvar("ui_grenade_death", "0");

  println("Saving level start saved game");

  flag_clear("game_saving");
}

trigger_autosave(trigger) {
  if(!isDefined(trigger.script_autosave))
    trigger.script_autosave = 0;

  autosave_think(trigger);
}

autosave_think(trigger) {
  trigger waittill("trigger", ent);
  num = trigger.script_autosave;
  imagename = "levelshots/autosave/autosave_" + level.script + num;
  try_auto_save(num, imagename, ent);

  if(isDefined(trigger)) {
    wait 2;
    trigger delete();
  }
}

autosave_name_think(trigger) {
  trigger endon("death");
  trigger trigger_wait();

  if(isDefined(level.customautosavecheck)) {
    if(![
        [level.customautosavecheck]
      ]())
      return;
  }

  maps\_utility::set_breadcrumbs_player_positions();
  maps\_utility::autosave_by_name(trigger.script_autosavename);
}

trigger_autosave_immediate(trigger) {
  trigger waittill("trigger");
}

auto_save_print(msg, msg2) {
  msg = " AUTOSAVE: " + msg;

  if(getdvar(#"_id_FD22913A") == "")
    setdvar("scr_autosave_debug", "0");

  if(getdebugdvarint("scr_autosave_debug") == 1) {
    if(isDefined(msg2))
      println(msg + "[localized description]");
    else
      println(msg);

    return;
  }

  if(isDefined(msg2))
    println(msg, msg2);
  else
    println(msg);
}

autosave_game_now(suppress_print) {
  if(flag("game_saving"))
    return false;

  if(!isalive(get_host()))
    return false;

  filename = "save_now";
  descriptionstring = autosave_description();
  players = get_players();

  for(i = 0; i < players.size; i++)
    players[i].savedvisionset = players[i] getvisionsetnaked();

  if(isDefined(suppress_print))
    saveid = savegamenocommit(filename, descriptionstring, "$default", 1);
  else
    saveid = savegamenocommit(filename, descriptionstring);

  wait 0.05;

  if(issaverecentlyloaded()) {
    auto_save_print("autosave_game_now: FAILED!!! -> save error - recently loaded.");

    level.lastautosavetime = gettime();
    return false;
  }

  auto_save_print("autosave_game_now: Saving game " + filename + " with desc ", descriptionstring);

  if(saveid < 0) {
    auto_save_print("autosave_game_now: FAILED!!! -> save error.: " + filename + " with desc ", descriptionstring);

    return false;
  }

  if(!try_to_autosave_now())
    return false;

  flag_set("game_saving");
  wait 0.5;

  if(try_to_autosave_now()) {
    level notify("save_success");
    commitsave(saveid);
    setdvar("ui_grenade_death", "0");
  }

  flag_clear("game_saving");
  return true;
}

autosave_now_trigger(trigger) {
  trigger waittill("trigger");
  autosave_now();
}

try_to_autosave_now() {
  if(!issavesuccessful())
    return false;

  if(!autosave_health_check())
    return false;

  if(!flag("can_save")) {
    auto_save_print("try_to_autosave_now: Can_save flag was clear");

    return false;
  }

  return true;
}

autosave_check_simple() {
  if(isDefined(level.special_autosavecondition) && ![
      [level.special_autosavecondition]
    ]())
    return false;

  if(level.missionfailed)
    return false;

  if(maps\_laststand::player_any_player_in_laststand())
    return false;

  if(isDefined(level.savehere) && !level.savehere)
    return false;

  if(isDefined(level.cansave) && !level.cansave)
    return false;

  if(!flag("can_save"))
    return false;

  return true;
}

try_auto_save(filename, image, ent) {
  if(!flag("all_players_connected")) {
    flag_wait("all_players_connected");
    wait 3;
  }

  level endon("save_success");
  flag_waitopen("game_saving");
  flag_wait("can_save");
  flag_set("game_saving");
  descriptionstring = autosave_description();

  if(!isDefined(ent))
    ent = get_players()[0];

  maps\_utility::set_breadcrumbs_player_positions();

  while(true) {
    if(issaverecentlyloaded()) {
      level.lastautosavetime = gettime();
      break;
    }

    if(autosave_check() && !issaverecentlyloaded()) {
      players = get_players();

      for(i = 0; i < players.size; i++)
        players[i].savedvisionset = players[i] getvisionsetnaked();

      level.checkpoint_time = gettime();
      saveid = savegamenocommit(filename, descriptionstring, image, coopgame());

      if(!isDefined(saveid) || saveid < 0) {
        flag_clear("game_saving");
        return false;
      }

      wait 6;
      retries = 0;

      while(retries < 8) {
        if(autosave_check_simple()) {
          commitsave(saveid);
          level.lastsavetime = gettime();
          setdvar("ui_grenade_death", "0");
          flag_clear("game_saving");
          return true;
        }

        retries++;
        wait 2;
      }

      flag_clear("game_saving");
      return false;
    }

    wait 1;
  }

  flag_clear("game_saving");
  return false;
}

autosave_check(dopickychecks) {
  if(isDefined(level.special_autosavecondition) && ![
      [level.special_autosavecondition]
    ]())
    return false;

  if(level.missionfailed)
    return false;

  if(maps\_laststand::player_any_player_in_laststand())
    return false;

  if(!isDefined(dopickychecks))
    dopickychecks = 1;

  if(!autosave_health_check())
    return false;

  if(!autosave_threat_check(dopickychecks))
    return false;

  if(!autosave_player_check())
    return false;

  if(isDefined(level.dont_save_now) && level.dont_save_now)
    return false;

  if(!flag("can_save"))
    return false;

  if(!issavesuccessful()) {
    auto_save_print("autosave_check: FAILED!!! -> save call was unsuccessful");

    return false;
  }

  return true;
}

autosave_player_check() {
  host = get_host();

  if(host ismeleeing()) {
    auto_save_print("autosave_player_check: FAILED!!! -> host is meleeing");

    return false;
  }

  if(host isthrowinggrenade() && host getcurrentoffhand() != "molotov") {
    auto_save_print("autosave_player_check: FAILED!!! -> host is throwing a grenade");

    return false;
  }

  if(host isfiring()) {
    auto_save_print("autosave_player_check: FAILED!!! -> host is firing");

    return false;
  }

  if(isDefined(host.shellshocked) && host.shellshocked) {
    auto_save_print("autosave_player_check: FAILED!!! -> host is in shellshock");

    return false;
  }

  return true;
}

autosave_health_check() {
  players = get_players();

  if(players.size > 1) {
    for(i = 1; i < players.size; i++) {
      if(players[i] player_flag("player_has_red_flashing_overlay")) {
        auto_save_print("autosave_health_check: FAILED!!! -> player " + i + " has red flashing overlay");

        return false;
      }
    }
  }

  host = get_host();
  healthfraction = host.health / host.maxhealth;

  if(healthfraction < 0.5) {
    auto_save_print("autosave_health_check: FAILED!!! -> host health too low");

    return false;
  }

  if(host player_flag("player_has_red_flashing_overlay")) {
    auto_save_print("autosave_health_check: FAILED!!! -> host has red flashing overlay");

    return false;
  }

  return true;
}

autosave_threat_check(dopickychecks) {
  if(level.script == "see2")
    return true;

  host = get_host();
  enemies = getaispeciesarray("axis", "all");

  for(i = 0; i < enemies.size; i++) {
    if(!isDefined(enemies[i].enemy)) {
      continue;
    }
    if(enemies[i].enemy != host) {
      continue;
    }
    if(enemies[i].isdog) {
      if(distancesquared(enemies[i].origin, host.origin) < 147456) {
        auto_save_print("autosave_threat_check: FAILED!!! -> dog near player");

        return false;
      }
    } else {
      if(enemies[i].a.lastshoottime > gettime() - 500) {
        if(dopickychecks || enemies[i] canshootenemy(0)) {
          auto_save_print("autosave_threat_check: FAILED!!! -> AI firing on player");

          return false;
        }
      }

      if(isDefined(enemies[i].a.isaiming) && enemies[i].a.isaiming || isDefined(enemies[i].corneraiming) && enemies[i].corneraiming) {
        if(enemies[i] animscripts\utility::canseeenemy() && enemies[i] canshootenemy(0)) {
          auto_save_print("autosave_threat_check: FAILED!!! -> AI aiming at player");

          return false;
        }
      }

      if(isDefined(enemies[i].a.personimmeleeing) && enemies[i].a.personimmeleeing == host) {
        auto_save_print("autosave_threat_check: FAILED!!! -> AI meleeing player");

        return false;
      }
    }
  }

  if(player_is_near_live_grenade())
    return false;

  return true;
}