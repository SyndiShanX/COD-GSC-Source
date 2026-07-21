/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_alt_mode_zxp.gsc
***********************************************/

init() {
  if(!getdvarint("_encstr_8714143EEB4366550A69A8C8F36913387395503258F3", 0)) {
    return;
  }
  level.disable_super_in_turret.brmayconsiderplayerdead = 1;
  level.disable_super_in_turret._id_146E7 = 1;
  level.disable_super_in_turret._id_146C9 = init_warning_levels();
  level.disable_super_in_turret._id_146BD = getdvarint("_encstr_BE8412F37E20A8AEF56EE25B433763B00B085B53", 300);
  level.disable_super_in_turret._id_146F1 = getdvarint("_encstr_A279201A762D39B29B210B0B701672E2FB1E6417E6F992F581F84F9B708822CAB32E", 0);
  level.disable_super_in_turret._id_146F2 = getdvarint("_encstr_820926104772201146FFF5E9218FCD3041EAA122464CB88D21A1D389CF0AE5D1A7F80C535A6ECFDB", 80);
  level.disable_super_in_turret._id_146F8 = getdvarint("_encstr_845329B7DF73F84812B1227A62D740287A331B13CF8A38584A17AFD18CD9D0D15237B18133527EA07FAD33", 1);
  level.disable_super_in_turret.brking_movenextcirclecenter = getdvarint("_encstr_84E41C889F62E6CD2329CAD3FA291348D41720719307F885BA4F505D96D3", 1);
  level.disable_super_in_turret._id_146D5 = getdvarfloat("_encstr_871D159B1BC9F5314EFA4F1E07FA38D29BCEFA9C16A3B2", -1);
  level.disable_super_in_turret._id_146D6 = getdvarfloat("_encstr_B14D15CD36397D314ED7E93C83BE1CA5739DFA3A5AADAC", 0.5);
  level.disable_super_in_turret._id_146D2 = getdvarint("_encstr_92BC1740EA425FA923AFCAC3786FD0C36DB14818925A73AD57", 4);
  level.disable_super_in_turret._id_146E5 = getdvarfloat("_encstr_993423BFD77BF0701AB93A729ACF0815C2570D5F3B122D2B1F8A01A985DD295BEA5787AB47", 1.0);
  level.disable_super_in_turret._id_146E6 = getdvarfloat("_encstr_8615243BA9A3BFCDD8871AD05A091393FF4AE6EF738F6B67382FC77B8CC7A9E865A1A62F29B6", 0.5);
  level.disable_super_in_turret._id_146E3 = getdvarfloat("_encstr_BD2824336A93F840D217B5C940F188BD9FA2283E8227A980283FAFF779E5C8680F6A86A13AC7", 1.0);
  level.disable_super_in_turret._id_146E4 = getdvarfloat("_encstr_ADE225BBE21B60D85A9F4D41D8499335E73A90A67ABF2108B087276FF16D70909F536B2ED207E6", 1.5);
  level.disable_super_in_turret._id_146E2 = getdvarint("_encstr_B8F012C862CAE711AB37524BF0F79B7F73EA5840", 1);
  level.disable_super_in_turret._id_12820 = getdvarint("_encstr_83C71B1B42BBC078FA3FADA138E9B090C75AB3832947B7D8951CBFA75E", 1);
  level.disable_super_in_turret._id_146CF = getdvarfloat("_encstr_ABC113E636C9FA989CBE3D3C0EBEB95DD642963AB9", 3);
  level.disable_super_in_turret._id_146D0 = getdvarfloat("_encstr_8FA717573F9318A8B21182DAC2B78045DA3BFBD187F8D5B8FF", 20);
  level.disable_super_in_turret._id_146BF = getdvarint("_encstr_8F0B1750FA526F9913BFDAD3887F20D7BDC2D07870EA53707B", 1);
  level.disable_super_in_turret._id_146E8 = getdvarint("_encstr_9B95216E6C27FA13C9F5F4E1C17D93AC6E382CEE73F56E1A578E23B7DDE6EB9AAE9DEC", 1);
  level.disable_super_in_turret._id_146CE = getdvarfloat("_encstr_A796176606FB6799A2B7107873F7507B5264D36D9AB0EB8091", 2);
  level.disable_super_in_turret._id_146CC = getdvarfloat("_encstr_8F7F162E3AEB06B242DE4093C3E86B7590486B23936F1C06", 2);
  level.disable_super_in_turret._id_146CD = getdvarfloat("_encstr_8B7F16CD3639FA989CFAE90F38F5CD5DB5124B1D6EA1164E", 3);
  level.disable_super_in_turret._id_146D1 = getdvarfloat("_encstr_B42D180726A838B5F257883AB3D1A2EDA710501BCBAC73251710", 4);
  level.disable_super_in_turret._id_146FC = getdvarint("_encstr_8BAA15731E7AB161E319027033CF0770695F851040E925", 1);
  level.disable_super_in_turret._id_1470A = getdvarint("_encstr_ADBB1D20CB937FE2C297429AA301756A20333B10DD2908BF8B2B67D1D9A5A1", 0);
  level.disable_super_in_turret._id_146FB = getdvarint("_encstr_969F1E373693BE134EF54F0F38F5D3F6B5315AB2EB370E0B77DCF5C226F6CECA", 0);
  level.disable_super_in_turret.spawndragonsbreathstruct = getdvarint("_encstr_B2D91B7B77AD67B3858F7AC061A15308A840F091C38271B3A55E2BA47A", 1);
  level.disable_super_in_turret.fluctuatevalues = getdvarint("_encstr_AF9719961B1B272D723992E02121799D304A41DF7467A8D32F0B5E", 1);
  level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback = getdvarint("_encstr_85191CB39F361738A209F85B737FF8F5403C66784BDB911FD90F4B7F8262", 3);
  level.disable_super_in_turret.vehicle_occupancy_getreserving = getdvarint("_encstr_8A801C58900BF79B42AF08E949FFDA0B67A719CB326FF1ACDB61B39F38F0", 0);
  level.disable_super_in_turret.spawndistancemax = getdvarint("_encstr_ABF7166E8D93AFC493F5E9E183BE37CAE4D9AC9CF51A5D32", 0);
  level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols = getdvarint("_encstr_813821635FA3BF364DBFA58819C7E83068FB393B62D9B075EF032B79390A95CF7711F4", 20);
  level.disable_super_in_turret.vehicle_occupancy_mp_changedseats = getdvarint("_encstr_A79121CDC693BE264EBEA7C338FA35EAB5387D1D272CB1CAF5EA8364FAB7CCCC37CAD1", 30);
  level.disable_super_in_turret._id_1470C = getdvarint("_encstr_858219CD1B9CEB26C97D4F3C387D9EDB5B315A95EB67D2E64BF6E6", 1);
  level.disable_super_in_turret._id_1470D = getdvarint("_encstr_B8292193B8454913DB20F2F84F868B8D9328BA4AF115BC1F9010FE27E88BBF9229D823", 1);
  level.disable_super_in_turret._id_14061 = getdvarint("_encstr_B40F2443EA0D695E22A94BE012299B2A6DB760255DB8DE4769FF87AA4321F0FC879F78FFA0D7", 0);
  level.disable_super_in_turret._id_146BC = getdvarfloat("_encstr_8D0F228BB66E8102526F43789BBEA3F7E5366FBF21E4658F410BEB6FCB36C71BE9B1EB52", 0.65);
  level.disable_super_in_turret._encstr_A27E187BE838FA0A6B16F62D0603828120D8B7DB2BF03C92A7B5 = getdvarint("_encstr_8A6628DCD893F526E4AF9E870EAFF4BDB5982D957D6C0B37D7DC56567DB0E632D7B783CA737D36B7F63A", 1);
  level.disable_super_in_turret._encstr_BA7D1772959A8D6825F318B0E379E3DD027D65FBEF927BF30D = getdvarint("_encstr_952A25E6867BE719223790F8F37752CFD26E536511936BE308E7F040676F2877FA90DDFE734B23", 1);
  level.disable_super_in_turret._encstr_820720585FB5BE70CDA5CBFF2177D7B040E6A462467C28942180D170D88AE7CDE348 = getdvarint("_encstr_AA872F1E7E831FD1EAEF5840BB2F2A879AA69BADD9DB23BBB02F28081F27E0AF328E0EADAA13F3C08CBFB0B0DF435B21CA", 0);
  level.disable_super_in_turret._encstr_811916222D694B2B0FC5D889B14A17739332293371E89843 = getdvarint("_encstr_91E11F4661CE4913D35F5A18D5E1B3838F0D7E8330087586FFB1D59BFBA35F48F8", 1);
  level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto = 0;
  level._id_13364 = 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B8E81758710D39A058D0077F601661F2C998E9D0E8ABA2F101"] = "_encstr_8A871ACD576D209BBFD113981AE7457809B91D59CF59A8D0E71A08A1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_974319F8C8703F1BE593FFF7FB1572474030F3052668C7424EBBC7"] = "_encstr_97E31C4F7B5BC44B59EBE856C2D6B5853A957D4BCD8EBDAF3DF6AD315A95";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC1417C263A8697B756192298B584F5F68FD551F93632C532D"] = "_encstr_B6CE10A7B7AD264B95BE9BCAB09C7D563723";
  level._effect["_encstr_85810DE97B5B4C96957D8E39B0B9DC"] = loadfx("_encstr_993A3BCE33E1972DDDC1D731E497CE2CDAAC388DB0CBE5E9B7D631B4CA97EC33E1AFA7B5C4EBE89C85379BA5A34BED37BE3A7BBEA1D55B16E6B83BCC3C");
  level._effect["_encstr_9A660D40EFC85DD88169E6D1781F73"] = loadfx("_encstr_8FF936A34872AF12679341069EEFCAA978C833B3180A17EBBFC116FC0D87937622B1833FB8269633F3ED1FF6E1D9D92B8BD067C332BBCE5B");
  level.disable_super_in_turret.empvfx = loadfx("_encstr_BA383875AB60676B64F0418A2217E84ADDF8DB217FCA6E63E0F71650A83D480F831FE0E3E578AA50C508047AAFA84338E7C1603863B0B58B567B");
  level.disable_super_in_turret.start_coop_defuse_infiltrate = loadfx("_encstr_AD7D34E3B7484A834BA2F7959396DC70E5CFAB389EA192C2E29F858BE77E9CF098295290C6DFE07D3A97E5DF4BE3664867FE18E92A5C");
  thread toggleusbstickinhand();
}

toggleusbstickinhand() {
  waittillframeend;

  if(level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback > 0 && level.disable_super_in_turret.vehicle_occupancy_getreserving)
    level.vehicle_occupancy_forceweaponswitchallowed = undefined;

  thread _id_13283();
  thread _id_1472D();
}

_id_126A4() {
  var_0 = self;

  if(!isDefined(var_0.spawndomplateflag))
    var_0 _id_12725();

  wait 0.5;
  var_0 _id_125FC();
  wait 2;
  var_0 _id_12723(0);
}

