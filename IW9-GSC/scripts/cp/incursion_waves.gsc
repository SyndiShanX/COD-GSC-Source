/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\incursion_waves.gsc
***********************************************/

_id_C07BD2E42BA41BC0() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("wave_spawn_pause");
  level._id_8215AB0BBDA0504F = [];
  level._id_8E6E84BCF72A908F = [];
  scripts\engine\utility::flag_wait("strike_init_done");

  if(!scripts\cp\utility::coop_mode_has("incursion_waves")) {
    return;
  }
  locations = scripts\engine\utility::getStructArray("objective_locations", "targetname");

  if(!isDefined(locations) || locations.size < 1) {
    return;
  }
  _id_324B68CB416ACBEC::main();
  _id_5460CD6692149701::main();
  _id_C0493D69216F6D54();
  _id_A2B11613E4C46ED8 = 0;
  _id_0EA76738101A63A0 = getdvarint("dvar_44F7A86AF84D092C", 0);

  if(_id_0EA76738101A63A0 != 0)
    _id_A2B11613E4C46ED8 = _id_0EA76738101A63A0;

  level._id_AE12ED8FC05422D2 = _id_A2B11613E4C46ED8;
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(isDefined(level._id_61E4080758EA1943))
    _id_6E2CF74C41DE0AFC();

  level thread _id_537A712B2BE3193C::_id_EDBFA2BA7F3B537F();

  for(;;) {
    _id_A2B11613E4C46ED8++;
    _id_0EA76738101A63A0 = getdvarint("dvar_20FDD1881EC96495", 0);

    if(_id_0EA76738101A63A0 != 0)
      _id_A2B11613E4C46ED8 = _id_0EA76738101A63A0;

    level._id_AE12ED8FC05422D2 = _id_A2B11613E4C46ED8;
    level notify("incursion_wave_increase", level._id_AE12ED8FC05422D2);

    if(level._id_AE12ED8FC05422D2 > 1)
      _id_B077E4A328BB9808(30);

    setomnvar("cp_wave_number", _id_A2B11613E4C46ED8);

    foreach(player in level.players)
    player thread scripts\cp\cp_hud_message::showsplash("cp_wave_started", level._id_AE12ED8FC05422D2, undefined);

    _id_577D509CDF72F199(_id_A2B11613E4C46ED8);
    wait 2;

    foreach(player in level.players)
    player thread scripts\cp\cp_hud_message::showsplash("cp_wave_ended", level._id_AE12ED8FC05422D2, undefined);

    _id_520DB2326BE2924E(_id_A2B11613E4C46ED8);
    scripts\engine\utility::flag_waitopen("wave_spawn_pause");
  }
}

_id_B077E4A328BB9808(wait_time) {
  level endon("game_ended");
  level notify("timeout_wave");
  level endon("timeout_wave");
  self endon("death");
  setomnvar("cp_countdown_color", 0);
  _id_E84E755251284EC2 = gettime() + wait_time * 1000;
  setomnvar("cp_wave_timer", int(_id_E84E755251284EC2));

  if(wait_time - 10 > 0) {
    wait(wait_time - 10);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
      setomnvar("cp_countdown_color", 2);
      wait 1;
    }
  }

  setomnvar("cp_wave_timer", 0);
}

_id_7FBEEB5260C6FC5C(group) {
  _id_1E6E19F31783DF76 = _id_912C529627D743D1();

  if(isDefined(_id_1E6E19F31783DF76)) {
    switch (_id_1E6E19F31783DF76) {
      case "commando":
        _id_0AD08E7559FFC20A(group);
        break;
      case "black_ops":
        _id_63B46133C32E3C66(group);
        break;
      default:
        _id_78A6D85F1D5C30AF(group);
        break;
    }
  } else
    _id_8F1F42604EDB1FD9();
}

_id_912C529627D743D1() {
  if(isDefined(self.unittype) && self.unittype == "juggernaut")
    return undefined;

  if(level._id_AE12ED8FC05422D2 >= 15)
    return "black_ops";
  else if(level._id_AE12ED8FC05422D2 >= 10)
    return "commando";
  else if(level._id_AE12ED8FC05422D2 >= 5)
    return "heavy";
  else
    return undefined;

  return undefined;
}

_id_78A6D85F1D5C30AF(group) {
  body = undefined;
  head = undefined;
  weapon = undefined;
  _id_A664AAD02EE98BD2 = undefined;
  armor = 420;
  helmet = undefined;
  _id_CF5350BA9DD03752 = undefined;
  _id_8F1F42604EDB1FD9(body, head, weapon, _id_A664AAD02EE98BD2, armor, helmet, _id_CF5350BA9DD03752);
}

_id_0AD08E7559FFC20A(group) {
  body = "body_mp_milsim_balkan_sf_1_1";
  head = "head_mp_milsim_balkan_sf_1_1";
  weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_ar_mike4_mp", ["thermal", "none", "none", "none", "none", "laserbalanced_mike4"], "none", "none");
  _id_A664AAD02EE98BD2 = "flash_mp";
  armor = 630;
  helmet = 1;
  _id_CF5350BA9DD03752 = undefined;
  _id_8F1F42604EDB1FD9(body, head, weapon, _id_A664AAD02EE98BD2, armor, helmet, _id_CF5350BA9DD03752);
  self.script_forcegrenade = 1;
}

_id_63B46133C32E3C66(group) {
  body = "body_mp_eastern_velikan_1_1";
  head = "head_mp_eastern_velikan_1_1";
  weapon = _id_2669878CF5A1B6BC::buildweapon("iw8_lm_mgolf36_mp", ["thermal", "none", "none", "none", "none", "none"], "none", "none");
  _id_A664AAD02EE98BD2 = "semtex_mp";
  armor = 630;
  helmet = 1;
  _id_CF5350BA9DD03752 = undefined;
  _id_8F1F42604EDB1FD9(body, head, weapon, _id_A664AAD02EE98BD2, armor, helmet, _id_CF5350BA9DD03752);
  self.script_forcegrenade = 1;
  self.accuracy = 0.4;
  self.health = 270;
}

