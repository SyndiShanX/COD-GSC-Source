/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist_util.gsc
************************************************/

_id_107BE() {
  if(isDefined(level._id_EA2C)) {
    return;
  }
  var_0 = scripts\engine\utility::get_target_ent("salter");
  var_0.count = 1;
  level._id_EA2C = var_0 scripts\sp\utility::_id_10619(1);
  level._id_EA2C thread scripts\sp\utility::_id_5131();
  level._id_EA2C._id_1FBB = "salter";
  level._id_EA2C scripts\sp\utility::_id_F3B5("r");
  level._id_EA2C scripts\sp\utility::_id_F2DA(0);
  level._id_EA2C thread scripts\sp\utility::_id_19FA("iw7_m4+acog4", "iw7_m8+m8scope_sp", 9999, 1, "iw7_m4+acogm4");
  level._id_EA2C.name = "Salter";
  level._id_EA2C.script_noteworthy = "salter";
  level._id_EA2C._id_1ED4 = ::_id_7C1F;
  level.allies[level.allies.size] = level._id_EA2C;
}

_id_EAF9() {
  level._id_EA2C thread scripts\sp\utility::_id_4125(1, 1, "iw7_m4+acogm4");
  level._id_EA2C thread scripts\sp\utility::_id_19FA("iw7_m4+acogm4", "iw7_m8+m8scope_sp", 9999, 1);
}

_id_EAFA() {
  level._id_EA2C thread scripts\sp\utility::_id_4125(1, 1, "iw7_m8+m8scope_sp");
  level._id_EA2C thread scripts\sp\utility::_id_19FA("iw7_m4+acogm4", "iw7_m8+m8scope_sp", 9999, 1, "iw7_m4+acogm4");
}

_id_10710() {
  var_0 = scripts\engine\utility::get_target_ent("gator");
  var_0.count = 1;
  level._id_76FB = var_0 scripts\sp\utility::_id_10619(1);
  level._id_76FB._id_1FBB = "gator";
  level._id_76FB.name = "Gator";
  level._id_76FB.script_noteworthy = "gator";
}

_id_107AF() {
  level._id_DC34 = getEnt("raines", "targetname") scripts\sp\utility::_id_10619(1);
  level._id_DC34._id_1FBB = "generic";
  level._id_DC34 scripts\sp\utility::_id_86E4();
  level._id_DC34 scripts\sp\utility::_id_F3BC();
  level._id_DC34 scripts\sp\utility::_id_51E1("casual");
  level._id_DC34 scripts\sp\utility::_id_F415(1);
  level._id_DC34.name = "Adm. Raines";
  level._id_76FB.script_noteworthy = "raines";
}

_id_106D9() {
  if(isDefined(level._id_6754)) {
    return;
  }
  var_0 = scripts\engine\utility::get_target_ent("ethan");
  var_0.count = 1;
  level._id_6754 = var_0 scripts\sp\utility::_id_10619(1);
  level._id_6754 thread scripts\sp\utility::_id_5131();
  level._id_6754._id_1FBB = "ethan";
  level._id_6754 scripts\sp\utility::_id_F3B5("r");
  level._id_6754 scripts\sp\utility::_id_F2DA(0);
  level._id_6754 scripts\sp\utility::_id_72EC("iw7_fhr", "primary");
  level._id_6754.name = "Ethan";
  level._id_6754.script_noteworthy = "ethan";
  level._id_6754._id_72C7 = 1;
  level._id_6754 _meth_8504(1, "soldier_boost");
  level.allies[level.allies.size] = level._id_6754;
}

_id_1073B() {
  var_0 = scripts\engine\utility::get_target_ent("hvt");
  level._id_920F = var_0 scripts\sp\utility::_id_10619(1);
  level._id_920F._id_1FBB = "hvt";
}

_id_10763() {
  var_0 = scripts\engine\utility::get_target_ent("marine_1");
  var_0.count = 1;
  level._id_B343 = var_0 scripts\sp\utility::_id_10619(1);
  level._id_B343 thread scripts\sp\utility::_id_5131();
  level._id_B343._id_1FBB = "marine";
  level._id_B343.name = "Private Ryan";
  level._id_B343 scripts\sp\utility::_id_F3B5("r");
  level._id_B343 scripts\sp\utility::_id_F2DA(0);
  level._id_B343 scripts\sp\utility::_id_72EC("iw7_ar57", "primary");
  level._id_B343.name = "Private Ryan";
  level._id_B343.script_noteworthy = "marine_1";
  level._id_B343._id_72C7 = 1;
}

_id_1065E() {
  if(isDefined(level._id_30F6)) {
    return;
  }
  var_0 = scripts\engine\utility::get_target_ent("brooks");
  var_0.count = 1;
  level._id_30F6 = var_0 scripts\sp\utility::_id_10619(1);
  level._id_30F6 thread scripts\sp\utility::_id_5131();
  level._id_30F6._id_1FBB = "brooks";
  level._id_30F6.name = "Brooks";
  level._id_30F6 scripts\sp\utility::_id_F3B5("r");
  level._id_30F6 scripts\sp\utility::_id_F2DA(0);
  level._id_30F6 scripts\sp\utility::_id_72EC("iw7_sdfar", "primary");
  level._id_30F6.name = "Brooks";
  level._id_30F6.script_noteworthy = "brooks";
  level._id_30F6._id_72C7 = 1;
  level._id_30F6._id_1ED4 = ::_id_7C1F;
  level.allies[level.allies.size] = level._id_30F6;
}

_id_1074D() {
  if(isDefined(level._id_A54E)) {
    return;
  }
  var_0 = scripts\engine\utility::get_target_ent("kashima");
  var_0.count = 1;
  level._id_A54E = var_0 scripts\sp\utility::_id_10619(1);
  level._id_A54E thread scripts\sp\utility::_id_5131();
  level._id_A54E._id_1FBB = "kashima";
  level._id_A54E.name = "Kashima";
  level._id_A54E scripts\sp\utility::_id_F3B5("r");
  level._id_A54E scripts\sp\utility::_id_F2DA(0);
  level._id_A54E scripts\sp\utility::_id_72EC("iw7_erad", "primary");
  level._id_A54E.name = "Kashima";
  level._id_A54E.script_noteworthy = "kashima";
  level._id_A54E._id_72C7 = 1;
  level._id_A54E._id_1ED4 = ::_id_7C1F;
  level.allies[level.allies.size] = level._id_A54E;
}

_id_10751() {
  if(isDefined(level._id_A70E)) {
    return;
  }
  var_0 = scripts\engine\utility::get_target_ent("kotch");
  var_0.count = 1;
  level._id_A70E = var_0 scripts\sp\utility::_id_10619(1);
  level._id_A70E thread scripts\sp\utility::_id_5131();
  level._id_A70E._id_1FBB = "kotch";
  level._id_A70E.name = "kotch";
  level._id_A70E.ignoreme = 1;
  level._id_A70E scripts\sp\utility::_id_F2DA(0);
  level._id_A70E.name = "Kotch";
  level._id_A70E.script_noteworthy = "kotch";
  level._id_A70E._id_72C7 = 1;
  level._id_A70E._id_C05C = 1;
}

#using_animtree("generic_human");

_id_7C1F() {
  return % body;
}

_id_9312() {
  if(isDefined(self._id_ED8A)) {
    return;
  }
  if(isDefined(self._id_12E6))
    _id_12BA0();

  self._id_12E6 = [];
  self.disableplayeradsloscheck = _id_EB5F(self.disableplayeradsloscheck, "disableplayeradsloscheck", 1);
  self.ignoreall = _id_EB5F(self.ignoreall, "ignoreall", 1);
  self.ignoreme = _id_EB5F(self.ignoreme, "ignoreme", 1);
  self.grenadeawareness = _id_EB5F(self.grenadeawareness, "grenadeawareness", 0);
  self.badplaceawareness = _id_EB5F(self.badplaceawareness, "badplaceawareness", 0);
  self.ignoreexplosionevents = _id_EB5F(self.ignoreexplosionevents, "ignoreexplosionevents", 1);
  self.ignorerandombulletdamage = _id_EB5F(self.ignorerandombulletdamage, "ignorerandombulletdamage", 1);
  self.ignoresuppression = _id_EB5F(self.ignoresuppression, "ignoresuppression", 1);
  self.dontavoidplayer = _id_EB5F(self.dontavoidplayer, "dontavoidplayer", 1);
  self.newenemyreactiondistsq = _id_EB5F(self.newenemyreactiondistsq, "newEnemyReactionDistSq", 0);
  self.disablebulletwhizbyreaction = _id_EB5F(self.disablebulletwhizbyreaction, "disableBulletWhizbyReaction", 1);
  self._id_55EF = _id_EB5F(self._id_55EF, "disableFriendlyFireReaction", 1);
  self.dontmelee = _id_EB5F(self.dontmelee, "dontMelee", 1);
  self._id_6EC4 = _id_EB5F(self._id_6EC4, "flashBangImmunity", 1);
  self.dodangerreact = _id_EB5F(self.dodangerreact, "doDangerReact", 0);
  self._id_BEFA = _id_EB5F(self._id_BEFA, "neverSprintForVariation", 1);
  self.a._id_5605 = _id_EB5F(self.a._id_5605, "a.disablePain", 1);
  self.allowpain = _id_EB5F(self.allowpain, "allowPain", 0);
  self.fixednode = _id_EB5F(self.fixednode, "fixedNode", 1);
  self._id_EDB0 = _id_EB5F(self._id_EDB0, "script_forcegoal", 1);
  self.goalradius = _id_EB5F(self.goalradius, "goalradius", 5);
}

_id_12BA0(var_0) {
  if(isDefined(self._id_ED8A)) {
    return;
  }
  if(isDefined(var_0) && var_0) {
    if(isDefined(self._id_12E6))
      self._id_12E6 = undefined;
  }

  self.disableplayeradsloscheck = _id_E2C5("disableplayeradsloscheck", 0);
  self.ignoreall = _id_E2C5("ignoreall", 0);
  self.ignoreme = _id_E2C5("ignoreme", 0);
  self.grenadeawareness = _id_E2C5("grenadeawareness", 1);
  self.badplaceawareness = _id_E2C5("badplaceawareness", 1);
  self.ignoreexplosionevents = _id_E2C5("ignoreexplosionevents", 0);
  self.ignorerandombulletdamage = _id_E2C5("ignorerandombulletdamage", 0);
  self.ignoresuppression = _id_E2C5("ignoresuppression", 0);
  self.dontavoidplayer = _id_E2C5("dontavoidplayer", 0);
  self.newenemyreactiondistsq = _id_E2C5("newEnemyReactionDistSq", 262144);
  self.disablebulletwhizbyreaction = _id_E2C5("disableBulletWhizbyReaction", undefined);
  self._id_55EF = _id_E2C5("disableFriendlyFireReaction", undefined);
  self.dontmelee = _id_E2C5("dontMelee", undefined);
  self._id_6EC4 = _id_E2C5("flashBangImmunity", undefined);
  self.dodangerreact = _id_E2C5("doDangerReact", 1);
  self._id_BEFA = _id_E2C5("neverSprintForVariation", undefined);
  self.a._id_5605 = _id_E2C5("a.disablePain", 0);
  self.allowpain = _id_E2C5("allowPain", 1);
  self.fixednode = _id_E2C5("fixedNode", 0);
  self._id_EDB0 = _id_E2C5("script_forcegoal", 0);
  self.goalradius = _id_E2C5("goalradius", 100);
  scripts\sp\utility::_id_61C7();
  self._id_12E6 = undefined;
}

