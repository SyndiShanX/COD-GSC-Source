/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_41328d99a64a9813.gsc
***********************************************/

elevator_manager() {
  level endon("game_ended");
  scripts\cp\cp_elevator::init_elevator_animations();
  _id_4E315593F65CB37C = getEntArray("spawn_elevator", "targetname");
  level.spawn_elevators = [];

  foreach(_id_D167B380D9850069 in _id_4E315593F65CB37C) {
    _id_D167B380D9850069 useanimtree(level.scr_animtree["elevator"]);
    _id_D167B380D9850069.animname = "elevator";
    level.spawn_elevators[_id_D167B380D9850069.script_noteworthy] = _id_D167B380D9850069;
  }

  for(;;) {
    level waittill("request_elevator_doors_open", group_name, _id_CAA4D0F0C7468F27);

    if(isDefined(level._id_A367B001F499E660) && level._id_A367B001F499E660 > 0)
      _id_CAA4D0F0C7468F27 = _id_21867B4FB7B6077E(group_name);

    if(isDefined(_id_CAA4D0F0C7468F27))
      thread process_elevator_request(group_name, _id_CAA4D0F0C7468F27);
  }
}

_id_21867B4FB7B6077E(group_name) {
  _id_99637F1582E29199 = _id_18A73A64992DD07D::get_module_structs_by_groupname(group_name, 1);

  if(!isDefined(_id_99637F1582E29199) || _id_99637F1582E29199.size == 0)
    return undefined;

  spawned_ai = _id_99637F1582E29199[0] _id_18A73A64992DD07D::get_spawned_ai_from_group_struct(group_name);
  _id_F651103B71C9508F = undefined;

  if(isDefined(spawned_ai) && spawned_ai.size > 0) {
    foreach(ai in spawned_ai) {
      _id_F651103B71C9508F = scripts\engine\utility::getclosest(ai.origin, level.spawn_elevators, level._id_A367B001F499E660);

      if(isDefined(_id_F651103B71C9508F)) {
        _id_7330DB20CB5FF382 = _id_F651103B71C9508F.script_noteworthy;
        return _id_7330DB20CB5FF382;
      }
    }
  }

  return undefined;
}

trigger_elevator_spawners(group) {
  self notify("basic_combat");
  self.ignoreall = 1;
  group thread play_elevator_anim_when_group_is_spawned(self);
  thread _id_8AEE4741C9766E6A(group, "elevator_opened");
}

_id_8AEE4741C9766E6A(group, waittill_notify) {
  thread _id_075B43ED977494D6(waittill_notify);
}

_id_075B43ED977494D6(waittill_notify) {
  level endon("game_ended");
  self endon("death");
  level scripts\engine\utility::waittill_any_timeout_1(10, waittill_notify);
  self.is_on_platform = 0;
  self.never_kill_off = 1;
  self.dontkilloff = 1;
  self.ignoreall = 0;
  thread _id_90236E9C00DFC046(self, self.enemy_group + "_target");
}

