/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\emp_debuff.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace emp_debuff;

function emp_debuff_init() {
  if(issharedfuncdefined("emp", "init")) {
    [[getsharedfunc("emp", "init")]]();
  }
}

function function_662905d3b9455612(data, time, var_d5c235d554645bbc) {
  if(istrue(level.gameended)) {
    return;
  }

  if(!isDefined(time) || time <= 0) {
    time = 6;
  }

  var_ec826393f0c6fdb3 = 0;

  if(istrue(var_d5c235d554645bbc) && data.victim scripts\cp_mp\vehicles\vehicle::isvehicle() && data.victim function_7d6c1037f26ddb70()) {
    var_ec826393f0c6fdb3 = 1;
  }

  if(var_ec826393f0c6fdb3) {
    function_84ff119fbcaf315(data);
  }

  apply_emp_struct(data);
  function_1b1d64a1cc52aab5(data, time);

  if(isDefined(data.victim)) {
    if(var_ec826393f0c6fdb3) {
      function_9100acf46355b9c2(data);
    } else {
      data.victim remove_emp();
    }

    return;
  }

  if(isDefined(data.var_51c985754e08a199)) {
    function_eb40c1291f724432(data);
  }
}

function function_7d6c1037f26ddb70() {
  if(scripts\cp_mp\vehicles\vehicle::isvehiclekillstreak()) {
    if(self.vehiclename == "pac_sentry" || self.vehiclename == "radar_drone_recon" || self.vehiclename == "assault_drone") {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 1;
}

function function_9100acf46355b9c2(data) {
  driver = data.var_51c985754e08a199;
  empcount = data.victim _get_emp_count();

  if(istrue(data.var_9159d29edcddbf2e) || empcount <= 1 || istrue(data.victim.isdestroyed)) {
    data.victim clear_emp();

    if(isDefined(driver)) {
      function_eb40c1291f724432(data);
    }

    return;
  }

  data.victim remove_emp();
}

function function_eb40c1291f724432(data) {
  data.var_51c985754e08a199 setclientomnvar("ui_emp_button_combo_show", 0);
  data.var_51c985754e08a199 = undefined;
}

function function_84ff119fbcaf315(data) {
  vehicle = data.victim;
  notifylist = ["death", "buttonComboSuccess", "buttonComboReplaced", "buttonComboEarlyExit"];

  if(data.victim is_empd()) {
    function_9cdf5e46cecefb7f(data);
  }

  if(isDefined(vehicle.helperdronetype)) {
    notifylist = array_add(notifylist, "drone_exit");
  } else if(vehicle scripts\cp_mp\vehicles\vehicle::isvehiclekillstreak() && vehicle.vehiclename == "pac_sentry") {
    notifylist = array_add(notifylist, "leaving_control");
  } else {
    notifylist = function_ef4b3df86351aa00(notifylist, ["vehicle_owner_update", "driver_exit"], 0);
    data.var_12482c5b5b258cdf = 1;
  }

  data thread function_70eaf1a1aca6a06c(notifylist);
}

function function_9cdf5e46cecefb7f(data) {
  level endon("game_ended");
  data.victim endon("death");
  data.victim notify("buttonComboReplaced");
  waitframe();
}

function function_70eaf1a1aca6a06c(notifylist) {
  self.victim endon("emp_cleared");
  self.victim notify("buttonComboStarted");
  self.victim endon("buttonComboStarted");
  driver = undefined;

  if(!istrue(self.var_12482c5b5b258cdf)) {
    driver = self.victim.owner;
    driver endon("disconnect");
  }

  childthread function_d5ea7c13a646e507();

  while(true) {
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(self.victim)) {
      break;
    }

    if(istrue(self.var_12482c5b5b258cdf) || istrue(self.victim.ispiloted)) {
      if(istrue(self.var_12482c5b5b258cdf)) {
        driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self.victim);

        if(isDefined(driver)) {
          childthread function_3e29189f38a017d(self.victim, driver);
        }
      }

      if(isDefined(driver)) {
        shouldcontinue = function_bcda60626641c653(driver, notifylist);

        if(!istrue(shouldcontinue)) {
          break;
        }
      } else {
        waitframe();
      }

      continue;
    }

    wait 0.1;
  }
}

