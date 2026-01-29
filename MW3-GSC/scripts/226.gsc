/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\226.gsc
**************************************/

main() {
  precachestring(&"SCRIPT_COLON");
  precachestring(&"SCRIPT_TIME_REMAINING");
  precachestring(&"SCRIPT_TOTAL_SCORE");
  precachestring(&"SCRIPT_EXTRA_LIFE");
  precachestring(&"SCRIPT_CHECKPOINT");
  precachestring(&"SCRIPT_MISSION_SCORE");
  precachestring(&"SCRIPT_ZERO_DEATHS");
  precachestring(&"SCRIPT_PLUS");
  precachestring(&"SCRIPT_TIME_UP");
  precachestring(&"SCRIPT_1UP");
  precachestring(&"SCRIPT_GAME_OVER");
  precachestring(&"SCRIPT_DIFFICULTY_BONUS_ONEANDAHALF");
  precachestring(&"SCRIPT_DIFFICULTY_BONUS_THREE");
  precachestring(&"SCRIPT_DIFFICULTY_BONUS_FOUR");
  precachestring(&"SCRIPT_MISSION_COMPLETE");
  precachestring(&"SCRIPT_NEW_HIGH_SCORE");
  precachestring(&"SCRIPT_STREAK_BONUS_LOST");
  precachestring(&"SCRIPT_STREAK_COMPLETE");
  precachestring(&"SCRIPT_X");
  precacheshader("arcademode_life");
  level._id_09AB = (0.8, 2, 0.8);
  level._id_09AC = (0.3, 0.6, 0.3);
  _id_0A27();
  level._id_09AD = [];
  level._id_09AE = 10;
  level._id_09AF = [];
  level._id_09B0 = 0;
  level._id_09B1 = 0;
  level._id_09B2 = 0;
  level._id_09B3 = 1;
  common_scripts\utility::flag_init("arcadeMode_multiplier_maxed");
  setdvar("arcademode_lives_changed", 0);
  level._id_09B4 = 1;
  level._id_09B5 = 3;
  _id_0A2A();

  for(var_0 = 0; var_0 < level._id_09AE; var_0++) {
    setdvar("arcademode_checkpoint_" + var_0, "");

  }
  level._id_09B6 = 0;
  level._id_09B7 = 0;
  _id_09F3();
  common_scripts\utility::flag_init("arcademode_complete");
  common_scripts\utility::flag_init("arcademode_ending_complete");
  waittillframeend;
  level._id_09B8 = ::_id_0A0D;
  level._id_09B9 = ::_id_0A0F;
  level._id_09BA = ::player_damage;
  level._id_09BB = 50;
  level._id_09BC = 10;
  level._id_09BD = 0;

  if(getdvar("arcademode_lives") == "" || getdvar("arcademode_full") != "1" || level.script == "cargoship") {
    setdvar("arcademode_lives", 2);
    level._id_09BD = 2;
  }

  if(getdvar("arcademode_full") == "1" && level.script == "cargoship") {
    setdvar("arcademode_lives", 5);
    level._id_09BD = 5;
  }

  var_1 = getdvarint("arcadeMode_lives");
  setdvar("arcademode_earned_lives", var_1);
  level._id_09BE = getdvarint("arcademode_playthrough_count");
  level._id_09BE++;
  setdvar("arcademode_playthrough_count", level._id_09BE);
  setdvar("arcademode_died", 0);
  setdvar("arcademode_score", 0);

  if(getdvar("arcademode_combined_score") == "" || getdvar("arcademode_full") == "1" && level.script == "cargoship") {
    setdvar("arcademode_combined_score", 0);

  }
  var_2 = _id_09C6();
  var_2 = var_2 * 60;
  level._id_09BF = gettime();
  level._id_09C0 = var_2;
  level._id_09C1 = 50;
  level._id_09C2 = 5;
  level._id_09C3 = [];
  var_3 = getarraykeys(level._id_09C4);

  for(var_0 = 0; var_0 < var_3.size; var_0++) {
    level._id_09C3[var_3[var_0]] = [];

  }
  var_4 = level._id_09C3;
  thread _id_09D0();
  thread _id_09EA();
  thread _id_09CE();
  thread _id_09C8();
  _id_09D7(var_1);

  for(;;) {
    wait 0.05;
    waittillframeend;
    waittillframeend;
    var_3 = getarraykeys(level._id_09C3);
    common_scripts\utility::array_levelthread(var_3, ::_id_0A09);
    level._id_09C3 = var_4;
  }
}

_id_09C5() {
  if(getdvar("arcademode") != "1") {
    return 0;

  }
  return common_scripts\utility::flag("arcademode_complete");
}

_id_09C6() {
  var_0 = 20;
  var_1 = [];
  var_2 = 1;

  if(isDefined(var_1[level.script])) {
    var_0 = var_1[level.script];

  }
  level._id_09C7 = var_2;
  return var_0;
}

_id_09C8() {
  level endon("arcademode_complete");
  level maps\_utility::_id_09C9(common_scripts\utility::flag_wait, "missionfailed");
  level.player maps\_utility::_id_09C9(maps\_utility::_id_09CA, "death");
  maps\_utility::_id_09CB();
  setdvar("arcademode_died", 1);
  var_0 = getdvarint("arcademode_lives");
  var_1 = getdvarint("arcademode_earned_lives");

  if(var_0 > var_1) {
    var_0 = var_1;

  }
  var_0 = var_0 - 1;
  setdvar("arcademode_lives", var_0);
  setdvar("arcademode_lives_changed", -1);
  _id_09D7(var_0 + 1);
  level._id_09CC = 1;
  _id_09ED();

  if(var_0 < 0) {
    wait 1.5;
    level._id_09CD = &"SCRIPT_GAME_OVER";
    thread _id_0A15();
    return;
  }

  if(isalive(level.player)) {
    missionfailed();
  }
}

_id_09CE() {
  level.player endon("death");
  var_0 = newhudelem();
  var_0.foreground = 1;
  var_0.alignx = "right";
  var_0.aligny = "top";
  var_0.horzalign = "right";
  var_0.vertalign = "top";
  var_0.x = 0;
  var_0.y = 60;
  var_0.sort = level._id_09BB;
  var_0.fontscale = 3;
  var_0.color = (0.8, 1, 0.8);
  var_0.font = "objective";
  var_0.glowcolor = (0.3, 0.6, 0.3);
  var_0.glowalpha = 1;
  var_0.hidewheninmenu = 1;
  level._id_09CF = var_0;
  level endon("arcadeMode_remove_timer");
  var_1 = level._id_09C0;
  var_0 settimer(var_1 - 0.1);
  wait(var_1);
  level._id_09CD = &"SCRIPT_TIME_UP";
  thread _id_0A15();
}

