/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rugby.gsc
***********************************************/

main() {
  var_0 = spawnStruct();
  level.rugby = var_0;
  var_0.endzones = [];
  var_0.endzones["_encstr_9A8507BA4040188D08"] = [];
  var_0.endzones["_encstr_8E8405EA382B2A"] = [];
  var_0.juggcratesetups = [];
  var_0.goals = [];
  var_0.activejuggcrates = [];
  var_0.activejuggernauts = [];
  var_0.lastjuggpositions = [];
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_1[0] = scripts\mp\utility\game::getgametype();
  scripts\mp\gameobjects::main(var_1);
  initrules();
  level.teambased = 1;
  level.objectivebased = 1;
  level.onstartgametype = ::onstartgametype;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerkilled = ::onplayerkilled;
  level.ontimelimit = ::ontimelimit;
  level.onplayerdamaged = ::onplayerdamaged;
  level.modeonteamchangedeath = ::modeonteamchangedeath;
  level.onplayerconnect = ::onplayerconnect;
  level.ontimelimitot = ::ontimelimitot;
  level._id_11C89 = ::get_circle_back_start_node;
  game["_encstr_AD3F0EB158739AC6EDE456F43751B495"] = 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_953B13A1380935092A01B70935C0087891CBF79853";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_AB690C5EB59A8FEB3F93F870CB41";

  if(!isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]))
    var_2 = "_encstr_AB690C5EB59A8FEB3F93F870CB41";
  else
    var_2 = "_encstr_9BA91289F67BDCD1BE39D5B34CCBBE3743BD4E8E";

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = var_2;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = var_2;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B13E177AE33096F7B8B1C27A9883378E63AFF3F51F881D5FD9"] = "_encstr_B13E177AE33096F7B8B1C27A9883378E63AFF3F51F881D5FD9";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8DC01AAAA38CE5CAF1826B33DA7834712F97CB3310535209D1E72BAD"] = "_encstr_8DC01AAAA38CE5CAF1826B33DA7834712F97CB3310535209D1E72BAD";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC6B10F84BA2AD689F79155BC59FCB835C4F"] = "_encstr_AC6B10F84BA2AD689F79155BC59FCB835C4F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B1D013C95DB313E57D372B36EA27AC23AF9AAECE3B"] = "_encstr_B1D013C95DB313E57D372B36EA27AC23AF9AAECE3B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9A331408CB47658AD7C3050EBD1BF0352FF14088429F"] = "_encstr_9A331408CB47658AD7C3050EBD1BF0352FF14088429F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_847B13A8EF5F79C3D9FEAF2F13531D41BF7B68883F"] = "_encstr_B12B0EC09A240BA91BB9EC6DB74B51E7";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_ABD80F1B938CCB18B18D3D17D720231724"] = "_encstr_9BB011A3A9EA76ECAFE6B2DD7D0763855EAC27";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_926D14BEDBF2455227A34068EF0F08D35AC7A0C8B6AA"] = "_encstr_8B7A0A85D27F071F3F8BC96B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8DE813522D8242722147E679696AE1E28B502E3162"] = "_encstr_BD0E0D65F398DD93AF6B734B5336CA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8C4F15395D3BC4F2EBB74E8CB2E4BE33B01B6398581B5B"] = "_encstr_91EF0FED93462B93EB992C63D826B036B5";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC1611CA538026276883228B28DD871D68C755"] = "_encstr_8D480EBDD95927275773AFCA9B59B62F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9731103223D762D1EF2B404FC0A5B94C8B73"] = "_encstr_92B611DED92BE4E4AECDD7CC4E96CAE68CD85E";
  level._effect["_encstr_8F2F1639EAD99897AFB9B17BE4CABEB28738C6B7B996ED37"] = loadfx("_encstr_A7CE3453FC2126B13322974778E0770AF3851D8D55B37ED679089F3738013A525130260549E573010398A7932B3BF48B07BBBDFBA439");
}

initrules() {
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 240);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.ontimelimitgraceperiod = remove_steam_damage();
  level.currenttimelimitdelay = 0.0;
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  var_0 = getmatchrulesdata("_encstr_93B80A5567C28670849E43F9", "_encstr_A71D0B383BB7BF7CEFE1B1B5F0");
  setdynamicdvar("_encstr_B27A1593B93357527B222EE3C9C4ABAFB1507859ED19CA", var_0);
  var_1 = getmatchrulesdata("_encstr_93B80A5567C28670849E43F9", "_encstr_AC990A221F50082643F5E841");
  setdynamicdvar("_encstr_8FB71403DE2317FA8B6072DBB9ED73BFF9AE888D6549", var_1);
  var_2 = getmatchrulesdata("_encstr_93B80A5567C28670849E43F9", "_encstr_8F110E53EAD93B8AB216B5D4C1595946");
  setdynamicdvar("_encstr_8AC6180BBFE8A94B3D61B20B4E9A6F1FE8499561CBB92ADFEDF9", var_2);
  var_3 = getmatchrulesdata("_encstr_93B80A5567C28670849E43F9", "_encstr_B4BC0C4D5DCEB351D2B5B27BBA3A");
  setdynamicdvar("_encstr_96AA1637B139FAC9BA7689CB7D4DBACE3B452DB5B2BDEAD1", var_3);
  var_4 = getmatchrulesdata("_encstr_93B80A5567C28670849E43F9", "_encstr_88FC0A687374DBD842C12BD8");
  setdynamicdvar("_encstr_8D6914E66CE4BE93AE9D892FAFA19563E0564EA9B087", var_4);
  var_5 = getmatchrulesdata("_encstr_93B80A5567C28670849E43F9", "_encstr_AC75101A6BF7E9B52123B393AECF2C601F60");
  setdynamicdvar("_encstr_BD631A93CA335860B38F252B8F5C101C3FA0A97B2387062B0369331B", var_5);
}

getjuggmaxhealth() {
  return getdvarint("_encstr_B27A1593B93357527B222EE3C9C4ABAFB1507859ED19CA");
}

getjuggspeedscalar(var_0) {
  var_1 = -0.3 + 0.1 * getdvarfloat("_encstr_8FB71403DE2317FA8B6072DBB9ED73BFF9AE888D6549");
  var_0 = int(min(var_0, getdvarint("_encstr_8D6914E66CE4BE93AE9D892FAFA19563E0564EA9B087")));
  var_2 = 0.08 * getdvarfloat("_encstr_8AC6180BBFE8A94B3D61B20B4E9A6F1FE8499561CBB92ADFEDF9");
  return var_1 + var_0 * var_2;
}

getjuggtimeout() {
  return getdvarfloat("_encstr_96AA1637B139FAC9BA7689CB7D4DBACE3B452DB5B2BDEAD1");
}

remove_spawn_disable_struct() {
  return getdvarfloat("_encstr_BD631A93CA335860B38F252B8F5C101C3FA0A97B2387062B0369331B");
}

remove_steam_damage() {
  return getdvarfloat("_encstr_9BE6176B40BD819BE3F422418068CFD7CF8983825059C43FD9", 45);
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  foreach(var_1 in level.teamnamelist)
  scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_99301FC31BA9F9192C3F9E37D3D7890B46E74D6FF7D0B5D10FC6242D4EEC99C458");

  setupwaypointicons();
  _id_12C4B();
  thread initrugbyents();
  thread setupinitialstate();
  initspawns();
  initjugg();
  level thread _id_136F4();
  setomnvar("_encstr_924514CB49C988AD8F2A2A16523F6CE811CC7B43EDEA", 0);
  setomnvar("_encstr_ABEE151308FFA2EFD91E517F22A39F2F5748DAFAE05B9D", 0);
}

_id_136F4() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait 5;
  level thread scripts\mp\hud_message::notifyteam("_encstr_96860D9ABA9D3BEB8D0BE0E85739AC", "_encstr_96860D9ABA9D3BEB8D0BE0E85739AC", "_encstr_9A8507BA4040188D08");
}

initrugbyents() {
  level.trial_target_headshot_func = scripts\engine\utility::array_combine(level.outofboundstriggers, level.minetriggers, level.hurttriggers, level.radtriggers);
  initendzoneents();
  initjuggcratesetupents();
}

initendzoneents() {
  var_0 = level.rugby;
  var_1 = scripts\engine\utility::getStructArray("_encstr_AAAA0E781BD2594A5F2F53D18DE05667", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    initendzoneent(var_3);
    var_0.endzones[var_3.team][var_0.endzones[var_3.team].size] = var_3;
  }
}