_id_EB5F(var_0, var_1, var_2) {
  if(isDefined(var_0))
    self._id_12E6[var_1] = var_0;
  else
    self._id_12E6[var_1] = "none";

  return var_2;
}

_id_E2C5(var_0, var_1) {
  if(isDefined(self._id_12E6)) {
    if(isstring(self._id_12E6[var_0]) && self._id_12E6[var_0] == "none")
      return var_1;
    else
      return self._id_12E6[var_0];
  }

  return var_1;
}

_id_10616(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = _id_229B(getEntArray("actors", "script_noteworthy"), ::_id_3DD0);

  if(isDefined(var_0)) {
    var_0 = _id_2289(var_0);
    var_3 = [];
    var_4 = [];

    foreach(var_6 in var_0) {
      var_7 = strtok(var_6, "!");

      if(var_7[0] != var_6) {
        var_3 = scripts\engine\utility::array_add(var_3, var_7[0]);
        continue;
      }

      var_4 = scripts\engine\utility::array_add(var_4, var_6);
    }

    var_2 = _id_229E(var_2, var_4);
    var_2 = _id_229D(var_2, var_3);
  }

  if(isDefined(level._id_1684))
    level._id_1684 = scripts\engine\utility::array_removeundefined(level._id_1684);
  else
    level._id_1684 = [];

  var_9 = [];

  foreach(var_6, var_11 in var_2)
  _id_10615(var_6, var_11, var_1);
}

_id_10615(var_0, var_1, var_2) {
  var_3 = ["Lopez", "Jewels", "Thompson", "Myers", "Rocket", "Ozz", "Dayo", "Hall", "Drown", "PI"];
  var_1 scripts\sp\utility::_id_1747(::_id_1088D);
  var_4 = undefined;

  switch (var_0) {
    case "brooks":
      if(isDefined(level._id_30F6)) {
        return;
      }
      var_4 = var_1 scripts\sp\utility::_id_10619(var_2);
      var_4._id_1FBB = "brooks";
      level._id_30F6 = var_4;
      break;
    case "atom":
      if(isDefined(level._id_2429)) {
        return;
      }
      var_4 = var_1 scripts\sp\utility::_id_10619(var_2);
      var_4._id_1FBB = "atom";
      level._id_2429 = var_4;
      break;
    case "salter":
      if(isDefined(level._id_EA2C)) {
        return;
      }
      var_4 = var_1 scripts\sp\utility::_id_10619(var_2);
      var_4._id_1FBB = "salter";
      level._id_EA2C = var_4;
      break;
    case "hvt":
      if(isDefined(level._id_920F)) {
        return;
      }
      var_4 = var_1 scripts\sp\utility::_id_10619(var_2);
      var_4._id_1FBB = "hvt";
      var_4 thread scripts\sp\utility::_id_F2DA(0);
      var_4 scripts\sp\utility::_id_5504();
      level._id_920F = var_4;
      break;
    default:
  }

  var_4 _meth_839E();
  level._id_1684 = scripts\engine\utility::array_add(level._id_1684, var_4);
  var_1.count = 1;
}

_id_3DD0() {
  return isspawner(self);
}

_id_1088D(var_0) {
  scripts\sp\utility::_id_B14F();
  self._id_8E27 = 1;
  _id_9312();

  if(isDefined(var_0))
    self._id_5D6C = var_0;
}

_id_4046(var_0) {
  scripts\sp\utility::_id_1101B();

  if(isDefined(self._id_5D6C) && isDefined(self._id_5D6C._id_4D94) && isDefined(self._id_5D6C._id_4D94.allies))
    self._id_5D6C._id_4D94.allies = scripts\engine\utility::array_remove(self._id_5D6C._id_4D94.allies, self);

  if(isDefined(var_0) && var_0)
    self _meth_81D0();
  else
    self delete();
}

_id_106B5(var_0, var_1, var_2, var_3, var_4) {
  var_3 = _id_2289(var_3);
  var_5 = _id_0BBF::_id_106B8(var_0, var_1, var_2, var_3, undefined, var_4);
  var_5 _meth_83E8();
  var_5 setmaxpitchroll(5, 3);
  var_5 _id_5DB0();
  scripts\engine\utility::array_thread(var_3, ::_id_87E9, var_5);
  var_5._id_4D94._id_1FC0 = [];
  var_5._id_4D94._id_5A0C = [];
  var_5._id_4D94.fx["atmosphere_burn"] = [];

  foreach(var_7 in var_5._id_4D94._id_C743) {
    if(!isDefined(var_7._id_EE52)) {
      continue;
    }
    switch (var_7._id_EE52) {
      case "gator_chair":
        var_5._id_4D94._id_1FC0["gator"] = var_7;
        break;
      case "atom_chair":
        var_5._id_4D94._id_1FC0["atom"] = var_7;
        break;
      case "copilot_chair":
        var_5._id_4D94._id_1FC0["brooks"] = var_7;
        break;
      case "redshirt_chair":
        var_5._id_4D94._id_1FC0["redshirt"] = var_7;
        break;
      case "player_chair":
        var_5._id_4D94._id_1FC0["player_rig"] = var_7;
        break;
      case "atom_jump":
        var_5._id_4D94._id_1FC0["atom_jump"] = var_7;
        break;
      case "ds2_crash2":
      case "ds2_crash1":
        if(!isDefined(var_5._id_4D94._id_1FC0["ds2_crash_nodes"]))
          var_5._id_4D94._id_1FC0["ds2_crash_nodes"] = [];

        var_5._id_4D94._id_1FC0["ds2_crash_nodes"] = scripts\engine\utility::array_add(var_5._id_4D94._id_1FC0["ds2_crash_nodes"], var_7);
        break;
      case "doorfire_left":
        var_5._id_4D94._id_5A0C["left"] = var_7;
        break;
      case "doorfire_right":
        var_5._id_4D94._id_5A0C["right"] = var_7;
      case "barrier_bars":
        var_5._id_4D94._id_2853 = var_7;
      case "fx_atmosphere_burn":
        var_5._id_4D94.fx["atmosphere_burn"] = scripts\engine\utility::array_add(var_5._id_4D94.fx["atmosphere_burn"], var_7);
        break;
      case "snd_wing_engine_left":
        level._id_10395 = var_7;
        var_8 = "dropship_wing_engine_pos_l_lp";
        level._id_10395 thread _id_5E6F(var_8);
        break;
      case "snd_wing_engine_right":
        level._id_10396 = var_7;
        var_8 = "dropship_wing_engine_pos_r_lp";
        level._id_10396 thread _id_5E6F(var_8);
        break;
      case "snd_forward_engine_left":
        level._id_1038B = var_7;
        var_8 = "dropship_forward_engine_pos_l_lp";
        level._id_1038B thread _id_5E6F(var_8);
        break;
      case "snd_forward_engine_right":
        level._id_1038C = var_7;
        var_8 = "dropship_forward_engine_pos_r_lp";
        level._id_1038C thread _id_5E6F(var_8);
        break;
      case "snd_rear_engine_left":
        level._id_10393 = var_7;
        var_8 = "dropship_rear_engine_pos_l_lp";
        level._id_10393 thread _id_5E6F(var_8);
        break;
      case "snd_rear_engine_right":
        level._id_10394 = var_7;
        var_8 = "dropship_rear_engine_pos_r_lp";
        level._id_10394 thread _id_5E6F(var_8);
        break;
      case "snd_int_rear_left":
        level._id_10391 = var_7;
        var_8 = "dropship_rear_int_pos_l_lp";
        level._id_10391 thread _id_5E6F(var_8);
        break;
      case "snd_int_rear_right":
        level._id_10392 = var_7;
        var_8 = "dropship_rear_int_pos_r_lp";
        level._id_10392 thread _id_5E6F(var_8);
        break;
      case "snd_int_mid_left":
        level._id_1038F = var_7;
        var_8 = "dropship_wing_int_pos_l_lp";
        level._id_1038F thread _id_5E6F(var_8);
        break;
      case "snd_int_mid_right":
        level._id_10390 = var_7;
        var_8 = "dropship_wing_int_pos_r_lp";
        level._id_10390 thread _id_5E6F(var_8);
        break;
      case "snd_int_cockpit":
        level._id_1038E = var_7;
        var_8 = "dropship_cockpit_int_pos_lp";
        level._id_1038E thread _id_5E6F(var_8);
        break;
      case "snd_int_center":
        level._id_1038D = var_7;
        var_8 = "dropship_fly_atmos_lp";
        level._id_1038D thread _id_5E6F(var_8);
        break;
      case "enemy_board1":
        var_5._id_4D94._id_1FC0["enemy_board1"] = var_7;
        break;
      case "enemy_board2":
        var_5._id_4D94._id_1FC0["enemy_board2"] = var_7;
        break;
      default:
        break;
    }
  }

  var_5 scripts\sp\utility::_id_65E0("ent_flag_arrived");
  var_5 scripts\sp\utility::_id_65E0("ent_flag_lookat");
  var_5 scripts\sp\utility::_id_65E0("ent_flag_ally_left");
  var_5 scripts\sp\utility::_id_65E0("ent_flag_clear_lookat");
  scripts\engine\utility::array_call(var_5._id_4D94.allies, ::setthreatbiasgroup, "dropships");
  var_5._id_1D2A = [];

  foreach(var_11 in var_5._id_4D94._id_127C9) {
    if(isDefined(var_11.targetname) && issubstr(var_11.targetname, "ally")) {
      if(issubstr(var_11.targetname, "left")) {
        var_5._id_1D2A["left"] = var_11;
        continue;
      }

      if(issubstr(var_11.targetname, "right")) {
        var_5._id_1D2A["right"] = var_11;
        continue;
      }

      if(issubstr(var_11.targetname, "back"))
        var_5._id_1D2A["back"] = var_11;
    }
  }

  var_5 scripts\engine\utility::delaythread(0.1, ::_id_CCEF, 1);
  var_5 notify("stop_kicking_up_dust");
  return var_5;
}

_id_5DB0() {
  self setyawspeed(60, 25, 15, 0);
  self sethoverparams(0, 0, 0);
}

