/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\spawner_scoring.gsc
***********************************************/

spawner_scoring_init() {
  scripts\engine\utility::flag_init("spawn_point_score_data_init_done");
  level.current_spawn_scoring_index = 0;
  level.spawn_scoring_array = [];
  level.total_cluster_spawn_score = 13;
  level.total_veh_spawn_score = 3;
  level.total_spawn_score = 18;
  level.spawner_scoring_funcs = [];
  level.spawner_scoring_funcs["vehicle_spawner"] = ::vehicle_spawnpoint_scoring;
  level.spawner_scoring_funcs["cluster_spawner"] = ::cluster_spawnpoint_scoring;
  level.spawner_scoring_funcs["standard_spawner"] = ::standard_spawnpoint_scoring;
  level.spawner_scoring_allow_early_out["cluster_spawner"] = 0;
  level.spawner_scoring_critical_factors = [];
  level.spawner_scoring_critical_factors["vehicle_spawner"] = ::vehicle_spawnpoint_valid;
  level.spawner_scoring_critical_factors["cluster_spawner"] = ::cluster_spawnpoint_valid;
  level.spawner_scoring_critical_factors["standard_spawner"] = ::standard_spawnpoint_valid;
  level.capsule_contents = scripts\engine\trace::create_solid_ai_contents();
}

vehicle_spawnpoint_scoring(spawnpoint, debug, _id_596674BD1F7B0B01, spawnpoints) {
  if(calculate_ai_veh_spawner_score(spawnpoint, level.current_spawn_scoring_index))
    return spawnpoint;
  else
    return undefined;
}

vehicle_spawnpoint_valid(spawnpoint, respawn) {
  if(istrue(respawn))
    return 0;
  else if(scripts\engine\utility::flag_exist("disable_vehicle_spawning") && scripts\engine\utility::flag("disable_vehicle_spawning"))
    return 0;
  else if(isDefined(spawnpoint.vehicle) && isDefined(spawnpoint.vehicle.attachedguys) && isDefined(spawnpoint.vehicle.usedpositions)) {
    _id_FC3670006DAE0C6E = spawnpoint.vehicle.usedpositions.size;
    override = _id_0E80538EF14D00E1::get_max_ai_from_infil_name(self, spawnpoint.vehicle.infil_name);

    if(isDefined(override))
      _id_FC3670006DAE0C6E = override;

    if(spawnpoint.vehicle.attachedguys.size >= _id_FC3670006DAE0C6E) {
      return 0;
      return;
    }

    return 1;
    return;
  } else
    return 1;
}

cluster_child_spawnpoint_scoring(_id_C0C95ED2A93ECD8A, debug, _id_596674BD1F7B0B01) {
  if(isDefined(_id_C0C95ED2A93ECD8A.child_spawners) && _id_C0C95ED2A93ECD8A.child_spawners.size > 0)
    _id_FAD1D4E8291840EC = _id_C0C95ED2A93ECD8A.child_spawners;
  else
    _id_FAD1D4E8291840EC = getnodesinradiussorted(_id_C0C95ED2A93ECD8A.origin, 2048, 0, 256, "cover");

  _id_38E40095837BFFD8 = 1;
  spawnpoint = undefined;

  if(_id_38E40095837BFFD8) {
    spawnpoint = score_ai_spawns(_id_FAD1D4E8291840EC, undefined, 1, _id_596674BD1F7B0B01, 1);
    self.position_ref = undefined;
  }

  _id_C0C95ED2A93ECD8A _id_18A73A64992DD07D::_id_EC648F2C89EA1C91();
  _id_C0C95ED2A93ECD8A.totalscore = undefined;
  _id_C0C95ED2A93ECD8A.fnchildscorefunc = undefined;

  if(isDefined(spawnpoint)) {
    set_chosen_spawner_from_uid(_id_C0C95ED2A93ECD8A);
    _id_C0C95ED2A93ECD8A thread _id_18A73A64992DD07D::parent_spawner_disable_after_count(self, spawnpoint);
  }

  return spawnpoint;
}

cluster_spawnpoint_scoring(_id_C0C95ED2A93ECD8A, debug, _id_596674BD1F7B0B01, spawnpoints) {
  if(calculate_ai_cluster_spawner_score(_id_C0C95ED2A93ECD8A, level.current_spawn_scoring_index))
    return _id_C0C95ED2A93ECD8A;
  else
    return undefined;
}

cluster_spawnpoint_valid(spawnpoint, respawn) {
  if(istrue(respawn))
    return 0;
  else
    return 1;
}

standard_spawnpoint_scoring(spawnpoint, debug, _id_596674BD1F7B0B01, spawnpoints) {
  if(calculate_ai_spawner_score(spawnpoint, level.current_spawn_scoring_index, debug, spawnpoints))
    return spawnpoint;

  return undefined;
}

get_player_velo_array() {
  if(isDefined(self.velo_forward_memory) && self.velo_forward_memory.size > 0)
    return self.velo_forward_memory;

  return [];
}

standard_spawnpoint_valid(spawnpoint, respawn) {
  if(!spawnpoint _id_18A73A64992DD07D::spawner_flags_check(32)) {
    _id_AA440CDD07894C27 = spawnpoint.origin + (0, 0, 6);
    _id_3A144F22E939C877 = scripts\engine\trace::capsule_trace_get_all_results(_id_AA440CDD07894C27, _id_AA440CDD07894C27 + (0, 0, 1), 16, 32, undefined, undefined, level.capsule_contents);
    spawnpoint _id_18A73A64992DD07D::add_to_spawner_flags(32);

    if(isDefined(_id_3A144F22E939C877) && isDefined(_id_3A144F22E939C877[0])) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3A144F22E939C877.size; _id_AC0E594AC96AA3A8++) {
        if(isDefined(_id_3A144F22E939C877[_id_AC0E594AC96AA3A8])) {
          trace = _id_3A144F22E939C877[_id_AC0E594AC96AA3A8];

          if(scripts\engine\utility::is_equal(trace["hittype"], "hittype_world")) {
            spawnpoint _id_18A73A64992DD07D::disable_spawner();
            return 0;
          }
        }
      }
    }
  }

  message = undefined;
  _id_78BABF35878BCD24 = undefined;
  _id_08F4AC8EA1ADB1DC = undefined;
  _id_6197F1FB60775B4C = 0;

  if(isnode(spawnpoint) && !spawnpoint nodeisactivated()) {
    add_to_score_message(_id_08F4AC8EA1ADB1DC, "^1CRITICAL^0: Node Spawner disconnected", undefined, undefined, 1, spawnpoint);
    spawnpoint _id_18A73A64992DD07D::disable_spawner();
    return 0;
  }

  spawnpoint _id_18A73A64992DD07D::spawner_init();

  if(!spawner_invalid_due_to_recently_used(spawnpoint))
    return 0;

  if(scripts\cp\cp_spawn_factor::critical_factor(::has_tac_vis, spawnpoint)) {
    _id_887D42B1410C39FE = 0;

    if(!_id_887D42B1410C39FE) {
      spawnpoint _id_18A73A64992DD07D::add_to_spawner_flags(64);
      spawnpoint.lastspawntime = self.current_time + 10000;
    }
  } else
    spawnpoint _id_18A73A64992DD07D::remove_from_spawner_flags(64);

  if(getdvarint("dvar_C2FACF64F58F632B", 1) && !istrue(spawnpoint.script_forcespawn)) {
    dist = get_close_distance_var();

    if(!isDefined(spawnpoint.script_parent)) {
      if(isDefined(spawnpoint.script_dist_only))
        dist = spawnpoint.script_dist_only;
    }

    nearby_players = scripts\common\utility::playersincylinder(spawnpoint.origin, dist);

    if(nearby_players.size > 0) {
      if(isDefined(spawnpoint.script_dist_only))
        spawnpoint thread _id_18A73A64992DD07D::disable_spawn_point(spawnpoint, undefined, self);
      else
        spawnpoint.lastspawntime = self.current_time;

      return 0;
    }
  }

  if(isDefined(level.spawner_poison_structs) && level.spawner_poison_structs.size > 0) {
    _id_920EB514B51276B8 = sortbydistancecullbyradius(level.spawner_poison_structs, spawnpoint.origin, 5000);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_920EB514B51276B8.size; _id_AC0E594AC96AA3A8++) {
      if(distance2dsquared(spawnpoint.origin, _id_920EB514B51276B8[_id_AC0E594AC96AA3A8].origin) < squared(_id_920EB514B51276B8[_id_AC0E594AC96AA3A8].radius)) {
        add_to_score_message(_id_08F4AC8EA1ADB1DC, "^1CRITICAL^0: Poisoned", undefined, undefined, 1, spawnpoint);
        return 0;
      }
    }
  }

  if(!istrue(level._id_884F3D8344C4EAFE) && isDefined(self.position_ref) && !istrue(spawnpoint.script_forcespawn)) {
    _id_E5970392FA9BE29C = get_too_far_dist_sq(spawnpoint);
    _id_ABD9EE4725B96FC2 = distancesquared(self.position_ref, spawnpoint.origin);
    dist = undefined;

    if(_id_ABD9EE4725B96FC2 >= _id_E5970392FA9BE29C) {
      add_to_score_message(_id_08F4AC8EA1ADB1DC, "^1CRITICAL^0: Too Far", undefined, undefined, 1, spawnpoint);
      return 0;
    } else
      spawnpoint.dist_sq_to_ref = _id_ABD9EE4725B96FC2;
  }

  return 1;
}

