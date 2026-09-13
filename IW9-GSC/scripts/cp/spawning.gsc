/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\spawning.gsc
***********************************************/

_id_4C108AF46678AF57() {
  _id_D744B74E99CE310E();
  init_spawn_vars_and_pointers();
  level thread scripts\cp\cp_skits::setup_spawn_skits();
  _id_266C399FB76E6719::_id_E364DBB1AD0A775B();
  level thread scripts\cp\cp_escalation::main();
  scripts\cp\cp_wave_spawning::init_wave_spawning();
  scripts\cp\coop_stealth::coop_stealth_init();
  level thread init_trigger_spawn_groups();

  if(!threatbiasgroupexists("axis"))
    createthreatbiasgroup("axis");

  modular_spawning_debug_init();

  if(getdvarint("dvar_5A01142D62D08A10", 1) == 1)
    _func_401D0838F4F47C3E(1);
}

_id_D744B74E99CE310E() {
  scripts\engine\utility::flag_init("disable_vehicle_spawning");
  scripts\engine\utility::flag_init("cover_spawners_initialized");
}

init_spawn_vars_and_pointers() {
  level.ignoredbycheck = ::isentignoredbyme;
  level.spawn_queue = 0;
  level.active_spawn_modules = [];
  level.spawn_module_structs_memory = [];
  level.module_group_id = 0;
  level.spawnloopupdatefunc = ::update_spawn_data_on_death;
  level.enemy_monitor_func = ::enemy_monitor;
  level.modular_spawning_vehicles = [];
  level.ambientgroups = [];
  level.current_num_spawned_enemies = 0;
  level.current_num_spawned_soldiers = 0;
  level.current_num_spawned_juggernauts = 0;
  level.reserved_spawn_slots = [];
  level.delayed_spawn_slots = 0;
  level.spawned_enemies = [];
  level.spawned_allies = [];
  level.spawned_ai = [];
  level.active_spawn_module_structs = [];
  level.spawner_script_funcs = [];
  level.requested_spawns_groups = [];
  level.valid_air_vehicle_spawn_points = [];
  level.all_spawned_vehicles = [];
  level.cluster_spawners = [];
  level.grouped_modules = [];
  level.spawn_scoring_pois = [];
  level.aitype_override = [];
  level.aitype_override_weights = [];
  level.aitype_override_cumulative_weight = 0;
  level.can_kill_off_list = [];
  level.combined_counters_groups = [];
  level.show_active_modules = 0;
  level.ignore_spawn_scoring_pois = [];
  level.spawner_poison_structs = [];
  level.skip_player_pos_memory = 0;
  level.lastspawnvocallouttimes = [];
}

isentignoredbyme(_id_3F9432BB52855FCC, _id_D620FF0C955AC649) {
  if(!isagent(_id_3F9432BB52855FCC))
    return 0;

  if(istrue(_id_D620FF0C955AC649.ignoreme))
    return 1;

  _id_B597609D6BC61FB8 = _id_3F9432BB52855FCC getthreatbiasgroup();
  _id_B597639D6BC62651 = _id_D620FF0C955AC649 getthreatbiasgroup();

  if(isDefined(level.ignoremegroups) && isDefined(level.ignoremegroups[_id_B597639D6BC62651])) {
    if(scripts\engine\utility::array_contains(level.ignoremegroups[_id_B597639D6BC62651], _id_B597609D6BC61FB8))
      return 1;
    else
      return 0;
  } else
    return 0;
}

_id_7736C252AD19C782(_id_F8E5E3AA5762A8E7, _id_536D11C1D37833B7, spawn_parameter_array, _id_3A308E048FA5CEC7) {
  if(isDefined(_id_536D11C1D37833B7)) {
    spawnpoint = _id_536D11C1D37833B7;
    spawnpoint spawner_init();
  } else
    spawnpoint = choose_spawnpoint(_id_F8E5E3AA5762A8E7);

  if(isDefined(_id_F8E5E3AA5762A8E7))
    _id_F8E5E3AA5762A8E7.respawning = undefined;

  if(!isDefined(spawnpoint)) {
    change_module_status(_id_F8E5E3AA5762A8E7, "No Spawner");
    return 0;
  }

  if(isDefined(_id_F8E5E3AA5762A8E7) && istrue(_id_F8E5E3AA5762A8E7.skip_soldier_spawn)) {
    change_module_status(_id_F8E5E3AA5762A8E7, "Skipped Spawning");
    return 1;
  }

  return _id_4441D2C30537EC6B(_id_F8E5E3AA5762A8E7, spawnpoint, 0, undefined, spawn_parameter_array, _id_3A308E048FA5CEC7);
}

choose_spawnpoint(group, respawn, _id_596674BD1F7B0B01) {
  if(isDefined(group.vehicle))
    return group.vehicle.spawn_point find_spawn_loc_from_vehicle_spawner(group);

  if(istrue(respawn))
    group.respawning = 1;
  else {}

  _id_7D259462D1A09376 = group.spawn_points;

  if(istrue(respawn) && isDefined(level._id_432E8D8D2B997226) && isDefined(level._id_432E8D8D2B997226[group.group_name]))
    _id_7D259462D1A09376 = [[level._id_432E8D8D2B997226[group.group_name]]]();

  _id_8DAA7EF0C0F67DC1 = group process_module_var(group, _id_7D259462D1A09376);
  spawn_point = group _id_54F6CD90DD31BBF0::score_ai_spawns(_id_8DAA7EF0C0F67DC1, respawn, undefined, _id_596674BD1F7B0B01);
  group.position_ref = undefined;

  if(!istrue(respawn)) {}

  group _id_54F6CD90DD31BBF0::print_spawner_score_for_factor(spawn_point);

  if(!isDefined(spawn_point))
    return undefined;

  if(istrue(spawn_point _id_0E80538EF14D00E1::is_vehicle_spawnpoint()))
    return spawn_point find_spawn_loc_from_vehicle_spawner(group);
  else if(isDefined(spawn_point.script_reuse_max)) {
    spawn_point.script_reuse_max = int(spawn_point.script_reuse_max);

    if(!isDefined(spawn_point.count))
      spawn_point.count = 1;
    else {
      spawn_point.count = int(spawn_point.count);
      spawn_point.count++;
    }

    if(spawn_point.count >= spawn_point.script_reuse_max) {
      spawn_point.used_recently = 1;
      spawn_point thread reset_spawn_vars();
    }
  } else
    spawn_point.used_recently = 1;

  return spawn_point;
}

reset_spawn_vars() {
  self notify("reset_spawn_vars");
  self endon("reset_spawn_vars");
  wait 0.1;
}

_id_4441D2C30537EC6B(_id_F8E5E3AA5762A8E7, spawnpoint, _id_8CB6EC14C2F6392D, _id_ABB7BDD43400A0C7, spawn_parameter_array, _id_3A308E048FA5CEC7) {
  spec = undefined;
  _id_536D11C1D37833B7 = undefined;
  _id_00DB52FA830038A9 = undefined;
  _id_ABB7BDD43400A0C7 = undefined;

  if(isDefined(spawnpoint.pos_override_struct)) {
    _id_536D11C1D37833B7 = spawnpoint.pos_override_struct.origin;
    _id_00DB52FA830038A9 = spawnpoint.pos_override_struct.angles;
  } else if(isDefined(spawnpoint.vehicle_position)) {
    _id_536D11C1D37833B7 = spawnpoint.origin;
    _id_00DB52FA830038A9 = spawnpoint.angles;
  }

  if(isDefined(spawnpoint.specs)) {
    if(!isarray(spawnpoint.specs))
      spawnpoint.specs = [spawnpoint.specs];

    _id_ABB7BDD43400A0C7 = scripts\engine\utility::random(spawnpoint.specs);
    spec = _id_ABB7BDD43400A0C7;
  }

  _id_07208FC96EA182F6 = 0;

  if(!isDefined(spawnpoint.count))
    spawnpoint.count = 1;

  if(isDefined(spawnpoint.script_suspend)) {
    _id_07208FC96EA182F6 = spawnpoint _id_17CA3AF80F14CE7E::prespawn_suspended_ai();

    if(spawnpoint.count == 0 && !_id_07208FC96EA182F6)
      return undefined;
  }

  if(!istrue(level._id_61198536443AD7EC))
    _id_F982E82BBD03D707();

  soldier = spawnpoint spawn_ai(_id_536D11C1D37833B7, _id_00DB52FA830038A9, _id_ABB7BDD43400A0C7, _id_F8E5E3AA5762A8E7);

  if(isDefined(soldier)) {
    soldier.suspended_ai = spawnpoint.suspended_ai;
    soldier.script_suspend = spawnpoint.script_suspend;
    soldier.script_suspend_group = spawnpoint.script_suspend_group;
    soldier.spawner = spawnpoint;
    change_module_status(_id_F8E5E3AA5762A8E7, "Found Agent");
    spawnpoint notify("spawn_success");
    level notify("spawned_group_soldier", soldier);
    level notify("ai_spawn_successful", soldier, spawnpoint, spawnpoint.origin, _id_F8E5E3AA5762A8E7);
    return run_ai_post_spawn_init(_id_F8E5E3AA5762A8E7, soldier, spawnpoint, spawn_parameter_array, spec, _id_8CB6EC14C2F6392D, _id_3A308E048FA5CEC7);
  } else {
    if(_id_07208FC96EA182F6) {
      self.count--;

      if(!isDefined(self.try_og_origin)) {
        self.try_og_origin = 1;
        spawned = spawn_ai();
        return spawned;
      } else
        self.try_og_origin = undefined;
    }

    change_module_status(_id_F8E5E3AA5762A8E7, "No Free Agent");
    spawnpoint notify("spawn_failed", spawnpoint);
    spawnpoint.aitype = undefined;

    if(istrue(_id_3A308E048FA5CEC7))
      return undefined;
    else
      return 0;
  }
}

_id_F982E82BBD03D707() {
  while(!istrue(level._id_61198536443AD7EC))
    waitframe();
}

run_ai_post_spawn_init(_id_F8E5E3AA5762A8E7, soldier, spawnpoint, spawn_parameter_array, spec, _id_8CB6EC14C2F6392D, _id_3A308E048FA5CEC7) {
  soldier endon("death");
  soldier _id_01329B355D73712F(undefined, spawnpoint, spawn_parameter_array, _id_F8E5E3AA5762A8E7);
  soldier node_fields_pre_goal(spawnpoint);

  if(isDefined(_id_F8E5E3AA5762A8E7) && _id_F8E5E3AA5762A8E7 scripts\cp\cp_spawning_util::module_disables_spawners_until_owner_death())
    soldier thread scripts\cp\cp_spawning_util::disable_spawner_until_owner_death(spawnpoint);

  copy_to_soldier_from_spawn_point(spawnpoint, soldier);

  if(!soldier is_specified_unittype("civilian"))
    soldier thread _id_0C11D6400BA31ED7::addtosquad();

  soldier _id_BF4BCF8DC0D42597(spawnpoint, spawn_parameter_array, _id_F8E5E3AA5762A8E7);
  spawnpoint _id_EC648F2C89EA1C91();
  soldier _id_389FFF85C076F49E();

  if(isDefined(soldier.suspended_ai))
    soldier _id_17CA3AF80F14CE7E::postspawn_suspended_ai();

  spawnpoint _id_9D9D82F0160FBB53(_id_F8E5E3AA5762A8E7);
  soldier _id_00B395044780AAC4();
  soldier _id_B34ED4EAFA93C760();

  if(isDefined(spawnpoint.specs) && isDefined(spec)) {
    if(scripts\engine\utility::array_contains(spawnpoint.specs, spec)) {
      spawnpoint.specs = scripts\engine\utility::array_remove(spawnpoint.specs, spec);

      if(spawnpoint.specs.size < 1)
        spawnpoint.specs = undefined;
    }
  }

  _id_DD1921916C4E99C7 = undefined;

  if(isDefined(spawnpoint.script_animation_type)) {
    if(!isDefined(_id_F8E5E3AA5762A8E7) || !_id_F8E5E3AA5762A8E7 scripts\engine\utility::ent_flag("weapons_free")) {
      _id_4B7479AE0DF07570 = strtok(spawnpoint.script_animation_type, ",");
      _id_DD1921916C4E99C7 = scripts\engine\utility::random(_id_4B7479AE0DF07570);
    }
  }

  if(isDefined(spawnpoint.script_function)) {
    if(isDefined(level.spawner_script_funcs[spawnpoint.script_function]) && isDefined(spawnpoint.ai_infil_type))
      soldier[[level.spawner_script_funcs[spawnpoint.script_function].script_function]](_id_F8E5E3AA5762A8E7, spawnpoint, spawnpoint.ai_infil_type);
  } else if(isDefined(_id_DD1921916C4E99C7) && isDefined(level.spawn_skits[_id_DD1921916C4E99C7])) {
    soldier thread enter_combat_after_stealth();
    soldier thread[[level.spawn_skits[_id_DD1921916C4E99C7].skit_func]]();

    if(isDefined(level._id_45D5787AF040313A))
      soldier[[level._id_45D5787AF040313A]](level.spawn_skits[_id_DD1921916C4E99C7]);
  } else {
    scripts\engine\utility::delaythread(5, ::unset_used_recently, spawnpoint);

    if(soldier is_patroller() || soldier is_pacifist()) {
      if(!isDefined(_id_F8E5E3AA5762A8E7) || _id_F8E5E3AA5762A8E7 scripts\engine\utility::ent_flag_exist("weapons_free") && !_id_F8E5E3AA5762A8E7 scripts\engine\utility::ent_flag("weapons_free")) {
        if(!isDefined(spawnpoint.script_demeanor)) {
          if(is_specified_unittype("civilian"))
            soldier set_demeanor_from_unittype("panic");
          else if(is_specified_unittype("juggernaut")) {
            if(soldier.spawnpoint spawnflags_check(512))
              soldier scripts\cp\cp_spawning_util::disable_juggernaut_move_behavior(_id_F8E5E3AA5762A8E7);
          } else if(isnullweapon(soldier.primaryweapon))
            soldier set_demeanor_from_unittype("patrol");
          else
            soldier set_demeanor_from_unittype("patrol");
        }

        soldier thread start_patrol();
      } else
        soldier thread enter_combat();
    } else if(isDefined(spawnpoint.target))
      soldier thread enter_combat_after_go_to_node(spawnpoint);
    else
      soldier thread enter_combat();
  }

  if(soldier scripts\cp\utility::isjuggernaut())
    _id_371B4C2AB5861E62::_id_E43F4000CAC35BA2(soldier);

  tier = "tier1";
  aitype = soldier _id_2EE1DC768D1A4703(spawnpoint);

  if(issubstr(aitype, "_t1_"))
    _id_371B4C2AB5861E62::_id_DC01679146E5F53C(soldier);
  else if(issubstr(aitype, "_t2_")) {
    tier = "tier2";
    _id_371B4C2AB5861E62::_id_DC016A9146E5FBD5(soldier);
  } else if(issubstr(aitype, "_t3_")) {
    tier = "tier3";
    _id_371B4C2AB5861E62::_id_DC01699146E5F9A2(soldier);
  }

  _id_F077ADF688122C36 = strtok(aitype, "_");
  _id_E97377032A878881 = _id_F077ADF688122C36[0];

  if(isDefined(level._id_9F0B40FBEB9CDDE2) && isDefined(level._id_9F0B40FBEB9CDDE2[_id_E97377032A878881])) {
    _id_64C6CED6D550CD33 = level._id_9F0B40FBEB9CDDE2[_id_E97377032A878881];
    soldier _id_371B4C2AB5861E62::_id_77B8B5AF85F319D8(_id_64C6CED6D550CD33);
  }

  soldier scripts\mp\mp_agent::set_agent_health(_id_371B4C2AB5861E62::_id_FB117F8CE12C38E9(tier));

  if(istrue(_id_3A308E048FA5CEC7))
    return soldier;
  else
    return 1;
}

_id_2EE1DC768D1A4703(spawnpoint) {
  if(isDefined(self.aitype))
    return self.aitype;
  else if(isDefined(spawnpoint._id_87B421D7E94C6265) && spawnpoint._id_87B421D7E94C6265 != "default")
    return spawnpoint._id_87B421D7E94C6265;
  else if(isDefined(spawnpoint.script_noteworthy))
    return spawnpoint.script_noteworthy;
  else
    return "";
}

_id_01329B355D73712F(trigger, spawnpoint, spawn_parameter_array, group) {
  if(isDefined(trigger) && isDefined(trigger.groupname))
    self.groupname = trigger.groupname;

  _id_2CAE33F77B1F866C(spawnpoint);
  _id_242733BD4DBB1979(spawnpoint);
  _id_78225857C662EBB4();
  self.qsetgoalpos = 1;
  self._id_07C968C5609ADED2 = 0;
  _id_8029849997321123();
  _id_0A3C8440BB465635(spawnpoint);

  if(isDefined(spawnpoint._id_72772FA651ECBE2B)) {
    funcs = strtok(spawnpoint._id_72772FA651ECBE2B, "+");

    foreach(func in funcs) {
      if(isDefined(level._id_A8DC22C62BA69B88[func]))
        self thread[[level._id_A8DC22C62BA69B88[func]]]();
    }
  }
}

_id_B34ED4EAFA93C760() {
  if(isDefined(self.aitype) && isDefined(level.aitypes[self.aitype]) && isDefined(level.aitypes[self.aitype].spawn_func))
    self thread[[level.aitypes[self.aitype].spawn_func]]();

  if(_id_2A3B21963254B2F6())
    thread _id_ECA783AF648F13B1(self.aitype);
}

_id_2A3B21963254B2F6() {
  _id_547FB533F1244631 = istrue(self.pacifist) || istrue(self.ignoreme) || istrue(self.ignoreall) || isDefined(level.global_stealth_broken) && !istrue(level.global_stealth_broken) || istrue(level.announcer_vo_playing) || istrue(level.spawn_vo_playing) || istrue(level.isteamvoplaying) || istrue(level.suppress_spawn_vo);
  return !_id_547FB533F1244631;
}

_id_ECA783AF648F13B1(aitype) {
  if(!getdvarint("dvar_F316D290504414C4", 0)) {
    return;
  }
  if(!isDefined(aitype)) {
    return;
  }
  if(level.lastspawnvocallouttimes[aitype] + 60000 > gettime()) {
    return;
  }
  if(isDefined(level.aitypes[aitype]) && isDefined(level.aitypes[aitype].spawn_vo_lines)) {
    lines = level.aitypes[aitype].spawn_vo_lines;
    level.spawn_vo_playing = 1;

    if(isarray(lines)) {
      _id_F2AF0F8E96B032E7 = scripts\engine\utility::random(lines);
      level _id_166B4F052DA169A7::try_to_play_vo_on_team(_id_F2AF0F8E96B032E7, "allies");
    } else
      level _id_166B4F052DA169A7::try_to_play_vo_on_team(lines, "allies");

    level.lastspawnvocallouttimes[aitype] = gettime();
    level.spawn_vo_playing = 0;
  }
}

set_character_models(bodymodelname, headmodelname, _id_41BD2EEDA1C033D2) {
  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  if(isDefined(bodymodelname))
    self setModel(bodymodelname);

  if(isDefined(headmodelname)) {
    self attach(headmodelname, "", 1);
    self.headmodel = headmodelname;
  }
}

_id_05D96B05A065564E() {
  level endon("game_ended");
  self endon("death");
  self notify("ai_watchForBadPath");
  self endon("ai_watchForBadPath");
  _id_29D65C2E0B18C7F6 = 0;
  _id_B3BFFC9A15155A83 = 0;
  wait 5;

  for(;;) {
    self waittill("bad_path", _id_772EDBDCFE906C73);

    if(getdvarint("dvar_9758CEC587280B4A", 0)) {
      break;
    }

    if(!has_never_kill_off_flag()) {
      time = gettime();

      if(time - _id_B3BFFC9A15155A83 > 5000) {
        _id_29D65C2E0B18C7F6 = 0;
        _id_B3BFFC9A15155A83 = time;
      } else {
        _id_29D65C2E0B18C7F6++;
        _id_B3BFFC9A15155A83 = time;

        if(_id_29D65C2E0B18C7F6 >= 10) {
          if(passed_kill_off_time_checks(gettime()))
            teleport_to_nearby_spawner("Bad Path", _id_772EDBDCFE906C73);
        }

        wait 0.5;
      }
    }
  }
}

copy_to_soldier_from_spawn_point(spawnpoint, soldier) {
  soldier.spawnpoint = spawnpoint;

  if(!istrue(spawnpoint _id_0E80538EF14D00E1::is_vehicle_spawnpoint()))
    soldier.target = spawnpoint.target;

  soldier.script_squadname = spawnpoint.script_squadname;
  soldier.script_stealthgroup = spawnpoint.script_stealthgroup;
  soldier.script_demeanor_post = spawnpoint.script_demeanor_post;
  soldier.script_goalheight = spawnpoint.script_goalheight;
  soldier.script_radius = spawnpoint.script_radius;
  soldier._id_9FF99CFC426066A2 = spawnpoint._id_9FF99CFC426066A2;
  soldier.dontkilloff = spawnpoint.dontkilloff;
  soldier.script_patroller = spawnpoint.script_patroller;
  soldier.equip_helmet = spawnpoint.equip_helmet;
  soldier.is_on_platform = spawnpoint.is_on_platform;
  soldier.door_spawner = spawnpoint.door_spawner;
  soldier.dont_enter_combat = spawnpoint.dont_enter_combat;
  soldier.script_origin_other = spawnpoint.script_origin_other;
  soldier.aitype = spawnpoint.aitype;

  if(isDefined(spawnpoint.script_enemyselector))
    soldier.script_enemyselector = spawnpoint.script_enemyselector;

  if(isDefined(spawnpoint.script_goalvolume))
    soldier.script_goalvolume = getEnt(spawnpoint.script_goalvolume, "targetname");
}

_id_BF4BCF8DC0D42597(spawnpoint, spawn_parameter_array, _id_F8E5E3AA5762A8E7) {
  self endon("death");

  if(!istrue(level._id_D9B24DFD45B657CB))
    thread _id_05D96B05A065564E();

  if(isDefined(_id_F8E5E3AA5762A8E7))
    _id_CBF9338E97CDB9F7(_id_F8E5E3AA5762A8E7);

  _id_B8177F07A65AA246();

  if(isDefined(level.enemy_monitor_func))
    self thread[[level.enemy_monitor_func]](self.unittype);

  if(istrue(self._id_9E5F6CA242B92628) || istrue(spawnpoint._id_9E5F6CA242B92628) || isDefined(spawnpoint.spawnflags) && spawnpoint.spawnflags & 4)
    thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1);
}

unset_used_recently(spawnpoint) {
  if(isDefined(spawnpoint))
    spawnpoint.used_recently = undefined;
}

find_spawn_loc_from_vehicle_spawner(group) {
  if(!isDefined(self.vehicle)) {
    if(!spawn_vehicle_at_vehicle_spawner(group))
      return undefined;
  }

  if(isDefined(self.vehicle) && self.vehicle scripts\common\vehicle_aianim::vehicle_hasavailablespots()) {
    level notify("vehicle_spawned", group, self.vehicle);
    group notify("vehicle_spawned", group, self.vehicle);

    if(isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_vehiclegroup))
      return get_near_vehicle_spawner();
    else {
      self.pos_override_struct = self.vehicle;
      return self;
    }
  } else
    return undefined;
}

get_near_vehicle_spawner() {
  _id_24F98AF94D03218A = scripts\engine\utility::getStructArray(self.veh_spawn_point.script_vehiclegroup, "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_24F98AF94D03218A.size; _id_AC0E594AC96AA3A8++) {
    if(_id_24F98AF94D03218A[_id_AC0E594AC96AA3A8] == self.veh_spawn_point) {
      continue;
    }
    if(!istrue(_id_24F98AF94D03218A[_id_AC0E594AC96AA3A8].disabled)) {
      self.pos_override_struct = _id_24F98AF94D03218A[_id_AC0E594AC96AA3A8];
      _id_24F98AF94D03218A[_id_AC0E594AC96AA3A8].disabled = 1;
      return self;
    }
  }

  return undefined;
}

spawn_vehicle_at_vehicle_spawner(group) {
  if(!isDefined(self.script_function))
    return 0;

  if(has_vehicle_type_exceeded_module_cap(group, self.script_function))
    return 0;

  if([[level.ai_spawn_vehicle_func[self.script_function].vehicle_spawn_func]](group, self, self.script_function)) {
    if(isDefined(group)) {
      group.vehicle vehicle_register_on_level(group.vehicle);
      group.vehicle thread vehicle_deregister_on_death(group.vehicle);
    } else {
      self.vehicle vehicle_register_on_level(self.vehicle);
      self.vehicle thread vehicle_deregister_on_death(self.vehicle);
    }

    return 1;
  } else
    return 0;
}

vehicle_register_on_level(vehicle) {
  level.modular_spawning_vehicles[vehicle getentitynumber()] = vehicle;
}

vehicle_deregister_on_death(vehicle) {
  level endon("game_ended");
  _id_8EFEF5B1E4D79B79 = vehicle getentitynumber();
  vehicle waittill("death");

  if(isDefined(vehicle.vehiclename))
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(vehicle);

  level.modular_spawning_vehicles[_id_8EFEF5B1E4D79B79] = undefined;
}

disable_spawn_point(spawn_point, timeout, group) {
  if(isDefined(timeout) && timeout > 0) {
    spawn_point disable_spawner();

    if(isDefined(group))
      group.longer_spawn_delay = 1;

    wait(timeout);

    if(isDefined(group))
      group.longer_spawn_delay = 0;

    spawn_point enable_spawner();
  } else
    spawn_point disable_spawner();
}

spawn_is_vehicle_spawn(spawn_point) {
  if(!isnode(spawn_point) && isDefined(spawn_point.spawnflags)) {
    spawnflags = int(spawn_point.spawnflags);
    _id_DAD5B086D6059445 = 16;
    _id_29E2F295ACB987F2 = 8;
    _id_4206EDAAAFF1F4B0 = 512;

    if(spawnflags &_id_DAD5B086D6059445) {
      spawn_point define_spawner("vehicle_spawner");
      spawn_point remove_from_spawner_flags(8);
      spawn_point add_to_spawner_flags(16);

      if(!isDefined(spawn_point.script_function))
        spawn_point.script_function = "random_ground_vehicle_spawn";
    }

    if(spawnflags &_id_29E2F295ACB987F2) {
      spawn_point define_spawner("vehicle_spawner");
      spawn_point add_to_spawner_flags(8);
      spawn_point remove_from_spawner_flags(16);
      spawn_point.script_goalyaw = 1;

      if(!isDefined(spawn_point.script_function))
        spawn_point.script_function = "random_air_vehicle_spawn";

      level.valid_air_vehicle_spawn_points[level.valid_air_vehicle_spawn_points.size] = spawn_point;

      if(!(spawnflags & 32))
        spawn_point.heli_path_func = _id_0E80538EF14D00E1::create_heli_path;
    }

    if((spawn_point spawner_flags_check(16) || spawn_point spawner_flags_check(8)) && spawnflags &_id_4206EDAAAFF1F4B0) {
      spawn_point.veh_model_spawner = 1;
      spawn_point.dontgetonpath = 1;
    }

    if(spawnflags &_id_29E2F295ACB987F2 || spawnflags &_id_DAD5B086D6059445) {
      return 1;
      return;
    }

    return undefined;
    return;
  } else
    return undefined;
}

define_spawner(_id_64AA8D7BF2D04944) {
  switch (_id_64AA8D7BF2D04944) {
    case "cluster_spawner":
      define_as_cluster_spawner();
      break;
    case "vehicle_spawner":
      define_as_vehicle_spawner();
      break;
  }
}

spawnflags_check(_id_27ED3D4F53AF6B75) {
  return isDefined(self.spawnflags) && self.spawnflags &_id_27ED3D4F53AF6B75;
}

spawner_flags_check(_id_27ED3D4F53AF6B75) {
  return isDefined(self.spawner_flags) && self.spawner_flags &_id_27ED3D4F53AF6B75;
}

add_to_spawner_flags(_id_1F160F711155C0F6) {
  if(isDefined(self.spawner_flags)) {
    if(!spawner_flags_check(_id_1F160F711155C0F6))
      self.spawner_flags = self.spawner_flags + _id_1F160F711155C0F6;
  } else
    self.spawner_flags = _id_1F160F711155C0F6;
}

remove_from_spawner_flags(_id_16A0B3FB97C3A2E7) {
  if(isDefined(self.spawner_flags) && self.spawner_flags &_id_16A0B3FB97C3A2E7)
    self.spawner_flags = self.spawner_flags - _id_16A0B3FB97C3A2E7;
}

