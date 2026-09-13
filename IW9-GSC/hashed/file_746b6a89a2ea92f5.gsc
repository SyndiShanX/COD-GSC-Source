/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_746b6a89a2ea92f5.gsc
***********************************************/

init() {
  level._effect["drone_turret_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_drone_lrg_dest_exp.vfx");
  level._effect["drone_grenade_light_danger"] = loadfx("vfx/iw8_cp/raid/vfx_raid_wheelson_flashlight_npc.vfx");

  if(!isDefined(level.drone_turrets))
    level.drone_turrets = [];

  _id_DA97C93516A3D411();
}

_id_DA97C93516A3D411() {
  if(!isDefined(level._id_44E7AA9CA256A799))
    level._id_44E7AA9CA256A799 = [];

  level._id_44E7AA9CA256A799["flash_grenade_mp"] = spawnStruct();
  level._id_44E7AA9CA256A799["flash_grenade_mp"].cooldown = 12.5;
  level._id_44E7AA9CA256A799["flash_grenade_mp"]._id_29111195D194B22A = 0;
  level._id_44E7AA9CA256A799["flash_grenade_mp"].waittime = 2.5;
  level._id_44E7AA9CA256A799["frag_grenade_mp"] = spawnStruct();
  level._id_44E7AA9CA256A799["frag_grenade_mp"].cooldown = 6;
  level._id_44E7AA9CA256A799["frag_grenade_mp"]._id_29111195D194B22A = 2;
  level._id_44E7AA9CA256A799["frag_grenade_mp"].waittime = 0;
}

_id_AE2FF42BCA6D6DCC(spawnpoint) {
  startpos = spawnpoint.origin;
  startang = spawnpoint.angles;
  vehicleinfo = "veh_radar_drone_recon_mp";
  _id_B923287498A8519A = "veh8_mil_air_tuniform_c4_ai";
  drone = spawnVehicle(_id_B923287498A8519A, "drone_turret", vehicleinfo, startpos, startang);
  drone.team = "axis";
  drone.spawnpoint = spawnpoint;
  drone.spawntime = gettime();
  drone.type = "flash_grenade_mp";

  if(isDefined(drone.spawnpoint) && isDefined(drone.spawnpoint.script_parameters))
    drone.type = "" + drone.spawnpoint.script_parameters;

  _id_E8E1535DA20CE9DF = getEnt("malfa_clip", "targetname");

  if(isDefined(_id_E8E1535DA20CE9DF)) {
    drone.clip = spawn("script_model", _id_E8E1535DA20CE9DF.origin);
    drone.clip.angles = _id_E8E1535DA20CE9DF.angles;
    drone.clip clonebrushmodeltoscriptmodel(_id_E8E1535DA20CE9DF);
    drone.clip.origin = drone.origin;
    drone.clip.angles = drone.angles;
    drone.clip linkTo(drone, "j_body", (0, 0, 0), (0, 0, 0));
    drone.clip enableaimassist();
    drone.clip setCanDamage(1);
    drone.clip makeentitysentient(drone.team, 1, 1);
    drone.clip._id_D1F953C063DFF1EB = 1;
    drone thread damage_feedback_watch();
    drone thread watch_for_death();
  }

  drone thread _id_4B61E2E97BA71335();
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

_id_4B61E2E97BA71335() {
  self endon("death");
  _id_C5013BF3DEBFE892 = _id_BEC91DF897D1A193();
  _id_C8A50F99D108E589(_id_C5013BF3DEBFE892);
}

_id_BEC91DF897D1A193() {
  struct = self.spawnpoint;

  if(!isDefined(struct.target))
    return undefined;

  for(;;) {
    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "drone_grenade_line")
      return struct;

    if(isDefined(struct.target)) {
      _id_CED0426E7E729ED5 = scripts\engine\utility::getStruct(struct.target, "targetname");
      thread move_to_new_node(_id_CED0426E7E729ED5, (0, 0, 0), 25);

      while(distance(self.origin, _id_CED0426E7E729ED5.origin) > 16)
        wait 0.1;

      struct = _id_CED0426E7E729ED5;
      continue;
    }

    return undefined;
  }
}

