/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombie_arcade_games.gsc
******************************************************/

func_211C() {
  wait(10);
  if(getdvar("zmb_arcade_test") != "") {
    setdvar("debug_pause_spawning", 1);
    var_00 = scripts\engine\utility::getstructarray("dance_floor_attract_spots", "targetname");
    level.players[0] setorigin(var_00[0].origin);
    level.players[0] setplayerangles(var_00[0].angles);
    wait(3);
  }
}

use_arcade_game(param_00, param_01) {
  param_01 endon("disconnect");
  if(param_01 getstance() != "stand") {
    param_01 scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, & "COOP_INTERACTIONS_MUST_BE_STANDING");
    param_01 scripts\cp\cp_interaction::refresh_interaction();
    return;
  }

  param_01 endon("last_stand");
  param_01 endon("player_exit_afterlife");
  param_01 endon("spawned");
  param_01.no_team_outlines = 1;
  if(scripts\cp\cp_laststand::player_in_laststand(param_01) && !scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    return;
  }

  scripts\cp\zombies\arcade_game_utility::set_arcade_game_award_type(param_01);
  param_01.playing_game = 1;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  level thread func_61D6(param_01, param_00);
  level thread func_5653(param_01, param_00);
  if(scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    level thread func_61D8(param_01, param_00);
  } else {
    level thread func_61D7(param_01, param_00);
  }

  level thread func_5FB8(param_01, param_00);
  param_01 setplayerangles(param_00.angles + (29, 0, 0));
  param_01 setorigin(param_00.origin, 0);
  param_01.anchor = spawn("script_model", param_01.origin);
  param_01.anchor setModel("tag_origin");
  param_01 playerlinkto(param_01.anchor, "tag_origin", 1, 0, 0, 0, 0, 0);
  param_01.anchor.angles = param_00.angles + (29, 0, 0);
  param_01.anchor.origin = scripts\engine\utility::getstruct(param_00.target, "targetname").origin + scripts\cp\utility::vec_multiply(anglesToForward(param_00.angles), 3);
  if(!scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    param_01 scripts\engine\utility::allow_weapon(0);
  }

  param_01 scripts\engine\utility::allow_weapon_switch(0);
  param_01.disable_consumables = 1;
  param_01 playlocalsound("arcadeSound");
  var_02 = param_00.script_noteworthy;
  if(param_00.script_noteworthy == "arcade_starmaster") {
    var_02 = "arcade_chopper";
  }

  while(param_01 usebuttonpressed()) {
    wait(0.05);
  }

  param_01 setclientomnvar("zm_arcade_emulator", var_02);
  param_01 lerpfovbypreset("zombiearcade");
  param_01 setclientomnvar("zombie_arcade_game_time", 1);
  param_01 setclientomnvar("zombie_arcade_widget", 1);
  param_01 scripts\cp\zombies\achievement::update_achievement_arcade(param_01, param_00.script_noteworthy, level.wave_num);
  wait(0.25);
  if(isDefined(param_00.script_index)) {
    var_03 = getent(param_00.name, "targetname");
    var_04 = param_00.script_index;
    var_03 setscriptablepartstate("cab" + var_04, "emulated");
  } else if(isDefined(param_00.groupname)) {
    var_03 = getent(param_00.groupname, "targetname");
    var_03 setscriptablepartstate(param_00.name, "emulated");
  }

  for(;;) {
    param_01 waittill("adjustedStance");
    if(param_01 gettimeremainingpercentage()) {
      continue;
    } else {
      break;
    }
  }

  param_01 notify("exit_arcade_game");
  param_01 setclientomnvar("zm_arcade_emulator", "arcade_off");
  param_01 stoplocalsound("arcadeSound");
  if(isDefined(param_00.script_index)) {
    var_03 = getent(param_00.name, "targetname");
    var_04 = param_00.script_index;
    var_03 setscriptablepartstate("cab" + var_04, "idle");
  } else if(isDefined(param_00.groupname)) {
    var_03 = getent(param_00.groupname, "targetname");
    var_03 setscriptablepartstate(param_00.name, "idle");
  }

  param_01 setstance("stand");
  param_01 setplayerangles(param_00.angles);
  if(!param_01 scripts\engine\utility::isweaponswitchallowed()) {
    param_01 scripts\engine\utility::allow_weapon_switch(1);
  }

  if(!scripts\engine\utility::istrue(param_01.in_afterlife_arcade) && !param_01 scripts\engine\utility::isweaponallowed()) {
    param_01 scripts\engine\utility::allow_weapon(1);
  }

  param_01 setmovespeedscale(1);
  param_01 lerpfovbypreset("zombiedefault");
  param_01 setclientomnvar("zombie_arcade_widget", 0);
  param_01 setclientomnvar("zombie_arcade_game_time", -1);
  wait(0.5);
  param_01 allowcrouch(1);
  param_01 allowprone(1);
  param_01.disable_consumables = undefined;
  wait(2);
  param_01.playing_game = undefined;
  param_01.no_team_outlines = 0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

