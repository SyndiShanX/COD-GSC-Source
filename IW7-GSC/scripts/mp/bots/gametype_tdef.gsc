/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_tdef.gsc
*********************************************/

main() {
  scripts\mp\bots\gametype_ball::main();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_war_think;
  level.bot_funcs["commander_gametype_tactics"] = ::bot_tdm_apply_commander_tactics;
}

setup_bot_war() {
  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    level.bot_team_tdm_personality = "default";
    level.bot_fireteam_buddy_up = 0;
  }
}

bot_war_think() {
  self notify("bot_war_think");
  self endon("bot_war_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");
  for(;;) {
    self[[self.personality_update_function]]();
    wait(0.05);
  }
}

bot_tdm_apply_commander_tactics(var_0) {
  var_1 = 0;
  var_2 = level.bot_fireteam_buddy_up;
  var_3 = 0;
  level.bot_fireteam_buddy_up = 0;
  switch (var_0) {
    case "tactic_none":
      level.bot_team_tdm_personality = "revert";
      var_1 = 1;
      break;

    case "tactic_war_hp":
      level.bot_team_tdm_personality = "revert";
      level thread scripts\mp\bots\_bots_fireteam::fireteam_tdm_find_hunt_zone(self.team);
      var_3 = 1;
      var_1 = 1;
      break;

    case "tactic_war_buddy":
      level.bot_team_tdm_personality = "revert";
      level.bot_fireteam_buddy_up = 1;
      var_1 = 1;
      break;

    case "tactic_war_hyg":
      level.bot_team_tdm_personality = "camper";
      var_1 = 1;
      break;
  }

  if(!var_3) {
    level scripts\mp\bots\_bots_fireteam::fireteam_tdm_hunt_end(self.team);
  }

  if(var_1) {
    foreach(var_5 in level.players) {
      if(!isDefined(var_5.team)) {
        continue;
      }

      if(isbot(var_5) && var_5.team == self.team) {
        var_5 botsetflag("force_sprint", 0);
        if(level.bot_team_tdm_personality == "revert") {
          if(isDefined(var_5.fireteam_personality_original)) {
            var_5 notify("stop_camping_tag");
            var_5 scripts\mp\bots\_bots_personality::clear_camper_data();
            var_5 scripts\mp\bots\_bots_util::bot_set_personality(var_5.fireteam_personality_original);
            var_5.can_camp_near_others = undefined;
            var_5.camping_needs_fallback_camp_location = undefined;
          }

          continue;
        }

        if(!isDefined(var_5.fireteam_personality_original)) {
          var_5.fireteam_personality_original = var_5 botgetpersonality();
        }

        var_5 notify("stop_camping_tag");
        var_5 scripts\mp\bots\_bots_personality::clear_camper_data();
        var_5 scripts\mp\bots\_bots_util::bot_set_personality(level.bot_team_tdm_personality);
        if(level.bot_team_tdm_personality == "camper") {
          var_5.can_camp_near_others = 1;
          var_5.camping_needs_fallback_camp_location = 1;
        }
      }
    }
  }

  if(level.bot_fireteam_buddy_up) {
    foreach(var_5 in level.players) {
      if(!isDefined(var_5.team)) {
        continue;
      }

      if(var_5.team == self.team) {
        if(isbot(var_5)) {
          var_5 thread scripts\mp\bots\_bots_fireteam::bot_fireteam_buddy_search();
        }
      }
    }

    return;
  }

  if(var_2) {
    foreach(var_5 in level.players) {
      if(!isDefined(var_5.team)) {
        continue;
      }

      if(var_5.team == self.team) {
        if(isbot(var_5)) {
          var_5.triggerportableradarping = undefined;
          var_5.bot_fireteam_follower = undefined;
          var_5 notify("buddy_cancel");
          var_5 scripts\mp\bots\_bots_personality::bot_assign_personality_functions();
        }
      }
    }
  }
}