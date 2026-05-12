/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_raid_objective_securedrops.gsc
*************************************************************/

securedropsobjectiveinit(param_00) {
  lib_04FF::func_6934(param_00);
  level.raidairdropcollision = getent("raid_securedrop_collision", "targetname");
  level.var_611["airdrop_smoke"] = loadfx("vfx/smoke/beacon_smoke_green_long");
  lib_04FF::func_6983(param_00.var_1A5);
  var_01 = lib_04FF::func_27DE("A", game["attackers"], self.var_116);
  var_01 maps\mp\gametypes\_gameobjects::func_8A60("none");
  param_00.var_2563 = var_01;
  param_00.numsecures = 0;
  param_00.drop_sites = [];
  foreach(var_03 in param_00.var_982D["drop_site"]) {
    var_04 = 0;
    if(isDefined(var_03.var_81E1)) {
      var_04 = var_03.var_81E1;
    }

    if(!isDefined(param_00.drop_sites[var_04])) {
      param_00.drop_sites[var_04] = [];
    }

    param_00.drop_sites[var_04] = common_scripts\utility::func_F6F(param_00.drop_sites[var_04], var_03);
  }

  foreach(var_08, var_07 in param_00.drop_sites) {
    var_07 = common_scripts\utility::func_F92(var_07);
    param_00.drop_sites[var_08] = var_07;
  }

  param_00 thread runsecuredropsobjective();
}

securedropssite(param_00) {
  param_00 method_805C();
  param_00 method_80B1();
}

issiteindexlower(param_00, param_01) {
  if(!isDefined(param_01.var_81E1)) {
    return 1;
  }

  if(!isDefined(param_00.var_81E1)) {
    return 0;
  }

  return param_00.var_81E1 < param_01.var_81E1;
}

runsecuredropsobjective() {
  level endon("game_ended");
  level endon("objective_A_complete");
  maps\mp\_utility::func_3FA5("finished_intro_vignette_allies");
  level.var_695E[level.var_695E.size] = ::secureobjectiveonplayerkilled;
  var_00 = 3;
  var_01 = var_00 * 1000;
  self.var_2563.var_A23F = var_01;
  self.var_2563 lib_04FF::func_990(self.var_116, undefined, (0, 0, 0), var_01, 118, 0, 1, 0, 1, 0, undefined, undefined, undefined, undefined, var_00);
  self.var_2563 lib_04FF::func_860F();
  thread securedropsobjectivecleanup();
  var_02 = 0;
  var_03 = 0;
  while(self.numsecures < var_00) {
    var_04 = self.drop_sites[0];
    if(isDefined(self.drop_sites[self.numsecures])) {
      var_04 = self.drop_sites[self.numsecures];
    }

    if(var_02 >= var_04.size) {
      var_02 = 0;
    }

    var_05 = var_04[var_02];
    var_05.var_695A = self.var_695A;
    self.current_drop_site = var_05;
    thread droppackage(var_05);
    var_06 = level common_scripts\utility::func_A715("attackers_secure_drop", "defenders_secure_drop", "securedrop_timeout");
    var_02++;
    if(var_06 == "attackers_secure_drop") {
      self.numsecures++;
      var_07 = self.numsecures * 1000;
      self.var_2563 lib_04FF::func_8615(var_07);
    }

    if(self.numsecures < var_00) {
      lib_04FF::func_79B2(self.var_695A);
      wait(2);
    }
  }

  level.var_695E = common_scripts\utility::func_F93(level.var_695E, ::secureobjectiveonplayerkilled);
  lib_04FF::func_6935(self.var_695A);
}

securedropsobjectivecleanup() {
  self endon("death");
  level endon("game_ended");
  lib_04FF::func_6982(self.var_1A5);
  self.var_2563 lib_04FF::func_7CCA();
  self.var_2563 maps\mp\gametypes\_gameobjects::func_2D58();
}