initendzoneent(var_0) {
  var_1 = getEntArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    if(var_3.classname == "_encstr_AAC222B5E038CF47ED4B40CD5BBDAC64C7CCB729B2D8E93308AC8EB109C7804183B720F3")
      var_0.trigger = var_3;

    if(isDefined(var_3.script_noteworthy) && getsubstr(var_3.script_noteworthy, 0, 3) == "_encstr_841804CC3CAF")
      var_3 delete();
  }

  getlinktarget(var_0);

  if(var_0.spawnflags & 1) {
    var_0.team = "_encstr_9A8507BA4040188D08";
    var_0.trigger.objectivekey = "_encstr_9A8507BA4040188D08";
  } else if(var_0.spawnflags & 2) {
    var_0.team = "_encstr_8E8405EA382B2A";
    var_0.trigger.objectivekey = "_encstr_8E8405EA382B2A";
  } else {
    var_0.team = "_encstr_9A8507BA4040188D08";
    var_0.trigger.objectivekey = "_encstr_9A8507BA4040188D08";
  }

  foreach(var_3 in var_1) {
    if(!isDefined(var_0.chevrons))
      level thread _id_13232(var_0);
  }
}

getlinktarget(var_0) {
  if(level.mapname == "_encstr_82670A6D9FF7A9AAD022B0CA") {
    if(distance2d(var_0.origin, (312, -1552, 216)) < 10)
      var_0.spawnflags = 1;
  } else if(level.mapname == "_encstr_86490D53F85118CEB362634A4A9B75") {
    if(distance2d(var_0.origin, (-25223.3, -12439.2, 36.5)) < 10)
      var_0.spawnflags = 2;
    else if(distance2d(var_0.origin, (-26150.7, -8967.81, 144)) < 10)
      var_0.spawnflags = 1;
  }
}

initjuggcratesetupents() {
  var_0 = level.rugby;
  var_1 = scripts\engine\utility::getStructArray("_encstr_AB151139AE7698E5AFD4EAB39DF5B139B08E56", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1) {
    var_3 = player_get_sniper_weapon_object(var_3);
    var_0.juggcratesetups[var_0.juggcratesetups.size] = var_3;
  }

  level.rugby = var_0;
}

player_get_sniper_weapon_object(var_0) {
  switch (level.mapname) {
    case "_encstr_83970EDA1CFAC2E65AF21686BE47C28D":
      if(distance(var_0.origin, (3113.65, -1118.5, 378.5)) < 10)
        var_0.origin = (2751, -1028, 376.5);

      break;
    default:
      break;
  }

  return var_0;
}

initoverheadcameras() {
  level.spectatorcameras = [];
  level.spectatorcameras[0]["_encstr_9A8507BA4040188D08"] = spawnStruct();
  level.spectatorcameras[0]["_encstr_8E8405EA382B2A"] = spawnStruct();
  scripts\mp\spawncamera::setgamemodecamera("_encstr_9A8507BA4040188D08", level.spectatorcameras[0]["_encstr_9A8507BA4040188D08"]);
  scripts\mp\spawncamera::setgamemodecamera("_encstr_8E8405EA382B2A", level.spectatorcameras[0]["_encstr_8E8405EA382B2A"]);
  updateoverheadcamerapos("_encstr_9A8507BA4040188D08");
  updateoverheadcamerapos("_encstr_8E8405EA382B2A");
  level.updategamemodecamera = ::updateoverheadcamerapos;
  level.spectatorcameratime = 1.25;
}

initjugg() {
  var_0 = scripts\mp\juggernaut::jugg_createconfig();
  level.rugby.juggconfig = var_0;
  var_1 = getjuggmaxhealth();
  var_0.maxhealth = var_1;
  var_0.startinghealth = var_1;
  var_2 = "_encstr_926B184F5F2B194DB3F9E7554EC55B45C3EFEA77C71A183ACEE9";

  if(scripts\common\utility::iscp())
    var_2 = "_encstr_87F018506B109F68FF57848D3AEB71836B718820415A33018B61";

  var_0.suit = var_2;
  var_0.clothtype = "_encstr_A96C0A3BAF8B58CB528FFDEB";
  var_0.forcetostand = 0;
  var_0.allows["_encstr_92100762872552A643"] = 1;
  var_0.allows["_encstr_A60F0E030703D180A0665F43BA558F28"] = undefined;
  var_0.classstruct.loadoutprimary = "_encstr_BD060D9B3F48B9098FC1A169DAA7B4";
}

initspawns() {
  var_0 = level.rugby;
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::setactivespawnlogic("_encstr_AF6A06B265315388", "_encstr_829A0D0F1AF8FB5ED127855073F940");
  var_0.startspawnclassname = "_encstr_BA6E0FD280BF622F19DE91BF6EC3476B75";
  scripts\mp\spawnlogic::addstartspawnpoints(var_0.startspawnclassname + "_encstr_951C0E91F96363396FDF216F7B2A3A69", 1, "_encstr_9A8507BA4040188D08");
  scripts\mp\spawnlogic::addstartspawnpoints(var_0.startspawnclassname + "_encstr_B2420C61B9AB3F42594FC4D92568", 1, "_encstr_8E8405EA382B2A");

  if(!isDefined(level.teamstartspawnpoints)) {
    var_0.startspawnclassname = "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD";
    scripts\mp\spawnlogic::addstartspawnpoints(var_0.startspawnclassname + "_encstr_951C0E91F96363396FDF216F7B2A3A69", 1, "_encstr_9A8507BA4040188D08");
    scripts\mp\spawnlogic::addstartspawnpoints(var_0.startspawnclassname + "_encstr_B2420C61B9AB3F42594FC4D92568", 1, "_encstr_8E8405EA382B2A");
  }

  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A15E1681484773AB9F6A98A15372BB6B2BFF1F89BC4759EF");
  var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_AB57148922C9DD9B57A3E8E1DF78D11F0201778BFCA3");

  if(var_1.size <= 0 || var_2.size <= 0) {
    var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");

    foreach(var_5 in var_3) {
      if(distancesquared(var_5.origin, var_0.goals["_encstr_9A8507BA4040188D08"].origin) < distancesquared(var_5.origin, var_0.goals["_encstr_8E8405EA382B2A"].origin)) {
        var_1[var_1.size] = var_5;
        continue;
      }

      var_2[var_2.size] = var_5;
    }
  }

  var_7 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_847320DA07F5E4EAB398BC7D9B1C85BBCDAF161B634BCACDF56E2BB1EDCD23169C2F");
  var_8 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_9BA21E08A33F13B322D6FB90EA2BE3FB6687E0186FCB4E772ABEF83707120DE2");
  scripts\mp\spawnlogic::registerspawnpoints("_encstr_9A8507BA4040188D08", var_1);
  scripts\mp\spawnlogic::registerspawnpoints("_encstr_8E8405EA382B2A", var_2);
  scripts\mp\spawnlogic::registerspawnpoints("_encstr_9A8507BA4040188D08", var_7);
  scripts\mp\spawnlogic::registerspawnpoints("_encstr_8E8405EA382B2A", var_8);
  scripts\mp\spawnlogic::registerspawnset("_encstr_8A730DD6B39A2DCABF5FB0A867DDC3", var_1);
  scripts\mp\spawnlogic::registerspawnset("_encstr_AFA00B437D2735435F1A7B53CB", var_2);
  scripts\mp\spawnlogic::registerspawnset("_encstr_A1F9122A6D3F4173C9EFF0B46A4B80699A613A12", var_7);
  scripts\mp\spawnlogic::registerspawnset("_encstr_B1621095A70246B0DFDE82B842F7A00FFB4F", var_8);
  var_0.spawnsets = [];
  var_0.spawnsets["_encstr_9A8507BA4040188D08"] = "_encstr_8A730DD6B39A2DCABF5FB0A867DDC3";
  var_0.spawnsets["_encstr_8E8405EA382B2A"] = "_encstr_AFA00B437D2735435F1A7B53CB";
  var_0.fallbackspawnsets = [];
  var_0.fallbackspawnsets["_encstr_9A8507BA4040188D08"] = "_encstr_A1F9122A6D3F4173C9EFF0B46A4B80699A613A12";
  var_0.fallbackspawnsets["_encstr_8E8405EA382B2A"] = "_encstr_B1621095A70246B0DFDE82B842F7A00FFB4F";
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  var_0 = level.rugby;
  var_1 = self.pers["_encstr_8AEF05472BC2D6"];

  if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    var_1 = scripts\engine\utility::ter_op(var_1 == "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");

  var_2 = scripts\engine\utility::ter_op(var_1 == "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");

  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    var_3 = scripts\mp\spawnlogic::getspawnpointarray(var_0.startspawnclassname + "_encstr_BA4C02DF" + var_1 + "_encstr_B4810709B378B9F3F5");
    var_4 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_3);
  } else {
    var_5 = getjuggorcratepos();
    var_6 = [];
    var_6["_encstr_AC010F235BF6E9C08D57B80373D379FD42"] = var_5;
    var_6["_encstr_AB4A1707F878FC2A27FDDB0D763B126780306B874B9004B17B"] = 562500;
    var_6["_encstr_B6F71772A8518F3FFBB5DCEFDE40DB8F911029EA4025FB9F93"] = 36000000;
    var_6["_encstr_8B7619B96C4B981652F39F93339ADEC8FE472011DA8FB8305B7FAB"] = 35437500;
    var_6["_encstr_ADD8088D2D8F6867F773"] = var_5;
    var_6["_encstr_B228102AB360C687444022BA09AD3F3A2249"] = var_0.goals[var_2].origin - var_0.goals[var_1].origin;
    var_4 = scripts\mp\spawnlogic::getspawnpoint(self, self.team, var_0.spawnsets[var_1], var_0.fallbackspawnsets[var_1], undefined, var_6);
  }

  return var_4;
}

