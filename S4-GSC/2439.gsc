/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2439.gsc
*************************************************/

_id_8543(var_0) {
  if(!isDefined(level._id_3BE9._id_0F51)) {
    return 0;
  }

  return level._id_3BE9._id_0F51 == var_0;
}

is_dark_aether(var_0) {
  return isDefined(var_0._id_96CF._id_0481) && var_0._id_96CF._id_0481 == "objectives_location_dark_aether";
}

_id_BB93() {
  level._id_A382 = 0;
  level._id_A88F = [];
  level._id_A88F[level._id_A88F.size] = "holdout";
  level._id_A88F[level._id_A88F.size] = "soul_capture";
  level._id_A88F[level._id_A88F.size] = "exfil";
  level._id_A88F[level._id_A88F.size] = "orb_follow";
  level._id_A88F[level._id_A88F.size] = "domination";
  level._id_A88F[level._id_A88F.size] = "forever_blitz";
  level._id_A88F[level._id_A88F.size] = "assault";
  _set_random_categories();

  if(scripts\engine\utility::is_equal(getdvarint("#x3ce6f1c71a4bdefaa", 0), 1)) {
    _insert_mandatory_category("assault");
  } else {
    _insert_mandatory_category("domination");
  }

  level._id_A88A = _func_03F0();
  level.objective_instance_limit = level._id_A88A * 8;
  level._id_A88B = [];
  level.objective_marker_instances = [];
  _id_06CB::_id_AA4A(::_id_AA59);
  _id_06CB::on_host_migration_end(::host_migration_end);
}

_set_random_categories() {
  level._id_A86A = [];
  level._id_A86A[level._id_A86A.size] = "holdout";
  level._id_A86A[level._id_A86A.size] = "soul_capture";
  level._id_A86A[level._id_A86A.size] = "exfil";
  level._id_A86A[level._id_A86A.size] = "orb_follow";
  level._id_A86A[level._id_A86A.size] = "forever_blitz";
  level._id_A86A[level._id_A86A.size] = "assault";
  level._id_A86A[level._id_A86A.size] = "domination";
  level._id_A86A = scripts\engine\utility::array_randomize(level._id_A86A);
}

_insert_mandatory_category(var_0) {
  var_1 = randomint(2);
  level._id_A86A = scripts\engine\utility::_id_1BB3(level._id_A86A, var_0, var_1);
}

_id_5A9A() {
  _id_0986::init();
  _id_0989::init();

  if(!getdvarint("#x3dee089cb49164e4e", 0)) {
    _id_0985::init();
  }

  _id_0988::init();
  _id_0984::init();
  level thread season_objectives_init();
  level scripts\engine\utility::_id_5C1B("spawn_zombies");
}

_id_C215(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = _id_06EF::_id_C215(var_0, scripts\cp\utility::_id_459B(var_9, ::_id_E1A3));
  var_12._id_A8F5 = var_1;
  var_12._id_A8F7 = var_3;
  var_12.objectivesetupcallback = var_2;
  var_12.objectivecleanupcallback = var_4;
  var_12.objectivehotjoincallback = var_11;
  var_12._id_A8D5 = var_5;
  var_12._id_5255 = var_7;
  var_12._id_A8FB = var_8;
  var_12._id_A8FD = var_6;
}

_id_0FFD(var_0, var_1) {
  if(!isDefined(var_0) || !_func_0121(var_0) || var_0 == "") {}

  if(!istrue(level.soak_testing)) {}

  var_2 = undefined;

  if(isDefined(var_1) && isDefined(var_1._id_9B54)) {
    var_2 = var_1._id_9B54;
  }

  var_3 = _id_660B(var_0, var_2);

  if(!istrue(level.soak_testing)) {}

  var_4 = 0;

  if(var_3 == -1) {
    var_5 = spawnStruct();

    for(var_5.label = var_0; isDefined(level._id_A88B[var_4]); var_4++) {}

    level._id_A88B[var_4] = var_5;
    _id_FB90(var_4, var_1);
  }

  return var_4;
}

add_instanced_objective_marker(var_0, var_1) {
  if(!isDefined(level.objective_marker_instances[var_0])) {
    level.objective_marker_instances[var_0] = spawnStruct();
    level.objective_marker_instances[var_0].activeinstances = [];
  }

  var_2 = level.objective_marker_instances[var_0];

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = get_first_free_instance_index(var_2);

  if(var_3 >= 8) {
    var_3 = add_instanced_objective_marker(var_0 + "_sub", var_1) + 8;
    var_2.hasexceededlocationmax = 1;
  } else {
    if(!isDefined(var_2.markerparams)) {
      var_2.markerparams = spawnStruct();
    }

    var_4 = get_changed_params(var_2.markerparams, var_1);
    var_4._id_9B54 = var_2.markerparams._id_9B54;
    var_4._id_96D8 = var_3;
    var_4._id_11012 = var_1._id_11012;
    var_5 = get_lowest_used_objective_marker_instance_index(var_2);

    if(var_5 == -1 || var_5 >= 8) {
      var_2.markerparams._id_9B54 = _id_0FFD(var_0, var_4);
    } else {
      _id_FB91(var_0, var_4);
    }
  }

  var_2.activeinstances[var_3] = 1;
  return var_3;
}

get_changed_params(var_0, var_1) {
  var_2 = spawnStruct();

  if(!scripts\engine\utility::is_equal(var_0._id_E747, var_1._id_E747)) {
    var_2._id_E747 = var_1._id_E747;
    var_0._id_E747 = var_1._id_E747;
  }

  if(!scripts\engine\utility::is_equal(var_0.label, var_1.label)) {
    var_2.label = var_1.label;
    var_0.label = var_1.label;
  }

  if(!scripts\engine\utility::is_equal(var_0._id_11012, var_1._id_11012)) {
    var_2._id_11012 = var_1._id_11012;
    var_0._id_11012 = var_1._id_11012;
  }

  if(!scripts\engine\utility::is_equal(var_0._id_96DE, var_1._id_96DE)) {
    var_2._id_96DE = var_1._id_96DE;
    var_0._id_96DE = var_1._id_96DE;
  }

  if(!scripts\engine\utility::is_equal(var_0.isunset, var_1.isunset)) {
    var_2.isunset = var_1.isunset;
    var_0.isunset = var_1.isunset;
  }

  if(!scripts\engine\utility::is_equal(var_0._id_96CF, var_1._id_96CF)) {
    var_2._id_96CF = var_1._id_96CF;
    var_0._id_96CF = var_1._id_96CF;
  }

  if(!scripts\engine\utility::is_equal(var_0._id_96D8, var_1._id_96D8)) {
    var_2._id_96D8 = var_1._id_96D8;
    var_0._id_96D8 = var_1._id_96D8;
  }

  if(!scripts\engine\utility::is_equal(var_0._id_DCEA, var_1._id_DCEA)) {
    var_2._id_DCEA = var_1._id_DCEA;
    var_0._id_DCEA = var_1._id_DCEA;
  }

  if(!scripts\engine\utility::is_equal(var_0._id_BD95, var_1._id_BD95)) {
    var_2._id_BD95 = var_1._id_BD95;
    var_0._id_BD95 = var_1._id_BD95;
  }

  if(!scripts\engine\utility::is_equal(var_0._id_D652, var_1._id_D652)) {
    var_2._id_D652 = var_1._id_D652;
    var_0._id_D652 = var_1._id_D652;
  }

  if(!scripts\engine\utility::is_equal(var_0._id_7C3B, var_1._id_7C3B)) {
    var_2._id_7C3B = var_1._id_7C3B;
    var_0._id_7C3B = var_1._id_7C3B;
  }

  if(!scripts\engine\utility::is_equal(var_0.minimapiconsize, var_1.minimapiconsize)) {
    var_2.minimapiconsize = var_1.minimapiconsize;
    var_0.minimapiconsize = var_1.minimapiconsize;
  }

  if(!scripts\engine\utility::is_equal(var_0.hideonminimapwhenclipped, var_1.hideonminimapwhenclipped)) {
    var_2.hideonminimapwhenclipped = var_1.hideonminimapwhenclipped;
    var_0.hideonminimapwhenclipped = var_1.hideonminimapwhenclipped;
  }

  if(!scripts\engine\utility::is_equal(var_0.setbackground, var_1.setbackground)) {
    var_2.setbackground = var_1.setbackground;
    var_0.setbackground = var_1.setbackground;
  }

  if(!scripts\engine\utility::is_equal(var_0.team, var_1.team)) {
    var_2.team = var_1.team;
    var_0.team = var_1.team;
  }

  return var_2;
}

get_first_free_instance_index(var_0) {
  if(!_func_0107(var_0.activeinstances)) {
    return -1;
  }

  var_1 = get_highest_used_objective_marker_instance_index(var_0);
  var_2 = var_0.activeinstances.size;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    if(!isDefined(var_0.activeinstances[var_3])) {
      var_2 = var_3;
      break;
    }
  }

  return var_2;
}

get_highest_used_objective_marker_instance_index(var_0) {
  if(!_func_0107(var_0.activeinstances)) {
    return -1;
  }

  var_1 = 0;

  foreach(var_4, var_3 in var_0.activeinstances) {
    if(var_4 > var_1) {
      var_1 = var_4;
    }
  }

  return var_1;
}

get_lowest_used_objective_marker_instance_index(var_0) {
  if(!_func_0107(var_0.activeinstances)) {
    return -1;
  }

  var_1 = level.objective_instance_limit;
  var_2 = var_1;

  foreach(var_5, var_4 in var_0.activeinstances) {
    if(var_5 < var_2) {
      var_2 = var_5;
    }
  }

  if(var_2 == var_1) {
    return -1;
  }

  return var_2;
}

_id_FB91(var_0, var_1) {
  if(!isDefined(var_0) || !_func_0121(var_0) || var_0 == "") {}

  var_2 = undefined;

  if(isDefined(var_1) && isDefined(var_1._id_9B54)) {
    var_2 = var_1._id_9B54;
  }

  var_3 = _id_660B(var_0, var_2);

  if(!istrue(level.soak_testing)) {}

  _id_FB90(var_3, var_1);
}

