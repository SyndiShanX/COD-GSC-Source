/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\weapon.gsc
***********************************************/

getattachmenttype(var_0) {
  var_1 = tablelookup("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", 4, var_0, 2);
  return var_1;
}

getcompleteweaponnamenoalt(var_0) {
  var_1 = createheadicon(var_0);

  if(istrue(var_0.isalternate))
    var_1 = getsubstr(var_1, 4);

  return var_1;
}

getweapontype(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(iscacprimaryweapon(var_0))
    return "_encstr_BA7F0830B3A7859B60B0";

  if(iscacsecondaryweapon(var_0))
    return "_encstr_AC8F0AE74163F85AAA380AD8";

  if(iskillstreakweapon(var_0))
    return "_encstr_85CE0B9770B02C73A1760F06D2";

  if(issuperweapon(var_0))
    return "_encstr_BEB406F03B72BB3B";

  if(isgamemodeweapon(var_0))
    return "_encstr_AAAC09D09972B9C83F2B7F";

  if(var_0 == "_encstr_91D8142DDDC17D3A5D4E4E2BA3EBD4601B58B1D7AD38" || var_0 == "_encstr_937019DA853757B0D8F51DAE4E9C95E8AF83165E8DBD8523BE5B07" || var_0 == "_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83" || var_0 == "_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A")
    return "_encstr_A7AF07D1EF1B06683C";

  if(var_0 == "_encstr_A7E91B88F09807D33D3F87015E41205658B774598D18AEFAB56039F220" || var_0 == "_encstr_862E1D0666BB921AC150075318B9C94A07FD8E7D42B75B450BC8E75B5910A8" || var_0 == "_encstr_96FC1FB3BBA2C0E8E59F661B02C9F888396F371DDB0A16B92C33CBD3EFA411B123" || var_0 == "_encstr_A2B6232C4E6BBD9C56237DA339C24B377D1B7BC6B7D6DE1D4B9D59FAD1AB9C93AC3ABE5B38" || var_0 == "_encstr_8AE7228539DAED9C95467DD1E485B4E6D7B6EC7DE85DC99395D17DC4BA3333B246BE5BE0" || var_0 == "_encstr_B21F24B093B5DE39598CF5E83958D2E6FA8E85CDAD7D47AB27E4CA47EB895D3333958C7DB50E" || var_0 == "_encstr_A5052A0B27DA7BC99523EB4793855AB9AFD87B6CBDB57B3AB4CE59AFE8BA9C2795E8EB26EACC33CAC8BEADE0")
    return "_encstr_A7AF07D1EF1B06683C";

  if(islevelweapon(var_0))
    return "_encstr_8A0A0638E26B1DC8";

  if(scripts\mp\utility\script::isstrstart(var_0, "_encstr_97880E21FA679D30C3FB795BE26D40F0"))
    return "_encstr_A6460DC8CADC8E4EAB8D3AA5C46356";

  if(isvehicleweapon(var_0))
    return "_encstr_9A50080BA7292FFA0DA2";

  if(isspecialmeleeweapon(var_0) || var_0 == "_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2")
    return "_encstr_9A8D0ECDC1CA365AB08D7D6BB2D8B259";

  if(isenvironmentweapon(var_0))
    return "_encstr_960B0C98A073C3DB4892BA3D3DEB";

  var_1 = getequipmenttype(var_0);

  if(isDefined(var_1))
    return var_1;

  if(var_0 == "_encstr_8BBA05185F8B99")
    return "_encstr_BD4E0B7B104D6AD4DB384717A0";

  if(var_0 == "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E")
    return var_0;

  if(var_0 == "_encstr_9A0D0C4B54606F8F63C84B8B53EE")
    return "_encstr_B28D08B3ABCDB195B9E6";

  if(var_0 == "_encstr_8B11184FDB6B13B42BF5272CB9CEAC23D7C28ED1C236ADD7DA83" || var_0 == "_encstr_87EF174BD808CA3A7B18E59FF913B2AFD1A8CBAF20203FA269")
    return "_encstr_BACB074025B01AAA28";
}

getequipmenttype(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "_encstr_BA410C6338E0D79EC39832198839":
    case "_encstr_AB0B08D8BD58B1EBB607":
    case "_encstr_86B108781A36271E4F70":
    case "_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB":
    case "_encstr_8AF817C568CBE8E754F22078CA6C8DE1270C4E33F41B560BFA":
    case "_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170":
    case "_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83":
    case "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83":
    case "_encstr_ACC40CC1F8A321601715CFBFE0EA":
    case "_encstr_81430B218B3F7018458997D78A":
    case "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860":
    case "_encstr_9AAE0876FCB7603101DB":
    case "_encstr_92A70ABB8267F5E0D89F6351":
    case "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B":
    case "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898":
    case "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1":
    case "_encstr_99410C4B48C39AB7D0CD95B769DB":
    case "_encstr_BA730BF8AFF178988293F158B9":
      var_1 = "_encstr_B116071BCAD186858D";
      break;
    case "_encstr_B8FE1378DF6549CBDB2A405442821591D43769E8B3":
    case "_encstr_932A12897D8237E1ABEF777D5D38B3BF72E9B068":
    case "_encstr_974A19B28974EB1620913F1B917B9B432DE349FBB158C34FD19B28":
    case "_encstr_8183093B28FB2D83C69150":
    case "_encstr_8C2E0D5B1078EEF508EBB81DE067A3":
    case "_encstr_8D2D0E6140B635206963A79B6B4F1163":
    case "_encstr_83B20F81360389C45B1755530BF2AFD0B8":
    case "_encstr_B8D30758E3EE7827BA":
    case "_encstr_BE8B116725FA28FB5178B2CF85017912618763":
    case "_encstr_A79A0E6D85DB6739B15BF89063F73071":
    case "_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E":
    case "_encstr_8823119675DAFF897F878020BB99612B219D8F":
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
    case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
      var_1 = "_encstr_99C209E34FC743616118AB";
      break;
    case "_encstr_9A6E16F73DE35BDB6550810B48BF533F3B11797C450E5B22":
    case "_encstr_8DC1136EB206EB287E2207B0DA5E327EB7E5C92F40":
    case "_encstr_857D10EB68A80C7ABFC5A91EB627C2D1D0E0":
    case "_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E":
      if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
        var_1 = "_encstr_B68610ACC5ABA50EB5CAB9A3F5DEA30D5693";

      break;
    default:
      break;
  }

  return var_1;
}

isenvironmentweapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  switch (var_1) {
    case "_encstr_95300DD8C29D85D713EDAD13AFDA38":
    case "_encstr_8ED01022406F60CB51BD13885E3BA80F33E8":
    case "_encstr_AABB1178920F9FD3AB01DED8F20FB879796A48":
    case "_encstr_AF3B113F77C358E0619DE69BC550788EB9EF89":
    case "_encstr_973F0B6FB76B7F263B80193258":
    case "_encstr_8FDA0D3880E2EF6E3F35108F39114B":
    case "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633":
      return 1;
    default:
      break;
  }

  return 0;
}

issuperweapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  return isDefined(scripts\mp\supers::getsuperrefforsuperweapon(var_0));
}

