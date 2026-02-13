/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_hstg.gsc
*************************************************/

main() {
  _id_997B();
  _id_07DC::init();
  _id_07DC::_id_D854();
  _id_997C();
  level._id_E6A1 = 0;
  level._id_ABAD = ::_id_ABAD;
}

_id_997A() {
  _id_997B();
  _id_997C();
  level._id_E6A1 = 1;
  _id_ABAD();
}

_id_997B() {
  level._id_ED22 = "to_hstg";
  level._id_41D2 = "to_hstg";
  setomnvar("ui_tac_ops_submode", level._id_41D2);
}

_id_997C() {
  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA("to_hstg", 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1("to_hstg", 10);
    scripts\mp\utility\game::_id_C2AD("to_hstg", 85);
    scripts\mp\utility\game::_id_C2A9("to_hstg", 1);
    scripts\mp\utility\game::_id_C2D0("to_hstg", 1);
    scripts\mp\utility\game::_id_C27E("to_hstg", 0);
    scripts\mp\utility\game::_id_C25D("to_hstg", 0);
    scripts\mp\utility\game::_id_C250("to_hstg", 0);
  }

  _id_FC7D();
  _id_D881();
  level._id_C63F = 1;
  level._id_E2B9 = 0;
  scripts\mp\gametypes\obj_grindzone::init();
  level.teambased = 1;
  level.onplayerconnect = ::onplayerconnect;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;
  level._id_ABB3 = ::_id_ABB3;
  level._id_ABC0 = ::_id_ABC0;
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3472627abdb7b65ed", getmatchrulesdata("grindData", "bankTime"));
  setdynamicdvar("#x3e5fb144086d445de", getmatchrulesdata("grindData", "bankRate"));
  setdynamicdvar("#x369d1f8da7f09f737", getmatchrulesdata("grindData", "bankCaptureTime"));
  setdynamicdvar("#x3410721ead5b2fcf1", getmatchrulesdata("grindData", "megaBankLimit"));
  setdynamicdvar("#x3619cefa937fa3663", getmatchrulesdata("grindData", "megaBankBonus"));
  setdynamicdvar("#x32509cbc62a413e06", 0);
  scripts\mp\utility\game::_id_C25D("to_hstg", 0);
  setdynamicdvar("#x358eced7f753934be", 0);
}

_id_D5AD() {
  level._id_10CCD["waypoint_capture_recover"] = "neutral";
  level._id_10CCC["waypoint_capture_recover"] = 1;
  level._id_10CCD["koth_enemy"] = "enemy";
  level._id_10CCC["koth_enemy"] = 1;
  level._id_7C8A = "waypoint_hardpoint_target";
  level._id_7C74 = "koth_neutral";
  level._id_7C42 = "koth_enemy";
  level._id_7C4B = "koth_friendly";
  level._id_7C48 = "waypoint_hardpoint_contested";
  level._id_7C87 = "waypoint_taking_chevron";
  level._id_7C6F = "waypoint_hardpoint_losing";
  level._id_7C40 = "waypoint_target";
  level._id_7C41 = "waypoint_defend";
  level._id_7C80 = "waypoint_capture_recover";
  level._id_7C55 = "waypoint_escort";
  level._id_7C4F = "waypoint_defend_round";
  level._id_7C6A = "waypoint_capture_kill_round";
}

_id_ABAD() {
  _id_4073();
  _id_D5AD();
  scripts\mp\tac_ops\hostage_utility::_id_7AA0();
  setDvar("#x321708ee64937f75e", 0.75);
  level._id_110E3 = 120;
  level._id_7A9D = [];
  level._id_7A8B = [];
  level._id_44D5 = 1;
  _id_3FF6();
  level._id_5837 = getent("hvtExtractionLoc", "targetname");
  level._id_7A8C = [];
  level._id_7A8C[0] = ::scripts\engine\utility::getstructarray("hostage_waypoint_1", "targetname");
  level._id_7A8C[1] = ::scripts\engine\utility::getstructarray("hostage_waypoint_2", "targetname");
  level._id_7A8C[2] = ::scripts\engine\utility::getstructarray("hostage_waypoint_3", "targetname");
  thread _id_3FF7();
  level._id_7A92 = [];
  level._id_7A92[0] = level._id_7C24;
  level._id_7A90 = [];
  level._id_7A90[0] = level._id_A8E8[0];
  scripts\mp\tac_ops\hostage_utility::_id_E262();
  level._id_7A96[0]._id_ACE5 = scripts\mp\utility\outline::_id_ACD2(level._id_7A96[0]._id_25CA, level._id_7A96[0].team, "outline_nodepth_cyan", "killstreak_personal");
  setDvar("#x321708ee64937f75e", 0.75);
  level._id_110E3 = 120;
  level._id_7A9D = [];
  level._id_7A8B = [];
  level._id_44D5 = 1;
  level._id_A8E8[0] _id_07D6::_id_D5C5(level._id_7A96[0]);
  level._id_5BEC = [];
  level._id_5BEC[0] = level._id_A8E8[0];
  _id_81E2();
  level thread _id_10BEC();

  if(!istrue(level._id_E6A1)) {
    var_0[0] = "dom";
    _id_07D6::main(var_0);
    scripts\mp\gametypes\tac_ops::_id_3AE4();
    _id_0EFE();
  }

  var_1 = scripts\mp\utility\game::_id_6DE5();
  level._id_5856 = 0;
  scripts\mp\utility\dvars::_id_D633("timelimit", 6);
  level._id_ED23 = 1;
}

