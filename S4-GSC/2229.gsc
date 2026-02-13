/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2229.gsc
*************************************************/

_id_64D1(var_0) {
  if(!isDefined(level._id_0408._id_7225._id_722F[var_0])) {
    return undefined;
  }

  return level._id_0408._id_7225._id_722F[var_0]._id_9DB5;
}

_id_720B(var_0, var_1) {
  var_2 = _id_64D2(var_0, var_1);
  scripts\engine\utility::_id_5C04(var_2);
  var_3 = level._id_0408._id_71F4._id_01C4[var_0];
  var_4 = 1;

  foreach(var_7, var_6 in var_3) {
    if(!issubstr(var_6, "allies") && scripts\engine\utility::_id_5C00(var_6)) {
      return;
    }
  }

  if(scripts\engine\utility::_id_5C00(var_2) && self != level) {
    self notify(var_0);
  }

  scripts\engine\utility::_id_5C04(var_0);
}

_id_720D(var_0) {
  var_1 = _id_64D2(var_0);

  if(!scripts\engine\utility::_id_5C00(var_1) && self != level) {
    self notify(var_0);
  }

  scripts\engine\utility::_id_5C1B(var_1);
  scripts\engine\utility::_id_5C1B(var_0);
}

_id_720A(var_0) {
  var_1 = _id_64D2(var_0);
  return scripts\engine\utility::_id_5C00(var_1);
}

_id_64D2(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self._id_CE6E;
  }

  var_2 = var_0 + "-Group:" + var_1;
  return var_2;
}

_id_720E(var_0) {
  var_1 = _id_64D2(var_0);
  scripts\engine\utility::_id_5C24(var_1);
}

_id_7210(var_0) {
  var_1 = _id_64D2(var_0);
  scripts\engine\utility::_id_5C30(var_1);
}

_id_720F(var_0, var_1) {
  var_2 = _id_64D2(var_0);
  scripts\engine\utility::_id_5C2E(var_2, var_1);
}

_id_7211(var_0, var_1) {
  var_2 = _id_64D2(var_0);
  scripts\engine\utility::_id_5C36(var_2, var_1);
}

_id_720C(var_0) {
  if(isDefined(self._id_CE6E)) {
    self._id_CE6E = scripts\engine\utility::_id_EA52(self._id_CE6E);
  } else {
    self._id_CE6E = "default";
  }

  if(self.team == "allies") {
    self._id_CE6E = self._id_CE6E + "allies";
  }

  if(!scripts\engine\utility::_id_5C0C(var_0)) {
    scripts\engine\utility::_id_5C11(var_0);
  }

  var_1 = _id_64D2(var_0);

  if(!scripts\engine\utility::_id_5C0C(var_1)) {
    scripts\engine\utility::_id_5C11(var_1);

    if(!isDefined(level._id_0408._id_71F4._id_01C4[var_0])) {
      level._id_0408._id_71F4._id_01C4[var_0] = [];
    }

    level._id_0408._id_71F4._id_01C4[var_0][level._id_0408._id_71F4._id_01C4[var_0].size] = var_1;
  }
}

_id_721B(var_0, var_1) {
  if(!isDefined(level._id_0408._id_3A97)) {
    level._id_0408._id_3A97 = [];
  }

  level._id_0408._id_3A97[var_0] = var_1;
}

_id_71F7() {
  if(!isDefined(level._id_0408._id_71F4._id_722F[self._id_CE6E])) {
    level._id_0408._id_71F4._id_722F[self._id_CE6E] = [];
    level._id_0408._id_71F4 notify(self._id_CE6E);
  }

  level._id_0408._id_71F4._id_722F[self._id_CE6E][level._id_0408._id_71F4._id_722F[self._id_CE6E].size] = self;
}

_id_721C() {
  var_0 = _id_64D2("stealth_spotted");
  return scripts\engine\utility::_id_5C00(var_0);
}

_id_1907(var_0) {
  if(!scripts\engine\utility::_id_5C00("stealth_enabled")) {
    return 0;
  }

  foreach(var_2 in level._id_0408._id_7225._id_722F) {
    if(isDefined(var_0) && !scripts\engine\utility::array_contains(var_0, var_2.name)) {
      continue;
    }
    if(_id_08AF::_id_71F8(var_2.name)) {
      return 1;
    }
  }

  return 0;
}