modifyplayerdamage(var_0) {
  var_1 = var_0.damage;
  var_2 = isPlayer(var_0.attacker) && var_0.attacker _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
  var_3 = isDefined(var_0.attacker) && var_0.attacker nukefridgewatcher();
  var_4 = isPlayer(var_0.victim) && var_0.victim _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
  var_5 = scripts\mp\utility\weapon::getweaponbasenamescript(var_0.objweapon);

  if(var_2 && var_4 && var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981") {
    if(!level.disable_super_in_turret._id_146F1)
      var_1 = 0;
    else
      var_1 = level.disable_super_in_turret._id_146F2;
  } else if(var_2 && !var_4 && !var_0.attacker isinexecutionattack() && var_0.victim isinexecutionvictim())
    var_1 = 0;
  else if(isDefined(var_0.attacker) && istrue(var_0.attacker.isjuggernaut) && var_4 && var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981")
    var_1 = var_0.victim.maxhealth / 3;
  else if(var_4 && var_0.meansofdeath == "_encstr_87A10C9D24E997A01F21838F3D34")
    var_1 = 0;
  else if(var_4 && isDefined(var_0.inflictor) && isDefined(var_0.inflictor.streakinfo) && (var_0.inflictor.streakinfo.streakname == "_encstr_A2E60C6BC099B7E1A0A93A398F48" || var_0.inflictor.streakinfo.streakname == "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895" || var_0.inflictor.streakinfo.streakname == "_encstr_8FD90E38C0E2EB692B28D0CBEB9E1FB4")) {
    var_6 = var_0.victim.maxhealth;
    var_7 = var_0.attacker.maxhealth;
    var_1 = var_0.damage * int(floor(var_6 / var_7));
  } else if(level.disable_super_in_turret._id_146F8 && var_4 && isexplosivedamagemod(var_0.meansofdeath) && isDefined(var_0.inflictor) && var_0.inflictor scripts\cp_mp\vehicles\vehicle::isvehicle())
    var_1 = 0;
  else if(var_4 && (var_0.meansofdeath == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_0.meansofdeath == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF"))
    var_1 = var_0.damage * getdvarfloat("_encstr_9A672402E32B2780636962C1FBE75143F343B7FB09EBC326B3958F89255D55F3E89AB5C8179B", 3.0);
  else if(var_2 && !var_4 && var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981") {
    var_8 = var_0.victim.maxhealth;
    var_9 = level.disable_super_in_turret._id_146CF;

    if(istrue(var_0.victim.isjuggernaut))
      var_9 = level.disable_super_in_turret._id_146D0;

    if(!level.disable_super_in_turret._id_146BF)
      var_8 = var_8 + var_0.victim.br_maxarmorhealth;

    var_1 = int(ceil(var_8 / var_9));
  } else if(var_4 && var_3 && istrue(var_0.victim._id_1423B))
    var_1 = 0;
  else if(var_2 && !var_4 && var_0.meansofdeath == "_encstr_A1ED0BA9FF84562B60BA073E83" && var_5 == "_encstr_86B108781A36271E4F70") {
    var_10 = spawnStruct();
    var_10.origin = var_0.point;
    var_0.victim thread scripts\mp\equipment\concussion_grenade::applyconcussion(var_10, var_0.attacker);
  } else if(var_4) {
    var_11 = 0.7;
    var_12 = scripts\mp\utility\weapon::getweaponrootname(var_0.objweapon);
    var_13 = weaponclass(var_5);
    var_14 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::tutzonetriggerlogic(var_0.idflags);

    if(!var_14) {
      switch (var_13) {
        case "_encstr_850707F7E5833355B8":
          if(var_0.shitloc == "_encstr_81CC0586952C91" || var_0.shitloc == "_encstr_A6CC076A05751852B3") {
            if(_encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::usefailvehiclemsg(var_12))
              var_1 = int(ceil(level.disable_super_in_turret._id_146BD * var_11));
            else
              var_1 = level.disable_super_in_turret._id_146BD;
          }

          break;
        default:
          if(var_0.shitloc == "_encstr_81CC0586952C91" || var_0.shitloc == "_encstr_A6CC076A05751852B3") {
            var_15 = getdvarfloat("_encstr_856E15E68D93D7E0D80BF25639FADA163CA1AC0B8DD134", 100.0);
            var_16 = var_15;

            if(level.disable_super_in_turret._id_14061)
              var_16 = var_16 + _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::_encstr_861519B969C353C3787F9DC45B2A71A97E3BE5DF730B4966A121D1();

            var_1 = int(ceil(var_1 / var_16 * level.disable_super_in_turret._id_146BD * level.disable_super_in_turret._id_146BC));
          }

          break;
      }
    }

    var_17 = "_encstr_A67112DEBE43DF112A2F9880FB6F4BDF1AE55D70" + var_13;
    var_18 = 0;

    if(var_13 == "_encstr_A1100738A33A638123")
      var_18 = 0.7;

    var_19 = getdvarfloat(var_17, var_18);

    if(var_19 != 0)
      var_1 = int(ceil(var_1 * var_19));

    var_20 = "_encstr_A67112DEBE43DF112A2F9880FB6F4BDF1AE55D70" + var_12;
    var_18 = 0;

    if(var_12 == "_encstr_B10B12CC2CE969D3A8513F1BC883B4723B648253")
      var_18 = 1.43;

    var_21 = getdvarfloat(var_20, var_18);

    if(var_21 != 0)
      var_1 = int(ceil(var_1 * var_21));
  }

  return var_1;
}

nukefridgewatcher() {
  return scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56";
}

_id_11CA1(var_0) {
  var_1 = var_0.damage;
  var_2 = var_0.victim;
  var_3 = isPlayer(var_0.attacker) && var_0.attacker _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
  var_4 = var_2.vehiclename;

  if(var_3 && var_0.meansofdeath == "_encstr_8DED0A21C79B660BC7588981") {
    switch (var_4) {
      case "_encstr_8C190467402B":
        var_1 = var_2.maxhealth / level.disable_super_in_turret._id_146CC;
        break;
      case "_encstr_9A120A1D8536F5E4ED3BB293":
      case "_encstr_85DE05A6B2AC0E":
        var_1 = var_2.maxhealth / level.disable_super_in_turret._id_146CD;
        break;
      case "_encstr_BAC20FBEE6F88945F163A37BD68409923B":
      case "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6":
        var_1 = var_2.maxhealth / level.disable_super_in_turret._id_146D1;
        break;
      case "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F":
      case "_encstr_9A8F0CB1A5E8471BB2EB894B39C8":
        var_1 = var_2.maxhealth / level.disable_super_in_turret._id_146CE;
        break;
      default:
        break;
    }

    var_1 = int(ceil(var_1));
  }

  return var_1;
}

_id_11B80(var_0, var_1) {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    return 1;

  var_2 = var_0 _encstr_B45218CA58D8A99AFE271B0F43A9D2F27BC0C61491B068125405(var_1);

  if(var_2)
    var_0.respawningfromtoken = 1;
  else if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
    thread _id_12538();

  return !var_2;
}

_id_1365D(var_0) {
  if(istrue(var_0.br_infilstarted) && scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") && var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
    var_0 _id_12645();
    return 1;
  }

  return 0;
}

_id_11B16() {
  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    return 0;

  return !istrue(self.respawningfromtoken);
}

_encstr_B45218CA58D8A99AFE271B0F43A9D2F27BC0C61491B068125405(var_0) {
  if(!istrue(var_0)) {
    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
      return 0;
  }

  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") || level.gameended || !level.disable_super_in_turret._id_146E7)
    return 0;

  return 1;
}

_id_126D2(var_0) {
  if(!istrue(var_0)) {
    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
      thread _id_12538();
      return 0;
    }
  }

  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") || level.gameended || !level.disable_super_in_turret._id_146E7)
    return 0;

  thread _id_12723(0);
  return 1;
}

_id_125F7(var_0, var_1) {
  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    return 0;

  if(level.gameended)
    return 1;

  if(istrue(self._id_12CA8))
    return 1;

  if(istrue(self.respawningfromtoken) && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
    self.respawningfromtoken = undefined;
    thread _id_12723(0);
  } else if(!scripts\mp\utility\damage::playershoulddofauxdeath(0))
    var_0.victim thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(var_0, var_1);

  return 1;
}

_id_12538() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setscriptablepartstate("_encstr_BACB074025B01AAA28", "_encstr_BA19049F4B2D");
  self setscriptablepartstate("_encstr_8D6D0C78D7A9D74ECACB31BF4740", "_encstr_B4250C393D87BECBF505130E27C3");
  self setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);

  if(level.disable_super_in_turret._id_1470C) {
    _id_125DA();

    if(!level.disable_super_in_turret._id_1470D)
      self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_A7A408B9CA5D1D4E2C63");

    scripts\mp\utility\player::restorebasevisionset(0);
  }

  waittillframeend;
  _id_12681(0, 1);
  _id_1262B(0);
}

