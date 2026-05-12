/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_bob.gsc
*********************************************/

func_00D5() {
  level.var_611["zmb_ber_bob_front_smoke"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_front_smoke");
  level.var_611["zmb_ber_bob_attack_smoke"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_attack_smoke");
  level.var_611["zmb_ber_bob_ambient_smoke"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_ambient_smoke");
  level.var_611["zmb_ber_bob_engine_glow"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_engine_glow");
  level.var_611["zmb_ber_bob_crank_glow"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_crank_glow");
  level.var_611["zmb_ber_bolt_stick_leg"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bolt_stick_leg");
  level.var_611["zmb_ber_bolt_stick_side"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bolt_stick_side");
  level.var_611["zmb_ber_bolt_stick_head"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bolt_stick_head");
  level.var_611["zmb_ber_bob_charge_bolt"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_charge_bolt");
  level.var_611["zmb_ber_bob_smk_cloud_5s"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_smk_cloud_5s");
  level.var_611["zmb_ber_bob_smk_cloud_lp"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_smk_cloud_lp");
  level.var_611["zmb_ber_bob_smk_electrify"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_smk_electrify");
  level.var_611["zmb_ber_bob_smk_dmg"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_bob_smk_dmg");
  level.var_611["zmb_bob_metalhit_1"] = loadfx("vfx/weaponimpact/zmb_bob_metalhit_1");
  level.var_611["zmb_ber_bob_beam_wv"] = loadfx("vfx/muzzleflash/zmb_ber_bob_beam_wv");
  maps\mp\agents\_scripted_agent_anim_util::func_5159("zombie_bob");
  level.var_A41["zombie_bob"] = level.var_A41["zombie"];
  level.var_A41["zombie_bob"]["think"] = ::zombie_bob_think;
  level.var_A41["zombie_bob"]["move_mode"] = ::zombie_bob_move_mode_func;
  level.var_A41["zombie_bob"]["on_damaged_finished"] = ::zombie_bob_on_damaged_finished;
  level.var_A41["zombie_bob"]["on_damaged"] = ::zombie_bob_on_damaged;
  level.var_A41["zombie_bob"]["tesla_delayed_dmg"] = ::zombie_bob_tesla_delayed_dmg;
  var_00 = spawnStruct();
  var_00.var_A4B = "zombie_bob";
  var_00.var_EAE = "zombie_bob_animclass";
  var_00.var_E88 = "zombie_bob";
  var_00.var_879 = "zombie_bob";
  var_00.var_4C12 = 1;
  var_00.overridehealth = int(bob_health_scale_per_num_players() * 32000);
  var_00.var_60E2 = 65;
  var_00.var_8302 = 85;
  var_00.var_8303 = 15;
  var_00.parenttype = "zombie_generic";
  var_00.tacklebymelee = 0;
  var_00.tacklebycharge = 0;
  var_00.knockbyravensword = 0;
  var_00.shockbyteslablood = 0;
  var_00.var_5ED2["bob"]["whole_body"] = "zom_bob";
  lib_0547::func_A52(var_00, "zombie_bob");
  lib_0541::func_2F92("crawl", ["zombie_bob"]);
  lib_0547::func_7BD0("zombie_bob_charge", ::lib_0547::zombie_charge_run, undefined, 6, ::lib_0547::zombie_charge_cleanup);
  lib_0547::func_7BD0("zombie_bob_infect", ::zombie_bob_infect_zombies, undefined, 6, ::zombie_bob_infect_cleanup);
  lib_0547::func_7BD0("zombie_bob_smoke", ::zombie_bob_smoke_atk, undefined, 6, ::zombie_bob_smoke_atk_cleanup);
  init_bob_phase_handler();
}

bob_health_scale_per_num_players() {
  var_00 = 1;
  switch (level.var_744A.size) {
    case 1:
      var_00 = 1;
      break;

    case 2:
      var_00 = 1.75;
      break;

    case 3:
      var_00 = 2;
      break;

    case 4:
      var_00 = 2.5;
      break;

    default:
      var_00 = 1;
      break;
  }

  return var_00;
}

init_bob_health() {
  self.var_BC = int(bob_health_scale_per_num_players() * 32000);
  self.phase2health = int(self.var_BC * 0.6);
  self.phase3health = int(self.var_BC * 0.3);
  var_00 = lib_0547::func_A51(self.var_A4B);
  var_00.overridehealth = self.var_BC;
}

init_bob_phase_handler() {
  var_00 = spawnStruct();
  var_00.var_3F02 = ::lib_0547::func_4B2C;
  var_00.var_A281 = 0;
  register_bob_phase("bob_punch", "bob_sizzle", ::zombie_bob_punch_think, [], ["bob_was_koed"], [var_00]);
  register_bob_phase("bob_sizzle", "bob_smoke", ::zombie_bob_sizzle_think, [], ["bob_was_koed"], [var_00]);
  register_bob_phase("bob_smoke", "bob_smoke", ::zombie_bob_smoke_think, [], undefined, [var_00]);
}

register_bob_phase(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(level.zmb_bob_agent_phases)) {
    level.zmb_bob_agent_phases = [];
  }

  var_06 = spawnStruct();
  var_06.var_109 = param_00;
  var_06.next_phase = param_01;
  var_06.func_and_data = common_scripts\utility::func_F73([param_02], param_03);
  var_06.reasons_to_skip = param_04;
  var_06.reasons_to_block_progress = param_05;
  level.zmb_bob_agent_phases[var_06.var_109] = var_06;
}

zombie_bob_think_setup() {
  thread lib_0566::func_ABB5();
  self.var_78D7 = 0;
  self.var_6099 = 150;
  self.var_5542 = 0;
  self.var_55AB = 1;
  self.var_57E8 = 1;
  self.zmdemigod = 1;
  self.var_6816 = 1;
  self.nomutilate = 1;
  self.nopairmelee = 1;
  self.var_15E1 = 1;
  self.var_57FD = 1;
  self.isteslastunimmune = 1;
  self method_84D4();
}

zombie_bob_should_charge() {
  var_00 = self.var_E6;
  if(!isalive(self.var_E6)) {
    self.var_78D7 = 0;
    level.var_5B1B = gettime();
    return 0;
  }

  if(self.var_78D7 >= self.var_6099 && isPlayer(var_00) && issentient(var_00) && self agentcanseesentient(var_00) && lib_0547::func_1F5B(self.var_116, var_00.var_116) && common_scripts\utility::func_F79(lib_053C::func_4F88(), var_00) && (!isDefined(self.var_3043) || !maps\mp\agents\humanoid\_humanoid_util::func_8BAE()) && !isDefined(self.var_1927) && (!lib_053C::func_5686() || !common_scripts\utility::func_F79(self.var_983C, var_00)) && (!isDefined(level.var_5B1B) || gettime() - level.var_5B1B > 10000) && !common_scripts\utility::func_562E(self.var_57C0)) {
    return 1;
  }

  return 0;
}

zombie_bob_is_charging() {
  return self.var_5542;
}

zombie_bob_charge_cooldown_wait() {
  if(zombie_bob_is_charging()) {
    return 1;
  }

  if(isDefined(self.waiting_for_charge_end) && !zombie_bob_is_charging()) {
    self.waiting_for_charge_end = undefined;
    self.last_charge_end_time = gettime();
    self.var_78D7 = 0;
    return 1;
  } else if(isDefined(self.last_charge_end_time)) {
    if(gettime() - self.last_charge_end_time < 1500) {
      return 1;
    } else {
      self.last_charge_end_time = undefined;
    }
  }

  return 0;
}

zombie_bob_do_charge() {
  zombie_bob_charge_request(self.var_E6);
  lib_0378::func_8D74("aud_bob_engine", "bob_engine_rev");
  level.var_5B1B = gettime();
  self.waiting_for_charge_end = 1;
}

zombie_bob_punch_think() {
  if(maps\mp\agents\_scripted_agent_anim_util::func_57E2()) {
    return 0;
  }

  self.enterednewphase = undefined;
  if(zombie_bob_charge_cooldown_wait()) {
    return 0;
  }

  if(self.var_BC <= self.phase2health || common_scripts\utility::func_3794("FORCE_bob_sizzle") || common_scripts\utility::func_3794("FORCE_bob_smoke")) {
    self.var_BC = self.phase2health;
    self notify("bob_stop_engine_pulse");
    return 1;
  }

  if(zombie_bob_should_charge()) {
    zombie_bob_do_charge();
  }

  return 0;
}

zombie_bob_sizzle_think() {
  if(maps\mp\agents\_scripted_agent_anim_util::func_57E2()) {
    return 0;
  }

  if(zombie_bob_charge_cooldown_wait()) {
    return 0;
  }

  if(self.var_BC <= self.phase3health || common_scripts\utility::func_3794("FORCE_bob_smoke")) {
    self.var_BC = self.phase3health;
    self notify("bob_stop_engine_pulse");
    return 1;
  }

  var_00 = 15;
  if(isDefined(self.enterednewphase)) {
    lib_0378::func_8D74("aud_bob_stab_leg");
    var_01 = "bob_stand_powerup";
    var_02 = self[[maps\mp\agents\_agent_utility::func_A59("get_action_params")]]();
    var_03 = maps\mp\agents\_scripted_agent_anim_util::func_87C(var_01, var_02);
    maps\mp\agents\humanoid\_humanoid_util::func_8318(self.var_116, self.var_1D, var_03, 1, 0, undefined, 1);
    self.nextsizzletime = gettime() + var_00 * 1000;
    self.enterednewphase = undefined;
  }

  if(zombie_bob_should_charge()) {
    zombie_bob_do_charge();
  }

  if(isDefined(self.nextsizzletime) && gettime() < self.nextsizzletime) {
    return 0;
  }

  self.nextsizzletime = gettime() + var_00 * 1000;
  self.zombie_limit_damage = int(bob_health_scale_per_num_players() * 1500);
  lib_0547::func_7D1A("zombie_bob_infect", undefined, 0.5);
  return 0;
}

zombie_bob_actually_die() {
  wait(14.4);
  self.var_2A9D = "death_final_pose";
  zombie_bob_is_dead();
}

zombie_bob_smoke_think() {
  if(maps\mp\agents\_scripted_agent_anim_util::func_57E2()) {
    return 0;
  }

  if(zombie_bob_charge_cooldown_wait()) {
    return 0;
  }

  if(self.var_BC <= 1) {
    lib_0378::func_8D74("aud_bob_engine", "bob_killed");
    level notify("bob_stop_smoke");
    thread zombie_bob_actually_die();
    var_00 = "death_full_body_stand";
    var_01 = self[[maps\mp\agents\_agent_utility::func_A59("get_action_params")]]();
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_87C(var_00, var_01);
    maps\mp\agents\humanoid\_humanoid_util::func_8318(self.var_116, self.var_1D, var_02, undefined, 0, undefined, 1);
    return 1;
  }

  var_03 = 30;
  if(isDefined(self.enterednewphase)) {
    lib_0378::func_8D74("aud_bob_stab_leg");
    var_00 = "bob_stand_powerup";
    var_01 = self[[maps\mp\agents\_agent_utility::func_A59("get_action_params")]]();
    var_02 = maps\mp\agents\_scripted_agent_anim_util::func_87C(var_02, var_03);
    maps\mp\agents\humanoid\_humanoid_util::func_8318(self.var_116, self.var_1D, var_03, 2, 0, undefined, 1);
    self.nextsmoketime = gettime() + var_00 * 1000;
    self.enterednewphase = undefined;
  }

  if(zombie_bob_should_charge()) {
    zombie_bob_do_charge();
  }

  if(isDefined(self.nextsmoketime) && gettime() < self.nextsmoketime) {
    zombie_bob_phase_3_try_sizzle();
    return 0;
  }

  if(isDefined(self.nextsmoketime) && gettime() >= self.nextsmoketime) {
    self.nextsmoketime = gettime() + var_03 * 1000;
    lib_0547::func_7D1A("zombie_bob_smoke", undefined, 0.5);
    return 0;
  }
}

zombie_bob_phase_3_try_sizzle() {
  var_00 = 30;
  if(isDefined(self.nextsizzletime) && gettime() < self.nextsizzletime) {
    return 0;
  }

  self.nextsizzletime = gettime() + var_00 * 1000;
  self.zombie_limit_damage = int(bob_health_scale_per_num_players() * 1500);
  lib_0547::func_7D1A("zombie_bob_infect", undefined, 0.5);
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
  common_scripts\utility::func_3799("bob_was_koed");
  common_scripts\utility::func_379A("bob_was_koed");
}

zombie_bob_think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  self method_85A1("zombie_bob");
  common_scripts\utility::func_3799("bob_punch");
  common_scripts\utility::func_3799("bob_sizzle");
  common_scripts\utility::func_3799("bob_smoke");
  common_scripts\utility::func_3799("FORCE_bob_sizzle");
  common_scripts\utility::func_3799("FORCE_bob_smoke");
  common_scripts\utility::func_3799("bob_was_koed");
  self.zombie_bob_can_take_damage = 0;
  init_bob_health();
  thread zombie_bob_think_setup();
  set_bob_phase("bob_punch");
  lib_0547::func_86C8(100);
  lib_0547::func_86C7(100);
  for(;;) {
    wait(0.2);
    if(common_scripts\utility::func_3794("bob_was_koed")) {
      continue;
    }

    run_bob_phase_logic();
    if(!self.var_5542 && lib_053C::func_4F8C()) {
      continue;
    }

    if(common_scripts\utility::func_562E(self.var_57C0)) {
      continue;
    }

    if(self.var_5542) {
      lib_0547::zombie_charge_cleanup(self.var_645E);
    }

    if(lib_053C::func_4F84()) {
      continue;
    }

    if(lib_053C::func_4F9B()) {
      continue;
    }

    if(lib_053C::func_4F9A()) {
      continue;
    }

    lib_053C::func_647();
  }
}

run_bob_phase_logic() {
  foreach(var_01 in level.zmb_bob_agent_phases) {
    if(common_scripts\utility::func_3794(var_01.var_109)) {
      bob_phase_handler(var_01);
    }
  }
}

bob_has_excuse_to_skip(param_00) {
  if(!isDefined(param_00.reasons_to_skip)) {
    return 0;
  }

  foreach(var_02 in param_00.reasons_to_skip) {
    if(common_scripts\utility::func_3794(var_02)) {
      return 1;
    }
  }

  return 0;
}

bob_phase_handler(param_00) {
  var_01 = bob_has_excuse_to_skip(param_00);
  if(!var_01) {
    foreach(var_03 in param_00.reasons_to_block_progress) {
      if(self[[var_03.var_3F02]]() == var_03.var_A281) {
        return;
      }
    }

    var_01 = common_scripts\utility::func_8134(param_00.func_and_data);
  }

  if(var_01) {
    if(lib_0547::func_5565(self.lastweapondamage, "throwingknife_zm")) {
      level notify("rebel_set_4_complete");
    }

    self.zombie_bob_can_take_damage = 0;
    set_bob_phase(param_00.next_phase);
  }
}

set_bob_phase(param_00) {
  foreach(var_02 in level.zmb_bob_agent_phases) {
    common_scripts\utility::func_3796(var_02.var_109);
  }

  common_scripts\utility::func_379A(param_00);
  lib_0378::func_8D74("aud_bob_engine", param_00);
  self.enterednewphase = 1;
}

zombie_bob_print_delayed_health() {
  iprintlnbold("health: " + self.var_BC);
}

zombie_bob_tesla_delayed_dmg(param_00, param_01, param_02) {
  return param_00;
}

zombie_bob_on_damaged_finished(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(!self.zombie_bob_can_take_damage && !isDefined(self.smoke_damage)) {
    return;
  }

  if(isDefined(self.zombie_limit_damage)) {
    self.zombie_limit_damage = self.zombie_limit_damage - param_02;
    if(self.zombie_limit_damage < 0) {
      self.zombie_bob_can_take_damage = 0;
      param_02 = param_02 + self.zombie_limit_damage;
      self.zombie_limit_damage = 0;
    }
  }

  var_0B = 0;
  if(common_scripts\utility::func_3794("bob_punch")) {
    var_0B = self.phase2health;
  }

  if(common_scripts\utility::func_3794("bob_sizzle")) {
    var_0B = self.phase3health;
  }

  if(self.var_BC - param_02 < var_0B) {
    param_02 = self.var_BC - var_0B;
  }

  if(param_02 == 0) {
    return;
  }

  lib_054D::func_6BD3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

zombie_bob_on_damaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  self.lastweapondamage = param_05;
  if(common_scripts\utility::func_3794("bob_was_koed")) {
    return;
  }

  if(self.var_78D7 < self.var_6099) {
    self.var_78D7 = self.var_78D7 + param_02;
  }

  self.var_E6 = param_01;
  if(!self.zombie_bob_can_take_damage && !isDefined(self.smoke_damage)) {
    return;
  }

  if(common_scripts\utility::func_3794("bob_smoke") && !isDefined(self.smoke_damage)) {
    return;
  }

  if(param_05 != "wunderbuss_zm") {
    var_0B = self gettagorigin("engine");
    if(distancesquared(var_0B, param_06) > 256) {
      return;
    }
  }

  if(common_scripts\utility::func_3794("bob_smoke") && param_05 != "wunderbuss_zm") {
    return;
  }

  playFXOnTag(level.var_611["zmb_bob_metalhit_1"], self, "Engine");
  lib_054D::func_6BD1(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
}

zombie_bob_move_mode_func() {
  return "walk";
}

zombie_bob_infect_zombies() {
  thread zombie_bob_make_sizzlers();
  var_00 = "bob_stand_infect";
  var_01 = self[[maps\mp\agents\_agent_utility::func_A59("get_action_params")]]();
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_87C(var_00, var_01);
  maps\mp\agents\humanoid\_humanoid_util::func_8318(self.var_116, self.var_1D, var_02, undefined, 0, undefined, 1);
}

zombie_bob_infect_cleanup() {}

zombie_bob_smoke_atk_monitor_health() {
  self endon("bob_stop_engine_pulse");
  for(;;) {
    if(self.var_BC <= 1) {
      self notify("bob_stop_engine_pulse");
    }

    wait 0.05;
  }
}

zombie_bob_smoke_atk_cloud_damage(param_00) {
  level endon("bob_stop_smoke");
  var_01 = 25;
  while(var_01 > 0) {
    foreach(var_03 in level.var_744A) {
      if(distance2d(var_03.var_116, param_00) < 120) {
        var_03 dodamage(1, param_00);
      }
    }

    wait 0.05;
    var_01 = var_01 - 0.05;
  }
}

zombie_bob_smoke_listen_for_damage(param_00, param_01) {
  self endon("stop_damage_listen");
  param_00 endon("death");
  for(;;) {
    self waittill("damage", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    playFX(level.var_611["zmb_ber_bob_smk_electrify"], param_01);
    if(distance2d(param_00.var_116, param_01) < 144) {
      playFXOnTag(level.var_611["zmb_ber_bob_smk_dmg"], param_00, "Engine");
      param_00.smoke_damage = 1;
      param_00 zombie_bob_on_damaged(self, var_03, var_02, var_0A, var_06, var_0B, var_05, var_04, var_08, 0, var_09);
      param_00.smoke_damage = undefined;
    }
  }
}

zombie_bob_smoke_atk_spawn_hit_volumes(param_00, param_01) {
  var_02 = 2;
  wait(var_02);
  var_03 = getent("bob_smoke_collision", "targetname");
  var_04 = undefined;
  if(isDefined(var_03)) {
    var_04 = spawn("script_model", param_01);
    if(isDefined(var_04)) {
      var_04 clonebrushmodeltoscriptmodel(var_03);
    }
  }

  var_05 = getent("bob_smoke_trigger_damage", "targetname");
  var_06 = undefined;
  if(isDefined(var_05)) {
    var_06 = var_05.var_116;
    var_05 childthread zombie_bob_smoke_listen_for_damage(param_00, param_01);
    var_05.var_116 = param_01;
  }

  level common_scripts\utility::func_A74B("bob_stop_smoke", 25);
  if(isDefined(var_04)) {
    var_04 delete();
  }

  if(isDefined(var_06)) {
    var_05 notify("stop_damage_listen");
    var_05.var_116 = var_06;
  }
}

zombie_bob_smoke_atk_spawn_cloud(param_00) {
  param_00 lib_0378::func_8D74("aud_bob_engine", "bob_engine_rev");
  param_00 lib_0378::func_8D74("aud_bob_smoke_attack_strt");
  wait(2);
  var_01 = anglesToForward(param_00.var_1D);
  var_02 = anglestoup(param_00.var_1D);
  var_03 = param_00.var_116;
  var_04 = spawnfx(level.var_611["zmb_ber_bob_smk_cloud_lp"], var_03, var_01, var_02);
  lib_0378::func_8D74("aud_bob_smoke_attack_loop", 25, var_03);
  triggerfx(var_04);
  thread zombie_bob_smoke_atk_cloud_damage(var_03);
  thread zombie_bob_smoke_atk_spawn_hit_volumes(param_00, var_03);
  level common_scripts\utility::func_A74B("bob_stop_smoke", 25);
  var_04 delete();
}

zombie_bob_smoke_atk() {
  level thread zombie_bob_smoke_atk_spawn_cloud(self);
  self.zombie_limit_damage = int(bob_health_scale_per_num_players() * 1500);
  var_00 = "bob_stand_engine_area";
  var_01 = self[[maps\mp\agents\_agent_utility::func_A59("get_action_params")]]();
  var_02 = maps\mp\agents\_scripted_agent_anim_util::func_87C(var_00, var_01);
  maps\mp\agents\humanoid\_humanoid_util::func_8318(self.var_116, self.var_1D, var_02, undefined, 0, undefined, 1);
}

zombie_bob_smoke_atk_cleanup() {}

zombie_bob_make_sizzlers() {
  if(common_scripts\utility::func_3794("bob_sizzle")) {
    thread zombie_bob_engine_pulse();
  }

  wait(1.8);
  var_00 = lib_0547::func_4090("zombie_generic");
  var_01 = function_01AC(var_00, self.var_116);
  var_02 = maps\mp\zombies\zombie_sizzler::noofsizzlerscanspawn();
  for(var_03 = int(3.333333); var_03; var_03 = var_03 - 1) {
    var_04 = undefined;
    var_05 = self gettagorigin("TAG_FX_GUN");
    var_06 = self gettagangles("TAG_FX_GUN");
    var_07 = (0, var_06[1], 0);
    var_08 = anglesToForward(var_07);
    foreach(var_0A in var_01) {
      if(!var_02) {
        continue;
      }

      if(!isDefined(var_0A) || !isalive(var_0A)) {
        continue;
      }

      if(common_scripts\utility::func_562E(var_0A.transformingtosizzler)) {
        continue;
      }

      var_0B = var_0A method_85A5();
      if(var_0B == "zombie_animclass" && var_02) {
        var_0C = var_0A.var_116 - var_05;
        var_0C = (var_0C[0], var_0C[1], 0);
        var_0C = vectornormalize(var_0C);
        if(vectordot(var_0C, var_08) < 0.94) {
          continue;
        }

        var_0D = -1 * var_0C;
        var_0A thread maps\mp\zombies\zombie_sizzler::zombie_make_sizzler(var_0D);
        var_0E = (0, 0, 40);
        var_04 = playFX(level.var_611["zmb_ber_bob_beam_wv"], var_05, var_0A.var_116 + var_0E - var_05);
        lib_0378::func_8D74("aud_bob_shoot_gun", var_05);
        var_02--;
      }
    }

    if(!isDefined(var_04)) {
      var_10 = 400;
      var_11 = (0, 0, -1000);
      var_12 = bulletTrace(var_05, var_05 + var_08 * var_10 + var_11, 1, self);
      var_04 = playFXOnTag(level.var_611["zmb_ber_bob_beam_wv"], self, "TAG_FX_GUN");
      lib_0378::func_8D74("aud_bob_shoot_gun", var_05);
    }

    wait 0.05;
  }

  if(common_scripts\utility::func_3794("bob_sizzle")) {
    self notify("bob_stop_engine_pulse");
  }
}

zombie_bob_kill_fx_on_death(param_00) {
  param_00 endon("death");
  self waittill("death");
  param_00 delete();
}

zombie_bob_engine_pulse() {
  self endon("death");
  if(common_scripts\utility::func_3794("bob_was_koed")) {
    return;
  }

  self.engine_pulse = spawnlinkedfx(level.var_611["zmb_ber_bob_engine_glow"], self, "engine");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.engine_pulse);
  self.crank_pulse = spawnlinkedfx(level.var_611["zmb_ber_bob_crank_glow"], self, "engineCrank");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.crank_pulse);
  self.zombie_bob_can_take_damage = 1;
  triggerfx(self.engine_pulse);
  triggerfx(self.crank_pulse);
  self waittill("bob_stop_engine_pulse");
  if(isDefined(self.engine_pulse)) {
    self.engine_pulse delete();
  }

  if(isDefined(self.crank_pulse)) {
    self.crank_pulse delete();
  }

  wait(3.5);
  self.zombie_bob_can_take_damage = 0;
}

zombie_bob_engine_smk_ambient() {
  self endon("death");
  if(common_scripts\utility::func_3794("bob_was_koed")) {
    return;
  }

  wait 0.05;
  wait 0.05;
  self.engine_smoke_exhaust = spawnlinkedfx(level.var_611["zmb_ber_bob_ambient_smoke"], self, "engine");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.engine_smoke_exhaust);
  self.engine_smoke = spawnlinkedfx(level.var_611["zmb_ber_bob_front_smoke"], self, "engine");
  maps\mp\agents\_agent_utility::deleteentonagentdeath(self.engine_smoke);
  triggerfx(self.engine_smoke_exhaust);
  triggerfx(self.engine_smoke);
}

zombie_bob_charge_request(param_00) {
  var_01 = spawnStruct();
  var_01.var_721C = param_00;
  var_01.var_7462 = param_00.var_116;
  var_01.end_notify = "bob_end_charge";
  var_01.scripted_state = "zombie_bob_charge";
  var_01.stop_run_state_name = "s2_bob_stop_sprint";
  var_01.react_state_name = "s2_bob_roar";
  var_01.run_state_name = "s2_bob_sprint";
  var_01.react_anim_rate = 1;
  var_01.extra_lunge_radius = 100;
  var_01.trigger_lerp_deg = 25;
  var_01.trigger_nolerp_deg = 50;
  var_01.var_9DAA = 200;
  var_01.turn_smoothing_thread = ::lib_0547::zombie_charge_turn_smoothing_thread;
  var_01.initial_turn_deg = 200;
  var_01.initial_turn_secs = 0.1;
  var_01.initial_turn_speed = 0.169;
  var_01.var_2434 = 37;
  var_01.var_60C1 = 55;
  var_01.var_3A20 = 82;
  var_01.var_1B70 = 160;
  var_01.tackleplayers = 1;
  var_01.far_dist_p = 60;
  var_01.box_height_p = 60;
  var_01.tackle_dmg_p = 80;
  if(!lib_0547::has_scripted_state_queued("zombie_bob_charge")) {
    thread lib_0547::func_7D1A("zombie_bob_charge", [var_01], 0.5);
  }

  childthread make_vulnerable_while_stage1_charge_roar();
}

make_vulnerable_while_stage1_charge_roar() {
  if(!common_scripts\utility::func_3794("bob_punch")) {
    return;
  }

  wait 0.05;
  self.zombie_limit_damage = int(bob_health_scale_per_num_players() * 1500);
  thread zombie_bob_engine_pulse();
  var_00 = gettime() / 1000;
  if(isDefined(self.end_roar_secs) && self.end_roar_secs > var_00) {
    wait(self.end_roar_secs - var_00);
  }

  self notify("bob_stop_engine_pulse");
}