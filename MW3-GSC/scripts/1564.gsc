/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1564.gsc
**************************************/

_id_3D40() {
  _id_3D41();
  precacheheadicon("headicon_delta_so");
  precacheheadicon("headicon_gign_so");
  precachemodel("weapon_c4");
  level._effect["martyrdom_c4_explosion"] = loadfx("explosions/grenadeExp_metal");
  level._effect["martyrdom_dlight_red"] = loadfx("misc/dlight_red");
  level._effect["martyrdom_red_blink"] = loadfx("misc/power_tower_light_red_blink");
  precachemodel("weapon_claymore");
  level._effect["claymore_laser"] = loadfx("misc/claymore_laser");
  level._effect["claymore_explosion"] = loadfx("explosions/grenadeExp_metal");
  level._effect["claymore_disabled"] = loadfx("explosions/sentry_gun_explosion");
  precachemodel("gas_canisters_backpack");
  precachemodel("ims_scorpion_explosive1");
  precacheshellshock("radiation_low");
  precacheshellshock("radiation_med");
  precacheshellshock("radiation_high");
  level._effect["chemical_tank_explosion"] = loadfx("smoke/so_chemical_explode_smoke");
  level._effect["chemical_tank_smoke"] = loadfx("smoke/so_chemical_stream_smoke");
  level._effect["chemical_mine_spew"] = loadfx("smoke/so_chemical_mine_spew");
  level._effect["money"] = loadfx("props/cash_player_drop");
  _id_0619::_id_3D06();
  animscripts\dog\dog_init::_id_3AF2();
}

_id_3D41() {
  var_0 = 100;
  var_1 = 120;

  for(var_2 = var_0; var_2 <= var_1; var_2++) {
    var_3 = _id_3DF6(_id_3DF3(var_2));

    foreach(var_5 in var_3) {}
    precacheitem(var_5);
  }
}

ai_init() {
  setsaveddvar("ai_dropAkimboChance", 0);

  if(!isDefined(level.wave_table)) {
    level.wave_table = "sp/survival_waves.csv";
  }
  level._id_3D43 = [];
  level._id_3D44 = [];
  level._id_3D43 = _id_3D5A();
  level._id_3D45 = [];
  level._id_3D46 = 0;
  level._id_3D47 = [];
  level._id_3D47 = _id_3D49();
  createthreatbiasgroup("sentry");
  createthreatbiasgroup("allies");
  createthreatbiasgroup("axis");
  createthreatbiasgroup("boss");
  createthreatbiasgroup("dogs");
  setignoremegroup("sentry", "dogs");
  setthreatbias("sentry", "boss", 50);
  setthreatbias("sentry", "axis", 50);
  setthreatbias("boss", "allies", 2000);
  setthreatbias("dogs", "allies", 1000);
  setthreatbias("axis", "allies", 0);

  foreach(var_1 in level.players) {
    var_1.onlygoodnearestnodes = 1;
    var_1 thread _id_3D5F();
  }

  level._id_3B89 = ::_id_3D75;
  level._id_3B85 = ::_id_3D72;
  level._id_3D48 = ::_id_3D72;
  level._id_3B83 = 1;
  maps\_utility::_id_1A5A("axis", ::_id_3D6B);
  maps\_utility::_id_1A5A("axis", ::_id_3D67);
  maps\_utility::_id_1A5A("axis", ::_id_3D61);
  maps\_utility::_id_1A5A("axis", ::_id_3D6D);
  maps\_utility::_id_1A5A("axis", ::kill_sentry_on_contact);
  _id_3D5E();
  thread _id_3D78();
  thread _id_3D7D();
  thread _id_3D85();
  thread _id_3DC5();
  thread _id_3DDF();
  thread _id_3DDE();
  thread _id_3DB5();
  maps\_utility::_id_265B("allies");
  maps\_utility::_id_265B("axis");
}

kill_sentry_on_contact() {
  self endon("death");

  if(!isai(self)) {
    return;
  }
  wait 0.5;

  if(isDefined(self._id_0EF1)) {
    self waittill("jumpedout");
  }
  if(!isDefined(level._id_3C67)) {
    return;
  }
  foreach(var_1 in level._id_3C67) {
    if(!isDefined(var_1) || !isalive(var_1)) {
      continue;
    }
    if(distance2d(var_1.origin, self.origin) < 40 && distancesquared(var_1.origin, self.origin) < 4096) {
      var_1 kill();
    }
  }
}

_id_3D49() {
  var_0 = 0;
  var_1 = 40;
  var_2 = [];

  for(var_3 = var_0; var_3 <= var_1; var_3++) {
    var_4 = _id_3E02(var_3);

    if(!isDefined(var_4) || var_4 == 0) {
      continue;
    }
    var_5 = spawnStruct();
    var_5._id_3D4A = var_3;
    var_5._id_1E2E = var_4;
    var_5._id_3D4B = _id_3E03(var_4);
    var_5._id_3D4C = _id_3E04(var_4);
    var_5._id_3D4D = _id_3E05(var_4);
    var_5._id_3D4E = _id_3E06(var_4);
    var_5._id_3D4F = _id_3E00(var_4);
    var_5._id_3D50 = _id_3E08(var_4);
    var_5._id_3D51 = _id_3E09(var_4);
    var_5._id_3D52 = _id_3E0C(var_4);
    var_5._id_3D53 = _id_3E0D(var_4);
    var_5._id_3D54 = _id_3E0A(var_4);
    var_6 = _id_3E0B(var_4);

    if(isDefined(var_6) && var_6.size) {
      if(!isDefined(level._id_3D55)) {
        level._id_3D55 = [];
      }
      foreach(var_8 in var_6) {}
      level._id_3D55[var_8] = var_4;
    }

    var_2[var_4] = var_5;

    if(var_5._id_3D54) {
      level._id_3D45[level._id_3D45.size] = var_5;
    }
  }

  return var_2;
}

_id_3D56(var_0, var_1) {
  if(!isDefined(level._id_3D57)) {
    level._id_3D57 = [];
  }
  level._id_3D57[var_0] = var_1;
}

_id_3D58(var_0, var_1) {
  if(!isDefined(level._id_3D59)) {
    level._id_3D59 = [];
  }
  foreach(var_3 in var_1) {}
  precacheitem(var_3);

  level._id_3D59[var_0] = var_1;
}

_id_3D5A() {
  var_0 = 100;
  var_1 = 120;
  var_2 = [];

  for(var_3 = var_0; var_3 <= var_1; var_3++) {
    var_4 = _id_3DF3(var_3);

    if(!isDefined(var_4) || var_4 == "") {
      continue;
    }
    var_5 = spawnStruct();
    var_5._id_3D4A = var_3;
    var_5._id_160B = var_4;
    var_5.name = _id_3DF8(var_4);
    var_5._id_189B = _id_3DF9(var_4);
    var_5.classname = _id_3DF5(var_4);
    var_5.weapon = _id_3DF6(var_4);
    var_5._id_3D5B = _id_3DF7(var_4);
    var_5.health = _id_3DFA(var_4);
    var_5.speed = _id_3DFB(var_4);
    var_5.accuracy = _id_3DFC(var_4);
    var_5.xp = _id_3DFD(var_4);

    if(_id_3DFE(var_4)) {
      level._id_3D44[var_4] = var_5;
    }
    var_2[var_4] = var_5;
  }

  return var_2;
}

_id_3D5C(var_0, var_1) {
  var_2 = "kill";

  if(isDefined(var_0._id_3D5D)) {
    var_2 = "survival_ai_" + var_0._id_3D5D._id_160B;
  }
  var_3 = undefined;

  if(isDefined(var_1)) {
    var_4 = maps\_rank::getscoreinfovalue(var_2);

    if(isDefined(var_4)) {
      var_3 = var_4 * var_1;
    }
  }

  maps\_utility::_id_12BE(var_2, var_3);
}

_id_3D5E() {
  foreach(var_1 in level._id_3D43) {}
  maps\_rank::registerscoreinfo("survival_ai_" + var_1._id_160B, _id_3DFD(var_1._id_160B));
}

_id_3D5F() {
  self endon("death");
  level endon("special_op_terminated");
  var_0 = 128;
  var_1 = 1;
  var_2 = 512;

  for(;;) {
    var_3 = getclosestnodeinsight(self.origin);

    if(isDefined(var_3)) {
      if(var_3.type != "Begin" && var_3.type != "End" && var_3.type != "Turret") {
        self._id_3D60 = var_3;
      }
    }

    wait 0.25;
  }
}

_id_3D61() {
  level endon("special_op_terminated");
  waittillframeend;
  level._id_3D62 = _id_3D63().size;
  level notify("axis_spawned");
  self waittill("death");
  waittillframeend;
  var_0 = _id_3D63();
  level._id_3D62 = var_0.size;
  level notify("axis_died");

  if(common_scripts\utility::flag("aggressive_mode") && var_0.size == 1 && isai(var_0[0]) && var_0[0].type != "dog") {
    var_0[0] thread _id_3D65();
  }
}

