/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1685e6d8181c932a.gsc
***********************************************/

_id_7CAD6330F341F78C(vehicle) {
  _id_918C5A31037E00EE = spawnStruct();
  _id_918C5A31037E00EE.script_airresistance = 1;
  _id_918C5A31037E00EE.speed = 50;
  _id_918C5A31037E00EE.script_accel = 6;
  _id_918C5A31037E00EE.script_decel = 6;
  vehicle._id_918C5A31037E00EE = _id_918C5A31037E00EE;
}

wait_to_stop_path_vehicle(_id_83F2164C211253C0, _id_92DEFECADE96A443) {
  self endon("death");

  for(_id_FE16E33D66144FA0 = _id_92DEFECADE96A443; isDefined(_id_FE16E33D66144FA0.target); _id_FE16E33D66144FA0 = scripts\engine\utility::getStruct(_id_FE16E33D66144FA0.target, "targetname")) {}

  wait 55;

  for(;;) {
    wait 0.25;

    if(self vehicle_getspeed() < 0.25 || distance(self.origin, _id_FE16E33D66144FA0.origin) < 250) {
      self stoppath(1);

      if(istrue(_id_83F2164C211253C0)) {
        thread _id_3E19322333AD204C::_id_4BE7EEE7A5972752();
        self notify("unload");
      }

      return;
    }
  }
}

_id_DB907916BB4A8EF9(_id_45E808DC306D0926) {
  _id_07296729673615C7 = 1073741824;

  if(isDefined(_id_45E808DC306D0926))
    _id_07296729673615C7 = _id_45E808DC306D0926;

  _id_FFF1B402F8B2915A = undefined;
  _id_0DA7CB411B775043 = level._id_FECE02A99189C2DE;

  foreach(_id_C00448D30DF1BEA6 in _id_0DA7CB411B775043) {
    _id_A9B6B677F6D0A010 = distancesquared(self.origin, _id_C00448D30DF1BEA6.origin);

    if(_id_A9B6B677F6D0A010 < _id_07296729673615C7) {
      _id_FFF1B402F8B2915A = _id_C00448D30DF1BEA6;
      _id_07296729673615C7 = _id_A9B6B677F6D0A010;
    }
  }

  return _id_FFF1B402F8B2915A;
}

_id_C05B11C5F084547E(_id_45E808DC306D0926) {
  if(!isDefined(level._id_6E5FF6CAE14C4081))
    return undefined;

  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removeundefined(level._id_6E5FF6CAE14C4081);
  level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_removedead(level._id_6E5FF6CAE14C4081);
  _id_07296729673615C7 = 1073741824;

  if(isDefined(_id_45E808DC306D0926))
    _id_07296729673615C7 = _id_45E808DC306D0926;

  _id_D30969700B0E0867 = undefined;
  _id_33E7199C33734029 = level._id_6E5FF6CAE14C4081;

  foreach(vehicle in _id_33E7199C33734029) {
    if(vehicle vehicle_getspeed() > 0) {
      continue;
    }
    _id_A9B6B677F6D0A010 = distancesquared(self.origin, vehicle.origin);

    if(_id_A9B6B677F6D0A010 < _id_07296729673615C7) {
      _id_D30969700B0E0867 = vehicle;
      _id_07296729673615C7 = _id_A9B6B677F6D0A010;
    }
  }

  return _id_D30969700B0E0867;
}

_id_380B59E67F6E081B(_id_800676BBD5453FC0) {
  foreach(_id_60F7CB484EC61F6C in level.ambientgroups[_id_800676BBD5453FC0._id_3E2A73CF57C32C7C].spawn_points) {
    _id_60F7CB484EC61F6C.script_function = _id_800676BBD5453FC0._id_759EE77E620C0DB7.script_function;

    if(isDefined(_id_800676BBD5453FC0._id_759EE77E620C0DB7._id_BD8883D612FBB662))
      _id_60F7CB484EC61F6C._id_BD8883D612FBB662 = _id_800676BBD5453FC0._id_759EE77E620C0DB7._id_BD8883D612FBB662;
  }
}

_id_1C9666BEF6857EF4(_id_800676BBD5453FC0) {
  foreach(_id_60F7CB484EC61F6C in level.ambientgroups[_id_800676BBD5453FC0._id_3E2A73CF57C32C7C].spawn_points)
  _id_60F7CB484EC61F6C.script_noteworthy = _id_800676BBD5453FC0._id_759EE77E620C0DB7.script_noteworthy;
}

_id_2E1F95D1B1F30D30(_id_800676BBD5453FC0) {
  spawn_points = level.ambientgroups[_id_800676BBD5453FC0._id_3E2A73CF57C32C7C].spawn_points;
  _id_DC61F0C6D1038AD8 = [];

  foreach(point in spawn_points) {
    if(!istrue(point._id_171147E16DF5E2CA))
      _id_DC61F0C6D1038AD8[_id_DC61F0C6D1038AD8.size] = point;
  }

  spawn_point = scripts\engine\utility::random(_id_DC61F0C6D1038AD8);

  if(isDefined(spawn_point)) {
    spawn_point _id_6BC10B84300A5668(_id_800676BBD5453FC0);
    return spawn_point;
  } else
    return undefined;
}

_id_6BC10B84300A5668(_id_800676BBD5453FC0) {
  if(isDefined(_id_800676BBD5453FC0._id_57F8B4C321038A32)) {
    switch (_id_800676BBD5453FC0._id_57F8B4C321038A32) {
      case "medium":
        self.spawngroup = "defender_helispawn_tier1";
        self._id_79FA6BD3C9BF6A0D = undefined;
        break;
      case "medium_close":
      case "medium_tier2":
        self.spawngroup = "defender_helispawn_tier2";
        self._id_79FA6BD3C9BF6A0D = undefined;
        break;
      case "medium_tier3":
        self.spawngroup = "defender_helispawn_hover";
        self._id_79FA6BD3C9BF6A0D = undefined;
        break;
      case "medium_hover":
        self.spawngroup = "defender_helispawn_hover";
        self._id_79FA6BD3C9BF6A0D = 1;
        break;
      case "heli_heavy":
        break;
    }
  }

  _id_5B8046E7D2F07129 = scripts\engine\utility::getStructArray(self.spawngroup, "targetname");

  foreach(_id_D5602DF5F418FB40 in _id_5B8046E7D2F07129)
  _id_D5602DF5F418FB40.pos_override_struct = self;

  thread _id_728CBAB0CB2B71F8();
}

_id_728CBAB0CB2B71F8() {
  self._id_171147E16DF5E2CA = 1;
  wait 45;
  self._id_171147E16DF5E2CA = undefined;
}

_id_B8C051778BBCE6CA() {}

_id_21E835AC16584AEC(_id_800676BBD5453FC0) {
  self endon("death");

  if(isDefined(_id_800676BBD5453FC0._id_57F8B4C321038A32)) {
    if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "medium_hover") {
      level thread _id_FD836036A3B3C31B(self);
      return;
    }
  }

  thread _id_B8C051778BBCE6CA();
  thread _id_FE2167FE1376F914();
  level._id_693F5F3CC4BB0D59 = scripts\engine\utility::array_add_safe(level._id_693F5F3CC4BB0D59, self);
  thread _id_9363F863938191FD();
  thread _id_48F20B0FE71DD6DF::_id_AA2A43AD24DF9485();
  wait 1;
  self.script_vehicle_selfremove = undefined;
  self.unload_hover_offset = 135;

  while(self.riders.size < 4)
    wait 0.1;

  wait 1;
  _id_1047A207E101159E = self.riders;

  foreach(soldier in _id_1047A207E101159E) {
    soldier._id_52284A320885226B = self;
    soldier._id_52284A320885226B._id_0F29D6C1B1FA2281 = _id_1047A207E101159E;
  }

  scripts\engine\utility::ent_flag_wait("unloaded");
  badplace = createnavbadplacebyent(self);
  thread _id_3AA166DEA837994C(badplace);
  level thread _id_A01960D6ACD64E0B(self, _id_1047A207E101159E, _id_800676BBD5453FC0);
  wait 4;
  self.script_vehicle_selfremove = 1;
  thread _id_0E80538EF14D00E1::get_to_z_and_fly_off(undefined, self.vehicle_spawner);
}

_id_FE2167FE1376F914() {
  level endon("game_ended");
  self endon("death_finished");
  self endon("death");

  if(getdvarint("dvar_A474FDC25AD6AB13", 0)) {
    self waittill("landing_found");

    if(isDefined(self._id_FE321E008E65C319))
      self._id_FE321E008E65C319.invulnerable = 1;

    self notify("vehicle_OnDriverDeath_early");
  }

  if(isDefined(self._id_FE321E008E65C319))
    self._id_FE321E008E65C319.ignoreme = 1;
}

_id_9363F863938191FD() {
  self waittill("death");
  level._id_693F5F3CC4BB0D59 = scripts\engine\utility::array_removedead(level._id_693F5F3CC4BB0D59);
}