_id_8F1F42604EDB1FD9(body, head, weapon, _id_A664AAD02EE98BD2, armor, helmet, _id_CF5350BA9DD03752) {
  if(isDefined(body))
    self setModel(body);

  if(isDefined(head)) {
    if(isDefined(self.headmodel))
      self detach(self.headmodel);

    self attach(head, "", 1);
    self.headmodel = head;
  }

  if(isDefined(armor)) {
    _id_18A73A64992DD07D::give_soldier_armor();
    self.equip_armor = 1;
    self._id_B5218CF00DAD94EF = armor;
    self.allowpain = 0;
  }

  if(isDefined(helmet))
    _id_18A73A64992DD07D::give_soldier_helmet();

  self.goalradius = 800;

  if(isDefined(weapon)) {
    if(isDefined(self.weapon))
      self takeweapon(self.weapon);

    self.weapon = weapon;
    scripts\common\utility::initweapon(self.weapon);
    self giveweapon(self.weapon);
    self setspawnweapon(self.weapon);
    self.bulletsinclip = weaponclipsize(self.weapon);
    self.primaryweapon = self.weapon;
  }

  if(isDefined(_id_A664AAD02EE98BD2)) {
    self.grenadeweapon = makeweapon(_id_A664AAD02EE98BD2);
    self.grenadeammo = 2;
  }

  thread _id_537A712B2BE3193C::_id_9C0FBE62C1B9D660();
  thread watchchangeweapon();
  _id_38E18AC0E9DFFAF1(_id_CF5350BA9DD03752);
  scripts\engine\utility::delaythread(3, ::_id_130532172349E887);
  thread _id_AD05E00ECE389A29();
  thread _id_596D07FACB536BBC();
  thread update_spawn_data_on_death();
  self.wave_spawn = 1;
  return self;
}

_id_130532172349E887() {
  self._id_98ADD129A7ECB962 = 0;
}

_id_AD05E00ECE389A29() {
  self endon("death");
  wait 2;

  if(isDefined(self.ridingvehicle))
    self.ridingvehicle waittill("unloaded");
}

update_spawn_data_on_death() {
  self endon("stop_death_watcher");
  thread _id_F5C40AB76D02F395();
  msg = scripts\engine\utility::waittill_any_return_2("death", "long_death");

  if(msg == "long_death")
    test = 1;

  if(istrue(self.died_poorly)) {
    return;
  }
  if(isDefined(self.damagemod)) {
    if(self.damagemod == "MOD_SUICIDE")
      return;
  }

  level._id_BAE0FF6D10C1E7D8++;
}

