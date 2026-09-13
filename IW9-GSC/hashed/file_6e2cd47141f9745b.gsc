/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6e2cd47141f9745b.gsc
***********************************************/

init() {
  level._effect["drone_turret_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_lrg_dest_exp.vfx");
  level._effect["drone_swarm_light_danger"] = loadfx("vfx/iw8_cp/raid/vfx_raid_wheelson_flashlight_npc.vfx");
  level._effect["drone_swarm_light_alert"] = loadfx("vfx/iw8_cp/raid/vfx_raid_wheelson_flashlight_npc_calm.vfx");

  if(!isDefined(level.drone_turrets))
    level.drone_turrets = [];

  level._id_EF94125F71754B2F = [];
  level._id_F753D22AE87B557B = 1;
  level thread _id_F0EAC5E558857C84();
}

_id_CB2C1DF00BD5E191(spawnpoint, _id_F716273270785091, _id_5761CB62BD849019) {
  return _id_305EC846C77281F6(spawnpoint, "axis", _id_F716273270785091, _id_5761CB62BD849019);
}

_id_BCA2AE187983E50A(spawnpoint, _id_F716273270785091, _id_5761CB62BD849019) {
  return _id_305EC846C77281F6(spawnpoint, "allies", _id_F716273270785091, _id_5761CB62BD849019);
}

_id_305EC846C77281F6(spawnpoint, _id_C1E547BABA2E6F87, _id_F716273270785091, _id_5761CB62BD849019) {
  if(level.drone_turrets.size >= 32) {
    return;
  }
  startpos = spawnpoint.origin;
  startang = spawnpoint.angles;
  vehicleinfo = "veh_radar_drone_recon_mp";
  _id_B923287498A8519A = "veh8_mil_air_tuniform_c4_ai";
  drone = spawnVehicle(_id_B923287498A8519A, "drone_turret", vehicleinfo, startpos, startang);
  drone.team = _id_C1E547BABA2E6F87;
  drone.spawnpoint = spawnpoint;
  drone.spawntime = gettime();
  drone._id_5761CB62BD849019 = _id_5761CB62BD849019;
  drone _id_98FBC01FF1E11FD8();
  _id_E8E1535DA20CE9DF = getEnt("malfa_clip", "targetname");
  drone.clip = spawn("script_model", _id_E8E1535DA20CE9DF.origin);
  drone.clip.angles = _id_E8E1535DA20CE9DF.angles;
  drone.clip clonebrushmodeltoscriptmodel(_id_E8E1535DA20CE9DF);
  drone.clip.origin = drone.origin;
  drone.clip.angles = drone.angles;
  drone.clip linkTo(drone, "j_body", (0, 0, 0), (0, 0, 0));
  drone.clip enableaimassist();
  drone.clip setCanDamage(1);
  drone.clip makeentitysentient(_id_C1E547BABA2E6F87, 1, 1);
  drone.clip._id_D1F953C063DFF1EB = 1;
  drone thread damage_feedback_watch();
  drone thread _id_5E52AE7FC7833E15();
  drone thread patrol_think(spawnpoint, _id_F716273270785091);
  drone thread watch_for_death();
  drone thread _id_53747F8CE3D99087();
  drone thread _id_D222480796864019();
  drone setscriptablepartstate("lights", "on", 0);
  drone setscriptablepartstate("glint", "on", 0);
  drone setturningability(0.6);
  drone setmaxpitchroll(10, 10);
  drone setairresistance(20);

  if(!isDefined(level.vehicle_ai_script_models))
    level.vehicle_ai_script_models = [];

  level.vehicle_ai_script_models[level.vehicle_ai_script_models.size] = drone;
  level.drone_turrets[level.drone_turrets.size] = drone;
  return drone;
}

_id_98FBC01FF1E11FD8() {
  if(!isDefined(level._id_EF94125F71754B2F[self._id_5761CB62BD849019]))
    level._id_EF94125F71754B2F[self._id_5761CB62BD849019] = spawnStruct();

  _id_DB46C7D01EE9223F = level._id_EF94125F71754B2F[self._id_5761CB62BD849019];

  if(!isDefined(_id_DB46C7D01EE9223F.drones))
    _id_DB46C7D01EE9223F.drones = [];

  if(!isDefined(_id_DB46C7D01EE9223F._id_5B47F0E93B535EC7))
    _id_DB46C7D01EE9223F._id_5B47F0E93B535EC7 = [];

  _id_DB46C7D01EE9223F.drones[_id_DB46C7D01EE9223F.drones.size] = self;

  if(!isDefined(_id_DB46C7D01EE9223F.id))
    _id_DB46C7D01EE9223F.id = self._id_5761CB62BD849019;

  self._id_DB46C7D01EE9223F = _id_DB46C7D01EE9223F;
  thread _id_7FEF88FA109A4A01();
}

_id_7FEF88FA109A4A01() {
  level endon("game_ended");
  _id_DB46C7D01EE9223F = self._id_DB46C7D01EE9223F;
  self waittill("death");
  _id_DB46C7D01EE9223F.drones = scripts\engine\utility::array_remove(_id_DB46C7D01EE9223F.drones, self);

  if(isDefined(self.headicon)) {
    _id_DB46C7D01EE9223F._id_5B47F0E93B535EC7 = scripts\engine\utility::array_remove(_id_DB46C7D01EE9223F._id_5B47F0E93B535EC7, self.headicon);
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  }
}

_id_34A36F44DD3B1EA9(_id_3CEAABC5D5A7FFBF) {
  wait 3;

  foreach(ref in _id_3CEAABC5D5A7FFBF) {
    if(isDefined(ref) && isent(ref)) {
      ref notify("death");
      ref delete();
    }
  }
}

_id_F0EAC5E558857C84() {
  self endon("death");

  for(;;) {
    wait 0.25;

    if(!isDefined(level.drone_turrets) || level.drone_turrets.size == 0) {
      wait 1;
      continue;
    }

    foreach(_id_D9D444D1B3160BA1 in level._id_EF94125F71754B2F) {
      if(!isDefined(_id_D9D444D1B3160BA1.leader)) {
        if(_id_D9D444D1B3160BA1.drones.size > 0) {
          _id_616AD255F43452AF = undefined;
          _id_72B9C1CA84591923 = _id_BA16DEBF946DBA5A();
          _id_0631D8B7B8CDB163 = _id_3693638F97674C98();
          _id_7F004B9BAFBAFA4A = _id_D9D444D1B3160BA1.drones _id_46AD4CB259B30031();
          closestplayer = _id_7F004B9BAFBAFA4A scripts\cp\utility::get_closest_living_player();

          foreach(drone in _id_D9D444D1B3160BA1.drones) {
            if(!drone _id_4149E78C6BEB0D0E(_id_72B9C1CA84591923, _id_0631D8B7B8CDB163)) {
              wait 0.05;
              continue;
            }

            if(!isDefined(_id_616AD255F43452AF)) {
              _id_616AD255F43452AF = drone;
              continue;
            }

            if(isDefined(closestplayer)) {
              _id_D32E4C561742E237 = distancesquared(drone.origin, closestplayer.origin);
              _id_C7E71D59C1C42DE7 = distancesquared(drone.origin, closestplayer.origin);

              if(_id_D32E4C561742E237 < _id_C7E71D59C1C42DE7)
                _id_616AD255F43452AF = drone;
            }
          }

          if(isDefined(_id_616AD255F43452AF))
            _id_616AD255F43452AF thread _id_021045A0D241029A();

          continue;
        }
      }

      if(!isent(_id_D9D444D1B3160BA1.leader) || !isalive(_id_D9D444D1B3160BA1.leader))
        _id_D9D444D1B3160BA1.leader = undefined;

      wait 0.05;
    }
  }
}

