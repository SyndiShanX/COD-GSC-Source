/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\137.gsc
**************************************/

_id_17D0() {
  foreach(var_1 in level.players) {}
  var_1 thread _id_17E7();

  if(maps\_utility::_id_12C1()) {
    maps\_gameskill::_id_17D1();

    foreach(var_4, var_1 in level.players) {}
    var_1 maps\_gameskill::_id_17D2();
  }

  if(!isDefined(level._id_1334)) {
    level._id_1334 = [];

  }
  if(!isDefined(level._id_0AD3)) {
    level._id_0AD3 = 1;

  }
  level._id_17D3 = 1;
  precacheminimapsentrycodeassets();
  precachemenu("sp_eog_summary");
  precachemenu("coop_eog_summary");
  precachemenu("coop_eog_summary2");
  precachemenu("surHUD_display");
  precacheshellshock("so_finished");
  precacheshader("hud_show_timer");
  precacheshader("specops_ui_equipmentstore");
  precacheshader("specops_ui_weaponstore");
  precacheshader("specops_ui_airsupport");
  _id_17E9();

  foreach(var_1 in level.players) {
    var_1._id_17D4 = gettime() + _id_17EA() * 1000;
    var_1 maps\_utility::_id_1402("so_hud_can_toggle");
  }

  level._id_17D5 = 30;
  level._id_17D6 = 10;
  level.func_destructible_crush_player = ::_id_1885;
  setsaveddvar("g_friendlyfireDamageScale", 2);
  setsaveddvar("turretSentryRestrictUsageToOwner", 0);

  if(isDefined(level._id_17D7)) {
    var_7 = 0;

    switch (level._id_17D7) {
      case "close":
        var_7 = 1500;
        break;
      case "far":
        var_7 = 6000;
        break;
      default:
        var_7 = 3000;
        break;
    }

    if(!issplitscreen()) {
      var_7 = var_7 + var_7 * 0.1;

    }
    setsaveddvar("compassmaxrange", var_7);
  }

  common_scripts\utility::flag_init("challenge_timer_passed");
  common_scripts\utility::flag_init("challenge_timer_expired");
  common_scripts\utility::flag_init("special_op_succeeded");
  common_scripts\utility::flag_init("special_op_failed");
  common_scripts\utility::flag_init("special_op_terminated");
  common_scripts\utility::flag_init("special_op_p1ready");
  common_scripts\utility::flag_init("special_op_p2ready");
  common_scripts\utility::flag_init("special_op_no_unlink");
  common_scripts\utility::flag_init("special_op_final_xp_given");
  thread maps\_specialops_code::_id_17D8();
  thread maps\_specialops_code::_id_17D9();
  maps\_specialops_code::_id_17DA();

  if(maps\_utility::_id_12C1()) {
    maps\_specialops_battlechatter::init();

  }
  if(!isDefined(level._id_01E0)) {
    level._id_01E0 = [];

  }
  if(!maps\_utility::_id_12C1()) {
    maps\_utility::_id_17DC(maps\_gameskill::_id_17DB);
  } else if(maps\_utility::_id_12DC()) {
    maps\_utility::_id_17DC(maps\_gameskill::_id_17DD);

  }
  common_scripts\utility::array_thread(getEntArray("trigger_multiple_SO_escapewarning", "classname"), maps\_specialops_code::_id_17DE);
  common_scripts\utility::array_thread(getEntArray("trigger_multiple_SO_escapefailure", "classname"), maps\_specialops_code::_id_17DF);
  level._id_17E0 = 0.5;
  setdvar("ui_deadquote", "");
  thread maps\_specialops_code::_id_17E1();
  setdvar("ui_skip_level_select", "1");
  setdvar("ui_opensummary", 0);
  var_8 = "LB_" + level.script;
  var_9 = "";

  if(maps\_utility::_id_12C1()) {
    var_8 = var_8 + "_TEAM";

  }
  if(maps\_utility::_id_12DC()) {
    var_9 = " LB_EXT_" + level.script;

    if(maps\_utility::_id_12C1()) {
      var_9 = var_9 + "_TEAM";
    }
  }

  precacheleaderboards(var_8 + var_9);
  maps\_specialops_code::_id_17E2();
  level thread _id_17E8();
  maps\_audio::_id_17C7();
  maps\_specialops_code::_id_17E3("so_mw3_mission_2", "mission");
  maps\_specialops_code::_id_17E3("so_mw3_mission_3", "mission");
  maps\_specialops_code::_id_17E3("so_mw3_mission_4", "mission");
  maps\_specialops_code::_id_17E4();
  maps\_rank::init();
  maps\_missions::init();
  maps\_utility::_id_17E5();
  maps\_utility::_id_1A5A("axis", maps\_specialops_code::_id_0239);
  thread maps\_specialops_code::_id_17E6();
  thread _id_1895();
  thread _id_01E2();
}

_id_17E7() {
  wait 0.05;
  self setplayerdata("round", "kills", 0);
  self setplayerdata("round", "killStreak", 0);
  self setplayerdata("round", "deaths", 0);
  self setplayerdata("round", "difficulty", 0);
  self setplayerdata("round", "score", 0);
  self setplayerdata("round", "timePlayed", 0);
  self setplayerdata("round", "wave", 0);
  self setplayerdata("round", "xuidTeammate", "0");
  self setplayerdata("round", "totalXp", 0);
  self setplayerdata("round", "scoreXp", 0);
  self setplayerdata("round", "challengeXp", 0);
}

_id_17E8() {
  setsaveddvar("hud_fade_ammodisplay", 30);
  setsaveddvar("hud_fade_stance", 30);
  setsaveddvar("hud_fade_offhand", 30);
  setsaveddvar("hud_fade_compass", 0);
}

_id_17E9() {
  precachestring(&"SPECIAL_OPS_TIME_NULL");
  precachestring(&"SPECIAL_OPS_TIME");
  precachestring(&"SPECIAL_OPS_WAITING_P1");
  precachestring(&"SPECIAL_OPS_WAITING_P2");
  precachestring(&"SPECIAL_OPS_REVIVE_NAG_HINT");
  precachestring(&"SPECIAL_OPS_CHALLENGE_SUCCESS");
  precachestring(&"SPECIAL_OPS_CHALLENGE_FAILURE");
  precachestring(&"SPECIAL_OPS_FAILURE_HINT_TIME");
  precachestring(&"SPECIAL_OPS_ESCAPE_WARNING");
  precachestring(&"SPECIAL_OPS_ESCAPE_SPLASH");
  precachestring(&"SPECIAL_OPS_WAITING_OTHER_PLAYER");
  precachestring(&"SPECIAL_OPS_STARTING_IN");
  precachestring(&"SPECIAL_OPS_UI_TIME");
  precachestring(&"SPECIAL_OPS_UI_KILLS");
  precachestring(&"SPECIAL_OPS_UI_DIFFICULTY");
  precachestring(&"SPECIAL_OPS_UI_PLAY_AGAIN");
  precachestring(&"SPECIAL_OPS_DASHDASH");
  precachestring(&"SPECIAL_OPS_HOSTILES");
  precachestring(&"SPECIAL_OPS_INTERMISSION_WAVENUM");
  precachestring(&"SPECIAL_OPS_INTERMISSION_WAVEFINAL");
  precachestring(&"SPECIAL_OPS_WAVENUM");
  precachestring(&"SPECIAL_OPS_WAVEFINAL");
  precachestring(&"SPECIAL_OPS_PRESS_TO_CANCEL");
  precachestring(&"SPECIAL_OPS_PLAYER_IS_READY");
  precachestring(&"SPECIAL_OPS_PRESS_TO_START");
  precachestring(&"SPECIAL_OPS_PLAYER_IS_NOT_READY");
  precachestring(&"SPECIAL_OPS_EMPTY");
}