_id_F5C40AB76D02F395() {
  self endon("death");
  self waittill("entervehicle");
  waitframe();

  if(isDefined(self.vehicle_position)) {
    if(self.vehicle_position == 0)
      self notify("stop_death_watcher");

    if(self.vehicle_position == 1)
      self notify("stop_death_watcher");
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

_id_1C225FE307735A4E() {
  level._id_AE12ED8FC05422D2 = level._id_AE12ED8FC05422D2 + 1;

  foreach(player in level.players)
  player thread scripts\cp\cp_hud_message::showsplash("cp_wave_started", level._id_AE12ED8FC05422D2, undefined);

  wait 1;
  setomnvar("cp_wave_number", level._id_AE12ED8FC05422D2);
  wait 2;
  _id_577D509CDF72F199(level._id_AE12ED8FC05422D2);
  _id_520DB2326BE2924E(level._id_AE12ED8FC05422D2);
}

_id_A8029B288749D0D5(_id_72D17CA40FEEC6ED, goalradius, _id_4AA0F44C1A6B235F) {
  position = _id_A4BC93565E7DA7DC();
  _id_D7B44CB498FDACDB = spawnStruct();
  _id_D7B44CB498FDACDB.origin = position;
  _id_D7B44CB498FDACDB.angles = (0, 0, 0);
  _id_FA8A3A54164A0B8A = _id_324B68CB416ACBEC::_id_0DE96B8A387DBE2A(_id_72D17CA40FEEC6ED);

  if(isDefined(_id_4AA0F44C1A6B235F))
    _id_FA8A3A54164A0B8A = _id_4AA0F44C1A6B235F;

  _id_FC9AC45209F959BB = [];
  spawnpoint = _id_5460CD6692149701::_id_9581045871F15252(_id_D7B44CB498FDACDB, 5000, 2000);
  enemies = undefined;

  if(_id_72D17CA40FEEC6ED == "riot")
    enemies = _id_3470AE2EA5D473DB(spawnpoint);
  else
    enemies = _id_A9B9234C0760C45E(spawnpoint, _id_FA8A3A54164A0B8A, goalradius);

  return enemies;
}

_id_3470AE2EA5D473DB(spawnpoint) {
  _id_45C5D4D61773B0B9 = _id_537A712B2BE3193C::_id_43825E7633150BE3("actor_enemy_cp_rus_riotshield", spawnpoint, 0, 128);
  guy1 = _id_537A712B2BE3193C::_id_43825E7633150BE3("actor_enemy_cp_rus_desert_smg", spawnpoint, 1, 128);
  guy2 = _id_537A712B2BE3193C::_id_43825E7633150BE3("actor_enemy_cp_rus_desert_smg", spawnpoint, 1, 128);
  _id_45C5D4D61773B0B9 thread _id_537A712B2BE3193C::_id_9C0FBE62C1B9D660();
  guy1 setgoalentity(_id_45C5D4D61773B0B9, 1000);
  guy2 setgoalentity(_id_45C5D4D61773B0B9, 1000);
  enemies = [_id_45C5D4D61773B0B9, guy1, guy2];

  foreach(guy in enemies)
  guy _id_38E18AC0E9DFFAF1();

  return enemies;
}

_id_38E18AC0E9DFFAF1(_id_DA87F68719E2B303) {
  _id_E6D574E5D6613546(_id_DA87F68719E2B303);
  thread _id_B23E29727CAF4C44();
}

_id_E6D574E5D6613546(_id_DA87F68719E2B303) {
  if(!isDefined(level._id_0603F2855FC89966))
    level._id_0603F2855FC89966 = [];

  key = level._id_AE12ED8FC05422D2;

  if(isDefined(_id_DA87F68719E2B303))
    key = _id_DA87F68719E2B303;

  if(!isDefined(level._id_0603F2855FC89966[key]))
    level._id_0603F2855FC89966[key] = [self];
  else {
    current = level._id_0603F2855FC89966[key];
    level._id_0603F2855FC89966[key] = scripts\engine\utility::array_combine_unique(current, [self]);
  }
}

_id_B23E29727CAF4C44() {
  self waittill("death");

  foreach(key, _id_9BDE88429952EC6F in level._id_0603F2855FC89966) {
    _id_055F75D9F16D814F = undefined;
    removed = undefined;

    foreach(_id_547487A5CD081071 in _id_9BDE88429952EC6F) {
      if(self == _id_547487A5CD081071) {
        removed = 1;

        if(isDefined(_id_055F75D9F16D814F)) {
          _id_055F75D9F16D814F = scripts\engine\utility::array_remove(_id_055F75D9F16D814F, self);
          continue;
        }

        _id_055F75D9F16D814F = scripts\engine\utility::array_remove(_id_9BDE88429952EC6F, self);
      }
    }

    if(isDefined(removed)) {
      if(!isDefined(_id_055F75D9F16D814F) || _id_055F75D9F16D814F.size == 0) {
        level._id_0603F2855FC89966[key] = undefined;
        continue;
      }

      level._id_0603F2855FC89966[key] = _id_055F75D9F16D814F;
    }
  }
}

_id_524C83C2668954EA() {
  org = level.players[0].origin;

  if(!isDefined(level._id_9D8C80DF4FF60185))
    level._id_9D8C80DF4FF60185 = 0;

  if(isalive(level.players[level._id_9D8C80DF4FF60185])) {
    org = level.players[level._id_9D8C80DF4FF60185].origin;
    level._id_9D8C80DF4FF60185 = level._id_9D8C80DF4FF60185 + 1;

    if(!isDefined(level.players[level._id_9D8C80DF4FF60185]))
      level._id_9D8C80DF4FF60185 = 0;
  }

  return org;
}

_id_9C1525E5E9DA73F2(_id_CA8D3101C7736449, _id_CED7BF80F9AB3F87, _id_7905CC64684E4944, _id_93B3F32629D2EC3E, _id_8F5DF84BDE498F90) {
  _id_21B0311D64CADFA2 = 4000;

  if(isDefined(_id_93B3F32629D2EC3E))
    _id_21B0311D64CADFA2 = _id_93B3F32629D2EC3E;

  _id_76C663E82A2008DC = 2500;

  if(isDefined(_id_7905CC64684E4944))
    _id_76C663E82A2008DC = _id_7905CC64684E4944;

  _id_6A3CC2111E30D71D = _id_76C663E82A2008DC * _id_76C663E82A2008DC;
  spawners = [];
  num = 5;

  if(isDefined(_id_8F5DF84BDE498F90))
    num = _id_8F5DF84BDE498F90;

  if(!isDefined(_id_CED7BF80F9AB3F87))
    _id_CED7BF80F9AB3F87 = "wave_spawn_heli";

  _id_8DAA7EF0C0F67DC1 = scripts\engine\utility::getStructArray(_id_CED7BF80F9AB3F87, "targetname");
  org = _id_524C83C2668954EA();
  _id_EECA462CE9F2A320 = sortbydistancecullbyradius(_id_8DAA7EF0C0F67DC1, org, _id_21B0311D64CADFA2);

  if(!isDefined(_id_EECA462CE9F2A320) || _id_EECA462CE9F2A320.size == 0) {
    _id_EECA462CE9F2A320 = sortbydistance(_id_8DAA7EF0C0F67DC1, org);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EECA462CE9F2A320.size; _id_AC0E594AC96AA3A8++) {
      if(!isDefined(_id_EECA462CE9F2A320[_id_AC0E594AC96AA3A8].active)) {
        spawners[spawners.size] = _id_EECA462CE9F2A320[_id_AC0E594AC96AA3A8];

        if(spawners.size > num) {
          break;
        }
      }
    }

    return spawners;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_EECA462CE9F2A320.size; _id_AC0E594AC96AA3A8++) {
    if(distancesquared(org, _id_EECA462CE9F2A320[_id_AC0E594AC96AA3A8].origin) > _id_6A3CC2111E30D71D) {
      spawners[spawners.size] = _id_EECA462CE9F2A320[_id_AC0E594AC96AA3A8];

      if(spawners.size > num) {
        break;
      }
    }
  }

  if(spawners.size > 0)
    spawners = scripts\engine\utility::array_randomize(spawners);
  else
    test = 1;

  return spawners;
}

_id_FD5721A770F0B9C9(_id_3E930A0A758406F3, _id_8A970A4FDD525614, _id_1DBEA318DE624F2E) {
  foreach(spawner in _id_8A970A4FDD525614) {
    spawner.script_noteworthy = _id_3E930A0A758406F3;

    if(isDefined(_id_1DBEA318DE624F2E)) {
      if(issubstr(_id_1DBEA318DE624F2E, "mindia")) {
        spawner.script_function = "mindia8";
        continue;
      }

      spawner.script_function = "lbravo_carrier";
    }
  }
}

timeout_wave(timer) {
  level endon("wave_ended");
  wait(timer);
  level notify("stop_wave");

  if(isDefined(level._id_0603F2855FC89966[level._id_AE12ED8FC05422D2])) {
    foreach(guy in level._id_0603F2855FC89966[level._id_AE12ED8FC05422D2])
    guy _id_18A73A64992DD07D::script_kill_ai();
  }
}

_id_577D509CDF72F199(wave_num) {
  level endon("stop_wave");
  level thread timeout_wave(300);

  if(!isDefined(level._id_0603F2855FC89966))
    level._id_0603F2855FC89966 = [];

  if(!isDefined(level._id_0603F2855FC89966[level._id_AE12ED8FC05422D2]))
    level._id_0603F2855FC89966[level._id_AE12ED8FC05422D2] = [];

  _id_4318643CDA66A61A = ["ground", "paratrooper", "lbravo", "mindia"];
  _id_2C5831BEAC142A62 = ["smg", "ar", "lmg"];
  level.total_spawns = 12;
  level._id_C09A05E4443A256F = 0;
  _id_1A811CF4B557C3C9 = 12;
  level._id_BAE0FF6D10C1E7D8 = 0;
  level._id_F09A19AC00F88108 = [];
  wave_num = wave_num % 5;

  switch (wave_num) {
    case 1:
      _id_2C5831BEAC142A62 = ["smg", "shotgun"];
      break;
    case 2:
      _id_2C5831BEAC142A62 = ["smg", "ar"];
      break;
    case 3:
      _id_2C5831BEAC142A62 = ["smg", "rpg", "ar", "ar"];
      break;
    case 4:
      _id_2C5831BEAC142A62 = ["lmg", "ar"];
      break;
    case 5:
      if(level._id_AE12ED8FC05422D2 < 10) {
        _id_4318643CDA66A61A = ["mindia_jugg_boss"];
        _id_2C5831BEAC142A62 = ["juggernaut"];
        level.total_spawns = 6;
      } else {
        _id_4318643CDA66A61A = ["mindia_jugg_boss"];
        _id_2C5831BEAC142A62 = ["juggernaut"];
        level.total_spawns = 6;
      }

      break;
    case 6:
      _id_2C5831BEAC142A62 = ["smg", "ar"];
      level.total_spawns = level.total_spawns * 1.5;
      break;
    case 7:
      _id_2C5831BEAC142A62 = ["smg", "rpg", "ar", "ar"];
      level.total_spawns = level.total_spawns * 2;
      break;
    case 8:
      _id_2C5831BEAC142A62 = ["lmg"];
      level.total_spawns = level.total_spawns * 2;
      break;
    case 9:
      _id_2C5831BEAC142A62 = ["lmg", "ar"];
      level.total_spawns = level.total_spawns * 2;
      break;
    case 0:
      _id_4318643CDA66A61A = ["mindia_jugg_boss"];
      _id_2C5831BEAC142A62 = ["juggernaut"];
      level.total_spawns = 12;
      break;
    default:
      _id_3E930A0A758406F3 = "lmg";
      break;
  }

  while(level._id_BAE0FF6D10C1E7D8 < level.total_spawns) {
    level._id_C09A05E4443A256F = 0;

    if(isDefined(level._id_0603F2855FC89966[level._id_AE12ED8FC05422D2]))
      level._id_C09A05E4443A256F = level._id_0603F2855FC89966[level._id_AE12ED8FC05422D2].size;

    _id_BBBC0B66AA0597BC = level.total_spawns - level._id_C09A05E4443A256F - level._id_BAE0FF6D10C1E7D8;
    _id_55136654A2E10EDD = _id_1A811CF4B557C3C9 - level._id_C09A05E4443A256F;
    _id_64488AA81D0AAC39 = min(_id_BBBC0B66AA0597BC, _id_55136654A2E10EDD);

    if(_id_64488AA81D0AAC39 > 0) {
      if(_id_64488AA81D0AAC39 < 12) {
        if(scripts\engine\utility::array_contains(_id_4318643CDA66A61A, "mindia"))
          _id_4318643CDA66A61A = scripts\engine\utility::array_remove(_id_4318643CDA66A61A, "mindia");

        if(_id_4318643CDA66A61A.size == 0)
          _id_4318643CDA66A61A[0] = "lbravo";
      }

      _id_2DAEBD1592EF4E3C = scripts\engine\utility::random(_id_4318643CDA66A61A);
      _id_54DA428AD4A96F2E = 3;

      if(level._id_F09A19AC00F88108.size > 0) {
        _id_2DAEBD1592EF4E3C = "ground";
        _id_54DA428AD4A96F2E = level._id_F09A19AC00F88108.size;
      } else {
        switch (_id_2DAEBD1592EF4E3C) {
          case "mindia_jugg_boss":
            _id_54DA428AD4A96F2E = 6;
            break;
          case "mindia_jugg":
            _id_54DA428AD4A96F2E = 1;
            break;
          case "ground":
            _id_54DA428AD4A96F2E = min(_id_64488AA81D0AAC39, 3);
            break;
          case "paratrooper":
            _id_54DA428AD4A96F2E = 6;
            break;
          case "lbravo":
            _id_54DA428AD4A96F2E = 6;
            break;
          case "mindia":
            _id_54DA428AD4A96F2E = 12;
            break;
        }
      }

      if(_id_64488AA81D0AAC39 < _id_54DA428AD4A96F2E) {} else {
        switch (_id_2DAEBD1592EF4E3C) {
          case "ground":
            _id_4AA0F44C1A6B235F = undefined;

            if(level._id_F09A19AC00F88108.size > 0)
              _id_4AA0F44C1A6B235F = level._id_F09A19AC00F88108;

            level._id_1C53F5DE9489EDD5 = _id_54DA428AD4A96F2E;
            _id_94A1F19ADC274198 = _id_54DA428AD4A96F2E;
            _id_6D2BBB090901AD4B(_id_2C5831BEAC142A62, _id_4AA0F44C1A6B235F, _id_94A1F19ADC274198);
            break;
          case "paratrooper":
            _id_FA504167ADED72B7(_id_2C5831BEAC142A62);
            break;
          case "lbravo":
            _id_5FED65420FE0E2F6(_id_2C5831BEAC142A62);
            break;
          case "mindia":
            _id_5C3BA13998974994(_id_2C5831BEAC142A62);
            break;
          case "mindia_jugg":
            _id_DC6162964AC57914(_id_2C5831BEAC142A62);
            break;
          case "mindia_jugg_boss":
            _id_4B2120B98910A4B6(_id_2C5831BEAC142A62);
            break;
          default:
            break;
        }
      }

      wait 5;
      continue;
    }

    wait 5;
  }

  level notify("wave_ended");
}

_id_E3BC33935BAE107F() {
  _id_CC900CB112348987 = ["wave_spawn_heli", "wave_spawn_ground"];
  num = 0;

  foreach(group_name in _id_CC900CB112348987) {
    if(isDefined(level.spawn_module_structs_memory[group_name])) {
      foreach(group in level.spawn_module_structs_memory[group_name])
      num = num + group.totalspawns;
    }

    if(isDefined(level.active_spawn_module_structs[group_name])) {
      foreach(group in level.active_spawn_module_structs[group_name])
      num = num + group.totalspawns;
    }
  }

  return num;
}

_id_613013012FBA0B7A(_id_2C5831BEAC142A62, _id_4AA0F44C1A6B235F) {
  _id_1DBEA318DE624F2E = "wave_spawn_ground";
  _id_3E930A0A758406F3 = "";

  foreach(_id_F7806D4CF24AACD3 in _id_2C5831BEAC142A62)
  _id_3E930A0A758406F3 = _id_3E930A0A758406F3 + (_id_F7806D4CF24AACD3 + " ");

  level.ambientgroups[_id_1DBEA318DE624F2E].spawn_points = _id_9C1525E5E9DA73F2(_id_1DBEA318DE624F2E, "wave_spawn_ground", 1200, 2500, 15);
  _id_50EBF0AC0D810885(level.ambientgroups[_id_1DBEA318DE624F2E].spawn_points);
  _id_FD5721A770F0B9C9(_id_3E930A0A758406F3, level.ambientgroups[_id_1DBEA318DE624F2E].spawn_points, _id_1DBEA318DE624F2E);
  group = _id_18A73A64992DD07D::run_spawn_module(_id_1DBEA318DE624F2E);
  level waittill("group_wave_spawn_ground_post_module_complete");
  return 3;
}

_id_6D2BBB090901AD4B(_id_2C5831BEAC142A62, _id_4AA0F44C1A6B235F, _id_94A1F19ADC274198) {
  _id_1DBEA318DE624F2E = "wave_spawn_ground";
  _id_3E930A0A758406F3 = "";

  foreach(_id_F7806D4CF24AACD3 in _id_2C5831BEAC142A62)
  _id_3E930A0A758406F3 = _id_3E930A0A758406F3 + (_id_F7806D4CF24AACD3 + " ");

  spawners = _id_9C1525E5E9DA73F2(_id_1DBEA318DE624F2E, "wave_spawn_ground", 1200, 2500, 15);

  if(spawners.size < 1)
    return 0;

  _id_B62C52EF1B5E3A49 = 3;

  if(isDefined(_id_94A1F19ADC274198))
    _id_B62C52EF1B5E3A49 = _id_94A1F19ADC274198;

  _id_9ED4B6B42FD80C8E = _id_AC3679951B7689C3(spawners, _id_3E930A0A758406F3, _id_B62C52EF1B5E3A49);
  return _id_9ED4B6B42FD80C8E;
}

_id_FA504167ADED72B7(_id_2C5831BEAC142A62, _id_4AA0F44C1A6B235F) {
  _id_1DBEA318DE624F2E = "wave_spawn_heli";
  _id_DCE8057401C9C502 = _id_9C1525E5E9DA73F2(_id_1DBEA318DE624F2E);
  spawn_point = scripts\engine\utility::random(_id_DCE8057401C9C502);
  _id_3E930A0A758406F3 = "";

  foreach(_id_F7806D4CF24AACD3 in _id_2C5831BEAC142A62) {
    if(level._id_AE12ED8FC05422D2 > 10)
      _id_F7806D4CF24AACD3 = _id_F7806D4CF24AACD3 + "_heavy";

    _id_3E930A0A758406F3 = _id_3E930A0A758406F3 + (_id_F7806D4CF24AACD3 + " ");
  }

  _id_EE13026B48E61129 = [];
  _id_3C6BEC636AC35DF8 = [-100, 0, 100];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 3; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 3; _id_AC0E5C4AC96AAA41++) {
      offset = (_id_3C6BEC636AC35DF8[_id_AC0E594AC96AA3A8], _id_3C6BEC636AC35DF8[_id_AC0E5C4AC96AAA41], 0);
      _id_1BDC9C3696CABF65 = spawnStruct();
      _id_1BDC9C3696CABF65.origin = spawn_point.origin + offset;
      _id_1BDC9C3696CABF65.targetname = "wave_spawn_paratrooper";
      _id_1BDC9C3696CABF65.script_noteworthy = _id_3E930A0A758406F3;
      _id_EE13026B48E61129[_id_EE13026B48E61129.size] = _id_1BDC9C3696CABF65;
    }
  }

  level.ambientgroups["wave_spawn_paratrooper"].spawn_points = _id_EE13026B48E61129;
  _id_4A9976569F7B0D6A = scripts\engine\utility::getStruct("ac130_spawn_loc", "targetname");
  group = scripts\cp\cp_aiparachute::request_paratroopers("wave_spawn_paratrooper", undefined, _id_4A9976569F7B0D6A.origin, _id_EE13026B48E61129);
  return 6;
}

