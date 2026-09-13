/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\combat.gsc
***********************************************/

soldier_init_common() {
  _id_010B6724C15A95E8::_id_136FB87AD4393EF8();
  self._id_0D318C0ABAF5B25E = 0;
  self _meth_8BBCAEB23A1512EF("all", 1, "bt");
}

_id_33EF051AFBF024E2(guy) {
  points = [];
  forward = anglesToForward(self.angles);
  left = anglestoleft(self.angles);
  up = anglestoup(self.angles);
  _id_D11BF1A777808CCF = 0;
  _id_CF861AF60EF5E2EC = guy getlinkedparent();
  _id_D11BF1A777808CCF = length(_id_CF861AF60EF5E2EC vehicle_getvelocity());
  _id_39C92FF067275632 = anglesToForward(_id_CF861AF60EF5E2EC.angles);
  _id_AE8C9C005807883C = self vehicle_getvelocity();
  _id_1FE3B79CF50144B6 = length(_id_AE8C9C005807883C);
  _id_59C6B9D8325F6109 = vectordot(forward, _id_AE8C9C005807883C) < 0;

  if(_id_59C6B9D8325F6109)
    _id_1FE3B79CF50144B6 = _id_1FE3B79CF50144B6 * -1;

  _id_E1D42175C57E7465 = [];
  _id_E1D42175C57E7465[0] = (-50, 0, -10);

  foreach(_id_45D7C8963B34D98E in _id_E1D42175C57E7465) {
    _id_90B08876A946FDF5 = forward * _id_45D7C8963B34D98E[0];
    _id_F6AA960EFF3521CB = left * _id_45D7C8963B34D98E[1];
    _id_2CF4A7DBEF8201F3 = up * _id_45D7C8963B34D98E[2];
    point = self.origin + _id_90B08876A946FDF5 + _id_F6AA960EFF3521CB + _id_2CF4A7DBEF8201F3;
    points[points.size] = point;
  }

  return points;
}

