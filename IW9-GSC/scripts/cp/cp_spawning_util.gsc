/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_spawning_util.gsc
***********************************************/

enable_juggernaut_move_behavior(group) {
  if(_id_18A73A64992DD07D::is_specified_unittype("juggernaut"))
    self._id_C833409FB72D15FB = 0;
}

disable_juggernaut_move_behavior(group) {
  if(_id_18A73A64992DD07D::is_specified_unittype("juggernaut"))
    self._id_C833409FB72D15FB = 1;
}

enable_cover_node_behavior(group) {
  self.combatmode = "cover";
}

disable_cover_node_behavior(group) {
  self.combatmode = "no_cover";
}

end_objective_when_all_dead(group, objective, _id_FF5CCEDE2521CB13, _id_D7D8EC6F46377734) {
  group thread end_objective_when_all_dead_interal(group, objective, _id_FF5CCEDE2521CB13, _id_D7D8EC6F46377734);
}

end_objective_when_all_dead_interal(group, _id_B81C89CDE4E926BA, _id_FF5CCEDE2521CB13, _id_D7D8EC6F46377734) {
  level endon("game_ended");
  group waittill("all_group_spawns_dead");

  if(isDefined(_id_FF5CCEDE2521CB13))
    level notify(_id_FF5CCEDE2521CB13);

  if(isDefined(_id_B81C89CDE4E926BA))
    scripts\cp\cp_objectives::debugbeatobjective(_id_B81C89CDE4E926BA);
}

disable_spawner_until_owner_death(spawnpoint) {
  spawnpoint _id_18A73A64992DD07D::disable_spawner();
  scripts\engine\utility::waittill_any_ents(self, "death", self.group, "death");
  spawnpoint _id_18A73A64992DD07D::_id_EC648F2C89EA1C91();
  spawnpoint _id_18A73A64992DD07D::enable_spawner();
}

register_module_for_spawn_owner_disables(group_name) {
  if(isDefined(level.ambientgroups[group_name])) {
    if(isarray(level.ambientgroups[group_name])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[group_name].size; _id_AC0E594AC96AA3A8++)
        level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].disable_spawners_until_owner_death = 1;
    } else
      level.ambientgroups[group_name].disable_spawners_until_owner_death = 1;
  }
}

register_grenade_settings_for_module(_id_CA8D3101C7736449, grenade_types, grenade_chances) {
  if(grenade_types.size != grenade_chances.size) {
    return;
  }
  if(isDefined(level.ambientgroups[_id_CA8D3101C7736449])) {
    if(isarray(level.ambientgroups[_id_CA8D3101C7736449])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[_id_CA8D3101C7736449].size; _id_AC0E594AC96AA3A8++) {
        level.ambientgroups[_id_CA8D3101C7736449][_id_AC0E594AC96AA3A8].grenade_types = grenade_types;
        level.ambientgroups[_id_CA8D3101C7736449][_id_AC0E594AC96AA3A8].grenade_chances = grenade_chances;
      }
    }
  }
}

get_spawncount_from_groupnames(_id_42DCA3C7ABC17220) {
  _id_82E31BFBE50BBE23 = 0;

  if(!isarray(_id_42DCA3C7ABC17220))
    _id_42DCA3C7ABC17220 = [_id_42DCA3C7ABC17220];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_42DCA3C7ABC17220.size; _id_AC0E594AC96AA3A8++) {
    group_name = _id_42DCA3C7ABC17220[_id_AC0E594AC96AA3A8];
    _id_82E31BFBE50BBE23 = _id_82E31BFBE50BBE23 + _id_18A73A64992DD07D::get_spawn_count_from_groupname(group_name);
  }

  return _id_82E31BFBE50BBE23;
}

module_disables_spawners_until_owner_death() {
  return istrue(self.disable_spawners_until_owner_death);
}

combine_module_counters(group, combined_alias) {
  if(!isDefined(level.combined_counters_groups[combined_alias]))
    level.combined_counters_groups[combined_alias] = [];

  level.combined_counters_groups[combined_alias][level.combined_counters_groups[combined_alias].size] = group;
  group.combined_alias = combined_alias;
}

remove_group_from_combined_module_counters(group) {
  combined_alias = group get_has_combined_counters_alias();
  group.combined_alias = undefined;

  if(!isDefined(combined_alias)) {
    return;
  }
  if(isDefined(level.combined_counters_groups[combined_alias]))
    level.combined_counters_groups[combined_alias] = scripts\engine\utility::array_remove(level.combined_counters_groups[combined_alias], group);

  if(isDefined(level.combined_counters_groups[combined_alias]) && level.combined_counters_groups[combined_alias].size < 1)
    level.combined_counters_groups[combined_alias] = undefined;
}

group_has_combined_counters(group_name) {
  _id_C43C439E2DF8BD7C = _id_18A73A64992DD07D::get_module_structs_by_groupname(group_name);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C43C439E2DF8BD7C.size; _id_AC0E594AC96AA3A8++) {
    _id_F564CE57BB79FF69 = _id_C43C439E2DF8BD7C[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_F564CE57BB79FF69.combined_alias))
      return 1;
  }

  return 0;
}

get_has_combined_counters_alias() {
  return self.combined_alias;
}

register_module_init_func(group_name, _id_4262A8E7C176383D) {
  if(isarray(level.ambientgroups[group_name])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[group_name].size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_init_funcs))
        level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_init_funcs = [];

      level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_init_funcs[level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_init_funcs.size] = _id_4262A8E7C176383D;
    }
  } else {
    if(!isDefined(level.ambientgroups[group_name].module_init_funcs))
      level.ambientgroups[group_name].module_init_funcs = [];

    level.ambientgroups[group_name].module_init_funcs[level.ambientgroups[group_name].module_init_funcs.size] = _id_4262A8E7C176383D;
  }
}

register_module_died_poorly_func(group_name, _id_4262A8E7C176383D) {
  if(isarray(level.ambientgroups[group_name])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[group_name].size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].died_poorly_funcs))
        level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].died_poorly_funcs = [];

      level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].died_poorly_funcs[level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].died_poorly_funcs.size] = _id_4262A8E7C176383D;
    }
  } else {
    if(!isDefined(level.ambientgroups[group_name].died_poorly_funcs))
      level.ambientgroups[group_name].died_poorly_funcs = [];

    level.ambientgroups[group_name].died_poorly_funcs[level.ambientgroups[group_name].died_poorly_funcs.size] = _id_4262A8E7C176383D;
  }
}

run_module_init_funcs_on_module_struct() {
  if(isDefined(self.level_module_struct)) {
    data = self.level_module_struct;

    if(isDefined(data.module_init_funcs)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < data.module_init_funcs.size; _id_AC0E594AC96AA3A8++)
        _id_18A73A64992DD07D::process_module_var(self, data.module_init_funcs[_id_AC0E594AC96AA3A8]);
    }
  }
}

