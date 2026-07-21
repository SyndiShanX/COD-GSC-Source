/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\to_air.gsc
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
  level.tacopssublevel = "_encstr_A26007B5FA212B1A83";
  level.currentmode = "_encstr_A26007B5FA212B1A83";
  setomnvar("_encstr_87DF1357967DD158C6D7ED1CE67DE6AB31D67B4659", level.currentmode);
}

maintacopspostinit() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar("_encstr_A26007B5FA212B1A83", 0, 0, 9);
    scripts\mp\utility\game::registertimelimitdvar("_encstr_A26007B5FA212B1A83", 10);
    scripts\mp\utility\game::registerscorelimitdvar("_encstr_A26007B5FA212B1A83", 65);
    scripts\mp\utility\game::registerroundlimitdvar("_encstr_A26007B5FA212B1A83", 1);
    scripts\mp\utility\game::registerwinlimitdvar("_encstr_A26007B5FA212B1A83", 1);
    scripts\mp\utility\game::registernumlivesdvar("_encstr_A26007B5FA212B1A83", 0);
    scripts\mp\utility\game::registerhalftimedvar("_encstr_A26007B5FA212B1A83", 0);
    scripts\mp\utility\game::registerdogtagsenableddvar("_encstr_A26007B5FA212B1A83", 0);
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
  setdynamicdvar("_encstr_A12D1CF8EF12B6B1A299F78BAAD9CF397E6F78F007C8897F9A7FFD014693", 5);
  setdynamicdvar("_encstr_864620CD8D9CBEA3B7FAB04B39AFDD5867B239566E38C2DDE6C8568D85E5D7168DD1", 10);
  setdynamicdvar("_encstr_BD2A1AFA49B07F2AA0CD937F195872B668D3BAC7C36107B20CFBDB4F", getmatchrulesdata("_encstr_99F0096CEDB93344858E0B", "_encstr_A757117208D3F254D23987DB050FE6379A626A"));
  setdynamicdvar("_encstr_A797176606FB67B9BF73F04173C7B04DC3AA4FE5DA70EBC081", getmatchrulesdata("_encstr_99F0096CEDB93344858E0B", "_encstr_86030E3B80D06E43EF274F8205FBDA31"));
  setdynamicdvar("_encstr_887D12CDB1E47D1BB773CCF58685D899A396AD2B", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_959105B99040BD", 0);
  setdynamicdvar("_encstr_844411E78F23A8107F8DD1CE324A38F9AAFBB3", 0);
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.flagneutralization = scripts\mp\utility\dvars::dvarintvalue("_encstr_8D23137298A7878D08C3444A83280C8BDFF31A6A60", 0, 0, 1);
  level.controltoprogress = 1;
}

onstartgametype(var_0) {
  var_1[0] = "_encstr_B60703EACA";
  var_1[1] = "_encstr_844E0C99C3A166200DFE2298E5ED";
  var_1[2] = "_encstr_A65908C41BED1BD62B4E";
  var_1[3] = "_encstr_A7290676E4D2378C";
  var_1[4] = "_encstr_8218041DF5FA";
  var_1[5] = "_encstr_959105B99040BD";
  scripts\mp\gameobjects::main(var_1);
  seticonnames();
  setupairpath();
  thread setupobjectives();

  if(!istrue(var_0)) {
    _encstr_97C0213EEB43A0718BABDAC0B37507F95795C5B350A72B07739280493AFAE7D8A72BC6::commoninit();
    activatespawns();
    level.allowtacopsmapprematch = 1;
  }

  level.extratime = 0;
  setgameendtime(0);
  scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_8B250A53848DC8D17A472BE9", 10);
  updateallowedspawnareas();
}

initspawns() {
  var_0 = level.tacopsspawns;
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_92E51668DA976878C27F05573FFBB7A84EF911C04519A82E");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_AA2614123B5FB3B7019920576B3B37D725DF68B9E363");
  var_0.to_air_spawns = [];
  var_0.to_air_spawns["_encstr_9A8507BA4040188D08"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_92E51668DA976878C27F05573FFBB7A84EF911C04519A82E");
  var_0.to_air_spawns["_encstr_8E8405EA382B2A"] = scripts\mp\spawnlogic::getspawnpointarray("_encstr_AA2614123B5FB3B7019920576B3B37D725DF68B9E363");
}