define_as_cluster_spawner() {
  if(isDefined(self.spawner_flags)) {
    if(!spawner_flags_check(4))
      self.spawner_flags = self.spawner_flags + 4;
  } else
    self.spawner_flags = 4;
}

define_as_vehicle_spawner() {
  if(isDefined(self.spawner_flags)) {
    if(!spawner_flags_check(2))
      self.spawner_flags = self.spawner_flags + 2;
  } else
    self.spawner_flags = 2;
}

returnzeroifundefined(param1) {
  if(isDefined(param1))
    return param1;
  else
    return 0;
}

returnblankfuncifundefined(param1) {
  if(isDefined(param1))
    return param1;
  else
    return::blankmodulefunc;
}

blankmodulefunc(param1, param2, param3, param4, param5, param6) {}

registerambientgroup(_id_DFB0FEA7209C8A32, _id_A3BB67FB64B35B06, _id_C79F045AADAE6882, _id_2139DC3011D8D4DE, _id_FCF1D4C447A55E88, _id_68F77EB370A10612, _id_FF243CC31753ECFF, _id_730F6140263562AD, _id_3F114D8F300F41B2, timeout_action) {
  struct = spawnStruct();
  _id_FE8404E13DD6D77A = strtok(_id_DFB0FEA7209C8A32, "/");

  if(_id_FE8404E13DD6D77A.size > 1)
    struct.group_name = _id_FE8404E13DD6D77A[1];
  else
    struct.group_name = _id_DFB0FEA7209C8A32;

  struct.min_size = returnzeroifundefined(_id_A3BB67FB64B35B06);
  struct.max_size = returnzeroifundefined(_id_C79F045AADAE6882);
  struct.time_between_spawns = returnzeroifundefined(_id_FCF1D4C447A55E88);
  struct.post_module_delay = returnzeroifundefined(_id_68F77EB370A10612);
  struct.activecount = 0;
  struct.spawn_count = 0;
  struct.ai_spawned = [];
  struct.module_vehicles = [];
  struct.module_vehicles_count = 0;
  struct.total_killed = 0;
  struct.cqb_module = 0;
  struct.debug_struct = struct create_module_debug_struct();

  if(isDefined(_id_FF243CC31753ECFF)) {
    struct._id_FF243CC31753ECFF = _id_FF243CC31753ECFF;
    struct thread _id_C17D56CB0B41476D();
  }

  struct.totalspawns = returnzeroifundefined(_id_2139DC3011D8D4DE);
  struct.start_func = returnblankfuncifundefined(_id_730F6140263562AD);
  struct.nextgroup = _id_3F114D8F300F41B2;
  struct.timeout_action = timeout_action;
  struct.currentmodulekills = 0;
  struct.currentmoduledeaths = 0;

  if(isDefined(level.ambientgroups[struct.group_name])) {
    if(isarray(level.ambientgroups[struct.group_name])) {
      _id_BFC65A378A6D8EFE = [];

      foreach(_id_F90358454413407F in level.ambientgroups[struct.group_name])
      _id_BFC65A378A6D8EFE = scripts\engine\utility::array_add(_id_BFC65A378A6D8EFE, _id_F90358454413407F);

      _id_BFC65A378A6D8EFE = scripts\engine\utility::array_add(_id_BFC65A378A6D8EFE, struct);
      level.ambientgroups[struct.group_name] = _id_BFC65A378A6D8EFE;
    } else {
      _id_C9DC2E68415B7F57 = level.ambientgroups[struct.group_name];
      level.ambientgroups[struct.group_name] = [struct, _id_C9DC2E68415B7F57];
    }

    struct.moduleid = level.module_group_id;
    level.module_group_id++;
  } else {
    struct.moduleid = level.module_group_id;
    level.module_group_id++;
    level.ambientgroups[struct.group_name] = struct;
  }

  if(!istrue(level._id_F8126E87C176D7F9)) {
    _id_5198162136305E6E = ":0/" + _id_DFB0FEA7209C8A32 + ":" + level.ambientgroups.size;
    _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Start Module" + _id_5198162136305E6E + "\" \"set scr_debug_spawning spawn_module_change &" + struct.group_name + "\" \n";
    scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
    _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Stop Module" + _id_5198162136305E6E + "\" \"set scr_debug_spawning stop_module_change &" + struct.group_name + "\" \n";
    scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  }
}

_id_C17D56CB0B41476D() {
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(isfunction(self._id_FF243CC31753ECFF))
    self.spawn_points = self._id_FF243CC31753ECFF;
  else if(isarray(self._id_FF243CC31753ECFF)) {
    foreach(_id_D92716D4A2E1F895 in self._id_FF243CC31753ECFF)
    self.spawn_points = scripts\engine\utility::array_combine(self.spawn_points, scripts\engine\utility::getStructArray(_id_D92716D4A2E1F895, "targetname"));

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.spawn_points.size; _id_AC0E594AC96AA3A8++) {
      spawn_point = self.spawn_points[_id_AC0E594AC96AA3A8];
      spawn_point thread spawner_init();
    }

    self.spawn_points = [::return_spawners_by_targetname, self._id_FF243CC31753ECFF];
  } else {
    self.spawn_points = scripts\engine\utility::getStructArray(self._id_FF243CC31753ECFF, "targetname");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.spawn_points.size; _id_AC0E594AC96AA3A8++)
      self.spawn_points[_id_AC0E594AC96AA3A8] thread spawner_init();
  }
}

return_spawners_by_targetname(group, _id_3F4C0253ED16B37F) {
  if(!isarray(_id_3F4C0253ED16B37F))
    _id_3F4C0253ED16B37F = [_id_3F4C0253ED16B37F];
  else {
    _id_6D906809844C7CB1 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3F4C0253ED16B37F.size; _id_AC0E594AC96AA3A8++)
      _id_6D906809844C7CB1[_id_6D906809844C7CB1.size] = _id_3F4C0253ED16B37F[_id_AC0E594AC96AA3A8];

    _id_3F4C0253ED16B37F = _id_6D906809844C7CB1;
  }

  _id_7BBDA18A855C7111 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3F4C0253ED16B37F.size; _id_AC0E594AC96AA3A8++)
    _id_7BBDA18A855C7111 = scripts\engine\utility::array_combine(_id_7BBDA18A855C7111, scripts\engine\utility::getStructArray(_id_3F4C0253ED16B37F[_id_AC0E594AC96AA3A8], "targetname"));

  return _id_7BBDA18A855C7111;
}

delay_start_specified_module() {
  if(getDvar("dvar_3ED315459BEA5889", "") != "") {
    scripts\engine\utility::flag_wait("level_ready_for_script");
    wait 2;
    _id_F8E5E3AA5762A8E7 = run_spawn_module(getDvar("dvar_3ED315459BEA5889", ""));
  }
}

return_cover_spawners(group) {
  if(istrue(group.use_only_veh_spawners))
    return [];

  if(isDefined(group.cover_node_spawners_override) && group.cover_node_spawners_override.size > 0) {
    _id_6D906809844C7CB1 = [];
    _id_AC0E5B4AC96AA80E = getarraykeys(group.cover_node_spawners_override);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < group.cover_node_spawners_override.size; _id_AC0E594AC96AA3A8++)
      _id_6D906809844C7CB1 = scripts\engine\utility::array_combine(_id_6D906809844C7CB1, group.cover_node_spawners_override[_id_AC0E5B4AC96AA80E[_id_AC0E594AC96AA3A8]]);

    if(_id_6D906809844C7CB1.size > 0)
      return _id_6D906809844C7CB1;
  } else if(isDefined(group.wave_spawner_overrides) && group.wave_spawner_overrides.size > 0) {
    _id_6D906809844C7CB1 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < group.wave_spawner_overrides.size; _id_AC0E594AC96AA3A8++) {
      spawners = scripts\engine\utility::getStructArray(group.wave_spawner_overrides[_id_AC0E594AC96AA3A8], "targetname");
      _id_6D906809844C7CB1 = scripts\engine\utility::array_combine(_id_6D906809844C7CB1, spawners);
    }

    if(_id_6D906809844C7CB1.size > 0)
      return _id_6D906809844C7CB1;
  } else if(isDefined(group.requested_spawners) && group.requested_spawners.size > 0) {
    _id_6D906809844C7CB1 = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < group.requested_spawners.size; _id_AC0E594AC96AA3A8++) {
      spawners = scripts\engine\utility::getStructArray(group.requested_spawners[_id_AC0E594AC96AA3A8], "targetname");
      _id_6D906809844C7CB1 = scripts\engine\utility::array_combine(_id_6D906809844C7CB1, spawners);
    }

    if(_id_6D906809844C7CB1.size > 0) {
      if(isDefined(level.cover_node_spawners))
        return scripts\engine\utility::array_combine(level.cover_node_spawners, _id_6D906809844C7CB1);
      else
        return _id_6D906809844C7CB1;
    } else if(isDefined(level.cover_node_spawners))
      return level.cover_node_spawners;
    else
      return [];
  }

  if(isDefined(level.cover_node_spawners))
    return level.cover_node_spawners;
  else
    return [];
}

setup_wave_vars(group) {
  group.spawn_aitype_counts = [];
}

split_array_into_quadrants(_id_FAE2C457B55BC6E7) {
  if(isDefined(_id_FAE2C457B55BC6E7) && _id_FAE2C457B55BC6E7.size < 1)
    return [];

  center_point = scripts\cp\utility::get_center_point_of_array(_id_FAE2C457B55BC6E7);
  center_struct = spawnStruct();
  center_struct.origin = center_point;
  center_struct.angles = (0, 0, 0);
  front_right = [];
  front_left = [];
  back_right = [];
  back_left = [];
  _id_F2E65E83142A7AF4 = [];
  _id_91368E4D0F3AC988 = [];
  _id_B9136FE80F16DE8B = [];
  _id_97CA37190A8BE9AD = [];
  _id_E5B8F0D2CF9E0DAF = [];
  _id_F316CBEF6615FC99 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FAE2C457B55BC6E7.size; _id_AC0E594AC96AA3A8++) {
    point = _id_FAE2C457B55BC6E7[_id_AC0E594AC96AA3A8];
    _id_05E9F5DF422DD7FE = center_struct scripts\cp\cp_spawning_util::cp_is_point_in_front(point.origin);
    _id_9C59422C571BD361 = center_struct scripts\cp\cp_spawning_util::cp_is_point_on_right(point.origin);

    if(_id_05E9F5DF422DD7FE && _id_9C59422C571BD361) {
      front_right[front_right.size] = point;
      continue;
    }

    if(!_id_05E9F5DF422DD7FE && !_id_9C59422C571BD361) {
      back_left[back_left.size] = point;
      continue;
    }

    if(!_id_05E9F5DF422DD7FE && _id_9C59422C571BD361) {
      back_right[back_right.size] = point;
      continue;
    }

    if(_id_05E9F5DF422DD7FE && !_id_9C59422C571BD361)
      front_left[front_left.size] = point;
  }

  if(isDefined(front_right)) {
    if(front_right.size > 64) {
      _id_B9136FE80F16DE8B = split_array_into_quadrants(front_right);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B9136FE80F16DE8B.size; _id_AC0E594AC96AA3A8++) {
        parent_struct = _id_B9136FE80F16DE8B[_id_AC0E594AC96AA3A8];

        if(isDefined(parent_struct.child_spawners) && parent_struct.child_spawners.size > 0) {
          parent_struct.origin = scripts\cp\utility::get_center_point_of_array(parent_struct.child_spawners);
          parent_struct.angles = (0, 0, 0);
          _id_F2E65E83142A7AF4[_id_F2E65E83142A7AF4.size] = parent_struct;
        }
      }
    } else {
      parent_struct = spawnStruct();
      parent_struct.child_spawners = front_right;

      if(isDefined(parent_struct.child_spawners) && parent_struct.child_spawners.size > 0) {
        parent_struct.origin = scripts\cp\utility::get_center_point_of_array(parent_struct.child_spawners);
        parent_struct.angles = (0, 0, 0);
        _id_F2E65E83142A7AF4[_id_F2E65E83142A7AF4.size] = parent_struct;
      }
    }
  }

  if(isDefined(front_left)) {
    if(front_left.size > 64) {
      _id_97CA37190A8BE9AD = split_array_into_quadrants(front_left);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_97CA37190A8BE9AD.size; _id_AC0E594AC96AA3A8++) {
        parent_struct = _id_97CA37190A8BE9AD[_id_AC0E594AC96AA3A8];

        if(isDefined(parent_struct.child_spawners) && parent_struct.child_spawners.size > 0) {
          parent_struct.origin = scripts\cp\utility::get_center_point_of_array(parent_struct.child_spawners);
          parent_struct.angles = (0, 0, 0);
          _id_F2E65E83142A7AF4[_id_F2E65E83142A7AF4.size] = parent_struct;
        }
      }
    } else {
      parent_struct = spawnStruct();
      parent_struct.child_spawners = front_left;

      if(isDefined(parent_struct.child_spawners) && parent_struct.child_spawners.size > 0) {
        parent_struct.origin = scripts\cp\utility::get_center_point_of_array(parent_struct.child_spawners);
        parent_struct.angles = (0, 0, 0);
        _id_F2E65E83142A7AF4[_id_F2E65E83142A7AF4.size] = parent_struct;
      }
    }
  }

  if(isDefined(back_right)) {
    if(back_right.size > 64) {
      _id_E5B8F0D2CF9E0DAF = split_array_into_quadrants(back_right);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_E5B8F0D2CF9E0DAF.size; _id_AC0E594AC96AA3A8++) {
        parent_struct = _id_E5B8F0D2CF9E0DAF[_id_AC0E594AC96AA3A8];

        if(isDefined(parent_struct.child_spawners) && parent_struct.child_spawners.size > 0) {
          parent_struct.origin = scripts\cp\utility::get_center_point_of_array(parent_struct.child_spawners);
          parent_struct.angles = (0, 0, 0);
          _id_F2E65E83142A7AF4[_id_F2E65E83142A7AF4.size] = parent_struct;
        }
      }
    } else {
      parent_struct = spawnStruct();
      parent_struct.child_spawners = back_right;

      if(isDefined(parent_struct.child_spawners) && parent_struct.child_spawners.size > 0) {
        parent_struct.origin = scripts\cp\utility::get_center_point_of_array(parent_struct.child_spawners);
        parent_struct.angles = (0, 0, 0);
        _id_F2E65E83142A7AF4[_id_F2E65E83142A7AF4.size] = parent_struct;
      }
    }
  }

  if(isDefined(back_left)) {
    if(back_left.size > 64) {
      _id_F316CBEF6615FC99 = split_array_into_quadrants(back_left);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F316CBEF6615FC99.size; _id_AC0E594AC96AA3A8++) {
        parent_struct = _id_F316CBEF6615FC99[_id_AC0E594AC96AA3A8];

        if(isDefined(parent_struct.child_spawners) && parent_struct.child_spawners.size > 0) {
          parent_struct.origin = scripts\cp\utility::get_center_point_of_array(parent_struct.child_spawners);
          parent_struct.angles = (0, 0, 0);
          _id_F2E65E83142A7AF4[_id_F2E65E83142A7AF4.size] = parent_struct;
        }
      }
    } else {
      parent_struct = spawnStruct();
      parent_struct.child_spawners = back_left;

      if(isDefined(parent_struct.child_spawners) && parent_struct.child_spawners.size > 0) {
        parent_struct.origin = scripts\cp\utility::get_center_point_of_array(parent_struct.child_spawners);
        parent_struct.angles = (0, 0, 0);
        _id_F2E65E83142A7AF4[_id_F2E65E83142A7AF4.size] = parent_struct;
      }
    }
  }

  front_right = undefined;
  front_left = undefined;
  back_right = undefined;
  back_left = undefined;
  _id_91368E4D0F3AC988 = undefined;
  _id_B9136FE80F16DE8B = undefined;
  _id_97CA37190A8BE9AD = undefined;
  _id_E5B8F0D2CF9E0DAF = undefined;
  _id_F316CBEF6615FC99 = undefined;
  return _id_F2E65E83142A7AF4;
}

register_module_as_passive(group_name) {
  if(isDefined(level.ambientgroups[group_name])) {
    if(isarray(level.ambientgroups[group_name])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[group_name].size; _id_AC0E594AC96AA3A8++)
        level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].is_passive = 1;
    } else
      level.ambientgroups[group_name].is_passive = 1;
  }
}

register_module_ai_spawn_func(group_name, func) {
  if(isDefined(level.ambientgroups[group_name])) {
    if(isarray(level.ambientgroups[group_name])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[group_name].size; _id_AC0E594AC96AA3A8++) {
        if(!isDefined(level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].ai_spawn_func))
          level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].ai_spawn_func = [];

        level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].ai_spawn_func[level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].ai_spawn_func.size] = func;
      }
    } else {
      if(!isDefined(level.ambientgroups[group_name].ai_spawn_func))
        level.ambientgroups[group_name].ai_spawn_func = [];

      level.ambientgroups[group_name].ai_spawn_func[level.ambientgroups[group_name].ai_spawn_func.size] = func;
    }
  }
}

register_module_weapons_free_func(group_name, func) {
  if(isDefined(level.ambientgroups[group_name])) {
    if(isarray(level.ambientgroups[group_name])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[group_name].size; _id_AC0E594AC96AA3A8++) {
        if(!isDefined(level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].fn_weapons_free))
          level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].fn_weapons_free = [];

        level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].fn_weapons_free[level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].fn_weapons_free.size] = func;
      }
    } else {
      if(!isDefined(level.ambientgroups[group_name].fn_weapons_free))
        level.ambientgroups[group_name].fn_weapons_free = [];

      level.ambientgroups[group_name].fn_weapons_free[level.ambientgroups[group_name].fn_weapons_free.size] = func;
    }
  }
}

register_module_ai_death_func(group_name, func) {
  if(isDefined(level.ambientgroups[group_name])) {
    if(isarray(level.ambientgroups[group_name])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[group_name].size; _id_AC0E594AC96AA3A8++) {
        if(!isDefined(level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].ai_death_func))
          level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].ai_death_func = [];

        level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].ai_death_func[level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].ai_death_func.size] = func;
      }
    } else {
      if(!isDefined(level.ambientgroups[group_name].ai_death_func))
        level.ambientgroups[group_name].ai_death_func = [];

      level.ambientgroups[group_name].ai_death_func[level.ambientgroups[group_name].ai_death_func.size] = func;
    }
  }
}

module_run_func_after_notify() {
  if(isDefined(self.funcs_after_notifies)) {
    self endon("all_group_spawns_dead");
    _id_C72D1295873229D2 = getarraykeys(self.funcs_after_notifies);

    for(;;) {
      result = level scripts\engine\utility::waittill_any_in_array_return(_id_C72D1295873229D2);
      self thread[[self.funcs_after_notifies[result]]]();
    }
  }
}

set_spawn_scoring_params_for_group(group_name, close_dist, far_dist, too_far_dist, far_score, _id_537AF603BE2D06B4) {
  if(isDefined(_id_537AF603BE2D06B4)) {
    gametype = level.gametype;
    _id_F077ADF688122C36 = strtok(_id_537AF603BE2D06B4, " ");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F077ADF688122C36.size; _id_AC0E594AC96AA3A8++) {
      if(_id_F077ADF688122C36[_id_AC0E594AC96AA3A8] == gametype) {
        break;
      }
    }

    return;
  }

  if(isDefined(level.ambientgroups[group_name])) {
    if(isarray(level.ambientgroups[group_name])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[group_name].size; _id_AC0E594AC96AA3A8++)
        level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].spawn_scoring_overrides = create_spawn_scoring_struct(close_dist, far_dist, too_far_dist, far_score);
    } else
      level.ambientgroups[group_name].spawn_scoring_overrides = create_spawn_scoring_struct(close_dist, far_dist, too_far_dist, far_score);
  }
}

create_spawn_scoring_struct(close_dist, far_dist, too_far_dist, far_score) {
  struct = spawnStruct();

  if(isDefined(close_dist))
    struct.close_dist = int(close_dist);
  else
    struct.close_dist = 1024;

  struct.close_dist_sq = struct.close_dist * struct.close_dist;

  if(isDefined(far_dist))
    struct.far_dist = int(far_dist);
  else
    struct.far_dist = 2048;

  struct.far_dist_sq = struct.far_dist * struct.far_dist;

  if(isDefined(too_far_dist)) {
    struct.too_far_dist = int(too_far_dist);
    struct.too_far_dist_sq = struct.too_far_dist * struct.too_far_dist;
  } else {
    struct.too_far_dist = 4096;
    struct.too_far_dist_sq = 16777216;
  }

  if(isDefined(far_score))
    struct.far_score = int(far_score);
  else
    struct.far_score = 20;

  return struct;
}

get_spawned_ai_from_group_struct(group_name) {
  _id_6D906809844C7CB1 = [];

  if(isstruct(self)) {
    if(isarray(self)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.size; _id_AC0E594AC96AA3A8++)
        _id_6D906809844C7CB1 = scripts\engine\utility::array_combine(_id_6D906809844C7CB1, self[_id_AC0E594AC96AA3A8].ai_spawned);
    } else
      _id_6D906809844C7CB1 = self.ai_spawned;
  } else if(isDefined(level.active_spawn_module_structs[group_name])) {
    _id_F564CE57BB79FF69 = level.active_spawn_module_structs[group_name];

    if(isarray(_id_F564CE57BB79FF69)) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_F564CE57BB79FF69.size; _id_AC0E5C4AC96AAA41++) {
        group = _id_F564CE57BB79FF69[_id_AC0E5C4AC96AAA41];
        _id_6D906809844C7CB1 = scripts\engine\utility::array_combine(_id_6D906809844C7CB1, group.ai_spawned);
      }
    } else
      _id_6D906809844C7CB1 = scripts\engine\utility::array_combine(_id_6D906809844C7CB1, _id_F564CE57BB79FF69.ai_spawned);
  }

  return _id_6D906809844C7CB1;
}

get_module_struct_from_level(_id_DFB0FEA7209C8A32) {
  if(isDefined(level.ambientgroups) && isDefined(level.ambientgroups[_id_DFB0FEA7209C8A32]))
    return level.ambientgroups[_id_DFB0FEA7209C8A32];
  else
    return undefined;
}

isambientspawningpaused(_id_97282C14346A7FCF) {
  self endon("death");

  if(!scripts\engine\utility::flag("level_ready_for_script")) {
    scripts\engine\utility::flag_wait("level_ready_for_scrip");
    return 1;
  }

  if(scripts\engine\utility::ent_flag_exist("pause_group") && scripts\engine\utility::ent_flag("pause_group")) {
    scripts\engine\utility::ent_flag_waitopen("pause_group");
    return 1;
  }

  if(istrue(level.spawnpoint_debug))
    level waittill("end_spawnpoint_debug");

  if(istrue(level.ambient_spawning_paused)) {
    wait 0.25;
    return 1;
  }

  return 0;
}

allowed_to_spawn_agent(group, _id_87722F7BF4B569CD, _id_0D7DC5191EC1D278, _id_4B543E12BCE76BEC) {
  _id_D15FDF9B8F04F587 = get_total_reserved_slot_count();
  _id_60C216ADE254641F = get_max_agent_count();
  _id_92069F281C4B24D9 = _id_60C216ADE254641F - _id_D15FDF9B8F04F587;
  _id_4079DA1F2A53F312 = level.spawned_ai.size - level.delayed_spawn_slots;
  _id_A68ECDD462F84180 = _id_92069F281C4B24D9 - _id_4079DA1F2A53F312;

  if(isDefined(group)) {
    _id_6916E693F017E62A = group get_comp_count();

    if(!isDefined(_id_6916E693F017E62A))
      return 0;

    _id_1DF77EC96CC8ECA2 = _id_6916E693F017E62A - group get_activecount_from_group(1);
    _id_BD24AA52DBDE4AA5 = get_reserved_slot_count_by_string_id(_id_4B543E12BCE76BEC);
    _id_92069F281C4B24D9 = _id_60C216ADE254641F - _id_D15FDF9B8F04F587 + _id_BD24AA52DBDE4AA5;

    if(!istrue(group.kill_off_enemies)) {
      if(_id_1DF77EC96CC8ECA2 > 0 && _id_A68ECDD462F84180 > 0) {
        return 1;
        return;
      }

      return 0;
      return;
      return;
    }

    if(_id_1DF77EC96CC8ECA2 > 0 && _id_A68ECDD462F84180 > 0) {
      return 1;
      return;
    }

    if(!istrue(group.min_spawn_requested)) {
      group.min_spawn_requested = 1;
      group increase_reserved_spawn_slots(1, group.moduleid, group);
    }

    _id_249A41496AE927EF = 0;

    if(!istrue(group.disable_kill_off)) {
      _id_E5AE32C6AD32A1E9 = int(abs(_id_A68ECDD462F84180));
      _id_249A41496AE927EF = kill_off_enemies(group, int(clamp(_id_E5AE32C6AD32A1E9, 1, _id_92069F281C4B24D9)), istrue(group.kill_off_enemies) || istrue(_id_87722F7BF4B569CD));
    }

    if(_id_249A41496AE927EF > 0)
      wait 0.1;

    _id_E560EB1A794EF6A9 = level.spawned_ai.size - level.delayed_spawn_slots;
    _id_9C5475D0EB9BFECD = _id_92069F281C4B24D9 - _id_E560EB1A794EF6A9;
    return _id_9C5475D0EB9BFECD;
    return;
    return;
  } else if(_id_A68ECDD462F84180 < 1) {
    _id_E5AE32C6AD32A1E9 = int(abs(_id_A68ECDD462F84180));
    _id_249A41496AE927EF = kill_off_enemies(undefined, int(clamp(_id_E5AE32C6AD32A1E9, 1, _id_92069F281C4B24D9)), istrue(_id_87722F7BF4B569CD));

    if(_id_249A41496AE927EF > 0)
      wait 0.1;

    _id_E560EB1A794EF6A9 = level.spawned_ai.size - level.delayed_spawn_slots;
    _id_9C5475D0EB9BFECD = _id_92069F281C4B24D9 - _id_E560EB1A794EF6A9;
    return _id_9C5475D0EB9BFECD;
  } else
    return _id_A68ECDD462F84180;
}

get_max_agent_count(group) {
  max = getdvarint("scr_default_maxagents", 48);
  min = 32;
  _id_B83E5284E2F19975 = getdvarint("dvar_14357440EF0E5DD2", max);

  if(min > max)
    return int(min);

  return int(clamp(_id_B83E5284E2F19975, min, max));
}

get_dist_to_closest_player(a, b) {
  _id_D1850B5610E4047D = a get_closest_player_dist();
  _id_D185085610E3FDE4 = b get_closest_player_dist();
  return _id_D1850B5610E4047D > _id_D185085610E3FDE4;
}

sort_wave_spawning_ai() {
  if(isDefined(self.group)) {
    if(self.group.group_name != "wave_spawning")
      return 1;
    else
      return 0;
  } else
    return 0;
}

get_closest_player_dist() {
  _id_07296729673615C7 = 1073741824;
  _id_C729D49D406ACED8 = undefined;

  foreach(player in level.players) {
    _id_A9B6B677F6D0A010 = distancesquared(self.origin, player.origin);

    if(_id_A9B6B677F6D0A010 < _id_07296729673615C7) {
      _id_C729D49D406ACED8 = player;
      _id_07296729673615C7 = _id_A9B6B677F6D0A010;
    }
  }

  return _id_07296729673615C7;
}

kill_off_enemies(group, _id_D4F430C74063FFA9, _id_5C7E9E0CE5DB8290, _id_97282C14346A7FCF) {
  _id_40F38A94C6993104 = 0;
  _id_AB0B17E756D19D0C = gettime();

  if(isDefined(group))
    level.compare_group_name = group.group_name;

  if(istrue(_id_5C7E9E0CE5DB8290) && _id_D4F430C74063FFA9 > _id_40F38A94C6993104) {
    ai = getaiarray("axis");
    _id_3E5E959C93142185 = scripts\engine\utility::array_sort_with_func(ai, ::get_dist_to_closest_player);
    _id_3E5E959C93142185 = scripts\cp\utility::array_sort_by_handler(_id_3E5E959C93142185, ::sort_wave_spawning_ai);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3E5E959C93142185.size; _id_AC0E594AC96AA3A8++) {
      if(_id_3E5E959C93142185[_id_AC0E594AC96AA3A8] passive_kill_off_ai(1)) {
        _id_40F38A94C6993104++;

        if(_id_D4F430C74063FFA9 <= _id_40F38A94C6993104)
          return _id_40F38A94C6993104;
      }
    }

    _id_3E5E959C93142185 = scripts\engine\utility::array_removedead(_id_3E5E959C93142185);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3E5E959C93142185.size; _id_AC0E594AC96AA3A8++) {
      _id_17F33C1E1A065B75 = _id_3E5E959C93142185[_id_AC0E594AC96AA3A8];

      if(_id_17F33C1E1A065B75 has_never_kill_off_flag()) {
        continue;
      }
      if(istrue(scripts\engine\utility::script_func("ai_is_carrying_hvt", _id_17F33C1E1A065B75))) {
        continue;
      }
      if(!isDefined(_id_17F33C1E1A065B75) || !isalive(_id_17F33C1E1A065B75) || _id_17F33C1E1A065B75.health <= 0) {
        continue;
      }
      if(isDefined(_id_17F33C1E1A065B75.team) && _id_17F33C1E1A065B75.team == "allies") {
        continue;
      }
      if(isDefined(group) && scripts\engine\utility::is_equal(_id_17F33C1E1A065B75.enemy_group, group.group_name)) {
        _id_17F33C1E1A065B75 thread teleport_to_nearby_spawner("Forced Kill-Off");
        continue;
      }

      _id_17F33C1E1A065B75 script_kill_ai();
      _id_40F38A94C6993104++;

      if(_id_D4F430C74063FFA9 <= _id_40F38A94C6993104)
        return _id_40F38A94C6993104;
    }
  }

  return _id_40F38A94C6993104;
}

