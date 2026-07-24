/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_util.gsc
******************************************************/

_id_10626(var_0, var_1, var_2) {
  var_0 = _id_2289(var_0);
  var_3 = [];
  var_4 = [];
  var_5 = 1;

  if(isDefined(var_1))
    var_3 = _id_229A(getnodearray(var_1, "script_noteworthy"));

  foreach(var_7 in var_0) {
    var_8 = undefined;
    var_9 = var_7;

    if(isai(var_7) || isspawner(var_7))
      var_9 = var_7.name;

    if(isDefined(var_1)) {
      if(isDefined(var_9) && isDefined(var_3[var_9]))
        var_8 = var_3[var_9];

      if(!isDefined(var_8) && isDefined(var_3["NONAME" + var_5])) {
        var_10 = var_5;

        while(isDefined(var_3["NONAME" + var_10])) {
          if(isDefined(var_3["NONAME" + var_10].owner)) {
            var_10++;
            continue;
          }

          var_8 = var_3["NONAME" + var_5];
          var_5++;
          break;
        }
      }

      if(!isDefined(var_8)) {}
    }

    if(isstring(var_7)) {
      switch (var_9) {
        case "salter":
          var_4 = scripts\engine\utility::array_add(var_4, _id_107BE(var_8));
          break;
        case "gator":
          var_4 = scripts\engine\utility::array_add(var_4, _id_10710(var_8));
          break;
        case "ethan":
          var_4 = scripts\engine\utility::array_add(var_4, _id_106D9(var_8));
          break;
        case "griff":
          var_4 = scripts\engine\utility::array_add(var_4, _id_10722(var_8));
          break;
        case "sipes":
          var_4 = scripts\engine\utility::array_add(var_4, _id_107DC(var_8));
          break;
        case "brooks":
          var_4 = scripts\engine\utility::array_add(var_4, _id_1065E(var_8));
          break;
        case "kloos":
          var_4 = scripts\engine\utility::array_add(var_4, _id_10750(var_8));
          break;
        case "boats":
          var_4 = scripts\engine\utility::array_add(var_4, _id_10652(var_8));
          break;
        case "dropoff":
          var_4 = scripts\engine\utility::array_add(var_4, _id_106AE(var_8));
          break;
        case "commo":
          var_4 = scripts\engine\utility::array_add(var_4, _id_1068C(var_8));
          break;
        case "sahora":
          var_4 = scripts\engine\utility::array_add(var_4, _id_107BD(var_8));
          break;
        case "mccallum":
          var_4 = scripts\engine\utility::array_add(var_4, _id_10766(var_8));
          break;
        default:
      }

      continue;
    }

    if(isspawner(var_7)) {
      var_11 = 1;

      if(isDefined(var_7._id_ECE7) && var_7.count == 0)
        var_11 = 0;

      var_7.count = 1;
      var_12 = var_7 scripts\sp\utility::_id_10619(1);

      if(!var_11)
        var_12 thread _id_0B77::_id_1A14(level._id_1162[var_7._id_ECE7]);

      var_4 = scripts\engine\utility::array_add(var_4, var_12);

      if(isDefined(var_8))
        var_12 _id_B399(var_8);

      continue;
    }

    if(isai(var_7)) {
      var_4 = scripts\engine\utility::array_add(var_4, var_7);

      if(isDefined(var_8))
        var_7 _id_B399(var_8);

      continue;
    }
  }

  if(isDefined(var_2) && var_2)
    _id_F338(var_4);

  foreach(var_15 in var_4)
  var_15.fixednodesaferadius = 128;

  scripts\engine\utility::waitframe();
  return var_4;
}

_id_107DC(var_0) {
  if(!isDefined(level._id_10214))
    level._id_10214 = _id_107D5("sipes", "Sipes", "sipes", "iw7_m4", "r");

  if(isDefined(var_0))
    level._id_10214 _id_B399(var_0);

  return level._id_10214;
}

_id_106AE(var_0) {
  if(!isDefined(level._id_5D2E))
    level._id_5D2E = _id_107D5("dropoff", "Drop Officer", "dropoff", "iw7_devastator", "r");

  if(isDefined(var_0))
    level._id_5D2E _id_B399(var_0);

  return level._id_5D2E;
}

_id_10750(var_0) {
  if(!isDefined(level._id_A6F4))
    level._id_A6F4 = _id_107D5("kloos", "Kloos", "kloos", "iw7_sdfar", "r");

  if(isDefined(var_0))
    level._id_A6F4 _id_B399(var_0);

  return level._id_A6F4;
}

_id_10652(var_0) {
  if(!isDefined(level._id_2BFF))
    level._id_2BFF = _id_107D5("boats", "Boats", "boats", "iw7_devastator", "r");

  if(isDefined(var_0))
    level._id_2BFF _id_B399(var_0);

  return level._id_2BFF;
}

_id_1068C(var_0) {
  if(!isDefined(level._id_444D))
    level._id_444D = _id_107D5("commo", "Commo", "commo", "iw7_m4", "r");

  if(isDefined(var_0))
    level._id_444D _id_B399(var_0);

  return level._id_444D;
}

_id_10653(var_0) {
  if(!isDefined(level._id_2C23))
    level._id_2C23 = _id_107D5("boggs", "Boggs", "boggs", "iw7_m4", "r");

  if(isDefined(var_0))
    level._id_2C23 _id_B399(var_0);

  return level._id_2C23;
}

_id_107BD(var_0) {
  if(!isDefined(level._id_EA29))
    level._id_EA29 = _id_107D5("sahora", "Sahora", "sahora", "iw7_m4", "r");

  if(isDefined(var_0))
    level._id_EA29 _id_B399(var_0);

  return level._id_EA29;
}

_id_1065E(var_0) {
  if(!isDefined(level._id_30F6))
    level._id_30F6 = _id_107D5("brooks_new", "Brooks", "brooks", "iw7_erad", "o");

  if(isDefined(var_0))
    level._id_30F6 _id_B399(var_0);

  return level._id_30F6;
}

_id_107BE(var_0) {
  if(!isDefined(level._id_EA2C))
    level._id_EA2C = _id_107D5("salter", "Salter", "salter", "iw7_m4", "y");

  if(isDefined(var_0))
    level._id_EA2C _id_B399(var_0);

  return level._id_EA2C;
}

_id_106D9(var_0) {
  if(!isDefined(level._id_6754))
    level._id_6754 = _id_107D5("ethan", "Ethan", "ethan", "iw7_sdfar", "g");

  if(isDefined(var_0))
    level._id_6754 _id_B399(var_0);

  return level._id_6754;
}

_id_10722(var_0) {
  if(!isDefined(level._id_8604))
    level._id_8604 = _id_107D5("griff", "Griff", "griff", "iw7_devastator", "c");

  if(isDefined(var_0))
    level._id_8604 _id_B399(var_0);

  return level._id_8604;
}

_id_10710(var_0) {
  if(!isDefined(level._id_76FB))
    level._id_76FB = _id_107D5("gator", "Gator", "gator", "iw7_erad", "b");

  if(isDefined(var_0))
    level._id_76FB _id_B399(var_0);

  return level._id_76FB;
}

