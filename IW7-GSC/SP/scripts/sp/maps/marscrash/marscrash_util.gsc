/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marscrash\marscrash_util.gsc
********************************************************/

_id_10626(var_0, var_1) {
  var_0 = _id_2289(var_0);
  var_2 = [];
  var_3 = [];
  var_4 = undefined;
  var_5 = 1;

  if(isDefined(var_1))
    var_2 = _id_229A(getnodearray(var_1, "script_noteworthy"));

  foreach(var_7 in var_0) {
    var_8 = var_7;

    if(isai(var_7) || isspawner(var_7))
      var_8 = var_7.name;

    if(isDefined(var_1)) {
      if(isDefined(var_8) && isDefined(var_2[var_8]))
        var_4 = var_2[var_8];

      if(!isDefined(var_4) && isDefined(var_2["NONAME" + var_5])) {
        var_9 = var_5;

        while(isDefined(var_2["NONAME" + var_9])) {
          if(isDefined(var_2["NONAME" + var_9].owner)) {
            var_9++;
            continue;
          }

          var_4 = var_2["NONAME" + var_5];
          var_5++;
          break;
        }
      }
    }

    if(isstring(var_7)) {
      switch (var_8) {
        case "salter":
          var_3 = scripts\engine\utility::array_add(var_3, _id_107BE(var_4));
          break;
        case "gator":
          var_3 = scripts\engine\utility::array_add(var_3, _id_10710(var_4));
          break;
        case "ethan":
          var_3 = scripts\engine\utility::array_add(var_3, _id_106D9(var_4));
          break;
        case "griff":
          var_3 = scripts\engine\utility::array_add(var_3, _id_10722(var_4));
          break;
        case "sipes":
          var_3 = scripts\engine\utility::array_add(var_3, _id_107DC(var_4));
          break;
        case "brooks":
          var_3 = scripts\engine\utility::array_add(var_3, _id_1065E(var_4));
          break;
        case "kloos":
          var_3 = scripts\engine\utility::array_add(var_3, _id_10750(var_4));
          break;
        case "dropoff":
          var_3 = scripts\engine\utility::array_add(var_3, _id_106AE(var_4));
          break;
        case "commo":
          var_3 = scripts\engine\utility::array_add(var_3, _id_1068C(var_4));
          break;
        case "sahora":
          var_3 = scripts\engine\utility::array_add(var_3, _id_107BD(var_4));
          break;
        case "mccallum":
          var_3 = scripts\engine\utility::array_add(var_3, _id_10766(var_4));
          break;
        default:
      }

      continue;
    }

    if(isspawner(var_7)) {
      var_10 = 1;

      if(isDefined(var_7._id_ECE7) && var_7.count == 0)
        var_10 = 0;

      var_7.count = 1;
      var_11 = var_7 scripts\sp\utility::_id_10619(1);

      if(!var_10)
        var_11 thread _id_0B77::_id_1A14(level._id_1162[var_7._id_ECE7]);

      var_3 = scripts\engine\utility::array_add(var_3, var_11);

      if(isDefined(var_4))
        var_11 _id_B399(var_4);

      continue;
    }

    if(isai(var_7)) {
      var_3 = scripts\engine\utility::array_add(var_3, var_7);

      if(isDefined(var_4))
        var_7 _id_B399(var_4);

      continue;
    }
  }

  scripts\engine\utility::waitframe();
  return var_3;
}

_id_107BE(var_0) {
  if(!isDefined(level._id_EA2C))
    level._id_EA2C = _id_107D5("salter", "Salter", "salter", "iw7_m4");

  if(isDefined(var_0))
    level._id_EA2C _id_B399(var_0);

  return level._id_EA2C;
}

_id_10710(var_0) {
  if(!isDefined(level._id_76FB))
    level._id_76FB = _id_107D5("gator", "Gator", "gator", "iw7_sdfar");

  if(isDefined(var_0))
    level._id_76FB _id_B399(var_0);

  return level._id_76FB;
}

