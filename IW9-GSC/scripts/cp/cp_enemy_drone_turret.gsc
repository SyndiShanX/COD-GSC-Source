/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_enemy_drone_turret.gsc
************************************************/

init() {
  level._effect["drone_turret_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_lrg_dest_exp.vfx");
  level._effect["sniper_red_laser_bright"] = loadfx("vfx/iw9/core/lasers/vfx_hipaimlaser_red_bright.vfx");
  level.drone_turrets = [];
}

_id_FF8F52FF7725F4B3(_id_8B461603A1F825D3) {
  self.targetent.origin = level.players[0].origin;
}

spawn_enemy_drone_turret(spawnpoint, _id_AA4C3AF5EE1FB9B9, _id_F716273270785091) {
  _id_68A36835FAE076D0(spawnpoint, "axis", _id_AA4C3AF5EE1FB9B9, _id_F716273270785091);
}

_id_4E59269E04BDEF3E(spawnpoint, _id_AA4C3AF5EE1FB9B9, _id_F716273270785091) {
  _id_68A36835FAE076D0(spawnpoint, "allies", _id_AA4C3AF5EE1FB9B9, _id_F716273270785091);
}

_id_68A36835FAE076D0(spawnpoint, _id_C1E547BABA2E6F87, _id_AA4C3AF5EE1FB9B9, _id_F716273270785091) {
  startpos = spawnpoint.origin;
  startang = spawnpoint.angles;
  vehicleinfo = "veh_radar_drone_recon_mp";
  _id_B923287498A8519A = "veh8_mil_air_tuniform";
  drone = spawnVehicle(_id_B923287498A8519A, "drone_turret", vehicleinfo, startpos, startang);
  drone.team = _id_C1E547BABA2E6F87;
  drone.spawnpoint = spawnpoint;
  drone makeentitysentient(_id_C1E547BABA2E6F87);
  drone attach_turret(spawnpoint);
  drone thread damage_feedback_watch();
  drone thread _id_5E52AE7FC7833E15();
  drone thread patrol_think(spawnpoint, _id_F716273270785091);
  drone thread fire_on_nearby_players(_id_AA4C3AF5EE1FB9B9);
  drone thread watch_for_death();
  drone thread _id_ABCA015D53CBEA13();
  drone setscriptablepartstate("lights", "on", 0);
  drone setscriptablepartstate("glint", "on", 0);
  drone enableaimassist();

  if(!isDefined(level.vehicle_ai_script_models))
    level.vehicle_ai_script_models = [];

  level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = drone;
  level.drone_turrets[level.drone_turrets.size] = drone;
  return drone;
}

_id_D57528AB38C2B356() {
  _id_97CE008C2DFE22F2 = getEntArray("drone_aimassist", "targetname");

  if(isDefined(_id_97CE008C2DFE22F2) && _id_97CE008C2DFE22F2.size > 0) {
    _id_97CE008C2DFE22F2[0].origin = self.origin;
    _id_97CE008C2DFE22F2[0] linkTo(self);
    _id_97CE008C2DFE22F2[0] enableaimassist();
    self._id_129FD360FB266D20 = _id_97CE008C2DFE22F2[0];
    thread _id_32CD9B2C430BDE92();
  }
}

_id_32CD9B2C430BDE92() {
  _id_7A8493E99AC15549 = self._id_129FD360FB266D20;
  self waittill("death");
  _id_7A8493E99AC15549 delete();
}

