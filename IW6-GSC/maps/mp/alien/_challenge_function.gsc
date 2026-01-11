/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_challenge_function.gsc
*************************************************/

#include maps\mp\alien\_utility;
#include common_scripts\utility;
#include maps\mp\_utility;

GOAL_SPEND_CURRENCY = 10000;
GOAL_SPEND_CURRENCY_20K = 20000;
KILL_LEPER_DURATION = 30;
MELEE_GOONS_AMOUNT = 5;
MELEE_SPITTER_AMOUNT = 1;
KILL_WITH_PROPANE_AMOUNT = 10;
KILL_WITH_TRAPS_AMOUNT = 10;
KILL_WHILE_PRONE_AMOUNT = 10;
KILL_WITH_TURRETS_AMNT = 10;
KILL_AIRBORNE_AMNT = 5;
KILL_WITH_WEAPON_AMT = 10;
SPEND_NO_MONEY_DURATION = 120;
NO_RELOAD_DURATION = 60;
NO_ABILITIES_DURATION = 90;

init_challenge_type() {
  level.challenge_data = [];

  if(!isDefined(level.challenge_scalar_func)) {
    level.challenge_scalar_func = ::default_challenge_scalar_func;
  }

  if(isDefined(level.challenge_registration_func)) {
    [[level.challenge_registration_func]]();
  }

  if(is_true(level.include_default_challenges)) {
    register_challenge("spend_10k", GOAL_SPEND_CURRENCY, false, undefined, undefined, ::activate_spend_currency, ::deactivate_spend_currency, undefined, ::update_spend_currency);
    register_challenge("spend_20k", GOAL_SPEND_CURRENCY_20K, false, undefined, undefined, ::activate_spend_currency, ::deactivate_spend_currency, undefined, ::update_spend_currency);
    register_challenge("kill_leper", KILL_LEPER_DURATION, false, undefined, undefined, ::activate_kill_leper, ::deactivate_kill_leper, undefined, ::update_kill_leper);
    register_challenge("spend_no_money", SPEND_NO_MONEY_DURATION, true, undefined, undefined, ::activate_spend_no_money, ::default_resetSuccess, undefined, ::update_spend_no_money);
    register_challenge("no_reloads", NO_RELOAD_DURATION, true, undefined, undefined, ::activate_no_reloads, ::default_resetSuccess, undefined, ::update_no_reloads);
    register_challenge("no_abilities", NO_ABILITIES_DURATION, true, undefined, undefined, ::activate_no_abilities, ::default_resetSuccess, undefined, ::update_no_abilities);
    register_challenge("take_no_damage", undefined, true, undefined, undefined, ::default_resetSuccess, ::default_resetSuccess, undefined, ::update_take_no_damage);
    register_challenge("melee_5_goons", MELEE_GOONS_AMOUNT, false, undefined, undefined, ::activate_melee_goons, ::deactivate_melee_goons, undefined, ::update_melee_goons);
    register_challenge("melee_spitter", MELEE_SPITTER_AMOUNT, false, undefined, undefined, ::activate_melee_spitter, ::deactivate_melee_spitter, undefined, ::update_melee_spitter);
    register_challenge("no_stuck_drill", undefined, true, undefined, undefined, ::default_resetSuccess, ::default_resetSuccess, undefined, ::update_no_stuck_drill);
    register_challenge("kill_10_with_propane", KILL_WITH_PROPANE_AMOUNT, false, undefined, undefined, ::activate_kill_10_with_propane, ::deactivate_kill_10_with_propane, undefined, ::update_kill_10_with_propane);
    register_challenge("stay_prone", KILL_WHILE_PRONE_AMOUNT, false, undefined, undefined, ::activate_stay_prone, ::deactivate_stay_prone, undefined, ::update_stay_prone);
    register_challenge("kill_10_with_traps", KILL_WITH_TRAPS_AMOUNT, false, undefined, undefined, ::activate_kill_10_with_traps, ::deactivate_kill_10_with_traps, undefined, ::update_kill_10_with_traps);
    register_challenge("avoid_minion_explosion", undefined, true, undefined, undefined, ::activate_avoid_minion_exp, ::deactivate_avoid_minion_exp, undefined, ::update_avoid_minion_exp);
    register_challenge("75_percent_accuracy", undefined, true, ::seventyfive_percent_accuracy_success_test, undefined, ::activate_percent_accuracy, ::deactivate_percent_accuracy, undefined, ::update_75_percent_accuracy);
    register_challenge("pistols_only", KILL_WITH_WEAPON_AMT, false, undefined, undefined, ::activate_use_weapon_challenge, ::default_resetSuccess, undefined, ::update_pistols_only);
    register_challenge("shotguns_only", KILL_WITH_WEAPON_AMT, false, undefined, undefined, ::activate_use_weapon_challenge, ::deactivate_weapon_challenge_waypoints, undefined, ::update_shotguns_only);
    register_challenge("snipers_only", KILL_WITH_WEAPON_AMT, false, undefined, undefined, ::activate_use_weapon_challenge, ::deactivate_weapon_challenge_waypoints, undefined, ::update_snipers_only);
    register_challenge("lmgs_only", KILL_WITH_WEAPON_AMT, false, undefined, undefined, ::activate_use_weapon_challenge, ::deactivate_weapon_challenge_waypoints, undefined, ::update_lmgs_only);
    register_challenge("ar_only", KILL_WITH_WEAPON_AMT, false, undefined, undefined, ::activate_use_weapon_challenge, ::deactivate_weapon_challenge_waypoints, undefined, ::update_ar_only);
    register_challenge("smg_only", KILL_WITH_WEAPON_AMT, false, undefined, undefined, ::activate_use_weapon_challenge, ::deactivate_weapon_challenge_waypoints, undefined, ::update_smgs_only);

    register_challenge("kill_10_with_turrets", KILL_WITH_TURRETS_AMNT, false, undefined, undefined, ::activate_kill_10_with_turrets, ::deactivate_kill_10_with_turrets, undefined, ::update_kill_10_with_turrets);
    register_challenge("kill_airborne_aliens", KILL_AIRBORNE_AMNT, false, undefined, undefined, ::activate_kill_airborne_aliens, ::deactivate_kill_airborne_aliens, undefined, ::update_kill_airborne_aliens);
    register_challenge("melee_only", undefined, true, undefined, undefined, ::activate_melee_only, ::deactivate_melee_only, undefined, ::update_melee_only);
    register_challenge("50_percent_accuracy", undefined, true, ::fifty_percent_accuracy_success_test, undefined, ::activate_percent_accuracy, ::deactivate_percent_accuracy, undefined, ::update_50_percent_accuracy);
    register_challenge("stay_within_area", 10, false, undefined, ::pre_activate_stay_within_area, ::activate_stay_within_area, ::deactivate_stay_within_area, undefined, ::update_stay_within_area);
    register_challenge("kill_10_in_30", 10, false, undefined, undefined, ::activate_kill_10_in_30, ::default_resetSuccess, undefined, ::update_kill_10_in_30);

    register_challenge("protect_player", undefined, true, undefined, undefined, ::activate_protect_a_player, ::deactivate_protect_a_player, undefined, ::update_protect_a_player);
    register_challenge("no_laststand", undefined, true, undefined, undefined, ::default_resetSuccess, ::default_resetSuccess, undefined, ::update_no_laststand);
    register_challenge("no_bleedout", undefined, true, undefined, undefined, ::default_resetSuccess, ::default_resetSuccess, undefined, ::update_no_bleedout);
    register_challenge("challenge_failed", undefined, false, undefined, undefined, ::default_resetSuccess, ::default_resetSuccess, undefined, undefined);
    register_challenge("challenge_success", undefined, false, undefined, undefined, ::default_resetSuccess, ::default_resetSuccess, undefined, undefined);
    register_challenge("barrier_hive", undefined, false, undefined, undefined, ::default_resetSuccess, ::default_resetSuccess, undefined, undefined);

  }
  init_alien_challenges_from_table();

  level.current_challenge_index = -1;
  level.current_challenge_progress_max = -1;
  level.current_challenge_progress_current = -1;
  level.current_challenge_percent = -1;
  level.current_challenge_target_player = -1;
  level.current_challenge_timer = -1;
  level.current_challenge_scalar = -1;
  level.current_challenge_title = -1;
  level.current_challenge_pre_challenge = 0;

  level.all_challenge_completed = true;
  level.pre_challenge_active = false;
  level.num_challenge_completed = 0;
}