_id_17EA() {
  return 4;
}

_id_17EB() {
  var_0 = getEntArray();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = maps\_utility::_id_0A36();

  foreach(var_3 in var_0) {
    if(var_3 maps\_specialops_code::_id_17EC(var_1)) {
      var_3 delete();
    }
  }

  maps\_specialops_code::_id_17ED();
}

_id_17EE(var_0) {
  level endon("challenge_timer_expired");
  var_1 = getent(var_0, "script_noteworthy");
  var_1 waittill("trigger");
  common_scripts\utility::flag_set(var_0);
}

_id_17EF(var_0, var_1, var_2) {
  level endon("challenge_timer_expired");
  common_scripts\utility::flag_set(var_0);

  if(!isDefined(var_2)) {
    var_2 = "freeze";

  }
  var_3 = getent(var_0, "script_noteworthy");
  thread maps\_specialops_code::_id_17F0(var_3);

  switch (var_2) {
    case "all":
      maps\_specialops_code::_id_17F1(var_3);
      break;
    case "any":
      maps\_specialops_code::_id_17F2(var_3, var_2);
      break;
    case "freeze":
      maps\_specialops_code::_id_17F2(var_3, var_2);
      break;
  }

  level._id_16CE = gettime();
  common_scripts\utility::flag_set(var_1);
}

_id_17F3(var_0, var_1) {
  if(!maps\_utility::_id_12DC()) {
    foreach(var_3 in level.players) {}
    var_3 thread _id_180F();
  }

  if(!isDefined(var_0)) {
    var_0 = 0.5;

  }
  var_5 = 1;

  if(isDefined(level._id_17F4)) {
    var_5 = level._id_17F4;

  }
  var_6 = maps\_hud_util::_id_09A7("black", var_5);
  wait(var_0);
  level notify("challenge_fading_in");
  var_7 = 1;
  var_6 thread maps\_hud_util::fade_over_time(0, var_7);
  level thread maps\_utility::_id_1424("challenge_fadein_complete", var_7);

  if(common_scripts\utility::flag_exist("slamzoom_finished")) {
    common_scripts\utility::flag_wait("slamzoom_finished");

  }
  wait 0.75;

  if(!isDefined(var_1) || var_1) {
    thread _id_1872();
  }
}

_id_17F5(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;

  }
  if(isDefined(var_0)) {
    common_scripts\utility::flag_wait(var_0);

  }
  var_2 = undefined;

  if(maps\_utility::_id_12DC()) {
    var_2 = 1;

    if(!var_1) {
      var_1 = level._id_17F6 < level._id_17F7;
    }
  }

  if(!var_1) {
    thread _id_1874(var_2);

  }
  maps\_endmission::_id_17F8(1);
  maps\_specialops_code::_id_17F9(1);
  maps\_specialops_code::_id_023A();

  if(maps\_utility::_id_12DC()) {
    level notify("so_generate_deathquote");

  }
  maps\_endmission::_id_17FA();
}

_id_17FB(var_0) {
  self._id_16C6["time"] = maps\_utility::_id_17FC(var_0, 1, 0);
}

_id_17FD(var_0) {
  self._id_16C6["kills"] = var_0;
}

_id_17FE(var_0) {
  self._id_16C6["score"] = var_0;
}

_id_17FF(var_0, var_1, var_2, var_3) {
  level endon("special_op_terminated");

  if(!isDefined(var_2)) {
    var_2 = &"SPECIAL_OPS_STARTING_IN";

  }
  var_4 = _id_16B6(0, _id_185B(), var_2);
  var_4 setpulsefx(50, var_0 * 1000, 500);
  var_5 = _id_16B6(0, _id_185B());
  var_5 thread _id_1801(var_0, var_3);
  wait(var_0);
  level.player playSound("arcademode_zerodeaths");

  if(isDefined(var_1) && var_1) {
    level._id_16CF = gettime();

  }
  thread _id_1800(var_4, var_5);
}

_id_1800(var_0, var_1) {
  wait 1;
  var_0 destroy();
  var_1 destroy();
}

_id_1801(var_0, var_1) {
  self.alignx = "left";
  self settenthstimer(var_0);
  self.alpha = 0;

  if(!isDefined(var_1)) {
    var_1 = 0.625;

  }
  wait(var_1);
  var_0 = int((var_0 - var_1) * 1000);
  self setpulsefx(50, var_0, 500);
  self.alpha = 1;
}

_id_1802(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0)) {
    if(!common_scripts\utility::flag_exist(var_0)) {
      common_scripts\utility::flag_init(var_0);

    }
    level._id_1803 = var_0;
  }

  if(isDefined(var_1)) {
    if(!common_scripts\utility::flag_exist(var_1)) {
      common_scripts\utility::flag_init(var_1);

    }
    level._id_1804 = var_1;
  }

  if(!isDefined(var_2)) {
    var_2 = &"SPECIAL_OPS_TIME";

  }
  if(!isDefined(level._id_1805)) {
    level._id_1805 = level._id_17D6;

  }
  level._id_1806 = level._id_1805 + 1;

  foreach(var_5 in level.players) {}
  var_5 thread maps\_specialops_code::_id_1807(var_0, var_1, var_2, var_3);
}

_id_1808(var_0, var_1, var_2) {
  if(!isDefined(self._id_1809)) {
    self._id_1809 = [];

  }
  if(!isDefined(self._id_180A)) {
    self._id_180A = [];

  }
  thread _id_180B(var_0, var_1, var_2);
}

_id_180B(var_0, var_1, var_2) {
  level endon("special_op_terminated");
  _id_180C(var_0);
  self endon(_id_180E(var_0));
  var_3 = _id_185B();
  self._id_1809[var_0] = _id_16B6(var_0, var_3, var_1, self);
  self._id_180A[var_0] = _id_16B6(var_0, var_3, undefined, self);
  self._id_180A[var_0] settext(0);
  self._id_180A[var_0].alignx = "left";
  childthread _id_1866(self._id_1809[var_0]);
  childthread _id_1866(self._id_180A[var_0]);

  if(!isDefined(level._id_023B) || !level._id_023B) {
    common_scripts\utility::flag_wait(level._id_1803);

  }
  for(;;) {
    self waittill(var_2, var_4);
    self._id_180A[var_0] settext(var_4);
  }
}

