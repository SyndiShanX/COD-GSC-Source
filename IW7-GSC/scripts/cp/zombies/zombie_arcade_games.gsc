/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_arcade_games.gsc
******************************************************/

func_211C() {
  wait(10);
  if(getDvar("zmb_arcade_test") != "") {
    setDvar("debug_pause_spawning", 1);
    var_0 = scripts\engine\utility::getStructArray("dance_floor_attract_spots", "targetname");
    level.players[0] setorigin(var_0[0].origin);
    level.players[0] setplayerangles(var_0[0].angles);
    wait(3);
  }
}

use_arcade_game(var_0, var_1) {
  var_1 endon("disconnect");
  if(var_1 getstance() != "stand") {
    var_1 scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_MUST_BE_STANDING");
    var_1 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  var_1 endon("last_stand");
  var_1 endon("player_exit_afterlife");
  var_1 endon("spawned");
  var_1.no_team_outlines = 1;
  if(scripts\cp\cp_laststand::player_in_laststand(var_1) && !scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    return;
  }

  scripts\cp\zombies\arcade_game_utility::set_arcade_game_award_type(var_1);
  var_1.playing_game = 1;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level thread func_61D6(var_1, var_0);
  level thread func_5653(var_1, var_0);
  if(scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    level thread func_61D8(var_1, var_0);
  } else {
    level thread func_61D7(var_1, var_0);
  }

  level thread func_5FB8(var_1, var_0);
  var_1 setplayerangles(var_0.angles + (29, 0, 0));
  var_1 setorigin(var_0.origin, 0);
  var_1.anchor = spawn("script_model", var_1.origin);
  var_1.anchor setModel("tag_origin");
  var_1 playerlinkto(var_1.anchor, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_1.anchor.angles = var_0.angles + (29, 0, 0);
  var_1.anchor.origin = scripts\engine\utility::getstruct(var_0.target, "targetname").origin + scripts\cp\utility::vec_multiply(anglesToForward(var_0.angles), 3);
  if(!scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    var_1 scripts\engine\utility::allow_weapon(0);
  }

  var_1 scripts\engine\utility::allow_weapon_switch(0);
  var_1.disable_consumables = 1;
  var_1 playlocalsound("arcadeSound");
  var_2 = var_0.script_noteworthy;
  if(var_0.script_noteworthy == "arcade_starmaster") {
    var_2 = "arcade_chopper";
  }

  while(var_1 useButtonPressed()) {
    wait(0.05);
  }

  var_1 setclientomnvar("zm_arcade_emulator", var_2);
  var_1 lerpfovbypreset("zombiearcade");
  var_1 setclientomnvar("zombie_arcade_game_time", 1);
  var_1 setclientomnvar("zombie_arcade_widget", 1);
  var_1 scripts\cp\zombies\achievement::update_achievement_arcade(var_1, var_0.script_noteworthy, level.wave_num);
  wait(0.25);
  if(isDefined(var_0.script_index)) {
    var_3 = getent(var_0.name, "targetname");
    var_4 = var_0.script_index;
    var_3 setscriptablepartstate("cab" + var_4, "emulated");
  } else if(isDefined(var_0.groupname)) {
    var_3 = getent(var_0.groupname, "targetname");
    var_3 setscriptablepartstate(var_0.name, "emulated");
  }

  for(;;) {
    var_1 waittill("adjustedStance");
    if(var_1 gettimeremainingpercentage()) {
      continue;
    } else {
      break;
    }
  }

  var_1 notify("exit_arcade_game");
  var_1 setclientomnvar("zm_arcade_emulator", "arcade_off");
  var_1 stoplocalsound("arcadeSound");
  if(isDefined(var_0.script_index)) {
    var_3 = getent(var_0.name, "targetname");
    var_4 = var_0.script_index;
    var_3 setscriptablepartstate("cab" + var_4, "idle");
  } else if(isDefined(var_0.groupname)) {
    var_3 = getent(var_0.groupname, "targetname");
    var_3 setscriptablepartstate(var_0.name, "idle");
  }

  var_1 setstance("stand");
  var_1 setplayerangles(var_0.angles);
  if(!var_1 scripts\engine\utility::isweaponswitchallowed()) {
    var_1 scripts\engine\utility::allow_weapon_switch(1);
  }

  if(!scripts\engine\utility::istrue(var_1.in_afterlife_arcade) && !var_1 scripts\engine\utility::isweaponallowed()) {
    var_1 scripts\engine\utility::allow_weapon(1);
  }

  var_1 setmovespeedscale(1);
  var_1 lerpfovbypreset("zombiedefault");
  var_1 setclientomnvar("zombie_arcade_widget", 0);
  var_1 setclientomnvar("zombie_arcade_game_time", -1);
  wait(0.5);
  var_1 allowcrouch(1);
  var_1 allowprone(1);
  var_1.disable_consumables = undefined;
  wait(2);
  var_1.playing_game = undefined;
  var_1.no_team_outlines = 0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

func_5FB8(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("arcade_special_interrupt");
  level thread func_211A(var_0);
  var_0 scripts\cp\utility::allow_player_interactions(0);
  var_2 = var_0 scripts\engine\utility::waittill_any_return("exit_arcade_game", "player_exit_afterlife", "last_stand", "revive");
  if(!isDefined(var_0) || !isDefined(var_0.anchor)) {
    return;
  }

  var_0 notify("stop_arcade_timer");
  var_0 playanimscriptevent("power_active_cp", "gesture001");
  var_0.anchor.angles = var_1.angles;
  var_3 = scripts\cp\utility::vec_multiply(anglesToForward(var_1.angles), -15);
  var_0.anchor.origin = scripts\engine\utility::getstruct(var_1.target, "targetname").origin + (0, 0, 1) + var_3;
  wait(0.1);
  var_0.anchor delete();
  var_0 unlink();
  wait(1.5);
  if(!var_0 scripts\cp\utility::areinteractionsenabled()) {
    var_0 scripts\cp\utility::allow_player_interactions(1);
  }
}

func_211A(var_0) {
  var_0 endon("stop_arcade_timer");
  var_0 endon("disconnect");
  var_0 endon("arcade_special_interrupt");
  if(!isDefined(var_0.var_2113)) {
    var_0.var_2113 = 0;
  }

  var_1 = 0;
  var_0.var_210F = 0;
  for(;;) {
    var_0 playanimscriptevent("power_active_cp", "gesture018");
    wait(1);
    var_1++;
    if(var_1 % 10 == 0) {
      var_0.var_2113 = var_0.var_2113 + 10;
      if(var_0.var_2113 > 150) {
        var_0.var_2113 = 150;
        continue;
      }

      if(var_0.arcade_game_award_type == "soul_power") {
        scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(var_0, 10);
        continue;
      }

      scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_0, 10, "yay", 1);
    }
  }
}

func_61D8(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("exit_arcade_game");
  var_2 = var_0 scripts\engine\utility::waittill_any_return("player_exit_afterlife", "spawned");
  var_0 notify("stop_arcade_timer");
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
  var_0 setclientomnvar("zm_arcade_emulator", "arcade_off");
  var_0 stoplocalsound("arcadeSound");
  if(isDefined(var_1.script_index)) {
    var_3 = getent(var_1.name, "targetname");
    var_4 = var_1.script_index;
    var_3 setscriptablepartstate("cab" + var_4, "idle");
  } else if(isDefined(var_1.groupname)) {
    var_3 = getent(var_1.groupname, "targetname");
    var_3 setscriptablepartstate(var_1.name, "idle");
  }

  var_0 setstance("stand");
  var_0 scripts\engine\utility::allow_weapon_switch(1);
  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  var_0.no_team_outlines = 0;
  var_0.playing_game = undefined;
  var_0 setmovespeedscale(1);
  var_0 lerpfovbypreset("zombiedefault");
  var_0 setclientomnvar("zombie_arcade_widget", 0);
  var_0 setclientomnvar("zombie_arcade_game_time", -1);
  wait(0.5);
  var_0 playanimscriptevent("power_active_cp", "gesture001");
  var_0.disable_consumables = undefined;
  var_0 allowcrouch(1);
  var_0 allowprone(1);
}

func_61D7(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_arcade_game");
  var_0 scripts\engine\utility::waittill_any("last_stand");
  var_0 playanimscriptevent("power_active_cp", "gesture001");
  var_0 setclientomnvar("zm_arcade_emulator", "arcade_off");
  var_0 stoplocalsound("arcadeSound");
  if(isDefined(var_1.script_index)) {
    var_2 = getent(var_1.name, "targetname");
    var_3 = var_1.script_index;
    var_2 setscriptablepartstate("cab" + var_3, "idle");
  } else if(isDefined(var_1.groupname)) {
    var_2 = getent(var_1.groupname, "targetname");
    var_2 setscriptablepartstate(var_1.name, "idle");
  }

  var_0 setplayerangles(var_1.angles);
  if(!var_0 scripts\engine\utility::isweaponswitchallowed()) {
    var_0 scripts\engine\utility::allow_weapon_switch(1);
  }

  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  if(!var_0 scripts\engine\utility::isweaponallowed()) {
    var_0 scripts\engine\utility::allow_weapon(1);
  }

  var_0.playing_game = undefined;
  var_0.no_team_outlines = undefined;
  var_0 setmovespeedscale(1);
  var_0 lerpfovbypreset("zombiedefault");
  var_0 setclientomnvar("zombie_arcade_widget", 0);
  var_0 setclientomnvar("zombie_arcade_game_time", -1);
  var_0.disable_consumables = undefined;
  var_0 allowcrouch(1);
  var_0 allowprone(1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

func_5653(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon("exit_arcade_game");
  level scripts\engine\utility::waittill_any("game_ended", "force_exit_arcade");
  var_0 setclientomnvar("zm_arcade_emulator", "arcade_off");
  var_0 stoplocalsound("arcadeSound");
  if(isDefined(var_1.script_index)) {
    var_2 = getent(var_1.name, "targetname");
    var_3 = var_1.script_index;
    var_2 setscriptablepartstate("cab" + var_3, "idle");
  } else if(isDefined(var_1.groupname)) {
    var_2 = getent(var_1.groupname, "targetname");
    var_2 setscriptablepartstate(var_1.name, "idle");
  }

  var_0 setplayerangles(var_1.angles);
  if(!var_0 scripts\engine\utility::isweaponswitchallowed()) {
    var_0 scripts\engine\utility::allow_weapon_switch(1);
  }

  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  if(!var_0 scripts\engine\utility::isweaponallowed()) {
    var_0 scripts\engine\utility::allow_weapon(1);
  }

  var_0 setmovespeedscale(1);
  var_0 lerpfovbypreset("zombiedefault");
  var_0 setclientomnvar("zombie_arcade_widget", 0);
  var_0 setclientomnvar("zombie_arcade_game_time", -1);
  var_0.disable_consumables = undefined;
  var_0 allowcrouch(1);
  var_0 allowprone(1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

func_61D6(var_0, var_1) {
  var_0 endon("exit_arcade_game");
  var_0 endon("player_exit_afterlife");
  var_0 endon("spawned");
  var_0 waittill("disconnect");
  if(isDefined(var_1.script_index)) {
    var_2 = getent(var_1.name, "targetname");
    var_3 = var_1.script_index;
    var_2 setscriptablepartstate("cab" + var_3, "idle");
  } else if(isDefined(var_1.groupname)) {
    var_2 = getent(var_1.groupname, "targetname");
    var_2 setscriptablepartstate(var_1.name, "idle");
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}