register_challenge(ref, goal, default_success, successFunc, canActivateFunc, activateFunc, deactivateFunc, failActivateFunc, updateFunc, rewardFunc, failFunc) {
  challenge_struct = spawnStruct();

  challenge_struct.ref = ref;
  challenge_struct.goal = goal;
  challenge_struct.default_success = default_success;

  challenge_struct.isSuccessFunc = ::default_isSuccessFunc;
  if(isDefined(successFunc)) {
    challenge_struct.isSuccessFunc = successFunc;
  }

  challenge_struct.canActivateFunc = ::default_canActivateFunc;
  if(isDefined(canActivateFunc)) {
    challenge_struct.canActivateFunc = canActivateFunc;
  }

  challenge_struct.activateFunc = activateFunc;
  challenge_struct.deactivateFunc = deactivateFunc;

  challenge_struct.failActivateFunc = ::default_failActivateFunc;
  if(isDefined(failActivateFunc)) {
    challenge_struct.failActivateFunc = failActivateFunc;
  }

  challenge_struct.updateFunc = updateFunc;

  challenge_struct.rewardFunc = ::default_rewardFunc;
  if(isDefined(rewardFunc)) {
    challenge_struct.rewardFunc = rewardFunc;
  }

  challenge_struct.failFunc = ::default_failFunc;
  if(isDefined(failFunc)) {
    challenge_struct.failFunc = failFunc;
  }

  level.challenge_data[ref] = challenge_struct;
}

init_alien_challenges_from_table() {
  CHALLENGE_TABLE = level.alien_challenge_table;
  TABLE_INDEX = 0;
  TABLE_CHALLENGE_START_INDEX = 1;
  TABLE_CHALLENGE_END_INDEX = 99;
  TABLE_CHALLENGE_REF = 1;
  TABLE_CHALLENGE_ALLOWED_CYCLES = 2;
  TABLE_ALLOWEDINSOLO = 6;
  TABLE_CHALLENGE_PRECHALLENGE_TEXT = 7;
  TABLE_CHALLENGE_ALLOWED_HIVES = 8;

  for(entryIndex = TABLE_CHALLENGE_START_INDEX; entryIndex <= TABLE_CHALLENGE_END_INDEX; entryIndex++) {
    challengeID = tablelookup(CHALLENGE_TABLE, TABLE_INDEX, entryIndex, TABLE_CHALLENGE_REF);
    if(challengeID == "") {
      break;
    }
    allowed_cycles = tablelookup(CHALLENGE_TABLE, TABLE_INDEX, entryIndex, TABLE_CHALLENGE_ALLOWED_CYCLES);
    allowed_hives = tablelookup(CHALLENGE_TABLE, TABLE_INDEX, entryIndex, TABLE_CHALLENGE_ALLOWED_HIVES);

    level.challenge_data[challengeID].allowed_cycles = allowed_cycles;
    level.challenge_data[challengeID].allowedinsolo = int(tablelookup(CHALLENGE_TABLE, TABLE_INDEX, entryIndex, TABLE_ALLOWEDINSOLO));
    level.challenge_data[challengeID].allowed_hives = allowed_hives;
  }

}