_id_180C(var_0) {
  var_0 = int(var_0);
  self notify(_id_180E(var_0));

  if(isDefined(self._id_1809[var_0])) {
    self._id_1809[var_0] destroy();

  }
  if(isDefined(self._id_180A[var_0])) {
    self._id_180A[var_0] destroy();
  }
}

_id_180D() {
  if(isDefined(self._id_1809)) {
    foreach(var_2, var_1 in self._id_1809) {}
    _id_180C(var_2);

    self._id_1809 = [];
    self._id_180A = [];
  }
}

_id_180E(var_0) {
  var_0 = int(var_0);
  return "challenge_counter_disable" + var_0;
}

_id_180F() {
  level._id_1810 = 2;
  level endon("special_op_terminated");
  self notify("enabling_kill_counter");
  self endon("enabling_kill_counter");
  thread _id_1808(level._id_1810, &"SPECIAL_OPS_KILL_COUNT", "ui_kill_count");
  thread _id_1811(level._id_1810);
}

_id_1811(var_0) {
  level endon("special_op_terminated");
  self endon(_id_180E(var_0));

  for(;;) {
    level waittill("specops_player_kill", var_1, var_2);

    if(self == var_1) {
      self notify("ui_kill_count", var_1.stats["kills"]);
    }
  }
}

_id_1812() {
  if(!isDefined(level._id_1810)) {
    return;
  }
  _id_180C(level._id_1810);
}

_id_1813() {
  level notify("stop_challenge_timer_thread");
}

_id_16D2(var_0) {
  var_0 = common_scripts\utility::ter_op(isDefined(var_0), var_0, level._id_16D1);
  var_1 = "";

  switch (int(var_0)) {
    case 0:
      var_1 = "@MENU_RECRUIT";
      break;
    case 1:
      var_1 = "@MENU_REGULAR";
      break;
    case 2:
      var_1 = "@MENU_HARDENED";
      break;
    case 3:
      var_1 = "@MENU_VETERAN";
      break;
    default:
      var_1 = "@MENU_REGULAR";
      break;
  }

  return var_1;
}

_id_1814() {
  if(!isDefined(level._id_1815)) {
    return;
  }
  if(!maps\_utility::_id_12C1() || issplitscreen()) {
    return;
  }
  level._id_1816 = 1;
  level._id_17F4 = 0.85;
  level.player thread _id_1817("special_op_p1ready", 2);
  level._id_1337 thread _id_1817("special_op_p2ready", 3.25);
  var_0 = maps\_hud_util::_id_09A7("black", 1);
  var_0 maps\_hud_util::fade_over_time(level._id_17F4, 1);

  while(!common_scripts\utility::flag("special_op_p1ready") || !common_scripts\utility::flag("special_op_p2ready")) {
    wait 0.05;

  }
  var_1 = 1;
  level.player thread _id_181A(var_1);
  level._id_1337 thread _id_181A(var_1);
  wait(var_1);
  var_0 destroy();
  level._id_1816 = undefined;
}

_id_1817(var_0, var_1) {
  self endon("stop_waiting_start");
  self freezecontrols(1);
  self disableweapons();
  self._id_1818 = _id_16B6(0, 0, &"SPECIAL_OPS_PRESS_TO_START", self, 1);
  self._id_1818.alignx = "center";
  self._id_1818.horzalign = "center";
  self._id_1819 = _id_16B6(var_1, 0, &"SPECIAL_OPS_PLAYER_IS_NOT_READY", undefined, 1);
  self._id_1819.alignx = "center";
  self._id_1819.horzalign = "center";
  self._id_1819 settext(self.playername);
  self._id_1819 _id_185F();
  wait 0.05;
  self setblurforplayer(6, 0);
  notifyoncommand(self.unique_id + "_is_ready", "+gostand");
  notifyoncommand(self.unique_id + "_is_not_ready", "+stance");

  for(;;) {
    self waittill(self.unique_id + "_is_ready");
    common_scripts\utility::flag_set(var_0);
    self playSound("so_player_is_ready");
    self._id_1818.label = &"SPECIAL_OPS_PRESS_TO_CANCEL";
    self._id_1819 _id_1854(&"SPECIAL_OPS_PLAYER_IS_READY");
    self waittill(self.unique_id + "_is_not_ready");
    common_scripts\utility::flag_clear(var_0);
    self playSound("so_player_not_ready");
    self._id_1818.label = &"SPECIAL_OPS_PRESS_TO_START";
    self._id_1819 _id_1855(&"SPECIAL_OPS_PLAYER_IS_NOT_READY");
  }
}

_id_181A(var_0) {
  self notify("stop_waiting_start");
  self._id_1818 thread _id_185C(1);
  wait(var_0);
  self._id_1819 thread _id_185C(0, 1);
  self freezecontrols(0);
  self enableweapons();
  self setblurforplayer(0, 0.5);
}

_id_181B(var_0) {
  if(!isDefined(var_0)) {
    return 0;

  }
  return var_0 == level.player;
}

_id_181C(var_0) {
  if(!maps\_utility::_id_12C1()) {
    return 0;

  }
  if(!isDefined(var_0)) {
    return 0;

  }
  return var_0 == level._id_1337;
}

_id_181D() {
  level endon("special_op_terminated");
  level._id_181E = getEntArray("player_trying_to_escape", "script_noteworthy");
  maps\_utility::add_hint_string("player_escape_warning", &"SPECIAL_OPS_EMPTY", maps\_specialops_code::_id_181F);

  for(;;) {
    wait 0.05;

    foreach(var_1 in level._id_181E) {
      foreach(var_3 in level.players) {
        if(!isDefined(var_3._id_1821)) {
          if(var_3 istouching(var_1)) {
            var_3._id_1821 = 1;
            var_3 thread maps\_specialops_code::_id_1822();
            var_3 maps\_utility::_id_1823("player_escape_warning");
          }

          continue;
        }

        if(!isDefined(var_3._id_1824)) {
          var_3 thread maps\_specialops_code::_id_1822();
        }
      }
    }
  }
}

_id_1825() {
  level endon("special_op_terminated");
  common_scripts\utility::flag_wait("player_has_escaped");
  level._id_16CE = gettime();
  _id_183F("@DEADQUOTE_SO_LEFT_PLAY_AREA");
  maps\_utility::_id_1826();
}

_id_1827(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = 0;

  }
  var_6 = [var_0, var_1, var_2, var_3, var_4];
  var_6 = common_scripts\utility::array_removeundefined(var_6);
  var_7 = getEntArray();

  foreach(var_9 in var_7) {
    if(!isDefined(var_9.code_classname)) {
      continue;
    }
    var_10 = isDefined(var_9._id_1693) && var_9._id_1693 == 1;

    if(var_10) {
      continue;
    }
    var_11 = isDefined(var_9.targetname) && var_9.targetname == "intelligence_item";

    if(var_11) {
      continue;
    }
    foreach(var_13 in var_6) {
      if(var_9[[var_13]]()) {
        if(var_5) {
          var_9 notify("delete");

        }
        var_9 delete();
      }
    }
  }
}