_id_3D63() {
  var_0 = getaiarray("axis");

  if(isDefined(level._id_3D64) && level._id_3D64.size) {
    var_0 = maps\_utility::_id_1843(var_0, level._id_3D64);
  }
  var_0 = maps\_utility::_id_1843(var_0, _id_3DC4());
  return var_0;
}

_id_3D65() {
  level endon("special_op_terminated");
  self endon("death");

  if(!isDefined(self.a._id_0D69)) {
    maps\_utility::_id_260D();
    return;
  }

  for(;;) {
    var_0 = 1;

    foreach(var_2 in level.players) {
      var_3 = distance2d(var_2.origin, self.origin) < 540;

      if(var_3) {
        var_0 = 0;
        break;
      }

      if(self cansee(var_2)) {
        var_0 = 0;
        break;
      }

      wait 0.05;
    }

    if(var_0) {
      var_5 = _id_3D66();

      if(isDefined(var_5)) {
        self kill(self.origin, var_5);
      } else {
        self kill(self.origin);
      }
      return;
    }

    wait 0.1;
  }
}

_id_3D66() {
  var_0 = undefined;

  if(isDefined(self._id_12DD) && self._id_12DD.size) {
    var_0 = self._id_12DD[self._id_12DD.size - 1];
  }
  return var_0;
}

_id_3D67() {
  if(!isai(self) || isDefined(self.type) && self.type == "dog") {
    return;
  }
  if(!isDefined(level._id_3D68) || !isDefined(level._id_3D68["weapon"])) {
    return;
  }
  level endon("special_op_terminated");
  self waittill("weapon_dropped", var_0);

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getsubstr(var_0.classname, 7);
  wait 0.05;
  var_2 = level._id_3D68["weapon"][var_1];

  if(!isDefined(var_0) || !isDefined(var_2)) {
    return;
  }
  var_3 = var_2._id_3D69;
  var_4 = var_2._id_3D6A;
  var_0 itemweaponsetammo(var_3, var_4);
  var_5 = weaponaltweaponname(var_1);

  if(var_5 != "none") {
    var_6 = int(max(1, weaponclipsize(var_5)));
    var_7 = int(max(1, weaponmaxammo(var_5)));
    var_0 itemweaponsetammo(var_6, var_7, var_6, 1);
  }
}

_id_3D6B() {
  level._id_20C8 = 100000;
}

_id_3D6C() {
  level endon("special_op_terminated");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  playFX(level._effect["money"], self.origin + (0, 0, 32));
}

_id_3D6D() {
  if(!isai(self) || isDefined(self.type) && self.type == "dog") {
    return;
  }
  self endon("death");
  level endon("special_op_terminated");
  self waittill("long_death");
  self waittill("flashbang", var_0, var_1, var_2, var_3);

  if(isDefined(var_3) && isDefined(var_3.team) && var_3.team == "allies") {
    self kill(self.origin, var_3);
  }
}

_id_3D6F() {
  if(isDefined(self._id_3D5D)) {
    return self._id_3D5D._id_160B;
  }
  if(isDefined(level._id_3B70)) {
    foreach(var_1 in level._id_3B70) {
      if(var_1 == self) {
        return _id_3E03(level._id_17F6);
      }
    }
  }

  if(isDefined(self._id_3B73) && isai(self._id_3B73)) {
    return _id_3E03(level._id_17F6);
  }
  return undefined;
}