passed_kill_off_time_checks(_id_AB0B17E756D19D0C) {
  if(isDefined(self.killofftime) && _id_AB0B17E756D19D0C <= self.killofftime)
    return 0;
  else
    return 1;
}

get_see_recently_time_overrides() {
  if(isDefined(self.see_recently_override))
    return self.see_recently_override;
  else if(isDefined(self.group)) {
    if(isDefined(self.group.last_seen_time_override))
      return self.group.last_seen_time_override;
    else if(istrue(self.group.cqb_module))
      return 2;
    else
      return 6;
  } else
    return 6;
}

watch_for_all_groups_dead(_id_F8E5E3AA5762A8E7, _id_3A15D9380A0AC582) {
  level endon("group_" + _id_3A15D9380A0AC582 + "_ended");
  count = 0;
  _id_22BFE98214726B66 = [];

  foreach(group in _id_F8E5E3AA5762A8E7) {
    thread notify_when_group_ends(group, _id_3A15D9380A0AC582, count);
    _id_22BFE98214726B66[_id_22BFE98214726B66.size] = _id_3A15D9380A0AC582 + count + "_completed";
    count++;
  }

  level scripts\engine\utility::waittill_all_in_array(_id_22BFE98214726B66);
  level notify("module_group " + _id_3A15D9380A0AC582 + " completed");
}

notify_when_group_ends(group, _id_3A15D9380A0AC582, count) {
  level endon("group_" + _id_3A15D9380A0AC582 + "_ended");
  group waittill("group_spawning_completed");
  level notify(_id_3A15D9380A0AC582 + count + "_completed");
}

run_spawn_module(_id_3A15D9380A0AC582, _id_1AF409DE0A7CA644, group, _id_946A6BB4C1F4FF6A, kill_off_enemies) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(getdvarint("dvar_35DEC012C752370D", 0)) {
    if(isDefined(level.ambientgroups[_id_3A15D9380A0AC582]) && !istrue(level.ambientgroups[_id_3A15D9380A0AC582].is_passive))
      return;
  }

  level notify("new_spawn_module_requested_" + _id_3A15D9380A0AC582);
  level.active_spawn_modules[level.active_spawn_modules.size] = _id_3A15D9380A0AC582;

  if(!isDefined(level.active_spawn_module_structs[_id_3A15D9380A0AC582]))
    level.active_spawn_module_structs[_id_3A15D9380A0AC582] = [];

  if(!isDefined(level.spawn_module_structs_memory[_id_3A15D9380A0AC582]))
    level.spawn_module_structs_memory[_id_3A15D9380A0AC582] = [];

  _id_F8E5E3AA5762A8E7 = create_module_struct(_id_3A15D9380A0AC582);

  if(isDefined(_id_F8E5E3AA5762A8E7)) {
    if(isarray(_id_F8E5E3AA5762A8E7)) {
      _id_F8E5E3AA5762A8E7 thread watch_for_all_groups_dead(_id_F8E5E3AA5762A8E7, _id_3A15D9380A0AC582);

      foreach(group in _id_F8E5E3AA5762A8E7)
      level thread add_and_watch_group(group, _id_3A15D9380A0AC582);

      foreach(group in _id_F8E5E3AA5762A8E7)
      level thread run_current_spawn_group(group, 1);
    } else {
      level thread add_and_watch_group(_id_F8E5E3AA5762A8E7, _id_3A15D9380A0AC582);
      level thread run_current_spawn_group(_id_F8E5E3AA5762A8E7, 0);
    }

    return _id_F8E5E3AA5762A8E7;
  }
}

add_and_watch_group(group, _id_3A15D9380A0AC582) {
  level endon("game_ended");
  level.active_spawn_module_structs[_id_3A15D9380A0AC582][level.active_spawn_module_structs[_id_3A15D9380A0AC582].size] = group;
  level.spawn_module_structs_memory[_id_3A15D9380A0AC582][level.spawn_module_structs_memory[_id_3A15D9380A0AC582].size] = group;
  group waittill("death");

  if(group get_activecount_from_group(1) < 1) {
    scripts\cp\cp_spawning_util::remove_group_from_combined_module_counters(group);

    if(isDefined(level.spawn_module_structs_memory[group.group_name]) && scripts\engine\utility::array_contains(level.spawn_module_structs_memory[group.group_name], group)) {
      level.spawn_module_structs_memory[group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[group.group_name], group);

      if(isDefined(level.spawn_module_structs_memory[group.group_name]) && level.spawn_module_structs_memory[group.group_name].size < 1)
        level.spawn_module_structs_memory[group.group_name] = undefined;
    }
  }

  if(scripts\engine\utility::array_contains(level.active_spawn_module_structs[_id_3A15D9380A0AC582], group)) {
    level.active_spawn_module_structs[_id_3A15D9380A0AC582] = scripts\engine\utility::array_remove(level.active_spawn_module_structs[_id_3A15D9380A0AC582], group);

    if(isDefined(level.active_spawn_module_structs[_id_3A15D9380A0AC582]) && level.active_spawn_module_structs[_id_3A15D9380A0AC582].size < 1)
      level.active_spawn_module_structs[_id_3A15D9380A0AC582] = undefined;
  }
}

create_module_struct(_id_3A15D9380A0AC582) {
  _id_F9AAE8D4C5B93FF7 = get_module_struct_from_level(_id_3A15D9380A0AC582);

  if(isDefined(_id_F9AAE8D4C5B93FF7)) {
    if(isarray(_id_F9AAE8D4C5B93FF7)) {
      _id_6D906809844C7CB1 = [];

      foreach(_id_F90358454413407F in _id_F9AAE8D4C5B93FF7) {
        struct = copy_from_level_struct(_id_F90358454413407F);
        _id_6D906809844C7CB1 = scripts\engine\utility::array_add(_id_6D906809844C7CB1, struct);
      }

      return _id_6D906809844C7CB1;
    } else {
      struct = copy_from_level_struct(_id_F9AAE8D4C5B93FF7);
      return struct;
    }
  }
}

copy_from_level_struct(_id_F90358454413407F) {
  struct = spawnStruct();
  struct.group_name = _id_F90358454413407F.group_name;
  struct.min_size = _id_F90358454413407F.min_size;
  struct.max_size = _id_F90358454413407F.max_size;
  struct.time_between_spawns = _id_F90358454413407F.time_between_spawns;
  struct.post_module_delay = _id_F90358454413407F.post_module_delay;
  struct.activecount = _id_F90358454413407F.activecount;
  struct.spawn_count = _id_F90358454413407F.spawn_count;
  struct.ai_spawned = _id_F90358454413407F.ai_spawned;
  struct.spawn_points = _id_F90358454413407F.spawn_points;
  struct.totalspawns = _id_F90358454413407F.totalspawns;
  struct.start_func = _id_F90358454413407F.start_func;
  struct.nextgroup = _id_F90358454413407F.nextgroup;
  struct.timeout_action = _id_F90358454413407F.timeout_action;
  struct.currentmodulekills = _id_F90358454413407F.currentmodulekills;
  struct.currentmoduledeaths = _id_F90358454413407F.currentmoduledeaths;
  struct.moduleid = _id_F90358454413407F.moduleid;
  struct.ai_spawn_func = _id_F90358454413407F.ai_spawn_func;
  struct.ai_death_func = _id_F90358454413407F.ai_death_func;
  struct.fn_weapons_free = _id_F90358454413407F.fn_weapons_free;
  struct.cqb_module = _id_F90358454413407F.cqb_module;
  struct.always_attempt_killoff = _id_F90358454413407F.always_attempt_killoff;
  struct.status = _id_F90358454413407F.status;
  struct.spawn_scoring_overrides = _id_F90358454413407F.spawn_scoring_overrides;
  struct.aievent_funcs = _id_F90358454413407F.aievent_funcs;
  struct.is_passive = _id_F90358454413407F.is_passive;
  struct.module_vehicles = _id_F90358454413407F.module_vehicles;
  struct.module_vehicles_count = _id_F90358454413407F.module_vehicles_count;
  struct.disable_spawners_until_owner_death = _id_F90358454413407F.disable_spawners_until_owner_death;
  struct.combined_counters = _id_F90358454413407F.combined_counters;
  struct.vehicle_invalid_seats = _id_F90358454413407F.vehicle_invalid_seats;
  struct.debug_data = _id_F90358454413407F.debug_data;
  struct.total_killed = _id_F90358454413407F.total_killed;
  struct.grenade_types = _id_F90358454413407F.grenade_types;
  struct.grenade_chances = _id_F90358454413407F.grenade_chances;
  struct.died_poorly_funcs = _id_F90358454413407F.died_poorly_funcs;
  struct.spawn_aitype_counts = _id_F90358454413407F.spawn_aitype_counts;
  struct.level_module_struct = _id_F90358454413407F;
  level.requested_spawns_groups[struct.moduleid] = 0;
  struct scripts\engine\utility::ent_flag_init("pause_group");
  struct scripts\engine\utility::ent_flag_init("weapons_free");
  return struct;
}

add_to_module_vehicles_list(_id_F8E5E3AA5762A8E7, infil_name) {
  if(isDefined(infil_name)) {
    if(!isDefined(_id_F8E5E3AA5762A8E7.vehicle_caps_counter))
      _id_F8E5E3AA5762A8E7.vehicle_caps_counter = [];

    if(!isDefined(_id_F8E5E3AA5762A8E7.vehicle_caps_counter[infil_name]))
      _id_F8E5E3AA5762A8E7.vehicle_caps_counter[infil_name] = 1;
    else
      _id_F8E5E3AA5762A8E7.vehicle_caps_counter[infil_name]++;
  }

  _id_F8E5E3AA5762A8E7.module_vehicles_count++;
  _id_F8E5E3AA5762A8E7.module_vehicles[_id_F8E5E3AA5762A8E7.module_vehicles.size] = self;
  thread scripts\engine\utility::thread_on_notify_no_endon_death("death", ::remove_from_module_vehicles_list, _id_F8E5E3AA5762A8E7, infil_name);
}

has_vehicle_type_exceeded_module_cap(_id_F8E5E3AA5762A8E7, infil_name) {
  if(!isDefined(_id_F8E5E3AA5762A8E7))
    return 0;

  if(!isDefined(_id_F8E5E3AA5762A8E7.vehicle_caps))
    return 0;

  if(isDefined(_id_F8E5E3AA5762A8E7.vehicle_caps[infil_name])) {
    if(!isDefined(_id_F8E5E3AA5762A8E7.vehicle_caps_counter))
      return 0;

    if(!isDefined(_id_F8E5E3AA5762A8E7.vehicle_caps_counter[infil_name]))
      return 0;

    if(_id_F8E5E3AA5762A8E7.vehicle_caps_counter[infil_name] >= _id_F8E5E3AA5762A8E7.vehicle_caps[infil_name])
      return 1;
  }

  return 0;
}

remove_from_module_vehicles_list(_id_F8E5E3AA5762A8E7, infil_name) {
  if(isDefined(infil_name)) {
    if(isDefined(_id_F8E5E3AA5762A8E7.vehicle_caps_counter)) {
      if(isDefined(_id_F8E5E3AA5762A8E7.vehicle_caps_counter[infil_name])) {
        _id_F8E5E3AA5762A8E7.vehicle_caps_counter[infil_name]--;

        if(_id_F8E5E3AA5762A8E7.vehicle_caps_counter[infil_name] < 0)
          _id_F8E5E3AA5762A8E7.vehicle_caps_counter[infil_name] = 0;
      }
    }
  }

  if(scripts\engine\utility::array_contains(_id_F8E5E3AA5762A8E7.module_vehicles, self))
    _id_F8E5E3AA5762A8E7.module_vehicles = scripts\engine\utility::array_remove(_id_F8E5E3AA5762A8E7.module_vehicles, self);

  _id_F8E5E3AA5762A8E7 notify("vehicle_removed_from_group");
}

timeout_group_after_duration() {
  self endon("death");
  level notify("timeout_group_after_duration_" + self.moduleid);
  level endon("timeout_group_after_duration_" + self.moduleid);
  level endon("group_" + self.group_name + "_ended");
  _id_0CF1441229A2390C = process_module_var(self, self.timeout_action);

  if(isDefined(_id_0CF1441229A2390C) && isnumber(_id_0CF1441229A2390C))
    wait(_id_0CF1441229A2390C);

  level notify("spawnModuleTimedOut_" + self.moduleid);
}

run_current_spawn_group(_id_F8E5E3AA5762A8E7, _id_7108B91FA6AC216B) {
  level notify("run_current_spawn_group" + _id_F8E5E3AA5762A8E7.moduleid);
  level endon("game_ended");
  _id_F8E5E3AA5762A8E7 endon("death");
  _id_F8E5E3AA5762A8E7 thread watch_for_module_endons();
  _id_F8E5E3AA5762A8E7 thread run_post_module_actions();
  _id_F8E5E3AA5762A8E7 thread module_run_func_after_notify();

  if(isDefined(_id_F8E5E3AA5762A8E7.timeout_action))
    _id_F8E5E3AA5762A8E7 thread timeout_group_after_duration();

  change_module_status(_id_F8E5E3AA5762A8E7, "Init Funcs");
  _id_F8E5E3AA5762A8E7 scripts\cp\cp_spawning_util::run_module_init_funcs_on_module_struct();

  if(isDefined(_id_F8E5E3AA5762A8E7.start_func)) {
    change_module_status(_id_F8E5E3AA5762A8E7, "Start Func");
    process_module_var(_id_F8E5E3AA5762A8E7, _id_F8E5E3AA5762A8E7.start_func);
  }

  _id_F8E5E3AA5762A8E7 thread run_weapons_free_funcs();

  if(getDvar("dvar_B0F661A58F72BCA5", "") != "" && getDvar("dvar_B0F661A58F72BCA5", "") == _id_F8E5E3AA5762A8E7.group_name)
    level thread runspawnmodule_isolated(_id_F8E5E3AA5762A8E7, _id_7108B91FA6AC216B);
  else
    level thread runspawnmodule(_id_F8E5E3AA5762A8E7, _id_7108B91FA6AC216B);

  _id_F8E5E3AA5762A8E7 waittill("death");
}

run_weapons_free_funcs() {
  if(isDefined(self.fn_weapons_free)) {
    scripts\engine\utility::ent_flag_wait("weapons_free");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.fn_weapons_free.size; _id_AC0E594AC96AA3A8++)
      thread process_module_var(self, self.fn_weapons_free[_id_AC0E594AC96AA3A8]);
  }
}

run_died_poorly_funcs() {
  if(isDefined(self.group.died_poorly_funcs)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.group.died_poorly_funcs.size; _id_AC0E594AC96AA3A8++)
      thread process_module_var(self.group, self.group.died_poorly_funcs[_id_AC0E594AC96AA3A8]);
  }
}

run_post_module_actions() {
  level endon("game_ended");
  self endon("death");
  result = level scripts\engine\utility::waittill_any_return_2("spawn_module_" + self.moduleid + "_completed", "spawnModuleTimedOut_" + self.moduleid);

  if(isDefined(self.post_module_delay)) {
    post_module_delay = process_module_var(self, self.post_module_delay);

    if(isDefined(post_module_delay) && isnumberandgreaterthanzero(post_module_delay))
      level scripts\engine\utility::waittill_any_timeout_1(post_module_delay, "new_module_requested");

    level notify("group_" + self.group_name + "_post_module_complete");
  }

  if(isDefined(self.nextgroup)) {
    _id_D301A5EC19274730 = process_module_var(self, self.nextgroup);

    if(isDefined(_id_D301A5EC19274730) && isstring(_id_D301A5EC19274730))
      level thread run_spawn_module(_id_D301A5EC19274730, undefined, self);
  }

  if(isDefined(level._id_48EA085692ABDACF) && isfunction(level._id_48EA085692ABDACF))
    level thread[[level._id_48EA085692ABDACF]](self.group_name);

  self notify("death");
}

remove_pacifist_from_guy() {
  self.pacifist = 0;
  self.script_pacifist = undefined;
}

watch_for_module_endons() {
  level endon("game_ended");
  self endon("death");
  _id_12E27B3BF88D446D = ["run_current_spawn_group" + self.moduleid, "end_spawn_module_" + self.moduleid, "end_spawn_module_" + self.group_name];
  level scripts\engine\utility::waittill_any_in_array_return(_id_12E27B3BF88D446D);
  self notify("death");
}

isnumberandgreaterthanzero(param1) {
  if(isDefined(param1) && isnumber(param1) && param1 > 0)
    return 1;
  else
    return 0;
}

runspawnmodule(_id_F8E5E3AA5762A8E7, _id_7108B91FA6AC216B) {
  level endon("game_ended");
  level notify("runSpawnModule_" + _id_F8E5E3AA5762A8E7.moduleid);
  level endon("runSpawnModule_" + _id_F8E5E3AA5762A8E7.moduleid);
  _id_F8E5E3AA5762A8E7 endon("death");
  _id_F8E5E3AA5762A8E7 thread resetgroupvariables();
  waittillframeend;

  for(;;) {
    if(_id_F8E5E3AA5762A8E7 isambientspawningpaused()) {
      change_module_status(_id_F8E5E3AA5762A8E7, "Module Paused");
      continue;
    }

    totalspawns = process_module_var(_id_F8E5E3AA5762A8E7, _id_F8E5E3AA5762A8E7.totalspawns);
    _id_F8E5E3AA5762A8E7.debug_data.totalspawns = totalspawns;

    if(totalspawns > 0 && _id_F8E5E3AA5762A8E7 get_activecount_from_group(1) + _id_F8E5E3AA5762A8E7.currentmodulekills >= totalspawns) {
      level notify("spawn_module_" + _id_F8E5E3AA5762A8E7.moduleid + "_completed");
      return;
    }

    totalspawns = process_module_var(_id_F8E5E3AA5762A8E7, _id_F8E5E3AA5762A8E7.totalspawns);
    _id_F8E5E3AA5762A8E7.debug_data.totalspawns = totalspawns;
    _id_E5FE678CFA5228DA = _id_F8E5E3AA5762A8E7 get_comp_count();
    _id_51736AADD2FAE346 = _id_F8E5E3AA5762A8E7 get_comp_count(0);
    result = allowed_to_spawn_agent(_id_F8E5E3AA5762A8E7);

    if(result) {
      if(isDefined(_id_E5FE678CFA5228DA) && isDefined(_id_51736AADD2FAE346) && _id_F8E5E3AA5762A8E7 get_activecount_from_group(1) < _id_E5FE678CFA5228DA && _id_F8E5E3AA5762A8E7 get_activecount_from_group() < _id_51736AADD2FAE346)
        _id_F8E5E3AA5762A8E7 _id_7736C252AD19C782(_id_F8E5E3AA5762A8E7);

      time_between_spawns = process_module_var(_id_F8E5E3AA5762A8E7, _id_F8E5E3AA5762A8E7.time_between_spawns);

      if(isnumberandgreaterthanzero(time_between_spawns))
        wait(time_between_spawns);
      else
        waitframe();

      continue;
    }

    wait 0.1;
  }
}

runspawnmodule_isolated(_id_F8E5E3AA5762A8E7, _id_7108B91FA6AC216B) {
  level endon("game_ended");
  level notify("runSpawnModule_" + _id_F8E5E3AA5762A8E7.moduleid);
  level endon("runSpawnModule_" + _id_F8E5E3AA5762A8E7.moduleid);
  _id_F8E5E3AA5762A8E7 endon("death");
  _id_F8E5E3AA5762A8E7 thread resetgroupvariables();

  for(;;) {
    if(_id_F8E5E3AA5762A8E7 isambientspawningpaused()) {
      change_module_status(_id_F8E5E3AA5762A8E7, "Module Paused");
      continue;
    }

    totalspawns = process_module_var(_id_F8E5E3AA5762A8E7, _id_F8E5E3AA5762A8E7.totalspawns);
    _id_F8E5E3AA5762A8E7.debug_data.totalspawns = totalspawns;

    if(totalspawns > 0 && _id_F8E5E3AA5762A8E7 get_activecount_from_group(1) + _id_F8E5E3AA5762A8E7.currentmodulekills >= totalspawns) {
      level notify("spawn_module_" + _id_F8E5E3AA5762A8E7.moduleid + "_completed");
      return;
    }

    totalspawns = process_module_var(_id_F8E5E3AA5762A8E7, _id_F8E5E3AA5762A8E7.totalspawns);
    _id_F8E5E3AA5762A8E7.debug_data.totalspawns = totalspawns;
    _id_E5FE678CFA5228DA = _id_F8E5E3AA5762A8E7 get_comp_count();
    _id_51736AADD2FAE346 = _id_F8E5E3AA5762A8E7 get_comp_count(0);
    result = allowed_to_spawn_agent(_id_F8E5E3AA5762A8E7);

    if(result) {
      if(isDefined(_id_E5FE678CFA5228DA) && isDefined(_id_51736AADD2FAE346) && _id_F8E5E3AA5762A8E7 get_activecount_from_group(1) < _id_E5FE678CFA5228DA && _id_F8E5E3AA5762A8E7 get_activecount_from_group() < _id_51736AADD2FAE346)
        _id_F8E5E3AA5762A8E7 _id_7736C252AD19C782(_id_F8E5E3AA5762A8E7);

      time_between_spawns = process_module_var(_id_F8E5E3AA5762A8E7, _id_F8E5E3AA5762A8E7.time_between_spawns);

      if(isnumberandgreaterthanzero(time_between_spawns))
        wait(time_between_spawns);

      continue;
    }

    wait 0.1;
  }
}

get_comp_count(_id_C7E4DD697F9B264E) {
  _id_036F6B22F5471A07 = process_module_var(self, self.min_size);
  self.debug_data.min_size = _id_036F6B22F5471A07;
  self.kill_off_enemies = undefined;
  _id_C7E4DD697F9B264E = define_var_if_undefined(_id_C7E4DD697F9B264E, 1);

  if(isDefined(_id_036F6B22F5471A07) && get_activecount_from_group(_id_C7E4DD697F9B264E) < _id_036F6B22F5471A07) {
    self.kill_off_enemies = 1;
    level.requested_spawns_groups[self.moduleid] = _id_036F6B22F5471A07;
    return _id_036F6B22F5471A07;
  }

  _id_7AD0F060D966EC01 = process_module_var(self, self.max_size);
  self.debug_data.max_size = _id_7AD0F060D966EC01;

  if(isDefined(_id_7AD0F060D966EC01) && get_activecount_from_group(_id_C7E4DD697F9B264E) < _id_7AD0F060D966EC01) {
    level.requested_spawns_groups[self.moduleid] = _id_7AD0F060D966EC01;
    return _id_7AD0F060D966EC01;
  }

  return undefined;
}

run_func_on_group_by_groupname(group_name, _id_88C4A89E97CB6E1C) {
  foreach(_id_F564CE57BB79FF69 in level.active_spawn_module_structs) {
    if(isarray(_id_F564CE57BB79FF69)) {
      foreach(struct in _id_F564CE57BB79FF69) {
        if(struct.group_name == group_name)
          struct process_module_var(struct, _id_88C4A89E97CB6E1C);
      }

      continue;
    }

    if(_id_F564CE57BB79FF69.group_name == group_name)
      _id_F564CE57BB79FF69 process_module_var(_id_F564CE57BB79FF69, _id_88C4A89E97CB6E1C);
  }
}

pause_all_other_groups(group_name) {
  foreach(_id_F564CE57BB79FF69 in level.active_spawn_module_structs) {
    if(isarray(_id_F564CE57BB79FF69)) {
      foreach(struct in _id_F564CE57BB79FF69) {
        if(struct.group_name != group_name) {
          if(getdvarint("dvar_8DFD6BDD237FF1AB", 0))
            announcement(struct.group_name + " ^1Paused");

          struct scripts\engine\utility::ent_flag_set("pause_group");
        }
      }

      continue;
    }

    if(_id_F564CE57BB79FF69.group_name != group_name) {
      if(getdvarint("dvar_8DFD6BDD237FF1AB", 0))
        announcement(_id_F564CE57BB79FF69.group_name + " ^1Paused");

      _id_F564CE57BB79FF69 scripts\engine\utility::ent_flag_set("pause_group");
    }
  }
}

unpause_all_other_groups(group_name) {
  foreach(_id_F564CE57BB79FF69 in level.active_spawn_module_structs) {
    if(isarray(_id_F564CE57BB79FF69)) {
      foreach(struct in _id_F564CE57BB79FF69) {
        if(struct.group_name != group_name) {
          if(getdvarint("dvar_8DFD6BDD237FF1AB", 0))
            announcement(struct.group_name + " ^3Unpaused");

          struct scripts\engine\utility::ent_flag_clear("pause_group");
        }
      }

      continue;
    }

    if(_id_F564CE57BB79FF69.group_name != group_name) {
      if(getdvarint("dvar_8DFD6BDD237FF1AB", 0))
        announcement(_id_F564CE57BB79FF69.group_name + " ^3Unpaused");

      _id_F564CE57BB79FF69 scripts\engine\utility::ent_flag_clear("pause_group");
    }
  }
}

pause_group_by_group_name(group_name) {
  foreach(_id_F564CE57BB79FF69 in level.active_spawn_module_structs) {
    if(isarray(_id_F564CE57BB79FF69)) {
      foreach(struct in _id_F564CE57BB79FF69) {
        if(struct.group_name == group_name) {
          if(getdvarint("dvar_8DFD6BDD237FF1AB", 0))
            announcement(struct.group_name + " ^1Paused");

          struct scripts\cp\cp_spawning_util::run_module_pause_funcs();
          struct scripts\engine\utility::ent_flag_set("pause_group");
        }
      }

      continue;
    }

    if(_id_F564CE57BB79FF69.group_name == group_name) {
      if(getdvarint("dvar_8DFD6BDD237FF1AB", 0))
        announcement(_id_F564CE57BB79FF69.group_name + " ^1Paused");

      _id_F564CE57BB79FF69 scripts\cp\cp_spawning_util::run_module_pause_funcs();
      _id_F564CE57BB79FF69 scripts\engine\utility::ent_flag_set("pause_group");
    }
  }
}

unpause_group_by_group_name(group_name) {
  foreach(_id_F564CE57BB79FF69 in level.active_spawn_module_structs) {
    if(isarray(_id_F564CE57BB79FF69)) {
      foreach(struct in _id_F564CE57BB79FF69) {
        if(struct.group_name == group_name) {
          if(getdvarint("dvar_8DFD6BDD237FF1AB", 0))
            announcement(_id_F564CE57BB79FF69.group_name + " ^3Unpaused");

          struct scripts\cp\cp_spawning_util::run_module_unpause_funcs();
          struct scripts\engine\utility::ent_flag_clear("pause_group");
        }
      }

      continue;
    }

    if(_id_F564CE57BB79FF69.group_name == group_name) {
      if(getdvarint("dvar_8DFD6BDD237FF1AB", 0))
        announcement(_id_F564CE57BB79FF69.group_name + " ^3Unpaused");

      _id_F564CE57BB79FF69 scripts\cp\cp_spawning_util::run_module_unpause_funcs();
      _id_F564CE57BB79FF69 scripts\engine\utility::ent_flag_clear("pause_group");
    }
  }
}

stop_all_groups() {
  keys = getarraykeys(level.active_spawn_module_structs);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++)
    stop_module_by_groupname(keys[_id_AC0E594AC96AA3A8]);
}

stop_module_by_id(id) {
  level notify("end_spawn_module_" + id);
}

