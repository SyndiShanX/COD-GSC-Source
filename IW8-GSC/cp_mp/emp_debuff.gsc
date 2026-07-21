/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\emp_debuff.gsc
***********************************************/

emp_debuff_init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8B1804DF2043", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8B1804DF2043", "_encstr_88C5055208731B")]]();
}

apply_emp(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.attacker = var_0;
  var_2.victim = self;
  var_2.objweapon = var_1;
  apply_emp_struct(var_2);
}

apply_emp_struct(var_0) {
  if(!isDefined(var_0.damage))
    var_0.damage = 1;

  if(!isDefined(var_0.meansofdeath))
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";

  if(!isDefined(var_0.point))
    var_0.point = (0, 0, 0);

  if(!isDefined(var_0.direction_vec))
    var_0.direction_vec = (0, 0, 0);

  if(!isDefined(var_0.modelname))
    var_0.modelname = 0;

  if(!isDefined(var_0.partname))
    var_0.partname = "_encstr_B40101";

  if(!isDefined(var_0.tagname))
    var_0.tagname = 0;

  if(!isDefined(var_0.damageflags))
    var_0.damageflags = 0;

  if(!isDefined(var_0.hitloc))
    var_0.hitloc = "_encstr_8BBA05185F8B99";

  if(!isDefined(var_0.timeoffset))
    var_0.timeoffset = 0;

  if(!isDefined(var_0.victim.empcount))
    var_0.victim.empcount = 0;

  var_0.victim.empcount++;

  if(var_0.victim.empcount == 1) {
    if(isPlayer(var_0.victim))
      var_0.victim thread start_emp_effects_player(var_0);

    if(isDefined(var_0.victim.empstartcallback))
      var_0.victim thread[[var_0.victim.empstartcallback]](var_0);

    var_0.victim notify("_encstr_92800CAD71CBBF6251B88BE3B059", var_0);
  }

  if(isDefined(var_0.victim.empapplycallback))
    var_0.victim thread[[var_0.victim.empapplycallback]](var_0);

  var_0.victim notify("_encstr_AB770C81EB09798E707B29137D77", var_0);
}

remove_emp() {
  if(!is_empd()) {
    return;
  }
  self.empcount--;

  if(isDefined(self.empremovecallback))
    self thread[[self.empremovecallback]]();

  self notify("_encstr_999E0C153D33A19EB8F748C312F7");

  if(self.empcount == 0)
    clear_emp(0);
}

clear_emp(var_0) {
  if(isDefined(self.empcount)) {
    self.empcount = undefined;

    if(isPlayer(self))
      thread stop_emp_effects_player(istrue(var_0));
    else if(isDefined(self.empclearcallback))
      self thread[[self.empclearcallback]](istrue(var_0));

    self notify("_encstr_99C40CA749E1F16B80389FEB2BB9");
  }
}

is_emp_weapon(var_0) {
  var_1 = 0;

  switch (var_0.basename) {
    case "_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E":
      var_1 = 1;
  }

  return var_1;
}

is_emp_damage(var_0, var_1) {
  if(!is_emp_weapon(var_0))
    return 0;

  if(!isexplosivedamagemod(var_1))
    return 0;

  return 1;
}