_id_1828() {
  if(!isDefined(self.code_classname)) {
    return 0;

  }
  return issubstr(self.code_classname, "actor_");
}

_id_1829() {
  if(!isDefined(self.code_classname)) {
    return 0;

  }
  if(self.code_classname == "script_vehicle_collmap") {
    return 0;

  }
  return issubstr(self.code_classname, "script_vehicle");
}

_id_182A() {
  if(!isDefined(self.classname)) {
    return 0;

  }
  if(self.classname == "trigger_multiple_spawn") {
    return 1;

  }
  if(self.classname == "trigger_multiple_spawn_reinforcement") {
    return 1;

  }
  if(self.classname == "trigger_multiple_friendly_respawn") {
    return 1;

  }
  if(isDefined(self.targetname) && self.targetname == "flood_spawner") {
    return 1;

  }
  if(isDefined(self.targetname) && self.targetname == "friendly_respawn_trigger") {
    return 1;

  }
  if(isDefined(self.spawnflags) && self.spawnflags & 32) {
    return 1;

  }
  return 0;
}

_id_182B() {
  if(!isDefined(self.code_classname)) {
    return 0;

  }
  var_0 = [];
  var_0["trigger_multiple"] = 1;
  var_0["trigger_once"] = 1;
  var_0["trigger_use"] = 1;
  var_0["trigger_radius"] = 1;
  var_0["trigger_lookat"] = 1;
  var_0["trigger_disk"] = 1;
  var_0["trigger_damage"] = 1;
  return isDefined(var_0[self.code_classname]);
}

_id_182C() {
  if(!isDefined(self.classname)) {
    return 0;

  }
  var_0 = [];
  var_0["trigger_multiple_flag_set"] = 1;
  var_0["trigger_multiple_flag_set_touching"] = 1;
  var_0["trigger_multiple_flag_clear"] = 1;
  var_0["trigger_multiple_flag_looking"] = 1;
  var_0["trigger_multiple_flag_lookat"] = 1;
  return isDefined(var_0[self.classname]);
}

_id_182D() {
  if(!_id_182B()) {
    return 0;

  }
  if(isDefined(self._id_182E)) {
    return 1;

  }
  return 0;
}

_id_182F() {
  if(!isDefined(self.classname)) {
    return 0;

  }
  if(self.classname == "info_volume" && isDefined(self._id_1830)) {
    return 1;

  }
  return 0;
}

_id_1831() {
  if(!isDefined(self.classname)) {
    return 0;

  }
  return self.classname == "info_volume";
}

_id_1832() {
  if(!isDefined(self.classname)) {
    return 0;

  }
  return self.classname == "misc_turret";
}

_id_1833() {
  if(!isDefined(self.classname) || !isDefined(self.model)) {
    return 0;

  }
  if(strtok(self.classname, "_")[0] == "weapon") {
    return 1;

  }
  return 0;
}

_id_1834() {
  _id_1827(::_id_182A);
}

_id_1835() {
  _id_1827(::_id_182B, ::_id_182A, ::_id_182C, ::_id_182D);
  animscripts\battlechatter::_id_0BF5();
}

_id_1836() {
  _id_1827(::_id_1829, undefined, undefined, undefined, undefined, 1);
}

_id_1837() {
  _id_1827(::_id_1828);
}

_id_1838(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);
  _id_183A(var_3, var_2);
}

_id_1839() {
  _id_183A(anim._id_0B52);
}

_id_183A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;

  }
  level._id_183B = [];
  _id_183C(var_0, var_1);
  level._id_183B = undefined;
}

_id_183C(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(maps\_utility::_id_0AD1(level._id_183B, var_3)) {
      continue;
    }
    level._id_183B[level._id_183B.size] = var_3;
    var_3._id_1693 = 1;

    if(var_1) {
      if(isDefined(var_3.target)) {
        var_4 = getEntArray(var_3.target, "targetname");
        _id_183C(var_4, var_1);
      }

      if(isDefined(var_3._id_183D)) {
        var_4 = var_3 common_scripts\utility::get_linked_ents();
        _id_183C(var_4, var_1);
      }
    }
  }
}

_id_183E() {
  var_0 = getEntArray("breach_solid", "targetname");

  foreach(var_2 in var_0) {
    var_2 connectpaths();
    var_2 delete();
  }
}

_id_183F(var_0, var_1) {
  level._id_1840 = [];
  level._id_1840[0] = var_0;
  level._id_17E0 = 1.0;
  maps\_specialops_code::_id_17ED(var_1);
}

_id_1841(var_0, var_1) {
  level._id_1840 = var_0;
  level._id_17E0 = 1.0;
  maps\_specialops_code::_id_17ED(var_1);
}

_id_1842(var_0) {
  if(!isDefined(level._id_1840)) {
    level._id_1840 = [];

  }
  level._id_1840 = maps\_utility::_id_1843(level._id_1840, var_0);
}

_id_16B6(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {}

  if(!isDefined(var_0)) {
    var_0 = 0;

  }
  if(!isDefined(var_1)) {
    var_1 = 0;

  }
  var_0 = var_0 + 2;
  var_5 = undefined;

  if(isDefined(var_3)) {
    var_5 = newclienthudelem(var_3);
  } else {
    var_5 = newhudelem();

  }
  var_5.alignx = "right";
  var_5.aligny = "middle";
  var_5.horzalign = "right";
  var_5.vertalign = "middle";
  var_5.x = var_1;
  var_5.y = -100 + 15 * var_0;
  var_5.font = "hudsmall";
  var_5.foreground = 1;
  var_5.hidewheninmenu = 1;
  var_5.hidewhendead = 1;
  var_5.sort = 2;
  var_5 _id_185D();

  if(isDefined(var_2)) {
    var_5.label = var_2;

  }
  if(!isDefined(var_4) || !var_4) {
    if(isDefined(var_3)) {
      if(!var_3 maps\_specialops_code::_id_1844()) {
        var_3 thread maps\_specialops_code::_id_1845(var_5);
      } else if(!maps\_utility::_id_1008("so_hud_can_toggle")) {
        maps\_utility::_id_13DC("so_hud_can_toggle");
      }
    }
  }

  return var_5;
}

_id_1846(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_16B6(var_0, var_1, var_2, var_3, var_4);
  var_5.alignx = "left";
  return var_5;
}

_id_1847(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_16B6(var_0, var_1, var_2, var_3, var_4);
  var_5.alignx = "left";
  var_5.horzalign = "left";
  return var_5;
}

