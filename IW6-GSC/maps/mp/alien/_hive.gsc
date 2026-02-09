/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_hive.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\alien\_utility;

DEFAULT_HIVE_WAYPOINT_DIST = 1300;

init_hives() {
  if(!flag_exist("hives_cleared"))
    flag_init("hives_cleared");

  if(!flag_exist("blocker_hive_destroyed"))
    flag_init("blocker_hive_destroyed");

  init_hive_locs();
}

regular_hive(custom_get_score_component_list_func) {
  while(1) {
    selected_regular_hives = select_hives(false);

    AssertEx(selected_regular_hives.size > 0, "No regular hive is selected");

    level thread maps\mp\alien\_spawnlogic::encounter_cycle_spawn("drill_planted", "door_planted");

    foreach(regular_hive in selected_regular_hives)
    regular_hive thread regular_hive_listener(get_hive_score_component_list_func(custom_get_score_component_list_func));

    result = level waittill_any_return("regular_hive_destroyed", "regular_door_destroyed");
    if(result == "regular_hive_destroyed") {
      maps\mp\alien\_spawn_director::end_cycle();
      level thread maps\mp\alien\_spawnlogic::remaining_alien_management();
      return;
    }
  }
}

regular_hive_listener(get_score_component_list_func) {
  level endon("game_ended");

  self notify("stop_listening");
  self endon("stop_listening");

  if(isDefined(level.drill) && !isDefined(level.drill_carrier) && !is_true(level.automatic_drill))
    level waittill("drill_pickedup", player);

  icon = "waypoint_alien_destroy";
  waypoint_dist = get_hive_waypoint_dist(self, DEFAULT_HIVE_WAYPOINT_DIST);

  if(self is_door() || (isDefined(level.hive_icon_override) && self[[level.hive_icon_override]]())) {
    waypoint_dist = 1000;
    icon = "waypoint_alien_door";
  }

  self thread set_hive_icon(icon, waypoint_dist);

  planter = self maps\mp\alien\_drill::wait_for_drill_plant();

  level.current_hive_name = self.target;

  if(!is_true(level.automatic_drill)) {
    self thread maps\mp\alien\_drill::drill_plant_BBPrint(planter);
  }

  if(level.cycle_count == 1)
    level delaythread(1, maps\mp\alien\_music_and_dialog::playVOForWaveStart);

  if(self is_door()) {
    level notify("door_planted");
    level notify("start_spawn_event", self.target);
    if(is_true(level.current_cycle_started_by_timeout))
      level.cycle_count--;

    if(getdvarint("scr_debugcyclecount") == 1) {
      if(is_true(level.current_cycle_started_by_timeout))
        println("CYCLE_COUNT_DEBUG -- > Cycle Count DECREMENTED to: " + level.cycle_count);

      println("CYCLE_COUNT_DEBUG -- > Spawning Door Event " + self.target);
    }
  }

  if(!self is_door())
    maps\mp\_utility::delaythread(2, maps\mp\alien\_challenge::spawn_challenge);

  level.drill_carrier = undefined;

  self thread maps\mp\alien\_drill::drilling(self.origin, planter);

  self disable_other_strongholds();

  maps\mp\alien\_gamescore::reset_encounter_performance();

  level notify("force_cycle_start");

  flag_wait("drill_detonated");

  self hive_play_death_animations();

  maps\mp\alien\_challenge::end_current_challenge();

  maps\mp\alien\_challenge::remove_all_challenge_cases();

  level.stronghold_hive_locs = array_remove(level.stronghold_hive_locs, self);

  self notify("hive_dying");

  self thread maps\mp\alien\_drill::drill_detonate();

  if(isDefined(self.scene_trig))
    self.scene_trig notify("trigger", level.players[0]);

  level.current_hive_name += "_post";

  if(self is_door()) {
    give_door_score();
    level notify("regular_door_destroyed");
  } else {
    level.num_hive_destroyed++;
    give_players_rewards(false, get_score_component_list_func);
    level notify("regular_hive_destroyed");
  }

  self notify("stop_listening");
}

