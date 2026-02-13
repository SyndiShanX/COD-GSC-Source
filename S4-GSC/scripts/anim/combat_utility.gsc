/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\anim\combat_utility.gsc
*************************************************/

_id_6DB9(var_0) {
  var_1 = self _meth_8176() + (0, 0, -3);
  var_2 = (var_1[0] - var_0[0], var_1[1] - var_0[1], var_1[2] - var_0[2]);
  var_2 = vectornormalize(var_2);
  var_3 = var_2[2] * -1;
  return var_3;
}

_id_6CEB() {
  var_0 = (gettime() - self._id_0DDF._id_9041) / 1000;
  var_1 = _id_6937();

  if(var_1 > var_0) {
    return var_1 - var_0;
  }

  return 0;
}

_id_6937() {
  if(scripts\anim\utility_common::_id_8AD4()) {
    return randomfloatrange(0.15, 0.55);
  } else if(scripts\anim\utility_common::_id_10D12()) {
    return randomfloatrange(1.0, 1.7);
  } else if(scripts\anim\utility_common::_id_10CF9()) {
    return _id_08F1::_id_716B();
  } else if(scripts\anim\utility_common::_id_8766()) {
    return _id_08F1::_id_6D38();
  } else if(self._id_59BA) {
    return randomfloatrange(0.1, 0.35);
  } else {
    return randomfloatrange(0.2, 0.4);
  }
}

_id_DA3D() {}

_id_6E20() {
  anim._id_18A7++;
  return anim._id_18A7;
}

#using_animtree("generic_human");

_id_D844(var_0) {
  self _meth_82D9(%exposed_aiming, 1, 0.2);

  if(scripts\engine\utility::_id_0F78()) {
    self _meth_831B("exposed_aim", scripts\anim\utility::_id_1872("straight_level"), 1, var_0);
  } else {
    self _meth_82E0(scripts\anim\utility::_id_1872("straight_level"), 1, var_0);
  }

  self _meth_82E0(scripts\anim\utility::_id_1872("add_aim_up"), 1, var_0);
  self _meth_82E0(scripts\anim\utility::_id_1872("add_aim_down"), 1, var_0);
  self _meth_82E0(scripts\anim\utility::_id_1872("add_aim_left"), 1, var_0);
  self _meth_82E0(scripts\anim\utility::_id_1872("add_aim_right"), 1, var_0);
  self._id_588F = scripts\anim\face::_id_B834(undefined, "aim", self._id_588F);
}

_id_8A39() {
  if(weaponburstcount(self._id_04F6) > 0) {
    return 0;
  } else if(weaponisauto(self._id_04F6) || weaponisbeam(self._id_04F6)) {
    return 0;
  }

  return 1;
}

_id_DA5D(var_0) {
  if(!scripts\anim\utility_common::_id_10D12()) {
    return;
  }
  self endon("killanimscript");
  self notify("shotgun_pump_sound_end");
  self endon("shotgun_pump_sound_end");
  thread _id_E93C(2.0);
  self waittillmatch(var_0, "rechamber");
  self playSound("ai_shotgun_pump");
  self notify("shotgun_pump_sound_end");
}

_id_E93C(var_0) {
  self endon("killanimscript");
  self endon("shotgun_pump_sound_end");
  wait(var_0);
  self notify("shotgun_pump_sound_end");
}

_id_C100(var_0) {}

_id_BE6E() {
  self endon("weapon_switch_done");
  self endon("death");
  self waittill("killanimscript");
  scripts\anim\shared::_id_B17E(self._id_034C, "right");
}

_id_0368(var_0, var_1) {}

_id_10B6(var_0, var_1) {
  if(!isDefined(anim._id_717F)) {
    anim._id_717F = [];
    anim._id_7182 = [];
  }

  var_2 = anim._id_717F.size;
  anim._id_717F[var_2] = var_0;
  anim._id_7182[var_2] = var_1;
}

_id_81A5() {}

_id_6A7C(var_0) {
  var_1 = (0, 0, 64);
  return var_1;
}

