/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\trial_gun_course.gsc
***********************************************/

init() {}

x1ops3() {
  for(;;) {
    self waittill("_encstr_92101CA2082F92BA26781777C8F1651BF3932A91E7A15BF568B0634F70B1");

    if(istrue(self.being_revived)) {
      continue;
    }
    thread useadrenaline();
    wait 0.1;
  }
}

useadrenaline() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9BD1119356ADB7D95682C8392B9B588D4B3759");
  self.adrenalinepoweractive = 1;
  self notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
  self refreshsprinttime();
  childthread adrenaline_removeonplayernotifies();
  childthread adrenaline_removeondamage();
  childthread adrenaline_removeongameend();
  self setscriptablepartstate("_encstr_A7D30834AC16635ADCD9", "_encstr_930B07BB1B6B3854FF", 0);
  return 1;
}

removeadrenaline() {
  if(istrue(self.adrenalinepoweractive)) {
    self notify("_encstr_9BD1119356ADB7D95682C8392B9B588D4B3759");
    self.adrenalinepoweractive = undefined;
  }
}

gethealthperframe() {
  return 8;
}

adrenaline_removeonplayernotifies() {
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8FB50718DD41DB3FA9");
  thread removeadrenaline();
}

adrenaline_removeondamage() {
  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(level.gametype == "_encstr_B607038AAB" && (var_4 == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3" || var_4 == "_encstr_BDB50C41D83F8F9F030B60E80F5B")) {
      continue;
    }
    thread removeadrenaline();
    return;
  }
}

adrenaline_removeongameend() {
  level waittill("_encstr_9B1D0BC7932875276230426AA1");
  thread removeadrenaline();
}