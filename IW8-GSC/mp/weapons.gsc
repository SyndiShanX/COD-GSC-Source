/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\weapons.gsc
***********************************************/

attachmentgroup(var_0) {
  return tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_0, 2);
}

init() {
  level.scavenger_altmode = 1;
  level.scavenger_secondary = 1;
  level._id_12E38 = getdvarint("_encstr_B82E1806669B07F9C2D7383A37E611BB824FF387BA83BF61B55F", 12);
  level._id_12E39 = getdvarfloat("_encstr_B4391D9BC639EB98C97D9B865ADC8D599B23960B39CBF5A3B4D8AD270B3A59", 0.25);
  level.maxperplayerexplosives = max(scripts\mp\utility\dvars::getintproperty("_encstr_A6531BDF5BAAC999AFA317B92B43C1E080B5253BD89218D09FAAEBA1C3", 2), 1);
  level.riotshieldxpbullets = scripts\mp\utility\dvars::getintproperty("_encstr_9A6E18E33EC3F71A537B3359208B17F3B90B484A4D6863E74108", 15);
  createthreatbiasgroup("_encstr_8D980F3D85572071BFBD133BC974288A87");
  createthreatbiasgroup("_encstr_8F670511EDCEB9");
  setignoremegroup("_encstr_8D980F3D85572071BFBD133BC974288A87", "_encstr_8F670511EDCEB9");

  switch (scripts\mp\utility\dvars::getintproperty("_encstr_928E130177C35211832ED1CB5776189D1B7F87A1EF", 0)) {
    case 1:
      level.scavenger_altmode = 0;
      break;
    case 2:
      level.scavenger_secondary = 0;
      break;
    case 3:
      level.scavenger_altmode = 0;
      level.scavenger_secondary = 0;
      break;
  }

  buildweaponmap();
  buildattachmentmaps();
  level._effect["_encstr_9B12096789A1B13BC3F8E3"] = loadfx("_encstr_A97F2678CDC07E4F02DE27A7C5CB90CFFA05A4534DE3329CE09C38C307D2F5EB78D7D67AFD233D39");
  level._effect["_encstr_887011CAADC1AF3B2B344BD8B1B2EBCD3AD59B"] = loadfx("_encstr_9A893ECB10E02A81288A113AF3BDDB1B405F7BB78E51D90282ABE0576BF6E3CB78A71906E7612778AF18C7D271D0E910229930B0809B87626F39EF27039BD4C8");
  level._effect["_encstr_BABE10CAB51CFA0E5693DCBD37FAE6E8EA73"] = loadfx("_encstr_955E3D53F90B8664F8390F3A85122C4FB9B14AFA286C775D30D124018BEA3353DBEE026303283F9570A7271A5BC8BE838D869B9AB396DF0D31CF570479A803");
  level._effect["_encstr_B292129A58A30BBB820DDB338FCABB2B19B7D0B7"] = loadfx("_encstr_8843337DF690F2335F0F908643CFF7E86F5BF1EFD7BD502873F2728E3AA720D042A9673F0562B043137A299073776D709A76C535B0");
  level._effect["_encstr_AB751081D3031ACA6D2F289D47B2A85F125F"] = loadfx("_encstr_A11831EC333C7936DB27ACE5AD075E6DB4C6B1CD1DE495B05BB9799DCCE1D79BD9F5C816D60BCECAF54CD8166CB56EADEDDACA");
  level._effect["_encstr_861E11938B2350E0A0598A7D97C053EF155417"] = loadfx("_encstr_A312318B744AE6F280DBC550E86B36E0AB02990BB50B47AF0A588A4D7FE87010F0720402D9B13C982899351B52930A563A6F62");
  level._effect["_encstr_AA7608ECD89B6BDE5B59"] = loadfx("_encstr_88EA35CECCE15EB4771CF5B6C197CAE2EAA5C15BB2371DF29B6BEDB5B2D7D939AC730B3295F2EC99F0EB9B6BB7ADACAFCEC995CDEB6C43");
  level._effect["_encstr_B26817A0E1F0F7D97670535399811BD160E03116F718731658"] = loadfx("_encstr_B21932ECCC1EE5B4DD83F55B83CB56C55DB4075BCADCE8BC67331ED7C3AD2DDA5662C0E4FAA3A12B4EB5B4E82BEB98B7BA73B12B");
  level._effect["_encstr_BEBE096AFE19D051EA374D"] = loadfx("_encstr_A5483554169390ABA307F228CAFE5158B7B151CF6997A31F81BA205846C02D28F36F644CD8BFC8D332A110A34B215101DFDC783151DFD1");
  level._effect["_encstr_A3E00AB182E4189D0F8BCB70"] = loadfx("_encstr_A2E336DB102172580F8F1D8BF769D72D29575DB09E708B98F18B4B02BE87DBCF93A7ED6D3A2FA2F0B84FA123E8698293F9DD19DCF7126FBF");
  level._effect["_encstr_9B9C097A1D23D3D8A0A967"] = loadfx("_encstr_AC6735D87A53376CCFD1051B4D67A31540CC18CB21D1B108CF5A99B05F41D5ECCBBF3040D1A70B5073383D1B98FF41E16B1326A0E9C978");
  level._effect["_encstr_A5280ADB4D3B0D66E1CCC2A2"] = loadfx("_encstr_88012E93C1C8279244894E372B67CBEF4988CD9A597824CE88CB2B039796820122F387E03698F143F9E3B7A769338A52");
  level._effect["_encstr_9B430B637F0354A9A3E20EB3D8"] = loadfx("_encstr_910A2F1D96F092533F5F3023923F97DA41E1A389399E9088772253CA5E5BC790F556CD119F8730EE875A4856D3D706883D");
  level._effect["_encstr_87450A6B3277C809D4CF127A"] = loadfx("_encstr_ADE32E1BB23358801BF8E75FCDC6101007FAF0432AA72D7A39B52959BFEA50839E6329CA5113EBA04D95131F101728C5");
  level._effect["_encstr_A64E0FFB592DB01BAF375BFE5AE3CF8805"] = loadfx("_encstr_8EEE332DA6A0C2036F2F4E309336CDF83B31A9E34D8DA07803A2A27E6AE771A81491B3D5CF72D890AB8AD903F28BBD19EFF0B9F197");
  scripts\mp\utility\entity::placeequipmentfailedinit();
  level.weaponconfigs = [];

  if(!isDefined(level.weapondropfunction))
    level.weapondropfunction = ::dropweaponfordeath;

  var_0 = 25;
  level.sticky_minedetectiondot = cos(var_0);
  level.sticky_minedetectionmindist = 15;
  level.sticky_minedetectiongraceperiod = 0.35;
  level.sticky_minedetonateradius = 256;
  level.minedetectiongraceperiod = 0.3;
  level.primary_weapon_array = [];
  level.side_arm_array = [];
  level.grenade_array = [];
  level.missile_array = [];
  level.inventory_array = [];
  level.mines = [];
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  level thread onplayerconnect();
  scripts\mp\utility\outline::initoutlineoccluders();
  init_function_refs();
  level._id_120AD = _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlyfire_allowed();
  level._id_120AE = _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlyfire_allowed();

  if(getdvarint("_encstr_A670195F3F43B7B63F9B40F0AF42C8DD2AA7D670975A6BD9ECFF70") == 1)
    level thread savegraverobberammo();

  level._encstr_99DB1773C7089B9F38F94A03230197D578A30AE943D0E36BDD = getdvarint("_encstr_82451EB2BE0597E88A96AA2F813E1B256FA8589F8DE7E8385B56A5878730386C", 5);
}

savegraverobberammo() {
  for(;;) {
    if(isDefined(level.players)) {
      foreach(var_1 in level.players) {
        if(!isDefined(var_1)) {
          continue;
        }
        if(var_1 scripts\mp\utility\perk::_hasperk("_encstr_9B7318FFD19D1A4128900B50EE6093C36729C7775337730F385B")) {
          var_2 = var_1 getcurrentweapon();
          var_1 getcurrentweapon();

          if(!isDefined(var_2)) {
            continue;
          }
          if(!isDefined(var_1.graverobberammo)) {
            var_1.graverobberammo = spawnStruct();
            var_1.graverobberammo = spawnStruct();
            var_1.graverobberammo = spawnStruct();
          }

          if(isDefined(var_1.graverobberammo.currentweapon) && var_1.graverobberammo.currentweapon.weapon.basename != "_encstr_8BBA05185F8B99" && var_1.graverobberammo.currentweapon.weapon != var_2) {
            var_1.graverobberammo.lastweapon = var_1.graverobberammo.currentweapon;
            var_1.graverobberammo.currentweapon = spawnStruct();
          }

          var_1.graverobberammo.currentweapon = spawnStruct();
          var_1.graverobberammo.currentweapon.weapon = var_2;
          var_1.graverobberammo.currentweapon.rightclip = var_1 getweaponammoclip(var_2, "_encstr_8253060E2B5FE330");
          var_1.graverobberammo.currentweapon.leftclip = var_1 getweaponammoclip(var_2, "_encstr_A5AD056A019C63");
          var_1.graverobberammo.currentweapon.stock = var_1 getweaponammostock(var_2);
          continue;
        }

        var_1.graverobberammo = undefined;
      }
    }

    waitframe();
  }
}

enablevisibilitycullingforclient(var_0) {
  self hudoutlinedisableforclient(var_0);
}

onplayerconnect() {
  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0.hits = 0;
    scripts\mp\gamelogic::sethasdonecombat(var_0, 0);
    var_0 thread watchmissileusage();
  }
}

watchchangeweapon() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(isDefined(var_0))
      dochangeweapon(var_0);

    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  }
}

dochangeweapon(var_0) {
  if(istrue(self.get_alive_players))
    _id_119AD(var_0);

  self.get_alive_players = 1;
  updatecamoscripts(var_0, self.lastweaponobj);
  updateweaponspeed(var_0);
  updatelastweaponobj(var_0);
  updatelauncherusage();
  updatesniperglint(var_0);
  updateweaponperks();
  _id_13FD2(var_0);
  _id_13FFC(var_0);
  _id_12F87(var_0);
  scripts\mp\perks\perkfunctions::updatedefaultflinchreduction();
  scripts\mp\events::updateweaponchangetime();
  scripts\mp\class::riotshieldonweaponchange(var_0);
  scripts\mp\perks\perkfunctions::updateweaponkick();
  thread scripts\cp_mp\gestures::_id_13E1A();
}

_id_12F87(var_0) {
  if(istrue(level.loadout_updateammo)) {
    return;
  }
  if(_id_132F2(var_0)) {
    scripts\common\utility::allow_mount_top(0, "_encstr_9AC7158F6126F16B43F889EC57239ED59D404E1E3EE9BF");
    scripts\common\utility::allow_mount_side(0, "_encstr_9AC7158F6126F16B43F889EC57239ED59D404E1E3EE9BF");
    thread _id_12F88();
  }
}

_id_12F88() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  scripts\common\utility::allow_mount_top(1, "_encstr_9AC7158F6126F16B43F889EC57239ED59D404E1E3EE9BF");
  scripts\common\utility::allow_mount_side(1, "_encstr_9AC7158F6126F16B43F889EC57239ED59D404E1E3EE9BF");
}

_id_13FFC(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_2 = undefined;

  if(var_1 == "_encstr_87610AB4EE83FAD6374B3395") {
    if(var_0.basename == "_encstr_BDAA163B530F37E8EEDF40401F354391223BA633AFA33D3B")
      var_2 = "_encstr_BE220F4E0117A86F4537EB990C53AB97AD";
    else if(var_0.basename == "_encstr_9A4A0E29843A47ECED60424AE9D3E27B" && var_0.attachmentvarindices["_encstr_8E9B0A852311344B4331522A"] == 9)
      var_2 = "_encstr_A3BD0DE135515883DADFDF8DFF02DD";
    else if(var_0.basename == "_encstr_954A0E96BB07D7DA9BB49995BEB58346" && var_0.attachmentvarindices["_encstr_AC9B0A255F9168B860F6E841"] == 1)
      var_2 = "_encstr_8FC80EB2B1CA3647E4D2365ACD4B99CA";
  }

  if(isDefined(var_2))
    thread _id_11DF9(var_2);

  return 1;
}

_id_11DF9(var_0) {
  self endon("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_9A671245E58B033126F97C819F4BD183A7BFBD1B");
  self endon("_encstr_9A671245E58B033126F97C819F4BD183A7BFBD1B");
  var_1 = "_encstr_815D087F3F5A0EE8A419" + var_0;
  thread _id_11DF7(var_1);
  childthread _id_11DFB(var_0, var_1);
  childthread _id_11DFE(var_0, var_1);
  childthread _id_11DFD(var_0, var_1);
}

_id_11DFE(var_0, var_1) {
  for(;;) {
    self waittill("_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC");

    if(self isthrowinggrenade()) {
      _id_11DFA(var_1);
      self waittill("_encstr_9A630C851C886BC33D8221E3EEB1");
      childthread _id_11DFB(var_0, var_1);
      continue;
    }

    if(self isonladder())
      _id_11DF8(var_0, var_1);
  }
}

_id_11DFD(var_0, var_1) {
  for(;;) {
    self waittill("_encstr_9A6A0B85E1A871F08169EDED79");

    if(self isonladder())
      _id_11DF8(var_0, var_1);
  }
}

_id_11DF8(var_0, var_1) {
  _id_11DFA(var_1);

  while(self isonladder())
    waitframe();

  childthread _id_11DFC(var_0, var_1);
}

_id_11DFB(var_0, var_1) {
  self notify(var_1);
  self endon(var_1);
  self._id_12745 = 1;
  self setscriptablepartstate("_encstr_B87B13777AA15F2A6AB44EC0DFE33A2FE7577F5A60", var_0);
  self setscriptablepartstate("_encstr_8BCB142FF5C8CA2F7DF46C51116F18A10B3DF7591758", "_encstr_A7A408B9CA5D1D4E2C63");
  var_2 = 0.4;
  wait(var_2);
  self setscriptablepartstate("_encstr_8BCB142FF5C8CA2F7DF46C51116F18A10B3DF7591758", var_0, 0);
}

_id_11DFC(var_0, var_1) {
  self notify(var_1);
  self endon(var_1);
  self._id_12745 = 1;
  self setscriptablepartstate("_encstr_B87B13777AA15F2A6AB44EC0DFE33A2FE7577F5A60", "_encstr_A7A408B9CA5D1D4E2C63");
  self setscriptablepartstate("_encstr_8BCB142FF5C8CA2F7DF46C51116F18A10B3DF7591758", "_encstr_A7A408B9CA5D1D4E2C63");
  var_2 = 0.4;
  wait(var_2);
  self setscriptablepartstate("_encstr_B87B13777AA15F2A6AB44EC0DFE33A2FE7577F5A60", var_0, 0);
  self setscriptablepartstate("_encstr_8BCB142FF5C8CA2F7DF46C51116F18A10B3DF7591758", var_0, 0);
}

_id_11DFA(var_0) {
  self notify(var_0);

  if(istrue(self._id_12745)) {
    self setscriptablepartstate("_encstr_B87B13777AA15F2A6AB44EC0DFE33A2FE7577F5A60", "_encstr_A7A408B9CA5D1D4E2C63");
    self setscriptablepartstate("_encstr_8BCB142FF5C8CA2F7DF46C51116F18A10B3DF7591758", "_encstr_A7A408B9CA5D1D4E2C63");
  }

  self._id_12745 = undefined;
}

_id_11DF7(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9A671245E58B033126F97C819F4BD183A7BFBD1B");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  _id_11DFA(var_0);
}

_id_132F2(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(var_1 == "_encstr_9B750F97DF33D94448F6CA54A96882F2EB" && var_0 hasattachment("_encstr_8BB111E63ADB1BD6E685DDEBE6A595279316C3"))
    return 1;

  return 0;
}

_id_119AD(var_0) {
  var_1 = var_0.basename;
  var_2 = "_encstr_8BBA05185F8B99";

  if(!isDefined(var_1) || var_1 == "_encstr_8BBA05185F8B99") {
    return;
  }
  if(isDefined(self.lastweaponobj) && var_0 == self.lastweaponobj) {
    return;
  }
  if(self.equippedweapons.size > 1) {
    var_2 = self.equippedweapons[1].basename;

    if(var_2 == var_1)
      var_2 = self.equippedweapons[0].basename;
  }

  if(isDefined(self.equippedweapons[0]))
    self setclientweaponinfo(0, createheadicon(self.equippedweapons[0]));

  if(isDefined(self.equippedweapons[1]))
    self setclientweaponinfo(1, createheadicon(self.equippedweapons[1]));

  self dlog_recordplayerevent("_encstr_AD5019D815DFF7597BA8D8EB807FB490A1CAAA2D871F437ADAA4D3", ["_encstr_B8D50F78CB6EEE073D99D7C4A5BF98879B", var_1, "_encstr_8C5D11B9CAC6B79B8C589C97AFBB2BB0C1B7CD", var_2]);
}

updateweaponperks() {
  self.prevweaponobj = doweaponperkupdate(self.prevweaponobj);
}

updatesniperglint(var_0) {
  if(sniperglint_supported(var_0))
    childthread sniperglint_manage();
}

_id_13FD2(var_0) {
  self notify("_encstr_95350FCADC197D19932CEC1239CAB03A0D");

  if(scripts\mp\utility\weapon::getweapongroup(var_0) == "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9" || var_0.basename == "_encstr_97F517F8C3B807B36797F54B904F9BE9D5DAB078BA43CF285B" || var_0 hasattachment("_encstr_ADE110F9026778319CAE7F7BC687D837B3FB", 1)) {
    if(scripts\cp_mp\killstreaks\nuke::unlockables(var_0))
      thread scripts\cp_mp\killstreaks\nuke::terminal_pusher_approach_array(var_0);
  }
}

updatelauncherusage() {
  var_0 = self getcurrentweapon();
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  switch (var_1) {
    default:
      break;
    case "_encstr_9A451268532897A0B76705DB238B49AD679A0888":
    case "_encstr_A5090EB4DD83D78D16BE3B4EED5BACB7":
      thread scripts\mp\missilelauncher::initmissilelauncherusage();
      break;
    case "_encstr_97EF0EA5BB70FA1BB0AFD4D56396593A":
      thread scripts\mp\javelin::javelin_reset();
      break;
    case "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD":
    case "_encstr_A34C12B0EB7A380815D7690B13FA20F68F12C8FB":
      thread scripts\cp\vehicles\vehicle_damage_cp::teleport_text_updated();
      break;
    case "_encstr_B453108C3B128FFBF07F5B077B2AC2B9FA4A":
      thread scripts\cp_mp\utility\omnvar_utility::tr_vis_facing_dist_add_override();
      break;
    case "_encstr_A6AE10032092892E28FFF91A34B95007CB0A":
      thread scripts\cp\utility\cp_safehouse_util::tr_vis_facing_dist_add_override();
      break;
    case "_encstr_924318F35710E1A187F98BDAD26FE9B09CCB414BEBAC10FBA372":
      thread scripts\cp\vehicles\cargo_truck_mg_cp::tr_vis_facing_dist_add_override();
      break;
  }

  self notify("_encstr_B1C80D5D9E631E21A65378089A7FD5");

  if(scripts\mp\utility\perk::_hasperk("_encstr_A9F31F6EC1AC6C2D0BD8E8E57DCC2CE6E8C9B236F616C8D73685D5378D345693B9")) {
    var_2 = weaponclass(var_0.basename) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" || var_0.basename == "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA";

    if(var_2 && !istrue(self.fastreloadlaunchers)) {
      scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
      self.fastreloadlaunchers = 1;
    } else if(!var_2 && istrue(self.fastreloadlaunchers)) {
      scripts\mp\utility\perk::removeperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
      self.fastreloadlaunchers = undefined;
    }
  }

  switch (var_1) {
    default:
      break;
    case "_encstr_9A451268532897A0B76705DB238B49AD679A0888":
    case "_encstr_A5090EB4DD83D78D16BE3B4EED5BACB7":
      thread scripts\mp\missilelauncher::missilelauncherusageloop();
      break;
    case "_encstr_97EF0EA5BB70FA1BB0AFD4D56396593A":
      thread scripts\mp\javelin::javelinusageloop();
      break;
    case "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD":
    case "_encstr_A34C12B0EB7A380815D7690B13FA20F68F12C8FB":
      thread scripts\cp\vehicles\vehicle_damage_cp::initarmor(var_0);
      break;
    case "_encstr_B453108C3B128FFBF07F5B077B2AC2B9FA4A":
      thread scripts\cp_mp\utility\omnvar_utility::_id_1403E(var_0);
      break;
    case "_encstr_A6AE10032092892E28FFF91A34B95007CB0A":
      thread scripts\cp\utility\cp_safehouse_util::_id_1403E(var_0);
      break;
    case "_encstr_924318F35710E1A187F98BDAD26FE9B09CCB414BEBAC10FBA372":
      thread scripts\cp\vehicles\cargo_truck_mg_cp::_id_1403E(var_0);
      break;
  }
}

_id_1316B(var_0) {
  self.lastdroppableweaponobj = var_0;

  if(isDefined(level.waittillmatch_wait))
    self[[level.waittillmatch_wait]]();
}

updatelastweaponobj(var_0) {
  var_1 = var_0 getnoaltweapon();

  if(nullweapon(var_1))
    var_1 = var_0;

  self.lastweaponobj = var_0;

  if(isnormallastweapon(var_0))
    self.lastnormalweaponobj = var_0;

  if(isdroppableweapon(var_1))
    _id_1316B(var_1);

  if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var_0))
    self.lastcacweaponobj = var_0;
}

updateweaponspeed(var_0) {
  if(var_0.basename == "_encstr_8BBA05185F8B99")
    return;
  else if(scripts\mp\utility\weapon::issuperweapon(var_0.basename)) {
    updatemovespeedscale();
    return;
  } else if(scripts\mp\utility\weapon::iskillstreakweapon(var_0.basename))
    return;
  else if(var_0.basename == "_encstr_A393109FCF38E936DA97CCE3177050314CB8") {
    updatemovespeedscale();
    return;
  } else if(var_0.inventorytype != "_encstr_BA7F0830B3A7859B60B0" && var_0.inventorytype != "_encstr_B4DC085639F9C2779108") {
    return;
  }
  updatemovespeedscale();
}

onplayerspawned() {
  self.hits = 0;
  scripts\mp\gamelogic::sethasdonecombat(self, 0);

  if(!isDefined(self.trackingweapon)) {
    self.trackingweapon = isundefinedweapon();
    self.trackingweaponshots = 0;
    self.trackingweaponkills = 0;
    self.trackingweaponhits = 0;
    self.trackingweaponheadshots = 0;
    self.trackingweapondeaths = 0;
  }

  if(!isDefined(self.plantedlethalequip))
    self.plantedlethalequip = [];

  if(!isDefined(self.plantedtacticalequip))
    self.plantedtacticalequip = [];

  if(!isDefined(self.plantedsuperequip))
    self.plantedsuperequip = [];

  if(!isDefined(self.plantedhackedequip))
    self.plantedhackedequip = [];

  self.prevweaponobj = undefined;
  thread watchchangeweapon();
  thread watchweaponusage();
  thread watchgrenadeusage();
  thread watchequipmentonspawn();

  if(scripts\mp\utility\game::onlinestatsenabled())
    thread _id_144C3();

  if(!scripts\mp\utility\game::runleanthreadmode())
    thread watchdropweapons();

  self.lasthittime = [];
  self.droppeddeathweapon = undefined;
  self.tookweaponfrom = [];
  self.lastnormalweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastcacweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj) && scripts\mp\utility\weapon::iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  _id_1316B(scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon()));
  scripts\mp\gamescore::initassisttrackers();
}

savealtstates() {
  self.pers["_encstr_8E7E0AF383739E98215BE13B"] = [];
  var_0 = self.primaryinventory;

  foreach(var_2 in var_0) {
    if(!getqueuedspleveltransients(self.primaryweaponobj) && var_2 == self.primaryweaponobj || !getqueuedspleveltransients(self.secondaryweaponobj) && var_2 == self.secondaryweaponobj) {
      if(shouldweaponsavealtstate(var_2) && self isalternatemode(var_2, 1)) {
        var_3 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_2);
        self.pers["_encstr_8E7E0AF383739E98215BE13B"][var_3] = 1;
      }
    }
  }
}