attach_turret(spawnpoint) {
  if(!isDefined(level.tanksettings))
    level.tanksettings = [];

  if(!isDefined(level.tanksettings["drone_turret"])) {
    level.tanksettings["drone_turret"] = spawnStruct();
    level.tanksettings["drone_turret"].timeout = 60.0;
    level.tanksettings["drone_turret"].maxhealth = 500;
    level.tanksettings["drone_turret"].hitstokill = 5;
    level.tanksettings["drone_turret"].streakname = "pac_sentry";
    level.tanksettings["drone_turret"].modelbase = "veh8_mil_lnd_whotel";
    level.tanksettings["drone_turret"].modeldestroyed = "veh8_mil_lnd_whotel";
    level.tanksettings["drone_turret"].mgturretmodelbase = "veh8_mil_air_tuniform_turret";
    level.tanksettings["drone_turret"].mgturretinfo = "sentry_turret_cp";
    level.tanksettings["drone_turret"].sentrymodeon = "sentry";
    level.tanksettings["drone_turret"].sentrymodeoff = "sentry_offline";
    level.tanksettings["drone_turret"].vehicleinfo = "veh_pac_sentry_mp_cp";
    level.tanksettings["drone_turret"].stringcannotplace = &"KILLSTREAKS_HINT_CANNOT_CALL_IN";
    level.tanksettings["drone_turret"].scorepopup = "destroyed_pac_sentry";
    level.tanksettings["drone_turret"].vodestroyed = "destroyed_pac_sentry";
    level.tanksettings["drone_turret"].destoyedsplash = "callout_destroyed_pac_sentry";
    level.tanksettings["drone_turret"].premoddamagefunc = undefined;
    level.tanksettings["drone_turret"].lifetime = 600;
  }

  config = level.tanksettings["drone_turret"];
  tag = "tag_turret";
  _id_1E2F2224127D2990 = (0, 0, 0);
  anglesoffset = (0, 0, 0);
  turret = spawnturret("misc_turret", spawnpoint.origin, "drone_turret_raid_cp");
  turret.team = self.team;

  if(!isDefined(spawnpoint.angles))
    spawnpoint.angles = (0, 0, 0);

  turret.angles = spawnpoint.angles;
  turret.health = config.maxhealth;
  turret.maxhealth = config.maxhealth;
  turret setModel("veh8_mil_air_tuniform_turret");
  turret setturretteam(self.team);
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret setautorotationdelay(0.2);
  turret maketurretinoperable();
  turret setleftarc(360);
  turret setrightarc(360);
  turret setbottomarc(60);
  turret settoparc(20);
  turret setconvergencetime(0.6, "pitch");
  turret setconvergencetime(0.6, "yaw");
  turret setconvergenceheightpercent(0.65);
  turret setdefaultdroppitch(-89.0);
  turret setturretmodechangewait(1);
  turret solid();
  turret._id_13388E6E14BBFB33 = self;
  self.mgturret = turret;
  self.mgturret linkTo(self, tag, _id_1E2F2224127D2990, anglesoffset);
  self.mgturret setturretteam(self.team);
  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(::sentryturret_empstarted);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(::sentryturret_empcleared);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  _id_E982491C56D263DD = spawn("script_model", turret.origin);
  _id_E982491C56D263DD setModel("weapon_wm_la_juliet");
  _id_E982491C56D263DD.angles = turret gettagangles("tag_flash");
  _id_E982491C56D263DD linkTo(turret, "tag_flash", (-10, 5, -3), (13, 0, 0));
  _id_E982491C56D263DD notsolid();
  self._id_8BA4B53EA3AAF3D4 = _id_E982491C56D263DD;
  wait 1;
  turret setmode("auto_nonai");
  turret scripts\cp_mp\emp_debuff::allow_emp(1);
  turret sentryturret_empupdate();
  turret thread sentry_beepsounds();
  self.health = 1000;
  self setCanDamage(1);
  self setCanRadiusDamage(1);
  turret setCanDamage(1);
  turret setCanRadiusDamage(1);
  turret thread damage_feedback_watch();
  level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = turret;
}

