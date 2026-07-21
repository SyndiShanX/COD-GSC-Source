/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_tac_ops.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_tac_ops();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_tac_ops_think;
}

setup_bot_tac_ops() {}

bot_tac_ops_think() {
  self notify("_encstr_A9F5124CBD8EEB8E0BC6BEBDC16EEBE8D0A537B5");
  self endon("_encstr_A9F5124CBD8EEB8E0BC6BEBDC16EEBE8D0A537B5");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}