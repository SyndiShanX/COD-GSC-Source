/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\equipment\nvg.gsc
***********************************************/

runnvg() {
  if(istrue(level.disable_nvg)) {
    return;
  }
  scripts\cp\utility\player::init_visionsetnight();

  if(!isai(self))
    scripts\common\utility::brjugg_oncrateuse(1, undefined, 1);

  if(!isDefined(self.pers["_encstr_BDAA073552DA154FC7"]))
    self.pers["_encstr_BDAA073552DA154FC7"] = 0;

  if(!isDefined(self.pers["_encstr_84681884DB48FCDA5D45EDDB9A098E7752C8FF340115F444CD6C"]))
    self.pers["_encstr_84681884DB48FCDA5D45EDDB9A098E7752C8FF340115F444CD6C"] = 0;

  thread nvg_monitor();
}

clearnvg(var_0) {
  if(isDefined(self.nvg3rdpersonmodel)) {
    if(var_0)
      self detach(self.nvg3rdpersonmodel, "_encstr_AADA07DBF19A4A81D7");

    self.nvg3rdpersonmodel = undefined;
  }
}

turnoffnvgs() {
  foreach(var_1 in level.players) {
    if(isalive(var_1))
      var_1 savenvgstate();

    if(var_1 isnightvisionon())
      var_1 nightvisionviewoff();

    var_1 thread removenvg();
  }
}

removenvg() {
  self setactionslot(2, "_encstr_B40101");
  self notify("_encstr_BE220C460C1439038723787B1D54");
}

savenvgstate() {
  if(self isnightvisionon())
    self.pers["_encstr_BDAA073552DA154FC7"] = 1;
  else if(!self isnightvisionon() && !istrue(self.pers["_encstr_84681884DB48FCDA5D45EDDB9A098E7752C8FF340115F444CD6C"]))
    self.pers["_encstr_BDAA073552DA154FC7"] = 0;
}

nvg_monitor() {
  self notify("_encstr_81450C2E0B4FE13805E8FBB34DEB");
  self endon("_encstr_81450C2E0B4FE13805E8FBB34DEB");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BE220C460C1439038723787B1D54");
  var_0 = gettime();

  for(;;) {
    var_1 = scripts\engine\utility::_id_143AD("_encstr_8FE31012B83FF43B0EE4B1A373500B7147F8", "_encstr_990911504BEF7075776C30F37B303529B2F142");

    if(!isDefined(var_1)) {
      continue;
    }
    savenvgstate();
    var_2 = var_1 == "_encstr_8FE31012B83FF43B0EE4B1A373500B7147F8";
    nvg_update3rdperson(var_2);

    if(istrue(var_2))
      level notify("_encstr_BA0814928D80F1D246C7E7D3A3668A2510CE8D9B1978");

    var_3 = gettime();
    var_4 = var_3 - var_0;
    var_0 = var_3;
  }
}

nvg_get3rdpersonupmodel() {
  var_0 = undefined;

  if(isDefined(level.nvgheadoverrides[self.operatorcustomization.head]))
    var_0 = level.nvgheadoverrides[self.operatorcustomization.head]["_encstr_87070365F7"];

  if(!isDefined(var_0))
    var_0 = "_encstr_8E541B302AD78179E304C8D415FF40757FA368D8A221D3134F79F0CDE0";
  else if(var_0 == "_encstr_9BB20673D9CEF546")
    var_0 = "_encstr_8F5B1B7F2DDB33DA5DCF9EFF1177B53EA0B35FB7A4CFF708284A3F6341";
  else if(var_0 == "_encstr_99B20678408AE7DE")
    var_0 = "_encstr_85621B45DFB77B6175D9FF13304F08B3BF0B7B0FD299AD9B39C61F9BFF";
  else if(var_0 == "_encstr_AFB206E6B3ECEB68")
    var_0 = "_encstr_85621B45DFB77B6175D9FF13304F08B3BF0B7B0FD299AD9B39C61F9BFF";
  else if(var_0 == "_encstr_8BBA05185F8B99")
    var_0 = undefined;
  else
    var_0 = "_encstr_8E541B302AD78179E304C8D415FF40757FA368D8A221D3134F79F0CDE0";

  return var_0;
}

nvg_get3rdpersondownmodel() {
  var_0 = undefined;

  if(isDefined(level.nvgheadoverrides[self.operatorcustomization.head]))
    var_0 = level.nvgheadoverrides[self.operatorcustomization.head]["_encstr_9767056D0FBFA8"];

  if(!isDefined(var_0))
    var_0 = "_encstr_A3C518F6CC998616B98CAFDDDAD79BCEECB8AE5823F5B507D713";
  else if(var_0 == "_encstr_9BB20673D9CEF546")
    var_0 = "_encstr_93C5186D84753AA108E8AF0788069663DFA773667DDFA2F87622";
  else if(var_0 == "_encstr_99B20678408AE7DE")
    var_0 = "_encstr_A1C518904EB320F3AD7AB9F08289B5BB1FE1251FA4AF4819D917";
  else if(var_0 == "_encstr_AFB206E6B3ECEB68")
    var_0 = "_encstr_8EC5182F5DBC0AE9F0F1A1B3C8A13E2384CBCF8F314802B05113";
  else if(var_0 == "_encstr_8BBA05185F8B99")
    var_0 = undefined;
  else
    var_0 = "_encstr_A3C518F6CC998616B98CAFDDDAD79BCEECB8AE5823F5B507D713";

  return var_0;
}

nvg_update3rdperson(var_0) {
  if(isDefined(self.nvg3rdpersonmodel)) {
    self detach(self.nvg3rdpersonmodel, "_encstr_AADA07DBF19A4A81D7");
    self.nvg3rdpersonmodel = undefined;
  }

  if(var_0) {
    var_1 = nvg_get3rdpersondownmodel();

    if(isDefined(var_1)) {
      self.nvg3rdpersonmodel = var_1;
      self attach(self.nvg3rdpersonmodel, "_encstr_AADA07DBF19A4A81D7");
      return;
    }
  } else {
    var_2 = nvg_get3rdpersonupmodel();

    if(isDefined(var_2)) {
      self.nvg3rdpersonmodel = var_2;
      self attach(self.nvg3rdpersonmodel, "_encstr_AADA07DBF19A4A81D7");
    }
  }
}

_id_13830() {
  thread screenent_b(2);
}

screenent_b(var_0, var_1) {
  if(scripts\cp\utility::turn_off_sniper_laser())
    self waittill("_encstr_B4C40E582257FDB09BB4077FC103B8B0");
  else {
    if(!scripts\engine\utility::ent_flag_exist("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0"))
      scripts\engine\utility::ent_flag_init("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");

    scripts\engine\utility::ent_flag_wait("_encstr_96A51CE368570FB760477378D3A0BDA70DA62BFAF3BBDFADB0239C7FC3E0");
  }

  thread _id_13337(var_0 / 2, var_1);
  wait(var_0);
  self nightvisionviewon();
  thread nvg_update3rdperson(1);
}

_id_13337(var_0, var_1) {
  wait(var_0);
  var_2 = 5;

  if(isDefined(var_1) && (isint(var_1) || isfloat(var_1)))
    var_2 = var_1;

  if(self usinggamepad())
    thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_84FB1499B3DFE74DB00A7E60D3480F0FCB9F8119030F", var_2);
  else
    thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_A32017F978A5F1010D2FAF3F69A4D19B2F674670E5C7F7748E", var_2);
}