_id_09D0() {
  level.player endon("death");
  level endon("missionfailed");
  level._id_09D1 = [];

  for(var_0 = 0; var_0 < level._id_09BC; var_0++) {
    _id_09F2(var_0, 16, 78, -18, 64, level._id_09BB);

  }
  for(;;) {
    var_1 = getdvarint("arcademode_lives_changed");

    if(var_1 != 0) {
      var_2 = getdvarint("arcademode_lives");

      if(var_2 < 0) {
        level._id_09CD = &"SCRIPT_GAME_OVER";
        thread _id_0A15();
        return;
      }

      if(var_1 == -1) {
        level notify("lost_streak");
        level._id_09B0 = gettime();
        thread _id_09E0(0);
        level._id_09B3 = 0;
        var_3 = getdvarint("arcademode_earned_lives");
        var_3--;
        var_2 = var_3;
        setdvar("arcademode_earned_lives", var_3);
        setdvar("arcademode_lives", var_3);
      }

      _id_09D7(var_2);
      level._id_09CC = 1;
      setdvar("arcademode_lives_changed", 0);
    }

    wait 0.05;
  }
}

_id_09D2() {
  var_0 = getdvarint("arcademode_lives");
  var_1 = getdvarint("arcademode_earned_lives");

  if(var_0 > var_1) {
    thread _id_09F9(var_0 - var_1);

  }
  setdvar("arcademode_earned_lives", var_0);
  thread _id_09D7(var_0);
  return var_0 > var_1;
}

_id_09D3() {
  if(!maps\_utility::_id_09D4()) {
    return;
  }
  _id_09D2();
  var_0 = 800;
  var_1 = 0.8;
  level.player thread common_scripts\utility::play_sound_in_space("arcademode_checkpoint", level.player getEye());
  thread _id_0A25(var_0, var_1, 1);
  thread _id_0A25(var_0, var_1, -1);
}

_id_09D5(var_0, var_1) {
  if(var_0 >= var_1) {
    self setshader("arcademode_life", 64, 64);
  } else {
    self setshader("stance_stand", 64, 64);

  }
  self fadeovertime(1);
  self.alpha = 1;
  self.glowalpha = 1;
  self.color = level._id_09AB;
}

_id_09D6(var_0) {
  if(self.alpha <= 0) {
    return;
  }
  self fadeovertime(1);
  self.alpha = 0;
  self.color = (1, 0, 0);
  self.glowalpha = 0;
}

_id_09D7(var_0) {
  if(var_0 > 10) {
    var_0 = 10;

  }
  var_1 = getdvarint("arcademode_earned_lives");

  for(var_2 = 0; var_2 < var_0; var_2++) {
    level._id_09D1[var_2] _id_09D5(var_2, var_1);

  }
  for(var_2 = var_0; var_2 < level._id_09BC; var_2++) {
    if(var_2 < 0) {
      continue;
    }
    if(var_2 >= 10) {
      continue;
    }
    level._id_09D1[var_2] _id_09D6(var_2);
  }
}

_id_09D8() {
  for(;;) {
    level common_scripts\utility::waittill_either("arcademode_decrement_kill_streak", "arcademode_new_kill");
    waittillframeend;
    _id_09D9();
  }
}

_id_09D9() {
  for(var_0 = 0; var_0 < level._id_09DA; var_0++) {
    if(var_0 >= level._id_09AF.size) {
      return;
    }
    level._id_09AF[var_0].color = level._id_09DB[level._id_09B4 - 1];
    level._id_09AF[var_0].glowcolor = level._id_09DC[level._id_09B4 - 1];
  }

  var_1 = 0;

  for(;;) {
    var_2 = level._id_09B4 + var_1;

    if(var_2 >= level._id_09DB.size) {
      var_2 = level._id_09DB.size - 1;

    }
    for(var_0 = level._id_09DA + var_1 * level._id_09B5; var_0 < level._id_09DA + (var_1 + 1) * level._id_09B5; var_0++) {
      if(var_0 >= level._id_09AF.size) {
        return;
      }
      level._id_09AF[var_0].color = level._id_09DB[var_2];
      level._id_09AF[var_0].glowcolor = level._id_09DC[var_2];
    }

    var_1++;
  }
}

_id_09DD(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("arcademode_stop_kill_streak_art");
  var_6 = newhudelem();
  var_6.foreground = 1;
  var_6.x = var_1 + var_0 * var_3;

  if(level._id_09AF.size == 0) {
    level._id_09DE = var_6.x;

  }
  var_6.y = var_2;
  var_6 setshader("arcademode_kill", var_4, var_4);
  var_6.alignx = "right";
  var_6.aligny = "top";
  var_6.horzalign = "right";
  var_6.vertalign = "top";
  var_6.sort = var_5;
  var_6.color = level._id_09AB;
  var_6.glowcolor = level._id_09AC;
  var_6.glowalpha = 1;
  var_6.hidewheninmenu = 1;
  var_7 = 0;
  level._id_09AF[level._id_09AF.size] = var_6;

  if(level._id_09AF.size == 10) {
    var_7 = 1;
    var_6.alpha = 0;
  } else {
    var_6.alpha = 1;

  }
  for(;;) {
    if(var_6.x == level._id_09DE) {
      var_8 = 4;

      if(level._id_09AF.size == 1) {
        wait 3;

      }
      var_6 fadeovertime(var_8);
      var_6.color = (1, 0, 0);
      var_6.alpha = 0;
      wait(var_8);
      level notify("arcademode_decrement_kill_streak");
      var_6 destroy();

      for(var_9 = 0; var_9 < level._id_09AF.size - 1; var_9++) {
        level._id_09AF[var_9] = level._id_09AF[var_9 + 1];

      }
      level._id_09AF[level._id_09AF.size - 1] = undefined;

      if(!level._id_09AF.size) {
        thread _id_0A2A();

      }
      return;
    }

    level waittill("arcademode_decrement_kill_streak");
    wait 0.05;
    var_6 moveovertime(0.5);
    var_6.x = var_6.x - var_3;

    if(var_7) {
      var_6 fadeovertime(0.5);
      var_6.alpha = 1;
      var_7 = 0;
    }
  }
}

