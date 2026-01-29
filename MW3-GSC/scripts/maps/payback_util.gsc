/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_util.gsc
*****************************************/

_id_6797(var_0) {
  var_1 = self;

  if(isDefined(self._id_100C)) {
    while(isalive(self) && isDefined(self._id_100C)) {
      wait 0.1;
    }
  }

  if(!isDefined(self) || !isalive(self)) {
    level waittill(var_0);

    switch (var_0) {
      case "hannibal_spawned":
        var_1 = level._id_6493;
        break;
      case "barracus_spawned":
        var_1 = level._id_6492;
        break;
      case "murdock_spawned":
        var_1 = level._id_6491;
        break;
    }
  }

  if(isDefined(var_1) && isalive(var_1) && !isDefined(var_1._id_0D04)) {
    var_1 thread maps\_utility::_id_0D04();
  }
}

_id_6490(var_0) {
  if(var_0 == 1) {
    level._id_6491 maps\_utility::_id_0D04();
    level._id_6492 maps\_utility::_id_0D04();
    level._id_6493 maps\_utility::_id_0D04();
  } else {
    level._id_6491 maps\_utility::_id_1902();
    level._id_6492 maps\_utility::_id_1902();
    level._id_6493 maps\_utility::_id_1902();
  }
}

_id_6494() {
  level._id_6495 = [];
  var_0 = (-1613.14, -9162.08, 419.447);
  var_1 = (0, 268.001, 1.99871);
  var_2 = anglestoup(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = spawnfx(level._effect["sand_wall_payback_still_md"], var_0, var_3, var_2);
  triggerfx(var_4, -2240);
  level._id_6495[level._id_6495.size] = var_4;
}

_id_6496() {
  level._id_6495 = [];
  var_0 = (-1613.14, -7862.08, 419.447);
  var_1 = (0, 268.001, 1.99871);
  var_2 = anglestoup(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = spawnfx(level._effect["sand_wall_payback_still_md"], var_0, var_3, var_2);
  triggerfx(var_4, -2240);
  level._id_6495[level._id_6495.size] = var_4;
}

_id_6497() {
  if(level._id_5671 < 2) {
    _id_6488(2);
    _id_6500(2300, -2240);
  } else {
    _id_6488(3, -2240);
    _id_6500(5300, -2240);
  }
}

_id_6488(var_0, var_1) {
  if(var_0 == 4) {
    _id_6498(5);
  } else if(isDefined(level._id_6495)) {
    level._id_6495 = common_scripts\utility::array_removeundefined(level._id_6495);
    maps\_utility::_id_135B(level._id_6495);
  }

  if(!isDefined(var_0)) {
    var_0 = 0;

  }
  if(var_0 == 1) {
    _id_6499();
  } else if(var_0 == 2) {
    _id_6494();
  } else if(var_0 == 3) {
    if(!isDefined(var_1)) {
      _id_649A();
    } else {
      _id_649A(var_1);
    }
  } else if(var_0 == 4) {
    _id_6496();
  }
}

_id_6498(var_0) {
  if(isDefined(level._id_6495)) {
    level._id_6495 = common_scripts\utility::array_removeundefined(level._id_6495);
    var_1 = level._id_6495;
    wait(var_0);
    maps\_utility::_id_135B(var_1);
    common_scripts\utility::array_removeundefined(level._id_6495);
  }
}

_id_6499() {
  level._id_6495 = [];
  var_0 = (3329.18, -7502.85, 1257.04);
  var_1 = (359.318, 352.837, 0.881786);
  var_2 = anglestoup(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = spawnfx(level._effect["sand_wall_payback_still_lg"], var_0, var_3, var_2);
  triggerfx(var_4, -2240);
  level._id_6495[level._id_6495.size] = var_4;
}

_id_649A(var_0) {
  level._id_6495 = [];
  var_1 = (-737.243, -2444.67, 531.125);
  var_2 = (0, 258, 0);
  var_3 = anglestoup(var_2);
  var_4 = anglesToForward(var_2);
  var_5 = spawnfx(level._effect["sand_wall_payback_still"], var_1, var_4, var_3);
  var_1 = (1091.39, -2842.78, 245.922);
  var_2 = (357.269, 272.002, 0.534172);
  var_3 = anglestoup(var_2);
  var_4 = anglesToForward(var_2);
  var_6 = spawnfx(level._effect["sand_wall_payback_still"], var_1, var_4, var_3);
  var_1 = (-3324.35, -2031.53, 415.489);
  var_2 = (0, 242, 0);
  var_3 = anglestoup(var_2);
  var_4 = anglesToForward(var_2);
  var_7 = spawnfx(level._effect["sand_wall_payback_still"], var_1, var_4, var_3);

  if(!isDefined(var_0)) {
    triggerfx(var_5);
    triggerfx(var_6);
    triggerfx(var_7);
  } else {
    triggerfx(var_5, var_0);
    triggerfx(var_6, var_0);
    triggerfx(var_7, var_0);
  }

  level._id_6495[level._id_6495.size] = var_5;
  level._id_6495[level._id_6495.size] = var_6;
  level._id_6495[level._id_6495.size] = var_7;
}

_id_649B() {
  level.player disableweapons();
  level.player disableweaponswitch();
  level.player disableoffhandweapons();
}

_id_649C() {
  level.player enableweapons();
  level.player enableweaponswitch();
  level.player enableoffhandweapons();
}

_id_649D(var_0) {
  var_1 = common_scripts\utility::getfx("thick_black_smoke_L");
  playFXOnTag(var_1, var_0, "tag_origin");

  if(!isDefined(level._id_649E)) {
    level._id_649E = [];

  }
  var_0._id_649F = var_1;
  level._id_649E[level._id_649E.size] = var_0;
}

_id_64A0() {
  if(isDefined(level._id_649E)) {
    for(var_0 = 0; var_0 < level._id_649E.size; var_0++) {
      var_1 = level._id_649E[var_0];

      if(isDefined(var_1)) {
        stopFXOnTag(var_1._id_649F, var_1, "tag_origin");
      }
    }

    level._id_649E = [];
  }
}

_id_64A1() {
  if(!isDefined(self.finished_spawning) || !self.finished_spawning) {
    self waittill("finished spawning");
  }
}

_id_64A2() {
  if(!isDefined(level.chopper)) {
    _id_64A3();

  }
  return level.chopper;
}

_id_64A3() {
  if(!isDefined(level.chopper)) {
    level.chopper = maps\_vehicle::_id_2A99("heli_nikolai");

  }
  level.chopper._id_581D = missile_createrepulsorent(level.chopper, 5000, 800);
  level.chopper setCanDamage(0);
  level.chopper setvehicleteam("allies");
  level.chopper.ignoreall = 1;
  level.chopper setmaxpitchroll(30, 30);
  level.chopper setturningability(1.0);
  level.chopper setjitterparams((1000, 1000, 500), 0.25, 0.75);
  level.chopper sethoverparams(100, 20, 10);
  var_0 = level.chopper gettagorigin("tag_origin");
  var_1 = level.chopper gettagorigin("tag_ground");
  level.chopper._id_295E = var_0[2] - var_1[2] + 22;
  thread maps\payback_aud::_id_5623();
  return level.chopper;
}

_id_64A4() {
  if(!isDefined(level._id_64A5)) {
    level._id_64A5 = _id_594A("nikolai", "nikolai_spawn_point");

  }
  if(!isDefined(level._id_64A6)) {
    _id_64A2() maps\_vehicle::_id_2AE6(level._id_64A5);
    level._id_64A6 = 1;
  }
}

_id_64A7(var_0, var_1, var_2, var_3) {
  level endon(var_3);
  waittillframeend;
  var_4 = var_2 * var_2;

  for(;;) {
    var_5 = var_0 gettagorigin(var_1);

    if(distancesquared(var_5, self.origin) <= var_4) {
      level notify(var_3);

    }
    wait 0.05;
  }
}

_id_64A8() {
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("actionSlotsHide", 1);
}

_id_64A9() {
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("hud_showstance", 1);
  setsaveddvar("actionSlotsHide", 0);
}

move_player_to_start(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level._id_1F19 + "_playerstart";

  }
  return _id_64AA(var_0, "targetname");
}

_id_64AA(var_0, var_1) {
  var_2 = common_scripts\utility::getstruct(var_0, var_1);

  if(isDefined(var_2)) {
    level.player setorigin(var_2.origin);
    level.player setplayerangles(var_2.angles);
    return 1;
  }

  return 0;
}

_id_594A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level._id_1F19 + "_" + var_0;

  }
  var_2 = _id_594B(var_0, var_1);
  return var_2;
}

