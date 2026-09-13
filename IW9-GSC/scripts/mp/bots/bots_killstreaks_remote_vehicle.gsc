/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_killstreaks_remote_vehicle.gsc
***************************************************************/

remote_vehicle_setup() {
  while(!isDefined(level.bot_variables_initialized))
    wait 0.05;

  if(isDefined(level.bot_initialized_remote_vehicles)) {
    return;
  }
  level.bot_ks_heli_offset["heli_pilot"] = (0, 0, 350);
  level.bot_ks_heli_offset["heli_sniper"] = (0, 0, 228);
  level.bot_ks_funcs["isUsing"]["odin_assault"] = scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["isUsing"]["odin_support"] = scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["isUsing"]["heli_pilot"] = scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["isUsing"]["switchblade_cluster"] = scripts\mp\utility\player::isusingremote;
  level.bot_ks_funcs["isUsing"]["vanguard"] = ::isusingvanguard;
  level.bot_ks_funcs["waittill_initial_goal"]["heli_pilot"] = ::heli_pilot_waittill_initial_goal;
  level.bot_ks_funcs["waittill_initial_goal"]["heli_sniper"] = ::heli_sniper_waittill_initial_goal;
  level.bot_ks_funcs["control_aiming"]["heli_pilot"] = ::heli_pilot_control_heli_aiming;
  level.bot_ks_funcs["control_aiming"]["heli_sniper"] = scripts\engine\utility::empty_init_func;
  level.bot_ks_funcs["control_aiming"]["vanguard"] = ::vanguard_control_aiming;
  level.bot_ks_funcs["control_other"]["heli_pilot"] = ::heli_pilot_monitor_flares;
  level.bot_ks_funcs["heli_pick_node"]["heli_pilot"] = ::heli_pilot_pick_node;
  level.bot_ks_funcs["heli_pick_node"]["heli_sniper"] = ::heli_sniper_pick_node;
  level.bot_ks_funcs["heli_pick_node"]["vanguard"] = ::vanguard_pick_node;
  level.bot_ks_funcs["heli_node_get_origin"]["heli_pilot"] = ::heli_get_node_origin;
  level.bot_ks_funcs["heli_node_get_origin"]["heli_sniper"] = ::heli_get_node_origin;
  level.bot_ks_funcs["heli_node_get_origin"]["vanguard"] = ::vanguard_get_node_origin;
  level.bot_ks_funcs["odin_perform_action"]["odin_assault"] = ::odin_assault_perform_action;
  level.bot_ks_funcs["odin_perform_action"]["odin_support"] = ::odin_support_perform_action;
  level.bot_ks_funcs["odin_get_target"]["odin_assault"] = ::odin_assault_get_target;
  level.bot_ks_funcs["odin_get_target"]["odin_support"] = ::odin_support_get_target;
  _id_8F50E25425117EBB = scripts\engine\utility::getStructArray("so_chopper_boss_path_struct", "script_noteworthy");
  level.bot_heli_nodes = [];

  foreach(_id_BA2239045A8D1BE6 in _id_8F50E25425117EBB) {
    if(isDefined(_id_BA2239045A8D1BE6.script_linkname))
      level.bot_heli_nodes = scripts\engine\utility::array_add(level.bot_heli_nodes, _id_BA2239045A8D1BE6);
  }

  level.bot_heli_pilot_traceoffset = scripts\mp\utility\killstreak::gethelipilottraceoffset();

  foreach(node in level.bot_heli_nodes) {
    node.vanguard_origin = node.origin;
    _id_F3E0744E19E8DE34 = node.origin + (0, 0, 50);
    node.valid_for_vanguard = 1;

    if(_id_F3E0744E19E8DE34[2] <= node.origin[2] - 1000)
      node.valid_for_vanguard = 0;

    _id_F3E0744E19E8DE34 = _id_F3E0744E19E8DE34 - (0, 0, 50);
    node.vanguard_origin = _id_F3E0744E19E8DE34;
  }

  _id_2C5952770E2C04C7 = -99999999;

  foreach(node in level.bot_heli_nodes)
  _id_2C5952770E2C04C7 = max(_id_2C5952770E2C04C7, node.origin[2]);

  level.bot_vanguard_height_trace_size = _id_2C5952770E2C04C7 - level.bot_map_min_z + 100;
  level.heli_pilot_missile_radius = getdvarfloat("bg_bulletexplradius");

  while(!isDefined(level.odin_marking_flash_radius_max) || !isDefined(level.odin_marking_flash_radius_min))
    wait 0.05;

  level.odin_flash_radius = (level.odin_marking_flash_radius_max + level.odin_marking_flash_radius_min) / 2;
  level.outside_zones = [];

  if(isDefined(level.teleportgetactivepathnodezonesfunc))
    _id_E510A3F92F966E4C = [[level.teleportgetactivepathnodezonesfunc]]();
  else {
    _id_E510A3F92F966E4C = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.zonecount; _id_AC0E594AC96AA3A8++)
      _id_E510A3F92F966E4C[_id_E510A3F92F966E4C.size] = _id_AC0E594AC96AA3A8;
  }

  foreach(z in _id_E510A3F92F966E4C) {
    if(botzonegetindoorpercent(z) < 0.25)
      level.outside_zones = scripts\engine\utility::array_add(level.outside_zones, z);
  }

  level.bot_odin_time_to_move["recruit"] = 1.0;
  level.bot_odin_time_to_move["regular"] = 0.7;
  level.bot_odin_time_to_move["hardened"] = 0.4;
  level.bot_odin_time_to_move["veteran"] = 0.05;
  level.bot_initialized_remote_vehicles = 1;
}

bot_killstreak_remote_control(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_A0D7F97F8BD0E3EC, _id_B66780CCC01EFB67) {
  if(!isDefined(_id_A0D7F97F8BD0E3EC))
    return 0;

  _id_DBB558D52B4C440A = 1;
  _id_7CEA91CE15F22CFB = 1;
  _id_03F7CCA53974B771 = undefined;

  if(isDefined(self.node_ambushing_from)) {
    script_goal_radius = self botgetscriptgoalRadius();
    _id_FB39425801B89150 = distancesquared(self.origin, self.node_ambushing_from.origin);

    if(_id_FB39425801B89150 < squared(script_goal_radius)) {
      _id_DBB558D52B4C440A = 0;
      _id_7CEA91CE15F22CFB = 0;
    } else if(_id_FB39425801B89150 < squared(200))
      _id_DBB558D52B4C440A = 0;
  }

  _id_C5D3A24C7D4A692A = killstreak_info.streakname == "vanguard" && is_indoor_map();

  if(_id_C5D3A24C7D4A692A || _id_DBB558D52B4C440A) {
    _id_C49A42FA6B3F0E0D = getnodesinradius(self.origin, 500, 0, 512);

    if(isDefined(_id_C49A42FA6B3F0E0D) && _id_C49A42FA6B3F0E0D.size > 0) {
      if(isDefined(_id_B66780CCC01EFB67) && _id_B66780CCC01EFB67) {
        _id_01E5601905A854CE = _id_C49A42FA6B3F0E0D;
        _id_C49A42FA6B3F0E0D = [];

        foreach(node in _id_01E5601905A854CE) {
          if(nodeexposedtosky(node)) {
            _id_789069F44709F226 = getlinkednodes(node);
            _id_39A704609DA1C730 = 0;

            foreach(_id_F80A362E5BFA1B31 in _id_789069F44709F226) {
              if(nodeexposedtosky(_id_F80A362E5BFA1B31))
                _id_39A704609DA1C730++;
            }

            if(_id_39A704609DA1C730 / _id_789069F44709F226.size > 0.5)
              _id_C49A42FA6B3F0E0D = scripts\engine\utility::array_add(_id_C49A42FA6B3F0E0D, node);
          }
        }
      }

      if(_id_C5D3A24C7D4A692A) {
        nodes = self botnodescoremultiple(_id_C49A42FA6B3F0E0D, "node_exposed");

        foreach(node in nodes) {
          if(scripts\engine\trace::_bullet_trace_passed(node.origin + (0, 0, 30), node.origin + (0, 0, 400), 0, self)) {
            _id_03F7CCA53974B771 = node;
            break;
          }

          wait 0.05;
        }
      } else if(_id_C49A42FA6B3F0E0D.size > 0)
        _id_03F7CCA53974B771 = self botnodepick(_id_C49A42FA6B3F0E0D, min(3, _id_C49A42FA6B3F0E0D.size), "node_hide");

      if(!isDefined(_id_03F7CCA53974B771))
        return 0;

      self botsetscriptgoalnode(_id_03F7CCA53974B771, "tactical");
    }
  }

  if(_id_7CEA91CE15F22CFB) {
    result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

    if(result != "goal") {
      try_clear_hide_goal(_id_03F7CCA53974B771);
      return 1;
    }
  }

  if(isDefined(_id_86AF96FE008C96EE) && !self[[_id_86AF96FE008C96EE]]()) {
    try_clear_hide_goal(_id_03F7CCA53974B771);
    return 0;
  }

  if(!scripts\mp\bots\bots_util::bot_allowed_to_use_killstreaks()) {
    try_clear_hide_goal(_id_03F7CCA53974B771);
    return 1;
  }

  if(!isDefined(_id_03F7CCA53974B771)) {
    if(self getstance() == "prone")
      self botsetstance("prone");
    else if(self getstance() == "crouch")
      self botsetstance("crouch");
  } else if(self botgetdifficultysetting("strategyLevel") > 0) {
    if(randomint(100) > 50)
      self botsetstance("prone");
    else
      self botsetstance("crouch");
  }

  scripts\mp\bots\bots_killstreaks::bot_switch_to_killstreak_weapon(killstreak_info, killstreaks_array, killstreak_info.weapon);
  self.vehicle_controlling = undefined;
  self thread[[_id_A0D7F97F8BD0E3EC]]();
  thread bot_end_control_on_respawn();
  thread bot_end_control_watcher(_id_03F7CCA53974B771);
  self waittill("control_func_done");
  return 1;
}

