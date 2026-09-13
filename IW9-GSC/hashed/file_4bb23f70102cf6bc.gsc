/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4bb23f70102cf6bc.gsc
***********************************************/

main() {
  setDvar("dvar_9EB1E24F643E2711", 1);
  scripts\engine\utility::flag_wait("cp_raid_complex_jugg_maze_completed");
  scripts\cp\coop_stealth::coop_stealth_init();
  register_maze_ai_spawners();
  sound_distraction_mechanic_init();
  set_maze_ai_stealth_settings();
  level._id_FB72DCF8512E4800 = [];
  level._id_FB72DCF8512E4800["jugg_maze_a"] = [];
  level._id_FB72DCF8512E4800["jugg_maze_b"] = [];
  level._id_FB72DCF8512E4800["jugg_maze_c"] = [];
  level._id_FB72DCF8512E4800["jugg_maze_d"] = [];
  level._id_FB72DCF8512E4800["jugg_maze_e"] = [];
  level._id_DFCA7532595ACFE2 = [];
  level._id_DFCA7532595ACFE2["jugg_maze_a"] = [];
  level._id_DFCA7532595ACFE2["jugg_maze_b"] = [];
  level._id_DFCA7532595ACFE2["jugg_maze_c"] = [];
  level._id_DFCA7532595ACFE2["jugg_maze_d"] = [];
  level._id_DFCA7532595ACFE2["jugg_maze_e"] = [];
  level._id_FD11A870E357A9ED = [];
  level._id_FD11A870E357A9ED["jugg_maze_a"] = [];
  level._id_FD11A870E357A9ED["jugg_maze_b"] = [];
  level._id_FD11A870E357A9ED["jugg_maze_c"] = [];
  level._id_FD11A870E357A9ED["jugg_maze_d"] = [];
  level._id_FD11A870E357A9ED["jugg_maze_e"] = [];
  level._id_DA342BD05311B053 = ["interactable_note_keycard_raid4_maze", "interactable_note_keycard_raid4_maze_2"];

  if(!isDefined(level._id_71B6598ADADADD87))
    level._id_71B6598ADADADD87 = ["volume_stealth_groupa", "volume_stealth_groupb", "volume_stealth_groupc", "volume_stealth_groupd"];

  if(!isDefined(level._id_91BE3D14A6998CA6))
    level._id_91BE3D14A6998CA6 = getEnt("volume_stealth_jugg_maze_map_room", "targetname");
}

set_maze_ai_stealth_settings() {
  level.astar_node_radius_override = 12;
  level._id_96D46B3DE782E4E7 = 1200;
  level._id_47247DECD7164A0E = 512;
}

unset_maze_ai_stealth_settings() {
  _func_7AFB89FC511BF315("new_enemy", 512.0);
  _func_1A3DD0FBFE26893F("new_enemy", 256.0);
  level.astar_node_radius_override = undefined;
}

setup_jugg_maze_kill_trigger() {
  level endon("game_ended");
  level endon("escaped_maze");
  level.jugg_maze_killtrigger = getEnt("jugg_maze_kill_trigger", "targetname");
  level.jugg_maze_killtrigger.origin = level.jugg_maze_killtrigger.origin + (0, 0, -70);

  for(;;) {
    level.jugg_maze_killtrigger waittill("trigger", entity);

    if(!isDefined(entity)) {
      waitframe();
      continue;
    }

    if(!isagent(entity) && !isPlayer(entity)) {
      waitframe();
      continue;
    } else if(isPlayer(entity)) {
      entity setvelocity((-500, 0, 500));
      entity.shouldskiplaststand = 1;
      entity dodamage(entity.health + 1000, entity.origin);
    }
  }
}

_id_4FA48E44E9B7363E(_id_E032318567F8AFCD, _id_D5685B7BAEE6505E, end_pos, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, ai, _id_ACF81F9900BE7297) {
  _id_94B74E624FEF0D5E = [];

  if(getdvarint("dvar_860C5A341FEC0253", 1) != 0) {
    _id_4326D485F057B09E = undefined;
    _id_A54D8B03B3F42B54 = (1, 0, 0);

    if(isDefined(ai)) {
      ai endon("death");

      if(isDefined(ai.script_stealthgroup)) {
        switch (ai.script_stealthgroup) {
          case "jugg_maze_a":
            _id_4326D485F057B09E = "volume_stealth_groupa";
            _id_A54D8B03B3F42B54 = (1, 0, 0);
            break;
          case "jugg_maze_b":
            _id_4326D485F057B09E = "volume_stealth_groupb";
            _id_A54D8B03B3F42B54 = (0, 1, 0);
            break;
          case "jugg_maze_c":
            _id_4326D485F057B09E = "volume_stealth_groupc";
            _id_A54D8B03B3F42B54 = (0, 0, 1);
            break;
          case "jugg_maze_d":
            _id_4326D485F057B09E = "volume_stealth_groupd";
            _id_A54D8B03B3F42B54 = (1, 1, 1);
            break;
          case "jugg_maze_e":
            _id_4326D485F057B09E = "volume_stealth_groupe";
            _id_A54D8B03B3F42B54 = (1, 1, 1);
            break;
        }

        if(isDefined(_id_4326D485F057B09E)) {
          foreach(node in _id_E032318567F8AFCD) {
            if(ispointinvolume(node.origin, getEnt(_id_4326D485F057B09E, "targetname"))) {
              _id_94B74E624FEF0D5E = scripts\engine\utility::array_add(_id_94B74E624FEF0D5E, node);

              if(getDvar("astar_debug") != "")
                level thread scripts\cp\utility::drawsphere(node.origin, 6.9, 20000, _id_A54D8B03B3F42B54);
            }
          }
        }
      }
    }
  }

  if(level._id_FB72DCF8512E4800[ai.script_stealthgroup].size == 0)
    level._id_FB72DCF8512E4800[ai.script_stealthgroup] = _id_94B74E624FEF0D5E;

  if(getDvar("astar_debug") != "")
    iprintln("^3 NEW GRID CHOSEN. SIZE = ^1" + _id_94B74E624FEF0D5E.size + " ^3 v/s ^6" + _id_E032318567F8AFCD.size);

  return scripts\cp\astar::astar_get_path(_id_94B74E624FEF0D5E, _id_D5685B7BAEE6505E, end_pos, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_ACF81F9900BE7297);
}

