/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\humanoid\_humanoid.gsc
*********************************************************/

_id_8A27() {
  self._id_11AB = 26 + self.radius;
  self._id_60F5 = "normal";
  self._id_60F6 = 50;
  self._id_11B8 = 54;
  self._id_11B9 = -64;
  self._id_29BE = 2250000;
  self._id_00CB = 1;
  self._id_64C2 = 1.0;
  self._id_672D = 1.0;
  self._id_9D0D = 1.0;
  self._id_4013 = 1.0;
  self._id_173C = 0;
  self._id_173E = 1;
  self._id_99FC = 0;
  self._id_0012 = 1;
  self._id_60E1 = 40;
  self._id_60F0 = 60;
  self._id_60F1 = _squared(self._id_60F0);
  _id_0547::_id_86C7(self._id_60F0);
  self._id_2BCA = self.radius + 1;
  self scragentsetgoalradius(self._id_2BCA);
  self._id_60E5 = 0.5;

  if(!isDefined(self._id_8303))
    self._id_8303 = self.radius;

  if(!isDefined(self._id_8302))
    self._id_8302 = self._id_00BD;
}

init() {
  self._id_0EAD = spawnStruct();
  self._id_0EAD._id_6AFE = [];
  self._id_0EAD._id_6AFE["idle"] = maps\mp\agents\humanoid\_humanoid_idle::main;
  self._id_0EAD._id_6AFE["move"] = maps\mp\agents\humanoid\_humanoid_move::main;
  self._id_0EAD._id_6AFE["traverse"] = maps\mp\agents\humanoid\_humanoid_traverse::main;
  self._id_0EAD._id_6AFE["melee"] = maps\mp\agents\humanoid\_humanoid_melee::main;
  self._id_0EAD._id_6AFE["scripted"] = ::_id_6B9F;
  self._id_0EAD._id_6B2F = [];
  self._id_0EAD._id_6B2F["idle"] = maps\mp\agents\humanoid\_humanoid_idle::_id_0085;
  self._id_0EAD._id_6B2F["move"] = maps\mp\agents\humanoid\_humanoid_move::_id_0085;
  self._id_0EAD._id_6B2F["melee"] = maps\mp\agents\humanoid\_humanoid_melee::_id_0085;
  self._id_0EAD._id_6B2F["traverse"] = maps\mp\agents\humanoid\_humanoid_traverse::_id_0085;
  self._id_0EAD._id_6B2F["scripted"] = ::_id_6BA0;
  self._id_0EAD._id_6ADB = [];
  self._id_0EAD._id_6ADB["move"] = maps\mp\agents\humanoid\_humanoid_move::_id_6ADB;
  self._id_0BA4 = "idle";
  self._id_0108 = "walk";
  self._id_017D = 100;
  self.radius = 15;
  self._id_00BD = 40;
}

_id_6B9F() {
  self._id_57C0 = 1;
}

_id_6BA0() {
  self._id_01BB = 0;
  self._id_57C0 = undefined;
}

_id_8FC9(var_0, var_1, var_2, var_3) {
  self setModel("tag_origin");
  self._id_90DC = "humanoid";
  self._id_6AFF = maps\mp\agents\_scripted_agent_anim_util::_id_6AFF;

  if(isDefined(var_1) && isDefined(var_2)) {
    var_4 = var_1;
    var_5 = var_2;
  } else {
    self _meth_856C(15, 60);
    var_6 = [[level._id_4696]]();
    var_4 = var_6.origin;
    var_5 = var_6.angles;
  }

  maps\mp\agents\_agent_utility::_id_08A7();
  self._id_5CC6 = maps\mp\agents\_agent_utility::_id_45AE(self.name);
  self._id_90AB = gettime();
  self._id_5BE2 = gettime();
  init();
  self spawnagent(var_4, var_5, var_0, 15, 60, var_3);
  level notify("spawned_agent", self);
  maps\mp\agents\_agent_common::_id_83FD(100);

  if(isDefined(var_3))
    maps\mp\agents\_agent_utility::hudoutlineenable(var_3.team, var_3);

  self takeallweapons();
  self scragentsetspecies("human");
  self scragentsetnopenetrate(1);
  self scragentsetorienttoground(0);
  self scragentsetobstacleavoid(0);
  self scragentsetlateralcodemove(0);
  self scragentsetpathteamspread(1);
  self scragentsetallowragdoll(1);
  self thread[[maps\mp\agents\_agent_utility::_id_0A59("think")]]();
}

