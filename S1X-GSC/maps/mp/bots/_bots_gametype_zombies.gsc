/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_zombies.gsc
***************************************************/

main() {
  setup_callbacks();
  setup_bot_zombies();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_zombies_think;
}

setup_bot_zombies() {
  level.bots_gametype_handles_team_choice = 1;
  level.bots_ignore_team_balance = 1;
}

bot_zombies_think() {
  self notify("bot_zombies_think");
  self endon("bot_zombies_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(self botgetpersonality() != "run_and_gun") {
      maps\mp\bots\_bots_util::bot_set_personality("run_and_gun");
    }

    if(!isDefined(self.bot_defend_player_guarding)) {
      var_0 = 9999;
      var_1 = undefined;

      foreach(var_3 in level.players) {
        if(isbot(var_3)) {
          continue;
        }
        if(!isDefined(var_3.guardcount)) {
          var_3.guardcount = 0;
        }

        if(var_3.guardcount < var_0) {
          var_0 = var_3.guardcount;
          var_1 = var_3;
        }
      }

      if(isDefined(var_1)) {
        thread maps\mp\bots\_bots_strategy::bot_guard_player(var_1, 800);
        var_1.guardcount++;
      }
    }

    self[[self.personality_update_function]]();
    wait 0.05;
  }
}