_id_C8A50F99D108E589(_id_C5013BF3DEBFE892) {
  childthread _id_572D3C6762B74DAB();
  _id_E14463F4B51550A1 = 0;

  if(isDefined(_id_C5013BF3DEBFE892) && isDefined(_id_C5013BF3DEBFE892.radius))
    _id_E14463F4B51550A1 = int(_id_C5013BF3DEBFE892.radius);

  if(!isDefined(_id_C5013BF3DEBFE892.target)) {
    return;
  }
  _id_9F656D408FE35B51 = scripts\engine\utility::getStruct(_id_C5013BF3DEBFE892.target, "targetname");

  for(;;) {
    _id_CF6B8D2D0EF1ACAF = _id_B4C76B9635F7C3F0(4194304);

    if(!isDefined(_id_CF6B8D2D0EF1ACAF)) {
      wait 3;
      continue;
    }

    _id_556B31282ABCB132 = distance2d(_id_CF6B8D2D0EF1ACAF.origin, self.origin);

    if(isDefined(_id_CF6B8D2D0EF1ACAF) && _id_556B31282ABCB132 > 64) {
      _id_CED0426E7E729ED5 = spawnStruct();
      _id_CED0426E7E729ED5.origin = pointonsegmentnearesttopoint(_id_C5013BF3DEBFE892.origin, _id_9F656D408FE35B51.origin, _id_CF6B8D2D0EF1ACAF.origin);

      if(_id_E14463F4B51550A1 > 0) {
        _id_81127E016B847FDD = _id_CF6B8D2D0EF1ACAF.origin - _id_CED0426E7E729ED5.origin;
        _id_904BA70F73808CB7 = _func_767CEA82B001F645(_id_81127E016B847FDD);
        _id_D70ED963B89051FD = length2d(_id_81127E016B847FDD);
        _id_81127E016B847FDD = scripts\engine\utility::ter_op(_id_D70ED963B89051FD > _id_E14463F4B51550A1, _id_904BA70F73808CB7 * _id_E14463F4B51550A1, _id_904BA70F73808CB7 * _id_81127E016B847FDD);
        _id_CED0426E7E729ED5.origin = _id_CED0426E7E729ED5.origin + _id_81127E016B847FDD;
      }

      if(distance2d(self.origin, _id_CED0426E7E729ED5.origin) > 25)
        thread move_to_new_node(_id_CED0426E7E729ED5, (0, 0, 0), 25);

      while(distance(self.origin, _id_CED0426E7E729ED5.origin) > 12)
        wait 0.1;
    }

    wait 0.5;
  }
}

_id_572D3C6762B74DAB() {
  for(;;) {
    _id_CF6B8D2D0EF1ACAF = _id_B4C76B9635F7C3F0(147456);

    if(isDefined(_id_CF6B8D2D0EF1ACAF) && _id_E9E1BA41686EFA8E())
      childthread drop_grenade(_id_CF6B8D2D0EF1ACAF);

    wait 0.1;
  }
}

_id_B4C76B9635F7C3F0(_id_45E808DC306D0926) {
  _id_07296729673615C7 = 1073741824;

  if(isDefined(_id_45E808DC306D0926))
    _id_07296729673615C7 = _id_45E808DC306D0926;

  _id_C729D49D406ACED8 = undefined;

  foreach(player in level.players) {
    if(isDefined(level.ignoredbycheck) && [[level.ignoredbycheck]](self, player)) {
      continue;
    }
    if(_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      continue;
    }
    if(player.origin[2] > self.origin[2] - 25) {
      continue;
    }
    _id_A9B6B677F6D0A010 = distance2dsquared(self.origin, player.origin);

    if(player scripts\cp_mp\utility\player_utility::_isalive() && _id_A9B6B677F6D0A010 < _id_07296729673615C7) {
      _id_C729D49D406ACED8 = player;
      _id_07296729673615C7 = _id_A9B6B677F6D0A010;
    }
  }

  return _id_C729D49D406ACED8;
}

_id_E9E1BA41686EFA8E() {
  if(!isDefined(self._id_287EFB93CFFFBDBD))
    return 1;

  _id_B344F40B2915564A = 7.5;

  if(isDefined(level._id_44E7AA9CA256A799[self.type]))
    _id_B344F40B2915564A = level._id_44E7AA9CA256A799[self.type].cooldown;

  if(gettime() - self._id_287EFB93CFFFBDBD > _id_B344F40B2915564A * 1000)
    return 1;

  return 0;
}

drop_grenade(_id_CF6B8D2D0EF1ACAF) {
  self._id_287EFB93CFFFBDBD = gettime();
  velocity = (0, 0, -10);
  _id_DF8E0358F6E2B842 = distance(self.origin, _id_CF6B8D2D0EF1ACAF.origin);
  _id_18041D0638A909B7 = _id_DF8E0358F6E2B842 / 800 + 0.25;
  _id_29111195D194B22A = 0;
  waittime = 0;
  _id_2FF28DA0A9FF8959 = vectortoangles(_id_CF6B8D2D0EF1ACAF.origin - self.origin);
  self setgoalyaw(_id_2FF28DA0A9FF8959[1]);
  self setyawspeed(400, 300, 270, 0.3);

  if(isDefined(level._id_44E7AA9CA256A799[self.type])) {
    _id_29111195D194B22A = level._id_44E7AA9CA256A799[self.type]._id_29111195D194B22A;
    waittime = level._id_44E7AA9CA256A799[self.type].waittime;
  }

  if(_id_29111195D194B22A > 0)
    _id_18041D0638A909B7 = _id_18041D0638A909B7 + _id_29111195D194B22A;

  if(waittime > 0)
    wait(waittime);

  _id_33071C5CA19FBB3F = magicgrenademanual(self.type, self.origin - (0, 0, 2), velocity, _id_18041D0638A909B7);
  thread _id_241A6F854E3AF34D();
  wait(_id_18041D0638A909B7);

  if(self.type == "flash_grenade_mp") {
    foreach(player in level.players) {
      if(distance(player getEye(), _id_33071C5CA19FBB3F.origin) < 500)
        result = _id_74502A9E0EF1F19C::applyflashfromdamage(player, self, _id_33071C5CA19FBB3F.origin, 0);
    }
  }
}

