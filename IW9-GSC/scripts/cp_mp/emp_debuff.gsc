/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\emp_debuff.gsc
***********************************************/

emp_debuff_init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "init")]]();
}

apply_emp(attacker, objweapon) {
  data = spawnStruct();
  data.attacker = attacker;
  data.victim = self;
  data.objweapon = objweapon;
  apply_emp_struct(data);
}

_id_662905D3B9455612(data, time, _id_D5C235D554645BBC) {
  if(istrue(level.gameended)) {
    return;
  }
  if(!isDefined(time) || time <= 0)
    time = 6.0;

  _id_EC826393F0C6FDB3 = 0;

  if(istrue(_id_D5C235D554645BBC) && data.victim scripts\cp_mp\vehicles\vehicle::isvehicle() && data.victim _id_7D6C1037F26DDB70())
    _id_EC826393F0C6FDB3 = 1;

  if(_id_EC826393F0C6FDB3)
    _id_084FF119FBCAF315(data);

  apply_emp_struct(data);
  _id_1B1D64A1CC52AAB5(data, time);

  if(isDefined(data.victim)) {
    if(_id_EC826393F0C6FDB3)
      _id_9100ACF46355B9C2(data);
    else
      data.victim remove_emp();
  } else if(isDefined(data._id_51C985754E08A199))
    _id_EB40C1291F724432(data);
}

_id_7D6C1037F26DDB70() {
  if(scripts\cp_mp\vehicles\vehicle::_id_2A503318E000E11D()) {
    if(self.vehiclename == "pac_sentry" || self.vehiclename == "radar_drone_recon" || self.vehiclename == "assault_drone")
      return 1;
    else
      return 0;
  } else
    return 1;
}

_id_9100ACF46355B9C2(data) {
  driver = data._id_51C985754E08A199;
  empcount = data.victim _id_322B9832295246C2();

  if(istrue(data._id_9159D29EDCDDBF2E) || empcount <= 1 || istrue(data.victim.isdestroyed)) {
    data.victim clear_emp();

    if(isDefined(driver))
      _id_EB40C1291F724432(data);
  } else
    data.victim remove_emp();
}

_id_EB40C1291F724432(data) {
  data._id_51C985754E08A199 setclientomnvar("ui_emp_button_combo_show", 0);
  data._id_51C985754E08A199 = undefined;
}

_id_084FF119FBCAF315(data) {
  vehicle = data.victim;
  _id_A06496F878B6F340 = ["death", "buttonComboSuccess", "buttonComboReplaced", "buttonComboEarlyExit"];

  if(data.victim is_empd())
    _id_9CDF5E46CECEFB7F(data);

  if(isDefined(vehicle.helperdronetype))
    _id_A06496F878B6F340 = scripts\engine\utility::array_add(_id_A06496F878B6F340, "drone_exit");
  else if(vehicle scripts\cp_mp\vehicles\vehicle::_id_2A503318E000E11D() && vehicle.vehiclename == "pac_sentry")
    _id_A06496F878B6F340 = scripts\engine\utility::array_add(_id_A06496F878B6F340, "leaving_control");
  else {
    _id_A06496F878B6F340 = scripts\engine\utility::_id_EF4B3DF86351AA00(_id_A06496F878B6F340, ["vehicle_owner_update", "driver_exit"], 0);
    data._id_12482C5B5B258CDF = 1;
  }

  data thread _id_70EAF1A1ACA6A06C(_id_A06496F878B6F340);
}

_id_9CDF5E46CECEFB7F(data) {
  level endon("game_ended");
  data.victim endon("death");
  data.victim notify("buttonComboReplaced");
  waitframe();
}

