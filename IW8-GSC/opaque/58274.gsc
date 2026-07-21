/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58274.gsc
***********************************************/

init() {
  level._effect["_encstr_88B118507B9836BD5319FF08EC4A49FBD7B770C8DF5DE8AF9AF8"] = loadfx("_encstr_88852DB3661E5E2DEEE0EB262779ECC2AD598336B02FF239AED6891B59BCCE99E1AF39ABB6FA641ED737D8C97399C3");
  level._effect["_encstr_87261FF3E51BD112D8FE12DDD0809CEB602D172F79CBBA0768220AE50850D96240"] = loadfx("_encstr_A30C3720DD889D50AB0819A2E572E7D2909F0BCA264F5785554815E240D7883109773580908EE09702F8938871AB2AE9FF5B4F10A7731F8815");
  level._effect["_encstr_9B34189CF4201FCE933F0B70900EB573E7E809C00929FF218F8C"] = loadfx("_encstr_AC0F322B1EE367180F62A1E9E01837D7FD19A2D18870BD5ECD1B85698212CB47C0492B635190FF33270B50D50B8369638307E2E1");
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_811916632D64571D4F4FFE2910DBD6611D914B074B081537"] = "_encstr_83FB1707EDBB594E7D5738FA8CF657C48D59D7077BA537A3E6";
  var_0 = spawnStruct();
  var_0._id_138FD = "_encstr_88E60E61324B219B37B0A2F8D74AD337";
  var_0.parachute_get_path = getdvarfloat("_encstr_8C2A2B3718EEF8F28B8FB817FD1B037BF3EFE940832AA235D818B82DD83BAF718315CACDC9D133A036D39F389B", 45);
  var_0.asm_playfacialanim_mp = ::asm_playfacialanim_mp;
  var_0._id_12A35 = ::_id_12A35;
  var_0.isdeathshieldskippingenabled = ::isdeathshieldskippingenabled;
  _keypadscriptableused_bunkeralt::_id_12AF4(var_0);
}

asm_playfacialanim_mp() {
  self._id_1265D = 0;
  self._id_11E08 = 2;
  self.player._id_12827 = 1;
  level thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_811916632D64571D4F4FFE2910DBD6611D914B074B081537", self.player);
  thread _id_135B7();
  self.player playlocalsound("_encstr_A67B1BCA13B0E3FD90FB4A35A9A906E74DA8F3B23B75A762C0A7402485");
  _keypadscriptableused_bunkeralt::_id_12425(self.player, "_encstr_BDA62A0D0339F678B5466841217070AC72FBABB11F323030D2DD711E124708683B57071B775B8BD0E9B37971");
}

isdeathshieldskippingenabled() {
  self notify("_encstr_8C631A37D2E6D936AC3AB7E6D71959851BA35ACEC2E856BECC57736C");
  self endon("_encstr_8C631A37D2E6D936AC3AB7E6D71959851BA35ACEC2E856BECC57736C");
  self.player._id_12827 = 0;
  thread lb_impulse_dmg_threshold_low();

  if(isalive(self.player))
    self.player playlocalsound("_encstr_BA8C1DD6E0AF0EDEDD2B39BA1CFA19CA2C6C1DB4EC2C47957D46C3AF83B193");
}

_id_12A35() {
  open_starting_safehouse_door(self._id_12E2D.parachute_get_path);
  self.player playlocalsound("_encstr_8A771D59F2190908974F406003E7E36B825E4DD3CB52D9B1573A18396BFC3B");
}

_id_11FF1(var_0) {
  if(isDefined(var_0.attacker) && istrue(var_0.attacker._id_12827)) {
    playFX(scripts\engine\utility::getfx("_encstr_87261FF3E51BD112D8FE12DDD0809CEB602D172F79CBBA0768220AE50850D96240"), var_0.victim.origin);
    var_1 = easepower("_encstr_A5F01AE21AF872F7682F0305C141D943D96310EF5FB20D8B219E2320", var_0.victim.origin);
    var_1 setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_B8C1134FBB7F3B08B80B532529FA1F3B1BCBE9CB58");
    var_0.attacker playlocalsound("_encstr_99C91FDA38EB38B7EEAC27D538D7B3A5D8E8D25BBE32CAC2D10DAFC887FAE0364E");
    var_2 = var_0.attacker _keypadscriptableused_bunkeralt::_id_1249C("_encstr_88E60E61324B219B37B0A2F8D74AD337");
    var_3 = 50;
  }
}

open_starting_safehouse_door(var_0) {
  self.mp_layover_patch = gettime() + var_0 * 1000;
  self.player thread _keypadscriptableused_bunkeralt::_id_13F7E(undefined, 1, 2);
}

_id_135B7() {
  playFXOnTag(scripts\engine\utility::getfx("_encstr_9B34189CF4201FCE933F0B70900EB573E7E809C00929FF218F8C"), self.player, "_encstr_A1190BD4FABB9396DC47EB8DAC");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_9B34189CF4201FCE933F0B70900EB573E7E809C00929FF218F8C"), self.player, "_encstr_83190BED4757A3B3B20C5E83E0");
  waitframe();
  stopfxontagforclients(scripts\engine\utility::getfx("_encstr_9B34189CF4201FCE933F0B70900EB573E7E809C00929FF218F8C"), self.player, "_encstr_A1190BD4FABB9396DC47EB8DAC", self.player);
  waitframe();
  stopfxontagforclients(scripts\engine\utility::getfx("_encstr_9B34189CF4201FCE933F0B70900EB573E7E809C00929FF218F8C"), self.player, "_encstr_83190BED4757A3B3B20C5E83E0", self.player);
}

lb_impulse_dmg_threshold_low() {
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_9B34189CF4201FCE933F0B70900EB573E7E809C00929FF218F8C"), self.player, "_encstr_A1190BD4FABB9396DC47EB8DAC");
  waitframe();
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_9B34189CF4201FCE933F0B70900EB573E7E809C00929FF218F8C"), self.player, "_encstr_83190BED4757A3B3B20C5E83E0");
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
    case "_encstr_8FA820D2A06275611FD70B27F73DC7E56E8060F0F8B863AD63B318A84F97FB62DFC1":
      level.player _keypadscriptableused_bunkeralt::_id_1393A("_encstr_88E60E61324B219B37B0A2F8D74AD337");
      break;
    case "_encstr_9BDB214E6B89C6BE37832C77DC7D23B7574CD895BE0EEDD2DCE8CDFA83DEEEACE4AB07":
      var_3 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      easepower("_encstr_84C724C2703905675B60BAB501E113CF37F89A2B60DD7BD316D5BFCDAE08FF99D16862321077", var_3);
      break;
    case "_encstr_862C29C2E9A5A2378138A317711BC5BA63718EFB45B75A5FEB48C31F59B3B762CD1592B9B76FA39D53E8AB":
      var_4 = scripts\mp\utility\teams::getteamdata(level.player.team, "_encstr_9775086022BE1B413B8B");
      var_4 = scripts\engine\utility::array_remove(var_4, level.player);
      var_4[randomintrange(0, var_4.size)] _keypadscriptableused_bunkeralt::_id_1393A("_encstr_88E60E61324B219B37B0A2F8D74AD337");
      break;
  }
}