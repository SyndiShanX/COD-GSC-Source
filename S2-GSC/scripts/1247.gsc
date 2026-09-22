/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1247.gsc
**************************************/

_id_21C7() {
  var_0 = getEntArray("fte_load_guard", "targetname");
  var_1 = getEntArray("fte_npc_collision", "targetname");
  level._id_836A = getEntArray("fte_section_wall", "targetname");

  foreach(var_3 in var_0) {
    var_3 threatdetectedtoplayer(self, 0);
  }

  foreach(var_3 in var_1) {
    var_3 threatdetectedtoplayer(self, 0);
  }

  foreach(var_3 in level._id_836A) {
    var_3 threatdetectedtoplayer(self, 0);
  }

  if(!maps\mp\gametypes\_hud_util::shoulddohubtutorialflow()) {
    return;
  }
  for(;;) {
    self waittill("luinotifyserver", var_9, var_10);

    if(var_9 == "hub_fte" && isDefined(var_10) && var_10 == 5) {
      break;
    }
  }

  self._id_6AC2 = self getplayerdata(common_scripts\utility::_id_46AA(), "hubTutorialProgress", "status");

  if(!isDefined(self._id_6AC2) || self._id_6AC2 == -1) {
    self._id_6AC2 = -1;
    return;
  }

  switch (self._id_6AC2) {
    case 0:
      break;
    case 1:
      _id_7FA8();
      break;
    case 2:
      _id_7FA9();
      break;
    case 3:
      break;
    default:
      return;
  }
}

_id_7FA7() {
  setDvar("5737", 1);
  setDvar("1471", 5);
  self._id_9FB4 = 0;
  _id_7FAA();
}

_id_7FA8() {
  self._id_6AC3 = [];
  self._id_6AC3["orders"] = spawnStruct();
  self._id_6AC3["supply"] = spawnStruct();
  self._id_6AC3["payroll"] = spawnStruct();
  self._id_6AC3["orders"]._id_933D = self getplayerdata(common_scripts\utility::_id_46AA(), "hubTutorialProgress", "onboard_orders_complete");
  self._id_6AC3["supply"]._id_933D = self getplayerdata(common_scripts\utility::_id_46AA(), "hubTutorialProgress", "onboard_supply_complete");
  self._id_6AC3["payroll"]._id_933D = self getplayerdata(common_scripts\utility::_id_46AA(), "hubTutorialProgress", "onboard_payroll_complete");
  self._id_6AC3["orders"]._id_389E = "picked_up_orders";
  self._id_6AC3["supply"]._id_389E = "open_sd";
  self._id_6AC3["payroll"]._id_389E = "picked_up_payroll";
  self._id_6AC3["orders"]._id_946C = "HUB_ONB_ORDERS";
  self._id_6AC3["supply"]._id_946C = "HUB_ONB_SUPPLY";
  self._id_6AC3["payroll"]._id_946C = "HUB_ONB_PAYROLL";
  self._id_6AC3["orders"]._id_59E7 = 2;
  self._id_6AC3["supply"]._id_59E7 = 3;
  self._id_6AC3["payroll"]._id_59E7 = 4;
  self _meth_866C(&"construction_event", 12, 1, "HUB_ONB_PHASE1_HEADER", self._id_6AC3["orders"]._id_59E7, self._id_6AC3["orders"]._id_946C, self._id_6AC3["supply"]._id_59E7, self._id_6AC3["supply"]._id_946C, self._id_6AC3["payroll"]._id_59E7, self._id_6AC3["payroll"]._id_946C, 5, "LUA_MENU_XP", 750, "s2_xp_icon");
  wait 3;

  if(isDefined(self._id_6AC3["orders"]._id_933D) && self._id_6AC3["orders"]._id_933D >= 1) {
    self _meth_866C(&"gray_out_persistent_indicator", 1, self._id_6AC3["orders"]._id_59E7);
  } else {
    _id_04E0::_id_3E28(level._id_4BF3);
    thread _id_A79C();
  }

  if(isDefined(self._id_6AC3["supply"]._id_933D) && self._id_6AC3["supply"]._id_933D >= 1) {
    self _meth_866C(&"gray_out_persistent_indicator", 1, self._id_6AC3["supply"]._id_59E7);
  }

  if(isDefined(self._id_6AC3["payroll"]._id_933D) && self._id_6AC3["payroll"]._id_933D >= 1) {
    self _meth_866C(&"gray_out_persistent_indicator", 1, self._id_6AC3["payroll"]._id_59E7);
  }
}