_id_3D70(var_0) {
  var_1 = [];

  if(isDefined(level._id_3D71) && level._id_3D71.size) {
    foreach(var_3 in level._id_3D71) {
      if(isalive(var_3) && isDefined(var_3._id_3D5D) && var_3._id_3D5D._id_160B == var_0) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

_id_3D72() {
  self notify("ai_behavior_change");
  self._id_0F3C = 1;
  self._id_3D73 = undefined;
  var_0 = self[[level._id_3B89]]();

  if(var_0 == "martyrdom") {
    thread _id_3D7B();
    return;
  }

  if(var_0 == "claymore") {
    thread _id_3D83();
    return;
  }

  if(var_0 == "chemical") {
    thread _id_3DA0();
    return;
  }

  if(var_0 == "easy" || var_0 == "regular" || var_0 == "hardened" || var_0 == "veteran" || var_0 == "elite") {
    thread _id_3D79();
  }
}

_id_3D74() {
  self notify("ai_behavior_change");
  self._id_0F3C = 1;
  self._id_3D73 = 1;
  var_0 = self[[level._id_3B89]]();

  if(var_0 == "martyrdom") {
    thread _id_3D7B();
    return;
  }

  if(var_0 == "claymore") {
    thread _id_3D83();
    return;
  }

  if(var_0 == "chemical") {
    thread _id_3DA0();
    return;
  }

  if(var_0 == "easy" || var_0 == "regular" || var_0 == "hardened" || var_0 == "veteran" || var_0 == "elite") {
    thread _id_3D7A();
  }
}

_id_3D75() {
  if(isDefined(self._id_3D76) && isDefined(self._id_3D5D)) {
    return self._id_3D5D._id_160B;
  }
  var_0 = _id_3D6F();

  if(!isDefined(self._id_3D5D)) {
    var_1 = _id_3DF4(var_0);
    self._id_3D5D = var_1;
  }

  var_2 = isDefined(self.code_classname) && self.code_classname == "script_vehicle";
  var_3 = _id_3DFA(var_0);

  if(isDefined(var_3) && !var_2) {
    self.health = var_3;
  }
  var_4 = _id_3DFB(var_0);

  if(isDefined(var_4)) {
    if(var_2) {
      self vehicle_setspeed(60 * var_4, 20 * var_4);
    } else {
      self._id_0FC6 = var_4;
    }
  }

  var_5 = _id_3DFC(var_0);

  if(isDefined(var_5)) {
    maps\_utility::_id_2736(var_5);
  }
  var_6 = _id_3DF7(var_0);

  foreach(var_8 in var_6) {
    if(var_8 == "fraggrenade") {
      self.grenadeammo = 2;
      self.grenadeweapon = "fraggrenade";
    }

    if(var_8 == "flash_grenade") {
      self.grenadeammo = 2;
      self.grenadeweapon = "flash_grenade";
    }
  }

  if(isDefined(self.dropweapon) && self.dropweapon && isDefined(level._id_3B83)) {
    var_10 = randomfloat(1);

    if(var_10 > level._id_3B83) {
      self.dropweapon = 0;
    }
  }

  self._id_4418 = 1;
  self._id_4411 = 1;
  self._id_1139 = 256;
  self._id_3D76 = 1;
  return var_0;
}

_id_3D77() {
  self endon("death");
  var_0 = "Boss does not have AI_Type struct, should have been passed when spawning by AI_Type.";
  var_1 = self[[level._id_3B89]]();

  if(!isDefined(var_1)) {
    return;
  }
  if(var_1 == "jug_regular") {
    _id_3DD3();
    thread _id_3DD5();
    return;
  }

  if(var_1 == "jug_headshot") {
    _id_3DD3();
    thread _id_3DD6();
    return;
  }

  if(var_1 == "jug_explosive") {
    _id_3DD3();
    thread _id_3DD7();
    return;
  }

  if(var_1 == "jug_riotshield") {
    _id_3DD3();
    thread _id_3DD8();
    return;
  }
}

_id_3D78() {}

_id_3D79() {
  self.goalradius = 900;
  self._id_3D73 = undefined;
  self setengagementmindist(300, 200);
  self setengagementmaxdist(512, 768);
  thread _id_3DEC(4.0, self.goalradius, "ai_behavior_change demotion");
}

_id_3D7A() {
  self.goalradius = 384;
  self._id_3D73 = 1;
  maps\_utility::_id_2131(1);
  maps\_utility::_id_0EEC();
  self setengagementmindist(88, 64);
  self setengagementmaxdist(512, 768);
  thread _id_3DEC(4.0, self.goalradius, "ai_behavior_change demotion");
}

_id_3D7B() {
  self endon("death");
  self endon("ai_behavior_change");

  if(!isDefined(self._id_3D7C)) {
    thread _id_3D7E();
  }
  var_0 = 0;
  var_1 = 0;

  if(isDefined(self._id_3D73) && self._id_3D73) {
    var_0 = 88;
    var_1 = 64;
    self.goalradius = 384;
    maps\_utility::_id_2131(1);
    maps\_utility::_id_0EEC();
  } else {
    var_0 = 200;
    var_1 = 100;
    self.goalradius = 900;
  }

  self setengagementmindist(var_0, var_1);
  self setengagementmaxdist(512, 768);
  thread _id_3DEC(4.0, self.goalradius, "ai_behavior_change");
}

_id_3D7D() {}

_id_3D7E() {
  self._id_3D7C = 1;
  self._id_0D41 = 1;
  thread _id_3D7F("j_spine4", (0, 6, 0), (0, 0, -90));
  thread _id_3D7F("tag_stowed_back", (0, 1, 5), (80, 90, 0));
  thread _id_3D81(3, 0.4);
}

_id_3D7F(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }
  var_3 = spawn("script_model", self gettagorigin(var_0) + var_1);
  var_3 setModel("weapon_c4");
  var_3 linkto(self, var_0, var_1, var_2);

  if(!isDefined(self._id_3D80)) {
    self._id_3D80 = [];
  }
  self._id_3D80[self._id_3D80.size] = var_3;
}

_id_3D81(var_0, var_1) {
  common_scripts\utility::waittill_any("long_death", "death", "force_c4_detonate");
  self notify("c4_detonated");

  if(!isDefined(self) || !isDefined(self._id_3D80) || self._id_3D80.size == 0) {
    return;
  }
  var_2 = _id_3D66();

  if(isDefined(self._id_3B38)) {
    var_0 = 5;
  }
  for(var_3 = 0; var_3 < self._id_3D80.size; var_3++) {
    playFXOnTag(common_scripts\utility::getfx("martyrdom_dlight_red"), self._id_3D80[var_3], "tag_fx");
    playFXOnTag(common_scripts\utility::getfx("martyrdom_red_blink"), self._id_3D80[var_3], "tag_fx");
  }

  var_4 = self._id_3D80;
  self._id_3D80 = undefined;
  badplace_cylinder("", var_0, var_4[0].origin, 144, 144, "axis", "allies");
  var_5 = max(var_0 - 1.5, 0);

  if(var_5 > 0) {
    var_0 = var_0 - var_5;
    wait(var_5);
  }

  var_4[0] playSound("semtex_warning");
  var_6 = 0;

  if(var_0 > 0.25) {
    var_0 = var_0 - 0.25;
    var_6 = 1;
  }

  wait(var_0);

  for(var_3 = 0; var_3 < var_4.size; var_3++) {
    if(!isDefined(var_4[var_3])) {
      continue;
    }
    stopFXOnTag(common_scripts\utility::getfx("martyrdom_red_blink"), var_4[var_3], "tag_fx");
  }

  if(var_6) {
    wait 0.25;
  }
  var_4 = sortbydistance(var_4, var_4[0].origin + (0, 0, -120));

  for(var_3 = 0; var_3 < var_4.size; var_3++) {
    if(!isDefined(var_4[var_3])) {
      continue;
    }
    playFX(level._effect["martyrdom_c4_explosion"], var_4[var_3].origin);
    var_4[var_3] playSound("detpack_explo_main", "sound_done");
    physicsexplosioncylinder(var_4[var_3].origin, 256, 1, 2);
    earthquake(0.4, 0.8, var_4[var_3].origin, 600);
    stopFXOnTag(common_scripts\utility::getfx("martyrdom_dlight_red"), var_4[var_3], "tag_fx");

    if(!isDefined(var_2)) {
      var_2 = undefined;
    }
    var_4[var_3] radiusdamage(var_4[var_3].origin, 192, 100, 50, var_2, "MOD_EXPLOSIVE");
    var_4[var_3] thread _id_0618::_id_3D82();
    wait(var_1);
  }
}

_id_3D83() {
  if(isDefined(self._id_3D84)) {
    return;
  }
  self endon("death");
  self endon("ai_behavior_change");
  var_0 = 0;
  var_1 = 0;

  if(isDefined(self._id_3D73) && self._id_3D73) {
    var_0 = 88;
    var_1 = 64;
    self.goalradius = 384;
    maps\_utility::_id_2131(1);
    maps\_utility::_id_0EEC();
  } else {
    var_0 = 300;
    var_1 = 200;
    self.goalradius = 900;
  }

  self setengagementmindist(var_0, var_1);
  self setengagementmaxdist(512, 768);
  thread _id_3DEC(4.0, self.goalradius, "ai_behavior_change");
}

_id_3D85() {
  _id_3D86();
  thread _id_3D8F();
  var_0 = ["claymore", "chemical"];
  thread _id_3D91(var_0);
}

_id_3D86() {
  level._id_3D87 = [];
  level._id_3D87 = _id_3DEA();

  foreach(var_1 in level._id_3D87) {}
  var_1.weight = 0.0;
}

_id_3D88(var_0) {
  if(isDefined(level._id_3D89) && level._id_3D89.size >= 6) {
    return 0;
  }
  var_1 = [];

  foreach(var_3 in var_0) {}
  var_1 = common_scripts\utility::array_combine(var_1, _id_3D70(var_3));

  var_1 = _id_3D8A(var_1);

  if(!var_1.size) {
    return 0;
  }
  var_5 = _id_3D8C(384, 2.0);
  var_5 = _id_3D8B(var_5);

  foreach(var_7 in var_5) {
    foreach(var_9 in var_1) {
      var_10 = distance2d(var_7.origin, var_9.origin);

      if(var_10 > 768 || var_7.origin[2] < var_9.origin[2] - 120.0 || var_7.origin[2] > var_9.origin[2] + 120.0) {
        continue;
      }
      var_11 = maps\_utility::_id_0AE9(var_7.origin, level.players);
      var_12 = distance2d(var_7.origin, var_11.origin);

      if(var_10 < var_12) {
        var_9 thread _id_3D92(var_7);
        return 1;
      }
    }
  }

  return 0;
}

_id_3D8A(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3._id_3D84)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_3D8B(var_0) {
  for(var_1 = 0; var_1 < var_0.size - 1; var_1++) {
    var_2 = 0;

    for(var_3 = var_1 + 1; var_3 < var_0.size; var_3++) {
      if(var_0[var_3].weight < var_0[var_1].weight) {
        var_4 = var_0[var_3];
        var_0[var_3] = var_0[var_1];
        var_0[var_1] = var_4;
      }
    }
  }

  return var_0;
}

_id_3D8C(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_3D87) {
    if(var_4 _id_3D8D(var_0, var_1)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_3D8D(var_0, var_1) {
  if(isDefined(self._id_3D8E) || self.weight < var_1) {
    return 0;
  }
  foreach(var_3 in level.players) {
    if(distance2d(self.origin, var_3.origin) < var_0) {
      return 0;
    }
  }

  return 1;
}

_id_3D8F() {
  level endon("special_op_terminated");

  for(;;) {
    foreach(var_1 in level._id_3D87) {
      var_2 = 0;

      foreach(var_4 in level.players) {
        if(distance2d(var_1.origin, var_4.origin) <= 512) {
          var_1 _id_3D90(1);
          var_2 = 1;
        }
      }

      if(!var_2) {
        var_1 _id_3D90(0);
      }
    }

    wait 0.5;
  }
}

_id_3D90(var_0) {
  if(var_0) {
    self.weight = min(20, self.weight + 0.5);
  } else {
    self.weight = max(0, self.weight - 0.025);
  }
}

_id_3D91(var_0) {
  level endon("special_op_terminated");

  for(;;) {
    if(_id_3D88(var_0)) {
      wait 8.0;
      continue;
    }

    wait 2.0;
  }
}

_id_3D92(var_0) {
  self endon("death");
  self._id_3D84 = 1;
  self notify("ai_behavior_change");
  var_0._id_3D8E = 1;
  thread _id_3D93(var_0);
  var_1 = self.goalradius;
  self.goalradius = 48;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self setgoalpos(var_0.origin);
  var_2 = common_scripts\utility::waittill_any_timeout(13, "goal", "bad_path");

  if(var_2 != "goal") {
    var_0._id_3D8E = undefined;

    if(var_2 == "bad_path") {
      level._id_3D87 = maps\_utility::array_remove_nokeys(level._id_3D87, var_0);
    }
  } else {
    self allowedstances("crouch");
    wait 1.0;
    var_3 = undefined;
    var_4 = _id_3D6F();

    if(var_4 == "claymore") {
      var_3 = _id_3D94(var_0.origin, var_0.angles);
      var_3 playSound("so_claymore_plant");
      var_3 thread _id_3D95();
      var_3 thread _id_3D9C();
      var_3 thread _id_3D9E();
      level notify("ai_claymore_planted");
    } else if(var_4 == "chemical") {
      var_3 = _id_3DAF(var_0.origin, var_0.angles);
      var_3 playSound("so_claymore_plant");
      var_3 thread _id_3DB1();
      var_3 thread _id_3DB2();
      level notify("ai_chembomb_planted");
    } else {}

    if(isDefined(var_3)) {
      if(!isDefined(level._id_3D89)) {
        level._id_3D89 = [];
      }
      level._id_3D89[level._id_3D89.size] = var_3;
      var_3 thread _id_3D9F(var_0);
      wait 0.25;
      var_0.weight = var_0.weight * 0.5;
    }
  }

  self allowedstances("prone", "crouch", "stand");
  self.goalradius = var_1;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self._id_3D84 = undefined;
  self notify("planting_done");
  var_4 = _id_3D6F();

  if(var_4 == "claymore") {
    thread _id_3D83();
  } else if(var_4 == "chemical") {
    thread _id_3DA0();
  }
}

_id_3D93(var_0) {
  self endon("planting_done");
  level endon("special_op_terminated");
  self waittill("death");
  var_0._id_3D8E = undefined;
}

_id_3D94(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3 setModel("weapon_claymore");

  if(!isDefined(var_2) || var_2) {
    var_3.origin = maps\_utility::_id_2281(var_0, 12, -120);
  }
  var_3.angles = (0, var_1[1], 0);
  playFXOnTag(common_scripts\utility::getfx("claymore_laser"), var_3, "tag_fx");

  if(isDefined(self) && isalive(self)) {
    var_3.owner = self;
  }
  return var_3;
}

_id_3D95() {
  self endon("death");
  level endon("special_op_terminated");
  var_0 = 6;
  var_1 = spawn("trigger_radius", self.origin + (0, 0, -192), var_0, 192, 384);
  thread _id_3D9B(var_1);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isDefined(self.owner) && var_2 == self.owner) {
      continue;
    }
    if(isDefined(self.disabled)) {
      self waittill("enabled");
      continue;
    }

    if(var_2 _id_3D96(self)) {
      self notify("triggered");
      _id_3D98(0.75);
      return;
    }
  }
}

_id_3D96(var_0) {
  if(isDefined(var_0.disabled)) {
    return 0;
  }
  var_1 = self.origin + (0, 0, 32);
  var_2 = var_1 - var_0.origin;
  var_3 = anglesToForward(var_0.angles);
  var_4 = vectordot(var_2, var_3);

  if(var_4 < 20) {
    return 0;
  }
  var_2 = vectornormalize(var_2);
  var_5 = vectordot(var_2, var_3);

  if(!isDefined(level._id_3D97)) {
    level._id_3D97 = cos(70);
  }
  return var_5 > level._id_3D97;
}

_id_3D98(var_0) {
  if(isDefined(self._id_3D99)) {
    return;
  }
  self._id_3D99 = 1;
  level endon("special_op_terminated");
  self playSound("claymore_activated_SP");

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }
  self playSound("detpack_explo_main", "sound_done");
  playFX(level._effect["claymore_explosion"], self.origin);
  physicsexplosioncylinder(self.origin, 256, 1, 2);
  earthquake(0.4, 0.8, self.origin, 600);
  stopFXOnTag(common_scripts\utility::getfx("claymore_laser"), self, "tag_fx");
  radiusdamage(self.origin, 192, 100, 50, undefined, "MOD_EXPLOSIVE");
  level._id_3D9A = gettime();

  if(isDefined(self)) {
    self delete();
  }
}

_id_3D9B(var_0) {
  level endon("special_op_terminated");
  self waittill("death");
  level._id_3D89 = maps\_utility::array_remove_nokeys(level._id_3D89, self);
  wait 0.05;

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_3D9C() {
  self endon("death");
  self endon("triggered");
  level endon("special_op_terminated");
  self.health = 100;
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self waittill("damage", var_0, var_1);
  var_2 = 0.05;

  if(_id_3D9D()) {
    var_2 = 0.1 + randomfloat(0.4);
  }
  _id_3D98(var_2);
}

_id_3D9D() {
  return isDefined(level._id_3D9A) && gettime() - level._id_3D9A < 400;
}

_id_3D9E() {
  self endon("death");
  self endon("triggered");
  level endon("special_op_terminated");

  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    playFXOnTag(common_scripts\utility::getfx("claymore_disabled"), self, "tag_origin");
    self.disabled = 1;
    self notify("disabled");
    wait(var_1);
    self.disabled = undefined;
    self notify("enabled");
  }
}

_id_3D9F(var_0) {
  level endon("special_op_terminated");
  self waittill("death");
  var_0._id_3D8E = undefined;
}

_id_3DA0() {
  if(isDefined(self._id_3D84)) {
    return;
  }
  self endon("death");
  self endon("ai_behavior_change");

  if(!isDefined(self._id_3D7C)) {
    thread _id_3DA1();
  }
  var_0 = 0;
  var_1 = 0;

  if(isDefined(self._id_3D73) && self._id_3D73) {
    var_0 = 88;
    var_1 = 64;
    self.goalradius = 384;
    maps\_utility::_id_2131(1);
    maps\_utility::_id_0EEC();
  } else {
    var_0 = 120;
    var_1 = 60;
    self.goalradius = 512;
  }

  self setengagementmindist(var_0, var_1);
  self setengagementmaxdist(512, 768);
  thread _id_3DEC(4.0, self.goalradius, "ai_behavior_change");
}

_id_3DA1() {
  self._id_3D7C = 1;
  self.ignoresuppression = 1;
  self._id_1151 = 1;
  self._id_0FDF = 1;
  self._id_1199 = 1;
  self._id_117F = 1;
  self._id_0EEE = 1;
  self.combatmode = "no_cover";
  self._id_0FD9 = 1;
  maps\_utility::_id_260D();
  maps\_utility::_id_0EEC();
  var_0 = _id_3DA2("tag_shield_back", (0, 0, 0), (0, 90, 0));
  thread _id_3DA3(var_0);
  thread _id_3DA4(var_0);
  thread _id_3DA6(var_0);
}

_id_3DA2(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self gettagorigin(var_0) + var_1);
  var_3 setModel("gas_canisters_backpack");
  var_3.health = 99999;
  var_3 setCanDamage(1);
  var_3 linkto(self, var_0, var_1, var_2);
  return var_3;
}