savetogglescopestates() {
  self.pers["_encstr_B2CA12D3509F9788FA4F53CF43055F2D11E38507"] = [];
  var_0 = self.primaryinventory;

  foreach(var_2 in var_0) {
    if(!getqueuedspleveltransients(self.primaryweaponobj) && var_2 == self.primaryweaponobj || !getqueuedspleveltransients(self.secondaryweaponobj) && var_2 == self.secondaryweaponobj) {
      if(isDefined(var_2.scope) && istogglescope(var_2.scope) && !_id_138B1(var_2.backpiece)) {
        var_3 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_2);
        self.pers["_encstr_B2CA12D3509F9788FA4F53CF43055F2D11E38507"][var_3] = self gethybridscopestate(var_2);
      }
    }
  }
}

updatetogglescopestate(var_0) {
  var_1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_0);

  if(isDefined(self.pers["_encstr_B2CA12D3509F9788FA4F53CF43055F2D11E38507"]) && isDefined(self.pers["_encstr_B2CA12D3509F9788FA4F53CF43055F2D11E38507"][var_1]))
    self sethybridscopestate(var_0, self.pers["_encstr_B2CA12D3509F9788FA4F53CF43055F2D11E38507"][var_1]);
}

updatesavedaltstate(var_0) {
  if(isDefined(self.pers["_encstr_8E7E0AF383739E98215BE13B"]) && istrue(var_0.hasalternate)) {
    var_1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_0);

    if(isDefined(self.pers["_encstr_8E7E0AF383739E98215BE13B"][var_1]) && self.pers["_encstr_8E7E0AF383739E98215BE13B"][var_1])
      var_0 = var_0 getaltweapon();
  }

  return var_0;
}

istogglescope(var_0) {
  var_1 = scripts\mp\utility\weapon::attachmentmap_tobase(var_0);

  switch (var_1) {
    case "_encstr_AA0B0D0DBC139CD232998D9676A1D1":
    case "_encstr_A9D40DD337A98A4B1FAA7DF3C12AED":
    case "_encstr_8F120C497FBAA6E8CCB59851DCA4":
    case "_encstr_B603088BE09A5D98D47A":
    case "_encstr_8C0308D0CBC439A5C899":
    case "_encstr_A90308B187425E2014FA":
    case "_encstr_931A070469021BF0D9":
      return 1;
    default:
      return 0;
  }
}

_id_138B1(var_0) {
  return isDefined(var_0) && var_0 == "_encstr_8BB111E63ADB1BD6E685DDEBE6A595279316C3";
}

shouldweaponsavealtstate(var_0) {
  if(istrue(var_0.hasalternate)) {
    if(shouldattachmentsavealtstate(var_0.underbarrel))
      return 1;
  }

  return 0;
}

shouldattachmentsavealtstate(var_0) {
  return turretoverridefunc(var_0);
}

turretoverridefunc(var_0) {
  var_1 = scripts\mp\utility\weapon::attachmentmap_tobase(var_0);

  switch (var_1) {
    case "_encstr_82910B7A09C0C5AAAD535F53A7":
    case "_encstr_926D0C3EDF424B110CFBC0F09724":
    case "_encstr_88270B9BE59120260B9BFD6343":
      return 1;
    default:
      return 0;
  }
}

turretobjweapon(var_0) {
  var_1 = scripts\mp\utility\weapon::attachmentmap_tobase(var_0);

  switch (var_1) {
    case "_encstr_8435070CAC0F080BD2":
    case "_encstr_A78B09ECB16E2B5B47590F":
    case "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5":
    case "_encstr_873708FFA8104C0AAEC1":
    case "_encstr_ADBD0780C4884FEE86":
    case "_encstr_97D506F770BFFFBB":
    case "_encstr_AA7608ECD89B6BDE5B59":
    case "_encstr_8A07035972":
      return 1;
    default:
      return 0;
  }
}

weaponperkupdate(var_0, var_1) {
  if(!getqueuedspleveltransients(var_1)) {
    var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);
    var_3 = scripts\mp\utility\weapon::weaponperkmap(var_2);

    if(isDefined(var_3))
      scripts\mp\class::loadout_removeperk(var_3);
  }

  if(!getqueuedspleveltransients(var_0)) {
    var_4 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);
    var_5 = scripts\mp\utility\weapon::weaponperkmap(var_4);

    if(isDefined(var_5))
      scripts\mp\class::loadout_giveperk(var_5);
  }
}

weaponattachmentperkupdate(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(!getqueuedspleveltransients(var_1)) {
    var_3 = getweaponattachments(var_1);

    if(isDefined(var_3) && var_3.size > 0) {
      foreach(var_5 in var_3) {
        var_6 = scripts\mp\utility\weapon::attachmentperkmap(var_5);

        if(!isDefined(var_6)) {
          continue;
        }
        if(!scripts\mp\utility\perk::_hasperk(var_6)) {
          continue;
        }
        scripts\mp\class::loadout_removeperk(var_6);
      }
    }
  }

  if(!getqueuedspleveltransients(var_0)) {
    var_2 = getweaponattachments(var_0);

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_9 in var_2) {
        var_6 = scripts\mp\utility\weapon::attachmentperkmap(var_9);

        if(!isDefined(var_6)) {
          continue;
        }
        scripts\mp\class::loadout_giveperk(var_6);
      }
    }
  }
}

doweaponperkupdate(var_0) {
  var_1 = self getcurrentweapon();
  weaponattachmentperkupdate(var_1, var_0);
  weaponperkupdate(var_1, var_0);
  return var_1;
}

watchweaponperkupdates() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
  var_0 = undefined;

  for(;;) {
    var_0 = doweaponperkupdate(var_0);
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  }
}

watchsniperuse() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(sniperglint_supported(var_0))
      childthread sniperglint_manage();

    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  }
}

sniperadsblur_supported(var_0) {
  return scripts\mp\utility\weapon::weaponhasattachment(var_0, "_encstr_B8FB06FF97EA2708") && !issubstr(var_0.basename, "_encstr_93A3086EB8B0583ABD41") && !issubstr(var_0.basename, "_encstr_8C940729C42A53B3A4");
}

sniperglint_supported(var_0) {
  if(nullweapon(var_0) || !isDefined(var_0.scope) || weaponclass(var_0) == "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" || weaponclass(var_0) == "_encstr_BE1904DCDA9D")
    return 0;

  if(var_0.basename == "_encstr_AD29118BAF609F623F8F7241B3EF21A766AA5A" || var_0.basename == "_encstr_A54A10D6440FD89DA95202A86ABD7D567FA8" || var_0.basename == "_encstr_95C5134B2DDE87B297B87B8210E92D235BD79FDDA7" || var_0.basename == "_encstr_AF9E1447DD1F2BF35FDAF759ABD81EA309DE8319784B")
    return 0;

  var_1 = scripts\mp\utility\weapon::attachmentmap_tobase(var_0.scope);

  switch (var_1) {
    case "_encstr_B8FB06FF97EA2708":
      if(var_0.basename == "_encstr_B2DB14DA273967BF858FBB904573D3A388D0C091DD82")
        return 0;
      else if(var_0.classname == "_encstr_850707F7E5833355B8" && issubstr(var_0.basename, "_encstr_BD0703AF7C"))
        return 1;
    case "_encstr_AB770B43F7378B8F6C1FAC936C":
      if(var_0.classname == "_encstr_850707F7E5833355B8")
        return 1;
      else
        return 0;
    case "_encstr_AFA00C47762F11823DFA7E4388F8":
      if(var_0.classname == "_encstr_850707F7E5833355B8" && issubstr(var_0.basename, "_encstr_BD0703AF7C"))
        return 1;
      else
        return 0;
    case "_encstr_936B09B9B17B38B29B9D9D":
      if(var_0.classname == "_encstr_850707F7E5833355B8")
        return 1;
      else
        return 0;
    case "_encstr_A68409E3CA3E0755105392":
      if(var_0.classname != "_encstr_850707F7E5833355B8" && issubstr(var_0.basename, "_encstr_BD0703AF7C"))
        return 0;
    case "_encstr_A1B50AB34B01F3D8501868A5":
    case "_encstr_B68409CEE99B8DEDC1CACC":
      return 1;
    case "_encstr_A3CA081B50EDAB3D60A9":
      var_2 = scripts\mp\utility\weapon::getweapongroup(var_0);

      if(var_2 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33")
        return 1;
      else
        return 0;
    case "_encstr_A23906472E023F8B":
      if(var_0.classname == "_encstr_850707F7E5833355B8" && issubstr(var_0.basename, "_encstr_AF0703BB78"))
        return 1;
      else
        return 0;
    case "_encstr_8A39067FE0106747":
      if(issubstr(var_0.basename, "_encstr_AF0703BB78"))
        return 1;
      else
        return 0;
    case "_encstr_8BEB08833B38890A08A7":
      if(var_0.classname == "_encstr_850707F7E5833355B8" && (issubstr(var_0.basename, "_encstr_BD0703AF7C") || issubstr(var_0.basename, "_encstr_AF0703BB78")))
        return 1;
      else if(!issubstr(var_0.basename, "_encstr_BD0703AF7C") && !issubstr(var_0.basename, "_encstr_AF0703BB78"))
        return 1;
  }

  return 0;
}

sniperglint_manage() {
  self notify("_encstr_8439128DF9A0B1BA75670317492DB3CF1840C553");
  self endon("_encstr_8439128DF9A0B1BA75670317492DB3CF1840C553");
  self endon("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  waitframe();
  thread sniperglint_cleanup();
  self.glinton = 0;

  if(self.currentweapon hasattachment("_encstr_8D171180EB25216903BB7866803B10E30F7210"))
    var_0 = getdvarfloat("_encstr_BA6A200328D5F9B78B2868753E908F3A09584AFBB8436F1F02804F6540582F034B63", 0.85);
  else
    var_0 = 0.5;

  for(;;) {
    if(self playerads() > var_0) {
      if(!self.glinton)
        sniperglint_add();
    } else if(self.glinton)
      sniperglint_remove();

    waitframe();
  }
}

sniperglint_cleanup() {
  scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");

  if(isDefined(self.glinton) && self.glinton) {
    sniperglint_remove();
    self.glinton = undefined;
  }
}

sniperglint_add() {
  if(scripts\mp\utility\perk::_hasperk("_encstr_A29D16378356D85A16C63A97D7D9B14BB93A935923AB6C56"))
    self setscriptablepartstate("_encstr_81560C92FE032B135248ED6083E4", "_encstr_AA82154B7B3099BF8371E14FA0BB80D568703F7ED39727", 0);
  else
    self setscriptablepartstate("_encstr_81560C92FE032B135248ED6083E4", "_encstr_A3090EC77B28DF5FB82829E3762BB0A2", 0);

  self.glinton = 1;
}

sniperglint_remove() {
  if(isDefined(self)) {
    self setscriptablepartstate("_encstr_81560C92FE032B135248ED6083E4", "_encstr_865C0F3B78DB1A97B3549C81E85BF7277D", 0);
    self.glinton = 0;
  }
}

sniperadsblur(var_0) {
  self endon("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  self.sniperblur = 0;

  for(;;) {
    if(self playerads() > 0.65 && !self.sniperblur)
      thread sniperadsblur_execute(var_0);
    else if(self playerads() <= 0.65)
      sniperadsblur_remove();

    waitframe();
  }
}

sniperadsblur_execute(var_0) {
  self notify("_encstr_A72B10B9B9960EB2274836AB9C49596ECAD1");
  self endon("_encstr_A72B10B9B9960EB2274836AB9C49596ECAD1");
  self.sniperblur = 1;
  self setblurforplayer(25, 0.1);
  wait 0.1;
  self setblurforplayer(0, getsniperadsblurtime(var_0));
}

sniperadsblur_remove() {
  self notify("_encstr_A72B10B9B9960EB2274836AB9C49596ECAD1");
  self setblurforplayer(0, 0);
  self.sniperblur = 0;
}

getsniperadsblurtime(var_0) {
  var_1 = 0.3;

  switch (var_0.basename) {
    case "_encstr_8D06112DDDE0EB6EE6BEB5B463BD271CFAD61C":
      var_1 = 0.18;
      break;
    case "_encstr_B8F911CBC79FB0B846F998109C35D27D813771":
      var_1 = 0.12;
      break;
    case "_encstr_9BFF104F9FA8014F8D176A50489B49D7DA70":
      var_1 = 0.12;
      break;
  }

  return var_1;
}

watchsniperboltactionkills() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread watchsniperboltactionkills_ondeath();

  if(!isDefined(self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"]))
    self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"] = 0;

  self setclientomnvar("_encstr_9B4B1A1F0730F7B9D81D246145934724E317085093D8E7C20B1ED393", self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"]);

  for(;;) {
    self waittill("_encstr_8F220B3FC7D11160D8F85169E9", var_0, var_1, var_2);
    var_3 = asmdevgetallstates(var_1);

    if(isrecoilreducingweapon(var_3)) {
      var_4 = self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"] + 1;
      self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"] = int(min(var_4, 4));
      self setclientomnvar("_encstr_9B4B1A1F0730F7B9D81D246145934724E317085093D8E7C20B1ED393", self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"]);

      if(var_4 <= 4)
        stancerecoilupdate(self getstance());
    }
  }
}

watchsniperboltactionkills_ondeath() {
  self notify("_encstr_A566239FFF7DB918FEB8F0402F4A719809245E767B32BAC544CAA561BB19CF1B4D7FB2CCC3");
  self endon("_encstr_A566239FFF7DB918FEB8F0402F4A719809245E767B32BAC544CAA561BB19CF1B4D7FB2CCC3");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_AD75063D571AE108");
  self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"] = 0;
}

isrecoilreducingweapon(var_0) {
  if(!isDefined(var_0) || nullweapon(var_0))
    return 0;

  var_1 = 0;

  if(var_0 hasattachment("_encstr_97270C8C836AAB6F769BCAF203A5", 1) || var_0 hasattachment("_encstr_B6490EA27259E2B2162D4BFEB6077AB7", 1) || var_0 hasattachment("_encstr_824109039B631EB845E85B", 1) || var_0 hasattachment("_encstr_AF680B956693034837D032BB98", 1))
    var_1 = 1;

  return var_1;
}

getrecoilreductionvalue() {
  if(!isDefined(self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"]))
    self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"] = 0;

  return self.pers["_encstr_8D8E12F0776997BCCA3AB728F3E7415332FD313E"] * 3;
}

ishackweapon(var_0) {
  if(var_0 == "_encstr_A70809FD790F183677D2F3" || var_0 == "_encstr_A1180DC24B399B479C966DACEBD6E0" || var_0 == "_encstr_925E0EB218E974A7C8276C753E1647FA")
    return 1;

  if(var_0 == "_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B")
    return 1;

  return 0;
}

isfistweapon(var_0) {
  var_0 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  return var_0 == "_encstr_A7ED0AD79F73990E28334B92";
}

isbombplantweapon(var_0) {
  return var_0 == "_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B" || var_0 == "_encstr_B108190EAE4BCAC6C9A07F2F3981B732355017471CAB630D96F86B" || var_0 == "_encstr_84F4147148CADD4A7148A60D26477822F5230B0FD752" || var_0 == "_encstr_A5C31BC1EE4C2259A23B9B23D10FF16D3DF6B9C1F3012D1F528519A53B";
}

dropweaponfordeath(var_0, var_1, var_2, var_3) {
  if(isDefined(level.blockweapondrops)) {
    return;
  }
  if(isDefined(self.droppeddeathweapon)) {
    return;
  }
  if(isDefined(var_0) && var_0 == self || var_1 == "_encstr_AB590C99ED78875F650F3951034D") {
    return;
  }
  var_4 = self.lastdroppableweaponobj;

  if(isDefined(var_2))
    var_4 = var_2;

  if(!isDefined(var_4)) {
    return;
  }
  if(var_4.basename == "_encstr_8BBA05185F8B99") {
    return;
  }
  if(!self hasweapon(var_4)) {
    return;
  }
  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var_4)) {
    return;
  }
  var_4 = var_4 getnoaltweapon();
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;

  if(!scripts\mp\riotshield::isriotshield(var_4.basename)) {
    if(!self anyammoforweaponmodes(var_4)) {
      return;
    }
    var_5 = self getweaponammoclip(var_4, "_encstr_8253060E2B5FE330");
    var_6 = self getweaponammoclip(var_4, "_encstr_A5AD056A019C63");

    if(!var_5 && !var_6) {
      return;
    }
    var_7 = self getweaponammostock(var_4);
    var_8 = weaponmaxammo(var_4);

    if(var_7 > var_8)
      var_7 = var_8;

    var_9 = self dropitem(var_4);

    if(!isDefined(var_9)) {
      return;
    }
    if(istrue(level.clearstockondrop))
      var_7 = 0;

    var_9 itemweaponsetammo(var_5, var_7, var_6);
    var_10 = scripts\mp\utility\weapon::getweapongroup(var_4);

    if(var_1 != "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
      thread scripts\cp_mp\utility\weapon_utility::dropweaponfordeathlaunch(var_9, var_10, var_3, self.angles);
  } else {
    var_9 = self dropitem(var_4);

    if(!isDefined(var_9)) {
      return;
    }
    var_9 itemweaponsetammo(1, 1, 0);
  }

  var_9 sethintdisplayrange(96);
  var_9 setuserange(96);
  self.droppeddeathweapon = 1;
  var_9.owner = self;
  var_9.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
  var_9.objweapon = var_4;
  var_9 thread watchpickup(self);
  var_9 thread deletepickupafterawhile();
}

forcedropweapon(var_0) {
  if(isDefined(level.blockweapondrops))
    return 0;

  if(isDefined(self.droppeddeathweapon))
    return 0;

  var_1 = self.lastdroppableweaponobj;

  if(isDefined(var_0))
    var_1 = var_0;

  if(!isDefined(var_1))
    return 0;

  if(var_1.basename == "_encstr_8BBA05185F8B99")
    return 0;

  if(!self hasweapon(var_1))
    return -1;

  if(isDefined(level.gamemodemaydropweapon) && !self[[level.gamemodemaydropweapon]](var_1))
    return 0;

  var_1 = var_1 getnoaltweapon();
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;

  if(!scripts\mp\riotshield::isriotshield(var_1.basename)) {
    if(!self anyammoforweaponmodes(var_1))
      return 0;

    var_2 = self getweaponammoclip(var_1, "_encstr_8253060E2B5FE330");
    var_3 = self getweaponammoclip(var_1, "_encstr_A5AD056A019C63");

    if(!var_2 && !var_3)
      return 0;

    var_4 = self getweaponammostock(var_1);
    var_5 = weaponmaxammo(var_1);

    if(var_4 > var_5)
      var_4 = var_5;

    var_6 = self dropitem(var_1);

    if(!isDefined(var_6))
      return 0;

    if(istrue(level.clearstockondrop))
      var_4 = 0;

    var_6 itemweaponsetammo(var_2, var_4, var_3);
  } else {
    var_6 = self dropitem(var_1);

    if(!isDefined(var_6))
      return 0;

    var_6 itemweaponsetammo(1, 1, 0);
  }

  var_6 sethintdisplayrange(96);
  var_6 setuserange(96);
  var_6.owner = self;
  var_6.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
  var_6.objweapon = var_1;
  var_6 thread watchpickup(self);
  var_6 thread deletepickupafterawhile();
  return 1;
}

detachifattached(var_0, var_1) {
  var_2 = self getattachsize();

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = self getattachmodelname(var_3);

    if(var_4 != var_0) {
      continue;
    }
    var_5 = self getattachtagname(var_3);
    self detach(var_0, var_5);

    if(var_5 != var_1) {
      var_2 = self getattachsize();

      for(var_3 = 0; var_3 < var_2; var_3++) {
        var_5 = self getattachtagname(var_3);

        if(var_5 != var_1) {
          continue;
        }
        var_0 = self getattachmodelname(var_3);
        self detach(var_0, var_5);
        break;
      }
    }

    return 1;
  }

  return 0;
}

deletepickupafterawhile() {
  self endon("_encstr_AD75063D571AE108");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

getitemweaponname() {
  var_0 = self.classname;
  var_1 = getsubstr(var_0, 7);
  return var_1;
}

watchpickup(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level._id_120AD _calloutmarkerping_handleluinotify_acknowledgedcancel::from(self, var_0, self.objweapon);
  var_1 = getitemweaponname();

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2, var_3);
    var_4 = undefined;
    var_5 = isDefined(level.cyberemp) && isDefined(level.cyberemp.carrier) && level.cyberemp.carrier == var_2;
    var_6 = scripts\mp\utility\game::getgametype() == "_encstr_ACF906B79752C5E8" && (isDefined(var_3) || var_5);

    if(var_6) {
      var_7 = var_2 scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();

      if(var_7.size > 2) {
        var_8 = 0;
        var_9 = 0;
        var_10 = 0;

        foreach(var_12 in var_7) {
          if(var_12.basename == "_encstr_976A10EB17828EAF30525010DACD41460FB8")
            var_8 = 1;

          if(scripts\mp\utility\weapon::update_health_bar_to_player(var_12))
            var_9 = 1;

          if(var_12.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
            var_10 = 1;
        }

        if(isDefined(var_2.primaryweapon) && var_2.primaryweapon != "_encstr_976A10EB17828EAF30525010DACD41460FB8")
          var_4 = var_2.primaryweaponobj;
        else if(isDefined(var_2.secondaryweapon) && var_2.secondaryweapon != "_encstr_976A10EB17828EAF30525010DACD41460FB8")
          var_4 = var_2.secondaryweaponobj;

        var_14 = var_7.size;

        if(var_9)
          var_14--;

        if(var_10)
          var_14--;

        if(!var_8 || var_14 > 3) {
          var_15 = undefined;

          if(var_4.basename != "_encstr_8BBA05185F8B99")
            var_15 = var_4;

          var_16 = var_2 forcedropweapon(var_15);

          if(var_5) {
            var_2 scripts\common\utility::allow_weapon_switch(0);
            var_2 scripts\common\utility::allow_weapon_pickup(0);
            var_2 scripts\common\utility::allow_usability(0);
            var_2 thread waitthengivecyberweapon(var_16 == 0);
          }

          if(var_16 == 1) {} else if(var_16 == 0) {
            if(var_5) {
              var_2 scripts\common\utility::allow_usability(1);
              var_2 scripts\common\utility::allow_weapon_switch(1);
              var_2 scripts\common\utility::allow_weapon_pickup(1);
            }

            return;
          } else if(var_16 == -1) {}
        }
      } else if(var_5) {
        var_2 scripts\common\utility::allow_weapon_switch(0);
        var_2 scripts\common\utility::allow_weapon_pickup(0);
        var_2 scripts\common\utility::allow_usability(0);
        var_2 thread waitthengivecyberweapon();
      } else if(isDefined(var_3))
        var_4 = var_2.lastdroppableweaponobj;
      else
        var_4 = var_2 getcurrentweapon();
    } else if(isDefined(var_3))
      var_4 = var_2.lastdroppableweaponobj;
    else
      var_4 = var_2 getcurrentweapon();

    var_17 = var_2 scripts\mp\utility\perk::_hasperk("_encstr_9B7318FFD19D1A4128900B50EE6093C36729C7775337730F385B") && getdvarint("_encstr_A670195F3F43B7B63F9B40F0AF42C8DD2AA7D670975A6BD9ECFF70") == 1;
    var_2 thread watchpickupcomplete(self.objweapon, var_4, var_17);
    level._id_120AE _calloutmarkerping_handleluinotify_acknowledgedcancel::from(self, var_2, self.objweapon);
    var_2 notify("_encstr_914C0EDDB20B837BB97D38D2365BAB83", self.objweapon);

    if(isDefined(var_3)) {
      var_2.lastweaponpickuptime = gettime();
      var_2 scripts\mp\utility\stats::incpersstat("_encstr_81880EE74DE64B58D361CBB76C286B73", 1);
    }

    var_18 = fixupplayerweapons(var_2, var_1);

    if(isDefined(var_3) && var_17)
      var_3 delete();

    if(isDefined(var_3) || var_18) {
      break;
    }
  }

  if(isDefined(var_3)) {
    var_19 = var_3 getitemweaponname();
    var_20 = asmdevgetallstates(var_19);

    if(isDefined(var_2.tookweaponfrom[var_19])) {
      var_3.owner = var_2.tookweaponfrom[var_19];
      var_2.tookweaponfrom[var_19] = undefined;
    }

    var_3.objweapon = var_20;
    var_3.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
    var_3 thread watchpickup(var_2);
  }

  var_2.tookweaponfrom[var_1] = self.owner;
}

waitthengivecyberweapon(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_BD0D0E6691C8DBE2992707435B25AA70");
  self endon("_encstr_BD0D0E6691C8DBE2992707435B25AA70");

  while(isDefined(self.currentweapon.basename) && self.currentweapon.basename == "_encstr_8BBA05185F8B99")
    waitframe();

  scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_976A10EB17828EAF30525010DACD41460FB8");

  if(!istrue(var_0)) {
    scripts\common\utility::allow_usability(1);
    scripts\common\utility::allow_weapon_switch(1);
    scripts\common\utility::allow_weapon_pickup(1);
  }
}

watchpickupcomplete(var_0, var_1, var_2) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_956C167F17D326D8F0FCC1D8E3B8C9683A3BD1D3FB6A5B2A");
  self endon("_encstr_956C167F17D326D8F0FCC1D8E3B8C9683A3BD1D3FB6A5B2A");
  var_3 = self.currentweapon;
  var_4 = 0;

  if(var_3 == var_0)
    var_4 = 1;
  else {
    for(;;) {
      waitframe();
      var_5 = self.currentweapon;

      if(isnullweapon(var_3, var_5, 0)) {
        continue;
      }
      if(isnullweapon(var_0, var_5, 0))
        var_4 = 1;
      else
        var_4 = 0;

      break;
    }
  }

  if(var_4) {
    if(var_0.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
      scripts\mp\killstreaks\juggernaut_mp::juggernautweaponpickedup(var_0, var_1);

    thread notifyuiofpickedupweapon();

    if(isDefined(level._id_120B0))
      [[level._id_120B0]](var_0);
    else if(var_2)
      thread usegraverobber(var_0, var_1);
  }
}

usegraverobber(var_0, var_1) {
  if(isDefined(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    var_2 = var_1;
    var_3 = safechecknum(var_1.name);
    var_4 = getrandomgraverobberattachment(var_1);

    if(isDefined(var_4)) {
      var_5 = getweaponattachments(var_1);

      foreach(var_8, var_7 in var_5) {
        if(!scripts\mp\utility\weapon::attachmentscompatible(var_3, var_7, var_4))
          var_5[var_8] = undefined;
      }

      var_5 = scripts\engine\utility::array_removeundefined(var_5);
      var_5[var_5.size] = var_4;
      var_2 = var_1 withattachments(var_5);
    }

    var_9 = scripts\mp\utility\weapon::getweaponfullname(var_2);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);
    self assignweaponprimaryslot(var_9);
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_9);
    fixupplayerweapons(self, var_9);
    self setweaponammoclip(var_2, self.graverobberammo.lastweapon.rightclip, "_encstr_8253060E2B5FE330");
    self setweaponammoclip(var_2, self.graverobberammo.lastweapon.leftclip, "_encstr_A5AD056A019C63");
    self setweaponammostock(var_2, self.graverobberammo.lastweapon.stock);
    var_10 = self getweaponslistprimaries();

    foreach(var_12 in var_10)
    addscavengercliptoweapon(self, var_12, 0.5);

    if(isDefined(var_4)) {
      wait 0.05;
      var_5 = getweaponattachments(var_2);
      var_14 = scripts\engine\utility::array_find(var_5, var_4);

      if(!isDefined(var_14))
        var_14 = 0;

      self setclientomnvar("_encstr_AD81115796EBDD2B0B0EF69BBE38D28DB5BA83", var_14 + 1);
      self playlocalsound("_encstr_AC49121F3813C1927919EF25FD6FDB819958C7E3");
    }
  }
}

getrandomgraverobberattachment(var_0, var_1) {
  if(!isDefined(var_0))
    return undefined;

  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_3 = getweaponattachments(var_0);
  var_4 = [];

  if(isDefined(var_1) && var_1.size > 0)
    var_4 = var_1;
  else
    var_4 = scripts\mp\utility\weapon::register_wave_spawner(var_2);

  if(!isDefined(var_4))
    return undefined;

  foreach(var_8, var_6 in var_3) {
    var_7 = scripts\mp\utility\weapon::attachmentmap_tobase(var_6);

    if(!scripts\mp\utility\weapon::carriedpunchcard(var_0, var_7)) {
      var_3[var_8] = undefined;
      continue;
    }
  }

  var_4 = scripts\engine\utility::can_be_shot_again(var_4);
  var_4 = scripts\engine\utility::array_randomize(var_4);

  foreach(var_10 in var_4) {
    if(!isgraverobberattachment(var_2, var_10)) {
      continue;
    }
    var_11 = 0;

    foreach(var_6 in var_3) {
      if(scripts\mp\utility\weapon::attachmentsconflict(var_6, var_10, var_0) != "_encstr_B40101") {
        var_11 = 1;
        break;
      }
    }

    if(var_11) {
      continue;
    }
    return var_10;
  }

  return undefined;
}

addattachmenttoweapon(var_0, var_1) {
  var_2 = getweaponvariantindex(var_0);
  var_0 = var_0 getnoaltweapon();
  var_3 = var_0.attachmentvarindices;
  var_4 = [];
  var_5 = [];

  foreach(var_9, var_7 in var_3) {
    var_8 = scripts\mp\utility\weapon::attachmentmap_tobase(var_9);
    var_5[var_5.size] = var_8;
    var_4[var_8] = var_7;
  }

  var_10 = 0;

  if(scripts\engine\utility::array_contains(var_5, var_1))
    var_10 = 1;
  else {
    var_11 = scripts\mp\utility\weapon::attachmentmap_tounique(var_1, var_0);

    if(!var_0 canuseattachment(var_11))
      var_10 = 1;
  }

  if(var_10)
    return undefined;

  var_5 = scripts\mp\utility\weapon::weaponattachremoveextraattachments(var_5, var_0);
  var_12 = [];

  foreach(var_14, var_9 in var_5)
  var_12[var_14] = var_4[var_9];

  var_5[var_5.size] = var_1;
  var_12[var_12.size] = 0;
  var_15 = var_0.camo;
  var_16 = [];

  if(isDefined(var_0.stickerslot0))
    var_16[var_16.size] = var_0.stickerslot0;

  if(isDefined(var_0.stickerslot1))
    var_16[var_16.size] = var_0.stickerslot1;

  if(isDefined(var_0.stickerslot2))
    var_16[var_16.size] = var_0.stickerslot2;

  if(isDefined(var_0.stickerslot3))
    var_16[var_16.size] = var_0.stickerslot3;

  var_17 = scripts\cp_mp\utility\game_utility::isnightmap();
  var_0 = scripts\mp\class::buildweapon(scripts\mp\utility\weapon::getweaponrootname(var_0), var_5, var_15, "_encstr_8BBA05185F8B99", var_2, var_12, undefined, var_16, var_17);
  return var_0;
}

getammooverride(var_0) {
  var_1 = var_0 getbaseweapon();
  var_2 = weaponclipsize(var_1);
  var_3 = weaponclipsize(var_0);
  var_4 = var_2;

  switch (var_0.basename) {
    case "_encstr_9154112DEEC1BE636BAF6BB6A563DE99AF6B83":
    case "_encstr_81291199FF1A494B18A9CA0A42FD7E4A676AF2":
    case "_encstr_A61B1358232A790335CF6FA272AF9AFB35FE2FD112":
      break;
    default:
      var_4 = int(min(var_2, var_3));
  }

  var_5 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_6 = 30;

  if(var_0.isalternate) {
    var_7 = scripts\mp\utility\weapon::attachmentmap_tobase(var_0.underbarrel);

    switch (var_7) {
      case "_encstr_8435070CAC0F080BD2":
      case "_encstr_A78B09ECB16E2B5B47590F":
      case "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5":
      case "_encstr_873708FFA8104C0AAEC1":
      case "_encstr_ADBD0780C4884FEE86":
      case "_encstr_97D506F770BFFFBB":
      case "_encstr_AA7608ECD89B6BDE5B59":
      case "_encstr_8A07035972":
        var_6 = 1;
        break;
      case "_encstr_BE9708CBAB13138857AD":
        var_6 = 999;
        break;
      default:
        var_6 = 0;
        break;
    }
  } else {
    switch (var_0.classname) {
      case "_encstr_A1100738A33A638123":
        switch (var_5) {
          case "_encstr_B10B12CC2CE969D3A8513F1BC883B4723B648253":
            var_6 = 6;
            break;
          case "_encstr_A1E70FBB8CDA89535851E1C3D9EB66A97A":
            var_6 = 8;
            break;
          default:
            var_6 = int(min(var_4, 30));
            break;
        }

        break;
      case "_encstr_850707F7E5833355B8":
        switch (var_5) {
          case "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD":
            var_6 = 3;
            break;
          default:
            var_6 = int(min(var_4, 30));
            break;
        }

        break;
      default:
        var_6 = int(min(var_4, 30));
    }
  }

  return var_6;
}

isgraverobberattachment(var_0, var_1) {
  if(!scripts\mp\utility\weapon::carriedpunchcard(var_0, var_1))
    return 0;

  switch (var_1) {
    case "_encstr_A9F90E09660BF37B52AF4010AB6B5139":
    case "_encstr_B45E080DA3A03EDFD998":
    case "_encstr_91D30B98AF82FABB1A37C877AA":
    case "_encstr_AD9C07E0478148252A":
      return 0;
  }

  if(issubstr(var_1, "_encstr_A3CA081B50EDAB3D60A9"))
    return 0;

  if(issubstr(var_1, "_encstr_96E206CE53B31F0B"))
    return 0;

  if(getsubstr(var_1, 0, 3) == "_encstr_8719041B0BB1")
    return 0;

  return 1;
}

notifyuiofpickedupweapon() {}

fixupplayerweapons(var_0, var_1) {
  var_2 = var_0 getweaponslistprimaries();
  var_3 = 1;
  var_4 = 1;
  var_5 = undefined;

  if(issameweapon(var_1))
    var_5 = createheadicon(var_1);
  else
    var_5 = var_1;

  foreach(var_7 in var_2) {
    if(isDefined(var_0.primaryweaponobj) && var_0.primaryweaponobj == var_7) {
      var_3 = 0;
      continue;
    }

    if(isDefined(var_0.secondaryweaponobj) && var_0.secondaryweaponobj == var_7)
      var_4 = 0;
  }

  if(var_3) {
    var_0.primaryweapon = var_5;
    var_0.primaryweaponobj = asmdevgetallstates(var_5);
  } else if(var_4) {
    var_0.secondaryweapon = var_5;
    var_0.secondaryweaponobj = asmdevgetallstates(var_5);
  }

  return var_3 || var_4;
}

itemremoveammofromaltmodes() {
  var_0 = getitemweaponname();
  var_1 = weaponaltweaponname(var_0);

  for(var_2 = 1; var_1 != "_encstr_8BBA05185F8B99" && var_1 != var_0; var_2++) {
    self itemweaponsetammo(0, 0, 0, var_2);
    var_1 = weaponaltweaponname(var_1);
  }
}

_id_12082(var_0) {
  if(isDefined(level._id_12082))
    [[level._id_12082]](var_0);
  else {
    scavengergiveammo(var_0);
    var_0 scripts\mp\equipment::givescavengerammo();
    var_0 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(level._encstr_99DB1773C7089B9F38F94A03230197D578A30AE943D0E36BDD);
  }
}

handlescavengerbagpickup(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_AF460A7B2649F34FE367455D", var_1);

    if(!var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
      break;
    }
  }

  var_1 notify("_encstr_9AF0119BB1583B95733B5927AFE05AB15BABE0");
  _id_12082(var_1);

  if(!isDefined(var_1.pers["_encstr_B8FE12908769CBCB1A2F5DDECA420FD0D5333983"]))
    var_1.pers["_encstr_B8FE12908769CBCB1A2F5DDECA420FD0D5333983"] = 0;

  var_1 scripts\cp\vehicles\vehicle_compass_cp::_id_1205F("_encstr_8B2C0ED07A16BDF9E307D55639372047", 0);
  var_1 scripts\mp\utility\stats::incpersstat("_encstr_B8FE12908769CBCB1A2F5DDECA420FD0D5333983", 1);
  var_1 scripts\mp\damagefeedback::hudicontype("_encstr_AF460A7B2649F34FE367455D");
  var_2 = scripts\mp\utility\game::unset_relic_grounded();

  if(istrue(var_2))
    var_1 scripts\mp\equipment::incrementequipmentslotammo("_encstr_91B50734CA58631D1A", 1);

  if(isDefined(self.useobj))
    self.useobj delete();

  self notify("_encstr_AD75063D571AE108");
}

scavengergiveammo(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1)
  addscavengercliptoweapon(var_0, var_3, 1);

  var_5 = scripts\mp\utility\game::unset_relic_grounded();

  if(istrue(var_5))
    bbeingelectrocuted(var_0, 1);
}

addscavengercliptoweapon(var_0, var_1, var_2) {
  if(!scripts\mp\utility\weapon::iscacprimaryweapon(var_1) && !level.scavenger_secondary) {
    return;
  }
  if(var_1.isalternate) {
    return;
  }
  if(scripts\mp\utility\weapon::getweapongroup(var_1) == "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195") {
    return;
  }
  var_3 = var_0 getweaponammostock(var_1);
  var_4 = getammooverride(var_1);
  var_4 = int(ceil(var_2 * var_4));

  if(var_1 hasattachment("_encstr_AD9C07E0478148252A", 1))
    var_4 = var_4 * 1;

  var_0 setweaponammostock(var_1, var_3 + var_4);
}

bbeingelectrocuted(var_0, var_1) {
  var_0 scripts\mp\equipment::incrementequipmentslotammo("_encstr_91B50734CA58631D1A", var_1);
}

scavenger_budget_delete() {
  if(isDefined(self.useobj))
    self.useobj delete();

  self delete();
}

dropscavengerfordeath(var_0, var_1) {
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!shoulddropscavengerbag(var_0, var_1)) {
    return;
  }
  var_2 = 0;

  if(isDefined(var_1) && var_1 == "_encstr_AA230E8CF56CD18DB12FC7E303C8C001")
    var_2 = 1.5;

  wait(var_2);

  if(var_2 > 0 && !shoulddropscavengerbag(var_0, var_1)) {
    return;
  }
  dropscavengerfordeathinternal(var_0);
}

dropscavengerfordeathinternal(var_0) {
  var_1 = self dropscavengerbag("_encstr_883D11A00A66ADE9F337E56637FB5147417230", "_encstr_AADA07DBF19A4A81D7");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 scripts\cp_mp\ent_manager::registerspawn(2, ::scavenger_budget_delete);
  var_1.owner = var_0;
  var_1.team = var_0.team;
  var_2 = scripts\mp\utility\game::unset_relic_grounded();

  if(istrue(var_2)) {
    var_1.outlineid = scripts\mp\utility\outline::outlineenableforplayer(var_1, var_1.owner, "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD", "_encstr_960D052F10EBF0");
    var_1 thread handlescavengerbagpickup(self);
    var_1 thread scavengerbagcleanupthink(var_1.outlineid);
    var_1 thread scavengerbagtimeoutthink(var_1.outlineid);
  } else {
    var_1 thread handlescavengerbagpickup(self);
    var_1 thread scavengerbagcleanupthink();
    var_1 thread scavengerbagtimeoutthink();
  }

  if(isDefined(level.bot_funcs) && isDefined(level.bot_funcs["_encstr_9ADC1726DE8EB9BEB04646EB9B6C163BB273EC59277D98B0EC"]))
    [[level.bot_funcs["_encstr_9ADC1726DE8EB9BEB04646EB9B6C163BB273EC59277D98B0EC"]]](var_1);
}

shoulddropscavengerbag(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(var_0 == self)
    return 0;

  return 1;
}

scavengerbagcleanupthink(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.owner scripts\engine\utility::_id_143A6("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_ACDC0C26859DEB474B6B59F65747");

  if(isDefined(self)) {
    if(isDefined(self.useobj)) {
      var_1 = scripts\mp\utility\game::unset_relic_grounded();

      if(istrue(var_1))
        scripts\mp\utility\outline::outlinedisable(var_0, self);

      self.useobj delete();
    }

    scripts\cp_mp\ent_manager::deregisterspawn();
    self delete();
  }
}

scavengerbagtimeoutthink(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = scripts\mp\utility\game::unset_relic_grounded();
  wait(scripts\engine\utility::ter_op(var_1, 60, 20));

  if(istrue(var_1))
    scripts\mp\utility\outline::outlinedisable(var_0, self);

  if(isDefined(self))
    self.owner notify("_encstr_ACDC0C26859DEB474B6B59F65747");
}

scavengerbagusesetup() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = &"_encstr_9B5C1787FF893FCF8FBBE9E99327E7FFA192968783506D358D";
  self.useobj = scripts\mp\gameobjects::createhintobject(self.origin + anglestoup(self.angles) * 1, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, var_0, undefined, undefined, "_encstr_BD1805CB69C063", 200, 160, 100, 160);
  self.useobj.owner = self.owner;
  self.useobj.team = self.team;
  self.useobj linkTo(self);

  foreach(var_2 in level.players)
  self.useobj disableplayeruse(var_2);

  thread scavengebagthink();
  thread scavengebagusemonitoring();

  for(;;) {
    self waittill("_encstr_A59215F380031A0758972397AF3F2B698AB989DE0D7FFC", var_2);

    if(isPlayer(var_2)) {
      var_2 notify("_encstr_9AF0119BB1583B95733B5927AFE05AB15BABE0");
      _id_12082(var_2);
      var_2 scripts\mp\damagefeedback::hudicontype("_encstr_AF460A7B2649F34FE367455D");

      if(isDefined(self.useobj))
        self.useobj delete();

      self notify("_encstr_AD75063D571AE108");
    }
  }
}

scavengebagusemonitoring() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 1;

  while(var_0) {
    wait 0.1;

    foreach(var_2 in level.players) {
      if(!isDefined(self)) {
        var_0 = 0;
        continue;
      }

      if(var_2.team != self.team || var_2 scripts\mp\utility\perk::_hasperk("_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3")) {
        self.useobj disableplayeruse(var_2);
        continue;
      }

      self.useobj enableplayeruse(var_2);
    }
  }
}

