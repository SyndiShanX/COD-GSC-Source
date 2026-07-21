/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_gulag.gsc
***********************************************/

initgulag() {
  level._id_12CA0 = getdvarfloat("_encstr_A66D1FDEBE43DF112A2FD868F74009F7EA295E6B528A7139C9D3F010EB78E717F3", 0.75);

  if(!istrue(level.usegulag)) {
    return;
  }
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_9B220634456A5747")) {
    level.usegulag = 0;
    return;
  }

  setomnvar("_encstr_A7990F658429177BBC4FF8417FDCB179D2", 1);
  setomnvar("_encstr_BA091CD3A071EFD349BBEF178763BA37C9490DDD9BA8BECA0877ABE7A19D", 0);
  level.gulag = spawnStruct();
  level.gulag.arenaflag = getdvarint("_encstr_8A1C0F9BB04D712BD338F6EBD0B9DB069F", 1);
  level.gulag.maxplayers = getmaxplayers();
  level.gulag.maxuses = getdvarint("_encstr_A77913BB906D510B33D8160BF0F8CF208F88235268", 1);
  level.gulag.endonshutdown = getdvarint("_encstr_9AAD1AE66C27F58993F5CCD8AFCACD23AF7B37AF371AD547C8DEBBDC", 3);
  level.gulag.timelimit = getdvarint("_encstr_BD96149B6C9CBE269CEB33D87D3A4BDAB2B14BB5B48E", 15.0);
  level.gulag.maxqueue = getdvarint("_encstr_BAF619E61B27F526C9AF33D8F5DA85E1FAC5BAAC5DCAF5BB8596A3", 3);
  level.gulag.onekillwin = getdvarint("_encstr_BDF0174B1146FF1E182FFEC317C8255F788862C29888E71410", 1);
  level.gulag.multiarena = getdvarint("_encstr_BAB8161F9B6A09DE231111B939770DC883F93FB312174897", 1);
  level.gulag.planerespawn = getdvarint("_encstr_8217186E6C4EAF8939D7CCB17D071B2C9B2B7DC9CAE638B077DC", 0);
  level.gulag.trial_target_civilian_killed_func = getdvarint("_encstr_8CD61A2B1BFDC19B43A8669B40C863D325C851A2C8AD07FF19256193", 1);
  level.gulag._id_14069 = getdvarint("_encstr_AFC4180F078649DA20463F467E20F322C693FB8B8F2F1287A8AB", 1);
  level.gulag._id_1407F = getdvarint("_encstr_885A18E6B139D7C4E4D733C6BED5E62B918DDBED9C29F66C6DE6", 0);
  level.gulag._id_13672 = getdvarint("_encstr_A60E14831F258F2140660B46D9D6A921079A195F1023", 0);
  level.gulag.lethaldelay = getdvarint("_encstr_AD7E1637364E7D1393EB66D8BE36CAD134B063882BC60B5E", 4);
  level.gulag._id_1391B = getdvarint("_encstr_8539200F67CB40E08A29C961C150B885738385BB07420880B53D169B742548C8CB6B", 9);
  level.gulag._id_11F2D = getdvarint("_encstr_A24619B98DC9FA3127BECCB1AF9BEADA50E4B67B9C12CAC2C61D34", 0);
  level.gulag._id_11F19 = getdvarint("_encstr_AD0416E61B937D4C4ED7D9BAD885767D9BD56D2B47BD77CD", 0);
  level.gulag.untrack_enemy = getdvarint("_encstr_8FF214A33F9B7905BECF5F556A5A142142931D5ECAC9", 0);
  level.gulag.impairedkill = getdvarint("_encstr_AA9D189653FBDEFDA2B17848A9BEAFD333EC95B7BF6367D34D7A", 3);
  level.gulag.juggheli_spawner_jammer5_2 = getdvarint("_encstr_93BA197B21762FCEC8DF0E13C7A0D703171B0293EFC1DF85108312", 5);
  level.gulag.getaccessorylogicbyindex = getdvarint("_encstr_9BAE139B8DE4F54C39F5B3D5B1163B7DD80D164B93", 0);
  level.gulag._id_142FB = getdvarint("_encstr_BAC114BA66F88E0623A9017B150607B1880F8BDFA7E3", 1);
  level.gulag._encstr_865E1B2B20C15FC37040899C68B85F2577D872E3588553BF88B88D8EFD = getdvarint("_encstr_956120DCB14EEBC9568C568336B7F245DEB5CAE6D7D8BD9B3B569C4750D6DEAB73D1", 40);
  level.gulag._encstr_8B541864AD6BF12FFB1AA8D0E2D6C7E8EB257665113778432593 = getdvarint("_encstr_8D3D1D86E61B87D9459B28204367903B020176B73DF34B232C4740682F8E4B", 20);
  level.gulag._encstr_911C1444A26267EDD1C8BD23F93BB33030452B3B09D2 = getdvarint("_encstr_9B1F273E4E8B4883B8B74B584F876E3EA77ECF371F1061E1B39FB7C17F57553A4B5A61519B5B81CDAD", 5);
  _setdomflagiconinfo("_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1", "_encstr_A7A408B9CA5D1D4E2C63", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  _setdomflagiconinfo("_encstr_859A1183D94B3B2548D56447E7202A93F5133A", "_encstr_88BF06FD784A6393", "_encstr_8D1719D1B969458FB799F07CA9C7555707D059B96036D907F7EA6D", 0);
  _setdomflagiconinfo("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_ACB71FA04759DCD6891D9554091C3EFCE1D6B7E6FA7184F94D086C08079BEF0FCA", 0);
  _setdomflagiconinfo("_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BA37220373A9AB257CAED1AD0FD7A198E9AA287DD30ED890A9571D39C965C1416F23B19F", 0);
  _setdomflagiconinfo("_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509", "_encstr_93B508770F528D90B3DB", "_encstr_A6A8224D5B417F4860B718FF8987ED7169EF9D3BDA115FA75019451399C7E187BDAFE1C6", 1);
  _setdomflagiconinfo("_encstr_B40710E36BBF4F179FCD9CC8C9B1F3836012", "_encstr_ACFC091AE8AB2FCBE15119", "_encstr_BDCF1FA641BE92C9D1146AA2D77A2762CA973D09A4FA15A02D929C74EBD00A416A", 1);
  _setdomflagiconinfo("_encstr_8202100F51F881C7C0F2255890A5865376FF", "_encstr_88BF06FD784A6393", "_encstr_8D341FA982AF25E48E28A6A2AFE972312BCB3D2449EB31F44DA4E48EF50DA014A9", 1);
  level.gulag.watch_for_near_objective_point = [];

  if(istrue(level.gulag.arenaflag))
    _encstr_BD8926CDD8E42D073A9B976B0ECBCEC2B6B21DCBC1596E79C427EB197BB5AF2EAB95B947B83B37B1::_id_13239();

  level.gulag.arenas = gulaggetarenas();
  gulaggesturesinit();
  gulaginitloadouts();

  if(level.gulag.trial_target_civilian_killed_func)
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_12521);

  if(level.gulag._id_1407F)
    scripts\engine\scriptable::_id_12F5B("_encstr_BA3B0C5DFB65E767E5292887339F", ::rockused);

  level.gulag.betting = getdvarint("_encstr_AB741243F70D794E72C72C1647F6E8449D6F520C", 0);

  if(level.gulag.betting) {
    if(!istrue(level.br_plunder_enabled))
      level.gulag.betting = 0;

    if(getdvarint("_encstr_AA9D189653FBDEFDA2B17848A9BEAFD333EC95B7BF6367D34D7A", 3) == 3)
      level.gulag.impairedkill = 15;
  }

  if(!isDefined(level.gulag.arenas[0].jailspawns[0].chair))
    level.gulag.getaccessorylogicbyindex = 0;

  foreach(var_1 in level.gulag.arenas)
  level thread monitorgulag(var_1);

  thread spawnac130();
  tracegroundheightexfil();
  level.playerzombieupdateongamepadchange = ::_id_12AA8;
  level.playimpactfx = ::_id_12AAA;
}

_setdomflagiconinfo(var_0, var_1, var_2, var_3) {
  level.waypointcolors[var_0] = var_1;
  level.waypointbgtype[var_0] = 1;
  level.waypointstring[var_0] = var_2;
  level.waypointshader[var_0] = "_encstr_A22F2FEA4BEBD683EB1393EB6BB038ADCA73EAAF96D8DEB9EBCEAEC658ECBEDBEC9527E8A56B2BAFDE31A9956C3A4BCECA";
  level.waypointpulses[var_0] = var_3;
}

tracegroundheightexfil() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A3BD0CC1735C3884C98FA9938782"] = "_encstr_A3BD0CC1735C3884C98FA9938782";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_879112B3ABD8859DBE9B0E2CEEE67DE4BA8D566E"] = "_encstr_879112B3ABD8859DBE9B0E2CEEE67DE4BA8D566E";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2E81010FF4409EFE9CD3E32A7C201F0A657"] = "_encstr_B2E81010FF4409EFE9CD3E32A7C201F0A657";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B6160BEC039A9BB90FF368F8E3"] = "_encstr_B6160BEC039A9BB90FF368F8E3";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2EE0AF2285926E79ED4010E"] = "_encstr_B2EE0AF2285926E79ED4010E";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A7090BD76D0D18BC77C2109BBA"] = "_encstr_A7090BD76D0D18BC77C2109BBA";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BE2815CF43C8F62F183392DA78696FEB28AF47459958BF"] = "_encstr_BE2815CF43C8F62F183392DA78696FEB28AF47459958BF";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_B2C314E807BCE10731A3051FFD4A530B1D173830F74D"] = "_encstr_B2C314E807BCE10731A3051FFD4A530B1D173830F74D";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_979F13E79358594280C1B79FCBB1EA84C83E1BEC68"] = "_encstr_979F13E79358594280C1B79FCBB1EA84C83E1BEC68";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_AC6B13504B12ABEF9F6F93AA4F7F1F865E8B38D3A1"] = "_encstr_AC6B13504B12ABEF9F6F93AA4F7F1F865E8B38D3A1";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_83A5123B57D8B0ECFA3BAB1B85CEAF1BD87B6E56"] = "_encstr_83A5123B57D8B0ECFA3BAB1B85CEAF1BD87B6E56";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_97D70EF7537DFFAF99A02830BD970D98"] = "_encstr_97D70EF7537DFFAF99A02830BD970D98";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_A1F20ED9ABB1169DF58E5AB6B2BDAB47"] = "_encstr_A1F20ED9ABB1169DF58E5AB6B2BDAB47";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8D630EF77BF0CE0730E9FB23F1775F04"] = "_encstr_8D630EF77BF0CE0730E9FB23F1775F04";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BD570C32E89966A7DE1549552083"] = "_encstr_BD570C32E89966A7DE1549552083";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_84360F0F7BB0B1BA681F331B172482E1D8"] = "_encstr_84360F0F7BB0B1BA681F331B172482E1D8";
}

gulaggetarenas() {
  var_0 = relic_steelballs_dash();

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    var_0 = scripts\engine\utility::getStructArray("_encstr_BD100F6713D8D9C2AF41774B4FBEEA1163", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_2.set_relic_oneclip = var_1;
    setuparena(var_2);
  }

  return var_0;
}

relic_steelballs_dash() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9B220634456A5747", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "_encstr_8CA809D3C06D1533A7C41D";

    if(istrue(level.gulag._id_11F19) && var_4 || !istrue(level.gulag._id_11F19) && !var_4)
      var_1[var_1.size] = var_3;
  }

  if(var_1.size > 0)
    var_0 = var_1;

  if(var_0.size > 1)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  return var_0;
}

setuparena(var_0) {
  var_0.jailspawns = [];
  var_0.fightspawns = [];
  var_0.get_wave_spawn_total = [];
  var_0.gates = [];
  var_0.floor = [];
  var_0.weapons = [];
  var_0.molotovs = [];
  var_0._id_13B29 = [];
  var_0.getactiveteamcount = [];
  var_0._id_12D93 = [];
  var_0.jailedplayers = [];
  var_0.arenaplayers = [];
  var_0.matches = [];
  var_0.loadingplayers = [];
  var_0.fightover = 1;
  var_0._id_11FCF = [];
  var_0._id_11FCF["_encstr_A1B616A34F46F220A1797089E6CCC7CBEDFFBFDD1BB3D9A7"] = 0;
  var_0._id_11FCF["_encstr_8C7C11DB3337AAE27EA0771BB851979223D5A6"] = 0;
  var_1 = [];
  var_2 = scripts\engine\utility::getStructArray(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    if(var_4.script_noteworthy == "_encstr_99250D6BFA01F0D89207676917EB90") {
      var_0.jailspawns[var_0.jailspawns.size] = var_4;
      continue;
    }

    if(var_4.script_noteworthy == "_encstr_864E0CF2175820C111B3EBF26B15") {
      var_0.fightspawns[var_0.fightspawns.size] = var_4;
      continue;
    }

    if(var_4.script_noteworthy == "_encstr_A5670BCFFD71582FEEB7F178ED") {
      var_0.get_wave_spawn_total[var_0.get_wave_spawn_total.size] = var_4;
      continue;
    }

    if(var_4.script_noteworthy == "_encstr_9ACE0D771569A2DF56D85F6B784982") {
      var_0.center = var_4.origin;
      continue;
    }

    if(var_4.script_noteworthy == "_encstr_AF8C0A1B6A1D6045925B4F7D") {
      var_0._id_136DC = var_4;
      continue;
    }

    if(isDefined(var_4.script_parameters) && var_4.script_parameters == "_encstr_A3090B97176357DFD19AA8E06C") {
      var_1[var_1.size] = var_4;
      continue;
    }

    if(var_4.script_noteworthy == "_encstr_82D0074002AC3F51CF")
      var_0._id_12D93[var_0._id_12D93.size] = var_4;
  }

  if(!isDefined(var_0.center))
    var_0.center = getgulagcenter(var_0);

  if(getdvarint("_encstr_B29C19336A93F840D2178DFF6FFA58BB9BB34959317FA780AB0EAF", 1) > 0)
    var_0.fightspawns = scripts\engine\utility::array_sort_with_func(var_0.fightspawns, ::hidequestobjiconfromplayer);
  else
    var_0.fightspawns = scripts\engine\utility::array_sort_with_func(var_0.fightspawns, ::hiderespawntimer);

  foreach(var_7 in var_0.get_wave_spawn_total)
  _id_1322E(var_0, var_7);

  var_0.get_wave_spawn_total = scripts\engine\utility::array_sort_with_func(var_0.get_wave_spawn_total, ::hiderespawntimer);

  foreach(var_10 in var_0.jailspawns)
  _id_13255(var_0, var_10);

  if(istrue(level.gulag._id_13672))
    var_0.weapons = spawnlootweapons(var_1);

  spawnrocks(var_0);

  if(istrue(level.gulag.arenaflag))
    _id_1323A(var_0);
}

gulaggesturesinit() {
  level.gulag.gestures_enabled = getdvarint("_encstr_884E13B01AB28F79F31F74FE07FFC19F9BC33098F3", 0);

  if(!istrue(level.gulag.gestures_enabled)) {
    return;
  }
  level.gulag.gestures = [];
  level.gulag.gestures["_encstr_BEDB0FBF96975A555B98978378B606224F"] = ["_encstr_88361B30BB82CE11536F5138F1AB9B092812DB93BBFB3D17B99D6B3B18", "_encstr_BD551BD2F831E9A7999677502122CB2127F0FBFBAB7DDF0F13F75C7443", "_encstr_A6FD1C2FF3BA51912AABA6C7C0D96B5117FBBB8377B0454F186AD3DF348A"];
  level.gulag.gestures["_encstr_ABDB0F5A5190DF1FD0B92D12A38962372E"] = ["_encstr_81A32061E7CAD98FA573D12BB883838158BBF3E44B209FA7DDE84B12C0D553C4D013", "_encstr_839D1A97DF33D94F0873C112883082116403777B73BE223F08D8051F", "_encstr_87061879742FC7CFE99B8127C181B2870F21505D85A203D78793", "_encstr_832A1FD8DF7719EFF74BF02939B206CFD77A4EABFB331DB16BC87B3D61DED97DE3"];
  level.gulag.gesturesounds["_encstr_BEDB0FBF96975A555B98978378B606224F"] = ["_encstr_BDCF1C3AB5E0BEEC5DC60BB3D73BB29BA3BAC995F57359B37DC6E4576E1A", "_encstr_A9391C3BC702993A4B0C8F0FB027A04B0B9D1A37A70577C159638FB2C25F", "_encstr_AD541D5BC007B70917B2E9B02EA78DC3D3A5C36F019D5F27B6CADDF5B0E3FF"];
  level.gulag.gesturesounds["_encstr_ABDB0F5A5190DF1FD0B92D12A38962372E"] = ["_encstr_AAE921A372BA174167D40F748F474917E35B882BC952BF1BF7C4B7758AB3B1D10CA2B8", "_encstr_96EB1BA36BC1D7B35D8D1676BED92BE6475D4EB2AF1CDEE67DD07B6391", "_encstr_A2C819A35BE0EBCEABB116D9AF762BB91DD527CAD738F6DC7DBD5B", "_encstr_977B207CCAA249EAB59B0858DEF9B77673BBE09FE1FBBFBBF0B3E33DB070C8797DDB"];
}

getmaxplayers() {
  var_0 = int(clamp(getdvarint("_encstr_86FA16CD8D27D713C9FA338DAF5BC2C3F50763C2F2959CCD", 2), 2, 2));

  if(var_0 % 2 != 0)
    var_0 = var_0 - 1;

  return var_0;
}

hiderespawntimer(var_0, var_1) {
  return var_0.script_index < var_1.script_index;
}

hidequestobjiconfromplayer(var_0, var_1) {
  if(var_0.script_index == 4)
    return 1;
  else if(var_0.script_index == 5)
    return 1;
  else if(var_1.script_index == 4)
    return 0;
  else if(var_1.script_index == 5)
    return 0;

  return hiderespawntimer(var_0, var_1);
}

copystructwithoffset(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_0.origin + var_1;
  var_3.angles = var_0.angles;
  var_3.script_index = var_2;
  return var_3;
}

getgulagcenter(var_0) {
  var_1 = (0, 0, 0);

  foreach(var_3 in var_0.fightspawns)
  var_1 = var_1 + var_3.origin;

  var_1 = var_1 / var_0.fightspawns.size;
  return var_1;
}

spawnweapon(var_0, var_1, var_2) {
  var_3 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::createspawnweaponatpos(getgroundposition(var_0.origin + (0, 0, 12), 12), var_0.angles + (0, 0, 90), var_1, []);
  var_3 thread outlinewatchplayerprox(var_2);
  return var_3;
}

spawnlootweapons(var_0) {
  var_1 = [];
  var_2 = [];
  var_2["_encstr_8BBA05185F8B99"] = ["_encstr_8BBA05185F8B99"];
  var_2["_encstr_99C209E34FC743616118AB"] = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getgulagpickupsforclass("_encstr_99C209E34FC743616118AB");
  var_2["_encstr_B116071BCAD186858D"] = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getgulagpickupsforclass("_encstr_B116071BCAD186858D");
  var_3 = [];

  foreach(var_5 in var_2) {
    foreach(var_7 in var_5) {
      var_8 = 1;

      if(isDefined(var_3[var_7])) {
        continue;
      }
      var_9 = level.br_lootiteminfo[var_7];

      if(isDefined(var_9)) {
        var_10 = level.br_lootiteminfo[var_7].baseweapon + "_encstr_851A049F8337";
        var_8 = weaponclipsize(var_10) * 1;
      }

      var_3[var_7] = var_8;
    }
  }

  var_13 = ["_encstr_99C209E34FC743616118AB", "_encstr_99C209E34FC743616118AB", "_encstr_B116071BCAD186858D", "_encstr_B116071BCAD186858D", "_encstr_B116071BCAD186858D"];
  var_13 = scripts\engine\utility::array_randomize(var_13);
  var_14 = [];
  var_14["_encstr_A3DE100DAC65C08ECF9A0950D31F46896A69"] = scripts\engine\utility::random(var_2[var_13[0]]);
  var_14["_encstr_93DE10A7099FB23AA648CFDBC8D9F279F9BE"] = scripts\engine\utility::random(var_2[var_13[1]]);
  var_14["_encstr_95AA0F991BBDDE4EFA27D29D0DA3EB1889"] = scripts\engine\utility::random(var_2[var_13[2]]);
  var_14["_encstr_976E0E338DBD7B39AFB1ACCC1DEB1898"] = scripts\engine\utility::random(var_2[var_13[3]]);
  var_14["_encstr_91CA0D998DB7ED93EBDA5A32AF06C4"] = scripts\engine\utility::random(var_2[var_13[4]]);

  if(getdvarint("_encstr_B29C19336A93F840D2178DFF6FFA58BB9BB34959317FA780AB0EAF", 1) > 0)
    var_14["_encstr_976E0E338DBD7B39AFB1ACCC1DEB1898"] = var_14["_encstr_95AA0F991BBDDE4EFA27D29D0DA3EB1889"];

  foreach(var_16 in var_0) {
    if(!isDefined(var_16.script_noteworthy)) {
      continue;
    }
    var_17 = var_14[var_16.script_noteworthy];

    if(!isDefined(var_17)) {
      continue;
    }
    if(var_17 == "_encstr_8BBA05185F8B99") {
      continue;
    }
    var_18 = var_16.origin;
    var_19 = var_16.angles;

    if(!isDefined(var_19))
      var_19 = (0, 0, 0);
    else
      var_19 = (0, var_19[1], 0);

    var_7 = easepower(var_17, var_18, var_19);

    if(isDefined(var_7)) {
      var_7.part = var_17;
      _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_119F5(var_7, var_3[var_17]);
      var_7.keepinmap = 1;
      var_1[var_1.size] = var_7;
      continue;
    }
  }

  return var_1;
}

_id_125EE(var_0) {
  if(_id_125EF(var_0)) {
    var_1 = var_0.matches[0];

    foreach(var_3 in var_1) {
      if(var_3 == self)
        continue;
      else if(updatelootleadercirclesize(var_3, var_0))
        return 0;
    }

    return 1;
  }

  return 0;
}

_id_125EF(var_0) {
  if(ismatchpending(var_0)) {
    var_1 = var_0.matches[0];

    foreach(var_3 in var_1) {
      if(var_3 == self)
        return 1;
    }
  }

  return 0;
}

ismatchpending(var_0) {
  if(var_0.matches.size == 0)
    return 0;

  var_1 = var_0.matches[0];

  if(var_1.size < 2)
    return 0;

  return 1;
}

isfightready(var_0) {
  if(!ismatchpending(var_0))
    return 0;

  var_1 = var_0.matches[0];

  foreach(var_3 in var_1) {
    if(istrue(var_3.entergulagwait) || !istrue(var_3.jailed))
      return 0;
  }

  return 1;
}

set_relic_noregen(var_0) {
  var_1 = 5000;

  if(!isDefined(var_0._id_11E78)) {
    var_0._id_11E78 = gettime() + var_1;
    return;
  }

  if(gettime() > var_0._id_11E78) {
    var_0.jailedplayers = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);
    updatematchqueuepositions(var_0);

    if(var_0.set_relic_oneclip == 0) {
      level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_removeundefined(level.gulag.watch_for_near_objective_point);

      foreach(var_3 in level.gulag.watch_for_near_objective_point) {
        if(!istrue(var_3.inlaststand))
          level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_remove(level.gulag.watch_for_near_objective_point, var_3);
      }
    }

    var_0._id_11E78 = gettime() + var_1;
  }
}

monitorgulag(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = relic_amped_paused();

  for(;;) {
    set_relic_noregen(var_0);

    if(istrue(level.br_prematchstarted)) {
      if(istrue(level.gulag.shutdown)) {
        if(var_0.loadingplayers.size != 0)
          var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_9A7B148DDE0B1996DC9D821B0BF2B2399BA85B381DF2", var_1);

        if(level.gulag.endonshutdown == 1) {
          foreach(var_3 in var_0.jailedplayers) {
            var_3.gulagloser = 1;
            var_3 kill();
          }

          var_0.shutdown = 1;
        } else if(level.gulag.endonshutdown == 2)
          thread dojailbreak(var_0);
        else if(level.gulag.endonshutdown == 3 && (istrue(var_0.shutdown) || !ismatchpending(var_0) && !c130airdrop_getteamaveragepos())) {
          foreach(var_3 in var_0.jailedplayers) {
            if(isalive(var_3)) {
              var_3 playergulagarenaready();
              thread gulagvictory(var_0, var_3, 1, 0, "_encstr_ABEF097343AB23ABD89446");
            }
          }

          var_0.shutdown = 1;
        }
      }

      if(unset_relic_martyrdom()) {
        waitframe();
        continue;
      }

      if(isfightready(var_0))
        beginnewfight(var_0);
      else
        _id_13165(var_0);
    }

    waitframe();
  }
}

_id_12219(var_0) {
  if(!istrue(level.usegulag)) {
    return;
  }
  level.gulag.paused = var_0;
}

unset_relic_martyrdom() {
  return istrue(level.usegulag) && istrue(level.gulag.paused);
}

calloutmarkerping_cp_setupcptimeouts() {
  if(!istrue(level.usegulag))
    return 0;

  foreach(var_1 in level.gulag.arenas) {
    if(!var_1.fightover)
      return 1;
  }

  return 0;
}

vehicle_compass_cp_shouldbevisibletoplayer() {
  if(isDefined(self) && isalive(self))
    gulagvictory(self.arena, self, 1, 1, "_encstr_87480FCA60BB7DEB13E531239DFBBF85F9");
}

circletimer(var_0) {
  if(istrue(level.usegulag) && !istrue(level.gulag.shutdown)) {
    var_1 = remove_engineer_class();

    if(var_0 >= var_1)
      shutdowngulag("_encstr_BAA70D43AB53970DDBF1921AD023C0", var_0);
  }
}

shutdowngulag(var_0, var_1, var_2) {
  if(!istrue(level.usegulag) || istrue(level.gulag.shutdown)) {
    return;
  }
  setomnvar("_encstr_A7990F658429177BBC4FF8417FDCB179D2", 0);
  setomnvar("_encstr_BA091CD3A071EFD349BBEF178763BA37C9490DDD9BA8BECA0877ABE7A19D", 2);
  level.gulag.shutdown = 1;

  if(isDefined(level._id_12851))
    [[level._id_12851]]();

  thread makeac130flyaway();

  if(!istrue(var_2)) {
    foreach(var_4 in level.players) {
      var_4 _encstr_824B1D0B0B064AD4B301BB45F8A0EE43D085D7EFF1A77283986BB38F90D826();

      if(istrue(var_4.inlaststand)) {
        level.gulag.watch_for_near_objective_point[level.gulag.watch_for_near_objective_point.size] = var_4;
        continue;
      }

      if(!isDefined(var_4) || !isalive(var_4) || isDefined(var_4.gulag)) {
        continue;
      }
      var_4 playergulagdonesplash();
      var_4 _encstr_911512D50E8C16E8958D85B95D6EAC76BA1B1676();
    }
  }

  getentitylessscriptablearray("_encstr_ADE21D59126F7C319FB6736DDC4980BE071AF3C02AB7B898F4AD2961FFAB28", ["_encstr_85F307A6C78A7F78FE", var_0, "_encstr_91130DC9AC2C37DEB97D8DBD5DCD8E", var_1]);
}