_id_7BD2E0A8D75178D4() {
  self waittill("death");
  level._id_9BC999AAF7CD0976 = scripts\engine\utility::array_removedead(level._id_9BC999AAF7CD0976);
}

_id_3AA166DEA837994C(badplace) {
  level endon("game_ended");
  wait 10;
  badplace_delete(badplace);
}

_id_A01960D6ACD64E0B(heli, _id_1047A207E101159E, _id_800676BBD5453FC0) {
  _id_1047A207E101159E = scripts\engine\utility::array_removedead_or_dying(_id_1047A207E101159E);
  _id_C00448D30DF1BEA6 = _id_800676BBD5453FC0._id_2444B7785351D927;

  foreach(soldier in _id_1047A207E101159E) {
    soldier._id_800676BBD5453FC0 = _id_800676BBD5453FC0;
    soldier._id_6D3FBC4590EDA90E = 1;
    soldier thread _id_3E19322333AD204C::_id_90B5F7A3A8C60478(_id_C00448D30DF1BEA6);
  }
}

_id_19094EF93A692F0C() {
  self endon("death");
  self endon("unloaded");
  self endon("vehicle_unloaded_me");
}

_id_FD836036A3B3C31B(heli) {
  heli endon("death");
  waittillframeend;
  level._id_9BC999AAF7CD0976 = scripts\engine\utility::array_add_safe(level._id_9BC999AAF7CD0976, heli);
  heli thread _id_7BD2E0A8D75178D4();
  heli.script_vehicle_selfremove = undefined;
  heli.dontunloadonend = 1;
  heli._id_2CE864BD06FB0385 = ::_id_CF0571A1195CF2F1;
  _id_FA4B2C2C8832EA64(heli);
  heli thread _id_694A5F3C8FD6A178();
  heli thread _id_48F20B0FE71DD6DF::_id_AA2A43AD24DF9485(1);
  heli.script_vehicle_selfremove = undefined;
  heli.dontunloadonend = 1;

  foreach(index, rider in heli.riders) {
    rider.dropweapon = 0;
    rider.dontkilloff = 1;
    rider._id_8A5246D0EDF1DCC6 = 1;

    if(rider.vehicle_position == 0 || rider.vehicle_position == 1) {
      continue;
    }
    rider thread _id_B8BBBADE083387DC();
  }
}

_id_B8BBBADE083387DC() {
  self endon("death");

  for(;;) {
    foreach(player in level.players)
    self getenemyinfo(player);

    self fixlinktointerpolationbug(0);
    self.maxsightdistsqrd = squared(8000);
    self _meth_9215CE6FC83759B9(8000);
    self.ignoreall = 0;
    wait 1;
  }
}

_id_CF0571A1195CF2F1(data) {
  modifier = _id_EFBAB999525CDDBE();

  if(istrue(data.isrearcriticaldamage))
    data.damage = int(data.damage * 3 * modifier);
  else
    data.damage = int(data.damage * 2 * modifier);

  return 1;
}

_id_EFBAB999525CDDBE() {
  guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  _id_8EA15BF9A2FD1021 = 0;
  modifier = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < guys.size; _id_AC0E594AC96AA3A8++) {
    if(!istrue(guys[_id_AC0E594AC96AA3A8]._id_8A5246D0EDF1DCC6))
      _id_8EA15BF9A2FD1021++;
  }

  if(_id_8EA15BF9A2FD1021 == 0) {
    modifier = 3;
    level thread _id_BAFA0A3200A9AB69();
  } else if(_id_8EA15BF9A2FD1021 == 1)
    modifier = 2;
  else if(_id_8EA15BF9A2FD1021 > 1 && _id_8EA15BF9A2FD1021 < 7)
    modifier = 1.5;

  return modifier;
}

_id_BAFA0A3200A9AB69() {
  if(isDefined(level._id_7016D1CDE820277C)) {
    return;
  }
  level._id_7016D1CDE820277C = 1;
  level thread _id_48F20B0FE71DD6DF::_id_07E843ECF26B3937();
}