patrol_think(spawnpoint, _id_F716273270785091) {
  self endon("death");
  node = spawnpoint;

  if(isDefined(spawnpoint.script_parameters))
    self waittill(spawnpoint.script_parameters);

  _id_ACF81F9900BE7297 = 500;
  dist = 100;
  _id_18F689E5445D1645 = dist * dist;

  if(isDefined(_id_F716273270785091) && isstring(_id_F716273270785091))
    self.node_grid = scripts\engine\utility::getStructArray(_id_F716273270785091, "script_noteworthy");
  else
    self.node_grid = scripts\engine\utility::getStructArray("drone_grid", "script_noteworthy");

  end_pos = self.origin;
  _id_88B8D987C09FC6C6 = 0;
  self._id_9307BB132B2C0B9F = "spawn";
  thread scripts\engine\utility::play_loop_sound_on_entity("recondrone_eng_high");

  for(;;) {
    _id_1C3A549D5001F50C = 0;

    if(getdvarint("dvar_AF90E849D061B8A2", 0) != 0) {
      _id_1C3A549D5001F50C = 1;
      _id_09D76B32CAC3B3EC();
      wait 0.5;
      continue;
    }

    if(istrue(self._id_6575F6E151B73BD1)) {
      thread _id_3B39D96E8A1F17F5();
      return;
    }

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

    move_to_new_node(next_node, _id_88B8D987C09FC6C6);
    _id_88B8D987C09FC6C6++;
    wait 0.1;
  }
}

_id_3B39D96E8A1F17F5() {
  _id_D5685B7BAEE6505E = self.origin;
  _id_17947F4A9AA52B15 = self;
  _id_6EE6C2CA7C64E9C9 = spawnStruct();
  _id_6EE6C2CA7C64E9C9.origin = self.origin;
  _id_ACF81F9900BE7297 = 500;
  dist = 100;
  _id_18F689E5445D1645 = dist * dist;
  _id_B63C7D24A3300061 = scripts\engine\utility::getStructArray("heli_exit", "targetname");
  _id_C0BD0A03ADDB645D = scripts\engine\utility::getclosest(self.origin, _id_B63C7D24A3300061);
  end_pos = _id_C0BD0A03ADDB645D.origin;
  self.path_data = scripts\cp\astar::astar_get_path(self.node_grid, _id_D5685B7BAEE6505E, end_pos, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_ACF81F9900BE7297);

  if(getDvar("astar_debug") != "") {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.path_data.path.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(self.path_data.path[_id_AC0E594AC96AA3A8]) && isDefined(self.path_data.path[_id_AC0E594AC96AA3A8 + 1])) {}
    }
  }

  self._id_9307BB132B2C0B9F = "exfil";
  speed = 15;
  self.move_speed = speed;
  self vehicle_setspeed(speed, 10, 10);
  self setvehgoalpos(self.origin + (0, 0, 500), 0);
  scripts\engine\utility::waittill_any_timeout_3(15, "goal", "goal_reached", "near_goal");
  self.move_speed = 0;
  self vehicle_setspeed(1, 12, 12);
  wait 0.5;
  speed = 20;
  self.move_speed = speed;
  self vehicle_setspeed(speed, 10, 10);
  self setvehgoalpos(end_pos, 0);
  scripts\engine\utility::waittill_any_timeout_3(15, "goal", "goal_reached", "near_goal");
  wait 0.5;
  self.move_speed = speed;
  self vehicle_setspeed(speed, 10, 10);
  self setvehgoalpos(self.origin - (0, 0, 500), 0);
  scripts\engine\utility::waittill_any_timeout_3(15, "goal", "goal_reached", "near_goal");
  self.fake_health = 0;
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

move_to_new_node(node, _id_CF551458C40AA3F5) {
  self endon("death");
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

    if(_id_CF551458C40AA3F5 + 1 >= self.path_data.path.size)
      speed = 5;

    self.move_speed = speed;
    self vehicle_setspeed(speed, 10, 10);
    self setvehgoalpos(node.origin, 0);
    scripts\engine\utility::waittill_any_timeout_3(15, "goal", "goal_reached", "near_goal");
    self.next_node = undefined;
    self.current_node = node;
    self.move_speed = 0;
    self vehicle_setspeed(1, 12, 12);
  } else
    wait 0.1;
}

_id_09D76B32CAC3B3EC() {
  self.move_speed = 0;
  self vehicle_setspeed(1, 12, 12);
}

_id_5E52AE7FC7833E15() {
  self endon("death");

  for(;;) {
    self waittill("pause_move", _id_06A3A1033FFC2699);
    _id_241B98DC86D614B0 = (0, 0, 10000);
    self applydroneimpulsevelocity(_id_241B98DC86D614B0, 1, 4.0);
  }
}

