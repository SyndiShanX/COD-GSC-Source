/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1380.gsc
**************************************/

init() {
  level._id_0A41["zombie_fireman"] = level._id_0A41["zombie"];
  level._id_0A41["zombie_fireman"]["think"] = ::_id_ABAB;
  level._id_0A41["zombie_fireman"]["move_mode"] = ::_id_ABA7;
  level._id_0A41["zombie_fireman"]["on_damaged"] = ::_id_ABA8;
  level._id_0A41["zombie_fireman"]["on_killed"] = ::_id_ABA9;
  level._id_0A41["zombie_fireman"]["ragdoll_overrides"] = ::_id_ABAA;
  level._id_0A41["zombie_fireman"]["is_hit_weak_point"] = ::_id_ABA6;
  level._id_0A41["zombie_fireman"]["tesla_delayed_dmg"] = ::zombie_fireman_tesla_delayed_dmg;
  var_0 = spawnStruct();
  var_0._id_0A4B = "zombie_fireman";
  var_0._id_0EAE = "zombie_animclass";
  var_0._id_0879 = "zombie_generic";
  var_0._id_5ED2["default look"]["whole_body"] = "zom_fireman_body";
  var_0._id_5ED2["default look"]["heads"] = ["zom_fireman_head"];
  var_0._id_4C12 = 20;
  var_0._id_4C07 = 175000;
  var_0._id_60E2 = 90;
  var_0._id_2F9B = 1;
  var_0._id_907C = "zombie_fireman";
  var_0._id_8302 = 80;
  var_0._id_8303 = 25;
  var_0.parenttype = "zombie_generic";
  var_0.suppressive_fire_speed_multiplier = 0.3;
  _id_0547::_id_0A52(var_0, "zombie_fireman");
  level._id_9E16["zombie_fireman"] = ::_id_9E17;
  level._id_7A5D["zombie_fireman"] = ::_id_3C08;
  _id_0547::_id_7BD0("fireman_do_flame", ::_id_3BF1, ::_id_3D2B, -1);
  level._effect["zombie_fireman_flamethrower"] = loadfx("vfx/fire/flamethrower_end_med");
  level._effect["zombie_fireman_flamethrower_expensive"] = loadfx("vfx/test/flamethrower_test");
  level._effect["zmb_zmb_fire_torso"] = loadfx("vfx/zombie/zmb_zmb_fire_torso");
  level._effect["zmb_ground_impact_lrg"] = loadfx("vfx/zombie/zmb_ground_impact_lrg");
  level._effect["gasTankExplosion"] = loadfx("vfx/explosion/molotov_cocktail_impact");
  level._effect["fireman_sparks"] = loadfx("vfx/weaponimpact/zmb_fireman_metal_impact_1");
  level._effect["fireman_explosion"] = loadfx("vfx/explosion/zmb_fireman_explosion");
  level._effect["fireman_leak"] = loadfx("vfx/smoke/zmb_fireman_leak");
}

_id_3BFB(var_0) {
  if(!isDefined(level._id_3C00))
    level._id_3C00 = 1;

  level._id_3BFF = 0;
  level._id_3BFE = 0;
  level._id_66A6 = _func_0A4(14, 15);
  level._id_3BED = 0;

  if(!isDefined(level._id_3BF2)) {
    if(isDefined(var_0))
      level._id_3BF2 = var_0;
    else
      level._id_3BF2 = 0;
  }

  thread _id_3C10();
}

_id_ABA7() {
  self._id_64C2 = 1.0 * _id_054D::_id_4440();

  if(isDefined(self._id_28D2)) {
    var_0 = isDefined(self._id_5B88) && gettime() - self._id_5B88 > 5000;

    if(var_0) {
      return "sprint";
      return;
    }

    return "run";
    return;
  } else {
    var_1 = _id_053C::_id_4F88();
    var_2 = undefined;

    if(isDefined(var_1) && var_1.size > 0)
      var_2 = distancesquared(var_1[0].origin, self.origin);

    if(isDefined(var_2) && var_2 > 50000)
      return "run";
    else
      return "walk";
  }
}