scavengebagthink() {
  self endon("_encstr_A517132A055FFBA18B687763D8068882E3A674E6F6");
  var_0 = self.useobj;
  var_1 = undefined;

  if(istrue(level.gameended) && !isDefined(var_0)) {
    return;
  }
  while(isDefined(self)) {
    var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
    var_2.iscapturingcrate = 1;
    var_1 = createuseent();
    var_1.id = "_encstr_AB19049D0FC0";
    var_3 = var_1 useholdthink(var_2, getdvarfloat("_encstr_A648202377426898DAFF95F7D7725450E64F09FB11ABF04F73BF9D97E7799D888DA7"));

    if(!isDefined(var_2)) {
      return;
    }
    var_2.iscapturingcrate = 0;

    if(var_3)
      self notify("_encstr_A59215F380031A0758972397AF3F2B698AB989DE0D7FFC", var_2);
  }
}

useholdthink(var_0, var_1) {
  self.curprogress = 0;
  self.inuse = 1;
  self.userate = 0;
  self.usetime = var_1;
  scripts\mp\movers::script_mover_link_to_use_object(var_0);
  var_0 scripts\common\utility::allow_weapon(0);
  var_2 = useholdthinkloop(var_0);

  if(isalive(var_0))
    var_0 scripts\common\utility::allow_weapon(1);

  if(isDefined(var_0))
    scripts\mp\movers::script_mover_unlink_from_use_object(var_0);

  if(!isDefined(self))
    return 0;

  self.inuse = 0;
  self.curprogress = 0;
  return var_2;
}

useholdthinkloop(var_0) {
  var_1 = internal_useholdthinkloop(var_0);

  if(isDefined(self))
    var_0 scripts\mp\gameobjects::updateuiprogress(self, 0);

  return istrue(var_1);
}

internal_useholdthinkloop(var_0) {
  self endon("_encstr_8F20103DC6F1B1F0C59C5769F99430184080");

  while(var_0 isplayerusing(self)) {
    if(!var_0 scripts\mp\movers::script_mover_use_can_link(self))
      return 0;

    self.curprogress = self.curprogress + level.framedurationseconds * self.userate;

    if(isDefined(self.objectivescaler))
      self.userate = 1 * self.objectivescaler;
    else
      self.userate = 1;

    var_0 scripts\mp\gameobjects::updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime)
      return scripts\mp\utility\player::isreallyalive(var_0);

    waitframe();
  }

  return 0;
}

createuseent() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_0.curprogress = 0;
  var_0.usetime = 0;
  var_0.userate = 3000;
  var_0.inuse = 0;
  var_0.id = self.id;
  var_0 linkTo(self);
  var_0 thread deleteuseent(self);
  return var_0;
}

deleteuseent(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.usedby)) {
    foreach(var_2 in self.usedby) {
      var_2 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
      var_2.ui_securing = undefined;
    }
  }

  self delete();
}

isplayerusing(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var_0.curprogress < var_0.usetime && (!isDefined(self.teleporting) || !self.teleporting);
}

weaponcanstoreaccuracystats(var_0) {
  if(scripts\mp\utility\weapon::iscacmeleeweapon(var_0.basename))
    return 0;

  return scripts\mp\utility\weapon::iscacprimaryweapon(var_0.basename) || scripts\mp\utility\weapon::iscacsecondaryweapon(var_0.basename);
}

setweaponstat(var_0, var_1, var_2) {
  scripts\mp\gamelogic::setweaponstat(var_0, var_1, var_2);
}

watchweaponusage(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_1);
    onweaponfired(var_1);
  }
}

onweaponfired(var_0) {
  scripts\mp\gamelogic::sethasdonecombat(self, 1);
  var_1 = gettime();

  if(!isDefined(self.lastshotfiredtime))
    self.lastshotfiredtime = 0;

  var_2 = gettime() - self.lastshotfiredtime;
  self.lastshotfiredtime = var_1;

  if(isai(self)) {
    return;
  }
  if(!weaponcanstoreaccuracystats(var_0)) {
    return;
  }
  thread watchformiss(var_0);

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var_3 = scripts\mp\playerstats_interface::getplayerstat("_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_972C0B3AF63A8563A6D07B3ADC") + 1;
    var_4 = scripts\mp\playerstats_interface::getplayerstat("_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B");
    scripts\mp\playerstats_interface::setplayerstatbuffered(var_3, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_972C0B3AF63A8563A6D07B3ADC");
    scripts\mp\playerstats_interface::setplayerstatbuffered(int(var_3 - var_4), "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8EDA07FF229707BB77");
  }

  var_5 = 1;
  setweaponstat(var_0, var_5, "_encstr_884806B91ADEE8CD");
  setweaponstat(var_0, self.hits, "_encstr_88CC0521F3A13B");
  scripts\mp\utility\stats::incpersstat("_encstr_ABAB0B8A63871B13AD20BBEFA0", 1);
  self.hits = 0;

  if(self getweaponammoclip(var_0) == 0 && self getweaponammostock(var_0) == 0)
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_973610CC1B0BCEDE27F59B2BB32C3A2DEC95");
}

watchformiss(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = createheadicon(var_0);
  self endon("_encstr_8F0C0EBBC21D1B0D23F6C953A5DCDCF5" + var_1);
  waitframe();
  self.consecutivehitsperweapon[var_1] = 0;
  scripts\mp\events::shotmissed();
}

clearmiss(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = createheadicon(var_0);
  self notify("_encstr_8F0C0EBBC21D1B0D23F6C953A5DCDCF5" + var_1);
}

_id_144C3() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_A2F315ABBB2BDF681327CBC1CBCCC805830F3123EB329B");
    scripts\mp\playerstats_interface::addtoplayerstatbuffered(1, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8FD00BB9B22C27A6A5CDCDB2DC");
  }
}