spawner_critical_factors(spawnpoint, respawn, _id_596674BD1F7B0B01) {
  message = undefined;
  _id_78BABF35878BCD24 = undefined;
  _id_08F4AC8EA1ADB1DC = undefined;
  _id_6197F1FB60775B4C = 0;

  if(istrue(level.pause_spawner_scoring))
    return 0;
  else if(scripts\cp\cp_spawn_factor::critical_factor(::is_spawner_disabled, spawnpoint))
    return 0;

  if(istrue(respawn)) {
    if(scripts\cp\cp_spawn_factor::critical_factor(::invalid_for_teleport, spawnpoint))
      return 0;
    else if(istrue(spawnpoint.is_on_platform) || isDefined(spawnpoint.noteleport)) {
      if(istrue(spawnpoint.is_on_platform)) {} else if(isDefined(spawnpoint.noteleport)) {}

      return 0;
    } else if(scripts\cp\cp_spawn_factor::critical_factor(::is_valid_respawn_spawnpoint, spawnpoint))
      return 0;
  }

  if(scripts\cp\cp_spawn_factor::critical_factor(::is_level_escalation_sufficient, spawnpoint))
    return 0;
  else if(scripts\cp\cp_spawn_factor::critical_factor(::are_weapons_free, spawnpoint))
    return 0;
  else if(!scripts\cp\cp_spawn_factor::critical_factor(scripts\cp\cp_spawn_factor::avoidtelefrag, spawnpoint))
    return 0;
  else if(!scripts\cp\cp_spawn_factor::critical_factor(level.spawner_scoring_critical_factors[spawnpoint get_spawn_scoring_type()], spawnpoint))
    return 0;
  else
    return 1;
}

get_spawn_scoring_type() {
  if(isDefined(self.spawner_flags)) {
    if(self.spawner_flags & 2)
      return "vehicle_spawner";
    else if(self.spawner_flags & 4)
      return "cluster_spawner";
    else
      return "standard_spawner";
  } else
    return "standard_spawner";
}

is_valid_respawn_spawnpoint(spawnpoint) {
  _id_64AA8D7BF2D04944 = spawnpoint get_spawn_scoring_type();

  if(isDefined(_id_64AA8D7BF2D04944)) {
    switch (_id_64AA8D7BF2D04944) {
      case "vehicle_spawner":
        return 1;
      case "cluster_spawner":
        return 0;
      case "standard_spawner":
        return 0;
    }
  }

  return 0;
}

can_path_to_target(spawnpoint) {
  if(isDefined(self.group) && isDefined(self.group.position_ref)) {
    if(!self maymovefrompointtopoint(spawnpoint.origin, self.group.position_ref)) {
      level thread scripts\engine\utility::draw_capsule(spawnpoint.origin, 16, 32, undefined, (1, 0, 0), undefined, 1000);
      spawnpoint _id_18A73A64992DD07D::add_to_spawner_flags(512);
      return 0;
    } else
      return 1;
  } else
    return 1;
}

has_tac_vis(spawnpoint) {
  if(!istrue(spawnpoint.script_forcespawn)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(level.players[_id_AC0E594AC96AA3A8] hastacvis(spawnpoint.origin, 0, 64, 1))
        return 1;
    }
  }

  return 0;
}

is_level_escalation_sufficient(spawnpoint) {
  if(isDefined(spawnpoint.script_escalation_level) && isDefined(level.escalation_level)) {
    if(int(spawnpoint.script_escalation_level) > int(level.escalation_level))
      return 1;
    else
      return 0;
  } else
    return 0;
}

are_weapons_free(spawnpoint) {
  if(scripts\engine\utility::ent_flag_exist("weapons_free") && scripts\engine\utility::ent_flag("weapons_free")) {
    if(isDefined(spawnpoint.script_animation_type))
      return 1;
  }

  return 0;
}

invalid_for_teleport(spawnpoint) {
  if(spawnpoint _id_18A73A64992DD07D::spawner_flags_check(512))
    return 1;

  if(istrue(spawnpoint.is_on_platform)) {
    spawnpoint _id_18A73A64992DD07D::add_to_spawner_flags(512);
    return 1;
  }

  _id_174EFDC364EEA3FF = self.position_ref;

  if(!isvector(_id_174EFDC364EEA3FF))
    _id_174EFDC364EEA3FF = self.position_ref.origin;

  if(!navtrace(spawnpoint.origin, _id_174EFDC364EEA3FF)) {
    spawnpoint _id_18A73A64992DD07D::add_to_spawner_flags(512);
    return 1;
  }

  return 0;
}

is_spawner_disabled(spawnpoint) {
  if(spawnpoint _id_18A73A64992DD07D::spawner_flags_check(1024))
    return 1;
  else
    return 0;
}

score_factor_ai(weight, _id_E2CADC5BF4175E47, spawnpoint, _id_394138CF0A48BDD1, _id_394135CF0A48B738, _id_9D3207145B5E514C) {
  if(isDefined(_id_394135CF0A48B738))
    _id_913B73097FDCDB62 = [[_id_E2CADC5BF4175E47]](spawnpoint, _id_394138CF0A48BDD1, _id_394135CF0A48B738);
  else if(isDefined(_id_394138CF0A48BDD1))
    _id_913B73097FDCDB62 = [[_id_E2CADC5BF4175E47]](spawnpoint, _id_394138CF0A48BDD1);
  else
    _id_913B73097FDCDB62 = [[_id_E2CADC5BF4175E47]](spawnpoint);

  if(!isDefined(_id_913B73097FDCDB62))
    return undefined;

  if(!isDefined(_id_9D3207145B5E514C))
    _id_9D3207145B5E514C = 1000;

  _id_4DDB8606CD43D154 = _id_9D3207145B5E514C * weight;
  _id_913B73097FDCDB62 = clamp(_id_913B73097FDCDB62 * weight, 0, _id_4DDB8606CD43D154);
  return _id_913B73097FDCDB62;
}

get_best_scoring_target(_id_BDF059129BDD23A3) {
  _id_85711BA5CCA7C90C = get_spawn_scoring_array();
  result = _id_9A9CC1B12C2B79B5(_id_85711BA5CCA7C90C, _id_BDF059129BDD23A3);
  level.current_spawn_scoring_index = result;

  if(isDefined(level.current_spawn_scoring_index))
    return _id_85711BA5CCA7C90C[level.current_spawn_scoring_index];
  else
    return level.current_spawn_scoring_index;
}

get_score_target_override(pos) {
  if(isDefined(level.ignore_spawn_scoring_pois)) {
    if(scripts\engine\utility::array_contains(level.ignore_spawn_scoring_pois, self.group_name))
      return undefined;
  }

  if(isDefined(level.spawn_scoring_pois) && level.spawn_scoring_pois.size > 0) {
    _id_B205D90302DA2F07 = undefined;

    if(level.spawn_scoring_pois.size > 1)
      _id_A719FCA40C4A6E2C = sortbydistance(level.spawn_scoring_pois, pos);
    else
      _id_A719FCA40C4A6E2C = level.spawn_scoring_pois;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A719FCA40C4A6E2C.size; _id_AC0E594AC96AA3A8++) {
      if(distance2dsquared(pos, _id_A719FCA40C4A6E2C[_id_AC0E594AC96AA3A8].origin) < _id_A719FCA40C4A6E2C[_id_AC0E594AC96AA3A8].activation_radius_sq)
        return _id_A719FCA40C4A6E2C[_id_AC0E594AC96AA3A8];
    }
  }

  return undefined;
}