_id_021045A0D241029A() {
  self._id_DB46C7D01EE9223F.leader = self;
  self._id_DB46C7D01EE9223F notify("group_new_leader", self);
  thread _id_721CC43274BB86AF("alert");
  thread _id_8E8FD2EB99BA5B39();

  foreach(drone in self._id_DB46C7D01EE9223F.drones) {
    if(drone == self) {
      continue;
    }
    drone._id_3AEC9A4EC140655A = undefined;
    drone._id_47C08DE6597328AA = undefined;
    drone thread _id_721CC43274BB86AF("off");
  }
}

_id_BA16DEBF946DBA5A() {
  ignore = undefined;

  if(level.drone_turrets.size > 0) {
    ignore = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.drone_turrets.size; _id_AC0E594AC96AA3A8++) {
      ignore[ignore.size] = level.drone_turrets[_id_AC0E594AC96AA3A8];
      ignore[ignore.size] = level.drone_turrets[_id_AC0E594AC96AA3A8].clip;
    }
  }

  return ignore;
}

_id_3693638F97674C98() {
  contents = scripts\engine\trace::create_contents(0, 0, 0, 1, 1, 1, 0, 1);
  return contents;
}

_id_4149E78C6BEB0D0E(ignore, contents) {
  radius = 16;

  if(!isDefined(self) || !isDefined(self.origin))
    return 0;

  endpoint = self.origin;

  if(isDefined(self._id_2B16FD690B342C8E) && self._id_0F1C32AC23BAF6A5 > gettime() - 3000)
    endpoint = self._id_2B16FD690B342C8E;

  _id_E5354BE82A7990D5 = scripts\engine\trace::sphere_trace_passed(self.origin, endpoint, radius, ignore, contents);
  return _id_E5354BE82A7990D5;
}

_id_46AD4CB259B30031() {
  pos = undefined;
  num = 0;

  foreach(drone in self) {
    if(!isDefined(pos))
      pos = drone.origin;
    else
      pos = pos + drone.origin;

    num++;
  }

  struct = spawnStruct();
  struct.origin = pos / num;
  return struct;
}

_id_8E8FD2EB99BA5B39() {
  self waittill("death");
  self._id_DB46C7D01EE9223F notify("group_leader_death");

  if(isDefined(self.headicon))
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
}

_id_77F1C6A83258CEB9() {
  if(isDefined(self._id_DB46C7D01EE9223F.leader) && self._id_DB46C7D01EE9223F.leader == self)
    return 1;

  return 0;
}

patrol_think(spawnpoint, _id_F716273270785091) {
  self endon("death");

  if(isDefined(spawnpoint.script_parameters) && !istrue(level._id_54992799735B1AFB))
    self waittill(spawnpoint.script_parameters);

  thread scripts\engine\utility::play_loop_sound_on_entity("recondrone_eng_high");
  thread scripts\engine\utility::play_loop_sound_on_entity("emt_drone_proximity_lp");

  for(;;) {
    if(!isDefined(self._id_DB46C7D01EE9223F.leader) || !isalive(self._id_DB46C7D01EE9223F.leader))
      _id_C7A29D92E0EE715B(spawnpoint, _id_F716273270785091);

    if(isDefined(self._id_DB46C7D01EE9223F.leader) && self._id_DB46C7D01EE9223F.leader == self) {
      _id_8CF7F8B74219AC94(spawnpoint, _id_F716273270785091);
      continue;
    }

    if(isDefined(self._id_DB46C7D01EE9223F.leader) && self._id_DB46C7D01EE9223F.leader != self)
      _id_327CE98E7384E9FF(spawnpoint, _id_F716273270785091);
  }
}