_id_FC8EF090DF82817E() {
  spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
  [[spawnfunc]]("defend_intro_guys_a", 5, 5, 5, 0.1, 0, "defend_intro_guys_a", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("defend_intro_guys_a", undefined, 20000, 30000);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("defend_intro_guys_a", ::spawn_in_cover);
  [[spawnfunc]]("defend_intro_guys_a_top", 5, 5, 5, 0.1, 0, "defend_intro_guys_a_top", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("defend_intro_guys_a_top", undefined, 20000, 30000);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("defend_intro_guys_a_top", ::_id_3637E53162C32ABA);
  [[spawnfunc]]("defend_intro_guys_rushers", 2, 2, 2, 0.1, 0, "defend_intro_guys_rushers", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("defend_intro_guys_rushers", undefined, 20000, 30000);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("defend_intro_guys_rushers", ::_id_D91A0AA660F50950);
  [[spawnfunc]]("defend_intro_guys_flank", 18, 18, 18, ::_id_49B7697773EB4570, 0, "defend_intro_guys_flank", ::watchforstopwaves, undefined, undefined);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("defend_intro_guys_flank", undefined, 20000, 30000);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("defend_intro_guys_flank", ::_id_5417010D0D525BD9);
}

_id_49B7697773EB4570(group) {
  if(!isDefined(level._id_B5AAB20E3A6702C5))
    level._id_B5AAB20E3A6702C5 = 0;

  level._id_B5AAB20E3A6702C5++;

  if(level._id_B5AAB20E3A6702C5 > 8)
    return randomfloatrange(0.6, 0.95);

  return randomfloatrange(0.3, 0.9);
}

_id_BC078843F4469108() {
  level endon("game_ended");
  level._id_193893EC58A382AF = level thread _id_18A73A64992DD07D::run_spawn_module("defend_intro_guys_a");
  level._id_FD1113A8AAB586AB = level thread _id_18A73A64992DD07D::run_spawn_module("defend_intro_guys_a_top");
  level._id_876B3E8629EA51CE = level thread _id_18A73A64992DD07D::run_spawn_module("defend_intro_guys_rushers");
  level._id_4791585AF72BE8A0 = [level._id_193893EC58A382AF, level._id_FD1113A8AAB586AB, level._id_876B3E8629EA51CE];
  wait 2;

  if(istrue(level._id_EFE609BCE901CAA8)) {
    scripts\cp\utility::gameflagwait("infil_started");

    while(level._id_193893EC58A382AF.ai_spawned.size == 0)
      wait 0.1;

    wait 1;
    _id_A3B65610149E93D8 = scripts\engine\utility::array_combine(level._id_193893EC58A382AF.ai_spawned, level._id_FD1113A8AAB586AB.ai_spawned);

    foreach(ai in _id_A3B65610149E93D8) {
      if(isalive(ai))
        ai thread scripts\common\ai::magic_bullet_shield(1);
    }

    wait 1;
    level thread _id_C80DA76572BC5314();
    scripts\engine\utility::flag_wait("infil_over");

    foreach(ai in _id_A3B65610149E93D8) {
      if(isalive(ai) && isDefined(ai.magic_bullet_shield))
        ai thread scripts\common\ai::stop_magic_bullet_shield();
    }
  }
}

_id_C80DA76572BC5314() {
  level endon("game_ended");
  level endon("infil_over");

  foreach(ai in level._id_193893EC58A382AF.ai_spawned) {
    if(isalive(ai)) {
      offset = (randomintrange(-150, 150), randomintrange(-150, 150), 0);
      position = scripts\engine\utility::drop_to_ground(ai.origin + offset, 1500, -12000);
      magicgrenademanual("frag", position, (0, 0, -1000), 2 + randomfloat(9));
      offset = (randomintrange(-350, 0), randomintrange(-350, 0), 0);
      position = scripts\engine\utility::drop_to_ground(ai.origin + offset, 1500, -12000);
      magicgrenademanual("frag", position, (0, 0, -1000), 6 + randomfloat(12));
      offset = (randomintrange(0, 350), randomintrange(0, 350), 0);
      position = scripts\engine\utility::drop_to_ground(ai.origin + offset, 1500, -12000);
      magicgrenademanual("frag", position, (0, 0, -1000), 10 + randomfloat(15));
    }

    wait(1 + randomfloat(2));
  }
}

spawn_in_cover(group) {
  self.dontkilloff = 1;
  _id_0386C209C4BE9E91 = self getnearestnode();
  _id_5EE5A07D7D8DC443 = 999;

  if(isDefined(_id_0386C209C4BE9E91))
    _id_5EE5A07D7D8DC443 = distance(self.origin, _id_0386C209C4BE9E91.origin);

  if(isDefined(_id_0386C209C4BE9E91) && _id_5EE5A07D7D8DC443 < 128) {
    _id_D38A5EB1292B482C = _id_0386C209C4BE9E91.angles;
    _id_CEE7A3C264A91076 = _id_0386C209C4BE9E91.origin;

    if(!issubstr(_id_0386C209C4BE9E91.type, "Prone")) {
      if(issubstr(_id_0386C209C4BE9E91.type, "Left"))
        _id_D38A5EB1292B482C = _id_D38A5EB1292B482C + (0, 90, 0);
      else if(issubstr(_id_0386C209C4BE9E91.type, "Right") || issubstr(_id_0386C209C4BE9E91.type, "Cover Crouch") || issubstr(_id_0386C209C4BE9E91.type, "Conceal") || issubstr(_id_0386C209C4BE9E91.type, "Cover Stand"))
        _id_D38A5EB1292B482C = _id_D38A5EB1292B482C - (0, 90, 0);
    }

    self forceteleport(_id_CEE7A3C264A91076, _id_D38A5EB1292B482C);
    self _meth_30377946FC33F8A7(_id_0386C209C4BE9E91);
    self setgoalnode(_id_0386C209C4BE9E91);
    self.goalradius = 8;
    self.sniperaccuracyset = 1;
    self.baseaccuracy = 1;
    self.aggressivemode = 1;
    self.mgbursttimemin = 15;
    self.mgbursttimemax = 20;
    self.aggressiveblindfire = 1;
  } else {}

  self.script_origin_other = self.origin;
  _id_18A73A64992DD07D::set_goal_pos(self.origin);
  _id_18A73A64992DD07D::set_goal_radius(64);
  thread _id_0BFFFC5C6BEA3AAD();
}

_id_3637E53162C32ABA(group) {
  _id_27E5044C7A07898E(group);
  thread _id_D6CE3A9D28C311EC();
}

_id_75C7109216536211() {
  self endon("death");
  level waittill("intro_soldier_damaged");
  _id_7EF6A8808A48F958 = undefined;

  while(!isDefined(_id_7EF6A8808A48F958)) {
    _id_7EF6A8808A48F958 = scripts\cp\utility::get_closest_living_player();

    if(isDefined(_id_7EF6A8808A48F958)) {
      break;
    }

    wait 1;
  }

  self allowedstances("crouch", "stand");
  self.dontkilloff = 1;

  for(;;) {
    self.script_origin_other = _id_7EF6A8808A48F958.origin;
    _id_18A73A64992DD07D::set_goal_pos(_id_7EF6A8808A48F958.origin);
    _id_18A73A64992DD07D::set_goal_radius(400);
    wait 20;
  }
}

_id_66C79C508B095F85() {
  _id_01D4621C77C9108F = getaiarray("axis");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_01D4621C77C9108F.size; _id_AC0E594AC96AA3A8++)
    _id_01D4621C77C9108F[_id_AC0E594AC96AA3A8] thread _id_BFF30240D0E9C8CB();
}

_id_BFF30240D0E9C8CB() {
  self waittill("death", attacker);

  if(isPlayer(attacker))
    level notify("intro_soldier_damaged");
}

_id_D6CE3A9D28C311EC() {
  thread _id_75C7109216536211();
}

_id_0BFFFC5C6BEA3AAD() {
  self endon("death");
  level waittill("intro_soldier_damaged");
  _id_7EF6A8808A48F958 = undefined;

  while(!isDefined(_id_7EF6A8808A48F958)) {
    _id_7EF6A8808A48F958 = scripts\cp\utility::get_closest_living_player();

    if(isDefined(_id_7EF6A8808A48F958)) {
      break;
    }

    wait 1;
  }

  level._id_367842BAEBE766BB = scripts\engine\utility::array_add_safe(level._id_367842BAEBE766BB, self);
}

_id_D91A0AA660F50950(group) {
  self endon("death");

  if(istrue(level._id_EFE609BCE901CAA8))
    level waittill("deltaSquad_intro_runbackwards");

  wait 1;
  self allowedstances("crouch", "stand");
  self.dontkilloff = 1;
  _id_C80243F45C64BB16 = scripts\engine\utility::getStruct("intro_rusher_dest", "targetname");
  _id_18A73A64992DD07D::set_goal_pos(_id_C80243F45C64BB16.origin);
  _id_18A73A64992DD07D::set_goal_radius(400);
}

_id_5417010D0D525BD9(group) {
  self endon("death");
  self allowedstances("crouch", "stand");
  self.dontkilloff = 1;
  thread _id_B41CDA73F2F369C7();
}

_id_B41CDA73F2F369C7() {
  self endon("death");
  scripts\engine\utility::flag_wait("infil_over");
  wait(randomfloat(7));
  self kill(self.origin);
}

_id_27E5044C7A07898E(group) {
  self allowedstances("crouch");
  self.dontkilloff = 1;
  self.script_origin_other = self.origin;
  _id_18A73A64992DD07D::set_goal_pos(self.origin);
  _id_18A73A64992DD07D::set_goal_radius(64);
}

watchforstopwaves(group) {
  level endon("game_ended");
  level thread _watchforstopwaves(group);
}

_watchforstopwaves(group) {
  level endon("game_ended");
  level waittill("end_wave_defend_intro_spawners");
  level notify("spawn_module_" + group.moduleid + "_completed");
}

_id_9F4D554E3AE3D383() {
  if(_id_18A73A64992DD07D::is_specified_unittype("juggernaut") || _id_18A73A64992DD07D::is_specified_unittype("dog")) {
    return;
  }
  body = "body_mp_milsim_balkan_sf_1_1";
  head = "head_mp_milsim_balkan_sf_1_1";
  weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mpapa7");
  _id_A664AAD02EE98BD2 = "frag_grenade_mp";
  _id_F9FA10E07F13F5FD = self.spawner.aitype;

  switch (_id_F9FA10E07F13F5FD) {
    case "shotgun":
      body = "body_mp_eastern_nikto_2_1";
      head = "head_mp_eastern_nikto_3_1";
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
      _id_A664AAD02EE98BD2 = "molotov_mp";
      break;
    case "sniper":
      body = "body_mp_eastern_azur_8_1";
      head = "head_mp_eastern_azur_8_1";
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("alpha50");
      _id_A664AAD02EE98BD2 = "frag_grenade_mp";
      break;
    case "lmg":
      body = "body_mp_eastern_velikan_1_1";
      head = "head_mp_eastern_velikan_1_1";
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mkilo3");
      _id_A664AAD02EE98BD2 = "semtex_mp";
      break;
    case "smg":
      body = "body_mp_eastern_rodion_7_1";
      head = "head_mp_eastern_rodion_7_1";
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mpapa7");
      _id_A664AAD02EE98BD2 = "smoke_grenade_mp";
      break;
    case "ar_laser":
    case "ar":
      body = "body_mp_western_milsim_jw_grom_1_1";
      head = "head_mp_western_milsim_jw_grom_1_1";
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
      _id_A664AAD02EE98BD2 = "flash_mp";
      break;
    default:
      break;
  }

  _id_16C92180949DB961(body, head, weapon, _id_A664AAD02EE98BD2);
}

_id_16C92180949DB961(body, head, weapon, _id_A664AAD02EE98BD2) {
  self setModel(body);

  if(isDefined(self.headmodel))
    self detach(self.headmodel);

  self attach(head, "", 1);
  self.headmodel = head;
  _id_18A73A64992DD07D::give_soldier_armor();
  _id_18A73A64992DD07D::give_soldier_helmet();
  self.allowpain = 0;
  self.equip_armor = 1;
  self._id_B5218CF00DAD94EF = 840;
  self.goalradius = 2048;
  self.fnshouldplaypainanim = ::_id_AF065740D34B7EA9;

  if(isDefined(self.weapon))
    self takeweapon(self.weapon);

  self.weapon = weapon;
  scripts\common\utility::initweapon(self.weapon);
  self giveweapon(self.weapon);
  self setspawnweapon(self.weapon);
  self.bulletsinclip = weaponclipsize(self.weapon);
  self.primaryweapon = self.weapon;
  self.grenadeweapon = makeweapon(_id_A664AAD02EE98BD2);
  self.grenadeammo = 2;
  self.script_forcegrenade = 1;
  self.accuracy = 0.4;
  thread watchchangeweapon();
  thread _id_8B1A3AD62BA39C38();
  thread _id_EB2924EA4D736217();
}

_id_8B1A3AD62BA39C38() {
  level endon("game_ended");
  weapon = undefined;
  _id_F9FA10E07F13F5FD = self.spawner.aitype;

  switch (_id_F9FA10E07F13F5FD) {
    case "shotgun":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mbravo");
      break;
    case "sniper":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("alpha50");
      break;
    case "lmg":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mkilo3");
      break;
    case "smg":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mpapa7");
      break;
    case "ar_laser":
    case "ar":
      weapon = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
      break;
    default:
      break;
  }

  self waittill("death");

  if(isDefined(weapon)) {
    _id_CD9ABE0E758CBDF7 = weapon;
    _id_92FCE7B1696254E3 = weapon.basename;

    if(issubstr(tolower(_id_92FCE7B1696254E3), "_ai")) {
      _id_92FCE7B1696254E3 = getsubstr(_id_92FCE7B1696254E3, 0, _id_92FCE7B1696254E3.size - 3);
      _id_CD9ABE0E758CBDF7 = makeweapon(_id_92FCE7B1696254E3, weapon.attachments);
    }

    if(isDefined(level.dropped_weapon_func))
      self thread[[level.dropped_weapon_func]](_id_CD9ABE0E758CBDF7, self.origin);
  }
}

_id_EB2924EA4D736217() {
  level endon("game_ended");
  self endon("death");
  _id_D01C4A7C13A1D961 = 100;

  for(;;) {
    self waittill("damage");

    if(self._id_B5218CF00DAD94EF <= _id_D01C4A7C13A1D961) {
      break;
    }
  }

  _id_9ED4AF47ABD0976E = randomfloatrange(5, 10);
  self allowedstances("crouch");
  wait(_id_9ED4AF47ABD0976E);
  self allowedstances("stand", "crouch");
}

_id_AF065740D34B7EA9() {
  if(isDefined(self.damageweapon)) {
    _id_9211CDAADB7BCA55 = getweaponbasename(self.damageweapon);

    if(isDefined(_id_9211CDAADB7BCA55) && _id_9211CDAADB7BCA55 == "sentry_turret_mp")
      return 1;

    if(isDefined(_id_9211CDAADB7BCA55) && _id_74502A9E0EF1F19C::is_launcher(self.damageweapon))
      return 1;
  }

  return scripts\asm\asm_mp::shouldplaypainanim();
}

_id_9C0FBE62C1B9D660(_id_875864798EFD8038) {
  self endon("death");
  self endon("stop_hunting");
  player = scripts\engine\utility::random(level.players);
  count = 0;

  for(;;) {
    if(!isDefined(player) || istrue(player.inlaststand)) {
      selected = 0;

      foreach(_id_4A27F44F23590C6F in level.players) {
        if(istrue(_id_4A27F44F23590C6F.inlaststand)) {
          continue;
        }
        player = _id_4A27F44F23590C6F;
        selected = 1;
      }

      if(!selected) {
        wait 3;
        player = undefined;
        continue;
      }
    }

    if(self cansee(player) || scripts\cp\utility::ifcanseeplayer(self, player)) {
      scripts\engine\utility::delaycall(0.05, ::aieventlistenerevent, "combat", player, player.origin);
      scripts\engine\utility::delaycall(0.1, ::getenemyinfo, player);
      org = player.origin;
      self setgoalpos(player.origin);
      _id_18A73A64992DD07D::set_goal_radius(1500);
      count++;
    }

    if(isDefined(_id_875864798EFD8038) && _id_875864798EFD8038 >= count) {
      return;
    }
    wait 5;
  }
}

watchchangeweapon() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    objweapon = self getcurrentweapon();

    if(isDefined(objweapon))
      dochangeweapon(objweapon);

    self waittill("weapon_change");
  }
}

