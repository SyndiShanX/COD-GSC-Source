/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1571.gsc
**************************************/

_id_3F62(var_0) {
  return tablelookup(level.loadout_table, 1, var_0, 2);
}

_id_3F64(var_0) {
  return tablelookup(level.loadout_table, 2, var_0, 3);
}

_id_3F65() {
  if(getdvarint("survival_chaos") == 1) {
    thread maps\_so_survival_chaos::chaos_pre_preload();

  }
  _id_03BE::main();

  if(!isDefined(level.loadout_table)) {
    level.loadout_table = "sp/survival_waves.csv";

  }
  level._id_3BD7 = "remote_missile_survival";
  level._id_12DB = _id_061C::_id_3D5C;
  _id_0626::_id_3EBB();
  _id_061C::_id_3D40();
  _id_0615::_id_3C51();
  _id_0627::_id_3F32();
  precacheitem("smoke_grenade_fast");
  precacherumble("damage_light");
  precacheminimapsentrycodeassets();
  precachestring(&"SO_SURVIVAL_SURVIVAL_OBJECTIVE");
  precachestring(&"SO_SURVIVAL_WAVE_TITLE");
  precachestring(&"SO_SURVIVAL_WAVE_SUCCESS_TITLE");
  precachestring(&"SO_SURVIVAL_SURVIVE_TIME");
  precachestring(&"SO_SURVIVAL_WAVE_TIME");
  precachestring(&"SO_SURVIVAL_PARTNER_READY");
  precachestring(&"SO_SURVIVAL_READY_UP_WAIT");
  precachestring(&"SO_SURVIVAL_READY_UP");
  precacheshader("gradient_inset_rect");
  precacheshader("teamperk_blast_shield");
  precacheshader("specialty_self_revive");
  _id_0618::_id_3D24(_id_3F62("weapon_1"));
  _id_0618::_id_3D24(_id_3F62("weapon_2"));
  _id_0618::_id_3D24(_id_3F62("weapon_3"));
  maps\_load::_id_1F5C("viewhands_player_delta");
  thread _id_0618::_id_3E3F();
  thread _id_00D8();
  level._id_3E86 = 1;

  if(getdvarint("survival_chaos") == 1) {
    thread maps\_so_survival_chaos::chaos_preload();

  }
  precachemenu("so_survival_dvar_reset");
}

_id_00D8() {
  var_0 = getEntArray("trigger_multiple_flag_set", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1692) && var_2._id_1692 == "start_survival") {
      var_2 common_scripts\utility::trigger_off();
    }
  }
}

hurtplayersthink(var_0) {
  level endon("special_op_terminated");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1) && isplayer(var_1) && var_1 == self) {
      break;
    }
  }

  maps\_utility::_id_1887();
}

_id_3F66() {
  _id_0626::_id_3EBC();
  _id_061A::_id_3D25();

  if(getdvarint("survival_chaos") == 1) {
    thread maps\_so_survival_chaos::chaos_postload();
  }
}

_id_3F67() {
  foreach(var_1 in level.players) {}
  var_1 openpopupmenu("so_survival_dvar_reset");

  common_scripts\utility::flag_init("bosses_spawned");
  common_scripts\utility::flag_init("aggressive_mode");
  common_scripts\utility::flag_init("boss_music");
  common_scripts\utility::flag_init("slamzoom_finished");
  common_scripts\utility::flag_set("so_player_death_nofail");
  level._id_16BC = 1;
  level._id_16BD = ::_id_16C2;
  level._id_1904 = 1;
  level._id_17F7 = 5;
  level._id_1990 = ::_id_3F69;
  level._id_1991 = ::_id_3F68;
  level._id_01D9 = 1;
  level._id_3C36 = 128.0;
  level._id_3C37 = 0.0;
  setsaveddvar("ai_foliageSeeThroughDist", 50000);
  setsaveddvar("g_friendlyfireDamageScale", 0.5);
  forcesharedammo();
  thread maps\_specialops::_id_1802("start_survival", "win_survival", undefined, 1);
  thread maps\_specialops::_id_17F3(undefined, 0);
  thread maps\_specialops::_id_17F5("win_survival");
  level._id_3DBD = _id_0610::_id_3B6D(1);
  maps\_drone_ai::init();
  _id_0626::_id_3EBE();
  _id_061A::_id_3D26();
  _id_061C::ai_init();
  _id_0615::_id_3C52();

  if(getdvarint("survival_chaos") != 1) {
    _id_0627::_id_3F3A();

  }
  _id_0628::_id_3E4B();
  maps\_audio::_id_1719();
  thread _id_3F71();
  thread _id_3F6C();

  if(getdvarint("survival_chaos") == 1) {
    thread maps\_so_survival_chaos::chaos_init();
  }
}

_id_3F68() {
  return level._id_17F6;
}

_id_3F69() {
  foreach(var_1 in level.players) {}

  var_3 = (level._id_16CE - level._id_16CF) / 1000;
  var_4 = level._id_17F6;
  var_5 = 0;

  foreach(var_1 in level.players) {}
  var_5 = var_5 + var_1._id_18D3["credits"];

  var_8 = 999 * min(var_5 / (var_4 * 10000), 1.0);

  if(var_4 == 1) {
    return int(var_8);

  }
  var_9 = var_4 * 1000;
  var_10 = int(var_9 + var_8);
  return var_10;
}

_id_3F6A(var_0, var_1) {
  if(maps\_utility::_id_12C1()) {
    return maps\_utility::_id_133A(var_0)._id_18D3[var_1];
  } else {
    return undefined;
  }
}

_id_16C2() {
  var_0 = int(min(level._id_16CE - level._id_16CF, 86400000));
  var_1 = int(var_0 % 1000 / 100);
  var_2 = int(var_0 / 1000) % 60;
  var_3 = int(var_0 / 60000) % 60;
  var_4 = int(var_0 / 3600000);

  if(var_4 < 10) {
    var_4 = "0" + var_4;

  }
  if(var_3 < 10) {
    var_3 = "0" + var_3;

  }
  if(var_2 < 10) {
    var_2 = "0" + var_2;

  }
  var_5 = var_4 + ":" + var_3 + ":" + var_2 + "." + var_1;
  var_6 = _id_3F69();

  foreach(var_8 in level.players) {
    var_9 = var_8._id_18D3["kill"];
    var_10 = _id_3F6A(var_8, "kill");
    var_11 = var_8._id_18D3["headshot"];
    var_12 = _id_3F6A(var_8, "headshot");
    var_13 = var_8._id_18D3["accuracy"] + "%";
    var_14 = _id_3F6A(var_8, "accuracy");

    if(isDefined(var_14)) {
      var_14 = var_14 + "%";

    }
    var_15 = var_8._id_18D3["credits"];
    var_16 = _id_3F6A(var_8, "credits");
    var_17 = var_8._id_18D3["downed"];
    var_18 = _id_3F6A(var_8, "downed");
    var_19 = var_8._id_18D3["revives"];
    var_20 = _id_3F6A(var_8, "revives");
    var_8 maps\_utility::_id_25DC(level._id_17F6);

    if(maps\_utility::_id_12C1()) {
      setdvar("ui_hide_hint", 1);
      var_8 maps\_utility::_id_16C7("", "@SPECIAL_OPS_PERFORMANCE_YOU", "@SPECIAL_OPS_PERFORMANCE_PARTNER");
      var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_KILLS", var_9, var_10);
      var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_HEADSHOT", var_11, var_12);
      var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_ACCURACY", var_13, var_14);
      var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_REVIVES", var_19, var_20);
      var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_CREDITS_EARNED", var_15, var_16);
      var_8 maps\_utility::_id_16C8();
      var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_TIME", var_5);
      var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_SCORE", var_6);
      continue;
    }

    setdvar("ui_hide_hint", 0);
    var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_KILLS", var_9);
    var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_HEADSHOT", var_11);
    var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_ACCURACY", var_13);
    var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_CREDITS_EARNED", var_15);
    var_8 maps\_utility::_id_16C8();
    var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_TIME", var_5);
    var_8 maps\_utility::_id_16C7("@SO_SURVIVAL_PERFORMANCE_SCORE", var_6);
  }
}

