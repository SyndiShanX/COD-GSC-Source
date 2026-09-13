/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_grnd.gsc
**************************************************/

main() {
  setup_callbacks();
  setup_bot_grnd();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_grnd_think;
}

setup_bot_grnd() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled(1);
  level.protect_radius = 128;
  level.bot_gametype_precaching_done = 1;
}

bot_grnd_think() {
  self notify("bot_grnd_think");
  self endon("bot_grnd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self botclearscriptgoal();

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("separation", 0);
  thread clear_defend();

  for(;;) {
    wait 0.05;

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      continue;
    }
    if(!self bothasscriptgoal()) {
      position = getnodeinzone();

      if(isDefined(position))
        self botsetscriptgoal(position.origin, 0, "objective");

      continue;
    }

    if(!scripts\mp\bots\bots_util::bot_is_defending()) {
      self botclearscriptgoal();
      position = getnodeinzone();

      if(isDefined(position))
        scripts\mp\bots\bots_strategy::bot_protect_point(position.origin, level.protect_radius);
    }
  }
}

clear_defend() {
  for(;;) {
    level waittill("zone_reset");

    if(scripts\mp\bots\bots_util::bot_is_defending())
      scripts\mp\bots\bots_strategy::bot_defend_stop();
  }
}

getnodeinzone() {
  nodes = getnodesintrigger(level.zone.trigger);

  if(nodes.size == 0 || !isDefined(nodes))
    return undefined;

  _id_CAAC702D63510A96 = randomintrange(0, nodes.size);
  position = nodes[_id_CAAC702D63510A96];
  return position;
}

temp() {}