_id_596C(var_0, var_1, var_2, var_3) {
  maps\_utility::_id_2636(var_0, var_1, var_3);
  common_scripts\utility::flag_set(var_2);
}

_id_5DD5(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = var_4 maps\_utility::_id_166F(var_1);

    if(isDefined(var_5)) {
      var_2[var_2.size] = var_5;
    }
  }

  return var_2;
}

_id_5DD7(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  return _id_5DD5(var_1);
}

_id_594B(var_0, var_1) {
  var_2 = getent(var_0, "script_noteworthy");
  var_3 = common_scripts\utility::getstruct(var_1, "targetname");
  var_2.origin = var_3.origin;

  if(isDefined(var_3.angles)) {
    var_2.angles = var_3.angles;

  }
  var_4 = var_2 maps\_utility::_id_166F();
  return var_4;
}

_id_64AB() {
  level._id_64AC = [];
  level._id_64AC["chopper_street_runners"] = ::_id_64AE;
  level._id_64AC["respawn_on_death_flashlights"] = ::_id_64AF;
  level._id_64AC["flashlight_runner"] = ::_id_64B0;
  level._id_64AC["flashlight_runner_delete_at_path_end"] = ::_id_64B1;
  level._id_64AC["crush_player"] = ::_id_64B2;
  level._id_64AC["sandstorm_combat"] = ::_id_64B3;
  level._id_64AC["sandstorm_combat_delete"] = ::_id_64B4;
  level._id_64AC["sandstorm_combat_rusher"] = ::_id_64B6;
  level._id_64AC["sandstorm_combat_pather"] = ::_id_64B7;
  level._id_64AC["sandstorm_combat_flood"] = ::_id_64B5;
  level._id_64AC["ignore_till_path_end"] = ::_id_64B8;
  level._id_64AC["delete_at_path_end"] = ::_id_64B9;
  level._id_64AC["respawn_on_death"] = ::_id_64BF;
  level._id_64AC["target_escape_chopper"] = ::_id_64C1;
  level._id_64AC["ignore_til_pathend_or_damage_spawners"] = ::_id_64BB;
  level._id_64AC["chopper_drop_off_land"] = ::_id_64BA;
  var_0 = getarraykeys(level._id_64AC);

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2, "script_noteworthy");

    if(isDefined(var_3) && var_3.size) {
      maps\_utility::_id_27CB(var_2, level._id_64AC[var_2]);
    }
  }

  var_5 = getspawnerteamarray("axis");
  var_6 = [];

  foreach(var_8 in var_5) {
    if(!isDefined(var_8._id_164F)) {
      continue;
    }
    var_6[var_6.size] = var_8;
  }

  if(var_6.size > 0) {
    maps\_utility::_id_27C9(var_6, ::_id_64EC);
  }
}