_id_8CF7F8B74219AC94(spawnpoint, _id_F716273270785091) {
  self endon("death");
  self._id_3FCAA9AA353A7778 = 0.8;
  self setturningability(self._id_3FCAA9AA353A7778);
  offset = undefined;
  speed = 10;

  if(isDefined(level._id_3E81A9FCEDD1021D))
    speed = level._id_3E81A9FCEDD1021D;

  speed = speed * 0.75;
  _id_ACF81F9900BE7297 = 500;
  self._id_4E606F5ACA19D584 = squared(250);
  self._id_9896FA8B6E050049 = squared(900);

  if(isDefined(_id_F716273270785091) && isstring(_id_F716273270785091))
    self.node_grid = scripts\engine\utility::getStructArray(_id_F716273270785091, "script_noteworthy");
  else
    self.node_grid = scripts\engine\utility::getStructArray("drone_grid", "script_noteworthy");

  end_pos = self.origin;
  _id_88B8D987C09FC6C6 = 0;
  self._id_9307BB132B2C0B9F = "spawn";
  self._id_2E13FDA08C2B1AE6 = 800;
  self._id_950028441BA5FACB = self._id_2E13FDA08C2B1AE6 * self._id_2E13FDA08C2B1AE6;
  node = spawnpoint;

  for(;;) {
    enemy_target = _id_CC76A1FBA850F228();

    if(!isDefined(enemy_target)) {
      if(!isDefined(self._id_3AEC9A4EC140655A))
        _id_9AB4DE075453475B();
      else
        end_pos = self._id_3AEC9A4EC140655A;

      if(self._id_9307BB132B2C0B9F != "no_target") {
        if(getDvar("astar_debug") != "")
          level thread scripts\cp\utility::drawsphere(end_pos, 5, 1, (1, 1, 1));

        _id_D5685B7BAEE6505E = self.origin;
        _id_17947F4A9AA52B15 = self;
        _id_6EE6C2CA7C64E9C9 = spawnStruct();
        _id_6EE6C2CA7C64E9C9.origin = self.origin;
        self.path_data = scripts\cp\astar::_id_845FD743C0FADC39(self.node_grid, _id_D5685B7BAEE6505E, end_pos, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_ACF81F9900BE7297);

        if(!isDefined(self.path_data)) {
          wait 0.5;
          _id_9AB4DE075453475B();
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
    } else if(_id_09ADA223F5F41E90(enemy_target)) {
      self._id_565AE80D9FECF7CA = enemy_target;
      self._id_8D8144287647FBC5 = 1;
      _id_EB38987B1C34B60F(enemy_target);
      self notify("stop_dive_bomb");
      self._id_47C08DE6597328AA = 1;
      self._id_8D8144287647FBC5 = undefined;
    } else if(istrue(self._id_47C08DE6597328AA)) {
      node_grid = self.node_grid;
      self._id_47C08DE6597328AA = undefined;

      foreach(drone in level.drone_turrets) {
        if(drone == self) {
          continue;
        }
        if(isDefined(drone.next_node))
          node_grid = scripts\engine\utility::array_remove(node_grid, drone.next_node);
      }

      _id_D5685B7BAEE6505E = self.origin;
      end_pos = enemy_target.origin;
      _id_E14AC44F6F147496 = enemy_target.origin;
      _id_FFB54732E70D0F73 = sortbydistancecullbyradius(node_grid, end_pos, 800);

      if(isDefined(_id_FFB54732E70D0F73) && _id_FFB54732E70D0F73.size > 0) {
        _id_E8E4ED22F3D730B4 = [];

        foreach(node in _id_FFB54732E70D0F73) {
          if(!isDefined(node)) {
            continue;
          }
          if(node drone_turret_canseetarget(enemy_target, (0, 0, 0), self))
            _id_E8E4ED22F3D730B4[_id_E8E4ED22F3D730B4.size] = node;
        }

        if(_id_E8E4ED22F3D730B4.size > 0) {
          _id_E14AC44F6F147496 = _id_E8E4ED22F3D730B4[randomintrange(0, int(min(3, _id_E8E4ED22F3D730B4.size)))];
          _id_E14AC44F6F147496 = _id_E14AC44F6F147496.origin;
        } else {
          _id_9AB4DE075453475B();
          _id_E14AC44F6F147496 = self._id_3AEC9A4EC140655A;
        }
      }

      _id_17947F4A9AA52B15 = [self, self.clip];

      if(level.drone_turrets.size > 0) {
        _id_17947F4A9AA52B15 = [];

        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.drone_turrets.size; _id_AC0E594AC96AA3A8++) {
          _id_17947F4A9AA52B15[_id_17947F4A9AA52B15.size] = level.drone_turrets[_id_AC0E594AC96AA3A8];
          _id_17947F4A9AA52B15[_id_17947F4A9AA52B15.size] = level.drone_turrets[_id_AC0E594AC96AA3A8].clip;
        }
      }

      _id_6EE6C2CA7C64E9C9 = spawnStruct();
      _id_6EE6C2CA7C64E9C9.origin = self.origin;
      self.path_data = scripts\cp\astar::_id_845FD743C0FADC39(node_grid, _id_D5685B7BAEE6505E, _id_E14AC44F6F147496, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_ACF81F9900BE7297);

      if(!isDefined(self.path_data)) {
        wait 0.1;
        continue;
      }

      if(getDvar("astar_debug") != "") {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.path_data.path.size; _id_AC0E594AC96AA3A8++) {
          if(isDefined(self.path_data.path[_id_AC0E594AC96AA3A8]) && isDefined(self.path_data.path[_id_AC0E594AC96AA3A8 + 1])) {}
        }
      }

      next_node = self.path_data.start_node;
      _id_88B8D987C09FC6C6 = 0;

      if(self._id_9307BB132B2C0B9F != "re_path")
        self._id_9307BB132B2C0B9F = "re_path";
    } else if(_id_9C77FA5E9C0C9A98(enemy_target, end_pos)) {
      node_grid = self.node_grid;
      _id_D5685B7BAEE6505E = self.origin;
      end_pos = enemy_target.origin;
      _id_E14AC44F6F147496 = enemy_target.origin;
      _id_FFB54732E70D0F73 = sortbydistancecullbyradius(node_grid, end_pos, 800);

      if(_id_FFB54732E70D0F73.size > 0) {
        _id_E8E4ED22F3D730B4 = [];

        foreach(node in _id_FFB54732E70D0F73) {
          if(node drone_turret_canseetarget(enemy_target, (0, 0, 0), self))
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
      self.path_data = scripts\cp\astar::_id_845FD743C0FADC39(node_grid, _id_D5685B7BAEE6505E, _id_E14AC44F6F147496, _id_17947F4A9AA52B15, _id_6EE6C2CA7C64E9C9, _id_ACF81F9900BE7297);

      if(!isDefined(self.path_data)) {
        wait 0.1;
        continue;
      }

      if(getDvar("astar_debug") != "") {
        for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.path_data.path.size; _id_AC0E594AC96AA3A8++) {
          if(isDefined(self.path_data.path[_id_AC0E594AC96AA3A8]) && isDefined(self.path_data.path[_id_AC0E594AC96AA3A8 + 1])) {}
        }
      }

      if(getDvar("astar_debug") != "") {
        _id_A54D8B03B3F42B54 = (0, 1, 1);
        level thread scripts\cp\utility::drawsphere(_id_E14AC44F6F147496, 5, 1, _id_A54D8B03B3F42B54);
      }

      next_node = self.path_data.start_node;

      if(self._id_9307BB132B2C0B9F != "new_target_loc") {
        _id_88B8D987C09FC6C6 = 0;
        self._id_9307BB132B2C0B9F = "new_target_loc";
      }
    } else if(self._id_9307BB132B2C0B9F != "hunt_target")
      self._id_9307BB132B2C0B9F = "hunt_target";

    if(!isDefined(self.path_data)) {
      wait 0.1;
      _id_09D76B32CAC3B3EC();
      continue;
    }

    if(!isDefined(self.path_data.path[_id_88B8D987C09FC6C6])) {
      if(_id_88B8D987C09FC6C6 >= self.path_data.path.size) {
        self._id_9307BB132B2C0B9F = "path_done";
        _id_09D76B32CAC3B3EC();
      }

      wait 0.1;
      continue;
    }

    if(istrue(self._id_47C08DE6597328AA)) {
      if(_id_BAAD9BB95A202B57()) {
        _id_4B94D0301D662C36();
        continue;
      }
    }

    next_node = self.path_data.path[_id_88B8D987C09FC6C6];

    if(_id_BAAD9BB95A202B57()) {
      self._id_47C08DE6597328AA = 1;
      _id_4B94D0301D662C36();
      continue;
    }

    self playsoundonmovingent("cp_bomb_drone_pause");

    if(!drone_turret_canseetarget(next_node, (0, 0, 0), self)) {
      if(isDefined(level._id_77D9637A0FC5A67E))
        announcement("drone tried to path through a wall?");

      if(gettime() - self.spawntime > 10000) {
        self._id_47C08DE6597328AA = 1;
        wait 0.1;
        continue;
      }
    }

    move_to_new_node(next_node, _id_88B8D987C09FC6C6, offset, speed);
    _id_88B8D987C09FC6C6++;
    wait 0.1;
  }
}

_id_327CE98E7384E9FF(spawnpoint, _id_F716273270785091) {
  self._id_DB46C7D01EE9223F endon("group_leader_death");
  self._id_DB46C7D01EE9223F endon("group_new_leader");
  self endon("death");
  _id_AE447F3203E2AADB = randomfloatrange(0.05, 0.2);
  _id_67168602B0241E34 = randomintrange(14, 40);
  _id_DAA711E95F6EBFEE = _id_67168602B0241E34 * -1;
  speed = 10;

  if(isDefined(level._id_3E81A9FCEDD1021D))
    speed = level._id_3E81A9FCEDD1021D;

  self vehicle_setspeed(speed, speed * 0.4, speed * 0.95);
  self.speed = speed;
  self._id_3FCAA9AA353A7778 = 1.0;
  self setturningability(self._id_3FCAA9AA353A7778);

  if(isDefined(_id_F716273270785091) && isstring(_id_F716273270785091))
    self.node_grid = scripts\engine\utility::getStructArray(_id_F716273270785091, "script_noteworthy");
  else
    self.node_grid = scripts\engine\utility::getStructArray("drone_grid", "script_noteworthy");

  for(;;) {
    leader = self._id_DB46C7D01EE9223F.leader;
    offset = (randomfloatrange(_id_DAA711E95F6EBFEE, _id_67168602B0241E34), randomfloatrange(_id_DAA711E95F6EBFEE, _id_67168602B0241E34), randomfloatrange(_id_DAA711E95F6EBFEE, _id_67168602B0241E34));
    thread _id_D677741135245C73(leader.origin, offset);
    self._id_2B16FD690B342C8E = leader.origin;
    self._id_0F1C32AC23BAF6A5 = gettime();
    self.current_node = undefined;
    wait(_id_AE447F3203E2AADB);
  }
}

_id_C7A29D92E0EE715B(spawnpoint, _id_F716273270785091) {
  self._id_DB46C7D01EE9223F endon("group_leader_death");
  self._id_DB46C7D01EE9223F endon("group_new_leader");
  self endon("death");
  speed = 10;

  if(isDefined(level._id_3E81A9FCEDD1021D))
    speed = level._id_3E81A9FCEDD1021D;

  self vehicle_setspeed(speed, speed * 0.4, speed * 0.95);
  self.speed = speed;
  self._id_3FCAA9AA353A7778 = 1.0;
  self setturningability(self._id_3FCAA9AA353A7778);
  _id_336A7187172CE931 = [];

  if(isDefined(_id_F716273270785091) && isstring(_id_F716273270785091))
    self.node_grid = scripts\engine\utility::getStructArray(_id_F716273270785091, "script_noteworthy");
  else
    self.node_grid = scripts\engine\utility::getStructArray("drone_grid", "script_noteworthy");

  _id_336A7187172CE931 = self.node_grid;

  for(;;) {
    _id_D6EB01B1DC33FFDC = scripts\engine\utility::getclosest(self.origin, _id_336A7187172CE931);
    _id_0D49262AB30E7C20 = distance(self.origin, _id_D6EB01B1DC33FFDC.origin);

    if(_id_0D49262AB30E7C20 < 16) {
      _id_336A7187172CE931 = scripts\engine\utility::array_remove(_id_336A7187172CE931, _id_D6EB01B1DC33FFDC);
      _id_D6EB01B1DC33FFDC = undefined;
    }

    if(isDefined(_id_D6EB01B1DC33FFDC))
      thread _id_D677741135245C73(_id_D6EB01B1DC33FFDC.origin, (0, 0, 0));

    wait 0.25;
  }
}

_id_6374F2634771C899() {
  if(isDefined(self._id_DB46C7D01EE9223F.leader)) {
    if(isent(self._id_DB46C7D01EE9223F.leader) && isalive(self._id_DB46C7D01EE9223F.leader)) {
      end_pos = self._id_DB46C7D01EE9223F.leader.origin;
      self._id_3AEC9A4EC140655A = end_pos;
      self._id_87BABC8A58BC3639 = gettime();
    }
  }
}

_id_9AB4DE075453475B() {
  _id_D6EB01B1DC33FFDC = scripts\engine\utility::getclosest(self.origin, self.node_grid);
  self._id_3AEC9A4EC140655A = _id_D6EB01B1DC33FFDC.origin;
  self._id_87BABC8A58BC3639 = gettime();
  speed = 10;

  if(isDefined(level._id_3E81A9FCEDD1021D))
    speed = level._id_3E81A9FCEDD1021D;

  self vehicle_setspeed(speed, speed * 0.4, speed * 0.95);
  self.speed = speed;
  self._id_3FCAA9AA353A7778 = 1.0;
  self setturningability(self._id_3FCAA9AA353A7778);
  self.current_node = _id_D6EB01B1DC33FFDC;
  thread _id_D677741135245C73(_id_D6EB01B1DC33FFDC.origin, (0, 0, 0));
  wait 2;
}

_id_BAAD9BB95A202B57() {
  _id_5A869FB9E51F4894 = 0;

  if(isDefined(self._id_DB46C7D01EE9223F.leader) && self._id_DB46C7D01EE9223F.leader != self) {
    if(distance(self._id_DB46C7D01EE9223F.leader.origin, self.origin) < 64) {
      foreach(_id_99B422971992819C in self._id_DB46C7D01EE9223F.drones) {
        if(_id_99B422971992819C == self) {
          continue;
        }
        if(distance(_id_99B422971992819C.origin, self.origin) < 48)
          _id_5A869FB9E51F4894 = 1;
      }
    }
  }

  return _id_5A869FB9E51F4894;
}

_id_4B94D0301D662C36() {
  wait 0.05;
}

_id_09ADA223F5F41E90(enemy_target) {
  if(isstruct(enemy_target))
    return 0;

  if(gettime() - self.spawntime < 3000)
    return 0;

  if(distancesquared(self.origin, enemy_target.origin) > self._id_950028441BA5FACB)
    return 0;

  if(istrue(self._id_47C08DE6597328AA))
    return 0;

  _id_445CECBEFD8DC42D = enemy_target _meth_6F55D55CCFF20D14() && _id_3FF5FA5CFFDD0AA8(enemy_target);

  if(_id_445CECBEFD8DC42D)
    return 1;

  canseetarget = drone_turret_canseetarget(enemy_target, (0, 0, 0), self);

  if(canseetarget)
    return 1;

  if(distancesquared(self.origin, enemy_target.origin) < self._id_4E606F5ACA19D584) {
    canseetarget = drone_turret_canseetarget(enemy_target, (0, 0, 0), self, 2, 1);

    if(canseetarget)
      return 1;
  }

  return 0;
}

_id_EB38987B1C34B60F(enemy_target) {
  if(isstruct(enemy_target))
    move_to_new_node(enemy_target, 0, (0, 0, 50), 33, 0.3);
  else {
    _id_A32C066ABF8931AD = _id_EAC4117ECB82B75E();
    _id_A32C066ABF8931AD = sortbydistancecullbyradius(_id_A32C066ABF8931AD, enemy_target.origin, self._id_2E13FDA08C2B1AE6);
    thread _id_40C75443A87EF6C5();
    self setturningability(0.95);
    self setlookatent(enemy_target);
    _id_2FF28DA0A9FF8959 = vectortoangles(enemy_target.origin - self.origin);
    self setgoalyaw(_id_2FF28DA0A9FF8959[1]);
    self setyawspeed(500, 300, 270, 0.3);
    thread _id_EB8BBC754779B523();
    thread _id_721CC43274BB86AF("danger");
    thread _id_94D8111112FFC480();
    move_to_new_node(enemy_target, 0, (0, 0, 50), 33, 0.3);
  }
}

_id_390147C3B3FFF1CB(_id_A32C066ABF8931AD) {
  _id_1EE5D92113C13508 = scripts\cp_mp\entityheadicons::setheadicon_singleimage;
  dist = self._id_2E13FDA08C2B1AE6 * 1.1;
  self.headicon = self thread[[_id_1EE5D92113C13508]](_id_A32C066ABF8931AD, "icon_ping_warning", 32, 1, dist, 256, undefined, 0, 1);
  self._id_DB46C7D01EE9223F._id_5B47F0E93B535EC7[self._id_DB46C7D01EE9223F._id_5B47F0E93B535EC7.size] = self.headicon;
}

_id_40C75443A87EF6C5() {
  self endon("death");
  self endon("stop_dive_bomb");

  for(;;) {
    playrumbleonposition("cp_wheelson_rumble", self.origin);
    wait 0.25;
  }
}

_id_EB8BBC754779B523() {
  self endon("death");
  self endon("stop_dive_bomb");

  for(;;) {
    self playsoundonmovingent("cp_bomb_drone_warning");
    wait 0.5;
  }
}

_id_9C77FA5E9C0C9A98(enemy_target, end_pos) {
  if(!isDefined(self.path_data) || self._id_9307BB132B2C0B9F == "path_done")
    return 1;

  if(distancesquared(enemy_target.origin, end_pos) > self._id_4E606F5ACA19D584) {
    if(distancesquared(self.origin, enemy_target.origin) > self._id_9896FA8B6E050049 && distancesquared(self.origin, end_pos) > self._id_9896FA8B6E050049)
      return 0;

    return 1;
  }

  return 0;
}

drone_turret_canseetarget(target, offset, drone, _id_921B9D1AB6394420, _id_726B4BF92CAC7D7B) {
  if(!isDefined(offset))
    offset = (0, 0, 0);

  _id_027B697504D9397D = 0;
  contents = scripts\engine\trace::create_contents(0, 0, 0, 1, 1, 1, 0, 1);

  if(!isstruct(target))
    _id_D895C679F6A927E5 = [target gettagorigin("j_head"), target gettagorigin("j_mainroot")];
  else
    _id_D895C679F6A927E5 = [target.origin];

  radius = 16;

  if(isDefined(level.astar_node_radius_override))
    radius = level.astar_node_radius_override;

  if(isDefined(_id_921B9D1AB6394420))
    radius = _id_921B9D1AB6394420;

  ignore = undefined;
  start = self;
  fov = cos(100);

  if(level.drone_turrets.size > 0) {
    ignore = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.drone_turrets.size; _id_AC0E594AC96AA3A8++) {
      ignore[ignore.size] = level.drone_turrets[_id_AC0E594AC96AA3A8];
      ignore[ignore.size] = level.drone_turrets[_id_AC0E594AC96AA3A8].clip;
    }
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    _id_6C31025C58CD1AD8 = scripts\engine\trace::sphere_trace(start.origin + offset, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], radius, ignore, contents);

    if(_id_6C31025C58CD1AD8["fraction"] < 1.0) {
      continue;
    }
    if(isDefined(drone)) {
      if(!isstruct(target)) {
        if(target _meth_6F55D55CCFF20D14() && !drone _id_3FF5FA5CFFDD0AA8(target)) {
          continue;
        }
        if(!istrue(_id_726B4BF92CAC7D7B)) {
          if(!scripts\engine\utility::within_fov(start.origin + offset, drone.angles, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], fov))
            continue;
        }
      }
    }

    _id_027B697504D9397D = 1;
    break;
  }

  return _id_027B697504D9397D;
}