_id_09DF(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.foreground = 1;
  var_4.x = var_0 + -4;
  var_4.y = var_1 + 14;
  var_4.alignx = "right";
  var_4.aligny = "top";
  var_4.horzalign = "right";
  var_4.vertalign = "top";
  var_4.color = level._id_09AB;
  var_4.sort = level._id_09BB - 1;
  var_4.alpha = 0;
  var_4.glowcolor = level._id_09AC;
  var_4.glowalpha = 0;
  var_4.hidewheninmenu = 1;
  var_4 setshader("white", var_2, var_3);
  return var_4;
}

_id_09E0(var_0) {
  if(!level._id_09B3) {
    return;
  }
  level notify("arcademode_new_kill_streak_time");
  level endon("arcademode_new_kill_streak_time");

  if(level._id_09B0 < gettime()) {
    level._id_09B0 = gettime() + var_0 * 1000;
  } else {
    level._id_09B0 = level._id_09B0 + var_0 * 1000;

  }
  waittillframeend;

  if(isDefined(level._id_09E1)) {
    level._id_09E1 fadeovertime(0.05);
    level._id_09E1.alpha = 1;
  }

  var_1 = 26;
  var_2 = 12;
  var_3 = 90;
  var_4 = level._id_09E2;
  var_5 = level._id_09E3;
  var_6 = level._id_09B0 - gettime();
  var_6 = var_6 * 0.001;

  if(var_6 > var_3) {
    var_6 = var_3;

  }
  var_6 = var_6 * var_2;
  var_6 = int(var_6);

  if(var_6 > 980) {
    var_6 = 980;

  }
  if(!isDefined(var_4)) {
    var_4 = _id_09DF(0, 0, var_6, var_1);
    var_5 = _id_09DF(3, 3, var_6, var_1);
    var_5.sort = var_5.sort - 1;
    var_5.alpha = 0.0;
    var_5.color = (0, 0, 0);
  } else {
    var_4 scaleovertime(1, var_6, var_1);
    var_5 scaleovertime(1, var_6, var_1);
    wait 1;
  }

  level._id_09E2 = var_4;
  level._id_09E3 = var_5;
  var_4 endon("death");
  var_0 = level._id_09B0 - gettime();
  var_0 = var_0 * 0.001;
  var_7 = int(var_0);

  if(var_7 > var_3) {
    var_7 = var_3;
    wait(var_0 - var_7);
  }

  for(;;) {
    var_6 = level._id_09B0 - gettime();
    var_6 = var_6 * 0.001;
    var_8 = var_6;

    if(isDefined(level._id_09E1)) {
      level._id_09E1 fadeovertime(1);
      level._id_09E1.alpha = (var_8 - 1) / 5;
    }

    var_6 = var_6 * var_2;
    var_6 = int(var_6);

    if(var_6 <= 0) {
      var_6 = 1;

    }
    if(var_6 > 980) {
      var_6 = 980;

    }
    var_4 scaleovertime(1, var_6, var_1);
    var_5 scaleovertime(1, var_6, var_1);
    wait 1;

    if(var_6 == 1) {
      break;
    }
  }

  thread _id_0A2A();
}

_id_09E4() {
  if(common_scripts\utility::flag("arcadeMode_multiplier_maxed")) {
    return;
  }
  level endon("arcadeMode_multiplier_maxed");
  level endon("arcademode_stop_kill_streak");
  level._id_09DA--;
  var_0 = gettime();

  if(level._id_09DA <= 0 && var_0 > level._id_09B1) {
    level._id_09B1 = var_0;
    var_1 = level._id_09B4;
    level._id_09B4++;

    if(level._id_09B4 >= level._id_09DB.size) {
      level._id_09B4 = level._id_09DB.size;
      thread _id_09E6();
    }

    if(var_1 != level._id_09B4) {
      level notify("arcademode_new_kill_streak");
      level.player playSound("arcademode_" + level._id_09B4 + "x");
      thread _id_0A2C();
    }

    level._id_09DA = level._id_09B5;
  }

  level notify("arcademode_new_kill");

  for(;;) {
    if(level._id_09AF.size < 10) {
      _id_09E0(5);
      return;
    }

    level waittill("arcademode_decrement_kill_streak");
  }
}

_id_09E5() {
  waittillframeend;
  waittillframeend;
  level._id_09E2 endon("death");

  for(;;) {
    var_0 = randomfloatrange(0.1, 1.0);
    level._id_09E2 fadeovertime(var_0);
    level._id_09E2.color = (randomfloat(1), randomfloat(1), randomfloat(1));
    wait(var_0);
  }
}

_id_09E6() {
  waittillframeend;

  if(common_scripts\utility::flag("arcadeMode_multiplier_maxed")) {
    return;
  }
  common_scripts\utility::flag_set("arcadeMode_multiplier_maxed");
  var_0 = 20;
  level._id_09B0 = gettime() + var_0 * 1000;
  thread _id_09E0(0);
  thread _id_09E5();
  musicstop();
  wait 0.05;
  musicplay("airplane_alt_maximum_music");
  maps\_utility::_id_09C9(maps\_utility::_id_09E7, var_0 + 1);
  level maps\_utility::_id_09C9(maps\_utility::_id_09CA, "lost_streak");
  maps\_utility::_id_09CB();
  thread _id_0A2A();
  musicstop();

  if(isDefined(level._id_09E8)) {
    wait 0.05;
    musicplay(level._id_09E8);
  }
}

_id_09E9() {
  var_0 = newhudelem();
  var_0.foreground = 1;
  var_0.x = 0;
  var_0.y = 10;
  var_0.alignx = "right";
  var_0.aligny = "top";
  var_0.horzalign = "right";
  var_0.vertalign = "top";
  var_0.score = 0;
  var_0.font = "objective";
  var_0.fontscale = 5;
  var_0.sort = level._id_09BB;
  var_0.glowcolor = level._id_09AC;
  var_0.glowalpha = 1;
  var_0.hidewheninmenu = 1;
  return var_0;
}