_id_64AD(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = level._id_64AC[var_1];

    foreach(var_4 in var_0) {
      if(isalive(var_4)) {
        var_4 thread[[var_2]]();
      }
    }
  }
}

_id_64AE() {
  self endon("death");
  maps\payback_sandstorm_code::_id_648A();
  maps\_utility::_id_109B();
  common_scripts\utility::waittill_either("goal", "damage");
  maps\_utility::_id_109E();
}

_id_64AF() {
  maps\payback_sandstorm_code::_id_648A();
  thread _id_64C0();
  _id_64A1();
  self._id_20AF = 0.15;
}

_id_64B0() {
  self._id_0FD7 = 1;
  maps\payback_sandstorm_code::_id_648A();
}

_id_64B1() {
  _id_64B0();
  _id_64B9();
}

_id_64B2() {
  var_0 = !isDefined(self._id_217B) || !self._id_217B;
  _id_64C8(var_0);
}

_id_64B3() {
  maps\payback_sandstorm_code::_id_648A();
  _id_64A1();
  self._id_20AF = 0.01;
}

_id_64B4() {
  self endon("death");
  thread _id_64B3();
  _id_64DE();
  thread _id_64B9();
}

_id_64B5() {
  thread _id_64B3();
  thread _id_64BF();
}

_id_64B6() {
  self endon("death");
  thread _id_64B3();
  self setgoalentity(level.player);
  _id_64DE();
  maps\_utility::_id_2712();
  var_0 = 512;
  var_1 = var_0 * var_0;

  for(;;) {
    if(distancesquared(self.origin, level.player.origin) <= var_1) {
      _id_64DF();
      return;
    }

    wait 0.2;
  }
}

_id_64B7() {
  self endon("death");
  thread _id_64B3();
  _id_64DE();
  self waittill("reached_path_end");
  _id_64DF();
}

_id_64B8() {
  self.ignoreall = 1;
  self clearenemy();
  self waittill("reached_path_end");
  self.ignoreall = 0;
}

_id_64B9() {
  self endon("death");
  self waittill("reached_path_end");

  if(isDefined(self)) {
    self delete();
  }
}

_id_64BA() {
  maps\_utility::_id_1402("drop_off");
  maps\_utility::_id_1654("drop_off");
  maps\_utility::_id_2698();
  wait 0.1;
  maps\_utility::_id_269C();
  maps\_vehicle::_id_2514();
  maps\_utility::_id_1654("unloaded");
  thread maps\_utility::_id_269E();
  wait 0.5;
  maps\_utility::_id_269A();
}

_id_64BB() {
  self endon("death");
  _id_64BC();
  common_scripts\utility::waittill_either("reached_path_end", "damage");
  _id_64BE();
}

_id_64BC() {
  self.ignoreall = 1;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.fixednode = 0;
  self._id_0EEE = 1;
  maps\_utility::_id_1057();
  self._id_64BD = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;
}

_id_64BE() {
  self.ignoreall = 0;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.fixednode = 1;
  self._id_0EEE = 0;
  maps\_utility::_id_1071();

  if(isDefined(self._id_64BD)) {
    self.newenemyreactiondistsq = self._id_64BD;
  }
}

_id_64BF() {
  var_0 = self.spawner;

  if(isDefined(var_0) && isDefined(var_0._id_164F)) {
    level endon(var_0._id_164F);

  }
  common_scripts\utility::waittill_either("death", "pain_death");
  wait 1;
  var_1 = undefined;

  while(!isDefined(var_1) && isDefined(var_0) && isDefined(var_0.count) && var_0.count > 0) {
    var_1 = var_0 maps\_utility::_id_166F();
    wait 1;
  }
}

_id_64C0() {
  var_0 = self.spawner;

  if(isDefined(var_0) && isDefined(var_0._id_164F)) {
    level endon(var_0._id_164F);

  }
  common_scripts\utility::waittill_either("death", "pain_death");
  wait 1;
  var_1 = undefined;

  while(!isDefined(var_1) && isDefined(var_0) && isDefined(var_0.count) && var_0.count > 0) {
    var_1 = var_0 maps\_utility::_id_166F(1);
    wait 1;
  }
}