bot_end_control_on_respawn() {
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  self waittill("spawned_player");
  self notify("control_func_done");
}

bot_end_control_watcher(_id_03F7CCA53974B771) {
  self endon("disconnect");
  self waittill("control_func_done");
  try_clear_hide_goal(_id_03F7CCA53974B771);
  self botsetstance("none");
  self botsetscriptmove(0, 0);
  self botsetflag("disable_movement", 0);
  self botsetflag("disable_rotation", 0);
  self.vehicle_controlling = undefined;
}

try_clear_hide_goal(_id_03F7CCA53974B771) {
  if(isDefined(_id_03F7CCA53974B771) && self bothasscriptgoal() && isDefined(self botgetscriptgoalnode()) && self botgetscriptgoalnode() == _id_03F7CCA53974B771)
    self botclearscriptgoal();
}

bot_end_control_on_vehicle_death(vehicle) {
  vehicle waittill("death");
  self notify("control_func_done");
}

bot_waittill_using_vehicle(type) {
  _id_F139A82799F5B68E = gettime();

  while(!self[[level.bot_ks_funcs["isUsing"][type]]]()) {
    wait 0.05;

    if(gettime() - _id_F139A82799F5B68E > 5000)
      return 0;
  }

  return 1;
}

bot_control_switchblade_cluster() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  childthread handle_disable_rotation();
  result = bot_waittill_using_vehicle("switchblade_cluster");

  if(!result)
    self notify("control_func_done");

  thread switchblade_handle_awareness();
  _id_AF0EB8C617C1166B = find_cluster_rocket_for_bot(self);
  wait 0.1;
  self.oldmaxsightdistsqrd = self.maxsightdistsqrd;
  self.maxsightdistsqrd = 256000000;
  thread watch_end_switchblade();
  _id_E90AFAB3A285B685 = undefined;
  _id_794601EE02DB5F4E = 0;
  _id_170B960D75247AA1 = 0;
  _id_A881D8167C35CF9A = [];
  _id_2412210E2E3096BF = undefined;
  _id_0D40411D2C496352 = 0;
  _id_08791A8AF9C5E338 = 0;
  _id_F3FF73980FAE5DB1 = undefined;
  locked_target = undefined;
  _id_AED9DFEFE5515810 = 0;
  _id_09473DCB5D22DC5B = is_indoor_map();

  while(self[[level.bot_ks_funcs["isUsing"]["switchblade_cluster"]]]() && isDefined(_id_AF0EB8C617C1166B)) {
    foreach(rocket in level.rockets) {
      if(isDefined(rocket) && rocket.owner == self && rocket.weapon_name == "switch_blade_child_mp") {
        _id_10E401A6F6D6CB7E = 1;

        foreach(_id_7AD213BDDC47D529 in _id_A881D8167C35CF9A) {
          if(_id_7AD213BDDC47D529.rocket == rocket)
            _id_10E401A6F6D6CB7E = 0;
        }

        if(_id_10E401A6F6D6CB7E) {
          _id_4043B25178528DC6 = spawnStruct();
          _id_4043B25178528DC6.rocket = rocket;
          _id_4043B25178528DC6.target = _id_2412210E2E3096BF;
          _id_2412210E2E3096BF = undefined;
          _id_A881D8167C35CF9A = scripts\engine\utility::array_add(_id_A881D8167C35CF9A, _id_4043B25178528DC6);
        }
      }
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A881D8167C35CF9A.size; _id_AC0E594AC96AA3A8++) {
      _id_7AD213BDDC47D529 = _id_A881D8167C35CF9A[_id_AC0E594AC96AA3A8];

      if(isDefined(_id_7AD213BDDC47D529) && isDefined(_id_7AD213BDDC47D529.rocket) && !scripts\engine\utility::array_contains(level.rockets, _id_7AD213BDDC47D529.rocket)) {
        _id_A881D8167C35CF9A[_id_AC0E594AC96AA3A8] = _id_A881D8167C35CF9A[_id_A881D8167C35CF9A.size - 1];
        _id_A881D8167C35CF9A[_id_A881D8167C35CF9A.size - 1] = undefined;
        _id_AC0E594AC96AA3A8--;
      }
    }

    if(_id_AED9DFEFE5515810) {
      wait 0.05;
      continue;
    }

    best_target = undefined;

    if(isDefined(locked_target)) {
      best_target = locked_target;

      if(!isalive(locked_target) || !self botcanseeentity(best_target)) {
        if(!isalive(locked_target))
          _id_AED9DFEFE5515810 = 1;

        wait 0.05;
        continue;
      }
    }

    _id_6EBB00162CF7C9EA = [];

    if(!isDefined(best_target)) {
      enemies = bot_killstreak_get_all_outside_enemies(0);
      _id_D7A0A05144CEB764 = [];

      foreach(_id_7AD213BDDC47D529 in _id_A881D8167C35CF9A) {
        if(isDefined(_id_7AD213BDDC47D529.target))
          _id_D7A0A05144CEB764 = scripts\engine\utility::array_add(_id_D7A0A05144CEB764, _id_7AD213BDDC47D529.target);
      }

      enemies = scripts\engine\utility::array_remove_array(enemies, _id_D7A0A05144CEB764);

      foreach(enemy in enemies) {
        if(enemy scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
          continue;
        }
        if(self botcanseeentity(enemy) || _id_09473DCB5D22DC5B && scripts\engine\utility::within_fov(self getEye(), _id_AF0EB8C617C1166B.angles, enemy.origin, self botgetfovdot())) {
          if(!bot_body_is_dead() && distancesquared(enemy.origin, self.origin) < 40000) {
            continue;
          }
          _id_6EBB00162CF7C9EA = scripts\engine\utility::array_add(_id_6EBB00162CF7C9EA, enemy);

          if(!isDefined(best_target)) {
            best_target = enemy;
            continue;
          }

          _id_BC34C62BEE0E91FE = vectorNormalize(best_target.origin - _id_AF0EB8C617C1166B.origin);
          _id_C16733D994283F04 = vectorNormalize(enemy.origin - _id_AF0EB8C617C1166B.origin);
          _id_DEF105AA8D67BE94 = anglesToForward(_id_AF0EB8C617C1166B.angles);
          _id_24B6E3EA8F396BA1 = vectordot(_id_BC34C62BEE0E91FE, _id_DEF105AA8D67BE94);
          _id_DF6E6D84FB19825B = vectordot(_id_C16733D994283F04, _id_DEF105AA8D67BE94);

          if(_id_DF6E6D84FB19825B > _id_24B6E3EA8F396BA1)
            best_target = enemy;
        }
      }
    }

    if(isDefined(best_target)) {
      _id_E90AFAB3A285B685 = undefined;
      _id_798C31D3A6FE9E79 = _id_AF0EB8C617C1166B.origin[2] - best_target.origin[2];
      _id_501F7F9E330F28B6 = self botgetdifficulty();

      if(_id_501F7F9E330F28B6 == "recruit")
        _id_F3FF73980FAE5DB1 = best_target.origin;
      else if(_id_798C31D3A6FE9E79 < 5000)
        _id_F3FF73980FAE5DB1 = best_target.origin;
      else if(length(best_target getentityvelocity()) < 25)
        _id_F3FF73980FAE5DB1 = best_target.origin;
      else if(gettime() - _id_08791A8AF9C5E338 > 500) {
        _id_08791A8AF9C5E338 = gettime();
        _id_E7D4A44EB0A17FA4 = 3.0;

        if(_id_501F7F9E330F28B6 == "regular")
          _id_E7D4A44EB0A17FA4 = 1.0;

        _id_F3FF73980FAE5DB1 = getpredictedentityposition(best_target, _id_E7D4A44EB0A17FA4);
      }

      _id_07770FF3A205C2B6 = missile_get_desired_angles_to_target(_id_AF0EB8C617C1166B, _id_F3FF73980FAE5DB1);
      _id_F7FAC0901F2D27D8 = missile_get_distance_to_target(_id_AF0EB8C617C1166B, _id_F3FF73980FAE5DB1);

      if(_id_F7FAC0901F2D27D8 < 30)
        speed = 0.0;
      else if(_id_F7FAC0901F2D27D8 < 100)
        speed = 0.15;
      else if(_id_F7FAC0901F2D27D8 < 200)
        speed = 0.3;
      else if(_id_F7FAC0901F2D27D8 < 400)
        speed = 0.6;
      else
        speed = 1.0;

      if(_id_0D40411D2C496352)
        speed = min(speed * 3, 1.0);

      if(speed > 0)
        self botsetscriptmove(_id_07770FF3A205C2B6[1], 0.05, speed, 1, 1);
      else if(gettime() > _id_170B960D75247AA1) {
        if(_id_794601EE02DB5F4E < 2) {
          self botpressbutton("attack");
          _id_794601EE02DB5F4E++;
          _id_170B960D75247AA1 = gettime() + 200;

          if(_id_501F7F9E330F28B6 == "regular" && _id_794601EE02DB5F4E == 2 || _id_501F7F9E330F28B6 == "hardened" || _id_501F7F9E330F28B6 == "veteran") {
            _id_DCAC7CD909BF4F2A = _id_794601EE02DB5F4E == 1 && _id_6EBB00162CF7C9EA.size == 1;

            if(!_id_DCAC7CD909BF4F2A) {
              _id_2412210E2E3096BF = best_target;
              _id_170B960D75247AA1 = _id_170B960D75247AA1 + 800;
            }
          }
        } else if(!_id_0D40411D2C496352 && (_id_798C31D3A6FE9E79 < 5000 || _id_501F7F9E330F28B6 == "recruit")) {
          _id_0D40411D2C496352 = 1;
          self botpressbutton("attack");

          if(_id_501F7F9E330F28B6 == "recruit")
            locked_target = best_target;
        }
      }
    } else {
      if(!isDefined(_id_E90AFAB3A285B685))
        _id_E90AFAB3A285B685 = scripts\engine\utility::random(level.outside_zones);

      _id_331313721EE341F6 = getzonenodeforindex(_id_E90AFAB3A285B685).origin;

      if(missile_get_distance_to_target(_id_AF0EB8C617C1166B, _id_331313721EE341F6) < 200) {
        _id_E90AFAB3A285B685 = scripts\engine\utility::random(level.outside_zones);
        _id_331313721EE341F6 = getzonenodeforindex(_id_E90AFAB3A285B685).origin;
      }

      _id_07770FF3A205C2B6 = missile_get_desired_angles_to_target(_id_AF0EB8C617C1166B, _id_331313721EE341F6);
      self botsetscriptmove(_id_07770FF3A205C2B6[1], 0.05, 0.75, 1, 1);
    }

    wait 0.05;
  }

  self notify("control_func_done");
}