checkhit(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(var_0.isalternate) {
    var_2 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_0);

    if(scripts\engine\utility::array_contains(var_2, "_encstr_A65B084B38A76BEFC350") || scripts\engine\utility::array_contains(var_2, "_encstr_8A07035972") || scripts\engine\utility::array_contains(var_2, "_encstr_AA7608ECD89B6BDE5B59") || scripts\engine\utility::array_contains(var_2, "_encstr_97D506F770BFFFBB") || scripts\engine\utility::array_contains(var_2, "_encstr_ADBD0780C4884FEE86") || scripts\engine\utility::array_contains(var_2, "_encstr_873708FFA8104C0AAEC1") || scripts\engine\utility::array_contains(var_2, "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5") || scripts\engine\utility::array_contains(var_2, "_encstr_A78B09ECB16E2B5B47590F") || scripts\engine\utility::array_contains(var_2, "_encstr_8435070CAC0F080BD2"))
      self.hits = 1;
  }

  if(!weaponcanstoreaccuracystats(var_0)) {
    return;
  }
  if(self meleeButtonPressed() && var_0.basename != "_encstr_BED80D7C9C59D95BF870DBDFA9F018") {
    return;
  }
  switch (weaponclass(var_0)) {
    case "_encstr_BE1904DCDA9D":
    case "_encstr_8D940738966ED1DB8D":
    case "_encstr_850707F7E5833355B8":
    case "_encstr_BE0703A54C":
    case "_encstr_965306392D3336B2":
      self.hits++;
      break;
    case "_encstr_A1100738A33A638123":
      self.hits = 1;
      break;
    default:
      break;
  }

  var_3 = createheadicon(var_0);

  if(scripts\mp\riotshield::isriotshield(var_0.basename) || var_0.basename == "_encstr_BED80D7C9C59D95BF870DBDFA9F018") {
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_3, self.hits, "_encstr_88CC0521F3A13B");
    self.hits = 0;
  }

  waittillframeend;
  thread clearmiss(var_0);

  if(!isDefined(self.lasthittime[var_3]))
    self.lasthittime[var_3] = 0;

  if(self.lasthittime[var_3] == gettime()) {
    return;
  }
  self.lasthittime[var_3] = gettime();

  if(!isDefined(self.consecutivehitsperweapon) || !isDefined(self.consecutivehitsperweapon[var_3]))
    self.consecutivehitsperweapon[var_3] = 1;
  else {
    self.consecutivehitsperweapon[var_3]++;
    scripts\cp\vehicles\vehicle_compass_cp::_id_12007(var_0, self.consecutivehitsperweapon[var_3]);
  }

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var_4 = scripts\mp\playerstats_interface::getplayerstat("_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_972C0B3AF63A8563A6D07B3ADC");
    var_5 = scripts\mp\playerstats_interface::getplayerstat("_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B") + 1;

    if(var_5 <= var_4) {
      scripts\mp\playerstats_interface::setplayerstatbuffered(var_5, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B");
      scripts\mp\playerstats_interface::setplayerstatbuffered(int(var_4 - var_5), "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8EDA07FF229707BB77");
    }
  }

  thread scripts\cp\vehicles\vehicle_compass_cp::onsuccessfulhit(var_0);
  thread scripts\mp\events::shothit();
  var_6 = scripts\mp\utility\weapon::getweapongroup(var_0.basename);

  if(var_6 == "_encstr_A3710BEEACC2E0B737EB36B676") {
    if(!isDefined(self.shotslandedlmg))
      self.shotslandedlmg = 1;
    else
      self.shotslandedlmg++;
  }

  var_7 = gettime();
  self.lastdamagetime = var_7;

  if(isDefined(var_1))
    var_1.lasttimedamaged = var_7;
}

friendlyfirecheck(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    return 1;

  if(!level.teambased)
    return 1;

  var_4 = level.friendlyfire;

  if(isDefined(var_2))
    var_4 = var_2;

  if(var_4 != 0)
    return 1;

  if(var_1 == var_0 || isDefined(var_1.owner) && var_1.owner == var_0)
    return 1;

  var_5 = undefined;

  if(isDefined(var_1.owner))
    var_5 = var_1.owner.team;
  else if(isDefined(var_1.team))
    var_5 = var_1.team;

  if(!isDefined(var_5))
    return 1;

  if(var_5 != var_0.team)
    return 1;

  return 0;
}

watchequipmentonspawn() {
  self notify("_encstr_B82816D3A849463B3D37FDE94FC0F7CDA141CA29883B3B6B");
  self endon("_encstr_B82816D3A849463B3D37FDE94FC0F7CDA141CA29883B3B6B");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  deletedisparateplacedequipment();
  var_0 = scripts\mp\utility\dvars::getintproperty("_encstr_8C5F1CB9C6E4AF19AC1B5947B22BC338B1B76EA59D956EB7B9B9C12CDD37", 1) && (!scripts\mp\utility\perk::_hasperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E") || !checkequipforrugged());

  if(var_0)
    deleteplacedequipment();

  var_1 = self.plantedtacticalequip.size;
  var_2 = self.plantedlethalequip.size;
  var_3 = self.plantedsuperequip.size;
  var_4 = self.plantedhackedequip.size;
  var_5 = var_1 && var_2 && var_3 && var_4;

  if(scripts\mp\utility\perk::_hasperk("_encstr_AA14156E0795B14B0B1BA35EAF27ABD99DCA91AF95B80E") && var_5)
    thread scripts\mp\perks\perkfunctions::feedbackruggedeqp(var_2, var_1, var_3, var_4);
}

getallequip() {
  var_0 = [];

  if(isDefined(self.plantedlethalequip))
    var_0 = scripts\engine\utility::array_combine(var_0, self.plantedlethalequip);

  if(isDefined(self.plantedtacticalequip))
    var_0 = scripts\engine\utility::array_combine(var_0, self.plantedtacticalequip);

  if(isDefined(self.plantedsuperequip))
    var_0 = scripts\engine\utility::array_combine(var_0, self.plantedsuperequip);

  if(isDefined(self.plantedhackedequip))
    var_0 = scripts\engine\utility::array_combine(var_0, self.plantedhackedequip);

  return var_0;
}

removeequip(var_0) {
  if(isDefined(self.plantedlethalequip))
    self.plantedlethalequip = scripts\engine\utility::array_remove(self.plantedlethalequip, var_0);

  if(isDefined(self.plantedtacticalequip))
    self.plantedtacticalequip = scripts\engine\utility::array_remove(self.plantedtacticalequip, var_0);

  if(isDefined(self.plantedsuperequip))
    self.plantedsuperequip = scripts\engine\utility::array_remove(self.plantedsuperequip, var_0);

  if(isDefined(self.plantedhackedequip))
    self.plantedhackedequip = scripts\engine\utility::array_remove(self.plantedhackedequip, var_0);
}

checkequipforrugged() {
  var_0 = scripts\engine\utility::array_combine(self.plantedtacticalequip, self.plantedlethalequip);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.hasruggedeqp))
      return 1;
  }

  return 0;
}

watchgrenadeusage() {
  self notify("_encstr_9571127F17D326D8E73A0178E6ACF875DB7FC7D3");
  self endon("_encstr_9571127F17D326D8E73A0178E6ACF875DB7FC7D3");
  self endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");

  for(;;)
    watchgrenadethrows();
}

watchgrenadethrows() {
  var_0 = _utilflare_isvalidflaretype::waittill_grenade_throw();

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.weapon_name)) {
    return;
  }
  setweaponstat(var_0.weapon_name, 1, "_encstr_884806B91ADEE8CD");
  var_1 = scripts\mp\equipment::isequipmentlethal(var_0.weapon_name);
  var_2 = isDefined(var_0.equipmentref) && scripts\mp\equipment::isequipmenttactical(var_0.equipmentref);
  scripts\mp\potg_events::grenadethrownevent(var_1);
  scripts\mp\battlechatter_mp::ongrenadeuse(var_0);
  scripts\mp\gamelogic::sethasdonecombat(self, 1);

  if(var_2 && self isthrowingbackgrenade() && getdvarint("_encstr_9B561FE6B139F55A9B99A5B9D23A56EB1D0BB18E5AC60BB1E67D1BB1CA2CCDEAC1", 1)) {
    self _meth_87A9();
    var_3 = getcompleteweaponname(var_0.weapon_name);
    var_4 = self getweaponammoclip(var_3);
    var_5 = int(max(var_4 - 1, 0));
    self setweaponammoclip(var_3, var_5);
  }

  if(scripts\mp\utility\weapon::isaxeweapon(var_0.weapon_name)) {
    var_0 thread _utilflare_isvalidflaretype::watchgrenadeaxepickup(self);
    return;
  }

  var_0 thread scripts\mp\battlechatter_mp::grenadeproximitytracking();
  var_0.spawnpos = var_0.origin;

  switch (var_0.weapon_name) {
    case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
      if(var_0.ticks >= 1)
        var_0.iscooked = 1;

      var_0.originalowner = self;
      var_0 thread scripts\mp\shellshock::grenade_earthquake();
      break;
    case "_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0":
      if(var_0.ticks >= 1)
        var_0.iscooked = 1;

      var_0.originalowner = self;
      thread scripts\mp\equipment\wristrocket::wristrocketused(var_0);
      var_0 thread scripts\mp\shellshock::grenade_earthquake(0.6);
      break;
    case "_encstr_92A70ABB8267F5E0D89F6351":
      thread _id_13018(var_0);
      var_0 thread scripts\mp\shellshock::grenade_earthquake();
      break;
    case "_encstr_9AAE0876FCB7603101DB":
      thread scripts\mp\equipment\c4::c4_used(var_0);
      break;
    case "_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E":
      thread scripts\mp\equipment\emp_grenade::emp_grenade_used(var_0);
      break;
    case "_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E":
      thread scripts\mp\equipment\snapshot_grenade::snapshot_grenade_used(var_0, 0);
      break;
    case "_encstr_8823119675DAFF897F878020BB99612B219D8F":
      var_0 thread smokegrenadeused();
      break;
    case "_encstr_92EA0A290B32FF88A90170EB":
      thread scripts\mp\equipment\trophy_system::trophy_used(var_0);
      break;
    case "_encstr_835611C8951BF6CDEB37D1851DD27BB9D7B6E0":
      thread _debug_rooftop_heli_start::jeep_initomnvars(var_0);
      break;
    case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
      thread scripts\mp\equipment\claymore::claymore_use(var_0);
      break;
    case "_encstr_81430B218B3F7018458997D78A":
      thread scripts\mp\equipment\at_mine::at_mine_use(var_0);
      break;
    case "_encstr_8AF817C568CBE8E754F22078CA6C8DE1270C4E33F41B560BFA":
    case "_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170":
    case "_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83":
    case "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83":
      thread scripts\cp_mp\equipment\throwing_knife::throwing_knife_used(var_0);
      break;
    case "_encstr_BA730BF8AFF178988293F158B9":
      var_0 thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\equipment\molotov::molotov_used(var_0);
      break;
    case "_encstr_99410C4B48C39AB7D0CD95B769DB":
      thread scripts\mp\equipment\thermite::thermite_used(var_0);
      break;
    case "_encstr_B63519953187B7EF1FE6575071AE7C3E69470295E840C0A2217212":
      thread scripts\mp\supers\spawnbeacon::thrown(var_0);
      break;
    case "_encstr_8DAF1F47B036EBEDC16EEBB9AB381C1B2FBEC1856CDAFA763959CDC246CAEBB583":
      thread scripts\mp\tac_ops\roles_utility::throwsupplypack(var_0);
      break;
    case "_encstr_92BC0F408BC20108238458CE67F3F6F32A":
      thread scripts\mp\equipment\support_box::supportbox_used(var_0);
      break;
    case "_encstr_81BE0DD71ADF8095A15AF84861C549":
      thread scripts\mp\equipment\support_box::calloutmarkerpingvo_playpredictivepingadded(var_0);
      break;
    case "_encstr_BE8B116725FA28FB5178B2CF85017912618763":
      thread scripts\mp\equipment\decoy_grenade::decoy_used(var_0);
      break;
    case "_encstr_B8D30758E3EE7827BA":
      thread scripts\mp\equipment\gas_grenade::gas_used(var_0);
      break;
    case "_encstr_8C2E0D5B1078EEF508EBB81DE067A3":
      thread scripts\mp\equipment\hb_sensor::hb_sensor_used(var_0);
      break;
    case "_encstr_932A12897D8237E1ABEF777D5D38B3BF72E9B068":
      thread _determinelocationarray::postspawn_juggernaut(var_0);
      break;
    case "_encstr_974A19B28974EB1620913F1B917B9B432DE349FBB158C34FD19B28":
      thread _debug_rooftop_activesat::colmodel(var_0);
      break;
    case "_encstr_B80E0DD3FF027E48DD5E7582AF27A8":
      thread scripts\mp\equipment\tactical_cover::tac_cover_used(var_0);
      break;
    case "_encstr_B635099C3C8FEDFB88E9EB":
      thread scripts\mp\equipment\tac_insert::tacinsert_used(var_0);
      break;
    case "_encstr_86691F58C8EC169B6C568CFA6EBA0EC163E5D791C9B70EF5DA0B4EB52B39D7B51C":
      thread scripts\mp\equipment\advanced_supply_drop::advanced_supply_drop_marker_used(var_0);
      break;
    case "_encstr_BDDF208519B30BDC6C9519F5EC2B1AD21BB1ACAF91E4EDE0BE6BB093AD2B39FAAD38":
      thread scripts\mp\equipment\advanced_supply_drop::binoculars_onstatelospendingupdate(var_0);
      break;
    case "_encstr_AF281D307AA38388C73565F004CF906141E220B8D3312321EB53FD5EDF2FBB":
      thread scripts\mp\equipment\advanced_supply_drop::binoculars_onstateinvalidupdate(var_0);
      break;
    case "_encstr_A6AB15078F8AEBD883CFBB7F6A7BA560BA5595F3CF3293":
      thread scripts\mp\equipment\weapon_drop::weapondrop_used(var_0);
      break;
    case "_encstr_B867153F40FF7F4AAFA11D5763D0D2C25287551B215D4B":
      thread _findgivearmoramountanddropleftovers::wait_between_combat_action(var_0);
      break;
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
      var_0 thread hoopty_truck_initdamage();
      break;
    case "_encstr_A3C80AFA71E9D73FF8CF1AF2":
      thread _donewithcorpse::vehicle_compass_instanceisregistered(var_0);
      break;
    case "_encstr_A79A0E6D85DB6739B15BF89063F73071":
      thread _debug_rooftop_raid_exfil::morsenumber(var_0);
      break;
    case "_encstr_B8FE1378DF6549CBDB2A405442821591D43769E8B3":
      thread _encstr_B1B12957D332E09F73AB702083C6DDE80B21D9F37D9D504873E330C93A9B8EE127920B7DE14710176FFBC9::_encstr_83CE159B57B6895639CDF59D9CACCDB03256F5EA9BACC8(var_0);
      break;
    default:
      if(isDefined(level._id_1203B))
        [[level._id_1203B]](var_0.weapon_name, var_0);

      break;
  }

  _id_119B0(var_0.weapon_name);
}

_id_119B0(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = scripts\mp\utility\weapon::getequipmenttype(var_0);

  if(!isDefined(var_1))
    var_1 = "_encstr_8BBA05185F8B99";

  self dlog_recordplayerevent("_encstr_8E2819191BDE3BBEB2675673D17DB25C5D2DC1DA2B731DBEBAE6B2", ["_encstr_9BA20CD8F7015387B299FD866F6A", var_0, "_encstr_93B20F806FDD88414ACFB8BDA9339B5335", var_1]);
}

hoopty_truck_initdamage() {
  thread scripts\mp\utility\script::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_0 = self.owner;
  self waittill("_encstr_860808CB78E2984063BA", var_1);
  thread scripts\mp\equipment\concussion_grenade::_id_12031(var_0, var_1);
}

smokegrenadeused(var_0) {
  thread scripts\mp\utility\script::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_BDF90C4D10A95F47E990CAF2D83B");
  self endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");

  if(istrue(var_0)) {
    self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_5, var_1, var_2, var_3, var_4, var_6);
    thread _id_13426(var_5);
    thread scripts\mp\bots\bots::init_leave_cave(var_5);
  } else
    self waittill("_encstr_860808CB78E2984063BA", var_5);

  thread smokegrenadeexplode(var_5);
  thread sfx_smoke_grenade_smoke(var_5);

  if(isDefined(self.owner))
    self.owner thread monitorsmokeactive();
}

sfx_smoke_grenade_smoke(var_0) {
  wait 0.2;
  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", var_0);
  var_1 playLoopSound("_encstr_8618179BB5B7ADB2BECE4ECA37C22395FA37B67BD659AFD80E");
  var_1 scripts\cp_mp\ent_manager::registerspawncount(1);
  wait 5.25;
  thread scripts\engine\utility::play_sound_in_space("_encstr_8CF1199B2FF7F85B795F46C5F57291E11FFF4868AF953621A2C4B1", var_0);
  wait 0.3;
  var_1 scripts\cp_mp\ent_manager::deregisterspawn();
  var_1 stoploopsound();
  var_1 delete();
}

smokegrenadeexplode(var_0) {
  wait 1;
  thread smokegrenadegiveblindeye(var_0);
  var_1 = scripts\mp\utility\outline::addoutlineoccluder(var_0, 330);
  wait 8.25;
  scripts\mp\utility\outline::removeoutlineoccluder(var_1);
}

_id_13426(var_0, var_1) {
  playFX(scripts\engine\utility::getfx("_encstr_AA7608ECD89B6BDE5B59"), var_0, anglestoup((0, 90, 0)));
}

smokegrenadegiveblindeye(var_0) {
  var_1 = spawnStruct();
  var_1.blindeyerecipients = [];
  smokegrenademonitorblindeyerecipients(var_1, var_0);

  foreach(var_3 in var_1.blindeyerecipients) {
    if(isDefined(var_3) && scripts\mp\utility\player::isreallyalive(var_3))
      var_3 scripts\mp\utility\perk::removeperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7");
  }
}

smokegrenademonitorblindeyerecipients(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = gettime() + 8250.0;
  var_3 = [];

  while(gettime() < var_2) {
    var_3 = scripts\mp\utility\player::getplayersinradius(var_1, 330);

    foreach(var_7, var_5 in var_0.blindeyerecipients) {
      if(!isDefined(var_5)) {
        var_0.blindeyerecipients[var_7] = undefined;
        continue;
      }

      var_6 = scripts\engine\utility::array_find(var_3, var_5);

      if(!isDefined(var_6) || !scripts\mp\utility\player::isreallyalive(var_5)) {
        if(var_5 scripts\mp\utility\perk::_hasperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7"))
          var_5 scripts\mp\utility\perk::removeperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7");

        var_0.blindeyerecipients[var_7] = undefined;
      }

      if(isDefined(var_6))
        var_3[var_6] = undefined;
    }

    foreach(var_9 in var_3) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_9.lastinsmoketime = gettime();

      if(isDefined(var_0.blindeyerecipients[var_9 getentitynumber()])) {
        continue;
      }
      if(!scripts\mp\utility\player::isreallyalive(var_9) || scripts\mp\utility\entity::isspidergrenade(var_9)) {
        continue;
      }
      var_9 scripts\mp\utility\perk::giveperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7");
      var_0.blindeyerecipients[var_9 getentitynumber()] = var_9;
    }

    waitframe();
  }
}

monitorsmokeactive() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_8ED415B977C0FF40574A9F7AF81F8F21162DB26BD79ADE");
  self endon("_encstr_8ED415B977C0FF40574A9F7AF81F8F21162DB26BD79ADE");
  scripts\mp\utility\print::printgameaction("_encstr_9A7518B95BBDDA95103BC956E6C2C859100BD8D14BCE2C47CA46", self);
  self.hasactivesmokegrenade = 1;
  var_0 = scripts\engine\utility::_id_143B9(9.25, "_encstr_AD75063D571AE108");
  self.hasactivesmokegrenade = 0;
  scripts\mp\utility\print::printgameaction("_encstr_A13E1A9BDADEB595023B3995B985195602232B161B8ED23B0B1DAC46", self);
}

lockonlaunchers_gettargetarray(var_0) {
  var_1 = [];
  var_2 = 0;
  var_3 = lockonlaunchers_gettargetvehiclerefs();

  if(level.teambased) {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_5 in level.characters) {
        if(isDefined(var_5) && isalive(var_5) && (var_5.team != self.team || var_2))
          var_1[var_1.size] = var_5;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var_8 in level.activekillstreaks) {
        if(isDefined(var_8) && isDefined(var_8.affectedbylockon) && (var_8.team != self.team || var_2))
          var_1[var_1.size] = var_8;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(var_11 in level.cratedropdata.ac130s) {
          if(isDefined(var_11) && (var_11.team != self.team || var_2))
            var_1[var_1.size] = var_11;
        }
      }
    }

    foreach(var_14 in var_3) {
      var_15 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var_14);

      foreach(var_17 in var_15) {
        if(isDefined(var_17) && (!scripts\cp_mp\vehicles\vehicle::_id_141B9(var_17, self) || var_2))
          var_1[var_1.size] = var_17;
      }
    }
  } else {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_5 in level.characters) {
        if((!isDefined(var_5) || !isalive(var_5)) && !var_2) {
          continue;
        }
        var_1[var_1.size] = var_5;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var_8 in level.activekillstreaks) {
        if(isDefined(var_8.affectedbylockon) && (isDefined(var_8.owner) && var_8.owner != self || var_2))
          var_1[var_1.size] = var_8;
      }
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(var_11 in level.cratedropdata.ac130s) {
          if(var_11.owner != self || var_2)
            var_1[var_1.size] = var_11;
        }
      }
    }

    foreach(var_14 in var_3) {
      var_15 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances(var_14);

      foreach(var_17 in var_15) {
        if(!isDefined(var_17.owner)) {
          var_1[var_1.size] = var_17;
          continue;
        }

        if(var_17.owner != self || var_2)
          var_1[var_1.size] = var_17;
      }
    }
  }

  return var_1;
}

lockonlaunchers_gettargetvehiclerefs() {
  var_0 = ["_encstr_86510C82737817CD40B38B720A15", "_encstr_8C190467402B", "_encstr_8AD40926E431B1C07B0EB3", "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_8FE608B268BFF756987D", "_encstr_91CD07D045CF0B0BB8", "_encstr_8BAA0D68183D43A35319057A93B767", "_encstr_85DE05A6B2AC0E", "_encstr_9BDA108D0BC976CAF5A34E16DCCD83B7278E", "_encstr_AF390B295782C3585F1B21D8C4", "_encstr_9A8F0CB1A5E8471BB2EB894B39C8", "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_84D70A6B2BEF3C9B30A67164", "_encstr_911904464232", "_encstr_A7B30DE187CA05B92B54B8537A15E8", "_encstr_99C20BA548E9F27A61D897932B", "_encstr_BDC80A5437EAD749519A6068", "_encstr_83F40783ADF1D14AA3", "_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3"];

  if(isDefined(level.playerzombieupdatetagobjectives))
    var_0 = level.playerzombieupdatetagobjectives;

  return var_0;
}

watchmissileusage() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    var_0 = waittill_missile_fire();
    updatemissilefire(var_0);
  }
}

updatemissilefire(var_0) {
  var_1 = undefined;
  var_2 = 0;

  switch (var_0.weapon_name) {
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
    case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
      var_1 = self.missilelaunchertarget;
      level thread scripts\mp\battlechatter_mp::watchbrsquadleaderdisconnect(var_0);
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_A2040BC8533FD723CF1BCA35E4", undefined, 0.5);
      break;
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      var_1 = self.javelin.target;
      level thread scripts\mp\battlechatter_mp::javelinfired(self.team, self.javelin.target.origin);
      level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_A2040BC8533FD723CF1BCA35E4", undefined, 0.5);
      break;
    case "_encstr_8A07035972":
      var_2 = 1;
      break;
    case "_encstr_AA7608ECD89B6BDE5B59":
      var_2 = 1;
      var_0 thread smokegrenadeused(1);
      break;
    case "_encstr_97D506F770BFFFBB":
      var_2 = 1;
      thread scripts\mp\equipment\gas_grenade::gas_used(var_0);
      break;
    case "_encstr_873708FFA8104C0AAEC1":
    case "_encstr_ADBD0780C4884FEE86":
      var_2 = 1;
      break;
    case "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5":
      var_2 = 1;
      var_0 thread scripts\mp\shellshock::grenade_earthquake();
      thread scripts\mp\equipment\thermite::thermite_used(var_0, 1);
      break;
    case "_encstr_A78B09ECB16E2B5B47590F":
      var_2 = 1;
      break;
    case "_encstr_8435070CAC0F080BD2":
      var_2 = 1;
      thread scripts\mp\equipment\snapshot_grenade::snapshot_grenade_used(var_0, var_2);
      break;
    default:
      break;
  }

  if(scripts\cp_mp\utility\weapon_utility::islockonlauncher(var_0.weapon_name) && isDefined(var_1)) {
    var_0._id_119A0 = var_1;
    level notify("_encstr_A1B90EC33B80328870DB219DE446B39B", self, var_0, var_1);
    thread scripts\cp_mp\utility\weapon_utility::watchtargetlockedontobyprojectile(var_1, var_0);
  }

  if(isPlayer(self))
    var_0.adsfire = scripts\mp\utility\player::isplayerads();

  if(!var_2 && isexplosivemissile(var_0.weapon_name)) {
    var_3 = 1.0;

    if(issmallmissile(var_0.weapon_name))
      var_3 = 0.65;

    var_0 thread scripts\mp\shellshock::grenade_earthquake(var_3);
  }

  scripts\mp\events::missilefired(var_0);
}

