/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1338.gsc
**************************************/

init() {
  _id_0547::_id_7BD0("stunning_burst", ::_id_AC63, ::_id_AC65, 4.25);
  _id_0547::_id_7BD0("mini_stunning_burst", ::mini_stunning_burst_state_run, ::mini_stunning_burst_state_interrupt, 4.24999, ::mini_stunning_burst_state_finish);
  level._effect["stunning_burst_aoe"] = loadfx("vfx/zombie/abilities_perks/zmb_blood_stun_burst_aoe");
  level._effect["stunning_burst_aoe_mega"] = loadfx("vfx/zombie/abilities_perks/zmb_blood_breathing_room");
  level._effect["stunning_burst"] = loadfx("vfx/zombie/abilities_perks/zmb_blood_zmb_stun");
  level._effect["stunning_burst_sz"] = loadfx("vfx/zombie/abilities_perks/zmb_moon_zmb_stun");
  level._effect["stunning_burst_sustain"] = loadfx("vfx/zombie/abilities_perks/zmb_blood_sustain_zone");
  level._effect["stunning_burst_sustain_br"] = loadfx("vfx/zombie/abilities_perks/zmb_blood_sustain_zone_br");
  level._effect["zmb_blood_player_heal"] = loadfx("vfx/zombie/abilities_perks/zmb_blood_player_heal");
}

_id_3662() {
  if(!common_scripts\utility::_id_3798("stunning_burst_active"))
    common_scripts\utility::_id_3799("stunning_burst_active");

  common_scripts\utility::_id_379A("stunning_burst_active");
  _id_054B::_id_6AB2("role_ability_stunning_burst_zm");
  var_0 = _id_0547::_id_408F();
  var_1 = [];
  var_2 = self.origin;
  var_3 = 0;
  var_4 = 518400;

  if(common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_breathing_room_zm")) && !common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_sustain_zone_zm"))) {
    playFX(common_scripts\utility::_id_44F5("stunning_burst_aoe_mega"), var_2 + (0, 0, var_3));
    _id_0378::_id_8D74("aud_stunning_burst_use");
    var_4 = var_4 * 2.25;
  } else if(!common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_breathing_room_zm")) && common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_sustain_zone_zm"))) {
    playFX(common_scripts\utility::_id_44F5("stunning_burst_aoe"), var_2 + (0, 0, var_3));
    _id_0378::_id_8D74("aud_stunning_burst_use");
    thread sustain_zone_fx(level._effect["stunning_burst_sustain"], var_2 + (0, 0, var_3));
    var_4 = var_4 * 0.25;
  } else if(common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_breathing_room_zm")) && common_scripts\utility::_id_562E(_id_0547::_id_4BA7("specialty_class_sustain_zone_zm"))) {
    playFX(common_scripts\utility::_id_44F5("stunning_burst_aoe_mega"), var_2 + (0, 0, var_3));
    _id_0378::_id_8D74("aud_stunning_burst_use");
    thread sustain_zone_fx(level._effect["stunning_burst_sustain_br"], var_2 + (0, 0, var_3));
  } else {
    playFX(common_scripts\utility::_id_44F5("stunning_burst_aoe"), var_2 + (0, 0, var_3));
    _id_0378::_id_8D74("aud_stunning_burst_use");
  }

  foreach(var_6 in var_0) {
    if(distancesquared(self.origin, var_6.origin) < var_4)
      var_1[var_1.size] = var_6;
  }

  var_1 = _sortbydistance(var_1, var_2);
  var_8 = 0;

  if(isDefined(level.zmb_events_player_zombie_shellshock_stun))
    self thread[[level.zmb_events_player_zombie_shellshock_stun]](var_1.size);

  foreach(var_6 in var_1) {
    thread _id_94C0(var_6, var_2, var_8);
    var_8 = var_8 + 0.05;
  }

  var_11 = [];

  foreach(var_13 in level.players) {
    if(var_13 != self && maps\mp\_utility::isreallyalive(var_13))
      var_11[var_11.size] = var_13;
  }

  foreach(var_16 in var_11) {
    if(distancesquared(self.origin, var_16.origin) < var_4 && _abs(self.origin[2] - var_16.origin[2]) < 90)
      thread _id_0A31(var_16);
  }

  if(_id_0547::_id_4BA7("specialty_class_sustain_zone_zm"))
    thread _id_9529(var_4);
}

sustain_zone_fx(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("DisabledRoleAbility");

  for(;;) {
    playFX(var_0, var_1);
    wait 1;
  }
}

_id_2F9E() {
  if(common_scripts\utility::_id_3798("stunning_burst_active"))
    common_scripts\utility::_id_3796("stunning_burst_active");
}