_encstr_824B1D0B0B064AD4B301BB45F8A0EE43D085D7EFF1A77283986BB38F90D826() {
  var_0 = 0;
  var_1 = 0;

  if(istrue(level.br_pickups._id_12CB5) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasrespawntoken() && level.gulag._encstr_865E1B2B20C15FC37040899C68B85F2577D872E3588553BF88B88D8EFD > 0) {
    var_0 = 1;
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::removerespawntoken();
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(level.gulag._encstr_865E1B2B20C15FC37040899C68B85F2577D872E3588553BF88B88D8EFD);
  }

  if(istrue(level.br_pickups._encstr_99ED1952C78253E4F3C8AF624837C8A863A37797E363077FB9FB07) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_86D90E342CE676ABC6C29D3ABDD6B29B() && level.gulag._encstr_8B541864AD6BF12FFB1AA8D0E2D6C7E8EB257665113778432593 > 0) {
    var_1 = 1;
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_encstr_8205111BD158BFA34162A5C131A7055F73FB53();
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(level.gulag._encstr_8B541864AD6BF12FFB1AA8D0E2D6C7E8EB257665113778432593);
  } else if(istrue(level.br_pickups._encstr_99ED1952C78253E4F3C8AF624837C8A863A37797E363077FB9FB07) && checkgulagusecount() && level.gulag._encstr_8B541864AD6BF12FFB1AA8D0E2D6C7E8EB257665113778432593 > 0) {
    var_1 = 1;
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12627(level.gulag._encstr_8B541864AD6BF12FFB1AA8D0E2D6C7E8EB257665113778432593);
  }

  if(var_0 && var_1)
    scripts\mp\utility\lower_message::_id_1316E("_encstr_99B61C5ADDC1A2D775E1539A88D367DBF063D79F17986DD3AD7B7BF290A0", undefined, level.gulag._encstr_911C1444A26267EDD1C8BD23F93BB33030452B3B09D2);
  else if(var_0)
    scripts\mp\utility\lower_message::_id_1316E("_encstr_8161177EAB19928AE51B0B73671351FBF0B0F30703A041E2C8", undefined, level.gulag._encstr_911C1444A26267EDD1C8BD23F93BB33030452B3B09D2);
  else if(var_1)
    scripts\mp\utility\lower_message::_id_1316E("_encstr_870B1472F659FF4BC88902B04697B5AE07C350D39FBE", undefined, level.gulag._encstr_911C1444A26267EDD1C8BD23F93BB33030452B3B09D2);

  _encstr_A5E41D91E702F5403C4DD388B41DF0366A1377236BFA4C884063DBE15DD7C8();
}

_encstr_A5E41D91E702F5403C4DD388B41DF0366A1377236BFA4C884063DBE15DD7C8() {
  var_0 = getlootscriptablearrayinradius("_encstr_865216B27B6327F74871ABB25A03183310A8E1FB9020A238", undefined);
  var_1 = getlootscriptablearrayinradius("_encstr_97C613F92AD4C00883B71F3353FA44F964C54091D5", undefined);

  foreach(var_3 in var_0)
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21(var_3);

  foreach(var_3 in var_1)
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_11A21(var_3);

  level.br_pickups._encstr_ACDA0B86A591AC477B5B59E637 = 1;
}

c130airdrop_getteamaveragepos() {
  return level.gulag.watch_for_near_objective_point.size > 0;
}

_id_125E6() {
  if(!istrue(level.usegulag) || !istrue(level.gulag.shutdown))
    return 0;

  return scripts\engine\utility::array_contains(level.gulag.watch_for_near_objective_point, self);
}

set_relic_steelballs(var_0) {
  if(istrue(level.gulag.shutdown) && c130airdrop_getteamaveragepos()) {
    if(isDefined(var_0) && var_0 _id_125E6()) {
      level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_remove(level.gulag.watch_for_near_objective_point, var_0);
      return 1;
    } else
      level.gulag.watch_for_near_objective_point = scripts\engine\utility::array_removeundefined(level.gulag.watch_for_near_objective_point);
  }

  return 0;
}

onplayerdisconnect(var_0) {
  if(!istrue(level.usegulag)) {
    return;
  }
  set_relic_steelballs(var_0);
}

_id_12551(var_0) {
  if(!istrue(level.usegulag)) {
    return;
  }
  if(istrue(var_0)) {
    self.watch_for_driver_death = undefined;

    if(set_relic_steelballs(self))
      playergulagdonesplash();
  }
}

remove_engineer_class() {
  if(!isDefined(level.br_level) || !isDefined(level.br_level.br_circledelaytimes))
    return 0;

  var_0 = level.br_level.delay_start_infiltrate_objective;

  if(!isDefined(var_0))
    var_0 = 0;

  return level.br_level.br_circledelaytimes.size - 1 - getdvarint("_encstr_97A119E251A867121697BB97AFB66A82F8589F6129D8F37A6699BF", 3) - var_0;
}

_id_13249() {
  var_0 = run_hud_logic();
  var_1 = gettime() + var_0 * 1000;
  setomnvar("_encstr_8AE30F9D40CF7F2340AB17B919F730F2DE", var_1);
  thread _id_13346(var_0);
}

_id_13346(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = getdvarint("_encstr_8C4923EBB1E69F7E784F9C69EF9005AF8BAE2233F8370779D8019F7BEBC10DE736C3DA9AA1", 90);
  var_2 = var_0 - var_1;

  if(0 < var_2) {
    wait(var_2);
    setomnvar("_encstr_BA091CD3A071EFD349BBEF178763BA37C9490DDD9BA8BECA0877ABE7A19D", 1);
  }
}

run_hud_logic() {
  var_0 = 0;

  if(isDefined(level.br_level) && isDefined(level.br_level.default_class_chosen)) {
    var_1 = remove_engineer_class();

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = level.br_level.br_circledelaytimes[var_2];
      var_4 = level.br_level.br_circleclosetimes[var_2];
      var_0 = var_0 + var_3 + var_4;
    }
  }

  return int(var_0);
}

playergulagdonesplash() {
  if(istrue(self.gulagdone)) {
    return;
  }
  self.gulagdone = 1;
  _encstr_B8A728C0C63A387B6D487EF5ABCA8F876BCF74F98972F638A65361F7E239C883030BA57980AFF2073206::isbrsquadleader(self, "_encstr_B8BA0DD16B8B8708F94BF9C7635FD8", undefined, 2);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_83A5123B57D8B0ECFA3BAB1B85CEAF1BD87B6E56", self);
}

dojailbreak(var_0) {
  if(var_0.jailedplayers.size == 0) {
    var_0.shutdown = 1;
    return;
  }

  var_0.isjailbreak = 1;
  var_0.arenaplayers = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);
  jailbreaktimerwait(var_0);
  var_1 = getloadoutindex();

  foreach(var_3 in var_0.arenaplayers) {
    var_3 thread set_respawn_points(var_0);
    var_3 initplayerarena(var_0, 1, var_1);

    if(istrue(level.gulag.gestures_enabled) && !isbot(var_3))
      var_3 playergulaggesturesdisable();

    if(getdvarint("_encstr_BACE1CFF7B8AE93EC3F13199195F6D68A5D97D5BDFB620FD8B5B89EDA303", 1) > 0 && var_0.arenaplayers.size > 0)
      var_3 hudoutlinedisableforclients(var_0.arenaplayers);
  }

  playsoundatpos(var_0.center, "_encstr_86191A4BDD1C7DB6E0BE6EDCB0E81BA1FA66B43BD01DAFE68E169CE8");
  var_0.fightover = 0;

  if(!isoneteamleft(var_0)) {
    var_0.time = level.gulag.timelimit;
    updatematchtimerhud(var_0, var_0.time);
    waittillgulagmatchend(var_0, 0);
  } else {
    var_0.time = 8;
    updatematchtimerhud(var_0, var_0.time);
    wait(var_0.time);
  }

  foreach(var_3 in var_0.arenaplayers) {
    if(isDefined(var_3) && isDefined(var_3.gulagjailbreakhud))
      var_3.gulagjailbreakhud destroy();
  }

  handleendarena(var_0);
  var_0.shutdown = 1;
}

jailbreaktimerwait(var_0) {
  foreach(var_2 in var_0.arenaplayers) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 thread scripts\mp\hud_message::showsplash("_encstr_873514FA93707FBB88339F5FDD18449B980973325932");

    if(getdvarint("_encstr_BACE1CFF7B8AE93EC3F13199195F6D68A5D97D5BDFB620FD8B5B89EDA303", 1) > 0)
      var_2 hudoutlineenableforclients(var_0.arenaplayers, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246");
  }

  wait 3;

  foreach(var_2 in var_0.arenaplayers) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 playeraddjailbreaktimer();
  }

  gulagcountdowntimer(var_0, 0);

  foreach(var_2 in var_0.arenaplayers) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", 0);
    var_2 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);

    if(isDefined(var_2) && isDefined(var_2.gulagjailbreakhud))
      var_2.gulagjailbreakhud.label = &"_encstr_88DC16A983EFF51D417F0DB9C6F83F3C297F2929635D2D67";
  }
}

playeraddjailbreaktimer() {
  self.gulagjailbreakhud = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 2);
  self.gulagjailbreakhud scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, -150);
  self.gulagjailbreakhud.label = &"_encstr_836419CB13A676C93FB7C7FC2ECF69BAB89F515DA3A8AF79671CAC";
}

resetequipment(var_0) {
  if(!istrue(level.gulag._id_13672)) {
    return;
  }
  for(var_1 = 0; var_1 < var_0.weapons.size; var_1++) {
    var_2 = var_0.weapons[var_1];
    var_2 setscriptablepartstate(var_2.part, "_encstr_BE8B08E323FB2BCD6268");
  }
}

validateplayers(var_0) {
  return var_0.arenaplayers.size >= 2;
}

beginnewfight(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_96901133A59D43D1D7ED9D5939D795C24E1B97");
  level notify("_encstr_874C161AC0B13EFFB666352F8BF85785DBB80182980FB44B", var_0);
  var_0.fightover = 0;
  resetequipment(var_0);
  _id_12C6B(var_0);
  var_0.arenaplayers = popnextmatch(var_0);
  var_1 = 0;

  foreach(var_4, var_3 in var_0.arenaplayers) {
    if(isDefined(var_3))
      var_0.jailedplayers = scripts\engine\utility::array_remove(var_0.jailedplayers, var_3);

    if(!isDefined(var_3)) {
      var_1 = 1;
      continue;
    }

    if(var_3.gulag == 0 || var_3.jailed == 0 || var_3.gulagarena == 1) {
      scripts\mp\utility\script::laststand_dogtags("_encstr_96F8094BD1B7936568B2E6" + var_3.name + "_encstr_8C552204A5084BB9D90BC65A1904667BE4089DEAC6C29D404B10385CCE578D58D980F408" + var_3.gulag + "_encstr_A51A0E12C66F0EFAA9C1090567066180" + var_3.jailed + "_encstr_A1021261021CE2ECBAD8B0B3283995375801A710" + var_3.gulagarena);
      var_1 = 1;
      continue;
    }

    var_3.fighterindex = var_4;
  }

  foreach(var_6 in var_0.jailedplayers) {
    if(!isDefined(var_6)) {
      continue;
    }
    var_6.gulagposition--;
    var_6 setweaponammoclip("_encstr_86B108781A36271E4F70", 5);
  }

  if(var_1) {
    var_0.jailedplayers = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);
    var_0.arenaplayers = scripts\engine\utility::array_removeundefined(var_0.arenaplayers);

    if(!validateplayers(var_0)) {
      handleendarena(var_0, undefined, 1);
      return;
    }
  }

  var_8 = startbetting(var_0, var_0.arenaplayers);

  if(getdvarint("_encstr_AD161CDCC627FA8939D7CC36FA378356D83AC23ACAEBDEABD1B15AB995B9", 0))
    thread manageoutlines(var_0, var_0.arenaplayers, var_8);

  var_0.arenaspawncounter = 0;
  var_9 = getloadoutindex();

  foreach(var_6 in var_0.arenaplayers) {
    if(!isDefined(var_6)) {
      continue;
    }
    var_6 thread set_respawn_points(var_0, var_8);
    var_6 thread initplayerarena(var_0, 0, var_9);
  }

  thread watchlethaldelay(var_0);
  wait 2;

  if(!validateplayers(var_0)) {
    handleendarena(var_0, var_8, 1);
    return;
  }

  _id_13FC1(var_0);
  _id_13FC0(var_0);
  var_12 = gulagcountdowntimer(var_0, 1, var_8);

  if(!var_12) {
    return;
  }
  endbetting(var_0, var_8);

  foreach(var_6 in var_0.arenaplayers) {
    var_6 playergulagarenaready();
    var_6 thread _id_12692();
  }

  thread _id_13849(var_0);
  var_0.time = level.gulag.timelimit;
  updatematchtimerhud(var_0, var_0.time);
  waittillgulagmatchend(var_0, 1);
  handleendarena(var_0, var_8);

  if(!isfightready(var_0))
    _id_14009(var_0);
}

watchlethaldelay(var_0) {
  var_0 endon("_encstr_85CC0BA370D12803F7F8CB075E");
  var_0 endon("_encstr_8A240BB6581D6C0DA2B98C5691");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(level.gulag.lethaldelay <= 0) {
    return;
  }
  var_0.lethaldelaystarttime = gettime();
  var_0.lethaldelayendtime = var_0.lethaldelaystarttime + level.gulag.lethaldelay * 1000 + level.gulag.impairedkill * 1000 + 2000;

  while(gettime() < var_0.lethaldelayendtime)
    waitframe();

  var_0 notify("_encstr_8FBD11CAA135B34E789F4C55E1481027D5B8C2");
}

watchlethaldelayplayer(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(level.gulag.lethaldelay == 0) {
    return;
  }
  if(!isai(self)) {
    self notifyonplayercommand("_encstr_923215FB837DC22158DE763B933865FBD55F4F17692FFA", "_encstr_9B0D065699E485D9");
    self notifyonplayercommand("_encstr_923215FB837DC22158DE763B933865FBD55F4F17692FFA", "_encstr_8E5F0795E6AD7BAD2B");
  }

  scripts\mp\equipment::allow_equipment_slot("_encstr_BA7F0830B3A7859B60B0", 0);
  scripts\mp\equipment::allow_equipment_slot("_encstr_AC8F0AE74163F85AAA380AD8", 0);
  watchlethaldelayfeedbackplayer(var_0, self);
  scripts\mp\equipment::allow_equipment_slot("_encstr_BA7F0830B3A7859B60B0", 1);
  scripts\mp\equipment::allow_equipment_slot("_encstr_AC8F0AE74163F85AAA380AD8", 1);

  if(scripts\cp_mp\utility\game_utility::isrealismenabled())
    self playlocalsound("_encstr_B229132D8BA1C2F7DEE3824AE8202BFF1011B18C17");

  self setclientomnvar("_encstr_B2C01378778F8303F2A407967FCA2F4817BB1078DF", 2);

  if(!isai(self)) {
    self notifyonplayercommandremove("_encstr_923215FB837DC22158DE763B933865FBD55F4F17692FFA", "_encstr_9B0D065699E485D9");
    self notifyonplayercommandremove("_encstr_923215FB837DC22158DE763B933865FBD55F4F17692FFA", "_encstr_8E5F0795E6AD7BAD2B");
  }
}

watchlethaldelayfeedbackplayer(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8A240BB6581D6C0DA2B98C5691");
  var_0 endon("_encstr_8FBD11CAA135B34E789F4C55E1481027D5B8C2");

  for(;;) {
    self waittill("_encstr_923215FB837DC22158DE763B933865FBD55F4F17692FFA");
    var_2 = (var_0.lethaldelayendtime - gettime()) / 1000;
    var_2 = int(max(0, ceil(var_2)));
    var_1 scripts\mp\hud_message::showerrormessage("_encstr_96F11D31C826142BB328B9D9F119732CF756AFBB7C471DF12F6199B9F9218D", var_2);
  }
}

_id_13849(var_0) {
  var_0 endon("_encstr_8A240BB6581D6C0DA2B98C5691");
  playsoundatpos(var_0.center, "_encstr_86191A4BDD1C7DB6E0BE6EDCB0E81BA1FA66B43BD01DAFE68E169CE8");
  wait 1;
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_AC6B13504B12ABEF9F6F93AA4F7F1F865E8B38D3A1", 0, var_0.jailedplayers);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_B2E81010FF4409EFE9CD3E32A7C201F0A657", 0, var_0.arenaplayers);
  wait 2;

  foreach(var_2 in var_0.jailedplayers) {
    if(var_2.gulagposition <= 1) {
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B6160BEC039A9BB90FF368F8E3", var_2, 0);
      continue;
    }

    if(var_2.gulagposition == 2)
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_BD570C32E89966A7DE1549552083", var_2, 0);
  }
}

_id_12692() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setclientomnvar("_encstr_BAE912ED0CA18F0122D720908F56B9B7BBB7E3F5", 0);
  wait 3;
  self setclientomnvar("_encstr_BAE912ED0CA18F0122D720908F56B9B7BBB7E3F5", -1);
}

handleonekillwin(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2) && isPlayer(var_2) && var_1 != var_2 && isalive(var_2) && scripts\engine\utility::array_contains(var_0.arenaplayers, var_2)) {
    thread gulagvictory(var_0, var_2, 0, 0, "_encstr_A6EA07CF498568A5DB");
    payoutbet(var_3, var_2, 1);
  }

  payoutbet(var_3, var_1, 0);
}

manageoutlines(var_0, var_1, var_2) {
  manageoutlineactive(var_0, var_1, var_2);

  if(istrue(level.gulag.onekillwin)) {
    return;
  }
  manageoutlinecleanup(var_0, var_1);
}

manageoutlineswatchplayersaddedtojail(var_0) {
  var_0 endon("_encstr_85CC0BA370D12803F7F8CB075E");

  for(;;) {
    var_0 waittill("_encstr_B40415E036B02FACC97D58C88CCA91D7D1F6EB4DC2B436");
    updateoutlines(var_0);
  }
}

manageoutlineactive(var_0, var_1, var_2) {
  var_0 endon("_encstr_85CC0BA370D12803F7F8CB075E");
  thread manageoutlineswatchplayersaddedtojail(var_0);

  for(;;) {
    if(var_0.jailedplayers.size) {
      var_3 = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);

      foreach(var_5 in var_1) {
        if(!isDefined(var_5)) {
          continue;
        }
        var_5 hudoutlineenableforclients(var_3, "_encstr_AF5716DF75E398434BBA0E10225B0D30BBF03797680CE09D");
      }
    }

    if(isDefined(var_2)) {
      foreach(var_8 in var_2.bets) {
        if(!isDefined(var_8.owner)) {
          continue;
        }
        var_9 = scripts\engine\utility::ter_op(var_2.bettingopen, var_8.playerfocus, var_8.playerbeton);

        if(var_9 != -1) {
          var_10 = var_2.fighters[var_9];

          if(isDefined(var_10))
            var_10 hudoutlineenableforclient(var_8.owner, "_encstr_A90116BFB72351201E2F964855FC8897FB6B6727335AAD40");
        }
      }
    }

    var_0 waittill("_encstr_953B10E3B08D3109A95F9F58F380D838110B");
  }
}

manageoutlinecleanup(var_0, var_1) {
  var_2 = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);

  if(!var_2.size) {
    return;
  }
  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    var_4 hudoutlinedisableforclients(var_2);
  }
}

updateoutlines(var_0) {
  var_0 notify("_encstr_953B10E3B08D3109A95F9F58F380D838110B");
}

playergulagarenaready() {
  _id_126B0(1);
  self setclientomnvar("_encstr_BA2914D5B4D726E4D7B49B66A58DFA6E3A2C93A35932", 1);
  self setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", 0);
  self setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 1);

  if(istrue(level.gulag.gestures_enabled) && !isbot(self))
    playergulaggesturesdisable();
}

gulagcountdowntimer(var_0, var_1, var_2) {
  var_3 = level.gulag.impairedkill;

  while(var_3 > 0) {
    foreach(var_5 in var_0.arenaplayers) {
      var_5 setclientomnvar("_encstr_82231507E01F6D82E3468271C14A010815DFEFFDB550B7", 0);
      var_5 setclientomnvar("_encstr_96A91957B4AF6B853A36A1FACD8EB0E4A3F56CBDBAB9E891ED77E6", var_3);
    }

    var_3 = var_3 - 1;
    wait 1;

    if(istrue(var_1) && !validateplayers(var_0)) {
      handleendarena(var_0, var_2, 1);
      return 0;
    }
  }

  return 1;
}

set_relic_vampire(var_0, var_1, var_2) {
  var_0 endon("_encstr_8A240BB6581D6C0DA2B98C5691");

  while(var_1 > 0) {
    if(level.gameended) {
      return;
    }
    var_3 = var_1;

    if(!istrue(var_0.overtime))
      var_3 = var_3 - var_2;

    if(var_3 <= 5) {
      var_4 = scripts\mp\gamelogic::relic_bang_and_boom_dropfunc(var_3);
      lower_target_when_close(var_0, var_4);
    }

    if(var_1 > 1)
      var_1 = var_1 - 1;

    wait 1;
  }
}

lower_target_when_close(var_0, var_1) {
  foreach(var_3 in var_0.jailedplayers) {
    if(isDefined(var_3))
      var_3 playlocalsound(var_1);
  }

  foreach(var_3 in var_0.arenaplayers) {
    if(isDefined(var_3))
      var_3 playlocalsound(var_1);
  }
}

respawn_scriptible_carriable_wait() {
  return getdvarint("_encstr_913513DC6C93AF9827D7CCC67DDEB3AC9CA32DB595", 15.0);
}

waittillgulagmatchend(var_0, var_1) {
  var_2 = respawn_scriptible_carriable_wait();
  var_0.time = var_0.time + var_2;
  thread set_relic_vampire(var_0, var_0.time, var_2);

  for(;;) {
    if(!isanyonealive(var_0) || isoneteamleft(var_0)) {
      break;
    }

    var_0.time = var_0.time - level.framedurationseconds;

    if(istrue(level.gulag.arenaflag) && !istrue(var_0.overtime) && var_0.time <= var_2) {
      var_0.overtime = 1;
      var_0.managevehiclehealthui.arenaflag calloutmarkerping_watchwhenobjectivedeleted(1);
      var_0.managevehiclehealthui.arenaflag calloutmarkerping_watchwhenobjectivestartsprogress(var_0, 1);
      var_0.managevehiclehealthui.arenaflag.flagmodel playsoundonmovingent("_encstr_841B0DCC36B0D9FAB93885BB372B46");
    }

    if(istrue(var_0.overtime)) {
      var_3 = clamp(var_0.time / var_2, 0.0, 1.0);
      _id_13194(var_0, var_3);
    }

    if(var_0.time <= 0) {
      _id_143EF(var_0);

      if(istrue(var_1)) {
        foreach(var_5 in var_0.arenaplayers) {
          var_5 thread set_respawn_loc_delayed(var_0);
          var_6 = scripts\mp\music_and_dialog::reset_attack_next_available_time("_encstr_8E250E989CBE3BEA361676FAB1BDB959");
          var_5 setplayermusicstate(var_6);
          var_5 playsoundtoplayer("_encstr_8A95169FBDA8681A493BFEE8035B0930B0C749B5DDC2A28E", var_5);
          var_5 clearclienttriggeraudiozone(2);
        }
      }

      break;
    }

    waitframe();
  }

  var_0 notify("_encstr_8A240BB6581D6C0DA2B98C5691");
}

_id_143EF(var_0) {
  while(isDefined(var_0.managevehiclehealthui.arenaflag.claimteam) && var_0.managevehiclehealthui.arenaflag.claimteam != "_encstr_8BBA05185F8B99" && !istrue(var_0.managevehiclehealthui.arenaflag.stalemate))
    waitframe();
}

isanyonealive(var_0) {
  foreach(var_2 in var_0.arenaplayers) {
    if(isalive(var_2))
      return 1;
  }

  return 0;
}

_encstr_83DF0DD2E66EC5572CC8EE9638CA46(var_0) {
  foreach(var_2 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"]) {
    if(isDefined(var_2) && isalive(var_2))
      return 0;
  }

  return 1;
}

isoneteamleft(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0.arenaplayers) {
    if(isalive(var_3)) {
      if(!isDefined(var_1)) {
        var_1 = var_3.team;
        continue;
      }

      if(var_1 != var_3.team)
        return 0;
    }
  }

  return 1;
}

handleendarena(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 notify("_encstr_8FBD11CAA135B34E789F4C55E1481027D5B8C2");
  var_0 notify("_encstr_85CC0BA370D12803F7F8CB075E");
  var_0.fightover = 1;

  if(!isDefined(var_4))
    var_4 = "_encstr_A6EA07CF498568A5DB";

  endbetting(var_0, var_1);
  updatematchtimerhud(var_0, 0);
  var_6 = undefined;

  foreach(var_8 in var_0.arenaplayers) {
    if(!isDefined(var_8)) {
      continue;
    }
    if(isalive(var_8)) {
      var_6 = var_8;

      if(istrue(var_2))
        var_6 playergulagarenaready();

      if(isDefined(var_5) && var_8.team == var_5.team) {
        thread gulagvictory(var_0, var_8, 0, 0, var_4, 0, var_5, var_3);
        continue;
      }

      thread gulagvictory(var_0, var_8, 0, 0, "_encstr_A6EA07CF498568A5DB");
    }
  }

  if(istrue(level.gulag.arenaflag) && istrue(var_0.overtime))
    var_0.managevehiclehealthui.arenaflag calloutmarkerping_watchwhenobjectivedeleted(0);

  payoutremainingbets(var_6, var_1);
  wait 2.0;

  if(istrue(level.gulag.arenaflag) && istrue(var_0.overtime)) {
    var_0.overtime = 0;
    var_0.managevehiclehealthui.arenaflag calloutmarkerping_watchwhenobjectivestartsprogress(var_0, 0);
  }

  handlesoloexclusionils(var_0);
  wait 1.0;
}

_id_12642(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91ED0AECABC60B3BEB95CD23");

  if(!isDefined(self.arena)) {
    return;
  }
  var_2 = self.arena;

  if(istrue(self._id_14439)) {
    self notify("_encstr_95AB121C5DB1D8EB7B57E87DED33EBB3AB6385B3");

    if(!isalive(self)) {
      thread playergulagautowin("_encstr_BE91196BE0DF972FE821FDFC41D9F36B601990A388A7B7EB18B5B1", var_0);
      return;
    } else if(istrue(self.delay_enter_combat_after_investigating_grenade)) {
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self, "_encstr_BD911910B96838FF567F2B428D3077B3C1059F9D210BC76FF39057");
      level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_14006();
    }
  } else if(istrue(self.gulagarena)) {
    if(!var_2.fightover) {
      var_2 notify("_encstr_8A240BB6581D6C0DA2B98C5691");
      var_2 notify("_encstr_96901133A59D43D1D7ED9D5939D795C24E1B97");
      thread handleendarena(var_2, undefined, 1, 1, var_1, var_0);
    }

    return;
  } else {
    var_2.jailedplayers = scripts\engine\utility::array_remove(var_2.jailedplayers, self);
    updatematchqueuepositions(var_2);

    if(istrue(self.gulag) && !istrue(self.jailed))
      self waittill("_encstr_95DC0CE95B640BBCE1D7C9EBFB7B");
  }

  thread gulagvictory(var_2, self, 1, 0, var_1, 0, var_0, 1);
}

getnextjailspawn(var_0) {
  if(isDefined(var_0.jailspawncounter)) {
    var_0.jailspawncounter++;
    var_0.jailspawncounter = var_0.jailspawncounter % var_0.jailspawns.size;
  } else
    var_0.jailspawncounter = 0;

  var_1 = var_0.jailspawns[var_0.jailspawncounter];
  return var_1;
}

_id_13255(var_0, var_1) {
  if(isDefined(var_1.target)) {
    var_2 = scripts\engine\utility::getStruct(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_2))
      var_1.chair = var_2;
  }
}

outlinewatchplayerprox(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8F5C086405E70FBA4B4A");
  self.outlinedplayers = [];

  switch (var_0) {
    case 0:
    default:
      var_1 = "_encstr_AAA514372003FC02452D71B705218BB00E48A3B78099";
      break;
    case 1:
      var_1 = "_encstr_966414C71D2B13C445B879C250917BFBA68C4245BD30";
      break;
    case 2:
      var_1 = "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD";
      break;
    case 3:
      var_1 = "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8";
      break;
    case 4:
      var_1 = "_encstr_96AE15674513800375C947242F6863285787EB2916E22F";
      break;
  }

  for(;;) {
    var_2 = scripts\common\utility::playersinsphere(self.origin, 2000);
    var_3 = scripts\engine\utility::array_difference(level.players, var_2);

    foreach(var_5 in var_2) {
      var_6 = distancesquared(self.origin, var_5.origin);
      var_7 = var_5 getentitynumber();

      if(!isDefined(self.outlinedplayers[var_7]))
        self.outlinedplayers[var_7] = scripts\mp\utility\outline::outlineenableforplayer(self, var_5, var_1, "_encstr_AC760D7A6AE6A9501F43EF73238A0C");
    }

    foreach(var_5 in var_3) {
      var_7 = var_5 getentitynumber();

      if(isDefined(self.outlinedplayers[var_7])) {
        scripts\mp\utility\outline::outlinedisable(self.outlinedplayers[var_7], self);
        self.outlinedplayers[var_7] = undefined;
      }
    }

    waitframe();
  }
}

