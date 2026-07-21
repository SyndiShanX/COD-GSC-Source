/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\siege.gsc
***********************************************/

main() {
  if(getDvar("_encstr_9570084B1793A090CDFF") == "_encstr_8D510E52E3A7C6985EB7B9BE2F35C690") {
    return;
  }
  level.unset_relic_lfo = 0;
  var_0 = getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7") && !getdvarint("_encstr_93390B136AA2628AA8A93529D4");

  if(var_0)
    level.unset_relic_lfo = getdvarint("_encstr_B4B2193736E4EBCDD2CACE59EBCE27ED577391EE0B4E4D9695CE56", 0);

  level.brking_createc130pathstruct = [];

  if(level.unset_relic_lfo)
    level.brking_createc130pathstruct[level.brking_createc130pathstruct.size] = "_encstr_B81904B04E6B";

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_1[0] = scripts\mp\utility\game::getgametype();
  var_1[1] = "_encstr_8218041DF5FA";

  if(istrue(level.unset_relic_lfo))
    var_1[var_1.size] = "_encstr_B81904B04E6B";

  scripts\mp\gameobjects::main(var_1);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registerroundswitchdvar(scripts\mp\utility\game::getgametype(), 3, 0, 12);
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::registerscorelimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 4);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerwinbytwoenableddvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinbytwomaxroundsdvar(scripts\mp\utility\game::getgametype(), 4);
  }

  updategametypedvars();
  level.objectivebased = 1;
  level.teambased = 1;
  level.nobuddyspawns = 1;
  level.gamehasstarted = 0;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.onplayerdisconnect = ::onplayerdisconnect;
  level.onplayerjointeam = ::onplayerjointeam;
  level.getspawnpoint = ::getspawnpoint;
  level.modeonspawnplayer = ::onspawnplayer;
  level.onplayerkilled = ::onplayerkilled;
  level.ondeadevent = ::ondeadevent;
  level.ononeleftevent = ::ononeleftevent;
  level.ontimelimit = ::ontimelimit;
  level.lastcaptime = gettime();
  level.alliesprevflagcount = 0;
  level.axisprevflagcount = 0;
  level.allowlatecomers = 0;
  level.gametimerbeeps = 0;
  level.rushtimerteam = "_encstr_8BBA05185F8B99";
  level.siegeflagcapturing = [];

  if(level.unset_relic_lfo) {
    level._id_12C49 = 1;
    level.requiredplayercount["_encstr_9A8507BA4040188D08"] = 12;
    level.requiredplayercount["_encstr_8E8405EA382B2A"] = 12;
    level.modecontrolledvehiclespawningonly = 1;
    level.maxhqtanks = 0;
    level._id_11F41 = getdvarint("_encstr_92151EA397D391D313B5722AE10E9320DC5730F9E2390A63A9C15990F9C58DCF", 25);
    level._id_133DF = 1;
    level.loadoutdefaultfiresalediscount = 1;
    var_2 = scripts\cp_mp\utility\game_utility::getmapname();

    switch (var_2) {
      case "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE":
      case "_encstr_876510B60EF583E4B76B2BB9851995BED9BB":
      case "_encstr_81060EEA3847D0DBBAD5EB771EEF11BF":
      case "_encstr_831E0F7F2968E2AFC819F0FED3B0D70AD4":
      case "_encstr_BA3F0A7D37E6935EE590C3CF":
      case "_encstr_AC880C67503EA82A05DD62214CE7":
      case "_encstr_93D20D28714743B99070632BAF3944":
      case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
      case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
        scripts\cp_mp\parachute::initparachutedvars();
        break;
      default:
        break;
    }

    if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      switch (var_2) {
        case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
          setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 6);
          break;
        case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
          setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 5);
          break;
        case "_encstr_BA3F0A7D37E6935EE590C3CF":
        case "_encstr_93D20D28714743B99070632BAF3944":
          setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 9);
          break;
        case "_encstr_AC880C67503EA82A05DD62214CE7":
          setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 3);
          break;
        case "_encstr_831E0F7F2968E2AFC819F0FED3B0D70AD4":
          setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 4);
          break;
        case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
          setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 17);
          break;
        case "_encstr_876510B60EF583E4B76B2BB9851995BED9BB":
          setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 18);
          break;
        case "_encstr_81060EEA3847D0DBBAD5EB771EEF11BF":
          setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 10);
          break;
        case "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE":
          setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 19);
          break;
        default:
          setDvar("_encstr_A1940DCB06FBCFB577B88A52A01367", 0);
      }
    }
  }

  game["_encstr_AD3F0EB158739AC6EDE456F43751B495"] = 1;
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_AF430FF92745BF0BBFA2450722732A87AB";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];
  else if(getdvarint("_encstr_82570B397A4D3192935192A562"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_979708CC69F02253FF26" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_AD940C7B2F58DB9C19B38C972990";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_AD940C7B2F58DB9C19B38C972990";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_AD940C7B2F58DB9C19B38C972990";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7270B37CAC6BA4E96CD76BE2C"] = "_encstr_A7270B37CAC6BA4E96CD76BE2C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AB270BF3CD11AFEAA31812A940"] = "_encstr_AB270BF3CD11AFEAA31812A940";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99270B0B3F0BC056E2C34F371F"] = "_encstr_99270B0B3F0BC056E2C34F371F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7010A03FD5FFFE3521A09C8"] = "_encstr_BD3009CD56B1AB9356BE85";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9B010A0FFD30CD6AE50956EB"] = "_encstr_BE3009909F6BABE5AA21DE";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_99010A734743881E7AA38787"] = "_encstr_9230098783F6133210DEF6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9BDC098D7BCD96DC76FA2C"] = "_encstr_9BDC098D7BCD96DC76FA2C";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83DC0901B70A98F85731F1"] = "_encstr_83DC0901B70A98F85731F1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BDC0955A0D021A28C87BF"] = "_encstr_8BDC0955A0D021A28C87BF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AD68071BF6B9A3BE0B"] = "_encstr_AD68071BF6B9A3BE0B";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_976807690FAFEBD7F6"] = "_encstr_976807690FAFEBD7F6";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AA68071BD0C3C4417F"] = "_encstr_AA68071BD0C3C4417F";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_966911714585885B197F3BE1DB43262B5C9113"] = "_encstr_8311176ED22B3BB2D756E656DABCD7C61638D1AEE456917D23";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8A7C145C8D088D7088502087026ED7C3F7D34AC14722"] = "_encstr_88751A3B9B6097C7F89143FAD9481B8D680FA3B101505BD39DC9A957";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2161036C2373A858DD2CEB2BED37B37B2B9"] = "_encstr_B2161036C2373A858DD2CEB2BED37B37B2B9";
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_870614637E8BC7CA688D02AD588A73AB330780D195A2", getmatchrulesdata("_encstr_8A6C0AB9D256CE95882CA30B", "_encstr_995F0A93AB3786A8A5DA5993"));
  setdynamicdvar("_encstr_88B21A786F92363F4297740D618B4BFBE02B2030DF4A0DCB0ABBF88D", getmatchrulesdata("_encstr_8A6C0AB9D256CE95882CA30B", "_encstr_8393106AF38004739380621B6DF9E73B7369"));
  setdynamicdvar("_encstr_84F91A687F82060F7287647D118B6189EA1F58F98F3B38899AAD6DFE", getmatchrulesdata("_encstr_8A6C0AB9D256CE95882CA30B", "_encstr_937A10E60D2CC99546A45D9BD0A24BD6954E"));
  setdynamicdvar("_encstr_B64C1753E01AB1937F0B3FF5A839FAB7678972C19DE2307567", getmatchrulesdata("_encstr_8A6C0AB9D256CE95882CA30B", "_encstr_82730D3B68514312E927CD4410D90B"));
  setdynamicdvar("_encstr_BAE1126E369CD737A52B76CA7DC62C38250B3ACA", getmatchrulesdata("_encstr_8A6C0AB9D256CE95882CA30B", "_encstr_86BA08808A8205897BD5"));
  setdynamicdvar("_encstr_8B6214CD3639FAE6D2599DB2F5DE8935356C58B1164E", getmatchrulesdata("_encstr_8A6C0AB9D256CE95882CA30B", "_encstr_86FA0ABD89A6D41B85630BC9"));
  setdynamicdvar("_encstr_B24317A3F9AEE742E863D7DD7F880D53DDD5CADAA78BE73FE8", getmatchrulesdata("_encstr_8A6C0AB9D256CE95882CA30B", "_encstr_8EF50D839F786CB031B1845C807562"));
  setdynamicdvar("_encstr_B6A4139BC627D7E6A5CACE59AF1A0B8D663A4BAD2B", 0);
  scripts\mp\utility\game::registerhalftimedvar("_encstr_A54F06D32A2F0498", 0);
}

seticonnames() {
  level.iconneutral = "_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1";
  level.iconcapture = "_encstr_859A1183D94B3B2548D56447E7202A93F5133A";
  level.icondefend = "_encstr_994B105B20DB3A9F30206457CD5973870DE0";
  level.icondefending = "_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30";
  level.iconcontested = "_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509";
  level.icontaking = "_encstr_B40710E36BBF4F179FCD9CC8C9B1F3836012";
  level.iconlosing = "_encstr_8202100F51F881C7C0F2255890A5865376FF";
}

onstartgametype() {
  seticonnames();

  if(!isDefined(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]))
    game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"] = 0;

  if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
    var_0 = game["_encstr_991C0AB9ED5B57161FE89B83"];
    var_1 = game["_encstr_B6A70A23CA6659DC91CAE4DC"];
    game["_encstr_991C0AB9ED5B57161FE89B83"] = var_1;
    game["_encstr_B6A70A23CA6659DC91CAE4DC"] = var_0;
  }

  foreach(var_3 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_3, &"_encstr_9B670F283D38CD76C3438B8DFF062DA7D5");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_9B670F283D38CD76C3438B8DFF062DA7D5");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_3, &"_encstr_964615086EAD9DA5BF6883B71B556D601C7F9141DFB9ED");

    scripts\mp\utility\game::setobjectivehinttext(var_3, &"_encstr_B404149E2125A8685125958A6A5E11D335F509299C2A");
  }

  thread waittooverridegraceperiod();

  if(level.unset_relic_lfo) {
    thread adjustroundendtimer();
    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::initspawns(isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] != 0);
    level thread _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::setupwaypointicons();
    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::debug_setupmatchdata();
    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::_id_1324D();
    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::calculatehqmidpoint();
    level._id_11F45 = getdvarint("_encstr_BAE2146E369CD737A52B76CA7DCC8DB0761BB7EACD8E", 3);
    setomnvar("_encstr_85511125C469453BFDF7A07BC737918952EF9E", level._id_11F45);
    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::setupobjectives();
    level thread runobjectives();
    thread _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::init_groundwarvehicles();
    thread trace_to_eye_weight();
    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::monitordriverexitbutton();
  } else {
    initspawns();
    thread domflags();
  }

  thread watchflagtimerpause();
  thread watchgamestart();

  if(scripts\mp\utility\game::matchmakinggame())
    thread watchgameinactive();
}

vehiclespawn_getspawndata(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_1.showheadicon = 1;
  return var_1;
}

registervehicletype(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.refname = var_0;
  var_3.spawncallback = var_2;
  var_3.vehiclespawns = [[var_1]]();
  level.vehicleinfo[var_0] = var_3;
}