_id_F7D7F5A416BA048F(taskid) {
  if(!getdvarint("dvar_18F07C17515921EA"))
    return anim.failure;

  if(!istrue(self._id_A4EC4541434CA606))
    return anim.failure;

  vehicle = self._blackboard.currentvehicle;

  if(gettime() < 5000)
    return anim.failure;

  if(!isDefined(level.player.veh))
    return anim.failure;

  player_vehicle = level.player.veh;

  if(isDefined(player_vehicle._id_B0C6C07E072EAADE))
    return anim.failure;

  if(!isDefined(level._id_E9C7F2AE8AF2293B))
    level._id_E9C7F2AE8AF2293B = 0;

  if(gettime() < level._id_E9C7F2AE8AF2293B)
    return anim.failure;

  if(istrue(self._id_58E8388F04ABB64E))
    return anim.failure;

  _id_71E1DFCB6998D10C = self._blackboard.currentvehicleanimalias;
  _id_84CACB9685561983 = scripts\engine\utility::string(self._blackboard._id_9176CAE5619D7FBA);
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_71E1DFCB6998D10C, "vehicle_jumper_jump", _id_84CACB9685561983, scripts\asm\asm::asm_isfrantic());

  if(!isDefined(_id_0EABF81B5BE8DDB5))
    return anim.failure;

  _id_52FC5266DCE0C05B = player_vehicle.vehicleanimalias;
  _id_90549D1E920415D4 = scripts\engine\utility::string(2);
  _id_0EABF81B5BE8DDB5 = archetypegetrandomalias(_id_52FC5266DCE0C05B, "vehicle_jumper_get_up", _id_90549D1E920415D4, scripts\asm\asm::asm_isfrantic());

  if(!isDefined(_id_0EABF81B5BE8DDB5))
    return anim.failure;

  if(!isalive(player_vehicle))
    return anim.failure;

  if(distancesquared(player_vehicle.origin, vehicle.origin) > 40000)
    return anim.failure;

  if(self.vehicle_position == 0) {
    _id_3C883BB046CCBAE8 = vehicle.riders.size == 1 || vehicle.health < 25;

    if(!_id_3C883BB046CCBAE8)
      return anim.failure;
  }

  _id_CBF88131408C3AED = istrue(self._blackboard._id_6A69FA6B0B354C93) && istrue(self.canshootinvehicle);
  _id_501E62DDDF768FC8 = vectortoangles(player_vehicle.origin - self.origin);
  _id_BE2F619C49B49AE3 = angleclamp(_id_501E62DDDF768FC8[1]);
  _id_67177E1CF8A6C99F = angleclamp(self.angles[1]);
  angle_diff = angleclamp180(_id_BE2F619C49B49AE3 - _id_67177E1CF8A6C99F);

  if(_id_CBF88131408C3AED && abs(angle_diff) > 45)
    return anim.failure;

  if(!self islinked())
    return anim.failure;

  _id_F76E63791A19D879 = spawnStruct();
  _id_F76E63791A19D879.vehicle = player_vehicle;
  _id_F76E63791A19D879._id_A6DE8EC9BA768684 = vehicle;
  points = player_vehicle _id_33EF051AFBF024E2(self);
  _id_195256E3FCC08D9A = 99999999;

  foreach(index, point in points) {
    _id_C5675AFFB3E31D81 = distancesquared(point, self.origin);

    if(_id_C5675AFFB3E31D81 <= 57600) {
      _id_F76E63791A19D879.index = index;
      _id_F76E63791A19D879.point = point;
      _id_195256E3FCC08D9A = _id_C5675AFFB3E31D81;
      break;
    }
  }

  if(!isDefined(_id_F76E63791A19D879.point))
    return anim.failure;

  foreach(rider in vehicle.riders) {
    if(self != rider) {
      _id_4F75BE2D248978D3 = vehicle.health < 25;

      if(rider.vehicle_position != 0 || _id_4F75BE2D248978D3) {
        if(distancesquared(_id_F76E63791A19D879.point, rider.origin) < _id_195256E3FCC08D9A)
          return anim.failure;
      }
    }
  }

  _id_23D3AC64C943C87F = angleclamp180(player_vehicle.angles[1]);
  angles = vectortoangles(self.origin - _id_F76E63791A19D879.point);
  yaw = angleclamp180(angles[1]);
  _id_7B6ABE1895867F3E = angleclamp180(yaw - _id_23D3AC64C943C87F);

  if(_id_7B6ABE1895867F3E < 82.0 && _id_7B6ABE1895867F3E > -82.0 || _id_7B6ABE1895867F3E > 98.0 || _id_7B6ABE1895867F3E < -98.0)
    return anim.failure;

  self._id_F76E63791A19D879 = _id_F76E63791A19D879;
  player_vehicle._id_B0C6C07E072EAADE = self;
  level._id_E9C7F2AE8AF2293B = gettime() + 20000;
  _id_010B6724C15A95E8::_id_C434AF0895CC147C("vehicle_jumper", player_vehicle.vehicleanimalias);
  vehicle.riders = scripts\engine\utility::array_remove(vehicle.riders, self);
  return anim.success;
}

_id_A38AD5564FCAFC54(taskid) {
  vehicle = self._blackboard.currentvehicle;

  if(!isDefined(vehicle))
    return anim.failure;

  pos = self._blackboard._id_9176CAE5619D7FBA;
  aianims = scripts\common\vehicle_aianim::anim_pos(vehicle, pos);

  if(!istrue(aianims._id_0A06D61EB83F02F4))
    return anim.failure;

  return anim.success;
}

