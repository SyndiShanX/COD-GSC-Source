/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\to_blitz.gsc
***********************************************/

main() {
  maintacopsinit();
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();

  if(isusingmatchrulesdata())
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();

  maintacopspostinit();
  level.startedfromtacops = 0;
  level.onstartgametype = ::onstartgametype;
}

maintacops() {
  maintacopsinit();
  maintacopspostinit();
  level.waypointcolors["_encstr_BEC116582930AAEF8732DB6FC8EBE1F1938B273EC856B7EA"] = "_encstr_A7A408B9CA5D1D4E2C63";
  level.waypointbgtype["_encstr_BEC116582930AAEF8732DB6FC8EBE1F1938B273EC856B7EA"] = 2;
  level.startedfromtacops = 1;
  onstartgametype(1);
}

maintacopsinit() {
  level.tacopssublevel = "_encstr_9B61099C371176434373A3";
  level.currentmode = "_encstr_9B61099C371176434373A3";
  setomnvar("_encstr_87DF1357967DD158C6D7ED1CE67DE6AB31D67B4659", level.currentmode);
}

maintacopspostinit() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("_encstr_9B61099C371176434373A3", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("_encstr_9B61099C371176434373A3", 10);
    scripts\mp\utility\game::registerscorelimitdvar("_encstr_9B61099C371176434373A3", 65);
    scripts\mp\utility\game::registerroundlimitdvar("_encstr_9B61099C371176434373A3", 1);
    scripts\mp\utility\game::registerwinlimitdvar("_encstr_9B61099C371176434373A3", 1);
    scripts\mp\utility\game::registernumlivesdvar("_encstr_9B61099C371176434373A3", 0);
    scripts\mp\utility\game::registerhalftimedvar("_encstr_9B61099C371176434373A3", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("_encstr_9B61099C371176434373A3", 0);
    level.matchrules_damagemultiplier = 0;
  }

  updategametypedvars();
  level.teambased = 1;
  level.onnormaldeath = ::onnormaldeath;
  level.modeonspawnplayer = ::onspawnplayer;
  level.ontimelimit = scripts\mp\gamelogic::default_ontimelimit;
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_A5B71EFBDEDD08E9E2478019336BCAF1CB22663BCB1FE3AB47F355317A7DD0B8", 5);
  setdynamicdvar("_encstr_A39422F79F72E924BACFDA8D7B53D3315728ED2B6EF81FC3F61BBDA1AF2DA9D0BFDB09DB", 10);
  setdynamicdvar("_encstr_BD2A1AFA49B07F2AA0CD937F195872B668D3BAC7C36107B20CFBDB4F", getmatchrulesdata("_encstr_99F0096CEDB93344858E0B", "_encstr_A757117208D3F254D23987DB050FE6379A626A"));
  setdynamicdvar("_encstr_A797176606FB67B9BF73F04173C7B04DC3AA4FE5DA70EBC081", getmatchrulesdata("_encstr_99F0096CEDB93344858E0B", "_encstr_86030E3B80D06E43EF274F8205FBDA31"));
  setdynamicdvar("_encstr_887D12CDB1E47D1BB773CCF58685D899A396AD2B", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_959105B99040BD", 0);
  setdynamicdvar("_encstr_844411E78F23A8107F8DD1CE324A38F9AAFBB3", 0);
}

onstartgametype(var_0) {
  var_1[0] = "_encstr_B60703EACA";
  var_1[1] = "_encstr_844E0C99C3A166200DFE2298E5ED";
  var_1[2] = "_encstr_A65908C41BED1BD62B4E";
  var_1[3] = "_encstr_A7290676E4D2378C";
  var_1[4] = "_encstr_8218041DF5FA";
  var_1[5] = "_encstr_959105B99040BD";
  var_1[6] = "_encstr_BA2013BE09B0528AA5F5778F295DD2B34850F40503";
  scripts\mp\gameobjects::main(var_1);

  if(!istrue(var_0)) {
    _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::commoninit();
    activatespawns();
  }

  level.extratime = 0;
  setgameendtime(0);
  scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", 6);
  seticonnames();
  level.bradleymodeloverride = 1;
  level.to_blitzactivebradleys = 2;
  thread setupbradleys();
  thread setuprpgcaches();
  thread setupbarriers();
  thread setuptankendgoal();
}

setupbradleys() {
  level.tankobjkeys = [];
  var_0 = scripts\engine\utility::getStructArray("_encstr_AB530B8E5873DAFAE6E016779B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = 0;

  foreach(var_3 in var_0) {}

  thread initobjicons();
  setomnvar("_encstr_BA7F2018D07FC39BE835538ECFB888BDA7EFC9BF61351EB9FB4317C0CF7E3E75ADA3", 1.0);
  setomnvar("_encstr_8C5920AE2DD7A3858D7B07DCD78E1673D6D789BE86CA85D81D34AFE0CA276C599BD1", 1.0);
}

bradleydamagewatcher() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0);

    if(self.tacopsindex == 0) {
      setomnvar("_encstr_BA7F2018D07FC39BE835538ECFB888BDA7EFC9BF61351EB9FB4317C0CF7E3E75ADA3", (self.maxhealth - self.damagetaken) / self.maxhealth);
      continue;
    }

    if(self.tacopsindex == 1)
      setomnvar("_encstr_8C5920AE2DD7A3858D7B07DCD78E1673D6D789BE86CA85D81D34AFE0CA276C599BD1", (self.maxhealth - self.damagetaken) / self.maxhealth);
  }
}