_id_106D9(var_0) {
  if(!isDefined(level._id_6754))
    level._id_6754 = _id_107D5("ethan", "Eth.3n", "ethan", "iw7_sdfar");

  if(isDefined(var_0))
    level._id_6754 _id_B399(var_0);

  return level._id_6754;
}

_id_10722(var_0) {
  if(!isDefined(level._id_8604))
    level._id_8604 = _id_107D5("griff", "Griff", "griff", "iw7_devastator");

  if(isDefined(var_0))
    level._id_8604 _id_B399(var_0);

  return level._id_8604;
}

_id_107DC(var_0) {
  if(!isDefined(level._id_10214))
    level._id_10214 = _id_107D5("sipes", "Sipes", "sipes", "iw7_m4");

  if(isDefined(var_0))
    level._id_10214 _id_B399(var_0);

  return level._id_10214;
}

_id_1065E(var_0) {
  if(!isDefined(level._id_30F6))
    level._id_30F6 = _id_107D5("brooks", "Brooks", "brooks", "iw7_erad");

  if(isDefined(var_0))
    level._id_30F6 _id_B399(var_0);

  return level._id_30F6;
}

_id_106AE(var_0) {
  if(!isDefined(level._id_5D2E))
    level._id_5D2E = _id_107D5("dropoff", "Dropoff", "dropoff", "iw7_devastator");

  if(isDefined(var_0))
    level._id_5D2E _id_B399(var_0);

  return level._id_5D2E;
}

_id_10750(var_0) {
  if(!isDefined(level._id_A6F4))
    level._id_A6F4 = _id_107D5("kloos", "Kloos", "kloos", "iw7_erad");

  if(isDefined(var_0))
    level._id_A6F4 _id_B399(var_0);

  return level._id_A6F4;
}

_id_1068C(var_0) {
  if(!isDefined(level._id_444D))
    level._id_444D = _id_107D5("commo", "Commo", "commo", "iw7_m4");

  if(isDefined(var_0))
    level._id_444D _id_B399(var_0);

  return level._id_444D;
}

_id_10653(var_0) {
  if(!isDefined(level._id_2C23))
    level._id_2C23 = _id_107D5("boggs", "Boggs", "boggs", "iw7_m4");

  if(isDefined(var_0))
    level._id_2C23 _id_B399(var_0);

  return level._id_2C23;
}

_id_107BD(var_0) {
  if(!isDefined(level._id_EA29))
    level._id_EA29 = _id_107D5("sahora", "Sahora", "sahora", "iw7_m4");

  if(isDefined(var_0))
    level._id_EA29 _id_B399(var_0);

  return level._id_EA29;
}

_id_10766(var_0) {
  if(!isDefined(level._id_B4F1))
    level._id_B4F1 = _id_107D5("mccallum", "McCallum", "mccallum", "iw7_m4");

  if(isDefined(var_0))
    level._id_B4F1 _id_B399(var_0);

  return level._id_B4F1;
}

_id_107D5(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::get_target_ent(var_0);
  var_4.count = 1;
  var_5 = var_4 scripts\sp\utility::_id_10619(1);
  var_5.name = var_1;
  var_5._id_EDB8 = var_1;
  var_5._id_1FBB = var_2;
  var_5 scripts\sp\utility::_id_F3B5("r");
  var_5 scripts\sp\utility::_id_F2DA(0);
  var_5 _meth_839E();

  if(isDefined(var_3))
    var_5 scripts\sp\utility::_id_72EC(var_3, "primary");

  var_5._id_BFED = 1;
  var_5._id_72C7 = 1;
  var_5 thread scripts\sp\utility::_id_5131();

  if(!isDefined(level._id_1684))
    level._id_1684 = [];

  level._id_1684[var_1] = var_5;
  return var_5;
}

_id_4046(var_0, var_1) {
  if(isDefined(self.name))
    level._id_1684 = scripts\sp\utility::_id_22B2(level._id_1684, self.name);

  _id_1101C();

  if(isDefined(self._id_5D6C) && isDefined(self._id_5D6C._id_4D94) && isDefined(self._id_5D6C._id_4D94.allies))
    self._id_5D6C._id_4D94.allies = scripts\engine\utility::array_remove(self._id_5D6C._id_4D94.allies, self);

  if(isDefined(var_0) && var_0)
    self _meth_81D0();
  else
    self delete();
}