_id_F192() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    if(level.players[var_0]._id_A788 == 0) {
      level.players[var_0]._id_7184["frag"] = 0;
      level.players[var_0]._id_7184["flash_grenade"] = 0;
      level.players[var_0]._id_7184["seeker"] = 0;
    }
  }

  anim._id_F191 = 1;
}

_id_D45E(var_0) {
  self._id_0F43 = spawnStruct();

  if(isPlayer(var_0)) {
    self._id_0F43._id_89A2 = 1;
    self._id_0F43.player = var_0;
    self._id_0F43._id_F25C = self._id_020A.basename;
  } else {
    self._id_0F43._id_89A2 = 0;
    self._id_0F43._id_F25C = "AI_" + self._id_020A.basename;
  }
}

_id_FF17() {
  return self._id_0F43._id_89A2;
}

_id_D57D(var_0, var_1) {
  if(var_0._id_89A2) {
    var_2 = var_0.player;
    var_3 = var_2._id_7184[var_0._id_F25C];
    var_2._id_7184[var_0._id_F25C] = max(var_1, var_3);
  } else {
    var_3 = anim._id_7184[var_0._id_F25C];
    anim._id_7184[var_0._id_F25C] = max(var_1, var_3);
  }
}

_id_69DB() {
  var_0 = undefined;

  if(_id_FF17()) {
    var_1 = self._id_0F43.player;
    var_0 = gettime() + var_1._id_7235._id_B6C1 + randomint(var_1._id_7235._id_B6C2);
  } else
    var_0 = gettime() + 30000 + randomint(30000);

  return var_0;
}

_id_6A7D(var_0) {
  if(var_0._id_89A2) {
    return var_0.player._id_7184[var_0._id_F25C];
  } else {
    return anim._id_7184[var_0._id_F25C];
  }
}

_id_9CCE(var_0) {
  if(scripts\engine\utility::_id_B414()) {
    return 0;
  }

  if(!var_0._id_7235._id_4E95) {
    return 0;
  }

  var_1 = gettime();

  if(var_1 < var_0._id_7184["double_grenade"]) {
    return 0;
  }

  if(var_1 > var_0._id_8FD7 + 3000) {
    return 0;
  }

  if(var_1 < var_0._id_8FD7 + 500) {
    return 0;
  }

  return var_0._id_A788 < 2;
}

_id_A371() {
  return gettime() >= self._id_0DDF._id_A4A4;
}

_id_715D(var_0) {
  if(scripts\engine\utility::_id_B414()) {
    return 0;
  }

  if(self._id_CD57 == 1) {
    return 1;
  }

  if(!_id_A371()) {
    return 0;
  }

  if(gettime() >= _id_6A7D(self._id_0F43)) {
    return 1;
  }

  if(self._id_0F43._id_89A2 && self._id_0F43._id_F25C == "fraggrenade") {
    return _id_9CCE(var_0);
  }

  return 0;
}

_id_F746(var_0, var_1, var_2, var_3) {
  if(!self _meth_81C3(var_0, var_1)) {
    return 0;
  } else if(distancesquared(self.origin, var_1) < 40000) {
    return 0;
  }

  var_4 = _func_0198(var_1 + (0, 0, 1), var_1 + (0, 0, -500));

  if(var_4 == var_1 + (0, 0, -500)) {
    return 0;
  }

  var_4 = var_4 + (0, 0, 0.1);
  return _id_F747(var_0, var_4, var_2, var_3);
}

_id_F747(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {}

_id_C17B(var_0) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill("killanimscript");
  var_0._id_A788--;
}