register_module_pause_unpause_funcs(group_name, _id_1086C97FECF7918C, _id_AD862214224FFD6F) {
  if(isarray(level.ambientgroups[group_name])) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.ambientgroups[group_name].size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_pause_funcs))
        level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_pause_funcs = [];

      level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_pause_funcs[level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_pause_funcs.size] = _id_1086C97FECF7918C;

      if(!isDefined(level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_unpause_funcs))
        level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_unpause_funcs = [];

      level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_unpause_funcs[level.ambientgroups[group_name][_id_AC0E594AC96AA3A8].module_unpause_funcs.size] = _id_AD862214224FFD6F;
    }
  } else {
    if(!isDefined(level.ambientgroups[group_name].module_pause_funcs))
      level.ambientgroups[group_name].module_pause_funcs = [];

    level.ambientgroups[group_name].module_pause_funcs[level.ambientgroups[group_name].module_pause_funcs.size] = _id_1086C97FECF7918C;

    if(!isDefined(level.ambientgroups[group_name].module_unpause_funcs))
      level.ambientgroups[group_name].module_unpause_funcs = [];

    level.ambientgroups[group_name].module_unpause_funcs[level.ambientgroups[group_name].module_unpause_funcs.size] = _id_AD862214224FFD6F;
  }
}

run_module_pause_funcs() {
  if(isDefined(self.level_module_struct)) {
    data = self.level_module_struct;

    if(isDefined(data.module_pause_funcs)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < data.module_pause_funcs.size; _id_AC0E594AC96AA3A8++)
        _id_18A73A64992DD07D::process_module_var(self, data.module_pause_funcs[_id_AC0E594AC96AA3A8]);
    }
  }
}

run_module_unpause_funcs() {
  if(isDefined(self.level_module_struct)) {
    data = self.level_module_struct;

    if(isDefined(data.module_unpause_funcs)) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < data.module_unpause_funcs.size; _id_AC0E594AC96AA3A8++)
        _id_18A73A64992DD07D::process_module_var(self, data.module_unpause_funcs[_id_AC0E594AC96AA3A8]);
    }
  }
}

cp_is_point_in_front(point) {
  dot = 0;

  if(isent(self) && isPlayer(self)) {
    _id_485B74CB677A51A9 = point - self getorigin();
    forward = anglesToForward(self getplayerangles(1));
    dot = vectordot(_id_485B74CB677A51A9, forward);
  } else {
    if(isDefined(self.angles))
      angles = self.angles;
    else
      angles = (0, 0, 0);

    _id_485B74CB677A51A9 = point - self.origin;
    forward = anglesToForward(angles);
    dot = vectordot(_id_485B74CB677A51A9, forward);
  }

  return dot > 0;
}

cp_is_point_on_right(point) {
  dot = 0;

  if(isPlayer(self)) {
    _id_485B74CB677A51A9 = point - self getorigin();
    right = anglestoright(self getplayerangles(1));
    dot = vectordot(_id_485B74CB677A51A9, right);
  } else {
    if(isDefined(self.angles))
      angles = self.angles;
    else
      angles = (0, 0, 0);

    _id_485B74CB677A51A9 = point - self.origin;
    right = anglestoright(angles);
    dot = vectordot(_id_485B74CB677A51A9, right);
  }

  return dot > 0;
}

create_agent_definition(_id_33310780E8A5996D) {
  level.agent_definition[_id_33310780E8A5996D] = [];
  level.agent_definition[_id_33310780E8A5996D]["animclass"] = "soldier";
  level.agent_definition[_id_33310780E8A5996D]["asm"] = "soldier";
  level.agent_definition[_id_33310780E8A5996D]["behaviorTree"] = "soldier_agent";
  level.agent_definition[_id_33310780E8A5996D]["health"] = 150;
  level.agent_definition[_id_33310780E8A5996D]["height"] = 70;
  level.agent_definition[_id_33310780E8A5996D]["radius"] = 15;
  level.agent_definition[_id_33310780E8A5996D]["reward"] = 100;
  level.agent_definition[_id_33310780E8A5996D]["setup_func"] = ::new_agent_def_main;
  level.agent_definition[_id_33310780E8A5996D]["setup_model_func"] = ::fake_agent_model_setup;
  level.agent_definition[_id_33310780E8A5996D]["species"] = "human";
  level.agent_definition[_id_33310780E8A5996D]["team"] = "axis";
  level.agent_definition[_id_33310780E8A5996D]["traversal_unit_type"] = "soldier";
  level.agent_definition[_id_33310780E8A5996D]["xp"] = 50;
}

new_agent_def_main() {
  self.additionalassets = "";
  self.subclass = "regular";
  self.defaultcoverselector = "cover_default";
  self.enemyselector = "enemyselector_default_cp";
  self.unittype = "soldier";
  self setengagementmindist(256.0, 0.0);
  self setengagementmaxdist(768.0, 1024.0);
  self.accuracy = 0.2;

  switch (scripts\code\character::get_random_weapon(3)) {
    case 0:
      self.weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_ar_akilo47_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 1:
      self.weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_ar_falpha_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
    case 2:
      self.weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_ar_falima_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
      break;
  }

  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = makeweapon("frag_grenade_mp");
  self.grenadeammo = 2;
}

fake_agent_model_setup(agent_type) {
  self.animationarchetype = "soldier";
  self.voice = "alqatala";
  self setModel("body_spetsnaz_ar");
  self attach("head_russian_army_balaclava_1", "", 1);
  self.headmodel = "head_russian_army_balaclava_1";
}

add_spawn_disable_struct(_id_4F5F8BF103FB2A4A, _id_30167C0AAC0D44F6) {
  struct = spawnStruct();
  struct.origin = _id_4F5F8BF103FB2A4A;
  struct.radius = _id_30167C0AAC0D44F6;
  struct scripts\engine\flags::assign_unique_id();
  level.spawner_poison_structs[struct.unique_id] = struct;
  return struct.unique_id;
}

remove_spawn_disable_struct(unique_id) {
  if(isDefined(level.spawner_poison_structs[unique_id]))
    level.spawner_poison_structs[unique_id] = undefined;
}

toggle_player_pos_memory(_id_E3108E412AFB3811) {
  level.skip_player_pos_memory = _id_E3108E412AFB3811;
}

adjust_player_pos_memory_array_size(_id_6302CA9978061647) {
  if(isDefined(_id_6302CA9978061647))
    level.disable_recent_area_memory = _id_6302CA9978061647;
  else
    level.disable_recent_area_memory = undefined;
}