_id_8A1B() {
  self _meth_85A1("zombie_fireman");
  self _meth_839E("agent");
  self._id_11AB = 70 + self.radius;
  self._id_60F5 = "large";
  self._id_60F6 = 200;
  self._id_64C2 = 1.0;
  self._id_672D = 1.0;
  self._id_9D0D = 1.0;
  self._id_4013 = 1.0;
  _id_0547::_id_86C8(100);
  _id_0547::_id_86C7(self._id_60F0);
  self _meth_8399(self._id_2BCA);
  self._id_60E4 = 0.25;
  self._id_3CFA = 3;
  self._id_0EAD._id_6AFE["melee"] = ::_id_3BFD;
  self._id_01B5 = 1;
  self._id_3CF9 = 1;
  self._id_3CFB = 0;
  var_0 = 0.0872222;
  self _meth_85E0(1);
  self _meth_85DE(var_0);
  self._id_2FA4 = 1;
  self._id_3FF1 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_fireman"), level._id_A980) / 3;
  self._id_3FF2 = self._id_3FF1;
  self._id_3FEE = 0;
}

_id_ABAB() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  _id_0566::_id_ABB5();
  _id_8A1B();
  thread _id_A112();
  thread _id_A113();
  self._id_6816 = 1;
  self._id_55AB = 1;
  self._id_562B = 1;
  self._id_5569 = 1;
  self._id_66EC = 1;
  self.is_flamethrower_immune = 1;
  var_0 = 0.2;

  for(;;) {
    wait(var_0);

    if(!common_scripts\utility::_id_562E(self._id_5580) && !common_scripts\utility::_id_562E(self._id_5748)) {
      if(_id_053C::_id_4F8C())
        continue;
    }

    if(common_scripts\utility::_id_562E(self._id_5580)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(self._id_5748)) {
      continue;
    }
    if(!_id_0547::_id_4B2C()) {
      _id_053C::_id_4F9A();
      continue;
    }

    if(_id_3BEE()) {
      if(_id_3BEF()) {
        thread _id_0547::_id_7D1A("fireman_do_flame", undefined, var_0);
        continue;
      }

      if(_id_3BF0()) {
        if(!isDefined(self._id_5BC1) || distancesquared(self._id_5BC1, self.origin) > 256)
          self._id_60ED = self._id_0108;

        self _meth_83A1(self._id_28D2);
        continue;
      }
    }

    if(_id_053C::_id_4F9B(1)) {
      continue;
    }
    if(_id_053C::_id_4F9A()) {
      continue;
    }
    _id_053C::_id_0647();
  }
}

_id_3BEE() {
  if(self._id_00CA)
    return 0;

  if(!isDefined(self._id_28D2))
    return 0;

  if(self._id_0BA4 == "melee" || maps\mp\agents\_scripted_agent_anim_util::_id_57E2())
    return 0;

  if(!_id_0547::_id_4B2C())
    return 0;

  if(maps\mp\agents\humanoid\_humanoid::_id_A7F8())
    return 0;

  if(maps\mp\agents\humanoid\_humanoid::_id_2EE6())
    return 0;

  return 1;
}

_id_3BEF() {
  if(!_id_3C0F("flame"))
    return 0;

  var_0 = isDefined(self._id_3CFB) && gettime() - self._id_3CFB <= self._id_3CFA * 1000;

  if(!self._id_3CF9 || var_0)
    return 0;

  if(self._id_3FEE == 1)
    return 0;

  return 1;
}

_id_3BF0() {
  if(!_id_3C0F("melee"))
    return 0;

  if(isDefined(self._id_60E4) && isDefined(self._id_5BC0)) {
    var_0 = gettime() - self._id_5BC0;

    if(var_0 < self._id_60E4 * 1000)
      return 0;
  }

  return 1;
}

_id_3C0F(var_0) {
  if(!isDefined(self._id_28D2))
    return 0;

  if(!maps\mp\_utility::isreallyalive(self._id_28D2))
    return 0;

  if(self._id_0BA4 == "traverse")
    return 0;

  if(!maps\mp\agents\humanoid\_humanoid_util::_id_56DD(self._id_28D2)) {
    if(!maps\mp\agents\humanoid\_humanoid::_id_5859(self._id_28D2.origin))
      return 0;

    if(var_0 == "flame" && !_id_AA4F())
      return 0;
    else if(var_0 == "melee" && !_id_AA53())
      return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid_melee::_id_5753())
    return 0;

  return 1;
}