_id_2EE6() {
  if(isDefined(self._id_5BBF) && isDefined(self._id_5BBE) && _distance2dsquared(self._id_28D2.origin, self._id_5BBF) < 4 && distancesquared(self.origin, self._id_5BBE) < 2500)
    return 1;

  return 0;
}

_id_2EE5() {
  if(isDefined(self._id_5BBC) && isDefined(self._id_5BBB) && _distance2dsquared(self._id_28D2.origin, self._id_5BBC) < 4 && distancesquared(self.origin, self._id_5BBB) < 2500)
    return 1;

  return 0;
}

_id_5859(var_0) {
  var_1 = 0;
  var_2 = var_0[2] - self.origin[2];
  var_1 = var_2 <= self._id_11B8 && var_2 >= self._id_11B9;

  if(!var_1 && isPlayer(self._id_28D2) && common_scripts\utility::_id_562E(self._id_28D2._id_571F)) {
    if(length(self getvelocity()) < 5)
      var_1 = var_2 <= self._id_11B8 * 2 && var_2 >= self._id_11B9;
  }

  return var_1;
}

_id_A7F8() {
  if(maps\mp\agents\humanoid\_humanoid_util::_id_56DD(self._id_28D2))
    return 0;

  return !_id_5859(self._id_28D2.origin) && _distance2dsquared(self.origin, self._id_28D2.origin) < maps\mp\agents\humanoid\_humanoid_util::_id_4581() * 0.75 * 0.75;
}

_id_7AC0(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self._id_28D2;

  if(!isDefined(var_1))
    return 0;

  if(!maps\mp\_utility::isreallyalive(var_1))
    return 0;

  if(self._id_0BA4 == "traverse")
    return 0;

  if(!maps\mp\agents\humanoid\_humanoid_util::_id_56DD(var_1)) {
    if(!_id_5859(var_1.origin))
      return 0;

    if(var_0 == "normal" && !maps\mp\agents\humanoid\_humanoid_util::_id_AA51(var_1))
      return 0;
    else if(var_0 == "base" && !maps\mp\agents\humanoid\_humanoid_util::_id_AA52(var_1))
      return 0;
  }

  if(maps\mp\agents\humanoid\_humanoid_melee::_id_5753(var_1))
    return 0;

  return 1;
}

_id_457E(var_0) {
  if(!isDefined(self._id_60E0))
    self._id_60E0 = spawnStruct();

  if(maps\mp\agents\humanoid\_humanoid_util::_id_56DE(var_0) && !maps\mp\agents\humanoid\_humanoid_util::_id_4B59())
    maps\mp\agents\humanoid\_humanoid_util::_id_1E52();

  var_1 = maps\mp\agents\humanoid\_humanoid_util::_id_45DC(var_0);
  self._id_60E0._id_3771 = var_1;
  var_2 = maps\mp\agents\humanoid\_humanoid_util::_id_4583(var_0, var_1);

  if(isDefined(var_2)) {
    self._id_60E0._id_A266 = 1;
    self._id_60E0.origin = var_2;
  } else {
    self._id_60E0._id_A266 = 0;
    self._id_60E0.origin = var_1;

    if(isDefined(self._id_3043)) {
      if(!isDefined(maps\mp\agents\humanoid\_humanoid_util::_id_34AB(self._id_60E0.origin, 15, 55))) {
        if(!isDefined(self._id_7A40)) {
          self._id_7A40 = [];

          for(var_3 = 0; var_3 < maps\mp\agents\humanoid\_humanoid_util::_id_45C6(); var_3++)
            self._id_7A40[self._id_7A40.size] = var_3;

          self._id_7A40 = common_scripts\utility::array_randomize(self._id_7A40);
        }

        foreach(var_5 in self._id_7A40) {
          var_6 = var_0 maps\mp\agents\humanoid\_humanoid_util::_id_4582(self._id_60F5);
          var_7 = var_6[var_5];

          if(isDefined(var_7.origin)) {
            self._id_60E0.origin = var_7.origin;
            break;
          }
        }
      }
    }
  }

  return self._id_60E0;
}