_id_3F6C() {
  wait 0.05;
  _id_0626::_id_3ECC();
  thread _id_3F6D();
  thread _id_3F6E();

  if(getdvarint("survival_chaos") == 1) {
    thread maps\_so_survival_chaos::chaos_wave();
  } else {
    thread _id_3D47();

  }
  thread _id_3FB8();
  thread _id_3FB1();
  thread _id_3FD9();
}

_id_3F6D() {
  wait 2;

  if(getdvarint("survival_chaos") == 1) {
    objective_add(1, "active", &"SO_SURVIVAL_CHAOS_OBJECTIVE");
  } else {
    objective_add(1, "active", &"SO_SURVIVAL_SURVIVAL_OBJECTIVE");

  }
  objective_current_nomessage(1);
}

_id_3F6E() {
  level waittill("so_player_has_died");

  if(!common_scripts\utility::flag("start_survival")) {
    common_scripts\utility::flag_wait("start_survival");

  }
  if(!common_scripts\utility::flag("so_player_death_nofail")) {
    return;
  }
  common_scripts\utility::flag_set("win_survival");
}

_id_3F6F() {
  level endon("special_op_terminated");

  for(;;) {
    level waittill("wave_ended", var_0);

    if(var_0 >= 0) {
      common_scripts\utility::flag_set("so_player_death_nofail");
      return;
    }
  }
}

_id_3F70() {
  common_scripts\utility::flag_wait_or_timeout("start_survival", 5);
}

_id_3F71() {
  if(level.console) {
    setsaveddvar("aim_aimAssistRangeScale", "1");
    setsaveddvar("aim_autoAimRangeScale", "0");
  }

  var_0 = getEntArray("trigger_hurt", "classname");

  foreach(var_2 in level.players) {
    var_2 thread _id_3F7F();
    var_2 thread _id_1C65();

    foreach(var_4 in var_0) {}
    var_2 thread hurtplayersthink(var_4);
  }

  thread _id_3F93();
  _id_3F70();
  level._id_00D9 = [];
  level._id_00DA = [];

  foreach(var_2 in level.players) {
    var_2 thread _id_3FA8();
    var_2 thread _id_3F78();
    var_2 thread _id_3F79();
    var_2 thread _id_00DB();
  }
}

_id_00DB() {
  self endon("death");
  self endon("disconnect");
  thread _id_00DC();
  thread _id_00DD();
}

_id_00DC() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(var_0) && isDefined(var_1) && isDefined(weaponinventorytype(var_1)) && weaponinventorytype(var_1) == "item" && issubstr(var_1, "c4")) {
      if(level._id_00D9.size) {
        level._id_00D9 = common_scripts\utility::array_removeundefined(level._id_00D9);

        if(level._id_00D9.size >= 20) {
          level._id_00D9[0] detonate();
        }
      }

      level._id_00D9[level._id_00D9.size] = var_0;
    }
  }
}

_id_00DD() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(var_0) && isDefined(var_1) && isDefined(weaponinventorytype(var_1)) && weaponinventorytype(var_1) == "item" && issubstr(var_1, "claymore")) {
      if(level._id_00DA.size) {
        level._id_00DA = common_scripts\utility::array_removeundefined(level._id_00DA);

        if(level._id_00DA.size >= 20) {
          level._id_00DA[0] detonate();
        }
      }

      level._id_00DA[level._id_00DA.size] = var_0;
    }
  }
}

_id_1C65() {
  self endon("death");
  self takeallweapons();
  _id_3F72("weapon_1");
  _id_3F72("weapon_2");
  _id_3F72("weapon_3");
  _id_3F73("grenade_1");
  _id_3F73("grenade_2");
  _id_3F74("armor_1");
  wait 0.05;
  _id_3F75("equipment_1");
  _id_3F75("equipment_2");
  _id_3F75("equipment_3");
  _id_3F76("airsupport_1");
  _id_3F76("airsupport_2");
  _id_3F76("airsupport_3");
  _id_3F77("perk_1");
  _id_3F77("perk_2");
  _id_3F77("perk_3");
}

_id_3F72(var_0) {
  var_1 = _id_3F62(var_0);
  var_2 = _id_3F64(var_1);

  if(var_1 != "") {
    self giveweapon(var_1);
    var_3 = weaponclass(var_1);

    if(var_3 == "pistol") {
      level._id_1AB1 = var_1;

    }
    if(var_2 == "max") {
      self setweaponammostock(var_1, weaponmaxammo(var_1));
    } else {
      self setweaponammostock(var_1, int(var_2));

    }
    if(var_0 == "weapon_1") {
      self switchtoweapon(var_1);
    }
  }
}

_id_3F73(var_0) {
  var_1 = _id_3F62(var_0);
  var_2 = _id_3F64(var_1);

  if(var_1 != "") {
    self giveweapon(var_1);

    if(var_2 == "max") {
      self setweaponammostock(var_1, weaponmaxammo(var_1));
    } else {
      self setweaponammostock(var_1, int(var_2));

    }
    if(var_1 == "flash_grenade") {
      self setoffhandsecondaryclass("flash");
    }
  }
}

_id_3F74(var_0) {
  var_1 = _id_3F62(var_0);
  var_2 = int(_id_3F64(var_1));

  if(var_1 != "") {
    _id_0626::_id_3F1A(var_1, var_2);
  }
}

_id_3F75(var_0) {
  var_1 = _id_3F62(var_0);

  if(var_1 != "") {
    var_2 = _id_0626::_id_3EFC("equipment", var_1);
    self thread[[var_2]](var_1);
  }
}

_id_3F76(var_0) {
  var_1 = _id_3F62(var_0);

  if(var_1 != "") {
    var_2 = _id_0626::_id_3EFC("airsupport", var_1);
    self thread[[var_2]](var_1);
  }
}

_id_3F77(var_0) {
  var_1 = _id_3F62(var_0);

  if(var_1 != "") {
    thread _id_0615::_id_3C53(var_1);
  }
}

_id_3F78() {
  if(!maps\_utility::_id_12C1()) {
    return;
  }
  for(;;) {
    level waittill("wave_ended");
    var_0 = 120;
    var_0 = var_0 - level._id_17F6 * 8;
    var_0 = max(var_0, 30);
    self._id_132B._id_132D = var_0;
  }
}

_id_3F79() {
  level endon("special_op_terminated");
  self endon("death");

  if(!isDefined(self._id_3F7A)) {
    self._id_3F7A = [];

  }
  var_0 = self getweaponslistprimaries();

  for(;;) {
    self waittill("weapon_change", var_1);

    if(!_id_3F7B(var_1)) {
      continue;
    }
    var_2 = !maps\_utility::_id_0AD1(var_0, var_1);

    if(!var_2) {
      continue;
    }
    if(!_id_3F7C(var_1)) {
      if(_id_3F7D(var_1)) {
        _id_3F07(var_1);
      }
    }

    var_3 = self getweaponslistprimaries();

    foreach(var_5 in var_0) {
      if(!maps\_utility::_id_0AD1(var_3, var_5)) {
        if(!_id_3F7B(var_5)) {
          continue;
        }
        _id_3F07(var_5);
      }
    }

    var_0 = var_3;
    _id_3F7E();
  }
}

_id_3F7B(var_0) {
  if(weaponclass(var_0) == "none" || weaponclass(var_0) == "rocketlauncher" || weaponclass(var_0) == "item") {
    return 0;

  }
  if(weaponinventorytype(var_0) != "primary") {
    return 0;

  }
  return 1;
}

_id_3F7C(var_0) {
  if(!isDefined(self._id_3F7A)) {
    return 0;

  }
  if(!isDefined(self._id_3F7A[var_0])) {
    return 0;

  }
  if(gettime() - self._id_3F7A[var_0] <= 10000) {
    return 1;

  }
  return 0;
}