_id_D8CD(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.team != var_0) {
      self disableplayeruse(var_2);
      continue;
    }

    self _meth_80E0(var_2);
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_21DC = scripts\mp\utility\dvars::_id_509A("bankTime", 2, 0, 10);
  level._id_21D9 = scripts\mp\utility\dvars::_id_509C("bankRate", 1, 1, 10);
  level._id_21CD = scripts\mp\utility\dvars::_id_509C("bankCaptureTime", 0, 0, 10);
  level._id_9D38 = scripts\mp\utility\dvars::_id_509C("megaBankLimit", 5, 5, 15);
  level._id_9D36 = scripts\mp\utility\dvars::_id_509C("megaBankBonus", 150, 0, 750);
}

_id_D881() {
  level._id_7C54 = "waypoint_extract_enemy";
  level._id_7C53 = "waypoint_extract_enemy";
  level._id_7C5F = "waypoint_extract_friendly";
  level._id_7C5E = "waypoint_extract_friendly";
  level._id_7C61 = "waypoint_staging_friendly";
  level._id_7C60 = "waypoint_staging_friendly";
}

_id_FC62() {
  _id_07D6::_id_D61B(level._id_7C5E);
}

_id_ABA4() {
  if(isDefined(self._id_ED74)) {
    self setclientomnvar("ui_grind_tags", self._id_ED74);
  }

  scripts\mp\playerlogic::_id_7DE8(self.team);
  self._id_7A89 = undefined;
  _id_0A76::_id_8E2C();
}

onplayerconnect(var_0) {
  var_0._id_8A17 = 0;
  var_0 thread _id_A11C();
}

_id_A11C() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    var_0 = 0;

    if(self.team == "allies") {
      var_0 = 1;
    } else if(self.team == "axis") {
      var_0 = 2;
    }

    self setclientomnvar("ui_tacops_team", var_0);

    if(!isDefined(level._id_E6A1)) {
      scripts\mp\supers::_id_3987();
      _id_0A76::_id_90D2();
    }
  }
}

_id_4073() {
  var_0 = scripts\engine\utility::getstructarray("hostage_extract_zone_A", "targetname");
  var_1 = scripts\engine\utility::getstructarray("hostage_extract_zone_B", "targetname");
  level._id_5BEC = scripts\engine\utility::array_combine(var_0, var_1);
  level._id_A8E8 = [];
}

_id_110D3() {
  _id_07D6::_id_4AD1();
  _id_07D6::_id_15DF("none");
}

_id_8294() {
  var_0 = level._id_ED1E;
  _id_0817::_id_1136("allies", "mp_tohstg_spawn_allies", 1);
  _id_0817::_id_1136("axis", "mp_tohstg_spawn_axis", 1);
  var_0._id_F2AE = [];
  var_0._id_F2AE["allies"] = _id_0817::_id_6D4E("mp_tohstg_spawn_allies");
  var_0._id_F2AE["axis"] = _id_0817::_id_6D4E("mp_tohstg_spawn_axis");

  if(var_0._id_F2AE["allies"].size <= 0) {
    _id_0817::_id_1136("allies", "mp_front_spawn_allies");
    var_0._id_F2AE["allies"] = _id_0817::_id_6D4E("mp_front_spawn_allies");
  }

  if(var_0._id_F2AE["axis"].size <= 0) {
    _id_0817::_id_1136("axis", "mp_front_spawn_axis");
    var_0._id_F2AE["axis"] = _id_0817::_id_6D4E("mp_front_spawn_axis");
  }
}

