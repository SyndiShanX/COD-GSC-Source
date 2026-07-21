/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\healthoverlay.gsc
***********************************************/

init() {
  var_0 = scripts\mp\utility\dvars::respawn_locations("_encstr_AF1805EFE726E9" + scripts\mp\utility\game::getgametype() + "_encstr_A2361158ECA233609C4348F857A578410AD5CD", "_encstr_874F1B0F078649C8D081F8C7DB71E822D7819B9BCDA57295A84BF4CDD1");
  scripts\mp\tweakables::settweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_823F10A0FA2F91A384EA5B47E5EDC8EBE712", var_0);
  scripts\mp\tweakables::settweakablelastvalue("_encstr_8BB007E03658CBCAE4", "_encstr_823F10A0FA2F91A384EA5B47E5EDC8EBE712", var_0);
  level.healthregendelay = scripts\mp\tweakables::gettweakablevalue("_encstr_8BB007E03658CBCAE4", "_encstr_823F10A0FA2F91A384EA5B47E5EDC8EBE712");
  level.healthregendisabled = level.healthregendelay <= 0;
  level.playerhealth_regularregendelay = level.healthregendelay;
  level.islargebrmap = getdvarfloat("_encstr_BDBB1B3736C9F5C4277D8C592C8E349B23EDBDC9D72BF04BE8EB386C47", 0.8);
  level.iskioskfiresaleactiveforplayer = getdvarfloat("_encstr_91B51CB9C69CFA989CFA4695B08E0D378CDEDB93EB959BD159E47D1C361D", 0.55);
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
}

onplayerspawned() {
  thread manageplayerregen();
  self visionsetthermalforplayer(game["_encstr_8E4A0FA5C837EB73F67241705A0A33ED43"]);
}

manageplayerregen() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self.deathsdoor = 0;
  self.islaststandbleedoutdmg = 0;
  self.hasdonepainbreathloopthislife = 0;
  self stoplocalsound("_encstr_8EC410035B3FCBE018966FB588C80FB28DC1");
  self stoplocalsound("_encstr_AA6A0F3B8081C4325F10DF1560051991C8");
  self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");

  for(;;) {
    scripts\engine\utility::waittill_either("_encstr_B2BE0788BAF573592F", "_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
    thread healhregenthink();
  }
}

onenterdeathsdoor() {
  if(istrue(self.deathsdoor)) {
    return;
  }
  self.deathsdoor = 1;
  self.painbreathloopsplayed = 0;

  if(!istrue(self.islaststandbleedoutdmg) && !istrue(self.littlebirdsmg)) {
    self.islaststandbleedoutdmg = 1;
    self stoplocalsound("_encstr_8EC410035B3FCBE018966FB588C80FB28DC1");
    self playlocalsound("_encstr_AA6A0F3B8081C4325F10DF1560051991C8");
    self setsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3", 0.2, 1);
    self enableplayerbreathsystem(0);
    thread playerbreathingpainsound();
  }

  if(level.healthregendisabled)
    self painvisionon();

  self notify("_encstr_8738123F8928549AAEAF9BBF27D611BDB833F702");
}

onexitdeathsdoor(var_0) {
  if(istrue(var_0)) {
    self.painbreathloopsplayed = 0;
    self.hasdonepainbreathloopthislife = 0;
  }

  if(!istrue(self.deathsdoor)) {
    return;
  }
  self.deathsdoor = 0;
  self.islaststandbleedoutdmg = 0;
  self stoplocalsound("_encstr_AA6A0F3B8081C4325F10DF1560051991C8");
  self playlocalsound("_encstr_8EC410035B3FCBE018966FB588C80FB28DC1");
  self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
  self enableplayerbreathsystem(1);

  if(level.healthregendisabled)
    self painvisionoff();

  self notify("_encstr_A63911C8B2C21D436EFA46DE7B4ED7CA3CD247");
}

onfullhealth() {
  self notify("_encstr_8FB50718DD41DB3FA9");
  level notify("_encstr_8FB50718DD41DB3FA9", self);
  thread scripts\mp\damage::removeoldattackersovertime();
  self setclientomnvar("_encstr_8868145074B9632D01CB1DC01112FBD05BEEA1192D75", 0);

  if(level.gameended) {
    return;
  }
  if(scripts\mp\utility\player::isusingremote()) {
    return;
  }
  self playlocalsound(scripts\engine\utility::ter_op(scripts\mp\utility\player::isfemale(), "_encstr_9A181532ACB6D7C427B2583AD0A59B3BFAC4AC3AE8AC4E", "_encstr_8B2011A1E2E211DBF8B88D4071489B2C9B5F38"));
}