func_5FB8(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 endon("arcade_special_interrupt");
  level thread func_211A(param_00);
  param_00 scripts\cp\utility::allow_player_interactions(0);
  var_02 = param_00 scripts\engine\utility::waittill_any_return("exit_arcade_game", "player_exit_afterlife", "last_stand", "revive");
  if(!isDefined(param_00) || !isDefined(param_00.anchor)) {
    return;
  }

  param_00 notify("stop_arcade_timer");
  param_00 playanimscriptevent("power_active_cp", "gesture001");
  param_00.anchor.angles = param_01.angles;
  var_03 = scripts\cp\utility::vec_multiply(anglesToForward(param_01.angles), -15);
  param_00.anchor.origin = scripts\engine\utility::getstruct(param_01.target, "targetname").origin + (0, 0, 1) + var_03;
  wait(0.1);
  param_00.anchor delete();
  param_00 unlink();
  wait(1.5);
  if(!param_00 scripts\cp\utility::areinteractionsenabled()) {
    param_00 scripts\cp\utility::allow_player_interactions(1);
  }
}

func_211A(param_00) {
  param_00 endon("stop_arcade_timer");
  param_00 endon("disconnect");
  param_00 endon("arcade_special_interrupt");
  if(!isDefined(param_00.var_2113)) {
    param_00.var_2113 = 0;
  }

  var_01 = 0;
  param_00.var_210F = 0;
  for(;;) {
    param_00 playanimscriptevent("power_active_cp", "gesture018");
    wait(1);
    var_01++;
    if(var_01 % 10 == 0) {
      param_00.var_2113 = param_00.var_2113 + 10;
      if(param_00.var_2113 > 150) {
        param_00.var_2113 = 150;
        continue;
      }

      if(param_00.arcade_game_award_type == "soul_power") {
        scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(param_00, 10);
        continue;
      }

      scripts\cp\zombies\arcade_game_utility::give_player_tickets(param_00, 10, "yay", 1);
    }
  }
}

func_61D8(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("exit_arcade_game");
  var_02 = param_00 scripts\engine\utility::waittill_any_return("player_exit_afterlife", "spawned");
  param_00 notify("stop_arcade_timer");
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_01);
  param_00 setclientomnvar("zm_arcade_emulator", "arcade_off");
  param_00 stoplocalsound("arcadeSound");
  if(isDefined(param_01.script_index)) {
    var_03 = getent(param_01.name, "targetname");
    var_04 = param_01.script_index;
    var_03 setscriptablepartstate("cab" + var_04, "idle");
  } else if(isDefined(param_01.groupname)) {
    var_03 = getent(param_01.groupname, "targetname");
    var_03 setscriptablepartstate(param_01.name, "idle");
  }

  param_00 setstance("stand");
  param_00 scripts\engine\utility::allow_weapon_switch(1);
  param_00 scripts\cp\utility::freezecontrolswrapper(0);
  param_00.no_team_outlines = 0;
  param_00.playing_game = undefined;
  param_00 setmovespeedscale(1);
  param_00 lerpfovbypreset("zombiedefault");
  param_00 setclientomnvar("zombie_arcade_widget", 0);
  param_00 setclientomnvar("zombie_arcade_game_time", -1);
  wait(0.5);
  param_00 playanimscriptevent("power_active_cp", "gesture001");
  param_00.disable_consumables = undefined;
  param_00 allowcrouch(1);
  param_00 allowprone(1);
}