get_score_target_pos(_id_AE58980967627913) {
  if(isPlayer(_id_AE58980967627913)) {
    if(isDefined(level.recondronesupers) && level.recondronesupers.size) {
      keys = getarraykeys(level.recondronesupers);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.recondronesupers.size; _id_AC0E594AC96AA3A8++) {
        if(isDefined(level.recondronesupers[keys[_id_AC0E594AC96AA3A8]].owner) && level.recondronesupers[keys[_id_AC0E594AC96AA3A8]].owner == _id_AE58980967627913)
          return level.recondronesupers[keys[_id_AC0E594AC96AA3A8]].origin;
      }
    }

    if(isDefined(_id_AE58980967627913.velo_forward) && _id_AE58980967627913 should_use_velo_forward())
      return _id_AE58980967627913.velo_forward;
    else {
      forward = anglesToForward(_id_AE58980967627913.angles);
      return _id_AE58980967627913.origin + forward * 1024;
    }
  } else
    return _id_AE58980967627913.origin;
}

get_closest_spawns(origin, spawnpoints, radius) {
  if(!isarray(spawnpoints))
    return spawnpoints;

  if(isDefined(radius))
    return sortbydistancecullbyradius(spawnpoints, origin, radius);

  return sortbydistance(spawnpoints, origin);
}

get_array_of_valid_spawnpoints(spawnpoints, respawn, debug, _id_596674BD1F7B0B01) {
  _id_59BA6BE73235750F = [];
  _id_9BC1F4EB3B98248D = 10;

  if(isarray(spawnpoints)) {
    self.position_ref = self.spawn_ref_point;
    spawnpoints = get_closest_spawns(self.position_ref, spawnpoints);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawnpoints.size; _id_AC0E594AC96AA3A8++) {
      spawnpoint = spawnpoints[_id_AC0E594AC96AA3A8];
      spawnpoint _id_18A73A64992DD07D::spawner_init();

      if(spawner_critical_factors(spawnpoint, respawn, _id_596674BD1F7B0B01))
        _id_59BA6BE73235750F[_id_59BA6BE73235750F.size] = spawnpoint;

      if(_id_59BA6BE73235750F.size >= _id_9BC1F4EB3B98248D) {
        break;
      }
    }
  } else
    _id_59BA6BE73235750F[0] = spawnpoints;

  return _id_59BA6BE73235750F;
}

_id_9A9CC1B12C2B79B5(_id_85711BA5CCA7C90C, _id_BDF059129BDD23A3) {
  if(!isDefined(_id_85711BA5CCA7C90C))
    _id_85711BA5CCA7C90C = get_spawn_scoring_array();

  _id_A1780ACBE9372380 = _id_85711BA5CCA7C90C.size;

  if(_id_A1780ACBE9372380 <= 1)
    return 0;

  found = 0;
  index = level.current_spawn_scoring_index;
  _id_12EBA3D580C9458A = get_next_player_index(index);

  while(!found) {
    if(_id_12EBA3D580C9458A == index) {
      break;
    }

    player = level.players[_id_12EBA3D580C9458A];

    if(!istrue(player.spectating) && !istrue(player.is_fast_traveling) && !istrue(player.inlaststand))
      found = 1;

    if(!found)
      _id_12EBA3D580C9458A = get_next_player_index(_id_12EBA3D580C9458A);
  }

  level.current_spawn_scoring_index = _id_12EBA3D580C9458A;
  return _id_12EBA3D580C9458A;
}

get_current_spawn_score_player_index(_id_85711BA5CCA7C90C, _id_BDF059129BDD23A3) {
  if(!isDefined(_id_85711BA5CCA7C90C))
    _id_85711BA5CCA7C90C = get_spawn_scoring_array();

  _id_A1780ACBE9372380 = _id_85711BA5CCA7C90C.size;

  if(_id_A1780ACBE9372380 <= 1)
    return 0;

  _id_12EBA3D580C9458A = undefined;
  _id_6686FFCF922E1B7C = scripts\engine\utility::array_sort_with_func(_id_85711BA5CCA7C90C, ::sort_by_ai_assigned);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6686FFCF922E1B7C.size; _id_AC0E594AC96AA3A8++) {
    player = _id_6686FFCF922E1B7C[_id_AC0E594AC96AA3A8];

    for(_id_BC6826D602EF944A = 0; _id_BC6826D602EF944A < 2; _id_BC6826D602EF944A++) {
      if(_id_BC6826D602EF944A || istrue(player.spectating) && !istrue(player.inlaststand) && !istrue(player.ignoreme)) {
        for(_id_AC0E5B4AC96AA80E = 0; _id_AC0E5B4AC96AA80E < _id_85711BA5CCA7C90C.size; _id_AC0E5B4AC96AA80E++) {
          if(_id_85711BA5CCA7C90C[_id_AC0E5B4AC96AA80E] == player) {
            _id_12EBA3D580C9458A = _id_AC0E5B4AC96AA80E;

            if(isPlayer(player))
              self.assigned_ai_index = _id_12EBA3D580C9458A;
            else
              self.assigned_ai_index = undefined;

            break;
          }
        }

        if(isDefined(_id_12EBA3D580C9458A)) {
          break;
        }
      }
    }

    if(isDefined(_id_12EBA3D580C9458A)) {
      break;
    }
  }

  if(!isDefined(_id_12EBA3D580C9458A))
    return randomint(level.players.size);
  else
    return _id_12EBA3D580C9458A;
}

get_next_player_index(index, _id_BDF059129BDD23A3) {
  _id_85711BA5CCA7C90C = get_spawn_scoring_array();
  index = level.current_spawn_scoring_index;
  _id_12EBA3D580C9458A = index;

  if(!istrue(_id_BDF059129BDD23A3))
    _id_12EBA3D580C9458A = index + 1;

  if(isDefined(_id_85711BA5CCA7C90C[_id_12EBA3D580C9458A]))
    return _id_12EBA3D580C9458A;
  else {
    _id_12EBA3D580C9458A++;

    for(_id_B1C605F611EAC779 = 0; _id_B1C605F611EAC779 < _id_85711BA5CCA7C90C.size; _id_B1C605F611EAC779++) {
      if(isDefined(_id_85711BA5CCA7C90C[_id_12EBA3D580C9458A]))
        return _id_12EBA3D580C9458A;

      if(_id_12EBA3D580C9458A >= _id_85711BA5CCA7C90C.size) {
        _id_12EBA3D580C9458A = 0;
        continue;
      }

      _id_12EBA3D580C9458A++;
    }

    return 0;
  }
}

score_ai_spawns(spawnpoints, respawn, _id_C62B3B643F30BDDF, _id_596674BD1F7B0B01, _id_BDF059129BDD23A3) {
  _id_B8D119D2C9609296 = undefined;
  _id_AE58980967627913 = get_best_scoring_target(_id_BDF059129BDD23A3);
  self.skip_forward_score_factor = undefined;

  if(!isDefined(_id_AE58980967627913))
    return undefined;

  if(istrue(self.use_respawn_rules))
    respawn = 1;

  self.current_time = gettime();
  _id_9ED7CD9678338A4E = get_score_target_pos(_id_AE58980967627913);
  _id_7E4F5E9726221EEC = get_score_target_override(_id_9ED7CD9678338A4E);
  self.spawn_ref_point = _id_9ED7CD9678338A4E;
  self.spawn_ref_point_override = _id_7E4F5E9726221EEC;
  _id_651A5674B0C8A1E6 = get_array_of_valid_spawnpoints(spawnpoints, respawn, undefined, _id_596674BD1F7B0B01);

  if(_id_651A5674B0C8A1E6.size < 1)
    return undefined;

  self.current_time = gettime();
  _id_06CB3B2286C446E9 = 1;

  if(_id_06CB3B2286C446E9)
    _id_2D2FF52E5D86488D = score_valid_spawnpoints(_id_651A5674B0C8A1E6, _id_C62B3B643F30BDDF, _id_596674BD1F7B0B01, spawnpoints);
  else
    _id_2D2FF52E5D86488D = [_id_651A5674B0C8A1E6[0]];

  if(_id_2D2FF52E5D86488D.size < 1)
    return undefined;

  _id_392FFC940F74DEB1 = undefined;

  if(_id_2D2FF52E5D86488D.size > 0)
    _id_B8D119D2C9609296 = _id_2D2FF52E5D86488D[randomint(_id_2D2FF52E5D86488D.size)];

  if(isDefined(_id_B8D119D2C9609296)) {
    if(istrue(_id_B8D119D2C9609296.script_forcespawn) || _id_B8D119D2C9609296 passes_forward_check(self) && _id_B8D119D2C9609296 passes_final_capsule_check() && avoids_recently_cleared_area(_id_B8D119D2C9609296))
      return _id_B8D119D2C9609296;
    else {
      _id_1AB83F97430541A3 = 10000;

      if(isDefined(level.seen_recently_spawner_time))
        _id_1AB83F97430541A3 = level.seen_recently_spawner_time;

      _id_B8D119D2C9609296.lastspawntime = self.current_time + _id_1AB83F97430541A3;
      level notify("update_spawnpoint_debug_prints");
      return undefined;
    }
  } else {
    level notify("update_spawnpoint_debug_prints");
    return undefined;
  }
}

