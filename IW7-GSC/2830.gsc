/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2830.gsc
**************************************/

main() {
  if(!scripts\engine\utility::add_init_script("autosave", ::main)) {
    return;
  }
  level.var_2668 = spawnStruct();
  level.var_2668.var_A943 = 0;
  scripts\engine\utility::flag_init("game_saving");
  scripts\engine\utility::flag_init("can_save");
  scripts\engine\utility::flag_set("can_save");
  scripts\engine\utility::flag_init("disable_autosaves");
  scripts\engine\utility::flag_init("ImmediateLevelStartSave");

  if(!isDefined(level.var_2668.var_6A42)) {
    level.var_2668.var_6A42 = [];
  }

  level.var_2668.var_DAC8 = ::func_2674;
  func_2A6D();
}

func_3D54() {
  wait 2;
  level.player endon("death");
  setdvarifuninitialized("scr_savetest", "0");

  for(;;) {
    if(getdvarint("scr_savetest") > 0) {
      setdvar("scr_savetest", "0");
      scripts\sp\utility::func_2669("cheat_save");
      wait 1;
    }

    wait 0.05;
  }
}

func_7E6B() {
  return &"AUTOSAVE_AUTOSAVE";
}

func_7FD9(var_0) {
  if(var_0 == 0) {
    var_1 = &"AUTOSAVE_GAME";
  } else {
    var_1 = &"AUTOSAVE_NOGAME";
  }

  return var_1;
}

func_2A6D() {
  thread immediatelevelstartsave();
  thread func_2A6E();
}

immediatelevelstartsave() {
  var_0 = scripts\sp\utility::func_7F6E(level.script);

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_0 = var_0 * 0.05;
  var_1 = scripts\sp\utility::func_7E2C(level.script);

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_1 = var_1 * 0.001;
  wait(var_1 + var_0 + 0.15);
  var_2 = 0;

  if(isDefined(level.var_4A3A)) {
    var_2 = 1;
  } else if(level.var_B8D0) {
    var_2 = 1;
  } else if(scripts\engine\utility::flag("game_saving")) {
    var_2 = 1;
  }

  if(var_2) {
    scripts\engine\utility::flag_set("ImmediateLevelStartSave");
    return;
  }

  scripts\engine\utility::flag_set("game_saving");

  if(!isalive(level.player)) {
    return;
  }
  var_3 = "levelshots / autosave / autosave_" + level.script + "immediate_start";
  _savegame("immediatelevelstart", &"AUTOSAVE_LEVELSTART", var_3, 1);
  setdvar("ui_grenade_death", "0");
  level.player _meth_8591(0);
  scripts\engine\utility::flag_clear("game_saving");
  scripts\engine\utility::flag_set("ImmediateLevelStartSave");
}

func_2A6E() {
  if(isDefined(level.var_2A6F)) {
    wait(level.var_2A6F);
  } else {
    wait 2;
  }

  if(isDefined(level.var_4A3A)) {
    return;
  }
  if(level.var_B8D0) {
    return;
  }
  if(scripts\engine\utility::flag("game_saving")) {
    return;
  }
  if(!scripts\engine\utility::flag("ImmediateLevelStartSave")) {
    scripts\engine\utility::flag_wait("ImmediateLevelStartSave");
    wait 1;
  }

  scripts\engine\utility::flag_set("game_saving");
  var_0 = "levelshots / autosave / autosave_" + level.script + "start";
  var_1 = waitfortransientloading("beginningOfLevelSave_thread()");

  if(!isDefined(var_1)) {
    scripts\engine\utility::flag_clear("game_saving");
    return;
  }

  if(!isalive(level.player)) {
    return;
  }
  _savegame("levelstart", &"AUTOSAVE_LEVELSTART", var_0, 1);
  setdvar("ui_grenade_death", "0");
  level.player _meth_8591(0);
  scripts\engine\utility::flag_clear("game_saving");
}

func_12726(var_0) {
  var_0 waittill("trigger");
  scripts\sp\utility::func_2677();
}

func_12727(var_0) {
  var_0 waittill("trigger");
  scripts\sp\utility::func_2679();
}

func_12724(var_0) {
  if(!isDefined(var_0.var_ED0D)) {
    var_0.var_ED0D = 0;
  }

  func_268E(var_0);
}

