/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\infect.gsc
***********************************************/

main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  var_0 = getdvarint("_encstr_BE9C0BD1E3C16D64B9DB4989F7") && !getdvarint("_encstr_93390B136AA2628AA8A93529D4");

  if(var_0)
    level.unset_relic_laststandmelee = getdvarint("_encstr_BD921B13A7F0B1CF58B92AB203383F32C023B68C170B8217709122BA2B", 0);

  var_1[0] = scripts\mp\utility\game::getgametype();
  var_1[var_1.size] = "_encstr_9A7205B39CB919";

  if(istrue(level.unset_relic_laststandmelee))
    var_1[var_1.size] = "_encstr_B81904B04E6B";

  scripts\mp\gameobjects::main(var_1);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility\game::registertimelimitdvar(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\dvars::setoverridewatchdvar("_encstr_B6FB0B93B87F020F183BE5E94D", 0);
    scripts\mp\utility\game::registerroundlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registerwinlimitdvar(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::registernumlivesdvar(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::registerhalftimedvar(scripts\mp\utility\game::getgametype(), 0);
  }

  updategametypedvars();
  level.packclientmatchdata = 0;
  level.packedbits = getdvarint("_encstr_A5B91DFBDEDD08D3F27EB89EBDC70B406A624F23BB07C3FA47F243561A3E58", 20);
  level.ignorekdrstats = 1;
  level.didhalfscorevoboost = 0;
  thread waitthensetstatgroupreadonly();
  level.teambased = 1;
  level.supportintel = 0;
  level.disableforfeit = 1;
  level.nobuddyspawns = 1;
  level.onstartgametype = ::onstartgametype;
  level.onplayerconnect = ::onplayerconnect;
  level.modeonspawnplayer = ::onspawnplayer;
  level.getspawnpoint = ::getspawnpoint;
  level.onplayerkilled = ::onplayerkilled;
  level.onnormaldeath = ::onnormaldeath;
  level.ondeadevent = ::ondeadevent;
  level.ontimelimit = ::ontimelimit;
  level.bypassclasschoicefunc = ::alwaysgamemodeclass;
  level.battle_tracks_stopbattletracksforplayer = ::steam_fx_off;
  level.playgotinfectedsoundcount = ::playgotinfectedsoundcount;

  if(istrue(level.setplayerselfrevivingextrainfo))
    level.modifyplayerdamage = scripts\mp\damage::gamemodemodifyplayerdamage;

  level.disablecopycatloadout = 1;
  setomnvar("_encstr_88D613AE96AFB6D21B8DB12CADAFC6DBC15E1BB0A3", 0);
  level.steam_damaged = getdvarint("_encstr_B86B130F10C5CF6A9EE1335B23D0E2B347CB50D982", 0);
  level.steam_damage_players = getdvarint("_encstr_ACF61797FF53D830EE1F21F983F7900BFB5F2D219FE918F03F", 0);
  level._id_12052 = getdvarint("_encstr_B83721CF184B579ACD2447FE1587B23ED020C31F18E3A9022BC648F57CAB5BEA98F067", 0);

  if(level.unset_relic_laststandmelee) {
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

    var_3 = 5000;

    if(scripts\cp_mp\utility\game_utility::unlink_on_ai_death())
      var_3 = 5000;
    else {
      switch (var_2) {
        case "_encstr_831E0F7F2968E2AFC819F0FED3B0D70AD4":
        case "_encstr_BA3F0A7D37E6935EE590C3CF":
        case "_encstr_AC880C67503EA82A05DD62214CE7":
        case "_encstr_93D20D28714743B99070632BAF3944":
        case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
        case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
          var_3 = 5000;
          break;
        default:
          var_3 = 5000;
      }
    }

    level.steam_fx_on = var_3;
    level.brmini_playerwelcomesplashes = getdvarint("_encstr_A3BA2343F642C983DADB83978B91DF18FFCE8ADBD3B9F05BF2E78BBDA3B91208B3E231D3C5", 0);
    level._id_133F8 = getdvarint("_encstr_927927979F6EA139388967EEA3D96BBA4379470B0B087ADC783114B57BD092838F51EFC7E3B1B2AE38", 1);
    level.brking_initfeatures = getdvarint("_encstr_B45F2413A7F0B1CF58B92AB2033827B5D817AFBB2FC00F977CF140DB2B975F6A18F738057998", 0);
    level._id_122FF = ::_id_122FF;
    level._id_13A06 = ::_id_13A06;
  }

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_922B1217B98DF8F52FC3115E3A1BA4A0A604AB99";

  if(getdvarint("_encstr_B2020AE1F36BF74429D93F01"))
    game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"] = "_encstr_8A19042AB017" + game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A5F909EC0B5B2B8EF20ECA"];

  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_91B2067E0898939B"] = "_encstr_A1CE0F98DEF6CD8EAF2D73332B6C3AB246";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_95240C659372588E43623137DE6C"] = "_encstr_A1CE0F98DEF6CD8EAF2D73332B6C3AB246";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_93420C4255FBEA5D408FD1FD2A62"] = "_encstr_A1CE0F98DEF6CD8EAF2D73332B6C3AB246";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9BBA0F01B55837FF4DD1C279592B636A60"] = "_encstr_9BBA0F01B55837FF4DD1C279592B636A60";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_925114D016C699EE85E5EB56E6566BE5BEB9C6F6C959"] = "_encstr_B1A2184B73CC56B1D15919BE430B3699DDB097D7C6DBB996B9EC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A2B8170D2C6399DD16CB7D3339D22B37911BCBBEB936DE9C2B"] = "_encstr_991F1AD29B9959D81D958C7DD08536CCDDC25ED733C9A52BE623C6F2";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A26D131C58EC01503BE17BAF4C338B132A11DA66F8"] = "_encstr_A26D131C58EC01503BE17BAF4C338B132A11DA66F8";
}

waitthensetstatgroupreadonly() {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 1;

  if(isDefined(level.playerstats)) {
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("_encstr_931904C47403");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("_encstr_956807294FC34ED073");
    scripts\mp\playerstats_interface::makeplayerstatgroupreadonly("_encstr_95FF08BB2D73137BDCE6");
  }
}

initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("_encstr_95CD1E6E36C9D72D9B66B2363AD737ABAD29CD4B8E4B58B19473CCAC6C3ACA8C", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_B45D130E8B0834D3DBFBEA928D331B37900FAC8D31"));
  setdynamicdvar("_encstr_B228212B9FC889C750A1224A0B2047FFB821BF8E57A88AF38B9B9AA3978E77B50BCD31", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_ACDD167795850EF6739A5D276796677B27144E4B5B2CC9F2"));
  setdynamicdvar("_encstr_8ED12363506D78DF56AD13969B478B7B2BE8A7E80797121C2BC3E8C6A96F1B90F56D961EEB", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_B6E418E3913048C2188FF7D3FDB39B9F70BF9F6E48E0E47A6EB3"));
  setdynamicdvar("_encstr_ABD51AB8F6201FA3A80D07FEC38FA00DC15829AA770B0393A8C3281B", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_91100FE9553368979329BB43635FD4984A"));
  setdynamicdvar("_encstr_8CF21C9B17EA7E436A1FCDC67391B16123E36808879CB723930333548D1B", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_8C8E112B3B46B399F0C9C5026350CE3AA44F4B"));
  setdynamicdvar("_encstr_9A81197B5702567BE6959B3014D646275B878BF2BBEB9B9B7CB043", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_927D0E97B36F0222D1EBA2AB2D90772B"));
  setdynamicdvar("_encstr_BDB81CB01AB28F188326F5FE2C1F03939AC23029934A05D0CB47067D0737", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_AA9911B9571C2B939AD52767D2CE7BE4A2DDF6"));
  setdynamicdvar("_encstr_9B741FFFF716D94150D14FD68B0187B2672907130BB0120550BB0A9AC0B8D9BBC3", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_8F20142FCDFBE31040BC567DFBA3B3D14E90D1813D47"));
  setdynamicdvar("_encstr_A9D521BF5FABA74B9DBF3FE7A3596C7381705F2554CDC5E3BB949912FE17122BE90BE1", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_BA0616532180F87248EBCBF3ABE60B131849CD9D79E8A22B"));
  setdynamicdvar("_encstr_876218B96C27FAD237332B8DD1D7B1CA1D34858D94CD3395C6D1", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_92040D81CF1B6B68043CB8B1DFF338"));
  setdynamicdvar("_encstr_A6051A501963171B3B68D7BF73E9E90907D8D04A204A113587DFFFEB", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_8FF50FD33BDF201336F173694A2A152E93"));
  setdynamicdvar("_encstr_87DE203736C97D5ADC99ACD8E87DEE2BB0077BE6529B2DA3A50BD828C92D5B169C5E", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_A6A0156F45C9E055B337400F2B9B4175BF538F0AAAB8E0"));
  setdynamicdvar("_encstr_8E5A22B9C64EFAA573332BC61DFADDB2C207DB9B4A9BD2E85AC28D6ACA1BBDE69185935E", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_B61117BB0F39D8E8824FADAB531A27C0E3E7A1307564181EAB"));
  setdynamicdvar("_encstr_932817DF5BAAC99B9342B1794B7F4E40C2B52523CE1750D683", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_AC070C5767B30528895D0179069C"));
  setdynamicdvar("_encstr_8E7C1A6ED89CBED23799B28D8EFA6EAE83564EA473CCACD8A345BB7B", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_8FAE0F9BEAE0ACE4529BCCCAB13A2ADDB7"));
  setdynamicdvar("_encstr_B4C822670FA328C0FE0F31C9B3E788F8BA7F3FE10FAB05C0096BB8AD9FB0D02E80F7A949", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_AC401798324F13B133ADD3CD728F9FF3756AC9704BAC43280B"));
  setdynamicdvar("_encstr_AFC01E0F078649D1C061FF461B71F3235EB5EFE3F72E109C900BF74211183A7A", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_B6C51392F5B533319318A37718A8E6CA0F061D4A55"));
  setdynamicdvar("_encstr_A3D01DF720731FD2957C0F865DCF4BFDDB10171BA8ABAB3AFF0E1773CB43E2", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_991812AB6D9B0B9425B89B81B07F0A1FF7DB0D35"));
  setdynamicdvar("_encstr_9A83207B5702567BE6959B3014D646275343E7BBF8EB3F9EF03E1FBA3DDB41F7FE72", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_87C115E657C9B3D2B3DBC99AC6B7C99514564EA2D2D86D"));
  setdynamicdvar("_encstr_BE461D23FE03371C9D08621A80A754BB3955BBBC1E2B5B27AB0818D2781B0A", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_AB1B128135D8B77FCD97432BB9AF87A6388D1503"));
  setdynamicdvar("_encstr_AF2021BB768BBFE46580FA92382FDFC3416E3C258BD093AF2768E2DA218D16BF7845AA", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_BE3B16AC73163163AC5237662B368EACC8A24E85B1DA594E"));
  setdynamicdvar("_encstr_B28516ABDFC219CBA39FED2799BFBBD33868DA61C7C32204", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_A9500BB2DCB0981BAC822D9BEC"));
  setdynamicdvar("_encstr_B1D91BC7CF3EF1698839B73E5329AF2A946BC3AFEF680971B903AE0308", getmatchrulesdata("_encstr_838E0B032DD27BC1DCB390300F", "_encstr_8CDB10377B9CF2F4C17C159354E9184AF49D"));
  setdynamicdvar("_encstr_A621104F98CBD7CB5B27C5719C7583A9D3C0", 0);
  setdynamicdvar("_encstr_8ADF139B10959F1B50A51558192F93835063B70D59", 0);
}

onstartgametype() {
  setclientnamemode("_encstr_B6900C7BCDABC8AF2722B158FA17");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"_encstr_859E1290A690BB457C07A939472FDC75B89F1E85");

    if(level.splitscreen)
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_859E1290A690BB457C07A939472FDC75B89F1E85");
    else
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"_encstr_815E1827B3181DD99C9C1F7532DFB1207037B7E92F51D6F1F2E7");

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"_encstr_AB541798AE98B35D640F91315F27D46D8087669D711013A40C");
  }

  initspawns();
  level.quickmessagetoall = 1;
  level.blockweapondrops = 1;
  level.infect_allowsuicide = 0;
  level.infect_skipsounds = 0;
  level._id_12738 = 0;
  level.infect_chosefirstinfected = 0;
  level.infect_choosingfirstinfected = 0;
  level.infect_awardedfinalsurvivor = 0;
  level.infect_countdowninprogress = 0;
  level.infect_teamscores["_encstr_8E8405EA382B2A"] = 0;
  level.infect_teamscores["_encstr_9A8507BA4040188D08"] = 0;
  level.infect_players = [];
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_B82710C38871C417183DD7E3C0C0A30EAFA0", "_encstr_AF2618A0BAE5ABC8DB12E57401BF504D8DF211B8D1FD3B22B74A", ::_id_14124);

  if(istrue(level.unset_relic_laststandmelee)) {
    _encstr_A2D91D6EC6C9B4C1D137CB5B38E59DC26BCA3ABC1C59DCE50B9C5BE29D6E1B::monitordriverexitbutton();
    thread superselectonunset();
    thread _id_119D8();
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    level.droptime = getdvarint("_encstr_AC3F1448E24A67F05B8E5D46747799C5F53BE910BA27", 30);

    if(level.droptime > 0)
      level thread _id_129FB();
  }
}

updategametypedvars() {
  _encstr_97EA20CDB1E44B1C3AB95EB583F2D9B05B95A3F2E056B9CBD8BDB66BF673B8D9CDB1::updatecommongametypedvars();
  level.numinitialinfected = scripts\mp\utility\dvars::dvarintvalue("_encstr_B45D130E8B0834D3DBFBEA928D331B37900FAC8D31", 1, 1, 9);
  level.survivorprimaryweapon = getDvar("_encstr_B228212B9FC889C750A1224A0B2047FFB821BF8E57A88AF38B9B9AA3978E77B50BCD31", "_encstr_925D13A28841F9E728B06A7FB1514FE8B74A497A18");
  level.survivorsecondaryweapon = getDvar("_encstr_8ED12363506D78DF56AD13969B478B7B2BE8A7E80797121C2BC3E8C6A96F1B90F56D961EEB", "_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B");
  level.survivorlethal = getDvar("_encstr_ABD51AB8F6201FA3A80D07FEC38FA00DC15829AA770B0393A8C3281B", "_encstr_82A70F2B3B73E33B472371FF21D7809DDF");
  level.survivortactical = getDvar("_encstr_8CF21C9B17EA7E436A1FCDC67391B16123E36808879CB723930333548D1B", "_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E");
  level.survivorsuper = getDvar("_encstr_9A81197B5702567BE6959B3014D646275B878BF2BBEB9B9B7CB043", "_encstr_923A10D7F32F4262F18BA62E06F8B7AB0D55");
  level._id_139BD = getDvar("_encstr_BDB81CB01AB28F188326F5FE2C1F03939AC23029934A05D0CB47067D0737", "_encstr_8BBA05185F8B99");
  level.infectedprimaryweapon = getDvar("_encstr_9B741FFFF716D94150D14FD68B0187B2672907130BB0120550BB0A9AC0B8D9BBC3", "_encstr_BED80D7C9C59D95BF870DBDFA9F018");
  level.infectedsecondaryweapon = getDvar("_encstr_A9D521BF5FABA74B9DBF3FE7A3596C7381705F2554CDC5E3BB949912FE17122BE90BE1", "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  level.initialprimaryweapon = getDvar("_encstr_87DE203736C97D5ADC99ACD8E87DEE2BB0077BE6529B2DA3A50BD828C92D5B169C5E", "_encstr_925D13A28841F9E728B06A7FB1514FE8B74A497A18");
  level.initialsecondaryweapon = getDvar("_encstr_8E5A22B9C64EFAA573332BC61DFADDB2C207DB9B4A9BD2E85AC28D6ACA1BBDE69185935E", "_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B");
  level.infectedlethal = getDvar("_encstr_876218B96C27FAD237332B8DD1D7B1CA1D34858D94CD3395C6D1", "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381");
  level.infectedtactical = getDvar("_encstr_A6051A501963171B3B68D7BF73E9E90907D8D04A204A113587DFFFEB", "_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A");
  level.infectedsuper = getDvar("_encstr_932817DF5BAAC99B9342B1794B7F4E40C2B52523CE1750D683", "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D");
  level.steam_dmg_trigger_think = getDvar("_encstr_8E7C1A6ED89CBED23799B28D8EFA6EAE83564EA473CCACD8A345BB7B", scripts\engine\utility::ter_op(level.unset_relic_laststandmelee, "_encstr_B81811B9AE8356C9F51D856CD7B437CDAC27D1", "_encstr_8BBA05185F8B99"));
  level.infectextratimeperkill = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_AC401798324F13B133ADD3CD728F9FF3756AC9704BAC43280B", 30, 0, 60);
  level.survivoralivescore = scripts\mp\utility\dvars::dvarintvalue("_encstr_B6C51392F5B533319318A37718A8E6CA0F061D4A55", 25, 0, 100);
  level.survivorscoretime = scripts\mp\utility\dvars::dvarfloatvalue("_encstr_991812AB6D9B0B9425B89B81B07F0A1FF7DB0D35", 30, 0, 60);
  level.survivorscorepertick = scripts\mp\utility\dvars::dvarintvalue("_encstr_87C115E657C9B3D2B3DBC99AC6B7C99514564EA2D2D86D", 50, 0, 100);
  level.infectstreakbonus = scripts\mp\utility\dvars::dvarintvalue("_encstr_AB1B128135D8B77FCD97432BB9AF87A6388D1503", 50, 0, 100);
  level.enableinfectedtracker = scripts\mp\utility\dvars::dvarintvalue("_encstr_BE3B16AC73163163AC5237662B368EACC8A24E85B1DA594E", 0, 0, 1);
  level.enableping = scripts\mp\utility\dvars::dvarintvalue("_encstr_A9500BB2DCB0981BAC822D9BEC", 0, 0, 1);
  level.givetkontispawn = scripts\mp\utility\dvars::dvarintvalue("_encstr_8CDB10377B9CF2F4C17C159354E9184AF49D", 0, 0, 1);
  level.stealth_broken_music = getdvarint("_encstr_BA9B1C0FFE401F50F6E8C84FF3819BB26292BF8470474D030FD1C388B35A", 150);
  level.stealth_broken_music_index = getdvarint("_encstr_8FE623B3E9BEF7D4E055C5CB59419C6BEC41CA4B5598FB0BF027EDC003702DA39E5B62E378", 0);
  level.stealth_enabled = getdvarint("_encstr_937F277EAB0326034DBAC8F0B329DBD8BB558E7522CF487372F170705ABADF902BF9067396D791859B", 0);
  level.play_player_approach = getdvarint("_encstr_AACC1DE68DE4FA5A7399ACD88E7D334BCD16C64DD5D94BB3B74E86DBABB91D", 1);
  level.steam_point_think = getdvarint("_encstr_B20A22F3CE33072CAD58326AF0F7E2A7AB3E699C579BFF350528BA6190C59B4F0318E203", 8);
  level._id_139BC = [];
  var_0 = getDvar("_encstr_815A225F379B1088A65779B1FBAF60BD33FBE3ADEF43DE28D2EFE1882D6E18764B2F6103", "_encstr_B40101");

  if(var_0 != "_encstr_B40101")
    level._id_139BC = strtok(var_0, "_encstr_964C0249");

  var_1 = scripts\cp_mp\utility\game_utility::getmapname();

  if(issubstr(var_1, "_encstr_AA1606AD077DB6FA") && var_1 != "_encstr_A5110B50E25F68A83BD3D3EBBB") {
    level.survivorsuper = player_give_intel_3_ks(0, 0);
    level._id_139BD = player_give_intel_3_ks(0, 1);
    level.infectedsuper = player_give_intel_3_ks(1, 0);
    level.steam_dmg_trigger_think = player_give_intel_3_ks(1, 1);
  }

  if(level.survivorsuper == level._id_139BD)
    level._id_139BD = "_encstr_8BBA05185F8B99";
  else if(level.survivorsuper == "_encstr_8BBA05185F8B99" && level._id_139BD != "_encstr_8BBA05185F8B99") {
    level.survivorsuper = level._id_139BD;
    level._id_139BD = "_encstr_8BBA05185F8B99";
  }

  if(level.infectedsuper == level.steam_dmg_trigger_think)
    level.steam_dmg_trigger_think = "_encstr_8BBA05185F8B99";
  else if(level.infectedsuper == "_encstr_8BBA05185F8B99" && level.steam_dmg_trigger_think != "_encstr_8BBA05185F8B99") {
    level.infectedsuper = level.steam_dmg_trigger_think;
    level.steam_dmg_trigger_think = "_encstr_8BBA05185F8B99";
  }

  thread buildandloadweapons();
}

buildandloadweapons() {
  waitframe();

  if(level._id_12052) {
    switch (level.survivorprimaryweapon) {
      case "_encstr_8DE1122D770EFA9BA1AF46832CC1C22664BEB5C1":
        level.arenaloadouts = 10;
        break;
      case "_encstr_84FC12199FB2A1FF466E9A22B0910FB372678588":
        level.arenaloadouts = 7;
        break;
      case "_encstr_8B98105A770ED71C5ABE46AC1B0DF6AFB61C":
        level.arenaloadouts = 9;
        break;
      case "_encstr_AFD81196BB83FADCDA7D0785832C9C817DAD83":
        level.arenaloadouts = 8;
        break;
      case "_encstr_8F091280BBC06FBB63BF57D988A321732AC128D0":
        level.arenaloadouts = 11;
        break;
      default:
        level.arenaloadouts = 7;
        break;
    }

    _encstr_8F431F033E8D20B1DDCB708D3270CF09537A130B900DBA08F8E65DC88B762F677F::cacherandomloadouts();
    level.survivorprimaryweapon = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];
    level.survivorprimaryweapon = level.survivorprimaryweapon + "_encstr_851A049F8337";

    if(game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] != "_encstr_8BBA05185F8B99") {
      level.survivorsecondaryweapon = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"];
      level.survivorsecondaryweapon = level.survivorsecondaryweapon + "_encstr_851A049F8337";
    }

    level.initialprimaryweapon = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"];
    level.initialprimaryweapon = level.initialprimaryweapon + "_encstr_851A049F8337";

    if(game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] != "_encstr_8BBA05185F8B99") {
      level.initialsecondaryweapon = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"];
      level.initialsecondaryweapon = level.initialsecondaryweapon + "_encstr_851A049F8337";
    }
  }

  level.allweapons = [];
  level.allweapons[level.allweapons.size] = level.survivorprimaryweapon;
  level.allweapons[level.allweapons.size] = level.survivorsecondaryweapon;
  level.allweapons[level.allweapons.size] = level.infectedprimaryweapon;
  level.allweapons[level.allweapons.size] = level.infectedsecondaryweapon;
  level.allweapons[level.allweapons.size] = level.initialprimaryweapon;
  level.allweapons[level.allweapons.size] = level.initialsecondaryweapon;
  level.survivorprimaryweapon = stripweapsuffix(level.survivorprimaryweapon);
  level.survivorsecondaryweapon = stripweapsuffix(level.survivorsecondaryweapon);
  level.infectedprimaryweapon = stripweapsuffix(level.infectedprimaryweapon);
  level.infectedsecondaryweapon = stripweapsuffix(level.infectedsecondaryweapon);
  level.initialprimaryweapon = stripweapsuffix(level.initialprimaryweapon);
  level.initialsecondaryweapon = stripweapsuffix(level.initialsecondaryweapon);

  foreach(var_1 in level.allweapons) {
    if(var_1 != "_encstr_8BBA05185F8B99") {
      var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1);
      var_3 = [];

      if(level._id_12052) {
        if(var_1 == level.allweapons[0] || var_1 == level.allweapons[4]) {
          for(var_4 = 1; var_4 < 6; var_4++) {
            var_5 = var_4;

            if(var_4 == 1)
              var_5 = "_encstr_B40101";

            var_6 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878" + var_5];

            if(var_6 != "_encstr_8BBA05185F8B99")
              var_3[var_3.size] = var_6;
          }
        }

        if(var_1 == level.allweapons[1] || var_1 == level.allweapons[5]) {
          for(var_4 = 1; var_4 < 6; var_4++) {
            var_5 = var_4;

            if(var_4 == 1)
              var_5 = "_encstr_B40101";

            var_6 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB" + var_5];

            if(var_6 != "_encstr_8BBA05185F8B99")
              var_3[var_3.size] = var_6;
          }
        }
      }

      if(level.steam_damaged)
        game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = run_func_on_each_player();

      var_7 = "_encstr_8BBA05185F8B99";
      var_8 = "_encstr_8BBA05185F8B99";
      var_9 = scripts\mp\class::buildweapon(var_2, var_3, var_7, var_8);
      var_10 = createheadicon(var_9);
    }
  }

  level thread setspecialloadouts();
}

run_func_on_each_player() {
  var_0 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] + "_encstr_851A049F8337";
  var_1 = weaponclass(var_0);
  level._id_14543 = var_1;
  var_2 = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"];

  switch (var_1) {
    case "_encstr_BE1904DCDA9D":
    case "_encstr_BE0703A54C":
    case "_encstr_965306392D3336B2":
      var_3 = randomintrange(0, 3);

      if(var_3 == 0)
        var_2 = "_encstr_A3CA081B50EDAB3D60A9";
      else if(var_3 == 0)
        var_2 = "_encstr_A77609BB28C102A2BB490A";
      else
        var_2 = "_encstr_8C0308D0CBC439A5C899";

      break;
    case "_encstr_850707F7E5833355B8":
      var_3 = randomintrange(0, 3);

      if(var_3 == 0)
        var_2 = "_encstr_A3CA081B50EDAB3D60A9";
      else if(var_3 == 0)
        var_2 = "_encstr_A77609BB28C102A2BB490A";
      else
        var_2 = "_encstr_A1B50AB34B01F3D8501868A5";

      break;
    case "_encstr_A1100738A33A638123":
      var_2 = "_encstr_A3CA081B50EDAB3D60A9";
    case "_encstr_BA080F126090E3D245A1F7BFBDE6CA25A0":
      break;
    case "_encstr_8D940738966ED1DB8D":
      break;
    default:
      break;
  }

  return var_2;
}

stripweapsuffix(var_0) {
  if(issubstr(var_0, "_encstr_AA1904D6074E"))
    var_0 = scripts\mp\utility\script::strip_suffix(var_0, "_encstr_8A430599F1885A");
  else if(issubstr(var_0, "_encstr_B81904B60E63"))
    var_0 = scripts\mp\utility\script::strip_suffix(var_0, "_encstr_834305A18D89D8");
  else
    var_0 = scripts\mp\utility\script::strip_suffix(var_0, "_encstr_851A049F8337");

  return var_0;
}

player_give_intel_3_ks(var_0, var_1) {
  if(istrue(var_1))
    var_2 = scripts\engine\utility::ter_op(var_0, level.steam_dmg_trigger_think, level._id_139BD);
  else
    var_2 = scripts\engine\utility::ter_op(var_0, level.infectedsuper, level.survivorsuper);

  switch (var_2) {
    case "_encstr_B12F1220EBA20B8BB7A7656F984F30B70F0348C0":
    case "_encstr_995B109BAB0756E47DCA5B837D914EEDB995":
    case "_encstr_955F12039B0FAFA2B9AD353BBF18A113B6704AEA":
      var_2 = "_encstr_96F610C7E33F527201D9B5BD3029AC9B1841";
      break;
    case "_encstr_B81811B9AE8356C9F51D856CD7B437CDAC27D1":
      if(var_0 && level.infectedtactical == "_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A")
        level.infectedtactical = "_encstr_8BBA05185F8B99";
      else if(level.survivortactical == "_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A")
        level.survivortactical = "_encstr_8BBA05185F8B99";

      break;
    case "_encstr_9B2F0D5B9D2BB782A7B02BF27821B8":
      if(var_0 && level.infectedtactical == "_encstr_AA870D15FAF37393C74318F8BB184A")
        level.infectedtactical = "_encstr_8BBA05185F8B99";
      else if(level.survivortactical == "_encstr_AA870D15FAF37393C74318F8BB184A")
        level.survivortactical = "_encstr_8BBA05185F8B99";

      break;
  }

  return var_2;
}

onplayerconnect(var_0) {
  var_0.gamemodefirstspawn = 1;
  var_0.gamemodejoinedatstart = 1;
  var_0.infectedrejoined = 0;
  var_0.waitedtospawn = 0;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") || level.infect_countdowninprogress)
    var_0.waitedtospawn = 1;

  var_0.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
  var_0.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
  var_0.class = var_0.pers["_encstr_959506B911C79707"];
  var_0.lastclass = var_0.pers["_encstr_92690A5B078ED325F539E25E"];
  var_0 loadweaponsforplayer(level.allweapons, 1);

  if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    var_0.gamemodejoinedatstart = 0;

    if(isDefined(level.infect_chosefirstinfected) && level.infect_chosefirstinfected)
      var_0.survivalstarttime = gettime();
  }

  if(isDefined(level.infect_players[var_0.name]))
    var_0.infectedrejoined = 1;

  if(isDefined(var_0.isinitialinfected))
    var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"];
  else if(var_0.infectedrejoined)
    var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.infect_loadouts["_encstr_8E8405EA382B2A"];
  else
    var_0.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.infect_loadouts["_encstr_9A8507BA4040188D08"];

  var_0 thread monitorsurvivaltime();

  if(level.unset_relic_laststandmelee)
    var_0 thread _id_133F7();
}

givesurvivortimescore() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait(level.survivorscoretime);

    foreach(var_1 in level.players) {
      if(var_1.team == "_encstr_9A8507BA4040188D08")
        var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A52C093330A23B194C60BB", undefined, level.survivorscorepertick);
    }
  }
}

initspawns() {
  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    level.gamemodestartspawnpointnames = [];
    var_0 = "_encstr_B49D1979D239072B9F7730A07FF66643B27DE3F5EAD1F773891B18";
    var_1 = "_encstr_BA33174DC1D9FFF7805B3B52A3601F36B85BEBF75F68863B3D";
    level.gamemodestartspawnpointnames["_encstr_9A8507BA4040188D08"] = var_0;
    level.gamemodestartspawnpointnames["_encstr_8E8405EA382B2A"] = var_1;
    level.gamemodespawnpointnames = [];
    level.gamemodespawnpointnames["_encstr_9A8507BA4040188D08"] = "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD";
    level.gamemodespawnpointnames["_encstr_8E8405EA382B2A"] = "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD";
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);

    if(scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_93FB0A6B1C7D2CB92D5EB00D")
      scripts\mp\spawnlogic::setactivespawnlogic("_encstr_97B00F74E4BD5DCD8CBA85C9A215C49E9A", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    else if(scripts\cp_mp\utility\game_utility::islargemap())
      scripts\mp\spawnlogic::setactivespawnlogic("_encstr_81CC0A74C9EDD5B98CEA859C", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    else
      scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");

    scripts\mp\spawnlogic::addstartspawnpoints("_encstr_B49D1979D239072B9F7730A07FF66643B27DE3F5EAD1F773891B18");
    scripts\mp\spawnlogic::addstartspawnpoints("_encstr_BA33174DC1D9FFF7805B3B52A3601F36B85BEBF75F68863B3D");
    scripts\mp\spawnlogic::addspawnpoints(game["_encstr_991C0AB9ED5B57161FE89B83"], "_encstr_B49D1979D239072B9F7730A07FF66643B27DE3F5EAD1F773891B18");
    scripts\mp\spawnlogic::addspawnpoints(game["_encstr_B6A70A23CA6659DC91CAE4DC"], "_encstr_BA33174DC1D9FFF7805B3B52A3601F36B85BEBF75F68863B3D");
    var_2 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_B49D1979D239072B9F7730A07FF66643B27DE3F5EAD1F773891B18");
    var_3 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_BA33174DC1D9FFF7805B3B52A3601F36B85BEBF75F68863B3D");
    scripts\mp\spawnlogic::registerspawnset("_encstr_8203101FF33885AB060225CD31A68A4B6AD7", var_2);
    scripts\mp\spawnlogic::registerspawnset("_encstr_9AE3109755F34D5879256960F390C8FFD207", var_3);
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
    var_4 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    var_5 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
    scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_4);
    scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_5);
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("_encstr_8B1608CC43B8D647A113", "_encstr_829A0D0F1AF8FB5ED127855073F940");
    level.spawnmins = (0, 0, 0);
    level.spawnmaxs = (0, 0, 0);
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    scripts\mp\spawnlogic::addspawnpoints("_encstr_9A8507BA4040188D08", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("_encstr_8E8405EA382B2A", "_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318", 1, 1);
    var_4 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    var_5 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_88E81740C30EE3BB17B06283F7DB7287B7C058E0C09017D318");
    scripts\mp\spawnlogic::registerspawnset("_encstr_820E07FAE8780B3A4C", var_4);
    scripts\mp\spawnlogic::registerspawnset("_encstr_AD0C095DF195E8B6074A18", var_5);
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
  }
}

alwaysgamemodeclass() {
  return "_encstr_AAAC09D09972B9C83F2B7F";
}

getspawnpoint() {
  if(isPlayer(self) && self.gamemodefirstspawn) {
    self.gamemodefirstspawn = 0;
    self.pers["_encstr_959506B911C79707"] = "_encstr_AAAC09D09972B9C83F2B7F";
    self.pers["_encstr_92690A5B078ED325F539E25E"] = "_encstr_B40101";
    self.class = self.pers["_encstr_959506B911C79707"];
    self.lastclass = self.pers["_encstr_92690A5B078ED325F539E25E"];
    var_0 = "_encstr_9A8507BA4040188D08";

    if(self.infectedrejoined)
      var_0 = "_encstr_8E8405EA382B2A";

    scripts\mp\menus::addtoteam(var_0, 1);
    thread monitordisconnect();
  }

  if(level.ingraceperiod) {
    var_1 = scripts\mp\spawnlogic::getspawnpointarray("_encstr_A5090DB6C1F51D8CD6BE9B0E2CDDCD");
    var_2 = scripts\mp\spawnlogic::getspawnpoint_random(var_1);
  } else
    var_2 = scripts\mp\spawnlogic::getspawnpoint(self, self.pers["_encstr_8AEF05472BC2D6"], "_encstr_820E07FAE8780B3A4C", "_encstr_AD0C095DF195E8B6074A18");

  return var_2;
}

onspawnplayer() {
  self.teamchangedthisframe = undefined;
  self.infect_spawnpos = self.origin;
  self.infectedkillsthislife = 0;

  if(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_8E8405EA382B2A") {
    scripts\mp\battlechatter_mp::disablebattlechatter(self);

    if(istrue(level.unset_relic_laststandmelee))
      self.little_bird_mg_playerexitturret = 1;
  }

  updateteamscores();

  if(!level.infect_choosingfirstinfected) {
    level.infect_choosingfirstinfected = 1;
    level thread choosefirstinfected();
  }

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B") || level.infect_countdowninprogress)
    self.waitedtospawn = 0;

  if(self.infectedrejoined) {
    if(!level.infect_allowsuicide) {
      level notify("_encstr_8B45155ACDFC470E785F9B842780DEA79DF8031288CC33");
      level.infect_chosefirstinfected = 1;
      level.infect_allowsuicide = 1;

      foreach(var_1 in level.players) {
        if(isDefined(var_1.infect_isbeingchosen))
          var_1.infect_isbeingchosen = undefined;
      }
    }

    foreach(var_1 in level.players) {
      if(isDefined(var_1.isinitialinfected))
        var_1 thread setinitialtonormalinfected();
    }

    if(level.infect_teamscores["_encstr_8E8405EA382B2A"] == 1)
      self.isinitialinfected = 1;

    initsurvivaltime(1);
  }

  thread onspawnfinished();
  thread updatematchstatushintonspawn();
  level notify("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
}

spawnwithplayersecondary() {
  var_0 = self getweaponslistprimaries();
  var_1 = self getcurrentprimaryweapon();

  if(var_0.size > 1) {
    if(scripts\mp\utility\weapon::isknifeonly(var_1)) {
      foreach(var_3 in var_0) {
        if(var_3 != var_1)
          self setspawnweapon(var_3);
      }
    }
  }
}

setdefaultammoclip(var_0) {
  var_1 = 1;

  if(isDefined(self.isinitialinfected)) {
    if(scripts\mp\utility\game::isusingdefaultclass(var_0, 1))
      var_1 = 0;
  } else if(scripts\mp\utility\game::isusingdefaultclass(var_0, 0))
    var_1 = 0;

  return var_1;
}

onspawnfinished() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");

  if(istrue(self.waitedtospawn)) {
    self.waitedtospawn = 0;
    self._id_13968 = 1;
    wait 0.1;
    self suicide();
  }

  self.last_infected_class = self.infected_class;

  if(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_9A8507BA4040188D08") {
    if(level.enableping)
      scripts\mp\utility\perk::giveperk("_encstr_86370FAF8B1AFE183945EB42A1E2F02072");

    if(level.unset_relic_laststandmelee)
      thread searchfortarget();

    spawnwithplayersecondary();

    if(level.steam_damaged && !level.steam_damage_players && !isbot(self))
      thread _id_11F4B();
  } else if(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_8E8405EA382B2A") {
    if(istrue(level.setplayerselfrevivingextrainfo)) {
      self detachall();
      self setModel("_encstr_852012A26819A533589DD1FFAA6037EEBB70B92A");
      self setviewmodel("_encstr_A3E1112DAD69B08E079B4ED2623F4E383F078B");

      if(getdvarint("_encstr_836919D789622F03E8F492E72DB079F387400B467786900E479882", 1) == 1)
        thread _id_126FF();

      self playlocalsound("_encstr_A741177B4BBE79EA10D12E7368A13C5237E1679B1D50D3A9D8");
      self.unset_relic_steelballs = 1;
    }

    if(istrue(level.brking_initfeatures))
      self skydive_cutautodeployon();

    if(level.enableping)
      scripts\mp\utility\perk::giveperk("_encstr_86370FAF8B1AFE183945EB42A1E2F02072");

    var_0 = 1.05;

    if(!level.unset_relic_laststandmelee) {
      var_1 = int(floor(level.infect_teamscores["_encstr_8E8405EA382B2A"] / 3));
      var_1 = var_1 * 0.01;
      var_0 = max(1.0, var_0 - var_1);
    }

    self.overrideweaponspeed_speedscale = var_0;
    thread setinfectedmsg();

    if(level.infectedtactical == "_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A" && !istrue(self.isinitialinfected)) {
      if(level.givetkontispawn || !level.givetkontispawn && !self.ti_spawn)
        scripts\mp\equipment::giveequipment(level.infectedlethal, "_encstr_BA7F0830B3A7859B60B0");
      else
        scripts\mp\equipment::decrementequipmentammo(level.infectedlethal, 1);
    }

    if(level.infectedtactical != "_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A" || level.infectedtactical == "_encstr_8BBA05185F8B99")
      scripts\mp\equipment::giveequipment(level.infectedtactical, "_encstr_AC8F0AE74163F85AAA380AD8");
    else
      scripts\mp\utility\perk::giveperk("_encstr_84901C53E0AB86FF79793C3998A3A7CEE1B0DACAA86B3D5FD15E2451A8C8");
  }

  giveextrainfectedperks();

  if(istrue(self._id_11D9E)) {
    if(!level.unset_relic_laststandmelee || level.unset_relic_laststandmelee && level.mapname == "_encstr_93FB0A6B1C7D2CB92D5EB00D")
      self._id_11D9E = undefined;

    thread scripts\mp\supers::givesuperpoints(350, undefined, 1);
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {} else {
    var_2 = scripts\mp\utility\weapon::getweaponrootname(self.loadoutprimary);

    if(var_2 != "_encstr_87610AB4EE83FAD6374B3395") {
      var_3 = getcompleteweaponname("_encstr_AFBB115ADD1CD75BDCA5CC56DC1D2CC4D7DAC1");
      self giveweapon(var_3);
      self assignweaponmeleeslot(var_3);

      if(self.loadoutsecondary == "_encstr_87610AB4EE83FAD6374B3395") {
        scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe("_encstr_BED80D7C9C59D95BF870DBDFA9F018");
        self giveweapon("_encstr_BED80D7C9C59D95BF870DBDFA9F018");
      }
    }
  }

  self.faux_spawn_infected = undefined;

  if(istrue(self.updatearenaomnvardata)) {
    self.updatearenaomnvardata = undefined;
    thread scripts\cp_mp\parachute::stop_restock_recharge(1);
  }

  thread scripts\mp\supers::givesuperpoints(level.stealth_broken_music_index, undefined, 1);
  thread _id_14399();
}

_id_126FF() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_837F0D4838B8B25A757F6F0B4F2DD3");
  self setscriptablepartstate("_encstr_8B91089C354BCAC65D59", "_encstr_AAC10DB208B88E7FEDCF5B4AD87DB6");
  waitframe();

  if(getdvarint("_encstr_AF541AE7636201C63B19AAD2D3B789C87DE8378D070D509B8FF121DA", 1))
    self setscriptablepartstate("_encstr_BACB074025B01AAA28", "_encstr_B66E08EDDCEBD8BDED0E");
  else
    self setscriptablepartstate("_encstr_BACB074025B01AAA28", "_encstr_AB0703DBB9");
}

_id_14399() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 0.2;

  if(istrue(level.setplayerselfrevivingextrainfo) && self.team == "_encstr_8E8405EA382B2A")
    self _meth_87AA("_encstr_BACB074025B01AAA28");
  else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "_encstr_B82907C2887BC62B39")
    self _meth_87AA("_encstr_B82907C2887BC62B39");
  else
    self _meth_87AA("_encstr_B40101");
}

searchfortarget() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  thread scripts\mp\supers::givesuperpoints(200, undefined, 1);
}

managefists(var_0, var_1) {
  if(var_0 != "_encstr_A7ED0AD79F73990E28334B92" || var_1 != "_encstr_A7ED0AD79F73990E28334B92") {
    if(var_0 == "_encstr_8BBA05185F8B99" && var_1 == "_encstr_8BBA05185F8B99") {
      return;
    }
    scripts\cp_mp\utility\inventory_utility::takeweaponwhensafe("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    return;
  }
}

giveextrainfectedperks() {
  if(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_9A8507BA4040188D08")
    var_0 = ["_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7"];
  else if(istrue(self.isinitialinfected))
    var_0 = ["_encstr_86C61787A9F5722930B83378F670671A5C2B1B0F51A61A16C0", "_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27", "_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959", "_encstr_A1C919E233105BA29FF1F3FFAF36AB9C8079DBEEC988F54BE787CF", "_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F"];
  else
    var_0 = ["_encstr_86C61787A9F5722930B83378F670671A5C2B1B0F51A61A16C0", "_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27", "_encstr_8F6D15E6C1CA1BD22CB1D1E57DCCC2368D1985B616D959"];

  foreach(var_2 in var_0)
  scripts\mp\utility\perk::giveperk(var_2);
}

setinfectedmodels() {}

setinfectedmsg() {
  if(isDefined(self.isinitialinfected)) {
    if(!isDefined(self.showninfected) || !self.showninfected) {
      thread scripts\mp\rank::scoreeventpopup("_encstr_B8800FE82C03422C40426B8EA5492B52B2");
      self.showninfected = 1;
    }
  } else if(isDefined(self.changingtoregularinfected)) {
    self.changingtoregularinfected = undefined;

    if(isDefined(self.changingtoregularinfectedbykill)) {
      self.changingtoregularinfectedbykill = undefined;
      thread scripts\mp\utility\points::giveunifiedpoints("_encstr_B8800FE82C03422C40426B8EA5492B52B2");
    }
  } else if(!isDefined(self.showninfected) || !self.showninfected) {
    thread scripts\mp\rank::scoreeventpopup("_encstr_AF9C0D1770344F423D6AF5472BB05F");
    self.showninfected = 1;
  }
}

choosefirstinfected() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8B45155ACDFC470E785F9B842780DEA79DF8031288CC33");
  level endon("_encstr_B2270A3E87C886F7C8C1923A");
  level.infect_allowsuicide = 0;
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  level.infect_countdowninprogress = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", "_encstr_AF9F1213733217935F9A704D09805B2954675455");
  var_0 = 15;

  while(var_0 > 0 && !level.gameended) {
    foreach(var_2 in level.players)
    var_2 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", var_0);

    var_0--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  }

  setomnvar("_encstr_B27014DBA879ED6A4DB7CB1FBF75524A88F613A7E278", "_encstr_84C0125139B36BF2595A283FF65BC7EB916642CD");

  foreach(var_2 in level.players)
  var_2 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", 0);

  level.infect_countdowninprogress = 0;
  var_6 = [];

  foreach(var_8 in level.players) {
    if(scripts\mp\utility\game::matchmakinggame() && level.players.size > 1 && var_8 ishost()) {
      continue;
    }
    if(var_8.team == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      continue;
    }
    if(!var_8.hasspawned) {
      continue;
    }
    var_6[var_6.size] = var_8;
  }

  level.player_damage_blood = 0;

  if(var_6.size <= level.numinitialinfected && var_6.size > 1)
    level.numinitialinfected = var_6.size - 1;

  var_10 = [];

  for(var_11 = 0; var_11 < level.numinitialinfected; var_11++) {
    var_12 = var_6[randomint(var_6.size)];
    var_10[var_10.size] = var_12;
    var_6 = scripts\engine\utility::array_remove(var_6, var_12);
  }

  foreach(var_12 in var_10)
  var_12 setfirstinfected(1);

  level.infect_allowsuicide = 1;

  foreach(var_8 in level.players) {
    if(istrue(var_8.isinitialinfected)) {
      var_8 thread scripts\mp\hud_message::showsplash("_encstr_B8800FE82C03422C40426B8EA5492B52B2");
      var_8 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_9BBA0F01B55837FF4DD1C279592B636A60");
      continue;
    }

    var_8 thread scripts\mp\hud_message::showsplash("_encstr_95A60F3BE8EBDBEB0F0EE35AF40B839FB3");
    var_8.survivalstarttime = gettime();
  }
}

setfirstinfected(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(var_0)
    self.infect_isbeingchosen = 1;

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::isusingremote() || isDefined(self._id_1425D))
    waitframe();

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");
    waitframe();
  }

  var_1 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2.allowairexit = 1;
    var_2.onprematchfadedone2 = "_encstr_B6690C29C959A78955E4A21449B2";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var_1, undefined, self, var_2, 1);

    while(scripts\cp_mp\utility\player_utility::isinvehicle())
      waitframe();
  }

  while(self ismantling())
    waitframe();

  while(!isalive(self))
    waitframe();

  while(istrue(self.usingascender))
    waitframe();

  if(var_0) {
    scripts\mp\menus::addtoteam("_encstr_8E8405EA382B2A", undefined, 1);
    thread monitordisconnect();
    level.infect_chosefirstinfected = 1;
    self.infect_isbeingchosen = undefined;
    updateteamscores();

    if(scripts\mp\utility\player::isfemale())
      self playlocalsound("_encstr_9A181532ACB6D7C427B2583AD0A59B3BFAC4AC3AE8AC4E");
    else
      self playlocalsound("_encstr_8B2011A1E2E211DBF8B88D4071489B2C9B5F38");

    thread scripts\mp\music_and_dialog::stealthtimeelapsed();
  }

  self.isinitialinfected = 1;
  scripts\mp\utility\stats::incpersstat("_encstr_9A8F0E99A5E4371DA4CD992BB1E8B219", 1);
  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"];
  scripts\mp\equipment\tac_insert::_id_13684(self.origin, self.angles);
  self notify("_encstr_91D70BC8AF032B0F1B734F731A");
  self.faux_spawn_stance = self getstance();
  self.faux_spawn_infected = 1;
  self.operatorcustomization = undefined;
  waittillframeend;
  thread scripts\mp\playerlogic::spawnplayer(1);

  if(isDefined(scripts\mp\supers::getcurrentsuper()) && scripts\mp\supers::getcurrentsuperref() == "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D")
    thread _id_1383E();
  else if(level.unset_relic_laststandmelee)
    thread scripts\mp\supers::givesuperpoints(350, undefined, 1);

  if(var_0)
    level.infect_players[self.name] = 1;

  level.player_damage_blood = 1;

  if(!level.player_damage_blood)
    level thread scripts\mp\hud_util::teamplayercardsplash("_encstr_A353179E76EAF1C855CBE938A78A8309219C8094CFB299F12C", self);

  if(!level.infect_skipsounds) {
    scripts\mp\utility\sound::playsoundonplayers("_encstr_8B78160973D7050D4BE7D98E187AFB3E038387CBA8EDAF39");
    level.infect_skipsounds = 1;
  }

  thread _id_1439E();
  initsurvivaltime(1);
}

_id_1439E() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  wait 4;
  self iprintlnbold(&"_encstr_96161489B799C712895B8BCF7B816F1FB6AFC150DC41");
}

_id_1383E() {
  thread scripts\mp\supers::givesuperpoints(4000, undefined, 1);
  thread scripts\mp\perks\perkpackage::perkpackage_forceusesuper();
}

setinitialtonormalinfected(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.isinitialinfected = undefined;
  self.changingtoregularinfected = 1;

  if(isDefined(var_0))
    self.changingtoregularinfectedbykill = 1;

  while(!scripts\mp\utility\player::isreallyalive(self))
    waitframe();

  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("_encstr_A17817D81A7237598763B7387BB7A0875A926868D2CD637003");
    waitframe();
  }

  while(self ismantling())
    waitframe();

  while(self ismeleeing())
    waitframe();

  while(!scripts\mp\utility\player::isreallyalive(self))
    waitframe();

  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.infect_loadouts["_encstr_8E8405EA382B2A"];
  scripts\mp\equipment\tac_insert::_id_13684(self.origin, self.angles);
  self notify("_encstr_91D70BC8AF032B0F1B734F731A");
  self.faux_spawn_stance = self getstance();
  self.faux_spawn_infected = 1;

  if(isDefined(scripts\mp\supers::getcurrentsuper()) && scripts\mp\supers::getcurrentsuper().isinuse)
    thread scripts\mp\supers::superusefinished(0);

  waitframe();
  thread scripts\mp\playerlogic::spawnplayer(1);

  if(isDefined(scripts\mp\supers::getcurrentsuper()) && scripts\mp\supers::getcurrentsuperref() == "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D")
    thread _id_1383E();
}

onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(level.gameended) {
    return;
  }
  var_10 = 0;
  var_11 = 0;
  level thread shouldplayhalfwayvo();

  if(self.team == "_encstr_8E8405EA382B2A") {}

  if(self.team == "_encstr_9A8507BA4040188D08" && isDefined(var_1)) {
    self.operatorcustomization = undefined;

    if(isPlayer(var_1) && var_1 != self)
      var_10 = 1;
    else if(level.infect_allowsuicide && (var_1 == self || !isPlayer(var_1))) {
      var_10 = 1;
      var_11 = 1;
    }
  }

  if(self.team == "_encstr_9A8507BA4040188D08" && istrue(level.nukeincoming)) {
    if(isDefined(level._id_11F14) && self == level._id_11F14) {
      var_10 = 0;
      var_11 = 0;
    }
  }

  if(isPlayer(var_1) && var_1.team == "_encstr_9A8507BA4040188D08" && var_1 != self) {
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_ABEC10F2089925F71D967B552EC3A76B3748", 1);
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_ABEC10F2089925F71D967B552EC3A76B3748", var_1.pers["_encstr_ABEC10F2089925F71D967B552EC3A76B3748"]);
  } else if(isPlayer(var_1) && var_1.team == "_encstr_8E8405EA382B2A" && var_1 != self) {
    var_1 scripts\mp\utility\stats::incpersstat("_encstr_B270105CA8E0EC4BD7974FDB95FD724C2B91", 1);
    var_1 scripts\mp\persistence::statsetchild("_encstr_8C4606C9DBD5CD46", "_encstr_B270105CA8E0EC4BD7974FDB95FD724C2B91", var_1.pers["_encstr_B270105CA8E0EC4BD7974FDB95FD724C2B91"]);

    if(isPlayer(var_1))
      var_1 scripts\mp\utility\stats::setextrascore1(var_1.pers["_encstr_B270105CA8E0EC4BD7974FDB95FD724C2B91"]);
  }

  if(var_10) {
    thread delayedprocesskill(var_1, var_11);

    if(var_11) {
      foreach(var_13 in level.players) {
        if(isDefined(var_13.isinitialinfected))
          var_13 thread setinitialtonormalinfected();
      }
    } else if(isDefined(var_1.isinitialinfected)) {
      foreach(var_13 in level.players) {
        if(isDefined(var_13.isinitialinfected))
          var_13 thread setinitialtonormalinfected(1);
      }
    } else if(level.infectstreakbonus > 0) {
      if(!isDefined(var_1.infectedkillsthislife))
        var_1.infectedkillsthislife = 1;
      else
        var_1.infectedkillsthislife++;

      var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8B6512A5E6332BC6E85991AF37EAC93B96CEDBC9", undefined, level.infectstreakbonus * var_1.infectedkillsthislife);
    } else
      var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8B6512A5E6332BC6E85991AF37EAC93B96CEDBC9");

    if(scripts\mp\utility\dvars::getwatcheddvar("_encstr_8B250A53848DC8D17A472BE9") != 0) {
      var_17 = 1;

      if(scripts\mp\utility\game::matchmakinggame()) {
        level.packclientmatchdata++;
        var_17 = level.packclientmatchdata <= level.packedbits;
      }

      if(var_17) {
        if(!isDefined(level.extratime))
          level.extratime = level.infectextratimeperkill;
        else
          level.extratime = level.extratime + level.infectextratimeperkill;
      }
    }

    setsurvivaltime(1);
  } else {
    if(isbot(self))
      self.classcallback = "_encstr_AAAC09D09972B9C83F2B7F";

    if(isDefined(self.isinitialinfected)) {
      self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"];
      self.infected_class = "_encstr_856A0DCA180B0AAFE0F0A9CC1B892B";
    } else {
      self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.infect_loadouts[self.pers["_encstr_8AEF05472BC2D6"]];
      self.infected_class = self.pers["_encstr_8AEF05472BC2D6"];
    }
  }
}

delayedprocesskill(var_0, var_1) {
  self._id_11D9E = 1;

  if(level.unset_relic_laststandmelee && level.mapname != "_encstr_93FB0A6B1C7D2CB92D5EB00D")
    _id_1314D();

  wait 0.15;
  self.teamchangedthisframe = 1;
  scripts\mp\menus::addtoteam("_encstr_8E8405EA382B2A");

  if(!istrue(self._id_13968)) {
    var_2 = scripts\mp\persistence::statgetchildbuffered("_encstr_8C4606C9DBD5CD46", "_encstr_881A0B47B4B6B2286316E59532", 0);
    var_2 = var_2 - 240;
    self.pers["_encstr_A7350D98707F9B79A37F4B04F34D27"] = var_2;
  } else
    self._id_13968 = 0;

  updateteamscores();
  level.infect_players[self.name] = 1;
  thread monitordisconnect();

  if(level.infect_teamscores["_encstr_9A8507BA4040188D08"] > 1) {
    if(level.unset_relic_laststandmelee) {
      level._id_12738++;

      if(level._id_12738 > 3)
        level._id_12738 = 1;

      if(level.infect_teamscores["_encstr_9A8507BA4040188D08"] == level.steam_point_think)
        level thread _id_13861();
    }

    if(level._id_12738 == 1) {
      scripts\mp\utility\sound::playsoundonplayers("_encstr_8B78160973D7050D4BE7D98E187AFB3E038387CBA8EDAF39", "_encstr_9A8507BA4040188D08");
      scripts\mp\utility\sound::playsoundonplayers("_encstr_87ED1717204EDFBA5518655EFA13D284D0B88F5798610B2255", "_encstr_8E8405EA382B2A");
      thread scripts\mp\hud_util::teamplayercardsplash("_encstr_B438151BC2368DDBD5D1FAECDBE87D5A9B33561B3A2B46", self, "_encstr_9A8507BA4040188D08");
    }

    if(!var_1) {
      thread scripts\mp\hud_util::teamplayercardsplash("_encstr_A9BA11322931BBD5B8F17F41ED081FDF65C13A", var_0, "_encstr_8E8405EA382B2A");

      if(!isDefined(level.survivorscoreevent)) {
        var_3 = getdvarint("_encstr_A97F2050C790BF5B12D4273FDC391B8F3A84A493CDCD4286289D4052CBB37608EE57", 50);

        if(var_3 > 0)
          level.survivorscoreevent = var_3;
        else
          level.survivorscoreevent = scripts\mp\rank::getscoreinfovalue("_encstr_A52C093330A23B194C60BB");
      } else
        level.survivorscoreevent = level.survivorscoreevent + level.survivoralivescore;

      foreach(var_5 in level.players) {
        if(!scripts\mp\utility\player::isreallyalive(var_5) || self.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
          continue;
        }
        if(var_5.team == "_encstr_9A8507BA4040188D08" && var_5 != self && distance(var_5.infect_spawnpos, var_5.origin) > 32)
          var_5 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A52C093330A23B194C60BB", undefined, level.survivorscoreevent);

        if(var_5.team == "_encstr_8E8405EA382B2A" && var_5 != var_0 && var_5 != self)
          var_5 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_A1BD075837DCD29B47", undefined, level.stealth_broken_music);
      }
    }
  } else if(level.infect_teamscores["_encstr_9A8507BA4040188D08"] == level.play_player_approach)
    onfinalsurvivor();
  else if(level.infect_teamscores["_encstr_9A8507BA4040188D08"] == 0)
    onsurvivorseliminated();

  if(isbot(self))
    self.classcallback = "_encstr_AAAC09D09972B9C83F2B7F";

  if(isDefined(self.isinitialinfected)) {
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"];
    self.infected_class = "_encstr_856A0DCA180B0AAFE0F0A9CC1B892B";
  } else {
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.infect_loadouts[self.pers["_encstr_8AEF05472BC2D6"]];
    self.infected_class = self.pers["_encstr_8AEF05472BC2D6"];
  }
}

onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(level.matchmakingmatch) && isDefined(var_1) && isDefined(var_0)) {
    var_6 = var_1 getfireteammembers();

    if(isDefined(var_6) && var_6.size > 0) {
      foreach(var_8 in var_6) {
        if(isDefined(var_8) && var_0 == var_8) {
          var_1 scripts\mp\killstreaks\killstreaks::givestreakpoints("_encstr_ABD70578F3D02C", -1, 0);
          var_1.nukepoints = scripts\engine\utility::ter_op(var_1.nukepoints > 0, var_1.nukepoints - 1, 0);
          break;
        }
      }
    }
  }
}