_id_6D4A() {
  var_0 = level._id_ED1E;
  var_1 = self.pers["team"];
  var_2 = _id_081C::_id_5A54(var_0._id_F2AE[var_1]);
  var_3 = undefined;
  return var_3;
}

_id_0EFE() {
  _id_0817::_id_D461("TDM");
  _id_081C::_id_D45F("to_hstg", "allies");
  _id_081C::_id_D45F("to_hstg", "axis");
  level._id_6D4A = ::_id_6D4A;
}

_id_ABC0() {
  _id_5305("allies");
}

_id_5305(var_0) {
  level._id_5856 = undefined;
  level notify("switch_modes");

  foreach(var_2 in level._id_7A96) {
    var_2 scripts\mp\tac_ops\hostage_utility::_id_C4EB();

    if(isDefined(var_2._id_FE90)) {
      var_2._id_FE90 delete();
    }

    var_2._id_25CA delete();
    var_2._id_75DA delete();
    var_2 delete();
  }

  level._id_7A96 = [];

  foreach(var_5 in level._id_0F3F) {
    var_5 _id_3892(0);
    var_5 scripts\mp\gametypes\obj_grindzone::_id_4392();
  }

  if(isDefined(level._id_AB4C)) {
    [[level._id_AB4C]](var_0);
  }

  scripts\mp\gamescore::_id_0CF2(var_0, 1, 0);
  thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["objective_completed"]);
}

_id_ABB3(var_0) {
  if(isDefined(var_0._id_7A89)) {
    scripts\mp\tac_ops\hostage_utility::_id_5032(var_0, var_0._id_7A89, var_0.origin);
  }
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_0._id_7A89)) {
    scripts\mp\tac_ops\hostage_utility::_id_5032(var_0, var_0._id_7A89, var_0.origin);
  }

  if(!isDefined(var_0._id_EC33)) {
    var_0 scripts\mp\playerlogic::_id_4554(var_0.team);
  }
}

_id_46BF(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("hostage_spawn_early");
  wait(var_0);
  scripts\mp\tac_ops\hostage_utility::_id_E359(var_1, var_2);
}

_id_7A8D() {
  for(var_0 = 0; var_0 < level._id_0F3F.size; var_0++) {
    var_1 = level._id_0F3F[var_0];

    if(distancesquared(self.origin, var_1.origin) < 14400) {
      iprintlnbold("OPFOR EXTRACTED A HOSTAGE");
      scripts\mp\tac_ops\hostage_utility::_id_CC06(var_1.team, 3);
      return 1;
    }
  }

  return 0;
}

_id_81E2() {
  level endon("game_ended");
  level endon("switch_modes");
  level._id_583A = "allies";

  for(var_0 = 0; var_0 < level._id_5BEC.size; var_0++) {
    level._id_7D84[var_0] = level._id_5BEC[var_0];
  }

  thread _id_10859();
}

_id_81E1() {
  level endon("game_ended");
  level endon("switch_modes");
  level._id_583A = "axis";

  for(var_0 = 0; var_0 < 2; var_0++) {
    level._id_7D84[var_0] = level._id_A863[var_0];
    level._id_7D84[var_0] _id_FC62();
    level._id_7D84[var_0] _id_07D6::_id_D8E0("none");
  }

  thread _id_10859();
}

_id_10859() {
  _id_07D1::_id_60C2("prematch_done");
}

_id_3FF2(var_0, var_1) {
  var_2 = level._id_7D84.size;
  var_3 = level._id_7D84[var_2 - 1];
  var_3._id_9B4D = var_0;
  level._id_7D84[var_2 - 1] = undefined;
  var_4 = level._id_0F3F.size;
  level._id_0F3F[var_4] = var_3;
  level._id_0F40[var_4] = self;
  var_5 = int(gettime() + 119000);

  if(istrue(var_1)) {
    _id_99FA(var_3);
  }
}