_id_678F() {
  switch (self._id_0408._id_E747) {
    case 0:
      return "normal";
    case 1:
      return "warning";
    case 2:
      return "warning";
    case 3:
      return "attack";
  }
}

_id_D3C9(var_0) {
  switch (var_0) {
    case "attack":
      var_1 = 3;
      break;
    case "warning2":
      var_1 = 2;
      break;
    case "warning1":
      var_1 = 1;
      break;
    default:
      var_1 = 0;
      break;
  }

  self._id_0408._id_E747 = var_1;
}

_id_34C5() {}

_id_1432() {
  level._id_0408._id_1429 = [];
  level._id_0408._id_1429["normal"] = "noncombat";
  level._id_0408._id_1429["reset"] = "noncombat";
  level._id_0408._id_1429["warning1"] = "alert";
  level._id_0408._id_1429["warning2"] = "alert";
  level._id_0408._id_1429["combat_hunt"] = "alert";
  level._id_0408._id_1429["attack"] = "combat";
  level._id_0408._id_142A = [];
  level._id_0408._id_142A["normal"] = 0;
  level._id_0408._id_142A["reset"] = 0;
  level._id_0408._id_142A["warning1"] = 1;
  level._id_0408._id_142A["warning2"] = 2;
  level._id_0408._id_142A["combat_hunt"] = 2;
  level._id_0408._id_142A["attack"] = 3;
  level._id_0408._id_1429["combat"] = 3;
}

_id_1434(var_0) {
  if(isDefined(level._id_0408._id_1429[var_0])) {
    return level._id_0408._id_1429[var_0];
  }

  return var_0;
}

_id_1435(var_0) {
  if(isDefined(level._id_0408._id_142A[var_0])) {
    return level._id_0408._id_142A[var_0];
  }

  return -1;
}

_id_D1CD(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {}

  _id_08B1::_id_D1CE(var_0, var_1);
}

_id_D290(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1)) {}

  if(isDefined(var_0)) {
    level._id_0408._id_4892._id_9F37["hidden"]["prone"] = var_0["prone"];
    level._id_0408._id_4892._id_9F37["hidden"]["crouch"] = var_0["crouch"];
    level._id_0408._id_4892._id_9F37["hidden"]["stand"] = var_0["stand"];
  }

  if(isDefined(var_1)) {
    level._id_0408._id_4892._id_9F37["spotted"]["prone"] = var_1["prone"];
    level._id_0408._id_4892._id_9F37["spotted"]["crouch"] = var_1["crouch"];
    level._id_0408._id_4892._id_9F37["spotted"]["stand"] = var_1["stand"];
  }
}

_id_4C28() {
  if(!isDefined(level.player._id_0408)) {
    _id_08B0::_id_D3C7(1);
  }

  switch (self.team) {
    case "team3":
    case "axis":
      thread _id_08AC::main();
      break;
    case "allies":
      thread _id_08AE::main();
      break;
    case "neutral":
      thread _id_08B2::main();
      break;
  }
}

_id_CB38() {
  if(isDefined(self._id_0408._id_8F23)) {
    return;
  }
  self._id_CB46 = self._id_CD56;

  if(isDefined(self._id_8F58)) {
    self._id_0408._id_8F23 = self._id_8F58;
  } else if(isDefined(self._id_8F57)) {
    self._id_0408._id_8F23 = self._id_8F57.origin;
  } else if(isDefined(self._id_8F59)) {
    self._id_0408._id_8F23 = self._id_8F59;
  } else {
    self._id_0408._id_8F23 = self.origin;
  }
}

_id_D2E6(var_0) {}

_id_D1B7(var_0) {
  self._id_0408._id_4581 = var_0;

  if(isDefined(self._id_0408._id_4581)) {
    _id_D2E8(self._id_0408._id_4581);
  }
}

_id_664B(var_0) {
  switch (var_0) {
    case "small":
      return 0;
    case "smed":
      return 1;
    case "med":
      return 2;
    case "large":
      return 3;
  }
}

_id_D2E8(var_0, var_1, var_2, var_3) {
  if(var_0 == "unaware") {
    var_0 = "patrol";
  }

  scripts\common\utility::_id_47A7(var_0);

  if(var_0 == "cqb") {
    var_4 = 60;

    if(isDefined(self._id_0408._id_7BC4)) {
      var_4 = self._id_0408._id_7BC4;
    }

    scripts\engine\utility::set_movement_speed(var_4);
  }

  if(istrue(var_1)) {
    _id_D2E7(var_2, var_3);
  }
}

