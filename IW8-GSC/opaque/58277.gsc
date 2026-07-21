/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58277.gsc
***********************************************/

init() {
  level._effect["_encstr_8F8419B399F0AFB90EACAC19EB26DBDBCDE8EBA3C9585A8DEBCCE1"] = loadfx("_encstr_9A52350B6709365ACB776FA30DFF7A5ADD739BC87B8FC7D2C719B8C00DC62B52DB8FD325B85E50805F8B0707C8AF60968B4F03AD1BB0CC");
  level._effect["_encstr_85511AA4071B27FBE01FA8580F0AB08F732B88AEDED32B61D6DFB8B0"] = loadfx("_encstr_85F236A4071BC7B8E76A7968BB47B193926F1F215E63BF83CD179810CF6FEBC56B19963535B9CF0B852FB091CB77ED27D3B18EB64A42BD32");
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8872143897F0179BED53915B7BCD1F8F5975AFBF0750"] = "_encstr_A5E415A1FF33F5D80F0B538EB208A83DDAD77D1767DBC5";
  var_0 = spawnStruct();
  var_0._id_138FD = "_encstr_9A570C4FD8FF88ADE7B260684BA3";
  var_0.parachute_get_path = getdvarfloat("_encstr_93E529734EB3876E156912ABF82DE373CB38FB08D5F9D3F9DD781AE3181F1EBF811C4F9475E30F7B936012", 45);
  var_0.asm_playfacialanim_mp = ::asm_playfacialanim_mp;
  var_0._id_12A35 = ::_id_12A35;
  var_0.isdeathshieldskippingenabled = ::isdeathshieldskippingenabled;
  _keypadscriptableused_bunkeralt::_id_12AF4(var_0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_84BF17C8FB0901083795CE45786F73C96F127099525D47C313", "_encstr_8D8B0F48038BBF7D4A79F340F0FF067A33", ::open_starting_safehouse_door);
}

asm_playfacialanim_mp() {
  self.player._id_12834 = 1;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8872143897F0179BED53915B7BCD1F8F5975AFBF0750", self.player);
  self.player lerpfovbypreset("_encstr_8B880E3B782B3B528F416928DF5B3D4D");
  _id_135B7();
  self.player cac_getaccessorylogic();
  self.player playlocalsound("_encstr_95121E593A01D037DFBF439BC33706162D9C4DD00B90808A78C23B3597CF2513");
  _keypadscriptableused_bunkeralt::_id_12425(self.player, "_encstr_8EEC2805B269280D078A2831614BC8C83F2AA3D977CA805D4F8246D98ADFFE88D9911759F9F3401D979A");
}

isdeathshieldskippingenabled() {
  self notify("_encstr_8C631A37D2E6D936AC3AB7E6D71959851BA35ACEC2E856BECC57736C");
  self endon("_encstr_8C631A37D2E6D936AC3AB7E6D71959851BA35ACEC2E856BECC57736C");
  self.player._id_12834 = 0;
  lb_impulse_dmg_threshold_low();
  self.player _id_12BF5();

  if(isalive(self.player))
    self.player playlocalsound("_encstr_8FC420A52931D26F6C71C3BBFB509B4F28F734398D789B0FAFABDBA2A1153F42187D");

  self.player lerpfovbypreset("_encstr_BA79117D172A8BEB2CEBC9BAEF7D61DF12FF6E");
}

_id_12A35() {
  open_starting_safehouse_door(self._id_12E2D.parachute_get_path);
  self.player playlocalsound("_encstr_95E220ADE0FA1CDEDDCA39AB07F5C959C23647A5B3B03A95FAE638B2AC32BE1CB139");
}

open_starting_safehouse_door(var_0) {
  self.mp_layover_patch = gettime() + var_0 * 1000;
  self.player thread _keypadscriptableused_bunkeralt::_id_13F7E(undefined, 4, 2);
}

_id_135B7() {
  playFXOnTag(scripts\engine\utility::getfx("_encstr_8F8419B399F0AFB90EACAC19EB26DBDBCDE8EBA3C9585A8DEBCCE1"), self.player, "_encstr_8EEC09159F6238030BFA23");
}

lb_impulse_dmg_threshold_low() {
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_8F8419B399F0AFB90EACAC19EB26DBDBCDE8EBA3C9585A8DEBCCE1"), self.player, "_encstr_8EEC09159F6238030BFA23");
}

cac_getaccessorylogic(var_0) {
  thread _id_124EF();

  if(!istrue(self.isjuggernaut) && !isDefined(self.vehicle))
    thread _id_124EE();

  if(isDefined(self.vehicle))
    _keypadscriptableused_bunkeralt::_id_1249C("_encstr_9A570C4FD8FF88ADE7B260684BA3") thread _id_141FC();
}

_id_141FC() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_9B730DFFD9982B77A0F0CB574B5080");
  self.player endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  while(isDefined(self.player.vehicle))
    waitframe();

  thread _id_124EE();
}