_id_125DA() {
  foreach(var_1 in level.players) {
    if(!var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
      var_1 hudoutlinedisableforclient(self);
  }
}

_id_12681(var_0, var_1) {
  self.iszombie = var_0;
  _id_12682(var_0);

  if(isDefined(level.disable_super_in_turret._id_11B5B))
    _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::_id_126E6(var_0);

  if(var_0) {
    self notify("_encstr_84290BF4DBB698B42BAFCD2BA3");

    if(level.disable_super_in_turret.spawndistancemax)
      _id_12725();

    self._id_11F39 = 0;
    self.bcdisabled = 1;
    self.plunderlimit = 1;
    _id_1267D(0);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(9);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(10);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(11);
    _id_14033("_encstr_ACF20B9D7D8575919257DF8095", self._id_11F39);
  } else {
    self notify("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
    self._id_11F39 = undefined;
    self.bcdisabled = undefined;
    self.plunderlimit = undefined;
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);

    if(isDefined(level.disable_super_in_turret._id_11B5B) && !istrue(level.disable_super_in_turret._encstr_9A1514DCA1F677C8EDB33A0BCEB91D7B43BAD6169B37))
      _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::_id_125CE();
  }

  level notify("_encstr_854F1AA7858A6B39E24779E8E7057183A26C10A4D1C231E1D63FA050");
  scripts\cp_mp\utility\train_utility::_encstr_88CE26357EF7292093E72ED51B1B4509A7AF0BBDA219B39B8D19E96A43F3D648FB0572ABFDD3F1B2();
  _encstr_8EA428CB926B2B188BE3D75B08A558E7FF6AA3320B6F5EAA26DA2FBF0F1D40B68F93587B229B38303AA3::_id_126E0();

  if(isDefined(level._encstr_93CD1CF9744ED8BDC353F379FA3365D865D14971F2B5307FE32BC9433237))
    self[[level._encstr_93CD1CF9744ED8BDC353F379FA3365D865D14971F2B5307FE32BC9433237]](self.iszombie);

  self notify("_encstr_A34F139633DAC9CE429FB0A8B39D8131C2DB8D150A");

  if(istrue(var_1)) {
    self lerpfovbypreset("_encstr_8B1608EC43B8D647A113");

    if(level.disable_super_in_turret._id_1470D)
      thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
  }
}

init_warning_levels() {
  var_0 = [];
  var_0["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_0["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = "_encstr_A7ED0AD79F73990E28334B92";
  var_0["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  var_0["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  var_0["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_968411DCBAC12B4E7D13E4BE563C8E27851BD1";
  var_0["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_AC9C0FEA0FF30A29692883BF99A00D4249"];
  var_0["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  var_0["_encstr_81E6112CD2D9B12F700387D0E8A7C32341A7DD"] = "_encstr_8BBA05185F8B99";
  return var_0;
}

spawnangle(var_0) {
  var_1 = getarraykeys(level.teamdata);

  foreach(var_3 in var_1) {
    var_4 = level.teamdata[var_3]["_encstr_9775086022BE1B413B8B"];

    foreach(var_6 in var_4) {
      if(var_6 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
        if(level.disable_super_in_turret.spawndistancemax)
          var_6 _id_12700();

        var_6 _id_12631();
        continue;
      }

      var_6 _id_12631();
    }
  }
}

vandalize_target_think(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isalive(var_0) && !istrue(var_0.respawningfromtoken) && !var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
    return 0;

  return !istrue(var_0.delay_enter_combat_after_investigating_grenade) || var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
}

get_chopper_minigun_start_node(var_0) {
  if(var_0.scriptablename == "_encstr_A378104B25894AD7104638C5D971F333D383") {
    if(self._id_11F39 >= level.disable_super_in_turret._id_146D2)
      return 12;

    return 1;
  }

  return undefined;
}

_id_12725() {
  var_0 = -60;
  var_1 = 120;
  var_2 = 180;
  self.spawnboardroom_juggdrop = _id_12530(var_0, var_1, "_encstr_8253060E2B5FE330", "_encstr_8F8D07BB035BDAD5CD", "_encstr_A5C407E1658D3339B3", "_encstr_8F8D07BB035BDAD5CD", &"_encstr_8E2F14D889B79063F760BEBD793EC76D2D39C15059E9", 0);
  self.spawnboardroom_loadoutdrop = _id_12530(var_0, var_1, "_encstr_A5AD056A019C63", "_encstr_8F8D07BB035BDAD5CD", "_encstr_A5C407E1658D3339B3", "_encstr_8F8D07BB035BDAD5CD", &"_encstr_B491169439471AF13A07BDB35DD159489FE02C7C91C7D941", level.disable_super_in_turret._id_146D2);
  self.spawndomplateflag = _id_12530(0, var_2, "_encstr_A5C407E1658D3339B3", "_encstr_8F8D07BB035BDAD5CD", "_encstr_A5C407E1658D3339B3", "_encstr_8F8D07BB035BDAD5CD", &"_encstr_8CF20EF1DBC7DE21894D52D03D40CBE5");
}

_id_12530(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
  var_8.x = var_0;
  var_8.y = var_1;
  var_8.alignx = var_2;
  var_8.aligny = var_3;
  var_8.horzalign = var_4;
  var_8.vertalign = var_5;
  var_8.alpha = 0;
  var_8.glowalpha = 0;
  var_8.hidewheninmenu = 1;
  var_8.archived = 0;

  if(isDefined(var_6))
    var_8.label = var_6;

  if(isDefined(var_7))
    var_8 setvalue(var_7);

  return var_8;
}

_id_12682(var_0) {
  if(istrue(var_0))
    self.game_extrainfo = self.game_extrainfo | 4096;
  else
    self.game_extrainfo = self.game_extrainfo &~4096;
}

_id_12723(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");

  if(level.gameended) {
    return;
  }
  if(!isDefined(level.teamdata[self.team]["_encstr_9B720F83F3966B7258B08E54A959993265"]) && !isDefined(level._id_12D05))
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_luicallback("_encstr_AC1417C263A8697B756192298B584F5F68FD551F93632C532D", self.team);

  _id_131CD(self.team);
  _id_1267D(1);
  _id_12727(1);
  waittillframeend;
  _id_12681(1);

  if(istrue(var_1))
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self, "_encstr_8D3209EDAB3A8927CA2CB5");
  else
    self._id_12CA8 = 1;

  if(isDefined(level._id_12D05))
    _id_12645();
  else if(var_0)
    _id_126EE();
  else
    _id_12645();

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_BA4F1D9AB14B1BF5DBA1377B6150A5F2335D2A12AFDFA21480981F6380086E"))
    [var_3, var_4] = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_BA4F1D9AB14B1BF5DBA1377B6150A5F2335D2A12AFDFA21480981F6380086E");
  else
    [var_3, var_4] = _id_12582();

  [var_3, var_7] = _id_12722(var_3, var_4);
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadetoblack();
  wait 1;
  scripts\mp\class::loadout_emptycacheofloadout("_encstr_AAAC09D09972B9C83F2B7F");
  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.disable_super_in_turret._id_146C9;
  self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  self.forcespawnangles = var_4;
  self.forcespawnorigin = var_7;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  thread scripts\mp\music_and_dialog::_id_1469B();
  scripts\cp_mp\execution::_clearexecution();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer(1);
  _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
  self notify("_encstr_9A83101A4D14D775F893B5791590C7EB2743");
  var_8 = getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_8);
  var_9 = getcompleteweaponname("_encstr_A9FA118BE3BF87F959E780806F65F34F438DF6");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_9, undefined, undefined, 1);
  self detachall();
  self setModel("_encstr_B8971533ABD88DC4DE19BCFAA77BAD13B495BE16AF2639");
  self setviewmodel("_encstr_A3E1112DAD69B08E079B4ED2623F4E383F078B");
  scripts\mp\utility\player::_setsuit("_encstr_88A00E4BEE077D3DEDAD314BB27DD61C");

  if(level.disable_super_in_turret._encstr_811916222D694B2B0FC5D889B14A17739332293371E89843)
    scripts\cp_mp\execution::_giveexecution("_encstr_8AA1270F6925A2E528A8A5ED860828B985ED87CBCBD6EBA9D0761A3799C15612DE1B2F3381E8173472");
  else
    scripts\cp_mp\execution::_clearexecution();

  var_10 = "_encstr_8BB610607BBC8B03496D97150282619002AF";
  var_11 = "_encstr_A7A408B9CA5D1D4E2C63";

  if(self isscriptable() && self getscriptablehaspart(var_10)) {
    var_12 = self getscriptablepartstate(var_10);

    if(var_12 != var_11)
      self setscriptablepartstate(var_10, var_11);
  }

  _id_126BD(var_3, var_4, var_7);
  self skydive_interrupt();
  self.play_disguise_vo = 5;
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  self skydive_beginfreefall();
  thread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_9);
  _id_1262B(1);
  thread _id_12710(var_9, scripts\cp_mp\utility\game_utility::turretdisabled());
  thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::defend_wave_2();
  thread _id_1272A();

  if(level.disable_super_in_turret.brking_movenextcirclecenter)
    thread _id_12724();

  _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::_encstr_A1231B2173D27BE0A28BD369B68C283DEAB7D18BC75BC838DCA5F8205F();
  thread _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::_encstr_ADE31ADB125773E05AB55979C983B8BDFF1AB0019ABFA6A0B4AE0B4F();
  thread _id_1270D();
  self disableexecutionvictim();
  scripts\mp\utility\perk::giveperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B");
  scripts\mp\utility\perk::giveperk("_encstr_8106160B38AFA8CBB915AB7088C3F3BA936DA343F5E43862");
  scripts\mp\utility\perk::giveperk("_encstr_B11F14CA2FD32A490948E3DFB9232843A34893C69D27");
  scripts\common\utility::allow_crate_use(0);
  scripts\common\utility::allow_vehicle_use(0);
  scripts\common\utility::brjugg_droponplayerdeath(0);
  self lerpfovbypreset("_encstr_8B880E3B782B3B528F416928DF5B3D4D");

  if(level.disable_super_in_turret._id_1470D)
    self setclientomnvar("_encstr_A97717236F39FDF8B9C78BC0ED6578A6724F9FBDF753B190C9", 0);

  thread _id_126FF();
  self setscriptablepartstate("_encstr_8D6D0C78D7A9D74ECACB31BF4740", "_encstr_BACB074025B01AAA28");

  if(getdvarint("_encstr_B1112B37D84EBE1339AFD30FC1FA99BD9CB1957D73AC1D33D2566319EB1AD2B31AF5C6ED46F5F4DBD61396B2E6", 0))
    self unmarkkeyframedmover(1);

  if(isDefined(level._id_12D05))
    scripts\mp\hud_message::showsplash("_encstr_AF6415422BC8A337C0B3E1E42F9BBB0F87268A6B31BB93");
  else
    scripts\mp\hud_message::showsplash("_encstr_857E178993D7EC16B5958EBC3895D79E1E38D78D0D16DCCE2B");

  if(!scripts\mp\utility\perk::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743"))
    scripts\mp\utility\perk::giveperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743");

  self.maxhealth = level.disable_super_in_turret._id_146BD;
  self.health = self.maxhealth;
  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::scriptablescurid(0);
  self._id_12CA8 = undefined;
  wait 3;

  if(!isDefined(level._id_12D05) && scripts\mp\utility\game::round_vehicle_logic() != "_encstr_831904FDF363") {
    foreach(var_14 in level.teamdata[self.team]["_encstr_9775086022BE1B413B8B"]) {
      if(self == var_14) {
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B8E81758710D39A058D0077F601661F2C998E9D0E8ABA2F101", var_14);
        continue;
      }

      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_974319F8C8703F1BE593FFF7FB1572474030F3052668C7424EBBC7", var_14);
    }
  }
}

_id_1264B(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
    if(istrue(self._id_146C0))
      return int(level.disable_super_in_turret._id_146E5 * var_0);
    else
      return int(level.disable_super_in_turret._id_146E6 * var_0);
  }

  return undefined;
}

_id_1262B(var_0) {
  if(!istrue(level.disable_super_in_turret._encstr_A27E187BE838FA0A6B16F62D0603828120D8B7DB2BF03C92A7B5))
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125CF(var_0);

  if(var_0) {
    if(level.disable_super_in_turret.spawndistancemax) {
      self.spawnboardroom_juggdrop.alpha = 1;
      self.spawnboardroom_loadoutdrop.alpha = 1;
      self.spawndomplateflag.alpha = 1;
    }

    self disableweaponpickup();
  } else {
    _id_12700();
    self enableweaponpickup();
  }
}

_id_131CD(var_0) {
  level.teamdata[var_0]["_encstr_9B720F83F3966B7258B08E54A959993265"] = gettime();
}

_id_1267D(var_0) {
  self.tut_popup_listener = var_0;
}

_id_12727(var_0) {
  var_1 = self.team;
  scripts\mp\utility\teams::_id_140C9("_encstr_ABA2055BF623CA", var_1, self);
  _id_126D8();

  if(istrue(var_0))
    [[level.updategameevents]]();
}

_id_12700() {
  if(isDefined(self.spawnboardroom_juggdrop))
    thread kioskfiresaledoneforplayer(self.spawnboardroom_juggdrop, 1.5);

  if(isDefined(self.spawnboardroom_loadoutdrop))
    thread kioskfiresaledoneforplayer(self.spawnboardroom_loadoutdrop, 1.5);

  if(isDefined(self.spawndomplateflag))
    self.spawndomplateflag destroy();

  self.spawnboardroom_juggdrop = undefined;
  self.spawnboardroom_loadoutdrop = undefined;
  self.spawndomplateflag = undefined;
}

kioskfiresaledoneforplayer(var_0, var_1) {
  wait(var_1);

  if(isDefined(var_0))
    var_0 destroy();
}

_id_125FA() {
  return isDefined(self._id_1472F);
}

_id_1264A(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
    if(istrue(self._id_146C0))
      return 1 / level.disable_super_in_turret._id_146E3 * var_0;
    else
      return 1 / level.disable_super_in_turret._id_146E4 * var_0;
  }

  return undefined;
}

onuse(var_0) {
  thread _id_120A7(var_0);
}

_id_120A7(var_0) {
  if(!isDefined(var_0)) {
    thread _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::_encstr_996312C320A07F73D329FDF50DA7DB2A48731F07(self);
    return;
  }

  if(!playercanusetags(var_0)) {
    return;
  }
  if(istrue(level.gameended)) {
    return;
  }
  thread _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::_encstr_996312C320A07F73D329FDF50DA7DB2A48731F07(self, undefined, var_0);

  if(var_0._id_11F39 >= level.disable_super_in_turret._id_146D2) {
    return;
  }
  var_0._id_11F39++;

  if(level.disable_super_in_turret.spawndistancemax)
    var_0 _id_125D4();

  var_0 _id_14033("_encstr_ACF20B9D7D8575919257DF8095", var_0._id_11F39);

  if(isDefined(level.disable_super_in_turret._id_11B5B) && var_0._id_11F39 >= level.disable_super_in_turret._id_146D2)
    var_0 thread _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::_id_126FA();
}

playercanusetags(var_0) {
  return var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3();
}

_id_125D4() {
  var_0 = (0, 1, 0);
  self.spawnboardroom_juggdrop setvalue(self._id_11F39);
  self.spawnboardroom_juggdrop thread spawn_vindia_assault3(var_0);
  self.spawnboardroom_loadoutdrop thread spawn_vindia_assault3(var_0);
}

spawn_vindia_assault3(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(istrue(self._id_1293B)) {
    return;
  }
  var_1 = 0.5;
  var_2 = 4;
  self._id_1293B = 1;
  var_3 = self.fontscale;
  var_4 = self.color;

  if(isDefined(var_0))
    self.color = var_0;

  self changefontscaleovertime(var_1);
  self.fontscale = var_2;
  wait(var_1);
  self changefontscaleovertime(var_1);
  self.fontscale = var_3;
  wait(var_1);
  self.color = var_4;
  self._id_1293B = undefined;
}

_id_125FC() {
  var_0 = spawnStruct();
  var_0.current = self getcurrentprimaryweapon();
  var_0._id_12889 = [];
  var_0.brtdm_config = [];
  var_0.brtruck_cleanupents = [];
  var_0.brtruck_ontimelimit = [];
  var_0.offhands = [];
  var_0.nvidiaansel_overridecollisionradius = [];
  var_1 = [];
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_4) && !issubstr(var_4.basename, "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") && !scripts\mp\utility\weapon::unset_relic_mythic(var_4.basename))
      var_1[var_1.size] = var_4;
  }

  foreach(var_7 in var_1) {
    var_8 = createheadicon(var_7);
    var_0.brtdm_config[var_8] = weaponclipsize(var_7);
    var_0.brtruck_ontimelimit[var_8] = self getweaponammostock(var_7);

    if(scripts\mp\utility\weapon::turnexfiltoside(var_7))
      var_0.brtruck_cleanupents[var_8] = self getweaponammoclip(var_7, "_encstr_A5AD056A019C63");

    if(getsubstr(var_8, 0, 4) == "_encstr_9B83050BD88EF5") {
      continue;
    }
    var_0._id_12889[var_0._id_12889.size] = var_7;
  }

  var_10 = self getweaponslistoffhands();

  foreach(var_12 in var_10) {
    if(var_12.basename == "_encstr_A51B0B2BD260444AAFCD6F86E2") {
      continue;
    }
    var_13 = self getweaponammoclip(var_12);

    if(var_13 <= 0) {
      continue;
    }
    var_0.offhands[var_0.offhands.size] = var_12;
    var_14 = createheadicon(var_12);
    var_0.brtdm_config[var_14] = var_13;
  }

  foreach(var_18, var_17 in self.equipment)
  var_0.nvidiaansel_overridecollisionradius[var_17] = var_18;

  var_0.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent)
    var_0.super = self.equipment["_encstr_BEB406F03B72BB3B"];

  self._id_1472F = var_0;
}

_id_126EE() {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
    self waittill("_encstr_A2B10C6E83C2BBB94BF65B4C2D95");
}

_id_12645() {
  self notify("_encstr_A2B10C6E83C2BBB94BF65B4C2D95");
  self _meth_87AA("_encstr_BACB074025B01AAA28");
  self setclothtype("_encstr_A99506D77CD5A833");
  scripts\mp\deathicons::spawn_carriables_from_prefabs_all(self);
}