_id_5C3BA13998974994(_id_2C5831BEAC142A62) {
  _id_1DBEA318DE624F2E = "wave_spawn_heli_mindia";
  _id_3E930A0A758406F3 = "";

  foreach(_id_F7806D4CF24AACD3 in _id_2C5831BEAC142A62)
  _id_3E930A0A758406F3 = _id_3E930A0A758406F3 + (_id_F7806D4CF24AACD3 + " ");

  spawners = _id_9C1525E5E9DA73F2(_id_1DBEA318DE624F2E);

  if(spawners.size < 1)
    return 0;

  _id_FD5721A770F0B9C9(_id_3E930A0A758406F3, spawners, _id_1DBEA318DE624F2E);
  _id_E1422566503D1E2F = spawners[0];
  heli = _id_C7B33824109D7C39(_id_E1422566503D1E2F);

  if(isDefined(heli)) {
    _id_B62C52EF1B5E3A49 = 12;
    _id_9ED4B6B42FD80C8E = heli _id_D0E3FC0F5E612280(_id_E1422566503D1E2F, _id_3E930A0A758406F3, _id_B62C52EF1B5E3A49);
    return _id_9ED4B6B42FD80C8E;
  }

  return 0;
}

_id_4B2120B98910A4B6(_id_2C5831BEAC142A62) {
  _id_1DBEA318DE624F2E = "wave_spawn_heli_mindia_jugg_boss";
  _id_3E930A0A758406F3 = "";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
    _id_F7806D4CF24AACD3 = "ar";
    _id_3E930A0A758406F3 = _id_3E930A0A758406F3 + (_id_F7806D4CF24AACD3 + " ");
  }

  _id_3E930A0A758406F3 = _id_3E930A0A758406F3 + "juggernaut ";
  spawners = _id_9C1525E5E9DA73F2(_id_1DBEA318DE624F2E);

  if(spawners.size < 1)
    return 0;

  _id_FD5721A770F0B9C9(_id_3E930A0A758406F3, spawners, _id_1DBEA318DE624F2E);
  _id_E1422566503D1E2F = spawners[0];
  heli = _id_C7B33824109D7C39(_id_E1422566503D1E2F);

  if(isDefined(heli)) {
    _id_B62C52EF1B5E3A49 = 6;
    _id_9ED4B6B42FD80C8E = heli _id_D0E3FC0F5E612280(_id_E1422566503D1E2F, _id_3E930A0A758406F3, _id_B62C52EF1B5E3A49);
    return _id_9ED4B6B42FD80C8E;
  }

  return 0;
}

