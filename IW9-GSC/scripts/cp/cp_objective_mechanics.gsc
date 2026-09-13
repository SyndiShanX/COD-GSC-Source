/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_objective_mechanics.gsc
*************************************************/

starthackingdefensewithnoobjstruct(location, duration, _id_FF8E35622C1CD1C3, team) {
  time = scripts\engine\utility::ter_op(isDefined(duration), duration, 60);
  endtime = gettime() + time * 1000;
  _id_3B5803E733581858 = 0;
  _id_451EBBF6C53EDC68 = 0.05;
  level.hack_duration = time;
  _id_198CC11E1F00E2CE = undefined;

  if(isDefined(team))
    _id_198CC11E1F00E2CE = scripts\cp\utility::getplayersinteam(team);
  else
    _id_198CC11E1F00E2CE = level.players;

  if(!isDefined(level.independent_hack_defenses))
    level.independent_hack_defenses = 1;
  else
    level.independent_hack_defenses++;

  _id_F0F08410F78DEFBC = scripts\cp\cp_objectives::requestworldid("independent_hack_" + level.independent_hack_defenses);
  _id_8B5C0F3961CCBA95 = spawnStruct();
  _id_8B5C0F3961CCBA95.currentteam = scripts\engine\utility::ter_op(isDefined(team), team, "allies");
  _id_B99260E0753975BC = 1;

  if(istrue(_id_8B5C0F3961CCBA95.no_lua))
    _id_B99260E0753975BC = 0;

  use_old_label = 0;

  if(istrue(_id_8B5C0F3961CCBA95.use_old_label))
    use_old_label = 1;

  hacking_labels_init(_id_8B5C0F3961CCBA95, use_old_label);
  hacking_ui();
  objective_setplayintro(_id_F0F08410F78DEFBC, 0);
  objective_setplayoutro(_id_F0F08410F78DEFBC, 0);
  objective_state(_id_F0F08410F78DEFBC, "current");
  objective_icon(_id_F0F08410F78DEFBC, "icon_waypoint_objective_general");
  objective_setbackground(_id_F0F08410F78DEFBC, 1);
  objective_position(_id_F0F08410F78DEFBC, location);
  objective_setshowprogress(_id_F0F08410F78DEFBC, 1);
  objective_setprogress(_id_F0F08410F78DEFBC, 0);
  objective_setownerteam(_id_F0F08410F78DEFBC, undefined);
  objective_setprogressteam(_id_F0F08410F78DEFBC, undefined);
  updatehackdefenselabel(_id_8B5C0F3961CCBA95, 0, _id_F0F08410F78DEFBC);
  _id_C8A3A9A2EF465611 = 1;
  _id_1CF220D52BECD506 = location;
  _id_8BC14603A27FA3E7 = (0, 0, 90);

  for(;;) {
    wait(_id_451EBBF6C53EDC68);
    players_in_range = 0;
    _id_EAC7308FE53BB0D8 = 0;
    _id_432026E906C458FE = [];

    foreach(player in _id_198CC11E1F00E2CE) {
      if(!player scripts\cp\utility::is_valid_player()) {
        if(isDefined(player.inhackring))
          player.inhackring = undefined;

        continue;
      }

      if(distancesquared(player.origin, _id_1CF220D52BECD506) > 14400) {
        if(isDefined(player.inhackring))
          player.inhackring = undefined;

        continue;
      }

      if(isDefined(player.perk_data["hack_speed_boost"]))
        _id_EAC7308FE53BB0D8 = _id_EAC7308FE53BB0D8 + player.perk_data["hack_speed_boost"];

      players_in_range++;

      if(!scripts\engine\utility::array_contains(_id_432026E906C458FE, player)) {
        _id_432026E906C458FE[_id_432026E906C458FE.size] = player;
        player.inhackring = 1;
      }
    }

    if(_id_C8A3A9A2EF465611 || scripts\cp\utility::roundup(_id_3B5803E733581858) % 1 == 0) {
      updatehackdefenselabel(_id_8B5C0F3961CCBA95, players_in_range, _id_F0F08410F78DEFBC);
      _id_C8A3A9A2EF465611 = 0;
    }

    if(players_in_range < 1) {
      continue;
    }
    modifier = 1;
    _id_98EA5AFB293A76A2 = 1;

    switch (players_in_range) {
      case 2:
        _id_98EA5AFB293A76A2 = 1 + 1 * modifier;
        break;
      case 3:
        _id_98EA5AFB293A76A2 = 1 + 3 * modifier;
        break;
      case 4:
        _id_98EA5AFB293A76A2 = 1 + 5 * modifier;
        break;
    }

    if(_id_EAC7308FE53BB0D8 > 0)
      _id_98EA5AFB293A76A2 = _id_98EA5AFB293A76A2 + _id_EAC7308FE53BB0D8;

    level.hack_multiplier = _id_98EA5AFB293A76A2;
    _id_3B5803E733581858 = _id_3B5803E733581858 + _id_451EBBF6C53EDC68 * _id_98EA5AFB293A76A2;

    if(_id_3B5803E733581858 >= time) {
      break;
    }

    if(isDefined(level.hack_progress) && level.hack_progress < 0) {
      break;
    }

    progression = _id_3B5803E733581858 / time;

    if(isDefined(level.hack_progress))
      progression = level.hack_progress;

    objective_setprogress(_id_F0F08410F78DEFBC, progression);
  }

  objective_setlabel(_id_F0F08410F78DEFBC, "");
  objective_sethot(_id_F0F08410F78DEFBC, 0);
  objective_setpulsate(_id_F0F08410F78DEFBC, 0);
  objective_setprogress(_id_F0F08410F78DEFBC, 0);
  objective_setshowprogress(_id_F0F08410F78DEFBC, 0);
  objective_delete(_id_F0F08410F78DEFBC);
  level.hack_duration = undefined;
  scripts\cp\cp_objectives::freeworldid("independent_hack_" + level.independent_hack_defenses);

  if(isDefined(_id_FF8E35622C1CD1C3))
    level notify(_id_FF8E35622C1CD1C3);
  else
    level notify("defense_hack_ended");
}