_id_10766(var_0) {
  if(!isDefined(level._id_B4F1))
    level._id_B4F1 = _id_107D5("mccallum", "MaCallum", "mccallum", "iw7_m4", "p");

  if(isDefined(var_0))
    level._id_B4F1 _id_B399(var_0);

  return level._id_B4F1;
}

_id_10711(var_0, var_1) {
  var_2 = scripts\engine\utility::get_target_ent(var_0);
  var_2.count = 1;
  var_3 = var_2 scripts\sp\utility::_id_10619(1);
  var_3._id_1FBB = "generic";
  var_3._id_72C7 = 1;
  var_3 scripts\sp\utility::_id_F2DA(0);

  if(isDefined(var_1))
    var_3 _id_B399(var_1);

  return var_3;
}

_id_107D5(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::get_target_ent(var_0);
  var_5.count = 1;
  var_6 = var_5 scripts\sp\utility::_id_10619(1);
  var_6.name = var_1;
  var_6._id_EDB8 = var_1;
  var_6._id_1FBB = var_2;
  var_6._id_5952 = 1;

  if(isDefined(var_4))
    var_6._color = var_4;

  var_6 scripts\sp\utility::_id_F3B5("r");
  var_6 scripts\sp\utility::_id_F2DA(0);
  var_6 _meth_839E();

  if(isDefined(var_3))
    var_6 scripts\sp\utility::_id_72EC(var_3, "primary");

  var_6._id_72C7 = 1;
  var_6 thread scripts\sp\utility::_id_5131();

  if(!isDefined(level._id_1684))
    level._id_1684 = [];

  level._id_1684[var_1] = var_6;
  return var_6;
}

_id_13722(var_0, var_1, var_2) {
  if(isDefined(var_2))
    level endon(var_2);

  if(!isDefined(var_1))
    var_1 = 0;

  var_3 = scripts\sp\utility::_id_77DF(var_0);
  var_3 = scripts\engine\utility::array_removeundefined(var_3);

  if(var_3.size < 1)
    wait 1;

  while(var_3.size > 0) {
    var_3 = scripts\engine\utility::array_removeundefined(var_3);

    foreach(var_5 in var_3) {
      if(var_5.count <= var_1)
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);
    }

    wait 0.5;
  }
}

_id_1069C(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "cleanup_dead_bodies";

  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && isDefined(var_4.animation)) {
      var_5 = spawnStruct();
      var_5.origin = var_4.origin;
      var_5.angles = var_4.angles;
      var_4._id_ED1B = 1;
      var_6 = var_4 scripts\sp\utility::_id_10619(1);
      var_6._id_1FBB = "dead_body";

      if(!isDefined(var_6.targetname))
        var_6.targetname = "dead_body";

      if(var_6.weapon != "none")
        var_6 scripts\sp\utility::_id_86E4();

      var_5 thread scripts\sp\anim::_id_1EC3(var_6, var_6.animation);
      var_6 thread _id_4067(var_1);
      var_6 notsolid();
      scripts\engine\utility::waitframe();
    }
  }
}

_id_4067(var_0) {
  self endon("death");
  level waittill(var_0);
  self delete();
}

_id_A605(var_0, var_1, var_2) {
  level endon(var_2);
  self endon("death");

  for(;;) {
    var_3 = getEnt(var_0, "targetname");

    if(!isDefined(var_3)) {
      return;
    }
    scripts\sp\utility::_id_13630(var_0);
    var_4 = scripts\engine\utility::getStruct(var_1, "targetname");

    if(!isDefined(var_4))
      var_4 = getEnt(var_1, "targetname");

    while(isalive(self) && self istouching(var_3)) {
      self dodamage(20, var_4.origin);
      magicbullet("iw7_sdfar", var_4.origin, self gettagorigin("j_head"));
      wait 0.5;
    }
  }
}

_id_6F56(var_0, var_1, var_2) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_0, var_1);
  var_4 = getspawnerarray(var_3.target);

  if(isDefined(var_2))
    scripts\engine\utility::array_thread(var_4, scripts\sp\utility::_id_1747, var_2);

  if(var_4.size < 1) {
    return;
  }
  scripts\sp\utility::_id_6F54(var_4);
}

_id_6F57(var_0, var_1, var_2) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, "targetname");
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0);
  var_3 = scripts\engine\utility::getStruct(var_0, var_1);
  var_4 = getspawnerarray(var_3.target);

  if(var_4.size < 1) {
    return;
  }
  scripts\sp\utility::_id_22A4(var_4, "stop current floodspawner");

  if(var_2)
    scripts\sp\utility::_id_228A(var_4);
}

_id_113D4(var_0, var_1) {
  var_2 = scripts\sp\utility::_id_77DF(var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_4))
      var_4 scripts\sp\utility::_id_1747(::_id_140B, var_1);
  }
}

_id_140B(var_0) {
  self.targetname = var_0;
}

_id_F338(var_0) {
  if(!isDefined(var_0))
    var_0 = level._id_1684;

  var_0 = _id_2289(var_0);

  foreach(var_2 in var_0) {
    if(isDefined(var_2._color))
      var_2 scripts\sp\utility::_id_F3B5(var_2._color);
  }
}

_id_F3B6() {
  _id_EA0B(level._id_EA2C, "y");
  _id_EA0B(level._id_30F6, "o");
  _id_EA0B(level._id_B4F1, "p");
  _id_EA0B(level._id_8604, "c");
  _id_EA0B(level._id_6754, "g");
  _id_EA0B(level._id_A6F4, "b");
  _id_EA0B(level._id_10214, "b");
  _id_EA0B(level._id_EA29, "b");
  _id_EA0B(level._id_2BFF, "b");
}