_id_0A31(var_0) {
  if(_id_0547::_id_4BA7("specialty_class_on_your_feet_zm")) {
    if(isPlayer(var_0) && _id_0547::_id_577E(var_0)) {
      var_0 _id_0553::_id_53E2(self);
      playFX(level._effect["zmb_blood_player_heal"], var_0.origin, anglesToForward(var_0.angles));
      var_0 _meth_866C(&"add_teammate_mod_buffs", 3, "specialty_class_on_your_feet_zm", 1, self);
    }
  }

  if(_id_0547::_id_4BA7("specialty_class_bolster_morale_zm")) {
    if(isPlayer(var_0) && var_0 _id_0547::_id_73E9() < var_0 _id_0547::playergetmaxarmorcount()) {
      var_0 _id_0547::_id_73AC(1);
      var_0 _meth_866C(&"add_teammate_mod_buffs", 3, "specialty_class_bolster_morale_zm", 1, self);
    }
  }
}

_id_94C0(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_94B4))
    var_0._id_94B4 = [];

  var_0._id_94B4[var_0._id_94B4.size] = self;
  var_3 = var_0 common_scripts\utility::_id_A74D("death", var_2);

  if(!isDefined(var_3) || isDefined(var_3) && var_3 != "timeout") {
    return;
  }
  var_0._id_94B4 = common_scripts\utility::_id_0F93(var_0._id_94B4, self);
  var_4 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), level._id_A980);
  var_0 dodamage(var_4 * 0.125, var_1, self, self, "MOD_ENERGY", "dot_generic_zm");

  if(!isalive(var_0)) {
    return;
  }
  var_0 _id_AC56(self, 1);
  var_0.stunnedbybursttime = gettime();
  var_5 = "stunning_burst";
  var_0 thread play_shock_fx(var_5, "J_Spine4", self, 0.35);
  var_0 _id_0378::_id_8D74("aud_stun_zombies_strt");
  var_0 notify("is_tower_battle_distracted");

  if(_id_0547::_id_4BA7("specialty_class_fiery_burst_zm"))
    var_0 _meth_8682(0.03 * var_4, 1.5, 20.0, "none", 1, self, "dot_generic_zm");

  var_0 thread _id_0547::_id_7D1A("stunning_burst", [var_1, self], undefined, [self, "stunning_burst_active", self, "disconnect", self, "death"]);
  common_scripts\utility::_id_A70C(self, "stunning_burst_active", var_0, "death");
  var_0 _id_0378::_id_8D74("aud_stun_zombies_end");
  var_0 _id_AC56(self, 0);
}

play_shock_fx(var_0, var_1, var_2, var_3) {
  self notify("play_shock_fx");
  var_2 endon("stunning_burst_active");
  var_2 endon("disconnect");
  self endon("death");
  self endon("play_shock_fx");

  for(;;) {
    var_4 = gettime() / 1000;

    if(isDefined(self.recentshockfxtime) && var_4 - self.recentshockfxtime < var_3)
      wait(var_3 - (var_4 - self.recentshockfxtime));

    _playfxontag(common_scripts\utility::_id_44F5(var_0), self, var_1);
    self.recentshockfxtime = var_4;
    wait(var_3);
  }
}

_id_AC56(var_0, var_1, var_2) {
  if(!isDefined(self._id_94BD))
    self._id_94BD = [];

  if(common_scripts\utility::_id_562E(var_1)) {
    self._id_94BD = common_scripts\utility::_id_0F6F(self._id_94BD, var_0);

    if(self._id_94BD.size == 1)
      self notify("stun_burst");
  } else {
    self._id_94BD = common_scripts\utility::_id_0F93(self._id_94BD, var_0);

    if(self._id_94BD.size == 0)
      self notify("stun_burst_expired");
  }
}

_id_AC2A() {
  var_0 = self;

  if(isDefined(var_0._id_94BD) && var_0._id_94BD.size > 0)
    return 1;

  if(var_0 mini_stunning_burst_affected())
    return 1;

  return 0;
}

_id_AC2B(var_0) {
  return isDefined(self._id_94BD) && common_scripts\utility::_id_0F79(self._id_94BD, var_0);
}

zombiecanbestunknockedback() {
  if(maps\mp\agents\humanoid\_humanoid_util::_id_56BC())
    return 0;

  if(isDefined(self.stunnedbybursttime) && gettime() > self.stunnedbybursttime + 1000)
    return 0;

  return 1;
}

