/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\bandage.gsc
***********************************************/

getbandagehealfractionbr() {
  return 0.2;
}

getbandagehealtimebr() {
  return 5;
}

getfirstaidhealtimebr() {
  return 5;
}

getbandagetime(var_0) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    var_1 = 1;

    if(isDefined(self.br_armorlevel) && self.br_armorlevel == 3)
      var_1 = 0.75;

    if(var_0 == "_encstr_BAB10F57FB40D4E05ECEF63888F057A513")
      return 5 * var_1;

    return 5 * var_1;
  }

  return 5;
}

usebandage(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(self.health == self.maxhealth) {
    self iprintlnbold("_encstr_A7B8155920751BDE982B899C114006BF9E312203E8410E");
    return;
  }

  var_2 = "_encstr_AA1B0B2616CD232CCE56F55B1C";

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    var_2 = "_encstr_857D10EB68A80C7ABFC5A91EB627C2D1D0E0";

  self disableweaponswitch();
  self allowfire(0);
  self giveandfireoffhand(var_2);
  wait 0.25;
  self.bandageactive = 1;
  self.healthregendisabled = 0;
  bandageheal(var_0);
  wait 0.25;

  if(self hasweapon(var_2))
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);

  self allowfire(1);
  self enableweaponswitch();
  var_1--;
  scripts\mp\equipment::setequipmentslotammo("_encstr_91B50734CA58631D1A", var_1);
  self.bandageactive = 0;
  self.healthregendisabled = 1;
}

bandageheal(var_0) {
  self endon("_encstr_8BA809681DBE82C6920A0D");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::watchhealend();
  thread scripts\mp\healthoverlay::healhregenthink(var_0);
  wait(getbandagetime(var_0));
}

usequickslothealitem(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(self.usingascender)) {
    return;
  }
  if(istrue(self.inlaststand)) {
    scripts\mp\hud_message::showerrormessage("_encstr_966C208F39588CD06FE502CB476DB8571C296B57A9EF3779251519725DB5A006C5A9");
    return;
  }

  if(var_0 == "_encstr_9A6E11F537232F9A3F7053BA18BD52F3191D7D")
    scripts\mp\equipment\armor_plate::demo_update_hint_logic(var_0, var_1);

  if(scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A") == 0) {
    var_2 = -1;
    var_3 = 0;

    foreach(var_6, var_5 in self.br_inventory_slots) {
      if(isDefined(var_5.scriptablename)) {
        if(var_5.scriptablename == level.br_pickups.br_equipnametoscriptable[var_0]) {
          scripts\mp\equipment::setequipmentslotammo("_encstr_91B50734CA58631D1A", var_5.count);
          _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::removeitemfrominventory(var_6);
          var_3 = 1;
          break;
        } else if(var_5.itemtype == "_encstr_91B50734CA58631D1A")
          var_2 = var_6;
      }
    }

    if(!var_3 && var_2 >= 0) {
      scripts\mp\equipment::giveequipment(level.br_pickups.br_equipname[self.br_inventory_slots[var_2].scriptablename], "_encstr_91B50734CA58631D1A");
      scripts\mp\equipment::setequipmentslotammo("_encstr_91B50734CA58631D1A", self.br_inventory_slots[var_2].count);
      self.br_inventory_slots[var_2] = undefined;
    } else
      scripts\mp\equipment::takeequipment("_encstr_91B50734CA58631D1A");
  }
}