_id_3DA3(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx("chemical_tank_smoke"), self, "tag_shield_back");
    wait 0.05;
  }
}

_id_3DA4(var_0) {
  self endon("death");
  self endon("tank_detonated");
  level endon("special_op_terminated");

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isPlayer(var_2) || var_5 == "MOD_EXPLOSIVE" || var_5 == "MOD_GRENADE" || var_5 == "MOD_GRENADE_SPLASH") {
      thread _id_0618::_id_3DA5(var_2, var_5, var_10);
      return;
    }
  }
}

_id_3DA6(var_0) {
  self endon("tank_detonated");
  level endon("special_op_terminated");
  self waittill("death", var_1);

  if(!isDefined(self)) {
    if(isDefined(var_0)) {
      wait 0.05;
      var_0 delete();
    }

    return;
  }

  thread _id_3DA7(var_0, var_1);
}

_id_3DA7(var_0, var_1) {
  if(!isDefined(var_0) || isDefined(var_0._id_3DA8)) {
    return;
  }
  var_0._id_3DA8 = 1;

  if(!isDefined(self)) {
    return;
  }
  self notify("tank_detonated");
  var_2 = self.origin;
  var_0 playSound("detpack_explo_main", "sound_done");
  physicsexplosioncylinder(var_2, 256, 1, 0.5);
  earthquake(0.2, 0.4, var_2, 600);
  var_1 = common_scripts\utility::ter_op(isDefined(var_1), var_1, undefined);
  playFX(common_scripts\utility::getfx("chemical_tank_explosion"), var_2);
  thread _id_3DA9(var_2, 6.0, 2.0);
  var_0 unlink();
  wait 0.05;
  var_0 delete();
}

_id_3DA9(var_0, var_1, var_2) {
  level endon("special_op_terminated");
  var_3 = 7;
  var_4 = spawn("trigger_radius", var_0 + (0, 0, -96), var_3, 96, 192);
  badplace_cylinder("", var_2, var_0, 96, 96, "axis", "allies");
  var_4 endon("smoke_done");
  var_4 thread wait_for_delete();
  var_4 thread maps\_utility::_id_26E7(maps\_utility::_id_09E7, var_1, maps\_utility::_id_1DAA, "smoke_done");

  for(;;) {
    var_4 waittill("trigger", var_5);

    if(!isDefined(var_5) || !isalive(var_5)) {
      continue;
    }
    if(isPlayer(var_5)) {
      if(maps\_utility::_id_1A43(var_5) || maps\_utility::_id_1A75(var_5)) {
        continue;
      }
      if(isDefined(var_5._id_3DAA)) {
        continue;
      }
      var_6 = "";
      var_7 = gettime();

      if(!isDefined(var_5._id_3DAB) || isDefined(var_5._id_3DAC) && var_7 - var_5._id_3DAC > 1500.0) {
        var_6 = "radiation_low";
      } else if(var_5._id_3DAD == "radiation_low") {
        var_6 = "radiation_med";
      } else {
        var_6 = "radiation_high";
      }
      var_5._id_3DAB = 1;
      var_5._id_3DAD = var_6;
      var_5._id_3DAC = var_7;
      var_5 shellshock(var_6, 1.5);
      var_5._id_3DAA = 1;
      var_5 thread _id_3DAE(1.0);
    }

    if(isai(var_5)) {}
  }
}

wait_for_delete() {
  level endon("special_op_terminated");
  self waittill("smoke_done");
  self delete();
}

_id_3DAE(var_0) {
  self endon("death");
  wait(var_0);
  self._id_3DAA = undefined;
}

_id_3DAF(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0);
  var_3 setModel("ims_scorpion_explosive1");

  if(!isDefined(var_2) || var_2) {
    var_3.origin = maps\_utility::_id_2281(var_0, 12, -120) + (0, 0, 5);
  }
  var_3.angles = (0, var_1[1], 0);
  var_3._id_3DB0 = var_3 common_scripts\utility::spawn_tag_origin();
  var_3._id_3DB0 linkto(var_3, "tag_explosive1", (0, 0, 6), (-90, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("chemical_mine_spew"), var_3._id_3DB0, "tag_origin");

  if(isDefined(self) && isalive(self)) {
    var_3.owner = self;
  }
  return var_3;
}