run_track_enemy_patrollers(var_0, var_1, var_2) {
  var_3 = var_0 + var_1 * var_2;

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_3, 1)) {
    var_4 = vectortoangles(var_1 * -1);
    return [var_3, var_4];
  } else
    return [undefined, undefined];
}

_id_1270E() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = getdvarfloat("_encstr_AF081D5BEE4AC10E6337A5A9A3994EA8E382815355B4D8B7CA0F85ADB7C295", 10000);

  if(var_2 >= 0) {
    var_3 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12568(0);

    if(isDefined(var_3)) {
      var_0 = rocket_fuel_stability(var_3.origin, var_2);

      if(istrue(level._encstr_BA651BED2E392BD665E82A4328AD8D8372984D724B41139F5718921B20) && isscriptabledefined())
        var_0 = getclosestpointonnavmesh(var_0);

      var_0 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_0);
      var_1 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::registercarryobjectpickupcheck(var_0, var_3.origin);
    }
  }

  return [var_0, var_1];
}

rocket_fuel_stability(var_0, var_1) {
  var_2 = 3.14159;
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_4 = vectorNormalize(var_0 - var_3);
  var_5 = vectortoangles(var_4);
  var_6 = randomfloatrange(getdvarfloat("_encstr_86151C3BA9A3BFCDD8871ECD9AFB71B7BDE9FAD1B20D0E66A007BF6389EB", 10.0), getdvarfloat("_encstr_A9151CD71B537F02CD80AA67FEB14A1FB8795B27C04987FADDA4F91DEF89", 60.0));
  var_7 = var_4;
  var_8 = var_0 + var_7 * var_1;

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_8, 0))
    return var_8;

  var_7 = var_7 * -1;
  var_8 = var_0 + var_7 * var_1;

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_8, 0))
    return var_8;

  var_7 = vectorNormalize(var_3 - var_0);
  var_8 = var_0 + var_7 * var_1;

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_8, 0))
    return var_8;

  var_9 = var_1;
  var_10 = distance2d(var_0, var_3);
  var_11 = var_9 / var_10;

  if(var_11 > var_2)
    var_11 = var_2;

  var_12 = var_11 * 180 / var_2;
  var_8 = rotatepointaroundvector((0, 0, 1), var_0 - var_3, var_12) + var_3;

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_8, 0))
    return var_8;

  var_8 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_0, var_1);

  if(_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_8, 0))
    return var_8;

  return undefined;
}

_id_12582() {
  var_0 = 50;
  var_1 = 10000;
  [var_3, var_4] = _id_1270E();

  if(isDefined(var_3)) {
    var_3 = _encstr_8ECB1A8DA12BB1ADCDC12C77CD772DA3D0B4B9B5C2074E85914BD59B(var_3);
    return [var_3, var_4];
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent) || istrue(level.disable_super_in_turret._id_146FB))
    return [self.origin, self getplayerangles()];

  var_5 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  var_6 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_7 = var_5 + var_0;
  var_8 = (self.origin[0], self.origin[1], 0);
  var_9 = vectorNormalize(var_8 - var_6);
  [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);

  if(!isDefined(var_11)) {
    var_9 = var_9 * -1;
    [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);
  }

  if(!isDefined(var_11)) {
    var_9 = (1, 0, 0);
    [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);
  }

  if(!isDefined(var_11)) {
    var_9 = (-1, 0, 0);
    [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);
  }

  if(!isDefined(var_11)) {
    var_9 = (0, 1, 0);
    [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);
  }

  if(!isDefined(var_11)) {
    var_9 = (0, -1, 0);
    [var_11, var_4] = run_track_enemy_patrollers(var_6, var_9, var_7);
  }

  if(!isDefined(var_11)) {
    var_11 = self.origin;
    var_4 = self.angles;
  }

  var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_11, var_1);
  var_3 = _encstr_8ECB1A8DA12BB1ADCDC12C77CD772DA3D0B4B9B5C2074E85914BD59B(var_3);
  return [var_3, var_4];
}

_id_12722(var_0, var_1) {
  var_2 = var_0;

  if(level.disable_super_in_turret._id_146FC) {
    var_3 = getdvarint("_encstr_858A1FD7DE83CFAB80013268C2697B027FF70BFBED1A20F7E66445B44D62F74873", 10000);
    var_4 = (0, 0, var_3);
    var_0 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::getoffsetspawnorigin(var_0, var_4);
    var_5 = spawnStruct();
    var_5.origin = var_0;
    var_5.angles = var_1;
    var_5.height = var_3;
    var_2 = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_1263E(var_5);
  } else {
    self calloutmarkerping_getinventoryslot(0.0);
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_2);
  }

  return [var_0, var_2];
}

_id_126BD(var_0, var_1, var_2) {
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_126C3(var_2, var_1);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3.angles = var_1;
  var_3 hide();
  var_3 showtoplayer(self);
  self playerlinktoabsolute(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playerhide();
  thread _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12524(var_3);
  waitframe();
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();
  var_3.origin = var_0;
  waitframe();
  self unlink();
  self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");
  self clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 2);
  self clearclienttriggeraudiozone(1);
  self playershow();
  var_4 = 0;

  if(isDefined(level._id_121CC))
    var_4 = level._id_121CC;

  thread scripts\cp_mp\parachute::startfreefall(var_4, 0, undefined, undefined, 1);
  self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);
  self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_12C7A();
  wait 0.5;
  _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::gulagfadefromblack();
  waitframe();
  var_3 delete();
  self notify("_encstr_978F121A20F5F1EF10A0675746FB5B863780E293");
}

_id_126FF() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");

  if(level.disable_super_in_turret._id_1470C) {
    self hudoutlinedisable();

    if(!level.disable_super_in_turret._id_1470D)
      self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_AAC10DB208B88E7FEDCF5B4AD87DB6");

    if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
      self visionsetnakedforplayer("_encstr_8F88126B1CBEB2B96C2C0E5986F5DD9E7DF4AD13", 0);
      thread _encstr_85681DDBB81B884783FAAFD59E880FD65B60F20230F747B73B6DBAC223F1F7();
    } else
      self visionsetnakedforplayer("_encstr_8AC20F883A770898D2F6FFA7BBA95A18E2", 0);

    _id_12713();
  }

  waitframe();

  if(getdvarint("_encstr_AF541AE7636201C63B19AAD2D3B789C87DE8378D070D509B8FF121DA", 1))
    self setscriptablepartstate("_encstr_BACB074025B01AAA28", "_encstr_B66E08EDDCEBD8BDED0E");
  else
    self setscriptablepartstate("_encstr_BACB074025B01AAA28", "_encstr_AB0703DBB9");
}

_encstr_85681DDBB81B884783FAAFD59E880FD65B60F20230F747B73B6DBAC223F1F7() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setclienttriggeraudiozonepartial("_encstr_A3B611C250D0A182F67767770F9A6AFD90583F", "_encstr_8D4708E790B3E4FA7D8B");
  scripts\engine\utility::_id_143A5("_encstr_837F0D4838B8B25A757F6F0B4F2DD3", "_encstr_AD75063D571AE108");
  self clearclienttriggeraudiozone(1);
}

_id_12713() {
  var_0 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);
  var_1 = scripts\mp\utility\teams::getenemyplayers(self.team, 1);

  foreach(var_3 in var_0)
  scripts\mp\utility\outline::outlineenableforplayer(var_3, self, "_encstr_AF1D249FCB25DA7160A1D1E759689452684D172F4DC33226704B542D1039CEABDB9B8B832973", "_encstr_AC190479FF92");

  foreach(var_3 in var_1) {
    if(!var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
      scripts\mp\utility\outline::outlineenableforplayer(var_3, self, "_encstr_ABBF21B7D5478D969B56EB192B07A334FAA7EDB526A52BD92D9B2DB7B9EBB2E659ADF2", "_encstr_AC190479FF92");
  }
}

_encstr_85FB1C695552A8C3FB282809A62DA83D8C4FCD90C8E3D5D1D540A7C99398() {
  var_0 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);
  var_1 = scripts\mp\utility\teams::getenemyplayers(self.team, 1);

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
      scripts\mp\utility\outline::outlineenableforplayer(self, var_3, "_encstr_AF1D249FCB25DA7160A1D1E759689452684D172F4DC33226704B542D1039CEABDB9B8B832973", "_encstr_AC190479FF92");
  }

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && var_3 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3())
      scripts\mp\utility\outline::outlineenableforplayer(self, var_3, "_encstr_ABBF21B7D5478D969B56EB192B07A334FAA7EDB526A52BD92D9B2DB7B9EBB2E659ADF2", "_encstr_AC190479FF92");
  }
}

_id_1270D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_146C0 = undefined;

  for(;;) {
    if(_id_12714()) {
      if(!isDefined(self._id_146C0) || !self._id_146C0) {
        self._id_146C0 = 1;
        _id_12705();
      }
    } else if(!isDefined(self._id_146C0) || self._id_146C0) {
      self._id_146C0 = 0;
      _id_12706();
    }

    waitframe();
  }
}

_id_12705() {
  self notify("_encstr_978C118B50F3BE87B1B87566C55923091FC883");
  self unsetperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
}

_id_12706() {
  self notify("_encstr_8F8C1095B77FBA94CD9F3BD80A4B3FFF42AB");

  if(level.disable_super_in_turret._id_146D5 >= 0) {
    if(level.disable_super_in_turret._id_146D5 == 0)
      self setperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    else
      thread _id_1271F();
  }
}

_id_1271F() {
  if(level.disable_super_in_turret._id_146D5 <= 0) {
    return;
  }
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self endon("_encstr_978C118B50F3BE87B1B87566C55923091FC883");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self setperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    wait(level.disable_super_in_turret._id_146D6);
    self unsetperk("_encstr_997514BBF23379635B154047C728F9F03F9332E803E7", 1);
    wait(level.disable_super_in_turret._id_146D5);
  }
}

_id_12714() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent))
    return 0;

  var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_1 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  return distance2dsquared(var_0, self.origin) > var_1 * var_1;
}

_id_12724() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_133E9 = 1;
  self.radarmode = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
  self.hasradar = 1;
  self waittill("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self._id_133E9 = undefined;
  self.hasradar = 0;
}

_id_1272A() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");

  for(;;) {
    if(self issupersprinting())
      self refreshsprinttime();

    waitframe();
  }
}

_id_12710(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");

  if(istrue(self._encstr_9711166517B3BF80E70D312937CAB8792A3F11CDD37A8F08))
    self setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_83F80F56CD0B988D9546AFD3EDD626D2AC", 0);

  wait 1;

  while(!self isonground()) {
    _id_125B8(var_0);
    waitframe();
  }

  self setclientomnvar("_encstr_827E16A39A77369029992901898DE08527837EEB33E77510", 0);
  self skydive_interrupt();
  playFX(level._effect["_encstr_9A660D40EFC85DD88169E6D1781F73"], self.origin);
  self playsoundtoplayer("_encstr_97F814E93C0EFA9BE00BEE737DB91CC6581DF5381B39", self, self);
  self playSound("_encstr_B2F9145041934957C3E3EF8AFEB7233947FC9778A9E2", self, self);
  self freezecontrols(1);
  var_2 = gettime() + 2000;

  while(self getcurrentprimaryweapon().classname == "_encstr_8BBA05185F8B99" && gettime() < var_2) {
    _id_125B8(var_0);
    waitframe();
  }

  var_3 = propwaitminigameinit(self, 0);

  if(!isDefined(var_3))
    var_3 = (0, 0, 1);

  var_4 = anglesToForward(self.angles);
  var_5 = vectortoangles(var_3);
  var_6 = angleclamp180(var_5[0] + 90);
  var_5 = (0, var_5[1], 0);
  var_7 = anglesToForward(var_5);
  var_8 = vectordot(var_7, var_4);
  var_9 = var_8 * var_6;
  var_10 = getdvarint("_encstr_A59523C3C112591BE8D683F2E3201B28BA190855AE7677F15743880B509752B1996062D7CB", 20);
  var_11 = getdvarint("_encstr_B42A210726A838B5F257883AB3D1E3E0A73A500AE78B7B3C1FE86165A3A96FAD30B8FB", -70);

  if(var_9 > 0)
    var_9 = min(var_10, var_9);
  else
    var_9 = max(var_11, var_9);

  self setplayerangles((var_9, self.angles[1], 0));

  if(self getcurrentprimaryweapon().classname != "_encstr_8BBA05185F8B99")
    self forceplaygestureviewmodel("_encstr_968211E10F02AF2D18182282C5B9B04B439115");

  wait 1;
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  wait 0.5;
  self freezecontrols(0);
  self freezelookcontrols(1);
  self allowsprint(0);
  thread _id_12720();
  _id_125B8(var_0);

  if(istrue(self._encstr_9711166517B3BF80E70D312937CAB8792A3F11CDD37A8F08)) {
    self._encstr_9711166517B3BF80E70D312937CAB8792A3F11CDD37A8F08 = undefined;
    self setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);
  }

  if(istrue(var_1))
    wait 0.5;
  else
    wait 1.0;

  self freezelookcontrols(0);

  if(istrue(var_1))
    wait 0.5;
  else
    wait 1.0;

  self allowsprint(1);
}