passes_final_capsule_check() {
  return capsuletracepassed(self.origin + (0, 0, 6), 16, 32, undefined, 1, 1);
}

avoids_recently_cleared_area(spawnpoint) {
  if(istrue(level.skip_player_pos_memory))
    return 1;

  message = undefined;
  _id_78BABF35878BCD24 = undefined;
  _id_08F4AC8EA1ADB1DC = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    array = level.players[_id_AC0E594AC96AA3A8] get_player_velo_array();

    if(isDefined(array) && array.size > 0) {
      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < array.size; _id_AC0E5C4AC96AAA41++) {
        if(distance2dsquared(array[_id_AC0E5C4AC96AAA41], spawnpoint.origin) <= 65536) {
          add_to_score_message(_id_08F4AC8EA1ADB1DC, "Player Cleared", undefined, undefined, 1, spawnpoint);
          return 0;
        }
      }
    }
  }

  return 1;
}

set_spawner_chosen_nearby() {
  self.spawner_chosen_nearby = 1;
  wait 2.5;
  self.spawner_chosen_nearby = undefined;
}

score_valid_spawnpoints(_id_651A5674B0C8A1E6, _id_C62B3B643F30BDDF, _id_596674BD1F7B0B01, spawnpoints) {
  _id_2D2FF52E5D86488D = [];
  _id_B8D119D2C9609296 = undefined;
  _id_14A4C0722F7ACA27 = 0;
  _id_27E45D4285530C95 = [];
  _id_E97BD95F1F9771E1 = 0;
  _id_23FFD71550B6DC5F = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_651A5674B0C8A1E6.size; _id_AC0E594AC96AA3A8++) {
    spawn_scoring_type = _id_651A5674B0C8A1E6[_id_AC0E594AC96AA3A8] get_spawn_scoring_type();

    if(isDefined(level.spawner_scoring_allow_early_out[spawn_scoring_type]) && !level.spawner_scoring_allow_early_out[spawn_scoring_type]) {
      _id_23FFD71550B6DC5F = 0;
      break;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_651A5674B0C8A1E6.size; _id_AC0E594AC96AA3A8++) {
    spawn_scoring_type = _id_651A5674B0C8A1E6[_id_AC0E594AC96AA3A8] get_spawn_scoring_type();
    result = [[level.spawner_scoring_funcs[spawn_scoring_type]]](_id_651A5674B0C8A1E6[_id_AC0E594AC96AA3A8], undefined, _id_596674BD1F7B0B01, spawnpoints);

    if(isDefined(result)) {
      if(!isDefined(_id_B8D119D2C9609296) || isDefined(_id_14A4C0722F7ACA27) && isDefined(result.totalscore) && result.totalscore > _id_14A4C0722F7ACA27) {
        _id_B8D119D2C9609296 = result;
        _id_14A4C0722F7ACA27 = result.totalscore;
      }

      _id_E97BD95F1F9771E1 = isDefined(result.fnchildscorefunc);

      if(_id_E97BD95F1F9771E1)
        _id_27E45D4285530C95[_id_27E45D4285530C95.size] = result;

      if(_id_23FFD71550B6DC5F && result.totalscore >= 950.0) {
        if(!istrue(_id_C62B3B643F30BDDF))
          result.totalscore = undefined;

        return [result];
      } else if(result.totalscore > 500.0) {
        if(!_id_E97BD95F1F9771E1)
          _id_2D2FF52E5D86488D[_id_2D2FF52E5D86488D.size] = result;

        if(_id_23FFD71550B6DC5F) {
          if(istrue(_id_C62B3B643F30BDDF)) {
            if(_id_2D2FF52E5D86488D.size >= 5)
              return _id_2D2FF52E5D86488D;
          } else
            result.totalscore = undefined;
        }
      }
    }
  }

  if(_id_27E45D4285530C95.size > 0) {
    _id_DFDB346FD48D6FAF = undefined;
    _id_053A4DA52F050A4F = -99999;
    _id_035EA3CD053DB31F = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_27E45D4285530C95.size; _id_AC0E594AC96AA3A8++) {
      _id_70159D1F6CC7B7FD = _id_27E45D4285530C95[_id_AC0E594AC96AA3A8];

      if(isDefined(_id_70159D1F6CC7B7FD.totalscore) && _id_70159D1F6CC7B7FD.totalscore > _id_053A4DA52F050A4F) {
        _id_053A4DA52F050A4F = _id_70159D1F6CC7B7FD.totalscore;
        _id_DFDB346FD48D6FAF = _id_70159D1F6CC7B7FD;
        _id_035EA3CD053DB31F = _id_70159D1F6CC7B7FD.fnchildscorefunc;
      }

      if(!istrue(_id_C62B3B643F30BDDF)) {
        _id_70159D1F6CC7B7FD.totalscore = undefined;
        _id_70159D1F6CC7B7FD.fnchildscorefunc = undefined;
      }
    }

    if(isDefined(_id_DFDB346FD48D6FAF)) {
      _id_168E835CF3A0DFF0 = [[_id_035EA3CD053DB31F]](_id_DFDB346FD48D6FAF, undefined, _id_596674BD1F7B0B01);

      if(isDefined(_id_168E835CF3A0DFF0)) {
        if(isarray(_id_168E835CF3A0DFF0)) {
          for(_id_1D86078F33BAFC19 = 0; _id_1D86078F33BAFC19 < _id_168E835CF3A0DFF0.size; _id_1D86078F33BAFC19++) {
            if(_id_168E835CF3A0DFF0[_id_1D86078F33BAFC19].totalscore > 500.0)
              _id_2D2FF52E5D86488D[_id_2D2FF52E5D86488D.size] = _id_168E835CF3A0DFF0[_id_1D86078F33BAFC19];
          }
        } else if(_id_168E835CF3A0DFF0.totalscore > 500.0)
          _id_2D2FF52E5D86488D[_id_2D2FF52E5D86488D.size] = _id_168E835CF3A0DFF0;
      }
    }
  }

  if(_id_2D2FF52E5D86488D.size > 0)
    return _id_2D2FF52E5D86488D;
  else if(isDefined(_id_B8D119D2C9609296)) {
    spawn_scoring_type = _id_B8D119D2C9609296 get_spawn_scoring_type();

    if(spawn_scoring_type == "cluster_spawner")
      return [];
    else
      return [_id_B8D119D2C9609296];
  } else
    return [];
}

print_spawnpoint_debug(_id_401C3A2E68AAB0FD, color, waittill_notify) {
  self notify("print_spawnpoint_debug");
  self endon("print_spawnpoint_debug");
  radius = 16;
  height = 16;
  spawn_scoring_type = get_spawn_scoring_type();

  if(spawn_scoring_type == "vehicle_spawner") {
    radius = 48;
    height = 48;
  }

  if(istrue(level.spawnpoint_debug)) {
    if(isDefined(waittill_notify))
      level waittill(waittill_notify);

    level endon("update_spawnpoint_debug_prints");
    level endon("end_spawnpoint_debug");

    for(;;) {
      thread scripts\engine\utility::draw_capsule(self.origin, radius, height, (0, 0, 0), color, 0, 1);
      waitframe();
    }
  }
}