gethealthpersec(var_0) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB") {
    if(isDefined(var_0)) {
      if(var_0 == "_encstr_BAB10F57FB40D4E05ECEF63888F057A513")
        return self.maxhealth * scripts\mp\equipment\bandage::getbandagehealfractionbr() / scripts\mp\equipment\bandage::getbandagehealtimebr();

      return self.maxhealth / scripts\mp\equipment\bandage::getfirstaidhealtimebr();
    }
  }

  return 4;
}

healhregenthink(var_0) {
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  self notify("_encstr_85211042E803A51BFF1DCFC5A007232CB55B");
  self endon("_encstr_85211042E803A51BFF1DCFC5A007232CB55B");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = !istrue(self.adrenalinepoweractive) && !istrue(self.bandageactive) && !istrue(self.laststandhealisactive);
  var_2 = self.health / self.maxhealth;

  while(istrue(level.healthregendisabled) && scripts\mp\utility\player::isusingremote())
    waitframe();

  if(var_2 < level.iskioskfiresaleactiveforplayer && !scripts\mp\utility\player::isusingremote() && !istrue(self.stadium_puzzle))
    onenterdeathsdoor();

  if(var_1) {
    if(level.healthregendisabled) {
      return;
    }
    while(istrue(self.healthregendisabled) || !scripts\mp\utility\player::is_health_regen_allowed())
      waitframe();

    waitforhealthregendelay();
  }

  if(!var_1 || scripts\mp\utility\perk::_hasperk("_encstr_8A3416FE38DF21830E9AC0A081E2437937DE8C7F9323A9FD"))
    self setclientomnvar("_encstr_8868145074B9632D01CB1DC01112FBD05BEEA1192D75", 1);

  var_3 = self.maxhealth / 50.0;
  var_4 = 0.0;
  var_5 = self.health;
  var_6 = istrue(self.adrenalinepoweractive);

  for(;;) {
    if(!scripts\mp\utility\player::is_health_regen_allowed() || istrue(self.healthregendisabled) && var_1) {
      return;
    }
    wait 0.05;
    var_7 = var_3;

    if(istrue(self.adrenalinepoweractive))
      var_7 = scripts\mp\equipment\adrenaline::gethealthperframe();
    else if(istrue(self.bandageactive)) {
      var_7 = gethealthpersec(var_0);
      wait 1;
    } else if(istrue(self.laststandhealisactive))
      var_7 = scripts\mp\supers\laststand_heal::laststandheal_gethealthperframe();
    else if(scripts\mp\utility\perk::_hasperk("_encstr_8A3416FE38DF21830E9AC0A081E2437937DE8C7F9323A9FD"))
      var_7 = var_3 * level.regenfasterhealthmod;

    if(isDefined(level._id_12AD2))
      var_7 = [[level._id_12AD2]](var_7);

    if(self.health < self.maxhealth) {
      var_8 = self.health + var_7 + var_4;
      var_9 = int(min(self.maxhealth, var_8));
      var_4 = var_8 - var_9;
      self.health = var_9;
      var_2 = self.health / self.maxhealth;

      if(var_2 > level.islargebrmap)
        onexitdeathsdoor(1);
    }

    if(self.health >= self.maxhealth) {
      self.health = self.maxhealth;
      onexitdeathsdoor(1);
      break;
    }
  }

  var_10 = self.health - var_5;

  if(var_6) {
    scripts\mp\damage::combatrecordtacticalstat("_encstr_820F114AE740032B7F8680CAD930B1D239F212", var_10);
    scripts\mp\utility\stats::incpersstat("_encstr_AF851178A3D7C371D3481FC7707CB9B3906FCF", var_10);
    scripts\cp\vehicles\vehicle_compass_cp::_id_12092(var_10);
    scripts\mp\analyticslog::logevent_playerhealed(self, var_10, self);
  } else if(!isai(self))
    scripts\mp\analyticslog::_id_119B7(self, var_10);

  if(var_1 && var_10 > 0)
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_91F60F38B185CBB227FAC92B6C7B9DB227");

  onfullhealth();
}

