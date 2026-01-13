/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\bots\gametype_grnd.gsc
*********************************************/

main() {
  setup_callbacks();
  setup_bot_grnd();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_grnd_think;
}

setup_bot_grnd() {
  scripts\mp\bots\_bots_util::bot_waittill_bots_enabled(1);
  level.protect_radius = 128;
  level.bot_gametype_precaching_done = 1;
}

bot_grnd_think() {
  self notify("bot_grnd_think");
  self endon("bot_grnd_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self botclearscriptgoal();
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self botsetflag("separation", 0);
  thread clear_defend();
  for(;;) {
    wait(0.05);
    if(scripts\mp\bots\_bots_strategy::bot_has_tactical_goal()) {
      continue;
    }

    if(!self bothasscriptgoal()) {
      var_0 = getnodeinzone();
      if(isDefined(var_0)) {
        self botsetscriptgoal(var_0.origin, 0, "objective");
      }

      continue;
    }

    if(!scripts\mp\bots\_bots_util::bot_is_defending()) {
      self botclearscriptgoal();
      var_0 = getnodeinzone();
      if(isDefined(var_0)) {
        scripts\mp\bots\_bots_strategy::bot_protect_point(var_0.origin, level.protect_radius);
      }
    }
  }
}

clear_defend() {
  for(;;) {
    level waittill("zone_reset");
    if(scripts\mp\bots\_bots_util::bot_is_defending()) {
      scripts\mp\bots\_bots_strategy::bot_defend_stop();
    }
  }
}

getnodeinzone() {
  var_0 = getnodesintrigger(level.zone.gameobject.trigger);
  if(var_0.size == 0 || !isDefined(var_0)) {
    return undefined;
  }

  var_1 = randomintrange(0, var_0.size);
  var_2 = var_0[var_1];
  return var_2;
}

temp() {}