starthackingdefense(objectivestruct, location, duration, _id_FF8E35622C1CD1C3, radius) {
  time = scripts\engine\utility::ter_op(isDefined(duration), duration, 60);
  endtime = gettime() + time * 1000;
  _id_3B5803E733581858 = 0;
  _id_451EBBF6C53EDC68 = 0.05;

  if(!isDefined(radius))
    radius = 120;

  level.hack_duration = time;
  objective_setownerteam(objectivestruct.objectiveindex, undefined);
  objective_setprogressteam(objectivestruct.objectiveindex, undefined);
  _id_8B5C0F3961CCBA95 = spawnStruct();
  _id_8B5C0F3961CCBA95.currentteam = objectivestruct.currentteam;
  _id_B99260E0753975BC = 1;

  if(istrue(objectivestruct.no_lua))
    _id_B99260E0753975BC = 0;

  use_old_label = 0;

  if(istrue(objectivestruct.use_old_label))
    use_old_label = 1;

  hacking_labels_init(_id_8B5C0F3961CCBA95, use_old_label);
  hacking_ui();
  updatehackdefenselabel(_id_8B5C0F3961CCBA95, 0, objectivestruct.objectiveindex);
  _id_C8A3A9A2EF465611 = 1;
  _id_1CF220D52BECD506 = location;
  _id_3A54A52414143A28 = spawn("script_origin", _id_1CF220D52BECD506);
  hacking_sfx = 0;
  _id_8BC14603A27FA3E7 = (0, 0, 90);

  for(;;) {
    wait(_id_451EBBF6C53EDC68);
    players_in_range = 0;
    _id_EAC7308FE53BB0D8 = 0;
    _id_432026E906C458FE = [];

    foreach(player in scripts\cp\utility::getplayersinteam(objectivestruct.currentteam)) {
      if(!player scripts\cp\utility::is_valid_player()) {
        if(isDefined(player.inhackring))
          player.inhackring = undefined;

        continue;
      }

      if(distancesquared(player.origin, _id_1CF220D52BECD506) > radius * radius) {
        if(isDefined(player.inhackring))
          player.inhackring = undefined;

        continue;
      }

      if(istrue(objectivestruct.use_trace_radius)) {
        contents = scripts\engine\trace::create_contents(0, 1, 1, 0, 0, 0);

        if(!scripts\engine\trace::ray_trace_passed(player getEye(), _id_1CF220D52BECD506, [player], contents)) {
          if(isDefined(player.inhackring))
            player.inhackring = undefined;

          continue;
        }
      }

      if(isDefined(player.perk_data["hack_speed_boost"]))
        _id_EAC7308FE53BB0D8 = _id_EAC7308FE53BB0D8 + player.perk_data["hack_speed_boost"];

      players_in_range++;

      if(!scripts\engine\utility::array_contains(_id_432026E906C458FE, player)) {
        _id_432026E906C458FE[_id_432026E906C458FE.size] = player;
        player.inhackring = 1;

        if(hacking_sfx == 0) {
          _id_3A54A52414143A28 playSound("cp_hacking_start");
          _id_3A54A52414143A28 playLoopSound("cp_hacking_lp");
          hacking_sfx = 1;
        }
      }
    }

    if(_id_C8A3A9A2EF465611 || scripts\cp\utility::roundup(_id_3B5803E733581858) % 1 == 0) {
      updatehackdefenselabel(_id_8B5C0F3961CCBA95, players_in_range, objectivestruct.objectiveindex);
      _id_C8A3A9A2EF465611 = 0;
    }

    if(players_in_range < 1) {
      if(hacking_sfx > 0) {
        _id_3A54A52414143A28 playSound("cp_hacking_stop");
        _id_3A54A52414143A28 stoploopsound("cp_hacking_lp");
        hacking_sfx = 0;
      }

      continue;
    }

    modifier = 1;

    if(isDefined(objectivestruct.hack_modifier))
      modifier = objectivestruct.hack_modifier;

    _id_98EA5AFB293A76A2 = 1;

    switch (players_in_range) {
      case 2:
        _id_98EA5AFB293A76A2 = 1 + 1 * modifier;
        break;
      case 3:
        _id_98EA5AFB293A76A2 = 1 + 3 * modifier;
        break;
      case 4:
        _id_98EA5AFB293A76A2 = 1 + 5 * modifier;
        break;
    }

    if(_id_EAC7308FE53BB0D8 > 0)
      _id_98EA5AFB293A76A2 = _id_98EA5AFB293A76A2 + _id_EAC7308FE53BB0D8;

    level.hack_multiplier = _id_98EA5AFB293A76A2;
    _id_3B5803E733581858 = _id_3B5803E733581858 + _id_451EBBF6C53EDC68 * _id_98EA5AFB293A76A2;

    if(_id_3B5803E733581858 >= time) {
      break;
    }

    if(isDefined(level.hack_progress) && level.hack_progress < 0) {
      break;
    }

    progression = _id_3B5803E733581858 / time;

    if(isDefined(level.hack_progress))
      progression = level.hack_progress;

    if(_id_3B5803E733581858 <= 0) {
      break;
    }
  }

  _id_3A54A52414143A28 playSound("cp_hacking_stop");
  _id_3A54A52414143A28 stoploopsound("cp_hacking_lp");
  objective_setlabel(objectivestruct.objectiveindex, "");
  objective_sethot(objectivestruct.objectiveindex, 0);
  objective_setpulsate(objectivestruct.objectiveindex, 0);
  level.hack_duration = undefined;

  if(isDefined(_id_FF8E35622C1CD1C3))
    objectivestruct notify(_id_FF8E35622C1CD1C3);
  else
    objectivestruct notify("defense_hack_ended");

  _id_3A54A52414143A28 delete();
}