gulagstreamlocationstart(var_0) {
  if((isbot(self) || self calloutmarkerping_getEnt()) && !istrue(self._id_119D7))
    return 0;

  self calloutmarkerping_getcreatedtime(10000.0);
  self setadditionalstreampos(var_0, 1);
  return !self isadditionalstreamposready();
}

gulagstreamlocationwait() {
  if(!istrue(self._id_119D7)) {
    self endon("_encstr_A7F71C3BBAD885EC6A8E9C56585B31F6B116A3D2DB371ADED6E0D8593ACA");
    thread gulagstreamlocationwaittimeout(level.gulag._id_1391B);

    while(!self isadditionalstreamposready())
      waitframe();

    self notify("_encstr_A7F71C3BBAD885EC6A8E9C56585B31F6B116A3D2DB371ADED6E0D8593ACA");
  } else
    wait(level.gulag._id_1391B);
}

gulagstreamlocationwaittimeout(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_A7F71C3BBAD885EC6A8E9C56585B31F6B116A3D2DB371ADED6E0D8593ACA");
  wait(var_0);
  self notify("_encstr_A7F71C3BBAD885EC6A8E9C56585B31F6B116A3D2DB371ADED6E0D8593ACA");
}

gulagstreamlocationend() {
  self clearadditionalstreampos();
  self notify("_encstr_A7F71C3BBAD885EC6A8E9C56585B31F6B116A3D2DB371ADED6E0D8593ACA");
}

set_scriptable_states() {
  self calloutmarkerping_getcreatedtime(0.0);
}

addloadingplayer(var_0, var_1) {
  var_1.entergulagwait = 1;
  var_0.loadingplayers[var_0.loadingplayers.size] = var_1;
  thread addloadingplayerdisconnectwatch(var_0, var_1);
}

addloadingplayerdisconnectwatch(var_0, var_1) {
  var_1 endon("_encstr_8B5F149C59B67BCECA62DE8519D2CDEC41D8B0BC59C9");
  var_1 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  thread removeloadingplayer(var_0, var_1);
}

removeloadingplayer(var_0, var_1) {
  var_1 notify("_encstr_8B5F149C59B67BCECA62DE8519D2CDEC41D8B0BC59C9");

  if(isDefined(var_1))
    var_0.loadingplayers = scripts\engine\utility::array_remove(var_0.loadingplayers, var_1);
  else
    var_0.loadingplayers = scripts\engine\utility::array_removeundefined(var_0.loadingplayers);

  if(var_0.loadingplayers.size == 0)
    var_0 notify("_encstr_9A7B148DDE0B1996DC9D821B0BF2B2399BA85B381DF2");
}

updatelootleadercirclesize(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_1.loadingplayers, var_0);
}

entergulag(var_0) {
  var_0 notify("_encstr_BED30C755D830BF3E72FABC01FF7");
  var_0.entergulagwait = 0;
  scripts\mp\deathicons::spawn_carriables_from_prefabs_all(var_0);
}

entergulagwait(var_0) {
  if(var_0.entergulagwait)
    var_0 waittill("_encstr_BED30C755D830BF3E72FABC01FF7");
}

playergetnextarena() {
  if(!istrue(level.gulag.multiarena))
    return level.gulag.arenas[0];

  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level.gulag.arenas) {
    foreach(var_6 in var_4.matches) {
      if(var_6.size == 1 && isDefined(var_6[0]) && var_6[0].team != self.team && (!isDefined(var_1) || var_6[0].vehicle_compass_friendlystatuschangedcallback < var_2)) {
        var_1 = var_4;
        var_2 = var_6[0].vehicle_compass_friendlystatuschangedcallback;
      }
    }
  }

  if(isDefined(var_1))
    return var_1;

  var_9 = [];

  for(var_10 = 0; var_10 < level.gulag.arenas.size; var_10++) {
    var_4 = level.gulag.arenas[var_10];

    if(var_4.matches.size > 0 && var_4.matches.size < level.gulag.maxqueue)
      var_9[var_9.size] = var_4;
  }

  if(var_9.size > 0) {
    foreach(var_4 in var_9) {
      foreach(var_6 in var_4.matches) {
        foreach(var_14 in var_6) {
          if(isDefined(var_14) && var_14.team == self.team)
            return var_4;
        }
      }
    }

    var_4 = var_9[randomint(var_9.size)];
    return var_4;
  }

  var_1 = undefined;
  var_18 = undefined;

  for(var_10 = 0; var_10 < level.gulag.arenas.size; var_10++) {
    var_4 = level.gulag.arenas[var_10];

    if(var_4.matches.size == 0)
      return var_4;
    else if(!isDefined(var_18) || var_4.matches.size < var_18) {
      var_1 = var_4;
      var_18 = var_4.matches.size;
    }
  }

  return var_1;
}

updatelootleadermarks(var_0, var_1) {
  if(!ismatchpending(var_0))
    return 0;

  var_2 = var_1.gulagposition - 1;

  if(var_2 >= 0 && var_0.matches[var_2].size > 1)
    return 1;

  return 0;
}

_id_13165(var_0) {
  foreach(var_2 in var_0.jailedplayers) {
    if(!updatelootleadermarks(var_0, var_2) && isDefined(var_2.vehicle_compass_getleveldata) && !isDefined(var_2.vehicle_compass_hide)) {
      var_2 setclientomnvar("_encstr_8D571B1BFC3812436F39E50967FFD81A37DB174037CBF8394EB1277D32", var_2.vehicle_compass_getleveldata);
      var_2.vehicle_compass_hide = 1;
    }
  }
}

_id_12527(var_0) {
  self.vehicle_compass_getleveldata = undefined;
  self.vehicle_compass_hide = undefined;
  self setclientomnvar("_encstr_8D571B1BFC3812436F39E50967FFD81A37DB174037CBF8394EB1277D32", 0);
}

_id_125F4(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8B7F10A5E6B4A3141B0BE5AC39144E59B958");
  self endon("_encstr_91ED0AECABC60B3BEB95CD23");
  var_1 = getdvarint("_encstr_8A3116FE2B83A695CAA9507081E44BB813E40B79854FABF1", 95);

  if(var_1 <= 0) {
    return;
  }
  self.vehicle_compass_getleveldata = gettime() + var_1 * 1000;
  wait(var_1);

  if(updatelootleadermarks(var_0, self)) {
    var_2 = self.gulagposition * (level.gulag.timelimit + respawn_scriptible_carriable_wait() + level.gulag.impairedkill + 2 + 2.0 + 1.0 + 1);
    var_3 = gettime() + var_2 * 1000;

    while(var_3 > gettime() && updatelootleadermarks(var_0, self))
      waitframe();
  }

  while(unset_relic_martyrdom())
    waitframe();

  thread gulagvictory(var_0, self, 1, 0, "_encstr_995408F398012F656821");
}

_encstr_911512D50E8C16E8958D85B95D6EAC76BA1B1676() {
  var_0 = self;

  if(!isDefined(var_0.gulaguses))
    self.gulaguses = 0;

  var_1 = var_0 _id_12517();
  var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_925B180318D9F6AFE8A56B75B45343BE17E03BEB084B2CDB8180(var_1);
}

initplayerjail(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91ED0AECABC60B3BEB95CD23");
  self.vehicle_compass_friendlystatuschangedcallback = gettime();
  self.gulagloser = 0;
  self.nosuspensemusic = 1;
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroyawardlaunchonly(self, scripts\engine\utility::ter_op(istrue(var_0), "_encstr_8B1608EC43B8D647A113", "_encstr_8E75065022EE9391"));
  _id_1263C();
  var_1 = playergetnextarena();
  self.arena = var_1;

  if(!scripts\engine\utility::array_contains(var_1.jailedplayers, self)) {
    var_1 notify("_encstr_B40415E036B02FACC97D58C88CCA91D7D1F6EB4DC2B436", self);
    var_1.jailedplayers[var_1.jailedplayers.size] = self;
  }

  playergulaghud(var_1);
  thread playerwatchdisconnect(var_1);
  updatematchqueuepositions(var_1);
  addloadingplayer(var_1, self);
  set_relic_steelballs(self);

  if(!isDefined(self.gulaguses))
    self.gulaguses = 0;

  self.gulaguses++;
  _encstr_911512D50E8C16E8958D85B95D6EAC76BA1B1676();
  setplayervargulag(1);
  setplayervargulagarena(0);
  _id_131A2(1);
  _id_1319F(var_1);
  scripts\mp\outofbounds::enableoobimmunity(self);

  if(isDefined(level.getinfilplayers))
    [[level.getinfilplayers]]();

  var_2 = getnextjailspawn(var_1);
  var_3 = getgroundposition(var_2.origin, 12);
  var_4 = (0, 0, 0);

  if(isDefined(var_2.angles))
    var_4 = var_2.angles;

  var_5 = gulagstreamlocationstart(var_3);
  self.set_relic_steelballs_perks = 1;
  self._id_1391A = spawnStruct();
  self._id_1391A.origin = var_3;
  self._id_1391A.angles = var_4;

  if(istrue(var_0))
    entergulagwait(self);
  else
    entergulag(self);

  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_1206C();
  _encstr_81032C6ED8E4B41CA3CDCBAD0E979DB05B561D971C95375E98C9BE2C3647FA6BDEC8B2AF56E68D0B38955C76B9C6::obj_hangar_bombs();
  _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("_encstr_9B220634456A5747");
  var_6 = gettime();

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    self notify("_encstr_99B70E48E130603FF4E3924A89C0A35D");

  if(level.gulag.betting) {
    var_7 = level.gulag.juggheli_spawner_jammer5_2;

    if(isDefined(self.plundercountondeath))
      var_7 = int(max(var_7, int(self.plundercountondeath / 2)));

    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(var_7);
  }

  _id_12617();

  if(var_5) {
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::spawnintermission(var_3 + (0, 0, 100), self.angles);
    scripts\mp\spectating::setdisabled();
    gulagstreamlocationstart(var_3);
  }

  if(var_5)
    gulagstreamlocationwait();

  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::tutorial_showtext("_encstr_8D88182BD14E87A83A8F9B4851792F8B7EDFADF8B74180D7707D"))
    _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_8D88182BD14E87A83A8F9B4851792F8B7EDFADF8B74180D7707D");

  scripts\mp\class::loadout_emptycacheofloadout("_encstr_AAAC09D09972B9C83F2B7F");
  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.gulag.vehicle_compass_deregisterinstance;
  self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  self.forcespawnangles = var_4;
  self.forcespawnorigin = var_3;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  self setclientomnvar("_encstr_AAFD09E3F80F777F282FFF", 1);
  self._id_1391A = undefined;
  self.set_relic_steelballs_perks = 0;
  _id_12C7A();

  if(var_5)
    gulagstreamlocationend();

  _id_12694();
  _id_126EA(var_6);

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    self clearsoundsubmix("_encstr_AC6F16A09BE04FB9335FB4B574A7C1875B03C008A3CC6B30", 2);
  else
    self clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 2);

  self setclientomnvar("_encstr_BA2914D5B4D726E4D7B49B66A58DFA6E3A2C93A35932", 1);
  var_8 = var_1.fightover && _id_125EE(var_1);
  var_9 = undefined;

  if(level.gulag.getaccessorylogicbyindex)
    var_9 = 0.5;

  if(!var_8)
    gulagfadefromblack(var_9);

  gulagloadingtextclear();

  if(!var_8) {
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A3BD0CC1735C3884C98FA9938782", self, 0);
    thread _id_1251A(var_1, var_2);
  }

  var_10 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(self.team, self.squadindex);

  foreach(var_12 in var_10) {
    if(!isDefined(var_12) || !isalive(var_12)) {
      continue;
    }
    if(var_12 != self) {
      var_12 thread scripts\mp\hud_message::showsplash("_encstr_AFC1154B2510CACDD0817F491BA0E1A2D19B9BAF97A3E2", undefined, self);
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_BE2815CF43C8F62F183392DA78696FEB28AF47459958BF", var_12);
    }
  }

  if(!istrue(self.jailed)) {
    _id_131AA(1);
    scripts\mp\utility\perk::blockperkfunction("_encstr_95571436E007F94BC6620878491A17F1339D30A44DF3");
  }

  removeloadingplayer(var_1, self);
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer(1);

  if(istrue(level.gulag.gestures_enabled) && !isbot(self))
    thread playergulaggestures();

  _id_126B3(0);

  if(istrue(level.gulag.arenaflag) && istrue(var_1.overtime))
    var_1.managevehiclehealthui.arenaflag thread calloutmarkerpingvo_canplaywithspamavoidance(1, self);

  thread _id_125F4(var_1);
  thread _id_125F5(var_1);
  self notify("_encstr_95DC0CE95B640BBCE1D7C9EBFB7B");
}

_id_125F5(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8B7F10A5E6B4A3141B0BE5AC39144E59B958");
  self endon("_encstr_91ED0AECABC60B3BEB95CD23");
  wait 5;

  if(ismatchpending(var_0)) {
    return;
  }
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_84360F0F7BB0B1BA681F331B172482E1D8", self, 0);
}

_id_126B3(var_0) {
  if(var_0)
    self enableoffhandthrowback();
  else
    self disableoffhandthrowback();
}

playergulaggestures() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_958F149D5DD8B0D97DD9CA6EA3BAC995CDFADC1DF607");
  self enableoffhandweapons();
  self allowfire(0);
  self allowads(0);
  self notifyonplayercommand("_encstr_BEDB0FBF96975A555B98978378B606224F", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommand("_encstr_ABDB0F5A5190DF1FD0B92D12A38962372E", "_encstr_97120D65B983599519EB1D86C9B7EE");
  var_0 = 0;

  for(;;) {
    var_1 = scripts\engine\utility::_id_143AD("_encstr_BEDB0FBF96975A555B98978378B606224F", "_encstr_ABDB0F5A5190DF1FD0B92D12A38962372E");

    if(self isgestureplaying() || self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing()) {
      continue;
    }
    if(getdvarint("_encstr_BD4618B9364E7D4CE4F5CC1B7DD995B9475D39ACCDAFD195CDD1", 0) > 0) {
      if(var_0 >= level.gulag.gestures[var_1].size)
        var_0 = 0;

      var_2 = level.gulag.gesturesounds[var_1][var_0];
      var_3 = level.gulag.gestures[var_1][var_0];
      var_0++;
    } else {
      var_0 = randomint(level.gulag.gestures[var_1].size);
      var_2 = level.gulag.gesturesounds[var_1][var_0];
      var_3 = level.gulag.gestures[var_1][var_0];
    }

    if(isDefined(var_2) && var_2 != "_encstr_B40101")
      self playSound(var_2);

    var_4 = getcompleteweaponname(var_3);

    if(isDefined(var_4) && !nullweapon(var_4))
      scripts\cp_mp\gestures::watchradialgesture(var_4);
  }
}

playergulaggesturesdisable() {
  self notify("_encstr_958F149D5DD8B0D97DD9CA6EA3BAC995CDFADC1DF607");
  self notifyonplayercommandremove("_encstr_BEDB0FBF96975A555B98978378B606224F", "_encstr_A9E60828803C73F11780");
  self notifyonplayercommandremove("_encstr_ABDB0F5A5190DF1FD0B92D12A38962372E", "_encstr_97120D65B983599519EB1D86C9B7EE");
  self allowfire(1);
  self allowads(1);
}

fadeoutin(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0))
    var_0 = 1.0;

  gulagfadetoblack();
  wait(var_0);
  gulagfadefromblack();
}

gulagfadetoblack(var_0) {
  _id_12522();

  if(istrue(var_0))
    set_relic_noluck();
}

gulagfadefromblack(var_0) {
  thread _id_12523(var_0);
  set_relic_noks();
}

set_relic_noluck() {
  var_0 = _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::rotatetocurrentangles(self);

  foreach(var_2 in var_0)
  var_2 _id_12522();
}

set_relic_noks() {
  var_0 = _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::rotatetocurrentangles(self);

  foreach(var_2 in var_0) {
    if(getdvarint("_encstr_8B8518AB1815CFE24A2689505867F1C084530ECB1A6728D1086F", 0) == 1)
      logstring("_encstr_99022B51854BD9947B83FB8F53426D403E1A780826A4D05EB257D183EF3B2710BF7263C4D720F0074B97CD01DE");

    var_2 thread _id_12523();
  }
}

patch_self_check(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(var_0))
    var_0 = 1.0;

  set_relic_noluck();
  wait(var_0);
  set_relic_noks();
}

set_relic_punchbullets() {
  if(_id_125EB())
    return 1;

  return 0;
}

gulagloadingtext() {
  var_0 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
  var_0 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, -100);
  var_0.label = &"_encstr_9BF813A682CB9049F53A55262874AF514A146515C4";
  self.gulagloadingtext = var_0;
}

gulagloadingtextclear() {
  if(isDefined(self.gulagloadingtext))
    self.gulagloadingtext destroy();
}

_id_126C3(var_0, var_1) {
  self cancelmantle();
  self setOrigin(var_0, 1);
  self setplayerangles(var_1);
}

initplayerarena(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8B7F10A5E6B4A3141B0BE5AC39144E59B958");
  _id_1251F();
  _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer();
  self allowprone(0);
  self allowcrouch(0);
  _id_126B3(1);
  _id_126B0(0);
  playertakeawayrock(var_0);
  _id_12527(var_0);
  scripts\mp\equipment::allow_equipment_slot("_encstr_BA7F0830B3A7859B60B0", 0);
  scripts\mp\equipment::allow_equipment_slot("_encstr_AC8F0AE74163F85AAA380AD8", 0);
  thread _id_125CC(var_0);

  if(istrue(var_1)) {
    _id_131AA(0);
    setplayervargulagarena(1);
    playergivearenaloadout(var_0, var_2);

    if(level.gulag.lethaldelay > 0)
      thread watchlethaldelayplayer(var_0);

    return;
  }

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_879112B3ABD8859DBE9B0E2CEEE67DE4BA8D566E", self, 0);
  var_3 = set_relic_punchbullets();

  if(!var_3)
    thread fadeoutin();

  thread patch_self_check();
  wait 1;
  playergivearenaloadout(var_0, var_2);
  thread _id_126C8(3);

  if(getdvarint("_encstr_99FB1D6E36C9D7139C7DEC569CD2CCF2AFCEAB1B163BAF8DDE2C23F6D5E8CD", 0) == 1) {
    level.gulag.lethaldelay = 0;
    thread _id_1428F(var_0);
  }

  if(level.gulag.lethaldelay > 0)
    thread watchlethaldelayplayer(var_0);

  var_4 = getnextarenaspawn(var_0);
  var_5 = getgroundposition(var_4.origin, 1);
  var_6 = var_4.angles;

  if(!isDefined(var_4.angles))
    var_6 = (0, 0, 0);

  _id_126C3(var_5, var_6);
  _id_131AA(0);
  setplayervargulagarena(1);
  self.health = self.maxhealth;
  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::scriptablescurid(level.gulag._id_11F2D);

  if(getdvarint("_encstr_BACE1CFF7B8AE93EC3F13199195F6D68A5D97D5BDFB620FD8B5B89EDA303", 1) > 0)
    self hudoutlineenableforclients(var_0.arenaplayers, "_encstr_B89614B7ABE88DD2DC59AF73F623AC833AA1BE27B246");

  if(var_3)
    gulagfadefromblack();

  wait 1;
  self allowprone(1);
  self allowcrouch(1);
  wait(level.gulag.impairedkill - 1);
  wait 1;

  if(getdvarint("_encstr_BACE1CFF7B8AE93EC3F13199195F6D68A5D97D5BDFB620FD8B5B89EDA303", 1) > 0 && var_0.arenaplayers.size > 0)
    self hudoutlinedisableforclients(var_0.arenaplayers);
}

_id_126B0(var_0) {
  if(var_0) {
    self allowmelee(1);
    self allowmovement(1);
    self enableusability();
    self enableoffhandweapons();
    self allowads(1);
    self allowfire(1);
  } else {
    self allowmelee(0);
    self allowmovement(0);
    self disableusability();
    self disableoffhandweapons();
    self allowads(0);
    self allowfire(0);
  }
}

getnextarenaspawn(var_0) {
  if(!isDefined(var_0.arenaspawncounter))
    var_0.arenaspawncounter = 0;

  var_1 = undefined;

  if(_id_14069(var_0))
    var_1 = var_0.get_wave_spawn_total[var_0.arenaspawncounter];
  else
    var_1 = var_0.fightspawns[var_0.arenaspawncounter];

  var_0.arenaspawncounter++;
  var_0.arenaspawncounter = var_0.arenaspawncounter % var_0.fightspawns.size;
  return var_1;
}

_id_126C8(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.plotarmor = 1;
  scripts\engine\utility::_id_143C0(var_0, "_encstr_AD75063D571AE108", "_encstr_AD1C0DE95B640BBC318FC7C9B74B70");
  self.plotarmor = undefined;
}

gulagvictory(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 notify("_encstr_91ED0AECABC60B3BEB95CD23");

  if(!isDefined(var_5))
    var_5 = 0;

  var_1 thread _id_1251F();
  var_1 _id_12527();
  var_1 thread _id_126C8(5);
  var_1.gulagloser = 0;

  if(var_0.jailedplayers.size > 0 && getdvarint("_encstr_AD161CDCC627FA8939D7CC36FA378356D83AC23ACAEBDEABD1B15AB995B9", 0))
    var_1 hudoutlinedisableforclients(var_0.jailedplayers);

  var_0.arenaplayers = scripts\engine\utility::array_removeundefined(var_0.arenaplayers);

  if(var_0.arenaplayers.size > 0 && getdvarint("_encstr_BACE1CFF7B8AE93EC3F13199195F6D68A5D97D5BDFB620FD8B5B89EDA303", 1) > 0)
    var_1 hudoutlinedisableforclients(var_0.arenaplayers);

  var_0.arenaplayers = scripts\engine\utility::array_remove(var_0.arenaplayers, var_1);
  var_8 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_1.team, var_1.squadindex);

  foreach(var_10 in var_8) {
    if(!isDefined(var_10) || !isalive(var_10)) {
      continue;
    }
    if(var_10 != var_1) {
      var_10 thread scripts\mp\hud_message::showsplash("_encstr_9364163995FF725D41F394BFBC40D9FA48C8E433F9C04D14", undefined, var_1);
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_979F13E79358594280C1B79FCBB1EA84C83E1BEC68", var_10);
    }
  }

  var_12 = "_encstr_B40101";

  if(isDefined(var_4))
    var_12 = var_4;

  if(!isDefined(var_1._id_145BF))
    var_1 _id_126F3(1);

  if(!istrue(var_3) && !istrue(var_5) && !istrue(var_7))
    var_1 thread _id_13DCB(3);

  if(var_2) {
    if(!istrue(var_3)) {
      if(var_4 == "_encstr_995408F398012F656821")
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A1F20ED9ABB1169DF58E5AB6B2BDAB47", var_1, 0);
      else
        _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_97D70EF7537DFFAF99A02830BD970D98", var_1, 0);
    }

    var_0.jailedplayers = scripts\engine\utility::array_remove(var_0.jailedplayers, var_1);
    updatematchqueuepositions(var_0);
  } else
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_B2EE0AF2285926E79ED4010E", var_1, 0);

  var_1 playsoundtoplayer("_encstr_8AD71967E3503EE86086EB98B44128675AEAE54BDF138B7020954A", var_1);
  var_13 = scripts\mp\music_and_dialog::reset_attack_next_available_time("_encstr_8BD40D3ABDA187B7514102896B3B23");
  var_1 setplayermusicstate(var_13);

  if(istrue(level.gulag.onekillwin) && (istrue(var_0.isjailbreak) || level.gulag.maxplayers > 2))
    var_1 playerhide();

  var_1 _id_126B3(1);
  var_1 _id_126B0(1);
  var_1 _id_125BF(0);
  var_1 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A1500D40B22258CE7B07674D3F421C", 1);
  var_1 scripts\mp\weapons::deleteplacedequipment();
  var_14 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::relic_nuketimer_gettimeformission() / 1000;
  var_15 = var_1 _id_125BE(0, var_14);
  var_16 = var_1 _id_1263E(var_15);
  wait 2.0;

  if(istrue(level.gulag.arenaflag))
    var_0.managevehiclehealthui.arenaflag thread calloutmarkerpingvo_canplaywithspamavoidance(0, var_1);

  var_1 clearclienttriggeraudiozone(2);
  var_1 gulagfadetoblack(1);
  wait 1;
  var_1 gulagwinnerrespawn(var_5, var_4, var_15, 1, var_16, undefined, var_6, var_3, var_7);
}

_id_1263E(var_0) {
  var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B8(var_0.origin, var_0.height);
  self calloutmarkerping_getinventoryslot(0.0);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126B9(var_1);
  return var_1;
}

set_respawn_points(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91ED0AECABC60B3BEB95CD23");
  self endon("_encstr_AF760A0FBD782BDA13AA7FE5");
  self waittill("_encstr_AD75063D571AE108", var_2);

  if(istrue(level.gulag.onekillwin))
    handleonekillwin(var_0, self, var_2, var_1);

  thread set_respawn_loc_delayed(var_0);
}

set_respawn_loc_delayed(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_95AB121C5DB1D8EB7B57E87DED33EBB3AB6385B3");
  self notify("_encstr_AF760A0FBD782BDA13AA7FE5");

  if(istrue(self.gulagloser)) {
    return;
  }
  self.gulagloser = 1;
  self._id_136DC = var_0._id_136DC;
  thread _id_1268E(1);
  var_0.jailedplayers = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);

  if(var_0.jailedplayers.size > 0 && getdvarint("_encstr_AD161CDCC627FA8939D7CC36FA378356D83AC23ACAEBDEABD1B15AB995B9", 0))
    self hudoutlinedisableforclients(var_0.jailedplayers);

  var_0.arenaplayers = scripts\engine\utility::array_removeundefined(var_0.arenaplayers);

  if(var_0.arenaplayers.size > 0 && getdvarint("_encstr_BACE1CFF7B8AE93EC3F13199195F6D68A5D97D5BDFB620FD8B5B89EDA303", 1) > 0)
    self hudoutlinedisableforclients(var_0.arenaplayers);

  var_0.arenaplayers = scripts\engine\utility::array_remove(var_0.arenaplayers, self);

  if(isDefined(self))
    var_1 = self.name;
  else
    var_1 = "_encstr_AA3A0C14C35837A70410A21AD940";

  var_2 = scripts\mp\music_and_dialog::reset_attack_next_available_time("_encstr_8E250E989CBE3BEA361676FAB1BDB959");
  self setplayermusicstate(var_2);
  scripts\mp\weapons::deleteplacedequipment();
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_11B15(self, "_encstr_A66A10503B75B3993BEC3733FD6B24671A93");
  level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_14006();
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_A7090BD76D0D18BC77C2109BBA", self, 0, 1);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztutdropcash("_encstr_B2C314E807BCE10731A3051FFD4A530B1D173830F74D", self.team, self, 0, 0);

  if(isalive(self)) {
    thread _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_13DC2();
    self.plotarmor = 1;
    self freezecontrols(1);
  }

  wait 2.0;
  self clearclienttriggeraudiozone(2);

  if(istrue(level.gulag.arenaflag))
    var_0.managevehiclehealthui.arenaflag thread calloutmarkerpingvo_canplaywithspamavoidance(0, self);

  scripts\cp\vehicles\vehicle_compass_cp::_id_1203C(2);
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroyaward(self, "_encstr_97B70613D8CBCD8B");
  playerdestroyhud(var_0);
  setplayervargulag(0);
  setplayervargulagarena(0, 1);
  _id_131AA(0);

  if(isalive(self)) {
    if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_838F0D8DEFA26BC7D83780300FF4D9"))
      _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_11BE2(self, undefined, 1);

    gulagfadetoblack();
    wait 1;

    if(!_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_838F0D8DEFA26BC7D83780300FF4D9"))
      _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_11BE2(self, undefined, 1);

    if(isalive(self)) {
      var_3 = spawnStruct();
      var_3.origin = self.origin;
      var_3.angles = self.angles;
      var_3.attacker = self.lastattacker;
      self.health = 0;
      self notify("_encstr_AD75063D571AE108");
      self notify("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
      _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::spawnspectator(var_3, 1, 1);
      scripts\mp\playerlogic::removefromalivecount(0, "_encstr_A66A10503B75B3993BEC3733FD6B24671A93");
    }

    gulagfadefromblack();
  }

  self.plotarmor = undefined;
}

_id_1268E(var_0) {
  if(istrue(level.usegulag)) {
    if(var_0) {
      self._id_14439 = var_0;
      self setclientomnvar("_encstr_AAFD09E3F80F777F282FFF", var_0);
    } else {
      self._id_14439 = undefined;
      self setclientomnvar("_encstr_AAFD09E3F80F777F282FFF", 0);
    }

    _id_131A1(var_0);
  }
}

_id_126AA() {
  if(istrue(level.usegulag) && istrue(self._id_14439) && _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationids(self.team, self.squadindex) > 0)
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::dmztut_endgamewithreward("_encstr_8D630EF77BF0CE0730E9FB23F1775F04", self, 0, 1);
}

_id_12AA8(var_0, var_1) {
  if(istrue(var_1.gulagarena)) {
    var_2 = var_1.arena;
    var_2.molotovs[var_2.molotovs.size] = var_0;
  }
}

_id_12AAA(var_0, var_1) {
  if(istrue(var_1.gulagarena)) {
    var_2 = var_1.arena;
    var_2._id_13B29[var_2._id_13B29.size] = var_0;
  }
}

handlesoloexclusionils(var_0) {
  foreach(var_2 in var_0.molotovs) {
    if(isDefined(var_2))
      thread scripts\mp\equipment\molotov::_id_11CB5(var_2);
  }

  var_0.molotovs = [];

  foreach(var_5 in var_0._id_13B29) {
    if(isDefined(var_5))
      var_5 thread scripts\mp\equipment\thermite::thermite_destroy();
  }

  var_0._id_13B29 = [];
}

set_relic_squadlink(var_0) {
  var_1 = isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent);

  if(!var_1)
    return 1;

  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_4 = distance2d(var_0, var_2);
  return var_4 < var_3;
}