getspawnpoint() {
  var_0 = level.tacopsspawns;
  var_1 = self.pers["_encstr_8AEF05472BC2D6"];
  var_2 = undefined;
  var_2 = var_0.to_air_spawns[var_1];
  var_2 = scripts\mp\tac_ops_map::filterspawnpoints(var_2);
  var_3 = undefined;

  if(isDefined(self.tacopsmapselectedarea.dynamicent)) {
    var_4 = isDefined(level.escortheli[0]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[0];
    var_5 = isDefined(level.escortheli[1]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[1];
    var_6 = isDefined(level.escortheli[2]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[2];

    if(var_4 || var_5 && level.escortheli[1].spawnoccupied || var_6 && level.escortheli[2].spawnoccupied) {
      var_7 = scripts\engine\utility::player_drop_to_ground(self.tacopsmapselectedarea.dynamicent.origin, 32, 0, -1500, (0, 0, 1));
      self.tacopsmapselectedarea.dynamicent.spawnorigin = var_7;
    } else if(isDefined(level.escortheli[1]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[1]) {
      self.tacopsmapselectedarea.dynamicent.spawnorigin = self.tacopsmapselectedarea.dynamicent.origin;
      level.escortheli[1].owner thread enterattackheli(level.escortheli[1]);
    } else if(isDefined(level.escortheli[2]) && self.tacopsmapselectedarea.dynamicent == level.escortheli[2]) {
      self.tacopsmapselectedarea.dynamicent.spawnorigin = self.tacopsmapselectedarea.dynamicent.origin;
      level.escortheli[2].owner thread enterattackheli(level.escortheli[2]);
    }

    var_8 = anglesToForward(self.tacopsmapselectedarea.dynamicent.angles);
    var_8 = var_8 * (1, 1, 0);
    var_9 = (0, 0, 1);
    var_10 = vectorcross(var_8, var_9);
    var_11 = axistoangles(var_8, var_10, var_9);
    self.tacopsmapselectedarea.dynamicent.spawnangles = var_11;
  } else {}

  return var_3;
}

activatespawns() {
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_A11904A822A6");
  scripts\mp\tac_ops_map::setactivemapconfig("_encstr_A26007B5FA212B1A83", "_encstr_9A8507BA4040188D08");
  scripts\mp\tac_ops_map::setactivemapconfig("_encstr_A26007B5FA212B1A83", "_encstr_8E8405EA382B2A");
  level.getspawnpoint = ::getspawnpoint;
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4);
}

onspawnplayer() {
  var_0 = 0;

  if(self.team == "_encstr_9A8507BA4040188D08") {
    var_0 = 1;

    if(!istrue(level.spawnedescortchopper)) {
      level.spawnedescortchopper = 1;
      thread setupheliobjective();
    }
  } else if(self.team == "_encstr_8E8405EA382B2A")
    var_0 = 2;

  self setclientomnvar("_encstr_8C460FD55A7D8E16D8DB83B9FAD15616DA", var_0);
  scripts\mp\tac_ops\roles_utility::kitspawn();
}

seticonnames() {
  level.icontarget = "_encstr_8F511ABB16F2E0DE969B8E7D43584E19E0DB2DCD3AFA8EB039CE95A3";
  level.iconneutral = "_encstr_96730D2FF80BE0794D25C3BB967B02";
  level.iconcapture = "_encstr_AF120B78D23BF9C6A7568DF129";
  level.icondefend = "_encstr_AA5E0EFB38032B514DE8E23A109155A7";
  level.iconcontested = "_encstr_A6C21D1FA7E70AAF8B30C529326FF8C477B827133CBEBAAF085B630BFB4345";
  level.icontaking = "_encstr_BD4218BB162FC1EDD2E6E8FAD158ADB4E6D9AF6CA1B2D9C9BDB9";
  level.iconlosing = "_encstr_A3471A8421A74B9714B2F899EA2E65015BC703F0AC9770CFFAAA2050";
  level.iconbombcapture = "_encstr_8F361077FED381AD0833C589FCA8DA67776B";
  level.iconbombdefend = "_encstr_994B105B20DB3A9F30206457CD5973870DE0";
}

setupairpath() {
  level.airpathnodes = [];
  constructhelipath(0, "_encstr_82960B87DC2031BBF86399A1DB");
  constructhelipath(1, "_encstr_92960B16B439AF0E85471AD713");
  constructhelipath(2, "_encstr_BE960BE3870388A8512B30AEC2");
}

constructhelipath(var_0, var_1) {
  var_2 = getEnt(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_2) && isDefined(var_2.target)) {
    var_3 = getEntArray(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_3) && var_3.size > 0) {
      level.airpathnodes[var_0] = [];

      foreach(var_5 in var_3) {
        var_6 = int(var_5.script_noteworthy);
        level.airpathnodes[var_0][var_6] = [];
        var_7 = var_5;

        for(;;) {
          level.airpathnodes[var_0][var_6][level.airpathnodes[var_0][var_6].size] = var_7;

          if(!isDefined(var_7.target)) {
            break;
          }

          var_7 = getEnt(var_7.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        }
      }
    }
  }
}

setupheliobjective() {
  level.escortheli = [];
  level.escortheli[0] = spawnescortchopper(level.airpathnodes[0][0][0].origin);
  level.escortheli[0] thread axiswinondeath();
  level.escortheli[1] = spawnescortchopper(level.airpathnodes[1][0][0].origin);
  level.escortheli[2] = spawnescortchopper(level.airpathnodes[2][0][0].origin);
  scripts\mp\tac_ops_map::adddynamicspawnarea("_encstr_A26007B5FA212B1A83", level.escortheli[0], "_encstr_9A8507BA4040188D08", "_encstr_9B2418F358183FE45077B1B439A0AFCFA051EA2A21EAD3DE2067");
  scripts\mp\tac_ops_map::adddynamicspawnarea("_encstr_A26007B5FA212B1A83", level.escortheli[1], "_encstr_9A8507BA4040188D08", "_encstr_BAE8186D8DA193603A3F30509B49B9EF09B6EBD4B3594129168B");
  scripts\mp\tac_ops_map::adddynamicspawnarea("_encstr_A26007B5FA212B1A83", level.escortheli[2], "_encstr_9A8507BA4040188D08", "_encstr_AC8E19E9ED5FFF2ACBC9197062842D68B0B15B15CFC18EA37840E3");
  level.escortheli[0].spawnoccupied = 0;
  level.escortheli[1].spawnoccupied = 0;
  level.escortheli[2].spawnoccupied = 0;
  updateallowedspawnareas();
  level.escortheli[0].trackedobject = level.escortheli[0] scripts\mp\gameobjects::createtrackedobject(level.escortheli[0], (0, 0, 0));
  level.escortheli[0].trackedobject scripts\mp\gameobjects::releaseid();
  level.escortheli[0].trackedobject scripts\mp\gameobjects::requestid(0, 1);
  level.escortheli[0].trackedobject scripts\mp\gameobjects::setownerteam("_encstr_9A8507BA4040188D08");
  level.escortheli[0].trackedobject scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  level.escortheli[0].trackedobject scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  level.airpathidx = 0;
  level.escortheli[0] waittill("_encstr_8B7205D9ED5958");
  followairpath();
}

spawnescortchopper(var_0) {
  var_1 = var_0;
  var_2 = (0, 0, 0);
  var_3 = 24000;
  var_4 = undefined;
  var_5 = var_0[2];
  var_6 = scripts\cp_mp\killstreaks\airstrike::getexplodedistance(var_5);
  var_7 = 8000;
  var_8 = "_encstr_B88607820996877650";
  var_9 = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_1, var_2, var_3, var_4, var_5, var_7, var_6, var_8);
  var_10 = fakestreakinfo();
  var_11 = scripts\mp\killstreaks\jackal::beginjackalescort(0, var_9["_encstr_B18C0B5E9C6FA319E20A487853"], var_1, var_10, undefined);
  return var_11;
}

fakestreakinfo() {
  var_0 = spawnStruct();
  var_0.available = 1;
  var_0.firednotify = "_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0";
  var_0.isgimme = 1;
  var_0.kid = 5;
  var_0.lifeid = 0;
  var_0.madeavailabletime = gettime();
  var_0.scriptuseagetype = "_encstr_AD56169FC186E14B0B222E10A9B28BA3D38FD76FE2A17735";
  var_0.streakname = "_encstr_B88607820996877650";
  var_0.streaksetupinfo = undefined;
  var_0.variantid = -1;
  var_0.weaponname = "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039";
  var_0.objweapon = getcompleteweaponname(var_0.weaponname);
  return var_0;
}

setupobjectives() {
  level.currentobjectiveindex = 0;
  level.currentobjective = undefined;
  level.objectives = [];
  wait 2.0;
  setupflags();
}

setupflags() {
  var_0 = getEntArray("_encstr_82170DCC8D2CB37D389C2DB685275E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_B40B0FA771DFC427F7DB8BD0FDB4F90ED8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size + var_1.size == 0) {
    return;
  }
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++)
    var_2[var_2.size] = var_0[var_3];

  for(var_3 = 0; var_3 < var_1.size; var_3++)
    var_2[var_2.size] = var_1[var_3];

  var_4 = [];
  var_4[0] = 10;
  var_4[1] = 20;
  var_4[2] = 30;
  var_5 = [];
  var_5[0] = 0;
  var_5[1] = 0;
  var_5[2] = 0;
  level.objectives = [];

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_6 = 0;

    switch (var_2[var_3].script_label) {
      case "_encstr_B20703DFCF":
        var_6 = 0;
        break;
      case "_encstr_B40703E96D":
        var_6 = 1;
        break;
      case "_encstr_B6070359BA":
        var_6 = 2;
        break;
    }

    var_2[var_3].script_label = undefined;
    level.objectives[var_6] = var_2[var_3];
    var_7 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(level.objectives[var_6]);
    var_7 dompoint_ondisableobjective();
    var_7.onbeginuse = ::dompoint_onbeginuse;
    var_7.onuse = ::dompoint_onuse;
    var_7.onenduse = ::dompoint_onenduse;
    var_7.oncontested = ::dompoint_oncontested;
    var_7.onuncontested = ::dompoint_onuncontested;
    var_7.ondisableobjective = ::dompoint_ondisableobjective;
    var_7.onenableobjective = ::dompoint_onenableobjective;
    var_7.onactivateobjective = ::dompoint_onactivateobjective;
    level.objectives[var_6] = var_7;
    level.objectives[var_6].tierindex = var_6;
    level.objectives[var_6].captureduration = var_4[var_6];
    level.objectives[var_6].holdtime = var_5[var_6];

    if(var_6 != 0)
      level.objectives[var_6] scripts\engine\utility::delaythread(2.0, ::dompoint_ondisableobjective);
  }
}