_id_FB90(var_0, var_1) {
  if(istrue(level.soak_testing) && (var_0 == -1 || var_0 > level._id_A88A - 1 || !isDefined(level._id_A88B[var_0]))) {
    return;
  }
  if(isDefined(var_1._id_E747)) {
    switch (var_1._id_E747) {
      case "current":
      case "failed":
      case "done":
      case "invisible":
      case "active":
        _func_016B(var_0, var_1._id_E747);
        break;
      default:
        break;
    }
  }

  if(isDefined(var_1.label)) {
    _func_0167(var_0, var_1.label);
  }

  var_2 = undefined;

  if(isDefined(var_1._id_11012)) {
    var_2 = (0, 0, 1) * var_1._id_11012;
    _func_0161(var_0, var_1._id_11012);
  }

  if(isDefined(var_1._id_96DE) && _func_0107(var_1._id_96DE)) {
    foreach(var_4 in var_1._id_96DE) {
      if(isDefined(var_4.index)) {
        if(istrue(var_4.isunset)) {
          _func_0165(var_0, var_4.index);
          continue;
        }

        if(isDefined(var_4._id_96CF)) {
          var_5 = var_4._id_96CF;

          if(!isent(var_5) && isvector(var_2)) {
            var_5 = var_5 + var_2;
          }

          _func_0164(var_0, var_4.index, var_5);
        }
      }
    }
  } else {
    var_7 = scripts\cp\utility::_id_459B(var_1._id_96D8, 0);

    if(istrue(var_1.isunset)) {
      _func_0165(var_0, var_7);
    } else if(isDefined(var_1._id_96CF)) {
      var_5 = var_1._id_96CF;

      if(!isent(var_5) && isvector(var_2)) {
        var_5 = var_5 + var_2;
      }

      _func_0164(var_0, var_7, var_5);
    }
  }

  if(isDefined(var_1._id_DCEA)) {
    _func_017B(var_0, var_1._id_DCEA);
  }

  if(isDefined(var_1._id_BD95)) {
    _func_0180(var_0, var_1._id_BD95);
  }

  if(isDefined(var_1._id_D652)) {
    _func_016C(var_0, var_1._id_D652);
  }

  if(isDefined(var_1._id_7C3B)) {
    _func_015D(var_0, var_1._id_7C3B);
  }

  if(isDefined(var_1.minimapiconsize)) {
    _func_0179(var_0, var_1.minimapiconsize);
  }

  if(isDefined(var_1.hideonminimapwhenclipped)) {
    _func_0449(var_0, var_1.hideonminimapwhenclipped);
  }

  if(isDefined(var_1.setbackground)) {
    _func_017A(var_0, var_1.setbackground);
  }

  if(isDefined(var_1.showsdistance)) {
    _func_0176(var_0, var_1.showsdistance);
  }

  if(isDefined(var_1.team)) {
    _func_0182(var_0, var_1.team);
  }
}

_id_C413(var_0, var_1) {
  if(!isDefined(var_0) || !_func_0121(var_0) || var_0 == "") {}

  if(is_invalid_objective_marker(var_0, var_1)) {
    return;
  }
  var_2 = _id_660B(var_0, var_1);
  _id_C412(var_2);
  return var_2;
}

remove_instanced_objective_marker(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = level.objective_marker_instances[var_0];

  if(!isDefined(var_2) || !isDefined(var_2.activeinstances[var_1])) {
    return;
  }
  var_3 = istrue(var_2.hasexceededlocationmax) && var_1 >= 8;

  if(var_3) {
    remove_instanced_objective_marker(var_0 + "_sub", var_1 - 8);
    var_2.activeinstances[var_1] = undefined;

    if(var_2.activeinstances.size == 0) {
      level.objective_marker_instances[var_0] = undefined;
    }
  } else {
    var_2.markerparams.isunset = 1;
    var_2.markerparams._id_96D8 = var_1;
    _id_FB91(var_0, var_2.markerparams);
    var_2.markerparams.isunset = undefined;
    var_2.activeinstances[var_1] = undefined;
    var_4 = get_lowest_used_objective_marker_instance_index(var_2);

    if(var_4 == -1 || var_4 >= 8) {
      _id_C413(var_0, var_2.makerparams);

      if(var_4 == -1) {
        level.objective_marker_instances[var_0] = undefined;
      }
    }
  }

  var_2.hasexceededlocationmax = 0;

  foreach(var_7, var_6 in var_2.activeinstances) {
    if(int(var_7) >= 8) {
      var_2.hasexceededlocationmax = 1;
      break;
    }
  }
}

is_invalid_objective_marker(var_0, var_1) {
  return _id_660B(var_0, var_1) == -1;
}

_id_C412(var_0) {
  if(istrue(level.soak_testing) && (var_0 > level._id_A88A - 1 || var_0 < 0 || !isDefined(level._id_A88B[var_0]))) {
    return;
  }
  _func_015C(var_0);
  level._id_A88B = scripts\engine\utility::array_remove_index(level._id_A88B, var_0, 1);
}

_id_660B(var_0, var_1) {
  if(!isDefined(var_0) || !_func_0121(var_0) || var_0 == "") {}

  if(isDefined(var_1) && isDefined(level._id_A88B[var_1]) && level._id_A88B[var_1].label == var_0) {
    if(istrue(level.soak_testing) && var_1 > level._id_A88A - 1) {
      return level._id_A88A - 1;
    }

    return var_1;
  }

  if(!isDefined(var_0)) {
    return -1;
  }

  foreach(var_4, var_3 in level._id_A88B) {
    if(var_3.label == var_0) {
      if(istrue(level.soak_testing) && var_4 > level._id_A88A - 1) {
        return level._id_A88A - 1;
      }

      return var_4;
    }
  }

  return -1;
}

add_location_ammo_cache_markers(var_0) {
  var_1 = var_0._id_3BE8["ammo_cache"];

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  foreach(var_3 in var_1) {
    var_4 = spawnStruct();
    var_4._id_E747 = "active";
    var_4._id_96CF = var_3.origin;
    var_4._id_7C3B = "v_ui_icons_zombies_minimap_ammocache";
    var_4.minimapiconsize = "icon_regular";
    var_4.hideonminimapwhenclipped = 1;
    var_4.setbackground = 1;
    var_3.markerlabel = var_0._id_0481 + "_" + var_3._id_039B;
    var_3.instanceindex = add_instanced_objective_marker(var_3.markerlabel, var_4);
    waitframe();
  }
}

remove_location_ammo_cache_markers(var_0) {
  var_1 = var_0._id_3BE8["ammo_cache"];

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  foreach(var_3 in var_1) {
    remove_instanced_objective_marker(var_3.markerlabel, var_3.instanceindex);
    var_3.markerlabel = undefined;
    var_3.instanceindex = undefined;
    waitframe();

    if(isDefined(var_3.markerent)) {
      var_3.markerent delete();
    }
  }
}

_id_A871(var_0, var_1, var_2) {
  if(_id_0726::_id_60B9()) {
    level.lastobjective = undefined;
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(level._id_3BE9._id_0F51)) {
    level.lastobjective = undefined;
    return;
  }

  if(isDefined(level._id_3BE9) && isDefined(level._id_3BE9._id_0F51)) {
    level.lastobjective = level._id_3BE9._id_0F51._id_0481;
  }

  if(var_1) {
    level notify("begin_successful_objective_ended");
  }

  level._id_3BE9._id_A8D9 = level._id_3BE9._id_0F51;
  level._id_3BE9._id_0F51 = undefined;
  clear_objective_item_positions();
  level _id_06CB::remove_on_ai_spawned(::on_objective_ai_spawned);
  level thread scripts\cp\zombies\zm_hub_portals::update_objective_portal(var_0);
  level.active_objective_instances = scripts\engine\utility::array_remove(level.active_objective_instances, var_0);

  if(var_1) {
    level thread _id_0991::_id_E8E2(1);
    level thread kill_all_objective_zombies();
    level thread _id_0991::reset_spawn_manager_active_zombie_info();
    reset_all_player_objective_kill_tracking();
    level _id_4BE2();
    level thread play_completed_narration(var_0);
    level _id_6F39(var_0);
    var_3 = 15;

    if(isDefined(level.n_objective_wait_after_completion_override)) {
      var_3 = level.n_objective_wait_after_completion_override;
    }

    if(var_3 > 0) {
      wait(var_3);
    }

    level._id_11049 = scripts\cp\utility::_id_459B(level._id_11049, 1);
    var_4 = level._id_11049;
    level thread _id_072E::setjiprulesbyround();
    var_5 = 1;

    if(scripts\engine\utility::is_equal(var_0._id_3BE5, "forever_blitz")) {
      var_5 = 0;
    }

    if(var_5) {
      level._id_11049++;
    }

    level thread scripts\cp\zombies\zm_hub_unlock::queue_wall_refresh("portal_activated");
    level thread refresh_hub(var_0);
    level thread _id_F02C(var_0, "start_interact");
    level thread _id_385C(10, var_0);

    foreach(var_9, var_7 in level.players) {
      var_8 = level.players[var_9];
      var_8.pers["telemetry"].first_weapon_in_round_end_time = _func_00D7();
    }

    scripts\cp\telemetry_cp::logevent_weaponinfo();

    foreach(var_9, var_7 in level.players) {
      var_8 = level.players[var_9];
      var_11 = var_8 getcurrentprimaryweapon();
      var_12 = getweaponbasename(var_11);
      var_8.pers["telemetry"].first_weapon_in_round_base_name = var_12;
      var_8.pers["telemetry"].first_weapon_in_round_start_time = _func_00D7();
      var_8.pers["telemetry"].first_weapon_in_round_end_time = undefined;
    }

    level waittill("players_landed");
    _id_074D::set_minimap_icon_persistent(1);
    level thread remove_location_ammo_cache_markers(var_0._id_96CF);

    if(isDefined(level._id_3BE9._id_A8D9._id_110AC)) {
      var_0._id_110AC = 0;
    }

    _id_072A::setperroundxp("default", level._id_11049);

    if(var_5) {
      level thread update_round_tracker_hud(var_0.hide_round_message_hud);
    }

    if(level._id_11049 >= 5 && !istrue(level._id_570D._id_5713)) {
      level _id_0985::init_exfil_start_interact();
    }

    foreach(var_8 in level.players) {
      var_8 _id_0717::on_objective_complete();
      var_8 update_completed_objectives(var_0);
      _id_070F::createobjectivecompleteevent(var_8, var_0, var_0._id_96CF._id_4823._id_0481);
    }

    if(!level scripts\engine\utility::_id_5C00("block_objective_spawn_on_completion") && is_hub_fully_unlocked()) {
      _id_B05F();
      _id_E1A2();
    }

    var_15 = scripts\engine\utility::random(level.hub_music_states);
    _func_01E3(var_15);
    wait 1.5;
    scripts\cp\zombies\zm_hub_portals::toggle_start_interact_markers(1, is_hub_fully_unlocked());
    play_return_narration(var_0._id_3BE5, var_4);
  } else {
    if(_func_0121(var_0.override_fail_vo)) {
      thread _id_0720::play_narration(var_0.override_fail_vo);
      level waittill("dialogue_finished");
    }

    level scripts\engine\utility::_id_5C1B("failed_any_objective");
    level _id_4BF9();

    if(istrue(var_0._id_529C)) {
      level thread _id_A874(var_0, var_2);
    }
  }

  var_16 = var_0._id_0481;

  if(!isDefined(level.last_objective_start)) {
    var_17 = 0;
  } else {
    var_17 = _func_00D7() - level.last_objective_start;
  }

  scripts\cp\telemetry_cp::logevent_objectivefinished(var_1, var_16, var_17);
  scripts\cp\telemetry_cp::logevent_serverroundend();
  scripts\cp\telemetry_cp::logevent_serveraispawned();
  level.spawnedaibase = 0;
  level.spawnedaijuggernaut = 0;
  level.spawnedaiscreamer = 0;
  level.spawnedaitrickster = 0;

  foreach(var_7 in level.players) {
    scripts\cp\telemetry_cp::logevent_playerroundend(var_7);
  }

  level.lastobjective = undefined;
  var_20 = spawnStruct();
  var_20._id_3B1A = var_1;
  var_20._id_82FC = var_0;
  level.soak_instance_objective_activated = 0;
  level notify("objective_ended", var_20);
  level _id_06CB::_id_2F23("objective_ended", var_20);
  var_0._id_EACB = var_1;
  var_0 notify("objective_ended");
  thread _id_C628();
}