blocker_hive_explode_sequence(attackable_ent, blocker_hive) {
  attackable_ent delete();

  if(isDefined(level.hive_heli)) {
    level.hive_heli notify("new_flight_path");
    level.hive_heli notify("blocker_hive_destroyed");
  }

  flag_set("blocker_hive_destroyed");

  blocker_hive hive_play_death_animations();
  blocker_hive delete_removables();
  blocker_hive maps\mp\alien\_drill::remove_spawner();
  blocker_hive maps\mp\alien\_drill::fx_ents_playFX();
  blocker_hive show_dead_hive_model();
  blocker_hive destroy_hive_icon();

  blocker_hive thread blocker_kill_sequence();
  blocker_hive thread maps\mp\alien\_drill::do_radius_damage();

  level thread maps\mp\alien\_music_and_dialog::playVOforBlockerHive();
  level thread maps\mp\alien\_spawnlogic::remaining_alien_management();
  level.current_blocker_hive = undefined;
  level.blocker_hive_active = undefined;
  level.stronghold_hive_locs = array_remove(level.stronghold_hive_locs, blocker_hive);
  level.current_hive_name += "_post";
  level.num_hive_destroyed++;

  if(isPlayingSolo() && !IsSplitScreen())
    maps\mp\alien\_laststand::give_lastStand(level.players[0], 1);

  if(isDefined(blocker_hive.drill_teleport_structs) && !is_true(level.automatic_drill))
    level thread maps\mp\alien\_drill::teleport_drill(blocker_hive.drill_teleport_structs[randomint(blocker_hive.drill_teleport_structs.size)].origin);

  if(isDefined(blocker_hive.scene_trig))
    blocker_hive.scene_trig notify("trigger", level.players[0]);

  maps\mp\alien\_achievement::update_blocker_hive_achievements(blocker_hive.target);
  level maps\mp\alien\_challenge_function::hide_barrier_hive_intel();

  flag_clear("blocker_hive_destroyed");

  blocker_hive notify("hive_dying");
  blocker_hive notify("stop_listening");
}

blocker_kill_sequence() {
  playFX(level._effect["stronghold_explode_large"], self.origin);
  self thread maps\mp\alien\_hive::sfx_destroy_hive();

  foreach(scriptable in self.scriptables) {
    scriptable thread maps\mp\alien\_hive::hive_explode(1);
    waitframe();
  }
}

CONST_BLOCKER_HIVE_HP_MED = 100000;
CONST_BLOCKER_HIVE_HP_HIGH = 150000;
CONST_BLOCKER_HIVE_HP_SOLO_SCALE = 0.66;
create_attackable_ent(blocker_hive) {
  attackable_ent = spawn("script_model", blocker_hive.origin);
  attackable_ent setModel("mp_ext_alien_hive03_collision");
  attackable_ent hide();
  attackable_ent.hive_target = blocker_hive.target;

  if(get_blocker_hive_index() == 1) {
    attackable_ent.health = CONST_BLOCKER_HIVE_HP_MED;
    attackable_ent.maxhealth = CONST_BLOCKER_HIVE_HP_MED;
  } else {
    attackable_ent.health = CONST_BLOCKER_HIVE_HP_HIGH;
    attackable_ent.maxhealth = CONST_BLOCKER_HIVE_HP_HIGH;
  }

  if(isPlayingSolo()) {
    attackable_ent.health = int(CONST_BLOCKER_HIVE_HP_SOLO_SCALE * attackable_ent.health);
    attackable_ent.maxhealth = int(CONST_BLOCKER_HIVE_HP_SOLO_SCALE * attackable_ent.maxhealth);
  }

  if(isDefined(level.create_attackable_ent_override_func))
    attackable_ent = [[level.create_attackable_ent_override_func]](attackable_ent);

  return attackable_ent;
}