func_61D7(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 endon("exit_arcade_game");
  param_00 scripts\engine\utility::waittill_any_3("last_stand");
  param_00 playanimscriptevent("power_active_cp", "gesture001");
  param_00 setclientomnvar("zm_arcade_emulator", "arcade_off");
  param_00 stoplocalsound("arcadeSound");
  if(isDefined(param_01.script_index)) {
    var_02 = getent(param_01.name, "targetname");
    var_03 = param_01.script_index;
    var_02 setscriptablepartstate("cab" + var_03, "idle");
  } else if(isDefined(param_01.groupname)) {
    var_02 = getent(param_01.groupname, "targetname");
    var_02 setscriptablepartstate(param_01.name, "idle");
  }

  param_00 setplayerangles(param_01.angles);
  if(!param_00 scripts\engine\utility::isweaponswitchallowed()) {
    param_00 scripts\engine\utility::allow_weapon_switch(1);
  }

  param_00 scripts\cp\utility::freezecontrolswrapper(0);
  if(!param_00 scripts\engine\utility::isweaponallowed()) {
    param_00 scripts\engine\utility::allow_weapon(1);
  }

  param_00.playing_game = undefined;
  param_00.no_team_outlines = undefined;
  param_00 setmovespeedscale(1);
  param_00 lerpfovbypreset("zombiedefault");
  param_00 setclientomnvar("zombie_arcade_widget", 0);
  param_00 setclientomnvar("zombie_arcade_game_time", -1);
  param_00.disable_consumables = undefined;
  param_00 allowcrouch(1);
  param_00 allowprone(1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_01);
}

func_5653(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 endon("exit_arcade_game");
  level scripts\engine\utility::waittill_any_3("game_ended", "force_exit_arcade");
  param_00 setclientomnvar("zm_arcade_emulator", "arcade_off");
  param_00 stoplocalsound("arcadeSound");
  if(isDefined(param_01.script_index)) {
    var_02 = getent(param_01.name, "targetname");
    var_03 = param_01.script_index;
    var_02 setscriptablepartstate("cab" + var_03, "idle");
  } else if(isDefined(param_01.groupname)) {
    var_02 = getent(param_01.groupname, "targetname");
    var_02 setscriptablepartstate(param_01.name, "idle");
  }

  param_00 setplayerangles(param_01.angles);
  if(!param_00 scripts\engine\utility::isweaponswitchallowed()) {
    param_00 scripts\engine\utility::allow_weapon_switch(1);
  }

  param_00 scripts\cp\utility::freezecontrolswrapper(0);
  if(!param_00 scripts\engine\utility::isweaponallowed()) {
    param_00 scripts\engine\utility::allow_weapon(1);
  }

  param_00 setmovespeedscale(1);
  param_00 lerpfovbypreset("zombiedefault");
  param_00 setclientomnvar("zombie_arcade_widget", 0);
  param_00 setclientomnvar("zombie_arcade_game_time", -1);
  param_00.disable_consumables = undefined;
  param_00 allowcrouch(1);
  param_00 allowprone(1);
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_01);
}

func_61D6(param_00, param_01) {
  param_00 endon("exit_arcade_game");
  param_00 endon("player_exit_afterlife");
  param_00 endon("spawned");
  param_00 waittill("disconnect");
  if(isDefined(param_01.script_index)) {
    var_02 = getent(param_01.name, "targetname");
    var_03 = param_01.script_index;
    var_02 setscriptablepartstate("cab" + var_03, "idle");
  } else if(isDefined(param_01.groupname)) {
    var_02 = getent(param_01.groupname, "targetname");
    var_02 setscriptablepartstate(param_01.name, "idle");
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(param_01);
}