_id_90236E9C00DFC046(_id_CD977BE97BC0FC1E, _id_F59D2DB02887FA46) {
  _id_4128A76076005694 = 0.5;
  _id_140112F309EB244A = 0.3;
  _id_D605B525E1068107 = scripts\engine\utility::getStructArray(_id_F59D2DB02887FA46, "targetname");

  if(_id_D605B525E1068107.size == 0) {
    if(getdvarint("dvar_5C593FF6C8012AC2", 1) > 0) {
      _id_CD977BE97BC0FC1E thread _id_E66DB129FB05D119(_id_CD977BE97BC0FC1E);
      return;
    }

    _id_0386C209C4BE9E91 = _id_CD977BE97BC0FC1E findbestcovernode("cover_default", 1, _id_CD977BE97BC0FC1E.origin, 1);

    if(isDefined(_id_0386C209C4BE9E91)) {
      _id_D38A5EB1292B482C = _id_0386C209C4BE9E91.angles;
      _id_CEE7A3C264A91076 = _id_0386C209C4BE9E91.origin;

      if(!issubstr(_id_0386C209C4BE9E91.type, "Prone")) {
        if(issubstr(_id_0386C209C4BE9E91.type, "Left"))
          _id_D38A5EB1292B482C = _id_D38A5EB1292B482C + (0, 90, 0);
        else if(issubstr(_id_0386C209C4BE9E91.type, "Right") || issubstr(_id_0386C209C4BE9E91.type, "Cover Crouch") || issubstr(_id_0386C209C4BE9E91.type, "Conceal") || issubstr(_id_0386C209C4BE9E91.type, "Cover Stand"))
          _id_D38A5EB1292B482C = _id_D38A5EB1292B482C - (0, 90, 0);
      }

      _id_CD977BE97BC0FC1E scripts\common\utility::demeanor_override("sprint");
      _id_CD977BE97BC0FC1E _id_18A73A64992DD07D::set_goal_pos(_id_CEE7A3C264A91076);
      _id_CD977BE97BC0FC1E scripts\engine\utility::waittill_any_2("goal_reached", "goal");
      _id_CD977BE97BC0FC1E usecovernode(_id_0386C209C4BE9E91, 1);
      _id_CD977BE97BC0FC1E setgoalnode(_id_0386C209C4BE9E91);
      return;
    }

    _id_0386C209C4BE9E91 = getclosestnodeinsight(self.origin);

    if(isDefined(_id_0386C209C4BE9E91)) {
      _id_D38A5EB1292B482C = _id_0386C209C4BE9E91.angles;
      _id_CEE7A3C264A91076 = _id_0386C209C4BE9E91.origin;

      if(!issubstr(_id_0386C209C4BE9E91.type, "Prone")) {
        if(issubstr(_id_0386C209C4BE9E91.type, "Left"))
          _id_D38A5EB1292B482C = _id_D38A5EB1292B482C + (0, 90, 0);
        else if(issubstr(_id_0386C209C4BE9E91.type, "Right") || issubstr(_id_0386C209C4BE9E91.type, "Cover Crouch") || issubstr(_id_0386C209C4BE9E91.type, "Conceal") || issubstr(_id_0386C209C4BE9E91.type, "Cover Stand"))
          _id_D38A5EB1292B482C = _id_D38A5EB1292B482C - (0, 90, 0);
      }

      _id_CD977BE97BC0FC1E scripts\common\utility::demeanor_override("sprint");
      _id_CD977BE97BC0FC1E _id_18A73A64992DD07D::set_goal_pos(_id_CEE7A3C264A91076);
      _id_CD977BE97BC0FC1E scripts\engine\utility::waittill_any_2("goal_reached", "goal");
      _id_CD977BE97BC0FC1E usecovernode(_id_0386C209C4BE9E91, 1);
      _id_CD977BE97BC0FC1E setgoalnode(_id_0386C209C4BE9E91);
      return;
    }

    return;
  } else {
    _id_CD977BE97BC0FC1E.goalradius = 64;
    _id_9284CBA34E9BF9AE = scripts\engine\utility::random(_id_D605B525E1068107);
    _id_CD977BE97BC0FC1E _id_18A73A64992DD07D::set_goal_pos(getclosestpointonnavmesh(_id_9284CBA34E9BF9AE.origin));
    _id_CD977BE97BC0FC1E waittill("goal");

    for(;;) {
      if(isDefined(_id_9284CBA34E9BF9AE.target)) {
        _id_9284CBA34E9BF9AE = scripts\engine\utility::getStruct(_id_9284CBA34E9BF9AE.target, "targetname");
        _id_CD977BE97BC0FC1E _id_18A73A64992DD07D::set_goal_pos(getclosestpointonnavmesh(_id_9284CBA34E9BF9AE.origin));
        _id_CD977BE97BC0FC1E waittill("goal");
        wait(randomfloatrange(_id_140112F309EB244A, _id_4128A76076005694));

        if(isDefined(_id_9284CBA34E9BF9AE.script_noteworthy) && _id_9284CBA34E9BF9AE.script_noteworthy == "go_hunt_player")
          _id_CD977BE97BC0FC1E thread _id_E66DB129FB05D119(_id_CD977BE97BC0FC1E);

        continue;
      }

      return;
    }
  }
}