sentryturret_empstarted(data) {
  sentryturret_empupdate();
}

sentryturret_empcleared(_id_B3990D56E2779F79) {
  if(_id_B3990D56E2779F79) {
    return;
  }
  sentryturret_empupdate();
}

sentryturret_empupdate() {}

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
  self.fake_health = 50;

  if(getdvarint("dvar_A77A771B24850BC3", 0) != 0)
    self.fake_health = getdvarint("dvar_A77A771B24850BC3", 0);

  _id_7DB16320F78CAD3F = self.team == "axis";

  if(!_id_7DB16320F78CAD3F)
    self.fake_health = 1000;

  for(;;) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, _id_9E834FE6754A9C98, _id_1D3F20A69CED2DD5, _id_920FF4456CE9A2FC, idflags, objweapon, origin, angles, normal, einflictor, eventid);

    if(!isDefined(eattacker) || _id_7DB16320F78CAD3F && !isPlayer(eattacker) && (!isDefined(eattacker.owner) || !isPlayer(eattacker.owner))) {
      continue;
    }
    if(isDefined(self.mgturret))
      self notify("pause_move", vdir);
    else if(isDefined(self._id_13388E6E14BBFB33))
      self._id_13388E6E14BBFB33 notify("pause_move", vdir);

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
    if(self.mgturret.fake_health <= 0)
      thread kill_drone_turret();

    if(self.fake_health <= 0)
      thread kill_drone_turret();

    wait 0.1;
  }
}

_id_ABCA015D53CBEA13() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    if(soundexists("breach_warning_beep_02"))
      self playSound("breach_warning_beep_02");

    wait 2;
  }
}

kill_drone_turret() {
  explode_fx();
  level.drone_turrets = scripts\engine\utility::array_remove(level.drone_turrets, self);
  self.mgturret _id_86D00513B000B479();
  level.vehicle_ai_script_models = scripts\engine\utility::array_remove(level.vehicle_ai_script_models, self);
  level.vehicle_ai_script_models = scripts\engine\utility::array_remove(level.vehicle_ai_script_models, self.mgturret);
  self.mgturret notify("death");

  if(isDefined(self.mgturret))
    self.mgturret delete();

  if(isDefined(self._id_8BA4B53EA3AAF3D4))
    self._id_8BA4B53EA3AAF3D4 delete();

  waitframe();
  self notify("death");

  if(isDefined(self))
    self delete();
}

explode_fx() {
  playFX(scripts\engine\utility::getfx("drone_turret_explode"), self.origin);
  self playSound("sentry_explode_smoke");
}

sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
}

sentry_beepsounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3.0;

    if(!isDefined(self.carriedby))
      self playSound("sentry_gun_beep");
  }
}

