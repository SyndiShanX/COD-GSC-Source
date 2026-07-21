/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_grnd.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_grnd();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_grnd_think;
}

setup_bot_grnd() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled(1);
  level.protect_radius = 128;
  level.bot_gametype_precaching_done = 1;
}

bot_grnd_think() {
  self notify("_encstr_9A990F5B7F5B199F72F84C8753116A08BB");
  self endon("_encstr_9A990F5B7F5B199F72F84C8753116A08BB");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self botclearscriptgoal();

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("_encstr_ABF30BBF587B195B43BDD44DA8", 0);
  thread clear_defend();

  for(;;) {
    wait 0.05;

    if(scripts\mp\bots\bots_strategy::bot_has_tactical_goal()) {
      continue;
    }
    if(!self bothasscriptgoal()) {
      var_0 = getnodeinzone();

      if(isDefined(var_0))
        self botsetscriptgoal(var_0.origin, 0, "_encstr_9A2B0A12F03587575B7BBEA5");

      continue;
    }

    if(!scripts\mp\bots\bots_util::bot_is_defending()) {
      self botclearscriptgoal();
      var_0 = getnodeinzone();

      if(isDefined(var_0))
        scripts\mp\bots\bots_strategy::bot_protect_point(var_0.origin, level.protect_radius);
    }
  }
}

clear_defend() {
  for(;;) {
    level waittill("_encstr_9B740BDBEF187A77B0B1CA578B");

    if(scripts\mp\bots\bots_util::bot_is_defending())
      scripts\mp\bots\bots_strategy::bot_defend_stop();
  }
}

getnodeinzone() {
  var_0 = getnodesintrigger(level.zone.trigger);

  if(var_0.size == 0 || !isDefined(var_0))
    return undefined;

  var_1 = randomintrange(0, var_0.size);
  var_2 = var_0[var_1];
  return var_2;
}

temp() {}