_id_125B8(var_0) {
  if(!self hasweapon(var_0))
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);

  if(self getcurrentprimaryweapon().classname == "_encstr_8BBA05185F8B99")
    thread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0);
}

_id_11ECD(var_0) {
  foreach(var_2 in level.players) {
    if(!isalive(var_2)) {
      continue;
    }
    if(scripts\engine\utility::array_contains(var_0, var_2.team)) {
      var_2 scripts\mp\hud_message::showsplash("_encstr_AB871A98E4EBEC16AD56D1BC1C597DF4F083FAA957B33B7DA356B06B");
      continue;
    }

    var_2 scripts\mp\hud_message::showsplash("_encstr_85921B1EBE37FAF138B0734F3011977311D72994A5FF320780203B2758");
  }
}

clear_tier_lights_all(var_0) {
  _id_11ECD(var_0);

  foreach(var_2 in var_0) {
    var_3 = level.teamdata[var_2]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"];

    foreach(var_5 in var_3) {
      if(isalive(var_5) && !var_5 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
        if(level.disable_super_in_turret.spawndomplateflagtestmap)
          var_5 _id_125FC();

        var_5 _id_1250E();
      }
    }
  }
}

_id_1250E() {
  if(istrue(self.inlaststand))
    scripts\mp\laststand::playanim_aibegindismountturret("_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F", self);

  scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(1);

  if(level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback > 0 && level.disable_super_in_turret.vehicle_occupancy_getreserving) {
    objective_icon(self.juggcontext.juggobjid, "_encstr_8DAD134CB9E2379017690B130F48C061D902C398AF");
    objective_state(self.juggcontext.juggobjid, "_encstr_AF5A081BBAC993AC73A3");
    objective_setzoffset(self.juggcontext.juggobjid, 70);
    objective_setprogress(self.juggcontext.juggobjid, 0.99);
    objective_setshowprogress(self.juggcontext.juggobjid, 1);
    objective_setprogressteam(self.juggcontext.juggobjid, self.team);
    objective_setbackground(self.juggcontext.juggobjid, 1);
    _func_421(self.juggcontext.juggobjid, 1);
  }
}

onplayerdamaged(var_0) {
  if(level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback > 0 && level.disable_super_in_turret.vehicle_occupancy_getreserving && istrue(var_0.victim.isjuggernaut)) {
    var_1 = var_0.victim.health / var_0.victim.maxhealth;
    objective_setprogress(var_0.victim.juggcontext.juggobjid, var_1);

    if(isDefined(var_0.attacker))
      var_0.attacker thread _id_12612(var_0.victim.juggcontext.juggobjid, var_0.victim);
  }

  var_2 = isDefined(var_0.attacker) && isDefined(var_0.attacker._id_12369);
  var_3 = var_0.victim getentitynumber();
  var_4 = var_2 && isDefined(var_0.attacker._id_12369._id_13A72) && isDefined(var_0.attacker._id_12369._id_13A72[var_3]) && var_0.attacker._id_12369._id_13A72[var_3] == var_0.victim;

  if(var_0.victim _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && var_4)
    var_0.attacker thread _encstr_A3B91B4271B0B7B37D2967037F107AF488D83E8FE970451AC533470F45(var_0.victim, var_0.victim.headicon);
}

_encstr_A3B91B4271B0B7B37D2967037F107AF488D83E8FE970451AC533470F45(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = var_0 getentitynumber();
  var_0 endon("_encstr_8F57108DA9F0CA667103EA03C10177975547" + var_2);
  var_3 = "_encstr_BDAF1C27CAD67BB395142D73CEE9CD44C2D60B9D5690ACC21952D8BDE6AF" + var_2;
  self notify(var_3);
  self endon(var_3);
  var_0 waittill("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1);
}

_id_12612(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8C97130763B0975993055ADC9E4C9A59C6A34BECCA");
  self endon("_encstr_8C97130763B0975993055ADC9E4C9A59C6A34BECCA");
  objective_pinforclient(var_0, self);
  var_1 scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 1);
  objective_unpinforclient(var_0, self);
}

_id_13283() {
  if(!level.disable_super_in_turret._id_146E2) {
    return;
  }
  level.disable_super_in_turret._id_14693 = spawnStruct();
  level.disable_super_in_turret._id_14693.powers = [];
  battlepassxpmultipliers(level.disable_super_in_turret._id_14693, "_encstr_84DD05D205AA0B", ["_encstr_97120D65B983599519EB1D86C9B7EE", "_encstr_A2071122CC07510FDD9AD8F8D3391108DB4F94", "_encstr_B4391759C2326ED785AD4BAD98DE7D58D81B569BB94B2663B2"], ::_id_12716, 0, undefined, ::_id_12718, undefined, &"_encstr_966C148F39569A41695806CC4755884D9DD91B17396F", undefined, 6, "_encstr_81730B2B2828F8B9792783FB16", "_encstr_964C0DC5B3E11B4133088F226B038E");
  battlepassxpmultipliers(level.disable_super_in_turret._id_14693, "_encstr_A5C109C06D4D73FFD327AB", ["_encstr_A52F0DF89B22FF1545787B02C3C7FF", "_encstr_8D5E11D28EDBB3EC36565823B9EB8ED09CBDBB", "_encstr_B285174ED74712A79FDCEB3BB5DFCFEF28604AA3A3C3E28115"], ::_id_1271B, 0);
  battlepassxpmultipliers(level.disable_super_in_turret._id_14693, "_encstr_9B1804C793EB", "_encstr_8E5F0795E6AD7BAD2B", ::_id_12707, 0, ::_id_1270A, ::_id_12708, ::_id_12709, &"_encstr_96C21320714F788BEF489F916E56AF3213F9682871", undefined, 15, "_encstr_8FEC116F88AB6F505DF5478C4F7F1BBA489072", "_encstr_A64A13C17643090E6AFB8B99CF61567BEF0A09DB1A");
  battlepassxpmultipliers(level.disable_super_in_turret._id_14693, "_encstr_8B1804DF2043", "_encstr_9B0D065699E485D9", ::_id_12703, 0, undefined, undefined, undefined, &"_encstr_AD580B156790BDEE83866DE1CF", undefined, 15, "_encstr_967E0AA10DC2B7311F3B5323", "_encstr_8A160C0DD16B23C287686B12A0D7");

  if(getdvarint("_encstr_A6791F2B71265FBEB88F4238A9A9C6BFC18BC2835EFF7F7538A7433D81F84D7BF5", 1))
    battlepassxpmultipliers(level.disable_super_in_turret._id_14693, "_encstr_B8010BFF97CFD95F7BC1D7FFD0", ["_encstr_888C145659E2D54B837DD1F6B39DD8597D3AA1397BDD"], ::_id_1270B, 0, undefined, ::_id_1270C);
}

battlepassxpmultipliers(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = "_encstr_BAF012CD6C9CD79839BE4F8707EB0EEDEE5639AF" + var_1;

  if(getdvarint(var_13, 1) == 0) {
    return;
  }
  if(isstring(var_2))
    var_2 = [var_2];

  var_0.powers[var_1] = spawnStruct();
  var_0.powers[var_1].clients_hacked = var_2;
  var_0.powers[var_1].func = var_3;
  var_0.powers[var_1]._id_1387B = var_5;
  var_0.powers[var_1].has_ammo_drain_passive = var_6;
  var_0.powers[var_1]._id_127FC = var_7;
  var_0.powers[var_1].label = var_8;
  var_0.powers[var_1].waitforstreamsynccomplete = var_9;
  var_0.powers[var_1].idmask = var_10;
  var_0.powers[var_1]._id_1388F = var_11;
  var_0.powers[var_1]._id_128BE = var_12;
  var_0.powers[var_1]._id_13060 = var_4;
}

_id_1270B(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A20115E0A23E9BC1BB22C831F23F093FE6FBA178A85D81");
  self endon("_encstr_A20115E0A23E9BC1BB22C831F23F093FE6FBA178A85D81");
  var_2 = gettime() + getdvarint("_encstr_8AD121EE8E73EF013A3FE8F0EB7FF9CBCB3968F669FA438B2F8B08408797732951DDDE", 500);

  while(var_2 > gettime()) {
    if(self secondaryoffhandbuttonPressed()) {
      self notify("_encstr_9B1804C793EB");
      break;
    } else if(self fragButtonPressed()) {
      self notify("_encstr_8B1804DF2043");
      break;
    }

    waitframe();
  }
}

_id_12703(var_0, var_1) {
  var_2 = 60;
  var_3 = 1;
  var_4 = 64;
  var_5 = var_4 * var_4;
  var_6 = 768;
  var_7 = var_6 * var_6;
  var_8 = "_encstr_8E0B110A40FBD68B1D4BA968F2F2B36E53CC96";
  var_9 = self;
  var_9 enableplayerbreathsystem(0);
  var_9 playsoundonmovingent(var_8);
  var_9 playsoundtoplayer("_encstr_910A14059D7611557BBA388383C71DC88AEAA1AB2B5B", self, self);
  var_9 playSound("_encstr_B8471872156AF78830B7C92BBB7EE0E5B3316571AA8249511B83", var_9, var_9);
  var_9 thread _id_14697(2);
  var_10 = anglesToForward(var_9.angles);
  playFX(level.disable_super_in_turret.empvfx, var_9.origin, var_10);
  var_11 = getcompleteweaponname("_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB");
  var_12 = getcompleteweaponname("_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E");
  var_13 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var_15 in var_13) {
    var_16 = var_15.owner;

    if(isDefined(var_16)) {
      if(var_16 != var_9 && !scripts\cp_mp\utility\player_utility::playersareenemies(var_9, var_16))
        continue;
    }

    var_17 = distancesquared(var_9.origin, var_15.origin);

    if(var_17 > var_7) {
      continue;
    }
    var_18 = scripts\engine\utility::ter_op(var_17 > var_5, var_11, var_12);
    var_15 dodamage(1, var_9.origin, var_9, var_9, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_18);
    var_15 playsoundonmovingent("_encstr_B8FF13D8EB78EECB2AEA405385D30BD1C4DFB8F0A3");
    var_19 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_9, var_15, 1, var_18, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_9, var_9.origin);
    thread _id_126F9(var_19);
  }

  var_21 = getcompleteweaponname("_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18");
  var_22 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53"))
    var_22 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AAC0133C589B026BE92A5D0A9BF4B6AA4FC4B48B53")]](var_9.origin, var_6);

  foreach(var_24 in var_22) {
    if(var_24 == var_9) {
      continue;
    }
    if(var_24 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
      continue;
    }
    if(!var_24 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }
    if(var_24 != var_9 && !scripts\cp_mp\utility\player_utility::playersareenemies(var_9, var_24)) {
      continue;
    }
    var_24 dodamage(1, var_9.origin, var_9, var_9, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_21);
    var_19 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_9, var_24, 1, var_21, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_9, var_9.origin);
    thread _id_126F9(var_19);
  }

  thread _id_1262C(var_0, var_1);
}

_id_14697(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  self enableplayerbreathsystem(1);
}

_id_1262C(var_0, var_1) {
  if(level.disable_super_in_turret.spawndistancemax)
    self._id_12821[var_1].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(1.0, 0);
  else
    self._id_12821[var_1].frac = 1.0;

  thread _id_12639(var_0, var_1);
}

_id_1270C(var_0, var_1) {
  self notify("_encstr_A20115E0A23E9BC1BB22C831F23F093FE6FBA178A85D81");
}

_id_12720() {
  if(!level.disable_super_in_turret._id_146E2) {
    return;
  }
  thread _id_126B4(level.disable_super_in_turret._id_14693);
}

_id_126B4(var_0) {
  thread _id_12637(var_0);
  thread _id_12634(var_0);
  thread _id_12635(var_0);

  if(level.disable_super_in_turret.spawndistancemax)
    thread _id_1263A(var_0);

  thread _id_12638(var_0);
  thread _id_12630(var_0);

  foreach(var_3, var_2 in var_0.powers) {
    if(isDefined(var_0.powers[var_3]._id_1388F))
      _id_14033(var_0.powers[var_3]._id_1388F, 2);
  }
}