update_completed_objectives(var_0) {
  if(istrue(self.presentatobjectivestart)) {
    var_1 = var_0._id_3BE5;

    if(!isDefined(self.completedobjectivetypes)) {
      self.completedobjectivetypes = [];
    }

    if(!isDefined(self.completedobjectivetypes[var_1])) {
      self.completedobjectivetypes[var_1] = 0;
    }

    self.completedobjectivetypes[var_1]++;
    var_2 = var_0._id_96CF._id_4823._id_0481;

    if(!isDefined(self.completedobjectivelocations)) {
      self.completedobjectivelocations = [];
    }

    if(!isDefined(self.completedobjectivelocations[var_2])) {
      self.completedobjectivelocations[var_2] = 0;
    }

    self.completedobjectivelocations[var_2]++;

    if(!isDefined(self.completedobjectiveinfo)) {
      self.completedobjectiveinfo = [];
    }

    if(!isDefined(self.completedobjectiveinfo[var_2])) {
      self.completedobjectiveinfo[var_2] = [];
    }

    if(_func_0107(self.completedobjectiveinfo[var_2]) && !scripts\cp\utility::_id_88B7(self.completedobjectiveinfo[var_2], var_1)) {
      self.completedobjectiveinfo[var_2] = ::scripts\engine\utility::array_add(self.completedobjectiveinfo[var_2], var_1);
    }
  }
}

refresh_hub(var_0) {
  level waittill("portal_activated");
  level._id_A382++;
  _id_073D::cleanup_managed_loot_weapons();
  update_poi(var_0);
}

_id_385C(var_0, var_1) {
  level endon("game_ended");
  wait(var_0);
  _id_0722::close_all_doors();
  level scripts\engine\utility::_id_5C04("objective_locked");
  var_2 = _id_06EF::_id_672B(var_1._id_3BE5);
  var_1 thread[[var_2.objectivecleanupcallback]]();
}

_id_B05F() {
  var_0 = getDvar("#x3d0f11b3052238412", "");

  if(var_0 != "" && isDefined(level._id_3BE9._id_4828[var_0])) {
    level._id_3BE9._id_41C0 = level._id_3BE9._id_4828[var_0];
  } else if(level._id_3BE9._id_AC62.size < 1) {
    _id_D2B2(0, 1);
  } else {
    level._id_3BE9._id_41C0 = level._id_3BE9._id_AC62[level._id_3BE9._id_4824];
    level._id_3BE9._id_AC62 = scripts\engine\utility::array_remove_index(level._id_3BE9._id_AC62, level._id_3BE9._id_4824, 0);
  }
}

fixup_destination_array(var_0) {
  if(isDefined(level.post_portal_destinations)) {
    level._id_3BE9._id_AC62 = level.post_portal_destinations;
  } else {
    _id_D2B2(0, 0);
  }

  var_1 = scripts\cp\zombies\zm_hub_portals::get_active_portals(1);

  if(_func_0107(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = var_3._id_82FC._id_96CF._id_4823;

      if(scripts\engine\utility::is_equal(var_4._id_039B, "exclude_from_objectives")) {
        continue;
      }
      level._id_3BE9._id_AC62 = scripts\cp\utility::_id_1B8C(level._id_3BE9._id_AC62, var_4);
    }
  }

  level.post_portal_destinations = level._id_3BE9._id_AC62;

  for(var_6 = 0; var_6 < level._id_3BE9._id_AC62.size; var_6++) {
    if(scripts\engine\utility::is_equal(level._id_3BE9._id_AC62[var_6]._id_0481, var_0._id_96CF._id_4823._id_0481)) {
      level.post_portal_destinations = scripts\engine\utility::array_remove_index(level.post_portal_destinations, var_6);
      level._id_3BE9._id_AC62 = level.post_portal_destinations;
      return;
    }
  }
}

remove_destination_from_ordered_destinations(var_0) {
  foreach(var_2 in level.active_objective_instances) {
    if(var_2._id_3BE5 == "exfil" || var_2._id_3BE5 == "forever_blitz" || scripts\engine\utility::is_equal(var_2._id_0481, "objective_dark_aether_assault")) {
      continue;
    }
    level._id_3BE9._id_AC62 = scripts\cp\utility::_id_1B8C(level._id_3BE9._id_AC62, var_2._id_96CF._id_4823);
  }

  for(var_4 = 0; var_4 < level._id_3BE9._id_AC62.size; var_4++) {
    if(level._id_3BE9._id_AC62[var_4]._id_0481 == var_0._id_0481) {
      level._id_3BE9._id_AC62 = scripts\engine\utility::array_remove_index(level._id_3BE9._id_AC62, var_4, 0);
    }
  }
}

_id_D2B2(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  level._id_3BE9._id_AC62 = [];

  foreach(var_3 in level._id_3BE9._id_4828) {
    if(scripts\engine\utility::is_equal(var_3._id_039B, "exclude_from_objectives")) {
      continue;
    }
    level._id_3BE9._id_AC62[level._id_3BE9._id_AC62.size] = var_3;
  }

  if(var_0) {
    level._id_3BE9._id_AC62 = scripts\engine\utility::array_randomize(level._id_3BE9._id_AC62);
  }

  level._id_3BE9._id_4824 = 0;

  if(var_1) {
    _id_B05F();
  }

  level.post_portal_destinations = undefined;
}

_id_A874(var_0, var_1) {
  level thread _id_0726::_id_52F7("axis", var_1, 4, var_0);
}

objective_failed_splash(var_0) {
  if(isDefined(var_0) && isDefined(var_0._id_3BE5)) {
    switch (var_0._id_3BE5) {
      case "holdout":
        set_objective_ui_state(0, 0, 3);
        break;
      case "soul_capture":
        set_objective_ui_state(1, 0, 3);
        break;
      case "orb_follow":
        set_objective_ui_state(2, 0, 3);
        break;
      case "domination":
        set_objective_ui_state(4, 0, 3);
        break;
      case "assault":
        set_objective_ui_state(6, 0, 3);
        break;
      case "exfil":
        set_objective_ui_state(3, 0, 3);
        break;
      case "forever_blitz":
        set_objective_ui_state(5, 0, 3);
        break;
    }
  }
}

_id_D619(var_0) {}

_id_D61F(var_0) {}

_id_C628(var_0) {
  level endon("game_ended");

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  wait(var_0);
  _id_D61F(0);
  _id_D619(0);
}

is_hub_fully_unlocked() {
  var_0 = scripts\cp\zombies\zm_hub_portals::get_portal_structs(0, 1, 0).size;
  var_0 = var_0 + scripts\cp\zombies\zm_hub_portals::get_secondary_portal_structs(0).size;
  return var_0 == 0;
}

_id_2F6E() {}

_id_2F6D() {}

_id_38BE() {}

_id_C9FE(var_0) {
  level endon("game_ended");

  foreach(var_2 in var_0) {
    _id_06EF::_id_E16F(var_2);
    var_3 = level scripts\engine\utility::_id_10896("objective_ended");

    if(var_3._id_3B1A == 0 && getdvarint("#x388c0591c4b9280dc", 1)) {
      return;
    }
  }
}

force_next_objective_category(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_3BE9._id_4828) {
    foreach(var_5 in var_3._id_A8E0) {
      foreach(var_7 in var_5) {
        if(var_7._id_3BE5 == var_0) {
          var_1 = scripts\engine\utility::array_add(var_1, var_7);
        }
      }
    }
  }

  if(var_1.size == 0) {
    return 0;
  }

  var_11 = randomint(var_1.size);
  var_12 = var_1[var_11];
  level._id_A86A = scripts\engine\utility::array_remove(level._id_A86A, var_0);
  level._id_A86A[level._id_A86A.size] = var_0;
  level._id_3BE9._id_A4BC = var_12;
  level._id_3BE9._id_41DD = var_0;
  var_13 = spawnStruct();
  var_13._id_A883 = var_12;
  var_13._id_332F = var_0;
  _id_06CB::_id_2F23("objective_set", var_13);
  return 1;
}