_id_3F7D(var_0) {
  var_1 = self getweaponammoclip(var_0);
  var_2 = self getweaponammostock(var_0);
  var_3 = weaponclipsize(var_0);
  var_4 = weaponmaxammo(var_0);

  if(var_1 == var_3) {
    return 0;

  }
  if(var_2 <= 0) {
    return 0;

  }
  var_5 = var_3 - var_1;
  var_6 = 0;

  if(var_5 > var_2) {
    var_6 = var_2;
  } else {
    var_6 = var_5;

  }
  self setweaponammoclip(var_0, var_1 + var_6);
  self setweaponammostock(var_0, var_2 - var_6);
  return 1;
}

_id_3F07(var_0) {
  if(!isDefined(self._id_3F7A)) {
    self._id_3F7A = [];

  }
  self._id_3F7A[var_0] = gettime();
}

_id_3F7E() {
  if(!isDefined(self._id_3F7A) || !self._id_3F7A.size) {
    return;
  }
  var_0 = [];

  foreach(var_3, var_2 in self._id_3F7A) {
    if(_id_3F7C(var_3)) {
      var_0[var_3] = self._id_3F7A[var_3];
    }
  }

  self._id_3F7A = var_0;
}

_id_3F7F() {
  self disableweapons();
  self disableoffhandweapons();
  self freezecontrols(1);

  if(isDefined(self._id_1C9B)) {
    self detachall();
    self setModel("");
  }

  var_0 = 1.75;
  var_1 = 16000;
  var_2 = self.origin;
  self playersetstreamorigin(var_2);
  self.origin = var_2 + (0, 0, var_1);
  var_3 = spawn("script_model", (69, 69, 69));
  var_3 setModel("tag_origin");
  var_3.origin = self.origin;
  var_3.angles = self.angles;
  self playerlinkto(var_3, undefined, 1, 0, 0, 0, 0);
  var_3.angles = (var_3.angles[0] + 89, var_3.angles[1], 0);
  var_3 moveto(var_2 + (0, 0, 0), var_0, 0, var_0);
  wait 0.05;
  self playSound("survival_slamzoom_out");
  wait(var_0 - 0.55);
  self visionsetnakedforplayer("coup_sunblind", 0.25);
  var_3 rotateto((var_3.angles[0] - 89, var_3.angles[1], 0), 0.5, 0.3, 0.2);
  wait 0.2;
  self visionsetnakedforplayer("", 1.0);
  wait 0.5;
  self unlink();
  self enableweapons();
  self enableoffhandweapons();
  self freezecontrols(0);
  self playerclearstreamorigin();
  self notify("player_update_model");
  wait 0.5;
  common_scripts\utility::flag_set("slamzoom_finished");
  var_3 delete();
}

_id_3F80() {
  level._id_3AB2 = 0;
  level._id_3AB1 = 1;
  level._id_3F51 = 0;
  level._id_3BD8._id_3BD9 = 12;
  setsaveddvar("g_compassShowEnemies", "0");
  common_scripts\utility::array_thread(level.players, _id_0612::_id_3C49);
  maps\_utility::_id_1A5A("axis", _id_0618::_id_3E13);
  level._id_17F6 = 1;
  level thread _id_3F81();
}

_id_3F81() {
  level endon("special_op_terminated");
  var_0 = undefined;
  var_1 = 0;

  for(;;) {
    level waittill("wave_ended", var_2);
    var_3 = var_2 + 1;

    if(!_id_061C::_id_3DFF(var_3)) {
      if(!isDefined(var_0)) {
        var_0 = 0;
        var_1 = 1;
      }

      if(var_0 == level._id_3D45.size) {
        var_0 = 0;
        var_1++;
      }

      var_4 = spawnStruct();
      var_4._id_3D4A = var_3 - 1;
      var_4._id_1E2E = var_3;
      var_4._id_3D4B = level._id_3D45[var_0]._id_3D4B;
      var_4._id_3D4C = level._id_3D45[var_0]._id_3D4C;
      var_4._id_3D4D = level._id_3D45[var_0]._id_3D4D;
      var_4._id_3D4E = level._id_3D45[var_0]._id_3D4E;
      var_4._id_3D50 = level._id_3D45[var_0]._id_3D50;
      var_4._id_3D51 = level._id_3D45[var_0]._id_3D51;
      var_4._id_3D4F = level._id_3D45[var_0]._id_3D4F;
      var_4._id_3D52 = level._id_3D45[var_0]._id_3D52;
      var_4._id_3D53 = level._id_3D45[var_0]._id_3D53;
      var_4._id_3D54 = level._id_3D45[var_0]._id_3D54;
      var_5 = level._id_3D47[var_2];
      level._id_3D47 = [];
      level._id_3D47[var_2] = var_5;
      level._id_3D47[var_4._id_1E2E] = var_4;
      var_0++;
      level._id_3D46++;
    }
  }
}

_id_3D47() {
  level endon("special_op_terminated");
  _id_3F80();
  thread _id_3FB6();
  _id_3F70();

  if(!common_scripts\utility::flag("start_survival")) {
    common_scripts\utility::flag_set("start_survival");

  }
  level notify("wave_started", level._id_17F6);
  setsaveddvar("bg_viewKickScale", "0.2");

  for(;;) {
    if(isDefined(level._id_3B70.size) && level._id_3B70.size >= 3) {}

    var_0 = _id_061C::_id_3E04(level._id_17F6);
    var_1 = 0;

    foreach(var_3 in var_0) {
      if(var_3 > 0) {
        var_1 = var_1 + _id_3F8A(1, var_3);
      }
    }

    level._id_3D71 = [];
    var_5 = _id_061C::_id_3E05(level._id_17F6);

    if(isDefined(var_5)) {
      foreach(var_7 in var_5) {
        if(issubstr(var_7, "dog")) {
          thread _id_061C::_id_3DBA(var_7, _id_061C::_id_3E0D(level._id_17F6));
          continue;
        }

        var_8 = _id_061C::_id_3E07(level._id_17F6, var_7);

        if(isDefined(var_8) && var_8 > 0) {
          var_9 = _id_3F8C(var_7, var_8);
        }
      }
    }

    if(var_0[0] > 0) {
      thread _id_3F8D(1, var_0[0]);

    }
    if(_id_3F8F(level._id_17F6)) {
      thread _id_3F90();

    }
    level thread _id_3F82();

    for(var_11 = getaiarray("axis").size + _id_061C::_id_3DC3(); var_11 > 4; var_11 = getaiarray("axis").size + _id_061C::_id_3DC3()) {
      level common_scripts\utility::waittill_any_timeout(1.0, "axis_died");

    }
    common_scripts\utility::flag_set("aggressive_mode");
    _id_0610::_id_3B72(0, _id_061C::_id_3D7A);
    level._id_3B85 = _id_061C::_id_3D74;
    level._id_3D48 = _id_061C::_id_3D74;

    if(isDefined(level._id_3D71) && level._id_3D71.size > 0) {
      foreach(var_13 in level._id_3D71) {}
      var_13 thread _id_061C::_id_3D74();
    }

    for(var_11 = getaiarray("axis").size + _id_061C::_id_3DC3(); var_11 > 0; var_11 = getaiarray("axis").size + _id_061C::_id_3DC3()) {
      level common_scripts\utility::waittill_any_timeout(1.0, "axis_died");

    }
    level._id_3B85 = _id_061C::_id_3D72;
    level._id_3D48 = _id_061C::_id_3D72;

    if(_id_3F8F(level._id_17F6)) {
      common_scripts\utility::flag_wait("bosses_spawned");

      while(isDefined(level._id_3D64) && level._id_3D64.size) {
        wait 0.1;
      }
    }

    common_scripts\utility::flag_clear("aggressive_mode");
    level notify("wave_ended", level._id_17F6);
    setsaveddvar("g_compassShowEnemies", "0");

    if(common_scripts\utility::flag("boss_music")) {
      level notify("end_boss_music");
      common_scripts\utility::flag_clear("boss_music");
      maps\_utility::_id_1427(3);
    }

    _id_3F89();
    _id_3F51();
    level._id_17F6++;
    level notify("wave_started", level._id_17F6);
  }
}