setuptankendgoal() {
  level waittill("_encstr_81520C77478FF92777A3C966751B");
  var_0 = getEnt("_encstr_996D0AAB2A7DB301AF40C8F1", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0))
    spawnmanualdomflag();
  else {
    level.objectives = [];
    level.objectives[0] = var_0;
    var_1 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(level.objectives[0]);
    var_1.onuse = ::dompoint_onuse;
    level.objectives[0] = var_1;
    level.flagcapturetime = 1;
    level.flagneutralization = 1;
    waitframe();
    var_1.nocarryobject = 1;
    var_1 scripts\mp\gameobjects::setkeyobject(level.tankobjkeys);
    var_1 scripts\mp\gameobjects::setownerteam("_encstr_8E8405EA382B2A");
    var_1 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_1 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    var_1 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  }
}

bradley_handletacopsdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(var_3 == "_encstr_8DED0A21C79B660BC7588981")
    return 0;

  if(var_1.team == "_encstr_9A8507BA4040188D08")
    return 0;

  var_4 = getmodifiedtankdamage(var_1, var_2, var_3, var_4, 3000, 10, 15, 20);
  var_0.damage = var_4;
  return var_4;
}

getmodifiedtankdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;

  if(var_2 != "_encstr_8DED0A21C79B660BC7588981") {
    switch (var_1.basename) {
      case "_encstr_B6B314378945F0ED77FACB1372672D69DF1589E7252A":
      case "_encstr_9AAE0876FCB7603101DB":
      case "_encstr_873910FA8BA0453BB8F9C3BF19DB7387A0B3":
        self.largeprojectiledamage = 1;
        var_9 = var_5;
        break;
      case "_encstr_AA49167445B3876E15E0A21AF83B69638926E708DEBEF732":
      case "_encstr_935E169BDD961D6C1AFA318D2C1995BE8D34B46319D76BE0":
      case "_encstr_BE541946E4DEB9B2F5A1A5CEACAF0727BDD4CA8D3AD236B2F5DAC1":
      case "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8":
      case "_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E":
      case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
      case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
      case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
        self.largeprojectiledamage = 1;
        var_9 = var_6;
        break;
      case "_encstr_B2431993782C0F025963C8C819B0CF47D811F95A6388EB3F814BD8":
      case "_encstr_998D1868A26D11B3E757B6234FA758FF15CAF0E01A857B2E6F80":
      case "_encstr_AFBB119A85B1DA0BD87DC6169B9BEDDCD7DAC1":
      case "_encstr_A9DA131AB0E9F962F81B8FBF90D63873BF5AA9D5A7":
      case "_encstr_A2950D16C9E8D2361B59932FF55BC1":
        self.largeprojectiledamage = 0;
        var_9 = var_7;
        break;
      default:
        self.largeprojectiledamage = 0;
    }
  }

  if(isDefined(var_8))
    self.largeprojectiledamage = var_8;

  if(self.largeprojectiledamage == 0)
    return 0;

  if(isDefined(var_9) && isDefined(var_2) && (var_2 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_2 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" || var_2 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_2 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_2 == "_encstr_911B0C7DA090E9A7F799FD50DD48"))
    var_3 = ceil(var_4 / var_9);

  if(isDefined(var_0) && isDefined(self.owner)) {
    if(isDefined(var_0.owner))
      var_0 = var_0.owner;

    if(var_0 == self.owner)
      var_3 = ceil(var_3 / 2);
  }

  return int(var_3);
}

bradley_handlefataltacopsdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;

  if(level.teambased) {
    var_6 = "_encstr_B40101";

    if(isDefined(var_1) && isDefined(var_1.team))
      var_6 = var_1.team;

    if(var_6 != self.team) {}
  } else if(isDefined(var_1) && (!isDefined(self.owner) || self.owner != var_1)) {}

  self.trackedobject scripts\mp\gameobjects::deletetrackedobject();
  thread bradley_vehicledestroy(var_1, var_2, var_3, 0);

  if(self.tacopsindex == 0)
    setomnvar("_encstr_BA7F2018D07FC39BE835538ECFB888BDA7EFC9BF61351EB9FB4317C0CF7E3E75ADA3", 0);
  else if(self.tacopsindex == 1)
    setomnvar("_encstr_8C5920AE2DD7A3858D7B07DCD78E1673D6D789BE86CA85D81D34AFE0CA276C599BD1", 0);
}

