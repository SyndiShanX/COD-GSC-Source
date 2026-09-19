/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_bob.gsc
**************************************************/

init() {
  level._effect["zmb_ber_bob_front_smoke"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_front_smoke");
  level._effect["zmb_ber_bob_attack_smoke"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_attack_smoke");
  level._effect["zmb_ber_bob_ambient_smoke"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_ambient_smoke");
  level._effect["zmb_ber_bob_engine_glow"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_engine_glow");
  level._effect["zmb_ber_bob_crank_glow"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_crank_glow");
  level._effect["zmb_ber_bolt_stick_leg"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bolt_stick_leg");
  level._effect["zmb_ber_bolt_stick_side"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bolt_stick_side");
  level._effect["zmb_ber_bolt_stick_head"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bolt_stick_head");
  level._effect["zmb_ber_bob_charge_bolt"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_charge_bolt");
  level._effect["zmb_ber_bob_smk_cloud_5s"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_smk_cloud_5s");
  level._effect["zmb_ber_bob_smk_cloud_lp"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_smk_cloud_lp");
  level._effect["zmb_ber_bob_smk_electrify"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_smk_electrify");
  level._effect["zmb_ber_bob_smk_dmg"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_smk_dmg");
  level._effect["zmb_bob_metalhit_1"] = loadfx("vfx/weaponimpact/zmb_bob_metalhit_1");
  level._effect["zmb_ber_bob_beam_wv"] = loadfx("vfx/muzzleflash/zmb_ber_bob_beam_wv");
  maps\mp\agents\_scripted_agent_anim_util::_id_5159("zombie_bob");
  level._id_0A41["zombie_bob"] = level._id_0A41["zombie"];
  level._id_0A41["zombie_bob"]["think"] = ::zombie_bob_think;
  level._id_0A41["zombie_bob"]["move_mode"] = ::zombie_bob_move_mode_func;
  level._id_0A41["zombie_bob"]["on_damaged_finished"] = ::zombie_bob_on_damaged_finished;
  level._id_0A41["zombie_bob"]["on_damaged"] = ::zombie_bob_on_damaged;
  level._id_0A41["zombie_bob"]["tesla_delayed_dmg"] = ::zombie_bob_tesla_delayed_dmg;
  var_0 = spawnStruct();
  var_0._id_0A4B = "zombie_bob";
  var_0._id_0EAE = "zombie_bob_animclass";
  var_0._id_0E88 = "zombie_bob";
  var_0._id_0879 = "zombie_bob";
  var_0._id_4C12 = 1;
  var_0.overridehealth = int(bob_health_scale_per_num_players() * 32000);
  var_0._id_60E2 = 65;
  var_0._id_8302 = 85;
  var_0._id_8303 = 15;
  var_0.parenttype = "zombie_generic";
  var_0.tacklebymelee = 0;
  var_0.tacklebycharge = 0;
  var_0.knockbyravensword = 0;
  var_0.shockbyteslablood = 0;
  var_0._id_5ED2["bob"]["whole_body"] = "zom_bob";
  _id_0547::_id_0A52(var_0, "zombie_bob");
  _id_0541::_id_2F92("crawl", ["zombie_bob"]);
  _id_0547::_id_7BD0("zombie_bob_charge", _id_0547::zombie_charge_run, undefined, 6, _id_0547::zombie_charge_cleanup);
  _id_0547::_id_7BD0("zombie_bob_infect", ::zombie_bob_infect_zombies, undefined, 6, ::zombie_bob_infect_cleanup);
  _id_0547::_id_7BD0("zombie_bob_smoke", ::zombie_bob_smoke_atk, undefined, 6, ::zombie_bob_smoke_atk_cleanup);
  init_bob_phase_handler();
}

bob_health_scale_per_num_players() {
  var_0 = 1.0;

  switch (level.players.size) {
    case 1:
      var_0 = 1.0;
      break;
    case 2:
      var_0 = 1.75;
      break;
    case 3:
      var_0 = 2.0;
      break;
    case 4:
      var_0 = 2.5;
      break;
    default:
      var_0 = 1.0;
      break;
  }

  return var_0;
}

init_bob_health() {
  self.health = int(bob_health_scale_per_num_players() * 32000);
  self.phase2health = int(self.health * 0.6);
  self.phase3health = int(self.health * 0.3);
  var_0 = _id_0547::_id_0A51(self._id_0A4B);
  var_0.overridehealth = self.health;
}

init_bob_phase_handler() {
  var_0 = spawnStruct();
  var_0._id_3F02 = _id_0547::_id_4B2C;
  var_0.value = 0;
  register_bob_phase("bob_punch", "bob_sizzle", ::zombie_bob_punch_think, [], ["bob_was_koed"], [var_0]);
  register_bob_phase("bob_sizzle", "bob_smoke", ::zombie_bob_sizzle_think, [], ["bob_was_koed"], [var_0]);
  register_bob_phase("bob_smoke", "bob_smoke", ::zombie_bob_smoke_think, [], undefined, [var_0]);
}

register_bob_phase(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.zmb_bob_agent_phases))
    level.zmb_bob_agent_phases = [];

  var_6 = spawnStruct();
  var_6.name = var_0;
  var_6.next_phase = var_1;
  var_6.func_and_data = common_scripts\utility::_id_0F73([var_2], var_3);
  var_6.reasons_to_skip = var_4;
  var_6.reasons_to_block_progress = var_5;
  level.zmb_bob_agent_phases[var_6.name] = var_6;
}

zombie_bob_think_setup() {
  thread _id_0566::_id_ABB5();
  self._id_78D7 = 0;
  self._id_6099 = 150;
  self._id_5542 = 0;
  self._id_55AB = 1;
  self._id_57E8 = 1;
  self.zmdemigod = 1;
  self._id_6816 = 1;
  self.nomutilate = 1;
  self.nopairmelee = 1;
  self._id_15E1 = 1;
  self._id_57FD = 1;
  self.isteslastunimmune = 1;
  self _meth_84D4();
}

zombie_bob_should_charge() {
  var_0 = self._id_00E6;

  if(!isalive(self._id_00E6)) {
    self._id_78D7 = 0;
    level._id_5B1B = gettime();
    return 0;
  }

  if(self._id_78D7 >= self._id_6099 && isPlayer(var_0) && _issentient(var_0) && self agentcanseesentient(var_0) && _id_0547::_id_1F5B(self.origin, var_0.origin) && common_scripts\utility::_id_0F79(_id_053C::_id_4F88(), var_0) && (!isDefined(self._id_3043) || !maps\mp\agents\humanoid\_humanoid_util::_id_8BAE()) && !isDefined(self._id_1927) && (!_id_053C::_id_5686() || !common_scripts\utility::_id_0F79(self._id_983C, var_0)) && (!isDefined(level._id_5B1B) || gettime() - level._id_5B1B > 10000) && !common_scripts\utility::_id_562E(self._id_57C0))
    return 1;

  return 0;
}

zombie_bob_is_charging() {
  return self._id_5542;
}

zombie_bob_charge_cooldown_wait() {
  if(zombie_bob_is_charging())
    return 1;

  if(isDefined(self.waiting_for_charge_end) && !zombie_bob_is_charging()) {
    self.waiting_for_charge_end = undefined;
    self.last_charge_end_time = gettime();
    self._id_78D7 = 0;
    return 1;
  } else if(isDefined(self.last_charge_end_time)) {
    if(gettime() - self.last_charge_end_time < 1500.0)
      return 1;
    else
      self.last_charge_end_time = undefined;
  }

  return 0;
}

zombie_bob_do_charge() {
  zombie_bob_charge_request(self._id_00E6);
  _id_0378::_id_8D74("aud_bob_engine", "bob_engine_rev");
  level._id_5B1B = gettime();
  self.waiting_for_charge_end = 1;
}

zombie_bob_punch_think() {
  if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2())
    return 0;

  self.enterednewphase = undefined;

  if(zombie_bob_charge_cooldown_wait())
    return 0;

  if(self.health <= self.phase2health || common_scripts\utility::_id_3794("FORCE_bob_sizzle") || common_scripts\utility::_id_3794("FORCE_bob_smoke")) {
    self.health = self.phase2health;
    self notify("bob_stop_engine_pulse");
    return 1;
  }

  if(zombie_bob_should_charge())
    zombie_bob_do_charge();

  return 0;
}

zombie_bob_sizzle_think() {
  if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2())
    return 0;

  if(zombie_bob_charge_cooldown_wait())
    return 0;

  if(self.health <= self.phase3health || common_scripts\utility::_id_3794("FORCE_bob_smoke")) {
    self.health = self.phase3health;
    self notify("bob_stop_engine_pulse");
    return 1;
  }

  var_0 = 15;

  if(isDefined(self.enterednewphase)) {
    _id_0378::_id_8D74("aud_bob_stab_leg");
    var_1 = "bob_stand_powerup";
    var_2 = self[[maps\mp\agents\_agent_utility::_id_0A59("get_action_params")]]();
    var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_087C(var_1, var_2);
    maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_3, 1, 0, undefined, 1);
    self.nextsizzletime = gettime() + var_0 * 1000;
    self.enterednewphase = undefined;
  }

  if(zombie_bob_should_charge())
    zombie_bob_do_charge();

  if(isDefined(self.nextsizzletime) && gettime() < self.nextsizzletime)
    return 0;

  self.nextsizzletime = gettime() + var_0 * 1000;
  self.zombie_limit_damage = int(bob_health_scale_per_num_players() * 1500);
  _id_0547::_id_7D1A("zombie_bob_infect", undefined, 0.5);
  return 0;
}

zombie_bob_actually_die() {
  wait 14.4;
  self._id_2A9D = "death_final_pose";
  zombie_bob_is_dead();
}

zombie_bob_smoke_think() {
  if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2())
    return 0;

  if(zombie_bob_charge_cooldown_wait())
    return 0;

  if(self.health <= 1) {
    _id_0378::_id_8D74("aud_bob_engine", "bob_killed");
    level notify("bob_stop_smoke");
    thread zombie_bob_actually_die();
    var_0 = "death_full_body_stand";
    var_1 = self[[maps\mp\agents\_agent_utility::_id_0A59("get_action_params")]]();
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_087C(var_0, var_1);
    maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_2, undefined, 0, undefined, 1);
    return 1;
  }

  var_3 = 30;

  if(isDefined(self.enterednewphase)) {
    _id_0378::_id_8D74("aud_bob_stab_leg");
    var_0 = "bob_stand_powerup";
    var_1 = self[[maps\mp\agents\_agent_utility::_id_0A59("get_action_params")]]();
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_087C(var_0, var_1);
    maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_2, 2, 0, undefined, 1);
    self.nextsmoketime = gettime() + var_3 * 1000;
    self.enterednewphase = undefined;
  }

  if(zombie_bob_should_charge())
    zombie_bob_do_charge();

  if(isDefined(self.nextsmoketime) && gettime() < self.nextsmoketime) {
    zombie_bob_phase_3_try_sizzle();
    return 0;
  }

  if(isDefined(self.nextsmoketime) && gettime() >= self.nextsmoketime) {
    self.nextsmoketime = gettime() + var_3 * 1000;
    _id_0547::_id_7D1A("zombie_bob_smoke", undefined, 0.5);
    return 0;
  }
}

zombie_bob_phase_3_try_sizzle() {
  var_0 = 30;

  if(isDefined(self.nextsizzletime) && gettime() < self.nextsizzletime)
    return 0;

  self.nextsizzletime = gettime() + var_0 * 1000;
  self.zombie_limit_damage = int(bob_health_scale_per_num_players() * 1500);
  _id_0547::_id_7D1A("zombie_bob_infect", undefined, 0.5);
  return 0;
}

zombie_bob_is_dead() {
  if(isDefined(self.engine_pulse)) {
    self.engine_pulse delete();
    self.engine_pulse = undefined;
  }

  if(isDefined(self.crank_pulse)) {
    self.crank_pulse delete();
    self.crank_pulse = undefined;
  }

  self notify("bob_stop_engine_pulse");
  self.zmdemigod = 0;
  self.zombie_bob_can_take_damage = 1;
  self.smoke_damage = 1;
  self.zombie_limit_damage = undefined;
  self dodamage(1, (0, 0, 0), undefined, undefined, undefined, "wunderbuss_zm");
  common_scripts\utility::_id_3799("bob_was_koed");
  common_scripts\utility::_id_379A("bob_was_koed");
}

zombie_bob_think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  self _meth_85A1("zombie_bob");
  common_scripts\utility::_id_3799("bob_punch");
  common_scripts\utility::_id_3799("bob_sizzle");
  common_scripts\utility::_id_3799("bob_smoke");
  common_scripts\utility::_id_3799("FORCE_bob_sizzle");
  common_scripts\utility::_id_3799("FORCE_bob_smoke");
  common_scripts\utility::_id_3799("bob_was_koed");
  self.zombie_bob_can_take_damage = 0;
  init_bob_health();
  thread zombie_bob_think_setup();
  set_bob_phase("bob_punch");
  _id_0547::_id_86C8(100);
  _id_0547::_id_86C7(100);

  for(;;) {
    wait 0.2;

    if(common_scripts\utility::_id_3794("bob_was_koed")) {
      continue;
    }
    run_bob_phase_logic();

    if(!self._id_5542 && _id_053C::_id_4F8C()) {
      continue;
    }
    if(common_scripts\utility::_id_562E(self._id_57C0)) {
      continue;
    }
    if(self._id_5542)
      _id_0547::zombie_charge_cleanup(self._id_645E);

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

run_bob_phase_logic() {
  foreach(var_1 in level.zmb_bob_agent_phases) {
    if(common_scripts\utility::_id_3794(var_1.name))
      bob_phase_handler(var_1);
  }
}

bob_has_excuse_to_skip(var_0) {
  if(!isDefined(var_0.reasons_to_skip))
    return 0;

  foreach(var_2 in var_0.reasons_to_skip) {
    if(common_scripts\utility::_id_3794(var_2))
      return 1;
  }

  return 0;
}

bob_phase_handler(var_0) {
  var_1 = bob_has_excuse_to_skip(var_0);

  if(!var_1) {
    foreach(var_3 in var_0.reasons_to_block_progress) {
      if(self[[var_3._id_3F02]]() == var_3.value)
        return;
    }

    var_1 = common_scripts\utility::makeentitysentient(var_0.func_and_data);
  }

  if(var_1) {
    if(_id_0547::_id_5565(self.lastweapondamage, "throwingknife_zm"))
      level notify("rebel_set_4_complete");

    self.zombie_bob_can_take_damage = 0;
    set_bob_phase(var_0.next_phase);
  }
}

set_bob_phase(var_0) {
  foreach(var_2 in level.zmb_bob_agent_phases)
  common_scripts\utility::_id_3796(var_2.name);

  common_scripts\utility::_id_379A(var_0);
  _id_0378::_id_8D74("aud_bob_engine", var_0);
  self.enterednewphase = 1;
}

zombie_bob_print_delayed_health() {
  _iprintlnbold("health: " + self.health);
}

zombie_bob_tesla_delayed_dmg(var_0, var_1, var_2) {
  return var_0;
}

zombie_bob_on_damaged_finished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!self.zombie_bob_can_take_damage && !isDefined(self.smoke_damage)) {
    return;
  }
  if(isDefined(self.zombie_limit_damage)) {
    self.zombie_limit_damage = self.zombie_limit_damage - var_2;

    if(self.zombie_limit_damage < 0) {
      self.zombie_bob_can_take_damage = 0;
      var_2 = var_2 + self.zombie_limit_damage;
      self.zombie_limit_damage = 0;
    }
  }

  var_11 = 0;

  if(common_scripts\utility::_id_3794("bob_punch"))
    var_11 = self.phase2health;

  if(common_scripts\utility::_id_3794("bob_sizzle"))
    var_11 = self.phase3health;

  if(self.health - var_2 < var_11)
    var_2 = self.health - var_11;

  if(var_2 == 0) {
    return;
  }
  _id_054D::_id_6BD3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

zombie_bob_on_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  self.lastweapondamage = var_5;

  if(common_scripts\utility::_id_3794("bob_was_koed")) {
    return;
  }
  if(self._id_78D7 < self._id_6099)
    self._id_78D7 = self._id_78D7 + var_2;

  self._id_00E6 = var_1;

  if(!self.zombie_bob_can_take_damage && !isDefined(self.smoke_damage)) {
    return;
  }
  if(common_scripts\utility::_id_3794("bob_smoke") && !isDefined(self.smoke_damage)) {
    return;
  }
  if(var_5 != "wunderbuss_zm") {
    var_11 = self gettagorigin("engine");

    if(distancesquared(var_11, var_6) > 256)
      return;
  }

  if(common_scripts\utility::_id_3794("bob_smoke") && var_5 != "wunderbuss_zm") {
    return;
  }
  _playfxontag(level._effect["zmb_bob_metalhit_1"], self, "Engine");
  _id_054D::_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

zombie_bob_move_mode_func() {
  return "walk";
}

zombie_bob_infect_zombies() {
  thread zombie_bob_make_sizzlers();
  var_0 = "bob_stand_infect";
  var_1 = self[[maps\mp\agents\_agent_utility::_id_0A59("get_action_params")]]();
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_087C(var_0, var_1);
  maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_2, undefined, 0, undefined, 1);
}

zombie_bob_infect_cleanup() {}

zombie_bob_smoke_atk_monitor_health() {
  self endon("bob_stop_engine_pulse");

  for(;;) {
    if(self.health <= 1)
      self notify("bob_stop_engine_pulse");

    waitframe();
  }
}

zombie_bob_smoke_atk_cloud_damage(var_0) {
  level endon("bob_stop_smoke");

  for(var_1 = 25; var_1 > 0; var_1 = var_1 - 0.05) {
    foreach(var_3 in level.players) {
      if(_distance2d(var_3.origin, var_0) < 120)
        var_3 dodamage(1, var_0);
    }

    waitframe();
  }
}

zombie_bob_smoke_listen_for_damage(var_0, var_1) {
  self endon("stop_damage_listen");
  var_0 endon("death");

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
    playFX(level._effect["zmb_ber_bob_smk_electrify"], var_1);

    if(_distance2d(var_0.origin, var_1) < 144.0) {
      _playfxontag(level._effect["zmb_ber_bob_smk_dmg"], var_0, "Engine");
      var_0.smoke_damage = 1;
      var_0 zombie_bob_on_damaged(self, var_3, var_2, var_10, var_6, var_11, var_5, var_4, var_8, 0, var_9);
      var_0.smoke_damage = undefined;
    }
  }
}

zombie_bob_smoke_atk_spawn_hit_volumes(var_0, var_1) {
  var_2 = 2;
  wait(var_2);
  var_3 = _getent("bob_smoke_collision", "targetname");
  var_4 = undefined;

  if(isDefined(var_3)) {
    var_4 = spawn("script_model", var_1);

    if(isDefined(var_4))
      var_4 clonebrushmodeltoscriptmodel(var_3);
  }

  var_5 = _getent("bob_smoke_trigger_damage", "targetname");
  var_6 = undefined;

  if(isDefined(var_5)) {
    var_6 = var_5.origin;
    var_5 childthread zombie_bob_smoke_listen_for_damage(var_0, var_1);
    var_5.origin = var_1;
  }

  level common_scripts\utility::waittill_notify_or_timeout("bob_stop_smoke", 25);

  if(isDefined(var_4))
    var_4 delete();

  if(isDefined(var_6)) {
    var_5 notify("stop_damage_listen");
    var_5.origin = var_6;
  }
}

zombie_bob_smoke_atk_spawn_cloud(var_0) {
  var_0 _id_0378::_id_8D74("aud_bob_engine", "bob_engine_rev");
  var_0 _id_0378::_id_8D74("aud_bob_smoke_attack_strt");
  wait 2;
  var_1 = anglesToForward(var_0.angles);
  var_2 = anglestoup(var_0.angles);
  var_3 = var_0.origin;
  var_4 = _spawnfx(level._effect["zmb_ber_bob_smk_cloud_lp"], var_3, var_1, var_2);
  _id_0378::_id_8D74("aud_bob_smoke_attack_loop", 25, var_3);
  _triggerfx(var_4);
  thread zombie_bob_smoke_atk_cloud_damage(var_3);
  thread zombie_bob_smoke_atk_spawn_hit_volumes(var_0, var_3);
  level common_scripts\utility::waittill_notify_or_timeout("bob_stop_smoke", 25);
  var_4 delete();
}

zombie_bob_smoke_atk() {
  level thread zombie_bob_smoke_atk_spawn_cloud(self);
  self.zombie_limit_damage = int(bob_health_scale_per_num_players() * 1500);
  var_0 = "bob_stand_engine_area";
  var_1 = self[[maps\mp\agents\_agent_utility::_id_0A59("get_action_params")]]();
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_087C(var_0, var_1);
  maps\mp\agents\humanoid\_humanoid_util::getcurrentoffhand(self.origin, self.angles, var_2, undefined, 0, undefined, 1);
}

zombie_bob_smoke_atk_cleanup() {}

zombie_bob_make_sizzlers() {
  if(common_scripts\utility::_id_3794("bob_sizzle"))
    thread zombie_bob_engine_pulse();

  wait 1.8;
  var_0 = _id_0547::_id_4090("zombie_generic");
  var_1 = _sortbydistance(var_0, self.origin);
  var_2 = maps\mp\zombies\zombie_sizzler::noofsizzlerscanspawn();

  for(var_3 = int(3.33333); var_3; var_3 = var_3 - 1) {
    var_4 = undefined;
    var_5 = self gettagorigin("TAG_FX_GUN");
    var_6 = self gettagangles("TAG_FX_GUN");
    var_7 = (0, var_6[1], 0);
    var_8 = anglesToForward(var_7);

    foreach(var_10 in var_1) {
      if(!var_2) {
        continue;
      }
      if(!isDefined(var_10) || !isalive(var_10)) {
        continue;
      }
      if(common_scripts\utility::_id_562E(var_10.transformingtosizzler)) {
        continue;
      }
      var_11 = var_10 _meth_85A5();

      if(var_11 == "zombie_animclass" && var_2) {
        var_12 = var_10.origin - var_5;
        var_12 = (var_12[0], var_12[1], 0);
        var_12 = vectorNormalize(var_12);

        if(vectordot(var_12, var_8) < 0.94) {
          continue;
        }
        var_13 = -1 * var_12;
        var_10 thread maps\mp\zombies\zombie_sizzler::zombie_make_sizzler(var_13);
        var_14 = (0, 0, 40);
        var_4 = playFX(level._effect["zmb_ber_bob_beam_wv"], var_5, var_10.origin + var_14 - var_5);
        _id_0378::_id_8D74("aud_bob_shoot_gun", var_5);
        var_2--;
      }
    }

    if(!isDefined(var_4)) {
      var_16 = 400;
      var_17 = (0, 0, -1000);
      var_18 = bulletTrace(var_5, var_5 + var_8 * var_16 + var_17, 1, self);
      var_4 = _playfxontag(level._effect["zmb_ber_bob_beam_wv"], self, "TAG_FX_GUN");
      _id_0378::_id_8D74("aud_bob_shoot_gun", var_5);
    }

    waitframe();
  }

  if(common_scripts\utility::_id_3794("bob_sizzle"))
    self notify("bob_stop_engine_pulse");
}

zombie_bob_kill_fx_on_death(var_0) {
  var_0 endon("death");
  self waittill("death");
  var_0 delete();
}

zombie_bob_engine_pulse() {
  self endon("death");

  if(common_scripts\utility::_id_3794("bob_was_koed")) {
    return;
  }
  self.engine_pulse = _spawnlinkedfx(level._effect["zmb_ber_bob_engine_glow"], self, "engine");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.engine_pulse);
  self.crank_pulse = _spawnlinkedfx(level._effect["zmb_ber_bob_crank_glow"], self, "engineCrank");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.crank_pulse);
  self.zombie_bob_can_take_damage = 1;
  _triggerfx(self.engine_pulse);
  _triggerfx(self.crank_pulse);
  self waittill("bob_stop_engine_pulse");

  if(isDefined(self.engine_pulse))
    self.engine_pulse delete();

  if(isDefined(self.crank_pulse))
    self.crank_pulse delete();

  wait 3.5;
  self.zombie_bob_can_take_damage = 0;
}

zombie_bob_engine_smk_ambient() {
  self endon("death");

  if(common_scripts\utility::_id_3794("bob_was_koed")) {
    return;
  }
  waitframe();
  waitframe();
  self.engine_smoke_exhaust = _spawnlinkedfx(level._effect["zmb_ber_bob_ambient_smoke"], self, "engine");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.engine_smoke_exhaust);
  self.engine_smoke = _spawnlinkedfx(level._effect["zmb_ber_bob_front_smoke"], self, "engine");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.engine_smoke);
  _triggerfx(self.engine_smoke_exhaust);
  _triggerfx(self.engine_smoke);
}