dochangeweapon(objweapon) {
  _id_74502A9E0EF1F19C::updatelauncherusage();
  _id_74502A9E0EF1F19C::updatedragonsbreath(objweapon);
}

#using_animtree("mp_vehicles_always_loaded");

_id_2A3D0EB105242615(veh) {
  spawndata = spawnStruct();
  spawndata.angles = veh.angles;
  spawndata.origin = veh.origin;

  if(istrue(self._id_2007F5A5A462CD9D))
    return 0;

  self._id_2007F5A5A462CD9D = 1;
  _id_998BE083DDA4BA35 = 0;
  _id_5D61F034B126CBCA = undefined;

  switch (veh.model) {
    case "veh8_civ_lnd_techo_physics_cp":
      veh setModel(veh.model);
      veh thread _id_19BEB2599A856A11::_id_7D87DD9EB57867A1();
      veh._id_1AB6B61153087915 = ::_id_1AB6B61153087915;
      veh.health = veh.health * 2;
      break;
    case "veh8_civ_lnd_techo_rebel_physics":
      spawndata.classname_mp = "script_vehicle_iw9_truck_techo_rebel";
      spawndata.script_modelname = veh.model;
      spawndata.vehicletype = "veh9_techo_physics_cp";
      _id_5D61F034B126CBCA = scripts\common\vehicle::vehicle_spawn(spawndata);
      _id_5D61F034B126CBCA thread _id_19BEB2599A856A11::_id_7D87DD9EB57867A1();
      _id_5D61F034B126CBCA._id_1AB6B61153087915 = ::_id_1AB6B61153087915;
      _id_5D61F034B126CBCA.health = _id_5D61F034B126CBCA.health * 2;
      _id_998BE083DDA4BA35 = 1;
      break;
    case "veh9_civ_lnd_techo_rebel_armor_cp":
    case "veh9_civ_lnd_techo_rebel_armor_vehphys_cp":
      if(getdvarint("dvar_1D8B8C45BBA6A4D6", 1) > 0) {
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(veh, "neutral");
        veh._id_F24CC3BEEF01650C = ::_id_1AB6B61153087915;
        veh.door_open = 1;
        veh vehicleplayanim(%reb_com_veh8_techo_fl_door_open);
        veh._id_CF1E271394C5DC95 = 850;
        _id_998BE083DDA4BA35 = 0;
        waitframe();
        veh.health = 2250;
        _id_5E69D629FB22356B = 0;
        level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_remove(level._id_6E5FF6CAE14C4081, veh);

        if(isDefined(veh._id_393832BCEC3AFD03)) {
          foreach(guy in veh._id_393832BCEC3AFD03) {}
        }

        veh _id_24E4405CF93F20ED::_id_1686ECAABFDC542D();
        wait 1;
        veh vehicle_settopspeedforward(35);
        veh vehicle_settopspeedreverse(35);
      } else {
        _id_5D61F034B126CBCA = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_techo_rebel_armor", spawndata);
        _id_5D61F034B126CBCA.health = _id_5D61F034B126CBCA.health * 2;

        if(!isDefined(_id_5D61F034B126CBCA.classname_mp))
          _id_5D61F034B126CBCA.classname_mp = "script_vehicle_iw9_truck_techo_rebel_armor";

        veh _id_0E80538EF14D00E1::delete_nav_obstacle();
        _id_5D61F034B126CBCA._id_1AB6B61153087915 = ::_id_1AB6B61153087915;
        veh hide();
        _id_5D61F034B126CBCA.door_open = 1;
        _id_5D61F034B126CBCA vehicleplayanim(%reb_com_veh8_techo_fl_door_open);
        _id_5D61F034B126CBCA._id_CF1E271394C5DC95 = 2500;
        _id_998BE083DDA4BA35 = 0;
        veh delete();
      }

      break;
    case "veh8_mil_lnd_tromeo_physics_mp":
      _id_5D61F034B126CBCA = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("tac_rover", spawndata);
      _id_5D61F034B126CBCA._id_1AB6B61153087915 = ::_id_1AB6B61153087915;
      _id_5D61F034B126CBCA.health = _id_5D61F034B126CBCA.health * 2;
      _id_998BE083DDA4BA35 = 1;
      break;
    case "veh9_mil_lnd_jltv_turret_vehphys_mp":
      if(getdvarint("dvar_1D8B8C45BBA6A4D6", 1) > 0) {
        while(isDefined(veh.gunner) && isalive(veh.gunner))
          wait 0.25;

        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(veh, "neutral");
        veh._id_F24CC3BEEF01650C = ::_id_1AB6B61153087915;
        veh.door_open = 1;
        veh vehicleplayanim(%vh_decho_driver_exit_patrol);
        veh._id_CF1E271394C5DC95 = 850;
        _id_998BE083DDA4BA35 = 0;
        waitframe();
        veh.health = 2250;
        _id_5E69D629FB22356B = 0;
        level._id_6E5FF6CAE14C4081 = scripts\engine\utility::array_remove(level._id_6E5FF6CAE14C4081, veh);

        if(isDefined(veh._id_393832BCEC3AFD03)) {
          foreach(guy in veh._id_393832BCEC3AFD03) {}
        }

        veh _id_0F3B4A4783EDE654::_id_AB23AE9A33E231FE();
        wait 1;
        veh vehicle_settopspeedforward(35);
        veh vehicle_settopspeedreverse(35);
      }

      break;
  }

  if(_id_998BE083DDA4BA35) {
    if(isDefined(_id_5D61F034B126CBCA)) {
      _id_74502A9E0EF1F19C::add_to_special_lockon_target_list(_id_5D61F034B126CBCA);

      if(isDefined(veh.vehicle_spawner._id_72772FA651ECBE2B)) {
        funcs = strtok(veh.vehicle_spawner._id_72772FA651ECBE2B, "+");

        foreach(func in funcs) {
          if(func != "ammo_cache") {
            continue;
          }
          _id_5D61F034B126CBCA thread[[level._id_A8DC22C62BA69B88[func]]]();
        }
      }
    }

    veh _id_0E80538EF14D00E1::delete_nav_obstacle();
    veh delete();
  }

  return _id_998BE083DDA4BA35;
}

