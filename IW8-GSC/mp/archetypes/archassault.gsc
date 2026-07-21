/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\archetypes\archassault.gsc
***********************************************/

applyarchetype() {
  equipextras();
}

equipextras() {}

removearchetype() {}

auraquickswap_run() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_911710C9ACADF6EC9505C98D1AAC8E973859");
  self setclientomnvar("_encstr_992E129BD781C7D0F2DE66BBC3C1A80AFB072B19", 0);

  for(;;) {
    self waittill("_encstr_8F220B3FC7D11160D8F85169E9");
    var_0 = scripts\common\utility::playersincylinder(self.origin, 384);

    foreach(var_2 in var_0) {
      if(var_2.team != self.team) {
        continue;
      }
      var_2 thread auraquickswap_bestowaura(self);
    }
  }
}

auraquickswap_bestowaura(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(self != var_0)
    var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B4D80E96B5DD72479308AF875069240A");

  self setclientomnvar("_encstr_992E129BD781C7D0F2DE66BBC3C1A80AFB072B19", 1);
  scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  self playlocalsound("_encstr_AA7511ADE0FA7BEC2B9C36435839CECABEDE73");
  thread cleanupafterplayerdeath();
  wait 5;
  self playlocalsound("_encstr_91D51290EB895AAB0D7B4EB4EADDDF131F90E789");
  self notify("_encstr_83AD14566535DA66687FAD424AD1A8CBB964BF871883");
  scripts\mp\utility\perk::removeperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
  self setclientomnvar("_encstr_992E129BD781C7D0F2DE66BBC3C1A80AFB072B19", 0);
}

cleanupafterplayerdeath() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  self setclientomnvar("_encstr_992E129BD781C7D0F2DE66BBC3C1A80AFB072B19", 0);
}