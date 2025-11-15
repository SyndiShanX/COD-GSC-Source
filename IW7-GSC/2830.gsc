/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2830.gsc
***************************************/

main() {
  if(!scripts\engine\utility::add_init_script("autosave", ::main)) {
    return;
  }
  level.func_2668 = spawnStruct();
  level.func_2668.func_A943 = 0;
  scripts\engine\utility::flag_init("game_saving");
  scripts\engine\utility::flag_init("can_save");
  scripts\engine\utility::flag_set("can_save");
  scripts\engine\utility::flag_init("disable_autosaves");
  scripts\engine\utility::flag_init("ImmediateLevelStartSave");

  if(!isDefined(level.func_2668.func_6A42))
    level.func_2668.func_6A42 = [];

  level.func_2668.func_DAC8 = ::func_2674;
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
  return & "AUTOSAVE_AUTOSAVE";
}

func_7FD9(var_00) {
  if(var_00 == 0)
    var_01 = & "AUTOSAVE_GAME";
  else
    var_01 = & "AUTOSAVE_NOGAME";

  return var_01;
}

func_2A6D() {
  thread immediatelevelstartsave();
  thread func_2A6E();
}

immediatelevelstartsave() {
  var_00 = scripts\sp\utility::func_7F6E(level.script);

  if(!isDefined(var_00))
    var_00 = 0;

  var_00 = var_00 * 0.05;
  var_01 = scripts\sp\utility::func_7E2C(level.script);

  if(!isDefined(var_01))
    var_01 = 0;

  var_01 = var_01 * 0.001;
  wait(var_01 + var_00 + 0.15);
  var_02 = 0;

  if(isDefined(level.func_4A3A))
    var_02 = 1;
  else if(level.func_B8D0)
    var_02 = 1;
  else if(scripts\engine\utility::flag("game_saving"))
    var_02 = 1;

  if(var_02) {
    scripts\engine\utility::flag_set("ImmediateLevelStartSave");
    return;
  }

  scripts\engine\utility::flag_set("game_saving");

  if(!isalive(level.player)) {
    return;
  }
  var_03 = "levelshots / autosave / autosave_" + level.script + "immediate_start";
  _savegame("immediatelevelstart", & "AUTOSAVE_LEVELSTART", var_03, 1);
  setdvar("ui_grenade_death", "0");
  level.player _meth_8591(0);
  scripts\engine\utility::flag_clear("game_saving");
  scripts\engine\utility::flag_set("ImmediateLevelStartSave");
}