_id_664C() {
  return _id_0009::_id_1C61();
}

_id_664D() {
  var_0 = self._id_0408._id_4581;

  if(!isDefined(var_0)) {
    var_0 = level._id_0408._id_4581;
  }

  return var_0;
}

_id_D2E7(var_0, var_1) {
  if(isDefined(self._id_0408._id_2B71)) {
    if(_id_664B(self._id_0408._id_2B71) >= _id_664B(var_1)) {
      return;
    }
  }

  self._id_0408._id_AF2F = var_1;
  self._id_0408._id_AF30 = var_0;
  self._id_0408._id_AF31 = gettime();
}

_id_70F7() {
  self notify("going_back");
  self endon("death");

  if(isDefined(self._id_0408._id_7093)) {
    self[[self._id_0408._id_7093]]();
  }

  var_0 = self._id_0408._id_8F23;

  if(isDefined(self._id_CB46)) {
    self._id_CD56 = self._id_CB46;
    self._id_CB46 = undefined;
  }

  if(_func_02E1(var_0)) {
    self._id_0408._id_8F23 = undefined;
    _id_E7D7(0);
    return;
  }

  if(isDefined(var_0)) {
    self _meth_8326(var_0);
    self._id_0201 = 40;
  }

  if(isDefined(var_0)) {
    thread _id_70F8(var_0);
  }

  wait 0.05;
  _id_E7D7(0);
}

_id_70F8(var_0) {
  self endon("death");
  _id_1093A(var_0);
  self._id_0408._id_8F61 = undefined;
}

_id_1425(var_0) {
  var_1 = 2;

  if(isDefined(self._id_0408._id_9C4E)) {
    var_1 = self._id_0408._id_9C4E;
  }

  if(self[[self._id_5D9C]]()) {
    var_1 = min(1.5, var_1);
  } else if(self[[self._id_5D99]]()) {
    var_1 = min(1.0, var_1);
  }

  var_2 = 0.1;
  var_3 = 0.4;
  var_4 = 64;
  var_5 = 1024;
  var_6 = distance2d(self.origin, var_0.origin);

  if(var_6 < var_4) {
    var_7 = scripts\engine\math::_id_A5C5(0, var_4, var_6);
    var_8 = scripts\engine\math::_id_5898(var_2, var_3, var_7);
  } else {
    var_7 = scripts\engine\math::_id_A5C5(var_4, var_5, var_6);
    var_8 = scripts\engine\math::_id_5898(var_3, var_1, var_7);
  }

  return var_8;
}

_id_D2E4(var_0) {
  var_0._id_4BB7 = _id_6643(self.origin, var_0.origin, self);
}

_id_6643(var_0, var_1, var_2) {
  var_3 = self _meth_847B(var_0, var_1);

  if(isDefined(var_2)) {
    var_2._id_AEC7 = var_3;
  }

  var_4 = 0;

  for(var_5 = 1; var_5 < var_3.size; var_5++) {
    var_4 = var_4 + distancesquared(var_3[var_5 - 1], var_3[var_5]);
  }

  return var_4;
}

_id_C42B() {
  self._id_AEC7 = undefined;
  self._id_4BB7 = undefined;
}

_id_8712(var_0) {
  if(isPlayer(self)) {
    if(scripts\engine\utility::_id_10E76(self.origin, self.angles, var_0.origin, 0.766)) {
      if(isDefined(var_0._id_ED67) || _id_ED61()) {
        return 1;
      }

      if(scripts\anim\utility_common::_id_B3D2(self, var_0, 250)) {
        return 1;
      }
    }
  } else
    return self _meth_8067(var_0);

  return 0;
}

_id_ED61() {
  return isDefined(self._id_A951) && isDefined(self._id_A951._id_0026) && self._id_A951._id_0026;
}

_id_6987() {
  if(isDefined(level._id_0408)) {
    if(isDefined(level._id_0408._id_10CD) && isDefined(level._id_0408._id_10CD[self getentitynumber()])) {
      return self.origin;
    }

    if(isDefined(level._id_0408._id_5D88)) {
      return [[level._id_0408._id_5D88]]();
    }
  }

  return self.origin;
}