trace_to_eye_weight() {
  level.numhqtanks_axis = 0;
  level.numhqtanks_allies = 0;

  if(!isDefined(level.vehicleinfo))
    level.vehicleinfo = [];

  registervehicletype("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", scripts\cp_mp\vehicles\little_bird::little_bird_getspawnstructscallback, ::vehiclespawn_littlebird);
  registervehicletype("_encstr_8C190467402B", scripts\cp_mp\vehicles\atv::atv_getspawnstructscallback, ::vehiclespawn_atv);
  registervehicletype("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", scripts\cp_mp\vehicles\cargo_truck::cargo_truck_getspawnstructscallback, ::vehiclespawn_cargotruck);
  registervehicletype("_encstr_85DE05A6B2AC0E", scripts\cp_mp\vehicles\jeep::jeep_getspawnstructscallback, ::vehiclespawn_jeep);
  registervehicletype("_encstr_9A120A1D8536F5E4ED3BB293", scripts\cp_mp\vehicles\tac_rover::tac_rover_getspawnstructscallback, ::vehiclespawn_tacrover);
  level.vehiclespawnlocs = [];

  foreach(var_1 in level.vehicleinfo) {
    switch (var_1.refname) {
      case "_encstr_9A8F0CB1A5E8471BB2EB894B39C8":
        var_1.vehiclespawns = rundrawprematchareas("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", "_encstr_96FB12BBCD3E1276801EF2FCF248A18A161F2743");
        break;
      case "_encstr_8C190467402B":
        var_1.vehiclespawns = rundrawprematchareas("_encstr_8C190467402B", "_encstr_9A981257491E559F356058E910276A60A359D570");
        break;
      case "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6":
        var_1.vehiclespawns = rundrawprematchareas("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", "_encstr_8D7B11F83FF98D57716243D3BACA972B679F98");
        break;
      case "_encstr_85DE05A6B2AC0E":
        var_1.vehiclespawns = rundrawprematchareas("_encstr_85DE05A6B2AC0E", "_encstr_8275116BD09168F2B7370C409EE30A3BBE08B3");
        break;
      case "_encstr_9A120A1D8536F5E4ED3BB293":
        var_1.vehiclespawns = rundrawprematchareas("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_B849127B4D1072C5E07E929C52E8016AF6FF87E3");
        break;
    }

    foreach(var_3 in var_1.vehiclespawns) {
      var_4 = level.vehiclespawnlocs.size;
      level.vehiclespawnlocs[var_4] = var_3;
      level.vehiclespawnlocs[var_4].refname = var_1.refname;
    }
  }

  if(0) {
    foreach(var_8 in level.vehiclespawnlocs)
    thread scripts\mp\utility\debug::drawline(var_8.origin, var_8.origin + (0, 0, 1500), 1000, (1, 0, 0));
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  var_10 = level._id_11F41;

  if(!isDefined(level._id_11F41))
    var_10 = 25;

  if(0) {
    for(var_11 = 0; var_11 < var_10; var_11++) {
      var_8 = level.vehiclespawnlocs[var_11];
      thread scripts\mp\utility\debug::drawline(var_8.origin + (0, 0, 1500), var_8.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(var_11 = 0; var_11 < var_10; var_11++) {
    var_8 = level.vehiclespawnlocs[var_11];

    if(isDefined(var_8)) {
      var_1 = level.vehicleinfo[var_8.refname];
      [[var_1.spawncallback]](var_8);
    }
  }
}

rundrawprematchareas(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\cp_mp\utility\game_utility::getmapname();
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];

  switch (var_3) {
    case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
      if(var_0 == "_encstr_8C190467402B") {
        var_4[var_4.size] = (21843.8, -4640.11, -476.961);
        var_4[var_4.size] = (20375.9, -3612.78, -454);
        var_4[var_4.size] = (20728.8, -3309.36, -456);
        var_5[var_5.size] = (0, 255, 0);
        var_5[var_5.size] = (0, 330, 0);
        var_5[var_5.size] = (0, 292, 0);
        var_4[var_4.size] = (20937.2, -9029.28, -379.674);
        var_4[var_4.size] = (23097.1, -9966.89, -344);
        var_5[var_5.size] = (356.825, 240, 0);
        var_5[var_5.size] = (0, 0, 0);
        var_4[var_4.size] = (17471, -23211.4, -204);
        var_4[var_4.size] = (15960.1, -22768.1, -204);
        var_4[var_4.size] = (15821.3, -23568, -208.461);
        var_5[var_5.size] = (0, 90, 0);
        var_5[var_5.size] = (0, 45, 0);
        var_5[var_5.size] = (0, 90, 0);
        var_4[var_4.size] = (22994.3, -15304.5, -216);
        var_5[var_5.size] = (0, 105, 0);
      } else if(var_0 == "_encstr_9A120A1D8536F5E4ED3BB293") {
        var_6[var_6.size] = (20120.2, -3287.71, -456);
        var_6[var_6.size] = (21339.9, -4787.55, -450.176);
        var_7[var_7.size] = (0, 345, 0);
        var_7[var_7.size] = (357.831, 255.032, -1.25312);
        var_6[var_6.size] = (17449, -22190.1, -208.116);
        var_6[var_6.size] = (16651.1, -22178.2, -207.908);
        var_7[var_7.size] = (0, 60, 0);
        var_7[var_7.size] = (0, 60, 0);
      }

      break;
    case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
      if(var_0 == "_encstr_8C190467402B") {
        var_4[var_4.size] = (26335.7, 30412.6, 655.471);
        var_4[var_4.size] = (27099.5, 30567.5, 639.236);
        var_4[var_4.size] = (27315.5, 30525.5, 639.236);
        var_5[var_5.size] = (0.0728273, 119, 0.843973);
        var_5[var_5.size] = (2.67817, 77.0718, 1.59551);
        var_5[var_5.size] = (2.67817, 77.0718, 1.59551);
        var_4[var_4.size] = (29610.4, 38228.5, 698.883);
        var_4[var_4.size] = (29465.5, 38973.6, 701);
        var_5[var_5.size] = (0, 315, 0);
        var_5[var_5.size] = (0, 88.9989, 0);
        var_4[var_4.size] = (39153, 46431.8, 932.749);
        var_4[var_4.size] = (38876.4, 46106.9, 925.771);
        var_4[var_4.size] = (37923.7, 47136.4, 949.247);
        var_5[var_5.size] = (1.88064, 180.047, 0.333796);
        var_5[var_5.size] = (1.47639, 180.039, 1.17305);
        var_5[var_5.size] = (359.077, 185.712, 7.76991);
        var_4[var_4.size] = (33628.2, 40971.6, 653.047);
        var_4[var_4.size] = (32104.4, 41719.8, 708.773);
        var_5[var_5.size] = (349.991, 186.286, -2.23687);
        var_5[var_5.size] = (3.95499, 211.371, 4.41818);
      } else if(var_0 == "_encstr_9A120A1D8536F5E4ED3BB293") {
        var_6[var_6.size] = (26310.8, 30168.4, 659.426);
        var_6[var_6.size] = (26954, 29794.1, 651.013);
        var_7[var_7.size] = (358.195, 118.006, -2.71651);
        var_7[var_7.size] = (0, 89.9998, 0);
        var_6[var_6.size] = (38573.2, 47052.8, 950.28);
        var_6[var_6.size] = (39660.3, 45949.9, 952.362);
        var_7[var_7.size] = (359.669, 194.507, -0.439539);
        var_7[var_7.size] = (11.7511, 162.518, 0.102679);
        var_6[var_6.size] = (33138.2, 41498.6, 707.349);
        var_7[var_7.size] = (357.81, 284.768, 1.14713);
      }

      break;
    case "_encstr_BA3F0A7D37E6935EE590C3CF":
    case "_encstr_93D20D28714743B99070632BAF3944":
      if(var_0 == "_encstr_8C190467402B") {
        var_4[var_4.size] = (49063.3, -22654.9, -385.662);
        var_4[var_4.size] = (47332.9, -23070.6, -374.497);
        var_4[var_4.size] = (48281.3, -22202.5, -371.375);
        var_5[var_5.size] = (0.0275984, 103.998, 0.280605);
        var_5[var_5.size] = (357.226, 88.8435, 4.3294);
        var_5[var_5.size] = (3.93534, 89.3527, 4.34541);
        var_4[var_4.size] = (49720, -18492, -387.562);
        var_4[var_4.size] = (48107.4, -18052.3, -312.859);
        var_5[var_5.size] = (0, 73.9972, 0);
        var_5[var_5.size] = (352.657, 118.56, -10.3306);
        var_4[var_4.size] = (46431.3, -92.3425, -52.4549);
        var_4[var_4.size] = (47471, -192.634, -43.7394);
        var_4[var_4.size] = (48085.6, -358.42, 9.73944);
        var_5[var_5.size] = (359.802, 240.821, -3.32839);
        var_5[var_5.size] = (0.975088, 240.828, 0.322594);
        var_5[var_5.size] = (6.15886, 241.028, 2.20885);
        var_4[var_4.size] = (44528.7, -5376.79, 283.824);
        var_4[var_4.size] = (43628, -5846.41, 346.636);
        var_5[var_5.size] = (357.74, 256.16, -1.56165);
        var_5[var_5.size] = (0.506229, 241.181, 0.438595);
      } else if(var_0 == "_encstr_9A120A1D8536F5E4ED3BB293") {
        var_6[var_6.size] = (47872.6, -22645.4, -385.49);
        var_6[var_6.size] = (48501.7, -22505, -382.243);
        var_7[var_7.size] = (1.68464, 109.9, -3.26246);
        var_7[var_7.size] = (359.897, 89.9842, 8.71393);
        var_6[var_6.size] = (46034.5, -59.925, -29.8834);
        var_6[var_6.size] = (47108.8, -498.535, -35.0573);
        var_7[var_7.size] = (2.33612, 243.444, -0.141863);
        var_7[var_7.size] = (355.135, 243.112, 2.65064);
      }

      break;
    case "_encstr_AC880C67503EA82A05DD62214CE7":
      if(var_0 == "_encstr_8C190467402B") {
        var_4[var_4.size] = (31381.3, -35260.4, -566.754);
        var_4[var_4.size] = (31087.5, -35307.9, -566.206);
        var_5[var_5.size] = (0, 106, 0);
        var_5[var_5.size] = (0, 91, 0);
        var_4[var_4.size] = (37273.8, -22647.6, -566);
        var_4[var_4.size] = (38224.6, -23864.4, -566);
        var_5[var_5.size] = (0, 225, 0);
        var_5[var_5.size] = (0, 225, 0);
        var_4[var_4.size] = (37183.4, -15816, -558.929);
        var_4[var_4.size] = (36704.9, -15941.1, -558);
        var_4[var_4.size] = (37630.9, -15950.5, -564);
        var_5[var_5.size] = (0, 270, 0);
        var_5[var_5.size] = (0, 270, 0);
        var_5[var_5.size] = (0, 270, 0);
        var_4[var_4.size] = (34323.3, -25831.8, -566);
        var_5[var_5.size] = (0, 45, 0);
      } else if(var_0 == "_encstr_9A120A1D8536F5E4ED3BB293") {
        var_6[var_6.size] = (31412.5, -34658.3, -564.862);
        var_6[var_6.size] = (31042.3, -16171.6, -565.383);
        var_7[var_7.size] = (0, 105, 0);
        var_7[var_7.size] = (0, 75, 0);
        var_6[var_6.size] = (36937.6, -15836.1, -559.8);
        var_6[var_6.size] = (37369.7, -16171.6, -562);
        var_7[var_7.size] = (0, 270, 0);
        var_7[var_7.size] = (0, 270, 0);
      }

      break;
    case "_encstr_831E0F7F2968E2AFC819F0FED3B0D70AD4":
      if(var_0 == "_encstr_8C190467402B") {
        var_4[var_4.size] = (-28937.7, -17197.8, -246.637);
        var_4[var_4.size] = (-29175.8, -17121.9, -247.909);
        var_4[var_4.size] = (-28096.5, -16918.8, -246.085);
        var_5[var_5.size] = (1.203, 90, 0.12);
        var_5[var_5.size] = (0.597, 90, 0.15);
        var_5[var_5.size] = (358.68, 90.0277, -0.8);
        var_4[var_4.size] = (-25926, -12688.6, -89.5073);
        var_4[var_4.size] = (-24872.9, -12661.3, -65.0808);
        var_5[var_5.size] = (5.13576, 104.619, 0.240957);
        var_5[var_5.size] = (358.169, 15, -3.49767);
        var_4[var_4.size] = (-28315.5, -3152.67, -311.293);
        var_4[var_4.size] = (-28107.5, -3152.67, -311.293);
        var_4[var_4.size] = (-27778.8, -3591.73, -310.621);
        var_5[var_5.size] = (0.061, 270, 7.355);
        var_5[var_5.size] = (0.061, 270, 7.355);
        var_5[var_5.size] = (0, 270, 0);
        var_4[var_4.size] = (-25666, -8411.14, -47.9997);
        var_4[var_4.size] = (-26998.2, -9004.54, -40);
        var_5[var_5.size] = (358.715, 15.233, -10.279);
        var_5[var_5.size] = (0, 285, 0);
      } else if(var_0 == "_encstr_9A120A1D8536F5E4ED3BB293") {
        var_6[var_6.size] = (-28683.3, -16741.2, -249.16);
        var_6[var_6.size] = (-29128.7, -16577.6, -229.266);
        var_7[var_7.size] = (359.734, 90.0021, -0.454);
        var_7[var_7.size] = (353.195, 90.3463, -3.01942);
        var_6[var_6.size] = (-27985.4, -3613.97, -315.978);
        var_6[var_6.size] = (-28449.8, -3645.92, -312.247);
        var_7[var_7.size] = (0, 270.003, 5.684);
        var_7[var_7.size] = (0, 270.004, -3.208);
      }

      break;
    case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
      break;
    case "_encstr_876510B60EF583E4B76B2BB9851995BED9BB":
      if(var_0 == "_encstr_8C190467402B") {
        var_4[var_4.size] = (-9606.95, -21527.2, -279.043);
        var_4[var_4.size] = (-10288.2, -20891.9, -356.989);
        var_4[var_4.size] = (-11011.4, -19877, -368.358);
        var_5[var_5.size] = (0, 200, 0);
        var_5[var_5.size] = (0, 222, 0);
        var_5[var_5.size] = (359.526, 210.007, -0.952);
        var_4[var_4.size] = (-13835.9, -23127.9, -278.639);
        var_4[var_4.size] = (-14327.9, -22160.8, -266.586);
        var_5[var_5.size] = (2.373, 210, 0);
        var_5[var_5.size] = (0.806, 194.929, 2.603);
        var_4[var_4.size] = (-21725.2, -26511, -152);
        var_4[var_4.size] = (-21577.7, -26755.1, -151.997);
        var_4[var_4.size] = (-21065.3, -27199.1, -148.746);
        var_5[var_5.size] = (0, 30, 0);
        var_5[var_5.size] = (0, 60, 0);
        var_5[var_5.size] = (5.079, 0.128, 1.453);
        var_4[var_4.size] = (-18873.3, -25796.5, -199.784);
        var_5[var_5.size] = (0, 30, 0);
      } else if(var_0 == "_encstr_9A120A1D8536F5E4ED3BB293") {
        var_6[var_6.size] = (-10912.6, -20079.6, -367);
        var_6[var_6.size] = (-10108.5, -21861.4, -287.271);
        var_7[var_7.size] = (0, 196.996, 0);
        var_7[var_7.size] = (7.93172, 180.719, 4.15911);
        var_6[var_6.size] = (-22036.5, -25881.6, -147.198);
        var_6[var_6.size] = (-21144.5, -27447.1, -151.145);
        var_7[var_7.size] = (0, 345, 0);
        var_7[var_7.size] = (0, 30, 0);
      }

      break;
    case "_encstr_81060EEA3847D0DBBAD5EB771EEF11BF":
      if(var_0 == "_encstr_8C190467402B") {
        var_4[var_4.size] = (-3749, 16980, -262);
        var_4[var_4.size] = (-2971.9, 18898, -262);
        var_4[var_4.size] = (-2735.8, 16203, -262);
        var_5[var_5.size] = (0, 218, 0);
        var_5[var_5.size] = (0, 174, 0);
        var_5[var_5.size] = (0, 208, 0);
        var_4[var_4.size] = (-11894, 16161, -266);
        var_4[var_4.size] = (-11841, 15884, -266);
        var_5[var_5.size] = (0, 162, 0);
        var_5[var_5.size] = (0, 248, 0);
        var_4[var_4.size] = (-29137, 12868, -244);
        var_4[var_4.size] = (-29539, 12883, -252);
        var_4[var_4.size] = (-29040, 13706, -497);
        var_5[var_5.size] = (0, 0, 0);
        var_5[var_5.size] = (0, 0, 0);
        var_5[var_5.size] = (0, 5, 0);
        var_4[var_4.size] = (-19181, 16384, -263);
        var_4[var_4.size] = (-19650, 17253, 54);
        var_4[var_4.size] = (-19937, 16123, -261);
        var_5[var_5.size] = (0, 310, 0);
        var_5[var_5.size] = (0, 357, 0);
        var_5[var_5.size] = (0, 35, 0);
      } else if(var_0 == "_encstr_9A120A1D8536F5E4ED3BB293") {
        var_6[var_6.size] = (-3520, 17805, -262);
        var_6[var_6.size] = (-3892, 18566, -262);
        var_7[var_7.size] = (0, 165, 0);
        var_7[var_7.size] = (0, 194, 0);
        var_6[var_6.size] = (-29131, 13010, -244);
        var_6[var_6.size] = (-28676, 13724, -518);
        var_7[var_7.size] = (0, 0, 0);
        var_7[var_7.size] = (0, 355, 0);
        var_6[var_6.size] = (-19622, 17422, 54);
        var_7[var_7.size] = (0, 357, 0);
      }

      break;
    case "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE":
      if(var_0 == "_encstr_8C190467402B") {
        var_4[var_4.size] = (4103, 26076, 57);
        var_4[var_4.size] = (4247, 25021, -38);
        var_4[var_4.size] = (3517, 25981, 47);
        var_5[var_5.size] = (0, 143, 0);
        var_5[var_5.size] = (0, 189, 0);
        var_5[var_5.size] = (0, 103, 0);
        var_4[var_4.size] = (4989, 29842, 253);
        var_4[var_4.size] = (1725, 28703, 51);
        var_5[var_5.size] = (0, 162, 0);
        var_5[var_5.size] = (0, 141, 0);
        var_4[var_4.size] = (-6826, 33623, -46);
        var_4[var_4.size] = (-7642, 32168, -188);
        var_4[var_4.size] = (-6589, 32564, -82);
        var_5[var_5.size] = (3, 337, 0);
        var_5[var_5.size] = (0, 357, 0);
        var_5[var_5.size] = (0, 320, 0);
        var_4[var_4.size] = (-3326, 32657, 238);
        var_4[var_4.size] = (-2149, 33264, 253);
        var_5[var_5.size] = (0, 325, 0);
        var_5[var_5.size] = (0, 287, 0);
      } else if(var_0 == "_encstr_9A120A1D8536F5E4ED3BB293") {
        var_6[var_6.size] = (4157, 26465, 65);
        var_6[var_6.size] = (4628, 26545, 63);
        var_7[var_7.size] = (0, 143, 0);
        var_7[var_7.size] = (0, 63, 0);
        var_6[var_6.size] = (-7337, 32683, -77);
        var_6[var_6.size] = (-6671, 32948, -67);
        var_7[var_7.size] = (0, 320, 0);
        var_7[var_7.size] = (0, 36, 0);
      }

      break;
    default:
      break;
  }

  level.check_for_moody_traversal = var_4;
  level.check_for_execution_allows = var_5;

  if(var_0 == "_encstr_8C190467402B") {
    for(var_8 = 0; var_8 < var_4.size; var_8++) {
      if(var_8 <= var_4.size - 1) {
        var_9 = var_4[var_8];
        var_10 = var_5[var_8];
        var_11 = spawnStruct();
        var_11.origin = var_9;
        var_11.angles = var_10;
        var_11.targetname = var_0;
        var_11.vehicletype = var_1;
        var_2[var_2.size] = var_11;
      }
    }
  } else if(var_0 == "_encstr_9A120A1D8536F5E4ED3BB293") {
    for(var_8 = 0; var_8 < var_6.size; var_8++) {
      if(var_8 <= var_6.size - 1) {
        var_12 = var_6[var_8];
        var_13 = var_7[var_8];
        var_11 = spawnStruct();
        var_11.origin = var_12;
        var_11.angles = var_13;
        var_11.targetname = var_0;
        var_11.vehicletype = var_1;
        var_2[var_2.size] = var_11;
      }
    }
  }

  var_14 = "_encstr_99E7130E896AD972B23425599750FA1A82FF30CDE9" + var_0;
  var_15 = 0;

  for(;;) {
    var_16 = var_14 + "_encstr_BD35097DF6394B3B96DC7D" + var_15;
    var_17 = var_14 + "_encstr_BA3A0927B7E5F7616D2241" + var_15;
    var_18 = (0, 0, 0);
    var_19 = getdvarvector(var_16, var_18);

    if(var_19 == (0, 0, 0)) {
      break;
    }

    var_11 = spawnStruct();
    var_11.origin = var_19;
    var_20 = (0, 0, 0);
    var_11.angles = getdvarvector(var_17, var_20);
    var_11.targetname = var_0;
    var_11.vehicletype = var_1;
    var_2[var_2.size] = var_11;
    var_15++;
  }

  return var_2;
}

vehiclespawn_littlebird(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9A8F0CB1A5E8471BB2EB894B39C8", var_2, var_1);
}

vehiclespawn_atv(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8C190467402B", var_2, var_1);
}

vehiclespawn_cargotruck(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6", var_2, var_1);
}

vehiclespawn_tacrover(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_9A120A1D8536F5E4ED3BB293", var_2, var_1);
}

vehiclespawn_jeep(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_85DE05A6B2AC0E", var_2, var_1);
}

play_nag_intro_vo(var_0) {
  var_1 = [];

  if(getdvarint("_encstr_959823E6D827BE98398E46ADBE91A5E6B08936B2EB27B046A5B09B47FA675934A51BD8CA6E", level.endsuperdisableweaponbr._id_1196B["_encstr_959823E6D827BE98398E46ADBE91A5E6B08936B2EB27B046A5B09B47FA675934A51BD8CA6E"]) == 1)
    return var_1;

  foreach(var_3 in var_0) {
    if(distance2dsquared(var_3.origin, level.endsuperdisableweaponbr.circlecenter) < level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer * level.endsuperdisableweaponbr.gulagfadetoblackspectatorsofplayer)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.rushtimer = scripts\mp\utility\dvars::dvarintvalue("_encstr_995F0A93AB3786A8A5DA5993", 1, 0, 1);
  level.rushtimeramount = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8393106AF38004739380621B6DF9E73B7369", 45.0, 30.0, 120);
  level.sharedrushtimer = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_937A10E60D2CC99546A45D9BD0A24BD6954E", 0, 0, 1);
  level.precappoints = scripts\mp\utility\dvars::dvarintvalue("_encstr_82730D3B68514312E927CD4410D90B", 0, 0, 1);
  level.caprate = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_86BA08808A8205897BD5", 7.5, 1, 60);
  level.objectivescaler = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_86FA0ABD89A6D41B85630BC9", 2, 1, 10);
  level.spawn_lmg_soldiers_05 = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_8EF50D839F786CB031B1845C807562", 7.5, 0, 60);
}

adjustroundendtimer() {
  wait 1;
  level.roundenddelay = 8.0;
}

waittooverridegraceperiod() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  if(!level.unset_relic_lfo)
    level.overrideingraceperiod = 1;
}

initspawns() {
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B");
  scripts\mp\spawnlogic::addstartspawnpoints("_encstr_AB42183082FF80107ACF5F214FA3E8119918384BE13BF8DFA34B");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_92A00D235071922868E7FBEB2148FB");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_92A00D235071922868E7FBEB2148FB");
  scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0", 1, 1);
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_92A00D235071922868E7FBEB2148FB");
  var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_82D817C9D8713DD85DB8FFA90FA7F099169F8E1FD8588B2AA0");
  scripts\mp\spawnlogic::registerspawnset("_encstr_8218041DF5FA", var_0);
  scripts\mp\spawnlogic::registerspawnset("_encstr_B15C0DC47FC871331F387AE2E1664F", var_1);
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
}

getspawnpoint() {
  if(level.unset_relic_lfo) {
    var_0 = self.pers["_encstr_8AEF05472BC2D6"];

    if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
      if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
        scripts\mp\spawnlogic::activatespawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_8203101FF33885AB060225CD31A68A4B6AD7");
      } else {
        scripts\mp\spawnlogic::activatespawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", 1);
        var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_9AE3109755F34D5879256960F390C8FFD207");
      }
    } else {
      scripts\mp\spawnlogic::activatespawnset("_encstr_820E07FAE8780B3A4C", 1);
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, undefined, "_encstr_AD0C095DF195E8B6074A18");
    }

    if(istrue(level.usesquadspawn) && istrue(self.squadspawnconfirmed)) {
      var_2 = self getspectatingplayer();

      if(isDefined(var_2) && isDefined(self.squadindex) && self.team == var_2.team && self.squadindex == var_2.squadindex)
        var_1 = scripts\mp\spawnscoring::findteammatebuddyspawn(var_2);
    }

    return var_1;
  } else {
    var_0 = self.pers["_encstr_8AEF05472BC2D6"];
    var_3 = scripts\mp\utility\game::getotherteam(var_0)[0];

    if(level.usestartspawns) {
      scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8AEF0B35A3C227D19A38C2BBCD", "_encstr_829A0D0F1AF8FB5ED127855073F940");

      if(game["_encstr_AFD60E233C91DC2F721D7B27C2E878EF"]) {
        var_4 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_83DA0E03A801F0787F31D3BBBA7FA071" + var_3 + "_encstr_B4810709B378B9F3F5");
        var_1 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_4);
      } else {
        var_4 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_83DA0E03A801F0787F31D3BBBA7FA071" + var_0 + "_encstr_B4810709B378B9F3F5");
        var_1 = scripts\mp\spawnlogic::getspawnpoint_startspawn(var_4);
      }
    } else {
      scripts\mp\spawnlogic::setactivespawnlogic("_encstr_A1580B11DE5B5A9B0BA35AEDCD", "_encstr_829A0D0F1AF8FB5ED127855073F940");
      var_5 = getteamdompoints(var_0);
      var_6 = scripts\mp\utility\game::getotherteam(var_0)[0];
      var_7 = getteamdompoints(var_6);
      var_8 = _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::getpreferreddompoints(var_5, var_7, var_0, var_3);
      var_9 = [];
      var_9["_encstr_A57C1399B32A4CA8FA123911B7DFD0EF22472DE9DF"] = var_8["_encstr_95830AC1C9CACCCAC939CAC8"];
      var_9["_encstr_BA38137FA7A6E765EDA628911497B859DF983A1137"] = var_8["_encstr_AC8F0AE74163F85AAA380AD8"];
      scripts\mp\spawnlogic::activatespawnset("_encstr_8218041DF5FA");
      var_1 = scripts\mp\spawnlogic::getspawnpoint(self, var_0, "_encstr_8218041DF5FA", "_encstr_B15C0DC47FC871331F387AE2E1664F", undefined, var_9);
    }

    return var_1;
  }
}