stop_module_by_groupname(group_name, _id_876D0014B1536200) {
  if(isDefined(level.active_spawn_module_structs[group_name])) {
    _id_F564CE57BB79FF69 = level.active_spawn_module_structs[group_name];

    if(isarray(_id_F564CE57BB79FF69)) {
      foreach(struct in _id_F564CE57BB79FF69) {
        if(istrue(_id_876D0014B1536200)) {
          level notify("spawn_module_" + struct.moduleid + "_completed");
          continue;
        }

        struct notify("death");
      }
    } else if(istrue(_id_876D0014B1536200))
      level notify("spawn_module_" + _id_F564CE57BB79FF69.moduleid + "_completed");
    else
      _id_F564CE57BB79FF69 notify("death");
  }
}

process_module_var(group, _id_06B5C8034010B9BA, _id_4E62F8D216C2816B, _id_A9C4D551B42AF0FB) {
  level endon("game_ended");
  group endon("death");
  self endon("var_param_race_timeout");

  if(!isDefined(_id_06B5C8034010B9BA))
    return "empty";

  _id_43E4442D6EA9B20D = _id_06B5C8034010B9BA;

  if(isstring(_id_06B5C8034010B9BA))
    return _id_06B5C8034010B9BA;
  else if(isnumberandgreaterthanzero(_id_06B5C8034010B9BA))
    return _id_06B5C8034010B9BA;
  else if(isarray(_id_06B5C8034010B9BA)) {
    if(isarray(_id_06B5C8034010B9BA[0])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_06B5C8034010B9BA.size; _id_AC0E594AC96AA3A8++)
        _id_43E4442D6EA9B20D = process_module_var(group, _id_06B5C8034010B9BA[_id_AC0E594AC96AA3A8], _id_4E62F8D216C2816B);
    } else if(isfunction(_id_06B5C8034010B9BA[0])) {
      func = _id_06B5C8034010B9BA[0];
      var_params = [];
      _id_8A69877EF3D6E5CA = process_module_params(group, _id_06B5C8034010B9BA);
      _id_43E4442D6EA9B20D = group run_modular_spawning_func(func, _id_8A69877EF3D6E5CA, _id_A9C4D551B42AF0FB);
    } else
      _id_43E4442D6EA9B20D = _id_06B5C8034010B9BA;
  } else if(isfunction(_id_06B5C8034010B9BA)) {
    if(istrue(_id_4E62F8D216C2816B))
      return _id_06B5C8034010B9BA;
    else
      _id_43E4442D6EA9B20D = [[_id_06B5C8034010B9BA]](group);
  }

  return _id_43E4442D6EA9B20D;
}

process_module_params(group, _id_06B5C8034010B9BA) {
  var_params = [];

  if(_id_06B5C8034010B9BA.size < 2)
    return var_params;
  else {
    _id_8A69877EF3D6E5CA = spawnStruct();
    _id_8A69877EF3D6E5CA.var_params = [];
    _id_BAE8297148C7F7E8 = min(_id_06B5C8034010B9BA.size, 9);

    for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < _id_BAE8297148C7F7E8; _id_AC0E594AC96AA3A8++) {
      _id_5B6F016C0007CA2C = _id_06B5C8034010B9BA[_id_AC0E594AC96AA3A8];
      _id_8A69877EF3D6E5CA thread send_notify_after_frame_end("var_param_race_timeout");
      _id_8A69877EF3D6E5CA.var_params[_id_AC0E594AC96AA3A8 - 1] = _id_8A69877EF3D6E5CA process_module_var(group, _id_5B6F016C0007CA2C, 1);
    }
  }

  return _id_8A69877EF3D6E5CA;
}

send_notify_after_frame_end(_id_7239F8830EF22B43) {
  self endon("death");
  waittillframeend;
  self notify(_id_7239F8830EF22B43);
}

run_modular_spawning_func(func, params, _id_A9C4D551B42AF0FB) {
  if(isDefined(_id_A9C4D551B42AF0FB))
    _id_84DAE085357E37AD = _id_A9C4D551B42AF0FB;
  else
    _id_84DAE085357E37AD = self;

  if(!isDefined(params.var_params))
    return _id_84DAE085357E37AD[[func]](self);
  else if(params.var_params.size == 1)
    return _id_84DAE085357E37AD[[func]](self, return_undefined_param_if_empty(params.var_params[0]));
  else if(params.var_params.size == 2)
    return _id_84DAE085357E37AD[[func]](self, return_undefined_param_if_empty(params.var_params[0]), return_undefined_param_if_empty(params.var_params[1]));
  else if(params.var_params.size == 3)
    return _id_84DAE085357E37AD[[func]](self, return_undefined_param_if_empty(params.var_params[0]), return_undefined_param_if_empty(params.var_params[1]), return_undefined_param_if_empty(params.var_params[2]));
  else if(params.var_params.size == 4)
    return _id_84DAE085357E37AD[[func]](self, return_undefined_param_if_empty(params.var_params[0]), return_undefined_param_if_empty(params.var_params[1]), return_undefined_param_if_empty(params.var_params[2]), return_undefined_param_if_empty(params.var_params[3]));
  else if(params.var_params.size == 5)
    return _id_84DAE085357E37AD[[func]](self, return_undefined_param_if_empty(params.var_params[0]), return_undefined_param_if_empty(params.var_params[1]), return_undefined_param_if_empty(params.var_params[2]), return_undefined_param_if_empty(params.var_params[3]), return_undefined_param_if_empty(params.var_params[4]));
  else if(params.var_params.size == 6)
    return _id_84DAE085357E37AD[[func]](self, return_undefined_param_if_empty(params.var_params[0]), return_undefined_param_if_empty(params.var_params[1]), return_undefined_param_if_empty(params.var_params[2]), return_undefined_param_if_empty(params.var_params[3]), return_undefined_param_if_empty(params.var_params[4]), return_undefined_param_if_empty(params.var_params[5]));
  else if(params.var_params.size == 7)
    return _id_84DAE085357E37AD[[func]](self, return_undefined_param_if_empty(params.var_params[0]), return_undefined_param_if_empty(params.var_params[1]), return_undefined_param_if_empty(params.var_params[2]), return_undefined_param_if_empty(params.var_params[3]), return_undefined_param_if_empty(params.var_params[4]), return_undefined_param_if_empty(params.var_params[5]), return_undefined_param_if_empty(params.var_params[6]));
  else if(params.var_params.size == 8)
    return _id_84DAE085357E37AD[[func]](self, return_undefined_param_if_empty(params.var_params[0]), return_undefined_param_if_empty(params.var_params[1]), return_undefined_param_if_empty(params.var_params[2]), return_undefined_param_if_empty(params.var_params[3]), return_undefined_param_if_empty(params.var_params[4]), return_undefined_param_if_empty(params.var_params[5]), return_undefined_param_if_empty(params.var_params[6]), return_undefined_param_if_empty(params.var_params[7]));
  else
    return undefined;
}

return_undefined_param_if_empty(_id_06B5C8034010B9BA) {
  if(isDefined(_id_06B5C8034010B9BA)) {
    if(isstring(_id_06B5C8034010B9BA) && _id_06B5C8034010B9BA == "empty")
      return undefined;
    else
      return _id_06B5C8034010B9BA;
  } else
    return undefined;
}

resetgroupvariables() {
  level endon("game_ended");
  self waittill("death");
  self.currentmodulekills = 0;
  level.requested_spawns_groups[self.moduleid] = undefined;
}

spawn_ai(_id_4FA96EB6FF30FD3F, _id_00DB52FA830038A9, _id_2B3FE0E3FB0CD248, _id_F8E5E3AA5762A8E7) {
  change_module_status(_id_F8E5E3AA5762A8E7, "attempt spawn_ai");
  spawnpos = self.origin;
  spawnangles = self.angles;

  if(isDefined(_id_4FA96EB6FF30FD3F))
    spawnpos = _id_4FA96EB6FF30FD3F;

  if(isDefined(_id_00DB52FA830038A9))
    spawnangles = (0, _id_00DB52FA830038A9[1], 0);

  aitype = undefined;
  agent_type = undefined;

  if(isDefined(_id_F8E5E3AA5762A8E7) && isDefined(_id_F8E5E3AA5762A8E7.spawn_aitype_counts) && _id_F8E5E3AA5762A8E7.spawn_aitype_counts.size > 0) {
    aitype = _id_F8E5E3AA5762A8E7 choose_and_decrement_from_aitype_list();
    agent_type = level.aitypes[aitype].agent_type;
  } else if(isDefined(_id_F8E5E3AA5762A8E7) && isDefined(_id_F8E5E3AA5762A8E7.aitype_override) && _id_F8E5E3AA5762A8E7.aitype_override.size && !isDefined(self.vehicle)) {
    _id_1BBE1E86BF2144D6 = weighted_array_randomize(_id_F8E5E3AA5762A8E7.aitype_override, _id_F8E5E3AA5762A8E7.aitype_override_weights);
    agent_type = level.aitypes[_id_1BBE1E86BF2144D6].agent_type;
    aitype = _id_1BBE1E86BF2144D6;
  } else if(isDefined(level.aitype_override) && level.aitype_override.size && !isDefined(self.vehicle)) {
    _id_1BBE1E86BF2144D6 = weighted_array_randomize(level.aitype_override, level.aitype_override_weights);
    agent_type = level.aitypes[_id_1BBE1E86BF2144D6].agent_type;
    aitype = _id_1BBE1E86BF2144D6;
  } else if(isDefined(_id_2B3FE0E3FB0CD248)) {
    agent_type = level.aitypes[_id_2B3FE0E3FB0CD248].agent_type;
    aitype = _id_2B3FE0E3FB0CD248;
  } else {
    _id_C68454D783B47EF5 = get_aitypes_from_spawner();
    _id_1BBE1E86BF2144D6 = scripts\engine\utility::random(_id_C68454D783B47EF5);
    agent_type = level.aitypes[_id_1BBE1E86BF2144D6].agent_type;
    aitype = _id_1BBE1E86BF2144D6;
  }

  if(isDefined(level.forced_aitypes)) {
    _id_1BBE1E86BF2144D6 = scripts\engine\utility::random(level.forced_aitypes);

    if(isDefined(level.aitypes[_id_1BBE1E86BF2144D6]) && isDefined(level.aitypes[_id_1BBE1E86BF2144D6].agent_type)) {
      agent_type = level.aitypes[_id_1BBE1E86BF2144D6].agent_type;
      aitype = _id_1BBE1E86BF2144D6;
    }
  }

  equip_armor = undefined;

  if(istrue(level.forced_aitype_armored) || is_armored()) {
    if(isDefined(level.aitypes[aitype + "_heavy"]) && isDefined(level.aitypes[aitype + "_heavy"].agent_type)) {
      agent_type = level.aitypes[aitype + "_heavy"].agent_type;
      aitype = aitype + "_heavy";
      equip_armor = 1;
    }
  }

  if(!isDefined(agent_type)) {
    _id_1BBE1E86BF2144D6 = scripts\engine\utility::random(level.random_aitype_list);
    agent_type = level.aitypes[_id_1BBE1E86BF2144D6].agent_type;
    aitype = _id_1BBE1E86BF2144D6;
  }

  _id_0C5CC779680CE70C = agent_type;
  thread _id_FAD3572108152BAF(self, _id_F8E5E3AA5762A8E7, _id_0C5CC779680CE70C);
  change_module_status(_id_F8E5E3AA5762A8E7, "Chose agent_type");
  change_module_status(_id_F8E5E3AA5762A8E7, "In Spawn Queue");
  enter_spawn_queue();
  self.aitype = aitype;
  self.agent_type = agent_type;

  if(isDefined(_id_F8E5E3AA5762A8E7) && istrue(_id_F8E5E3AA5762A8E7.min_spawn_requested)) {
    soldier = undefined;
    change_module_status(_id_F8E5E3AA5762A8E7, "Force Spawn Loop");

    for(;;) {
      soldier = scripts\mp\mp_agent::spawnnewagentaitype(_id_0C5CC779680CE70C, spawnpos, spawnangles);

      if(isDefined(soldier)) {
        break;
      }

      waitframe();
    }

    _id_F8E5E3AA5762A8E7.min_spawn_requested = undefined;

    if(get_reserved_slot_count_by_string_id(_id_F8E5E3AA5762A8E7.moduleid) > 0)
      decrease_reserved_spawn_slots(1, _id_F8E5E3AA5762A8E7.moduleid);
  } else {
    change_module_status(_id_F8E5E3AA5762A8E7, "Spawn Attempt");
    soldier = scripts\mp\mp_agent::spawnnewagentaitype(_id_0C5CC779680CE70C, spawnpos, spawnangles);
  }

  if(isDefined(soldier) && istrue(equip_armor))
    soldier.equip_armor = 1;

  if(isDefined(soldier))
    soldier setthreatbiasgroup("axis");

  return soldier;
}

_id_FAD3572108152BAF(spawnpoint, _id_F8E5E3AA5762A8E7, _id_E75102F384565FCF) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender", "aitype_type_validation"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("defender", "aitype_type_validation")]](spawnpoint, _id_F8E5E3AA5762A8E7, _id_E75102F384565FCF);
}

get_aitypes_from_spawner() {
  _id_6D906809844C7CB1 = [];

  if(!isDefined(self._id_BD8883D612FBB662) && !isDefined(self._id_87B421D7E94C6265) && !isDefined(self.script_noteworthy))
    return level.random_aitype_list;
  else {
    if(isDefined(self._id_BD8883D612FBB662))
      _id_F077ADF688122C36 = strtok(self._id_BD8883D612FBB662, " ");
    else if(isDefined(self._id_87B421D7E94C6265))
      _id_F077ADF688122C36 = [self._id_87B421D7E94C6265];
    else
      _id_F077ADF688122C36 = strtok(self.script_noteworthy, " ");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F077ADF688122C36.size; _id_AC0E594AC96AA3A8++) {
      _id_E97377032A878881 = _id_F077ADF688122C36[_id_AC0E594AC96AA3A8];

      if(isDefined(level.aitypes[_id_E97377032A878881]))
        _id_6D906809844C7CB1[_id_6D906809844C7CB1.size] = _id_E97377032A878881;
    }

    if(_id_6D906809844C7CB1.size > 0)
      return _id_6D906809844C7CB1;
    else
      return level.random_aitype_list;
  }
}

choose_and_decrement_from_aitype_list() {
  keys = getarraykeys(self.spawn_aitype_counts);

  foreach(key in keys) {
    if(isDefined(self.spawn_aitype_counts[key]) && isint(self.spawn_aitype_counts[key]) && self.spawn_aitype_counts[key] >= 1) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.spawn_module_structs_memory[self.group_name].size; _id_AC0E594AC96AA3A8++) {
        _id_EDED3A3BD26715B6 = level.spawn_module_structs_memory[self.group_name][_id_AC0E594AC96AA3A8];

        if(isDefined(_id_EDED3A3BD26715B6.spawn_aitype_counts[key])) {
          _id_EDED3A3BD26715B6.spawn_aitype_counts[key]--;

          if(_id_EDED3A3BD26715B6.spawn_aitype_counts[key] <= 0)
            _id_EDED3A3BD26715B6.spawn_aitype_counts[key] = undefined;
        }
      }

      agent_type = level.aitypes[key].agent_type;
      aitype = key;
      return aitype;
    }
  }

  return undefined;
}

weighted_array_randomize(array, weights) {
  _id_13ACBD53528ED1FF = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < weights.size; _id_AC0E594AC96AA3A8++)
    _id_13ACBD53528ED1FF = _id_13ACBD53528ED1FF + weights[_id_AC0E594AC96AA3A8];

  random_weight = randomfloat(_id_13ACBD53528ED1FF);
  _id_98ABCC65D2B0707D = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    _id_98ABCC65D2B0707D = _id_98ABCC65D2B0707D + weights[_id_AC0E594AC96AA3A8];

    if(_id_98ABCC65D2B0707D >= random_weight)
      return array[_id_AC0E594AC96AA3A8];
  }
}

enter_spawn_queue() {
  level endon("game_ended");
  level.spawn_queue++;

  if(level.spawn_queue > 1)
    wait(level.spawn_queue * 0.05);

  level.spawn_queue--;
}

start_patrol() {
  self endon("death");
  self notify("start_patrol");
  self endon("start_patrol");
  self endon("enter_combat");
  level endon("game_ended");

  if(isDefined(self.script_linkto))
    thread go_to_node(get_next_node_array());
  else if(isDefined(self.spawnpoint.target) || isDefined(self.spawnpoint.script_linkto) && !is_door_spawn())
    thread go_to_node(self.spawnpoint get_next_node_array());
  else if(should_roam())
    thread patrol_using_cover_nodes();
}

patrol_using_cover_nodes() {
  self endon("enter_combat");
  self endon("death");

  if(!isDefined(self.dot_override))
    self.dot_override = 0;

  if(self.goalradius < 256)
    _id_753C2F938646E38C = 1024;
  else
    _id_753C2F938646E38C = self.goalradius;

  set_goal_radius(64);
  _id_E80F66E023B2AEA2 = 64;
  _id_20520E06DC84DF35 = 256;
  _id_0EF4E4D85E21B4FA = undefined;
  _id_6CECE043C9264CE2 = undefined;

  if(isDefined(self.script_goalheight))
    _id_20520E06DC84DF35 = int(self.script_goalheight);

  for(;;) {
    if(isDefined(self.script_origin_other))
      _id_ED2CCFCF6DA01F9C = self.script_origin_other;
    else
      _id_ED2CCFCF6DA01F9C = self.origin;

    if(istrue(self.find_new_patrol)) {
      wait 0.25;
      continue;
    }

    _id_E627E357CF133EAB = -1;
    _id_6CECE043C9264CE2 = undefined;
    next_node = undefined;
    _id_97DB970A57D9F896 = getnodesinradiussorted(_id_ED2CCFCF6DA01F9C, _id_753C2F938646E38C, _id_E80F66E023B2AEA2, _id_20520E06DC84DF35, "all");
    _id_132D1035A2F11A50 = [];

    if(isDefined(_id_97DB970A57D9F896) && _id_97DB970A57D9F896.size > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_97DB970A57D9F896.size; _id_AC0E594AC96AA3A8++) {
        if(isDefined(_id_0EF4E4D85E21B4FA) && _id_97DB970A57D9F896[_id_AC0E594AC96AA3A8] == _id_0EF4E4D85E21B4FA) {
          continue;
        }
        if(isDefined(getnodeowner(_id_97DB970A57D9F896[_id_AC0E594AC96AA3A8]))) {
          continue;
        }
        if(isDefined(self.dot_override))
          _id_157B4CCA8E1ADB67 = self.angles + (0, self.dot_override, 0);
        else
          _id_157B4CCA8E1ADB67 = self.angles;

        dot = scripts\engine\math::get_dot(self.origin, _id_157B4CCA8E1ADB67, _id_97DB970A57D9F896[_id_AC0E594AC96AA3A8].origin);

        if(dot < 0.3) {
          if(dot > _id_E627E357CF133EAB) {
            _id_6CECE043C9264CE2 = _id_97DB970A57D9F896[_id_AC0E594AC96AA3A8];
            _id_E627E357CF133EAB = dot;
          }

          continue;
        }

        _id_132D1035A2F11A50[_id_132D1035A2F11A50.size] = _id_97DB970A57D9F896[_id_AC0E594AC96AA3A8];
      }
    }

    if(_id_132D1035A2F11A50.size > 0)
      next_node = get_least_used_from_array(_id_132D1035A2F11A50);

    time = gettime();

    if(isDefined(next_node)) {
      self.dot_override = undefined;
      _id_0EF4E4D85E21B4FA = next_node;
      go_to_node(next_node);
      _id_047085F3BF583F9F = gettime();

      if(_id_047085F3BF583F9F <= time)
        waitframe();

      continue;
    }

    if(isDefined(_id_6CECE043C9264CE2)) {
      self.dot_override = undefined;
      _id_0EF4E4D85E21B4FA = _id_6CECE043C9264CE2;
      go_to_node(_id_6CECE043C9264CE2);
      _id_047085F3BF583F9F = gettime();

      if(_id_047085F3BF583F9F <= time)
        waitframe();

      continue;
    }

    wait 1;
  }
}

enter_combat_after_stealth(group) {
  if(scripts\cp\coop_stealth::should_run_sp_stealth()) {
    return;
  }
  self notify("enter_combat_after_stealth");
  self endon("enter_combat_after_stealth");
  self endon("death");
  self endon("enter_combat");
  _id_50386379DA7B12C9 = [];
  _id_EB3648C64314177E = [];
  result = undefined;

  if(isDefined(self.team)) {
    if(isDefined(self.group) && self.group scripts\engine\utility::ent_flag_exist("weapons_free") && !self.group scripts\engine\utility::ent_flag("weapons_free")) {
      if(self.team == "allies") {
        _id_EB3648C64314177E = [self, level];
        scripts\engine\utility::waittill_any_ents_array(_id_EB3648C64314177E, "damage", "stealth_combat", "stealth_over", "weapons_free", "bulletwhizby");
      } else if(istrue(self.aggressive))
        return;
      else if(is_pacifist()) {
        _id_EB3648C64314177E = [self, self.group, level];
        scripts\engine\utility::waittill_any_ents_array(_id_EB3648C64314177E, "weapons_free", "saw_death");
      } else {
        _id_EB3648C64314177E = [self, self.group, level];
        result = scripts\engine\utility::waittill_any_ents_return(level, "weapons_free", self.group, "weapons_free", self, "saw_death", self, "known_event");
      }
    }
  }

  if(isDefined(level.enter_combat_flag) && !scripts\engine\utility::flag(level.enter_combat_flag))
    scripts\engine\utility::flag_set(level.enter_combat_flag);

  thread enter_combat();
}

_id_EC648F2C89EA1C91() {
  self.lastspawntime = gettime();
}

_id_242733BD4DBB1979(spawnpoint) {
  if(isDefined(spawnpoint._id_9FF99CFC426066A2))
    set_goal_radius(spawnpoint._id_9FF99CFC426066A2);
  else if(isDefined(spawnpoint.script_radius))
    set_goal_radius(spawnpoint.script_radius);
  else if(isDefined(self._id_9FF99CFC426066A2))
    set_goal_radius(self._id_9FF99CFC426066A2);
  else if(isDefined(self.script_radius))
    set_goal_radius(self.script_radius);
  else
    set_goal_radius(2048);

  self.og_goalradius = self.goalradius;
}

_id_78225857C662EBB4(spawnpoint) {
  if(isDefined(self.spawnpoint.script_goalheight))
    self.goalheight = self.spawnpoint.script_goalheight;
  else if(isDefined(self.script_goalheight))
    self.goalheight = self.script_goalheight;
  else
    self.goalheight = 80;

  self.og_goalheight = self.goalheight;
}

_id_0A3C8440BB465635(spawnpoint) {
  if(getdvarint("dvar_E297FED388DA8211", 0) > 0 || !isDefined(spawnpoint)) {
    return;
  }
  switch (spawnpoint.aitype) {
    case "ar":
      self setengagementmindist(256, 0);
      self setengagementmaxdist(768, 2048);
      self _meth_9215CE6FC83759B9(2048);
      break;
    case "smg":
      self setengagementmindist(256, 0);
      self setengagementmaxdist(768, 1024);
      self _meth_9215CE6FC83759B9(2048);
      break;
    case "shotgun":
      self setengagementmindist(256, 0);
      self setengagementmaxdist(768, 1024);
      self _meth_9215CE6FC83759B9(1024);
      break;
    case "sniper":
      self setengagementmindist(512, 0);
      self setengagementmaxdist(768, 4096);
      self _meth_9215CE6FC83759B9(4096);
      break;
    case "lmg":
      self setengagementmindist(256, 0);
      self setengagementmaxdist(768, 3000);
      self _meth_9215CE6FC83759B9(3000);
      break;
    case "juggernaut":
      break;
    default:
      break;
  }
}

_id_2CAE33F77B1F866C(spawnpoint) {
  self.spawnpoint = spawnpoint;
}

_id_C2C72BA14CDF8889() {
  if(istrue(self.equip_helmet) || is_juggernaut_aitype())
    give_soldier_helmet();

  if(is_armored() || is_juggernaut_aitype()) {
    give_soldier_armor();

    if(!isDefined(self._id_B5218CF00DAD94EF) && !is_juggernaut_aitype()) {
      self.allowpain = 0;
      self._id_B5218CF00DAD94EF = 420;
    }
  }
}

give_soldier_helmet() {
  if(!issubstr(self.agent_type, "_helmet") && !is_juggernaut_aitype()) {}

  self.wearing_helmet = 1;
}

give_soldier_armor() {
  if(!issubstr(self.agent_type, "_armor") && !is_juggernaut_aitype()) {}

  self.wearing_armor = 1;
  self._id_B5218CF00DAD94EF = 150;
}

_id_9426D24DFB73528D(_id_580837BA9DE8F3D4) {
  if(isDefined(self.aitype) && issubstr(self.aitype, "bomber")) {
    return;
  }
  _id_F0FFAFCA5D927A12 = self.weapon;

  if(!isDefined(_id_F0FFAFCA5D927A12)) {
    return;
  }
  agent = self;
  _id_631EB7A15A695766 = ["iw9_lm_foxtrot_mp", "iw9_ar_mike16_mp", "iw9_ar_mike4_mp"];
  _id_EFFB4AE1788A8B10 = "";

  if(scripts\engine\utility::array_contains(_id_631EB7A15A695766, _id_F0FFAFCA5D927A12.basename))
    _id_EFFB4AE1788A8B10 = "laserbox_hip01_p01";
  else {
    switch (_id_F0FFAFCA5D927A12.classname) {
      case "sniper":
      case "rifle":
        _id_EFFB4AE1788A8B10 = "laserbox_hip01";
        break;
      case "mg":
        _id_EFFB4AE1788A8B10 = "laserbox_hip01";
        break;
      case "pistol":
        _id_EFFB4AE1788A8B10 = "laserpstl_hip01";
        break;
      case "smg":
        _id_EFFB4AE1788A8B10 = "laserbox_hip01";
        break;
      case "spread":
        _id_EFFB4AE1788A8B10 = "lasercyl_hip01";
        break;
      default:
        break;
    }
  }

  if(isDefined(_id_580837BA9DE8F3D4))
    _id_EFFB4AE1788A8B10 = _id_580837BA9DE8F3D4;

  if(!isDefined(_id_EFFB4AE1788A8B10) || _id_EFFB4AE1788A8B10 == "") {
    return;
  }
  _id_DD515FCF025B2E79 = _id_F0FFAFCA5D927A12 withattachment(_id_EFFB4AE1788A8B10);

  if(isDefined(self.weapon))
    self takeweapon(self.weapon);

  self.weapon = _id_DD515FCF025B2E79;
  scripts\common\utility::initweapon(self.weapon);
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
}

_id_B8177F07A65AA246() {
  if(isDefined(level.global_ai_func_array) && level.global_ai_func_array.size > 0) {
    if(isDefined(self.team) && self.team == "axis") {
      team = self.team;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.global_ai_func_array[team].size; _id_AC0E594AC96AA3A8++) {
        func = level.global_ai_func_array[team][_id_AC0E594AC96AA3A8];

        if(isDefined(func["param4"])) {
          self thread[[func["function"]]](func["param1"], func["param2"], func["param3"], func["param4"]);
          continue;
        }

        if(isDefined(func["param3"])) {
          self thread[[func["function"]]](func["param1"], func["param2"], func["param3"]);
          continue;
        }

        if(isDefined(func["param2"])) {
          self thread[[func["function"]]](func["param1"], func["param2"]);
          continue;
        }

        if(isDefined(func["param1"])) {
          self thread[[func["function"]]](func["param1"]);
          continue;
        }

        self thread[[func["function"]]]();
      }
    }
  }
}

_id_389FFF85C076F49E() {
  if(istrue(self._id_45E0128A2FF05F04)) {
    return;
  }
  if(isDefined(level._id_317452953C148027))
    self[[level._id_317452953C148027]]();

  _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_armor_plate");
  _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_powerup_equipment");
  _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("cash_drop_100");

  if(getdvarint("dvar_E2EB41C1190B2FC2", 0))
    _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_powerup_ammo");
  else if(getdvarint("dvar_DF9BF139FD731025", 0)) {
    if(isDefined(self.aitype)) {
      if(issubstr(self.aitype, "smg"))
        _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_ammo_919");
      else if(issubstr(self.aitype, "ar"))
        _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_ammo_762");
      else if(issubstr(self.aitype, "sniper"))
        _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_ammo_50cal");
      else if(issubstr(self.aitype, "juggernaut"))
        _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_ammo_762");
      else if(issubstr(self.aitype, "shotgun"))
        _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_ammo_12g");
      else if(issubstr(self.aitype, "lmg"))
        _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_ammo_762");
      else if(issubstr(self.aitype, "rpg"))
        _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("brloot_ammo_rocket");
    }
  } else
    _id_703FDBB02501D31E::_id_6FDBF71C8217CFC5("drop_random_ammo_types");
}