droppackage(param_00) {
  playFX(level.var_611["airdrop_smoke"], param_00.var_116);
  var_01 = param_00.var_116 + (0, 0, 6000);
  var_02 = spawn("script_model", var_01);
  var_02.var_1D = param_00.var_1D;
  var_02.var_1A7 = game["attackers"];
  var_02.visualteam = lib_0502::func_7979("attackers");
  var_02.var_28D5 = 0;
  var_02.var_A22B = 0;
  var_02.var_54F5 = 0;
  var_02 setModel("tun_airdrop_crates_01");
  var_03 = spawn("script_model", var_02 gettagorigin("tag_origin") + (0, 0, -10));
  var_03.var_1D = (0, 180, 0);
  var_03.visualteam = var_02.visualteam;
  if(var_03.visualteam == "allies" || var_03.visualteam == "zm") {
    var_03 setModel("usa_carepackage_parachute_anim");
  } else {
    var_03 setModel("ger_carepackage_parachute_anim");
  }

  var_04 = spawn("script_model", var_03.var_116);
  var_04.var_1D = var_03.var_1D;
  var_04 setModel("ger_carepackage_parachute");
  var_04 setCanDamage(1);
  var_04 method_805C();
  var_04 method_8449(var_03);
  var_02.var_1D = var_03 gettagangles("TAG_CRATE");
  var_02.var_116 = var_03 gettagorigin("TAG_CRATE");
  var_02 method_8449(var_03, "TAG_CRATE");
  var_02.var_6E4A = var_03;
  var_02.flag_wait = var_04;
  level notify("airdrop_deployed");
  var_03 thread func_64B8();
  var_03 scriptmodelplayanim("carepackage_parachute_deploy");
  wait(1.75);
  var_03.var_2D6A = 1;
  if(isDefined(var_02.var_6E4A)) {
    var_03 scriptmodelplayanim("carepackage_parachute_loop");
  }

  var_05 = maps\mp\gametypes\_gameobjects::func_45A9();
  objective_add(var_05, "invisible", (0, 0, 0));
  objective_position(var_05, param_00.var_116);
  objective_state(var_05, "active");
  function_01D1(var_05, "waypoint_supplydrop_neutral_map");
  objective_team(var_05, var_02.var_1A7);
  var_02.var_698E = var_05;
  var_05 = maps\mp\gametypes\_gameobjects::func_45A9();
  objective_add(var_05, "invisible", (0, 0, 0));
  objective_position(var_05, param_00.var_116);
  objective_state(var_05, "active");
  function_01D1(var_05, "waypoint_supplydrop_neutral_map");
  objective_team(var_05, level.var_6C63[var_02.var_1A7]);
  var_02.var_698D = var_05;
  var_02.parentobj = self;
  var_02 lib_04FF::func_990(var_02, "TAG_ORIGIN", (0, 0, 32), lib_0501::func_4647("airdrop_timeout") * 1000, 120, 1, 1, 0, 1, 1);
  var_03 thread func_63BB(var_02, var_03);
  var_04 thread func_63BA(var_03, var_02);
  var_02 thread func_6376("objective");
  var_02 thread func_2745();
  var_02 thread func_2752();
  var_02 thread func_74BA();
  if(!isDefined(level.droppedcratearray)) {
    level.droppedcratearray = [];
    level.droppedcratearray = common_scripts\utility::func_972(level.droppedcratearray, var_02);
    return;
  }

  level.droppedcratearray = common_scripts\utility::func_972(level.droppedcratearray, var_02);
}

func_64B8() {
  self endon("death");
  self endon("detach");
  lib_0378::func_8D74("ks_carepackage_parachute");
  for(;;) {
    self moveto(self.var_116 + (0, 0, -20), 0.05);
    wait 0.05;
  }
}

func_63BA(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("detach");
  common_scripts\utility::func_A732("damage", "death");
  param_00 thread func_2E45(param_01, 1);
}

func_63BB(param_00, param_01) {
  self endon("detach");
  var_02 = undefined;
  for(;;) {
    var_03 = param_01 gettagorigin("tag_origin");
    var_04 = (var_03[0], var_03[1], var_03[2] - 1000);
    var_05 = var_03;
    var_06 = bulletTrace(var_03, var_04, 1, param_00);
    if(var_06["fraction"] <= 0.5) {
      thread func_2E45(param_00, 0);
      break;
    }

    if(isDefined(var_05) && isDefined(var_02) && var_05 == var_02) {
      break;
    }

    var_02 = var_05;
    wait 0.05;
  }
}

