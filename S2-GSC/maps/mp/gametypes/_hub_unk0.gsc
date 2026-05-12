/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hub_unk0.gsc
*********************************************/

func_21C7() {
  var_00 = getEntArray("fte_load_guard", "targetname");
  var_01 = getEntArray("fte_npc_collision", "targetname");
  level.var_836A = getEntArray("fte_section_wall", "targetname");
  foreach(var_03 in var_00) {
    var_03 setplayercollision(self, 0);
  }

  foreach(var_03 in var_01) {
    var_03 setplayercollision(self, 0);
  }

  foreach(var_03 in level.var_836A) {
    var_03 setplayercollision(self, 0);
  }

  if(!maps\mp\gametypes\_hud_util::shoulddohubtutorialflow()) {
    return;
  }

  for(;;) {
    self waittill("luinotifyserver", var_09, var_0A);
    if(var_09 == "hub_fte" && isDefined(var_0A) && var_0A == 5) {
      break;
    }
  }

  self.var_6AC2 = self getrankedplayerdata(common_scripts\utility::func_46AA(), "hubTutorialProgress", "status");
  if(!isDefined(self.var_6AC2) || self.var_6AC2 == -1) {
    self.var_6AC2 = -1;
    return;
  }

  switch (self.var_6AC2) {
    case 0:
      break;

    case 1:
      func_7FA8();
      break;

    case 2:
      func_7FA9();
      break;

    case 3:
      break;

    default:
      break;
  }
}

func_7FA7() {
  setDvar("5737", 1);
  setDvar("1471", 5);
  self.var_9FB4 = 0;
  func_7FAA();
}

func_7FA8() {
  self.var_6AC3 = [];
  self.var_6AC3["orders"] = spawnStruct();
  self.var_6AC3["supply"] = spawnStruct();
  self.var_6AC3["payroll"] = spawnStruct();
  self.var_6AC3["orders"].var_933D = self getrankedplayerdata(common_scripts\utility::func_46AA(), "hubTutorialProgress", "onboard_orders_complete");
  self.var_6AC3["supply"].var_933D = self getrankedplayerdata(common_scripts\utility::func_46AA(), "hubTutorialProgress", "onboard_supply_complete");
  self.var_6AC3["payroll"].var_933D = self getrankedplayerdata(common_scripts\utility::func_46AA(), "hubTutorialProgress", "onboard_payroll_complete");
  self.var_6AC3["orders"].var_389E = "picked_up_orders";
  self.var_6AC3["supply"].var_389E = "open_sd";
  self.var_6AC3["payroll"].var_389E = "picked_up_payroll";
  self.var_6AC3["orders"].var_946C = "HUB_ONB_ORDERS";
  self.var_6AC3["supply"].var_946C = "HUB_ONB_SUPPLY";
  self.var_6AC3["payroll"].var_946C = "HUB_ONB_PAYROLL";
  self.var_6AC3["orders"].var_59E7 = 2;
  self.var_6AC3["supply"].var_59E7 = 3;
  self.var_6AC3["payroll"].var_59E7 = 4;
  self luinotifyeventextraplayer(&"construction_event", 12, 1, "HUB_ONB_PHASE1_HEADER", self.var_6AC3["orders"].var_59E7, self.var_6AC3["orders"].var_946C, self.var_6AC3["supply"].var_59E7, self.var_6AC3["supply"].var_946C, self.var_6AC3["payroll"].var_59E7, self.var_6AC3["payroll"].var_946C, 5, "LUA_MENU_XP", 750, "s2_xp_icon");
  wait(3);
  if(isDefined(self.var_6AC3["orders"].var_933D) && self.var_6AC3["orders"].var_933D >= 1) {
    self luinotifyeventextraplayer(&"gray_out_persistent_indicator", 1, self.var_6AC3["orders"].var_59E7);
  } else {
    maps\mp\gametypes\_hub_unk1::func_3E28(level.var_4BF3);
    thread func_A79C();
  }

  if(isDefined(self.var_6AC3["supply"].var_933D) && self.var_6AC3["supply"].var_933D >= 1) {
    self luinotifyeventextraplayer(&"gray_out_persistent_indicator", 1, self.var_6AC3["supply"].var_59E7);
  }

  if(isDefined(self.var_6AC3["payroll"].var_933D) && self.var_6AC3["payroll"].var_933D >= 1) {
    self luinotifyeventextraplayer(&"gray_out_persistent_indicator", 1, self.var_6AC3["payroll"].var_59E7);
  }
}

