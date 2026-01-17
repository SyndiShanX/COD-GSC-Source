/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\alien_ancestor\_alien_ancestor.gsc
*******************************************************************/

init() {
  level.agent_funcs["ancestor"] = [];
  level.agent_funcs["ancestor"]["spawn"] = ::onspawn;
  level.agent_funcs["ancestor"]["on_killed"] = ::onkilled;
  level.agent_funcs["ancestor"]["on_damaged"] = ::ondamaged;
  level.agent_funcs["ancestor"]["on_damaged_finished"] = ::ondamagedfinished;
  level.custom_alien_attribute_table_init = ::init_attributes;
  level.drop_ims_when_grabbed_func = ::drop_ims_when_grabbed;
  level.shield_down_extension_dur = [5, 3, 2];
  load_ancestor_fx();

  if(!isDefined(level.active_ancestors))
    level.active_ancestors = [];
}

init_attributes() {
  var_0 = "ancestor";
  level.alien_types[var_0] = spawnStruct();
  level.alien_types[var_0].attributes = [];
  level.alien_types[var_0].attributes["emissive"] = getdefinitionvalue(21.0);
  level.alien_types[var_0].attributes["max_emissive"] = getdefinitionvalue(22.0);
  level.alien_types[var_0].attributes["view_height"] = getdefinitionvalue(23);
  level.alien_types[var_0].attributes["anim_scale"] = getdefinitionvalue(20.0);
  level.alien_types[var_0].attributes["model"] = getdefinitionvalue("2");
  level.alien_types[var_0].attributes["starting_health"] = getdefinitionvalue(24);
  level.alien_types[var_0].attributes["health_scalar_1p"] = getdefinitionvalue(70.0);
  level.alien_types[var_0].attributes["health_scalar_2p"] = getdefinitionvalue(71.0);
  level.alien_types[var_0].attributes["health_scalar_3p"] = getdefinitionvalue(72.0);
  level.alien_types[var_0].attributes["attacker_difficulty"] = getdefinitionvalue(80);
  level.alien_types[var_0].attributes["min_cumulative_pain_threshold"] = getdefinitionvalue(81);
  level.alien_types[var_0].attributes["min_cumulative_pain_buffer_time"] = getdefinitionvalue(82.0);
  level.alien_types[var_0].attributes["pain_interval"] = getdefinitionvalue(83.0);
}

load_ancestor_fx() {
  level._effect["ancestor_shield"] = loadfx("vfx/gameplay/alien/vfx_alien_ancstr_ff_01");
  level._effect["ancestor_shield_collapse"] = loadfx("vfx/gameplay/alien/vfx_alien_ancstr_ff_collapse_01");
  level._effect["ancestor_shield_raise"] = loadfx("vfx/gameplay/alien/vfx_alien_ancstr_ff_raise_01");
  level._effect["ancestor_hover"] = loadfx("vfx/gameplay/alien/vfx_alien_anc_hover");
  level._effect["ancestor_choke_ring"] = loadfx("vfx/gameplay/alien/vfx_alien_ancstr_choke_ring");
  level._effect["ancestor_choke_grab"] = loadfx("vfx/gameplay/alien/vfx_alien_ancstr_choke_grab");
  level._effect["ancestor_death_nuke"] = loadfx("vfx/gameplay/alien/vfx_alien_ancestor_blast_child_01");
  level._effect["blackhole_exp"] = loadfx("vfx/gameplay/alien/vfx_alien_blackhole_exp");
  level._effect["ancestor_choke_pv"] = loadfx("vfx/gameplay/alien/vfx_alien_ancstr_choke_pv_1");
  level._effect["ancestor_choke_3pv"] = loadfx("vfx/gameplay/alien/vfx_alien_ancstr_choke_3p");
  level._effect["ancestor_spawn_flash"] = loadfx("vfx/gameplay/alien/vfx_alien_ancstr_spawn_flash");
}

getdefinitionvalue(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 2;

  var_2 = tablelookup("mp/alien/alien_ancestor_definition.csv", 0, var_0, var_1);

  if(!isstring(var_0)) {
    if(!issubstr(var_2, "."))
      var_2 = int(var_2);
    else
      var_2 = float(var_2);
  }

  return var_2;
}