_id_126F9(var_0) {
  var_1 = 5;
  var_2 = 2;
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  var_3 = var_1;

  if(isPlayer(var_0.victim)) {
    var_0.victim.unmark_on_death = 1;
    var_0.victim playSound("_encstr_A9FF131598C2216567CB2E90626B2F889B2789813A");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
      if(var_0.victim != self && var_0.victim[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_9733153383D563C1D1CA237FE6259ACFE7E085E20FEE93")) {
        var_3 = var_2;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA")]]("_encstr_8D760DB8F77343CF62BEB7E3D01013");
      }
    }
  }

  moraleslaptopthink(var_0, var_3);

  if(isDefined(var_0.victim)) {
    var_0.victim.unmark_on_death = undefined;
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();
  }
}

_id_1270A(var_0, var_1) {
  scripts\mp\equipment::giveequipment("_encstr_B24B12B7A88B412B8F84669AE0974315B0800B3F", "_encstr_AC8F0AE74163F85AAA380AD8");
  scripts\mp\equipment::setequipmentslotammo("_encstr_AC8F0AE74163F85AAA380AD8", 1);
}

_id_12707(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_9A630C851C886BC33D8221E3EEB1");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_2, var_3, var_4, var_5);

  if(!scripts\mp\utility\weapon::grenadethrown(var_2)) {
    return;
  }
  self playSound("_encstr_9A1B13D30F38D7CE27B29BB0C895D7B37BBECD38C6", self, self);
  thread _id_1262C(var_0, var_1);
}

_id_12709(var_0, var_1) {
  scripts\mp\equipment::setequipmentslotammo("_encstr_AC8F0AE74163F85AAA380AD8", 1);
}

_id_12708(var_0, var_1) {
  scripts\mp\equipment::takeequipment("_encstr_AC8F0AE74163F85AAA380AD8");
}

moraleslaptopthink(var_0, var_1) {
  var_0.victim endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_99C40CA749E1F16B80389FEB2BB9", var_1);

  if(var_2 != "_encstr_99C40CA749E1F16B80389FEB2BB9")
    var_0.empremoved = 1;
}

_id_12630(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_837F0D4838B8B25A757F6F0B4F2DD3", "_encstr_84290BF4DBB698B42BAFCD2BA3");
  thread _id_1262D(var_0);
  thread _id_12632(var_0);
  thread _id_12633(var_0);
  thread _id_12631(var_0);
}

_id_12637(var_0) {
  if(isbot(self)) {
    return;
  }
  foreach(var_6, var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked)
    self notifyonplayercommand(var_6, var_4);
  }
}

_id_12631(var_0) {
  if(!isDefined(self._id_12821)) {
    return;
  }
  if(level.disable_super_in_turret.spawndistancemax) {
    foreach(var_2 in self._id_12821) {
      if(isDefined(var_2)) {
        if(isDefined(var_2.choppergunner_refillmissiles))
          var_2.choppergunner_refillmissiles scripts\mp\hud_util::destroyelem();

        var_2 destroy();
      }
    }
  }

  self._id_12821 = undefined;
}

_id_12634(var_0) {
  var_1 = 200;
  var_2 = 18;
  var_3 = var_1;
  self._id_12821 = [];

  foreach(var_6, var_5 in var_0.powers) {
    if(isDefined(var_5.label)) {
      if(level.disable_super_in_turret.spawndistancemax)
        self._id_12821[var_6] = _id_1262F(var_5.label, var_5.waitforstreamsynccomplete, var_3, var_5._id_13060);
      else {
        self._id_12821[var_6] = spawnStruct();
        self._id_12821[var_6].frac = 0;
      }

      self._id_12821[var_6].incooldown = 0;
      var_3 = var_3 + var_2;
    }
  }
}

_id_1262F(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
  var_4.x = 15;
  var_4.y = var_2;
  var_4.alignx = "_encstr_A5AD056A019C63";
  var_4.aligny = "_encstr_AC190479FF92";
  var_4.horzalign = "_encstr_AD16101BCA66A37DB0194D579B470B261BB2";
  var_4.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
  var_4.alpha = var_3;
  var_4.glowalpha = 0;
  var_4.hidewheninmenu = 1;
  var_4.archived = 0;

  if(isDefined(var_1) && !scripts\engine\utility::is_player_gamepad_enabled())
    var_4.label = var_1;
  else if(isDefined(var_0))
    var_4.label = var_0;

  var_5 = scripts\mp\hud_util::createbar((1, 1, 1), 160, 14);
  var_5.x = 13;
  var_5.y = var_2;
  var_5.alignx = "_encstr_A5AD056A019C63";
  var_5.aligny = "_encstr_AC190479FF92";
  var_5.horzalign = "_encstr_AD16101BCA66A37DB0194D579B470B261BB2";
  var_5.vertalign = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";
  var_5.alpha = var_3;
  var_5 _id_132A8();
  var_5.archived = 0;
  var_5.hidewheninmenu = 1;
  var_5.bar.archived = 0;
  var_5.bar.hidewheninmenu = 1;
  var_5.bar.alpha = var_3;
  var_4.choppergunner_refillmissiles = var_5;
  return var_4;
}

_id_132A8(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "_encstr_A5AD056A019C63";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y + 2;
  self.bar.x = self.x + 2;
  scripts\mp\hud_util::updatebar(self.bar.frac);
}

_id_12632(var_0) {
  if(isbot(self)) {
    return;
  }
  foreach(var_6, var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked)
    self notifyonplayercommandremove(var_6, var_4);
  }
}

_id_12633(var_0) {
  foreach(var_3, var_2 in var_0.powers) {
    if(isDefined(var_2.has_ammo_drain_passive))
      self thread[[var_2.has_ammo_drain_passive]](var_0, var_3);
  }
}

_id_1262D(var_0) {
  if(!isDefined(var_0) || !isDefined(self._id_12821)) {
    return;
  }
  self notify("_encstr_81971074BB638F9ED9D0C01A9801D77F5B90");

  foreach(var_3, var_2 in var_0.powers) {
    if(!isDefined(self._id_12821[var_3])) {
      continue;
    }
    self._id_12821[var_3].incooldown = 0;

    if(level.disable_super_in_turret.spawndistancemax)
      self._id_12821[var_3].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0, 0);
    else
      self._id_12821[var_3].frac = 0;

    thread _id_12639(var_0, var_3);
  }

  self.laststandattackermodifiers = undefined;
  self.vehicle_occupancy_mp_hidecashbag = undefined;
}

_id_12BBA(var_0) {
  if(!isDefined(level.teamdata[var_0]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"]))
    return level.teamdata[var_0]["_encstr_8A2A0B936CCCC3078547970A8B"];
  else
    return level.teamdata[var_0]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"];
}

wait_for_chopper_boss_finish_turning(var_0, var_1) {
  var_2 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 notify("_encstr_B1E80FD9BAB1B076EB2C5DE87BF5EE5A37");
  var_2 notify("_encstr_84290BF4DBB698B42BAFCD2BA3");
  var_2 notify("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");

  if(istrue(var_2.respawningfromtoken)) {
    return;
  }
  var_3 = var_0;
  var_4 = "_encstr_88911047F6D62B9B7DCDC1B79B6E7BE42B32";

  if(!isalive(var_2) && istrue(var_2.delay_enter_combat_after_investigating_grenade)) {
    if(!level.disable_super_in_turret.fluctuatevalues)
      var_2 _id_1267D(1);

    [var_3, var_4] = _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_125C7(var_0, var_1, 0, 1, "_encstr_844C0E9EDEB6264BACB925B2EC4B9DAC");
  } else if(istrue(var_3.hasrespawntoken))
    var_3 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::removerespawntoken();

  var_2.respawningfromtoken = 1;
  var_6 = var_2 _encstr_9673224F98CBE18B792E55FD97E7B2B170C02BEF988133A6AD4641777D39EA7FF068BF1F::_id_126E8();

  if(var_6)
    var_2 scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  var_2 scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();

  if(level.disable_super_in_turret.fluctuatevalues)
    var_2 _encstr_A9F5296E8D4E2D0EA3E65EB5C1E5ECC2DA953ABC0756E6CB31C97DB385B656A3BCE0CABEF4F007C5CE6E8D::_id_126FA(1);
  else
    var_2 _id_12723(0);

  var_2 freezecontrols(0);
  var_2 freezelookcontrols(0);
  var_2 allowsprint(1);
  var_7 = "_encstr_A30D1880F5B18FB0C8511771D740E5F3A0772B5A673FE9B958E8";
  var_8 = var_0;
  var_2 thread scripts\mp\hud_message::showsplash(var_7, undefined, var_0);
  var_2.respawningfromtoken = undefined;
}

_id_12638(var_0) {
  foreach(var_3, var_2 in var_0.powers) {
    if(isDefined(var_2._id_1387B))
      self thread[[var_2._id_1387B]](var_0, var_3);
  }
}

_id_12635(var_0) {
  if(isbot(self)) {
    return;
  }
  foreach(var_3, var_2 in var_0.powers)
  thread _id_12636(var_0, var_3);
}

_id_12636(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self endon("_encstr_84290BF4DBB698B42BAFCD2BA3");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill(var_1);
    waittillframeend;

    if(isDefined(self._id_12821[var_1]) && self._id_12821[var_1].incooldown) {
      _id_12614();
      continue;
    }

    self thread[[var_0.powers[var_1].func]](var_0, var_1);
  }
}

_id_12614() {
  if(!isDefined(self.laststandattackermodifiers) || gettime() > self.laststandattackermodifiers) {
    self playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
    self.laststandattackermodifiers = gettime() + 1000;
  }
}

_id_1263A(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self endon("_encstr_84290BF4DBB698B42BAFCD2BA3");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isbot(self)) {
    return;
  }
  waittillframeend;
  var_1 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    var_2 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var_2 != var_1) {
      var_1 = var_2;

      if(var_2) {
        foreach(var_5, var_4 in var_0.powers) {
          if(isDefined(var_4.waitforstreamsynccomplete))
            self._id_12821[var_5].label = var_4.label;
        }
      } else {
        foreach(var_5, var_4 in var_0.powers) {
          if(isDefined(var_4.waitforstreamsynccomplete))
            self._id_12821[var_5].label = var_4.waitforstreamsynccomplete;
        }
      }
    }

    waitframe();
  }
}

_id_12639(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self endon("_encstr_84290BF4DBB698B42BAFCD2BA3");
  self endon("_encstr_81971074BB638F9ED9D0C01A9801D77F5B90");

  if(!isDefined(self._id_12821[var_1]) || istrue(self._id_12821[var_1].incooldown)) {
    return;
  }
  var_2 = self._id_12821[var_1];

  if(level.disable_super_in_turret._id_12820 && var_2.frac > 0) {
    self._id_12821[var_1].incooldown = 1;
    var_3 = var_0.powers[var_1].idmask;
    var_4 = "_encstr_BD7E1BAB1EBA31FEF3A7151933093F68577773A6861FF8A1EA7F372D77" + var_1;

    if(getdvarint(var_4, 0) != 0)
      var_3 = getdvarint(var_4, 0);

    thread _id_126DE(var_0, var_1, var_3, int(var_2.frac * 100));
    var_5 = var_2.frac;
    var_3 = var_3 * var_5;

    if(level.disable_super_in_turret.spawndistancemax) {
      var_2.choppergunner_refillmissiles.bar.color = (1, 0.6, 0);
      var_2.choppergunner_refillmissiles.bar scaleovertime(var_3, 0, var_2.choppergunner_refillmissiles.height);
    }

    wait(var_3);
    var_6 = "_encstr_A21310A3D85813E080B7627DC788EDCFFAB6" + var_1;
    self playlocalsound(var_6);
    self._id_12821[var_1].incooldown = 0;
  } else {
    if(level.disable_super_in_turret.spawndistancemax)
      var_2.choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0, 0);
    else
      var_2.frac = 0;

    thread _id_126DE(var_0, var_1, 0, 0);
  }

  if(level.disable_super_in_turret.spawndistancemax)
    var_2.choppergunner_refillmissiles.bar.color = (1, 1, 1);

  if(isDefined(var_0.powers[var_1]._id_127FC))
    self[[var_0.powers[var_1]._id_127FC]](var_0, var_1);
}

_id_126DE(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self endon("_encstr_84290BF4DBB698B42BAFCD2BA3");
  self endon("_encstr_81971074BB638F9ED9D0C01A9801D77F5B90");

  if(!isDefined(var_0.powers[var_1]._id_1388F) || !isDefined(var_0.powers[var_1]._id_128BE)) {
    return;
  }
  _id_14033(var_0.powers[var_1]._id_1388F, 1);
  var_4 = var_2 * 1000 * var_3 / 100;
  var_5 = gettime();
  var_6 = var_5 + var_4;

  while(gettime() < var_6) {
    var_7 = gettime();
    var_8 = (var_6 - gettime()) / var_4;
    var_9 = var_8 * var_3;
    _id_14033(var_0.powers[var_1]._id_128BE, int(var_9));
    waitframe();
  }

  _id_14033(var_0.powers[var_1]._id_128BE, 0);
  _id_14033(var_0.powers[var_1]._id_1388F, 2);
}

