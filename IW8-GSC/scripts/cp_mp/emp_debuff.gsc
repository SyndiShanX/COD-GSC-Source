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

function apply_emp(var0, var1) {
  var2 = spawnStruct();
  var2.attacker = var0;
  var2.victim = self;
  var2.objweapon = var1;
  apply_emp_struct(var2);
}

function apply_emp_struct(var0) {
  if(!isDefined(var0.damage)) {
    var0.damage = 1;
  }

  if(!isDefined(var0.meansofdeath)) {
    var0.meansofdeath = "MOD_EXPLOSIVE";
  }

  if(!isDefined(var0.point)) {
    var0.point = (0, 0, 0);
  }

  if(!isDefined(var0.direction_vec)) {
    var0.direction_vec = (0, 0, 0);
  }

  if(!isDefined(var0.modelname)) {
    var0.modelname = 0;
  }

  if(!isDefined(var0.partname)) {
    var0.partname = "";
  }

  if(!isDefined(var0.tagname)) {
    var0.tagname = 0;
  }

  if(!isDefined(var0.damageflags)) {
    var0.damageflags = 0;
  }

  if(!isDefined(var0.hitloc)) {
    var0.hitloc = "none";
  }

  if(!isDefined(var0.timeoffset)) {
    var0.timeoffset = 0;
  }

  if(!isDefined(var0.victim.empcount)) {
    var0.victim.empcount = 0;
  }

  var0.victim.empcount++;

  if(var0.victim.empcount == 1) {
    if(isPlayer(var0.victim)) {
      thread start_emp_effects_player(var0.victim);
    }

    if(isDefined(var0.victim.empstartcallback)) {
      var0.victim thread[[var0.victim.empstartcallback]](var0);
    }

    var0.victim notify("emp_started", var0);
  }

  if(isDefined(var0.victim.empapplycallback)) {
    var0.victim thread[[var0.victim.empapplycallback]](var0);
  }

  var0.victim notify("emp_applied", var0);
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

function clear_emp(var0) {
  if(isDefined(self.empcount)) {
    self.empcount = undefined;

    if(isPlayer(self)) {
      thread stop_emp_effects_player(istrue(var0));
    } else if(isDefined(self.empclearcallback)) {
      self thread[[self.empclearcallback]](istrue(var0));
    }

    self notify("emp_cleared");
    return;
  }
}

function is_emp_weapon(var0) {
  var1 = 0;

  switch (var0.basename) {
    case "emp_grenade_mp":
      var1 = 1;
      break;
  }

  return var1;
}

function is_emp_damage(var0, var1) {
  if(!is_emp_weapon(var0)) {
    return false;
  }

  if(!isexplosivedamagemod(var1)) {
    return false;
  }

  return true;
}

function allow_emp(var0) {
  if(isPlayer(self)) {
    allow_emp_player(var0);
    return;
  }

  if(!isDefined(self.empnotallowed)) {
    self.empnotallowed = 0;
  }

  if(var0) {
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
  var0 = emp_get_level_data();
  emp_update_ents();
  return var0.entscurrent;
}

function set_apply_emp_callback(var0) {
  self.empapplycallback = var0;
}

function set_start_emp_callback(var0) {
  self.empstartcallback = var0;
}

function set_remove_emp_callback(var0) {
  self.empremovecallback = var0;
}

function set_clear_emp_callback(var0) {
  self.empclearcallback = var0;
}

function add_emp_ent(var0) {
  var1 = emp_get_level_data();
  var2 = var0 getentitynumber();
  var1.ents[var2] = var0;
  return var2;
}

function play_emp_scramble(var0) {
  if(var0 == 0) {
    return;
  }

  if(!isDefined(self.empscramblelevels)) {
    self.empscramblelevels = [];
  }

  var1 = self.empscramblelevels[var0];

  if(!isDefined(var1)) {
    var1 = 0;
  }

  self.empscramblelevels[var0] = var1 + 1;
  _update_emp_scramble();
}

function stop_emp_scramble(var0) {
  if(var0 == 0) {
    return;
  }

  self.empscramblelevels[var0] -= 1;

  if(self.empscramblelevels[var0] == 0) {
    self.empscramblelevels[var0] = undefined;
  }

  _update_emp_scramble();
}

function _update_emp_scramble() {
  var0 = 0;

  foreach(var2 in self.empscramblelevels) {
    if(var3 > var0) {
      var0 = var3;
    }
  }

  self setclientomnvar("ui_scrambler_strength", var0);
}

function ref_1241a(var0, var1) {
  play_emp_scramble(var0, var1);
  scripts\engine\utility::ref_143a5("emp_cleared", "death");

  if(isDefined(var0)) {
    stop_emp_scramble(var0, var1);
    return;
  }
}

function allow_emp_player(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "setPlayerEMPImmune")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "setPlayerEMPImmune")]](var0);
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

function start_emp_effects_player(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "onPlayerEMPed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "onPlayerEMPed")]](var0);
  }

  self setempjammed(1);
  scripts\common\utility::allow_killstreaks(0, "emp");
  scripts\common\utility::allow_supers(0, "emp");
}

function stop_emp_effects_player(var0) {
  self setempjammed(0);

  if(!var0) {
    scripts\common\utility::allow_killstreaks(1, "emp");
    scripts\common\utility::allow_supers(1, "emp");
    return;
  }
}

function emp_init() {
  var0 = spawnStruct();
  level.emp = var0;
  level.emp.ents = [];
}

function emp_get_level_data() {
  if(!isDefined(level.emp)) {
    emp_init();
  }

  return level.emp;
}

function emp_update_ents() {
  var0 = emp_get_level_data();
  var1 = [];

  foreach(var3 in var0.ents) {
    if(isDefined(var3) && can_be_empd(var3)) {
      var1 = var3;
    }
  }

  foreach(var6 in level.mines) {
    if(isDefined(var6) && can_be_empd(var6)) {
      var1 = var6;
    }
  }

  var8 = getEntArray("misc_turret", "classname");

  foreach(var10 in var8) {
    if(isDefined(var10) && can_be_empd(var10)) {
      var1 = var10;
    }
  }

  if(isDefined(level.activekillstreaks)) {
    foreach(var13 in level.activekillstreaks) {
      if(isDefined(var13) && can_be_empd(var13)) {
        var1 = var13;
      }
    }
  }

  if(isDefined(level.vehicle)) {
    foreach(var16 in level.vehicle.instances) {
      foreach(var18 in var16) {
        if(isDefined(var18) && can_be_empd(var18)) {
          var1 = var18;
        }
      }
    }
  }

  if(isDefined(level.decoygrenades)) {
    foreach(var22 in level.decoygrenades) {
      if(isDefined(var22) && can_be_empd(var22)) {
        var1 = var22;
      }
    }
  }

  foreach(var25 in level.players) {
    if(!isPlayer(var25) && can_be_empd(var25)) {
      var1 = var25;
    }
  }

  if(isDefined(level.owner_name)) {
    foreach(var28 in level.owner_name) {
      var1 = var28;
    }
  }

  var0.entscurrent = var1;
  thread emp_reset_ents();
}

function emp_reset_ents() {
  var0 = emp_get_level_data();
  waittillframeend();
  var0.entscurrent = undefined;
}