bradley_vehicledestroy(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.attacker = var_0;
  var_4.objweapon = var_1;
  var_4.meansofdeath = var_2;
  scripts\cp_mp\vehicles\light_tank::light_tank_explode(var_4, var_3);
  level.to_blitzactivebradleys--;

  if(level.to_blitzactivebradleys == 0) {
    if(isDefined(level.onphaseend)) {
      game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
      game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
      [[level.onphaseend]]("_encstr_8E8405EA382B2A");
    } else
      thread scripts\mp\gamelogic::endgame("_encstr_8E8405EA382B2A", game["_encstr_99EA0B72AB022F6ED1CF9FC248"][game["_encstr_991C0AB9ED5B57161FE89B83"] + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
  }
}

initspawns() {
  var_0 = level.tacopsspawns;
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_877118839BA965180A7558F318CF9B9FA21F0D5F77C22160258A", 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_B10F16D61CEBE87B31364B8EE9FACDC158BBB97D0B0F5AB9", 1);
  var_0.to_blitz_spawns = [];
  var_0.to_blitz_spawns["_encstr_9A8507BA4040188D08"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_877118839BA965180A7558F318CF9B9FA21F0D5F77C22160258A");
  var_0.to_blitz_spawns["_encstr_8E8405EA382B2A"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_B10F16D61CEBE87B31364B8EE9FACDC158BBB97D0B0F5AB9");

  if(var_0.to_blitz_spawns["_encstr_9A8507BA4040188D08"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_839D1687D1804A5A58D00BD96B789193E0773F1B41332213");
    var_0.to_blitz_spawns["_encstr_9A8507BA4040188D08"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_839D1687D1804A5A58D00BD96B789193E0773F1B41332213");
  }

  if(var_0.to_blitz_spawns["_encstr_8E8405EA382B2A"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_9B3B1429826955DBFF332081BF1871BFA2E1972B5CC3");
    var_0.to_blitz_spawns["_encstr_8E8405EA382B2A"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_9B3B1429826955DBFF332081BF1871BFA2E1972B5CC3");
  }
}

getspawnpoint() {
  var_0 = level.tacopsspawns;
  var_1 = self.pers["_encstr_8AEF05472BC2D6"];
  var_2 = scripts\mp\tac_ops_map::filterspawnpoints(var_0.to_blitz_spawns[var_1]);
  var_3 = undefined;
  return var_3;
}

activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_A11904A822A6");
  scripts\mp\tac_ops_map::setactivemapconfig("_encstr_9B61099C371176434373A3", "_encstr_9A8507BA4040188D08");
  scripts\mp\tac_ops_map::setactivemapconfig("_encstr_9B61099C371176434373A3", "_encstr_8E8405EA382B2A");
  level.getspawnpoint = ::getspawnpoint;
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4);
}

onspawnplayer() {
  if(self.team == "_encstr_8E8405EA382B2A")
    thread onspawnfinished();

  var_0 = 0;

  if(self.team == "_encstr_9A8507BA4040188D08")
    var_0 = 1;
  else if(self.team == "_encstr_8E8405EA382B2A")
    var_0 = 2;

  self setclientomnvar("_encstr_8C460FD55A7D8E16D8DB83B9FAD15616DA", var_0);
  scripts\mp\tac_ops\roles_utility::kitspawn();
}

onspawnfinished() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");
  scripts\mp\equipment::giveequipment("_encstr_843D095F2B7D52B041D9A3", "_encstr_BA7F0830B3A7859B60B0");
  var_0 = self getweaponslist("_encstr_BA7F0830B3A7859B60B0");

  foreach(var_2 in var_0) {
    var_3 = getweaponbasename(var_2);

    switch (var_3) {
      case "_encstr_9A3910F3CC9269453ED1A23FE89B402F3DB3":
      case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
        var_4 = getcompleteweaponname("_encstr_82B914182358E753C737D5CEE91FDB45F6FF62213AE2");
        scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe(var_2);
        self giveweapon(var_4);
        self givestartammo(var_4);
        break;
    }
  }
}

setuprpgcaches() {
  level.rpg7caches = [];
  var_0 = getEntArray("_encstr_93010A6B2049F79A7306A49F", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_84BE1048DB075F4B279558C57AB7F1E76F63", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0[var_2].origin);
    var_3 setModel("_encstr_B42F1747A6A825CFF02B4058A21012F8B72FA2A9DC8D0F3D7F");
    var_3.angles = var_0[var_2].angles;
    var_0[var_2] scripts\mp\utility\outline::outlineenableforteam(var_0[var_2], "_encstr_8E8405EA382B2A", "_encstr_9ABD15C87B5C489BD2AFFF95EF1AD5F0F49476C1E0B190", "_encstr_A7440781BA73D7D8C1");
    var_0[var_2].ownerteam = "_encstr_8E8405EA382B2A";
    var_0[var_2].interactteam = "_encstr_ACFC091AE8AB2FCBE15119";
    var_0[var_2].exclusiveuse = 0;
    var_0[var_2].curprogress = 0;
    var_0[var_2].usetime = 0;
    var_0[var_2].userate = 1;
    var_0[var_2].id = "_encstr_BAE50DE60E739BA638C72068AF47B9";
    var_0[var_2].skiptouching = 1;
    var_0[var_2].trigger = var_1[var_2];
    var_0[var_2].trigger.angles = var_0[var_2].angles;
    var_0[var_2].trigger setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
    var_0[var_2].trigger setHintString(&"_encstr_A5470F0D49FF42B1192CA349498331C9FF");
    var_0[var_2].trigger.team = "_encstr_8E8405EA382B2A";
    var_0[var_2].trigger.destination = var_0[var_2].origin;
    var_0[var_2].onuse = ::rpgcrateenduse;
    var_0[var_2] thread scripts\mp\gameobjects::useobjectusethink();
    var_0[var_2] thread rpgcrateuseteamupdater("_encstr_8E8405EA382B2A");
    level.rpg7caches[level.rpg7caches.size] = var_0[var_2];
  }
}

rpgcrateenduse(var_0) {
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0.01);
  var_1 = var_0.lastdroppableweaponobj;
  var_2 = var_0 dropitem(var_1);

  if(isDefined(var_2)) {
    var_2.owner = var_0;
    var_2.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
    var_2 thread scripts\mp\weapons::watchpickup(var_0);
    var_2 thread scripts\mp\weapons::deletepickupafterawhile();
  }

  var_0 giveweapon("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8");
  var_0 givestartammo("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8");
  var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8", 1);
  var_0 scripts\mp\weapons::_id_1316B(getcompleteweaponname("_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8"));
}

rpgcrateuseteamupdater(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    setusablebyteam(var_0);
    level waittill("_encstr_81170C244F9CBDE72C01BB99A298");
  }
}

setusablebyteam(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.team != var_0) {
      self.trigger disableplayeruse(var_2);
      continue;
    }

    self.trigger enableplayeruse(var_2);
  }
}