_id_7FA9() {
  self._id_6AC3 = [];
  self._id_6AC3["collection"] = spawnStruct();
  self._id_6AC3["streak"] = spawnStruct();
  self._id_6AC3["commend"] = spawnStruct();
  self._id_6AC3["collection"]._id_933D = self getplayerdata(common_scripts\utility::_id_46AA(), "hubTutorialProgress", "onboard_collection_complete");
  self._id_6AC3["streak"]._id_933D = self getplayerdata(common_scripts\utility::_id_46AA(), "hubTutorialProgress", "onboard_scorestreak_complete");
  self._id_6AC3["commend"]._id_933D = self getplayerdata(common_scripts\utility::_id_46AA(), "hubTutorialProgress", "onboard_commend_complete");
  self._id_6AC3["collection"]._id_389E = "";
  self._id_6AC3["streak"]._id_389E = "";
  self._id_6AC3["commend"]._id_389E = "commend_player";
  self._id_6AC3["collection"]._id_946C = "HUB_ONB_COLLECTION";
  self._id_6AC3["streak"]._id_946C = "HUB_ONB_SCORESTREAK";
  self._id_6AC3["commend"]._id_946C = "HUB_ONB_COMMEND";
  self._id_6AC3["collection"]._id_59E7 = 2;
  self._id_6AC3["streak"]._id_59E7 = 3;
  self._id_6AC3["commend"]._id_59E7 = 4;
  self _meth_866C(&"construction_event", 12, 1, "HUB_ONB_PHASE2_HEADER", self._id_6AC3["collection"]._id_59E7, self._id_6AC3["collection"]._id_946C, self._id_6AC3["streak"]._id_59E7, self._id_6AC3["streak"]._id_946C, self._id_6AC3["commend"]._id_59E7, self._id_6AC3["commend"]._id_946C, 5, "LUA_MENU_XP", 750, "s2_xp_icon");
  wait 3;

  if(isDefined(self._id_6AC3["collection"]._id_933D) && self._id_6AC3["collection"]._id_933D >= 1) {
    self _meth_866C(&"gray_out_persistent_indicator", 1, self._id_6AC3["collection"]._id_59E7);
  }

  if(isDefined(self._id_6AC3["streak"]._id_933D) && self._id_6AC3["streak"]._id_933D >= 1) {
    self _meth_866C(&"gray_out_persistent_indicator", 1, self._id_6AC3["streak"]._id_59E7);
  }

  if(isDefined(self._id_6AC3["commend"]._id_933D) && self._id_6AC3["commend"]._id_933D >= 1) {
    self _meth_866C(&"gray_out_persistent_indicator", 1, self._id_6AC3["commend"]._id_59E7);
  }
}

_id_A79C() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "hub_fte") {
      continue;
    }
    switch (var_1) {
      case 69:
        _id_04E0::_id_3E15(level._id_4BF3);
        break;
      default:
        break;
    }
  }
}

_id_7FAA() {
  level._effect["tutorial_path"] = loadfx("vfx/unique/hardpoint_chevron_friendly_vertical");
  waitframe();
  thread _id_9075();
  thread _id_77C7();
  thread _id_63B0();
  self setclienttriggervisionset("mp_hub_allies_fte", 0);
  thread _id_7FAE();
  thread _id_6380();
}

_id_6461() {
  waitframe();
  setDvar("712", 1);
  setDvar("r_mbVeliocityScaler", 100);
  setDvar("5469", 1);
  setDvar("904", 1);
  setDvar("2032", "1");
  setDvar("3161", ".3");
  setDvar("r_vignettefalloff", "1.2");
}

_id_6460() {
  setDvar("712", 0);
  setDvar("3161", ".35");
  setDvar("r_vignettefalloff", "1.2");
  setDvar("2032", "0");
}

_id_8BE4() {
  var_0 = common_scripts\utility::_id_46B7("org_tutorial_path", "targetname");

  if(!isDefined(var_0) || var_0.size == 0) {
    return;
  }
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = common_scripts\utility::_id_8FFC();
    var_4.origin = var_3.origin;
    var_4.angles = var_3.angles;
    var_4 show();
    var_1[var_1.size] = var_4;
    _playfxontagforclients(common_scripts\utility::_id_44F5("tutorial_path"), var_4, "tag_origin", self);
  }

  return var_1;
}

_id_4CFB(var_0) {
  foreach(var_2 in var_0) {
    _stopfxontagforclient(common_scripts\utility::_id_44F5("tutorial_path"), var_2, "tag_origin", self);
    var_2 delete();
  }
}