func_7FA9() {
  self.var_6AC3 = [];
  self.var_6AC3["collection"] = spawnStruct();
  self.var_6AC3["streak"] = spawnStruct();
  self.var_6AC3["commend"] = spawnStruct();
  self.var_6AC3["collection"].var_933D = self getrankedplayerdata(common_scripts\utility::func_46AA(), "hubTutorialProgress", "onboard_collection_complete");
  self.var_6AC3["streak"].var_933D = self getrankedplayerdata(common_scripts\utility::func_46AA(), "hubTutorialProgress", "onboard_scorestreak_complete");
  self.var_6AC3["commend"].var_933D = self getrankedplayerdata(common_scripts\utility::func_46AA(), "hubTutorialProgress", "onboard_commend_complete");
  self.var_6AC3["collection"].var_389E = "";
  self.var_6AC3["streak"].var_389E = "";
  self.var_6AC3["commend"].var_389E = "commend_player";
  self.var_6AC3["collection"].var_946C = "HUB_ONB_COLLECTION";
  self.var_6AC3["streak"].var_946C = "HUB_ONB_SCORESTREAK";
  self.var_6AC3["commend"].var_946C = "HUB_ONB_COMMEND";
  self.var_6AC3["collection"].var_59E7 = 2;
  self.var_6AC3["streak"].var_59E7 = 3;
  self.var_6AC3["commend"].var_59E7 = 4;
  self luinotifyeventextraplayer(&"construction_event", 12, 1, "HUB_ONB_PHASE2_HEADER", self.var_6AC3["collection"].var_59E7, self.var_6AC3["collection"].var_946C, self.var_6AC3["streak"].var_59E7, self.var_6AC3["streak"].var_946C, self.var_6AC3["commend"].var_59E7, self.var_6AC3["commend"].var_946C, 5, "LUA_MENU_XP", 750, "s2_xp_icon");
  wait(3);
  if(isDefined(self.var_6AC3["collection"].var_933D) && self.var_6AC3["collection"].var_933D >= 1) {
    self luinotifyeventextraplayer(&"gray_out_persistent_indicator", 1, self.var_6AC3["collection"].var_59E7);
  }

  if(isDefined(self.var_6AC3["streak"].var_933D) && self.var_6AC3["streak"].var_933D >= 1) {
    self luinotifyeventextraplayer(&"gray_out_persistent_indicator", 1, self.var_6AC3["streak"].var_59E7);
  }

  if(isDefined(self.var_6AC3["commend"].var_933D) && self.var_6AC3["commend"].var_933D >= 1) {
    self luinotifyeventextraplayer(&"gray_out_persistent_indicator", 1, self.var_6AC3["commend"].var_59E7);
  }
}

func_A79C() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 != "hub_fte") {
      continue;
    }

    switch (var_01) {
      case 69:
        maps\mp\gametypes\_hub_unk1::func_3E15(level.var_4BF3);
        break;

      default:
        break;
    }
  }
}

func_7FAA() {
  level.var_0611["tutorial_path"] = loadfx("vfx/unique/hardpoint_chevron_friendly_vertical");
  wait 0.05;
  thread func_9075();
  thread func_77C7();
  thread func_63B0();
  self method_8483("mp_hub_allies_fte", 0);
  thread func_7FAE();
  thread func_6380();
}

func_6461() {
  wait 0.05;
  setDvar("712", 1);
  setDvar("r_mbVeliocityScaler", 100);
  setDvar("5469", 1);
  setDvar("904", 1);
  setDvar("2032", "1");
  setDvar("3161", ".3");
  setDvar("r_vignettefalloff", "1.2");
}

func_6460() {
  setDvar("712", 0);
  setDvar("3161", ".35");
  setDvar("r_vignettefalloff", "1.2");
  setDvar("2032", "0");
}

func_8BE4() {
  var_00 = common_scripts\utility::func_46B7("org_tutorial_path", "targetname");
  if(!isDefined(var_00) || var_00.size == 0) {
    return;
  }

  var_01 = [];
  foreach(var_03 in var_00) {
    var_04 = common_scripts\utility::func_8FFC();
    var_04.var_0116 = var_03.var_0116;
    var_04.var_001D = var_03.var_001D;
    var_04 method_805B();
    var_01[var_01.size] = var_04;
    playfxontagforclients(common_scripts\utility::func_44F5("tutorial_path"), var_04, "tag_origin", self);
  }

  return var_01;
}

func_4CFB(param_00) {
  foreach(var_02 in param_00) {
    function_0294(common_scripts\utility::func_44F5("tutorial_path"), var_02, "tag_origin", self);
    var_02 delete();
  }
}

func_63B9() {
  self endon("disconnect");
  level endon("game_ended");
  maps\mp\gametypes\_hub_unk1::func_3E28(level.var_4BF3);
  while(func_21B0(300) == 0) {
    wait(1);
  }

  self notify("followSequenceOver");
  self waittill("playerLeftRequisitions");
  self luinotifyeventextraplayer(&"gray_out_persistent_indicator", 1, 2);
  thread func_2CD3(1.5, "remove", 1, 2);
  thread func_2CD3(1, "headerremove", 1, 10);
  thread func_2CD3(2.5, "headeradd", 2, 11, "HUB_FTE_HEADER2");
  thread func_2CD3(3, "add", 2, 3, "HUB_FTE_PAYROLL");
  thread func_2CD3(3.5, "add", 2, 4, "HUB_FTE_RANGE");
  maps\mp\gametypes\_hub_unk1::func_A04C();
  maps\mp\gametypes\_hub_unk1::func_3E1F(level.var_4BF3);
  self notify("opsDone");
}

