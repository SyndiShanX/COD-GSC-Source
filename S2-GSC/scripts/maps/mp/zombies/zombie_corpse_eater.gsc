/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_corpse_eater.gsc
***********************************************************/

init() {
  level.zmb_corpse_eater_channel_counter = 0;
  common_scripts\utility::_id_092C("zmb_corpse_eater_zombie_smoldering", "vfx/zombie/prototype_fx/zmf_corpse_eater_smoldering");
  var_0 = spawnStruct();
  var_0._id_0A4B = "zombie_dlc4";
  var_0._id_0EAE = "zombie_animclass";
  var_0._id_0E88 = "zombie_generic";
  var_0._id_0879 = "zombie_generic";
  var_0._id_4C12 = 1;
  var_0._id_60E2 = 40;
  var_0._id_8302 = 65;
  var_0._id_8303 = 15;
  var_0.parenttype = "zombie_generic";
  var_0.suppressive_fire_speed_multiplier = 0.3;
  var_0.tacklebymelee = 1;
  var_0.tacklebycharge = 1;
  var_0.knockbyravensword = 1;
  var_0.shockbyteslablood = 1;
  var_0.energyhold = 1;
  var_0.energyholdsecondary = 1;
  var_0.throwable = 1;
  var_1 = ["zom_corpseeater_head_a_org1", "zom_corpseeater_head_b_org1", "zom_corpseeater_head_c_org1"];
  var_0._id_5ED2["corpse_eater_a"]["whole_body"] = "zom_corpseeater_torso_a_org1";
  var_0._id_5ED2["corpse_eater_a"]["heads"] = var_1;
  var_0._id_5ED2["corpse_eater_b"]["whole_body"] = "zom_corpseeater_torso_b_org1";
  var_0._id_5ED2["corpse_eater_b"]["heads"] = var_1;
  var_0._id_5ED2["corpse_eater_c"]["whole_body"] = "zom_corpseeater_torso_c_org1";
  var_0._id_5ED2["corpse_eater_c"]["heads"] = var_1;
  level._id_0A41["zombie_dlc4"] = level._id_0A41["zombie"];
  level._id_0A41["zombie_dlc4"]["post_model"] = ::zombie_corpse_eater_vfx;
  level._id_0A41["zombie_dlc4"]["move_mode"] = maps\mp\zombies\zombie_sizzler::zombie_sizzler_move_mode_func;
  level._id_0A41["zombie_dlc4"]["think"] = ::zombie_corpse_eater_think;
  level._id_0A41["zombie_dlc4"]["get_action_params"] = ::zombie_corpse_eater_params;
  level._id_0A41["zombie_dlc4"]["on_damaged"] = ::zombie_corpse_eater_on_damaged;
  level._id_0A41["zombie_dlc4"]["on_damaged_finished"] = ::zombie_corpse_eater_on_damaged_finished;
  _id_0547::_id_7BA9(::unlink_corpseeater);
  _id_0547::_id_7BD0("corpse_eater_feed", ::enterfeedingstate, ::exitfeedingstate, 4);
  _id_0547::_id_7BD0("corpse_eater_detonate", ::enterdetonation, ::exitdetonation, 8);
  _id_0547::_id_0A52(var_0, "zombie_dlc4");
}

enterfeedingstate(var_0) {
  var_1 = get_target_zombie();

  if(!isDefined(var_1)) {
    exitfeedingstate();
    return;
  }

  self endon("death");

  if(!isDefined(self._id_5A36))
    self._id_5A36 = 0;

  level notify("corpse_eater_start_feed", self, var_1);
  self _meth_83A2(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "corpse_eater_feed");
  self _meth_839C("anim deltas");
  wait_for_eating_done();
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("corpse_eat_exit");
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, 0, 1, "scripted_anim");

  if(self._id_5A36 >= 5 && 0) {
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("corpse_eat_rage");
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, 0, 1, "scripted_anim");
  }

  exitfeedingstate();
}

enterdetonation(var_0) {
  self endon("death");
  self _meth_83A2(1);
  self _meth_839C("code_move");
  self _meth_839B("face angle abs", self.angles);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "corpse_eater_detonate");
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("corpse_death_explode");
  thread maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, 0, 1, "scripted_anim", undefined, ::detonate_on_notetrack);
  _id_0378::_id_8D74("aud_corpse_eater_pre_explosion");
}

detonate_on_notetrack(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "deathboom":
      do_final_detonation();
      break;
  }
}

do_final_detonation() {
  self._id_1F4C = 1;
  self.shouldexplode = 1;
  var_0 = undefined;

  if(isDefined(self._id_00E6))
    var_0 = self._id_00E6;

  self.luckycrit = 1;
  self._id_1DEB = 1;
  try_detonation();
  self _meth_8059(self.health * 2, self.origin, var_0);
}