_id_1848(var_0) {
  if(!maps\_specialops_code::_id_1849()) {
    return;
  }
  self notify("update_hud_pulse");
  self endon("update_hud_pulse");
  self endon("destroying");

  if(isDefined(var_0)) {
    self.label = var_0;

  }
  if(isDefined(self._id_184A)) {
    level.player playSound(self._id_184A);

  }
  if(isDefined(self._id_184B) && self._id_184B) {
    maps\_specialops_code::_id_184C();
  } else {
    maps\_specialops_code::_id_1850(self._id_184F, self._id_184E, self._id_184D);
  }
}

_id_1851(var_0) {
  if(!maps\_specialops_code::_id_1849()) {
    return;
  }
  self notify("update_hud_pulse");
  self endon("update_hud_pulse");
  self endon("destroying");

  if(isDefined(var_0)) {
    self.label = var_0;

  }
  self._id_184B = 0;
  maps\_specialops_code::_id_1850(self.fontscale, self._id_184E, self._id_184D);
}

_id_1852(var_0) {
  _id_185D();
  self._id_184B = 0;
  _id_1848(var_0);
}

_id_1853(var_0) {
  _id_16AE();
  self._id_184B = 1;
  _id_1848(var_0);
}

_id_1854(var_0) {
  _id_16AE();
  self._id_184B = 0;
  _id_1848(var_0);
}

_id_1855(var_0) {
  _id_185F();
  self._id_184B = 0;
  _id_1848(var_0);
}

_id_1856(var_0) {
  _id_16AC();
  self._id_184B = 1;
  _id_1848(var_0);
}

_id_1857(var_0) {
  _id_16AC();
  self._id_184B = 0;
  _id_1848(var_0);
}

_id_1858(var_0) {
  _id_1860();
  self._id_184B = 0;
  _id_1848(var_0);
}

_id_1859(var_0, var_1) {
  if(!isDefined(self._id_185A)) {
    _id_1852(var_1);
    return;
  }

  foreach(var_4, var_3 in self._id_185A) {
    if(var_0 <= var_3) {
      switch (var_4) {
        case "pulse_disabled":
          _id_1858(var_1);
          return;
        case "pulse_failure":
          _id_1857(var_1);
          return;
        case "pulse_alarm":
          _id_1856(var_1);
          return;
        case "pulse_warning":
          _id_1855(var_1);
          return;
        case "pulse_default":
          _id_1852(var_1);
          return;
        case "pulse_close":
          _id_1853(var_1);
          return;
        case "pulse_success":
          _id_1854(var_1);
          return;
      }
    }
  }

  _id_1852(var_1);
}

_id_185B() {
  return -72;
}

_id_185C(var_0, var_1) {
  if(isDefined(var_0) && var_0) {
    self notify("destroying");
    self destroy();
    return;
  }

  thread _id_1851();

  if(isDefined(var_1) && var_1) {
    self setpulsefx(0, 0, 500);
    wait 0.5;
  } else {
    self setpulsefx(0, 1500, 500);
    wait 2;
  }

  self notify("destroying");
  self destroy();
}

_id_185D(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (1, 1, 1);
  self.glowcolor = (0.6, 0.6, 0.6);
}

_id_185E(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (0.8, 0.8, 1);
  self.glowcolor = (0.301961, 0.301961, 0.6);
}

_id_16AE(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (0.8, 1, 0.8);
  self.glowcolor = (0.301961, 0.6, 0.301961);
}

_id_185F(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (1, 1, 0.5);
  self.glowcolor = (0.7, 0.7, 0.2);
}

_id_16AC(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (1, 0.4, 0.4);
  self.glowcolor = (0.7, 0.2, 0.2);
}

_id_1860(var_0) {
  if(isDefined(var_0)) {
    self.alpha = var_0;
    self.glowalpha = var_0;
  }

  self.color = (0.4, 0.4, 0.4);
  self.glowcolor = (0.2, 0.2, 0.2);
}

_id_1861(var_0) {
  if(isDefined(self._id_1862)) {
    return;
  }
  level endon("challenge_timer_expired");
  level endon("challenge_timer_passed");
  level endon("special_op_terminated");
  self endon("death");

  if(isDefined(var_0)) {
    level endon(var_0);

  }
  self setweaponhudiconoverride("actionslot1", "hud_show_timer");
  notifyoncommand("toggle_challenge_timer", "+actionslot 1");
  self._id_1862 = _id_1864();

  if(!maps\_specialops_code::_id_1844()) {
    thread _id_1863();
    maps\_utility::_id_1654("so_hud_can_toggle");
  }

  self notify("so_hud_toggle_available");

  for(;;) {
    self waittill("toggle_challenge_timer");

    switch (self._id_1862) {
      case "on":
        self._id_1862 = "off";
        setdvar("so_ophud_" + self.unique_id, "0");
        break;
      case "off":
        self._id_1862 = "on";
        setdvar("so_ophud_" + self.unique_id, "1");
        break;
    }

    self notify("update_challenge_timer");
  }
}

_id_1863() {
  self endon("so_hud_toggle_available");
  notifyoncommand("force_challenge_timer", "+actionslot 1");
  self waittill("force_challenge_timer");
  self._id_17D4 = gettime();
  self._id_1862 = "on";
  setdvar("so_ophud_" + self.unique_id, "1");
}

_id_1864() {
  if(getdvarint("so_ophud_" + self.unique_id) == 1) {
    self._id_17D4 = gettime() + 1000;
    return "on";
  }

  if(isDefined(level._id_16C3)) {
    return "on";

  }
  if(isDefined(level._id_1865) && level._id_1865) {
    return "on";

  }
  return "off";
}

_id_1866(var_0, var_1) {
  level endon("new_challenge_timer");
  level endon("challenge_timer_expired");
  level endon("challenge_timer_passed");
  level endon("special_op_terminated");
  self endon("death");

  if(isDefined(var_1)) {
    level endon(var_1);

  }
  var_0._id_1867 = 1;
  maps\_utility::_id_1654("so_hud_can_toggle");
  _id_1868(var_0);

  for(;;) {
    self waittill("update_challenge_timer");
    var_0 fadeovertime(0.25);
    _id_1868(var_0);
  }
}

_id_1868(var_0) {
  switch (self._id_1862) {
    case "on":
      var_0.alpha = 1;
      break;
    case "off":
      var_0.alpha = 0;
      break;
  }
}

_id_1869(var_0) {
  if(!isDefined(level._id_16C3)) {
    return;
  }
  if(common_scripts\utility::flag("challenge_timer_expired") || common_scripts\utility::flag("challenge_timer_passed")) {
    return;
  }
  level._id_186A = level._id_186A - var_0;

  if(level._id_186A < 0) {
    level._id_186A = 0.01;

  }
  var_1 = (0.6, 0.2, 0.2);
  var_2 = (0.4, 0.1, 0.1);

  foreach(var_4 in level.players) {}
  var_4._id_186B settenthstimer(level._id_186A);

  thread maps\_specialops_code::_id_186C();
}