missile_get_desired_angles_to_target(missile, _id_4351410D12107DF3) {
  current_target = missile_find_ground_target(missile, _id_4351410D12107DF3[2]);
  _id_322ABD791D0AD262 = vectorNormalize(_id_4351410D12107DF3 - current_target);
  return vectortoangles(_id_322ABD791D0AD262);
}

missile_get_distance_to_target(missile, _id_4351410D12107DF3) {
  current_target = missile_find_ground_target(missile, _id_4351410D12107DF3[2]);
  return distance(current_target, _id_4351410D12107DF3);
}

handle_disable_rotation() {
  self botsetflag("disable_rotation", 1);
  self botsetflag("disable_movement", 1);
  find_cluster_rocket_for_bot(self);
  self botsetflag("disable_rotation", 0);
  self botsetflag("disable_movement", 0);
}

switchblade_handle_awareness() {
  self endon("disconnect");
  self botsetawareness(2.5);
  self waittill("control_func_done");
  self botsetawareness(1.0);
}

missile_find_ground_target(missile, _id_8099CDF91FA07077) {
  _id_B08E2CFDCFFF25C7 = anglesToForward(missile.angles);
  _id_AB276AABF08E332D = (_id_8099CDF91FA07077 - missile.origin[2]) / _id_B08E2CFDCFFF25C7[2];
  _id_6D4EAA166902B863 = missile.origin + _id_B08E2CFDCFFF25C7 * _id_AB276AABF08E332D;
  return _id_6D4EAA166902B863;
}

watch_end_switchblade() {
  self endon("disconnect");
  self waittill("control_func_done");
  self.maxsightdistsqrd = self.oldmaxsightdistsqrd;
}

find_cluster_rocket_for_bot(bot) {
  for(;;) {
    foreach(rocket in level.rockets) {
      if(isDefined(rocket) && rocket.owner == bot)
        return rocket;
    }

    wait 0.05;
  }
}

vanguard_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed())
    return 0;

  return 1;
}

bot_killstreak_vanguard_start(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_A0D7F97F8BD0E3EC) {
  bot_killstreak_remote_control(killstreak_info, killstreaks_array, _id_86AF96FE008C96EE, _id_A0D7F97F8BD0E3EC, 1);
}

isusingvanguard() {
  return scripts\mp\utility\player::isusingremote() && self.usingremote == "vanguard" && isDefined(self.remoteuav);
}

bot_control_vanguard() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  result = bot_waittill_using_vehicle("vanguard");

  if(!result)
    self notify("control_func_done");

  self.vehicle_controlling = self.remoteuav;
  childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);
  self.vehicle_controlling endon("death");
  wait 0.5;
  _id_EEB18C09526831F4 = 0;
  _id_0E41C6322CB5A215 = !self.vehicle_controlling vanguard_is_outside();
  _id_0609A4A78FFFE040 = undefined;
  _id_44EE720D1B6F774F = 0;
  _id_09473DCB5D22DC5B = is_indoor_map();

  while(_id_0E41C6322CB5A215 && !_id_09473DCB5D22DC5B) {
    nodes = getnodesinradiussorted(self.vehicle_controlling.origin, 1024, 64, 512, "path");

    if(isDefined(_id_0609A4A78FFFE040))
      nodes = scripts\engine\utility::array_remove(nodes, _id_0609A4A78FFFE040);

    foreach(_id_14173607261225D3 in nodes) {
      if(node_is_valid_outside_for_vanguard(_id_14173607261225D3)) {
        _id_0609A4A78FFFE040 = _id_14173607261225D3;
        break;
      }

      wait 0.05;
      _id_EEB18C09526831F4 = _id_EEB18C09526831F4 + 0.05;
    }

    if(_id_EEB18C09526831F4 < 1.0)
      wait(1.0 - _id_EEB18C09526831F4);

    if(!isDefined(_id_0609A4A78FFFE040)) {
      self botpressbutton("use", 4.0);
      wait 4.0;
    }

    path = scripts\mp\bots\bots_util::bot_queued_process("GetNodesOnPathVanguard", scripts\mp\bots\bots_util::func_get_nodes_on_path, self.vehicle_controlling.origin, _id_0609A4A78FFFE040.origin);

    if(!isDefined(path)) {
      if(_id_44EE720D1B6F774F == 0) {
        _id_44EE720D1B6F774F++;
        wait 0.05;
        continue;
      } else {
        self botpressbutton("use", 4.0);
        wait 4.0;
      }
    }

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < path.size; _id_AC0E594AC96AA3A8++) {
      next_node = path[_id_AC0E594AC96AA3A8];

      if(_id_AC0E594AC96AA3A8 == 0 && distancesquared(self.origin, next_node.origin) < 1600) {
        continue;
      }
      _id_4A38AB365344A40D = 32;

      if(_id_AC0E594AC96AA3A8 == path.size - 1)
        _id_4A38AB365344A40D = 16;

      last_pos = self.vehicle_controlling.origin;
      _id_94699E558D940F9C = gettime() + 2500;

      while(distance2dsquared(next_node.origin, self.vehicle_controlling.origin) > _id_4A38AB365344A40D * _id_4A38AB365344A40D) {
        if(self.vehicle_controlling vanguard_is_outside()) {
          _id_AC0E594AC96AA3A8 = path.size;
          break;
        }

        if(gettime() > _id_94699E558D940F9C) {
          _id_94699E558D940F9C = gettime() + 2500;
          _id_3C36FA26DCA3C9D5 = distancesquared(self.vehicle_controlling.origin, last_pos);

          if(_id_3C36FA26DCA3C9D5 < 1.0) {
            _id_AC0E594AC96AA3A8++;
            break;
          }

          last_pos = self.vehicle_controlling.origin;
        }

        _id_91D0AC94FF8EBC89 = vectorNormalize(next_node.origin - self.vehicle_controlling.origin);
        self botsetscriptmove(vectortoangles(_id_91D0AC94FF8EBC89)[1], 0.2);
        self botlookatpoint(next_node.origin, 0.2, "script_forced");
        _id_5A85896C5C7944C1 = next_node.origin[2] + 64;
        _id_A36A7535DA401884 = _id_5A85896C5C7944C1 - self.vehicle_controlling.origin[2];

        if(_id_A36A7535DA401884 > 10)
          self botpressbutton("lethal");
        else if(_id_A36A7535DA401884 < -10)
          self botpressbutton("tactical");

        wait 0.05;
      }
    }

    _id_0E41C6322CB5A215 = 0;

    if(!self.vehicle_controlling vanguard_is_outside())
      _id_0E41C6322CB5A215 = 1;
  }

  self botsetscriptmove(0, 0);
  self botlookatpoint(undefined);
  self childthread[[level.bot_ks_funcs["control_aiming"]["vanguard"]]]();
  _id_1450C458C74941E5 = self.vehicle_controlling.origin[2];
  _id_BF6D8F35CB3B4B6A = undefined;
  _id_6BA1A69E97D56E55 = gettime() + 2000;
  _id_6558E6F3F0D145AD = [];
  _id_6558E6F3F0D145AD[0] = (1, 0, 0);
  _id_6558E6F3F0D145AD[1] = (-1, 0, 0);
  _id_6558E6F3F0D145AD[2] = (0, 1, 0);
  _id_6558E6F3F0D145AD[3] = (0, -1, 0);
  _id_6558E6F3F0D145AD[4] = (1, 1, 0);
  _id_6558E6F3F0D145AD[5] = (1, -1, 0);
  _id_6558E6F3F0D145AD[6] = (-1, 1, 0);
  _id_6558E6F3F0D145AD[7] = (-1, -1, 0);
  _id_71F05487C401C762 = find_closest_heli_node_2d(self.vehicle_controlling.origin, "vanguard");

  while(_id_71F05487C401C762.vanguard_origin[2] - self.vehicle_controlling.origin[2] > 20) {
    if(gettime() > _id_6BA1A69E97D56E55) {
      _id_6BA1A69E97D56E55 = gettime() + 2000;

      if(isDefined(_id_BF6D8F35CB3B4B6A))
        _id_BF6D8F35CB3B4B6A = undefined;
      else {
        _id_A36A7535DA401884 = self.vehicle_controlling.origin[2] - _id_1450C458C74941E5;

        if(_id_A36A7535DA401884 < 20 && !_id_09473DCB5D22DC5B) {
          _id_8E4D6CA7020FE22F = scripts\engine\utility::array_randomize(_id_6558E6F3F0D145AD);

          foreach(direction in _id_8E4D6CA7020FE22F) {
            if(pos_passes_sky_trace(self.vehicle_controlling.origin + direction * 64)) {
              if(!scripts\engine\trace::_bullet_trace_passed(self.vehicle_controlling.origin, self.vehicle_controlling.origin + direction * 64, 0, self.vehicle_controlling)) {
                wait 0.05;
                continue;
              }

              _id_BF6D8F35CB3B4B6A = direction;
              break;
            }

            wait 0.05;
          }
        }
      }

      _id_1450C458C74941E5 = self.vehicle_controlling.origin[2];
    }

    if(isDefined(_id_BF6D8F35CB3B4B6A)) {
      self botsetscriptmove(vectortoangles(_id_BF6D8F35CB3B4B6A)[1], 0.05);

      if(scripts\engine\utility::cointoss())
        self botpressbutton("tactical");
    } else
      self botpressbutton("lethal");

    wait 0.05;
  }

  wait 1.0;
  wait 1.0;
  self botsetflag("disable_movement", 0);
  bot_control_heli_main_move_loop("vanguard", 0);
  self notify("control_func_done");
}