onfinalsurvivor() {
  scripts\mp\utility\sound::playsoundonplayers("_encstr_82C6102771207AEAD096AE366BF8256385E1");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1.team == "_encstr_9A8507BA4040188D08") {
      var_1 scripts\mp\utility\dialog::leaderdialogonplayer("_encstr_A26D131C58EC01503BE17BAF4C338B132A11DA66F8");
      var_1 thread scripts\mp\rank::scoreeventpopup("_encstr_81830F5A70E56E83C69E556A3428233505");
      var_1 scripts\mp\utility\stats::incpersstat("_encstr_99730D58B61F9B177392500763C0EA", 1);

      if(scripts\mp\utility\game::matchmakinggame()) {
        if(!var_1 scripts\mp\utility\killstreak::isjuggernaut()) {
          var_1.maxhealth = 200;
          var_1 notify("_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5");
        }
      }

      if(!level.infect_awardedfinalsurvivor) {
        if(var_1.gamemodejoinedatstart && isDefined(var_1.infect_spawnpos) && distance(var_1.infect_spawnpos, var_1.origin) > 32)
          var_1 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_81830F5A70E56E83C69E556A3428233505");

        level.infect_awardedfinalsurvivor = 1;
      }

      thread scripts\mp\hud_util::teamplayercardsplash("_encstr_8DA0178D58C6B1BDEA3AF5CCA5CD0BB1FAE6BA4EECD2ECB79C", var_1);

      if(level.steam_damaged) {} else
        level thread finalsurvivoruav(var_1);

      break;
    }
  }
}