_id_09EA() {
  level.player endon("death");
  level._id_09EB = 10;
  level._id_09EC = [];

  for(var_0 = 0; var_0 < level._id_09EB; var_0++) {
    level._id_09EC[level._id_09EC.size] = _id_09E9();
    level._id_09EC[level._id_09EC.size - 1].x = var_0 * -30;
  }

  if(getdvarint("arcademode_full")) {
    var_1 = getdvarint("arcademode_combined_score");
  } else {
    var_1 = getdvarint("arcademode_score");

  }
  _id_09F0(var_1);
  level._id_09CC = 0;

  for(;;) {
    wait 0.05;
    _id_09ED();

    if(level._id_09CC) {
      level._id_09CC = 0;
    }
  }
}

_id_09ED() {
  if(getdvarint("arcademode_full")) {
    _id_09EE("arcadeMode_combined_score");
  } else {
    _id_09EE("arcademode_score");
  }
}

_id_09EE(var_0) {
  var_1 = getdvarint(var_0);

  if(level._id_09CC) {
    level._id_09B2 = var_1;
    _id_09F0(var_1);
    return;
  }

  if(level._id_09B2 >= var_1) {
    return;
  }
  var_2 = var_1 - level._id_09B2;
  var_3 = var_2 * 0.2 + 1;

  if(var_2 <= 15) {
    var_3 = 1;

  }
  level._id_09B2 = level._id_09B2 + var_3;

  if(level._id_09B2 > var_1) {
    level._id_09B2 = var_1;

  }
  _id_09F0(int(level._id_09B2));
}

_id_09EF(var_0) {
  var_1 = [];
  var_0 = int(var_0);

  for(;;) {
    var_1[var_1.size] = var_0 % 10;
    var_0 = int(var_0 * 0.1);

    if(var_0 <= 0) {
      break;
    }
  }

  return var_1;
}

_id_09F0(var_0) {
  _id_09F1(var_0, level._id_09EC);
}

_id_09F1(var_0, var_1) {
  var_2 = _id_09EF(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_3 >= var_1.size - 1) {
      break;
    }

    var_1[var_3] setvalue(var_2[var_3]);
    var_1[var_3].alpha = 1;
  }

  for(var_3 = var_2.size; var_3 < var_1.size; var_3++) {
    var_1[var_3].alpha = 0;

  }
  if(var_0 == 0) {
    var_1[0].alpha = 1;
    var_1[0] setvalue(0);
  }
}

_id_09F2(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = newhudelem();
  var_6.foreground = 1;
  var_6.x = var_1 + var_0 * var_3;
  var_6.y = var_2;
  var_6 setshader("stance_stand", var_4, var_4);
  var_6.alignx = "right";
  var_6.aligny = "top";
  var_6.horzalign = "right";
  var_6.vertalign = "top";
  var_6.sort = var_5;
  var_6.color = level._id_09AB;
  var_6.glowcolor = level._id_09AC;
  var_6.glowalpha = 0;
  var_6.alpha = 0;
  var_6.hidewheninmenu = 1;
  level._id_09D1[level._id_09D1.size] = var_6;
}

_id_09F3() {
  var_0[0] = 40;
  var_0[1] = 30;
  var_0[2] = 25;
  var_0[3] = 20;
  level._id_09F4 = 10;
  level._id_09F5 = var_0;
  var_1 = [];

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_1[var_2] = var_0[var_2] * 0.15;

  }
  level._id_09F6 = var_1;
}

_id_09F7(var_0) {}

_id_09F8(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.foreground = 1;
  var_4.x = var_2;
  var_4.y = var_3;
  var_4.alignx = var_0;
  var_4.aligny = "middle";
  var_4.horzalign = var_0;
  var_4.vertalign = "middle";
  var_4.fontscale = 3;

  if(getdvar("widescreen") == "1") {
    var_4.fontscale = 5;

  }
  var_4.color = (0.8, 1, 0.8);
  var_4.font = "objective";
  var_4.glowcolor = (0.3, 0.6, 0.3);
  var_4.glowalpha = 1;
  var_4.alpha = 0;
  var_4 fadeovertime(var_1);
  var_4.alpha = 1;
  var_4.hidewheninmenu = 1;
  var_4.sort = level._id_09BB + 10;
  return var_4;
}

_id_09F9(var_0) {
  for(var_1 = 0; var_1 < 5; var_1++) {
    thread _id_09FB();

  }
  var_2 = _id_09F8("center", 0.2, 0, -100);
  var_2.label = &"SCRIPT_EXTRA_LIFE";
  var_2 setvalue(var_0);
  var_2 setpulsefx(5, 3000, 1000);
  wait 5;
  var_2 destroy();
}

_id_09FA(var_0) {
  self fadeovertime(var_0);
  self.alpha = 0;
  wait(var_0);
  self destroy();
}

_id_09FB() {
  var_0 = _id_09F8("center", 0.2, 0, -100);
  var_0.alpha = randomfloatrange(0.1, 0.45);
  var_0.sort = var_0.sort - 1;
  var_0 settext(&"SCRIPT_EXTRA_LIFE");
  var_0 maps\_utility::delaythread(3, ::_id_09FA, 1);
  var_0 endon("death");
  var_1 = var_0.x;
  var_2 = var_0.y;
  var_3 = 20;

  for(;;) {
    var_4 = randomfloatrange(0.1, 0.2);
    var_0 moveovertime(var_4);
    var_0.x = var_1 + randomfloatrange(var_3 * -1, var_3);
    var_0.y = var_2 + randomfloatrange(var_3 * -1, var_3);
    wait(var_4);
  }
}

_id_09FD(var_0) {
  var_1 = var_0 - var_0 % 5;

  if(var_1 < var_0) {
    var_1 = var_1 + 5;

  }
  return var_1;
}

_id_09FE(var_0, var_1, var_2, var_3) {
  if(var_3 <= 0) {
    return;
  }
  if(isDefined(level._id_09FF[var_2])) {
    var_2 = level._id_09FF[var_2];

  }
  var_3 = int(var_3);
  var_3 = _id_09FD(var_3);
  var_3 = var_3 * level._id_09B4;
  var_4 = getdvarint("arcademode_score");
  var_4 = var_4 + var_3;
  var_5 = getdvarint("arcademode_combined_score");
  var_5 = var_5 + var_3;
  setdvar("arcademode_combined_score", var_5);
  setdvar("arcademode_score", var_4);
  var_6 = 60;
  var_7 = 1.5;
  var_8 = 0.9 + (var_3 - 10) * 0.01;

  if(var_8 > 1.4) {
    var_8 = 1.4;

  }
  var_9 = (0.75, 0, 0);

  if(var_1) {
    thread _id_09E4();
    thread _id_0A01();
    var_9 = level._id_0A00[var_2];
  }

  level.player _id_0A06(var_3);
}