func_63B0() {
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 != "hub_fte") {
      continue;
    }

    if(var_01 == -1) {}

    switch (var_01) {
      case 8:
        break;

      default:
        break;
    }
  }
}

func_77C7() {
  foreach(var_01 in level.var_4F51) {
    maps\mp\gametypes\_hub_unk1::func_3E1F(var_01);
  }
}

func_7B78() {
  maps\mp\gametypes\_hub_unk1::func_3E28(level.var_5F83);
  maps\mp\gametypes\_hub_unk1::func_3E28(level.var_3C3E);
}

func_8A1C() {
  wait 0.05;
  var_00 = common_scripts\utility::func_46B5("firing_range_vendor", "targetname");
  if(!isDefined(var_00)) {
    return;
  }

  var_01 = spawn("script_model", var_00.var_0116);
  var_01.var_001D = var_00.var_001D;
  var_01 setcostumemodels([497, 497, 0, 0, 0]);
  var_01 scriptmodelplayanim("mp_hub_patrol_unarmed_idle");
  return var_01;
}

func_4ABE(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    while(self.var_5721) {
      wait(10);
    }

    wait(5);
  }
}

func_2CD3(param_00, param_01, param_02, param_03, param_04) {
  self endon("disconnect");
  level endon("game_ended");
  wait(param_00);
  switch (param_01) {
    case "add":
      self luinotifyeventextraplayer(&"add_persistent_indicator", param_02, param_03, param_04);
      break;

    case "remove":
      self luinotifyeventextraplayer(&"remove_persistent_indicator", param_02, param_03);
      break;

    case "gray":
      self luinotifyeventextraplayer(&"gray_out_persistent_indicator", param_02, param_03);
      break;

    case "headeradd":
      self luinotifyeventextraplayer(&"add_persistent_indicator_header", param_02, param_03, param_04);
      break;

    case "headerremove":
      self luinotifyeventextraplayer(&"remove_persistent_indicator_header", param_02, param_03);
      break;

    default:
      break;
  }
}

func_63F1() {
  if(!isDefined(self.var_3EF8)) {
    self.var_3EF8 = 0;
  }

  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  for(;;) {
    self waittill("luinotifyserver", var_05, var_06);
    if(var_05 != "hub_fte") {
      continue;
    }

    if(var_06 == -1) {}

    switch (var_06) {
      case 2:
        if(!var_03) {
          self.var_3EF8++;
        }

        var_03 = 1;
        break;

      case 3:
        if(!var_04) {
          self.var_3EF8++;
        }

        var_04 = 1;
        break;

      case 4:
        maps\mp\gametypes\_hub_unk1::func_3E1F(level.var_5F83);
        self luinotifyeventextraplayer(&"gray_out_persistent_indicator", 1, 3);
        var_00++;
        break;

      case 5:
        self luinotifyeventextraplayer(&"gray_out_persistent_indicator", 1, 4);
        maps\mp\gametypes\_hub_unk1::func_3E1F(level.var_3C3E);
        var_00++;
        break;

      default:
        break;
    }

    if(self.var_3EF8 == 2) {
      self luinotifyeventextraplayer(&"remove_persistent_indicator", 1, 6);
      thread func_2CD3(1, "headerremove", 1, 11);
      thread func_2CD3(4, "headeradd", 2, 12, "HUB_FTE_HEADER3");
      thread func_2CD3(5, "add", 2, 5, "HUB_FTE_LOBBY");
      setDvar("1471", 5);
      self luinotifyevent(&"fte_lobby_open", 0);
      return;
    }

    if(var_00 == 2 && !var_01) {
      thread func_2CD3(2.3, "remove", 1, 3);
      thread func_2CD3(2.6, "remove", 1, 4);
      thread func_2CD3(4, "add", 2, 6, "HUB_FTE_REDEEM_ORDERS");
      setDvar("1471", 5);
      var_01 = 1;
    }
  }
}

func_6398() {
  self waittill("playerLeftQuartermaster");
  maps\mp\gametypes\_hub_unk1::func_3E15(level.var_781C);
}