getteamdompoints(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectives) {
    if(var_3.ownerteam == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

gettimesincedompointcapture(var_0) {
  return gettime() - var_0.capturetime;
}

onplayerconnect(var_0) {
  var_0._domflageffect = [];
  var_0._domflagpulseeffect = [];
  var_0.ui_dom_securing = undefined;
  var_0.ui_dom_stalemate = undefined;
  var_0 thread onplayerspawned();
  var_0 thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::ondisconnect();
  var_0.siegelatecomer = 1;

  if(level.unset_relic_lfo && isDefined(game["_encstr_8DC30DAA0285FD69FAE113371B1934"]) && game["_encstr_8DC30DAA0285FD69FAE113371B1934"] != 0 && !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    var_0 thread _id_11AAF();
}

onplayerdisconnect(var_0) {
  for(;;) {
    var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");

    foreach(var_2 in var_0._domflageffect) {
      if(isDefined(var_2))
        var_2 delete();
    }
  }
}

onplayerspawned() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_BA350853C128FB939DB9");
    scripts\mp\utility\stats::setextrascore0(0);

    if(isDefined(self.pers["_encstr_81CF0936850ED1D54EACCD"]))
      scripts\mp\utility\stats::setextrascore0(self.pers["_encstr_81CF0936850ED1D54EACCD"]);

    scripts\mp\utility\stats::setextrascore1(0);

    if(isDefined(self.pers["_encstr_8294083A0938C3CB2577"]))
      scripts\mp\utility\stats::setextrascore1(self.pers["_encstr_8294083A0938C3CB2577"]);
  }
}

onplayerjointeam(var_0) {
  if(scripts\mp\utility\game::gamehasstarted())
    var_0.siegelatecomer = 1;
}

onspawnplayer() {
  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  thread _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::updatematchstatushintonspawn();
}

checkallowspectating() {
  if(level.rushtimerteam == "_encstr_8BBA05185F8B99") {
    return;
  }
  if(!scripts\mp\utility\teams::getteamdata(level.rushtimerteam, "_encstr_8A2A0B936CCCC3078547970A8B")) {
    level.spectateoverride[level.rushtimerteam].allowenemyspectate = 1;
    scripts\mp\spectating::updatespectatesettings();
  }
}

domflags() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = getEntArray("_encstr_82170DCC8D2CB37D389C2DB685275E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEntArray("_encstr_B40B0FA771DFC427F7DB8BD0FDB4F90ED8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size + var_1.size < 2) {
    return;
  }
  var_2 = "_encstr_8FF714CFF898F312433CCF0F9173CA9838784A8F88EB";
  var_3 = scripts\cp_mp\utility\game_utility::getmapname();
  var_4 = 1;

  for(var_5 = 2; var_5 < 11; var_5++) {
    var_6 = tablelookup(var_2, var_4, var_3, var_5);

    if(var_6 != "_encstr_B40101")
      setflagpositions(var_5, float(var_6));
  }

  var_7 = [];

  for(var_8 = 0; var_8 < var_0.size; var_8++)
    var_7[var_7.size] = var_0[var_8];

  for(var_8 = 0; var_8 < var_1.size; var_8++)
    var_7[var_7.size] = var_1[var_8];

  level._id_11F45 = 3;
  setomnvar("_encstr_85511125C469453BFDF7A07BC737918952EF9E", level._id_11F45);

  if(level._id_11F45 == 3) {
    foreach(var_10 in var_0)
    var_10 _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::remapdomtriggerscriptlabel();
  }

  level.objectives = [];

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_10 = var_7[var_8];

    if(level._id_11F45 == 3) {
      if(var_10.script_label == "_encstr_A2070318DC" || var_10.script_label == "_encstr_950703EBCA")
        continue;
    }

    var_10.origin = getflagpos(var_10.script_label, var_10.origin);

    if(isDefined(var_10.target))
      var_12[0] = getEnt(var_10.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    else {
      var_12[0] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_10.origin);
      var_12[0].angles = var_10.angles;
    }

    var_13 = scripts\mp\gameobjects::createuseobject("_encstr_A7A408B9CA5D1D4E2C63", var_10, var_12, (0, 0, 100), 1, 1);
    var_13 scripts\mp\gameobjects::allowuse("_encstr_88BF06FD784A6393");
    var_13 scripts\mp\gameobjects::setusetime(level.caprate);

    if(isDefined(var_10.objectivekey))
      var_13.objectivekey = var_10.objectivekey;
    else
      var_13.objectivekey = var_13 scripts\mp\gameobjects::getlabel();

    if(isDefined(var_10.iconname))
      var_13.iconname = var_10.iconname;
    else
      var_13.iconname = var_13 scripts\mp\gameobjects::getlabel();

    var_13 scripts\mp\gameobjects::cancontestclaim(1);
    var_13.nousebar = 1;
    var_13.id = "_encstr_87D9083A6F628DDB5F1F";
    var_13.firstcapture = 1;
    var_13.prevteam = "_encstr_A7A408B9CA5D1D4E2C63";
    var_13.flagcapsuccess = 0;
    var_13.playersrevived = 0;
    var_13.claimgracetime = level.caprate * 1000;
    var_13 scripts\mp\gameobjects::pinobjiconontriggertouch();
    var_14 = var_12[0].origin + (0, 0, 32);
    var_15 = var_12[0].origin + (0, 0, -32);
    var_16 = scripts\engine\trace::ray_trace(var_14, var_15, undefined, scripts\engine\trace::create_default_contents(1));
    var_17 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::checkmapoffsets(var_13);
    var_13.baseeffectpos = var_16["_encstr_BD260953AA97E3F014279D"] + var_17;
    var_18 = vectortoangles(var_16["_encstr_820E07FAE8780B3A4C"]);
    var_19 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::checkmapfxangles(var_13, var_18);
    var_13.baseeffectforward = anglesToForward(var_19);
    var_13.noscriptable = 1;
    var_13.flagmodel = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_13.baseeffectpos);

    if(istrue(level.setplayerselfrevivingextrainfo))
      var_20 = "_encstr_AFD41A34359BC76B019B6F1992B0E8B7C5E81957C6B02E25CF5E7B4B";
    else
      var_20 = "_encstr_887E1AD64BB1A51D0B2797F519BDD6EB66B1B09DF5B9CAD5D139C2C6";

    var_13.flagmodel setModel(var_20);
    level.objectives[var_13.objectivekey] = var_13;
  }

  var_21 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_AB42183082FF80107ACF5F214FA3E8119918384BE13BF8DFA34B");
  var_22 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_ADB41A031B29ED9885399BF35E67688822F389B3E7B33830B48EA38B");
  level.startpos["_encstr_9A8507BA4040188D08"] = var_22[0].origin;
  level.startpos["_encstr_8E8405EA382B2A"] = var_21[0].origin;
  level.bestspawnflag = [];
  level.bestspawnflag["_encstr_9A8507BA4040188D08"] = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getunownedflagneareststart("_encstr_9A8507BA4040188D08", undefined);
  level.bestspawnflag["_encstr_8E8405EA382B2A"] = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getunownedflagneareststart("_encstr_8E8405EA382B2A", level.bestspawnflag["_encstr_9A8507BA4040188D08"]);
  _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::flagsetup();

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    level scripts\engine\utility::_id_143A5("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B", "_encstr_8F55118F8B711B6436974A09E1173783D313D9");

  foreach(var_24 in level.objectives) {
    var_25 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getreservedobjid(var_24.objectivekey);
    var_24 scripts\mp\gameobjects::requestid(1, 1, var_25);
    var_24.onuse = ::onuse;
    var_24.onbeginuse = ::onbeginuse;
    var_24.onuseupdate = ::onuseupdate;
    var_24.onenduse = ::onenduse;
    var_24.oncontested = ::oncontested;
    var_24.onuncontested = ::onuncontested;
    var_24.onunoccupied = ::onunoccupied;
    var_24.onpinnedstate = ::onpinnedstate;
    var_24.onunpinnedstate = ::onunpinnedstate;
    var_24._id_138B2 = ::_id_12093;
    var_24.stompprogressreward = ::stompprogressreward;
    var_24 scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_8F361077FED381AD0833C589FCA8DA67776B");
    var_24 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_24 _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::domflag_setneutral();
  }

  if(level.precappoints)
    _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::precap();
}