_id_D492(var_0) {
  if(isDefined(level._id_0408) && isDefined(level._id_0408._id_5DBA)) {
    return [[level._id_0408._id_5DBA]](var_0);
  }
}

_id_10AC(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level._id_0408) && isDefined(level._id_0408._id_5D53)) {
    return [[level._id_0408._id_5D53]](var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_18A9(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level._id_0408) && isDefined(level._id_0408._id_5D5A)) {
    return [[level._id_0408._id_5D5A]](var_0, var_1, var_2, var_3, var_4, var_5);
  }
}

_id_E7B8(var_0, var_1) {
  self notify("stealth_music");
  self endon("stealth_music");
  thread _id_E7B9();

  for(;;) {
    scripts\engine\utility::_id_5C24("stealth_enabled");
    scripts\engine\utility::_id_5C30("stealth_spotted");
    scripts\engine\utility::_id_5C30("stealth_music_pause");

    foreach(var_3 in level.players) {
      var_3 thread _id_E7BC(var_0);
    }

    scripts\engine\utility::_id_5C24("stealth_spotted");
    scripts\engine\utility::_id_5C30("stealth_music_pause");

    foreach(var_3 in level.players) {
      var_3 thread _id_E7BC(var_1);
    }
  }
}

_id_E7BA() {
  self notify("stealth_music");
  self notify("stealth_music_pause_monitor");

  foreach(var_1 in level.players) {
    var_1 thread _id_E7BC(undefined);
  }
}

_id_E7B9(var_0, var_1) {
  self notify("stealth_music_pause_monitor");
  self endon("stealth_music_pause_monitor");

  for(;;) {
    scripts\engine\utility::_id_5C24("stealth_music_pause");

    foreach(var_3 in level.players) {
      var_3 thread _id_E7BC(undefined);
    }

    scripts\engine\utility::_id_5C30("stealth_music_pause");

    if(scripts\engine\utility::_id_5C00("stealth_spotted")) {
      foreach(var_3 in level.players) {
        var_3 thread _id_E7BC(var_1);
      }

      continue;
    }

    foreach(var_3 in level.players) {
      var_3 thread _id_E7BC(var_0);
    }
  }
}

_id_E7BC(var_0) {
  if(isDefined(self._id_5DC9)) {
    return [[self._id_5DC9]](var_0);
  }
}

_id_FB7D() {
  if(isDefined(self._id_5DD0)) {
    return [[self._id_5DD0]]();
  }
}

_id_D1DC(var_0) {
  if(isDefined(level._id_0408._id_5DBC)) {
    self[[level._id_0408._id_5DBC]](var_0);
  }
}

_id_D1DD(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
    level._id_0408._id_4B39 = 1;
    level._id_0408._id_F16A = 0.4;
    level._id_0408._id_F169 = 0.4;
    level._id_0408._id_BDCC = 0;
    level._id_0408._id_BDCE = 0;
    level._id_0408._id_BDCD = 0;
    setsaveddvar("#x3cd925342b619dce4", 0.25);
    setsaveddvar("#x344b7ec70967f8c6b", cos(90));
    setsaveddvar("#x36509f372440175f2", 0.025);
    setsaveddvar("#x3a4e628015921ae35", 0.25);
  } else {
    level._id_0408._id_4B39 = undefined;
    level._id_0408._id_F16A = undefined;
    level._id_0408._id_F169 = undefined;
    level._id_0408._id_BDCC = 100;
    level._id_0408._id_BDCE = 150;
    level._id_0408._id_BDCD = 60;
    setsaveddvar("#x3cd925342b619dce4", 0.5);
    setsaveddvar("#x344b7ec70967f8c6b", cos(180));
    setsaveddvar("#x36509f372440175f2", 0.01);
    setsaveddvar("#x3a4e628015921ae35", 0.1);
  }

  var_1 = _func_0070();

  foreach(var_3 in var_1) {
    if(!isalive(var_3)) {
      continue;
    }
    if(isDefined(var_3._id_0408) && isDefined(var_3._id_0408._id_F159)) {
      var_3 _id_08B4::_id_F153();
    }
  }
}