issmallmissile(var_0) {
  return 0;
}

isexplosivemissile(var_0) {
  var_1 = getweaponbasename(var_0);

  switch (var_1) {
    case "_encstr_A9DA131AB0E9F962F81B8FBF90D63873BF5AA9D5A7":
    case "_encstr_88F90EF65F8E7A1AEED5251AE97F9788":
    case "_encstr_88710EC26CC49918FA1A815BB5AFADC1":
    case "_encstr_A7BC0FA2A8D3626A4E07A8A531D00F3DB9":
      return 0;
  }

  return 1;
}

movingplatformdetonate(var_0) {
  if(!isDefined(var_0.lasttouchedplatform) || !isDefined(var_0.lasttouchedplatform.destroyexplosiveoncollision) || var_0.lasttouchedplatform.destroyexplosiveoncollision)
    self notify("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B");
}

monitordisownedequipment(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 notify("_encstr_9A011BE8721D5B032FEABD13C3072B0D87AAD1804B74A1F8FFEEADBBE1");
  var_1 endon("_encstr_9A011BE8721D5B032FEABD13C3072B0D87AAD1804B74A1F8FFEEADBBE1");

  if(istrue(var_2))
    var_0 scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_8D820B49520F0EC02DDE6367EC");
  else
    var_0 scripts\engine\utility::_id_143A6("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", "_encstr_8D820B49520F0EC02DDE6367EC");

  var_1 deleteexplosive();
}

monitordisownedgrenade(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_88120D27D858FD694191F62D850392");
  scripts\engine\utility::waittill_any_ents(var_0, "_encstr_81170C244F9CBDE72C01BB99A298", var_0, "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", var_0, "_encstr_8D820B49520F0EC02DDE6367EC", level, "_encstr_AD9F1168238D48239B0EFB68667263B1FE57F0");

  if(isDefined(var_1))
    var_1 delete();
}

isplantedequipment(var_0) {
  return isDefined(level.mines[var_0 getentitynumber()]) || istrue(var_0.planted);
}

getmaxplantedlethalequip(var_0) {
  var_1 = 2;

  if(scripts\mp\utility\perk::_hasperk("_encstr_B4D722B907ACB1B4C28DA3CBFA950FD193C2BE831B2CCDD1B291EBCA5CEAA5076B569B1D"))
    var_1++;

  return var_1;
}

getmaxplantedtacticalequip(var_0) {
  var_1 = 2;

  if(scripts\mp\utility\perk::_hasperk("_encstr_B4D722B907ACB1B4C28DA3CBFA950FD193C2BE831B2CCDD1B291EBCA5CEAA5076B569B1D"))
    var_1++;

  return var_1;
}

getmaxplantedsuperequip(var_0) {
  return 1;
}

getmaxplantedhackedequip() {
  return 3;
}

onequipmentplanted(var_0, var_1, var_2) {
  var_0.equipmentref = var_1;
  var_0.deletefunc = var_2;
  var_0.planted = 1;
  updateplantedarray(var_0);
  var_3 = var_0 getentitynumber();
  level.mines[var_3] = var_0;

  if(var_1 != "_encstr_867010E842EB0B29AF8B8886074E3F2CB506") {
    var_0 enableplayermarks("_encstr_BE8F0A272F9B2BE97268AE8B");

    if(level.teambased)
      var_0 filteroutplayermarks(self.team);
    else
      var_0 filteroutplayermarks(self);
  }

  var_0 notify("_encstr_88120D27D858FD694191F62D850392");
}

updateplantedarray(var_0) {
  var_1 = undefined;
  var_2 = 0;
  var_3 = scripts\mp\equipment::findequipmentslot(var_0.equipmentref);

  if(istrue(var_0.ishacked)) {
    var_1 = var_0.owner.plantedhackedequip;
    var_2 = getmaxplantedhackedequip();
  } else if(istrue(var_0.issuper)) {
    var_1 = var_0.owner.plantedsuperequip;
    var_2 = getmaxplantedsuperequip(var_0.equipmentref);
  } else if(isDefined(var_3) && var_3 == "_encstr_BA7F0830B3A7859B60B0" || scripts\mp\equipment::isequipmentlethal(var_0.equipmentref)) {
    var_1 = var_0.owner.plantedlethalequip;
    var_2 = getmaxplantedlethalequip(self);
  } else if(isDefined(var_3) && var_3 == "_encstr_AC8F0AE74163F85AAA380AD8" || scripts\mp\equipment::isequipmenttactical(var_0.equipmentref)) {
    var_1 = var_0.owner.plantedtacticalequip;
    var_2 = getmaxplantedtacticalequip(self);
  }

  if(!isDefined(var_1)) {
    var_4 = "_encstr_A52E0A709BEAFB70C5EEB286" + var_0.issuper + "_encstr_9208093C1F63BBDDE92AF6" + scripts\engine\utility::ter_op(isDefined(var_3), var_3, "_encstr_8C500ABA9B23CACC2D37AC8C") + "_encstr_9A991162E11F92BBB4F745F3D529D950B67298" + var_0.equipmentref + "_encstr_814E0C3CD98FF9EB77BFC96CDA0A" + scripts\mp\equipment::is_equipment_slot_allowed("_encstr_BEB406F03B72BB3B");
    scripts\mp\utility\script::laststand_dogtags(var_4);
  }

  if(var_1.size > 0) {
    if(var_1.size && var_1.size >= var_2) {
      var_5 = var_1[0];
      var_1 = scripts\engine\utility::array_remove(var_1, var_5);
      var_5 deleteexplosive();
    }
  }

  var_1[var_1.size] = var_0;

  if(istrue(var_0.ishacked))
    var_0.owner.plantedhackedequip = var_1;
  else if(istrue(var_0.issuper))
    var_0.owner.plantedsuperequip = var_1;
  else if(isDefined(var_3) && var_3 == "_encstr_BA7F0830B3A7859B60B0" || scripts\mp\equipment::isequipmentlethal(var_0.equipmentref))
    var_0.owner.plantedlethalequip = var_1;
  else if(isDefined(var_3) && var_3 == "_encstr_AC8F0AE74163F85AAA380AD8" || scripts\mp\equipment::isequipmenttactical(var_0.equipmentref))
    var_0.owner.plantedtacticalequip = var_1;
}

setplantedequipmentuse(var_0) {
  var_1 = getallequip();

  foreach(var_3 in var_1) {
    if(isDefined(var_3.trigger) && isDefined(var_3.owner)) {
      if(var_0) {
        var_3.trigger enableplayeruse(var_3.owner);
        continue;
      }

      var_3.trigger disableplayeruse(var_3.owner);
    }
  }
}

cleanupequipment(var_0, var_1, var_2) {
  if(isDefined(var_0))
    level.mines[var_0] = undefined;

  if(isDefined(var_1))
    var_1 delete();

  if(isDefined(var_2))
    var_2 delete();
}

equipmenthit(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\player_utility::playersareenemies(var_1, var_0)) {
    if(!isDefined(var_2)) {
      return;
    }
    if(scripts\mp\utility\weapon::iskillstreakweapon(var_2.basename)) {
      return;
    }
    var_4 = createheadicon(var_2);

    if(!isDefined(var_1.lasthittime))
      var_1.lasthittime = [];

    if(!isDefined(var_1.lasthittime[var_4]))
      var_1.lasthittime[var_4] = 0;

    if(var_1.lasthittime[var_4] == gettime()) {
      return;
    }
    var_1.lasthittime[var_4] = gettime();
    var_1 thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_4, 1, "_encstr_88CC0521F3A13B");

    if(scripts\mp\utility\game::onlinestatsenabled()) {
      var_5 = var_1 scripts\mp\playerstats_interface::getplayerstat("_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_972C0B3AF63A8563A6D07B3ADC");
      var_6 = var_1 scripts\mp\playerstats_interface::getplayerstat("_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B") + 1;

      if(var_6 <= var_5) {
        scripts\mp\playerstats_interface::setplayerstatbuffered(var_6, "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_88CC0521F3A13B");
        scripts\mp\playerstats_interface::setplayerstatbuffered(int(var_5 - var_6), "_encstr_9BBC0C0BB76BF6F74D17C39A1B26", "_encstr_8EDA07FF229707BB77");
      }
    }

    if(isDefined(var_3) && scripts\engine\utility::isbulletdamage(var_3) || scripts\mp\utility\damage::isprojectiledamage(var_3)) {
      var_1.lastdamagetime = gettime();
      var_7 = scripts\mp\utility\weapon::getweapongroup(var_2.basename);

      if(var_7 == "_encstr_A3710BEEACC2E0B737EB36B676") {
        if(!isDefined(var_1.shotslandedlmg))
          var_1.shotslandedlmg = 1;
        else
          var_1.shotslandedlmg++;
      }
    }
  }
}

deleteexplosive() {
  if(!isDefined(self)) {
    return;
  }
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  var_0 = self getentitynumber();
  level.mines[var_0] = undefined;
  self disableplayermarks("_encstr_BE8F0A272F9B2BE97268AE8B");

  if(isDefined(self.deletefunc)) {
    self thread[[self.deletefunc]]();
    self notify("_encstr_829012BF09C0C5DB2559F7179BD5F2282091B503");
  } else {
    var_1 = self.killcament;
    var_2 = self.trigger;
    cleanupequipment(var_0, var_1, var_2);
    self notify("_encstr_829012BF09C0C5DB2559F7179BD5F2282091B503");
    self delete();
  }
}

makeexplosiveusable(var_0) {
  self setotherent(self.owner);

  if(!isDefined(var_0))
    var_0 = 10;

  var_1 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin + var_0 * anglestoup(self.angles));
  var_1 linkTo(self);
  self.trigger = var_1;
  var_1.owner = self;
  thread makeexplosiveusableinternal();
  return var_1;
}

makeexplosiveusableinternal() {
  self endon("_encstr_8EAF167AA07FFFB792AFFCE7C658B307FB30631318C5F54F");
  var_0 = self.trigger;
  watchexplosiveusable();

  if(isDefined(self)) {
    var_0 = self.trigger;
    self.trigger = undefined;
  }

  if(isDefined(var_0))
    var_0 delete();
}

makeexplosiveunusable() {
  self notify("_encstr_8EAF167AA07FFFB792AFFCE7C658B307FB30631318C5F54F");
  var_0 = self.trigger;
  self.trigger = undefined;

  if(isDefined(var_0))
    var_0 delete();
}

watchexplosiveusable() {
  var_0 = self.owner;
  var_1 = self.trigger;
  self endon("_encstr_AD75063D571AE108");
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_1 scripts\mp\utility\usability::setselfusable(var_0);
  var_1 childthread scripts\mp\utility\usability::notusableforjoiningplayers(var_0);
  var_1 childthread scripts\mp\utility\usability::notusableafterownerchange(var_0, self);
  var_1 setexplosiveusablehintstring(self.weapon_name);

  for(;;) {
    var_1 waittillmatch("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isDefined(self.weapon_name)) {
      switch (self.weapon_name) {
        case "_encstr_92EA0A290B32FF88A90170EB":
          thread scripts\mp\equipment\trophy_system::trophy_pickup();
          break;
      }

      var_0 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    var_0 playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");
    var_0 notify("_encstr_A6790F2B71AFFB7F58FF5D24F75805DFC0", self.weapon_name);
    var_2 = scripts\mp\equipment::getequipmentreffromweapon(getcompleteweaponname(self.weapon_name));

    if(isDefined(var_2) && self.owner scripts\mp\equipment::hasequipment(var_2))
      self.owner scripts\mp\equipment::incrementequipmentammo(var_2, 1);

    thread deleteexplosive();
    return;
  }
}

makeexplosiveusabletag(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8EAF167AA07FFFB792AFFCE7C658B307FB30631318C5F54F");
  var_2 = self.owner;
  var_3 = self.weapon_name;

  if(!isDefined(var_1))
    var_1 = 0;

  if(var_1)
    self enablemissilehint(1);
  else
    self setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");

  self sethinttag(var_0);
  self setuserange(72);
  setexplosiveusablehintstring(self.weapon_name);
  scripts\mp\utility\usability::setselfusable(var_2);
  childthread scripts\mp\utility\usability::notusableforjoiningplayers(var_2);
  childthread scripts\mp\utility\usability::notusableafterownerchange(var_2, self);

  for(;;) {
    self waittillmatch("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(istrue(var_2.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_A9C1255A923189D445A45405D2D4E594AA1D1DFA0D05E439A72AEB8454D7A0A40D691522AFAA0A");

      continue;
    }

    if(isDefined(var_3)) {
      switch (var_3) {
        case "_encstr_92EA0A290B32FF88A90170EB":
          thread scripts\mp\equipment\trophy_system::trophy_pickup();
          break;
        case "_encstr_835611C8951BF6CDEB37D1851DD27BB9D7B6E0":
          thread _debug_rooftop_heli_start::jugg_health_debug();
      }

      var_2 thread scripts\mp\equipment\c4::c4_resetaltdetonpickup();
    }

    var_2 playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");
    var_2 notify("_encstr_A6790F2B71AFFB7F58FF5D24F75805DFC0", var_3);
    var_4 = scripts\mp\equipment::getequipmentreffromweapon(getcompleteweaponname(var_3));

    if(isDefined(var_4)) {
      if(self.owner scripts\mp\equipment::hasequipment(var_4))
        self.owner scripts\mp\equipment::incrementequipmentammo(var_4, 1);
      else if(isDefined(level._id_1205C))
        [[level._id_1205C]](self.owner, var_4);
    }

    if(isDefined(self.useobj))
      self.useobj delete();

    thread deleteexplosive();
    return;
  }
}

makeexplosiveunusuabletag() {
  self notify("_encstr_8EAF167AA07FFFB792AFFCE7C658B307FB30631318C5F54F");
  self makeunusable();
}

setexplosiveusablehintstring(var_0) {
  switch (var_0) {
    case "_encstr_9AAE0876FCB7603101DB":
      self setHintString(&"_encstr_BDCD1AA245AA920A5354722AD742A472A2A9BC41941AD2AA41BE8643");
      break;
    case "_encstr_81430B218B3F7018458997D78A":
      self setHintString(&"_encstr_A7691F152A55A40A9A5439157D4252C9A2359782943469AA82AF28A2F553A4398A");
      break;
    case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
      self setHintString(&"_encstr_99E92015CFA3B8518D0530C597A13878519F58F859DFA0476931A39C21762B8F42A5");
      break;
    case "_encstr_83B20F81360389C45B1755530BF2AFD0B8":
      self setHintString(&"_encstr_993B23A88A55A40A532A932ABE2492C9A86A970AA41A695528F5A3A0A6AF8E92152714118A");
      break;
    case "_encstr_92EA0A290B32FF88A90170EB":
      self setHintString(&"_encstr_B6AC1E512AAA9282D4A23951D7425293A2A6792852D09655A0FA2A253D2812CA");
      break;
  }
}

explosivehandlemovers(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.linkparent = var_0;
  var_2.deathoverridecallback = ::movingplatformdetonate;
  var_2.endonstring = "_encstr_AD75063D571AE108";

  if(_calloutmarkerping_handleluinotify_enemyrepinged::tugofwar_tank(var_0)) {
    var_2._id_123B4 = 1;
    self _meth_87BB(1);
  }

  if(!isDefined(var_1) || !var_1)
    var_2.invalidparentoverridecallback = scripts\mp\movers::moving_platform_empty_func;

  thread scripts\mp\movers::handle_moving_platforms(var_2);
}

explosivetrigger(var_0, var_1, var_2) {
  if(isPlayer(var_0) && var_0 scripts\mp\utility\perk::_hasperk("_encstr_9AE514B0EB4D49F30A0D35BB29B22350B127D8E82BE5")) {
    var_0 thread scripts\cp\vehicles\vehicle_compass_cp::triggereddelayedexplosion();
    var_1 = level.delayminetime;
  }

  wait(var_1);
}

getdamageableents(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_5 = var_1 * var_1;
  var_6 = level.players;

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    if(!isalive(var_6[var_7]) || var_6[var_7].sessionstate != "_encstr_877508C1D8C22F2DDC3B") {
      continue;
    }
    var_8 = scripts\mp\utility\damage::get_damageable_player_pos(var_6[var_7]);
    var_9 = distancesquared(var_0, var_8);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_8, var_3, var_6[var_7])))
      var_4[var_4.size] = scripts\mp\utility\damage::get_damageable_player(var_6[var_7], var_8);
  }

  var_10 = getEntArray("_encstr_8C8D08671D451291C849", "_encstr_AC110A7F14873B5B3D073009");

  for(var_7 = 0; var_7 < var_10.size; var_7++) {
    var_11 = scripts\mp\utility\damage::get_damageable_grenade_pos(var_10[var_7]);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_10[var_7])))
      var_4[var_4.size] = scripts\mp\utility\damage::get_damageable_grenade(var_10[var_7], var_11);
  }

  var_12 = getEntArray("_encstr_A6460DC8CADC8E4EAB8D3AA5C46356", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_7 = 0; var_7 < var_12.size; var_7++) {
    var_11 = var_12[var_7].origin;
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_12[var_7]))) {
      var_13 = spawnStruct();
      var_13.isplayer = 0;
      var_13.isadestructable = 0;
      var_13.entity = var_12[var_7];
      var_13.damagecenter = var_11;
      var_4[var_4.size] = var_13;
    }
  }

  var_14 = getEntArray("_encstr_A6040DE8D943BB96574093B7B1DACB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_7 = 0; var_7 < var_14.size; var_7++) {
    var_11 = var_14[var_7].origin;
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_14[var_7]))) {
      var_13 = spawnStruct();
      var_13.isplayer = 0;
      var_13.isadestructable = 1;
      var_13.entity = var_14[var_7];
      var_13.damagecenter = var_11;
      var_4[var_4.size] = var_13;
    }
  }

  var_15 = getEntArray("_encstr_97710C6B2DCD1BAF3AD54E4E598E", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_17 in var_15) {
    var_11 = var_17.origin + (0, 0, 32);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_17))) {
      switch (var_17.model) {
        case "_encstr_84BA19688AC433895B9558456FCBF6C16E822810815F7360BFB5D7":
        case "_encstr_A99313CB60D990B6CBEA58A1224F6060EBDA7D430C":
        case "_encstr_AB1F0EF7A1900B5958C63B435B9865B3":
        case "_encstr_BA80142851BBC3BD3839F083AD50B88BB3EFDF577332":
          var_4[var_4.size] = scripts\mp\utility\damage::get_damageable_sentry(var_17, var_11);
          break;
      }
    }
  }

  var_19 = getEntArray("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_21 in var_19) {
    if(var_21.model != "_encstr_99F4220E4EBD53568D8E4BB1CA7D267BBA738D5A37CEF54C593A8EBC7DEC4E2BDCC2232B" && var_21.model != "_encstr_9130125AAD9BAFDC36DBE4E0A5DE73EB987B8CE5") {
      continue;
    }
    var_11 = var_21.origin + (0, 0, 32);
    var_9 = distancesquared(var_0, var_11);

    if(var_9 < var_5 && (!var_2 || weapondamagetracepassed(var_0, var_11, var_3, var_21)))
      var_4[var_4.size] = scripts\mp\utility\damage::get_damageable_mine(var_21, var_11);
  }

  return var_4;
}

weapondamagetracepassed(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = var_1 - var_0;

  if(lengthsquared(var_5) < var_2 * var_2)
    return 1;

  var_6 = vectorNormalize(var_5);
  var_4 = var_0 + (var_6[0] * var_2, var_6[1] * var_2, var_6[2] * var_2);
  var_7 = scripts\engine\trace::_bullet_trace(var_4, var_1, 0, var_3);

  if(getdvarint("_encstr_A714119F481B071AA3D136AFCD37D2C5E11057") != 0 || getdvarint("_encstr_86550F7E1EE37F31DD3BAB98AFF948B35B") != 0) {
    thread debugprint(var_0, "_encstr_8AA70538E76D38");

    if(isDefined(var_3))
      thread debugprint(var_1, "_encstr_BD4C024E" + var_3.classname);
    else
      thread debugprint(var_1, "_encstr_8A840B654DAD109DB3B2D0B94A");

    if(var_7["_encstr_A53009A25003666B9818C6"] == 1)
      thread debugline(var_4, var_1, (1, 1, 1));
    else {
      thread debugline(var_4, var_7["_encstr_BD260953AA97E3F014279D"], (1, 0.9, 0.8));
      thread debugline(var_7["_encstr_BD260953AA97E3F014279D"], var_1, (1, 0.4, 0.3));
    }
  }

  return var_7["_encstr_A53009A25003666B9818C6"] == 1;
}

damageent(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self.isplayer) {
    self.damageorigin = var_5;
    self.entity thread[[level.callbackplayerdamage]](var_0, var_1, var_2, 0, var_3, var_4, var_5, var_6, "_encstr_8BBA05185F8B99", 0);
  } else {
    if(self.isadestructable && (var_4.basename == "_encstr_A2950D16C9E8D2361B59932FF55BC1" || var_4.basename == "_encstr_ACC40CC1F8A321601715CFBFE0EA" || var_4.basename == "_encstr_B4171008D3CF5B1073C0AF86AF7F995FB5FB")) {
      return;
    }
    self.entity notify("_encstr_B2BE0788BAF573592F", var_2, var_1, (0, 0, 0), (0, 0, 0), "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_B40101", "_encstr_B40101", "_encstr_B40101", undefined, var_4);
  }
}

debugline(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < 600; var_3++)
    wait 0.05;
}

debugcircle(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 16;

  var_4 = 360 / var_3;
  var_5 = [];

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_4 * var_6;
    var_8 = cos(var_7) * var_1;
    var_9 = sin(var_7) * var_1;
    var_10 = var_0[0] + var_8;
    var_11 = var_0[1] + var_9;
    var_12 = var_0[2];
    var_5[var_5.size] = (var_10, var_11, var_12);
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    var_13 = var_5[var_6];

    if(var_6 + 1 >= var_5.size)
      var_14 = var_5[0];
    else
      var_14 = var_5[var_6 + 1];

    thread debugline(var_13, var_14, var_2);
  }
}

debugprint(var_0, var_1) {
  for(var_2 = 0; var_2 < 600; var_2++)
    wait 0.05;
}

onweapondamage(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    return;
  }
  switch (var_1.basename) {
    case "_encstr_A3DA1116382CC6D056BE8EAE27E42BA3AFB583":
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
    case "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B":
    case "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898":
    case "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1":
    case "_encstr_BA730BF8AFF178988293F158B9":
      break;
    case "_encstr_99410C4B48C39AB7D0CD95B769DB":
      scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_99410C4B48C39AB7D0CD95B769DB", "_encstr_8E440A950FE01BB76E96BDE6", 0.5);
      break;
    case "_encstr_9AAE0876FCB7603101DB":
    case "_encstr_92A70ABB8267F5E0D89F6351":
    case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
      scripts\cp_mp\utility\shellshock_utility::_shellshock("_encstr_8C4A10BA936F7F31D0159D6ECB304757814B", "_encstr_8E440A950FE01BB76E96BDE6", 0.5);
      break;
    default:
      scripts\mp\shellshock::shellshockondamage(var_2, var_3);
      break;
  }
}

updatelastweapon() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self.lastnormalweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  self.lastcacweaponobj = scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj) && scripts\mp\utility\weapon::iscacprimaryorsecondary(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon());
  _id_1316B(scripts\engine\utility::ter_op(isDefined(self.spawnweaponobj), self.spawnweaponobj, isundefinedweapon()));

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_0);
    self.lastweaponobj = var_0;

    if(isnormallastweapon(var_0))
      self.lastnormalweaponobj = var_0;

    if(isdroppableweapon(var_0))
      _id_1316B(var_0);

    if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var_0))
      self.lastcacweaponobj = var_0;
  }
}

isnormallastweapon(var_0) {
  if(var_0.basename == "_encstr_8BBA05185F8B99")
    return 0;

  if(var_0.classname == "_encstr_A7AF07D1EF1B06683C")
    return 0;

  if(scripts\mp\utility\weapon::issuperweapon(var_0.basename))
    return 0;

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0.basename))
    return 0;

  if(scripts\mp\utility\weapon::isspecialmeleeweapon(var_0))
    return 0;

  if(var_0.inventorytype != "_encstr_BA7F0830B3A7859B60B0" && var_0.inventorytype != "_encstr_B4DC085639F9C2779108")
    return 0;

  return 1;
}