addancestoragent(var_0, var_1, var_2) {
  var_3 = maps\mp\agents\_agent_common::connectnewagent("ancestor", var_0);

  if(isDefined(var_3))
    var_3 thread[[var_3 maps\mp\agents\_agent_utility::agentfunc("spawn")]](var_1, var_2);

  return var_3;
}

onspawn(var_0, var_1) {
  setancestormodel();
  self.onenteranimstate = ::onenterstate;
  self spawnagent(var_0, var_1, "alien_ancestor_last_animclass", 32, 120);
  level notify("spawned_agent", self);
  assignattributes();
  setscriptfields(var_0);
  self scragentsetclipmode("agent");
  self scragentsetphysicsmode("gravity");
  self scragentusemodelcollisionbounds();
  self takeallweapons();
  level.active_ancestors = common_scripts\utility::array_add(level.active_ancestors, self);
  level notify("dlc_vo_notify", "last_vo", "ancestor_inbound");
  thread ancestor_shield();
  thread ancestor_spawnfx();
  maps\mp\agents\alien\_alien_think::cleardamagehistory();
  thread maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::main();
  self.headicon = maps\mp\_entityheadicons::setheadicon("allies", "waypoint_ancestor_health_10", (0, 0, 182), 10, 10, undefined, undefined, 0, 1, 0, 0);
}

setancestormodel() {
  var_0 = level.alien_types["ancestor"].attributes["model"];
  self setModel(var_0);
  self show();
  self motionblurhqenable();
}

ancestor_spawnfx() {
  wait 0.1;
  playFXOnTag(level._effect["ancestor_spawn_flash"], self, "j_spinelower");
}

ancestor_shield() {
  self endon("death");
  self endon("ancestor_destroyed");
  thread drop_shield_until_damaged();
  thread listen_for_shield_disable();
  self.shield_state = 1;
  self.shield_radius_sq = 50176;
  self.shield = spawn("script_model", self.origin + (0, 0, 100));
  self.shield setModel("alien_shield_bubble_ancestor_col");
  self.shield linkto(self, "tag_origin", (0, 0, 100), (-90, 0, 0));
  thread listen_for_shield_damage();
  wait 1.0;
  self.shield_down_time_end = gettime();

  for(;;) {
    raise_shield();

    if(!maps\mp\alien\_utility::is_true(self.should_lower_shield) && !maps\mp\alien\_utility::is_true(self.force_shield_down))
      self waittill("lower_shield");

    self.shield_down_time_extension_cnt = 0;
    lower_shield();

    while(isDefined(self.shield_down_time_end) && gettime() < self.shield_down_time_end || maps\mp\alien\_utility::is_true(self.force_shield_down))
      wait 0.05;

    self.shield_down_time_end = undefined;
    self.shield_down_time_extension_cnt = undefined;
  }
}

listen_for_shield_damage() {
  self endon("death");
  self endon("ancestor_destroyed");

  if(!isDefined(self.shield)) {
    return;
  }
  self.shield setCanDamage(1);

  for(;;) {
    self.shield waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9) && var_9 == "iw6_aliendlc42_mp") {
      self notify("ancestor_disable_shield_weapon");
      continue;
    }

    if(isDefined(var_9) && var_9 == "iw6_aliendlc43_mp")
      self notify("ancestor_disable_shield_grenade");
  }
}

raise_shield() {
  self.shield playSound("anc_shield_up");
  self.shield playLoopSound("anc_shield_lp");
  self.shield_state = 2;
  self.shield show();
  self.shield solid();
  wait 0.1;
  playFXOnTag(level._effect["ancestor_shield_raise"], self.shield, "tag_origin");
  wait 1;
  playFXOnTag(level._effect["ancestor_shield"], self.shield, "tag_origin");
  wait 0.2;
  self.shield_state = 1;
}