_id_0A01() {
  level._id_09F4 = level._id_09F4 - 1;

  if(level._id_09F4 > 0) {
    return;
  }
  level._id_09BD++;
  var_0 = getdvarint("arcademode_lives");
  var_0++;

  if(var_0 >= level._id_09BC) {
    var_0 = level._id_09BC;
  } else {
    setdvar("arcademode_lives", var_0);
    setdvar("arcademode_lives_changed", 1);
  }

  level._id_09F4 = level._id_09F5[level.gameskill];
}

_id_0A03() {
  var_0 = 60;
  var_1 = 90;

  if(level.player._id_0A04 > 0) {
    if(level.player._id_0A04 == 1) {
      var_2 = randomint(1);
      level.player._id_0A05 = 1 - var_2;

      if(var_2) {
        var_1 = 45;
      } else {
        var_1 = 135;
      }
    } else if(level.player._id_0A04 == 2) {
      var_2 = level.player._id_0A05;

      if(var_2) {
        var_1 = 45;
      } else {
        var_1 = 135;
      }
    } else if(level.player._id_0A04 <= 4) {
      var_1 = randomfloatrange(0, 180);
      var_0 = randomfloatrange(60, 120);
    } else if(level.player._id_0A04 <= 8) {
      var_1 = randomfloatrange(0, 180);
      var_0 = randomfloatrange(60, 160);
    } else {
      var_1 = randomfloatrange(-30, 210);
      var_0 = randomfloatrange(60, 200);
    }
  }

  self.x = var_0 * cos(var_1);
  self.y = 0 - var_0 * sin(var_1);
}

_id_0A06(var_0) {
  if(var_0 == 0) {
    return;
  }
  if(!isDefined(level.player._id_0A07)) {
    level.player._id_0A07 = 0;
    level.player._id_0A04 = 0;
  }

  var_1 = newhudelem();
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1 _id_0A03();
  var_1.font = "objective";
  var_1.fontscale = 2.5;
  var_1.archived = 0;
  var_1.color = (0.5, 0.5, 0.5);
  var_1.sort = 4;
  var_2 = level._id_09B4;
  level.player._id_0A07++;
  level.player._id_0A04++;
  wait 0.05;

  if(var_0 <= 0) {
    var_1.label = &"";
    var_1.color = (1, 0, 0);
    var_1.glowcolor = (0, 0, 0);
    var_1.glowalpha = 0;
  } else {
    var_1.label = &"SCRIPT_PLUS";
    var_1.color = (1, 1, 1);
    var_1.glowcolor = level._id_09AC;
    var_1.glowalpha = 1;
  }

  var_1 setvalue(var_0);
  var_1.alpha = 1;
  var_1 changefontscaleovertime(0.15);
  var_1.fontscale = 3.5;
  wait 0.15;
  var_1 moveovertime(1.75);
  var_1.y = var_1.y - 40;
  var_1 changefontscaleovertime(0.25);
  var_1.fontscale = 2.5;
  wait 0.25;
  wait 0.5;
  var_1 fadeovertime(1.0);
  var_1.alpha = 0;
  wait 0.5;
  level.player._id_0A07--;

  if(level.player._id_0A07 == 0) {
    level.player._id_0A04 = 0;

  }
  var_1 destroy();
}

_id_0A08() {
  var_0 = 50;

  for(;;) {
    var_1 = randomint(var_0);
    var_2 = randomint(var_0);

    if(distance((0, 0, 0), (var_1, var_2, 0)) < var_0) {
      break;
    }
  }

  if(common_scripts\utility::cointoss()) {
    var_1 = var_1 * -1;

  }
  if(common_scripts\utility::cointoss()) {
    var_2 = var_2 * -1;

  }
  self.x = var_1;
  self.y = var_2;
}

_id_0A09(var_0) {
  for(var_1 = 0; var_1 < level._id_09C3[var_0].size; var_1++) {
    _id_0A0A(level._id_09C3[var_0][var_1], var_0, level._id_09C3[var_0].size);
  }
}

_id_0A0A(var_0, var_1, var_2) {
  if(var_0["type"] != "melee") {
    var_3 = level._id_09C1 + level._id_0A0B[var_0["damage_location"]] + level._id_0A0C[var_0["type"]];
  } else {
    var_3 = level._id_09C1 + level._id_0A0C[var_0["type"]];

  }
  thread _id_09FE(var_0["origin"], 1, var_1, var_3);
}

_id_0A0D(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "none";

  }
  var_3 = level._id_09FF[var_0];

  if(!isDefined(var_3)) {
    var_4 = level._id_09C1;
    thread _id_09FE(var_2, 1, "melee", var_4);
    return;
  }

  var_5["damage_location"] = var_1;
  var_5["type"] = var_3;
  var_5["origin"] = var_2;

  if(var_3 == "explosive") {
    var_5["origin"] = self.origin;

  }
  level._id_09C3[var_3][level._id_09C3[var_3].size] = var_5;
}

player_damage(var_0, var_1, var_2) {
  thread _id_09FE(var_2, 0, var_0, level._id_09C2);
}

_id_0A0F(var_0, var_1, var_2) {
  thread _id_09FE(var_2, 0, var_0, level._id_09C2 * 1.25);
}

_id_0A10() {
  setsaveddvar("ui_nextMission", "0");

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];
    var_1.maxhealth = 0;
    var_1.health = 1;
  }

  missionsuccess("killhouse");
}

_id_0A12(var_0, var_1) {
  level._id_0A13 = [];

  for(var_2 = 0; var_2 < level._id_09EB; var_2++) {
    var_3 = _id_09E9();
    level._id_0A13[level._id_0A13.size] = var_3;
    var_3.x = var_2 * -30 + -150 + var_0;
    var_3.y = var_1;
    var_3.alignx = "right";
    var_3.aligny = "middle";
    var_3.horzalign = "right";
    var_3.vertalign = "middle";
    var_3.alpha = 0;
    var_3.sort = level._id_09BB + 10;
  }
}

_id_0A14(var_0) {
  _id_09F1(var_0, level._id_0A13);
}