setneutral() {
  if(scripts\mp\gameobjects::getownerteam() == "_encstr_A7A408B9CA5D1D4E2C63")
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_A7C5056BD931D1", 0);
}

setflagpositions(var_0, var_1) {
  switch (var_0) {
    case 2:
      level.siege_a_xpos = var_1;
      break;
    case 3:
      level.siege_a_ypos = var_1;
      break;
    case 4:
      level.siege_a_zpos = var_1;
      break;
    case 5:
      level.siege_b_xpos = var_1;
      break;
    case 6:
      level.siege_b_ypos = var_1;
      break;
    case 7:
      level.siege_b_zpos = var_1;
      break;
    case 8:
      level.siege_c_xpos = var_1;
      break;
    case 9:
      level.siege_c_ypos = var_1;
      break;
    case 10:
      level.siege_c_zpos = var_1;
      break;
  }
}

getflagpos(var_0, var_1) {
  var_2 = var_1;

  if(var_0 == "_encstr_B20703DFCF") {
    if(isDefined(level.siege_a_xpos) && isDefined(level.siege_a_ypos) && isDefined(level.siege_a_zpos))
      var_2 = (level.siege_a_xpos, level.siege_a_ypos, level.siege_a_zpos);
  } else if(var_0 == "_encstr_B40703E96D") {
    if(isDefined(level.siege_b_xpos) && isDefined(level.siege_b_ypos) && isDefined(level.siege_b_zpos))
      var_2 = (level.siege_b_xpos, level.siege_b_ypos, level.siege_b_zpos);
  } else if(isDefined(level.siege_c_xpos) && isDefined(level.siege_c_ypos) && isDefined(level.siege_c_zpos))
    var_2 = (level.siege_c_xpos, level.siege_c_ypos, level.siege_c_zpos);

  return var_2;
}