_id_3DB1() {
  self endon("death");
  level endon("special_op_terminated");
  var_0 = 6;
  var_1 = spawn("trigger_radius", self.origin + (0, 0, -96), var_0, 96, 192);
  thread _id_3D9B(var_1);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(isDefined(self.owner) && var_2 == self.owner) {
      continue;
    }
    if(isDefined(self.disabled)) {
      self waittill("enabled");
      continue;
    }

    self notify("triggered");
    _id_3DB3(0.5);
    return;
  }
}

_id_3DB2() {
  self endon("death");
  self endon("triggered");
  level endon("special_op_terminated");
  self.health = 100;
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self waittill("damage", var_0, var_1);
  var_2 = 0.05;

  if(_id_3D9D()) {
    var_2 = 0.1 + randomfloat(0.4);
  }
  _id_3DB3(var_2);
}

_id_3DB3(var_0) {
  if(isDefined(self._id_3DB4)) {
    return;
  }
  self._id_3DB4 = 1;
  level endon("special_op_terminated");
  self playSound("claymore_activated_SP");

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }
  level._id_3D9A = gettime();
  self playSound("detpack_explo_main", "sound_done");
  physicsexplosioncylinder(self.origin, 256, 1, 0.5);
  earthquake(0.2, 0.4, self.origin, 600);
  playFX(common_scripts\utility::getfx("chemical_tank_explosion"), self.origin);
  stopFXOnTag(common_scripts\utility::getfx("chemical_mine_spew"), self._id_3DB0, "tag_origin");
  thread _id_3DA9(self.origin, 6.0, 1.0);
  self._id_3DB0 delete();
  wait 0.05;

  if(isDefined(self)) {
    self delete();
  }
}

_id_3DB5() {
  level._id_3DB6 = getEntArray("dog_relocate", "targetname");

  if(!isDefined(level._id_3DB6) || level._id_3DB6.size == 0) {
    return;
  }
  foreach(var_1 in level._id_3DB6) {
    var_2 = common_scripts\utility::getstruct(var_1.target, "targetname");
    var_1._id_3DB7 = var_2.origin;
    var_1 thread _id_3DB8();
  }
}

_id_3DB8() {
  level endon("special_op_terminated");

  for(;;) {
    self waittill("trigger", var_0);

    while(var_0 istouching(self)) {
      var_0._id_3DB9 = self._id_3DB7;
      wait 0.05;
    }

    var_0._id_3DB9 = undefined;
  }
}

_id_3DBA(var_0, var_1) {
  level endon("special_op_terminated");
  level endon("wave_ended");

  if(!isDefined(var_0) || var_0 == "" || !isDefined(var_1) || !var_1) {
    return;
  }
  level._id_3DBB = [];
  var_2 = [];

  foreach(var_4 in level.players) {}
  var_2[var_2.size] = var_4;

  var_6 = getEntArray("dog_spawner", "targetname")[0];
  level._id_3DBC = isDefined(var_0) && var_0 == "dog_splode";
  var_6 maps\_utility::add_spawn_function(::_id_3DC0);
  var_6 maps\_utility::add_spawn_function(::_id_3DC2);
  var_6 maps\_utility::add_spawn_function(::_id_3DC1);

  for(var_7 = 0; var_7 < var_1; var_7++) {
    var_8 = _id_0618::_id_3DBE(level._id_3DBD, var_2, 4);
    var_6.count = 1;
    var_6.origin = var_8.origin;
    var_6.angles = var_8.angles;
    var_9 = int((40 + randomint(10)) / var_1);
    level._id_3DBF = 1;
    var_10 = var_6 maps\_utility::_id_166F(1);
    var_10._id_3D5D = _id_3DF4(var_0);
    var_10 setthreatbiasgroup("dogs");
    var_10[[level._id_3B89]]();
    var_10.canclimbladders = 0;
    level._id_3DBB[level._id_3DBB.size] = var_10;
    level._id_3DBF = undefined;

    if(!common_scripts\utility::flag("aggressive_mode")) {
      common_scripts\utility::waittill_any_timeout(var_9, "aggressive_mode");
    }
    wait 0.05;
  }
}

_id_3DC0() {
  self.badplaceawareness = 0;
  self.grenadeawareness = 0;

  if(isDefined(level._id_3DBC) && level._id_3DBC) {
    thread _id_3D7F("j_hip_base_ri", (6, 6, -3), (0, 0, 0));
    thread _id_3D7F("j_hip_base_le", (-6, -6, 3), (0, 0, 0));
    thread _id_3D81(3, 0.4);
    thread _id_020F();
  }
}

_id_020F() {
  level endon("special_op_terminated");
  self endon("death");
  self endon("c4_detonated");
  var_0 = self.origin;
  var_1 = self.origin;
  var_2 = gettime();

  for(;;) {
    wait 0.2;
    var_1 = self.origin;
    var_3 = gettime();

    if(distancesquared(var_1, var_0) > squared(10) || animscripts\dog\dog_combat::_id_3B2A()) {
      var_0 = var_1;
      var_2 = var_3;
    }

    if(!isDefined(level._id_3C67) || !level._id_3C67.size) {
      continue;
    }
    if(var_3 - var_2 < 2000) {
      continue;
    }
    var_4 = 0;

    foreach(var_6 in level._id_3C67) {
      if(isDefined(var_6.carrier)) {
        continue;
      }
      if(distancesquared(var_1, var_6.origin) < squared(40)) {
        var_4 = 1;
        break;
      }
    }

    if(var_4) {
      break;
    } else {
      var_0 = var_1;
      var_2 = var_3;
    }
  }

  self notify("stop_dog_seek_player");
  self.ignoreall = 1;
  self setgoalpos(self.origin);
  self notify("force_c4_detonate");
}

_id_3DC1() {
  self waittill("death");
  level._id_3DBB = _id_3DC4();
}

_id_3DC2() {
  level endon("special_op_terminated");
  level endon("wave_ended");
  self endon("death");
  self endon("stop_dog_seek_player");
  self._id_0FC6 = 0.75;
  self.goalheight = 80;
  self.goalradius = 300;
  var_0 = 1.0;

  for(;;) {
    var_1 = maps\_utility::_id_2609(self.origin);

    if(!isDefined(var_1)) {
      var_1 = maps\_utility::_id_2608(self.origin);
    }
    if(isDefined(var_1)) {
      var_2 = self cansee(var_1);
      var_3 = distancesquared(self.origin, var_1.origin);

      if(isDefined(var_1._id_3DB9)) {
        self setgoalpos(var_1._id_3DB9);
      } else if((!var_2 || var_3 > 1048576) && isDefined(var_1._id_3D60)) {
        self setgoalpos(var_1._id_3D60.origin);
        self.goalradius = 24;
      } else {
        self setgoalpos(var_1.origin);
        self.goalradius = 384;
      }
    }

    wait(var_0);
  }
}

_id_3DC3() {
  var_0 = _id_3DC4().size;

  if(isDefined(level._id_3DBF)) {
    var_0++;
  }
  return var_0;
}

_id_3DC4() {
  if(!isDefined(level._id_3DBB)) {
    level._id_3DBB = [];
    return level._id_3DBB;
  }

  var_0 = [];

  foreach(var_2 in level._id_3DBB) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

_id_3DC5() {}

_id_3DC6(var_0) {
  foreach(var_2 in var_0) {
    if(issubstr(var_2, "jug_")) {
      return 1;
    }
  }

  return 0;
}

_id_3DC7(var_0, var_1) {
  level endon("special_op_terminated");
  var_2 = _id_3DC9(var_0, var_1);

  if(!isDefined(var_2)) {
    return;
  }
  var_2._id_3D5D = _id_3DF4(var_0);
  var_2._id_12DE = int(_id_3DFD(var_0) * 0.2);
  var_2 _id_061A::_id_3D30(0.0);
  level._id_3D64[level._id_3D64.size] = var_2;
  var_2 waittill("jumpedout");
  level notify("juggernaut_jumpedout");
  var_2 thread _id_3D77();
  var_2 thread _id_0618::_id_3DC8();
}

_id_3DC9(var_0, var_1) {
  var_2 = _id_0618::_id_3DCA(var_0)[0];
  var_2 maps\_utility::add_spawn_function(::_id_3D6C);
  var_3 = _id_0618::_id_3DCB("jug_drop_chopper", var_1.origin, var_1);
  var_3 thread _id_0619::_id_3D09("reached_dynamic_path_end death deathspin");
  var_3 maps\_vehicle::_id_2A12();
  var_3._id_2950 = 1;
  var_3 vehicle_setspeed(60 + randomint(15), 30, 30);
  var_3 thread _id_0618::_id_3DCC();
  var_3 _id_0618::_id_3DCD("jug_drop_chopper_pilot");
  var_4 = var_3 _id_0618::_id_3DCE(var_2);
  var_4 maps\_utility::_id_2611();
  var_4 thread maps\_utility::_id_26E7(common_scripts\utility::waittill_any, "jumpedout", maps\_utility::_id_1902);
  var_4 setthreatbiasgroup("boss");
  return var_4;
}

_id_3DCF() {
  self endon("death");
  self endon("new_jug_behavior");

  for(;;) {
    if(self.health <= 250) {
      self.walkdist = 500;
      self.walkdistfacingmotion = 500;
    } else {
      self.walkdist = 1000;
      self.walkdistfacingmotion = 1000;
    }

    wait 0.05;
  }
}

_id_3DD0() {
  self endon("death");
  self endon("new_jug_behavior");
  self._id_1A2D = 0;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(self._id_0D04)) {
      continue;
    }
    var_10 = 0;
    var_11 = 0;

    if(isDefined(var_1) && isai(var_1) && self.team != var_1.team) {
      var_10 = _id_3DD2(var_0, self._id_3DD1["ai_damage"]);
    } else if(var_4 == "MOD_MELEE") {
      if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_9) && issubstr(var_9, "riotshield_so")) {
        var_10 = _id_3DD2(var_0, self._id_3DD1["melee_riotshield"]);
      } else {
        var_10 = _id_3DD2(var_0, self._id_3DD1["melee"]);
      }
    } else if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_GRENADE_SPLASH" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH") {
      var_10 = _id_3DD2(var_0, self._id_3DD1["explosive"]);
    } else if(_id_0618::_id_0A32()) {
      var_10 = _id_3DD2(var_0, self._id_3DD1["headshot"]);
      var_11 = 1;
    } else {
      var_10 = _id_3DD2(var_0, self._id_3DD1["bodyshot"]);
    }
    var_10 = int(var_10);

    if(var_10 < 0 && abs(var_10) >= self.health) {
      if(var_11) {
        self._id_0A33 = 1;
      }
      thread _id_0618::_id_3DA5(var_1, var_4, var_9);
    } else {
      self.health = self.health + var_10;
    }
    self notify("dmg_factored");
  }
}