modeonteamchangedeath(var_0) {
  if(isDefined(level._id_12DD4))
    var_0 setclientomnvar("_encstr_92C3175D2D7D275DD9C42FEB53AEECCEFA33C94B569B8C632F", scripts\engine\utility::ter_op(var_0.team == level._id_12DD4.team, 0, 1));
}

onplayerconnect(var_0) {
  var_0 scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0.pers["_encstr_B2BE0788BAF573592F"]))
    var_0 scripts\mp\utility\stats::setextrascore0(var_0.pers["_encstr_B2BE0788BAF573592F"]);

  var_0 scripts\mp\utility\stats::setextrascore1(0);

  if(isDefined(var_0.pers["_encstr_B1F7085B03F492AE98DB"]))
    var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["_encstr_B1F7085B03F492AE98DB"]);

  thread onplayerspawned(var_0);
}

onplayerspawned(var_0) {
  var_0 waittill("_encstr_BA350853C128FB939DB9");

  if(isDefined(level._id_12DD4) && isDefined(level._id_12DD4.team) && isDefined(var_0.team))
    var_0 setclientomnvar("_encstr_92C3175D2D7D275DD9C42FEB53AEECCEFA33C94B569B8C632F", scripts\engine\utility::ter_op(var_0.team == level._id_12DD4.team, 0, 1));
}

onplayerdamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_1) && var_1 != var_2 && isPlayer(var_1)) {
    if(var_3 >= var_7)
      var_3 = var_7;

    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B2BE0788BAF573592F", var_1.pers["_encstr_B2BE0788BAF573592F"]);
    var_1 scripts\mp\utility\stats::setextrascore0(var_1.pers["_encstr_B2BE0788BAF573592F"]);
  }
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::oncommonnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self.overrideweaponspeed_speedscale = undefined;

  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

awardgenericmedals(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;
  var_11 = 0;
  var_12 = self;
  var_13 = var_12.origin;
  var_14 = var_1.origin;
  var_15 = 0;

  if(isDefined(var_0)) {
    var_14 = var_0.origin;
    var_15 = var_0 == var_1;
  }

  if(isDefined(level._id_12DD4)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1.team != var_12.team) {
      if(var_1 == level._id_12DD4)
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A56813EFFB71582FE73636902B0F589D353E56F37B");
      else if(var_12 == level._id_12DD4)
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_BABA10D6A51B63EBA6ABD99DB293DCC2EAA3");
      else if(var_1.team == level._id_12DD4.team && var_1 != level._id_12DD4) {
        var_16 = distancesquared(level._id_12DD4.origin, var_14);

        if(var_16 < 105625) {
          var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
          var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
          var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
          var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
          var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
          thread scripts\common\utility::_id_13E0A(level._id_11B30, var_9, "_encstr_ABA70A195633CADC324BDC76");
          return;
        }
      } else if(var_1.team != level._id_12DD4.team && var_12.team == level._id_12DD4.team) {
        var_16 = distancesquared(level._id_12DD4.origin, var_13);

        if(var_16 < 105625) {
          var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_AB3508737F830710ACDB");
          var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
          thread scripts\common\utility::_id_13E0A(level._id_11B26, var_9, "_encstr_9AD10BF61657A2CD30606F6BE0");
        }
      }
    }
  }
}

ontimelimit() {
  if(level.gameended) {
    return;
  }
  thread scripts\mp\gamelogic::endgame("_encstr_8D19048EA595", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_AF9C0A077B223BF35F4BF34B"]);
}

ontimelimitot() {
  if(level.rugby.activejuggernauts.size > 0) {
    if(!istrue(level.rugby.inot)) {
      setomnvar("_encstr_B8891173088897B318DD34218B70B1A3CB20CA", gettime() + remove_steam_damage() * 1000);
      level.rugby.inot = 1;
      level.canprocessot = 1;
      _id_13166();
      level thread vehicle_isenemytoteam();
    }
  } else {
    level.canprocessot = 1;
    level.currenttimelimitdelay = level.ontimelimitgraceperiod;
  }
}

vehicle_isenemytoteam() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(level.rugby.activejuggernauts.size > 0) {
      wait 0.05;
      continue;
    }

    level.currenttimelimitdelay = level.ontimelimitgraceperiod;
    break;
  }
}

_id_13167() {
  var_0 = getdvarfloat("_encstr_96AA1637B139FAC9BA7689CB7D4DBACE3B452DB5B2BDEAD1");
  var_0 = int(var_0 * 1000 + gettime());
  setomnvar("_encstr_924514CB49C988AD8F2A2A16523F6CE811CC7B43EDEA", var_0);
  setomnvar("_encstr_ABEE151308FFA2EFD91E517F22A39F2F5748DAFAE05B9D", 1);
  return var_0;
}

_id_13166() {
  level notify("_encstr_954013DC8EBD83F5E4ABD9265EBE3AD2DA2BB7D53A");
  setomnvar("_encstr_924514CB49C988AD8F2A2A16523F6CE811CC7B43EDEA", 0);
  setomnvar("_encstr_ABEE151308FFA2EFD91E517F22A39F2F5748DAFAE05B9D", 0);
}

getjuggorcratepos() {
  var_0 = level.rugby;

  if(isDefined(level._id_12DD4))
    return level._id_12DD4.origin;
  else if(var_0.activejuggernauts.size > 0) {
    foreach(var_2 in var_0.activejuggernauts)
    return var_2.origin;
  } else {
    foreach(var_5 in var_0.activejuggcrates)
    return var_5.origin;
  }

  return undefined;
}

doesteamhaveactivejugg(var_0) {
  var_1 = level.rugby;

  if(var_1.activejuggernauts.size > 0) {
    foreach(var_3 in var_1.activejuggernauts) {
      if(var_3.team == var_0)
        return 1;
    }
  }

  return 0;
}

onjuggproximityscore(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  playsoundatpos(var_0.origin, "_encstr_BAE710E54853EF0127F728A88F54B9B73A72");
  playFX(scripts\engine\utility::getfx("_encstr_8F2F1639EAD99897AFB9B17BE4CABEB28738C6B7B996ED37"), var_0.origin);
  var_1 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 800);

  foreach(var_3 in var_1) {
    if(var_3 != var_0 && var_3.team != var_0.team)
      var_3 dodamage(5000, var_0.origin, var_3, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF");
  }

  thread scripts\mp\gamelogic::endgame(var_0.team, game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_ABCA11472C9C3B56E8BE3295CD1D93B7E5CA91"]);
}

setupinitialstate() {
  var_0 = level.rugby;

  if(!activateendzone(var_0.endzones["_encstr_9A8507BA4040188D08"][0], "_encstr_9A8507BA4040188D08")) {
    return;
  }
  if(!activateendzone(var_0.endzones["_encstr_8E8405EA382B2A"][0], "_encstr_8E8405EA382B2A")) {
    return;
  }
  if(!activatenewjuggcrate())
    return;
}

activatenewjuggcrate() {
  var_0 = randomint(level.rugby.juggcratesetups.size);
  var_1 = level.rugby.juggcratesetups[var_0];

  if(!isDefined(var_1))
    return 0;

  return activatejuggcrate(var_1.origin, scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0)), 1);
}

