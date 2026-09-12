/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\emp_debuff.gsc
***********************************************/

function emp_debuff_init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "init")]]();
    return;
  }
}

function apply_emp(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.attacker = var_0;
  var_2.victim = self;
  var_2.objweapon = var_1;
  apply_emp_struct(var_2);
}

function apply_emp_struct(var_0) {
  if(!isDefined(var_0.damage)) {
    var_0.damage = 1;
  }

  if(!isDefined(var_0.meansofdeath)) {
    var_0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(!isDefined(var_0.point)) {
    var_0.point = (0, 0, 0);
  }

  if(!isDefined(var_0.direction_vec)) {
    var_0.direction_vec = (0, 0, 0);
  }

  if(!isDefined(var_0.modelname)) {
    var_0.modelname = 0;
  }

  if(!isDefined(var_0.partname)) {
    var_0.partname = "";
  }

  if(!isDefined(var_0.tagname)) {
    var_0.tagname = 0;
  }

  if(!isDefined(var_0.damageflags)) {
    var_0.damageflags = 0;
  }

  if(!isDefined(var_0.hitloc)) {
    var_0.hitloc = "none";
  }

  if(!isDefined(var_0.timeoffset)) {
    var_0.timeoffset = 0;
  }

  if(!isDefined(var_0.victim.empcount)) {
    var_0.victim.empcount = 0;
  }

  var_0.victim.empcount++;

  if(var_0.victim.empcount == 1) {
    if(isPlayer(var_0.victim)) {
      thread start_emp_effects_player(var_0.victim);
    }

    if(isDefined(var_0.victim.empstartcallback)) {
      var_0.victim thread[[var_0.victim.empstartcallback]](var_0);
    }

    var_0.victim notify("emp_started", var_0);
  }

  if(isDefined(var_0.victim.empapplycallback)) {
    var_0.victim thread[[var_0.victim.empapplycallback]](var_0);
  }

  var_0.victim notify("emp_applied", var_0);
}

function remove_emp() {
  if(!is_empd()) {
    return;
  }

  self.empcount--;

  if(isDefined(self.empremovecallback)) {
    self thread[[self.empremovecallback]]();
  }

  self notify("emp_removed");

  if(self.empcount == 0) {
    clear_emp(0);
    return;
  }
}

function clear_emp(var_0) {
  if(isDefined(self.empcount)) {
    self.empcount = undefined;

    if(isPlayer(self)) {
      thread stop_emp_effects_player(istrue(var_0));
    } else if(isDefined(self.empclearcallback)) {
      self thread[[self.empclearcallback]](istrue(var_0));
    }

    self notify("emp_cleared");
    return;
  }
}

function is_emp_weapon(var_0) {
  var_1 = 0;

  switch (var_0.basename) {
    case "emp_grenade_mp":
      var_1 = 1;
      break;
  }

  return var_1;
}

function is_emp_damage(var_0, var_1) {
  if(!is_emp_weapon(var_0)) {
    return false;
  }

  if(!isexplosivedamagemod(var_1)) {
    return false;
  }

  return true;
}

function allow_emp(var_0) {
  if(isPlayer(self)) {
    allow_emp_player(var_0);
    return;
  }

  if(!isDefined(self.empnotallowed)) {
    self.empnotallowed = 0;
  }

  if(var_0) {
    self.empnotallowed--;
    return;
  }

  self.empnotallowed++;
}

function can_be_empd() {
  if(isPlayer(self)) {
    return can_emp_player();
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

function get_emp_ents() {
  var_0 = emp_get_level_data();
  emp_update_ents();
  return var_0.entscurrent;
}

function set_apply_emp_callback(var_0) {
  self.empapplycallback = var_0;
}

function set_start_emp_callback(var_0) {
  self.empstartcallback = var_0;
}

function set_remove_emp_callback(var_0) {
  self.empremovecallback = var_0;
}

function set_clear_emp_callback(var_0) {
  self.empclearcallback = var_0;
}

function add_emp_ent(var_0) {
  var_1 = emp_get_level_data();
  var_2 = var_0 getentitynumber();
  var_1.ents[var_2] = var_0;
  return var_2;
}

function play_emp_scramble(var_0) {
  if(var_0 == 0) {
    return;
  }

  if(!isDefined(self.empscramblelevels)) {
    self.empscramblelevels = [];
  }

  var_1 = self.empscramblelevels[var_0];

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self.empscramblelevels[var_0] = var_1 + 1;
  _update_emp_scramble();
}

function stop_emp_scramble(var_0) {
  if(var_0 == 0) {
    return;
  }

  self.empscramblelevels[var_0] -= 1;

  if(self.empscramblelevels[var_0] == 0) {
    self.empscramblelevels[var_0] = undefined;
  }

  _update_emp_scramble();
}

function _update_emp_scramble() {
  var_0 = 0;

  foreach(var_2 in self.empscramblelevels) {
    if(var_3 > var_0) {
      var_0 = var_3;
    }
  }

  self setclientomnvar("ui_scrambler_strength", var_0);
}

function ref_1241A(var_0, var_1) {
  play_emp_scramble(var_0, var_1);
  scripts\engine\utility::ref_143A5("emp_cleared", "death");

  if(isDefined(var_0)) {
    stop_emp_scramble(var_0, var_1);
    return;
  }
}

function allow_emp_player(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "setPlayerEMPImmune")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "setPlayerEMPImmune")]](var_0);
    return;
  }
}