_id_1069C(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      if(isDefined(var_3.animation)) {
        var_4 = spawnStruct();
        var_4.origin = var_3.origin;
        var_4.angles = var_3.angles;
        var_3._id_ED1B = 0;
        var_5 = var_3 scripts\sp\utility::_id_10619(1);
        var_5._id_1FBB = "dead_body";

        if(var_5.weapon != "none")
          var_5 scripts\sp\utility::_id_86E4();

        var_4 thread scripts\sp\anim::_id_1EEA(var_5, var_5.animation);
        var_5 thread _id_4067();
        var_5 notsolid();
        scripts\engine\utility::waitframe();
      }
    }
  }
}

_id_4067() {
  level waittill("cleanup_dead_bodies");
  self delete();
}

_id_9312() {
  if(!isalive(self) || isDefined(self._id_ED8A) || isDefined(self._id_ED1B)) {
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
  if(!isalive(self) || isDefined(self._id_ED8A) || isDefined(self._id_ED1B)) {
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

_id_517C(var_0, var_1, var_2) {
  self notify("stop_delete_on_end");
  self endon("stop_delete_on_end");
  self endon("death");

  if(isDefined(var_1)) {
    if(!isDefined(var_2))
      var_2 = "targetname";

    var_3 = undefined;
    var_4 = getEnt(var_1, var_2);

    if(!isDefined(var_4))
      var_3 = getnode(var_1, var_2);

    for(;;) {
      var_5 = _id_13777();

      if(var_2 == "script_noteworthy" && isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == var_1) {
        break;
      }

      if(var_2 == "targetname" && isDefined(var_5.targetname) && var_5.targetname == var_1) {
        break;
      }

      self waittill("go_to_node_new_goal");
    }
  }

  self._id_E87B = 1;

  if(isDefined(var_0) && var_0) {
    scripts\sp\utility::_id_F492(1.3);
    thread scripts\sp\utility::_id_1938([self], 2048);
  }

  self waittill("reached_path_end");

  if(isDefined(self._id_B14F))
    scripts\sp\utility::_id_1101B();

  self delete();
}

_id_13777() {
  self endon("death");

  for(;;) {
    if(isDefined(self._id_A906))
      return self._id_A906;

    if(isDefined(self._id_A905))
      return self._id_A905;

    self waittill("go_to_node_new_goal");
  }
}

_id_12BA1() {
  self notify("stop_unignore_on_end");
  self endon("stop_unignore_on_end");
  self endon("death");
  self waittill("goal");
  scripts\sp\utility::_id_F415(0);
}

_id_1101C() {
  if(isDefined(self._id_B14F) && self._id_B14F)
    scripts\sp\utility::_id_1101B();
}

_id_D08D(var_0, var_1, var_2) {
  self endon("stop_trying_gesture");
  thread scripts\sp\utility::_id_C12D("stop_trying_gesture", var_0);

  for(;;) {
    var_3 = scripts\sp\utility::_id_D08C(var_1, var_2);

    if(var_3)
      return 1;
    else
      wait 0.15;
  }
}

_id_B399(var_0) {
  if(isnode(var_0)) {
    scripts\sp\utility::_id_1160F(var_0);
    return;
  } else if(isent(var_0)) {
    scripts\sp\utility::_id_11624(var_0);
    self setgoalpos(self.origin);
    return;
  }

  var_1 = undefined;
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(isDefined(var_1)) {
    self _meth_80F1(var_1.origin, var_1.angles);
    self setgoalpos(self.origin);
    return;
  }

  var_1 = getnode(var_0, "targetname");

  if(isDefined(var_1)) {
    scripts\sp\utility::_id_1160F(var_1);
    self setgoalpos(self.origin);
    return;
  }

  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1)) {
    scripts\sp\utility::_id_11624(var_1);
    self setgoalpos(self.origin);
  }
}

_id_6E55(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\engine\utility::flag_wait(var_0);

  if(isDefined(var_9))
    self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else {
    if(isDefined(var_8)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      return;
    }

    if(isDefined(var_7)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
      return;
    }

    if(isDefined(var_6)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6);
      return;
    }

    if(isDefined(var_5)) {
      self[[var_1]](var_2, var_3, var_4, var_5);
      return;
    }

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

_id_127B4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  scripts\sp\utility::_id_127B3(var_0);

  if(isDefined(var_9))
    self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else {
    if(isDefined(var_8)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8);
      return;
    }

    if(isDefined(var_7)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7);
      return;
    }

    if(isDefined(var_6)) {
      self[[var_1]](var_2, var_3, var_4, var_5, var_6);
      return;
    }

    if(isDefined(var_5)) {
      self[[var_1]](var_2, var_3, var_4, var_5);
      return;
    }

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

_id_C152(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6)) {
    foreach(var_8 in var_6)
    self endon(var_8);
  }

  self waittill(var_0);

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

