/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_21787630bbee2a4.gsc
***********************************************/

init() {
  level._effect["drone_turret_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_lrg_dest_exp.vfx");
  level.drone_turrets = [];
}

_id_CB2C1DF00BD5E191(spawnpoint, _id_F716273270785091) {
  return _id_87DD7CFA8068C008(spawnpoint, "axis", _id_F716273270785091);
}

_id_BCA2AE187983E50A(spawnpoint) {
  _id_87DD7CFA8068C008(spawnpoint, "allies");
}

_id_87DD7CFA8068C008(spawnpoint, _id_C1E547BABA2E6F87, _id_F716273270785091) {
  startpos = spawnpoint.origin;
  startang = spawnpoint.angles;
  vehicleinfo = "veh_radar_drone_recon_mp";
  _id_B923287498A8519A = "veh8_mil_air_tuniform_c4_ai";
  drone = spawnVehicle(_id_B923287498A8519A, "drone_turret", vehicleinfo, startpos, startang);
  drone.team = _id_C1E547BABA2E6F87;
  drone.spawnpoint = spawnpoint;
  drone makeentitysentient(_id_C1E547BABA2E6F87);
  drone thread damage_feedback_watch();
  drone thread _id_5E52AE7FC7833E15();
  drone thread patrol_think(spawnpoint, _id_F716273270785091);
  drone thread watch_for_death();
  drone thread _id_94D8111112FFC480();
  drone setscriptablepartstate("lights", "on", 0);
  drone setscriptablepartstate("glint", "on", 0);
  drone enableaimassist();

  if(!isDefined(level.vehicle_ai_script_models))
    level.vehicle_ai_script_models = [];

  level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = drone;
  level.drone_turrets[level.drone_turrets.size] = drone;
  return drone;
}