_id_E66DB129FB05D119(rider) {
  level endon("game_ended");
  rider endon("death");

  if(!isai(rider)) {
    return;
  }
  rider.goalradius = 128;
  rider.goalheight = 128;
  rider cleargoalvolume();

  for(;;) {
    _id_9C68E94FF2A677DB = get_closest_alive_player(rider);

    if(isDefined(_id_9C68E94FF2A677DB)) {
      break;
    }

    wait 0.1;
  }

  rider _id_18A73A64992DD07D::set_goal_pos(self getclosestreachablepointonnavmesh(_id_9C68E94FF2A677DB.origin));
  target_player = _id_9C68E94FF2A677DB;

  for(;;) {
    target_player waittill("last_stand");
    _id_2909ED8B5CAE5917 = get_closest_alive_player(rider);
    rider _id_18A73A64992DD07D::set_goal_pos(self getclosestreachablepointonnavmesh(_id_2909ED8B5CAE5917.origin));
    target_player = _id_2909ED8B5CAE5917;
  }
}

get_closest_alive_player(rider) {
  _id_E158BFBAB3D9C7DE = scripts\cp\coop_stealth::get_players_not_in_laststand();
  return scripts\engine\utility::getclosest(rider.origin, _id_E158BFBAB3D9C7DE);
}

play_elevator_anim_when_group_is_spawned(ai) {
  level endon("game_ended");
  self notify("play_elevator_anim_when_group_is_spawned");
  self endon("play_elevator_anim_when_group_is_spawned");

  if(isDefined(level._id_38B8D41AA0C9B2B2))
    wait(level._id_38B8D41AA0C9B2B2);
  else
    level waittill("spawn_module_" + self.moduleid + "_completed");

  level notify("request_elevator_doors_open", self.group_name, self.group_name + "_elevator");
}

process_elevator_request(group_name, _id_CAA4D0F0C7468F27) {
  level endon("game_ended");

  if(!isDefined(_id_CAA4D0F0C7468F27) || !isstring(_id_CAA4D0F0C7468F27)) {
    return;
  }
  if(!isDefined(group_name) || !isstring(group_name)) {
    return;
  }
  level notify("elevator_request_" + _id_CAA4D0F0C7468F27);
  level endon("elevator_request_" + _id_CAA4D0F0C7468F27);
  _id_EEC55FABA21F3653 = level.spawn_elevators[_id_CAA4D0F0C7468F27];

  if(!isDefined(_id_EEC55FABA21F3653)) {
    return;
  }
  if(istrue(_id_EEC55FABA21F3653.occupied)) {
    iprintln(" ^3elevator - ^1 " + _id_CAA4D0F0C7468F27 + " ^3 is occupied ");
    return;
  }

  _id_EEC55FABA21F3653 playSound("scn_cp_elevator_in_use_start");
  _id_EEC55FABA21F3653 playLoopSound("scn_cp_elevator_in_use_lp");
  wait(lookupsoundlength("scn_cp_elevator_in_use_lp") / 1000);
  _id_EEC55FABA21F3653 playSound("scn_cp_elevator_in_use_stop");
  _id_EEC55FABA21F3653 stoploopsound("scn_cp_elevator_in_use_lp");
  wait 1;
  _id_EEC55FABA21F3653 playSound("scn_cp_elevator_open");
  _id_EEC55FABA21F3653.occupied = 1;
  _id_EEC55FABA21F3653 thread scripts\common\anim::anim_single_solo(_id_EEC55FABA21F3653, "elevator_open");
  wait(getanimlength(level.scr_anim["elevator"]["elevator_open"]));
  _id_EEC55FABA21F3653 notify("elevator_opened");
  level notify("elevator_opened");
  level notify("elevator_opened_" + group_name);

  if(_id_AC5B4014069003E2(group_name))
    _id_7179944C63D9C99F(group_name);
  else {
    for(;;) {
      _id_59BE93542D588276 = 0;
      _id_333CFA1E234FD48F = get_ai_by_groupname(group_name);

      foreach(ai in _id_333CFA1E234FD48F) {
        if(!ai istouching(_id_EEC55FABA21F3653)) {
          continue;
        }
        _id_59BE93542D588276++;
      }

      if(_id_59BE93542D588276 == 0) {
        break;
      }

      waitframe();
    }
  }

  _id_EEC55FABA21F3653 thread scripts\common\anim::anim_single_solo(_id_EEC55FABA21F3653, "elevator_close");
  _id_EEC55FABA21F3653 playSound("scn_cp_elevator_close");
  wait(getanimlength(level.scr_anim["elevator"]["elevator_close"]));
  _id_EEC55FABA21F3653.occupied = undefined;
}