_id_64C1() {
  if(issentient(self)) {
    thread _id_64C2();
  } else if(isDefined(self._id_0A39)) {
    waittillframeend;

    foreach(var_1 in self._id_0A39) {
      if(isDefined(var_1) && isalive(var_1)) {
        var_1 thread _id_64C2();
      }
    }
  }
}

_id_64C2() {
  self notify("thread_target_escape_chopper");
  self endon("thread_target_escape_chopper");
  self endon("death");
  common_scripts\utility::flag_wait("escape_chopper_took_off");
  self setentitytarget(_id_64A2());
}

_id_64C3(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1)) {
    var_1 notify("trigger");
  }
}

_id_594D(var_0, var_1, var_2) {
  var_3 = "array_wait_any_" + var_1;

  foreach(var_5 in var_0) {}
  var_5 thread _id_594E(var_1, var_3);

  if(!isDefined(var_2)) {
    level waittill(var_3);
  } else {
    level common_scripts\utility::waittill_any_timeout(var_2, var_3);
  }
}

_id_594E(var_0, var_1) {
  self waittill(var_0);
  level notify(var_1);
}

_id_64C4() {
  maps\_utility::_id_109E();
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self._id_0EEE = 1;
  maps\_utility::_id_1057();
  maps\_utility::_id_0EEC();
  self.pathenemylookahead = 1024;
  maps\_utility::_id_2131(1);
  self._id_20AF = 50;
}

_id_64C5() {
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self._id_0EEE = 0;
  maps\_utility::_id_1071();
  maps\_utility::_id_27B8();
  maps\_utility::_id_27B9();
  self._id_0FC6 = 1;
}

_id_64C6(var_0, var_1, var_2) {
  maps\_utility::_id_109E();
  maps\_utility::_id_140B(var_1, 1);
  self._id_117F = 1;
  self._id_1199 = 1;
  self.goalradius = 32;
  self setgoalnode(var_0);
  self waittill("goal");
  self setgoalpos(self.origin);

  if(isDefined(var_2) && var_2 == 1) {
    _id_64C7();
  }
}

_id_64C7() {
  maps\_utility::_id_140C();
  self._id_117F = 0;
  self._id_1199 = 0;
}

_id_64C8(var_0) {
  if(!isDefined(self._id_64C9)) {
    self._id_64C9 = 1;
    self._id_64CA = 1;

    if(isalive(self)) {
      self.health = self.health * 3;

    }
    self.maxhealth = self.maxhealth * 3;

    if(!threatbiasgroupexists("player")) {
      createthreatbiasgroup("player");
      level.player._id_64CB = level.player getthreatbiasgroup();
    }

    if(!threatbiasgroupexists("crush_player")) {
      createthreatbiasgroup("crush_player");
      setthreatbias("crush_player", "player", 10000);
    }

    level.player setthreatbiasgroup("player");
    self._id_64CB = self getthreatbiasgroup();
    self setthreatbiasgroup("crush_player");

    if(isDefined(var_0) && var_0) {
      thread maps\_utility::_id_266C();
    }
  }
}

_id_64CC(var_0) {
  var_1 = getaiarray("axis");
  common_scripts\utility::array_thread(var_1, ::_id_64C8, var_0);
}

_id_64CD() {
  if(isDefined(self._id_64C9)) {
    self._id_64C9 = undefined;
    self._id_64CA = 0;
    self.maxhealth = int(self.maxhealth / 3);

    if(isalive(self)) {
      var_0 = int(max(1, int(min(self.health, self.maxhealth))));
      self.health = var_0;
    }

    self setthreatbiasgroup(self._id_64CB);
    var_1 = getaiarray("axis");

    foreach(var_3 in var_1) {
      if(isalive(var_3) && isDefined(var_3._id_64C9)) {
        return;
      }
    }

    level.player setthreatbiasgroup(level.player._id_64CB);
  }
}

_id_64CE() {
  var_0 = getaiarray("axis");
  common_scripts\utility::array_thread(var_0, ::_id_64CD);
}

_id_64CF(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;

  }
  if(var_1) {
    if(!isDefined(level._id_64D0)) {
      level._id_64D0 = [];

    }
    level._id_64D0[var_0] = 1;
  }

  var_2 = getEntArray(var_0, "script_noteworthy");

  foreach(var_4 in var_2) {
    if(var_1) {
      var_5 = strtok(var_4.targetname, "_");
      var_6 = var_5[var_5.size - 1];
      var_4._id_64D1 = int(var_6);
    }

    var_4 thread _id_64D2();
  }
}

_id_64D2() {
  self endon("disable_trigger");
  self._id_64D3 = 1;
  self waittill("trigger");
  var_0 = [];

  if(isDefined(level._id_64D0) && isDefined(level._id_64D0[self.script_noteworthy])) {
    var_1 = getEntArray(self.script_noteworthy, "script_noteworthy");

    foreach(var_3 in var_1) {
      if(var_3._id_64D3 && var_3._id_64D1 <= self._id_64D1) {
        var_0[var_0.size] = var_3;
        var_3._id_64D3 = 0;
      }
    }
  } else {
    var_0 = getEntArray(self.targetname, "targetname");

  }
  foreach(var_3 in var_0) {
    var_3 notify("disable_trigger");
    var_3 common_scripts\utility::trigger_off();
  }
}