activateendzone(var_0, var_1) {
  var_2 = level.rugby;

  if(istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    var_1 = scripts\engine\utility::ter_op(var_1 == "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");

  if(!isDefined(var_0))
    return 0;

  if(isDefined(var_2.goals[var_1]))
    deactivateendzone(var_2.goals[var_1]);

  var_2.goals[var_1] = var_0;
  var_0 thread watchforjuggproximityscore(var_1);
  return 1;
}

deactivateendzone(var_0) {
  var_0 notify("_encstr_A6C81359CD91F4BD37957D322BC2C63AA5672CD1AC");
}

_id_13232(var_0) {
  if(level.mapname == "_encstr_A2200CDA13D6CBC897E1A0EBAA93" || level.mapname == "_encstr_A6640D9D1109AF2FC7082B029395FF" || level.mapname == "_encstr_9B8808AD1CD7E457DC1D" || level.mapname == "_encstr_82670A6D9FF7A9AAD022B0CA" || level.mapname == "_encstr_82740C4F78166D12D1B3CA0495DD") {
    if(var_0.trigger.objectivekey == "_encstr_9A8507BA4040188D08")
      var_1 = "_encstr_81BD13D704DB40BBAA89A8F8D29E7778578FE45B73";
    else
      var_1 = "_encstr_8F3F114E7B2D1B39083774AA6F55A9C7C5EBC7";
  } else if(level.mapname == "_encstr_8E2D0CDA88B79E8791429C87E593") {
    if(var_0.trigger.targetname == "_encstr_AAA90FE0386238C907C77FC5B148574B6D")
      var_1 = "_encstr_8F3F114E7B2D1B39083774AA6F55A9C7C5EBC7";
    else
      var_1 = "_encstr_81BD13D704DB40BBAA89A8F8D29E7778578FE45B73";
  } else if(var_0.trigger.targetname == "_encstr_AAA90FE0386238C907C77FC5B148574B6D")
    var_1 = "_encstr_81BD13D704DB40BBAA89A8F8D29E7778578FE45B73";
  else
    var_1 = "_encstr_8F3F114E7B2D1B39083774AA6F55A9C7C5EBC7";

  var_0 thread cargo_truck_mg_initomnvars(var_1, var_0.trigger.targetname);
  var_0 thread updatechevrons("_encstr_A7C5056BD931D1");
}

cargo_truck_mg_initomnvars(var_0, var_1) {
  wait 1.0;
  var_2 = getentitylessscriptablearrayinradius(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = _id_12805(var_2, var_1);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_3.size;
    var_3[var_6] = var_5;
    var_3[var_6].numchevrons = 1;

    if(isDefined(var_5.script_noteworthy)) {
      if(var_5.script_noteworthy == "_encstr_A74C0222") {
        var_3[var_6].numchevrons = 2;
        continue;
      }

      if(var_5.script_noteworthy == "_encstr_A14C023B") {
        var_3[var_6].numchevrons = 3;
        continue;
      }

      if(var_5.script_noteworthy == "_encstr_AC4C024A")
        var_3[var_6].numchevrons = 4;
    }
  }

  self.chevrons = var_3;
}

updatechevrons(var_0) {
  self notify("_encstr_8BBA0F9540A319D1677008783BFAAFB047");
  self endon("_encstr_8BBA0F9540A319D1677008783BFAAFB047");

  while(!isDefined(self.chevrons))
    waitframe();

  foreach(var_2 in self.chevrons) {
    for(var_3 = 0; var_3 < var_2.numchevrons; var_3++)
      var_2 setscriptablepartstate("_encstr_917509E648C510D3A7781F" + var_3, var_0);
  }
}

_id_12C1D(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  switch (level.mapname) {
    case "_encstr_A5110B50E25F68A83BD3D3EBBB":
      var_3["_encstr_A34C02BB"] = [(-564, 1848, 24)];
      var_3["_encstr_A74C0222"] = [(-1314, 440, 24), (-1362, 816, 24)];
      break;
    case "_encstr_BDFF088922C9FF1946BF":
    case "_encstr_99020BB0027F38974BA78783FF":
      var_3["_encstr_A14C023B"] = [(-692, 1828, 42), (-300, 1548, 76)];
      break;
    case "_encstr_A3890850E25F90B79A83":
      var_3["_encstr_864C02F9"] = [(688, 256, 280)];
      var_3["_encstr_990703B2F9"] = [(212, 1436, 338)];
      break;
    default:
      break;
  }

  if(isDefined(var_3[var_1])) {
    foreach(var_5 in var_0) {
      foreach(var_7 in var_3[var_1]) {
        if(distance(var_5.origin, var_7) < 10) {
          var_2[var_2.size] = var_5;
          break;
        }
      }
    }
  }

  var_0 = scripts\engine\utility::array_remove_array(var_0, var_2);
  return var_0;
}

_id_12805(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  switch (level.mapname) {
    case "_encstr_B4870E0751AFABC1B8F1CE97A8181CF3":
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"] = [];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][0] = [(-2376, -3322, 39), (0, -90, 0)];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][1] = [(-2071, -3537, 0), (0, 180, 0)];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][2] = [(-2071, -3653, 0), (0, 180, 0)];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][3] = [(-2071, -3754, 3), (0, 180, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"] = [];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][0] = [(2137, 493, 124), (0, -85, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][1] = [(2302, 495, 128), (0, -90, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][2] = [(2390, 495, 134), (0, -90, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][3] = [(2457, 494, 134), (0, -90, 0)];
      break;
    case "_encstr_96040A5B1CAF0D163926ED9C":
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"] = [];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][0] = [(-722, -1428, 201), (0, 0, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][1] = [(-722, -1567, 200), (0, 0, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][2] = [(-721, -1496, 200), (0, 0, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][3] = [(-721, -1639, 200), (0, 0, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][4] = [(-720, -1711, 200), (0, 0, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][5] = [(-720, -1806, 200), (0, 0, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][6] = [(-719, -1896, 200), (0, 0, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][7] = [(-719, -1999, 200), (0, 0, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][8] = [(-483, -2074, 200), (0, -270, 0)];
      break;
    case "_encstr_9B2D0A451FCEFB46DF18EA43":
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"] = [];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][0] = [(4948, 1284, 9), (0, 45, 0)];
      break;
    case "_encstr_A5110B50E25F68A83BD3D3EBBB":
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"] = [];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][0] = [(-603, 3101, 33), (0, 155, 0)];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"] = [];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][0] = [(-1070, 600, 32), (0, -20, 0)];
      break;
    case "_encstr_992B0BABB3814370F29F80B983":
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"] = [];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][0] = [(1773, -1148, 302), (0, -90, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][1] = [(2098, -1153, 292), (0, -90, 0)];
      break;
    case "_encstr_91B90DB6E0D7935D9B7356C9AF0EAD":
    case "_encstr_B6EE0A72AB0863F3C065A5BA":
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"] = [];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][0] = [(1648, 367, 291), (0, 0, 0)];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][1] = [(1947, 859, 255), (0, 270, 0)];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][2] = [(1691, 854, 291), (0, 270, 0)];
      break;
    case "_encstr_A3890850E25F90B79A83":
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"] = [];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][0] = [(-2404.94, -1457.67, 280), (0, 0, 0)];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][1] = [(-849.814, -1158.33, 280), (0, 180, 0)];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][2] = [(-1978.45, -341.57, 280), (0, 270, 0)];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][3] = [(-1143, -975, 280), (0, 270, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"] = [];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][0] = [(-1300.9, 4861.72, 269), (0, 180, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][1] = [(-1300.9, 4947, 269), (0, 180, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][2] = [(-1300.9, 4759, 269), (0, 180, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][3] = [(-1293.48, 4459.81, 273), (0, 180, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][4] = [(-1293.48, 4392, 274), (0, 180, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][5] = [(-2300.19, 3725.48, 288), (0, 90, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][6] = [(-1700.19, 3725.48, 286), (0, 90, 0)];
      var_2["_encstr_8BA50D211BC07F076845D43AFF1367"][7] = [(-1598.19, 4348.83, 279), (0, 90, 0)];
      break;
    case "_encstr_994B10FAA8973CA771A27E6D431E0F8635E0":
    case "_encstr_86570E71DA311191DB1FD8887FCFA9A3":
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"] = [];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][0] = [(765, -1883, 23), (0, 180, 0)];
      var_2["_encstr_AAA90FE0386238C907C77FC5B148574B6D"][1] = [(762, -2006, 187), (0, 180, 0)];
      break;
    default:
      break;
  }

  if(isDefined(var_2[var_1])) {
    foreach(var_5 in var_2[var_1]) {
      var_6 = var_5[0];
      var_7 = var_5[1];
      var_8 = easepower("_encstr_9B6512802B78F73340D0E24BFEAE8B6FF0B50F1E", var_6, var_7);
      var_3[var_3.size] = var_8;
    }
  }

  var_0 = scripts\engine\utility::array_combine(var_0, var_3);
  return var_0;
}

init_vo_arrays(var_0, var_1, var_2) {
  var_0.origin = var_1;
  var_0.angles = var_2;
  return var_0;
}

setupgoalvisualsforjugg(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\utility\teams::getenemyteams(var_1);
  var_3 = var_2[0];
  var_4 = level.rugby.goals[var_3];
  var_4 thread updatechevrons(var_3);
  var_5 = level.rugby.goals[var_1];
  var_5 thread updatechevrons("_encstr_BA19049F4B2D");
}

watchforjuggproximityscore(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A6C81359CD91F4BD37957D322BC2C63AA5672CD1AC");

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(isDefined(var_1.rugbyjugginfo) && var_1.team != var_0) {
      onjuggproximityscore(var_1);
      return;
    }
  }
}

activatenewjuggernaut(var_0) {
  var_1 = level.rugby;
  var_2 = setupplayerasjugg(var_0);

  if(!var_2)
    return 0;

  var_3 = spawnStruct();
  var_3.player = var_0;
  var_4 = var_0 getentitynumber();
  var_3.id = var_4;
  var_1.activejuggernauts[var_4] = var_0;
  level._id_12DD4 = var_0;
  var_0.rugbyjugginfo = var_3;
  createobjectiveiconsforactivejugg(var_0, var_3);
  startjugghud(var_0);
  setupgoalvisualsforjugg(var_0);
  var_0 thread watchjugghealth();
  var_0 thread watchforjuggdeathdisconnect();
  var_0 thread watchjuggprogress();
  var_0 thread watchteammatesnearjugg();

  if(getjuggtimeout() > 0)
    var_0 thread watchjuggtimeout();

  var_0 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_ABD80F1B938CCB18B18D3D17D720231724", "_encstr_9119045F7272");
  var_0 thread scripts\mp\hud_message::showsplash("_encstr_A6B10C8230EF8738E899F99B3DBD");
  var_5 = [var_0];
  var_6 = scripts\mp\utility\game::getotherteam(var_0.team)[0];
  scripts\mp\utility\dialog::statusdialog("_encstr_B1D013C95DB313E57D372B36EA27AC23AF9AAECE3B", var_0.team, "_encstr_9119045F7272", var_5);
  scripts\mp\utility\dialog::statusdialog("_encstr_AC6B10F84BA2AD689F79155BC59FCB835C4F", var_6, "_encstr_9119045F7272");
  level thread _id_12451(var_0.team, var_6);

  foreach(var_8 in level.players) {
    if(var_8.team == var_0.team) {
      if(var_8 != var_0)
        var_8 thread scripts\mp\hud_message::showsplash("_encstr_93CA0E6B6829AF391767C2FB551D5274");

      continue;
    }

    var_8 thread scripts\mp\hud_message::showsplash("_encstr_85090A93D384426F48C8C20B");
  }

  return 1;
}

_id_12451(var_0, var_1) {
  wait 3;
  scripts\mp\utility\dialog::statusdialog("_encstr_8DE813522D8242722147E679696AE1E28B502E3162", var_0);
  scripts\mp\utility\dialog::statusdialog("_encstr_8C4F15395D3BC4F2EBB74E8CB2E4BE33B01B6398581B5B", var_1);
}

deactivatejuggernaut(var_0) {
  var_1 = level.rugby;
  var_2 = var_0.rugbyjugginfo;

  if(isDefined(var_0))
    var_0.rugbyjugginfo = undefined;

  var_1.activejuggernauts[var_2.id] = undefined;
  level._id_12DD4 = undefined;
  cleanupobjectiveiconsforjugg(var_0, var_2);
  clearjugghud();

  foreach(var_4 in var_1.endzones)
  var_4[0] thread updatechevrons("_encstr_A7C5056BD931D1");

  level.rugby.maxperkbonustier = undefined;
  level.rugby._id_128BF = undefined;
  level.rugby.vehicle_occupancy_isfriendlytoplayer = undefined;
  level.rugby.vehicle_occupancy_isenemytoteam = undefined;

  if(isDefined(var_0) && isDefined(var_0.team))
    level thread scripts\mp\hud_message::notifyteam("_encstr_91600D12531F5FC95C571F66C94866", "_encstr_83600D858722E4A104BD83B8A9EDE0", var_0.team);
  else
    level thread scripts\mp\hud_message::notifyteam("_encstr_96860D9ABA9D3BEB8D0BE0E85739AC", "_encstr_96860D9ABA9D3BEB8D0BE0E85739AC", "_encstr_9A8507BA4040188D08");

  setomnvar("_encstr_924514CB49C988AD8F2A2A16523F6CE811CC7B43EDEA", 0);
  setomnvar("_encstr_ABEE151308FFA2EFD91E517F22A39F2F5748DAFAE05B9D", 0);
  var_0 notify("_encstr_863B0FAD9F3A7E9807C4CB81AFDFA0A0E2");
}

startjugghud(var_0) {
  setomnvar("_encstr_BD951515B399FABFDC39EB71C02D3F77410FB481337803", var_0);
  setomnvar("_encstr_ADD215F5FB19558D0F5858884ABB4774E198C31B0CF32B", 1.0);

  foreach(var_2 in level.players)
  var_2 setclientomnvar("_encstr_92C3175D2D7D275DD9C42FEB53AEECCEFA33C94B569B8C632F", scripts\engine\utility::ter_op(var_2.team == var_0.team, 0, 1));
}

clearjugghud() {
  setomnvar("_encstr_BD951515B399FABFDC39EB71C02D3F77410FB481337803", undefined);

  foreach(var_1 in level.players)
  var_1 setclientomnvar("_encstr_92C3175D2D7D275DD9C42FEB53AEECCEFA33C94B569B8C632F", -1);
}

watchjugghealth() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_863B0FAD9F3A7E9807C4CB81AFDFA0A0E2");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F");
    setomnvar("_encstr_ADD215F5FB19558D0F5858884ABB4774E198C31B0CF32B", self.health / self.maxhealth);
  }
}