turnexfiltoside(var_0) {
  if(isDefined(var_0.others)) {
    foreach(var_2 in var_0.others) {
      if(issubstr(var_2, "_encstr_AD9C07E0478148252A"))
        return 1;
    }
  }

  if(isDefined(var_0.attachments)) {
    foreach(var_2 in var_0.attachments) {
      if(issubstr(var_2, "_encstr_AD9C07E0478148252A"))
        return 1;
    }
  }

  return 0;
}

issuperdamagesource(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  if(issuperweapon(var_0))
    return 1;

  if(var_1 == "_encstr_A3030E6F0BBA9688DDE528418FBF80CF")
    return 1;

  if(var_1 == "_encstr_82C314F0CAD76E28993CABDD427FB8A09FA3283E1273")
    return 1;

  if(var_1 == "_encstr_873910FA8BA0453BB8F9C3BF19DB7387A0B3")
    return 1;

  return 0;
}

isgamemodeweapon(var_0) {
  if(isbombsiteweapon(var_0))
    return 1;

  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  switch (var_1) {
    case "_encstr_BD060D9B3F48B9098FC1A169DAA7B4":
    case "_encstr_950A162DEE707D366BD7B54BB1DB266462A6BAD99DD7B538":
    case "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633":
    case "_encstr_A17810A09B234F7B6B65343E7993A0871D53":
    case "_encstr_976A10EB17828EAF30525010DACD41460FB8":
      return 1;
    default:
      return 0;
  }

  return 0;
}

islevelweapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  switch (var_1) {
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
      return 1;
    default:
      return 0;
  }

  return 0;
}

getweapongroup(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0))
    return "_encstr_8261067B1D34AC27";

  if(isstring(var_0) && (var_0 == "_encstr_8BBA05185F8B99" || var_0 == "_encstr_AA7809476984573B7FCDE9"))
    return "_encstr_8261067B1D34AC27";

  var_1 = getweaponrootname(var_0);
  var_2 = weapongroupmap(var_1);

  if(!isDefined(var_2)) {
    if(issuperweapon(var_0))
      var_2 = "_encstr_BEB406F03B72BB3B";
    else if(iskillstreakweapon(var_0))
      var_2 = "_encstr_85CE0B9770B02C73A1760F06D2";
    else if(isgamemodeweapon(var_0))
      var_2 = "_encstr_AAAC09D09972B9C83F2B7F";
    else if(tut_loadout(var_0))
      var_2 = "_encstr_B4221847B0B1D05275AF2EE6F1094A9B7B489F6FB0E93BFA43A1";
    else if(unlockableindex(var_0))
      var_2 = "_encstr_AB0615DD9558C1ED37F59139C23B7BB9DC2193562CA3D0";
    else
      var_2 = "_encstr_8261067B1D34AC27";
  }

  return var_2;
}

runpubliceventoftype(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0))
    return "_encstr_8261067B1D34AC27";

  if(isstring(var_0) && (var_0 == "_encstr_8BBA05185F8B99" || var_0 == "_encstr_AA7809476984573B7FCDE9"))
    return "_encstr_8261067B1D34AC27";

  var_1 = getweaponrootname(var_0);
  var_2 = _id_14594(var_1);

  if(!isDefined(var_2)) {
    if(issuperweapon(var_0))
      var_2 = "_encstr_BEB406F03B72BB3B";
    else if(iskillstreakweapon(var_0))
      var_2 = "_encstr_85CE0B9770B02C73A1760F06D2";
    else if(isgamemodeweapon(var_0))
      var_2 = "_encstr_AAAC09D09972B9C83F2B7F";
    else if(tut_loadout(var_0))
      var_2 = "_encstr_B4221847B0B1D05275AF2EE6F1094A9B7B489F6FB0E93BFA43A1";
    else if(unlockableindex(var_0))
      var_2 = "_encstr_AB0615DD9558C1ED37F59139C23B7BB9DC2193562CA3D0";
    else
      var_2 = "_encstr_8261067B1D34AC27";
  }

  return var_2;
}

unlockableindex(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  return var_1 == "_encstr_AB45111102C198104A7F7D255FC2E5A8A75D1B";
}

tut_loadout(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  switch (var_1) {
    case "_encstr_AD6E1AB959D6A356F0BE85B063E01AB013C8F5CDC163B0B90DBEAD83":
    case "_encstr_A90C1AE6ACB63A5987AFE16BA5ADCA13C027FAE60E36B0DC86D76B07":
    case "_encstr_889F1CA3D0ACC9B62D8EB2FA3CB596DAACC403E4D7390B23A5D5B9BED607":
    case "_encstr_84A0166830BBFB0FB38089F0E1D84E2B5B18102BBA09B85B":
    case "_encstr_B69C1874D1289ABFBB9B4AD16180F353A18D19EC4BAB62AF51F3":
    case "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B":
    case "_encstr_8B9E13779010B4923960C8855327AA3913EA4FF7D0":
    case "_encstr_B45E1514B148FADFDBFB2A718221077490ABE8D1476002":
    case "_encstr_888E0FE659DAD12BC37D89F636D1BE5BC1":
    case "_encstr_8E3B11F9785798B1A7BB5906C267F96061C579":
      return 1;
    default:
      return 0;
  }
}

register_wave_spawner(var_0) {
  var_1 = getweaponrootname(var_0);
  var_2 = level.weaponattachments[var_1];

  if(!isDefined(var_2))
    var_2 = [];

  return var_2;
}

attachmentscompatible(var_0, var_1, var_2) {
  if(attachmentiscosmetic(var_1) && attachmentiscosmetic(var_2))
    return 0;

  var_1 = attachmentmap_tobase(var_1);
  var_2 = attachmentmap_tobase(var_2);
  var_3 = 1;

  if(var_1 == var_2)
    var_3 = 0;
  else if(isDefined(level.carryitem2omnvar)) {
    if(!isDefined(level.carryitem2omnvar[var_0]))
      var_0 = "_encstr_8B1608EC43B8D647A113";

    var_3 = !(isDefined(level.carryitem2omnvar[var_0][var_1]) && isDefined(level.carryitem2omnvar[var_0][var_1][var_2]));
  } else if(var_1 != "_encstr_8BBA05185F8B99" && var_2 != "_encstr_8BBA05185F8B99") {
    if(!isDefined(level.cash_hud_bink[var_0]))
      var_0 = "_encstr_8B1608EC43B8D647A113";

    var_4 = level.cash_hud_bink[var_0];
    var_5 = tablelookuprownum(var_4, 0, var_2);

    if(tablelookup(var_4, 0, var_1, var_5) == "_encstr_BE07036548")
      var_3 = 0;
  }

  return var_3;
}

