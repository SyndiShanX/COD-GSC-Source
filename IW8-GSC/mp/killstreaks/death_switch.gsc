/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\death_switch.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_A6DC0D5AB1AFF33CD1D74F29A14844", ::tryusedeathswitchfromstruct);
  level.killstreak_laststand_func = ::deathswitch_startpayloadreleasesequence;
}

tryusedeathswitch() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("_encstr_A6DC0D5AB1AFF33CD1D74F29A14844", self);
  return tryusedeathswitchfromstruct(var_0);
}

tryusedeathswitchfromstruct(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_A63C1793E225B9F2DAE38187BB53CD80F37139698E8C90BFC2");
  var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, getcompleteweaponname("_encstr_A93313025B51E953606BA380FD6663FDDB38C679DB"));

  if(!istrue(var_1))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0))
      return 0;
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_0.streakname, 1);
  scripts\common\utility::_id_13E0A(level._id_11B2A, "_encstr_A6DC0D5AB1AFF33CD1D74F29A14844", self.origin);
  thread scripts\mp\hud_util::teamplayercardsplash("_encstr_B1C012AB9BCA91F5322B588E34EB37EEA53A1B1A", self);
  thread startdeathswitch(var_0);
  return 1;
}

weapongivendeathswitch(var_0) {
  return 1;
}

startdeathswitch(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self iprintlnbold("_encstr_ABC82794CC084A02CEDE1091BDDD731680929C5B04D1C2B5B4CDEC0447A1B25B04772D3A3402B55642");
  scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");
  self.killstreaklaststand = 1;
  self.deathswitchent = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self gettagorigin("_encstr_9ABB0968F1402B19E2AFA9"));
  self.deathswitchent setModel("_encstr_AF5C135BB97D23AC0BA386BE6EBBB43A361AEBB51C");
  self.deathswitchent.angles = self.angles;
  self.deathswitchent linkTo(self, "_encstr_9ABB0968F1402B19E2AFA9", (0, 0, 0), (0, 0, 0));
  thread deathswitch_loopblinkinglight();
}

deathswitch_loopblinkinglight() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_914414F1C78A39C266533A895F3B2FFD6BF9FDC330C9");

  for(;;) {
    self.deathswitchent setscriptablepartstate("_encstr_819B0F723920B3DCD3888219800B17633B", "_encstr_AB0703DBB9", 0);
    wait 0.5;
    self.deathswitchent setscriptablepartstate("_encstr_819B0F723920B3DCD3888219800B17633B", "_encstr_BA19049F4B2D", 0);
  }
}

debugloc() {
  self endon("_encstr_AD75063D571AE108");

  for(;;)
    waitframe();
}

deathswitch_startpayloadreleasesequence() {
  var_0 = "_encstr_A393109FCF38E936DA97CCE3177050314CB8";
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  thread scripts\mp\laststand::switchtofists(var_0);
  self.laststandactionset = "_encstr_8C1015C5F140ACE3F50B7B2B0F120AFCE01B7BCAE9384B";
  scripts\mp\playeractions::allowactionset(self.laststandactionset, 0);
  thread deathswitch_payloadrelease(3);
  thread deathswitch_watchbleedout(3);
}

deathswitch_payloadrelease(var_0) {
  self endon("_encstr_8894100716F263DB85917D39598D2BC29BB2");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 1;
  var_2 = scripts\mp\utility\weapon::_launchgrenade("_encstr_BA301644EB283B8B805B4BD2C3E6C3B96851F9DB51318533", self gettagorigin("_encstr_8FE10B52092BB64F28E6B7BFFD"), (0, 0, 0), var_0, 1);
  var_2 linkTo(self);
  thread deathswitch_payloadreleaseondeath(var_1, var_2);
  var_3 = 1;

  while(var_0 > 0) {
    self iprintlnbold("_encstr_A2FC19A8415F23ECFAA77F79F13834BAE6B833920BA51763A09D20" + var_0);
    var_0 = var_0 - var_3;
    playsoundatpos(self.origin, "_encstr_92071274BD21DB1CBF60837A401FD4BFF915FDF8");
    wait(var_3);
    var_3 = var_3 - 0.2;

    if(var_3 < 0.05)
      var_3 = 0.05;
  }

  deathswitch_payloadreleasetype(var_1, var_2);
}

deathswitch_payloadreleaseondeath(var_0, var_1) {
  self endon("_encstr_8894100716F263DB85917D39598D2BC29BB2");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_A38216EE2C8E1B1AD7B9DD2D1DD843D7DB9BAFC856168E34");
  self endon("_encstr_A38216EE2C8E1B1AD7B9DD2D1DD843D7DB9BAFC856168E34");
  self waittill("_encstr_AD75063D571AE108");
  deathswitch_payloadreleasetype(var_0, var_1);
}

deathswitch_payloadreleasetype(var_0, var_1) {
  if(isDefined(var_1))
    var_1 delete();

  switch (var_0) {
    case 0:
      thread deathswitch_releaselocalexplosion();
      break;
    case 1:
      thread deathswitch_releaseartilleryexplosion();
      break;
    default:
      break;
  }

  self.killstreaklaststand = undefined;
  scripts\mp\utility\perk::removeperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");
  self notify("_encstr_8894100716F263DB85917D39598D2BC29BB2");
}

deathswitch_releaselocalexplosion() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_914414F1C78A39C266533A895F3B2FFD6BF9FDC330C9");
  self.deathswitchent setscriptablepartstate("_encstr_819B0F723920B3DCD3888219800B17633B", "_encstr_BA19049F4B2D", 0);
  self.deathswitchent setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_AB0703DBB9", 0);
  self.deathswitchent setentityowner(self);
  self.deathswitchent thread scripts\mp\utility\script::delayentdelete(5);
}

deathswitch_releaseartilleryexplosion() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_914414F1C78A39C266533A895F3B2FFD6BF9FDC330C9");
  var_0 = self.origin + (0, 0, 20000);
  var_1 = self.origin;
  var_2 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_A1FF15232B0B8E347DB9DDB4D11B0DFA1C397B9AF5D6E0"), var_0, var_1, self);
  self.deathswitchent setscriptablepartstate("_encstr_819B0F723920B3DCD3888219800B17633B", "_encstr_BA19049F4B2D", 0);
  self.deathswitchent thread scripts\mp\utility\script::delayentdelete(5);
}

deathswitch_watchbleedout(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  scripts\mp\utility\damage::_suicide();
}