_id_63B9() {
  self endon("disconnect");
  level endon("game_ended");
  _id_04E0::_id_3E28(level._id_4BF3);

  while(_id_21B0(300) == 0) {
    wait 1;
  }

  self notify("followSequenceOver");
  self waittill("playerLeftRequisitions");
  self _meth_866C(&"gray_out_persistent_indicator", 1, 2);
  thread _id_2CD3(1.5, "remove", 1, 2);
  thread _id_2CD3(1, "headerremove", 1, 10);
  thread _id_2CD3(2.5, "headeradd", 2, 11, "HUB_FTE_HEADER2");
  thread _id_2CD3(3, "add", 2, 3, "HUB_FTE_PAYROLL");
  thread _id_2CD3(3.5, "add", 2, 4, "HUB_FTE_RANGE");
  _id_04E0::_id_A04C();
  _id_04E0::_id_3E1F(level._id_4BF3);
  self notify("opsDone");
}

_id_63B0() {
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "hub_fte") {
      continue;
    }
    if(var_1 == -1) {}

    switch (var_1) {
      case 8:
        break;
      default:
        break;
    }
  }
}

_id_77C7() {
  foreach(var_1 in level._id_4F51) {
    _id_04E0::_id_3E1F(var_1);
  }
}

_id_7B78() {
  _id_04E0::_id_3E28(level._id_5F83);
  _id_04E0::_id_3E28(level._id_3C3E);
}

_id_8A1C() {
  waitframe();
  var_0 = common_scripts\utility::_id_46B5("firing_range_vendor", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 _meth_84C7([497, 497, 0, 0, 0]);
  var_1 scriptmodelplayanim("mp_hub_patrol_unarmed_idle");
  return var_1;
}

_id_4ABE(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    while(self._id_5721) {
      wait 10;
    }

    wait 5;
  }
}

_id_2CD3(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  level endon("game_ended");
  wait(var_0);

  switch (var_1) {
    case "add":
      self _meth_866C(&"add_persistent_indicator", var_2, var_3, var_4);
      break;
    case "remove":
      self _meth_866C(&"remove_persistent_indicator", var_2, var_3);
      break;
    case "gray":
      self _meth_866C(&"gray_out_persistent_indicator", var_2, var_3);
      break;
    case "headeradd":
      self _meth_866C(&"add_persistent_indicator_header", var_2, var_3, var_4);
      break;
    case "headerremove":
      self _meth_866C(&"remove_persistent_indicator_header", var_2, var_3);
    default:
      break;
  }
}

_id_63F1() {
  if(!isDefined(self._id_3EF8)) {
    self._id_3EF8 = 0;
  }

  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    self waittill("luinotifyserver", var_5, var_6);

    if(var_5 != "hub_fte") {
      continue;
    }
    if(var_6 == -1) {}

    switch (var_6) {
      case 2:
        if(!var_3) {
          self._id_3EF8++;
        }

        var_3 = 1;
        break;
      case 3:
        if(!var_4) {
          self._id_3EF8++;
        }

        var_4 = 1;
        break;
      case 4:
        _id_04E0::_id_3E1F(level._id_5F83);
        self _meth_866C(&"gray_out_persistent_indicator", 1, 3);
        var_0++;
        break;
      case 5:
        self _meth_866C(&"gray_out_persistent_indicator", 1, 4);
        _id_04E0::_id_3E1F(level._id_3C3E);
        var_0++;
        break;
      default:
        break;
    }

    if(self._id_3EF8 == 2) {
      self _meth_866C(&"remove_persistent_indicator", 1, 6);
      thread _id_2CD3(1, "headerremove", 1, 11);
      thread _id_2CD3(4, "headeradd", 2, 12, "HUB_FTE_HEADER3");
      thread _id_2CD3(5, "add", 2, 5, "HUB_FTE_LOBBY");
      setDvar("1471", 5);
      self _meth_85EF(&"fte_lobby_open", 0);
      return;
    }

    if(var_0 == 2 && !var_1) {
      thread _id_2CD3(2.3, "remove", 1, 3);
      thread _id_2CD3(2.6, "remove", 1, 4);
      thread _id_2CD3(4, "add", 2, 6, "HUB_FTE_REDEEM_ORDERS");
      setDvar("1471", 5);
      var_1 = 1;
    }
  }
}

_id_6398() {
  self waittill("playerLeftQuartermaster");
  _id_04E0::_id_3E15(level._id_781C);
}

