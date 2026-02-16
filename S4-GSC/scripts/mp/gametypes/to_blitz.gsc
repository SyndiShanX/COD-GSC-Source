/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_blitz.gsc
*************************************************/

main() {
  _id_997B();
  _id_07DC::init();
  _id_07DC::_id_D854();

  if(_func_0127()) {
    scripts\mp\utility\game::_id_D4E0();
  }

  _id_997C();
  level._id_E6A1 = 0;
  level._id_ABAD = ::_id_ABAD;
}

_id_997A() {
  _id_997B();
  _id_997C();
  level._id_10CCD["waypoint_capture_take"] = "neutral";
  level._id_10CCC["waypoint_capture_take"] = 2;
  level._id_E6A1 = 1;
  _id_ABAD(1);
}

_id_997B() {
  level._id_ED22 = "to_blitz";
  level._id_41D2 = "to_blitz";
  setomnvar("ui_tac_ops_submode", level._id_41D2);
}

_id_997C() {
  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA("to_blitz", 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1("to_blitz", 10);
    scripts\mp\utility\game::_id_C2AD("to_blitz", 65);
    scripts\mp\utility\game::_id_C2A9("to_blitz", 1);
    scripts\mp\utility\game::_id_C2D0("to_blitz", 1);
    scripts\mp\utility\game::_id_C27E("to_blitz", 0);
    scripts\mp\utility\game::_id_C25D("to_blitz", 0);
    scripts\mp\utility\game::_id_C250("to_blitz", 0);
    level._id_9BEB = 0;
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;
  level._id_ABC0 = scripts\mp\gamelogic::_id_4580;
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3e82ec037f53f7ef", 5);
  setdynamicdvar("#x3a3479dea289e376b", 10);
  setdynamicdvar("#x3ea832f361e5f0f9e", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("#x3ee3025e722ce448c", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("#x3e1cf872f62a500", 0);
  scripts\mp\utility\game::_id_C25D("conf", 0);
  setdynamicdvar("#x3d628ca1e61295f94", 0);
}

_id_ABAD(var_0) {
  var_1[0] = "dd";
  var_1[1] = "dd_bombzone";
  var_1[2] = "blocker";
  var_1[3] = "grind";
  var_1[4] = "dom";
  var_1[5] = "conf";
  var_1[6] = "barrier_checkpoint";
  _id_07D6::main(var_1);

  if(!istrue(var_0)) {
    scripts\mp\gametypes\tac_ops::_id_3AE4();
    _id_0EFE();
  }

  level._id_5856 = 0;
  setgameendtime(0);
  scripts\mp\utility\dvars::_id_D633("timelimit", 6);
  _id_D5AD();
  level._id_2AE1 = 1;
  level._id_F2AA = 2;
  thread _id_D850();
  thread _id_D8AB();
  thread _id_D84B();
  thread _id_D8B7();
}

_id_D850() {
  level._id_EE44 = [];
  var_0 = scripts\engine\utility::getStructArray("tank_spawn", "targetname");
  var_1 = 0;

  foreach(var_3 in var_0) {}

  thread _id_8248();
  setomnvar("ui_tacops_tank_a_health_percent", 1.0);
  setomnvar("ui_tacops_tank_b_health_percent", 1.0);
}

_id_2AE0() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  level endon("switch_modes");

  for(;;) {
    self waittill("damage", var_0);

    if(self._id_ED0F == 0) {
      setomnvar("ui_tacops_tank_a_health_percent", (self.maxhealth - self._id_014E) / self.maxhealth);
      continue;
    }

    if(self._id_ED0F == 1) {
      setomnvar("ui_tacops_tank_b_health_percent", (self.maxhealth - self._id_014E) / self.maxhealth);
    }
  }
}

_id_D8B7() {
  level waittill("goal_opened");
  var_0 = getent("tank_goal", "targetname");

  if(!isDefined(var_0)) {
    _id_E323();
  } else {
    level._id_A8E8 = [];
    level._id_A8E8[0] = var_0;
    var_1 = scripts\mp\gametypes\obj_dom::_id_D896(level._id_A8E8[0]);
    var_1._id_ABCB = ::_id_4D4F;
    level._id_A8E8[0] = var_1;
    level._id_5C3B = 1;
    level._id_5C41 = 1;
    waitframe();
    var_1._id_A544 = 1;
    var_1 _id_07D6::_id_D5C5(level._id_EE44);
    var_1 _id_07D6::_id_D639("axis");
    var_1 _id_07D6::_id_D8E0("any");
    var_1 _id_07D6::_id_15DF("enemy");
    var_1 _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
  }
}

_id_2AD7(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;

  if(var_3 == "MOD_MELEE") {
    return 0;
  }

  if(var_1.team == "allies") {
    return 0;
  }

  var_4 = _id_6B68(var_1, var_2, var_3, var_4, 3000, 10, 15, 20);
  var_0.damage = var_4;
  return var_4;
}

_id_6B68(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;

  if(var_2 != "MOD_MELEE") {
    switch (var_1.basename) {
      case "kineticpulse_emp_mp":
      case "super_trophy_mp":
      case "s4_c4_mp":
        self._id_8EE2 = 1;
        var_9 = var_5;
        break;
      case "tur_bradley_tacops_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_kgolf_mp":
      case "switch_blade_child_mp":
      case "drone_hive_projectile_mp":
      case "iw8_la_gromeo_mp":
      case "tur_bradley_mp":
      case "iw8_la_juliet_mp":
      case "emp_grenade_mp":
        self._id_8EE2 = 1;
        var_9 = var_6;
        break;
      case "s4_strafing_run_mp":
      case "power_exploding_drone_mp":
      case "jackal_cannon_mp":
      case "sentry_shock_missile_mp":
      case "pop_rocket_proj_mp":
        self._id_8EE2 = 0;
        var_9 = var_7;
        break;
      default:
        self._id_8EE2 = 0;
    }
  }

  if(isDefined(var_8)) {
    self._id_8EE2 = var_8;
  }

  if(self._id_8EE2 == 0) {
    return 0;
  }

  if(isDefined(var_9) && isDefined(var_2) && (var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_EXPLOSIVE_BULLET" || var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH" || var_2 == "MOD_GRENADE")) {
    var_3 = _func_0037(var_4 / var_9);
  }

  if(isDefined(var_0) && isDefined(self.owner)) {
    if(isDefined(var_0.owner)) {
      var_0 = var_0.owner;
    }

    if(var_0 == self.owner) {
      var_3 = _func_0037(var_3 / 2);
    }
  }

  return int(var_3);
}

_id_2AD6(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;

  if(level.teambased) {
    var_6 = "";

    if(isDefined(var_1) && isDefined(var_1.team)) {
      var_6 = var_1.team;
    }

    if(var_6 != self.team) {}
  } else if(isDefined(var_1) && (!isDefined(self.owner) || self.owner != var_1)) {}

  self._id_F3FE _id_07D6::_id_4799();
  thread _id_2ADE(var_1, var_2, var_3, 0);

  if(self._id_ED0F == 0) {
    setomnvar("ui_tacops_tank_a_health_percent", 0);
  } else if(self._id_ED0F == 1) {
    setomnvar("ui_tacops_tank_b_health_percent", 0);
  }
}

_id_2ADE(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.attacker = var_0;
  var_4.objweapon = var_1;
  var_4._id_9CD6 = var_2;
  _id_09D6::_id_93C6(var_4, var_3);
  level._id_F2AA--;

  if(level._id_F2AA == 0) {
    if(isDefined(level._id_AB4C)) {
      game["attackers"] = "allies";
      game["defenders"] = "axis";
      [[level._id_AB4C]]("axis");
    } else
      thread scripts\mp\gamelogic::_id_52F7("axis", game["end_reason"][game["attackers"] + "_eliminated"]);
  }
}

_id_8294() {
  var_0 = level._id_ED1E;
  _id_0817::_id_1136("allies", "mp_toblitz_spawn_allies", 1);
  _id_0817::_id_1136("axis", "mp_toblitz_spawn_axis", 1);
  var_0._id_F2A9 = [];
  var_0._id_F2A9["allies"] = _id_0817::_id_6D4E("mp_toblitz_spawn_allies");
  var_0._id_F2A9["axis"] = _id_0817::_id_6D4E("mp_toblitz_spawn_axis");

  if(var_0._id_F2A9["allies"].size <= 0) {
    _id_0817::_id_1136("allies", "mp_front_spawn_allies");
    var_0._id_F2A9["allies"] = _id_0817::_id_6D4E("mp_front_spawn_allies");
  }

  if(var_0._id_F2A9["axis"].size <= 0) {
    _id_0817::_id_1136("axis", "mp_front_spawn_axis");
    var_0._id_F2A9["axis"] = _id_0817::_id_6D4E("mp_front_spawn_axis");
  }
}

_id_6D4A() {
  var_0 = level._id_ED1E;
  var_1 = self.pers["team"];
  var_2 = _id_081C::_id_5A54(var_0._id_F2A9[var_1]);
  var_3 = undefined;
  return var_3;
}

_id_0EFE() {
  _id_0817::_id_D461("TDM");
  _id_081C::_id_D45F("to_blitz", "allies");
  _id_081C::_id_D45F("to_blitz", "axis");
  level._id_6D4A = ::_id_6D4A;
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4);
}

_id_ABA4() {
  if(self.team == "axis") {
    thread _id_ABA1();
  }

  var_0 = 0;

  if(self.team == "allies") {
    var_0 = 1;
  } else if(self.team == "axis") {
    var_0 = 2;
  }

  self setclientomnvar("ui_tacops_team", var_0);
  _id_0A76::_id_8E2C();
}

_id_ABA1() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");
  scripts\mp\equipment::giveequipment("equip_c4", "primary");
  var_0 = self _meth_8191("primary");

  foreach(var_2 in var_0) {
    var_3 = getweaponbasename(var_2);

    switch (var_3) {
      case "iw8_la_lapha_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_juliet_mp":
        var_4 = makeweapon("s4_pi_mike1911");
        scripts\cp_mp\utility\inventory_utility::_id_EDDF(var_2);
        self giveweapon(var_4);
        self _meth_819C(var_4);
        break;
    }
  }
}