default_canActivateFunc() {
  return true;
}
default_failActivateFunc() {
  AssertMsg("Fail to activate challenge: " + self.ref);
}
default_isSuccessFunc() {
  return self.success;
}
default_failFunc() {}
default_resetSuccess() {
  self.success = self.default_success;
}

default_rewardFunc() {
  CHALLENGE_COMPLETE_SKILL_POINT = 1;

  foreach(player in level.players) {
  player maps\mp\alien\_persistence::give_player_points(CHALLENGE_COMPLETE_SKILL_POINT);
  }
}

activate_spend_currency() {
  activate_spend_money_progress();
}
deactivate_spend_currency() {
  reset_spend_money_progress();
}

reset_spend_money_progress() {
  default_resetSuccess();
  self.current_progress = 0;
}

activate_spend_money_progress() {
  default_resetSuccess();
  self.current_progress = 0;
  self.goal = self.goal * 1000;
  update_challenge_progress(0, self.goal);
}

update_spend_currency(currency_spent, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.current_progress += currency_spent;

  if(self.current_progress >= self.goal) {
    self.success = true;
  }

  update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_kill_leper() {
  default_resetSuccess();

  if(!isDefined(level.current_cycle)) {
    level waittill("alien_cycle_started");
  }

  self.leper = maps\mp\alien\_spawn_director::spawn_alien("leper");
  self.leper thread leper_watch_death();
  self.leper thread maps\mp\agents\alien\_alien_leper::leper_challenge_despawn(self.goal);

  challenge_time = int(gettime() + 30000);
  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_timer", challenge_time);
  }
  level.current_challenge_timer = 30;
  level thread update_current_challenge_timer();
}

deactivate_kill_leper() {
  default_resetSuccess();
  if(IsAlive(self.leper)) {
    self.leper thread maps\mp\agents\alien\_alien_leper::leper_despawn();
    self.leper = undefined;
  }
}

leper_watch_death() {
  self waittill("death", attacker, cause, weapon);
  if(isDefined(attacker) && (isPlayer(attacker) || isDefined(attacker.classname) && attacker.classname == "misc_turret" && isDefined(attacker.owner) && attacker.owner IsUsingTurret())) {
    maps\mp\alien\_challenge::update_challenge("kill_leper", "success");

  } else {
    maps\mp\alien\_challenge::update_challenge("kill_leper", "fail");
  }
  level notify("stop_challenge_timer");
  level.current_challenge_timer = -1;
}

update_kill_leper(leper_state, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  if(leper_state == "success") {
    self.success = true;
  }

  maps\mp\alien\_challenge::deactivate_current_challenge();
}

activate_spend_no_money() {
  default_resetSuccess();
  challenge_time = int(gettime() + self.goal * 1000);
  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_timer", challenge_time);
  }
  level.current_challenge_timer = self.goal;
  level thread update_current_challenge_timer();
  level thread spend_no_money_timer(self);
}

spend_no_money_timer(challenge) {
  level endon("game_ended");
  challenge endon("fail");
  wait(challenge.goal);
  challenge.success = true;
  level notify("stop_challenge_timer");
  maps\mp\alien\_challenge::deactivate_current_challenge();
}
update_spend_no_money(spent_money, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.success = false;
  self notify("fail");
  level notify("stop_challenge_timer");
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

activate_no_reloads() {
  default_resetSuccess();
  challenge_time = int(gettime() + self.goal * 1000);
  level.current_challenge_timer = self.goal;
  level thread update_current_challenge_timer();
  level thread no_reload_timer(self);

  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_timer", challenge_time);
    player thread wait_for_reload();
  }
}

no_reload_timer(challenge) {
  level endon("stop_watching_reload");
  wait(challenge.goal);
  challenge.success = true;
  maps\mp\alien\_challenge::deactivate_current_challenge();
  level notify("stop_challenge_timer");
  level notify("stop_watching_reload");
}

wait_for_reload() {
  level endon("stop_watching_reload");
  self waittill("reload");
  maps\mp\alien\_challenge::update_challenge("no_reloads");
  level notify("stop_watching_reload");
}

update_no_reloads(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.success = false;
  maps\mp\alien\_challenge::deactivate_current_challenge();
  level notify("stop_challenge_timer");
}

activate_no_abilities() {
  default_resetSuccess();
  challenge_time = int(gettime() + self.goal * 1000);
  level.current_challenge_timer = self.goal;
  level thread update_current_challenge_timer();
  level thread no_abilities_timer(self);

  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_timer", challenge_time);
    player thread wait_for_ability_use();
  }
}

no_abilities_timer(challenge) {
  level endon("stop_watching_ability_use");
  wait(challenge.goal);
  challenge.success = true;
  maps\mp\alien\_challenge::deactivate_current_challenge();
  level notify("stop_challenge_timer");
  level notify("stop_watching_ability_use");
}

wait_for_ability_use() {
  level endon("stop_watching_ability_use");
  self waittill_any("action_finish_used", "class_skill_used");
  maps\mp\alien\_challenge::update_challenge("no_abilities");
  level notify("stop_watching_ability_use");
}

update_no_abilities(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.success = false;
  maps\mp\alien\_challenge::deactivate_current_challenge();
  level notify("stop_challenge_timer");
}

