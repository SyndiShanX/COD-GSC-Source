/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2282.gsc
*************************************************/

_id_82BE(var_0) {
  if(isDefined(self._id_03E9) && self._id_03E9 _id_E2CC()) {
    self._id_54D1 = 1;
  }

  if(isDefined(level._id_7D75)) {
    if(self[[level._id_7D75]]()) {
      self._id_54D1 = 1;
    }
  }

  _id_D843();
  self.zm_ai_category = "normal";
  self.uses_super_sprint = 1;
  self._id_D603 = _id_0B05::_id_D602;
  self._id_D6A4 = _id_0B05::_id_D6A3;
  _id_0B05::_id_D602("walk");
  _id_0B05::_id_D6A3(1.0);
  self._id_6A2E = ::_id_6A2D;
  self._id_E3D8 = "zombie";
  self._id_9D94 = self._id_9D95;
  self._id_9D97 = _func_0219(self._id_9D94);
  self._id_15C4 = 1;
  self._id_0047 = 0;
  self._id_AD49 = 1;
  self.maxhealth = self.health;
  self._id_7320 = 1;

  if(_id_0909::_id_1106E()) {
    self._id_45CB = 55;
    self._id_04A9 = self._id_45CB;
    self._id_04BE = -60;
    self._id_0185 = 60;
    self._id_7320 = 0;
    self._id_4DA9 = 1;
  }

  thread _id_09A5::_id_1101A();
  self _meth_86C6();

  if(!_func_0247("zombie")) {
    _func_004D("zombie");
  }

  self _meth_8390("zombie");
  _id_D874();

  if(self _meth_86EE()) {
    thread _id_8283();
  }

  self.set_turned_func = ::set_turned;
  self.set_frozen_func = ::set_frozen;
  self.try_do_scripted_anim = ::zombietrydoscriptedanim;
  self.try_do_intro_loop_scripted_anim = ::zombieplayintroloopscriptedanim;
  return anim._id_EACB;
}

_id_8283() {
  self setscriptablepartstate("notetrack_handler", "active", 0);
  _id_110A5("base_loop");
}

_id_D874() {
  if(!isDefined(level._id_D8F5)) {
    level._id_D8F5 = 1;
  } else {
    return;
  }

  level._id_10CB3 = 1;
  level._id_A23E = [];
  level._id_A255 = [];
  level._id_A5AD = [];
  level._id_F4EF = [];
  level._id_792A = [];
  level._id_4B42 = [];
  level._id_11EF["actor_enemy_base_zombie_cp"]["on_damaged"] = ::onzombiedamage;
  level._id_11EF["actor_enemy_base_zombie_cp"]["on_damaged_finished"] = ::_id_ABDF;
  level._id_11EF["actor_enemy_base_zombie_cp"]["on_killed"] = ::_id_ABE0;
  level._id_11EF["actor_enemy_base_zombie_skorpion_cp"]["on_damaged"] = ::onzombiedamage;
  level._id_11EF["actor_enemy_base_zombie_skorpion_cp"]["on_damaged_finished"] = ::_id_ABDF;
  level._id_11EF["actor_enemy_base_zombie_skorpion_cp"]["on_killed"] = ::_id_ABE0;
  level._id_11EF["actor_enemy_base_zombie_sumpf_cp"]["on_damaged"] = ::onzombiedamage;
  level._id_11EF["actor_enemy_base_zombie_sumpf_cp"]["on_damaged_finished"] = ::_id_ABDF;
  level._id_11EF["actor_enemy_base_zombie_sumpf_cp"]["on_killed"] = ::_id_ABE0;
  level._id_11EF["actor_enemy_zombie_soldier_cp"]["on_damaged"] = ::onzombiedamage;
  level._id_11EF["actor_enemy_zombie_soldier_cp"]["on_damaged_finished"] = ::_id_ABDF;
  level._id_11EF["actor_enemy_zombie_soldier_cp"]["on_killed"] = ::_id_ABE0;
}

_id_D843() {
  thread _id_FCE6();
  self.class = undefined;
  self._id_A25F = undefined;
  self._id_1FAF = undefined;
  self.guid = undefined;
  self.name = undefined;
  self._id_CB42 = undefined;
  self.perks = undefined;
  self.weaponlist = undefined;
  self._id_A8EC = undefined;
  self.sessionteam = undefined;
  self.sessionstate = undefined;
  scripts\common\input_allow::_id_38B0("weapon");
  scripts\common\input_allow::_id_38B0("weaponSwitch");
  scripts\common\input_allow::_id_38B0("offhandWeaps");
  scripts\common\input_allow::_id_38B0("usability");
  self._id_A546 = undefined;
  self.ignoreme = 0;
  self._id_0229 = 0;
  self._id_F080 = undefined;
  self._id_3AD5 = undefined;
  self._id_417A = undefined;
  self._id_4C08 = undefined;
  self._id_30B9 = 0;
  self._id_1DC9 = undefined;
  self._id_54D1 = 0;
  self._id_9B33 = undefined;
  self._id_F4B9 = undefined;
  self._id_75BE = 0;
  self._id_1DCF = undefined;
  self._id_13E7 = "idle";
  self._id_91A3._id_02D6 = "walk";
  self._id_03BD = 100;
  self._id_0359 = 15;
  self.height = 40;
  self._id_1DF5 = 26 + self._id_0359;
  self._id_9DA0 = "normal";
  self._id_9DA1 = 50;
  self._id_42F7 = 2250000;
  self._id_022A = 1;
  self.guid = self getentitynumber();
  self._id_A254 = 1.0;
  self._id_A5AC = 1.0;
  self._id_F4EE = 1.0;
  self._id_6289 = 1.0;
  self._id_24F3 = 0;
  self._id_24F8 = 1;
  self._id_F220 = 0;
  self._id_003F = 1;
  self._id_9D79 = 40;
  self._id_9D95 = 70;
  self._id_9D98 = 64;
  self._id_9D96 = _func_0219(self._id_9D95);
  self._id_45B4 = self._id_0359 + 1;
  self._id_4982 = 0;
  self._id_42ED = 0;
  self._id_8873 = undefined;
  self._id_5D22 = undefined;
  self._id_9910 = 1;
  self._id_5FF5 = 0;
  self._id_01BD = undefined;
  self._id_CA0B = undefined;
  self._id_8F13 = [];
  self._id_7596 = 0;
  self._id_7598 = undefined;
  self._id_8584 = undefined;
  self._id_0221 = 200;
  self._id_43F2 = undefined;
  self._id_E42D = undefined;
  self._id_6EAC = undefined;
  self._id_B2F1 = undefined;
  self._id_2467 = 1;
  self._id_103E8 = undefined;
  self._id_43AB = undefined;
  self._id_9D82 = 0.85;
  self._id_C01D = 3;
  self._id_9013 = gettime();
  self._id_9035 = gettime();
  self._id_A4CC = gettime();
  self._id_7D48 = undefined;
  self._id_AA6C = ::_id_AA6C;
  self._id_8FF1 = [];
  self.playereffects = [];
  self._id_1DFC = 54;
  self._id_1DFD = -64;
  self._id_9D84 = 0.5;
  _id_0AF3::_id_D7A5();
  _id_0B05::_id_D5F7(self._id_9D95);

  if(getdvarint("#x3b5686c86eb3eb3e0", 0) == 1) {
    self._id_917B = 1;
  }

  var_0 = 15;

  if(isDefined(level._id_1FA1)) {
    var_0 = level._id_1FA1;
  }

  self _meth_8512(var_0);
  thread update_avoidance_blocking();
  thread _id_A146();
  thread _id_7441();
}