set_relic_shieldsonly(var_0) {
  var_1 = isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent);

  if(!var_1)
    return 1;

  var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  var_4 = distance2d(var_0, var_2);
  return var_4 < var_3;
}

set_relic_rocket_kill_ammo(var_0, var_1) {
  if(!_encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::ispointinbounds(var_0, 1))
    return 0;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent) || !isDefined(level.br_circle.dangercircleent))
    return 1;

  if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_85EE090C9DD0A62F3CA1B3") {
    if(set_relic_shieldsonly(var_0))
      return 1;
  } else {
    if(set_relic_squadlink(var_0))
      return 1;

    if(!set_relic_shieldsonly(var_0))
      return 0;
  }

  if(isDefined(var_1)) {
    var_2 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getmintimetillpointindangercircle(var_0);

    if(var_1 > var_2)
      return 0;
  }

  var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
  var_5 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
  var_6 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();
  var_7 = length(var_5 - var_3);
  var_8 = vectorNormalize(var_5 - var_3);
  var_9 = level._id_12CA0;
  var_10 = var_3 + var_8 * var_7 * var_9;
  var_11 = var_4 + (var_6 - var_4) * var_9;
  var_12 = distance2d(var_0, var_10);
  return var_12 < var_11;
}

updateplayereliminatedomnvar(var_0, var_1) {
  if(var_0 == self)
    return 0;

  if(!isalive(var_0) || var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updateinstantclassswapallowedinternal() || istrue(var_0.delay_enter_combat_after_investigating_grenade))
    return 0;

  if(!set_relic_rocket_kill_ammo(var_0.origin, var_1))
    return 0;

  return 1;
}

_id_12568(var_0, var_1, var_2) {
  var_3 = undefined;

  if(istrue(level.onlinegame) && self getprivatepartysize()) {
    var_4 = undefined;

    foreach(var_6 in self getfireteammembers()) {
      if(!updateplayereliminatedomnvar(var_6, var_1)) {
        continue;
      }
      var_4 = var_6;

      if(var_6 isfireteamleader()) {
        break;
      }
    }

    if(isDefined(var_4) && istrue(var_0)) {
      var_3 = var_4;
      var_4 = undefined;

      foreach(var_6 in self getfireteammembers()) {
        if(isDefined(var_3) && var_3 == var_6) {
          continue;
        }
        if(!updateplayereliminatedomnvar(var_6, var_1)) {
          continue;
        }
        var_4 = var_6;

        if(var_6 isfireteamleader()) {
          break;
        }
      }
    }

    if(isDefined(var_4))
      return var_4;
  }

  if(isDefined(self.lastdeathpos)) {
    var_10 = undefined;
    var_11 = undefined;
    var_12 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationrefsbyseatandweapon(self.team, self.squadindex);

    foreach(var_14 in var_12) {
      if(isDefined(var_3) && var_3 == var_14) {
        continue;
      }
      if(!updateplayereliminatedomnvar(var_14, var_1)) {
        continue;
      }
      if(var_14 isparachuting() || var_14 isskydiving()) {
        continue;
      }
      var_15 = distance2dsquared(self.lastdeathpos, var_14.origin);

      if(!isDefined(var_11) || var_15 < var_11) {
        var_10 = var_14;
        var_11 = var_15;
      }
    }

    if(isDefined(var_10) && istrue(var_0) && !isDefined(var_3)) {
      var_3 = var_10;
      var_10 = undefined;
      var_11 = undefined;

      foreach(var_14 in var_12) {
        if(isDefined(var_3) && var_3 == var_14) {
          continue;
        }
        if(!updateplayereliminatedomnvar(var_14, var_1)) {
          continue;
        }
        if(var_14 isparachuting() || var_14 isskydiving()) {
          continue;
        }
        var_15 = distance2dsquared(self.lastdeathpos, var_14.origin);

        if(!isDefined(var_11) || var_15 < var_11) {
          var_10 = var_14;
          var_11 = var_15;
        }
      }
    }

    if(isDefined(var_10))
      return var_10;
  }

  var_10 = undefined;
  var_19 = scripts\engine\utility::array_randomize(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::rotationrefsbyseatandweapon(self.team, self.squadindex));

  foreach(var_21 in var_19) {
    if(isDefined(var_3) && var_3 == var_21) {
      continue;
    }
    if(!updateplayereliminatedomnvar(var_21, var_1)) {
      continue;
    }
    var_10 = var_21;

    if(istrue(var_21 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatedragonsbreath())) {
      break;
    }
  }

  if(isDefined(var_10))
    return var_10;
  else if(!istrue(var_2)) {
    if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_BE180419DAE9" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_8AE1099A0B999F2D28AF15" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_9B1F05BE4B9B52" || scripts\mp\utility\game::round_vehicle_logic() == "_encstr_866209ECEDB1197DEE0B4E") {
      var_23 = scripts\mp\utility\teams::getteamdata(self.team, "_encstr_AB580A05672AE35D5FFF50B8");

      if(var_23 == 1 && !istrue(self.locationtriggersetpaused) && !scripts\mp\outofbounds::ispointinoutofbounds(self.origin))
        return self;
    }
  }

  return undefined;
}

rocket_fuel_stability(var_0, var_1, var_2) {
  var_3 = ai_washitbyvehicle(var_0, var_1, var_2);
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::detonatesound(var_0, 0, var_3);
  return var_3;
}

ai_washitbyvehicle(var_0, var_1, var_2) {
  var_3 = 3.14159;
  var_4 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
  var_5 = vectorNormalize(var_0 - var_4);
  var_6 = vectortoangles(var_5);
  var_7 = randomfloatrange(getdvarfloat("_encstr_86151C3BA9A3BFCDD8871ECD9AFB71B7BDE9FAD1B20D0E66A007BF6389EB", 10.0), getdvarfloat("_encstr_A9151CD71B537F02CD80AA67FEB14A1FB8795B27C04987FADDA4F91DEF89", 90.0));
  var_8 = scripts\mp\utility\game::round_vehicle_logic();

  if((var_8 == "_encstr_BE180419DAE9" || var_8 == "_encstr_8AE1099A0B999F2D28AF15") && getdvarint("_encstr_87EC196FB8EBF7EA6B8A695A7D3FE391137867E3308004814BA86F", 0) == 1 || var_8 == "_encstr_BAA110C9BA5BC48D56D74BB9D92CCD4BBDE6")
    var_9 = vectorNormalize(anglesToForward(var_6 + (0, scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), var_7, var_7 * -1), 0)));
  else
    var_9 = var_5;

  var_10 = var_0 + var_9 * var_1;

  if(set_relic_rocket_kill_ammo(var_10, var_2))
    return var_10;

  var_9 = var_9 * -1;
  var_10 = var_0 + var_9 * var_1;

  if(set_relic_rocket_kill_ammo(var_10, var_2))
    return var_10;

  var_9 = vectorNormalize(var_4 - var_0);
  var_10 = var_0 + var_9 * var_1;

  if(set_relic_rocket_kill_ammo(var_10, var_2))
    return var_10;

  var_11 = var_1;
  var_12 = distance2d(var_0, var_4);

  if(var_12 > 0) {
    var_13 = var_11 / var_12;

    if(var_13 > var_3)
      var_13 = var_3;

    var_14 = var_13 * 180 / var_3;
    var_10 = rotatepointaroundvector((0, 0, 1), var_0 - var_4, var_14) + var_4;

    if(set_relic_rocket_kill_ammo(var_10, var_2))
      return var_10;
  }

  var_10 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getrandompointincircle(var_0, var_1);

  if(set_relic_rocket_kill_ammo(var_10, var_2))
    return var_10;

  return undefined;
}

_id_12567() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_AF190997F3A62B7168C0DA"))
    return undefined;

  foreach(var_5, var_1 in level.questinfo.quests) {
    foreach(var_4, var_3 in var_1.instances) {
      if(var_4 == self.team && !_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::upper_door_coll(var_3)) {
        switch (var_3.category) {
          case "_encstr_92A40EF9E31F7F501AA96573DCC4E8B0":
            if(isDefined(var_3.targetplayer))
              return var_3.targetplayer.origin;

            break;
          case "_encstr_A1580B19DE5B5A9B0BA35AEDCD":
            if(isDefined(var_3._id_1393B) && isDefined(var_3._id_1393B.domflag) && isDefined(var_3._id_1393B.domflag.curorigin))
              return var_3._id_1393B.domflag.curorigin;

            break;
          case "_encstr_A11904D82B38":
          case "_encstr_ACE0106BABFBACE38DF73568015199D47F83":
          case "_encstr_AF460A7B2649F34FE367455D":
            if(isDefined(var_3._id_1393B.force_spawn_all_dead_players.origin) && isDefined(var_3._id_1393B.force_spawn_all_dead_players))
              return var_3._id_1393B.force_spawn_all_dead_players.origin;

            break;
          case "_encstr_97580E238AD72960B651E3379C0EE7F9":
          case "_encstr_A19B096816E6C71BC36072":
          case "_encstr_AADD079327E9CA81D2":
          case "_encstr_8D600AE8F5694A3F2C68BA72":
          case "_encstr_B82D088332497B18D26E":
          case "_encstr_A93908FBBAC970BACA02":
          case "_encstr_B4AB0698A3B0E99A":
          case "_encstr_8745086CF27708C893BF":
          case "_encstr_B47808F8E26FEBB7D25B":
          case "_encstr_A6B10B0EF0CF8423188FFF5B36":
          case "_encstr_951904D8F1E0":
            break;
          default:
            break;
        }
      }
    }
  }

  return undefined;
}

_id_12566(var_0) {
  foreach(var_2 in level.br_pickups.crates) {
    if(!isDefined(var_2) || !isDefined(var_2.team) || var_2.team != self.team) {
      continue;
    }
    if(isDefined(var_2.playerscaptured) && isDefined(var_2.playerscaptured[self getentitynumber()])) {
      continue;
    }
    if(set_relic_rocket_kill_ammo(var_2.origin, var_0))
      return var_2.origin;
  }
}

_encstr_81221ED0E331628363E78515BD4AD34B9A0FC8B00FCAFB532B0F881E54820B70(var_0) {
  var_1 = level.disable_super_in_turret._encstr_BE0E1DFD87EA0ED82153F9D33F1110B5C227591167F2CB2849EAC349E5FB98 * level.disable_super_in_turret._encstr_BE0E1DFD87EA0ED82153F9D33F1110B5C227591167F2CB2849EAC349E5FB98;

  foreach(var_3 in level.disable_super_in_turret._encstr_A3651345F2A970C6A3FAABF172F78920FA71E1339B) {
    if(isDefined(var_3) && distance2dsquared(var_0, var_3.origin) <= var_1)
      return var_3.origin;
  }
}

_id_125BE(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = var_2;
  var_6 = 1;
  var_7 = 0;

  if(isDefined(self.setspawnpoint)) {
    var_3 = self.setspawnpoint.playerspawnpos;
    var_4 = self.setspawnpoint.playerspawnangles;
  }

  var_8 = getdvarfloat("_encstr_95AF21DC36E4AF3127FA4EB26E0785DDE66A0BC331C26EE888ACB0D143F499CCCD561D", -1);

  if(!isDefined(var_3) && var_8 >= 0 && isDefined(self.lastdeathpos)) {
    var_9 = rocket_fuel_stability(self.lastdeathpos, var_8, var_1);

    if(isDefined(var_9)) {
      var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_9);
      var_4 = registercarryobjectpickupcheck(var_3, self.lastdeathpos);
    }
  }

  var_8 = getdvarfloat("_encstr_AD59209A0106B7A90B818BA0ABB08F43909D8F1BB18B4F33F00ECCD374E7F3EBF094", 1000);

  if(!isDefined(var_3) && var_8 >= 0) {
    var_10 = _id_12568(var_0, var_1);

    if(isDefined(var_10)) {
      var_11 = getdvarfloat("_encstr_836B22D789622F86887031A3A5A6499227E06F844684118E579B535BE1FFF0D1F94A07ED", 5.0) * 1000;
      var_12 = getdvarfloat("_encstr_AFA91872C138F7822947EF434B453A1030A868F1FB489E9A705F", 30.0) * 1000;

      if((getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_B18D0B5281530117EDEAC82033" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") && isDefined(level.teamdata[self.team]["_encstr_A70F12FDD3FBD31AD93B716E5C1B13A55997BD62"]) && level.teamdata[self.team]["_encstr_A70F12FDD3FBD31AD93B716E5C1B13A55997BD62"] + var_12 > gettime() + var_11 && distance2d(level.teamdata[self.team]["_encstr_8BC0140CA3F87B2BDF3B6AB2802D73F7C12DB18F2B78"], var_10.origin) < getdvarfloat("_encstr_AD59209A0106B7A90B818BA0ABB08F43909D8F1BB18B4F33F00ECCD374E7F3EBF094", 1000) * 1.25) {
        var_3 = level.teamdata[self.team]["_encstr_8BC0140CA3F87B2BDF3B6AB2802D73F7C12DB18F2B78"];
        var_4 = level.teamdata[self.team]["_encstr_842F1402D718231F9F2A7E06A0ABEB92E83D3FBAC2BB"];
      } else {
        var_3 = rocket_fuel_stability(var_10.origin, var_8, var_1);

        if(isDefined(var_3)) {
          var_3 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::modifyplayer_damage(var_3);
          var_4 = registercarryobjectpickupcheck(var_3, var_10.origin);
          level.teamdata[self.team]["_encstr_8BC0140CA3F87B2BDF3B6AB2802D73F7C12DB18F2B78"] = var_3;
          level.teamdata[self.team]["_encstr_842F1402D718231F9F2A7E06A0ABEB92E83D3FBAC2BB"] = var_4;
          level.teamdata[self.team]["_encstr_A70F12FDD3FBD31AD93B716E5C1B13A55997BD62"] = gettime();
        }
      }

      if(isDefined(var_3) && isDefined(level._id_12CA9) && level._id_12CA9 >= 0) {
        var_13 = getclosestpointonnavmesh(var_3);
        var_14 = var_13 - var_3;

        if(length2d(var_14) > level._id_12CA9) {
          var_14 = vectorNormalize(var_14);
          var_14 = (var_14[0] * level._id_12CA9, var_14[1] * level._id_12CA9, var_14[2] * level._id_12CA9);
          var_3 = var_13 + var_14;
        }
      }
    }
  }

  var_8 = getdvarfloat("_encstr_97E01F6E1B9CBE139CEBE456E60785DD373585C3A92DCDB9B4F6CDA799996E5647", 3000);

  if(!isDefined(var_3) && var_8 >= 0) {
    var_15 = _id_12567();

    if(isDefined(var_15)) {
      var_3 = rocket_fuel_stability(var_15, var_8, var_1);
      var_4 = registercarryobjectpickupcheck(var_3, var_15);
    }
  }

  var_8 = getdvarfloat("_encstr_861E1DBFAF2DE170431E4BF527D842E42DDD33382DFBA9E8056FFD79E3F01C", 3000);

  if(!isDefined(var_3) && var_8 >= 0) {
    var_16 = _id_12566(var_1);

    if(isDefined(var_16)) {
      var_3 = rocket_fuel_stability(var_16, var_8, var_1);
      var_4 = registercarryobjectpickupcheck(var_3, var_16);
    }
  }

  if(scripts\mp\utility\game::round_vehicle_logic() == "_encstr_AD51088015D1E2D47930" && _encstr_83DF0DD2E66EC5572CC8EE9638CA46(self.team)) {
    var_17 = self.origin;

    if(isDefined(self.lastdeathpos))
      var_17 = self.lastdeathpos;

    var_18 = _encstr_81221ED0E331628363E78515BD4AD34B9A0FC8B00FCAFB532B0F881E54820B70(var_17);

    if(!isDefined(var_18))
      var_18 = var_17;

    var_8 = level.disable_super_in_turret._encstr_8BDC1A53E14025028DFBE38BC5A53B70F80B4D9D9960E26A5583EFEF;
    var_3 = rocket_fuel_stability(var_18, var_8, var_1);
    var_4 = registercarryobjectpickupcheck(var_3, var_18);
  }

  if(!isDefined(var_3)) {
    if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
      if(getdvarint("_encstr_A7F1282F6B5AEF53F25F47DAC787C07FD08862A117739A38706F541078C15270E1E781B37734225E8397", 0)) {
        var_19 = getdvarfloat("_encstr_8AEE22371BE4F58993AFC636EDDC2BE63A4D1633AC41DE4B738E8A96ADB2A76666E6AC1D", 2.0);
        var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::helibankplunder(self, var_1, var_19);
      }

      if(!isDefined(var_3)) {
        var_20 = getdvarfloat("_encstr_A1582DDCC69CD79893FA5D6EAC1AD8DB9B566EA3A616CCB205CAC9B4B6B23A59E40ABD4BDC479416465ABA6E0A1BE8", 0.9);

        if(getdvarint("_encstr_9BBE311BAFF8B9FB4E96D3BB393E1B6D581B9384A718BFAF67C95B02AD7533A78899371145184FCB90E0418B6B5F8B1D7849B5", 1))
          var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::_encstr_AD30271B63ED3759CDE8B98533561CB293B4DAACE82B271C7B5AE61D994EB7D6DC2EBAC219B685A3CA(var_20, var_1);

        if(!isDefined(var_3) && getdvarint("_encstr_8CDF2FF241B8770226A7C7C7CB562A8F48696ABBFF88160A6FFBD3A7337DF3FDE857E5443078FEB3D893134713958A2580", 1))
          var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::_encstr_BD592572209FE2AF5B155B4124A1C3AF0D901AEA08531AB3B0F35E6CCCAB77F549084272681BD3(var_20, var_1);

        if(isDefined(var_3)) {
          var_4 = registercarryobjectpickupcheck(_encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin(), var_3);
          var_21 = 0;

          if(getdvarint("_encstr_9A4A32338E7347AED5D1732B388FE54F8B65BBCC0EB91B37F9680B82902BDB3FC3473542374173BF534063CAE85D1FE759B3B6CF", 1)) {
            var_22 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
            var_23 = randomint(2);
            var_24 = [90, -90];
            var_25 = [-10.0, 10.0];
            var_26 = rotatevector(var_3 - var_22, (0, var_25[var_23], 0)) + var_22;
            var_27 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_26, 0, var_1);

            if(var_27 == 0) {
              var_23 = 1 - var_23;
              var_26 = rotatevector(var_3 - var_22, (0, var_25[var_23], 0)) + var_22;
              var_27 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::vandalize_minigun_speed(var_26, 0, var_1);
            }

            if(var_27) {
              var_3 = var_26;
              var_21 = var_24[var_23];
            }
          }

          var_28 = angleclamp(var_4[1] + var_21);
          var_4 = (0, var_28, 0);
        }
      }

      if(!isDefined(var_3)) {
        var_29 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();
        var_30 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleradius();
        var_31 = getdvarfloat("_encstr_82FA1BEB26DBEF166D79AAE218C50F87339F577ED6C14B9C5B9B815AF0", 0.9);
        var_20 = getdvarfloat("_encstr_A7211B8B3F68298B3EE6C20A2A06AF9AD0A307EE35A8AF6F659B0912B3", 0.9);
        var_32 = getdvarint("_encstr_99CD1EDB18F8EF2EF38EED20B2BB5D524F8F6388F8BB57E341EA657BAA0D628F", 1);
        var_33 = getdvarint("_encstr_A16E1F53AE53678EF5F1D2EA304D871FCB07DFF62EB8E7529158E8E2685BFF4760", 1);

        if(getdvarint("_encstr_823D23C39A6308B002C77543F36A60E4EBB1D8E8427F5E905AD3414B37D738214BFA91F1CA", 1) && var_30 == 0) {
          var_34 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
          var_35 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleradius();

          if(var_35 > 0) {
            var_29 = var_34;
            var_30 = var_35;
            var_31 = getdvarfloat("_encstr_910C24D753B2D116EBE9B820E2B35D78CAA95775CADE50EB9F031769ABAF8490650C85E36304", 0.6);
            var_20 = getdvarfloat("_encstr_B4172408A20A27D16BF71907B8837907F2EAB06809669948AFE38F0EAC8FC1EB5DA290A8F23C", 0.8);
            var_7 = 1;
          }
        }

        var_3 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_flagspawnshiftingpercent(var_29, var_30, var_31, var_20, var_32, var_33, 0, var_1);
      }
    } else if(isDefined(level.prematchspawnorigins)) {
      if(isDefined(level.teamdata[self.team]["_encstr_922D161FB00D487D73F1B399DB1B3CC06215FFB529F75030"]) && isDefined(level.teamdata[self.team]["_encstr_9A191C9B0EB0DDDC75B41CB29EC95A3B4BDCAAB9CA6A8E0B398E514BDA2B"]) && isDefined(level.checkpoint_objective_id) && level.teamdata[self.team]["_encstr_9A191C9B0EB0DDDC75B41CB29EC95A3B4BDCAAB9CA6A8E0B398E514BDA2B"] + level.checkpoint_objective_id * 1000 > gettime())
        var_3 = level.teamdata[self.team]["_encstr_922D161FB00D487D73F1B399DB1B3CC06215FFB529F75030"];
      else {
        var_36 = [];

        foreach(var_38 in level.prematchspawnorigins) {
          if(distance2dsquared(var_38.origin, self.origin) > var_8)
            var_36[var_36.size] = var_38;
        }

        if(var_36.size == 0)
          var_36 = level.prematchspawnorigins;

        var_36 = scripts\engine\utility::array_randomize(var_36);

        if((getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E") && isDefined(level._id_12CA7) && istrue(self._id_13749))
          var_3 = (var_36[0].origin[0], var_36[0].origin[1], level._id_12CA7);
        else
          var_3 = var_36[0].origin;

        var_3 = var_3 + scripts\engine\math::random_vector_2d() * randomfloatrange(100, 500);
        level.teamdata[self.team]["_encstr_922D161FB00D487D73F1B399DB1B3CC06215FFB529F75030"] = var_3;
        level.teamdata[self.team]["_encstr_9A191C9B0EB0DDDC75B41CB29EC95A3B4BDCAAB9CA6A8E0B398E514BDA2B"] = gettime();
      }

      var_4 = (0, 0, 0);

      if(var_3[2] > 10000 &!isDefined(var_2)) {
        var_6 = 0;
        var_5 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::getinfilspawnoffset();
      }
    } else {
      var_3 = (0, 0, 0);
      var_4 = (0, 0, 0);
    }
  }

  if(!isDefined(var_4)) {
    if(var_7)
      var_40 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getdangercircleorigin();
    else
      var_40 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::getsafecircleorigin();

    var_41 = vectortoyaw(var_40 - var_3);
    var_4 = (0, var_41, 0);
  }

  if(var_6) {
    if(!isDefined(var_5))
      var_5 = scripts\cp_mp\parachute::getc130height();

    if(isDefined(level.br_circle)) {
      var_42 = level.br_circle.circleindex;
      var_43 = remove_engineer_class();
      var_44 = isDefined(var_42) && var_42 >= var_43;

      if(var_44)
        var_5 = var_5 * getdvarfloat("_encstr_975C247BE76D3F6D53AF2990C148DF9BD8E07BD52FEFBBC0E3234CDAE1F805A8C120D25AA080", 0.55);
    }

    if(isDefined(level._id_12CA7))
      var_5 = level._id_12CA7;

    var_45 = (0, 0, var_5);
    var_3 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::resetcircuitbreakers(var_3, var_45);
  }

  var_46 = spawnStruct();
  var_46.origin = var_3;
  var_46.angles = var_4;
  var_46.height = var_5;
  return var_46;
}

registercarryobjectpickupcheck(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = vectortoyaw(var_1 - var_0);
    var_3 = (0, var_2, 0);
    return var_3;
  }
}

gulagwinnerrespawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = !istrue(var_0);

  if(!istrue(var_0) && !istrue(var_8))
    scripts\cp\vehicles\vehicle_compass_cp::_id_1203C(1);

  if(!isDefined(var_10))
    var_10 = 0;

  if(isDefined(var_1))
    _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroyaward(self, var_1);

  _id_1268E(0);
  setplayervargulag(0);
  setplayervargulagarena(0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    playerdestroyhud(self.arena);

  _id_131AA(0);
  level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
  self.vehicle_compass_friendlystatuschangedcallback = undefined;
  _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptednode(self);
  playertakeawayrock(self.arena);
  set_showing_bomb_wire_pair_to_player(var_0);

  if(isDefined(level.gulag) && istrue(level.gulag.planerespawn)) {
    playerrespawngulagcleanup(var_0);
    set_scriptable_states();
    playersetupac130();

    if(isDefined(self.oobimmunity))
      scripts\mp\outofbounds::disableoobimmunity(self);

    return;
  }

  if(!isDefined(var_2))
    var_2 = _id_125BE();

  var_12 = var_2.origin;
  var_13 = var_2.angles;
  var_14 = var_12;

  if(isDefined(var_4))
    var_14 = var_4;

  set_scriptable_states();
  _id_126C3(var_14, var_13);
  var_15 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_14);
  var_15 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_15.angles = var_13;
  var_15 hide();
  var_15 showtoplayer(self);
  self playerlinktoabsolute(var_15, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self playerhide();
  thread _id_12524(var_15);
  waitframe();

  if(isDefined(self.oobimmunity))
    scripts\mp\outofbounds::disableoobimmunity(self);

  playerrespawngulagcleanup(var_0);

  if(getdvarint("_encstr_A69D166B46DACF52A7B74FD7339D037227F39329CA20A30A", 1) == 0)
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_126ED();

  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1252B();

  if(isDefined(var_4))
    var_15.origin = var_12;

  var_15 playsoundtoplayer("_encstr_85E90F214B17D778126B31F7262DE02EF7", self);
  wait 1.5;
  self unlink();
  self clearsoundsubmix("_encstr_9A6A0FC7E54971D043696DEF18531612F3");

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    self clearsoundsubmix("_encstr_AC6F16A09BE04FB9335FB4B574A7C1875B03C008A3CC6B30", 2);
  else
    self clearsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 2);

  self clearclienttriggeraudiozone(1);
  self playershow(1);
  _id_125BF(1);
  var_16 = 0;

  if(isDefined(level._id_121CC))
    var_16 = level._id_121CC;

  if(!_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid()) {
    if(istrue(level._id_13678))
      self[[level.parachuterestoreweaponscb]]();
    else
      thread scripts\cp_mp\parachute::startfreefall(var_16, 0, undefined, undefined, 1);
  }

  if(!istrue(var_3))
    thread _id_13DCB(7);

  if(istrue(var_5))
    self setclientomnvar("_encstr_BD9616AB2DD7C427D78E3958B9B94BE8B4BD737D3A2F1C95", 0);

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
    self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);

  _id_12C7A();
  var_17 = scripts\mp\utility\perk::_hasperk("_encstr_8A4D18DC8356D82D85C6E8CBAF31E4F593B2B4DCCCDE9CC6CA32");
  _encstr_B89622B91BE42DE0E8DC976B0779EC0BB695E8973856B9CBC427FA2CE4DADB93173B9B1B::searchcirclesize(var_17);
  _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::_id_12072();
  _encstr_851F24F3D825E47B3B1687CDAF681F2EB3700BABA8D3DA4E91FEEFEACD8BCFB2D96836C208B7::_id_12072();
  _encstr_81032C6ED8E4B41CA3CDCBAD0E979DB05B561D971C95375E98C9BE2C3647FA6BDEC8B2AF56E68D0B38955C76B9C6::obj_hangar_juggs();
  _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AD491376AB362CD9752DDC37959C9456E60EC2DDE6", self);
  wait 0.5;

  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !isDefined(self._id_145BF))
    gulagfadefromblack();

  waitframe();
  var_15 delete();
  _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_9B220634456A5747");

  if(istrue(level._id_133EF))
    _encstr_85592F474FBE12F0D81BA53D532A2F2A99EBC3E7116DFB97B0C3A18228E07462EC73E7BBBD805395D02B248DE072BF9BCE::toma_strike_munitionused(1);

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
    self notify("_encstr_B18313686F8BFB339B7D70E452326346C747E078FF");

  self notify("_encstr_978F121A20F5F1EF10A0675746FB5B863780E293");

  if(istrue(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_85EE090C9DD0A62F3CA1B3") && !istrue(var_8)) {
    var_18 = "_encstr_8D6521F275694F4FA989DA4153736B45C01D576AE31817A3416033497858977B20A3E7";
    var_19 = undefined;
  }

  if(istrue(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9") || istrue(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15") || istrue(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_B18D0B5281530117EDEAC82033") || istrue(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_816E079685517D0975") || istrue(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52") || istrue(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9936086E0BB9324CDBC3") || istrue(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BAA110C9BA5BC48D56D74BB9D92CCD4BBDE6") || istrue(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E")) {
    var_18 = "_encstr_8D6521F275694F4FA989DA4153736B45C01D576AE31817A3416033497858977B20A3E7";
    var_19 = undefined;
  } else if(istrue(var_7)) {
    var_18 = "_encstr_93831CF6BAB7213BCDCAD81152A6DB98AB428DFF0B0FCB53B7925890FA78";
    var_19 = undefined;
  } else if((istrue(var_0) || istrue(var_8)) && !var_10) {
    var_18 = "_encstr_A30D1880F5B18FB0C8511771D740E5F3A0772B5A673FE9B958E8";
    var_19 = var_6;
  } else {
    if(istrue(isDefined(level.gulag) && !istrue(level.gulag.shutdown)) && checkgulagusecount())
      var_18 = "_encstr_8D6521F275694F4FA989DA4153736B45C01D576AE31817A3416033497858977B20A3E7";
    else
      var_18 = "_encstr_867019D082610C2363DFB8982F4B3D20B506A6252734A8C37447CB";

    var_19 = undefined;
  }

  if(!istrue(var_9))
    thread scripts\mp\hud_message::showsplash(var_18, undefined, var_19);

  if(istrue(self._id_145BF) && isDefined(level.br_circle)) {
    self._id_145BF = undefined;

    if(istrue(self._id_12C9E)) {
      playerrespawngulagcleanup(var_0);
      set_scriptable_states();
      _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_9B220634456A5747");

      if(isDefined(self.oobimmunity))
        scripts\mp\outofbounds::disableoobimmunity(self);
    }

    _id_1268C();
  }

  if(isDefined(level.gulag) && istrue(level.gulag.shutdown) && !istrue(self.gulagdone)) {
    wait 2.0;
    playergulagdonesplash();
  }

  if(var_10) {
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(self, "_encstr_83BA192FFDC8C7E79778CAC230F5926F83E7B1B798385BADB760D2");
    level thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_14006();
  }

  var_20 = "_encstr_8C500ABA9B23CACC2D37AC8C";

  if(isDefined(self.currentweapon))
    var_20 = self.currentweapon.basename;

  var_21 = "_encstr_8C500ABA9B23CACC2D37AC8C";

  if(isDefined(self.name))
    var_21 = self.name;

  logstring("_encstr_8FC22C9345E99952F4F0027A9BCB9F0F22D5252381785B231B08AAF62010C2C758D9DEB71D1A22D3378282DB625F" + var_21 + "_encstr_97350F6063D974C0907B011F0320AAEA19" + var_20);
}

_id_12524(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_0))
    var_0 delete();
}

_id_125BF(var_0) {
  if(var_0) {
    self enableoffhandweapons();
    self enableusability();
  } else {
    self disableoffhandweapons();
    self disableusability();
  }
}

_id_13DCB(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_AB11161D39D23B76954E29AC6E832CEE377ACE95E436C2F2");

  if(istrue(var_1)) {
    return;
  }
  _id_13DCC();
}

_id_13DCC() {
  wait 0.5;

  if(istrue(self._id_145BF))
    thread scripts\mp\hud_message::showsplash("_encstr_AFA41729F3EF5168DD36BA4F9AED6FC0C7AFBB2FA0D22017DA");
  else
    thread scripts\mp\hud_message::showsplash("_encstr_A613103D8A21C8555BF2313EBB6780D8C7E2");
}

playerrespawngulagcleanup(var_0) {
  self notify("_encstr_AD1C0DE95B640BBC318FC7C9B74B70");
  scripts\mp\equipment\molotov::molotov_clear_burning();

  if(getdvarint("_encstr_85C6203EEB4366550A6998AB72E6073E6F9C4DBF4EE74BE7B412F8D0FB3BD393B730", 0) == 0)
    self.shouldhumanspawntags = 0;

  self.health = self.maxhealth;
  scripts\mp\healthoverlay::onexitdeathsdoor(1);

  if(!istrue(var_0)) {
    scripts\mp\utility\player::enableplayerforspawnlogic(0);
    self setclientomnvar("_encstr_AAFD09E3F80F777F282FFF", 0);
    _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::updatebrscoreboardstat("_encstr_A1500D40B22258CE7B07674D3F421C", 0);

    if(isDefined(self.arena))
      removeloadingplayer(self.arena, self);

    self.arena = undefined;
  }
}

set_showing_bomb_wire_pair_to_player(var_0) {
  var_1 = getdvarint("_encstr_966113DB16EBDF067D69EAB281A73FCF4390575538", 1) != 0;
  var_2 = istrue(level.debug_safehouse_regroup_start) && !istrue(level.debug_show2dvotext);
  var_3 = !istrue(var_0);

  if(var_1 && var_3 && !var_2)
    return gulagwinnerremembergunandammo();

  var_4 = getdvarint("_encstr_9347133356AB495E48019FFE1702FFAE5B906BC552", 1) != 0 && getdvarint("_encstr_859B19C399CE876690B7767B9F906CFB78F14B898D2837DFA01B7C", -1) > -1;

  if(isDefined(level.deletescriptableinstanceaftertime) || var_4) {
    self.set_shouldrespawn = 1;
    return;
  }

  self.set_shouldrespawn = 0;
}

set_solution() {
  if(!istrue(level.usegulag) && !_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_97C92259EBD4B00CB16F0D0577CBDE286303C073172C0837DA0F2309AF239D711D9D8929"))
    return 0;

  var_0 = getdvarint("_encstr_966113DB16EBDF067D69EAB281A73FCF4390575538", 1) != 0;
  var_1 = !istrue(self.gulagloser);

  if(var_0 && var_1)
    return set_slow_healthregen();

  var_2 = getdvarint("_encstr_9347133356AB495E48019FFE1702FFAE5B906BC552", 1) != 0 && getdvarint("_encstr_859B19C399CE876690B7767B9F906CFB78F14B898D2837DFA01B7C", -1) > -1;

  if(isDefined(level.deletescriptableinstanceaftertime) || var_2)
    return set_spawn_scoring_params_for_level();

  return 0;
}

gulagwinnerremembergunandammo() {
  self.br_gulagguncurrent = self getcurrentprimaryweapon();
  var_0 = self getweaponslistprimaries();
  var_0 = scripts\engine\utility::array_remove(var_0, getcompleteweaponname("_encstr_AFBB115ADD1CD75BDCA5CC56DC1D2CC4D7DAC1"));
  var_0 = scripts\engine\utility::array_remove(var_0, getcompleteweaponname("_encstr_B6202030B8C2304120681F3C3C48493BD6B4CC476F18BBF297D92FA5085FC1F7E5FB"));
  var_0 = scripts\engine\utility::array_remove(var_0, getcompleteweaponname("_encstr_93C224EC0CC949B4C8586F07A8209FB2CDABB767E0ABB2EDF1100347E0FE5D1AB135FF1151E9"));
  var_0 = scripts\engine\utility::array_remove(var_0, getcompleteweaponname("_encstr_A10A211A6393EF8BD845C7C76BB01777D0D86242CE0583041051FFD51B885FB790F07B"));
  var_0 = scripts\engine\utility::array_remove(var_0, getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C"));
  self.br_gulagguns = [];
  self.br_gulagammo = [];

  foreach(var_2 in var_0) {
    var_3 = createheadicon(var_2);

    if(getsubstr(var_3, 0, 4) == "_encstr_9B83050BD88EF5") {
      continue;
    }
    self.br_gulagguns[self.br_gulagguns.size] = var_2;

    if(getdvarint("_encstr_AF9C1A4776324FF205F9F46B28909F6E428F5597780347B34F9DCAF5", 0) == 1) {
      self.br_gulagammo[var_3] = self getweaponammoclip(var_2) + self getweaponammostock(var_2);
      continue;
    }

    self.br_gulagammo[var_3] = weaponclipsize(var_2) * 3;
  }

  var_5 = self getweaponslistoffhands();
  var_6 = "_encstr_BA7F0830B3A7859B60B0";
  self.br_gulagoffhands = [];

  foreach(var_8 in var_5) {
    var_9 = self getweaponammoclip(var_8);

    if(var_9 <= 0) {
      scripts\mp\equipment::takeequipment(var_6);
      var_6 = "_encstr_AC8F0AE74163F85AAA380AD8";
      continue;
    }

    var_6 = "_encstr_AC8F0AE74163F85AAA380AD8";
    self.br_gulagoffhands[self.br_gulagoffhands.size] = var_8;
    var_10 = createheadicon(var_8);
    self.br_gulagammo[var_10] = weaponstartammo(var_8);
  }
}

set_slow_healthregen() {
  if(isDefined(self.br_gulagguns) && isDefined(self.br_gulagoffhands) && isDefined(self.br_gulagammo)) {
    var_0 = getdvarint("_encstr_A54F17D38A7318A032F74749E59B58D8BFB2C8D832834840CB", 1) == 1;

    if(var_0 && self.br_gulagguns.size < 1) {
      self.set_shouldrespawn = 1;
      set_spawn_scoring_params_for_level();
      return 0;
    }

    self takeallweapons();
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
    self.equipment["_encstr_BA7F0830B3A7859B60B0"] = undefined;
    self.equipment["_encstr_AC8F0AE74163F85AAA380AD8"] = undefined;
    self.equipment["_encstr_91B50734CA58631D1A"] = undefined;
    self.equipment["_encstr_BEB406F03B72BB3B"] = undefined;
    var_1 = 0;

    foreach(var_3 in self.br_gulagguns) {
      var_4 = createheadicon(var_3);
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3);
      self setweaponammostock(var_3, 0);

      if(!var_1) {
        self assignweaponprimaryslot(var_4);
        scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);
        var_1 = 1;
      }

      scripts\mp\weapons::fixupplayerweapons(self, var_4);
      thread _encstr_AAD224E6C69C2D383ADC5E5B1C5ED985B6593A97C195CD5E989CEB2795371CB0DD731776CDC6::giveweaponpickup(var_4);
      var_5 = weaponclipsize(var_3);
      var_6 = int(min(var_5, 25));

      if(isDefined(self.br_gulagammo[var_4]))
        var_6 = int(max(var_6, self.br_gulagammo[var_4]));

      var_7 = 0;

      if(var_6 > var_5) {
        var_7 = var_6 - var_5;
        var_6 = var_5;
      }

      self setweaponammoclip(var_3, var_6);

      if(var_7 > 0) {
        var_8 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_3);
        _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_give_type(self, var_8, var_7);
      }
    }

    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);

    if(self.br_gulagguns.size < 2)
      self giveweapon(getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C"));

    foreach(var_11 in self.br_gulagoffhands) {
      var_12 = scripts\mp\equipment::getequipmentreffromweapon(var_11);

      if(isDefined(var_12) && isDefined(level.br_pickups.br_equipnametoscriptable[var_12])) {
        var_13 = level.br_pickups.br_equipnametoscriptable[var_12];
        _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::br_forcegivecustompickupitem(self, var_13, 1);
        var_4 = createheadicon(var_11);

        if(isDefined(self.br_gulagammo[var_4])) {
          var_14 = self.br_gulagammo[var_4];
          self setweaponammoclip(var_11, var_14);
        }
      }
    }

    if(isDefined(self.br_gulagguncurrent))
      self switchtoweaponimmediate(self.br_gulagguncurrent);

    if(isDefined(self.executionref))
      scripts\cp_mp\execution::_giveexecution(self.executionref);

    self.br_gulaggun = undefined;
    self.br_gulagammo = undefined;
    self.br_gulagoffhands = undefined;
    self.br_gulagguncurrent = undefined;
    return 1;
  } else if(istrue(self.gulagloser))
    self.shouldhumanspawntags = 0;

  return 0;
}

set_spawn_scoring_params_for_level() {
  if(istrue(self.set_shouldrespawn)) {
    var_0 = getdvarint("_encstr_859B19C399CE876690B7767B9F906CFB78F14B898D2837DFA01B7C", -1);

    if(var_0 > -1)
      self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.set_relic_thirdperson[var_0];
    else
      self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.deletescriptableinstanceaftertime;

    self.class = "_encstr_AAAC09D09972B9C83F2B7F";
    self.prevweaponobj = undefined;
    var_1 = scripts\mp\class::loadout_getclassstruct();
    var_1 = scripts\mp\class::loadout_updateclass(var_1, "_encstr_AAAC09D09972B9C83F2B7F");
    scripts\mp\class::preloadandqueueclassstruct(var_1, 1, 1);
    scripts\mp\class::giveloadout(self.team, "_encstr_AAAC09D09972B9C83F2B7F", 0, 0);
    self givestartammo(var_1.loadoutprimaryobject);

    if(isDefined(var_1.loadoutsecondaryobject))
      self givestartammo(var_1.loadoutsecondaryobject);

    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::scriptednode(self);
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::delay_add_to_chopper_boss_drone_target_array();
    _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_update_weapons(self);
    self notify("_encstr_B2110C63C02DC5E92388229F9D75");
    thread _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::defend_wave_2();

    if(isDefined(level.obit_activation) && level.obit_activation._id_129DA == 1)
      _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::disablearmorykiosk();

    self.set_shouldrespawn = undefined;
    return 1;
  }

  return 0;
}

popnextmatch(var_0) {
  var_1 = var_0.matches[0];
  var_0.matches = scripts\engine\utility::array_remove_index(var_0.matches, 0);
  return var_1;
}

checkgulagusecount() {
  if(level.gulag.maxuses >= 0) {
    var_0 = self.gulaguses;

    if(!isDefined(var_0))
      var_0 = 0;

    if(var_0 >= level.gulag.maxuses)
      return 0;
  }

  return 1;
}

trygulagspawn() {
  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    return 0;

  if(istrue(self.gulag))
    return 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasrespawntoken() && !_encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_12CB6()) {
    thread playergulagautowin("_encstr_AF390E193B6354506C5EE17F02498808", undefined, 1, 1);
    return 1;
  }

  if(!_id_12517())
    return 0;

  if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_86D90E342CE676ABC6C29D3ABDD6B29B())
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_encstr_8205111BD158BFA34162A5C131A7055F73FB53();

  thread initplayerjail(1);
  return 1;
}

_id_12517() {
  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    return 0;

  if(istrue(self.gulag))
    return 0;

  if(!istrue(level.usegulag))
    return 0;

  if(istrue(level.gulag.shutdown) && !_id_125E6())
    return 0;

  if(getdvarint("_encstr_92FD1C6B801AEE65D8BFD9720B0E0A63AB735B3F4310593B62A3EED37BE0", 0))
    return 0;

  if(!checkgulagusecount() && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_86D90E342CE676ABC6C29D3ABDD6B29B())
    return 0;

  return 1;
}

playergulaghud(var_0) {
  if(isDefined(var_0.fightover) && !var_0.fightover)
    _id_1267A(var_0);

  if(isDefined(var_0.fightover) && !var_0.fightover && isDefined(var_0.time) && var_0.time > 0) {
    var_1 = var_0.time;

    if(!istrue(var_0.overtime)) {
      var_2 = respawn_scriptible_carriable_wait();
      var_1 = var_1 - var_2;
    }

    self setclientomnvar("_encstr_8D571B1BFC3812436F39E50967FFD81A37DB174037CBF8394EB1277D32", gettime() + int(var_1 * 1000));
  } else
    self setclientomnvar("_encstr_8D571B1BFC3812436F39E50967FFD81A37DB174037CBF8394EB1277D32", 0);
}

updatematchtimerhud(var_0, var_1) {
  _updatematchtimerhudinternal(var_0.arenaplayers, var_1);
  _updatematchtimerhudinternal(var_0.jailedplayers, var_1);
}

_updatematchtimerhudinternal(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_1 > 0) {
      var_3 setclientomnvar("_encstr_8D571B1BFC3812436F39E50967FFD81A37DB174037CBF8394EB1277D32", gettime() + int(var_1 * 1000));
      continue;
    }

    var_3 setclientomnvar("_encstr_8D571B1BFC3812436F39E50967FFD81A37DB174037CBF8394EB1277D32", 0);
  }
}

updatematchqueuepositions(var_0) {
  for(var_1 = 2; var_1 <= level.gulag.maxplayers; var_1 = var_1 + 2) {
    var_2 = [];

    foreach(var_4 in var_0.jailedplayers) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = 0;

      foreach(var_12, var_7 in var_2) {
        if(var_7.size >= var_1) {
          continue;
        }
        var_8 = 0;

        foreach(var_10 in var_7) {
          if(var_10.team == var_4.team) {
            var_8 = 1;
            break;
          }
        }

        if(!var_8) {
          var_5 = 1;
          var_4.gulagposition = var_12 + 1;
          var_2[var_12][var_2[var_12].size] = var_4;
          break;
        }
      }

      if(!var_5) {
        var_4.gulagposition = var_2.size + 1;
        var_2[var_2.size] = [var_4];
      }
    }

    var_0.matches = var_2;

    if(var_2.size <= level.gulag.maxqueue) {
      break;
    }
  }

  _id_13FC1(var_0);
}

playerwatchdisconnect(var_0) {
  self endon("_encstr_AF760A0FBD782BDA13AA7FE5");
  self endon("_encstr_91ED0AECABC60B3BEB95CD23");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self) && istrue(self.gulagarena)) {
    return;
  }
  if(isDefined(self)) {
    if(istrue(self.gulagarena))
      var_0.arenaplayers = scripts\engine\utility::array_remove(var_0.arenaplayers, self);
    else if(istrue(self.jailed))
      var_0.jailedplayers = scripts\engine\utility::array_remove(var_0.jailedplayers, self);

    playerdestroyhud(var_0);
  } else {
    var_0.jailedplayers = scripts\engine\utility::array_removeundefined(var_0.jailedplayers);
    var_0.arenaplayers = scripts\engine\utility::array_removeundefined(var_0.arenaplayers);
  }

  updatematchqueuepositions(var_0);
}

playerdestroyhud(var_0) {
  self setclientomnvar("_encstr_8D571B1BFC3812436F39E50967FFD81A37DB174037CBF8394EB1277D32", 0);

  if(isDefined(var_0))
    _id_12526(var_0);

  if(isDefined(self.gulagjailbreakhud))
    self.gulagjailbreakhud destroy();

  self.set_relic_team_proximity = undefined;
}

setplayervargulag(var_0) {
  if(isDefined(self.gulag) && self.gulag == var_0) {
    return;
  }
  self.gulag = var_0;
  level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
}

setplayervargulagarena(var_0, var_1) {
  if(isDefined(self.gulagarena) && self.gulagarena == var_0) {
    return;
  }
  if(!istrue(var_1))
    _id_131A1(var_0);

  self.gulagarena = var_0;
  level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
}

_id_131A1(var_0) {
  if(istrue(var_0))
    self.game_extrainfo = self.game_extrainfo | 256;
  else
    self.game_extrainfo = self.game_extrainfo &~256;
}

_id_131AA(var_0) {
  if(isDefined(self.jailed) && self.jailed == var_0) {
    return;
  }
  _id_131A2(var_0);
  self.jailed = var_0;
  level notify("_encstr_817B1303D099169BE9905B591E71A35F47A84A8A90");
}

_id_131A2(var_0) {
  if(var_0)
    self.game_extrainfo = self.game_extrainfo | 128;
  else
    self.game_extrainfo = self.game_extrainfo &~128;
}

_id_1319F(var_0) {
  if(var_0.set_relic_oneclip > 7) {
    return;
  }
  var_1 = 3;
  var_2 = 3;
  var_3 = int(pow(2, var_1)) - 1;
  var_4 = (var_0.set_relic_oneclip &var_3) << var_2;
  var_5 = ~(var_3 << var_2);
  var_6 = self.game_extrainfo;
  var_7 = var_6 &var_5;
  var_8 = var_7 + var_4;
  self.game_extrainfo = var_8;
}

startbetting(var_0, var_1) {
  if(!level.gulag.betting)
    return undefined;

  var_2 = spawnStruct();
  var_2.fighters = var_1;
  var_2.bets = [];
  var_2.bettingopen = 1;
  var_2 thread show_betting_to_players(var_0);
  return var_2;
}

show_betting_to_players(var_0) {
  self endon("_encstr_8D2A0C6510BD28A16D03D3877D3F");

  for(;;) {
    var_1 = getbettingplayers(var_0, self);

    foreach(var_3 in var_1) {
      if(isbot(var_3)) {
        continue;
      }
      if(isDefined(self.bets[var_3.guid])) {
        continue;
      }
      thread showbettinghud(var_0, var_3);
    }

    var_0 waittill("_encstr_B40415E036B02FACC97D58C88CCA91D7D1F6EB4DC2B436");
  }
}

showbettinghud(var_0, var_1) {
  self endon("_encstr_8D2A0C6510BD28A16D03D3877D3F");
  var_2 = spawnStruct();
  var_2.owner = var_1;
  self.bets[var_1.guid] = var_2;
  var_2._id_125F9 = 0;
  var_2._id_12652 = 1;
  var_3 = 0;
  var_4 = 50;
  var_2.hudavailable = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.2);
  var_2.hudavailable scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_3, var_4);
  var_2.hudavailable.label = &"_encstr_A21B1BD40AEB3AAA988274AF12A8A88A92C9E8E550CA05A4C450123151";
  var_2.hudavailable scripts\mp\hud::fontpulseinit();
  var_2.spawn_truck_techo = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.2);
  var_2.spawn_truck_techo scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_3, var_4 - 15);
  var_2.spawn_truck_techo.label = &"_encstr_82DA1BD9F871ACC57CB797F79E6FB7C10B339C1EB951E1612ED9AD4951";
  var_2.spawn_truck_techo.alpha = 0.0;
  var_5 = -90;
  var_6 = 65;
  var_2.spawn_trap_room_ent = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.2);
  var_2.spawn_trap_room_ent scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_5, var_6);
  var_2.spawn_trap_room_ent.label = &"_encstr_AC562350013FAF2FFCCF2F3F76E51323BB69780EF953D3CFB4A0330A9D0D47BF6FD1C010F1";
  var_2.spawn_trap_room_ent.alpha = 1.0;
  var_2.spawnboardroom_miniguns = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.25);
  var_2.spawnboardroom_miniguns scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_5 - 20, var_6 + 12);
  var_2.spawnboardroom_miniguns.label = &"_encstr_A6701EC17291EFF7145771B93375AFB1986D4C481DF821FFDF2B79A92F4D2479";
  var_2.spawnboardroom_miniguns setvalue(randomint(60) + 20);
  var_2.spawnboardroom_miniguns.alpha = 1.0;
  var_2.spawnboardroomblueprintweapons = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.25);
  var_2.spawnboardroomblueprintweapons scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_5 + 20, var_6 + 12);
  var_2.spawnboardroomblueprintweapons.label = &"_encstr_A2721C6A28D7E855895074AF90A215A292931D79D34422A9F549504592A7";
  var_2.spawnboardroomblueprintweapons setvalue(randomint(10) + 1);
  var_2.spawnboardroomblueprintweapons.alpha = 1.0;
  var_2.spawnchoppers = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
  var_2.spawnchoppers scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_5, var_6 + 25);
  var_2.spawnchoppers.label = &"_encstr_B40101";

  if(isDefined(self.fighters[var_2._id_125F9]))
    var_2.spawnchoppers setplayernamestring(self.fighters[var_2._id_125F9]);

  var_2.spawnchoppers.alpha = 1.0;
  var_2.spawn_techo_lmgs = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
  var_2.spawn_techo_lmgs scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_5, var_6 + 40);
  var_2.spawn_techo_lmgs.label = &"_encstr_81141DED7011EF2704F177DE90D901435185DFE5A80BE2CFE52D2BF95A586C";
  var_2.spawn_techo_lmgs.alpha = 0.0;
  var_2.spawn_techo_lmgs scripts\mp\hud::fontpulseinit();
  var_7 = 90;
  var_8 = 65;
  var_2.spawn_truck_group_on_proximity = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.2);
  var_2.spawn_truck_group_on_proximity scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_7, var_8);
  var_2.spawn_truck_group_on_proximity.label = &"_encstr_B29F24F45927F4F95D09CF877277B92527100D30E0A7B571242ECF955DAE7965D7A944A5A85B";
  var_2.spawn_truck_group_on_proximity.alpha = 1.0;
  var_2.spawnboardroom_specialist = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.25);
  var_2.spawnboardroom_specialist scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_7 - 20, var_8 + 12);
  var_2.spawnboardroom_specialist.label = &"_encstr_A6701EC17291EFF7145771B93375AFB1986D4C481DF821FFDF2B79A92F4D2479";
  var_2.spawnboardroom_specialist setvalue(randomint(60) + 20);
  var_2.spawnboardroom_specialist.alpha = 1.0;
  var_2.spawnbunkerloot = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.25);
  var_2.spawnbunkerloot scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_7 + 20, var_8 + 12);
  var_2.spawnbunkerloot.label = &"_encstr_A2721C6A28D7E855895074AF90A215A292931D79D34422A9F549504592A7";
  var_2.spawnbunkerloot setvalue(randomint(10) + 1);
  var_2.spawnbunkerloot.alpha = 1.0;
  var_2.spawnclientdevtest = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
  var_2.spawnclientdevtest scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_7, var_8 + 25);
  var_2.spawnclientdevtest.label = &"_encstr_B40101";

  if(isDefined(self.fighters[var_2._id_12652]))
    var_2.spawnclientdevtest setplayernamestring(self.fighters[var_2._id_12652]);

  var_2.spawnclientdevtest.alpha = 1.0;
  var_2.spawn_techo_turret = var_1 scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
  var_2.spawn_techo_turret scripts\mp\hud_util::setpoint("_encstr_AC190439DF9A", "_encstr_AC190439DF9A", var_7, var_8 + 40);
  var_2.spawn_techo_turret.label = &"_encstr_81141DED7011EF2704F177DE90D901435185DFE5A80BE2CFE52D2BF95A586C";
  var_2.spawn_techo_turret.alpha = 0.0;
  var_2.spawn_techo_turret scripts\mp\hud::fontpulseinit();
  var_2.playerbeton = -1;
  var_2.amount = 0;
  updatebethud(var_2);
  thread watchbetplaced(var_2);
  thread watchbetclear(var_2);
}