_id_4CCF(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");

  if(!self._id_0063) {
    self _meth_8251("face direction", var_1);
  }

  scripts\anim\battlechatter_wrapper::_id_566C(self._id_020A.basename);
  self notify("stop_aiming_at_enemy");
  self _meth_831A("throwanim", var_0, %body, _id_59BD(), 0.1, 1);
  thread scripts\anim\notetracks::_id_4D64("throwanim", "killanimscript");
  var_4 = scripts\anim\utility_common::_id_6A7B();
  var_5 = "none";

  for(;;) {
    self waittill("throwanim", var_6);

    if(var_6 == "grenade_left" || var_6 == "grenade_right") {
      var_5 = _id_1D89(var_4, "TAG_INHAND");
      self._id_88A6 = 1;
    }

    if(var_6 == "grenade_throw" || var_6 == "grenade throw") {
      break;
    }

    if(var_6 == "end") {
      self._id_0F43.player._id_A788--;
      self notify("dont_reduce_giptp_on_killanimscript");
      return 0;
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");

  if(_id_FF17()) {
    thread _id_10B72(self._id_0F43.player, var_2);
  }

  self _meth_840D();

  if(!_id_FF17()) {
    _id_D57D(self._id_0F43, var_2);
  }

  if(var_3 && self._id_0F43._id_89A2) {
    var_13 = self._id_0F43.player;

    if(var_13._id_A788 > 1 || gettime() - var_13._id_8FDD < 2000) {
      var_13._id_7184["double_grenade"] = gettime() + min(5000, var_13._id_7235._id_B69A);
    }
  }

  self notify("stop grenade check");

  if(var_5 != "none") {
    self detach(var_4, var_5);
  } else {}

  self._id_88A6 = undefined;
  self._id_0207 = self._id_AA2F;
  self._id_AA2F = undefined;
  self waittillmatch("throwanim", "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
  self _meth_82D9(%exposed_modern, 1, 0.2);
  self _meth_82D9(%exposed_aiming, 1);
  self _meth_85EF(var_0, 0.2);
}

_id_10B72(var_0, var_1) {
  var_0 endon("death");
  _id_10B73(var_1);
  var_0._id_A788--;
}

_id_10B73(var_0) {
  var_1 = self._id_0F43;
  var_2 = spawnStruct();
  var_2 thread _id_10B74(5);
  var_2 endon("watchGrenadeTowardsPlayerTimeout");
  var_3 = self._id_020A.basename;
  var_4 = _id_6A7A();

  if(!isDefined(var_4)) {
    return;
  }
  _id_D57D(var_1, min(gettime() + 5000, var_0));
  var_5 = 62500;
  var_6 = 160000;

  if(var_3 == "flash_grenade") {
    var_5 = 810000;
    var_6 = 1690000;
  }

  var_7 = level.players;
  var_8 = var_4.origin;

  for(;;) {
    wait 0.1;

    if(!isDefined(var_4)) {
      break;
    }

    if(distancesquared(var_4.origin, var_8) < 400) {
      var_9 = [];

      for(var_10 = 0; var_10 < var_7.size; var_10++) {
        var_11 = var_7[var_10];
        var_12 = distancesquared(var_4.origin, var_11.origin);

        if(var_12 < var_5) {
          var_11 _id_716A(var_1, var_0);
          continue;
        }

        if(var_12 < var_6) {
          var_9[var_9.size] = var_11;
        }
      }

      var_7 = var_9;

      if(var_7.size == 0) {
        break;
      }
    }

    var_8 = var_4.origin;
  }
}

_id_716A(var_0, var_1) {
  var_2 = self;
  anim._id_F191 = undefined;

  if(gettime() - var_2._id_8FDD < 3000) {
    var_2._id_7184["double_grenade"] = gettime() + var_2._id_7235._id_B69A;
  }

  var_2._id_8FDD = gettime();
  var_3 = var_2._id_7184[var_0._id_F25C];
  var_2._id_7184[var_0._id_F25C] = max(var_1, var_3);
}

_id_6A7A() {
  self endon("killanimscript");
  self waittill("grenade_fire", var_0);
  return var_0;
}

_id_10B74(var_0) {
  wait(var_0);
  self notify("watchGrenadeTowardsPlayerTimeout");
}

_id_1D89(var_0, var_1) {
  self attach(var_0, var_1);
  thread _id_488C(var_0, var_1);
  return var_1;
}

_id_488C(var_0, var_1) {
  self endon("stop grenade check");
  self waittill("killanimscript");

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self._id_AA2F)) {
    self._id_0207 = self._id_AA2F;
    self._id_AA2F = undefined;
  }

  self detach(var_0, var_1);
}

_id_A984(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_1 = var_1 * var_0[0];
  var_2 = var_2 * var_0[1];
  var_3 = var_3 * var_0[2];
  return var_1 + var_2 + var_3;
}

_id_716C(var_0, var_1) {
  level notify("armoffset");
  level endon("armoffset");
  var_0 = self.origin + _id_A984(var_0);

  for(;;) {
    wait 0.05;
  }
}

_id_6A77() {
  var_0 = randomfloat(360);
  var_1 = randomfloatrange(30, 75);
  var_2 = sin(var_1);
  var_3 = cos(var_1);
  var_4 = cos(var_0) * var_3;
  var_5 = sin(var_0) * var_3;
  var_6 = randomfloatrange(100, 200);
  var_7 = (var_4, var_5, var_2) * var_6;
  return var_7;
}

_id_502F() {
  if(isDefined(self._id_A580)) {
    return;
  }
  var_0 = self gettagorigin("tag_accessory_right");
  var_1 = _id_6A77();
  self _meth_821D(var_0, var_1, 3);
}

_id_DB6F() {
  if(level._id_11DA[self.team] > 0 && level._id_11DA[self.team] < level._id_11DB) {
    if(gettime() - level._id_8F88[self.team] > 4000) {
      return 0;
    }

    var_0 = level._id_8F85[self.team];

    if(var_0 == self) {
      return 0;
    }

    var_1 = isDefined(var_0) && distancesquared(self.origin, var_0.origin) < 65536;

    if((var_1 || distancesquared(self.origin, level._id_8F87[self.team]) < 65536) && (!isDefined(self._id_0192) || distancesquared(self._id_0192.origin, level._id_8F86[self.team]) < 262144)) {
      return 1;
    }
  }

  return 0;
}

_id_34DD() {
  if(!isDefined(level._id_8F88[self.team])) {
    return 0;
  }

  if(_id_DB6F()) {
    return 1;
  }

  if(gettime() - level._id_8F88[self.team] < level._id_11DC) {
    return 0;
  }

  if(!_func_011D(self._id_0192)) {
    return 0;
  }

  if(level._id_11DA[self.team]) {
    level._id_11DA[self.team] = 0;
  }

  var_0 = isDefined(self._id_11C5) && self._id_11C5;

  if(!var_0 && _func_0072(self.team) < _func_0072(self._id_0192.team)) {
    return 0;
  }

  return 1;
}

_id_F758(var_0) {
  if(!isDefined(self._id_0192)) {
    return 0;
  }

  if(self._id_01C2) {
    return 0;
  }

  if(self._id_010D == "ambush" || self._id_010D == "ambush_nodes_only") {
    return 0;
  }

  if(!self _meth_81C6(self._id_0192.origin)) {
    return 0;
  }

  if(scripts\anim\utility_common::_id_8917()) {
    return 0;
  }

  if(!_id_34DD()) {
    return 0;
  }

  if(isDefined(self._id_04CA) && self._id_04CA) {
    return 0;
  }

  self _meth_80EF(var_0);

  if(self _meth_8289()) {
    self._id_0260 = 0;
    self._id_025E = 0;
    self._id_0DDF._id_9956 = 1;

    if(level._id_11DA[self.team] == 0) {
      level._id_8F88[self.team] = gettime();
      level._id_8F85[self.team] = self;
    }

    level._id_8F87[self.team] = self.origin;
    level._id_8F86[self.team] = self._id_0192.origin;
    level._id_11DA[self.team]++;
    return 1;
  }

  return 0;
}

_id_6C2D(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = var_0 - self _meth_8176();
  var_1 = vectornormalize(var_1);
  var_2 = vectortoangles(var_1)[0];
  return _func_000B(var_2);
}

_id_10BF2() {
  self._id_89F8 = 0;
  self._id_9037 = -1;

  for(;;) {
    self waittill("reload_start");
    self._id_89F8 = 1;
    self._id_9037 = gettime();
    scripts\anim\battlechatter_wrapper::_id_5677();
    _id_10969();
    self._id_89F8 = 0;
  }
}

_id_10969() {
  thread _id_F20B(4, "reloadtimeout");
  self endon("reloadtimeout");
  self endon("weapon_taken");

  for(;;) {
    self waittill("reload");
    var_0 = self getcurrentweapon();

    if(isnullweapon(var_0)) {
      break;
    }

    if(self getcurrentweaponclipammo() >= weaponclipsize(var_0)) {
      break;
    }
  }

  self notify("reloadtimeout");
}

_id_F20B(var_0, var_1) {
  self endon(var_1);
  wait(var_0);
  self notify(var_1);
}

_id_3513() {
  var_0 = self._id_0192.origin - self.origin;
  var_1 = _func_0135((var_0[0], var_0[1], 0));

  if(self._id_020A.basename == "flash_grenade") {
    return var_1 < 589824;
  }

  return var_1 >= 40000 && var_1 <= 1562500;
}

_id_A10F() {
  self endon("death");

  if(!isDefined(level._id_A442)) {
    self endon("stop_monitoring_flash");
  }

  for(;;) {
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    self waittill("flashbang", var_1, var_0, var_2, var_3, var_4);

    if(isDefined(self._id_5C99) && self._id_5C99) {
      continue;
    }
    if(isDefined(self._id_CD8B) && self._id_CD8B != 0) {
      continue;
    }
    if(isDefined(self.team) && isDefined(var_4) && self.team == var_4) {
      var_0 = 3 * (var_0 - 0.75);

      if(var_0 < 0) {
        continue;
      }
      if(isDefined(self._id_EF73)) {
        continue;
      }
    }

    var_5 = 0.2;

    if(var_0 > 1 - var_5) {
      var_0 = 1.0;
    } else {
      var_0 = var_0 / (1 - var_5);
    }

    var_6 = 4.5 * var_0;

    if(var_6 < 0.25) {
      continue;
    }
    self._id_5CA6 = var_4;
    _id_5C9E(var_6);
    self notify("doFlashBanged", var_1, var_3);
  }
}

_id_5C9E(var_0) {
  if(isDefined(self._id_5C99) && self._id_5C99) {
    return;
  }
  if(isDefined(self._id_0426)) {
    return;
  }
  if(self _meth_81C7() || _id_06BD::_id_23CE()) {
    return;
  }
  if(!self._id_0043 || !self._id_0044) {
    return;
  }
  var_1 = gettime() + var_0 * 1000.0;

  if(isDefined(self._id_5CA2)) {
    self._id_5CA2 = max(self._id_5CA2, var_1);
  } else {
    self._id_5CA2 = var_1;

    if(isDefined(self._id_1C30)) {
      _id_0009::_id_1CA1("pain_flashed_transition");
    }
  }

  self notify("flashed");
}

_id_59BD() {
  return 1.5;
}

_id_BFF9() {
  return randomfloatrange(1, 1.2);
}

_id_B5C8() {
  var_0 = self getEye();

  foreach(var_2 in level.players) {
    if(!self _meth_8067(var_2)) {
      continue;
    }
    var_3 = var_2 getEye();
    var_4 = vectortoangles(var_0 - var_3);
    var_5 = anglesToForward(var_4);
    var_6 = var_2 getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = vectordot(var_5, var_7);

    if(var_8 < 0.805) {
      continue;
    }
    if(scripts\engine\utility::cointoss() && var_8 >= 0.996) {
      continue;
    }
    return 1;
  }

  return 0;
}

_id_3AA0(var_0, var_1) {
  self._id_588F = scripts\anim\face::_id_B834(var_0, var_1, self._id_588F);
}

_id_3A8F() {
  self._id_588F = undefined;
  self _meth_85EF(%head, 0.2);
}