_id_0A15() {
  if(common_scripts\utility::flag("arcademode_complete")) {
    return;
  }
  common_scripts\utility::flag_set("arcademode_complete");
  maps\_utility::_id_0A16(0.05);
  maps\_utility::_id_0A17();
  maps\_utility::_id_0A18();

  if(level._id_09B7) {
    if(_id_09D2()) {
      wait 2;
    }
  }

  var_0 = 0;

  if(isDefined(level._id_0A19)) {
    var_0 = gettime() - level._id_0A19;
    var_0 = var_0 * 0.001;
  }

  var_1 = gettime() - level._id_09BF;
  var_1 = var_1 * 0.001;
  var_1 = var_1 - var_0;
  var_2 = level._id_09C0 - var_1;
  var_2 = int(var_2);

  if(var_2 == 0) {
    var_2++;

  }
  var_3 = 0.5;
  level._id_0A1A = 1;
  thread _id_0A22();
  thread _id_0A21(var_3);
  wait(var_3 + 0.25);
  level.player freezecontrols(1);
  var_4 = 1;
  var_5 = -140;
  var_6 = -80;
  var_7 = -20;
  var_8 = 40;
  var_9 = 100;
  var_10 = 300;
  var_11 = _id_09F8("center", var_4, 0, var_5);

  if(level._id_09B7) {
    var_11.color = (1, 1, 1);
    var_11 settext(&"SCRIPT_MISSION_COMPLETE");
  } else {
    var_11.color = (1, 0.4, 0.2);
    var_11.glowcolor = (0.75, 0.3, 0.3);
    var_11 settext(level._id_09CD);
  }

  wait 1.0;

  for(var_12 = 0; var_12 < level._id_09BC; var_12++) {
    level._id_09D1[var_12] destroy();

  }
  var_13 = 130;
  level._id_09D1 = [];

  for(var_12 = 0; var_12 < level._id_09BC; var_12++) {
    _id_09F2(var_12, -135 + var_13, var_10, -30, 96, level._id_09BB + 10);

  }
  var_14 = getdvarint("arcademode_lives");
  var_15 = level._id_09BD;

  if(var_14 > var_15) {
    var_14 = var_15;

  }
  _id_09D7(var_14);
  var_16 = 0;
  var_17 = undefined;

  if(getdvar("arcademode_full") == "1") {
    var_17 = _id_09F8("left", var_4, 20, var_6);
    var_17 settext(&"SCRIPT_TOTAL_SCORE");
    _id_0A12(var_13, var_6);
    var_16 = getdvarint("arcademode_combined_score");
    _id_0A14(var_16);
  }

  var_18 = _id_09F8("left", var_4, 20, var_7);
  var_18 settext(&"SCRIPT_MISSION_SCORE");

  for(var_12 = 0; var_12 < level._id_09EB; var_12++) {
    var_19 = level._id_09EC[var_12];
    var_19.x = var_12 * -30 + -150 + var_13;
    var_19.y = var_7;
    var_19.sort = level._id_09BB + 10;
    var_19.alignx = "right";
    var_19.aligny = "middle";
    var_19.horzalign = "right";
    var_19.vertalign = "middle";
  }

  _id_09F0(0);
  var_20 = 0;

  for(var_21 = 0; var_2 >= 60; var_2 = var_2 - 60) {
    var_20++;

  }
  var_21 = var_2;
  var_22 = _id_09F8("left", var_4, 20, var_8);
  var_22 settext(&"SCRIPT_TIME_REMAINING");
  level._id_0A1B = _id_09F8("right", var_4, -265 + var_13, var_8);
  level._id_0A1C = _id_09F8("right", var_4, -235 + var_13, var_8);
  var_23 = _id_09F8("right", var_4, -215 + var_13, var_8 - 5);
  var_23 settext(&"SCRIPT_COLON");
  level._id_0A1D = _id_09F8("right", var_4, -180 + var_13, var_8);
  level._id_0A1E = _id_09F8("right", var_4, -150 + var_13, var_8);
  _id_0A24(var_20, var_21);
  wait(var_4);
  wait 1;
  var_24 = getdvarint("arcadeMode_score");
  var_25 = 0;
  var_26 = var_16;
  var_27 = 0;

  for(;;) {
    var_28 = var_24 - var_25;
    var_29 = var_28 * 0.2 + 1;

    if(var_28 <= 15) {
      var_29 = 1;

    }
    var_29 = int(var_29);
    var_25 = var_25 + var_29;

    if(var_25 > var_24) {
      var_25 = var_24;

    }
    _id_09F0(var_25);

    if(var_25 == var_24) {
      break;
    }

    var_27--;

    if(var_27 <= 0) {
      level.player thread common_scripts\utility::play_sound_in_space("bullet_ap_dirt", level.player getEye());
      var_27 = 3;
    }

    wait 0.05;
  }

  wait 1;
  var_30 = 0;
  var_31 = undefined;

  if(level._id_09B7) {
    var_32 = 5;
    var_33 = var_20 * 60 + var_21;
    var_34 = ceil(var_33 / 15);
    var_35 = ceil(var_33 * var_32);
    var_36 = ceil(var_35 / level._id_09C7);
    var_37 = var_25;
    var_38 = var_25 + var_36;
    var_39 = var_16;
    var_40 = var_16 + var_36;

    for(var_12 = 1; var_12 <= var_34; var_12++) {
      var_41 = var_12 * 1.0 / var_34;

      if(var_12 == var_34) {
        var_41 = 1;

      }
      var_25 = int(var_37 * (1 - var_41) + var_38 * var_41);

      if(getdvar("arcademode_full") == "1") {
        var_16 = int(var_39 * (1 - var_41) + var_40 * var_41);
        _id_0A14(var_16);
      }

      _id_09F0(var_25);
      var_42 = int(var_33 * (1 - var_41));
      _id_0A24(floor(var_42 / 60), var_42 % 60);
      var_27--;

      if(var_27 <= 0) {
        level.player thread common_scripts\utility::play_sound_in_space("bullet_ap_metal", level.player getEye());
        var_27 = 3;
      }

      wait 0.05;
    }

    _id_0A24(0, 0);
    wait 1;

    for(;;) {
      var_43 = 1;

      if(var_14 > 10) {
        var_44 = var_14 % 10;

        if(var_14 - var_44 >= 10) {
          var_43 = 10;
        } else {
          var_43 = var_44;

        }
        if(var_14 < 20) {
          var_43 = var_44;
        }
      }

      var_14 = var_14 - var_43;

      if(var_14 < 0) {
        break;
      }

      var_45 = 1000;
      var_45 = var_45 * var_43;
      var_29 = int(var_45);

      if(getdvar("arcademode_full") == "1") {
        var_16 = var_16 + var_29;
        _id_0A14(var_16);
      }

      var_25 = var_25 + var_29;
      level.player thread common_scripts\utility::play_sound_in_space("mortar_explosion", level.player getEye());
      _id_09F0(int(var_25));
      _id_09D7(var_14);
      wait 0.6;
    }

    wait 1;

    if(getdvarint("arcademode_died") != 1 && level.gameskill >= 2) {
      var_29 = int(var_25);
      _id_0A20(var_25, var_16, var_29, &"SCRIPT_ZERO_DEATHS", "bullet_ap_bark", var_9, var_4);
      var_25 = var_25 + var_29;
      var_16 = var_16 + var_29;
    }
  } else {
    level._id_0A1E setpulsefx(0, 0, 1000);
    level._id_0A1D setpulsefx(0, 0, 1000);
    level._id_0A1C setpulsefx(0, 0, 1000);
    level._id_0A1B setpulsefx(0, 0, 1000);
    var_23 setpulsefx(0, 0, 1000);
    var_22 setpulsefx(0, 0, 1000);
    _id_09D7(0);
    wait 2;
  }

  var_46 = level._id_0A1F[level.gameskill];

  if(var_46 > 1) {
    if(var_46 == 1.5) {
      var_47 = &"SCRIPT_DIFFICULTY_BONUS_ONEANDAHALF";
    } else if(var_46 == 3) {
      var_47 = &"SCRIPT_DIFFICULTY_BONUS_THREE";
    } else {
      var_47 = &"SCRIPT_DIFFICULTY_BONUS_FOUR";

    }
    var_29 = int(ceil(var_25 * var_46) - var_25);
    _id_0A20(var_25, var_16, var_29, var_47, "bullet_ap_glass", var_9, var_4);
    var_25 = var_25 + var_29;
    var_16 = var_16 + var_29;
  }

  var_48 = 0;

  if(getdvar("arcademode_full") == "1") {
    var_49 = "s18";
    var_50 = getdvarint(var_49);

    if(var_16 > var_50) {
      var_51 = _id_09EF(var_16);
      var_52 = _id_0A2F(var_51);
      setdvar(var_49, var_52);
      var_53 = 0;

      if(!level._id_09B7) {
        var_53 = 1;

      }
      if(level.script == "airplane") {
        var_53 = 1;

      }
      if(var_53) {
        var_48 = 1;
      }
    }

    level.player uploadscore("LB_FULL", getdvarint(var_49));
  } else {
    var_54 = [];

  }
  if(var_48) {
    if(!level._id_09B7) {
      updategamerprofile();

    }
    wait 1;
    var_55 = _id_09F8("center", var_4, 0, var_9);
    var_55 settext(&"SCRIPT_NEW_HIGH_SCORE");
    var_55.alpha = 1;
    var_55 fadeovertime(0.05);
    var_55 setpulsefx(30, 3000, 1000);
    wait 3.5;
  }

  wait 2;
  var_11 setpulsefx(0, 0, 1000);
  wait 0.5;
  var_18 setpulsefx(0, 0, 1000);

  for(var_12 = 0; var_12 < level._id_09EB; var_12++) {
    var_19 = level._id_09EC[var_12];
    var_19 setpulsefx(0, 0, 1000);
  }

  if(getdvar("arcademode_full") == "1") {
    var_17 setpulsefx(0, 0, 1000);

    for(var_12 = 0; var_12 < level._id_09EB; var_12++) {
      var_19 = level._id_0A13[var_12];
      var_19 setpulsefx(0, 0, 1000);
    }
  }

  if(level._id_09B7) {
    wait 0.5;
    level._id_0A1E setpulsefx(0, 0, 1000);
    level._id_0A1D setpulsefx(0, 0, 1000);
    level._id_0A1C setpulsefx(0, 0, 1000);
    level._id_0A1B setpulsefx(0, 0, 1000);
    var_23 setpulsefx(0, 0, 1000);
    var_22 setpulsefx(0, 0, 1000);
  }

  wait 1;

  if(getdvar("arcademode_full") == "1") {
    logstring("ArcadeMode Score: " + var_25 + ", mission: " + level.script + ", gameskill: " + level.gameskill + ", total: " + var_16);
  } else {
    logstring("ArcadeMode Score: " + var_25 + ", mission: " + level.script + ", gameskill: " + level.gameskill);

  }
  setdvar("arcademode_combined_score", var_16);

  if(!level._id_09B7) {
    setdvar("ui_arcade_lost", 1);
    _id_0A10();
  } else {
    setdvar("ui_arcade_lost", 0);

  }
  common_scripts\utility::flag_set("arcademode_ending_complete");
}