func_2E45(param_00, param_01) {
  var_02 = 2.666667;
  if(!isDefined(param_00) || !isDefined(self)) {
    return;
  }

  if(isDefined(param_00.var_34A3) && param_00.var_34A3) {
    return;
  }

  self notify("detach");
  if(isDefined(param_00.flag_wait)) {
    param_00.flag_wait delete();
  }

  param_00.var_34A3 = 1;
  self method_8278("carepackage_parachute_detach");
  wait(0.2);
  param_00 unlink();
  param_00 clonebrushmodeltoscriptmodel(level.raidairdropcollision);
  var_03 = 500;
  if(maps\mp\_utility::func_579B()) {
    var_03 = 100;
  }

  param_00 physicslaunchserver((0, 0, 0), (0, 0, 1000), 3000, var_03);
  var_04 = 1;
  wait(var_02 - 0.2 - var_04);
  self setmaterialscriptparam(1, 1, 0);
  if(self.visualteam == "allies") {
    self setModel("usa_carepackage_parachute_anim_fade");
  } else {
    self setModel("ger_carepackage_parachute_anim_fade");
  }

  self setmaterialscriptparam(1, 0, var_04);
  wait(var_04);
  self delete();
}

func_74BA() {
  self waittill("physics_impact", var_00, var_01, var_02, var_03);
  lib_0378::func_8D74("ks_carepackage_firstImpact");
  playFX(common_scripts\utility::func_44F5("care_package_landed"), var_00, var_01);
  thread func_720C();
}

func_720C() {
  self endon("physics_finished");
  self waittill("physics_impact", var_00, var_01, var_02, var_03);
  lib_0380::func_6844("ks_carepackage_physics", undefined, self);
  playFX(common_scripts\utility::func_44F5("care_package_landed"), var_00, var_01);
}

func_2745() {
  self endon("physics_finished");
  self endon("death");
  var_00 = 0;
  var_01 = self.var_116;
  for(;;) {
    wait 0.05;
    var_02 = distancesquared(var_01, self.var_116);
    if(var_02 < 56.25) {
      var_00++;
    } else {
      var_00 = 0;
    }

    var_01 = self.var_116;
  }
}

func_2752(param_00) {
  self endon("death");
  self waittill("physics_finished");
  self.var_34A3 = 0;
  thread func_5A5F();
  level thread func_34B2(self);
  var_01 = getEntArray("trigger_hurt", "classname");
  foreach(var_03 in var_01) {
    if(self istouching(var_03)) {
      func_2D30();
      return;
    }
  }

  if(isDefined(self.var_117) && abs(self.var_116[2] - self.var_117.var_116[2]) > 4000) {
    func_2D30();
    return;
  }

  var_05 = spawnStruct();
  var_05.var_2AA8 = ::func_64EB;
  var_05.var_9AC2 = ::func_64EC;
  thread maps\mp\_movers::func_4A27(var_05);
  thread func_275D();
}

func_64EB(param_00) {
  func_2D30(1, 1);
}

func_64EC(param_00) {
  return func_1FFA(param_00) && func_1FFB(param_00);
}

func_1FFA(param_00) {
  return !isDefined(self.var_1A5) || !isDefined(param_00.var_1A5) || self.var_1A5 != "care_package" || param_00.var_1A5 != "care_package";
}

func_1FFB(param_00) {
  return !isDefined(self.var_1A5) || !isDefined(param_00.var_1FFE) || self.var_1A5 != "care_package" || !param_00.var_1FFE;
}

func_275D() {
  var_00 = getnodesinradiussorted(self.var_116, 300, 0, 300);
  foreach(var_02 in function_02D1()) {
    if(!isalive(var_02)) {
      continue;
    }

    if(var_02 istouching(self)) {
      foreach(var_04 in var_00) {
        if(distancesquared(var_04.var_116, self.var_116) > 10000) {
          var_02 setorigin(var_04.var_116, 1);
          var_00 = common_scripts\utility::func_F93(var_00, var_04);
          break;
        }
      }
    }
  }
}

func_5A5F() {
  self endon("death");
  if(isDefined(self.var_56C5) && self.var_56C5) {
    self waittill("physics_finished");
  }

  self.parentobj lib_04FF::func_79B3(self.parentobj.var_695A);
  func_275A(maps\mp\killstreaks\_killstreaks::func_4533("carepackage"));
  for(;;) {
    self waittill("captured", var_00);
    if(var_00.var_1A7 == self.var_1A7) {
      level notify("attackers_secure_drop");
    } else {
      level notify("defenders_secure_drop");
    }

    lib_0380::func_6840("scavenger_pack_pickup", var_00);
    func_2D30(1);
  }
}