_id_D29E(var_0, var_1, var_2, var_3) {
  var_4 = var_0._id_A8E0[var_2];

  if(isDefined(level._id_11049)) {
    if(level._id_11049 < 4 && isDefined(var_0.smallmediumobjectiveinstances) && isDefined(var_0.smallmediumobjectiveinstances[var_2])) {
      var_4 = var_0.smallmediumobjectiveinstances[var_2];
    } else if(isDefined(var_0.mediumlargeobjectiveinstances) && isDefined(var_0.mediumlargeobjectiveinstances[var_2])) {
      var_4 = var_0.mediumlargeobjectiveinstances[var_2];
    }
  }

  if(!isDefined(var_4) || var_4.size == 0) {
    return 0;
  }

  if(isDefined(var_0._id_E2BE) && isDefined(var_0._id_E2BE[var_2]) && !var_1) {
    return 0;
  }

  var_4 = scripts\engine\utility::array_randomize(var_4);
  var_5 = var_4[0];
  var_6 = getDvar("#x375885019d5a1fb85", "");
  var_7 = get_forced_instance();

  if(isDefined(var_7)) {
    var_5 = var_7;
  } else if(var_6 != "" && isDefined(level._id_3BE9._id_4828[var_0._id_0481]._id_96DE[var_6])) {
    foreach(var_9 in var_4) {
      if(var_9._id_96CF._id_0481 == var_6) {
        var_5 = var_9;
      }
    }
  }

  if(isDefined(var_3)) {
    var_2 = var_3;

    foreach(var_9 in var_4) {
      if(var_9._id_FFC4 == var_3) {
        var_5 = var_9;
        break;
      }
    }
  } else if(!var_1 && level._id_A382 < 1 && (var_2 == "hunt" || var_2 == "payload")) {
    foreach(var_9 in var_4) {
      if(var_9._id_FFC4 != "hunt_steiner" && var_9._id_FFC4 != "hunt_mechz" && var_9._id_FFC4 != "payload_teleport") {
        var_5 = var_9;
        break;
      }
    }
  }

  level._id_A86A = scripts\engine\utility::array_remove(level._id_A86A, var_2);
  level._id_A86A[level._id_A86A.size] = var_2;
  level._id_3BE9._id_A4BC = var_5;
  level._id_3BE9._id_41DD = var_2;
  var_15 = spawnStruct();
  var_15._id_A883 = var_5;
  var_15._id_332F = var_2;
  _id_06CB::_id_2F23("objective_set", var_15);
  return 1;
}

get_forced_instance() {
  var_0 = getDvar("#x3e8cfd2795bd2d6d9", "");

  if(var_0 != "") {
    foreach(var_2 in level._id_3BE9._id_4828) {
      foreach(var_4 in var_2._id_A8E0) {
        foreach(var_6 in var_4) {
          if(var_6._id_0481 == var_0) {
            return var_6;
          }
        }
      }
    }
  }

  return undefined;
}

_id_5AB4(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_3 in level._id_A86A) {
    var_4 = undefined;

    if(istrue(is_disabled_category(var_3))) {
      continue;
    }
    if(var_3 == "assault" && scripts\engine\utility::is_equal(var_0._id_0481, "destination_dark_aether")) {
      continue;
    }
    if(var_3 == "final_battle" || var_3 == "exfil" || var_3 == "ee" || var_3 == "forever_blitz") {
      continue;
    } else if(var_3 == "payload_teleport" || var_3 == "payload_noteleport") {
      var_4 = var_3;
      var_3 = "payload";
    } else if(var_3 == "hunt_steiner" || var_3 == "hunt_mechz" || var_3 == "hunt_raz") {
      var_4 = var_3;
      var_3 = "hunt";
    } else if(var_3 == "defend_prime" || var_3 == "defend_alt") {
      var_4 = var_3;
      var_3 = "defend";
    } else if(var_3 == "holdout_alt" || var_3 == "holdout_prime") {
      var_4 = var_3;
      var_3 = "holdout";
    } else if(var_3 == "retrieval_alt" || var_3 == "retrieval_prime") {
      var_4 = var_3;
      var_3 = "retrieval";
    }

    if(!_id_D29E(var_0, var_1, var_3, var_4)) {
      continue;
    }
    return;
  }

  if(!var_1) {
    _id_5AB4(var_0, 1);
  }
}

spawn_one_time_objectives() {
  var_0 = scripts\cp\zombies\zm_hub_portals::get_portal_structs(0, 1, 0);

  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2._id_3BE5, "portal") && !scripts\engine\utility::is_equal(var_2._id_0481, "portal_fixed")) {
      _id_B05F();
      var_3 = getDvar("#x3a3189d5345f0ec9a");

      if(isDefined(var_3) && !istrue(level.forced_early_objective) && var_3 != "") {
        var_4 = force_next_objective_category(var_3);

        if(istrue(var_4)) {
          level.forced_early_objective = 1;
        }
      }

      _id_E1A2();
    }
  }

  update_poi(undefined);
  scripts\cp\zombies\zm_hub_portals::hide_portal_clip_at_start();
  wait 6;
  scripts\cp\zombies\zm_hub_portals::toggle_start_interact_markers(1, 0);
}

check_fully_unlocked_narration(var_0) {
  if(is_hub_fully_unlocked()) {
    thread play_objective_announcement_narration(var_0);
    level scripts\engine\utility::_id_5C1B("hub_fully_unlocked");
  }
}

_id_E1A2() {
  if(!isDefined(level._id_3BE9._id_A4BC)) {
    _id_5AB4(level._id_3BE9._id_41C0);
  }

  if(isDefined(level._id_3BE9._id_A4BC)) {
    check_fully_unlocked_narration(level._id_3BE9._id_A4BC);
    _id_06EF::_id_E16F(level._id_3BE9._id_A4BC);
    level._id_3BE9._id_A4BC = undefined;
  } else {
    var_0 = scripts\engine\utility::array_randomize(level._id_3BE9._id_4828);
    var_1 = scripts\engine\utility::array_randomize(level._id_A86A);

    foreach(var_3 in var_0) {
      foreach(var_5 in var_1) {
        if(var_3._id_A8E0[var_5].size == 0) {
          continue;
        }
        var_6 = [];

        if(isDefined(level._id_11049)) {
          if(level._id_11049 < 4 && isDefined(var_3.smallmediumobjectiveinstances) && isDefined(var_3.smallmediumobjectiveinstances[var_5])) {
            var_6 = var_3.smallmediumobjectiveinstances[var_5];
          } else if(isDefined(var_3.mediumlargeobjectiveinstances) && isDefined(var_3.mediumlargeobjectiveinstances[var_5])) {
            var_6 = var_3.mediumlargeobjectiveinstances[var_5];
          }
        }

        if(var_6.size == 0) {
          var_6 = var_3._id_A8E0[var_5];
        }

        var_6 = scripts\engine\utility::array_randomize(var_6);
        var_7 = var_6[0];
        var_3 = level._id_3BE9._id_41C0;
        level._id_3BE9._id_A4BC = var_7;
        level._id_3BE9._id_41DD = var_5;
        var_8 = spawnStruct();
        var_8._id_A883 = var_7;
        var_8._id_332F = var_5;
        _id_06CB::_id_2F23("objective_set", var_8);
        check_fully_unlocked_narration(level._id_3BE9._id_A4BC);
        _id_06EF::_id_E16F(level._id_3BE9._id_A4BC);
        level._id_3BE9._id_A4BC = undefined;
      }
    }
  }
}

_id_D797(var_0) {
  var_1 = getDvar("#x3d33351bd33a76410");

  if(var_1 != "") {
    var_2 = [];
    var_2[var_2.size] = var_1;
    level._id_A86A = var_2;
    var_3 = [];

    foreach(var_5 in level._id_3BE9._id_4828) {
      var_6 = var_5._id_A8E0[var_1];

      if(isDefined(var_6) && var_6.size > 0) {
        var_3[var_3.size] = var_5;
      }
    }

    level._id_3BE9._id_4828 = var_3;
    return;
  }
}

_id_E19E(var_0, var_1) {
  var_2 = var_0[0];

  foreach(var_4 in var_1) {
    if(var_4 == "final_battle" || var_4 == "exfil") {
      continue;
    }
    var_5 = var_2._id_A8E0[var_4];

    if(!isDefined(var_5)) {
      continue;
    }
    var_6 = var_5[randomint(var_5.size)];
    _id_06EF::_id_E16F(var_6);
    var_2._id_A8E0 = undefined;
    scripts\engine\utility::array_remove(var_0, var_2);
    scripts\engine\utility::array_remove(var_1, var_4);
    var_1[var_1.size] = var_4;
    return;
  }
}

_id_E0B9() {
  var_0 = spawnStruct();
  var_0._id_4828 = [];
  var_0._id_332E = [];
  _id_3328(var_0);
  var_0._id_4828 = scripts\engine\utility::array_randomize(var_0._id_4828);
  var_0._id_332E = scripts\engine\utility::array_randomize(var_0._id_332E);

  while(var_0._id_4828.size > 0) {
    foreach(var_2 in var_0._id_332E) {
      _id_E13D(var_0, var_2);
    }
  }
}

_id_3328(var_0) {
  foreach(var_2 in level._id_3BE9._id_4828) {
    var_3 = [];

    foreach(var_5 in var_2._id_96DE) {
      if(_id_06EF::_id_751F(var_5)) {
        continue;
      }
      foreach(var_13, var_7 in var_5._id_8300) {
        var_8 = _id_06EF::_id_672B(var_13);

        if(!isDefined(var_8)) {
          continue;
        }
        var_9 = var_8._id_A8D5;

        if(!isDefined(var_9)) {
          continue;
        }
        if(!scripts\engine\utility::array_contains(var_0._id_332E, var_9)) {
          var_0._id_332E[var_0._id_332E.size] = var_9;
        }

        if(!isDefined(var_3[var_9])) {
          var_3[var_9] = [];
        }

        foreach(var_11 in var_7.versions) {
          var_3[var_9][var_3[var_9].size] = var_11;
        }
      }
    }

    var_15 = [];
    var_16 = [];

    if(var_3.size > 0) {
      foreach(var_9, var_18 in var_3) {
        var_3[var_9] = ::scripts\engine\utility::array_randomize(var_18);

        if(!isDefined(var_15[var_9])) {
          var_15[var_9] = [];
        }

        if(!isDefined(var_16[var_9])) {
          var_16[var_9] = [];
        }

        foreach(var_11 in var_18) {
          if(isDefined(level.small_objective_instance_names)) {
            foreach(var_21 in level.small_objective_instance_names) {
              if(var_11._id_0481 == var_21) {
                var_15[var_9] = ::scripts\cp\utility::_id_1B8C(var_15[var_9], var_11);
              }
            }
          }

          if(isDefined(level.large_objective_instance_names)) {
            foreach(var_21 in level.large_objective_instance_names) {
              if(var_11._id_0481 == var_21) {
                var_16[var_9] = ::scripts\cp\utility::_id_1B8C(var_16[var_9], var_11);
              }
            }
          }
        }
      }

      var_2._id_A8E0 = var_3;
      var_2.smallobjectiveinstances = var_15;
      var_2.largeobjectiveinstances = var_16;
      var_26 = [];
      var_27 = [];

      foreach(var_9, var_18 in var_3) {
        if(!isDefined(var_26[var_9])) {
          var_26[var_9] = [];
        }

        if(!isDefined(var_27[var_9])) {
          var_27[var_9] = [];
        }

        foreach(var_11 in var_18) {
          if(var_16[var_9].size == 0) {
            var_26[var_9] = var_3[var_9];
          } else {
            var_30 = 0;

            foreach(var_32 in var_16[var_9]) {
              if(var_11._id_0481 != var_32._id_0481) {
                var_30++;
              }
            }

            if(scripts\engine\utility::is_equal(var_30, var_16[var_9].size)) {
              var_26[var_9] = ::scripts\cp\utility::_id_1B8C(var_26[var_9], var_11);
            }
          }

          if(var_15[var_9].size == 0) {
            var_27[var_9] = var_3[var_9];
            continue;
          }

          var_30 = 0;

          foreach(var_35 in var_15[var_9]) {
            if(var_11._id_0481 != var_35._id_0481) {
              var_30++;
            }
          }

          if(scripts\engine\utility::is_equal(var_30, var_15[var_9].size)) {
            var_27[var_9] = ::scripts\cp\utility::_id_1B8C(var_27[var_9], var_11);
          }
        }
      }

      var_2.smallmediumobjectiveinstances = var_26;
      var_2.mediumlargeobjectiveinstances = var_27;
      var_0._id_4828[var_0._id_4828.size] = var_2;
    }
  }
}

