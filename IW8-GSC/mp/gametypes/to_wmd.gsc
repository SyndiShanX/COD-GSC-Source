/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\to_wmd.gsc
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
  level.startedfromtacops = 1;
  onstartgametype(1);
}

maintacopsinit() {
  level.tacopssublevel = "_encstr_BE60077B87404CE718";
  level.currentmode = "_encstr_BE60077B87404CE718";
  setomnvar("_encstr_87DF1357967DD158C6D7ED1CE67DE6AB31D67B4659", level.currentmode);
}

maintacopspostinit() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("_encstr_BE60077B87404CE718", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("_encstr_BE60077B87404CE718", 10);
    scripts\mp\utility\game::registerscorelimitdvar("_encstr_BE60077B87404CE718", 65);
    scripts\mp\utility\game::registerroundlimitdvar("_encstr_BE60077B87404CE718", 1);
    scripts\mp\utility\game::registerwinlimitdvar("_encstr_BE60077B87404CE718", 1);
    scripts\mp\utility\game::registernumlivesdvar("_encstr_BE60077B87404CE718", 0);
    scripts\mp\utility\game::registerhalftimedvar("_encstr_BE60077B87404CE718", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("_encstr_BE60077B87404CE718", 0);
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
  setdynamicdvar("_encstr_B20E1C47B032C92317F113999568A4B2BB39EA8B9093093445D7C729587B", 5);
  setdynamicdvar("_encstr_BD2A1AFA49B07F2AA0CD937F195872B668D3BAC7C36107B20CFBDB4F", getmatchrulesdata("_encstr_99F0096CEDB93344858E0B", "_encstr_A757117208D3F254D23987DB050FE6379A626A"));
  setdynamicdvar("_encstr_A797176606FB67B9BF73F04173C7B04DC3AA4FE5DA70EBC081", getmatchrulesdata("_encstr_99F0096CEDB93344858E0B", "_encstr_86030E3B80D06E43EF274F8205FBDA31"));
  setdynamicdvar("_encstr_887D12CDB1E47D1BB773CCF58685D899A396AD2B", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_959105B99040BD", 0);
  setdynamicdvar("_encstr_844411E78F23A8107F8DD1CE324A38F9AAFBB3", 0);
}

onstartgametype(var_0) {
  level.extratime = 0;
  setgameendtime(0);
  scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", 6);
  var_1[0] = "_encstr_B60703EACA";
  var_1[1] = "_encstr_844E0C99C3A166200DFE2298E5ED";
  var_1[2] = "_encstr_A65908C41BED1BD62B4E";
  var_1[3] = "_encstr_A7290676E4D2378C";
  var_1[4] = "_encstr_8218041DF5FA";
  var_1[5] = "_encstr_959105B99040BD";
  scripts\mp\gameobjects::main(var_1);

  if(!istrue(var_0)) {
    _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::commoninit();
    activatespawns();
  }
}

initspawns() {
  var_0 = level.tacopsspawns;
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A2F016B3AB9955080F2509664AD0A00C22AF2329B38295A0", 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_962E146B07EBE8F6EEDA19F56E1C0BDD377D8587D2CD", 1);
  var_0.to_wmd_spawns = [];
  var_0.to_wmd_spawns["_encstr_9A8507BA4040188D08"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A2F016B3AB9955080F2509664AD0A00C22AF2329B38295A0");
  var_0.to_wmd_spawns["_encstr_8E8405EA382B2A"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_962E146B07EBE8F6EEDA19F56E1C0BDD377D8587D2CD");

  if(var_0.to_wmd_spawns["_encstr_9A8507BA4040188D08"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_839D1687D1804A5A58D00BD96B789193E0773F1B41332213");
    var_0.to_wmd_spawns["_encstr_9A8507BA4040188D08"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_839D1687D1804A5A58D00BD96B789193E0773F1B41332213");
  }

  if(var_0.to_wmd_spawns["_encstr_8E8405EA382B2A"].size <= 0) {
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_9B3B1429826955DBFF332081BF1871BFA2E1972B5CC3");
    var_0.to_wmd_spawns["_encstr_8E8405EA382B2A"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_9B3B1429826955DBFF332081BF1871BFA2E1972B5CC3");
  }
}

getspawnpoint() {
  var_0 = level.tacopsspawns;
  var_1 = self.pers["_encstr_8AEF05472BC2D6"];
  var_2 = scripts\mp\tac_ops_map::filterspawnpoints(var_0.to_wmd_spawns[var_1]);
  var_3 = undefined;
  return var_3;
}

activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_A11904A822A6");
  scripts\mp\tac_ops_map::setactivemapconfig("_encstr_BE60077B87404CE718", "_encstr_9A8507BA4040188D08");
  scripts\mp\tac_ops_map::setactivemapconfig("_encstr_BE60077B87404CE718", "_encstr_8E8405EA382B2A");
  level.getspawnpoint = ::getspawnpoint;
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4);
}

onspawnplayer() {
  var_0 = 0;

  if(self.team == "_encstr_9A8507BA4040188D08")
    var_0 = 1;
  else if(self.team == "_encstr_8E8405EA382B2A")
    var_0 = 2;

  self setclientomnvar("_encstr_8C460FD55A7D8E16D8DB83B9FAD15616DA", var_0);
}