_id_EA0B(var_0, var_1) {
  if(isDefined(var_0))
    var_0 scripts\sp\utility::_id_F3B5(var_1);
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

_id_137F2(var_0) {
  while(isDefined(var_0)) {
    var_1 = 1;

    foreach(var_3 in var_0) {
      if(isalive(var_3) && !var_3 istouching(self))
        var_1 = 0;
    }

    if(!level.player istouching(self))
      var_1 = 0;

    if(var_1) {
      break;
    }

    wait 1;
  }
}

_id_13828(var_0) {
  self endon("death");
  var_1 = var_0.size;

  if(!isarray(var_0))
    var_0 = _id_2289(var_0);

  while(var_1 > 0) {
    wait 0.2;
    var_1 = 0;
    var_0 = scripts\sp\utility::_id_22B9(var_0);

    foreach(var_3 in var_0) {
      if(var_3 istouching(self) || isPlayer(var_3) && scripts\engine\utility::flag("player_in_mars_killstreak")) {
        var_1++;
        continue;
      }

      var_3 notify("zone_cleared");
    }
  }

  self notify("zone_cleared");
}

_id_F475(var_0) {
  if(!isDefined(var_0))
    var_0 = "relaxed";

  level.player scripts\sp\utility::_id_F526(var_0);
  level.player scripts\engine\utility::allow_fire(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
}

_id_F47B(var_0) {
  scripts\engine\utility::flag_set("mars_killstreak_offline");
  thread _id_B390(var_0);

  if(!scripts\engine\utility::is_true(var_0))
    scripts\sp\utility::_id_15F5("orbit_hill3");
}

_id_F47C() {
  scripts\engine\utility::flag_clear("mars_killstreak_offline");
  level notify("mars_killstreak_online");
}

_id_B390(var_0) {
  level endon("mars_killstreak_online");
  var_1 = 3;

  while(!isDefined(level._id_B3B1) || !isDefined(level._id_B3B1._id_C6DB))
    scripts\engine\utility::waitframe();

  var_2 = newclienthudelem(level.player);
  var_2.x = 0;
  var_2.y = 0;
  var_2 setshader("overlay_static", 640, 480);
  var_2.alignx = "left";
  var_2.aligny = "top";
  var_2.sort = 1;
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_2.alpha = 1;
  var_3 = newhudelem();
  var_3.alignx = "left";
  var_3.location = 0;
  var_3.foreground = 1;
  var_3.fontscale = 5;
  var_3.sort = 20;
  var_3.color = (1, 0, 0);
  var_3.alpha = 0;
  var_3.x = 315;
  var_3.y = 200;
  var_3.alignx = "center";
  var_3.aligny = "middle";
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3 thread _id_1D38();
  level.player playSound("hack_hud_static_impact");
  level.player waittill("mars_killstreak_outro_black");
  var_2 destroy();
  var_3 destroy();

  if(!scripts\engine\utility::flag("flag_mars_killstreak_offline_message"))
    thread _id_6E3B();

  if(isDefined(level._id_8569))
    level._id_8569 playSound("weap_xlarge_npc_land");

  wait(var_1);
  level notify("killstreak_exit");

  if(!scripts\engine\utility::is_true(var_0))
    level.player thread scripts\sp\maps\marsbase\marsbase_killstreak::_id_1143D();
}

_id_1D38() {
  self endon("death");

  for(;;) {
    for(var_0 = 0; var_0 < 1; var_0 = var_0 + 0.05) {
      self.alpha = var_0;
      scripts\engine\utility::waitframe();
    }

    for(var_0 = 1; var_0 < 1; var_0 = var_0 - 0.05) {
      self.alpha = var_0;
      scripts\engine\utility::waitframe();
    }
  }
}

_id_6E3B() {
  var_0 = "weaponOfflineWarning";
  var_1 = 1;
  scripts\engine\utility::flag_set("flag_mars_killstreak_offline_message");
  level.player _meth_849C(var_0);
  wait 0.75;
  level.player _meth_849D();
  wait 0.75;
  scripts\engine\utility::flag_clear("flag_mars_killstreak_offline_message");
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

  self.disableplayeradsloscheck = _id_E2C5(self.disableplayeradsloscheck, "disableplayeradsloscheck", 0);
  self.ignoreall = _id_E2C5(self.ignoreall, "ignoreall", 0);
  self.ignoreme = _id_E2C5(self.ignoreme, "ignoreme", 0);
  self.grenadeawareness = _id_E2C5(self.grenadeawareness, "grenadeawareness", 1);
  self.badplaceawareness = _id_E2C5(self.badplaceawareness, "badplaceawareness", 1);
  self.ignoreexplosionevents = _id_E2C5(self.ignoreexplosionevents, "ignoreexplosionevents", 0);
  self.ignoresuppression = _id_E2C5(self.ignoresuppression, "ignoresuppression", 0);
  self.dontavoidplayer = _id_E2C5(self.dontavoidplayer, "dontavoidplayer", 0);
  self.newenemyreactiondistsq = _id_E2C5(self.newenemyreactiondistsq, "newEnemyReactionDistSq", 262144);
  self.disablebulletwhizbyreaction = _id_E2C5(self.disablebulletwhizbyreaction, "disableBulletWhizbyReaction", undefined);
  self._id_55EF = _id_E2C5(self._id_55EF, "disableFriendlyFireReaction", undefined);
  self.dontmelee = _id_E2C5(self.dontmelee, "dontMelee", undefined);
  self._id_6EC4 = _id_E2C5(self._id_6EC4, "flashBangImmunity", undefined);
  self.dodangerreact = _id_E2C5(self.dodangerreact, "doDangerReact", 1);
  self._id_BEFA = _id_E2C5(self._id_BEFA, "neverSprintForVariation", undefined);
  self.a._id_5605 = _id_E2C5(self.a._id_5605, "a.disablePain", 0);
  self.allowpain = _id_E2C5(self.allowpain, "allowPain", 1);
  self.fixednode = _id_E2C5(self.fixednode, "fixedNode", 0);
  self._id_EDB0 = _id_E2C5(self._id_EDB0, "script_forcegoal", undefined);
  self.goalradius = _id_E2C5(self.goalradius, "goalradius", 100);
  self._id_12E6 = undefined;
}

_id_EB5F(var_0, var_1, var_2) {
  if(isDefined(var_0))
    self._id_12E6[var_1] = var_0;
  else
    self._id_12E6[var_1] = "none";

  return var_2;
}

_id_E2C5(var_0, var_1, var_2) {
  var_3 = var_2;

  if(isDefined(self._id_12E6)) {
    if(isstring(self._id_12E6[var_1]) && self._id_12E6[var_1] == "none") {
      if(isDefined(var_0))
        var_3 = var_0;
    } else
      var_3 = self._id_12E6[var_1];
  } else if(isDefined(var_0))
    var_3 = var_0;

  return var_2;
}

_id_1C37(var_0, var_1) {
  var_0 = scripts\sp\utility::_id_DFEB(var_0);

  foreach(var_3 in var_0) {
    if(scripts\engine\utility::is_true(var_1)) {
      var_3 notify("allow_nav");
      continue;
    }

    var_3 thread _id_193B();
  }
}

_id_193B() {
  self endon("allow_nav");
  self endon("death");

  for(var_0 = 0; 1 && var_0 < 30; var_0 = var_0 + 0.05) {
    scripts\sp\utility::_id_F3DC(self.origin);
    scripts\engine\utility::waitframe();
  }
}

_id_61C9(var_0) {
  if(isalive(self)) {
    if(var_0)
      self.dontmelee = undefined;
    else
      self.dontmelee = 1;
  }
}

_id_7469() {
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_72EC("iw7_steeldragon", "primary");
}

_id_746A() {
  self endon("death");

  for(;;) {
    if(isalive(self.enemy)) {
      self _meth_851D(self.enemy);

      while(isalive(self.enemy) && self cansee(self.enemy))
        wait 0.1;

      self _meth_851E();
    }

    scripts\engine\utility::waitframe();
  }
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

_id_931B(var_0) {
  self notify("stop_unignore_on_end");
  self endon("stop_unignore_on_end");
  self endon("death");
  _id_F5CA("ignore_player");
  self waittill("reached_path_end");
  _id_F5CA(var_0);
}

_id_1101C() {
  if(isDefined(self._id_B14F) && self._id_B14F)
    scripts\sp\utility::_id_1101B();
}

_id_F5CA(var_0, var_1, var_2) {
  if(!isDefined(self._id_2ABF)) {
    if(isDefined(var_1)) {
      self._id_2ABF = var_1;
      self setthreatbiasgroup(var_1);
    } else
      self._id_2ABF = "";
  }

  if(self._id_2ABF == var_0) {
    return;
  }
  self notify("stop_threatbias_focus");
  self endon("stop_threatbias_focus");
  self endon("death");

  if(isDefined(var_2) && var_2)
    wait(randomfloatrange(1, 2));

  self._id_2ABF = var_0;
  self setthreatbiasgroup(var_0);
}

_id_1916(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self.onlytakedamagefromplayer = 0;
  self _meth_83A1();
  self _meth_81D0();
}

_id_B3A3() {
  var_0 = scripts\sp\utility::_id_7C84("actor_enemy_c8", "classname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_1747, ::_id_B3A4);
}

_id_B3A4() {
  self._id_5580 = 1;
}

_id_B3A2() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(!isPlayer(var_1)) {
      continue;
    }
    var_10 = int(var_0 * 1 - 1);

    if(var_7 == "j_head_pv_z" || var_6 == "j_head")
      var_10 = int(var_0 * 1 - 1);

    if(var_9 == "iw7_steeldragon")
      var_10 = int(var_0 * 200 - 1);

    self dodamage(var_10, var_1.origin, var_1, var_1, var_4, var_9);
    scripts\engine\utility::waitframe();
  }
}

_id_341E(var_0, var_1, var_2) {
  scripts\engine\utility::waitframe();
  self._id_1FBB = "c8";
  thread _id_347E();
  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_3.angles))
    var_3.angles = (0, 0, 0);

  self notify("c8_anim_jump_down_start");
  var_3 scripts\sp\anim::_id_1F35(self, var_1);
  self notify("c8_anim_jump_down_done");

  if(isDefined(var_2)) {
    var_4 = getnodearray(var_2, "targetname");

    if(var_4.size > 1)
      var_5 = randomint(var_4.size - 1);
    else
      var_5 = 0;

    var_6 = var_4[var_5];
    scripts\sp\utility::_id_F415(0);
    scripts\sp\utility::_id_F3D9(var_6);
  }
}

