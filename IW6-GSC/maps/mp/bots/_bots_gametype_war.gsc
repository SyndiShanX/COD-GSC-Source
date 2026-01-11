/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_war.gsc
***********************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;
#include maps\mp\bots\_bots_fireteam;

main() {
  setup_callbacks();
  setup_bot_war();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_war_think;
  level.bot_funcs["commander_gametype_tactics"] = ::bot_tdm_apply_commander_tactics;
}

setup_bot_war() {
  if(bot_is_fireteam_mode()) {
    level.bot_team_tdm_personality = "default";
    level.bot_fireteam_buddy_up = false;
  }
}

bot_war_think() {
  self notify("bot_war_think");
  self endon("bot_war_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  while(true) {
    self[[self.personality_update_function]]();
    wait(0.05);
  }
}

bot_tdm_apply_commander_tactics(new_tactic) {
  reset_all_bots = false;
  was_buddied = level.bot_fireteam_buddy_up;
  hunting_party = false;
  level.bot_fireteam_buddy_up = false;
  switch (new_tactic) {
    case "tactic_none":
      level.bot_team_tdm_personality = "revert";
      reset_all_bots = true;
      break;
    case "tactic_war_hp":
      level.bot_team_tdm_personality = "revert";
      level thread fireteam_tdm_find_hunt_zone(self.team);
      hunting_party = true;
      reset_all_bots = true;
      break;
    case "tactic_war_buddy":
      level.bot_team_tdm_personality = "revert";
      level.bot_fireteam_buddy_up = true;
      reset_all_bots = true;
      break;
    case "tactic_war_hyg":
      level.bot_team_tdm_personality = "camper";
      reset_all_bots = true;
      break;
  }

  if(!hunting_party) {
    level fireteam_tdm_hunt_end(self.team);
  }

  if(reset_all_bots) {
    foreach(player in level.players) {
      if(!isDefined(player.team)) {
        continue;
      }
      if(IsBot(player) && player.team == self.team) {
        player BotSetFlag("force_sprint", false);
        if(level.bot_team_tdm_personality == "revert") {
          if(isDefined(player.fireteam_personality_original)) {
            player notify("stop_camping_tag");
            player clear_camper_data();
            player bot_set_personality(player.fireteam_personality_original);
            player.can_camp_near_others = undefined;
            player.camping_needs_fallback_camp_location = undefined;
          }
        } else {
          if(!isDefined(player.fireteam_personality_original)) {
            player.fireteam_personality_original = player BotGetPersonality();
          }
          player notify("stop_camping_tag");
          player clear_camper_data();
          player bot_set_personality(level.bot_team_tdm_personality);

          if(level.bot_team_tdm_personality == "camper") {
            player.can_camp_near_others = true;
            player.camping_needs_fallback_camp_location = true;
          }
        }
      }
    }
  }

  if(level.bot_fireteam_buddy_up) {
    foreach(player in level.players) {
      if(!isDefined(player.team)) {
        continue;
      }
      if(player.team == self.team) {
        if(IsBot(player)) {
          player thread bot_fireteam_buddy_search();
        }
      }
    }
  } else if(was_buddied) {
    foreach(player in level.players) {
      if(!isDefined(player.team)) {
        continue;
      }
      if(player.team == self.team) {
        if(IsBot(player)) {
          player.owner = undefined;
          player.bot_fireteam_follower = undefined;
          player notify("buddy_cancel");
          player bot_assign_personality_functions();
        }
      }
    }
  }
}