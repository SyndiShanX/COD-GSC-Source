/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\tac_ops\roles_utility.gsc
***********************************************/

kitspawn() {
  if(istrue(self.tacopsstealthrole))
    givestealthperks();
}

kittoicon(var_0) {
  switch (var_0) {
    case 1:
    default:
      return "_encstr_B109188A2079CBD04E303723E821ADF215CDD9059DAD0204D310";
    case 2:
      return "_encstr_872B184852DF68A18C23F7915D3568B88FBB63F1FA1708D0230C";
    case 8:
    case 3:
      return "_encstr_B8DE16B4D8BD9BF5B6B97DC25AC9F5B9BA072BE47D43EA46";
    case 4:
      return "_encstr_A36E11D26CDEDCAFB56EAF35573BB3F586AB19";
    case 5:
      return "_encstr_A957145A1BBDCDD75B377D3785E8D71B7BB6D7865D23";
    case 6:
      return "_encstr_8DC1182A0207CBEBF1D327B4DA5925F703E1F74B4056929B91EC";
    case 7:
      return "_encstr_9A84183A385820B7C8A7112BD02859098377BFF3B7731E5283EA";
    case 9:
      return "_encstr_B1741767D828A639076E093A5D25436232D1A79F2886E8C361";
    case 10:
      return "_encstr_9AFC132DC6B79BAF6DE6FAD6C2DC5A85D8BE1AEAC8";
  }
}

kittohintstring(var_0) {
  switch (var_0) {
    case 1:
    default:
      return &"_encstr_BDD2203582BC429E31227D453DFAA845AA2941D745A0863D056AEB352882757215A4";
    case 2:
      return &"_encstr_97701F6A0ABC42A72611EB8AD3EBA2A855A4A07DA2A034D3056AAFA1D382458A25";
    case 8:
    case 3:
      return &"_encstr_932122B90AEE89FC5C1BF959CFB7757391E48F389360E7A4686FF1F993948C11A81F06A3";
    case 4:
      return &"_encstr_A1F91D15481E041F517B968C083F3189AD64F2B13380F104803F9FBACF1D07";
    case 5:
      return &"_encstr_ADE720EB531F619F6898E019688FF30A5B24784709D1A8682B7E88472BDF1303BD3A";
    case 6:
      return &"_encstr_8BAC1E4D872DC0C4C4A8905CD4CFDF795DA70A10E9C14728907BDE6BE8B501C6";
    case 7:
      return &"_encstr_931C204D40D6F334DCD8C0BB45891F2A0BAB5A8F9B1780AFD719596153EDFEA119E1";
    case 9:
      return &"_encstr_A5021F6A055E423D3122EB457A7D5145AA9282EB51051AA7286AD72AAA29945451";
    case 10:
      return &"_encstr_87EC1C972140E058299569D36867B0A157415B57996523802936611F47A7";
  }
}

enabletacopsstations(var_0) {
  foreach(var_2 in var_0)
  var_2 enabletacopskit();
}

initroles() {
  level.teamspotindices = [];
  level.teamspotindices["_encstr_9A8507BA4040188D08"] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  level.teamspotindices["_encstr_8E8405EA382B2A"] = [11, 12, 13, 14, 15, 16, 17, 18, 19, 20];
  level thread managespotteromnvars();
}

createtacopskitstation(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_4 setModel("_encstr_8601133B681070F1EFB54C0396F30B2DBE70CF3780");
  var_4.kittype = var_0;
  var_4.forteam = var_2;

  if(!istrue(var_3))
    var_4 enabletacopskit();

  if(!isDefined(level.tacopsstations))
    level.tacopsstations = [];

  level.tacopsstations[level.tacopsstations.size] = var_4;
}

enabletacopskit() {
  self makeusable();
  thread tacopskitsuseteamupdater();
  var_0 = kittoicon(self.kittype);
  self.curobjid = createkitobjective(var_0, self.forteam);
  scripts\mp\gameobjects::setusetext(&"_encstr_85B116653F4A60E887BD4B37955C01AD19C7AD7DF7C12E30");
  self setHintString(kittohintstring(self.kittype));
  self setusepriority(0);
  level thread tacopskitstationonuse(self);
}

tacopskitsuseteamupdater() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    setusablebyteam(self.forteam);
    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
  }
}

setusablebyteam(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.team != var_0 || isDefined(var_2.tacopskit)) {
      self disableplayeruse(var_2);
      continue;
    }

    self enableplayeruse(var_2);
  }
}