_id_87E9(var_0) {
  self endon("death");
  var_0 endon("death");
  self endon("stop_hack_stay_on_dropship");

  for(;;) {
    if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) > squared(500))
      self _meth_80F1(self.node.origin, self.node.angles);

    wait 5;
  }
}

_id_5E6F(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self playLoopSound(var_0);
}

_id_5EC2(var_0) {
  switch (var_0) {
    case "takeoff":
      level._id_10395 thread scripts\sp\utility::play_sound_on_entity("dropship_takeoff_engine_wing_l");
      level._id_10396 thread scripts\sp\utility::play_sound_on_entity("dropship_takeoff_engine_wing_r");
      level._id_10393 thread scripts\sp\utility::play_sound_on_entity("dropship_takeoff_engine_rear_l");
      level._id_10394 thread scripts\sp\utility::play_sound_on_entity("dropship_takeoff_engine_rear_r");
      break;
    case "land":
      level._id_10395 thread scripts\sp\utility::play_sound_on_entity("dropship_land_wing_engine_l");
      level._id_10396 thread scripts\sp\utility::play_sound_on_entity("dropship_land_wing_engine_r");
      level._id_10393 thread scripts\sp\utility::play_sound_on_entity("dropship_land_rear_engine_l");
      level._id_10394 thread scripts\sp\utility::play_sound_on_entity("dropship_land_rear_engine_r");
      break;
    case "bank_right":
    case "bank_left":
    case "bank":
      level._id_10395 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_wing_engine_l");
      level._id_10396 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_wing_engine_r");
      level._id_10393 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_rear_engine_l");
      level._id_10394 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_rear_engine_r");
      break;
    case "ascend":
      level._id_10395 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_wing_engine_l");
      level._id_10396 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_wing_engine_r");
      level._id_10393 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_rear_engine_l");
      level._id_10394 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_rear_engine_r");
      break;
    case "descend":
      level._id_10395 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_wing_engine_l");
      level._id_10396 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_wing_engine_r");
      level._id_10393 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_rear_engine_l");
      level._id_10394 thread scripts\sp\utility::play_sound_on_entity("dropship_dive_rear_engine_r");
      break;
    default:
      break;
  }
}

_id_5DE5() {
  level._id_5D6C endon("stop_dropship_fall_kill");
  level._id_5D6C waittill("player_exited_dropship");
  getEnt("brush_dropship_player_door_collision", "targetname") solid();
  setomnvar("ui_death_hint", 6);
  scripts\sp\utility::_id_B8D1();
}

_id_10FE2() {
  level._id_5D6C notify("stop_dropship_fall_kill");
  getEnt("brush_dropship_player_door_collision", "targetname") notsolid();
}

_id_CCEF(var_0) {
  if(!isDefined(self._id_4D94.fx)) {
    return;
  }
  thread _id_0BBF::_id_CCE8("cabin_lights");

  if(isDefined(var_0) && var_0)
    _id_5EB0();
}

_id_A5D5() {
  if(!isDefined(self._id_4D94.fx)) {
    return;
  }
  thread _id_0BBF::_id_10FDD("cabin_lights");
  _id_5EAF();
}

_id_5EB0() {
  return;
  playFXOnTag(scripts\engine\utility::getfx("pnr_dropship_spotlight"), self.turret, "tag_flash");
}

_id_5EAF() {
  killfxontag(scripts\engine\utility::getfx("pnr_dropship_spotlight"), self.turret, "tag_flash");
}

_id_5E36() {
  for(;;)
    scripts\engine\utility::waitframe();
}

_id_10FE0() {
  self notify("stop_anim_casual_door");
  scripts\sp\utility::anim_stopanimScripted();

  if(isDefined(self._id_1FBD))
    self._id_1FBD notify("stop_loop");

  scripts\sp\utility::_id_61C7();
  self unlink();
  scripts\sp\utility::_id_86E2();
}

_id_1EA7(var_0, var_1, var_2, var_3) {
  childthread _id_1178(var_0, var_1, var_2, var_3);
}

_id_1178(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::waitframe();

  if(!isDefined(self)) {
    return;
  }
  _id_10FE0();
  self endon("stop_anim_casual_door");
  self._id_1FBD = getnode(var_0, "targetname");

  if(!isDefined(var_3) || !var_3)
    self._id_1FBD scripts\sp\anim::_id_1F17(self, var_1);

  self linkTo(level._id_5D6C);
  self._id_1FBD scripts\sp\anim::_id_1F35(self, var_1);
  self._id_1FBD thread scripts\sp\anim::_id_1EEA(self, var_2);
}

_id_CD1B(var_0, var_1, var_2) {
  playFXOnTag(var_0, var_1, var_2);
}

_id_1041A(var_0) {
  for(var_1 = 1; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    for(var_3 = var_1 - 1; var_3 >= 0 && !_id_10419(var_0[var_3], var_2); var_3--)
      var_0[var_3 + 1] = var_0[var_3];

    var_0[var_3 + 1] = var_2;
  }

  return var_0;
}

_id_10419(var_0, var_1) {
  return var_0.script_index < var_1.script_index;
}

_id_229A(var_0) {
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_3._id_EE52] = var_3;

  return var_1;
}

_id_229B(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_1) && !var_4[[var_1]]()) {
      continue;
    }
    var_2[var_4.targetname] = var_4;
  }

  return var_2;
}

_id_229D(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = [];
  var_0 = _id_2289(var_0);
  var_1 = _id_2289(var_1);

  if(var_1.size == 0)
    return var_0;

  foreach(var_10, var_5 in var_0) {
    var_6 = 0;

    foreach(var_8 in var_1) {
      if(var_8 == var_10) {
        var_6 = 1;

        if(var_2)
          var_5 delete();

        break;
      }
    }

    if(var_6) {
      continue;
    }
    var_3[var_10] = var_5;
  }

  return var_3;
}

_id_229E(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = [];
  var_0 = _id_2289(var_0);
  var_1 = _id_2289(var_1);

  if(var_1.size == 0)
    return var_0;

  foreach(var_10, var_5 in var_0) {
    var_6 = 0;

    foreach(var_8 in var_1) {
      if(var_8 == var_10) {
        var_6 = 1;
        break;
      }
    }

    if(!var_6) {
      if(var_2)
        var_5 delete();

      continue;
    }

    var_3[var_10] = var_5;
  }

  return var_3;
}

_id_2AE1(var_0, var_1) {
  var_2 = -1;

  while(var_2 < var_0) {
    var_2 = cinematicgettimeinmsec() / 1000;
    wait 0.05;
  }

  level notify(var_1);
}

_id_77C4(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getEnt(var_0, "targetname");

    if(!isDefined(var_1)) {
      var_1 = scripts\engine\utility::getStruct(var_0, "script_noteworthy");

      if(!isDefined(var_1))
        var_1 = getEnt(var_0, "script_noteworthy");
    }
  }

  return var_1;
}

_id_693D(var_0) {
  var_1 = _id_77C4(var_0);

  if(isDefined(var_1))
    return 1;

  return 0;
}

_id_4A81(var_0, var_1) {
  return var_0[0] * var_1[1] - var_0[1] * var_1[0];
}

_id_2289(var_0) {
  if(!isDefined(var_0))
    return undefined;

  return scripts\engine\utility::ter_op(isarray(var_0), var_0, [var_0]);
}

_id_65E5(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\sp\utility::_id_65E3(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(var_5))
    self[[var_1]](var_2, var_3, var_4, var_5);
  else {
    if(isDefined(var_4)) {
      self[[var_1]](var_2, var_3, var_4);
      return;
    }

    if(isDefined(var_3)) {
      self[[var_1]](var_2, var_3);
      return;
    }

    if(isDefined(var_2)) {
      self[[var_1]](var_2);
      return;
      return;
    }

    self[[var_1]]();
  }
}

_id_5DE8(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_65E5(var_0, var_1, var_2, var_3, var_4, var_5);
  scripts\sp\utility::_id_65DD(var_0);
}

_id_6E55(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4))
      var_4 = _id_2289(var_4);

    for(var_6 = 0; var_6 < var_3.size; var_6++) {
      if(isDefined(var_4)) {
        var_4[var_6] endon(var_3[var_6]);
        continue;
      }

      self endon(var_3[var_6]);
    }
  }

  if(!isDefined(var_2))
    var_2 = [];
  else
    var_2 = _id_2289(var_2);

  if(isDefined(var_5) && var_5) {
    var_7 = scripts\sp\utility::_id_7E9C(var_0);

    for(;;) {
      level waittill(var_0, var_8);

      if(var_8 == self) {
        break;
      }
    }

    scripts\engine\utility::flag_set(var_0);
  }

  scripts\engine\utility::flag_wait(var_0);

  switch (var_2.size) {
    case 0:
      self[[var_1]]();
      break;
    case 1:
      self[[var_1]](var_2[0]);
      break;
    case 2:
      self[[var_1]](var_2[0], var_2[1]);
      break;
    case 3:
      self[[var_1]](var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    default:
  }
}

flag_waitopen_any(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4))
      var_4 = _id_2289(var_4);

    for(var_6 = 0; var_6 < var_3.size; var_6++) {
      if(isDefined(var_4)) {
        var_4[var_6] endon(var_3[var_6]);
        continue;
      }

      self endon(var_3[var_6]);
    }
  }

  if(!isDefined(var_2))
    var_2 = [];
  else
    var_2 = _id_2289(var_2);

  if(isDefined(var_5) && var_5) {
    var_7 = scripts\sp\utility::_id_7E9C(var_0);

    for(;;) {
      level waittill(var_0, var_8);

      if(var_8 == self) {
        break;
      }
    }

    scripts\engine\utility::flag_set(var_0);
  }

  scripts\engine\utility::flag_waitopen(var_0);

  switch (var_2.size) {
    case 0:
      self[[var_1]]();
      break;
    case 1:
      self[[var_1]](var_2[0]);
      break;
    case 2:
      self[[var_1]](var_2[0], var_2[1]);
      break;
    case 3:
      self[[var_1]](var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    default:
  }
}