_id_3FF5FA5CFFDD0AA8(target) {
  if(!isPlayer(target))
    return 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self._id_DB46C7D01EE9223F.drones.size; _id_AC0E594AC96AA3A8++) {
    _id_A38BCB54E21B2F5F = self._id_DB46C7D01EE9223F.drones[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_A38BCB54E21B2F5F.last_damaged_by) && _id_A38BCB54E21B2F5F.last_damaged_by == target)
      return 1;
  }

  return 0;
}

_id_DE436DB710384FE2() {
  _id_DC1A0178A2C53770 = self._id_DB46C7D01EE9223F.drones.size;

  if(_id_DC1A0178A2C53770 < 4.2)
    return 1;

  return 0;
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

  if(!isDefined(self) || !isDefined(self.origin))
    return enemy_target;

  if(isDefined(self._id_3AEC9A4EC140655A)) {
    if(self._id_87BABC8A58BC3639 + 2000 < gettime())
      self._id_3AEC9A4EC140655A = undefined;
  }

  if(isDefined(self._id_DB46C7D01EE9223F) && isDefined(self._id_DB46C7D01EE9223F.leader) && self._id_DB46C7D01EE9223F.leader != self)
    return enemy_target;

  if(isDefined(enemy_target) && isDefined(enemy_target.origin)) {
    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset, self)) {
      self._id_3AEC9A4EC140655A = enemy_target.origin;
      self._id_87BABC8A58BC3639 = gettime();
      return enemy_target;
    }
  }

  _id_5BF33998853D38AE = _id_EAC4117ECB82B75E();

  if(!isDefined(_id_5BF33998853D38AE) || _id_5BF33998853D38AE.size < 1)
    return enemy_target;

  if(isDefined(self.origin))
    _id_5BF33998853D38AE = sortbydistance(_id_5BF33998853D38AE, self.origin);

  _id_F76842485BABEE15 = 160000;

  if(_id_DE436DB710384FE2())
    _id_F76842485BABEE15 = 1440000;

  foreach(enemy_target in _id_5BF33998853D38AE) {
    if(distancesquared(enemy_target.origin, self.origin) > _id_F76842485BABEE15) {
      continue;
    }
    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset, self)) {
      self._id_3AEC9A4EC140655A = enemy_target.origin;
      self._id_87BABC8A58BC3639 = gettime();
      _id_76B97D7B11066363();
      return enemy_target;
    }
  }

  if(istrue(level._id_7AE7CCFF11823A4B)) {
    if(!isDefined(level._id_44A584EDFEB159A2)) {
      level._id_44A584EDFEB159A2 = [];
      _id_D5257E0C17926BD4 = "drones_path_stealth";

      if(isDefined(level._id_43D6260EC0484E29))
        _id_D5257E0C17926BD4 = level._id_43D6260EC0484E29;

      _id_9C6F15FA4F485D2F = scripts\engine\utility::getStruct(_id_D5257E0C17926BD4, "targetname");
      level._id_44A584EDFEB159A2[level._id_44A584EDFEB159A2.size] = _id_9C6F15FA4F485D2F;

      if(!isDefined(_id_9C6F15FA4F485D2F))
        return enemy_target;

      while(isDefined(_id_9C6F15FA4F485D2F.target)) {
        _id_9C6F15FA4F485D2F = scripts\engine\utility::getStruct(_id_9C6F15FA4F485D2F.target, "targetname");
        level._id_44A584EDFEB159A2[level._id_44A584EDFEB159A2.size] = _id_9C6F15FA4F485D2F;
      }
    }

    if(level._id_44A584EDFEB159A2.size == 0)
      return enemy_target;

    if(!isDefined(self._id_27ED911E8764D33A))
      self._id_27ED911E8764D33A = 0;

    if(!isDefined(level._id_44A584EDFEB159A2[self._id_27ED911E8764D33A]))
      return enemy_target;

    _id_E0D9D2880C046704 = level._id_44A584EDFEB159A2[self._id_27ED911E8764D33A];

    if(!isDefined(_id_E0D9D2880C046704) || !isDefined(_id_E0D9D2880C046704.origin))
      return enemy_target;

    if(distancesquared(self.origin, _id_E0D9D2880C046704.origin) < 90000) {
      self._id_27ED911E8764D33A++;

      if(self._id_27ED911E8764D33A >= level._id_44A584EDFEB159A2.size)
        self._id_27ED911E8764D33A = 0;

      if(isDefined(level._id_44A584EDFEB159A2[self._id_27ED911E8764D33A])) {
        _id_E0D9D2880C046704 = level._id_44A584EDFEB159A2[self._id_27ED911E8764D33A];
        self.current_node = _id_E0D9D2880C046704;
      }
    }

    if(!isDefined(self.path_data))
      self._id_47C08DE6597328AA = 1;

    self._id_3AEC9A4EC140655A = _id_E0D9D2880C046704.origin;
    self._id_87BABC8A58BC3639 = gettime();
    return _id_E0D9D2880C046704;
  }

  if(isDefined(level._id_8D1CB2F62CE55C8A)) {
    foreach(enemy in _id_5BF33998853D38AE) {
      if(enemy == level._id_8D1CB2F62CE55C8A) {
        if(isDefined(self._id_DB46C7D01EE9223F) && isDefined(self._id_DB46C7D01EE9223F.leader) && self._id_DB46C7D01EE9223F.leader == self) {
          self._id_3AEC9A4EC140655A = enemy.origin;
          self._id_87BABC8A58BC3639 = gettime();
          return enemy;
        }
      }
    }
  }

  foreach(enemy_target in _id_5BF33998853D38AE) {
    if(!isDefined(enemy_target) || !isDefined(enemy_target.origin)) {
      continue;
    }
    target_offset = (0, 0, 50);

    if(drone_turret_canseetarget(enemy_target, target_offset, self)) {
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
  self notify("move_to_new_node");
  self endon("move_to_new_node");

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

    level thread scripts\cp\utility::drawsphere(node.origin, 5, 1, _id_A54D8B03B3F42B54);
  }

  if(dist > 1) {
    self.next_node = node;
    speed = 10;

    if(isDefined(speed_override))
      speed = speed_override;

    if(isDefined(level._id_3E81A9FCEDD1021D)) {
      if(isDefined(level._id_95FD31D093A7B7AA) && level._id_95FD31D093A7B7AA != self)
        speed = level._id_3E81A9FCEDD1021D;
      else if(self._id_DB46C7D01EE9223F.drones.size > 1)
        speed = level._id_3E81A9FCEDD1021D * 0.8;
      else
        speed = level._id_3E81A9FCEDD1021D;
    }

    self.move_speed = speed;
    self vehicle_setspeed(speed, speed * 0.2, speed * 0.95);
    _id_2FF28DA0A9FF8959 = vectortoangles(node.origin - self.origin);
    self setgoalyaw(_id_2FF28DA0A9FF8959[1]);
    self setyawspeed(400, 300, 270, 0.3);
    thread _id_D677741135245C73(node, offset, update_time);
    scripts\engine\utility::waittill_any_timeout_2(15, "near_goal", "stop_tracking");
    self notify("stop_tracking");
    self.next_node = undefined;
    self.current_node = node;
    self.move_speed = 0;
    self vehicle_setspeedimmediate(1, 12, 12);
  } else
    wait 0.1;
}