isdroppableweapon(var_0) {
  if(var_0.basename == "_encstr_8BBA05185F8B99")
    return 0;

  if(isfistweapon(var_0.basename))
    return 0;

  if(isbombplantweapon(var_0.basename))
    return 0;

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0.basename))
    return 0;

  if(scripts\mp\utility\weapon::issuperweapon(var_0.basename))
    return 0;

  if(var_0.inventorytype != "_encstr_BA7F0830B3A7859B60B0")
    return 0;

  if(var_0.classname == "_encstr_A7AF07D1EF1B06683C")
    return 0;

  if(!scripts\mp\utility\weapon::iscacprimaryweapon(var_0.basename) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var_0.basename))
    return 0;

  return 1;
}

updatemovespeedonweaponchange() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_0);

    if(var_0.basename == "_encstr_8BBA05185F8B99")
      continue;
    else if(scripts\mp\utility\weapon::issuperweapon(var_0.basename)) {
      updatemovespeedscale();
      continue;
    } else if(scripts\mp\utility\weapon::iskillstreakweapon(var_0.basename))
      continue;
    else if(var_0.basename == "_encstr_A393109FCF38E936DA97CCE3177050314CB8") {
      updatemovespeedscale();
      continue;
    } else if(var_0.inventorytype != "_encstr_BA7F0830B3A7859B60B0" && var_0.inventorytype != "_encstr_B4DC085639F9C2779108") {
      continue;
    }
    updatemovespeedscale();
  }
}

getweaponspeedslowest() {
  var_0 = 2.0;
  self.weaponlist = self getweaponslistprimaries();

  if(self.weaponlist.size) {
    foreach(var_2 in self.weaponlist) {
      if(scripts\mp\utility\weapon::issuperweapon(var_2))
        var_3 = scripts\mp\supers::getmovespeedforsuperweapon(var_2);
      else if(scripts\mp\utility\weapon::isgamemodeweapon(var_2))
        var_3 = getgamemodeweaponspeed(var_2);
      else
        var_3 = getweaponspeed(var_2);

      if(var_3 == 0) {
        continue;
      }
      if(var_3 < var_0)
        var_0 = var_3;
    }
  } else
    var_0 = 0.85;

  var_0 = clampweaponspeed(var_0);
  return var_0;
}

getweaponspeed(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);

  if(!isDefined(var_1) || !isDefined(level.weaponmapdata[var_1]) || !isDefined(level.weaponmapdata[var_1].speed))
    return 1.0;

  return level.weaponmapdata[var_1].speed;
}

getgamemodeweaponspeed(var_0) {
  return 0.93;
}

clampweaponspeed(var_0) {
  return clamp(var_0, 0.0, 1.0);
}

updateviewkickscale(var_0) {
  if(isDefined(var_0))
    self.viewkickscale = var_0;

  var_1 = self getcurrentweapon();

  if(isDefined(self.overchargeviewkickscale))
    var_0 = self.overchargeviewkickscale;
  else if(isDefined(self.overrideviewkickscale)) {
    var_0 = self.overrideviewkickscale;
    var_2 = scripts\mp\utility\weapon::_id_14584(var_1);

    if(var_2 == 1)
      var_0 = self.overrideviewkickscalepistol;
    else if(var_2 == 4)
      var_0 = self._id_1218D;
    else if(var_2 == 2)
      var_0 = self._id_1218E;
    else if(var_2 == 3)
      var_0 = self._id_1218F;
    else if(var_2 == 5)
      var_0 = self.overrideviewkickscalesniper;
  } else if(isDefined(self.viewkickscale))
    var_0 = self.viewkickscale;
  else
    var_0 = 1.0;

  if(weaponclass(var_1) == "_encstr_850707F7E5833355B8" && isDefined(level.debug_unlock_silo) && level.debug_unlock_silo == 1) {
    if(var_1 hasattachment("_encstr_A232125527A28E80B29CC33E4689A84DCABFC1F3", 1) && var_1 hasattachment("_encstr_8DAA0D8EF93398037B57834213B022", 1))
      var_0 = var_0 * 0.7;
    else if(var_1 hasattachment("_encstr_8DAA0D8EF93398037B57834213B022", 1))
      var_0 = var_0 * 0.85;
    else if(var_1 hasattachment("_encstr_A232125527A28E80B29CC33E4689A84DCABFC1F3", 1))
      var_0 = var_0 * 0.8;
    else if(var_1 hasattachment("_encstr_84E20D9A6073F30E28A90415C71815", 1))
      var_0 = var_0 * 0.85;
    else if(var_1 hasattachment("_encstr_9B790AF45F2DB29451F9C7AB", 1))
      var_0 = var_0 * 0.75;
    else if(isDefined(self.viewkickscale))
      var_0 = self.viewkickscale;
    else
      var_0 = 1.0;
  }

  var_0 = clamp(var_0, 0.0, 1.0);
  self setviewkickscale(var_0);
}

updatemovespeedscale() {
  var_0 = undefined;

  if(isDefined(self.playerstreakspeedscale)) {
    var_0 = 1.0;
    var_0 = var_0 + self.playerstreakspeedscale;
  } else {
    var_0 = getplayerspeedbyweapon(self);

    if(isDefined(self.overrideweaponspeed_speedscale))
      var_0 = self.overrideweaponspeed_speedscale;

    var_1 = self.chill_data;

    if(isDefined(var_1) && isDefined(var_1.speedmod))
      var_0 = var_0 + var_1.speedmod;

    if(isDefined(self.gasspeedmod))
      var_0 = var_0 + self.gasspeedmod;

    if(isDefined(self.disabledspeedmod))
      var_0 = var_0 + self.disabledspeedmod;

    if(isDefined(self.speedonkillmod))
      var_0 = var_0 + self.speedonkillmod;

    if(isDefined(self.momentumspeedincrease))
      var_0 = var_0 + self.momentumspeedincrease;
  }

  self.weaponspeed = var_0;

  if(!isDefined(self.combatspeedscalar))
    self.combatspeedscalar = 1;

  var_0 = var_0 + (self.movespeedscaler - 1.0);
  var_0 = var_0 + (self.combatspeedscalar - 1.0);
  var_0 = clamp(var_0, 0.0, 1.08);

  if(isDefined(self.fastcrouchspeedmod))
    var_0 = var_0 + self.fastcrouchspeedmod;

  self setmovespeedscale(var_0);
}

getplayerspeedbyweapon(var_0) {
  var_1 = 1.0;
  self.weaponlist = self getweaponslistprimaries();

  if(!self.weaponlist.size)
    var_1 = 0.85;
  else {
    var_2 = self getcurrentweapon();

    if(!isDefined(var_2))
      var_1 = getweaponspeedslowest();
    else if(scripts\mp\utility\weapon::issuperweapon(var_2.basename))
      var_1 = scripts\mp\supers::getmovespeedforsuperweapon(var_2);
    else if(scripts\mp\utility\weapon::isgamemodeweapon(var_2.basename))
      var_1 = getgamemodeweaponspeed(var_2);
    else if(scripts\mp\utility\weapon::iskillstreakweapon(var_2.basename))
      var_1 = 0.85;
    else if(scripts\mp\utility\weapon::unset_relic_mythic(var_2.basename))
      var_1 = 0.85;
    else {
      if(var_2.inventorytype != "_encstr_BA7F0830B3A7859B60B0" && var_2.inventorytype != "_encstr_B4DC085639F9C2779108" || scripts\mp\utility\weapon::update_health_bar_to_player(var_2)) {
        if(isDefined(self.lastnormalweaponobj))
          var_2 = self.lastnormalweaponobj;
        else
          var_2 = undefined;
      }

      if(!self hasweapon(var_2))
        var_1 = getweaponspeedslowest();
      else
        var_1 = getweaponspeed(var_2);
    }
  }

  var_1 = clampweaponspeed(var_1);
  return var_1;
}

stancerecoiladjuster() {
  if(!isPlayer(self)) {
    return;
  }
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_A6E308B2DCE8B0B936B2");
  self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_B44609DFE7078F394E1651");

  if(!self isconsoleplayer() && !isai(self)) {
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_B1680E47C3E2A4204C7F417BE53D486B");
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_A38B0C43A0B047C20783E360451D");
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_ACF70A27C7824C50E45D6358");
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_92700A11DD726DD11CCFD010");
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_A75407A4F05EE24E57");
    self notifyonplayercommand("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_AA1207A507C9B7732B");
  }

  for(;;) {
    scripts\engine\utility::_id_143A6("_encstr_82EE0F816D2233A3C06BCD7214775D361D", "_encstr_9A1A0D9B0E395ADC47AF98B2CEA59B", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
    wait 0.5;
    var_0 = self getstance();
    stancerecoilupdate(var_0);
  }
}

stancerecoilupdate(var_0) {
  var_1 = self getcurrentprimaryweapon();
  var_2 = 0;

  if(isrecoilreducingweapon(var_1))
    var_2 = getrecoilreductionvalue();

  if(var_0 == "_encstr_922406F1A6FD5E05") {
    var_3 = scripts\mp\utility\weapon::getweapongroup(var_1);

    if(var_3 == "_encstr_A3710BEEACC2E0B737EB36B676") {
      scripts\mp\utility\weapon::setrecoilscale(0, 0);
      return;
    }

    if(var_3 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33") {
      if(var_1 hasattachment("_encstr_82820C411AC33E28E59A2F0D85CF", 1)) {
        scripts\mp\utility\weapon::setrecoilscale(0, 0 + var_2);
        return;
      }

      scripts\mp\utility\weapon::setrecoilscale(0, 0 + var_2);
      return;
      return;
    }

    scripts\mp\utility\weapon::setrecoilscale();
    return;
    return;
  } else if(var_0 == "_encstr_B13D076BED70539F23") {
    var_3 = scripts\mp\utility\weapon::getweapongroup(var_1);

    if(var_3 == "_encstr_A3710BEEACC2E0B737EB36B676") {
      scripts\mp\utility\weapon::setrecoilscale(0, 0);
      return;
    }

    if(var_3 == "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33") {
      if(var_1 hasattachment("_encstr_82820C411AC33E28E59A2F0D85CF", 1)) {
        scripts\mp\utility\weapon::setrecoilscale(0, 0 + var_2);
        return;
      }

      scripts\mp\utility\weapon::setrecoilscale(0, 0 + var_2);
      return;
      return;
    }

    scripts\mp\utility\weapon::setrecoilscale();
    return;
    return;
  } else if(var_2 > 0)
    scripts\mp\utility\weapon::setrecoilscale(0, var_2);
  else
    scripts\mp\utility\weapon::setrecoilscale();
}

deleteallgrenades() {
  if(isDefined(level.grenades)) {
    foreach(var_1 in level.grenades) {
      if(isDefined(var_1) && !istrue(var_1.exploding) && !isplantedequipment(var_1))
        var_1 delete();
    }
  }

  if(isDefined(level.missiles)) {
    foreach(var_4 in level.missiles) {
      if(isDefined(var_4) && !istrue(var_4.exploding) && !isplantedequipment(var_4))
        var_4 delete();
    }
  }
}

minegettwohitthreshold() {
  return 80;
}

minedamagemonitor() {
  self endon("_encstr_975012ADB49B2BAFE695B1CC46B2CDD127EAD83A");
  self endon("_encstr_AD75063D571AE108");
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_0 = undefined;
  var_1 = 1;
  var_2 = "_encstr_A2FB098A2035874AB0F358";

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_3, var_0, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
    var_11 = scripts\mp\utility\weapon::mapweapon(var_11, var_15);
    var_16 = var_0;

    if(!isPlayer(var_0) && !isagent(var_0)) {
      if(isDefined(var_0.owner) && isPlayer(var_0.owner))
        var_16 = var_0.owner;
    }

    if(!isPlayer(var_16) && !isagent(var_16)) {
      continue;
    }
    if(isDefined(var_11) && isendstr(var_11.basename, "_encstr_AF1809ABEB255B61E9A01A")) {
      continue;
    }
    if(!friendlyfirecheck(self.owner, var_16)) {
      continue;
    }
    if(scripts\mp\utility\damage::non_player_should_ignore_damage(var_16, var_11, var_15, var_6)) {
      continue;
    }
    var_17 = scripts\engine\utility::ter_op(scripts\mp\utility\damage::isfmjdamage(var_11, var_6, 1) || var_3 >= 80, 2, 1);
    var_1 = var_1 - var_17;
    equipmenthit(self.owner, var_16, var_11, var_6);

    if(var_1 <= 0) {
      break;
    } else
      var_16 scripts\mp\damagefeedback::updatedamagefeedback(var_2);
  }

  self notify("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");

  if(isDefined(var_6) && (issubstr(var_6, "_encstr_911B0C7DA090E9A7F799FD50DD48") || issubstr(var_6, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF")))
    self.waschained = 1;

  if(isDefined(var_10) && var_10 &level.idflags_penetration)
    self.wasdamagedfrombulletpenetration = 1;

  if(isDefined(var_10) && var_10 &level.idflags_ricochet)
    self.wasdamagedfrombulletricochet = 1;

  self.wasdamaged = 1;

  if(isDefined(var_16))
    self.damagedby = var_16;

  if(isDefined(self.killcament))
    self.killcament.damagedby = var_16;

  if(isPlayer(var_16)) {
    var_16 scripts\mp\damagefeedback::updatedamagefeedback(var_2);

    if(var_16 != self.owner && var_16.team != self.owner.team) {
      var_16 scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, var_11);
      var_16 scripts\mp\battlechatter_mp::equipmentdestroyed(self);
      scripts\cp\vehicles\vehicle_compass_cp::equipmentdestroyed(var_15, var_0, var_3, var_10, undefined, var_11, undefined, var_16.modifiers);
    }
  }

  if(level.teambased) {
    if(isDefined(var_16) && isDefined(var_16.pers["_encstr_8AEF05472BC2D6"]) && isDefined(self.owner) && isDefined(self.owner.pers["_encstr_8AEF05472BC2D6"])) {
      if(var_16.pers["_encstr_8AEF05472BC2D6"] != self.owner.pers["_encstr_8AEF05472BC2D6"])
        var_16 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");
    }
  } else if(isDefined(self.owner) && isDefined(var_16) && var_16 != self.owner)
    var_16 notify("_encstr_85BB142A408F7BABB0EB352C9099EF43C38022B2A029");

  scripts\cp\vehicles\vehicle_compass_cp::minedestroyed(self, var_16, var_6);
  self notify("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", var_16);
}

mineselfdestruct() {
  self endon("_encstr_879C0F95E0B8AD31855D17376F25ABE550");
  self endon("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523");
  self endon("_encstr_AD75063D571AE108");
  wait(level.mineselfdestructtime + randomfloat(0.4));
  self notify("_encstr_975012ADB49B2BAFE695B1CC46B2CDD127EAD83A");
  self notify("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B");
}

mineexplodeonnotify() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_BACE12D17D0B68388F43515D6B23E1B062D94D5B", var_0);

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = self.owner;

  var_1 = self.config;
  var_2 = var_1.vfxtag;

  if(!isDefined(var_2))
    var_2 = "_encstr_B2BF0708BA770F795B";

  var_3 = self gettagorigin(var_2);

  if(!isDefined(var_3))
    var_3 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  self notify("_encstr_860808CB78E2984063BA", var_3);
  waitframe();

  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }
  self hide();

  if(isDefined(var_1.onexplodefunc))
    self thread[[var_1.onexplodefunc]]();

  if(isDefined(var_1.onexplodesfx))
    self playSound(var_1.onexplodesfx);

  var_4 = scripts\engine\utility::ter_op(isDefined(var_1.onexplodevfx), var_1.onexplodevfx, level.mine_explode);
  playFX(var_4, var_3);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemin), var_1.minedamagemin, level.minedamagemin);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_1.minedamagemax), var_1.minedamagemax, level.minedamagemax);
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1.minedamageradius), var_1.minedamageradius, level.minedamageradius);

  if(var_6 > 0)
    self radiusdamage(self.origin, var_7, var_6, var_5, var_0, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", self.weapon_name);

  if(isDefined(self.owner))
    self.owner thread scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_887B0FB5B4DC95FA322B6E4727BDF29523", undefined, undefined, self.origin);

  wait 0.2;
  deleteexplosive();
}

deleteplacedequipment(var_0) {
  if(isDefined(self.plantedlethalequip)) {
    foreach(var_2 in self.plantedlethalequip) {
      if(isDefined(var_2))
        var_2 deleteexplosive();
    }
  }

  self.plantedlethalequip = [];

  if(isDefined(self.plantedtacticalequip)) {
    foreach(var_2 in self.plantedtacticalequip) {
      if(isDefined(var_2))
        var_2 deleteexplosive();
    }
  }

  self.plantedtacticalequip = [];
  var_6 = scripts\mp\utility\game::isanymlgmatch() || istrue(var_0);

  if(isDefined(self.plantedhackedequip)) {
    foreach(var_8, var_2 in self.plantedhackedequip) {
      if(isDefined(var_2) && (!var_6 || !istrue(var_2.issuper))) {
        var_2 deleteexplosive();
        self.plantedhackedequip[var_8] = undefined;
      }
    }

    self.plantedhackedequip = scripts\engine\utility::array_removeundefined(self.plantedhackedequip);
  }

  if(var_6 && isDefined(self.plantedsuperequip)) {
    foreach(var_8, var_2 in self.plantedsuperequip) {
      var_2 deleteexplosive();
      self.plantedsuperequip[var_8] = undefined;
    }

    self.plantedsuperequip = scripts\engine\utility::array_removeundefined(self.plantedsuperequip);
  }
}

deletedisparateplacedequipment() {
  var_0 = scripts\mp\equipment::getcurrentequipment("_encstr_BA7F0830B3A7859B60B0");

  foreach(var_2 in self.plantedlethalequip) {
    if(isDefined(var_2)) {
      if(!isDefined(var_2.equipmentref) || !isDefined(var_0) || var_2.equipmentref != var_0)
        var_2 deleteexplosive();
    }
  }

  var_4 = scripts\mp\equipment::getcurrentequipment("_encstr_AC8F0AE74163F85AAA380AD8");

  foreach(var_2 in self.plantedtacticalequip) {
    if(isDefined(var_2)) {
      if(!isDefined(var_2.equipmentref) || !isDefined(var_4) || var_2.equipmentref != var_4)
        var_2 deleteexplosive();
    }
  }
}

equipmentdeletevfx(var_0, var_1) {
  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      var_2 = anglesToForward(var_1);
      var_3 = anglestoup(var_1);
      playFX(scripts\engine\utility::getfx("_encstr_B292129A58A30BBB820DDB338FCABB2B19B7D0B7"), var_0, var_2, var_3);
      playFX(scripts\engine\utility::getfx("_encstr_AB751081D3031ACA6D2F289D47B2A85F125F"), var_0, var_2, var_3);
    } else {
      playFX(scripts\engine\utility::getfx("_encstr_B292129A58A30BBB820DDB338FCABB2B19B7D0B7"), var_0);
      playFX(scripts\engine\utility::getfx("_encstr_AB751081D3031ACA6D2F289D47B2A85F125F"), var_0);
    }

    playsoundatpos(var_0, "_encstr_BDA11887DF79028B02DCD893ABE0B00820224FFB209A10D80E4B");
  } else if(isDefined(self)) {
    var_4 = self.origin;
    var_2 = anglesToForward(self.angles);
    var_3 = anglestoup(self.angles);
    playFX(scripts\engine\utility::getfx("_encstr_B292129A58A30BBB820DDB338FCABB2B19B7D0B7"), var_4, var_2, var_3);
    playFX(scripts\engine\utility::getfx("_encstr_AB751081D3031ACA6D2F289D47B2A85F125F"), var_4, var_2, var_3);
    self playSound("_encstr_BDA11887DF79028B02DCD893ABE0B00820224FFB209A10D80E4B");
  }
}

vehcolignorelist() {
  if(level.mapname == "_encstr_A3930F8FD35F7A396BA3D6614DF1A0B245" || isstartstr(level.mapname, "_encstr_A75F0921E8E7B14BBF3AC8"))
    return 1;

  return 0;
}

buildattachmentmaps() {
  level.attachmentmap_uniquetobase = [];
  level.attachmentmap_uniquetoextra = [];
  level.weaponattachments = [];
  var_0 = [];
  var_1 = 1;
  var_2 = tablelookupbyrow("_encstr_BA99153377AA21F3ECD0F86397509513D2D299DE627F4B", var_1, 0);

  for(var_3 = scripts\mp\utility\game::unset_relic_grounded(); var_2 != "_encstr_B40101"; var_2 = tablelookupbyrow("_encstr_BA99153377AA21F3ECD0F86397509513D2D299DE627F4B", var_1, 0)) {
    if(var_3 || scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_2) || vehcolignorelist())
      var_0[var_0.size] = var_2;

    var_1++;
  }

  var_4 = [];
  var_5 = 1;

  for(var_6 = tablelookupbyrow("_encstr_BA99153377AA21F3ECD0F86397509513D2D299DE627F4B", 0, var_5); var_6 != "_encstr_B40101"; var_6 = tablelookupbyrow("_encstr_BA99153377AA21F3ECD0F86397509513D2D299DE627F4B", 0, var_5)) {
    var_4[var_6] = var_5;
    var_5++;
  }

  level.attachmentmap_basetounique = [];

  foreach(var_2 in var_0) {
    foreach(var_11, var_9 in var_4) {
      var_10 = tablelookup("_encstr_BA99153377AA21F3ECD0F86397509513D2D299DE627F4B", 0, var_2, var_9);

      if(var_10 == "_encstr_B40101") {
        continue;
      }
      if(!isDefined(level.attachmentmap_basetounique[var_2]))
        level.attachmentmap_basetounique[var_2] = [];

      level.attachmentmap_basetounique[var_2][var_11] = var_10;

      if(!isDefined(level.attachmentmap_uniquetobase[var_10])) {
        level.attachmentmap_uniquetobase[var_10] = var_11;
        continue;
      }

      if(level.attachmentmap_uniquetobase[var_10] != var_11) {}
    }
  }

  level.carryingplayer = [];
  var_13 = [];
  var_1 = 1;

  for(var_14 = tablelookupbyrow("_encstr_879824A3BB8ECF20FCD6F990FDD5C8FD026711BF9FD281580FA5430922AAB83D7A87354F67AB", var_1, 0); var_14 != "_encstr_B40101"; var_14 = tablelookupbyrow("_encstr_879824A3BB8ECF20FCD6F990FDD5C8FD026711BF9FD281580FA5430922AAB83D7A87354F67AB", var_1, 0)) {
    var_13[var_13.size] = var_14;
    var_1++;
  }

  var_15 = [];
  var_5 = 1;

  for(var_16 = tablelookupbyrow("_encstr_879824A3BB8ECF20FCD6F990FDD5C8FD026711BF9FD281580FA5430922AAB83D7A87354F67AB", 0, var_5); var_16 != "_encstr_B40101"; var_16 = tablelookupbyrow("_encstr_879824A3BB8ECF20FCD6F990FDD5C8FD026711BF9FD281580FA5430922AAB83D7A87354F67AB", 0, var_5)) {
    var_15[var_15.size] = var_16;
    var_5++;
  }

  foreach(var_14 in var_13) {
    foreach(var_9, var_16 in var_15) {
      var_19 = tablelookup("_encstr_879824A3BB8ECF20FCD6F990FDD5C8FD026711BF9FD281580FA5430922AAB83D7A87354F67AB", 0, var_14, var_9 + 1);

      if(var_19 == "_encstr_B40101") {
        continue;
      }
      if(!isDefined(level.carryingplayer[var_14]))
        level.carryingplayer[var_14] = [];

      level.carryingplayer[var_14][var_16] = var_19;
    }
  }

  foreach(var_31, var_22 in level.weaponmapdata) {
    var_23 = var_31;

    if(getsubstr(var_31, 0, 4) == "_encstr_83C5052DBBC1FA")
      var_23 = getsubstr(var_31, 4);

    var_24 = "_encstr_A6180D78E2C8B8C335E317A3B3AB3E" + var_23 + "_encstr_B4501101DB40BFBAFE0B777F7B2872A66003C3";

    if(!tableexists(var_24)) {
      continue;
    }
    level.weaponattachments[var_31] = [];
    var_1 = 1;
    var_25 = tablelookupbyrow(var_24, var_1, 0);
    var_26 = var_23 + "_encstr_AF5214EB0B478EC2C6A16B56E647AF968CCD71D8DCB3";

    if(getsubstr(var_23, 0, 3) == "_encstr_81190403FB70")
      var_26 = "_encstr_8BB606A877A74B9F" + var_26;
    else
      var_26 = "_encstr_81190AE02D6813A73FCC124E" + var_26;

    while(var_25 != "_encstr_B40101") {
      var_27 = getdvarint("_encstr_8ACC21EE8E73EFE029A33190FB4179D92AB7E8F5EB4A416813F7D8A9878A540BC3DF51", 3);

      for(var_28 = 0; var_28 < var_27; var_28++) {
        var_29 = tablelookupbyrow(var_24, var_1, 1 + var_28 * 4);

        if(var_29 != "_encstr_B40101") {
          var_30 = tablelookup(var_26, 0, var_29, 1);

          if(var_30 != "_encstr_B40101")
            level.weaponattachments[var_31][var_30] = var_30;
        }
      }

      var_1++;
      var_25 = tablelookupbyrow(var_24, var_1, 0);
      var_29 = tablelookupbyrow(var_24, var_1, 1);
    }
  }

  level.attachmentmap_attachtoperk = [];
  level.carrier_remove_carriable_weapon = [];
  level.carry_ref = [];
  level.carryobjects_onjuggernaut = [];
  var_32 = getattachmentlistuniquenames();

  foreach(var_34 in var_32) {
    var_35 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_34, 2);
    var_36 = scripts\mp\utility\weapon::attachmentmap_tobase(var_34);

    if(var_35 != "_encstr_B40101" && isDefined(var_36)) {
      var_37 = level.carry_ref[var_36];

      if(!isDefined(var_37))
        level.carry_ref[var_36] = var_35;
      else if(var_35 != var_37)
        level.carryobjects_onjuggernaut[var_34] = var_35;
    }

    var_38 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_34, 12);

    if(var_38 != "_encstr_B40101")
      level.attachmentmap_attachtoperk[var_34] = var_38;

    var_39 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_34, 13);

    if(var_39 != "_encstr_B40101")
      level.attachmentmap_uniquetoextra[var_34] = var_39;

    var_40 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_34, 9);

    if(var_40 != "_encstr_B40101")
      level.carrier_remove_carriable_weapon[var_34] = var_40;
  }

  level.carryitem2omnvar = [];
  level.carryitem2omnvar["_encstr_8B1608EC43B8D647A113"] = fired_missiles("_encstr_BDFB18451FC0A703F1183A82903B7D0BA108DDC23813D28EA798");
  level.carryitem2omnvar["_encstr_BD0703AF7C"] = fired_missiles("_encstr_84FF1B1D910A2EAB45A9BA1230150BA3D007859AD780F98F4DA8B2AB7B");
  level.cash_hud_bink = [];
  level.cash_hud_bink["_encstr_8B1608EC43B8D647A113"] = "_encstr_BDFB18451FC0A703F1183A82903B7D0BA108DDC23813D28EA798";
  level.cash_hud_bink["_encstr_BD0703AF7C"] = "_encstr_84FF1B1D910A2EAB45A9BA1230150BA3D007859AD780F98F4DA8B2AB7B";
}