hive_explode(fx_count) {
  if(!isDefined(fx_count))
    fx_count = 2;

  for(i = 0; i < fx_count; i++) {
    wait randomfloatrange(0.5, 1);

    offset = 8;
    _x = offset - randomintrange(0, offset * 2);
    _y = offset - randomintrange(0, offset * 2);

    self_forward = anglesToForward(self.angles);
    self_up = anglesToUp(self.angles);

    playFX(level._effect["alien_hive_explode"], self.origin + (_x, _y, 0), self_forward, self_up);
  }
}

sfx_destroy_hive() {
  wait 0.1;
  self playSound("alien_hive_destroyed");
}

CONST_DAMAGE_TRIGGER_THREAT = 400;
CONST_THREAT_INCREMENT = 100;
CONST_THREAT_COOL_DOWN = 10;
STAGE_ONE_THRESHOLD = 0.75;
STAGE_TWO_THRESHOLD = 0.5;
NEAR_DEATH_THRESHOLD = 0.25;
BLOCKER_HIVE_PAIN_EARTHQUAKE_INTENSITY = 0.4;
BLOCKER_HIVE_PAIN_WARN_DELAY = 0.1;
monitor_attackable_ent_damage(blocker_hive) {
  level endon("blocker_hive_destroyed");
  level endon("game_ended");

  level._effect["Fire_Cloud_Blocker_Hive"] = loadfx("vfx/gameplay/alien/vfx_alien_gas_fire");

  stageOnePainThreshold = STAGE_ONE_THRESHOLD * self.maxhealth;
  stageTwoPainThreshold = STAGE_TWO_THRESHOLD * self.maxhealth;
  nearDeathPainThreshold = NEAR_DEATH_THRESHOLD * self.maxhealth;

  stageOnePainReached = false;
  stageTwoPainReached = false;
  nearDeathReached = false;

  while(1) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags, weapon);

    if(isDefined(weapon) && weapon == "alienmortar_strike_mp") {
      damage = int(damage / 3);
      self.health += damage;
    }

    if(isDefined(weapon) && weapon == "iw6_alienpanzerfaust3_mp")
      self DoDamage(damage, self.origin, attacker, attacker, "MOD_PROJECTILE_SPLASH");

    if(isDefined(attacker) && isalive(attacker) && isPlayer(attacker)) {
      if(!isDefined(attacker.hive_damage))
        attacker.hive_damage = 0;

      attacker.hive_damage += damage;

      if(attacker.hive_damage > CONST_DAMAGE_TRIGGER_THREAT) {
        attacker.hive_damage = 0;
        attacker.threatbias += CONST_THREAT_INCREMENT;
        attacker thread cool_down_threat(CONST_THREAT_COOL_DOWN);
      }
    }

    if(!(isDefined(type) && type == "MOD_UNKNOWN") && !(isDefined(self.is_burning) && self.is_burning)) {
      if((isDefined(attacker.has_incendiary_ammo) && attacker.has_incendiary_ammo) || (isDefined(weapon) && (weapon == "iw6_alienmk324_mp" || weapon == "iw6_alienminigun4_mp" || weapon == "iw6_alienmk323_mp"))) {
        self thread blocker_hive_burn(attacker);
      }
    }

    if(isDefined(attacker.owner) && isalive(attacker.owner) && isPlayer(attacker.owner))
      attacker = attacker.owner;

    if(isDefined(attacker) && isalive(attacker) && isPlayer(attacker))
      attacker thread maps\mp\gametypes\_damagefeedback::updateDamageFeedback("standard");

    if(!stageOnePainReached && self.health < stageOnePainThreshold) {
      thread warn_all_players(BLOCKER_HIVE_PAIN_WARN_DELAY, BLOCKER_HIVE_PAIN_EARTHQUAKE_INTENSITY);
      stageOnePainReached = true;
    }

    if(!stageTwoPainReached && self.health < stageTwoPainThreshold) {
      thread warn_all_players(BLOCKER_HIVE_PAIN_WARN_DELAY, BLOCKER_HIVE_PAIN_EARTHQUAKE_INTENSITY);
      blocker_hive hive_play_first_pain_animations();
      if(isDefined(level.hive_heli))
        level.hive_heli maps\mp\alien\_music_and_dialog::play_pilot_vo("so_alien_plt_hivehalfdead");
      stageTwoPainReached = true;
    }

    if(!nearDeathReached && self.health < nearDeathPainThreshold) {
      blocker_hive hive_play_second_pain_animations();
      if(isDefined(level.hive_heli))
        level.hive_heli maps\mp\alien\_music_and_dialog::play_pilot_vo("so_alien_plt_hivealmostdead");
      nearDeathReached = true;
    }
  }
}