_id_8029849997321123() {
  _id_5F612DA1F12CC6E5(1);

  if(!isDefined(self.sidearm))
    self.sidearm = nullweapon();

  scripts\common\utility::initweapon(self.primaryweapon);
  scripts\common\utility::initweapon(self.sidearm);
  _id_7F6BFE0BF3CF84E8 = "primary";

  if(_id_A1A803521137F145())
    _id_7F6BFE0BF3CF84E8 = "right";

  if(!is_specified_unittype("civilian")) {
    _id_3433EE6B63C7E243::placeweaponon(self.primaryweapon, _id_7F6BFE0BF3CF84E8);
    _id_3433EE6B63C7E243::placeweaponon(self.sidearm, "sidearm");
    scripts\common\utility::set_battlechatter(1);
  }
}

_id_A1A803521137F145() {
  if(getdvarint("dvar_74C4EB895FCCEF41", 0) == 0)
    return 0;

  if(!isDefined(level._id_4A2590C2DFE94983) && !isDefined(level._id_360370415A0CE15F) && !isDefined(level._id_F121B39847BCA5E8) && !isDefined(level._id_F0525567BC0FFA6A))
    return 0;

  if(!isDefined(self.agent_type))
    return 0;

  attachments = undefined;

  if(isDefined(level._id_121443DFD453E6A3)) {
    if(scripts\engine\utility::_id_51D76700600CEBE3(30)) {
      attachments = [];
      _id_64D3FAD2BCB789D2 = scripts\engine\utility::create_deck(level._id_121443DFD453E6A3, 1, 1);
      attachments[attachments.size] = _id_64D3FAD2BCB789D2 scripts\engine\utility::deck_draw();
      attachments[attachments.size] = _id_64D3FAD2BCB789D2 scripts\engine\utility::deck_draw();
    }
  }

  if(issubstr(self.agent_type, "_ar")) {
    if(isDefined(self.weapon))
      self takeallweapons();

    _id_72672CD81EC1093D = scripts\engine\utility::random(level._id_360370415A0CE15F);
    _id_ED540658678514F1 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4(_id_72672CD81EC1093D);
    _id_ED540658678514F1 = _id_ED540658678514F1 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(attachments);
    self.weapon = _id_ED540658678514F1;
    scripts\common\utility::initweapon(self.weapon);
    self giveweapon(self.weapon);
    self setspawnweapon(self.weapon);
    self.primaryweapon = self.weapon;
    return 1;
  }

  if(issubstr(self.agent_type, "_smg")) {
    if(isDefined(self.weapon))
      self takeallweapons();

    _id_72672CD81EC1093D = scripts\engine\utility::random(level._id_4A2590C2DFE94983);
    _id_ED540658678514F1 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4(_id_72672CD81EC1093D);
    _id_ED540658678514F1 = _id_ED540658678514F1 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(attachments);
    self.weapon = _id_ED540658678514F1;
    scripts\common\utility::initweapon(self.weapon);
    self giveweapon(self.weapon);
    self setspawnweapon(_id_ED540658678514F1);
    self.primaryweapon = _id_ED540658678514F1;
    return 1;
  }

  if(issubstr(self.agent_type, "_shotgun")) {
    if(isDefined(self.weapon))
      self takeallweapons();

    _id_72672CD81EC1093D = scripts\engine\utility::random(level._id_F0525567BC0FFA6A);
    _id_ED540658678514F1 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4(_id_72672CD81EC1093D);
    _id_ED540658678514F1 = _id_ED540658678514F1 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(attachments);
    self.weapon = _id_ED540658678514F1;
    scripts\common\utility::initweapon(self.weapon);
    self giveweapon(self.weapon);
    self setspawnweapon(_id_ED540658678514F1);
    self.primaryweapon = _id_ED540658678514F1;
    return 1;
  }

  if(issubstr(self.agent_type, "_lmg")) {
    if(isDefined(self.weapon))
      self takeallweapons();

    _id_72672CD81EC1093D = scripts\engine\utility::random(level._id_F121B39847BCA5E8);
    _id_ED540658678514F1 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4(_id_72672CD81EC1093D);
    _id_ED540658678514F1 = _id_ED540658678514F1 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(attachments);
    self.weapon = _id_ED540658678514F1;
    scripts\common\utility::initweapon(self.weapon);
    self giveweapon(self.weapon);
    self setspawnweapon(_id_ED540658678514F1);
    self.primaryweapon = _id_ED540658678514F1;
    return 1;
  }

  return 0;
}

_id_5F612DA1F12CC6E5(_id_25F0D68EE22434EB) {
  if(!getdvarint("dvar_26524832A07CF602", 1)) {
    self.dropweapon = 0;
    return;
  }

  if(!isDefined(_id_25F0D68EE22434EB))
    _id_25F0D68EE22434EB = 0;

  self.dropweapon = _id_25F0D68EE22434EB;
  self._id_98ADD129A7ECB962 = 0;
}

set_kill_off_time(override) {
  if(istrue(level._id_F57B5DB263860330)) {
    return;
  }
  if(isDefined(override))
    _id_BBC66AD67526DB08 = override * 1000;
  else if(isDefined(self.group) && isDefined(self.group.kill_off_time_override))
    _id_BBC66AD67526DB08 = self.group.kill_off_time_override * 1000;
  else if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.script_timer))
    _id_BBC66AD67526DB08 = self.spawnpoint.script_timer * 1000;
  else if(isDefined(self.group) && istrue(self.group.cqb_module))
    _id_BBC66AD67526DB08 = 2500000;
  else
    _id_BBC66AD67526DB08 = 20000;

  _id_047085F3BF583F9F = gettime() + _id_BBC66AD67526DB08;

  if(!isDefined(self.killofftime) || _id_047085F3BF583F9F > self.killofftime)
    self.killofftime = _id_047085F3BF583F9F;

  if(istrue(self.entered_combat)) {
    wait_time = _id_BBC66AD67526DB08 / 1000;
    thread add_to_kill_off_list(wait_time);
  } else
    remove_from_kill_off_list();
}

add_to_kill_off_list(wait_time) {
  self notify("add_to_kill_off_list");
  self endon("add_to_kill_off_list");
  self endon("death");
  remove_from_kill_off_list();
  wait(wait_time);

  if(isDefined(self.entity_number))
    level.can_kill_off_list[self.entity_number] = self;
  else
    level.can_kill_off_list[self getentitynumber()] = self;

  if(level.can_kill_off_list.size == 1)
    level thread passive_kill_off_loop();
}

passive_kill_off_loop() {
  level notify("stop_kill_off_loop");
  level endon("stop_kill_off_loop");
  level endon("game_ended");
  _id_6582DC596556CF2E = level.frameduration / 1000;

  for(;;) {
    waittime = 1;
    keys = getarraykeys(level.can_kill_off_list);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(level.can_kill_off_list[keys[_id_AC0E594AC96AA3A8]])) {
        continue;
      }
      _id_7EDBB385819F8E7F = level.can_kill_off_list[keys[_id_AC0E594AC96AA3A8]] thread passive_kill_off_ai();

      if(!isDefined(_id_7EDBB385819F8E7F) || _id_7EDBB385819F8E7F) {
        if(waittime > _id_6582DC596556CF2E)
          waittime = waittime - _id_6582DC596556CF2E;

        waitframe();
      }
    }

    wait(waittime);
  }
}

passive_kill_off_ai(_id_21B3206D7AFB1536) {
  if(!isalive(self))
    return 0;

  if(self.health < 1)
    return 0;

  if(has_dont_kill_off_flag())
    return 0;

  if(istrue(scripts\engine\utility::script_func("ai_is_carrying_hvt", self)))
    return 0;

  if(istrue(self.attempting_teleport))
    return 0;

  if(istrue(self.playing_skit))
    return 0;

  if(is_specified_unittype("juggernaut"))
    return 0;

  if(istrue(self.is_kidnapping_player)) {
    set_kill_off_time(20);
    return 0;
  }

  if(!istrue(self.forced_kill_off)) {
    if(is_riding_vehicle())
      return 0;

    if(isDefined(self.enemy) && self canshootenemy())
      return 0;
  }

  if(isDefined(self.birthtime) && self.birthtime >= gettime())
    return 0;

  _id_934F2BD9F0E5C04B = get_see_recently_time_overrides();

  if(isDefined(self.group) && istrue(self.group.cqb_module))
    _id_99189C9718781C5D = 2250000;
  else
    _id_99189C9718781C5D = 25000000;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    _id_678A0776298909D1 = level.players[_id_AC0E594AC96AA3A8];

    if(distancesquared(_id_678A0776298909D1.origin, self.origin) < _id_99189C9718781C5D)
      return 0;

    if(self seerecently(_id_678A0776298909D1, _id_934F2BD9F0E5C04B))
      return 0;
  }

  if(!killoff_vis_passed()) {
    if(!istrue(_id_21B3206D7AFB1536))
      return 1;
  }

  teleport_to_nearby_spawner("Passive Kill-Off", undefined, 0);
  return 1;
}

killoff_vis_passed() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    _id_678A0776298909D1 = level.players[_id_AC0E594AC96AA3A8];

    if(self hastacvis(_id_678A0776298909D1, 0, 64, 1))
      return 0;

    if(_id_678A0776298909D1 hastacvis(self, 0, 64, 1))
      return 0;
  }

  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1);
  _id_EB66EBED687542E2 = self getapproxeyepos();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(scripts\engine\trace::ray_trace_passed(player getEye(), _id_EB66EBED687542E2, [player, self], contents))
      return 0;
  }

  return 1;
}

is_riding_vehicle() {
  return isDefined(self.ridingvehicle);
}

_id_5BB77ADDD9F02498(team) {
  return isDefined(self.team) && self.team == team;
}

is_specified_unittype(unittype) {
  return isDefined(self.unittype) && self.unittype == unittype;
}

is_juggernaut_aitype() {
  return isDefined(self.unittype) && self.unittype == "juggernaut";
}

_id_9D9D82F0160FBB53(group) {
  if(isDefined(group) && isDefined(self.post_spawn_spawner_funcs)) {
    foreach(func in self.post_spawn_spawner_funcs)
    self[[func]](group);
  }
}

_id_00B395044780AAC4() {
  if(isDefined(self.spawnpoint.post_spawn_ai_funcs)) {
    foreach(func in self.spawnpoint.post_spawn_ai_funcs)
    self[[func]]();
  }
}

_id_CBF9338E97CDB9F7(_id_F8E5E3AA5762A8E7) {
  self.enemy_group = _id_F8E5E3AA5762A8E7.group_name;
  self.moduleid = _id_F8E5E3AA5762A8E7.moduleid;
  self.group = _id_F8E5E3AA5762A8E7;
  self.group.activecount++;
  self.group.spawn_count++;
  _id_F8E5E3AA5762A8E7.ai_spawned[_id_F8E5E3AA5762A8E7.ai_spawned.size] = self;
  _id_F8E5E3AA5762A8E7 notify("spawned_group_soldier");

  if(isDefined(_id_F8E5E3AA5762A8E7.threatbiasoverride))
    self.threatbiasoverride = _id_F8E5E3AA5762A8E7.threatbiasoverride;

  if(isDefined(_id_F8E5E3AA5762A8E7.ai_spawn_func)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F8E5E3AA5762A8E7.ai_spawn_func.size; _id_AC0E594AC96AA3A8++)
      thread process_module_var(_id_F8E5E3AA5762A8E7, _id_F8E5E3AA5762A8E7.ai_spawn_func[_id_AC0E594AC96AA3A8], undefined, self);
  }
}

set_spawner_init_flag() {
  add_to_spawner_flags(1);
}

is_spawner_initialized() {
  return isDefined(self.spawner_flags) && self.spawner_flags & 1;
}

spawner_init() {
  level endon("game_ended");

  if(is_spawner_initialized()) {
    return;
  }
  set_spawner_init_flag();
  remove_default_kvps();
  set_spawner_type();

  if(!is_spawner_position_valid()) {
    remove_from_spawner_flags(4);
    remove_from_spawner_flags(2);
  } else {
    spawn_is_vehicle_spawn(self);
    self.lastspawntime = 0;

    if(isstruct(self) && isDefined(self.spawnflags))
      self.spawnflags = int(self.spawnflags);

    if(isDefined(self.script_parent)) {
      _id_1A977EA95154CBA4 = scripts\engine\utility::getStructArray(self.script_parent, "targetname");

      if(_id_1A977EA95154CBA4.size > 0) {
        self.child_spawners = [];
        self.child_spawners = _id_1A977EA95154CBA4;
        init_cluster_parent();
        scripts\engine\utility::array_thread(_id_1A977EA95154CBA4, ::spawner_init);
        return;
      }

      return;
    }

    _id_7A922F0FA8AF7C0A = 2;
    is_on_platform = 64;
    is_patroller = 128;
    is_pacifist = 256;

    if(!isnode(self) && isDefined(self.spawnflags)) {
      if(!isint(self.spawnflags))
        self.spawnflags = int(self.spawnflags);

      if(self.spawnflags &_id_7A922F0FA8AF7C0A)
        self.equip_armor = 1;

      if(self.spawnflags &is_on_platform) {
        add_to_spawner_flags(512);
        self.is_on_platform = 1;
      }

      if(!istrue(_id_0E80538EF14D00E1::is_vehicle_spawnpoint())) {
        _id_746593E9CD54D86E = 8;

        if(self.spawnflags &_id_746593E9CD54D86E)
          self.dont_enter_combat = 1;
      }
    }

    if(isDefined(self.script_count) || isDefined(self.script_timeout)) {
      self.post_spawn_spawner_funcs = [];
      self.post_spawn_spawner_funcs[self.post_spawn_spawner_funcs.size] = ::spawner_disable_after_count;
    }

    get_aitype_settings();
  }
}

get_aitype_settings() {
  spawnfunc = undefined;

  if(isDefined(spawnfunc))
    self.post_spawn_ai_funcs[self.post_spawn_ai_funcs.size] = spawnfunc;
}

enable_traversals_for_bombers() {
  level.bomber_shouldusetraversals = 1;
}

is_spawner_position_valid() {
  _id_5E7F14654E78AF92 = "^0";
  _id_CBA41E031462F3D0 = "^1";
  _id_CAAE05637AC7AE10 = "^2";
  _id_AC1BD900D1AABE1D = "^3";
  _id_D6348C41222908A1 = "^4";
  _id_816462F6F23F6883 = "^5";
  _id_8D342A1AB4AD19C3 = "^6";
  _id_003D457E623469E7 = "^7";
  _id_7D0735088218E523 = "^8";
  _id_BF96937082C048AC = "^9";
  _id_BE4A9BEED7ADB334 = _id_CBA41E031462F3D0 + "SPAWNER DISABLED: ";

  if(isDefined(self.targetname))
    targetname = _id_5E7F14654E78AF92 + "targetname = (" + self.targetname + ")";
  else
    targetname = "";

  type = scripts\engine\utility::ter_op(isstruct(self), _id_5E7F14654E78AF92 + "(struct) " + targetname + _id_AC1BD900D1AABE1D + "spawner", _id_5E7F14654E78AF92 + "(node)" + targetname + _id_AC1BD900D1AABE1D + " spawner");

  if(isDefined(self.script_difficulty) && level.gameskill <= 1 && scripts\engine\utility::is_equal(self.script_difficulty, "hard")) {
    disable_spawner();
    return 0;
  }

  _id_96C042967487D523 = _id_0E80538EF14D00E1::is_vehicle_spawnpoint();

  if(!spawner_flags_check(4)) {
    if(isDefined(self.origin)) {
      _id_D68EC2205B2A335B = getgroundposition(self.origin, 1, 100, 16);

      if(_id_96C042967487D523) {
        if(!isDefined(self.skip_navmesh_check) && !ispointonnavmesh(_id_D68EC2205B2A335B)) {
          disable_spawner();
          return 0;
        } else
          return 1;
      } else
        _id_D68EC2205B2A335B = self.origin;

      if(!isDefined(self.skip_navmesh_check)) {
        _id_55A01E81BDA4CC0C = getclosestpointonnavmesh(_id_D68EC2205B2A335B);

        if(isDefined(_id_55A01E81BDA4CC0C)) {
          if(distance2dsquared(_id_55A01E81BDA4CC0C, self.origin) <= 4096) {
            if(isstruct(self))
              self.origin = _id_55A01E81BDA4CC0C;
          } else {
            disable_spawner();
            return 0;
          }
        }
      }
    } else {
      disable_spawner();
      return 0;
    }
  }

  return 1;
}

disable_spawner() {
  add_to_spawner_flags(1024);
}

enable_spawner() {
  remove_from_spawner_flags(1024);
}

set_spawner_type() {
  if(isDefined(self.spawnflags) && !isnode(self)) {
    spawnflags = int(self.spawnflags);
    _id_DAD5B086D6059445 = 16;
    _id_29E2F295ACB987F2 = 8;

    if(spawnflags &_id_DAD5B086D6059445)
      define_spawner("vehicle_spawner");

    if(spawnflags &_id_29E2F295ACB987F2)
      define_spawner("vehicle_spawner");
  }

  if(isDefined(self.script_parent)) {
    _id_1A977EA95154CBA4 = scripts\engine\utility::getStructArray(self.script_parent, "targetname");

    if(_id_1A977EA95154CBA4.size > 0)
      define_spawner("cluster_spawner");
  }
}

remove_default_kvps() {
  if(scripts\engine\utility::is_equal(self.target, "default"))
    self.target = undefined;

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "default"))
    self.script_noteworthy = undefined;

  if(scripts\engine\utility::is_equal(self.script_forcespawn, 0))
    self.script_forcespawn = undefined;

  if(scripts\engine\utility::is_equal(self.script_team, "axis"))
    self.script_team = undefined;

  if(scripts\engine\utility::is_equal(self.script_radius, 0))
    self.script_radius = undefined;

  if(scripts\engine\utility::is_equal(self.script_goalheight, 0))
    self.script_goalheight = undefined;

  if(scripts\engine\utility::is_equal(self.script_origin_other, (0, 0, 0)))
    self.script_origin_other = undefined;

  if(scripts\engine\utility::is_equal(self.script_count, 0))
    self.script_count = undefined;

  if(scripts\engine\utility::is_equal(self.script_timeout, 0))
    self.script_timeout = undefined;

  if(scripts\engine\utility::is_equal(self.script_dot, 0))
    self.script_dot = undefined;

  if(scripts\engine\utility::is_equal(self.script_dist_only, 0))
    self.script_dist_only = undefined;

  if(scripts\engine\utility::is_equal(self.script_demeanor, "default"))
    self.script_demeanor = undefined;

  if(scripts\engine\utility::is_equal(self.script_speed, 0))
    self.script_speed = undefined;

  if(scripts\engine\utility::is_equal(self.script_linkto, "default"))
    self.script_linkto = undefined;

  if(scripts\engine\utility::is_equal(self.script_linkname, "default"))
    self.script_linkname = undefined;

  if(isDefined(self.script_unload)) {
    if(isstring(self.script_unload) && scripts\engine\utility::is_equal(self.script_unload, "-1"))
      self.script_unload = undefined;
    else if(isint(self.script_unload) && scripts\engine\utility::is_equal(self.script_unload, -1))
      self.script_unload = undefined;
  }
}

is_door_spawn() {
  is_door_spawn = 32;

  if(isDefined(self.spawnpoint)) {
    if(istrue(self.spawnpoint.door_spawner))
      return 1;
    else if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      if(self.spawnpoint.spawnflags &is_door_spawn && !(self.spawnpoint.spawnflags & 8)) {
        if(isDefined(self.spawnpoint.script_linkto)) {
          _id_2DFDC94D75548C27 = getEntArray(self.spawnpoint.script_linkto, "script_linkname");

          if(!isDefined(_id_2DFDC94D75548C27) || _id_2DFDC94D75548C27.size < 1)
            _id_2DFDC94D75548C27 = scripts\engine\utility::getStructArray(self.spawnpoint.script_linkto, "script_linkname");

          if(isDefined(_id_2DFDC94D75548C27) && _id_2DFDC94D75548C27.size > 0) {
            for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2DFDC94D75548C27.size; _id_AC0E594AC96AA3A8++) {
              _id_B0EE50BB7A11E24E = _id_2DFDC94D75548C27[_id_AC0E594AC96AA3A8];

              if(isDefined(_id_B0EE50BB7A11E24E.targetname) && _id_B0EE50BB7A11E24E.targetname == "ai_spawn_doors") {
                if(!isDefined(self.spawnpoint.doors))
                  self.spawnpoint.doors = [_id_B0EE50BB7A11E24E];
                else
                  self.spawnpoint.doors[self.spawnpoint.doors.size] = _id_B0EE50BB7A11E24E;

                continue;
              }

              if(isDefined(_id_2DFDC94D75548C27[0].script_noteworthy) && _id_2DFDC94D75548C27[0].script_noteworthy == "spawn_door_single") {
                if(!isDefined(self.spawnpoint.doors)) {
                  self.spawnpoint.doors = [_id_B0EE50BB7A11E24E];
                  continue;
                }

                self.spawnpoint.doors[self.spawnpoint.doors.size] = _id_B0EE50BB7A11E24E;
              }
            }

            if(isDefined(self.spawnpoint.doors) && self.spawnpoint.doors > 0) {
              self.spawnpoint.door_spawner = 1;
              return 1;
              return;
            }

            return 0;
            return;
            return;
          }

          return 0;
          return;
        } else
          return 0;
      } else
        return 0;
    } else if(isDefined(self.spawnpoint.script_linkto)) {
      _id_2DFDC94D75548C27 = getEntArray(self.spawnpoint.script_linkto, "script_linkname");

      if(!isDefined(_id_2DFDC94D75548C27) || _id_2DFDC94D75548C27.size < 1)
        _id_2DFDC94D75548C27 = scripts\engine\utility::getStructArray(self.spawnpoint.script_linkto, "script_linkname");

      if(isDefined(_id_2DFDC94D75548C27) && _id_2DFDC94D75548C27.size > 0) {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2DFDC94D75548C27.size; _id_AC0E594AC96AA3A8++) {
          _id_B0EE50BB7A11E24E = _id_2DFDC94D75548C27[_id_AC0E594AC96AA3A8];

          if(isDefined(_id_B0EE50BB7A11E24E.targetname) && _id_B0EE50BB7A11E24E.targetname == "ai_spawn_doors") {
            if(!isDefined(self.spawnpoint.doors))
              self.spawnpoint.doors = [_id_B0EE50BB7A11E24E];
            else
              self.spawnpoint.doors[self.spawnpoint.doors.size] = _id_B0EE50BB7A11E24E;

            continue;
          }

          if(isDefined(_id_2DFDC94D75548C27[0].script_noteworthy) && _id_2DFDC94D75548C27[0].script_noteworthy == "spawn_door_single") {
            if(!isDefined(self.spawnpoint.doors)) {
              self.spawnpoint.doors = [_id_B0EE50BB7A11E24E];
              continue;
            }

            self.spawnpoint.doors[self.spawnpoint.doors.size] = _id_B0EE50BB7A11E24E;
          }
        }

        if(isDefined(self.spawnpoint.doors) && self.spawnpoint.doors.size > 0) {
          self.spawnpoint.door_spawner = 1;
          return 1;
          return;
        }

        return 0;
        return;
        return;
      }

      return 0;
      return;
    } else
      return 0;
  } else
    return 0;
}

is_armored() {
  if(isDefined(self.spawnpoint)) {
    if(istrue(self.wearing_armor))
      return 1;
    else if(istrue(self.equip_armor))
      return 1;
    else if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags))
      return self.spawnpoint.spawnflags & 2;
    else
      return 0;
  } else
    return istrue(self.equip_armor);
}

is_patroller() {
  if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags))
      return self.spawnpoint.spawnflags & 128;
    else
      return 0;
  } else
    return istrue(self.script_patroller);
}

is_pacifist() {
  if(istrue(self.pacifist_override))
    return 1;
  else if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags))
      return self.spawnpoint.spawnflags & 256;
    else
      return 0;
  } else
    return istrue(self.script_pacifist);
}

has_dont_kill_off_flag() {
  if(isDefined(self.birthtime) && self.birthtime >= gettime())
    return 1;

  if(has_never_kill_off_flag())
    return 1;

  if(istrue(self.skip_dko_check))
    return 0;
  else if(istrue(self.dontkilloff))
    return 1;
  else if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags))
      return self.spawnpoint.spawnflags & 1024;
    else
      return 0;
  } else
    return 0;
}

has_never_kill_off_flag() {
  if(isDefined(self.birthtime) && self.birthtime >= gettime())
    return 1;

  if(istrue(self.never_kill_off))
    return 1;
  else if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags))
      return self.spawnpoint.spawnflags & 2048;
    else
      return 0;
  } else
    return 0;
}

should_roam() {
  if(istrue(level._id_3ABDB45E8244CE30))
    return 0;

  if(isDefined(self.spawnpoint) && !istrue(spawn_is_vehicle_spawn(self.spawnpoint))) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      if(self.spawnpoint.spawnflags & 512)
        return 0;
      else
        return 1;
    } else
      return 1;
  } else
    return 1;
}

parent_spawner_disable_after_count(group, spawn_point) {
  group endon("death");
  self notify("parent_spawner_disable_after_count");
  self endon("parent_spawner_disable_after_count");
  spawn_point endon("spawn_failed");
  spawn_point waittill("spawn_success");

  if(isDefined(self.script_count)) {
    self.script_count--;

    if(self.script_count < 1)
      thread disable_spawn_point(self, self.script_timeout, group);
  } else if(isDefined(self.script_timeout)) {
    if(!isDefined(self.lastspawntime))
      self.lastspawntime = 0;

    self.lastspawntime = gettime() + self.script_timeout * 1000 + 10000;
  }
}

spawner_disable_after_count(group) {
  if(isDefined(self.script_count)) {
    self.script_count--;

    if(self.script_count < 1)
      thread disable_spawn_point(self, self.script_timeout, group);
  } else if(isDefined(self.script_timeout)) {
    if(!isDefined(self.lastspawntime))
      spawner_init();

    self.lastspawntime = gettime() + self.script_timeout * 1000;
  }
}

init_cluster_parent() {
  define_spawner("cluster_spawner");
}

enemy_monitor(_id_742C9CA4175A2518, spec) {
  level endon("game_ended");
  update_spawn_data_on_spawn(_id_742C9CA4175A2518, spec);

  if(getdvarint("dvar_E170EDED9289133E", 0) != 0)
    thread kill_agent_when_in_water();
}

kill_agent_when_in_water() {
  self endon("death");

  for(;;) {
    trace = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 10), self.origin + (0, 0, -10), 0, self);
    self.hit_water = trace["surfacetype"] == "surftype_water";

    if(istrue(self.hit_water)) {
      if(istrue(level.bshockactive)) {
        if(isDefined(level.soldiershockfunc))
          self[[level.soldiershockfunc]](2);
      }
    }

    wait 1;
  }
}

update_spawn_data_on_spawn(_id_742C9CA4175A2518, spec) {
  _id_EBC9B6AE903F9C28 = 1;

  if(isDefined(self.team)) {
    if(self.team == "axis") {
      level.spawned_enemies[level.spawned_enemies.size] = self;
      level.current_num_spawned_enemies = level.current_num_spawned_enemies + _id_EBC9B6AE903F9C28;
    } else if(self.team == "allies")
      level.spawned_allies[level.spawned_allies.size] = self;
  }

  level.spawned_ai[level.spawned_ai.size] = self;

  if(isDefined(_id_742C9CA4175A2518)) {
    if(_id_742C9CA4175A2518 == "juggernaut") {
      if(!isDefined(level.spawned_juggernauts))
        level.spawned_juggernauts = [];

      level.spawned_juggernauts[level.spawned_juggernauts.size] = self;
    }

    if(_id_742C9CA4175A2518 == "soldier_agent" || _id_742C9CA4175A2518 == "soldier")
      level.current_num_spawned_soldiers = level.current_num_spawned_soldiers + _id_EBC9B6AE903F9C28;
  }
}

remove_from_kill_off_list() {
  if(isDefined(level.can_kill_off_list)) {
    if(isDefined(self.entity_number) && isDefined(level.can_kill_off_list[self.entity_number]))
      level.can_kill_off_list[self.entity_number] = undefined;
    else if(isDefined(level.can_kill_off_list[self getentitynumber()]))
      level.can_kill_off_list[self getentitynumber()] = undefined;

    if(level.can_kill_off_list.size < 1)
      level notify("stop_kill_off_loop");
  }
}