_id_AC5B4014069003E2(group_name) {
  if(isDefined(level._id_381058397007C792))
    return 1;

  if(isDefined(level._id_53B9E751611C93D3) && isDefined(level._id_53B9E751611C93D3[group_name]))
    return 1;

  return 0;
}

_id_7179944C63D9C99F(group_name) {
  if(isDefined(level._id_381058397007C792))
    [[level._id_381058397007C792]](group_name);

  if(isDefined(level._id_53B9E751611C93D3) && isDefined(level._id_53B9E751611C93D3[group_name]))
    [[level._id_53B9E751611C93D3[group_name]]](group_name);
}

get_ai_by_groupname(group_name) {
  _id_99637F1582E29199 = _id_18A73A64992DD07D::get_module_structs_by_groupname(group_name);
  guys = [];

  foreach(_id_8AA2609E46B64970 in _id_99637F1582E29199) {
    ai_array = _id_18A73A64992DD07D::get_spawned_ai_from_group_struct(group_name);

    foreach(enemy in ai_array)
    guys[guys.size] = enemy;
  }

  return guys;
}

_id_EFB89153378823AF(point) {
  return scripts\engine\utility::getclosest(point, level.spawn_elevators, 256);
}

_id_4FBCD21D182FEF58(_id_EEC55FABA21F3653) {
  level endon("game_ended");
  _id_EEC55FABA21F3653 notify("make_single_ai_request_to_open");
  _id_EEC55FABA21F3653 endon("make_single_ai_request_to_open");

  if(isDefined(level._id_38B8D41AA0C9B2B2))
    wait(level._id_38B8D41AA0C9B2B2);
  else
    level waittill("spawn_module_" + self.moduleid + "_completed");

  level thread _id_7D861621A87D2201(_id_EEC55FABA21F3653);
}

_id_7D861621A87D2201(_id_EEC55FABA21F3653) {
  level endon("game_ended");
  level notify("elevator_request_" + _id_EEC55FABA21F3653.script_noteworthy);
  level endon("elevator_request_" + _id_EEC55FABA21F3653.script_noteworthy);

  if(!isDefined(_id_EEC55FABA21F3653)) {
    return;
  }
  if(istrue(_id_EEC55FABA21F3653.occupied)) {
    iprintln(" ^3elevator - ^1 " + _id_EEC55FABA21F3653.script_noteworthy + " ^3 is occupied ");
    return;
  }

  _id_EEC55FABA21F3653 playSound("scn_cp_elevator_in_use_start");
  _id_EEC55FABA21F3653 playLoopSound("scn_cp_elevator_in_use_lp");
  wait 1;
  _id_EEC55FABA21F3653 playSound("scn_cp_elevator_in_use_stop");
  _id_EEC55FABA21F3653 stoploopsound("scn_cp_elevator_in_use_lp");
  wait 1;
  _id_EEC55FABA21F3653 playSound("scn_cp_elevator_open");
  _id_EEC55FABA21F3653.occupied = 1;
  _id_EEC55FABA21F3653 thread scripts\common\anim::anim_single_solo(_id_EEC55FABA21F3653, "elevator_open");
  wait(getanimlength(level.scr_anim["elevator"]["elevator_open"]));
  _id_EEC55FABA21F3653 notify("elevator_opened");
  _id_CD207438E3E764E6 = getaiarray("axis");

  for(;;) {
    _id_59BE93542D588276 = 0;

    foreach(ai in _id_CD207438E3E764E6) {
      if(!isalive(ai) || !distance(ai.origin, _id_EEC55FABA21F3653.origin) <= 128) {
        continue;
      }
      _id_59BE93542D588276++;
    }

    if(_id_59BE93542D588276 == 0) {
      break;
    }

    waitframe();
  }

  _id_EEC55FABA21F3653 thread scripts\common\anim::anim_single_solo(_id_EEC55FABA21F3653, "elevator_close");
  _id_EEC55FABA21F3653 playSound("scn_cp_elevator_close");
  wait(getanimlength(level.scr_anim["elevator"]["elevator_close"]));
  _id_EEC55FABA21F3653.occupied = undefined;
}