watchforjuggdeathdisconnect() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_863B0FAD9F3A7E9807C4CB81AFDFA0A0E2");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 = undefined;

  if(!isDefined(self))
    var_0 = level.lastjuggpositions[self.rugbyjugginfo.id];
  else
    var_0 = self.origin;

  var_1 = getnodesinradius(var_0, 32, 0, 32);
  var_2 = getclosestpointonnavmesh(var_0);

  if(distance(var_0, var_2) > 50)
    var_2 = var_0;

  var_2 = var_0;
  activatejuggcrate(var_2 + (0, 0, 0), (0, 0, 0));
  deactivatejuggernaut(self);
}

watchjuggprogress() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_863B0FAD9F3A7E9807C4CB81AFDFA0A0E2");
  var_0 = self.team;
  var_1 = scripts\mp\utility\teams::getenemyteams(var_0);
  var_2 = var_1[0];
  var_3 = level.rugby.goals[var_0];
  var_4 = level.rugby.goals[var_2];
  var_5 = var_4.origin - var_3.origin;
  var_6 = vectordot(var_5, var_5);
  var_7 = undefined;

  for(;;) {
    var_8 = self.origin * (1, 1, 0) - var_3.origin * (1, 1, 0);
    var_9 = vectordot(var_5, var_8) / var_6;
    var_9 = clamp(var_9, 0.0, 1.0);
    var_10 = [];
    var_10[var_0] = var_9;
    var_10[var_2] = 1.0 - var_9;

    foreach(var_12 in level.players) {
      if(var_12.team == var_0 || var_12.team == var_2)
        var_12 setclientomnvar("_encstr_BE3817AE4BF539ABEC98BCF55357ECECBE834EBDB39C596E37", var_10[var_12.team]);
    }

    if(var_9 > 0.8)
      level thread getquestunlockableindexfromlootid(var_9, var_0, var_2);

    if(isDefined(level._id_12DD4)) {
      if(!isDefined(var_7))
        var_7 = var_9;

      if(var_9 > var_7 + 0.1) {
        var_7 = var_9;
        level._id_12DD4 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B1CB0FD6856FB90B29F21840E93ADB53EB");
      }
    }

    level.lastjuggpositions[self.rugbyjugginfo.id] = self.origin;
    wait 0.05;
  }
}