patrol_think(spawnpoint, _id_F716273270785091) {
  self endon("death");
  node = spawnpoint;

  if(isDefined(spawnpoint.script_parameters))
    self waittill(spawnpoint.script_parameters);

  _id_ACF81F9900BE7297 = 500;
  dist = 100;

  if(isDefined(level._id_42F0B59A6CEC2E6A))
    _id_ACF81F9900BE7297 = level._id_42F0B59A6CEC2E6A;

  _id_18F689E5445D1645 = dist * dist;

  if(isDefined(_id_F716273270785091) && isstring(_id_F716273270785091))
    self.node_grid = scripts\engine\utility::getStructArray(_id_F716273270785091, "script_noteworthy");
  else
    self.node_grid = scripts\engine\utility::getStructArray("drone_grid", "script_noteworthy");

  end_pos = self.origin;
  _id_88B8D987C09FC6C6 = 0;
  self._id_9307BB132B2C0B9F = "spawn";
  _id_2E13FDA08C2B1AE6 = 500;

  if(isDefined(level._id_B3F7B3933168C3EF))
    _id_2E13FDA08C2B1AE6 = level._id_B3F7B3933168C3EF;

  _id_950028441BA5FACB = _id_2E13FDA08C2B1AE6 * _id_2E13FDA08C2B1AE6;
  thread scripts\engine\utility::play_loop_sound_on_entity("recondrone_eng_high");

  for(;;) {
    enemy_target = _id_CC76A1FBA850F228();

    if(!isDefined(enemy_target)) {
      if(!isDefined(self._id_3AEC9A4EC140655A))
        end_pos = self.origin + (randomintrange(-1000, 1000), randomintrange(-1000, 1000), 0);
      else
        end_pos = self._id_3AEC9A4EC140655A;

      if(self._id_9307BB132B2C0B9F != "no_target") {
        if(getDvar("astar_debug") != "")
          level thread scripts\cp\utility::drawsphere(end_pos, 5, 10, (1, 1, 1));

        _id_D5685B7BAEE6505E = self.origin;
        _id_17947F4A9AA52B15 = self;
        _id_6EE6C2CA7C64E9C9 = spawnStruct();
        _id_6EE6C2CA7C64E9C9.origin = self.origin;
        self.path_data = scripts\cp\astar::astar_get_path(self.node_grid, _id_D5685B7BAEE6505E, end_pos, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_ACF81F9900BE7297);

        if(!isDefined(self.path_data)) {
          wait 0.5;
          continue;
        }

        if(getDvar("astar_debug") != "") {
          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.path_data.path.size; _id_AC0E594AC96AA3A8++) {
            if(isDefined(self.path_data.path[_id_AC0E594AC96AA3A8]) && isDefined(self.path_data.path[_id_AC0E594AC96AA3A8 + 1])) {}
          }
        }

        _id_88B8D987C09FC6C6 = 0;
        next_node = self.path_data.start_node;
        self._id_9307BB132B2C0B9F = "no_target";
      }
    } else if(!istrue(self._id_47C08DE6597328AA) && distancesquared(self.origin, enemy_target.origin) < _id_950028441BA5FACB) {
      _id_A32C066ABF8931AD = _id_EAC4117ECB82B75E();
      _id_A32C066ABF8931AD = sortbydistancecullbyradius(_id_A32C066ABF8931AD, enemy_target.origin, 200);
      attack_sequence(enemy_target, _id_A32C066ABF8931AD);
      self notify("stop_beep");
      self._id_47C08DE6597328AA = 1;
    } else if(istrue(self._id_47C08DE6597328AA)) {
      node_grid = self.node_grid;
      self._id_47C08DE6597328AA = undefined;

      foreach(drone in level.drone_turrets) {
        if(drone == self) {
          continue;
        }
        if(isDefined(drone.current_node))
          node_grid = scripts\engine\utility::array_remove(node_grid, drone.current_node);

        if(isDefined(drone.next_node))
          node_grid = scripts\engine\utility::array_remove(node_grid, drone.next_node);
      }

      _id_D5685B7BAEE6505E = self.origin;
      end_pos = enemy_target.origin;
      _id_E14AC44F6F147496 = enemy_target.origin;
      _id_FFB54732E70D0F73 = sortbydistancecullbyradius(node_grid, end_pos, 800);

      if(_id_FFB54732E70D0F73.size > 0) {
        _id_E8E4ED22F3D730B4 = [];

        foreach(node in _id_FFB54732E70D0F73) {
          if(node drone_turret_canseetarget(enemy_target, (0, 0, 0)))
            _id_E8E4ED22F3D730B4[_id_E8E4ED22F3D730B4.size] = node;
        }

        if(_id_E8E4ED22F3D730B4.size > 0) {
          _id_E14AC44F6F147496 = _id_E8E4ED22F3D730B4[randomintrange(0, int(min(3, _id_E8E4ED22F3D730B4.size)))];
          _id_E14AC44F6F147496 = _id_E14AC44F6F147496.origin;
        }
      }

      _id_17947F4A9AA52B15 = self;
      _id_6EE6C2CA7C64E9C9 = spawnStruct();
      _id_6EE6C2CA7C64E9C9.origin = self.origin;
      self.path_data = scripts\cp\astar::astar_get_path(node_grid, _id_D5685B7BAEE6505E, _id_E14AC44F6F147496, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_ACF81F9900BE7297);

      if(!isDefined(self.path_data)) {
        wait 0.5;
        continue;
      }

      if(getDvar("astar_debug") != "") {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.path_data.path.size; _id_AC0E594AC96AA3A8++) {
          if(isDefined(self.path_data.path[_id_AC0E594AC96AA3A8]) && isDefined(self.path_data.path[_id_AC0E594AC96AA3A8 + 1])) {}
        }
      }

      next_node = self.path_data.start_node;

      if(self._id_9307BB132B2C0B9F != "re_path") {
        _id_88B8D987C09FC6C6 = 0;
        self._id_9307BB132B2C0B9F = "re_path";
      }
    } else if(distancesquared(enemy_target.origin, end_pos) > _id_18F689E5445D1645) {
      node_grid = self.node_grid;
      _id_D5685B7BAEE6505E = self.origin;
      end_pos = enemy_target.origin;
      _id_E14AC44F6F147496 = enemy_target.origin;
      _id_FFB54732E70D0F73 = sortbydistancecullbyradius(node_grid, end_pos, 800);

      if(_id_FFB54732E70D0F73.size > 0) {
        _id_E8E4ED22F3D730B4 = [];

        foreach(node in _id_FFB54732E70D0F73) {
          if(node drone_turret_canseetarget(enemy_target, (0, 0, 0)))
            _id_E8E4ED22F3D730B4[_id_E8E4ED22F3D730B4.size] = node;
        }

        if(_id_E8E4ED22F3D730B4.size > 0) {
          _id_E14AC44F6F147496 = _id_E8E4ED22F3D730B4[randomintrange(0, int(min(3, _id_E8E4ED22F3D730B4.size)))];
          _id_E14AC44F6F147496 = _id_E14AC44F6F147496.origin;
        }
      }

      _id_17947F4A9AA52B15 = self;
      _id_6EE6C2CA7C64E9C9 = spawnStruct();
      _id_6EE6C2CA7C64E9C9.origin = self.origin;
      self.path_data = scripts\cp\astar::astar_get_path(node_grid, _id_D5685B7BAEE6505E, _id_E14AC44F6F147496, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_ACF81F9900BE7297);

      if(!isDefined(self.path_data)) {
        wait 0.5;
        continue;
      }

      if(getDvar("astar_debug") != "") {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.path_data.path.size; _id_AC0E594AC96AA3A8++) {
          if(isDefined(self.path_data.path[_id_AC0E594AC96AA3A8]) && isDefined(self.path_data.path[_id_AC0E594AC96AA3A8 + 1])) {}
        }
      }

      if(getDvar("astar_debug") != "") {
        _id_A54D8B03B3F42B54 = (0, 1, 1);
        level thread scripts\cp\utility::drawsphere(_id_E14AC44F6F147496, 5, 20, _id_A54D8B03B3F42B54);
      }

      next_node = self.path_data.start_node;

      if(self._id_9307BB132B2C0B9F != "new_target_loc") {
        _id_88B8D987C09FC6C6 = 0;
        self._id_9307BB132B2C0B9F = "new_target_loc";
      }
    } else if(self._id_9307BB132B2C0B9F != "hunt_target")
      self._id_9307BB132B2C0B9F = "hunt_target";

    if(!isDefined(self.path_data)) {
      wait 0.5;
      _id_09D76B32CAC3B3EC();
      continue;
    }

    if(!isDefined(self.path_data.path[_id_88B8D987C09FC6C6])) {
      if(_id_88B8D987C09FC6C6 >= self.path_data.path.size) {
        self._id_9307BB132B2C0B9F = "path_done";
        _id_09D76B32CAC3B3EC();
      }

      wait 0.5;
      continue;
    }

    if(istrue(self._id_47C08DE6597328AA)) {
      wait 0.5;
      continue;
    }

    next_node = self.path_data.path[_id_88B8D987C09FC6C6];
    _id_5A869FB9E51F4894 = 0;

    foreach(drone in level.drone_turrets) {
      if(drone == self) {
        continue;
      }
      if(isDefined(drone.current_node) && next_node == drone.current_node)
        _id_5A869FB9E51F4894 = 1;

      if(isDefined(drone.next_node) && next_node == drone.next_node)
        _id_5A869FB9E51F4894 = 1;
    }

    if(_id_5A869FB9E51F4894) {
      self._id_47C08DE6597328AA = 1;
      wait 0.5;
      continue;
    }

    if(isDefined(enemy_target) && isPlayer(enemy_target) && isalive(enemy_target)) {
      if(soundexists("breach_warning_beep_03"))
        enemy_target playlocalsound("breach_warning_beep_03");
    }

    move_to_new_node(next_node, _id_88B8D987C09FC6C6);
    _id_88B8D987C09FC6C6++;
    wait 0.1;
  }
}