tacopskitstationonuse(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_8F5C086405E70FBA4B4A", var_1);
  var_1.tacopskit = var_0.kittype;
  var_2 = [];

  switch (var_0.kittype) {
    case 1:
    default:
      if(var_1.team == "_encstr_9A8507BA4040188D08")
        scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_916C1AEC7971D553A67652CB3810030D803B73719F201FDFDE687A83", var_1);
      else
        scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_A74E1B21B0EFD88F9ABF0B3357324068670D895BDE0778CD82271F053F", var_1);

      var_1 scripts\mp\supers::givesuper("_encstr_ADD214F3C3607B0E7FE89896D0F8697EE183E91B1752");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["_encstr_A93B0E3BF7C699BA1B13775FA57BA06B"] = "_encstr_ADD214F3C3607B0E7FE89896D0F8697EE183E91B1752";
      var_2[0] = &"_encstr_A9F428A9256A68EB6A8AA64D05E8A8A6BE35289745F4BE50263165AF49A7C42AAF869E9A9A82E488BE26";
      var_2[1] = &"_encstr_A2F428F34F59CE89352FEFE7C6E7811E31E741AF53E088311C75567E3A87815DE937C7E3AFA8F82177C2";
      break;
    case 5:
      if(var_1.team == "_encstr_9A8507BA4040188D08")
        scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_86BA19B81B497BAB23EFB784A4AF9337ED528828C19A8B8127F695", var_1);
      else
        scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_8E6619FBF89EA7AB0AA97991FEE98712489C7AF2F6718C8DB815C3", var_1);

      var_1 grantspotterkit();
      var_1 scripts\mp\supers::givesuper("_encstr_A7E111921560D1A3EF63FF1F40E00BF7D3F2B8");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["_encstr_A93B0E3BF7C699BA1B13775FA57BA06B"] = "_encstr_A7E111921560D1A3EF63FF1F40E00BF7D3F2B8";
      var_2[0] = &"_encstr_9BE127690B2195B70DCB225FD9D4A5C726DD7B78CBF0A19999110B873F850B3DB16F8747C45089AFD6";
      var_2[1] = &"_encstr_A7E1271D0B431517FD2FE67F57D73DEF87308932619760090119D33FB29F4D1D6FA7E135944BA9C966";
      var_2[2] = &"_encstr_ABE127BB071186D17D67572F1E1F49C689BF39F7EB3870F9440D1EA6F2CFF91521BF83BF7790BD41D3";
      break;
    case 2:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_B6DD17191EF5D6C14CD7F6B31BBEC97B8D56E685EB4D3AC26C", var_1);
      var_1 scripts\mp\supers::givesuper("_encstr_ACA512FBBB41391E99BB490F10996710E1EBF0D2");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["_encstr_A93B0E3BF7C699BA1B13775FA57BA06B"] = "_encstr_ACA512FBBB41391E99BB490F10996710E1EBF0D2";
      var_2[0] = &"_encstr_863E249B2731A6F15D47774F7E7F69E6A95FD9D7CB5810D9A4ED3EC6D22F193541D763B54F47";
      var_2[1] = &"_encstr_9B3E243525D4A1FAA92A6A35058E51A9FAD482E5A27AD714983195F594D313A27D825225BE23";
      break;
    case 10:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_AD90176301403A98F0368E92A9D0EF832051EFA79DE8124970", var_1);
      var_1 scripts\mp\supers::givesuper("_encstr_8D35126EAB389527BE8EB0B1AFED83CDEBD98537");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["_encstr_A93B0E3BF7C699BA1B13775FA57BA06B"] = "_encstr_8D35126EAB389527BE8EB0B1AFED83CDEBD98537";
      var_1.tacopsgasrole = 1;
      var_2[0] = &"_encstr_ACA2243C3C07FD88B87F7B6F07F70B168FBB77B18FD0F95D13188F90FBB7B4A12F4757DFB941";
      var_2[1] = &"_encstr_A3A22453294D1AAF6A156A4D503A5435BE5341AF8AA7FA829898B2D792D331A2AFD1054DD719";
      break;
    case 8:
    case 3:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_9AC71CA102B0F56B8129E88B54A9825889C14E1E71F3E3F157D505FDE550", var_1);
      var_1 scripts\mp\supers::givesuper("_encstr_BD7717BB2348971B7853F2DA18C7C7C128D53439B910DF5313");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["_encstr_A93B0E3BF7C699BA1B13775FA57BA06B"] = "_encstr_BD7717BB2348971B7853F2DA18C7C7C128D53439B910DF5313";
      var_2[0] = &"_encstr_93502A01E1E7C50FE5E85951C00F639F7F5D37B8146F8EFB9D607129C9D5B9952739BE9D91CB94CBF2194952";
      var_2[1] = &"_encstr_A1502AC43C2369D8A8972F379FD00D219785EF101357D19F905B3327FB38C1297F6E17F7CC8C81A50937C7C5";
      break;
    case 4:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_85D018ABF8D62D438DE08DC351CF5BE718887F4729C98ADAFF0E", var_1);
      var_1 scripts\mp\supers::givesuper("_encstr_8AE1189BA091772DD98111582F93F351D253A78C5903D017B363");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["_encstr_A93B0E3BF7C699BA1B13775FA57BA06B"] = "_encstr_8AE1189BA091772DD98111582F93F351D253A78C5903D017B363";
      var_2[0] = &"_encstr_8C74256D14A17BC189A36F5793A4A8A3197CD27D2FE9DF7871D94F6F5D78C4ED71241BFFE511F9";
      var_2[1] = &"_encstr_B17425F789AF8B394B750A324F775043F6417BF6F984DF80319980392EBFF81D9EC1E7CFC9FE0A";
      break;
    case 7:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_BD94190491993DAB5E9E6A93E121DF32C011BD9B3DF1C2BFF0F333", var_1);
      var_1 givestealthperks();
      var_2[0] = &"_encstr_950F28C31B4927B18F3F4EB24D0F2FD31FA9C27A71C91113DD9963A98F2C81FDE1A9595D99450C880F0F";
      var_2[1] = &"_encstr_A20F280FAB9E346F418DCAC22539BDD9704B830E0928892931B470D9BFA18CF028CF1B3F8BC181E88113";
      break;
    case 6:
      if(var_1.team == "_encstr_9A8507BA4040188D08")
        scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_932E19E9F3E13D43AAEF6F3B44B1AB976C4A4079EF0580740BFE32", var_1);
      else
        scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_992319C81E7D5B1C987D2CC5C6B5AFE4BDD859DC317DB52B464B36", var_1);

      var_1 scripts\mp\supers::givesuper("_encstr_95381A2398873505EE09A7E839E0109B560B7380D3FA8377AB8BC72F");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["_encstr_A93B0E3BF7C699BA1B13775FA57BA06B"] = "_encstr_95381A2398873505EE09A7E839E0109B560B7380D3FA8377AB8BC72F";
      var_1.tacopsmedicrole = 1;
      var_2[0] = &"_encstr_AD472695697F17A84FCDDF79D80425E6E609F88E015750AF1D61993FAE7F49F531A5E5D078151F7F";
      var_2[1] = &"_encstr_974726354CF923A9F1DB070FBB8C704BF154FA1547C1F78059F1374785A02895493C27471C09AFEF";
      break;
    case 9:
      scripts\mp\tac_ops\radio_utility::queue_dialogue("_encstr_8DC81C49F8A9104FFB99497362FF90A0FD74C31F8A01E8980712A0F96AEB", var_1);
      var_1 scripts\mp\supers::givesuper("_encstr_8C24146BF367F7FA919919E3571042D78D6BF3C3593D");
      var_1 scripts\mp\supers::givesuperpoints(400000);
      var_1.pers["_encstr_A93B0E3BF7C699BA1B13775FA57BA06B"] = "_encstr_8C24146BF367F7FA919919E3571042D78D6BF3C3593D";
      var_2[0] = &"_encstr_B88D29DCE03FCE913525FFF709EF198E67D8F70899F718A99D34D3F762C5997DBFF04C8DD01B5DF122CF0B";
      var_2[1] = &"_encstr_8E8D290FAB9E346F418DCAC22539BDD9704B830E0928892931B470D9BFA18CF028E373379BC090E5E9BEA2";
      break;
  }

  var_1 thread describerole(var_2);
  var_1 disabletacopskitstationuse();
  var_0 delete();
}