pos_is_valid_outside_for_vanguard(pos) {
  nearest_node = getclosestnodeinsight(pos);

  if(isDefined(nearest_node))
    return node_is_valid_outside_for_vanguard(nearest_node);

  return 0;
}

node_is_valid_outside_for_vanguard(node) {
  if(nodeexposedtosky(node))
    return pos_passes_sky_trace(node.origin);

  return 0;
}

pos_passes_sky_trace(pos) {
  start = pos;
  end = pos + (0, 0, level.bot_vanguard_height_trace_size);

  if(end[2] <= start[2])
    return 0;

  result = scripts\engine\trace::_bullet_trace_passed(start, end, 0, undefined);
  return result;
}

vanguard_is_outside() {
  nearest_node = getclosestnodeinsight(self.origin);

  if(isDefined(nearest_node) && !nodeexposedtosky(nearest_node))
    return 0;

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (18, 0, 25)))
    return 0;

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (-18, 0, 25)))
    return 0;

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (0, 18, 25)))
    return 0;

  wait 0.05;

  if(!pos_passes_sky_trace(self.origin + (0, -18, 25)))
    return 0;

  return 1;
}

vanguard_control_aiming() {
  self notify("vanguard_control_aiming");
  self endon("vanguard_control_aiming");
  _id_F3FF73980FAE5DB1 = undefined;
  _id_BEFBF47BFF2227BD = 0;
  _id_D9084B43307ECDA8 = gettime();
  _id_08791A8AF9C5E338 = 0;
  _id_5ECF1D67365182C1 = undefined;
  _id_46219A6A94DC3F7E = 0;

  while(self[[level.bot_ks_funcs["isUsing"]["vanguard"]]]()) {
    _id_47ECA5045634214A = undefined;
    _id_BE7B9C056623FA13 = self getEye();
    _id_C127D102DD2295C3 = self getplayerangles();
    _id_9230F5246D95A3D6 = self botgetfovdot();

    if(isalive(self.enemy) && self botcanseeentity(self.enemy)) {
      _id_776BA3F458AA7EE9 = 1;
      _id_47ECA5045634214A = self.enemy;
      _id_46219A6A94DC3F7E = 0;
    } else if(_id_46219A6A94DC3F7E < 10.0) {
      foreach(_id_7DC3241E7F3C6B24 in level.characters) {
        if(_id_7DC3241E7F3C6B24 == self || !isalive(_id_7DC3241E7F3C6B24)) {
          continue;
        }
        if(_id_7DC3241E7F3C6B24 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
          continue;
        }
        if(!isDefined(_id_7DC3241E7F3C6B24.team)) {
          continue;
        }
        if(!level.teambased || self.team != _id_7DC3241E7F3C6B24.team) {
          if(scripts\engine\utility::within_fov(_id_BE7B9C056623FA13, _id_C127D102DD2295C3, _id_7DC3241E7F3C6B24.origin, _id_9230F5246D95A3D6)) {
            _id_46219A6A94DC3F7E = _id_46219A6A94DC3F7E + 0.05;

            if(isDefined(_id_47ECA5045634214A)) {
              _id_95290E32A23B47F3 = distancesquared(self.vehicle_controlling.origin, _id_47ECA5045634214A.origin);
              _id_1B19C0B9CE3C8AED = distancesquared(self.vehicle_controlling.origin, _id_7DC3241E7F3C6B24.origin);

              if(_id_1B19C0B9CE3C8AED < _id_95290E32A23B47F3)
                _id_47ECA5045634214A = _id_7DC3241E7F3C6B24;

              continue;
            }

            _id_47ECA5045634214A = _id_7DC3241E7F3C6B24;
          }
        }
      }
    }

    if(isDefined(_id_47ECA5045634214A)) {
      if((isai(_id_47ECA5045634214A) || isPlayer(_id_47ECA5045634214A)) && length(_id_47ECA5045634214A getentityvelocity()) < 25)
        _id_F3FF73980FAE5DB1 = _id_47ECA5045634214A.origin;
      else if(gettime() - _id_08791A8AF9C5E338 < 500) {
        if(_id_5ECF1D67365182C1 != _id_47ECA5045634214A)
          _id_F3FF73980FAE5DB1 = _id_47ECA5045634214A.origin;
      } else if(gettime() - _id_08791A8AF9C5E338 > 500) {
        _id_08791A8AF9C5E338 = gettime();
        _id_F3FF73980FAE5DB1 = getpredictedentityposition(_id_47ECA5045634214A, 3.0);
        _id_5ECF1D67365182C1 = _id_47ECA5045634214A;
      }

      _id_91D341C821BD4D3F = 165;

      if(gettime() - _id_D9084B43307ECDA8 > 10000)
        _id_91D341C821BD4D3F = 200;

      if(distancesquared(self.vehicle_controlling.attackarrow.origin, _id_F3FF73980FAE5DB1) < level.vanguard_missile_radius * level.vanguard_missile_radius) {
        if(bot_body_is_dead() || distancesquared(self.vehicle_controlling.attackarrow.origin, self.origin) > level.vanguard_missile_radius * level.vanguard_missile_radius) {
          _id_D9084B43307ECDA8 = gettime();
          self botpressbutton("attack");
        }
      }
    } else if(gettime() > _id_BEFBF47BFF2227BD) {
      _id_BEFBF47BFF2227BD = gettime() + randomintrange(1000, 2000);
      _id_F3FF73980FAE5DB1 = get_random_outside_target();
      self.next_goal_time = gettime();
    }

    if(length(_id_F3FF73980FAE5DB1) == 0)
      _id_F3FF73980FAE5DB1 = (0, 0, 10);

    self botlookatpoint(_id_F3FF73980FAE5DB1, 0.2, "script_forced");
    wait 0.05;
  }
}

vanguard_pick_node(current_node) {
  current_node.bot_visited_times[self.entity_number]++;
  _id_FCEC43EE4C57AB6E = [[level.bot_ks_funcs["heli_node_get_origin"]["vanguard"]]](current_node);
  _id_0F3DB337E7391129 = bot_vanguard_find_unvisited_nodes(current_node);
  _id_B09396F0B1B602BF = _id_0F3DB337E7391129;
  _id_0F3DB337E7391129 = [];

  foreach(node in _id_B09396F0B1B602BF) {
    if(node.valid_for_vanguard) {
      if(current_node.origin[2] != current_node.vanguard_origin[2] || node.origin[2] != node.vanguard_origin[2]) {
        _id_CA5534A90F13A4D4 = [[level.bot_ks_funcs["heli_node_get_origin"]["vanguard"]]](node);
        _id_2E3BC21C15E7AB6C = playerphysicstrace(_id_FCEC43EE4C57AB6E, _id_CA5534A90F13A4D4);

        if(distancesquared(_id_2E3BC21C15E7AB6C, _id_CA5534A90F13A4D4) < 1)
          _id_0F3DB337E7391129 = scripts\engine\utility::array_add(_id_0F3DB337E7391129, node);

        wait 0.05;
        continue;
      }

      _id_0F3DB337E7391129 = scripts\engine\utility::array_add(_id_0F3DB337E7391129, node);
    }
  }

  if(_id_0F3DB337E7391129.size == 0 && _id_B09396F0B1B602BF.size > 0) {
    foreach(node in _id_B09396F0B1B602BF)
    node.bot_visited_times[self.entity_number]++;
  }

  return heli_pick_node_furthest_from_center(_id_0F3DB337E7391129, "vanguard");
}

bot_vanguard_find_unvisited_nodes(current_node) {
  _id_DFB97CDFD9440698 = 99;
  _id_0F3DB337E7391129 = [];

  foreach(node in current_node.neighbors) {
    if(isDefined(node.script_linkname) && node.valid_for_vanguard) {
      _id_58C720AC2B13BFA6 = node.bot_visited_times[self.entity_number];

      if(_id_58C720AC2B13BFA6 < _id_DFB97CDFD9440698) {
        _id_0F3DB337E7391129 = [];
        _id_0F3DB337E7391129[0] = node;
        _id_DFB97CDFD9440698 = _id_58C720AC2B13BFA6;
      } else if(_id_58C720AC2B13BFA6 == _id_DFB97CDFD9440698)
        _id_0F3DB337E7391129[_id_0F3DB337E7391129.size] = node;
    }
  }

  return _id_0F3DB337E7391129;
}

vanguard_get_node_origin(node) {
  return node.vanguard_origin;
}

origin_is_valid_for_vanguard(origin) {
  result = 1;
  _id_350C03E8095BB7A4 = scripts\engine\utility::spawn_tag_origin();
  _id_350C03E8095BB7A4.origin = origin;
  _id_350C03E8095BB7A4 delete();
  return result;
}

heli_sniper_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed())
    return 0;

  return 1;
}

heli_sniper_waittill_initial_goal() {
  self.vehicle_controlling waittill("near_goal");
}

bot_control_heli_sniper() {
  thread heli_sniper_clear_script_goal_on_ride();
  bot_control_heli("heli_sniper");
}

heli_sniper_clear_script_goal_on_ride() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  self botclearscriptgoal();
}

heli_sniper_pick_node(current_node) {
  current_node.bot_visited_times[self.entity_number]++;
  _id_0F3DB337E7391129 = bot_heli_find_unvisited_nodes(current_node);
  return heli_pick_node_furthest_from_center(_id_0F3DB337E7391129, "heli_sniper");
}

heli_pilot_allowed() {
  if(!scripts\mp\bots\bots_killstreaks::aerial_vehicle_allowed())
    return 0;

  if(scripts\mp\killstreaks\helicopter_pilot::exceededmaxhelipilots(self.team))
    return 0;

  return 1;
}

