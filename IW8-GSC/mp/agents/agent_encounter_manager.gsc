/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\agents\agent_encounter_manager.gsc
*************************************************/

init() {
  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9 = spawnStruct();
  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9.encounters = [];
  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_8A1F12732B878EFAB2371BDBBAE61D564E7DD219 = 0;
  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_A17D0C40DBB7391E7F67B5386CEF = 0;
  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_AC730EAA4AF5C8531F41D3112E4A1D23 = [];
  init_dvars();
  _encstr_82550EA573A5D1FA199533B0AB8D479B();
}

init_dvars() {
  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_BA6E0BD208F1297F195D86946E = getdvarint("_encstr_8E401637C69CFA19B2CCC2BAD8D1EBB516E1853B59E68EDC", 48);
}

_encstr_BDA017BF576A18BD92C1E8B1AF68412035B297E910DF0E508A(var_0) {
  return var_0 <= level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_BA6E0BD208F1297F195D86946E - level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_A17D0C40DBB7391E7F67B5386CEF;
}

_encstr_ACE9149F327129B8802030DB068B72EDFFD2EFF773FF(var_0) {
  var_1 = level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9.encounters[var_0];

  if(isDefined(var_1))
    var_1 _encstr_9ACC0EF7987941DD70D87707A86B95DB();
}

_encstr_82550EA573A5D1FA199533B0AB8D479B() {
  _handlevehiclerepair::init();
  var_0 = [];
  var_0["_encstr_8DDE08CDF61D434BB9B3"] = 1.0;
  var_0["_encstr_83D8191DAACDA8781B3191187A1F38D0241CB99B32F908B73F8A49"] = 0.8;
  var_0["_encstr_82A813C6133837A275F7C7F3EB903B4F8078BECB69"] = 0.4;
  _handlevehiclerepair::_id_11A45("_encstr_932E20497C423EC3799B6D7E47E0DBFB653B21751706A0770D7609B9AA9CBE8D1494", var_0);
  _encstr_8DFD1523C00199C3114D9AD9A7EF7A56CBA9EFC388FBDB("_encstr_8B1608EC43B8D647A113");
  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_A73215B06865577BBC3B8123C1416FD5A9E32A66407D9A = _encstr_979219BB018470F89F4B69D3D25727189A99333F972AA8BDDF3323();
}

_encstr_BE7218A7D1D82762DCA3DB8BEFF6FA51B87BD16ECA29AEBA214B(var_0) {
  if(!isDefined(var_0) || !isDefined(level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_AC730EAA4AF5C8531F41D3112E4A1D23[var_0]))
    var_0 = "_encstr_8B1608EC43B8D647A113";

  return level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_AC730EAA4AF5C8531F41D3112E4A1D23[var_0];
}

_encstr_A33E17D13ED2ABB62B9340F8836F2BDB2BA65966197A7BFBF4(var_0, var_1) {
  if(!isDefined(var_0) || var_0.size <= 0)
    return level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_A73215B06865577BBC3B8123C1416FD5A9E32A66407D9A;

  var_2 = spawnStruct();
  var_2.spawn_type = "_encstr_A2AD058D96B9E8";
  var_2.spawn_points = var_0;
  var_2._encstr_BADD0EF86FAA673827434206DB973BF5 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 0);
  return var_2;
}

_encstr_979219BB018470F89F4B69D3D25727189A99333F972AA8BDDF3323(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.spawn_type = "_encstr_8D4607ABF0ABE4FB47";
  var_3._encstr_A6D30B6BB49B7D4E0B912DABCD = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 100);
  var_3._encstr_96200B25CF7171FAA1B03F7730 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 2500);
  var_3._encstr_BADD0EF86FAA673827434206DB973BF5 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0);
  return var_3;
}

_encstr_B8521C6A304BD3D120CD7B4FC34023DF6E8E7392DB170F12191F6749A530(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "_encstr_93A206EADB3842FA";
  var_4._encstr_8AD61122E7F33BF8760DB7C0A04B346B3AFBEE = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);
  var_4._encstr_BAC50D7B65C84985F126017A954302 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 9999);
  var_4.class = _encstr_BE7218A7D1D82762DCA3DB8BEFF6FA51B87BD16ECA29AEBA214B(var_2);
  var_4._encstr_868B0DB8E341F3C5E112B7C6AE3A07 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_A73215B06865577BBC3B8123C1416FD5A9E32A66407D9A);
  return var_4;
}