_id_D677741135245C73(node, offset, update_time) {
  self endon("death");
  self endon("stop_tracking");
  self notify("update_goal_pos");
  self endon("update_goal_pos");
  pos = undefined;

  if(isvector(node))
    pos = node;
  else if(isDefined(node.origin))
    pos = node.origin;

  if(!isDefined(pos)) {
    return;
  }
  if(istrue(level._id_77D9637A0FC5A67E)) {
    _id_0AF4A7323E71B404 = 0;
    _id_06A3A1033FFC2699 = pos - self.origin;
    _id_96020F25B789ACCF = length(_id_06A3A1033FFC2699);

    if(_id_96020F25B789ACCF > 2) {
      ignore = [self, self.clip];
      _id_1BFA180C6FDD09DD = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
      start = _id_96020F25B789ACCF * 0.25;

      for(_id_AC0E594AC96AA3A8 = start; _id_AC0E594AC96AA3A8 < _id_96020F25B789ACCF; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 * 1.1) {
        _id_29AEA598C15F22F8 = self.origin + vectorNormalize(_id_06A3A1033FFC2699) * _id_AC0E594AC96AA3A8;
        _id_DA461B632FC8E9DE = _id_29AEA598C15F22F8 + (0, 0, 150);
        passed = scripts\engine\trace::sphere_trace_passed(_id_29AEA598C15F22F8, _id_DA461B632FC8E9DE, 8, ignore, _id_1BFA180C6FDD09DD);

        if(passed) {
          _id_0AF4A7323E71B404++;
          continue;
        }
      }
    }

    if(_id_0AF4A7323E71B404 > 10)
      announcement("Wallcheck!");
  }

  self setvehgoalpos(pos + offset, 0);

  if(isDefined(level._id_903F92904B8791E0))
    self setneargoalnotifydist(level._id_903F92904B8791E0);

  if(isDefined(update_time) && update_time > 0) {
    _id_2BC7779D8637C25D = 0;
    thread _id_A953E534FF89430A(12);

    for(;;) {
      wait(update_time);

      if(isDefined(node.origin))
        pos = node.origin;

      self setvehgoalpos(pos + offset, 0);

      if(isDefined(self._id_3589A53AB80793C7)) {
        continue;
      }
      if(!drone_turret_canseetarget(node, offset, self)) {
        if(distancesquared(self.origin, pos + offset) > 22500) {
          self notify("stop_tracking");
          continue;
        }

        ignore = [];

        if(level.drone_turrets.size > 0) {
          for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.drone_turrets.size; _id_AC0E594AC96AA3A8++) {
            ignore[ignore.size] = level.drone_turrets[_id_AC0E594AC96AA3A8];
            ignore[ignore.size] = level.drone_turrets[_id_AC0E594AC96AA3A8].clip;
          }
        }

        contents = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
        _id_6C31025C58CD1AD8 = scripts\engine\trace::ray_trace(self.origin, node.origin, ignore, contents);
        self._id_3589A53AB80793C7 = spawnStruct();
        self._id_3589A53AB80793C7.origin = _id_6C31025C58CD1AD8["position"];
        node = self._id_3589A53AB80793C7;
      }
    }
  }
}