watchflagtimerpause() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    level waittill("_encstr_92A30F1912577C311EA15959DD02D8B0E7", var_0);

    if(level.rushtimer) {
      if(var_0.prevteam != "_encstr_A7A408B9CA5D1D4E2C63") {
        var_1 = scripts\mp\utility\game::getotherteam(var_0.prevteam)[0];

        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "_encstr_8CA706B310FB034F" && !iswinningteam(var_1)) {
          level.gametimerbeeps = 0;
          level.siegetimerstate = "_encstr_8CA706B310FB034F";
          pausecountdowntimer();

          if(!flagownersalive(var_0.prevteam))
            setwinner(var_1, tolower(game[var_0.prevteam]) + "_encstr_86E60CDF8828C17A6380E6DB7D11");
        }
      }
    }
  }
}

iswinningteam(var_0) {
  var_1 = 0;
  var_2 = getflagcount(var_0);

  if(level._id_11F45 == 3) {
    if(var_2 == 2)
      var_1 = 1;
  } else if(var_2 >= 3)
    var_1 = 1;

  return var_1;
}

flagownersalive(var_0) {
  var_1 = 0;

  foreach(var_3 in level.participants) {
    if(isDefined(var_3) && var_3.team == var_0 && (scripts\mp\utility\player::isreallyalive(var_3) || var_3.pers["_encstr_8CAA06DB20A31543"] > 0)) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

pausecountdowntimer() {
  if(!level.timerstoppedforgamemode) {
    var_0 = level.rushtimeramount;

    if(isDefined(level.siegetimeleft))
      var_0 = level.siegetimeleft;

    var_1 = int(gettime() + var_0 * 1000);
    scripts\mp\gamelogic::pausetimer(var_1);
  }

  level notify("_encstr_BE22135B8315F85F09117B181D4277C32783076F29");
}

resumecountdowntimer(var_0) {
  var_1 = level.rushtimeramount;

  if(level.timerstoppedforgamemode) {
    if(isDefined(level.siegetimeleft))
      var_1 = level.siegetimeleft;

    var_2 = int(gettime() + var_1 * 1000);
    setgameendtime(var_2);
    scripts\mp\gamelogic::resumetimer(var_2);

    if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "_encstr_8CA706B310FB034F")
      level.siegetimerstate = "_encstr_99AD06D3A5B1538B";

    thread watchgametimer(var_1);

    if(istrue(var_0)) {
      if(level.siegeflagcapturing.size > 0)
        level notify("_encstr_92A30F1912577C311EA15959DD02D8B0E7", self);
    }
  }
}

watchflagenduse(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 0;
  var_2 = 0;
  var_3 = level.rushtimerteam;
  var_1 = getflagcount("_encstr_9A8507BA4040188D08");
  var_2 = getflagcount("_encstr_8E8405EA382B2A");

  if(level.rushtimer && level.rushtimerteam != "_encstr_8BBA05185F8B99") {
    if(level.sharedrushtimer || var_1 == 1 && var_2 == 1) {
      level.siegetimerstate = "_encstr_99AD06D3A5B1538B";
      notifyplayers("_encstr_B2A312F3CBD1E72FCFC8F28A78ADE9FFABA77A8C");
      resumecountdowntimer(1);
      return;
    }
  }

  if(var_1 == level._id_11F45)
    setwinner("_encstr_9A8507BA4040188D08", "_encstr_97901387090760E52F5AC8B0529BAF28DAA7070BA6", "_encstr_ACE7141A4251AAB8183028F80EEB32C7D3EFBB37473A");
  else if(var_2 == level._id_11F45)
    setwinner("_encstr_8E8405EA382B2A", "_encstr_97901387090760E52F5AC8B0529BAF28DAA7070BA6", "_encstr_ACE7141A4251AAB8183028F80EEB32C7D3EFBB37473A");
  else if(level.rushtimer) {
    if(var_1 == 2 || var_2 == 2) {
      level.rushtimerteam = scripts\engine\utility::ter_op(var_1 > var_2, "_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A");

      if(var_3 != level.rushtimerteam) {
        if(isDefined(level.siegetimerstate) && level.siegetimerstate != "_encstr_88F20627959BCAE8") {
          level.gametimerbeeps = 0;
          level.siegetimeleft = undefined;
          level.siegetimerstate = "_encstr_88F20627959BCAE8";
          notifyplayers("_encstr_BE2A122BE3F9CF17F7E0AAE22BC5C1C3515685A4");
        }

        if(!isDefined(level.siegetimerstate) || level.siegetimerstate != "_encstr_99AD06D3A5B1538B") {
          var_4 = level.rushtimeramount;

          if(isDefined(level.siegetimeleft))
            var_4 = level.siegetimeleft;

          var_5 = int(gettime() + var_4 * 1000);
          level.timelimitoverride = 1;
          scripts\mp\gamelogic::pausetimer(var_5);
          setgameendtime(var_5);
          scripts\mp\gamelogic::resumetimer(var_5);

          if(!isDefined(level.siegetimerstate) || level.siegetimerstate == "_encstr_8CA706B310FB034F") {
            level.siegetimerstate = "_encstr_99AD06D3A5B1538B";
            notifyplayers("_encstr_B2A312F3CBD1E72FCFC8F28A78ADE9FFABA77A8C");
          }

          if(!level.gametimerbeeps)
            thread watchgametimer(var_4);
        }
      } else if(var_3 == level.rushtimerteam && var_1 == 1 || var_3 == level.rushtimerteam && var_2 == 1)
        resumecountdowntimer(1);
      else if(level.rushtimer) {
        level.gametimerbeeps = 0;
        level.siegetimeleft = undefined;
        level.siegetimerstate = "_encstr_88F20627959BCAE8";
        notifyplayers("_encstr_BE2A122BE3F9CF17F7E0AAE22BC5C1C3515685A4");
        resumecountdowntimer(1);
      }
    }
  }

  self.prevteam = self.ownerteam;
}

watchgameinactive() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_92A30F1912577C311EA15959DD02D8B0E7");
  var_0 = getdvarfloat("_encstr_81151462435ADFBF21D0F7994150E8A7300D67750A43");

  if(var_0 > 0) {
    var_1 = var_0 - 1;

    while(var_1 > 0) {
      var_1 = var_1 - 1;
      wait 1;
    }

    level.siegegameinactive = 1;
  }
}

watchgamestart() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  while(!havespawnedplayers())
    waitframe();

  level.gamehasstarted = 1;
}

havespawnedplayers() {
  if(level.teambased) {
    foreach(var_1 in level.teamnamelist) {
      if(!scripts\mp\utility\teams::getteamdata(var_1, "_encstr_A1310B432F9BDEFBEF4393B0F1"))
        return 0;
    }

    return 1;
  }

  return level.maxplayercount > 1;
}

watchgametimer(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_BE22135B8315F85F09117B181D4277C32783076F29");
  level endon("_encstr_BE2A122BE3F9CF17F7E0AAE22BC5C1C3515685A4");
  var_1 = var_0;
  var_2 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_2 hide();
  level.gametimerbeeps = 1;

  while(var_1 > 0) {
    var_1 = var_1 - 1;
    level.siegetimeleft = var_1;

    if(var_1 <= 30) {
      if(var_1 != 0)
        var_2 playSound("_encstr_B61216E504A9835B0F9B0850A75AF6D7F2ABD0EDDF424F40");
    }

    wait 1;
  }

  ontimelimit();
}