update_spawn_data_on_death(eattacker, sweapon) {
  self notify("update_spawn_data_on_death");
  self endon("update_spawn_data_on_death");
  level endon("game_ended");
  thread remove_from_kill_off_list();

  if(!isDefined(self.group))
    level notify("no group defined");

  _id_EBC9B6AE903F9C28 = 1;

  if(isDefined(self.team)) {
    if(self.team == "axis") {
      if(scripts\engine\utility::array_contains(level.spawned_enemies, self)) {
        level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, self);
        level.current_num_spawned_enemies = level.current_num_spawned_enemies - _id_EBC9B6AE903F9C28;
      }
    } else if(self.team == "allies") {
      if(scripts\engine\utility::array_contains(level.spawned_allies, self))
        level.spawned_allies = scripts\engine\utility::array_remove(level.spawned_allies, self);
    }
  }

  remove_from_enemy_list();

  if(isDefined(self.ridingvehicle))
    self.ridingvehicle thread scripts\cp\utility::add_to_notify_queue("passenger_died");

  if(scripts\engine\utility::array_contains(level.spawned_ai, self))
    level.spawned_ai = scripts\engine\utility::array_remove(level.spawned_ai, self);

  if(isDefined(self.group)) {
    is_group_active = is_my_group_an_active_module();

    if(self.group get_activecount_from_group() - _id_EBC9B6AE903F9C28 >= 1)
      self.group.activecount = int(clamp(self.group.activecount - _id_EBC9B6AE903F9C28, 0, self.group.activecount - _id_EBC9B6AE903F9C28));
    else
      self.group.activecount = 0;

    self.group.ai_spawned = scripts\engine\utility::array_remove(self.group.ai_spawned, self);

    if(is_group_active) {
      if(!istrue(self.died_poorly))
        self.group.currentmodulekills = self.group.currentmodulekills + _id_EBC9B6AE903F9C28;
    } else
      self.group.currentmodulekills = self.group.currentmodulekills + _id_EBC9B6AE903F9C28;

    totalspawns = process_module_var(self.group, self.group.totalspawns);

    if(isDefined(totalspawns) && totalspawns > 0) {
      if(is_group_active && self.group.currentmodulekills >= totalspawns) {
        self.group notify("spawn_module_" + self.group.moduleid + "_completed");
        self.group notify("group_spawning_completed");
        self.group notify("reached_total_spawns");
        level notify("group_spawning_completed");

        if(self.group get_activecount_from_group(1) < 1) {
          scripts\cp\cp_spawning_util::remove_group_from_combined_module_counters(self.group);
          self.group notify("all_group_spawns_dead");

          if(scripts\engine\utility::array_contains(level.spawn_module_structs_memory[self.group.group_name], self.group)) {
            level.spawn_module_structs_memory[self.group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[self.group.group_name], self.group);

            if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && level.spawn_module_structs_memory[self.group.group_name].size < 1)
              level.spawn_module_structs_memory[self.group.group_name] = undefined;
          }
        }
      } else if(!is_group_active && self.group get_activecount_from_group(1) < 1) {
        scripts\cp\cp_spawning_util::remove_group_from_combined_module_counters(self.group);
        self.group notify("all_group_spawns_dead");

        if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && scripts\engine\utility::array_contains(level.spawn_module_structs_memory[self.group.group_name], self.group)) {
          level.spawn_module_structs_memory[self.group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[self.group.group_name], self.group);

          if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && level.spawn_module_structs_memory[self.group.group_name].size < 1)
            level.spawn_module_structs_memory[self.group.group_name] = undefined;
        }
      } else if(is_group_active && self.group get_activecount_from_group(1) < 1)
        self.group notify("active_all_group_spawns_dead");
    } else if(!is_group_active && self.group get_activecount_from_group(1) < 1) {
      scripts\cp\cp_spawning_util::remove_group_from_combined_module_counters(self.group);
      self.group notify("all_group_spawns_dead");

      if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && scripts\engine\utility::array_contains(level.spawn_module_structs_memory[self.group.group_name], self.group)) {
        level.spawn_module_structs_memory[self.group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[self.group.group_name], self.group);

        if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && level.spawn_module_structs_memory[self.group.group_name].size < 1)
          level.spawn_module_structs_memory[self.group.group_name] = undefined;
      }
    } else if(is_group_active && self.group get_activecount_from_group(1) < 1)
      self.group notify("active_all_group_spawns_dead");

    if(!istrue(self.died_poorly))
      thread run_group_death_funcs();
    else
      thread run_died_poorly_funcs();

    if(scripts\cp\cp_spawning_util::group_has_combined_counters(self.group.group_name)) {
      combined_alias = self.group scripts\cp\cp_spawning_util::get_has_combined_counters_alias();

      if(isDefined(combined_alias)) {
        _id_C43C439E2DF8BD7C = level.combined_counters_groups[combined_alias];

        if(isDefined(_id_C43C439E2DF8BD7C) && _id_C43C439E2DF8BD7C.size > 0) {
          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C43C439E2DF8BD7C.size; _id_AC0E594AC96AA3A8++)
            level thread send_notify_to_groups_from_groupname(_id_C43C439E2DF8BD7C[_id_AC0E594AC96AA3A8].group_name, "activeCount_changed", _id_C43C439E2DF8BD7C[_id_AC0E594AC96AA3A8] get_activecount_from_group());
        } else
          level thread send_notify_to_groups_from_groupname(self.group.group_name, "activeCount_changed", self.group get_activecount_from_group());
      } else
        level thread send_notify_to_groups_from_groupname(self.group.group_name, "activeCount_changed", self.group get_activecount_from_group());
    } else
      level thread send_notify_to_groups_from_groupname(self.group.group_name, "activeCount_changed", self.group get_activecount_from_group());
  }

  if(isDefined(self.unittype)) {
    if(isDefined(self.unittype) && self.unittype == "juggernaut")
      level.current_num_spawned_juggernauts = level.current_num_spawned_juggernauts - _id_EBC9B6AE903F9C28;

    if(self.unittype == "soldier")
      level.current_num_spawned_soldiers = level.current_num_spawned_soldiers - _id_EBC9B6AE903F9C28;
  }
}

toggle_force_stop_wave_from_groupname(group_name, _id_E3108E412AFB3811, _id_532D40D9284E828C) {
  if(isDefined(level.spawn_module_structs_memory[group_name])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.spawn_module_structs_memory[group_name].size; _id_AC0E594AC96AA3A8++) {
      level.spawn_module_structs_memory[group_name][_id_AC0E594AC96AA3A8].stop_wave_spawning = _id_E3108E412AFB3811;

      if(!istrue(_id_E3108E412AFB3811))
        level.spawn_module_structs_memory[group_name][_id_AC0E594AC96AA3A8] notify("wave_spawn");

      change_module_status(level.spawn_module_structs_memory[group_name][_id_AC0E594AC96AA3A8], _id_532D40D9284E828C);
    }
  }
}

get_spawn_count_from_groupname(group_name) {
  _id_82E31BFBE50BBE23 = 0;

  if(isDefined(level.spawn_module_structs_memory[group_name])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.spawn_module_structs_memory[group_name].size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(level.spawn_module_structs_memory[group_name][_id_AC0E594AC96AA3A8].spawn_count))
        _id_82E31BFBE50BBE23 = _id_82E31BFBE50BBE23 + level.spawn_module_structs_memory[group_name][_id_AC0E594AC96AA3A8].spawn_count;
    }
  }

  return _id_82E31BFBE50BBE23;
}

subtract_from_spawn_count_from_group(_id_F8E5E3AA5762A8E7) {
  _id_F8E5E3AA5762A8E7.spawn_count--;
}

reset_spawn_count_from_groupname(group_name) {
  if(isDefined(level.spawn_module_structs_memory[group_name])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.spawn_module_structs_memory[group_name].size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(level.spawn_module_structs_memory[group_name][_id_AC0E594AC96AA3A8].spawn_count))
        level.spawn_module_structs_memory[group_name][_id_AC0E594AC96AA3A8].spawn_count = 0;
    }
  }
}

send_notify_to_groups_from_groupname(group_name, _id_FF5CCEDE2521CB13, param1, param2) {
  if(isDefined(level.spawn_module_structs_memory[group_name])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.spawn_module_structs_memory[group_name].size; _id_AC0E594AC96AA3A8++) {
      group = level.spawn_module_structs_memory[group_name][_id_AC0E594AC96AA3A8];
      group thread scripts\cp\utility::add_to_notify_queue(_id_FF5CCEDE2521CB13, param1);
    }
  }
}

get_activecount_from_group(_id_C0AD69E25377169F) {
  if(istrue(self.skip_soldier_spawn))
    return self.module_vehicles_count;
  else {
    _id_82E31BFBE50BBE23 = 0;

    if(!istrue(_id_C0AD69E25377169F) && isDefined(self.combined_alias)) {
      _id_C43C439E2DF8BD7C = level.combined_counters_groups[self.combined_alias];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C43C439E2DF8BD7C.size; _id_AC0E594AC96AA3A8++) {
        _id_F564CE57BB79FF69 = _id_C43C439E2DF8BD7C[_id_AC0E594AC96AA3A8];

        if(isDefined(_id_F564CE57BB79FF69.activecount))
          _id_82E31BFBE50BBE23 = _id_82E31BFBE50BBE23 + _id_F564CE57BB79FF69.activecount;
      }
    } else if(isDefined(self.activecount))
      _id_82E31BFBE50BBE23 = self.activecount;

    return _id_82E31BFBE50BBE23;
  }
}

set_wave_settings_for_all_with_groupname(group_name, wave_reference, last_wave_ref, last_wave_num) {
  if(isDefined(level.active_spawn_module_structs[group_name])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.active_spawn_module_structs[group_name].size; _id_AC0E594AC96AA3A8++) {
      group = level.active_spawn_module_structs[group_name][_id_AC0E594AC96AA3A8];
      group.wave_reference = wave_reference;
      group.last_wave_ref = last_wave_ref;
      group.last_wave_num = last_wave_num;
    }
  }
}

toggle_kamikaze_for_group(group, _id_E3108E412AFB3811) {
  group.kamikaze = _id_E3108E412AFB3811;
}

equip_random_grenade() {
  grenade_types = ["frag_grenade_mp", "molotov_mp", "semtex_mp", "flash_grenade_mp", "concussion_grenade_mp", "smoke_grenade_mp", "gas_mp"];
  grenade_chances = [0.5, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1];
  _id_8489888B834DCA8C = scripts\engine\utility::array_sum(grenade_chances);
  _id_087EC3EA7B437551 = randomfloatrange(0.0, _id_8489888B834DCA8C);
  _id_8D4EDD505ADF2C5D = 0;

  for(_id_AD78E2D0EFC05AF6 = 0; _id_AD78E2D0EFC05AF6 < grenade_types.size; _id_AD78E2D0EFC05AF6++) {
    _id_8D4EDD505ADF2C5D = _id_8D4EDD505ADF2C5D + grenade_chances[_id_AD78E2D0EFC05AF6];

    if(_id_8D4EDD505ADF2C5D >= _id_087EC3EA7B437551) {
      self.grenadeweapon = makeweapon(grenade_types[_id_AD78E2D0EFC05AF6]);
      self.grenadeammo = 2;
      return;
    }
  }
}

wave_go_kamikaze(group) {
  level endon("game_ended");

  if(isDefined(group)) {
    group notify("wave_go_kamikaze");
    group endon("wave_go_kamikaze");
    group endon("death");

    if(isDefined(group.timeout_after_min_count) && group.timeout_after_min_count > 0) {
      scripts\cp\cp_wave_spawning::update_enemies_remaining(0, group);
      group thread timeout_wave(group.timeout_after_min_count);
    }
  }

  wait 1.5;
  level notify("wave_ending");
}

wave_failsafe_end(group) {
  level endon("game_ended");
  level endon("timeout_wave");
  level notify("wave_failsafe_end");
  level endon("wave_failsafe_end");

  if(!scripts\cp\utility::is_wave_gametype()) {
    return;
  }
  _id_307FF213BE4E59BB = 0;
  _id_CE4B48E2A63B3705 = 45;
  _id_D49B6C890B68BE84 = int(_id_CE4B48E2A63B3705 / 2);

  for(;;) {
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    if(guys.size == 0)
      _id_307FF213BE4E59BB++;

    if(_id_307FF213BE4E59BB >= _id_CE4B48E2A63B3705) {
      break;
    }

    wait 1;
  }

  scripts\cp\cp_wave_spawning::update_enemies_remaining(0, group);
  group thread timeout_wave(group.timeout_after_min_count);
}

timeout_wave(wait_time) {
  level endon("game_ended");
  level notify("timeout_wave");
  level endon("timeout_wave");
  self endon("death");
  setomnvar("cp_countdown_color", 0);

  if(getdvarint("dvar_F51CCA1F5C183719", -1) != -1)
    wait_time = getdvarint("dvar_F51CCA1F5C183719", -1);

  notify_all_groups_in_module(self.group_name, "threshold_timeout");
  toggle_force_stop_wave_from_groupname(self.group_name, 1, "wave_delay");
  toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "wave_delay");
  wave_cooldown_time(wait_time);
  scripts\cp\cp_wave_spawning::update_enemies_remaining(0, self);

  if(!istrue(self.disable_wave_hud)) {
    wait 0.1;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      level.players[_id_AC0E594AC96AA3A8] thread scripts\cp\cp_hud_message::showsplash("cp_wave_ended", level.display_wave_num, undefined);
      level.players[_id_AC0E594AC96AA3A8] thread scripts\cp\cp_challenge::onplant();
    }
  }

  wait(wait_time - 10);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
    setomnvar("cp_countdown_color", 2);
    wait 1;
  }

  setomnvar("cp_wave_timer", 0);
  scripts\cp\cp_wave_spawning::increase_wave_num();
  run_func_on_group_by_groupname(self.group_name, [::toggle_kamikaze_for_group, undefined]);
  toggle_force_stop_wave_from_groupname(self.group_name, undefined, "new_wave_starting");
  toggle_force_stop_wave_from_groupname("wave_paratroopers", undefined, "new_wave_starting");
}

notify_all_groups_in_module(group_name, _id_FF5CCEDE2521CB13) {
  if(isDefined(level.spawn_module_structs_memory[group_name])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.spawn_module_structs_memory[group_name].size; _id_AC0E594AC96AA3A8++)
      level.spawn_module_structs_memory[group_name][_id_AC0E594AC96AA3A8] notify(_id_FF5CCEDE2521CB13);
  }
}

group_wait_for_activecount_notify(_id_F9A50F697CF445EB) {
  self endon("death");
  self endon("threshold_timeout");

  for(;;) {
    self waittill("activeCount_changed", _id_341137AF462DEADF);

    if(getdvarfloat("dvar_4F27A8AB9BAE330A", 0) != 0)
      childthread start_threshold_timeout(getdvarfloat("dvar_4F27A8AB9BAE330A"));

    if(_id_341137AF462DEADF <= _id_F9A50F697CF445EB) {
      self notify("start_threshold_timeout");
      break;
    }
  }
}

start_threshold_timeout(timeout) {
  self notify("start_threshold_timeout");
  self endon("start_threshold_timeout");
  wait(timeout);
  self notify("threshold_timeout");
}

run_group_death_funcs() {
  if(isDefined(self.group) && isDefined(self.group.ai_death_func)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.group.ai_death_func.size; _id_AC0E594AC96AA3A8++)
      self thread[[self.group.ai_death_func[_id_AC0E594AC96AA3A8]]]();
  }
}

is_my_group_an_active_module() {
  keys = getarraykeys(level.active_spawn_module_structs);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    group = level.active_spawn_module_structs[keys[_id_AC0E594AC96AA3A8]];

    if(isarray(group)) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < group.size; _id_AC0E5C4AC96AAA41++) {
        if(group[_id_AC0E5C4AC96AAA41] == self.group)
          return 1;
      }

      continue;
    }

    if(group == self.group)
      return 1;
  }

  return 0;
}

get_total_reserved_slot_count() {
  count = 0;

  foreach(slot in level.reserved_spawn_slots)
  count = count + slot;

  return count;
}

get_reserved_slot_count_by_string_id(_id_4B543E12BCE76BEC) {
  if(isDefined(_id_4B543E12BCE76BEC) && isDefined(level.reserved_spawn_slots[_id_4B543E12BCE76BEC]))
    return level.reserved_spawn_slots[_id_4B543E12BCE76BEC];
  else
    return 0;
}

increase_reserved_spawn_slots(num, _id_4B543E12BCE76BEC, group) {
  if(isDefined(_id_4B543E12BCE76BEC)) {
    if(!isDefined(level.reserved_spawn_slots[_id_4B543E12BCE76BEC]))
      level.reserved_spawn_slots[_id_4B543E12BCE76BEC] = 0;
  } else
    _id_4B543E12BCE76BEC = "default";

  level.reserved_spawn_slots[_id_4B543E12BCE76BEC] = level.reserved_spawn_slots[_id_4B543E12BCE76BEC] + num;
  allowed_to_spawn_agent(group, 1, level.reserved_spawn_slots[_id_4B543E12BCE76BEC], _id_4B543E12BCE76BEC);
}

decrease_reserved_spawn_slots(num, _id_4B543E12BCE76BEC) {
  if(isDefined(_id_4B543E12BCE76BEC)) {
    if(isDefined(level.reserved_spawn_slots[_id_4B543E12BCE76BEC])) {
      _id_D30FD0A5F4A93E62 = level.reserved_spawn_slots[_id_4B543E12BCE76BEC];
      level.reserved_spawn_slots[_id_4B543E12BCE76BEC] = int(clamp(_id_D30FD0A5F4A93E62 - num, 0, _id_D30FD0A5F4A93E62 - num));

      if(level.reserved_spawn_slots[_id_4B543E12BCE76BEC] < 1) {
        level.reserved_spawn_slots[_id_4B543E12BCE76BEC] = undefined;
        return;
      }
    } else {}
  } else {
    _id_4B543E12BCE76BEC = "default";

    if(isDefined(level.reserved_spawn_slots[_id_4B543E12BCE76BEC])) {
      _id_D30FD0A5F4A93E62 = level.reserved_spawn_slots[_id_4B543E12BCE76BEC];
      level.reserved_spawn_slots[_id_4B543E12BCE76BEC] = int(clamp(_id_D30FD0A5F4A93E62 - num, 0, _id_D30FD0A5F4A93E62 - num));

      if(level.reserved_spawn_slots[_id_4B543E12BCE76BEC] < 1) {
        level.reserved_spawn_slots[_id_4B543E12BCE76BEC] = undefined;
        return;
      }
    } else {}
  }
}

enter_combat(_id_97282C14346A7FCF) {
  if(istrue(level._id_A4977696D3393DD8) || istrue(self.aggressive) || istrue(self.dont_enter_combat)) {
    return;
  }
  if(scripts\cp\coop_stealth::should_run_sp_stealth()) {
    return;
  }
  self notify("alerted");
  self notify("enter_combat");
  self notify("stop_going_to_node");
  self endon("death");
  level endon("game_ended");
  set_kill_off_time();
  set_demeanor_from_unittype("combat");

  if(getdvarint("dvar_9BCCA58E56E4C178", 0))
    scripts\cp\cp_outline::enable_outline_for_players(self, level.players, "outline_nodepth_green", "high");

  self.pacifist_override = undefined;
  self.scripted_mode = 0;
  self.entered_combat = 1;
  self.script_pacifist = undefined;
  self.pacifist = 0;
  self.currentnode = undefined;

  if(!is_specified_unittype("juggernaut")) {
    _id_CE2161D0EDFB387E = randomintrange(180, 220);
    scripts\engine\utility::set_movement_speed(_id_CE2161D0EDFB387E);
  }

  if(!is_specified_unittype("suicidebomber") && !is_specified_unittype("civilian") && !_id_5BB77ADDD9F02498("allies"))
    thread get_enemy_info_loop();

  run_combat_func();
}

run_combat_func(param1, param2) {
  if(isDefined(self.combat_func_override))
    _id_44A76D6F2A335572 = self.combat_func_override;
  else
    _id_44A76D6F2A335572 = self.aitype;

  if(isDefined(_id_44A76D6F2A335572)) {
    if(isDefined(level.aitypes[_id_44A76D6F2A335572]) && isDefined(level.aitypes[_id_44A76D6F2A335572].combat_func)) {
      if(isDefined(param1) && isDefined(param2))
        self thread[[level.aitypes[_id_44A76D6F2A335572].combat_func]](param1, param2);
      else if(isDefined(param1))
        self thread[[level.aitypes[_id_44A76D6F2A335572].combat_func]](param1);
      else
        self thread[[level.aitypes[_id_44A76D6F2A335572].combat_func]]();
    }
  }
}

get_enemy_info_loop(_id_988C511564BEE3EA) {
  level endon("game_ended");
  self notify("get_enemy_info_loop");
  self endon("get_enemy_info_loop");
  self endon("death");

  if(istrue(self.attempting_teleport)) {
    self.ignoreall = 0;
    self.is_on_platform = undefined;
    self.attempting_teleport = undefined;
    self show();
    set_kill_off_time(20.0);
  }

  if(!isDefined(_id_988C511564BEE3EA))
    _id_988C511564BEE3EA = 2;

  _id_EEEAA28F8FA549D1 = 0;
  _id_6C3229091811ACD4 = 1;
  _id_45F9A855D9BAAA6B = get_comp_dist_for_info_loop();
  _id_B9B21F015277470B = ::get_all_players_enemy_info_new;
  _id_9145D185F89CF357 = ::get_closest_available_player_new;

  for(;;) {
    if(should_skip_info_loop()) {
      _id_EEEAA28F8FA549D1 = 0;
      self.target_enemy = undefined;
    } else {
      _id_6DFF1FC88CA160AF = _id_45F9A855D9BAAA6B;

      if(_id_6C3229091811ACD4)
        _id_6DFF1FC88CA160AF = undefined;

      _id_783EE0B853473371 = self[[_id_B9B21F015277470B]](_id_6DFF1FC88CA160AF);
      target_player = self[[_id_9145D185F89CF357]](_id_6DFF1FC88CA160AF, _id_783EE0B853473371);

      if(isDefined(target_player)) {
        _id_6C3229091811ACD4 = 0;

        if(isDefined(self.script_origin_other))
          _id_2AE01F9836C08415 = self.script_origin_other;
        else
          _id_2AE01F9836C08415 = target_player.origin;

        if(scripts\cp\utility::is_wave_gametype())
          set_goal_pos_check_for_offset(target_player.origin);
        else if(!has_dont_kill_off_flag() && z_is_excessive(_id_2AE01F9836C08415)) {
          if(passed_kill_off_time_checks(gettime()))
            teleport_to_nearby_spawner("Too Far From Target", _id_2AE01F9836C08415);
        } else {
          set_kill_off_time(_id_988C511564BEE3EA);
          set_demeanor_from_unittype("combat");

          if(isDefined(self.goal_pos_override) && !isDefined(self.last_set_goalent)) {
            self.goal_pos_override = undefined;
            set_goal_radius(self.last_goalradius);
          }

          update_target_player(target_player);

          if(isDefined(self.group))
            self.group scripts\engine\utility::ent_flag_set("weapons_free");

          if(isDefined(self.script_goalvolume))
            self setgoalvolumeauto(self.script_goalvolume);
          else {
            self cleargoalvolume();

            if(!istrue(self.combat_func_active)) {
              if(!istrue(self.is_on_platform) && isDefined(self.engagemaxdist)) {
                _id_934F2BD9F0E5C04B = 6;

                if(self seerecently(target_player, _id_934F2BD9F0E5C04B)) {
                  _id_3A1644F2929823D8 = distancesquared(_id_2AE01F9836C08415, self.origin);
                  _id_5B54E94C677983C0 = _id_3A1644F2929823D8 <= self.engagemaxdist * self.engagemaxdist;

                  if(istrue(_id_EEEAA28F8FA549D1) && _id_5B54E94C677983C0 || isDefined(target_player.vehicle_riding_on)) {
                    _id_EEEAA28F8FA549D1 = 0;
                    set_goal_pos_check_for_offset(self.origin);
                  } else if(!istrue(_id_EEEAA28F8FA549D1) && !_id_5B54E94C677983C0) {
                    _id_EEEAA28F8FA549D1 = 1;
                    set_goal_pos_check_for_offset(target_player.origin);
                  }
                } else {
                  _id_EEEAA28F8FA549D1 = 1;
                  set_goal_pos_check_for_offset(target_player.origin);
                }
              } else {
                self.goal_pos_override = undefined;
                set_goal_pos_check_for_offset(self.origin);
              }
            }
          }
        }
      } else if(!istrue(self.combat_func_active)) {
        _id_EEEAA28F8FA549D1 = 0;
        self.target_enemy = undefined;
        self.goal_pos_override = undefined;

        if(isDefined(self.script_origin_other))
          set_goal_pos_check_for_offset(self.script_origin_other);
        else if(istrue(self.is_on_platform))
          set_goal_pos_check_for_offset(self.origin);
        else if(isDefined(self.script_goalvolume))
          self setgoalvolumeauto(self.script_goalvolume);
        else if(!has_dont_kill_off_flag()) {
          if(passed_kill_off_time_checks(gettime()))
            teleport_to_nearby_spawner("No Target Found", self.origin);
          else {
            set_goal_pos_check_for_offset(self.origin);
            set_demeanor_from_unittype("cqb");
          }
        } else {
          set_goal_pos_check_for_offset(self.origin);
          set_demeanor_from_unittype("cqb");
        }
      }
    }

    wait(_id_988C511564BEE3EA);

    if(istrue(self._id_4B3EDA62DD53F00B))
      return;
  }
}

get_comp_dist_for_info_loop() {
  if(isDefined(self.group)) {
    if(isDefined(self.group.spawn_scoring_overrides))
      _id_45F9A855D9BAAA6B = self.group.spawn_scoring_overrides.too_far_dist;
    else if(istrue(self.group.cqb_module))
      _id_45F9A855D9BAAA6B = 2333;
    else
      _id_45F9A855D9BAAA6B = 4096;
  } else if(istrue(level.spawn_scoring_overrides))
    _id_45F9A855D9BAAA6B = level.spawn_scoring_overrides.too_far_dist;
  else
    _id_45F9A855D9BAAA6B = 4096;

  _id_45F9A855D9BAAA6B = int(min(_id_45F9A855D9BAAA6B, 2500));
  return _id_45F9A855D9BAAA6B;
}

should_skip_info_loop() {
  if(istrue(self.ignoreall) || istrue(self.scripted_mode) || istrue(self._id_894D1167ACE5B58C))
    return 1;
  else
    return 0;
}

get_all_players_enemy_info() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
    self getenemyinfo(level.players[_id_AC0E594AC96AA3A8]);
}

get_all_players_enemy_info_new(_id_97282C14346A7FCF) {
  self notify("get_all_players_enemy_info_new");
  self endon("get_all_players_enemy_info_new");
  _id_7BBDA18A855C7111 = [];

  if(!scripts\engine\utility::is_equal(self.demeanoroverride, "combat")) {
    self endon("death");
    wait 5;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(get_player_info_proc(level.players[_id_AC0E594AC96AA3A8]))
      _id_7BBDA18A855C7111[_id_7BBDA18A855C7111.size] = level.players[_id_AC0E594AC96AA3A8];
  }

  return _id_7BBDA18A855C7111;
}

get_player_info_proc(player) {
  if(scripts\cp\utility::is_wave_gametype()) {
    player.lastseentime = gettime();
    self getenemyinfo(player);
    return 1;
  }

  _id_934F2BD9F0E5C04B = 5;
  _id_2AB4EB5F9BF4DD77 = 5;

  if(self seerecently(player, _id_934F2BD9F0E5C04B)) {
    player.lastseentime = gettime();
    self getenemyinfo(player);
    return 1;
  } else if(isDefined(player.lastseentime) && gettime() < player.lastseentime + _id_2AB4EB5F9BF4DD77 * 1000) {
    self getenemyinfo(player);
    return 1;
  } else if(isDefined(self.pathgoalpos) && distancesquared(self.pathgoalpos, player.origin) < 262144 && self pathdisttogoal() < 2048)
    return 1;

  return 0;
}

z_is_excessive(_id_B0BDB0F88C510505) {
  _id_D5685B7BAEE6505E = self.origin;
  max_z = 256;

  if(self _meth_E8CA4080D02A0BB4())
    max_z = 512;

  _id_09C1331465A43603 = undefined;

  if(isDefined(_id_B0BDB0F88C510505))
    _id_09C1331465A43603 = _id_B0BDB0F88C510505[2];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(_id_B0BDB0F88C510505))
      _id_09C1331465A43603 = level.players[_id_AC0E594AC96AA3A8].origin[2];

    if(int(abs(_id_D5685B7BAEE6505E[2] - _id_09C1331465A43603)) >= max_z && !spawnsighttrace(undefined, level.players[_id_AC0E594AC96AA3A8].origin, _id_D5685B7BAEE6505E))
      return 1;
  }

  return 0;
}