update_avoidance_blocking() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 = !self _meth_8566();

    if(!scripts\engine\utility::is_equal(self._id_0174, var_0)) {
      self._id_0174 = var_0;
    }

    wait 1;
  }
}

_id_7441() {
  self endon("death");
  level waittill("game_ended");
  self _meth_8474();
  self _meth_85CA(self._id_1CB8, "idle");
}

_id_8AAE() {
  return isDefined(self._id_8AAE) && self._id_8AAE;
}

_id_A146() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    if(length(self getvelocity()) == 0 && self._id_13E7 == "move") {
      var_0 = var_0 + 0.05;
    } else {
      var_0 = 0;
    }

    if(var_0 > 2.0) {
      var_1 = self _meth_8161();

      if(isDefined(var_1)) {
        var_2 = distancesquared(self.origin, var_1.origin);

        if(var_2 < _func_0219(15)) {
          self setorigin(var_1.origin, 0);
        }
      }
    }

    wait 0.05;
  }
}

_id_5B1C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(!isalive(self)) {
    return;
  }
  if(isPlayer(self)) {
    self _meth_80F2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  }

  if(!isai(self)) {
    self playrumbleonentity("damage_heavy");
  }
}

_id_ABDF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = self;

  if(isDefined(var_1) && var_1 scripts\cp_mp\vehicles\vehicle::_id_8AF5() && isDefined(var_1.owner)) {
    var_1 = var_1.owner;
  }

  if(var_5.basename == "molotov_mp") {
    var_2 = int(floor(float(var_2 / 2.5)));
  } else if(istrue(var_13._id_7572) && (var_8 == "helmet" || var_8 == "head" || isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "script_vehicle")) {
    var_2 = int(floor(var_2 * 1));
    var_13 _id_780D();
  } else if(_func_010F(var_4))
    var_2 = int(floor(var_2 * 1.0));

  var_14 = var_13.health;
  var_15 = should_try_dismemberment(var_13, var_4, var_5);

  if(var_15 && istrue(var_13._id_4982)) {
    var_15 = 0;
  }

  if(var_15) {
    _id_0AF3::_id_F707(var_1, var_8, var_5, var_2, var_4);

    if(istrue(self._id_7572) && !_id_0AF3::has_head()) {
      var_13 _id_780D();
    }
  }

  if(isDefined(var_1) && (isPlayer(var_1) || istrue(var_1._id_86F2))) {
    _id_06FC::_id_108F(var_13, var_1, var_0, var_5, var_2, var_6, var_7, var_8, var_9, var_4);

    if(!isDefined(var_13._id_01BD)) {
      var_17 = isDefined(var_13._id_012F) && var_13._id_012F == var_1;
      var_18 = isDefined(var_13._id_012F) && !isPlayer(var_13._id_012F);

      if(var_17 || var_18) {
        if(distancesquared(var_13.origin, var_1.origin) <= var_13._id_42F7) {
          var_13 _id_0B05::_id_D55D(var_1);
          var_13 thread _id_C5B6(0.2);
        }
      }
    }
  }

  if(!var_13 _id_3171() && var_13.health - var_2 <= 0) {
    var_13 thread _id_11078(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_11, var_12);
    var_2 = int(max(0, var_13.health - 1));
  }

  if(!isDefined(level.no_knockdown_weapon_names) || !scripts\engine\utility::array_contains(level.no_knockdown_weapon_names, var_5.basename)) {
    scripts\aitypes\zombie_common\push::damage_knockdown(var_2, var_4, var_7);
  }

  _id_AA9D(var_2, var_4, var_5);
  level notify("zombie_damaged", var_13, var_1);
  var_13 _id_0014::_id_11EC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_11, var_12);

  if(isDefined(var_1) && isPlayer(var_1)) {
    _id_072E::display_damage_number(var_1, var_13, var_8, var_4, var_5, var_2, var_6);
  }
}