disabledomflagscriptable() {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_BA19049F4B2D", 0);
}

followairpath() {
  level.currentobjective = level.objectives[level.currentobjectiveindex];

  if(isDefined(level.currentobjective))
    level.currentobjective[[level.currentobjective.onenableobjective]]();

  thread helifollowpath(0);
  thread helifollowpath(1);
  thread helifollowpath(2);
}

helifollowpath(var_0) {
  var_1 = level.escortheli[var_0];
  var_2 = level.airpathnodes[var_0][level.airpathidx];

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  for(var_3 = 1; var_3 < var_2.size; var_3++) {
    if(!isDefined(var_1)) {
      return;
    }
    var_4 = var_2[var_3];
    var_5 = var_4.origin;
    var_1.combatmode = "_encstr_859B0F825B4733E7F9D17F7BE3886CFF78";
    var_1 notify(var_1.combatmode);
    var_1 thread scripts\mp\killstreaks\jackal::guardpositionescort(var_5);

    if(isDefined(var_1))
      var_1 waittill("_encstr_8B7205D9ED5958");
  }

  if(isDefined(level.currentobjective) && isDefined(level.currentobjective.trigger))
    var_1 thread scripts\mp\killstreaks\jackal::guardpositionescort(undefined, level.currentobjective.trigger);

  if(var_0 == 0) {
    if(isDefined(level.currentobjective))
      level.currentobjective[[level.currentobjective.onactivateobjective]]();
    else {
      scripts\mp\gamescore::_setteamscore("_encstr_9A8507BA4040188D08", 1, 0);
      thread scripts\mp\gamelogic::endgame("_encstr_9A8507BA4040188D08", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
    }

    level.airpathidx++;
  }
}

setheligoal(var_0) {
  var_1 = distance(level.attackheli.origin, var_0);
  var_2 = var_1 / 150;
  var_3 = 0.25;
  var_4 = 0.25;
  level.attackheli moveTo(var_0, var_2, var_3, var_4);
  var_5 = anglesToForward(level.attackheli.angles);
  var_6 = vectorNormalize(var_0 - level.attackheli.origin);
  thread changeheading(var_5, var_6, 2.0);
  return var_2;
}

changeheading(var_0, var_1, var_2) {
  var_3 = gettime();
  var_4 = var_3;
  var_2 = int(var_2 * 1000);

  for(var_5 = var_4 + var_2; var_3 < var_5; var_3 = gettime()) {
    var_6 = clamp((var_3 - var_4) / var_2, 0.0, 1.0);
    var_7 = vectorlerp(var_0, var_1, var_6);
    level.attackheli.angles = scripts\mp\utility\script::vectortoanglessafe(var_7, (0, 0, 1));
    waitframe();
  }
}

dompoint_onbeginuse(var_0) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onusebegin(var_0);
}