_id_347E() {
  self endon("death");
  level waittill("c8_hit_ground");
  playFX(scripts\engine\utility::getfx("drop_pod_impact"), self.origin);
  self playSound("mars_base_c8_land");
  radiusdamage(self.origin, 48, 1, 1, self, "MOD_EXPLOSIVE");
  earthquake(0.5, 1, self.origin, 2500);
}

_id_5D45(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStructArray(var_2, "script_noteworthy");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(var_6.targetname == "s_ref_droppod_c8_anim")
      var_4 = var_6;
  }

  var_8 = scripts\sp\utility::_id_10639("c8_droppod");

  if(isstring(var_0)) {
    var_9 = getspawner(var_0, var_1);
    var_0 = var_9 scripts\sp\utility::_id_10619(1);
  }

  var_0 scripts\sp\utility::_id_11645(var_8, "tag_origin");
  scripts\engine\utility::waitframe();
  var_0 linkTo(var_8);
  var_0._id_1FBB = "c8";
  var_0._id_5580 = 1;
  var_0 scripts\sp\utility::_id_B14F();
  var_0 hide();
  var_4 thread scripts\sp\anim::_id_1F35(var_8, "c8_droppod_intro");
  var_8 thread scripts\sp\anim::_id_1EC3(var_0, "droppod_c8_fall");
  level waittill("droppod_c8_land");
  var_0 show();
  var_0 unlink();
  var_8 scripts\sp\anim::_id_1F35(var_0, "droppod_c8_fall");
  var_0 scripts\sp\utility::_id_1101B();
  var_8 delete();
  return var_0;
}

_id_9CA8() {
  if(self.unittype == "c6" || self.unittype == "c8")
    return 1;

  return 0;
}

_id_B3A5(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, "axis");

  if(_id_9CA8() || self.team != var_1) {
    return;
  }
  scripts\sp\utility::_id_51E1(scripts\engine\utility::ter_op(isDefined(var_0), var_0, "frantic"));
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

_id_B3A8(var_0, var_1) {
  if(!isDefined(var_1))
    var_2 = "targetname";
  else
    var_2 = var_1;

  if(isstring(var_0))
    var_3 = getEnt(var_0, var_2);
  else
    var_3 = var_0;

  if(isDefined(var_3))
    var_3 scripts\sp\utility::_id_8E7E();

  return var_3;
}

_id_B3A9(var_0, var_1) {
  if(!isDefined(var_1))
    var_2 = "targetname";
  else
    var_2 = var_1;

  if(isstring(var_0))
    var_3 = getEntArray(var_0, var_2);
  else
    var_3 = var_0;

  foreach(var_5 in var_3) {
    if(isDefined(var_5))
      var_5 scripts\sp\utility::_id_8E7E();
  }

  return var_3;
}

_id_B3AA(var_0, var_1) {
  if(!isDefined(var_1))
    var_2 = "targetname";
  else
    var_2 = var_1;

  if(isstring(var_0))
    var_3 = getEnt(var_0, var_2);
  else
    var_3 = var_0;

  if(isDefined(var_3))
    var_3 scripts\sp\utility::_id_100D7();

  return var_3;
}

_id_B3AB(var_0, var_1) {
  if(!isDefined(var_1))
    var_2 = "targetname";
  else
    var_2 = var_1;

  if(isstring(var_0))
    var_3 = getEntArray(var_0, var_2);
  else
    var_3 = var_0;

  foreach(var_5 in var_3) {
    if(isDefined(var_5))
      var_5 scripts\sp\utility::_id_100D7();
  }

  return var_3;
}

_id_B39D() {
  var_0 = ["phys_antigrav_destructible", "phys_battery_destructible", "phys_barrel_destructible"];

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2, "targetname");
    scripts\engine\utility::array_thread(var_3, ::_id_B39E);
  }
}

_id_B39E() {
  while(!isDefined(self._id_2836))
    wait 0.1;

  self._id_2836 = self._id_2836 * 0.5;
}

_id_266E() {
  if(scripts\engine\utility::flag("player_in_mars_killstreak") || scripts\engine\utility::flag("mars_killstreak_missiles_in_progress"))
    return 0;

  return 1;
}

_id_B39B() {
  self endon("death");
  var_0 = undefined;
  var_1 = getEntArray(self.target, "targetname");

  foreach(var_3 in var_1) {
    if(var_3.classname == "script_brushmodel")
      var_0 = var_3;
  }

  var_0 linkTo(self);
  var_0 connectpaths();
  scripts\engine\utility::waittill_either("reached_end_node", "death");
  scripts\engine\utility::delaythread(0.25, scripts\sp\maps\marsbase\marsbase_code::_id_2562, self._id_E4FB, 1.75);
  self vehicle_setspeed(0, 20);
  scripts\sp\vehicle::_id_13253();
  var_0 disconnectPaths();
}