updateeveryframe_noncombat(taskid) {
  scripts\asm\asm_bb::bb_requestweapon(weaponclass(self.primaryweapon));
  whizbyevent = scripts\asm\asm::asm_getephemeraleventdata("ai_notify", "bulletwhizby");

  if(isDefined(whizbyevent)) {
    if(!self.disablebulletwhizbyreaction) {
      _id_34A49A1027E86AC0 = whizbyevent[0];
      _id_AF242C2D23F38691 = isDefined(_id_34A49A1027E86AC0) && distancesquared(self.origin, _id_34A49A1027E86AC0.origin) < 160000;

      if(_id_AF242C2D23F38691 || scripts\engine\utility::cointoss())
        self._blackboard._id_9F7C458052D2C805 = gettime() - 50;
    }
  } else {
    _id_4B4ADF39CFE6C5AF = 100;

    if(isDefined(self._blackboard._id_9F7C458052D2C805) && gettime() > self._blackboard._id_9F7C458052D2C805 + _id_4B4ADF39CFE6C5AF)
      self._blackboard._id_9F7C458052D2C805 = undefined;
  }

  self.looktarget = undefined;
  return anim.success;
}

shouldbefrantic() {
  if(isDefined(self.frantic))
    return self.frantic;

  return 0;
}

hasammoinclip() {
  turret = getusedturret();

  if(isDefined(turret))
    return 1;

  if(!isDefined(self.weapon))
    return 0;

  if(self.bulletsinclip > 0 || istrue(self.disablereload))
    return 1;

  return 0;
}

islowonammo(_id_B8EBE3F71A08AB40, params) {
  if(_id_2B79931B08683E0A::needtoreload(params))
    return anim.success;

  return anim.failure;
}

withindistancetoenemy(_id_B8EBE3F71A08AB40, params) {
  if(!isDefined(self.enemy))
    return anim.failure;

  if(distancesquared(self.origin, self.enemy.origin) <= params * params)
    return anim.success;

  return anim.failure;
}

mayshoot(_id_B8EBE3F71A08AB40) {
  if(!isDefined(self.weapon))
    return anim.failure;

  _id_9578A7ED2D4E36ED = shouldshoot();

  if(_id_9578A7ED2D4E36ED)
    _id_9578A7ED2D4E36ED = calcgoodshootpos();
  else
    self.goodshootpos = undefined;

  if(!_id_9578A7ED2D4E36ED)
    return anim.failure;

  return anim.success;
}

updatelooktarget(taskid) {
  if(!isDefined(self.looktarget) || self.looktarget != self.enemy)
    self.looktarget = self.enemy;

  return anim.success;
}

shoot_clearconvergence() {
  self._blackboard.shootparams_bconvergeontarget = 0;
}

shoot_enableconvergence() {
  self._blackboard.shootparams_bconvergeontarget = 1;
}

isaimedataimtarget() {
  return isDefined(self._id_A709FBD9FEA148F6) && self _meth_6DD13D05C4F4330E();
}

hasatleastammo(threshold) {
  if(isnullweapon(self.weapon))
    return 0;

  return self.bulletsinclip >= weaponclipsize(self.weapon) * threshold;
}

reload_cheatammo() {
  clipsize = weaponclipsize(self.weapon);
  self.bulletsinclip = int(clipsize * 0.5);
  self.bulletsinclip = int(clamp(self.bulletsinclip, 0, clipsize));
}