_id_E13D(var_0, var_1) {
  foreach(var_3 in var_0._id_4828) {
    var_4 = var_3._id_A8E0[var_1];

    if(!isDefined(var_4)) {
      continue;
    }
    var_5 = var_4[randomint(var_4.size)];
    _id_06EF::_id_E16F(var_5);
    var_3._id_A8E0[var_1] = undefined;

    if(var_3._id_A8E0.size == 0) {
      var_0._id_4828 = scripts\engine\utility::array_remove(var_0._id_4828, var_3);
    }

    return;
  }
}

_id_E1A3(var_0) {
  var_1 = _id_06EF::_id_672B(var_0._id_3BE5);
  level.active_objective_instances = scripts\cp\utility::_id_459B(level.active_objective_instances, []);
  level.active_objective_instances = scripts\cp\utility::_id_1B8C(level.active_objective_instances, var_0);
  scripts\cp\zombies\zm_hub_portals::spawn_next_interact(var_0);
  level thread[[var_1._id_A8F5]](var_0);
  level scripts\engine\utility::_id_5C1B("objective_spawned");
}

update_poi(var_0) {
  if(isDefined(var_0) && isDefined(var_0.hub_portal)) {
    if(isDefined(level.a_portal_zone_map[var_0.hub_portal])) {
      level.a_active_zones = scripts\engine\utility::array_add(level.a_active_zones, level.a_portal_zone_map[var_0.hub_portal]);
    }
  }

  var_1 = spawnStruct();
  var_1._id_4649 = 0.5;
  level thread _id_06CB::_id_2F23("start_poi_spawning", var_1);
}

_id_E618(var_0, var_1) {
  level endon("begin_game_ended");

  if(!istrue(level.soak_testing)) {
    if(isDefined(level._id_3BE9._id_0F51)) {
      return 0;
    }
  } else if(!isDefined(var_0))
    return 0;

  level._id_3BE9._id_0F51 = var_0;
  level._id_3BE9._id_0F51._id_110AC = 0;
  level notify("abort_nuke_spawn_delay");
  level thread scripts\cp\zombies\zm_hub_portals::toggle_start_interact_markers(0);
  scripts\cp\zombies\zm_hub_portals::set_portals_inactive();
  _id_074D::set_minimap_icon_persistent(0);
  add_location_ammo_cache_markers(var_0._id_96CF);

  if(isDefined(var_0._id_A8FE)) {
    var_0._id_A8FE = undefined;
  }

  var_2 = _id_06EF::_id_672B(var_0._id_3BE5);
  level notify("objective_triggered");
  var_3 = spawnStruct();
  var_3._id_82FC = var_0;
  var_3._id_0025 = var_1;
  level _id_06CB::_id_2F23("objective_triggered", var_3);

  if(isDefined(var_0.override_vo_func)) {
    [[var_0.override_vo_func]](var_0);
  }

  if(isDefined(level.objective_override_vo_func)) {
    [[level.objective_override_vo_func]](var_0);
  }

  if(!scripts\engine\utility::is_equal(self._id_82FC._id_3BE5, "exfil")) {
    level thread scripts\cp\zombies\zm_hub_unlock::queue_wall_unlock("portal_activated");
    level thread play_objective_start_narration(var_0);
    level thread _id_F02C(var_0, "teleport_pt");
    level waittill("portal_activated");
    level thread[[var_2.objectivesetupcallback]](var_0);
    scripts\cp\zombies\zm_hub_portals::hide_portals_objectives();
    level thread _id_06CB::_id_2F23("cleanup_poi_encounters");
    level thread _id_073D::cleanup_managed_loot_weapons();
    level waittill("players_landed");

    foreach(var_5 in level.players) {
      var_5._id_0313 = 1;
      var_5.presentatobjectivestart = 1;
      var_5.nomanualreloads = 1;
      var_5.highest_objective_rapid_kill = 0;
      var_5.highest_objective_rapid_critical_kill = 0;
      var_5.b_finish_first_objective_rapid_kill_ar = 0;
      var_5.b_finish_first_objective_rapid_critical_kill_lmg = 0;
    }
  } else {
    scripts\cp\zombies\zm_hub_portals::hide_portals_objectives();
    level scripts\cp\zombies\cp_zm_poi_spawning::cleanup_poi_encounters();
    level thread _id_073D::cleanup_managed_loot_weapons();
  }

  if(isDefined(level._id_3BE9._id_0F51) && isDefined(level._id_3BE9._id_0F51._id_3BE5)) {
    _id_072A::setperroundxp(level._id_3BE9._id_0F51._id_3BE5, level._id_11049);
  }

  waittillframeend;
  remove_destination_from_ordered_destinations(var_0._id_96CF._id_4823);
  level thread[[var_2._id_A8F7]](var_0);
  level _id_06CB::on_ai_spawned(::on_objective_ai_spawned);

  if(isDefined(var_1)) {}

  level thread fixup_destination_array(var_0);
  level notify("objective_started");
  var_3 = spawnStruct();
  var_3._id_82FC = var_0;
  var_3._id_0025 = var_1;
  level _id_06CB::_id_2F23("objective_started", var_3);
  level thread _id_4C24(var_2._id_CF92);

  foreach(var_5 in level.players) {
    var_5.b_getting_hit_in_objective = 0;
  }

  return 1;
}

_id_F02C(var_0, var_1) {
  level endon("begin_game_ended");
  var_2 = [];
  var_3 = var_0;

  switch (var_1) {
    case "start_interact":
      var_4 = scripts\cp\zombies\zm_hub_portals::get_all_portal_structs();

      foreach(var_6 in var_4) {
        if(isDefined(var_0.hub_portal) && var_6._id_0481 == var_0.hub_portal) {
          var_3 = var_6;
          break;
        }
      }

      break;
    default:
      break;
  }

  if(isDefined(level.a_forever_blitz_instance) && scripts\cp\utility::_id_88B7(level.a_forever_blitz_instance, var_0) && scripts\engine\utility::is_equal(var_1, "start_interact")) {
    var_3 = var_0._id_E5F6.interact_struct;
  }

  var_2 = _id_6692(var_3);

  if(!isDefined(var_2)) {
    level notify("players_landed");
    return;
  }

  level _id_098A::_id_109FC(var_3, var_1);
  _id_092E::_id_46F7();
  level notify("players_landed");
}

_id_6692(var_0) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = undefined;

  if(isDefined(var_0._id_3BE8["player_spawn_cluster"])) {
    var_2 = randomint(var_0._id_3BE8["player_spawn_cluster"].size);
    var_1 = var_0._id_3BE8["player_spawn_cluster"][var_2];
  }

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_3 = undefined;

  if(isDefined(var_1._id_3BE8["player_spawn_location"])) {
    var_3 = var_1._id_3BE8["player_spawn_location"];
  }

  if(!isDefined(var_3)) {
    return undefined;
  }

  return var_3;
}

_id_385D() {
  var_0 = level._id_3BE9._id_A8D9._id_0DF3;
  level._id_3BE9._id_A8D9 = undefined;

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(isDefined(var_2)) {
        var_2 delete();
        waitframe();
      }
    }
  }
}

_id_CF90(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_0 endon("stop_scriptmodel_bob");
  var_5 = scripts\cp\utility::_id_459B(var_5, 0);
  var_6 = scripts\cp\utility::_id_459B(var_1, 0.5);
  var_7 = scripts\cp\utility::_id_459B(var_2, 4);
  var_8 = scripts\cp\utility::_id_459B(var_3, 0.15);
  var_9 = scripts\cp\utility::_id_459B(var_4, 0.15);
  var_10 = var_0.origin + (0, 0, var_7);
  var_11 = var_0.origin - (0, 0, var_7);

  for(;;) {
    var_0 moveto(var_10, var_6, var_8, var_9);

    if(var_5) {
      var_0 rotateyaw(var_0.angles[2] + 45, var_6);
    }

    wait(var_6);
    var_0 moveto(var_11, var_6, var_8, var_9);

    if(var_5) {
      var_0 rotateyaw(var_0.angles[2] + 45, var_6);
    }

    wait(var_6);
  }
}