blocker_hive_burn(attacker) {
  self endon("death");

  self.is_burning = true;

  burn_time = 3;
  total_damage = 1200;
  total_damage *= level.alien_health_per_player_scalar[level.players.size];

  elapsed_time = 0;
  samples = 6;
  interval_wait = burn_time / samples;
  interval_damage = total_damage / samples;

  pos = self.origin + (VectorNormalize(anglesToForward(self.angles)) * 60) - (0, 0, 20);

  self.gasFire = SpawnFx(level._effect["Fire_Cloud_Blocker_Hive"], pos);
  triggerFx(self.gasFire);

  self thread kill_hive_burning_on_death();

  for(i = 0; i < samples; i++) {
    wait(interval_wait);
    self DoDamage(interval_damage, self.origin, attacker, attacker, "MOD_UNKNOWN");
  }

  self.is_burning = false;
  self.gasFire delete();
}

kill_hive_burning_on_death() {
  self notify("kill_hive_burning_on_death");
  self endon("kill_hive_burning_on_death");

  self waittill("death");

  if(isDefined(self.gasFire))
    self.gasFire delete();
}

cool_down_threat(timer) {
  level endon("blocker_hive_destroyed");
  level endon("game_ended");

  self endon("death");
  self thread reset_threat_on_death();
  self thread reset_threat_on_blocker_destroyed();

  if(GetDvarInt("alien_debug_director") > 0)
    IPrintLnBold(self.name + " threat: " + self.threatbias);

  wait timer;

  self.threatbias = int(max(0, self.threatbias - CONST_THREAT_INCREMENT));

  if(GetDvarInt("alien_debug_director") > 0)
    IPrintLnBold(self.name + " threat: " + self.threatbias);
}

reset_threat_on_death() {
  self notify("monitor_threat_on_death");
  self endon("monitor_threat_on_death");

  self waittill("death");
  self.threatbias = 0;
}

reset_threat_on_blocker_destroyed() {
  self notify("monitor_threat_on_blocker_destroyed");
  self endon("monitor_threat_on_blocker_destroyed");

  level waittill("blocker_hive_destroyed");
  self.threatbias = 0;
}

give_door_score() {
  door_score_component_list = get_door_score_component_list();
  maps\mp\alien\_gamescore::calculate_encounter_scores(level.players, door_score_component_list);
}

get_door_score_component_list() {
  if(is_progression_door(self))
    return ["progression_door"];
  else
    return ["side_area"];
}

is_progression_door(stronghold_struct) {
  if(!isDefined(level.progression_doors) || !isDefined(stronghold_struct.target))
    return false;

  return array_contains(level.progression_doors, stronghold_struct.target);
}

give_players_rewards(is_blocker_hive, get_score_component_list_func) {
  calculate_and_show_hive_scores(get_score_component_list_func);

  foreach(player in level.players) {
    player maps\mp\alien\_persistence::eog_player_update_stat("hivesdestroyed", 1);
    player thread wait_to_give_rewards();

    if(is_blocker_hive)
      player maps\mp\alien\_persistence::try_award_bonus_pool_token();
  }
}