_id_B3A6() {
  var_0 = getEntArray("script_vehicle_dropship_enemy", "classname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_1747, ::_id_B3A7);
}

_id_B3A7() {
  self endon("death");

  if(isDefined(self.target))
    var_0 = getEntArray(self.target, "targetname");

  var_1 = scripts\sp\vehicle_code::_id_7D47();

  if(var_1.size < 1) {
    return;
  }
  while(!isDefined(self._id_E4FB) || self._id_E4FB.size < var_1.size)
    scripts\engine\utility::waitframe();

  foreach(var_3 in self._id_E4FB) {
    if(var_3._id_1321D == 0 || var_3._id_1321D == 1)
      var_3 delete();
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

_id_ABD3(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 3;

  if(!isDefined(var_1))
    var_1 = 1;

  if(var_1) {
    level._id_6ABB = scripts\sp\hud_util::_id_7B4F();
    level._id_6ABB.alpha = 1;
    level._id_6ABB fadeovertime(var_0);
    level._id_6ABB.alpha = 0;
  } else {
    level._id_6ABB = scripts\sp\hud_util::_id_7B4F();
    level._id_6ABB.alpha = 0;
    level._id_6ABB fadeovertime(var_0);
    level._id_6ABB.alpha = 1;
  }
}

_id_C862(var_0, var_1) {
  var_2 = scripts\sp\hud_util::_id_48B7("vfx_ui_player_pain_overlay", 0, level.player);
  var_2._id_02B4 = 1;
  var_2.enablehudlighting = 1;

  if(scripts\engine\utility::is_true(var_1))
    var_2 fadeovertime(0.05);
  else
    var_2 fadeovertime(0.5);

  var_2.alpha = 0.7;
  var_3 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);
  wait(var_3);
  var_2 fadeovertime(1.5);
  var_2.alpha = 0;
  wait 2;
  var_2 destroy();
}

_id_6E55(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");

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

_id_6E56(var_0, var_1, var_2, var_3, var_4) {
  _id_6E55(var_0, var_1, var_2, var_3, var_4, 1);
}

_id_7271(var_0) {
  if(!scripts\engine\utility::flag_exist(var_0))
    scripts\engine\utility::flag_init(var_0);

  scripts\engine\utility::flag_set(var_0);
}

_id_13BF3() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::waitframe();
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(self.damageshield) && self.damageshield == 1) {
      continue;
    }
    if(!isPlayer(var_1)) {
      if(!isDefined(var_9))
        var_9 = self.weapon;

      self dodamage(self.maxhealth, var_1.origin, var_1, var_1, var_4, var_9);
    }
  }
}

_id_127B1(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isstring(var_0))
    var_0 = getEnt(var_0, "targetname");

  var_0 endon("death");

  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    if(isDefined(var_4))
      var_4 = _id_2289(var_4);

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      if(isDefined(var_4)) {
        var_4[var_5] endon(var_3[var_5]);
        var_0 thread _id_127B2(var_4[var_5], var_3[var_5]);
        continue;
      }

      self endon(var_3[var_5]);
      var_0 thread _id_127B2(self, var_3[var_5]);
    }
  }

  if(!isDefined(var_2))
    var_2 = [];
  else
    var_2 = _id_2289(var_2);

  var_0 waittill("trigger");

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

_id_127B2(var_0, var_1) {
  self endon("death");
  var_0 waittill(var_1);
  self delete();
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

_id_127AF(var_0, var_1) {
  if(isstring(var_0))
    var_0 = getEnt(var_0, "targetname");

  var_1 = _id_2289(var_1);

  foreach(var_3 in var_1) {
    if(isstring(var_3))
      var_3 = getEnt(var_3, "targetname");

    var_3 thread _id_127B1(var_0, scripts\sp\utility::_id_F1DE);
  }
}

flag_wait_delete(var_0, var_1) {
  var_1 = _id_2289(var_1);

  foreach(var_3 in var_1) {
    if(isstring(var_3))
      var_3 = getEnt(var_3, "targetname");

    var_3 thread _id_6E55(var_0, scripts\sp\utility::_id_F1DE);
  }
}

_id_1E98(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0)
  thread _id_1E96(var_5, var_1, var_2, var_3);
}

_id_1E96(var_0, var_1, var_2, var_3, var_4) {
  var_0 notify("stop_anim_ai_linked");
  var_0 endon("stop_anim_ai_linked");

  if(isDefined(var_0._id_1EEF)) {
    var_0._id_1EEF notify("stop_loop");
    var_0._id_1EEF delete();
  }

  var_0 notify("stop_loop");
  var_0._id_1EEF = scripts\engine\utility::spawn_tag_origin();

  if(!isstruct(self))
    var_0._id_1EEF linkTo(self);

  var_0 linkTo(var_0._id_1EEF);

  if(isDefined(var_1)) {
    var_1 = _id_2289(var_1);

    foreach(var_6 in var_1) {
      var_0 notify(var_6 + "_start");
      var_0._id_1EEF notify(var_6 + "_start");
      var_0._id_1EEF scripts\sp\anim::_id_1F35(var_0, var_6);
    }
  }

  if(isDefined(var_2)) {
    var_0 notify(var_2 + "_start");
    var_0._id_1EEF notify(var_2 + "_start");
    var_0._id_1EEF thread scripts\sp\anim::_id_1EEA(var_0, var_2);
    scripts\engine\utility::waittill_any_ents(var_0._id_1EEF, "stop_loop", var_0, "stop_loop");
    var_0._id_1EEF notify("stop_loop");
  }

  if(isDefined(var_3)) {
    var_3 = _id_2289(var_3);

    foreach(var_6 in var_3) {
      var_0 notify(var_6 + "_start");
      var_0._id_1EEF notify(var_6 + "_start");
      var_0._id_1EEF scripts\sp\anim::_id_1F35(var_0, var_6);
    }
  }

  var_0 _id_1E97();

  if(isDefined(var_4))
    var_0[[var_4]]();
}

_id_1E97() {
  self unlink();

  if(isDefined(self._id_1EEF))
    self._id_1EEF delete();
}

_id_1EFD(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.player._id_1EEF))
    level.player._id_1EEF delete();

  level.player._id_1EEF = scripts\engine\utility::spawn_tag_origin();
  level.player._id_1EEF linkTo(self);

  if(!isDefined(level.player._id_E505))
    level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig");

  level.player._id_E505 hide();
  level.player._id_E505 linkTo(level.player._id_1EEF);
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player _meth_84FE();

  if(isDefined(var_2)) {
    level.player _meth_823C(level.player._id_E505, "tag_player", var_2);
    level.player scripts\engine\utility::delaycall(var_2, ::playerlinktodelta, level.player._id_E505, "tag_player", 1, 0, 0, 0, 0, 1);
  } else
    level.player playerlinktodelta(level.player._id_E505, "tag_player", 1, 0, 0, 0, 0, 1);

  level.player._id_E505 show();

  if(isDefined(var_0)) {
    var_0 = _id_2289(var_0);

    foreach(var_6 in var_0)
    level.player._id_1EEF scripts\sp\anim::_id_1F35(level.player._id_E505, var_6);
  }

  if(isDefined(var_1)) {
    level.player._id_1EEF thread scripts\sp\anim::_id_1EEA(level.player._id_E505, var_1);
    level.player._id_1EEF waittill("stop_loop");
  }

  if(!isDefined(var_3) || !var_3)
    _id_1EFE();

  if(isDefined(var_4))
    level.player[[var_4]]();
}