_id_C152(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4))
      var_4 = _id_2289(var_4);

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      if(isDefined(var_4)) {
        var_4[var_5] endon(var_3[var_5]);
        continue;
      }

      self endon(var_3[var_5]);
    }
  }

  if(!isDefined(var_2))
    var_2 = [];
  else
    var_2 = _id_2289(var_2);

  self waittill(var_0);

  switch (var_2.size) {
    case 0:
      self[[var_1]]();
      break;
    case 1:
      self[[var_1]](var_2[0]);
      break;
    case 2:
      self[[var_1]](var_2[0], var_2[1]);
      break;
    case 3:
      self[[var_1]](var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      self[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    default:
  }
}

_id_19DB() {
  self endon("death");
  var_0 = 250;
  var_1 = distance(self.origin, level.player.origin);

  for(;;) {
    var_2 = randomfloatrange(3, 6);
    wait(var_2);
    self.goalradius = var_1;
    self setgoalentity(level.player);
    var_1 = var_1 - 175;

    if(var_1 < var_0) {
      var_1 = var_0;
      return;
    }
  }
}

_id_9E47(var_0) {
  var_1 = anglesToForward(scripts\engine\utility::flat_angle(self.angles));
  var_2 = vectorNormalize(scripts\engine\utility::flat_origin(var_0.origin) - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 > 0)
    return 1;
  else
    return 0;
}

_id_9D64(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_2 = vectorNormalize(var_0.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 > 0)
    return 1;

  return 0;
}

_id_61DC() {
  scripts\sp\utility::_id_61F7();
  scripts\sp\utility::_id_61DB();
}

_id_5505() {
  scripts\sp\utility::_id_5528();
  scripts\sp\utility::_id_5504();
}

_id_13815(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 waittill("trigger");
}

_id_13814(var_0) {
  var_1 = getEnt(var_0, "script_noteworthy");
  var_1 waittill("trigger");
}

_id_127B6(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(var_1 == var_0) {
      break;
    }
  }
}

_id_127B5(var_0) {
  for(;;) {
    var_1 = 1;

    foreach(var_3 in var_0) {
      if(!var_3 istouching(self)) {
        var_1 = 0;
        break;
      }
    }

    if(var_1) {
      break;
    }

    wait 0.05;
  }
}

_id_83C7() {
  var_0 = getglass(self.target);
  self waittill("trigger", var_1);
  var_2 = anglesToForward(var_1.angles);
  destroyglass(var_0, var_2);
}

_id_519D(var_0) {
  var_1 = getEnt(var_0, "targetname");
  var_1 delete();
}

_id_1144C() {
  var_0 = level.player getweaponslist("offhand");

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "frag"))
      level.player takeweapon(var_2);
  }
}

_id_1144E() {
  var_0 = level.player getweaponslist("offhand");

  foreach(var_2 in var_0) {
    if(issubstr(var_2, "retractableshield"))
      level.player takeweapon(var_2);
  }
}

_id_79CE(var_0, var_1, var_2) {
  var_3 = vectorNormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}

_id_E45E(var_0, var_1, var_2) {
  var_3 = var_1 * randomfloat(1.0);
  var_4 = randomfloat(360.0);
  var_5 = sin(var_4);
  var_6 = cos(var_4);
  var_7 = var_3 * var_6;
  var_8 = var_3 * var_5;
  var_9 = 0;

  if(isDefined(var_2))
    var_9 = randomfloatrange(var_2 * -1, var_2);

  var_7 = var_7 + var_0[0];
  var_8 = var_8 + var_0[1];
  var_9 = var_9 + var_0[2];
  return (var_7, var_8, var_9);
}

_id_36DF(var_0, var_1, var_2, var_3) {
  var_4 = var_0[0];
  var_5 = var_0[1];
  var_6 = var_0[2];
  var_7 = var_1[0];
  var_8 = var_1[1];
  var_9 = var_1[2];
  var_10 = [var_0, var_1];
  var_11 = _id_7ADF(var_10, var_2);
  var_12 = var_11[0];
  var_13 = var_11[1];
  var_14 = var_11[2];
  var_15 = [];

  for(var_16 = 1; var_16 <= var_3; var_16++) {
    var_17 = var_16 / var_3;
    var_18 = int((1 - var_17) * (1 - var_17) * var_4 + 2 * (1 - var_17) * var_17 * var_12 + var_17 * var_17 * var_7);
    var_19 = int((1 - var_17) * (1 - var_17) * var_5 + 2 * (1 - var_17) * var_17 * var_13 + var_17 * var_17 * var_8);
    var_20 = int((1 - var_17) * (1 - var_17) * var_6 + 2 * (1 - var_17) * var_17 * var_14 + var_17 * var_17 * var_9);
    var_15[var_16] = (var_18, var_19, var_20);
  }

  return var_15;
}

_id_7ADF(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_2 = var_2 + var_0[var_5][0];
    var_3 = var_3 + var_0[var_5][1];
    var_4 = var_4 + var_0[var_5][2];
  }

  return (var_2 / var_0.size, var_3 / var_0.size, var_4 / var_0.size + var_1);
}

_id_BC50(var_0) {
  if(isstring(var_0))
    var_0 = _id_7988(var_0);

  var_1 = undefined;
  var_2 = (0, 0, 110);

  if(isDefined(level._id_133EC)) {
    if(isDefined(level._id_133EC._id_12F97)) {
      if(isDefined(level._id_133EC._id_12F97[0]))
        var_1 = level._id_133EC._id_12F97[0]._id_10229;
    }
  }

  var_1 moveTo(var_0.origin + var_2, 0.05);

  if(isDefined(var_0.angles))
    var_1.angles = var_0.angles;
}

_id_107DF() {
  var_0 = scripts\engine\utility::get_target_ent("fighter_salter");
  level._id_A2F3 = scripts\sp\vehicle::_id_1080D("fighter_salter");
}

_id_7988(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1))
    return var_1;

  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(isDefined(var_1))
    return var_1;

  var_1 = call[[level.getnodefunction]](var_0, "targetname");

  if(isDefined(var_1))
    return var_1;

  var_1 = getvehiclenode(var_0, "targetname");

  if(isDefined(var_1))
    return var_1;
}

_id_AFF1() {
  self endon("stop_look_at_next_node");

  while(!isDefined(self._id_4BF7))
    wait 0.05;

  self setyawspeedbyname("instant");
  self._id_F472 = 1;
  self._id_B00A = spawn("script_origin", (0, 0, 0));
  self setlookatent(self._id_B00A);

  for(;;) {
    if(!isDefined(self._id_4BF7.target)) {
      break;
    }

    var_0 = scripts\engine\utility::getStruct(self._id_4BF7.target, "targetname");
    self._id_B00A.origin = var_0.origin;
    self waittill("reached_current_node");
  }
}

_id_11017() {
  self notify("stop_look_at_next_node");
  self clearlookatent();
  self._id_F472 = 0;
  self._id_B00A delete();
}

_id_D83D() {
  var_0 = scripts\engine\utility::get_target_ent("interior_base_speed_volume");
  var_0 hide();
}

_id_1330E() {
  self notify("disable_jackal_dust_vfx");
  self endon("disable_jackal_dust_vfx");

  for(;;) {
    if(level._id_133EC._id_D1A4._id_BD69 <= 70 && level._id_133EC._id_D1A4._id_BD69 >= 20)
      playFXOnTag(scripts\engine\utility::getfx("vfx_europa_jackal_mist_canyon_01"), level._id_133EC._id_D1A4._id_10229, "j_mainroot");
    else if(level._id_133EC._id_D1A4._id_BD69 >= 140)
      playFXOnTag(scripts\engine\utility::getfx("vfx_europa_jackal_mist_canyon_03"), level._id_133EC._id_D1A4._id_10229, "j_mainroot");
    else if(level._id_133EC._id_D1A4._id_BD69 <= 19)
      playFXOnTag(scripts\engine\utility::getfx("vfx_europa_jackal_canyon_ch_stop"), level._id_133EC._id_D1A4._id_10229, "j_mainroot");
    else
      playFXOnTag(scripts\engine\utility::getfx("vfx_europa_jackal_mist_canyon_02"), level._id_133EC._id_D1A4._id_10229, "j_mainroot");

    wait 0.1;
  }
}

_id_116B5() {
  level notify("temp_player_speed");
  level endon("temp_player_speed");
  wait 5;
}

_id_11690() {
  level notify("temp_flight_hack");
  level endon("temp_flight_hack");
  level._id_133EC._id_D1A4 scripts\sp\utility::_id_65E1("auto_boost_on");
  wait 1;
  level._id_133EC._id_D1A4 scripts\sp\utility::_id_65DD("auto_boost_on");
}

_id_8578() {
  setdvarifuninitialized("grenade_indicator", 0);
  precacheshader("hud_grenadethrowback");
  setsaveddvar("r_hudoutlineEnable", 1);

  if(getdvarint("grenade_indicator") != 1) {
    return;
  }
  var_0 = getspawnerarray();
  scripts\sp\utility::_id_22C7(var_0, ::_id_857A);
}

_id_857A() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_0 thread _id_8579();
  }
}

_id_8579() {
  self hudoutlineenable(1, 0, 0);
  target_set(self);
  target_setshader(self, "hud_grenadethrowback");
  var_0 = 0;

  while(isDefined(self)) {
    var_1 = distance(self.origin, level.player.origin);

    if(var_1 > 250 && var_0 == 0) {
      var_0 = 1;
      self hudoutlinedisable();
      target_hidefromplayer(self, level.player);
    } else if(var_1 <= 250 && var_0 == 1) {
      var_0 = 0;
      self hudoutlineenable(1, 0, 0);
      target_showtoplayer(self, level.player);
    }

    wait 0.1;
  }
}

_id_4ED5() {
  for(;;) {
    if(!getdvarint("debug_ent_count")) {
      wait 0.2;
      continue;
    }

    var_0 = 110;
    var_1 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_1.x = 580;
    var_1.y = var_0;
    var_0 = var_0 + 15;
    var_2 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_2.x = 580;
    var_2.y = var_0;
    var_0 = var_0 + 15;
    var_3 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_3.x = 580;
    var_3.y = var_0;
    var_0 = var_0 + 15;
    var_4 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_4.x = 580;
    var_4.y = var_0;
    var_0 = var_0 + 15;
    var_5 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_5.x = 580;
    var_5.y = var_0;
    var_0 = var_0 + 15;
    var_6 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_6.x = 580;
    var_6.y = var_0;
    var_0 = var_0 + 15;
    var_7 = scripts\sp\hud_util::createfontstring("default", 1.5);
    var_7.x = 580;
    var_7.y = var_0;
    thread _id_65D8(var_3, var_4, var_5, var_6, var_7);

    while(getdvarint("debug_ent_count")) {
      wait 0.1;
      continue;
    }

    level notify("stop_ai_drone_debug");
    var_2 destroy();
    var_1 destroy();
    var_3 destroy();
    var_4 destroy();
    var_5 destroy();
    var_6 destroy();
    var_7 destroy();
  }
}

_id_4EA2(var_0, var_1) {
  level endon("stop_ai_drone_debug");

  for(;;) {
    var_2 = level._id_13267["allies"];
    var_2 = scripts\engine\utility::array_combine(var_2, level._id_13267["axis"]);
    var_3 = getaiarray();
    var_0 settext("Vehicles : " + var_2.size);
    var_1 settext("AI : " + var_3.size);
    wait 0.05;
  }
}