updatehackdefenselabel(_id_8B5C0F3961CCBA95, players_in_range, objid) {
  if(!isDefined(_id_8B5C0F3961CCBA95.players_in_range))
    _id_8B5C0F3961CCBA95.players_in_range = players_in_range;
  else if(_id_8B5C0F3961CCBA95.players_in_range == players_in_range) {
    if(!players_in_range) {
      if(!isDefined(level.rooftop_hack_paused))
        level.rooftop_hack_paused = gettime() + randomintrange(15, 25) * 1000;

      if(gettime() >= level.rooftop_hack_paused)
        level.rooftop_hack_paused = undefined;
    }

    return;
  }

  if(!players_in_range) {
    objective_setlabel(objid, _id_8B5C0F3961CCBA95.label_settings.paused);
    objective_sethot(objid, 1);
    objective_setpulsate(objid, 1);
    level.hacking_paused = 1;
    setomnvar("cpu_hacking_signal", 0);
  } else {
    level.hacking_paused = undefined;
    level.rooftop_hack_paused = undefined;

    switch (players_in_range) {
      case 1:
        objective_setlabel(objid, _id_8B5C0F3961CCBA95.label_settings.mult_1);
        break;
      case 2:
        objective_setlabel(objid, _id_8B5C0F3961CCBA95.label_settings.mult_2);
        break;
      case 3:
        objective_setlabel(objid, _id_8B5C0F3961CCBA95.label_settings.mult_3);
        break;
      case 4:
        objective_setlabel(objid, _id_8B5C0F3961CCBA95.label_settings.mult_4);
        break;
    }

    setomnvar("cpu_hacking_signal", players_in_range);
    objective_sethot(objid, 0);
    objective_setpulsate(objid, 0);
  }

  _id_8B5C0F3961CCBA95.players_in_range = players_in_range;

  if(!isDefined(level.next_hack_update_time))
    level.next_hack_update_time = gettime();

  foreach(player in scripts\cp\utility::getplayersinteam(_id_8B5C0F3961CCBA95.currentteam)) {
    if(soundexists("iw8_new_objective_sfx"))
      player playlocalsound("iw8_new_objective_sfx");
  }
}