_id_D8AB() {
  level._id_C959 = [];
  var_0 = getEntArray("rpg_cache", "targetname");
  var_1 = getEntArray("rpg_use_trigger", "targetname");

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = spawn("script_model", var_0[var_2].origin);
    var_3 setModel("care_package_iw7_dummy");
    var_3.angles = var_0[var_2].angles;
    var_0[var_2] scripts\mp\utility\outline::_id_ACD2(var_0[var_2], "axis", "outline_nodepth_cyan", "lowest");
    var_0[var_2]._id_ADAE = "axis";
    var_0[var_2]._id_83B6 = "friendly";
    var_0[var_2]._id_56E2 = 0;
    var_0[var_2]._id_4143 = 0;
    var_0[var_2]._id_FEE7 = 0;
    var_0[var_2]._id_FEB1 = 1;
    var_0[var_2]._id_7C8C = "care_package";
    var_0[var_2]._id_DDC9 = 1;
    var_0[var_2].trigger = var_1[var_2];
    var_0[var_2].trigger.angles = var_0[var_2].angles;
    var_0[var_2].trigger setcursorhint("HINT_NOICON");
    var_0[var_2].trigger sethintstring(&"MP/PICKUP_RPG7");
    var_0[var_2].trigger.team = "axis";
    var_0[var_2].trigger._id_4823 = var_0[var_2].origin;
    var_0[var_2]._id_ABCB = ::_id_C982;
    var_0[var_2] thread _id_07D6::_id_FE97();
    var_0[var_2] thread _id_C983("axis");
    level._id_C959[level._id_C959.size] = var_0[var_2];
  }
}