_id_6F39(var_0) {
  var_1 = scripts\cp\utility::_id_6C5C();

  foreach(var_3 in var_1) {
    var_4 = 0;

    switch (level._id_11049) {
      case 1:
        var_5 = "objective_complete_rank_1";
        var_4 = 50;
        break;
      case 2:
        var_5 = "objective_complete_rank_2";
        var_4 = 100;
        break;
      case 3:
        var_5 = "objective_complete_rank_3";
        var_4 = 150;
        break;
      case 4:
        var_5 = "objective_complete_rank_4";
        var_4 = 200;
        break;
      case 5:
        var_5 = "objective_complete_rank_5";
        var_4 = 250;
        break;
      case 6:
        var_5 = "objective_complete_rank_6";
        var_4 = 300;
        break;
      case 7:
        var_5 = "objective_complete_rank_7";
        var_4 = 350;
        break;
      case 8:
        var_5 = "objective_complete_rank_8";
        var_4 = 400;
        break;
      case 9:
        var_5 = "objective_complete_rank_9";
        var_4 = 450;
        break;
      default:
        var_5 = "objective_complete_rank_10";
        var_4 = 500;
        break;
    }

    var_4 = int(var_4 * var_3 _id_0945::_id_664E("salvage_bonus_increase"));
    var_3 thread _id_075A::_id_6FCE(var_4, "Objective");
    var_6 = 1;

    if(isDefined(var_0) && scripts\engine\utility::is_equal(var_0._id_3BE5, "forever_blitz")) {
      var_6 = 0;
    }

    if(var_6) {
      var_7 = _id_0756::_id_6D0C(var_5, "xp");
      var_3.pers["earned_objective_completion_xp"] = var_3.pers["earned_objective_completion_xp"] + var_7;
      var_3 _id_0756::giverankxp(var_5, var_7);
    }

    var_3 _id_0756::givebattlepassparticipationxp();
    var_3 _id_0752::_id_7003(var_5, undefined, undefined, 1);
    var_3 scripts\cp\cp_sacrificial_heart::giveplayersacrificialheart();
  }
}

_id_1081(var_0, var_1, var_2) {}

_id_4C24(var_0) {
  var_1 = _id_06EF::_id_672B(var_0);
  var_2 = scripts\cp\utility::_id_459B(var_1._id_A8FB, 0);
  var_3 = scripts\cp\utility::_id_6C5C();

  foreach(var_5 in var_3) {}
}

_id_4BE2() {}

play_objective_announcement_narration(var_0) {
  if(_func_0121(var_0.override_vos)) {
    var_1 = var_0.override_vos;
  } else {
    var_1 = var_0._id_3BE5;
  }

  var_2 = _id_0720::get_objective_alias(var_0._id_3BE5, "announce");
  var_3 = _id_0720::get_objective_alias(var_0._id_3BE5, "announce_response");

  if(_func_0121(var_0.override_announce_vo)) {
    var_2 = var_0.override_announce_vo;
  }

  if(_func_0121(var_0.override_announce_resp_vo)) {
    var_3 = var_0.override_announce_resp_vo;
  }

  thread _id_0720::play_narration(var_2);
  level waittill("dialogue_finished");
  thread _id_0720::play_narration(var_3);
  level waittill("dialogue_finished");
}

play_objective_start_narration(var_0) {
  if(scripts\engine\utility::is_equal(var_0._id_0481, "objective_dark_aether_forever_blitz")) {
    level thread _id_0720::play_narration("zm_zofb_ofbz_krft_ftrg");
    level waittill("dialogue_finished");
    level thread _id_0720::play_narration("zm_zofb_ofbz_blkr_ftgr");
    level waittill("dialogue_finished");
  }

  if(_func_0121(var_0.override_vos)) {
    var_1 = var_0.override_vos;
  } else {
    var_1 = var_0._id_3BE5;
  }

  var_2 = _id_0720::get_objective_alias(var_1, "announce");
  var_3 = _id_0720::get_objective_alias(var_1, "trigger");

  if(_func_0121(var_0.override_announce_vo)) {
    var_2 = var_0.override_announce_vo;
  }

  if(_func_0121(var_0.override_trigger_vo)) {
    var_3 = var_0.override_trigger_vo;
  }

  if(!scripts\engine\utility::is_equal(var_0._id_3BE5, "assault")) {
    thread _id_0720::play_narration(var_2);
    level waittill("dialogue_finished");
  }

  if(isDefined(var_3) && var_3 != "") {
    thread _id_0720::play_narration(var_3);
    level waittill("dialogue_finished");

    if(scripts\engine\utility::is_equal(var_0._id_039B, "assault")) {
      thread _id_0720::play_narration("zm_o2as_ass2_vrcn_atrr");
      level waittill("dialogue_finished");
    }
  }
}

play_objective_kickoff_narration(var_0, var_1, var_2, var_3) {
  if(var_2._id_96CF._id_0481 == "objectives_location_dark_aether" && !level scripts\engine\utility::_id_5C00("flg_first_travels_dark_athener")) {
    level scripts\engine\utility::_id_5C1B("flg_first_travels_dark_athener");
    thread _id_0720::play_narration("zm_zohs_hbsk_vrcn_hsna");
  }

  if(_func_0121(var_2.override_vos)) {
    var_0 = var_2.override_vos;
  } else {
    var_0 = var_2._id_3BE5;
  }

  var_4 = undefined;
  var_5 = undefined;

  switch (var_1) {
    case 1:
      var_4 = _id_0720::get_objective_alias(var_0, "start_first_time");
      var_5 = _id_0720::get_objective_alias(var_0, "start_first_time_response");
      break;
    case 2:
      var_4 = _id_0720::get_objective_alias(var_0, "start_second_time");
      var_5 = _id_0720::get_objective_alias(var_0, "start_second_time_response");
      break;
    case 3:
      var_4 = _id_0720::get_objective_alias(var_0, "start_third_time");
      var_5 = _id_0720::get_objective_alias(var_0, "start_third_time_response");
      break;
    default:
      var_5 = _id_0720::get_objective_alias(var_0, "start_generic");
      break;
  }

  if(istrue(var_2.b_force_play_kickoff_vo) && _func_0121(var_2.override_kickoff_vo)) {
    var_4 = var_2.override_kickoff_vo;
  }

  if(isDefined(var_4) && var_4 != "") {
    thread _id_0720::play_narration(var_4);
    level waittill("dialogue_finished");
  }

  wait 1.0;
  var_2 notify("kickoff_vo_complete");

  if(!var_3) {
    wait 1.5;
  }

  if(isDefined(var_5) && var_5 != "") {
    thread _id_0720::play_narration(var_5);
    level waittill("dialogue_finished");
  }
}

play_completed_narration(var_0) {
  wait 1.5;

  if(_func_0121(var_0.override_vos)) {
    var_1 = var_0.override_vos;
  } else {
    var_1 = var_0._id_3BE5;
  }

  var_2 = _id_0720::get_objective_alias(var_1, "success");
  var_3 = _id_0720::get_objective_alias(var_1, "end");
  var_4 = _id_0720::get_objective_alias(var_1, "end_response");

  if(_func_0121(var_0.override_success_vo)) {
    var_2 = var_0.override_success_vo;
  }

  if(_func_0121(var_0.override_end_vo)) {
    var_3 = var_0.override_end_vo;
  }

  if(_func_0121(var_0.override_end_resp_vo)) {
    var_4 = var_0.override_end_resp_vo;
  }

  if(!istrue(var_0.b_is_quest)) {
    thread _id_0720::play_narration("zm_cmcp_obhb_vlst_hgnr");
    level waittill("dialogue_finished");
  }

  thread _id_0720::play_narration(var_2);
  level waittill("dialogue_finished");
  thread _id_0720::play_narration(var_3);
  level waittill("dialogue_finished");
  wait 1;
  level notify("hub_return_vo_complete");
  thread _id_0720::play_narration(var_4);
  level waittill("dialogue_finished");

  if(isDefined(var_0.override_vo_cleanup_func)) {
    [[var_0.override_vo_cleanup_func]](var_0);
  }

  if(isDefined(level.objective_override_vo_cleanup_func)) {
    [[level.objective_override_vo_cleanup_func]](var_0);
  }

  wait 1.5;
}

play_return_narration(var_0, var_1) {
  if(isDefined(level.fn_play_return_narration_override)) {
    [[level.fn_play_return_narration_override]]();
  } else if(!is_hub_fully_unlocked()) {
    switch (var_1) {
      case 1:
        var_2 = scripts\engine\utility::ter_op(level.mapname == "cp_zm_skorpion", "zm_zohs_hbsk_krft_hsca", "zm_cmcp_obhb_krft_hrt1");
        thread _id_0720::play_narration(var_2);
        level waittill("dialogue_finished");
        break;
      case 2:
        var_3 = scripts\engine\utility::ter_op(level.mapname == "cp_zm_skorpion", "zm_zohs_hbsk_krft_hsda", "zm_cmcp_obhb_krft_hrt2");
        thread _id_0720::play_narration(var_3);
        level waittill("dialogue_finished");
        var_4 = scripts\engine\utility::ter_op(level.mapname == "cp_zm_skorpion", "zm_zohs_hbsk_krft_hsea", "zm_cmcp_obhb_krft_hrai");
        thread _id_0720::play_narration(var_4);
        level waittill("dialogue_finished");
        break;
      case 4:
        var_5 = scripts\engine\utility::ter_op(level.mapname == "cp_zm_skorpion", "zm_zohs_hbsk_krft_hsga", "zm_cmcp_obhb_krft_hrte");
        thread _id_0720::play_narration(var_5);
        level waittill("dialogue_finished");
        wait 1;

        if(level.mapname == "cp_zod") {
          level notify("hub_return_vo_complete");
          thread _id_0720::play_narration(["zm_cmcp_obex_dnrt_eanc", "zm_cmcp_obex_dsrx_eanc", "zm_cmcp_obex_blkr_eanc", "zm_cmcp_obex_dnvk_eanc"]);
          level waittill("dialogue_finished");
          _id_0720::init_approach_dialogue(level._id_570D._id_E5F6.origin, scripts\engine\utility::random(["zm_cmcp_obex_dnrt_eanr", "zm_cmcp_obex_dsrx_eanr", "zm_cmcp_obex_blkr_eanr", "zm_cmcp_obex_dnvk_eanr"]), 0, 10000);
          wait 1.5;
        }

        break;
      case 5:
      case 3:
        wait 1.5;
        level notify("hub_return_vo_complete");
        var_6 = scripts\engine\utility::ter_op(level.mapname == "cp_zm_skorpion", "zm_zohs_hbsk_krft_hsha", "zm_cmcp_obhb_krft_hrtb");
        thread _id_0720::play_narration(var_6);
        level waittill("dialogue_finished");
        break;
    }
  }

  thread update_portal_nag();
}

