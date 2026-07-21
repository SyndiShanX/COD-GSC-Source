/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_front.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_front();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_front_think;
}

setup_bot_front() {}

bot_front_think() {
  self notify("_encstr_A9F0104CBD8EEBCC93DEDCD17D8E0DD2DCAD");
  self endon("_encstr_A9F0104CBD8EEBCC93DEDCD17D8E0DD2DCAD");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}