givestealthperks() {
  self.tacopsstealthrole = 1;
  scripts\mp\utility\perk::giveperk("_encstr_876B16B9C1B2D8B40BB1A35EBEB1DED88C9863DEDE469532");
  scripts\mp\utility\perk::giveperk("_encstr_A97E1950E1284F5BE2D1630BF78B3BDF7E0AA713C1FDC285A81598");
  scripts\mp\utility\perk::giveperk("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7");
  scripts\mp\utility\perk::giveperk("_encstr_9B63139B09C036574770439BFEAD93EF088D051565");
  scripts\mp\utility\perk::giveperk("_encstr_990810B8796F28FB0B6193B21770B42573B3");
}

describerole(var_0) {
  foreach(var_2 in var_0) {
    _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::tutorialprint(var_2, 5);
    wait 0.5;
  }
}

disabletacopskitstationuse() {
  for(var_0 = 0; var_0 < level.tacopsstations.size; var_0++) {
    if(isDefined(level.tacopsstations[var_0]))
      level.tacopsstations[var_0] disableplayeruse(self);
  }

  var_1 = level.tacopskitobjectives[self.team];

  for(var_0 = 0; var_0 < var_1.size; var_0++) {
    if(isDefined(var_1[var_0]))
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1[var_0], self);
  }
}