_id_92D4() {
  var_0 = common_scripts\utility::_id_46B5("fte_waypoint_05", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1 _id_04E0::clientclearsoundsubmix();
  var_2 = spawn("script_model", var_0.origin);
  var_2 _id_04E0::clientclearsoundsubmix();
  var_3 = spawn("script_model", var_0.origin);
  var_3 _id_04E0::clientclearsoundsubmix();
  var_4 = spawn("script_model", var_0.origin);
  var_4 _id_04E0::clientclearsoundsubmix();
  var_5 = spawn("script_model", var_0.origin);
  var_5 _id_04E0::clientclearsoundsubmix();
  self._id_54C5.origin = var_0.origin;
  self._id_54C5.angles = var_0.angles;
  var_1 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt01_guy_01", var_0.origin, var_0.angles, "animEnded");
  var_2 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt01_guy_02", var_0.origin, var_0.angles, "animEnded");
  var_3 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt01_guy_03", var_0.origin, var_0.angles, "animEnded");
  var_4 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt01_guy_04", var_0.origin, var_0.angles, "animEnded");
  var_5 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt01_guy_05", var_0.origin, var_0.angles, "animEnded");
  self._id_54C5 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt01_camera", var_0.origin, var_0.angles, "animEnded");
  var_1 waittill("animEnded");
  var_1 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt03_guy_01", var_0.origin, var_0.angles, "animEnded");
  var_2 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt03_guy_02", var_0.origin, var_0.angles, "animEnded");
  var_3 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt03_guy_04", var_0.origin, var_0.angles, "animEnded");
  var_4 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt03_guy_03", var_0.origin, var_0.angles, "animEnded");
  var_5 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt03_guy_05", var_0.origin, var_0.angles, "animEnded");
  self._id_54C5 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt03_camera", var_0.origin, var_0.angles, "animEnded");
  var_1 waittillmatch("animEnded", "end");
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_4 delete();
  var_5 delete();
}

_id_8A3E() {
  var_0 = common_scripts\utility::_id_46B5("fte_waypoint_05", "targetname");
  level._id_7B46 = spawn("script_model", var_0.origin);
  level._id_7B46 _meth_84C7([498, 498, 0, 0, 0]);
  level._id_7B46 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt01_sergeant", var_0.origin, var_0.angles, "animEnded");
  level._id_7B46 waittill("animEnded");
  level._id_7B46 scriptmodelplayanimdeltamotionfrompos("mp_hub_rco_arrival_pt03_sergeant", var_0.origin, var_0.angles, "animEnded");
}

_id_5428() {
  wait 2;
  level._id_7B46 scriptmodelclearanim();
}

_id_2D4A() {
  if(isDefined(level._id_7B46._id_6CA2)) {
    level._id_7B46._id_6CA2 destroy();
  }

  level._id_7B46 delete();
}

_id_21B1(var_0, var_1) {
  var_2 = distance(self.origin, level._id_93F7[var_1].origin);

  if(var_2 > var_0) {
    return 0;
  } else {
    return 1;
  }
}

_id_21B0(var_0) {
  var_1 = distance(self.origin, level._id_4BF3.origin);

  if(var_1 > var_0) {
    return 0;
  } else {
    return 1;
  }
}

_id_4AEA(var_0, var_1, var_2) {
  level._id_7B46 scriptmodelplayanimdeltamotionfrompos(level._id_7A90[var_1], var_2.origin, var_2.angles, "animEnded");
  var_3 = 10;
  var_4 = 0;

  while(!_id_21B1(var_0, var_1)) {
    wait 1;
  }

  self notify("backInRangeOfRecruitment");
}

_id_74D1() {
  self endon("backInRangeOfRecruitment");
  self endon("disconnect");
  self endon("tutorialShortcut");
  var_0 = ["Let's get moving, soldier!", "We've got a war to fight. Get moving, private!", "Over here! Let's get going.", "Stay on track, private. Follow me.", "I've got places to be, let's GO!", "Do I need to hold your hand, private? Get over here.", "Soldier, get back over here. We have work to do."];

  for(;;) {
    self iprintlnbold(common_scripts\utility::random(var_0));
    wait 10;
  }
}

_id_6380() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "hub_character_selection") {
      break;
    }
  }

  if(!_id_04CA::_id_56CC(var_1)) {
    self iprintlnbold("INVALID DIVISION SELECTED");
  } else {
    var_2 = _id_04CA::_id_4498(var_1);

    if(isDefined(var_2)) {
      thread maps\mp\gametypes\_hud_message::_id_9102(var_2);
    }

    self._id_9FB3 = var_1;
    self._id_267E = _func_333(var_1, 1);
    self _meth_84C7(self._id_267E);
    _id_04E0::_id_115E();
    _id_0378::_id_8D74("start_hub_music");
    thread _id_7214(var_1);
  }

  _id_04E0::_id_A04C();
  self freezecontrols(0);
  self._id_9FB4 = 2;
  setDvar("1471", 5);
  _id_0468::_id_0A1F();
}