_id_3DD2(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1) && var_1) {
    var_2 = int(var_0 * (1 - var_1));
  }
  return var_2;
}

_id_3DD3() {
  self._id_3DD1["headshot"] = 1;
  self._id_3DD1["bodyshot"] = 1;
  self._id_3DD1["melee"] = 1;
  self._id_3DD1["melee_riotshield"] = 1;
  self._id_3DD1["explosive"] = 1;
  self._id_3DD1["ai_damage"] = 1;
  self.dropweapon = 0;
  self.minpaindamage = 350;
  maps\_utility::_id_0D72(0);
  self._id_3D73 = 1;
  self._id_100A = undefined;
  self._id_1035 = 1;
  thread _id_3DD0();
  thread _id_3DCF();
}

_id_3DD4(var_0, var_1) {
  self endon("death");
  var_2 = self.health;

  if(isDefined(self._id_3D5D)) {
    var_2 = _id_3DFA(self._id_3D5D._id_160B);
  }
  for(;;) {
    if(self.health / var_2 <= var_0) {
      animscripts\death::_id_0D17();
      var_3 = self._id_3DD1.size;
      self._id_3DD1 = maps\_utility::_id_26F2(self._id_3DD1, var_1);
      return;
    }

    self waittill("dmg_factored");
  }
}

_id_3DD5() {
  self._id_3DD1["headshot"] = 0.75;
  self._id_3DD1["bodyshot"] = 0.33;
  self._id_3DD1["melee"] = 0.25;
  self._id_3DD1["melee_riotshield"] = 0.25;
  self._id_3DD1["explosive"] = 0.33;
  self._id_3DD1["ai_damage"] = 0.33;
  self setengagementmindist(100, 60);
  self setengagementmaxdist(512, 768);
  self.goalradius = 128;
  self.goalheight = 81;
  thread _id_3DEC(2.0, self.goalradius, "new_jug_behavior", "stop_hunting");
}

_id_3DD6() {
  self._id_3DD1["headshot"] = 1.0;
  self._id_3DD1["bodyshot"] = 0.33;
  self._id_3DD1["melee"] = 0.25;
  self._id_3DD1["melee_riotshield"] = 0.25;
  self._id_3DD1["explosive"] = 1.0;
  self._id_3DD1["ai_damage"] = 0.25;
  self setengagementmindist(100, 60);
  self setengagementmaxdist(512, 768);
  self.goalradius = 128;
  self.goalheight = 81;
  thread _id_3DEC(2.0, self.goalradius, "new_jug_behavior", "stop_hunting");
}

_id_3DD7() {
  self._id_3DD1["headshot"] = 0.33;
  self._id_3DD1["bodyshot"] = 0.25;
  self._id_3DD1["melee"] = 0.25;
  self._id_3DD1["melee_riotshield"] = 0.25;
  self._id_3DD1["explosive"] = 0.33;
  self._id_3DD1["ai_damage"] = 0.25;
  self setengagementmindist(100, 60);
  self setengagementmaxdist(512, 768);
  self.goalradius = 128;
  self.goalheight = 81;
  thread _id_3DEC(2.0, self.goalradius, "new_jug_behavior", "stop_hunting");
}

_id_3DD8() {
  self endon("death");
  self endon("riotshield_damaged");
  self._id_3DD1["headshot"] = 0.75;
  self._id_3DD1["bodyshot"] = 0.75;
  self._id_3DD1["melee"] = 0.33;
  self._id_3DD1["melee_riotshield"] = 0.33;
  self._id_3DD1["explosive"] = 1.0;
  self._id_3DD1["ai_damage"] = 0.25;

  if(getdvarint("survival_chaos") != 1) {
    self._id_3DD9 = 1;
  }
  _id_3DDA();

  if(getdvarint("survival_chaos") != 1) {
    thread _id_3DDB();
  }
  if(1) {
    self._id_3AB9 = 9999;
  }
  self setengagementmindist(100, 60);
  self setengagementmaxdist(512, 768);
  self.goalradius = 128;
  self.goalheight = 81;
  self.usechokepoints = 0;
  thread _id_3DEC(2.0, self.goalradius, "new_jug_behavior", "stop_hunting");
  thread _id_00D4();
}

_id_00D4() {
  self endon("death");

  for(;;) {
    if(self.health <= 250) {
      self.minpaindamage = 250;
    } else {
      self.minpaindamage = 350;
    }
    wait 0.05;
  }
}

_id_3DDA() {
  self._id_0A37 = 1;
  self._id_10A3 = 0.05;
  self._id_0F3C = 1;
  self.ignoresuppression = 1;
  self._id_1151 = 1;
  self._id_0FDF = 1;
  self._id_117F = 1;
  self._id_0EEE = 1;
  self.combatmode = "no_cover";
  self._id_0FD9 = 1;
  self.a._id_0D31 = 1;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  maps\_utility::_id_2721();
  maps\_utility::_id_0EEC();
  self._id_1035 = 1;

  if(!self isbadguy()) {
    return;
  }
  level notify("juggernaut_spawned");
  thread _id_3DDD();
}

_id_3DDB() {
  self endon("death");
  thread _id_3DDC(0.5);
  self waittill("riotshield_damaged");
  wait 0.05;
  _id_3DEB();

  if(!isalive(self)) {
    return;
  }
  animscripts\riotshield\riotshield::_id_3AD4();
  thread _id_05C6::_id_3AAE();
  self notify("new_jug_behavior");
  _id_3DD3();
  thread _id_3DD5();
}

_id_3DDC(var_0) {
  self endon("death");
  self endon("riotshield_damaged");
  var_1 = self.health;

  if(isDefined(self._id_3D5D)) {
    var_1 = _id_3DFA(self._id_3D5D._id_160B);
  }
  for(;;) {
    self waittill("damage");

    if(self.health / var_1 <= var_0) {
      self notify("riotshield_damaged");
      return;
    }
  }
}

_id_3DDD() {
  self endon("new_jug_behavior");
  self waittill("death", var_0);

  if(getdvarint("survival_chaos") != 1) {
    _id_3DEB();
  }
  level notify("juggernaut_died");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  if(!isPlayer(var_0)) {
    return;
  }
}

_id_3DDE() {
  level._id_3D16 = 128;
  _id_0619::_id_3D07("script_noteworthy", "so_chopper_boss_path_struct");
}

_id_3DDF() {
  var_0 = common_scripts\utility::getStructArray("drop_path_start", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2;

    while(isDefined(var_3)) {
      if(isDefined(var_3._id_2954)) {
        var_3._id_295B = maps\_utility::_id_1277(var_3.origin);
        break;
      }

      if(isDefined(var_3.target)) {
        var_3 = common_scripts\utility::getstruct(var_3.target, "targetname");
        continue;
      }

      break;
    }
  }
}