func_275A(param_00) {
  function_01D1(self.var_698E, "waypoint_supplydrop_neutral_map");
  function_01D1(self.var_698D, "waypoint_supplydrop_ally_map");
  var_01 = 1;
  if(var_01) {
    var_02 = spawn("trigger_radius", self.var_116 + (0, 0, -1), 0, 160, 128);
    var_03 = maps\mp\gametypes\_gameobjects::func_2837(self.var_1A7, var_02, [self], (0, 0, 100));
    var_03 maps\mp\gametypes\_gameobjects::func_C30("friendly");
    var_03 maps\mp\gametypes\_gameobjects::func_1F49(lib_0501::func_4647("airdrop_contestable"));
    var_03 maps\mp\gametypes\_gameobjects::func_8A5A(lib_0501::func_4647("airdrop_captureTime"));
    var_03 maps\mp\gametypes\_gameobjects::func_8A59(&"MP_SECURING_CRATE");
    var_03.var_6ABC = ::onbeginusecrate;
    var_03.var_6AFA = ::onendusecrate;
    var_03.var_6BBE = ::onupdateuseratecrate;
    var_03.var_6BBF = ::onsecureobjectiveuse;
    var_03.var_A23E = 22;
    var_03.requirescontinuouslos = 1;
    var_03.var_1F6A = ::canseecrate;
    self.var_321B = var_03;
    var_03.parentobj = self.parentobj;
    level.activesecureobjective = [];
    level.activesecureobjective[0] = var_03;
    var_04 = maps\mp\bots\_bots_gametype_raid::func_412E();
    if(isDefined(var_04)) {
      var_04.var_A222 = var_03;
    }

    lib_04FF::func_8617("none", 121);
    self.var_321B lib_04FF::func_990(self.var_116, undefined, (0, 0, 32), lib_0501::func_4647("airdrop_captureTime") * 1000, 121, 0, 1, 0, 1, 1);
    self.var_321B onupdateuseratecrate();
    self.var_321B thread dropobjectiveupdate();
    return;
  }

  self makeusable();
  lib_04FF::func_8613(121);
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"RAIDS_USE_SECURE_AIRDROP");
  var_05 = self.var_1A7;
  foreach(var_07 in level.var_744A) {
    if(var_07.var_1A7 != var_05 || var_07.var_1A7 == "spectator") {
      self disableplayeruse(var_07);
      continue;
    }

    if(var_07.var_1A7 == var_05) {
      self enableplayeruse(var_07);
    }
  }

  thread func_2744();
}

canseecrate(param_00, param_01) {
  var_02 = 25;
  var_03 = (0, 0, 1);
  var_04 = 10;
  var_05 = param_00 getEye();
  var_06 = anglestoup(self.var_A582[0].var_1D);
  var_07 = self.var_A582[0].var_116 + var_06 * var_02 + var_03 * var_04;
  var_08 = param_01[0];
  for(;;) {
    var_09 = bulletTrace(var_07, var_05, 0, var_08, 0, 0, 0, 0, 1, 0, 0);
    if(var_09["fraction"] == 1) {
      return 1;
    } else if(!isDefined(var_09["entity"]) || var_09["fraction"] == 0) {
      return 0;
    } else {
      var_08 = var_09["entity"];
      var_07 = var_09["position"];
    }
  }
}

dropobjectiveupdate() {
  self endon("deleted");
  var_00 = game["attackers"];
  for(;;) {
    var_01 = self.var_689F[var_00];
    if(var_01 > 0) {
      lib_04FF::func_6981(self.parentobj.var_695A);
    }

    wait 0.05;
  }
}

onbeginusecrate(param_00, param_01) {}

onendusecrate(param_00, param_01, param_02) {
  if(!param_02) {
    self.var_28D5 = 0;
    return;
  }

  var_03 = self.var_A582[0];
  var_04 = self.var_9AC3[var_03.var_1A7];
  foreach(var_06 in var_04) {}

  var_03 notify("captured", param_01);
}