_id_7214(var_0) {
  self endon("disconnect");
  wait 2;

  switch (var_0) {
    case 0:
      self playsoundtoplayer("hub_dr2_goodchoicesoldierinfantry", self);
      wait 4;
      break;
    case 1:
      self playsoundtoplayer("hub_dr2_nicechoicesoldierairborne", self);
      wait 4;
      break;
    case 2:
      self playsoundtoplayer("hub_dr2_bolddecisionyouwillbringt", self);
      wait 4;
      break;
    case 3:
      self playsoundtoplayer("hub_dr2_welldonesoldiermountaindi", self);
      wait 4.5;
      break;
    case 4:
      self playsoundtoplayer("hub_dr2_goodlucksoldieryourebring", self);
      wait 3.5;
      break;
  }
}

_id_9075() {
  wait 0.5;
  var_0 = common_scripts\utility::_id_46B7("fte_guard_structs", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3.angles = var_2.angles;

    if(isDefined(var_2._id_0165)) {
      var_3 setModel(var_2._id_0165);
    } else {
      var_3 _id_04E0::clientclearsoundsubmix();
    }

    if(isDefined(var_2.animation)) {
      var_3 scriptmodelplayanimdeltamotion(var_2.animation);
    }
  }

  var_5 = common_scripts\utility::_id_46B7("fte_npc_structs", "targetname");

  foreach(var_7 in var_5) {
    var_8 = spawn("script_model", var_7.origin);
    var_8.angles = var_7.angles;

    if(isDefined(var_7._id_0165)) {
      var_8._id_00B9 = var_7._id_0165;
    }

    if(isDefined(var_7.model)) {
      var_8._id_18A8 = var_7.model;
    }

    var_8 _id_04E0::clientclearsoundsubmix();
    var_8 scriptmodelplayanimdeltamotion(var_7.animation);
  }

  var_10 = common_scripts\utility::_id_46B7("fte_section_prop", "targetname");
  level._id_3EF9 = [];

  foreach(var_12 in var_10) {
    var_13 = spawn("script_model", var_12.origin);
    var_13.angles = var_12.angles;
    var_13 setModel(var_12._id_0165);
    level._id_3EF9[level._id_3EF9.size] = var_13;
  }
}

_id_A6B6() {
  wait 2;
  self freezecontrols(0);
  self allowsprint(0);
}

_id_2D39() {
  foreach(var_1 in level._id_3EF9) {
    var_1 delete();
  }

  level._id_3EF9 = undefined;

  foreach(var_4 in level._id_836A) {
    var_4 threatdetectedtoplayer(self, 0);
  }
}