_id_AA4F() {
  return distancesquared(self.origin, self._id_28D2.origin) <= _func_0DA(250);
}

_id_AA53() {
  return distancesquared(self.origin, self._id_28D2.origin) <= _func_0DA(self._id_60F0);
}

_id_56EE() {
  var_0 = self.origin + (0, 0, self._id_60E1);
  var_1 = self._id_28D2.origin + (0, 0, self._id_60E1);
  var_2 = _func_080(var_0, var_1);
  return distancesquared(var_2, var_1) > 1;
}

_id_3BF1() {
  self endon("death");
  self endon("flame_interrupt");

  if(!isDefined(self._id_28D2)) {
    return;
  }
  self._id_28D2 endon("disconnect");
  var_0 = maps\mp\agents\humanoid\_humanoid::_id_457E(self._id_28D2);

  if(_id_56EE())
    return maps\mp\agents\humanoid\_humanoid_melee::_id_60E7();

  var_1 = 0;
  var_2 = undefined;

  if(var_0._id_A266 && self._id_3CF9) {
    var_3 = maps\mp\agents\humanoid\_humanoid_util::_id_1F51(self.origin, var_0.origin);

    if(var_3) {
      var_1 = 1;
      var_2 = var_0.origin;
    } else {
      var_4 = _func_07E(self.origin + (0, 0, 32), self._id_28D2.origin + (0, 0, 32), 0, undefined);

      if(var_4) {
        var_1 = 1;
        var_2 = self.origin;
      }
    }
  }

  if(!var_1) {
    return;
  }
  self._id_3CFB = gettime();
  _id_3C01(self._id_28D2, var_2);
}

_id_3BFD() {
  self endon("death");
  self endon("killanimscript");
  self._id_28D2 endon("disconnect");
  var_0 = maps\mp\agents\humanoid\_humanoid::_id_457E(self._id_28D2);

  if(maps\mp\agents\humanoid\_humanoid_melee::_id_5753())
    return maps\mp\agents\humanoid\_humanoid_melee::_id_60E7();

  if(var_0._id_A266 && !_id_AA53()) {
    maps\mp\agents\humanoid\_humanoid_melee::_id_60E7();
    return;
  }

  _id_3C02(self._id_28D2, var_0.origin);
}

_id_3C02(var_0, var_1) {
  self endon("death");
  var_2 = "attack_stand";
  var_3 = 0;

  if(isDefined(self._id_60ED)) {
    var_2 = "attack_" + self._id_60ED;
    var_3 = 1;
    self._id_60ED = undefined;
  }

  var_4 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_2);
  var_5 = 0;
  var_6 = 1.0;
  self._id_5BBE = undefined;
  self._id_5BBF = undefined;
  var_7 = randomint(self _meth_83DB(var_4));
  var_8 = self _meth_83D8(var_4, var_7);
  var_9 = _func_065(var_8);
  var_10 = _func_067(var_8, "attack");
  var_11 = _func_067(var_8, "end");
  var_10 = common_scripts\utility::_id_0F73(var_10, var_11);
  var_12 = _id_4511(var_9, var_6, var_10, undefined);
  self _meth_839D("gravity");

  if(var_3)
    self _meth_839B("face enemy");
  else
    self _meth_839B("face angle abs", (0, _func_109(var_0.origin - self.origin), 0));

  self _meth_839C("anim deltas");
  maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_4, var_7, var_6);
  thread _id_3C0E(var_4, var_9);
  var_13 = undefined;
  self _meth_839A(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "DoAttack");
  childthread _id_A137(var_0, var_8, var_9, var_6, var_10);
  wait(var_12);
  self notify("cancel_updatelerppos");
  self _meth_839C("anim deltas");
  self _meth_839A(1, 1);
  self._id_5BC1 = self.origin;
  var_14 = var_9 / var_6 - var_12;

  if(var_14 > 0)
    maps\mp\agents\_scripted_agent_anim_util::_id_A79F("attack_anim", "end", var_14);

  self notify("cancel_updatelerppos");
  self _meth_839C("anim deltas");
  self _meth_839A(1, 1);
}