finalsurvivoruav(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_A6EB0BEB4C4470A3AB1A8B51B2");
  level endon("_encstr_868712A57399B21B8E7D8D0B3A5925F64B9B59E4");
  level thread enduavonlatejoiner(var_0);
  var_1 = getuavstrengthlevelneutral();

  if(level.unset_relic_laststandmelee && level.mapname != "_encstr_93FB0A6B1C7D2CB92D5EB00D")
    var_1 = 5;

  var_2 = 1;
  var_3 = 0;
  level.radarmode["_encstr_8E8405EA382B2A"] = "_encstr_A7C90DB83D45714FA1E16D79C58F12";

  foreach(var_5 in level.players) {
    if(var_5.team == "_encstr_8E8405EA382B2A")
      var_5.radarmode = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
  }

  scripts\cp_mp\killstreaks\uav::_setteamradarstrength("_encstr_8E8405EA382B2A", var_1 + 1);

  for(;;) {
    var_7 = var_0.origin;
    wait 4;

    if(var_3) {
      setteamradar("_encstr_8E8405EA382B2A", 0);
      var_3 = 0;
    }

    wait 6;

    if(distance(var_7, var_0.origin) < 200) {
      setteamradar("_encstr_8E8405EA382B2A", 1);
      var_3 = 1;

      foreach(var_5 in level.players)
      var_5 playlocalsound("_encstr_8ABE0FFBA9A75F40E0A8C0AECDB9A3C78F");
    }

    if(var_2) {
      var_2 = 0;
      var_1 = getuavstrengthlevelneutral();
      scripts\cp_mp\killstreaks\uav::_setteamradarstrength("_encstr_8E8405EA382B2A", var_1 + 1);
    }
  }
}