heli_pilot_waittill_initial_goal() {
  self.vehicle_controlling waittill("goal_reached");
}

bot_control_heli_pilot() {
  bot_control_heli("heli_pilot");
}

heli_pilot_pick_node(current_node) {
  current_node.bot_visited_times[self.entity_number]++;
  _id_0F3DB337E7391129 = bot_heli_find_unvisited_nodes(current_node);
  _id_953F471CA637DD82 = scripts\engine\utility::random(_id_0F3DB337E7391129);
  return _id_953F471CA637DD82;
}

heli_pilot_monitor_flares() {
  self notify("heli_pilot_monitor_flares");
  self endon("heli_pilot_monitor_flares");
  _id_2365122D9E752752 = [];

  while(self[[level.bot_ks_funcs["isUsing"]["heli_pilot"]]]()) {
    self.vehicle_controlling waittill("targeted_by_incoming_missile", missiles);

    if(!scripts\mp\killstreaks\flares::flares_areavailable(self.vehicle_controlling)) {
      break;
    }

    _id_CF626EF12D877F28 = 1;

    foreach(missile in missiles) {
      if(isDefined(missile) && !scripts\engine\utility::array_contains(_id_2365122D9E752752, missile))
        _id_CF626EF12D877F28 = 0;
    }

    if(!_id_CF626EF12D877F28) {
      _id_8B686F26E9129E3C = clamp(0.34 * self botgetdifficultysetting("strategyLevel"), 0.0, 1.0);

      if(randomfloat(1.0) < _id_8B686F26E9129E3C)
        self notify("manual_flare_popped");

      _id_2365122D9E752752 = scripts\engine\utility::array_combine(_id_2365122D9E752752, missiles);
      _id_2365122D9E752752 = scripts\engine\utility::array_removeundefined(_id_2365122D9E752752);
      wait 3.0;
    }
  }
}

heli_pilot_control_heli_aiming() {
  self notify("heli_pilot_control_heli_aiming");
  self endon("heli_pilot_control_heli_aiming");
  _id_4AC4B608421ECBBB = undefined;
  _id_4D571DF5F3A8BEFC = undefined;
  _id_F3FF73980FAE5DB1 = undefined;
  _id_BEFBF47BFF2227BD = 0;
  _id_EA189B55DE5C8FA7 = 0;
  _id_AB3E79C5F7D858AF = undefined;
  _id_4174D86981043509 = (self botgetdifficultysetting("minInaccuracy") + self botgetdifficultysetting("maxInaccuracy")) / 2;
  _id_DEF9C228381A493A = 0;

  while(self[[level.bot_ks_funcs["isUsing"]["heli_pilot"]]]()) {
    _id_D430BCDA6275A38B = 0;
    _id_4B05A8497817406A = 0;

    if(isDefined(_id_4D571DF5F3A8BEFC) && _id_4D571DF5F3A8BEFC.health <= 0 && gettime() - _id_4D571DF5F3A8BEFC.deathtime < 2000) {
      _id_D430BCDA6275A38B = 1;
      _id_4B05A8497817406A = 1;
    } else if(isalive(self.enemy) && (self botcanseeentity(self.enemy) || gettime() - self lastknowntime(self.enemy) <= 300)) {
      _id_D430BCDA6275A38B = 1;
      _id_4D571DF5F3A8BEFC = self.enemy;
      _id_4AC4B608421ECBBB = self.enemy.origin;

      if(self botcanseeentity(self.enemy)) {
        _id_DEF9C228381A493A = 0;
        _id_4B05A8497817406A = 1;
        _id_B8CCCB951E8A65C4 = gettime();
      } else {
        _id_DEF9C228381A493A = _id_DEF9C228381A493A + 0.05;

        if(_id_DEF9C228381A493A > 5.0)
          _id_D430BCDA6275A38B = 0;
      }
    }

    if(_id_D430BCDA6275A38B) {
      _id_F3FF73980FAE5DB1 = _id_4AC4B608421ECBBB - (0, 0, 50);

      if(_id_4B05A8497817406A && (bot_body_is_dead() || distancesquared(_id_F3FF73980FAE5DB1, self.origin) > level.heli_pilot_missile_radius * level.heli_pilot_missile_radius))
        self botpressbutton("attack");

      if(gettime() > _id_EA189B55DE5C8FA7 + 500) {
        _id_BCFEC646853A95C1 = randomfloatrange(-1 * _id_4174D86981043509 / 2, _id_4174D86981043509 / 2);
        _id_BCFEC546853A938E = randomfloatrange(-1 * _id_4174D86981043509 / 2, _id_4174D86981043509 / 2);
        _id_BCFEC446853A915B = randomfloatrange(-1 * _id_4174D86981043509 / 2, _id_4174D86981043509 / 2);
        _id_AB3E79C5F7D858AF = (150 * _id_BCFEC646853A95C1, 150 * _id_BCFEC546853A938E, 150 * _id_BCFEC446853A915B);
        _id_EA189B55DE5C8FA7 = gettime();
      }

      _id_F3FF73980FAE5DB1 = _id_F3FF73980FAE5DB1 + _id_AB3E79C5F7D858AF;
      _id_61CE3A6EBF0B28A6 = self.vehicle_controlling gettagorigin("tag_player");
      _id_DF61CD3F6F7E9F85 = vectorNormalize(_id_F3FF73980FAE5DB1 - _id_61CE3A6EBF0B28A6);
      _id_DEE6508B0BA437C5 = anglesToForward(self getplayerangles());
      dot = vectordot(_id_DF61CD3F6F7E9F85, _id_DEE6508B0BA437C5);

      if(dot > 0.5)
        self botpressbutton("ads", 0.1);
    } else if(gettime() > _id_BEFBF47BFF2227BD) {
      _id_BEFBF47BFF2227BD = gettime() + randomintrange(1000, 2000);
      _id_F3FF73980FAE5DB1 = get_random_outside_target();
      self.next_goal_time = gettime();
    }

    _id_A558729C23606F06 = _id_F3FF73980FAE5DB1 - self.vehicle_controlling.origin;
    _id_AAFCE4CBF21021ED = length(_id_A558729C23606F06);
    _id_E2BFEBEA4ACE23DB = vectortoangles(_id_A558729C23606F06);
    _id_C52592149682016A = angleclamp(self.vehicle_controlling.angles[0]);
    _id_F33538ADAAE5E75D = angleclamp(_id_E2BFEBEA4ACE23DB[0]);
    dist = int(_id_C52592149682016A - _id_F33538ADAAE5E75D) % 360;

    if(dist > 180)
      dist = 360 - dist;
    else if(dist < -180)
      dist = -360 + dist;

    if(dist > 15)
      _id_F33538ADAAE5E75D = _id_C52592149682016A - 15;
    else if(dist < -15)
      _id_F33538ADAAE5E75D = _id_C52592149682016A + 15;

    _id_E2BFEBEA4ACE23DB = (_id_F33538ADAAE5E75D, _id_E2BFEBEA4ACE23DB[1], _id_E2BFEBEA4ACE23DB[2]);
    _id_A558729C23606F06 = anglesToForward(_id_E2BFEBEA4ACE23DB);
    _id_F3FF73980FAE5DB1 = self.vehicle_controlling.origin + _id_A558729C23606F06 * _id_AAFCE4CBF21021ED;

    if(length(_id_F3FF73980FAE5DB1) == 0)
      _id_F3FF73980FAE5DB1 = (0, 0, 10);

    self botlookatpoint(_id_F3FF73980FAE5DB1, 0.2, "script_forced");
    wait 0.05;
  }
}

bot_control_odin_assault() {
  bot_control_odin("odin_assault");
}

odin_assault_perform_action() {
  if(bot_odin_try_spawn_juggernaut())
    return 1;

  if(bot_odin_try_rods())
    return 1;

  if(bot_odin_try_airdrop())
    return 1;

  return 0;
}

odin_assault_get_target() {
  return bot_odin_find_target_for_rods();
}

bot_odin_find_target_for_rods() {
  _id_D91860896D0A8573 = undefined;

  if(isDefined(self.last_large_rod_target) && gettime() - self.last_large_rod_time < 5000)
    _id_D91860896D0A8573 = self.last_large_rod_target;

  return bot_odin_get_closest_visible_outside_player("enemy", 1, _id_D91860896D0A8573);
}

bot_odin_try_rods() {
  _id_E74293C1E1D5F3E3 = bot_odin_should_fire_rod_at_marker();

  if(_id_E74293C1E1D5F3E3 == "large") {
    self notify("large_rod_action");
    return 1;
  }

  if(_id_E74293C1E1D5F3E3 == "small") {
    self notify("small_rod_action");
    return 1;
  }

  return 0;
}

bot_odin_should_fire_rod_at_marker() {
  _id_C42A5A5477738232 = gettime() >= self.odin.odin_largerodusetime;
  _id_6757435AD2FCAD1A = gettime() >= self.odin.odin_smallrodusetime;

  if(_id_C42A5A5477738232 || _id_6757435AD2FCAD1A) {
    _id_FD8C40D97F2B5BE3 = bot_odin_get_visible_outside_players("enemy", 0);
    _id_124D8FF097468AD2 = [];
    _id_3004663D1F820632 = distancesquared(self.origin, self.odin.targeting_marker.origin);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FD8C40D97F2B5BE3.size; _id_AC0E594AC96AA3A8++) {
      _id_E5207EE0FBB4D144 = bot_odin_get_player_target_point(_id_FD8C40D97F2B5BE3[_id_AC0E594AC96AA3A8]);
      _id_124D8FF097468AD2[_id_AC0E594AC96AA3A8] = distancesquared(self.odin.targeting_marker.origin, _id_E5207EE0FBB4D144);
    }

    if(_id_C42A5A5477738232) {
      if(!bot_body_is_dead() && _id_3004663D1F820632 < level.odin_large_rod_radius * level.odin_large_rod_radius)
        return "none";

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FD8C40D97F2B5BE3.size; _id_AC0E594AC96AA3A8++) {
        if(_id_124D8FF097468AD2[_id_AC0E594AC96AA3A8] < squared(level.odin_large_rod_radius)) {
          self.last_large_rod_target = _id_FD8C40D97F2B5BE3[_id_AC0E594AC96AA3A8];
          self.last_large_rod_time = gettime();
          return "large";
        }
      }
    }

    if(_id_6757435AD2FCAD1A) {
      if(!bot_body_is_dead() && _id_3004663D1F820632 < level.odin_small_rod_radius * level.odin_small_rod_radius)
        return "none";

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FD8C40D97F2B5BE3.size; _id_AC0E594AC96AA3A8++) {
        if(_id_124D8FF097468AD2[_id_AC0E594AC96AA3A8] < squared(level.odin_small_rod_radius)) {
          if(isDefined(self.last_large_rod_target) && self.last_large_rod_target == _id_FD8C40D97F2B5BE3[_id_AC0E594AC96AA3A8] && gettime() - self.last_large_rod_time < 5000) {
            continue;
          }
          return "small";
        }
      }
    }
  }

  return "none";
}