getflagcount(var_0) {
  var_1 = 0;

  foreach(var_3 in level.objectives) {
    if(var_3.ownerteam == var_0 && !isbeingcaptured(var_3))
      var_1 = var_1 + 1;
  }

  return var_1;
}

isbeingcaptured(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    if(level.siegeflagcapturing.size > 0) {
      foreach(var_3 in level.siegeflagcapturing) {
        if(var_0.objectivekey == var_3)
          var_1 = 1;
      }
    }
  }

  return var_1;
}

setwinner(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(!isai(var_4))
      var_4 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
  }

  if(isDefined(var_2))
    thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"][var_1], game["_encstr_99EA0B72AB022F6ED1CF9FC248"][var_2]);
  else
    thread scripts\mp\gamelogic::endgame(var_0, game["_encstr_99EA0B72AB022F6ED1CF9FC248"][var_1]);
}

onbeginuse(var_0) {
  if(!scripts\engine\utility::array_contains(level.siegeflagcapturing, self.objectivekey)) {
    level.siegeflagcapturing[level.siegeflagcapturing.size] = self.objectivekey;
    var_1 = scripts\mp\gameobjects::getownerteam();
    var_0 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);
    self.didstatusnotify = 0;
    scripts\mp\gameobjects::setusetime(level.caprate);
  }

  level notify("_encstr_92A30F1912577C311EA15959DD02D8B0E7", self);
}

onuse(var_0) {
  self.didstatusnotify = 0;
  var_1 = var_0.team;
  var_2 = scripts\mp\gameobjects::getownerteam();
  var_3 = scripts\mp\utility\game::getotherteam(var_1)[0];
  self.capturetime = gettime();
  scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate(var_1, 0, var_1);
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setflagcaptured(var_1, var_2, var_0);
  level.usestartspawns = 0;

  if(var_2 == "_encstr_A7A408B9CA5D1D4E2C63") {
    var_4 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getteamflagcount(var_1);

    if(var_4 < level.objectives.size) {
      if(var_4 == 2 && level._id_11F45 == 3) {
        scripts\mp\utility\dialog::statusdialog("_encstr_8A7C145C8D088D7088502087026ED7C3F7D34AC14722", var_1);
        scripts\mp\utility\dialog::statusdialog("_encstr_966911714585885B197F3BE1DB43262B5C9113", var_3, 1);
      } else {
        scripts\mp\utility\dialog::statusdialog("_encstr_AAE70838F27E43E327DC" + self.objectivekey, var_1);
        scripts\mp\utility\dialog::statusdialog("_encstr_86AD05B1F6B9A3" + self.objectivekey, var_3, 1);
      }
    }
  }

  if(_encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getteamflagcount(var_1) == level.objectives.size)
    var_5 = "_encstr_8A5919A8037FCD80ADAF2539B91739062F9B03D34BCF75C9466429";
  else
    var_5 = "_encstr_AF841588B30FD127CB0E030550B7FEB7F82ACBD80E0DC1";

  thread scripts\mp\utility\print::printandsoundoneveryone(var_1, var_3, undefined, undefined, var_5, "_encstr_BD6C119A43E0C38D30DF0E1CBBB8592B10DB83", var_0);
  thread giveflagcapturexp(self.touchlist[var_1], var_2, var_0);
  self.firstcapture = 0;

  if(scripts\mp\utility\teams::isgameplayteam(var_1)) {
    if(level.teamdata[var_1]["_encstr_8A2A0B936CCCC3078547970A8B"] < level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"].size) {
      foreach(var_7 in level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"])
      var_7 playlocalsound("_encstr_ADBE1BD0D86942EF47B16178F31271C9A3333BF0E7DB10B6C82B0FD559");

      var_9 = scripts\mp\utility\teams::getenemyplayers(var_1);

      foreach(var_7 in var_9)
      var_7 playlocalsound("_encstr_8C321BB60EBE98DB46BC8DB7EACD3AD73AB4C65BEBCD59D9B0D196B3CA");
    }
  }

  thread getquickdropitemcount(var_1);
}

onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_1 < 1.0 && !level.gameended && !istrue(self.captureblocked))
    play_dom_capture_sfx(var_1, var_0);

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify) {
    if(var_4 == "_encstr_A7A408B9CA5D1D4E2C63") {
      scripts\mp\utility\dialog::statusdialog("_encstr_823109E62B1BAB27D2B93B" + self.objectivekey, var_0);
      self.prevownerteam = scripts\mp\utility\game::getotherteam(var_0)[0];
    } else {
      scripts\mp\utility\dialog::statusdialog("_encstr_8267076C10DBE8B6E0" + self.objectivekey, var_4, 1);
      scripts\mp\utility\dialog::statusdialog("_encstr_823109E62B1BAB27D2B93B" + self.objectivekey, var_0);
    }

    if(!isagent(var_3))
      _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagcapturestate(var_0);

    scripts\mp\gameobjects::setobjectivestatusicons(level.iconlosing, level.icontaking);
    self.didstatusnotify = 1;
  }

  level notify("_encstr_92A30F1912577C311EA15959DD02D8B0E7", self);
}

getquickdropitemcount(var_0) {
  var_1 = 0;
  var_2 = getflagcount(var_0);

  if(level._id_11F45 == 3) {
    if(var_2 == 2)
      var_1 = 1;
  } else if(var_2 == 4)
    var_1 = 1;

  if(var_1)
    thread scripts\mp\music_and_dialog::dominating_music(var_0);
}

play_dom_capture_sfx(var_0, var_1) {
  if(!isDefined(self.lastsfxplayedtime))
    self.lastsfxplayedtime = gettime();

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_2 = "_encstr_B40101";
    var_0 = int(floor(var_0 * 10));
    var_2 = "_encstr_856B180A5867CF6F6068A3D9972B4F12537312A1E0E3C6A71EC7" + var_0;
    self.visuals[0] playsoundtoteam(var_2, var_1);
  }
}

onenduse(var_0, var_1, var_2) {
  self.didstatusnotify = 0;

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    var_1.ui_dom_securing = undefined;
  }

  if(var_2)
    self.flagcapsuccess = 1;
  else {
    self.flagcapsuccess = 0;
    resumecountdowntimer();
  }

  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_A7C5056BD931D1", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
    _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate(var_3, 0);
  }

  if(!istrue(self.setblocking) && !istrue(self.stalemate))
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);

  thread _id_14393();
}

_id_14393() {
  waitframe();
  checkendgame();
}

oncontested() {
  if(!scripts\engine\utility::array_contains(level.siegeflagcapturing, self.objectivekey))
    level.siegeflagcapturing[level.siegeflagcapturing.size] = self.objectivekey;

  scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_B85C0AD87B9B8E95CD8E2B46", 0);

  if(level.rushtimerteam == self.ownerteam)
    resumecountdowntimer();
}

onuncontested(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\gameobjects::getnumtouchingforteam(var_1);
  var_3 = scripts\mp\gameobjects::getnumtouchingexceptteam(var_1);

  if(var_2 && !var_3)
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);

  thread _id_14393();

  if(var_1 == "_encstr_A7A408B9CA5D1D4E2C63") {
    if(var_0 != "_encstr_8BBA05185F8B99")
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, var_0);
    else
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  } else
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, scripts\mp\utility\game::getotherteam(var_1)[0]);

  if(var_0 == "_encstr_8BBA05185F8B99" || var_1 == "_encstr_A7A408B9CA5D1D4E2C63") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  var_4 = scripts\engine\utility::ter_op(var_1 == "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_A7C5056BD931D1", var_1);
  _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate(var_4, 0);
}

onunoccupied() {
  var_0 = scripts\mp\gameobjects::getownerteam();
  level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);
  thread _id_14393();

  if(var_0 == "_encstr_A7A408B9CA5D1D4E2C63") {
    scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    self.didstatusnotify = 0;
  } else
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);
}

onpinnedstate(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

onunpinnedstate(var_0) {
  if(self.ownerteam != "_encstr_A7A408B9CA5D1D4E2C63" && !self.numtouching[self.ownerteam] && !self.stalemate)
    scripts\mp\gameobjects::setobjectivestatusicons(level.icondefend, level.iconcapture);

  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\gameobjects::getnumtouchingforteam(var_1);
  var_3 = scripts\mp\gameobjects::getnumtouchingexceptteam(var_1);

  if(var_2 && !var_3)
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);

  thread _id_14393();
}

_id_12093(var_0) {
  var_1 = scripts\mp\gameobjects::getownerteam();
  var_2 = scripts\mp\gameobjects::getnumtouchingforteam(var_1);
  var_3 = scripts\mp\gameobjects::getnumtouchingexceptteam(var_1);

  if(var_2 && !var_3)
    level.siegeflagcapturing = scripts\engine\utility::array_remove(level.siegeflagcapturing, self.objectivekey);

  if(level.rushtimerteam == self.ownerteam)
    resumecountdowntimer();
  else
    resumecountdowntimer(1);
}

stompprogressreward(var_0) {
  var_0 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
  var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
  scripts\mp\gameobjects::setobjectivestatusicons(level.icondefending, level.iconcapture);
}