_id_E7D7(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(var_0) {
    self._id_C3C2 = 1;
    scripts\engine\utility::_id_5474("stealth_override_goal");
    _id_08AC::_id_D173(0);
    self._id_8F57 = undefined;
  } else
    scripts\engine\utility::_id_5470("stealth_override_goal");
}

_id_E797() {
  return scripts\engine\utility::_id_5472("stealth_override_goal") && scripts\engine\utility::_id_546E("stealth_override_goal");
}

_id_E798() {
  if(_id_E797()) {
    scripts\engine\utility::_id_547B("stealth_override_goal");
  }
}

_id_4A58() {
  scripts\engine\utility::_id_5C04("stealth_enabled");
  _id_08B0::_id_D3C7(0);
  var_0 = _func_0074("all", "all");

  foreach(var_2 in var_0) {
    var_2 _id_5228(0);
  }

  foreach(var_5 in level.players) {
    var_5._id_02A1 = 8192;

    if(var_5 scripts\engine\utility::_id_5472("stealth_enabled")) {
      var_5 scripts\engine\utility::_id_5470("stealth_enabled");
    }
  }

  _id_08B1::_id_5692("spotted");
}

_id_5229() {
  if(!isDefined(level._id_0408)) {
    if(isDefined(level._id_5DC0)) {
      [[level._id_5DC0]]();
    } else {
      _id_08B0::main();
    }
  } else
    scripts\engine\utility::_id_5C1B("stealth_enabled");

  if(!isDefined(level.player._id_0408)) {
    _id_08B0::_id_D3C7(1);
  }

  var_0 = _func_0074("all", "all");

  foreach(var_2 in var_0) {
    var_2 _id_5228(1);
  }

  foreach(var_5 in level.players) {
    if(var_5 scripts\engine\utility::_id_5472("stealth_enabled")) {
      var_5 scripts\engine\utility::_id_5474("stealth_enabled");
    }
  }
}

_id_5228(var_0, var_1) {
  if(!var_0) {
    self._id_02A1 = 8192;

    if(scripts\engine\utility::_id_5472("stealth_enabled") && scripts\engine\utility::_id_546E("stealth_enabled") && self.team == "axis") {
      var_2 = spawnStruct();
      var_2.origin = level.player.origin;
      var_2._id_8511 = level.player.origin;
      var_2._id_8512 = level.player.origin;
      var_2.type = "combat";
      var_2._id_F8E4 = "attack";
      self._id_017F = 0;
      _id_08AC::_id_2C60(var_2);
    }

    if(istrue(var_1)) {
      _id_3908();
    }
  }

  if(scripts\engine\utility::_id_5472("stealth_enabled")) {
    if(var_0) {
      scripts\engine\utility::_id_5474("stealth_enabled");
    } else {
      scripts\engine\utility::_id_5470("stealth_enabled");
    }
  }

  if(var_0 && istrue(var_1)) {
    _id_0ED4();
  }
}

_id_4260(var_0) {
  if(isDefined(var_0["spotted"])) {
    self._id_E7E8["spotted"] = var_0["spotted"];
  }

  if(isDefined(var_0["hidden"])) {
    self._id_E7E8["hidden"] = var_0["hidden"];
  }
}

_id_D3C4(var_0, var_1) {
  self._id_0408._id_6035[var_0] = var_1;
}

_id_D1F3(var_0, var_1) {
  if(isDefined(var_0) && isDefined(self._id_0408) && isDefined(self._id_0408._id_6035)) {
    self._id_0408._id_6035["event_" + var_0] = var_1;
  }
}

_id_2434() {
  self endon("death");

  if(isDefined(self._id_5D98) && self[[self._id_5D98]]()) {
    return 1;
  }

  if(!isDefined(self._id_0408)) {
    return 1;
  }

  return 0;
}

_id_0B61() {
  return 1;
}

_id_1093A(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = self._id_0201;
  }

  for(;;) {
    self waittill("goal");

    if(distance(self.origin, var_0) < var_1 + 10) {
      break;
    }
  }
}

_id_666E() {
  if(isDefined(level._id_0408._id_5D8D)) {
    return [[level._id_0408._id_5D8D]](self);
  }
}

_id_3908() {
  if(isDefined(self._id_5D6F)) {
    [[self._id_5D6F]]();
  }
}

_id_0ED4() {
  if(isDefined(self._id_5D52)) {
    [[self._id_5D52]]();
  }
}