update_portal_nag() {
  level endon("objective_triggered");

  if(istrue(level.b_force_disable_portal_nag)) {
    return;
  }
  thread update_holiday_nag();

  for(;;) {
    wait 300;

    if(istrue(level.playing_audio_log)) {
      level waittill("audio_log_finished");
      wait 5.0;
    }

    if(!istrue(level.b_disable_nags)) {
      var_0 = scripts\engine\utility::ter_op(level.mapname == "cp_zm_skorpion", "zm_zohs_hbsk_krft_hska", "zm_cmcp_obhb_krft_hprt");
      thread _id_0720::play_narration(var_0);
      level waittill("dialogue_finished");
    }
  }
}

update_holiday_nag() {
  level endon("objective_triggered");

  if(getdvarint("#x32499d9dc5db0430e", 0) == 0 || istrue(level.played_holiday_nag)) {
    return;
  }
  wait 60;

  if(istrue(level.playing_audio_log)) {
    level waittill("audio_log_finished");
    wait 5.0;
  }

  if(!istrue(level.b_disable_nags)) {
    thread _id_0720::play_narration("zm_cmcp_cann_krtx_ahtn");
    level waittill("dialogue_finished");
    level.played_holiday_nag = 1;
  }
}

_id_4BF9() {}

_id_4BFA(var_0) {
  scripts\engine\utility::_id_5C30("objective_fanfare");
  scripts\engine\utility::_id_5C1B("objective_fanfare");

  foreach(var_2 in scripts\cp\utility::_id_6C5C()) {
    level._id_EBCE[[var_0]](var_2, 1);
  }

  level scripts\engine\utility::_id_108F5("game_ended", 6);
  scripts\engine\utility::_id_5C04("objective_fanfare");

  foreach(var_2 in scripts\cp\utility::_id_6C5C()) {
    level._id_EBCE[[var_0]](var_2, 0);
  }
}

_id_E65A(var_0, var_1) {
  level endon("game_ended");
  level endon("timer_stop");

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  level thread _id_F253(var_0, var_1);

  foreach(var_3 in scripts\cp\utility::_id_6C5C()) {
    if(isDefined(level._id_A381) && isDefined(level._id_A380) && level._id_A380 > 0) {
      var_4 = level._id_A381 - level._id_A380;
      continue;
    }
  }

  wait(var_0);
  level notify("timer_" + var_1);
  _id_E8EB();
}

_id_C197(var_0) {
  if(isDefined(level._id_A381) && isDefined(level._id_A380) && level._id_A380 > 0) {
    if(isPlayer(var_0._id_3998)) {} else {}

    var_1 = level._id_A381 - level._id_A380;
  }
}

_id_F253(var_0, var_1) {
  level endon("timer_update_thread_ended");

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  level thread _id_F254(var_1);
  level._id_A381 = var_0;

  for(level._id_A380 = 0; level._id_A380 < var_0; level._id_A380++) {
    wait 1.0;
  }
}

_id_F254(var_0) {
  level scripts\engine\utility::_id_1087F("game_ended", "timer_stop", "timer_" + var_0);
  level._id_A381 = undefined;
  level._id_A380 = undefined;
  level notify("timer_update_thread_ended");
}

_id_E65B(var_0, var_1) {
  level endon("game_ended");
  level endon("timer_stop");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = "";
  }

  wait(var_0);
  self notify("timer_" + var_1);
  _id_E8EB();
}

_id_E8EB() {
  foreach(var_1 in scripts\cp\utility::_id_6C5C()) {}

  level notify("objective_timer_reset");
  level notify("timer_stop");
}

_id_E65C(var_0, var_1) {
  level endon("game_ended");
  level endon("timer_stop");

  if(!isDefined(var_1)) {
    var_1 = "#";
  }

  level thread play_timer_countdown_sfx(var_0, var_1);
  wait(var_0);
  level notify("timer_" + var_1);
  _id_E8A5();
}

play_timer_countdown_sfx(var_0, var_1) {
  level endon("game_ended");
  level endon("timer_stop");

  switch (var_1) {
    case "exfil":
      var_2 = 15;
      var_3 = "zmb_exfil_timer_countdown";
      break;
    case "domination":
      var_2 = 10;
      var_3 = "zmb_exfil_timer_countdown";
      break;
    case "assault":
      var_2 = 10;
      var_3 = "zmb_exfil_timer_countdown";
      break;
    default:
      return;
  }

  wait(var_0 - var_2);
  level.e_timer_sfx = spawn("script_origin", (0, 0, 0));
  level.e_timer_sfx playLoopSound(var_3);
  thread stop_countdown_sfx_watcher(var_1, var_3);
}

stop_countdown_sfx_watcher(var_0, var_1) {
  level scripts\engine\utility::waittill_any_3("game_ended", "timer_stop", "timer_" + var_0);

  if(isDefined(level.e_timer_sfx)) {
    level.e_timer_sfx stoploopsound();
    wait 0.1;
    level.e_timer_sfx delete();
    level.e_timer_sfx = undefined;
  }
}

_id_3F28(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2._id_A8CC)) {
      var_2._id_A8CC = var_2 scripts\cp\utility::_id_4065("default", 2);
      var_2._id_A8CC scripts\cp\utility::setpoint("CENTER", "CENTER", -300, -70);
      var_2._id_A8CC.color = (1, 1, 1);
      var_2._id_A8CC.archived = 0;
      var_2._id_A8CC._id_01D6 = 1;
    }

    var_2._id_A8CC _id_F487(1);
    var_2._id_A8CC _meth_8391(var_0);
  }
}

_id_E8A5() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_A8CC)) {
      var_1._id_A8CC _id_F488(1);
    }
  }

  level notify("objective_timer_reset");
  level notify("timer_stop");
}

_id_F487(var_0) {
  self fadeovertime(var_0);

  if(isDefined(self._id_9C52)) {
    self.alpha = self._id_9C52;
  } else {
    self.alpha = 1;
  }
}

_id_F488(var_0) {
  self fadeovertime(0.15);
  self.alpha = 0;
}

_id_E634(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3._id_A8A6)) {
      var_3._id_A8A6 = var_3 scripts\cp\utility::_id_4035(var_0, var_1);
    }

    var_3._id_A8A6 scripts\cp\utility::_id_FC11(0);
    var_3._id_A8A6.bar _id_F487(1);
    var_3._id_A8A6 _id_F487(1);
  }
}

_id_FBBA(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_A8A6)) {
      if(var_0 >= 1) {
        var_2._id_A8A6 scripts\cp\utility::_id_FC11(1);
        _id_E8D1();
        return;
      }

      var_2._id_A8A6 scripts\cp\utility::_id_FC11(var_0);
    }
  }
}

_id_E8D1() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_A8A6)) {
      var_1._id_A8A6.bar _id_F488(1);
      var_1._id_A8A6 _id_F488(1);
    }
  }
}

_id_6610() {
  return level._id_A382;
}

_id_A458(var_0) {
  wait 5;
  var_1 = 0;

  if(isDefined(var_0)) {
    var_1 = _id_660F(var_0);
  } else {
    return;
  }

  var_2 = scripts\cp\utility::_id_6C5C();

  foreach(var_4 in var_2) {}
}

_id_660F(var_0) {
  var_1 = _id_06EF::_id_672B(var_0);
  var_2 = scripts\cp\utility::_id_459B(var_1._id_A8FB, 0);
  return var_2;
}

set_objective_ui_state(var_0, var_1, var_2) {
  setomnvar("ui_zm_objective_id", var_0);
  setomnvar("ui_zm_objective_subobj_id", var_1);
  setomnvar("ui_zm_objective_state", var_2);
}

set_objective_ui_time(var_0) {
  setomnvar("ui_zm_objective_time", var_0);
}

set_objective_ui_bar_progress(var_0) {
  setomnvar("ui_zm_objective_bar_progress", var_0);
}

set_objective_ui_bar_2_progress(var_0) {
  setomnvar("ui_zm_objective_bar_2_progress", var_0);
}

set_objective_ui_bar_progress_numerical(var_0, var_1) {
  setomnvar("ui_zm_objective_bar_value_num", var_0);
  setomnvar("ui_zm_objective_bar_max_num", var_1);
}

set_objective_ui_bar_2_progress_numerical(var_0, var_1) {
  setomnvar("ui_zm_objective_bar_2_value_num", var_0);
  setomnvar("ui_zm_objective_bar_2_max_num", var_1);
}

set_objective_ui_counter(var_0, var_1) {
  self setclientomnvar("ui_zm_objective_counter_value", var_0);
  self setclientomnvar("ui_zm_objective_counter_max_value", var_1);
}

set_objective_phase_count(var_0, var_1) {
  setomnvar("ui_zm_objective_phase_current", var_0);
  setomnvar("ui_zm_objective_phase_max", var_1);
}

set_objective_target_id(var_0) {
  setomnvar("ui_zm_objective_target_id", var_0);
}

set_objective_target_color_id(var_0) {
  setomnvar("ui_zm_objective_target_color_id", var_0);
}

set_objective_show_subtext(var_0) {
  setomnvar("ui_zm_objective_subtext", var_0);
}

set_center_bar_state(var_0) {
  self setclientomnvar("ui_zm_center_progress_bar_state", var_0);
}

set_center_bar_progress(var_0) {
  self setclientomnvar("ui_zm_center_progress_bar_progress", var_0);
}

set_dg2_center_bar_state(var_0) {
  self setclientomnvar("ui_zm_center_progress_bar_shino_workbench_state", var_0);
}

set_dg2_center_bar_progress(var_0) {
  self setclientomnvar("ui_zm_center_progress_bar_shino_workbench_progress", var_0);
}

_id_C7BB() {
  foreach(var_1 in scripts\cp\utility::_id_6C5C()) {
    if(istrue(var_1.inlaststand)) {
      var_2 = spawnStruct();
      var_2._id_C7E9 = self;
      var_1 notify("player_revived", var_2);
      continue;
    }

    if(var_1 _meth_8605()) {}
  }
}

_id_C7BF() {
  foreach(var_1 in scripts\cp\utility::_id_6C5C()) {
    if(istrue(var_1.inlaststand)) {
      var_2 = spawnStruct();
      var_2._id_C7E9 = self;
      var_1 notify("player_revived", var_2);
    }
  }
}

_id_AA59(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isPlayer(var_0._id_50FF) && isDefined(level._id_3BE9._id_0F51) && isDefined(level._id_3BE9._id_0F51._id_110AC)) {
    level._id_3BE9._id_0F51._id_110AC++;
    var_0._id_50FF update_player_objective_kill_tracking(level._id_3BE9._id_0F51);
  }
}