calculate_and_show_hive_scores(get_score_component_list_func) {
  score_component_name_list = [[get_score_component_list_func]]();
  maps\mp\alien\_gamescore::calculate_and_show_encounter_scores(level.players, score_component_name_list);
}

get_blocker_hive_score_component_name_list() {
  if(isPlayingSolo())
    return ["personal_blocker"];
  else
    return ["team_blocker", "personal_blocker"];
}

get_regular_hive_score_component_name_list() {
  if(isPlayingSolo())
    return ["drill", "personal", "challenge"];
  else
    return ["drill", "team", "personal", "challenge"];
}

wait_to_give_rewards() {
  self endon("disconnect");
  level endon("game_ended");

  CONST_LUA_AFTER_HIVE_MENU_TIME = 4.0;
  wait(CONST_LUA_AFTER_HIVE_MENU_TIME);

  xp_earned = int(self.encounter_score_earned);
  self maps\mp\alien\_persistence::give_player_xp(xp_earned);

  maps\mp\alien\_debug::print_hive_XP_earned(xp_earned);

  self maps\mp\alien\_persistence::give_player_currency(self.encounter_cash_earned, undefined, undefined, true);
}

disable_other_strongholds() {
  foreach(stronghold_loc in level.stronghold_hive_locs) {
    if(self != stronghold_loc) {
      if(isDefined(stronghold_loc.icon))
        stronghold_loc.icon Destroy();

      stronghold_loc MakeUnusable();
      stronghold_loc SetHintString("");
      stronghold_loc notify("stop_listening");
    }
  }
}

set_hive_icon(shader, coll_dist, icon_width, icon_height) {
  level endon("game_ended");

  self endon("stop_listening");

  if(!isDefined(coll_dist))
    coll_dist = 1000;
  if(isDefined(level.drill_icon_draw_dist_override))
    coll_dist = level.drill_icon_draw_dist_override;

  if(!isDefined(icon_width))
    icon_width = 14;

  if(!isDefined(icon_height))
    icon_height = 14;

  someone_is_close = false;
  while(!someone_is_close) {
    someone_is_close = false;
    foreach(player in level.players) {
      if(isalive(player) && Distance(player.origin, self.origin) <= coll_dist)
        someone_is_close = true;
    }
    wait 0.05;
  }

  self destroy_hive_icon();

  self.icon = NewHudElem();
  self.icon SetShader(shader, icon_width, icon_height);
  self.icon.alpha = 0;
  self.icon.color = (1, 1, 1);
  self.icon SetWayPoint(true, true);
  self.icon.x = self.origin[0];
  self.icon.y = self.origin[1];
  self.icon.z = self.origin[2];

  if(!isDefined(coll_dist)) {
    self.icon.alpha = 0.5;
    return;
  }

  self.icon endon("death");

  while(isDefined(self.icon)) {
    someone_is_close = false;
    foreach(player in level.players) {
      if(isalive(player) && Distance(player.origin, self.origin) <= coll_dist)
        someone_is_close = true;
    }

    if(someone_is_close)
      icon_fade_in(self.icon);
    else
      icon_fade_out(self.icon);

    wait 0.05;
  }
}

icon_fade_in(icon) {
  if(icon.alpha != 0) {
    return;
  }
  icon FadeOverTime(1);
  icon.alpha = .5;
  wait(1);
}

icon_fade_out(icon) {
  if(icon.alpha == 0) {
    return;
  }
  icon FadeOverTime(1);
  icon.alpha = 0;
  wait(1);
}

destroy_hive_icon() {
  if(isDefined(self.icon))
    self.icon Destroy();
}