attachmentsconflict(var_0, var_1, var_2, var_3, var_4) {
  if(attachmentiscosmetic(var_0) && attachmentiscosmetic(var_1))
    return var_0;

  var_5 = undefined;

  if(issameweapon(var_2))
    var_5 = createheadicon(var_2);
  else
    var_5 = var_2;

  if(!isDefined(var_3))
    var_3 = attachmentmap_tounique(var_0, var_5);

  if(!isDefined(var_4))
    var_4 = attachmentmap_tounique(var_1, var_5);

  if(add_head_icon_on_allies(var_3, var_4))
    return var_0;

  if(add_head_icon_on_allies(var_4, var_3))
    return var_0;

  var_0 = attachmentmap_tobase(var_0);
  var_1 = attachmentmap_tobase(var_1);
  var_6 = scripts\mp\weapons::safechecknum(var_5);

  if(isDefined(level.carryitem2omnvar) && !isDefined(level.carryitem2omnvar[var_6]))
    var_6 = "_encstr_8B1608EC43B8D647A113";

  var_7 = "_encstr_B40101";

  if(var_0 == var_1)
    var_7 = var_0;
  else if(isDefined(level.carryitem2omnvar) && isDefined(level.carryitem2omnvar[var_6]) && isDefined(level.carryitem2omnvar[var_6][var_0])) {
    var_8 = level.carryitem2omnvar[var_6][var_0][var_1];

    if(isDefined(var_8)) {
      if(var_8 == "_encstr_BE07036548")
        var_7 = var_0;
      else
        var_7 = var_8;
    }
  }

  return var_7;
}

add_head_icon_on_allies(var_0, var_1) {
  var_2 = carryitemomnvar(var_0);
  var_3 = carryiteminfo(var_1);
  return isDefined(var_2) && isDefined(var_3) && var_3 == var_2;
}

getweaponrootname(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  var_2 = level.weaponrootcache[var_1];

  if(isDefined(var_2))
    return var_2;

  var_3 = var_1;
  var_4 = strtok(var_1, "_encstr_BA4C02DF");

  if(!isDefined(var_4) || var_4.size == 0)
    return "_encstr_B40101";

  var_5 = 0;

  if(var_4[0] == "_encstr_B419040BB1A3")
    var_5++;

  if(var_4[var_5] == "_encstr_B21904D2EE0E" || var_4[var_5] == "_encstr_BD0703AF7C") {
    var_6 = ["_encstr_AD07034A38", "_encstr_990703B843", "_encstr_AA07038DB6", "_encstr_A30703C763", "_encstr_A10703BB40", "_encstr_9707038CB6", "_encstr_A607036B40", "_encstr_8707037C7F", "_encstr_820703E04B", "_encstr_BE0703A54C", "_encstr_BA0703D5C3"];

    if(scripts\engine\utility::array_contains(var_6, var_4[var_5 + 1]))
      var_1 = var_4[var_5] + "_encstr_BA4C02DF" + var_4[var_5 + 1] + "_encstr_BA4C02DF" + var_4[var_5 + 2];
    else
      var_1 = var_4[var_5] + "_encstr_BA4C02DF" + var_4[var_5 + 1];
  }

  if(level.weaponrootcache.size < 100)
    level.weaponrootcache[var_3] = var_1;

  return var_1;
}

relic_nuketimer_globalthread(var_0) {
  var_1 = getweaponrootname(var_0);

  if(isDefined(level.weaponmapdata[var_1]) && isDefined(level.weaponmapdata[var_1].assetname))
    var_0 = level.weaponmapdata[var_1].assetname;

  return var_0;
}

getweaponvarianttablename(var_0) {
  if(scripts\mp\utility\script::isstrstart(var_0, "_encstr_83C5052DBBC1FA"))
    var_0 = getsubstr(var_0, 4);

  if(scripts\mp\utility\script::isstrstart(var_0, "_encstr_81190403FB70")) {}

  return "_encstr_A6180D78E2C8B8C335E317A3B3AB3E" + var_0 + "_encstr_A1B90E013381F3F8505878B735CE9FD3";
}

getweaponbasenamescript(var_0) {
  if(issameweapon(var_0))
    return var_0.basename;

  if(isstring(var_0) && var_0 == "_encstr_8BBA05185F8B99")
    return "_encstr_8BBA05185F8B99";

  return getweaponbasename(var_0);
}

getweapongunsmithattachmenttable(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  var_2 = getweaponrootname(var_1);
  return "_encstr_A6180D78E2C8B8C335E317A3B3AB3E" + getsubstr(var_2, 4) + "_encstr_8B0911EB858EE80B6CA16B2BE6479B71B137D9";
}

getaltmodeweapon(var_0) {
  foreach(var_2 in var_0.attachments) {
    var_3 = attachmentmap_tobase(var_2);

    if(var_3 == "_encstr_8A07035972" || var_3 == "_encstr_AA7608ECD89B6BDE5B59" || var_3 == "_encstr_97D506F770BFFFBB" || var_3 == "_encstr_ADBD0780C4884FEE86" || var_3 == "_encstr_873708FFA8104C0AAEC1" || var_3 == "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5" || var_3 == "_encstr_A78B09ECB16E2B5B47590F" || var_3 == "_encstr_8435070CAC0F080BD2")
      return var_3;
  }

  return undefined;
}

isaltmodeweapon(var_0) {
  if(var_0 == "_encstr_8BBA05185F8B99")
    return 0;

  return weaponinventorytype(var_0) == "_encstr_B4DC085639F9C2779108";
}

removealtmodefromweaponname(var_0) {
  if(isaltmodeweapon(var_0))
    var_0 = getsubstr(var_0, 4);

  return var_0;
}

getvalidextraammoweapons() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = weaponclass(var_3);

    if(!iskillstreakweapon(var_3) && var_4 != "_encstr_8C8D08671D451291C849" && var_4 != "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0" && self getweaponammostock(var_3) != 0)
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

ispickedupweapon(var_0) {
  if(iscacprimaryorsecondary(var_0)) {
    var_1 = undefined;

    if(issameweapon(var_0))
      var_1 = createheadicon(var_0 getnoaltweapon());
    else if(isstring(var_0)) {
      var_1 = var_0;

      if(issubstr(var_1, "_encstr_9B83050BD88EF5"))
        var_1 = getsubstr(var_1, 4, var_0.size);
    }

    var_2 = isDefined(self.pers["_encstr_BE310E88C361A8C3DBA8445586D31770"]) && self.pers["_encstr_BE310E88C361A8C3DBA8445586D31770"] == var_1;
    var_3 = isDefined(self.pers["_encstr_85891093AA774080F789052B879FB0971F72"]) && self.pers["_encstr_85891093AA774080F789052B879FB0971F72"] == var_1;

    if(!var_2 && !var_3)
      return 1;
  }

  return 0;
}

iscacprimaryweapon(var_0) {
  return tv_station_fastrope_one_infil_start_targetname_array(getweapongroup(var_0), var_0);
}

tv_station_fastrope_one_infil_start_targetname_array(var_0, var_1) {
  switch (var_0) {
    case "_encstr_8ACC0DEC0F42B1A0263F50189B45B9":
    case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
    case "_encstr_A3710BEEACC2E0B737EB36B676":
    case "_encstr_A1710B57AD31DBCDCDF1422A60":
    case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
    case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
    case "_encstr_AF710BF4355A9195B0FF0AEAD0":
    case "_encstr_AB0615DD9558C1ED37F59139C23B7BB9DC2193562CA3D0":
    case "_encstr_B4221847B0B1D05275AF2EE6F1094A9B7B489F6FB0E93BFA43A1":
    case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
      return 1;
    default:
      return 0;
  }
}

iscacsecondaryweapon(var_0) {
  return tv_station_fastrope_one_infil_start_targetname_array_index(getweapongroup(var_0), var_0);
}

tv_station_fastrope_one_infil_start_targetname_array_index(var_0, var_1) {
  switch (var_0) {
    case "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195":
    case "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36":
      return 1;
    case "_encstr_8D200E63B9A7DBC550975D5D99600FAA":
      return !isspecialmeleeweapon(var_1);
    default:
      return 0;
  }
}