get_module_spawn_points() {
  _id_7BBDA18A855C7111 = [];
  spawners = _id_18A73A64992DD07D::process_module_var(self, self.spawn_points);
  return spawners;
}

set_recent_spawn_time_threshold_override(_id_F8E5E3AA5762A8E7, threshold) {
  if(isarray(_id_F8E5E3AA5762A8E7)) {
    foreach(struct in _id_F8E5E3AA5762A8E7)
    struct.recent_spawn_threshold = threshold;
  } else
    _id_F8E5E3AA5762A8E7.recent_spawn_threshold = threshold;
}

_id_61FFC6A808C617A0(group_name, time_between_spawns) {
  _id_18E4128165DBEE65 = _id_18A73A64992DD07D::get_module_structs_by_groupname(group_name);

  if(isDefined(_id_18E4128165DBEE65) && _id_18E4128165DBEE65.size > 0) {
    foreach(struct in _id_18E4128165DBEE65) {
      struct.time_between_spawns = time_between_spawns;
      _id_18A73A64992DD07D::process_module_var(struct, struct.time_between_spawns);
    }
  }
}

_id_76D4300CAC6F9381(group_name, min_size) {
  _id_18E4128165DBEE65 = _id_18A73A64992DD07D::get_module_structs_by_groupname(group_name);

  if(isDefined(_id_18E4128165DBEE65) && _id_18E4128165DBEE65.size > 0) {
    foreach(struct in _id_18E4128165DBEE65) {
      struct.min_size = min_size;
      _id_18A73A64992DD07D::process_module_var(struct, struct.min_size);
    }
  }
}

_id_0B905B02B6C7AEA3(group_name, max_size) {
  _id_18E4128165DBEE65 = _id_18A73A64992DD07D::get_module_structs_by_groupname(group_name);

  if(isDefined(_id_18E4128165DBEE65) && _id_18E4128165DBEE65.size > 0) {
    foreach(struct in _id_18E4128165DBEE65) {
      struct.max_size = max_size;
      _id_18A73A64992DD07D::process_module_var(struct, struct.max_size);
    }
  }
}

_id_9F1ADDB4E0FF0121(name, target, max_time, _id_1ADA3EA412535AF3) {
  level endon("game_ended");

  if(isDefined(_id_1ADA3EA412535AF3))
    level endon(_id_1ADA3EA412535AF3);

  if(!isDefined(target))
    target = 1;

  struct = undefined;

  if(isDefined(level.spawn_module_structs_memory[name])) {
    struct = level.spawn_module_structs_memory[name];

    if(isarray(struct))
      struct = struct[0];
  }

  endtime = undefined;

  if(isDefined(max_time)) {
    starttime = gettime();
    endtime = starttime + max_time * 1000;
  }

  if(isDefined(struct) && isDefined(struct.activecount) && struct.activecount > 0) {
    while(struct.activecount > target) {
      if(struct.activecount <= target) {
        break;
      }

      if(isDefined(max_time) && gettime() > endtime) {
        break;
      }

      wait 0.5;
    }
  }
}

_id_5EBBD91D2F142DBC(_id_0DF2F39AFAB3B8B9) {
  level endon("game_ended");

  if(!scripts\engine\utility::flag_exist("pause_trigger_spawn"))
    scripts\engine\utility::flag_init("pause_trigger_spawn");

  if(!scripts\engine\utility::flag_exist("disable_trigger_spawn"))
    scripts\engine\utility::flag_init("disable_trigger_spawn");

  scripts\engine\utility::flag_wait("level_ready_for_script");
  triggers = getEntArray("trigger_rotatable_radius", "classname");

  foreach(trigger in triggers) {
    if(!isDefined(trigger.struct) || !isDefined(trigger.struct.spawnflags)) {
      continue;
    }
    if(isDefined(trigger.init)) {
      continue;
    }
    _id_EB527018293A50ED = trigger.struct.spawnflags & 32;
    _id_A47DFA9BE97584D9 = trigger.struct.spawnflags & 16;

    if(_id_EB527018293A50ED) {
      if(_id_A47DFA9BE97584D9) {
        trigger thread _id_173D5FA8D42BA233();
        trigger.init = 1;
        continue;
      }

      trigger thread trigger_spawn_init();
      trigger.init = 1;
    }
  }
}

trigger_spawn_init(_id_0DF2F39AFAB3B8B9) {
  self.spawners = scripts\engine\utility::getStructArray(self.target, "targetname");
  thread trigger_spawn(_id_0DF2F39AFAB3B8B9);
}

trigger_spawn(_id_0DF2F39AFAB3B8B9) {
  self endon("death");
  level endon("game_ended");
  trigger_wait();
  _id_81B8EDC3CB076FDA(self.spawners);
  wait 1;
  self delete();
}

_id_81B8EDC3CB076FDA(spawners, _id_9BD8D35E5CF10D81) {
  _id_BFE291B401A9BF2A = spawners;
  _id_0A9022DCDDC38CFA = [];

  if(!isarray(spawners))
    _id_BFE291B401A9BF2A = [spawners];

  spawngroup = _id_BFE291B401A9BF2A[0].targetname;
  _id_9427293C1EEE7DEB = getdvarint("dvar_1E189DD1AC99D6D2", 0);

  foreach(spawner in _id_BFE291B401A9BF2A) {
    if(_id_9427293C1EEE7DEB)
      soldier = spawner _id_18A73A64992DD07D::spawn_ai();
    else
      soldier = _id_18A73A64992DD07D::_id_7736C252AD19C782(undefined, spawner, undefined, 1);

    if(!isDefined(soldier)) {
      _id_262683DEEA02353A = 0;

      while(_id_262683DEEA02353A < 3) {
        if(_id_9427293C1EEE7DEB)
          soldier = spawner _id_18A73A64992DD07D::spawn_ai();
        else
          soldier = _id_18A73A64992DD07D::_id_7736C252AD19C782(undefined, spawner, undefined, 1);

        if(!isDefined(soldier)) {
          wait 0.1;
          _id_262683DEEA02353A++;
          continue;
        }

        break;
      }
    }

    if(!isDefined(soldier)) {
      continue;
    }
    _id_0A9022DCDDC38CFA[_id_0A9022DCDDC38CFA.size] = soldier;

    if(isDefined(level._id_7A9F066F79BED633))
      soldier thread[[level._id_7A9F066F79BED633]]();

    if(istrue(self._id_9E5F6CA242B92628) || istrue(spawner._id_9E5F6CA242B92628) || isDefined(spawner.spawnflags) && spawner.spawnflags & 4)
      soldier thread scripts\cp\coop_stealth::run_common_functions(soldier, 1, 1);

    if(getdvarint("dvar_5890E41DBBF58B87", 0) != 0 && !istrue(soldier scripts\cp\utility::isjuggernaut())) {
      soldier.maxhealth = getdvarint("dvar_5890E41DBBF58B87");
      soldier.health = soldier.maxhealth;
    }

    soldier.targetname = spawngroup;

    if(isDefined(soldier.target))
      soldier thread _id_18A73A64992DD07D::go_to_node();
  }

  if(istrue(_id_9BD8D35E5CF10D81))
    return _id_0A9022DCDDC38CFA;

  self delete();
  return _id_0A9022DCDDC38CFA;
}