function function_bcda60626641c653(driver, notifylist) {
  self.var_51c985754e08a199 = driver;
  self.var_51c985754e08a199 setclientomnvar("ui_emp_button_combo_show", 1);
  childthread function_28045a145366e0c5();
  childthread function_f552430dc0f43d18(self.var_51c985754e08a199);
  childthread function_e86117e40bd6ee1f();
  msg = self.victim waittill_any_in_array_return_no_endon_death(notifylist);

  if(isDefined(self.var_51c985754e08a199)) {
    function_eb40c1291f724432(self);
  }

  if(msg == "death" || msg == "buttonComboSuccess" || msg == "buttonComboReplaced" || msg == "buttonComboEarlyExit") {
    return 0;
  }

  return 1;
}

function function_e86117e40bd6ee1f() {
  level waittill_any_3("game_ended", "round_end_finished", "start_game_ended");
  self.victim notify("buttonComboEarlyExit");
}

function function_28045a145366e0c5() {
  maxduration = self.empdurationremaining;

  while(true) {
    percentageleft = self.empdurationremaining / 6;

    if(isDefined(self.var_51c985754e08a199)) {
      self.var_51c985754e08a199 setclientomnvar("ui_emp_button_combo_duration", percentageleft);
    }

    waitframe();
  }
}

function function_d5ea7c13a646e507() {
  self.empdurationremaining = 6;

  while(self.empdurationremaining > 0) {
    self.empdurationremaining -= level.framedurationseconds;
    waitframe();
  }
}

function function_3e29189f38a017d(vehicle, driver) {
  driver endon("disconnect");
  vehicle endon("death");
  driver waittill_any_3("vehicle_seat_exit", "death", "killed_player");
  vehicle notify("driver_exit");
}

function function_1b1d64a1cc52aab5(data, time) {
  data.victim endon("death_or_disconnect");
  level endon("game_ended");
  data.victim waittill_any_timeout_4(time, "emp_cleared", "buttonComboSuccess", "death", "player_killed_no_faux_death");
}

function function_f552430dc0f43d18(driver) {
  self.victim notify("waitButtonComboSuccess");
  self.victim endon("waitButtonComboSuccess");
  driver endon("disconnect");

  while(true) {
    driver waittill("luinotifyserver", message, value);

    if(message == "button_combo_success" && value == 1) {
      self.victim notify("buttonComboSuccess");
      driver notify("ddos_ended_early");
      self.var_9159d29edcddbf2e = 1;
    }

    waitframe();
  }
}