set_goal_pos_to_center_of_nearby_ai() {
  self endon("death");

  if(!isDefined(self.goal_pos_override))
    set_goal_radius(1024);

  _id_01D4621C77C9108F = level.spawned_enemies;
  ai_array = scripts\engine\utility::get_array_of_closest(self.origin, _id_01D4621C77C9108F, undefined, 10);
  center_point = scripts\cp\utility::get_center_point_of_array(ai_array);

  if(!isDefined(self.goal_pos_override) || distance2dsquared(self.goal_pos_override, center_point) >= 262144) {
    self.goal_pos_override = center_point;
    set_goal_pos(self.goal_pos_override);
  }

  wait 5;
}

has_seen_any_player_recently_watcher() {
  self endon("death");
  _id_6B554CCF6D238865 = 10;
  _id_05471F9FE1D572B7 = gettime() / level.frameduration % _id_6B554CCF6D238865;
  _id_A453164A8EB29906 = self getentitynumber() % _id_6B554CCF6D238865;

  if(_id_05471F9FE1D572B7 != _id_A453164A8EB29906)
    wait((_id_A453164A8EB29906 + _id_6B554CCF6D238865 - _id_05471F9FE1D572B7) % _id_6B554CCF6D238865 * level.frameduration / 1000);

  while(has_seen_any_player_recently())
    wait 0.5;
}

has_seen_any_player_recently() {
  _id_934F2BD9F0E5C04B = 3;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    if(self seerecently(level.players[_id_AC0E594AC96AA3A8], _id_934F2BD9F0E5C04B))
      return 1;
  }

  if(!killoff_vis_passed())
    return 1;

  return 0;
}

teleport_to_nearby_spawner(_id_401C3A2E68AAB0FD, _id_9C0D8673F33945A9, _id_8FFCE7D21396AFE0) {
  if(scripts\cp\utility::is_wave_gametype() || istrue(level._id_F57B5DB263860330)) {
    return;
  }
  if(istrue(self.marked_for_death) || istrue(self.attempting_teleport)) {
    return;
  }
  if(has_never_kill_off_flag()) {
    if(isDefined(_id_401C3A2E68AAB0FD)) {
      if(getdvarint("dvar_9E9513E7705385BD", 0)) {
        _id_CCC48D184751E941 = 1;

        if(isDefined(_id_9C0D8673F33945A9)) {
          if(_id_CCC48D184751E941)
            announcement("(NKO)Agent at: " + self.origin + " attempted teleport because: " + _id_401C3A2E68AAB0FD);
        } else if(_id_CCC48D184751E941)
          announcement("(NKO)Agent at: " + self.origin + " attempted teleport because: " + _id_401C3A2E68AAB0FD);
      }
    }
  } else if(istrue(self.forced_kill_off) || !isDefined(self.group))
    script_kill_ai();
  else {
    self endon("death");
    self notify("teleport_to_nearby_spawner");
    self endon("teleport_to_nearby_spawner");

    if(getdvarint("dvar_9E9513E7705385BD", 0))
      self hudoutlineenable("outline_cp_teleport_debug");

    if(getdvarint("dvar_B7F5396996295942", 0)) {
      self notify("get_enemy_info_loop");
      self.ignoreall = 1;
      self.ignoreme = 1;
      self.marked_for_death = 1;
      set_goal_pos(self.origin);
      self waittill("forever");
    }

    if(!isDefined(_id_8FFCE7D21396AFE0))
      _id_8FFCE7D21396AFE0 = 1;

    if(_id_8FFCE7D21396AFE0)
      has_seen_any_player_recently_watcher();

    if(istrue(self.playing_skit))
      script_kill_ai(1);
    else {
      if(is_riding_vehicle()) {
        script_kill_ai();
        return;
        return;
      }

      spawnpoint = choose_spawnpoint(self.group, 1, self);

      if(isDefined(spawnpoint)) {
        if(isDefined(_id_401C3A2E68AAB0FD)) {
          if(getdvarint("dvar_9E9513E7705385BD", 0)) {
            _id_CCC48D184751E941 = 1;

            if(isDefined(_id_9C0D8673F33945A9)) {
              if(_id_CCC48D184751E941)
                announcement("Agent at: " + self.origin + " teleported because: " + _id_401C3A2E68AAB0FD);
            } else if(_id_CCC48D184751E941)
              announcement("Agent at: " + self.origin + " teleported because: " + _id_401C3A2E68AAB0FD);
          }
        }

        spawnpoint notify("spawn_success", spawnpoint);
        self endon("death");
        self.combat_func_active = undefined;
        self.attempting_teleport = 1;
        self.ignoreall = 1;
        set_kill_off_time(20.0);
        self hide();
        spawnpoint _id_EC648F2C89EA1C91();
        wait 0.1;
        self dontinterpolate();
        _id_40253D1D292D9707 = (0, 0, 0);

        if(isDefined(spawnpoint.angles))
          _id_40253D1D292D9707 = spawnpoint.angles;

        self forceteleport(spawnpoint.origin, _id_40253D1D292D9707, 10000, 1);
        self.goal_pos_override = undefined;
        set_goal_pos(self.origin);
        wait 0.1;
        self.ignoreall = 0;
        self.is_on_platform = undefined;
        self.attempting_teleport = undefined;
        self show();
        set_kill_off_time(20.0);
        target_player = get_closest_available_player();
        update_target_player(target_player);
        return;
      }

      if(isDefined(_id_401C3A2E68AAB0FD)) {
        if(_id_401C3A2E68AAB0FD == "Bad Path") {
          return;
        }
        if(_id_401C3A2E68AAB0FD == "Too Far From Target") {
          if(isDefined(_id_9C0D8673F33945A9)) {} else {}

          set_goal_pos_to_center_of_nearby_ai();
          return;
        }

        script_kill_ai();
        return;
        return;
        return;
      }

      script_kill_ai();
    }
  }
}

script_kill_ai(_id_4A25D51D4C939879) {
  remove_from_kill_off_list();

  if(self.birthtime >= gettime())
    waitframe();

  self.marked_for_death = 1;

  if(!istrue(_id_4A25D51D4C939879))
    self.nocorpse = 1;

  self.died_poorly = 1;
  self.died_poorly_health = self.health;

  if(istrue(self.wave_spawn)) {
    if(isDefined(level._id_F09A19AC00F88108))
      level._id_F09A19AC00F88108[level._id_F09A19AC00F88108.size] = self.aitype;
  }

  self kill();
}

remove_from_enemy_list(target_player) {
  if(!isDefined(target_player) && isDefined(self.target_enemy))
    target_player = self.target_enemy;

  if(isDefined(target_player)) {
    if(scripts\engine\utility::array_contains(target_player.enemy_list, self))
      target_player.enemy_list = scripts\engine\utility::array_remove(target_player.enemy_list, self);
  }
}

get_closest_available_player(_id_45F9A855D9BAAA6B) {
  _id_FA881E11A5BE9A19 = undefined;

  if(isDefined(_id_45F9A855D9BAAA6B))
    players = scripts\common\utility::playersnear(self.origin, _id_45F9A855D9BAAA6B);
  else
    players = scripts\cp\utility::get_array_of_valid_players();

  players = sortbydistance(players, self.origin);
  _id_E793DD1C29570DB4 = _id_45F9A855D9BAAA6B;

  if(players.size > 0) {
    _id_FA881E11A5BE9A19 = players[0];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
      player = players[_id_AC0E594AC96AA3A8];

      if(istrue(player.ignoreme)) {
        continue;
      }
      if(!player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(isDefined(self.enemy) && player == self.enemy)
        return player;

      if(scripts\cp\cp_spawning_util::cp_is_point_in_front(player.origin)) {
        _id_FA881E11A5BE9A19 = player;
        break;
      }
    }
  }

  if(isDefined(_id_FA881E11A5BE9A19))
    return _id_FA881E11A5BE9A19;
  else
    return undefined;
}

get_closest_available_player_new(_id_45F9A855D9BAAA6B, _id_783EE0B853473371) {
  _id_FA881E11A5BE9A19 = undefined;

  if(isDefined(_id_45F9A855D9BAAA6B) && !scripts\cp\utility::is_wave_gametype())
    players = playersnearcustom(self.origin, _id_45F9A855D9BAAA6B, _id_783EE0B853473371);
  else
    players = scripts\cp\utility::get_array_of_valid_players();

  players = sortbydistance(players, self.origin);
  _id_E793DD1C29570DB4 = _id_45F9A855D9BAAA6B;

  if(players.size > 0) {
    _id_FA881E11A5BE9A19 = players[0];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < players.size; _id_AC0E594AC96AA3A8++) {
      player = players[_id_AC0E594AC96AA3A8];

      if(istrue(player.ignoreme)) {
        continue;
      }
      if(!player scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }
      if(isDefined(self.enemy) && player == self.enemy)
        return player;

      if(player scripts\cp\cp_spawning_util::cp_is_point_in_front(self.origin)) {
        _id_FA881E11A5BE9A19 = player;
        break;
      }
    }
  }

  if(isDefined(_id_FA881E11A5BE9A19))
    return _id_FA881E11A5BE9A19;
  else
    return undefined;
}

playersnearcustom(point, distance, _id_783EE0B853473371) {
  _id_556DB0B72A96514E = physics_createcontents(["physicscontents_characterproxy"]);
  _id_B65B7AEAB526E1AC = (distance, distance, distance);
  _id_80745CF3E2877DF5 = point - _id_B65B7AEAB526E1AC;
  _id_809746F3E2AD954B = point + _id_B65B7AEAB526E1AC;
  _id_7BBDA18A855C7111 = [];
  hits = physics_aabbbroadphasequery(_id_80745CF3E2877DF5, _id_809746F3E2AD954B, _id_556DB0B72A96514E, []);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < hits.size; _id_AC0E594AC96AA3A8++) {
    if(isPlayer(hits[_id_AC0E594AC96AA3A8])) {
      if(scripts\engine\utility::array_contains(_id_783EE0B853473371, hits[_id_AC0E594AC96AA3A8]))
        _id_7BBDA18A855C7111 = scripts\engine\utility::array_add(_id_7BBDA18A855C7111, hits[_id_AC0E594AC96AA3A8]);
    }
  }

  return _id_7BBDA18A855C7111;
}

update_target_player(target_player) {
  if(isDefined(target_player)) {
    if(!isDefined(target_player.enemy_list))
      target_player.enemy_list = [];

    if(!isDefined(self.target_enemy) || self.target_enemy != target_player) {
      self notify("changed_target");
      remove_from_enemy_list(target_player);
    }

    run_combat_func(target_player);
  }

  self.target_enemy = target_player;
}

trigger_choose_func_from_list(trigger, player) {}

trigger_run_module_once(trigger, player) {
  level endon("game_ended");
  group = run_spawn_module(trigger.target);
  trigger notify("disable_trigger");
}

trigger_run_spawn_module(trigger, player) {
  level endon("game_ended");
  group = run_spawn_module(trigger.target);

  if(isDefined(group))
    wait_for_all_group_dead(group);
}

wait_for_all_group_dead(group, _id_DD662D1D63252970, param1, param2) {
  if(isDefined(_id_DD662D1D63252970))
    group scripts\engine\utility::waittill_any_timeout_1(_id_DD662D1D63252970, "group_spawning_completed");
  else
    group waittill("group_spawning_completed");
}

group_reset_goalRadius(group, _id_2CAAB8E7479CAF27) {
  if(!isDefined(_id_2CAAB8E7479CAF27))
    _id_2CAAB8E7479CAF27 = 2048;

  spawned_ai = group get_spawned_ai_from_group_struct();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawned_ai.size; _id_AC0E594AC96AA3A8++)
    spawned_ai[_id_AC0E594AC96AA3A8] set_goal_radius(_id_2CAAB8E7479CAF27);
}

wave_cooldown_time(timer) {
  if(!istrue(level.wave_cooldown_active)) {
    level thread monitor_wave_cooldown(timer);
    level thread wave_cooldown_sounds(timer);

    if(!istrue(self.disable_wave_hud)) {
      _id_E84E755251284EC2 = gettime() + timer * 1000;
      setomnvar("cp_wave_timer", int(_id_E84E755251284EC2));
    }
  }
}

monitor_wave_cooldown(timer) {
  level endon("game_ended");
  level.wave_cooldown_active = 1;
  wait(timer);
  level.wave_cooldown_active = undefined;
}

wave_cooldown_sounds(timer) {
  level endon("game_ended");
  level endon("wave_starting");
  level endon("stop_wave_sounds");

  if(!scripts\cp\utility::is_wave_gametype()) {
    return;
  }
  if(isDefined(level.wavesv_finite_max) && level.wavesv_finite_max <= level.display_wave_num) {
    return;
  }
  _id_8DD9F2EB8215A139 = timer;

  while(_id_8DD9F2EB8215A139 > 0) {
    _id_8DD9F2EB8215A139--;
    _id_D5ADBC626EA67B4D = scripts\cp\utility::getclocksoundaliasfortimeleft(_id_8DD9F2EB8215A139);

    foreach(player in level.players)
    player playlocalsound(_id_D5ADBC626EA67B4D);

    if(_id_8DD9F2EB8215A139 == 30 || _id_8DD9F2EB8215A139 == 10) {
      _id_18F2BB0DD309974C = scripts\cp\utility::getoverlordaliasfortimeleft(_id_8DD9F2EB8215A139);

      if(isDefined(_id_18F2BB0DD309974C))
        level thread _id_166B4F052DA169A7::try_to_play_vo_on_team(_id_18F2BB0DD309974C, "allies");
    }

    wait 1;
  }
}

set_count_based_on_grouped_modules(group, _id_F3AC51EC178C7722, _id_9112AEE06E41CEC2, _id_43E4442D6EA9B20D) {
  if(!isDefined(level.grouped_modules[_id_F3AC51EC178C7722]))
    level.grouped_modules[_id_F3AC51EC178C7722] = [];

  if(!scripts\engine\utility::array_contains(level.grouped_modules[_id_F3AC51EC178C7722], group))
    level.grouped_modules[_id_F3AC51EC178C7722][level.grouped_modules[_id_F3AC51EC178C7722].size] = group;

  active = group.activecount;
  _id_82E8765288A4EAFB = get_active_from_grouped_modules(level.grouped_modules[_id_F3AC51EC178C7722]);

  if(_id_82E8765288A4EAFB < _id_9112AEE06E41CEC2)
    return _id_43E4442D6EA9B20D;
  else
    return 0;
}

get_active_from_grouped_modules(grouped_modules) {
  count = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < grouped_modules.size; _id_AC0E594AC96AA3A8++)
    count = count + grouped_modules[_id_AC0E594AC96AA3A8].activecount;

  return count;
}

define_var_if_undefined(_id_D49B300A0C84B099, _id_7C4E85897DE24AD2) {
  if(!isDefined(_id_D49B300A0C84B099)) {
    if(isfunction(_id_7C4E85897DE24AD2))
      return [[_id_7C4E85897DE24AD2]]();
    else
      return _id_7C4E85897DE24AD2;
  } else
    return _id_D49B300A0C84B099;
}

disable_spawn_window(timer) {
  self.spawn_window_open = undefined;
  self.last_wave_time = gettime();
}

go_to_node(nodes, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25) {
  if(!isDefined(nodes) || isarray(nodes) && nodes.size < 1) {
    nodes = self.spawnpoint get_next_node_array();

    if(nodes.size == 0) {
      self notify("reached_path_end");

      if(isDefined(_id_D25339A42DEEAC35))
        [[_id_D25339A42DEEAC35]]();

      return;
    }
  } else if(!isarray(nodes))
    nodes = [nodes];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < nodes.size; _id_AC0E594AC96AA3A8++) {
    if(isvector(nodes[_id_AC0E594AC96AA3A8])) {
      struct = spawnStruct();
      struct.origin = nodes[_id_AC0E594AC96AA3A8];
      struct.angles = (0, 0, 0);
      nodes[_id_AC0E594AC96AA3A8] = struct;
    }
  }

  go_to_node_internal(nodes, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25);
}

get_next_node_array() {
  _id_764BDB6FE546DACC = get_linkto_goals();

  if(_id_764BDB6FE546DACC.size < 1) {
    if(isDefined(self.target))
      _id_764BDB6FE546DACC = get_target_goals(self.target);
  }

  return _id_764BDB6FE546DACC;
}

get_target_goals(target) {
  goals = getnodearray(target, "targetname");
  _id_889BE5A52999435E = scripts\engine\utility::getStructArray(target, "targetname");

  foreach(new in _id_889BE5A52999435E)
  goals[goals.size] = new;

  _id_889BE5A52999435E = getEntArray(target, "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_889BE5A52999435E.size; _id_AC0E594AC96AA3A8++) {
    new = _id_889BE5A52999435E[_id_AC0E594AC96AA3A8];

    if(!is_target_goal_valid(new)) {
      continue;
    }
    goals[goals.size] = new;
  }

  return goals;
}

get_linkto_goals() {
  goals = [];

  if(isDefined(self.script_linkto)) {
    linked_ents = scripts\engine\utility::get_linked_ents();
    _id_3D938A1343D65FED = scripts\engine\utility::get_linked_structs();
    _id_789069F44709F226 = scripts\engine\utility::get_linked_nodes();
    goals = scripts\engine\utility::array_combine(linked_ents, _id_3D938A1343D65FED, _id_789069F44709F226);
  }

  return goals;
}

go_to_node_internal(node, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");
  level endon("game_ended");

  if(!isarray(node))
    node = [node];

  thread go_to_node_end();
  _id_A749CE9B52022669 = 0;
  patharrayindex = 0;
  patharray = undefined;
  startnode = node[0];

  for(;;) {
    if(!_id_A749CE9B52022669) {
      node = get_least_used_from_array(node);
      patharray = get_path_array(node, startnode);

      if(patharray.size > 1)
        _id_A749CE9B52022669 = 1;
    }

    self.currentnode = node;

    if(_id_A749CE9B52022669) {
      node = patharray[patharray.size - 1];
      go_through_patharray(patharray, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25);
      patharray = undefined;
      _id_A749CE9B52022669 = 0;
    } else {
      node_fields_pre_goal(node);

      if(isDefined(self.stealth))
        scripts\stealth\callbacks::stealth_call("go_to_node_wait", ::go_to_node_set_goal, node);
      else {
        go_to_node_set_goal(node);
        self waittill("goal");
      }
    }

    node notify("trigger", self);
    node_fields_after_goal(node, _id_D25339A42DEEAC35);
    node_fields_after_goal_skit(node);
    node scripts\engine\utility::script_delay();

    if(isDefined(node.script_flag_wait))
      scripts\engine\utility::flag_wait(node.script_flag_wait);

    if(isDefined(node.script_ent_flag_wait))
      scripts\engine\utility::ent_flag_wait(node.script_ent_flag_wait);

    node scripts\engine\utility::script_wait();
    node_fields_after_goal_and_wait(node, _id_5E38F20C9628AE25);

    if(!isDefined(node.target) && !isDefined(node.script_linkto)) {
      break;
    }

    _id_6EC865F8E82F3AE6 = node get_next_node_array();

    if(!_id_6EC865F8E82F3AE6.size) {
      break;
    }

    node = _id_6EC865F8E82F3AE6;
  }

  self notify("reached_path_end");

  if(isDefined(self.script_forcegoal)) {
    return;
  }
  volume = self getgoalvolume();

  if(isDefined(volume))
    self setgoalvolumeauto(volume, volume get_cover_volume_forward());
}

go_to_node_wait(_id_E2A7566FB8A29355, node) {
  self endon("death");

  if(!go_to_node_should_stop(node)) {
    return;
  }
  if(!istrue(node._id_97C8A15D77788E5A)) {
    if(isDefined(node.target)) {
      self._blackboard.idlenode = node;
      node._id_F8D4ED108521E632 = _func_5D6132045B29BAF5(node.target);
    }

    node._id_97C8A15D77788E5A = 1;
  }

  self[[_id_E2A7566FB8A29355]](node);
  self waittill("goal");

  if(isDefined(node._id_F8D4ED108521E632)) {
    _id_F8D4ED108521E632 = self _meth_92435C7A6AE85C3C();

    if(!isDefined(_id_F8D4ED108521E632))
      self _meth_76B3CFB91EF40B3B(node._id_F8D4ED108521E632);

    self waittill("bseq_user_deleted");
    self._blackboard.idlenode = undefined;

    if(isDefined(node.interaction)) {
      _func_2A627FA5FD1CE263(node._id_F8D4ED108521E632);
      node._id_F8D4ED108521E632 = undefined;
    }
  }
}

get_least_used_from_array(array) {
  if(array.size == 1)
    return array[0];

  array = scripts\engine\utility::array_randomize(array);
  _id_AD98B0B8CE2A6FDE = array[0];

  if(!isDefined(_id_AD98B0B8CE2A6FDE.used_time))
    _id_AD98B0B8CE2A6FDE.used_time = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    node = array[_id_AC0E594AC96AA3A8];

    if(!isDefined(node.used_time))
      node.used_time = 0;

    if(node.used_time < _id_AD98B0B8CE2A6FDE.used_time)
      _id_AD98B0B8CE2A6FDE = node;
  }

  _id_AD98B0B8CE2A6FDE.used_time = gettime();
  return _id_AD98B0B8CE2A6FDE;
}

get_path_array(node, startnode) {
  array = [];
  count = 0;

  for(;;) {
    array[array.size] = node;
    count++;

    if(count == 16) {
      break;
    }

    if(go_to_node_should_stop(node)) {
      break;
    }

    if(!isDefined(node.target) && !isDefined(node.script_linkto)) {
      break;
    }

    _id_6EC865F8E82F3AE6 = node get_next_node_array();

    if(!_id_6EC865F8E82F3AE6.size) {
      break;
    }

    node = get_least_used_from_array(_id_6EC865F8E82F3AE6);

    if(node == startnode) {
      break;
    }
  }

  return array;
}

go_through_patharray(patharray, _id_D25339A42DEEAC35, _id_5E38F20C9628AE25) {
  self setgoalpath(patharray);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < patharray.size; _id_AC0E594AC96AA3A8++) {
    index = _id_AC0E594AC96AA3A8;
    _id_E0386CBFBCCBBC5B = patharray[_id_AC0E594AC96AA3A8];
    self.currentnode = _id_E0386CBFBCCBBC5B;
    node_fields_pre_goal(_id_E0386CBFBCCBBC5B);
    patharrayindex = waittill_subgoal();

    if(index == patharray.size - 1) {
      self waittill("goal");
      break;
    }

    _id_E0386CBFBCCBBC5B notify("trigger", self);
    node_fields_after_goal(_id_E0386CBFBCCBBC5B, _id_D25339A42DEEAC35);
    node_fields_after_goal_skit(_id_E0386CBFBCCBBC5B);
    node_fields_after_goal_and_wait(_id_E0386CBFBCCBBC5B, _id_5E38F20C9628AE25);
  }
}

node_fields_pre_goal(node) {
  if(isDefined(node._id_9FF99CFC426066A2))
    set_goal_radius(node._id_9FF99CFC426066A2);
  else if(isDefined(node.radius))
    set_goal_radius(node.radius);
  else if(isDefined(node.script_radius)) {
    self.script_radius = node.script_radius;
    set_goal_radius(node.script_radius);
  }

  if(isDefined(node.script_goalheight))
    self.goalheight = node.script_goalheight;
  else if(isDefined(node.height))
    self.goalheight = node.height;

  if(isDefined(node.script_demeanor))
    set_demeanor_from_unittype(node.script_demeanor);

  if(istrue(node.script_pacifist) || isDefined(node.spawnflags) && node.spawnflags & 256)
    self.pacifist = 1;

  if(isDefined(node.script_ignoreall))
    self.ignoreall = node.script_ignoreall;

  if(isDefined(node.script_ignoreme))
    self.ignoreme = node.script_ignoreme;

  if(isDefined(node.script_flag_wait) && !scripts\engine\utility::flag_exist(node.script_flag_wait))
    scripts\engine\utility::flag_init(node.script_flag_wait);

  if(isDefined(node.script_flag_set) && !scripts\engine\utility::flag_exist(node.script_flag_set))
    scripts\engine\utility::flag_init(node.script_flag_set);

  if(isDefined(node.script_flag) && !scripts\engine\utility::flag_exist(node.script_flag))
    scripts\engine\utility::flag_init(node.script_flag);

  if(isDefined(node.script_deathflag)) {
    if(!scripts\engine\utility::flag_exist(node.script_deathflag))
      scripts\engine\utility::flag_init(node.script_deathflag);

    delay = 5;

    if(isDefined(node._id_3DE4F31275C86745))
      delay = node._id_3DE4F31275C86745;

    thread scripts\engine\utility::thread_on_notify_no_endon_death("death", scripts\engine\utility::flag_set_delayed, node.script_deathflag, delay);
  }

  if(isDefined(node.script_speed))
    scripts\engine\utility::set_movement_speed(node.script_speed);
}

node_fields_after_goal(node, _id_D25339A42DEEAC35) {
  if(isDefined(self.stealth))
    scripts\stealth\callbacks::stealth_call("go_to_node_arrive", ::go_to_node_set_goal, node);

  go_to_node_wait(::go_to_node_set_goal, node);

  if(isDefined(_id_D25339A42DEEAC35))
    [[_id_D25339A42DEEAC35]](node);

  if(isDefined(node.script_flag_set))
    scripts\engine\utility::flag_set(node.script_flag_set);

  if(isDefined(node.script_ent_flag_set))
    scripts\engine\utility::ent_flag_set(node.script_ent_flag_set);

  if(isDefined(node.script_flag_clear))
    scripts\engine\utility::flag_clear(node.script_flag_clear);
}

node_fields_after_goal_skit(node) {
  level endon("game_ended");
  self endon("death");

  if(!istrue(level.global_stealth_broken) && !istrue(self.entered_combat) && isDefined(node.script_animation_type)) {
    _id_DD1921916C4E99C7 = undefined;
    _id_4B7479AE0DF07570 = strtok(node.script_animation_type, ",");
    _id_DD1921916C4E99C7 = scripts\engine\utility::random(_id_4B7479AE0DF07570);

    if(isDefined(_id_DD1921916C4E99C7)) {
      if(!istrue(node.script_looping))
        self.single_loop = 1;
      else
        self.single_loop = undefined;

      self.playing_skit = 1;
      play_skit_and_watch_for_endons(node, _id_DD1921916C4E99C7);
      self.playing_skit = undefined;

      while(istrue(self.playing_skit))
        wait 0.05;
    }
  }
}

play_skit_and_watch_for_endons(node, _id_DD1921916C4E99C7) {
  self endon("death");

  if(istrue(self.single_loop))
    self endon("patrol_" + _id_DD1921916C4E99C7 + "_loop");

  set_goal_pos(node.origin);
  self thread[[level.spawn_skits[_id_DD1921916C4E99C7].skit_func]]();

  while(istrue(self.playing_skit))
    wait 0.05;
}

node_fields_after_goal_and_wait(node, _id_5E38F20C9628AE25) {
  if(isDefined(self.stealth))
    scripts\stealth\callbacks::stealth_call("go_to_node_post_wait", ::go_to_node_set_goal, node);

  if(isDefined(node.script_soundalias)) {
    if(soundexists(node.script_soundalias))
      self playSound(node.script_soundalias);
  }

  if(isDefined(node.script_forcegoal))
    set_goal_radius(node.script_forcegoal);

  if(isDefined(self.post_wait_func))
    [[self.post_wait_func]]();

  if(isDefined(node.script_delay_post))
    wait(node.script_delay_post);

  while(isDefined(node.script_requires_player)) {
    node.script_requires_player = 0;

    if(go_to_node_wait_for_player(node, ::get_next_node_array)) {
      node.script_requires_player = 1;
      node notify("script_requires_player");
      break;
    }

    wait 0.25;
  }

  if(isDefined(node.script_demeanor_post))
    set_demeanor_from_unittype(node.script_demeanor_post);

  if(isDefined(_id_5E38F20C9628AE25))
    [[_id_5E38F20C9628AE25]](node);

  if(isDefined(node.script_death) && node.script_death)
    script_kill_ai();

  if(isDefined(node.script_delete) && node.script_delete)
    self delete();
}

go_to_node_wait_for_player(node, _id_98EA791865528A70) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    player = level.players[_id_AC0E594AC96AA3A8];

    if(distancesquared(player.origin, node.origin) < distancesquared(self.origin, node.origin))
      return 1;

    if(!isDefined(node.script_dist_only)) {
      _id_06A3A1033FFC2699 = anglesToForward(self.angles);

      if(isDefined(node.target)) {
        temp = node[[_id_98EA791865528A70]](node.target);

        if(temp.size == 1)
          _id_06A3A1033FFC2699 = vectorNormalize(temp[0].origin - node.origin);
        else if(isDefined(node.angles))
          _id_06A3A1033FFC2699 = anglesToForward(node.angles);
      } else if(isDefined(node.angles))
        _id_06A3A1033FFC2699 = anglesToForward(node.angles);

      _id_9601C525B7890A11 = [];
      _id_9601C525B7890A11[_id_9601C525B7890A11.size] = vectorNormalize(player.origin - self.origin);

      foreach(value in _id_9601C525B7890A11) {
        if(vectordot(_id_06A3A1033FFC2699, value) > 0)
          return 1;
      }
    }

    dist = 300;

    if(node.script_requires_player > dist)
      dist = node.script_requires_player;

    if(distancesquared(player.origin, self.origin) < squared(dist))
      return 1;

    return 0;
  }
}