_id_186D(var_0) {
  var_1 = getdvar(var_0);
  return var_1 == "so_char_client" || var_1 == "so_char_host";
}

_id_186E() {
  var_0 = tablelookup("sp/specOpsTable.csv", 1, level.script, 9);

  if(var_0 == "") {
    return 0;

  }
  foreach(var_2 in level.players) {
    var_3 = var_2 getlocalplayerprofiledata(var_0);

    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3 != 0) {
      return 1;
    }
  }

  return 0;
}

_id_186F(var_0) {
  return 0;
}

_id_1870(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    if(isDefined(level._id_16CF)) {
      var_0 = level._id_16CF;
    } else {
      var_0 = 300;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = gettime();

  }
  if(!isDefined(var_2)) {
    var_2 = 0.0;

  }
  var_3 = var_1 - var_0;
  var_3 = int(min(var_3, 86400000));
  var_4 = tablelookup("sp/specOpsTable.csv", 1, level.script, 9);

  if(var_4 == "") {
    return 0;

  }
  foreach(var_6 in level.players) {
    var_7 = var_6 getlocalplayerprofiledata(var_4);

    if(!isDefined(var_7)) {
      continue;
    }
    var_8 = var_7 == 0;

    if(var_8) {
      continue;
    }
    var_7 = var_7 - var_7 * var_2;

    if(var_3 < var_7) {
      return 1;
    }
  }

  return 0;
}

_id_1871(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    if(isDefined(level._id_16CF)) {
      var_0 = level._id_16CF;
    } else {
      var_0 = 300;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = gettime();

  }
  if(!isDefined(var_2)) {
    var_2 = 0.0;

  }
  var_3 = var_1 - var_0;
  var_4 = level._id_16C3 * 1000;
  var_4 = var_4 - var_4 * var_2;
  return var_3 > var_4;
}

_id_1872() {
  if(isDefined(level._id_01E0["ready_up"])) {
    [[level._id_01E0["ready_up"]]]();
    return;
  }

  maps\_specialops_code::_id_1873("so_tf_1_plyr_prep", 0, 1);
}

_id_1874(var_0) {
  if(!maps\_utility::_id_12DC() && _id_1870(level._id_16CF, level._id_16CE)) {
    if(isDefined(level._id_01E0["success_best"])) {
      thread[[level._id_01E0["success_best"]]]();
      return;
    }

    thread maps\_specialops_code::_id_1873("so_tf_1_success_best", 0.5, 1);
  } else {
    if(!isDefined(var_0)) {
      var_0 = 0;

      if(level.gameskill >= 3) {
        if(_id_186E()) {
          var_0 = common_scripts\utility::cointoss();
        }
      }
    }

    if(isDefined(level._id_01E0["success_generic"])) {
      [[level._id_01E0["success_generic"]]](var_0);
      return;
    }

    if(var_0) {
      maps\_specialops_code::_id_1873("so_tf_1_success_jerk", 0.5, 1);
      return;
    }

    maps\_specialops_code::_id_1873("so_tf_1_success_generic", 0.5, 1);
  }
}

_id_1875(var_0) {
  if(isDefined(level._id_1876) && level._id_1876) {
    return;
  }
  level._id_1876 = 1;
  maps\_specialops_code::_id_1873(var_0, 0.5, 1);
}

_id_1877() {
  if(isDefined(level._id_01E0["failed_generic"])) {
    [[level._id_01E0["failed_generic"]]]();
  } else {
    if(level.gameskill <= 2 || common_scripts\utility::cointoss()) {
      _id_1875("so_tf_1_fail_generic");
      return;
    }

    _id_1875("so_tf_1_fail_generic_jerk");
  }
}

_id_1878() {
  if(isDefined(level._id_01E0["failed_time"])) {
    [[level._id_01E0["failed_time"]]]();
    return;
  }

  _id_1875("so_tf_1_fail_time");
}

_id_1879() {
  if(isDefined(level._id_01E0["failed_bleedout"])) {
    [[level._id_01E0["failed_bleedout"]]]();
    return;
  }

  _id_1875("so_tf_1_fail_bleedout");
}

_id_187A() {
  if(isDefined(level._id_01E0["time_low_normal"])) {
    [[level._id_01E0["time_low_normal"]]]();
    return;
  }

  maps\_specialops_code::_id_1873("so_tf_1_time_generic");
}

_id_187B() {
  if(isDefined(level._id_01E0["time_low_hurry"])) {
    [[level._id_01E0["time_low_hurry"]]]();
    return;
  }

  maps\_specialops_code::_id_1873("so_tf_1_time_hurry");
}

_id_187C() {
  if(!isDefined(level._id_187D)) {
    level._id_187D = gettime();

    if(!isDefined(level._id_187E)) {
      level._id_187E = 5000;
    }
  } else if(gettime() - level._id_187D < level._id_187E) {
    return;
  }
  var_0 = 0.5;
  level._id_187D = gettime() + var_0 * 1000;

  if(isDefined(level._id_01E0["killing_civilians"])) {
    [[level._id_01E0["killing_civilians"]]]();
    return;
  }

  maps\_specialops_code::_id_1873("so_tf_1_civ_kill_warning", 0.5);
}

_id_187F(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level._id_1880)) {
    level._id_1880 = "none";

  }
  var_2 = undefined;

  switch (level._id_1880) {
    case "none":
      var_2 = 0.75;
      break;
    case "3quarter":
      var_2 = 0.5;
      break;
    case "half":
      var_2 = 0.25;
      break;
    default:
      return;
  }

  var_3 = var_1 * var_2;

  if(var_0 > var_3) {
    return;
  }
  var_4 = undefined;

  switch (level._id_1880) {
    case "none":
      level._id_1880 = "3quarter";
      var_4 = "so_tf_1_progress_3quarter";
      break;
    case "3quarter":
      level._id_1880 = "half";
      var_4 = "so_tf_1_progress_half";
      break;
    case "half":
      level._id_1880 = "quarter";
      var_4 = "so_tf_1_progress_quarter";
      break;
  }

  if(isDefined(level._id_01E0["progress_goal_status"])) {
    [[level._id_01E0["progress_goal_status"]]]();
    return;
  }

  maps\_specialops_code::_id_1873(var_4, 0.5);
}

_id_1881(var_0) {
  if(isDefined(level._id_16C3)) {
    if(_id_1871(level._id_16CF, gettime(), var_0)) {
      if(isDefined(level._id_01E0["time_status_late"])) {
        [[level._id_01E0["time_status_late"]]]();
        return;
      }

      maps\_specialops_code::_id_1873("so_tf_1_time_status_late", 0.2);
      return;
    }
  }

  if(_id_1870(level._id_16CF, gettime(), var_0)) {
    if(isDefined(level._id_01E0["time_status_good"])) {
      [[level._id_01E0["time_status_good"]]]();
      return;
    }

    maps\_specialops_code::_id_1873("so_tf_1_time_status_good", 0.2);
  }
}