update_player_objective_kill_tracking(var_0) {
  var_1 = scripts\cp\zombies\zm_objective_kill_caps::get_objective_kill_cap(var_0._id_3BE5);

  if(var_1 < 0) {
    return;
  }
  self.objective_kill_count = scripts\cp\utility::_id_459B(self.objective_kill_count, 0);
  self.objective_kill_count++;

  if(self.objective_kill_count >= var_1) {
    _id_0752::playerkillscoredisable(1);
  }
}

reset_all_player_objective_kill_tracking() {
  foreach(var_1 in level.players) {
    var_1.objective_kill_count = scripts\cp\utility::_id_459B(var_1.objective_kill_count, 0);
    var_1.objective_kill_count = 0;
    var_1 _id_0752::playerkillscoredisable(0);
  }
}

_id_C0A0() {}

on_objective_ai_spawned() {
  waitframe();
  self.birthplace = self.origin;

  if(!istrue(self.is_in_playspace)) {
    thread track_entry();
  }
}

track_entry() {
  self endon("death");
  self._id_A52A = 1;
  self._id_4A75 = 1;
  self.outside_playspace = 1;

  if(!isDefined(level._id_3BE9._id_0F51)) {
    return;
  }
  var_0 = level._id_3BE9._id_0F51._id_0481;

  if(isDefined(level.a_objective_zombie_entry_triggers) && isDefined(level.a_objective_zombie_entry_triggers[var_0])) {
    var_1 = level.a_objective_zombie_entry_triggers[var_0];
  } else {
    switch (var_0) {
      case "objective_red_star_apartment_second_floor_holdout":
        var_1 = "trigger_apartment_second_floor_holdout";
        break;
      case "objective_red_star_apartment_small_first_floor_holdout":
        var_1 = "trigger_apartment_small_first_floor_holdout";
        break;
      case "objective_red_star_apartment_stairwell_holdout":
        var_1 = "trigger_apartment_holdout";
        break;
      case "objective_red_star_basement_holdout":
        var_1 = "trigger_basement_holdout";
        break;
      case "objective_tonga_barnyard_holdout":
        var_1 = "trigger_tonga_barnyard_holdout";
        break;
      case "objective_tonga_barn_holdout":
        var_1 = "trigger_tonga_barn_holdout";
        break;
      case "objective_tonga_small_barn_holdout":
        var_1 = "trigger_tonga_small_barn_holdout";
        break;
      case "objective_red_star_theater_holdout":
        var_1 = "trigger_theater_holdout";
        break;
      case "objective_tonga_windmill_holdout":
        var_1 = "trigger_tonga_windmill_holdout";
        break;
      case "objective_sumpf_second_floor_holdout":
        var_1 = "trigger_sumpf_second_floor_holdout";
        break;
      case "objective_sumpf_first_floor_holdout":
        var_1 = "trigger_sumpf_first_floor_holdout";
        break;
      case "objective_sumpf_flogger_holdout":
        var_1 = "trigger_sumpf_flogger_holdout";
        break;
      case "objective_royal_hotel_clock_holdout":
        var_1 = "trigger_hotel_clock_holdout";
        break;
      case "objective_royal_hotel_clocktower_holdout":
        var_1 = "trigger_hotel_clocktower_holdout";
        break;
      case "objective_royal_hotel_south_holdout":
        var_1 = "trigger_hotel_south_holdout";
        break;
      case "objective_sumpf_top_down_soul_capture":
        var_1 = "trigger_shino_top_down_soul";
        break;
      case "objective_sumpf_bottom_up_soul_capture":
        var_1 = "trigger_shino_bottom_up_soul";
        break;
      case "objective_tonga_windmill_barn_soul_capture":
        var_1 = "trigger_tonga_windmill_barn_soul";
        break;
      case "objective_tonga_yard_small_barn_soul_capture":
        var_1 = "trigger_tonga_yard_small_barn_soul";
        break;
      case "objective_royal_hotel_clocktower_soul_capture":
        var_1 = "trigger_hotel_clocktower_soul";
        break;
      case "objective_royal_hotel_clocktower_mirror_soul_capture":
        var_1 = "trigger_hotel_clocktower_mirror_soul";
        break;
      case "objective_royal_hotel_clock_soul_capture":
        var_1 = "trigger_hotel_clock_soul";
        break;
      case "objective_red_star_theater_soul_capture":
        var_1 = "trigger_theater_soul";
        break;
      case "objective_red_star_apartment_stairwell_soul_capture":
        var_1 = "trigger_apartment_stairwell_soul";
        break;
      case "objective_red_star_apartment_top_down_soul_capture":
        var_1 = "trigger_apartment_top_down_soul";
        break;
      case "objective_apartment_top_orb_follow":
      case "objective_apartment_orb_follow":
        var_1 = "trigger_apartment_orb_follow";
        break;
      case "objective_royal_hotel_west_orb_follow":
      case "objective_royal_hotel_orb_follow":
      case "objective_royal_hotel_clock_orb_follow":
        var_1 = "trigger_royal_hotel_orb_follow";
        break;
      case "objective_domination_sumpf":
        var_1 = "trigger_shino_domination";
        break;
      case "objective_domination_apartment":
        var_1 = "trigger_apartment_domination";
        break;
      case "objective_domination_basement_indoor":
        var_1 = "trigger_basement_indoor_domination";
        break;
      case "objective_domination_basement_outdoor":
        var_1 = "trigger_basement_outdoor_domination";
        break;
      case "objective_domination_royal_hotel_north":
        var_1 = "trigger_royal_hotel_north_domination";
        break;
      case "objective_domination_royal_hotel_south":
        var_1 = "trigger_royal_hotel_south_domination";
        break;
      case "objective_domination_tonga_barn":
      case "objective_domination_tonga_windmill":
        var_1 = "trigger_tonga_domination";
        break;
      case "objective_sumpf_top_assault":
        var_1 = "trigger_shino_assault";
        break;
      case "objective_apartment_bottom_assault":
        var_1 = "trigger_apartment_assault";
        break;
      case "objective_basement_outdoor_assault":
        var_1 = "trigger_basement_outdoor_assault";
        break;
      case "objective_theater_assault":
        var_1 = "trigger_theater_assault";
        break;
      case "objective_royal_hotel_west_assault":
        var_1 = "trigger_royal_hotel_west_assault";
        break;
      case "objective_royal_hotel_east_assault":
        var_1 = "trigger_royal_hotel_east_assault";
        break;
      case "objective_tonga_windmill_assault":
        var_1 = "trigger_tonga_windmill_assault";
        break;
      case "objective_tonga_barn_assault":
        var_1 = "trigger_tonga_barn_assault";
        break;
      default:
        return;
    }
  }

  wait_till_any_objective_trigger(var_1);
  self._id_A52A = undefined;
  self._id_4A75 = undefined;
  self.outside_playspace = undefined;
}

wait_till_any_objective_trigger(var_0) {
  var_1 = spawnStruct();
  var_2 = [];

  if(_func_0121(var_0)) {
    var_2 = getEntArray(var_0, "targetname");
  } else {
    foreach(var_4 in var_0) {
      var_2 = scripts\engine\utility::array_combine(var_2, getEntArray(var_4, "targetname"));
    }
  }

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_1 thread waits_for_trigger(var_2[var_6], self);
  }

  var_1 waittill("done");
}

waits_for_trigger(var_0, var_1) {
  var_1 endon("death");
  self endon("done");

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(scripts\engine\utility::is_equal(var_1, var_2)) {
      self notify("done");
    }
  }

  self notify("done");
}

show_portaling_hud_elem(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2.portaling_text)) {
      var_2.portaling_text = var_2 scripts\cp\utility::createfontstring("default", 1);
    }

    var_2.portaling_text scripts\cp\utility::setpoint("CENTER", undefined, 0, -150);

    switch (var_0) {
      case "hub":
        var_2.portaling_text settext(&"CP_ZMB/TELEPORT_TO_HUB_LABEL");
        break;
      case "exfil":
        var_2.portaling_text settext(&"CP_ZMB/EXFIL_LABEL");
        break;
      case "objective":
        var_2.portaling_text settext(&"CP_ZMB/TELEPORT_TO_OBJECTIVE_LABEL");
        break;
      default:
        var_2.portaling_text settext(&"CP_ZMB/TELEPORT_TO_HUB_LABEL");
        break;
    }

    var_2.portaling_text.fontscale = 3;
    var_2.portaling_text.alpha = 1;
  }

  level thread cleanup_portaling_hud();
}

cleanup_portaling_hud() {
  wait 3.5;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1.portaling_text)) {
      continue;
    }
    var_1.portaling_text fadeovertime(0.15);
    var_1.portaling_text.alpha = 0;
  }
}

update_round_tracker_hud(var_0) {
  setomnvar("cp_hide_round_message", istrue(var_0));
  setomnvar("cp_round_num", level._id_11049);
}

kill_all_objective_zombies() {
  level endon("game_ended");
  var_0 = _func_0070("axis");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_2 _meth_81FA();
  }

  wait 0.2;
  var_0 = _func_0070("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 _meth_81FA();
    }
  }
}

host_migration_end() {
  if(isDefined(level._id_3BE9) && isDefined(level._id_3BE9._id_0F51) && isDefined(level._id_3BE9._id_0F51._id_3BE5)) {
    var_0 = _id_06EF::_id_672B(level._id_3BE9._id_0F51._id_3BE5);

    foreach(var_2 in level.players) {
      var_2[[var_0.objectivehotjoincallback]]();
    }
  }
}

play_objective_complete_sfx() {
  if(_func_0205("zmb_objective_complete")) {
    foreach(var_1 in level.players) {
      var_1 playsoundtoplayer("zmb_objective_complete", var_1);
    }
  }
}

clear_objective_item_positions() {
  level.get_objective_item_positions_func = undefined;
}

season_objectives_init(var_0) {
  if(!is_disabled_category("assault")) {
    scripts\cp\zombies\objective_assault::init();
  }

  if(getdvarint("#x3553d15a56298db4", 0) == 1) {
    scripts\cp\zombies\objective_forever_blitz::init();
  }
}

get_disabled_categories() {
  var_0 = [];
  var_1 = getdvarint("#x3ce6f1c71a4bdefaa", 0);

  if(var_1 == 1) {
    return undefined;
  } else {
    var_0[var_0.size] = "assault";
  }

  return var_0;
}

is_disabled_category(var_0) {
  var_1 = get_disabled_categories();

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0) {
        return 1;
      }
    }
  }

  return 0;
}