attack_sequence(enemy_target, _id_A32C066ABF8931AD) {
  foreach(guy in _id_A32C066ABF8931AD)
  thread _id_EB8BBC754779B523(guy);

  move_to_new_node(enemy_target, 0, (0, 0, 50), 20, 0.25);
}

_id_EB8BBC754779B523(guy) {
  self endon("death");
  self endon("stop_beep");

  if(soundexists("breach_warning_beep_03"))
    guy playlocalsound("breach_warning_beep_03");

  wait 0.5;

  if(soundexists("breach_warning_beep_04"))
    guy playlocalsound("breach_warning_beep_04");

  wait 0.25;

  if(soundexists("breach_warning_beep_05"))
    guy playlocalsound("breach_warning_beep_05");

  for(;;) {
    wait 0.1;

    if(soundexists("breach_warning_beep_05"))
      guy playlocalsound("breach_warning_beep_05");
  }
}

drone_turret_canseetarget(target, offset) {
  if(!isDefined(offset))
    offset = (0, 0, 0);

  _id_027B697504D9397D = 0;
  contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);
  _id_D895C679F6A927E5 = [target gettagorigin("j_head"), target gettagorigin("j_mainroot"), target gettagorigin("tag_origin")];
  ignore = undefined;

  if(isent(self))
    ignore = self;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin + offset, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], ignore, contents)) {
      continue;
    }
    _id_027B697504D9397D = 1;
    break;
  }

  return _id_027B697504D9397D;
}

_id_337EC551928C6AA1() {
  self endon("death");
  self.mgturret endon("death");

  for(;;) {
    _id_A2999C158533ABF3 = randomintrange(-5, 6);
    self rotateroll(_id_A2999C158533ABF3, 1);
    self waittill("rotatedone");
    wait 0.1;
    self rotateroll(_id_A2999C158533ABF3 * -1, 1);
    self waittill("rotatedone");
  }
}