_id_119D8() {
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");

  while(level.infect_teamscores["_encstr_9A8507BA4040188D08"] > level.steam_point_think) {
    foreach(var_1 in level.players) {
      if(var_1.team == "_encstr_8E8405EA382B2A")
        triggeroneoffradarsweep(var_1);
    }

    wait(getdvarint("_encstr_81691783DA2348A845BE1B0FB461C8282BF29F49C293851193", 60));
  }
}

enduavonlatejoiner(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_A6EB0BEB4C4470A3AB1A8B51B2");

  for(;;) {
    if(level.infect_teamscores["_encstr_9A8507BA4040188D08"] > level.play_player_approach) {
      level notify("_encstr_868712A57399B21B8E7D8D0B3A5925F64B9B59E4");
      waitframe();
      setteamradar("_encstr_8E8405EA382B2A", 0);
      break;
    }

    waitframe();
  }
}

_id_13861() {
  level.radarmode["_encstr_8E8405EA382B2A"] = "_encstr_A7C90DB83D45714FA1E16D79C58F12";

  foreach(var_1 in level.players) {
    if(var_1.team == "_encstr_8E8405EA382B2A")
      var_1.radarmode = "_encstr_A7C90DB83D45714FA1E16D79C58F12";
  }

  var_3 = getuavstrengthlevelneutral();
  scripts\cp_mp\killstreaks\uav::_setteamradarstrength("_encstr_8E8405EA382B2A", var_3 + 1);
  setteamradar("_encstr_8E8405EA382B2A", 1);
}