bot_control_odin_support() {
  bot_control_odin("odin_support");
}

odin_support_perform_action() {
  if(bot_odin_try_spawn_juggernaut())
    return 1;

  if(bot_odin_try_airdrop())
    return 1;

  if(bot_odin_try_smoke())
    return 1;

  if(bot_odin_try_flash())
    return 1;

  return 0;
}

bot_odin_try_flash() {
  if(bot_odin_should_fire_flash_at_marker()) {
    self notify("marking_action");
    return 1;
  }

  return 0;
}

bot_odin_should_fire_flash_at_marker() {
  if(gettime() < self.odin.odin_markingusetime)
    return 0;

  _id_FD8C40D97F2B5BE3 = bot_odin_get_visible_outside_players("enemy", 0);
  _id_124D8FF097468AD2 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FD8C40D97F2B5BE3.size; _id_AC0E594AC96AA3A8++) {
    _id_E5207EE0FBB4D144 = bot_odin_get_player_target_point(_id_FD8C40D97F2B5BE3[_id_AC0E594AC96AA3A8]);
    _id_124D8FF097468AD2[_id_AC0E594AC96AA3A8] = distancesquared(self.odin.targeting_marker.origin, _id_E5207EE0FBB4D144);

    if(_id_124D8FF097468AD2[_id_AC0E594AC96AA3A8] < squared(level.odin_flash_radius / 2))
      return 1;
  }

  return 0;
}

bot_odin_try_smoke() {
  if(bot_odin_should_drop_smoke_at_marker()) {
    self notify("smoke_action");
    return 1;
  }

  return 0;
}

bot_odin_should_drop_smoke_at_marker() {
  if(gettime() < self.odin.odin_smokeusetime)
    return 0;

  _id_C8C8FF4B4D6F5A35 = bot_odin_get_high_priority_smoke_locations();

  foreach(location in _id_C8C8FF4B4D6F5A35) {
    if(distancesquared(location, self.odin.targeting_marker.origin) < 2500)
      return 1;
  }

  _id_F8898B9246323DA2 = undefined;

  if(isDefined(self.odin.targeting_marker.nearest_node))
    _id_F8898B9246323DA2 = getnodezone(self.odin.targeting_marker.nearest_node);

  if(!isDefined(_id_F8898B9246323DA2))
    return 0;

  _id_496B706855B1DDF4 = bot_killstreak_get_zone_enemies_outside(1);
  _id_E2D98FC247820509 = _id_496B706855B1DDF4[_id_F8898B9246323DA2].size;

  if(_id_E2D98FC247820509 >= 2)
    return 1;

  return 0;
}

bot_odin_get_high_priority_smoke_locations() {
  _id_07CAC1009C20BF46 = [];

  if(gettime() < self.odin.odin_smokeusetime)
    return _id_07CAC1009C20BF46;

  foreach(_id_782866E364DCD2EF in level.carepackages) {
    if(scripts\mp\bots\bots::crate_landed_and_on_path_grid(_id_782866E364DCD2EF)) {
      _id_6342A5CD84590602[0] = self;
      _id_91F8F74167179907 = scripts\engine\utility::get_array_of_closest(_id_782866E364DCD2EF.origin, level.players, _id_6342A5CD84590602);

      if(_id_91F8F74167179907.size > 0 && _id_91F8F74167179907[0].team == self.team)
        _id_07CAC1009C20BF46 = scripts\engine\utility::array_add(_id_07CAC1009C20BF46, _id_782866E364DCD2EF.origin);
    }
  }

  _id_E63DCB8377800007 = bot_odin_get_visible_outside_players("ally", 0);

  foreach(ally in _id_E63DCB8377800007) {
    if(isai(ally) && ally scripts\mp\bots\bots_util::bot_is_capturing())
      _id_07CAC1009C20BF46 = scripts\engine\utility::array_add(_id_07CAC1009C20BF46, ally.origin);
  }

  return _id_07CAC1009C20BF46;
}

odin_support_get_target() {
  _id_7F1AC86A3F1BBEF6 = bot_odin_get_high_priority_smoke_locations();

  if(_id_7F1AC86A3F1BBEF6.size > 0)
    return _id_7F1AC86A3F1BBEF6[0];

  return bot_odin_get_closest_visible_outside_player("enemy", 1);
}

monitor_odin_marker() {
  for(;;) {
    self.odin.targeting_marker.nearest_node = getclosestnodeinsight(self.odin.targeting_marker.origin);

    if(scripts\mp\bots\bots_util::bot_point_is_on_pathgrid(self.odin.targeting_marker.origin, 200))
      self.odin.targeting_marker.nearest_point_on_pathgrid = self.odin.targeting_marker.origin;
    else
      self.odin.targeting_marker.nearest_point_on_pathgrid = undefined;

    wait 0.25;
  }
}

bot_control_odin(type) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  result = bot_waittill_using_vehicle(type);

  if(!result)
    self notify("control_func_done");

  self.vehicle_controlling = self.odin;
  childthread bot_end_control_on_vehicle_death(self.odin);
  self.odin endon("death");
  wait 1.4;
  self botsetawareness(0.7);
  thread bot_end_odin_watcher();
  self.odin_predicted_loc_for_player = [];
  self.odin_predicted_loc_time_for_player = [];
  self.odin_last_predict_position_time = 0;
  _id_E90AFAB3A285B685 = undefined;
  _id_1497A47034E387C4 = 0;
  _id_973F93820C8C0465 = undefined;
  childthread monitor_odin_marker();
  _id_EF47868CA10DCC01 = self.odin.targeting_marker.origin;
  _id_FD9C9BCD1E914113 = gettime();

  while(self[[level.bot_ks_funcs["isUsing"][type]]]()) {
    _id_85EEFBE482EAEE42 = self[[level.bot_ks_funcs["odin_perform_action"][type]]]();

    if(gettime() > _id_FD9C9BCD1E914113 + 2000) {
      _id_FD9C9BCD1E914113 = gettime();
      _id_170E45043275D92F = distance(_id_EF47868CA10DCC01, self.odin.targeting_marker.origin);
      _id_EF47868CA10DCC01 = self.odin.targeting_marker.origin;

      if(_id_170E45043275D92F < 100) {
        _id_973F93820C8C0465 = undefined;
        _id_E90AFAB3A285B685 = undefined;
      }
    }

    if(gettime() > _id_1497A47034E387C4 || !isDefined(_id_973F93820C8C0465)) {
      _id_793236BF24161670 = level.bot_odin_time_to_move[self botgetdifficulty()];
      _id_1497A47034E387C4 = gettime() + _id_793236BF24161670 * 1000;
      _id_2E7BB50120A1A873 = self[[level.bot_ks_funcs["odin_get_target"][type]]]();

      if(isDefined(_id_2E7BB50120A1A873)) {
        _id_E90AFAB3A285B685 = undefined;

        if(isPlayer(_id_2E7BB50120A1A873))
          _id_973F93820C8C0465 = bot_odin_get_player_target_point(_id_2E7BB50120A1A873);
        else
          _id_973F93820C8C0465 = _id_2E7BB50120A1A873;
      } else {
        if(!isDefined(_id_E90AFAB3A285B685))
          _id_E90AFAB3A285B685 = scripts\engine\utility::random(level.outside_zones);

        _id_331313721EE341F6 = getzonenodeforindex(_id_E90AFAB3A285B685).origin;

        if(distance2dsquared(self.odin.targeting_marker.origin, _id_331313721EE341F6) < 10000) {
          _id_E90AFAB3A285B685 = scripts\engine\utility::random(level.outside_zones);
          _id_331313721EE341F6 = getzonenodeforindex(_id_E90AFAB3A285B685).origin;
          _id_FD9C9BCD1E914113 = gettime();
        }

        _id_973F93820C8C0465 = _id_331313721EE341F6;
      }
    }

    _id_437878FC8700D152 = _id_973F93820C8C0465 - self.odin.targeting_marker.origin;

    if(lengthsquared(_id_437878FC8700D152) > 100) {
      _id_1B8E1FAD87BE8F97 = vectortoangles(_id_437878FC8700D152);
      self botsetscriptmove(_id_1B8E1FAD87BE8F97[1], 0.05);
      self botlookatpoint(_id_973F93820C8C0465, 0.1, "script_forced");
    } else
      _id_FD9C9BCD1E914113 = gettime();

    wait 0.05;
  }

  self notify("control_func_done");
}

bot_end_odin_watcher(_id_03F7CCA53974B771) {
  self endon("disconnect");
  self waittill("control_func_done");
  self.odin_predicted_loc_for_player = undefined;
  self.odin_predicted_loc_time_for_player = undefined;
  self.odin_last_predict_position_time = undefined;
  self botsetawareness(1.0);
}