_id_ABE0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_1) && var_1 scripts\cp_mp\vehicles\vehicle::_id_8AF5() && isDefined(var_1.owner)) {
    var_1 = var_1.owner;
  }

  var_9 = spawnStruct();
  var_9._id_511D = var_0;
  var_9._id_50FF = var_1;
  var_9._id_7C8D = var_2;
  var_9._id_DE2B = var_3;
  var_9._id_04F6 = var_4;
  var_9._id_FFD4 = var_5;
  var_9._id_D9E0 = var_6;
  var_9._id_0354 = var_7;
  var_9._id_43D5 = var_8;

  if(!istrue(self._id_DD08)) {
    _id_110B1(var_1);

    switch (self._id_110B0) {
      default:
        var_10 = 30;
        var_11 = "br_zai_killed";
        break;
    }
  }

  if(isDefined(self._id_CFF6)) {
    self._id_CFF6._id_37F2 = undefined;
  }

  _id_110A5("glow_off");

  if(getdvarint("#x347248745761dd621", 1)) {
    var_12 = 0;
    var_13 = gettime() - 0.5;

    foreach(var_15 in level.agent_corpses) {
      if(!isDefined(var_15)) {
        continue;
      }
      if(var_15._id_0094 >= var_13) {
        var_12++;
      }
    }

    if(var_12 >= 8) {
      self._id_A546 = 1;
      self._id_5FF5 = 1;
    }
  }

  _id_0014::_id_0F7A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  _id_E3AC(self._id_0F4F, var_3, var_4);
}

_id_110B1(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_110B0)) {
    var_1._id_110B0 = "base";
  }

  switch (var_1._id_110B0) {
    default:
      playFX(level._effect["zmb_ai_base_death"], var_1 gettagorigin("j_spineupper"));
      break;
  }
}

_id_E3AC(var_0, var_1, var_2) {
  if(!isDefined(self._id_25CA) && !istrue(self._id_5FF5)) {
    return;
  }
  var_3 = self._id_C0F7;

  if(!isDefined(var_3) && !istrue(self._id_5FF5)) {
    return;
  }
  if(self._id_5FF5 || _id_0AF3::_id_3D96(var_3) >= 3) {
    thread _id_E28C(var_0);
    return;
  }
}

_id_E28C(var_0) {
  var_1 = 35;
  var_2 = scripts\cp_mp\utility\player_utility::_id_69E4();

  if(var_2.size < var_1) {
    var_3 = spawn("script_model", self gettagorigin("j_mainroot"));
    var_3.angles = self.angles;
    var_3 setModel("zombie_death_fx");
    var_3 setscriptablepartstate("effects", "gib", 0);

    foreach(var_5 in var_2) {
      var_3 hidefromplayer(var_5);
    }

    wait 0.5;
    var_3 delete();
  }
}

_id_AA6C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = _id_07F7::_id_DA8D(self);

  if(isDefined(self._id_A546)) {
    var_10 = 0;
  }

  var_11 = isDefined(self._id_BF53);

  if(!var_10 || !istrue(self._id_86ED)) {
    self _meth_85DD(self._id_1CB8);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onAgentKilled") && (isPlayer(var_1) || isagent(var_1))) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onAgentKilled")]](var_0, var_1, self, var_2, 0, var_3, var_4, var_5, var_6, var_7, var_8, 1);
  }

  if(isDefined(self._id_A546)) {
    if(isDefined(level._id_5D9E) && [[level._id_5D9E]](var_4)) {
      var_12 = self _meth_808C(var_8, 1);
      var_12 hide(1);
    }

    return;
  }

  var_13 = self;

  if(var_8 == 0) {
    var_8 = 500;
  }

  if(isDefined(self._id_74D9) && isDefined(level._id_DA9B)) {
    if([[level._id_DA9B]](var_1, self.origin)) {
      self setscriptablepartstate("backpack", "hide", 1);
    }
  }

  if(isDefined(self._id_BF52)) {
    self._id_25CA = self _meth_808C(var_8, var_10);
    self._id_25CA._id_BF52 = self._id_BF52;
    self._id_25CA._id_BF53 = self._id_BF53;
  } else
    self._id_25CA = self _meth_808C(var_8, var_10);

  if(isDefined(self._id_8569) || isDefined(var_1) && isDefined(var_4) && var_4.basename == "incendiary_ammo_mp") {
    self._id_25CA setscriptablepartstate("burning", "active", 1);
  } else if(isDefined(self._id_5120)) {
    self._id_25CA setscriptablepartstate("electrocuted", "active");
  }

  _id_0AF3::_id_3D54(self._id_25CA);

  if(istrue(self.is_bleeding)) {
    self._id_25CA setscriptablepartstate("bleeding", "active", 1);
  }

  if(isDefined(self._id_B2F1)) {
    self._id_25CA thread _id_4BE5(self._id_B2F1, istrue(self._id_86ED));
  }

  if(istrue(var_10)) {
    cp_do_immediate_ragdoll(self._id_25CA);
  } else if(istrue(var_11)) {
    thread _id_103A1(self._id_25CA, var_6, var_5, var_4, var_0, var_3);
  } else if(!istrue(self._id_43AB)) {
    thread _id_07F7::_id_46E0(self._id_25CA, var_6, var_5, var_4, var_0, var_3);
  }

  if(isDefined(self._id_25CA)) {
    var_14 = getdvarfloat("#x3d02c95c889fb027a", 0.0);

    if(var_14 > 0.0) {
      self._id_25CA scripts\engine\utility::_id_46A8(var_14, ::delete);
    }
  }

  self._id_43AB = undefined;
}