_id_1AB6B61153087915(data) {
  if(isDefined(data.attacker) && isPlayer(data.attacker))
    data.damage = 0;
  else if(isexplosivedamagemod(data.meansofdeath) && data.meansofdeath != "MOD_EXPLOSIVE_BULLET")
    data.damage = max(1, int(data.damage / 2));
  else
    data.damage = max(5, int(data.damage / 4.5));

  _id_52616AAE7B55D981 = int(clamp((self.health - data.damage) / self.maxhealth * 100, 0, 100));
}

_id_58AC0D3936B07904() {
  if(isDefined(self.spawner) && self.spawner.targetname == "ai_for_trucks") {
    if(!isDefined(self.vehicle) && !isDefined(self._id_57FE63DB5392BD20)) {
      _id_7EF6A8808A48F958 = scripts\cp\utility::get_closest_living_player();
      _id_18A73A64992DD07D::set_goal_pos(_id_7EF6A8808A48F958.origin);
      _id_18A73A64992DD07D::set_goal_radius(500);
    }
  }
}

_id_CC07567B08D95292(_id_6DD492B76AE7D613, _id_C00448D30DF1BEA6) {
  _id_1491A51C2EF8B214 = scripts\engine\utility::getStructArray(_id_6DD492B76AE7D613, "targetname");
  func = ::_id_3B6CB5ADD3327A1B;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender", "mortar_team_area_think"))
    func = scripts\cp_mp\utility\script_utility::getsharedfunc("defender", "mortar_team_area_think");

  foreach(area in _id_1491A51C2EF8B214)
  area thread[[func]](_id_C00448D30DF1BEA6);
}

_id_3B6CB5ADD3327A1B(_id_C00448D30DF1BEA6) {
  level endon("game_ended");
  trig = spawn("trigger_radius", self.origin, 0, int(self.radius), 1024);

  if(!isDefined(trig.radius))
    trig.radius = int(self.radius);

  _id_CFF4CD4D39602AAE = scripts\engine\utility::getStructArray(self.target, "targetname");
  _id_0C3EA9B1A20FF199 = scripts\engine\utility::random(_id_CFF4CD4D39602AAE);
  _id_C718C3FCABAA752F = scripts\engine\utility::drop_to_ground(_id_0C3EA9B1A20FF199.origin);
  _id_92753DA39919F200 = spawn("script_model", _id_C718C3FCABAA752F);
  _id_92753DA39919F200.angles = _id_0C3EA9B1A20FF199.angles;
  _id_92753DA39919F200 setModel("misc_wm_mortar");
  _id_92753DA39919F200.script_noteworthy = "mortar";

  if(!isDefined(level._id_2B218E6AEBB46057))
    level._id_2B218E6AEBB46057 = [];

  level._id_2B218E6AEBB46057[level._id_2B218E6AEBB46057.size] = _id_92753DA39919F200;
  level thread _id_5DBE8C6B21E034B4(_id_0C3EA9B1A20FF199.origin, _id_92753DA39919F200);
  spawnpoints = scripts\engine\utility::getStructArray("soldiers_mortarteam", "targetname");
  spawnpoint = scripts\engine\utility::getclosest(_id_0C3EA9B1A20FF199.origin, spawnpoints);
  aitype = "actor_enemy_cp_ar_tier1_aq";

  if(!isDefined(spawnpoint)) {
    return;
  }
  guys = [];
  guys[guys.size] = _id_537A712B2BE3193C::_id_43825E7633150BE3(aitype, spawnpoint, 0, 128);
  guys[guys.size] = _id_537A712B2BE3193C::_id_43825E7633150BE3(aitype, spawnpoint, 0, 128);

  foreach(guy in guys) {
    if(!isDefined(guy)) {
      continue;
    }
    guy._id_389B04AEB955FCB9 = 1;

    if(!isDefined(_id_92753DA39919F200.operator))
      _id_92753DA39919F200.operator = guy;
    else {
      guy setgoalpos(_id_92753DA39919F200.origin);
      guy setgoalentity(_id_92753DA39919F200);
    }

    guy.entered_combat = 1;
  }

  level thread _id_230D6EEBDA212CCF(_id_92753DA39919F200, trig);
  level thread _id_A3AA6C4D8110D906(_id_92753DA39919F200);
  level thread _id_86F1137F72C8347D(_id_92753DA39919F200);
  level _id_3CD7FAF667114025(guys, _id_92753DA39919F200);
  _id_92753DA39919F200.dead = 1;
  _id_92753DA39919F200 notify("stop_mortar_think");
  _id_92753DA39919F200 notify("stop_attracting");
  wait 3;
  _id_92753DA39919F200 playSound("sentry_explode");

  foreach(guy in guys) {
    if(isDefined(guy) && isalive(guy)) {
      _id_BF957E58D9E127A7 = scripts\engine\utility::random(level._id_FECE02A99189C2DE);

      if(isDefined(_id_BF957E58D9E127A7) && isDefined(_id_BF957E58D9E127A7.origin)) {
        guy _id_18A73A64992DD07D::set_goal_radius(450);
        guy _id_18A73A64992DD07D::set_goal_pos(_id_BF957E58D9E127A7.origin);
        guy.goalheight = 48;
        guy.script_origin_other = _id_BF957E58D9E127A7.origin;
        guy.ignoreall = 0;
      }

      if(istrue(guy.dontkilloff))
        guy.dontkilloff = undefined;
    }
  }

  if(_id_92753DA39919F200 tagexists("tag_origin"))
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), _id_92753DA39919F200, "tag_origin");

  if(_id_92753DA39919F200 tagexists("tag_aim"))
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), _id_92753DA39919F200, "tag_aim");

  wait 1;
  level._id_2B218E6AEBB46057 = scripts\engine\utility::array_remove(level._id_2B218E6AEBB46057, _id_92753DA39919F200);
  _id_92753DA39919F200 delete();
}

_id_3CD7FAF667114025(guys, _id_92753DA39919F200) {
  _id_92753DA39919F200 endon("stop_mortar_think");
  _id_537A712B2BE3193C::_id_E4F3059610095250(guys);
}

_id_230D6EEBDA212CCF(_id_92753DA39919F200, trig) {
  _id_92753DA39919F200 endon("stop_mortar_think");
  level.get_mortar_impact_pos = ::_id_AA2345159B60A661;
  _id_92753DA39919F200.targets = undefined;

  for(;;) {
    targets = scripts\cp\utility::get_array_of_valid_players();
    targets = _id_9CB5E0B04644DD1A(trig);

    if(targets.size > 0) {
      _id_92753DA39919F200.targets = targets;
      _id_504283B70DE854FA::attract_agent_to_mortar(_id_92753DA39919F200, 1, 1024);
      _id_92753DA39919F200.targets = undefined;
      wait(randomintrange(5, 10));
      continue;
    }

    wait 1;
  }
}

_id_86F1137F72C8347D(_id_92753DA39919F200) {
  level endon("game_ended");
  _id_92753DA39919F200 endon("stop_mortar_think");

  for(;;) {
    if(isDefined(_id_92753DA39919F200.targets)) {
      foreach(target in _id_92753DA39919F200.targets) {
        if(distance2d(target.origin, _id_92753DA39919F200.origin) < 500) {
          _id_92753DA39919F200 notify("stop_mortar_think");
          _id_92753DA39919F200 notify("stop_attracting");
        }
      }
    }

    wait 1;
  }
}

_id_A3AA6C4D8110D906(_id_92753DA39919F200) {
  level endon("game_ended");
  _id_92753DA39919F200 endon("stop_mortar_think");
  wait 5;

  for(;;) {
    wait 5;
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    if(guys.size == 0) {
      continue;
    }
    _id_B929F167E9CEEEE0 = 0;

    foreach(guy in guys) {
      if(!isDefined(guy)) {
        continue;
      }
      if(!isalive(guy)) {
        continue;
      }
      if(istrue(guy._id_389B04AEB955FCB9))
        _id_B929F167E9CEEEE0++;
    }

    if(_id_B929F167E9CEEEE0 >= guys.size - 3 && level._id_215CD837F06FA79E._id_1F44055D8DF16E0B > 1)
      _id_92753DA39919F200 notify("stop_mortar_think");
  }
}

_id_AA2345159B60A661(_id_92753DA39919F200) {
  if(!isDefined(_id_92753DA39919F200.targets))
    return undefined;

  player = scripts\engine\utility::random(_id_92753DA39919F200.targets);

  if(!isDefined(player._id_4B4E9C1B27D7F65E))
    player._id_4B4E9C1B27D7F65E = 0;

  modifier = 1;

  switch (player._id_4B4E9C1B27D7F65E) {
    case 0:
      modifier = 40;
      break;
    case 1:
      modifier = 10;
      break;
    case 2:
      modifier = 1;
      break;
  }

  if(player._id_4B4E9C1B27D7F65E >= 2)
    player._id_4B4E9C1B27D7F65E = undefined;
  else
    player._id_4B4E9C1B27D7F65E++;

  point = player.origin + (randomintrange(-10 * modifier, 10 * modifier), randomintrange(-10 * modifier, 10 * modifier), 0);
  trace = scripts\engine\trace::ray_trace(point + (0, 0, 500), point);
  return trace["position"];
}