_encstr_88461C43FED42828179A198033E37568AA77F9CB8ABEB806D7E351AB1AFF(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.type = "_encstr_8A4C06DD0B67596E";
  var_2._encstr_8A4C06DD0B67596E = var_0;
  var_2._encstr_8AD61122E7F33BF8760DB7C0A04B346B3AFBEE = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 1);
  var_2._encstr_868B0DB8E341F3C5E112B7C6AE3A07 = level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_A73215B06865577BBC3B8123C1416FD5A9E32A66407D9A;
  return var_2;
}

_encstr_BE140A6B0B6DCAAFBB16EC59(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._encstr_A2C20B25051B31A921F8633370 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);
  var_4._encstr_84C914C3C83B867F187BA6A71823030A43E0EAAA28F1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 0);
  var_4._encstr_868B0DB8E341F3C5E112B7C6AE3A07 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_A73215B06865577BBC3B8123C1416FD5A9E32A66407D9A);
  var_4.class = _encstr_BE7218A7D1D82762DCA3DB8BEFF6FA51B87BD16ECA29AEBA214B(var_2);
  return var_4;
}

_encstr_8DFD1523C00199C3114D9AD9A7EF7A56CBA9EFC388FBDB(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0)) {
    var_5 = spawnStruct();
    var_5.type = scripts\engine\utility::ter_op(isDefined(var_1), var_1, "_encstr_A31412FAF6CBE2E39887CE19E8FB318DA431852B");
    var_5._id_1404D = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0);
    var_5._encstr_83C50F8D7B7BA3EB8E0B31D856EB5B95F2 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, "_encstr_932E20497C423EC3799B6D7E47E0DBFB653B21751706A0770D7609B9AA9CBE8D1494");
    var_5._encstr_A189106A0A604B19D473F7BBC0F018AB7099 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, 1);
    level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_AC730EAA4AF5C8531F41D3112E4A1D23[var_0] = var_5;
  }
}

_encstr_8EB6104AAD5BBBD44E800B37B863B6A33BC6(var_0, var_1) {
  if(!_encstr_AD4A17670B362D19168ECAAFB959DDF5CACDC6BD57DC1DCA93(var_1))
    return undefined;

  var_2 = spawnStruct();
  var_2.id = level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_8A1F12732B878EFAB2371BDBBAE61D564E7DD219;
  var_2.agents = [];
  var_2.params = var_1;
  var_2.origin = var_0;
  var_2._encstr_BA6E0BD208F1297F195D86946E = var_1._encstr_8AD61122E7F33BF8760DB7C0A04B346B3AFBEE;
  var_2._encstr_8D8C0C1037A8573A0BF6FF78F1FB = 0;
  var_2._encstr_97C50BB0FD3F6647CC5AC080F2 = 0;
  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_8A1F12732B878EFAB2371BDBBAE61D564E7DD219++;
  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_A17D0C40DBB7391E7F67B5386CEF = level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_A17D0C40DBB7391E7F67B5386CEF + var_1._encstr_8AD61122E7F33BF8760DB7C0A04B346B3AFBEE;

  if(!isDefined(var_1.type))
    var_1.type = "_encstr_93A206EADB3842FA";

  switch (var_1.type) {
    case "_encstr_8A4C06DD0B67596E":
      var_2 thread _encstr_AC87150FD81BBD292BD0362D45D5534563C19BFB20B0FB();
      break;
    case "_encstr_93A206EADB3842FA":
      var_2 thread _encstr_87E316377785C95BBE59CDD8DED5DCA3B227FA471A5ACD5B();
      break;
    default:
  }

  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9.encounters[var_2.id] = var_2;
  return var_2;
}

_encstr_AD4A17670B362D19168ECAAFB959DDF5CACDC6BD57DC1DCA93(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isDefined(var_0._encstr_8AD61122E7F33BF8760DB7C0A04B346B3AFBEE))
    return 0;

  if(!_encstr_BDA017BF576A18BD92C1E8B1AF68412035B297E910DF0E508A(var_0._encstr_8AD61122E7F33BF8760DB7C0A04B346B3AFBEE))
    return 0;

  if(!isDefined(var_0._encstr_868B0DB8E341F3C5E112B7C6AE3A07))
    return 0;

  return 1;
}