_id_A953E534FF89430A(timer) {
  self endon("death");
  self endon("stop_tracking");
  thread _id_F0794596985DCDB4();
  wait(timer);
  self notify("stop_tracking");
}

_id_F0794596985DCDB4() {
  self endon("death");
  self waittill("stop_tracking");
  thread _id_721CC43274BB86AF("alert");
  self setturningability(self._id_3FCAA9AA353A7778);
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

_id_721CC43274BB86AF(state, _id_29B7BCDE1751519D) {
  if(!isDefined(self._id_4E3EA138AA2442FD))
    self._id_4E3EA138AA2442FD = "tag_camera_fx";

  self._id_34A833CF8E285177 = self._id_1AE06A02FBBA3B31;
  self._id_1AE06A02FBBA3B31 = state;
  _id_9FDA1F9DCA69810C();

  if(self._id_1AE06A02FBBA3B31 == "danger")
    playFXOnTag(level._effect["drone_swarm_light_danger"], self, self._id_4E3EA138AA2442FD);
  else if(self._id_1AE06A02FBBA3B31 == "alert")
    playFXOnTag(level._effect["drone_swarm_light_alert"], self, self._id_4E3EA138AA2442FD);
  else {}
}

_id_9FDA1F9DCA69810C() {
  if(!isDefined(self._id_34A833CF8E285177)) {
    return;
  }
  if(self._id_34A833CF8E285177 == "alert")
    stopFXOnTag(level._effect["drone_swarm_light_alert"], self, self._id_4E3EA138AA2442FD);
  else if(self._id_34A833CF8E285177 == "danger")
    stopFXOnTag(level._effect["drone_swarm_light_danger"], self, self._id_4E3EA138AA2442FD);
}

_id_27B2B1F4F6013D20() {
  self endon("death");

  if(!isDefined(self._id_DDDCF6433FFA5AAA) && _id_77F1C6A83258CEB9()) {
    self._id_DDDCF6433FFA5AAA = 1;
    _id_346F237F388C0946 = self.origin;
    velocity = (0, 0, -10);

    if(isDefined(self._id_565AE80D9FECF7CA))
      _id_346F237F388C0946 = self._id_565AE80D9FECF7CA.origin;

    magicgrenademanual("smoke_grenade_mp", _id_346F237F388C0946, velocity, 0.05);
    thread scripts\engine\utility::play_sound_in_space("smoke_grenade_expl_trans", self.origin);
  }
}

damage_feedback_watch() {
  self endon("death");
  level endon("game_ended");
  self setCanDamage(0);
  self.health = 100000;
  self.clip setCanDamage(1);
  self.clip.health = 100000;
  self.clip.fake_health = 50;
  _id_7DB16320F78CAD3F = self.team == "axis";

  if(!_id_7DB16320F78CAD3F)
    self.clip.fake_health = 200;

  self._id_689D46E1E37CC5AD = ::_id_C5D04118503D4EA7;

  for(;;) {
    self.clip waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, _id_9E834FE6754A9C98, _id_1D3F20A69CED2DD5, _id_920FF4456CE9A2FC, idflags, objweapon, origin, angles, normal, einflictor, eventid);
    self.clip.fake_health = self.clip.fake_health - idamage;
    self.clip.health = 100000;

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

    _id_76B97D7B11066363();
    thread _id_25586D738B30AF98(eattacker);

    if(_id_6F1E07CE9FF97D5F::should_get_currency_from_kill(einflictor, eattacker, objweapon)) {
      if(idamage < self.clip.fake_health)
        eattacker _id_3BCAA2CBAF54ABDD::give_player_currency(10, "large");
      else
        eattacker _id_3BCAA2CBAF54ABDD::give_player_currency(100, "large");
    }

    if(self.clip.fake_health <= 0)
      self.health = 1;

    _id_354C862768CFE202::process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, vdir, _id_920FF4456CE9A2FC, undefined, self);
  }
}