watchbetclear(var_0) {
  self endon("_encstr_8D2A0C6510BD28A16D03D3877D3F");
  var_0.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = "_encstr_AD84099EA1D555C857D7B3";
  thread notifyonplayercommandbetting(var_0.owner, var_1, "_encstr_874D09DEF0893FEF70E73C");
  thread notifyonplayercommandbetting(var_0.owner, var_1, "_encstr_97410B23BD6B976233901AF2F8");

  for(;;) {
    var_0.owner waittill(var_1);

    if(var_0.playerbeton == -1) {
      continue;
    }
    var_0.playerbeton = -1;
    var_0.amount = 0;
    updatebethud(var_0);
  }
}

watchbetplaced(var_0) {
  self endon("_encstr_8D2A0C6510BD28A16D03D3877D3F");
  var_0.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = "_encstr_87430EEE326B29A8F1D7527AB03557D0";
  var_2 = "_encstr_880F0F19B55508F1F8BFA5DFFA575FEC81";
  thread notifyonplayercommandbetting(var_0.owner, var_1, "_encstr_8E5F0795E6AD7BAD2B");
  thread notifyonplayercommandbetting(var_0.owner, var_2, "_encstr_BE4C08954E2B63BD0B23");
  thread notifyonplayercommandbetting(var_0.owner, var_2, "_encstr_9B0D065699E485D9");

  for(;;) {
    var_3 = var_0.owner scripts\engine\utility::_id_143AD(var_1, var_2);
    var_4 = -1;

    if(var_3 == var_1)
      var_4 = var_0._id_125F9;
    else if(var_3 == var_2)
      var_4 = var_0._id_12652;

    if(var_0.playerbeton == var_4)
      var_5 = var_0.amount + 1;
    else
      var_5 = 1;

    if(var_5 > var_0.owner.plundercount) {
      betchangefail(var_0);
      continue;
    }

    var_0.amount = var_5;
    var_0.playerbeton = var_4;
    updatebethud(var_0);
  }
}

notifyonplayercommandbetting(var_0, var_1, var_2) {
  var_0 notifyonplayercommand(var_1, var_2);
  self waittill("_encstr_8D2A0C6510BD28A16D03D3877D3F");

  if(isDefined(var_0))
    var_0 notifyonplayercommandremove(var_1, var_2);
}

betchangefail(var_0) {
  var_0.owner playlocalsound("_encstr_ACA80FED33315369193F78E1B96C1575FB");
  var_0.hudavailable thread scripts\mp\hud::fontpulse(var_0.owner);
}

updatebethud(var_0) {
  var_1 = 100;
  var_0.hudavailable setvalue((var_0.owner.plundercount - var_0.amount) * var_1);

  if(var_0.playerbeton == -1) {
    var_0.spawn_trap_room_ent.label = &"_encstr_97DB210D77DF103DE47967FF993DF4E92BE0072DD683596F2D1977B3991587309B0C5B";
    var_0.spawn_truck_group_on_proximity.label = &"_encstr_8708225DE759DF43CCA974B0D6BD3B8CB744F1F0B29561D7DFB099B64F2FAE49618898FB";
    var_0.spawn_truck_techo.alpha = 0.0;
    var_0.spawn_techo_lmgs setvalue(0);
    var_0.spawn_techo_turret setvalue(0);
    var_0.spawn_techo_lmgs.alpha = 0.0;
    var_0.spawn_techo_turret.alpha = 0.0;
  } else if(var_0.playerbeton == var_0._id_125F9) {
    var_0.spawn_trap_room_ent.label = &"_encstr_AC562350013FAF2FFCCF2F3F76E51323BB69780EF953D3CFB4A0330A9D0D47BF6FD1C010F1";
    var_0.spawn_truck_group_on_proximity.label = &"_encstr_8708225DE759DF43CCA974B0D6BD3B8CB744F1F0B29561D7DFB099B64F2FAE49618898FB";
    var_0.spawn_truck_techo.alpha = 1.0;
    var_0.spawn_techo_lmgs setvalue(var_0.amount * var_1);
    var_0.spawn_techo_lmgs.alpha = 1.0;
    var_0.spawn_techo_turret.alpha = 0.0;
  } else if(var_0.playerbeton == var_0._id_12652) {
    var_0.spawn_trap_room_ent.label = &"_encstr_97DB210D77DF103DE47967FF993DF4E92BE0072DD683596F2D1977B3991587309B0C5B";
    var_0.spawn_truck_group_on_proximity.label = &"_encstr_B29F24F45927F4F95D09CF877277B92527100D30E0A7B571242ECF955DAE7965D7A944A5A85B";
    var_0.spawn_truck_techo.alpha = 1.0;
    var_0.spawn_techo_turret setvalue(var_0.amount * var_1);
    var_0.spawn_techo_turret.alpha = 1.0;
    var_0.spawn_techo_lmgs.alpha = 0.0;
  }
}

cleanupbethud(var_0, var_1) {
  var_0 notify("_encstr_B1170ED8D89516B9AA0712593A42AB19");

  if(isDefined(var_1)) {
    var_0 endon("_encstr_B1170ED8D89516B9AA0712593A42AB19");
    wait(var_1);
  }

  var_2 = [var_0.spawn_trap_room_ent, var_0.spawn_truck_group_on_proximity, var_0.spawn_techo_lmgs, var_0.spawn_techo_turret, var_0.spawnchoppers, var_0.spawnclientdevtest, var_0.spawnboardroom_miniguns, var_0.spawnboardroomblueprintweapons, var_0.spawnboardroom_specialist, var_0.spawnbunkerloot, var_0.hudavailable, var_0.spawn_truck_techo];

  foreach(var_4 in var_2) {
    if(isDefined(var_4))
      var_4 destroy();
  }
}

watchbetbutton(var_0, var_1, var_2, var_3) {
  self endon("_encstr_8D2A0C6510BD28A16D03D3877D3F");

  for(;;) {
    var_1 waittill(var_2);
    var_0 notify("_encstr_AFD30A32358CF813E21E7F09", var_3);
  }
}

endbetting(var_0, var_1) {
  if(!isDefined(var_1) || !istrue(var_1.bettingopen)) {
    return;
  }
  var_1 notify("_encstr_8D2A0C6510BD28A16D03D3877D3F");
  var_1.bettingopen = 0;

  foreach(var_3 in var_1.bets) {
    var_4 = [var_3.spawn_truck_techo, var_3.hudavailable, var_3.spawnboardroom_specialist, var_3.spawnboardroom_miniguns, var_3.spawnbunkerloot, var_3.spawnboardroomblueprintweapons, var_3.spawn_trap_room_ent, var_3.spawn_truck_group_on_proximity];

    if(var_3.playerbeton != -1) {
      if(var_3.playerbeton == var_3._id_125F9) {
        var_4[var_4.size] = var_3.spawnclientdevtest;
        var_4[var_4.size] = var_3.spawn_truck_group_on_proximity;
        var_4[var_4.size] = var_3.spawn_techo_turret;
      } else if(var_3.playerbeton == var_3._id_12652) {
        var_4[var_4.size] = var_3.spawnchoppers;
        var_4[var_4.size] = var_3.spawn_trap_room_ent;
        var_4[var_4.size] = var_3.spawn_techo_lmgs;
      }
    } else
      cleanupbethud(var_3, 0.0);

    foreach(var_6 in var_4) {
      if(isDefined(var_6))
        var_6 destroy();
    }
  }

  updateoutlines(var_0);
}

payoutremainingbets(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_2 = -1;

  if(isDefined(var_0))
    var_2 = var_0.fighterindex;

  foreach(var_4 in var_1.bets) {
    if(var_4.playerbeton != -1 && isDefined(var_4.owner) && !istrue(var_4.paidout)) {
      var_5 = var_4.playerbeton == var_2;
      _completebet(var_1, var_4, var_5);
    }

    thread cleanupbethud(var_4, 2.5);
  }
}

_completebet(var_0, var_1, var_2) {
  var_3 = (0, 1, 0);
  var_4 = (1, 0, 0);
  var_1.paidout = 1;

  if(var_2) {
    var_1.owner _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(var_1.owner.plundercount + var_1.amount);

    if(var_1.playerbeton == var_1._id_125F9) {
      var_1.spawnchoppers.color = var_3;
      var_1.spawnchoppers.label = &"_encstr_9ACB1FF307B0DFFF44D9EDAE7A2FA4C51BA4548D37A33789E75AC9CF93E95BB541";
      var_1.spawn_techo_lmgs.color = var_3;
      var_1.spawn_techo_lmgs.label = &"_encstr_91161C350AEB74AA31051D7D90A88A45A49374F20AD4F4AA9C15EBABE927";
      var_1.owner playlocalsound("_encstr_A3C80F4AF0E9DFB1709519F44369C36705");
      var_1.spawn_techo_lmgs thread scripts\mp\hud::fontpulse(var_1.owner);
    } else if(var_1.playerbeton == var_1._id_12652) {
      var_1.spawnclientdevtest.color = var_3;
      var_1.spawnclientdevtest.label = &"_encstr_9ACB1FF307B0DFFF44D9EDAE7A2FA4C51BA4548D37A33789E75AC9CF93E95BB541";
      var_1.spawn_techo_turret.color = var_3;
      var_1.spawn_techo_turret.label = &"_encstr_91161C350AEB74AA31051D7D90A88A45A49374F20AD4F4AA9C15EBABE927";
      var_1.owner playlocalsound("_encstr_A3C80F4AF0E9DFB1709519F44369C36705");
      var_1.spawn_techo_turret thread scripts\mp\hud::fontpulse(var_1.owner);
    }
  } else {
    if(isalive(var_1.owner)) {
      var_5 = var_1.owner.plundercount - var_1.amount;
      var_5 = int(max(0, var_5));
      var_1.owner _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::playersetplundercount(var_5);
    }

    if(var_1.playerbeton == var_1._id_125F9) {
      var_1.spawnchoppers.color = var_4;
      var_1.spawnchoppers.label = &"_encstr_A5401E10CF68D79BB15BA7B775D11343BBE448BE95CB9F84816587BC97B96F13";
      var_1.spawn_techo_lmgs.color = var_4;
      var_1.spawn_techo_lmgs.label = &"_encstr_BAF41D350AD7D1552682E8F524A88A8A29E4A3972853E9552745EBC49E4D8A";
      var_1.spawn_techo_lmgs thread scripts\mp\hud::fontpulse(var_1.owner);
    } else if(var_1.playerbeton == var_1._id_12652) {
      var_1.spawnclientdevtest.color = var_4;
      var_1.spawnclientdevtest.label = &"_encstr_A5401E10CF68D79BB15BA7B775D11343BBE448BE95CB9F84816587BC97B96F13";
      var_1.spawn_techo_turret.color = var_4;
      var_1.spawn_techo_turret.label = &"_encstr_BAF41D350AD7D1552682E8F524A88A8A29E4A3972853E9552745EBC49E4D8A";
      var_1.spawn_techo_turret thread scripts\mp\hud::fontpulse(var_1.owner);
    }
  }

  var_6 = var_0.fighters[var_1.playerbeton];

  if(isDefined(var_6))
    var_6 hudoutlinedisableforclient(var_1.owner);
}

getbettingplayers(var_0, var_1) {
  var_2 = var_0.jailedplayers;

  if(level.gulag.betting > 1) {
    foreach(var_4 in var_1.fighters)
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

payoutbet(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_4 in var_0.bets) {
    if(var_4.playerbeton == var_1.fighterindex && isDefined(var_4.owner) && !istrue(var_4.paidout)) {
      _completebet(var_0, var_4, var_2);
      thread cleanupbethud(var_4, 2.5);
    }
  }
}

rock_used(var_0) {
  var_1 = self.arena;
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", 4);
  wait 2;

  if(isDefined(var_0))
    var_0 delete();

  if(istrue(level.usegulag) && level.gulag._id_1407F)
    spawnrock(var_1);
}

spawnrocks(var_0) {
  var_0.rocks = getentitylessscriptablearrayinradius(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.rocks.size == 0 || !level.gulag._id_1407F) {
    for(var_1 = 0; var_1 < var_0.rocks.size; var_1++) {
      var_2 = var_0.rocks[var_1];
      var_2 setscriptablepartstate("_encstr_BA3B0C5DFB65E767E5292887339F", "_encstr_95DF070DD22319CA9B");
    }

    return;
  }

  var_3 = 20;

  if(var_0.rocks.size < var_3)
    var_3 = var_0.rocks.size;

  var_0.rocks = scripts\engine\utility::array_randomize(var_0.rocks);
  var_0.rockcounter = var_3;
  var_4 = getdvarint("_encstr_81E5103312CAC71B48AF0B1639E3F7E643BB", 1) == 0;

  for(var_1 = 0; var_1 < var_0.rocks.size; var_1++) {
    var_2 = var_0.rocks[var_1];
    var_2.arena = var_0;

    if(var_1 >= var_3 || var_4)
      var_2 setscriptablepartstate("_encstr_BA3B0C5DFB65E767E5292887339F", "_encstr_95DF070DD22319CA9B");
  }
}

rockused(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isDefined(var_3)) {
    return;
  }
  var_5 = getcompleteweaponname("_encstr_86B108781A36271E4F70");

  if(var_3 hasweapon(var_5) && var_3 getammocount(var_5) > 0) {
    return;
  }
  var_0 setscriptablepartstate("_encstr_BA3B0C5DFB65E767E5292887339F", "_encstr_95DF070DD22319CA9B");
  var_3 thread _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerplaypickupanim();
  var_3 scripts\mp\equipment::giveequipment("_encstr_92620B68531B9B432F2AE8D61B", "_encstr_BA7F0830B3A7859B60B0");
  var_3 playlocalsound("_encstr_99360F4C937D39EDD85BD738D2B1D6AEE0");
}

spawnrock(var_0) {
  if(istrue(var_0.shutdown) || var_0.rocks.size == 0) {
    return;
  }
  var_1 = var_0.rocks[var_0.rockcounter];
  var_1 setscriptablepartstate("_encstr_BA3B0C5DFB65E767E5292887339F", "_encstr_BE8B08E323FB2BCD6268");
  var_0.rockcounter++;

  if(var_0.rockcounter >= var_0.rocks.size)
    var_0.rockcounter = 0;
}

playertakeawayrock(var_0) {
  var_1 = getcompleteweaponname("_encstr_86B108781A36271E4F70");

  if(self hasweapon(var_1)) {
    self takeweapon(var_1);
    self clearaccessory();

    if(level.gulag._id_1407F)
      spawnrock(var_0);
  }
}

_id_126F3(var_0) {
  var_1 = self;

  if(!isDefined(level.pickup_truck_initdamage)) {
    return;
  }
  if(isDefined(level.br_circle.circleindex)) {
    var_2 = level.br_circle.circleindex + 1;

    if(var_2 > level.phase_five_combat)
      return;
  }

  var_3 = 0;

  if(isDefined(level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"]))
    var_3 = var_3 + level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"].size;

  if(isDefined(level.vehicle.instances["_encstr_83F40783ADF1D14AA3"]))
    var_3 = var_3 + level.vehicle.instances["_encstr_83F40783ADF1D14AA3"].size;

  if(var_3 >= level.pickup_truck_initdamage) {
    return;
  }
  if(istrue(var_1._id_145BF)) {
    return;
  }
  var_4 = "_encstr_8C500ABA9B23CACC2D37AC8C";

  if(isDefined(var_1.currentweapon))
    var_4 = var_1.currentweapon.basename;

  var_5 = "_encstr_8C500ABA9B23CACC2D37AC8C";

  if(isDefined(var_1.name))
    var_5 = var_1.name;

  if(level.ph_setfinalkillcamwinner > 0.0 && randomfloat(1.0) < level.ph_setfinalkillcamwinner) {
    logstring("_encstr_A39C2EDE27FC51AFE15F3739679BC0487EC72910D54040B53F322F0B77229DD01B8EA5C1FB6770FD921A2B0F877A7A92" + var_0 + "_encstr_97C00F91A81360759E9BC0A023E72D9262" + var_5 + "_encstr_97350F6063D974C0907B011F0320AAEA19" + var_4);
    var_1._id_12C9E = var_0;
    var_1._id_145BF = 1;
    return;
  }

  logstring("_encstr_88F94278155B095A4F7B06CBEF579B40F57919348BD2CAA988DE4C5F99FBBAED310C52B357F04867403B514221AB80E7759E03A67D201E80906843192B9018F3AFFBAA12" + var_5 + "_encstr_97350F6063D974C0907B011F0320AAEA19" + var_4);
  var_1._id_12C9E = undefined;
  var_1._id_145BF = undefined;
}

_id_1268C() {
  thread gulagfadefromblack(3.0);

  if(isDefined(level.pilot_tag))
    var_0 = [[level.pilot_tag]]();
  else
    var_0 = _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::risk_modifyflagstieronrespawn(0.9, 0.95);

  var_1 = level.br_circle.circleindex + 1;

  if(!isDefined(level.br_level.default_class_chosen[var_1]))
    var_1 = level.br_circle.circleindex;

  var_2 = vectortoyaw(level.br_level.default_class_chosen[var_1] - var_0);
  var_3 = spawnStruct();
  var_3.origin = (var_0[0], var_0[1], 11500);
  var_3.angles = (0, var_2, 0);
  var_3.cannotbesuspended = 1;
  var_4 = spawnStruct();

  if(isDefined(self._id_12C9F))
    var_5 = self._id_12C9F;
  else {
    var_5 = "_encstr_BDC80A5437EAD749519A6068";

    if(randomfloat(1.0) > level.ph_endgame)
      var_5 = "_encstr_83F40783ADF1D14AA3";
  }

  var_3.targetname = var_5;

  switch (var_5) {
    case "_encstr_83F40783ADF1D14AA3":
      var_3.modelname = "_encstr_871219BCED2B66779B69C8E072690BF82BAFCEB84DBBE9BDB9F348";
      var_3.vehicletype = "_encstr_8CEE061DAC01B8F7";
      var_6 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_mp_version_of_vehicle(var_3, var_4);
      break;
    case "_encstr_BDC80A5437EAD749519A6068":
      var_3.modelname = "_encstr_821619CEAC0DAFCD1AD7ADB4B1F5582D9CFA9185D8E034B0F5EE9E";
      var_3.vehicletype = "_encstr_85100F7376B718BBA15A43D8058F09CC4A";
      var_6 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gametype_set_role(var_3, var_4);
      break;
    default:
      return;
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_enter(var_6, "_encstr_A266062032BD7723", self);
}

gettangentoncirclefrompoint(var_0, var_1, var_2) {
  var_3 = var_2[0] - var_0[0];
  var_4 = var_2[1] - var_0[1];
  var_5 = var_1;
  var_6 = var_3 * var_3;
  var_7 = var_4 * var_4;
  var_8 = var_5 * var_5;
  var_9 = var_6 + var_7 - var_8;
  var_10 = undefined;
  var_11 = 1;

  if(var_9 > 0) {
    var_12 = (var_8 * var_3 - var_5 * var_4 * sqrt(var_6 + var_7 - var_8)) / (var_6 + var_7);
    var_13 = (var_8 * var_4 + var_5 * var_3 * sqrt(var_6 + var_7 - var_8)) / (var_6 + var_7);
    var_10 = (var_12, var_13, var_2[2]) + (var_0[0], var_0[1], 0);
  } else {
    var_14 = vectorNormalize((var_3, var_4, 0));
    var_15 = var_0 + var_14 * var_1;
    var_10 = (var_15[0], var_15[1], var_2[2]);
    var_11 = 0;
  }

  return [var_10, var_11];
}

spawnac130() {
  if(!istrue(level.gulag.planerespawn)) {
    return;
  }
  level waittill("_encstr_8B7A1187533F0D1369DFC88EF81BD79B148B8D");

  if(!istrue(level.br_infils_disabled))
    wait 10;

  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(level.br_ac130))
    var_0 = level.br_ac130.startpt;
  else {
    var_2 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::createtestc130path();
    var_0 = var_2.startpt;
  }

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent))
    var_1 = level.br_circle.safecircleent.origin[2];
  else
    var_1 = level.br_level.br_circleradii[0];

  var_1 = var_1 - 100;
  [var_4, var_5] = gettangentoncirclefrompoint(level.br_level.br_mapcenter, var_1, var_0);
  var_6 = 0;
  var_7 = 0;

  if(var_5) {
    var_6 = distance(var_0, var_4);
    var_7 = var_6 / _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed();
  }

  var_8 = (level.br_level.br_mapcenter[0], level.br_level.br_mapcenter[1], var_0[2]);
  level.gulag.ac130linker = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8);
  level.gulag.ac130linker setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.gulag.ac130linker.radius = var_1;
  level.gulag.ac130 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::gunship_spawn(var_0, var_4, var_7, 0, ::ac130handlemovement);
  level.gulag.ac130 thread ac130setupanim();
  level.gulag.ac130.riders = [];

  if(var_7 <= 0) {
    var_9 = var_4 - level.br_level.br_mapcenter;
    var_10 = vectorNormalize((var_9[0], var_9[1], 0));
    var_11 = vectortoangles(var_10);
    level.gulag.ac130 unlink();
    level.gulag.ac130.angles = (0, var_11[1] + 90, 0);
    level.gulag.ac130.origin = var_4;
    level.gulag.ac130 thread ac130linkandspin();
  }
}

ac130setupanim() {
  var_0 = spawnStruct();
  self.animstruct = var_0;
  var_0.movingc130 = self;
  _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::spawnplayerpositionparentent(var_0, self);
  _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::spawnplayerpositionent(var_0, "_encstr_AFAA09344628DA52A72756");
  _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::playac130infilloopanims(var_0);
}

ac130handlemovement(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self playLoopSound("_encstr_97E10C4C93D7C21B4C6660F5D807");

  if(var_1 > 0) {
    self moveTo(var_0, var_1, 0, 0);
    wait(var_1);
  }

  thread ac130linkandspin();
}

ac130linkandspin() {
  self notify("_encstr_83AC11DF66691F2021DFB604482820D6DBE4CB");
  self endon("_encstr_83AC11DF66691F2021DFB604482820D6DBE4CB");
  level.gulag.ac130linker endon("_encstr_AD75063D571AE108");
  var_0 = 6.28318;
  var_1 = _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed();
  var_2 = level.gulag.ac130linker.radius;
  var_3 = var_0 * var_2 / var_1;
  self linkTo(level.gulag.ac130linker, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  if(var_3 <= 0) {
    return;
  }
  for(;;) {
    level.gulag.ac130linker rotateYaw(360, var_3);
    wait(var_3);
  }
}

waittillallarenasshutdown() {
  var_0 = level.gulag.arenas.size;

  if(!istrue(level.gulag.multiarena))
    var_0 = 1;

  for(;;) {
    var_1 = 0;

    for(var_2 = 0; var_2 < var_0; var_2++) {
      var_3 = level.gulag.arenas[var_2];

      if(!istrue(var_3.shutdown)) {
        var_1 = 1;
        break;
      }
    }

    if(!var_1) {
      return;
    }
    waitframe();
  }
}

makeac130flyaway() {
  if(!istrue(level.gulag.planerespawn)) {
    return;
  }
  var_0 = gettime();
  waittillallarenasshutdown();
  var_1 = gettime();
  wait(getdvarint("_encstr_8FF117A33F9B7905BECF5B43596B152AD3D1DB9DD9AB97A703", 15));
  waittillframeend;

  foreach(var_3 in level.gulag.ac130.riders) {
    if(isDefined(var_3)) {
      var_3.jumptype = "_encstr_B61805B97B36DB";
      var_3 notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
    }
  }

  while(level.gulag.ac130.riders.size > 0)
    waitframe();

  var_5 = level.gulag.ac130.origin;
  var_6 = anglesToForward(level.gulag.ac130.angles);
  var_7 = level.br_level.br_circleradii[0] * 2;
  var_8 = var_5 + var_6 * var_7;
  var_8 = var_8 + var_6 * _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed();
  var_9 = distance(var_5, var_8);
  var_10 = var_9 / _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::getc130speed();
  level.gulag.ac130 notify("_encstr_83AC11DF66691F2021DFB604482820D6DBE4CB");
  level.gulag.ac130 unlink();
  level.gulag.ac130 moveTo(var_8, var_10, 0, 0);
  wait(var_10);
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::cleanac130struct(level.gulag.ac130.animstruct);

  if(isDefined(level.gulag.ac130))
    level.gulag.ac130 delete();

  if(isDefined(level.gulag.ac130linker))
    level.gulag.ac130linker delete();
}

transitioncircle(var_0, var_1) {
  if(!istrue(level.gulag.planerespawn)) {
    return;
  }
  if(!isDefined(level.gulag.ac130) || !isDefined(level.gulag.ac130linker)) {
    return;
  }
  var_2 = (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], level.gulag.ac130linker.origin[2]);
  var_0 = var_0 - 100;

  if(level.gulag.ac130linker.radius != var_0) {
    var_3 = vectorNormalize(level.gulag.ac130linker.origin - level.gulag.ac130.origin);
    var_4 = level.gulag.ac130.origin + var_3 * var_0;
    level.gulag.ac130 unlink();
    level.gulag.ac130linker.origin = var_4;
    level.gulag.ac130linker.radius = var_0;
    level.gulag.ac130linker dontinterpolate();
    level.gulag.ac130 thread ac130linkandspin();
  }

  level.gulag.ac130linker moveTo(var_2, var_1);
  wait(var_1);
}

playersetupac130() {
  self.infilanimindex = 1;
  self.isjumpmaster = 0;
  _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::playerlinktopositionent(level.gulag.ac130.animstruct);
  thread _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::playerplayinfilloopanim(level.gulag.ac130.animstruct);
  thread playerputinc130(level.gulag.ac130);
  _encstr_AD2A23CDC64EA50E3A3779D61CE5EC16DA591DCB07569B5E98C9AFA59BCCD2D8E617B39B36::playersetupcontrolsforinfil(1);
  thread playerac130cleanup();
  thread playerautodeployaftertime();
  thread playerspawnprotectionac130();
  level.gulag.ac130.riders[level.gulag.ac130.riders.size] = self;
}

playerputinc130(var_0) {
  self.angles = var_0.angles;
  thread listenjump(var_0);
  thread _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::listenkick(var_0, 0);
  scripts\mp\utility\game::_id_131A3(self, 1);
  self.br_infil_type = "_encstr_969105B1C4CC81";
  thread _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::orbitcam(var_0);
}

listenjump(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8F860C1B58DCB1B28DEB6C4C6603");
  self endon("_encstr_8F7D08C66A0125438523");
  self.redeployenabled = 0;
  scripts\engine\utility::waittill_either("_encstr_BA0C0F6867D11F07BDF8D838A7C8DEDA82", "_encstr_AFBE141A8536DBFAD4D5DA07D7DCEDD8DBBE8D62990C");
  self.jumptype = "_encstr_B61805B97B36DB";
  thread _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::leaveplane(var_0, 0, self getplayerangles(), 0);
}

playerspawnprotectionac130() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.plotarmor = 1;
  _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::setplayervarinrespawnc130(1);
  waittillplayerdoneskydivingac130(self);
  self.plotarmor = undefined;
  _encstr_831221634036DF2F1B0A109A99F03F9128BF43E3DB7BCB684B93890E2A7BC2A2A86220::setplayervarinrespawnc130(0);
}