createkitobjective(var_0, var_1) {
  var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(10);

  if(var_2 == -1)
    return -1;

  scripts\mp\objidpoolmanager::objective_add_objective(var_2, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0), var_0);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_2, self);
  scripts\mp\objidpoolmanager::update_objective_state(var_2, "_encstr_930B07BB1B6B3854FF");
  scripts\mp\objidpoolmanager::update_objective_icon(var_2, var_0);

  if(isDefined(level.objvisall))
    [[level.objvisall]](var_2);

  if(!isDefined(level.tacopskitobjectives)) {
    level.tacopskitobjectives = [];
    level.tacopskitobjectives["_encstr_9A8507BA4040188D08"] = [];
    level.tacopskitobjectives["_encstr_8E8405EA382B2A"] = [];
  }

  level.tacopskitobjectives[var_1][level.tacopskitobjectives[var_1].size] = var_2;
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_2);

  foreach(var_4 in level.players) {
    if(isDefined(var_4.team) && var_4.team == var_1) {
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_2, var_4);
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_2, var_4);
  }

  return var_2;
}

latejointeamkitobjective() {
  if(!isDefined(level.tacopskitobjectives)) {
    return;
  }
  foreach(var_1 in level.tacopskitobjectives[self.team])
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_1, self);

  foreach(var_1 in level.tacopskitobjectives[scripts\mp\utility\game::getotherteam(self.team)[0]])
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1, self);
}

grantspotterkit() {
  thread spotterthink();
}

managespotteromnvars() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.playertoomvarmap = [];
  level.playertoomnvarmap["_encstr_9A8507BA4040188D08"] = [];
  level.playertoomnvarmap["_encstr_8E8405EA382B2A"] = [];
}

listendisconnectspotted() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_9254189BFB9E6345689D54DA9188863A7D0763EF71C82B2C68A1");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  recyclespotted(self);
}

recyclespotted(var_0) {
  var_1 = var_0 getentitynumber();

  if(isDefined(level.playertoomnvarmap["_encstr_9A8507BA4040188D08"][var_1])) {
    var_2 = level.playertoomnvarmap["_encstr_9A8507BA4040188D08"][var_1];
    level.playertoomnvarmap["_encstr_9A8507BA4040188D08"][var_1] = undefined;
    level.teamspotindices["_encstr_9A8507BA4040188D08"][level.teamspotindices["_encstr_9A8507BA4040188D08"].size] = var_2;
  }

  if(isDefined(level.playertoomnvarmap["_encstr_8E8405EA382B2A"][var_1])) {
    var_2 = level.playertoomnvarmap["_encstr_8E8405EA382B2A"][var_1];
    level.playertoomnvarmap["_encstr_8E8405EA382B2A"][var_1] = undefined;
    level.teamspotindices["_encstr_8E8405EA382B2A"][level.teamspotindices["_encstr_8E8405EA382B2A"].size] = var_2;
  }
}

spotplayer(var_0) {
  if(!isDefined(var_0.tacopsspottedbyteam)) {
    var_0 thread spotexpire();
    var_0.tacopsspottedbyteam = scripts\mp\utility\game::getotherteam(var_0.team)[0];
    var_1 = scripts\mp\utility\teams::getteamdata(scripts\mp\utility\game::getotherteam(var_0.team)[0], "_encstr_9775086022BE1B413B8B");

    foreach(var_3 in var_1) {}
  } else
    refreshspottimer(var_0);
}

spotexpire() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_9AB013FEAD53831B0A5A1970F325E1FEF35989FD12");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD75063D571AE108", 3);
  unspotplayer(self);
}

refreshspottimer(var_0) {
  var_0 notify("_encstr_9AB013FEAD53831B0A5A1970F325E1FEF35989FD12");
  var_0 thread spotexpire();
}

unspotplayer(var_0) {
  if(!isDefined(var_0.tacopsspottedbyteam)) {
    return;
  }
  var_1 = level.playertoomnvarmap[scripts\mp\utility\game::getotherteam(var_0.tacopsspottedbyteam)[0]];
  var_2 = scripts\mp\utility\teams::getteamdata(var_0.tacopsspottedbyteam, "_encstr_9775086022BE1B413B8B");
  var_0.tacopsspottedbyteam = undefined;

  foreach(var_4 in var_2) {}
}