_id_C5D04118503D4EA7(idamage) {
  if(self.clip.fake_health <= 0)
    return 1;

  return 0;
}

_id_76B97D7B11066363() {
  if(istrue(level._id_7AE7CCFF11823A4B))
    level._id_7AE7CCFF11823A4B = 0;
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
    if(self.clip.fake_health <= 0 || self.health <= 0) {
      if(istrue(level._id_F753D22AE87B557B) || istrue(self._id_8D8144287647FBC5))
        thread _id_270B6F63D186FB2B();
      else
        thread _id_120810605DF9FC38();
    }

    wait 0.1;
  }
}

_id_94D8111112FFC480() {
  self endon("death");
  self endon("stop_dive_bomb");
  dist = 100;
  _id_ABD9EE4725B96FC2 = dist * dist;

  for(;;) {
    enemy_list = _id_EAC4117ECB82B75E();

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < enemy_list.size; _id_AC0E594AC96AA3A8++) {
      if(isPlayer(enemy_list[_id_AC0E594AC96AA3A8]) && enemy_list[_id_AC0E594AC96AA3A8] _meth_6F55D55CCFF20D14() && !_id_3FF5FA5CFFDD0AA8(enemy_list[_id_AC0E594AC96AA3A8])) {
        continue;
      }
      if(isDefined(level._id_3B24ACB8A1C0031D)) {
        if(gettime() < level._id_3B24ACB8A1C0031D + 250)
          continue;
      }

      if(distancesquared(enemy_list[_id_AC0E594AC96AA3A8].origin, self.origin) < _id_ABD9EE4725B96FC2)
        thread _id_270B6F63D186FB2B();
    }

    wait 0.1;
  }
}

_id_270B6F63D186FB2B() {
  level._id_3B24ACB8A1C0031D = gettime();
  self.exploding = 1;
  self._id_CEFCAFDECC575902 = 1;
  _id_A7481C2414A64A86 = 170;
  _id_1037A3C4089F679B = 400;
  _id_3C27A8DA881BAAB2 = _id_1037A3C4089F679B * _id_1037A3C4089F679B;
  armorhealth = level.players[0]._id_8790C077C95DB752;
  _id_846AEEDA37B2D312 = int(armorhealth * 0.05);
  _id_9FF3DF11D91830E0 = int(armorhealth * 0.125);
  _id_329B0CB4924A42F0 = int(armorhealth * 0.3);

  if(scripts\cp\cp_gameskill::_id_F8448FD91ABB54C8()) {
    _id_846AEEDA37B2D312 = int(armorhealth * 0.2);
    _id_9FF3DF11D91830E0 = int(armorhealth * 0.4);
    _id_329B0CB4924A42F0 = int(armorhealth * 0.65);
  }

  weapon_name = "assault_drone_mp";
  type = "MOD_EXPLOSIVE";
  thread _id_5EAFE20E3889D3A9(_id_3C27A8DA881BAAB2);
  self radiusdamage(self.origin, _id_A7481C2414A64A86, _id_329B0CB4924A42F0, _id_846AEEDA37B2D312, self, type);
  level thread _id_28CB88CB0CCBFFED(self.origin, _id_A7481C2414A64A86);
  level thread _id_F33C56CD33B96D7A(self.origin, _id_A7481C2414A64A86 * 0.2, _id_846AEEDA37B2D312);
  _id_E7A08F629E00C5B7 = self.origin;
  thread _id_120810605DF9FC38();

  if(istrue(level._id_F753D22AE87B557B)) {
    _id_3E3AF5DC3694A80C = level.drone_turrets;
    _id_3E3AF5DC3694A80C = sortbydistance(_id_3E3AF5DC3694A80C, _id_E7A08F629E00C5B7);

    foreach(_id_99B422971992819C in _id_3E3AF5DC3694A80C) {
      if(!isent(_id_99B422971992819C)) {
        continue;
      }
      if(_id_99B422971992819C == self) {
        continue;
      }
      if(istrue(_id_99B422971992819C.exploding)) {
        continue;
      }
      if(distancesquared(_id_E7A08F629E00C5B7, _id_99B422971992819C.origin) > _id_3C27A8DA881BAAB2) {
        continue;
      }
      _id_99B422971992819C thread _id_270B6F63D186FB2B();
      wait 0.2;
    }
  }

  level notify("bomb_drone_explode", _id_E7A08F629E00C5B7, _id_A7481C2414A64A86, _id_846AEEDA37B2D312, _id_329B0CB4924A42F0);
}

_id_5EAFE20E3889D3A9(_id_3C27A8DA881BAAB2) {
  c4 = spawn("script_model", self.origin);
  c4 setModel("tag_origin_drone_explosion_cp");
  c4 setscriptablepartstate("effects", "explodeAir");
  wait 1;
  c4 delete();
}

_id_F33C56CD33B96D7A(origin, radius, damage) {
  players = [];

  if(isDefined(origin) && isDefined(radius))
    players = scripts\cp\utility::getplayersinradius(origin, radius, "allies");

  foreach(player in players) {
    if(isDefined(player) && isPlayer(player) && isDefined(damage) && isDefined(origin))
      player dodamage(damage, origin);
  }
}

_id_28CB88CB0CCBFFED(origin, radius) {
  level endon("game_ended");
  radius = radius + 500;
  players = scripts\cp\utility::give_all_players_nearby(origin, radius * radius);
  wait 3;

  foreach(player in players) {
    if(!isPlayer(player)) {
      continue;
    }
    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(_id_0AFB7E332AEE4BF2::isinlaststand(player)) {
      continue;
    }
    player notify("force_regeneration");
  }
}

_id_120810605DF9FC38() {
  if(istrue(self._id_F679EB037C6F4F7B)) {
    return;
  }
  self._id_F679EB037C6F4F7B = 1;
  explode_fx();

  if(isDefined(self.clip.fake_health) && self.clip.fake_health > 0)
    self.clip dodamage(9999, self.origin, self);

  level.drone_turrets = scripts\engine\utility::array_remove(level.drone_turrets, self);
  level.vehicle_ai_script_models = scripts\engine\utility::array_remove(level.vehicle_ai_script_models, self);
  self._id_DB46C7D01EE9223F.drones = scripts\engine\utility::array_remove(self._id_DB46C7D01EE9223F.drones, self);
  self freeentitysentient();
  _id_3CEAABC5D5A7FFBF = [self.clip, self];
  level thread _id_34A36F44DD3B1EA9(_id_3CEAABC5D5A7FFBF);

  if(isDefined(self.clip)) {
    if(issentient(self.clip))
      self.clip freeentitysentient();

    self.clip notify("death");
    self.clip delete();
  }

  if(isDefined(self.node_grid))
    self.node_grid = undefined;

  _id_34A9757868BB0162 = self;

  if(isDefined(_id_34A9757868BB0162) && isent(_id_34A9757868BB0162)) {
    if(isDefined(_id_34A9757868BB0162))
      _id_34A9757868BB0162 delete();
  }

  waitframe();

  if(isDefined(_id_34A9757868BB0162) && isent(_id_34A9757868BB0162)) {
    _id_34A9757868BB0162 notify("death");
    _id_34A9757868BB0162 delete();
  }
}