func_92D4() {
  var_00 = common_scripts\utility::func_46B5("fte_waypoint_05", "targetname");
  var_01 = spawn("script_model", var_00.var_0116);
  var_01 maps\mp\gametypes\_hub_unk1::func_8627();
  var_02 = spawn("script_model", var_00.var_0116);
  var_02 maps\mp\gametypes\_hub_unk1::func_8627();
  var_03 = spawn("script_model", var_00.var_0116);
  var_03 maps\mp\gametypes\_hub_unk1::func_8627();
  var_04 = spawn("script_model", var_00.var_0116);
  var_04 maps\mp\gametypes\_hub_unk1::func_8627();
  var_05 = spawn("script_model", var_00.var_0116);
  var_05 maps\mp\gametypes\_hub_unk1::func_8627();
  self.var_54C5.var_0116 = var_00.var_0116;
  self.var_54C5.var_001D = var_00.var_001D;
  var_01 method_8495("mp_hub_rco_arrival_pt01_guy_01", var_00.var_0116, var_00.var_001D, "animEnded");
  var_02 method_8495("mp_hub_rco_arrival_pt01_guy_02", var_00.var_0116, var_00.var_001D, "animEnded");
  var_03 method_8495("mp_hub_rco_arrival_pt01_guy_03", var_00.var_0116, var_00.var_001D, "animEnded");
  var_04 method_8495("mp_hub_rco_arrival_pt01_guy_04", var_00.var_0116, var_00.var_001D, "animEnded");
  var_05 method_8495("mp_hub_rco_arrival_pt01_guy_05", var_00.var_0116, var_00.var_001D, "animEnded");
  self.var_54C5 method_8495("mp_hub_rco_arrival_pt01_camera", var_00.var_0116, var_00.var_001D, "animEnded");
  var_01 waittill("animEnded");
  var_01 method_8495("mp_hub_rco_arrival_pt03_guy_01", var_00.var_0116, var_00.var_001D, "animEnded");
  var_02 method_8495("mp_hub_rco_arrival_pt03_guy_02", var_00.var_0116, var_00.var_001D, "animEnded");
  var_03 method_8495("mp_hub_rco_arrival_pt03_guy_04", var_00.var_0116, var_00.var_001D, "animEnded");
  var_04 method_8495("mp_hub_rco_arrival_pt03_guy_03", var_00.var_0116, var_00.var_001D, "animEnded");
  var_05 method_8495("mp_hub_rco_arrival_pt03_guy_05", var_00.var_0116, var_00.var_001D, "animEnded");
  self.var_54C5 method_8495("mp_hub_rco_arrival_pt03_camera", var_00.var_0116, var_00.var_001D, "animEnded");
  var_01 waittillmatch("end", "animEnded");
  var_01 delete();
  var_02 delete();
  var_03 delete();
  var_04 delete();
  var_05 delete();
}

func_8A3E() {
  var_00 = common_scripts\utility::func_46B5("fte_waypoint_05", "targetname");
  level.var_7B46 = spawn("script_model", var_00.var_0116);
  level.var_7B46 setcostumemodels([498, 498, 0, 0, 0]);
  level.var_7B46 method_8495("mp_hub_rco_arrival_pt01_sergeant", var_00.var_0116, var_00.var_001D, "animEnded");
  level.var_7B46 waittill("animEnded");
  level.var_7B46 method_8495("mp_hub_rco_arrival_pt03_sergeant", var_00.var_0116, var_00.var_001D, "animEnded");
}

func_5428() {
  wait(2);
  level.var_7B46 scriptmodelclearanim();
}

func_2D4A() {
  if(isDefined(level.var_7B46.var_6CA2)) {
    level.var_7B46.var_6CA2 destroy();
  }

  level.var_7B46 delete();
}

func_21B1(param_00, param_01) {
  var_02 = distance(self.var_0116, level.var_93F7[param_01].var_0116);
  if(var_02 > param_00) {
    return 0;
  }

  return 1;
}

func_21B0(param_00) {
  var_01 = distance(self.var_0116, level.var_4BF3.var_0116);
  if(var_01 > param_00) {
    return 0;
  }

  return 1;
}

func_4AEA(param_00, param_01, param_02) {
  level.var_7B46 method_8495(level.var_7A90[param_01], param_02.var_0116, param_02.var_001D, "animEnded");
  var_03 = 10;
  var_04 = 0;
  while(!func_21B1(param_00, param_01)) {
    wait(1);
  }

  self notify("backInRangeOfRecruitment");
}

func_74D1() {
  self endon("backInRangeOfRecruitment");
  self endon("disconnect");
  self endon("tutorialShortcut");
  var_00 = ["Let\'s get moving, soldier!", "We\'ve got a war to fight. Get moving, private!", "Over here! Let\'s get going.", "Stay on track, private. Follow me.", "I\'ve got places to be, let\'s GO!", "Do I need to hold your hand, private? Get over here.", "Soldier, get back over here. We have work to do."];
  for(;;) {
    self iclientprintlnbold(common_scripts\utility::func_7A33(var_00));
    wait(10);
  }
}

func_6380() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "hub_character_selection") {
      break;
    }
  }

  if(!maps\mp\gametypes\_divisions::func_56CC(var_01)) {
    self iclientprintlnbold("INVALID DIVISION SELECTED");
  } else {
    var_02 = maps\mp\gametypes\_divisions::func_4498(var_01);
    if(isDefined(var_02)) {
      thread maps\mp\gametypes\_hud_message::func_9102(var_02);
    }

    self.var_9FB3 = var_01;
    self.var_267E = getdivisioncostume(var_01, 1);
    self setcostumemodels(self.var_267E);
    maps\mp\gametypes\_hub_unk1::func_115E();
    lib_0378::func_8D74("start_hub_music");
    thread func_7214(var_01);
  }

  maps\mp\gametypes\_hub_unk1::func_A04C();
  self freezecontrols(0);
  self.var_9FB4 = 2;
  setDvar("1471", 5);
  lib_0468::func_0A1F();
}