cp_do_immediate_ragdoll(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0._id_BF52) && isDefined(var_0._id_BF53)) {
    var_0 _meth_83E6(var_0._id_BF52, var_0._id_BF53);
    return;
  }

  var_1 = 10;
  var_2 = scripts\common\utility::_id_69C4(self.damagemod);

  if(isDefined(self.attacker) && isPlayer(self.attacker) && var_2 == "melee") {
    var_1 = 5;
  }

  var_3 = self._id_014E;

  if(var_2 == "bullet" || isDefined(self.damagemod) && self.damagemod == "MOD_FIRE") {
    var_3 = min(var_3, 300);
  }

  var_4 = var_1 * var_3;
  var_5 = max(0.3, self._id_0147[2]);
  var_6 = (self._id_0147[0], self._id_0147[1], var_5);

  if(isDefined(self._id_BF49)) {
    var_6 = var_6 * self._id_BF49;
  } else {
    var_6 = var_6 * var_4;
  }

  if(self._id_01D0) {
    var_6 = var_6 + self._id_0344 * 20 * 10;
  }

  if(isDefined(self._id_BF50)) {
    var_6 = var_6 + self._id_BF50 * 10;
  }

  var_7 = self._id_0148;

  if(isDefined(self._id_BF47) && var_7 == "none") {
    var_7 = self._id_BF47;
  }

  var_6 = (var_6[0], var_6[1], 0);
  var_0 _meth_83E6(var_7, var_6);
}

_id_103A1(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level._id_A5BB) && level._id_A5BB.size) {
    foreach(var_7 in level._id_A5BB) {
      if(distancesquared(var_0.origin, var_7.origin) < 65536) {
        return;
      }
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 _meth_81DF()) {
    return;
  }
  if(isDefined(var_0)) {
    if(isDefined(var_0._id_BF52) && isDefined(var_0._id_BF53)) {
      var_0 _meth_83E6(var_0._id_BF52, var_0._id_BF53);
    } else {
      var_0 startragdoll();
    }
  }
}

_id_4BE5(var_0, var_1) {
  if(!istrue(var_1)) {
    wait(var_0);
  }

  if(isDefined(self)) {
    self setscriptablepartstate("death_fx", "active", 1);
    wait 0.1;
    self hide(1);
  }
}

_id_110CE() {
  return isDefined(self._id_F173);
}

_id_89AC() {
  if(isDefined(self._id_82D3) && self._id_82D3) {
    return 1;
  }

  if(isDefined(self._id_82D2) && self._id_82D2) {
    return 1;
  }

  return 0;
}

_id_FCE6() {
  self notify("updatePainSensor");
  self endon("updatePainSensor");
  self endon("death");
  self._id_ADEF = spawnStruct();
  self._id_ADEF._id_9024 = gettime();
  self._id_ADEF.damage = 0.0;
  var_0 = 0.05;
  var_1 = 5 * var_0;

  for(;;) {
    wait(var_0);

    if(gettime() > self._id_ADEF._id_9024 + 2000) {
      self._id_ADEF.damage = self._id_ADEF.damage - var_1;
    }

    self._id_ADEF.damage = max(self._id_ADEF.damage, 0);

    if(_id_89AC()) {
      self._id_ADEF.damage = 0;
    }
  }
}

_id_3171() {
  if(isDefined(self._id_E393) && gettime() - self._id_E393 <= 0.05) {
    return 0;
  }

  return 1;
}