_id_5FED65420FE0E2F6(_id_2C5831BEAC142A62) {
  _id_1DBEA318DE624F2E = "wave_spawn_heli";
  _id_3E930A0A758406F3 = "";

  foreach(_id_F7806D4CF24AACD3 in _id_2C5831BEAC142A62)
  _id_3E930A0A758406F3 = _id_3E930A0A758406F3 + (_id_F7806D4CF24AACD3 + " ");

  spawners = _id_9C1525E5E9DA73F2(_id_1DBEA318DE624F2E);

  if(spawners.size < 1)
    return 0;

  _id_FD5721A770F0B9C9(_id_3E930A0A758406F3, spawners, _id_1DBEA318DE624F2E);
  _id_E1422566503D1E2F = spawners[0];
  heli = _id_C7B33824109D7C39(_id_E1422566503D1E2F);

  if(isDefined(heli)) {
    _id_B62C52EF1B5E3A49 = 6;
    _id_9ED4B6B42FD80C8E = heli _id_D0E3FC0F5E612280(_id_E1422566503D1E2F, _id_3E930A0A758406F3, _id_B62C52EF1B5E3A49);
    return _id_9ED4B6B42FD80C8E;
  }

  return 0;
}

_id_1DEAABEC65389CB3(_id_2C5831BEAC142A62, _id_4AA0F44C1A6B235F) {
  _id_1DBEA318DE624F2E = "wave_spawn_heli";
  _id_3E930A0A758406F3 = "";

  foreach(_id_F7806D4CF24AACD3 in _id_2C5831BEAC142A62) {
    if(level._id_AE12ED8FC05422D2 > 10)
      _id_F7806D4CF24AACD3 = _id_F7806D4CF24AACD3 + "_heavy";

    _id_3E930A0A758406F3 = _id_3E930A0A758406F3 + (_id_F7806D4CF24AACD3 + " ");
  }

  level.ambientgroups[_id_1DBEA318DE624F2E].spawn_points = _id_9C1525E5E9DA73F2(_id_1DBEA318DE624F2E);
  _id_50EBF0AC0D810885(level.ambientgroups[_id_1DBEA318DE624F2E].spawn_points);
  _id_FD5721A770F0B9C9(_id_3E930A0A758406F3, level.ambientgroups[_id_1DBEA318DE624F2E].spawn_points, _id_1DBEA318DE624F2E);
  group = _id_18A73A64992DD07D::run_spawn_module(_id_1DBEA318DE624F2E);
  level waittill("group_" + _id_1DBEA318DE624F2E + "_post_module_complete");
  return 6;
}