exitfeedingstate(var_0) {
  self _meth_83A2(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "corpse_eater_feed");
}

exitdetonation(var_0) {
  self _meth_83A2(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "corpse_eater_detonate");
}

get_target_zombie() {
  foreach(var_1 in get_all_zombies_for_ce()) {
    if(var_1 is_corpse_eater_linked(self))
      return var_1;
  }
}

get_all_zombies_for_ce() {
  var_0 = [];
  var_1 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_000A) && var_3._id_000A == level._id_746E && !common_scripts\utility::_id_562E(var_3.isdarkhost)) {
      continue;
    }
    if(_id_0547::_id_5565(level.zombie_king, var_3)) {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

get_feed_secondary_count() {
  if(isDefined(self.forcedfeedcount))
    return self.forcedfeedcount;

  return 0;
}

exit_loop() {
  self endon("corpse_eat_loop");
  wait 3;
  self notify("corpse_eat_loop", "scripted_anim");
}

wait_for_eating_done() {
  self endon("death");
  var_0 = get_target_zombie();

  if(!isDefined(var_0)) {
    exitfeedingstate();
    return;
  }

  var_0 endon("death");
  self _meth_839B("face angle abs", self.angles);
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("corpse_eat_enter");
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, 0, 1, "scripted_anim");
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("corpse_eat_loop");
  childthread exit_loop();

  if(isDefined(self.loc_beam))
    self.loc_beam delete();

  self.loc_beam = _func_382("zmb_geistkraft_reg_beam_med", self, "jnt_mandible", var_0, "j_neck");
  _func_147(level._effect["zmb_corpse_eater_feed"], self, "j_head");
  _func_147(level._effect["dark_energy_burst"], var_0, "J_Head");
  _id_0378::_id_8D74("aud_corpse_eater_soul_suck", self.origin, var_0.origin);
  childthread kill_zombie_target();
  var_2 = get_feed_secondary_count();

  if(isDefined(var_2) && var_2 > 0) {
    var_3 = [];

    if(isDefined(self.secondary_loc_beams)) {
      foreach(var_5 in self.secondary_loc_beams) {
        if(isDefined(var_5))
          var_5 delete();
      }
    }

    self.secondary_loc_beams = [];
    var_7 = common_scripts\utility::_id_40B0(self.origin, _id_0547::_id_4090("zombie_generic"), [var_0], var_2, 256);

    foreach(var_9 in var_7) {
      if(!var_9 _id_0547::_id_4B2C()) {
        continue;
      }
      if(var_9 == self) {
        continue;
      }
      if(isDefined(var_9.corpseeatertargetid)) {
        continue;
      }
      var_3 = common_scripts\utility::_id_0F6F(var_3, var_9);
    }

    foreach(var_12 in var_3) {
      self.secondary_loc_beams[self.secondary_loc_beams.size] = _func_382("zmb_geistkraft_reg_beam_med", self, "jnt_mandible", var_12, "j_neck");
      _func_147(level._effect["zmb_corpse_eater_feed"], self, "j_head");
      _func_147(level._effect["dark_energy_burst"], var_0, "J_Head");
      _id_0378::_id_8D74("aud_corpse_eater_soul_suck", self.origin, var_12.origin);
      thread kill_zombie_target(var_12);
    }
  }

  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, 0, 1, "scripted_anim");
  self notify("corpse_eater_end_feed");
}

zombie_corpse_eater_params() {
  var_0 = _id_054D::_id_AC22();
  var_0["script_var"] = "sizzler_dlc4";
  return var_0;
}

periodically_spawn_corpse_eaters() {
  var_0 = common_scripts\utility::_id_46B7("zombie_spawner", "script_noteworthy");
  var_1 = [];
  level.plr_training_time = 0;

  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_8260) && issubstr(var_3._id_8260, "corpse_eater_enabled"))
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_3);
  }

  var_5 = 3;

  for(;;) {
    while(!isDefined(level._id_A980) || level._id_A980 < var_5)
      waitframe();

    while(!players_are_training_zombies()) {
      level.plr_training_time++;
      wait 1;
    }

    foreach(var_3 in common_scripts\utility::array_randomize(var_1)) {
      if(var_3 _id_055A::_id_905D()) {
        var_7 = _id_054D::_id_90BA("zombie_dlc4", var_3, "corpse_eater", 1, 1, 0);
        break;
      }
    }

    var_5 = level._id_A980 + 2;
    level.plr_training_time = 0;
  }
}