_id_1882(var_0, var_1, var_2) {
  if(!isDefined(level._id_1883)) {
    level._id_1883 = 0;

  }
  if(gettime() < level._id_1883) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 1;

  }
  var_3 = int(var_0 / var_2);

  if(var_3 > 5) {
    if(!isDefined(level._id_1884) || !level._id_1884) {
      thread _id_187F(var_0, var_1);
      level._id_1883 = gettime() + 800;
    }

    return;
  }

  if(isDefined(level._id_01E0["progress"])) {
    thread[[level._id_01E0["progress"]]](var_3);
  } else {
    switch (var_3) {
      case 5:
        thread maps\_specialops_code::_id_1873("so_tf_1_progress_5more", 0.5);
        break;
      case 4:
        thread maps\_specialops_code::_id_1873("so_tf_1_progress_4more", 0.5);
        break;
      case 3:
        thread maps\_specialops_code::_id_1873("so_tf_1_progress_3more", 0.5);
        break;
      case 2:
        thread maps\_specialops_code::_id_1873("so_tf_1_progress_2more", 0.5);
        break;
      case 1:
        thread maps\_specialops_code::_id_1873("so_tf_1_progress_1more", 0.5);
        break;
    }
  }

  level._id_1883 = gettime() + 800;
}

_id_1885(var_0, var_1) {
  if(!isDefined(var_0._id_1886)) {
    var_0._id_1886 = [];

  }
  if(!isDefined(var_1)) {
    var_1 = "MOD_EXPLOSIVE";

  }
  var_0._id_1886["attacker"] = self;
  var_0._id_1886["cause"] = var_1;
  var_0._id_1886["weapon_name"] = "none";
  var_0 maps\_utility::_id_1887();
}

_id_1888() {
  var_0 = level._id_1889 maps\_endmission::_id_188A(level.script);
  var_1 = int(self getlocalplayerprofiledata("missionSOHighestDifficulty")[var_0]);
  var_1 = int(max(0, var_1));
  return var_1;
}

_id_188B() {
  precacheshader("difficulty_star");
}

_id_188C(var_0, var_1, var_2, var_3, var_4, var_5) {
  level._id_188D = [];
  level._id_188D["regular"] = var_2;
  level._id_188D["hardened"] = var_3;
  level._id_188D["veteran"] = var_4;
  var_5 = common_scripts\utility::ter_op(isDefined(var_5), var_5, 4);
  self._id_188E = [];
  thread _id_188F(var_0, var_1, 0, level._id_188D["regular"], "regular", var_5);
  thread _id_188F(var_0, var_1, 1, level._id_188D["hardened"], "hardened", var_5);
  thread _id_188F(var_0, var_1, 2, level._id_188D["veteran"], "veteran", var_5);
}

_id_188F(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("special_op_terminated");
  level endon(var_1);

  if(!isDefined(self._id_1890)) {
    self._id_1890 = 0;

  }
  self._id_1890++;
  var_6 = 25;
  var_7 = _id_185B();
  var_8 = _id_16B6(var_5, var_7, undefined, self);
  var_8.x = var_8.x - (var_2 * var_6 - 30);
  var_8.y = var_8.y + 5;
  var_8 setshader("difficulty_star", 25, 25);
  common_scripts\utility::flag_wait(var_0);
  thread _id_1894(var_8, var_1);

  if(var_3 < 0) {
    return;
  }
  thread _id_1893(var_8, var_3, var_1);
  level common_scripts\utility::waittill_any_timeout(var_3, "star_hud_remove_" + var_4);
  waittillframeend;

  if(common_scripts\utility::flag(var_1)) {
    return;
  }
  self._id_1890--;
  var_8 destroy();
}

_id_1891(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_0)) {
      if(!isDefined(var_2._id_188E["veteran"])) {
        var_0 = "veteran";
      } else if(!isDefined(var_2._id_188E["hardened"])) {
        var_0 = "hardened";
      } else if(!isDefined(var_2._id_188E["regular"])) {
        var_0 = "regular";
      }
    }

    if(isDefined(var_2._id_188E[var_0])) {
      return;
    }
    if(var_0 == "hardened" && !isDefined(var_2._id_188E["veteran"])) {
      return;
    } else if(var_0 == "regular" && (!isDefined(var_2._id_188E["veteran"]) || !isDefined(var_2._id_188E["hardened"]))) {
      return;
    }
    var_2._id_188E[var_0] = 1;
    level notify("star_hud_remove_" + var_0);
  }
}

_id_1892(var_0) {
  switch (var_0) {
    case "regular":
    case "veteran":
    case "hardened":
      break;
    default:
      break;
  }
}

_id_1893(var_0, var_1, var_2) {
  var_0 endon("death");
  level endon(var_2);
  level endon("special_op_terminated");
  var_3 = 5;
  var_4 = var_1 - var_3;
  wait(var_4);

  for(var_5 = 0; var_5 < var_3; var_5++) {
    self playlocalsound("star_tick");
    var_0.alpha = 1;
    wait 0.5;
    var_0.alpha = 0.3;
    wait 0.5;
  }

  self playlocalsound("star_lost");
}

_id_1894(var_0, var_1) {
  var_0 endon("death");
  common_scripts\utility::flag_wait(var_1);
  waittillframeend;
  var_0.alpha = 1;
}

_id_1895() {
  wait 0.05;

  foreach(var_1 in level.players) {}
  var_1 thread _id_1896();
}

_id_1896() {
  _id_18A5("unlock");

  for(var_0 = 0; var_0 < 3; var_0++) {
    _id_189D(var_0);

  }
  for(;;) {
    self waittill("update_rank");
    waittillframeend;

    if(!isDefined(self)) {
      return;
    }
    var_1 = maps\_rank::getrank();
    var_2 = level._id_1897[var_1];

    if(isDefined(var_2)) {
      for(var_0 = 0; var_0 < 3; var_0++) {
        var_3 = var_2[var_0];

        if(isDefined(var_3)) {
          _id_1899(var_3);
          _id_18A7("surHUD_unlock_hint_" + var_0, "name", var_3.name);
          _id_18A7("surHUD_unlock_hint_" + var_0, "icon", var_3.icon);
          _id_18A7("surHUD_unlock_hint_" + var_0, "mode", var_3.mode);
          continue;
        }

        _id_189D(var_0);
      }

      _id_189E("unlock");
    }
  }
}

_id_1899(var_0) {
  if(!var_0._id_01DD) {
    var_1 = tablelookup("sp/survival_armories.csv", 1, var_0._id_160B, 2);
    var_2 = int(1 + (var_1 == "weapon"));
    var_3 = tablelookup("sp/survival_armories.csv", 1, var_0._id_160B, 6);
    var_4 = var_0._id_189B;
    _id_189C("recent_item_2", "recent_item_3");
    _id_189C("recent_item_1", "recent_item_2");
    _id_18A7("recent_item_1", "name", var_0.name);
    _id_18A7("recent_item_1", "icon", var_3);
    _id_18A7("recent_item_1", "desc", var_4);
    _id_18A7("recent_item_1", "icon_width_ratio", var_2);
  } else {
    var_5 = self getplayerdata("recent_feature_1", "name");
    _id_18A7("recent_feature_2", "name", var_5);
    _id_18A7("recent_feature_1", "name", var_0.name);
  }
}