iscacprimaryorsecondary(var_0) {
  var_1 = getweapongroup(var_0);
  return tv_station_fastrope_one_infil_start_targetname_array(var_1, var_0) || tv_station_fastrope_one_infil_start_targetname_array_index(var_1, var_0);
}

iscacmeleeweapon(var_0) {
  var_1 = getweapongroup(var_0);
  return var_1 == "_encstr_8ACC0DEC0F42B1A0263F50189B45B9" || var_1 == "_encstr_8D200E63B9A7DBC550975D5D99600FAA";
}

enableweaponlaser() {
  if(!isDefined(self.weaponlasercalls))
    self.weaponlasercalls = 0;

  self.weaponlasercalls++;
  self laseron();
}

disableweaponlaser() {
  self.weaponlasercalls--;

  if(self.weaponlasercalls == 0) {
    self laseroff();
    self.weaponlasercalls = undefined;
  }
}

attachmentmap_tounique(var_0, var_1) {
  var_2 = undefined;

  if(issameweapon(var_1))
    var_2 = createheadicon(var_1);
  else
    var_2 = var_1;

  var_3 = getweaponrootname(var_1);

  if(var_3 != var_2) {
    var_4 = getweaponbasename(var_1);

    if(isDefined(var_4)) {
      if(isDefined(level.attachmentmap_basetounique[var_4]) && isDefined(level.attachmentmap_uniquetobase[var_0]) && isDefined(level.attachmentmap_basetounique[var_4][level.attachmentmap_uniquetobase[var_0]])) {
        var_5 = level.attachmentmap_uniquetobase[var_0];
        return level.attachmentmap_basetounique[var_4][var_5];
      } else if(isDefined(level.attachmentmap_basetounique[var_4]) && isDefined(level.attachmentmap_basetounique[var_4][var_0]))
        return level.attachmentmap_basetounique[var_4][var_0];
      else {
        var_6 = strtok(var_4, "_encstr_BA4C02DF");

        if(var_6.size > 3) {
          var_7 = var_6[0] + "_encstr_BA4C02DF" + var_6[1] + "_encstr_BA4C02DF" + var_6[2];

          if(isDefined(level.attachmentmap_basetounique[var_7]) && isDefined(level.attachmentmap_basetounique[var_7][var_0]))
            return level.attachmentmap_basetounique[var_7][var_0];
        }
      }
    }
  }

  if(isDefined(level.attachmentmap_basetounique[var_3]) && isDefined(level.attachmentmap_basetounique[var_3][var_0]))
    return level.attachmentmap_basetounique[var_3][var_0];
  else {
    var_8 = weapongroupmap(var_3);

    if(isDefined(level.attachmentmap_basetounique[var_8]) && isDefined(level.attachmentmap_basetounique[var_8][var_0]))
      return level.attachmentmap_basetounique[var_8][var_0];
  }

  return var_0;
}

attachmentmap_extratovariantid(var_0, var_1, var_2) {
  var_3 = var_1 + "_encstr_854C021F" + var_2;

  if(isDefined(level.weaponlootmapdata[var_3]) && isDefined(level.weaponlootmapdata[var_3].attachextratoidmap) && isDefined(level.weaponlootmapdata[var_3].attachextratoidmap[var_0]))
    return level.weaponlootmapdata[var_3].attachextratoidmap[var_0];

  return 0;
}

attachmentperkmap(var_0) {
  if(isDefined(level.attachmentmap_attachtoperk[var_0]))
    return level.attachmentmap_attachtoperk[var_0];

  return undefined;
}

carryiteminfo(var_0) {
  if(isDefined(level.carrier_remove_carriable_weapon[var_0]))
    return level.carrier_remove_carriable_weapon[var_0];

  return undefined;
}

carryitemomnvar(var_0) {
  if(isDefined(level.carryobjects_onjuggernaut[var_0]))
    return level.carryobjects_onjuggernaut[var_0];

  var_1 = attachmentmap_tobase(var_0);

  if(isDefined(level.carry_ref[var_1]))
    return level.carry_ref[var_1];

  return undefined;
}

weaponassetnamemap(var_0, var_1) {
  if(iskillstreakweapon(var_0))
    return var_0;

  if(isDefined(var_1)) {
    var_2 = var_0 + "_encstr_854C021F" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].assetoverridename))
      return level.weaponlootmapdata[var_2].assetoverridename;
  }

  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].assetname))
    return level.weaponmapdata[var_0].assetname;

  return var_0;
}

weaponperkmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].perk))
    return level.weaponmapdata[var_0].perk;

  return undefined;
}

risktokens(var_0) {
  var_1 = randomintrange(0, level._id_14589[var_0].size);
  return level._id_14589[var_0][var_1];
}

weapongroupmap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].group))
    return level.weaponmapdata[var_0].group;

  return undefined;
}

_id_14594(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0]._id_11BD1))
    return level.weaponmapdata[var_0]._id_11BD1;

  return undefined;
}

weaponnumbermap(var_0) {
  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].number))
    return level.weaponmapdata[var_0].number;

  return undefined;
}

weaponattachdefaulttoidmap(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = var_0 + "_encstr_854C021F" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].attachdefaulttoidmap))
      return level.weaponlootmapdata[var_2].attachdefaulttoidmap;
  }

  if(isDefined(level.weaponmapdata[var_0]) && isDefined(level.weaponmapdata[var_0].attachdefaulttoidmap))
    return level.weaponmapdata[var_0].attachdefaulttoidmap;

  return undefined;
}

weaponattachcustomtoidmap(var_0, var_1) {
  if(isDefined(var_1) && var_1 >= 0) {
    var_2 = var_0 + "_encstr_854C021F" + var_1;

    if(isDefined(level.weaponlootmapdata[var_2]) && isDefined(level.weaponlootmapdata[var_2].attachcustomtoidmap))
      return level.weaponlootmapdata[var_2].attachcustomtoidmap;
  }

  return undefined;
}

safedestroy(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = [];

  var_2 = 1;
  var_3 = [];

  for(;;) {
    var_4 = var_0 + "_encstr_854C021F" + var_2;

    if(!isDefined(level.weaponlootmapdata[var_4])) {
      break;
    }

    if(!level.weaponlootmapdata[var_4].update_focus_fire_objective && !scripts\engine\utility::array_contains(var_1, var_2))
      var_3[var_3.size] = var_2;

    var_2++;
  }

  return var_3;
}

runspawnmodule_isolated(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = [];

  var_2 = 0;
  var_3 = safedestroy(var_0, var_1);

  if(var_3.size > 0)
    var_2 = var_3[randomint(var_3.size)];

  return var_2;
}

weaponexistsinstatstable(var_0) {
  return isDefined(level.weaponmapdata[var_0]);
}

_id_1458C(var_0, var_1) {
  var_2 = weaponexistsinstatstable(var_0);
  var_3 = 1;

  if(var_2) {
    if(isDefined(isDefined(var_1)) && var_1 > 0) {
      var_4 = var_0 + "_encstr_854C021F" + var_1;
      var_3 = isDefined(level.weaponlootmapdata[var_4]) && !level.weaponlootmapdata[var_4].update_focus_fire_objective;
    }
  }

  return var_2 && var_3;
}