_id_9CB5E0B04644DD1A(trig) {
  validplayers = [];
  _id_1A96B3062BB2C598 = trig.radius * trig.radius;

  foreach(player in level.players) {
    if(!player scripts\cp\utility::is_valid_player() || !player isonground() || player isonladder()) {
      continue;
    }
    if(distance2dsquared(player.origin, trig.origin) < _id_1A96B3062BB2C598)
      validplayers[validplayers.size] = player;
  }

  return validplayers;
}

_id_5DBE8C6B21E034B4(location, _id_92753DA39919F200) {
  level endon("game_ended");
  wait 10;

  if(isDefined(_id_92753DA39919F200) && istrue(_id_92753DA39919F200.dead)) {
    return;
  }
  objindex = scripts\cp\cp_objectives::requestworldid("defender_attackGroup");
  objective_state(objindex, "current");
  objective_position(objindex, location);
  objective_icon(objindex, "hud_icon_head_marked");
  objective_setminimapiconsize(objindex, "icon_small");
  objective_setshowdistance(objindex, 1);
  objective_setplayintro(objindex, 0);
  objective_sethot(objindex, 0);
  objective_setownerteam(objindex, "axis");
  objective_setbackground(objindex, 1);

  if(!isDefined(level._id_E27A333459EF4DBE))
    level._id_E27A333459EF4DBE = [];

  level._id_E27A333459EF4DBE[level._id_E27A333459EF4DBE.size] = objindex;

  if(isDefined(_id_92753DA39919F200))
    _id_92753DA39919F200 scripts\engine\utility::waittill_any_2("stop_mortar_think", "death");
  else
    wait 40;

  objective_delete(objindex);
  scripts\cp\cp_objectives::freeworldidbyobjid(objindex);
  level._id_E27A333459EF4DBE = scripts\engine\utility::array_remove(level._id_E27A333459EF4DBE, objindex);
}

_id_43EBC66899EF6383(guys) {
  level endon("game_ended");
  level endon("defender_wave_fail");
  level endon("defender_wave_win");
  _id_63429D61D120D4C2 = 0;
  _id_B12025DBD33FD672 = 0;
  maxdist = 2000;

  while(guys.size > 0) {
    guys = scripts\engine\utility::array_removedead_or_dying(guys);

    if(guys.size == 0) {
      break;
    }

    if(guys.size <= 3) {
      _id_63429D61D120D4C2++;
      _id_B12025DBD33FD672++;
    }

    if(_id_B12025DBD33FD672 > 30)
      maxdist = 1500;

    if(_id_63429D61D120D4C2 > 5) {
      _id_ADDD38BB488192B4 = scripts\cp\utility::get_average_origin(level.players);
      _id_AA96A05C93CB3459 = scripts\cp\utility::getfarthest(_id_ADDD38BB488192B4, guys);
      _id_91CF4907C1742793 = 0;

      foreach(player in level.players) {
        _id_91CF4907C1742793 = _id_2B79931B08683E0A::player_can_see_ai(player, _id_AA96A05C93CB3459);

        if(_id_91CF4907C1742793) {
          break;
        }

        _id_91CF4907C1742793 = _id_AA96A05C93CB3459 seerecently(player, 15);

        if(_id_91CF4907C1742793) {
          break;
        }
      }

      isonturret = _id_AA96A05C93CB3459 _id_3E19322333AD204C::_id_96A4544BE1843F0E();

      if(isonturret) {
        _id_AA96A05C93CB3459.vehicle.unload_group = "all";
        _id_AA96A05C93CB3459.vehicle scripts\common\vehicle_code::_vehicle_unload(_id_AA96A05C93CB3459);
      }

      _id_1D24D18E8F904D2D = istrue(_id_AA96A05C93CB3459._id_456F1227DDA72419);
      _id_34395DF55388B808 = isDefined(_id_AA96A05C93CB3459.vehicle) && isDefined(_id_AA96A05C93CB3459.vehicle_position);

      if(distance(_id_AA96A05C93CB3459.origin, _id_ADDD38BB488192B4) >= maxdist && !_id_91CF4907C1742793 && !isonturret && !_id_1D24D18E8F904D2D && !_id_34395DF55388B808)
        _id_AA96A05C93CB3459 dodamage(_id_AA96A05C93CB3459.health + 1000, _id_AA96A05C93CB3459.origin);

      _id_63429D61D120D4C2 = 0;
    }

    wait 1;
  }
}

_id_2F4168E10B3A0B51() {
  level endon("game_ended");
  wait 10;

  for(;;) {
    wait 5;
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    if(guys.size == 0) {
      continue;
    }
    foreach(guy in guys) {
      if(!isDefined(guy)) {
        continue;
      }
      if(!isalive(guy)) {
        continue;
      }
      if(istrue(guy._id_389B04AEB955FCB9)) {
        continue;
      }
      if(!istrue(guy._id_61CD763336E9C921))
        guy thread _id_C2529DDAA2040E52();
    }
  }
}

_id_C2529DDAA2040E52() {
  self endon("death");
  _id_A2817BAF9ACCAFB2 = 0;
  self._id_61CD763336E9C921 = 1;
  _id_2AC210AF318CF38B = self.origin;
  _id_75521C641D0D69F7 = _id_2AC210AF318CF38B + (0, 0, 500);

  while(_id_A2817BAF9ACCAFB2 < 5) {
    if(self.origin[2] < _id_75521C641D0D69F7[2] && distance(self.origin, _id_2AC210AF318CF38B) < 1500)
      _id_A2817BAF9ACCAFB2++;

    wait 5;
  }

  self dodamage(self.health + 1000, self.origin);
}

_id_4AD1751DD6EF5881() {
  level endon("game_ended");
  wait 10;
  _id_5A94FBA0FF6C999E = 1000;

  if(isDefined(level._id_5A94FBA0FF6C999E))
    _id_5A94FBA0FF6C999E = level._id_5A94FBA0FF6C999E;

  for(;;) {
    wait 5;
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    if(guys.size == 0) {
      continue;
    }
    foreach(guy in guys) {
      if(!isDefined(guy)) {
        continue;
      }
      if(!isalive(guy)) {
        continue;
      }
      if(guy.origin[2] < _id_5A94FBA0FF6C999E)
        guy dodamage(guy.health + 1000, guy.origin);
    }
  }
}

_id_690BA9393A0059AD() {
  spawnfunc = _id_18A73A64992DD07D::registerambientgroup;
  [[spawnfunc]]("mindia_temp_riotshield_a", 1, 1, 1, 0, 0, "mindia_temp_riotshield", ::watchforstopwaves, undefined, undefined);
  [[spawnfunc]]("mindia_temp_riotshield_b", 1, 1, 1, 0, 0, "mindia_temp_riotshield", ::watchforstopwaves, undefined, undefined);
  [[spawnfunc]]("mindia_temp_riotshield_c", 1, 1, 1, 0, 0, "mindia_temp_riotshield", ::watchforstopwaves, undefined, undefined);
}

_id_2418A46F24F01BD1(_id_800676BBD5453FC0) {
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_800676BBD5453FC0._id_2444B7785351D927);
  _id_F318D96DABD3B489 = spawnStruct();

  if(id == "a")
    _id_F318D96DABD3B489 = _id_18A73A64992DD07D::run_spawn_module("mindia_temp_riotshield_a");
  else if(id == "b")
    _id_F318D96DABD3B489 = _id_18A73A64992DD07D::run_spawn_module("mindia_temp_riotshield_b");
  else if(id == "c")
    _id_F318D96DABD3B489 = _id_18A73A64992DD07D::run_spawn_module("mindia_temp_riotshield_c");

  while(!isDefined(_id_F318D96DABD3B489.ai_spawned) || _id_F318D96DABD3B489.ai_spawned.size == 0)
    wait 0.05;

  _id_AAD1D143095A72E6 = _id_F318D96DABD3B489.ai_spawned[0];

  if(isDefined(_id_AAD1D143095A72E6) && isalive(_id_AAD1D143095A72E6)) {
    _id_C00448D30DF1BEA6 = _id_800676BBD5453FC0._id_2444B7785351D927;
    _id_AAD1D143095A72E6._id_800676BBD5453FC0 = _id_800676BBD5453FC0;
    _id_AAD1D143095A72E6._id_6D3FBC4590EDA90E = 1;
    _id_AAD1D143095A72E6._id_C833409FB72D15FB = 1;
    _id_AAD1D143095A72E6 thread _id_3E19322333AD204C::_id_90B5F7A3A8C60478(_id_C00448D30DF1BEA6);
  }
}