_id_64D4() {
  level._id_64D5 = getEntArray("chopper_fog_brush", "targetname");

  foreach(var_1 in level._id_64D5) {
    var_1 hide();
    var_1 notsolid();

    if(isDefined(level.chopper)) {
      var_1.origin = level.chopper.origin;
      var_1 linkto(level.chopper);
    }
  }
}

_id_64D6(var_0) {
  common_scripts\utility::flag_init(var_0);
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {}
  var_3 thread _id_64D7(self, var_0);
}

_id_64D7(var_0, var_1) {
  var_0 endon(var_1);
  self waittill("trigger", var_2);
  thread maps\_utility::_id_25EE(var_1, 0.05);
  level notify(var_1, var_2);
  var_0 notify(var_1, var_2);
}

_id_64D8(var_0, var_1, var_2, var_3) {
  var_4 = getaispeciesarray(var_0, "all");

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && distance(var_6.origin, var_1) <= var_2) {
      var_6._id_648F = 2.0;
      var_6 notify("flashlight_off_delayed");
      var_6 startragdoll();
      var_6 dodamage(var_6.health, (0, 0, 0));
    }
  }

  wait 0.1;
  physicsexplosionsphere(var_1 - (0, 0, var_2 / 4), var_2, var_2 / 2, var_3);
}

_id_64D9(var_0, var_1) {
  var_2 = vectornormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)));
  var_3 = 1;

  if(vectordot(var_2, var_0) < 0) {
    var_3 = -1;

  }
  var_4 = (1.0 - var_1) * var_0;
  var_5 = var_3 * var_1 * var_2;
  return vectornormalize(var_4 + var_5);
}

_id_64DA(var_0) {
  wait 0.1;

  if(!isDefined(var_0)) {
    var_0 = 0.1;

  }
  for(;;) {
    var_1 = self.origin;
    var_2 = self.angles;
    wait(var_0);

    if(var_1 == self.origin && var_2 == self.angles) {
      break;
    }
  }
}

_id_64DB(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = self.origin;
  var_0 = vectornormalize(var_0);
  var_5 = 1.0 / var_2;

  if(isDefined(var_3)) {
    thread _id_64DC();

  }
  for(;;) {
    self moveto(var_4 + var_0 * var_1, var_5, 0.05, 0.05);
    wait(var_5);
    self moveto(var_4 + var_0 * var_1 * -1, var_5, 0.05, 0.05);
    wait(var_5);
  }
}

_id_64DC() {
  self endon("death");

  for(;;) {
    wait 0.05;
  }
}

_id_64DD() {
  var_0 = bulletTrace(self.origin + (0, 0, 32), self.origin, 0, undefined);
  self.origin = var_0["position"];
}

_id_64DE() {
  self.grenadeawareness = 0;
  self._id_59C3 = 1;
  self.ignoreme = 1;
  self.ignoresuppression = 1;
  self._id_460D = self.suppressionwait;
  self.suppressionwait = 0;
  self._id_0EEE = 1;
}

_id_64DF() {
  self.grenadeawareness = 1;
  self._id_59C3 = 0;
  self.ignoreme = 0;
  self.ignoresuppression = 0;
  self.suppressionwait = self._id_460D;
  self._id_460D = undefined;
  self._id_0EEE = 0;
}

_id_596D(var_0, var_1, var_2) {
  level notify("temp_dialogue", var_0, var_1, var_2);
  level endon("temp_dialogue");

  if(!isDefined(var_2)) {
    var_2 = 4;

  }
  if(isDefined(level._id_596E)) {
    level._id_596E destroy();
    level._id_596E = undefined;
  }

  level._id_596E = newhudelem();
  level._id_596E.x = -60;
  level._id_596E.y = -62;
  level._id_596E settext("^2" + var_0 + ": ^7" + var_1);
  level._id_596E.fontscale = 1.46;
  level._id_596E.alignx = "center";
  level._id_596E.aligny = "middle";
  level._id_596E.horzalign = "center";
  level._id_596E.vertalign = "bottom";
  level._id_596E.sort = 1;
  wait(var_2);
  thread _id_596F();
}

_id_596F() {
  level endon("temp_dialogue");

  for(var_0 = 1.0; var_0 > 0.0; var_0 = var_0 - 0.1) {
    level._id_596E.alpha = var_0;
    wait 0.05;
  }

  level._id_596E destroy();
}

_id_64E0(var_0, var_1) {
  level notify("set_black_fade", var_0, var_1);
  level endon("set_black_fade");

  if(!isDefined(var_0)) {
    var_0 = 1;

  }
  var_0 = max(0.0, min(1.0, var_0));

  if(!isDefined(var_1)) {
    var_1 = 1;

  }
  var_1 = max(0.01, var_1);

  if(!isDefined(level._id_64E1)) {
    level._id_64E1 = newhudelem();
    level._id_64E1.x = 0;
    level._id_64E1.y = 0;
    level._id_64E1.horzalign = "fullscreen";
    level._id_64E1.vertalign = "fullscreen";
    level._id_64E1.foreground = 1;
    level._id_64E1.sort = -999;
    level._id_64E1 setshader("black", 650, 490);
    level._id_64E1.alpha = 0.0;
  }

  level._id_64E1 fadeovertime(var_1);
  level._id_64E1.alpha = max(0.0, min(1.0, var_0));

  if(var_0 <= 0) {
    wait(var_1);
    level._id_64E1 destroy();
    level._id_64E1 = undefined;
  }
}