_id_C982(var_0) {
  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", 0.01);
  var_1 = var_0._id_8FC2;
  var_2 = var_0 dropitem(var_1);

  if(isDefined(var_2)) {
    var_2.owner = var_0;
    var_2._id_0481 = "dropped_weapon";
    var_2 thread scripts\mp\weapons::_id_10BCF();
    var_2 thread scripts\mp\weapons::_id_4783();
  }

  var_0 giveweapon("iw8_la_rpapa7_mp");
  var_0 _meth_819C("iw8_la_rpapa7_mp");
  var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("iw8_la_rpapa7_mp", 1);
  var_0._id_8FC2 = makeweapon("iw8_la_rpapa7_mp");
}

_id_C983(var_0) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    _id_D8CD(var_0);
    level waittill("joined_team");
  }
}

_id_D8CD(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.team != var_0) {
      self.trigger disableplayeruse(var_2);
      continue;
    }

    self.trigger _meth_80E0(var_2);
  }
}

_id_8248() {
  foreach(var_1 in level._id_2AD5._id_0F67["allies"]) {
    var_1._id_F3FE = var_1 _id_07D6::_id_4069(var_1, (0, 0, 0));
    var_1._id_F3FE._id_A90C = 0;
    var_1._id_F3FE._id_A90B = 1;
    var_1._id_F3FE._id_A912 = 0.05;
    var_1._id_F3FE._id_1041A = "any";
    var_1._id_852E = 1;
    var_1._id_F3FE _id_07D6::_id_D61B(level._id_7C86, level._id_7C6A);
    var_1 thread _id_10B86();
  }
}