explode_fx() {
  playFX(scripts\engine\utility::getfx("drone_turret_explode"), self.origin);
  self playSound("cp_bomb_drone_death");
}

_id_EAC4117ECB82B75E() {
  enemy_list = scripts\cp\utility::get_array_of_valid_players();

  if(self.team == "allies")
    enemy_list = getaiarray("axis");

  if(isDefined(self._id_3589A53AB80793C7))
    enemy_list[enemy_list.size] = self._id_3589A53AB80793C7;

  return enemy_list;
}

_id_1EF2364D60A8AF83(struct, _id_921B9D1AB6394420) {
  level endon("game_ended");
  radius = 800;

  if(isDefined(_id_921B9D1AB6394420))
    radius = _id_921B9D1AB6394420;

  _id_1A96B3062BB2C598 = radius * radius;

  if(!isDefined(struct)) {
    return;
  }
  for(;;) {
    _id_5DAE2C18D8E0E29A = struct scripts\cp\utility::get_closest_living_player(_id_1A96B3062BB2C598);

    if(isDefined(_id_5DAE2C18D8E0E29A)) {
      level._id_8D1CB2F62CE55C8A = _id_5DAE2C18D8E0E29A;
      wait(randomfloatrange(3, 6));
    } else
      level._id_8D1CB2F62CE55C8A = undefined;

    wait 0.5;
  }
}

_id_09766CDB112671D7(targetname) {
  level._id_A7B6C38E3EB32646 = [];
  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray(targetname, "targetname");

  foreach(struct in _id_9E4E1482CB40C9C5) {
    height = scripts\engine\utility::ter_op(isDefined(struct.height), struct.height, "500");
    trigger = spawn("trigger_radius", struct.origin, 0, int(struct.radius), int(height));

    if(isDefined(struct.angles) && struct.angles != (0, 0, 0))
      trigger.angles = (-90, 0, 0) + struct.angles;

    if(!isDefined(trigger.height))
      trigger.height = int(height);

    if(!isDefined(trigger.radius))
      trigger.radius = int(struct.radius);

    trigger thread _id_D1965300901B62B7();
    level._id_A7B6C38E3EB32646 = scripts\engine\utility::array_add(level._id_A7B6C38E3EB32646, trigger);
  }
}

_id_D1965300901B62B7() {
  self endon("death");
  radius = squared(self.radius);

  for(;;) {
    wait 1;

    if(!isDefined(level.drone_turrets)) {
      continue;
    }
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.drone_turrets.size; _id_AC0E594AC96AA3A8++) {
      drone = level.drone_turrets[_id_AC0E594AC96AA3A8];

      if(!isDefined(drone) || !isent(drone)) {
        continue;
      }
      if(!isDefined(drone._id_5761CB62BD849019)) {
        continue;
      }
      if(isDefined(drone.clip) && drone.clip.fake_health <= 0) {
        continue;
      }
      if(distance2dsquared(drone.origin, self.origin) < radius)
        drone thread _id_120810605DF9FC38();
    }
  }
}

_id_18871F933340B91B(_id_8D20A2CD0457E5B1) {
  if(!isDefined(level.drone_turrets)) {
    return;
  }
  _id_F00F10160EACB571 = level.drone_turrets;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F00F10160EACB571.size; _id_AC0E594AC96AA3A8++) {
    drone = _id_F00F10160EACB571[_id_AC0E594AC96AA3A8];

    if(!isDefined(drone) || !isent(drone)) {
      continue;
    }
    if(!isDefined(drone._id_5761CB62BD849019)) {
      continue;
    }
    if(isDefined(drone.clip) && drone.clip.fake_health <= 0) {
      continue;
    }
    if(isDefined(_id_8D20A2CD0457E5B1)) {
      _id_5C266234F3E3AD4E = 0;

      foreach(player in level.players) {
        if(distance(drone.origin, player.origin) < _id_8D20A2CD0457E5B1)
          _id_5C266234F3E3AD4E = 1;
      }

      if(_id_5C266234F3E3AD4E)
        continue;
    }

    drone thread _id_120810605DF9FC38();
  }
}

_id_53747F8CE3D99087() {
  self endon("death");
  _id_A395B21F16F97CCF = 0;

  for(;;) {
    if(isDefined(self._id_8534D2048FA254A3) && self.origin == self._id_8534D2048FA254A3)
      _id_A395B21F16F97CCF = _id_A395B21F16F97CCF + 1;

    self._id_8534D2048FA254A3 = self.origin;

    if(_id_A395B21F16F97CCF == 2) {
      if(isDefined(self.current_node)) {
        if(isDefined(self.current_node.target)) {
          _id_E0D9D2880C046704 = scripts\engine\utility::getStruct(self.current_node.target, "targetname");

          if(isDefined(_id_E0D9D2880C046704) && isDefined(_id_E0D9D2880C046704.open) && _id_E0D9D2880C046704.open == 0)
            _id_E0D9D2880C046704.open = 1;
        }
      }

      self._id_47C08DE6597328AA = 1;
    }

    if(_id_A395B21F16F97CCF > 6)
      thread _id_120810605DF9FC38();

    wait 2.5;
  }
}

_id_D222480796864019() {
  self endon("death");

  while(istrue(level._id_7AE7CCFF11823A4B))
    wait 1;

  _id_A395B21F16F97CCF = 0;

  for(;;) {
    if(isDefined(self._id_A0790D172D45F316) && isDefined(self.current_node) && isDefined(self.current_node.origin) && self.current_node.origin == self._id_A0790D172D45F316)
      _id_A395B21F16F97CCF = _id_A395B21F16F97CCF + 1;

    if(isDefined(self.current_node) && isDefined(self.current_node.origin))
      self._id_A0790D172D45F316 = self.current_node.origin;

    if(!isDefined(self.current_node)) {
      if(isDefined(self.node_grid)) {
        _id_9BDE6CEB27BC4985 = scripts\engine\utility::getclosest(self.origin, self.node_grid);
        self.current_node = _id_9BDE6CEB27BC4985;
      }
    }

    if(_id_A395B21F16F97CCF > 12)
      thread _id_120810605DF9FC38();

    wait 2.5;
  }
}

_id_8EBDE019036D5C6D() {
  for(;;) {
    wait 1;

    if(isDefined(level.drone_turrets) && level.drone_turrets.size > 0) {
      _id_0119C222BA451841 = 0;

      if(isDefined(level._id_EF94125F71754B2F)) {
        foreach(group in level._id_EF94125F71754B2F) {
          if(group.drones.size == 0)
            _id_0119C222BA451841++;
        }

        if(_id_0119C222BA451841 == level._id_EF94125F71754B2F.size) {
          foreach(drone in level.drone_turrets)
          drone.clip dodamage(9999, drone.origin, level);

          wait 10;
        }
      }
    }
  }
}