_id_65D8(var_0, var_1, var_2, var_3, var_4) {
  level endon("stop_ai_drone_debug");
  var_5 = 0;
  var_6 = 50;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  for(;;) {
    var_10 = getEntArray("script_model", "classname");
    var_11 = getEntArray("script_origin", "classname");
    var_0 settext("models : " + var_10.size);
    var_1 settext("origins : " + var_11.size);
    var_12 = var_10.size + var_11.size;
    var_2 settext("total : " + var_12);
    var_7 = var_7 + var_12;
    var_3 settext("average : " + var_5);
    var_8++;

    if(var_8 == var_6) {
      var_5 = int(var_7 / var_6);
      var_7 = 0;
      var_8 = 0;
    }

    if(var_12 > var_9) {
      var_9 = var_12;
      var_4 settext("highest :" + var_9);
    }

    wait 0.05;
  }
}

_id_513B(var_0) {
  self endon("death");

  if(!isDefined(var_0))
    var_0 = 0;

  wait(var_0);
  self waittill("reached_path_end");

  if(isDefined(self))
    self delete();
}

_id_8813(var_0) {
  var_1 = getEnt(var_0, "targetname");

  for(;;) {
    if(level.player istouching(var_1)) {
      var_1 scripts\sp\utility::_id_15F1();
      break;
    }

    wait 0.05;
  }
}

_id_D126() {
  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 == level.player) {
      break;
    }
  }
}

_id_1368F(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = var_2 scripts\sp\utility::_id_77E3("axis");
  var_4 = var_3.size;

  while(var_4 > var_1) {
    wait 0.3;
    var_3 = var_2 scripts\sp\utility::_id_77E3("axis");
    var_4 = var_3.size;

    if(var_4 - var_1 < 3) {
      foreach(var_6 in var_3) {
        if(var_6 scripts\sp\utility::_id_58DA() || var_6.delayeddeath)
          var_4--;
      }
    }
  }
}

_id_1CC5() {
  self endon("trigger_off");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  if(!isDefined(level._id_161F))
    level._id_161F = [];

  if(isDefined(self.target))
    var_0 = getEnt(self.target, "targetname");

  if(!isDefined(var_0)) {
    var_2 = self;
    var_0 = self;
  } else if(issubstr(var_0.classname, "friendly") && !isDefined(var_0.target)) {
    var_2 = var_0;
    var_0 = self;
  } else
    var_2 = getEnt(var_0.target, "targetname");

  var_1 = 0;

  if(isDefined(var_0.script_count))
    var_1 = var_0.script_count;

  self waittill("trigger");
  scripts\engine\utility::array_thread(level._id_161F, scripts\engine\utility::trigger_off);
  level._id_161F = [];
  level._id_161F[level._id_161F.size] = var_2;

  if(self != var_2)
    level._id_161F[level._id_161F.size] = self;

  var_2 endon("trigger_off");
  scripts\sp\utility::script_delay();

  for(;;) {
    var_3 = var_0 scripts\sp\utility::_id_77E3("axis");

    if(var_3.size <= var_1) {
      break;
    }

    wait 0.25;
  }

  var_2 notify("trigger");
  scripts\engine\utility::trigger_off();
}

_id_1CC2(var_0) {
  setdvarifuninitialized("ally_advance_debug", 0);

  if(!getdvarint("ally_advance_debug")) {
    return;
  }
  foreach(var_2 in var_0)
  thread scripts\sp\utility::draw_circle(var_2.origin, 24, (1, 0, 0), 1, 0, 24);
}

_id_F5B1(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    switch (var_3.script_noteworthy) {
      case "player":
        level.player setOrigin(var_3.origin);
        level.player setplayerangles(var_3.angles);
        break;
      case "salter":
        level._id_EA2C _meth_80F1(var_3.origin, var_3.angles);
        level._id_EA2C setgoalpos(var_3.origin);

        if(isDefined(var_3.animation))
          var_3 thread scripts\sp\anim::_id_1EC7(level._id_EA2C, var_3.animation);

        if(isDefined(var_3.target)) {
          var_3 = var_3 scripts\engine\utility::get_target_ent();
          level._id_EA2C thread scripts\sp\utility::_id_7227(var_3);
        }

        break;
      case "ethan":
        level._id_6754 _meth_80F1(var_3.origin, var_3.angles);
        level._id_6754 setgoalpos(var_3.origin);

        if(isDefined(var_3.animation))
          var_3 thread scripts\sp\anim::_id_1EC7(level._id_B4F1, var_3.animation);

        if(isDefined(var_3.target)) {
          var_3 = var_3 scripts\engine\utility::get_target_ent();
          level._id_6754 thread scripts\sp\utility::_id_7227(var_3);
        }

        break;
    }
  }
}

_id_1356C(var_0) {
  if(isDefined(level._id_D127)) {
    return;
  }
  level._id_D127 = _id_0BDC::_id_1079F("jackal_player", var_0);
}

_id_1356E(var_0) {
  if(isDefined(level._id_116A1)) {
    return;
  }
  var_1 = scripts\engine\utility::get_target_ent("temp_jackal");
  level._id_116A1 = var_1 scripts\sp\utility::_id_10808();

  if(isDefined(var_0))
    level._id_116A1 _id_0BDC::_id_1162F(var_0);
}

_id_1356D(var_0) {
  if(isDefined(level._id_EA99)) {
    return;
  }
  var_1 = scripts\engine\utility::get_target_ent("jackal_salter");
  level._id_EA99 = var_1 scripts\sp\utility::_id_10808();

  if(isDefined(var_0))
    level._id_EA99 _id_0BDC::_id_1162F(var_0);
}

_id_5569(var_0) {
  var_1 = _id_7B8A(var_0);
  _id_EB5A(var_1, 0);

  if(var_1["freeze"])
    level.player freezecontrols(1);

  if(var_1["weapons"])
    level.player scripts\engine\utility::allow_weapon(0);

  if(var_1["weaponswitch"])
    level.player scripts\engine\utility::allow_weapon_switch(0);

  if(var_1["offhandweapons"])
    level.player scripts\engine\utility::allow_offhand_weapons(0);

  if(var_1["offhandprimaryweapons"])
    level.player disableoffhandprimaryweapons();

  if(var_1["offhandsecondaryweapons"])
    level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);

  if(var_1["prone"])
    level.player scripts\engine\utility::allow_prone(0);

  if(var_1["crouch"])
    level.player scripts\engine\utility::allow_crouch(0);

  if(var_1["sprint"])
    level.player scripts\engine\utility::allow_sprint(0);

  if(var_1["jump"])
    level.player scripts\engine\utility::allow_jump(0);

  if(var_1["melee"])
    level.player scripts\engine\utility::allow_melee(0);
}

_id_6229(var_0) {
  var_1 = _id_7B8A(var_0);
  _id_EB5A(var_1, 1);

  if(var_1["freeze"])
    level.player freezecontrols(0);

  if(var_1["weapons"])
    level.player scripts\engine\utility::allow_weapon(1);

  if(var_1["weaponswitch"])
    level.player scripts\engine\utility::allow_weapon_switch(1);

  if(var_1["offhandweapons"])
    level.player scripts\engine\utility::allow_offhand_weapons(1);

  if(var_1["offhandprimaryweapons"])
    level.player enableoffhandprimaryweapons();

  if(var_1["offhandsecondaryweapons"])
    level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);

  if(var_1["prone"])
    level.player scripts\engine\utility::allow_prone(1);

  if(var_1["crouch"])
    level.player scripts\engine\utility::allow_crouch(1);

  if(var_1["sprint"])
    level.player scripts\engine\utility::allow_sprint(1);

  if(var_1["jump"])
    level.player scripts\engine\utility::allow_jump(1);

  if(var_1["melee"])
    level.player scripts\engine\utility::allow_melee(1);
}

_id_7B8A(var_0) {
  var_1 = ["freeze", "weapons", "weaponswitch", "offhandweapons", "offhandprimaryweapons", "offhandsecondaryweapons", "prone", "crouch", "sprint", "jump", "melee"];

  if(!isDefined(level._id_4EA4)) {
    level._id_4EA4 = [];

    foreach(var_3 in var_1)
    level._id_4EA4[var_3] = 0;
  }

  var_0 = _id_2289(var_0);

  if(!isDefined(var_0))
    var_0 = var_1;

  var_5 = 1;
  var_6 = [];

  foreach(var_10, var_8 in var_0) {
    var_9 = issubstr(var_8, "!");
    var_3 = tolower(strtok(var_8, "!")[0]);

    if(!isDefined(scripts\engine\utility::array_find(var_1, var_3))) {
      continue;
    }
    if(var_9)
      var_5 = 0;

    if(isDefined(var_6[var_3])) {
      continue;
    }
    var_6[var_3] = 1;
  }

  var_11 = [];

  foreach(var_3 in var_1) {
    if(var_5) {
      if(isDefined(var_6[var_3]))
        var_11[var_3] = 1;
      else
        var_11[var_3] = 0;

      continue;
    }

    if(isDefined(var_6[var_3])) {
      var_11[var_3] = 0;
      continue;
    }

    var_11[var_3] = 1;
  }

  return var_11;
}

_id_EB5A(var_0, var_1) {
  foreach(var_4, var_3 in var_0) {
    if(var_1) {
      if(var_3)
        level._id_4EA4[var_4]++;

      continue;
    }

    if(var_3)
      level._id_4EA4[var_4]--;
  }
}

_id_96E7() {
  if(!isDefined(level._id_D226)) {
    var_0 = anglesToForward(level.player.angles) * 150;
    level._id_D226 = physics_volumecreate(level.player.origin, 300);
    level._id_D226 linkTo(level.player);
  }

  level._id_D226 physics_volumesetactivator(0);
  level._id_D226 physics_volumeenable(0);
}

_id_10CD9() {
  level notify("stop_player_physics_sphere");
  level endon("stop_player_physics_sphere");
  _id_96E7();
  var_0 = vectorNormalize((0, -200, 0));
  var_1 = vectorNormalize((0, 200, 0));

  for(;;) {
    level waittill("activate_physics_on_player", var_2, var_3, var_4);

    if(!isDefined(var_3))
      var_3 = 600;

    if(isDefined(var_2) && var_2 > 0 || level._id_AD4F < 0) {
      level._id_D226 physics_volumesetasdirectionalforce(1, var_0, var_3);
      level._id_D226 physics_volumeenable(1);
      level._id_D226 physics_volumesetactivator(1);

      if(isDefined(var_4))
        wait(var_4);
      else
        wait(level._id_AD51);
    } else if(isDefined(var_2) && var_2 < 0 || level._id_AD4F > 0) {
      level._id_D226 physics_volumesetasdirectionalforce(1, var_1, var_3);
      level._id_D226 physics_volumeenable(1);
      level._id_D226 physics_volumesetactivator(1);

      if(isDefined(var_4))
        wait(var_4);
      else
        wait(level._id_AD51);
    }

    level._id_D226 physics_volumeenable(0);
    level._id_D226 physics_volumesetactivator(0);
  }
}