_id_70EAF1A1ACA6A06C(_id_A06496F878B6F340) {
  self.victim endon("emp_cleared");
  self.victim notify("buttonComboStarted");
  self.victim endon("buttonComboStarted");
  driver = undefined;

  if(!istrue(self._id_12482C5B5B258CDF)) {
    driver = self.victim.owner;
    driver endon("disconnect");
  }

  childthread _id_D5EA7C13A646E507();

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(self.victim)) {
      break;
    }

    if(istrue(self._id_12482C5B5B258CDF) || istrue(self.victim.ispiloted)) {
      if(istrue(self._id_12482C5B5B258CDF)) {
        driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self.victim);

        if(isDefined(driver))
          childthread _id_03E29189F38A017D(self.victim, driver);
      }

      if(isDefined(driver)) {
        _id_35AB2DABE0210D0F = _id_BCDA60626641C653(driver, _id_A06496F878B6F340);

        if(!istrue(_id_35AB2DABE0210D0F)) {
          break;
        }
      } else
        waitframe();

      continue;
    }

    wait 0.1;
  }
}

_id_BCDA60626641C653(driver, _id_A06496F878B6F340) {
  self._id_51C985754E08A199 = driver;
  self._id_51C985754E08A199 setclientomnvar("ui_emp_button_combo_show", 1);
  childthread _id_28045A145366E0C5();
  childthread _id_F552430DC0F43D18(self._id_51C985754E08A199);
  childthread _id_E86117E40BD6EE1F();
  msg = self.victim scripts\engine\utility::waittill_any_in_array_return_no_endon_death(_id_A06496F878B6F340);

  if(isDefined(self._id_51C985754E08A199))
    _id_EB40C1291F724432(self);

  if(msg == "death" || msg == "buttonComboSuccess" || msg == "buttonComboReplaced" || msg == "buttonComboEarlyExit")
    return 0;
  else
    return 1;
}

_id_E86117E40BD6EE1F() {
  level scripts\engine\utility::waittill_any_3("game_ended", "round_end_finished", "start_game_ended");
  self.victim notify("buttonComboEarlyExit");
}

_id_28045A145366E0C5() {
  _id_6B7054210E5DF55D = self._id_F9005F600EA89DC7;

  for(;;) {
    _id_59E0DE52B3136ACC = self._id_F9005F600EA89DC7 / 6.0;

    if(isDefined(self._id_51C985754E08A199))
      self._id_51C985754E08A199 setclientomnvar("ui_emp_button_combo_duration", _id_59E0DE52B3136ACC);

    waitframe();
  }
}

_id_D5EA7C13A646E507() {
  self._id_F9005F600EA89DC7 = 6.0;

  while(self._id_F9005F600EA89DC7 > 0) {
    self._id_F9005F600EA89DC7 = self._id_F9005F600EA89DC7 - level.framedurationseconds;
    waitframe();
  }
}

_id_03E29189F38A017D(vehicle, driver) {
  driver endon("disconnect");
  vehicle endon("death");
  driver scripts\engine\utility::waittill_any_3("vehicle_seat_exit", "death", "killed_player");
  vehicle notify("driver_exit");
}

_id_1B1D64A1CC52AAB5(data, time) {
  data.victim endon("death_or_disconnect");
  level endon("game_ended");
  data.victim scripts\engine\utility::waittill_any_timeout_4(time, "emp_cleared", "buttonComboSuccess", "death", "player_killed_no_faux_death");
}

_id_F552430DC0F43D18(driver) {
  self.victim notify("waitButtonComboSuccess");
  self.victim endon("waitButtonComboSuccess");
  driver endon("disconnect");

  for(;;) {
    driver waittill("luinotifyserver", message, value);

    if(message == "button_combo_success" && value == 1) {
      self.victim notify("buttonComboSuccess");
      driver notify("ddos_ended_early");
      self._id_9159D29EDCDDBF2E = 1;
    }

    waitframe();
  }
}