waittill_subgoal() {
  self endon("goal");
  self waittill("subgoal", index);
  return index;
}

go_to_node_should_stop(_id_9DA7DD4834E89D17) {
  if(!isDefined(_id_9DA7DD4834E89D17))
    return 1;

  if(!isDefined(_id_9DA7DD4834E89D17.target))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay_min))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay_max))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait_add))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait_min))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_wait_max))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_flag_wait))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_ent_flag_wait))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_delay_post))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_requires_player))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_idle))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.script_stopnode))
    return 1;

  if(isDefined(_id_9DA7DD4834E89D17.interaction))
    return 1;

  return 0;
}

get_cover_volume_forward() {
  if(isDefined(self.goalvolumecoveryaw))
    return anglesToForward((0, self.goalvolumecoveryaw, 0));
  else
    return undefined;
}

go_to_node_set_goal(ent) {
  if(isnode(ent))
    go_to_node_set_goal_node(ent);
  else if(isstruct(ent))
    go_to_node_set_goal_pos(ent);
  else if(isent(ent))
    go_to_node_set_goal_ent(ent);

  if(isstruct(ent) || isnode(ent))
    ent.patrol_stop = go_to_node_should_stop(ent);
}

go_to_node_set_goal_ent(ent) {
  if(ent.code_classname == "info_volume") {
    self setgoalvolumeauto(ent, ent get_cover_volume_forward());
    self notify("go_to_node_new_goal");
    return;
  }

  go_to_node_set_goal_pos(ent);
}

go_to_node_set_goal_pos(ent) {
  set_goal_ent(ent);
  self notify("go_to_node_new_goal");
}

enter_combat_after_go_to_node(spawnpoint) {
  level endon("game_ended");
  self endon("death");
  spawnpoint scripts\engine\utility::script_wait();
  go_to_node(self.spawnpoint get_next_node_array());
  thread enter_combat();
}

set_goal_ent(target) {
  set_goal_pos(target.origin);
  self.last_set_goalent = target;

  if(isstruct(target) && !isDefined(target.type))
    target.type = "struct";
}

set_goal_pos(origin) {
  if(istrue(self.fixednode)) {
    return;
  }
  if(istrue(self._id_1BD24C17AEE24DCE)) {
    return;
  }
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = origin;
  self.last_set_goalent = undefined;
  self setgoalpos(getclosestpointonnavmesh(origin));
  self notify("new_goal_pos");
}

go_to_node_set_goal_node(node) {
  set_goal_node(node);
  self notify("go_to_node_new_goal");
}

set_goal_node(node) {
  self.last_set_goalnode = node;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(node);
}

go_to_node_end() {
  self notify("go_to_node_end");
  self endon("go_to_node_end");
  self endon("death");
  level endon("game_ended");
  self.using_goto_node = 1;
  result = scripts\engine\utility::waittill_any_return_2("reached_path_end", "stop_going_to_node");
  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
  thread _id_480F99299B4CBC38();
}

_id_480F99299B4CBC38() {
  self endon("death");

  if(isDefined(self.currentnode) && isDefined(self.currentnode._id_F8D4ED108521E632) && isDefined(self.currentnode.interaction)) {
    if(isDefined(self _meth_92435C7A6AE85C3C()))
      self waittill("bseq_user_deleted");

    _func_2A627FA5FD1CE263(self.currentnode._id_F8D4ED108521E632);
    self.currentnode._id_F8D4ED108521E632 = undefined;
  }
}

is_target_goal_valid(object) {
  if(isspawner(object))
    return 0;

  switch (object.code_classname) {
    case "trigger_once":
    case "trigger_multiple":
    case "trigger_radius":
    case "misc_turret":
      return 0;
  }

  return 1;
}

set_goal_radius(goal_radius) {
  if(istrue(self._id_42DD56E19557F95A)) {
    return;
  }
  if(!isDefined(goal_radius))
    goal_radius = 2048;

  goal_radius = getdvarint("dvar_321CACFB0DBA94E2", goal_radius);
  self.last_goalradius = self.goalradius;
  self.goalradius = int(goal_radius);
}

return_to_last_goalRadius() {
  if(isDefined(self.last_goalradius))
    set_goal_radius(self.last_goalradius);
}

set_goal_pos_check_for_offset(origin) {
  if(isDefined(self.script_origin_other))
    origin = self.script_origin_other;

  set_goal_pos(origin);
}

module_set_goal_radius(_id_F8E5E3AA5762A8E7, goal_radius) {
  set_goal_radius(goal_radius);
}

module_set_goal_height(_id_F8E5E3AA5762A8E7, goalheight) {
  self.goalheight = goalheight;
}

set_script_origin_other_on_ai(origin) {
  self.script_origin_other = origin;
}

clear_script_origin_other_on_ai(origin) {
  self.script_origin_other = undefined;
}

modular_spawning_debug_init() {
  delay_start_specified_module();
  setDvar("dvar_B3B5329386B31BFC", 0);
  setdvarifuninitialized("dvar_76EC06326708E615", 0);
  setdvarifuninitialized("dvar_9758CEC587280B4A", 0);
  setdvarifuninitialized("dvar_9BCCA58E56E4C178", 0);
  setdvarifuninitialized("dvar_67846A0D7AA3030A", 0);
  setdvarifuninitialized("dvar_3ED315459BEA5889", "");
  setdvarifuninitialized("dvar_8CC57893708670EA", 0);
  setdvarifuninitialized("dvar_D056B8028AE7261E", 0);
  setdvarifuninitialized("dvar_35DEC012C752370D", 0);
  setdvarifuninitialized("dvar_9E9513E7705385BD", 0);
  setdvarifuninitialized("dvar_B7F5396996295942", 0);
  setdvarifuninitialized("dvar_628DE91EFB80CF77", 0);
  setdvarifuninitialized("dvar_3D7B446D7722D59F", -1);
  setdvarifuninitialized("dvar_41847A5466C0369B", -1);
  setdvarifuninitialized("dvar_D01A3F44BE125516", -1);
  setdvarifuninitialized("dvar_DD0FF23757667151", -1);
  setdvarifuninitialized("dvar_A70FA5936C87D3FF", -1);
  setdvarifuninitialized("dvar_348079AC80B6FBF5", "");
  setdvarifuninitialized("dvar_6E280CADCE9D4064", 0);
  setdvarifuninitialized("dvar_4F27A8AB9BAE330A", 0);
  setdvarifuninitialized("dvar_1C1590ADAF373606", 1);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Agent Stats:1 / Disable:0\" \"togglep scr_show_agent_stats 0\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);

  for(_id_AC0E594AC96AA3A8 = 4; _id_AC0E594AC96AA3A8 < 4 + get_max_agent_count(); _id_AC0E594AC96AA3A8++) {
    _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Agent Stats:1 / e" + _id_AC0E594AC96AA3A8 + ":" + _id_AC0E594AC96AA3A8 + "\" \"togglep scr_show_agent_stats " + _id_AC0E594AC96AA3A8 + "\" \n";
    scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  }

  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Debug / Print Dialogue Aliases\" \"togglep scr_print_dialogue_alias 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Print Spawner Disables:2\" \"togglep scr_print_spawner_disables 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Cleanup Stats:2\" \"togglep scr_show_kill_off_stats 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Pause Spawning:0\" \"togglep scr_pause_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Print Spec Info\" \"togglep scr_show_spawn_spec_info 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Toggle Ambient Spawning\" \"togglep scr_always_on_always 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Disable badpath cleanup:3\" \"togglep scr_disable_bad_path_cleanup 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Teleport Reasons:3\" \"togglep scr_show_teleport_reason 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Use Wave Spawning\" \"togglep scr_wave_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Init Nodes As Spawners\" \"togglep scr_init_cover_node_spawners 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Use Cover Node Spawning\" \"togglep scr_cover_node_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Only Use Passive Spawning\" \"togglep scr_only_passive_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / AI Outline Debug:4\" \"togglep scr_ai_outline_debug 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Cleanup Vehicles:4\" \"set scr_debug_spawning cleanup_vehicles\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Stop All Groups:4\" \"set scr_debug_spawning stop_all_groups\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / whyAmINotShooting\" \"togglep ai_whyaminotshooting 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / whyAmINotMoving\" \"togglep ai_whyaminotmoving 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Stealth / Debug\" \"togglep debug_stealth 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Stealth / Chat\" \"togglep debug_stealth_chat 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / Stealth / fov\" \"togglep debug_stealth_fov 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  level.spawnpoint_debug = 0;
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Toggle:4\" \"set scr_debug_spawning spawnpoint_debug\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Spawnpoint Selection\" \"togglep scr_show_spawn_selection 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Add Proxy Player At Loc:4\" \"set scr_debug_spawning proxy_add_player\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Delete All Proxy Players:4\" \"set scr_debug_spawning proxy_delete_all\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Delete Selected Proxy Player:4\" \"set scr_debug_spawning proxy_delete_selected\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Active Spawn Modules\" \"set scr_debug_spawning show_active_spawn_modules\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
  _id_A5516703B3F7D1FF = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Convert Nodes To Spawners\" \"set scr_debug_spawning convert_nodes\" \n";
  scripts\cp\utility::addentrytodevgui(_id_A5516703B3F7D1FF);
}

print_active_modules_to_screen() {
  level notify("print_active_modules_to_screen");
  level endon("print_active_modules_to_screen");
  level.show_active_modules = !level.show_active_modules;

  if(!level.show_active_modules) {
    if(isDefined(level.menu_background))
      level.menu_background destroy();

    return;
  }

  create_background();

  for(;;) {
    _id_254DDB6B0EDE6C93 = 150;
    _id_5C3387E64D7B054F = " ";
    _id_1C449B3151E45E2F = "|Active| Min| Max|Deaths| Total";
    msg = "Active Modules| Spawn Count: " + level.spawned_ai.size + "/" + get_max_agent_count();
    msg = msg + getsubstr(_id_5C3387E64D7B054F, 0, _id_5C3387E64D7B054F.size - (msg.size + _id_1C449B3151E45E2F.size)) + _id_1C449B3151E45E2F;
    _id_254DDB6B0EDE6C93 = _id_254DDB6B0EDE6C93 + 15;
    _id_162E534872EA0677 = " ";
    _id_3F436DB8D4B31C3F = getsubstr(_id_5C3387E64D7B054F, 0, _id_5C3387E64D7B054F.size - _id_162E534872EA0677.size * 5 - 4);

    if(isDefined(level.spawn_module_structs_memory) && level.spawn_module_structs_memory.size > 0) {
      keys = getarraykeys(level.spawn_module_structs_memory);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
        key = keys[_id_AC0E594AC96AA3A8];
        _id_F564CE57BB79FF69 = level.spawn_module_structs_memory[key];

        for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_F564CE57BB79FF69.size; _id_AC0E5C4AC96AAA41++) {
          group = _id_F564CE57BB79FF69[_id_AC0E5C4AC96AAA41];

          if(key == "wave_spawning") {
            _id_FD12DFCA9E789574 = group scripts\cp\cp_wave_spawning::get_current_wave_ref();
            key = "wave: " + _id_FD12DFCA9E789574;
          }

          data = group get_module_debug_data();

          if(isDefined(level.active_spawn_module_structs) && group is_group_active())
            color = (1, 1, 1);
          else
            color = (1, 1, 0);

          active = add_space_to_string("| A:" + group get_activecount_from_group(1), _id_162E534872EA0677);
          min = add_space_to_string("| m:" + data.min_size, _id_162E534872EA0677);
          max = add_space_to_string("| M:" + data.max_size, _id_162E534872EA0677);
          total = add_space_to_string("| T:" + data.totalspawns, _id_162E534872EA0677);
          deaths = add_space_to_string("| D:" + group.currentmodulekills, _id_162E534872EA0677);
          msg = add_space_to_string(data.status + "|" + key, _id_3F436DB8D4B31C3F) + "[" + _id_AC0E5C4AC96AAA41 + "] " + active + min + max + deaths + total;
          _id_254DDB6B0EDE6C93 = _id_254DDB6B0EDE6C93 + 15;
        }
      }
    }

    waitframe();
  }
}

create_background() {
  level.menu_background = create_hudelem();
  level.menu_background setshader("black", 350, 110);
  level.menu_background.color = (0.2, 0.2, 0.2);
  level.menu_background.alpha = 0.1;
  level.menu_background.sort = -20;
}

create_hudelem(text, x, y, scale, alpha, sort) {
  if(!isDefined(alpha))
    alpha = 1;

  if(!isDefined(scale))
    scale = 1;

  if(!isDefined(sort))
    sort = 20;

  hud = newhudelem();
  hud.location = 0;
  hud.alignx = "left";
  hud.aligny = "middle";
  hud.vertalign = "top";
  hud.horzalign = "left";
  hud.foreground = 1;
  hud.fontscale = 1;
  hud.sort = define_var_if_undefined(sort, 1);
  hud.alpha = define_var_if_undefined(alpha, 0.1);
  hud.x = define_var_if_undefined(x, 0);
  hud.y = define_var_if_undefined(y, 85);
  hud.og_scale = 1;
  hud.archived = 0;

  if(isDefined(text)) {
    hud.text = text;

    if(isnumber(text))
      hud setvalue(text);
    else
      hud clearalltextafterhudelem();
  }

  return hud;
}

add_space_to_string(_id_8CF037AA822B057D, _id_99A110EF2E699143) {
  if(_id_8CF037AA822B057D.size > _id_99A110EF2E699143.size)
    return getsubstr(_id_8CF037AA822B057D, 0, _id_99A110EF2E699143.size);
  else {
    _id_46205307B7B3C8FE = getsubstr(_id_99A110EF2E699143, 0, _id_99A110EF2E699143.size - _id_8CF037AA822B057D.size);

    if(isDefined(_id_46205307B7B3C8FE) && _id_46205307B7B3C8FE.size > 0)
      return _id_8CF037AA822B057D + _id_46205307B7B3C8FE;
    else
      return _id_8CF037AA822B057D;
  }
}

is_group_active() {
  if(isDefined(level.active_spawn_module_structs) && level.active_spawn_module_structs.size > 0) {
    keys = getarraykeys(level.active_spawn_module_structs);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.active_spawn_module_structs.size; _id_AC0E594AC96AA3A8++) {
      key = keys[_id_AC0E594AC96AA3A8];

      if(scripts\engine\utility::array_contains(level.active_spawn_module_structs[key], self))
        return 1;
    }

    return 0;
  } else
    return 0;
}

create_module_debug_struct() {
  struct = spawnStruct();
  struct.status = "running";
  struct.min_size = 0;
  struct.max_size = 0;
  struct.totalspawns = 0;
  self.debug_data = struct;
}

change_module_status(_id_F8E5E3AA5762A8E7, _id_B386118C13EFB928) {}

get_module_debug_data() {
  return self.debug_data;
}

add_global_spawn_function(team, function, param1, param2, param3, param4) {
  if(!isDefined(level.global_ai_func_array))
    level.global_ai_func_array = [];

  if(!isDefined(level.global_ai_func_array[team]))
    level.global_ai_func_array[team] = [];

  func = [];
  func["function"] = function;
  func["param1"] = param1;
  func["param2"] = param2;
  func["param3"] = param3;
  func["param4"] = param4;
  level.global_ai_func_array[team][level.global_ai_func_array[team].size] = func;
}

remove_global_spawn_function(team, function) {
  array = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.global_ai_func_array[team].size; _id_AC0E594AC96AA3A8++) {
    if(level.global_ai_func_array[team][_id_AC0E594AC96AA3A8]["function"] != function)
      array[array.size] = level.global_ai_func_array[team][_id_AC0E594AC96AA3A8];
  }

  level.global_ai_func_array[team] = array;
}

get_passive_wave_high_threshold(group, high_threshold) {
  if(getdvarint("dvar_3D7B446D7722D59F", -1) != -1)
    return getdvarint("dvar_3D7B446D7722D59F");

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.high_threshold))
    return self.passive_wave_settings.high_threshold;
  else {
    if(isDefined(high_threshold))
      return process_module_var(group, high_threshold);

    return undefined;
  }
}

get_passive_wave_low_threshold(group, low_threshold) {
  if(getdvarint("dvar_41847A5466C0369B", -1) != -1)
    return getdvarint("dvar_41847A5466C0369B");

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.low_threshold))
    return self.passive_wave_settings.low_threshold;
  else {
    if(isDefined(low_threshold))
      return process_module_var(group, low_threshold);

    return undefined;
  }
}

get_passive_spawn_window_time(group) {
  if(getdvarint("dvar_413DED1333E47085", 0) != 0)
    return getdvarint("dvar_413DED1333E47085");

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.spawn_window_time))
    return self.passive_wave_settings.spawn_window_time;
  else
    return 5;
}

get_passive_wave_spawn_time(group) {
  if(getdvarint("dvar_D01A3F44BE125516", -1) != -1)
    return getdvarint("dvar_D01A3F44BE125516");

  if(isDefined(self.timeout_after_min_count))
    return self.timeout_after_min_count;

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.wave_spawn_time))
    return self.passive_wave_settings.wave_spawn_time;
  else
    return 15;
}

set_wave_ref_override(_id_061DB077F29AE157) {
  if(is_module_active("wave_spawning")) {
    run_func_on_group_by_groupname("wave_spawning", [::add_wave_overrides_to_module, _id_061DB077F29AE157]);
    _id_18E4128165DBEE65 = get_module_structs_by_groupname("wave_spawning");

    if(isDefined(_id_18E4128165DBEE65) && _id_18E4128165DBEE65.size > 0)
      _id_18E4128165DBEE65[0] thread scripts\cp\cp_wave_spawning::start_wave();
  } else {
    level.first_wave_override = _id_061DB077F29AE157;
    _id_18E4128165DBEE65 = run_spawn_module("wave_spawning");
  }

  return _id_18E4128165DBEE65;
}

add_wave_overrides_to_module(group, _id_061DB077F29AE157) {
  level notify("timeout_wave");
  group notify("wave_spawn");
  group notify("wave_go_kamikaze");
  toggle_force_stop_wave_from_groupname("wave_spawning", undefined, "new_wave_starting");
  toggle_force_stop_wave_from_groupname("wave_paratroopers", undefined, "new_wave_starting");
  run_func_on_group_by_groupname("wave_spawning", [::toggle_kamikaze_for_group, undefined]);
  set_wave_settings_for_all_with_groupname("wave_spawning", _id_061DB077F29AE157, group.wave_reference, group.last_wave_num);
  group.next_wave = _id_061DB077F29AE157;
  group.wave_reference_override = _id_061DB077F29AE157;
}

is_module_active(group_name) {
  return isDefined(level.active_spawn_module_structs[group_name]);
}

get_module_structs_by_groupname(group_name, _id_39B6D9B1EA445B43) {
  _id_7BBDA18A855C7111 = [];

  if(!isarray(group_name))
    group_name = [group_name];

  if(istrue(_id_39B6D9B1EA445B43)) {
    keys = getarraykeys(level.spawn_module_structs_memory);
    array = level.spawn_module_structs_memory;
  } else {
    keys = getarraykeys(level.active_spawn_module_structs);
    array = level.active_spawn_module_structs;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    _id_F564CE57BB79FF69 = array[keys[_id_AC0E594AC96AA3A8]];

    if(isarray(_id_F564CE57BB79FF69)) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_F564CE57BB79FF69.size; _id_AC0E5C4AC96AAA41++) {
        group = _id_F564CE57BB79FF69[_id_AC0E5C4AC96AAA41];

        for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < group_name.size; _id_AC0E5B4AC96AA80E++) {
          if(group.group_name == group_name[_id_AC0E5B4AC96AA80E])
            _id_7BBDA18A855C7111[_id_7BBDA18A855C7111.size] = group;
        }
      }

      continue;
    }

    for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < group_name.size; _id_AC0E5B4AC96AA80E++) {
      if(_id_F564CE57BB79FF69.group_name == group_name[_id_AC0E5B4AC96AA80E])
        _id_7BBDA18A855C7111[_id_7BBDA18A855C7111.size] = _id_F564CE57BB79FF69;
    }
  }

  return _id_7BBDA18A855C7111;
}

get_allowed_vehicle_types_from_spawnpoint(_id_F7A6739C47BA2EE1) {
  _id_7BBDA18A855C7111 = [];

  if(isDefined(self.script_type) && isDefined(_id_F7A6739C47BA2EE1) && isarray(_id_F7A6739C47BA2EE1) && _id_F7A6739C47BA2EE1.size > 0) {
    if(!isarray(self.script_type)) {
      _id_F077ADF688122C36 = strtok(self.script_type, ",");
      self.script_type = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F077ADF688122C36.size; _id_AC0E594AC96AA3A8++)
        self.script_type[self.script_type.size] = _id_F077ADF688122C36[_id_AC0E594AC96AA3A8];
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.script_type.size; _id_AC0E594AC96AA3A8++) {
      if(scripts\engine\utility::array_contains(_id_F7A6739C47BA2EE1, self.script_type[_id_AC0E594AC96AA3A8]))
        _id_7BBDA18A855C7111[_id_7BBDA18A855C7111.size] = self.script_type[_id_AC0E594AC96AA3A8];
    }

    return _id_7BBDA18A855C7111;
  } else
    return _id_F7A6739C47BA2EE1;
}

get_allowed_vehicle_types_from_wave() {
  _id_6D906809844C7CB1 = [];
  keys = getarraykeys(self.valid_vehicles);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < keys.size; _id_AC0E594AC96AA3A8++) {
    if(self.valid_vehicles[keys[_id_AC0E594AC96AA3A8]] > 0)
      _id_6D906809844C7CB1[_id_6D906809844C7CB1.size] = keys[_id_AC0E594AC96AA3A8];
  }

  if(_id_6D906809844C7CB1.size > 0)
    return _id_6D906809844C7CB1;
  else
    return undefined;
}

remove_invalid_aitypes() {
  keys = getarraykeys(self.spawn_aitype_counts);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.spawn_module_structs_memory[self.group_name].size; _id_AC0E594AC96AA3A8++) {
    _id_F564CE57BB79FF69 = level.spawn_module_structs_memory[self.group_name][_id_AC0E594AC96AA3A8];

    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < keys.size; _id_AC0E5C4AC96AAA41++) {
      key = keys[_id_AC0E5C4AC96AAA41];

      if(isDefined(_id_F564CE57BB79FF69.spawn_aitype_counts[key]) && _id_F564CE57BB79FF69.spawn_aitype_counts[key] < 1)
        _id_F564CE57BB79FF69.spawn_aitype_counts[key] = undefined;
    }
  }

  return self.spawn_aitype_counts;
}

set_demeanor_from_unittype(_id_F7EE87DC76B45E62) {
  _id_F7EE87DC76B45E62 = validate_demeanor(_id_F7EE87DC76B45E62);

  if(is_specified_unittype("civilian"))
    scripts\asm\asm_bb::bb_setcivilianstate(_id_F7EE87DC76B45E62);
  else if(!is_specified_unittype("juggernaut"))
    scripts\common\utility::demeanor_override(_id_F7EE87DC76B45E62);
}

validate_demeanor(_id_F7EE87DC76B45E62) {
  switch (_id_F7EE87DC76B45E62) {
    case "casual":
    case "casual_gun":
      return "patrol";
    default:
      return _id_F7EE87DC76B45E62;
  }
}

init_trigger_spawn_groups() {
  level endon("game_ended");
  register_trigger_func("run_spawn_module", ::trigger_run_spawn_module, ::register_triggered_module);
  register_trigger_func("run_spawn_module_looping", ::trigger_run_module_once, ::register_triggered_looping_module);
  register_trigger_func("run_spawn_module_infinite", ::trigger_run_module_once, ::register_triggered_infinite_module);
  register_trigger_func("run_spawn_module_timeout_loop", ::trigger_run_module_once, ::register_triggered_timeout_module);
  register_trigger_func("run_spawn_module_list", ::trigger_choose_func_from_list, ::register_triggered_timeout_module);
  scripts\engine\utility::flag_wait("level_ready_for_script");
  _id_26CD5FAD08ECB98E = getEntArray("trigger_spawner", "targetname");

  foreach(trigger in _id_26CD5FAD08ECB98E) {
    if(isDefined(trigger.target) && isDefined(trigger.script_function)) {
      [[run_triggered_module_registration(trigger.script_function)]](trigger);
      trigger thread run_script_func_when_triggered(trigger);
    }
  }
}

run_triggered_module_registration(ref) {
  if(isDefined(level.trigger_spawn_module_func[ref]))
    return level.trigger_spawn_module_func[ref];
  else
    return::register_triggered_module;
}

register_triggered_timeout_module(trigger) {
  _id_AAE412DAADFC9729 = scripts\engine\utility::getStructArray(trigger.target, "targetname");
  total_spawns = scripts\engine\utility::ter_op(isDefined(trigger.script_count), int(trigger.script_count), undefined);
  _id_3525E3C3B2304C40 = scripts\engine\utility::ter_op(isDefined(trigger.script_count_min), int(trigger.script_count_min), 0);
  max_spawns = scripts\engine\utility::ter_op(isDefined(trigger.script_count_max), int(trigger.script_count_max), _id_AAE412DAADFC9729.size);
  registerambientgroup(trigger.target, _id_3525E3C3B2304C40, max_spawns, total_spawns, [::wait_time_from_active_count, 0.25, 5, 0.8], undefined, trigger.target, undefined, trigger.target, 30);
  set_spawn_scoring_params_for_group(trigger.target, undefined, undefined, trigger.script_maxdist, undefined);
}

wait_time_from_active_count(group, min_time, max_time, _id_26226E6C4819E205) {
  _id_3260FE8E5DBC524B = group.activecount;
  max_count = process_module_var(group, group.max_size);

  if(_id_3260FE8E5DBC524B / max_count >= _id_26226E6C4819E205)
    return max_time;
  else
    return min_time;
}

register_triggered_infinite_module(trigger) {
  _id_AAE412DAADFC9729 = scripts\engine\utility::getStructArray(trigger.target, "targetname");
  registerambientgroup(trigger.target, 0, _id_AAE412DAADFC9729.size, undefined, 0.25, undefined, trigger.target, undefined, undefined, undefined);
  set_spawn_scoring_params_for_group(trigger.target, undefined, undefined, trigger.script_maxdist, undefined);
}

register_triggered_looping_module(trigger) {
  _id_AAE412DAADFC9729 = scripts\engine\utility::getStructArray(trigger.target, "targetname");
  registerambientgroup(trigger.target, 0, _id_AAE412DAADFC9729.size, _id_AAE412DAADFC9729.size, 0.25, ::wait_for_all_group_dead, trigger.target, undefined, trigger.target, undefined);
  set_spawn_scoring_params_for_group(trigger.target, undefined, undefined, trigger.script_maxdist, undefined);
}

register_triggered_module(trigger) {
  _id_AAE412DAADFC9729 = scripts\engine\utility::getStructArray(trigger.target, "targetname");
  registerambientgroup(trigger.target, 0, _id_AAE412DAADFC9729.size, _id_AAE412DAADFC9729.size, 0.25, undefined, trigger.target, undefined, undefined, undefined);
  set_spawn_scoring_params_for_group(trigger.target, undefined, undefined, trigger.script_maxdist, undefined);
}

register_trigger_func(ref, trigger_func, _id_BAFC9E49CDA911E4) {
  if(!isDefined(level.trigger_spawn_func))
    level.trigger_spawn_func = [];

  if(!isDefined(level.trigger_spawn_module_func))
    level.trigger_spawn_module_func = [];

  level.trigger_spawn_func[ref] = trigger_func;
  level.trigger_spawn_module_func[ref] = _id_BAFC9E49CDA911E4;
}

run_script_func_when_triggered(trigger) {
  trigger notify("run_script_func_when_triggered");
  trigger endon("run_script_func_when_triggered");
  trigger endon("death");
  level endon("game_ended");
  trigger scripts\engine\utility::thread_on_notify("disable_trigger", scripts\engine\utility::trigger_off);

  if(!isDefined(level.trigger_spawn_func)) {
    trigger notify("disable_trigger");
    return;
  }

  if(!isDefined(level.trigger_spawn_func[trigger.script_function])) {
    trigger notify("disable_trigger");
    return;
  }

  func = level.trigger_spawn_func[trigger.script_function];

  for(;;) {
    trigger waittill("trigger", triggering_ent);

    if(isPlayer(triggering_ent))
      [[func]](trigger, triggering_ent);
  }
}