_id_CB09(var_0, var_1, var_2) {
  if(!isDefined(level._id_D226)) {
    thread _id_10CD9();
    scripts\engine\utility::waitframe();
  }

  level notify("activate_physics_on_player", var_0, var_1, var_2);
}

_id_1102F() {
  level notify("stop_player_physics_sphere");

  if(isDefined(level._id_8632))
    level._id_8632 notify("stop_delay_thread");

  if(isDefined(level._id_D226)) {
    level._id_D226 physics_volumeenable(0);
    level._id_D226 physics_volumesetactivator(0);
    level._id_D226 delete();
  }
}

_id_968E() {
  _id_96E0();
  _id_953D();
}

_id_96E0() {
  if(isDefined(level._id_8632)) {
    return;
  }
  level._id_8632 = spawn("script_model", (0, 0, 0));
  level._id_8632 rotateTo((0, 0, 0), 0.01);
  scripts\engine\utility::waitframe();
  level.player _meth_823F(level._id_8632);
}

_id_953D() {
  if(isDefined(level._id_3F8E)) {
    return;
  }
  level._id_3F8E = scripts\engine\utility::spawn_tag_origin();
  level._id_3F90 = scripts\engine\utility::spawn_tag_origin();
}

_id_10CB3() {
  level notify("stop_moving_background");
  level endon("stop_moving_background");
  level._id_3F8E movex(-35000, 1800);
}

_id_10D16(var_0) {
  level notify("ship_list_system_disable");
  level endon("ship_list_system_disable");
  _id_5013();
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(var_0) && var_0)
    _id_C9C6();
  else
    scripts\engine\utility::flag_clear("ship_list_pause");

  for(;;) {
    scripts\engine\utility::flag_waitopen("ship_list_pause");
    scripts\engine\utility::flag_set("ship_list_active");
    var_5 = 0;

    if(level._id_AD4F <= 0) {
      level._id_AD4F = randomfloatrange(4, 5);

      if(randomint(100) > 80) {
        level._id_AD4F = level._id_AD4F + 1.5;
        var_5 = 1;
      }
    } else {
      level._id_AD4F = randomfloatrange(-5, -4);

      if(randomint(100) > 80) {
        level._id_AD4F = level._id_AD4F - 1.5;
        var_5 = 1;
      }
    }

    var_6 = level._id_AD51 * 0.25;

    if(isDefined(level._id_FD4C))
      thread[[level._id_FD4C]]();

    level._id_8632 rotateTo((0, 0, level._id_AD4F), level._id_AD51, var_6, var_6);
    level._id_8632 scripts\engine\utility::delaythread(level._id_AD51 * 0.5, ::_id_CB09);

    if(level._id_AD4F > 0)
      thread _id_8AB0();
    else
      thread _id_8AAF();

    if(var_5 == 0)
      level.player playSound("veh_capitol_ship_rcs_small");
    else
      level.player playSound("heist_mons_quakes");

    level._id_8632 waittill("rotatedone");
    thread _id_FD4E(var_5);
    wait(randomfloatrange(1.5, 3));
    scripts\engine\utility::flag_clear("ship_list_active");
  }
}

_id_5013() {
  if(!isDefined(level._id_AD4F))
    level._id_AD4F = 0.0;

  level._id_AD51 = 6;
}

_id_FD4E(var_0) {
  if(var_0 == 0) {
    var_1 = randomfloatrange(1.5, 2.0);
    level.player _meth_8291(0.17, 0.17, 0.17, var_1, 0, -1, 0, 15, 15, 15);
    level.player playRumbleOnEntity("light_2s");
  } else {
    var_1 = randomfloatrange(2.5, 3.2);
    level.player _meth_8291(0.25, 0.25, 0.25, var_1, 0, -1, 0, 30, 30, 30);
    level.player playRumbleOnEntity("heavy_3s");
  }

  if(scripts\engine\utility::flag("hangar_shiplist_fx_enabled")) {
    var_2 = ["mons_shake_damage", "mons_damage_shake_02"];
    scripts\engine\utility::exploder(scripts\engine\utility::random(var_2));
  }
}

_id_1103D(var_0) {
  level endon("stop_stop_ship_list");

  if(isDefined(var_0))
    scripts\engine\utility::flag_wait(var_0);

  scripts\engine\utility::flag_set("ship_list_stopping");

  if(scripts\engine\utility::flag("ship_list_pause") && level._id_8632.angles == (0, 0, 0)) {
    return;
  }
  _id_C9C6();
  _id_1102F();
  scripts\engine\utility::waitframe();
  level._id_8632 rotateTo((0, 0, 0), 1.5, 0.25, 0.25);
  level.player playSound("veh_capitol_ship_rcs_small");
  level._id_8632 waittill("rotatedone");
  level.player _meth_8291(0.1, 0.1, 0.1, 0.4, 0, -1, 0, 15, 15, 15);
  scripts\engine\utility::flag_clear("ship_list_stopping");
}

_id_C9C6() {
  level notify("ship_list_system_disable");
  thread _id_10D16(1);
}

_id_4D77(var_0, var_1) {
  level._id_4D76 = 1;
  thread _id_4D78(var_1);

  while(level._id_4D76 == 1) {
    level.player _meth_8251(var_0);
    scripts\engine\utility::waitframe();
  }

  level.player _meth_8251((0, 0, 0));
}

_id_4D78(var_0) {
  wait(var_0);
  level._id_4D76 = 0;
}

_id_8AB0() {
  var_0 = vectorNormalize((0, 100, 0));
  var_0 = var_0 * 2;

  if(!isDefined(level._id_AD51))
    level._id_AD51 = 3.5;

  thread _id_4D77(var_0, level._id_AD51);
}

_id_8AAF() {
  var_0 = vectorNormalize((0, -100, 0));
  var_0 = var_0 * 2;

  if(!isDefined(level._id_AD51))
    level._id_AD51 = 3.5;

  thread _id_4D77(var_0, level._id_AD51);
}

_id_BD33() {
  var_0 = getnodearray("hangar_cover_nodes", "script_noteworthy");
  var_0 = getnodearray("lift_cover_nodes", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 _meth_80AC();
}

_id_1DF0() {
  thread _id_862C();
  thread _id_0B0F::_id_10D23("mons_vista_skyambient");
}

_id_1DEF() {
  level notify("end_flak_defense");
  thread _id_0B0F::_id_1103F("mons_vista_skyambient");
}

_id_862C() {
  level endon("end_flak_defense");
  var_0 = [];
  var_1 = 0.6;
  var_2 = 3.7;

  for(;;) {
    var_3 = scripts\engine\utility::get_target_array("flak_targets");
    var_3 = scripts\engine\utility::array_randomize(var_3);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_3[var_4] thread _id_6E80();
      wait(randomfloatrange(var_1, var_2));
    }
  }
}

_id_6E80() {
  level endon("end_flak_defense");
  playFX(level._effect["om_flak_expl"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  playworldsound("atmosphere_flak_bursts", self.origin);
}

_id_957C() {
  if(isDefined(level._id_31FD)) {
    return;
  }
  level._id_31FD = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level._id_8E2A = getEntArray("bot_collapse_building_mover", "targetname");
  level._id_8E29 = getEntArray("hero_building_dmg", "script_noteworthy");

  foreach(var_1 in level._id_8E2A) {
    var_1 linkTo(level._id_31FD);
    var_1 hide();
  }

  foreach(var_1 in level._id_8E29) {
    var_1 linkTo(level._id_31FD);
    var_1 hide();
  }

  level._id_31FE = getEntArray("bot_collapse_building_mover_2", "targetname");
  level._id_31FF = getEntArray("bot_collapse_building_mover_2_dmg", "targetname");

  foreach(var_6 in level._id_31FE) {
    var_6 linkTo(level._id_31FD);
    var_6 hide();
  }

  foreach(var_6 in level._id_31FF) {
    var_6 linkTo(level._id_31FD);
    var_6 hide();
  }

  level._id_31FB = [];
  level._id_31FA = [];
  var_10 = scripts\engine\utility::getStructArray("second_bldng_expl_top", "targetname");
  var_11 = scripts\engine\utility::getStructArray("second_bldng_expl", "targetname");

  foreach(var_13 in var_10) {
    var_14 = var_13 scripts\engine\utility::spawn_tag_origin();
    var_14 linkTo(level._id_31FD);
    level._id_31FB = scripts\engine\utility::array_add(level._id_31FB, var_14);
  }

  foreach(var_17 in var_11) {
    var_18 = var_17 scripts\engine\utility::spawn_tag_origin();
    var_18 linkTo(level._id_31FD);
    level._id_31FA = scripts\engine\utility::array_add(level._id_31FA, var_18);
  }

  level._id_4822 = getEnt("crash_before_window", "targetname");
  level._id_4823 = getEntArray("jackal_crash_after_debris", "targetname");

  foreach(var_21 in level._id_4823) {
    if(isDefined(level._id_31FD)) {
      var_21 linkTo(level._id_31FD);
      var_21 hide();
    }
  }

  level._id_A65F = getEnt("killer_beam_debris", "targetname");
  level._id_A65F hide();
}

_id_100CD() {
  level._id_8E2A = getEntArray("hero_building", "script_noteworthy");
  level._id_31FE = getEntArray("bot_collapse_building_mover_2", "targetname");

  foreach(var_1 in level._id_31FE)
  var_1 show();

  foreach(var_1 in level._id_8E2A) {
    var_1 show();

    if(isDefined(var_1.script_parameters)) {
      if(var_1.script_parameters == "hero_bldng_window_dmg_1" || var_1.script_parameters == "hero_bldng_window_dmg_2")
        var_1 hide();
    }
  }
}

_id_8E74() {
  level._id_8E2A = getEntArray("hero_building", "script_noteworthy");
  level._id_8E29 = getEntArray("hero_building_dmg", "script_noteworthy");
  level._id_31FE = getEntArray("bot_collapse_building_mover_2", "targetname");
  level._id_31FF = getEntArray("bot_collapse_building_mover_2_dmg", "targetname");
  var_0 = getEnt("lit_exp_mons_topdeck_01", "targetname");
  var_1 = getEntArray("lit_thrust_mons_topdeck", "targetname");

  if(isDefined(var_0))
    var_0 setlightintensity(0);

  foreach(var_3 in var_1)
  var_3 setlightintensity(0);

  foreach(var_6 in level._id_8E2A)
  var_6 hide();

  foreach(var_6 in level._id_8E29)
  var_6 hide();

  foreach(var_11 in level._id_31FE)
  var_11 hide();

  foreach(var_11 in level._id_31FF)
  var_11 hide();

  var_15 = getEntArray("slide_debris_ground_dmg_1", "targetname");
  var_16 = getEntArray("slide_debris_ground_dmg_2", "targetname");

  foreach(var_11 in var_15)
  var_11 hide();

  foreach(var_11 in var_16)
  var_11 hide();
}

_id_1130C() {
  var_0 = getEntArray("hero_building", "script_noteworthy");
  var_1 = getEntArray("hero_building_dmg", "script_noteworthy");

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_parameters)) {
      if(var_3.script_parameters == "building_clean_piece")
        var_3 hide();

      if(var_3.script_parameters == "hero_bldng_window_prst_1" || var_3.script_parameters == "hero_bldng_window_prst_2")
        var_3 hide();

      if(var_3.script_parameters == "hero_bldng_window_dmg_1" || var_3.script_parameters == "hero_bldng_window_dmg_2")
        var_3 show();
    }
  }

  foreach(var_6 in var_1)
  var_6 show();
}