lower_shield() {
  self.shield stoploopsound("anc_shield_lp");
  self.shield playSound("anc_shield_down");
  self.shield_state = 3;
  stopFXOnTag(level._effect["ancestor_shield"], self.shield, "tag_origin");
  playFXOnTag(level._effect["ancestor_shield_collapse"], self.shield, "tag_origin");
  self.shield notsolid();
  wait 0.2;
  self.shield hide();
  self.shield_state = 0;
  level notify("dlc_vo_notify", "ancestor_shield_down");
  self.should_lower_shield = 0;
}

listen_for_shield_disable() {
  self endon("death");
  self endon("ancestor_destroyed");

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return("ancestor_disable_shield_weapon", "ancestor_disable_shield_grenade", "ancestor_disable_shield_blast", "ancestor_disable_shield_grab");
    var_1 = 0;

    if(var_0 == "ancestor_disable_shield_weapon")
      var_1 = 7;
    else if(var_0 == "ancestor_disable_shield_grenade")
      var_1 = 9;
    else if(var_0 == "ancestor_disable_shield_blast")
      var_1 = 1.8;
    else if(var_0 == "ancestor_disable_shield_grab")
      var_1 = 1.8;

    if(!maps\mp\alien\_utility::is_true(self.force_shield_down) && (var_0 == "ancestor_disable_shield_blast" || var_0 == "ancestor_disable_shield_grab")) {
      continue;
    }
    if(self.shield_state == 1 || self.shield_state == 2)
      self.should_lower_shield = 1;

    var_2 = int(gettime() + var_1 * 1000);

    if(!isDefined(self.shield_down_time_end) || var_2 > self.shield_down_time_end)
      self.shield_down_time_end = var_2;

    self notify("lower_shield");
  }
}

drop_shield_until_damaged() {
  self endon("death");
  self endon("ancestor_destroyed");
  var_0 = 0.15;
  var_1 = (self.maxhealth - 20000) * var_0;
  var_2 = 20;

  if(isDefined(level.ancestor_shield_up_override))
    var_2 = level.ancestor_shield_up_override;

  wait 5;
  self.force_shield_down = 1;
  var_3 = self.health;
  var_4 = var_3 - var_1;
  self notify("lower_shield");

  for(;;) {
    self waittill("damage");
    var_3 = self.health;

    if(var_3 > var_4) {
      continue;
    }
    var_4 = var_3 - var_1;
    self.force_shield_down = 0;
    wait(var_2);
    self notify("lower_shield");
    self.force_shield_down = 1;
  }
}

ancestor_hover() {
  self endon("death");
  self endon("ancestor_destroyed");
  wait 5;
  playFXOnTag(level._effect["ancestor_hover"], self, "j_mainroot");
}

isshieldup() {
  return isDefined(self.shield_state) && self.shield_state == 1;
}

isshielddown() {
  return isDefined(self.shield_state) && self.shield_state == 0;
}

extend_shield_down_time(var_0) {
  if(isshielddown()) {
    self.shield_down_time_extension_cnt++;

    if(!isDefined(self.shield_down_time_end))
      self.shield_down_time_end = gettime();

    var_1 = self.shield_down_time_end + var_0;
    self.shield_down_time_end = var_1;
  }
}

ensure_shield_stays_down_until_time(var_0) {
  if(isshielddown()) {
    if(isDefined(self.shield_down_time_end) && var_0 > self.shield_down_time_end)
      self.shield_down_time_end = var_0;
  }
}

assignattributes() {
  self.alien_type = "ancestor";
  self.moveplaybackrate = 1.0;
  self.defaultmoveplaybackrate = self.moveplaybackrate;
  self.animplaybackrate = self.moveplaybackrate;
  self.xyanimscale = level.alien_types[self.alien_type].attributes["anim_scale"];
  self.defaultemissive = level.alien_types[self.alien_type].attributes["emissive"];
  self.maxemissive = level.alien_types[self.alien_type].attributes["max_emissive"];
  thread setinitialemissive();
  self scragentsetviewheight(level.alien_types[self.alien_type].attributes["view_height"]);
  var_0 = gethealthscalar();
  self.health = int(level.alien_types["ancestor"].attributes["starting_health"] * var_0 + 20000);
  self.maxhealth = int(level.alien_types["ancestor"].attributes["starting_health"] * var_0 + 20000);
  self scragentsetmaxturnspeed(0.05);

  if(!threatbiasgroupexists("ancestors")) {
    createthreatbiasgroup("ancestors");
    setthreatbias("players", "ancestors", 10000);
  }

  self setthreatbiasgroup("ancestors");
  maps\mp\alien\_utility::ent_flag_init("activate_shield_health_check");
}