chooseshootstyle() {
  _id_5E2B1CC3ABA6D0EC = 62500;
  _id_FA7A428482EFE086 = 810000;
  _id_5646233813D9B9E6 = 2560000;
  _id_0DD6BF5F9DBA888C = weaponclass(self.weapon);
  turret = getusedturret();
  usingturret = isDefined(turret);

  if(isDefined(self.shootstyleoverride)) {
    fastburst = 0;

    if(isDefined(self.bt.shootstylefastburst))
      fastburst = self.bt.shootstylefastburst;

    return setshootstyle(self.shootstyleoverride, fastburst);
  }

  if(_id_0DD6BF5F9DBA888C == "mg" || usingturret)
    return setshootstyle("mg", 0);

  if(isDefined(self._blackboard.shootparams_ent) && isDefined(self._blackboard.shootparams_ent.enemy) && isDefined(self._blackboard.shootparams_ent.enemy.syncedmeleetarget))
    return setshootstyle("single", 0);

  if(self _meth_E8CA4080D02A0BB4())
    return setshootstyle("single", 0);

  if(_id_0DD6BF5F9DBA888C == "rocketlauncher" || _id_0DD6BF5F9DBA888C == "pistol")
    return setshootstyle("single", 0);

  if(_id_2B79931B08683E0A::isshotgun(self.weapon)) {
    if(_id_2B79931B08683E0A::weapon_pump_action_shotgun())
      return setshootstyle("single", 0);
    else
      return setshootstyle("semi", 0);
  }

  if(_id_0DD6BF5F9DBA888C == "grenade")
    return setshootstyle("single", 0);

  if(weaponburstcount(self.weapon) > 0)
    return setshootstyle("burst", 0);

  _id_4EB801042B324702 = distancesquared(self getshootatpos(), self._blackboard.shootparams_pos);

  if(_id_4EB801042B324702 < _id_5E2B1CC3ABA6D0EC) {
    if(isDefined(self._blackboard.shootparams_ent) && isDefined(self._blackboard.shootparams_ent.magic_bullet_shield))
      return setshootstyle("single", 0);
    else
      return setshootstyle("full", 0);
  } else if(_id_4EB801042B324702 < _id_FA7A428482EFE086 || shouldbeajerk()) {
    if(weaponissemiauto(self.weapon) || shoulddosemiforvariety(_id_4EB801042B324702))
      return setshootstyle("semi", 1);
    else
      return setshootstyle("burst", 1);
  } else if(self.providecoveringfire || _id_4EB801042B324702 < _id_5646233813D9B9E6) {
    if(shoulddosemiforvariety(_id_4EB801042B324702))
      return setshootstyle("semi", 0);
    else
      return setshootstyle("burst", 0);
  } else if(shoulddosemiforvariety(_id_4EB801042B324702))
    return setshootstyle("semi", 0);
  else
    return setshootstyle("single", 0);
}

setshootstyle(shootstyle, fastburst) {
  self._blackboard.shootparams_style = shootstyle;
  self._blackboard.shootparams_fastburst = fastburst;
}

shouldbeajerk() {
  if(!isDefined(level.gameskill))
    return 0;

  return level.gameskill == 3 && isPlayer(self.enemy);
}

shoulddosemiforvariety(_id_4EB801042B324702) {
  _id_DC061F521C45D732 = randomfloat(1);
  _id_824F089B7C5F24BE = shoulddosemiprobabilityline(_id_4EB801042B324702);
  return _id_DC061F521C45D732 <= _id_824F089B7C5F24BE;
}

shoulddosemiprobabilityline(_id_D58E3CC99EDAEF16) {
  if(_id_D58E3CC99EDAEF16 < 2560000.0)
    return -1;

  return -0.0000000465839 * _id_D58E3CC99EDAEF16 - -0.119255 + 0.5;
}

getusedturret() {
  if(isDefined(self.fngetusedturret))
    return [[self.fngetusedturret]]();
}

shouldshoot() {
  if(!self _meth_ 66 A38A800F4FF4F())
    return 0;

  if(istrue(self._blackboard.partialgestureplaying))
    return 0;

  if(self _meth_53FB16FCB6043BBC())
    return 0;

  return 1;
}

calcgoodshootpos() {
  if(self cansee(self.enemy)) {
    if(self canshootenemy()) {
      self.goodshootpos = self.enemy getshootatpos();
      return 1;
    }
  }

  _id_9578A7ED2D4E36ED = _id_2B79931B08683E0A::cansuppressenemy();
  return _id_9578A7ED2D4E36ED;
}