_id_64E2(var_0, var_1) {
  return var_0._id_64E3 > var_1._id_64E3;
}

_id_64E4(var_0, var_1) {
  return var_0._id_64E3 < var_1._id_64E3;
}

_id_64E5(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(!var_4) {
      if([[var_2]](var_0[var_5], var_1)) {
        var_3[var_3.size] = var_1;
        var_4 = 1;
      }
    }

    var_3[var_3.size] = var_0[var_5];
  }

  if(!var_4) {
    var_3[var_3.size] = var_1;

  }
  return var_3;
}

_id_64E6(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[1] = [];
  var_4[0] = [];
  var_5[1] = ::_id_64E4;
  var_5[0] = ::_id_64E4;

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_7 = var_2[var_6];
    var_8 = vectornormalize(var_7.origin - var_0);
    var_9 = vectordot(var_1, var_8);
    var_7._id_64E3 = var_9;
    var_10 = var_9 >= var_3;
    var_4[var_10] = _id_64E5(var_4[var_10], var_7, var_5[var_10]);
  }

  return var_4;
}

_id_64E7(var_0) {
  var_1 = [];
  var_2 = self getEye();

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!bullettracepassed(var_2, var_0[var_3] gettagorigin("tag_eye"), 0, undefined)) {
      continue;
    }
    var_1[var_1.size] = var_0[var_3];
  }

  return var_1;
}

_id_64E8(var_0, var_1) {
  self notify("unlimited_ammo_till");
  self endon("unlimited_ammo_till");

  if(isDefined(var_0)) {
    level endon(var_0);
    self endon(var_0);
  }

  var_2 = 0;

  for(;;) {
    if(isDefined(var_1) && var_2 >= var_1) {
      return;
    }
    var_3 = self getcurrentweapon();

    if(var_3 != "none") {
      var_4 = self getcurrentweaponclipammo();
      var_5 = weaponclipsize(var_3);

      if(isDefined(var_5)) {
        var_6 = var_5 - var_4;

        if(isDefined(var_6) && var_6 > 0) {
          self setweaponammoclip(var_3, var_4 + var_6);
        }
      }
    }

    wait 0.05;
    var_2 = var_2 + 0.05;
  }
}

_id_64E9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level notify("phantom_pressure");
  level endon("phantom_pressure");

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }
    var_8 = 500;
    var_9 = var_2[randomint(var_2.size)];

    if(isDefined(var_9.radius)) {
      var_8 = var_9.radius;

    }
    var_10 = vectornormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)));

    if(vectordot(var_10, (0, 0, 1)) < 0) {
      var_10 = var_10 * -1;

    }
    var_10 = var_10 * randomfloatrange(0, var_8);
    var_11 = var_9.origin + var_10;
    var_12 = var_11 - var_0.origin;
    var_13 = length(var_12);
    var_12 = vectornormalize(var_12);
    var_14 = vectortoangles(var_12);
    var_14 = anglestoup(var_14);
    var_14 = _id_64D9(var_14, 0.6);
    var_15 = 200;

    if(randomint(4) == 0) {
      var_14 = var_14 * -1;
      var_15 = 50;
    }

    if(isDefined(var_7)) {
      var_15 = var_15 * (1.0 / var_7);

    }
    var_14 = var_14 * randomfloatrange(var_15, var_15 + 50);
    var_16 = var_0.origin + var_14 + var_12 * -1000;
    var_17 = bulletTrace(var_11, var_16, 1);
    var_18 = var_17["entity"];

    if(!isDefined(var_18) || !isDefined(var_18.team) || var_18.team != level.player.team) {
      magicbullet(var_1, var_11, var_16);
      maps\_audio::aud_send_msg("magic_bullet_fire", var_11);
    }

    var_19 = randomfloatrange(var_3, var_3 * 2);
    var_20 = (var_13 - var_5) / (var_6 - var_5);

    if(var_20 > 0) {
      var_21 = var_4 - var_3 * 2;
      var_19 = var_19 + randomfloatrange(var_21 * 0.5, var_21);
    }

    wait(var_19);
  }
}