_id_7FAE() {
  self setclientomnvar("ui_hub_enable_pause", 0);
  var_0 = common_scripts\utility::_id_46B5("fte_waypoint_05", "targetname");
  var_1 = self.origin;
  var_2 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_2 setModel("s2_genericprop");
  var_3 = spawn("script_model", var_0.origin);
  var_3 setModel("usa_trans_willys_jeep_ai_01_no_post");
  var_4 = spawn("script_model", var_0.origin);
  var_4 _meth_84C7([496, 496, 0, 0, 0]);
  var_4 attach("usa_laundrybag_fte", "j_spine4");
  var_5 = spawn("script_model", var_0.origin);
  var_5._id_00B9 = "huba";
  var_5._id_18A8 = "hube";
  var_5 _id_04E0::clientclearsoundsubmix();
  var_6 = spawn("script_model", var_0.origin);
  var_6 _id_04E0::clientclearsoundsubmix();
  var_7 = spawn("script_model", var_0.origin);
  var_7 _id_04E0::clientclearsoundsubmix();
  var_8 = spawn("script_model", var_0.origin);
  var_8 _id_04E0::clientclearsoundsubmix();
  var_9 = spawn("script_model", var_0.origin);
  var_9 _id_04E0::clientclearsoundsubmix();
  var_10 = spawn("script_model", var_0.origin);
  var_10 setModel("usa_barrage_balloon_02_fte");
  var_11 = spawn("script_model", var_0.origin);
  var_11 setModel("usa_barrage_balloon_02_fte");
  var_12 = spawn("script_model", var_0.origin);
  var_12 setModel("usa_barrage_balloon_02_fte");
  var_13 = spawn("script_model", var_0.origin);
  var_13 setModel("usa_fighter_thunderbolt_fade");
  var_13 _meth_8450(0, 1, 0.05);
  var_14 = spawn("script_model", var_0.origin);
  var_14 setModel("usa_fighter_thunderbolt_fade");
  var_14 _meth_8450(0, 1, 0.05);
  var_15 = spawn("script_model", var_0.origin);
  var_15 setModel("usa_fighter_thunderbolt_fade");
  var_15 _meth_8450(0, 1, 0.05);
  var_16 = spawn("script_model", var_0.origin);
  var_16 setModel("usa_bomber_skytrain_vista_fade");
  var_16 _meth_8450(0, 1, 0.05);
  var_17 = spawn("script_model", var_0.origin);
  var_17 setModel("usa_bomber_skytrain_vista_fade");
  var_17 _meth_8450(0, 1, 0.05);
  var_18 = spawn("script_model", var_0.origin);
  var_18 setModel("usa_bomber_skytrain_vista_fade");
  var_18 _meth_8450(0, 1, 0.05);
  var_19 = spawn("script_model", var_0.origin);
  var_19 setModel("usa_bomber_skytrain_vista_fade");
  var_19 _meth_8450(0, 1, 0.05);
  var_20 = spawn("script_model", var_0.origin);
  var_20 setModel("usa_bomber_skytrain_vista_fade");
  var_20 _meth_8450(0, 1, 0.05);
  var_21 = spawn("script_model", var_0.origin);
  var_21 setModel("vehicle_usa_tank_sherman_base_01");
  var_21 _id_54C4("usa_tank_sherman_gun75mm_01");
  var_22 = spawn("script_model", var_0.origin);
  var_22 setModel("vehicle_usa_tank_sherman_base_01_raid");
  var_22 _id_54C4("usa_tank_sherman_gun75mm_01_mp");
  var_23 = spawn("script_model", var_0.origin);
  var_23 setModel("vehicle_usa_tank_sherman_base_01");
  var_23 _id_54C4("usa_tank_sherman_gun75mm_01");

  for(;;) {
    self dontinterpolate();
    self setOrigin(var_1);
    self freezecontrols(1);
    self cameralinkTo(var_2, "tag_origin_animated");
    self setclienttriggervisionset("mp_hub_allies_fte", 0);
    thread _id_74BC(var_2);
    thread _id_54C7();
    var_24 = getdvarint("intro_camera", 0);
    var_25 = "mp_hub_intro_camera";
    var_26 = "mp_hub_intro_jeep";
    var_27 = "mp_hub_intro_guy01";
    var_28 = "mp_hub_intro_guy02";
    var_2 dontinterpolate();
    var_10 dontinterpolate();
    var_11 dontinterpolate();
    var_12 dontinterpolate();
    var_4 dontinterpolate();
    var_5 dontinterpolate();
    var_4 show();
    var_2 scriptmodelplayanimdeltamotionfrompos(var_25, var_0.origin, var_0.angles, "camera_anim_finished");
    var_3 scriptmodelplayanimdeltamotionfrompos(var_26, var_0.origin, var_0.angles);
    var_4 scriptmodelplayanimdeltamotionfrompos(var_27, var_0.origin, var_0.angles);
    var_5 scriptmodelplayanimdeltamotionfrompos(var_28, var_0.origin, var_0.angles);
    var_6 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_guy_10", var_0.origin, var_0.angles);
    var_7 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_guy_11", var_0.origin, var_0.angles);
    var_8 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_guy_12", var_0.origin, var_0.angles);
    var_9 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_guy_13", var_0.origin, var_0.angles);
    var_10 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_barrage_balloon_01", var_0.origin, var_0.angles);
    var_11 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_barrage_balloon_02", var_0.origin, var_0.angles);
    var_12 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_barrage_balloon_03", var_0.origin, var_0.angles);
    var_13 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_plane_01", var_0.origin, var_0.angles);
    var_14 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_plane_02", var_0.origin, var_0.angles);
    var_15 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_plane_03", var_0.origin, var_0.angles);
    var_16 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_plane_04", var_0.origin, var_0.angles);
    var_17 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_plane_05", var_0.origin, var_0.angles);
    var_18 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_plane_06", var_0.origin, var_0.angles);
    var_19 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_plane_07", var_0.origin, var_0.angles);
    var_20 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_plane_08", var_0.origin, var_0.angles);
    var_21 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_tank_01", var_0.origin, var_0.angles);
    var_22 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_tank_02", var_0.origin, var_0.angles);
    var_23 scriptmodelplayanimdeltamotionfrompos("mp_hub_intro_tank_03", var_0.origin, var_0.angles);
    var_2 waittill("camera_anim_finished");
    self setclienttriggervisionset("mp_hub_allies", 5);
    self setclientomnvar("ui_show_fte_division_select", 1);
    self setclientomnvar("ui_hub_enable_pause", 1);
    wait 1;

    if(getdvarint("intro_anim_debug", 0) == 0) {
      break;
    }

    self setOrigin(_droptoground(var_4.origin));
    self setplayerangles((0, 90, 0));
    var_4 hide();
    waitframe();
    self cameraunlink();
    self freezecontrols(0);
    self notifyonplayercommand("reset_intro_anim", "+smoke");
    self setclientomnvar("hub_fte_reset_intro", 0);
    self waittill("reset_intro_anim");
    self setclientomnvar("hub_fte_reset_intro", 1);
  }
}

