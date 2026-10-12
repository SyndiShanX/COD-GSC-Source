/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_grnd.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#namespace bots_gametype_grnd;

function main() {
  setup_callbacks();
  setup_bot_grnd();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_grnd_think;
}

function setup_bot_grnd() {
  bot_waittill_bots_enabled(1);
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

  while(true) {
    wait 0.05;

    if(bot_has_tactical_goal()) {
      continue;
    }

    if(!self bothasscriptgoal()) {
      position = getnodeinzone();

      if(isDefined(position)) {
        self botsetscriptgoal(position.origin, 0, "objective");
      }

      continue;
    }

    if(!bot_is_defending()) {
      self botclearscriptgoal();
      position = getnodeinzone();

      if(isDefined(position)) {
        bot_protect_point(position.origin, level.protect_radius);
      }
    }
  }
}

function clear_defend() {
  while(true) {
    level waittill("zone_reset");

    if(bot_is_defending()) {
      bot_defend_stop();
    }
  }
}

function getnodeinzone() {
  nodes = getnodesintrigger(level.zone.trigger);

  if(nodes.size == 0 || !isDefined(nodes)) {
    return undefined;
  }

  nodesnum = randomintrange(0, nodes.size);
  position = nodes[nodesnum];
  return position;
}

function temp() {}