fired_missiles(var_0) {
  var_4 = [];
  var_1 = 1;

  for(var_2 = tablelookupbyrow(var_0, var_1, 0); var_2 != "_encstr_B40101"; var_2 = tablelookupbyrow(var_0, var_1, 0)) {
    var_5 = 1;

    for(var_3 = tablelookupbyrow(var_0, 0, var_5); var_3 != "_encstr_B40101"; var_3 = tablelookupbyrow(var_0, 0, var_5)) {
      if(var_1 != var_5) {
        var_6 = tablelookupbyrow(var_0, var_1, var_5);

        if(!isDefined(var_4[var_2]))
          var_4[var_2] = [];

        if(var_6 != "_encstr_B40101")
          var_4[var_2][var_3] = var_6;
      }

      var_5++;
    }

    var_1++;
  }

  return var_4;
}

getattachmentlistuniquenames() {
  return scripts\mp\utility\weapon::getattachmentlist(4, 1);
}

track_get_launch_target() {
  level._id_1459E = [];
  _encstr_A3331D38AA06A98BFF114FC8E65F70432AF2F840E29EC181DB2AD831C3771B("_encstr_968317A04A15C3311D1833E2CDD030E923911E09E22EF99B35");
  _encstr_A3331D38AA06A98BFF114FC8E65F70432AF2F840E29EC181DB2AD831C3771B("_encstr_B4C71B5B43763328F5CDF348F3CAD87D9B6F3DD18FD98E105AF5F9C35B");
}

_encstr_A3331D38AA06A98BFF114FC8E65F70432AF2F840E29EC181DB2AD831C3771B(var_0) {
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 1);

    if(!isDefined(var_2) || var_2 == "_encstr_B40101") {
      break;
    }

    if(var_2 != "_encstr_AC20072B9FA9487832") {
      var_1++;
      continue;
    }

    var_3 = tablelookupbyrow(var_0, var_1, 3);
    var_4 = tablelookupbyrow(var_0, var_1, 2);
    level._id_1459E[var_4] = var_3;
    var_1++;
  }
}

safechecknum(var_0) {
  if(!isDefined(level._id_1459E))
    track_get_launch_target();

  var_1 = level._id_1459E[var_0];

  if(isDefined(var_1))
    return var_1;

  return "_encstr_B21904D2EE0E";
}

vehicle_ai_avoidance_cleanup(var_0) {
  if(!isDefined(level._id_1459E))
    track_get_launch_target();

  var_1 = level._id_1459E[var_0];

  if(isDefined(var_1) && (var_1 == "_encstr_AF0703BB78" || var_1 == "_encstr_BD0703AF7C")) {
    if(!istrue(level._id_14434))
      return 0;

    if(!getdvarint("_encstr_A7910B319C629AF44A9A05A2A9"))
      return 0;

    return 1;
  }

  if(isDefined(var_1) && var_1 != "_encstr_B21904D2EE0E")
    return 0;

  return 1;
}

buildweaponmap() {
  level.weaponmapdata = [];
  level._id_14589 = [];
  level._id_14580 = [];
  var_0 = scripts\mp\utility\game::unset_relic_grounded();
  var_1 = tablelookupgetnumrows("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_3 = tablelookupbyrow("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", var_2, 0);
    var_4 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 4);

    if(var_4 == "_encstr_B40101") {
      continue;
    }
    if(var_0 || scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_4) || vehcolignorelist()) {
      level.weaponmapdata[var_4] = spawnStruct();
      var_5 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 0);

      if(var_5 != "_encstr_B40101")
        level.weaponmapdata[var_4].number = var_5;

      var_6 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 1);

      if(var_6 != "_encstr_B40101") {
        level.weaponmapdata[var_4].group = var_6;
        var_7 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 41);

        if(var_7 != "_encstr_B40101") {
          var_8 = int(var_7);
          var_9 = 0;
          var_10 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 17);

          if(var_10 != "_encstr_B40101")
            var_9 = getdvarint(var_10, 0) == 0;

          if(var_8 > -1 && vehicle_ai_avoidance_cleanup(var_4) && !var_9) {
            if(!isDefined(level._id_14589[var_6]))
              level._id_14589[var_6] = [];

            level._id_14589[var_6][level._id_14589[var_6].size] = var_4;
          } else
            level.weaponmapdata[var_4]._id_13EFC = 1;
        }
      }

      if(!istrue(level.weaponmapdata[var_4]._id_13EFC))
        level._id_14580[var_4] = 1;

      var_11 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 2);

      if(var_11 != "_encstr_B40101")
        level.weaponmapdata[var_4]._id_11BD1 = var_11;

      var_12 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 5);

      if(var_12 != "_encstr_B40101")
        level.weaponmapdata[var_4].assetname = var_12;

      var_13 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 44);

      if(var_13 != "_encstr_B40101")
        level.weaponmapdata[var_4].perk = var_13;

      var_14 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 9);
      var_15 = parseattachdefaulttoidmap(var_14);

      if(isDefined(var_15))
        level.weaponmapdata[var_4].attachdefaulttoidmap = var_15;

      var_16 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 8);

      if(var_16 != "_encstr_B40101") {
        var_16 = float(var_16);
        level.weaponmapdata[var_4].speed = var_16;
      }

      continue;
    }

    var_9 = undefined;

    if(tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 1) != "_encstr_B40101") {
      if(tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 41) != "_encstr_B40101") {
        var_10 = tablelookup("_encstr_9B271262BB2077A3C821A3AC23F8ED9718711B5B", 0, var_3, 17);

        if(var_10 != "_encstr_B40101")
          var_9 = getdvarint(var_10, 0) == 0;
      }
    }

    if(!istrue(var_9))
      level._id_14580[var_4] = 1;
  }

  var_17 = [];
  level.weaponlootmapdata = [];
  var_2 = -1;

  for(;;) {
    var_2++;
    var_18 = tablelookupbyrow("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", var_2, 0);

    if(var_18 == "_encstr_B40101") {
      break;
    }

    var_4 = tablelookupbyrow("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", var_2, 1);

    if(!var_0 && !scripts\cp_mp\utility\weapon_utility::vehicle_ai_script_models(var_4) && !vehcolignorelist()) {
      continue;
    }
    var_19 = tablelookupbyrow("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", var_2, 6);
    var_20 = scripts\mp\utility\weapon::getweaponvarianttablename(var_4);
    var_21 = tablelookup(var_20, 1, var_19, 0);

    if(var_21 == "_encstr_B40101") {
      continue;
    }
    if(int(var_21) > 0) {
      if(!isDefined(var_17[var_4]) || int(var_21) > var_17[var_4])
        var_17[var_4] = int(var_21);
    }

    var_22 = var_4 + "_encstr_854C021F" + var_21;
    level.weaponlootmapdata[var_22] = spawnStruct();
    level.weaponlootmapdata[var_22].variantid = int(var_21);
    var_23 = tablelookup(var_20, 1, var_19, 3);

    if(var_23 != "_encstr_B40101")
      level.weaponlootmapdata[var_22].assetoverridename = var_23;

    var_24 = tablelookup("_encstr_9A79148DDE7B1DF2EE950B1C7BDCAFB4236E8BB1DCEC", 6, var_19, 5);
    level.weaponlootmapdata[var_22].update_focus_fire_objective = int(var_21) != 0 && int(var_24) == 99;
    level.weaponlootmapdata[var_22].tut_bot_nameplate = vehicle_ai_avoidance_cleanup(var_4);
    var_25 = tablelookup(var_20, 1, var_19, 4);
    var_15 = parseattachdefaulttoidmap(var_25);

    if(isDefined(var_15)) {
      if(isDefined(level.weaponmapdata[var_4].attachdefaulttoidmap))
        var_15 = scripts\engine\utility::array_combine_unique_keys(var_15, level.weaponmapdata[var_4].attachdefaulttoidmap);

      level.weaponlootmapdata[var_22].attachdefaulttoidmap = var_15;
    }

    var_26 = [];

    for(var_27 = 5; var_27 <= 15; var_27++) {
      var_28 = tablelookup(var_20, 1, var_19, var_27);

      if(var_28 != "_encstr_B40101") {
        var_29 = strtok(var_28, "_encstr_854C021F");

        if(var_29.size == 2)
          var_26[var_29[0]] = int(var_29[1]);
        else
          var_26[var_29[0]] = 0;
      }
    }

    if(var_26.size > 0)
      level.weaponlootmapdata[var_22].attachcustomtoidmap = var_26;

    var_30 = tablelookup(var_20, 1, var_19, 16);

    if(var_30 != "_encstr_B40101") {
      var_31 = [];
      var_32 = strtok(var_30, "_encstr_974C0246");

      foreach(var_34 in var_32) {
        var_35 = strtok(var_34, "_encstr_854C021F");

        if(var_35.size != 2) {
          continue;
        }
        var_31[var_35[0]] = int(var_35[1]);
      }

      if(var_31.size > 0)
        level.weaponlootmapdata[var_22].attachextratoidmap = var_31;
    }
  }

  foreach(var_41, var_38 in var_17) {
    for(var_39 = 1; var_39 <= var_38; var_39++) {
      var_40 = var_41 + "_encstr_854C021F" + var_39;

      if(!isDefined(level.weaponlootmapdata[var_40])) {
        level.weaponlootmapdata[var_40] = spawnStruct();
        level.weaponlootmapdata[var_40].variantid = var_39;
        level.weaponlootmapdata[var_40].update_focus_fire_objective = 1;
        level.weaponlootmapdata[var_40].tut_bot_nameplate = 0;
      }
    }
  }
}

parseattachdefaulttoidmap(var_0) {
  if(var_0 != "_encstr_B40101") {
    var_1 = strtok(var_0, "_encstr_974C0246");
    var_2 = [];

    foreach(var_4 in var_1) {
      var_5 = strtok(var_4, "_encstr_854C021F");

      if(getdvarint("_encstr_AA3F176EC6C9EB6EB236B26C8E994BC92BAF2BDCC2131B5619", 1) == 0) {
        if(scripts\engine\utility::string_starts_with(var_5[0], "_encstr_990B07B8532D18FE21"))
          continue;
      }

      if(var_5.size == 2) {
        var_2[var_5[0]] = int(var_5[1]);
        continue;
      }

      var_2[var_5[0]] = 0;
    }

    return var_2;
  }

  return undefined;
}

grenadestuckto(var_0, var_1, var_2) {
  if(!isDefined(self)) {
    var_0.stuckenemyentity = var_1;
    var_1.stuckbygrenade = var_0;
    var_1._id_13935 = var_0.owner;
  } else if(level.teambased && isDefined(var_1.team) && var_1.team == self.team)
    var_0.isstuck = "_encstr_ACFC091AE8AB2FCBE15119";
  else {
    var_3 = undefined;
    var_4 = "_encstr_A9460F7FBDF1486510D00461F32B4556B0";

    switch (var_0.weapon_name) {
      case "_encstr_92A70ABB8267F5E0D89F6351":
        var_3 = "_encstr_91860D9BACB63AB2F07DE63AD56CD6";
        break;
      case "_encstr_BA730BF8AFF178988293F158B9":
        var_3 = "_encstr_B40E0E5D2A316ADB653B19B813A3B72C";
        var_4 = "_encstr_8FF010F221D7301FBECF0F558B4B9EACE351";
        break;
      case "_encstr_99410C4B48C39AB7D0CD95B769DB":
        var_3 = "_encstr_A9C018A3D0954E5B96E8567D581D8EC2C6AD95937DCD47D5B1B5";
        var_4 = "_encstr_8FF010F221D7301FBECF0F558B4B9EACE351";
        break;
    }

    var_0.isstuck = "_encstr_88BF06FD784A6393";
    var_0.stuckenemyentity = var_1;
    var_1.stuckbygrenade = var_0;
    var_1._id_13935 = var_0.owner;
    self notify("_encstr_844F149F9B026050043F861B63FD882A592F15135F6B");
    level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_1, var_4);

    if(!istrue(var_2))
      grenadestucktosplash(var_3, var_1);
  }
}

grenadestucktosplash(var_0, var_1) {
  var_2 = self;

  if(isPlayer(var_1) && isDefined(var_0)) {
    if(isDefined(var_2.owner))
      var_2 = var_2.owner;

    var_2 scripts\mp\hud_message::showsplash(var_0);
  }

  var_2 thread scripts\mp\awards::givemidmatchaward("_encstr_84DC1022837BCAFAEE40435B5F308BA86178");
}

outlineequipmentforowner(var_0) {}

outlinesuperequipment(var_0, var_1) {
  if(level.teambased)
    thread outlinesuperequipmentforteam(var_0, var_1);
  else
    thread outlinesuperequipmentforplayer(var_0, var_1);
}

outlinesuperequipmentforteam(var_0, var_1) {
  var_2 = scripts\mp\utility\outline::outlineenableforteam(var_0, var_1.team, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_85CE0B9770B02C73A1760F06D2");
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\mp\utility\outline::outlinedisable(var_2, var_0);
}

outlinesuperequipmentforplayer(var_0, var_1) {
  var_2 = scripts\mp\utility\outline::outlineenableforplayer(var_0, var_1, "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_85CE0B9770B02C73A1760F06D2");
  var_0 waittill("_encstr_AD75063D571AE108");
  scripts\mp\utility\outline::outlinedisable(var_2, var_0);
}

grenadeheldatdeath() {
  return istrue(self.grenadeheldatdeath);
}

set_cp_vehicle_health_values() {
  self.grenadeheldatdeath = !nullweapon(self getheldoffhand());
}

trace_impale(var_0, var_1) {
  var_2 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
  var_3 = scripts\engine\trace::ray_trace_detail(var_0, var_1, level.players, var_2, undefined, 1);
  return var_3;
}

impale_endpoint(var_0, var_1) {
  var_2 = var_0 + var_1 * 4096;
  return var_2;
}

impale(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!isDefined(var_1.body)) {
    return;
  }
  playFX(scripts\engine\utility::getfx("_encstr_A3DA1B07B2CDCAE827C28E2DF6DCFA93B0A5633BEA73F55A6B380B36A3"), var_4);
  var_9 = impale_endpoint(var_4, var_5);
  var_10 = trace_impale(var_4, var_9);
  var_9 = var_10["_encstr_BD260953AA97E3F014279D"] - var_5 * 12;
  var_11 = length(var_9 - var_4);
  var_12 = var_11 / 1000;
  var_12 = max(var_12, 0.05);

  if(var_10["_encstr_AA1C0886968EA32FE056"] != "_encstr_9B0C0ED05AE8D15EC1B2F5BBBD93C632")
    var_12 = 0;

  var_13 = var_12 > 0.05;

  if(isDefined(var_1))
    var_1.body startragdoll();

  waitframe();

  if(var_13) {
    var_14 = var_5;
    var_15 = anglestoup(var_0.angles);
    var_16 = vectorcross(var_14, var_15);
    var_17 = scripts\engine\utility::spawn_tag_origin(var_4, axistoangles(var_14, var_16, var_15));
    var_17 moveTo(var_9, var_12);
    var_18 = spawnragdollconstraint(var_1.body, var_6, var_7, var_8);
    var_18.origin = var_17.origin;
    var_18.angles = var_17.angles;
    var_18 linkTo(var_17);

    if(var_12 > 1)
      thread impale_detachaftertime(var_18, 1);

    thread impale_cleanup(var_1, var_17, var_12 + 0.25);
    var_17 thread impale_effects(var_9, var_12);
  }
}

impale_detachaftertime(var_0, var_1) {
  wait(var_1);

  if(isDefined(var_0))
    var_0 delete();
}

impale_effects(var_0, var_1) {
  wait(clamp(var_1 - 0.05, 0.05, 20));
  playFX(scripts\engine\utility::getfx("_encstr_BE6E1FCE33C3BE072BE6CAE89316A35AED377D27C22D1BCEAEE6F54BD63885C63A"), var_0);
}

impale_cleanup(var_0, var_1, var_2) {
  if(isDefined(var_0))
    var_0 scripts\engine\utility::_id_143B9(var_2, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  var_1 delete();
}

codecallback_getprojectilespeedscale(var_0, var_1) {
  return [1.0, 1.0];
}

setplayerstunned() {
  if(!isDefined(self.isstunned))
    self.isstunned = 1;
  else
    self.isstunned++;
}

setplayerunstunned() {
  self.isstunned--;
}

isstunned() {
  return isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers["_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B"]);
}

setplayerblinded() {
  if(!isDefined(self.isblinded))
    self.isblinded = 1;
  else
    self.isblinded++;
}

setplayerunblinded() {
  self.isblinded--;
}

isblinded() {
  return isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers["_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683"]);
}

tutkioskpurchase(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683";
  var_2 = var_0 getentitynumber();

  if(isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers[var_1]) && isDefined(self.debuffedbyplayers[var_1][var_2]))
    return 1;

  return 0;
}

using_self_revive(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B";
  var_2 = var_0 getentitynumber();

  if(isDefined(self.debuffedbyplayers) && isDefined(self.debuffedbyplayers[var_1]) && isDefined(self.debuffedbyplayers[var_1][var_2]))
    return 1;

  return 0;
}

isstunnedorblinded() {
  return isblinded() || isstunned();
}

cleanupconcussionstun(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8716143EFC0FC379CFDA5930B3E62718A39C4FB345FB");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait(var_0);
  setplayerunstunned();
}

applyweaponsonicstun() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 0.1;

  if(isDefined(self) && isPlayer(self) && !isbot(self)) {
    self playlocalsound("_encstr_BA721508AFF0B82081874848B162AD6B5E9F3DB11DE39F");
    self setsoundsubmix("_encstr_8DC015EA0208F389F1D30330CB592570B7FBC543604343");
  }
}

watchinvalidweaponchange() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    self waittill("_encstr_9645168BA7FB3B20F809CA3B218389F35EA778E86748C1C9", var_0);
    var_1 = self getcurrentweapon();

    if(var_1.inventorytype == "_encstr_B2C5059803B560" || var_1.inventorytype == "_encstr_A5D70AACF0C6D8D5379667CA")
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.lastdroppableweaponobj);
  }
}

weaponhasselectableoptic(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_2 = getweaponattachments(var_0);

  foreach(var_4 in var_2) {
    var_5 = attachmentgroup(var_4);

    if(var_5 == "_encstr_851F05E3C813A5") {
      var_6 = scripts\mp\utility\weapon::attachmentmap_tobase(var_4);

      if(scripts\mp\utility\weapon::carriedpunchcard(var_1, var_6))
        return 1;
    }
  }

  return 0;
}

watchdropweapons() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_962C11BB168EC68688E4DB07EA590B1CB7B9CD");
  self endon("_encstr_962C11BB168EC68688E4DB07EA590B1CB7B9CD");

  for(;;) {
    self waittill("_encstr_B8E20FBB59851CF6E6AF91E4DBC107B232", var_0, var_1);

    if(isDefined(var_0) && isDefined(var_1) && !scripts\mp\utility\weapon::ismeleeonly(var_1) && !scripts\mp\utility\weapon::update_health_bar_to_player(var_1) && !scripts\mp\utility\weapon::isknifeonly(var_1)) {
      if(var_0 physics_getnumbodies() > 0) {
        var_0 physics_registerforcollisioncallback();
        var_0 thread weapondrop_physics_callback_monitor();
      }
    }
  }
}

weapondrop_physics_callback_monitor() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_995408F398012F656821");
  thread weapondrop_physics_timeout(2);
  self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

  if(isDefined(self.classname) && getsubstr(self.classname, 0, 6) == "_encstr_AC20072B9FA9487832") {
    var_8 = physics_getsurfacetypefromflags(var_3);
    var_9 = getsubstr(var_8["_encstr_84BA05A8CA852B"], 9);

    if(var_9 == "_encstr_A1140EEA6EB2E4EB3A9593C90BB4734C")
      var_9 = "_encstr_AA9D0F9543A77B872312D8C04A3CAD964E";

    if(var_9 == "_encstr_9B140E63868B6317C37893AB6058EEDF")
      var_9 = "_encstr_8A9D0F4F7F25B3CF2829E2EA412836B9A5";

    switch (getsubstr(self.classname, 0, 13)) {
      case "_encstr_86A00E4CAFE211ED869F90682A9F994D":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "_encstr_ABCA0807ED1BCBD6CAE4")
            self playsurfacesound("_encstr_8F78134CAFE211068C2BA050B7AD19616992C8595E", var_9);
          else
            self playsurfacesound("_encstr_A9D30EAF47C988B11FBABDC1C67A6571", var_9);
        } else
          self playsurfacesound("_encstr_A9D30EAF47C988B11FBABDC1C67A6571", var_9);

        break;
      case "_encstr_86A00E4CAFE211ED869F90682A9FDB73":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "_encstr_ABCA0807ED1BCBD6CAE4")
            self playsurfacesound("_encstr_A21B1577AC2C83FAC8E4F638FA6EDA2CD88DEB0EDB8DE5", var_9);
          else
            self playsurfacesound("_encstr_8B4910EEB2160EF51927BDC1F59BD616B1C6", var_9);
        } else
          self playsurfacesound("_encstr_8B4910EEB2160EF51927BDC1F59BD616B1C6", var_9);

        break;
      case "_encstr_ABA00E43FA2F9FD805C74367B8A108E9":
        self playsurfacesound("_encstr_AA0E116847B1C3778222B797711B49A90AF770", var_9);
        break;
      case "_encstr_ABA00E43FA2F9FD805C74367B8A1F06B":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "_encstr_ABCA0807ED1BCBD6CAE4")
            self playsurfacesound("_encstr_8F78134CAFE211068C2BA050B7AD19616992C8595E", var_9);
          else
            self playsurfacesound("_encstr_A9D30EAF47C988B11FBABDC1C67A6571", var_9);
        } else
          self playsurfacesound("_encstr_A9D30EAF47C988B11FBABDC1C67A6571", var_9);

        break;
      case "_encstr_A5A00E77B28507DBDCFAB4DDC1D7DCCD":
        self playsurfacesound("_encstr_ABF310AF5859088949BE558A3071A2B221F0", var_9);
        break;
      case "_encstr_9AA00E5F496ED98768280A579AD91B90":
        if(isDefined(self.objweapon)) {
          if(isDefined(self.objweapon.material) && self.objweapon.material == "_encstr_ABCA0807ED1BCBD6CAE4")
            self playsurfacesound("_encstr_A3FE16AFB179A32961E2B7B3F6AA0C077B9898A7734FFCA3", var_9);
          else
            self playsurfacesound("_encstr_858E11C75FCF915F30689060099BCA63717811", var_9);
        } else
          self playsurfacesound("_encstr_858E11C75FCF915F30689060099BCA63717811", var_9);

        break;
      case "_encstr_A3A00E5BEFD9380822B703370219C108":
        self playsurfacesound("_encstr_95F4134323165859D88288287185A2FDE5478C4DAB", var_9);
        break;
      default:
        self playsurfacesound("_encstr_A9D30EAF47C988B11FBABDC1C67A6571", var_9);
        break;
    }
  }
}

