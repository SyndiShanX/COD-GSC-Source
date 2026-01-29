/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\civilian\civilian_init.gsc
**************************************************/

main() {
  animscripts\init::main();
  _id_407F();
}

#using_animtree("generic_human");

_id_407F() {
  self.allowdeath = 1;
  self._id_117F = 1;
  self._id_1199 = 1;
  self._id_1099 = 1;
  self._id_241B = 1;
  self orientmode("face default");
  self.combatmode = "no_cover";
  self pushplayer(0);
  self.a._id_0FDD = 1;

  if(!isDefined(level._id_4080)) {
    level._id_4080 = 1;
    level._id_0C59["default_civilian"]["run_combat"][0] = % civilian_run_upright;
    level._id_0C59["default_civilian"]["run_hunched_combat"][0] = % civilian_run_hunched_a;
    level._id_0C59["default_civilian"]["run_hunched_combat"][1] = % civilian_run_hunched_c;
    level._id_0C59["default_civilian"]["run_hunched_combat"][2] = % civilian_run_hunched_flinch;
    level._id_0C59["default_civilian"]["run_noncombat"][0] = % civilian_walk_cool;
    var_0 = [];
    var_0[0] = 3;
    var_0[1] = 3;
    var_0[2] = 1;
    level._id_0C59["default_civilian"]["run_hunched_weights"] = common_scripts\utility::get_cumulative_weights(var_0);
    var_0 = [];
    var_0[0] = 1;
    level._id_0C59["default_civilian"]["run_weights"] = common_scripts\utility::get_cumulative_weights(var_0);
    level._id_0C59["default_civilian"]["idle_noncombat"][0] = % unarmed_cowerstand_idle;
    level._id_0C59["default_civilian"]["idle_combat"][0] = % casual_crouch_v2_idle;
    level._id_0C59["default_civilian"]["idle_combat"][1] = % unarmed_cowercrouch_idle_duck;
    anim._id_400F[0] = % unarmed_cowerstand_react;
    anim._id_400F[1] = % unarmed_cowercrouch_react_a;
    anim._id_400F[2] = % unarmed_cowercrouch_react_b;
  }

  var_1 = undefined;

  if(isDefined(self._id_4081)) {
    self._id_1032 = self._id_4081;
    _id_4083(self._id_4081);
    self.alertlevel = "noncombat";
    _id_4088();
  } else {
    self._id_1032 = "default_civilian";
    self.alertlevel = "alert";
    _id_4089();
  }

  thread _id_408C();
  self.dropweapon = 0;
  animscripts\shared::_id_23C8();
  self._id_4082 = 0;
}

_id_4083(var_0) {
  if(isDefined(self._id_4084)) {
    return;
  }
  _id_4087();
  var_1 = anim._id_4085[var_0];

  if(isDefined(var_1)) {
    self attach(var_1, "tag_inhand", 1);
    self._id_4084 = 1;
  }
}

_id_4086(var_0) {
  if(isDefined(self._id_4084)) {
    self._id_4084 = undefined;
    self detach(anim._id_4085[var_0], "tag_inhand");
  }
}

_id_4087() {
  if(isDefined(anim._id_4085)) {
    return;
  }
  anim._id_4085 = [];
  anim._id_4085["civilian_briefcase_walk"] = "com_metal_briefcase";
  anim._id_4085["civilian_crazy_walk"] = "electronics_pda";
  anim._id_4085["civilian_cellphone_walk"] = "com_cellphone_on";
  anim._id_4085["sit_lunch_A"] = "com_cellphone_on";
  anim._id_4085["civilian_soda_walk"] = "ma_cup_single_closed";
  anim._id_4085["civilian_paper_walk"] = "paper_memo";
  anim._id_4085["civilian_coffee_walk"] = "cs_coffeemug02";
  anim._id_4085["civilian_pda_walk"] = "electronics_pda";
  anim._id_4085["reading1"] = "open_book";
  anim._id_4085["reading2"] = "open_book";
  anim._id_4085["texting_stand"] = "electronics_pda";
  anim._id_4085["texting_sit"] = "electronics_pda";
  anim._id_4085["smoking1"] = "prop_cigarette";
  anim._id_4085["smoking2"] = "prop_cigarette";
}

_id_4088() {
  self.turnrate = 0.2;

  if(isDefined(self._id_4081)) {
    var_0 = % civilian_briefcase_walk_dodge_l;
    var_1 = % civilian_briefcase_walk_dodge_r;

    if(isDefined(level._id_0C59[self._id_1032]["dodge_left"])) {
      var_0 = level._id_0C59[self._id_1032]["dodge_left"];

    }
    if(isDefined(level._id_0C59[self._id_1032]["dodge_right"])) {
      var_1 = level._id_0C59[self._id_1032]["dodge_right"];

    }
    animscripts\move::_id_10D0(var_0, var_1);
  }

  if(isDefined(level._id_0C59[self._id_1032]["turn_left_90"])) {
    self._id_10C3 = animscripts\civilian\civilian_move::_id_407C;
    self._id_10C6 = 0.1;
    maps\_utility::_id_2722();
  } else {
    maps\_utility::_id_2721();

  }
  self._id_0FBC = level._id_0C59[self._id_1032]["run_noncombat"];
  self._id_1081 = self._id_0FBC;
  self._id_0FD4 = undefined;

  if(self._id_1032 == "default_civilian") {
    self._id_0FBD = level._id_0C59[self._id_1032]["run_weights_noncombat"];
    self._id_1082 = self._id_0FBD;
  }
}

_id_4089() {
  self notify("combat");
  animscripts\move::_id_10D1();
  self._id_10C6 = undefined;
  maps\_utility::_id_2722();
  self.turnrate = 0.3;
  var_0 = randomint(3) < 1;

  if(isDefined(self._id_408A)) {
    var_0 = 1;
  } else if(isDefined(self._id_408B)) {
    var_0 = 0;

  }
  if(var_0) {
    self._id_10C3 = animscripts\civilian\civilian_move::_id_407D;
    self._id_0FBC = level._id_0C59["default_civilian"]["run_combat"];
    self._id_0FBD = level._id_0C59["default_civilian"]["run_weights"];
  } else {
    self._id_10C3 = animscripts\civilian\civilian_move::_id_407E;
    self._id_0FBC = level._id_0C59["default_civilian"]["run_hunched_combat"];
    self._id_0FBD = level._id_0C59["default_civilian"]["run_hunched_weights"];
  }

  self._id_0FD4 = [];
  self._id_0FD4[0] = % run_react_stumble;
  self._id_1081 = self._id_0FBC;
  self._id_1082 = self._id_0FBD;
  _id_4086(self._id_4081);
}

_id_408C() {
  self endon("death");
  self endon("disable_combat_state_check");
  var_0 = self.alertlevelint > 1;

  for(;;) {
    var_1 = self.alertlevelint > 1;

    if(var_0 && !var_1) {
      _id_4088();
    } else if(!var_0 && var_1) {
      _id_4089();

    }
    var_0 = var_1;
    wait 0.05;
  }
}