passes_forward_check(_id_8AA2609E46B64970) {
  if(isDefined(self) && !isvector(self)) {
    if(isDefined(self.script_dot)) {
      compare = int(self.script_dot) == 1;

      for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < level.players.size; _id_AC0E5C4AC96AAA41++) {
        if(scripts\cp\cp_spawning_util::cp_is_point_in_front(level.players[_id_AC0E5C4AC96AAA41].origin) == compare) {
          if(isDefined(self.script_dist_only)) {
            if(distancesquared(level.players[_id_AC0E5C4AC96AAA41].origin, self.origin) <= int(self.script_dist_only)) {
              thread _id_18A73A64992DD07D::disable_spawn_point(self, undefined, _id_8AA2609E46B64970);
              return 0;
            }
          } else {
            thread _id_18A73A64992DD07D::disable_spawn_point(self, undefined, _id_8AA2609E46B64970);
            return 0;
          }
        }
      }
    } else if(isDefined(self.script_dist_only)) {
      for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < level.players.size; _id_AC0E424AC96A7113++) {
        if(distancesquared(level.players[_id_AC0E424AC96A7113].origin, self.origin) <= int(self.script_dist_only)) {
          thread _id_18A73A64992DD07D::disable_spawn_point(self, undefined, _id_8AA2609E46B64970);
          return 0;
        }
      }
    }
  }

  return 1;
}

calculate_ai_cluster_spawner_score(spawnpoint, _id_0432A6B6AADCC1EF) {
  message = undefined;
  _id_78BABF35878BCD24 = undefined;
  _id_08F4AC8EA1ADB1DC = undefined;
  totalscore = level.total_cluster_spawn_score;
  _id_72BB89E60D3674DF = 0;
  weight = 8;
  _id_913B73097FDCDB62 = score_factor_ai(weight / totalscore, ::is_cluster_spawner_ideal_distance, spawnpoint, _id_0432A6B6AADCC1EF);

  if(!isDefined(_id_913B73097FDCDB62))
    return 0;

  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_913B73097FDCDB62;
  _id_2653F927DF4A0BF4 = 5;
  _id_8766534BE41302A9 = score_factor_ai(_id_2653F927DF4A0BF4 / totalscore, ::is_spawner_towards_objective, spawnpoint, _id_0432A6B6AADCC1EF);

  if(!isDefined(_id_8766534BE41302A9))
    return 0;

  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_8766534BE41302A9;
  spawnpoint.totalscore = int(_id_72BB89E60D3674DF);
  spawnpoint.fnchildscorefunc = ::cluster_child_spawnpoint_scoring;
  return 1;
}

calculate_ai_veh_spawner_score(spawnpoint, _id_0432A6B6AADCC1EF) {
  message = undefined;
  _id_78BABF35878BCD24 = undefined;
  _id_08F4AC8EA1ADB1DC = undefined;
  totalscore = level.total_veh_spawn_score;
  _id_72BB89E60D3674DF = 0;
  weight = 2;
  _id_913B73097FDCDB62 = score_factor_ai(weight / totalscore, ::is_vehicle_spawner_ideal_distance, spawnpoint, _id_0432A6B6AADCC1EF, undefined, 1250);

  if(!isDefined(_id_913B73097FDCDB62))
    return 0;

  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_913B73097FDCDB62;
  weight = 1;
  _id_913B73097FDCDB62 = score_factor_ai(weight / totalscore, ::is_spawner_towards_objective, spawnpoint, _id_0432A6B6AADCC1EF);

  if(!isDefined(_id_913B73097FDCDB62))
    return 0;

  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_913B73097FDCDB62;
  spawnpoint.totalscore = int(_id_72BB89E60D3674DF);
  return 1;
}

calculate_ai_spawner_score(spawnpoint, _id_0432A6B6AADCC1EF, debug, spawnpoints) {
  message = undefined;
  _id_78BABF35878BCD24 = undefined;
  _id_08F4AC8EA1ADB1DC = undefined;
  totalscore = level.total_spawn_score;
  _id_72BB89E60D3674DF = 0;
  weight = 4;
  _id_913B73097FDCDB62 = score_factor_ai(weight / totalscore, ::is_spawner_ideal_distance, spawnpoint, _id_0432A6B6AADCC1EF);

  if(!isDefined(_id_913B73097FDCDB62)) {
    if(istrue(debug))
      _id_913B73097FDCDB62 = -10000;
    else
      return 0;
  }

  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_913B73097FDCDB62;
  weight = 4;
  _id_913B73097FDCDB62 = score_factor_ai(weight / totalscore, ::avoid_recently_used_spawns, spawnpoint);

  if(!isDefined(_id_913B73097FDCDB62)) {
    if(istrue(debug))
      _id_913B73097FDCDB62 = -10000;
    else
      return 0;
  }

  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_913B73097FDCDB62;
  weight = 0;
  _id_913B73097FDCDB62 = score_factor_ai(weight / totalscore, ::avoid_players_vision, spawnpoint);

  if(!isDefined(_id_913B73097FDCDB62)) {
    if(istrue(debug))
      _id_913B73097FDCDB62 = -10000;
    else
      return 0;
  }

  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_913B73097FDCDB62;
  weight = 5;
  _id_913B73097FDCDB62 = score_factor_ai(weight / totalscore, ::is_spawner_towards_objective, spawnpoint, _id_0432A6B6AADCC1EF);

  if(!isDefined(_id_913B73097FDCDB62)) {
    if(istrue(debug))
      _id_913B73097FDCDB62 = -10000;
    else
      return 0;
  }

  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_913B73097FDCDB62;
  weight = 5;
  _id_913B73097FDCDB62 = score_factor_ai(weight / totalscore, ::weight_spawners_closest_to_forward, spawnpoint);

  if(!isDefined(_id_913B73097FDCDB62))
    return 0;

  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_913B73097FDCDB62;
  weight = 5;
  _id_913B73097FDCDB62 = score_factor_ai(weight / totalscore, ::has_spawner_chosen_nearby_flag, spawnpoint);

  if(!isDefined(_id_913B73097FDCDB62)) {
    if(istrue(debug))
      _id_913B73097FDCDB62 = -10000;
    else
      return 0;
  }

  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_913B73097FDCDB62;
  weight = 2;
  _id_913B73097FDCDB62 = score_factor_ai(weight / totalscore, ::is_close_to_player_z, spawnpoint, _id_0432A6B6AADCC1EF);

  if(!isDefined(_id_913B73097FDCDB62)) {
    if(istrue(debug))
      _id_913B73097FDCDB62 = -10000;
    else
      return 0;
  }

  _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_913B73097FDCDB62;
  spawnpoint.totalscore = int(_id_72BB89E60D3674DF);
  return 1;
}

is_close_to_player_z(spawnpoint, _id_0432A6B6AADCC1EF) {
  player = level.players[_id_0432A6B6AADCC1EF];

  if(isDefined(self.spawn_ref_point))
    _id_18A2800BC2414B53 = self.spawn_ref_point[2];
  else
    _id_18A2800BC2414B53 = player.origin[2];

  if(isvector(spawnpoint))
    _id_30D0ECAFD8AA6711 = int(abs(spawnpoint[2] - _id_18A2800BC2414B53));
  else
    _id_30D0ECAFD8AA6711 = int(abs(spawnpoint.origin[2] - _id_18A2800BC2414B53));

  if(_id_30D0ECAFD8AA6711 <= 128)
    return 1000;
  else
    return 1000 / int(_id_30D0ECAFD8AA6711 / 32);
}

score_spawner_relative_to_objective(_id_9832DDE9AFB5565C, _id_9D5EBD8DBF54C6AC, _id_1F810C7DF46FFB0E, _id_A299BAE2B12AA472) {
  _id_053A4DA52F050A4F = 1000;
  _id_445ACA8C2C95592E = 0.707;
  _id_935BA925E6FC497C = -0.5;
  _id_38F868494486FD60 = _id_053A4DA52F050A4F * 0.5;
  _id_244A6693D35086E1 = 0;
  _id_528C2BA90B381005 = 1024;
  _id_88A5204C5DEE932E = 262144;
  _id_E1F1195815227FE0 = _id_9D5EBD8DBF54C6AC - _id_9832DDE9AFB5565C;
  _id_E1F1195815227FE0 = (_id_E1F1195815227FE0[0], _id_E1F1195815227FE0[1], 0);
  _id_F0FD166C750FAC7C = length(_id_E1F1195815227FE0);

  if(_id_F0FD166C750FAC7C > 0)
    _id_E1F1195815227FE0 = _id_E1F1195815227FE0 / _id_F0FD166C750FAC7C;

  dot = vectordot(_id_1F810C7DF46FFB0E, _id_E1F1195815227FE0);

  if(_id_F0FD166C750FAC7C > _id_528C2BA90B381005) {
    self.allow_forward_factor = 1;

    if(dot < _id_244A6693D35086E1)
      return 0;
    else if(dot * _id_A299BAE2B12AA472 > _id_F0FD166C750FAC7C)
      return 0;
    else if(dot < _id_445ACA8C2C95592E) {
      f = 1 - (_id_445ACA8C2C95592E - dot) / (_id_445ACA8C2C95592E - _id_244A6693D35086E1);
      return _id_053A4DA52F050A4F * f;
    } else
      return _id_053A4DA52F050A4F;
  } else {
    self.allow_forward_factor = 0;

    if(dot > _id_244A6693D35086E1)
      return 0;
    else if(dot > _id_935BA925E6FC497C) {
      f = 1 - (_id_935BA925E6FC497C - dot) / (_id_935BA925E6FC497C - _id_244A6693D35086E1);
      return _id_053A4DA52F050A4F * f;
    } else
      return _id_053A4DA52F050A4F;
  }

  return 0;
}

