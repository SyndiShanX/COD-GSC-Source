/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_grnd.gsc
**************************************************/

function main() {
  setup_callbacks();
  setup_bot_grnd();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_grnd_think;
}

function setup_bot_grnd() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled(1);
  level.protect_radius = 128;
  level.bot_gametype_precaching_done = 1;
}

function bot_grnd_think() {
  self notify("bot_grnd_think");
  self endon("bot_grnd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botclearscriptgoal();

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  thread clear_defend();

  for(;;) {
    wait 0.05;

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      continue;
    }

    if(!self bothasscriptgoal()) {
      var_0 = getnodeinzone();

      if(isDefined(var_0)) {
        self botsetscriptgoal(var_0.origin, 0, "objective");
      }

      continue;
    }

    if(!scripts\mp\bots\bots_util::bot_is_defending()) {
      self botclearscriptgoal();
      var_0 = getnodeinzone();

      if(isDefined(var_0)) {
        scripts\mp\bots\bots_strategy::bot_protect_point(var_0.origin, level.protect_radius);
      }
    }
  }
}

function clear_defend() {
  for(;;) {
    level waittill("zone_reset");

    if(scripts\mp\bots\bots_util::bot_is_defending()) {
      scripts\mp\bots\bots_strategy::bot_defend_stop();
    }
  }
}

function getnodeinzone() {
  var_0 = getnodesintrigger(level.zone.trigger);

  if(var_0.size == 0 || !isDefined(var_0)) {
    return undefined;
  }

  var_1 = randomintrange(0, var_0.size);
  var_2 = var_0[var_1];
  return var_2;
}

function temp() {}