update_take_no_damage(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.success = false;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

nodamage_rewardFunc() {
  NODAMAGE_REWARD_POINT = 250;
  foreach(player in level.players) {
  player thread maps\mp\alien\_persistence::give_player_currency(NODAMAGE_REWARD_POINT);
  }
}

activate_melee_goons() {
  reset_melee_goons_progress();
  update_challenge_progress(0, self.goal);
}
deactivate_melee_goons() {
  reset_melee_goons_progress();
}

reset_melee_goons_progress() {
  default_resetSuccess();
  self.current_progress = 0;
}

update_melee_goons(goons_killed, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.current_progress += goons_killed;

  if(self.current_progress >= self.goal) {
    self.success = true;
  }

  remaining = (self.goal - self.current_progress);
  update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_melee_spitter() {
  reset_melee_spitter_progress();
}
deactivate_melee_spitter() {
  reset_melee_spitter_progress();
}

reset_melee_spitter_progress() {
  default_resetSuccess();
  self.current_progress = 0;
}

update_melee_spitter(spitter_killed, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.current_progress += spitter_killed;

  if(self.current_progress >= self.goal) {
    self.success = true;
  }

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

update_no_stuck_drill(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.success = false;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

update_no_laststand(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.success = false;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

update_no_bleedout(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.success = false;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

activate_kill_10_with_propane() {
  reset_kill_10_with_propane_progress();
  update_challenge_progress(0, self.goal);
}

deactivate_kill_10_with_propane() {
  reset_kill_10_with_propane_progress();
}

reset_kill_10_with_propane_progress() {
  default_resetSuccess();
  self.current_progress = 0;
}

update_kill_10_with_propane(aliens_killed, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.current_progress += aliens_killed;

  if(self.current_progress >= self.goal) {
    self.success = true;
  }

  remaining = (self.goal - self.current_progress);
  update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_kill_10_with_traps() {
  reset_kill_10_with_traps_progress();
  update_challenge_progress(0, self.goal);
}

deactivate_kill_10_with_traps() {
  reset_kill_10_with_traps_progress();
}

reset_kill_10_with_traps_progress() {
  default_resetSuccess();
  self.current_progress = 0;
}

update_kill_10_with_traps(aliens_killed, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.current_progress += aliens_killed;

  if(self.current_progress >= self.goal) {
    self.success = true;
  }

  remaining = (self.goal - self.current_progress);
  update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_stay_prone() {
  reset_stay_prone_progress();

  update_challenge_progress(0, self.goal);
}

deactivate_stay_prone() {
  reset_stay_prone_progress();
}

reset_stay_prone_progress() {
  default_resetSuccess();
  self.current_progress = 0;
}

update_stay_prone(aliens_killed, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.current_progress += aliens_killed;

  if(self.current_progress >= self.goal) {
    self.success = true;
  }

  remaining = (self.goal - self.current_progress);

  update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_protect_a_player() {
  default_resetSuccess();

  alive_players = [];
  foreach(player in level.players) {
    if(isAlive(player) && !player is_in_laststand()) {
      alive_players[alive_players.size] = player;
    }
  }

  targetPlayer = random(alive_players);

  foreach(player in level.players) {
    entnum = targetPlayer GetEntityNumber();
    player SetClientOmnvar("ui_intel_target_player", entnum);
  }

  level.current_challenge_target_player = targetplayer GetEntityNumber();

  targetplayer maps\mp\_entityheadIcons::setHeadIcon(targetplayer.team, "waypoint_defend", (0, 0, 72), 4, 4, undefined, undefined, undefined, true, undefined, false);
  level thread watch_target_player(targetPlayer, self);
  level thread watch_drill_detonated(targetPlayer, self);
}
watch_target_player(player, challenge) {
  level endon("drill_detonated");
  player waittill_any("death", "last_stand", "disconnect");

  player remove_head_icon();

  challenge.success = false;
  update_protect_a_player();
}
update_protect_a_player() {
  maps\mp\alien\_challenge::deactivate_current_challenge();

  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_target_player", -1);
  }

  level.current_challenge_target_player = -1;
}

watch_drill_detonated(player, challenge) {
  player endon("death");
  player endon("last_stand");
  player endon("disconnect");

  level waittill("drill_detonated");

  player remove_head_icon();

  update_protect_a_player();
}

remove_head_icon() {
  foreach(key, headIcon in self.entityHeadIcons) {
    if(!isDefined(headIcon)) {
      continue;
    }
    headIcon destroy();
  }
}

deactivate_protect_a_player() {
  default_resetSuccess();
}

activate_avoid_minion_exp() {
  default_resetSuccess();
}

deactivate_avoid_minion_exp() {
  default_resetSuccess();
}

update_avoid_minion_exp(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.success = false;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

update_75_percent_accuracy(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.total_shots_hit++;
}

seventyfive_percent_accuracy_success_test(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  return self.current_accuracy >= 75;
}

fifty_percent_accuracy_success_test(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  return self.current_accuracy >= 50;
}

update_50_percent_accuracy(hit, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.total_shots_hit++;
}

activate_percent_accuracy() {
  default_resetSuccess();
  self.total_shots_fired = 0;
  self.total_shots_hit = 0;
  self.current_accuracy = 0;
  self.is_updating = false;
  level thread track_percent_accuracy_shots_fired(self);
  level thread update_percent_accuracy(self);
  update_challenge_percent(0);
}

deactivate_percent_accuracy() {
  default_resetSuccess();
  self.total_shots_fired = 0;
  self.total_shots_hit = 0;
  level notify("deactivate_track_accuracy");
}

activate_use_weapon_challenge() {
  setup_challenge_waypoints(self);
  default_resetSuccess();
  self.current_progress = 0;
  update_challenge_progress(0, self.goal);
}

update_pistols_only(weapon, sMeansOfDeath, arc_death, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  if(getweaponclass(weapon) == "weapon_pistol" || is_true(arc_death)) {
    self.current_progress++;
  }

  update_challenge_progress(self.current_progress, self.goal);

  if(self.current_progress >= self.goal) {
    self.success = true;
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }

}

update_shotguns_only(weapon, sMeansOfDeath, arc_death, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  if(getweaponclass(weapon) == "weapon_shotgun" || is_true(arc_death)) {
    self.current_progress++;
  }

  update_challenge_progress(self.current_progress, self.goal);

  if(self.current_progress >= self.goal) {
    self.success = true;
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

update_snipers_only(weapon, sMeansOfDeath, arc_death, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  if(getweaponclass(weapon) == "weapon_sniper" || is_true(arc_death)) {
    self.current_progress++;
  }

  update_challenge_progress(self.current_progress, self.goal);

  if(self.current_progress >= self.goal) {
    self.success = true;
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

update_lmgs_only(weapon, sMeansOfDeath, arc_death, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  if(getweaponclass(weapon) == "weapon_lmg" || is_true(arc_death)) {
    self.current_progress++;
  }

  update_challenge_progress(self.current_progress, self.goal);

  if(self.current_progress >= self.goal) {
    self.success = true;
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

update_ar_only(weapon, sMeansOfDeath, arc_death, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  if(getweaponclass(weapon) == "weapon_assault" || is_true(arc_death)) {
    self.current_progress++;
  }

  update_challenge_progress(self.current_progress, self.goal);

  if(self.current_progress >= self.goal) {
    self.success = true;
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

update_smgs_only(weapon, sMeansOfDeath, arc_death, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  if(getweaponclass(weapon) == "weapon_smg" || is_true(arc_death)) {
    self.current_progress++;
  }

  update_challenge_progress(self.current_progress, self.goal);

  if(self.current_progress >= self.goal) {
    self.success = true;
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_kill_10_with_turrets() {
  reset_kill_10_with_turrets_progress();
  update_challenge_progress(0, self.goal);
}

deactivate_kill_10_with_turrets() {
  reset_kill_10_with_turrets_progress();
}

reset_kill_10_with_turrets_progress() {
  default_resetSuccess();
  self.current_progress = 0;
}

update_kill_10_with_turrets(aliens_killed, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.current_progress += aliens_killed;

  if(self.current_progress >= self.goal) {
    self.success = true;
  }

  remaining = (self.goal - self.current_progress);
  update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_kill_airborne_aliens() {
  reset_kill_airborne_aliens_progress();
  update_challenge_progress(0, self.goal);
}

deactivate_kill_airborne_aliens() {
  reset_kill_airborne_aliens_progress();
}

reset_kill_airborne_aliens_progress() {
  default_resetSuccess();
  self.current_progress = 0;
}

update_kill_airborne_aliens(aliens_killed, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.current_progress += aliens_killed;

  if(self.current_progress >= self.goal) {
    self.success = true;
  }

  remaining = (self.goal - self.current_progress);
  update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

activate_melee_only() {
  reset_melee_only_progress();
}
deactivate_melee_only() {
  reset_melee_only_progress();
}

reset_melee_only_progress() {
  default_resetSuccess();
}

update_melee_only(unused_1, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.success = false;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

pre_activate_stay_within_area() {
  ring_location = get_challenge_ring_location(level.current_hive_name);
  trace = bulletTrace(ring_location + (0, 0, 20), ring_location - (0, 0, 20), false, undefined, true, false, true, true);

  self.ring_ent = spawn("script_model", trace["position"]);
  self.ring_ent setModel("tag_origin");
  wait(0.1);
  self.ring_fx = playFXOnTag(level._effect["challenge_ring"], self.ring_ent, "tag_origin");

  return true;
}

activate_stay_within_area() {
  default_resetSuccess();
  self.current_progress = 0;
  self.distance_check = 150 * 150;
  update_challenge_progress(0, self.goal);
}

update_stay_within_area(alien_pos, player_pos, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  if(abs(player_pos[2] - self.ring_ent.origin[2]) > 75) {
    return;
  }
  dist = distancesquared(player_pos, self.ring_ent.origin);
  if(dist > self.distance_check) {
    return;
  }
  self.current_progress++;

  if(self.current_progress >= self.goal) {
    self.success = true;
  }

  remaining = (self.goal - self.current_progress);
  update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}
deactivate_stay_within_area() {
  level notify("ring_challenge_ended");
  self.current_progress = 0;
  self.ring_ent delete();
  self.ring_fx = undefined;
  if(isDefined(level.ring_waypoint_icon)) {
    level.ring_waypoint_icon destroy();
  }
  default_resetSuccess();
}

activate_kill_10_in_30() {
  default_resetSuccess();
  self.current_progress = 0;

  challenge_time = int(gettime() + 30000);
  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_timer", challenge_time);
  }
  level.current_challenge_timer = 30;
  level thread update_current_challenge_timer();
  update_challenge_progress(0, self.goal);
  level thread kill_10_in_30_timer(self);
}

kill_10_in_30_timer(challenge) {
  level endon("game_ended");
  self endon("success");
  wait(30);
  self.success = false;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

update_kill_10_in_30(num_killed, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9) {
  self.current_progress += num_killed;

  if(self.current_progress >= self.goal) {
    self.success = true;
    self notify("success");
  }

  remaining = (self.goal - self.current_progress);
  update_challenge_progress(self.current_progress, self.goal);

  if(self.success) {
    maps\mp\alien\_challenge::deactivate_current_challenge();
  }
}

update_alien_death_challenges(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration) {
  if(!isDefined(level.current_challenge)) {
    return;
  }
  current_challenge = level.current_challenge;

  if(isDefined(level.custom_death_challenge_func)) {
    continue_processing_challenges = self[[level.custom_death_challenge_func]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, deathAnimDuration);

    if(!is_true(continue_processing_challenges)) {
      return;
    }
  }

  attacker_is_player = isDefined(eAttacker) && isPlayer(eAttacker);
  attacker_defined = isDefined(eAttacker);
  inflictor_is_player = isDefined(eInflictor) && isPlayer(eInflictor);
  inflictor_defined = isDefined(eInflictor);
  alien_type = self get_alien_type();
  weapon_defined = isDefined(sWeapon);

  explosive_kill = false;
  if(weapon_defined) {
    explosive_kill = is_explosive_kill(sWeapon);
  }

  is_trap_kill = false;
  if(inflictor_defined) {
    is_trap_kill = is_trap(eInflictor);
  }

  switch (current_challenge) {
    case "pistols_only":
    case "shotguns_only":
    case "snipers_only":
    case "lmgs_only":
    case "ar_only":
    case "smg_only":
      if(weapon_defined && sMeansOfDeath != "MOD_MELEE") {
        isArcDeath = is_arc_death(eInflictor, eAttacker, attacker_defined, attacker_is_player, inflictor_defined, inflictor_is_player);
        if(!inflictor_defined || inflictor_is_player || isArcDeath) {
          if(isArcDeath) {
            maps\mp\alien\_challenge::update_challenge(current_challenge, sWeapon, sMeansofDeath, isArcDeath);
          }
          else {
            maps\mp\alien\_challenge::update_challenge(current_challenge, sWeapon, sMeansofDeath);
          }
        }
      }
      break;

    case "melee_5_goons":
      if(alien_type == "goon" && attacker_is_player && sMeansOfDeath == "MOD_MELEE") {
        maps\mp\alien\_challenge::update_challenge("melee_5_goons", 1);
      }
      break;

    case "melee_spitter":
      if(alien_type == "spitter" && attacker_is_player && sMeansOfDeath == "MOD_MELEE") {
        maps\mp\alien\_challenge::update_challenge("melee_spitter", 1);
      }
      break;

    case "melee_only":
      if(attacker_is_player && sMeansOfDeath != "MOD_MELEE") {
        maps\mp\alien\_challenge::update_challenge("melee_only");
      }
      break;

    case "kill_airborne_aliens":
      if(attacker_is_player && isDefined(self.trajectoryActive) && self.trajectoryActive) {
        maps\mp\alien\_challenge::update_challenge("kill_airborne_aliens", 1);
      }
      else if(attacker_is_player && (is_true(self.in_air) || alien_type == "bomber") && sMeansOfDeath != "MOD_SUICIDE") {
        maps\mp\alien\_challenge::update_challenge("kill_airborne_aliens", 1);
      }
      else if(attacker_is_player && alien_type == "ancestor") {
        maps\mp\alien\_challenge::update_challenge("kill_airborne_aliens", 1);
      }
      break;

    case "stay_prone":
      if((attacker_is_player || inflictor_is_player) && eAttacker GetStance() == "prone") {
        maps\mp\alien\_challenge::update_challenge("stay_prone", 1);
      }
      break;

    case "kill_10_with_turrets":
      if(attacker_is_player && weapon_defined && maps\mp\alien\_damage::isAlienTurret(sWeapon)) {
        maps\mp\alien\_challenge::update_challenge("kill_10_with_turrets", 1);
      }
      else if(attacker_defined && isDefined(eAttacker.classname) && eAttacker.classname == "misc_turret" && weapon_defined && maps\mp\alien\_damage::isAlienTurret(sWeapon)) {
        maps\mp\alien\_challenge::update_challenge("kill_10_with_turrets", 1);
      }
      break;

    case "stay_within_area":
      if(attacker_is_player) {
        maps\mp\alien\_challenge::update_challenge("stay_within_area", self.origin, eAttacker.origin);
      }
      break;

    case "kill_10_in_30":
      if(attacker_is_player) {
        maps\mp\alien\_challenge::update_challenge("kill_10_in_30", 1);
      }
      break;

    case "kill_10_with_propane":
      if(weapon_defined && sWeapon == "alienpropanetank_mp") {
        maps\mp\alien\_challenge::update_challenge("kill_10_with_propane", 1);
      }
      else if(inflictor_defined && isDefined(eInflictor.classname) && eInflictor.classname == "trigger_radius") {
        maps\mp\alien\_challenge::update_challenge("kill_10_with_propane", 1);
      }
      break;

    case "kill_10_with_traps":
      if(is_trap_kill) {
        maps\mp\alien\_challenge::update_challenge("kill_10_with_traps", 1);
      }
      break;
  }
}

is_arc_death(eInflictor, eAttacker, attacker_defined, attacker_is_player, inflictor_defined, inflictor_is_player) {
  return (attacker_defined &&
    attacker_is_player &&
    inflictor_defined &&
    !inflictor_is_player &&
    isDefined(eAttacker.stun_struct) &&
    isDefined(eAttacker.stun_struct.attack_bolt) &&
    eInflictor == eAttacker.stun_struct.attack_bolt);
}

update_alien_damage_challenge(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, alien) {
  if(!isDefined(level.current_challenge)) {
    return;
  }
  if(level.current_challenge == "melee_only" && sMeansOfDeath != "MOD_MELEE" && !is_flaming_stowed_riotshield_damage(sMeansOfDeath, sWeapon, eInflictor) && IsPlayer(eAttacker)) {
    maps\mp\alien\_challenge::update_challenge("melee_only");
  }

  if(isDefined(eAttacker) && isPlayer(eAttacker)) {
    if(isDefined(level.custom_damage_challenge_func)) {
      continue_processing_challenges = self[[level.custom_damage_challenge_func]](eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, timeOffset, alien);
      if(!is_true(continue_processing_challenges)) {
        return;
      }
    }

    eAttacker endon("disconnect");
    waitframe();

    if(isDefined(eAttacker.fired_weapon)) {
      if(isDefined(sWeapon) && sWeapon == "alienpropanetank_mp" || sWeapon == "spore_pet_beam_mp") {
        return;
      }

      if(isDefined(eInflictor) && isDefined(eInflictor.classname) && eInflictor.classname == "trigger_radius") {
        return;
      }
      if(isDefined(sMeansOfDeath) && sMeansOfDeath == "MOD_MELEE") {
        return;
      }
      if(iDFlags & 8) {
        return;
      }

      if(maps\mp\alien\_damage::isAlienNonMannedTurret(sWeapon)) {
        return;
      }

      if(sMeansOfDeath == "MOD_EXPLOSIVE_BULLET" && sHitLoc == "none") {
        return;
      }

      if(isDefined(sWeapon) && sWeapon == "alienims_projectile_mp") {
        return;
      }

      if(isDefined(sWeapon) && getWeaponClass(sWeapon) == "weapon_shotgun") {
        eAttacker.fired_weapon = undefined;
      }

      if(isDefined(level.current_challenge)) {
        if(level.current_challenge == "75_percent_accuracy") {
          maps\mp\alien\_challenge::update_challenge("75_percent_accuracy", 1);
        }
        else if(level.current_challenge == "50_percent_accuracy") {
          maps\mp\alien\_challenge::update_challenge("50_percent_accuracy", 1);
        }
      }

      eAttacker.fired_weapon = undefined;
    }
  }
}

is_explosive_kill(sWeapon) {
  switch (sWeapon) {
    case "aliensemtex_mp":
    case "alienbetty_mp":
    case "alienclaymore_mp":
    case "iw6_alienmk32_mp":
    case "iw6_alienmk321_mp":
    case "iw6_alienmk322_mp":
    case "iw6_alienmk323_mp":
    case "iw6_alienmk324_mp":
      return true;
    default:
      return false;
  }
}

clear_last_alien_damaged_time() {
  self endon("disconnect");
  wait(.05);
  self.last_alien_damaged_time = undefined;
}

update_alien_weapon_challenges(weapon, sMeansOfDeath) {
  if(!isDefined(level.current_challenge)) {
    return;
  }
  switch (level.current_challenge) {
    case "pistols_only":
    case "shotguns_only":
    case "snipers_only":
    case "lmgs_only":
    case "ar_only":
    case "smg_only":
      maps\mp\alien\_challenge::update_challenge(level.current_challenge, weapon, sMeansofDeath);
      break;

    default:
      return;
  }

}

update_challenge_progress(current_val, max_val) {
  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_progress_current", int(current_val));
    player setClientOmnvar("ui_intel_progress_max", int(max_val));
  }

  level.current_challenge_progress_max = max_val;
  level.current_challenge_progress_current = current_val;
}

update_challenge_percent(percent) {
  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_percent", percent);
  }
  level.current_challenge_percent = percent;
}

update_percent_accuracy(challenge) {
  level endon("deactivate_track_accuracy");
  last_accuracy = 0;
  last_accuracy_count = 0;
  while(1) {
    if((challenge.total_shots_hit == 0 && challenge.total_shots_fired == 0) || challenge.total_shots_fired < 1) {
      wait(0.25);
      continue;
    }
    accuracy = int((challenge.total_shots_hit / challenge.total_shots_fired) * 10000);

    if(accuracy > 10000) {
      accuracy = 10000;
    }

    trimmed_accuracy = accuracy / 100;
    challenge.current_accuracy = trimmed_accuracy;
    if(accuracy == last_accuracy) {
      last_accuracy_count++;
      if(last_accuracy_count > 2) {
        update_challenge_percent(accuracy);
        last_accuracy_count = 0;
      }
    } else {
      last_accuracy_count = 0;
    }
    wait .05;
    last_accuracy = accuracy;
  }
}

fail_challenge(challenge) {
  challenge.success = false;
  maps\mp\alien\_challenge::deactivate_current_challenge();
}

track_percent_accuracy_shots_fired(challenge) {
  foreach(player in level.players) {
    if(!isAlive(player)) {
      continue;
    }
    player thread track_percent_accuracy_shots_fired_internal(challenge);
  }
}
track_percent_accuracy_shots_fired_internal(challenge) {
  level endon("deactivate_track_accuracy");
  self endon("disconnect");
  self endon("death");

  self childthread track_percent_accuracy_misc_shots_fired(challenge);

  while(1) {
    self waittill("weapon_fired", wpn);

    if(!weapon_should_count_towards_accuracy_challenge(wpn)) {
      continue;
    }
    self.fired_weapon = true;
    challenge.total_shots_fired++;
  }
}

track_percent_accuracy_misc_shots_fired(challenge) {
  level endon("deactivate_track_accuracy");
  self endon("disconnect");
  self endon("death");

  while(1) {
    self waittill_any("turret_fire", "nx1_large_fire");
    self.fired_weapon = true;
    challenge.total_shots_fired++;
  }
}

update_current_challenge_timer() {
  level endon("stop_challenge_timer");
  while(level.current_challenge_timer > 0) {
    wait(.1);
    level.current_challenge_timer = level.current_challenge_timer - 0.1;
  }
}

weapon_should_count_towards_accuracy_challenge(wpn) {
  switch (wpn) {
    case "alienbomb_mp":
    case "alienclaymore_mp":
    case "bouncingbetty_mp":
    case "alientrophy_mp":
    case "deployable_vest_marker_mp":
    case "aliendeployable_crate_marker_mp":
    case "alienpropanetank_mp":
    case "alien_turret_marker_mp":
    case "switchblade_laptop_mp":
    case "mortar_detonator_mp":
      return false;
  }
  return true;
}

get_challenge_scalar(challenge_name) {
  return [[level.challenge_scalar_func]](challenge_name);
}

default_challenge_scalar_func(challenge_name) {
  switch (challenge_name) {
    case "pistols_only":
    case "snipers_only":
    case "shotguns_only":
    case "ar_only":
    case "smg_only":
    case "lmgs_only":
      switch (level.players.size) {
        case 1:
          return 15;
        case 2:
          return 20;
        case 3:
        case 4:
          return 25;
      }

    case "kill_10_with_propane":
    case "kill_10_with_traps":
    case "kill_10_with_turrets":
      switch (level.players.size) {
        case 1:
          return 5;
        case 2:
        case 3:
        case 4:
          return 10;
      }

    case "kill_10_in_30":
      switch (level.players.size) {
        case 1:
          return 5;
        case 2:
        case 3:
        case 4:
          return 10;
      }

    case "stay_within_area":
      switch (level.players.size) {
        case 1:
          return 10;
        case 2:
        case 3:
        case 4:
          return 20;
      }

    case "kill_airborne_aliens":
      switch (level.players.size) {
        case 1:
          return 3;
        case 2:
        case 3:
        case 4:
          return 5;
      }

    case "stay_prone":
      switch (level.players.size) {
        case 1:
          return 15;
        case 2:
        case 3:
        case 4:
          return 25;
      }
    case "spend_20k":
      switch (level.players.size) {
        case 1:
          return 6;
        case 2:
          return 10;
        case 3:
          return 15;
        case 4:
          return 20;
      }
    case "spend_10k":
      switch (level.players.size) {
        case 1:
          return 6;
        case 2:
        case 3:
        case 4:
          return 10;
      }

    case "melee_5_goons":
      switch (level.players.size) {
        case 1:
          return 5;
        case 2:
          return 10;
        case 3:
          return 10;
        case 4:
          return 15;
      }

  }
  return undefined;
}

show_barrier_hive_intel() {
  CONST_CHALLENGE_HIVE_INTEL = 52;
  CONST_BARRIER_HIVE_TITLE = 2;

  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_title", CONST_BARRIER_HIVE_TITLE);
    player SetClientOmnvar("ui_intel_active_index", CONST_CHALLENGE_HIVE_INTEL);
  }

  level.current_challenge_title = CONST_BARRIER_HIVE_TITLE;
  level.current_challenge_index = CONST_CHALLENGE_HIVE_INTEL;
}

hide_barrier_hive_intel() {
  foreach(player in level.players) {
    player SetClientOmnvar("ui_intel_active_index", -1);
    player SetClientOmnvar("ui_intel_title", -1);
  }

  level.current_challenge_title = -1;
  level.current_challenge_index = -1;
}

get_challenge_ring_location(hive_name) {
  if(isDefined(level.challenge_ring_location_func)) {
    return [[level.challenge_ring_location_func]](hive_name);
  }

  return undefined;
}

create_challenge_waypoints(item) {
  wayPoint_SHADER = "waypoint_alien_weapon_challenge";
  wayPoint_WIDTH = 14;
  wayPoint_HEIGHT = 14;
  wayPoint_ALPHA = 0.75;
  wayPoint_POS = item.origin;

  if(level.script == "mp_alien_armory") {
    wayPoint_ALPHA = 0;
  }

  waypoint_icon = maps\mp\alien\_hud::make_wayPoint(wayPoint_SHADER, wayPoint_WIDTH, wayPoint_HEIGHT, wayPoint_ALPHA, wayPoint_POS);

  return waypoint_icon;
}

setup_challenge_waypoints(challenge) {
  current_area = get_current_area_name();

  current_challenge = level.current_challenge;

  if(current_challenge == "pistols_only") {
    return;
  }
  challenge_weapons = get_challenge_weapons(current_area, current_challenge);

  self.challenge_weapons = [];

  foreach(weapon in challenge_weapons) {
    self.challenge_weapons[self.challenge_weapons.size] = getBaseWeaponName(weapon);
  }
}

get_challenge_weapons(current_area, current_challenge) {
  challenge_weapon_class = get_weapon_class_for_current_challenge(current_challenge);

  if(!isDefined(challenge_weapon_class) && current_challenge == "semi_autos_only")

  {
    challenge_weapon_class = ["weapon_dmr", "weapon_sniper"];
  }

  possible_weapons = [];

  waypoints = [];

  foreach(item in level.world_items) {
    if(level.script == "mp_alien_armory") {
      if(isDefined(item.script_noteworthy) && item.script_noteworthy == "weapon_iw6_aliendlc15_mp") {
        item.areas = [];
        item.areas[0] = "checkpoint";
      }
    }
    if(isDefined(item.areas) && item.areas[0] == current_area) {
      if(!isDefined(item.script_noteworthy)) {
        continue;
      }
      base_weapon = GetSubStr(item.script_noteworthy, 7);

      WeaponClass = getWeaponClass(base_weapon);
      if(IsArray(challenge_weapon_class)) {
        if(array_contains(challenge_weapon_class, WeaponClass)) {
          possible_weapons[possible_weapons.size] = base_weapon;

          waypoint = create_challenge_waypoints(item);
          waypoints[waypoints.size] = waypoint;
        }
      } else {
        if(challenge_weapon_class != WeaponClass) {
          continue;
        }
        possible_weapons[possible_weapons.size] = base_weapon;

        waypoint = create_challenge_waypoints(item);
        waypoints[waypoints.size] = waypoint;
      }
    }
  }
  self.waypoints = waypoints;

  return possible_weapons;
}

get_weapon_class_for_current_challenge(current_challenge) {
  switch (current_challenge) {
    case "ar_only":
      return "weapon_assault";
    case "snipers_only":
      return "weapon_sniper";
    case "smg_only":
      return "weapon_smg";
    case "lmgs_only":
      return "weapon_lmg";
    case "shotguns_only":
      return "weapon_shotgun";
  }
}

deactivate_weapon_challenge_waypoints() {
  if(isDefined(self) && isDefined(self.waypoints)) {
    foreach(waypoint in self.waypoints) {
      waypoint Destroy();
    }
  }
  default_resetSuccess();
}

focus_fire_update_alien_outline(player) {
  foreach(player in level.players) {
    if(array_contains(self.damaged_by_players, player)) {
      if(isDefined(player.isFeral) && player.isFeral) {
        maps\mp\alien\_outline_proto::enable_outline_for_player(self, player, 4, false, "high");
      } else {
        maps\mp\alien\_outline_proto::disable_outline_for_player(self, player);
      }
    } else {
      maps\mp\alien\_outline_proto::enable_outline_for_player(self, player, 0, false, "high");
    }
  }
}