onupdateuseratecrate() {
  var_00 = self.var_A582[0];
  if(!isDefined(var_00) || function_0279(var_00)) {
    return;
  }

  var_01 = self.var_689F[game["attackers"]];
  var_02 = self.var_1F49 && self.var_689F[game["defenders"]];
  self.var_A22B = 0;
  self.var_915C = var_01 && var_02;
  if(var_01 && var_02) {
    function_01D1(var_00.var_698E, "waypoint_supplydrop_contested_map");
    function_01D1(var_00.var_698D, "waypoint_supplydrop_contested_map");
    lib_04FF::func_8611();
    lib_04FF::func_8614(134);
    var_00 lib_04FF::func_860F();
  }

  if(var_01 && !var_02) {
    self.var_A22B = 1;
    function_01D1(var_00.var_698E, "waypoint_supplydrop_ally_map");
    function_01D1(var_00.var_698D, "waypoint_supplydrop_enemy_map");
    lib_04FF::func_8611();
    lib_04FF::func_8617("taking", 122);
    var_00 lib_04FF::func_860F();
  }

  if(!var_01) {
    function_01D1(var_00.var_698E, "waypoint_supplydrop_neutral_map");
    function_01D1(var_00.var_698D, "waypoint_supplydrop_ally_map");
    lib_04FF::func_860F();
    lib_04FF::func_8615(0, 121);
    var_00 lib_04FF::func_8611();
  }
}

func_2744() {
  self endon("captured");
  while(isDefined(self)) {
    self waittill("trigger", var_00);
    thread func_11C3(var_00);
  }
}

func_11C3(param_00) {
  if(param_00 method_83B8()) {
    return;
  }

  if(!param_00 isonground() && !func_A7A0(param_00)) {
    return;
  }

  if(!func_A276(param_00)) {
    return;
  }

  if(param_00.var_1A7 == self.var_1A7) {
    function_01D1(self.var_698E, "waypoint_supplydrop_ally_map");
    function_01D1(self.var_698D, "waypoint_supplydrop_enemy_map");
    lib_04FF::func_8613(122);
  } else {
    return;
  }

  var_01 = lib_0501::func_4647("airdrop_captureTime") * 1000;
  param_00.var_56A1 = 1;
  param_00 thread preventactionslotspam();
  var_02 = func_2836();
  var_03 = var_02 func_A213(param_00, var_01, self);
  if(isDefined(var_02)) {
    var_02 delete();
  }

  if(isDefined(param_00)) {
    param_00.var_56A1 = 0;
  }

  function_01D1(self.var_698E, "waypoint_supplydrop_neutral_map");
  function_01D1(self.var_698D, "waypoint_supplydrop_ally_map");
  lib_04FF::func_8616(121);
  if(!var_03) {
    param_00 notify("attemptCaptureEnd");
    return;
  }

  self notify("captured", param_00);
  wait(0.2);
  param_00 notify("attemptCaptureEnd");
}

preventactionslotspam() {
  self method_8309(0);
  common_scripts\utility::func_A716("death", "game_ended", "disconnect", "attemptCaptureEnd");
  self method_8309(1);
}

func_A7A0(param_00) {
  if(param_00 isonground()) {
    return 0;
  }

  var_01 = param_00.var_116;
  var_02 = gettime();
  while(isDefined(param_00) && maps\mp\_utility::func_57A0(param_00) && !param_00 isonground() && var_01 == param_00.var_116 && param_00 useButtonPressed()) {
    var_03 = gettime() - var_02;
    if(var_03 >= 200) {
      return 1;
    }

    wait 0.05;
  }

  return 0;
}

func_A276(param_00) {
  var_01 = param_00 getcurrentprimaryweapon();
  if(issubstr(var_01, "turrethead") || issubstr(var_01, "flamethrower") || issubstr(var_01, "carepackage")) {
    return 1;
  }

  if(!param_00 maps\mp\killstreaks\_killstreaks::func_1F6E()) {
    return 0;
  }

  if(isDefined(param_00.var_20CC) && !param_00 maps\mp\killstreaks\_killstreaks::func_1F6E()) {
    return 0;
  }

  return 1;
}

func_A213(param_00, param_01, param_02) {
  if(isPlayer(param_00)) {
    param_00 playerlinkto(self);
  } else {
    param_00 linkto(self);
  }

  param_00 common_scripts\utility::func_602();
  thread func_A215(param_00);
  self.var_28D5 = 0;
  self.var_54F5 = 1;
  self.var_A22B = 0;
  if(isPlayer(param_00)) {
    param_00 thread func_6F82(self, param_01, param_02);
  }

  var_03 = func_A214(param_00, param_01);
  if(!isDefined(self)) {
    return 0;
  }

  self notify("useHoldThinkLoopDone");
  self.var_54F5 = 0;
  self.var_28D5 = 0;
  return var_03;
}