_id_A1DB830A81D5F633(_id_800676BBD5453FC0) {
  level._id_215CD837F06FA79E._id_84FBF9BF3E60B952 = 1;
  level thread _id_0CED1843591E186F(_id_800676BBD5453FC0);
  _id_800676BBD5453FC0 scripts\engine\utility::waittill_any_timeout_1(60, "soldier_found");

  if(isDefined(_id_800676BBD5453FC0._id_5C57B8432636DCF5)) {
    soldier = _id_800676BBD5453FC0._id_5C57B8432636DCF5[0];
    _id_F318D96DABD3B489 = _id_18A73A64992DD07D::run_spawn_module("mindia_temp_riotshield");
    waitframe();
    _id_AAD1D143095A72E6 = _id_F318D96DABD3B489.ai_spawned[0];

    if(isDefined(_id_AAD1D143095A72E6) && isalive(_id_AAD1D143095A72E6)) {
      _id_DF4DE7A06B1089CD = _id_AAD1D143095A72E6.origin;
      _id_B9084AA10AB3B5AF = _id_AAD1D143095A72E6.angles;
      _id_AAD1D143095A72E6 forceteleport(soldier.origin, soldier.angles);
      _id_AAD1D143095A72E6._id_910A3FC61896465B = 1;

      if(isalive(soldier))
        soldier forceteleport(_id_DF4DE7A06B1089CD, _id_B9084AA10AB3B5AF);

      _id_C00448D30DF1BEA6 = _id_800676BBD5453FC0._id_2444B7785351D927;
      _id_AAD1D143095A72E6._id_6D3FBC4590EDA90E = 1;
      _id_AAD1D143095A72E6 thread _id_3E19322333AD204C::_id_90B5F7A3A8C60478(_id_C00448D30DF1BEA6);
      wait 0.1;
      soldier kill();
    }

    waitframe();

    foreach(guy in _id_F318D96DABD3B489.ai_spawned) {
      if(!istrue(guy._id_910A3FC61896465B))
        guy kill();
    }
  }

  level._id_215CD837F06FA79E._id_84FBF9BF3E60B952 = 0;
}

_id_7A84AC3286FBD0D3(origin) {
  level endon("game_ended");
  origin = scripts\engine\utility::drop_to_ground(origin);
  _id_9AF72BBDFDEACE5D = spawn("script_model", origin + (0, 0, 2));
  _id_9AF72BBDFDEACE5D setModel("tag_origin");
  _id_9AF72BBDFDEACE5D show();
  _id_9AF72BBDFDEACE5D.angles = (270, 0, 0);
  wait 0.5;
  playFXOnTag(level._effect["vfx_smokegren_loop"], _id_9AF72BBDFDEACE5D, "tag_origin");
  wait 15;
  stopFXOnTag(level._effect["vfx_smokegren_loop"], _id_9AF72BBDFDEACE5D, "tag_origin");
  wait 1;
  _id_9AF72BBDFDEACE5D delete();
}

_id_0CED1843591E186F(_id_800676BBD5453FC0) {
  wait 1;
  _id_F318D96DABD3B489 = _id_800676BBD5453FC0._id_F318D96DABD3B489;
  wait 10;

  if(!isDefined(_id_F318D96DABD3B489.module_vehicles))
    return undefined;

  vehicle = _id_F318D96DABD3B489.module_vehicles[0];

  if(!isDefined(vehicle))
    return undefined;

  vehicle endon("death");
  vehicle scripts\engine\utility::ent_flag_wait("unloaded");
  wait 1.5;
  _id_800676BBD5453FC0._id_5C57B8432636DCF5 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F318D96DABD3B489.ai_spawned.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(_id_F318D96DABD3B489.ai_spawned[_id_AC0E594AC96AA3A8]) && !isDefined(_id_F318D96DABD3B489.ai_spawned[_id_AC0E594AC96AA3A8].ridingvehicle)) {
      soldier = _id_F318D96DABD3B489.ai_spawned[_id_AC0E594AC96AA3A8];
      _id_800676BBD5453FC0._id_5C57B8432636DCF5 = scripts\engine\utility::array_add(_id_800676BBD5453FC0._id_5C57B8432636DCF5, soldier);
      _id_800676BBD5453FC0 notify("soldier_found");
    }
  }
}

suicide_bomber_combat_func() {
  self endon("death");

  for(;;) {
    _id_F4E34D8FC8416066 = [];

    foreach(player in level.players) {
      if(player scripts\cp\utility::isusingremote()) {
        continue;
      }
      _id_F4E34D8FC8416066[_id_F4E34D8FC8416066.size] = player;
    }

    if(_id_F4E34D8FC8416066.size == 0)
      _id_F4E34D8FC8416066 = level.players;

    _id_5B8DB1F519F9AB09 = scripts\cp\utility::get_closest_living_player(undefined, _id_F4E34D8FC8416066);

    if(isDefined(_id_5B8DB1F519F9AB09))
      self getenemyinfo(_id_5B8DB1F519F9AB09);

    self.bomberusegrenade = 0;

    if(isDefined(self.enemy)) {
      if(isDefined(self.enemy.vehicle_riding_on))
        self.bombertarget = self.enemy.vehicle_riding_on;
      else if(isDefined(_id_5B8DB1F519F9AB09))
        self.bombertarget = _id_5B8DB1F519F9AB09;
      else
        self.bombertarget = undefined;
    }

    wait 1;
  }
}

_id_694A5F3C8FD6A178() {
  thread lbravo_hover_attack_think(self);
}

lbravo_hover_attack_think(vehicle) {
  vehicle endon("death");
  vehicle thread scripts\cp\utility::notify_delay("increase_accuracy", 0.1);
  vehicle thread scripts\cp\utility::notify_delay("hover_attack", 0.1);
  vehicle thread _id_7E1A768E8E5E8D9E();
  vehicle.hover_attack_directions = ["clockwise", "counterclockwise"];

  for(;;) {
    result = vehicle scripts\engine\utility::waittill_any_return_no_endon_death_3("hover_attack", "increase_accuracy", "hover_retreat");
    vehicle.script_vehicle_selfremove = undefined;
    vehicle.dontunloadonend = 1;

    switch (result) {
      case "hover_retreat":
        vehicle.hover_attack_direction = undefined;
        _id_C0C8BDC2370EC1D4 = fly_toward_retreat_struct(vehicle);
        _id_007B1B37DCECB532 = create_circular_path_around(_id_C0C8BDC2370EC1D4.origin, vehicle, 2500, 256, 1, 50, get_random_circle_direction(), 12);
        _id_E780BF8D5663095D = _id_007B1B37DCECB532[0];
        vehicle thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_E780BF8D5663095D);
        break;
      case "hover_attack":
        _id_C2E06D0A5523A7A2 = scripts\engine\utility::getStructArray("defender_hover_heli_marker", "targetname");
        _id_7EB9AB78689E62AB = scripts\engine\utility::getclosest(vehicle.origin, _id_C2E06D0A5523A7A2);
        _id_914E920EE4A75F55 = _id_7EB9AB78689E62AB.origin + (0, 0, 150);
        hover_radius = 3200;

        if(isDefined(_id_7EB9AB78689E62AB.radius))
          hover_radius = int(_id_7EB9AB78689E62AB.radius);

        _id_2AC91D401D9FD359 = create_circular_path_around(_id_914E920EE4A75F55, vehicle, hover_radius, 256, 1, 45, get_hover_attack_direction(vehicle), 12);
        _id_D709F38718C6972A = _id_2AC91D401D9FD359[0];
        vehicle thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_D709F38718C6972A);
        break;
      case "increase_accuracy":
        riders = vehicle.riders;

        foreach(rider in riders) {
          rider.baseaccuracy = 1.0;
          rider.maxfaceenemydist = 8000;
          rider.maxfacenewenemydist = 8000;
          rider.newenemyreactiondistsq = squared(8000);
          rider.maxsightdistsqrd = squared(8000);
          rider _meth_9215CE6FC83759B9(8000);
          rider.ignoreall = 0;
          vehicle thread lbravo_hover_rider_death_monitor(rider, vehicle);
        }

        break;
    }
  }
}

_id_7E1A768E8E5E8D9E() {
  level endon("game_ended");
  self endon("death");
  _id_84F72238BED4055E = self.riders.size;

  while(self.riders.size == _id_84F72238BED4055E)
    wait 0.5;

  self notify("hover_retreat");
}

get_random_circle_direction() {
  return scripts\engine\utility::random(["clockwise", "counterclockwise"]);
}

_id_FA4B2C2C8832EA64(vehicle) {
  _id_C2E06D0A5523A7A2 = scripts\engine\utility::getStructArray("defender_hover_heli_marker", "targetname");
  _id_34FA923C8D78BA0F = scripts\engine\utility::getclosest(vehicle.origin, _id_C2E06D0A5523A7A2);
  _id_B32099A7218A7A69 = _id_34FA923C8D78BA0F.origin;
  _id_6E621390DB45C3F2 = make_fly_struct(_id_B32099A7218A7A69, vehicle.angles, 256, 1, 55);
  vehicle thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_6E621390DB45C3F2);
  vehicle.script_vehicle_selfremove = undefined;
  vehicle.dontunloadonend = 1;
  vehicle scripts\engine\utility::waittill_any_2("near_goal", "goal");
}

