/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rumble_invasion\br_ri_utils.gsc
********************************************************/

assignclientmatchdataid() {
  if(getdvarint("_encstr_A66C14DEBE43DF13312F58388743ABA75A655FEED5EA", 1) == 1) {
    var_0 = "_encstr_8898102DE6B15D936E967B73F513DEF6B947";
    var_1 = accesscardsspawned_red::preinfilstreamfunc();
    var_2 = getdvarint("_encstr_93ED1667B0E3EF936B105E156007ABA789B8EBB7E078079A", 30);

    if(!isDefined(var_1) || var_1 != var_0) {
      thread apc_rus_postmoddamagecallback();
      thread ammobox_updateheadicononjointeam();
      thread _encstr_B14B177D77B0D1B10DD7A5371BEA9CCD4BBD73AF1D2DAD954E(var_2);
      thread _encstr_A57922C7A76A4598E059B8507EC5287E425F2DBF9BD280D014A10109E6BB50BB4BCF8143();
    }

    var_3 = getdvarfloat("_encstr_BDAB133656AB37CBE9076010DF2BC3FF03FEA731AF", 1.5);
    var_4 = "_encstr_B6C10E16FEB9C2379020FFBB7B6EFD9B";
    var_5 = "_encstr_8B880E3B782B3B528F416928DF5B3D4D";
    var_6 = 1;
    thread accesscardsspawned_red::_id_1380C(var_0, var_2, var_3, var_4, var_5, var_6);
  }
}

isdragonsbreath() {
  var_0 = accesscardsspawned_red::preinfilstreamfunc();

  if(isDefined(var_0) && var_0 == "_encstr_8898102DE6B15D936E967B73F513DEF6B947")
    accesscardsspawned_red::_id_138C8();
}

apc_rus_postmoddamagecallback() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_9372221853E1339181B25FED0F0AFF7947A7905897B10877CB1AD6E3E5C2B7A1BF0F08D0");
  self setclientomnvar("_encstr_8C1F1B1BF3F74B2278E8E7BB58D1FEC27D9569D36B2B526AC6E0BFB3A0", 4);
  self notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
}

_encstr_B14B177D77B0D1B10DD7A5371BEA9CCD4BBD73AF1D2DAD954E(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_ADB021DB702538E793036001A24F02C748F7339171E86E73637B40F2D02FDA2AA823A3");

  for(;;) {
    var_1 = gettime() + var_0 * 1000;
    self setclientomnvar("_encstr_96FC169BD7814FE8E91BA11BC7CDB30D2A0B5711AFCA9DD0", var_1);
    self waittill("_encstr_8308284293B0FDD2204D3FC7975DA93930597B8A6BB88F2A186537CFBF05D17CA060F71286D84D336D51", var_0);
  }
}

_encstr_A57922C7A76A4598E059B8507EC5287E425F2DBF9BD280D014A10109E6BB50BB4BCF8143() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_ADB021DB702538E793036001A24F02C748F7339171E86E73637B40F2D02FDA2AA823A3");
  self setclientomnvar("_encstr_8C1F1B1BF3F74B2278E8E7BB58D1FEC27D9569D36B2B526AC6E0BFB3A0", 0);
}

ammobox_updateheadicononjointeam() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_ADB021DB702538E793036001A24F02C748F7339171E86E73637B40F2D02FDA2AA823A3");
  scripts\engine\utility::waittill_all_in_array(["_encstr_84750DC45676D2DCAF99B4C94B9B9D", "_encstr_9372221853E1339181B25FED0F0AFF7947A7905897B10877CB1AD6E3E5C2B7A1BF0F08D0"]);
  isdragonsbreath();
}