func_7214(param_00) {
  self endon("disconnect");
  wait(2);
  switch (param_00) {
    case 0:
      self method_860F("hub_dr2_goodchoicesoldierinfantry", self);
      wait(4);
      break;

    case 1:
      self method_860F("hub_dr2_nicechoicesoldierairborne", self);
      wait(4);
      break;

    case 2:
      self method_860F("hub_dr2_bolddecisionyouwillbringt", self);
      wait(4);
      break;

    case 3:
      self method_860F("hub_dr2_welldonesoldiermountaindi", self);
      wait(4.5);
      break;

    case 4:
      self method_860F("hub_dr2_goodlucksoldieryourebring", self);
      wait(3.5);
      break;
  }
}

func_9075() {
  wait(0.5);
  var_00 = common_scripts\utility::func_46B7("fte_guard_structs", "targetname");
  foreach(var_02 in var_00) {
    var_03 = spawn("script_model", var_02.var_0116);
    var_03.var_001D = var_02.var_001D;
    if(isDefined(var_02.var_0165)) {
      var_03 setModel(var_02.var_0165);
    } else {
      var_03 maps\mp\gametypes\_hub_unk1::func_8627();
    }

    if(isDefined(var_02.var_0EA4)) {
      var_03 method_8278(var_02.var_0EA4);
    }
  }

  var_05 = common_scripts\utility::func_46B7("fte_npc_structs", "targetname");
  foreach(var_07 in var_05) {
    var_08 = spawn("script_model", var_07.var_0116);
    var_08.var_001D = var_07.var_001D;
    if(isDefined(var_07.var_0165)) {
      var_08.var_00B9 = var_07.var_0165;
    }

    if(isDefined(var_07.var_0106)) {
      var_08.var_18A8 = var_07.var_0106;
    }

    var_08 maps\mp\gametypes\_hub_unk1::func_8627();
    var_08 method_8278(var_07.var_0EA4);
  }

  var_0A = common_scripts\utility::func_46B7("fte_section_prop", "targetname");
  level.var_3EF9 = [];
  foreach(var_0C in var_0A) {
    var_0D = spawn("script_model", var_0C.var_0116);
    var_0D.var_001D = var_0C.var_001D;
    var_0D setModel(var_0C.var_0165);
    level.var_3EF9[level.var_3EF9.size] = var_0D;
  }
}

func_A6B6() {
  wait(2);
  self freezecontrols(0);
  self method_8308(0);
}

func_2D39() {
  foreach(var_01 in level.var_3EF9) {
    var_01 delete();
  }

  level.var_3EF9 = undefined;
  foreach(var_04 in level.var_836A) {
    var_04 setplayercollision(self, 0);
  }
}