getquestunlockableindexfromlootid(var_0, var_1, var_2) {
  if(!isDefined(level.rugby.maxperkbonustier)) {
    level.rugby.maxperkbonustier = 1;
    level.rugby._id_128BF = gettime();
    level.rugby.vehicle_occupancy_isfriendlytoplayer = var_0;
    level.rugby.vehicle_occupancy_isenemytoteam = var_0;
  } else if(isDefined(level.rugby._id_128BF) && level.rugby._id_128BF + 30000 < gettime()) {
    level.rugby.maxperkbonustier = 1;
    level.rugby._id_128BF = gettime();
    level.rugby.vehicle_occupancy_isfriendlytoplayer = var_0;
    level.rugby.vehicle_occupancy_isenemytoteam = var_0;
  }

  if(istrue(level.rugby.maxperkbonustier)) {
    scripts\mp\utility\dialog::statusdialog("_encstr_8DC01AAAA38CE5CAF1826B33DA7834712F97CB3310535209D1E72BAD", var_1, "_encstr_9119045F7272");
    scripts\mp\utility\dialog::statusdialog("_encstr_B13E177AE33096F7B8B1C27A9883378E63AFF3F51F881D5FD9", var_2, "_encstr_9119045F7272");
    thread scripts\mp\music_and_dialog::timelimitmusic(var_1);
  }

  level.rugby.maxperkbonustier = 0;
}

setupplayerasjugg(var_0) {
  var_1 = level.rugby.juggconfig;
  var_2 = var_0 scripts\mp\juggernaut::jugg_makejuggernaut(var_1);

  if(!var_2)
    return 0;

  var_0.droppeddeathweapon = 1;
  var_0 givemaxammo(var_0.classstruct.loadoutprimaryobject);
  var_0.playerstreakspeedscale = getjuggspeedscalar(0);
  var_0 scripts\mp\weapons::updatemovespeedscale();
  var_0 thread handlejuggjumpspam();
  var_3 = scripts\mp\utility\teams::getenemyteams(var_0.team);
  var_4 = var_3[0];
  return 1;
}

watchteammatesnearjugg() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_863B0FAD9F3A7E9807C4CB81AFDFA0A0E2");

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(var_2.team != self.team || var_2 == self) {
        continue;
      }
      if(distancesquared(var_2.origin, self.origin) < 122500)
        var_0++;
    }

    self.playerstreakspeedscale = getjuggspeedscalar(var_0);
    scripts\mp\weapons::updatemovespeedscale();
    wait 0.1;
  }
}

watchjuggtimeout() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_954013DC8EBD83F5E4ABD9265EBE3AD2DA2BB7D53A");
  self endon("_encstr_863B0FAD9F3A7E9807C4CB81AFDFA0A0E2");
  _id_13167();
  level thread _id_12E18(self);
  wait(getjuggtimeout());
  setomnvar("_encstr_924514CB49C988AD8F2A2A16523F6CE811CC7B43EDEA", 0);
  setomnvar("_encstr_ABEE151308FFA2EFD91E517F22A39F2F5748DAFAE05B9D", 0);
  self suicide();
}

_id_12E18(var_0) {
  level endon("_encstr_954013DC8EBD83F5E4ABD9265EBE3AD2DA2BB7D53A");
  var_0 endon("_encstr_863B0FAD9F3A7E9807C4CB81AFDFA0A0E2");
  var_1 = getdvarfloat("_encstr_96AA1637B139FAC9BA7689CB7D4DBACE3B452DB5B2BDEAD1");
  var_2 = var_1;

  while(!istrue(level.canprocessot)) {
    setomnvar("_encstr_ABEE151308FFA2EFD91E517F22A39F2F5748DAFAE05B9D", var_2 / var_1);
    var_2 = var_2 - level.framedurationseconds;
    wait(level.framedurationseconds);
  }
}

handlejuggjumpspam() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_863B0FAD9F3A7E9807C4CB81AFDFA0A0E2");
  self notifyonplayercommand("_encstr_A7A30CA9EAD9D9EB4DABDA835923", "_encstr_B44609DFE7078F394E1651");

  for(;;) {
    self waittill("_encstr_A7A30CA9EAD9D9EB4DABDA835923");

    while(!self isonground())
      waitframe();

    var_0 = self getvelocity();
    var_1 = (var_0[0] * 0.25, var_0[1] * 0.25, var_0[2]);
    self setvelocity(var_1);
    self.overrideweaponspeed_speedscale = 0.2;
    scripts\mp\weapons::updatemovespeedscale();

    for(;;) {
      var_2 = scripts\engine\utility::_id_143B9(1, "_encstr_A7A30CA9EAD9D9EB4DABDA835923");

      if(var_2 == "_encstr_A7A30CA9EAD9D9EB4DABDA835923") {
        while(!self isonground())
          waitframe();

        var_0 = self getvelocity();
        var_1 = (var_0[0] * 0.25, var_0[1] * 0.25, var_0[2]);
        self setvelocity(var_1);
        continue;
      }

      break;
    }

    self.overrideweaponspeed_speedscale = undefined;
  }
}

_id_12C4B() {
  var_0 = 0;
  level.vehicle_occupancy_isfriendlytoteam = spawnStruct();
  level.vehicle_occupancy_isfriendlytoteam.objidnum = scripts\mp\objidpoolmanager::requestreservedid(var_0);
}

createobjectiveiconsforactivejugg(var_0, var_1) {
  createjuggobjective(var_0, var_1);
  var_2 = scripts\mp\utility\teams::getenemyteams(var_0.team);
  var_3 = var_2[0];
  var_4 = level.rugby.goals[var_3];
  createendzoneobjective(var_4, var_3, var_1);
}

cleanupobjectiveiconsforjugg(var_0, var_1) {
  scripts\mp\objidpoolmanager::update_objective_state(0, "_encstr_8267056410C669");
  scripts\mp\objidpoolmanager::returnobjectiveid(var_1.endzoneobjid);
}

createjuggobjective(var_0, var_1) {
  var_2 = 0;
  var_1.juggobjid = var_2;
  scripts\mp\objidpoolmanager::objective_add_objective(var_2, "_encstr_AF5A081BBAC993AC73A3", var_0.origin, "_encstr_8DAD134CB9E2379017690B130F48C061D902C398AF");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var_2, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_2);
  scripts\mp\objidpoolmanager::update_objective_onentity(var_2, var_0);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(var_2, 90);
  objective_setownerteam(var_2, var_0.team);
  objective_setfriendlylabel(var_2, "_encstr_A99A1AC13817C4EF67287919C14F2D9E7E9A754C476F8D9F9E90E931");
  objective_setenemylabel(var_2, "_encstr_9B7718079180F86701B5C19AAFC1B271405DEFB71728C02929BC");
}

createendzoneobjective(var_0, var_1, var_2) {
  var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_2.endzoneobjid = var_3;
  scripts\mp\objidpoolmanager::objective_add_objective(var_3, "_encstr_AF5A081BBAC993AC73A3", var_0.origin, "_encstr_849A199B7E45E2172C4E6383E0FA20BBC90E4DF0768081822392A7");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_3, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var_3, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_3);
  objective_setownerteam(var_3, var_1);
  objective_setfriendlylabel(var_3, "_encstr_93311DA877D0B755A91BC7F203892EAF404D10405E80031F99F1D5EE4BA9E7");
  objective_setenemylabel(var_3, "_encstr_97071EA928FAA97A8851F5A4AA8E12565E5193112D3D27547D289A9A82AA9851");
}