_id_3F82() {
  level endon("wave_ended");
  wait 7;
  setsaveddvar("g_compassShowEnemies", "1");
}

_id_3F51() {
  level endon("special_op_terminated");
  level._id_3F51 = 1;
  var_0 = 30;
  var_1 = 5;

  if(var_0 > 0) {
    wait 5;
    var_0 = var_0 - 5;
    common_scripts\utility::array_thread(level.players, ::_id_3F83, "survival_all_ready", var_0 + var_1);
    level common_scripts\utility::waittill_any_timeout(var_0, "survival_all_ready");
    level notify("survival_all_ready");
  }

  foreach(var_3 in level.players) {}
  var_3 thread matchstarttimer(var_1);

  wait(var_1);
  level._id_3F51 = 0;
}

_id_3F83(var_0, var_1) {
  self endon("death");
  level endon("special_op_terminated");
  level endon(var_0);
  var_2 = maps\_specialops::_id_185B() - 130;
  self._id_3F84 = maps\_specialops::_id_16B6(-2, var_2, &"SO_SURVIVAL_READY_UP", self, 1);
  self._id_3F84 _id_3F86();
  thread _id_3F87("survival_player_ready", var_0, self._id_3F84, var_1);
  thread _id_3F88(var_0);

  if(level.console) {
    self notifyonplayercommand("survival_player_ready", "+stance");
  } else {
    self notifyonplayercommand("survival_player_ready", "skip");

  }
  self waittill("survival_player_ready");

  if(!isDefined(level._id_3F85)) {
    level._id_3F85 = 1;
  } else {
    level._id_3F85++;

  }
  self._id_3F84 maps\_specialops::_id_185C(1);

  if(level._id_3F85 == level.players.size) {
    level notify(var_0);
  } else {
    var_3 = maps\_utility::_id_133A(self);

    if(isDefined(var_3) && isDefined(var_3._id_3F84)) {
      var_3._id_3F84.label = &"SO_SURVIVAL_PARTNER_READY";

    }
    self._id_3F84 = maps\_specialops::_id_16B6(-2, var_2, &"SO_SURVIVAL_READY_UP_WAIT", self, 1);
    self._id_3F84 _id_3F86();
  }
}

_id_3F86() {
  self.alignx = "left";
  self.fontscale = 0.75;
  self.alpha = 0.0;

  if(issplitscreen()) {
    self.horzalign = "center";
    self.x = 36;
    self.y = -22;
  }

  thread maps\_hud_util::fade_over_time(1.0, 0.5);
}

_id_3F87(var_0, var_1, var_2, var_3) {
  level endon(var_1);
  self endon(var_0);

  for(var_3 = int(var_3); isDefined(var_2) && var_3 > 0; var_3--) {
    var_2 setvalue(var_3);
    wait 1.0;
  }
}

_id_3F88(var_0) {
  level waittill(var_0);
  level._id_3F85 = undefined;

  if(isDefined(self._id_3F84)) {
    self._id_3F84 maps\_specialops::_id_185C(1);
  }
}

_id_3F89() {
  foreach(var_1 in level.players) {
    if(maps\_utility::_id_1A43(var_1)) {
      var_1._id_1A89 = 1;
    }
  }
}

_id_3F8A(var_0, var_1) {
  level endon("special_op_terminated");

  for(var_0 = int(var_0); var_0; var_0--) {
    var_2 = _id_0610::_id_3B7B(level._id_3DBD, _id_3F8B("leader"), _id_3F8B("follower"), var_1 - 1);

    foreach(var_4 in var_2) {
      var_4 setthreatbiasgroup("axis");
      var_4 thread _id_061C::_id_3DE9();
    }
  }

  return level._id_3B70.size;
}

_id_3F8B(var_0) {
  var_1 = _id_061C::_id_3E03(level._id_17F6);
  var_2 = _id_061C::_id_3DF5(var_1);

  if(isDefined(var_0)) {}

  return var_2;
}

_id_3F8C(var_0, var_1) {
  var_2 = [];
  var_2[var_2.size] = level.player;

  if(maps\_utility::_id_12C1()) {
    var_2[var_2.size] = level.players[1];

  }
  var_3 = _id_061C::_id_3DF5(var_0);
  var_4 = _id_0618::_id_3E3A(var_3)[0];

  for(var_5 = 0; var_5 < var_1; var_5++) {
    wait 0.05;
    var_6 = _id_0618::_id_3DBE(level._id_3DBD, var_2, 4);
    var_4.count = 1;
    var_4.origin = var_6.origin;
    var_4.angles = var_6.angles;

    if(getdvarint("survival_chaos") == 1) {
      var_7 = var_4 maps\_utility::_id_166F();
    } else {
      var_7 = var_4 maps\_utility::_id_166F(1);

    }
    if(isDefined(var_7)) {
      var_7 setthreatbiasgroup("axis");
      var_7._id_3D5D = _id_061C::_id_3DF4(var_0);
      level._id_3D71[level._id_3D71.size] = var_7;
      var_7 thread _id_0618::_id_3E3C();
      var_7 thread _id_061C::_id_3DE9();
      var_7 thread[[level._id_3D48]]();
    }
  }

  return level._id_3D71;
}

_id_3F8D(var_0, var_1) {
  level endon("special_op_terminated");
  level endon("wave_ended");
  var_2 = level._id_3B70.size;
  var_3 = 0;

  while(var_3 < var_0) {
    if(level._id_3B70.size >= var_2) {
      wait 0.05;
      continue;
    }

    var_4 = getaiarray();

    if(var_4.size >= 32 - var_1) {
      wait 0.05;
      continue;
    }

    var_5 = _id_0610::_id_3B7B(level._id_3DBD, _id_3F8B("leader"), _id_3F8B("follower"), var_1 - 1);

    foreach(var_7 in var_5) {
      var_7 setthreatbiasgroup("axis");
      var_7 thread _id_061C::_id_3DE9();
    }

    var_3++;
  }
}

_id_3F8E(var_0, var_1) {
  level endon("special_op_terminated");
  level endon("wave_ended");
  var_2 = level._id_3D71.size;
  var_3 = 0;

  while(var_3 < var_1) {
    if(level._id_3D71.size >= var_2) {
      wait 0.05;
      continue;
    }

    var_4 = getaiarray();

    if(var_4.size > 31) {
      wait 0.05;
      continue;
    }

    _id_3F8C(var_0, 1);
    var_3++;
    wait 0.05;
  }
}

_id_3F8F(var_0) {
  var_1 = _id_061C::_id_3E08(var_0);
  var_2 = _id_061C::_id_3E09(var_0);

  if(isDefined(var_1) || isDefined(var_2)) {
    return 1;

  }
  return 0;
}

_id_3F90() {
  common_scripts\utility::flag_clear("bosses_spawned");

  if(level._id_3D47[level._id_17F6]._id_3D4F && common_scripts\utility::flag_exist("aggressive_mode") && !common_scripts\utility::flag("aggressive_mode")) {
    common_scripts\utility::flag_wait("aggressive_mode");

  }
  level notify("boss_spawning", level._id_17F6);
  level._id_3D64 = [];
  var_0 = _id_061C::_id_3E08(level._id_17F6);
  var_1 = _id_061C::_id_3E09(level._id_17F6);

  if(isDefined(var_0)) {
    if(getdvarint("survival_chaos") == 1) {
      _id_3F91(var_0, 0);
    } else {
      _id_3F91(var_0, 1);

    }
    if(level._id_3D64.size && isDefined(var_1)) {
      level common_scripts\utility::waittill_any_timeout(30, "juggernaut_jumpedout");
      wait 6;
    }
  }

  if(isDefined(var_1)) {
    thread _id_3F92(var_1, !isDefined(var_0));

  }
  common_scripts\utility::flag_set("bosses_spawned");
}