monitordisconnect() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A6EB0BEB4C4470A3AB1A8B51B2");
  self notify("_encstr_96CB1AA7C53C3DD773A9FD4A955C9B4AED19D4D0137317BA35AB9353");
  self endon("_encstr_96CB1AA7C53C3DD773A9FD4A955C9B4AED19D4D0137317BA35AB9353");
  var_0 = self.team;

  if(!isDefined(var_0) && isDefined(self.bot_team))
    var_0 = self.bot_team;

  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  updateteamscores();

  if(isDefined(self.infect_isbeingchosen) || level.infect_chosefirstinfected) {
    if(level.infect_teamscores["_encstr_8E8405EA382B2A"] && level.infect_teamscores["_encstr_9A8507BA4040188D08"]) {
      if(level.unset_relic_laststandmelee) {
        if(var_0 == "_encstr_9A8507BA4040188D08" && level.infect_teamscores["_encstr_9A8507BA4040188D08"] == level.steam_point_think)
          level thread _id_13861();
      }

      if(var_0 == "_encstr_9A8507BA4040188D08" && level.infect_teamscores["_encstr_9A8507BA4040188D08"] == level.play_player_approach)
        onfinalsurvivor();
      else if(var_0 == "_encstr_8E8405EA382B2A" && level.infect_teamscores["_encstr_8E8405EA382B2A"] == 1) {
        foreach(var_2 in level.players) {
          if(var_2 != self && var_2.team == "_encstr_8E8405EA382B2A")
            var_2 setfirstinfected(0);
        }
      }
    } else if(level.infect_teamscores["_encstr_9A8507BA4040188D08"] == 0) {
      if(istrue(level.hostmigration))
        scripts\mp\hostmigration::waittillhostmigrationdone();

      onsurvivorseliminated();
    } else if(level.infect_teamscores["_encstr_8E8405EA382B2A"] == 0) {
      if(level.infect_teamscores["_encstr_9A8507BA4040188D08"] == 1)
        level thread scripts\mp\gamelogic::endgame("_encstr_9A8507BA4040188D08", game["_encstr_99EA0B72AB022F6ED1CF9FC248"][tolower(game["_encstr_8E8405EA382B2A"]) + "_encstr_86E60CDF8828C17A6380E6DB7D11"]);
      else if(level.infect_teamscores["_encstr_9A8507BA4040188D08"] > 1) {
        level.infect_chosefirstinfected = 0;
        level thread choosefirstinfected();
      }
    }
  } else if(level.infect_countdowninprogress && level.infect_teamscores["_encstr_9A8507BA4040188D08"] == 0 && level.infect_teamscores["_encstr_8E8405EA382B2A"] == 0) {
    level notify("_encstr_8B45155ACDFC470E785F9B842780DEA79DF8031288CC33");
    level.infect_choosingfirstinfected = 0;

    foreach(var_5 in level.players)
    var_5 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", 0);
  }

  self.isinitialinfected = undefined;
}

ondeadevent(var_0) {
  return;
}

ontimelimit() {
  level thread scripts\mp\gamelogic::endgame("_encstr_9A8507BA4040188D08", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_B40B13237BEFC5278BC385D3C98FEA8518524C203D"]);
}

onsurvivorseliminated() {
  level thread scripts\mp\gamelogic::endgame("_encstr_8E8405EA382B2A", game["_encstr_99EA0B72AB022F6ED1CF9FC248"]["_encstr_8CEE153FAD4A607B1332F3DB5937A1C02519BD93347738"]);
}

getteamsize(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "_encstr_AF8C0A1B6A1D6045925B4F7D" && !var_3.spectatekillcam && !istrue(var_3.inspawncamera)) {
      continue;
    }
    if(var_3.team == var_0)
      var_1++;
  }

  return var_1;
}

updateteamscores() {
  level.infect_teamscores["_encstr_9A8507BA4040188D08"] = getteamsize("_encstr_9A8507BA4040188D08");
  game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_9A8507BA4040188D08"] = level.infect_teamscores["_encstr_9A8507BA4040188D08"];
  setteamscore("_encstr_9A8507BA4040188D08", level.infect_teamscores["_encstr_9A8507BA4040188D08"]);
  level.infect_teamscores["_encstr_8E8405EA382B2A"] = getteamsize("_encstr_8E8405EA382B2A");
  game["_encstr_96040B1D59B0AD35B1F64E599B"]["_encstr_8E8405EA382B2A"] = level.infect_teamscores["_encstr_8E8405EA382B2A"];
  setteamscore("_encstr_8E8405EA382B2A", level.infect_teamscores["_encstr_8E8405EA382B2A"]);
}

setspecialloadouts() {
  waitframe();

  if(!isDefined(level.survivorprimaryweapon) || level.survivorprimaryweapon == "_encstr_B40101")
    level.survivorprimaryweapon = "_encstr_925D13A28841F9E728B06A7FB1514FE8B74A497A18";

  if(!isDefined(level.survivorsecondaryweapon) || level.survivorsecondaryweapon == "_encstr_B40101")
    level.survivorsecondaryweapon = "_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B";

  if(!isDefined(level.infectedprimaryweapon) || level.infectedprimaryweapon == "_encstr_B40101")
    level.infectedprimaryweapon = "_encstr_BED80D7C9C59D95BF870DBDFA9F018";

  if(!isDefined(level.infectedsecondaryweapon) || level.infectedsecondaryweapon == "_encstr_B40101")
    level.infectedsecondaryweapon = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";

  if(!isDefined(level.initialprimaryweapon) || level.initialprimaryweapon == "_encstr_B40101")
    level.initialprimaryweapon = "_encstr_925D13A28841F9E728B06A7FB1514FE8B74A497A18";

  if(isDefined(level.infectedprimaryweapon) && level.infectedprimaryweapon == "_encstr_BED80D7C9C59D95BF870DBDFA9F018") {
    level.infectedprimaryweapon = "_encstr_BED80D7C9C59D95BF870DBDFA9F018";

    if(isDefined(level.infectedsecondaryweapon) && level.infectedsecondaryweapon == "_encstr_BED80D7C9C59D95BF870DBDFA9F018")
      level.infectedsecondaryweapon = "_encstr_8BBA05185F8B99";
  }

  if(istrue(level.setplayerselfrevivingextrainfo)) {
    level.infectedprimaryweapon = "_encstr_A9FA118BE3BF87F959E780806F65F34F438DF6";
    level.infectedsecondaryweapon = "_encstr_A9FA118BE3BF87F959E780806F65F34F438DF6";
  }

  if(!isDefined(level.initialsecondaryweapon) || level.initialsecondaryweapon == "_encstr_B40101")
    level.initialsecondaryweapon = "_encstr_B8B311C42CC8F74278DFF7F29998FA43110A4B";

  if(!isDefined(level.survivorlethal) || level.survivorlethal == "_encstr_B40101")
    level.survivorlethal = "_encstr_82A70F2B3B73E33B472371FF21D7809DDF";

  if(!isDefined(level.survivortactical) || level.survivortactical == "_encstr_B40101")
    level.survivortactical = "_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E";

  if(!isDefined(level.infectedlethal) || level.infectedlethal == "_encstr_B40101")
    level.infectedlethal = "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381";

  if(!isDefined(level.infectedtactical) || level.infectedtactical == "_encstr_B40101")
    level.infectedtactical = "_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A";

  level.infect_allyrigs = [];
  level.infect_allyrigs[level.infect_allyrigs.size] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_0 = 0;
  var_1 = _encstr_BA5F1D37C693D2C13A9BBC6B1C979D58AD563A5E832BCD79B3BA3717766E1B::remappedhpzoneorder(level.survivorprimaryweapon);
  var_0 = scripts\mp\class::_id_139E7(level.survivorprimaryweapon, var_1);
  var_2 = 0;
  var_3 = _encstr_BA5F1D37C693D2C13A9BBC6B1C979D58AD563A5E832BCD79B3BA3717766E1B::remappedhpzoneorder(level.survivorsecondaryweapon);
  var_2 = scripts\mp\class::_id_139E7(level.survivorsecondaryweapon, var_3);

  if(scripts\mp\utility\game::isusingdefaultclass("_encstr_9A8507BA4040188D08", 0))
    level.infect_loadouts["_encstr_9A8507BA4040188D08"] = scripts\mp\utility\game::getmatchrulesspecialclass("_encstr_9A8507BA4040188D08", 0);
  else if(level._id_12052) {
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = level.survivorprimaryweapon;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"];
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"];
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"];
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"];
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"];
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = var_0;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = level.survivorsecondaryweapon;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = level.attachmentsurvivorsecondary;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = level.attachmentsurvivorsecondarytwo;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = var_2;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = level.survivorlethal;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = level.survivortactical;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";

    if(level._id_139BC.size > 0) {
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = level._id_139BC[0];
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = level._id_139BC[1];
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = level._id_139BC[2];
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC", "_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6", "_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F"];
    } else {
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_BD7517A417C0D76F6D53B1DBD8C897C2A0FB2339A310DC5795"] = 1;
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F"];
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_97EA12B1B7C223DBBA3A8AE1A327582859C95BE6"] = ["_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6", "_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC", "_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F"];
    }

    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"] = level.survivorsuper;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"] = level._id_139BD;
  } else {
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = level.survivorprimaryweapon;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = level.attachmentsurvivorprimary;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = var_0;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = level.survivorsecondaryweapon;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = level.attachmentsurvivorsecondary;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = level.attachmentsurvivorsecondarytwo;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = var_2;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = level.survivorlethal;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = level.survivortactical;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";

    if(level._id_139BC.size > 0) {
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = level._id_139BC[0];
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = level._id_139BC[1];
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = level._id_139BC[2];
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC", "_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6", "_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F"];
    } else {
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_BD7517A417C0D76F6D53B1DBD8C897C2A0FB2339A310DC5795"] = 1;
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F"];
      level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_97EA12B1B7C223DBBA3A8AE1A327582859C95BE6"] = ["_encstr_8882193783958D5A0BC64797D7CD362C6795379D56C9BEC1B1BAE6", "_encstr_9B4F1243D118EE9F8FC80BC3B6DCF7E2C853C9DC", "_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F"];
    }

    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"] = level.survivorsuper;
    level.infect_loadouts["_encstr_9A8507BA4040188D08"]["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"] = level._id_139BD;

    if(level.enableping) {}
  }

  var_4 = 0;
  var_5 = 0;

  if(level.survivorprimaryweapon == level.initialprimaryweapon)
    var_4 = var_0;
  else {
    var_6 = _encstr_BA5F1D37C693D2C13A9BBC6B1C979D58AD563A5E832BCD79B3BA3717766E1B::remappedhpzoneorder(level.initialprimaryweapon);
    var_4 = scripts\mp\class::_id_139E7(level.initialprimaryweapon, var_6);
  }

  if(level.survivorsecondaryweapon == level.initialsecondaryweapon)
    var_5 = var_2;
  else {
    var_7 = _encstr_BA5F1D37C693D2C13A9BBC6B1C979D58AD563A5E832BCD79B3BA3717766E1B::remappedhpzoneorder(level.initialsecondaryweapon);
    var_5 = scripts\mp\class::_id_139E7(level.initialsecondaryweapon, var_7);
  }

  var_8 = [];

  if(level.unset_relic_laststandmelee)
    var_8[var_8.size] = "_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F";

  if(scripts\mp\utility\game::isusingdefaultclass("_encstr_8E8405EA382B2A", 1)) {
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"] = scripts\mp\utility\game::getmatchrulesspecialclass("_encstr_8E8405EA382B2A", 1);
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  } else if(level._id_12052) {
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = level.initialprimaryweapon;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"];
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"];
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"];
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"];
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = game["_encstr_82FF13025BA5A346B1EB5E5C9F2045DFDFF17ACB23"][0]["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"];
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = var_4;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = level.initialsecondaryweapon;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = level.attachmentinitialsecondary;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = level.attachmentinitialsecondarytwo;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = var_5;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = level.infectedlethal;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = level.infectedtactical;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = var_8;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"] = level.infectedsuper;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"] = level.steam_dmg_trigger_think;
  } else {
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = level.initialprimaryweapon;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = level.attachmentinitialprimary;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = var_4;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = level.initialsecondaryweapon;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = level.attachmentinitialsecondary;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = level.attachmentinitialsecondarytwo;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = var_5;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = level.infectedlethal;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = level.infectedtactical;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = var_8;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"] = level.infectedsuper;
    level.infect_loadouts["_encstr_856A0DCA180B0AAFE0F0A9CC1B892B"]["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"] = level.steam_dmg_trigger_think;

    if(level.enableinfectedtracker) {}

    if(level.enableping) {}
  }

  if(istrue(level.setplayerselfrevivingextrainfo))
    var_9 = 0;
  else {
    var_9 = 0;
    var_10 = _encstr_BA5F1D37C693D2C13A9BBC6B1C979D58AD563A5E832BCD79B3BA3717766E1B::remappedhpzoneorder(level.infectedprimaryweapon);
    var_9 = scripts\mp\class::_id_139E7(level.infectedprimaryweapon, var_10);
  }

  var_11 = [];

  if(level.unset_relic_laststandmelee)
    var_11[var_11.size] = "_encstr_93EC12672801D3227B89DB907805BA8B8B68AF9F";

  if(scripts\mp\utility\game::isusingdefaultclass("_encstr_8E8405EA382B2A", 0)) {
    level.infect_loadouts["_encstr_8E8405EA382B2A"] = scripts\mp\utility\game::getmatchrulesspecialclass("_encstr_8E8405EA382B2A", 0);
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  } else {
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = level.infectedprimaryweapon;
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_935A1863DB1619ED5DA3284E2D5B85E4E52BB0935A5873E89222"] = var_9;
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = level.infectedsecondaryweapon;
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_88531A48DA76F9D8EF34EEFD3BDFA0B1DEB36801D24A3BD1AB5C9B75"] = -1;
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = level.infectedlethal;
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = level.infectedtactical;
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = level.infectedsuper;
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = var_11;
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_91C8151BEDB08C7BAEE891B4B28D91550E9DC9588CAC62"] = level.infectedsuper;
    level.infect_loadouts["_encstr_8E8405EA382B2A"]["_encstr_ACC815D8F62C23F6BAD19196598DC8AA387693C2C8598C"] = level.steam_dmg_trigger_think;

    if(level.enableinfectedtracker) {}

    if(level.enableping)
      return;
  }
}