is_spawner_towards_objective(spawnpoint, _id_0432A6B6AADCC1EF) {
  if(!isDefined(level.activequests) || level.activequests.size < 1) {
    self.skip_forward_score_factor = undefined;
    return 1000;
  } else {
    player = level.players[_id_0432A6B6AADCC1EF];

    if(!isDefined(player))
      player = level.players[0];

    _id_18A2800BC2414B53 = player.origin;
    _id_5566EA9A726700E7 = spawnpoint.origin;
    _id_17756A44A05002DE = _id_5566EA9A726700E7 - _id_18A2800BC2414B53;
    _id_17756A44A05002DE = (_id_17756A44A05002DE[0], _id_17756A44A05002DE[1], 0);
    _id_311C45D876A94904 = length(_id_17756A44A05002DE);

    if(_id_311C45D876A94904 > 0)
      _id_17756A44A05002DE = _id_17756A44A05002DE / _id_311C45D876A94904;

    _id_053A4DA52F050A4F = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.activequests.size; _id_AC0E594AC96AA3A8++) {
      _id_12461E617D024EF9 = level.activequests[_id_AC0E594AC96AA3A8];

      if(isDefined(_id_12461E617D024EF9.objectivelocations) && _id_12461E617D024EF9.objectivelocations.size > 0) {
        for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < _id_12461E617D024EF9.objectivelocations.size; _id_AC0E5C4AC96AAA41++) {
          _id_03ED87EA90882333 = _id_12461E617D024EF9.objectivelocations[_id_AC0E5C4AC96AAA41];
          score = score_spawner_relative_to_objective(_id_18A2800BC2414B53, _id_03ED87EA90882333, _id_17756A44A05002DE, _id_311C45D876A94904);

          if(!isDefined(_id_053A4DA52F050A4F) || score > _id_053A4DA52F050A4F) {
            if(istrue(self.allow_forward_factor))
              self.skip_forward_score_factor = 1;
            else
              self.skip_forward_score_factor = undefined;

            _id_053A4DA52F050A4F = score;
          }

          self.allow_forward_factor = undefined;
        }
      }
    }

    if(isDefined(_id_053A4DA52F050A4F))
      return _id_053A4DA52F050A4F;
  }

  self.skip_forward_score_factor = undefined;
  return 1000;
}

has_spawner_chosen_nearby_flag(spawnpoint) {
  if(istrue(spawnpoint.spawner_chosen_nearby))
    return 1000;
  else
    return 0;
}

avoid_players_vision(spawnpoint) {
  if(isDefined(spawnpoint.script_parent) || istrue(spawnpoint.script_forcespawn) || istrue(spawnpoint _id_0E80538EF14D00E1::is_vehicle_spawnpoint()) || !isDefined(level.players) || level.players.size < 1)
    return 1000;

  _id_9D3207145B5E514C = 1000 / level.players.size;
  _id_4F86BF5BE5E42647 = undefined;
  _id_F104A131C0A929A2 = get_player_array();

  if(run_func_on_each_player(::spawnpoint_is_within_sight, 1, spawnpoint)) {
    spawnpoint.lastspawntime = self.current_time;
    return undefined;
  } else
    return _id_9D3207145B5E514C;
}

should_use_velo_forward() {
  _id_DD6FBB1FF2A513C9 = self.velo_forward - self.origin;
  _id_DD6FBB1FF2A513C9 = (_id_DD6FBB1FF2A513C9[0], _id_DD6FBB1FF2A513C9[1], 0);
  _id_13B97A8DA9DFEA88 = length(_id_DD6FBB1FF2A513C9);

  if(_id_13B97A8DA9DFEA88 > 0)
    return 1;
  else
    return 0;
}

weight_spawners_closest_to_forward(spawnpoint, spawnpoints) {
  _id_9D3207145B5E514C = 1000;

  if(isDefined(spawnpoint.script_parent) || istrue(spawnpoint.script_forcespawn) || istrue(spawnpoint _id_0E80538EF14D00E1::is_vehicle_spawnpoint()) || !isDefined(level.players) || istrue(self.skip_forward_score_factor) || level.players.size < 1)
    return _id_9D3207145B5E514C;

  _id_B8D4B06FA0E4099E = 0;
  _id_79B9256C5DA3C044 = 0;
  _id_119E10BD34398BA0 = 0;
  _id_F104A131C0A929A2 = get_player_array();

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F104A131C0A929A2.size; _id_AC0E594AC96AA3A8++) {
    if(isPlayer(_id_F104A131C0A929A2[_id_AC0E594AC96AA3A8])) {
      angles = _id_F104A131C0A929A2[_id_AC0E594AC96AA3A8] getplayerangles();

      if(isDefined(_id_F104A131C0A929A2[_id_AC0E594AC96AA3A8].velo_forward) && _id_F104A131C0A929A2[_id_AC0E594AC96AA3A8] should_use_velo_forward())
        angles = vectortoangles(_id_F104A131C0A929A2[_id_AC0E594AC96AA3A8].velo_forward - _id_F104A131C0A929A2[_id_AC0E594AC96AA3A8].origin);

      _id_B8D4B06FA0E4099E = _id_B8D4B06FA0E4099E + scripts\engine\math::get_dot(_id_F104A131C0A929A2[_id_AC0E594AC96AA3A8].origin, angles, spawnpoint.origin);
    } else {
      angles = _id_F104A131C0A929A2[_id_AC0E594AC96AA3A8].angles;
      _id_B8D4B06FA0E4099E = _id_B8D4B06FA0E4099E + scripts\engine\math::get_dot(_id_F104A131C0A929A2[_id_AC0E594AC96AA3A8].origin, angles, spawnpoint.origin);
    }

    _id_119E10BD34398BA0++;
  }

  if(_id_119E10BD34398BA0 == 0)
    return _id_9D3207145B5E514C;
  else {
    _id_79B9256C5DA3C044 = _id_B8D4B06FA0E4099E / _id_119E10BD34398BA0;
    return _id_9D3207145B5E514C * _id_79B9256C5DA3C044;
  }
}

run_func_on_each_player(func, _id_8FE112BDF78BC8E4, _id_EB8DD9106F941B72, _id_EB8DD8106F94193F) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
    _id_E3108E412AFB3811 = level.players[_id_AC0E594AC96AA3A8][[func]](_id_EB8DD9106F941B72, _id_EB8DD8106F94193F);

    if(isDefined(_id_8FE112BDF78BC8E4) && isDefined(_id_E3108E412AFB3811) && scripts\engine\utility::is_equal(_id_8FE112BDF78BC8E4, _id_E3108E412AFB3811))
      return 1;
  }

  return 0;
}

spawnpoint_is_within_sight(spawnpoint, _id_EB8DD8106F94193F) {
  if(isPlayer(self) && !scripts\cp\utility::is_valid_player(1))
    return 0;

  angles = get_within_sight_angles();
  _id_7FE710B31B2B752D = self getEye();
  _id_C869F57096AFA5EE = spawnpoint.origin + (0, 0, 56);
  _id_3A144F22E939C877 = scripts\engine\utility::within_fov(_id_7FE710B31B2B752D, angles, _id_C869F57096AFA5EE, cos(65)) && sighttracepassed(_id_7FE710B31B2B752D, _id_C869F57096AFA5EE, 0, undefined, 1);
  return _id_3A144F22E939C877;
}

reset_nearby_spawn_times(spawnpoint, spawnpoints, time) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < spawnpoints.size; _id_AC0E594AC96AA3A8++)
    spawnpoints[_id_AC0E594AC96AA3A8].lastspawntime = time;
}

get_within_sight_angles() {
  return self getplayerangles();
}