_id_3F91(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(var_3 == "jug_minigun") {
      continue;
    }
    if(!issubstr(var_3, "jug_")) {
      continue;
    }
    var_4 = _id_0618::_id_3E3D(_id_0618::_id_3E45(), "drop_path_start", "script_unload");
    thread _id_061C::_id_3DC7(var_3, var_4);
    wait 0.5;
  }

  if(var_1) {
    thread _id_3FB7("juggernaut");
  }
}

_id_3F92(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(issubstr(var_3, "chopper")) {
      var_4 = _id_0618::_id_3E3D(_id_0618::_id_3E45(), "chopper_boss_path_start", "script_stopnode");
      var_5 = _id_061C::_id_3DE0(var_3, var_4);
      continue;
    }
  }

  if(var_1) {
    thread _id_3FB7("chopper");
  }
}

spawn_allies(var_0, var_1, var_2) {
  var_3 = _id_0618::_id_3E3D(var_0, "drop_path_start", "script_unload");
  level notify("so_airsupport_incoming", var_1);
  _id_061C::_id_3DE2(var_1, 3, var_3, var_2);
}

_id_3F93() {
  wait 0.05;
  level._id_3F94["accuracy"] = 3;
  level._id_3F94["damagetaken"] = 2;
  level._id_3F94["time"] = 2;

  if(maps\_utility::_id_12C1()) {
    level._id_3F94["wavebonus"] = 50;
    level._id_3F94["headshot"] = 50;
    level._id_3F94["kill"] = 50;
  } else {
    level._id_3F94["wavebonus"] = 25;
    level._id_3F94["headshot"] = 20;
    level._id_3F94["kill"] = 10;
  }

  foreach(var_1 in level.players) {
    var_1._id_18D3 = [];
    var_1._id_18D3["headshot"] = 0;
    var_1._id_18D3["accuracy"] = 0;
    var_1._id_18D3["damagetaken"] = 0;
    var_1._id_18D3["kill"] = 0;
    var_1._id_18D3["credits"] = 0;
    var_1._id_18D3["downed"] = 0;
    var_1._id_18D3["revives"] = 0;
    var_1._id_3F95 = [];
    var_1._id_3F95["headshot"] = 0;
    var_1._id_3F95["accuracy"] = 0;
    var_1._id_3F95["time"] = 0;
    var_1._id_3F95["damagetaken"] = 0;
    var_1._id_3F95["kill"] = 0;
    var_1._id_3F95["wavebonus"] = 0;
    var_1 _id_3FD2();
    var_1 thread _id_3F97();
  }

  maps\_utility::_id_1A5A("axis", ::_id_3F9E);
}

_id_3F96() {
  maps\_specialops::_id_18A6("surHUD_performance_reward", 0);

  foreach(var_2, var_1 in self._id_3F95) {
    self._id_3F95[var_2] = 0;
    maps\_specialops::_id_18A7("surHUD_performance", var_2, 0);
    maps\_specialops::_id_18A7("surHUD_performance_p2", var_2, 0);
    maps\_specialops::_id_18A7("surHUD_performance_credit", var_2, 0);
  }
}

_id_3F97() {
  self endon("death");
  thread _id_3F99();
  thread _id_3F9B();
  thread _id_3F9A();
  thread _id_3F9C();
  thread _id_3F9D();
  thread _id_3F9F();
  thread _id_3FA2();
  thread _id_3FA3();
  thread _id_3FA4();

  for(;;) {
    level waittill("wave_ended");
    maps\_player_stats::_id_0A3A("waves_survived", 1);
    waittillframeend;
    var_0 = _id_3FA6();

    if(var_0["total"]) {
      thread maps\_utility::_id_12BE("personal_wave_reward", var_0["total"]);

    }
    thread _id_3FD3(var_0);
    level waittill("wave_started");
    self._id_3F98 = 0;
  }
}

_id_3F99() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    level waittill("wave_started");
    _id_3F96();
    self.stats["kills"] = 0;
    self.stats["shots_fired"] = 0;
    self.stats["shots_hit"] = 0;
  }
}

_id_3F9A() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("so_revive_success");
    self._id_18D3["revives"]++;
  }
}

_id_3F9B() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("player_downed");
    self._id_18D3["downed"]++;
  }
}

_id_3F9C() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    self waittill("deposit_credits", var_0, var_1);

    if(self._id_3ED7 >= 50000 && !isDefined(self._id_00DE)) {
      self._id_00DE = 1;
      thread maps\_specialops::_id_01DF("GET_RICH_OR_DIE_TRYING");
    }

    if(isDefined(var_1) && var_1) {
      continue;
    }
    if(var_0 > 0) {
      self._id_18D3["credits"] = self._id_18D3["credits"] + var_0;
    }
  }
}

_id_3F9D() {
  level endon("special_op_terminated");
  self endon("death");
  _id_3F70();

  for(;;) {
    var_0 = gettime();
    level waittill("wave_ended");
    self._id_3F95["time"] = gettime() - var_0;
    level waittill("wave_started");
  }
}

_id_3F9E() {
  level endon("special_op_terminated");

  if(!isai(self)) {
    return;
  }
  var_0 = 0;
  self waittill("death", var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  if(_id_0618::_id_0A32() && isplayer(var_1)) {
    var_8 = "player.performance array is missing headshot setting";
    var_1._id_3F95["headshot"]++;
    var_1._id_18D3["headshot"]++;
    var_1 notify("sur_ch_headshot");
  }
}

_id_3F9F() {
  level endon("special_op_terminated");
  self endon("death");

  if(isDefined(self._id_3F16)) {
    self._id_3FA0 = self._id_3F16["points"];
  } else {
    self._id_3FA0 = 0;

  }
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_1) && var_1 != self && isDefined(var_1.team) && var_1.team == self.team) {
      continue;
    }
    thread _id_3FA1(var_0);
  }
}

_id_3FA1(var_0) {
  var_1 = 100 + self._id_3FA0;
  var_2 = int(min(var_1, var_0));
  self._id_3F95["damagetaken"] = self._id_3F95["damagetaken"] + var_2;
  self._id_18D3["damagetaken"] = self._id_18D3["damagetaken"] + var_2;
  waittillframeend;

  if(isDefined(self._id_3F16)) {
    self._id_3FA0 = self._id_3F16["points"];
  } else {
    self._id_3FA0 = 0;
  }
}

_id_3FA2() {
  level endon("special_op_terminated");
  self endon("death");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    self waittill("weapon_fired");
    var_2 = max(1, float(self.stats["shots_fired"]));
    var_3 = float(self.stats["shots_hit"]);
    var_0 = var_0 + var_2;
    var_1 = var_1 + var_3;
    self._id_3F95["accuracy"] = _id_0618::_id_3E40(100 * (var_3 / var_2), 0, 100);
    self._id_18D3["accuracy"] = _id_0618::_id_3E40(100 * (var_1 / var_0), 0, 100);
  }
}

_id_3FA3() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    level waittill("specops_player_kill", var_0);

    if(isDefined(var_0) && isplayer(var_0) && var_0 == self) {
      self._id_3F95["kill"]++;
      self._id_18D3["kill"]++;
    }
  }
}

_id_3FA4() {
  level endon("special_op_terminated");
  self endon("death");

  for(;;) {
    level waittill("wave_ended", var_0);
    self._id_3F95["wavebonus"] = var_0;

    if(!isDefined(self._id_00DF)) {
      self._id_00DF = 1;
      thread maps\_specialops::_id_01DF("I_LIVE");
    }

    if(var_0 == 9) {
      thread maps\_specialops::_id_01DF("SURVIVOR");

    }
    if(var_0 == 14) {
      thread maps\_specialops::_id_01DF("UNSTOPPABLE");
    }
  }
}