waitforhealthregendelay() {
  self endon("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
  self endon("_encstr_8DBB13C4AC76D2CDF593B23B59E69539161D5ADE37");
  self.shrapnelregendelay = 0.0;

  if(isDefined(self.lastshrapneltime)) {
    var_0 = gettime();
    var_1 = var_0 - self.lastshrapneltime;
    var_1 = var_1 * 0.001;

    if(scripts\mp\utility\perk::_hasperk("_encstr_A73B1A6E1C2BB12D0BB18ECBF59BD039C238B959D8FAC9B26EA5DC3A")) {
      var_2 = 1;
      self.shrapnelregendelay = max(var_2 - var_1, 0);
    } else
      self.shrapnelregendelay = max(3 - var_1, 0);
  }

  if(!isDefined(self.regendelayspeed))
    self.regendelayspeed = 1;

  var_3 = self.shrapnelregendelay > 0.0;

  if(var_3)
    thread applyshrapnelfx();

  if(!isDefined(self.regendelayreductiontime) || gettime() - self.regendelayreductiontime > 0.15)
    self.regendelayreduction = 0;

  var_4 = level.playerhealth_regularregendelay + self.shrapnelregendelay;
  self.currentregendelay = var_4;
  var_0 = gettime() * 0.001;

  while(self.currentregendelay - self.regendelayreduction > 0) {
    var_5 = self.regendelayspeed;

    if(isDefined(level._id_12AD1))
      var_5 = [[level._id_12AD1]](var_5);

    self.currentregendelay = self.currentregendelay - (gettime() * 0.001 - var_0) * var_5;
    var_0 = gettime() * 0.001;

    if(var_3 && self.currentregendelay - self.regendelayreduction <= level.playerhealth_regularregendelay) {
      var_3 = 0;

      if(self.regendelayreduction > 0)
        self notify("_encstr_973A0F6E1A932CE0E6561BFAB2CD32ACC8");
      else
        self notify("_encstr_AD7315B6142BCB0B6E6F901177B6410BF2712537EAA2A3");
    }

    wait 0.05;
  }

  if(var_3)
    self notify("_encstr_AD7315B6142BCB0B6E6F901177B6410BF2712537EAA2A3");

  self.regendelayreduction = 0;
  self.regendelayreductiontime = 0;
}

reducehealthregendelay(var_0) {
  if(!isDefined(self.regendelayreduction)) {
    self.regendelayreduction = 0;
    self.regendelayreductiontime = 0;
  }

  self.regendelayreduction = self.regendelayreduction + var_0;
  self.regendelayreductiontime = gettime();
}

playerbreathingpainsound(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A63911C8B2C21D436EFA46DE7B4ED7CA3CD247");
  self endon("_encstr_8FB50718DD41DB3FA9");
  self endon("_encstr_8A59138812CFC5012A842B3DBC195005730A43D12A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 0.5;

  for(;;) {
    if(scripts\mp\utility\player::isusingremote()) {
      waitframe();
      continue;
    }

    if(level.healthregendisabled) {
      self.painbreathloopsplayed++;

      if(self.painbreathloopsplayed > scripts\engine\utility::ter_op(istrue(self.hasdonepainbreathloopthislife), 1, 4)) {
        wait 1.0;
        self.hasdonepainbreathloopthislife = 1;
        onexitdeathsdoor(0);
        break;
      }
    }

    self playlocalsound("_encstr_81F81870D990D18336B90A632098831610B527E745906947DBF0");
    wait 1.7;
  }
}

applyshrapnelfx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8A8C10A3A36351A0236C33A992F68899D8AB");
  self endon("_encstr_8A8C10A3A36351A0236C33A992F68899D8AB");
  self setclientomnvar("_encstr_9BAB14D596FADCA1E4B0C137AC63BEF6B3954E8D2CF2", 1);
  self playlocalsound("_encstr_817615273882D75A713882FF966F31A3D0787FCB68812C");
  var_0 = applyshrapnelfxinternal();

  if(istrue(var_0))
    self setclientomnvar("_encstr_9BAB14D596FADCA1E4B0C137AC63BEF6B3954E8D2CF2", 2);
  else
    self setclientomnvar("_encstr_9BAB14D596FADCA1E4B0C137AC63BEF6B3954E8D2CF2", 3);
}

applyshrapnelfxinternal() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_81170C244F9CBDE72C01BB99A298");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = scripts\engine\utility::_id_143AE("_encstr_AD7315B6142BCB0B6E6F901177B6410BF2712537EAA2A3", "_encstr_973A0F6E1A932CE0E6561BFAB2CD32ACC8", "_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
  return var_0 == "_encstr_973A0F6E1A932CE0E6561BFAB2CD32ACC8";
}