initobjicons() {
  foreach(var_1 in level.bradley.activevehicles["_encstr_9A8507BA4040188D08"]) {
    var_1.trackedobject = var_1 scripts\mp\gameobjects::createtrackedobject(var_1, (0, 0, 0));
    var_1.trackedobject.objidpingfriendly = 0;
    var_1.trackedobject.objidpingenemy = 1;
    var_1.trackedobject.objpingdelay = 0.05;
    var_1.trackedobject.visibleteam = "_encstr_9A19040BCDBC";
    var_1.invulnerable = 1;
    var_1.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontake, level.iconkill);
    var_1 thread watchiconupdater();
  }
}

watchiconupdater() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    scripts\engine\utility::_id_143A6("_encstr_923015C3ADF7022C101AF93F53587EAAD64B135373A5DA", "_encstr_AD75063D571AE108", "_encstr_93FE140AB8EB3F93B1AB4F7E4DF84F0609E8E023D869");
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self, "_encstr_9AE307B956E345D0AB");

    if(isDefined(var_0) && isDefined(self.trackedobject.visibleteam)) {
      self.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconkill);
      continue;
    }

    if(isDefined(self.trackedobject.visibleteam))
      self.trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icontake, level.iconkill);
  }
}

seticonnames() {
  level.waypointcolors["_encstr_BEC116582930AAEF8732DB6FC8EBE1F1938B273EC856B7EA"] = "_encstr_A7A408B9CA5D1D4E2C63";
  level.waypointbgtype["_encstr_BEC116582930AAEF8732DB6FC8EBE1F1938B273EC856B7EA"] = 2;
  level.icontake = "_encstr_BEC116582930AAEF8732DB6FC8EBE1F1938B273EC856B7EA";
  level.iconkill = "_encstr_82FD166339ABDBC568F5446787404AB3D533DA69C00B63FD";
  level.iconneutral = "_encstr_96730D2FF80BE0794D25C3BB967B02";
  level.iconcapture = "_encstr_AF120B78D23BF9C6A7568DF129";
  level.icondefend = "_encstr_AA5E0EFB38032B514DE8E23A109155A7";
  level.iconcontested = "_encstr_A6C21D1FA7E70AAF8B30C529326FF8C477B827133CBEBAAF085B630BFB4345";
  level.icontaking = "_encstr_BD4218BB162FC1EDD2E6E8FAD158ADB4E6D9AF6CA1B2D9C9BDB9";
  level.iconlosing = "_encstr_A3471A8421A74B9714B2F899EA2E65015BC703F0AC9770CFFAAA2050";
}