_id_1EFE() {
  level.player unlink();
  level.player enableweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player _meth_84FD();

  if(isDefined(level.player._id_E505))
    level.player._id_E505 delete();

  if(isDefined(level.player._id_1EEF))
    level.player._id_1EEF delete();
}

_id_10687() {
  var_0 = getEntArray("spawn_closet_airlock_door", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_10684);
}

_id_10684() {
  self.clip = getEnt(self.target, "targetname");
  self.state = "closed";
  self.ent = undefined;
  self.trigger = undefined;
  self.clip linkTo(self);
}

_id_10683(var_0, var_1, var_2) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 90);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 2);
  var_3 = var_2 / 2;
  var_4 = getEntArray(var_0, "script_noteworthy");
  var_5 = undefined;

  foreach(var_7 in var_4) {
    if(var_7.classname == "script_model") {
      var_5 = var_7;
      break;
    }
  }

  if(isDefined(var_5.state) && (var_5.state == "opening" || var_5.state == "opened")) {
    return;
  }
  if(var_5.model == "sdf_door_airlock_01")
    var_1 = -1 * var_1;

  var_5.state = "opening";
  var_5.clip connectpaths();
  var_5 rotateYaw(var_1, var_3, var_3);
  var_5 waittill("rotatedone");
  var_5.clip disconnectPaths();
  var_5.state = "opened";
}

_id_10681(var_0, var_1, var_2, var_3) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 90);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 2);
  var_4 = var_2 / 2;
  var_5 = getEntArray(var_0, "script_noteworthy");
  var_6 = undefined;

  foreach(var_8 in var_5) {
    if(var_8.classname == "script_model") {
      var_6 = var_8;
      break;
    }
  }

  if(isDefined(var_6.state) && (var_6.state == "closing" || var_6.state == "closed")) {
    return;
  }
  if(var_6.model == "sdf_door_airlock_01")
    var_1 = -1 * var_1;

  var_6.state = "closing";
  var_6.clip connectpaths();
  var_10 = 0;

  if(!isDefined(var_3)) {
    while(var_10 < 128) {
      var_10 = distance2d(level.player.origin, var_6.origin);
      var_11 = scripts\engine\utility::getclosest(var_6.origin, getaiarray("axis"), 128);

      if(isDefined(var_11)) {
        var_12 = distance2d(var_11.origin, var_6.origin);

        if(var_12 < var_10)
          var_10 = var_12;
      }

      wait 0.2;
    }
  }

  var_6 rotateYaw(-1 * var_1, var_4, var_4);
  var_6 waittill("rotatedone");
  var_6.clip disconnectPaths();
  var_6.state = "closed";
}

_id_10685(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_2);

  if(isDefined(var_3))
    level thread[[var_3]]();

  if(isDefined(var_4)) {
    var_5 = getEntArray(var_0, "script_noteworthy");

    foreach(var_7 in var_5) {
      if(isDefined(var_7))
        scripts\sp\utility::_id_16AE(var_7, var_4);
    }
  }

  while(!scripts\engine\utility::flag(var_1)) {
    scripts\engine\utility::flag_wait("flag_" + var_0);
    _id_10683(var_0);
    scripts\engine\utility::flag_waitopen("flag_" + var_0);
    _id_10681(var_0);
  }

  _id_10683();
}

_id_10682(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  if(var_1.size < 1) {
    return;
  }
  scripts\sp\utility::_id_228A(var_1);
}

_id_40AB() {
  wait 1;

  if(isDefined(level._id_10CDA) && (level._id_10CDA == "dev_mccallum_pip" || level._id_10CDA == "dev_jackal_pilot_pip" || level._id_10CDA == "dev_jackal_pilot_sacrifice_pip" || level._id_10CDA == "dev_art_review")) {
    return;
  }
  var_0 = getEnt("pre_hill_cleanup_vol", "targetname");

  foreach(var_2 in level._id_CAF7) {
    if(var_2 istouching(var_0))
      var_2 delete();
  }

  var_4 = getEntArray("script_model", "classname");
  var_5 = scripts\sp\utility::_id_81FF();

  foreach(var_7 in var_5) {
    if(isDefined(var_7.audio) && isDefined(var_7.audio._id_1113C))
      var_4 = scripts\engine\utility::array_remove(var_4, var_7.audio._id_1113C);
  }

  foreach(var_10 in var_4) {
    if(!isDefined(var_10)) {
      continue;
    }
    var_11 = var_10 istouching(var_0);
    var_12 = var_11;

    if(var_12)
      var_10 delete();
  }

  var_0 delete();
}

_id_D03C(var_0) {
  level.player playerlinktodelta(level._id_5D6C _id_0BBF::_id_796F(var_0), "tag_origin", 1, 45, 45, 45, 45, 0);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowads(1);
  level.player disableweapons();
  level.player scripts\sp\utility::_id_2B76(0.3, 0.05);
}

_id_D03E() {
  level.player enableweapons();
  level.player scripts\engine\utility::allow_jump(0);
  level.player allowdoublejump(0);
  level.player allowads(1);
  level.player _meth_823F(undefined);
  level._id_5D6C thread _id_0BBF::_id_B98D();
  level.player scripts\sp\utility::_id_F526("safe");
  level.player scripts\sp\utility::_id_2B77(0.3);
}

_id_D03D() {
  level.player enableweapons();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player scripts\engine\utility::allow_jump(1);
  level.player allowads(1);
  level.player allowdoublejump(1);
  level.player _meth_823F(undefined);
  level._id_5D6C thread _id_0BBF::_id_B98D();
  level.player scripts\sp\utility::_id_F526("normal");
  level.player scripts\sp\utility::_id_2B77(0.3);
}

_id_EA01(var_0) {
  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

_id_9BDD(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_1))
    var_1 = 0.5;

  var_3 = _id_6A8C(var_0, var_2);
  return var_3 >= var_1;
}

_id_6A8C(var_0, var_1) {
  var_2 = var_0.origin - self.origin;
  var_3 = anglesToForward(self.angles);

  if(scripts\engine\utility::is_true(var_1)) {
    var_2 = (var_2[0], var_2[1], 0);
    var_3 = (var_3[0], var_3[1], 0);
  }

  var_2 = vectorNormalize(var_2);
  var_3 = vectorNormalize(var_3);
  var_4 = vectordot(var_2, var_3);
  return var_4;
}

_id_6E43(var_0, var_1, var_2, var_3) {
  level endon(var_0);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0);
  var_4 = 0;

  while(!level.player scripts\sp\utility::_id_3849(var_1.origin, var_2)) {
    wait 0.1;

    if(isDefined(var_3)) {
      var_4 = var_4 + 0.1;

      if(var_4 >= var_3) {
        break;
      }
    }
  }

  scripts\engine\utility::flag_set(var_0);
}