_id_173D5FA8D42BA233() {
  self.spawners = scripts\engine\utility::getStructArray(self.target, "targetname");
  _id_E1884B3C25B85AF8();
}

_id_E1884B3C25B85AF8(_id_0DF2F39AFAB3B8B9) {
  self endon("death");
  level endon("game_ended");
  trigger_wait();

  foreach(spawner in self.spawners)
  thread _id_94E3A9862B435632(spawner);

  self delete();
}

_id_94E3A9862B435632(_id_E1422566503D1E2F, _id_5B8046E7D2F07129) {
  if(getDvar("dvar_742CAA13B3C2E685") == "1") {
    return;
  }
  riders = [];
  _id_65119E62F62616E1 = "axis";

  if(isDefined(_id_E1422566503D1E2F.spawngroup)) {
    if(isDefined(level._id_ED8B3892702336D7))
      level[[level._id_ED8B3892702336D7]](_id_E1422566503D1E2F);

    spawngroup = _id_E1422566503D1E2F.spawngroup;
    spawners = scripts\engine\utility::getStructArray(_id_E1422566503D1E2F.spawngroup, "targetname");

    if(!spawners.size && isDefined(_id_5B8046E7D2F07129) || isDefined(_id_5B8046E7D2F07129) && istrue(_id_E1422566503D1E2F._id_079A88FDCF2BBDD5))
      spawners = _id_5B8046E7D2F07129;

    foreach(index, spawner in spawners) {
      spawner.script_demeanor = undefined;
      rider = _id_18A73A64992DD07D::_id_7736C252AD19C782(undefined, spawner, undefined, 1);

      if(isDefined(rider)) {
        _id_65119E62F62616E1 = rider.team;

        if(isDefined(spawner.script_startingposition))
          rider.script_startingposition = int(spawner.script_startingposition);
        else {
          rider.script_startingposition = index;
          rider.spawner.script_startingposition = index;
        }

        if(isDefined(level._id_7A9F066F79BED633))
          rider thread[[level._id_7A9F066F79BED633]]();

        rider.vehicle_position = rider.script_startingposition;
        riders[riders.size] = rider;

        if(rider.script_startingposition == 0) {
          if(isDefined(rider.nocorpse))
            rider._id_58CC857EE7806CBF = rider.nocorpse;

          rider.nocorpse = 1;
        }
      }

      waitframe();
    }
  }

  _id_FA890E641F17EA50 = _id_30C929B6490AAA38(_id_E1422566503D1E2F);
  _id_E1422566503D1E2F._id_F16652E1462A3739 = 1;

  if(_id_FA890E641F17EA50 == "little_bird")
    _id_E1422566503D1E2F.vehicletype = "veh9_mil_air_heli_medium_physics_mp";
  else if(_id_FA890E641F17EA50 == "veh9_techo_rebel_armor")
    _id_E1422566503D1E2F.vehicletype = "veh9_techo_physics_cp";

  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(_id_FA890E641F17EA50, _id_E1422566503D1E2F);
  vehicle.vehicle_spawner = _id_E1422566503D1E2F;

  if(!isDefined(vehicle.classname_mp) && isDefined(_id_E1422566503D1E2F.classname_mp))
    vehicle.classname_mp = _id_E1422566503D1E2F.classname_mp;

  level notify("spawned_vehicle", _id_FA890E641F17EA50);

  if(_id_FA890E641F17EA50 == "little_bird") {
    vehicle _meth_247AD6A91F6A4FFE(1);
    vehicle._id_E6036CC5FE1C5C9E = 1;
  }

  if(riders.size) {
    _id_24E4405CF93F20ED::_id_64D2D74AB85E00BB(riders);

    if(isDefined(_id_E1422566503D1E2F._id_B25AB59A11FC36DA)) {
      scripts\cp_mp\vehicles\vehicle::_id_F92FAAAF5C5077C6(riders);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, _id_65119E62F62616E1);
    } else {
      spawninvehicle = !isDefined(_id_E1422566503D1E2F._id_3F0312E6382C878F) || istrue(_id_E1422566503D1E2F._id_3F0312E6382C878F);
      vehicle scripts\cp_mp\vehicles\vehicle::_id_F92FAAAF5C5077C6(riders, spawninvehicle);
    }

    level notify("loaded_ai_in_vehicle", vehicle);
  }

  if(isDefined(_id_E1422566503D1E2F.target))
    path = scripts\engine\utility::getStruct(_id_E1422566503D1E2F.target, "targetname");
  else
    path = scripts\engine\utility::getclosest(_id_E1422566503D1E2F.origin, scripts\engine\utility::getStructArray("vehicle_path_start", "targetname"));

  if(isDefined(path) && !isDefined(_id_E1422566503D1E2F._id_79FA6BD3C9BF6A0D)) {
    if(vehicle scripts\common\vehicle::ishelicopter()) {
      vehicle.script_vehicle_selfremove = 1;
      vehicle thread scripts\common\vehicle_paths::vehicle_paths_helicopter(path);
    } else {
      vehicle _id_0E80538EF14D00E1::create_simple_path(path, vehicle.angles);
      vehicle thread _id_0E80538EF14D00E1::vehiclefollowstructpath(path, 1);
    }
  }

  if(isDefined(_id_E1422566503D1E2F._id_5ABE2C141F995FB2))
    vehicle._id_5ABE2C141F995FB2 = 1;

  if(isDefined(_id_E1422566503D1E2F._id_72772FA651ECBE2B)) {
    funcs = strtok(_id_E1422566503D1E2F._id_72772FA651ECBE2B, "+");

    foreach(func in funcs) {
      if(isDefined(level._id_A8DC22C62BA69B88[func]))
        vehicle thread[[level._id_A8DC22C62BA69B88[func]]]();
    }
  }

  if(isDefined(level._id_6E5FF6CAE14C4081) && !vehicle scripts\common\vehicle::ishelicopter())
    level._id_6E5FF6CAE14C4081[level._id_6E5FF6CAE14C4081.size] = vehicle;

  vehicle._id_6E156BE4871C1ABD = 1;
  vehicle vehicle_turnengineon();
  return vehicle;
}

