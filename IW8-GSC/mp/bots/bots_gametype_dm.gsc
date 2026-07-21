/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_dm.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_dm();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_dm_think;
}

setup_bot_dm() {}

bot_dm_think() {
  self notify("_encstr_BED00DDEF0A1B934F8A1B3CB38B0E3");
  self endon("_encstr_BED00DDEF0A1B934F8A1B3CB38B0E3");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}