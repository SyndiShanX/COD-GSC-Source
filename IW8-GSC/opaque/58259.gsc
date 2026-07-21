/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58259.gsc
***********************************************/

randomoffsetmortar() {
  return getdvarfloat("_encstr_85521F2646BB27FBF54328100F0F7199326F1DB81FE23BE1DF3771E8D721A8CBCB", 1.5);
}

_encstr_A7F5132F7C49B50BB9EF079AC33FA67740806783F3(var_0, var_1) {
  if(self isthrowingbackgrenade()) {
    self _meth_87A9();

    if(isDefined(var_1)) {
      var_2 = self getweaponammoclip(var_1);
      var_3 = int(max(var_2 - 1, 0));
      self setweaponammoclip(var_1, var_3);
    }
  }

  var_4 = "_encstr_840E0D6ECA39EA6BFAD9C2C8D995E8";
  var_5 = accesscardsspawned_red::preinfilstreamfunc();

  if(!isDefined(var_0))
    var_0 = getdvarint("_encstr_AAF522A7A06B3192D57228C19141615CE41908FE0393FB63F0B745D241FE577688E0FF0F", 40);

  if(!isDefined(var_5) || var_5 != var_4) {
    childthread apc_rus_update(var_0);
    childthread apc_rus_updatedriverturretammoui();
    childthread _encstr_83BD1A17FC6993E6E9C91B7288FB5D87236DB8A91E101FA1AB88A25B();
  }

  var_6 = getdvarfloat("_encstr_A5551A6E1B397D9BCA9CBAB57DEC168C3BAC8E7D5BDE9DB293B03ACA", 1.08);
  var_7 = "_encstr_8388125E35ED5A7E3978879318533DC289C02592";
  var_8 = "_encstr_8B880E3B782B3B528F416928DF5B3D4D";
  var_9 = 1;
  accesscardsspawned_red::_id_1380C(var_4, var_0, var_6, var_7, var_8, var_9);
}

_encstr_83141263F8B8BBB8FB8FBB1BA3C83F91603F5233() {
  var_0 = accesscardsspawned_red::preinfilstreamfunc();

  if(isDefined(var_0) && var_0 == "_encstr_840E0D6ECA39EA6BFAD9C2C8D995E8")
    accesscardsspawned_red::_id_138C8();
}

_encstr_83BD1A17FC6993E6E9C91B7288FB5D87236DB8A91E101FA1AB88A25B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A9461E178970C7E9C02005C2114ECE5530A86396EBBBBBB348BF11FA0CDFAB50");

  for(;;) {
    self waittill("_encstr_8B18148B28612902BDF0FB374353BAF409495733A87B");
    scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("_encstr_B2880BBBD78797A7D75F660BAB", 0.0);
  }
}

apc_rus_update(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_8C021FE6A3C239D1BEB9C1B2B2C8FA98DBEDE63A7DE6B227ABB6D7D92C23D9591D");
  scripts\mp\utility\perk::giveperk("_encstr_840E0D6ECA39EA6BFAD9C2C8D995E8");
  scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("_encstr_B2880BBBD78797A7D75F660BAB", 1.5);

  if(self getscriptablehaspart("_encstr_85C30D1B42CFFDD11F32D3EB7E8FD1"))
    self setscriptablepartstate("_encstr_85C30D1B42CFFDD11F32D3EB7E8FD1", "_encstr_930B07BB1B6B3854FF");

  scripts\mp\gamelogic::sethasdonecombat(self, 1);
}

apc_rus_updatedriverturretammoui() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_A9461E178970C7E9C02005C2114ECE5530A86396EBBBBBB348BF11FA0CDFAB50");
  scripts\mp\utility\perk::removeperk("_encstr_840E0D6ECA39EA6BFAD9C2C8D995E8");

  if(self isscriptable() && self getscriptablehaspart("_encstr_85C30D1B42CFFDD11F32D3EB7E8FD1") && self getscriptablepartstate("_encstr_85C30D1B42CFFDD11F32D3EB7E8FD1") == "_encstr_930B07BB1B6B3854FF") {
    if(!scripts\mp\utility\player::isreallyalive(self))
      self setscriptablepartstate("_encstr_85C30D1B42CFFDD11F32D3EB7E8FD1", "_encstr_A7A408B9CA5D1D4E2C63");
    else {
      self setscriptablepartstate("_encstr_85C30D1B42CFFDD11F32D3EB7E8FD1", "_encstr_819B0B74BD21871BD348E2ABC8");
      self playlocalsound("_encstr_9A591C4DC97F883057C2C32BAA0F51209621E99F60E5E06B578B7ED182DB");
    }
  }

  scripts\cp_mp\utility\game_utility::_visionsetnakedforplayer("_encstr_B40101", 3);
}