func_2A6E() {
  if(isDefined(level.func_2A6F))
    wait(level.func_2A6F);
  else
    wait 2;

  if(isDefined(level.func_4A3A)) {
    return;
  }
  if(level.func_B8D0) {
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
  var_00 = "levelshots / autosave / autosave_" + level.script + "start";
  var_01 = waitfortransientloading("beginningOfLevelSave_thread()");

  if(!isDefined(var_01)) {
    scripts\engine\utility::flag_clear("game_saving");
    return;
  }

  if(!isalive(level.player)) {
    return;
  }
  _savegame("levelstart", & "AUTOSAVE_LEVELSTART", var_00, 1);
  setdvar("ui_grenade_death", "0");
  level.player _meth_8591(0);
  scripts\engine\utility::flag_clear("game_saving");
}

func_12726(var_00) {
  var_00 waittill("trigger");
  scripts\sp\utility::func_2677();
}

func_12727(var_00) {
  var_00 waittill("trigger");
  scripts\sp\utility::func_2679();
}

func_12724(var_00) {
  if(!isDefined(var_0.func_ED0D))
    var_0.func_ED0D = 0;

  func_268E(var_00);
}

func_268E(var_00) {
  var_01 = func_7FD9(var_0.func_ED0D);

  if(!isDefined(var_01)) {
    return;
  }
  wait 1;
  var_00 waittill("trigger");
  var_02 = var_0.func_ED0D;
  var_03 = "levelshots / autosave / autosave_" + level.script + var_02;
  func_12891(var_02, var_01, var_03);

  if(isDefined(var_00))
    var_00 delete();
}

func_268B(var_00) {
  if(scripts\sp\starts::func_9C4B()) {
    return;
  }
  wait 1;
  var_00 waittill("trigger");

  if(!isDefined(var_00)) {
    return;
  }
  var_01 = var_0.func_ED0E;
  var_00 delete();

  if(isDefined(level.func_4C7F)) {
    if(![
        [level.func_4C7F]
      ]())
      return;
  }

  scripts\sp\utility::func_2669(var_01);
}

func_268D(var_00, var_01, var_02) {}

func_1190(var_00, var_01) {
  if(!specialistsavecheck())
    return 0;

  if(isDefined(level.func_B8D0) && level.func_B8D0)
    return 0;

  if(!isDefined(var_01) || !var_01)
    level notify("trying_new_autosave");

  if(scripts\engine\utility::flag("game_saving"))
    return 0;

  scripts\engine\utility::flag_set("game_saving");
  var_02 = waitfortransientloading("_autosave_game_now()");

  if(!isDefined(var_02)) {
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  for(var_03 = 0; var_03 < level.players.size; var_3++) {
    var_04 = level.players[var_03];

    if(!isalive(var_04))
      return 0;
  }

  var_05 = "save_now";
  var_06 = func_7E6B();

  if(getdvarint("reloading") != 0)
    return 0;

  if(isDefined(level.func_BF95))
    return 0;

  if(isDefined(var_00))
    var_07 = _savegamenocommit(var_05, var_06, "$default", 1);
  else
    var_07 = _savegamenocommit(var_05, var_06);

  wait 0.05;

  if(_issaverecentlyloaded()) {
    level.func_2668.func_A943 = gettime();
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  if(_isloadinganytransients()) {
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  if(var_07 < 0) {
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  if(!func_12878(var_07)) {
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  wait 2;
  scripts\engine\utility::flag_clear("game_saving");

  if(_isloadinganytransients()) {
    scripts\engine\utility::flag_clear("game_saving");
    return 0;
  }

  if(!_commitwouldbevalid(var_07))
    return 0;

  if(func_12878(var_07)) {
    _commitsave(var_07);
    level.player _meth_8591(0);
    setdvar("ui_grenade_death", "0");
  }

  return 1;
}

func_2671(var_00) {
  var_00 waittill("trigger");
  scripts\sp\utility::func_266F();
}

func_12878(var_00) {
  if(!_issavesuccessful())
    return 0;

  if(!level.player func_2688(var_00))
    return 0;

  if(scripts\engine\utility::player_is_in_jackal()) {
    if(!level.func_D127 func_2689(var_00))
      return 0;
  }

  if(!scripts\engine\utility::flag("can_save"))
    return 0;

  return 1;
}

func_12891(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(scripts\engine\utility::flag("disable_autosaves"))
    return 0;

  if(!specialistsavecheck())
    return 0;

  level endon("nextmission");
  level.player endon("death");

  if(scripts\engine\utility::flag("game_saving"))
    return 0;

  level notify("trying_new_autosave");

  if(isDefined(level.func_BF95))
    return 0;

  var_06 = 1.25;
  var_07 = 1.25;

  if(isDefined(var_03) && var_03 < var_06 + var_07) {}

  if(!isDefined(var_05))
    var_05 = 0;

  if(!isDefined(var_02))
    var_02 = "$default";

  if(!isDefined(var_04))
    var_04 = 0;

  scripts\engine\utility::flag_set("game_saving");
  var_08 = func_7E6B();
  var_09 = gettime();
  var_10 = 0;

  for(;;) {
    if(func_2685(undefined, var_04)) {
      waitfortransientloading("tryAutoSave()");

      if(getdvarint("reloading") != 0) {
        break;
      }
      if(isDefined(level.func_BF95)) {
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

      var_11 = _savegamenocommit(var_00, var_08, var_02, var_05);

      if(var_11 < 0) {
        break;
      }
      wait 0.05;

      if(_issaverecentlyloaded()) {
        level.func_2668.func_A943 = gettime();
        break;
      }

      if(_isloadinganytransients()) {
        continue;
      }
      wait(var_06);

      if(_isloadinganytransients()) {
        continue;
      }
      if(func_6A43(var_11)) {
        continue;
      }
      if(!func_2685(undefined, var_04, var_11)) {
        continue;
      }
      wait(var_07);

      if(_isloadinganytransients()) {
        continue;
      }
      if(!func_2686(var_11)) {
        continue;
      }
      if(isDefined(var_03)) {
        if(gettime() > var_09 + var_03 * 1000) {
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
      level.func_A9E7 = gettime();
      setdvar("ui_grenade_death", "0");
      break;
    }

    wait 0.25;
  }

  scripts\engine\utility::flag_clear("game_saving");
  return 1;
}

waitfortransientloading(var_00) {
  level endon("trying_new_autosave");
  var_01 = 0;

  if(_waspreloadzonesstarted()) {
    while(!_ispreloadzonescomplete()) {
      if(gettime() > var_01)
        var_01 = gettime() + 2000;

      wait 0.05;
    }
  }

  while(_isloadinganytransients()) {
    if(gettime() > var_01)
      var_01 = gettime() + 2000;

    wait 0.05;
  }

  return 1;
}

func_6A43(var_00) {
  foreach(var_02 in level.func_2668.func_6A42) {
    if(![
        [var_2["func"]]
      ]())
      return 1;
  }

  return 0;
}

func_2686(var_00) {
  return func_2685(0, 0, var_00);
}

func_2685(var_00, var_01, var_02) {
  if(isDefined(level.func_266C))
    return [[level.func_266C]]();

  if(isDefined(level.func_1093A) && ![[level.func_1093A]]())
    return 0;

  if(level.func_B8D0)
    return 0;

  if(!isDefined(var_00))
    var_00 = level.func_5A5E;

  if(!isDefined(var_01))
    var_01 = 0;

  if(var_01) {
    if(![
        [level._meth_83D2["_autosave_stealthcheck"]]
      ]())
      return 0;
  }

  if(scripts\engine\utility::player_is_in_jackal()) {
    if(!level.func_D127 func_2689(var_02))
      return 0;
  } else {
    if(!level.player func_2688(var_02))
      return 0;

    if(var_00 && !level.player func_2684(var_02))
      return 0;
  }

  if(level.func_2681) {
    if(!func_268F(var_00, var_02))
      return 0;
  }

  if(!level.player func_268C(var_00, var_02))
    return 0;

  if(isDefined(level.func_EB75) && !level.func_EB75)
    return 0;

  if(isDefined(level.cansave) && !level.cansave)
    return 0;

  if(!_issavesuccessful())
    return 0;

  return 1;
}

func_268C(var_00, var_01) {
  if(self ismeleeing() && var_00)
    return 0;

  if(self isthrowinggrenade() && var_00)
    return 0;

  if(self _meth_819F() && var_00)
    return 0;

  if(isDefined(self.func_FC69) && self.func_FC69)
    return 0;

  if(!self getteamflagcount() && !scripts\engine\utility::player_is_in_jackal() && !scripts\sp\utility::func_93AC() && !self isonground()) {
    if(bullettracepassed(level.player.origin + (0, 0, 5), level.player.origin + (0, 0, -200), 0, self))
      return 0;
  }

  if(self iswallrunning())
    return 0;

  if(scripts\engine\utility::isflashed())
    return 0;

  if(isDefined(self.func_883A) && self.func_883A == 1)
    return 0;

  return 1;
}

func_2684(var_00) {
  var_01 = self getweaponslistprimaries();

  if(var_1.size == 0)
    return 1;

  var_02 = 1;

  for(var_03 = 0; var_03 < var_1.size; var_3++) {
    if(weaponmaxammo(var_1[var_03]) > 0)
      var_02 = 0;

    var_04 = self getfractionmaxammo(var_1[var_03]);

    if(var_04 > 0.1)
      return 1;
  }

  if(var_02)
    return 1;

  return 0;
}

func_2688(var_00) {
  var_01 = self.health / self.maxhealth;

  if(var_01 < 0.5)
    return 0;

  if(scripts\sp\utility::func_65DB("player_has_red_flashing_overlay"))
    return 0;

  return 1;
}

func_2689(var_00) {
  if(isDefined(self.func_5F6F))
    return 0;

  var_01 = scripts\sp\utility::func_7B9D();

  if(var_01 < 0.5)
    return 0;

  if(isDefined(self.func_93D2) && self.func_93D2.size > 0)
    return 0;

  if(scripts\sp\utility::func_A1A8("enemy_lockon"))
    return 0;

  if(func_268A())
    return 0;

  return 1;
}

func_268A(var_00) {
  var_01 = self.spaceship_vel;
  var_02 = rotatevectorinverted(var_01, self.angles);
  var_00 = var_2[0];

  if(var_00 < 100)
    return 0;

  var_03 = var_00 * 10;
  var_03 = clamp(var_03, 0, 10000);
  var_04 = self.origin + anglesToForward(self.angles) * var_03;
  var_05 = scripts\engine\trace::capsule_trace(self.origin, var_04, 200, 400, self.angles, self);

  if(var_5["fraction"] < 1)
    return 1;
  else
    return 0;
}

func_268F(var_00, var_01) {
  var_02 = _getaiunittypearray("bad_guys", "all");

  foreach(var_04 in var_02) {
    if(!isDefined(var_4.enemy)) {
      continue;
    }
    if(!isplayer(var_4.enemy)) {
      continue;
    }
    if(isDefined(var_4.melee) && isDefined(var_4.melee.target) && isplayer(var_4.melee.target))
      return 0;

    var_05 = [[level.func_2668.func_DAC8]](var_04);

    if(var_05 == "return_even_if_low_accuracy")
      return 0;

    if(var_4.finalaccuracy < 0.021 && var_4.finalaccuracy > -1) {
      continue;
    }
    if(var_05 == "return")
      return 0;

    if(var_05 == "none") {
      continue;
    }
    var_06 = undefined;

    if(var_4.a.func_A9ED > gettime() - 500) {
      var_06 = var_04 func_7E19();

      if(var_00 || var_06)
        return 0;
    }

    if(!isDefined(var_06))
      var_06 = var_04 func_7E19();

    if(isDefined(var_4.asm.func_11AC7) && var_04 scripts\asm\asm::func_231B(var_4.asm.func_11AC7, "aim") && var_06)
      return 0;
  }

  if(scripts\sp\utility::func_D121())
    return 0;

  if(isDefined(level.func_CAF7)) {
    foreach(var_09 in level.func_CAF7) {
      if(!isDefined(var_9.func_C528)) {
        continue;
      }
      if(var_9.func_111AD == "antigrav") {
        continue;
      }
      if(distancesquared(var_9.origin, level.player.origin) < 122500)
        return 0;
    }
  }

  var_11 = getEntArray("scriptable", "code_classname");

  foreach(var_13 in var_11) {
    if(!isDefined(var_13.func_00ED) || var_13.func_00ED != "vehicle") {
      continue;
    }
    if(!isDefined(var_13.func_C528)) {
      continue;
    }
    if(distancesquared(var_13.origin, level.player.origin) < 160000)
      return 0;
  }

  return 1;
}

func_7E19() {
  return scripts\anim\utility_common::canseeenemy(0) && self canshootenemy(0);
}

func_6489() {
  if(self.finalaccuracy >= 0.021)
    return 1;

  foreach(var_01 in level.players) {
    if(distance(self.origin, var_1.origin) < 500)
      return 1;
  }

  return 0;
}

func_2674(var_00) {
  foreach(var_02 in level.players) {
    var_03 = distancesquared(var_0.origin, var_2.origin);

    if(var_03 < 40000)
      return "return_even_if_low_accuracy";
    else if(var_03 < 129600)
      return "return";
    else if(var_03 < 1000000)
      return "threat_exists";
  }

  return "none";
}

specialistsavecheck() {
  if(!scripts\sp\utility::func_93A6())
    return 1;

  if(specialistinjackal())
    return 1;

  if(func_0A2F::func_9CBB(level.template_script))
    return 1;

  if(isDefined(level.player.func_D430) && level.player.func_D430)
    return 0;

  if(!specialistitemcheck())
    return 0;

  return 1;
}

specialistinjackal() {
  if(scripts\sp\specialist_MAYBE::func_2C97())
    return 1;

  if(scripts\engine\utility::player_is_in_jackal())
    return 1;

  return 0;
}

specialistitemcheck() {
  var_00 = 0;
  var_01 = 0;
  var_00 = level.player getweaponammostock("nanoshot");
  var_01 = level.player getweaponammostock("helmet");

  if(var_00 == 0) {
    if(level.player.func_110BD == "nanoshot")
      var_00 = level.player.func_110BE;
  }

  if(var_00 < 1)
    return 0;

  if(var_01 == 0) {
    if(level.player.func_110BA == "helmet")
      var_01 = level.player.func_110BB;
  }

  if(var_01 < 1)
    return 0;

  return 1;
}