_id_4360() {
  var_0 = scripts\engine\utility::getStruct("collapse_fx_0", "targetname");
  var_1 = scripts\engine\utility::getStruct("collapse_fx_1", "targetname");
  var_2 = scripts\engine\utility::getStruct("collapse_fx_2", "targetname");
  level._id_434A = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  level._id_434B = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  level._id_434C = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  level._id_436E = [level._id_434A, level._id_434B, level._id_434C];
}

_id_9686() {
  level._id_4018["on"] = _id_7991("hangar_claxon_light", "script_noteworthy", "model_on");
  level._id_4018["off"] = _id_7991("hangar_claxon_light", "script_noteworthy", "model_off");
  level._id_4017["on"] = _id_7991("deck_claxon_lights_mod", "script_noteworthy", "model_on");
  level._id_4017["off"] = _id_7991("deck_claxon_lights_mod", "script_noteworthy", "model_off");
  level._id_4016["on"] = _id_7991("breach_claxon_light_mod", "script_noteworthy", "model_on");
  level._id_4016["off"] = _id_7991("breach_claxon_light_mod", "script_noteworthy", "model_off");
}

_id_FD33(var_0) {
  scripts\engine\utility::waitframe();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = [];
  var_5 = [];
  var_6 = [];

  switch (var_0) {
    case "hangar":
      var_3 = level._id_4018;
      var_1 = "hangar_claxon_lights";
      var_2 = "lift_end";
      var_4 = ["hangar_start", "hangar_mid", "hangar_end", "lift_start"];
      var_6 = _id_7991("hangar_claxon_light", "script_noteworthy", "flare_struct");
      break;
    case "deck":
      var_3 = level._id_4017;
      var_1 = "deck_claxon_lights";
      var_2 = "close_deck_door";
      var_4 = ["lift_end", "post_lift", "deck_mid", "deck_end"];
      var_6 = _id_7991("deck_claxon_lights_mod", "script_noteworthy", "flare_struct");
      break;
    case "breach":
      var_3 = level._id_4016;
      var_1 = "breach_claxon_lights";
      var_2 = "bridge_robot_control_dialogue";
      var_4 = ["pre_breach"];
      var_6 = _id_7991("breach_claxon_light_mod", "script_noteworthy", "flare_struct");
      break;
  }

  wait 1;

  foreach(var_8 in var_4) {
    var_9 = scripts\engine\utility::getStruct(var_8, "script_noteworthy");
    var_10 = scripts\engine\utility::spawn_tag_origin(var_9.origin, var_9.angles);
    var_5 = scripts\engine\utility::array_add(var_5, var_10);
  }

  scripts\engine\utility::array_thread(var_6, ::_id_6E8F, var_2);
  scripts\engine\utility::array_thread(var_5, ::_id_1B1D, var_2);
  var_12 = getEntArray(var_1, "targetname");

  while(!scripts\engine\utility::flag(var_2)) {
    foreach(var_8 in var_12) {
      _id_BA6E(var_3);
      var_8 setlightintensity(0.5);
      var_8 _meth_82FC((1, 0, 0));
    }

    wait 0.5;

    foreach(var_8 in var_12) {
      _id_BA6D(var_3);
      var_8 setlightintensity(0.0);
      var_8 _meth_82FC((1, 0, 0));
    }

    wait 0.5;
  }

  foreach(var_8 in var_12) {
    var_8 setlightintensity(0.0);
    var_8 _meth_82FC((1, 0, 0));
  }
}

_id_1B1D(var_0) {
  self playLoopSound("alarm_heist_mons_lp3");
  scripts\engine\utility::flag_wait(var_0);
  self stoploopsound("alarm_heist_mons_lp3");
  wait 1;
  self delete();
}

_id_BA6E(var_0) {
  scripts\engine\utility::array_call(var_0["on"], ::show);
  scripts\engine\utility::array_call(var_0["off"], ::hide);
}

_id_BA6D(var_0) {
  scripts\engine\utility::array_call(var_0["on"], ::hide);
  scripts\engine\utility::array_call(var_0["off"], ::show);
}

_id_6E8F(var_0) {
  if(isDefined(self)) {
    var_1 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);

    while(!scripts\engine\utility::flag(var_0)) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_heist_red_light_flare"), var_1, "tag_origin");
      wait 1;
      stopFXOnTag(scripts\engine\utility::getfx("vfx_heist_red_light_flare"), var_1, "tag_origin");
    }

    self delete();
  }
}

_id_9706() {
  level._id_DD00["lid_pos"] = getEntArray("lid_pos", "script_noteworthy");
  scripts\engine\utility::array_call(level._id_DD00["lid_pos"], ::hide);
}

_id_DCFE(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = getEntArray(var_0, "targetname");

  foreach(var_5 in var_3) {
    if(isDefined(var_5) && isDefined(var_5.script_noteworthy)) {
      var_6 = var_5.script_noteworthy;

      switch (var_6) {
        case "lid":
          var_1 = var_5;
          break;
        case "lid_pos":
          var_2 = var_5;
          break;
      }
    }
  }

  var_1 moveTo(var_2.origin, 1.5);
  var_1 rotateTo(var_2.angles, 1.5);
}

_id_1EFA(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player endon("stop_anim_player");
  var_7 = "player_rig";

  if(isDefined(level.player._id_1F1F))
    var_7 = level.player._id_1F1F;

  if(!isDefined(var_5))
    var_5 = 0;

  if(isDefined(level.player._id_1EEF) && !isstruct(level.player._id_1EEF))
    level.player._id_1EEF delete();

  level.player._id_1EEF = self;

  if(!isDefined(level.player._id_E505))
    level.player._id_E505 = scripts\sp\utility::_id_10639(var_7);

  level.player._id_E505 hide();

  if(!isstruct(level.player._id_1EEF))
    level.player._id_E505 linkTo(level.player._id_1EEF);

  _id_5569("!freeze");
  scripts\sp\utility::_id_E006();
  level.player _meth_84FE();

  if(isDefined(var_2)) {
    level.player _meth_823C(level.player._id_E505, "tag_player", var_2);
    level.player scripts\engine\utility::delaycall(var_2, ::playerlinktodelta, level.player._id_E505, "tag_player", 1, 0, 0, 0, 0, var_5);
    level.player._id_E505 scripts\engine\utility::delaycall(var_2, ::show);
  } else {
    var_8 = 0;

    if(isDefined(var_6))
      var_8 = 90;

    level.player playerlinktodelta(level.player._id_E505, "tag_player", 1, var_8, var_8, var_8, var_8, var_5);
    level.player._id_E505 show();

    if(isDefined(var_6))
      level.player lerpviewangleclamp(var_6, 0, 0, 0, 0, 0, 0);
  }

  if(isDefined(var_0)) {
    var_0 = _id_2289(var_0);

    foreach(var_10 in var_0) {
      if(isDefined(level.player._id_1EDE) && level.player._id_1EDE) {
        level.player._id_1EEF scripts\sp\anim::_id_1EE0(level.player._id_E505, var_10);
        continue;
      }

      if(isDefined(level.player._id_1EC1) && level.player._id_1EC1) {
        level.player._id_1EEF scripts\sp\anim::_id_1EC3(level.player._id_E505, var_10);
        continue;
      }

      if(isDefined(var_2)) {
        level.player._id_1EEF scripts\sp\anim::_id_1EC3(level.player._id_E505, var_10);
        wait(var_2);
      }

      level.player._id_1EEF scripts\sp\anim::_id_1F35(level.player._id_E505, var_10);
    }
  }

  if(isDefined(var_1)) {
    level.player._id_1EEF thread scripts\sp\anim::_id_1EEA(level.player._id_E505, var_1);
    level.player._id_1EEF waittill("stop_loop");
  }

  if((!isDefined(var_3) || !var_3) && (!isDefined(level.player._id_1EC1) || !level.player._id_1EC1))
    _id_1EFB();

  if(isDefined(var_4))
    level.player[[var_4]]();
}

_id_1EFB(var_0) {
  level.player unlink();
  _id_6229(["!freeze"]);
  level.player _meth_84FD();

  if(isDefined(level.player._id_E505))
    level.player._id_E505 delete();

  if(isDefined(level.player._id_1EEF) && !isstruct(level.player._id_1EEF))
    level.player._id_1EEF delete();
}

_id_C5F0(var_0, var_1, var_2, var_3, var_4) {
  thread _id_59B0(var_0, "open", var_2, var_3, var_4);
  _id_59B0(var_1, "open", var_2, var_3, var_4);
}

_id_4264(var_0, var_1, var_2, var_3, var_4) {
  thread _id_59B0(var_0, "closed", var_2, var_3, var_4);
  _id_59B0(var_1, "closed", var_2, var_3, var_4);
}

_id_59B0(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_794A(var_0);

  if(!isDefined(var_2))
    var_2 = var_5.time;

  if(var_2 <= 0.05) {
    var_2 = 0.05;
    var_6 = 0.05;
  } else
    var_6 = var_2 * 0.25;

  if(!isDefined(var_3))
    var_3 = var_5._id_56E8;

  var_5._id_BCDA scripts\sp\utility::_id_65E8("door_moving");

  if(isDefined(var_5.current_state) && var_1 == var_5.current_state) {
    return;
  }
  var_5._id_BCDA scripts\sp\utility::_id_65E1("door_moving");
  var_7 = var_5.origin;
  var_8 = var_4;

  switch (var_1) {
    case "open":
      if(isDefined(var_5._id_C614))
        var_7 = var_5._id_C614;
      else if(isDefined(var_3))
        var_7 = var_5._id_BCDA.origin + anglesToForward(var_5.angles) * (var_3 * -1);

      if(!isDefined(var_8))
        var_8 = "heist_mons_door_open";

      scripts\engine\utility::delaythread(0, ::_id_F363, var_0, "unlock");

      if(isDefined(var_5.clip))
        var_5.clip scripts\engine\utility::delaycall(0, ::connectpaths);

      break;
    case "closed":
      if(isDefined(var_5._id_4289))
        var_7 = var_5._id_4289;
      else if(isDefined(var_3))
        var_7 = var_5._id_BCDA.origin + anglesToForward(var_5.angles) * var_3;

      if(!isDefined(var_8))
        var_8 = "heist_mons_door_close";

      var_5._id_BCDA scripts\engine\utility::delaythread(var_2 + 1, ::_id_F363, var_0, "lock");

      if(isDefined(var_5.clip))
        var_5.clip scripts\engine\utility::delaycall(var_2, ::disconnectpaths);

      break;
    case "up":
      if(isDefined(var_3))
        var_7 = var_5._id_BCDA.origin + (0, 0, var_3);

      break;
    case "down":
      if(isDefined(var_3))
        var_7 = var_5._id_BCDA.origin + (0, 0, var_3 * -1);

      break;
    default:
  }

  if(!isDefined(var_7)) {
    return;
  }
  if(isDefined(var_8))
    var_5._id_BCDA thread scripts\sp\utility::play_sound_on_entity(var_8);

  var_5._id_BCDA moveTo(var_7, var_2, var_6, 0);
  wait(var_2);
  var_5.current_state = var_1;
  scripts\engine\utility::waitframe();
  var_5._id_BCDA scripts\sp\utility::_id_65DD("door_moving");
}