func_A215(param_00) {
  param_00 endon("death");
  common_scripts\utility::knock_off_battery("death", "captured", "useHoldThinkLoopDone");
  if(isalive(param_00)) {
    param_00 common_scripts\utility::func_616();
    if(param_00 islinked()) {
      param_00 unlink();
    }
  }
}

func_6F82(param_00, param_01, param_02) {
  self endon("disconnect");
  self setclientomnvar("ui_use_bar_text", 1);
  self setclientomnvar("ui_use_bar_start_time", int(gettime()));
  var_03 = -1;
  while(maps\mp\_utility::func_57A0(self) && isDefined(param_00) && param_00.var_54F5 && !level.var_3F9D) {
    if(var_03 != param_00.var_A22B) {
      if(param_00.var_28D5 > param_01) {
        param_00.var_28D5 = param_01;
      }

      if(param_00.var_A22B > 0) {
        var_04 = int(param_02.var_116[0]);
        var_05 = int(param_02.var_116[1]);
        var_06 = int(param_02.var_116[2] + 25);
        self luinotifyevent(&"carepackage_icon_world_position", 3, var_04, var_05, var_06);
        var_07 = gettime();
        var_08 = param_00.var_28D5 / param_01;
        var_09 = var_07 + 1 - var_08 * param_01 / param_00.var_A22B;
        self setclientomnvar("ui_use_bar_end_time", int(var_09));
        self setclientomnvar("ui_mp_carepackage_scorestreak", maps\mp\_utility::func_453F("carepackage"));
        self setclientomnvar("ui_mp_carepackage_team", maps\mp\_utility::func_46D4(param_02.var_1A7));
        if(isDefined(param_02.var_117)) {
          self setclientomnvar("ui_mp_carepackage_owner", param_02.var_117 getentitynumber());
        }
      }

      var_03 = param_00.var_A22B;
    }

    wait 0.05;
  }

  if(isDefined(param_02)) {}

  self setclientomnvar("ui_use_bar_end_time", 0);
}

func_A214(param_00, param_01) {
  while(!level.var_3F9D && isDefined(self) && maps\mp\_utility::func_57A0(param_00) && param_00 useButtonPressed() && self.var_28D5 < param_01) {
    self.var_28D5 = self.var_28D5 + self.var_A22B * 50;
    if(!self.var_A22B) {
      self.var_A22B = 1;
    }

    if(self.var_28D5 >= param_01) {
      return maps\mp\_utility::func_57A0(param_00);
    }

    wait 0.05;
  }

  return 0;
}

func_2836() {
  var_00 = spawn("script_origin", self.var_116);
  var_00.var_28D5 = 0;
  var_00.var_A22B = 0;
  var_00.var_54F5 = 0;
  var_00 thread func_2D57(self);
  return var_00;
}

func_2D57(param_00) {
  self endon("death");
  param_00 waittill("death");
  self delete();
}

func_2D30(param_00, param_01, param_02) {
  if(isDefined(self.var_321B)) {
    self.var_321B lib_04FF::func_7CCA();
  }

  lib_04FF::func_7CCA();
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  if(isDefined(self.var_5A2C)) {
    self.var_5A2C delete();
  }

  if(isDefined(self.var_6DB1)) {
    self.var_6DB1 delete();
  }

  if(isDefined(self.var_6C62)) {
    self.var_6C62 delete();
  }

  if(isDefined(self.var_3009)) {
    self.var_3009 delete();
  }

  if(param_00 && self.visualteam == "axis") {
    playFX(common_scripts\utility::func_44F5("care_package_axis_destroy"), self.var_116, anglesToForward(self.var_1D));
  }

  if(param_00 && self.visualteam == "allies") {
    playFX(common_scripts\utility::func_44F5("care_package_allies_destroy"), self.var_116, anglesToForward(self.var_1D));
  }

  if(param_01 && self.visualteam == "allies") {
    lib_0380::func_6842("ks_carepackage_open_allies", undefined, self.var_116);
  }

  if(param_01 && self.visualteam == "axis") {
    lib_0380::func_6842("ks_carepackage_open_axis", undefined, self.var_116);
  }

  if(isDefined(self.var_5010)) {
    foreach(var_04 in self.var_5010) {
      var_04 delete();
    }
  }

  if(param_02 && self.visualteam == "axis") {
    thread func_27DF(self.var_116, self.var_1D);
  }

  if(!function_0279(self) && isDefined(self.var_321B)) {
    if(isDefined(self.var_320E)) {
      self.var_320E delete();
    }

    if(isDefined(self.var_321B.var_9D65)) {
      self.var_321B.var_9D65 delete();
    }

    self.var_321B maps\mp\gametypes\_gameobjects::func_2D58();
  }

  if(isDefined(self.var_698E)) {
    maps\mp\_utility::func_68B(self.var_698E);
  }

  if(isDefined(self.var_698D)) {
    maps\mp\_utility::func_68B(self.var_698D);
  }

  if(isDefined(self) && !function_0279(self)) {
    self delete();
  }
}