_id_0A20(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = _id_09F8("center", var_6, 0, var_5);
  var_7 settext(var_3);
  var_7.alpha = 1;
  var_7 fadeovertime(0.05);
  wait 0.05;
  wait 1.0;
  var_8 = 0;
  var_9 = var_0 + var_2;
  var_10 = var_1 + var_2;

  for(;;) {
    var_11 = var_9 - var_0;
    var_2 = var_11 * 0.2 + 1;

    if(var_11 <= 15) {
      var_2 = 1;

    }
    var_2 = int(var_2);
    var_0 = var_0 + var_2;

    if(var_0 > var_9) {
      var_0 = var_9;

    }
    _id_09F0(var_0);

    if(getdvar("arcademode_full") == "1") {
      var_1 = var_1 + var_2;

      if(var_1 > var_10) {
        var_1 = var_10;

      }
      _id_0A14(var_1);
    }

    if(var_0 == var_9) {
      break;
    }

    var_8--;

    if(var_8 <= 0) {
      level.player thread common_scripts\utility::play_sound_in_space(var_4, level.player getEye());
      var_8 = 3;
    }

    wait 0.05;
  }

  wait 0.5;
  var_7 setpulsefx(0, 0, 1000);
  wait 1.0;
}

_id_0A21(var_0) {
  var_1 = newhudelem();
  var_1.foreground = 1;
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("black", 640, 480);
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.sort = level._id_09BB + 5;
  var_1.alpha = 0;

  if(var_0 > 0) {
    var_1 fadeovertime(var_0);

  }
  var_1.alpha = 1;
}