setupbarriers() {
  var_0 = getEntArray("_encstr_BA2013BE09B0528AA5F5778F295DD2B34850F40503", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0) {
    var_2 setCanDamage(1);
    var_2.health = 10000;
    var_2.team = "_encstr_8E8405EA382B2A";
    var_2 thread barriermonitordamage();
    var_2 thread barriermonitordeath();
  }

  level.totalbarriers = var_0.size;
}

barriermonitordamage() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0);
    iprintln("_encstr_A5900E81810C6A12381063F9BB383BC1" + var_0 + "_encstr_A39B0F41DA4437900ADB4301906A4D3DB1" + self.health);
  }
}

barriermonitordeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  iprintln("_encstr_A7480A47D3700D9A3D8D3870");
  thread barrier_destroy();
}

barrier_deathfunc(var_0, var_1, var_2, var_3, var_4) {
  if(level.teambased) {
    var_5 = "_encstr_B40101";

    if(isDefined(var_0) && isDefined(var_0.team))
      var_5 = var_0.team;

    if(var_5 != self.team) {}
  } else if(isDefined(var_0) && (!isDefined(self.owner) || self.owner != var_0)) {}

  thread barrier_destroy(var_0, var_1, var_2, 0);
}

barrier_destroy(var_0, var_1, var_2, var_3) {
  playFX(level.barrier_explode, self.origin);
  playFX(level.barrier_explode, self.origin + (0, -150, 0));
  playFX(level.barrier_explode, self.origin + (0, 150, 0));
  playFX(level.barrier_explode, self.origin + (150, 0, 0));
  playFX(level.barrier_explode, self.origin + (-150, 0, 0));
  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", self.origin);
  earthquake(0.75, 2.0, self.origin, 2000);
  self delete();
  level.totalbarriers--;

  if(level.totalbarriers == 0)
    level notify("_encstr_81520C77478FF92777A3C966751B");
}