dompoint_onuse(var_0) {
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuse(var_0);
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\utility\game::getotherteam(var_1)[0];
  thread scripts\mp\utility\print::printandsoundoneveryone(var_1, var_2, undefined, undefined, "_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1", "_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", var_0);
  thread dompoint_holdtimer(var_1);
}

dompoint_onenduse(var_0, var_1, var_2) {
  if(self != level.currentobjective) {
    return;
  }
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuseend(var_0, var_1, var_2);
}

dompoint_oncontested() {
  if(self != level.currentobjective) {
    return;
  }
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_oncontested();
}

dompoint_onuncontested(var_0) {
  if(self != level.currentobjective) {
    return;
  }
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::dompoint_onuncontested(var_0);
}

dompoint_ondisableobjective() {
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::resetcaptureprogress();
  scripts\mp\gameobjects::releaseid();
  scripts\engine\utility::delaythread(0.1, ::disabledomflagscriptable);
}

dompoint_onenableobjective() {
  scripts\mp\gameobjects::requestid(1, 1);
  scripts\mp\gameobjects::enableobject();
  scripts\mp\gameobjects::setvisibleteam("_encstr_ACFC091AE8AB2FCBE15119");
  scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.icontarget);
  scripts\mp\gameobjects::setownerteam("_encstr_8E8405EA382B2A");
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_8E8405EA382B2A", 0);
}