_id_3FA6() {
  var_0 = self._id_3F95["headshot"] * level._id_3F94["headshot"];
  var_1 = int(max(self._id_3F95["accuracy"] - 25, 0)) * level._id_3F94["accuracy"];
  var_2 = 400;
  var_2 = var_2 - self._id_3F95["damagetaken"] * level._id_3F94["damagetaken"];
  var_2 = int(max(var_2, 0));
  var_3 = self._id_3F95["kill"] * level._id_3F94["kill"];
  var_4 = 0;
  var_5 = 90;
  var_6 = max(var_5 - int(self._id_3F95["time"] / 1000), 0);
  var_4 = int(level._id_3F94["time"] * var_6);
  var_7 = self._id_3F95["wavebonus"] * level._id_3F94["wavebonus"];
  var_8 = [];
  var_8["time"] = var_4;
  var_8["headshot"] = var_0;
  var_8["accuracy"] = var_1;
  var_8["damagetaken"] = var_2;
  var_8["kill"] = var_3;
  var_8["wavebonus"] = var_7;
  var_9 = 0;

  foreach(var_11 in var_8) {}
  var_9 = var_9 + var_11;

  var_8["total"] = _id_3FA7(var_9);
  thread _id_3FD4(var_8);
  return var_8;
}

_id_3FA7(var_0) {
  return int(max(0, int(var_0)));
}

_id_3FA8() {
  self endon("death");

  if(!isDefined(self._id_3FA9)) {
    self._id_3FA9 = 0;

  }
  self._id_3FAA = [];
  self._id_3F98 = 0;
  thread _id_3FAD();
  var_0 = self.origin;
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    self._id_3FAB = 0;
    self._id_3FAC = self.origin;
    var_1 = 0;
    var_0 = self.origin;

    while(var_1 <= 20) {
      if(distance(var_0, self.origin) < 220) {
        var_1++;
      } else {
        var_1 = var_1 - 2;

      }
      if(self.health < 40) {
        var_1--;

      }
      if(self.stats["kills"] - var_2 > 0) {
        var_1 = var_1 + (self.stats["kills"] - var_2);

      }
      if(var_1 <= 0 || level._id_3F51 || maps\_utility::_id_133C("laststand_downed") && maps\_utility::_id_1008("laststand_downed")) {
        var_1 = 0;
        var_0 = self.origin;
      }

      var_2 = self.stats["kills"];
      wait 1;
    }

    self._id_3FAB = 1;
    self._id_3FAC = self.origin;
    self._id_3FAA[self._id_3FAA.size] = self._id_3FAC;
    self notify("camping");

    while(distance(var_0, self.origin) < 260) {
      self._id_3F98++;
      wait 1;
    }

    self notify("stopped camping");
  }
}

_id_3FAD() {
  self endon("death");
  level._id_3FAE = 8;

  for(;;) {
    wait 0.05;

    if(!isDefined(self._id_3FAB) || !isDefined(self._id_3FAC) || !isDefined(self._id_3F98)) {
      continue;
    }
    if(self._id_3FAB) {
      thread _id_3FAF(self._id_3FAC, self._id_3F98);
      thread _id_3FB0(self._id_3FAC, self._id_3F98);
      wait(level._id_3FAE);
    }
  }
}

_id_3FAF(var_0, var_1) {
  var_2 = getaiarray("axis");

  foreach(var_4 in var_2) {}
  var_4 thread _id_0618::_id_3E3B(self);
}

_id_3FB0(var_0, var_1) {
  if(isDefined(level._id_3D64) && level._id_3D64.size) {
    var_2 = level._id_3D64[randomint(level._id_3D64.size)];
  }
}

_id_3FB1() {
  level endon("special_op_terminated");

  foreach(var_1 in level.players) {}
  var_1 _id_3FB9();

  _id_3F70();

  foreach(var_1 in level.players) {
    var_1._id_3ED7 = 0;

    if(getdvarint("survival_chaos") != 1) {
      var_1 thread _id_3FB2();
      var_1 thread _id_3FB5();
    }
  }
}