_id_0A22() {
  for(;;) {
    level.player enableinvulnerability();
    level.player.deathinvulnerabletime = 70000;
    level.player.ignoreme = 1;
    var_0 = getaispeciesarray("all", "all");
    common_scripts\utility::array_thread(var_0, maps\_utility::_id_0A23, 1);
    wait 0.05;
  }
}

_id_0A24(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_0 >= 10; var_0 = var_0 - 10) {
    var_2++;

  }
  while(var_1 >= 10) {
    var_3++;
    var_1 = var_1 - 10;
  }

  level._id_0A1E setvalue(var_1);
  level._id_0A1D setvalue(var_3);
  level._id_0A1C setvalue(var_0);
  level._id_0A1B setvalue(var_2);
}

_id_0A25(var_0, var_1, var_2) {
  var_0 = var_0 * var_2;
  var_3 = _id_09F8("center", 0.1, var_0, 90);
  var_3 settext(&"SCRIPT_CHECKPOINT");
  var_3 moveovertime(var_1);
  var_3.x = 0;
  wait(var_1);
  wait 0.5;
  var_3 moveovertime(var_1);
  var_3.x = var_0 * -1;
  wait(var_1);
  var_3 destroy();
}

_id_0A26(var_0) {
  for(var_1 = 0; var_1 < level._id_09AD.size; var_1++) {
    if(level._id_09AD[var_1] == var_0) {
      return var_1;
    }
  }

  return undefined;
}

_id_0A27() {
  level._id_09DB = [];
  level._id_09DC = [];
  level._id_09DB[level._id_09DB.size] = level._id_09AB;
  level._id_09DB[level._id_09DB.size] = (0.8, 0.8, 2);
  level._id_09DB[level._id_09DB.size] = (2, 0.8, 0);
  level._id_09DB[level._id_09DB.size] = (0.5, 2, 2);
  level._id_09DB[level._id_09DB.size] = (2, 0.5, 2);
  level._id_09DB[level._id_09DB.size] = (0.3, 0.3, 2);
  level._id_09DB[level._id_09DB.size] = (2, 2, 0.5);
  level._id_09DB[level._id_09DB.size] = (2, 2, 2);

  for(var_0 = 0; var_0 < level._id_09DB.size; var_0++) {
    level._id_09DC[var_0] = (level._id_09DB[var_0][0] * 0.35, level._id_09DB[var_0][1] * 0.35, level._id_09DB[var_0][2] * 0.35);

  }
  level._id_09DB[0] = level._id_09AC;
}

_id_0A28() {
  if(level._id_09B4 == 1) {
    return;
  }
  if(common_scripts\utility::flag("arcademode_complete")) {
    return;
  }
  var_0 = _id_09F8("right", 0.2, -10, -57);
  var_0 setpulsefx(5, 3000, 1000);
  var_0.fontscale = 2;

  if(level._id_09B4 >= 8) {
    level.player thread common_scripts\utility::play_sound_in_space("arcademode_kill_streak_won", level.player getEye());
    var_0 settext(&"SCRIPT_STREAK_COMPLETE");
  } else {
    level.player thread common_scripts\utility::play_sound_in_space("arcademode_kill_streak_lost", level.player getEye());
    var_0 settext(&"SCRIPT_STREAK_BONUS_LOST");
  }

  wait 5;
  var_0 destroy();
}

_id_0A29() {
  if(isDefined(level._id_09E2)) {
    level._id_09E2 destroy();
    level._id_09E2 = undefined;
    level._id_09E3 destroy();
  }

  level notify("arcademode_stop_kill_streak_art");

  for(var_0 = 0; var_0 < level._id_09AF.size; var_0++) {
    level._id_09AF[var_0] destroy();

  }
  level._id_09AF = [];
}

_id_0A2A() {
  level._id_09B3 = 1;
  thread _id_0A28();
  level notify("arcademode_stop_kill_streak");
  _id_0A29();
  common_scripts\utility::flag_clear("arcadeMode_multiplier_maxed");
  level._id_09DA = level._id_09B5;
  level._id_09B4 = 1;
}

_id_0A2B() {
  var_0 = newhudelem();
  var_0.alignx = "right";
  var_0.aligny = "top";
  var_0.horzalign = "right";
  var_0.vertalign = "top";
  var_0 thread _id_0A2E();
  var_0.x = 0;
  var_0.y = 126;
  var_0.font = "objective";
  var_0.fontscale = 0.1;
  var_0.archived = 0;
  var_0.foreground = 1;
  var_0.color = level._id_09DB[level._id_09B4 - 1];
  var_0.glowcolor = level._id_09DC[level._id_09B4 - 1];
  var_0.sort = level._id_09BB;
  var_0.label = &"SCRIPT_X";
  var_0 setvalue(level._id_09B4);
  var_0 changefontscaleovertime(0.5);
  var_0.fontscale = 3;
  var_0.alpha = 0;
  var_0 fadeovertime(0.5);
  var_0.alpha = 1.0;
  return var_0;
}

_id_0A2C() {
  for(var_0 = 0; var_0 < 40; var_0++) {
    var_1 = _id_0A2B();
    var_1 thread _id_0A2D();
  }

  level endon("arcademode_new_kill_streak");
  var_2 = _id_0A2B();
  level._id_09E1 = var_2;
  level waittill("arcademode_stop_kill_streak");
  var_2 setpulsefx(0, 0, 1000);
  wait 1;
  var_2 destroy();
  level._id_09E1 = undefined;
}

_id_0A2D() {
  level endon("arcademode_new_kill_streak");
  wait 0.05;
  var_0 = 500;
  self moveovertime(2);
  self.x = self.x + randomintrange(var_0 * -1, var_0);
  self.y = self.y + randomintrange(var_0 * -1, var_0);
  wait 0.5;
  self fadeovertime(1);
  self.alpha = 0;
  wait 1;
  self destroy();
}

_id_0A2E() {
  self endon("death");
  level waittill("arcademode_new_kill_streak");
  self destroy();
}

_id_0A2F(var_0) {
  var_1 = "";

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_0[var_2] + var_1;

  }
  return var_1;
}