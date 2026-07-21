/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_to_hstg.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_to_hstg();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_to_hstg_think;
}

setup_bot_to_hstg() {}

bot_to_hstg_think() {
  self notify("_encstr_99C712C4B78EAF3AEDEB86CD3AD9FAD11AD2DCDA");
  self endon("_encstr_99C712C4B78EAF3AEDEB86CD3AD9FAD11AD2DCDA");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}