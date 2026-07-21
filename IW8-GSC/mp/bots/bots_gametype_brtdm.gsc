/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\bots\bots_gametype_brtdm.gsc
***********************************************/

main() {
  setup_callbacks();
  _id_131DD();
}

setup_callbacks() {
  level.bot_funcs["_encstr_A7610FD916DACA47CB832BF547432DDC6D"] = ::currenttime_bonus;
}

_id_131DD() {}

currenttime_bonus() {
  self notify("_encstr_A99C104C7B8EAF89E4E832DAAF1D344BE66D");
  self endon("_encstr_A99C104C7B8EAF89E4E832DAAF1D344BE66D");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self[[self.personality_update_function]]();
    wait 0.05;
  }
}