_id_30C929B6490AAA38(_id_E1422566503D1E2F) {
  if(!isDefined(_id_E1422566503D1E2F.vehicletype) && !isDefined(_id_E1422566503D1E2F._id_1E33F32152F60866))
    return undefined;

  if(isDefined(_id_E1422566503D1E2F._id_1E33F32152F60866))
    return _id_E1422566503D1E2F._id_1E33F32152F60866;

  switch (_id_E1422566503D1E2F.vehicletype) {
    case "veh9_techo_physics_cp":
    case "veh9_civ_lnd_pickup_fullsized_2014_tech_armor_physics_mp":
      return "veh9_techo_rebel_armor";
    case "veh9_jltv_physics_sp":
    case "veh9_jltv_physics_mp":
      return "veh9_jltv";
    case "veh9_jltv_mg_physics_mp":
    case "veh9_jltv_mg_physics_sp":
      return "veh9_jltv_mg";
    case "veh9_mil_air_heli_medium_mp":
    case "veh9_mil_air_heli_medium_physics_mp":
      return "little_bird";
  }
}

trigger_wait() {
  level endon("game_ended");
  self endon("death");
  _id_CC98688338A8AB23 = isDefined(self.struct) && isDefined(self.struct.spawnflags) && self.struct.spawnflags & 8;

  for(;;) {
    self waittill("trigger", player);
    scripts\engine\utility::flag_waitopen("pause_trigger_spawn");
    scripts\engine\utility::flag_waitopen("disable_trigger_spawn");

    if(!player scripts\cp\utility::is_valid_player()) {
      if(_id_CC98688338A8AB23 && isDefined(level.recondronesupers) && level.recondronesupers.size) {
        keys = getarraykeys(level.recondronesupers);

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.recondronesupers.size; _id_AC0E594AC96AA3A8++) {
          if(isDefined(level.recondronesupers[keys[_id_AC0E594AC96AA3A8]].owner) && isPlayer(level.recondronesupers[keys[_id_AC0E594AC96AA3A8]].owner))
            return;
        }
      }

      if(isDefined(player.owner) && isPlayer(player.owner) && istrue(level._id_2F11073BD9CEB3E0))
        return;
    } else
      return;
  }
}

_id_E7D3411DB935E99B(pos) {
  self endon("death");
  wait 2;
  self.vehicle_position = pos;
  self.script_startingposition = pos;
}

_id_12C0DE9AD36EB18B() {
  self endon("death");
  _id_80DC2C3589695B44();
  _id_CE79428A89A56E31 = "dive_fwd";
  _id_F5F6AD5A2900F0E2 = "dive_fwd_getup";

  for(;;) {
    waitframe();
    _id_8C33E181F5DDAE3C = _id_8A178EE7BFA2FF5A();

    if(!_id_8C33E181F5DDAE3C.size) {
      continue;
    }
    _id_D30969700B0E0867 = scripts\engine\utility::getclosest(self.origin, _id_8C33E181F5DDAE3C);
    _id_FBA905B4B44B0A91 = _id_C0F7C5E411992612("default", _id_D30969700B0E0867);

    if(!isDefined(_id_FBA905B4B44B0A91) || _id_FBA905B4B44B0A91 == "default") {
      continue;
    }
    _id_E7FC2021E96EB2F9();

    switch (_id_FBA905B4B44B0A91) {
      case "dive_left":
      case "dive_right":
        if(_id_FBA905B4B44B0A91 == "dive_left")
          self setgoalpos(getclosestpointonnavmesh(self.origin + anglestoleft(_id_D30969700B0E0867.angles) * 200));
        else
          self setgoalpos(getclosestpointonnavmesh(self.origin + anglestoright(_id_D30969700B0E0867.angles) * 200));

        wait 0.2;
        scripts\asm\shared\mp\utility::animscripted_single(_id_CE79428A89A56E31);
        scripts\asm\shared\mp\utility::animscripted_single(_id_F5F6AD5A2900F0E2);
        scripts\asm\shared\mp\utility::animscripted_clear();
        self setgoalpos(self.origin);
        break;
      case "juke_left":
        self setgoalpos(getclosestpointonnavmesh(self.origin + anglestoleft(_id_D30969700B0E0867.angles) * 200));
        break;
      case "juke_right":
        self setgoalpos(getclosestpointonnavmesh(self.origin + anglestoright(_id_D30969700B0E0867.angles) * 200));
        break;
      default:
        break;
    }

    self waittill("goal");
    _id_0C83E8B49E55A092();
  }
}

_id_80DC2C3589695B44() {
  wait 3;

  while(isDefined(self.vehicle_position))
    wait 1;
}

_id_8A178EE7BFA2FF5A() {
  _id_4789ACDA6EA1F7B1 = _id_823F69BC9733F183();
  _id_942720D22D0D1EA4 = cos(10);
  valid_vehicles = [];

  foreach(vehicle in _id_4789ACDA6EA1F7B1) {
    dist = distancesquared(self.origin, vehicle.origin);

    if(dist > squared(1500)) {
      continue;
    }
    if(self isinscriptedstate()) {
      continue;
    }
    _id_216AA8D841F7C224 = vehicle vehicle_getspeed();

    if(_id_216AA8D841F7C224 < 5) {
      continue;
    }
    _id_1D652FB2EBE872F4 = max(int(_id_216AA8D841F7C224 * 70), 2000);

    if(dist < squared(_id_1D652FB2EBE872F4)) {
      _id_2E5BC4F60FF0A001 = scripts\engine\utility::within_fov(vehicle.origin, vehicle.angles, self.origin, _id_942720D22D0D1EA4);
      velocity = vehicle vehicle_getvelocity();
      fwd = anglesToForward(vehicle.angles);
      dot = vectordot(velocity, fwd);

      if(dot < 0) {
        continue;
      }
      if(!_id_2E5BC4F60FF0A001) {
        continue;
      }
      valid_vehicles[valid_vehicles.size] = vehicle;
    }
  }

  return valid_vehicles;
}

_id_823F69BC9733F183() {
  _id_6D707EBC7D10DED8 = [];
  _id_D30969700B0E0867 = undefined;

  foreach(player in level.players) {
    if(!isDefined(player.vehicle)) {
      continue;
    }
    _id_6D707EBC7D10DED8[_id_6D707EBC7D10DED8.size] = player.vehicle;
  }

  _id_4789ACDA6EA1F7B1 = scripts\engine\utility::array_combine(_id_6D707EBC7D10DED8, level._id_6E5FF6CAE14C4081);
  _id_4789ACDA6EA1F7B1 = scripts\engine\utility::array_removeundefined(_id_4789ACDA6EA1F7B1);
  return _id_4789ACDA6EA1F7B1;
}