hackspottest(var_0) {
  wait 5;

  if(isbot(var_0) == 0)
    var_0 thread spotterthink();
}

spotterthink() {
  for(;;) {
    var_0 = scripts\mp\utility\teams::getteamdata(scripts\mp\utility\game::getotherteam(self.team)[0], "_encstr_9775086022BE1B413B8B");

    foreach(var_2 in var_0) {
      if(!isDefined(var_2) || var_2 == self || !scripts\mp\utility\player::isreallyalive(var_2) || istrue(var_2.tacopsstealthrole)) {
        continue;
      }
      if(distancesquared(self getEye(), var_2 getEye()) < 7290000) {
        if(sighttracepassed(self getEye(), var_2 getEye(), 0, self))
          spotplayer(var_2);
      }
    }

    wait 0.333;
  }
}

throwsupplypack(var_0) {
  if(!isDefined(level.tacopssupplypacks))
    level.tacopssupplypacks = [];

  if(!isDefined(level.tacopssupplypacks[var_0.owner.team]))
    level.tacopssupplypacks[var_0.owner.team] = [];

  var_1 = level.tacopssupplypacks[var_0.owner.team].size;

  if(var_1 >= 4) {
    var_2 = level.tacopssupplypacks[var_0.owner.team][0];
    level.tacopssupplypacks[var_0.owner.team] = scripts\engine\utility::array_remove_index(level.tacopssupplypacks[var_0.owner.team], 0);
    var_2 dovisualdeath();
  }

  var_0.team = var_0.owner.team;
  var_0.throwangles2d = (var_0.angles[0], var_0.angles[1], 0);
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  var_3 = createsupplypack(self, var_0.origin);
  var_1 = level.tacopssupplypacks[var_3.owner.team].size;
  level.tacopssupplypacks[var_0.owner.team][var_1] = var_3;
  var_0 delete();
}

dovisualdeath() {
  self delete();
}

supplypackmonitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  dovisualdeath();
}

beginusegas() {
  return 1;
}

beginusesupplypack() {
  self giveandfireoffhand("_encstr_8DAF1F47B036EBEDC16EEBB9AB381C1B2FBEC1856CDAFA763959CDC246CAEBB583");
  return 1;
}

createsupplypack(var_0, var_1) {
  var_2 = "_encstr_BE8F0A272F9B2BE97268AE8B";
  var_3 = 20;
  var_4 = 20;
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1 + (0, 0, 10));
  var_6 = "_encstr_8F33173DD2DB5B8BEDEF73C81F2AE1A7633A2F31A8111591CF";
  var_5 scriptmoverthermal();
  var_5 setModel(var_6);
  var_5.owner = var_0;
  var_5.team = var_0.team;
  var_5.type = var_2;
  var_7 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_1, 0, var_3, var_4);
  var_7 thread watchsupplypackuse(var_5);
  var_7 thread watchsupplypackdeath(var_5);
  return var_5;
}

watchsupplypackdeath(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(self))
    self delete();
}

watchsupplypackuse(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(!isPlayer(var_1) || !isalive(var_1)) {
      continue;
    }
    level.tacopssupplypacks[var_0.team] = scripts\engine\utility::array_remove(level.tacopssupplypacks[var_0.team], var_0);
    var_1.health = var_1.maxhealth;
    scripts\mp\weapons::scavengergiveammo(var_1);
    var_1 playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");
    var_0 delete();
  }
}

granthelicopterpilot() {
  scripts\mp\supers::givesuper("_encstr_ACA512FBBB41391E99BB490F10996710E1EBF0D2", 1);
}

usehelicopterpilot() {
  return 1;
}

useartilleryrole() {
  return 1;
}

useturretrole() {
  return 1;
}

watchturretdeployfailed(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88F514D6A51BE4DE51BAC92759A3EBDC3858DD73CA91");
  self endon("_encstr_B1011095E0D0BA3295537B636BAD79E573E9");
  self waittill("_encstr_AC2211699ABD80F7214B2B09430ABBE945B5B1", var_1, var_2, var_3, var_4);
  scripts\mp\supers::givesuperpoints(400000);
}

useuavrole() {
  return 1;
}

usejuggernautrole() {
  thread _encstr_BAAC1D1BAE0A3047C347CF43635E04C8BD8763D21245A8D06AC741FD27E35E::givejuggernaut();
  return 1;
}