ondeadevent(var_0) {
  if(scripts\mp\utility\game::gamehasstarted()) {
    if(var_0 == "_encstr_AF1904A7F929")
      ontimelimit();
    else if(var_0 == game["_encstr_991C0AB9ED5B57161FE89B83"]) {
      if(level.rushtimer && getflagcount(var_0) == 2) {
        return;
      }
      setwinner(game["_encstr_B6A70A23CA6659DC91CAE4DC"], tolower(game[game["_encstr_991C0AB9ED5B57161FE89B83"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11");
    } else if(var_0 == game["_encstr_B6A70A23CA6659DC91CAE4DC"]) {
      if(level.rushtimer && getflagcount(var_0) == 2) {
        return;
      }
      setwinner(game["_encstr_991C0AB9ED5B57161FE89B83"], tolower(game[game["_encstr_B6A70A23CA6659DC91CAE4DC"]]) + "_encstr_86E60CDF8828C17A6380E6DB7D11");
    }
  }
}

ononeleftevent(var_0) {
  var_1 = scripts\mp\utility\game::getlastlivingplayer(var_0);
  var_1 thread givelastonteamwarning();
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self._id_14437))
    self._id_14437 = undefined;

  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(!flagownersalive(self.team) && _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getteamflagcount(self.team) == 2)
    scripts\mp\utility\dialog::statusdialog("_encstr_840A0D6253FAB77951F6827B8F73C3", var_1.team, 1);

  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = self;
  var_14 = var_13.team;
  var_15 = var_13.origin;
  var_16 = var_1.team;
  var_17 = var_1.origin;
  var_18 = 0;

  if(isDefined(var_0)) {
    var_17 = var_0.origin;
    var_18 = var_0 == var_1;
  }

  foreach(var_20 in var_1.touchtriggers) {
    var_21 = undefined;

    foreach(var_23 in level.objectives) {
      if(var_23.trigger == var_20) {
        var_21 = var_23;
        break;
      }
    }

    if(!isDefined(var_21)) {
      continue;
    }
    var_25 = var_21.ownerteam;

    if(var_16 != var_25) {
      if(!var_10)
        var_10 = 1;

      continue;
    }
  }

  foreach(var_21 in level.objectives) {
    var_20 = var_21.trigger;
    var_25 = var_21.ownerteam;

    if(var_25 == "_encstr_A7A408B9CA5D1D4E2C63") {
      var_28 = var_1 istouching(var_20);
      var_29 = var_13 istouching(var_20);

      if(var_28 || var_29) {
        if(var_21.claimteam == var_14) {
          if(!var_11) {
            if(var_10)
              var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8DFD0D67E0E384A31D4DD1D4A3F9EA");
            else {
              var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_AB3508737F830710ACDB");
              var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
            }

            var_11 = 1;
            thread scripts\common\utility::_id_13E0A(level._id_11B26, var_9, "_encstr_9AD10BF61657A2CD30606F6BE0");
            continue;
          }
        } else if(var_21.claimteam == var_16) {
          if(!var_12) {
            if(var_10)
              var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8DFD0D67E0E384A31D4DD1D4A3F9EA");
            else {
              var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
              var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
            }

            var_12 = 1;
            var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
            var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
            thread scripts\common\utility::_id_13E0A(level._id_11B26, var_9, "_encstr_ABA70A195633CADC324BDC76");
            continue;
          }
        }
      }
    } else if(var_25 != var_16) {
      if(!var_11) {
        var_30 = distsquaredcheck(var_20, var_17, var_15);

        if(var_30) {
          if(var_10)
            var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8DFD0D67E0E384A31D4DD1D4A3F9EA");
          else {
            var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_AB3508737F830710ACDB");
            var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_8E020FAB6877F10FCBEFD81F63FB9B901C");
          }

          var_11 = 1;
          thread scripts\common\utility::_id_13E0A(level._id_11B26, var_9, "_encstr_9AD10BF61657A2CD30606F6BE0");
          continue;
        }
      }
    } else if(!var_12) {
      var_31 = distsquaredcheck(var_20, var_17, var_15);

      if(var_31) {
        if(var_10)
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8DFD0D67E0E384A31D4DD1D4A3F9EA");
        else {
          var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_A20C07ABF304625E08");
          var_1 thread scripts\mp\awards::givemidmatchaward("_encstr_93D80ED6F646B2AFF0EB1995CCCA3791");
        }

        var_12 = 1;
        var_1 scripts\mp\utility\stats::incpersstat("_encstr_B1F7085B03F492AE98DB", 1);
        var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B1F7085B03F492AE98DB", var_1.pers["_encstr_B1F7085B03F492AE98DB"]);
        thread scripts\common\utility::_id_13E0A(level._id_11B26, var_9, "_encstr_ABA70A195633CADC324BDC76");
        continue;
      }
    }
  }

  thread checkallowspectating();
}

distsquaredcheck(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0.origin, var_1);
  var_4 = distancesquared(var_0.origin, var_2);

  if(var_3 < 105625 || var_4 < 105625) {
    if(!isDefined(var_0.modifieddefendcheck))
      return 1;
    else if(var_1[2] - var_0.origin[2] < 100 || var_2[2] - var_0.origin[2] < 100)
      return 1;
    else
      return 0;
  } else
    return 0;
}

givelastonteamwarning() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\utility\player::waittillrecoveredhealth(3);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "_encstr_88101078BE5C37CD984FAC9EDB23672DB507");
  var_0 = scripts\mp\utility\game::getotherteam(self.pers["_encstr_8AEF05472BC2D6"])[0];
  level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_AB591C8E66FAE1D845FBD978977B7319B28E7101FF4245C12AC748582385", self, self.pers["_encstr_8AEF05472BC2D6"]);
  level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_81D01736858DB1BDAE8E7D1BB09B3AACCDB2DA97851B4BB395", self, var_0);
  level notify("_encstr_B6420BE367A3B0A1F7EB43C33F", self);
}

ontimelimit() {
  if(isDefined(level.siegegameinactive)) {
    level.forcedend = 1;
    thread scripts\mp\gamelogic::endgame("_encstr_8BBA05185F8B99", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_A5C310E3634F023961355A0D304FB66B267D"]);
    return;
  } else {
    var_0 = getflagcount("_encstr_9A8507BA4040188D08");
    var_1 = getflagcount("_encstr_8E8405EA382B2A");

    if(var_0 > var_1)
      setwinner("_encstr_9A8507BA4040188D08", "_encstr_83470FAA89A3B9E7FEDDB590079F6BE7A0", "_encstr_A519106F52E5470A97CE0907A7D935CF2B3B");
    else if(var_1 > var_0)
      setwinner("_encstr_8E8405EA382B2A", "_encstr_83470FAA89A3B9E7FEDDB590079F6BE7A0", "_encstr_A519106F52E5470A97CE0907A7D935CF2B3B");
    else
      setwinner("_encstr_8D19048EA595", "_encstr_AF9C0A077B223BF35F4BF34B");
  }
}

teamrespawn(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::getteamdata(var_1.team, "_encstr_AB580A05672AE35D5FFF50B8");

  if(!isDefined(var_1.rescuedplayers))
    var_1.rescuedplayers = [];

  foreach(var_4 in level.participants) {
    if(isDefined(var_4) && var_4.team == var_0 && !scripts\mp\utility\player::isreallyalive(var_4) && !scripts\engine\utility::array_contains(scripts\mp\utility\teams::getfriendlyplayers(var_4.team, 1), var_4) && (!isDefined(var_4.waitingtoselectclass) || !var_4.waitingtoselectclass)) {
      if(isDefined(var_4.siegelatecomer) && var_4.siegelatecomer)
        var_4.siegelatecomer = 0;

      if(!istrue(var_4.pers["_encstr_8CED0F31BD8EB86A6F0230BFFB1B231064"])) {
        if(istrue(var_4._id_14437)) {
          continue;
        }
        var_4._id_14437 = 1;
        var_4 thread scripts\mp\playerlogic::waittillcanspawnclient(0);
        var_4 thread scripts\mp\rank::scoreeventpopup("_encstr_8E4208C9ACEC5A3BAC46");
        level notify("_encstr_8AC2144BBA77A81922DF8BAD2F7BD5E8F0D67360E7B4", var_4);
        var_4 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_8E4208C9ACEC5A3BAC46");
      }

      var_1.rescuedplayers[var_4.guid] = 1;
    }
  }

  self.playersrevived = var_1.rescuedplayers.size;
}

notifyplayers(var_0) {
  foreach(var_2 in level.players)
  var_2 thread scripts\mp\hud_message::showsplash(var_0);

  level notify("_encstr_B62312B008A02E7917D01BB53C48490FCB354885", "_encstr_84EF055338A18F");
  level notify(var_0);
}

giveflagcapturexp(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_3 = var_2;

  if(isDefined(var_3.owner))
    var_3 = var_3.owner;

  level.lastcaptime = gettime();

  if(isPlayer(var_3)) {
    level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_B6C51896FF899237F3C017BF50E9E5BB6385DA0D5E2B4B49D838" + self.objectivekey, var_3);
    var_3 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_95EB0866891B23FB85B3", var_3.origin);
  }

  var_4 = getarraykeys(var_0);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_0[var_4[var_5]].player;

    if(isDefined(var_6.owner))
      var_6 = var_6.owner;

    if(!isPlayer(var_6)) {
      continue;
    }
    var_6 thread updatecpm();

    if(var_6.cpm > 3) {
      var_7 = 0;
      var_8 = 0;
    } else if(var_6.numcaps > 5) {
      var_7 = 125;
      var_8 = 50;
    } else if(self.objectivekey == "_encstr_B40703E96D" || var_1 != "_encstr_A7A408B9CA5D1D4E2C63" || self.playersrevived > 0) {
      var_7 = undefined;
      var_8 = undefined;
    } else {
      var_7 = 125;
      var_8 = 50;
    }

    var_6 thread scripts\mp\rank::scoreeventpopup("_encstr_95EB0866891B23FB85B3");
    var_6 thread scripts\mp\awards::givemidmatchaward("_encstr_910C12EB5F372B88EF8AB9E1528756C80EBD5D63", var_8, var_7);
    var_6 scripts\mp\utility\stats::incpersstat("_encstr_81CF0936850ED1D54EACCD", 1);
    var_6 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_81CF0936850ED1D54EACCD", var_6.pers["_encstr_81CF0936850ED1D54EACCD"]);
    var_6 scripts\mp\utility\stats::setextrascore0(var_6.pers["_encstr_81CF0936850ED1D54EACCD"]);
    var_6 scripts\mp\utility\stats::incpersstat("_encstr_8294083A0938C3CB2577", self.playersrevived);
    var_6 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_8294083A0938C3CB2577", var_6.pers["_encstr_8294083A0938C3CB2577"]);
    var_6 scripts\mp\utility\stats::setextrascore1(var_6.pers["_encstr_8294083A0938C3CB2577"]);
    wait 0.05;
  }

  self.playersrevived = 0;
}

getcapxpscale() {
  if(self.cpm < 4)
    return 1;
  else
    return 0.25;
}

updatecpm() {
  if(!isDefined(self.cpm)) {
    self.numcaps = 0;
    self.cpm = 0;
  }

  self.numcaps++;

  if(scripts\mp\utility\game::getminutespassed() < 1) {
    return;
  }
  self.cpm = self.numcaps / scripts\mp\utility\game::getminutespassed();
}

checkendgame() {
  var_0 = getflagcount("_encstr_9A8507BA4040188D08");
  var_1 = getflagcount("_encstr_8E8405EA382B2A");

  if(var_0 == level._id_11F45)
    setwinner("_encstr_9A8507BA4040188D08", "_encstr_97901387090760E52F5AC8B0529BAF28DAA7070BA6", "_encstr_ACE7141A4251AAB8183028F80EEB32C7D3EFBB37473A");
  else if(var_1 == level._id_11F45)
    setwinner("_encstr_8E8405EA382B2A", "_encstr_97901387090760E52F5AC8B0529BAF28DAA7070BA6", "_encstr_ACE7141A4251AAB8183028F80EEB32C7D3EFBB37473A");
}