_id_11078(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self notify("zombiePendingDeath");
  self endon("zombiePendingDeath");

  while(isDefined(self) && isalive(self)) {
    self._id_AF84 = 1;

    if(!_id_3171()) {
      wait 0.05;
      continue;
    }

    self._id_AF84 = 0;
    _id_ABDF(var_0, var_1, self.health + 1, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }
}

_id_AA9D(var_0, var_1, var_2) {
  if(isDefined(self._id_AA9E)) {
    [[self._id_AA9E]](var_0, var_1, var_2);
  }

  self._id_ADEF._id_9024 = gettime();
  self._id_ADEF.damage = self._id_ADEF.damage + var_0;
}

_id_8977(var_0) {
  return isDefined(self._id_AF84) && self._id_AF84;
}

_id_E2CC() {
  if(isDefined(self._id_CE18) && (self._id_CE18 == "no_boards" || self._id_CE18 == "ground_spawn_no_boards")) {
    return 1;
  }

  return 0;
}

_id_DDE6(var_0) {
  var_1 = gettime();

  if(isDefined(self._id_DDE7)) {
    if(var_1 >= self._id_DDE7) {
      self._id_DDE7 = undefined;
      return anim._id_58E3;
    }

    return anim._id_CA5F;
  }

  if(!isDefined(self._id_012F)) {
    self._id_DDE7 = var_1 + 2000;
    return anim._id_CA5F;
  }

  var_2 = distance2d(self.origin, self._id_012F.origin);

  if(var_2 < 1200) {
    return anim._id_58E3;
  }

  if(var_2 > 2000) {
    self._id_DDE7 = var_1 + 500;
    return anim._id_CA5F;
  }

  var_2 = var_2 - 1200;
  var_3 = var_2 / 800;
  self._id_DDE7 = var_1 + 200 + int(var_3 * 300);
  return anim._id_CA5F;
}

_id_DB4F(var_0) {
  if(isDefined(level._id_5DD3)) {
    if(!self[[level._id_5DD3]]()) {
      return anim._id_58E3;
    } else if(self._id_75BE) {
      return anim._id_58E3;
    }
  }

  return anim._id_EACB;
}

_id_4C6E() {
  self endon("AbortEnterPlayspace");
  self._id_24CC = 1;
  self[[level._id_5DD2]]();
  self._id_24CC = 0;
}

_id_54DC(var_0) {
  self._id_25BE = 1;
}

_id_54DD(var_0) {
  self notify("AbortEnterPlayspace");
}

_id_54DB(var_0) {
  if(istrue(self._id_54D1)) {
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

_id_EF0D(var_0) {
  if(_func_0202(self getEye(), var_0 getEye(), 0, self, var_0)) {
    return 1;
  }

  return 0;
}

_id_15B1() {
  var_0 = getdvarint("#x3ef25f5f3a7324f4c", 1);

  if(var_0 == 0) {
    return 0;
  }

  return self._id_7320;
}

_id_DB3C() {
  if(!_id_15B1()) {
    return 0;
  }

  if(isDefined(self._id_C01D)) {
    var_0 = gettime() - self._id_9035;

    if(var_0 < self._id_C01D * 1000) {
      return 0;
    }
  }

  if(gettime() >= self._id_A4CC) {
    self._id_A4CC = gettime() + 1000;
    var_1 = 0;

    if(isDefined(level.aigutprojectiles)) {
      var_1 = level.aigutprojectiles.size;
    }

    var_2 = _func_0070(self.team);

    foreach(var_4 in var_2) {
      var_5 = istrue(var_4._id_0B67._id_02A8) && istrue(var_4._id_0B67._id_9D90);

      if(var_5 || istrue(var_4._id_0B67.isthrowingguts)) {
        var_1++;
      }
    }

    if(var_1 >= 3) {
      return 0;
    }

    var_7 = getdvarfloat("#x396a9b3ac3d1e23e0", 0.0);

    if(istrue(self._id_5431)) {
      var_8 = gettime() - scripts\cp\utility::_id_459B(self.enemyunreachableformeleeattime, 0);

      if(scripts\cp\utility::_id_A2B8(var_8) >= 3) {
        var_7 = 1.0;
      }
    } else {
      var_9 = _func_0219(getdvarfloat("#x3c73633fbff5fc8c9", 300));

      if(distancesquared(self.origin, self._id_012F.origin) < var_9) {
        var_7 = 0.0;
      }
    }

    var_10 = randomfloat(1);

    if(var_10 < var_7) {
      return _id_EF0D(self._id_012F);
    }
  }

  return 0;
}

zombiegetmeleedistsq() {
  if(self._id_91A3._id_02D6 == "walk") {
    return 10000;
  } else if(self._id_91A3._id_02D6 == "run") {
    return 14400;
  }

  return 8100;
}

zombieshouldmelee() {
  if(!isDefined(self._id_012F)) {
    return 0;
  }

  if(gettime() < scripts\cp\utility::_id_459B(self._id_012F.meleeshieldexpiretime, 0)) {
    return 0;
  }

  var_0 = self._id_012F.origin;

  if(!_id_0B05::_id_8B17(var_0)) {
    return 0;
  }

  if(!_id_0B05::_id_10E7E()) {
    return 0;
  }

  var_1 = vectortoangles(var_0 - self.origin);
  var_2 = _func_000B(self.angles[1] - var_1[1]);

  if(abs(var_2) > 60) {
    return 0;
  }

  var_3 = distancesquared(self.origin, var_0);

  if(var_3 < 1600) {
    return 1;
  }

  if(!self _meth_8067(self._id_012F)) {
    return 0;
  }

  return 1;
}

_id_352C(var_0) {
  if(self._id_0229) {
    clearmeleerequest();
    return anim._id_58E3;
  }

  clearmeleerequest();

  if(!isDefined(self._id_012F)) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_012F.ignoreme) && self._id_012F.ignoreme == 1) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_012F._id_8D86)) {
    return anim._id_58E3;
  }

  if(self._id_13E7 == "melee" || _id_0017::_id_8A63()) {
    return anim._id_58E3;
  }

  if(!_id_0B05::_id_74EC()) {
    return anim._id_58E3;
  }

  if(_id_0909::_id_1106E()) {
    return anim._id_58E3;
  }

  if(_id_DB3C()) {
    _id_06BD::_id_23F0(self._id_012F);
    self._id_0B67._id_9D90 = 1;
    return anim._id_58E3;
  }

  if(zombieshouldmelee()) {
    if(isPlayer(self._id_012F)) {
      self._id_012F.meleeshieldexpiretime = gettime() + scripts\cp\utility::_id_CFF0(0.2);
    }

    _id_06BD::_id_23F0(self._id_012F);
  }

  return anim._id_58E3;
}

clearmeleerequest() {
  _id_06BD::_id_23AF();
  self._id_0B67._id_9D90 = 0;
}

_id_341C(var_0) {
  _id_06BD::_id_2408(1);

  if(self._id_0229) {
    self._id_012F = undefined;
    return anim._id_58E3;
  }

  if(isDefined(self._id_75BE) && self._id_75BE) {
    self._id_A6C1 = 0;
  }

  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_0192._id_85CC) || isDefined(self._id_0192._id_864C)) {
    self._id_012F = undefined;
    return anim._id_58E3;
  }

  if(isDefined(self._id_0192._id_8D86)) {
    self._id_012F = undefined;
    return anim._id_58E3;
  }

  var_1 = undefined;

  if(isDefined(self._id_1DCF)) {
    var_1 = self._id_1DCF;
  } else if(isDefined(self._id_0192) && !_id_0B05::_id_DB71(self._id_0192)) {
    if(isDefined(self._id_0192 scripts\cp_mp\utility\player_utility::getvehicle())) {
      var_1 = self._id_0192 scripts\cp_mp\utility\player_utility::getvehicle();
    } else {
      var_1 = self._id_0192;
    }
  }

  if(!isDefined(var_1) || istrue(var_1._id_86F2)) {
    if(isDefined(self._id_012F)) {
      self._id_24F8 = 1;
    }

    self._id_012F = undefined;
    return anim._id_58E3;
  }

  self._id_012F = var_1;

  if(_id_0909::_id_1106E()) {
    if(_id_EF0D(var_1)) {
      self _meth_84BC(0, self.origin);
      self._id_24F8 = 0;
      return anim._id_58E3;
    }
  }

  var_3 = self._id_1DF5 + self._id_0359 * 2;
  var_4 = var_3 * var_3;
  var_5 = self._id_1DF5;
  var_6 = var_5 * var_5;
  var_7 = _id_0B05::_id_6B52(var_1);
  var_8 = var_7._id_5428;
  var_9 = distancesquared(var_7.origin, self.origin);
  var_10 = distancesquared(var_8, self.origin);
  var_11 = self._id_24F8;

  if(var_10 < _func_0219(self._id_0359) && distancesquared(var_8, var_7.origin) > _func_0219(self._id_0359)) {
    var_11 = 1;
    self notify("attack_anim", "end");
  }

  if(!var_11 && var_10 > var_4 && var_9 > var_6) {
    var_11 = 1;
  }

  if(var_7._id_FF2C) {
    if(!var_11 && var_10 <= var_4 && var_9 > _func_0219(self._id_45B4)) {
      var_11 = 1;
    }

    self._id_0201 = self._id_45B4;
  } else if(!_id_0B05::_id_75C1(var_1, self._id_9DA0)) {
    self._id_0201 = self._id_45B4;
    var_11 = 1;
  } else {
    self._id_0201 = var_3;

    if(var_10 <= var_4) {
      var_7.origin = self.origin;
      var_11 = 1;
    }
  }

  if(var_11) {
    var_2 = _id_3550(var_1, var_7.origin, 10000);

    if(isDefined(var_2)) {
      self _meth_84BC(0, var_2);
      self._id_24F8 = 0;
    }

    if(_id_0B05::_id_10E7E()) {
      self _meth_8251("face enemy");
    }
  }

  return anim._id_EACB;
}