_id_189C(var_0, var_1) {
  var_2 = self getplayerdata(var_0, "name");
  var_3 = self getplayerdata(var_0, "desc");
  var_4 = self getplayerdata(var_0, "icon");
  var_5 = self getplayerdata(var_0, "icon_width_ratio");
  _id_18A7(var_1, "name", var_2);
  _id_18A7(var_1, "desc", var_3);
  _id_18A7(var_1, "icon", var_4);
  _id_18A7(var_1, "icon_width_ratio", var_5);
}

_id_189D(var_0) {
  _id_18A7("surHUD_unlock_hint_" + var_0, "name", "");
  _id_18A7("surHUD_unlock_hint_" + var_0, "icon", "");
  _id_18A7("surHUD_unlock_hint_" + var_0, "mode", "");
}

_id_189E(var_0) {
  level endon("special_op_terminated");
  self endon("stop_animate_" + var_0);
  thread _id_01E1("stop_animate_" + var_0);

  if(!isDefined(self._id_189F)) {
    self._id_189F = 0;

  }
  while(self._id_189F) {
    wait 0.05;

  }
  self._id_189F = 1;

  if(!_id_18A3(var_0)) {
    _id_18A4(var_0);

  }
  _id_18A6("surHUD_set_animate", var_0);
  wait 0.05;
  self openmenu("surHUD_display");
  wait 0.05;
  self._id_189F = 0;
  self notify("surHUD_free");
}

_id_01E1(var_0) {
  self endon("surHUD_free");
  self waittill(var_0);
  self._id_189F = 0;
}

_id_18A0(var_0, var_1) {
  if(isDefined(self)) {
    _id_18A7("surHUD_challenge_label", "slot_" + var_0, var_1);
  }
}

_id_18A1(var_0, var_1) {
  if(isDefined(self)) {
    _id_18A7("surHUD_challenge_progress", "slot_" + var_0, var_1);
  }
}

_id_18A2(var_0, var_1) {
  if(isDefined(self)) {
    _id_18A7("surHUD_challenge_reward", "slot_" + var_0, var_1);
  }
}

_id_18A3(var_0) {
  if(isDefined(self) && self getplayerdata("surHUD", var_0)) {
    return 1;

  }
  return 0;
}

_id_18A4(var_0) {
  if(isDefined(self)) {
    _id_18A7("surHUD", var_0, 1);
  }
}

_id_18A5(var_0) {
  if(isDefined(self)) {
    _id_18A7("surHUD", var_0, 0);
  }
}

_id_18A6(var_0, var_1) {
  self setplayerdata(var_0, var_1);
}

_id_18A7(var_0, var_1, var_2) {
  self setplayerdata(var_0, var_1, var_2);
}

_id_01E2() {
  wait 0.05;

  foreach(var_1 in level.players) {}
  var_1 thread _id_01E3();
}

_id_01E3() {
  if(!isDefined(self._id_01E4)) {
    self._id_01E4 = [];

  }
  self._id_01E4["ARMS_DEALER"] = 0;
  self._id_01E4["DANGER_ZONE"] = 0;
  self._id_01E4["DEFENSE_SPENDING"] = 0;
  self._id_01E4["SURVIVOR"] = 0;
  self._id_01E4["UNSTOPPABLE"] = 0;
}

_id_01DF(var_0, var_1) {
  if(maps\_utility::_id_12DC()) {
    switch (var_0) {
      case "DEFENSE_SPENDING":
      case "DANGER_ZONE":
      case "ARMS_DEALER":
        thread _id_01E5(var_0, var_1);
        return;
      case "SURVIVOR":
        thread _id_01E7(var_0, 9);
        return;
      case "UNSTOPPABLE":
        thread _id_01E7(var_0, 14);
        return;
      case "GET_RICH_OR_DIE_TRYING":
      case "I_LIVE":
        thread maps\_utility::_id_1E39(var_0);
        return;
    }
  } else {
    switch (var_0) {
      case "BRAG_RAGS":
        thread maps\_utility::_id_1E39(var_0);
        return;
      case "TACTICIAN":
        thread _id_019E(var_0, 1);
        return;
      case "OVERACHIEVER":
        thread _id_019E(var_0, 3);
        return;
    }
  }
}

_id_01E5(var_0, var_1) {
  if(self._id_01E4[var_0]) {
    return;
  }
  var_2 = level._id_189A[var_1].type;

  if(self getplayerdata(var_2 + "_purchased", var_1) == 0) {
    self setplayerdata(var_2 + "_purchased", var_1, 1);
  } else {
    return;

  }
  var_3 = 0;

  if(var_2 == "weapon" || var_2 == "weaponupgrade") {
    var_3 = _id_01E6("weapon", "weapon_purchased") && _id_01E6("weaponupgrade", "weaponupgrade_purchased");
  } else {
    var_3 = _id_01E6(var_2, var_2 + "_purchased");

  }
  if(var_3) {
    maps\_utility::_id_1E39(var_0);
    self._id_01E4[var_0] = 1;
  }
}

_id_01E6(var_0, var_1) {
  foreach(var_3 in level._id_3D68[var_0]) {
    if(self getplayerdata(var_1, var_3._id_160B) == 0) {
      return 0;
    }
  }

  return 1;
}

_id_01E7(var_0, var_1) {
  if(self._id_01E4[var_0]) {
    return;
  }
  for(var_2 = 0; var_2 < 16; var_2++) {
    var_3 = level._id_1889._id_190C[var_2].name;
    var_4 = tablelookup("sp/specOpsTable.csv", 1, var_3, 9);
    var_5 = int(self getlocalplayerprofiledata(var_4) / 1000);

    if(var_3 == level.script) {
      var_5 = level._id_17F6;

    }
    if(var_5 < var_1) {
      return;
    }
  }

  maps\_utility::_id_1E39(var_0);
  self._id_01E4[var_0] = 1;

  if(var_0 == "UNSTOPPABLE") {
    self setplayerdata("challengeState", "ch_unstoppable", 2);
  }
}

_id_019E(var_0, var_1) {
  for(var_2 = 16; var_2 < 32; var_2++) {
    var_3 = level._id_1889._id_190C[var_2].name;
    var_4 = int(self getlocalplayerprofiledata("missionSOHighestDifficulty")[var_2]);
    var_4 = int(max(0, var_4)) - 1;

    if(var_4 < var_1) {
      return;
    }
  }

  maps\_utility::_id_1E39(var_0);

  if(var_0 == "OVERACHIEVER") {
    self setplayerdata("challengeState", "ch_overachiever", 2);
  }
}