_id_64EA(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  level endon(var_0);
  var_13 = var_4 - var_3;
  var_14 = var_2 - var_1;
  var_15 = var_6 - var_5;
  var_16 = var_8 - var_7;

  for(;;) {
    var_17 = (0, 0, 0);
    var_18 = [];

    foreach(var_22, var_20 in var_12) {
      var_17 = var_17 + var_20.origin;
      var_21 = distance(var_20.origin, level._id_64EB);
      var_18[var_22] = var_21 + var_11[var_22];
    }

    var_17 = var_17 / var_12.size;
    var_23 = 99999999;

    foreach(var_21 in var_18) {
      if(var_21 < var_23) {
        var_23 = var_21;
      }
    }

    var_26 = [];

    foreach(var_22, var_21 in var_18) {}
    var_18[var_22] = var_18[var_22] - var_23;

    var_28 = 0;

    foreach(var_21 in var_18) {
      if(var_21 > var_28) {
        var_28 = var_21;
      }
    }

    var_31 = var_28 * var_9 / var_10;
    var_31 = var_31 * 0.5;

    if(var_31 > var_9) {
      var_31 = var_9;

    }
    var_32 = var_28 * 0.5;
    var_26 = [];

    foreach(var_22, var_21 in var_18) {
      var_21 = var_21 - var_32;
      var_21 = var_21 / abs(var_32);
      var_26[var_22] = var_21 * var_31;
    }

    var_34 = distance(var_17, level._id_64EB);
    var_35 = distance(level.player.origin, level._id_64EB);
    var_21 = var_35 - var_34;
    level notify("player_dist_from_squad", var_21);
    var_36 = var_21;
    var_21 = var_21 - var_3;
    var_37 = var_21 / var_13;

    if(var_37 < 0) {
      var_37 = 0;
    } else if(var_37 > 1) {
      var_37 = 1;

    }
    var_37 = 1 - var_37;
    var_38 = var_1 + var_14 * var_37;
    var_21 = var_36 - var_7;
    var_37 = var_21 / var_16;

    if(var_37 < 0) {
      var_37 = 0;
    } else if(var_37 > 1) {
      var_37 = 1;

    }
    var_39 = var_5 + var_15 * var_37;
    setsaveddvar("player_sprintSpeedScale", var_39);

    if(1) {
      foreach(var_22, var_20 in var_12) {
        var_20._id_0FC6 = var_38 + var_26[var_22];

        if(var_20._id_0FC6 > 1.15) {
          var_20._id_0FC6 = 1.15;
        }
      }
    }

    wait 0.05;
  }
}

_id_64EC() {
  if(!isDefined(self._id_164F)) {
    return;
  }
  var_0 = strtok(self._id_164F, ":;, ");

  foreach(var_2 in var_0) {
    var_2 = tolower(var_2);

    if(var_2 == "balcony") {
      self._id_0D45 = ::_id_64ED;
    }
  }
}

_id_64ED() {
  if(!isDefined(self)) {
    return 0;

  }
  if(self.a._id_0D26 == "prone") {
    return 0;

  }
  if(!isDefined(self.prevnode)) {
    return 0;

  }
  if(!isDefined(self.prevnode._id_64EE)) {
    return 0;

  }
  var_0 = self.angles[1];
  var_1 = self.prevnode.angles[1];
  var_2 = abs(angleclamp180(var_0 - var_1));

  if(var_2 > 45) {
    return 0;

  }
  var_3 = distance(self.origin, self.prevnode.origin);

  if(var_3 > 16) {
    return 0;

  }
  if(isDefined(level._id_64EF)) {
    var_4 = gettime() - level._id_64EF;

    if(var_4 < 5000) {
      return 0;
    }
  }

  var_5 = getEntArray("trigger_balcony", "targetname");

  foreach(var_7 in var_5) {
    var_3 = distance(var_7.origin, self.origin);

    if(var_3 < 48) {
      var_7 notify("trigger");
    }
  }

  glassradiusdamage(self.origin, 48, 500, 500);
  level._id_64EF = gettime();
  var_9 = maps\_utility::_id_270F("balcony_death");
  self._id_0D50 = var_9[randomint(var_9.size)];
  return 0;
}

_id_64F0(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = var_2 maps\_utility::_id_2789("axis");
  var_4 = var_3.size;

  while(var_4 > var_1) {
    wait 1;
    var_3 = var_2 maps\_utility::_id_2789("axis");
    var_4 = var_3.size;

    if(var_4 - var_1 < 3) {
      foreach(var_6 in var_3) {
        if(var_6 maps\_utility::_id_0D69() || var_6.delayeddeath) {
          var_4--;
        }
      }
    }
  }
}

_id_64F1(var_0) {
  setsaveddvar("player_sprintSpeedScale", 1.5);

  foreach(var_3, var_2 in var_0) {}
  var_2._id_0FC6 = 1;
}

_id_64F2(var_0, var_1) {
  foreach(var_3 in var_0) {}
  thread _id_64F3(var_3, var_1);

  level waittill("sandstorm_combat_" + var_1);
}

_id_64F3(var_0, var_1) {
  var_0 common_scripts\utility::waittill_any("enemy", "death", "damage");
  level notify("sandstorm_combat_" + var_1);
}

_id_64F4(var_0, var_1) {
  level maps\_utility::_id_1255(::_id_64F5, self, var_0, var_1);
}

_id_64F5(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    var_0 maps\_utility::_id_11F4(var_1);
  } else {
    var_0 maps\_utility::_id_168C(var_1);
  }
}