_id_C7B33824109D7C39(_id_E1422566503D1E2F) {
  success = _id_E1422566503D1E2F _id_18A73A64992DD07D::spawn_vehicle_at_vehicle_spawner();

  if(success)
    return _id_E1422566503D1E2F.vehicle;

  return undefined;
}

_id_AC3679951B7689C3(_id_2353898E4D6F348F, _id_3E930A0A758406F3, _id_B62C52EF1B5E3A49) {
  _id_3E930A0A758406F3 = strtok(_id_3E930A0A758406F3, " ");
  _id_FA8A3A54164A0B8A = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B62C52EF1B5E3A49; _id_AC0E594AC96AA3A8++) {
    index = _id_AC0E594AC96AA3A8 % _id_3E930A0A758406F3.size;
    _id_FA8A3A54164A0B8A[_id_FA8A3A54164A0B8A.size] = _id_3E930A0A758406F3[index];
  }

  _id_9ED4B6B42FD80C8E = spawn_ai_group(_id_B62C52EF1B5E3A49, _id_FA8A3A54164A0B8A, _id_2353898E4D6F348F);
  return _id_9ED4B6B42FD80C8E;
}

_id_D0E3FC0F5E612280(spawnpoint, _id_3E930A0A758406F3, _id_B62C52EF1B5E3A49) {
  _id_3E930A0A758406F3 = strtok(_id_3E930A0A758406F3, " ");
  _id_6398F42A6D3E046C = 2;
  _id_FA8A3A54164A0B8A = ["smg", "smg"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B62C52EF1B5E3A49; _id_AC0E594AC96AA3A8++) {
    index = _id_AC0E594AC96AA3A8 % _id_3E930A0A758406F3.size;
    _id_FA8A3A54164A0B8A[_id_FA8A3A54164A0B8A.size] = _id_3E930A0A758406F3[index];
  }

  _id_B62C52EF1B5E3A49 = _id_B62C52EF1B5E3A49 + _id_6398F42A6D3E046C;
  _id_2353898E4D6F348F = [spawnpoint];
  _id_9ED4B6B42FD80C8E = spawn_ai_group(_id_B62C52EF1B5E3A49, _id_FA8A3A54164A0B8A, _id_2353898E4D6F348F);

  if(_id_9ED4B6B42FD80C8E > _id_6398F42A6D3E046C)
    return _id_9ED4B6B42FD80C8E - _id_6398F42A6D3E046C;
  else
    return 0;
}

spawn_ai_group(_id_B62C52EF1B5E3A49, _id_FA8A3A54164A0B8A, _id_2353898E4D6F348F) {
  spawned = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_B62C52EF1B5E3A49; _id_AC0E594AC96AA3A8++) {
    _id_2B3FE0E3FB0CD248 = _id_FAA64720475B9142(_id_FA8A3A54164A0B8A, _id_AC0E594AC96AA3A8);
    _id_A56471A195BC47AD = _id_AC0E594AC96AA3A8 % _id_2353898E4D6F348F.size;
    spawnpoint = _id_2353898E4D6F348F[_id_A56471A195BC47AD];
    soldier = spawnpoint _id_18A73A64992DD07D::spawn_ai(undefined, undefined, _id_2B3FE0E3FB0CD248);

    if(isDefined(soldier)) {
      soldier.dontkilloff = 1;
      soldier.aitype = _id_FA8A3A54164A0B8A[_id_AC0E594AC96AA3A8];
      spawned[spawned.size] = soldier;
      soldier.spawnpoint = spawnpoint;
      spawnpoint notify("spawn_success", spawnpoint);
      level notify("spawned_group_soldier", soldier);
      level notify("ai_spawn_successful", soldier, spawnpoint, spawnpoint.origin);
      soldier _id_68FA6B4EE60216AE::init();
      soldier thread _id_7FBEEB5260C6FC5C();
      soldier _id_9742A64AF2D2EA49(spawnpoint);
    }

    wait 0.1;
  }

  if(spawned.size)
    return spawned.size;

  return 0;
}

_id_9742A64AF2D2EA49(spawnpoint) {
  self endon("death");
  _id_18A73A64992DD07D::node_fields_pre_goal(spawnpoint);
  thread _id_18A73A64992DD07D::_id_05D96B05A065564E();
  _id_0C11D6400BA31ED7::addtosquad();
  spawnpoint _id_18A73A64992DD07D::_id_EC648F2C89EA1C91();
  _id_18A73A64992DD07D::_id_389FFF85C076F49E();
  _id_18A73A64992DD07D::_id_00B395044780AAC4();
  _id_18A73A64992DD07D::_id_B34ED4EAFA93C760();

  if(isDefined(spawnpoint.script_function)) {
    if(isDefined(level.spawner_script_funcs[spawnpoint.script_function]) && isDefined(spawnpoint.ai_infil_type))
      self[[level.spawner_script_funcs[spawnpoint.script_function].script_function]](undefined, spawnpoint, spawnpoint.ai_infil_type);
  }

  if(isDefined(spawnpoint.target))
    thread _id_18A73A64992DD07D::enter_combat_after_go_to_node();
  else
    thread _id_18A73A64992DD07D::enter_combat();

  spawnpoint.aitype = undefined;
  return 1;
}

_id_FAA64720475B9142(_id_FA8A3A54164A0B8A, index) {
  type = _id_FA8A3A54164A0B8A[index];

  if(level._id_AE12ED8FC05422D2 > 5) {
    switch (type) {
      case "riotshield":
        break;
      case "juggernaut":
        break;
      default:
        type = type + "_heavy";
    }
  }

  return type;
}

_id_90186A2E3F2E6435(_id_2C5831BEAC142A62, _id_4AA0F44C1A6B235F) {
  _id_1DBEA318DE624F2E = "wave_spawn_heli_mindia";
  _id_3E930A0A758406F3 = "";

  foreach(_id_F7806D4CF24AACD3 in _id_2C5831BEAC142A62) {
    if(level._id_AE12ED8FC05422D2 > 10)
      _id_F7806D4CF24AACD3 = _id_F7806D4CF24AACD3 + "_heavy";

    _id_3E930A0A758406F3 = _id_3E930A0A758406F3 + (_id_F7806D4CF24AACD3 + " ");
  }

  level.ambientgroups[_id_1DBEA318DE624F2E].spawn_points = _id_9C1525E5E9DA73F2(_id_1DBEA318DE624F2E);
  _id_50EBF0AC0D810885(level.ambientgroups[_id_1DBEA318DE624F2E].spawn_points);
  _id_FD5721A770F0B9C9(_id_3E930A0A758406F3, level.ambientgroups[_id_1DBEA318DE624F2E].spawn_points, _id_1DBEA318DE624F2E);
  group = _id_18A73A64992DD07D::run_spawn_module(_id_1DBEA318DE624F2E);
  return 12;
}