activatejuggcrate(var_0, var_1, var_2) {
  var_3 = level.rugby;

  if(!vandalize_attack_min_cooldown(var_0)) {
    var_0 = level.init_ai_kill_params_for_events;
    var_1 = level.init_ai;
  }

  var_4 = createjuggcrate(var_0, var_1, var_2);
  var_3.activejuggcrates[0] = var_4;
  var_3.activejuggcrates[0].crateid = var_4;
  return 1;
}

vandalize_attack_min_cooldown(var_0) {
  var_1 = 1;

  foreach(var_3 in level.trial_target_headshot_func) {
    if(ispointinvolume(var_0, var_3)) {
      var_1 = 0;
      break;
    }
  }

  return var_1;
}

createjuggcrate(var_0, var_1, var_2) {
  var_3 = getgroundposition(var_0, 8, 2000, 32);
  var_3 = var_3 + (0, 0, 5);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_3);
  var_4.angles = var_1;
  var_4.visuals = [var_4];
  var_4.trigger = var_4;
  var_4.trigger.origin = var_4.origin;
  var_4.curorigin = var_4.trigger.origin;
  var_4.safeorigin = var_4.trigger.origin;
  var_4.visuals[0] setModel("_encstr_B62620D65A1B5A4758275EEB1B0B3956E0C28DDA2C762BAF0CC87DE4BA831D57C9AC");
  var_4 thread scripts\mp\gameobjects::setdropped();
  var_4.crateid = var_4 getentitynumber();
  var_4 thread juggcratemanageuse(var_4);

  if(istrue(var_2)) {
    level.init_ai_kill_params_for_events = var_0;
    level.init_ai = var_1;

    foreach(var_6 in level.teamnamelist)
    scripts\mp\utility\dialog::statusdialog("_encstr_847B13A8EF5F79C3D9FEAF2F13531D41BF7B68883F", var_6, "_encstr_9119045F7272");
  }

  return var_4;
}

gunkillerhackthread() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 = getweaponarray();

    foreach(var_2 in var_0) {
      if(distance2dsquared(var_2.origin, self.origin) < 40000)
        var_2 delete();
    }

    wait 0.25;
  }
}

juggcratemanageuse(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 30));
  var_1.usetype = 1;
  var_1.destination = self.origin + (0, 0, 30);
  var_1.vampirepoints = 1;
  self._id_14074 = scripts\mp\gameobjects::createholduseobject("_encstr_A7A408B9CA5D1D4E2C63", var_1, self.visuals, (0, 0, 64));

  foreach(var_3 in level.teamnamelist)
  self._id_14074.teamprogress = undefined;

  self._id_14074.trigger._id_1408A = 16900;
  self._id_14074.trigger setuserange(130);
  self._id_14074.trigger setHintString(&"_encstr_9B41183541D7A67A882AEB25558E90AC79349228A22AD755A615");
  self._id_14074.trigger makeusable();
  self._id_14074.trigger setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  self._id_14074.trigger setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
  self._id_14074.trigger setusehideprogressbar(1);
  self._id_14074.trigger setusepriority(-3);
  self._id_14074.trigger sethintonobstruction("_encstr_BECC055CF3811A");
  self._id_14074 scripts\mp\gameobjects::setusetime(remove_spawn_disable_struct());
  self._id_14074.interactteam = "_encstr_9A19040BCDBC";
  self._id_14074.curprogress = 0;
  self._id_14074.defaultusetime = self._id_14074._id_1409E;
  self._id_14074.userate = 1;
  self._id_14074.id = "_encstr_8DF90B33B8DF96EFEECA8D9754";
  self._id_14074.exclusiveuse = 0;
  self._id_14074.exclusiveclaim = 0;
  self._id_14074.skiptouching = 1;
  self._id_14074.onbeginuse = ::_id_12DD1;
  self._id_14074.onuse = ::_id_12DD0;
  self._id_14074.onenduse = ::_id_12DD2;
  self._id_14074.oncantuse = ::_id_12DD3;
  self._id_14074.inuse = 0;

  foreach(var_6 in level.teamnamelist) {
    self._id_14074.numtouching[var_6] = 0;
    self._id_14074.touchlist[var_6] = [];
  }

  self._id_14074.cancontestclaim = 0;
  self._id_14074.stalemate = 0;
  self._id_14074.wasstalemate = 0;
  self._id_14074.cancontestclaim = 0;
  self._id_14074.majoritycapprogress = 1;
  self._id_14074.wasmajoritycapprogress = 0;
  self._id_14074.resetprogress = 1;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9");

  self._id_14074.type = "_encstr_8CC00AABB9599E984D2BD81D";
  self._id_14074.offset3d = (0, 0, 32);
  self._id_14074 scripts\mp\gameobjects::requestid(1, 1);
  self._id_14074 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_B22E196812FDF5C6EF59837F3FFFA899A92A3090CA1927BB8F5485");
  self._id_14074 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
  scripts\mp\objidpoolmanager::objective_set_play_intro(self._id_14074.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self._id_14074.objidnum, 0);
}

_id_12DD1(var_0) {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_AAFE1522A86F35D74B2FE1E03050CB7BE7E82A9A50D52F", "_encstr_AB75152DF7376A01773FA39F7734B044087B42066CDD4A");
  scripts\mp\utility\dialog::statusdialog("_encstr_9A331408CB47658AD7C3050EBD1BF0352FF14088429F", var_0.team, "_encstr_9119045F7272");
  self.visuals[0] playLoopSound("_encstr_82AC1E0553A13B4276833FFBF396AA713859314D28C0FF7ACCBDDFFBA74EF2B8");
}

_id_12DD0(var_0) {
  var_1 = activatenewjuggernaut(var_0);

  if(!var_1) {
    return;
  }
  juggcratecleanup();
  level.rugby.activejuggcrates[0].crateid = undefined;
  level.rugby.activejuggcrates[0] = undefined;

  if(isDefined(self._id_14074))
    self._id_14074 delete();

  if(isDefined(self.visuals)) {
    foreach(var_3 in self.visuals)
    var_3 delete();
  }

  if(isDefined(self.trigger))
    self.trigger delete();
}

_id_12DD2(var_0, var_1, var_2) {
  self.visuals[0] stoploopsound("_encstr_82AC1E0553A13B4276833FFBF396AA713859314D28C0FF7ACCBDDFFBA74EF2B8");

  if(!var_2)
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_B22E196812FDF5C6EF59837F3FFFA899A92A3090CA1927BB8F5485");

  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_1.team);
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);

  if(self.curprogress > 0)
    scripts\mp\objidpoolmanager::objective_show_team_progress(self.objidnum, var_1.team);
  else
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
}

_id_12DD3(var_0) {}

juggcratecleanup() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);
}

createjuggcrateobjective(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  var_0.objid = var_1;
  var_2 = var_0.origin + (0, 0, 32);
  scripts\mp\objidpoolmanager::objective_add_objective(var_1, "_encstr_AF5A081BBAC993AC73A3", var_2, "_encstr_8DAD134CB9E2379017690B130F48C061D902C398AF");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_1, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(var_1, 0);
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_1);
  objective_setneutrallabel(var_1, "_encstr_A2CA1C6A14BEA99E2215F594AA7412ACCB0D258215A2F5D00541A2AA292A");
  objective_setfriendlylabel(var_1, "_encstr_8E441E350ABE53A788547D25553A90B279D0A4508A54AF0D82A02A55259493A3");
  objective_setenemylabel(var_1, "_encstr_96F51B31C8E7343FB7F84929911F5DCE4E4326BF6457BEF1ADA1E1B1A8");
  updatejuggcrateobjectivestate(var_0);
}

updatejuggcrateobjectivestate(var_0) {
  var_1 = var_0.objid;
  var_2 = istrue(var_0.inuse);

  if(var_2) {
    objective_setownerteam(var_1, var_0.usingplayer.team);
    objective_sethot(var_1, 1);
  } else {
    objective_setownerteam(var_1, undefined);
    objective_sethot(var_1, 0);
  }
}