fire_on_nearby_players(_id_B026D19BC14D8AD0) {
  self endon("death");

  if(isDefined(self.mgturret))
    self.mgturret endon("death");

  self.targetent = spawn("script_origin", self.origin);
  self.shots_fired = 0;
  self._id_73DB5E595DC80C23 = 4;
  lights_on = 0;
  self.targeted_enemy = undefined;
  time_before_shoot = 0.05;

  if(isDefined(self.time_before_shoot))
    time_before_shoot = self.time_before_shoot;

  time_after_shoot = 0.05;

  if(isDefined(self.time_after_shoot))
    time_after_shoot = self.time_after_shoot;

  if(!isDefined(self.max_detection_sq))
    self.max_detection_sq = 4000000;

  if(isDefined(level._id_892990D1B2DA4A65))
    self.max_detection_sq = level._id_892990D1B2DA4A65;

  self.mgturret laseron();
  target_offset = (0, 0, 50);
  current_target = self.targetent;

  for(;;) {
    if(self.shots_fired >= self._id_73DB5E595DC80C23) {
      self._id_6575F6E151B73BD1 = 1;
      self.mgturret setmode("auto_nonai");
      self.mgturret setdefaultdroppitch(0);
      return;
    }

    while(!isDefined(self.owner)) {
      if(self.shots_fired >= self._id_73DB5E595DC80C23) {
        self._id_6575F6E151B73BD1 = 1;
        self.mgturret setmode("auto_nonai");
        self.mgturret setdefaultdroppitch(0);
        return;
      }

      _id_0D9E5028F8ED076F = undefined;

      if(isDefined(self.last_damaged_by)) {
        if(isDefined(level._id_892990D1B2DA4A65)) {
          if(distancesquared(self.mgturret.origin, self.last_damaged_by.origin) > level._id_892990D1B2DA4A65) {
            wait 0.05;
            continue;
          }
        } else if(distancesquared(self.mgturret.origin, self.last_damaged_by.origin) > self.max_detection_sq) {
          wait 0.05;
          continue;
        }

        if(isDefined(self.last_attacker) && gettime() <= self.last_attack_time + 500) {} else if(isDefined(_id_B026D19BC14D8AD0)) {
          fov = _id_B026D19BC14D8AD0;

          if(!scripts\engine\math::within_fov_2d(self.mgturret.origin, self.mgturret.angles, self.last_damaged_by.origin, fov)) {
            wait 0.05;
            continue;
          }
        }

        if(!drone_turret_canseetarget(self.last_damaged_by, target_offset)) {
          wait 0.05;
          continue;
        }

        _id_0D9E5028F8ED076F = self.last_damaged_by;
      }

      _id_1C3A549D5001F50C = 0;

      if(getdvarint("dvar_AF90E849D061B8A2", 0) != 0) {
        _id_0D9E5028F8ED076F = self.targetent;
        _id_1C3A549D5001F50C = 1;
        self.mgturret setmode("manual");
      } else if(self.mgturret getmode() != "sentry")
        self.mgturret setmode("sentry");

      if(!isDefined(_id_0D9E5028F8ED076F)) {
        _id_2A29B237DCC66FE5 = _id_EAC4117ECB82B75E();

        foreach(player in _id_2A29B237DCC66FE5) {
          if(isDefined(level._id_892990D1B2DA4A65)) {
            if(distancesquared(self.mgturret.origin, player.origin) > level._id_892990D1B2DA4A65)
              continue;
          } else if(distancesquared(self.mgturret.origin, player.origin) > self.max_detection_sq) {
            continue;
          }
          if(isDefined(self.last_attacker) && gettime() <= self.last_attack_time + 500) {} else if(isDefined(_id_B026D19BC14D8AD0)) {
            fov = _id_B026D19BC14D8AD0;

            if(!scripts\engine\math::within_fov_2d(self.mgturret.origin, self.mgturret.angles, player.origin, fov))
              continue;
          }

          if(!drone_turret_canseetarget(player, target_offset)) {
            continue;
          }
          _id_0D9E5028F8ED076F = player;
          break;
        }
      }

      if(!isDefined(_id_0D9E5028F8ED076F)) {
        wait 0.05;
        fwd = anglesToForward(self.angles);
        fwd = vectorNormalize(fwd);
        fwd = fwd * 100;
        self.targetent.origin = fwd + self.origin;
        self.mgturret settargetentity(self.targetent);
        current_target = self.targetent;
        self.targeted_enemy = undefined;

        if(lights_on)
          lights_on = 0;

        continue;
      } else {
        if(!lights_on) {
          self.mgturret laseron();
          lights_on = 1;
        }

        self.targeted_enemy = _id_0D9E5028F8ED076F;
        self.mgturret settargetentity(_id_0D9E5028F8ED076F);
        self.mgturret scripts\engine\utility::waittill_any_timeout_1(0.05, "turret_on_target");

        if((!_id_2925F3C5F960C89C(_id_0D9E5028F8ED076F) || !drone_turret_canseetarget(_id_0D9E5028F8ED076F, target_offset)) && !_id_1C3A549D5001F50C) {
          wait 0.1;

          if(lights_on)
            lights_on = 0;

          self.targeted_enemy = undefined;
          wait 0.05;
          continue;
        }

        if(!_id_1C3A549D5001F50C && _id_2925F3C5F960C89C(_id_0D9E5028F8ED076F)) {
          if(_id_0D9E5028F8ED076F != current_target) {
            if(!isDefined(_id_0D9E5028F8ED076F._id_57B1F5A348AD68A9))
              _id_0D9E5028F8ED076F._id_57B1F5A348AD68A9 = gettime();

            if(_id_0D9E5028F8ED076F._id_57B1F5A348AD68A9 + 10000 < gettime()) {
              _id_0D9E5028F8ED076F playlocalsound("canister_warning");
              _id_0D9E5028F8ED076F._id_57B1F5A348AD68A9 = gettime();
            }

            current_target = _id_0D9E5028F8ED076F;
          }
        }

        wait(time_before_shoot);

        if(_id_1C3A549D5001F50C) {} else if(!_id_2925F3C5F960C89C(_id_0D9E5028F8ED076F) || !drone_turret_canseetarget(_id_0D9E5028F8ED076F, target_offset) || distancesquared(self.mgturret.origin, _id_0D9E5028F8ED076F.origin) > self.max_detection_sq) {
          if(lights_on)
            lights_on = 0;

          self.targeted_enemy = undefined;
          current_target = self.targetent;
          continue;
        }

        self.mgturret burst_fire_turret(current_target);
        thread notify_nearby_enemies();
        wait(time_after_shoot);
      }

      if(isDefined(level._id_8C0C40822E2C4024)) {
        wait(level._id_8C0C40822E2C4024);
        continue;
      }

      wait 0.5;
    }

    wait 0.1;
  }
}