zombiestunknockbackanim(var_0, var_1) {
  var_2 = undefined;
  self._id_561D = 1;
  var_3 = maps\mp\agents\humanoid\_humanoid_util::_id_29CB(var_0);
  var_4 = _angleclamp180(var_3 - self.angles[1]);

  if(_abs(var_4) < 45)
    var_2 = "pain_knockback_front";
  else if(_abs(var_4) > 135)
    var_2 = "pain_knockback_back";
  else if(var_4 > 0)
    var_2 = "pain_knockback_right";
  else
    var_2 = "pain_knockback_left";

  var_5 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_2);
  var_6 = self getanimentrycount(var_5);
  var_7 = randomint(var_6);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);

  if(isPlayer(var_1) && var_1 _id_0547::_id_4BA7("specialty_class_breathing_room_zm"))
    self scragentsetanimscale(2, 1);

  if(self._id_0A4B == "zombie_fireman") {
    var_5 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("scripted_fire_stun_burst");
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_5, randomint(2), 1, "stun_anim");
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_5, 2, 1, "stun_anim");
    self scragentsetanimscale(1, 1);
  } else if(self._id_0A4B == "zombie_assassin") {
    var_5 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("scripted_asn_stun_burst");
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_5, 0, 1, "stun_anim");
    self.assassinmuststopattackingandleave = 1;
  } else {
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_5, var_7, 1, "stun_anim");
    self scragentsetanimscale(1, 1);
  }
}

zombiecanbestunheld() {
  if(common_scripts\utility::_id_0F79(["zombie_fireman", "zombie_assassin"], self._id_0A4B))
    return 0;

  return 1;
}

_id_AC63(var_0, var_1, var_2) {
  if(common_scripts\utility::_id_562E(self._id_57E8)) {
    return;
  }
  self scragentsetscripted(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "stunning_burst");

  if(!common_scripts\utility::_id_562E(var_2) && zombiecanbestunknockedback())
    zombiestunknockbackanim(var_0, var_1);

  if(zombiecanbestunheld())
    _id_AC62(var_1);

  _id_AC64();
}

_id_AC62(var_0) {
  if(isPlayer(var_0) && !var_0 common_scripts\utility::_id_3794("stunning_burst_active")) {
    return;
  }
  var_0 endon("stunning_burst_active");
  var_1 = undefined;
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("stun_hold");
  var_3 = self getanimentrycount(var_2);

  for(;;) {
    if(self._id_0A4B == "zombie_exploder") {
      if(common_scripts\utility::_id_562E(self._id_392C))
        var_1 = 0;
      else
        var_1 = 1;
    }

    if(isDefined(var_1))
      var_4 = var_1;
    else
      var_4 = randomint(var_3);

    self scragentsetanimmode("anim deltas");
    self scragentsetorientmode("face angle abs", self.angles);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_4, 1, "stun_anim");
  }
}

_id_AC64() {
  self._id_561D = 0;
  self notify("stunning_burst_end");
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "stunning_burst");
}

_id_AC65(var_0, var_1, var_2) {
  _id_AC64();
  thread zombiestunstaterestart(var_0, var_1);
}

zombiestunstaterestart(var_0, var_1) {
  self endon("death");
  var_1 endon("disconnect");
  var_1 endon("death");
  var_1 endon("stunning_burst_active");
  thread _id_0547::_id_7D1A("stunning_burst", [var_0, var_1, 1], undefined, [var_1, "stunning_burst_active", var_1, "disconnect", var_1, "death"]);
}

_id_62A6(var_0) {
  var_1 = 1.0;

  if(_id_AC2A() && isDefined(self._id_94BD)) {
    foreach(var_3 in self._id_94BD) {
      var_4 = 1.0;

      if(isPlayer(var_3) && var_3 _id_0547::_id_4BA7("specialty_class_exploit_weakness_zm") && !common_scripts\utility::_id_562E(self.shortstun))
        var_4 = 3.0;

      if(var_4 > var_1)
        var_1 = var_4;
    }
  }

  var_0 = var_0 * var_1;
  return var_0;
}

_id_9529(var_0) {
  var_1 = self getEye();
  var_2 = self getorigin();

  if(_id_0547::_id_4BA7("specialty_class_breathing_room_zm"))
    var_3 = "stunning_burst_sustain_br";
  else
    var_3 = "stunning_burst_sustain";

  var_4 = _spawnfx(common_scripts\utility::_id_44F5(var_3), var_2);
  _triggerfx(var_4);
  thread _id_952A(var_1, var_0);
  common_scripts\utility::_id_A70C(self, "disconnect", self, "stunning_burst_active");
  var_4 delete();
  self notify("sustain_zone_complete");
}

_id_4B9B(var_0) {
  return isDefined(var_0._id_94B4) && common_scripts\utility::_id_0F79(var_0._id_94B4, self);
}