_id_3C01(var_0, var_1) {
  self._id_5580 = 1;
  self _meth_83A2(1);
  self endon("killanimscript");
  self endon("death");
  var_2 = common_scripts\utility::random(["s2_fireman_attack_flamethrower_stand", "s2_fireman_attack_flamethrower_walk"]);
  var_3 = 1;
  var_4 = 1.0;
  self._id_5BBE = undefined;
  self._id_5BBF = undefined;
  var_5 = randomint(self _meth_83DB(var_2));
  var_6 = self _meth_83D8(var_2, var_5);
  var_7 = _func_065(var_6);
  self _meth_839D("gravity");

  if(var_3)
    self _meth_839B("face enemy");
  else
    self _meth_839B("face angle abs", (0, _func_109(var_0.origin - self.origin), 0));

  self _meth_839C("anim deltas");
  maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_2, var_5, var_4);
  _id_3D2A();
}

_id_3C0E(var_0, var_1) {
  maps\mp\_utility::waitfortimeornotify(var_1, "killanimscript");
  self._id_5BC0 = gettime();
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "DoAttack");
}

_id_4511(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2) || var_2.size == 0)
    return var_3;

  var_4 = var_0 / var_1 * var_2[0];

  if(isDefined(var_3) && var_3 < var_4)
    return var_3;

  return var_4;
}

_id_A136(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_4 = self.origin;
  var_5 = var_1;
  var_6 = 0.05;

  for(;;) {
    wait(var_6);
    var_5 = var_5 - var_6;

    if(var_5 <= 0) {
      break;
    }

    var_7 = maps\mp\agents\humanoid\_humanoid_melee::_id_4707(var_0, var_2);

    if(!isDefined(var_7)) {
      break;
    }

    if(isDefined(var_3)) {
      var_8 = var_3;
      var_9 = var_7 - var_4;

      if(_func_0E5(var_9) > var_8 * var_8)
        var_7 = var_4 + vectorNormalize(var_9) * var_8;
    }

    self _meth_839B("face enemy");
    self _meth_83A4(self.origin, var_7, var_5);
  }
}

_id_3D2A() {
  self endon("death");
  self _meth_839A(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "DoFiremanFlameAttack");
  _id_0378::_id_8D74("flamethrower_start", "tag_flamethrower_fx");
  thread _id_3D29();
  var_0 = gettime();
  self._id_7ACF = 0;

  while(gettime() - var_0 < 2000) {
    var_1 = common_scripts\utility::_id_0F73(_id_0547::_id_408F(), level.players);

    foreach(var_9 in var_1) {
      waitframe();

      if(!isalive(self) || !isalive(var_9)) {
        continue;
      }
      if(_id_5625(var_9)) {
        if(var_9.team == self.team) {
          if(var_9._id_0A4B != "zombie_fireman") {
            var_9 _meth_8682(0, 10, 1, "none", 1);
            var_9 _meth_8059(5, var_9 getEye(), undefined, undefined, "MOD_ENERGY");
            var_10 = 10;
            var_9 _id_0378::_id_8D74("zombie_ignite", var_10);
          }

          continue;
        }

        var_11 = 1;

        if(should_longburn(var_9))
          var_11 = 5;

        if(var_11 == 1)
          do_fireman_player_unit_damage(var_9);
        else
          thread prolonged_damage(var_9, var_11);
      }
    }

    waitframe();
  }

  thread _id_3D31();
}

should_longburn(var_0) {
  return (common_scripts\utility::_id_562E(self.isuberfireman) || common_scripts\utility::_id_562E(self.isfireassassin)) && !common_scripts\utility::_id_562E(var_0.islongburning);
}

do_fireman_player_unit_damage(var_0) {
  var_0 _meth_8059(15, var_0 getEye(), self, undefined, "MOD_ENERGY");

  if(!isDefined(self._id_7ACF))
    self._id_7ACF = 0;

  self._id_7ACF = self._id_7ACF + 15;
}

prolonged_damage(var_0, var_1) {
  self endon("death");
  var_0 endon("disconnect");
  var_0.islongburning = 1;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    do_fireman_player_unit_damage(var_0);
    wait 0.7;
  }

  var_0.islongburning = 0;
}

_id_3D29() {
  var_0 = spawn("script_model", self gettagorigin("tag_flamethrower_fx") + (600, 0, 0));
  var_0 setModel("tag_origin");
  var_0 _meth_8055(self, "tag_flamethrower_fx");
  var_1 = _func_382("zmb_brenner_flamethrower_beam", self, "tag_flamethrower_fx", var_0, "tag_origin");
  self waittill("cancel_updatelerppos");
  var_1 delete();
  var_0 delete();
}