apply_emp_struct(data, _id_206D2CAF9CBDEC7C, _id_88CC62362FD687A2) {
  if(!isDefined(data.damage))
    data.damage = 1;

  if(!isDefined(data.meansofdeath))
    data.meansofdeath = "MOD_EXPLOSIVE";

  if(!isDefined(data.point))
    data.point = (0, 0, 0);

  if(!isDefined(data.direction_vec))
    data.direction_vec = (0, 0, 0);

  if(!isDefined(data.modelname))
    data.modelname = 0;

  if(!isDefined(data.partname))
    data.partname = "";

  if(!isDefined(data.tagname))
    data.tagname = 0;

  if(!isDefined(data.damageflags))
    data.damageflags = 0;

  if(!isDefined(data.hitloc))
    data.hitloc = "none";

  if(!isDefined(data.timeoffset))
    data.timeoffset = 0;

  if(!isDefined(data.victim.empcount))
    data.victim.empcount = 0;

  data.victim.empcount++;

  if(data.victim.empcount == 1) {
    if(isPlayer(data.victim))
      data.victim thread start_emp_effects_player(data, _id_206D2CAF9CBDEC7C, _id_88CC62362FD687A2);

    if(isDefined(data.victim.empstartcallback))
      data.victim thread[[data.victim.empstartcallback]](data);

    data.victim notify("emp_started", data);
  }

  if(isDefined(data.victim.empapplycallback))
    data.victim thread[[data.victim.empapplycallback]](data);

  data.victim notify("emp_applied", data);
}

remove_emp() {
  if(!isDefined(self.empcount)) {
    return;
  }
  self.empcount--;

  if(isDefined(self.empremovecallback))
    self thread[[self.empremovecallback]]();

  self notify("emp_removed");

  if(self.empcount == 0)
    clear_emp(0);
}

clear_emp(_id_FCEF8D217A441961) {
  if(isDefined(self.empcount)) {
    self.empcount = undefined;

    if(isPlayer(self))
      thread stop_emp_effects_player(istrue(_id_FCEF8D217A441961));
    else if(isDefined(self.empclearcallback))
      self thread[[self.empclearcallback]](istrue(_id_FCEF8D217A441961));

    self notify("emp_cleared");
  }
}

is_emp_weapon(objweapon) {
  _id_29CF955CC937C215 = 0;

  switch (objweapon.basename) {
    case "emp_grenade_mp":
      _id_29CF955CC937C215 = 1;
  }

  return _id_29CF955CC937C215;
}

is_emp_damage(objweapon, meansofdeath) {
  if(!is_emp_weapon(objweapon))
    return 0;

  if(!isexplosivedamagemod(meansofdeath))
    return 0;

  return 1;
}

allow_emp(status) {
  if(isPlayer(self))
    allow_emp_player(status);
  else {
    if(!isDefined(self.empnotallowed))
      self.empnotallowed = 0;

    if(status)
      self.empnotallowed--;
    else
      self.empnotallowed++;
  }
}

can_be_empd() {
  if(isPlayer(self))
    return can_emp_player();
  else if(istrue(self.exploding))
    return 0;
  else if(istrue(self.empnotallowed))
    return 0;

  return 1;
}

is_empd() {
  return isDefined(self.empcount) && self.empcount > 0;
}

get_emp_ents() {
  data = emp_get_level_data();
  emp_update_ents();
  return data.entscurrent;
}

set_apply_emp_callback(_id_9B9A9FD5C7F44AF0) {
  self.empapplycallback = _id_9B9A9FD5C7F44AF0;
}

set_start_emp_callback(_id_8E053B475850D27C) {
  self.empstartcallback = _id_8E053B475850D27C;
}

set_remove_emp_callback(_id_31AB61E6884F3BC2) {
  self.empremovecallback = _id_31AB61E6884F3BC2;
}

set_clear_emp_callback(_id_A92C68F274CD0239) {
  self.empclearcallback = _id_A92C68F274CD0239;
}

add_emp_ent(ent) {
  data = emp_get_level_data();
  id = ent getentitynumber();
  data.ents[id] = ent;
  return id;
}

_id_73FD4DD382874EF7(_id_FA88F8AF6B2F44D0, _id_1E3B528A920CE1E9) {
  if(istrue(_id_1E3B528A920CE1E9))
    _id_1E2A945F433A4672(_id_FA88F8AF6B2F44D0);
  else
    play_emp_scramble(_id_FA88F8AF6B2F44D0);
}

_id_AE54EEE1DC461971(_id_FA88F8AF6B2F44D0, _id_1E3B528A920CE1E9) {
  if(istrue(_id_1E3B528A920CE1E9))
    _id_F9646D0DA61017EC(_id_FA88F8AF6B2F44D0);
  else
    stop_emp_scramble(_id_FA88F8AF6B2F44D0);
}