fly_toward_retreat_struct(vehicle) {
  _id_C0C8BDC2370EC1D4 = get_target_retreat_struct(vehicle);
  _id_5160014CE4EC2684 = (vehicle.origin + _id_C0C8BDC2370EC1D4.origin) / 2;
  _id_6E621390DB45C3F2 = make_fly_struct(_id_5160014CE4EC2684, vehicle.angles, 256, 50, 1);
  vehicle thread scripts\common\vehicle_paths::vehicle_paths_helicopter(_id_6E621390DB45C3F2);
  vehicle scripts\engine\utility::waittill_any_2("near_goal", "goal");
  return _id_C0C8BDC2370EC1D4;
}

make_fly_struct(position, angles, _id_432421558B8220FC, speed, goalyaw) {
  _id_033F78C8B2EBE782 = spawnStruct();
  _id_033F78C8B2EBE782.origin = position;
  _id_033F78C8B2EBE782.angles = angles;
  _id_033F78C8B2EBE782.radius = _id_432421558B8220FC;
  _id_033F78C8B2EBE782.speed = speed;

  if(istrue(goalyaw))
    _id_033F78C8B2EBE782.script_goalyaw = 1;

  return _id_033F78C8B2EBE782;
}

get_target_retreat_struct(vehicle) {
  _id_A09F8AA2E00AA3C1 = scripts\engine\utility::getStructArray("hover_retreat", "targetname");
  _id_E627E357CF133EAB = -99999;
  _id_568E9927D8245561 = _id_A09F8AA2E00AA3C1[0];
  _id_1E5C3E3065486EA9 = anglesToForward(vehicle.angles);

  foreach(_id_122554D6D2A66784 in _id_A09F8AA2E00AA3C1) {
    _id_7595C3549B2394F3 = vectorNormalize(_id_122554D6D2A66784.origin - vehicle.origin);
    _id_6BD958BBAA5FDFFE = vectordot(_id_7595C3549B2394F3, _id_1E5C3E3065486EA9);

    if(_id_6BD958BBAA5FDFFE > _id_E627E357CF133EAB) {
      _id_E627E357CF133EAB = _id_6BD958BBAA5FDFFE;
      _id_568E9927D8245561 = _id_122554D6D2A66784;
    }
  }

  return _id_568E9927D8245561;
}

lbravo_hover_rider_death_monitor(rider, vehicle) {
  vehicle endon("death");
  rider waittill("death");
  waitframe();
  check_lbravo_hover_retreat(vehicle);
}

check_lbravo_hover_retreat(vehicle) {
  if(!any_rider_still_alive_at_seat(vehicle, [2, 3, 4])) {
    remove_hover_direction_and_try_issue_retreat(vehicle, "counterclockwise");
    return;
  }

  if(!any_rider_still_alive_at_seat(vehicle, [5, 6, 7])) {
    remove_hover_direction_and_try_issue_retreat(vehicle, "clockwise");
    return;
  }
}

remove_hover_direction_and_try_issue_retreat(vehicle, _id_15D3935AEC7E13D7) {
  vehicle.hover_attack_directions = scripts\engine\utility::array_remove(vehicle.hover_attack_directions, _id_15D3935AEC7E13D7);

  if(isDefined(vehicle.hover_attack_direction) && vehicle.hover_attack_direction == _id_15D3935AEC7E13D7)
    vehicle notify("hover_retreat");
}

timed_death(rider) {
  wait(10 + rider.vehicle_position * 2);
  rider dodamage(rider.health + 100, rider.origin);
}

any_rider_still_alive_at_seat(vehicle, _id_B8664495EBE8B207) {
  foreach(_id_4DD1F414CC13B6D5 in _id_B8664495EBE8B207) {
    foreach(rider in vehicle.riders) {
      if(isalive(rider) && isDefined(rider.vehicle_position) && rider.vehicle_position == _id_4DD1F414CC13B6D5)
        return 1;
    }
  }

  return 0;
}

get_hover_attack_direction(vehicle) {
  if(isDefined(vehicle.hover_attack_direction))
    return vehicle.hover_attack_direction;

  result = scripts\engine\utility::random(vehicle.hover_attack_directions);
  vehicle.hover_attack_direction = result;
  return result;
}

create_circular_path_around(_id_914E920EE4A75F55, heli, _id_F31031D371DFB13C, _id_432421558B8220FC, goalyaw, speed, direction, _id_BF5342D9775D472D) {
  _id_8E8726C1AF0A339C = vectorNormalize(heli.origin - _id_914E920EE4A75F55);
  _id_8E8726C1AF0A339C = scripts\engine\utility::flatten_vector(_id_8E8726C1AF0A339C);
  yaw_delta = int(360 / _id_BF5342D9775D472D);
  original_angles = vectortoangles(_id_8E8726C1AF0A339C);

  if(direction == "clockwise")
    yaw_delta = yaw_delta * -1;

  _id_752700679022BA12 = [];

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 <= _id_BF5342D9775D472D; _id_AC0E594AC96AA3A8++) {
    _id_37B788B5F5E40BAD = original_angles + (0, yaw_delta * _id_AC0E594AC96AA3A8, 0);
    _id_65346F73F6B0BABF = make_path_node_on_circular_path(_id_914E920EE4A75F55, _id_37B788B5F5E40BAD, _id_F31031D371DFB13C, _id_432421558B8220FC, goalyaw, speed, direction);

    if(_id_AC0E594AC96AA3A8 == _id_BF5342D9775D472D)
      _id_65346F73F6B0BABF.script_noteworthy = "hover_attack";

    _id_752700679022BA12[_id_752700679022BA12.size] = _id_65346F73F6B0BABF;
  }

  connect_circlar_path(_id_752700679022BA12);
  return _id_752700679022BA12;
}

connect_circlar_path(_id_752700679022BA12) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_752700679022BA12.size - 1; _id_AC0E594AC96AA3A8++) {
    _id_E04BBEB4570E6276 = _id_752700679022BA12[_id_AC0E594AC96AA3A8];
    _id_9CFAE7D0290CCB43 = _id_752700679022BA12[_id_AC0E594AC96AA3A8 + 1];
    _id_E04BBEB4570E6276.target = _id_9CFAE7D0290CCB43.targetname;
    scripts\cp\utility::addtostructarray("target", _id_E04BBEB4570E6276.targetname, _id_9CFAE7D0290CCB43);
  }
}

make_path_node_on_circular_path(_id_914E920EE4A75F55, _id_37B788B5F5E40BAD, _id_F31031D371DFB13C, _id_432421558B8220FC, goalyaw, speed, direction) {
  _id_65346F73F6B0BABF = spawnStruct();
  _id_65346F73F6B0BABF.origin = _id_914E920EE4A75F55 + anglesToForward(_id_37B788B5F5E40BAD) * _id_F31031D371DFB13C;
  _id_65346F73F6B0BABF.radius = _id_432421558B8220FC;
  _id_65346F73F6B0BABF.speed = speed;
  _id_65346F73F6B0BABF.targetname = _id_0E80538EF14D00E1::create_unique_kvp_string();
  scripts\cp\utility::addtostructarray("targetname", _id_65346F73F6B0BABF.targetname, _id_65346F73F6B0BABF);
  _id_FF712E5BB54E5049 = vectortoangles(vectorNormalize(_id_65346F73F6B0BABF.origin - _id_914E920EE4A75F55));

  if(istrue(goalyaw))
    _id_65346F73F6B0BABF.script_goalyaw = 1;

  if(direction == "counterclockwise")
    _id_65346F73F6B0BABF.angles = vectortoangles(anglestoleft(_id_FF712E5BB54E5049));
  else
    _id_65346F73F6B0BABF.angles = vectortoangles(anglestoright(_id_FF712E5BB54E5049));

  return _id_65346F73F6B0BABF;
}

_id_62BBDDE329CBD71D(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_B2883531AFA6B83D) {
  _id_AE4472F81B9C6ABC = 0;

  if(isDefined(sweapon) && isDefined(sweapon.basename)) {
    switch (sweapon.basename) {
      case "cruise_proj_mp":
        _id_AE4472F81B9C6ABC = 1;
        break;
    }
  }

  if(_id_AE4472F81B9C6ABC)
    idamage = self.health;

  if(sweapon.basename == "bunkerbuster_mp")
    idamage = int(idamage * 0.1);

  if(level.script == "cp_lone")
    _id_F4CB78B6036DC664 = level.agent_funcs["actor_enemy_cp_jugg_cartel"]["on_damaged_finished"];
  else
    _id_F4CB78B6036DC664 = level.agent_funcs["actor_enemy_cp_jugg_aq"]["on_damaged_finished"];

  if(isDefined(_id_F4CB78B6036DC664))
    [[_id_F4CB78B6036DC664]](einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, _id_B6F2EA21C3462024, modelindex, partname, _id_B2883531AFA6B83D);
}

_id_14CE3704BCC6E611() {
  level._id_54D403857922C58C = level.agent_funcs["juggernaut"]["on_damaged_finished"];
  level.agent_funcs["juggernaut"]["on_damaged_finished"] = ::_id_62BBDDE329CBD71D;
}