_id_2925F3C5F960C89C(target_ent) {
  if(isPlayer(target_ent))
    return target_ent scripts\cp\utility::is_valid_player();
  else if(isDefined(target_ent) && isalive(target_ent))
    return 1;

  return 0;
}

_id_EAC4117ECB82B75E() {
  _id_2A29B237DCC66FE5 = level.players;

  if(self.team == "allies")
    _id_2A29B237DCC66FE5 = getaiarray("axis");

  return _id_2A29B237DCC66FE5;
}

burst_fire_turret(current_target) {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  firetime = 0.1;
  _id_3746EC1BEFD86AE8 = 4;
  _id_3E92CD336A99CE02 = 6;
  _id_5F622C39D6661B23 = 2;
  _id_42AE243CD994C3BD = 4;

  for(;;) {
    _id_89F949A75D92E1A4 = randomintrange(_id_3746EC1BEFD86AE8, _id_3E92CD336A99CE02 + 1);
    start = self gettagorigin("tag_flash");
    offset = (randomintrange(-100, 100), randomintrange(-100, 100), 0);
    end = current_target.origin + offset;
    magicbullet("iw8_la_rpapa7_mp", start, end);
    self._id_13388E6E14BBFB33.shots_fired++;
    self notify("bullet_fired");

    if(self._id_13388E6E14BBFB33.shots_fired < self._id_13388E6E14BBFB33._id_73DB5E595DC80C23)
      wait(randomfloatrange(_id_5F622C39D6661B23, _id_42AE243CD994C3BD));

    return;
  }
}

notify_nearby_enemies() {
  level notify("enemy_spotted", self);
  enemies = scripts\cp\cp_agent_utils::getaliveagentsofteam(self.team);
  enemy_notify_range = 1000;

  if(isDefined(self.enemy_notify_range))
    enemy_notify_range = self.enemy_notify_range;

  _id_4CF33B57655A86C3 = scripts\engine\utility::get_array_of_closest(self.origin, enemies, undefined, undefined, enemy_notify_range);

  foreach(enemy in _id_4CF33B57655A86C3)
  enemy notify("bulletwhizby");
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

flicker_tank_lights() {
  self endon("death");
}

_id_184EB1D2AA71225C(target) {
  self endon("death");
  level endon("game_ended");
  self endon("lose_target");
  target endon("death_or_disconnect");
  maxrange = 4000000;

  for(;;) {
    if(distance2dsquared(target.origin, self.origin) < maxrange) {
      break;
    }

    wait 0.1;
  }

  if(isDefined(self.laser_fx))
    _id_86D00513B000B479();

  thread _id_0AB8DF173CD07CAD();
}

_id_0AB8DF173CD07CAD() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  maxrange = 4000050;
  target = self getturrettarget(0);

  for(;;) {
    if(!isDefined(target)) {
      return;
    }
    if(distance2dsquared(self.origin, target.origin) > maxrange) {
      thread _id_86D00513B000B479();
      return;
    } else
      wait 0.1;
  }
}