isenemyinlowcover(taskid) {
  if(!isDefined(self.enemy) || !issentient(self.enemy))
    return anim.failure;

  if(self._id_A97AC004F00C5DF9)
    return anim.failure;

  if(!isDefined(self.enemy.lowcovervolume))
    return anim.failure;

  if(!istrue(self.enemy.underlowcover))
    return anim.failure;

  if(istrue(self._id_3DB4FA492BDD5986))
    return anim.failure;

  lastknownpos = self lastknownpos(self.enemy);
  _id_9BC7ED05EA9A9090 = 0;

  if(istrue(self.aggressivelowcovermode)) {
    _id_FC22138908AF2B15 = distancesquared(self.origin, lastknownpos);
    _id_95FBB30C0D7A739D = 3600;

    if(isDefined(self._id_C46E0DF7E4FC8D94) && self._id_C46E0DF7E4FC8D94 > 0)
      _id_95FBB30C0D7A739D = self._id_C46E0DF7E4FC8D94 * self._id_C46E0DF7E4FC8D94;

    if(_id_FC22138908AF2B15 < _id_95FBB30C0D7A739D)
      _id_9BC7ED05EA9A9090 = 1;
    else if(distancesquared(self.origin, self.enemy.origin) < _id_95FBB30C0D7A739D)
      _id_9BC7ED05EA9A9090 = 1;
  }

  if(!_id_9BC7ED05EA9A9090) {
    lastknowntime = self lastknowntime(self.enemy);

    if(lastknowntime <= gettime() - 5000)
      return anim.failure;

    if(!ispointinvolume(lastknownpos, self.enemy.lowcovervolume))
      return anim.failure;
  }

  _id_4EDA5E21D64652A1 = self.enemy.lowcovervolume scripts\engine\utility::get_linked_nodes();

  if(_id_4EDA5E21D64652A1.size == 0)
    return anim.failure;

  _id_4EDA5E21D64652A1 = sortbydistance(_id_4EDA5E21D64652A1, lastknownpos);

  foreach(node in _id_4EDA5E21D64652A1) {
    if(isDefined(getnodeowner(node)) && getnodeowner(node) != self) {
      continue;
    }
    self setbtgoalnode(1, node);
    self setbtgoalRadius(1, 12);
    return anim.success;
  }

  return anim.failure;
}

valid_reaction_sound(npcid) {
  switch (npcid) {
    case "w2":
    case "w1":
    case "w0":
    case "omr":
    case "slt":
    case "5":
    case "4":
    case "3":
    case "2":
    case "0":
    case "1":
      return 1;
  }

  return 0;
}

turretrequested(_id_B8EBE3F71A08AB40) {
  if(isDefined(scripts\asm\asm_bb::bb_getrequestedturret()))
    return anim.success;

  return anim.failure;
}

ifshoulddosmartobject(taskid) {
  _id_6C66DE307018DFE3 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(!isDefined(_id_6C66DE307018DFE3))
    return anim.failure;

  if(isDefined(self.disablesmartobjects))
    return anim.failure;

  _id_121017411B87DACE = self.origin[2] - _id_6C66DE307018DFE3.origin[2];

  if(_id_121017411B87DACE * _id_121017411B87DACE > 5184)
    return anim.failure;

  if(distance2dsquared(self.origin, _id_6C66DE307018DFE3.origin) > 225)
    return anim.failure;

  return anim.success;
}

dosmartobject_init(taskid) {
  scripts\asm\asm_bb::bb_requestplaysmartobject();

  if(isDefined(self._id_0A41EDF45BB0FF97))
    self._id_0A41EDF45BB0FF97 = undefined;

  self.bt.instancedata[taskid] = self.disableautolookat;
  self.disableautolookat = 1;
}