_id_14033(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  switch (var_0) {
    case "_encstr_81730B2B2828F8B9792783FB16":
      var_2 = 0;
      var_3 = 2;
      break;
    case "_encstr_964C0DC5B3E11B4133088F226B038E":
      var_2 = 2;
      var_3 = 7;
      break;
    case "_encstr_967E0AA10DC2B7311F3B5323":
      var_2 = 9;
      var_3 = 2;
      break;
    case "_encstr_8A160C0DD16B23C287686B12A0D7":
      var_2 = 11;
      var_3 = 7;
      break;
    case "_encstr_8FEC116F88AB6F505DF5478C4F7F1BBA489072":
      var_2 = 18;
      var_3 = 2;
      break;
    case "_encstr_A64A13C17643090E6AFB8B99CF61567BEF0A09DB1A":
      var_2 = 20;
      var_3 = 7;
      break;
    case "_encstr_ACF20B9D7D8575919257DF8095":
      var_2 = 27;
      var_3 = 2;
      break;
    default:
      break;
  }

  if(!isDefined(level._id_146E0))
    level._id_146E0 = [];

  if(!isDefined(level._id_146E0["_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8"]))
    level._id_146E0["_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8"] = 0;

  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (int(var_1) &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = self calloutmarkerping_entityzoffset("_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8");
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;
  level._id_146E0["_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8"] = var_9;
  self setclientomnvar("_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8", level._id_146E0["_encstr_9951144330E17A33A0FDBF4F35538A8F40587BCFCBE8"]);
}

_id_12716(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self endon("_encstr_97C615BBADD9700DE3A30F036B7A455165452357530FF0");
  var_2 = -1;

  if(_id_12717()) {
    _id_12614();
    return;
  }

  var_3 = getdvarfloat("_encstr_8661236E6CC9D7894EFA4F1E1CEBC1EDEE2BC9E6EBA95DB60E7D6C43B093CE56D73916E82B", 1.0);
  var_4 = getdvarfloat("_encstr_B66F206EC64EBE894EEBE93CC1F5C1EDBB5939DCD7A6D5D60EFAD62D73FA992716C6", 0.25);
  var_5 = getdvarint("_encstr_84A725E356E269A6BBDF5D417B31F7A09FAF4B7BF152E0E973F77B7B331933582C479613E48D28", var_2);
  var_6 = var_3 * level.framedurationseconds;
  self.vehicle_occupancy_monitormovementcontrols = 0.0;
  self allowmelee(0);
  self disableoffhandweapons();

  while(self ismantling() || self isthrowinggrenade() || self ismeleeing() || scripts\mp\utility\weapon::grenadeinpullback())
    waitframe();

  thread _id_1270F();
  thread _id_13982();
  var_7 = undefined;
  var_8 = 0;

  if(!isDefined(self.vehicle_occupancy_mp_hidecashbag) || gettime() > self.vehicle_occupancy_mp_hidecashbag) {
    self playlocalsound("_encstr_887A19D5B4BEE9C338FA6C8616C9CE95FAA6AE6B387D9B3A16E447");
    self.vehicle_occupancy_mp_hidecashbag = gettime() + 500;
  }

  if(isDefined(var_0.powers[var_1]._id_1388F))
    _id_14033(var_0.powers[var_1]._id_1388F, 0);

  while(!_id_12717()) {
    if(level.disable_super_in_turret.spawndistancemax)
      self._id_12821[var_1].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(self.vehicle_occupancy_monitormovementcontrols, 0);
    else
      self._id_12821[var_1].frac = self.vehicle_occupancy_monitormovementcontrols;

    var_9 = self.vehicle_occupancy_monitormovementcontrols;
    self.vehicle_occupancy_monitormovementcontrols = self.vehicle_occupancy_monitormovementcontrols + var_6;

    if(self.vehicle_occupancy_monitormovementcontrols >= 1) {
      self.vehicle_occupancy_monitormovementcontrols = 1.0;

      if(var_5 >= 0) {
        if(!isDefined(var_7)) {
          var_7 = gettime() + var_5 * 1000;

          if(level.disable_super_in_turret.spawndistancemax)
            thread _id_1271A(var_1, var_5);
        }

        if(gettime() >= var_7) {
          break;
        }
      }
    }

    if(level.disable_super_in_turret.spawndistancemax && var_9 < var_4 && self.vehicle_occupancy_monitormovementcontrols >= var_4)
      self._id_12821[var_1].choppergunner_refillmissiles.bar.color = (0, 1, 0);

    if(var_9 < 1 && self.vehicle_occupancy_monitormovementcontrols >= 1)
      self playlocalsound("_encstr_872918FFFB88835898FED61CD1608F8A6015671771D00A2D20A0");

    if(isDefined(var_0.powers[var_1]._id_128BE)) {
      var_8 = max(int(self.vehicle_occupancy_monitormovementcontrols * 100), 0);
      _id_14033(var_0.powers[var_1]._id_128BE, var_8);
    }

    waitframe();
  }

  thread _id_12719(var_0, var_1);
}

_id_12717() {
  return self getstance() == "_encstr_922406F1A6FD5E05" || istrue(self.usingascender);
}

_id_1271C() {
  if(level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols != 0) {
    var_0 = self.origin + (0, 0, level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols);
    var_1 = playerphysicstrace(self.origin, var_0);

    if(var_1 != var_0)
      return 0;
  }

  if(level.disable_super_in_turret.vehicle_occupancy_mp_changedseats != 0) {
    var_2 = self getEye();
    var_0 = var_2 + (0, 0, level.disable_super_in_turret.vehicle_occupancy_mp_changedseats);
    var_3 = 10;
    var_4 = 20;
    var_5 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 1);
    var_1 = scripts\engine\trace::capsule_trace(var_2, var_0, var_3, var_4, (0, 0, 0), self, var_5);

    if(var_1["_encstr_A53009A25003666B9818C6"] != 1)
      return 0;
  }

  return 1;
}

_id_12719(var_0, var_1) {
  self stopgestureviewmodel("_encstr_8C421B9D59CDEBA7DB5B13B42B7D3757E0954E355DDA831B1AB04E9DAC");
  self notify("_encstr_B84D1A6B711733C508DE55DD31380DF8F59BF32FC14FCBBFE8050D67");
  self notify("_encstr_97C615BBADD9700DE3A30F036B7A455165452357530FF0");
  var_2 = getdvarfloat("_encstr_B66F206EC64EBE894EEBE93CC1F5C1EDBB5939DCD7A6D5D60EFAD62D73FA992716C6", 0.25);
  var_3 = getdvarint("_encstr_AB0F27DCB1E4FA26C9EB3D0F0EFA0EDEBB2B4ECDBE35EADAC1EBAD2D9BBE33C90B6C7D9C56995D9B91", 1);

  if(self.vehicle_occupancy_monitormovementcontrols >= var_2 && !_id_12717() && _id_1271C() && !self ismantling()) {
    self playsoundtoplayer("_encstr_8BE6112533D3784095FA41BB647D7827D9E397", self, self);
    self playSound("_encstr_916416021043510B4D69577A84D0E9D7812791139F3042E9", self, self);
    var_4 = getdvarfloat("_encstr_8C3020B96CE4D79827AFE93CE0EB38DBBBB2E49BEB4D5D5B387D672BD8ED6CD2E85E", 1300);
    var_5 = self getplayerangles();
    thread _id_12711();
    _id_1250A(var_5, var_4, self.vehicle_occupancy_monitormovementcontrols);
    thread _id_126D7();
    thread _id_12528();
    self.laststandattackermodifiers = undefined;
    self.vehicle_occupancy_mp_hidecashbag = undefined;
  } else if(var_3) {
    if(level.disable_super_in_turret.spawndistancemax)
      self._id_12821[var_1].choppergunner_refillmissiles.bar.frac = 0;
    else
      self._id_12821[var_1].frac = 0;

    _id_14033(var_0.powers[var_1]._id_128BE, 0);
    self enableoffhandweapons();
    self allowmelee(1);
    self notify("_encstr_9A83101A4D14D775F893B5791590C7EB2743");
    _id_12614();
  } else
    _id_12614();

  _id_12718(var_0, var_1, 1);
}

_id_1270F() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self endon("_encstr_97C615BBADD9700DE3A30F036B7A455165452357530FF0");

  if(self isgestureplaying("_encstr_8C421B9D59CDEBA7DB5B13B42B7D3757E0954E355DDA831B1AB04E9DAC")) {
    return;
  }
  while(self ismantling() || self isthrowinggrenade() || self ismeleeing() || scripts\mp\utility\weapon::grenadeinpullback())
    waitframe();

  self forceplaygestureviewmodel("_encstr_8C421B9D59CDEBA7DB5B13B42B7D3757E0954E355DDA831B1AB04E9DAC");

  while(self isgestureplaying("_encstr_8C421B9D59CDEBA7DB5B13B42B7D3757E0954E355DDA831B1AB04E9DAC")) {
    if(self isonladder()) {
      self stopgestureviewmodel("_encstr_8C421B9D59CDEBA7DB5B13B42B7D3757E0954E355DDA831B1AB04E9DAC");
      break;
    }

    waitframe();
  }
}

_id_12711() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_83F80F56CD0B988D9546AFD3EDD626D2AC", 0);
  wait 0.2;
  self notify("_encstr_9A83101A4D14D775F893B5791590C7EB2743");
  self forceplaygestureviewmodel("_encstr_8FF715E75013DF2357390EC4150F8BBDDBC83BABB88848");

  while(!_id_12715())
    waitframe();

  self notify("_encstr_8A0F15A530A876CB9159EAD3E91B96A627A0FA620F14DF");
  self stopgestureviewmodel("_encstr_8FF715E75013DF2357390EC4150F8BBDDBC83BABB88848");
  self setscriptablepartstate("_encstr_BD640B934A1FC5B8738D4D15A8", "_encstr_8B1608EC43B8D647A113", 0);
  self playsoundtoplayer("_encstr_A2BC0E3DF038AF6E1C1B588EAF07B14E", self, self);
  self playSound("_encstr_AA32179B45DE37B0603A1716531D99ABA85F69C27ED0C1C27C", self, self);
  self playSound("_encstr_9BBC0E1299E8B9BF4FF092CB7EA86B6E", self, self);
  wait 0.2;
  self enableoffhandweapons();
  self allowmelee(1);
}

_id_12715() {
  return self isonground() || self isonladder() || self ismantling();
}

_id_1250A(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  var_5 = (0, 0, 20);

  if(!isDefined(var_3))
    var_3 = var_5;

  var_6 = var_0;
  var_7 = (0, 0, 1);
  var_8 = (1, 0, 0);

  if(getdvarint("_encstr_86B528AB1EBA31FEF3A7151933093F6857777323891A2821ABBF3923DB120BA11B4DFB9BAF7B98EB7213", var_4)) {
    var_7 = propwaitminigameinit();

    if(!isDefined(var_7))
      var_7 = (0, 0, 1);

    var_9 = (0, var_6[1], 0);
    var_10 = anglestoright(var_9);
    var_8 = vectorcross(var_7, var_10);
    var_11 = vectortoangles(var_8);
    var_12 = angleclamp180(var_11[0]);
    var_13 = -85;
    var_14 = var_12;
    var_15 = var_6[0];

    if(var_15 > var_12)
      var_15 = var_12;

    var_16 = getdvarfloat("_encstr_A5502FD38A7318A032F75569E051F8D8BF020B5BD1BB4580CA9F49430C864388871A83E3DAE77D6825B60F4B14E1606F53", -45.0);
    var_17 = getdvarfloat("_encstr_92502FE63627D74CC97D4F8707F583BDEEB2E4377D9AABD6E0AF38A5A36CA1D736F64EC9CAD83A4B7BDCAFB0E8EBB55AB9", 0.0);
    var_18 = (var_15 - var_13) / (var_14 - var_13);
    var_19 = var_17 + var_18 * (var_16 - var_17);
    var_6 = (var_15 + var_19, var_6[1], var_6[2]);
  }

  var_20 = getdvarfloat("_encstr_B15821AFC76BE0402A892A626ADF0820D32725379F52BD704091535893CB8070EA8BF1", 0.0);

  if(var_20 != 0.0)
    var_6 = (var_6[0] + var_20, var_6[1], var_6[2]);

  var_21 = anglesToForward(var_6);
  var_22 = var_21 * var_2 * var_1;
  var_23 = self.origin + var_3;
  self setOrigin(var_23);
  self setvelocity(var_22);
  glassradiusdamage(self.origin + (0, 0, 30), 30, 50, 51);
  var_24 = anglesToForward(self.angles);
  var_25 = self.origin + (0, 0, 30) + var_24 * 15;
  radiusdamage(var_25, 100, 1, 1);
}