_id_3FB2() {
  self endon("death");

  for(;;) {
    self._id_3FB3 = self._id_12CE["rankxp"];
    self._id_3FB4 = self._id_3ED7;
    self waittill("xp_updated", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    var_1 = self._id_12CE["rankxp"] - self._id_3FB3;
    self._id_3ED7 = self._id_3ED7 + var_1;

    if(isDefined(self._id_12CF) && self._id_12CF > var_1) {
      thread _id_3FBA(self._id_3FB4, self._id_12CF);
    } else {
      thread _id_3FBA(self._id_3FB4, var_1);

    }
    self notify("deposit_credits", var_1);
  }
}

_id_3FB5() {
  self endon("death");

  for(;;) {
    self._id_3FB3 = self._id_12CE["rankxp"];
    self._id_3FB4 = self._id_3ED7;
    self waittill("credit_updated", var_0);
    var_1 = self._id_3ED7 - self._id_3FB4;

    if(isDefined(self._id_12CF) && self._id_12CF > var_1) {
      thread _id_3FBA(self._id_3FB4, self._id_12CF);
    } else {
      thread _id_3FBA(self._id_3FB4, var_1);

    }
    self notify("deposit_credits", var_1, var_0);
  }
}

_id_3FB6(var_0) {
  level endon("special_op_terminated");
  var_1 = "so_survival_regular_music";
  wait 1.5;
  maps\_utility::_id_142B(var_1);
  wait 5;
  maps\_utility::_id_1427(20);
}

_id_3FB7(var_0) {
  level endon("special_op_terminated");
  level endon("end_boss_music");
  common_scripts\utility::flag_set("boss_music");
  maps\_utility::_id_1427(3);

  if(var_0 == "chopper") {
    var_1 = "so_survival_boss_music_01";
  } else if(var_0 == "juggernaut") {
    var_1 = "so_survival_boss_music_02";
  } else {
    var_1 = "so_survival_boss_music_01";

  }
  var_2 = maps\_utility::_id_142C(var_1) + 2;

  while(common_scripts\utility::flag("boss_music")) {
    maps\_utility::_id_142B(var_1);
    wait(var_2);
  }
}

_id_1B2C() {
  level endon("special_op_terminated");
}

_id_3FB8() {
  thread _id_1B2C();
  thread _id_3FD5();

  foreach(var_1 in level.players) {
    var_1 _id_0618::_id_3E36();
    var_1 thread _id_3FD0();
    var_1 thread _id_3FBF();

    if(getdvarint("survival_chaos") != 1) {
      var_1 thread _id_3FCD();

    }
    var_1 thread _id_3C63();
    var_1 thread _id_3FC8();
  }
}

_id_3FB9() {
  maps\_specialops::_id_18A6("surHUD_credits", 0);
  maps\_specialops::_id_18A6("surHUD_credits_delta", 0);
  maps\_specialops::_id_18A4("credits");
}

_id_3FBA(var_0, var_1) {
  self notify("stop_animate_credits");
  self endon("stop_animate_credits");
  maps\_specialops::_id_18A6("surHUD_credits_delta", 0);
  maps\_specialops::_id_189E("credits");
  maps\_specialops::_id_18A6("surHUD_credits", self._id_3ED7);
  maps\_specialops::_id_18A6("surHUD_credits_delta", var_1);
}

_id_3FBB() {
  level endon("special_op_terminated");
  var_0 = "Player is either dead or removed while trying to setup its hud.";
  var_1 = 28;
  var_2 = maps\_specialops::_id_185B();
  var_3 = var_2 + 12 + var_1;
  self._id_3FBC = maps\_specialops::_id_16B6(-1, var_2, &"SO_SURVIVAL_SURVIVE_TIME", self, 1);
  self._id_3FBD = maps\_specialops::_id_16B6(-1, var_2 - var_1, undefined, self, 1);
  self._id_3FBC.alignx = "left";
  self._id_3FBD.alignx = "left";
  self._id_3FBD setshader("hud_show_timer", var_1, var_1);
  self._id_3FBD.alpha = 0;
  self._id_3FBC.alpha = 0;
  thread _id_3FBE(self._id_3FBC, self._id_3FBD);
}

_id_3FBE(var_0, var_1) {
  level endon("special_op_terminated");
  self endon("death");
  _id_3F70();

  for(;;) {
    var_0.label = "";
    var_0 settenthstimerup(0.0);
    var_2 = gettime();
    var_0 thread maps\_hud_util::fade_over_time(1.0, 0.5);
    var_1 thread maps\_hud_util::fade_over_time(1.0, 0.5);
    level waittill("wave_ended");
    var_0.label = "";
    var_3 = max(1, (gettime() - var_2) / 1000);
    var_0 settenthstimerstatic(var_3);
    var_4 = "";

    if(1) {
      var_4 = common_scripts\utility::waittill_any_timeout(1.75, "wave_started");

    }
    if(isDefined(var_4) && var_4 == "wave_started") {
      var_0 thread maps\_hud_util::fade_over_time(0.0, 0.0);
      var_1 thread maps\_hud_util::fade_over_time(0.0, 0.0);
      continue;
    }

    var_0 thread maps\_hud_util::fade_over_time(0.0, 0.5);
    var_1 thread maps\_hud_util::fade_over_time(0.0, 0.5);
    level waittill("wave_started");
  }
}

_id_3FBF() {
  self endon("death");
  self._id_3FC0 = 0;

  if(issplitscreen()) {
    self._id_3FC1 = 112 + (self == level.player) * 27;
  } else {
    self._id_3FC1 = 196;

  }
  if(getdvarint("survival_chaos") == 1) {
    self._id_3FC2 = 38;
  } else {
    self._id_3FC2 = 28;

  }
  self._id_3FC3 = _id_3FCF(self._id_3FC0, self._id_3FC1);
  self._id_3FC3 setshader("teamperk_blast_shield", self._id_3FC2, self._id_3FC2);
  self._id_3FC3.alpha = 0.85;
  self._id_3FC4 = _id_3FCF(self._id_3FC0, self._id_3FC1);
  self._id_3FC4.alpha = 0;
  thread _id_3FC6();
  waittillframeend;

  for(;;) {
    if(isDefined(self._id_3F16) && isDefined(self._id_3F16["points"]) && self._id_3F16["points"]) {
      if(getdvarint("survival_chaos") == 1) {
        var_0 = 250;
      } else {
        var_0 = 100;

      }
      var_1 = _id_0618::_id_3E41(self._id_3F16["points"] / (var_0 / 2), 0, 1);
      var_2 = 1 - _id_0618::_id_3E41((self._id_3F16["points"] - var_0 / 2) / (var_0 / 2), 0, 1);
      self._id_3FC3.alpha = 0.85;
      self._id_3FC3.color = (1, _id_0618::_id_3E41(var_1, 0, 0.95), _id_0618::_id_3E41(var_1, 0, 0.7));

      if(getdvarint("survival_chaos") == 1) {
        if(self._id_3F16["points"] < var_0) {
          thread _id_3FC5();
        }
      } else {
        thread _id_3FC5();
      }
    } else {
      self._id_3FC3.alpha = 0;

    }
    common_scripts\utility::waittill_any("damage", "health_update");
  }
}

_id_3FC5() {
  self endon("death");
  self._id_3FC4.alpha = 0.85;
  var_0 = 20;

  for(var_1 = 0; var_1 <= var_0; var_1++) {
    var_2 = randomint(int(max(1, 5 - var_1 / (var_0 / 5)))) - int(2 - var_1 / (var_0 / 2));
    self._id_3FC3.x = self._id_3FC0 + var_2;
    self._id_3FC3.y = self._id_3FC1 + var_2;
    var_3 = int(var_1 * (40 / var_0));
    self._id_3FC4 setshader("teamperk_blast_shield", self._id_3FC2 + var_3, self._id_3FC2 + var_3);
    self._id_3FC4.alpha = max((var_0 * 0.85 - var_1) / var_0, 0);
    wait 0.05;
  }

  self._id_3FC4.alpha = 0;
  self._id_3FC3.x = self._id_3FC0;
  self._id_3FC3.y = self._id_3FC1;
}

_id_3FC6(var_0) {
  self endon("death");
  self._id_3FC7 = _id_3FCF(self._id_3FC0, self._id_3FC1);
  self._id_3FC7.alpha = 0.85;
  self._id_3FC7.elemtype = "font";
  self._id_3FC7.label = &"SO_SURVIVAL_ARMOR_POINTS";
  self._id_3FC7.y = self._id_3FC7.y - 2;
  self._id_3FC7.x = self._id_3FC7.x - 58;
  self._id_3FC7.font = "hudbig";
  self._id_3FC7.fontscale = 0.5;
  self._id_3FC7.width = 0;
  self._id_3FC7.color = (1, 0.95, 0.7);
  self._id_3FC7.alignx = "left";

  if(isDefined(self._id_3F16)) {
    self._id_3FC7 setvalue(self._id_3F16["points"]);
  } else {
    self._id_3FC7 setvalue(0);

  }
  var_1 = 14;

  for(;;) {
    if(!isDefined(self._id_3F16) || !isDefined(self._id_3F16["points"]) || !self._id_3F16["points"]) {
      self._id_3FC7.alpha = 0;
      wait 0.05;
      continue;
    }

    self._id_3FC7.alpha = 0.85;
    var_2 = "";
    var_3 = 2;
    var_4 = 6;

    while(var_4 > 0 || var_1 > 0) {
      var_2 = common_scripts\utility::waittill_any_timeout(0.5, "damage", "health_update");
      self._id_3FC7 setvalue(self._id_3F16["points"]);
      var_4 = var_4 - 0.5;

      if(var_1 > 0) {
        var_1 = var_1 - 0.5;

      }
      if(self._id_3F16["points"] <= 0) {
        var_3 = 0.5;
        break;
      }
    }

    self._id_3FC7 fadeovertime(var_3);
    self._id_3FC7.alpha = 0;

    if(var_2 != "damage" && var_2 != "health_update") {
      common_scripts\utility::waittill_any("damage", "health_update");
    }
  }
}

_id_3FC8() {
  self endon("death");
  maps\_specialops::_id_18A5("enemy");
  maps\_specialops::_id_18A6("surHUD_enemy", 0);

  for(;;) {
    level common_scripts\utility::waittill_either("axis_spawned", "axis_died");

    if(!common_scripts\utility::flag("aggressive_mode")) {
      maps\_specialops::_id_18A5("enemy");
      continue;
    }

    if(getdvarint("survival_chaos") != 1) {
      maps\_specialops::_id_18A4("enemy");
      maps\_specialops::_id_18A6("surHUD_enemy", level._id_3D62);
    }
  }
}

_id_3C63() {
  self endon("death");
  self._id_3FC9 = spawnStruct();

  if(getdvarint("survival_chaos") == 1) {
    self._id_3FC9._id_3FCA = -138 + level.perk_offset;
  } else {
    self._id_3FC9._id_3FCA = -138;

  }
  if(issplitscreen()) {
    self._id_3FC9._id_3FCB = 112 + (self == level.player) * 27;
  } else {
    self._id_3FC9._id_3FCB = 196;

  }
  self._id_3FC9._id_3FCC = 28;
  self._id_3FC9.icon = _id_3FCF(self._id_3FC9._id_3FCA, self._id_3FC9._id_3FCB);
  self._id_3FC9.icon.color = (1, 1, 1);
  self._id_3FC9.icon.alpha = 0.0;

  for(;;) {
    self waittill("give_perk", var_0);
    var_1 = level._id_3D68["airsupport"][var_0].icon;
    self._id_3FC9.icon setshader(var_1, self._id_3FC9._id_3FCC, self._id_3FC9._id_3FCC);
    self._id_3FC9.icon.alpha = 0.85;
  }
}

_id_3FCD() {
  self endon("death");
  self._id_3FCE = spawnStruct();
  self._id_3FCE._id_3FCA = -104;

  if(issplitscreen()) {
    self._id_3FCE._id_3FCB = 112 + (self == level.player) * 27;
  } else {
    self._id_3FCE._id_3FCB = 196;

  }
  self._id_3FCE._id_3FCC = 28;
  self._id_3FCE.icon = _id_3FCF(self._id_3FCE._id_3FCA, self._id_3FCE._id_3FCB);
  self._id_3FCE.icon setshader("specialty_self_revive", self._id_3FCE._id_3FCC, self._id_3FCE._id_3FCC);
  self._id_3FCE.icon.color = (1, 1, 1);
  self._id_3FCE.icon.alpha = 0.0;

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("laststand_lives_updated", "player_downed");

    if(var_0 == "player_downed") {
      self._id_3FCE.icon.alpha = 0.0;
      continue;
    }

    if(maps\_laststand::_id_1ABD() > 0) {
      self._id_3FCE.icon.alpha = 1;
      continue;
    }

    self._id_3FCE.icon.alpha = 0.0;
  }
}