_encstr_9ACC0EF7987941DD70D87707A86B95DB() {
  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_A17D0C40DBB7391E7F67B5386CEF = level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9._encstr_A17D0C40DBB7391E7F67B5386CEF - self.params._encstr_8AD61122E7F33BF8760DB7C0A04B346B3AFBEE;

  foreach(var_1 in self.agents)
  var_1 despawnagent();

  level._encstr_936D15C2A5AF5637C6F65DCD8E59C9BEB60BE658EC95C9.encounters[self.id] = undefined;
  self notify("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
}

_encstr_AC87150FD81BBD292BD0362D45D5534563C19BFB20B0FB() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  _encstr_BAD31833CA03652997A60767C53D383D4B810BF9034FA40B6B85(0);

  for(;;) {
    var_0 = self.initoperatorunlocks;

    while(self._encstr_8D8C0C1037A8573A0BF6FF78F1FB < self._encstr_950A0ACDEADA7D3A7B1DB063) {
      if(self.agents.size >= self._encstr_BA6E0BD208F1297F195D86946E || scripts\mp\mp_agent::getfreeagentcount() <= 0) {
        break;
      }

      var_1 = rear_door_collision(var_0._encstr_868B0DB8E341F3C5E112B7C6AE3A07);

      if(isDefined(var_1))
        spawn_agent(var_1[0], var_1[1], var_0.class, var_0._encstr_868B0DB8E341F3C5E112B7C6AE3A07._encstr_BADD0EF86FAA673827434206DB973BF5);

      waitframe();
    }

    if(self._encstr_8D8C0C1037A8573A0BF6FF78F1FB >= self._encstr_950A0ACDEADA7D3A7B1DB063 && self._encstr_950A0ACDEADA7D3A7B1DB063 - self._encstr_97C50BB0FD3F6647CC5AC080F2 <= var_0._encstr_84C914C3C83B867F187BA6A71823030A43E0EAAA28F1) {
      if(self._encstr_B84F0B8BD1C497D140CD7C45D9 + 1 >= self.params._encstr_8A4C06DD0B67596E.size) {
        break;
      }

      _encstr_BAD31833CA03652997A60767C53D383D4B810BF9034FA40B6B85(self._encstr_B84F0B8BD1C497D140CD7C45D9 + 1);
      continue;
    }

    self waittill("_encstr_8AD00CE78F028DC317D31038FB48");
    wait 1.0;
  }

  while(self.agents.size > 0)
    self waittill("_encstr_8AD00CE78F028DC317D31038FB48");

  _encstr_9ACC0EF7987941DD70D87707A86B95DB();
}

_encstr_BAD31833CA03652997A60767C53D383D4B810BF9034FA40B6B85(var_0) {
  if(var_0 < 0 || var_0 >= self.params._encstr_8A4C06DD0B67596E.size) {
    return;
  }
  self._encstr_B84F0B8BD1C497D140CD7C45D9 = var_0;
  self.initoperatorunlocks = self.params._encstr_8A4C06DD0B67596E[var_0];
  self._encstr_8D8C0C1037A8573A0BF6FF78F1FB = self.agents.size;
  self._encstr_950A0ACDEADA7D3A7B1DB063 = self.initoperatorunlocks._encstr_A2C20B25051B31A921F8633370 + self.agents.size;
  self._encstr_97C50BB0FD3F6647CC5AC080F2 = 0;
}

_encstr_87E316377785C95BBE59CDD8DED5DCA3B227FA471A5ACD5B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  self._encstr_950A0ACDEADA7D3A7B1DB063 = self.params._encstr_BAC50D7B65C84985F126017A954302;

  while(self._encstr_8D8C0C1037A8573A0BF6FF78F1FB < self._encstr_950A0ACDEADA7D3A7B1DB063) {
    if(self.agents.size >= self._encstr_BA6E0BD208F1297F195D86946E || scripts\mp\mp_agent::getfreeagentcount() <= 0) {
      self waittill("_encstr_8AD00CE78F028DC317D31038FB48");
      wait 1.0;
    }

    var_0 = rear_door_collision();

    if(isDefined(var_0))
      spawn_agent(var_0[0], var_0[1], self.params.class, self.params._encstr_868B0DB8E341F3C5E112B7C6AE3A07._encstr_BADD0EF86FAA673827434206DB973BF5);

    waitframe();
  }

  while(self._encstr_97C50BB0FD3F6647CC5AC080F2 < self._encstr_950A0ACDEADA7D3A7B1DB063)
    self waittill("_encstr_8AD00CE78F028DC317D31038FB48");

  _encstr_9ACC0EF7987941DD70D87707A86B95DB();
}