play_emp_scramble(_id_FA88F8AF6B2F44D0) {
  if(_id_FA88F8AF6B2F44D0 == 0) {
    return;
  }
  if(!isDefined(self.empscramblelevels))
    self.empscramblelevels = [];

  _id_4FDC563C6178BCBF = self.empscramblelevels[_id_FA88F8AF6B2F44D0];

  if(!isDefined(_id_4FDC563C6178BCBF))
    _id_4FDC563C6178BCBF = 0;

  self.empscramblelevels[_id_FA88F8AF6B2F44D0] = _id_4FDC563C6178BCBF + 1;
  _update_emp_scramble();
}

stop_emp_scramble(_id_FA88F8AF6B2F44D0) {
  if(_id_FA88F8AF6B2F44D0 == 0) {
    return;
  }
  self.empscramblelevels[_id_FA88F8AF6B2F44D0] = self.empscramblelevels[_id_FA88F8AF6B2F44D0] - 1;

  if(self.empscramblelevels[_id_FA88F8AF6B2F44D0] == 0)
    self.empscramblelevels[_id_FA88F8AF6B2F44D0] = undefined;

  _update_emp_scramble();
}

_id_F7C6D776D032122F() {
  self.empscramblelevels = [];
  _update_emp_scramble();
  self notify("emp_scramble_off");
}

_update_emp_scramble() {
  _id_7EBFF841A7082A8B = 0;

  foreach(_id_FA88F8AF6B2F44D0, _ in self.empscramblelevels) {
    if(_id_FA88F8AF6B2F44D0 > _id_7EBFF841A7082A8B)
      _id_7EBFF841A7082A8B = _id_FA88F8AF6B2F44D0;
  }

  self setclientomnvar("ui_scrambler_strength", _id_7EBFF841A7082A8B);
}

_id_1E2A945F433A4672(_id_FA88F8AF6B2F44D0) {
  if(_id_FA88F8AF6B2F44D0 == 0) {
    return;
  }
  if(!isDefined(self._id_A0D8D8B22DA8EC61))
    self._id_A0D8D8B22DA8EC61 = [];

  _id_8D59C19C765106E8 = self._id_A0D8D8B22DA8EC61[_id_FA88F8AF6B2F44D0];

  if(!isDefined(_id_8D59C19C765106E8))
    _id_8D59C19C765106E8 = 0;

  self._id_A0D8D8B22DA8EC61[_id_FA88F8AF6B2F44D0] = _id_8D59C19C765106E8 + 1;
  _id_9884B1BC85070E0E();
}

_id_F9646D0DA61017EC(_id_FA88F8AF6B2F44D0) {
  if(_id_FA88F8AF6B2F44D0 == 0) {
    return;
  }
  self._id_A0D8D8B22DA8EC61[_id_FA88F8AF6B2F44D0] = self._id_A0D8D8B22DA8EC61[_id_FA88F8AF6B2F44D0] - 1;

  if(self._id_A0D8D8B22DA8EC61[_id_FA88F8AF6B2F44D0] == 0)
    self._id_A0D8D8B22DA8EC61[_id_FA88F8AF6B2F44D0] = undefined;

  _id_9884B1BC85070E0E();
}

_id_9884B1BC85070E0E() {
  _id_7EBFF841A7082A8B = 0;

  foreach(_id_FA88F8AF6B2F44D0, _ in self._id_A0D8D8B22DA8EC61) {
    if(_id_FA88F8AF6B2F44D0 > _id_7EBFF841A7082A8B)
      _id_7EBFF841A7082A8B = _id_FA88F8AF6B2F44D0;
  }

  self setclientomnvar("ui_jammer_strength", _id_7EBFF841A7082A8B);
}

play_scramble_for_player_until_cleared(player, _id_FA88F8AF6B2F44D0) {
  player play_emp_scramble(_id_FA88F8AF6B2F44D0);
  scripts\engine\utility::waittill_any_2("emp_cleared", "death");

  if(isDefined(player))
    player stop_emp_scramble(_id_FA88F8AF6B2F44D0);
}