_id_3FCF(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.hidden = 0;
  var_2.elemtype = "icon";
  var_2.hidewheninmenu = 1;
  var_2.archived = 0;
  var_2.x = var_0;
  var_2.y = var_1;
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "center";
  var_2.vertalign = "middle";
  return var_2;
}

_id_3FD0() {
  self endon("death");
  maps\_specialops::_id_18A5("wave");
  maps\_specialops::_id_18A6("surHUD_wave", 0);

  for(;;) {
    level waittill("wave_started");
    maps\_specialops::_id_18A4("wave");
    maps\_specialops::_id_18A6("surHUD_wave", level._id_17F6);
  }
}

matchstarttimer(var_0) {
  var_1 = _id_3FD1("hudbig", 1);
  var_1 maps\_hud_util::setpoint("CENTER", "CENTER", 0, 0);
  var_1.sort = 1001;
  var_1.glowcolor = (0.15, 0.35, 0.85);
  var_1.color = (0.95, 0.95, 0.95);
  var_1.foreground = 0;
  var_1.hidewheninmenu = 1;
  var_1 fontpulseinit();
  matchstarttimer_internal(int(var_0), var_1);
  var_1 destroy();
}

fontpulseinit(var_0) {
  self.basefontscale = self.fontscale;

  if(isDefined(var_0)) {
    self.maxfontscale = min(var_0, 6.3);
  } else {
    self.maxfontscale = min(self.fontscale * 2, 6.3);

  }
  self.inframes = 2;
  self.outframes = 4;
}

_id_3FD1(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "font";
  var_2.font = "hudbig";
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 maps\_hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

matchstarttimer_internal(var_0, var_1) {
  while(var_0 > 0) {
    if(var_0 > 99) {
      var_1.alpha = 0;
    } else {
      var_1.alpha = 1;

    }
    foreach(var_3 in level.players) {}
    var_3 playSound("so_countdown_beep");

    var_1 thread fontpulse();
    wait(var_1.inframes * 0.05);
    var_1 setvalue(var_0);
    var_0--;
    wait(1 - var_1.inframes * 0.05);
  }
}

fontpulse() {
  self notify("fontPulse");
  self endon("fontPulse");
  self endon("death");
  self changefontscaleovertime(self.inframes * 0.05);
  self.fontscale = self.maxfontscale;
  wait(self.inframes * 0.05);
  self changefontscaleovertime(self.outframes * 0.05);
  self.fontscale = self.basefontscale;
}

_id_3FD2() {
  _id_3F96();
  maps\_specialops::_id_18A5("performance");
}

_id_3FD3(var_0) {
  self endon("death");

  if(maps\_utility::_id_12C1()) {
    waittillframeend;

  }
  foreach(var_4, var_2 in self._id_3F95) {
    maps\_specialops::_id_18A7("surHUD_performance", var_4, self._id_3F95[var_4]);
    maps\_specialops::_id_18A7("surHUD_performance_credit", var_4, var_0[var_4]);

    if(maps\_utility::_id_12C1()) {
      var_3 = maps\_utility::_id_133A(self);
      maps\_specialops::_id_18A7("surHUD_performance_p2", var_4, var_3._id_3F95[var_4]);
    }
  }

  maps\_specialops::_id_18A6("surHUD_performance_reward", var_0["total"]);
  wait 1;
  maps\_specialops::_id_189E("performance");
}

_id_3FD4(var_0) {
  var_1 = "---------------------------------------------";
  var_2 = "COOP";

  if(!maps\_utility::_id_12C1()) {
    var_2 = "SOLO";

  }
  foreach(var_5, var_4 in var_0) {
    if(var_5 == "total") {
      continue;
    }
  }
}

_id_3FD5() {
  level endon("special_op_terminated");
  _id_3F70();

  for(;;) {
    level waittill("wave_started");
    thread _id_3FD6("");
    level waittill("wave_ended", var_0);
    _id_0618::_id_3E39(10);
    thread _id_3FD7(var_0);
  }
}

_id_3FD6(var_0) {
  var_1 = spawnStruct();
  var_1._id_3E1B = &"SO_SURVIVAL_WAVE_TITLE";
  var_1.duration = 1.5;
  var_1.sound = "survival_wave_start_splash";
  common_scripts\utility::array_thread(level.players, ::_id_3FD8, var_1);
}

_id_3FD7(var_0) {
  var_1 = spawnStruct();
  var_1._id_3E1B = &"SO_SURVIVAL_WAVE_SUCCESS_TITLE";
  var_1._id_3E1C = var_0;
  var_1.duration = 2.5;
  var_1.sound = "survival_wave_end_splash";
  common_scripts\utility::array_thread(level.players, ::_id_3FD8, var_1);
}

_id_3FD8(var_0) {
  if(isDefined(self._id_12C6) && self._id_12C6) {
    while(self._id_12C6) {
      wait 0.05;
    }
  }

  if(!isDefined(var_0.duration)) {
    var_0.duration = 1.5;

  }
  var_0._id_3E20 = (0.15, 0.35, 0.85);
  var_0._id_3E21 = (0.95, 0.95, 0.95);
  var_0.type = "wave";
  var_0._id_3E1D = "hudbig";
  var_0._id_3E31 = 1;
  var_0._id_3E2E = 1;
  var_0._id_3E34 = 1;
  var_0._id_15E0 = 1;
  var_0._id_3E33 = 1;

  if(issplitscreen()) {
    var_0._id_3E1F = 1;
    var_0._id_3E24 = 1.2;
  } else {
    var_0._id_3E1F = 1.1;
    var_0._id_3E24 = 1.2;
  }

  _id_0618::_id_3E14(var_0);
}

_id_3FD9() {
  level endon("special_op_terminated");

  foreach(var_1 in level.players) {
    var_1 maps\_specialops::_id_18A5("armory");
    var_1 maps\_specialops::_id_18A7("surHUD_unlock_hint_armory", "name", "");
    var_1 maps\_specialops::_id_18A7("surHUD_unlock_hint_armory", "icon", "");
    var_1 maps\_specialops::_id_18A7("surHUD_unlock_hint_armory", "desc", "");
  }

  for(;;) {
    level waittill("armory_open", var_3);
    var_4 = "";
    var_5 = "";
    var_6 = var_3.icon;

    if(var_3._id_3EC8 == "weapon") {
      var_4 = "@SO_SURVIVAL_ARMORY_WEAPON_AV";
      var_5 = "@SO_SURVIVAL_ARMORY_WEAPON_DESC";
    } else if(var_3._id_3EC8 == "airsupport") {
      var_4 = "@SO_SURVIVAL_ARMORY_AIRSUPPORT_AV";
      var_5 = "@SO_SURVIVAL_ARMORY_AIRSUPPORT_DESC";
    } else if(var_3._id_3EC8 == "equipment") {
      var_4 = "@SO_SURVIVAL_ARMORY_EQUIPMENT_AV";
      var_5 = "@SO_SURVIVAL_ARMORY_EQUIPMENT_DESC";
    }

    foreach(var_1 in level.players) {
      var_1 maps\_specialops::_id_18A7("surHUD_unlock_hint_armory", "name", var_4);
      var_1 maps\_specialops::_id_18A7("surHUD_unlock_hint_armory", "icon", var_6);
      var_1 maps\_specialops::_id_18A7("surHUD_unlock_hint_armory", "desc", var_5);
      var_1 maps\_specialops::_id_189E("armory");
    }
  }
}