_id_141FB() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(isDefined(self.vehicle))
    waitframe();

  thread _id_124E4();
}

_id_12BF5() {
  thread _id_124E3();

  if(!isDefined(self.vehicle))
    thread _id_124E4();
  else
    thread _id_141FB();
}

_id_124EE() {
  if(!isDefined(self.operatorcustomization) || !isDefined(self.operatorcustomization.suit)) {
    return;
  }
  if(self.operatorcustomization.suit == "_encstr_B6C10E16FEB9C2379020FFBB7B6EFD9B") {
    return;
  }
  if(!isDefined(self._id_12147))
    self._id_12147 = self.operatorcustomization.suit;

  self.operatorcustomization.suit = "_encstr_B6C10E16FEB9C2379020FFBB7B6EFD9B";
  scripts\mp\utility\player::_setsuit("_encstr_B6C10E16FEB9C2379020FFBB7B6EFD9B");
}

_id_124E4() {
  self notify("_encstr_880812DE335B81880D27C8E0E74CC6C7535ECEDD");
  self endon("_encstr_880812DE335B81880D27C8E0E74CC6C7535ECEDD");

  if(isDefined(self._id_12147) && self.operatorcustomization.suit != self._id_12147) {
    self.operatorcustomization.suit = self._id_12147;
    scripts\mp\utility\player::_setsuit(self._id_12147);
    self._id_12147 = undefined;
  }
}

_id_124EF() {
  self notify("_encstr_873521DB506F07BF784F8B65E1E944930468B272FB35E7726839957A9FA04ABB3B608B");
  self endon("_encstr_873521DB506F07BF784F8B65E1E944930468B272FB35E7726839957A9FA04ABB3B608B");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self refreshsprinttime();
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    scripts\mp\utility\perk::giveperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
    scripts\mp\utility\perk::giveperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
    scripts\mp\utility\perk::giveperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
    scripts\mp\utility\perk::giveperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
  }
}

_id_124E3() {
  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::shouldlink()) {
    scripts\mp\utility\perk::removeperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
    scripts\mp\utility\perk::removeperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
    scripts\mp\utility\perk::removeperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
    scripts\mp\utility\perk::removeperk("_encstr_92891DBB833D1FCC9079DCC907F09617DD9B033308379BC2584FCFCE1B7858");
  }

  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
}

isplatepouch() {
  _encstr_86272063EE5BD1037B9032D850808A4F614F53F7470393A82283E9789593B5978ED7::_id_12B21(::isplacementplayerobstructed);
  level thread isplayerbrsquadleader();
}

isplayerbrsquadleader() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(level.player))
    waitframe();
}

isplacementplayerobstructed(var_0, var_1) {
  var_2 = "_encstr_B40101";

  switch (var_0) {
    case "_encstr_BD8C1E42692522B701B82397F17B507AF37581FEC057ABC42E584FD708732D73":
      level.player _keypadscriptableused_bunkeralt::_id_1393A("_encstr_9A570C4FD8FF88ADE7B260684BA3");
      break;
    case "_encstr_8F6F1FE4B5C463BE6EC185DDB9BEE638AC5991AF26DBDB6ED17DE07BEE599C57E0":
      var_3 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      easepower("_encstr_8165227EAB808F2AED6F0317639E62FD7173B583E1A85D13500F132F6BB5993248F82ACB", var_3);
      break;
    case "_encstr_A76D27935B2636AFB396B395F5479585D6B58547CAF5E61CCA9546AF26DEED6E8EFA387BDD959CBAC1":
      var_4 = scripts\mp\utility\teams::getteamdata(level.player.team, "_encstr_9775086022BE1B413B8B");
      var_4 = scripts\engine\utility::array_remove(var_4, level.player);
      var_4[randomintrange(0, var_4.size)] _keypadscriptableused_bunkeralt::_id_1393A("_encstr_9A570C4FD8FF88ADE7B260684BA3");
      break;
  }
}