hive_pain_monitor() {
  self endon("death");
  self endon("stop_listening");

  maps\mp\alien\_drill::get_drill_entity() endon("offline");

  if(!isDefined(self.scriptables)) {
    return;
  }
  stageTwoPainThreshold = STAGE_TWO_THRESHOLD * self.total_depth;
  nearDepthPainThreshold = NEAR_DEATH_THRESHOLD * self.total_depth;
  currentDepth = self.depth;

  if(currentDepth > stageTwoPainThreshold) {
    wait(self.depth - stageTwoPainThreshold);
    self hive_play_first_pain_animations();
    currentDepth = stageTwoPainThreshold;
  }

  if(currentDepth > nearDepthPainThreshold) {
    wait(currentDepth - nearDepthPainThreshold);
    self hive_play_second_pain_animations();
  }
}

get_hive_score_component_list_func(custom_func) {
  if(isDefined(custom_func))
    return custom_func;

  return::get_regular_hive_score_component_name_list;
}

hive_play_first_pain_animations() {
  STAGE_TWO_PAIN_STATE = 3;

  self thread play_hive_scriptable_animations(undefined, undefined, STAGE_TWO_PAIN_STATE, true);
}

hive_play_second_pain_animations() {
  NEAR_DEATH_DELAY = 0.4;

  self thread play_hive_scriptable_animations("start_near_death", NEAR_DEATH_DELAY, "loop_near_death", true);
}

hive_play_drill_planted_animations(delay_override) {
  START_PAIN_DELAY = 0.2;
  if(isDefined(delay_override))
    START_PAIN_DELAY = delay_override;

  self thread play_hive_scriptable_animations("start_pain", START_PAIN_DELAY, "loop_pain1", true);
}

hive_play_death_animations() {
  DEATH_PAIN_DELAY = 1.5;

  self thread play_hive_scriptable_animations("death", DEATH_PAIN_DELAY, "remove", true);
}

play_hive_scriptable_animations(start_anim, time_delay, secondary_anim, use_interval_delay) {
  MIN_DELAY = 0.15;
  MAX_DELAY = 0.25;

  if(!isDefined(self.scriptables)) {
    return;
  }
  foreach(ent in self.scriptables) {
    ent thread play_hive_anim(start_anim, time_delay, secondary_anim);

    if(use_interval_delay)
      wait RandomFloatRange(MIN_DELAY, MAX_DELAY);
  }
}

play_hive_anim(start_anim, time_delay, secondary_anim) {
  if(isDefined(start_anim))
    self SetScriptablePartState(0, start_anim);

  if(isDefined(time_delay))
    wait time_delay;

  if(isDefined(secondary_anim))
    self SetScriptablePartState(0, secondary_anim);
}

dependent_hives_removed() {
  if(!isDefined(self.target) || !isDefined(level.hive_dependencies) || !isDefined(level.hive_dependencies[self.target])) {
    return true;
  }

  dependencies = level.hive_dependencies[self.target];

  foreach(hive in level.stronghold_hive_locs) {
    if(isDefined(hive.target)) {
      if(array_contains(dependencies, hive.target)) {
        return false;
      }
    }
  }

  return true;
}

select_hives(select_blocker_hive) {
  selected_hives = [];
  current_area_name = get_current_area_name();

  foreach(stronghold_loc in level.stronghold_hive_locs) {
    is_blocker_hive = stronghold_loc is_blocker_hive();

    if(select_blocker_hive && !is_blocker_hive) {
      continue;
    }
    if(!select_blocker_hive && is_blocker_hive) {
      continue;
    }
    if(!(stronghold_loc.area_name == current_area_name) && !stronghold_loc is_door()) {
      continue;
    }
    if(!stronghold_loc dependent_hives_removed()) {
      continue;
    }
    selected_hives[selected_hives.size] = stronghold_loc;
  }

  return selected_hives;
}