get_circle_back_start_node(var_0) {
  var_1 = level.rugby.juggconfig;

  if(istrue(var_0.isjuggernaut)) {
    var_0 scripts\mp\hud_message::showerrormessage("_encstr_A9C1255A923189D445A45405D2D4E594AA1D1DFA0D05E439A72AEB8454D7A0A40D691522AFAA0A");
    return 0;
  }

  var_2 = var_0 scripts\mp\juggernaut::vehicle_damage_setweaponhitdamagedata(var_1);

  if(!isDefined(var_2)) {
    var_0 scripts\mp\hud_message::showerrormessage("_encstr_8BB91F91EF844C67F9220D074CA1D734257F69B93F61C46510DB18BED758CF9C5D");
    return 0;
  }

  return 1;
}

updateoverheadcamerapos(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0;
    var_2 = level.spectatorcameras[0][var_1];
  } else {
    var_1 = self.team;
    var_2 = level.spectatorcameras[0][self.team];
  }

  var_3 = level.rugby;
  var_4 = undefined;

  if(!istrue(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    var_4 = var_1;
  else
    var_4 = scripts\engine\utility::ter_op(var_1 == "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");

  var_5 = scripts\engine\utility::ter_op(var_4 == "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A", "_encstr_9A8507BA4040188D08");
  var_6 = var_3.endzones[var_4][0].origin;
  var_7 = var_3.endzones[var_5][0].origin;
  var_8 = (var_7 - var_6) * (1, 1, 0);
  var_9 = length2d(var_8);
  var_10 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var_10))
    var_11 = var_10.origin[2];
  else
    var_11 = 5000;

  var_12 = undefined;
  var_13 = undefined;

  if(doesteamhaveactivejugg(var_1)) {
    var_14 = getjuggorcratepos();
    var_12 = var_14 + var_8 * (-3000 / var_9);
    var_12 = (var_12[0], var_12[1], var_11);
    var_13 = var_14 + (var_7 - var_14) * 0.5;
  } else {
    var_12 = var_6 + var_8 * (-2000 / var_9);
    var_12 = (var_12[0], var_12[1], var_11);
    var_13 = getjuggorcratepos();
  }

  var_15 = var_13 - var_12;
  var_16 = vectortoangles(var_15);
  var_2.origin = var_12;
  var_2.angles = var_16;
}

startspectatorview() {
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
  waitframe();
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  scripts\mp\spectating::setdisabled();

  if(isDefined(self.lastdeathangles))
    self setplayerangles(self.lastdeathangles);

  wait 0.1;
  scripts\mp\utility\player::setdof_default();
  updateoverheadcamerapos();
  var_0 = level.spectatorcameras[0][self.team];
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  self.deathspectatepos = var_1;
  self.deathspectateangles = var_2;
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self getvieworigin());
  var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_3.angles = var_2;
  self.spectatorcament = var_3;
  self.isusingtacopsmapcamera = 1;
  self cameralinkTo(var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  thread dohalfwayflash();
  var_3 movecameratomappos(self, var_1, var_2);
}

dohalfwayflash() {
  wait 0.4;
  thread playslamzoomflash();
  applythermal();
}

endspectatorview() {
  if(!isDefined(self.spectatorcament)) {
    return;
  }
  removethermal();
  removeplayeroutlinesforoverheadcam();
  thread runslamzoomonspawn();
}

applythermal() {
  self visionsetthermalforplayer("_encstr_B60A15ABAB38AB4AE13741AE77D9F75F8D4AC4EE815F1A");
  self thermalvisionon();
}

removethermal() {
  self thermalvisionoff();
}

movecameratomappos(var_0, var_1, var_2) {
  var_0 endon("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_3 = 1.0;
  var_4 = 1.0;
  self moveTo(var_1, 1.0, 0.5, 0.5);
  var_0 playlocalsound("_encstr_8867179032B9E625040796C93205D5E02FFAA21721E86F3D6B");
  var_0 setclienttriggeraudiozonepartialwithfade("_encstr_AC230AABDAA970F821572333", 0.5, "_encstr_AB1904853B28");
  self rotateTo(var_2, 1.0, 0.5, 0.5);
  wait 1.1;
  var_5 = anglesToForward(var_2) * 300;
  var_5 = var_5 * (1, 1, 0);

  if(isDefined(var_0) && isDefined(var_0.spectatorcament)) {
    self moveTo(var_1 + var_5, 15.0, 1.0, 1.0);
    var_0 earthquakeforplayer(0.03, 15.0, var_1 + var_5, 1000);
  }
}

runslamzoomonspawn() {
  self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::updatesessionstate("_encstr_AF8C0A1B6A1D6045925B4F7D");
  self cameralinkTo(self.spectatorcament, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", 1);
  self visionsetnakedforplayer("_encstr_9A591141C97E59285BA366EBBAF7D188952FEB", 0.2);
  self.spectatorcament moveTo(var_0, 0.5);
  self playlocalsound("_encstr_A39D1618AAE7A00982B7171B57BACE084F80C0D0153F38B0");
  self clearclienttriggeraudiozone(0.5);
  self.spectatorcament rotateTo(var_1, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("_encstr_B40101", 0);
  thread playslamzoomflash();
  scripts\mp\utility\player::updatesessionstate("_encstr_877508C1D8C22F2DDC3B");
  self cameraunlink();
  self.spectatorcament delete();
  wait 1.0;
}

playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "_encstr_A5AD056A019C63";
  var_0.aligny = "_encstr_AC190479FF92";
  var_0.sort = 1;
  var_0.horzalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.vertalign = "_encstr_9A940B9FAB606CCB46157F7705";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("_encstr_998806DD1A96D12B", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0.0;
  wait 0.4;
  var_0 destroy();
}

enableplayeroutlinesforoverheadcam() {
  self.rugbyoverheadoutlines = [];

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }
    var_2 = scripts\engine\utility::ter_op(var_1.team == self.team, "_encstr_A7DA197F2B857AD1C0013FC418E8DF92D091DFFBC123F19310E935", "_encstr_AA2E1BE85B7C68BBF28FEDFB83FAE8200F77D18383D83960CB87C5FFDF");
    var_3 = scripts\mp\utility\outline::outlineenableforplayer(var_1, self, var_2, "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
    self.rugbyoverheadoutlines[var_3] = var_1;
  }
}

removeplayeroutlinesforoverheadcam() {
  if(isDefined(self.rugbyoverheadoutlines)) {
    foreach(var_2, var_1 in self.rugbyoverheadoutlines)
    scripts\mp\utility\outline::outlinedisable(var_2, var_1);

    self.rugbyoverheadoutlines = undefined;
  }
}

setupwaypointicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_B22E196812FDF5C6EF59837F3FFFA899A92A3090CA1927BB8F5485", 0, "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A2CA1C6A14BEA99E2215F594AA7412ACCB0D258215A2F5D00541A2AA292A", "_encstr_8DAD134CB9E2379017690B130F48C061D902C398AF", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8DAD134CB9E2379017690B130F48C061D902C398AF", 1, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_A9D31F47930EB139D77635ABC658F021B92F1F7D34AF838F9BAF8901F14FE0FBDB", "_encstr_8DAD134CB9E2379017690B130F48C061D902C398AF", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8DAD134CB9E2379017690B130F48C061D902C398AF", 1, "_encstr_88BF06FD784A6393", "_encstr_AF7B1D912177CB2065791DD5B8014630F16AE4853211A0D319E1D61FFE291E", "_encstr_8DAD134CB9E2379017690B130F48C061D902C398AF", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_8DC0186CC288FD0EFBF247BF7A983E7DB7F9D9FF484562AAF0EC", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_93311DA877D0B755A91BC7F203892EAF404D10405E80031F99F1D5EE4BA9E7", "_encstr_849A199B7E45E2172C4E6383E0FA20BBC90E4DF0768081822392A7", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_A34018D3BE92BDB62FD780C08759E8F1F9E4577096FB41B9E3C7", 0, "_encstr_88BF06FD784A6393", "_encstr_97071EA928FAA97A8851F5A4AA8E12565E5193112D3D27547D289A9A82AA9851", "_encstr_849A199B7E45E2172C4E6383E0FA20BBC90E4DF0768081822392A7", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AAFE1522A86F35D74B2FE1E03050CB7BE7E82A9A50D52F", 0, "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", "_encstr_8DAD134CB9E2379017690B130F48C061D902C398AF", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("_encstr_AB75152DF7376A01773FA39F7734B044087B42066CDD4A", 0, "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", "_encstr_8DAD134CB9E2379017690B130F48C061D902C398AF", 0);
}