_id_99FA(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level._id_5839;
  }

  var_0.origin = var_1;

  if(isDefined(var_0.trigger)) {
    var_0.trigger.origin = var_1;
  }

  var_0._id_4140 = var_1;
  var_0 _id_07D6::_id_C579(1, 1);
  var_0 _id_FC62();
  var_0 scripts\mp\gametypes\obj_grindzone::_id_0F05();
  var_0._id_0026 = 1;
  var_0 _id_07D6::_id_D8E0("friendly");
  var_0._id_03A9 = scripts\mp\gametypes\obj_grindzone::_id_D8AD(var_1, var_0);
  var_0 scripts\mp\gametypes\obj_grindzone::_id_FC64(var_0.team, 0);

  if(isDefined(var_0.team)) {
    _id_FD24(var_0.team, 0);
  }

  level notify("zone_moved");
  _id_0AA2::_id_B8F1("mp_killstreak_radar");
  var_2 = spawnfx(level._effect["vfx_smk_signal"], var_1);

  if(isDefined(var_2)) {
    triggerfx(var_2);
  }

  var_0._id_609E = var_2;
}

_id_E2E3(var_0, var_1) {
  self endon("game_ended");
  self endon("switch_modes");
  wait(var_1);
  var_2 = level._id_5839;
  var_3 = (0, 0, 0);
  var_4 = 24000;
  var_5 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_6 = var_5.origin[2];
  var_7 = _id_6A21(var_6);
  var_8 = 4000;
  var_9 = "jackal";
  var_10 = _id_09AB::_id_6A4E(var_2, var_3, var_4, var_5, var_6, var_8, var_7, var_9);
  var_11 = _id_5954();
  var_12 = _id_0A4F::_id_24AB(0, var_10["startPoint"], var_2, var_11, var_0);
  return var_12;
}

_id_5954() {
  var_0 = spawnStruct();
  var_0._id_1F84 = 1;
  var_0._id_5B70 = "offhand_fired";
  var_0._id_887C = 1;
  var_0._id_8CED = 5;
  var_0._id_936C = 0;
  var_0._id_9925 = gettime();
  var_0._id_CF97 = "gesture_script_weapon";
  var_0.streakname = "jackal";
  var_0._id_EA15 = undefined;
  var_0._id_04CC = -1;
  var_0._id_04FE = "s4_ks_gesture_generic_mp";
  var_0.objweapon = makeweapon(var_0._id_04FE);
  return var_0;
}

_id_6A21(var_0) {
  var_1 = 850;
  var_2 = 1500;
  var_3 = var_1 / var_0;
  var_4 = var_3 * var_2;
  return var_4;
}

_id_10850(var_0) {
  level endon("game_ended");
  level endon("switch_modes");
  self endon("extraction_destroyed");
  thread _id_5848();
  wait 119;

  foreach(var_2 in level._id_8B53) {
    if(!isDefined(var_2._id_991F) || !isDefined(var_2._id_991F._id_9B4D)) {
      continue;
    }
    if(self._id_9B4D == var_2._id_991F._id_9B4D) {
      var_2 notify("extract_hostages");
    }
  }

  if(level._id_A8E8[0]._id_ADAE == "allies") {
    scripts\mp\gamescore::_id_0CF2("allies", 1, 0);
    thread scripts\mp\gamelogic::_id_52F7("allies", game["end_reason"]["objective_completed"]);
  } else {
    scripts\mp\gamescore::_id_0CF2("axis", 1, 0);
    thread scripts\mp\gamelogic::_id_52F7("axis", game["end_reason"]["objective_completed"]);
  }
}

_id_5848() {
  level endon("switch_modes");
  self endon("game_ended");
  self endon("extract_hostages");
  self waittill("extraction_destroyed");
  _id_3892(0);
}

_id_3892(var_0) {
  if(var_0) {
    _id_351A();
  }

  _id_3893();
  level._id_7D84[level._id_7D84.size] = self;
  level._id_0F40 = scripts\engine\utility::array_remove_index(level._id_0F40, 0);
  level._id_0F3F = scripts\engine\utility::array_remove_index(level._id_0F3F, 0);
}

_id_3893() {
  if(isDefined(self._id_03A9)) {
    scripts\mp\gametypes\obj_grindzone::_id_FC64("off", 0);
    self._id_03A9 delete();
  }

  if(isDefined(self._id_609E)) {
    self._id_609E delete();
  }

  if(isDefined(self._id_9B4D) && isDefined(self._id_9B4D._id_04ED)) {
    self._id_9B4D._id_04ED delete();
    _id_07D6::_id_15DF("none");
    _id_07D6::_id_C300();
  }

  self._id_0026 = 0;
  _id_FD24("zone_shift", 0);
  scripts\mp\gametypes\obj_grindzone::_id_4392();
  self._id_0026 = 1;
  self._id_8F83 = gettime();
}