allow_emp_player(status) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "setPlayerEMPImmune"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "setPlayerEMPImmune")]](status);
}

_id_322B9832295246C2() {
  if(!isDefined(self.empcount))
    return 0;
  else
    return self.empcount;
}

can_emp_player() {
  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "getPlayerEMPImmune"))
    return ![[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "getPlayerEMPImmune")]]();

  return 1;
}

start_emp_effects_player(data, _id_206D2CAF9CBDEC7C, _id_88CC62362FD687A2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "onPlayerEMPed"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "onPlayerEMPed")]](data);

  if(istrue(_id_206D2CAF9CBDEC7C))
    self setempjammed(1);

  if(istrue(_id_88CC62362FD687A2)) {
    _id_3B64EB40368C1450::set("emp", "killstreaks", 0);
    _id_3B64EB40368C1450::set("emp", "supers", 0);
  }
}

stop_emp_effects_player(_id_FCEF8D217A441961) {
  self setempjammed(0);

  if(!_id_FCEF8D217A441961)
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("emp");
}

emp_init() {
  data = spawnStruct();
  level.emp = data;
  level.emp.ents = [];
}

emp_get_level_data() {
  if(!isDefined(level.emp))
    emp_init();

  return level.emp;
}

emp_update_ents() {
  data = emp_get_level_data();
  ents = [];

  foreach(ent in data.ents) {
    if(isDefined(ent) && ent can_be_empd())
      ents[ents.size] = ent;
  }

  foreach(mine in level.mines) {
    if(isDefined(mine) && mine can_be_empd())
      ents[ents.size] = mine;
  }

  turrets = getEntArray("misc_turret", "classname");

  foreach(turret in turrets) {
    if(isDefined(turret) && turret can_be_empd())
      ents[ents.size] = turret;
  }

  if(isDefined(level.activekillstreaks)) {
    foreach(_id_153FDEE861E0F06F in level.activekillstreaks) {
      if(isDefined(_id_153FDEE861E0F06F) && _id_153FDEE861E0F06F can_be_empd())
        ents[ents.size] = _id_153FDEE861E0F06F;
    }
  }

  if(isDefined(level.vehicle)) {
    foreach(vehicles in level.vehicle.instances) {
      foreach(vehicle in vehicles) {
        if(isDefined(vehicle) && vehicle can_be_empd())
          ents[ents.size] = vehicle;
      }
    }
  }

  if(isDefined(level.decoygrenades)) {
    foreach(_id_8456FC3126306843 in level.decoygrenades) {
      if(isDefined(_id_8456FC3126306843) && _id_8456FC3126306843 can_be_empd())
        ents[ents.size] = _id_8456FC3126306843;
    }
  }

  if(isDefined(level._id_1FDD52A3D7E6715D)) {
    foreach(_id_83C22FCEBA5BCE5C in level._id_1FDD52A3D7E6715D) {
      if(isDefined(_id_83C22FCEBA5BCE5C) && _id_83C22FCEBA5BCE5C can_be_empd())
        ents[ents.size] = _id_83C22FCEBA5BCE5C;
    }
  }

  if(isDefined(level._id_92E2C130A8EA2B6C)) {
    foreach(drone in level._id_92E2C130A8EA2B6C) {
      if(isDefined(drone) && !istrue(drone.isdestroyed))
        ents[ents.size] = drone;
    }
  }

  foreach(player in level.players) {
    if(!isPlayer(player) && player can_be_empd())
      ents[ents.size] = player;
  }

  if(isDefined(level._id_372BD0F371E44049)) {
    foreach(_id_1B91D895C80E84B2 in level._id_372BD0F371E44049)
    ents[ents.size] = _id_1B91D895C80E84B2;
  }

  ents = scripts\engine\utility::array_remove_duplicates(ents);
  data.entscurrent = ents;
  thread emp_reset_ents();
}

emp_reset_ents() {
  data = emp_get_level_data();
  waittillframeend;
  data.entscurrent = undefined;
}