runobjectives(var_0) {
  level.axisspawnareas = [level.axishqname];
  level.alliesspawnareas = [level.allieshqname];
  level.allfobs = [];

  foreach(var_2 in level.gw_objstruct.startingfobs_axis) {
    var_3 = runobjflag(var_2.trigger, "_encstr_8E8405EA382B2A");
    level.allfobs[level.allfobs.size] = var_2;
    level.axisspawnareas[level.axisspawnareas.size] = var_2.name;

    if(isDefined(level.spawnselectionlocations[var_2.name]["_encstr_8E8405EA382B2A"].anchorentity))
      level.spawnselectionlocations[var_2.name]["_encstr_8E8405EA382B2A"].anchorentity.origin = var_2.trigger.origin + (0, 0, 100);
  }

  foreach(var_2 in level.gw_objstruct.startingfobs_allies) {
    var_3 = runobjflag(var_2.trigger, "_encstr_9A8507BA4040188D08");
    level.allfobs[level.allfobs.size] = var_2;
    level.alliesspawnareas[level.alliesspawnareas.size] = var_2.name;

    if(isDefined(level.spawnselectionlocations[var_2.name]["_encstr_9A8507BA4040188D08"].anchorentity))
      level.spawnselectionlocations[var_2.name]["_encstr_9A8507BA4040188D08"].anchorentity.origin = var_2.trigger.origin + (0, 0, 100);
  }

  foreach(var_2 in level.gw_objstruct.startingfobs_neutral) {
    if(level._id_11F45 == 3) {
      if(level.mapname == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
        if(var_2.trigger.objkey == "_encstr_B20703DFCF" || var_2.trigger.objkey == "_encstr_950703EBCA")
          continue;
        else
          _id_12BBD(var_2.trigger);
      } else if(level.mapname == "_encstr_93FB0A6B1C7D2CB92D5EB00D") {
        if(var_2.trigger.objkey == "_encstr_B40703E96D" || var_2.trigger.objkey == "_encstr_A2070318DC")
          continue;
        else
          _id_12BBD(var_2.trigger);
      } else if(level.mapname == "_encstr_93D20D28714743B99070632BAF3944") {
        if(var_2.trigger.objkey == "_encstr_B40703E96D" || var_2.trigger.objkey == "_encstr_A2070318DC")
          continue;
        else
          _id_12BBD(var_2.trigger);
      } else if(level.mapname == "_encstr_876510B60EF583E4B76B2BB9851995BED9BB") {
        if(var_2.trigger.objkey == "_encstr_B20703DFCF" || var_2.trigger.objkey == "_encstr_950703EBCA")
          continue;
        else
          _id_12BBD(var_2.trigger);
      } else if(level.mapname == "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE") {
        if(var_2.trigger.objkey == "_encstr_B40703E96D" || var_2.trigger.objkey == "_encstr_A2070318DC")
          continue;
        else
          _id_12BBD(var_2.trigger);
      } else if(var_2.trigger.objkey == "_encstr_B20703DFCF" || var_2.trigger.objkey == "_encstr_950703EBCA")
        continue;
      else
        _id_12BBD(var_2.trigger);
    }

    var_3 = runobjflag(var_2.trigger, "_encstr_A7A408B9CA5D1D4E2C63");
    level.allfobs[level.allfobs.size] = var_2;
  }

  var_9 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_BA33174DC1D9FFF7805B3B52A3601F36B85BEBF75F68863B3D");
  var_10 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_B49D1979D239072B9F7730A07FF66643B27DE3F5EAD1F773891B18");
  level.startpos["_encstr_9A8507BA4040188D08"] = var_10[0].origin;
  level.startpos["_encstr_8E8405EA382B2A"] = var_9[0].origin;

  foreach(var_2 in level.allfobs) {
    var_12 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getreservedobjid(var_2.trigger.gameobject.objectivekey);
    var_2.trigger.gameobject scripts\mp\gameobjects::requestid(1, 1, var_12);
    var_2.trigger.gameobject.onuse = ::onuse;
    var_2.trigger.gameobject.onbeginuse = ::onbeginuse;
    var_2.trigger.gameobject.onuseupdate = ::onuseupdate;
    var_2.trigger.gameobject.onenduse = ::onenduse;
    var_2.trigger.gameobject.oncontested = ::oncontested;
    var_2.trigger.gameobject.onuncontested = ::onuncontested;
    var_2.trigger.gameobject.onunoccupied = ::onunoccupied;
    var_2.trigger.gameobject.onpinnedstate = ::onpinnedstate;
    var_2.trigger.gameobject.onunpinnedstate = ::onunpinnedstate;
    var_2.trigger.gameobject._id_138B2 = ::_id_12093;
    var_2.trigger.gameobject.stompprogressreward = ::stompprogressreward;
    var_2.trigger.gameobject scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_8F361077FED381AD0833C589FCA8DA67776B");
    var_2.trigger.gameobject scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_2.trigger.gameobject _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::domflag_setneutral();
    level.objectives[var_2.trigger.gameobject.objectivekey] = var_2.trigger.gameobject;
  }

  level.bestspawnflag = [];
  level.bestspawnflag["_encstr_9A8507BA4040188D08"] = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getunownedflagneareststart("_encstr_9A8507BA4040188D08", undefined);
  level.bestspawnflag["_encstr_8E8405EA382B2A"] = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::getunownedflagneareststart("_encstr_8E8405EA382B2A", level.bestspawnflag["_encstr_9A8507BA4040188D08"]);

  if(level.precappoints)
    _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::precap(level._id_11F45 == 5);

  _encstr_9B711DDCB1272D073A37BC6BC197CE16B6568E970EB2DCF2C8BDB55CD9CD36::flagsetup();
  level thread objective_manageobjectivesintrovisibility();
  level thread _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::brking_getspawnpoint();
}

objective_manageobjectivesintrovisibility() {
  wait 1;

  foreach(var_1 in level.allfobs)
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_1.trigger.gameobject.objidnum);

  while(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    waitframe();

  foreach(var_1 in level.allfobs)
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(var_1.trigger.gameobject.objidnum);
}

_id_12BBD(var_0) {
  if(level.mapname == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB") {
    if(var_0.objkey == "_encstr_B40703E96D" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B20703DFCF";
      var_0.objkey = "_encstr_B20703DFCF";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_B6070359BA" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B6070359BA";
      var_0.objkey = "_encstr_B40703E96D";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_A2070318DC" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_A2070318DC";
      var_0.objkey = "_encstr_B6070359BA";
      var_0.script_label = var_0.objkey;
    }
  } else if(level.mapname == "_encstr_831E0F7F2968E2AFC819F0FED3B0D70AD4") {
    if(var_0.objkey == "_encstr_B40703E96D" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B40703E96D";
      var_0.objkey = "_encstr_B20703DFCF";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_A2070318DC" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_A2070318DC";
      var_0.objkey = "_encstr_B40703E96D";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_B6070359BA" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B6070359BA";
      var_0.objkey = "_encstr_B6070359BA";
      var_0.script_label = var_0.objkey;
    }
  } else if(level.mapname == "_encstr_93FB0A6B1C7D2CB92D5EB00D") {
    if(var_0.objkey == "_encstr_B20703DFCF" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B20703DFCF";
      var_0.objkey = "_encstr_B20703DFCF";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_B6070359BA" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B6070359BA";
      var_0.objkey = "_encstr_B40703E96D";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_950703EBCA" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_950703EBCA";
      var_0.objkey = "_encstr_B6070359BA";
      var_0.script_label = var_0.objkey;
    }
  } else if(level.mapname == "_encstr_876510B60EF583E4B76B2BB9851995BED9BB") {
    if(var_0.objkey == "_encstr_B40703E96D" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B40703E96D";
      var_0.objkey = "_encstr_B20703DFCF";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_B6070359BA" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B6070359BA";
      var_0.objkey = "_encstr_B40703E96D";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_A2070318DC" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_950703EBCA";
      var_0.objkey = "_encstr_B6070359BA";
      var_0.script_label = var_0.objkey;
    }
  } else if(level.mapname == "_encstr_93D20D28714743B99070632BAF3944") {
    if(var_0.objkey == "_encstr_B20703DFCF" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B20703DFCF";
      var_0.objkey = "_encstr_B20703DFCF";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_B6070359BA" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B6070359BA";
      var_0.objkey = "_encstr_B40703E96D";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_950703EBCA" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_950703EBCA";
      var_0.objkey = "_encstr_B6070359BA";
      var_0.script_label = var_0.objkey;
    }
  } else if(level.mapname == "_encstr_A62810B638BEE44BD9AC396ED232CAF5B3EE") {
    if(var_0.objkey == "_encstr_B20703DFCF" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B20703DFCF";
      var_0.objkey = "_encstr_B20703DFCF";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_B6070359BA" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_B6070359BA";
      var_0.objkey = "_encstr_B40703E96D";
      var_0.script_label = var_0.objkey;
    } else if(var_0.objkey == "_encstr_950703EBCA" && !isDefined(var_0._id_11FCB)) {
      var_0._id_11FCB = "_encstr_950703EBCA";
      var_0.objkey = "_encstr_B6070359BA";
      var_0.script_label = var_0.objkey;
    }
  } else if(var_0.objkey == "_encstr_B40703E96D" && !isDefined(var_0._id_11FCB)) {
    var_0._id_11FCB = "_encstr_B40703E96D";
    var_0.objkey = "_encstr_B20703DFCF";
    var_0.script_label = var_0.objkey;
  } else if(var_0.objkey == "_encstr_B6070359BA" && !isDefined(var_0._id_11FCB)) {
    var_0._id_11FCB = "_encstr_B6070359BA";
    var_0.objkey = "_encstr_B40703E96D";
    var_0.script_label = var_0.objkey;
  } else if(var_0.objkey == "_encstr_A2070318DC" && !isDefined(var_0._id_11FCB)) {
    var_0._id_11FCB = "_encstr_A2070318DC";
    var_0.objkey = "_encstr_B6070359BA";
    var_0.script_label = var_0.objkey;
  }
}

runobjflag(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0.script_label = var_0.objkey;
  var_2 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_0, undefined, 1);
  var_2.origin = var_0.origin;
  var_2 scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
  var_2.didstatusnotify = 0;
  var_2 scripts\mp\gameobjects::setownerteam(var_1);
  var_3 = "_encstr_9A19040BCDBC";

  if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63") {
    if(level.hideenemyfobs)
      var_3 = "_encstr_ACFC091AE8AB2FCBE15119";

    var_2.capturetime = gettime();
  }

  var_2 scripts\mp\gameobjects::setvisibleteam(var_3);
  return var_2;
}

_id_11AAF(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_2 = 0.0;
  var_3 = 0.5;
  thread _id_11AB0(var_2, var_3);
}

_id_11AB0(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(istrue(self._id_12CA6)) {
    return;
  }
  self._id_12CA6 = 1;
  self notify("_encstr_B60B0FCA9A60EFF8603C7D2137E1E7EBA9");

  if(!isDefined(var_0))
    var_0 = 0;

  var_2 = var_0;

  if(var_2 > 0) {
    var_3 = 0.0;
    var_4 = var_2 / level.framedurationseconds;
    var_5 = 1.0 / var_4;
    var_6 = 0;

    while(var_6 < var_4) {
      var_6++;
      var_3 = var_3 + var_5;
      var_3 = clamp(var_3, 0.0, 1.0);
      self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", var_3);
      waitframe();
    }
  } else
    self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", 1.0);

  self notify("_encstr_846A12C7CB49F517D04F68A71A88850BD5F8BB35");
  var_7 = 0;

  if(!scripts\mp\utility\player::isreallyalive(self)) {
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
    var_7 = 1;
  }

  if(var_7)
    scripts\mp\utility\player::hidehudenable();

  wait 1.0;
  self notify("_encstr_867E0DE2A9B51FDB1027D3DC7328DB");

  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = var_1;

  if(var_2 > 0) {
    var_3 = 1.0;
    var_4 = var_2 / level.framedurationseconds;
    var_5 = 1.0 / var_4;
    var_6 = 0;

    while(var_6 < var_4) {
      var_6++;
      var_3 = var_3 - var_5;
      var_3 = clamp(var_3, 0.0, 1.0);
      self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", var_3);
      waitframe();
    }
  } else
    self setclientomnvar("_encstr_B1920E5DA57D77DBC9B1C8D799169195", 0.0);

  if(var_7)
    scripts\mp\utility\player::hidehuddisable();

  self._id_12CA6 = undefined;
  self notify("_encstr_B43C108731387D4137B78F472BDF1AB56019");
}