_id_952A(var_0, var_1) {
  self endon("sustain_zone_complete");

  for(;;) {
    var_2 = _id_0547::_id_408F();
    var_3 = 0;

    foreach(var_5 in var_2) {
      if(isalive(var_5) && !_id_4B9B(var_5) && !var_5 _id_AC2B(self)) {
        if(distancesquared(var_0, var_5.origin) < var_1) {
          thread _id_94C0(var_5, var_0, var_3);
          var_3 = var_3 + 0.05;
        }
      }
    }

    wait 0.3;
  }
}

mini_stunning_burst_execute(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_2))
    var_2 = 480;

  if(!isDefined(var_3))
    var_3 = 5;

  if(!isDefined(var_4))
    var_4 = 4;

  var_8 = _id_0547::_id_408F();
  var_9 = _sortbydistance(_id_0547::_id_408F(), var_0, var_2);
  var_10 = 0;

  foreach(var_12 in var_9) {
    if(isDefined(var_5) && var_12 == var_5) {
      continue;
    }
    if(_id_0547::_id_5565(var_12._id_0A4B, var_6)) {
      continue;
    }
    var_13 = spawnStruct();
    var_13.origin = var_0;
    var_13._id_1180 = var_1;
    var_13.durationsecs = var_3;
    level thread mini_stunning_burst_stun_zombie(var_12, var_13, var_4, var_7, var_10);
    var_10 = var_10 + 0.05;
  }
}

mini_stunning_burst_stun_zombie(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  wait(var_4);

  if(isDefined(var_3))
    var_0 thread[[var_3]]();

  var_5 = 0.125 * maps\mp\gametypes\zombies::_id_1E59();
  var_6 = var_1.origin;
  var_7 = var_1._id_1180;
  var_0 dodamage(var_5, var_6, var_7, var_7, "MOD_ENERGY", "dot_generic_zm");

  if(common_scripts\utility::_id_562E(var_0._id_57E8)) {
    return;
  }
  var_0 thread _id_0547::_id_7D1A("mini_stunning_burst", [var_1], var_2);
}

mini_stunning_burst_state_run_manage_fx() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("flag_mini_burst");
  var_1 = common_scripts\utility::_id_44F5("stunning_burst");

  for(;;) {
    _playfxontag(var_1, var_0, "J_Spine4");
    wait 0.35;
  }
}

mini_stunning_burst_state_run_manage_aud() {
  var_0 = self;
  var_0 _id_0378::_id_8D74("aud_stun_zombies_strt");
  var_0 common_scripts\utility::_id_A732("flag_mini_burst", "death");
  var_0 _id_0378::_id_8D74("aud_stun_zombies_end");
}

mini_stunning_burst_state_run_hold(var_0) {
  var_1 = self;
  var_2 = var_1 maps\mp\agents\_scripted_agent_anim_util::_id_434D("stun_hold");

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = var_1 getanimentrycount(var_2);
  var_4 = gettime();

  for(;;) {
    var_5 = (gettime() - var_4) / 1000;

    if(var_5 > var_0) {
      break;
    }

    var_6 = randomint(var_3);

    if(var_1._id_0A4B == "zombie_exploder")
      var_6 = common_scripts\utility::_id_98E7(common_scripts\utility::_id_562E(var_1._id_392C), 0, 1);

    var_1 scragentsetanimmode("anim deltas");
    var_1 scragentsetorientmode("face angle abs", var_1.angles);
    var_1 maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_6, 1, "stun_anim");
  }
}

mini_stunning_burst_state_run(var_0) {
  var_1 = self;
  var_1 scragentsetscripted(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "mini_stunning_burst");
  var_2 = var_0.origin;
  var_3 = var_0._id_1180;
  var_4 = var_0.durationsecs;

  if(!var_1 common_scripts\utility::_id_3798("flag_mini_burst"))
    var_1 common_scripts\utility::_id_3799("flag_mini_burst");

  var_1 common_scripts\utility::_id_379A("flag_mini_burst");
  var_1 thread mini_stunning_burst_state_run_manage_fx();
  var_1 thread mini_stunning_burst_state_run_manage_aud();

  if(var_1 zombiecanbestunknockedback())
    var_1 zombiestunknockbackanim(var_2, var_3);

  if(var_1 zombiecanbestunheld())
    var_1 mini_stunning_burst_state_run_hold(var_4);
}

mini_stunning_burst_state_interrupt(var_0) {}

mini_stunning_burst_state_finish(var_0) {
  var_1 = self;
  var_1._id_561D = 0;
  var_1 common_scripts\utility::_id_3796("flag_mini_burst");
  var_1 scragentsetscripted(0);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "mini_stunning_burst");
}

mini_stunning_burst_affected() {
  var_0 = self;
  var_1 = var_0 common_scripts\utility::_id_3798("flag_mini_burst") && var_0 common_scripts\utility::_id_3794("flag_mini_burst");
  return var_1;
}