waittillplayerdoneskydivingac130(var_0) {
  var_0 endon("_encstr_B2E014A3966BCAEDAEE87DCED536B076FA168DC466C0");
  thread _waittillplayerdoneskydivingac130timeout(var_0);
  var_0 waittill("_encstr_831910EB8313CF31B9121BFFC3FECDF5800D");

  while(!var_0 isparachuting() && !var_0 isonground())
    waitframe();
}

_waittillplayerdoneskydivingac130timeout(var_0) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 scripts\engine\utility::_id_143BA(getdvarint("_encstr_8FF117A33F9B7905BECF5B43596B152AD3D1DB9DD9AB97A703", 15), "_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62", "_encstr_AFBE141A8536DBFAD4D5DA07D7DCEDD8DBBE8D62990C");
  wait 15;
  var_0 notify("_encstr_B2E014A3966BCAEDAEE87DCED536B076FA168DC466C0");
}

playerautodeployaftertime() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8F860C1B58DCB1B28DEB6C4C6603");
  self endon("_encstr_8F7D08C66A0125438523");
  wait(getdvarint("_encstr_8FF117A33F9B7905BECF5B43596B152AD3D1DB9DD9AB97A703", 15));
  self.jumptype = "_encstr_B61805B97B36DB";
  self notify("_encstr_8B160FE04BE855EF22B0921A5E0E0E1A62");
}

playerac130cleanup() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A7("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_AD75063D571AE108", "_encstr_8F860C1B58DCB1B28DEB6C4C6603", "_encstr_831910EB8313CF31B9121BFFC3FECDF5800D");

  if(!isDefined(level.gulag.ac130.riders)) {
    return;
  }
  if(isDefined(self))
    level.gulag.ac130.riders = scripts\engine\utility::array_remove(level.gulag.ac130.riders, self);
  else
    level.gulag.ac130.riders = scripts\engine\utility::array_removeundefined(level.gulag.ac130.riders);
}

playergulagautowin(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_5 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_5 notify("_encstr_B1E80FD9BAB1B076EB2C5DE87BF5EE5A37");

  if(istrue(var_5.respawningfromtoken)) {
    return;
  }
  [var_7, var_8] = var_5 _id_125C7(var_1, var_2, var_4, undefined, var_0);
  var_5.respawningfromtoken = 1;
  var_9 = var_5 _id_126E8();
  var_10 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::relic_nuketimer_gettimeformission() / 1000;
  var_11 = var_5 _id_125BE(0, var_10);
  var_12 = var_5 _id_1263E(var_11);
  self.forcespawnorigin = var_12;
  var_13 = _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_938917C18D85CB56391DAE8D85D928AED17B5DA5735D16D28E", var_1, var_2);

  if(!istrue(var_13)) {
    var_14 = 1.0;
    wait(var_14);
  }

  if(var_9)
    var_5 scripts\mp\utility\lower_message::setlowermessageomnvar(0);

  var_15 = 1.0;
  var_5 gulagfadetoblack(1);
  wait(var_15);
  var_5 scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
  var_5 scripts\mp\playerlogic::spawnplayer(undefined, 0);
  var_5 scripts\cp_mp\execution::_clearexecution();
  var_5 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::initplayer();
  var_5 _encstr_81E4253312CAAB53781F2E954096E76645ADE963D3EA4380AA45C7CB90A2E09B9F45C046E7D81B::_id_1252A();
  var_5.respawningfromtoken = undefined;

  if(!isDefined(var_1) && !istrue(var_3))
    var_5 thread _id_13DCB(4);

  var_5.plotarmor = undefined;
  var_5.c130 = undefined;

  if(!isDefined(var_5._id_145BF))
    var_5 _id_126F3(var_2);

  var_5 gulagwinnerrespawn(1, var_8, var_11, 1, var_12, undefined, var_7, var_4, undefined, undefined, var_2);
}

_id_125C7(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_6 = var_5;
  var_7 = "_encstr_857D06B318080D8A";

  if(isDefined(var_0)) {
    var_8 = istrue(var_5.delay_enter_combat_after_investigating_grenade) && !isalive(var_5) && istrue(var_5._id_14439);
    var_6 = var_0;
    var_7 = "_encstr_88911047F6D62B9B7DCDC1B79B6E7BE42B32";

    if(!istrue(var_3)) {
      if(istrue(var_1))
        var_9 = 6;
      else
        var_9 = 10;

      var_5 thread _id_13DCB(var_9);
    }
  }

  if(isDefined(var_0) || istrue(var_2)) {
    var_5 scripts\mp\playerlogic::addtoalivecount(var_4);
    _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::_id_13F21(var_5, var_4);
  }

  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::destroyawardlaunchonly(var_5, var_7);
  _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::devspectatetesthost(self, int(isDefined(var_0)));

  if(istrue(var_6.hasrespawntoken))
    var_6 _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::removerespawntoken();

  return [var_6, var_7];
}

_id_126E8() {
  var_0 = self;
  var_1 = istrue(var_0._id_12876);

  if(var_1) {
    var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(76);

    while(istrue(var_0._id_12876))
      waitframe();
  }

  return var_1;
}

gulaginitloadouts() {
  level.gulag.vehicle_compass_deregisterinstance = init_relic_punchbullets();
  init_relic_rocket_kill_ammo();
}