func_7FAE() {
  self setclientomnvar("ui_hub_enable_pause", 0);
  var_00 = common_scripts\utility::func_46B5("fte_waypoint_05", "targetname");
  var_01 = self.var_0116;
  var_02 = spawn("script_model", var_00.var_0116);
  var_02.var_001D = var_00.var_001D;
  var_02 setModel("s2_genericprop");
  var_03 = spawn("script_model", var_00.var_0116);
  var_03 setModel("usa_trans_willys_jeep_ai_01_no_post");
  var_04 = spawn("script_model", var_00.var_0116);
  var_04 setcostumemodels([496, 496, 0, 0, 0]);
  var_04 attach("usa_laundrybag_fte", "j_spine4");
  var_05 = spawn("script_model", var_00.var_0116);
  var_05.var_00B9 = "huba";
  var_05.var_18A8 = "hube";
  var_05 maps\mp\gametypes\_hub_unk1::func_8627();
  var_06 = spawn("script_model", var_00.var_0116);
  var_06 maps\mp\gametypes\_hub_unk1::func_8627();
  var_07 = spawn("script_model", var_00.var_0116);
  var_07 maps\mp\gametypes\_hub_unk1::func_8627();
  var_08 = spawn("script_model", var_00.var_0116);
  var_08 maps\mp\gametypes\_hub_unk1::func_8627();
  var_09 = spawn("script_model", var_00.var_0116);
  var_09 maps\mp\gametypes\_hub_unk1::func_8627();
  var_0A = spawn("script_model", var_00.var_0116);
  var_0A setModel("usa_barrage_balloon_02_fte");
  var_0B = spawn("script_model", var_00.var_0116);
  var_0B setModel("usa_barrage_balloon_02_fte");
  var_0C = spawn("script_model", var_00.var_0116);
  var_0C setModel("usa_barrage_balloon_02_fte");
  var_0D = spawn("script_model", var_00.var_0116);
  var_0D setModel("usa_fighter_thunderbolt_fade");
  var_0D setmaterialscriptparam(0, 1, 0.05);
  var_0E = spawn("script_model", var_00.var_0116);
  var_0E setModel("usa_fighter_thunderbolt_fade");
  var_0E setmaterialscriptparam(0, 1, 0.05);
  var_0F = spawn("script_model", var_00.var_0116);
  var_0F setModel("usa_fighter_thunderbolt_fade");
  var_0F setmaterialscriptparam(0, 1, 0.05);
  var_10 = spawn("script_model", var_00.var_0116);
  var_10 setModel("usa_bomber_skytrain_vista_fade");
  var_10 setmaterialscriptparam(0, 1, 0.05);
  var_11 = spawn("script_model", var_00.var_0116);
  var_11 setModel("usa_bomber_skytrain_vista_fade");
  var_11 setmaterialscriptparam(0, 1, 0.05);
  var_12 = spawn("script_model", var_00.var_0116);
  var_12 setModel("usa_bomber_skytrain_vista_fade");
  var_12 setmaterialscriptparam(0, 1, 0.05);
  var_13 = spawn("script_model", var_00.var_0116);
  var_13 setModel("usa_bomber_skytrain_vista_fade");
  var_13 setmaterialscriptparam(0, 1, 0.05);
  var_14 = spawn("script_model", var_00.var_0116);
  var_14 setModel("usa_bomber_skytrain_vista_fade");
  var_14 setmaterialscriptparam(0, 1, 0.05);
  var_15 = spawn("script_model", var_00.var_0116);
  var_15 setModel("vehicle_usa_tank_sherman_base_01");
  var_15 func_54C4("usa_tank_sherman_gun75mm_01");
  var_16 = spawn("script_model", var_00.var_0116);
  var_16 setModel("vehicle_usa_tank_sherman_base_01_raid");
  var_16 func_54C4("usa_tank_sherman_gun75mm_01_mp");
  var_17 = spawn("script_model", var_00.var_0116);
  var_17 setModel("vehicle_usa_tank_sherman_base_01");
  var_17 func_54C4("usa_tank_sherman_gun75mm_01");
  for(;;) {
    self method_808C();
    self setorigin(var_01);
    self freezecontrols(1);
    self method_81E2(var_02, "tag_origin_animated");
    self method_8483("mp_hub_allies_fte", 0);
    thread func_74BC(var_02);
    thread func_54C7();
    var_18 = getdvarint("intro_camera", 0);
    var_19 = "mp_hub_intro_camera";
    var_1A = "mp_hub_intro_jeep";
    var_1B = "mp_hub_intro_guy01";
    var_1C = "mp_hub_intro_guy02";
    var_02 method_808C();
    var_0A method_808C();
    var_0B method_808C();
    var_0C method_808C();
    var_04 method_808C();
    var_05 method_808C();
    var_04 method_805B();
    var_02 method_8495(var_19, var_00.var_0116, var_00.var_001D, "camera_anim_finished");
    var_03 method_8495(var_1A, var_00.var_0116, var_00.var_001D);
    var_04 method_8495(var_1B, var_00.var_0116, var_00.var_001D);
    var_05 method_8495(var_1C, var_00.var_0116, var_00.var_001D);
    var_06 method_8495("mp_hub_intro_guy_10", var_00.var_0116, var_00.var_001D);
    var_07 method_8495("mp_hub_intro_guy_11", var_00.var_0116, var_00.var_001D);
    var_08 method_8495("mp_hub_intro_guy_12", var_00.var_0116, var_00.var_001D);
    var_09 method_8495("mp_hub_intro_guy_13", var_00.var_0116, var_00.var_001D);
    var_0A method_8495("mp_hub_intro_barrage_balloon_01", var_00.var_0116, var_00.var_001D);
    var_0B method_8495("mp_hub_intro_barrage_balloon_02", var_00.var_0116, var_00.var_001D);
    var_0C method_8495("mp_hub_intro_barrage_balloon_03", var_00.var_0116, var_00.var_001D);
    var_0D method_8495("mp_hub_intro_plane_01", var_00.var_0116, var_00.var_001D);
    var_0E method_8495("mp_hub_intro_plane_02", var_00.var_0116, var_00.var_001D);
    var_0F method_8495("mp_hub_intro_plane_03", var_00.var_0116, var_00.var_001D);
    var_10 method_8495("mp_hub_intro_plane_04", var_00.var_0116, var_00.var_001D);
    var_11 method_8495("mp_hub_intro_plane_05", var_00.var_0116, var_00.var_001D);
    var_12 method_8495("mp_hub_intro_plane_06", var_00.var_0116, var_00.var_001D);
    var_13 method_8495("mp_hub_intro_plane_07", var_00.var_0116, var_00.var_001D);
    var_14 method_8495("mp_hub_intro_plane_08", var_00.var_0116, var_00.var_001D);
    var_15 method_8495("mp_hub_intro_tank_01", var_00.var_0116, var_00.var_001D);
    var_16 method_8495("mp_hub_intro_tank_02", var_00.var_0116, var_00.var_001D);
    var_17 method_8495("mp_hub_intro_tank_03", var_00.var_0116, var_00.var_001D);
    var_02 waittill("camera_anim_finished");
    self method_8483("mp_hub_allies", 5);
    self setclientomnvar("ui_show_fte_division_select", 1);
    self setclientomnvar("ui_hub_enable_pause", 1);
    wait(1);
    if(getdvarint("intro_anim_debug", 0) == 0) {
      break;
    }

    self setorigin(function_0236(var_04.var_0116));
    self setangles((0, 90, 0));
    var_04 method_805C();
    wait 0.05;
    self method_81E3();
    self freezecontrols(0);
    self notifyonplayercommand("reset_intro_anim", "+smoke");
    self setclientomnvar("hub_fte_reset_intro", 0);
    self waittill("reset_intro_anim");
    self setclientomnvar("hub_fte_reset_intro", 1);
  }
}