_id_3550(var_0, var_1, var_2) {
  var_3 = self.enemyunreachableformeleeattime;
  var_4 = self _meth_86F8(var_1);

  if(var_4 == (0, 0, 0) || distancesquared(self.origin, var_4) < 16) {
    var_5 = _func_02AB(var_1, self);

    if(var_5 == (0, 0, 0)) {} else
      var_4 = var_5;
  }

  if(isPlayer(var_0) && !var_0 isonground()) {
    return var_4;
  }

  self._id_5431 = undefined;
  self.enemyunreachableformeleeattime = undefined;

  if(isDefined(level.check_on_moving_platform_func)) {
    if(istrue(var_0[[level.check_on_moving_platform_func]]())) {
      return var_4;
    }
  }

  var_6 = distancesquared(var_4, var_1);

  if(_id_15B1()) {
    if(var_6 > 625) {
      var_7 = _id_06E0::_id_5056(var_4, 128);

      if(isDefined(var_7) && var_7[2] > var_4[2] + 40) {
        var_8 = scripts\cp\utility::_id_459B(self.height, 45);
        var_7 = _id_06E0::_id_5056(var_4, var_8);
      }

      if(!isDefined(var_7)) {
        var_7 = getgroundposition(var_4, 1, 128, 0);

        if(!isDefined(var_7)) {
          var_7 = var_4 - (0, 0, 10);
        }
      }

      if(istrue(self._id_9010)) {
        self._id_5431 = 1;
      } else if(!_id_0B05::_id_89BE(var_7, var_0.origin)) {
        self._id_5431 = 1;
      } else if(!_func_02AE(self._id_012F.origin, self)) {
        if(!_id_0B05::_id_89C0(var_7, var_0.origin)) {
          self._id_5431 = 1;
        }
      } else if(!_id_0B05::_id_89BF(var_7, var_0.origin))
        self._id_5431 = 1;

      if(istrue(self._id_5431)) {
        self.enemyunreachableformeleeattime = scripts\cp\utility::_id_459B(var_3, gettime());
        var_9 = distancesquared(self.origin, var_1);
        var_10 = getdvarfloat("#x397b449ac4df601cd", 600);
        var_11 = _func_0219(var_10);

        if(var_9 < var_11 && _id_EF0D(var_0)) {
          var_4 = self.origin;
        }
      }
    }
  } else if(var_6 > var_2)
    return undefined;

  return var_4;
}

_id_D00D(var_0) {
  if(isDefined(self._id_4DAD)) {
    return anim._id_58E3;
  }

  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.ignoreme || isDefined(var_3.owner) && var_3.owner.ignoreme) {
      continue;
    }
    if(_id_0B05::_id_DB71(var_3)) {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_5 = undefined;

  if(var_1.size > 0) {
    var_5 = _func_0204(var_1, self.origin);
  }

  if(isDefined(var_5) && var_5.size > 0) {
    var_6 = 300;
    var_7 = distancesquared(var_5[0].origin, self.origin);

    if(var_7 < var_6 * var_6) {
      var_6 = 16;
    }

    var_8 = var_6 * var_6;

    if(istrue(self._id_24F8) || !isDefined(self._id_0323) || distancesquared(self._id_0323, var_5[0].origin) > var_8) {
      var_9 = var_5[0].origin;
      var_10 = self _meth_86F8(var_9);

      if(distancesquared(var_10, var_5[0].origin) > var_8) {
        return anim._id_58E3;
      }

      self _meth_84BC(0, var_10);
      self._id_24F8 = 0;
    }

    _id_06BD::_id_2408(1);
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

_id_A5E5(var_0) {
  _id_06BD::_id_2408(0);

  if(isDefined(level._id_5D8B)) {
    if(!istrue(self._id_3B1C)) {
      var_1 = self[[level._id_5D8B]]();

      if(isDefined(var_1)) {
        self _meth_84BC(0, var_1);
      } else {
        self _meth_8474();
      }
    } else
      self _meth_8474();
  } else
    self _meth_8474();

  return anim._id_EACB;
}

_id_C5B6(var_0) {
  self endon("death");
  wait(var_0);
  self._id_01BD = undefined;
}

_id_11068() {
  var_0 = self;
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("terminate_ai_threads");
  var_0 hide();
  wait 0.2;
  var_0 show();
}

_id_110A5(var_0) {
  if(self _meth_86EE() && self _meth_867A("ai_glow", var_0)) {
    self setscriptablepartstate("ai_glow", var_0);
  }
}

_id_110A8(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_D603) || !isDefined(var_1._id_D6A4)) {
    return;
  }
  var_2 = randomfloat(2.0);

  if(var_0 == level._id_11057) {
    var_1[[var_1._id_D603]]("run");
  }

  var_1[[var_1._id_D6A4]](var_2);
}

