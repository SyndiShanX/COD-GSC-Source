/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1285.gsc
*********************************************/

func_00D5() {
  if(!isDefined(level.var_54D0)) {
    maps\mp\_utility::func_3FA3("finished_intro_vignette_allies", 1);
    maps\mp\_utility::func_3FA3("finished_intro_vignette_axis", 1);
    return;
  }

  maps\mp\_utility::func_3FA3("started_vignettes", 0);
  maps\mp\_utility::func_3FA3("finished_intro_vignette_allies", 0);
  maps\mp\_utility::func_3FA3("finished_intro_vignette_axis", 0);
  level.disableprespawnspectator = 1;
  level.var_A6BC = ::func_A6BA;
  level.var_6BA7 = ::func_6BA7;
  level.onspawnspectatorgamemode = ::onspawnspectatorgamemode;
  level.var_495C = ::func_75E9;
  level.var_75E7 = ::func_75E6;
  level.var_4526 = ::func_4526;
  level.var_36C1 = ::func_36C1;
  animscripts\notetracks_common::func_7BF0();
  level thread onintrovignettescomplete();
}

func_5310() {
  if(!isDefined(level.var_54D0)) {
    level.var_54D0 = [];
    level.var_54D0["allies"] = spawnStruct();
    level.var_54D0["axis"] = spawnStruct();
  }
}

func_5325() {
  if(!isDefined(level.var_6C86)) {
    level.var_6C86 = [];
    level.var_6C86["allies"] = spawnStruct();
    level.var_6C86["axis"] = spawnStruct();
  }
}

func_A6BA() {
  maps\mp\_utility::func_3FA4("started_vignettes");
  level thread func_54D0("allies");
  level thread func_54D0("axis");
}

func_6BA7() {
  thread maps\mp\gametypes\raid::func_6BA7();
  thread func_6BA8();
}

onintrovignettescomplete() {
  maps\mp\_utility::func_3FA5("finished_intro_vignette_allies");
  maps\mp\_utility::func_3FA5("finished_intro_vignette_axis");
  level.disableprespawnspectator = 0;
}

func_6BA8() {
  waittillframeend;
  if(getdvarint("scr_raid_introvignette", 1) == 0) {
    return;
  }

  if(!function_01EF(self)) {
    thread dirt_concrete_fx("allies");
    thread dirt_concrete_fx("axis");
  }
}

onspawnspectatorgamemode() {
  thread introvignettespectatorthink();
}

func_54E8() {
  if(!isPlayer(self)) {
    return;
  }

  var_00 = newclienthudelem(self);
  var_00 setshader("black", 640, 480);
  var_00.ignoreme = 1;
  var_00.var_C6 = "fullscreen";
  var_00.var_1CA = "fullscreen";
  var_00.var_18 = 1;
  var_00.var_A0 = 1;
  self.var_54EC = var_00;
  maps\mp\_audio_submixes::func_8A9D("mp_war_black", 0.1, 1);
}

func_54EF() {
  if(isDefined(self.var_54EC)) {
    self.var_54EC destroy();
    maps\mp\_audio_submixes::func_8A9F("mp_war_black", 0);
  }
}

func_54EB(param_00, param_01) {
  if(isDefined(self.var_54EC)) {
    if(param_00 > 0) {
      wait(param_00);
    }

    self.var_54EC fadeovertime(param_01);
    self.var_54EC.var_18 = 0;
    maps\mp\_audio_submixes::func_8A9E("mp_war_black", 0, param_01);
    wait(param_01);
    if(isDefined(self.var_54EC)) {
      self.var_54EC destroy();
    }

    maps\mp\_audio_submixes::func_8A9F("mp_war_black", 0);
  }
}