remove_unused_hives(removed_hives) {
  foreach(hive in removed_hives) {
    location_ent = getent(hive, "target");
    assertEx(isDefined(location_ent), "Invalid hive chosen to remove: " + hive);
    location_ent notify("stop_listening");
    location_ent thread play_hive_scriptable_animations("remove", undefined, undefined, false);
    location_ent thread delete_removables();
    location_ent destroy_hive_icon();
    foreach(ent in location_ent.fx_ents) {
      ent delete();
    }

    if(isDefined(location_ent.dead_hive_model)) {
      location_ent show_dead_hive_model();
    }

    location_ent delete();
  }
}

delete_removables() {
  assert(isDefined(self.removeables));

  foreach(ent in self.removeables) {
    if(isDefined(ent))
      ent delete();
  }
}

show_dead_hive_model() {
  if(!isDefined(self.dead_hive_model)) {
    return;
  }
  foreach(piece in self.dead_hive_model)
  piece show();
}

is_blocker_hive() {
  if(!isDefined(level.blocker_hives) || !isDefined(self.target))
    return false;

  foreach(hive_struct in level.blocker_hives) {
    if(hive_struct == self.target)
      return true;
  }

  return false;
}

warn_all_players(warn_delay, earthquake_intensity) {
  level endon("game_ended");

  wait warn_delay;

  foreach(player in level.players) {
    player thread warn_player(earthquake_intensity);
  }
}

warn_player(earthquake_intensity) {
  Earthquake(earthquake_intensity, 3, self.origin, 300);
  self PlayLocalSound("pre_quake_mtl_groan");
  self PlayRumbleOnEntity("heavygun_fire");
}

init_hive_locs() {
  level.stronghold_hive_locs = [];
  level.current_hive_name = "before_first_hive";

  stronghold_hive_locs = getEntArray("stronghold_bomb_loc", "targetname");

  door_locs = getEntArray("stronghold_door_loc", "targetname");
  if(isDefined(door_locs) && door_locs.size > 0)
    stronghold_hive_locs = array_combine(stronghold_hive_locs, door_locs);

  foreach(location_ent in stronghold_hive_locs) {
    if(isDefined(location_ent.target)) {
      targeted_ents = getEntArray(location_ent.target, "targetname");
      assert(isDefined(targeted_ents) && targeted_ents.size > 0);
      location_ent.scriptables = GetScriptableArray(location_ent.target, "targetname");

      foreach(scriptable in location_ent.scriptables)
      scriptable.is_hive = true;

      removeables = [];
      fx_ents = [];

      foreach(ent in targeted_ents) {
        if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "fx_ent")
          fx_ents[fx_ents.size] = ent;
        else if(isDefined(ent.script_noteworthy) && IsSubStr(ent.script_noteworthy, "waypointdist")) {
          tok = StrTok(ent.script_noteworthy, " ");
          if(isDefined(tok) && tok.size && tok[0] == "waypointdist") {
            assert(tok.size == 2);
            location_ent.waypoint_dist = int(tok[1]);
          }
        } else
          removeables[removeables.size] = ent;
      }

      if(isDefined(level.scene_trigs)) {
        foreach(trig in level.scene_trigs) {
          if(isDefined(trig.script_noteworthy) && trig.script_noteworthy == location_ent.target) {
            location_ent.scene_trig = trig;
            break;
          }
        }
      }

      drill_teleport_targetname = location_ent.target + "_drill_teleport_loc";
      location_ent.drill_teleport_structs = getstructarray(drill_teleport_targetname, "targetname");

      location_ent.removeables = removeables;
      location_ent.fx_ents = fx_ents;

      if(location_ent.target == level.last_hive) {
        location_ent.last_hive = true;
      }

      dead_hive_targetname = location_ent.target + "_dead";
      location_ent.dead_hive_model = getEntArray(dead_hive_targetname, "targetname");

      if(isDefined(location_ent.dead_hive_model)) {
        foreach(piece in location_ent.dead_hive_model)
        piece hide();
      }

      if(location_ent is_blocker_hive()) {
        location_ent thread init_blocker_hive_animation_state();

        location_ent MakeUnusable();
        location_ent SetHintString("");
      }
    }

    if(!array_contains(level.removed_hives, location_ent.target)) {
      location_ent.area_name = location_ent get_in_world_area();
      level.stronghold_hive_locs[level.stronghold_hive_locs.size] = location_ent;
    }
  }
}