zombie_bob_charge_request(var_0) {
  var_1 = spawnStruct();
  var_1.player = var_0;
  var_1._id_7462 = var_0.origin;
  var_1.end_notify = "bob_end_charge";
  var_1.scripted_state = "zombie_bob_charge";
  var_1.stop_run_state_name = "s2_bob_stop_sprint";
  var_1.react_state_name = "s2_bob_roar";
  var_1.run_state_name = "s2_bob_sprint";
  var_1.react_anim_rate = 1;
  var_1.extra_lunge_radius = 100;
  var_1.trigger_lerp_deg = 25;
  var_1.trigger_nolerp_deg = 50;
  var_1._id_9DAA = 200;
  var_1.turn_smoothing_thread = _id_0547::zombie_charge_turn_smoothing_thread;
  var_1.initial_turn_deg = 200;
  var_1.initial_turn_secs = 0.1;
  var_1.initial_turn_speed = 0.169;
  var_1._id_2434 = 37;
  var_1._id_60C1 = 55;
  var_1._id_3A20 = 82;
  var_1._id_1B70 = 160;
  var_1.tackleplayers = 1;
  var_1.far_dist_p = 60;
  var_1.box_height_p = 60;
  var_1.tackle_dmg_p = 80;

  if(!_id_0547::has_scripted_state_queued("zombie_bob_charge"))
    thread _id_0547::_id_7D1A("zombie_bob_charge", [var_1], 0.5);

  childthread make_vulnerable_while_stage1_charge_roar();
}

make_vulnerable_while_stage1_charge_roar() {
  if(!common_scripts\utility::_id_3794("bob_punch")) {
    return;
  }
  waitframe();
  self.zombie_limit_damage = int(bob_health_scale_per_num_players() * 1500);
  thread zombie_bob_engine_pulse();
  var_0 = gettime() / 1000;

  if(isDefined(self.end_roar_secs) && self.end_roar_secs > var_0)
    wait(self.end_roar_secs - var_0);

  self notify("bob_stop_engine_pulse");
}