_id_3DE0(var_0, var_1) {
  level endon("special_op_terminated");
  var_2 = _id_0618::_id_3DE1(var_0, var_1.origin);
  var_2 _id_0618::_id_3DCD("jug_drop_chopper_pilot");
  var_2 thread _id_0612::_id_3C49();
  var_2._id_3D5D = _id_3DF4(var_0);
  var_2[[level._id_3B89]]();

  if(isDefined(level._id_12E5) && level._id_12E5) {
    var_2 thread maps\_rank::_id_12E0();
  }
  var_2._id_12DE = int(_id_3DFD(var_0) * 0.2);
  level._id_3D64[level._id_3D64.size] = var_2;
  var_2 thread _id_0619::_id_3D0C(var_1);
  var_2 thread _id_0619::_id_3D09("death deathspin");
  var_2 thread _id_0618::_id_3DC8();
  var_2 setthreatbiasgroup("boss");
  setthreatbias("sentry", "boss", 1500);

  foreach(var_4 in var_2.mgturret) {}
  var_4 setbottomarc(90);

  return var_2;
}

_id_3DE2(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = _id_0618::_id_3DCA(var_0)[0];

  if(!isDefined(var_5)) {
    return var_4;
  }
  var_6 = _id_0618::_id_3DCB("ally_drop_chopper", var_2.origin, var_2);
  var_6 thread _id_0619::_id_3D09("reached_dynamic_path_end death deathspin");
  var_6 maps\_vehicle::_id_2A12();
  var_6 vehicle_setspeed(60 + randomint(15), 30, 30);
  var_6._id_2950 = 1;
  var_6 endon("death");
  var_6 _id_0618::_id_3DCD("friendly_support_delta");

  for(var_7 = 0; var_7 < var_1; var_7++) {
    var_8 = var_6 _id_0618::_id_3DCE(var_5, var_7 + 2);
    var_8 maps\_utility::_id_0D72(0);
    var_8 maps\_utility::_id_2611();
    var_8 thread _id_3DE7(20, "jumpedout");
    var_8 setthreatbiasgroup("allies");
    var_8.ignoreme = 1;
    var_8._id_3D5D = _id_3DF4(var_0);
    var_8[[level._id_3B89]]();
    var_8 thread _id_3DE9();
    var_8.owner = var_3;
    var_4[var_4.size] = var_8;
    var_8.headiconteam = "allies";

    if(var_0 == "friendly_support_delta") {
      var_8.headicon = "headicon_delta_so";
    }
    if(var_0 == "friendly_support_riotshield") {
      var_8.headicon = "headicon_gign_so";
    }
    var_8.drawoncompass = 0;
    wait 0.05;
  }

  var_6 thread _id_3DE4(var_4);
  return var_4;
}

_id_3DE3() {
  if(isDefined(self) && isalive(self)) {
    return self getEye();
  }
  return undefined;
}

_id_3DE4(var_0) {
  self endon("death");
  self waittill("unloaded");
  common_scripts\utility::array_thread(var_0, ::_id_3DE5);
}

_id_3DE5() {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self setengagementmindist(300, 200);
  self setengagementmaxdist(512, 768);
  self.goalradius = 512;

  if(isDefined(self._id_3D5D) && issubstr(self._id_3D5D._id_160B, "riotshield")) {
    self.goalradius = 448;
    self setengagementmindist(200, 100);
    self setengagementmaxdist(512, 768);
    thread _id_3DE6();
    thread _id_00D5(300);
  } else {
    thread _id_00D5(150);
  }
  self.ignoreme = 0;
  self.fixednode = 0;
  self.dropweapon = 0;
  self._id_3DD9 = 1;
  self.drawoncompass = 1;
  maps\_utility::_id_0D72(1);
  self pushplayer(0);
  self._id_1A2D = 30;
  thread _id_3DE8();
  thread _id_3DEC(4.0, self.goalradius);
}

_id_00D5(var_0) {
  self endon("death");

  for(;;) {
    self.minpaindamage = var_0;
    wait 0.05;
  }
}

_id_3DE6() {
  self endon("death");
  common_scripts\utility::waittill_any_return("riotshield_damaged", "dog_attacks_ai");
  wait 0.05;
  _id_3DEB();

  if(!isalive(self)) {
    return;
  }
  animscripts\riotshield\riotshield::_id_3AD4();
}

_id_3DE7(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    self waittill(var_1);
  }
  wait(var_0);
  maps\_utility::_id_1902();
}

_id_3DE8() {
  self waittill("death");

  if(isDefined(self.owner) && isalive(self.owner)) {
    self.owner notify("ally_died");
  }
  _id_3DEB();
}

_id_3DE9() {
  waittillframeend;

  if(isDefined(self.team) && self.team == "axis") {
    _id_061A::_id_3D30();
  }
  if(isDefined(level._id_1AB1)) {
    self.sidearm = level._id_1AB1;
    maps\_utility::_id_2709(self.sidearm, "none");
  }

  var_0 = _id_3DF6(self._id_3D5D._id_160B)[0];

  if(!isDefined(var_0) || var_0 == self.weapon) {
    return;
  }
  maps\_utility::_id_104A(var_0, "primary");
}

_id_3DEA() {
  var_0 = common_scripts\utility::getStructArray("so_claymore_loc", "targetname");
  return var_0;
}

_id_3DEB() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.weaponinfo["iw5_riotshield_so"])) {
    var_0 = self.weaponinfo["iw5_riotshield_so"]._id_2099;

    if(isDefined(self._id_3DD9) && self._id_3DD9 && var_0 != "none") {
      thread animscripts\shared::_id_23C9("iw5_riotshield_so", var_0);
    }
    animscripts\shared::_id_23BE("iw5_riotshield_so");
    self.weaponinfo["iw5_riotshield_so"]._id_2099 = "none";
    self.a._id_0EE4[var_0] = "none";
  }
}

_id_3DEC(var_0, var_1, var_2, var_3) {
  level endon("special_op_terminated");
  self endon("death");
  self.goalradius = common_scripts\utility::ter_op(isDefined(var_1), var_1, self.goalradius);
  self.goalheight = 80;

  if(isDefined(var_2)) {
    var_4 = strtok(var_2, " ");

    foreach(var_6 in var_4) {}
    self endon(var_6);
  }

  if(isDefined(var_3)) {
    var_8 = strtok(var_3, " ");

    foreach(var_10 in var_8) {}
    self notify(var_10);
  }

  _id_3DF0();
  var_12 = 1;
  var_13 = undefined;

  for(;;) {
    var_14 = maps\_utility::_id_2609(self.origin);

    if(!isDefined(var_14)) {
      var_14 = maps\_utility::_id_2608(self.origin);
    }
    if(!isDefined(var_14)) {
      wait(var_0);
      continue;
    }

    if(self.team == "allies") {
      if(distancesquared(self.origin, var_14.origin) > self.goalradius * self.goalradius) {
        self setgoalentity(var_14);
        wait 2;
        continue;
      }
    } else if(distancesquared(self.origin, var_14.origin) < self.goalradius * self.goalradius) {
      self getenemyinfo(var_14);
    }
    if(!isDefined(var_13) || var_13 != var_14) {
      var_13 = var_14;
      self setgoalentity(var_14);
      self notify("target_reset");
      thread _id_061B(var_14);
    }

    if(var_12) {
      var_12 = 0;

      if(self.team == "axis") {
        self getenemyinfo(var_14);
      }
    }

    _id_3DF0();

    if(self.team == "allies") {
      self setgoalpos(self.origin);

      if(isDefined(self.subclass) && self.subclass == "riotshield") {
        wait(randomfloatrange(0.2, 2.0));
        var_15 = self.goalradius;
        self.goalradius = 1.0;
        wait 0.1;
        self.goalradius = var_15;
      }
    }

    wait(var_0);
  }
}

_id_061B(var_0) {
  self endon("target_reset");
  self endon("death");

  for(;;) {
    self waittill("bad_path");

    if(isDefined(var_0._id_3D60)) {
      self setgoalpos(var_0._id_3D60.origin);
      var_1 = var_0.origin;

      while(distancesquared(var_1, var_0.origin) < 144) {
        wait 0.5;
      }
      self setgoalentity(var_0);
    }
  }
}

_id_3DED(var_0) {
  self endon("death");
  self endon("manage_ai_stop_polling_player_state");

  for(;;) {
    wait 0.1;

    if(!isDefined(var_0) || !isalive(var_0) || maps\_utility::_id_1A43(var_0)) {
      self notify("manage_ai_player_invalid");
      return;
    } else if(distancesquared(self.origin, var_0.origin) <= self.goalradius * self.goalradius) {
      self notify("manage_ai_player_found");
      return;
    }
  }
}

_id_3DEE(var_0) {
  if(isDefined(var_0._id_3D60)) {
    self setgoalpos(var_0._id_3D60.origin);
  }
}

_id_3DEF() {
  if(isDefined(self.subclass) && self.subclass == "riotshield") {
    if(isDefined(self._id_0A37)) {
      _id_05C8::_id_3ACD();
    } else {
      _id_05C8::_id_3ACC();
    }
  } else if(isDefined(self._id_0A37)) {
    maps\_utility::_id_2712();
  } else {
    self.combatmode = "no_cover";
  }
}

_id_3DF0() {
  if(isDefined(self.subclass) && self.subclass == "riotshield") {
    if(isDefined(self._id_0A37)) {
      _id_05C8::_id_3ACF();
    } else {
      _id_05C8::_id_3ACE();
    }
  } else if(isDefined(self._id_0A37)) {
    maps\_utility::_id_2713();
  } else {
    self.combatmode = "cover";
  }
}