init_blocker_hive_animation_state() {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(self.scriptables)) {
    return;
  }
  wait 5;

  foreach(ent in self.scriptables) {
    wait RandomFloatRange(0.15, 0.25);
    ent SetScriptablePartState(0, "loop_pain1");
  }
}

get_hive_waypoint_dist(hive, default_waypoint_dist) {
  if(isDefined(hive.waypoint_dist))
    return hive.waypoint_dist;

  if(isDefined(level.waypoint_dist_override))
    return level.waypoint_dist_override;

  return default_waypoint_dist;
}

get_blocker_hive_index() {
  assertex(isDefined(level.cycle_end_area_list) && level.cycle_end_area_list.size, "level.cycle_end_area_list is not defined at this point.");

  index_1 = level.cycle_end_area_list[0];
  index_2 = level.cycle_end_area_list[1];

  if(level.cycle_count == (index_1 - 1) || level.cycle_count == index_1)
    return 1;
  else
    return 2;
}

skip_hive() {
  if(!isDefined(level.cycle_count))
    level.cycle_count = maps\mp\alien\_spawnlogic::init_cycle_count();

  level.cycle_count++;
  level.num_hive_destroyed++;
}

beat_regular_hive() {
  selected_hive = get_selected_hive();

  if(!flag("drill_drilling"))
    beat_pre_drilling_sequence(selected_hive);

  beat_drilling_sequence(selected_hive);
}

beat_blocker_hive() {
  if(!is_true(level.blocker_hive_active)) {
    iprintlnBold("Blocker hive is not active yet");
    return;
  }

  level.current_blocker_hive.attackable_ent notify("death");
}

beat_pre_drilling_sequence(selected_hive) {
  level notify("drill_pickedup");
  waitframe();

  if(!isDefined(level.drill_carrier))
    set_fake_drill_carrier();

  selected_hive notify("trigger", level.drill_carrier);
  wait 7.5;
}

set_fake_drill_carrier() {
  level.drill_carrier = level.players[0];

  if(!isDefined(level.drill_carrier.lastweapon))
    level.drill_carrier.lastweapon = level.drill_carrier getWeaponsListAll()[0];
}

beat_drilling_sequence(selected_hive) {
  selected_hive.layers = [];
  selected_hive notify("force_drill_complete");
  wait 1.0;
}

get_selected_hive() {
  regular_hives_in_area = select_hives(false);

  if(flag("drill_drilling")) {
    foreach(regular_hive in regular_hives_in_area) {
      if(regular_hive.target == level.current_hive_name)
        return regular_hive;
    }
  } else {
    random_hive_index = randomIntRange(0, regular_hives_in_area.size);
    return (regular_hives_in_area[random_hive_index]);
  }
}

debug_spitter_population() {
  level endon("blocker_hive_destroyed");
  level endon("game_ended");

  while(1) {
    level.spitters_against_chopper = [];
    level.spitters_against_players = [];
    level.spitters_array = [];

    foreach(agent in level.agentArray) {
      if(!isDefined(agent.isActive) || !agent.isActive || !isalive(agent) || !isDefined(agent.alien_type) || agent.alien_type != "spitter") {
        continue;
      }
      level.spitters_array[level.spitters_array.size] = agent;

      if(agent GetThreatBiasGroup() == "spitters")
        level.spitters_against_chopper[level.spitters_against_chopper.size] = agent;
      else
        level.spitters_against_players[level.spitters_against_players.size] = agent;
    }
    wait 0.5;
  }
}
# /