weaponattachremoveextraattachments(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = attachmentmap_tounique(var_4, var_1);
    var_6 = attachmentmap_toextra(var_5);

    if(isDefined(var_6))
      var_2[var_2.size] = var_6;
  }

  var_8 = [];

  foreach(var_4 in var_0) {
    var_10 = 0;

    foreach(var_6 in var_2) {
      if(var_4 == var_6) {
        var_10 = 1;
        break;
      }
    }

    if(!var_10)
      var_8[var_8.size] = var_4;
  }

  return var_8;
}

isattachmentsniperscopedefault(var_0, var_1) {
  var_2 = strtok(var_0, "_encstr_BA4C02DF");
  return isattachmentsniperscopedefaulttokenized(var_2, var_1);
}

isattachmentsniperscopedefaulttokenized(var_0, var_1) {
  var_2 = 0;

  if(var_0.size && isDefined(var_1)) {
    var_3 = 0;

    if(var_0[0] == "_encstr_B419040BB1A3")
      var_3 = 1;

    if(var_0.size >= 3 + var_3 && (var_0[var_3] == "_encstr_BE19045AEED8" || var_0[var_3] == "_encstr_921904C3C7E2")) {
      if(weaponclass(var_0[var_3] + "_encstr_BA4C02DF" + var_0[var_3 + 1] + "_encstr_BA4C02DF" + var_0[var_3 + 2]) == "_encstr_850707F7E5833355B8")
        var_2 = var_0[var_3 + 1] + "_encstr_B8FB06FF97EA2708" == var_1;
    }
  }

  return var_2;
}

getweaponattachmentsbasenames(var_0) {
  if(isstring(var_0)) {
    if(var_0 == "_encstr_8BBA05185F8B99")
      return [];
  } else if(var_0.basename == "_encstr_8BBA05185F8B99")
    return [];

  var_1 = getweaponattachments(var_0);

  if(!isDefined(var_1))
    return [];

  foreach(var_4, var_3 in var_1)
  var_1[var_4] = attachmentmap_tobase(var_3);

  return var_1;
}

getattachmentbasenames(var_0) {
  foreach(var_3, var_2 in var_0)
  var_0[var_3] = attachmentmap_tobase(var_2);

  return var_0;
}

getattachmentlist(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_5 = tablelookupgetnumrows("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB");

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = tablelookupbyrow("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", var_6, 5);

    if(var_7 == "_encstr_B40101") {
      continue;
    }
    var_8 = tablelookupbyrow("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", var_6, 2);

    if(isDefined(var_2) && (var_8 == "_encstr_8BBA05185F8B99" || var_8 == var_2)) {
      continue;
    }
    if(isDefined(var_3) && var_8 != var_3) {
      continue;
    }
    if(var_1) {
      var_9 = tablelookupbyrow("_encstr_A39F1718AA97B085834F170957BAC0A0644661B0174E683EFB", var_6, 4);
      var_4[var_4.size] = var_9;
      continue;
    }

    if(scripts\engine\utility::array_contains(var_4, var_7)) {
      continue;
    }
    var_4[var_4.size] = var_7;
  }

  return var_4;
}

getnonopticattachmentlistbasenames() {
  return getattachmentlist(5, 0, "_encstr_851F05E3C813A5", undefined);
}

getopticattachmentlistbasenames() {
  if(isDefined(level.opticattachmentbasenames))
    return level.opticattachmentbasenames;

  level.opticattachmentbasenames = getattachmentlist(5, 0, undefined, "_encstr_851F05E3C813A5");
  return level.opticattachmentbasenames;
}

attachmentmap_tobase(var_0) {
  if(isDefined(level.attachmentmap_uniquetobase[var_0]))
    var_0 = level.attachmentmap_uniquetobase[var_0];

  return var_0;
}

attachmentmap_toextra(var_0) {
  var_1 = undefined;

  if(isDefined(level.attachmentmap_uniquetoextra[var_0]))
    var_1 = level.attachmentmap_uniquetoextra[var_0];

  return var_1;
}

mapweapon(var_0, var_1, var_2) {
  var_3 = var_0;

  if(!isDefined(var_0))
    var_3 = isundefinedweapon();

  var_4 = 0;

  if(var_3.basename != "_encstr_8BBA05185F8B99") {
    if(isDefined(var_1) && !isPlayer(var_1)) {
      var_5 = getaltmodeweapon(var_0);

      if(isDefined(var_5)) {
        switch (var_5) {
          case "_encstr_ADBD0780C4884FEE86":
            var_3 = getcompleteweaponname("_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B");
            break;
          case "_encstr_873708FFA8104C0AAEC1":
            var_3 = getcompleteweaponname("_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683");
            break;
          case "_encstr_8435070CAC0F080BD2":
            var_3 = getcompleteweaponname("_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E");
            break;
          case "_encstr_AFE00DCE634BCDC6CA9BC84B1693E5":
            var_3 = getcompleteweaponname("_encstr_99410C4B48C39AB7D0CD95B769DB");
            break;
        }
      }
    }

    switch (var_3.basename) {
      case "_encstr_A9DA131AB0E9F962F81B8FBF90D63873BF5AA9D5A7":
        var_3 = getcompleteweaponname("_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0");
        break;
      case "_encstr_85430BD44B30713715784912C3":
      case "_encstr_831C13D1EF4317B433165ED3E15B4B37078B57051B":
        var_3 = getcompleteweaponname("_encstr_91D8142DDDC17D3A5D4E4E2BA3EBD4601B58B1D7AD38");
        break;
      case "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8":
      case "_encstr_977F153AAEE4AF3BEAE67D63963B1A3AD1859BDAEB5B83":
        var_3 = getcompleteweaponname("_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0");
        break;
      case "_encstr_BADF128E579CD726C90B46D895F2EBB537FAB6E0":
      case "_encstr_8A9B18CDA79A41114F78E7C8AB7719A3EB6702DFB1F277A75BF3":
        var_3 = getcompleteweaponname("_encstr_B107148D23571AD42BA00B173943ADC34F4AD2C999A1");
        break;
      case "_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E":
        var_3 = isundefinedweapon();
        break;
    }
  } else if(isDefined(var_1)) {
    if(isDefined(var_1.objweapon)) {
      var_3 = getcompleteweaponname(var_1.objweapon.basename);
      var_4 = 1;
    } else if(isDefined(var_1.weapon_name)) {
      var_3 = getcompleteweaponname(var_1.weapon_name);
      var_4 = 1;
    }
  }

  if(var_4 && !istrue(var_2))
    var_3 = mapweapon(var_3, var_1, 1);

  return var_3;
}

attachmentsfilterforstats(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(attachmentlogsstats(var_4, var_1))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

attachmentlogsstats(var_0, var_1) {
  if(attachmentiscosmetic(var_0))
    return 0;

  if(!carriedpunchcard(var_1, var_0))
    return 0;

  if(scripts\engine\utility::string_starts_with(var_0, "_encstr_8B4F0BC6C23747E63A16E6C8AF"))
    return 0;

  return 1;
}

weaponhasattachment(var_0, var_1) {
  var_2 = getweaponattachmentsbasenames(var_0);

  foreach(var_4 in var_2) {
    if(var_4 == var_1)
      return 1;
  }

  return 0;
}

setrecoilscale(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(self.recoilscale))
    self.recoilscale = var_0;
  else
    self.recoilscale = self.recoilscale + var_0;

  if(isDefined(var_1)) {
    if(isDefined(self.recoilscale) && var_1 < self.recoilscale)
      var_1 = self.recoilscale;

    var_2 = 100 - var_1;
  } else
    var_2 = 100 - self.recoilscale;

  var_2 = int(clamp(var_2, 0, 255));

  if(var_2 == 100) {
    self player_recoilscaleoff();
    return;
  }

  self player_recoilscaleon(var_2);
}