weapondrop_physics_timeout(var_0) {
  wait(var_0);
  self notify("_encstr_995408F398012F656821");
}

axedetachfromcorpse(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = var_0 getlinkedchildren();

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = var_3.weapon_name;
    var_5 = var_3.owner;
    var_6 = var_3.origin;

    if(isDefined(var_4) && scripts\mp\utility\weapon::isaxeweapon(var_4))
      var_3 relaunchaxe(var_4, var_5);
  }
}

relaunchaxe(var_0, var_1) {
  self unlink();
  var_2 = scripts\mp\utility\weapon::getweaponbasenamescript(var_0);
  var_3 = getsubstr(var_0, var_2.size);
  var_4 = var_1 scripts\mp\utility\weapon::_launchgrenade("_encstr_83371130A74F9EB3EB3FF0E152B1F1834DA7C8" + var_3, self.origin, (0, 0, 0), 100, 1, self);
  var_4 setentityowner(var_1);
  var_4 thread _utilflare_isvalidflaretype::watchgrenadeaxepickup(var_1, self.weapon_name);
}

callback_finishweaponchange(var_0, var_1, var_2, var_3) {
  updateweaponscriptvfx(var_0, var_1, var_2, var_3);
  var_4 = self.weaponchangecallbacks;

  if(isDefined(var_4)) {
    foreach(var_6 in var_4.callbacks)
    self[[var_6]](var_0, var_1);

    foreach(var_6 in var_4.oneshotcallbacks)
    self[[var_6]](var_0, var_1);

    var_4.oneshotcallbacks = [];
  }
}

updateweaponscriptvfx(var_0, var_1, var_2, var_3) {
  if((var_1.basename == "_encstr_8BBA05185F8B99" || var_1.basename == "_encstr_AA7809476984573B7FCDE9") && isDefined(self.lastdroppableweapon)) {
    if(var_1 == "_encstr_AA7809476984573B7FCDE9")
      var_3 = 1;
    else
      var_3 = 0;

    var_1 = self.lastdroppableweapon;
  }

  clearweaponscriptvfx(var_1, var_3);
  runweaponscriptvfx(var_0, var_2);
}

runweaponscriptvfx(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_1) && var_1 == 1)
    var_2 = "_encstr_9B83050BD88EF5" + scripts\mp\utility\weapon::getweaponbasenamescript(var_0);
  else
    var_2 = scripts\mp\utility\weapon::getweaponbasenamescript(var_0);
}

clearweaponscriptvfx(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_1) && var_1 == 1)
    var_2 = "_encstr_9B83050BD88EF5" + scripts\mp\utility\weapon::getweaponbasenamescript(var_0);
  else
    var_2 = scripts\mp\utility\weapon::getweaponbasenamescript(var_0);

  switch (var_2) {
    case "_encstr_8380108C3B128FFBF07F2B2771A582D71063":
    case "_encstr_8F091280BBC06FBB63BF57D988A321732AC128D0":
    case "_encstr_ACDD1096DDE0EB376BFA5DA757C657FAD61C":
    case "_encstr_83EA1197DF33D95B48F64D122978919778137B":
    case "_encstr_B6F50F81DBCA6F8A08819E8A2B41A6DAD3":
    case "_encstr_B8AB117B772FAF28D569E9630F8F88C4F1A7C1":
    case "_encstr_93D811967783AFB9DAEB5BC1C2E0B0D4F5AD83":
    case "_encstr_AFD81196BB83FADCDA7D0785832C9C817DAD83":
    case "_encstr_9A45126853289743936788FE33DF2B13F279F028":
    case "_encstr_A1AF15733C88381B0A0E8743929044085DAF9A1DBF905B":
    case "_encstr_8DE1122D770EFA9BA1AF46832CC1C22664BEB5C1":
    case "_encstr_8E86126A40892133C04890B9F7E97622C1695273":
    case "_encstr_8B98105A770ED71C5ABE46AC1B0DF6AFB61C":
    case "_encstr_B8101002A7B77ED05C7773805753B96FDF87":
    case "_encstr_B8B7134BEE70EB0ED2FA5BB4D69526721398D7AD07":
    case "_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B":
    case "_encstr_AA511062DBBA97C9E8DF996A9791D207C0F2":
    case "_encstr_A3A3125AEEE0FA366B7DAD9DDB63663368D7B538":
    case "_encstr_83ED1197DF33D94448F60D54A8F0C88778137B":
    case "_encstr_87131233FF6A6649CD69F8E07265AB9326AF4937":
    case "_encstr_860A13D377F001473B198BB1524F86D0FCFD37A318":
    case "_encstr_82B813182358E771AB37D9C6E80FDB79F4EA31B0EB":
    case "_encstr_965111B4EEC1AFB027FACC58B11C860BBE5B1C":
    case "_encstr_A78B112DDD07FA5827D7CC16B196D685EB5BC1":
    case "_encstr_96CF14A5BB1CD70BC97D16B996CA9C9316C4237D5B07":
    case "_encstr_9BFF104F9FA8014F8D176A50489B49D7DA70":
    case "_encstr_B8F911CBC79FB0B846F998109C35D27D813771":
    case "_encstr_8D06112DDDE0EB6EE6BEB5B463BD271CFAD61C":
    case "_encstr_A3D91096BB07BEC227BEAD2DB6CAA1FAB6C1":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
    case "_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588":
    case "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB":
    case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
    case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
    case "_encstr_A6CB155AEEE0BECDB67DD19C9BE8C23791164E91EBAD07":
      break;
  }
}

updatecamoscripts(var_0, var_1) {
  if(_id_1458A(var_1))
    clearcamoscripts(getweaponcamoname(var_1));

  runcamoscripts(var_0);
}

runcamoscripts(var_0) {
  if(!getdvarint("_encstr_99CF13DB18F8EF2A11496E88902B5D59C68F20A88B", 1)) {
    return;
  }
  if(_id_1458A(var_0))
    thread _id_12A3E(var_0);
  else
    self setscriptablepartstate("_encstr_962A0B0B368ED267CA8658D6ED", "_encstr_B2AC096DF7B7A77B8387E1");

  var_1 = getweaponcamoname(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "_encstr_AB9207FEE9DD779322":
      thread blood_camo_84();
      break;
  }
}

clearcamoscripts(var_0) {
  self notify("_encstr_92F616281EFA12F507564342E4600ED043E8B140EADFD1A1");
  self setscriptablepartstate("_encstr_962A0B0B368ED267CA8658D6ED", "_encstr_B2AC096DF7B7A77B8387E1");

  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "_encstr_AB9207FEE9DD779322":
      self notify("_encstr_A6600E9229882D6B50691AC2F088D233");
      break;
  }
}

_id_12A41() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  foreach(var_1 in level.players) {
    if(isDefined(var_1) && isDefined(var_1._id_12A44)) {
      var_1._id_12A44 = undefined;
      var_1 notify("_encstr_92F616281EFA12F507564342E4600ED043E8B140EADFD1A1");
    }
  }
}

_id_12A42(var_0, var_1, var_2) {
  var_0._id_13765 = var_1;

  if(var_2 == 1)
    self setscriptablepartstate("_encstr_962A0B0B368ED267CA8658D6ED", "_encstr_96AD06373AB03B95" + var_0._id_13765);
  else
    self setscriptablepartstate("_encstr_962A0B0B368ED267CA8658D6ED", "_encstr_A2200B9A6B10BB71FFE9C0EF1A" + var_0._id_13765);
}

_id_12A43(var_0) {
  if(!isDefined(self._id_12A44))
    self._id_12A44 = [];

  if(!isDefined(self._id_12A44[var_0])) {
    self._id_12A44[var_0] = spawnStruct();
    self._id_12A44[var_0].kills = 0;
    self._id_12A44[var_0]._id_13765 = 0;
  }
}

_id_12A3E(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_92F616281EFA12F507564342E4600ED043E8B140EADFD1A1");

  if(!isDefined(level._id_12A40) && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    level._id_12A40 = 1;
    level thread _id_12A41();
  }

  var_1 = _id_14585(var_0);
  _id_12A43(var_1);
  var_2 = self._id_12A44[var_1];
  _id_12A42(var_2, var_2._id_13765, 0);
  var_3 = tablelookuprownum("_encstr_8E7D134E5958C6E8B4D9B27D6C0BADED9BE26CB9B3", 0, var_1);
  var_4 = int(tablelookupbyrow("_encstr_8E7D134E5958C6E8B4D9B27D6C0BADED9BE26CB9B3", var_3, 1));
  var_5 = strtok(tablelookupbyrow("_encstr_8E7D134E5958C6E8B4D9B27D6C0BADED9BE26CB9B3", var_3, 2), "_encstr_854C021F");

  while(var_2._id_13765 < var_4) {
    scripts\engine\utility::waittill_either("_encstr_8F220B3FC7D11160D8F85169E9", "_encstr_844E18B7DF73F85004FB41B8A6ED932DBA37210B33AABE285595");
    var_6 = int(var_5[var_2._id_13765 + 1]);
    var_2.kills++;

    if(var_2.kills >= var_6) {
      _id_12A42(var_2, var_2._id_13765 + 1, 1);

      if(!self isswitchingweapon())
        self playlocalsound("_encstr_ADBD1AA8DA6941E343A1C33951C25BEAC0282CD3D93AF0BB6B6C17E5");
    }
  }
}

blood_camo_84() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A6600E9229882D6B50691AC2F088D233");

  if(isDefined(self.bloodcamokillcount))
    self setscriptablepartstate("_encstr_B49D087E961A172EF86A", self.bloodcamokillcount + "_encstr_9ABE07CEFC41481903");
  else
    self.bloodcamokillcount = 0;

  while(self.bloodcamokillcount < 13) {
    self waittill("_encstr_A3EC145383B883F9E3904AF2A8BF6E3F11FCA5C22D01");
    self.bloodcamokillcount = self.bloodcamokillcount + 1;
    self setscriptablepartstate("_encstr_B49D087E961A172EF86A", self.bloodcamokillcount + "_encstr_9ABE07CEFC41481903");
  }
}

_id_14585(var_0) {
  return var_0.basename + "_encstr_9607034960" + var_0.variantid;
}

_id_1458A(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.variantid))
    return 0;

  var_1 = _id_14585(var_0);
  var_2 = tablelookuprownum("_encstr_8E7D134E5958C6E8B4D9B27D6C0BADED9BE26CB9B3", 0, var_1);

  if(isDefined(var_2) && var_2 >= 0)
    return 1;

  return 0;
}

getactiveequipmentarray() {
  return scripts\engine\utility::array_remove_duplicates(level.mines);
}

init_function_refs() {
  level.getactiveequipmentarray = ::getactiveequipmentarray;
}

doesshareammo(var_0) {
  return var_0.isalternate && !issubstr(var_0.underbarrel, "_encstr_8A07035972") && issubstr(var_0.underbarrel, "_encstr_A65B084B38A76BEFC350");
}

grenadeinitialize(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0.weapon_object))
    var_0.weapon_object = var_1;

  if(!isDefined(var_0.weapon_name))
    var_0.weapon_name = var_1.basename;

  if(!isDefined(var_0.owner))
    var_0.owner = self;

  if(!isDefined(var_0.team))
    var_0.team = self.team;

  if(!isDefined(var_0.tickpercent))
    var_0.tickpercent = var_2;

  if(!isDefined(var_0.ticks) && isDefined(var_0.tickpercent))
    var_0.ticks = scripts\mp\utility\script::roundup(4 * var_2);

  var_4 = scripts\mp\equipment::getequipmentreffromweapon(var_1);

  if(isDefined(var_4)) {
    var_0.equipmentref = var_4;
    var_0.isequipment = 1;

    if(var_4 == "_encstr_84CB0CB2680B841B3E76A5AF0201")
      var_0.owner scripts\mp\utility\stats::incpersstat("_encstr_978F0B1B40F7FCB773BD636DCD", 1);
  }

  var_0.threwback = isDefined(var_3);
}

waittill_missile_fire() {
  self waittill("_encstr_ACA30D383847FB93AAFF7705139D4B", var_0, var_1);

  if(isDefined(var_0)) {
    if(!isDefined(var_0.weapon_name)) {
      if(var_1.isalternate)
        var_0.weapon_name = scripts\mp\utility\weapon::getaltmodeweapon(var_1);
      else
        var_0.weapon_name = var_1.basename;
    }

    if(!isDefined(var_0.owner))
      var_0.owner = self;

    if(!isDefined(var_0.team))
      var_0.team = self.team;
  }

  return var_0;
}

update_jugg_targets(var_0) {
  if(var_0.basename == "_encstr_AA5B16F9348AF7DE658162DA28819592D3887578C5485B32" || var_0.basename == "_encstr_A2951596DD70BEB95BD76B0E161C8573EBB5E0D6A3E199")
    return 1;

  return 0;
}

update_icon_for_bomb_case_detonator_holder(var_0) {
  if(var_0.basename == "_encstr_85361A3B376F40F88A2929C0CD562B8162C7850352611138BDFBF253" || var_0.basename == "_encstr_BEFB15737F270830DD61B3E9D2B92AF709BFF9F3EBCBC6")
    return 1;

  if(isDefined(var_0.reargrip) && var_0.reargrip == "_encstr_91DF0B46E3409B0B67C259D893")
    return 1;

  return 0;
}

_id_11DF6(var_0) {
  _id_12734("_encstr_A9B30EA6BECD347BAE3623569CBEC95A", "_encstr_A5280ADB4D3B0D66E1CCC2A2");
  _id_12734("_encstr_8BB30ED4AFDC43DEEAB191ACE47DB156", "_encstr_A5280ADB4D3B0D66E1CCC2A2");
  _id_12734("_encstr_A78B0B4D7DAC6398F6DDEB27A5", "_encstr_A5280ADB4D3B0D66E1CCC2A2");
  _id_12734("_encstr_8D8B0B309FA99B7EFA735F68F1", "_encstr_A5280ADB4D3B0D66E1CCC2A2");
  _id_12734("_encstr_AFDD09A6FA864B1CBEC996", "_encstr_A5280ADB4D3B0D66E1CCC2A2");
  _id_12734("_encstr_AFDD09A6FA864B1CBEB156", "_encstr_A5280ADB4D3B0D66E1CCC2A2");
  _id_12734("_encstr_BD500A3C087F4AD519410B6F", "_encstr_A5280ADB4D3B0D66E1CCC2A2");
  _id_12734("_encstr_AC500A7A366A5BBFC04F9465", "_encstr_A5280ADB4D3B0D66E1CCC2A2");
  _id_12734("_encstr_813B0D4027B390B37585BBC819FD28", "_encstr_9B430B637F0354A9A3E20EB3D8");
  _id_12734("_encstr_AADA07DBF19A4A81D7", "_encstr_87450A6B3277C809D4CF127A");
  self playSound("_encstr_99EE17B2CFC72FE173D09162A029A02981A35BE3E4F85733B3");
  var_0 hide();
}

_id_11DF5(var_0) {
  _id_12734("_encstr_A9B30EA6BECD347BAE3623569CBEC95A", "_encstr_BEBE096AFE19D051EA374D");
  _id_12734("_encstr_8BB30ED4AFDC43DEEAB191ACE47DB156", "_encstr_BEBE096AFE19D051EA374D");
  _id_12734("_encstr_A78B0B4D7DAC6398F6DDEB27A5", "_encstr_BEBE096AFE19D051EA374D");
  _id_12734("_encstr_8D8B0B309FA99B7EFA735F68F1", "_encstr_BEBE096AFE19D051EA374D");
  _id_12734("_encstr_AFDD09A6FA864B1CBEC996", "_encstr_BEBE096AFE19D051EA374D");
  _id_12734("_encstr_AFDD09A6FA864B1CBEB156", "_encstr_BEBE096AFE19D051EA374D");
  _id_12734("_encstr_BD500A3C087F4AD519410B6F", "_encstr_BEBE096AFE19D051EA374D");
  _id_12734("_encstr_AC500A7A366A5BBFC04F9465", "_encstr_BEBE096AFE19D051EA374D");
  _id_12734("_encstr_813B0D4027B390B37585BBC819FD28", "_encstr_A3E00AB182E4189D0F8BCB70");
  _id_12734("_encstr_AADA07DBF19A4A81D7", "_encstr_9B9C097A1D23D3D8A0A967");
  self playSound("_encstr_87A80F30CD40136F25B1326B389087CFA0");
  var_0 hide();
}

_id_12734(var_0, var_1) {
  var_2 = self gettagorigin(var_0);
  var_3 = self gettagangles(var_0);
  playFX(level._effect[var_1], var_2, anglesToForward(var_3), anglestoup(var_3));
}

enableburnfx(var_0, var_1) {
  if(!isDefined(self.flare_thread))
    self.flare_thread = [];

  if(!isDefined(var_1))
    var_1 = "_encstr_930B07BB1B6B3854FF";

  if(!istrue(var_0))
    thread enableburnsfx();

  self.flare_thread[release_mortar_operator(var_1)] = var_1;
  thread startburnfx();
}

release_mortar_operator(var_0) {
  switch (var_0) {
    case "_encstr_86630CCDAEAD597D2C1B8E5A9DAC":
      return 3;
    case "_encstr_8C8F0A271958E29348C8438F":
      return 2;
    case "_encstr_930B07BB1B6B3854FF":
      return 1;
    default:
      return 0;
  }
}

remove_invulnerability(var_0) {
  var_1 = 3;

  for(var_2 = undefined; var_1 >= 0; var_1--) {
    if(isDefined(var_0[var_1])) {
      var_2 = var_0[var_1];
      break;
    }
  }

  return var_2;
}

enableburnsfx() {
  if(!isDefined(self.burnsfxenabled))
    self.burnsfxenabled = 0;

  if(!isDefined(self.burnsfx)) {
    self.burnsfx = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
    self.burnsfx linkTo(self);
    self.burnsfx scripts\cp_mp\ent_manager::registerspawncount(1);
    thread flares_from_structs(self.burnsfx);
    wait 0.05;
  }

  if(self.burnsfxenabled == 0) {
    self.burnsfx playLoopSound("_encstr_A1E01D0F7F11DB672AA081E8B05023B904345A9FF1814628F0F77F50B54ECB");
    self.burnsfxenabled = 1;
  }
}

flares_from_structs(var_0) {
  self endon("_encstr_8E201089AE4EE6359161AF192B1B561D958C");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0)) {
    var_0 stoploopsound("_encstr_A1E01D0F7F11DB672AA081E8B05023B904345A9FF1814628F0F77F50B54ECB");
    var_0 delete();
  }
}

enableburnfxfortime(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_930B07BB1B6B3854FF";

  var_2 = "_encstr_A25415972BA5AF43F9FA3775CB22A375C87037F1FA2B0F" + var_1;
  self notify(var_2);
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_96410C3F94AFF8D6E3B39318A8A3");
  self endon(var_2);
  thread enableburnfx(0, var_1);
  wait(var_0);
  thread disableburnfx(0, var_1);
}

disableburnfx(var_0, var_1) {
  if(isDefined(var_1)) {
    if(self.flare_thread[release_mortar_operator(var_1)] == var_1)
      self.flare_thread[release_mortar_operator(var_1)] = undefined;
  } else
    self.flare_thread = [];

  if(self.flare_thread.size > 0)
    thread startburnfx();
  else {
    thread stopburnfx();

    if(!istrue(var_0))
      thread disable_burnsfx();
  }
}

disable_burnsfx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self.burnsfxenabled))
    self.burnsfxenabled = 0;

  wait 0.5;

  if(self.burnsfxenabled == 1) {
    self playSound("_encstr_BA7A21F4175AA9AE2D875050F377C3BF92BCEE7561F24DD105B7C130DF821807CAE56D");

    if(isDefined(self.burnsfx)) {
      self.burnsfx scripts\cp_mp\ent_manager::deregisterspawn();
      wait 0.15;

      if(isDefined(self.burnsfx)) {
        self notify("_encstr_8E201089AE4EE6359161AF192B1B561D958C");
        self.burnsfx stoploopsound("_encstr_A1E01D0F7F11DB672AA081E8B05023B904345A9FF1814628F0F77F50B54ECB");
        self.burnsfx delete();
      }
    }

    self.burnsfxenabled = 0;
  }
}

supressburnfx(var_0) {
  if(!isDefined(self.burnfxsuppressed))
    self.burnfxsupressed = 0;

  if(var_0)
    self.burnfxsuppressed++;
  else
    self.burnfxsuppressed--;
}

clearburnfx() {
  self notify("_encstr_96410C3F94AFF8D6E3B39318A8A3");
  thread stopburnfx();
  self.burnfxsuppressed = undefined;
  self.burnfxplaying = undefined;
  self.flare_thread = undefined;
}

startburnfx() {
  self notify("_encstr_88490BB91DDEE009AEC99B8CC2");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88490BB91DDEE009AEC99B8CC2");
  var_0 = remove_invulnerability(self.flare_thread);

  for(;;) {
    var_1 = isDefined(self.burnfxsuppressed) && self.burnfxsuppressed > 0;
    var_2 = isDefined(self.burnfxplaying);

    if(var_1 && var_2) {
      self setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_A7A408B9CA5D1D4E2C63");
      scripts\mp\damage::dequeuecorpsetablefunc("_encstr_A9B10826EAC9374BCDB3");
      self.burnfxplaying = undefined;
    } else if(!var_1 && !var_2 || var_0 != self.burnfxplaying) {
      self setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", var_0);
      self.burnfxplaying = var_0;

      if(!var_2)
        scripts\mp\damage::enqueuecorpsetablefunc("_encstr_A9B10826EAC9374BCDB3", ::burnfxcorpstablefunc);
    }

    waitframe();
  }
}

stopburnfx() {
  self notify("_encstr_88490BB91DDEE009AEC99B8CC2");

  if(isDefined(self.burnfxplaying)) {
    self setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_A7A408B9CA5D1D4E2C63");
    scripts\mp\damage::dequeuecorpsetablefunc("_encstr_A9B10826EAC9374BCDB3");
    self.burnfxplaying = undefined;
  }
}

burnfxcorpstablefunc(var_0) {
  var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_86390885FB5A76780D42", 0);
}

_id_13018(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1);

  if(isPlayer(var_1)) {
    thread grenadestuckto(var_0, var_1);

    if(isalive(var_1))
      thread _id_13016(var_0, var_1);
  }
}

_id_13016(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_BDF90C4D10A95F47E990CAF2D83B");
  var_0 waittill("_encstr_860808CB78E2984063BA", var_2);
  thread _id_13017(var_1, var_2);
}

_id_13017(var_0, var_1) {
  var_2 = distancesquared(var_1, var_0.origin);
  var_3 = 5000;

  if(var_2 > var_3) {
    return;
  }
  var_0 scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
  var_0 dodamage(var_0.maxhealth, var_1, self, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", getcompleteweaponname("_encstr_92A70ABB8267F5E0D89F6351"));
  var_0 scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
}