bot_odin_get_player_target_point(player) {
  if(level.teambased && self.team == player.team)
    return player.origin;
  else {
    if(length(player getentityvelocity()) < 25)
      return player.origin;

    _id_E6BE2F834CE26751 = player getentitynumber();

    if(!isDefined(self.odin_predicted_loc_time_for_player[_id_E6BE2F834CE26751]))
      self.odin_predicted_loc_time_for_player[_id_E6BE2F834CE26751] = 0;

    _id_4FB72B720667636B = gettime();
    _id_A7711337581DB22E = _id_4FB72B720667636B - self.odin_predicted_loc_time_for_player[_id_E6BE2F834CE26751];

    if(_id_A7711337581DB22E <= 400) {
      _id_87E06701670C4F0E = vectorNormalize(player getentityvelocity());
      _id_8BC6CF48C44D94CA = vectorNormalize(self.odin_predicted_loc_for_player[_id_E6BE2F834CE26751] - player.origin);

      if(vectordot(_id_87E06701670C4F0E, _id_8BC6CF48C44D94CA) < -0.5)
        return player.origin;
    }

    if(_id_A7711337581DB22E > 400) {
      if(_id_4FB72B720667636B == self.odin_last_predict_position_time) {
        if(_id_A7711337581DB22E > 1000)
          return player.origin;
      } else {
        self.odin_predicted_loc_for_player[_id_E6BE2F834CE26751] = getpredictedentityposition(player, 1.5);
        self.odin_predicted_loc_time_for_player[_id_E6BE2F834CE26751] = _id_4FB72B720667636B;
        self.odin_last_predict_position_time = _id_4FB72B720667636B;
      }
    }

    return self.odin_predicted_loc_for_player[_id_E6BE2F834CE26751];
  }
}

bot_odin_get_closest_visible_outside_player(type, _id_3A3CB035FB18EC46, _id_D91860896D0A8573) {
  _id_EE756551B58215D4 = bot_odin_get_visible_outside_players(type, _id_3A3CB035FB18EC46);

  if(isDefined(_id_D91860896D0A8573))
    _id_EE756551B58215D4 = scripts\engine\utility::array_remove(_id_EE756551B58215D4, _id_D91860896D0A8573);

  if(_id_EE756551B58215D4.size > 0) {
    _id_A7D47AC97D19D2E4 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, _id_EE756551B58215D4);
    return _id_A7D47AC97D19D2E4[0];
  }

  return undefined;
}

bot_odin_try_spawn_juggernaut() {
  if(gettime() >= self.odin.odin_juggernautusetime) {
    if(!isDefined(self.odin.targeting_marker.nearest_node))
      return 0;
  }

  return 0;
}

bot_odin_find_target_for_airdrop() {
  return bot_odin_get_closest_visible_outside_player("ally", 0);
}

bot_odin_try_airdrop() {
  if(bot_odin_should_airdrop_at_marker()) {
    self notify("airdrop_action");
    self notify("juggernaut_action");
    return 1;
  }

  return 0;
}

bot_odin_should_airdrop_at_marker() {
  if(gettime() < self.odin.odin_airdropusetime)
    return 0;

  if(!isDefined(self.odin.targeting_marker.nearest_node))
    return 0;

  if(bot_odin_get_num_valid_care_packages() > 2)
    return 0;

  if(!isDefined(self.odin.targeting_marker.nearest_point_on_pathgrid))
    return 0;

  _id_F8898B9246323DA2 = getnodezone(self.odin.targeting_marker.nearest_node);

  if(!isDefined(_id_F8898B9246323DA2))
    return 0;

  _id_CB35D9461A15429A = bot_killstreak_get_zone_allies_outside(1);
  _id_A891CAA86BC4A7F7 = _id_CB35D9461A15429A[_id_F8898B9246323DA2].size;
  _id_496B706855B1DDF4 = bot_killstreak_get_zone_enemies_outside(1);
  _id_E2D98FC247820509 = _id_496B706855B1DDF4[_id_F8898B9246323DA2].size;

  if(_id_A891CAA86BC4A7F7 == 0)
    return 0;

  if(_id_E2D98FC247820509 == 0) {
    _id_9AC378B966278A36 = 0;
    _id_6EBB00162CF7C9EA = bot_odin_get_visible_outside_players("enemy", 1);

    foreach(enemy in _id_6EBB00162CF7C9EA) {
      if(distancesquared(enemy.origin, self.odin.targeting_marker.origin) < 14400)
        _id_9AC378B966278A36 = 1;
    }

    if(!_id_9AC378B966278A36)
      return 1;
  }

  if(_id_A891CAA86BC4A7F7 - _id_E2D98FC247820509 >= 2) {
    _id_A6571DC2A58C4E51 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, _id_CB35D9461A15429A[_id_F8898B9246323DA2]);
    _id_81D35B9A2EC3AC25 = scripts\engine\utility::get_array_of_closest(self.odin.targeting_marker.origin, _id_496B706855B1DDF4[_id_F8898B9246323DA2]);
    _id_A0CDC235271AE7E0 = distance(self.odin.targeting_marker.origin, _id_A6571DC2A58C4E51[0].origin);
    _id_D512083E84B3CE24 = distance(self.odin.targeting_marker.origin, _id_81D35B9A2EC3AC25[0].origin);

    if(_id_A0CDC235271AE7E0 + 120 < _id_D512083E84B3CE24)
      return 1;
  }

  return 0;
}

bot_odin_get_num_valid_care_packages() {
  count = 0;

  foreach(_id_782866E364DCD2EF in level.carepackages) {
    if(isDefined(_id_782866E364DCD2EF) && scripts\mp\bots\bots::crate_landed_and_on_path_grid(_id_782866E364DCD2EF))
      count++;
  }

  return count;
}

bot_odin_get_visible_outside_players(type, _id_3A3CB035FB18EC46, _id_885E7A840BDD3128) {
  _id_1C664656C4B55731 = bot_killstreak_get_outside_players(self.team, type, _id_3A3CB035FB18EC46);
  _id_3A7E2E5EB062A1D0 = self botgetfovdot();
  _id_C60B7B779E693458 = [];

  foreach(player in _id_1C664656C4B55731) {
    _id_EF1DB9C1F617F745 = 0;
    _id_BC74F8BBDB62ED10 = _id_3A7E2E5EB062A1D0;

    if(type == "enemy")
      _id_BC74F8BBDB62ED10 = _id_BC74F8BBDB62ED10 * 0.9;

    if(scripts\engine\utility::within_fov(self.vehicle_controlling.origin, self getplayerangles(), player.origin, _id_BC74F8BBDB62ED10)) {
      if(!_id_EF1DB9C1F617F745 || self botcanseeentity(player))
        _id_C60B7B779E693458 = scripts\engine\utility::array_add(_id_C60B7B779E693458, player);
    }
  }

  return _id_C60B7B779E693458;
}

is_indoor_map() {
  return level.script == "mp_sovereign";
}

bot_body_is_dead() {
  return isDefined(self.fauxdead) && self.fauxdead;
}

heli_pick_node_furthest_from_center(nodes, type) {
  _id_D89F315DEB0441B3 = undefined;
  _id_8E18414D09AC1595 = 0;

  foreach(node in nodes) {
    _id_4C5056D533E11E6A = distancesquared(level.bot_map_center, [[level.bot_ks_funcs["heli_node_get_origin"][type]]](node));

    if(_id_4C5056D533E11E6A > _id_8E18414D09AC1595) {
      _id_8E18414D09AC1595 = _id_4C5056D533E11E6A;
      _id_D89F315DEB0441B3 = node;
    }
  }

  if(isDefined(_id_D89F315DEB0441B3))
    return _id_D89F315DEB0441B3;
  else
    return scripts\engine\utility::random(nodes);
}

heli_get_node_origin(node) {
  return node.origin;
}

find_closest_heli_node_2d(origin, type) {
  _id_21D0B4A644EFA190 = undefined;
  _id_9106952186A9A611 = 99999999;

  foreach(node in level.bot_heli_nodes) {
    _id_1DCE2D1958040081 = distance2dsquared(origin, [[level.bot_ks_funcs["heli_node_get_origin"][type]]](node));

    if(_id_1DCE2D1958040081 < _id_9106952186A9A611) {
      _id_21D0B4A644EFA190 = node;
      _id_9106952186A9A611 = _id_1DCE2D1958040081;
    }
  }

  return _id_21D0B4A644EFA190;
}

bot_killstreak_get_zone_allies_outside(_id_3A3CB035FB18EC46) {
  _id_E63DCB8377800007 = bot_killstreak_get_all_outside_allies(_id_3A3CB035FB18EC46);
  _id_CB35D9461A15429A = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.zonecount; _id_AC0E594AC96AA3A8++)
    _id_CB35D9461A15429A[_id_AC0E594AC96AA3A8] = [];

  foreach(ally in _id_E63DCB8377800007) {
    nearest_node = ally getnearestnode();
    zone = getnodezone(nearest_node);

    if(isDefined(zone))
      _id_CB35D9461A15429A[zone] = scripts\engine\utility::array_add(_id_CB35D9461A15429A[zone], ally);
  }

  return _id_CB35D9461A15429A;
}

bot_killstreak_get_zone_enemies_outside(_id_3A3CB035FB18EC46) {
  _id_FD8C40D97F2B5BE3 = bot_killstreak_get_all_outside_enemies(_id_3A3CB035FB18EC46);
  _id_496B706855B1DDF4 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.zonecount; _id_AC0E594AC96AA3A8++)
    _id_496B706855B1DDF4[_id_AC0E594AC96AA3A8] = [];

  foreach(enemy in _id_FD8C40D97F2B5BE3) {
    nearest_node = enemy getnearestnode();
    zone = getnodezone(nearest_node);
    _id_496B706855B1DDF4[zone] = scripts\engine\utility::array_add(_id_496B706855B1DDF4[zone], enemy);
  }

  return _id_496B706855B1DDF4;
}

bot_killstreak_get_all_outside_enemies(_id_3A3CB035FB18EC46) {
  return bot_killstreak_get_outside_players(self.team, "enemy", _id_3A3CB035FB18EC46);
}

bot_killstreak_get_all_outside_allies(_id_3A3CB035FB18EC46) {
  return bot_killstreak_get_outside_players(self.team, "ally", _id_3A3CB035FB18EC46);
}