_id_74BC(var_0) {
  wait 1;
  var_0 playsoundtoplayer("hub_gen_thisisheadquartersyourhom", self);
  wait 15;
  var_0 playsoundtoplayer("hub_gen_werewellsuppliedbutyouveg", self);
  wait 14;
  self notify("intro_vo_finished");
}

_id_54C4(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1 setModel(var_0);
  var_1 linkTo(self, "TAG_BARREL", (0, 0, 0), (0, 0, 0));
}

_id_54C6() {
  for(var_0 = 0; !isDefined(self._id_93FC); var_0++) {
    _iprintln(var_0);
    wait 1;
  }

  self._id_93FC = undefined;
}

_id_54C7() {
  thread getvalidcoverpeekouts();
}

getvalidcoverpeekouts() {
  var_0 = _id_906C(_droptoground((415, 2713, -24)), (0, 175, 0));
  var_1 = spawn("script_model", (345, 2705, -32));
  var_1.angles = (0, 80, 0);
  var_1 _meth_84C7([510, 507, 0, 0, 0]);
  var_1 scriptmodelplayanim("mp_hub_general_idle");
  wait 5;
  var_0 scriptmodelplayanim("mp_hub_doorman_salute", "anim_end");
  var_0 waittill("anim_end");
  var_0 delete();
  var_1 delete();
}

_id_21F4() {
  var_0 = _id_906C(_droptoground((822, 3089, -216)), (0, 90, 0));
  var_0 thread _id_7F93();
  var_0 = _id_906C(_droptoground((631, 3069, -216)), (0, 85, 0));
  var_0 thread _id_7F93();
  var_0 = _id_906C(_droptoground((552, 3049, -216)), (0, 85, 0));
  var_0 thread _id_7F93();
  var_0 = _id_906C(_droptoground((520, 3032, -216)), (0, 80, 0));
  var_0 thread _id_7F93();
  var_0 = _id_906C(_droptoground((477, 3049, -216)), (0, 80, 0));
  var_0 thread _id_7F93();
  var_0 = _id_906C(_droptoground((168, 3183, -245)), (0, 25, 0));
  var_0 thread _id_7F93();
  var_0 = _id_906C(_droptoground((178, 3265, -245)), (0, 15, 0));
  var_0 thread _id_7F93();
  var_0 = _id_906C(_droptoground((168, 3307, -245)), (0, 0, 0));
  var_0 thread _id_7F93();
  var_0 = _id_906C(_droptoground((140, 3347, -245)), (0, 15, 0));
  var_0 thread _id_7F93();
  var_0 = _id_906C(_droptoground((166, 3374, -245)), (0, 20, 0));
  var_0 thread _id_7F93();
}

_id_7F93() {
  self endon("death");
  common_scripts\utility::_id_2CBE(15, ::delete);
  var_0 = _randomfloatrange(0, 2);

  for(;;) {
    switch (_randomintrange(0, 10)) {
      case 0:
        self scriptmodelplayanim("mp_emote_cheer_onehand_fte", "anim_end", var_0);
        break;
      case 1:
        self scriptmodelplayanim("mp_emote_cheer_slow_clap_fte", "anim_end", var_0);
        break;
      case 2:
        self scriptmodelplayanim("mp_emote_cheer_twohand_fte", "anim_end", var_0);
        break;
      case 3:
        self scriptmodelplayanim("mp_emote_cheer_yeah_fte", "anim_end", var_0);
        break;
      case 4:
        self scriptmodelplayanim("mp_emote_cheer_yes_fte", "anim_end", var_0);
        break;
      case 5:
        self scriptmodelplayanim("mp_emote_clap_cheer_fte", "anim_end", var_0);
        break;
      case 6:
        self scriptmodelplayanim("mp_emote_clap_jump_fte", "anim_end", var_0);
        break;
      default:
        self scriptmodelplayanim("mp_emote_congratulate_fte", "anim_end", var_0);
        break;
    }

    var_0 = 0;
    self waittill("anim_end");
  }
}