func_74BC(param_00) {
  wait(1);
  param_00 method_860F("hub_gen_thisisheadquartersyourhom", self);
  wait(15);
  param_00 method_860F("hub_gen_werewellsuppliedbutyouveg", self);
  wait(14);
  self notify("intro_vo_finished");
}

func_54C4(param_00) {
  var_01 = spawn("script_model", self.var_0116);
  var_01 setModel(param_00);
  var_01 linkto(self, "TAG_BARREL", (0, 0, 0), (0, 0, 0));
}

func_54C6() {
  for(var_00 = 0; !isDefined(self.var_93FC); var_00++) {
    iprintln(var_00);
    wait(1);
  }

  self.var_93FC = undefined;
}

func_54C7() {
  thread func_8037();
}

func_8037() {
  var_00 = func_906C(function_0236((415, 2713, -24)), (0, 175, 0));
  var_01 = spawn("script_model", (345, 2705, -32));
  var_01.var_001D = (0, 80, 0);
  var_01 setcostumemodels([510, 507, 0, 0, 0]);
  var_01 scriptmodelplayanim("mp_hub_general_idle");
  wait(5);
  var_00 scriptmodelplayanim("mp_hub_doorman_salute", "anim_end");
  var_00 waittill("anim_end");
  var_00 delete();
  var_01 delete();
}

func_21F4() {
  var_00 = func_906C(function_0236((822, 3089, -216)), (0, 90, 0));
  var_00 thread func_7F93();
  var_00 = func_906C(function_0236((631, 3069, -216)), (0, 85, 0));
  var_00 thread func_7F93();
  var_00 = func_906C(function_0236((552, 3049, -216)), (0, 85, 0));
  var_00 thread func_7F93();
  var_00 = func_906C(function_0236((520, 3032, -216)), (0, 80, 0));
  var_00 thread func_7F93();
  var_00 = func_906C(function_0236((477, 3049, -216)), (0, 80, 0));
  var_00 thread func_7F93();
  var_00 = func_906C(function_0236((168, 3183, -245)), (0, 25, 0));
  var_00 thread func_7F93();
  var_00 = func_906C(function_0236((178, 3265, -245)), (0, 15, 0));
  var_00 thread func_7F93();
  var_00 = func_906C(function_0236((168, 3307, -245)), (0, 0, 0));
  var_00 thread func_7F93();
  var_00 = func_906C(function_0236((140, 3347, -245)), (0, 15, 0));
  var_00 thread func_7F93();
  var_00 = func_906C(function_0236((166, 3374, -245)), (0, 20, 0));
  var_00 thread func_7F93();
}

func_7F93() {
  self endon("death");
  common_scripts\utility::func_2CBE(15, ::delete);
  var_00 = randomfloatrange(0, 2);
  for(;;) {
    switch (randomintrange(0, 10)) {
      case 0:
        self scriptmodelplayanim("mp_emote_cheer_onehand_fte", "anim_end", var_00);
        break;

      case 1:
        self scriptmodelplayanim("mp_emote_cheer_slow_clap_fte", "anim_end", var_00);
        break;

      case 2:
        self scriptmodelplayanim("mp_emote_cheer_twohand_fte", "anim_end", var_00);
        break;

      case 3:
        self scriptmodelplayanim("mp_emote_cheer_yeah_fte", "anim_end", var_00);
        break;

      case 4:
        self scriptmodelplayanim("mp_emote_cheer_yes_fte", "anim_end", var_00);
        break;

      case 5:
        self scriptmodelplayanim("mp_emote_clap_cheer_fte", "anim_end", var_00);
        break;

      case 6:
        self scriptmodelplayanim("mp_emote_clap_jump_fte", "anim_end", var_00);
        break;

      default:
        self scriptmodelplayanim("mp_emote_congratulate_fte", "anim_end", var_00);
        break;
    }

    var_00 = 0;
    self waittill("anim_end");
  }
}