register_maze_ai_spawners() {
  _id_18A73A64992DD07D::registerambientgroup("jugg_spawn_aj", 12, 12, undefined, 0.5, undefined, "jugg_spawn_aj", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_spawn_aj", ::run_maze_ai_common_function_stealth);
  _id_18A73A64992DD07D::registerambientgroup("jugg_spawn_localized_a", 3, 3, undefined, 0.5, undefined, "jugg_spawn_localized_a", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_spawn_localized_a", ::_id_6399EE828911B0E0);
  _id_18A73A64992DD07D::registerambientgroup("jugg_spawn_localized_b", 3, 3, undefined, 0.5, undefined, "jugg_spawn_localized_b", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_spawn_localized_b", ::_id_6399F1828911B779);
  _id_18A73A64992DD07D::registerambientgroup("jugg_spawn_localized_c", 2, 2, 2, 0.5, undefined, "jugg_spawn_localized_c", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_spawn_localized_c", ::_id_6399F0828911B546);
  _id_18A73A64992DD07D::registerambientgroup("jugg_spawn_localized_d", 2, 2, 2, 0.5, undefined, "jugg_spawn_localized_d", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_spawn_localized_d", ::_id_6399F3828911BBDF);
  _id_18A73A64992DD07D::registerambientgroup("jugg_spawn_localized_e", 2, 2, undefined, 0.5, undefined, "jugg_spawn_localized_e", scripts\cp\coop_stealth::increase_script_maxdist, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("jugg_spawn_localized_e", ::_id_6399F2828911B9AC);
  _id_18A73A64992DD07D::registerambientgroup("enemy_wave_1", 1, 1, 4, 3, undefined, "enemy_wave_1", undefined, "enemy_wave_2", undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("enemy_wave_1", ::_id_3F3738ABA4AA0451);
  _id_18A73A64992DD07D::registerambientgroup("enemy_wave_2", 0, 2, 7, 8, undefined, "enemy_wave_2", undefined, "enemy_wave_3", undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("enemy_wave_2", ::_id_3F3738ABA4AA0451);
  _id_18A73A64992DD07D::registerambientgroup("enemy_wave_3", 0, 3, 10, 10, undefined, "enemy_wave_3", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("enemy_wave_3", ::_id_3F3738ABA4AA0451);
  _id_18A73A64992DD07D::registerambientgroup("juggmaze_screen_guy", 1, 1, 1, 1, undefined, "juggmaze_screen_guy", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("juggmaze_screen_guy", ::_id_C7B88F3CD77CBD98);
}

_id_D1BFBCB28C0CD76E() {
  _id_18A73A64992DD07D::stop_module_by_groupname("enemy_wave_1");
  _id_18A73A64992DD07D::stop_module_by_groupname("enemy_wave_2");
  _id_18A73A64992DD07D::stop_module_by_groupname("enemy_wave_3");
}

_id_91C2742E256F657D(_id_DCE3A6BB9F7CE5FD) {
  _id_47327F8B54FC5DB2 = [];

  foreach(player in level.players) {
    if(!istrue(_id_DCE3A6BB9F7CE5FD)) {
      if(!isalive(player) || _id_0AFB7E332AEE4BF2::player_in_laststand(player))
        continue;
    }

    if(ispointinvolume(player.origin, getEnt("volume_stealth_jugg_maze_map_room", "targetname"))) {
      _id_47327F8B54FC5DB2 = scripts\engine\utility::array_add(_id_47327F8B54FC5DB2, player);
      break;
    }
  }

  return _id_47327F8B54FC5DB2;
}

_id_B34C6E374DF9C4A1(_id_DCE3A6BB9F7CE5FD) {
  _id_47327F8B54FC5DB2 = [];

  foreach(player in level.players) {
    if(!istrue(_id_DCE3A6BB9F7CE5FD)) {
      if(!isalive(player) || _id_0AFB7E332AEE4BF2::player_in_laststand(player))
        continue;
    }

    if(ispointinvolume(player.origin, getEnt("volume_stealth_jugg_maze_complete", "targetname"))) {
      _id_47327F8B54FC5DB2 = scripts\engine\utility::array_add(_id_47327F8B54FC5DB2, player);
      break;
    }
  }

  return _id_47327F8B54FC5DB2;
}

_id_D24590F588A71CA2(_id_4D1875416188467E) {
  players = scripts\engine\utility::ter_op(isDefined(_id_4D1875416188467E), _id_4D1875416188467E, level.players);
  _id_C729D49D406ACED8 = scripts\engine\utility::getclosest(self.origin, players);

  if(isDefined(_id_C729D49D406ACED8))
    thread _id_242A2441CBD54AF1::_id_43A45E199254CE4F(_id_C729D49D406ACED8);
}

_id_3F3738ABA4AA0451(group_name, func) {
  if(!istrue(level._id_2AEBAA33ED0079F4)) {
    level._id_2AEBAA33ED0079F4 = 1;

    if(!isDefined(level._id_6266E73962148BD0))
      level._id_6266E73962148BD0 = getentitylessscriptablearray(undefined, undefined, level._id_0C6C8A6BC57170DB.origin, 64, "door");

    foreach(door in level._id_6266E73962148BD0)
    _id_531C536DCD04E20F::_id_B092780F9EC4496E(door);
  }

  _id_242A2441CBD54AF1::_id_9F4D554E3AE3D383(group_name);
  self.maxfacenewenemydist = 4000;
  self.baseaccuracy = getdvarfloat("dvar_9F78280356EF4531", 2.0);
  thread _id_D24590F588A71CA2(_id_91C2742E256F657D());
}

jugg_death_watcher_internal(_id_E21279FA90BDF012) {
  _id_E21279FA90BDF012 waittill("death");
  _id_E21279FA90BDF012._id_B4E73B5C37FE850F = 0;
}

jugg_damage_watcher_internal(_id_E21279FA90BDF012) {
  _id_E21279FA90BDF012 endon("death");
  _id_E21279FA90BDF012 waittill("damage");
}

_id_6399EE828911B0E0(group) {
  run_maze_ai_common_function_stealth(group);
}

_id_6399F1828911B779(group) {
  run_maze_ai_common_function_stealth(group);
}

_id_6399F0828911B546(group) {
  if(!istrue(level._id_A6E002E7FA1DF0C3)) {
    if(!isDefined(level._id_6E6C8E9CA9C42A38)) {
      level._id_6E6C8E9CA9C42A38 = self;
      level._id_6E6C8E9CA9C42A38 thread _id_8F98C06D510E40AC();
    }
  }

  run_maze_ai_common_function_stealth(group);
}

_id_6399F3828911BBDF(group) {
  if(!istrue(level._id_A6E002E7FA1DF0C3)) {
    if(!isDefined(level._id_6E6C8E9CA9C42A38)) {
      level._id_6E6C8E9CA9C42A38 = self;
      level._id_6E6C8E9CA9C42A38 thread _id_8F98C06D510E40AC();
    }
  }

  run_maze_ai_common_function_stealth(group);
}

_id_6399F2828911B9AC(group) {
  run_maze_ai_common_function_stealth(group);
}

_id_C7B88F3CD77CBD98(group) {
  self.script_noteworthy = "screen_guy";
}

_id_8F98C06D510E40AC() {
  level notify("keycard_kickOffJuggKeycardLogic");
  level endon("keycard_kickOffJuggKeycardLogic");
  level endon("game_ended");
  self setperk("specialty_coldblooded", 1);
  self setperk("specialty_radarringresist", 1);
  self setperk("specialty_radarjuggernaut", 1);
  self setperk("specialty_blindeye", 1);
  self setperk("specialty_spygame", 1);
  self setperk("specialty_radarblip", 1);
  setomnvar("ui_keycard_carrier", self getentitynumber());
  _id_477F81D188723410 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID"))
    _id_477F81D188723410 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID");

  objid = undefined;

  if(isDefined(_id_477F81D188723410)) {
    objid = [[_id_477F81D188723410]](68);
    self.juggobjid = objid;
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "active", self.origin, "ui_map_icon_jugg_drop");
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);

    foreach(player in level.players) {
      if(!isDefined(player) || isbot(player) || player == self) {
        continue;
      }
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
    }

    scripts\mp\objidpoolmanager::update_objective_onentity(objid, self);
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
  }

  self waittill("death");
  setomnvar("ui_keycard_carrier", -1);
  _id_F9ABDB32B007D054 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
    _id_F9ABDB32B007D054 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID");

  if(isDefined(_id_F9ABDB32B007D054))
    [[_id_F9ABDB32B007D054]](objid);

  objective_state(objid, "done");

  if(isDefined(self.lastattacker))
    self.lastattacker thread _id_293BC33BD79CABD1::killeventtextpopup("stat_EBCC9C019C3B6818", 0);

  thread _id_C5979FDECB85AC32(undefined, (0, 0, 64));
}

run_maze_ai_common_function_stealth(group) {
  _id_CD977BE97BC0FC1E = self;
  _id_CD977BE97BC0FC1E.ballowexecutions = 1;
  _id_CD977BE97BC0FC1E._id_4438D881D79DF85B = 1;
  _id_CD977BE97BC0FC1E _meth_8A144CB1601C409A();
  _id_CD977BE97BC0FC1E.sightmaxdistance = 1000;
  _id_CD977BE97BC0FC1E thread jugg_death_watcher_internal(_id_CD977BE97BC0FC1E);
  _id_CD977BE97BC0FC1E thread jugg_damage_watcher_internal(_id_CD977BE97BC0FC1E);

  if(getdvarint("dvar_D9E66BE134D0BC66", 0) != 0)
    _id_CD977BE97BC0FC1E _meth_D493E7FE15E5EAF4("cp_jugg_maze_section");
  else
    _id_CD977BE97BC0FC1E _meth_D493E7FE15E5EAF4("cp_jugg_maze_section_longer");

  if(getdvarint("dvar_DCF5FCEDE3345FB8", 0) != 0)
    _id_CD977BE97BC0FC1E.ignoreall = 1;

  if(_id_CD977BE97BC0FC1E _id_18A73A64992DD07D::is_specified_unittype("juggernaut")) {
    _id_CD977BE97BC0FC1E _meth_B11B5190B03C861C("");
    _id_CD977BE97BC0FC1E._id_B4E73B5C37FE850F = 1;
    _id_CD977BE97BC0FC1E.combatmode = "no_cover";
    _id_CD977BE97BC0FC1E.script_combatmode = "no_cover";
    _id_CD977BE97BC0FC1E._id_2626D6897D71B728 = getdvarint("dvar_27AC49E932C82CD6", 768);
    _id_CD977BE97BC0FC1E.meleechargedistvsplayer = 256;
    _id_CD977BE97BC0FC1E _id_18A73A64992DD07D::set_goal_radius(64);
    _id_CD977BE97BC0FC1E.baseaccuracy = getdvarfloat("dvar_BF81930E3FF6D7EB", 66);
  }

  _id_CD977BE97BC0FC1E scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  _id_CD977BE97BC0FC1E _id_371B4C2AB5861E62::_id_1C3709E864D4E8D5(1);
  _id_CD977BE97BC0FC1E.stealth.funcs["event_investigate"] = ::_id_740482DD5A644509;
  _id_CD977BE97BC0FC1E.stealth.funcs["event_cover_blown"] = ::_id_740482DD5A644509;
  _id_CD977BE97BC0FC1E.stealth.funcs["event_combat"] = ::_id_740482DD5A644509;
  _id_CD977BE97BC0FC1E.maxfacenewenemydist = 4000;
  _id_CD977BE97BC0FC1E._id_E72151E692E96CAD = _id_AA33454AB6E10CE3(_id_CD977BE97BC0FC1E);
  level._id_FD11A870E357A9ED[_id_CD977BE97BC0FC1E.script_stealthgroup] = scripts\engine\utility::_id_6D6AF8144A5131F1(level._id_FD11A870E357A9ED[_id_CD977BE97BC0FC1E.script_stealthgroup], _id_CD977BE97BC0FC1E);

  if(isDefined(_id_CD977BE97BC0FC1E.enemy_group) && (_id_CD977BE97BC0FC1E.enemy_group == "jugg_spawn_aj" || issubstr(_id_CD977BE97BC0FC1E.enemy_group, "spawn_localized"))) {
    _id_CD977BE97BC0FC1E.node_grid = scripts\engine\utility::getStructArray("jugg_nav_path", "script_noteworthy");

    if(isDefined(_id_CD977BE97BC0FC1E.node_grid)) {
      _id_D5685B7BAEE6505E = _id_CD977BE97BC0FC1E.origin;
      end_pos = scripts\engine\utility::random(_id_CD977BE97BC0FC1E.node_grid).origin;
      _id_17947F4A9AA52B15 = [self];
      _id_6EE6C2CA7C64E9C9 = spawnStruct();
      _id_6EE6C2CA7C64E9C9.origin = _id_CD977BE97BC0FC1E.origin;
      _id_CD977BE97BC0FC1E.path_data = _id_4FA48E44E9B7363E(_id_CD977BE97BC0FC1E.node_grid, _id_D5685B7BAEE6505E, end_pos, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_CD977BE97BC0FC1E);

      if(isDefined(self._id_E72151E692E96CAD)) {
        if(self istouching(self._id_E72151E692E96CAD))
          _id_CD977BE97BC0FC1E thread go_patrol_the_maze();
        else {
          while(level._id_FB72DCF8512E4800[_id_CD977BE97BC0FC1E.script_stealthgroup].size == 0)
            waitframe();

          _id_C8B707C031223716 = _id_A186D1F007BC37D3([_id_CD977BE97BC0FC1E], level._id_FB72DCF8512E4800[_id_CD977BE97BC0FC1E.script_stealthgroup], _id_CD977BE97BC0FC1E.script_stealthgroup);
          _id_CD977BE97BC0FC1E thread _id_18A73A64992DD07D::go_to_node(_id_C8B707C031223716);
          _id_CD977BE97BC0FC1E thread path_loop();
        }
      }
    }
  }
}

_id_A186D1F007BC37D3(ai_array, _id_B217F6D03CCC3F2E, groupname) {
  _id_5F8B983A9CC28FB2 = [];

  foreach(interaction in _id_B217F6D03CCC3F2E) {
    if(!istrue(interaction.active))
      _id_5F8B983A9CC28FB2[_id_5F8B983A9CC28FB2.size] = interaction;
  }

  _id_99FA079B730F3956 = [];
  _id_B217F6D03CCC3F2E = _id_5F8B983A9CC28FB2;
  _id_3342A2487478D901 = _id_B217F6D03CCC3F2E[0];
  _id_6ABF4CEA6BF92F0E = 0;
  _id_41BB661D950E0147 = [];
  _id_41BB661D950E0147 = scripts\engine\utility::array_intersection(level._id_DFCA7532595ACFE2[groupname], _id_B217F6D03CCC3F2E);

  if(_id_41BB661D950E0147.size > 0) {
    foreach(node in _id_B217F6D03CCC3F2E) {
      if(scripts\engine\utility::array_contains(_id_41BB661D950E0147, node)) {
        continue;
      }
      _id_99FA079B730F3956 = scripts\engine\utility::array_add(_id_99FA079B730F3956, node);
    }
  }

  if(_id_99FA079B730F3956.size == 0) {}

  foreach(_id_0C3EA9B1A20FF199 in _id_B217F6D03CCC3F2E) {
    dist = undefined;
    player = scripts\engine\utility::getclosest(_id_0C3EA9B1A20FF199.origin, ai_array);
    dist = distance2dsquared(player.origin, _id_0C3EA9B1A20FF199.origin);

    if(dist > _id_6ABF4CEA6BF92F0E) {
      _id_3342A2487478D901 = _id_0C3EA9B1A20FF199;
      _id_6ABF4CEA6BF92F0E = dist;
    }
  }

  level._id_DFCA7532595ACFE2[groupname] = scripts\engine\utility::array_add(level._id_DFCA7532595ACFE2[groupname], _id_3342A2487478D901);
  return _id_3342A2487478D901;
}

_id_AA33454AB6E10CE3(ai) {
  _id_4326D485F057B09E = undefined;

  if(isDefined(ai.script_stealthgroup)) {
    switch (ai.script_stealthgroup) {
      case "jugg_maze_a":
        _id_4326D485F057B09E = "volume_stealth_groupa";
        _id_A54D8B03B3F42B54 = (1, 0, 0);
        break;
      case "jugg_maze_b":
        _id_4326D485F057B09E = "volume_stealth_groupb";
        _id_A54D8B03B3F42B54 = (0, 1, 0);
        break;
      case "jugg_maze_c":
        _id_4326D485F057B09E = "volume_stealth_groupc";
        _id_A54D8B03B3F42B54 = (0, 0, 1);
        break;
      case "jugg_maze_d":
        _id_4326D485F057B09E = "volume_stealth_groupd";
        _id_A54D8B03B3F42B54 = (1, 1, 1);
        break;
      case "jugg_maze_e":
        _id_4326D485F057B09E = "volume_stealth_groupe";
        _id_A54D8B03B3F42B54 = (0, 1, 1);
        break;
    }

    if(isDefined(_id_4326D485F057B09E))
      return getEnt(_id_4326D485F057B09E, "targetname");
  }

  return undefined;
}

_id_740482DD5A644509(event) {
  _id_205ECAFADD3EE98F = 1;

  if(isDefined(event.origin)) {
    foreach(_id_4326D485F057B09E in level._id_71B6598ADADADD87) {
      if(event.typeorig == "gunshot_teammate") {
        if(isDefined(event.entity)) {
          if(ispointinvolume(event.entity.origin, getEnt(_id_4326D485F057B09E, "targetname"))) {
            break;
          }
        }
      } else if(ispointinvolume(event.origin, getEnt(_id_4326D485F057B09E, "targetname"))) {
        if(isDefined(event.entity) && (event.typeorig == "gunshot" || event.typeorig == "gunshot_impact")) {
          if(ispointinvolume(event.entity.origin, getEnt(_id_4326D485F057B09E, "targetname"))) {
            _id_205ECAFADD3EE98F = 0;
            break;
          }
        } else {
          _id_205ECAFADD3EE98F = 0;
          break;
        }
      }
    }

    if(!istrue(_id_205ECAFADD3EE98F)) {
      if(ispointinvolume(event.origin, level._id_91BE3D14A6998CA6))
        _id_205ECAFADD3EE98F = 1;
    }

    if(istrue(_id_205ECAFADD3EE98F))
      return 1;
  }

  _id_7B64EABBDC923F61 = ["silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_sprint", "footstep_walk", "projectile_impact"];

  if(scripts\engine\utility::array_contains(_id_7B64EABBDC923F61, event.typeorig)) {
    if(isDefined(event.origin)) {
      if(!self hastacvis(event.origin, 1) && !_id_CA53F38B1EB70113(event.origin, 1, level._id_8EE9C5604A4FB6C0))
        return 1;
      else {}
    }
  }

  if(_id_9A9B91C11482389F(event))
    return 1;

  if(event.type == "combat") {
    _id_18A73A64992DD07D::set_goal_radius(2048);
    self notify("stop_going_to_node");
    self notify("go_patrol_the_maze");
    self notify("path_loop");

    if(getdvarint("dvar_C30C5A97E1042021", 1) != 0)
      thread _id_C72212CE5697C02A();

    thread _id_11811C954BBA79E3::_id_75B8976CF0C4104F(self, self.enemy);
    return 0;
  }

  return 0;
}

_id_C72212CE5697C02A() {
  self endon("death");
  self endon("stealth_hunt");
  self notify("ai_decreasePursueDistanceOverTime");
  self endon("ai_decreasePursueDistanceOverTime");
  self._id_F0A6BB2515B0AFFC = getdvarint("dvar_27AC49E932C82CD6", 768);
  thread _id_7AA389EEFAFD2AFA();
  time = getdvarint("dvar_F939B631CFD6B7BD", 7);
  counter = 0;

  while(!isDefined(self.enemy))
    waitframe();

  wait(getdvarint("dvar_EAFAEDFA1399A35C", 2));

  while(time > counter) {
    wait(getdvarint("dvar_EA0F210196405EF2", 2));

    if(!_id_0EED5395217FF3B6()) {
      counter++;
      self._id_2626D6897D71B728 = max(self._id_F0A6BB2515B0AFFC - getdvarint("dvar_1DB231E7A1245AF2", 100) * counter, 0);

      if(getdvarint("dvar_A05DE2CC08D8FFB7", 0) != 0) {
        text = " New Pursue Distance " + self._id_2626D6897D71B728;
        childthread _id_B944804243A232CE("tag_eye", (0, 0, 10), text, (1, 0, 0), 0.5, "stealth_hunt", undefined);
      }

      continue;
    }
  }

  if(getdvarint("dvar_EE325CCBBD0C3694", 0) != 0) {
    if(!self[[self.fnisinstealthcombat]]())
      self[[self.fnsetstealthstate]]("hunt");
  }
}

_id_7AA389EEFAFD2AFA() {
  self endon("death");
  self notify("ai_resetToOGPursueDistances");
  self endon("ai_resetToOGPursueDistances");
  scripts\engine\utility::waittill_any_2("stealth_hunt", "stealth_investigate");
  self._id_2626D6897D71B728 = self._id_F0A6BB2515B0AFFC;

  if(getdvarint("dvar_A05DE2CC08D8FFB7", 0) != 0) {
    text = " Pursue Distance Reset to OG Value: " + self._id_2626D6897D71B728;
    childthread _id_B944804243A232CE("tag_eye", (0, 0, 10), text, (0, 1, 0), 0.5, "stealth_combat", undefined);
  }
}

_id_B944804243A232CE(tag, offset, text, color, scale, _id_E4536166F39FF536, _id_2930CE928C2AC84C) {
  if(!istrue(_id_2930CE928C2AC84C))
    self endon("death");

  if(isDefined(_id_E4536166F39FF536))
    self endon(_id_E4536166F39FF536);

  if(!isDefined(offset))
    offset = (0, 0, 0);

  self notify("debug_print3dOnTag");
  self endon("debug_print3dOnTag");

  for(;;)
    waitframe();
}

_id_0EED5395217FF3B6() {
  self endon("death");
  self notify("ai_amIStillTrackingMyEnemy");
  self endon("ai_amIStillTrackingMyEnemy");
  _id_CD977BE97BC0FC1E = self;

  if(isDefined(_id_CD977BE97BC0FC1E.enemy)) {
    if(_id_CD977BE97BC0FC1E cansee(_id_CD977BE97BC0FC1E.enemy))
      return 1;
    else
      return 0;
  }

  return 0;
}

watch_for_player_in_los() {
  self endon("death");
  self notify("watch_for_player_in_LOS");
  self endon("watch_for_player_in_LOS");
  _id_CD977BE97BC0FC1E = self;
  _id_72BB599075A82534 = _id_CD977BE97BC0FC1E.origin;

  while(!isDefined(_id_CD977BE97BC0FC1E.enemy))
    waitframe();

  if(isPlayer(_id_CD977BE97BC0FC1E.enemy))
    iprintln("^3 AI - Ent ^1" + _id_CD977BE97BC0FC1E getentitynumber() + "^3 went into Combat State because of - ^1" + _id_CD977BE97BC0FC1E.enemy.name);

  if(isDefined(_id_CD977BE97BC0FC1E.enemy))
    _id_72BB599075A82534 = _id_CD977BE97BC0FC1E.enemy.origin;
  else if(isDefined(_id_CD977BE97BC0FC1E.lastattacker))
    _id_72BB599075A82534 = _id_CD977BE97BC0FC1E.lastattacker.origin;

  while(isDefined(_id_CD977BE97BC0FC1E.enemy)) {
    if(_id_CD977BE97BC0FC1E cansee(_id_CD977BE97BC0FC1E.enemy) || distance2dsquared(_id_CD977BE97BC0FC1E.origin, _id_CD977BE97BC0FC1E.enemy.origin) <= squared(1024) || _func_8CE5803B7D377D72(_id_CD977BE97BC0FC1E.enemy) == 1)
      _id_72BB599075A82534 = _id_CD977BE97BC0FC1E lastknownpos(_id_CD977BE97BC0FC1E.enemy);
    else
      break;

    wait 1;
  }
}

_id_CA53F38B1EB70113(origin, _id_7E6761D0C6470CA2, dist) {
  if(!isDefined(_id_7E6761D0C6470CA2))
    _id_7E6761D0C6470CA2 = 1;

  if(_id_7E6761D0C6470CA2 && !scripts\engine\utility::within_fov(self.origin, self.angles, origin, cos(180)))
    return 0;

  _id_67245ACC80F2296D = _id_CABCC7C3E8682497();
  _id_C127D102DD2295C3 = _id_0B071913D4B91319();

  if(!isDefined(dist))
    dist = 1024;

  if(!_id_86C6AFB41A6C383B(_id_67245ACC80F2296D, origin, dist))
    return 0;

  if(_id_86C6AFB41A6C383B(_id_67245ACC80F2296D, origin, level.stealth.damage_sight_range))
    return 1;

  if(_id_7E6761D0C6470CA2) {
    if(isai(self) && !self aipointinfov(origin))
      return 0;
  }

  _id_125435EA93CCA389 = level._id_318CEAE290567709;
  return scripts\engine\trace::ray_trace_passed(_id_67245ACC80F2296D, origin, [self], _id_125435EA93CCA389);
}

_id_86C6AFB41A6C383B(start, end, dist) {
  if(!isDefined(start) || !isDefined(end))
    return 0;

  return distancesquared(start, end) <= dist * dist;
}

_id_CABCC7C3E8682497() {
  if(isDefined(self._id_18718F98529A77D8)) {
    if(self._id_695601297697AB71 == gettime())
      return self._id_18718F98529A77D8;

    if(isDefined(self._id_DF2EC152343705D2) && self._id_DF2EC152343705D2 == self.origin)
      return self._id_18718F98529A77D8;
  }

  if(isai(self))
    self._id_18718F98529A77D8 = self getEye();
  else {
    self._id_18718F98529A77D8 = self gettagorigin("tag_eye");
    self._id_DF2EC152343705D2 = self.origin;
  }

  self._id_695601297697AB71 = gettime();
  return self._id_18718F98529A77D8;
}

_id_0B071913D4B91319() {
  if(isDefined(self._id_2B5F8CE7DE8E2AF2)) {
    if(self._id_BE76BF1CCA511D73 == gettime())
      return self._id_2B5F8CE7DE8E2AF2;

    if(isDefined(self._id_87B23FA7022B1C46) && self._id_87B23FA7022B1C46 == self.angles)
      return self._id_2B5F8CE7DE8E2AF2;
  }

  self._id_2B5F8CE7DE8E2AF2 = self gettagangles("tag_eye");
  self._id_BE76BF1CCA511D73 = gettime();
  return self._id_2B5F8CE7DE8E2AF2;
}

_id_9A9B91C11482389F(event) {
  _id_9AE80645C2B78E8A = [];

  if(isDefined(self.stealth._id_90CDC499FC2BDDD7))
    _id_9AE80645C2B78E8A = scripts\cp\utility::array_merge(_id_9AE80645C2B78E8A, self.stealth._id_90CDC499FC2BDDD7);

  if(scripts\engine\utility::array_contains(_id_9AE80645C2B78E8A, event.typeorig))
    return 1;

  _id_1C01519BD9CEC9A6 = event.typeorig == "grenade danger" && isDefined(event.entity) && isDefined(event.entity.weapon_name) && (scripts\engine\utility::is_equal(event.entity.weapon_name, "geiger_counter_mp") || scripts\engine\utility::is_equal(event.entity.weapon_name, "gas_mp") || scripts\engine\utility::is_equal(event.entity.weapon_name, "gas_grenade_mp"));

  if(_id_1C01519BD9CEC9A6)
    return 1;

  return 0;
}

go_patrol_the_maze(_id_24C92924FA8F2CFB) {
  self endon("death");
  self notify("go_patrol_the_maze");
  self endon("go_patrol_the_maze");
  self endon("stealth_combat");

  if(isDefined(self.path_data)) {
    if(isDefined(self._id_E72151E692E96CAD)) {
      if(self istouching(self._id_E72151E692E96CAD)) {
        _id_C8B707C031223716 = _id_A186D1F007BC37D3([self], level._id_FB72DCF8512E4800[self.script_stealthgroup], self.script_stealthgroup);
        thread _id_18A73A64992DD07D::go_to_node(_id_C8B707C031223716);
        thread path_loop(_id_24C92924FA8F2CFB);
      } else {}
    } else {}
  }
}

path_loop(_id_24C92924FA8F2CFB) {
  self endon("death");
  self endon("enter_combat");
  self endon("stealth_combat");
  level endon("players_detected");
  self notify("path_loop");
  self endon("path_loop");

  for(;;) {
    if(istrue(_id_24C92924FA8F2CFB))
      result = scripts\engine\utility::waittill_any_return_2("goal", "goal_reached");
    else
      result = scripts\engine\utility::waittill_any_return_3("reached_path_end", "stop_going_to_node", "goal_reached");

    if(istrue(self.scripted_mode)) {
      waitframe();
      continue;
    }

    self.node_grid = scripts\engine\utility::getStructArray("jugg_nav_path", "script_noteworthy");
    _id_D5685B7BAEE6505E = self.origin;
    end_pos = scripts\engine\utility::random(self.node_grid).origin;
    _id_17947F4A9AA52B15 = [self];
    _id_6EE6C2CA7C64E9C9 = spawnStruct();
    _id_6EE6C2CA7C64E9C9.origin = self.origin;

    if(isDefined(self._id_E72151E692E96CAD)) {
      if(self istouching(self._id_E72151E692E96CAD)) {} else {}
    }

    if(isDefined(self._id_E72151E692E96CAD)) {
      while(level._id_FB72DCF8512E4800[self.script_stealthgroup].size == 0)
        waitframe();

      _id_C8B707C031223716 = _id_A186D1F007BC37D3([self], level._id_FB72DCF8512E4800[self.script_stealthgroup], self.script_stealthgroup);
      thread _id_18A73A64992DD07D::go_to_node(_id_C8B707C031223716);
      continue;
    }

    if(isDefined(self._id_E72151E692E96CAD)) {
      while(level._id_FB72DCF8512E4800[self.script_stealthgroup].size == 0)
        waitframe();

      _id_C8B707C031223716 = _id_A186D1F007BC37D3([self], level._id_FB72DCF8512E4800[self.script_stealthgroup], self.script_stealthgroup);
      thread _id_18A73A64992DD07D::go_to_node(_id_C8B707C031223716);
    }
  }
}

order_path_data(path_data, ai) {
  _id_DEC9BCCE93873125 = "jugg_maze_path";
  _id_CF86FC78C966BFBE = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < path_data.path.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(path_data.path[_id_AC0E594AC96AA3A8].script_noteworthy)) {
      continue;
    }
    if(isDefined(path_data.path[_id_AC0E594AC96AA3A8 + 1]) && isstruct(path_data.path[_id_AC0E594AC96AA3A8 + 1])) {
      path_data.path[_id_AC0E594AC96AA3A8].target = _id_DEC9BCCE93873125 + "" + _id_AC0E594AC96AA3A8 + ai getentitynumber();
      path_data.path[_id_AC0E594AC96AA3A8 + 1].targetname = _id_DEC9BCCE93873125 + "" + _id_AC0E594AC96AA3A8 + ai getentitynumber();
      _id_CF86FC78C966BFBE = scripts\engine\utility::array_add(_id_CF86FC78C966BFBE, path_data.path[_id_AC0E594AC96AA3A8]);
      continue;
    }

    _id_CF86FC78C966BFBE = scripts\engine\utility::array_add(_id_CF86FC78C966BFBE, path_data.path[_id_AC0E594AC96AA3A8]);

    if(path_data.path[_id_AC0E594AC96AA3A8] != path_data.end_node) {
      path_data.end_node.targetname = _id_DEC9BCCE93873125 + "" + _id_AC0E594AC96AA3A8 + ai getentitynumber();
      _id_CF86FC78C966BFBE = scripts\engine\utility::array_add(_id_CF86FC78C966BFBE, path_data.end_node);
    }
  }

  return _id_CF86FC78C966BFBE;
}

node_is_valid(node, _id_17947F4A9AA52B15, _id_1BFA180C6FDD09DD) {
  if(istrue(node.claimed))
    return 0;

  startpos = node.origin + (0, 0, 256);
  endpos = node.origin + (0, 0, 128);
  return scripts\engine\trace::sphere_trace_passed(startpos, endpos, 72, _id_17947F4A9AA52B15, _id_1BFA180C6FDD09DD);
}

set_maze_ai_state(state) {
  self.current_state = self.current_state | state;
}

force_maze_ai_state(state) {
  self.current_state = state;
}

check_maze_ai_state(state) {
  return self.current_state &state;
}

sound_distraction_mechanic_init() {
  level.sound_events = ["dx_vom_bkv_entrance_intercom_10", "dx_vom_bkv_dragons_breath_clear_10"];
  level.pasystems = getEntArray("pa_system", "targetname");
  level thread periodic_sound_events();
}

turbine_spin() {
  level endon("escaped_maze");
  time = 0.1 + randomfloatrange(0.5, 1.5);

  for(;;) {
    self rotatepitch(360, time);
    wait(time);
  }
}

alarm_audio() {
  self endon("stop_alarm");
  level endon("escaped_maze");

  for(;;) {
    scripts\engine\utility::play_sound_in_space("indoor_alarm");
    wait 2.5;
  }
}

periodic_sound_events() {
  level endon("escaped_maze");

  for(;;) {
    wait(randomintrange(15, 30));
    play_random_sound_event();
  }
}

play_random_sound_event() {
  _id_78786E87E7996E27 = scripts\engine\utility::random(level.sound_events);

  if(isDefined(_id_78786E87E7996E27)) {
    level.ai_deaf_event_active = 1;
    _id_40CDBACDA5CCA105 = lookupsoundlength(_id_78786E87E7996E27) / 1000;
    level thread play_sound_on_pa_systems(_id_78786E87E7996E27, _id_40CDBACDA5CCA105);
    wait(_id_40CDBACDA5CCA105);
    level.ai_deaf_event_active = undefined;
  }
}

play_sound_on_pa_systems(_id_78786E87E7996E27, _id_40CDBACDA5CCA105) {
  foreach(_id_51567E5C2A1B6703 in level.pasystems) {
    scripts\cp\utility::playsoundatpos_safe(_id_51567E5C2A1B6703.origin, _id_78786E87E7996E27);
    level thread deafen_ai_near_pa_for_duration(_id_51567E5C2A1B6703, _id_40CDBACDA5CCA105);
  }
}

deafen_ai_near_pa_for_duration(_id_51567E5C2A1B6703, _id_40CDBACDA5CCA105) {
  foreach(ai in getaiarray("axis")) {
    if(scripts\engine\utility::distance_2d_squared(ai.origin, _id_51567E5C2A1B6703.origin) <= 11108889)
      ai thread deafen_ai(_id_40CDBACDA5CCA105);
  }
}

deafen_ai(_id_40CDBACDA5CCA105) {
  self endon("death");
  self.bisdeaf = 1;
  wait(_id_40CDBACDA5CCA105);
  self.bisdeaf = undefined;
}

maze_ai_setup() {
  createthreatbiasgroup("juggernaut");
  setthreatbias("allies", "juggernaut", 8600);
  setthreatbias("player", "juggernaut", 9000);
}

notify_whizby_from_player() {
  level endon("escaped_maze");
  self endon("death");

  for(;;) {
    self waittill("bulletwhizby", _id_7176B6A64D4D823B);

    foreach(player in level.players) {
      if(scripts\engine\utility::is_equal(_id_7176B6A64D4D823B, player))
        self notify("heard_player");
    }
  }
}

set_favoriteenemy(enemy) {
  self.favoriteenemy = enemy;
}

set_pacifist(val) {
  self.pacifist = val;
}

_id_0F5B7D094EEBD9B3(loc, player) {
  _id_310236DBF257FBB5 = getaiarray("axis");
  count = min(_id_310236DBF257FBB5.size, 6);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < count; _id_AC0E594AC96AA3A8++) {
    waitframe();
    _id_3114816C58D0AA74 = (_id_AC0E594AC96AA3A8 + 1) / count;

    if(scripts\engine\utility::_id_51D76700600CEBE3((1 - _id_3114816C58D0AA74) * 30)) {
      continue;
    }
    guy = _id_310236DBF257FBB5[_id_AC0E594AC96AA3A8];

    if(!isalive(guy)) {
      continue;
    }
    team = guy.team;
    origin = guy.origin;

    if(!isDefined(team) || !isDefined(origin)) {
      continue;
    }
    state = guy _id_35DE402EFC5ACFB3::_id_16DCE705F14F4B84();

    if(!isDefined(state) || !isDefined(guy.team)) {
      continue;
    }
    if(state == "dead" || guy.team == "neutral") {
      continue;
    }
    angles = vectortoangles(loc - guy.origin);
    _id_0C3EA9B1A20FF199 = player.origin;

    if(!isDefined(player))
      player = scripts\engine\utility::random(level.players);

    guy aieventlistenerevent("investigate", player, loc);
    waitframe();
    guy._id_97DB6F81BA0702E3 = 90000;
    guy._id_93B8288EFB765770 = 90000;
    wait 1;
  }
}

_id_C5979FDECB85AC32(_id_EED0FCEBA34FF33F, _id_F014A33EDFFB2257, _id_FD512F8CF22B3EE7, _id_EE15985E13898AAC, _id_8197815F9318ED3E, _id_511FC16EA22F749C) {
  level endon("game_ended");
  keycard = undefined;

  if(isDefined(_id_EED0FCEBA34FF33F))
    keycard = _id_EED0FCEBA34FF33F;
  else {
    switch (level._id_21CC7CF44C9FAFCE.script_noteworthy) {
      case "core_location_room_3":
        keycard = level._id_DA342BD05311B053[0];
        break;
      case "core_location_room_4":
        keycard = level._id_DA342BD05311B053[1];
        break;
      default:
        break;
    }
  }

  if(!istrue(_id_EE15985E13898AAC)) {
    level._id_12DDC19216A77181 = keycard;
    level._id_2DFA52A052B72AFA._id_9495681C4A644AA1 = level._id_12DDC19216A77181;
    level._id_2DFA52A052B72AFA._id_B97BBDA2597193F1 = scripts\engine\utility::getclosest(level._id_2DFA52A052B72AFA.origin, level._id_1C8FC4D6F9FCF7ED);
    level._id_2DFA52A052B72AFA _id_6B18C507926DD700::setvisibleteam("any");
  }

  if(!isDefined(_id_F014A33EDFFB2257))
    _id_F014A33EDFFB2257 = (0, 0, 0);

  _id_447F40C814B97CDC = self;

  if(!isent(self))
    _id_447F40C814B97CDC = undefined;

  _id_CB4FAD49263E20C4 = undefined;

  if(!istrue(_id_511FC16EA22F749C)) {
    baseorigin = getclosestpointonnavmesh(self.origin) + (0, 0, 64);
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdroporiginandangles(0, baseorigin, self.angles, _id_447F40C814B97CDC);
  } else {
    _id_CB4FAD49263E20C4 = spawnStruct();
    _id_CB4FAD49263E20C4.origin = self.origin;

    if(isDefined(self.angles))
      _id_CB4FAD49263E20C4.angles = self.angles;
    else
      _id_CB4FAD49263E20C4.angles = (0, 0, 0);

    _id_CB4FAD49263E20C4.payload = 0;
  }

  item = _id_66122A002AFF5D57::spawnpickup(keycard, _id_CB4FAD49263E20C4, 1, 1, undefined, 0);
  level thread _id_6C7DD7C0C3A453B1(_id_CB4FAD49263E20C4);

  if(!istrue(_id_FD512F8CF22B3EE7))
    level thread _id_91E8BF59BDBB9A6D(keycard, undefined, item, _id_8197815F9318ED3E);
}

_id_91E8BF59BDBB9A6D(_id_CFD7C318C9B9CF4D, _id_5B30935A93682242, pickup, _id_8197815F9318ED3E) {
  level endon("game_ended");
  level notify("maze_jugg_key_pickup_created", pickup);

  for(;;) {
    level waittill("pickedup_loot_success", _id_5BA045294C1D4D1B, player);

    if(!isPlayer(player) || _id_CFD7C318C9B9CF4D != _id_5BA045294C1D4D1B) {
      waitframe();
      continue;
    }

    if(!istrue(level._id_A8353BB50301BEEA))
      level._id_A8353BB50301BEEA = 1;

    level._id_2313A19F59121665 = player;
    player thread _id_1E337E98B672B9EA(_id_5BA045294C1D4D1B);

    if(istrue(_id_8197815F9318ED3E))
      player thread _id_CBDA750AA59E94C9(_id_5BA045294C1D4D1B);
  }
}

_id_1E337E98B672B9EA(_id_5BA045294C1D4D1B) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("watch_for_keycard_drop");
  self endon("watch_for_keycard_drop");

  if(!isDefined(self._id_F793C712094E383C))
    self._id_F793C712094E383C = scripts\cp\utility::set_carry_item(self, "raid_keycard");

  self waittill("dropped_backpack_item", _id_76F4143215683892);

  if(_id_76F4143215683892.type == _id_5BA045294C1D4D1B) {
    self notify("dropped_keycard");
    level._id_2313A19F59121665 = undefined;
    level thread _id_91E8BF59BDBB9A6D(_id_76F4143215683892.type, 1);

    if(isDefined(self._id_F793C712094E383C)) {
      scripts\cp\utility::_id_98F7CA3781DAC77C(self, self._id_F793C712094E383C.carry_ref);
      self._id_F793C712094E383C = undefined;
    }
  }
}

_id_CBDA750AA59E94C9(_id_5BA045294C1D4D1B) {
  level endon("game_ended");
  level endon("topdoor_opened");
  self endon("dropped_keycard");
  scripts\engine\utility::waittill_any_3("laststand", "death", "entered_spectate");
  _id_55C80BAE27E47104 = _id_66122A002AFF5D57::_id_F8D85C542911E3A9(self, _id_5BA045294C1D4D1B);

  if(!isDefined(_id_55C80BAE27E47104)) {
    return;
  }
  _id_531CB1BE084314F7::_id_DB1DD76061352E5B(_id_55C80BAE27E47104, 1);
  thread scripts\cp\cp_hud_message::tutorialprint(&"CP_TRAP_ROOM/KEYCARD_RUINED", 2);
  level notify("topkeycard_destroyed");
}

_id_6C7DD7C0C3A453B1(_id_CB4FAD49263E20C4) {
  level endon("game_ended");

  if(isDefined(level._id_C4C8367CD1872DBC)) {
    return;
  }
  icon = "ui_mp_br_loot_icon_keycard";
  offset = 36;
  _id_DA337D5FD8067F7A = 1;
  level._id_C4C8367CD1872DBC = scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.players, icon, offset, 0, 230, 75, 0, 0, _id_DA337D5FD8067F7A, _id_CB4FAD49263E20C4.origin, 0);

  while(!isDefined(level._id_2313A19F59121665))
    wait 0.05;

  if(isDefined(level._id_C4C8367CD1872DBC)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(level._id_C4C8367CD1872DBC);
    level._id_C4C8367CD1872DBC = undefined;
  }
}

_id_A5AA158578694A69(player, _id_48ACCC37953CFC3B, _id_477C1209E5432ABE) {
  _id_6FBEA72303085C6F(player, scripts\common\utility::_id_B88F4E5BAFF057A9(_id_48ACCC37953CFC3B), _id_477C1209E5432ABE);
}

_id_C0FACA532411608C(player) {
  _id_1E1767FDC6980106(player);
}

_id_6FBEA72303085C6F(ent, speed, _id_477C1209E5432ABE, offset) {
  if(!isDefined(self.lookatentities))
    self.lookatentities = [];

  if(!self.lookatentities.size)
    self _meth_1C339DAABA3F71DB(1);

  self.lookatentities[self.lookatentities.size] = ent;

  if(isDefined(speed))
    self _meth_106BCE0AEEE91D2C(speed);

  if(isDefined(_id_477C1209E5432ABE))
    self _meth_6DC7C9BE085F4137(_id_477C1209E5432ABE);

  if(isPlayer(ent))
    self _meth_5621E511B99964A7(ent);
  else {
    if(isDefined(offset))
      ent._id_64B4740234F03713 = offset;
    else
      offset = (0, 0, 0);

    self _meth_06EF849BEE4B12DD(ent, offset);
  }
}

_id_1E1767FDC6980106(ent) {
  if(!isDefined(self.lookatentities) || !scripts\engine\utility::array_contains(self.lookatentities, ent)) {
    return;
  }
  lookingatent = scripts\engine\utility::_id_350E192B13BEA45C(self.lookatentities) == ent;
  self.lookatentities = scripts\engine\utility::_id_57091B2D67654A14(self.lookatentities, ent);
  self.lookatentities = scripts\engine\utility::array_removeundefined(self.lookatentities);

  if(isDefined(ent._id_64B4740234F03713))
    ent._id_64B4740234F03713 = undefined;

  if(lookingatent) {
    if(isPlayer(ent))
      self _meth_504A5E2DF31069A4();

    if(self.lookatentities.size > 0) {
      _id_180BBBD4951D78AD = scripts\engine\utility::_id_350E192B13BEA45C(self.lookatentities);

      if(isPlayer(_id_180BBBD4951D78AD))
        self _meth_5621E511B99964A7(_id_180BBBD4951D78AD);
      else {
        offset = scripts\engine\utility::_id_53C4C53197386572(_id_180BBBD4951D78AD._id_64B4740234F03713, (0, 0, 0));
        self _meth_06EF849BEE4B12DD(_id_180BBBD4951D78AD, offset);
      }
    }
  }

  if(!self.lookatentities.size) {
    self _meth_1C339DAABA3F71DB(0);
    self stoplookat();
  }
}

_id_15DC13DCB9303962(player) {
  return _id_E98030C52E2F3EEC(player);
}

_id_E98030C52E2F3EEC(ent) {
  return scripts\engine\utility::is_equal(ent, _id_163FD34FC07D2B8A());
}

_id_163FD34FC07D2B8A() {
  if(!isDefined(self.lookatentities) || !self.lookatentities.size)
    return undefined;

  return scripts\engine\utility::_id_350E192B13BEA45C(self.lookatentities);
}

_id_2C49ADD797A42AAB(guys, maxdist) {
  if(!isDefined(self._id_C15AC68FC63FC9A8) || !self._id_C15AC68FC63FC9A8) {
    return;
  }
  guys = scripts\engine\utility::array_removedead(guys);
  guy = scripts\engine\utility::random(guys);

  if(guys.size < 2) {
    return;
  }
  if(!isDefined(guy) || vectordot(self.origin, guy.origin) < 0) {
    return;
  }
  if(guy == self) {
    _id_C38D71F632B89906();
    return;
  }

  if(isDefined(self._id_85F04BF47BF39FF6) && self._id_85F04BF47BF39FF6 == guy) {
    self._id_85F04BF47BF39FF6 = undefined;
    return;
  }

  if(isDefined(maxdist) && distancesquared(self.origin, guy.origin) > maxdist * maxdist) {
    return;
  }
  if(vectordot(self.origin, guy.origin) <= 0) {
    return;
  }
  self._id_85F04BF47BF39FF6 = guy;
  _id_9FADCB46C7EF90A0(guy);
}

_id_C38D71F632B89906() {
  if(!isDefined(self) || !isent(self)) {
    return;
  }
  minidletime = 2;
  _id_E7FC8C00DAB4CA1A = 4;
  self _meth_1C339DAABA3F71DB(0);
  wait(randomfloatrange(minidletime, _id_E7FC8C00DAB4CA1A));
  self _meth_1C339DAABA3F71DB(1);
}

_id_9FADCB46C7EF90A0(other) {
  _id_477C1209E5432ABE = 0.8;
  speed = 1;
  _id_6FBEA72303085C6F(other, scripts\common\utility::_id_B88F4E5BAFF057A9(speed), _id_477C1209E5432ABE);
  _id_08660E4BE5019B5F = 0.5;
  _id_CF84BB92B95910ED = 1;

  if(isDefined(other)) {
    if(self.team == other.team) {
      _id_08660E4BE5019B5F = 1.5;
      _id_CF84BB92B95910ED = 2.5;
    } else {
      _id_08660E4BE5019B5F = 1;
      _id_CF84BB92B95910ED = 1.5;
    }
  }

  wait(randomfloatrange(_id_08660E4BE5019B5F, _id_CF84BB92B95910ED));
}

_id_587202DCEF401B18(player, _id_E12B2113162EE01E, _id_54C8809356DFAEAF) {
  self._id_1C1F7BC9AB4D2C62 = 1;
  _id_A5AA158578694A69(player, _id_E12B2113162EE01E);
  _id_B3962FE002947207(player.origin, _id_54C8809356DFAEAF);
}

_id_E530C39362E2935B(player, _id_E12B2113162EE01E) {
  self endon("death");
  self endon("stop_turnInPlace");
  self._id_1C1F7BC9AB4D2C62 = 1;
  _id_A5AA158578694A69(player, _id_E12B2113162EE01E);

  for(;;) {
    _id_B3962FE002947207(player.origin);

    while(scripts\engine\utility::within_fov(self.origin, self.angles, player.origin, cos(30)))
      waitframe();
  }
}

_id_815B24F247658730(player, _id_F2DFF4A684254CD3) {
  self notify("stop_turnInPlace");
  _id_C0FACA532411608C(player);

  if(istrue(_id_F2DFF4A684254CD3) && isDefined(self.target))
    thread _id_18A73A64992DD07D::go_to_node();

  self._id_1C1F7BC9AB4D2C62 = undefined;
}

_id_B3962FE002947207(origin, _id_54C8809356DFAEAF) {
  _id_C960359186200593(vectortoangles(origin - self.origin), _id_54C8809356DFAEAF);
}

_id_C960359186200593(angles, _id_54C8809356DFAEAF) {
  self endon("death");
  self endon("stop_turnInPlace");
  struct = spawnStruct();
  struct.origin = self.origin;
  struct.angles = angles;
  _id_AE657F6A5F7BBF83 = self.script_forcegoal;
  self.script_forcegoal = 1;
  _id_18A73A64992DD07D::go_to_node(struct);
  self.script_forcegoal = _id_AE657F6A5F7BBF83;

  if(istrue(_id_54C8809356DFAEAF)) {
    while(abs(self.angles[1] - struct.angles[1]) > 5)
      waitframe();
  }
}