setinitialemissive() {
  self endon("death");
  self endon("ancestor_destroyed");
  wait 1;
  maps\mp\alien\_utility::set_alien_emissive(0.2, self.defaultemissive);
}

setscriptfields(var_0) {
  self.species = "alien";
  self.radius = 32;
  self.height = 120;
  maps\mp\agents\_agent_utility::activateagent();
  self.spawntime = gettime();
  self.spawnorigin = var_0;
  self.is_moving = 1;
  self.movemode = "walk";
  self.trajectoryactive = 0;
}

gethealthscalar() {
  switch (level.players.size) {
    case 1:
      return level.alien_types["ancestor"].attributes["health_scalar_1p"];
    case 2:
      return level.alien_types["ancestor"].attributes["health_scalar_2p"];
    case 3:
      return level.alien_types["ancestor"].attributes["health_scalar_3p"];
  }

  return 1.0;
}

handleshielddamage(var_0) {
  if(isshieldup()) {
    if(var_0 != "iw6_aliendlc42_mp" && var_0 != "iw6_aliendlc43_mp")
      level notify("dlc_vo_notify", "ancestor_shield_up");
  } else if(isshielddown() && (var_0 == "iw6_aliendlc43_mp" || var_0 == "iw6_aliendlc42_mp")) {
    var_1 = self.shield_down_time_extension_cnt;

    if(var_1 < level.shield_down_extension_dur.size) {
      var_2 = level.shield_down_extension_dur[var_1] * 1000;
      extend_shield_down_time(var_2);
    }
  }
}

handleshieldstateforattack(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  switch (var_0) {
    case "grab":
      var_2 = "ancestor_disable_shield_grab";
      var_1 = 1800.0;
      break;
    case "blast":
      var_2 = "ancestor_disable_shield_blast";
      var_1 = 1800.0;
      break;
  }

  if(isshieldup())
    self notify(var_2);
  else if(isshielddown()) {
    var_3 = gettime() + var_1;
    ensure_shield_stays_down_until_time(var_3);
  }
}

ondamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!maps\mp\alien\_damage::is_alien_agent_damage_allowed(var_0, var_1, var_5, var_4))
    return 0;

  if(var_2 <= 0)
    return 0;

  if(isshieldup()) {
    var_10 = "hitalienarmor";
    var_2 = 0;
  } else if(isDefined(var_8) && (var_8 == "head" || var_8 == "neck")) {
    var_2 = var_2 * 1.2;
    var_10 = "hitaliensoft";
  } else
    var_10 = "standard";

  handleshielddamage(var_5);

  if(var_5 == "iw6_alienminigun_mp" || var_5 == "iw6_alienminigun1_mp" || var_5 == "iw6_alienminigun2_mp" || var_5 == "iw6_alienminigun3_mp")
    var_2 = 27.5;
  else if(var_5 == "iw6_alienminigun4_mp")
    var_2 = 37.5;

  if(var_5 == "iw6_alienmk32_mp" || var_5 == "iw6_alienmk321_mp" || var_5 == "iw6_alienmk322_mp" || var_5 == "iw6_alienmk323_mp" || var_5 == "iw6_alienmk324_mp")
    var_2 = var_2 * 0.5;

  if(var_5 == "alien_manned_minigun_turret_mp" || var_5 == "alien_manned_minigun_turret1_mp" || var_5 == "alien_manned_minigun_turret2_mp" || var_5 == "alien_manned_minigun_turret3_mp" || var_5 == "alien_manned_minigun_turret4_mp")
    var_2 = var_2 * 0.5;

  if(var_5 == "alien_manned_gl_turret_mp" || var_5 == "alien_manned_gl_turret1_mp" || var_5 == "alien_manned_gl_turret2_mp" || var_5 == "alien_manned_gl_turret3_mp" || var_5 == "alien_manned_gl_turret4_mp")
    var_2 = var_2 * 0.5;

  if(var_5 == "iw6_arkalienvks_mp_alienvksscope")
    var_2 = var_2 * 1.15;

  if(var_5 == "iw6_alienrgm_mp")
    var_2 = var_2 * 1.15;

  if(isDefined(level.custom_scale_alien_damage_func))
    var_2 = [[level.custom_scale_alien_damage_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(var_5 == "alienthrowingknife_mp") {
    if(isDefined(level.achievement_you_wish_cb) && isplayer(var_1))
      var_1[[level.achievement_you_wish_cb]]();

    var_2 = 0;
    var_0 delete();
  } else
    var_2 = maps\mp\alien\_damage::set_alien_damage_by_weapon_type(var_4, var_5, var_2);

  if(isplayer(var_1) && !maps\mp\alien\_utility::is_trap(var_0)) {
    var_2 = maps\mp\alien\_damage::scale_alien_damage_by_perks(var_1, var_2, var_4, var_5);
    var_2 = maps\mp\alien\_damage::scale_alien_damage_by_weapon_type(var_1, var_2, var_4, var_5, var_8);
  }

  var_2 = maps\mp\alien\_damage::scale_alien_damage_by_prestige(var_1, var_2);
  var_2 = int(var_2);

  if(isDefined(var_1)) {
    if(isDefined(var_1.owner) && isplayer(var_1.owner))
      var_1.owner thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_10);
    else
      var_1 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_10);
  }

  if(var_2 <= 0)
    return 0;

  if(getrealhealth() - var_2 <= 0) {
    if(isDefined(self.entityheadicons)) {
      foreach(var_12 in self.entityheadicons) {
        if(!isDefined(var_12)) {
          continue;
        }
        var_12 destroy();
      }
    }
  }

  level thread maps\mp\alien\_challenge_function::update_alien_damage_challenge(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self);
  return self[[maps\mp\agents\_agent_utility::agentfunc("on_damaged_finished")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

ondamagedfinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_3 = var_3 | level.idflags_no_knockback;
  self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, 0);

  if(!isDefined(self.ancestor_destroyed))
    self.ancestor_attacker = var_1;

  var_10 = getrealhealth();

  if(var_10 <= 0) {
    return;
  }
  var_11 = maps\mp\alien\_utility::is_trap(var_0);
  maps\mp\agents\alien\_alien_think::registerdamage(var_2);

  if(isDefined(var_1)) {
    if(isplayer(var_1) || isDefined(var_1.owner) && isplayer(var_1.owner)) {
      if(!var_11)
        var_1 maps\mp\alien\_damage::check_for_special_damage(self, var_5, var_4);
    }
  }

  if(self.currentanimstate == "move") {
    var_12 = maps\mp\agents\alien\_alien_think::belowcumulativepainthreshold(var_1, var_5);

    if(!var_12) {
      maps\mp\agents\alien\_alien_think::cleardamagehistory();
      maps\mp\agents\alien\alien_ancestor\_alien_ancestor_move::ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    }
  }

  var_13 = int(getrealmaxhealth() * 0.1);
  var_14 = int(var_10 / var_13) + 1;

  if(!isDefined(self.current_headicon))
    self.current_headicon = var_14;

  if(var_14 == self.current_headicon) {
    return;
  }
  var_15 = maps\mp\_entityheadicons::setheadicon("allies", "waypoint_ancestor_health_" + var_14, (0, 0, 182), 10, 10, undefined, undefined, 0, 1, 0, 0);
  self.current_headicon = var_14;
}

getrealmaxhealth() {
  return self.maxhealth - 20000;
}

getrealhealth() {
  return self.health - 20000;
}

onkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = common_scripts\utility::flag_exist("cortex_started") && common_scripts\utility::flag("cortex_started");

  if(isDefined(self.shield)) {
    stopFXOnTag(level._effect["ancestor_shield"], self.shield, "tag_origin");
    self.shield stoploopsound("anc_shield_lp");
    self.shield delete();
  }

  if(maps\mp\alien\_utility::is_true(self.killed_by_script)) {
    return;
  }
  maps\mp\alien\_challenge_function::update_alien_death_challenges(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  level maps\mp\alien\_achievement_dlc4::update_timing_is_everything();

  if(isDefined(self.ancestor_attacker) && isplayer(self.ancestor_attacker)) {
    level.alienbbdata["aliens_killed"]++;
    maps\mp\alien\_death::record_player_kills(self.ancestor_attacker);
  }

  var_10 = maps\mp\alien\_gamescore::get_reward_point_for_kill();

  foreach(var_12 in level.players) {
    maps\mp\alien\_gamescore::givekillreward(var_12, 3500, "large");

    if(!var_9)
      maps\mp\alien\_gamescore::calculate_player_encounter_scores(var_12, ["ancestor_bonus"]);

    if(!isDefined(var_12.ancestor_kills))
      var_12.ancestor_kills = 0;

    var_12.ancestor_kills++;

    if(!maps\mp\alien\_utility::is_casual_mode()) {
      if(isDefined(var_12.ancestor_kills) && var_12.ancestor_kills == 3)
        var_12 maps\mp\alien\_persistence::give_player_tokens(1, 0);

      if(isDefined(var_12.ancestor_kills) && var_12.ancestor_kills == 5)
        var_12 maps\mp\alien\_persistence::give_player_tokens(1, 0);
    }
  }

  if(!maps\mp\alien\_utility::is_hardcore_mode())
    maps\mp\mp_alien_last_progression::give_players_skill_points(1);

  if(var_9) {
    if(isDefined(level.add_cortex_charge_func))
      [[level.add_cortex_charge_func]](10, 1);
  }

  return;
}

playdeath() {
  self notify("ancestor_destroyed");

  if(isDefined(self.shield)) {
    stopFXOnTag(level._effect["ancestor_shield"], self.shield, "tag_origin");
    self.shield stoploopsound("anc_shield_lp");
    self.shield delete();
  }

  level.active_ancestors = common_scripts\utility::array_remove(level.active_ancestors, self);
  level notify("dlc_vo_notify", "last_vo", "ancestor_killed");

  if(isDefined(level.dead_ancestors))
    level.dead_ancestors++;

  level notify("ancestor_died");
  var_0 = 24;
  var_1 = 30;

  if(!maps\mp\alien\_utility::is_normal_upright(anglestoup(self.angles)))
    maps\mp\alien\_death::move_away_from_surface(anglestoup(self.angles), var_0);

  if(isDefined(self.apextraversaldeathvector))
    maps\mp\alien\_death::move_away_from_surface(self.apextraversaldeathvector, var_1);

  self.ancestor_destroyed = 1;
  maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("death", undefined, "death_anim", "end", ::handledeathnotetracks);
  self suicide();
}

ancestor_death_nuke_fx() {
  playFX(level._effect["ancestor_death_nuke"], self.origin + (0, 0, 60));
  wait 0.5;

  foreach(var_1 in level.players) {
    if(isDefined(level.shell_shock_override))
      var_1[[level.shell_shock_override]](0.5);
    else
      var_1 shellshock("alien_spitter_gas_cloud", 0.5);

    var_1 playrumbleonentity("grenade_rumble");
  }
}

handledeathnotetracks(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "death_end":
      thread ancestor_death_nuke_fx();
      break;
  }
}

drop_ims_when_grabbed(var_0) {}

onenterstate(var_0, var_1) {
  onexitanimstate(var_0, var_1);
  self.currentanimstate = var_1;

  switch (var_1) {
    case "idle":
      maps\mp\agents\alien\alien_ancestor\_alien_ancestor_idle::main();
      break;
    case "melee":
      maps\mp\agents\alien\alien_ancestor\_alien_ancestor_melee::main();
      break;
    case "move":
      maps\mp\agents\alien\alien_ancestor\_alien_ancestor_move::main();
      break;
  }
}

onexitanimstate(var_0, var_1) {
  self notify("killanimscript");

  switch (var_0) {
    case "melee":
      maps\mp\agents\alien\alien_ancestor\_alien_ancestor_melee::endscript();
      break;
  }
}