_id_10B86() {
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::waittill_any_3("bradley_driverUpdate", "death", "bradley_vehicleExit");
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "driver");

    if(isDefined(var_0) && isDefined(self._id_F3FE._id_1041A)) {
      self._id_F3FE _id_07D6::_id_D61B(level._id_7C4B, level._id_7C6A);
      continue;
    }

    if(isDefined(self._id_F3FE._id_1041A)) {
      self._id_F3FE _id_07D6::_id_D61B(level._id_7C86, level._id_7C6A);
    }
  }
}

_id_D5AD() {
  level._id_10CCD["waypoint_capture_take"] = "neutral";
  level._id_10CCC["waypoint_capture_take"] = 2;
  level._id_7C86 = "waypoint_capture_take";
  level._id_7C6A = "waypoint_capture_kill";
  level._id_7C74 = "koth_neutral";
  level._id_7C42 = "koth_enemy";
  level._id_7C4B = "koth_friendly";
  level._id_7C48 = "waypoint_hardpoint_contested";
  level._id_7C87 = "waypoint_taking_chevron";
  level._id_7C6F = "waypoint_hardpoint_losing";
}

_id_D84B() {
  var_0 = getEntArray("barrier_checkpoint", "targetname");

  foreach(var_2 in var_0) {
    var_2 setCanDamage(1);
    var_2.health = 10000;
    var_2.team = "axis";
    var_2 thread _id_2295();
    var_2 thread _id_2296();
  }

  level._id_F371 = var_0.size;
}

_id_2295() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_0);
    iprintln("Wall hit for " + var_0 + ", health left " + self.health);
  }
}

_id_2296() {
  level endon("game_ended");
  self waittill("death");
  iprintln("Wall DEAD");
  thread _id_2292();
}

_id_2291(var_0, var_1, var_2, var_3, var_4) {
  if(level.teambased) {
    var_5 = "";

    if(isDefined(var_0) && isDefined(var_0.team)) {
      var_5 = var_0.team;
    }

    if(var_5 != self.team) {}
  } else if(isDefined(var_0) && (!isDefined(self.owner) || self.owner != var_0)) {}

  thread _id_2292(var_0, var_1, var_2, 0);
}

_id_2292(var_0, var_1, var_2, var_3) {
  playFX(level._id_2294, self.origin);
  playFX(level._id_2294, self.origin + (0, -150, 0));
  playFX(level._id_2294, self.origin + (0, 150, 0));
  playFX(level._id_2294, self.origin + (150, 0, 0));
  playFX(level._id_2294, self.origin + (-150, 0, 0));
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.75, 2.0, self.origin, 2000);
  self delete();
  level._id_F371--;

  if(level._id_F371 == 0) {
    level notify("goal_opened");
  }
}

_id_2293(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "MOD_MELEE") {
    return 0;
  }

  if(var_0.team == self.team) {
    return 0;
  }

  var_3 = _id_6B67(var_0, var_1, var_2, var_3, 10000, 10, 15, 50);
  return var_3;
}

_id_6B67(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_1._id_0245;
  var_10 = 0;

  if(istrue(var_9)) {
    var_11 = scripts\mp\utility\weapon::_id_6E69(var_1);

    foreach(var_13 in var_11) {
      if(var_13 == "gl") {
        var_10 = 1;
        break;
      }
    }
  }

  var_15 = undefined;

  if(var_2 != "MOD_MELEE") {
    switch (var_1.basename) {
      case "iw8_la_lapha_mp":
      case "iw8_la_rpapa7_mp":
      case "iw8_la_juliet_mp":
      case "s4_c4_mp":
        self._id_8EE2 = 1;
        var_15 = var_5;
        break;
      case "switch_blade_child_mp":
      case "drone_hive_projectile_mp":
      case "tur_bradley_mp":
      case "s4_tur_main_tank_mike4_mp":
        self._id_8EE2 = 1;
        var_15 = var_6;
        break;
      case "s4_strafing_run_mp":
      case "jackal_cannon_mp":
      case "lighttank_mp":
        self._id_8EE2 = 0;
        var_15 = var_7;
        break;
      case "iw7_arclassic_mp":
        if(istrue(var_10)) {
          self._id_8EE2 = 0;
          var_15 = var_7;
        }

        break;
      default:
        var_3 = 0;
        break;
    }
  }

  if(isDefined(var_8)) {
    self._id_8EE2 = var_8;
  }

  if(isDefined(var_15) && isDefined(var_2) && (var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_EXPLOSIVE_BULLET" || var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH" || var_2 == "MOD_GRENADE")) {
    var_3 = _func_0037(var_4 / var_15);
  }

  if(isDefined(var_0) && isDefined(self.owner)) {
    if(isDefined(var_0.owner)) {
      var_0 = var_0.owner;
    }

    if(var_0 == self.owner) {
      var_3 = _func_0037(var_3 / 2);
    }
  }

  return int(var_3);
}