_id_CC76A1FBA850F228() {
  enemy_target = undefined;

  if(isDefined(self.last_damaged_by)) {
    if(isDefined(self.last_damaged_time)) {
      if(gettime() - self.last_damaged_time < 5000)
        enemy_target = self.last_damaged_by;
    }
  }

  if(isDefined(self.targeted_enemy)) {
    if(isPlayer(self.targeted_enemy))
      enemy_target = self.targeted_enemy;
  }

  if(isDefined(enemy_target)) {
    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset)) {
      self._id_3AEC9A4EC140655A = enemy_target.origin;
      self._id_87BABC8A58BC3639 = gettime();
      return enemy_target;
    }
  }

  if(isDefined(self._id_3AEC9A4EC140655A)) {
    if(self._id_87BABC8A58BC3639 + 5000 < gettime())
      self._id_3AEC9A4EC140655A = undefined;
  }

  _id_5BF33998853D38AE = _id_EAC4117ECB82B75E();

  if(_id_5BF33998853D38AE.size < 1)
    return enemy_target;

  _id_5BF33998853D38AE = sortbydistance(_id_5BF33998853D38AE, self.origin);

  foreach(enemy_target in _id_5BF33998853D38AE) {
    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset)) {
      self._id_3AEC9A4EC140655A = enemy_target.origin;
      self._id_87BABC8A58BC3639 = gettime();
      return enemy_target;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5BF33998853D38AE.size; _id_AC0E594AC96AA3A8++) {
    enemy_target = _id_5BF33998853D38AE[_id_AC0E594AC96AA3A8];

    if(isalive(enemy_target) && !istrue(enemy_target.inlaststand))
      return enemy_target;
  }

  return enemy_target;
}

move_to_new_node(node, _id_CF551458C40AA3F5, offset, speed_override, update_time) {
  self endon("death");

  if(!isDefined(offset))
    offset = (0, 0, 0);

  dist = distance(self.origin, node.origin);

  if(!isDefined(node.angles))
    node.angles = (0, 0, 0);

  if(getDvar("astar_debug") != "") {
    _id_A54D8B03B3F42B54 = (1, 0, 1);

    if(self._id_9307BB132B2C0B9F == "no_target")
      _id_A54D8B03B3F42B54 = (0, 1, 0);
    else if(self._id_9307BB132B2C0B9F == "new_target_loc")
      _id_A54D8B03B3F42B54 = (1, 0, 0);
    else if(self._id_9307BB132B2C0B9F == "re_path")
      _id_A54D8B03B3F42B54 = (0, 0, 1);

    level thread scripts\cp\utility::drawsphere(node.origin, 5, 10, _id_A54D8B03B3F42B54);
  }

  if(dist > 1) {
    self.next_node = node;
    speed = 10;

    if(isDefined(speed_override))
      speed = speed_override;

    if(_id_CF551458C40AA3F5 + 1 >= self.path_data.path.size)
      speed = 5;

    self.move_speed = speed;
    self vehicle_setspeed(speed, 10, 10);
    thread _id_D677741135245C73(node, offset, update_time);
    scripts\engine\utility::waittill_any_timeout_3(15, "goal", "goal_reached", "near_goal");
    self notify("stop_tracking");
    self.next_node = undefined;
    self.current_node = node;
    self.move_speed = 0;
  } else
    wait 0.1;
}

_id_D677741135245C73(node, offset, update_time) {
  self endon("death");
  self endon("stop_tracking");
  self setvehgoalpos(node.origin + offset, 0);

  if(istrue(update_time)) {
    thread _id_A953E534FF89430A(3);

    for(;;) {
      wait(update_time);
      self setvehgoalpos(node.origin + offset, 0);
    }
  }
}

_id_A953E534FF89430A(timer) {
  self endon("death");
  self endon("stop_tracking");
  wait(timer);
  self notify("stop_tracking");
}

_id_09D76B32CAC3B3EC() {
  self.move_speed = 0;
  self vehicle_setspeed(0, 12, 12);
}

_id_5E52AE7FC7833E15() {
  self endon("death");

  for(;;) {
    self waittill("pause_move");
    self vehicle_setspeedimmediate(0, 15, 15);
    wait 0.5;
    self vehicle_setspeed(self.move_speed, 12, 12);
  }
}