_id_1080A(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_0))
    var_3 = self;

  if(!isDefined(var_1))
    var_1 = "targetname";

  if(!isDefined(var_3))
    var_3 = scripts\sp\utility::_id_8200(var_0, var_1);

  var_4 = var_3 scripts\sp\utility::_id_10808();

  if(!isDefined(var_4)) {
    return;
  }
  if(isDefined(var_2))
    var_4 thread[[var_2]]();

  var_4 scripts\sp\vehicle_paths::_id_8023();
  var_4 scripts\sp\vehicle_paths::_id_845A(var_4);
  return var_4;
}

_id_A1CA(var_0, var_1, var_2, var_3) {
  var_4 = getcsplineid(var_1);
  var_5 = undefined;

  if(isstring(var_0))
    var_5 = scripts\sp\vehicle::_id_1080C(var_0);
  else
    var_5 = var_0;

  if(isDefined(var_5)) {
    var_5 endon("death");
    var_5 scripts\sp\utility::_id_F416(1);
    var_5 scripts\sp\utility::_id_F415(1);
    var_5._id_1416 = var_1;
    var_5 _id_0BDC::_id_19A0(1);
    var_5 _meth_8555(0);
    wait 0.05;
    var_6 = getcsplinepointposition(var_4, 0);
    var_5 vehicle_teleport(var_6, var_5.angles);
    var_5 thread _id_A1CB(var_4, var_2, var_3);
  }
}

_id_A1CB(var_0, var_1, var_2) {
  thread _id_0BDC::_id_A1EF(var_0, var_1, 30);
  wait(var_2 + randomfloatrange(0, 1.0));
  thread scripts\sp\maps\marsbase\marsbase_sky_cowbell::_id_A233();
}

_id_2CDF(var_0, var_1, var_2) {
  var_3 = var_2["func_shoot"];
  var_4 = getEnt(var_0["veh_spawner"], "targetname") scripts\sp\utility::_id_10808();
  var_4._id_14A9 = var_2;
  var_4 scripts\sp\utility::_id_16B7(::_id_2CE0);
  var_4 thread _id_2CE1();
  var_4 setneargoalnotifydist(50);
  level._id_2CDF = var_4;
  var_5 = getEnt(var_0["turret"], "targetname");
  var_6 = var_0["turret"] + "_pos";
  var_7 = scripts\engine\utility::getStruct(var_6, "targetname");
  var_5.origin = var_7.origin;
  var_5.angles = var_7.angles;
  var_8 = "tag_turret_mount_ri";
  var_9 = spawn("script_model", var_4 gettagorigin(var_8));
  var_9 linkTo(var_4, var_8, (0, 0, 0), (0, 0, 0));
  var_9 setModel("veh_mil_air_ca_dropship_mount");
  var_10 = getEnt(var_0["light"], "targetname");
  var_11 = var_0["light"] + "_pos";
  var_12 = scripts\engine\utility::getStruct(var_11, "targetname");
  var_10.origin = var_12.origin;
  var_13 = getEnt(var_5.target, "targetname");
  var_14 = scripts\engine\utility::getStruct(var_13.target, "targetname");
  var_10 linkTo(var_4);
  var_5 linkTo(var_4);
  var_5 setmode("manual");
  var_15 = var_14 scripts\engine\utility::spawn_tag_origin();
  var_15 linkTo(var_4);
  var_4.tag = var_15;
  var_13.count = 1;
  var_16 = var_13 scripts\sp\utility::_id_10619(1);
  var_16 linkTo(var_15, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_15 thread scripts\sp\anim::_id_1ECC(var_16, "turret_aim_idle");
  var_16 scripts\sp\utility::_id_F2A8(1);
  var_16 setCanDamage(1);
  var_16 scripts\sp\utility::_id_16B7(::_id_2CE4);
  var_4.gunner = var_16;
  var_4.light = var_10;
  var_4.turret = var_5;
  var_4._id_BBC7 = var_9;
  var_4.turret.gunner = var_16;
  var_4._id_270C = 1;
  scripts\engine\utility::waitframe();
  var_17 = var_16 scripts\engine\utility::spawn_tag_origin();
  var_17 linkTo(var_4);
  var_4._id_ACD4 = var_17;
  playFXOnTag(scripts\engine\utility::getfx("vfx_enemy_dropship_gunner_light"), var_17, "tag_origin");
  var_0["lightTag"] = var_17;
  var_5 setturretteam("axis");
  var_5 setmode("auto_nonai");
  var_5 setleftarc(45);
  var_5 setrightarc(45);
  var_5 setbottomarc(60);

  if(isDefined(var_3))
    var_4 thread[[var_3]](var_1);

  level._id_2CDF thread _id_2CE3(var_0, var_1, var_2);
}

_id_2CE3(var_0, var_1, var_2) {
  var_3 = var_2["start"];
  var_4 = var_2["exit"];
  var_5 = var_2["func_exit"];
  var_6 = self;
  var_7 = _id_0BBF::_id_129F(var_3);
  var_8 = var_7 scripts\engine\utility::spawn_tag_origin();
  var_6 _meth_83BA(var_6, var_8);
  teleportscene();
  var_6 thread scripts\sp\vehicle::_id_1321A(scripts\engine\utility::getStruct(var_3, "targetname"));
  var_6._id_110CE = "boss_dropship_enter";
  var_6 waittill("reached_dynamic_path_end");

  if(isDefined(var_6.gunner) && isalive(var_6.gunner) && isDefined(var_5)) {
    var_6._id_110CE = "boss_dropship_hover";
    var_6[[var_5]]();
  }

  if(isDefined(var_6)) {
    var_6._id_EF05 = 1;
    var_6 _id_0BBF::_id_414A();
    var_6 thread scripts\sp\vehicle::_id_1321A(scripts\engine\utility::getStruct(var_4, "targetname"));
    var_6._id_110CE = "boss_dropship_exit";
  }

  level notify("boss_dropship_exited");

  if(isDefined(var_2["exit_notify"]))
    level notify(var_2["exit_notify"]);

  if(scripts\engine\utility::is_true(var_1["stop_shooting_on_exit"])) {
    var_6.turret notify("stop_fire");
    var_6 thread _id_0BBD::_id_5DB7("right");
  }

  var_6 waittill("reached_dynamic_path_end");
  var_6.tag delete();
  var_6.turret setmode("manual");
  var_6._id_ACD4 delete();

  if(isDefined(var_6.gunner))
    var_6.gunner delete();

  var_6._id_BBC7 delete();

  if(isDefined(var_6))
    var_6 delete();

  if(isDefined(var_0["lightTag"]))
    var_0["lightTag"] delete();
}

_id_2CE0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(var_1 == self || var_1 == self.turret)
    self.health = self.health + var_0;
  else if(var_1 == level.player)
    self notify("shot_by_player");
}

_id_2CE1() {
  self waittill("death");

  if(isDefined(self.gunner) && isalive(self.gunner))
    self.gunner _meth_81D0();

  self notify("boss_dropship_killed");
  level notify("boss_dropship_killed");
}

_id_2CE4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(var_1 == level.player) {
    self notify("shot_by_player");

    if(self.health <= 0)
      level notify("boss_dropship_gunner_killed_by_player");
  }
}

_id_4FDC(var_0) {
  thread _id_0BBD::_id_5DB9("right");
  wait 1;

  if(isDefined(self.gunner) && isalive(self.gunner))
    self.turret thread _id_035A(var_0);
}