hacking_labels_init(_id_8B5C0F3961CCBA95, use_old_label) {
  label_settings = spawnStruct();

  if(!istrue(use_old_label)) {
    label_settings.paused = &"CP_BR_SYRK_OBJECTIVES/PANHACKING_PAUSED";
    label_settings.mult_1 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_1";
    label_settings.mult_2 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_2";
    label_settings.mult_3 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_3";
    label_settings.mult_4 = &"CP_BR_SYRK_OBJECTIVES/PANHACK_IN_PROGRESS_4";
  } else {
    label_settings.paused = &"CP_BR_SYRK_OBJECTIVES/HACKING_PAUSED";
    label_settings.mult_1 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_1";
    label_settings.mult_2 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_2";
    label_settings.mult_3 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_3";
    label_settings.mult_4 = &"CP_BR_SYRK_OBJECTIVES/HACK_IN_PROGRESS_4";
  }

  _id_8B5C0F3961CCBA95.label_settings = label_settings;
}

hacking_ui() {
  level thread scripts\cp\cp_hacking::hacking_objective_time();
}

smoke_canister_spawn(location, _id_EE8BBB848A851FDD) {
  spawnpos = scripts\engine\utility::drop_to_ground(location, 50, -200, (0, 0, 1));
  spawnpos = spawnpos + (0, 0, 1);
  magicgrenademanual("deploy_airdrop_mp", spawnpos, (0, randomint(360), 0), 0.01);
}

smoke_canister_end(_id_4E0D9C78FA04CDD4) {}