_id_137BA(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3) && !scripts\engine\utility::flag_exist(var_3))
    scripts\engine\utility::flag_init(var_3);

  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = getnotetracktimes(var_0, var_1)[0];
  var_5 = var_4 * getanimlength(var_0) + var_2;
  wait(var_5);

  if(isDefined(var_3))
    scripts\engine\utility::flag_set(var_3);
}

_id_22B4(var_0, var_1, var_2) {
  var_3 = [];
  var_0 = _id_2289(var_0);
  var_4 = _id_2289(var_1);

  if(var_4.size == 0)
    return var_0;

  foreach(var_11, var_6 in var_0) {
    var_7 = 0;

    foreach(var_9 in var_4) {
      if(var_9 == var_11) {
        var_7 = 1;
        break;
      }
    }

    if(var_7) {
      continue;
    }
    var_3[var_11] = var_6;
  }

  return var_3;
}

_id_2289(var_0) {
  return scripts\engine\utility::ter_op(isarray(var_0), var_0, [var_0]);
}

_id_229A(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = 1;

  foreach(var_5 in var_0) {
    if(isDefined(var_5._id_EE52)) {
      var_1[var_5._id_EE52] = var_5;
      continue;
    }

    var_1["NONAME" + scripts\sp\utility::string(var_3)] = var_5;
    var_3++;
  }

  return var_1;
}

_id_2281(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_2 == 0) {
      var_1 = var_0[0];
      continue;
    }

    var_1 = scripts\engine\utility::array_combine(var_1, var_0[var_2]);
  }

  return var_1;
}

_id_5569() {
  level.player disableweapons();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
}

_id_6229() {
  level.player enableweapons();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowsprint(1);
}

_id_12984() {
  if(!isDefined(self._id_9067)) {
    return;
  }
  self._id_9067 setlightintensity(self._id_9067._id_C4BC);
  self._id_9067.state = "on";
}

_id_12958() {
  if(!isDefined(self._id_9067)) {
    return;
  }
  self._id_9067 setlightintensity(0);
  self._id_9067.state = "off";
}

_id_F99A() {
  if(isDefined(self._id_9067)) {
    return;
  }
  switch (self._id_7429) {
    case "Kashima":
      self._id_9067 = getEnt("kashima_light", "targetname");
      self._id_9067.origin = self gettagorigin("tag_helmetlight");
      self._id_9067.angles = self gettagangles("tag_helmetlight") + (68, 180, 0);
      break;
    case "Brooks":
      self._id_9067 = getEnt("brooks_light", "targetname");
      self._id_9067.origin = self gettagorigin("tag_helmetlight");
      self._id_9067.angles = self gettagangles("tag_helmetlight") + (68, 180, 0);
      break;
  }

  if(!isDefined(self._id_9067._id_C4BC))
    self._id_9067._id_C4BC = self._id_9067 _meth_8134();

  self._id_9067 linkTo(self, "tag_helmetlight");
  self._id_9067 setlightintensity(0);
}

_id_1168B() {
  wait 3;

  while(!level.player useButtonPressed())
    scripts\engine\utility::waitframe();

  scripts\sp\utility::_id_BF95();
}