_id_2CE2() {
  if(!isDefined(self.gunner) || !isalive(self.gunner)) {
    return;
  }
  if(!isDefined(self._id_14A9["hover_time_min"]))
    var_0["hovertime_min"] = 2;

  if(!isDefined(self._id_14A9["hover_time_max"]))
    var_0["hovertime_max"] = 5;

  thread _id_119A(self._id_14A9["hovertime_min"], self._id_14A9["hovertime_max"]);
  scripts\engine\utility::waittill_any_ents(self, "shot_by_player", self, "dropship_timed_out", self.gunner, "damage", self.gunner, "death");
}

_id_119A(var_0, var_1) {
  wait(randomintrange(var_0, var_1));
  self notify("dropship_timed_out");
}

_id_035A(var_0) {
  self endon("stop_fire");
  self endon("death");
  self.gunner endon("death");

  if(!isDefined(var_0))
    var_0 = [];

  if(isDefined(var_0["func_turret_aim"]))
    self childthread[[var_0["func_turret_aim"]]](var_0);
  else
    childthread _id_129BB(var_0);

  if(!isDefined(var_0["rest_time_min"]))
    var_0["rest_time_min"] = 0.5;

  if(!isDefined(var_0["rest_time_max"]))
    var_0["rest_time_max"] = 1.5;

  if(!isDefined(var_0["num_bursts_min"]))
    var_0["num_bursts_min"] = 5;

  if(!isDefined(var_0["num_bursts_max"]))
    var_0["num_bursts_max"] = 10;

  if(!isDefined(var_0["time_between_shots"]))
    var_0["time_between_shots"] = 0.1;

  for(;;) {
    var_1 = randomintrange(var_0["num_bursts_min"], var_0["num_bursts_max"]);

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = self _meth_8161(1);

      if(isDefined(var_3) && isalive(self.gunner)) {
        if(!scripts\engine\utility::is_true(self.gunner._id_2717))
          thread _id_129EC(self.gunner);

        self shootturret();
      }

      wait(var_0["time_between_shots"]);
    }

    self notify("turret_resting");
    wait(randomfloatrange(var_0["rest_time_min"], var_0["rest_time_max"]));
  }
}

_id_129EC(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 playLoopSound("mars_base_turret_override");
  var_0._id_2717 = 1;
  scripts\engine\utility::waittill_any_ents(self, "turret_resting", self, "stop_fire");
  var_0._id_2717 = 0;
  var_0 stoploopsound();
}

_id_129BB(var_0) {
  self.gunner endon("death");

  if(!isDefined(var_0) || !isDefined(var_0["shootat_target"]))
    var_0["shootat_target"] = level.player;

  var_1 = var_0["shootat_target"] scripts\engine\utility::spawn_tag_origin();
  self settargetentity(var_1);

  if(!isDefined(var_0["n_deviate_x"]))
    var_0["n_deviate_x"] = 10;

  if(!isDefined(var_0["n_deviate_y"]))
    var_0["n_deviate_y"] = 10;

  var_2 = var_0["shootat_target"];
  var_3 = var_0["n_deviate_x"];
  var_4 = var_0["n_deviate_y"];

  while(isDefined(var_2)) {
    var_5 = var_2.origin + (randomfloatrange(-1 * var_3, var_3), randomfloatrange(-1 * var_4, var_4), 0);
    var_1 moveTo(var_5, 0.1);
    wait 0.1;
  }
}

_id_12A28() {
  var_0 = getEnt("hill_enemy_mg_dropship_mg", "targetname");

  if(isDefined(var_0))
    var_0 delete();
}

_id_DC75() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStructArray("s_aa2_gun_target", "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3.targetname;
    var_5 = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
    var_5.targetname = var_4;
    var_5.health = 100;
    var_0 = scripts\engine\utility::add_to_array(var_0, var_5);
  }

  level.gun["aa_gun_2"] thread scripts\sp\maps\marsbase\marsbase_code::_id_14E2(undefined, 3, 1);
}

_id_138D6(var_0, var_1, var_2, var_3, var_4) {
  self endon("stop_wandering");
  self endon("death");

  if(!isDefined(var_1))
    var_1 = 5;

  if(!isDefined(var_2))
    var_2 = 10;

  if(!isDefined(var_0) || var_0.size < 2) {
    return;
  }
  if(isDefined(self._id_290A)) {
    self._id_290A = 0;
    self _meth_8484();
  }

  var_5 = scripts\engine\utility::array_randomize(var_0);
  var_6 = 0;

  for(;;) {
    var_7 = var_5[var_6];
    thread scripts\sp\utility::_id_F3DC(var_7.origin);
    var_8 = randomfloatrange(var_1, var_2);
    scripts\engine\utility::waittill_any_timeout(var_8, "goal");

    if(isDefined(var_3) && isDefined(var_4)) {
      var_9 = randomfloatrange(var_3, var_4);
      wait(var_9);
    }

    var_6++;

    if(var_6 >= var_5.size)
      var_6 = 0;
  }
}

_id_A62C() {
  self endon("death");

  while(level.player scripts\sp\utility::_id_3849(self getEye(), 1))
    wait 0.1;

  scripts\sp\utility::_id_1101B();
  self _meth_81D0();
}

_id_107D0(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1);
  var_3 setModel(var_0);

  if(isDefined(var_2))
    var_3.angles = var_2;

  return var_3;
}

_id_CE53(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_23B7, "tarp");

  foreach(var_3 in var_1)
  var_3 thread scripts\sp\anim::_id_1EEA(var_3, var_0);
}

_id_5196(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  scripts\sp\utility::_id_22A4(var_1, "stop_loop");
  scripts\sp\utility::_id_228A(var_1);
}

_id_A6E3(var_0, var_1, var_2) {
  var_0 scripts\sp\utility::_id_23B7("klaxon");

  if(scripts\engine\utility::is_true(var_2)) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_klaxon_flare"), var_0, "j_spin");
    scripts\engine\utility::array_thread(var_1, scripts\sp\lights::_id_AB83, 100, 0.5);
    scripts\engine\utility::array_call(var_1, ::linkto, var_0, "j_spin");
    var_0 thread scripts\sp\anim::_id_1EEA(var_0, "klaxon_spin");
  } else {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_klaxon_flare"), var_0, "j_spin");
    var_0 _meth_83A1();
  }
}

_id_CB9E(var_0, var_1) {
  if(!isDefined(level.player._id_4B20)) {
    level.player setclienttriggeraudiozonepartialwithfade("marsbase_pip_mix", 0.75, "mix");

    if(isDefined(var_1))
      level thread scripts\sp\pip_util::_id_2ADF(var_0);
    else
      level scripts\sp\pip_util::_id_2ADF(var_0);
  }

  if(isDefined(var_1))
    level scripts\sp\utility::_id_10350(var_1);

  level.player clearclienttriggeraudiozone(0.9);
}

_id_1168B() {
  wait 3;

  while(!level.player useButtonPressed())
    scripts\engine\utility::waitframe();

  scripts\sp\utility::_id_BF95();
}