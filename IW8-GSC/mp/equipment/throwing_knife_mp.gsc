/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\throwing_knife_mp.gsc
***********************************************/

throwing_knife_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_BA6F07F2708FA42359", ::throwing_knife_mp_ongive);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_ABCE07DBE61516B6AC", ::throwing_knife_mp_ontake);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_99C10CE3C6F341670758978F803B", ::throwing_knife_mp_trytopickup);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_A3E90D4B10F00AB1E8C337D8E49DA8", ::_id_13B51);
}

throwing_knife_mp_ongive(var_0, var_1) {
  if(var_0 == "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC") {
    self._id_13B5C = "_encstr_B6202030B8C2304120681F3C3C48493BD6B4CC476F18BBF297D92FA5085FC1F7E5FB";
    thread _id_13B5A();
  } else if(var_0 == "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B") {
    self._id_13B5C = "_encstr_93C224EC0CC949B4C8586F07A8209FB2CDABB767E0ABB2EDF1100347E0FE5D1AB135FF1151E9";
    thread _id_13B56();
  } else if(var_0 == "_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1")
    self._id_13B5C = "_encstr_A10A211A6393EF8BD845C7C76BB01777D0D86242CE0583041051FFD51B885FB790F07B";
  else
    self._id_13B5C = "_encstr_AFBB115ADD1CD75BDCA5CC56DC1D2CC4D7DAC1";

  scripts\mp\utility\perk::giveperk("_encstr_86121E3BCBD24FDB404B1DD191AA73B37C1BD7C4D20608E32315CF2F8EF7E7ED");
}

throwing_knife_mp_ontake(var_0, var_1) {
  if(scripts\mp\utility\perk::_hasperk("_encstr_86121E3BCBD24FDB404B1DD191AA73B37C1BD7C4D20608E32315CF2F8EF7E7ED"))
    scripts\mp\utility\perk::removeperk("_encstr_86121E3BCBD24FDB404B1DD191AA73B37C1BD7C4D20608E32315CF2F8EF7E7ED");

  self._id_13B5C = undefined;
}

throwing_knife_mp_trytopickup(var_0) {
  if(scripts\mp\equipment::getequipmentammo(var_0) >= scripts\mp\equipment::getequipmentmaxammo(var_0))
    return 0;

  scripts\mp\equipment::incrementequipmentammo(var_0);

  if(var_0 == "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC")
    scripts\mp\damagefeedback::hudicontype("_encstr_8669131DD0E4F6DD2DE6EC5BCDB4CC95FA995AC995");
  else
    scripts\mp\damagefeedback::hudicontype("_encstr_92590EFBF91ED25750D8D7DC30B88E8A");

  return 1;
}

_id_13B51(var_0) {
  thread _id_13B59();
  var_0 setscriptablepartstate("_encstr_92ED0B135F227368B503F08934", "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

_id_13B5A() {
  self notify("_encstr_881917473439B7BB4BE69D2D372D99CABE1BC6955839F5CCC3");
  self endon("_encstr_881917473439B7BB4BE69D2D372D99CABE1BC6955839F5CCC3");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = self getheldoffhand();

    if(!nullweapon(var_2) && var_2.basename == "_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83")
      var_1 = 1;

    if(var_1 && !var_0)
      thread _id_13B57();
    else if(var_0 && !var_1)
      thread _id_13B59();

    var_0 = var_1;
    waitframe();
  }
}

_id_13B57() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9950150310887763BBD59FD72D53BAB539193D8F6E4018");
  self._id_12748 = 1;
  self setscriptablepartstate("_encstr_BD8411955CEA2D07A6A3B7B3C816AEDE393619", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_915110C201FF735285933AA351C30E3A0358", "_encstr_930B07BB1B6B3854FF", 0);
  var_0 = 0.4;
  wait(var_0);
  self setscriptablepartstate("_encstr_BD8411955CEA2D07A6A3B7B3C816AEDE393619", "_encstr_930B07BB1B6B3854FF", 0);
  self waittill("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0");
  waitframe();
  thread _id_13B59();
}

_id_13B59() {
  self notify("_encstr_9950150310887763BBD59FD72D53BAB539193D8F6E4018");

  if(istrue(self._id_12748)) {
    self setscriptablepartstate("_encstr_BD8411955CEA2D07A6A3B7B3C816AEDE393619", "_encstr_A7A408B9CA5D1D4E2C63", 0);
    self setscriptablepartstate("_encstr_915110C201FF735285933AA351C30E3A0358", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  }

  self._id_12748 = undefined;
}

_id_13B52() {
  self notify("_encstr_881917473439B7BB4BE69D2D372D99CABE1BC6955839F5CCC3");
  thread _id_13B59();
  thread _id_13B55();
}

_id_13B56() {
  self notify("_encstr_B86B200148C50F8B99E0377382CB62827F9BD1F9E244439A1F1FC72937C7C379C5A8");
  self endon("_encstr_B86B200148C50F8B99E0377382CB62827F9BD1F9E244439A1F1FC72937C7C379C5A8");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = 0;

  for(;;) {
    var_1 = 0;
    var_2 = self getheldoffhand();

    if(!nullweapon(var_2) && var_2.basename == "_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170")
      var_1 = 1;

    if(var_1 && !var_0)
      thread _id_13B53();
    else if(var_0 && !var_1)
      thread _id_13B55();

    var_0 = var_1;
    waitframe();
  }
}

_id_13B53() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_938C1EDBC850AFCB036D378F453BE21D91F1556741B87A626E77272349C82A48");
  self._id_12747 = 1;
  self setscriptablepartstate("_encstr_BD8411955CEA2D07A6A3B7B3C816AEDE393619", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_915110C201FF735285933AA351C30E3A0358", "_encstr_8FC80EB2B1CA3647E4D2365ACD4B99CA", 0);
  var_0 = 0.4;
  wait(var_0);
  self setscriptablepartstate("_encstr_BD8411955CEA2D07A6A3B7B3C816AEDE393619", "_encstr_8FC80EB2B1CA3647E4D2365ACD4B99CA", 0);
  self waittill("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0");
  waitframe();
  thread _id_13B55();
}

_id_13B55() {
  self notify("_encstr_938C1EDBC850AFCB036D378F453BE21D91F1556741B87A626E77272349C82A48");

  if(istrue(self._id_12747)) {
    self setscriptablepartstate("_encstr_BD8411955CEA2D07A6A3B7B3C816AEDE393619", "_encstr_A7A408B9CA5D1D4E2C63", 0);
    self setscriptablepartstate("_encstr_915110C201FF735285933AA351C30E3A0358", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  }

  self._id_12747 = undefined;
}

_id_13B54() {
  self notify("_encstr_B86B200148C50F8B99E0377382CB62827F9BD1F9E244439A1F1FC72937C7C379C5A8");
  thread _id_13B55();
}