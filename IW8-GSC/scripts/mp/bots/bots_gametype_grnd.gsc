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
      var0 = getnodeinzone();

      if(isDefined(var0)) {
        self botsetscriptgoal(var0.origin, 0, "objective");
      }

      continue;
    }

    if(!scripts\mp\bots\bots_util::bot_is_defending()) {
      self botclearscriptgoal();
      var0 = getnodeinzone();

      if(isDefined(var0)) {
        scripts\mp\bots\bots_strategy::bot_protect_point(var0.origin, level.protect_radius);
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
  var0 = getnodesintrigger(level.zone.trigger);

  if(var0.size == 0 || !isDefined(var0)) {
    return undefined;
  }

  var1 = randomintrange(0, var0.size);
  var2 = var0[var1];
  return var2;
}

function temp() {}