func_34B2(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  maps\mp\gametypes\_hostmigration::func_A6F5(lib_0501::func_4647("airdrop_timeout"));
  if(isDefined(param_00.var_321B)) {
    while(param_00.var_321B.var_689F[game["attackers"]] > 0 || lib_04FF::raidovertimeisactive()) {
      wait 0.05;
    }
  } else {}

  level notify("securedrop_timeout");
  param_00 func_2D30(1, 1);
}

func_27DF(param_00, param_01) {
  var_02 = spawn("script_model", param_00);
  var_02 setModel("ger_carepackage_crate_chunks");
  var_02.var_1D = param_01;
  var_02 method_805B();
  wait 0.05;
  physicsexplosionsphere(param_00, 100, 80, 0.6);
  wait(2);
  var_02 delete();
}

secureobjectiveonplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = self;
  if(isDefined(level.activesecureobjective) && level.activesecureobjective.size > 0) {
    foreach(var_0C in level.activesecureobjective) {
      if(isDefined(var_0C.var_9D65)) {
        if(param_01 istouching(var_0C.var_9D65)) {
          if(param_01.var_1A7 == game["attackers"]) {
            param_01 thread maps\mp\_events::func_5A82(var_0A, param_09, param_04);
            param_01.var_62A1["assaultObjective"] = var_0C;
          }

          if(param_01.var_1A7 == game["defenders"]) {
            param_01 thread maps\mp\_events::func_2C80(var_0A, param_09, param_04);
            param_01.var_62A1["defendObjective"] = var_0C;
          }

          continue;
        }

        if(var_0A istouching(var_0C.var_9D65)) {
          param_01 thread maps\mp\gametypes\_missions::func_80BB(param_04, param_03);
          if(var_0A.var_1A7 == game["attackers"]) {
            param_01 thread maps\mp\_events::func_2C80(var_0A, param_09, param_04);
            param_01.var_62A1["defendObjective"] = var_0C;
          }

          if(var_0A.var_1A7 == game["defenders"]) {
            param_01 thread maps\mp\_events::func_10BA(var_0A, param_09, param_04);
            param_01.var_62A1["assaultObjective"] = var_0C;
          }
        }
      }
    }
  }
}

onsecureobjectiveuse(param_00) {
  foreach(var_02 in self.var_9AC3[game["attackers"]]) {
    var_02.var_721C thread raidsecureobjectiveevent();
    param_00 notify("ch_capture", self);
  }

  level.activesecureobjective = [];
}

raidsecureobjectiveevent() {
  maps\mp\_utility::func_50EA("raids_airdrop_secure", 1);
  level thread maps\mp\gametypes\_rank::func_1457("raids_airdrop_secure", self);
}

func_0F30(param_00, param_01) {
  var_02 = 300;
  var_03 = 100;
  var_04 = 1250;
  var_05 = vectornormalize(param_01 - param_00.var_116);
  var_06 = var_05[0] * var_02;
  var_07 = var_05[1] * var_02;
  var_08 = -1 * var_05[1] * var_04;
  var_09 = var_05[0] * var_04;
  self physicssetvelocityserver((var_06, var_07, var_03), (var_08, var_09, 0));
}

func_6376(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("physics_finished");
  var_01 = self.var_116;
  for(;;) {
    var_02 = self.var_116 + anglestoup(self.var_1D);
    if(distancesquared(var_01, var_02) > 100) {
      foreach(var_04 in level.var_744A) {
        if(var_04 istouching(self)) {
          thread func_0F30(var_04, var_02);
          var_04 dodamage(150, var_02, undefined, self, "MOD_PROJECTILE", "carepackage_crate_mp");
          self notify("hit_player");
        }
      }
    }

    var_01 = var_02;
    wait 0.05;
  }
}