_id_DC6162964AC57914(_id_2C5831BEAC142A62, _id_4AA0F44C1A6B235F) {
  _id_1DBEA318DE624F2E = "wave_spawn_heli_mindia_jugg";
  _id_3E930A0A758406F3 = "";
  spawners = _id_9C1525E5E9DA73F2(_id_1DBEA318DE624F2E);
  _id_FD5721A770F0B9C9(_id_3E930A0A758406F3, spawners, _id_1DBEA318DE624F2E);
  group = _id_18A73A64992DD07D::run_spawn_module(_id_1DBEA318DE624F2E);
  _id_50EBF0AC0D810885(spawners);
  return 1;
}

_id_C7C757A184734BB7(_id_2C5831BEAC142A62, _id_4AA0F44C1A6B235F) {
  _id_1DBEA318DE624F2E = "wave_spawn_heli_mindia_jugg_boss";
  _id_3E930A0A758406F3 = "";
  spawners = _id_9C1525E5E9DA73F2(_id_1DBEA318DE624F2E);
  _id_FD5721A770F0B9C9(_id_3E930A0A758406F3, spawners, _id_1DBEA318DE624F2E);

  foreach(spawner in spawners) {
    spawner.spawn_aitype_counts["ar"] = 7;
    spawner.spawn_aitype_counts["juggernaut"] = 1;
  }

  level.ambientgroups[_id_1DBEA318DE624F2E].spawn_points = spawners;
  level.ambientgroups[_id_1DBEA318DE624F2E].spawn_aitype_counts["juggernaut"] = 1;
  level.ambientgroups[_id_1DBEA318DE624F2E].spawn_aitype_counts["ar"] = 7;
  group = _id_18A73A64992DD07D::run_spawn_module(_id_1DBEA318DE624F2E);
  wait 5;
  return 6;
}

_id_50EBF0AC0D810885(spawners) {
  foreach(spawner in spawners)
  spawner.spawn_aitype_counts = undefined;
}

_id_91E608317EB58EB2() {
  locations = scripts\engine\utility::getStructArray("objective_locations", "targetname");
  _id_DACE4B70DF8D5F18 = scripts\cp\utility::get_center_point_of_array(level.players);
  _id_DFDD438871090D04 = sortbydistance(locations, _id_DACE4B70DF8D5F18);

  if(distance(_id_DFDD438871090D04[2].origin, _id_DACE4B70DF8D5F18) > 3000)
    pos = scripts\engine\utility::random([_id_DFDD438871090D04[2], _id_DFDD438871090D04[3]]);
  else
    pos = _id_DFDD438871090D04[_id_DFDD438871090D04.size - 1];

  if(isDefined(level._id_8215AB0BBDA0504F) && level._id_8215AB0BBDA0504F.size > 0)
    pos = scripts\engine\utility::random(level._id_8215AB0BBDA0504F);

  return pos;
}

_id_5871DEB0FE55DEFD(spawnpoint) {
  aitype = "actor_enemy_cp_dog";
  ai = _id_537A712B2BE3193C::_id_43825E7633150BE3(aitype, spawnpoint, 0);

  if(isDefined(ai)) {
    if(_id_537A712B2BE3193C::_id_0578D89786B7EDA1())
      ai scripts\engine\utility::delaythread(1, _id_537A712B2BE3193C::_id_3BA1A006F4DE9686);
    else
      ai thread _id_537A712B2BE3193C::_id_9C0FBE62C1B9D660();

    ai _id_38E18AC0E9DFFAF1();
    return ai;
  }

  return undefined;
}

_id_A9B9234C0760C45E(spawnpoint, _id_FA8A3A54164A0B8A, goalradius) {
  spawned = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FA8A3A54164A0B8A.size; _id_AC0E594AC96AA3A8++) {
    type = _id_FA8A3A54164A0B8A[_id_AC0E594AC96AA3A8];
    aitype = "actor_enemy_cp_alq_desert_" + type;

    if(level._id_AE12ED8FC05422D2 >= 10) {
      _id_0439B78048A60675 = "actor_enemy_cp_rus_desert_";

      if(type == "ar")
        type = "ar_ak";

      switch (type) {
        case "riotshield":
          aitype = "actor_enemy_cp_rus_riotshield";
          break;
        case "juggernaut":
          aitype = "actor_enemy_cp_rus_juggernaut";
          break;
        default:
          aitype = _id_0439B78048A60675 + type;
      }
    }

    ai = _id_537A712B2BE3193C::_id_43825E7633150BE3(aitype, spawnpoint, 0);

    if(isDefined(ai)) {
      spawned[spawned.size] = ai;
      ai.spawnpoint = spawnpoint;
      ai.aitype = type;
      ai _id_38E18AC0E9DFFAF1();
      ai _id_7FBEEB5260C6FC5C();
      thread _id_9742A64AF2D2EA49(undefined, ai, spawnpoint);
    }

    waitframe();
  }

  if(spawned.size)
    return spawned;

  return undefined;
}

_id_6EDF7E31CA183BB8() {
  self.dontkilloff = 1;
  wait 2;
  self.dontkilloff = undefined;
}