_id_E7FC2021E96EB2F9() {
  scripts\common\utility::demeanor_override("sprint");
  self._id_05EDE15B5B3C5EF1 = self.ignoreall;
  self.og_radius = self.goalradius;
  self.ignoreall = 1;
  self allowedstances("stand");
  self.goalradius = 12;
}

_id_0C83E8B49E55A092() {
  scripts\common\utility::clear_demeanor_override();
  self.ignoreall = self._id_05EDE15B5B3C5EF1;
  self.goalradius = self.og_radius;
  self allowedstances("stand", "crouch", "prone");
}

_id_C0F7C5E411992612(_id_FBA905B4B44B0A91, _id_D30969700B0E0867) {
  _id_216AA8D841F7C224 = _id_D30969700B0E0867 vehicle_getspeed();
  _id_08DA2769AF8F94B0 = self.origin + (0, 0, 5) + anglestoleft(_id_D30969700B0E0867.angles) * 200;
  trace = scripts\engine\trace::ray_trace(self.origin + (0, 0, 60), _id_08DA2769AF8F94B0, self);
  _id_0E06D1F8AF320925 = trace["fraction"] == 1;
  _id_0EF091DFA814CAFF = self.origin + (0, 0, 5) + anglestoright(_id_D30969700B0E0867.angles) * 200;
  trace = scripts\engine\trace::ray_trace(self.origin + (0, 0, 60), _id_0EF091DFA814CAFF, self);
  _id_5149D2DD057854D0 = trace["fraction"] == 1;

  if(!_id_0E06D1F8AF320925 && !_id_5149D2DD057854D0)
    return _id_FBA905B4B44B0A91;

  if(_id_0E06D1F8AF320925 && _id_5149D2DD057854D0) {
    dir = vectorNormalize((_id_D30969700B0E0867.origin - self.origin) * (1, 1, 0));
    fwd = anglestoright(_id_D30969700B0E0867.angles);
    dot = vectordot(dir, fwd);

    if(_id_216AA8D841F7C224 > 30)
      _id_FBA905B4B44B0A91 = "dive_left";
    else
      _id_FBA905B4B44B0A91 = "juke_left";

    if(dot < 0) {
      if(_id_216AA8D841F7C224 > 30)
        _id_FBA905B4B44B0A91 = "dive_right";
      else
        _id_FBA905B4B44B0A91 = "juke_right";
    }
  } else {
    if(_id_216AA8D841F7C224 > 30)
      _id_FBA905B4B44B0A91 = "dive_right";
    else
      _id_FBA905B4B44B0A91 = "juke_right";

    if(_id_5149D2DD057854D0) {
      if(_id_216AA8D841F7C224 > 30)
        _id_FBA905B4B44B0A91 = "dive_left";
      else
        _id_FBA905B4B44B0A91 = "juke_left";
    }
  }

  return _id_FBA905B4B44B0A91;
}

_id_A6D375B860CEFD56() {
  self endon("death");
  level endon("obj_scene_started");
  waitframe();

  while(!isDefined(self.riders))
    wait 0.5;

  self.gunner = get_gunner();

  while(!isDefined(self.gunner)) {
    self.gunner = get_gunner();
    wait 0.1;
  }

  self.gunner _id_18A73A64992DD07D::give_soldier_armor();
  self.gunner _id_18A73A64992DD07D::give_soldier_helmet();
  self.gunner.allowpain = 0;
  self.gunner.equip_armor = 1;
  self.gunner._id_B5218CF00DAD94EF = 600;
  self.gunner._id_292D0F6A197C141E = 1;

  while(!isDefined(self.mgturret))
    waitframe();

  turret = self.mgturret[0];
  turret makeunusable();
  self.gunner.vehicle = self;
  self.gunner waittill("death");

  if(isDefined(turret)) {
    turret cleartargetentity();
    turret setmode("sentry_offline");
  }

  if(isDefined(self.turret_pointer))
    self.turret_pointer delete();

  wait 0.75;
  self notify("gunner_defeated");
}

get_gunner() {
  foreach(rider in self.riders) {
    if(rider.vehicle_position == 5)
      return rider;
  }

  return undefined;
}

technical_gunner_custom_death() {
  scripts\common\ai::_id_82A45E8AEF44CE3F(undefined);
  scripts\asm\soldier\vehicle::playanim_vehicledeath(self.asmname, "vehicle_death");
  return 1;
}