_id_A909() {
  self notify("watchFavoriteEnemyDeath");
  self endon("watchFavoriteEnemyDeath");
  self endon("death");
  self endon("disconnect");
  self._id_0094 common_scripts\utility::_id_A71A(5.0, "death", "disconnect");
  maps\mp\agents\humanoid\_humanoid_util::_id_867E(undefined);
}

_id_32B0(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2()) {
    return;
  }
  if(maps\mp\agents\humanoid\_humanoid_util::_id_56BC()) {
    return;
  }
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "DoStopHitReaction");
  self._id_5381 = 1;
  var_7 = "pain_stand";

  if(isDefined(var_1) && var_1 == "head")
    var_7 = "pain_stand_head";

  if(isDefined(self._id_6CC4))
    var_7 = self._id_6CC4;

  var_8 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_7);
  var_9 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_8);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_8, var_9, self._id_672D, "pain_anim");
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "DoStopHitReaction");
  self._id_5381 = undefined;
  self scragentsetscripted(0);
}

_id_45FB(var_0, var_1) {
  [var_3, var_4] = _id_0547::_id_4584(var_0, var_1);

  if(!isDefined(var_3))
    return undefined;

  if(isDefined(var_4) && issubstr(var_4, "shovel"))
    var_4 = "shovel_zm";

  return level._id_6DF9[var_3][var_4];
}

_id_8B9D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(var_4) || var_4 != "MOD_MELEE")
    return 0;

  if(!isPlayer(var_1))
    return 0;

  if(_id_0547::_id_6720())
    return 0;

  if(!_id_0547::_id_4B2C())
    return 0;

  if(isalive(var_1._id_6DFA) && var_1._id_6DFA != self)
    return 0;

  if(!self _meth_864D(var_1))
    return 0;

  if(maps\mp\agents\humanoid\_humanoid_util::_id_56BC())
    return 0;

  if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2())
    return 0;

  if(var_2 >= self.health)
    return 0;

  var_10 = _id_45FB(var_5, var_1);

  if(!isDefined(var_10))
    return 0;

  var_11 = self.origin - var_1.origin;
  var_12 = anglesToForward(self.angles);

  if(vectordot(var_11, var_12) > 0.866)
    return 0;

  if(!isDefined(var_10["hit_zombie_action"]))
    return 0;

  var_13 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_10["hit_zombie_action"], undefined, 1);

  if(!isDefined(var_13))
    return 0;

  return 1;
}

_id_3298(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("death");
  var_10 = var_1;
  var_10._id_6DFA = self;
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "DoMeleeHitReaction");
  self._id_5381 = 1;
  var_11 = 0.2;
  var_9 = var_9 - 1;

  if(var_9 < 0)
    var_9 = 0;

  var_12 = var_9 * 0.001;
  var_12 = var_12 - var_11;
  var_13 = _id_45FB(var_5, var_1);
  var_14 = var_13["hit_zombie_action"];
  var_15 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_14);
  var_16 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_15);
  var_17 = self getanimentry(var_15, var_16);
  var_18 = _getanimlength(var_17);
  var_19 = 1;
  var_20 = max(0, maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_17, "melee_hit", 0.1) * var_18 / var_19 - var_12);
  var_21 = max(0, maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_17, "melee_stop_pairing", 0.2) * var_18 / var_19 - var_12);
  self notify("helmet_pop", max(0, maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_17, "helmet_pop", 0.2) * var_18 / var_19 - var_12));

  if(isDefined(var_13["hit_zombie_snd"])) {
    var_22 = spawnStruct();
    var_22.player = var_1;
    var_22._id_ABE6 = self.origin;
    var_22._id_4DCF = var_8;
    var_22._id_60B8 = var_4;
    var_22._id_01D0 = var_5;
    var_22.delaysec = var_20;
    _id_0378::_id_8D74(var_13["hit_zombie_snd"], var_22);
  }

  thread _id_6DFD(var_10, var_13["hit_worldmodel_anim"], var_12, var_20, var_21, var_13);
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_15, var_16, var_19, var_12);
  var_23 = var_18 / var_19 - var_12;
  var_24 = 0.2;
  var_25 = var_13["hit_zombie_blend_duration"];

  if(isDefined(var_25))
    var_24 = var_25;

  var_26 = var_23 - var_24;

  if(var_26 > 0)
    wait(var_26);

  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "DoMeleeHitReaction");
  self._id_5381 = undefined;
  self scragentsetscripted(0);

  if(isDefined(var_10))
    var_10._id_6DFA = undefined;
}