_id_8B22() {
  var_0 = _id_906C((277, 3740, -369), (0, 15, 0));
  var_0 scriptmodelplayanim("mp_smg_stand_idle_ads_fte");
  var_0 common_scripts\utility::_id_2CBE(15, ::delete);
  var_0 endon("death");
  var_1 = (305, 3741, -327);
  var_2 = (1333, 3852, -317);

  for(;;) {
    for(var_3 = 0; var_3 < 6; var_3++) {
      _magicbullet("intro_anim_gun_mp", var_1, var_2 + common_scripts\utility::_id_7A61(25, 50));
      wait 0.2;
    }

    wait 0.2;

    for(var_3 = 0; var_3 < 6; var_3++) {
      _magicbullet("intro_anim_gun_mp", var_2, var_1 + common_scripts\utility::_id_7A61(25, 50));
      wait 0.2;
    }
  }
}

_id_1B76() {
  var_0 = _id_906C(_droptoground((343, 2993, -220)), (0, 175, 0));
  var_1 = _id_906C(_droptoground((273, 2993, -220)), (0, 5, 0));
  wait 3;
  var_0 scriptmodelplayanim("mp_emote_noway_fte");
  var_1 scriptmodelplayanim("mp_emote_boxing_fte");
  wait 5.35;
  var_0 delete();
  var_1 delete();
}

_id_906C(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 _id_04E0::clientclearsoundsubmix();
  var_2 scriptmodelplayanim("mp_hub_patrol_unarmed_idle");
  return var_2;
}

_id_54C8() {
  var_0 = (300, 9000, 800);
  thread _id_7FAC(var_0, "usa_fighter_thunderbolt", "usa_fighter_thunderbolt_propeller");
  thread _id_7FAC(var_0 + (700, 500, -30), "usa_fighter_thunderbolt", "usa_fighter_thunderbolt_propeller");
  thread _id_7FAC(var_0 + (-700, 500, 25), "usa_fighter_thunderbolt", "usa_fighter_thunderbolt_propeller");
  thread _id_7FAC(var_0 + (0, 1000, 400), "usa_bomber_skytrain_vista");
  thread _id_7FAC(var_0 + (1200, 1700, 430), "usa_bomber_skytrain_vista");
  thread _id_7FAC(var_0 + (-1200, 1700, 370), "usa_bomber_skytrain_vista");
  thread _id_7FAC(var_0 + (2400, 2400, 340), "usa_bomber_skytrain_vista");
  thread _id_7FAC(var_0 + (-2400, 2400, 460), "usa_bomber_skytrain_vista");
}

_id_7FAC(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3.angles = (0, 270, 5);
  var_3 setModel(var_1);

  if(isDefined(var_2)) {
    var_3 scriptmodelplayanim(var_2);
  }

  var_3 moveTo(var_3.origin + (0, -22500, 0), 15);
  var_3 thread _id_7042();
  wait 15;
  var_3 delete();
}

_id_7042() {
  self endon("death");
  wait(_randomfloatrange(0, 3.0));

  for(;;) {
    self rotateroll(-10, 3, 0.5, 0.5);
    wait 3;
    self rotateroll(10, 3, 0.5, 0.5);
    wait 3;
  }
}

_id_54CF() {
  wait 3;
  var_0 = (-2580, 1093, 32);
  thread _id_7FAD(var_0);
  wait 2.25;
  thread _id_7FAD(var_0);
  wait 2.25;
  thread _id_7FAD(var_0);
}

_id_7FAD(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1.angles = (0, 0, 0);
  var_1 setModel("vehicle_usa_tank_sherman_base_01");
  var_1 moveTo((-1700, 1093, 32), 5);
  wait 5;
  var_1 moveTo((-1424, 1021, 37), 1.6);
  var_1 rotateTo((0, 330, 0), 1.6);
  wait 1.6;
  var_1 moveTo((-1176, 765, 35), 2);
  var_1 rotateTo((0, 300, 0), 2);
  wait 2;
  var_1 moveTo((-1064, 253, 46), 3);
  var_1 rotateTo((0, 270, 0), 3);
  wait 3;
  var_1 moveTo((-1168, -187, 36), 2.55);
  var_1 rotateTo((0, 240, 0), 2.55);
  wait 2.55;
  var_1 moveTo(var_1.origin + _rotatevector((1000, 0, 0), var_1.angles), 5.7);
  wait 5.7;
  var_1 delete();
}

cleanuphubtutorialents() {
  var_0 = ["intro_path_wire", "intro_path_clip", "intro_beach_wire", "intro_beach_post"];

  foreach(var_2 in var_0) {
    var_3 = _getEnt(var_2, "targetname");

    if(isDefined(var_3)) {
      var_3 delete();
    }
  }
}