_id_110A6(var_0) {
  var_1 = self;
  var_2 = level._id_11049;

  if(isDefined(level.zombie_round_override)) {
    var_2 = level.zombie_round_override;
  }

  if(isDefined(var_2)) {
    if(getdvarint("#x3dee089cb49164e4e", 0)) {
      var_1 calculateroundbasedzombiehealth(var_2);
    } else {
      var_3 = _id_09A4::zombiegethealthroundscale(var_2);
      var_4 = 1;

      if(isDefined(var_1.zm_ai_category)) {
        var_5 = 0;

        switch (var_1.zm_ai_category) {
          case "special":
            var_5 = 0.5;
            break;
          case "elite":
            var_5 = 0.33;
            break;
        }

        var_4 = 1 + var_5 * (level.players.size - 1);
      }

      var_1.maxhealth = int(var_1.health * var_3 * var_4);
      var_1.health = var_1.maxhealth;
    }

    if(isDefined(var_1.backpackhealth)) {
      var_1 scripts\aitypes\zombie_juggernaut\combat::initbackpackhealth();
    }
  }
}

_id_110A7(var_0) {
  var_1 = self;
  var_2 = 20;

  if(var_1._id_1210 == "actor_enemy_zombie_juggernaut_cp") {
    var_2 = 60;
  }

  if(istrue(var_1._id_86F2)) {
    var_2 = 135;

    if(var_1._id_1210 == "actor_enemy_zombie_juggernaut_cp") {
      var_2 = 200;
    }
  } else {
    var_3 = level._id_11049;

    if(isDefined(level.zombie_round_override)) {
      var_3 = level.zombie_round_override;
    }

    if(isDefined(var_3)) {
      if(var_3 <= 5) {
        var_4 = 1;
      } else if(var_3 <= 8) {
        var_4 = 1.5;
      } else if(var_3 <= 16) {
        var_4 = 2;
      } else if(var_3 <= 30) {
        var_4 = 3;
      } else {
        var_4 = 5;
      }

      var_2 = int(var_2 * var_4);

      if(var_2 > 150) {
        var_2 = 150;
      }
    }
  }

  var_1._id_9D80 = var_2;
}

equiphelmet() {
  if(!self _meth_8679("helmet")) {
    return;
  }
  self._id_7572 = 1;
  self setscriptablepartstate("helmet", "equipped", 0);
}

_id_780D() {
  self._id_7572 = undefined;
  var_0 = self _meth_8575("helmet") + "_pop";
  self setscriptablepartstate("helmet", var_0, 0);
}

_id_9CCB(var_0) {
  if(!_id_0909::_id_1106E()) {
    return anim._id_58E3;
  }

  if(istrue(self._id_0181)) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_012F)) {
    return anim._id_58E3;
  }

  if(istrue(self._id_012F._id_017F)) {
    return anim._id_58E3;
  }

  if(self _meth_8067(self._id_012F)) {
    var_1 = self._id_012F _meth_8176();

    if(self _meth_8068(var_1)) {
      return anim._id_EACB;
    }
  }

  return anim._id_58E3;
}

_id_DA06(var_0) {
  return _id_06AC::_id_DA07(var_0, self._id_012F);
}

_id_DA19(var_0) {
  return _id_06AC::_id_DA19(var_0);
}

_id_6A2D() {
  if(isDefined(self._id_0323)) {
    return undefined;
  }

  if(isDefined(self._id_012F)) {
    var_0 = self._id_012F.origin - self.origin;
    var_1 = vectortoangles(var_0);
    var_2 = _func_043F(var_1[1] - self.angles[1]);

    if(var_2 <= self._id_04A9) {
      return undefined;
    }

    if(isPlayer(self._id_012F) && _id_EF0D(self._id_012F)) {
      return self._id_012F;
    }
  }

  return undefined;
}

onzombiedamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(var_4 == "MOD_MELEE" && isPlayer(var_1)) {
    if(scripts\cp\cp_weapon::_id_88F9(var_5)) {
      self playsoundtoplayer("zmb_knife_melee_flesh_sweet_plr", var_1);
      self playsoundtoteam("zmb_knife_melee_flesh_sweet_npc", var_1.team, var_1);
    } else {
      self playsoundtoplayer("zmb_wpn_melee_flesh_sweet_plr", var_1);
      self playsoundtoteam("zmb_wpn_melee_flesh_sweet_npc", var_1.team, var_1);
    }
  }

  var_14 = undefined;
  self._id_10CE2 = undefined;

  if(!isDefined(self)) {
    return var_2;
  }

  if(level._id_A393 <= 0 && level scripts\engine\utility::_id_5C00("infinite_round_spawning") && !istrue(level._id_2023)) {
    self._id_2042 = 1;
  }

  if((isDefined(self._id_202A) || isai(var_1) && scripts\engine\utility::is_equal(var_4, "MOD_MELEE")) && isDefined(var_1) && scripts\engine\utility::is_equal(var_1.team, self.team)) {
    return 0;
  }

  var_15 = _id_0014::_id_0F74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_13);

  if(int(var_15) < self.health && var_5.basename != "s4_brimstone_zm" && var_5.basename != "s4_ar_tgun_mp") {
    self notify("zombie_non_lethal_damage");
  }

  if((scripts\engine\utility::is_equal(var_8, "head") || scripts\engine\utility::is_equal(var_8, "helmet")) && var_4 != "MOD_MELEE") {
    return;
  }
}

set_turned(var_0) {
  _id_110A5(scripts\engine\utility::ter_op(var_0, "brainrot_loop", "base_loop"));

  if(isDefined(self._id_D603)) {
    self[[self._id_D603]]("super_sprint");
  }
}

