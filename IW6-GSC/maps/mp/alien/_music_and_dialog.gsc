/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_music_and_dialog.gsc
***********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\alien\_utility;

init() {
  while(!isDefined(game["allies"])) {
    wait 0.05;
  }

  game["music"]["spawn_allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "spawn_music";
  game["music"]["defeat_allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "defeat_music";
  game["music"]["victory_allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "victory_music";
  game["music"]["winning_allies"] = "null";
  game["music"]["losing_allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "losing_music";
  game["voice"]["allies"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("allies") + "1mc_";

  game["music"]["spawn_axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "spawn_music";
  game["music"]["defeat_axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "defeat_music";
  game["music"]["victory_axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "victory_music";
  game["music"]["winning_axis"] = "null";
  game["music"]["losing_axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "losing_music";
  game["voice"]["axis"] = maps\mp\gametypes\_teams::getTeamVoicePrefix("axis") + "1mc_";

  game["music"]["losing_time"] = "mp_time_running_out_losing";

  game["music"]["suspense"] = [];
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_01";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_02";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_03";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_04";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_05";
  game["music"]["suspense"][game["music"]["suspense"].size] = "mp_suspense_06";

  game["dialog"]["push_forward"] = "pushforward";

  game["music"]["nuke_music"] = "nuke_music";

  flag_init("alien_music_playing");
  flag_init("exfil_music_playing");

  level thread onPlayerConnect();
  level thread musicController();
  level thread onGameEnded();
  level initAlienVOSystem();
  level thread scriptable_vo_handler();
}

initAlienVOSystem() {
  level.alien_VO_priority_level = ["high", "medium", "low"];
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread onPlayerSpawned();
    player thread initAndStartVOSystem();
  }
}

onPlayerSpawned() {
  self endon("disconnect");

  self waittill("spawned_player");

  if(level.script != "mp_alien_last" && (!level.splitscreen || level.splitscreen && !isDefined(level.playedStartingMusic))) {
    if(!self isSplitscreenPlayer() || self isSplitscreenPlayerPrimary()) {
      self playLocalSound(game["music"]["spawn_" + self.team]);
    }

    if(level.splitscreen) {
      level.playedStartingMusic = true;
    }
  }
}

onGameEnded() {
  level waittill("game_win", winner);

  if(level.teamBased) {
    if(level.splitscreen) {
      if(winner == "allies") {
        wait .01;
      }

      else if(winner == "axis") {
        foreach(player in level.players) {
          if(flag("alien_music_playing")) {
            player StopLocalSound("mp_suspense_01");
            player StopLocalSound("mp_suspense_02");
            player StopLocalSound("mp_suspense_03");
            player StopLocalSound("mp_suspense_04");
            player StopLocalSound("mp_suspense_05");
            player StopLocalSound("mp_suspense_06");
            player StopLocalSound("mus_alien_newwave");
            flag_clear("alien_music_playing");
          }
        }
        flag_set("alien_music_playing");
        playSoundOnPlayers(game["music"]["defeat_allies"], "axis");
      } else
        playSoundOnPlayers(game["music"]["nuke_music"]);
    } else {
      if(winner == "allies") {
        wait .01;

      } else if(winner == "axis") {
        foreach(player in level.players) {
          if(flag("alien_music_playing")) {
            player StopLocalSound("mp_suspense_01");
            player StopLocalSound("mp_suspense_02");
            player StopLocalSound("mp_suspense_03");
            player StopLocalSound("mp_suspense_04");
            player StopLocalSound("mp_suspense_05");
            player StopLocalSound("mp_suspense_06");
            player StopLocalSound("mus_alien_newwave");
            flag_clear("alien_music_playing");
          }
        }
        flag_set("alien_music_playing");
        playSoundOnPlayers(game["music"]["victory_axis"], "axis");
        playSoundOnPlayers(game["music"]["defeat_allies"], "allies");
      } else {
        playSoundOnPlayers(game["music"]["nuke_music"]);
      }
    }
  } else {
    foreach(player in level.players) {
      if(player isSplitscreenPlayer() && !player isSplitscreenPlayerPrimary()) {
        continue;
      }
      if(player.pers["team"] != "allies" && player.pers["team"] != "axis") {
        player playLocalSound(game["music"]["nuke_music"]);
      }
      else if(isDefined(winner) && isPlayer(winner) && player == winner) {
        player playLocalSound(game["music"]["victory_" + player.pers["team"]]);
      }
      else if(!level.splitScreen) {
        player playLocalSound(game["music"]["defeat_" + player.pers["team"]]);
      }
    }
  }
}

musicController() {
  level endon("game_ended");

  thread suspenseMusic();

  level waittill("match_ending_soon", reason);
  assert(isDefined(reason));

  if(getWatchedDvar("roundlimit") == 1 || game["roundsPlayed"] == (getWatchedDvar("roundlimit") - 1)) {
    if(!level.splitScreen) {
      if(reason == "time") {
        if(level.teamBased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            playSoundOnPlayers(game["music"]["losing_axis"], "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            playSoundOnPlayers(game["music"]["losing_allies"], "allies");
          }
        } else {
          playSoundOnPlayers(game["music"]["losing_time"]);
        }
      } else if(reason == "score") {
        if(level.teamBased) {
          if(game["teamScores"]["allies"] > game["teamScores"]["axis"]) {
            playSoundOnPlayers(game["music"]["losing_axis"], "axis");
          } else if(game["teamScores"]["axis"] > game["teamScores"]["allies"]) {
            playSoundOnPlayers(game["music"]["losing_allies"], "allies");
          }
        } else {
          winningPlayer = maps\mp\gametypes\_gamescore::getHighestScoringPlayer();
          losingPlayers = maps\mp\gametypes\_gamescore::getLosingPlayers();
          excludeList[0] = winningPlayer;

          winningPlayer playLocalSound(game["music"]["winning_" + winningPlayer.pers["team"]]);

          foreach(otherPlayer in level.players) {
            if(otherPlayer == winningPlayer) {
              continue;
            }
            otherPlayer playLocalSound(game["music"]["losing_" + otherPlayer.pers["team"]]);
          }
        }
      }

      level waittill("match_ending_very_soon");

    }
  } else {
    if(!level.hardcoreMode) {
      playSoundOnPlayers(game["music"]["losing_allies"]);
    }

  }
}

suspenseMusic() {
  level endon("game_ended");
  level endon("match_ending_soon");
  level endon("nuke_went_off");

  if(isDefined(level.noSuspenseMusic) && level.noSuspenseMusic) {
    return;
  }
  numTracks = game["music"]["suspense"].size;
  wait(120);

  for(;;) {
    wait(randomFloatRange(60, 90));
    if(!flag("alien_music_playing")) {
      playSoundOnPlayers(game["music"]["suspense"][randomInt(numTracks)]);
    }
  }
}

alienPlayerPainBreathingSound() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");

  wait(2);

  while(true) {
    wait(0.2);

    if(shouldPlayPainBreathingSound()) {
      if(self hasFemaleCustomizationModel()) {
        self playLocalSound("Fem_breathing_hurt");
      }
      else {
        self playLocalSound("breathing_hurt_alien");
      }
      wait(.784);
      wait(0.1 + randomfloat(0.8));
    }
  }
}

VERY_HURT_HEALTH = 0.55;
shouldPlayPainBreathingSound() {
  if(maps\mp\gametypes\aliens::isHealthRegenDisabled() ||
    self isUsingRemote() ||
    (isDefined(self.breathingStopTime) && gettime() < self.breathingStopTime) ||
    self.health > self.maxhealth * self.healthRegenMaxPercent * VERY_HURT_HEALTH
  )
    return false;
  else {
    return true;
  }
}

playMusicBeforeReachLayer(time_to_reach_layer) {
  NEW_WAVE_MUSIC_ALIAS = "mus_alien_newwave";

  wave_music_length = 8.5;

  if(time_to_reach_layer <= wave_music_length) {
    return;
  }
  wait(time_to_reach_layer - wave_music_length);

  if(!flag("alien_music_playing")) {
    level thread play_alien_music(NEW_WAVE_MUSIC_ALIAS);
  }
}

playVOForDowned(player) {
  if(maps\mp\alien\_utility::IsPlayingSolo()) {
    return;
  }
  line = player.vo_prefix + "downed";
  player thread play_vo_on_player(line);
}

playVOForRevived(player) {
  line = player.vo_prefix + "reviving";
  player thread play_vo_on_player(line);
}

playVOForWaveStart() {
  wait(3);
  players = get_array_of_valid_players();

  if(players.size < 1) {
    return;
  }
  player = random(players);
  line = player.vo_prefix + "trouble";
  player play_vo_on_player(line);
}

playVOForBombDetonate(hive) {
  level endon("drill_planted");
  level endon("stop_post_hive_vo");

  if(isDefined(level.next_hive_vo_cycle) && level.cycle_count < level.next_hive_vo_cycle) {
    return;
  }
  if(!isDefined(level.next_hive_vo_cycle)) {
    level.next_hive_vo_cycle = level.cycle_count + randomintrange(5, 8);
  }

  if(isDefined(level.should_play_next_hive_vo_func)) {
    if(![
        [level.should_play_next_hive_vo_func]
      ]())
      return;
  }

  counter = 0;
  while(maps\mp\agents\_agent_utility::getActiveAgentsOfType("alien").size > 0) {
    wait(1);
    counter++;
    if(counter > 30) {
      return;
    }
  }

  if(hive is_door() || hive is_door_hive()) {
    level notify("dlc_vo_notify", "open_door_move", hive);
    wait(5);
  } else {
    play_vo_when_aliens_dead();

    wait(3);

    if(randomint(100) > 40) {
      play_vo_for_get_to_crater();
      wait(5);
    }

    if(level.cycle_count > 1) {
      playPosthiveVo();
      wait(5);
    }
  }
  play_vo_for_grab_drill();

  wait(60);

  play_vo_for_next_hive(hive);
}

play_vo_for_next_hive(hive) {
  players = get_array_of_valid_players();

  if(players.size < 1) {
    return;
  }
  player = random(players);

  line = player.vo_prefix + "attack_hive_next";

  player play_vo_on_player(line, undefined, 10);
}

play_vo_for_get_to_crater() {
  players = get_array_of_valid_players();

  if(players.size < 1) {
    return;
  }
  player = random(players);

  if(isDefined(player) && isAlive(player)) {
    line = player.vo_prefix + "stayready";
    player play_vo_on_player(line);
  }
}

play_vo_for_grab_drill() {
  players = get_array_of_valid_players();

  if(players.size < 1) {
    return;
  }
  foreach(player in players) {
    if(isDefined(level.drill_carrier) && level.drill_carrier == player) {
      return;
    }
  }

  player = random(players);

  line = player.vo_prefix + "get_drill";
  if(!SoundExists(line)) {
    line = player.vo_prefix + "order_grab_drill";
  }
  player play_vo_on_player(line, undefined, 10);
}

PlayVOForIntro() {
  players = get_array_of_valid_players();

  if(players.size < 1) {
    return;
  }
  player = random(players);

  if(level.players.size == 1) {
    line = player.vo_prefix + "intro";
    player thread play_solo_vo(line);
    return;
  }

  foreach(player in players) {
    if(isDefined(level.drill_carrier) && level.drill_carrier == player) {
      return;
    }
  }

  line = player.vo_prefix + "intro";
  player play_vo_on_player(line);
}

play_vo_when_aliens_dead() {
  level endon("drill_planted");
  wait(1);
  players = get_array_of_valid_players();

  if(players.size < 1) {
    return;
  }
  player = random(players);
  variants = ["destroyed", "area_clear", "destroyed_hive_area"];
  player play_vo_on_player(player.vo_prefix + random(variants));
}

playPostHiveVo() {
  players = get_array_of_valid_players();

  if(players.size < 1) {
    return;
  }
  player = random(players);

  player play_vo_on_player(player.vo_prefix + "destroyed_hive");
}

playVoForBlockerHiveReward() {
  lines = ["so_alien_plt_hivereward", "so_alien_plt_hivereward2"];
  self play_pilot_vo(random(lines));
}

playVOforBlockerHive() {
  players = get_array_of_valid_players();
  if(players.size > 0) {
    player = random(players);
    player play_vo_on_player(player.vo_prefix + "explode_lung");
  }

  counter = 0;
  while(maps\mp\agents\_agent_utility::getActiveAgentsOfType("alien").size > 0) {
    wait(1);
    counter++;
    if(counter > 30) {
      return;
    }
  }

  hasdrill = false;
  players = get_array_of_valid_players();

  if(players.size < 1) {
    return;
  }
  player = random(players);
  foreach(player in players) {
    if(player hasweapon("alienbomb_mp")) {
      hasdrill = true;
    }
  }
  if(!hasdrill) {
    line = player.vo_prefix + "get_drill";
    player play_vo_on_player(line);
  }
  wait(1);
  if(isDefined(player) && isAlive(player)) {
    line = player.vo_prefix + "stayready";
    player play_vo_on_player(line);
  }

}

playVOForBombPlant(player) {
  if(isPlayingSolo()) {
    return;
  }
  if(!isDefined(player) || !isAlive(player) || player is_in_laststand()) {
    return;
  }
  line = player.vo_prefix + "place_drill";
  player play_vo_on_player(line);
}

playVOForSpitterspawn(alien) {
  wait(3);

  if(!isDefined(alien)) {
    return;
  }
  players = get_array_of_valid_players(true, alien.origin);

  if(players.size < 1) {
    return;
  }
  player = players[0];
  lines = [player.vo_prefix + "near_spitter", player.vo_prefix + "inbound_spitters"];
  player play_vo_on_player(random(lines));
}

playVOForQueenspawn(alien) {
  wait(3);

  if(!isDefined(alien)) {
    return;
  }
  players = get_array_of_valid_players(true, alien.origin);

  if(players.size < 1) {
    return;
  }
  player = players[0];

  lines = [player.vo_prefix + "near_queen", player.vo_prefix + "inbound_queen"];
  player play_vo_on_player(random(lines));
}

playVOForIncomingChopperBlockerHive() {
  chopper_incoming_vo_lines = ["so_alien_plt_morefirepower", "so_alien_blockerhive"];
  self play_pilot_vo(random(chopper_incoming_vo_lines));
}

playVOForProvidingCoverAtBlockerHive() {
  chopper_provide_covering_fire_vo = ["so_alien_plt_providecover", "so_alien_plt_incomming2"];
  self play_pilot_vo(random(chopper_provide_covering_fire_vo));
}

playVOForChopperTakingDamage() {
  variants = ["so_alien_plt_providecover2", "so_alien_plt_scorpiondamage"];
  self play_pilot_vo(random(variants));
}

playVOForChopperTakingTooMuchDamage() {
  self play_pilot_vo("so_alien_plt_toomuchheat");
}

handleFirstEliteArrival(elite) {
  if(level.script != "mp_alien_town" || is_chaos_mode()) {
    return;
  }
  foreach(player in level.players) {
    if(flag("alien_music_playing")) {
      player StopLocalSound("mp_suspense_01");
      player StopLocalSound("mp_suspense_02");
      player StopLocalSound("mp_suspense_03");
      player StopLocalSound("mp_suspense_04");
      player StopLocalSound("mp_suspense_05");
      player StopLocalSound("mp_suspense_06");
      player StopLocalSound("mus_alien_newwave");
      flag_clear("alien_music_playing");
    }
    if(!flag("exfil_music_playing")) {
      level thread play_alien_music("mus_alien_queen");
    }
  }
}

handleLastEliteDeath(elite) {}

Play_Nuke_Set_Music() {
  foreach(player in level.players) {
    if(flag("alien_music_playing")) {
      player StopLocalSound("mp_suspense_01");
      player StopLocalSound("mp_suspense_02");
      player StopLocalSound("mp_suspense_03");
      player StopLocalSound("mp_suspense_04");
      player StopLocalSound("mp_suspense_05");
      player StopLocalSound("mp_suspense_06");
      player StopLocalSound("mus_alien_newwave");
      player StopLocalSound("mus_alien_queen");
      flag_clear("alien_music_playing");
    }
    level thread play_alien_music("mus_alien_nukeset");
    flag_set("exfil_music_playing");
  }
}

Play_Exfil_Music() {
  foreach(player in level.players) {
    if(flag("alien_music_playing")) {
      player StopLocalSound("mus_alien_nukeset");
      flag_clear("alien_music_playing");
    }

    player playLocalSound("mus_alien_exfil");
    flag_set("exfil_music_playing");
  }
}

playVOForDrillDamaged() {
  if(level.script == "mp_alien_last") {
    level notify("dlc_vo_notify", "conduit_attack");
    return;
  }
  BOMB_DAMAGE_COOL_DOWN_TIME = 15000;
  current_time = getTime();

  if(!isDefined(level.next_bomb_damage_VO_time) || level.next_bomb_damage_VO_time < current_time) {
    level.next_bomb_damage_VO_time = current_time + randomintrange(BOMB_DAMAGE_COOL_DOWN_TIME, BOMB_DAMAGE_COOL_DOWN_TIME + 5000);

    players = get_array_of_valid_players();
    player = random(players);

    if(!isDefined(player)) {
      return;
    }
    if(isPlayingSolo()) {
      line = player.vo_prefix + "drill_attacked";

      solo_line = line + "_solo";
      if(SoundExists(solo_line)) {
        player thread play_solo_vo(line, undefined, 10);
        return;
      }
    }

    line = player.vo_prefix + "drill_attacked";
    player play_vo_on_player(line, "high", 10);
  }
}

playVOForDrillHalfway() {
  if(level.script == "mp_alien_last") {
    level notify("dlc_vo_notify", "last_vo", "conduit_halfway");
    return;
  }

  players = get_array_of_valid_players();

  if(players.size < 1) {
    return;
  }
  player = random(players);

  line = player.vo_prefix + "drill_halfway";
  player play_vo_on_player(line, undefined, 10);
}

playVOForDrillOffline() {
  return;
}

PlayVOForSentry(player, sentry_type) {
  if(isPlayingSolo()) {
    return;
  }
  type = "turret_generic";
  switch (sentry_type) {
    case "grenade":
      type = "turret_grenade";
      break;

    case "minigun":
      type = "turret_minigun";
      break;

    case "sentry":
      type = "sentry";
  }

  line = player.vo_prefix + "online_" + type;
  player thread play_vo_on_player(line);
}
playVOForIMS(player) {
  if(isPlayingSolo()) {
    return;
  }
  line = player.vo_prefix + "online_ims";
  player play_vo_on_player(line);
}

playVOForDrone(player) {
  if(isPlayingSolo()) {
    return;
  }
  line = player.vo_prefix + "online_drone";
  player play_vo_on_player(line);
}

playVOForMortarStrike(player) {
  if(isPlayingSolo()) {
    return;
  }
  line = player.vo_prefix + "inbound_mortar";
  player play_vo_on_player(line);
}

playVOForPredator(player) {
  if(isPlayingSolo()) {
    return;
  }
  line = player.vo_prefix + "inbound_missile";
  player play_vo_on_player(line);
}

PlayVOForTeamAmmo(player) {
  line = player.vo_prefix + "drop_ammo";

  if(isPlayingSolo()) {
    if(randomint(100) > 50) {
      return;
    }
    line = player.vo_prefix + "equip_ammo_solo";
  }

  player thread play_vo_on_player(line);
}

PlayVOForSpecialAmmo(player) {
  line = player.vo_prefix + "ready_specialammo";

  if(isPlayingSolo()) {
    if(randomint(100) > 50) {
      return;
    }
    line = player.vo_prefix + "equip_ammo_solo";
  }

  player thread play_vo_on_player(line);
}

PlayVOForTeamBoost(player) {
  line = player.vo_prefix + "deployed_boosters";

  if(isPlayingSolo()) {
    if(randomint(100) > 50) {
      return;
    }
    line = player.vo_prefix + "equip_ammo_solo";
  }

  player thread play_vo_on_player(line);
}

PlayVOForSupportItems(player) {
  line = player.vo_prefix + "inform_supportitems";

  if(isPlayingSolo()) {
    if(randomint(100) > 50) {
      return;
    }
    line = player.vo_prefix + "equip_ammo_solo";
  }
  player thread play_vo_on_player(line);
}

PlayVOForRandombox(player) {
  line = player.vo_prefix + "inform_supplies";

  if(isPlayingSolo()) {
    if(randomint(100) > 50) {
      return;
    }
    line = player.vo_prefix + "equip_ammo_solo";
  }
  player thread play_vo_on_player(line);
}

PlayVOForTeamArmor(player) {
  line = player.vo_prefix + "drop_armor";

  if(randomint(100) > 50) {
    line = player.vo_prefix + "inform_armor";
  }

  if(isPlayingSolo()) {
    if(randomint(100) > 50) {
      return;
    }
    line = player.vo_prefix + "equip_ammo_solo";
  }

  player thread play_vo_on_player(line);
}

playVOForDeathMachine(player) {
  line = player.vo_prefix + "online_machine_death";
  player play_vo_on_player(line);
}

playVOForWarMachine(player) {
  line = player.vo_prefix + "online_machine_war";
  player play_vo_on_player(line);
}

PlayVOForMeteor() {
  METEOR_VO_COOL_DOWN_TIME = 30000;
  current_time = getTime();

  if(!isDefined(level.next_meteor_vo_time) || level.next_meteor_vo_time < current_time) {
    level.next_meteor_vo_time = current_time + randomintrange(METEOR_VO_COOL_DOWN_TIME, METEOR_VO_COOL_DOWN_TIME + 5000);

    players = get_array_of_valid_players();
    player = random(players);
    if(!isDefined(player)) {
      return;
    }
    line = player.vo_prefix + "inbound_meteor";
    player play_vo_on_player(line);
  }
}

PlayVOForMinions() {
  MINION_VO_COOL_DOWN_TIME = 30000;
  current_time = getTime();

  if(!isDefined(level.next_minion_vo_time) || level.next_minion_vo_time < current_time) {
    level.next_minion_vo_time = current_time + randomintrange(MINION_VO_COOL_DOWN_TIME, MINION_VO_COOL_DOWN_TIME + 5000);

    players = get_array_of_valid_players();

    if(players.size < 1) {
      return;
    }
    player = random(players);

    line = player.vo_prefix + "inbound_minions";
    player play_vo_on_player(line);
  }
}

playVOForTrapActivation(player, trap_type) {
  line = player.vo_prefix + "activated_trap_generic";
  switch (trap_type) {
    case "traps_fire":
      line = player.vo_prefix + "activated_trap_fire";
      break;
    case "traps_fence":
      line = player.vo_prefix + "online_electricfence";
  }
  player thread play_vo_on_player(line);
}

playVOForPillage(player) {
  alias = player.vo_prefix + "good_loot";

  if(alias_2d_version_exists(player, alias)) {
    player playlocalsound(get_alias_2d_version(player, alias));
  }
  else if(SoundExists(alias)) {
    player playlocalsound(alias);
  }
}

playVOforDrillHot() {
  if(level.script == "mp_alien_last") {
    level notify("dlc_vo_notify", "last_vo", "conduit_damaged");
    return;
  }

  players = get_array_of_valid_players(true, level.drill.origin);
  if(players.size < 1) {
    return;
  }
  player = players[0];
  line = player.vo_prefix + "drill_hot";
  player thread play_vo_on_player(line, undefined, 10);
}

playVOforNukeArmed(player) {
  players = get_array_of_valid_players(true, level.drill.origin);
  if(players.size < 1) {
    return;
  }
  player = players[0];
  line = player.vo_prefix + "nuke_armed";
  player thread play_vo_on_player(line);

  level thread playVOForNukeCountdown();
}

playVOForNukeCountdown() {
  wait(10);
  players = get_array_of_valid_players(true, level.drill.origin);
  if(players.size < 1) {
    return;
  }
  player = players[0];
  line = player.vo_prefix + "nuke_countdown";
  player thread play_vo_on_player(line);
}

playVoFor30Seconds() {
  players = get_array_of_valid_players(true, level.drill.origin);
  if(players.size < 1) {
    return;
  }
  player = players[0];
  line = player.vo_prefix + "30_seconds";
  player thread play_vo_on_player(line);
  wait(5);
  level thread playVOforGetToLz();
}

playVoFor10Seconds() {
  players = get_array_of_valid_players(true, level.drill.origin);
  if(players.size < 1) {
    return;
  }
  player = players[0];
  line = player.vo_prefix + "10_seconds";
  player thread play_vo_on_player(line);
}

playVOforGetToLz() {
  players = get_array_of_valid_players(true, level.drill.origin);
  if(players.size < 1) {
    return;
  }
  player = random(players);
  line = player.vo_prefix + "gettolz";
  player thread play_vo_on_player(line);
}

playVOforAttackChopper(player) {
  line = player.vo_prefix + "inbound_chopper";
  player thread play_vo_on_player(line);
}

playVOforAttackChopperIncoming() {
  self play_pilot_vo("so_alien_plt_teamcallin");
}

PlayVOForAttackChopperLeaving() {
  self play_pilot_vo("so_alien_plt_hivesuccess");
}

PlayMedicClassSkillVO(player) {
  line = player.vo_prefix + "medic_skill";

  player thread play_vo_on_player(line);
}

PlayEngineerClassSkillVO(player) {
  line = player.vo_prefix + "engr_skill";

  player thread play_vo_on_player(line);
}

PlayWeaponClassSkillVO(player) {
  line = player.vo_prefix + "weap_skill";

  player thread play_vo_on_player(line);
}

PlayTankClassSkillVO(player) {
  line = player.vo_prefix + "tank_skill";

  player thread play_vo_on_player(line);
}

playRandomVOline(vo_list, priority, timeout, interrupt) {
  random_index = RandomInt(vo_list.size);
  vo_alias = vo_list[random_index];
  playVOToAllPlayers(vo_alias, priority, timeout, interrupt);
}

play_vo_on_player(alias, priority, timeout, interrupt, pause_time, only_local) {
  self add_to_VO_system(alias, priority, timeout, interrupt, pause_time, only_local);
}

playVOToAllPlayers(alias, priority, timeout, interrupt, pause_time) {
  foreach(player in level.players) {
  player add_to_VO_system(alias, priority, timeout, interrupt, pause_time);
  }
}

add_to_VO_system(alias, priority, timeout, interrupt, pause_time, only_local) {
  self thread add_to_VO_system_internal(alias, priority, timeout, interrupt, pause_time, only_local);
}

add_to_VO_system_internal(alias, priority, timeout, interrupt, pause_time, only_local) {
  priority = get_validated_priority(priority);

  VO_data = create_VO_data(alias, timeout, pause_time, only_local);

  if(should_interrupt_VO_system(interrupt)) {
    add_to_interrupt_VO(VO_data);

    if(is_VO_system_playing()) {
      interrupt_current_VO();
    }
  } else {
    add_to_queue_at_priority(VO_data, priority);
  }

  if(!is_VO_system_playing()) {
    play_VO_system();
  }
}

get_validated_priority(priority) {
  if(!isDefined(priority)) {
    return level.alien_VO_priority_level[level.alien_VO_priority_level.size - 1];
  }

  AssertEx(array_contains(level.alien_VO_priority_level, priority), "'" + priority + "' is not a valid priority level.");
  return priority;
}

play_VO_system() {
  self notify("play_VO_system");
}

interrupt_current_VO() {
  self stopLocalSound(get_current_VO_alias());
  self notify("interrupt_current_VO");
}

start_VO_system() {
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    VO_to_play = get_VO_to_play();

    if(!isDefined(VO_to_play)) {
      set_VO_system_playing(false);

      self waittill("play_VO_system");

      if(is_VO_system_paused()) {
        self waittill("unpause_VO_system");
      }

      continue;
    }

    set_VO_system_playing(true);

    set_VO_currently_playing(VO_to_play);

    play_VO(VO_to_play);

    pause_between_VO(VO_to_play);

    unset_VO_currently_playing();
  }
}

playVOForScriptable(scriptable_name) {
  SCRIPTABLE_VO_COOL_DOWN_TIME = 45000;
  current_time = getTime();

  if(!isDefined(level.next_scriptable_vo_time) || level.next_scriptable_vo_time < current_time) {
    if(isDefined(level.next_scriptable_vo_time)) {
      if(randomint(100) < 60) {
        return;
      }
    }

    level.next_scriptable_vo_time = current_time + randomintrange(SCRIPTABLE_VO_COOL_DOWN_TIME, SCRIPTABLE_VO_COOL_DOWN_TIME + 5000);

    players = get_array_of_valid_players();
    player = random(players);
    if(!isDefined(player)) {
      return;
    }
    switch (scriptable_name) {
      case "scriptable_alien_tatra_t815_jump":
      case "scriptable_alien_lynx_jump":

        line = player.vo_prefix + "alien_approach_truck";
        player play_vo_on_player(line);
        break;
    }
  }
}

play_VO(VO_to_play) {
  self endon("interrupt_current_VO");

  if(self.sessionstate != "playing") {
    return;
  }
  alias = VO_to_play.alias;
  if(!SoundExists(alias)) {
    PrintLn("^1*****SOUND ALIAS MISSING*****: ^7" + alias);
    wait(.1);
    return;
  }

  if(self is_in_laststand() && !(IsSubStr(alias, "downed") || IsSubStr(alias, "last_stand"))) {
    return;
  }
  self.vo_system_playing_vo = true;
  foreach(player in level.players) {
    if(player isSplitScreenPlayer() && !player isSplitScreenPlayerPrimary()) {
      continue;
    }
    if(player == self) {
      if(alias_2d_version_exists(player, alias)) {
        player playlocalsound(get_alias_2d_version(player, alias));
      }
      else {
        player playlocalsound(alias);
      }
    } else {
      if(!is_true(VO_to_play.only_local)) {
        self playSoundToPlayer(alias, player);
      }
    }
  }

  wait(get_sound_length(alias));
  self.vo_system_playing_vo = false;
}

create_VO_data(alias, timeout, pause_time, only_local) {
  DEFAULT_TIMEOUT = 999;
  MIN_BETWEEN_VO_WAIT = 1.5;
  MAX_BETWEEN_VO_WAIT = 3;

  VO_data = spawnStruct();
  VO_data.alias = alias;

  if(!isDefined(timeout)) {
    timeout = DEFAULT_TIMEOUT;
  }

  VO_data.expire_time = getTime() + timeout * 1000;

  if(!isDefined(pause_time)) {
    pause_time = randomFloatRange(MIN_BETWEEN_VO_WAIT, MAX_BETWEEN_VO_WAIT);
  }

  VO_data.pause_time = pause_time;

  if(is_true(only_local)) {
    VO_data.only_local = true;
  }
  else {
    VO_data.only_local = false;
  }

  return VO_data;
}

get_VO_to_play() {
  VO_to_play = retrieve_interrupt_VO();
  if(isDefined(VO_to_play)) {
    return VO_to_play;
  }

  foreach(array_index, priority_level in level.alien_VO_priority_level) {
    VO_to_play = retrieve_VO_from_queue(priority_level);
    if(isDefined(VO_to_play)) {
      return VO_to_play;
    }
  }

  return undefined;
}

retrieve_interrupt_VO() {
  interrupt_VO = self.VO_system.interrupt_VO;
  reset_interrupt_VO();
  return interrupt_VO;
}

retrieve_VO_from_queue(priority) {
  remove_expired_VO_from_queue(priority);
  return pop_first_VO_out_of_queue(priority);
}

pop_first_VO_out_of_queue(priority) {
  first_VO = self.VO_system.VO_queue[priority][0];
  if(!isDefined(first_VO)) {
    return first_VO;
  }

  new_array = [];
  for(array_index = 1; array_index < self.VO_system.VO_queue[priority].size; array_index++) {
    if(!isDefined(self.VO_system.VO_queue[priority][array_index])) {
      break;
    }

    new_array[array_index - 1] = self.VO_system.VO_queue[priority][array_index];
  }
  self.VO_system.VO_queue[priority] = new_array;
  return first_VO;
}

remove_expired_VO_from_queue(priority) {
  current_time = getTime();
  new_array = [];
  foreach(array_index, VO_data in self.VO_system.VO_queue[priority]) {
    if(!VO_expired(VO_data, current_time)) {
      new_array[new_array.size] = self.VO_system.VO_queue[priority][array_index];
    }
  }
  self.VO_system.VO_queue[priority] = new_array;
}

initAndStartVOSystem() {
  self init_VO_system();

  self thread start_VO_system();
}

init_VO_system() {
  VO_system = spawnStruct();
  VO_system.VO_currently_playing = undefined;
  VO_system.interrupt_VO = undefined;
  VO_system.is_playing = false;

  VO_queue = [];
  foreach(array_index, priority_level in level.alien_VO_priority_level) {
    VO_queue[priority_level] = [];
  }
  VO_system.VO_queue = VO_queue;

  self.VO_system = VO_system;
}

pause_between_VO(VO_to_play) {
  if(is_VO_system_paused()) {
    self waittill("unpause_VO_system");
  }

  if(VO_to_play.pause_time > 0) {
    wait VO_to_play.pause_time;
  }
}

is_VO_system_paused() {
  return is_true(self.pause_VO_system);
}

pause_VO_system(player_list) {
  foreach(player in player_list) {
  player.pause_VO_system = true;
  }
}

unpause_VO_system(player_list) {
  foreach(player in player_list) {
    player.pause_VO_system = false;
  }
  foreach(player in player_list) {
    player notify("unpause_VO_system");
  }
}

VO_expired(VO_data, current_time) {
  return (current_time > VO_data.expire_time);
}

add_to_queue_at_priority(VO_data, priority) {
  self.VO_system.VO_queue[priority][self.VO_system.VO_queue[priority].size] = VO_data;
}

is_VO_system_playing() {
  return self.VO_system.is_playing;
}

set_VO_system_playing(bool) {
  self.VO_system.is_playing = bool;
}

set_VO_currently_playing(VO_to_play) {
  self.VO_system.VO_currently_playing = VO_to_play;
}

unset_VO_currently_playing() {
  self.VO_system.VO_currently_playing = undefined;
}

should_interrupt_VO_system(interrupt) {
  return (isDefined(interrupt) && interrupt);
}

add_to_interrupt_VO(VO_data) {
  self.VO_system.interrupt_VO = VO_data;
}

get_current_VO_alias() {
  return self.VO_system.VO_currently_playing.alias;
}

reset_interrupt_VO() {
  self.VO_system.interrupt_VO = undefined;
}

scriptable_vo_handler() {
  level endon("game_ended");
  level.scriptable_vo_played = [];
  while(1) {
    level waittill("scriptable", scriptable_name);
    level thread playVOForScriptable(scriptable_name);
  }
}

player_pain_vo() {
  PAIN_VO_COOL_DOWN_TIME = 1500;
  current_time = getTime();

  if(!isDefined(self.next_pain_vo_time)) {
    self.next_pain_vo_time = current_time + randomintrange(PAIN_VO_COOL_DOWN_TIME, PAIN_VO_COOL_DOWN_TIME + 2000);
  } else if(current_time < self.next_pain_vo_time) {
    return;
  }
  if(self.vo_prefix == "p1_") {
    self PlayLocalSound("female_death_american_1_plr");
  }
  if(self.vo_prefix == "p2_") {
    self PlayLocalSound("generic_death_american_1_plr");
  }
  if(self.vo_prefix == "p3_") {
    self PlayLocalSound("generic_death_american_2_plr");
  }
  if(self.vo_prefix == "p4_") {
    self PlayLocalSound("generic_death_american_3_plr");
  }

  self.next_pain_vo_time = current_time + randomintrange(PAIN_VO_COOL_DOWN_TIME, PAIN_VO_COOL_DOWN_TIME + 1500);
}

play_pilot_vo(alias) {
  sound_length = get_sound_length(alias);
  self playSound(alias);
  wait(sound_length);
}

play_alien_music(alias) {
  if(flag("alien_music_playing")) {
    return;
  }
  sound_length = get_sound_length(alias);

  flag_set("alien_music_playing");

  foreach(player in level.players) {
    if(isReallyAlive(player)) {
      player playLocalSound(alias);
    }
  }

  wait(sound_length);

  flag_clear("alien_music_playing");
}

get_sound_length(alias) {
  return (LookupSoundLength(alias) / 1000);
}

ext_last_stand_sfx() {
  self playlocalsound("mantle_cloth_plr_24_up");
  wait 0.65;
  if(self hasFemaleCustomizationModel()) {
    self playLocalSound("Fem_breathing_better");
  } else {
    self playLocalSound("breathing_better");
  }

}

play_solo_vo(line, priority, timeout, interrupt, pause_time, only_local) {
  solo_line = line + "_solo";
  if(SoundExists(solo_line)) {
    self play_vo_on_player(solo_line);
  }
}

alias_2d_version_exists(player, alias) {
  alias_2d_version = get_alias_2d_version(player, alias);
  return SoundExists(alias_2d_version);
}

get_alias_2d_version(player, alias) {
  end_of_alias = GetSubStr(alias, player.vo_prefix.size);
  return (player.vo_prefix + "plr_" + end_of_alias);
}

remove_VO_data(alias_substring, priority) {
  new_array = [];
  foreach(array_index, VO_data in self.VO_system.VO_queue[priority]) {
    if(!((VO_data.alias == (self.vo_prefix + alias_substring)) || (VO_data.alias == (self.vo_prefix + "plr_" + alias_substring)))) {
      new_array[new_array.size] = self.VO_system.VO_queue[priority][array_index];
    }
  }
  self.VO_system.VO_queue[priority] = new_array;
}