init_relic_punchbullets() {
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
  var_0["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = "_encstr_92620B68531B9B432F2AE8D61B";
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

init_relic_rocket_kill_ammo() {
  level.set_relic_thirdperson = [];
  level.set_relic_trex = give_and_switch_to_secondary_weapon();

  if(getDvar("_encstr_8EB21E9BB04D712BD338F7FD4959F7898938226268EBF3A72894FDF25E60A34F") != "_encstr_B40101") {
    var_0 = strtok(getDvar("_encstr_8EB21E9BB04D712BD338F7FD4959F7898938226268EBF3A72894FDF25E60A34F"), "_encstr_974C0246");
    var_1 = [];

    for(var_2 = 0; var_2 < var_0.size; var_2++)
      var_1[var_1.size] = int(var_0[var_1.size]);

    var_3 = var_1.size;

    for(var_4 = 0; var_4 < var_3; var_4++)
      level.set_relic_thirdperson[level.set_relic_thirdperson.size] = init_relic_oneclip(var_1[var_4]);
  } else {
    var_3 = tablelookupgetnumcols(level.set_relic_trex) - 1;

    for(var_4 = 0; var_4 < var_3; var_4++)
      level.set_relic_thirdperson[level.set_relic_thirdperson.size] = init_relic_oneclip(var_4);
  }
}

give_and_switch_to_secondary_weapon() {
  var_0 = getdvarint("_encstr_92671C270F0E190172FEE75D41DB576FC3931A79FD37C82B4DE2DB2F30CF", 0);

  if(var_0) {
    if(var_0 == 444) {
      if(randomint(2) == 0)
        return "_encstr_AAFC1F6230EF761B8926EBE43731C33FE7581BD920E3ED672185C2ECF790B7C2ED";
      else
        return "_encstr_8FEC1F6583F7FFA059CF0F9C4EBB9AFA112832973767D81B104393222A0E0B9693";
    } else if(var_0 == 445)
      return "_encstr_813720A0797683316B93B7E83BFAD8B02EB97289275BC8710F436A2AE0EF058E7773";
    else
      return "_encstr_A9AD1708BA87B099A277272157FAD1D85F9653C6E72563C7FA" + var_0 + "_encstr_96A70506895E33";
  }

  if(getdvarint("_encstr_A6631C8337602173C6EE7A439097AFE92093041D4361751B65A3238AB9FD", 0) == 1)
    return "_encstr_8F5921B30BB80A7CF1EF8B29612A4B83193DDD094F5F2DFE278EA00750D7C15E31D3B6";

  var_1 = randomint(1337) + 1;

  if(var_1 == 1337)
    return "_encstr_BE891DEDBACAB6A9D3EBC36B610A61B077789B8F7AD333F1BF9F4B82F2E0C6";

  var_2 = randomint(100) + 1;

  if(var_2 > 90)
    return "_encstr_A7E71CE8E08A37323FFA3701D721085D588BFE590418A13EB762651238FB";
  else if(var_2 > 65)
    return "_encstr_970D1C5B437636E8F14AF32BF6DAA07D29631DB7877B09580FF250C11A96";
  else if(var_2 > 40)
    return "_encstr_AF021C38937F219152E28E157E3AC9A9A763483127DD18431A9A2896D293";
  else
    return "_encstr_95F91CB50E971B1B16DC9B3A2C311B56EB8939F5B3ABC658D9898BD8E6B3";

  return "_encstr_95F91CB50E971B1B16DC9B3A2C311B56EB8939F5B3ABC658D9898BD8E6B3";
}

init_relic_oneclip(var_0) {
  var_1["_encstr_AA2D1188DD6928B843CBA3CDBFBAF5F01972D1"] = "_encstr_AFB31216936C0DCAE8F283B2FA85CDE6B0578D1D";
  var_1["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = tablelookup(level.set_relic_trex, 0, "_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243", var_0 + 1);
  var_1["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = tablelookup(level.set_relic_trex, 0, "_encstr_99651ABB702174E2F32532B2839B5A2A4A795343A8D9A00A3B30037A", var_0 + 1);
  var_1["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = tablelookup(level.set_relic_trex, 0, "_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353", var_0 + 1);
  var_1["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = tablelookup(level.set_relic_trex, 0, "_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66", var_0 + 1);
  var_1["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = tablelookup(level.set_relic_trex, 0, "_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3", var_0 + 1);
  var_1["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = tablelookup(level.set_relic_trex, 0, "_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB", var_0 + 1);
  var_1["_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED"] = tablelookup(level.set_relic_trex, 0, "_encstr_856C13D8BD0B19DEEAA3A027B46BC227BC0D2C6BED", var_0 + 1);
  var_1["_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3"] = tablelookup(level.set_relic_trex, 0, "_encstr_AA0216B867B9590F9BDB978EF4725BC3F93B48F0E75390C3", var_0 + 1);
  var_1["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = tablelookup(level.set_relic_trex, 0, "_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B", var_0 + 1);
  var_1["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = tablelookup(level.set_relic_trex, 0, "_encstr_8FDB1C30B012AF674FBDE9CFFA1033A4635D4BB6D541BF1E90C829ED3BAA", var_0 + 1);
  var_1["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = tablelookup(level.set_relic_trex, 0, "_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7", var_0 + 1);
  var_1["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"] = tablelookup(level.set_relic_trex, 0, "_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC", var_0 + 1);
  var_1["_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC"] = tablelookup(level.set_relic_trex, 0, "_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC", var_0 + 1);
  var_1["_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA"] = tablelookup(level.set_relic_trex, 0, "_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA", var_0 + 1);
  var_1["_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560"] = tablelookup(level.set_relic_trex, 0, "_encstr_8CEA1501B78EF0781F83D7199A1FA0A8260293D7217560", var_0 + 1);
  var_1["_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D"] = tablelookup(level.set_relic_trex, 0, "_encstr_83B6181AA01BCF6F63FD93DD1E48239743E0F37168D94487786D", var_0 + 1);
  var_1["_encstr_AA9C11195FB7B9E7630321789A3FBB173BF79D"] = "_encstr_8BBA05185F8B99";
  var_1["_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB"] = tablelookup(level.set_relic_trex, 0, "_encstr_93A4182DD83854DA9DC90FD7E34BF385F0CDA3BAD3C0157276CB", var_0 + 1);
  var_1["_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B"] = tablelookup(level.set_relic_trex, 0, "_encstr_8B781A89822F040F6B83E54BC8CA9378059D855728CF2D2DBF69104B", var_0 + 1);
  var_1["_encstr_AD1B1288DD6928B843CB87C1FB6AF70834307321"] = "_encstr_AB3508737F830710ACDB";
  var_1["_encstr_8EE713601A6FD59883AC471BACAD30A55BD2590847"] = "_encstr_8BBA05185F8B99";
  var_1["_encstr_91E71336EDC291F6AE8E5A5AD88DB91DE456B05B8C"] = "_encstr_8BBA05185F8B99";
  var_1["_encstr_ACE713DD22D19AE80D98115804EB13E1D2D58F27C7"] = "_encstr_8BBA05185F8B99";
  var_1["_encstr_85920D9D304BCAFF3B38EF7F3011BA"] = "_encstr_8BBA05185F8B99";
  var_1["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = [tablelookup(level.set_relic_trex, 0, "_encstr_96CB0DB3C7BF3CCF5363C0EA92DCCA", var_0 + 1), tablelookup(level.set_relic_trex, 0, "_encstr_88CB0DC6B70B237B5D1DA02B27AD46", var_0 + 1), tablelookup(level.set_relic_trex, 0, "_encstr_81CB0D4DB85834BAFDA97BA7CDAA27", var_0 + 1), tablelookup(level.set_relic_trex, 0, "_encstr_86EA12137F2FDAF73803D760FBF80151F5DD87DE", var_0 + 1), tablelookup(level.set_relic_trex, 0, "_encstr_8BEA12C06AA8690A20E32759212A20912B13FF0A", var_0 + 1), tablelookup(level.set_relic_trex, 0, "_encstr_83EA1283EF9F6A47889347108B6891E1652D1766", var_0 + 1)];
  var_1["_encstr_B4450F51E53FE10F4B0C1791B7ABED8085"] = "_encstr_A63C0B33252188F56B439B89EF";
  var_1["_encstr_96D10CD10B311B2B0DBDC6BAD6DC"] = var_0;
  return var_1;
}

playergivearenaloadout(var_0, var_1) {
  if(getdvarint("_encstr_9347133356AB495E48019FFE1702FFAE5B906BC552", 1) == 0) {
    return;
  }
  self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"] = level.set_relic_thirdperson[var_1];
  gethightestpriotiryactiveburnstate(var_1);
  self.class = "_encstr_AAAC09D09972B9C83F2B7F";
  self.prevweaponobj = undefined;
  var_2 = scripts\mp\class::loadout_getclassstruct();
  var_2 = scripts\mp\class::loadout_updateclass(var_2, "_encstr_AAAC09D09972B9C83F2B7F");
  scripts\mp\class::preloadandqueueclassstruct(var_2, 1, 1);
  scripts\mp\class::giveloadout(self.team, "_encstr_AAAC09D09972B9C83F2B7F", 0, 0);
  self givestartammo(var_2.loadoutprimaryobject);

  if(isDefined(var_2.loadoutsecondaryobject))
    self givestartammo(var_2.loadoutsecondaryobject);

  self.set_relic_team_proximity = level.set_relic_thirdperson[var_1]["_encstr_96D10CD10B311B2B0DBDC6BAD6DC"];
  _id_12687(var_0, "_encstr_AD670B1BF6B023DEAB4792EDDD", self.set_relic_team_proximity);
}

gethightestpriotiryactiveburnstate(var_0) {
  if(getdvarint("_encstr_BE8413F37E20A8AEF56E810BC337E1E001403E6F7A", 0)) {
    switch (var_0) {
      case 0:
        var_1 = "_encstr_88FE0D0157202970845121C58E802F";
        break;
      case 1:
        var_1 = "_encstr_8D900DB477077D1C2DD736E0C28385";
        break;
      case 2:
        var_1 = "_encstr_88FE0D0157202970845121C58E802F";
        break;
      case 3:
        var_1 = "_encstr_8D900DB477077D1C2DD736E0C28385";
        break;
      case 4:
        var_1 = "_encstr_88FE0D0157202970845121C58E802F";
        break;
      case 5:
        var_1 = "_encstr_8D900DB477077D1C2DD736E0C28385";
        break;
      case 6:
        var_1 = "_encstr_88FE0D0157202970845121C58E802F";
        break;
      case 7:
        var_1 = "_encstr_8D900DB477077D1C2DD736E0C28385";
        break;
      case 8:
        var_1 = "_encstr_88FE0D0157202970845121C58E802F";
        break;
      case 9:
      default:
        var_1 = "_encstr_8D900DB477077D1C2DD736E0C28385";
    }

    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_AAC30FB908390F67FD8BC70AD8FDB9A243"] = var_1;
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_9643193A25FBB9209BBB027A21C5C9FE9A07A8F86730C0DB505878"] = "_encstr_8BBA05185F8B99";
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_A1651A992F661880E76B2F5382BF4F60B8992151C94EC0D9CFA2A353"] = "_encstr_8BBA05185F8B99";
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_A7651A1BF6C2C8F6ABA38227966B2CE42F283AE858C61AD6ACB93A66"] = "_encstr_8BBA05185F8B99";
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_A3651A59EF2658C0A72B6F13C2FF8FA07859E111890E80190F62E3D3"] = "_encstr_8BBA05185F8B99";
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_93651AF8AF834247CDD90F92A16BD90BCAC9E41108C6500DAB88D1FB"] = "_encstr_8BBA05185F8B99";
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_914E11521FAFF595BD93F9EF781F36EA0B708B"] = "_encstr_8BBA05185F8B99";
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_A96F1B782D99D84853DBB7D3AFDA376031C2425593D4B8765A47C3FDEB"] = "_encstr_8BBA05185F8B99";
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_B8DB1C1C17A137958B719F02564FF061B64E77B134A3D1DF58BF9BC633C7"] = "_encstr_8BBA05185F8B99";
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_ACDB1CC6BD858CF6ABA3D45636F6E623169C2F0A1D8E85C634AD95B98ECC"] = "_encstr_8BBA05185F8B99";
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_A1DB1C292712B5A7DD034F97C73DF6E0A74D9011B3E1F77FA393B00593AC"] = "_encstr_8BBA05185F8B99";
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_A7DB1C731F0FFAD7182372C7F9F0EE32D7BDAF3FC12D12939868F70DF3CA"] = "_encstr_8BBA05185F8B99";
    self.pers["_encstr_8CFB10507A35BBD8C7E435A9F72721679B93"]["_encstr_86CB0DFB97F7022F90BB3A7F53487B"] = ["_encstr_AC9C0FEA0FF30A29692883BF99A00D4249"];
  }
}

getloadoutindex() {
  if(getdvarint("_encstr_9347133356AB495E48019FFE1702FFAE5B906BC552", 1) == 0) {
    return;
  }
  var_0 = getdvarint("_encstr_8C791A5A366D79F2DB613B274930A7C22958A313B8DD122A23C80B27", -1);

  if(var_0 > -1 && var_0 < level.set_relic_thirdperson.size)
    return var_0;

  if(getDvar("_encstr_8EB21E9BB04D712BD338F7FD4959F7898938226268EBF3A72894FDF25E60A34F") != "_encstr_B40101") {
    if(!isDefined(level.set_relic_team_proximity) || level.set_relic_team_proximity >= level.set_relic_thirdperson.size)
      level.set_relic_team_proximity = 0;

    var_1 = level.set_relic_team_proximity;
    level.set_relic_team_proximity = level.set_relic_team_proximity + 1;
  } else
    var_1 = randomint(level.set_relic_thirdperson.size);

  return var_1;
}

_id_1428F(var_0) {
  var_0 endon("_encstr_85CC0BA370D12803F7F8CB075E");
  var_0 endon("_encstr_8A240BB6581D6C0DA2B98C5691");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = level.gulag.timelimit;
  level.gulag.timelimit = 180;
  iprintln("_encstr_B18D2CC1876F612FABBB02B84282FBF9E733EF55E92F68F912A3F0806B1CBD911AD1E0E72BBA334B7E3A803873E5");
  wait 3.0;
  iprintln("_encstr_8A1F14B22B272D33B4B10B1DB4F69B026ED1C29CD109");

  for(var_2 = 0; var_2 < level.set_relic_thirdperson.size; var_2++) {
    iprintln("_encstr_A7C20A21B8B7F12FA3FBDA42" + var_2);
    playergivearenaloadout(var_0, var_2);
    wait 5.0;
    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self.secondaryweapon);
    wait 4.0;
  }

  playergivearenaloadout(var_0, 0);
  level.gulag.timelimit = var_1;
  iprintln("_encstr_ACB71311E130D4FEF8599E136A181E71DCD796754F");
}

_id_1323A(var_0) {
  var_1 = getdvarint("_encstr_AFFF166283C8DEFD72960386C933D840E289BB122C3B9382", 50);
  var_0.managevehiclehealthui = spawnStruct();
  var_2 = getgroundposition(var_0.center, 1);
  var_0.managevehiclehealthui.trigger = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_2, 0, int(var_1), int(level.defend_wave_3));
  var_3 = _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::setupobjective(var_0.managevehiclehealthui.trigger, "_encstr_A7A408B9CA5D1D4E2C63", undefined, 1);
  var_3.onuse = ::arenaflag_onuse;
  var_3.onbeginuse = ::arenaflag_onusebegin;
  var_3.onenduse = ::arenaflag_onuseend;
  var_3.onuseupdate = ::arenaflag_onuseupdate;
  var_3.oncontested = ::arenaflag_oncontested;
  var_3.isarena = 1;
  var_3 scripts\mp\gameobjects::pinobjiconontriggertouch();
  var_3.id = "_encstr_87D9083A6F628DDB5F1F";
  var_3 scripts\mp\gameobjects::setcapturebehavior("_encstr_92FC0B5BB01A6B73D09459526B");
  var_3.scriptable delete();
  var_3.ignorestomp = 1;
  var_3 scripts\mp\gameobjects::requestid(0, 1, undefined, 0, 0);
  var_3.visibilitymanuallycontrolled = 1;
  var_3 calloutmarkerping_watchwhenobjectivedeleted(0);
  var_3 calloutmarkerping_watchwhenobjectivestartsprogress(var_0, 0);
  var_3.arena = var_0;
  var_0.managevehiclehealthui.arenaflag = var_3;
}

mark_remaining_as_died_poorly(var_0) {
  wait 1.0;

  if(isDefined(var_0) && isDefined(var_0.managevehiclehealthui) && isDefined(var_0.managevehiclehealthui.arenaflag) && isDefined(var_0.managevehiclehealthui.arenaflag.flagmodel))
    return;
}

calloutmarkerping_watchwhenobjectivedeleted(var_0) {
  if(var_0) {
    scripts\mp\gameobjects::allowuse("_encstr_9A19040BCDBC");
    self.trigger scripts\engine\utility::trigger_on();
  } else {
    scripts\mp\gameobjects::allowuse("_encstr_8BBA05185F8B99");
    self.trigger scripts\engine\utility::trigger_off();
    scripts\mp\gameobjects::resetcaptureprogress();
  }
}

calloutmarkerping_watchwhenobjectivestartsprogress(var_0, var_1, var_2, var_3) {
  self notify("_encstr_AB9815E086EF08B92EFCD1A9515F0934A5830BC0F3A483");

  if(var_1) {
    var_4 = "_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1";

    if(istrue(var_2))
      var_4 = level.squadspawndebug;

    thread calloutmarkerping_squadleaderbeaconshouldcreate(var_0);
    thread scripts\mp\gameobjects::setobjectivestatusicons(var_4);
    thread scripts\mp\gameobjects::setownerteam("_encstr_A7A408B9CA5D1D4E2C63");
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_A7C5056BD931D1", 0, "_encstr_8BBA05185F8B99");
    self.flagmodel show();
    thread calloutmarkerpingvo_createcalloutbattlechatter(var_0, 1);

    if(!istrue(var_2)) {
      _id_13193(var_0, 1);
      return;
    }
  } else
    thread calloutmarkerpingvo_calculatesounddebouncelength(var_0, var_2, var_3);
}

calloutmarkerpingvo_calculatesounddebouncelength(var_0, var_1, var_2) {
  self endon("_encstr_AB9815E086EF08B92EFCD1A9515F0934A5830BC0F3A483");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!istrue(var_2)) {
    objective_setpinned(self.objidnum, 0);
    wait 1;
  }

  thread calloutmarkerpingvo_createcalloutbattlechatter(var_0, 0);
  thread calloutmarkerping_squadleaderbeaconplayerfirstlanded(var_2);
  thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_BA19049F4B2D", 0, "_encstr_8BBA05185F8B99");
  self.flagmodel hide(1);

  if(!istrue(var_1)) {
    _id_13193(var_0, 0);
    _id_13194(var_0, 0);
  }
}

calloutmarkerpingvo_canplaywithspamavoidance(var_0, var_1) {
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(var_0) {
    var_1 setclientomnvar("_encstr_AC1417CD6B41651B7583934A485D871B58FB5532EFF86C3724", 1);
    objective_addclienttomask(self.objidnum, var_1);
  } else {
    objective_unpinforclient(self.objidnum, var_1);
    wait 1;
    var_1 setclientomnvar("_encstr_AC1417CD6B41651B7583934A485D871B58FB5532EFF86C3724", 0);
    objective_removeclientfrommask(self.objidnum, var_1);
  }

  thread calloutmarkerpingvo_debouncegarbagecollector(var_0, var_1);
}

calloutmarkerping_watchplayerdeathordisconnect(var_0, var_1) {
  thread calloutmarkerping_watchwhenobjectivestartsprogress(var_0, 1, 1);
  wait(var_1);
  thread calloutmarkerping_watchwhenobjectivestartsprogress(var_0, 0, 1, 1);
}

calloutmarkerping_squadleaderbeaconshouldcreate(var_0) {
  objective_removeallfrommask(self.objidnum);

  foreach(var_2 in var_0.jailedplayers)
  objective_addclienttomask(self.objidnum, var_2);

  foreach(var_2 in var_0.arenaplayers)
  objective_addclienttomask(self.objidnum, var_2);

  objective_showtoplayersinmask(self.objidnum);
}

calloutmarkerping_squadleaderbeaconplayerfirstlanded(var_0) {
  objective_setshowprogress(self.objidnum, 0);
  objective_removeallfrommask(self.objidnum);
  objective_showtoplayersinmask(self.objidnum);
}

calloutmarkerpingvo_createcalloutbattlechatter(var_0, var_1) {
  if(var_1) {
    if(var_0.jailedplayers.size > 0)
      self.flagmodel hudoutlineenableforclients(var_0.jailedplayers, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA");

    if(var_0.arenaplayers.size > 0)
      self.flagmodel hudoutlineenableforclients(var_0.arenaplayers, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA");
  } else {
    if(var_0.jailedplayers.size > 0)
      self.flagmodel hudoutlinedisableforclients(var_0.jailedplayers);

    if(var_0.arenaplayers.size > 0)
      self.flagmodel hudoutlinedisableforclients(var_0.arenaplayers);
  }
}

calloutmarkerpingvo_debouncegarbagecollector(var_0, var_1) {
  if(var_0)
    self.flagmodel hudoutlineenableforclient(var_1, "_encstr_A2A117F6AB471B5AE656AFE6DB199583D134FADB930BCD76CA");
  else
    self.flagmodel hudoutlinedisableforclient(var_1);
}

arenaflag_onusebegin(var_0) {
  var_1 = getdvarint("_encstr_AC151CCB7F28694BFE26B2EA0EDC4B5E289F5321B1C02B432D5E8B7250A5", 3.0);
  var_0.iscapturing = 1;
  var_2 = scripts\mp\gameobjects::getownerteam();

  if(var_2 == "_encstr_A7A408B9CA5D1D4E2C63")
    var_0 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 1);

  self.neutralizing = istrue(level.flagneutralization) && var_2 != "_encstr_A7A408B9CA5D1D4E2C63";

  if(!istrue(self.neutralized))
    self.didstatusnotify = 0;

  var_3 = var_1;
  scripts\mp\gameobjects::setusetime(var_3);

  if(istrue(level.capturedecay))
    thread scripts\mp\gameobjects::useobjectdecay(var_0.team);

  if(var_3 > 0) {
    foreach(var_5 in self.arena.arenaplayers) {
      if(var_5 != var_0 && var_5.team != var_0.team) {
        self.prevownerteam = var_5.team;
        break;
      }
    }

    _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagcapturestate(var_0.team);
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_B40710E36BBF4F179FCD9CC8C9B1F3836012", "_encstr_8202100F51F881C7C0F2255890A5865376FF");
  }
}

arenaflag_onuseupdate(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\gameobjects::getownerteam();

  if(var_1 > 0.05 && var_2 && !self.didstatusnotify)
    self.didstatusnotify = 1;
}

arenaflag_onuseend(var_0, var_1, var_2) {
  self.didstatusnotify = 0;

  if(var_2)
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);

  if(isPlayer(var_1)) {
    var_1.iscapturing = 0;
    var_1 setclientomnvar("_encstr_883813B378B9C8B14D37B03CFB5B79098803C9939B", 0);
    var_1.ui_dom_securing = undefined;
  }

  var_3 = scripts\mp\gameobjects::getownerteam();

  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_85B118EB19F840DA93FDCB6FCF4FF39C7083E73531200C43FFE1");
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_A7C5056BD931D1", 0);
  } else {
    scripts\mp\gameobjects::setobjectivestatusicons("_encstr_994B105B20DB3A9F30206457CD5973870DE0", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");
    thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate(var_3, 0);
  }

  if(!var_2)
    self.neutralized = 0;
}

calloutmarkerping_watchwhenmissioncompletes(var_0, var_1) {
  scripts\mp\gameobjects::setownerteam(var_0);
  self notify("_encstr_95EB0866891B23FB85B3", var_1);
  self notify("_encstr_AB3508737F830710ACDB", var_1);
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_A9E313D3A8538227B8B8FCDF45C1FB0F9518BAFA30", "_encstr_859A1183D94B3B2548D56447E7202A93F5133A");
  self.neutralized = 0;
  thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate(var_0, 0, var_0);

  if(self.touchlist[var_0].size == 0 && isDefined(self.oldtouchlist))
    self.touchlist = self.oldtouchlist;

  foreach(var_3 in self.arena.arenaplayers) {
    if(var_3 != var_1 && var_3.team != var_0 && isDefined(self.assisttouchlist[var_3.team])) {
      self.assisttouchlist[var_3.team] = [];
      break;
    }
  }
}

arenaflag_onuse(var_0) {
  var_1 = var_0.team;
  self.capturetime = gettime();
  self.neutralized = 0;
  calloutmarkerping_watchwhenmissioncompletes(var_1, var_0);

  if(!self.neutralized) {
    foreach(var_3 in self.arena.arenaplayers) {
      if(isalive(var_3) && var_3.team != var_1)
        var_3 thread set_respawn_loc_delayed(self.arena);
    }

    thread handleendarena(self.arena);
    self.firstcapture = 0;
  }
}

arenaflag_oncontested() {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_AA3B135FEBE0328F83F003B939E8D36BA877D4D509");
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  thread _encstr_957F21CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E79BD894D7D8CF65BC53B6E36::updateflagstate("_encstr_B85C0AD87B9B8E95CD8E2B46", 0);
}

registercontrolledcallback(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "_encstr_B40101";

  switch (var_0) {
    case "_encstr_92DA0DAB58D9E395FDF77E0B252F4A":
      [var_2, var_3, var_4] = [0, 8, "_encstr_A1B616A34F46F220A1797089E6CCC7CBEDFFBFDD1BB3D9A7"];
      var_1 = var_1 + 1;
      break;
    case "_encstr_82DA0D47C480B3DD42B7FD8388FF1B":
      [var_2, var_3, var_4] = [8, 8, "_encstr_A1B616A34F46F220A1797089E6CCC7CBEDFFBFDD1BB3D9A7"];
      var_1 = var_1 + 1;
      break;
    case "_encstr_BA700C0360C3A06FBBCA8989E1CB":
      [var_2, var_3, var_4] = [16, 8, "_encstr_A1B616A34F46F220A1797089E6CCC7CBEDFFBFDD1BB3D9A7"];
      var_1 = var_1 + 1;
      break;
    case "_encstr_B1700C62F070012256FDE7FF89DF":
      [var_2, var_3, var_4] = [24, 8, "_encstr_A1B616A34F46F220A1797089E6CCC7CBEDFFBFDD1BB3D9A7"];
      var_1 = var_1 + 1;
      break;
    case "_encstr_AD670B1BF6B023DEAB4792EDDD":
      [var_2, var_3, var_4] = [0, 8, "_encstr_8C7C11DB3337AAE27EA0771BB851979223D5A6"];
      var_1 = var_1 + 1;
      break;
    case "_encstr_8F430E33FDAB229BDEF0558E35DDF323":
      [var_2, var_3, var_4] = [8, 8, "_encstr_8C7C11DB3337AAE27EA0771BB851979223D5A6"];
      break;
    case "_encstr_A3430E072CC76A83D2D07068AA6B51AB":
      [var_2, var_3, var_4] = [16, 8, "_encstr_8C7C11DB3337AAE27EA0771BB851979223D5A6"];
      break;
    default:
      break;
  }

  return [var_2, var_3, var_4, var_1];
}

_id_121B3(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(pow(2, var_4)) - 1;
  var_6 = (var_2 &var_5) << var_3;
  var_7 = ~(var_5 << var_3);
  var_8 = var_0._id_11FCF[var_1];
  var_9 = var_8 &var_7;
  var_10 = var_9 + var_6;
  var_0._id_11FCF[var_1] = var_10;
}

_id_13125(var_0, var_1, var_2) {
  [var_4, var_5, var_6, var_2] = registercontrolledcallback(var_1, var_2);

  if(var_6 == "_encstr_B40101") {
    return;
  }
  _id_121B3(var_0, var_6, var_2, var_4, var_5);
}

_id_13127(var_0, var_1, var_2) {
  var_3 = -1;

  if(isDefined(var_2))
    var_3 = var_2 getentitynumber();

  _id_13125(var_0, var_1, var_3);
}

_id_13126(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_2))
    var_3 = var_2.health;

  _id_13125(var_0, var_1, var_3);
}

_id_13FC1(var_0) {
  var_0._id_11FCF["_encstr_A1B616A34F46F220A1797089E6CCC7CBEDFFBFDD1BB3D9A7"] = 0;

  for(var_1 = 0; var_1 < level.gulag.maxplayers; var_1++) {
    var_2 = var_0.arenaplayers[var_1];
    _id_13127(var_0, "_encstr_BD7C0C97F0C77B9D5B76757165D8" + var_1, var_2);
  }

  var_3 = var_0.matches[0];

  if(!isDefined(var_3))
    var_3 = [];

  _id_13127(var_0, "_encstr_BA700C0360C3A06FBBCA8989E1CB", var_3[0]);
  _id_13127(var_0, "_encstr_B1700C62F070012256FDE7FF89DF", var_3[1]);
  var_4 = scripts\engine\utility::array_combine(var_0.jailedplayers, var_0.arenaplayers);

  foreach(var_2 in var_4) {
    var_2 setclientomnvar("_encstr_A1B616A34F46F220A1797089E6CCC7CBEDFFBFDD1BB3D9A7", var_0._id_11FCF["_encstr_A1B616A34F46F220A1797089E6CCC7CBEDFFBFDD1BB3D9A7"]);

    foreach(var_11, var_7 in var_0.matches) {
      if(isDefined(var_7[0]) && var_2 == var_7[0] || isDefined(var_7[1]) && var_2 == var_7[1]) {
        var_8 = !updatelootleadermarks(var_0, var_2);
        var_9 = var_11 + 1;
        var_10 = var_8 + (var_9 << 1);
        var_2 setclientomnvar("_encstr_A5721B65289FC64E675755A173E031436793271B68B3D2E7780588E280", var_10);
        break;
      }
    }
  }
}

_id_1267A(var_0) {
  self setclientomnvar("_encstr_8C7C11DB3337AAE27EA0771BB851979223D5A6", var_0._id_11FCF["_encstr_8C7C11DB3337AAE27EA0771BB851979223D5A6"]);
}

_id_13FC0(var_0) {
  _id_12C6B(var_0);

  for(var_1 = 0; var_1 < level.gulag.maxplayers; var_1++) {
    var_2 = var_0.arenaplayers[var_1];
    _id_13126(var_0, "_encstr_A7120D933079210A8543372E496112" + var_1, var_2);
  }

  foreach(var_2 in var_0.jailedplayers)
  var_2 _id_1267A(var_0);

  foreach(var_2 in var_0.arenaplayers)
  var_2 _id_1266D(var_0);
}

_id_12C6B(var_0) {
  var_0._id_11FCF["_encstr_8C7C11DB3337AAE27EA0771BB851979223D5A6"] = 0;
}

_id_1266D(var_0) {
  if(!isDefined(self.set_relic_team_proximity))
    self setclientomnvar("_encstr_8C7C11DB3337AAE27EA0771BB851979223D5A6", var_0._id_11FCF["_encstr_8C7C11DB3337AAE27EA0771BB851979223D5A6"]);
  else
    _id_12687(var_0, "_encstr_AD670B1BF6B023DEAB4792EDDD", self.set_relic_team_proximity);
}

_id_12687(var_0, var_1, var_2) {
  [var_4, var_5, var_6, var_2] = registercontrolledcallback(var_1, var_2);

  if(var_6 == "_encstr_B40101") {
    return;
  }
  _id_1260F(var_0, var_6, var_2, var_4, var_5);
}

_id_1260F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = int(pow(2, var_4)) - 1;
  var_6 = (var_2 &var_5) << var_3;
  var_7 = ~(var_5 << var_3);
  var_8 = var_0._id_11FCF[var_1];
  var_9 = var_8 &var_7;
  var_10 = var_9 + var_6;
  self setclientomnvar(var_1, var_10);
}

_id_14009(var_0) {
  _id_13FC1(var_0);
  _id_13FC0(var_0);
}

_id_12526(var_0) {
  var_1 = getarraykeys(var_0._id_11FCF);

  foreach(var_3 in var_1)
  self setclientomnvar(var_3, 0);

  self setclientomnvar("_encstr_8FD112D5B4EBF63B95C9D1B45BB2BED1A5D656E4", 0);
  self setclientomnvar("_encstr_AC1417CD6B41651B7583934A485D871B58FB5532EFF86C3724", 0);
}

_id_13194(var_0, var_1) {
  foreach(var_3 in var_0.arenaplayers)
  var_3 setclientomnvar("_encstr_8FD112D5B4EBF63B95C9D1B45BB2BED1A5D656E4", var_1);

  foreach(var_3 in var_0.jailedplayers)
  var_3 setclientomnvar("_encstr_8FD112D5B4EBF63B95C9D1B45BB2BED1A5D656E4", var_1);
}

_id_13193(var_0, var_1) {
  foreach(var_3 in var_0.arenaplayers)
  var_3 setclientomnvar("_encstr_AC1417CD6B41651B7583934A485D871B58FB5532EFF86C3724", var_1);

  foreach(var_3 in var_0.jailedplayers)
  var_3 setclientomnvar("_encstr_AC1417CD6B41651B7583934A485D871B58FB5532EFF86C3724", var_1);
}

_id_125CC(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_91ED0AECABC60B3BEB95CD23");
  var_1 = "_encstr_8F430E33FDAB229BDEF0558E35DDF323";

  if(var_0.arenaplayers[0] != self)
    var_1 = "_encstr_A3430E072CC76A83D2D07068AA6B51AB";

  for(;;) {
    _id_13FC0(var_0);

    if(self.health <= 0) {
      return;
    }
    scripts\engine\utility::_id_143AA("_encstr_B2BE0788BAF573592F", "_encstr_8BCA133EF0500E3B31E6FD2F326DA09D1F73F14FD5", "_encstr_9BD1119356ADB7D95682C8392B9B588D4B3759", "_encstr_8FB50718DD41DB3FA9", "_encstr_85211042E803A51BFF1DCFC5A007232CB55B", "_encstr_96B00A7E4F82030372481F2D", "_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  }
}

_id_1263C() {
  if(level.gulag.trial_target_civilian_killed_func && !isbot(self)) {
    var_0 = relic_amped_pick_new_victim();
    self skydive_cutparachuteon(var_0);
  }
}

_id_12617() {
  if(level.gulag.trial_target_civilian_killed_func && !isbot(self)) {
    self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 1);
    var_0 = scripts\mp\music_and_dialog::reset_attack_next_available_time("_encstr_97870FE18BD7140885F95F37E9EDC866EF");
    self setplayermusicstate(var_0);

    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::tutorial_playSound())
      self setsoundsubmix("_encstr_AC6F16A09BE04FB9335FB4B574A7C1875B03C008A3CC6B30", 0.5);
    else
      self setsoundsubmix("_encstr_83CE2D99163295F53ABDF5891B2C6CB5AF16C6D8FAACF0C65938E8FA5B57B9A5C6FA0B73C8BECD1B935A0EA35691A6", 0.5);

    var_1 = relic_amped_pick_new_victim();
    self preloadcinematicforplayer(var_1);
    self._id_12742 = 1;
  } else
    gulagloadingtext();
}

_id_12694() {
  self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 2);
}

_id_126EA(var_0) {
  if(level.gulag.trial_target_civilian_killed_func && !isbot(self) && !self calloutmarkerping_getEnt()) {
    self freezecontrols(1);
    allplayers_setfov(var_0);
    self freezecontrols(0);
    self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 5);
    self skydive_cutparachuteoff();
    self._id_12742 = undefined;
  }
}

allplayers_setfov(var_0) {
  self endon("_encstr_84300E8EA97BA8771622B0602AAFE9A1");
  var_1 = relic_amped_paused();

  while(gettime() - var_0 < var_1 && !self crouchbuttonPressed() && !self useButtonPressed() && !self jumpbuttonPressed())
    waitframe();
}

_id_12521(var_0, var_1) {
  if(var_0 == "_encstr_84300E8EA97BA8771622B0602AAFE9A1")
    self notify("_encstr_84300E8EA97BA8771622B0602AAFE9A1");
}

_id_125EB() {
  if(scripts\mp\utility\game::getgametype() != "_encstr_B607038AAB")
    return 0;

  var_0 = self calloutmarkerping_entityzoffset("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2");

  if(var_0 != 0 && var_0 != 6)
    return 1;

  return 0;
}

_id_125EA() {
  var_0 = self calloutmarkerping_entityzoffset("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2");
  return var_0 == 7;
}

_id_12522() {
  self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 7);
}

_id_12523(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_ADF21F88BB692ACBDB265BD087020B33D92FA188E305A4D3639F40E61EFA1BB83C");

  if(_id_125EB()) {
    if(isDefined(var_0))
      wait(var_0);

    if(getdvarint("_encstr_8B8518AB1815CFE24A2689505867F1C084530ECB1A6728D1086F", 0) == 1) {
      logstring("_encstr_87141DB6E62766718D8A6880936E1B18779D4F3549BF8D9B77D2E1188BEC53");
      logstring("_encstr_B48D0C0E58C8CF89B1439FE78D4F" + self.name + "_encstr_A9D21DF207C8A7589AF1FEF3E01A78679665652151E3B7CFAC81EB122EBDF6" + self calloutmarkerping_entityzoffset("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 0));
    }

    self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 6);
    wait 1;
    self setclientomnvar("_encstr_AF4819AB4BD7C49CF5892D73ADAFDBB395E4C62C5EFACD1D2C1DB2", 0);
  }
}

relic_amped_pick_new_victim() {
  if(level.mapname == "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319" || istrue(level.gulag.untrack_enemy))
    return "_encstr_B1D617B607F5DD3DEB969BD885E619BEEC5DD858B3EB6C8699";
  else if(scripts\cp_mp\utility\game_utility::turretdisabled()) {
    if(scripts\cp_mp\utility\game_utility::turretlightsonstate())
      return "_encstr_B4BA174E59C4B4C9E8A1AF83B6AF3BAB635876FAD2CDA327ED";
    else
      return "_encstr_AC3A149CACC4A5274786FAD95DD80BD9AF4B73D1C9BD";
  } else if(istrue(level.gulag._id_11F19))
    return "_encstr_A62B180D6FE71A0FA840A3B7D866FFF3690F17095BDD535AD0C2";
  else
    return "_encstr_A171174D27F68BCDCD2043CBA85707074807CFC733B8B3D2E7";
}

relic_amped_paused() {
  if(level.mapname == "_encstr_B6AC0D5B0EAFEED3F5B4CDB1587319")
    return 28000;
  else if(istrue(level.gulag._id_11F19))
    return 35000;
  else
    return 17000;
}

_id_1322E(var_0, var_1) {
  if(!level.gulag._id_14069) {
    return;
  }
  if(!isDefined(var_1.target)) {
    return;
  }
  var_2 = getEntArray(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_2.size > 1)
    level.gulag._id_14069 = 0;
  else {
    var_1.door = getEnt(var_1.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_1.door)) {
      var_1.door.closed = 1;
      var_3 = getEnt(var_1.door.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
      var_3 delete();
      var_4 = anglesToForward(var_1.door.angles);
      var_1.door.heli_rpg_enemy_run_away = var_1.door.origin;
      var_1.door._id_1212B = var_1.door.origin + var_4 * 60;
    }
  }
}

_id_14069(var_0) {
  return level.gulag._id_14069 && var_0.get_wave_spawn_total.size > 0;
}

_id_12C7A() {
  var_0 = self;
  var_0.fastcrouchspeedmod = 0;
  var_0 scripts\mp\weapons::updatemovespeedscale();
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_1251A(var_0, var_1) {
  if(!level.gulag.getaccessorylogicbyindex) {
    return;
  }
  self endon("_encstr_8CA21BB37879424F96EE90333930D97252DF545DBBC37740F3ABD06D33");
  var_2 = var_1.chair;
  self playerhide();
  self showtoplayer(self);
  var_3 = spawn("_encstr_BEFE0C2FAB5A88876B4181EB4A5F", var_2.origin, 0, 0, self);
  var_3.angles = var_2.angles;
  var_3 useanimtree(#animtree);
  var_3 hide();
  var_3 showtoplayer(self);
  self._id_12651 = var_3;
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_4.angles = var_2.angles;
  var_4 setModel("_encstr_AA2C14A85C7B10A073AF9FE7E7FAF7683FB6D34107C3");
  var_4 useanimtree(#animtree);
  var_4 hide();
  var_4 showtoplayer(self);
  self.straps = var_4;
  self setOrigin(var_2.origin);
  self playerlinktoabsolute(var_3, "_encstr_8E010B996FB7B6B3C1D1183343");
  _id_1251C(1);
  thread _id_1251D(var_3, var_4);
  self playanimscriptsceneevent("_encstr_B8850F13491E8F3290F32417B7403FCBCD", "_encstr_ABD51B18FDD021BF8E07337E843BC68ECD3029DA0F0B1BB67843581B9D");
  var_3 animScripted("_encstr_8A76065EF4FA3BAB", var_2.origin, var_2.angles, %_encstr_96B5256E234EBEDA83D7B3BA1BC23BBE269CCAB0AD7BBA8ED7BB9EFA46EBB9472C9CE8AFC18D93);
  var_3 scriptmodelplayanim("_encstr_96B5256E234EBEDA83D7B3BA1BC23BBE269CCAB0AD7BBA8ED7BB9EFA46EBB9472C9CE8AFC18D93");
  var_4 animScripted("_encstr_8A76065EF4FA3BAB", var_2.origin, var_2.angles, %_encstr_A61B2888E76379C009CF3FADB58FBA5E153A15D7D427CB0CDEF382872246BB5B1F901C9E0B631E4137F3);
  var_4 scriptmodelplayanim("_encstr_A61B2888E76379C009CF3FADB58FBA5E153A15D7D427CB0CDEF382872246BB5B1F901C9E0B631E4137F3");
  var_3 waittillmatch("_encstr_8A76065EF4FA3BAB", "_encstr_961804BD954A");
  thread _id_1251E();
  self playerlinkTo(var_3, "_encstr_8E010B996FB7B6B3C1D1183343", 0, 30, 30, 45, 60, 0);
  var_3 hide();
  var_3 showtoplayer(self);
  _id_12600(var_3, var_4, var_2);
  self playanimscriptsceneevent("_encstr_B8850F13491E8F3290F32417B7403FCBCD", "_encstr_8C221A9FFD915A37BE40C3EF3833D7B2451DE614681B43478180FFA3");
  var_3 animScripted("_encstr_8A76065EF4FA3BAB", var_2.origin, var_2.angles, %_encstr_86E3243732C9AFDA0EFAECEA630BECBE1393B2B0B6F657E8F5DDF4F564EB56F02DE8FA381B9C);
  var_3 scriptmodelplayanim("_encstr_86E3243732C9AFDA0EFAECEA630BECBE1393B2B0B6F657E8F5DDF4F564EB56F02DE8FA381B9C");
  var_4 animScripted("_encstr_8A76065EF4FA3BAB", var_2.origin, var_2.angles, %_encstr_978327B98CE4AF6BE0F59DABC60BD9AF89C959586DDBABA3BEDDE9EB91F5CA0F961DAFDC479C851C9B);
  var_4 scriptmodelplayanim("_encstr_978327B98CE4AF6BE0F59DABC60BD9AF89C959586DDBABA3BEDDE9EB91F5CA0F961DAFDC479C851C9B");
  var_3 waittillmatch("_encstr_8A76065EF4FA3BAB", "_encstr_961804BD954A");
  thread _id_1251B(var_3, var_4);
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

_id_12600(var_0, var_1, var_2) {
  self endon("_encstr_8CA21BB37879424F96EE90333930D97252DF545DBBC37740F3ABD06D33");
  self endon("_encstr_856E0EC6A10B5AE48493CA16B57BEA47");

  for(;;) {
    self playanimscriptsceneevent("_encstr_B8850F13491E8F3290F32417B7403FCBCD", "_encstr_8D5E1A76AE1BB0ECAF361A0BB44EEBC49C950B6D7B57A3FAC6F6DE83");
    var_0 animScripted("_encstr_8A76065EF4FA3BAB", var_2.origin, var_2.angles, %_encstr_A932240E4C1AEE4378C787B8F4A172C7CA08817FB728A3FB99DF2B0F62918B02805351707543);
    var_0 scriptmodelplayanim("_encstr_A932240E4C1AEE4378C787B8F4A172C7CA08817FB728A3FB99DF2B0F62918B02805351707543");
    var_1 animScripted("_encstr_8A76065EF4FA3BAB", var_2.origin, var_2.angles, %_encstr_84F8276863820633E3096475DDAA7F4EFA435060F7279BC9F92BE2682261A1B02FE3F97813D251B903);
    var_1 scriptmodelplayanim("_encstr_84F8276863820633E3096475DDAA7F4EFA435060F7279BC9F92BE2682261A1B02FE3F97813D251B903");
    var_0 waittillmatch("_encstr_8A76065EF4FA3BAB", "_encstr_961804BD954A");
  }
}

_id_1251E() {
  self endon("_encstr_8CA21BB37879424F96EE90333930D97252DF545DBBC37740F3ABD06D33");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait 1;

  for(;;) {
    if(isDefined(self)) {
      var_0 = self getnormalizedmovement();

      if(self useButtonPressed() || self jumpbuttonPressed() || var_0[0] > 0.5 || var_0[1] > 0.5) {
        break;
      }
    }

    waitframe();
  }

  self playerlinktoabsolute(self._id_12651, "_encstr_8E010B996FB7B6B3C1D1183343");
  self._id_12651 hide();
  self._id_12651 showtoplayer(self);
  self.straps hide();
  self.straps showtoplayer(self);
  self notify("_encstr_856E0EC6A10B5AE48493CA16B57BEA47");
}

_id_1251F() {
  _id_1251B(self._id_12651, self.straps);
}

_id_1251B(var_0, var_1) {
  if(!level.gulag.getaccessorylogicbyindex) {
    return;
  }
  if(!isDefined(self._id_12651)) {
    return;
  }
  if(isDefined(self)) {
    self unlink();
    self stopanimscriptsceneevent();
    self playershow(1);
    _id_1251C(0);
    self._id_12651 = undefined;
    self.straps = undefined;
    self notify("_encstr_8CA21BB37879424F96EE90333930D97252DF545DBBC37740F3ABD06D33");
  }

  var_0 delete();
  var_1 delete();
}

_id_1251D(var_0, var_1) {
  self endon("_encstr_8CA21BB37879424F96EE90333930D97252DF545DBBC37740F3ABD06D33");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  thread _id_1251B(var_0, var_1);
}

_id_1251C(var_0) {
  if(var_0)
    self disableweapons();
  else
    self enableweapons();

  var_1 = !var_0;
  self allowmelee(var_1);
  self allowfire(var_1);
}

reset_minigun_shot_count(var_0) {
  if(isDefined(var_0.getactiveforteam)) {
    var_0.getactiveforteam++;
    var_0.getactiveforteam = var_0.getactiveforteam % var_0.getactiveteamcount.size;
  } else
    var_0.getactiveforteam = 0;

  var_1 = var_0.getactiveteamcount[var_0.getactiveforteam];
  return var_1;
}

_id_1327F() {
  if(!istrue(level.gulag._id_142FB)) {
    return;
  }
  level.gulag.hud_y_offset = [];
  var_0 = 0;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "_encstr_A31422AA7BAE32E3816FD2180A99B22329D28F8E39EB4BB389E8D01F3E686F2878C20249";
  level.gulag.hud_y_offset[var_0].aliases = [10, 20, 30, 40];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [1, 1, 1, 0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "_encstr_A31422AA7BAE32E3816FD2180A99B22329D28F8E39EB4BB389E8D01F3E686F2878C20249";
  level.gulag.hud_y_offset[var_0].aliases = [90, 100, 110];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [1, 1, 0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "_encstr_8B1F1F616041711BD07EB510A7A19F2D985E906E538046F875AD33BD4AC33DBB8F";
  level.gulag.hud_y_offset[var_0].aliases = [10];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "_encstr_8B1F1F616041711BD07EB510A7A19F2D985E906E538046F875AD33BD4AC33DBB8F";
  level.gulag.hud_y_offset[var_0].aliases = [20];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "_encstr_8B1F1F616041711BD07EB510A7A19F2D985E906E538046F875AD33BD4AC33DBB8F";
  level.gulag.hud_y_offset[var_0].aliases = [30];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "_encstr_8B1F1F616041711BD07EB510A7A19F2D985E906E538046F875AD33BD4AC33DBB8F";
  level.gulag.hud_y_offset[var_0].aliases = [40];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "_encstr_B1431C983B69058B7F8FEE69DA8F11E30D3208B9733FBF606BDC7BD06767";
  level.gulag.hud_y_offset[var_0].aliases = [10];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0];
  var_0++;
  level.gulag.hud_y_offset[var_0] = spawnStruct();
  level.gulag.hud_y_offset[var_0].brclampdamagealtmodegg = "_encstr_B1431C983B69058B7F8FEE69DA8F11E30D3208B9733FBF606BDC7BD06767";
  level.gulag.hud_y_offset[var_0].aliases = [20, 30, 40, 50, 60, 20, 70, 80, 90, 80, 20, 30, 100, 110];
  level.gulag.hud_y_offset[var_0].ks_circledelaytime = [0.5, 1.0, 1.5, 0.7, 0.3, 1.0, 0.4, 0.8, 1.0, 0.5, 1.0, 1.5, 2.0, 0];
  var_0++;
  level.gulag.hud_y_offset = scripts\engine\utility::array_randomize(level.gulag.hud_y_offset);
}

_id_13882(var_0) {
  if(!istrue(level.gulag._id_142FB) || var_0._id_12D93.size == 0) {
    return;
  }
  var_0._id_142FA = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_0._id_142FA setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 = randomint(level.gulag.hud_y_offset.size);
  var_2 = randomint(var_0._id_12D93.size);

  for(;;) {
    _id_14407();

    while(var_0.jailedplayers.size == 0)
      waitframe();

    var_5 = var_0._id_12D93[var_2];
    var_6 = level.gulag.hud_y_offset[var_1];
    var_0._id_142FA.origin = var_5.origin;
    var_0._id_142FA dontinterpolate();
    waitframe();

    for(var_7 = 0; var_7 < var_6.aliases.size; var_7++) {
      var_8 = var_6.brclampdamagealtmodegg + var_6.aliases[var_7];
      var_0._id_142FA playsoundonmovingent(var_8);
      var_9 = lookupsoundlength(var_8, 1) / 1000.0;
      var_10 = var_6.ks_circledelaytime[var_7] + var_9;
      wait(var_10);
    }

    var_2 = randomint(var_0._id_12D93.size);
    var_1++;

    if(var_1 >= level.gulag.hud_y_offset.size)
      var_1 = 0;
  }
}

_id_14407() {
  var_0 = getdvarint("_encstr_BA6F173318E52973BB408F95E1E15F6145E01A4A40E71D97D0", 90);
  var_1 = getdvarint("_encstr_A56F17CFA70B80204AE9A9E34D0150D8E32F7377572151F068", 180);
  var_2 = randomfloatrange(var_0, var_1);
  wait(var_2);
}