_id_6DFD(var_0, var_1, var_2, var_3, var_4, var_5) {
  wait 0;
  var_6 = spawn("script_model", var_0.origin + anglesToForward(var_0.angles) * 1);
  var_6 setModel(var_0.model);
  var_6.angles = var_0.angles;
  var_6 hide();
  var_7 = undefined;
  var_6 scriptmodelplayanim(var_1, "actually play this anim please", max(0, var_2));
  var_8 = 0;
  var_9 = var_5["invalid_pair_distance"];

  if(isDefined(var_9)) {
    if(distance(self.origin, var_0.origin) > var_9) {
      _id_0542::set_zombie_too_far_for_pairing(var_0);
      var_8 = 1;
    }
  }

  if(!var_8)
    self scragentsynchronizeanims(var_3, var_3, var_6, "tag_sync", "tag_origin");
  else
    self.angles = (0, _vectortoyaw(var_0.origin - self.origin), 0);

  for(var_10 = 0; var_10 < var_4; var_10 = var_10 + 0.05) {
    var_11 = var_2 + var_10;
    var_6 scriptmodelplayanim(var_1, "actually play this anim please", max(0, var_11));
    waitframe();
  }

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  var_6 delete();
}

_id_60EA(var_0, var_1, var_2) {
  var_3 = (32, 0, 0);
  self endon("MeleeHitReactionAlignZombie_stop");

  for(var_4 = 0; var_4 < var_2; var_4 = var_4 + 0.05) {
    var_5 = var_0 localtoworldcoords(var_3);
    var_6 = _combineangles(var_0.angles, (0, 180, 0));
    var_7 = 1;
    var_8 = _vectorlerp(self.origin, var_5, var_7);
    var_9 = _func_10B(self.angles, var_6, var_7);
    self setOrigin(var_8, 0);
    self scragentsetorientmode("face angle abs", var_9);
    waitframe();
  }
}

_id_6ADB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self._id_99FC = gettime();
  self._id_99FB = var_9;

  if(isDefined(self._id_0117))
    self._id_29BC = vectorNormalize(self.origin - self._id_0117.origin);

  if(_id_8B9D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9))
    thread _id_3298(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  else if(_id_8B9F(var_2, var_5, var_4, var_8))
    thread _id_32B0(maps\mp\agents\humanoid\_humanoid_util::_id_29CB(var_6, var_7), var_8, var_5, var_4, var_2, var_0, var_1);
  else if(isDefined(self._id_0EAD._id_6ADB[self._id_0BA4]))
    self[[self._id_0EAD._id_6ADB[self._id_0BA4]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_8B9F(var_0, var_1, var_2, var_3) {
  if(self._id_0A4B == "zombie_heavy" || self._id_0A4B == "zombie_fireman")
    return 0;

  if(_id_0547::_id_6720())
    return 0;

  if(isDefined(var_1) && (var_1 == "trap_zm_mp" || var_1 == "zombie_water_trap_mp"))
    return 0;

  if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2())
    return 0;

  if(self._id_0BA4 == "traverse")
    return 0;

  if(isDefined(self._id_6CC4))
    return 1;

  if(!_id_0547::_id_4B2C())
    return 0;

  if(isDefined(var_3) && var_3 == "head" && var_2 != "MOD_MELEE" && (!isDefined(self._id_5BA7) || gettime() - self._id_5BA7 > 10000)) {
    self._id_5BA7 = gettime();
    return 1;
  }

  if(!_id_054D::_id_8B9C())
    return 0;

  if(isDefined(var_1) && weaponclass(var_1) == "sniper")
    return 1;

  if(isDefined(var_2) && _isexplosivedamagemod(var_2) && var_0 >= 10)
    return 1;

  if(isDefined(var_1) && var_1 == "concussion_grenade_mp")
    return 1;

  if(isDefined(self._id_8BA0) && [[self._id_8BA0]]())
    return 1;

  return 0;
}

_id_6394() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_3) && var_3 == self._id_0117) {
      continue;
    }
    if(!maps\mp\agents\_scripted_agent_anim_util::_id_57E2())
      _id_6B3B();
  }
}

_id_6B3B(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_32B0(self.angles[1] + 180);
}