function can_emp_player() {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "getPlayerEMPImmune")) {
    return ![[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "getPlayerEMPImmune")]]();
  }

  return true;
}

function start_emp_effects_player(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "onPlayerEMPed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "onPlayerEMPed")]](var_0);
  }

  self setempjammed(1);
  scripts\common\utility::allow_killstreaks(0, "emp");
  scripts\common\utility::allow_supers(0, "emp");
}

function stop_emp_effects_player(var_0) {
  self setempjammed(0);

  if(!var_0) {
    scripts\common\utility::allow_killstreaks(1, "emp");
    scripts\common\utility::allow_supers(1, "emp");
    return;
  }
}

function emp_init() {
  var_0 = spawnStruct();
  level.emp = var_0;
  level.emp.ents = [];
}

function emp_get_level_data() {
  if(!isDefined(level.emp)) {
    emp_init();
  }

  return level.emp;
}

function emp_update_ents() {
  var_0 = emp_get_level_data();
  var_1 = [];

  foreach(var_3 in var_0.ents) {
    if(isDefined(var_3) && can_be_empd(var_3)) {
      var_1 = var_3;
    }
  }

  foreach(var_6 in level.mines) {
    if(isDefined(var_6) && can_be_empd(var_6)) {
      var_1 = var_6;
    }
  }

  var_8 = getEntArray("misc_turret", "classname");

  foreach(var_10 in var_8) {
    if(isDefined(var_10) && can_be_empd(var_10)) {
      var_1 = var_10;
    }
  }

  if(isDefined(level.activekillstreaks)) {
    foreach(var_13 in level.activekillstreaks) {
      if(isDefined(var_13) && can_be_empd(var_13)) {
        var_1 = var_13;
      }
    }
  }

  if(isDefined(level.vehicle)) {
    foreach(var_16 in level.vehicle.instances) {
      foreach(var_18 in var_16) {
        if(isDefined(var_18) && can_be_empd(var_18)) {
          var_1 = var_18;
        }
      }
    }
  }

  if(isDefined(level.decoygrenades)) {
    foreach(var_22 in level.decoygrenades) {
      if(isDefined(var_22) && can_be_empd(var_22)) {
        var_1 = var_22;
      }
    }
  }

  foreach(var_25 in level.players) {
    if(!isPlayer(var_25) && can_be_empd(var_25)) {
      var_1 = var_25;
    }
  }

  if(isDefined(level.owner_name)) {
    foreach(var_28 in level.owner_name) {
      var_1 = var_28;
    }
  }

  var_0.entscurrent = var_1;
  thread emp_reset_ents();
}

function emp_reset_ents() {
  var_0 = emp_get_level_data();
  waittillframeend();
  var_0.entscurrent = undefined;
}