_id_3D31() {
  self endon("death");
  self._id_5580 = 0;
  self._id_3CFB = gettime();
  self _meth_83A2(0);
  self notify("cancel_updatelerppos");
  self _meth_839C("anim deltas");
  self _meth_839A(1, 1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "DoFiremanFlameAttack");
  self._id_5BC1 = self.origin;
  self._id_5B9B = self.origin;
  self._id_3CF9 = 0;
  _id_0378::_id_8D74("flamethrower_stop", "tag_flamethrower_fx");
}

_id_3D2B() {
  _id_3D31();
}

_id_5625(var_0) {
  var_1 = 250;
  var_2 = _func_0DA(var_1 + 100);
  var_3 = _func_0DA(50);
  var_4 = self getEye();
  var_5 = self getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = var_4 + var_6 * 50;
  var_8 = var_7 + var_6 * var_1;

  if(_func_211(self.origin, var_0.origin) > var_2)
    return 0;

  var_9 = (var_0.origin - var_4) * (1, 1, 0);

  if(vectordot(var_9, var_6 * (1, 1, 0)) < 0.866)
    return 0;

  var_10 = _id_7540(var_0 getEye(), var_7, var_8);
  var_11 = _id_7540(var_0 gettagorigin("J_Spine4"), var_7, var_8);
  var_12 = _func_0AF(var_10, var_11);

  if(var_12 > var_3)
    return 0;

  return 1;
}

_id_7540(var_0, var_1, var_2) {
  var_3 = _func_0E5(var_2 - var_1);

  if(var_3 == 0)
    return _func_0E5(var_1 - var_0);

  var_4 = vectordot(var_0 - var_1, var_2 - var_1) / var_3;

  if(var_4 < 0)
    return _func_0E5(var_0 - var_1);
  else if(var_4 > 1)
    return _func_0E5(var_0 - var_2);

  var_5 = var_1 + var_4 * (var_2 - var_1);
  var_6 = _func_0E5(var_0 - var_5);
  return var_6;
}

_id_A137(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  level endon("game_ended");

  if(var_4.size == 0) {
    return;
  }
  if(common_scripts\utility::_id_627D(var_4.size, 2) != 0) {}

  var_5 = var_2 / var_3 * var_4[0];
  var_6 = var_2 / var_3 * var_4[1];
  var_7 = 0;
  var_8 = 0.05;
  self._id_4DE5 = [];
  wait(var_5);
  var_9 = var_6 - var_5;

  while(var_7 <= var_9) {
    wait(var_8);
    var_7 = var_7 + var_8;
    _id_21CD(var_0);
  }
}

_id_21CD(var_0) {
  var_1 = self gettagorigin("TAG_WEAPON_LEFT");
  var_2 = (var_1 - self.origin) * (1, 1, 0);
  var_3 = length(var_2);

  foreach(var_5 in level._id_6E97) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(_id_0547::_id_577E(var_5)) {
      continue;
    }
    if(_func_26C(var_5, self)) {
      continue;
    }
    _id_21CE(var_5, var_1, var_2, var_3, self._id_60E2);
  }

  if(isDefined(var_0) && isDefined(var_0._id_56ED) && var_0._id_56ED)
    _id_21CE(var_0, var_1, var_2, var_3, var_0.maxhealth / 2);
}

_id_21CE(var_0, var_1, var_2, var_3, var_4) {
  if(common_scripts\utility::_id_0F79(self._id_4DE5, var_0)) {
    return;
  }
  if(!_id_21CC(var_0, var_1[2])) {
    return;
  }
  var_5 = (var_0.origin - self.origin) * (1, 1, 0);
  var_6 = length(var_5);

  if(var_6 > var_3 + 40) {
    return;
  }
  if(vectordot(var_5, var_2) < 0.707) {
    return;
  }
  self notify("attack_hit", var_0, self.origin);
  maps\mp\agents\humanoid\_humanoid_melee::_id_3210(var_0, var_4, "MOD_IMPACT");
  self._id_4DE5[self._id_4DE5.size] = var_0;
}