_id_64F6(var_0, var_1) {
  var_2 = gettime();

  if(!isDefined(var_1)) {
    var_1 = 0;

  }
  if(isDefined(var_0._id_2753) && var_0._id_2753 + var_1 >= var_2) {
    return var_0._id_2754;

  }
  var_0._id_2753 = var_2;

  if(!maps\_utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766)) {
    var_0._id_2754 = 0;
    return 0;
  }

  var_3 = level.player getEye();
  var_4 = var_0.origin;

  if(sighttracepassed(var_3, var_4, 0, level.player)) {
    var_0._id_2754 = 1;
    return 1;
  }

  var_5 = var_0 getEye();

  if(sighttracepassed(var_3, var_5, 0, level.player)) {
    var_0._id_2754 = 1;
    return 1;
  }

  var_6 = (var_5 + var_4) * 0.5;

  if(sighttracepassed(var_3, var_6, 0, level.player)) {
    var_0._id_2754 = 1;
    return 1;
  }

  var_0._id_2754 = 0;
  return 0;
}

_id_64F7(var_0, var_1) {
  self notify("tv_trigger_wait_enter");
  self endon("tv_trigger_wait_enter");

  for(;;) {
    self waittill("trigger", var_2);
    level thread _id_64FB(var_0, var_1);
    _id_64F8(var_2);
  }
}

_id_64F8(var_0) {
  self notify("tv_trigger_wait_leave");
  self endon("tv_trigger_wait_leave");
  level endon("tv_movies_played");

  while(isalive(var_0) && var_0 istouching(self)) {
    wait 0.05;

  }
  _id_64FD();
  level._id_64F9 = undefined;
  level._id_64FA = undefined;
}

_id_64FB(var_0, var_1) {
  level notify("tv_movies_play");
  level endon("tv_movies_play");
  level endon("tv_movies_stop");

  if(isDefined(var_0)) {
    level._id_64F9 = var_0;

  }
  if(isDefined(var_1)) {
    level._id_64FA = var_1;

  }
  while(isDefined(level._id_64F9) && level._id_64F9 != "") {
    level notify("tv_movies_played");
    setsaveddvar("cg_cinematicFullScreen", "0");
    cinematicingame(level._id_64F9);
    var_2 = getEntArray("interactive_tv", "targetname");

    foreach(var_4 in var_2) {
      if(!isDefined(var_4._id_64FC)) {
        if(isDefined(level._id_64FA) && level._id_64FA != "") {
          var_4 playLoopSound(level._id_64FA);

        }
        var_4 thread _id_64FE();
      }
    }

    wait 0.05;

    while(iscinematicplaying()) {
      wait 1;
    }
  }
}

_id_64FD() {
  level notify("tv_movies_stop");
  stopcinematicingame();
  var_0 = getEntArray("interactive_tv", "targetname");

  foreach(var_2 in var_0) {
    var_2 notify("tv_death");
    var_2 stoploopsound();
  }
}

_id_64FE() {
  self notify("tv_death");
  self endon("tv_death");
  common_scripts\utility::waittill_any("death", "destroyed");
  self._id_64FC = 1;
  self stoploopsound();
}

_id_64FF(var_0, var_1, var_2) {
  level notify("custom_in_game_movie");
  level endon("custom_in_game_movie");
  _id_64FD();

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);

  }
  setsaveddvar("cg_cinematicFullScreen", "0");
  cinematicingame(var_0);
  wait(var_2);
  level thread _id_64FB();
}

_id_6500(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0.05;

  }
  var_0 = var_0 + "";

  if(!isDefined(level._id_6501)) {
    level._id_6501 = [];

  }
  level._id_6501["num"] = [];

  for(var_2 = 0; var_2 < level.createfxent.size; var_2++) {
    var_3 = level.createfxent[var_2];

    if(isDefined(var_3) && var_3.v["type"] == "exploder" && var_3.v["exploder"] + "" == var_0) {
      var_4 = var_3.v["origin"];
      var_5 = anglestoup(var_4);
      var_6 = var_3.v["angles"];
      var_7 = anglesToForward(var_6);
      var_8 = spawnfx(level._effect[var_3.v["fxid"]], var_3.v["origin"], var_7, var_5);
      triggerfx(var_8, var_1);
      level._id_6501["num"][level._id_6501["num"].size] = var_8;
    }
  }
}

_id_6502(var_0) {
  if(isDefined(level._id_6501["num"])) {
    level._id_6501["num"] = common_scripts\utility::array_removeundefined(level._id_6501["num"]);
    var_1 = level._id_6501["num"];
    maps\_utility::_id_135B(level._id_6501["num"]);
    common_scripts\utility::array_removeundefined(level._id_6501["num"]);
  }
}

_id_6503(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == 0) {
    setsaveddvar("compass", 0);
  } else {
    setsaveddvar("compass", 1);

  }
  if(var_1 == 0) {
    setsaveddvar("ammoCounterHide", 1);
  } else {
    setsaveddvar("ammoCounterHide", 0);

  }
  if(var_2 == 0) {
    setsaveddvar("hud_showstance", 0);
  } else {
    setsaveddvar("hud_showstance", 1);

  }
  if(var_3 == 0) {
    setsaveddvar("actionSlotsHide", 1);
  } else {
    setsaveddvar("actionSlotsHide", 0);

  }
  if(var_4 == 0) {
    setsaveddvar("hud_drawhud", 0);
  } else {
    setsaveddvar("hud_drawhud", 1);
  }
}