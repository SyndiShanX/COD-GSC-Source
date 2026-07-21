/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\supers\laststand_heal.gsc
***********************************************/

laststandheal_onset() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A6C01404A7CF0B5FB1B7C8E7306D60CCE0B53B672DDB");
  waittillframeend;
  thread laststandheal_watchrespawn();
  self.laststandheal_hassuperweapon = 1;

  for(;;) {
    if(self.laststandheal_hassuperweapon && (!istrue(self.inlaststand) || istrue(self.stuckinlaststand) || istrue(scripts\mp\utility\player::registerpuzzleinteractions()))) {
      var_0 = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
      self clearoffhandspecial();

      if(isDefined(var_0))
        scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

      self.laststandheal_hassuperweapon = 0;
    } else if(!self.laststandheal_hassuperweapon && istrue(self.inlaststand) && !istrue(self.stuckinlaststand) && !istrue(scripts\mp\utility\player::registerpuzzleinteractions())) {
      var_0 = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
      var_1 = scripts\engine\utility::ter_op(scripts\mp\supers::issuperready(), 1, 0);
      self setweaponammoclip(var_0, var_1);
      self assignweaponoffhandspecial(var_0);
      self.laststandheal_hassuperweapon = 1;
    }

    wait 0.05;
  }
}

laststandheal_unset() {
  self notify("_encstr_A6C01404A7CF0B5FB1B7C8E7306D60CCE0B53B672DDB");
}

laststandheal_watchrespawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A6C01404A7CF0B5FB1B7C8E7306D60CCE0B53B672DDB");

  for(;;) {
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    waittillframeend;
    laststandheal_onrespawn();
  }
}

laststandheal_onrespawn() {
  var_0 = scripts\mp\supers::getcurrentsuper().staticdata.weapon;
  self clearoffhandspecial();

  if(isDefined(var_0))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

  self.laststandheal_hassuperweapon = 0;
}

laststandheal_beginuse() {
  thread laststandheal_think();
  thread laststandheal_setinactivewhendone();
  return 1;
}

laststandheal_think() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  scripts\engine\utility::delaythread(0.05, ::laststandheal_drainsupermeter);
  self.laststandhealisactive = 1;
  self notify("_encstr_8768173685B91DAF9BD10B9BC8AFD0CA2C1BFAC2C647A53BB2");
  self notify("_encstr_BA94161A16DC238DB2EB9C563B4B3BB2BE6B959BE62CCE2B");
  scripts\common\utility::allow_movement(0);
  wait 0.45;
  self playlocalsound("_encstr_8D4915B185DC4737470B37C8D71AB22C36EBCD1D2C39E8");
  self notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");

  while(self.health < self.maxhealth)
    waitframe();

  scripts\common\utility::allow_movement(1);
  scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
  self playlocalsound("_encstr_953614C0380624078B239BD0390DB8D9308E379F106A");
  self notify("_encstr_8D811848D20F85416AC46B7DFC59C0C5EF9AA6537B97B6D802BB");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_8B6210D537B2FAE6CA1B99AF27CAD9B467AC");
}

laststandheal_drainsupermeter() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8D811848D20F85416AC46B7DFC59C0C5EF9AA6537B97B6D802BB");

  for(;;) {
    scripts\mp\supers::reducesuperusepercent(5, 0, 1);
    var_0 = scripts\mp\supers::getcurrentsuper();

    if(var_0.usepercent <= 0)
      return;
  }
}

laststandheal_setinactivewhendone() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143B4("_encstr_AD75063D571AE108", "_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self.laststandhealisactive = 0;
}

laststandheal_gethealthperframe() {
  return 2;
}