dosmartobject(taskid) {
  if(self asmephemeraleventfired("smartobject", "finished")) {
    _id_6C66DE307018DFE3 = scripts\asm\asm_bb::bb_getrequestedsmartobject();
    _id_6C66DE307018DFE3 scripts\smartobjects\utility::smartobject_setnextuse();
    return anim.success;
  }

  return anim.running;
}

dosmartobjectterminate(taskid) {
  scripts\smartobjects\utility::clearsmartobject(scripts\asm\asm_bb::bb_getrequestedsmartobject());
  self.disableautolookat = self.bt.instancedata[taskid];
  self.bt.instancedata[taskid] = undefined;
}

low_cover_combat_areas() {
  if(istrue(level.low_cover_combat_setup)) {
    return;
  }
  level.low_cover_combat_setup = 1;

  for(;;) {
    _id_4A8B1AB1C3ECE95D = getEntArray("low_cover_area", "targetname");

    foreach(player in level.players) {
      _id_73CEFD4AE5E1ADCD = undefined;

      foreach(vol in _id_4A8B1AB1C3ECE95D) {
        if(istrue(vol.disabled)) {
          continue;
        }
        if(ispointinvolume(player.origin, vol)) {
          _id_73CEFD4AE5E1ADCD = vol;
          break;
        }
      }

      if(isDefined(player.lowcovervolume) && (!isDefined(_id_73CEFD4AE5E1ADCD) || player.lowcovervolume != _id_73CEFD4AE5E1ADCD)) {
        player notify("left_low_cover");
        player.underlowcover = 0;
      }

      if(isDefined(_id_73CEFD4AE5E1ADCD) && (!isDefined(player.lowcovervolume) || _id_73CEFD4AE5E1ADCD != player.lowcovervolume)) {
        player thread transfer_damage_to_player(_id_73CEFD4AE5E1ADCD);
        player thread player_under_low_cover_monitor(_id_73CEFD4AE5E1ADCD);
      }

      player.lowcovervolume = _id_73CEFD4AE5E1ADCD;
    }

    waitframe();
  }
}

player_under_low_cover_monitor(vol) {
  self endon("left_low_cover");
  self endon("death");
  _id_C1648261A91FFA49 = 1;

  if(isDefined(vol.script_trace) && vol.script_trace == 0)
    _id_C1648261A91FFA49 = 0;

  for(;;) {
    if(_id_C1648261A91FFA49 && !scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 60), self))
      self.underlowcover = 1;
    else if(!_id_C1648261A91FFA49 && ispointinvolume(self.origin, vol))
      self.underlowcover = 1;
    else
      self.underlowcover = 0;

    wait 0.15;
  }
}

transfer_damage_to_player(vol) {
  self endon("left_low_cover");
  self endon("death");
  dmg_trig = vol scripts\engine\utility::get_linked_ents()[0];

  if(!isDefined(dmg_trig)) {
    return;
  }
  _id_17AD3A838DCA5866 = 1;

  while(isDefined(dmg_trig)) {
    dmg_trig waittill("damage", _id_8BBC2903A2793B49, attacker, dir, point, type, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(!isalive(attacker)) {
      continue;
    }
    if(attacker == self) {
      continue;
    }
    if(!self istouching(dmg_trig)) {
      continue;
    }
    if(scripts\engine\utility::is_equal(type, "MOD_MELEE")) {
      continue;
    }
    if(issubstr(type, "BULLET")) {
      forward = anglesToForward(attacker gettagangles("tag_flash"));
      normal = vectorNormalize(self getEye() - attacker gettagorigin("tag_flash"));

      if(vectordot(forward, normal) < 0.9) {
        continue;
      }
      if(_id_17AD3A838DCA5866) {
        _id_17AD3A838DCA5866 = 0;
        wait 2;
        continue;
      }
    }

    self dodamage(_id_8BBC2903A2793B49, attacker.origin, attacker, attacker, type, attacker.weapon);
  }
}