_id_3DF1(var_0) {
  return isDefined(level._id_3D43) && isDefined(level._id_3D43[var_0]);
}

_id_3DF2(var_0) {
  if(_id_3DF1(var_0)) {
    return level._id_3D43[var_0]._id_3D4A;
  }
  return int(tablelookup("sp/survival_waves.csv", 1, var_0, 0));
}

_id_3DF3(var_0) {
  return tablelookup("sp/survival_waves.csv", 0, var_0, 1);
}

_id_3DF4(var_0) {
  var_1 = "Trying to get survival AI_type struct before stringtable is ready, or type doesnt exist.";
  return level._id_3D43[var_0];
}

_id_3DF5(var_0) {
  if(isDefined(level._id_3D57) && isDefined(level._id_3D57[var_0])) {
    return level._id_3D57[var_0];
  }
  if(_id_3DF1(var_0)) {
    return level._id_3D43[var_0].classname;
  }
  return tablelookup("sp/survival_waves.csv", 1, var_0, 4);
}

_id_3DF6(var_0) {
  if(isDefined(level._id_3D59) && isDefined(level._id_3D59[var_0])) {
    return level._id_3D59[var_0];
  }
  if(_id_3DF1(var_0)) {
    return level._id_3D43[var_0].weapon;
  }
  var_1 = tablelookup("sp/survival_waves.csv", 1, var_0, 5);
  return strtok(var_1, " ");
}

_id_3DF7(var_0) {
  if(_id_3DF1(var_0)) {
    return level._id_3D43[var_0]._id_3D5B;
  }
  var_1 = tablelookup("sp/survival_waves.csv", 1, var_0, 6);
  return strtok(var_1, " ");
}

_id_3DF8(var_0) {
  if(_id_3DF1(var_0)) {
    return level._id_3D43[var_0].name;
  }
  return tablelookup("sp/survival_waves.csv", 1, var_0, 2);
}

_id_3DF9(var_0) {
  if(_id_3DF1(var_0)) {
    return level._id_3D43[var_0]._id_189B;
  }
  return tablelookup("sp/survival_waves.csv", 1, var_0, 3);
}

_id_3DFA(var_0) {
  if(isDefined(level._id_3D46)) {
    var_1 = 1.0 + level._id_3D46 * 0.1;
  } else {
    var_1 = 1.0;
  }
  if(_id_3DF1(var_0)) {
    return int(level._id_3D43[var_0].health * var_1);
  }
  var_2 = tablelookup("sp/survival_waves.csv", 1, var_0, 7);

  if(var_2 == "") {
    return undefined;
  }
  return int(int(var_2) * var_1);
}

_id_3DFB(var_0) {
  if(isDefined(level._id_3D46)) {
    var_1 = 1.0 + level._id_3D46 * 0.05;
  } else {
    var_1 = 1.0;
  }
  if(_id_3DF1(var_0)) {
    return min(level._id_3D43[var_0].speed * var_1, 1.5);
  }
  var_2 = tablelookup("sp/survival_waves.csv", 1, var_0, 8);

  if(var_2 == "") {
    return undefined;
  }
  return min(float(var_2) * var_1, 1.5);
}

_id_3DFC(var_0) {
  if(isDefined(level._id_3D46)) {
    var_1 = 1.0 + level._id_3D46 * 0.2;
  } else {
    var_1 = 1.0;
  }
  if(_id_3DF1(var_0)) {
    if(isDefined(level._id_3D43[var_0].accuracy)) {
      return level._id_3D43[var_0].accuracy * var_1;
    } else {
      return level._id_3D43[var_0].accuracy;
    }
  }

  var_2 = tablelookup("sp/survival_waves.csv", 1, var_0, 11);

  if(var_2 == "") {
    return undefined;
  }
  return float(var_2) * var_1;
}

_id_3DFD(var_0) {
  if(_id_3DF1(var_0)) {
    return level._id_3D43[var_0].xp;
  }
  var_1 = tablelookup("sp/survival_waves.csv", 1, var_0, 9);

  if(var_1 == "") {
    return undefined;
  }
  return int(var_1);
}

_id_3DFE(var_0) {
  if(_id_3DF1(var_0) && isDefined(level._id_3D44)) {
    return isDefined(level._id_3D44[var_0]);
  }
  var_1 = tablelookup("sp/survival_waves.csv", 1, var_0, 10);

  if(!isDefined(var_1) || var_1 == "") {
    return 0;
  }
  return 1;
}

_id_3DFF(var_0) {
  return isDefined(level._id_3D47) && isDefined(level._id_3D47[var_0]);
}

_id_3E00(var_0) {
  if(_id_3DFF(var_0)) {
    return level._id_3D47[var_0]._id_3D4F;
  }
  return int(tablelookup(level.wave_table, 2, var_0, 1));
}

_id_3E01(var_0) {
  if(_id_3DFF(var_0)) {
    return level._id_3D47[var_0]._id_3D4A;
  }
  return int(tablelookup(level.wave_table, 2, var_0, 0));
}

_id_3E02(var_0) {
  return int(tablelookup(level.wave_table, 0, var_0, 2));
}

_id_3E03(var_0) {
  if(_id_3DFF(var_0)) {
    return level._id_3D47[var_0]._id_3D4B;
  }
  return tablelookup(level.wave_table, 2, var_0, 3);
}

_id_3E04(var_0) {
  if(_id_3DFF(var_0)) {
    return level._id_3D47[var_0]._id_3D4C;
  }
  var_1 = [];
  var_2 = int(tablelookup(level.wave_table, 2, var_0, 4));

  if(var_2 <= 3) {
    var_1[0] = var_2;
  } else {
    var_3 = var_2 % 3;
    var_4 = int(var_2 / 3);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_1[var_5] = 3;
    }
    if(var_3 == 1) {
      if(level._id_3B6F == 4) {
        var_1[var_1.size - 1] = var_1[var_1.size - 1] + var_3;
      } else {
        var_6 = 1;
        var_1[var_1.size - 1] = var_1[var_1.size - 1] - var_6;
        var_1[var_1.size] = var_3 + var_6;
      }
    } else if(var_3 == 2) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_3E05(var_0) {
  if(_id_3DFF(var_0)) {
    return level._id_3D47[var_0]._id_3D4D;
  }
  var_1 = tablelookup(level.wave_table, 2, var_0, 5);

  if(isDefined(var_1) && var_1 != "") {
    return strtok(var_1, " ");
  }
  return undefined;
}

_id_3E06(var_0) {
  if(_id_3DFF(var_0)) {
    return level._id_3D47[var_0]._id_3D4E;
  }
  var_1 = tablelookup(level.wave_table, 2, var_0, 6);
  var_2 = [];

  if(isDefined(var_1) && var_1 != "") {
    var_1 = strtok(var_1, " ");

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      var_2[var_3] = int(var_1[var_3]);
    }
    return var_2;
  }

  return undefined;
}

_id_3E07(var_0, var_1) {
  var_2 = _id_3E05(var_0);
  var_3 = _id_3E06(var_0);

  if(isDefined(var_2) && isDefined(var_3) && var_2.size && var_3.size) {
    foreach(var_6, var_5 in var_2) {
      if(var_1 == var_5) {
        return var_3[var_6];
      }
    }
  }

  return 0;
}

_id_3E08(var_0) {
  if(_id_3DFF(var_0)) {
    return level._id_3D47[var_0]._id_3D50;
  }
  var_1 = tablelookup(level.wave_table, 2, var_0, 7);

  if(isDefined(var_1) && var_1 != "") {
    return strtok(var_1, " ");
  }
  return undefined;
}

_id_3E09(var_0) {
  if(_id_3DFF(var_0)) {
    return level._id_3D47[var_0]._id_3D51;
  }
  var_1 = tablelookup(level.wave_table, 2, var_0, 8);

  if(isDefined(var_1) && var_1 != "") {
    return strtok(var_1, " ");
  }
  return undefined;
}

_id_3E0A(var_0) {
  if(_id_3DFF(var_0)) {
    return level._id_3D47[var_0]._id_3D54;
  }
  return int(tablelookup(level.wave_table, 2, var_0, 9));
}

_id_3E0B(var_0) {
  var_1 = tablelookup(level.wave_table, 2, var_0, 10);
  var_1 = strtok(var_1, " ");
  return var_1;
}

_id_3E0C(var_0) {
  if(_id_3DFF(var_0)) {
    return level._id_3D47[var_0]._id_3D52;
  }
  var_1 = _id_3E05(var_0);

  if(!isDefined(var_1) || !var_1.size) {
    return "";
  }
  foreach(var_3 in var_1) {
    if(issubstr(var_3, "dog")) {
      return var_3;
    }
  }

  return "";
}

_id_3E0D(var_0) {
  if(_id_3DFF(var_0)) {
    return level._id_3D47[var_0]._id_3D53;
  }
  var_1 = _id_3E0C(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }
  return _id_3E07(var_0, var_1);
}