_id_351A() {
  var_0 = [];
  var_1 = "none";

  foreach(var_3 in level._id_7A96) {
    if(var_3 _id_7A8D()) {
      var_0[var_0.size] = var_3;
    }

    var_1 = var_3.team;
  }

  level._id_7A96 = scripts\engine\utility::_id_1BBF(level._id_7A96, var_0);
  _id_F749(var_1);
}

_id_F749(var_0) {
  if(level._id_7A96.size == 0) {
    level notify("hostage_spawn_early");
    scripts\mp\tac_ops\hostage_utility::_id_E359(2, var_0);
    waitframe();
    var_1 = scripts\mp\gametypes\tac_ops::_id_6DAD() / 1000;
    thread _id_46BF(var_1 * 0.2, 2);
    thread _id_46BF(var_1 * 0.4, 2);
    thread _id_46BF(var_1 * 0.6, 2);
  }
}

_id_7458(var_0) {
  level endon("game_ended");
  level endon("bomb_defused");
  level endon("disconnect");
  level waittill("host_migration_begin");
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_1 > 0) {
    return;
  }
  return;
}

_id_FD24(var_0, var_1) {
  var_2 = -1;

  if(var_1) {
    var_2 = -2;
  } else {
    switch (var_0) {
      case "axis":
      case "allies":
        var_3 = thread _id_6C03(var_0);

        if(isDefined(var_3)) {
          var_2 = var_3 getentitynumber();
        }

        break;
      case "zone_activation_delay":
        var_2 = -3;
        break;
      case "zone_shift":
      default:
        break;
    }
  }
}

_id_6C03(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

_id_D86D(var_0) {
  var_1 = 1;
  level._id_583A = var_0;

  if(!isDefined(level._id_583A)) {
    var_1 = 2;
  } else if(level._id_583A == "allies") {
    var_1 = 0;
  }

  foreach(var_3 in level.players) {
    if(isDefined(var_1)) {
      var_3 setclientomnvar("ui_hp_callout_id", var_1);
    }
  }
}

_id_F73C(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(level._id_0F3F.size < 2) {
    level._id_5839 = var_0;
    _id_3FF2(var_1, var_2);
    self iprintlnbold("Extraction copter deployed, hold out!");
    return 1;
  } else {
    self iprintlnbold("Request Denied - All copters already en route!");
    return 0;
  }
}

_id_6A2A() {
  return 120;
}

_id_3FF6() {
  var_0 = getent("hvtSpawnLoc", "targetname");
  level._id_7C24 = var_0;
}

_id_3FF7() {
  var_0 = getent("hvtExtractionLoc", "targetname");
  level._id_A8E8 = [];
  level._id_A8E8[0] = var_0;
  var_1 = scripts\mp\gametypes\obj_dom::_id_D896(level._id_A8E8[0]);
  scripts\engine\utility::delaythread(3.0, ::_id_46DA);
  var_1._id_ABCB = ::_id_7A8E;
  level._id_A8E8[0] = var_1;
  level._id_5C3B = 0.1;
  level._id_5C41 = 0;
  waitframe();
  var_1 _id_07D6::_id_D639("neutral");
  var_1 _id_07D6::_id_D8E0("any");
  var_1 _id_07D6::_id_15DF("enemy");
  var_1 _id_07D6::_id_316A(1);
  var_1 _id_07D6::_id_D61B(level._id_7C4B, level._id_7C5F);
}

_id_46DA() {
  level._id_A8E8[0] _id_07D6::_id_D639("axis");
  level._id_A8E8[0] _id_07D6::_id_15DF("enemy");
  level._id_A8E8[0] scripts\mp\gametypes\obj_dom::_id_FC64("axis", 0);
  level._id_A8E8[0] _id_07D6::_id_D61B(level._id_7C4B, level._id_7C5F);
}

_id_10BEC() {
  level endon("game_ended");
  level endon("hostage_phase_ended");
  var_0 = getEntArray("to_hstg_push_trigger", "targetname");

  if(!isDefined(var_0) || var_0.size <= 0) {
    return;
  }
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = int(var_3._id_039B);
    var_1[var_4] = var_3;
  }

  var_6 = 0;

  for(;;) {
    wait 1.0;
    var_7 = var_1[var_6 + 1];

    if(isDefined(var_7)) {
      foreach(var_9 in level._id_7A96) {
        if(var_9 istouching(var_7)) {
          var_6++;
          var_10 = "to_hstg_" + var_6;
          _id_081C::_id_D45F(var_10, "allies");
          _id_081C::_id_D45F(var_10, "axis");
          level notify("hostage_spawns_pushed");
        }
      }
    }
  }
}