dompoint_onactivateobjective() {
  level.flagcapturetime = self.captureduration;
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
  scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
}

dompoint_holdtimer(var_0) {
  level endon("_encstr_841E0AB3B0AD598AB9465946");
  self notify("_encstr_85DA13C26831CB55D845D4F721C0DD43F5C02A5A53");
  self endon("_encstr_85DA13C26831CB55D845D4F721C0DD43F5C02A5A53");
  var_1 = level.currentobjective.holdtime;

  if(var_1 > 0) {
    wait(var_1);

    if(istrue(level.controltoprogress)) {
      var_2 = scripts\mp\utility\game::getotherteam(var_0)[0];

      for(;;) {
        if(level.currentobjective.touchlist[var_2].size == 0) {
          break;
        }

        waitframe();
      }
    }
  }

  if(var_0 == "_encstr_9A8507BA4040188D08") {
    level.currentobjective[[level.currentobjective.ondisableobjective]]();
    level.currentobjectiveindex++;
    updateallowedspawnareas();
    followairpath();
  }
}

updateallowedspawnareas() {
  if(!isDefined(level.allowedspawnareas))
    level.allowedspawnareas = [];

  level.allowedspawnareas["_encstr_9A8507BA4040188D08"] = [];
  level.allowedspawnareas["_encstr_8E8405EA382B2A"] = [];

  if(isDefined(level.escortheli)) {
    level.allowedspawnareas["_encstr_9A8507BA4040188D08"][level.allowedspawnareas["_encstr_9A8507BA4040188D08"].size] = "_encstr_9B2418F358183FE45077B1B439A0AFCFA051EA2A21EAD3DE2067";

    if(isDefined(level.escortheli[1]) && !istrue(level.escortheli[1].spawnoccupied))
      level.allowedspawnareas["_encstr_9A8507BA4040188D08"][level.allowedspawnareas["_encstr_9A8507BA4040188D08"].size] = "_encstr_BAE8186D8DA193603A3F30509B49B9EF09B6EBD4B3594129168B";

    if(isDefined(level.escortheli[2]) && !istrue(level.escortheli[2].spawnoccupied))
      level.allowedspawnareas["_encstr_9A8507BA4040188D08"][level.allowedspawnareas["_encstr_9A8507BA4040188D08"].size] = "_encstr_AC8E19E9ED5FFF2ACBC9197062842D68B0B15B15CFC18EA37840E3";
  }

  switch (level.currentobjectiveindex) {
    case 0:
      level.allowedspawnareas["_encstr_9A8507BA4040188D08"][level.allowedspawnareas["_encstr_9A8507BA4040188D08"].size] = "_encstr_ABDD107BD090C71CD8EF390CB138274738A3";
      level.allowedspawnareas["_encstr_8E8405EA382B2A"][level.allowedspawnareas["_encstr_8E8405EA382B2A"].size] = "_encstr_95020EE8DEF5C24B4EFAB0E14BE6AF60";
      break;
    case 1:
      level.allowedspawnareas["_encstr_8E8405EA382B2A"][level.allowedspawnareas["_encstr_8E8405EA382B2A"].size] = "_encstr_B4020EE8B7AF2C2DC97D58F02DE67D4C";
      break;
    case 2:
      level.allowedspawnareas["_encstr_8E8405EA382B2A"][level.allowedspawnareas["_encstr_8E8405EA382B2A"].size] = "_encstr_B1020ED32031A9528607374B732E79B2";
      break;
  }

  foreach(var_9, var_1 in level.allowedspawnareas) {
    foreach(var_3 in level.tacopsmap.activeconfigs[var_9].spawnareas[var_9]) {
      var_4 = 0;

      foreach(var_6 in level.allowedspawnareas[var_9]) {
        if(var_6 == var_3.script_noteworthy) {
          var_4 = 1;
          break;
        }
      }

      var_3.enabled = var_4;
    }
  }

  level notify("_encstr_BE66141D3F935E506973263830189F96AC93B6D96D5F");
}

