/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\numbers_grenade.gsc
****************************************************/

function init() {
  level._effect["vfx_numbers_trail"] = loadfx("vfx/iw8_br/island/equip/numb3rs_explosion/vfx_numb3rs_scrnfx_trail.vfx");
  level._effect["vfx_numbers_zombie_explosion"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_explode_death.vfx");
  game["dialog"]["numbers_grenade_assist"] = "numbers_victim_killed";
  level.numbers_grenade = spawnStruct();
  init_dvars();
  scripts\mp\utility\sound::besttime("br_numbers_grenade");
}

function init_dvars() {
  level.numbers_grenade.f_radius = getdvarfloat("scr_br_numbers_grenade_radius", 452.0);
  level.numbers_grenade.f_stun_duration = getdvarfloat("scr_br_numbers_grenade_stun_duration", 2.0);
  level.numbers_grenade.f_debuff_duration = getdvarfloat("scr_br_numbers_grenade_debuff_duration", 8.0);
  level.numbers_grenade.f_ai_effect_duration = getdvarfloat("scr_br_numbers_grenade_ai_effect_duration", 15.0);
  level.numbers_grenade.f_ai_stagger_duration = getdvarfloat("scr_br_numbers_grenade_ai_stagger_duration", 5.0);
  level.numbers_grenade.f_zombie_delay_min = getdvarfloat("scr_br_numbers_grenade_zombie_delay_min", 2.0);
  level.numbers_grenade.f_zombie_delay_max = getdvarfloat("scr_br_numbers_grenade_zombie_delay_max", 4.0);
  level.numbers_grenade.b_adrenaline_cancel = getdvarint("scr_br_numbers_grenade_canceled_by_adrenaline", 1);
  level.numbers_grenade.i_decoy_ping_count = getdvarint("scr_br_numbers_grenade_decoy_ping_count", 5);
  level.numbers_grenade.f_decoy_ping_interval = getdvarfloat("scr_br_numbers_grenade_decoy_ping_interval", 2.0);
  level.numbers_grenade.i_decoy_ping_radius = getdvarint("scr_br_numbers_grenade_decoy_ping_radius", 4000);
  level.numbers_grenade.f_shock_interrupt_delay_trim = getdvarfloat("scr_br_numbers_grenade_shock_interrupt_delay_trim", 2.7);
  level.numbers_grenade.f_stun_resist_scalar = getdvarfloat("scr_br_numbers_grenade_stun_resist_scalar", 0.5);
  level.numbers_grenade.f_debuff_resist_scalar = getdvarfloat("scr_br_numbers_grenade_debuff_resist_scalar", 0.5);
  level.numbers_grenade.i_assist_quip_cooldown = 1000 * getdvarint("scr_br_numbers_grenade_assist_quip_cooldown", 60);
}

function numbers_grenade_used(var_0) {
  self endon("disconnect");
  var_0 endon("explode_end");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  var_0 waittill("explode", var_1);

  if(isDefined(var_0.damaged_players)) {
    var_2 = create_decoy_ping_data(var_0.damaged_players, var_1, level.numbers_grenade.f_debuff_duration);
    thread decoy_ping_group(level);

    foreach(var_4 in var_0.damaged_players) {
      thread player_effect(var_4, var_2);
    }
  }

  var_6 = getaiarrayinradius(var_1, level.numbers_grenade.f_radius);

  foreach(var_8 in var_6) {
    var_9 = var_8 getEye();

    if(istrue(var_8.ref_14693)) {
      thread zombie_effect(var_8);
      continue;
    }

    thread ai_effect(var_8);
    LOC_000000ea:
  }
}

function on_player_damaged(var_0) {
  if(var_0.meansofdeath == "MOD_IMPACT") {
    return true;
  }

  if(!isDefined(var_0.inflictor)) {
    return false;
  }

  var_1 = var_0.inflictor;

  if(!isDefined(var_1.damaged_players)) {
    var_1.damaged_players = [];
  }

  var_1.damaged_players[var_1.damaged_players.size] = var_0.victim;
  return true;
}

function player_effect(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(istrue(self.b_has_numbers_debuff)) {
    self notify("numbers_debuff_end_early");
    waitframe();
  }

  self endon("numbers_debuff_end_early");
  thread player_effect_end_watcher(var_0, var_1);

  if(level.numbers_grenade.b_adrenaline_cancel) {
    GscBinSkip4(0x35);
  }

  var_2 = scripts\mp\utility\perk::_hasperk("specialty_tac_resist");
  var_3 = scripts\engine\utility::ter_op(var_2, level.numbers_grenade.f_stun_resist_scalar, 1);
  var_4 = level.numbers_grenade.f_stun_duration * var_3;

  if(var_4 > 0) {
    scripts\cp_mp\utility\shellshock_utility::_shellshock("numbers_grenade_mp", "stun", var_4, 1, calculate_interrupt_delay(var_4));
    self.b_has_numbers_stun = 1;
  }

  var_5 = scripts\mp\utility\perk::_hasperk("specialty_tac_resist");
  var_6 = scripts\engine\utility::ter_op(var_5, level.numbers_grenade.f_debuff_resist_scalar, 1);
  var_7 = level.numbers_grenade.f_debuff_duration * var_6;
  thread scripts\mp\gamescore::trackdebuffassistfortime(var_1, self, "numbers_grenade_mp", var_7, "numbers_debuff_end_early");
  thread player_death_watcher(var_1);
  self playlocalsound("dx_bra_bchr_numbers_ambient_sfx");
  self setscriptablepartstate("headVFX", "numbersVision");
  self setscriptablepartstate("headSFX", "numbers_loop");
  self.b_has_numbers_debuff = 1;
  wait var_4;
  remove_stun();
  wait var_7 - var_4;
  remove_debuff();
  self notify("numbers_debuff_end");
}

function adrenaline_watcher() {
  self waittill("force_regeneration");
  self notify("numbers_debuff_end_early");
}

function player_death_watcher(var_0) {
  self endon("numbers_debuff_end");
  self endon("numbers_debuff_end_early");
  self waittill("death");

  if(!isDefined(var_0.numbers_quip_timestamp) || gettime() - var_0.numbers_quip_timestamp > level.numbers_grenade.i_assist_quip_cooldown) {
    var_0.numbers_quip_timestamp = gettime();
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("numbers_grenade_assist", var_0, 1, 0.5);
    return;
  }
}

function remove_stun() {
  if(self.b_has_numbers_stun) {
    scripts\cp_mp\utility\shellshock_utility::_stopshellshock(0);
    self.b_has_numbers_stun = 0;
    return;
  }
}

function remove_debuff() {
  if(self.b_has_numbers_debuff) {
    self stoplocalsound("dx_bra_bchr_numbers_ambient_sfx");
    self setscriptablepartstate("headVFX", "neutral");
    self setscriptablepartstate("headSFX", "numbers_fade");
    self.b_has_numbers_debuff = 0;
    return;
  }
}

function decoy_ping_group(var_0) {
  self endon("death_or_disconnect");
  var_1 = gettime() + var_0.f_duration * 1000;

  while(var_0.a_victims.size > 0 && gettime() < var_1) {
    function_0443(var_0.v_origin, var_0.a_victims, level.numbers_grenade.i_decoy_ping_count, level.numbers_grenade.i_decoy_ping_radius);
    wait(level.numbers_grenade.f_decoy_ping_interval);
  }
}

function player_effect_end_watcher(var_0, var_1) {
  scripts\engine\utility::ref_143A6("death_or_disconnect", "numbers_debuff_end_early", "numbers_debuff_end");

  if(isDefined(var_0)) {
    var_0.a_victims = scripts\engine\utility::array_remove(var_0.a_victims, self);
  }

  remove_debuff();
  remove_stun();
}

function ai_effect(var_0) {
  self endon("death");
  level endon("game_ended");

  if(istrue(self.b_has_numbers_debuff)) {
    self endon("numbers_debuff_end_early");
    remove_ai_effect();
  }

  self endon("numbers_debuff_end_early");
  self.s_numbers_original_team = self.team;
  self.b_has_numbers_debuff = 1;
  scripts\mp\mp_agent::set_agent_team(var_0.team);
  playFXOnTag(scripts\engine\utility::getfx("vfx_numbers_trail"), self, "j_spine4");
  thread scripts\engine\utility::play_loop_sound_on_entity("br_numbers_grenade_lp_npc", (0, 0, 50));
  childthread scripts\anim\combat_utility::flashbangstart(level.numbers_grenade.f_ai_stagger_duration);
  wait level.numbers_grenade.f_ai_effect_duration + level.numbers_grenade.f_ai_stagger_duration;
  remove_ai_effect();
}

function remove_ai_effect() {
  if(istrue(self.b_has_numbers_debuff)) {
    scripts\mp\mp_agent::set_agent_team(self.s_numbers_original_team);
    stopFXOnTag(scripts\engine\utility::getfx("vfx_numbers_trail"), self, "j_spine4");
    scripts\engine\utility::stop_loop_sound_on_entity("br_numbers_grenade_lp_npc");
    self playsoundonmovingent("br_numbers_grenade_fade_out_npc");
    self.b_has_numbers_debuff = 0;
    self.s_numbers_original_team = undefined;
    return;
  }
}

function zombie_effect(var_0) {
  level endon("game_ended");
  self endon("death");
  self.b_has_numbers_debuff = 1;
  childthread scripts\anim\combat_utility::flashbangstart(level.numbers_grenade.f_ai_stagger_duration);
  wait randomfloatrange(level.numbers_grenade.f_zombie_delay_min, level.numbers_grenade.f_zombie_delay_max);
  playFX(level._effect["vfx_numbers_zombie_explosion"], self gettagorigin("j_spineupper"));
  self kill(self.origin, var_0, self, "MOD_UNKNOWN");
}

function test_line_of_sight(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle"]);
  var_3 = physics_raycast(var_0, var_1, var_2, undefined, 0, "physicsquery_closest", 1);
  return !(isDefined(var_3) && var_3.size > 0);
}

function create_decoy_ping_data(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.a_victims = var_0;
  var_3.v_origin = var_1;
  var_3.f_duration = var_2;
  return var_3;
}

function calculate_interrupt_delay(var_0) {
  return max(0, var_0 - level.numbers_grenade.f_shock_interrupt_delay_trim) * 1000;
}