_id_ABC0() {
  if(isDefined(level._id_AB4C)) {
    var_0 = scripts\mp\gamescore::_id_2F03(0);
    [[level._id_AB4C]](var_0);
  }

  scripts\mp\gamescore::_id_0CF2("axis", 1, 0);
  thread scripts\mp\gamelogic::_id_52F7("axis", game["end_reason"]["objective_completed"]);
}

_id_E323() {
  level._id_5C3B = 1;
  level._id_5C41 = 1;
  var_0 = spawnStruct();
  var_0.origin = (7524, 11709, 308);
  var_0.angles = (0, 0, 0);
  var_1 = spawn("trigger_radius", var_0.origin, 0, 160, 128);
  var_1._id_0359 = 160;
  var_0.trigger = var_1;
  var_0.trigger._id_CD99 = "";
  var_0._id_ADAE = "neutral";
  var_2 = var_0.origin + (0, 0, 32);
  var_3 = var_0.origin + (0, 0, -32);
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, undefined, scripts\engine\trace::_id_3EF6(1));
  var_0.origin = var_4["position"];
  var_0._id_FB2F = vectortoangles(var_4["normal"]);
  var_0._id_01D7 = anglesToForward(var_0._id_FB2F);
  var_0._id_0376 = anglestoright(var_0._id_FB2F);
  var_0._id_10430[0] = spawn("script_model", var_0.origin);
  var_0._id_10430[0].angles = var_0.angles;
  var_5 = _id_07D6::_id_406E("neutral", var_0.trigger, var_0._id_10430, (0, 0, 100));
  var_5 _id_07D6::_id_15DF("enemy");
  var_5 _id_07D6::_id_D8D2(1);
  var_5 _id_07D6::_id_D8D1(&"MP/SECURING_POSITION");
  var_6 = "";
  var_5.label = var_6;
  var_5 _id_07D6::_id_D61B(level._id_7C5F, level._id_7C4B);
  var_5 _id_07D6::_id_D8E0("any");
  var_5._id_ABCB = ::_id_4D4F;
  var_5._id_AA79 = scripts\mp\gametypes\obj_dom::_id_4D50;
  var_5._id_ABD4 = scripts\mp\gametypes\obj_dom::_id_4D52;
  var_5._id_AAC2 = scripts\mp\gametypes\obj_dom::_id_4D51;
  var_5._id_AA8D = scripts\mp\gametypes\obj_dom::_id_4D47;
  var_5._id_ABC7 = scripts\mp\gametypes\obj_dom::_id_4D4C;
  var_5._id_A6C4 = 1;
  var_5._id_7C8C = "domFlag";
  var_5._id_37F3 = level._id_5C3B * 1000;
  var_5._id_5BC6 = 1;
  var_5 _id_07D6::_id_D5C5(level._id_EE44);
  var_5._id_A544 = 1;
  level._id_A8E8 = [];
  level._id_A8E8[0] = var_5;
  var_2 = var_0._id_10430[0].origin + (0, 0, 32);
  var_3 = var_0._id_10430[0].origin + (0, 0, -32);
  var_7 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
  var_8 = [];
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, var_8, var_7);
  var_5._id_22B7 = var_4["position"];
  var_9 = vectortoangles(var_4["normal"]);
  var_5._id_22B6 = anglesToForward(var_9);
  var_10 = spawn("script_model", var_5._id_22B7);
  var_10 setModel("dom_flag_scriptable");
  var_10.angles = _func_030A(var_5._id_22B6, var_10.angles);
  var_5._id_03A9 = var_10;
  var_5._id_103BF = "";

  if(var_5.trigger._id_0359 == 160) {
    var_5._id_103BF = "_160";
  } else if(var_5.trigger._id_0359 == 90) {
    var_5._id_103BF = "_90";
  } else if(var_5.trigger._id_0359 == 315) {
    var_5._id_103BF = "_300";
  }

  var_5 _id_07D6::_id_D639("axis");
  var_5 _id_07D6::_id_D8E0("any");
  var_5 _id_07D6::_id_15DF("enemy");
  var_5 _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
  var_5 scripts\mp\gametypes\obj_dom::_id_FC64("axis", 0);
}

_id_4D4F(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4F(var_0);

  if(var_0.team == "allies") {
    scripts\mp\gamescore::_id_0CF2("allies", 1, 0);
    thread scripts\mp\gamelogic::_id_52F7("allies", game["end_reason"]["objective_completed"]);
  }
}