is_vehicle_spawner_ideal_distance(spawnpoint, _id_0432A6B6AADCC1EF) {
  _id_F104A131C0A929A2 = level.players;
  player = level.players[_id_0432A6B6AADCC1EF];
  _id_18A2800BC2414B53 = player.origin;
  _id_4C3EEADD59CD0CA6 = 0;
  _id_9D3207145B5E514C = 1250;
  close_dist = 1250;
  close_dist_sq = 1562500;
  far_dist = 4000;
  far_dist_sq = 16000000;
  too_far_dist = 30000;
  too_far_dist_sq = 900000000;
  _id_E20DF67BC043C785 = 0.25;

  if(isDefined(spawnpoint.script_maxdist)) {
    too_far_dist = int(spawnpoint.script_maxdist);
    too_far_dist_sq = squared(too_far_dist);
  }

  _id_58E1B8850DF3B5C4 = distancesquared(_id_18A2800BC2414B53, spawnpoint.origin);

  if(_id_58E1B8850DF3B5C4 >= too_far_dist_sq)
    return undefined;

  if(_id_58E1B8850DF3B5C4 <= close_dist_sq)
    return _id_9D3207145B5E514C;
  else if(_id_58E1B8850DF3B5C4 <= far_dist_sq) {
    _id_0EDDADD6A0F69888 = far_dist - close_dist;
    _id_7206821DC4564B24 = sqrt(_id_58E1B8850DF3B5C4) - close_dist;
    _id_A61F687A770146F2 = 1 - _id_7206821DC4564B24 / _id_0EDDADD6A0F69888;
    return _id_9D3207145B5E514C * _id_A61F687A770146F2;
  } else if(_id_58E1B8850DF3B5C4 >= far_dist_sq) {
    _id_0EDDADD6A0F69888 = too_far_dist - far_dist;
    _id_7206821DC4564B24 = sqrt(_id_58E1B8850DF3B5C4) - far_dist;
    _id_A61F687A770146F2 = 1 - _id_7206821DC4564B24 / _id_0EDDADD6A0F69888;
    return _id_9D3207145B5E514C * _id_A61F687A770146F2 * _id_E20DF67BC043C785;
  }

  return _id_4C3EEADD59CD0CA6;
}

is_cluster_spawner_ideal_distance(spawnpoint, _id_0432A6B6AADCC1EF) {
  _id_F104A131C0A929A2 = level.players;

  if(isDefined(self.spawn_ref_point))
    _id_18A2800BC2414B53 = self.spawn_ref_point;
  else
    _id_18A2800BC2414B53 = scripts\cp\utility::get_center_point_of_array(_id_F104A131C0A929A2);

  _id_4F86BF5BE5E42647 = undefined;
  close_dist = 1024;
  close_dist_sq = 1048576;
  _id_4C3EEADD59CD0CA6 = 0;
  _id_9D3207145B5E514C = 1000 / level.players.size;
  far_score = 20;
  far_dist_sq = 4194304;
  far_dist = 2048;
  too_far_dist = 4096;
  too_far_dist_sq = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    data = level.spawn_scoring_overrides;
    close_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.close_dist, close_dist);
    close_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.close_dist_sq, close_dist_sq);
    far_score = _id_18A73A64992DD07D::define_var_if_undefined(data.far_score, far_score);
    far_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.far_dist_sq, far_dist_sq);
    far_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.far_dist, far_dist);
    too_far_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.too_far_dist, too_far_dist);
    too_far_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  }

  if(isDefined(self.spawn_scoring_overrides)) {
    data = self.spawn_scoring_overrides;
    close_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.close_dist, close_dist);
    close_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.close_dist_sq, close_dist_sq);
    far_score = _id_18A73A64992DD07D::define_var_if_undefined(data.far_score, far_score);
    far_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.far_dist_sq, far_dist_sq);
    far_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.far_dist, far_dist);
    too_far_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.too_far_dist, too_far_dist);
    too_far_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  }

  _id_E20DF67BC043C785 = 0.5;

  if(isDefined(spawnpoint.script_maxdist)) {
    too_far_dist = int(spawnpoint.script_maxdist);
    too_far_dist_sq = squared(too_far_dist);
  }

  _id_58E1B8850DF3B5C4 = distance2dsquared(_id_18A2800BC2414B53, spawnpoint.origin);

  if(_id_58E1B8850DF3B5C4 >= too_far_dist_sq)
    return undefined;
  else if(_id_58E1B8850DF3B5C4 <= far_dist_sq && _id_58E1B8850DF3B5C4 >= close_dist_sq)
    _id_4F86BF5BE5E42647 = _id_9D3207145B5E514C;
  else if(_id_58E1B8850DF3B5C4 >= far_dist_sq) {
    _id_98EA5AFB293A76A2 = 1 + _id_58E1B8850DF3B5C4 / far_dist_sq;
    _id_8586CACB3696DFE5 = far_score / _id_98EA5AFB293A76A2;
    _id_4F86BF5BE5E42647 = _id_8586CACB3696DFE5;
  } else {
    _id_8586CACB3696DFE5 = _id_9D3207145B5E514C * _id_E20DF67BC043C785;
    _id_4F86BF5BE5E42647 = _id_8586CACB3696DFE5;
  }

  return _id_4F86BF5BE5E42647;
}

is_spawner_ideal_distance(spawnpoint, _id_0432A6B6AADCC1EF) {
  if(istrue(spawnpoint.script_forcespawn))
    return 1000;

  _id_F104A131C0A929A2 = level.players;

  if(isDefined(self.spawn_ref_point))
    _id_18A2800BC2414B53 = self.spawn_ref_point;
  else
    _id_18A2800BC2414B53 = scripts\cp\utility::get_center_point_of_array(_id_F104A131C0A929A2);

  player = level.players[_id_0432A6B6AADCC1EF];
  _id_4F86BF5BE5E42647 = undefined;
  close_dist = 1024;
  close_dist_sq = 1048576;
  _id_4C3EEADD59CD0CA6 = 0;
  _id_9D3207145B5E514C = 1000 / level.players.size;
  far_score = 20;
  far_dist_sq = 4194304;
  far_dist = 2048;
  too_far_dist = 4096;
  too_far_dist_sq = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    data = level.spawn_scoring_overrides;
    close_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.close_dist, close_dist);
    close_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.close_dist_sq, close_dist_sq);
    far_score = _id_18A73A64992DD07D::define_var_if_undefined(data.far_score, far_score);
    far_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.far_dist_sq, far_dist_sq);
    far_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.far_dist, far_dist);
    too_far_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.too_far_dist, too_far_dist);
    too_far_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  }

  if(isDefined(self.spawn_scoring_overrides)) {
    data = self.spawn_scoring_overrides;
    close_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.close_dist, close_dist);
    close_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.close_dist_sq, close_dist_sq);
    far_score = _id_18A73A64992DD07D::define_var_if_undefined(data.far_score, far_score);
    far_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.far_dist_sq, far_dist_sq);
    far_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.far_dist, far_dist);
    too_far_dist = _id_18A73A64992DD07D::define_var_if_undefined(data.too_far_dist, too_far_dist);
    too_far_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  }

  _id_E20DF67BC043C785 = 0.5;

  if(isDefined(spawnpoint.script_maxdist)) {
    too_far_dist = int(spawnpoint.script_maxdist);
    too_far_dist_sq = squared(too_far_dist);
  }

  if(isDefined(too_far_dist) && isDefined(spawnpoint)) {
    _id_FCCE8B5400B99526 = 0;

    if(isvector(spawnpoint))
      _id_FCCE8B5400B99526 = scripts\common\utility::playersnear(spawnpoint, too_far_dist);
    else
      _id_FCCE8B5400B99526 = scripts\common\utility::playersnear(spawnpoint.origin, too_far_dist);

    if(_id_FCCE8B5400B99526.size < 1)
      return undefined;
  }

  if(isDefined(spawnpoint.ideal_dist)) {
    _id_41281DAC906D6AB4 = spawnpoint.ideal_dist;
    _id_AAB0A592CD72D6F5 = spawnpoint.ideal_dist * spawnpoint.ideal_dist;
  } else {
    _id_41281DAC906D6AB4 = (far_dist + close_dist) / 2;
    _id_AAB0A592CD72D6F5 = _id_41281DAC906D6AB4 * _id_41281DAC906D6AB4;
  }

  if(isDefined(spawnpoint.dist_sq_to_ref)) {
    _id_58E1B8850DF3B5C4 = spawnpoint.dist_sq_to_ref;
    spawnpoint.dist_sq_to_ref = undefined;
  } else
    _id_58E1B8850DF3B5C4 = distancesquared(_id_18A2800BC2414B53, spawnpoint.origin);

  if(_id_58E1B8850DF3B5C4 <= far_dist_sq && _id_58E1B8850DF3B5C4 >= close_dist_sq)
    return _id_9D3207145B5E514C;
  else if(_id_58E1B8850DF3B5C4 >= far_dist_sq) {
    _id_98EA5AFB293A76A2 = 1 + _id_58E1B8850DF3B5C4 / far_dist_sq;
    _id_8586CACB3696DFE5 = far_score / _id_98EA5AFB293A76A2;
    return _id_8586CACB3696DFE5;
  } else {
    _id_8586CACB3696DFE5 = _id_9D3207145B5E514C * _id_E20DF67BC043C785;
    return _id_8586CACB3696DFE5;
  }

  return _id_4C3EEADD59CD0CA6;
}