players_are_training_zombies() {
  if(_id_0547::_id_408F().size > 5) {
    level.plr_training_time = 0;
    return 0;
  }

  return level.plr_training_time >= 180;
}

zombie_corpse_eater_vfx(var_0) {
  self endon("death");

  if(isDefined(self.poweredupfx))
    self.poweredupfx delete();

  while(!should_detonate_on_players())
    waitframe();

  self.poweredupfx = _func_2A8(common_scripts\utility::_id_44F5("zmb_corpse_eater_zombie_smoldering"), self, "J_Spine4");
  _func_14C(self.poweredupfx);

  if(!common_scripts\utility::_id_562E(var_0))
    _id_0378::_id_8D74("aud_corpse_eater_fully_charged");
}

zombie_corpse_eater_think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  var_0 = 0.2;
  self._id_5A36 = 0;
  maps\mp\zombies\zombie_sizzler::zombie_sizzler_think_setup();
  self.custom_passive_action = ::zombie_corpse_eater_passive;
  self._id_6816 = 1;
  var_1 = 4;
  self.maxhealth = int(self.maxhealth * 3.8);
  self.health = self.maxhealth;

  for(;;) {
    wait(var_0);

    if(common_scripts\utility::_id_562E(self.startcorpseeater)) {
      self.startcorpseeater = 0;
      self._id_5A36 = 4;
      var_1 = 0;
    }

    if(!isDefined(self._id_1928))
      var_1 = var_1 - var_0;

    if(should_target_new_zombie(var_1))
      target_new_zombie();

    if(should_kill_zombie_target()) {
      _id_0547::_id_7D1A("corpse_eater_feed");
      continue;
    }

    if(_id_053C::_id_4F8C()) {
      continue;
    }
    if(_id_053C::_id_4F84()) {
      continue;
    }
    if(_id_053C::_id_4F9B()) {
      continue;
    }
    if(_id_053C::_id_4F9A()) {
      continue;
    }
    _id_053C::_id_0647();
  }
}

should_detonate_on_players() {
  if(!_id_0547::_id_5565(self._id_0A4B, "zombie_dlc4"))
    return 0;

  if(!isDefined(self._id_5A36))
    return 0;

  if(self._id_5A36 < 5)
    return 0;

  return 1;
}

get_max_zombies_to_eat() {
  return 5;
}

should_target_new_zombie(var_0) {
  if(isDefined(self._id_5A36) && self._id_5A36 >= 5)
    return 0;

  return !isDefined(self._id_1928) && var_0 <= 0;
}

target_new_zombie() {
  var_0 = common_scripts\utility::_id_40B0(self.origin, get_all_zombies_for_ce());

  foreach(var_2 in var_0) {
    if(!var_2 _id_0547::_id_4B2C()) {
      continue;
    }
    if(var_2 == self) {
      continue;
    }
    if(_id_0547::_id_5565(level.zombie_king, var_2)) {
      continue;
    }
    if(isDefined(var_2.corpseeatertargetid)) {
      continue;
    }
    if(!_id_0547::_id_5565(var_2._id_0A4B, "zombie_generic") && !common_scripts\utility::_id_562E(var_2.isdarkhost)) {
      continue;
    }
    level.zmb_corpse_eater_channel_counter++;
    var_2.corpseeatertargetid = level.zmb_corpse_eater_channel_counter;
    self.corpseeatertargetid = level.zmb_corpse_eater_channel_counter;
    self._id_1928 = var_2;
    break;
  }
}

unlink_corpseeater(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self.poweredupfx))
    self.poweredupfx delete();

  if(isDefined(self.loc_beam))
    self.loc_beam delete();

  if(isDefined(self.secondary_loc_beams)) {
    foreach(var_10 in self.secondary_loc_beams) {
      if(isDefined(var_10))
        var_10 delete();
    }
  }

  if(!_id_0547::_id_5565(self._id_0A4B, "zombie_dlc4") && isDefined(var_1) && isPlayer(var_1)) {
    var_12 = get_my_corpse_eater();

    if(isDefined(var_12) && isDefined(self._id_08E1) && _id_0547::_id_5565(self._id_08E1.name, "tesla_shock")) {
      self.beingeatenbyce = 1;
      var_13 = _id_0580::_id_8317(self.origin, var_1);
      var_13._id_6AA0 = _id_0557::_id_30D8;
      var_12 thread _id_0547::_id_7D1A("tesla_shock", [var_13], 1.8);
    }
  }

  if(!isDefined(self.corpseeatertargetid)) {
    return;
  }
  foreach(var_15 in get_all_zombies_for_ce()) {
    if(var_15 is_corpse_eater_linked(self)) {
      var_15._id_1928 = undefined;
      var_15.corpseeatertargetid = undefined;
    }
  }
}