addsurvivorattachmentsprimary(var_0) {
  level.attachmentsurvivorprimary = "_encstr_8BBA05185F8B99";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9")
    level.attachmentsurvivorprimary = "_encstr_8BC10C02A3F0FAFF593B6A626125";
  else if(var_1 == "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D" || var_1 == "_encstr_9B65109F23E0F24FC016431A79258FEE4889" || var_1 == "_encstr_AF710BF4355A9195B0FF0AEAD0" || var_1 == "_encstr_A3710BEEACC2E0B737EB36B676" || var_1 == "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36" || var_0 == "_encstr_8186089F5F73B918AE52")
    level.attachmentsurvivorprimary = "_encstr_82360811A967F806376A";
}

addinitialattachmentsprimary(var_0) {
  level.attachmentinitialprimary = "_encstr_8BBA05185F8B99";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9")
    level.attachmentinitialprimary = "_encstr_8BC10C02A3F0FAFF593B6A626125";
  else if(var_1 == "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D" || var_1 == "_encstr_9B65109F23E0F24FC016431A79258FEE4889" || var_1 == "_encstr_AF710BF4355A9195B0FF0AEAD0" || var_1 == "_encstr_A3710BEEACC2E0B737EB36B676" || var_1 == "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36" || var_0 == "_encstr_8186089F5F73B918AE52")
    level.attachmentinitialprimary = "_encstr_82360811A967F806376A";
}

addsurvivorattachmentssecondary(var_0) {
  level.attachmentsurvivorsecondary = "_encstr_8BBA05185F8B99";
  level.attachmentsurvivorsecondarytwo = "_encstr_8BBA05185F8B99";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36")
    level.attachmentsurvivorsecondary = "_encstr_82360811A967F806376A";

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(var_0 == "_encstr_BD0D09E45302E7C237D92F") {
      level.attachmentsurvivorsecondary = "_encstr_AD9C07E0478148252A";
      level.attachmentsurvivorsecondarytwo = "_encstr_82360811A967F806376A";
    }
  }
}

addinitialattachmentssecondary(var_0) {
  level.attachmentinitialsecondary = "_encstr_8BBA05185F8B99";
  level.attachmentinitialsecondarytwo = "_encstr_8BBA05185F8B99";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36")
    level.attachmentinitialsecondary = "_encstr_82360811A967F806376A";

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(var_0 == "_encstr_BD0D09E45302E7C237D92F") {
      level.attachmentinitialsecondary = "_encstr_AD9C07E0478148252A";
      level.attachmentinitialsecondarytwo = "_encstr_82360811A967F806376A";
    }
  }
}

monitorsurvivaltime() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_87FC09E8423F63C163DD8D");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    if(!level.infect_chosefirstinfected || !isDefined(self.survivalstarttime) || !isalive(self)) {
      waitframe();
      continue;
    }

    setsurvivaltime(0);
    wait 1.0;
  }
}

initsurvivaltime(var_0) {
  scripts\mp\utility\stats::setextrascore0(0);

  if(isDefined(var_0) && var_0)
    self notify("_encstr_87FC09E8423F63C163DD8D");
}

setsurvivaltime(var_0) {
  if(!isDefined(self.survivalstarttime))
    self.survivalstarttime = self.spawntime;

  var_1 = int((gettime() - self.survivalstarttime) / 1000);

  if(var_1 > 999)
    var_1 = 999;

  scripts\mp\utility\stats::setextrascore0(var_1);

  if(isDefined(var_0) && var_0)
    self notify("_encstr_87FC09E8423F63C163DD8D");
}

shouldplayhalfwayvo() {
  if(!level.didhalfscorevoboost && getteamscore("_encstr_8E8405EA382B2A") >= int(level.players.size - level.players.size / 2)) {
    var_0 = "_encstr_8E8405EA382B2A";
    scripts\mp\utility\dialog::leaderdialog("_encstr_A2B8170D2C6399DD16CB7D3339D22B37911BCBBEB936DE9C2B", var_0, "_encstr_A16D07532531CB4BF7");
    var_1 = scripts\mp\utility\teams::getenemyteams(var_0);

    foreach(var_3 in var_1)
    scripts\mp\utility\dialog::leaderdialog("_encstr_925114D016C699EE85E5EB56E6566BE5BEB9C6F6C959", var_3, "_encstr_A16D07532531CB4BF7");

    level.didhalfscorevoboost = 1;
  }
}

updatematchstatushintonspawn() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(self.team == "_encstr_9A8507BA4040188D08")
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 39);
  else
    self setclientomnvar("_encstr_9B061AD54B7D5B0B3AC61A7DE6D1C247ABDC7DA1B4DC1DD78ECA87E8", 40);
}

_id_11F4B() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA350853C128FB939DB9");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    if(self isnightvisionon()) {
      var_0 = var_0 + level.framedurationseconds;

      if(var_0 >= 9 && !var_1) {
        scripts\mp\hud_message::showerrormessage("_encstr_87F71B53A0AF299C3A056AA2FA3D72C495F2C49EABAF210A51518A2956");
        var_1 = 1;
      }

      if(var_0 >= 10) {
        self nightvisionviewoff();
        self setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 1);
        scripts\common\utility::brjugg_oncrateuse(0);
        _id_12A93();
        scripts\common\utility::brjugg_oncrateuse(1);
        var_1 = 0;
        self setclientomnvar("_encstr_BA5514BAA5D76CA3CCD799C616B3BE6CC2C9C9B42BE4", 0);
        var_0 = 0;
      }
    }

    wait(level.framedurationseconds);
  }
}

_id_12A93() {
  var_0 = 0;

  while(var_0 < 5) {
    var_0 = var_0 + level.framedurationseconds;

    if(self isnightvisionon())
      self nightvisionviewoff();

    wait(level.framedurationseconds);
  }
}

_id_122FF() {
  if(self.team == "_encstr_8E8405EA382B2A") {
    if(scripts\mp\utility\perk::_hasperk("_encstr_84901C53E0AB86FF79793C3998A3A7CEE1B0DACAA86B3D5FD15E2451A8C8"))
      scripts\mp\utility\perk::removeperk("_encstr_84901C53E0AB86FF79793C3998A3A7CEE1B0DACAA86B3D5FD15E2451A8C8");

    if(!scripts\mp\utility\perk::_hasperk("_encstr_84901C53E0AB86FF79793C3998A3A7CEE1B0DACAA86B3D5FD15E2451A8C8"))
      scripts\mp\utility\perk::giveperk("_encstr_84901C53E0AB86FF79793C3998A3A7CEE1B0DACAA86B3D5FD15E2451A8C8");

    scripts\mp\equipment::giveequipment(level.infectedtactical, "_encstr_AC8F0AE74163F85AAA380AD8");
  }
}

_id_13A06() {
  thread headicon_time_left();
}

headicon_time_left() {
  self.loadoutfieldupgrade1 = "_encstr_8BBA05185F8B99";
  self.loadoutfieldupgrade2 = "_encstr_8BBA05185F8B99";
  self.loadoutfieldupgrade1 = level.infectedsuper;
  self.loadoutfieldupgrade2 = level.steam_dmg_trigger_think;
  wait 0.1;

  if(isDefined(self) && scripts\mp\utility\player::isreallyalive(self)) {
    self notify("_encstr_B41712A8020B53141FC99DB7B51B3E07F3EA98B8");
    scripts\mp\supers::clearsuper();
    scripts\mp\perks\perkpackage::perkpackage_reset();
    self.perkpackagedata.istwomode = 1;
    scripts\mp\perks\perkpackage::perkpackage_setstate(0);
    self.perkpackagedata.super = "_encstr_9AEB0D0B93F8274B28E3C25A091E6B";
    var_0 = "_encstr_AAAC09D09972B9C83F2B7F";
    var_1 = scripts\mp\class::zombiesignorevehicleexplosions();
    var_1 = scripts\mp\class::_id_1194E(var_1, var_0);
    scripts\mp\class::loadout_updatefieldupgrades(var_1, var_0);

    if(scripts\mp\utility\perk::_hasperk("_encstr_84901C53E0AB86FF79793C3998A3A7CEE1B0DACAA86B3D5FD15E2451A8C8"))
      scripts\mp\utility\perk::removeperk("_encstr_84901C53E0AB86FF79793C3998A3A7CEE1B0DACAA86B3D5FD15E2451A8C8");

    if(!scripts\mp\utility\perk::_hasperk("_encstr_84901C53E0AB86FF79793C3998A3A7CEE1B0DACAA86B3D5FD15E2451A8C8"))
      scripts\mp\utility\perk::giveperk("_encstr_84901C53E0AB86FF79793C3998A3A7CEE1B0DACAA86B3D5FD15E2451A8C8");

    scripts\mp\equipment::giveequipment(level.infectedtactical, "_encstr_AC8F0AE74163F85AAA380AD8");
    thread scripts\mp\supers::givesuperpoints(level.stealth_enabled, undefined, 1);
  }

  if(istrue(level._id_133F8))
    thread _id_13967();
  else
    thread scripts\mp\hud_message::showsplash("_encstr_B1731913C8A9975A0D6E877AD547927ED12BB79BA163EC826F0DCF");
}

_id_13967() {
  if(scripts\mp\utility\player::isreallyalive(self)) {
    self._id_133CB = 1;
    self suicide();
    waitframe();

    if(isDefined(self)) {
      self.deaths = self.deaths - 1;
      self.pers["_encstr_8E0607055DBFB3919A"] = self.pers["_encstr_8E0607055DBFB3919A"] - 1;
    }
  }

  wait 1;

  if(isDefined(self)) {
    self._id_133CB = undefined;
    thread scripts\mp\hud_message::showsplash("_encstr_B1731913C8A9975A0D6E877AD547927ED12BB79BA163EC826F0DCF");
  }
}

registervehicletype(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.refname = var_0;
  var_3.spawncallback = var_2;
  var_3.vehiclespawns = [[var_1]]();

  if(!isDefined(level.vehicleinfo))
    level.vehicleinfo = [];

  level.vehicleinfo[var_0] = var_3;
}