enemy_sentry_debug() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  org = self.origin;
  interval = 0.05;
  _id_1AAD8F38CB38F703 = int(interval * 20);

  for(;;)
    wait(interval);
}

damage_feedback_watch() {
  self endon("death");
  level endon("game_ended");
  self setCanDamage(1);
  self.health = 100000;
  self.fake_health = 40;
  _id_7DB16320F78CAD3F = self.team == "axis";

  if(!_id_7DB16320F78CAD3F)
    self.fake_health = 200;

  for(;;) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, _id_9E834FE6754A9C98, _id_1D3F20A69CED2DD5, _id_920FF4456CE9A2FC, idflags, objweapon, origin, angles, normal, einflictor, eventid);

    if(!isDefined(eattacker) || _id_7DB16320F78CAD3F && !isPlayer(eattacker) && (!isDefined(eattacker.owner) || !isPlayer(eattacker.owner))) {
      continue;
    }
    if(isDefined(self.mgturret))
      self notify("pause_move");
    else if(isDefined(self._id_13388E6E14BBFB33))
      self._id_13388E6E14BBFB33 notify("pause_move");

    if(isDefined(objweapon.basename)) {
      if(issubstr(objweapon.basename, "emp_drone")) {}
    }

    thread _id_25586D738B30AF98(eattacker);

    if(_id_6F1E07CE9FF97D5F::should_get_currency_from_kill(einflictor, eattacker, objweapon)) {
      if(idamage < self.fake_health)
        eattacker _id_3BCAA2CBAF54ABDD::give_player_currency(10, "large");
      else
        eattacker _id_3BCAA2CBAF54ABDD::give_player_currency(100, "large");
    }

    self.fake_health = self.fake_health - idamage;
    self.health = 100000;
    _id_354C862768CFE202::process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, vdir, _id_920FF4456CE9A2FC, undefined, self);
  }
}

_id_25586D738B30AF98(eattacker) {
  self notify("new_damage");
  self endon("new_damage");
  self.last_damaged_by = eattacker;
  self.last_damaged_time = gettime();
  wait 5;
  self.last_damaged_by = undefined;
  self.last_damaged_time = undefined;
}

watch_for_death() {
  self endon("death");

  for(;;) {
    if(self.fake_health <= 0)
      thread _id_120810605DF9FC38();

    wait 0.1;
  }
}

_id_94D8111112FFC480() {
  self endon("death");
  dist = 100;
  _id_ABD9EE4725B96FC2 = dist * dist;

  for(;;) {
    enemy_list = _id_EAC4117ECB82B75E();

    foreach(guy in enemy_list) {
      if(distancesquared(guy.origin, self.origin) < _id_ABD9EE4725B96FC2)
        thread _id_270B6F63D186FB2B();
    }

    wait 0.1;
  }
}

_id_270B6F63D186FB2B() {
  self setscriptablepartstate("explode", "on", 0);
  range = 200;
  _id_846AEEDA37B2D312 = 10000;
  _id_329B0CB4924A42F0 = 10000;
  weapon_name = "assault_drone_mp";
  thread _id_5EAFE20E3889D3A9();

  if(isDefined(self.owner))
    self radiusdamage(self.origin, range, _id_846AEEDA37B2D312, _id_329B0CB4924A42F0, self.owner, "MOD_EXPLOSIVE", weapon_name);
  else
    self radiusdamage(self.origin, range, _id_846AEEDA37B2D312, _id_329B0CB4924A42F0, undefined, "MOD_EXPLOSIVE", weapon_name);

  thread _id_120810605DF9FC38();
}

_id_5EAFE20E3889D3A9() {
  c4 = spawn("script_model", self.origin);
  c4 setModel("offhand_wm_c4_bomb");
  c4 setscriptablepartstate("effects", "explodeAir");
  wait 1;
  c4 delete();
}

_id_120810605DF9FC38() {
  explode_fx();
  level.drone_turrets = scripts\engine\utility::array_remove(level.drone_turrets, self);
  level.vehicle_ai_script_models = scripts\engine\utility::array_remove(level.vehicle_ai_script_models, self);
  waitframe();
  self notify("death");

  if(isDefined(self))
    self delete();
}

explode_fx() {
  playFX(scripts\engine\utility::getfx("drone_turret_explode"), self.origin);
  self playSound("cp_bomb_drone_death");
}

_id_EAC4117ECB82B75E() {
  _id_2A29B237DCC66FE5 = scripts\cp\utility::get_array_of_valid_players();

  if(self.team == "allies")
    _id_2A29B237DCC66FE5 = getaiarray("axis");

  return _id_2A29B237DCC66FE5;
}