_id_BD89BC6288EF7F9B() {
  self endon("death");
  self endon("gunner_defeated");
  level endon("obj_scene_started");
  scripts\engine\utility::ent_flag_init("turret_investigate_pos_updated");

  while(!isDefined(self.mgturret)) {
    if(isDefined(self.turrets) && isDefined(self.turrets["iw9_mg_jltv_mp"])) {
      self.mgturret = [];
      self.mgturret[0] = self.turrets["iw9_mg_jltv_mp"];
    }

    waitframe();
  }

  turret = self.mgturret[0];
  turret.ownervehicle = self;
  turret setmode("manual");
  turret endon("death");
  turret settoparc(25);
  turret setbottomarc(25);
  self.spotlight = spawn("script_model", turret gettagorigin("tag_aim_animated"));
  self.spotlight setModel("tag_origin");
  self.spotlight linkTo(turret, "tag_aim_animated", (0, 0, 0), (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(self.spotlight);
  self.spotlight.tag = scripts\engine\utility::spawn_tag_origin(self.spotlight.origin, self.spotlight.angles);
  self.spotlight.tag linkTo(self.spotlight, "tag_origin", (7.5, -3.5, 2.5), (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(self.spotlight.tag);
  self.turret_pointer = scripts\engine\utility::spawn_script_origin(self.origin - 500 * anglesToForward(self.angles));
  turret settargetentity(self.turret_pointer);
  thread scripts\engine\utility::delete_on_death(self.turret_pointer);
  level.technical_spotlight_targets = scripts\engine\utility::getStructArray("technical_spotlight_target", "targetname");
  _id_46D8E81088AF53D5 = 1;

  foreach(player in level.players)
  childthread turret_spotted_ent_think(player);

  for(;;) {
    wait 0.2;

    if(!isalive(self.gunner)) {
      continue;
    }
    if(self._id_807A9ED6606103DE scripts\engine\utility::ent_flag("weapons_free")) {
      turret setleftarc(180);
      turret setrightarc(180);
      turret setconvergencetime(2, "yaw");
      turret setconvergencetime(2, "pitch");
      childthread turret_aim_think();
      turret childthread turret_shoot_think();
      self.gunner scripts\engine\utility::waittill_any_timeout_2(10, "stealth_hunt", "death");
      turret notify("stop_turret_shoot_think");
      turret cleartargetentity();
      continue;
    }

    if(isDefined(self.turret_investigate_pos)) {
      if(gettime() - self.turret_investigate_pos_time > 3000) {
        self.turret_investigate_pos = undefined;
        self.turret_investigate_pos_time = undefined;
      } else if(scripts\engine\utility::ent_flag("turret_investigate_pos_updated")) {
        turret setleftarc(180);
        turret setrightarc(180);
        turret setconvergencetime(4, "yaw");
        turret setconvergencetime(4, "pitch");
        update_turret_pointer(self.turret_investigate_pos);
        scripts\engine\utility::ent_flag_clear("turret_investigate_pos_updated");
      }

      continue;
    }

    success = turret_sweep(turret, _id_46D8E81088AF53D5, 5);

    if(istrue(success))
      _id_46D8E81088AF53D5 = _id_46D8E81088AF53D5 * -1;
  }
}

update_turret_pointer(pos) {
  if(!isDefined(self.turret_pointer))
    self.turret_pointer = scripts\engine\utility::spawn_script_origin(pos);
  else
    self.turret_pointer.origin = pos;

  self.mgturret[0] settargetentity(self.turret_pointer);
}

turret_aim_think() {
  self.gunner endon("stealth_hunt");
  self.gunner endon("death");
  _id_72BB599075A82534 = undefined;
  self._id_F9374A64EF9C64EC = undefined;
  _id_2D1996A1AFA79192 = 0;
  _id_C00939B2974DB87C = (0, 0, 0);
  _id_072BD42692055CDD = [self.mgturret[0], self.gunner];
  _id_072BD42692055CDD = scripts\engine\utility::array_combine(_id_072BD42692055CDD, level.players);

  for(;;) {
    waitframe();

    if(!isDefined(level.players) || level.players.size == 0) {
      continue;
    }
    self.mgturret[0]._id_F9374A64EF9C64EC = scripts\cp\utility::get_closest_living_player();

    if(!isDefined(self.mgturret[0]._id_F9374A64EF9C64EC)) {
      continue;
    }
    if(!scripts\engine\utility::is_equal(self.gunner.enemy, self.mgturret[0]._id_F9374A64EF9C64EC)) {
      continue;
    }
    if(gettime() - self.gunner lastknowntime(self.mgturret[0]._id_F9374A64EF9C64EC) > 10000) {
      continue;
    }
    if(scripts\engine\utility::is_equal(self.gunner lastknownpos(self.mgturret[0]._id_F9374A64EF9C64EC), _id_72BB599075A82534)) {
      continue;
    }
    _id_72BB599075A82534 = self.gunner lastknownpos(self.mgturret[0]._id_F9374A64EF9C64EC);

    if(gettime() > _id_2D1996A1AFA79192) {
      start_origin = self.mgturret[0] gettagorigin("tag_aim");
      _id_A89FB08B16E1D170 = self.mgturret[0]._id_F9374A64EF9C64EC getEye() - self.mgturret[0]._id_F9374A64EF9C64EC.origin - (0, 0, 10);

      if(scripts\engine\trace::ray_trace_passed(start_origin, _id_72BB599075A82534, _id_072BD42692055CDD))
        _id_C00939B2974DB87C = (0, 0, 0);
      else if(scripts\engine\trace::ray_trace_passed(start_origin, _id_72BB599075A82534 + _id_A89FB08B16E1D170, _id_072BD42692055CDD))
        _id_C00939B2974DB87C = _id_A89FB08B16E1D170;
      else if(scripts\engine\trace::ray_trace_passed(start_origin, _id_72BB599075A82534 + _id_A89FB08B16E1D170 / 2, _id_072BD42692055CDD))
        _id_C00939B2974DB87C = _id_A89FB08B16E1D170 / 2;

      _id_2D1996A1AFA79192 = gettime() + 1000;
    }

    aim_pos = _id_72BB599075A82534 + _id_C00939B2974DB87C;

    if(distancesquared(aim_pos, self.origin) < 40000 && !self.mgturret[0] turretcantarget(aim_pos)) {
      _id_6B8BC7FAB156CCD9 = self.origin;
      _id_F92BD9CAB49D2D58 = scripts\engine\utility::flatten_vector(aim_pos - _id_6B8BC7FAB156CCD9);
      aim_pos = _id_6B8BC7FAB156CCD9 + _id_F92BD9CAB49D2D58 * 500;
    }

    update_turret_pointer(aim_pos);
  }
}

turret_shoot_think() {
  self notify("stop_turret_shoot_think");
  self endon("stop_turret_shoot_think");
  gunner = self.ownervehicle.gunner;

  while(!gunner_can_shoot_player(gunner))
    waitframe();

  for(;;) {
    waitframe();

    if(!isDefined(self._id_F9374A64EF9C64EC)) {
      continue;
    }
    if(!scripts\engine\utility::is_equal(gunner.enemy, self._id_F9374A64EF9C64EC)) {
      continue;
    }
    if(gettime() - gunner lastknowntime(self._id_F9374A64EF9C64EC) > 10000) {
      continue;
    }
    if(isDefined(self.ownervehicle.turret_pointer)) {
      if(!self turretcantarget(self.ownervehicle.turret_pointer.origin))
        continue;
    }

    start_origin = self gettagorigin("tag_flash");
    start_angles = self gettagangles("tag_flash");
    _id_4351410D12107DF3 = gunner lastknownpos(self._id_F9374A64EF9C64EC);

    if(!turret_aimed_at_last_known(start_origin, start_angles, _id_4351410D12107DF3)) {
      continue;
    }
    if(distance2dsquared(self.origin, _id_4351410D12107DF3) > squared(3000)) {
      continue;
    }
    trace = scripts\engine\trace::ray_trace(start_origin, start_origin + anglesToForward(start_angles) * 3000, self);
    _id_E18FB8F9395C8AF8 = trace["entity"];

    if(isDefined(_id_E18FB8F9395C8AF8) && (_id_E18FB8F9395C8AF8 == self.ownervehicle || scripts\engine\utility::is_equal(_id_E18FB8F9395C8AF8.team, "axis"))) {
      continue;
    }
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
      self shootturret("tag_flash");
      level notify("technical_hot_event", gunner);
      wait 0.1;
    }

    wait 1;

    while(!gunner_can_shoot_player(gunner))
      waitframe();
  }
}

gunner_can_shoot_player(gunner) {
  if(!isDefined(self._id_F9374A64EF9C64EC))
    return 0;

  if(gunner cansee(self._id_F9374A64EF9C64EC))
    return 1;

  _id_EE752F5A6B0F9807 = gunner lastknowntime(self._id_F9374A64EF9C64EC);

  if(!isDefined(_id_EE752F5A6B0F9807))
    return 0;

  if(gettime() - _id_EE752F5A6B0F9807 > 10000)
    return 0;

  _id_72BB599075A82534 = gunner lastknownpos(self._id_F9374A64EF9C64EC);

  if(!isDefined(_id_72BB599075A82534))
    return 0;

  if(!turret_aimed_at_last_known(self gettagorigin("tag_flash"), self gettagangles("tag_flash"), _id_72BB599075A82534))
    return 0;

  if(distancesquared(_id_72BB599075A82534, self._id_F9374A64EF9C64EC.origin) > 16384)
    return 0;

  return 1;
}

turret_aimed_at_last_known(start_origin, start_angles, _id_C74E2E565EE3FE18) {
  if(!isDefined(self._id_F9374A64EF9C64EC))
    return 0;

  if(scripts\engine\utility::within_fov(start_origin, start_angles, _id_C74E2E565EE3FE18, 0.7))
    return 1;

  _id_A89FB08B16E1D170 = self._id_F9374A64EF9C64EC getEye() - self._id_F9374A64EF9C64EC.origin;

  if(scripts\engine\utility::within_fov(start_origin, start_angles, _id_C74E2E565EE3FE18 + _id_A89FB08B16E1D170, 0.7))
    return 1;

  if(scripts\engine\utility::within_fov(start_origin, start_angles, _id_C74E2E565EE3FE18 + _id_A89FB08B16E1D170 / 2, 0.7))
    return 1;

  return 0;
}

turret_spotted_ent_think(ent) {
  ent endon("stop_turret_spotted_ent_think");
  ent endon("disconnect");
  _id_F00D645C58143E63 = 0;

  for(;;) {
    if(!isDefined(ent)) {
      return;
    }
    while(isalive(self.gunner) && turret_is_on_ent(ent, 10)) {
      _id_F00D645C58143E63++;

      if(_id_F00D645C58143E63 >= 3) {
        if(isPlayer(ent)) {
          if(!scripts\engine\utility::is_equal(self.turret_investigate_pos, ent.origin))
            update_turret_investigate_pos(ent.origin);
        } else
          return;
      }

      waitframe();
    }

    if(_id_F00D645C58143E63 > 0)
      _id_F00D645C58143E63 = 0;

    waitframe();
  }
}

turret_is_on_ent(ent, fov) {
  if(distance2dsquared(self.origin, ent.origin) > 4000000)
    return 0;

  origin = ent.origin;

  if(isPlayer(ent))
    origin = ent getEye();
  else
    origin = ent.origin;

  turret = self.mgturret[0];
  start = turret gettagorigin("tag_flash");
  angles = turret gettagangles("tag_flash");

  if(scripts\engine\utility::within_fov(start, angles, origin, cos(fov))) {
    if(self.gunner cansee(ent))
      return 1;
  }

  return 0;
}

update_turret_investigate_pos(pos) {
  scripts\engine\utility::ent_flag_set("turret_investigate_pos_updated");
  self.turret_investigate_pos = pos;
  self.turret_investigate_pos_time = gettime();
}

turret_sweep(turret, _id_46D8E81088AF53D5, _id_87CDBDFE21E2D499) {
  self endon("death");
  self endon("turret_investigate_pos_updated");
  self.gunner endon("death");
  self.gunner endon("stealth_combat");
  turret setconvergencetime(_id_87CDBDFE21E2D499, "yaw");
  turret setconvergencetime(_id_87CDBDFE21E2D499, "pitch");
  turret setleftarc(180);
  turret setrightarc(180);
  _id_140149F4F2ED1009 = scripts\engine\utility::get_array_of_closest(self.origin, level.technical_spotlight_targets, undefined, undefined, 4000);
  _id_6075CD8D87DF97EC = [];
  _id_DE40082E48FF7CC9 = anglestoright(self.angles);
  _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");
  _id_6B84F2EC187B1C4D = scripts\engine\utility::getclosest(self.origin, _id_A02118632C7F1621, 1500);

  if(isDefined(_id_6B84F2EC187B1C4D)) {
    dir = vectorNormalize(_id_6B84F2EC187B1C4D.origin - self.origin);
    dot = vectordot(_id_DE40082E48FF7CC9, dir);
    _id_46D8E81088AF53D5 = dot;
  }

  foreach(target in _id_140149F4F2ED1009) {
    dir = vectorNormalize(target.origin - self.origin);
    dot = vectordot(_id_DE40082E48FF7CC9, dir);

    if(dot * _id_46D8E81088AF53D5 <= 0) {
      continue;
    }
    if(!turret turretcantarget(target.origin)) {
      continue;
    }
    _id_6075CD8D87DF97EC[_id_6075CD8D87DF97EC.size] = target;
  }

  best_target = undefined;

  foreach(player in level.players) {
    dir = vectorNormalize(player.origin - self.origin);
    dot = vectordot(_id_DE40082E48FF7CC9, dir);

    if(dot * _id_46D8E81088AF53D5 > 0) {
      best_target = scripts\engine\utility::getclosest(player.origin, _id_6075CD8D87DF97EC);
      continue;
    }

    best_target = scripts\cp\utility::getfarthest(player.origin, _id_6075CD8D87DF97EC);
  }

  if(!isDefined(best_target))
    return 0;

  update_turret_pointer(best_target.origin);
  waittill_technical_turns_or_timeout(_id_87CDBDFE21E2D499 + 2);
  return 1;
}

waittill_technical_turns_or_timeout(timeout) {
  _id_F6E585610BAFC635 = anglesToForward(self.angles);
  _id_BFDA656E7B3CC1A0 = gettime() + timeout * 1000;

  while(gettime() < _id_BFDA656E7B3CC1A0) {
    waitframe();
    forward = anglesToForward(self.angles);
    dot = vectordot(_id_F6E585610BAFC635, forward);

    if(dot < 0.5) {
      break;
    }
  }
}

_id_362F719B447ABA3F(type, pos, _id_8BC14603A27FA3E7, tier, _id_CB1E30930C35F2E2) {
  if(!isDefined(tier))
    tier = 1;

  if(!isDefined(_id_8BC14603A27FA3E7))
    _id_8BC14603A27FA3E7 = (0, 0, 0);

  aitype = undefined;

  if(type == "juggernaut")
    aitype = "jugg_aq";
  else {
    aitype = type + "_t" + tier;

    if(istrue(_id_CB1E30930C35F2E2))
      aitype = aitype + "_nvg_aq";
    else
      aitype = aitype + "_aq";
  }

  if(!isDefined(aitype))
    return undefined;

  struct = spawnStruct();
  struct.origin = pos;
  struct.angles = _id_8BC14603A27FA3E7;
  struct._id_87B421D7E94C6265 = aitype;
  return _id_81B8EDC3CB076FDA(struct, 1);
}