set_frozen(var_0) {
  self._id_8873 = var_0;
  set_limb_frozen("head", var_0);
  set_limb_frozen("torso", var_0);
  set_limb_frozen("legs", var_0);

  if(var_0 && istrue(self._id_7572)) {
    _id_780D();
  }
}

set_limb_frozen(var_0, var_1) {
  if(!self _meth_8679(var_0)) {
    return;
  }
  var_2 = self _meth_8575(var_0);
  var_3 = _func_0440(var_2, "_frozen");

  if(var_1) {
    var_3 = var_3 + "_frozen";
  }

  if(self _meth_867A(var_0, var_3)) {
    self setscriptablepartstate(var_0, var_3);
  } else {}
}

isrevengekill(var_0) {
  var_1 = scripts\engine\utility::_id_1BAB(self._id_42EF, var_0);
  return isDefined(var_1);
}

should_try_dismemberment(var_0, var_1, var_2) {
  return !var_0 _id_110CE() && var_1 != "MOD_FALLING" && var_2.basename != "repulsor_zombie_mp" && var_2.basename != "zombie_water_trap_mp" && var_2.basename != "s4_mine_ger_s44_zm";
}

zombietrydoscriptedanim(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isDefined(var_1)) {
    _id_0AED::_id_18D0(self._id_1C30._id_1A35, var_0, var_1, var_2, var_3, var_4);
    self._id_0DDF._id_A235 = "stop";
    return 1;
  }

  return 0;
}

zombieplayintroloopscriptedanim(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
    _id_0AED::animscriptintroloopmp(self._id_1C30._id_1A35, var_0, var_1, var_2, var_3, var_4);
    thread zombiewatchanimscriptcancelled();
    return 1;
  }

  return 0;
}

zombiewatchanimscriptcancelled() {
  self endon("death");
  self notify("zombieWatchAnimScriptCancelled");
  self endon("zombieWatchAnimScriptCancelled");
  self waittill("CancelAnimscriptMP");
  self._id_0DDF._id_A235 = "stop";
}

calculateroundbasedzombiehealth(var_0) {
  if(!isDefined(level.ai_round_based_health_setting)) {
    initroundbasedzombiehealthsetting();
  }

  var_1 = scripts\cp\utility::_id_459B(self._id_110B0, "base");

  foreach(var_4, var_3 in level.ai_round_based_health_setting) {
    if(var_1 == var_4) {
      self.health = getroundbasedzombiehealth(var_4, var_0, var_3);
      self.maxhealth = self.health;
      return;
    }
  }
}

initroundbasedzombiehealthsetting() {
  level.ai_round_based_health_setting = [];
  level.ai_starting_health = [];
  var_0 = tablelookupgetnumrows("cp/zombies/zombie_round_based_health.csv");
  var_1 = _func_0225("cp/zombies/zombie_round_based_health.csv");

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = tablelookupbyrow("cp/zombies/zombie_round_based_health.csv", var_2, 0);

    if(var_3 == "") {
      break;
    }

    var_4 = tablelookupbyrow("cp/zombies/zombie_round_based_health.csv", var_2, 1);
    var_5 = tablelookupbyrow("cp/zombies/zombie_round_based_health.csv", var_2, 2);

    if(var_4 == "" || var_5 == "") {
      break;
    }

    var_6 = tablelookupbyrow("cp/zombies/zombie_round_based_health.csv", var_2, 3);

    if(var_6 == "") {
      var_6 = 0;
    }

    var_7 = spawnStruct();
    var_7.base_health = int(var_4);
    var_7._id_9C21 = int(var_5);
    var_7.num_player_health_scale = float(var_6);
    var_7.a_health_progression = [];

    for(var_8 = 0; 4 + var_8 + 2 <= var_1; var_8 = var_8 + 2) {
      var_9 = tablelookupbyrow("cp/zombies/zombie_round_based_health.csv", var_2, 4 + var_8);
      var_10 = tablelookupbyrow("cp/zombies/zombie_round_based_health.csv", var_2, 5 + var_8);

      if(var_9 == "" || var_10 == "") {
        break;
      }

      var_11 = spawnStruct();
      var_11.start_round = int(var_9);
      var_11.health_added = int(var_10);
      var_7.a_health_progression[var_7.a_health_progression.size] = var_11;
    }

    level.ai_round_based_health_setting[var_3] = var_7;
  }
}

getroundbasedzombiehealth(var_0, var_1, var_2) {
  if(!isDefined(level.ai_starting_health[var_0]) || isDefined(level.ai_starting_health[var_0].round) && level.ai_starting_health[var_0].round != var_1) {
    var_3 = var_2.base_health;
    var_4 = var_2.a_health_progression;

    if(var_1 > 1 && isDefined(var_4) && var_4.size > 0) {
      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        if(var_1 >= var_4[var_5].start_round) {
          var_6 = var_4[var_5].health_added;

          if(isDefined(var_4[var_5 + 1]) && var_1 >= var_4[var_5 + 1].start_round) {
            var_7 = var_4[var_5 + 1].start_round - var_4[var_5].start_round;
          } else {
            var_7 = var_1 - var_4[var_5].start_round;
          }

          var_3 = var_3 + var_6 * var_7;
          continue;
        }

        break;
      }
    }

    var_3 = int(clamp(var_3, 0, var_2._id_9C21));
    var_8 = level.players.size;

    if(var_2.num_player_health_scale > 0 && var_8 > 1) {
      var_3 = var_3 + var_3 * (var_8 - 1) * var_2.num_player_health_scale;
    }

    if(!isDefined(level.ai_starting_health[var_0])) {
      level.ai_starting_health[var_0] = spawnStruct();
    }

    level.ai_starting_health[var_0].health = int(var_3);
    level.ai_starting_health[var_0].round = var_1;
  }

  return level.ai_starting_health[var_0].health;
}