enterattackheli(var_0) {
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  self playerlinkTo(var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self remotecontrolturret(var_0.turret);
  var_0.spawnoccupied = 1;
  updateallowedspawnareas();
  thread watchearlyexit(var_0);
  thread watchhelideath(var_0);
}

watchearlyexit(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_0 thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit();
  var_0 waittill("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  self remotecontrolturretoff(var_0.turret);
  var_1 = scripts\engine\utility::player_drop_to_ground(var_0.origin, 32, 0, -1500, (0, 0, 1));
  self unlink();
  self dontinterpolate();
  self setOrigin(var_1);
  var_2 = anglesToForward(var_0.angles);
  var_2 = var_2 * (1, 1, 0);
  var_3 = (0, 0, 1);
  var_4 = vectorcross(var_2, var_3);
  var_5 = axistoangles(var_2, var_4, var_3);
  self setplayerangles(var_5);
  var_0.spawnoccupied = 0;
  updateallowedspawnareas();
  self notify("_encstr_BAE10CAC875A1D5691FA86CAB1D2");
}

watchhelideath(var_0) {
  self endon("_encstr_BAE10CAC875A1D5691FA86CAB1D2");
  var_0 waittill("_encstr_AD75063D571AE108");
  self suicide();
  updateallowedspawnareas();
}

axiswinondeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");
  wait 5.0;
  scripts\mp\gamescore::_setteamscore("_encstr_8E8405EA382B2A", 1, 0);
  thread scripts\mp\gamelogic::endgame("_encstr_8E8405EA382B2A", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_81221428DB3AE18F03640C9DF12ACFA8885BF0682FCC"]);
}