func_8B22() {
  var_00 = func_906C((277, 3740, -369), (0, 15, 0));
  var_00 scriptmodelplayanim("mp_smg_stand_idle_ads_fte");
  var_00 common_scripts\utility::func_2CBE(15, ::delete);
  var_00 endon("death");
  var_01 = (305, 3741, -327);
  var_02 = (1333, 3852, -317);
  for(;;) {
    for(var_03 = 0; var_03 < 6; var_03++) {
      magicbullet("intro_anim_gun_mp", var_01, var_02 + common_scripts\utility::func_7A61(25, 50));
      wait(0.2);
    }

    wait(0.2);
    for(var_03 = 0; var_03 < 6; var_03++) {
      magicbullet("intro_anim_gun_mp", var_02, var_01 + common_scripts\utility::func_7A61(25, 50));
      wait(0.2);
    }
  }
}

func_1B76() {
  var_00 = func_906C(function_0236((343, 2993, -220)), (0, 175, 0));
  var_01 = func_906C(function_0236((273, 2993, -220)), (0, 5, 0));
  wait(3);
  var_00 scriptmodelplayanim("mp_emote_noway_fte");
  var_01 scriptmodelplayanim("mp_emote_boxing_fte");
  wait(5.35);
  var_00 delete();
  var_01 delete();
}

func_906C(param_00, param_01) {
  var_02 = spawn("script_model", param_00);
  var_02.var_001D = param_01;
  var_02 maps\mp\gametypes\_hub_unk1::func_8627();
  var_02 scriptmodelplayanim("mp_hub_patrol_unarmed_idle");
  return var_02;
}

func_54C8() {
  var_00 = (300, 9000, 800);
  thread func_7FAC(var_00, "usa_fighter_thunderbolt", "usa_fighter_thunderbolt_propeller");
  thread func_7FAC(var_00 + (700, 500, -30), "usa_fighter_thunderbolt", "usa_fighter_thunderbolt_propeller");
  thread func_7FAC(var_00 + (-700, 500, 25), "usa_fighter_thunderbolt", "usa_fighter_thunderbolt_propeller");
  thread func_7FAC(var_00 + (0, 1000, 400), "usa_bomber_skytrain_vista");
  thread func_7FAC(var_00 + (1200, 1700, 430), "usa_bomber_skytrain_vista");
  thread func_7FAC(var_00 + (-1200, 1700, 370), "usa_bomber_skytrain_vista");
  thread func_7FAC(var_00 + (2400, 2400, 340), "usa_bomber_skytrain_vista");
  thread func_7FAC(var_00 + (-2400, 2400, 460), "usa_bomber_skytrain_vista");
}

func_7FAC(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_00);
  var_03.var_001D = (0, 270, 5);
  var_03 setModel(param_01);
  if(isDefined(param_02)) {
    var_03 scriptmodelplayanim(param_02);
  }

  var_03 moveto(var_03.var_0116 + (0, -22500, 0), 15);
  var_03 thread func_7042();
  wait(15);
  var_03 delete();
}

func_7042() {
  self endon("death");
  wait(randomfloatrange(0, 3));
  for(;;) {
    self rotateroll(-10, 3, 0.5, 0.5);
    wait(3);
    self rotateroll(10, 3, 0.5, 0.5);
    wait(3);
  }
}

func_54CF() {
  wait(3);
  var_00 = (-2580, 1093, 32);
  thread func_7FAD(var_00);
  wait(2.25);
  thread func_7FAD(var_00);
  wait(2.25);
  thread func_7FAD(var_00);
}

func_7FAD(param_00) {
  var_01 = spawn("script_model", param_00);
  var_01.var_001D = (0, 0, 0);
  var_01 setModel("vehicle_usa_tank_sherman_base_01");
  var_01 moveto((-1700, 1093, 32), 5);
  wait(5);
  var_01 moveto((-1424, 1021, 37), 1.6);
  var_01 rotateto((0, 330, 0), 1.6);
  wait(1.6);
  var_01 moveto((-1176, 765, 35), 2);
  var_01 rotateto((0, 300, 0), 2);
  wait(2);
  var_01 moveto((-1064, 253, 46), 3);
  var_01 rotateto((0, 270, 0), 3);
  wait(3);
  var_01 moveto((-1168, -187, 36), 2.55);
  var_01 rotateto((0, 240, 0), 2.55);
  wait(2.55);
  var_01 moveto(var_01.var_0116 + rotatevector((1000, 0, 0), var_01.var_001D), 5.7);
  wait(5.7);
  var_01 delete();
}

cleanuphubtutorialents() {
  var_00 = ["intro_path_wire", "intro_path_clip", "intro_beach_wire", "intro_beach_post"];
  foreach(var_02 in var_00) {
    var_03 = getent(var_02, "targetname");
    if(isDefined(var_03)) {
      var_03 delete();
    }
  }
}