_id_C0493D69216F6D54() {
  _id_18A73A64992DD07D::registerambientgroup("wave_spawn_heli", 0, 8, 8, 0.1, 0, "wave_spawn_heli", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("wave_spawn_heli", ::_id_7FBEEB5260C6FC5C);
  _id_18A73A64992DD07D::registerambientgroup("wave_spawn_heli_mindia", 0, 14, 14, 0.1, 0, "wave_spawn_heli", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("wave_spawn_heli_mindia", ::_id_7FBEEB5260C6FC5C);
  _id_18A73A64992DD07D::registerambientgroup("wave_spawn_heli_mindia_jugg", 3, 3, 3, 0.1, 0, "wave_spawn_heli", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("wave_spawn_heli_mindia_jugg", ::_id_7FBEEB5260C6FC5C);
  _id_18A73A64992DD07D::registerambientgroup("wave_spawn_heli_mindia_jugg_boss", 8, 8, 8, 0.1, 0, "wave_spawn_heli", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("wave_spawn_heli_mindia_jugg_boss", ::_id_7FBEEB5260C6FC5C);
  _id_18A73A64992DD07D::registerambientgroup("wave_spawn_paratrooper", 0, 6, 6, 1, 0, "wave_spawn_paratrooper", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("wave_spawn_paratrooper", ::_id_7FBEEB5260C6FC5C);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("wave_spawn_heli", undefined, 20000, 30000);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("wave_spawn_heli_mindia", undefined, 20000, 30000);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("wave_spawn_heli_mindia_jugg", undefined, 20000, 30000);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("wave_spawn_heli_mindia_jugg_boss", undefined, 20000, 30000);
  _id_18A73A64992DD07D::set_spawn_scoring_params_for_group("wave_spawn_paratrooper", undefined, 20000, 30000);
  level._id_432E8D8D2B997226 = [];
  level._id_432E8D8D2B997226["wave_spawn_heli"] = ::_id_3B5824A062991C2E;
  _id_18A73A64992DD07D::registerambientgroup("wave_spawn_ground", ::_id_DB68FE3EDA64CC58, ::_id_DB68FE3EDA64CC58, ::_id_DB68FE3EDA64CC58, 0.1, 0, "wave_spawn_ground", undefined, undefined, undefined);
  _id_18A73A64992DD07D::register_module_ai_spawn_func("wave_spawn_ground", ::_id_7FBEEB5260C6FC5C);
}

_id_3B5824A062991C2E() {
  _id_DCE8057401C9C502 = _id_9C1525E5E9DA73F2(undefined, "wave_spawn_ground");
  return _id_DCE8057401C9C502;
}

_id_DB68FE3EDA64CC58(group) {
  if(level._id_F09A19AC00F88108.size > 0)
    return level._id_F09A19AC00F88108.size;

  if(isDefined(level._id_1C53F5DE9489EDD5))
    return level._id_1C53F5DE9489EDD5;

  return 3;
}

_id_596D07FACB536BBC() {
  self endon("death");
  dist = 1800;
  _id_ABD9EE4725B96FC2 = dist * dist;
  far_dist = 2400;
  far_dist_sq = far_dist * far_dist;
  _id_A888435E0D19392D = 3400;
  _id_45FAFAE5D6358B8A = _id_A888435E0D19392D * _id_A888435E0D19392D;
  self.goalradius = 32;
  self._id_676F66FEC9E74526 = "get_closer";

  for(;;) {
    enemy = level.players[0];

    if(!enemy scripts\cp\utility::is_valid_player()) {
      if(isDefined(level.players[1]))
        enemy = level.players[1];
    }

    if(isDefined(self.enemy))
      enemy = self.enemy;

    if(!isDefined(enemy)) {
      wait 1;
      continue;
    }

    if(istrue(self.playing_skit)) {
      wait 1;
      continue;
    }

    if(self._id_676F66FEC9E74526 == "get_closer_fast") {
      self.goalradius = 32;
      self.scripted_mode = 1;
      _id_18A73A64992DD07D::set_demeanor_from_unittype("sprint");

      if(distancesquared(self.origin, enemy.origin) > far_dist_sq)
        self setgoalpos(enemy.origin);
      else {
        self._id_676F66FEC9E74526 = "get_closer";
        self setgoalpos(self.origin);
      }
    } else if(self._id_676F66FEC9E74526 == "get_closer") {
      self.goalradius = 32;
      self.scripted_mode = 1;
      _id_18A73A64992DD07D::set_demeanor_from_unittype("combat");

      if(distancesquared(self.origin, enemy.origin) > _id_ABD9EE4725B96FC2)
        self setgoalpos(enemy.origin);
      else {
        self._id_676F66FEC9E74526 = "close_enough";
        self setgoalpos(self.origin);
      }
    } else {
      self.goalradius = 1500;
      self.scripted_mode = 0;
      _id_34FA6C6B9E4FF7B7 = distancesquared(self.origin, enemy.origin);

      if(_id_34FA6C6B9E4FF7B7 > _id_45FAFAE5D6358B8A)
        self._id_676F66FEC9E74526 = "get_closer_fast";
      else if(_id_34FA6C6B9E4FF7B7 > far_dist_sq)
        self._id_676F66FEC9E74526 = "get_closer";
    }

    wait 1;
  }
}

_id_FDAC8F6F00E7C3F2(loc) {
  level._id_8215AB0BBDA0504F = scripts\engine\utility::array_add_safe(level._id_8215AB0BBDA0504F, loc);
  level._id_8E6E84BCF72A908F = scripts\engine\utility::array_add_safe(level._id_8E6E84BCF72A908F, loc);
}

_id_AFDE497917CEF48D(loc) {
  level._id_8215AB0BBDA0504F = scripts\engine\utility::array_remove(level._id_8215AB0BBDA0504F, loc);
}

_id_C1DC7A1D01595216() {
  _id_79B7318806EA4CAD = _id_A4BC93565E7DA7DC();
  _id_3B2AFD27AAA6AE6F = level._id_8215AB0BBDA0504F;

  if(!_id_3B2AFD27AAA6AE6F.size)
    return undefined;

  return scripts\engine\utility::getclosest(_id_79B7318806EA4CAD, _id_3B2AFD27AAA6AE6F);
}

_id_A4BC93565E7DA7DC() {
  if(!isDefined(level._id_B7BD3EB1E94AE8C0))
    level._id_B7BD3EB1E94AE8C0 = level.players[0];
  else {
    foreach(player in level.players) {
      if(player == level._id_B7BD3EB1E94AE8C0) {
        continue;
      }
      if(player scripts\cp\utility::is_valid_player())
        level._id_B7BD3EB1E94AE8C0 = player;
    }
  }

  return level._id_B7BD3EB1E94AE8C0.origin;
}

_id_6E2CF74C41DE0AFC() {
  [[level._id_61E4080758EA1943]]();
}

_id_5775B1927FD651C4(_id_FA8A3A54164A0B8A, _id_DAD689C3E036D1B3, _id_6BC06A9511457A26, _id_A0DD548B766B2E74) {
  position = _id_91E608317EB58EB2();
  spawnpoint = _id_5460CD6692149701::_id_9581045871F15252(position, 5000, 3000);

  if(!isDefined(_id_FA8A3A54164A0B8A))
    _id_FA8A3A54164A0B8A = _id_324B68CB416ACBEC::_id_0DE96B8A387DBE2A("ar_smg");

  enemies = _id_A9B9234C0760C45E(spawnpoint, _id_FA8A3A54164A0B8A, 800);

  if(!isDefined(_id_DAD689C3E036D1B3))
    _id_DAD689C3E036D1B3 = 1;

  if(istrue(_id_A0DD548B766B2E74))
    _id_537A712B2BE3193C::_id_E4F3059610095250(enemies, 1);
}

_id_520DB2326BE2924E(wave_num) {
  if(isDefined(level._id_62ED34C7E289D568))
    [[level._id_62ED34C7E289D568]](wave_num);
}