is_corpse_eater_linked(var_0) {
  if(var_0 == self)
    return 0;

  if(_id_0547::_id_5565(self.corpseeatertargetid, var_0.corpseeatertargetid))
    return 1;

  return 0;
}

get_my_corpse_eater() {
  foreach(var_1 in get_all_zombies_for_ce()) {
    if(var_1 is_corpse_eater_linked(self))
      return var_1;
  }
}

should_kill_zombie_target() {
  var_0 = get_target_zombie();

  if(!isDefined(var_0))
    return 0;

  return distance(self.origin, var_0.origin) < 96;
}

kill_zombie_target(var_0) {
  self endon("death");

  if(!isDefined(var_0))
    var_1 = get_target_zombie();
  else
    var_1 = var_0;

  if(common_scripts\utility::_id_562E(var_1._id_2FDA)) {
    var_1 _meth_8059(var_1.health + 1, self.origin);
    return;
  }

  var_2 = _id_0580::_id_8317(var_1.origin, self);
  var_1 thread _id_0547::_id_7D1A("tesla_shock", [var_2], 1.8);

  if(!isDefined(var_1)) {
    return;
  }
  wait 1.8;
  var_3 = var_1.health;
  var_1.soulcollectinvalid = 1;
  self notify("corpse_eater_feed_on_target", var_1);

  if(common_scripts\utility::_id_562E(var_1.isdarkhost))
    var_1 suicide();
  else if(!common_scripts\utility::_id_562E(var_1._id_2FDA) && !_id_0547::_id_5565(var_1._id_0A4B, "zombie_fireman"))
    var_1 maps\mp\mp_zombies_soul_collection::_id_865C("scripted_soul_eat", 0);

  if(!isDefined(self._id_5A36))
    self._id_5A36 = 0;

  self._id_5A36++;
  self.maxhealth = self.maxhealth + int(var_3 * 0.35);
  self.health = self.maxhealth;
  var_1 _meth_8059(var_1.health + 1, self.origin);
}

zombie_corpse_eater_on_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(var_2 >= self.health || _id_0547::_id_5731()) {
    if(isDefined(var_5) && (issubstr(var_5, "scythe_emp") || issubstr(var_5, "scythe_cleave_emp"))) {
      if(isDefined(self.poweredupfx))
        self.poweredupfx delete();
    } else if(should_detonate_on_players()) {
      if(!common_scripts\utility::_id_562E(self.detonating)) {
        self.detonating = 1;
        self.my_killer = var_1;
        self.my_killer_weapon = var_5;
        self.my_killer_smod = var_4;

        if(isDefined(self.my_killer) && isPlayer(self.my_killer)) {
          if(isDefined(self.my_killer_weapon) && issubstr(self.my_killer_weapon, "scythe"))
            self.my_killer thread maps\mp\mp_zombie_descent_ee_main::give_player_the_corpse_eater_spine();
        }

        thread _id_0547::_id_7D1A("corpse_eater_detonate");
      }
    } else {}
  }

  _id_054D::_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

zombie_corpse_eater_on_damaged_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  _id_054D::_id_6BD3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

try_detonation() {
  if(isDefined(self.poweredupfx))
    self.poweredupfx delete();

  if(should_detonate_on_players()) {
    var_0 = self gettagorigin("TAG_ORIGIN");
    playFX(level._effect["zmb_corpse_eater_detonate"], var_0);
    _id_0378::_id_8D74("aud_corpse_eater_explosion");
    level notify("ce_explosion", self.origin);
    var_1 = 240;
    var_2 = 200;
    var_3 = 80;

    if(_id_0547::is_solo() && common_scripts\utility::_id_562E(self.cenerfedexplosion))
      radiusdamage(self.origin, var_1, var_2 / 2, var_3 / 2, self, "MOD_EXPLOSIVE", "corpse_eater_dlc4_zm", 1);
    else
      radiusdamage(self.origin, var_1, var_2, var_3, self, "MOD_EXPLOSIVE", "corpse_eater_dlc4_zm", 1);
  }
}

get_ce_requirement() {
  return 5;
}

set_corpse_eater_full() {
  var_0 = self;
  var_0._id_5A36 = 5;
}

zombie_corpse_eater_passive() {
  self endon("zombie_passive");
  self endon("death");

  for(;;) {
    var_0 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("idle_noncombat");
    var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_0);
    self _meth_839C("anim deltas");
    self _meth_839B("face angle abs", self.angles);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_0, var_1, 1.0, "idle_anim");
  }
}