function apply_emp_struct(data, disablehud, var_88cc62362fd687a2) {
  assertex(isDefined(data), "<dev string:x1c>");
  assertex(isDefined(data.attacker), "<dev string:x40>");
  assertex(isDefined(data.victim), "<dev string:x6f>");

  if(issharedfuncdefined("perk", "hasPerk") && data.victim[[getsharedfunc("perk", "hasPerk")]]("specialty_emp_immunity")) {
    return;
  }

  assertex(isDefined(data.objweapon), "<dev string:x9c>");
  assertex(isweapon(data.objweapon), "<dev string:xcc>");

  if(!isDefined(data.damage)) {
    data.damage = 1;
  }

  if(!isDefined(data.meansofdeath)) {
    data.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(!isDefined(data.point)) {
    data.point = (0, 0, 0);
  }

  if(!isDefined(data.direction_vec)) {
    data.direction_vec = (0, 0, 0);
  }

  if(!isDefined(data.modelname)) {
    data.modelname = 0;
  }

  if(!isDefined(data.partname)) {
    data.partname = "";
  }

  if(!isDefined(data.tagname)) {
    data.tagname = 0;
  }

  if(!isDefined(data.damageflags)) {
    data.damageflags = 0;
  }

  if(!isDefined(data.hitloc)) {
    data.hitloc = "none";
  }

  if(!isDefined(data.timeoffset)) {
    data.timeoffset = 0;
  }

  if(!isDefined(data.victim.empcount)) {
    data.victim.empcount = 0;
  }

  if(!isDefined(data.reason)) {
    data.reason = "DDOS";
  }

  data.victim.empcount++;

  if(data.victim.empcount == 1) {
    if(isent(data.victim) && isPlayer(data.victim)) {
      data.victim thread function_3839fb2d04a8d30e(data, disablehud, var_88cc62362fd687a2);
    }

    if(isDefined(data.victim.empstartcallback)) {
      data.victim thread[[data.victim.empstartcallback]](data);
    }

    data.victim notify("emp_started", data);
  }

  if(isDefined(data.victim.empapplycallback)) {
    data.victim thread[[data.victim.empapplycallback]](data);
  }

  data.victim notify("emp_applied", data);
  data.victim thread function_45aca51d5e102b8c();
}

function remove_emp() {
  if(!isDefined(self.empcount)) {
    return;
  }

  self.empcount--;

  if(isDefined(self.empremovecallback)) {
    self thread[[self.empremovecallback]]();
  }

  self notify("emp_removed");
  self notify("stopLauncherCheck");

  if(self.empcount == 0) {
    clear_emp(0);
  }
}

function clear_emp(fromdeath) {
  if(isDefined(self.empcount)) {
    self.empcount = undefined;

    if(isent(self) && isPlayer(self)) {
      thread function_a50bae7a5c1bb54e(istrue(fromdeath));
    } else if(isDefined(self.empclearcallback)) {
      self thread[[self.empclearcallback]](istrue(fromdeath));
    }

    self notify("emp_cleared");
    scripts\cp_mp\utility\weapon_utility::function_605b121f1fadd46c(1);
  }
}

function function_45aca51d5e102b8c() {
  level endon("game_ended");

  if(!isDefined(self) || !isPlayer(self) && !isagent(self)) {
    return;
  }

  weap = self getcurrentweapon();

  if(weap.basename == "jup_jp22_la_dromeo_mp") {
    val::set("emp", "fire", 0);
    self.var_a1049ae916f6b287 = 1;
  }

  while(true) {
    result = waittill_any_return_4("weapon_change", "emp_cleared", "emp_removed", "disconnect");

    if(isDefined(result) && result == "disconnect") {
      return;
    }

    if(!isDefined(self)) {
      return;
    }

    isemp = scripts\cp_mp\emp_debuff::is_empd();

    if(isDefined(result) && (result == "emp_cleared" || result == "emp_removed" || !istrue(isemp))) {
      val::set("emp", "fire", 1);
      self.var_a1049ae916f6b287 = undefined;
      return;
    }

    weap = self getcurrentweapon();

    if(weap.basename == "jup_jp22_la_dromeo_mp") {
      val::set("emp", "fire", 0);
      self.var_a1049ae916f6b287 = 1;
      continue;
    }

    if(istrue(self.var_a1049ae916f6b287)) {
      val::set("emp", "fire", 1);
      self.var_a1049ae916f6b287 = undefined;
    }
  }
}

function allow_emp(status) {
  if(isPlayer(self)) {
    function_8ee0deb8fa69cbee(status);
    return;
  }

  if(!isDefined(self.empnotallowed)) {
    self.empnotallowed = 0;
  }

  if(status) {
    assertex(self.empnotallowed > 0, "<dev string:x102>");
    self.empnotallowed--;
    return;
  }

  self.empnotallowed++;
}

function function_5c534584bf65d24c() {
  if(istrue(self.exploding)) {
    return false;
  } else if(istrue(self.empnotallowed)) {
    return false;
  }

  return true;
}

function can_be_empd() {
  if(isPlayer(self)) {
    return function_28b3cf4c66aab86f();
  } else if(istrue(self.exploding)) {
    return 0;
  } else if(istrue(self.empnotallowed)) {
    return 0;
  }

  return 1;
}

function is_empd() {
  return isDefined(self.empcount) && self.empcount > 0;
}

function emp_debuff_get_emp_count() {
  if(isDefined(self.empcount)) {
    return self.empcount;
  }

  return 0;
}

function set_apply_emp_callback(applycallback) {
  self.empapplycallback = applycallback;
}

function set_start_emp_callback(startcallback) {
  self.empstartcallback = startcallback;
}

function set_clear_emp_callback(clearcallback) {
  self.empclearcallback = clearcallback;
}

function add_emp_ent(ent) {
  data = function_879c1eec976b6d33();
  id = ent getentitynumber();
  data.ents[id] = ent;
  return id;
}

function play_scramble(scramblelevel, isjammer) {
  if(istrue(isjammer)) {
    function_1e2a945f433a4672(scramblelevel);
    return;
  }

  play_emp_scramble(scramblelevel);
}

function stop_scramble(scramblelevel, isjammer) {
  if(istrue(isjammer)) {
    function_f9646d0da61017ec(scramblelevel);
    return;
  }

  stop_emp_scramble(scramblelevel);
}

function function_396e8b70241f9f10(scramblelevel, var_699323575339379a) {
  if(istrue(var_699323575339379a)) {
    return (isDefined(self.var_a0d8d8b22da8ec61) && isDefined(self.var_a0d8d8b22da8ec61[scramblelevel]));
  }

  return isDefined(self.empscramblelevels) && isDefined(self.empscramblelevels[scramblelevel]);
}

function play_emp_scramble(scramblelevel) {
  if(scramblelevel == 0) {
    return;
  }

  if(!isDefined(self.empscramblelevels)) {
    self.empscramblelevels = [];
  }

  var_4fdc563c6178bcbf = self.empscramblelevels[scramblelevel];

  if(!isDefined(var_4fdc563c6178bcbf)) {
    var_4fdc563c6178bcbf = 0;
  }

  self.empscramblelevels[scramblelevel] = var_4fdc563c6178bcbf + 1;
  _update_emp_scramble();
}

function stop_emp_scramble(scramblelevel) {
  if(!isDefined(self) || !isDefined(scramblelevel) || scramblelevel == 0 || !(isDefined(self.empscramblelevels) && isDefined(self.empscramblelevels[scramblelevel]))) {
    return;
  }

  assert(isDefined(self.empscramblelevels), "<dev string:x13a>");
  assert(isDefined(self.empscramblelevels[scramblelevel]), "<dev string:x168>");
  self.empscramblelevels[scramblelevel] -= 1;

  if(self.empscramblelevels[scramblelevel] == 0) {
    self.empscramblelevels[scramblelevel] = undefined;
  }

  _update_emp_scramble();
}

function function_f7c6d776d032122f() {
  self.empscramblelevels = [];
  _update_emp_scramble();

  if(isDefined(self.empclearcallback)) {
    self thread[[self.empclearcallback]](0);
  }

  self notify("emp_scramble_off");
}

function private _update_emp_scramble() {
  highestlevel = 0;

  foreach(scramblelevel, _ in self.empscramblelevels) {
    if(scramblelevel > highestlevel) {
      highestlevel = scramblelevel;
    }
  }

  self setclientomnvar("ui_scrambler_strength", highestlevel);
}

function private function_9884b1bc85070e0e() {
  highestlevel = 0;

  foreach(scramblelevel, _ in self.var_a0d8d8b22da8ec61) {
    if(scramblelevel > highestlevel) {
      highestlevel = scramblelevel;
    }
  }

  self setclientomnvar("ui_jammer_strength", highestlevel);
}

function function_1e2a945f433a4672(scramblelevel) {
  if(scramblelevel == 0) {
    return;
  }

  if(!isDefined(self.var_a0d8d8b22da8ec61)) {
    self.var_a0d8d8b22da8ec61 = [];
  }

  var_8d59c19c765106e8 = self.var_a0d8d8b22da8ec61[scramblelevel];

  if(!isDefined(var_8d59c19c765106e8)) {
    var_8d59c19c765106e8 = 0;
  }

  self.var_a0d8d8b22da8ec61[scramblelevel] = var_8d59c19c765106e8 + 1;
  function_9884b1bc85070e0e();
}

function function_f9646d0da61017ec(scramblelevel) {
  if(scramblelevel == 0) {
    return;
  }

  assert(isDefined(self.var_a0d8d8b22da8ec61), "<dev string:x1a1>");
  assert(isDefined(self.var_a0d8d8b22da8ec61[scramblelevel]), "<dev string:x1d6>");
  self.var_a0d8d8b22da8ec61[scramblelevel] -= 1;

  if(self.var_a0d8d8b22da8ec61[scramblelevel] == 0) {
    self.var_a0d8d8b22da8ec61[scramblelevel] = undefined;
  }

  function_9884b1bc85070e0e();
}

function play_scramble_for_player_until_cleared(player, scramblelevel) {
  player scripts\cp_mp\emp_debuff::play_emp_scramble(scramblelevel);
  waittill_any_2("emp_cleared", "death");

  if(isDefined(player)) {
    player scripts\cp_mp\emp_debuff::stop_emp_scramble(scramblelevel);
  }
}

function function_9d31a370d60f86da(player, scramblelevel) {
  player scripts\cp_mp\emp_debuff::play_emp_scramble(scramblelevel);
  waittill_any_2("dronegun_emp_cleared", "death");

  if(isDefined(player)) {
    player scripts\cp_mp\emp_debuff::stop_emp_scramble(scramblelevel);
  }
}

function private function_8ee0deb8fa69cbee(status) {
  if(issharedfuncdefined("emp", "setPlayerEMPImmune")) {
    self[[getsharedfunc("emp", "setPlayerEMPImmune")]](status);
  }
}

function private _get_emp_count() {
  if(!isDefined(self.empcount)) {
    return 0;
  }

  return self.empcount;
}

function private function_28b3cf4c66aab86f() {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(issharedfuncdefined("emp", "getPlayerEMPImmune")) {
    return ![[getsharedfunc("emp", "getPlayerEMPImmune")]]();
  }

  return true;
}

function private function_3839fb2d04a8d30e(data, disablehud, var_88cc62362fd687a2) {
  if(issharedfuncdefined("emp", "onPlayerEMPed")) {
    self[[getsharedfunc("emp", "onPlayerEMPed")]](data);
  }

  if(istrue(disablehud)) {
    self setempjammed(1);
  }

  if(istrue(var_88cc62362fd687a2)) {
    val::set("emp", "killstreaks", 0);
    val::set("emp", "supers", 0);
  }

  thread watch_checkforlauncherweapons();
}

function private function_a50bae7a5c1bb54e(fromdeath) {
  self setempjammed(0);

  if(!fromdeath) {
    val::reset_all("emp");
  }
}

function private function_bc44636b60d908b() {
  data = spawnStruct();
  level.emp = data;
  level.emp.ents = [];
}

function private function_879c1eec976b6d33() {
  if(!isDefined(level.emp)) {
    function_bc44636b60d908b();
  }

  return level.emp;
}

function private watch_checkforlauncherweapons() {
  self endon("death_or_disconnect");
  self endon("stopLauncherCheck");
  level endon("game_ended");

  while(true) {
    currentweapon = self getcurrentweapon();

    if(weapon_utility::islockonlauncher(currentweapon)) {
      scripts\cp_mp\utility\weapon_utility::function_605b121f1fadd46c(0);
    } else {
      scripts\cp_mp\utility\weapon_utility::function_605b121f1fadd46c(1);
    }

    wait 1;
  }
}

function function_ecb3af104f3ab0f4(entity, applycallback, startcallback, clearcallback) {
  if(isDefined(applycallback)) {
    entity set_apply_emp_callback(applycallback);
  }

  if(isDefined(startcallback)) {
    entity set_start_emp_callback(startcallback);
  }

  if(isDefined(clearcallback)) {
    entity set_clear_emp_callback(clearcallback);
  }

  if(!isDefined(level.var_7cfe8a4bd3bd978c)) {
    level.var_7cfe8a4bd3bd978c = [];
  }

  if(isDefined(entity)) {
    level.var_7cfe8a4bd3bd978c[entity getentitynumber()] = entity;
  }
}

function emp_debuff_deregister(entity) {
  if(!isDefined(level.var_7cfe8a4bd3bd978c)) {
    return;
  }

  if(!isDefined(entity)) {
    return;
  }

  entitynumber = entity getentitynumber();

  if(!isDefined(level.var_7cfe8a4bd3bd978c[entitynumber])) {
    return;
  }

  level.var_7cfe8a4bd3bd978c[entitynumber] = undefined;
}

function private function_c772d34f3b6b6273(ents, optionalorigin, var_5a946d15b7708ff0) {
  if(isDefined(optionalorigin)) {
    if(distancesquared(self.origin, optionalorigin) > var_5a946d15b7708ff0) {
      return false;
    }
  }

  if(arraycontains(ents, self)) {
    return false;
  }

  return true;
}

function empdebuff_get_emp_ents(optionalorigin, optionalradius) {
  data = function_879c1eec976b6d33();
  radiussquared = undefined;

  if(isDefined(optionalradius)) {
    radiussquared = optionalradius * optionalradius;
  }

  ents = [];

  foreach(ent in data.ents) {
    if(isDefined(ent) && ent can_be_empd() && ent function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
      ents[ents.size] = ent;
    }
  }

  foreach(mine in level.mines) {
    if(isDefined(mine) && mine function_5c534584bf65d24c() && mine function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
      ents[ents.size] = mine;
    }
  }

  turrets = getEntArray("misc_turret", "classname");

  foreach(turret in turrets) {
    if(isDefined(turret) && turret function_5c534584bf65d24c() && turret function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
      ents[ents.size] = turret;
    }
  }

  if(isDefined(level.activekillstreaks)) {
    foreach(streak in level.activekillstreaks) {
      if(isDefined(streak) && streak function_5c534584bf65d24c() && streak function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
        ents[ents.size] = streak;
      }
    }
  }

  if(isDefined(level.vehicle)) {
    foreach(vehicles in level.vehicle.instances) {
      foreach(vehicle in vehicles) {
        if(isDefined(vehicle) && vehicle function_5c534584bf65d24c() && vehicle function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
          ents[ents.size] = vehicle;
        }
      }
    }
  }

  if(isDefined(level.trackers)) {
    foreach(tracker in level.trackers) {
      if(isDefined(tracker) && tracker function_5c534584bf65d24c() && tracker function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
        ents[ents.size] = tracker;
      }
    }
  }

  if(isDefined(level.var_7cfe8a4bd3bd978c)) {
    foreach(equipment in level.var_7cfe8a4bd3bd978c) {
      if(isDefined(equipment) && equipment function_5c534584bf65d24c() && equipment function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
        ents[ents.size] = equipment;
      }
    }
  }

  if(isDefined(level.var_92e2c130a8ea2b6c)) {
    foreach(drone in level.var_92e2c130a8ea2b6c) {
      if(isDefined(drone) && !istrue(drone.isdestroyed) && drone function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
        ents[ents.size] = drone;
      }
    }
  }

  if(isDefined(level.holdprop) && istrue(level.holdprop.canemp) && isDefined(level.var_f1073fbd45b59a06) && isDefined(level.var_f1073fbd45b59a06.var_df987907a483df89)) {
    foreach(stronghold in level.var_f1073fbd45b59a06.var_df987907a483df89) {
      if(isDefined(stronghold) && isDefined(stronghold.task) && isDefined(stronghold.task.holdpoint) && isDefined(stronghold.task.holdpoint.trigger) && stronghold.task.holdpoint.trigger function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
        ents[ents.size] = stronghold.task.holdpoint.trigger;
      }
    }
  }

  if(istrue(level.var_684d782689230a50)) {
    foreach(towerstruct in level.uavtowers) {
      if(isDefined(towerstruct) && isDefined(towerstruct.uav_station) && towerstruct.uav_station function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
        ents[ents.size] = towerstruct.uav_station;
      }
    }
  }

  if(istrue(level.var_3976c9c03dc06d9b) && isDefined(level.var_fc4bb27a820f54dd)) {
    if(isDefined(level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c)) {
      foreach(var_5c5b88ce7ae1228e in level.var_fc4bb27a820f54dd.var_cd2de8814a52f22c) {
        if(!istrue(var_5c5b88ce7ae1228e.b_occupied)) {
          continue;
        }

        if(var_5c5b88ce7ae1228e function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
          ents[ents.size] = var_5c5b88ce7ae1228e;
        }
      }
    }

    if(isDefined(level.var_fc4bb27a820f54dd.var_858ba27e4dbd844c)) {
      foreach(var_e744c8777474039a in level.var_fc4bb27a820f54dd.var_858ba27e4dbd844c) {
        if(var_e744c8777474039a function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
          ents[ents.size] = var_e744c8777474039a;
        }
      }
    }
  }

  if(istrue(level.var_3976c9c03dc06d9b) && scripts\engine\utility::issharedfuncdefined(#"hash_7c77f410582a71b4", #"hash_3dd4fa0f710a2eff")) {
    drones = [[scripts\engine\utility::getsharedfunc(#"hash_7c77f410582a71b4", #"hash_3dd4fa0f710a2eff")]]();
    assert(isDefined(drones));

    foreach(var_5c5b88ce7ae1228e in drones) {
      if(!isDefined(var_5c5b88ce7ae1228e)) {
        continue;
      }

      if(!istrue(var_5c5b88ce7ae1228e.b_occupied)) {
        continue;
      }

      if(var_5c5b88ce7ae1228e function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
        ents[ents.size] = var_5c5b88ce7ae1228e;
      }
    }
  }

  if(isDefined(level.deployablekiosks)) {
    if(istrue(level.deployablekiosks.var_8bf814f9559f53)) {
      if(isDefined(level.deployablekiosks.drones)) {
        foreach(drone in level.deployablekiosks.drones) {
          if(drone function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
            ents[ents.size] = drone;
          }
        }
      }
    }

    if(istrue(level.deployablekiosks.var_aaa31c1e28a5663c)) {
      if(isDefined(level.deployablekiosks.buystations)) {
        foreach(buystation in level.deployablekiosks.buystations) {
          if(buystation function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
            ents[ents.size] = buystation;
          }
        }
      }
    }
  }

  if(isDefined(level.var_c75aa35bb2f6a4e2)) {
    foreach(object in level.var_c75aa35bb2f6a4e2) {
      if(object function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
        ents[ents.size] = object;
      }
    }
  }

  foreach(player in level.players) {
    if(!isPlayer(player) && player can_be_empd() && player function_c772d34f3b6b6273(ents, optionalorigin, radiussquared)) {
      ents[ents.size] = player;
    }
  }

  return ents;
}