_id_126D7() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  var_0 = getdvarfloat("_encstr_8A6D17B9C627BE89E4EBD3C383D758D24EEBC67BE64793BD8D", 400.0);

  if(var_0 <= 0.0) {
    return;
  }
  var_1 = getdvarfloat("_encstr_911321CD6C4EF5C4C97DE9E11CEB2C9639D736F6734727B7D8D7ADB00FAFB9C156B223", 1400.0);
  wait 0.2;

  while(!_id_12715()) {
    var_2 = self getnormalizedmovement();

    if(length(var_2) > 0) {
      var_3 = rotatevector((var_2[0], -1.0 * var_2[1], 0), self.angles);
      var_4 = self getvelocity();
      var_5 = length(var_4);
      var_6 = var_3 * var_0 * level.framedurationseconds;
      var_7 = var_4 + var_6;
      var_8 = length(var_7);

      if(var_8 <= var_1)
        self setvelocity(var_7);
      else if(var_5 < var_1) {
        var_7 = vectorNormalize(var_7) * var_1;
        self setvelocity(var_7);
      }
    }

    waitframe();
  }
}

_id_12528() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self endon("_encstr_8A0F15A530A876CB9159EAD3E91B96A627A0FA620F14DF");
  var_0 = getdvarfloat("_encstr_BE23265B869E39434247F2BA086F87B325AB03E1089783B348025703B8C6630CA3A86079AB3BE8DF", 0.3);

  if(var_0 < 0) {
    return;
  }
  if(var_0 > 0)
    wait(var_0);

  self _meth_87B1();
}

isvalidpointinbounds(var_0, var_1, var_2, var_3, var_4) {
  level notify("_encstr_95C80C5BBBE00548A927C320750F");
  level endon("_encstr_95C80C5BBBE00548A927C320750F");
  var_5 = var_0 + var_1;
  var_6 = var_2 + var_3 * 20;
  var_7 = var_2 + var_4 * 20;

  for(;;)
    waitframe();
}

_id_1271B(var_0, var_1) {
  if(isDefined(self.vehicle_occupancy_monitormovementcontrols))
    _id_12719(var_0, "_encstr_84DD05D205AA0B");
  else
    self notify("_encstr_97C615BBADD9700DE3A30F036B7A455165452357530FF0");
}

propwaitminigameinit(var_0, var_1) {
  if(!isDefined(var_0))
    var_2 = self;
  else
    var_2 = var_0;

  if(!isDefined(var_1))
    var_1 = 0;

  var_3 = [var_2];
  var_4 = [self.origin];

  for(var_5 = -1.0; var_5 <= 1.0; var_5 = var_5 + 2.0) {
    for(var_6 = -1.0; var_6 <= 1.0; var_6 = var_6 + 2.0) {
      var_7 = var_2 getpointinbounds(var_5, var_6, 0.0);
      var_7 = (var_7[0], var_7[1], self.origin[2]);
      var_4[var_4.size] = var_7;
    }
  }

  var_8 = (0, 0, 0);
  var_9 = 0;

  foreach(var_11 in var_4) {
    var_12 = scripts\engine\trace::_bullet_trace(var_11 + (0, 0, 4), var_11 + (0, 0, -16), 0, var_3);
    var_13 = var_12["_encstr_A53009A25003666B9818C6"] > 0.0 && var_12["_encstr_A53009A25003666B9818C6"] < 1;

    if(var_13) {
      var_8 = var_8 + var_12["_encstr_820E07FAE8780B3A4C"];
      var_9++;
    }
  }

  if(var_9 > 0) {
    var_8 = var_8 / var_9;
    return var_8;
  } else
    return undefined;
}

_id_12718(var_0, var_1, var_2) {
  if(istrue(var_2))
    thread _id_12639(var_0, var_1);

  self.vehicle_occupancy_monitormovementcontrols = undefined;
}

_id_1271A(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self endon("_encstr_97C615BBADD9700DE3A30F036B7A455165452357530FF0");
  self endon("_encstr_B84D1A6B711733C508DE55DD31380DF8F59BF32FC14FCBBFE8050D67");

  if(var_1 <= 0) {
    return;
  }
  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::can_killstreak_be_detected(var_1, int(var_1 * 5), 1);
  var_3 = 1;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_3)
      self._id_12821[var_0].choppergunner_refillmissiles.bar.color = (1, 0, 0);
    else
      self._id_12821[var_0].choppergunner_refillmissiles.bar.color = (0, 1, 0);

    wait(var_2[var_4]);
    var_3 = !var_3;
  }
}

_id_125D7(var_0, var_1) {
  var_2 = 1800;
  var_3 = spawnStruct();
  var_3.origin = self.origin;
  var_0 thread scripts\mp\equipment\concussion_grenade::applyconcussion(var_3, self);
  var_0 thread _id_1262E(level.disable_super_in_turret._id_14693);
  var_4 = var_0.origin - self.origin;
  var_5 = vectortoangles(var_4);
  var_6 = distance(var_0.origin, self.origin);
  var_7 = 1.0 - var_6 / var_1;
  var_0 _id_1250A(var_5, var_2, var_7);
}

_encstr_8ECB1A8DA12BB1ADCDC12C77CD772DA3D0B4B9B5C2074E85914BD59B(var_0) {
  if(istrue(level._encstr_BA651BED2E392BD665E82A4328AD8D8372984D724B41139F5718921B20) && isscriptabledefined()) {
    if(isDefined(level._id_12CA9) && level._id_12CA9 >= 0) {
      var_1 = getclosestpointonnavmesh(var_0);
      var_2 = var_1 - var_0;

      if(length2d(var_2) > level._id_12CA9) {
        var_2 = vectorNormalize(var_2);
        var_2 = (var_2[0] * level._id_12CA9, var_2[1] * level._id_12CA9, 0);
        var_0 = var_1 + var_2;
      }
    }
  }

  return var_0;
}

standard_health(var_0) {
  if(isexplosivedamagemod(var_0.meansofdeath) && var_0.objweapon.basename == "_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E" || var_0.objweapon.basename == "_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB" || var_0.objweapon.basename == "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18")
    return 1;
  else
    return 0;
}

_id_1262E(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  self notify("_encstr_81971074BB638F9ED9D0C01A9801D77F5B90");

  foreach(var_3, var_2 in var_0.powers) {
    if(!isDefined(self._id_12821[var_3])) {
      continue;
    }
    self._id_12821[var_3].incooldown = 0;
    thread _id_1262C(var_0, var_3);
  }
}

_id_13982() {
  var_0 = self;
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 notify("_encstr_8A37157F78F36C9385A8830A1EFB0B2D98C0F753D848D6");
  var_0 endon("_encstr_8A37157F78F36C9385A8830A1EFB0B2D98C0F753D848D6");
  var_0 lerpfovbypreset("_encstr_8E420DE9EDDA98B4AC16C936162359");
  var_0 waittill("_encstr_9A83101A4D14D775F893B5791590C7EB2743");
  var_0 lerpfovbypreset("_encstr_8B880E3B782B3B528F416928DF5B3D4D");
}

addtoteamlives(var_0, var_1) {
  var_0 _id_126D8();
}

removefromteamlives(var_0, var_1) {
  var_0 _id_126D8();
}

_id_125E9() {
  return istrue(self.tut_popup_listener);
}

watch_flight_collision(var_0) {
  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3()) {
    var_1 = isDefined(var_0.attacker) && var_0.attacker nukefridgewatcher();

    if(!var_1 || !level.disable_super_in_turret._id_1470A)
      return 0;

    thread _id_1262E(level.disable_super_in_turret._id_14693);
    thread _id_1271D();
    thread _id_12731(var_0);
    thread _id_12701();
  }

  return 1;
}

_id_12731(var_0) {
  var_1 = 500;
  var_2 = 90;
  var_3 = 60;
  var_4 = 30;
  var_5 = var_0.direction_vec;
  var_6 = vectortoyaw(var_5);
  var_7 = var_2;
  var_8 = var_3;

  if(scripts\engine\utility::cointoss())
    var_8 = var_8 * -1;

  var_8 = var_8 + var_6;
  var_9 = (var_7, var_8, 0);
  var_10 = vectorNormalize((var_5[0], var_5[1], 0));
  var_11 = var_10 * var_4 + (0, 0, var_4);
  _id_1250A(var_9, var_1, 1.0, var_11);
}

_id_12701() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self._id_1423B = 1;
  var_0 = getdvarfloat("_encstr_8DEE1C3EEB4366550A697068B369257943994E39454F688335D3E8F88BB8", 1.5);
  wait(var_0);
  self._id_1423B = undefined;
}

_id_1271D() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_852B140A41FF7CB923B8C7BB5FAF0691C293D8337B69");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_BDA21B114FFBF529ABC3C920EF5FA82E328BA783B3E230E8EFDF303857");
  waittillframeend;
  self setlaststandenabled(1);
  self.usedprops = 1;
  self.laststandreviveent makeunusable();
  var_0 = self.laststandreviveent;
  var_0.usetime = getdvarfloat("_encstr_979B19CB7F28694BFE26735BEB40235F50F3532C9B99AF1FA51BCB", 3.0) * 1000;

  if(!isDefined(var_0.curprogress))
    var_0.curprogress = 0;

  while(scripts\mp\utility\player::isreallyalive(self) && var_0.curprogress < var_0.usetime) {
    if(self isinexecutionvictim()) {
      waitframe();
      continue;
    }

    if(!isDefined(var_0.userate))
      var_0.userate = 0;

    var_0.curprogress = var_0.curprogress + level.frameduration * var_0.userate;
    var_0.userate = 1;
    scripts\mp\gameobjects::updateuiprogress(var_0, 1);

    if(var_0.curprogress >= var_0.usetime) {
      break;
    }

    waitframe();
  }

  var_0.usetime = undefined;
  var_0.curprogress = undefined;
  var_0.userate = undefined;
  scripts\mp\laststand::playanim_aibegindismountturret("_encstr_A9DE1493887907E7DB3DFEE94CC11F8AA3201A4A901F", self);
  self playsoundtoplayer("_encstr_A741177B4BBE79EA10D12E7368A13C5237E1679B1D50D3A9D8", self, self);
  self playSound("_encstr_84241BF45B31D73783B17D1393B22CE834F58DC2CD8CF5239C7B835ACD");
  self setlaststandenabled(0);
}

_id_12810() {
  if(istrue(level.br_debugsolotest) || level.gameended) {
    return;
  }
  var_0 = 0;
  var_1 = [];
  var_2 = [];

  foreach(var_4 in level.teamnamelist) {
    var_5 = level.teamdata[var_4]["_encstr_AB580A05672AE35D5FFF50B8"];

    if(var_5 > 0) {
      if(level.teamdata[var_4]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"] > 0) {
        if((level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto || level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback == 0) && var_2.size > 0) {
          return;
        }
        var_2[var_2.size] = var_4;
        var_0 = var_0 + level.teamdata[var_4]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"];
        continue;
      }

      if(level.teamdata[var_4]["_encstr_8A2A0B936CCCC3078547970A8B"] > 0)
        var_1[var_1.size] = var_4;
    }
  }

  if(!level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto && var_0 <= level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback) {
    level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto = 1;
    thread clear_tier_lights_all(var_2);

    if(level.disable_super_in_turret._id_146E8)
      level.disable_super_in_turret._id_146E7 = 0;
  }

  if(var_2.size > 1) {
    return;
  }
  var_7 = scripts\mp\utility\script::quicksort(var_1, ::_id_134D6);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_4 = var_7[var_8];
    var_9 = var_8 + 2;
    thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_1209B(var_4, var_9, 0, 1);
  }

  thread scripts\mp\gamelogic::endgame(var_2[0], game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF36133B4BA241B065DAE6B90541588BAADF81B31B"]);
}

_id_134D6(var_0, var_1) {
  var_2 = level.teamdata[var_0]["_encstr_9B720F83F3966B7258B08E54A959993265"];
  var_3 = level.teamdata[var_1]["_encstr_9B720F83F3966B7258B08E54A959993265"];
  return var_2 >= var_3;
}

_id_1472D() {
  wait 5.0;
  scripts\mp\utility\sound::besttime("_encstr_A29607E9D81842CBBA");
}

_id_126D8() {
  var_0 = self.team;
  level.teamdata[var_0]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"] = 0;

  foreach(var_2 in level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"]) {
    if(!var_2 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_125F3() && !var_2 _id_125E9())
      level.teamdata[var_0]["_encstr_9AFC102CD8B49DB268DEABE6E8905DB558DC"]++;
  }
}