_id_21CC(var_0, var_1) {
  var_2 = self.origin[2] + 80;
  var_3 = max(var_2, var_1);
  var_4 = self.origin[2];
  var_5 = var_0 getEye()[2];
  var_6 = var_0.origin[2];

  if(var_5 >= var_4 && var_5 <= var_3)
    return 1;

  if(var_6 >= var_4 && var_6 <= var_3)
    return 1;

  return 0;
}

_id_A112() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0.05;

  for(;;) {
    wait(var_0);

    if(!isDefined(self._id_5B9B) || !isDefined(self._id_28D2)) {
      continue;
    }
    var_1 = maps\mp\agents\humanoid\_humanoid::_id_457E(self._id_28D2);

    if(!isDefined(var_1.origin)) {
      continue;
    }
    var_2 = length(var_1.origin - self._id_5B9B);

    if(var_2 < 100) {
      continue;
    }
    self._id_3CF9 = 1;
  }
}

_id_A113() {
  self endon("death");
  level endon("game_ended");
  var_0 = 0.05;

  for(;;) {
    wait(var_0);
    var_1 = undefined;
    var_2 = -1;
    var_3 = [];

    foreach(var_5 in level._id_6E97) {
      waitframe();
      var_6 = _id_1E49(var_5);

      if(var_6 < 0) {
        continue;
      }
      var_3[var_3.size] = var_5;
    }

    self._id_9992 = var_3;
  }
}

_id_1E49(var_0) {
  var_1 = 0;
  var_2[0] = ::_id_388D;
  var_2[1] = ::_id_388B;
  var_2[2] = ::_id_3889;
  var_2[3] = ::_id_388A;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = self[[var_2[var_3]]](var_0);

    if(var_4 < 0)
      return -1;

    var_1 = var_1 + var_4;
  }

  return var_1 / var_2.size;
}

_id_388D(var_0) {
  if(!isDefined(var_0) || !isalive(var_0))
    return -1;

  if(isDefined(var_0._id_00CE) && var_0._id_00CE == 1)
    return -1;

  if(var_0 _meth_8541())
    return -1;

  if(_func_26C(var_0, self))
    return -1;

  if(_id_0547::_id_8B95(var_0))
    return -1;

  if(_id_0547::_id_577D(var_0))
    return -1;

  return 1;
}

_id_3889(var_0) {
  if(!var_0 _meth_83B8() && _func_211(self.origin, var_0.origin) < 250000)
    return -1;

  return 1;
}

_id_388C(var_0) {
  var_1 = length(var_0.origin - self.origin);
  var_2 = max(1 - var_1 / 1500, 0);
  return var_2;
}

_id_388A(var_0) {
  if(_id_9B84(self getEye() + (0, 0, 45), var_0, undefined))
    return 1;

  return -1;
}

_id_9B84(var_0, var_1, var_2) {
  var_3 = bulletTrace(var_0, var_1 getEye(), 0, undefined, 0, 0, 0, 0, 0);
  return var_3["fraction"] == 1;
}

_id_388B(var_0) {
  if(!isDefined(self._id_28D2))
    return 1;

  if(self._id_28D2 == var_0 && _func_0E5(var_0.origin - self.origin) < _func_0DA(250))
    return -1;

  return 1;
}

_id_9E17(var_0, var_1, var_2, var_3) {
  if(gettime() - var_0._id_9A18 >= 50) {
    var_0.origin = maps\mp\agents\humanoid\_humanoid_util::_id_60F4(var_1, var_0._id_686A, var_2);
    var_0.origin = maps\mp\agents\humanoid\_humanoid_util::_id_34AB(var_0.origin, 15, 55);
    var_0._id_9A18 = gettime();

    if(isDefined(var_0.origin)) {
      var_4 = self._id_60E1;
      var_5 = var_0.origin + (0, 0, var_4);
      var_6 = var_1 + (0, 0, var_4);
      var_7 = _func_080(var_5, var_6);

      if(distancesquared(var_7, var_6) > 1)
        var_0.origin = undefined;
    }
  }
}