barrier_dmgfunc(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "_encstr_8DED0A21C79B660BC7588981")
    return 0;

  if(var_0.team == self.team)
    return 0;

  var_3 = getmodifiedbarrierdamage(var_0, var_1, var_2, var_3, 10000, 10, 15, 50);
  return var_3;
}

getmodifiedbarrierdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_1.isalternate;
  var_10 = 0;

  if(istrue(var_9)) {
    var_11 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_1);

    foreach(var_13 in var_11) {
      if(var_13 == "_encstr_8A07035972") {
        var_10 = 1;
        break;
      }
    }
  }

  var_15 = undefined;

  if(var_2 != "_encstr_8DED0A21C79B660BC7588981") {
    switch (var_1.basename) {
      case "_encstr_9A3910F3CC9269453ED1A23FE89B402F3DB3":
      case "_encstr_9AAE0876FCB7603101DB":
      case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
      case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
        self.largeprojectiledamage = 1;
        var_15 = var_5;
        break;
      case "_encstr_935E169BDD961D6C1AFA318D2C1995BE8D34B46319D76BE0":
      case "_encstr_BE541946E4DEB9B2F5A1A5CEACAF0727BDD4CA8D3AD236B2F5DAC1":
      case "_encstr_ABFC0FCB7B408FEAFE032B03632361E5F8":
        self.largeprojectiledamage = 1;
        var_15 = var_6;
        break;
      case "_encstr_AFBB119A85B1DA0BD87DC6169B9BEDDCD7DAC1":
      case "_encstr_827E0D809A9733A0E3992D3FBF8D48":
      case "_encstr_A2950D16C9E8D2361B59932FF55BC1":
        self.largeprojectiledamage = 0;
        var_15 = var_7;
        break;
      case "_encstr_BD48113A4334CFEE2807A4B13F78B477A8B823":
        if(istrue(var_10)) {
          self.largeprojectiledamage = 0;
          var_15 = var_7;
        }

        break;
      default:
        var_3 = 0;
        break;
    }
  }

  if(isDefined(var_8))
    self.largeprojectiledamage = var_8;

  if(isDefined(var_15) && isDefined(var_2) && (var_2 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_2 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5" || var_2 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_2 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" || var_2 == "_encstr_911B0C7DA090E9A7F799FD50DD48"))
    var_3 = ceil(var_4 / var_15);

  if(isDefined(var_0) && isDefined(self.owner)) {
    if(isDefined(var_0.owner))
      var_0 = var_0.owner;

    if(var_0 == self.owner)
      var_3 = ceil(var_3 / 2);
  }

  return int(var_3);
}