func_54D0(param_00) {
  if(!isDefined(level.var_54D0) || !isDefined(level.var_54D0[param_00])) {
    return;
  }

  if(getdvarint("scr_raid_introvignette", 1) == 0) {
    maps\mp\_utility::func_3FA4("finished_intro_vignette_" + param_00);
    return;
  }

  var_01 = level.var_54D0[param_00].var_8097;
  var_02 = level.var_54D0[param_00].var_8F53;
  if(!isDefined(var_02)) {
    return;
  }

  var_03 = var_02.var_116;
  if(!isDefined(var_03)) {
    var_03 = (0, 0, 0);
  }

  var_04 = var_02.var_1D;
  if(!isDefined(var_04)) {
    var_04 = (0, 0, 0);
  }

  var_05 = lib_050D::func_46A0(game[level.var_54D0[param_00].var_8F2]);
  var_05 = common_scripts\utility::func_F92(var_05);
  var_06 = level.var_54D0[param_00].var_73B4;
  var_07 = [];
  for(var_08 = 0; var_08 < 18; var_08++) {
    var_09 = spawnStruct();
    if(var_08 < 6) {
      var_09.var_13B3 = spawn("script_model", var_03);
      var_09.var_13B3 setModel("usa_hubd_org1");
      if(isDefined(level.var_54D0[param_00].bot_costume)) {
        var_09.var_13B3 setcostumemodels(level.var_54D0[param_00].bot_costume, param_00);
      } else {
        var_0A = function_0283();
        var_09.var_13B3 setcostumemodels(var_0A, param_00);
      }

      var_09.var_13B3 animscripts\notetracks_common::give_player_xp(var_06[var_08], var_03, var_04, "avatar");
      if(isDefined(level.var_54D0[param_00].var_13B7)) {
        var_09.var_13B3 thread[[level.var_54D0[param_00].var_13B7]](var_08, "avatar");
      }

      if(isDefined(level.var_54D0[param_00].basecostume) && isDefined(level.var_54D0[param_00].forceavatars) && common_scripts\utility::func_562E(level.var_54D0[param_00].forceavatars[var_08])) {
        var_09.var_13B3 setcostumemodels(level.var_54D0["axis"].basecostume, param_00);
        if(!common_scripts\utility::func_562E(level.var_54D0[param_00].forceavatarsweaponless)) {
          var_0B = "m1garand_mp";
          if(param_00 == "axis") {
            var_0B = "mp40_mp";
          }

          var_0C = param_00;
          if(common_scripts\utility::func_562E(level.var_9565) && game["switchedsides"]) {
            var_0C = maps\mp\_utility::func_45DE(param_00);
          }

          var_0D = spawn("weapon_" + var_0B, (0, 0, 0), 1);
          var_0D thread lib_0502::func_8C21(var_0C, 0);
          var_0D linkto(var_09.var_13B3, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
          var_0D thread lib_0502::func_2FA6();
          var_09.var_7490 = var_0D;
        }
      } else if(common_scripts\utility::func_562E(level.var_54D0[param_00].showfullteam)) {} else {
        var_09.var_13B3 method_805C();
      }
    }

    var_0E = var_08 % var_05.size;
    var_09.var_907B = var_05[var_0E].var_116;
    var_09.var_9029 = var_05[var_0E].var_1D;
    var_09.var_721C = undefined;
    var_09.var_13AF = 1;
    var_07[var_08] = var_09;
  }

  level.var_54D0[param_00].var_116 = var_03;
  level.var_54D0[param_00].var_1D = var_04;
  level.var_54D0[param_00].var_EC2 = var_01;
  level.var_54D0[param_00].var_9309 = gettime();
  level.var_54D0[param_00].var_36ED = gettime() + var_01 * 1000;
  level.var_54D0[param_00].var_8CA7 = var_07;
  level.var_54D0[param_00].var_8BE = 1;
  level thread func_54E6(param_00);
  level thread func_54F3(param_00);
  func_09AE("m1garand_mp", 1);
  foreach(var_10 in level.var_744A) {
    if(maps\mp\_utility::func_57A0(var_10)) {
      var_10 thread dirt_concrete_fx(param_00);
    }
  }

  var_12 = "ui_war_vignette_active_" + param_00;
  setomnvar(var_12, 1);
  if(isDefined(level.var_54D0[param_00].var_92D5)) {
    level thread[[level.var_54D0[param_00].var_92D5]]();
  }

  if(common_scripts\utility::func_562E(level.var_54D0[param_00].var_6F27)) {
    setomnvar("ui_war_pause_timer", 1);
    maps\mp\gametypes\_gamelogic::func_6F27();
  }

  wait(var_01);
  foreach(var_10 in level.var_744A) {
    if(maps\mp\_utility::func_57A0(var_10)) {
      var_10 thread dirt_fx(param_00);
    }
  }

  if(isDefined(level.var_54D0[param_00].basecostume)) {
    foreach(var_16 in var_07) {
      if(isDefined(var_16.var_721C)) {
        continue;
      }

      if(isDefined(var_16.var_7490)) {
        var_16.var_7490 method_8511();
      }

      if(isDefined(var_16.var_13B3)) {
        var_16.var_13B3 method_8511();
      }
    }
  }

  var_18 = level.var_54D0[param_00].var_1F02;
  var_19 = level.var_54D0[param_00].var_6F27;
  var_1A = level.var_54D0[param_00].var_765B;
  var_1B = level.var_54D0[param_00].var_2381;
  level.var_54D0[param_00].var_8BE = 0;
  maps\mp\_utility::func_3FA4("finished_intro_vignette_" + param_00);
  func_7CDC("m1garand_mp");
  if(common_scripts\utility::func_562E(var_19)) {
    setomnvar("ui_war_pause_timer", 0);
    maps\mp\gametypes\_gamelogic::func_7DFC();
  }

  if(isDefined(var_1A)) {
    level thread[[var_1A]]();
  }

  introvignette_fov_precleanup(param_00);
  foreach(var_16 in var_07) {
    if(isDefined(var_16.var_7490)) {
      var_16.var_7490 thread lib_0502::func_3669();
      var_16.var_7490 delete();
    }

    if(isDefined(var_16.var_13B3)) {
      var_16.var_13B3 thread introvignette_delayeddeleteavatar();
    }
  }

  if(isDefined(var_18)) {
    var_18 delete();
  }

  if(isDefined(var_1B)) {
    level thread[[var_1B]]();
  }

  setomnvar(var_12, 0);
  foreach(var_1F in level.var_79AE.var_8DB) {
    var_1F.var_A4BF[param_00] = gettime();
  }
}

introvignette_delayeddeleteavatar() {
  self setModel("tag_origin");
  wait 0.05;
  self delete();
}

introvignette_fov_precleanup(param_00) {
  if(game["switchedsides"]) {
    param_00 = maps\mp\_utility::func_45DE(param_00);
  }

  var_01 = lib_0502::func_4627(param_00);
  foreach(var_03 in var_01) {
    var_03 method_8036(1, 0.5);
  }
}

introvignetteactiveforplayer(param_00) {
  foreach(var_02 in level.var_54D0) {
    if(game[var_02.var_8F2] == param_00.var_1A7) {
      return common_scripts\utility::func_562E(var_02.var_8BE);
    }
  }
}

dirt_concrete_fx(param_00) {
  self endon("disconnect");
  if(!isDefined(level.var_54D0) || !isDefined(level.var_54D0[param_00])) {
    return;
  }

  if(self.var_1A7 != game[level.var_54D0[param_00].var_8F2]) {
    return;
  }

  if(isDefined(self.var_54EC)) {
    return;
  }

  if(maps\mp\_utility::func_3FA0("finished_intro_vignette_" + param_00)) {
    return;
  }

  if(level.var_7691 > 0) {
    func_54E8();
  }

  var_01 = self.var_1A7;
  if(!maps\mp\_utility::func_3FA0("prematch_waitforplayers_done")) {
    maps\mp\_utility::func_3FA5("prematch_waitforplayers_done");
  }

  if(var_01 != self.var_1A7) {
    param_00 = maps\mp\_utility::func_45DE(param_00);
  }

  while(!isDefined(level.var_54D0) || !isDefined(level.var_54D0[param_00]) || !common_scripts\utility::func_562E(level.var_54D0[param_00].var_8BE)) {
    wait 0.05;
  }

  if(maps\mp\_utility::func_3FA0("finished_intro_vignette_" + param_00)) {
    return;
  }

  if(isDefined(self.var_54F0)) {
    return;
  }

  func_54E3(param_00);
}

func_54E3(param_00) {
  for(var_01 = 0; var_01 < 18; var_01++) {
    if(level.var_54D0[param_00].var_8CA7[var_01].var_13AF) {
      break;
    }
  }

  if(isDefined(level.var_54D0[param_00].var_8CA7[var_01])) {
    level.var_54D0[param_00].var_8CA7[var_01].var_13AF = 0;
    level.var_54D0[param_00].var_8CA7[var_01].var_721C = self;
    self.var_54F0 = var_01;
  }

  if(var_01 < 0 || var_01 >= 6) {
    if(isPlayer(self)) {
      thread func_54E2(param_00, var_01);
    }

    return;
  }

  var_03 = self.var_1A7;
  if(common_scripts\utility::func_562E(level.var_9565) && game["switchedsides"]) {
    var_03 = maps\mp\_utility::func_45DE(self.var_1A7);
  }

  var_04 = game[level.var_54D0[param_00].var_8F2];
  level.var_54D0[param_00].var_8CA7[var_01].var_13B3 setcostumemodels(self.var_267E, var_03);
  level.var_54D0[param_00].var_8CA7[var_01].var_13B3 thread lib_0502::func_8C21(var_04, 0);
  level.var_54D0[param_00].var_8CA7[var_01].var_13B3 setclientowner(self);
  if(isDefined(level.var_54D0[param_00].setthreatdetectedfunc)) {
    level.var_54D0[param_00].var_8CA7[var_01].var_13B3[[level.var_54D0[param_00].setthreatdetectedfunc]]();
  }

  if(!common_scripts\utility::func_562E(level.var_54D0[param_00].forceavatarsweaponless) && !common_scripts\utility::func_562E(level.var_54D0[param_00].var_8CA7[var_01].forceweaponless)) {
    var_05 = func_470D("m1garand_mp");
    if(var_05 != "none") {
      var_06 = spawn("weapon_" + var_05, (0, 0, 0), 1);
      var_06 thread lib_0502::func_8C21(var_04, 0);
      var_06 linkto(level.var_54D0[param_00].var_8CA7[var_01].var_13B3, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      var_06 thread lib_0502::func_2FA6();
      if(isDefined(level.var_54D0[param_00].var_8CA7[var_01].var_7490)) {
        level.var_54D0[param_00].var_8CA7[var_01].var_7490 delete();
      }

      level.var_54D0[param_00].var_8CA7[var_01].var_7490 = var_06;
    }
  }

  thread func_54F1(param_00);
  thread func_54F2(param_00);
  var_07 = level.var_54D0[param_00].var_1F02;
  var_08 = "tag_player";
  var_09 = var_07 gettagorigin(var_08);
  var_0A = var_07 gettagangles(var_08);
  self setangles(var_0A);
  self method_81E2(var_07, var_08);
  if(isDefined(level.var_54D0[param_00].var_1F04)) {
    self thread[[level.var_54D0[param_00].var_1F04]](param_00);
  }

  if(isDefined(level.var_54D0[param_00].var_73E6)) {
    self thread[[level.var_54D0[param_00].var_73E6]](var_01);
  }

  self method_8003();
  thread func_54EB(0, 3);
  thread func_54E9(param_00);
  var_0B = level.var_54D0[param_00].var_36ED - gettime() / 1000;
  thread maps\mp\gametypes\raid::func_9026(var_0B + 3);
}

func_54E2(param_00, param_01) {
  thread func_54F2(param_00);
  var_02 = level.var_54D0[param_00].var_1F02;
  var_03 = "tag_player";
  var_04 = var_02 gettagorigin(var_03);
  var_05 = var_02 gettagangles(var_03);
  self setangles(var_05);
  self method_81E2(var_02, var_03);
  if(isDefined(level.var_54D0[param_00].var_1F04)) {
    self thread[[level.var_54D0[param_00].var_1F04]](param_00);
  }

  if(isDefined(level.var_54D0[param_00].var_73E6)) {
    self thread[[level.var_54D0[param_00].var_73E6]](param_01);
  }

  self method_8003();
  thread func_54EB(0, 3);
  thread func_54E9(param_00);
  var_06 = level.var_54D0[param_00].var_36ED - gettime() / 1000;
  thread maps\mp\gametypes\raid::func_9026(var_06 + 3);
}

func_54E9(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self method_8322();
  self allowmovement(0);
  self method_812C(0);
  for(;;) {
    var_01 = level common_scripts\utility::func_A715("prematch_done", "finished_intro_vignette_" + param_00);
    if(isDefined(var_01) && var_01 == "finished_intro_vignette_" + param_00) {
      break;
    }

    self method_8322();
    self allowmovement(0);
    self method_812C(0);
  }

  self method_8323();
  self allowmovement(1);
  self method_812C(1);
}

func_9539(param_00, param_01, param_02, param_03) {
  self notify("wait_raidvig_costume_swap");
  self endon("wait_raidvig_costume_swap");
  self endon("death");
  if(isDefined(self.var_98D0)) {
    self.var_98D0 delete();
  }

  self.var_98D0 = spawn("script_model", (0, 0, 0));
  self.var_98D0 method_805C();
  self.var_98D0 setcostumemodels(param_00, param_01);
  while(!self.var_98D0 method_86A6()) {
    wait 0.05;
  }

  self.var_98D0 delete();
  self.var_98D0 = undefined;
  self setcostumemodels(param_00, param_01);
  if(isDefined(param_02)) {
    param_02 method_848E(param_03);
  }
}

func_54F3(param_00) {
  level endon("finished_intro_vignette_" + param_00);
  level waittill("game_ended");
  foreach(var_02 in level.var_744A) {
    var_02 notify("game_ended");
  }
}

func_54F1(param_00) {
  level endon("finished_intro_vignette_" + param_00);
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  var_01 = self.var_54F0;
  var_02 = param_00;
  for(;;) {
    self waittill("changed_class");
    var_03 = func_470D("m1garand_mp");
    var_04 = level.var_54D0[param_00].var_8CA7[var_01].var_7490;
    level.var_54D0[param_00].var_8CA7[var_01].var_13B3 thread func_9539(self.var_267E, var_02, var_04, var_03);
  }
}

introvignettespectatorthink() {
  self endon("joined_team");
  self endon("game_ended");
  self endon("disconnect");
  if(isDefined(level.spectatorspawnedforintrovignettesfunc)) {
    self[[level.spectatorspawnedforintrovignettesfunc]]();
  }

  wait 0.05;
  if(level.var_7691 == 0) {
    return;
  }

  maps\mp\_utility::func_3FA5("started_vignettes");
  var_00 = undefined;
  for(;;) {
    var_01 = self getspectatingplayer();
    if(isDefined(var_00) && !isDefined(var_01)) {
      self method_84B7(22, 29.301);
      self method_84B5();
    }

    if(maps\mp\_utility::func_3FA0("finished_intro_vignette_allies") && maps\mp\_utility::func_3FA0("finished_intro_vignette_axis")) {
      return;
    }

    var_00 = var_01;
    wait 0.05;
  }
}

func_54F2(param_00) {
  level endon("finished_intro_vignette_" + param_00);
  var_01 = self.var_54F0;
  var_02 = common_scripts\utility::func_A716("disconnect", "joined_team", "joined_spectators", "game_ended");
  if(isDefined(var_01)) {
    if(var_01 < 6) {
      if(isDefined(level.var_54D0[param_00].var_8CA7[var_01].var_7490)) {
        level.var_54D0[param_00].var_8CA7[var_01].var_7490 thread lib_0502::func_3669();
        level.var_54D0[param_00].var_8CA7[var_01].var_7490 delete();
      }

      level.var_54D0[param_00].var_8CA7[var_01].var_13B3 lib_0502::func_8C20();
      level.var_54D0[param_00].var_8CA7[var_01].var_13B3 method_805C();
    }

    level.var_54D0[param_00].var_8CA7[var_01].var_13AF = 1;
    level.var_54D0[param_00].var_8CA7[var_01].var_721C = undefined;
  }

  if(isDefined(self)) {
    self.var_54F0 = undefined;
    self unlink();
    self method_81E3();
    self method_84B7(22, 29.301);
    self method_84B5();
    self method_8004();
    self method_8323();
    self allowmovement(1);
    self method_812C(1);
    func_54EF();
    var_03 = maps\mp\gametypes\_playerlogic::func_4651();
    self setspectatedefaults(var_03.var_116, var_03.var_1D);
    self spawn_0(var_03.var_116, var_03.var_1D);
    maps\mp\_utility::func_A165("spectator");
    if(var_02 != "joined_spectators") {
      self.var_3A61 = 1;
    }

    self method_8036(1, 0);
  }
}

cam_shot_wait_func() {
  self endon("end_shot");
  self waittillmatch("end", "camRig");
}

func_54E6(param_00) {
  level endon("game_ended");
  level endon("finished_intro_vignette_" + param_00);
  var_01 = level.var_54D0[param_00].var_1F03;
  var_02 = level.var_54D0[param_00].var_1F05;
  var_03 = level.var_54D0[param_00].var_116;
  var_04 = level.var_54D0[param_00].var_1D;
  for(var_05 = 0; var_05 < var_01.size; var_05++) {
    var_06 = var_01[var_05];
    var_07 = var_02[var_05];
    var_08 = spawn("script_model", var_03);
    var_08 setModel("tag_player");
    var_09 = game[level.var_54D0[param_00].var_8F2];
    var_08.camriganim = var_06;
    var_08 animscripts\notetracks_common::give_player_xp(var_06, var_03, var_04, "camRig", var_09);
    var_08 thread func_54E7(param_00, "camRig");
    level.var_54D0[param_00].var_1F02 = var_08;
    level.var_54D0[param_00].var_1F04 = var_07;
    level.var_54D0[param_00].var_1F07 = gettime();
    var_0A = level.var_54D0[param_00].var_1F02;
    var_0B = "tag_player";
    var_0C = var_0A gettagorigin(var_0B);
    var_0D = var_0A gettagangles(var_0B);
    foreach(var_0F in level.var_744A) {
      if(isDefined(var_0F) && isDefined(var_0F.var_1A7) && var_0F.var_1A7 == game[level.var_54D0[param_00].var_8F2] && isDefined(var_0F.var_54F0)) {
        var_0F method_808C();
        var_0F setangles(var_0D);
        var_0F method_81E2(var_0A, var_0B);
        if(isDefined(var_07)) {
          var_0F thread[[var_07]](param_00);
        }
      }
    }

    var_08 cam_shot_wait_func();
    level notify("next_shot_anim_" + param_00);
    var_08 common_scripts\utility::func_2CBE(0.05, ::delete);
  }
}

func_54E7(param_00, param_01) {
  self endon("death");
  var_02 = game[level.var_54D0[param_00].var_8F2];
  for(;;) {
    self waittill(param_01, var_03);
    switch (var_03) {
      case "cam_fade_start":
        var_04 = lib_0502::func_4627(var_02);
        foreach(var_06 in var_04) {
          var_06 thread func_54EA(param_00);
        }
        break;

      case "end_shot":
        self notify("end_shot");
        break;
    }
  }
}

func_54EA(param_00) {
  var_01 = level.var_54D0[param_00].var_36ED - gettime() / 1000;
  if(var_01 <= 0) {
    return;
  }

  var_02 = newclienthudelem(self);
  var_02 setshader("black", 640, 480);
  var_02.ignoreme = 1;
  var_02.var_C6 = "fullscreen";
  var_02.var_1CA = "fullscreen";
  var_02.var_18 = 0;
  var_02.var_A0 = 1;
  var_02 fadeovertime(var_01);
  var_02.var_18 = 1;
  var_02 endon("death");
  maps\mp\_utility::func_3FA5("finished_intro_vignette_" + param_00);
  var_03 = 1;
  if(!isDefined(var_02)) {
    return;
  }

  var_02 fadeovertime(var_03);
  var_02.var_18 = 0;
  wait(var_03);
  if(!isDefined(var_02)) {
    return;
  }

  var_02 destroy();
}

dirt_fx(param_00) {
  if(self.var_1A7 != game[level.var_54D0[param_00].var_8F2]) {
    return;
  }

  var_01 = self.var_54F0;
  if(isDefined(var_01)) {
    if(var_01 < 6) {
      var_02 = level.var_54D0[param_00].var_8CA7[var_01].var_13B3;
      var_03 = level.var_54D0[param_00].var_8CA7[var_01].var_7490;
      var_02 lib_0502::func_8C20();
      var_02 method_8511();
      if(isDefined(var_03)) {
        var_03 lib_0502::func_8C20();
        var_03 method_8511();
      }
    }

    self.spawnpos_postraidvignette = level.var_54D0[param_00].var_8CA7[var_01].var_907B;
    self setorigin(level.var_54D0[param_00].var_8CA7[var_01].var_907B, 1);
    self setangles(level.var_54D0[param_00].var_8CA7[var_01].var_9029);
  }

  self unlink();
  self method_81E3();
  self method_84B7(22, 29.301);
  self method_84B5();
  self method_8004();
  self method_8323();
  self allowmovement(1);
  self method_812C(1);
  self.var_54F0 = undefined;
}

func_3187(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(param_00.size == 0) {} else {}

  var_06 = spawnStruct();
  var_06.var_3EF7 = param_01;
  var_06.var_3DA3 = param_02;
  var_06.var_3DA5 = param_03;
  var_06.var_F19 = param_04;
  var_06.var_99FA = param_05;
  param_00[param_00.size] = var_06;
  return param_00;
}

func_318A(param_00, param_01) {
  for(var_02 = param_00.size - 1; var_02 >= 0; var_02--) {
    if(param_01 >= param_00[var_02].var_99FA) {
      return var_02;
    }
  }

  return 0;
}

func_3188(param_00, param_01) {
  var_02 = undefined;
  var_03 = undefined;
  if(isDefined(level.var_1F02) && isDefined(level.var_1F07)) {
    var_02 = level.var_1F02;
    var_03 = level.var_1F07;
  } else {
    var_02 = level.var_54D0[param_00].var_1F02;
    var_03 = level.var_54D0[param_00].var_1F07;
  }

  var_02 endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  var_04 = gettime() - var_03 / 1000;
  var_05 = func_318A(param_01, var_04);
  for(var_06 = var_05; var_06 < param_01.size; var_06++) {
    var_07 = param_01[var_06].var_3EF7;
    var_08 = param_01[var_06].var_3DA3;
    var_09 = param_01[var_06].var_3DA5;
    var_0A = param_01[var_06].var_F19;
    self method_84B4();
    self method_84B7(var_07, var_08, var_09, var_0A);
    if(var_06 < param_01.size - 1) {
      var_0B = param_01[var_06 + 1].var_99FA;
      var_0C = var_0B - var_04;
      wait(var_0C);
      var_04 = gettime() - var_03 / 1000;
    }
  }
}

fovnotetracksaddtolistall(param_00, param_01) {
  if(function_01EF(self)) {
    return;
  }

  var_02 = [];
  if(isstring(param_00)) {
    var_04 = getanimationfromname(#animtree, param_00);
    if(!isDefined(var_04)) {
      return;
    }
  } else {
    var_04 = param_01;
  }

  var_05 = getanimlength(var_04);
  var_03 = getnotetracks(var_04, "fov", 1);
  foreach(var_07 in var_03) {
    var_08 = var_07["name"];
    var_09 = var_07["time"] * var_05;
    var_02 = fovnotetracksaddtolist(var_02, var_08, var_09);
  }

  thread fovnotetrackscamfunccommon(param_01, var_02);
}

fovnotetracksaddtolist(param_00, param_01, param_02) {
  if(param_00.size == 0) {} else {}

  var_03 = spawnStruct();
  var_03.fovnotetrack = param_01;
  var_03.var_99FA = param_02;
  param_00[param_00.size] = var_03;
  return param_00;
}

fovgetcurindexfortimeoffset(param_00, param_01) {
  for(var_02 = param_00.size - 1; var_02 >= 0; var_02--) {
    if(param_01 >= param_00[var_02].var_99FA) {
      return var_02;
    }
  }

  return 0;
}

fovnotetrackscamfunccommon(param_00, param_01) {
  if(function_01EF(self)) {
    return;
  }

  var_02 = undefined;
  var_03 = undefined;
  if(isDefined(level.var_1F02) && isDefined(level.var_1F07)) {
    var_02 = level.var_1F02;
    var_03 = level.var_1F07;
  } else {
    var_02 = level.var_54D0[param_00].var_1F02;
    var_03 = level.var_54D0[param_00].var_1F07;
  }

  var_02 endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  var_04 = gettime() - var_03 / 1000;
  var_05 = fovgetcurindexfortimeoffset(param_01, var_04);
  for(var_06 = var_05; var_06 < param_01.size; var_06++) {
    var_07 = param_01[var_06].fovnotetrack;
    thread animscripts\notetracks_common::func_67B2(var_07, "dummy", [self]);
    if(var_06 < param_01.size - 1) {
      var_08 = param_01[var_06 + 1].var_99FA;
      var_09 = var_08 - var_04;
      wait(var_09);
      var_04 = gettime() - var_03 / 1000;
    }
  }
}

func_75E9() {
  func_75E8();
}

func_75E6() {
  func_75E8();
}

func_4526() {
  if(isDefined(level.var_541F)) {
    return level.var_541F;
  }

  var_00 = getEntArray("mp_global_intermission", "classname");
  return var_00[0];
}

func_36C1() {
  var_00 = ["mp40_mp", "m1garand_mp"];
  foreach(var_02 in level.var_744A) {
    var_02 method_8533(1);
    var_03 = var_00;
    var_04 = ["custom1", "custom2", "custom3", "custom4", "custom5", "class0", "class1", "class2", "class3", "class4"];
    foreach(var_06 in var_04) {
      var_07 = var_02 maps\mp\gametypes\_class::func_455F(var_02.var_1A7, var_06, undefined, undefined, 1);
      var_03[var_03.size] = var_07.var_76F8;
    }

    var_02 method_8512(var_03);
  }
}

func_75E8() {
  var_00 = lib_0502::func_797A();
  if(!isDefined(var_00) || var_00 == "none" || var_00 == "" || var_00 == "tie") {
    return;
  }

  level thread func_7FE2(var_00);
  maps\mp\gametypes\_hostmigration::func_A6F5(7);
  func_1E25();
}

func_1E25() {
  if(isDefined(level.var_1F02)) {
    var_00 = level.var_1F08;
    var_01 = spawnStruct();
    var_01.var_116 = level.var_1F02 gettagorigin(var_00);
    var_01.var_1D = level.var_1F02 gettagangles(var_00);
    level.var_541F = var_01;
  }
}

func_7FE2(param_00, param_01) {
  level endon("game_ended");
  level notify("game_end_vignette");
  if(!isDefined(level.var_6C86) || !isDefined(level.var_6C86[param_00])) {
    return;
  }

  var_02 = level.var_6C86[param_00].var_8097;
  var_03 = level.var_6C86[param_00].var_8F53;
  if(!isDefined(var_03)) {
    return;
  }

  var_04 = var_03.var_116;
  if(!isDefined(var_04)) {
    var_04 = (0, 0, 0);
  }

  var_05 = var_03.var_1D;
  if(!isDefined(var_05)) {
    var_05 = (0, 0, 0);
  }

  level.var_6C86[param_00].var_116 = var_04;
  level.var_6C86[param_00].var_1D = var_05;
  level.var_6C86[param_00].var_EC2 = var_02;
  level.var_6C86[param_00].var_9309 = gettime();
  level.var_6C86[param_00].var_36ED = gettime() + var_02 * 1000;
  level.var_6C86[param_00].var_8BE = 1;
  level thread func_6C96(param_00);
  common_scripts\utility::func_F71(level.var_744A, ::method_8003);
  if(isDefined(level.var_6C86[param_00].var_92D5)) {
    level thread[[level.var_6C86[param_00].var_92D5]]();
  }

  func_2382(param_00, param_01);
  wait(var_02);
  if(isDefined(level.var_6C86[param_00].prewaitcleanupfunc)) {
    level thread[[level.var_6C86[param_00].prewaitcleanupfunc]]();
  }

  if(!isDefined(param_01) || !param_01) {
    wait(30);
  }

  level notify("game_end_vignette_done");
  var_06 = level.var_6C86[param_00].var_2381;
  level.var_6C86[param_00].var_8BE = 0;
  if(isDefined(var_06)) {
    level thread[[var_06]]();
  }

  foreach(var_08 in level.var_744A) {
    var_08 method_8004();
    var_08 method_81E3();
    var_08 method_84B7(22, 29.301);
    var_08 method_84B5();
  }

  level notify("game_end_vignette_done");
}

spectatorspawnedforintrovignettes() {
  self method_8036(1, 0);
}

func_6C96(param_00) {
  level endon("game_end_vignette_done");
  var_01 = level.var_6C86[param_00].var_1F03;
  var_02 = level.var_6C86[param_00].var_1F05;
  var_03 = level.var_6C86[param_00].var_116;
  var_04 = level.var_6C86[param_00].var_1D;
  var_05 = level.var_6C86[param_00].var_1F06;
  var_06 = level.var_6C86[param_00].var_1F08;
  if(!isDefined(var_05)) {
    var_05 = "tag_player";
  }

  if(!isDefined(var_06)) {
    var_06 = "tag_player";
  }

  for(var_07 = 0; var_07 < var_01.size; var_07++) {
    var_08 = var_01[var_07];
    var_09 = var_02[var_07];
    var_0A = spawn("script_model", var_03);
    var_0A setModel(var_05);
    var_0B = "all";
    var_0A animscripts\notetracks_common::give_player_xp(var_08, var_03, var_04, "camRig", var_0B);
    level notify("camRigCut", common_scripts\utility::func_9AAD(var_07 + 1));
    level.var_1F02 = var_0A;
    level.var_1F08 = var_06;
    level.var_1F07 = gettime();
    var_0C = var_0A;
    var_0D = var_06;
    var_0E = var_0C gettagorigin(var_0D);
    var_0F = var_0C gettagangles(var_0D);
    foreach(var_11 in level.var_744A) {
      var_11 method_81E2(var_0C, var_0D);
      if(isDefined(var_09)) {
        var_11 thread[[var_09]](param_00);
      }
    }

    var_0A waittillmatch("end", "camRig");
    var_0A common_scripts\utility::func_2CBE(0.05, ::delete);
  }
}

func_2382(param_00, param_01) {
  level thread func_5A55(param_00);
  function_0021();
  var_02 = getEntArray("dropped_weapon", "targetname");
  common_scripts\utility::func_F71(var_02, ::delete);
  if(!common_scripts\utility::func_562E(param_01)) {
    lib_04F8::func_7CCF();
    var_03 = getEntArray("care_package", "targetname");
    common_scripts\utility::func_F71(var_03, ::delete);
  }
}

func_5A55(param_00) {
  level endon("game_ended");
  var_01 = level.var_6C86[param_00].var_116;
  for(;;) {
    function_0380(var_01, 2000);
    wait(0.5);
  }
}

func_5841(param_00) {
  if(param_00 == "none") {
    return 0;
  }

  if(!maps\mp\gametypes\_weapons::func_5795(param_00)) {
    return 0;
  }

  if(maps\mp\gametypes\_weapons::func_5756(param_00)) {
    return 0;
  }

  switch (function_01AA(param_00)) {
    case "mg":
    case "smg":
    case "rifle":
    case "sniper":
    case "spread":
      return 1;

    default:
      return 0;
  }
}

func_470D(param_00) {
  var_01 = self getcurrentweapon();
  if(func_5841(var_01)) {
    return var_01;
  }

  var_02 = self getweaponslistprimaries();
  foreach(var_04 in var_02) {
    if(func_5841(var_04)) {
      return var_04;
    }
  }

  return param_00;
}

func_7D5E() {
  level.var_3E20 = [];
}

func_09AE(param_00, param_01) {
  if(!isDefined(level.var_3E20)) {
    level.var_3E20 = [];
  }

  if(!common_scripts\utility::func_F79(level.var_3E20, param_00)) {
    level.var_3E20 = common_scripts\utility::func_F6F(level.var_3E20, param_00);
  }

  if(common_scripts\utility::func_562E(param_01)) {
    foreach(var_03 in level.var_744A) {
      var_03 maps\mp\gametypes\_playerlogic::func_9457();
    }
  }
}

func_7CDC(param_00) {
  level.var_3E20 = common_scripts\utility::func_F93(level.var_3E20, param_00);
}

createfakenameplate(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_04 = getdvarvector("1497");
  var_05 = getdvarvector("5390");
  var_06 = getdvarvector("257");
  var_07 = newteamhudelem(param_02);
  var_07.maxsightdistsqrd = 0;
  var_07.var_1D7 = 0;
  if(param_00 method_8445("j_head") == -1) {
    var_07 settargetent(param_00);
    var_07.var_1D9 = 0;
  } else {
    var_07 settargetent(param_00, "j_head");
    var_07.var_1D9 = 10.5 + param_03;
  }

  var_07.var_134 = 1;
  var_07.var_56 = var_04;
  var_07.var_C6 = "center";
  var_07.var_1CA = "top";
  var_07.var_9B = 0.5;
  var_07 settext(param_01);
  var_07.var_18 = 1;
  var_07.var_9A = "default";
  var_07.var_AB = var_06;
  var_07.var_AA = 0;
  var_07.var_17A = 1;
  if(!isDefined(level.fakenameplates)) {
    level.fakenameplates = [];
  }

  level.fakenameplates[level.fakenameplates.size] = var_07;
}

deletefakenameplates() {
  if(isDefined(level.fakenameplates)) {
    var_00 = level.fakenameplates.size;
    for(var_01 = 0; var_01 < var_00; var_01++) {
      level.fakenameplates[var_01] destroy();
      level.fakenameplates[var_01] = undefined;
    }

    level.fakenameplates = undefined;
  }
}

getmaxintroavatars() {
  return 6;
}