_id_ABA9(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = "unknown kill method";

  if(isDefined(var_1)) {
    var_9 = common_scripts\utility::_id_98E7(isPlayer(var_1), var_1.name, "") + " killed fireman";
    var_10 = _id_0541::_id_5E60("head");
    _id_0541::_id_65D0(self._id_6250 | var_10, 1, 1, (0, 0, 1), 0);
  }

  var_11 = self gettagorigin("j_head");
  level notify("fireman_killed");

  if(common_scripts\utility::_id_562E(level._id_3BF2))
    level thread _id_057E::_id_8FA7(var_11, var_9);

  _id_054D::_id_6BD4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_3C10() {
  level waittill("zombie_wave_started");

  for(;;) {
    while(level._id_A980 < level._id_66A6)
      level waittill("zombie_wave_started");

    if(level._id_7F2A == "zombie_dog")
      level._id_66A6++;
    else if(level._id_3C00)
      _id_3C13();

    level waittill("zombie_wave_ended");
  }
}

_id_3C13() {
  var_0 = _id_3C12();
  wait 5;

  while(var_0 > 0) {
    _id_3C14();
    var_2 = _id_3C11(1);

    if(isDefined(var_2))
      var_0--;

    if(var_0 > 0)
      wait(_func_0A5(5, 10));
  }

  var_3 = 5;
  var_4 = 7;

  if(isDefined(level.fireman_round_min))
    var_3 = level.fireman_round_min;

  if(isDefined(level.fireman_round_max))
    var_4 = level.fireman_round_max;

  if(var_3 == var_4)
    level._id_66A6 = level._id_A980 + var_3;
  else
    level._id_66A6 = level._id_A980 + _func_0A4(var_3, var_4);

  level._id_3BFE++;
}

_id_3C14() {
  _id_056D::_id_A78F();
}

_id_3C12() {
  level._id_3BFF++;

  if(level.players.size == 1)
    return 1;
  else if(level._id_3BFF == 1 || level._id_3BFF == 2)
    return 1;
  else if(level._id_3BFF == 3 || level._id_3BFF == 4)
    return 2;
  else
    return 3;
}

_id_3C11(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = _id_054D::_id_4696("zombie_fireman", 1, 0);

  if(!isDefined(var_1))
    return undefined;

  var_3 = 0;

  if(_id_0547::_id_5565(var_1._id_0165, "zombie_sky_spawner") || _id_0547::_id_5565(var_1._id_8109, "scripted_fire_spawn_drop"))
    var_3 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  var_4 = 1;
  var_5 = _id_054D::_id_90BA("zombie_fireman", var_1, "fireman", var_2, var_4, 0, undefined, 0);

  if(!isDefined(var_5))
    return undefined;

  if(var_3)
    var_5 thread _id_3C0D(var_1.origin);

  var_5.health = _id_3C04(var_5.health);

  if(var_5.health < var_5.maxhealth)
    var_5.maxhealth = var_5.health;

  level notify("spawned_fireman");

  if(isDefined(var_5)) {
    var_5._id_0C29 = 0;
    var_5 thread _id_3C06();
  }

  if(!common_scripts\utility::_id_562E(var_0))
    level._id_66A6 = level._id_A980 + _func_0A4(5, 7);

  return var_5;
}

_id_3C0D(var_0) {
  self endon("death");
  var_1 = 2304;
  var_2 = 10000;
  var_3 = 9216;
  var_4 = 2250000;
  maps\mp\agents\_scripted_agent_anim_util::_id_A79F("scripted_anim", "land", 2);
  playFX(level._effect["zmb_ground_impact_lrg"], var_0 + (0, 0, -12));
  var_5 = _id_0547::_id_408F();

  foreach(var_7 in var_5) {
    if(var_7 == self) {
      continue;
    }
    var_8 = distancesquared(var_7.origin, var_0);

    if(var_8 <= var_2) {
      if(var_7._id_0A4B == "zombie_generic" || var_7._id_0A4B == "zombie_berserker")
        var_7 suicide();
    }
  }

  foreach(var_11 in level.players) {
    var_8 = distancesquared(var_11.origin, var_0);

    if(var_8 <= var_1)
      var_11 _meth_8059(100, var_0, self, self);

    var_12 = (var_4 - var_8) / var_4;

    if(var_12 <= 0 || var_12 >= 1) {
      return;
    }
    var_13 = var_12 * 0.15;
    _func_17F(var_13, 0.1, var_0, 1500);
    var_11 _meth_809F("damage_heavy");
  }
}

_id_3C06() {
  level._id_3BED++;
  thread _id_3C05();
  self waittill("death");
  thread _id_3C07();
  level._id_3BED--;
  level notify("fireman_total_update");
}

_id_3C05() {
  self waittill("actor_corpse", var_0);
  wait 60;

  if(isDefined(var_0))
    var_0 delete();
}

_id_3C07() {}

_id_3C04(var_0) {
  var_1 = 1;

  switch (level.players.size) {
    case 1:
    case 0:
      var_1 = 1;
      break;
    case 2:
      var_1 = 1.5;
      break;
    case 3:
      var_1 = 2;
      break;
    case 4:
      var_1 = 2.5;
      break;
  }

  return _id_3C03(var_0, 175000, var_1);
}

_id_3C03(var_0, var_1, var_2) {
  if(var_0 >= var_1 * var_2)
    var_0 = int(var_1 * var_2);

  return var_0;
}

_id_3C08() {
  var_0 = [];

  foreach(var_2 in level._id_AC4F) {
    var_3 = 0;

    if(isDefined(var_2._id_8260)) {
      var_4 = strtok(var_2._id_8260, " ,");

      foreach(var_6 in var_4) {
        if(var_6 == "zombie_fireman")
          var_3 = 1;
      }
    }

    if(level._id_AC80._id_ACB3[var_2._id_AC8A]._id_556E && var_3)
      var_0[var_0.size] = var_2;
  }

  return common_scripts\utility::random(var_0);
}

_id_ABAA() {
  return 0.28;
}

_id_ABA8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(level.zmb_boss_damage_reduction_func))
    var_2 = [[level.zmb_boss_damage_reduction_func]](var_5, var_2, var_4);

  if(var_10 == "j_backpack" && self._id_3FEE == 0 && isalive(self)) {
    self._id_3FF1 = self._id_3FF1 - var_2;

    if(!common_scripts\utility::_id_562E(self.godtank)) {
      var_2 = 1;
      thread _id_3FF3(var_6);
    }

    if(!common_scripts\utility::_id_562E(self.godtank) && self._id_3FF1 <= 0)
      thread _id_3FEF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(var_10 != "j_backpack" && self._id_3FEE == 0 && !issubstr(var_5, "fliegerfaust") && !issubstr(var_5, "tesla") && !issubstr(var_5, "razergun") && var_5 != "bazooka_zm" && var_5 != "panzerschreck_zm" && var_5 != "raven_sword_zm")
    var_2 = var_2 * 0.5;

  if(var_10 == "j_backpack" && self._id_3FEE == 1) {
    var_2 = 0;

    if(!isDefined(self.lastsparkfxtime) || self.lastsparkfxtime != gettime()) {
      playFX(common_scripts\utility::_id_44F5("fireman_sparks"), var_6);
      self.lastsparkfxtime = gettime();
    }
  }

  _id_054D::_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_3FEF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  waittillframeend;

  if(isalive(self)) {
    _id_0380::_id_2889("zmb_fireman_gas_tank_destroyed", undefined, self.origin);
    self._id_3FEE = 1;
    thread _id_3FF0(var_6);
    self _meth_8682(0.01 * self.maxhealth, 1.5, 20.0, "none", 1, self, var_5);
    self _meth_8059(self._id_3FF2, self.origin, var_1, var_0, "MOD_EXPLOSIVE", var_5);

    if(isDefined(level.zmb_events_player_destoyed_brenner_gas_tank))
      var_1 thread[[level.zmb_events_player_destoyed_brenner_gas_tank]]();
  }
}

_id_3FF3(var_0) {
  if(randomint(100) >= 80)
    _func_147(common_scripts\utility::_id_44F5("fireman_leak"), self, "TAG_STOWED_BACK");
}

_id_3FF0(var_0) {
  _func_147(common_scripts\utility::_id_44F5("fireman_explosion"), self, "TAG_STOWED_BACK");
}

_id_ABA6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!common_scripts\utility::_id_562E(self._id_3FEE) && var_9 == "j_backpack")
    return 1;

  return _id_054D::_id_5714(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

zombie_fireman_tesla_delayed_dmg(var_0, var_1, var_2) {
  if(common_scripts\utility::_id_562E(var_1))
    var_0 = maps\mp\gametypes\zombies::_id_1E59();

  if(isDefined(var_2))
    var_0 = var_2;

  return var_0;
}