allow_emp(var_0) {
  if(isPlayer(self))
    allow_emp_player(var_0);
  else {
    if(!isDefined(self.empnotallowed))
      self.empnotallowed = 0;

    if(var_0)
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
  var_0 = emp_get_level_data();
  emp_update_ents();
  return var_0.entscurrent;
}

set_apply_emp_callback(var_0) {
  self.empapplycallback = var_0;
}

set_start_emp_callback(var_0) {
  self.empstartcallback = var_0;
}

set_remove_emp_callback(var_0) {
  self.empremovecallback = var_0;
}

set_clear_emp_callback(var_0) {
  self.empclearcallback = var_0;
}

add_emp_ent(var_0) {
  var_1 = emp_get_level_data();
  var_2 = var_0 getentitynumber();
  var_1.ents[var_2] = var_0;
  return var_2;
}

play_emp_scramble(var_0) {
  if(var_0 == 0) {
    return;
  }
  if(!isDefined(self.empscramblelevels))
    self.empscramblelevels = [];

  var_1 = self.empscramblelevels[var_0];

  if(!isDefined(var_1))
    var_1 = 0;

  self.empscramblelevels[var_0] = var_1 + 1;
  _update_emp_scramble();
}

stop_emp_scramble(var_0) {
  if(var_0 == 0) {
    return;
  }
  self.empscramblelevels[var_0] = self.empscramblelevels[var_0] - 1;

  if(self.empscramblelevels[var_0] == 0)
    self.empscramblelevels[var_0] = undefined;

  _update_emp_scramble();
}

_update_emp_scramble() {
  var_0 = 0;

  foreach(var_3, var_2 in self.empscramblelevels) {
    if(var_3 > var_0)
      var_0 = var_3;
  }

  self setclientomnvar("_encstr_B40316EAB4AF6E6CC9855BC48DCAC9D7CD474EACDCB33AD0", var_0);
}

_id_1241A(var_0, var_1) {
  var_0 play_emp_scramble(var_1);
  scripts\engine\utility::_id_143A5("_encstr_99C40CA749E1F16B80389FEB2BB9", "_encstr_AD75063D571AE108");

  if(isDefined(var_0))
    var_0 stop_emp_scramble(var_1);
}

allow_emp_player(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8B1804DF2043", "_encstr_871F133A5501E99CD93097C339B478A09BF903F5CD"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8B1804DF2043", "_encstr_871F133A5501E99CD93097C339B478A09BF903F5CD")]](var_0);
}

can_emp_player() {
  if(!scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8B1804DF2043", "_encstr_88D513EC563A05D8582FB24EA8A6A052B55BAB372B"))
    return ![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8B1804DF2043", "_encstr_88D513EC563A05D8582FB24EA8A6A052B55BAB372B")]]();

  return 1;
}

start_emp_effects_player(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8B1804DF2043", "_encstr_95C70E4738C17168230FD2A5E9AB1D21"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8B1804DF2043", "_encstr_95C70E4738C17168230FD2A5E9AB1D21")]](var_0);

  self setempjammed(1);
  scripts\common\utility::allow_killstreaks(0, "_encstr_8B1804DF2043");
  scripts\common\utility::allow_supers(0, "_encstr_8B1804DF2043");
}

stop_emp_effects_player(var_0) {
  self setempjammed(0);

  if(!var_0) {
    scripts\common\utility::allow_killstreaks(1, "_encstr_8B1804DF2043");
    scripts\common\utility::allow_supers(1, "_encstr_8B1804DF2043");
  }
}

emp_init() {
  var_0 = spawnStruct();
  level.emp = var_0;
  level.emp.ents = [];
}

emp_get_level_data() {
  if(!isDefined(level.emp))
    emp_init();

  return level.emp;
}

emp_update_ents() {
  var_0 = emp_get_level_data();
  var_1 = [];

  foreach(var_3 in var_0.ents) {
    if(isDefined(var_3) && var_3 can_be_empd())
      var_1[var_1.size] = var_3;
  }

  foreach(var_6 in level.mines) {
    if(isDefined(var_6) && var_6 can_be_empd())
      var_1[var_1.size] = var_6;
  }

  var_8 = getEntArray("_encstr_97710C6B2DCD1BAF3AD54E4E598E", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_10 in var_8) {
    if(isDefined(var_10) && var_10 can_be_empd())
      var_1[var_1.size] = var_10;
  }

  if(isDefined(level.activekillstreaks)) {
    foreach(var_13 in level.activekillstreaks) {
      if(isDefined(var_13) && var_13 can_be_empd())
        var_1[var_1.size] = var_13;
    }
  }

  if(isDefined(level.vehicle)) {
    foreach(var_16 in level.vehicle.instances) {
      foreach(var_18 in var_16) {
        if(isDefined(var_18) && var_18 can_be_empd())
          var_1[var_1.size] = var_18;
      }
    }
  }

  if(isDefined(level.decoygrenades)) {
    foreach(var_22 in level.decoygrenades) {
      if(isDefined(var_22) && var_22 can_be_empd())
        var_1[var_1.size] = var_22;
    }
  }

  foreach(var_25 in level.players) {
    if(!isPlayer(var_25) && var_25 can_be_empd())
      var_1[var_1.size] = var_25;
  }

  if(isDefined(level.owner_name)) {
    foreach(var_28 in level.owner_name)
    var_1[var_1.size] = var_28;
  }

  var_0.entscurrent = var_1;
  thread emp_reset_ents();
}

emp_reset_ents() {
  var_0 = emp_get_level_data();
  waittillframeend;
  var_0.entscurrent = undefined;
}