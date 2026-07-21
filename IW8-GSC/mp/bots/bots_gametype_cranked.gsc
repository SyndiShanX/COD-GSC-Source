/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_cranked.gsc
***********************************************/

main() {
  setup_callbacks();
  setup_bot_cranked();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::bot_cranked_think;
}

setup_bot_cranked() {
  level.bot_personality_types_desired["_encstr_930B07BB1B6B3854FF"] = 1;
  level.bot_personality_types_desired["_encstr_88FA0B7271CF407FE86D0FEBE3"] = 0;
}

bot_cranked_think() {
  self notify("_encstr_8CF5128827EC7E57ABDE48C23722E7C328975048");
  self endon("_encstr_8CF5128827EC7E57ABDE48C23722E7C328975048");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}