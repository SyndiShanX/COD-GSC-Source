/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_grnd.gsc
************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;

main() {
  setup_callbacks();
  setup_bot_grnd();
}

empty_function_to_force_script_dev_compile() {}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_grnd_think;
}

setup_bot_grnd() {
  bot_waittill_bots_enabled(true);

  level.protect_radius = 128;
  level.bot_gametype_precaching_done = true;
}

bot_grnd_think() {
  self notify("bot_grnd_think");
  self endon("bot_grnd_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self BotSetFlag("separation", 0);

  while(true) {
    wait(0.05);

    if(bot_has_tactical_goal()) {
      continue;
    }
    if(!self BotHasScriptGoal()) {
      self BotSetScriptGoal(level.grnd_zone.origin, 0, "objective");
    } else {
      if(!bot_is_defending()) {
        self BotClearScriptGoal();
        self bot_protect_point(level.grnd_zone.origin, level.protect_radius);
      }
    }
  }
}