_id_86D00513B000B479() {
  if(isDefined(self.laser_fx))
    self.laser_fx delete();

  if(isDefined(self.laser_start_ent))
    self.laser_start_ent delete();

  if(isDefined(self.laser_end_ent))
    self.laser_end_ent delete();
}

_id_95C492792C7BCB56(_id_6B68C7899B0ED705) {
  _id_844661B1EEA5FFEE = self gettagorigin("tag_laser");
  laser_start_ent = scripts\engine\utility::spawn_tag_origin(_id_844661B1EEA5FFEE, (0, 0, 0));
  laser_start_ent show();
  self.laser_start_ent = laser_start_ent;
  thread follow_tag_laser_attach(laser_start_ent);
  _id_ED46B526E028A1FB = get_laser_end_loc();
  laser_end_ent = scripts\engine\utility::spawn_tag_origin(_id_ED46B526E028A1FB, (0, 0, 0));
  laser_end_ent show();
  self.laser_end_ent = laser_end_ent;
  laser_fx = playfxontagsbetweenclients(_id_6B68C7899B0ED705, laser_start_ent, "tag_origin", laser_end_ent, "tag_origin");
  laser_end_ent thread follow_first_vehicle_driver(self, laser_end_ent);
  laser_start_ent thread _id_1BA1B8853F211BE3(laser_start_ent, laser_fx);
  laser_end_ent thread _id_1BA1B8853F211BE3(laser_end_ent, laser_fx);
  return laser_fx;
}

follow_first_vehicle_driver(sentry, laser_end_ent) {
  laser_end_ent endon("death");
  sentry endon("death");

  for(;;) {
    endpos = sentry get_laser_end_loc();

    if(isDefined(endpos))
      laser_end_ent.origin = endpos;

    waitframe();
  }
}

follow_tag_laser_attach(laser_start_ent) {
  laser_start_ent endon("death");
  self endon("death");

  for(;;) {
    _id_5638C3C19559C7F0 = self gettagorigin("tag_laser");
    _id_6A5DAF9FBF65C11E = self gettagangles("tag_laser");
    _id_50BE9A8C628554B7 = anglesToForward(_id_6A5DAF9FBF65C11E);
    _id_CE978C0D67AFEB68 = anglestoright(_id_6A5DAF9FBF65C11E);
    _id_CED390888B8D7F80 = _id_5638C3C19559C7F0 + _id_50BE9A8C628554B7 + _id_CE978C0D67AFEB68;
    laser_start_ent.origin = _id_CED390888B8D7F80;
    waitframe();
  }
}

get_laser_end_loc() {
  _id_5638C3C19559C7F0 = self gettagorigin("tag_laser");
  _id_6A5DAF9FBF65C11E = self gettagangles("tag_laser");
  _id_50BE9A8C628554B7 = anglesToForward(_id_6A5DAF9FBF65C11E);
  _id_CE978C0D67AFEB68 = anglestoright(_id_6A5DAF9FBF65C11E);
  _id_78CEB106D9B681B1 = _id_5638C3C19559C7F0 + _id_50BE9A8C628554B7 * 10000 + _id_CE978C0D67AFEB68;
  contentoverride = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 0);
  ignoreents = [self];
  trace = scripts\engine\trace::ray_trace(_id_5638C3C19559C7F0, _id_78CEB106D9B681B1, ignoreents, contentoverride, 0);

  if(trace["fraction"] != 1.0)
    return trace["position"];

  return _id_78CEB106D9B681B1;
}

_id_1BA1B8853F211BE3(_id_E58D98C4472E2132, laser_fx) {
  laser_fx waittill("death");

  if(isDefined(_id_E58D98C4472E2132))
    _id_E58D98C4472E2132 delete();
}