avoid_recently_used_spawns(spawnpoint) {
  _id_9D3207145B5E514C = 1000;

  if(isDefined(spawnpoint.lastspawntime)) {
    _id_3B5803E733581858 = self.current_time - spawnpoint.lastspawntime;
    _id_3D066CE4442701D0 = get_recent_spawn_time_threshold();

    if(_id_3B5803E733581858 > _id_3D066CE4442701D0)
      return _id_9D3207145B5E514C;

    _id_4FEE9FDC7BB80A41 = _id_3B5803E733581858 / _id_3D066CE4442701D0;
    return int(_id_4FEE9FDC7BB80A41 * _id_9D3207145B5E514C);
  }

  return _id_9D3207145B5E514C;
}

spawner_invalid_due_to_recently_used(spawnpoint, _id_3B5803E733581858) {
  if(!isDefined(spawnpoint.lastspawntime)) {
    spawnpoint.lastspawntime = self.current_time;
    return 1;
  }

  _id_3B5803E733581858 = self.current_time - spawnpoint.lastspawntime;
  _id_3D066CE4442701D0 = get_recent_spawn_time_threshold();
  _id_4FEE9FDC7BB80A41 = _id_3B5803E733581858 / _id_3D066CE4442701D0;

  if(_id_4FEE9FDC7BB80A41 <= 0.5)
    return 0;
  else
    return 1;
}

get_recent_spawn_time_threshold() {
  if(isDefined(self.recent_spawn_threshold))
    return self.recent_spawn_threshold;
  else
    return 20000;
}

sort_by_ai_assigned(a, b) {
  if(isDefined(a.assigned_ai) && isDefined(b.assigned_ai))
    return a.assigned_ai < b.assigned_ai;
  else
    return 0;
}

get_spawn_scoring_array() {
  if(isDefined(level.players) && level.players.size > 0)
    return scripts\cp\utility::get_array_of_valid_players();
  else
    return [];
}

get_close_distance_var(_id_AFDAE23BA5CDC204) {
  close_dist = 1024;
  close_dist_sq = 1048576;

  if(isDefined(self.spawn_scoring_overrides)) {
    if(istrue(_id_AFDAE23BA5CDC204))
      return _id_18A73A64992DD07D::define_var_if_undefined(self.spawn_scoring_overrides.close_dist_sq, close_dist_sq);
    else
      return _id_18A73A64992DD07D::define_var_if_undefined(self.spawn_scoring_overrides.close_dist, close_dist);
  } else if(isDefined(level.spawn_scoring_overrides)) {
    if(istrue(_id_AFDAE23BA5CDC204))
      return _id_18A73A64992DD07D::define_var_if_undefined(level.spawn_scoring_overrides.close_dist_sq, close_dist_sq);
    else
      return _id_18A73A64992DD07D::define_var_if_undefined(level.spawn_scoring_overrides.close_dist, close_dist);
  } else if(istrue(self.cqb_module)) {
    if(istrue(_id_AFDAE23BA5CDC204))
      return 110889;
    else
      return 333;
  } else if(istrue(_id_AFDAE23BA5CDC204))
    return close_dist_sq;
  else
    return close_dist;
}

get_player_array() {
  _id_F104A131C0A929A2 = level.players;
  return _id_F104A131C0A929A2;
}

print_spawner_score_for_factor(spawnpoint) {
  self.score_message = undefined;
}

create_debug_model_for_spawnpoint(group, color) {
  if(getdvarint("dvar_0BF3EAE56EDFFB7F")) {
    spawn_scoring_type = get_spawn_scoring_type();

    if(spawn_scoring_type == "vehicle_spawner") {
      return;
    }
    _id_7C9DF333D692BA19 = spawn("script_model", self.origin);

    if(!isDefined(group.spawner_debug_model))
      group.spawner_debug_model = [];

    group.spawner_debug_model[group.spawner_debug_model.size] = _id_7C9DF333D692BA19;

    if(isDefined(self.angles))
      _id_7C9DF333D692BA19.angles = self.angles;

    switch (spawn_scoring_type) {
      case "cluster_spawner":
        _id_7C9DF333D692BA19 setModel("com_teddy_bear");
        break;
      default:
        _id_7C9DF333D692BA19 setModel("british_pilot_fullbody");
        break;
    }

    scripts\cp\cp_outline::enable_outline_for_players(_id_7C9DF333D692BA19, level.players, color);
  }
}

add_to_score_message(_id_32207D01DE93E75D, message, _id_913B73097FDCDB62, override, _id_10E401A6F6D6CB7E, spawnpoint) {
  if(getdvarint("dvar_B050BE7DE75CD841", 0)) {
    if(isDefined(spawnpoint)) {
      if(!isDefined(spawnpoint.uid))
        get_available_unique_id(spawnpoint);

      uid = spawnpoint.uid;
    } else
      uid = get_available_unique_id();

    if(!isDefined(self.score_message))
      create_score_message();

    self.score_message_spawners[uid] = spawnpoint;

    if(istrue(override) || !isDefined(_id_32207D01DE93E75D))
      _id_32207D01DE93E75D = "";

    if(!isDefined(_id_913B73097FDCDB62))
      _id_913B73097FDCDB62 = "";

    if(!isDefined(message))
      message = "";

    if(_id_32207D01DE93E75D.size > 0 || message.size > 0)
      message = "|" + message;

    message = _id_32207D01DE93E75D + "^0" + message + "^5" + _id_913B73097FDCDB62;

    if(istrue(_id_10E401A6F6D6CB7E))
      self.score_message[uid] = message;

    return message;
  }
}

create_score_message() {
  if(getdvarint("dvar_B050BE7DE75CD841", 0)) {
    self.score_message = [];
    self.score_message_spawners = [];
    group_name = self.group_name;

    if(!isDefined(group_name))
      group_name = "";

    msg = "^7#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#^0" + group_name + "^7#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#";
    add_to_score_message(undefined, msg, undefined, undefined, 1);
  }
}

get_available_unique_id(spawnpoint) {
  if(!isDefined(self.current_uid))
    self.current_uid = 0;

  if(isDefined(spawnpoint))
    spawnpoint.uid = self.current_uid;

  _id_AFF4D33BA5E9CA11 = self.current_uid;
  self.current_uid++;
  return _id_AFF4D33BA5E9CA11;
}

get_unique_id() {
  if(isDefined(self.uid))
    return self.uid;
  else
    return undefined;
}

set_chosen_spawner_from_uid(spawnpoint) {
  if(getdvarint("dvar_B050BE7DE75CD841", 0)) {
    uid = spawnpoint get_unique_id();
    spawnpoint.chosen = 1;

    if(isDefined(uid)) {
      msg = self.score_message[uid];

      if(isDefined(msg)) {
        msg = "^5CHOSEN: " + msg;
        self.score_message[uid] = msg;
      }
    }
  }
}

get_too_far_dist_sq(spawnpoint) {
  too_far_dist_sq = 16777216;

  if(isDefined(level.spawn_scoring_overrides)) {
    data = level.spawn_scoring_overrides;
    too_far_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  } else if(isDefined(self.spawn_scoring_overrides)) {
    data = self.spawn_scoring_overrides;
    too_far_dist_sq = _id_18A73A64992DD07D::define_var_if_undefined(data.too_far_dist_sq, too_far_dist_sq);
  }

  if(isDefined(spawnpoint.script_maxdist)) {
    too_far_dist = int(spawnpoint.script_maxdist);
    too_far_dist_sq = squared(too_far_dist);
  }

  return too_far_dist_sq;
}