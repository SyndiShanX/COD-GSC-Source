/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_payload.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_payload();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_payload_think;
}

setup_bot_payload() {}

bot_payload_think() {
  self notify("_encstr_A1031313F61DF50EB0F236B72C32C9AF1D432D375B");
  self endon("_encstr_8709127278EBC70A6991B2A8479CF9AC33A0B8D2");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}