_id_241A6F854E3AF34D() {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(self._id_4E3EA138AA2442FD))
    self._id_4E3EA138AA2442FD = "tag_camera_fx";

  playFXOnTag(level._effect["drone_grenade_light_danger"], self, self._id_4E3EA138AA2442FD);
  wait 5;
  stopFXOnTag(level._effect["drone_grenade_light_danger"], self, self._id_4E3EA138AA2442FD);
}

move_to_new_node(node, offset, speed_override) {
  self endon("death");
  self notify("move_to_new_node");
  self endon("move_to_new_node");

  if(!isDefined(offset))
    offset = (0, 0, 0);

  dist = distance(self.origin, node.origin);

  if(!isDefined(node.angles))
    node.angles = (0, 0, 0);

  if(dist > 1) {
    self.next_node = node;
    speed = 10;

    if(isDefined(speed_override))
      speed = speed_override;

    self.move_speed = speed;
    self vehicle_setspeed(speed, speed * 0.65, speed * 0.95);
    _id_2FF28DA0A9FF8959 = vectortoangles(node.origin - self.origin);
    self setgoalyaw(_id_2FF28DA0A9FF8959[1]);
    self setyawspeed(400, 300, 270, 0.3);
    thread _id_D677741135245C73(node, offset);
    scripts\engine\utility::waittill_any_timeout_2(15, "near_goal", "stop_tracking");
    self notify("stop_tracking");
    self.next_node = undefined;
    self.current_node = node;
    self.move_speed = 0;
    self vehicle_setspeed(1, 120, 120);
  } else
    wait 0.1;
}

_id_D677741135245C73(node, offset) {
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
  self setvehgoalpos(pos + offset, 0);
  self setneargoalnotifydist(32);
}

damage_feedback_watch() {
  self endon("death");
  level endon("game_ended");
  self setCanDamage(0);
  self.health = 100000;
  self.clip setCanDamage(1);
  self.clip.health = 100000;
  self.clip.fake_health = 50;
  self._id_689D46E1E37CC5AD = ::_id_C5D04118503D4EA7;

  for(;;) {
    self.clip waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, _id_9E834FE6754A9C98, _id_1D3F20A69CED2DD5, _id_920FF4456CE9A2FC, idflags, objweapon, origin, angles, normal, einflictor, eventid);
    self.clip.fake_health = self.clip.fake_health - idamage;
    self.clip.health = 100000;

    if(!isDefined(eattacker) || !isPlayer(eattacker) && (!isDefined(eattacker.owner) || !isPlayer(eattacker.owner))) {
      continue;
    }
    if(isDefined(self.mgturret))
      self notify("pause_move");
    else if(isDefined(self._id_13388E6E14BBFB33))
      self._id_13388E6E14BBFB33 notify("pause_move");

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

_id_25586D738B30AF98(eattacker) {
  self notify("new_damage");
  self endon("new_damage");
  self.last_damaged_by = eattacker;
  self.last_damaged_time = gettime();
  wait 5;
  self.last_damaged_by = undefined;
  self.last_damaged_time = undefined;
}

_id_C5D04118503D4EA7(idamage) {
  if(self.clip.fake_health <= 0)
    return 1;

  return 0;
}

watch_for_death() {
  self endon("death");

  for(;;) {
    if(self.clip.fake_health <= 0 || self.health <= 0)
      thread _id_120810605DF9FC38();

    wait 0.1;
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
  self freeentitysentient();
  _id_3CEAABC5D5A7FFBF = [self.clip, self];

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

_id_8D5E27863A5831E9(_id_8D20A2CD0457E5B1) {
  if(!isDefined(level.drone_turrets)) {
    return;
  }
  _id_F00F10160EACB571 = level.drone_turrets;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F00F10160EACB571.size; _id_AC0E594AC96AA3A8++) {
    drone = _id_F00F10160EACB571[_id_AC0E594AC96AA3A8];

    if(!isDefined(drone) || !isent(drone)) {
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