superselectonunset() {
  level.ignorevehicletypeinstancelimit = 1;
  registervehicletype("_encstr_8C190467402B", scripts\cp_mp\vehicles\atv::atv_getspawnstructscallback, ::vehiclespawn_atv);
  level.vehiclespawnlocs = [];

  foreach(var_1 in level.vehicleinfo) {
    if(var_1.refname == "_encstr_8C190467402B") {
      if(level.mapname == "_encstr_93D20D28714743B99070632BAF3944" && level.localeid == "_encstr_AF3409DC18C12FBD6B6107") {
        var_2 = [];
        var_3 = [];
        var_2[0] = (46022, 1039, 56);
        var_3[0] = (7, 289, 0);
        var_2[1] = (47881, -1404, 115);
        var_3[1] = (8, 294, 0);
        var_2[2] = (47970, -22545, -320);
        var_3[2] = (9, 105, 0);

        for(var_4 = 0; var_4 < var_2.size; var_4++) {
          var_5 = spawnStruct();
          var_5.origin = var_2[var_4];
          var_5.angles = var_3[var_4];
          var_5.script_noteworthy = "_encstr_AF3409DC18C12FBD6B6107";
          var_5.targetname = "_encstr_BE7E0A0F2843CFA3792F7B35";
          var_5.vehicletype = "_encstr_9A981257491E559F356058E910276A60A359D570";
          var_1.vehiclespawns[var_1.vehiclespawns.size] = var_5;
        }

        foreach(var_7 in var_1.vehiclespawns) {
          if(distancesquared(var_7.origin, (53109, -8400, -710)) < 16384) {
            var_7.origin = (46868, -457, 18);
            var_7.angles = (11, 252, 0);
            continue;
          }

          if(distancesquared(var_7.origin, (48215, -1671, 56)) < 16384) {
            var_7.origin = (47906, -676, 55);
            var_7.angles = (11, 309, 0);
          }
        }
      } else if(level.mapname == "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB" && level.localeid == "_encstr_8A34097127C761890FA9D2") {
        var_2 = [];
        var_3 = [];
        var_2[0] = (17806, -20823, -110);
        var_3[0] = (11, 358, 0);
        var_2[1] = (16109, -24057, -144);
        var_3[1] = (1, 90, 0);
        var_2[2] = (18227, -704, -448);
        var_3[2] = (7, 266, 0);
        var_2[3] = (19180, 332, -447);
        var_3[3] = (6, 298, 0);

        for(var_4 = 0; var_4 < var_2.size; var_4++) {
          var_5 = spawnStruct();
          var_5.origin = var_2[var_4];
          var_5.angles = var_3[var_4];
          var_5.script_noteworthy = "_encstr_8A34097127C761890FA9D2";
          var_5.targetname = "_encstr_BE7E0A0F2843CFA3792F7B35";
          var_5.vehicletype = "_encstr_9A981257491E559F356058E910276A60A359D570";
          var_1.vehiclespawns[var_1.vehiclespawns.size] = var_5;
        }

        foreach(var_7 in var_1.vehiclespawns) {
          if(distancesquared(var_7.origin, (18368, -21157, -107)) < 16384) {
            var_7.origin = (16572, -19828, 86);
            var_7.angles = (2, 55, 0);
            continue;
          }

          if(distancesquared(var_7.origin, (19526, -15475, -97)) < 16384) {
            var_7.origin = (19177, -15490, -116);
            var_7.angles = (2, 64, 0);
          }
        }
      }
    }

    foreach(var_7 in var_1.vehiclespawns) {
      if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(var_7.script_noteworthy) && var_7.script_noteworthy == level.localeid) {
        var_12 = level.vehiclespawnlocs.size;
        level.vehiclespawnlocs[var_12] = var_7;
        level.vehiclespawnlocs[var_12].refname = var_1.refname;
      }
    }
  }

  if(0) {
    foreach(var_16 in level.vehiclespawnlocs)
    thread scripts\mp\utility\debug::drawline(var_16.origin, var_16.origin + (0, 0, 1500), 1000, (1, 0, 0));
  }

  level.vehiclespawnlocs = scripts\engine\utility::array_randomize(level.vehiclespawnlocs);
  var_18 = level._id_11F41;

  if(!isDefined(level._id_11F41))
    var_18 = 25;

  if(0) {
    for(var_4 = 0; var_4 < var_18; var_4++) {
      var_16 = level.vehiclespawnlocs[var_4];
      thread scripts\mp\utility\debug::drawline(var_16.origin + (0, 0, 1500), var_16.origin + (0, 0, 2500), 1000, (0, 1, 0));
    }
  }

  for(var_4 = 0; var_4 < var_18; var_4++) {
    var_16 = level.vehiclespawnlocs[var_4];

    if(isDefined(var_16)) {
      var_1 = level.vehicleinfo[var_16.refname];
      [[var_1.spawncallback]](var_16);
    }
  }
}

vehiclespawn_atv(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, randomfloat(360), 0);

  var_2 = vehiclespawn_getspawndata(var_0);
  return scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle("_encstr_8C190467402B", var_2, var_1);
}

vehiclespawn_getspawndata(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "_encstr_AFBE0AD105A651FA9A3D8854";
  var_1.showheadicon = 1;
  return var_1;
}

_id_129FB() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.steam_damage_player = [];
  level thread _id_13254();
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  wait(level.droptime);
  level.grnd_previouscratetypes = [];

  for(;;) {
    var_0 = scripts\engine\utility::random(scripts\mp\utility\teams::getteamdata("_encstr_9A8507BA4040188D08", "_encstr_9775086022BE1B413B8B"));
    var_1 = 1;

    if(isDefined(var_0) && scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level.fauxvehiclecount + var_1 < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      var_2 = _encstr_A9631EE6B1939638D1B9F2B6C1973B85B6AC3AF283ACE65EEC4EDC2371CEDCD8::getdropzonecratetype();
      var_3 = remove_medic_class();

      if(!isDefined(var_3)) {
        return;
      }
      if(var_2 == "_encstr_84A20520D7F798") {
        var_4 = spawnStruct();
        var_4.cratetype = undefined;
        var_4.numcrates = undefined;
        var_4.usephysics = undefined;
        scripts\cp_mp\killstreaks\airdrop_multiple::airdrop_multiple_dropcrates(var_0, var_0.team, var_3, randomfloat(360), var_3, var_4);
      } else {
        scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
        scripts\cp_mp\killstreaks\airdrop::dropkillstreakcratefromscriptedheli(var_0, var_0.team, var_2, var_3, randomfloat(360), var_3, 1);
      }

      var_5 = level.droptime;
    } else
      var_5 = 0.5;

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_5);
  }
}

remove_medic_class() {
  var_0 = level.steam_damage_player[0];
  level.steam_damage_player[level.steam_damage_player.size] = level.steam_damage_player[0];
  level.steam_damage_player[0] = undefined;
  level.steam_damage_player = scripts\engine\utility::array_removeundefined(level.steam_damage_player);
  return var_0;
}

_id_13254() {
  switch (level.mapname) {
    case "_encstr_BD920F0D81997FD7D4B83B7263A0DF77BB":
      level.steam_damage_player = [(21298, -15989, 1970), (22131, -18582, 690), (17264, -17920, 1066), (16682, -23069, 230), (21664, -23061, -108), (16208, -13686, -158), (19920, -18069, 157), (25150, -17449, -150), (27173, -14625, -200), (22696, -12784, -158), (22115, -12162, -106), (22278, -10595, 1610), (19963, -14131, 149), (20019, -11243, -194), (16711, -8999, -326), (15772, -5966, -390), (15501, -1873, -446), (19760, -1172, -449), (20464, -2047, -450), (23814, -5888, -382), (26210, -9404, -318), (30288, -8981, -358), (20781, -7208, -366), (18773, -13037, 9), (20091, -21421, -78), (23574, -14769, -134)];
      break;
    case "_encstr_8B240B70C2BF685DFA3B1DF3C2":
      level.steam_damage_player = [(25008, 32313, 826), (29171, 32156, 659), (25021, 37011, 841), (30305, 35572, 526), (30779, 33427, 1009), (28913, 38886, 888), (25888, 40248, 1680), (27533, 43285, 1792), (31199, 37768, 722), (33534, 35968, 1103), (34872, 33255, 664), (33704, 39718, 1395), (35903, 39512, 879), (32265, 46424, 1450), (35084, 43008, 960), (38700, 43064, 1087), (36348, 44694, 481), (34805, 48469, 1317), (32313, 39712, 767)];
      break;
    case "_encstr_BA3F0A7D37E6935EE590C3CF":
    case "_encstr_93D20D28714743B99070632BAF3944":
      level.steam_damage_player = [(51478, -24749, -55), (50222, -21762, -335), (46165, -20091, -409), (49089, -18057, -359), (54074, -16693, -307), (52289, -14523, -335), (48361, -13952, -1), (43445, -16524, -405), (43634, -13100, -51), (47714, -14136, 141), (50498, -12784, -199), (53744, -11930, -510), (52284, -7268, -672), (49723, -7122, 438), (47540, -10295, 266), (48403, -7548, 291), (53225, -3832, -456), (49419, -4336, 141), (49419, -4336, 141), (47101, -1784, 116), (43600, -3193, 340), (42522, -6972, 30), (45959, -5516, 328), (46058, -8625, 136)];
      break;
    case "_encstr_AC880C67503EA82A05DD62214CE7":
      level.steam_damage_player = [(40724, -13376, -58), (37115, -14577, -152), (35766, -19268, -508), (38572, -18749, -508), (42023, -19947, -500), (40116, -25824, -247), (38056, -23083, 240), (35024, -24401, -508), (36958, -26270, -112), (36264, -28611, -36), (38229, -28438, -452), (38304, -30376, -172), (33276, -26940, -116), (30526, -27712, -508), (29810, -29730, -508), (33689, -28898, -507), (36498, -33452, -508), (37219, -37142, -506), (34863, -34724, -318), (34304, -36576, -506), (31116, -35074, -508), (32797, -32582, -372)];
      break;
    case "_encstr_831E0F7F2968E2AFC819F0FED3B0D70AD4":
      level.steam_damage_player = [(-28661, -17966, -177), (-30406, -15324, -159), (-26858, -14816, 3), (-26567, -8261, 17), (-23466, -14624, -12), (-24687, -11527, 238), (-24492, -10369, 148), (-25965, -11096, 27), (-29884, -12919, -43), (-30458, -10020, -136), (-28564, -9301, 248), (-29994, -6709, -208), (-28156, -5883, -119), (-30522, -3889, -247), (-28220, -3171, -255), (-25333, -4300, -242), (-28106, -1937, -255), (-30823, -2351, -248), (-29121, -11011, -61)];
      break;
    case "_encstr_93FB0A6B1C7D2CB92D5EB00D":
      level.steam_damage_player = [(2716, -158, 708), (8215, 874, 342), (6524, 1561, 316), (5827, -860, 357), (4268, -47, 452), (2305, -1994, 386), (5172, 2587, 231), (2691, 3096, 302), (-910, 3497, 318), (-3579, -544, 320), (2591, 1659, 545), (1033, -514, 447), (-93, -2789, 169), (-1301, 924, 315), (-2843, 2779, 316)];
      break;
    default:
      level.steam_damage_player = relic_healthpacks();
      break;
  }

  level.steam_damage_player = scripts\engine\utility::array_randomize(level.steam_damage_player);
}

relic_healthpacks() {
  var_0 = [];
  var_1 = getEntArray("_encstr_9A7205B39CB919", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(level.mapname == "_encstr_A2200CDA13D6CBC897E1A0EBAA93") {
    var_2 = [];

    foreach(var_4 in var_1) {
      if(var_4.script_label == "_encstr_A34C02BB" && distance(var_4.origin, (-333, 1999, 119)) < 5) {
        var_2[var_2.size] = var_4;
        continue;
      }

      if(var_4.script_label == "_encstr_A74C0222" && distance(var_4.origin, (189, 1564, 75)) < 5) {
        var_2[var_2.size] = var_4;
        continue;
      }

      if(var_4.script_label == "_encstr_A14C023B" && distance(var_4.origin, (-751, 2416, 81)) < 5) {
        var_2[var_2.size] = var_4;
        continue;
      }

      if(var_4.script_label == "_encstr_AC4C024A" && distance(var_4.origin, (165, 2420, 79)) < 5) {
        var_2[var_2.size] = var_4;
        continue;
      }

      if(var_4.script_label == "_encstr_B84C027E" && distance(var_4.origin, (-823, 1536, 68)) < 5)
        var_2[var_2.size] = var_4;
    }

    var_1 = scripts\engine\utility::array_remove_array(var_1, var_2);
  }

  if(var_1.size > 0) {
    foreach(var_4 in var_1)
    var_0[var_0.size] = var_4.origin;
  }

  return var_0;
}

steam_fx_off() {
  var_0 = getdvarint("_encstr_A7AA16E636E4D7969BCCB28D8EAF9AEA763B12B2C21BD10D", 2000);
  self.maxhealth = var_0;
  self.startinghealth = var_0;
}

playgotinfectedsoundcount(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(var_0.team == "_encstr_8E8405EA382B2A" && scripts\mp\utility\weapon::iskillstreakweapon(var_3.basename) && !scripts\mp\utility\weapon::weaponbypassspawnprotection(var_3) && var_4 != "_encstr_8DED0A21C79B660BC7588981")
    var_5 = 1;

  return var_5;
}

_id_1314D() {
  var_0 = getspawnpoint();
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1.playerspawnpos = var_0.origin;
  var_1.playerspawnangles = var_0.angles;
  var_1.notti = 0;
  var_1.issuper = 1;
  var_1._id_133E3 = 1;
  self.setspawnpoint = var_1;
}

_id_14124(var_0, var_1) {
  return 1;
}

_id_133F7() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A9BA173368BB9B54A0D37F5BD1309BEBF0E32BCB7096678E88");
  self endon("_encstr_A9BA173368BB9B54A0D37F5BD1309BEBF0E32BCB7096678E88");
  var_0 = 0;
  var_1 = 1;

  for(;;) {
    if(var_1)
      self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");
    else
      self waittill("_encstr_BA350853C128FB939DB9");

    if(self.pers["_encstr_8AEF05472BC2D6"] == "_encstr_9A8507BA4040188D08") {
      continue;
    }
    if(var_0 < 2) {
      if(!var_0)
        wait 5;

      scripts\mp\utility\lower_message::setlowermessageomnvar(77);
      wait 5;
      scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      var_0++;
      continue;
    }

    break;
  }
}