bot_killstreak_get_outside_players(team, type, _id_3A3CB035FB18EC46) {
  _id_1C664656C4B55731 = [];
  _id_45D25409ACB2D4F9 = level.participants;

  if(isDefined(_id_3A3CB035FB18EC46) && _id_3A3CB035FB18EC46)
    _id_45D25409ACB2D4F9 = level.players;

  foreach(player in _id_45D25409ACB2D4F9) {
    if(player == self || !isalive(player)) {
      continue;
    }
    is_valid_player = 0;

    if(type == "ally")
      is_valid_player = level.teambased && team == player.team;
    else if(type == "enemy")
      is_valid_player = !level.teambased || team != player.team;

    if(is_valid_player) {
      _id_CF74BC7C70F92EB6 = player getnearestnode();

      if(isDefined(_id_CF74BC7C70F92EB6) && nodeexposedtosky(_id_CF74BC7C70F92EB6))
        _id_1C664656C4B55731 = scripts\engine\utility::array_add(_id_1C664656C4B55731, player);
    }
  }

  _id_1C664656C4B55731 = scripts\engine\utility::array_remove(_id_1C664656C4B55731, self);
  return _id_1C664656C4B55731;
}

bot_heli_find_unvisited_nodes(current_node) {
  _id_DFB97CDFD9440698 = 99;
  _id_0F3DB337E7391129 = [];

  foreach(node in current_node.neighbors) {
    if(isDefined(node.script_linkname)) {
      _id_58C720AC2B13BFA6 = node.bot_visited_times[self.entity_number];

      if(_id_58C720AC2B13BFA6 < _id_DFB97CDFD9440698) {
        _id_0F3DB337E7391129 = [];
        _id_0F3DB337E7391129[0] = node;
        _id_DFB97CDFD9440698 = _id_58C720AC2B13BFA6;
      } else if(_id_58C720AC2B13BFA6 == _id_DFB97CDFD9440698)
        _id_0F3DB337E7391129[_id_0F3DB337E7391129.size] = node;
    }
  }

  return _id_0F3DB337E7391129;
}

bot_control_heli(type) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  result = bot_waittill_using_vehicle(type);

  if(!result)
    self notify("control_func_done");

  foreach(_id_8D39AE40EC801616 in level.littlebirds) {
    if(_id_8D39AE40EC801616.owner == self)
      self.vehicle_controlling = _id_8D39AE40EC801616;
  }

  childthread bot_end_control_on_vehicle_death(self.vehicle_controlling);
  self.vehicle_controlling endon("death");

  if(isDefined(level.bot_ks_funcs["control_other"][type]))
    self childthread[[level.bot_ks_funcs["control_other"][type]]]();

  self[[level.bot_ks_funcs["waittill_initial_goal"][type]]]();
  self childthread[[level.bot_ks_funcs["control_aiming"][type]]]();
  bot_control_heli_main_move_loop(type, 1);
  self notify("control_func_done");
}

bot_get_heli_goal_dist_sq(_id_C3EDBF19A4808CD4) {
  if(_id_C3EDBF19A4808CD4)
    return squared(100);
  else
    return squared(30);
}

bot_get_heli_slowdown_dist_sq(_id_C3EDBF19A4808CD4) {
  if(_id_C3EDBF19A4808CD4)
    return squared(300);
  else
    return squared(90);
}

bot_control_heli_main_move_loop(type, _id_C3EDBF19A4808CD4) {
  foreach(node in level.bot_heli_nodes)
  node.bot_visited_times[self.entity_number] = 0;

  current_node = find_closest_heli_node_2d(self.vehicle_controlling.origin, type);
  current_target = undefined;
  self.next_goal_time = 0;
  state = "needs_new_goal";
  _id_74207EFE9FFC3778 = undefined;
  _id_CADD32B7C5BF3FA9 = self.vehicle_controlling.origin;
  _id_B7C52A7E2454A386 = 3.0;
  wait_time = 0.05;

  while(self[[level.bot_ks_funcs["isUsing"][type]]]()) {
    if(gettime() > self.next_goal_time && state == "needs_new_goal") {
      prev_node = current_node;
      current_node = [[level.bot_ks_funcs["heli_pick_node"][type]]](current_node);
      current_target = undefined;

      if(isDefined(current_node)) {
        _id_FCEC43EE4C57AB6E = [[level.bot_ks_funcs["heli_node_get_origin"][type]]](current_node);

        if(_id_C3EDBF19A4808CD4) {
          tracestart = current_node.origin + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() + level.bot_heli_pilot_traceoffset);
          _id_8B39E5984DA1FFAF = current_node.origin + (scripts\mp\utility\killstreak::gethelipilotmeshoffset() - level.bot_heli_pilot_traceoffset);
          _id_1F0571D36D0DF95B = scripts\engine\trace::_bullet_trace(tracestart, _id_8B39E5984DA1FFAF, 0, undefined, 0, 0, 1);
          current_target = _id_1F0571D36D0DF95B["position"] - scripts\mp\utility\killstreak::gethelipilotmeshoffset() + level.bot_ks_heli_offset[type];
        } else
          current_target = _id_FCEC43EE4C57AB6E;
      }

      if(isDefined(current_target)) {
        self botsetflag("disable_movement", 0);
        state = "waiting_till_goal";
        _id_B7C52A7E2454A386 = 3.0;
        _id_CADD32B7C5BF3FA9 = self.vehicle_controlling.origin;
      } else {
        current_node = prev_node;
        self.next_goal_time = gettime() + 2000;
      }
    } else if(state == "waiting_till_goal") {
      if(!_id_C3EDBF19A4808CD4) {
        _id_A36A7535DA401884 = current_target[2] - self.vehicle_controlling.origin[2];

        if(_id_A36A7535DA401884 > 10)
          self botpressbutton("lethal");
        else if(_id_A36A7535DA401884 < -10)
          self botpressbutton("tactical");
      }

      _id_4957AC5FEB2A6FCF = current_target - self.vehicle_controlling.origin;

      if(_id_C3EDBF19A4808CD4)
        _id_74207EFE9FFC3778 = length2dsquared(_id_4957AC5FEB2A6FCF);
      else
        _id_74207EFE9FFC3778 = lengthsquared(_id_4957AC5FEB2A6FCF);

      if(_id_74207EFE9FFC3778 < bot_get_heli_goal_dist_sq(_id_C3EDBF19A4808CD4)) {
        self botsetscriptmove(0, 0);
        self botsetflag("disable_movement", 1);

        if(self botgetdifficulty() == "recruit")
          self.next_goal_time = gettime() + randomintrange(5000, 7000);
        else
          self.next_goal_time = gettime() + randomintrange(3000, 5000);

        state = "needs_new_goal";
      } else {
        _id_4957AC5FEB2A6FCF = current_target - self.vehicle_controlling.origin;
        _id_12E3256864EF7F70 = vectortoangles(_id_4957AC5FEB2A6FCF);
        _id_8B71502BBA40864F = scripts\engine\utility::ter_op(_id_74207EFE9FFC3778 < bot_get_heli_slowdown_dist_sq(_id_C3EDBF19A4808CD4), 0.5, 1.0);
        self botsetscriptmove(_id_12E3256864EF7F70[1], wait_time, _id_8B71502BBA40864F);
        _id_B7C52A7E2454A386 = _id_B7C52A7E2454A386 - wait_time;

        if(_id_B7C52A7E2454A386 <= 0.0) {
          if(distancesquared(self.vehicle_controlling.origin, _id_CADD32B7C5BF3FA9) < 225) {
            current_node.bot_visited_times[self.entity_number]++;
            state = "needs_new_goal";
          }

          _id_CADD32B7C5BF3FA9 = self.vehicle_controlling.origin;
          _id_B7C52A7E2454A386 = 3.0;
        }
      }
    }

    wait(wait_time);
  }
}

get_random_outside_target() {
  _id_CEB6CF74CB9D8AEE = [];

  foreach(z in level.outside_zones) {
    _id_58EEA57628B0811E = botzonegetcount(z, self.team, "enemy_predict");

    if(_id_58EEA57628B0811E > 0)
      _id_CEB6CF74CB9D8AEE = scripts\engine\utility::array_add(_id_CEB6CF74CB9D8AEE, z);
  }

  _id_F3FF73980FAE5DB1 = undefined;

  if(_id_CEB6CF74CB9D8AEE.size > 0) {
    _id_3547D8B9F1E19749 = scripts\engine\utility::random(_id_CEB6CF74CB9D8AEE);
    _id_79B2B39EE937D213 = scripts\engine\utility::random(getzonenodes(_id_3547D8B9F1E19749));
    _id_F3FF73980FAE5DB1 = _id_79B2B39EE937D213.origin;
  } else {
    _id_91BF9DCD7B76676C = undefined;
    _id_89DB07CFFE8425D6 = undefined;

    if(isDefined(level.teleportgetactivenodesfunc))
      _id_91BF9DCD7B76676C = [[level.teleportgetactivenodesfunc]]();
    else
      _id_89DB07CFFE8425D6 = getnodecount();

    _id_DF3DF3F76BABD410 = 0;

    while(_id_DF3DF3F76BABD410 < 10) {
      _id_DF3DF3F76BABD410++;
      _id_953F471CA637DD82 = undefined;

      if(isDefined(_id_91BF9DCD7B76676C))
        _id_953F471CA637DD82 = scripts\engine\utility::random(_id_91BF9DCD7B76676C);
      else
        _id_953F471CA637DD82 = getnodebyindex(randomint(_id_89DB07CFFE8425D6));

      if(isDefined(_id_953F471CA637DD82)) {
        _id_F3FF73980FAE5DB1 = _id_953F471CA637DD82.origin;

        if(nodeexposedtosky(_id_953F471CA637DD82) && distance2dsquared(_id_953F471CA637DD82.origin, self.vehicle_controlling.origin) > 62500) {
          break;
        }
      }
    }
  }

  return _id_F3FF73980FAE5DB1;
}