_id_F363(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0)) {
    var_3 = _id_794A(var_0);

    if(isDefined(var_3._id_BCDA))
      var_2 = var_3._id_BCDA;
  } else if(self != level)
    var_2 = self;

  if(!isDefined(var_2) || !isDefined(var_2.model) || !scripts\sp\utility::hastag(var_2.model, "tag_screen_locked")) {
    return;
  }
  switch (var_1) {
    case "unlock":
      var_2 showpart("tag_screen_open", var_2.model);
      var_2 hidepart("tag_screen_restricted", var_2.model);
      var_2 hidepart("tag_screen_locked", var_2.model);
      break;
    case "lock":
      var_2 hidepart("tag_screen_open", var_2.model);
      var_2 hidepart("tag_screen_restricted", var_2.model);
      var_2 showpart("tag_screen_locked", var_2.model);
      break;
    case "restricted":
      var_2 hidepart("tag_screen_open", var_2.model);
      var_2 showpart("tag_screen_restricted", var_2.model);
      var_2 hidepart("tag_screen_locked", var_2.model);
    default:
  }
}

_id_794A(var_0) {
  var_1 = var_0;

  if(isstring(var_1))
    var_1 = _id_318A(var_1);

  if(!isDefined(var_1)) {
    return;
  }
  return var_1;
}

_id_318A(var_0) {
  if(!isDefined(level.doors))
    level.doors = [];

  if(isDefined(level.doors[var_0]))
    return level.doors[var_0];

  var_1 = spawnStruct();
  var_1.name = var_0;
  var_1._id_BCDA = undefined;
  var_1.clip = undefined;
  var_2 = undefined;

  foreach(var_4 in getEntArray(var_1.name, "targetname")) {
    if(issubstr(var_4.classname, "script_model")) {
      var_1._id_BCDA = var_4;
      continue;
    }

    if(issubstr(var_4.classname, "script_brushmodel"))
      var_1.clip = var_4;
  }

  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_2) && isDefined(var_1._id_BCDA.target))
    var_2 = scripts\engine\utility::getStruct(var_1._id_BCDA.target, "targetname");

  if(!isDefined(var_1.clip))
    var_1.clip = getEnt(var_1.name + "_clip", "targetname");

  if(!isDefined(var_1.clip) && isDefined(var_1._id_BCDA.target))
    var_1.clip = getEnt(var_1._id_BCDA.target, "targetname");

  if(isDefined(var_1.clip) && !isDefined(var_1._id_BCDA))
    var_1._id_BCDA = var_1.clip;
  else if(isDefined(var_1.clip) && isDefined(var_1._id_BCDA) && var_1.clip != var_1._id_BCDA) {
    if(!var_1.clip islinked())
      var_1.clip linkTo(var_1._id_BCDA);
  }

  if(!isDefined(var_1._id_BCDA)) {
    return;
  }
  if(isDefined(var_1._id_BCDA.script_parameters))
    var_1.current_state = tolower(var_1._id_BCDA.script_parameters);

  if(isDefined(var_2) && isDefined(var_1.current_state)) {
    switch (var_1.current_state) {
      case "open":
        var_1._id_C614 = var_1._id_BCDA.origin;
        var_1._id_4289 = var_2.origin;
        break;
      case "closed":
        var_1._id_4289 = var_1._id_BCDA.origin;
        var_1._id_C614 = var_2.origin;
        break;
      default:
    }
  }

  var_1.angles = var_1._id_BCDA.angles;

  if(isDefined(var_2))
    var_1.angles = var_2.angles;

  if(isDefined(var_1._id_BCDA._id_EE52))
    var_1._id_56E8 = float(var_1._id_BCDA._id_EE52);

  var_1.time = 3;

  if(!var_1._id_BCDA scripts\sp\utility::_id_65DF("door_moving"))
    var_1._id_BCDA scripts\sp\utility::_id_65E0("door_moving");

  level.doors[var_0] = var_1;
  return var_1;
}

_id_1378F(var_0, var_1) {
  if(isstring(var_0))
    var_0 = getEnt(var_0, "targetname");

  for(;;) {
    var_2 = 0;
    var_1 = scripts\engine\utility::array_removeundefined(var_1);
    var_1 = scripts\sp\utility::_id_22B9(var_1);

    foreach(var_4 in var_1) {
      if(var_4 istouching(var_0))
        var_2++;
    }

    if(var_2 == var_1.size) {
      break;
    }

    wait 1;
  }
}

_id_13820(var_0, var_1) {
  if(isstring(var_0))
    var_0 = getEnt(var_0, "targetname");

  for(;;) {
    var_2 = 0;

    foreach(var_4 in var_1) {
      if(!var_4 istouching(var_0))
        var_2++;
    }

    if(var_2 == var_1.size) {
      break;
    }

    wait 1;
  }
}

_id_50B9(var_0, var_1, var_2, var_3) {
  level endon(var_1);
  wait(var_0);
  [[var_2]](var_3);
}

_id_127B1(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = var_0;

  if(isstring(var_0)) {
    var_5 = getEnt(var_0, "targetname");

    if(!isDefined(var_5))
      var_5 = getEnt(var_0, "script_noteworthy");
  }

  var_5 endon("death");

  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4))
      var_4 = _id_2289(var_4);

    for(var_6 = 0; var_6 < var_3.size; var_6++) {
      if(isDefined(var_4)) {
        var_4[var_6] endon(var_3[var_6]);
        var_5 thread _id_127B2(var_4[var_6], var_3[var_6]);
        continue;
      }

      self endon(var_3[var_6]);
      var_5 thread _id_127B2(self, var_3[var_6]);
    }
  }

  if(!isDefined(var_2))
    var_2 = [];
  else
    var_2 = _id_2289(var_2);

  var_5 waittill("trigger");

  switch (var_2.size) {
    case 0:
      self thread[[var_1]]();
      break;
    case 1:
      self thread[[var_1]](var_2[0]);
      break;
    case 2:
      self thread[[var_1]](var_2[0], var_2[1]);
      break;
    case 3:
      self thread[[var_1]](var_2[0], var_2[1], var_2[2]);
      break;
    case 4:
      self thread[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3]);
      break;
    case 5:
      self thread[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4]);
      break;
    case 6:
      self thread[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5]);
      break;
    case 7:
      self thread[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6]);
      break;
    case 8:
      self thread[[var_1]](var_2[0], var_2[1], var_2[2], var_2[3], var_2[4], var_2[5], var_2[6], var_2[7]);
      break;
    default:
  }
}

_id_127B2(var_0, var_1) {
  self endon("death");
  var_0 waittill(var_1);
  self delete();
}

_id_7991(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_EE52)) {
      if(var_5._id_EE52 != var_2)
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);

      continue;
    }

    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

_id_7CC0(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_EE52)) {
      if(var_5._id_EE52 != var_2)
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);

      continue;
    }

    var_3 = scripts\engine\utility::array_remove(var_3, var_5);
  }

  return var_3;
}

_id_968F(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\engine\utility::flag_exist(var_1))
    scripts\engine\utility::flag_init(var_1);

  var_5 = getEntArray(var_0, "targetname");

  foreach(var_7 in var_5)
  var_7 thread _id_BD34(var_1);
}

_id_BD34(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  foreach(var_6 in getEntArray(self.target, "targetname")) {
    if(var_6.classname == "script_model") {
      var_6 linkTo(self);
      continue;
    }

    if(var_6.classname == "script_brushmodel")
      var_4 = var_6;
  }

  if(isDefined(var_4))
    var_4 linkTo(self);

  if(!isDefined(self.target)) {}

  var_8 = scripts\engine\utility::getStruct(self.target, "targetname");
  self.origin = var_8.origin;

  if(isDefined(var_8.angles))
    self.angles = var_8.angles;

  var_9 = var_8;
  scripts\engine\utility::flag_wait(var_0);

  if(isDefined(var_9.target))
    var_9 = _id_4707(1, var_9, var_1, var_2, var_3);

  if(isDefined(var_4))
    var_10 = createnavobstaclebyent(var_4);
}

_id_4707(var_0, var_1, var_2, var_3, var_4) {
  for(;;) {
    if(isDefined(var_1.target))
      var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    else
      return;

    if(!isstruct(var_1))
      return undefined;

    var_1 scripts\sp\utility::script_delay();

    if(!isDefined(var_2)) {
      if(isDefined(var_1._id_ED75))
        var_2 = var_1._id_ED75;
      else
        var_2 = randomfloatrange(1.5, 2);
    }

    var_5 = var_2;
    var_6 = var_5 * 0.25;
    var_7 = var_5 * 0.25;

    if(var_5 < 1.0) {
      var_6 = 0;
      var_7 = 0;
    }

    if(isDefined(var_1.script_accel))
      var_6 = var_2 * var_1.script_accel;

    if(isDefined(var_1._id_ED4C))
      var_7 = var_2 * var_1._id_ED4C;

    if(isDefined(var_3))
      var_6 = var_2 * var_3;

    if(isDefined(var_4))
      var_7 = var_2 * var_4;

    self moveTo(var_1.origin, var_5, var_6, var_7);

    if(isDefined(var_1.angles)) {
      var_8 = var_2;
      self rotateTo(var_1.angles, var_8, var_8 * 0.25, var_8 * 0.25);
    }

    wait(var_5);
    scripts\engine\utility::waitframe();
  }
}

_id_1F36(var_0, var_1, var_2) {
  var_0 endon("stop_loop");
  var_0 endon("death");

  for(;;) {
    var_0 scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F29, var_0, var_1, var_2);
    scripts\sp\anim::_id_1F35(var_0, var_1);
  }
}