spawn_agent(var_0, var_1, var_2, var_3, var_4) {
  if(self.agents.size >= self._encstr_BA6E0BD208F1297F195D86946E)
    return undefined;

  if(scripts\mp\mp_agent::getfreeagentcount() <= 0)
    return undefined;

  if(!isDefined(var_4))
    var_4 = "_encstr_9BDB118E2B85D6BE47BBEDF5D0D5733227ACC8";

  var_5 = undefined;

  if(var_3 && isDefined(level._encstr_A3271AA18AE35EF88534999B25AAA8AFDB1299E883131D9B9A11B79D))
    var_5 = _testing_ending::_encstr_82F017C37BFB3B65E0678B7040137ED62AE87385A8FF8A3D93(var_0, var_1, var_2._id_1404D, var_2.type, var_4);
  else
    var_5 = _testing_ending::spawnnewagent(var_0, var_1, var_2._id_1404D, var_2.type, var_4);

  if(!isDefined(var_5)) {}

  var_5.class = var_2;
  var_5.isinlaststand = ::_encstr_B66418FBBB8869897D1FCFF7AD9A5BC61867C2093491EFA0175D;
  self._encstr_8D8C0C1037A8573A0BF6FF78F1FB++;
  self.agents[self.agents.size] = var_5;
  thread watch_agent_death(var_5);
  return var_5;
}

rear_door_collision(var_0) {
  if(!isDefined(var_0))
    var_0 = self.params._encstr_868B0DB8E341F3C5E112B7C6AE3A07;

  var_1 = undefined;

  switch (var_0.spawn_type) {
    case "_encstr_8D4607ABF0ABE4FB47":
      var_1 = _encstr_9B3C179D951DAF9B0E0BEEE67DE0DBB47347FA4E0B235A57E6(var_0);
      break;
    case "_encstr_A2AD058D96B9E8":
      var_1 = _encstr_A1631A8F2523C18EF33ACBD0E1CB48B87DAC7775DA4DE8C0EBD2439B(var_0);
      break;
    default:
  }

  return var_1;
}

_encstr_9B3C179D951DAF9B0E0BEEE67DE0DBB47347FA4E0B235A57E6(var_0) {
  var_1 = randomfloatrange(0, 360);
  var_2 = anglesToForward((0, var_1, 0));
  var_3 = randomfloatrange(var_0._encstr_A6D30B6BB49B7D4E0B912DABCD, var_0._encstr_96200B25CF7171FAA1B03F7730);
  var_4 = self.origin + var_2 * var_3;
  var_4 = getclosestpointonnavmesh(var_4);
  return [var_4, (0, randomfloatrange(0, 360), 0)];
}

_encstr_A1631A8F2523C18EF33ACBD0E1CB48B87DAC7775DA4DE8C0EBD2439B(var_0) {
  var_1 = randomintrange(0, var_0.spawn_points.size);
  return var_0._encstr_87890CC05B068FA81770C048FC5F[var_1];
}

_encstr_999515BB952BC329736F09E04787812BF27F25BDA142A3(var_0) {
  self._encstr_BA6E0BD208F1297F195D86946E = self._encstr_BA6E0BD208F1297F195D86946E + var_0;
  self notify("_encstr_8AD00CE78F028DC317D31038FB48");
}

watch_agent_death(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_83A10EA7ED9EDA5D50934F92EED09EA2");
  var_0 waittill("_encstr_AD75063D571AE108");
  self.agents = scripts\engine\utility::array_remove(self.agents, var_0);
  self._encstr_97C50BB0FD3F6647CC5AC080F2++;
  self notify("_encstr_8AD00CE78F028DC317D31038FB48");
}

_encstr_B66418FBBB8869897D1FCFF7AD9A5BC61867C2093491EFA0175D(var_0) {
  var_1 = [];
  var_1["_encstr_97BD0AB214A31D85D8AD594E"] = var_0.eattacker;
  level thread _handlevehiclerepair::_id_13673(self.class._encstr_83C50F8D7B7BA3EB8E0B31D856EB5B95F2, self.origin, self.class._encstr_A189106A0A604B19D473F7BBC0F018AB7099, 0, var_1);
}