ontimelimit() {
  if(isDefined(level.onphaseend)) {
    var_0 = scripts\mp\gamescore::freight_lift_door_switch(0);
    [[level.onphaseend]](var_0);
  }

  scripts\mp\gamescore::_setteamscore("_encstr_8E8405EA382B2A", 1, 0);
  thread scripts\mp\gamelogic::endgame("_encstr_8E8405EA382B2A", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
}

spawnmanualdomflag() {
  level.flagcapturetime = 1;
  level.flagneutralization = 1;
  var_0 = spawnStruct();
  var_0.origin = (7524, 11709, 308);
  var_0.angles = (0, 0, 0);
  var_1 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_0.origin, 0, 160, 128);
  var_1.radius = 160;
  var_0.trigger = var_1;
  var_0.trigger.script_label = "_encstr_B40101";
  var_0.ownerteam = "_encstr_A7A408B9CA5D1D4E2C63";
  var_2 = var_0.origin + (0, 0, 32);
  var_3 = var_0.origin + (0, 0, -32);
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, undefined, scripts\engine\trace::create_default_contents(1));
  var_0.origin = var_4["_encstr_BD260953AA97E3F014279D"];
  var_0.upangles = vectortoangles(var_4["_encstr_820E07FAE8780B3A4C"]);
  var_0.forward = anglesToForward(var_0.upangles);
  var_0.right = anglestoright(var_0.upangles);
  var_0.visuals[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_0.visuals[0].angles = var_0.angles;
  var_5 = scripts\mp\gameobjects::createuseobject("_encstr_A7A408B9CA5D1D4E2C63", var_0.trigger, var_0.visuals, (0, 0, 100));
  var_5 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  var_5 scripts\mp\gameobjects::setusetime(1);
  var_5 scripts\mp\gameobjects::setusetext(&"_encstr_838E1511A2461705EBF709D9B3C79EC9A89A9B054CF865");
  var_6 = "_encstr_B40101";
  var_5.label = var_6;
  var_5 scripts\mp\gameobjects::setobjectivestatusicons(level.iconfriendlyextract3d, level.icondefend);
  var_5 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  var_5.onuse = ::dompoint_onuse;
  var_5.onbeginuse = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onusebegin;
  var_5.onuseupdate = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseupdate;
  var_5.onenduse = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend;
  var_5.oncontested = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_oncontested;
  var_5.onuncontested = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuncontested;
  var_5.nousebar = 1;
  var_5.id = "_encstr_87D9083A6F628DDB5F1F";
  var_5.claimgracetime = level.flagcapturetime * 1000;
  var_5.firstcapture = 1;
  var_5 scripts\mp\gameobjects::setkeyobject(level.tankobjkeys);
  var_5.nocarryobject = 1;
  level.objectives = [];
  level.objectives[0] = var_5;
  var_2 = var_0.visuals[0].origin + (0, 0, 32);
  var_3 = var_0.visuals[0].origin + (0, 0, -32);
  var_7 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_8 = [];
  var_4 = scripts\engine\trace::ray_trace(var_2, var_3, var_8, var_7);
  var_5.baseeffectpos = var_4["_encstr_BD260953AA97E3F014279D"];
  var_9 = vectortoangles(var_4["_encstr_820E07FAE8780B3A4C"]);
  var_5.baseeffectforward = anglesToForward(var_9);
  var_10 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_5.baseeffectpos);
  var_10 setModel("_encstr_8B501446DED6F5CC361676BEB96C4E5AE08EB031B159");
  var_10.angles = generateaxisanglesfromforwardvector(var_5.baseeffectforward, var_10.angles);
  var_5.scriptable = var_10;
  var_5.vfxnamemod = "_encstr_B40101";

  if(var_5.trigger.radius == 160)
    var_5.vfxnamemod = "_encstr_AD450587AAD3F1";
  else if(var_5.trigger.radius == 90)
    var_5.vfxnamemod = "_encstr_BE1A04D772C0";
  else if(var_5.trigger.radius == 315)
    var_5.vfxnamemod = "_encstr_A64505BE660C06";

  var_5 scripts\mp\gameobjects::setownerteam("_encstr_8E8405EA382B2A");
  var_5 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  var_5 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
  var_5 scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  var_5 _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_8E8405EA382B2A", 0);
}

dompoint_onuse(var_0) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuse(var_0);

  if(var_0.team == "_encstr_9A8507BA4040188D08") {
    scripts\mp\gamescore::_setteamscore("_encstr_9A8507BA4040188D08", 1, 0);
    thread scripts\mp\gamelogic::endgame("_encstr_9A8507BA4040188D08", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
  }
}