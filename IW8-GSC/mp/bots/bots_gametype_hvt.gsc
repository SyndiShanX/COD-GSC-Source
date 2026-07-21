/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_hvt.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_hvt();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_hvt_think;
}

setup_bot_hvt() {}

bot_hvt_think() {
  self notify("_encstr_ACD50E4A90AB5F04F5B0F943B8237D77");
  self endon("_encstr_ACD50E4A90AB5F04F5B0F943B8237D77");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}