_launchgrenade(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self launchgrenade(var_0, var_1, var_2, var_3, var_5);

  if(!isDefined(var_4))
    var_6.notthrown = 1;
  else
    var_6.notthrown = var_4;

  var_6 setotherent(self);
  return var_6;
}

grenadethrown(var_0) {
  return !isDefined(var_0.notthrown) || !var_0.notthrown;
}

grenadeinpullback() {
  return !nullweapon(self getheldoffhand());
}

getgrenadeinpullback() {
  var_0 = self getheldoffhand();

  if(isDefined(self.gestureweapon) && var_0 == asmdevgetallstates(self.gestureweapon))
    var_0 = isundefinedweapon();

  return var_0;
}

weaponignoresblastshield(var_0, var_1) {
  var_2 = var_0.basename;

  if(issuperweapon(var_2))
    return 1;

  if(iskillstreakweapon(var_2))
    return 1;

  switch (var_2) {
    case "_encstr_B8D30758E3EE7827BA":
    case "_encstr_AD1414DCDC1683CD34DB8EF53B272BE65832CAAFDA0E":
    case "_encstr_AC451696FDC2E7B36BDF407843AF093D9A251FADD789B35B":
    case "_encstr_AB0B1199B158CD0DAF76C9B2DC0B2395D7B683":
    case "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E":
    case "_encstr_96AA1696BB1CFACDB6F5D1C9998DB2C643568ED1B27DDAC1":
      return 1;
    default:
      return 0;
  }
}

weaponsupportslaserir(var_0) {
  switch (var_0) {
    case "_encstr_BED80D7C9C59D95BF870DBDFA9F018":
    case "_encstr_8E0817834FDAD69B1FB9C01092739F8837C5998D8F57FBE510":
    case "_encstr_9108172387E0115177299BE0326B16E0CCEDA1A1071DB024D6":
    case "_encstr_AC0817636F3718D0A51183F8059C68CB9A8FF1F1378A5730AE":
    case "_encstr_A30817AF1FA2485D2BA926E3772BAEC27C87E315B9314BEBFB":
    case "_encstr_8F081780BBC06F784FBFDE5B97D363C97C622070912D695362":
    case "_encstr_A108171A6393EFCDB01FDAD96760127B5359C252CE818BC3EA":
    case "_encstr_930817AB0F7889D9FF911378BA938E684475D939BF95389C5A":
    case "_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1":
    case "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB":
    case "_encstr_8B161CE1674A5927235032DA1B88670AB01B67779FA01FEBD8A9DA4160DF":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C":
    case "_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB":
      return 0;
  }

  if(iskillstreakweapon(var_0))
    return 0;

  var_1 = weaponclass(var_0);
  return var_1 == "_encstr_965306392D3336B2" || var_1 == "_encstr_BE0703A54C" || var_1 == "_encstr_850707F7E5833355B8" || var_1 == "_encstr_BE1904DCDA9D" || var_1 == "_encstr_A1100738A33A638123";
}

getweaponnvgattachment(var_0) {
  return "_encstr_9B6B081A7BABC93A37DE";
}

issinglehitweapon(var_0) {
  var_0 = getweaponbasenamescript(var_0);

  switch (var_0) {
    case "_encstr_8A6E10B968F5D885BE0E0B63831A58BEAD0E":
    case "_encstr_B6D110371AEBC60B7DDADAD236DBC4F5B683":
    case "_encstr_9331124BFBD033DE7171F9CC49F0E61ACE0E2203":
    case "_encstr_8C2F1137A27861F12E284A3D76576398DF8B6B":
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
    case "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB":
    case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
    case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
      return 1;
    default:
      return 0;
  }
}

attachmentiscosmetic(var_0) {
  return isDefined(var_0) && scripts\engine\utility::string_starts_with(var_0, "_encstr_BE91055A80D60F");
}

carriedpunchcard(var_0, var_1) {
  var_2 = getweaponrootname(var_0);
  return carrier_cleanup(var_2, var_1);
}

carrier_cleanup(var_0, var_1) {
  var_2 = level.weaponattachments[var_0];
  return isDefined(var_2) && isDefined(var_2[var_1]);
}

_id_12BBB(var_0) {
  switch (var_0) {
    case "_encstr_885E09D8B0B959E4C219B9":
    case "_encstr_A9F90E09660BF37B52AF4010AB6B5139":
    case "_encstr_91D30B98AF82FABB1A37C877AA":
      var_0 = "_encstr_91EC068D0B372B93";
      break;
    case "_encstr_AB1A088A2B783257C1BB":
    case "_encstr_979A07DA7B286267F1":
    case "_encstr_9BD30A0BAB18273B3621B3DF":
    case "_encstr_93D30AD8438B4F581830430B":
    case "_encstr_A3D30A9BD263B29B6C959C19":
      var_0 = "_encstr_AD3E09B95A632BDC6CCA27";
      break;
    case "_encstr_8FF70FF37033E3D36FB50D45145BAABA59":
    case "_encstr_8B4A094CB0276C57DC47C8":
    case "_encstr_95A3082BA8EBCBFB578D":
    case "_encstr_A98B0840112B5A452B54":
    case "_encstr_A39B07DDDFC235D08A":
    case "_encstr_91A51015B15250F37F9B3B6052073588EA0C":
    case "_encstr_858E09935E8397836868F3":
      var_0 = "_encstr_A98B0840112B5A452B54";
      break;
  }

  return var_0;
}

_id_14584(var_0) {
  var_1 = "_encstr_8BBA05185F8B99";
  var_2 = -1;
  var_3 = getweaponrootname(var_0);

  if(isDefined(var_0) && !nullweapon(var_0)) {
    var_1 = weaponclass(var_0);

    switch (var_1) {
      case "_encstr_8D940738966ED1DB8D":
        var_2 = 1;
        break;
      case "_encstr_850707F7E5833355B8":
        if(getweapongroup(var_0) == "_encstr_A1710B57AD31DBCDCDF1422A60") {
          if(var_3 == "_encstr_A52C0E7020307103407898128DC7C6CB" || var_3 == "_encstr_BAA51049A41A67CACDF1230A9823050EC3AF" || var_3 == "_encstr_A34C12B0EB7A380815D7690B13FA20F68F12C8FB" || var_3 == "_encstr_8C59102DEE0EFACDB9FA369CDB6E3713DEDD")
            var_2 = 2;
          else
            var_2 = 4;
        } else if(var_3 == "_encstr_A1B312733C88381B6A0EDB0692184B8B4A030B35" || var_3 == "_encstr_A70D0F3A797EF0921E5F71E95ACA428B3A" || var_3 == "_encstr_82660D691C902EABA8293197FB038E" || var_3 == "_encstr_BD9014098FA2B1A7589E3B17A32D0776E02FBB871920" || var_3 == "_encstr_9601125ADD1CEB3737F58E4E9B8E2C3746B09C32" || var_3 == "_encstr_93340F4BFBD0371A7153EACF7398652E4B")
          var_2 = 6;
        else if(var_3 == "_encstr_B453108C3B128FFBF07F5B077B2AC2B9FA4A" || var_3 == "_encstr_AC26134BEF9869363371F3526BDFEC60A243EBCB69" || var_3 == "_encstr_96DE0F464761236B899BB340E0EA8D12EE")
          var_2 = 3;
        else
          var_2 = 5;

        break;
      default:
        var_2 = 0;
    }
  }

  return var_2;
}

isbombsiteweapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  switch (var_1) {
    case "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E":
    case "_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B":
      return 1;
  }

  return 0;
}

iskillstreakweapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  if(isDefined(level.killstreakweaponmap) && isDefined(level.killstreakweaponmap[var_1]))
    return 1;

  return 0;
}

unsetreduceregendelayonkills(var_0) {
  return isDefined(var_0) && isDefined(var_0.vehiclename) && isDefined(var_0.streakinfo);
}

weaponbypassspawnprotection(var_0) {
  var_1 = 1;
  var_2 = undefined;

  if(issameweapon(var_0))
    var_2 = var_0.basename;
  else
    var_2 = var_0;

  if(iskillstreakweapon(var_0) && var_2 != "_encstr_969E11D61673EA0B8DF58EAE39272B477DB61C" && var_2 != "_encstr_B2C0155057B3262F92258D96F869792B0AA370E847451B" && !update_health_on_spawn(var_2))
    var_1 = 0;

  return var_1;
}

isvehicleweapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  switch (var_1) {
    case "_encstr_9104161ABF1B119F7EA97ACF8AD02F6B8193702F6DCF6BE0":
    case "_encstr_BDA519211FEB60E8AD450E81AE7288A0124F9BB11F533080DB9F53":
    case "_encstr_BD171279485ABEA7ABE8E649388A083FC37FED51":
    case "_encstr_A2CF0C31B4B37D985A2746D76B07":
    case "_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0":
    case "_encstr_9BC214E7BF293BA9AD583A63A1971EF323A8735F59D3":
    case "_encstr_96BD0D28C35788412CD56341C7D583":
    case "_encstr_82C50EF0AA8BE0C0963187E155F17037":
    case "_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43":
    case "_encstr_99E107C0F71E86B363":
    case "_encstr_AF3011DD1D21D7BB459072BB83A7F2B3BEF148":
    case "_encstr_AB6F081B8D7949AFC813":
    case "_encstr_8A6C1038D236D6D5E0EBA393ABD8DABEAD0E":
    case "_encstr_87BF13EC43105F1F201BBBB2600E03154801A765F9":
    case "_encstr_A7AA0DE816C6D727DBCEB2C9EBB61C":
    case "_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213":
    case "_encstr_8D7B0D3007F3805512A6C759B18AB1":
    case "_encstr_BE2610C077D0B2630B5683EB7B6E472168F1":
    case "_encstr_8CBA0AD33D120153A1AFA040":
    case "_encstr_B2F60B166F934917E1C5C7BA1B":
    case "_encstr_92B90BC2C11BBEE4AE6ED7AD0E":
    case "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0":
    case "_encstr_A7A70785E89DD7AD0E":
    case "_encstr_827E0D809A9733A0E3992D3FBF8D48":
    case "_encstr_A64016B36332B9F41BEBE7ADFB81C908C77A19690C8188BC":
    case "_encstr_85B1132B9BA06F5A9DFD679BE1502298218165F5D1":
    case "_encstr_84A00E50B085578F87182E98ED81081B":
    case "_encstr_B8210FE85D27D785E0B1BE935D9BBE6B07":
    case "_encstr_88E90F60526BE39B37B026C8BBEA614FB1":
    case "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8":
    case "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2":
    case "_encstr_8EC319437BB679EF28B0A17249903CB287E167DB1D5DE2AB513862":
    case "_encstr_8E26171D5DE4FACEBAE6F51B85C9B3DBD78EC9EA1B5BD7DA38":
    case "_encstr_B65F1413E4B03236ACF2D78EDBDDEB83E4BD4DFAD61C":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
      return 1;
    default:
      return 0;
  }
}

isgesture(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  if(issubstr(var_1, "_encstr_A69F097F45DBCF92BBF74E"))
    return 1;
  else if(issubstr(var_1, "_encstr_8E550E681AD383D8FB0F5E580BFF2079"))
    return 1;
  else
    return 0;
}

getweaponfullname(var_0) {
  if(isstring(var_0))
    return var_0;
  else
    return createheadicon(var_0);
}

playdeatomizefx(var_0, var_1) {
  var_2[0][0]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_813B0D4027B390B37585BBC819FD28");
  var_2[0][0]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_813B0D4027B390B37585BBC819FD28");
  var_2[0][1]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_83890D9CA8EF0B79D830939788913A");
  var_2[0][1]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_83890D9CA8EF0B79D830939788913A");
  var_2[0][2]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_AADA07DBF19A4A81D7");
  var_2[0][2]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_AADA07DBF19A4A81D7");
  var_2[1][0]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_BD500A3C087F4AD519410B6F");
  var_2[1][0]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_BD500A3C087F4AD519410B6F");
  var_2[1][1]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_AC500A7A366A5BBFC04F9465");
  var_2[1][1]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_AC500A7A366A5BBFC04F9465");
  var_2[1][2]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_A78B0B4D7DAC6398F6DDEB27A5");
  var_2[1][2]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_A78B0B4D7DAC6398F6DDEB27A5");
  var_2[1][3]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_8D8B0B309FA99B7EFA735F68F1");
  var_2[1][3]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_8D8B0B309FA99B7EFA735F68F1");
  var_2[2][0]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_A1D50BD4BE2CDC6D36B2EBC695");
  var_2[2][0]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_A1D50BD4BE2CDC6D36B2EBC695");
  var_2[2][1]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_83D50BE2875F1037FDBA096892");
  var_2[2][1]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_83D50BE2875F1037FDBA096892");
  var_2[2][2]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_A1190BD4FABB9396DC47EB8DAC");
  var_2[2][2]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_A1190BD4FABB9396DC47EB8DAC");
  var_2[2][3]["_encstr_8C19045F7009"] = self gettagorigin("_encstr_83190BED4757A3B3B20C5E83E0");
  var_2[2][3]["_encstr_A7610758E6CED8569B"] = self gettagangles("_encstr_83190BED4757A3B3B20C5E83E0");
  var_3 = "_encstr_AFCF1B31EAB1D856D1EB58D1B7DA96D3B2C9F596AD0E85C68EEBE60ED8";
  var_4 = (0, 0, 0);

  if(isDefined(var_1))
    var_4 = var_1;

  if(isDefined(var_0))
    var_3 = var_0;

  self playSound(var_3);

  foreach(var_6 in var_2) {
    foreach(var_8 in var_6)
    playFX(level._effect["_encstr_AD560D1EE388D3C82B222E9828A483"], var_8["_encstr_8C19045F7009"] + var_4, anglesToForward(var_8["_encstr_A7610758E6CED8569B"]));

    wait 0.01;
  }
}