func_268E(var_0) {
  var_1 = func_7FD9(var_0.var_ED0D);

  if(!isDefined(var_1)) {
    return;
  }
  wait 1;
  var_0 waittill("trigger");
  var_2 = var_0.var_ED0D;
  var_3 = "levelshots / autosave / autosave_" + level.script + var_2;
  func_12891(var_2, var_1, var_3);

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

func_268B(var_0) {
  if(scripts\sp\starts::func_9C4B()) {
    return;
  }
  wait 1;
  var_0 waittill("trigger");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0.var_ED0E;
  var_0 delete();

  if(isDefined(level.var_4C7F)) {
    if(![
        [level.var_4C7F]
      ]())
      return;
  }

  scripts\sp\utility::func_2669(var_1);
}

func_268D(var_0, var_1, var_2) {}

func_1190(var_0, var_1) {
  if(!specialistsavecheck()) {
    return 0;
  }

  if(isDefined(level.var_B8D0) && level.var_B8D0) {
    return 0;
  }

  if(!isDefined(var_1) || !var_1) {
    level notify("trying_new_autosave");
  }

  if(scripts\engine\utility::flag("game_saving")) {
    return 0;
  }

  scripts\engine\utility::flag_set("game_saving");
  var_2 = waitfortransientloading("_autosave_game_now()");

  if(!isDefined(var_2)) {
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(!isalive(var_4)) {
      return 0;
    }
  }

  var_5 = "save_now";
  var_6 = func_7E6B();

  if(getdvarint("reloading") != 0) {
    return 0;
  }

  if(isDefined(level.var_BF95)) {
    return 0;
  }

  if(isDefined(var_0)) {
    var_7 = _savegamenocommit(var_5, var_6, "$default", 1);
  } else {
    var_7 = _savegamenocommit(var_5, var_6);
  }

  wait 0.05;

  if(_issaverecentlyloaded()) {
    level.var_2668.var_A943 = gettime();
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  if(_isloadinganytransients()) {
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  if(var_7 < 0) {
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  if(!func_12878(var_7)) {
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  wait 2;
  scripts\engine\utility::flag_clear("game_saving");

  if(_isloadinganytransients()) {
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  if(!_commitwouldbevalid(var_7)) {
    return 0;
  }

  if(func_12878(var_7)) {
    _commitsave(var_7);
    level.player _meth_8591(0);
    setdvar("ui_grenade_death", "0");
  }

  return 1;
}

func_2671(var_0) {
  var_0 waittill("trigger");
  scripts\sp\utility::func_266F();
}

func_12878(var_0) {
  if(!_issavesuccessful()) {
    return 0;
  }

  if(!level.player func_2688(var_0)) {
    return 0;
  }

  if(scripts\engine\utility::player_is_in_jackal()) {
    if(!level.var_D127 func_2689(var_0)) {
      return 0;
    }
  }

  if(!scripts\engine\utility::flag("can_save")) {
    return 0;
  }

  return 1;
}

func_12891(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\engine\utility::flag("disable_autosaves")) {
    return 0;
  }

  if(!specialistsavecheck()) {
    return 0;
  }

  level endon("nextmission");
  level.player endon("death");

  if(scripts\engine\utility::flag("game_saving")) {
    return 0;
  }

  level notify("trying_new_autosave");

  if(isDefined(level.var_BF95)) {
    return 0;
  }

  var_6 = 1.25;
  var_7 = 1.25;

  if(isDefined(var_3) && var_3 < var_6 + var_7) {}

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = "$default";
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  scripts\engine\utility::flag_set("game_saving");
  var_8 = func_7E6B();
  var_9 = gettime();
  var_10 = 0;

  for(;;) {
    if(func_2685(undefined, var_4)) {
      waitfortransientloading("tryAutoSave()");

      if(getdvarint("reloading") != 0) {
        break;
      }
      if(isDefined(level.var_BF95)) {
        break;
      }
      var_10++;

      if(scripts\sp\utility::func_93A6()) {
        if(var_10 == 3) {
          break;
        }
        if(!specialistinjackal()) {
          if(!specialistitemcheck()) {
            break;
          }
        }
      }

      var_11 = _savegamenocommit(var_0, var_8, var_2, var_5);

      if(var_11 < 0) {
        break;
      }
      wait 0.05;

      if(_issaverecentlyloaded()) {
        level.var_2668.var_A943 = gettime();
        break;
      }

      if(_isloadinganytransients()) {
        continue;
      }
      wait(var_6);

      if(_isloadinganytransients()) {
        continue;
      }
      if(func_6A43(var_11)) {
        continue;
      }
      if(!func_2685(undefined, var_4, var_11)) {
        continue;
      }
      wait(var_7);

      if(_isloadinganytransients()) {
        continue;
      }
      if(!func_2686(var_11)) {
        continue;
      }
      if(isDefined(var_3)) {
        if(gettime() > var_9 + var_3 * 1000) {
          break;
        }
      }

      if(!scripts\engine\utility::flag("can_save")) {
        break;
      }
      if(!_commitwouldbevalid(var_11)) {
        scripts\engine\utility::flag_clear("game_saving");
        return 0;
      }

      _commitsave(var_11);
      level.player _meth_8591(0);
      level.var_A9E7 = gettime();
      setdvar("ui_grenade_death", "0");
      break;
    }

    wait 0.25;
  }

  scripts\engine\utility::flag_clear("game_saving");
  return 1;
}

waitfortransientloading(var_0) {
  level endon("trying_new_autosave");
  var_1 = 0;

  if(_waspreloadzonesstarted()) {
    while(!_ispreloadzonescomplete()) {
      if(gettime() > var_1) {
        var_1 = gettime() + 2000;
      }

      wait 0.05;
    }
  }

  while(_isloadinganytransients()) {
    if(gettime() > var_1) {
      var_1 = gettime() + 2000;
    }

    wait 0.05;
  }

  return 1;
}

func_6A43(var_0) {
  foreach(var_2 in level.var_2668.var_6A42) {
    if(![
        [var_2["func"]]
      ]())
      return 1;
  }

  return 0;
}

func_2686(var_0) {
  return func_2685(0, 0, var_0);
}

func_2685(var_0, var_1, var_2) {
  if(isDefined(level.var_266C)) {
    return [[level.var_266C]]();
  }

  if(isDefined(level.var_1093A) && ![[level.var_1093A]]()) {
    return 0;
  }

  if(level.var_B8D0) {
    return 0;
  }

  if(!isDefined(var_0)) {
    var_0 = level.var_5A5E;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1) {
    if(![
        [level._meth_83D2["_autosave_stealthcheck"]]
      ]())
      return 0;
  }

  if(scripts\engine\utility::player_is_in_jackal()) {
    if(!level.var_D127 func_2689(var_2)) {
      return 0;
    }
  } else {
    if(!level.player func_2688(var_2)) {
      return 0;
    }

    if(var_0 && !level.player func_2684(var_2)) {
      return 0;
    }
  }

  if(level.var_2681) {
    if(!func_268F(var_0, var_2)) {
      return 0;
    }
  }

  if(!level.player func_268C(var_0, var_2)) {
    return 0;
  }

  if(isDefined(level.var_EB75) && !level.var_EB75) {
    return 0;
  }

  if(isDefined(level.cansave) && !level.cansave) {
    return 0;
  }

  if(!_issavesuccessful()) {
    return 0;
  }

  return 1;
}

func_268C(var_0, var_1) {
  if(self ismeleeing() && var_0) {
    return 0;
  }

  if(self isthrowinggrenade() && var_0) {
    return 0;
  }

  if(self _meth_819F() && var_0) {
    return 0;
  }

  if(isDefined(self.var_FC69) && self.var_FC69) {
    return 0;
  }

  if(!self getteamflagcount() && !scripts\engine\utility::player_is_in_jackal() && !scripts\sp\utility::func_93AC() && !self isonground()) {
    if(bullettracepassed(level.player.origin + (0, 0, 5), level.player.origin + (0, 0, -200), 0, self)) {
      return 0;
    }
  }

  if(self iswallrunning()) {
    return 0;
  }

  if(scripts\engine\utility::isflashed()) {
    return 0;
  }

  if(isDefined(self.var_883A) && self.var_883A == 1) {
    return 0;
  }

  return 1;
}

func_2684(var_0) {
  var_1 = self getweaponslistprimaries();

  if(var_1.size == 0) {
    return 1;
  }

  var_2 = 1;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(weaponmaxammo(var_1[var_3]) > 0) {
      var_2 = 0;
    }

    var_4 = self getfractionmaxammo(var_1[var_3]);

    if(var_4 > 0.1) {
      return 1;
    }
  }

  if(var_2) {
    return 1;
  }

  return 0;
}

func_2688(var_0) {
  var_1 = self.health / self.maxhealth;

  if(var_1 < 0.5) {
    return 0;
  }

  if(scripts\sp\utility::func_65DB("player_has_red_flashing_overlay")) {
    return 0;
  }

  return 1;
}

func_2689(var_0) {
  if(isDefined(self.var_5F6F)) {
    return 0;
  }

  var_1 = scripts\sp\utility::func_7B9D();

  if(var_1 < 0.5) {
    return 0;
  }

  if(isDefined(self.var_93D2) && self.var_93D2.size > 0) {
    return 0;
  }

  if(scripts\sp\utility::func_A1A8("enemy_lockon")) {
    return 0;
  }

  if(func_268A()) {
    return 0;
  }

  return 1;
}

func_268A(var_0) {
  var_1 = self.spaceship_vel;
  var_2 = rotatevectorinverted(var_1, self.angles);
  var_0 = var_2[0];

  if(var_0 < 100) {
    return 0;
  }

  var_3 = var_0 * 10;
  var_3 = clamp(var_3, 0, 10000);
  var_4 = self.origin + anglesToForward(self.angles) * var_3;
  var_5 = scripts\engine\trace::capsule_trace(self.origin, var_4, 200, 400, self.angles, self);

  if(var_5["fraction"] < 1) {
    return 1;
  } else {
    return 0;
  }
}

func_268F(var_0, var_1) {
  var_2 = _getaiunittypearray("bad_guys", "all");

  foreach(var_4 in var_2) {
    if(!isDefined(var_4.enemy)) {
      continue;
    }
    if(!isplayer(var_4.enemy)) {
      continue;
    }
    if(isDefined(var_4.melee) && isDefined(var_4.melee.target) && isplayer(var_4.melee.target)) {
      return 0;
    }

    var_5 = [[level.var_2668.var_DAC8]](var_4);

    if(var_5 == "return_even_if_low_accuracy") {
      return 0;
    }

    if(var_4.finalaccuracy < 0.021 && var_4.finalaccuracy > -1) {
      continue;
    }
    if(var_5 == "return") {
      return 0;
    }

    if(var_5 == "none") {
      continue;
    }
    var_6 = undefined;

    if(var_4.a.var_A9ED > gettime() - 500) {
      var_6 = var_4 func_7E19();

      if(var_0 || var_6) {
        return 0;
      }
    }

    if(!isDefined(var_6)) {
      var_6 = var_4 func_7E19();
    }

    if(isDefined(var_4.asm.var_11AC7) && var_4 scripts\asm\asm::func_231B(var_4.asm.var_11AC7, "aim") && var_6) {
      return 0;
    }
  }

  if(scripts\sp\utility::func_D121()) {
    return 0;
  }

  if(isDefined(level.var_CAF7)) {
    foreach(var_9 in level.var_CAF7) {
      if(!isDefined(var_9.var_C528)) {
        continue;
      }
      if(var_9.var_111AD == "antigrav") {
        continue;
      }
      if(distancesquared(var_9.origin, level.player.origin) < 122500) {
        return 0;
      }
    }
  }

  var_11 = getEntArray("scriptable", "code_classname");

  foreach(var_13 in var_11) {
    if(!isDefined(var_13.var_00ED) || var_13.var_00ED != "vehicle") {
      continue;
    }
    if(!isDefined(var_13.var_C528)) {
      continue;
    }
    if(distancesquared(var_13.origin, level.player.origin) < 160000) {
      return 0;
    }
  }

  return 1;
}

func_7E19() {
  return scripts\anim\utility_common::canseeenemy(0) && self canshootenemy(0);
}

func_6489() {
  if(self.finalaccuracy >= 0.021) {
    return 1;
  }

  foreach(var_1 in level.players) {
    if(distance(self.origin, var_1.origin) < 500) {
      return 1;
    }
  }

  return 0;
}

func_2674(var_0) {
  foreach(var_2 in level.players) {
    var_3 = distancesquared(var_0.origin, var_2.origin);

    if(var_3 < 40000) {
      return "return_even_if_low_accuracy";
    } else if(var_3 < 129600) {
      return "return";
    } else if(var_3 < 1000000) {
      return "threat_exists";
    }
  }

  return "none";
}

specialistsavecheck() {
  if(!scripts\sp\utility::func_93A6()) {
    return 1;
  }

  if(specialistinjackal()) {
    return 1;
  }

  if(func_0A2F::func_9CBB(level.template_script)) {
    return 1;
  }

  if(isDefined(level.player.var_D430) && level.player.var_D430) {
    return 0;
  }

  if(!specialistitemcheck()) {
    return 0;
  }

  return 1;
}

specialistinjackal() {
  if(scripts\sp\specialist_MAYBE::func_2C97()) {
    return 1;
  }

  if(scripts\engine\utility::player_is_in_jackal()) {
    return 1;
  }

  return 0;
}

specialistitemcheck() {
  var_0 = 0;
  var_1 = 0;
  var_0 = level.player getweaponammostock("nanoshot");
  var_1 = level.player getweaponammostock("helmet");

  if(var_0 == 0) {
    if(level.player.var_110BD == "nanoshot") {
      var_0 = level.player.var_110BE;
    }
  }

  if(var_0 < 1) {
    return 0;
  }

  if(var_1 == 0) {
    if(level.player.var_110BA == "helmet") {
      var_1 = level.player.var_110BB;
    }
  }

  if(var_1 < 1) {
    return 0;
  }

  return 1;
}