/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_chaos_laststand.gsc
**********************************************/

#include maps\mp\alien\_laststand;

CONST_CHAOS_SELF_REVIVE_TIME = 15;
CONST_CHAOS_REVIVE_TIME = 3000;
CONST_CHAOS_INITIAL_LASTSTANDS = 3;

chaos_PlayerLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, bleedOutSpawnEntity) {
  gameShouldEnd = chaos_gameShouldEnd(self);

  if(gameShouldEnd) {
    maps\mp\alien\_chaos_utility::chaos_end_game();
  }

  if(is_killed_by_kill_trigger(bleedOutSpawnEntity)) {
    return process_killed_by_kill_trigger(bleedOutSpawnEntity);
  }

  chaos_dropIntoLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, bleedOutSpawnEntity, gameShouldEnd);
}

process_killed_by_kill_trigger(bleedOutSpawnEntity) {
  self setOrigin(bleedOutSpawnEntity.origin);
  maps\mp\alien\_death::set_kill_trigger_event_processed(self, false);

  if(!self.inLastStand) {
    self DoDamage(1000, self.origin);
  }

  return;
}

chaos_dropIntoLastStand(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, bleedOutSpawnEntity, gameShouldEnd) {
  self endon("disconnect");
  level endon("game_ended");

  self notify("last_stand");

  enter_GamemodeSpecificAction();

  enter_laststand();

  if(get_last_stand_count() > 0) {
    chaos_self_revive(gameShouldEnd);
  }
  else {
    wait_to_be_revived(self, self.origin, undefined, undefined, true, CONST_CHAOS_REVIVE_TIME, (0.33, 0.75, 0.24), undefined, false, gameShouldEnd, true);
  }

  self notify("revive");

  exit_laststand();

  exit_GamemodeSpecificAction();
}

chaos_self_revive(gameShouldEnd) {
  self endon("disconnect");
  self endon("revive");
  level endon("game_ended");

  if(self maps\mp\alien\_debug::shouldSelfRevive()) {
    return debug_self_revive();
  }

  self set_in_chaos_self_revive(self, true);
  self take_lastStand(self, 1);
  self register_laststand_ammo();

  return (wait_for_chaos_self_revive(gameShouldEnd, CONST_CHAOS_SELF_REVIVE_TIME));
}

wait_for_chaos_self_revive(gameShouldEnd, duration) {
  if(gameShouldEnd) {
    level waittill("forever");
    return false;
  }

  maps\mp\alien\_hud::set_last_stand_timer(self, duration);
  self common_scripts\utility::waittill_any_timeout(duration, "revive_success");
  maps\mp\alien\_hud::clear_last_stand_timer(self);
  return true;
}

chaos_gameShouldEnd(player_just_down) {
  return (get_team_self_revive_count() == 0 && everyone_else_all_in_lastStand(player_just_down) && no_one_else_in_chaos_self_revive(player_just_down));
}

no_one_else_in_chaos_self_revive(player_just_down) {
  foreach(player in level.players) {
    if(player == player_just_down) {
      continue;
    }
    if(is_in_chaos_self_revive(player)) {
      return false;
    }
  }
  return true;
}

get_team_self_revive_count() {
  total_self_revive_count = 0;

  foreach(player in level.players) {
  total_self_revive_count += player get_last_stand_count();
  }

  return total_self_revive_count;
}

CONST_PRE_GAME_IS_OVER_FLAG = "chaos_pre_game_is_over";

chaos_player_init_laststand() {
  if(common_scripts\utility::flag(CONST_PRE_GAME_IS_OVER_FLAG)) {
    return;
  }
  set_last_stand_count(self, CONST_CHAOS_INITIAL_LASTSTANDS);
  self thread init_selfrevive_icon(CONST_CHAOS_INITIAL_LASTSTANDS);
}

chaos_exit_GamemodeSpecificAction(player) {
  player maps\mp\alien\_damage::setBodyArmor(level.deployablebox_vest_max);
  player notify("enable_armor");
  player set_in_chaos_self_revive(self, false);
  maps\mp\alien\_chaos::process_chaos_event("refill_combo_meter");
}

set_in_chaos_self_revive(player, value) {
  player.in_chaos_self_revive = value;
}
should_instant_revive(attacker) {
  return (isDefined(attacker) && is_in_chaos_self_revive(attacker));
}
is_in_chaos_self_revive(player) {
  return maps\mp\alien\_utility::is_true(player.in_chaos_self_revive);
}