isprimaryweapon(var_0) {
  if(nullweapon(var_0))
    return 0;

  if(var_0.inventorytype != "_encstr_BA7F0830B3A7859B60B0" && var_0.inventorytype != "_encstr_B4DC085639F9C2779108")
    return 0;

  switch (var_0.classname) {
    case "_encstr_BE1904DCDA9D":
    case "_encstr_8D940738966ED1DB8D":
    case "_encstr_850707F7E5833355B8":
    case "_encstr_A1100738A33A638123":
    case "_encstr_BE0703A54C":
    case "_encstr_965306392D3336B2":
    case "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0":
      return 1;
    default:
      return 0;
  }
}

update_health_bar_to_player(var_0) {
  if(issameweapon(var_0))
    var_1 = var_0.basename;
  else
    var_1 = var_0;

  return var_1 == "_encstr_AFBB115ADD1CD75BDCA5CC56DC1D2CC4D7DAC1" || var_1 == "_encstr_AFBB115ADD1CD75BDCA5CC56DC1D2CC4D7DAC1" || var_1 == "_encstr_B6202030B8C2304120681F3C3C48493BD6B4CC476F18BBF297D92FA5085FC1F7E5FB" || var_1 == "_encstr_93C224EC0CC949B4C8586F07A8209FB2CDABB767E0ABB2EDF1100347E0FE5D1AB135FF1151E9" || var_1 == "_encstr_A10A211A6393EF8BD845C7C76BB01777D0D86242CE0583041051FFD51B885FB790F07B";
}

isknifeonly(var_0) {
  return getweaponrootname(var_0) == "_encstr_87610AB4EE83FAD6374B3395";
}

ismeleeonly(var_0) {
  if(isstring(var_0)) {}

  return var_0.ismelee;
}

isfistsonly(var_0) {
  return getweaponrootname(var_0) == "_encstr_A7ED0AD79F73990E28334B92";
}

isballweapon(var_0) {
  return var_0.basename == "_encstr_976A10EB17828EAF30525010DACD41460FB8" || var_0.basename == "_encstr_A17810A09B234F7B6B65343E7993A0871D53";
}

isaxeweapon(var_0) {
  var_1 = getweaponrootname(var_0);
  return var_1 == "_encstr_8386085CBC67F9711A30" || var_1 == "_encstr_A9290E3FA3DE19C93748D1D7C0012B28" || var_1 == "_encstr_8C890A037586DF3FDF50D31A";
}

validatefuelstability(var_0, var_1) {
  return isaxeweapon(var_0) && isDefined(var_1.classname) && var_1.classname == "_encstr_8C8D08671D451291C849";
}

turret_aimed_at_last_known(var_0) {
  return getweaponrootname(var_0) == "_encstr_B6BD13609368A9E10A1FABA7DF52BEE0CAAD6B18FB" || getweaponrootname(var_0) == "_encstr_9B031467F4EAE7ADE56E91CFF3656002AE6B3129F5AB";
}

isthrowingknife(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0))
      return 0;

    var_1 = var_0.basename;
  } else {
    if(var_0 == "_encstr_8BBA05185F8B99")
      return 0;

    var_1 = var_0;
  }

  return issubstr(var_1, "_encstr_92590EFBF91ED25750D8D7DC30B88E8A");
}

isspecialmeleeweapon(var_0) {
  if(update_health_bar_to_player(var_0))
    return 1;

  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0))
      return 0;

    var_1 = var_0.basename;
  } else {
    if(var_0 == "_encstr_8BBA05185F8B99")
      return 0;

    var_1 = var_0;
  }

  return var_1 == "_encstr_A393109FCF38E936DA97CCE3177050314CB8";
}

unset_relic_mythic(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0))
      return 0;

    var_1 = var_0.basename;
  } else {
    if(var_0 == "_encstr_8BBA05185F8B99")
      return 0;

    var_1 = var_0;
  }

  return var_1 == "_encstr_9A0D0C4B54606F8F63C84B8B53EE" || var_1 == "_encstr_962A124B7707BE76EADC1B566EDCFA5A3799A5C6" || var_1 == "_encstr_B4FE1DE7AF23C95F98E03D477B905F32573F1BC74FAD921E78AE778D73C8BA";
}

update_health_on_spawn(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0))
      return 0;

    var_1 = var_0.basename;
  } else {
    if(var_0 == "_encstr_8BBA05185F8B99")
      return 0;

    var_1 = var_0;
  }

  return var_1 == "_encstr_9B1315648431B1256020FFFFC0B8EBBB4D1D6F1F7833FB" || var_1 == "_encstr_8B161CE1674A5927235032DA1B88670AB01B67779FA01FEBD8A9DA4160DF" || var_1 == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB";
}

unset_jugg_ignoreall_after_notify(var_0) {
  if(!isDefined(var_0))
    return 0;

  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0))
      return 0;

    var_1 = var_0.basename;
  } else {
    if(var_0 == "_encstr_8BBA05185F8B99")
      return 0;

    var_1 = var_0;
  }

  return var_1 == "_encstr_A2C219E404B131BBCD290B06C0FA70CAC79E6CDBE5AD8AE74ED013";
}

infiniteammothread(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_81A91A7B3DE8C3292B808A72A803DB2F462FFDEDD8B69B2CC520E29A");

  if(!isDefined(var_0))
    var_0 = level.framedurationseconds;

  for(;;) {
    if(!isDefined(var_1))
      var_1 = self.equippedweapons;

    foreach(var_3 in var_1) {
      self givemaxammo(var_3);
      self setweaponammoclip(var_3, weaponclipsize(var_3));
    }

    wait(var_0);
  }
}

stopinfiniteammothread() {
  self notify("_encstr_81A91A7B3DE8C3292B808A72A803DB2F462FFDEDD8B69B2CC520E29A");
}

russianletter(var_0) {
  if(isDefined(level.br_pickups) && isDefined(level.br_pickups.br_weapontoscriptable) && isDefined(level.br_pickups.delay_hide_player_clip)) {
    var_1 = createheadicon(var_0);
    var_2 = level.br_pickups.br_weapontoscriptable[var_1];

    if(isDefined(var_2))
      return level.br_pickups.delay_hide_player_clip[var_2];
  }

  var_3 = scripts\mp\loot::getlootinfoforweapon(var_0.basename, var_0.variantid);

  if(isDefined(var_3))
    return var_3.quality;

  return undefined;
}

safe_to_authenticate(var_0) {
  if(isDefined(level.br_pickups) && isDefined(level.br_pickups.br_weapontoscriptable) && isDefined(level.br_pickups.delay_hide_player_clip)) {
    var_1 = createheadicon(var_0);
    var_2 = level.br_pickups.br_weapontoscriptable[var_1];

    if(isDefined(var_2))
      return level.br_pickups.delay_hide_player_clip[var_2];
  }

  return undefined;
}

unset_relic_damage_from_above(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0))
    var_1 = getweaponbasename(var_0);
  else
    var_1 = var_0;

  switch (var_1) {
    case "_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A":
    case "_encstr_87E016D616B9D558D8D78E5DE4C9CAA3AF666316DAD7AD83":
    case "_encstr_97781E650A25C38AAC57A0C87B5BB7F5DF8A108FA21EBB8BF030E72F98F028EA":
      return 1;
    default:
      return 0;
  }
}