_id_7A8E(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4F(var_0);

  if(var_0.team == "allies") {
    if(isDefined(var_0._id_7A89)) {
      var_1 = scripts\mp\tac_ops\hostage_utility::_id_5032(var_0, var_0._id_7A89, var_0.origin);
      var_1._id_F3FE _id_07D6::_id_4799();
      var_1 makeunusable();
      var_1._id_FE90 unlink();
      var_1._id_FE90 makeunusable();
    }

    var_0 thread _id_F73C(var_0.origin, undefined, 0);
    var_2 = scripts\mp\gametypes\tac_ops::_id_6DAF();

    if(var_2 < _id_6A2A() * 1000) {
      scripts\mp\gametypes\tac_ops::_id_57FA(_id_6A2A() * 1000 - var_2);
    } else {
      scripts\mp\gametypes\tac_ops::_id_C17F(var_2 - _id_6A2A() * 1000);
    }

    level._id_A8E8[0]._id_ABCB = scripts\mp\gametypes\obj_dom::_id_4D4F;
    level._id_A8E8[0] _id_07D6::_id_D5C5(undefined);
    level._id_A8E8[0] _id_07D6::_id_D8E0("any");
    level._id_A8E8[0] _id_07D6::_id_15DF("enemy");

    if(scripts\mp\utility\teams::_id_6DCA("allies", "teamCount")) {
      level._id_F348 = scripts\engine\utility::_id_1BD6(scripts\mp\utility\teams::_id_6DCA("allies", "players"), ::_id_3AF6);
      var_3 = level._id_F348[0] _id_E2E3(self, 0);
      var_4 = scripts\mp\utility\teams::_id_6DCA("axis", "players");
      var_5 = var_4.size;
      var_5 = max(var_5, 1);
      var_6 = 1666.67;
      var_3.health = int(var_5 * var_6);
      var_3.maxhealth = var_3.health;
      level._id_A8E8[0] thread _id_3D4D();
      var_3 thread _id_3D4E();
      setomnvar("ui_tacops_helo_health_percent", 1.0);
      thread _id_79D0();
    }
  }
}

_id_79D1() {
  wait 7;
  scripts\mp\gametypes\tac_ops::_id_EF93(&"MISC_MESSAGES_MP/TO_ALLY_HSTG_DEFEND_1", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_DEFEND_1");
}

_id_3D4E() {
  level endon("game_ended");

  for(;;) {
    self waittill("damage", var_0);
    setomnvar("ui_tacops_helo_health_percent", self.health / self.maxhealth);
  }
}

_id_3D4D() {
  level endon("game_ended");
  self waittill("extraction_destroyed");
  scripts\mp\gametypes\tac_ops::_id_AF74();
  wait 5;
  _id_5305("axis");
}

_id_79D0() {
  level endon("game_ended");
  self endon("extraction_destroyed");
  level notify("hostage_holdout_phase_begun");
  thread _id_79D1();
  _id_E692();
  wait(_id_6A2A() - 110.0);
  _id_0A75::_id_BEC1("dx_mpb_us1_phase1_wina", "allies");
  _id_0A75::_id_BEC1("dx_mpb_aqcm_lz_capture", "axis");
  wait 10.0;
  _id_0A75::_id_BEC1("dx_mpb_ovl_lz_hold", "allies");
  wait 20.0;
  _id_0A75::_id_BEC1("dx_mpb_us2_phase3_introa4", "allies");
  wait 55.0;
  _id_0A75::_id_BEC1("dx_mpb_us2_phase1_infila6", "allies");
  _id_0A75::_id_BEC1("dx_mpb_aqcm_phase1_lesstimeb", "axis");
}

_id_E692() {
  var_0 = getEntArray("holdout_outofbounds", "targetname");
  var_1 = scripts\mp\utility\teams::_id_6DCA("allies", "players");

  foreach(var_3 in var_1) {
    foreach(var_5 in var_0) {
      var_3 _id_E70A(var_5, "copterHoldOut");
    }
  }
}

_id_E70A(var_0, var_1) {
  level endon("game_ended");
  level endon("switch_modes");
}

_id_3AF6(var_0, var_1) {
  return var_0._id_038F >= var_1._id_038F;
}