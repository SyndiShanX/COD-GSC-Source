/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\binoculars.gsc
***********************************************/

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

teamuseonly() {
  level.get_station_controller_struct = spawnStruct();
  level.get_station_controller_struct.plundertotal = getdvarint("_encstr_BA4D2BF347105103B67EAAB2E38E6796C8319D57D720E2EF515072FA2E6D1B0A508F03F96FA021D38FE91AE3B3", 300);
  level.get_station_controller_struct.plunderstructreplenish = getdvarint("_encstr_8B802CCD3639FA989CFA8D2C39272D58891B2BD7ECB037EDB12D73ACAF95F01C637BB9A5DECDF5DA2C87BE236B9D", 250);
  level.get_station_controller_struct.plundertimer = getdvarint("_encstr_A7A22CCDC69CD74C4EFAC60B9C932D2C13B1B2BE3B85CDBDD84BB9B2BE56F0C18DF637B4DEB9EBD6D2CDAF916B3B", 50);
  setdvarifuninitialized("_encstr_83791E9327703163D61ECA12432E877628913D379DA04273773312F9AB8BEF2F", 0);
  setdvarifuninitialized("_encstr_B8E226B9D8C9D72627AF8DC29CC996B031C62BBEA573C2368E966795FAC859C6B28E59FA1D2DADB2", 300);
  setdvarifuninitialized("_encstr_934A1EB936E4FAC439AF6C589393965813C6ACBE6EC1C2BBDCFAE6979B8E59AD", 0);
  setdvarifuninitialized("_encstr_BE032612A15897E286073F2F45AE1AE160E80F9198286809550D6B0761D3A15B10B384E6D1183D03", 50);
  setdvarifuninitialized("_encstr_92EB1E274FE368D8A201B1C9728A48BF3A9BF3F7976BCF28C669B9E05E4E20E5", 0);
  precachestring(&"_encstr_AD8C1C8589A926E2306F0801FB1B8FCF193BE95F39A9C7C74A10514F08B5");
  precachestring(&"_encstr_A3B81B8DD7219AF1605BFBA73301C8BF015CB684EFB17F095073878F05");
  setdvarifuninitialized("_encstr_92D5125FF90A933B0FA2F0D908B7EE602B59FBDB", 5);
  setdvarifuninitialized("_encstr_A63114F0FA7215D87F6231BD4C8363E79B3018E0B2CF", 2250);
  level.get_tier_reward_for_total_time = [];
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"] = spawnStruct();
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].weaponname = "_encstr_8ED01022406F60CB51BD13885E3BA80F33E8";
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].modelname = "_encstr_AC031B3F45FE086186D1BE0C7FB6A87F02CA27A61FF0013B1AF8902F4A";
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].spawn_guys_at_lz = &"_encstr_AD8C1C8589A926E2306F0801FB1B8FCF193BE95F39A9C7C74A10514F08B5";
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].leader_charge_dialogue = ::get_silencedshot_alias;
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].leader_intro_dialogue = "_encstr_A13715C36A3BB9E9939D5B771EB7300FAAEBCEA15FB842";
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].leaderboard_enabled = "_encstr_828F143B6F8001C723B7F1DB9B7A986828428651D4D2";
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].playerzombieaddhudelem = "_encstr_839D13EBFD13D94B28538A5429E89CB278056F6753";
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"]._id_13711 = "_encstr_8E810FDDABB3980829DAE1BE821808C5CB";
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].playerzombiecleanuppowers = "_encstr_B271115EA9F0E94B4DBBA31FB7FF635660D0D7";
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"]._id_1459B = getcompleteweaponname(level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].weaponname);
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].playerzombiebacktohuman = "_encstr_BD441EB3566E7D6CC227E44B8598B1B2F5D9B06EBD36A5B9957DB49D375A472B";
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].playerzombiecleanup = "_encstr_8A072798C352AF90FFD32771E420E0C8D75A73638A8FC68097E76F4B038D58ABBBB22E88F2DB8BB8AF";
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].playerzombiecleanupkeybindings = "_encstr_92FB1738118B5DFC03D052E06F381B4071EDD349FF1DD9A3C1";
  level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"].playerzombieapplyemp = 1.23;
  level._effect["_encstr_99FF12ABF9F06F0A1E4767DBD7C7A2B7E8E022F7"] = loadfx("_encstr_AD912F2B3DD31E8158DA01568BC2D993A14BC3FB07F66353A818850D63A078A90EC5CE9F25287B3DC9C1BC22391A3672DB");
  level._effect["_encstr_A13715C36A3BB9E9939D5B771EB7300FAAEBCEA15FB842"] = loadfx("_encstr_82C02A933ABBC0189370FFFD42ED30B7D762EB78920BA5F2EB06B98F686298FF2F6AC1A67AEBDF39C51983F5");
  level._effect["_encstr_828F143B6F8001C723B7F1DB9B7A986828428651D4D2"] = loadfx("_encstr_AB0A299D991EBC2DBB837D31E4792BC55DB483D6AC73E897B3663CAF07E4B7C1169B59F556E138AFC296E4");
  level._effect["_encstr_839D13EBFD13D94B28538A5429E89CB278056F6753"] = loadfx("_encstr_91172FD9CC0FF2D2DDE07D899CE52D373658E646793657B9E8DBAD97CE333C7D263999BEB1B0B95A6E3A5693EB99EA9BAC");
  level._effect["_encstr_8E810FDDABB3980829DAE1BE821808C5CB"] = loadfx("_encstr_958324D999F0E5D2DD1CBEC4275E95E2AB96C1DACAB98E79D9990F7DCC969CACFA6E07DB5747");
  level.scr_animtree["_encstr_8BB007E03658CBCAE4"] = #animtree;
  level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_82801A611AC33E48A69A2923BF8E500E27421929531FFF983B713F31"] = % _encstr_92B52DECB5FACAE2EB6C584E4E96C2268DCAD7EC0B6EED63D2B956EBB09B6CACB99159C9F516D1E8B03686BE83C69C;
  level.scr_animname["_encstr_8BB007E03658CBCAE4"]["_encstr_82801A611AC33E48A69A2923BF8E500E27421929531FFF983B713F31"] = "_encstr_92B52DECB5FACAE2EB6C584E4E96C2268DCAD7EC0B6EED63D2B956EBB09B6CACB99159C9F516D1E8B03686BE83C69C";
  level.scr_eventanim["_encstr_8BB007E03658CBCAE4"]["_encstr_82801A611AC33E48A69A2923BF8E500E27421929531FFF983B713F31"] = "_encstr_82801A611AC33E48A69A2923BF8E500E27421929531FFF983B713F31";
  level.scr_animtree["_encstr_9690073295D94B8D59"] = #animtree;
  level.scr_anim["_encstr_9690073295D94B8D59"]["_encstr_8CDC21276B9E83C990D995DF96781B6AFD9DA3B7F550AABD70804E278E404453471F1B"] = % _encstr_93B332101FF70943694E3FBEE2E2AB113CD7C9189773ED01523525D03E7BF7B9964B90080739BBF9FA1EABD816133F61CEE36880;
  level.scr_animname["_encstr_9690073295D94B8D59"]["_encstr_8CDC21276B9E83C990D995DF96781B6AFD9DA3B7F550AABD70804E278E404453471F1B"] = "_encstr_93B332101FF70943694E3FBEE2E2AB113CD7C9189773ED01523525D03E7BF7B9964B90080739BBF9FA1EABD816133F61CEE36880";
  level.scr_eventanim["_encstr_9690073295D94B8D59"]["_encstr_8CDC21276B9E83C990D995DF96781B6AFD9DA3B7F550AABD70804E278E404453471F1B"] = "_encstr_8CDC21276B9E83C990D995DF96781B6AFD9DA3B7F550AABD70804E278E404453471F1B";
  level._id_1403D = [];
  level.get_target_spotted_alias = [];
  scripts\engine\scriptable::_id_12F5B("_encstr_8814141B937EFB8A459EF4EE8E1182BFE3B087B78033", ::_id_12F63);
  scripts\engine\scriptable::_id_12F5A(::_id_12F61);
  level thread handle_tank_spawning();
}

_id_13545(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {}

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  level._id_1403D = scripts\engine\utility::array_removeundefined(level._id_1403D);
  var_3 = getdvarint("_encstr_BE032612A15897E286073F2F45AE1AE160E80F9198286809550D6B0761D3A15B10B384E6D1183D03", 50);

  if(level._id_1403D.size >= var_3) {
    var_4 = 999999999;
    var_5 = undefined;

    foreach(var_7 in level._id_1403D) {
      if(istrue(var_7.playerzombiecleanuphud) || var_7 islinked()) {
        continue;
      }
      if(var_7.waittillmatchstarts < var_4) {
        var_4 = var_7.waittillmatchstarts;
        var_5 = var_7;
      }
    }

    if(!isDefined(var_5)) {}

    var_5 delete();
  }

  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_9 setModel(var_0.modelname);
  var_9.angles = var_2;
  var_9.get_teaminquiry_alias = var_0;
  var_9 get_station_index_in_active_stations(var_0);
  level._id_1403D = scripts\engine\utility::array_add(level._id_1403D, var_9);
  return var_9;
}

handle_tank_spawning() {
  foreach(var_1 in level._id_1403D) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1 islinked())
      var_1 get_subway_train_hit_damage_multiplier(1);

    var_1 delete();
  }

  level._id_1403D = [];

  switch (getdvarint("_encstr_934A1EB936E4FAC439AF6C589393965813C6ACBE6EC1C2BBDCFAE6979B8E59AD", 0)) {
    case 0:
      _id_1351F();
      break;
    case 1:
      _id_1351C();
      break;
    case 2:
      _id_1351D();
      break;
    default:
      _id_1351F();
      break;
  }
}

_id_1351F() {
  var_0 = getentitylessscriptablearrayinradius("_encstr_A743210E7A23E7C0C1CB62243DF1D8BA87CB164BDD7367F660A1D9E72163F0CC7B0350", "_encstr_AC110A7F14873B5B3D073009");
  var_1 = var_0;

  if(var_1.size == 0) {
    return;
  }
  var_2 = getdvarfloat("_encstr_92EB1E274FE368D8A201B1C9728A48BF3A9BF3F7976BCF28C669B9E05E4E20E5", 0);
  var_3 = floor(var_2 * var_1.size);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_4 < var_3) {
      var_1[var_4] setscriptablepartstate("_encstr_8814141B937EFB8A459EF4EE8E1182BFE3B087B78033", "_encstr_BE8B08E323FB2BCD6268");
      continue;
    }

    var_1[var_4] setscriptablepartstate("_encstr_8814141B937EFB8A459EF4EE8E1182BFE3B087B78033", "_encstr_95DF070DD22319CA9B");
  }
}

_id_1351D() {
  var_0 = getdvarfloat("_encstr_92EB1E274FE368D8A201B1C9728A48BF3A9BF3F7976BCF28C669B9E05E4E20E5", 0);
  var_1 = scripts\engine\utility::array_randomize(getentitylessscriptablearrayinradius("_encstr_A743210E7A23E7C0C1CB62243DF1D8BA87CB164BDD7367F660A1D9E72163F0CC7B0350", "_encstr_AC110A7F14873B5B3D073009"));

  if(var_1.size > 0) {
    var_2 = floor(var_0 * var_1.size);

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_3 < var_2) {
        var_1[var_3] setscriptablepartstate("_encstr_8814141B937EFB8A459EF4EE8E1182BFE3B087B78033", "_encstr_BE8B08E323FB2BCD6268");
        continue;
      }

      var_1[var_3] setscriptablepartstate("_encstr_8814141B937EFB8A459EF4EE8E1182BFE3B087B78033", "_encstr_95DF070DD22319CA9B");
    }
  }
}

_id_1351C() {
  var_0 = scripts\engine\utility::array_randomize(getentitylessscriptablearrayinradius("_encstr_A743210E7A23E7C0C1CB62243DF1D8BA87CB164BDD7367F660A1D9E72163F0CC7B0350", "_encstr_AC110A7F14873B5B3D073009"));

  if(var_0.size == 0) {
    return;
  }
  var_1 = [];
  var_1["_encstr_921814D3D7C8080FE37CA49B5D92B8C1F9DB154BCDF0"] = (11086, -12336, 0);
  var_1["_encstr_967B0985969CCC2D561B19"] = (-21484, -22516, 0);
  var_1["_encstr_8D9708AFC2079025B13D"] = (-17334, 47252, 0);
  var_1["_encstr_B2280A3A935086C353C1623A"] = (52009, 20904, 0);
  var_1["_encstr_8BDC089661282C1206FB"] = (12090, 13317, 0);
  var_1["_encstr_8D0308D858C14BD15836"] = (22833, -47700, 0);
  var_1["_encstr_81AB066CB069AF22"] = (14082, 50019, 0);
  var_1["_encstr_99E00710F71780B782"] = (-45466, -19181, 0);
  var_1["_encstr_A56206DAA57359E6"] = (-6589, 14626, 0);
  var_1["_encstr_88390E5379600810276F0829C1AA3845"] = (-5862, -46402, 0);
  var_1["_encstr_BD7D0796D1CE57163B"] = (42804, -43023, 0);
  var_1["_encstr_B46A066BF3D0B56F"] = (-44348, 19225, 0);
  var_1["_encstr_92740733B8CDD38F2A"] = (42214, 39322, 0);
  var_1["_encstr_A1330ECE258AC1EAA3A293B096A7BF72"] = (44138, -20531, 0);
  var_1["_encstr_B1B708EC8C1209E1AF57"] = (-33835, -1222, 0);
  var_2 = [];

  foreach(var_5, var_4 in var_1)
  var_2[var_5] = [];

  foreach(var_7 in var_0) {
    var_8 = undefined;
    var_9 = 99999;

    foreach(var_5, var_4 in var_1) {
      var_11 = distance2d(var_7.origin, var_4);

      if(var_11 < var_9) {
        var_9 = var_11;
        var_8 = var_5;
      }
    }

    var_7 setscriptablepartstate("_encstr_8814141B937EFB8A459EF4EE8E1182BFE3B087B78033", "_encstr_95DF070DD22319CA9B");
    var_2[var_8][var_2[var_8].size] = var_7;
  }

  foreach(var_5, var_14 in var_2) {
    var_15 = getdvarfloat("_encstr_AFAF1F371B4EEBC4E4BE1BB093C9A5C231C6ACD7B91CB0DDDC7D36342C73B195F5" + var_5, getdvarfloat("_encstr_92EB1E274FE368D8A201B1C9728A48BF3A9BF3F7976BCF28C669B9E05E4E20E5", 0));
    var_16 = var_14;
    var_17 = 0;

    foreach(var_7 in var_14) {
      if(isDefined(var_7.script_noteworthy) && var_7.script_noteworthy == "_encstr_A1990B76B843875FE778E29B90") {
        var_7 mortar_start();
        var_16 = scripts\engine\utility::array_remove(var_16, var_7);
        var_17++;
      }
    }

    var_20 = floor(float(var_15) * (var_14.size - var_17));

    if(var_20 <= 0)
      continue;
    else {
      for(var_21 = 0; var_21 < var_20; var_21++)
        var_16[var_21] mortar_start();
    }
  }
}

mortar_start() {
  self setscriptablepartstate("_encstr_8814141B937EFB8A459EF4EE8E1182BFE3B087B78033", "_encstr_BE8B08E323FB2BCD6268");
}

_id_12F63(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level.gameended)) {
    return;
  }
  if(!var_3 scripts\cp_mp\utility\player_utility::_isalive() || istrue(var_3.inlaststand)) {
    return;
  }
  if(var_3 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    if(isDefined(level.showuseresultsfeedback)) {
      var_3[[level.showuseresultsfeedback]](17);
      return;
    }
  }

  if(!var_0 get_sight_dist_for_taccover_check(var_3)) {
    return;
  }
  if(var_2 == "_encstr_BE8B08E323FB2BCD6268") {
    var_5 = level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"];

    if(var_0.type == "_encstr_BE0A1566C6BF32694380BFA738B825B9B95EAD9A2775EA")
      var_5 = level.get_tier_reward_for_total_time["_encstr_96EA088393BD1CB09BAC"];

    if(var_0.type == "_encstr_85E418214B17D668C22A838B222D2BB0AB525BAB22131858DC1E")
      var_5 = level.get_tier_reward_for_total_time["_encstr_93FE0BCA2BC3BA9F93A06861C8"];

    var_0 setscriptablepartstate("_encstr_8814141B937EFB8A459EF4EE8E1182BFE3B087B78033", "_encstr_95DF070DD22319CA9B");
    level notify("_encstr_8C8C18773BCED399E0A9C58F2698D16AA92F0FF7B979CA5DB016" + var_0.origin);
    var_6 = _id_13545(var_5, var_3.origin);
    var_6 thread get_stay_at_station_time(var_3);
    level thread _id_12C90(var_0, var_1);
  }
}

tv_station_fastrope_two_infil_start_targetname_array_index(var_0) {
  return var_0.type == "_encstr_91361613EE974BD9233224936601C9C72707C3D8E2378029" || var_0.type == "_encstr_85E418214B17D668C22A838B222D2BB0AB525BAB22131858DC1E" || var_0.type == "_encstr_BE0A1566C6BF32694380BFA738B825B9B95EAD9A2775EA";
}

_id_12F61(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_2) || !tv_station_fastrope_two_infil_start_targetname_array_index(var_2)) {
    return;
  }
  level thread _id_12F62(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_12F62(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  waittillframeend;
  var_11 = level.get_tier_reward_for_total_time["_encstr_8B050919C7EFF0F1785A6F"];

  if(var_2.type == "_encstr_BE0A1566C6BF32694380BFA738B825B9B95EAD9A2775EA")
    var_11 = level.get_tier_reward_for_total_time["_encstr_96EA088393BD1CB09BAC"];

  if(var_2.type == "_encstr_85E418214B17D668C22A838B222D2BB0AB525BAB22131858DC1E")
    var_11 = level.get_tier_reward_for_total_time["_encstr_93FE0BCA2BC3BA9F93A06861C8"];

  level notify("_encstr_8C8C18773BCED399E0A9C58F2698D16AA92F0FF7B979CA5DB016" + var_2.origin);
  var_12 = _id_13545(var_11, var_2.origin, var_2.angles);
  var_12.owner = var_1;
  var_12.team = var_1.team;
  var_12 thread[[var_11.leader_charge_dialogue]]();
  var_12 makeunusable();
  var_12 hide();

  if(isDefined(level._id_12074) && isPlayer(var_1) && istrue(var_1.should_take_damage) && isDefined(var_6)) {
    var_13 = 0;

    if(isDefined(var_1.showassassinationtargethud)) {
      var_14 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_6);

      if(scripts\engine\utility::array_contains_key(var_1.showassassinationtargethud, var_14))
        var_13 = 1;
    }

    if(var_13) {
      var_12.updateteamplunderscore = 1;
      var_12 thread _luidecision::playericonfilter(var_1, var_12.origin, "_encstr_91D208889782ABF71F0B", level.getserverroomspawnpoint.get_ai_within_range);
      var_12 thread _id_13580();
    }
  }

  wait 5;

  if(isDefined(var_12))
    var_12 delete();
}

_id_12C90(var_0, var_1) {
  var_2 = getdvarfloat("_encstr_83791E9327703163D61ECA12432E877628913D379DA04273773312F9AB8BEF2F", 0);

  if(var_2 == 0) {
    return;
  }
  wait(var_2);
  var_0 setscriptablepartstate("_encstr_8814141B937EFB8A459EF4EE8E1182BFE3B087B78033", "_encstr_BE8B08E323FB2BCD6268");
}

_id_13518(var_0) {
  var_1 = "_encstr_8B050919C7EFF0F1785A6F";

  if(var_0.script_noteworthy == "_encstr_B1EE12BF528ACBC8E7FAC173114A3BBDC97B405F")
    var_1 = "_encstr_96EA088393BD1CB09BAC";

  if(var_0.script_noteworthy == "_encstr_856515461EB27669B6D5CC51762D8DD3EB377937131460")
    var_1 = "_encstr_93FE0BCA2BC3BA9F93A06861C8";

  var_2 = level.get_tier_reward_for_total_time[var_1];
  var_3 = _id_13545(var_2, var_0.origin);
}

get_station_index_in_active_stations(var_0) {
  self.start_origin = self.origin;
  self.get_teaminquiry_alias = var_0;

  if(!isDefined(self.script_health))
    self.script_health = 16;

  self setHintString(self.get_teaminquiry_alias.spawn_guys_at_lz);
  self sethintdisplayfov(20);
  self setuseholdduration("_encstr_82370F09B522B08D175A6876A32BC8E07B");
  self sethintrequiresholding(0);
  self setusefov(20);
  self disablemissilestick();
  get_subway_car_available_to_deploy();
}

get_subway_train_hit_damage() {
  self.origin = self.start_origin;
  self show();
  get_subway_car_available_to_deploy();
}

get_subway_car_available_to_deploy() {
  self _meth_87CD(0);
  self physics_takecontrol(1);
  self physics_registerforcollisioncallback();
  thread get_tag_to_target();
  thread get_swivel_spawnpoint();
  self.waittillmatchstarts = gettime();
  self.team = undefined;

  if(!isDefined(self.playerzombiecleanuphud))
    self.playerzombiecleanuphud = 0;

  if(!self.playerzombiecleanuphud) {
    self makeusable();
    thread get_stealth_alert_music_alias();
    thread get_starting_ai_per_site();
  }

  if(self.script_health > 0) {
    self setCanDamage(1);
    self.is_first_time_high_tier = 0;
    self.health = 99999999;
    thread get_sight_dist_for_vehicle_check();
  }
}

get_sight_dist_for_vehicle_check() {
  self notify("_encstr_A9711699AE8A684B1283C9D35F6A87283187C19653C1F8FD");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A9711699AE8A684B1283C9D35F6A87283187C19653C1F8FD");

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    self.health = 99999999;

    if(var_0 < 14) {
      continue;
    }
    if(isDefined(var_1.owner) && isDefined(var_1.owner.vehicle)) {
      var_10 = var_1.owner.vehicle vehicle_getvelocity();
      var_11 = sqrt(vectordot(var_10, var_10));

      if(var_11 > 400) {
        self.owner = undefined;
        self.team = undefined;
        thread get_smoke_grenade_start_pos();
        return;
      }
    } else {
      switch (var_4) {
        case "_encstr_8D4E0A501FCB898912CB3FA3":
        case "_encstr_A1ED0BA9FF84562B60BA073E83":
        case "_encstr_A6C7065BACB1CA95":
        case "_encstr_8DED0A21C79B660BC7588981":
          break;
        default:
          var_12 = isDefined(var_1) && scripts\mp\utility\damage::attackerishittingteam(self, var_1);

          if(!var_12) {
            if(isDefined(var_1)) {
              self.owner = var_1;
              self.team = var_1.team;
            }

            if(isDefined(level._id_12074) && isPlayer(var_1) && istrue(var_1.should_take_damage) && isDefined(var_9)) {
              var_13 = 0;

              if(isDefined(var_1.showassassinationtargethud)) {
                var_14 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt(var_9);

                if(scripts\engine\utility::array_contains_key(var_1.showassassinationtargethud, var_14))
                  var_13 = 1;
              }

              if(var_13) {
                self.updateteamplunderscore = 1;
                thread _luidecision::playericonfilter(var_1, self.origin, "_encstr_91D208889782ABF71F0B", level.getserverroomspawnpoint.get_ai_within_range);
                thread _id_13580();
              }
            }

            thread get_smoke_grenade_start_pos();
            return;
          }
      }
    }
  }
}

_id_13580() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_0 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  waitframe();
  var_0._id_14293 = playFXOnTag(scripts\engine\utility::getfx("_encstr_BDA120EBD40B189DE383B971E7B8F0C8B53223D72B9810094D295B44E5C9EF60E228"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  wait 8.0;
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_BDA120EBD40B189DE383B971E7B8F0C8B53223D72B9810094D295B44E5C9EF60E228"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 delete();
}

get_spaced_out_station_names_on_track(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
    var_0 endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  }

  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");

  if(isDefined(var_1))
    wait(var_1);

  self.playerzombiecleanuphud = 1;
  self setscriptablepartstate("_encstr_927805C3B3EE02", "_encstr_8CA609D2B03BC1C1167C10");
  playFXOnTag(level._effect[self.get_teaminquiry_alias.playerzombieaddhudelem], self, "_encstr_B2BF0708BA770F795B");

  if(isDefined(var_0) && isDefined(self.get_teaminquiry_alias.playerzombiecleanupkeybindings)) {
    var_0 setscriptablepartstate("_encstr_B87B13777AA15F2A6AB44EC0DFE33A2FE7577F5A60", self.get_teaminquiry_alias.playerzombiecleanupkeybindings, 0);
    var_0 setscriptablepartstate("_encstr_8BCB142FF5C8CA2F7DF46C51116F18A10B35F7591758", self.get_teaminquiry_alias.playerzombiecleanupkeybindings, 0);
    var_0 thread _encstr_968510DAB4B163EBB14BCED047B24EF599C3();
  }
}

_encstr_968510DAB4B163EBB14BCED047B24EF599C3() {
  wait 2;

  if(isDefined(self)) {
    self setscriptablepartstate("_encstr_B87B13777AA15F2A6AB44EC0DFE33A2FE7577F5A60", "_encstr_A7A408B9CA5D1D4E2C63", 0);
    self setscriptablepartstate("_encstr_8BCB142FF5C8CA2F7DF46C51116F18A10B35F7591758", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  }
}

get_spotlight_goal_node(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A31C07E04BD8ADABE0");
  self endon("_encstr_BE5B0C66315576725DA7C2E34708");

  if(0)
    thread get_start_ang(var_0);

  if(!istrue(var_0.usingascender) && !istrue(var_0._id_140AF))
    var_0 setclientomnvar("_encstr_BEE715E778DE5A1BFFF4168AF0AF62EE669B7B3F687383", 2);

  var_2 = getdvarfloat("_encstr_92D5125FF90A933B0FA2F0D908B7EE602B59FBDB", 5);

  if(istrue(var_1))
    var_2 = var_2 + 2.1;

  wait(var_2);
  self.owner = var_0;
  self.team = var_0.team;
  thread get_smoke_grenade_start_pos();
}

get_start_ang(var_0) {
  var_1 = var_0 scripts\mp\hud_util::createprimaryprogressbar();
  var_2 = var_0 scripts\mp\hud_util::createprimaryprogressbartext();
  var_2 settext("_encstr_8A8D09ED3751C56A3C24F7");
  var_3 = getdvarfloat("_encstr_92D5125FF90A933B0FA2F0D908B7EE602B59FBDB", 5);

  if(var_3 <= 0)
    var_3 = 1;

  var_1 scripts\mp\hud_util::updatebar(0, 1 / var_3);
  var_0 scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", "_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  var_1 scripts\mp\hud_util::destroyelem();
  var_2 scripts\mp\hud_util::destroyelem();
}

get_spawncount_from_groupnames() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");

  if(istrue(self.playerzombiecleanuphud)) {
    waitframe();
    get_spaced_out_station_names_on_track(undefined, undefined);
  }
}

get_stealth_breaking_guilty_player_name(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 = getcompleteweaponname(var_0);
  self giveandfireoffhand(var_2);
  scripts\common\utility::allow_fire(0, "_encstr_995011C631886A82BFCDB36F7F55EBA468FBFF");
  wait(var_1);
  scripts\common\utility::allow_fire(1, "_encstr_995011C631886A82BFCDB36F7F55EBA468FBFF");

  if(self hasweapon(var_2))
    self takeweapon(var_2);
}

get_spawn_delay(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  var_1 = self getgestureanimlength(var_0.get_teaminquiry_alias.playerzombiebacktohuman);
  thread get_stealth_breaking_guilty_player_name(var_0.get_teaminquiry_alias.playerzombiecleanup, var_1);

  if(isDefined(var_0.get_teaminquiry_alias.playerzombieapplyemp))
    var_2 = var_0.get_teaminquiry_alias.playerzombieapplyemp;
  else
    var_2 = var_1;

  var_0 thread get_spaced_out_station_names_on_track(self, var_2);
  wait 1.75;
}

get_specific_truck(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  self endon("_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC");
  self endon("_encstr_9612118A91860B9CC015B48557F82287A5E872");

  for(;;) {
    self waittill("_encstr_A96D1739AB8BD05012DBF9D3972B0DB933062333D4C1A0F18A");

    if(self getcurrentweapon() == var_0.get_teaminquiry_alias._id_1459B && !self attackButtonPressed()) {
      self disableweaponswitch();
      self enableoffhandweapons();
      var_0 thread get_spotlight_goal_node(self, 1);
      get_spawn_delay(var_0);
      self disableoffhandweapons();
      self enableweaponswitch();
      return;
    }
  }
}

get_smoke_grenade_start_pos(var_0) {
  if(istrue(self.exploded)) {
    return;
  }
  self.exploded = 1;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self notify("_encstr_860808CB78E2984063BA");
  level notify("_encstr_8C8C18773BCED399E0A9C58F2698D16AA92F0FF7B979CA5DB016" + self.origin);

  if(istrue(self.playerzombiecleanuphud))
    stopFXOnTag(level._effect[self.get_teaminquiry_alias.playerzombieaddhudelem], self, "_encstr_B2BF0708BA770F795B");

  if(isDefined(self.carrier)) {
    thread get_station_track_available_time_stamp((0, 0, -90), self.carrier);
    wait 0.1;
  }

  if(!istrue(self.updateteamplunderscore))
    self[[self.get_teaminquiry_alias.leader_charge_dialogue]](var_0);

  self makeunusable();
  self hide();
  self.origin = self.origin + (0, 0, 10000);
  wait 5;
  self delete();
}

get_stealth_alert_music_alias() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A31C07E04BD8ADABE0");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(isDefined(var_0) && isalive(var_0) && get_sight_dist_for_taccover_check(var_0)) {
      thread get_stay_at_station_time(var_0);
      return;
    }
  }
}

get_stay_at_station_time(var_0) {
  self notify("_encstr_A31C07E04BD8ADABE0");
  level notify("_encstr_8C8C18773BCED399E0A9C58F2698D16AA92F0FF7B979CA5DB016" + self.origin);
  var_1 = self getlinkedparent();

  if(isDefined(var_1))
    self unlink();

  self physicslaunchserver(self.origin, (0, 0, 0));
  self physicsstopserver();
  self show();
  self hide();
  self linkTo(var_0, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5", (0, 0, 0), (0, 0, 0));

  if(isDefined(self.projectile))
    self.projectile delete();

  self setotherent(var_0);
  self makeunusable();
  self.carrier = var_0;
  self.owner = var_0;
  self.team = var_0.team;
  var_0 scripts\mp\equipment::allow_equipment(0, "_encstr_87660AB185399CB40B896359");
  var_0.iscarrying = 1;
  var_0._id_1286C = var_0 getcurrentweapon();
  var_0 giveweapon(self.get_teaminquiry_alias._id_1459B);
  var_0 setweaponammoclip(self.get_teaminquiry_alias._id_1459B, 1);
  var_0 switchtoweapon(self.get_teaminquiry_alias._id_1459B);
  var_0 thread little_bird_mg_initfx();
  var_0 thread _encstr_9BA52378E712138B42D6718DE12BF379632F68217BD929592AFAE00582F20926D33358489F();
  var_0 scripts\engine\utility::_id_143A9("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_88A80D134FDE4B2FA8A7CBBF2B45DD", "_encstr_9645168BA7FB3B20F809CA3B218389F35EA778E86748C1C9", "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_A9DC0ADD30B7CA719938B7E3", "_encstr_9A1612DCD50756E4EBBAB92BBEB91D0B933A5646");

  if(!isalive(var_0) || var_0 getcurrentweapon() != self.get_teaminquiry_alias._id_1459B) {
    if(isDefined(var_0)) {
      var_0 enableoffhandweapons();
      var_0 scripts\mp\equipment::allow_equipment(1, "_encstr_87660AB185399CB40B896359");
      var_0.iscarrying = 0;
      var_0 takeweapon(self.get_teaminquiry_alias._id_1459B);
      var_0._id_1286C = undefined;
      var_0 notify("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
    }

    self.owner = undefined;
    self.carrier = undefined;
    self.team = undefined;
    self setotherent(undefined);
    self unlink();
    self show();
    var_2 = anglesToForward(self.angles) * 40;
    get_station_names_on_track(var_2);
    get_subway_car_available_to_deploy();
    return;
  }

  self _meth_87CD(1);
  self _meth_87C8(1);
  var_0.get_search_turret_target_player = self;

  if(!isai(var_0)) {
    var_0 notifyonplayercommand("_encstr_839C1983FB15AA4940F64E138BD09DE3ED77372F7DBEE20158B847", "_encstr_9B0D065699E485D9");
    var_0 notifyonplayercommand("_encstr_839C1983FB15AA4940F64E138BD09DE3ED77372F7DBEE20158B847", "_encstr_8E5F0795E6AD7BAD2B");
    var_0 notifyonplayercommand("_encstr_A96D1739AB8BD05012DBF9D3972B0DB933062333D4C1A0F18A", "_encstr_97120D65B983599519EB1D86C9B7EE");

    if(!var_0 isconsoleplayer())
      var_0 notifyonplayercommand("_encstr_A96D1739AB8BD05012DBF9D3972B0DB933062333D4C1A0F18A", "_encstr_A2071122CC07510FDD9AD8F8D3391108DB4F94");
  }

  var_0 disableoffhandweapons();
  var_3 = var_0 scripts\mp\supers::getcurrentsuper();

  if(isDefined(var_3)) {
    if(var_3.staticdata.ref != "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D") {
      var_4 = var_3.staticdata.weapon;
      var_5 = var_0 getweaponammoclip(var_4);
      var_0 scripts\common\utility::allow_supers(0, "_encstr_87660AB185399CB40B896359");
      var_0 setweaponammoclip(var_4, var_5);
    }
  } else
    var_0 scripts\common\utility::allow_supers(0, "_encstr_87660AB185399CB40B896359");

  var_0 allowmelee(0);
  var_0 allowsupersprint(0);
  var_0 scripts\common\utility::allow_prone(0, "_encstr_87660AB185399CB40B896359");
  var_0._encstr_A5771B72EEE7064E3DD441BD69F031417B874B1B68F2B2E7380E284285 = 1;
  var_0 thread get_successful_vehicle_spawns_from_module(self);
  var_0 thread get_specific_truck(self);
  var_0 thread get_target_located(self, "_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC");
  var_0 thread get_target_located(self, "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  var_0 thread get_stealth_broken_music_alias(self);
  var_0 thread get_strafe_target_loc(self);
  var_0 thread get_smallest_cumulative_damage();
  var_0 setclientomnvar("_encstr_BEE715E778DE5A1BFFF4168AF0AF62EE669B7B3F687383", 1);
}

_id_140C1(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0))
      return 0;

    foreach(var_3 in level.get_tier_reward_for_total_time) {
      if(var_3._id_1459B == var_0)
        return 0;
    }

    var_1 = var_0.basename;
  }

  if(isstring(var_0)) {
    if(var_0 == "_encstr_8BBA05185F8B99")
      return 0;

    foreach(var_3 in level.get_tier_reward_for_total_time) {
      if(var_3._id_1459B.basename == var_0)
        return 0;
    }

    var_1 = var_0;
  }

  if(scripts\mp\utility\killstreak::isremotekillstreakweapon(var_1))
    return 0;

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0))
    return 0;

  return 1;
}

get_sight_dist_for_taccover_check(var_0) {
  if(!isPlayer(var_0))
    return 0;

  if(var_0 isonladder())
    return 0;

  if(!var_0 scripts\common\utility::is_weapon_allowed())
    return 0;

  if(var_0 scripts\mp\supers::issuperinuse()) {
    var_1 = var_0 scripts\mp\supers::getcurrentsuper();

    if(var_1.staticdata.ref != "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D")
      return 0;
  }

  if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  if(istrue(var_0.inlaststand))
    return 0;

  if(istrue(var_0.isreviving))
    return 0;

  if(var_0 isskydiving())
    return 0;

  if(istrue(var_0.iszombie))
    return 0;

  if(istrue(var_0.isjuggernaut)) {
    if(isDefined(level.showuseresultsfeedback)) {
      var_0[[level.showuseresultsfeedback]](16);
      return 0;
    }
  }

  if(isDefined(var_0.manuallyjoiningkillstreak) && var_0.manuallyjoiningkillstreak)
    return 0;

  if(istrue(var_0.iscarrying)) {
    if(isDefined(level.showuseresultsfeedback)) {
      var_0[[level.showuseresultsfeedback]](3);
      return 0;
    }
  }

  var_2 = var_0 getcurrentweapon();

  if(isDefined(var_2)) {
    if(!_id_140C1(var_2)) {
      var_0 scripts\mp\hud_message::showerrormessage("_encstr_97911CFB309569F34788CDD6616BBC8156BC63678BE6D1A84721A69F2917");
      return 0;
    }
  }

  var_3 = var_0.changingweapon;

  if(isDefined(var_3) && var_0 isswitchingweapon()) {
    if(!_id_140C1(var_3))
      return 0;
  }

  if(var_0 scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
    var_3 = var_0 scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();

    if(!_id_140C1(var_3))
      return 0;
  }

  if(var_0 scripts\mp\utility\player::isusingremote())
    return 0;

  if(istrue(self.playerzombiecleanuphud))
    return 0;

  if(istrue(var_0.tracking_max_health))
    return 0;

  return 1;
}

get_successful_vehicle_spawns_from_module(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  var_1 = 0;
  var_2 = getdvarfloat("_encstr_A63114F0FA7215D87F6231BD4C8363E79B3018E0B2CF", 2250);

  for(;;) {
    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_3, var_4);

    if(var_4 != var_0.get_teaminquiry_alias._id_1459B) {
      continue;
    }
    if(isDefined(var_3))
      var_3 laser_vfx_start_pos();

    self setweaponammoclip(var_0.get_teaminquiry_alias._id_1459B, 0);
    break;
  }

  if(self issprintsliding()) {
    var_1 = -12;
    var_2 = var_2 + 200;
  }

  var_5 = self getplayerangles();
  var_5 = var_5 + (var_1, 0, 0);
  var_5 = (clamp(var_5[0], -85, 85), var_5[1], var_5[2]);
  var_6 = anglesToForward(var_5);
  var_0 thread get_station_track_available_time_stamp(var_6 * var_2, self);
}

laser_vfx_start_pos() {
  self endon("_encstr_AD75063D571AE108");
  waitframe();
  self delete();
}

little_bird_mg_initfx() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self disableweaponswitch();
  scripts\engine\utility::_id_143A6("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_AD75063D571AE108", "_encstr_99920C3D92FAE9EE6F73A0C06FAC");

  if(istrue(self.usingascender) || istrue(self._id_140AF)) {
    return;
  }
  self enableweaponswitch();
}

_encstr_9BA52378E712138B42D6718DE12BF379632F68217BD929592AFAE00582F20926D33358489F() {
  for(var_0 = 0; var_0 < 20; var_0++) {
    if(self isonladder())
      self notify("_encstr_A9DC0ADD30B7CA719938B7E3");

    waitframe();
  }
}

get_target_located(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  thread little_bird_mg_initfx();

  for(;;) {
    self waittill(var_1, var_2);

    if(istrue(self.usingascender)) {
      continue;
    }
    if(var_2 != var_0.get_teaminquiry_alias._id_1459B) {
      wait 0.34;
      break;
    }
  }

  var_0 thread get_subway_train_hit_damage_multiplier(0, 0.4);
}

get_smallest_cumulative_damage() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");

  for(;;) {
    self waittill("_encstr_839C1983FB15AA4940F64E138BD09DE3ED77372F7DBEE20158B847");
    scripts\mp\hud_message::showerrormessage("_encstr_97911CFB309569F34788CDD6616BBC8156BC63678BE6D1A84721A69F2917");
  }
}

get_strafe_target_loc(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");

  for(;;) {
    if(self isskydiving()) {
      break;
    }

    if(scripts\mp\supers::issuperinuse()) {
      var_1 = scripts\mp\supers::getcurrentsuper();

      if(var_1.staticdata.ref != "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D") {
        break;
      }
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
      break;
    }

    if(self isinexecutionattack() || self isinexecutionvictim()) {
      break;
    }

    waitframe();
  }

  var_0 thread get_subway_train_hit_damage_multiplier(0);
}

get_stealth_broken_music_alias(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  self waittill("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 = self getplayerangles();
  var_1 = (clamp(var_1[0], -85, 85), scripts\engine\utility::absangleclamp180(var_1[1]), 0);
  var_2 = anglesToForward(var_1);
  var_3 = 90;
  var_0 thread get_station_track_available_time_stamp(var_2 * var_3, self);
}

get_station_names_on_track(var_0, var_1, var_2) {
  self.origin_prev = undefined;
  var_3 = self;

  if(isDefined(var_1) && !var_1 isonladder()) {
    self.origin = var_1 gettagorigin("_encstr_8107069A17A718C5");
    self.angles = var_1 gettagangles("_encstr_8107069A17A718C5");
  }

  self dontinterpolate();

  if(istrue(var_2))
    self physicslaunchserver(self.origin, var_0 * 1.2);
  else
    self physicslaunchserver(self.origin + 10 * anglestoup(self.angles), var_0);

  _func_0441(self.origin, self.origin + vectorNormalize(var_0) * 30, 1000);
  thread get_target_group();
}

get_target_group() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A31C07E04BD8ADABE0");
  self endon("_encstr_860808CB78E2984063BA");
  var_0 = self.origin;

  for(;;) {
    var_1 = self.origin - var_0;
    var_2 = lengthsquared(var_1);

    if(var_2 > 225) {
      var_1 = vectorNormalize(var_1) * (sqrt(var_2) + 6);
      _func_0441(self.origin, self.origin + var_1, 1000);
    }

    var_0 = self.origin;
    waitframe();
  }
}

nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56");
}

get_sight_dist_for_laststand_check(var_0) {
  if(isDefined(var_0.equipmentref) && var_0.equipmentref == "_encstr_867010E842EB0B29AF8B8886074E3F2CB506")
    return 0;

  return 1;
}

get_sight_alias(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A31C07E04BD8ADABE0");
  self endon("_encstr_93510A16C71B20636A2AB8B8");

  if(var_1 > 1 || var_0[2] < 0.5)
    wait 2;
  else
    wait 0.5;

  if(!self islinked()) {
    var_2 = scripts\engine\trace::ray_trace(self.origin, (self.origin[0], self.origin[1], self.origin[2] - 10), [self]);
    var_3 = var_2["_encstr_850E077B0BF30318B9"];

    if(isDefined(var_3) && var_3 != self && (var_3 nuke_vault_suicidebomber_internal() || var_3 _meth_87C7()) && get_sight_dist_for_laststand_check(var_3)) {
      self linkTo(var_3);
      self _meth_87C9(1);
      self _meth_87C8(1);
    }
  }
}

get_tag_to_target() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A31C07E04BD8ADABE0");

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(!self islinked())
      thread get_sight_alias(var_5, var_6);
  }
}

get_station_track_available_time_stamp(var_0, var_1) {
  self.moverdoesnotkill = 1;
  get_subway_train_hit_damage_multiplier(1);
  get_station_names_on_track(var_0, var_1, 1);
  get_subway_car_available_to_deploy();
}

get_swivel_spawnpoint() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A31C07E04BD8ADABE0");
  var_0 = [["_encstr_AB141131ED579B8DB2BED8B0C976B2AFB9CC87", 20.0], ["_encstr_AB071298BD5DB96CB2F5B5B2C84BABB5D7B93387", 5.0], ["_encstr_8D9B112E851FC83FB5F1F363E36C4049B75938", 1.0]];

  while(isDefined(self)) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(self islinked()) {
      continue;
    }
    foreach(var_10 in var_0) {
      if(var_7 > var_10[1]) {
        if(self getscriptableparthasstate("_encstr_8C19042FD0EA", var_10[0]))
          self setscriptablepartstate("_encstr_8C19042FD0EA", var_10[0]);

        break;
      }
    }

    wait 0.125;
    self setscriptablepartstate("_encstr_8C19042FD0EA", "_encstr_921D09D9D9C0090D7275B4");
  }
}

get_subway_train_hit_damage_multiplier(var_0, var_1) {
  var_2 = 40;
  var_3 = 11.0;
  var_4 = 7.1;

  if(!isDefined(var_0))
    var_0 = 0;

  self.droptime = gettime();
  self notify("_encstr_88C60846397B83835919");
  var_5 = (0, 0, 0);
  var_6 = self.carrier;

  if(isDefined(var_6) && var_6.team != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    var_7 = var_6.origin;
    var_5 = var_6.angles;
    var_6 notify("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
    var_6 setclientomnvar("_encstr_BEE715E778DE5A1BFFF4168AF0AF62EE669B7B3F687383", 0);

    if(var_6 isonladder())
      var_7 = var_7 + anglesToForward((0, var_5[1], 0)) * -5;
  } else
    var_7 = self.start_origin;

  var_8 = (0, var_5[1], 0);
  var_9 = anglesToForward(var_8);
  var_7 = var_7 + ((0, 0, var_3) + var_4 * var_9);
  self.origin = var_7;
  self.angles = var_5;
  self show();
  var_10 = self getlinkedparent();

  if(isDefined(var_10))
    self unlink();

  get_too_far_dist_sq(var_1);
  self dontinterpolate();
  self.ownerteam = "_encstr_9A19040BCDBC";

  if(!var_0) {
    var_11 = var_9 * var_2;
    get_station_names_on_track(var_11, var_6);
    get_subway_car_available_to_deploy();
  }

  thread get_spawncount_from_groupnames();
  return 1;
}

get_too_far_dist_sq(var_0) {
  if(isDefined(self.carrier)) {
    self.carrier.iscarrying = undefined;
    self.carrier.get_search_turret_target_player = undefined;
    self setotherent(undefined);
    self.carrier thread get_total_from_call_count(var_0);
    self.carrier scripts\mp\equipment::allow_equipment(1, "_encstr_87660AB185399CB40B896359");

    if(!isai(self.carrier)) {
      self.carrier notifyonplayercommandremove("_encstr_839C1983FB15AA4940F64E138BD09DE3ED77372F7DBEE20158B847", "_encstr_9B0D065699E485D9");
      self.carrier notifyonplayercommandremove("_encstr_839C1983FB15AA4940F64E138BD09DE3ED77372F7DBEE20158B847", "_encstr_8E5F0795E6AD7BAD2B");
      self.carrier notifyonplayercommandremove("_encstr_A96D1739AB8BD05012DBF9D3972B0DB933062333D4C1A0F18A", "_encstr_97120D65B983599519EB1D86C9B7EE");

      if(!self.carrier isconsoleplayer())
        self.carrier notifyonplayercommandremove("_encstr_A96D1739AB8BD05012DBF9D3972B0DB933062333D4C1A0F18A", "_encstr_A2071122CC07510FDD9AD8F8D3391108DB4F94");
    }

    self.carrier enableoffhandweapons();

    if(self.carrier scripts\mp\supers::issuperinuse()) {
      var_1 = self.carrier scripts\mp\supers::getcurrentsuper();

      if(var_1.staticdata.ref != "_encstr_A66C12DE3B63AB1307C36048AB4308C15A655E6D")
        self.carrier scripts\common\utility::allow_supers(1, "_encstr_87660AB185399CB40B896359");
    } else
      self.carrier scripts\common\utility::allow_supers(1, "_encstr_87660AB185399CB40B896359");

    self.carrier allowmelee(1);
    self.carrier allowsupersprint(1);

    if(istrue(self.carrier._encstr_A5771B72EEE7064E3DD441BD69F031417B874B1B68F2B2E7380E284285)) {
      self.carrier scripts\common\utility::allow_prone(1, "_encstr_87660AB185399CB40B896359");
      self.carrier._encstr_A5771B72EEE7064E3DD441BD69F031417B874B1B68F2B2E7380E284285 = undefined;
    }

    self.carrier = undefined;
  }
}

get_total_from_call_count(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  foreach(var_2 in level.get_tier_reward_for_total_time) {
    if(self getcurrentweapon() == var_2._id_1459B) {
      if(self getweaponammoclip(var_2._id_1459B) == 0) {
        wait 0.6;

        if(isDefined(self._id_1286C))
          self switchtoweaponimmediate(self._id_1286C);
      } else {
        if(isDefined(var_0))
          wait(var_0);

        if(isDefined(self._id_1286C) && !istrue(self._id_140AF))
          self switchtoweaponimmediate(self._id_1286C);
      }

      self takeweapon(var_2._id_1459B);
      break;
    } else if(self hasweapon(var_2._id_1459B)) {
      self takeweapon(var_2._id_1459B);
      break;
    }
  }
}

isbossheli(var_0, var_1) {
  if(!isDefined(level._id_1403D)) {
    return;
  }
  var_2 = var_1 * var_1;

  foreach(var_4 in level._id_1403D) {
    if(isDefined(var_4) && !istrue(var_4._encstr_9BA90F89F5335DCDCAAF8D36AC0BDC5783) && !var_4 islinked() && distance2dsquared(var_4.origin, var_0) > var_2)
      var_4 thread _encstr_AB1317B12C279CA5B0C4D8B27D66BAB9B2EB361BCAB0735D38();
  }
}

_encstr_AB1317B12C279CA5B0C4D8B27D66BAB9B2EB361BCAB0735D38() {
  self._encstr_9BA90F89F5335DCDCAAF8D36AC0BDC5783 = 1;
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A31C07E04BD8ADABE0");
  self endon("_encstr_BE5B0C66315576725DA7C2E34708");
  thread get_spaced_out_station_names_on_track();
  var_0 = getdvarfloat("_encstr_92D5125FF90A933B0FA2F0D908B7EE602B59FBDB", 5);
  wait(var_0);
  thread get_smoke_grenade_start_pos();
}

get_starting_ai_per_site() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A31C07E04BD8ADABE0");
  var_0 = getdvarfloat("_encstr_B8E226B9D8C9D72627AF8DC29CC996B031C62BBEA573C2368E966795FAC859C6B28E59FA1D2DADB2", 300);

  if(var_0 == 0) {
    return;
  }
  wait(var_0);
  thread _encstr_AB1317B12C279CA5B0C4D8B27D66BAB9B2EB361BCAB0735D38();
}

get_silencedshot_alias(var_0) {
  var_1 = self.origin + (0, 0, -96);
  var_2 = physicstrace(self.origin, var_1);
  var_3 = var_2 == var_1;
  var_4 = "_encstr_A6030FE8D9A3D79807F8D72FB3EAEBE809";

  if(var_3)
    var_4 = "_encstr_8D7E0C49921308C8EEC46323F112";

  waitframe();
  var_5 = easepower("_encstr_914220FD9B691752F6F33AA35D2BC7A76BF3E8D9D00B039752609F8F9BC75913267A", var_2, (0, 0, 0));
  var_5 setscriptablepartstate("_encstr_8304168D58939CA598D895F5B23C1CC6F6C8CAFA890BCD56", var_4);
  var_5 thread hanging_crate_think(5);
  self radiusdamage(self.origin, level.get_station_controller_struct.plundertotal, level.get_station_controller_struct.plunderstructreplenish, level.get_station_controller_struct.plundertimer, self, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8ED01022406F60CB51BD13885E3BA80F33E8");
}

get_silo_thrust_spawnpoint() {
  var_0 = 2;
  var_1 = self.origin + (0, 0, -96);
  var_2 = physicstrace(self.origin, var_1);
  var_3 = var_2 == var_1;
  var_4 = "_encstr_A6030FE8D9A3D79807F8D72FB3EAEBE809";

  if(var_3)
    var_4 = "_encstr_8D7E0C49921308C8EEC46323F112";

  var_5 = easepower("_encstr_BED21FF65A310791CA7BE0A813FC29C73A407709F52BDB188EB730083F1861ED42", self.origin, self.angles);
  var_5 setscriptablepartstate("_encstr_8304168D58939CA598D895F5B23C1CC6F6C8CAFA890BCD56", var_4);
  var_5 thread hanging_crate_think(5);
  var_6 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  var_6.angles = self.angles;
  var_6.owner = self.owner;
  var_6.team = self.team;
  var_6.script_noteworthy = "_encstr_A6B70D2BB8D8DD491B70D50DE53793";
  var_6.weapon_name = "_encstr_973F0B6FB76B7F263B80193258";

  if(isPlayer(self.owner))
    self radiusdamage(var_6.origin, 250, 400, 1, self.owner, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_9AAE0876FCB7603101DB");
  else
    self radiusdamage(var_6.origin, 250, 400, 1, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_9AAE0876FCB7603101DB");

  var_7 = "_encstr_A32613817AA7C8780636EF8529AA2BB0DF03184B93";
  var_8 = 3;
  level.get_target_spotted_alias = scripts\engine\utility::array_removedead(level.get_target_spotted_alias);
  var_9 = 0;

  for(var_10 = relic_steelballs_slide(var_8); var_9 < var_8; var_9++) {
    if(level.get_target_spotted_alias.size >= 12) {
      break;
    }

    var_11 = magicgrenademanual(var_7, self.origin + var_10[var_9] * 0.02, var_10[var_9], 5);
    level.get_target_spotted_alias = scripts\engine\utility::array_add(level.get_target_spotted_alias, var_11);
    var_11 thread played_fulton_crate_anim(var_6);
  }

  if(var_2 != var_1)
    var_6 scripts\mp\equipment\molotov::molotov_simulate_impact(var_6, var_2, (0, 0, 0), undefined, (0, 0, 0), gettime());
  else if(level.get_target_spotted_alias.size < 12) {
    var_11 = magicgrenademanual(var_7, self.origin + (0, 0, -30), (0, 0, -200), 5);
    level.get_target_spotted_alias = scripts\engine\utility::array_add(level.get_target_spotted_alias, var_11);
    var_11 thread played_fulton_crate_anim(var_6);
  }

  var_6 thread hanging_crate_think(30);
}

relic_steelballs_slide(var_0) {
  var_1 = [];

  if(var_0 <= 0)
    return var_1;

  var_2 = 360.0 / var_0;
  var_3 = randomfloatrange(-1 * var_2, var_2);

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_5 = randomfloatrange(-0.5 * var_2, 0.5 * var_2);
    var_6 = var_4 * var_2 + var_5 + var_3;
    var_7 = vectorNormalize(rotatepointaroundvector((0, 0, 1), (0, 0.7, 0.7), var_6));
    var_8 = randomfloatrange(250, 400);
    var_1[var_1.size] = var_7 * var_8;
  }

  return var_1;
}

played_fulton_crate_anim(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_87CA147F1B7EF3A9D81979BF3108FC895CA3F7F3FB2D");
  self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1);
  var_0 scripts\mp\equipment\molotov::molotov_simulate_impact(var_0, self.origin, var_0.angles, undefined, (0, 0, 0), gettime());
  level.get_target_spotted_alias = scripts\engine\utility::array_remove(level.get_target_spotted_alias, self);
  self delete();
}

hanging_crate_think(var_0) {
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(var_0))
    var_0 = 5;

  wait(var_0);

  if(isDefined(self)) {
    if(isent(self))
      self delete();
    else
      self freescriptable();
  }
}

lootleadermarkstrongsize(var_0, var_1, var_2) {
  if(scripts\cp_mp\gasmask::hasgasmask(var_0)) {
    var_0 thread _id_11E4E();

    if(isDefined(level.plunderrepositoryrestricted))
      var_0[[level.plunderrepositoryrestricted]]("_encstr_856515461EB27669B6D5CC51762D8DD3EB377937131460");
    else if(!istrue(var_0.gasmaskequipped))
      var_0 notify("_encstr_933D0F2B10A7BFD3F1F837298698AFC2C7");

    var_0 scripts\cp_mp\gasmask::processdamage(var_2);
  } else {
    var_0 dodamage(var_2, var_0.origin, var_1, undefined, "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3", "_encstr_BA1211895E6630BD3367E7FBFB0A71783FF633");

    if(var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::hasarmor())
      var_0 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::damagearmor(var_2);

    var_0 _encstr_8D18236E8DC95A383ACD5E6BE0CBECB06BAC3ACBC12BCDBC4C277DD8B4E46C8DAC8B9D9B36::_id_13E18();
  }
}

_id_11E4E() {
  var_0 = self;
  var_1 = 1100;

  if(!isDefined(var_0.trackchallengetimers)) {
    var_0.trackchallengetimers = gettime();

    while(!istrue(var_0.gasmaskequipped) || gettime() < var_0.trackchallengetimers + var_1)
      wait 0.5;

    var_0.trackchallengetimers = undefined;

    if(isDefined(level.plunderrepositories))
      var_0[[level.plunderrepositories]]("_encstr_856515461EB27669B6D5CC51762D8DD3EB377937131460");
    else if(istrue(var_0.gasmaskequipped))
      var_0 notify("_encstr_933D0F2B10A7BFD3F1F837298698AFC2C7");

    return;
  }

  var_0.trackchallengetimers = gettime();
}

get_surface_point(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A59E1516B98D569BC82B39D79BDB1BEDFA1B16CDD8B236");
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");

  if(level.ascendstructs[var_0.target].dir == 0) {
    self.get_search_turret_target_player get_subway_train_hit_damage_multiplier(0);
    scripts\engine\utility::waittill_notify_or_timeout("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", 1);
    return 0;
  }

  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("_encstr_8BB007E03658CBCAE4", self.origin, self.angles);
  self.player_rig hide();
  var_1 = spawnStruct();
  var_1.molotov_cleanup_pool = self.get_search_turret_target_player;
  var_1.player = self;
  var_1.tracknonoobplayerlocation = var_0;
  var_1.car_collision = level.ascendstructs[var_0.target];
  self.shouldskiplaststand = 1;
  var_1.car_collision.waittill_player_opens_tac_map = gettime();
  var_2 = scripts\engine\utility::drop_to_ground(var_1.car_collision.origin, 100, -250);
  var_1.canseedangercircleui = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_1.canseedangercircleui setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.initpostmain++;

  if(self getstance() != "_encstr_A5AD069B231F0BAF")
    self setstance("_encstr_A5AD069B231F0BAF");

  scripts\common\utility::allow_execution_victim(0);
  scripts\common\utility::allow_usability(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_ads(0);
  scripts\common\utility::allow_fire(0);

  if(istrue(self.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")) {
      var_3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")]]();

      if(istrue(var_3))
        self disableweaponswitch();
    }
  } else {
    scripts\common\utility::allow_killstreaks(0);
    self disableweaponswitch();
  }

  var_1.canseedangercircleui scripts\cp_mp\ent_manager::registerspawncount(2);
  var_1.car_collision.inuse = 1;
  self.usingascender = 1;
  var_4 = anglesToForward(var_1.car_collision.angles);
  var_5 = anglesToForward(self.angles);
  var_6 = vectordot(var_5, var_4);
  var_7 = 0;

  if(var_6 < 0.5) {
    var_8 = vectorcross(var_5, var_4);

    if(var_8[2] < 0)
      var_7 = 120;
    else
      var_7 = 240;
  }

  var_9 = (0, var_7, 0);
  var_1.canseedangercircleui dontinterpolate();
  var_1.canseedangercircleui.origin = var_2;
  var_1.canseedangercircleui.angles = var_1.car_collision.angles + var_9;
  var_1.cansnapcamera = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.car_collision.origin);
  var_1.cansnapcamera setModel("_encstr_87AF15D8226A7F561FA56067936759DD174AB8C17A4417");
  var_1.cansnapcamera hide();
  var_1.cansolospawn = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.car_collision.origin);
  var_1.cansolospawn setModel("_encstr_87AF15D8226A7F561FA56067936759DD174AB8C17A4417");
  var_1.cansolospawn hide();
  self setclientomnvar("_encstr_BEE715E778DE5A1BFFF4168AF0AF62EE669B7B3F687383", 0);
  var_1 thread _id_1250B();
  var_1 thread get_target_retreat_struct();
  self notify("_encstr_9612118A91860B9CC015B48557F82287A5E872");
  var_1 _id_123D4();
  var_1._id_142D4 = var_1.player.player_rig gettagorigin("_encstr_8AD30BA3E631B1687D87E39838");
  var_1 thread cleanupascenduse();

  if(isDefined(var_1.molotov_cleanup_pool))
    var_1 thread get_shootable_scriptables();

  return 1;
}

get_shootable_scriptables() {
  if(isDefined(self.player))
    self.cansolospawn showtoplayer(self.player);

  carriable_physics_launch_drop();
  var_0 = distance(self.car_collision.ascendstructend.origin, self.car_collision.origin);
  var_1 = var_0 / 200;
  var_2 = scripts\cp_mp\auto_ascender::registered_checkpoint_funcs() * var_1;
  var_3 = scripts\cp_mp\auto_ascender::registereventcallback() * var_1;
  self.canseedangercircleui moveTo(self.car_collision.ascendstructend.origin, var_1, var_2, var_3);
  childthread get_showing_bomb_wire_pair_to_player();
  wait(var_1);

  if(isDefined(self.molotov_crate_player_at_max_ammo)) {
    if(isDefined(self.canseedangercircleui))
      playFX(scripts\engine\utility::getfx("_encstr_99FF12ABF9F06F0A1E4767DBD7C7A2B7E8E022F7"), self.canseedangercircleui.origin + (0, 0, -70), anglestoup(self.canseedangercircleui.angles), anglesToForward(self.canseedangercircleui.angles));

    self.molotov_crate_player_at_max_ammo thread get_smoke_grenade_start_pos(1);
  }

  handleteamvisibility();
}

get_showing_bomb_wire_pair_to_player() {
  playFX(scripts\engine\utility::getfx("_encstr_99FF12ABF9F06F0A1E4767DBD7C7A2B7E8E022F7"), self.canseedangercircleui.origin + (0, 0, 0), anglestoup(self.canseedangercircleui.angles), anglesToForward(self.canseedangercircleui.angles));
  wait 1;

  for(;;) {
    wait(randomfloatrange(0.05, 1.0));

    if(isDefined(self) && isDefined(self.canseedangercircleui))
      playFX(scripts\engine\utility::getfx("_encstr_99FF12ABF9F06F0A1E4767DBD7C7A2B7E8E022F7"), self.canseedangercircleui.origin + (0, 0, randomfloatrange(-70, 0)), anglestoup(self.canseedangercircleui.angles), anglesToForward(self.canseedangercircleui.angles));
  }
}

carriable_physics_launch_drop() {
  self.molotov_crate_player_at_max_ammo = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self._id_142D4);
  self.molotov_crate_player_at_max_ammo.angles = (0, self.molotov_cleanup_pool.angles[1], 0);
  self.molotov_crate_player_at_max_ammo setModel(self.molotov_cleanup_pool.get_teaminquiry_alias.modelname);
  self.molotov_crate_player_at_max_ammo setCanDamage(1);
  self.molotov_crate_player_at_max_ammo.health = 999999;
  self.molotov_crate_player_at_max_ammo.ownerteam = "_encstr_9A19040BCDBC";
  self.molotov_crate_player_at_max_ammo.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
  self.molotov_crate_player_at_max_ammo.owner = self.molotov_cleanup_pool.owner;
  self.molotov_crate_player_at_max_ammo.playerzombiecleanuphud = 1;
  self.molotov_crate_player_at_max_ammo thread get_sight_dist_for_vehicle_check();
  self.molotov_crate_player_at_max_ammo thread get_spawncount_from_groupnames();
  self.molotov_crate_player_at_max_ammo linkTo(self.canseedangercircleui);
  self.molotov_cleanup_pool get_too_far_dist_sq();
  self.molotov_cleanup_pool delete();
  thread capsule_contents();
}

_id_123D4() {
  self.player endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.player endon("_encstr_A59E1516B98D569BC82B39D79BDB1BEDFA1B16CDD8B236");
  self.player endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self.cansnapcamera.animname = "_encstr_9690073295D94B8D59";
  self.cansnapcamera scripts\common\anim::setanimtree();
  self.cansolospawn.animname = "_encstr_9690073295D94B8D59";
  self.cansolospawn scripts\common\anim::setanimtree();
  var_0 = rotatevector((-32.415, 0, 0), self.canseedangercircleui.angles);
  var_1 = 0.4;
  self._encstr_820D131B66C0131B4387D0DC7B20B18335334387A8 = self.player.origin;
  self.player.player_rig moveTo(scripts\engine\utility::drop_to_ground(self.canseedangercircleui.origin + var_0, 100, -250), var_1, 0.1, 0.1);
  var_2 = vectorNormalize(var_0 * -1);
  self._encstr_93A816C14ECA2C37C6B2378C83C62CBCAC4E85B93B63596E = self.player.angles;
  var_3 = scripts\cp_mp\auto_ascender::vectortoanglessafe(var_2, (0, 0, 1));
  self.player.player_rig rotateTo(var_3, var_1, 0.1, 0.1);

  if(istrue(self.molotov_cleanup_pool.playerzombiecleanuphud)) {
    self.molotov_cleanup_pool notify("_encstr_BE5B0C66315576725DA7C2E34708");
    wait(var_1);
  } else {
    self.player enableoffhandweapons();
    self.player get_spawn_delay(self.molotov_cleanup_pool);
    self.molotov_cleanup_pool.playerzombiecleanuphud = 1;
    self.player disableoffhandweapons();

    if(isDefined(self.molotov_cleanup_pool)) {
      self.molotov_cleanup_pool thread get_spotlight_goal_node(self.player, 0);

      if(isDefined(self.car_collision.chopperexfil_sfx_before_sh070)) {
        if(self.car_collision.chopperexfil_sfx_before_sh070.health <= 0)
          return 1;
      } else if(isDefined(self.car_collision.type) && self.car_collision.type == "_encstr_8E631A3798D3B367DBC2F348F20F43B7BBE097E064C9B121B9C7E72D") {
        if(self.car_collision getscriptablepartstate("_encstr_88B708B9DA2F0DF6EDAD") == "_encstr_A22A07C493EDB62BCD")
          return 1;
      }
    }
  }

  if(!istrue(self.isjuggernaut))
    self.player disableoffhandweapons();

  self.player scripted_laser_func();
  self.cansolospawn show();
  self.cansolospawn hidefromplayer(self.player);
  self.cansnapcamera show();
  self.cansnapcamera showonlytoplayer(self.player);
  self.cansnapcamera linkTo(self.player.player_rig, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5", (0, 0, 0), (0, 0, 0));
  self.cansolospawn linkTo(self.canseedangercircleui, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  self.player.player_rig linkTo(self.canseedangercircleui, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  self.player.player_rig showonlytoplayer(self.player);
  var_4 = self.player.player_rig gettagorigin("_encstr_8AD30BA3E631B1687D87E39838");
  var_5 = self.player.player_rig gettagangles("_encstr_8AD30BA3E631B1687D87E39838");
  self.molotov_clear_fx = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  self.molotov_clear_fx.angles = var_5;
  self.molotov_clear_fx setModel(self.molotov_cleanup_pool.get_teaminquiry_alias.modelname);
  self.molotov_clear_fx showonlytoplayer(self.player);
  self.molotov_clear_fx.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
  self.molotov_clear_fx.owner = self.molotov_cleanup_pool.owner;
  self.molotov_clear_fx.playerzombiecleanuphud = 1;
  self.molotov_clear_fx linkTo(self.player.player_rig, "_encstr_8AD30BA3E631B1687D87E39838");
  self.molotov_clear_fx thread get_spawncount_from_groupnames();
  self.canseedangercircleui scripts\common\anim::anim_first_frame_solo(self.player.player_rig, "_encstr_82801A611AC33E48A69A2923BF8E500E27421929531FFF983B713F31");
  self.canseedangercircleui thread scripts\mp\anim::anim_player_solo(self.player, self.player.player_rig, "_encstr_82801A611AC33E48A69A2923BF8E500E27421929531FFF983B713F31");
  self.canseedangercircleui thread scripts\common\anim::anim_single_solo(self.cansolospawn, "_encstr_8CDC21276B9E83C990D995DF96781B6AFD9DA3B7F550AABD70804E278E404453471F1B");
  var_6 = getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_82801A611AC33E48A69A2923BF8E500E27421929531FFF983B713F31"]);
  wait(var_6);

  if(isDefined(self.molotov_cleanup_pool)) {
    if(isDefined(self.car_collision.chopperexfil_sfx_before_sh070)) {
      if(self.car_collision.chopperexfil_sfx_before_sh070.health <= 0)
        return;
    } else if(isDefined(self.car_collision._encstr_881F1017F50BC10942AB38188794603F225D)) {
      if(self.car_collision._encstr_881F1017F50BC10942AB38188794603F225D._encstr_8A2D0DB7630ABF42635BD7FAEBCDEC <= 0)
        return;
    } else if(isDefined(self.car_collision.type) && self.car_collision.type == "_encstr_8E631A3798D3B367DBC2F348F20F43B7BBE097E064C9B121B9C7E72D") {
      if(self.car_collision getscriptablepartstate("_encstr_88B708B9DA2F0DF6EDAD") == "_encstr_A22A07C493EDB62BCD")
        return;
    }
  }

  self.player takeweapon(self.player.currentweapon);
  self.player switchtoweaponimmediate(self.player._id_1286C);
  self.player notify("_encstr_B2AC15AECFCF8B1389672368C0C71F78A012D8A3425977");
  self.player notify("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
}

_id_1250B() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.player endon("_encstr_8EE810C1DB675590C7871717ADAAC82D43D2");
  self.player endon("_encstr_B2AC15AECFCF8B1389672368C0C71F78A012D8A3425977");
  self.player endon("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
  self.player scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");

  if(isDefined(self.player))
    self.player stopanimscriptsceneevent();

  thread cleanupascenduse();
  thread handleteamvisibility();

  if(isDefined(self.molotov_cleanup_pool)) {
    self.molotov_cleanup_pool thread get_subway_train_hit_damage_multiplier(0);

    if(istrue(self.molotov_cleanup_pool.playerzombiecleanuphud))
      self.molotov_cleanup_pool thread get_spotlight_goal_node(self.player);
  }

  if(isDefined(self.player))
    self.player notify("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
}

get_target_retreat_struct() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.player endon("_encstr_8EE810C1DB675590C7871717ADAAC82D43D2");
  self.player endon("_encstr_B2AC15AECFCF8B1389672368C0C71F78A012D8A3425977");
  self.player endon("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
  self.molotov_cleanup_pool waittill("_encstr_860808CB78E2984063BA");

  if(isDefined(self.player))
    self.player stopanimscriptsceneevent();

  cleanupascenduse();
  handleteamvisibility();

  if(isDefined(self.player))
    self.player notify("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
}

capsule_contents() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.molotov_crate_player_at_max_ammo waittill("_encstr_860808CB78E2984063BA");
  self.car_collision.inuse = 0;

  if(isDefined(self.car_collision._id_134CB) && istrue(self.car_collision._id_134CB.inuse))
    self.car_collision._id_134CB.inuse = 0;

  handleteamvisibility();
}

cleanupascenduse() {
  self.car_collision.inuse = 0;

  if(isDefined(self.car_collision._id_134CB) && istrue(self.car_collision._id_134CB.inuse))
    self.car_collision._id_134CB.inuse = 0;

  if(isDefined(self.player) && istrue(self.player.usingascender)) {
    self.player.usingascender = 0;
    self.player.waittill_player_opens_scavenger_cache = gettime();
    self.player scripts\common\utility::allow_usability(1);
    self.player.shouldskiplaststand = undefined;
    self.player scripts\common\utility::allow_execution_victim(1);
    self.player scripts\common\utility::allow_melee(1);
    self.player scripts\common\utility::allow_ads(1);
    self.player scripts\common\utility::allow_fire(1);

    if(istrue(self.player.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")) {
        var_0 = self.player[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")]]();

        if(istrue(var_0))
          self.player enableweaponswitch();
      }
    } else if(!istrue(self.player.inlaststand)) {
      self.player enableoffhandweapons();
      self.player enableweaponswitch();
      self.player scripts\common\utility::allow_killstreaks(1);
    } else
      self.player thread scripts\cp_mp\auto_ascender::watch_for_ashes_achievement();

    self.player.player_rig unlink();
    self.player.get_search_turret_target_player = undefined;
  }

  if(isDefined(self.cansnapcamera)) {
    self.cansnapcamera unlink();
    self.cansnapcamera delete();
    self.cansnapcamera = undefined;
  }

  if(isDefined(self.molotov_clear_fx)) {
    self.molotov_clear_fx delete();
    self.molotov_clear_fx = undefined;
  }

  wait 0.2;

  if(isDefined(self.player)) {
    var_1 = 0.4;
    self.player.player_rig moveTo(self._encstr_820D131B66C0131B4387D0DC7B20B18335334387A8 + (0, 0, 75), var_1, 0.1, 0.1);
    self.player.player_rig rotateTo(self._encstr_93A816C14ECA2C37C6B2378C83C62CBCAC4E85B93B63596E, var_1, 0.1, 0.1);
    wait(var_1);

    if(!self.player hasweapon("_encstr_962A124B7707BE76EADC1B566EDCFA5A3799A5C6"))
      self.player.gunnlessweapon = undefined;

    self.player thread scripts\mp\utility\infilexfil::takegunless();
    self.player notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  }
}

handleteamvisibility() {
  if(isDefined(self.cansolospawn)) {
    self.cansolospawn unlink();
    self.cansolospawn delete();
  }

  if(isDefined(self.canseedangercircleui)) {
    self.canseedangercircleui scripts\cp_mp\ent_manager::deregisterspawn();
    self.canseedangercircleui delete();
    level.initpostmain--;
  }
}

_id_119E2() {
  self.canseedangercircleui endon("_encstr_AD75063D571AE108");
  self.canseedangercircleui endon("_encstr_A6BD1847B7F65012B3B25BD1C3780868BF44F81DC101E1E79D7D");
  var_0 = "_encstr_81F61561E7185FB33DB93BD1810B9399F08927E447D0A2";
  var_1 = getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"][var_0]);

  for(;;) {
    if(!isDefined(self.canseedangercircleui)) {
      break;
    }

    self.canseedangercircleui scripts\common\anim::anim_single_solo(self.cansolospawn, var_0 + "_encstr_B81A04AFEE6B");

    if(!isDefined(var_1) || var_1 == 0) {
      break;
    }

    wait(var_1);
  }
}

scripted_laser_func() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(self.gunnlessweapon)) {
    return;
  }
  var_0 = getcompleteweaponname("_encstr_962A124B7707BE76EADC1B566EDCFA5A3799A5C6");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);

  if(!scripts\common\utility::is_script_weapon_switch_allowed())
    scripts\common\utility::allow_script_weapon_switch(1);

  if(scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress())
    self clearhighpriorityweapon(scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon());

  self switchtoweaponimmediate(var_0);
  self.gunnlessweapon = var_0;
  scripts\common\utility::allow_script_weapon_switch(0);
}

_encstr_99E91506C96A0BC2A122215D97489BCA23EF92C0686FA2(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_A59E1516B98D569BC82B39D79BDB1BEDFA1B16CDD8B236");
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("_encstr_8BB007E03658CBCAE4", self.origin, self.angles);
  self.player_rig hide();
  var_1 = spawnStruct();
  var_1.molotov_cleanup_pool = self.get_search_turret_target_player;
  var_1.player = self;
  var_1.tracknonoobplayerlocation = var_0;
  var_1.car_collision = var_0;
  self.shouldskiplaststand = 1;
  var_1.car_collision.waittill_player_opens_tac_map = gettime();
  var_2 = scripts\engine\utility::drop_to_ground(var_1.car_collision.origin, 100, -250);
  var_1.canseedangercircleui = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_1.canseedangercircleui setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  level.initpostmain++;

  if(self getstance() != "_encstr_A5AD069B231F0BAF")
    self setstance("_encstr_A5AD069B231F0BAF");

  scripts\common\utility::allow_execution_victim(0);
  scripts\common\utility::allow_usability(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_ads(0);
  scripts\common\utility::allow_fire(0);

  if(istrue(self.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")) {
      var_3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")]]();

      if(istrue(var_3))
        self disableweaponswitch();
    }
  } else {
    scripts\common\utility::allow_killstreaks(0);
    self disableweaponswitch();
  }

  var_1.canseedangercircleui scripts\cp_mp\ent_manager::registerspawncount(2);
  var_1.car_collision.inuse = 1;
  self.usingascender = 1;
  var_4 = anglesToForward(var_1.car_collision.angles);
  var_5 = anglesToForward(self.angles);
  var_6 = vectordot(var_5, var_4);
  var_7 = 0;

  if(var_6 < 0.5) {
    var_8 = vectorcross(var_5, var_4);

    if(var_8[2] < 0)
      var_7 = 120;
    else
      var_7 = 240;
  }

  var_9 = (0, var_7, 0);
  var_1.canseedangercircleui dontinterpolate();
  var_1.canseedangercircleui.origin = var_2;
  var_1.canseedangercircleui.angles = var_1.car_collision.angles + var_9;
  var_1.cansnapcamera = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.car_collision.origin);
  var_1.cansnapcamera setModel("_encstr_87AF15D8226A7F561FA56067936759DD174AB8C17A4417");
  var_1.cansnapcamera hide();
  var_1.cansolospawn = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.car_collision.origin);
  var_1.cansolospawn setModel("_encstr_87AF15D8226A7F561FA56067936759DD174AB8C17A4417");
  var_1.cansolospawn hide();
  self setclientomnvar("_encstr_BEE715E778DE5A1BFFF4168AF0AF62EE669B7B3F687383", 0);
  var_1 thread _encstr_BA2526C1365897CA9CB0DC3695CD236EB52F437BDBB5836358C6598C590BA343D82D37D156375993();
  var_1 thread _encstr_9265295852DAAD60D73A69D511B7E95B05EA20904BF4DFF8873061DFEB373113AE537030E24A5171BB4D76();
  self notify("_encstr_9612118A91860B9CC015B48557F82287A5E872");
  var_10 = anglesToForward(self getplayerangles());
  var_1 _id_123D4();
  var_1._id_142D4 = var_1.player.player_rig gettagorigin("_encstr_8AD30BA3E631B1687D87E39838");
  var_1 thread _encstr_811718664C9FA3CB3D78EF5B82D8D08380CC27346A85DB2B237B();

  if(isDefined(var_1.molotov_cleanup_pool)) {
    if(isDefined(var_1.car_collision.chopperexfil_sfx_before_sh070)) {
      if(var_1.car_collision.chopperexfil_sfx_before_sh070.health <= 0)
        return 1;
    } else if(isDefined(var_1.car_collision._encstr_881F1017F50BC10942AB38188794603F225D)) {
      if(var_1.car_collision._encstr_881F1017F50BC10942AB38188794603F225D._encstr_8A2D0DB7630ABF42635BD7FAEBCDEC <= 0)
        return 1;
    } else if(var_1.car_collision getscriptablepartstate("_encstr_88B708B9DA2F0DF6EDAD") == "_encstr_A22A07C493EDB62BCD")
      return 1;
  }

  var_1 thread _encstr_A664199333606A5F4F49CA42F697FFE660850C276FC0F06360EDB2(var_10);
  return 1;
}

_encstr_A664199333606A5F4F49CA42F697FFE660850C276FC0F06360EDB2(var_0) {
  if(isDefined(self.car_collision._encstr_881F1017F50BC10942AB38188794603F225D))
    self.car_collision._encstr_881F1017F50BC10942AB38188794603F225D endon("_encstr_AD75063D571AE108");
  else
    self.car_collision endon("_encstr_AB63129ED1033867652231F08A3A19B3B7619505");

  thread _encstr_A70616DD790D70B8B7E21679BA67ED8869C76379E374707E();

  if(isDefined(self.player))
    self.cansolospawn showtoplayer(self.player);

  self.car_collision.inuse = 1;
  self.player._id_140AF = 1;
  _encstr_8F30253F93CB4BE9E8076860AB2A6083123DA5A8EB126F91DB1F5010DB555B47EB64234B85CACF();
  self.player._id_140AF = undefined;
  var_1 = 2.33333;
  self.canseedangercircleui moveTo(self.car_collision.origin + (0, 0, 3500), var_1, 0.5, 0);
  thread _encstr_9B9912A603989FB7FC7BEBB2064C87131BF95D3A();
  wait(var_1);
  self.car_collision notify("_encstr_BA7F1FA0D1B3C5878875B605BB802085B7C9CD530FB6182019C74DC2CCF77EF1BB");

  if(isDefined(self.molotov_crate_player_at_max_ammo)) {
    self.molotov_crate_player_at_max_ammo thread get_smoke_grenade_start_pos(1);

    if(isDefined(self.car_collision.chopperexfil_sfx_before_sh070))
      self.car_collision.chopperexfil_sfx_before_sh070 dodamage(999999, self.molotov_crate_player_at_max_ammo.origin);
    else if(isDefined(self.car_collision._encstr_881F1017F50BC10942AB38188794603F225D))
      self.car_collision._encstr_881F1017F50BC10942AB38188794603F225D dodamage(self.car_collision._encstr_881F1017F50BC10942AB38188794603F225D._encstr_8A2D0DB7630ABF42635BD7FAEBCDEC + 1, self.molotov_crate_player_at_max_ammo.origin);
    else
      self.car_collision _encstr_9641241F9B6AB8D73BD33878CB7E04A0C5F569831017A0B09BDB0EA3027F4B189D435527BB7E::_encstr_AB2F19495E6468B8E2A39FC9832AF67804B9F12142C450607B97D1();
  }

  handleteamvisibility();
}

_encstr_A70616DD790D70B8B7E21679BA67ED8869C76379E374707E() {
  self.car_collision endon("_encstr_BA7F1FA0D1B3C5878875B605BB802085B7C9CD530FB6182019C74DC2CCF77EF1BB");

  if(isDefined(self.car_collision._encstr_881F1017F50BC10942AB38188794603F225D))
    self.car_collision._encstr_881F1017F50BC10942AB38188794603F225D waittill("_encstr_AD75063D571AE108");
  else
    self.car_collision waittill("_encstr_AB63129ED1033867652231F08A3A19B3B7619505");

  self.molotov_crate_player_at_max_ammo setscriptablepartstate("_encstr_927805C3B3EE02", "_encstr_8CA609D2B03BC1C1167C10");

  if(isDefined(self.molotov_crate_player_at_max_ammo)) {
    self.molotov_crate_player_at_max_ammo unlink();
    var_0 = (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1));
    var_1 = (randomfloatrange(-100, 100), randomfloatrange(-100, 100), randomfloatrange(-100, 100));
    self.molotov_crate_player_at_max_ammo physics_takecontrol(1, self.molotov_crate_player_at_max_ammo.origin + var_0, var_1);
    thread _encstr_B8C91F87E137CA6720512177C980B531066B5343ABD7722C2BFEE7BF40B8E12A6D();
  }

  handleteamvisibility();
}

_encstr_B8C91F87E137CA6720512177C980B531066B5343ABD7722C2BFEE7BF40B8E12A6D() {
  self.molotov_crate_player_at_max_ammo thread _encstr_A9ED1897371A5117D6F3FFFBF7C63823E6833569CD0BD7903980();

  while(self.molotov_crate_player_at_max_ammo._encstr_96C90D9BA73C2DF751A9E42A555F1A > 0) {
    self.molotov_crate_player_at_max_ammo._encstr_96C90D9BA73C2DF751A9E42A555F1A = self.molotov_crate_player_at_max_ammo._encstr_96C90D9BA73C2DF751A9E42A555F1A - 0.05;
    wait 0.05;
  }

  if(isDefined(self.molotov_crate_player_at_max_ammo))
    self.molotov_crate_player_at_max_ammo thread get_smoke_grenade_start_pos(1);
}

_encstr_9B9912A603989FB7FC7BEBB2064C87131BF95D3A() {
  if(isDefined(self.car_collision._encstr_881F1017F50BC10942AB38188794603F225D))
    self.car_collision._encstr_881F1017F50BC10942AB38188794603F225D endon("_encstr_AD75063D571AE108");
  else
    self.car_collision endon("_encstr_AB63129ED1033867652231F08A3A19B3B7619505");

  self.molotov_crate_player_at_max_ammo._encstr_96C90D9BA73C2DF751A9E42A555F1A = 5;

  for(;;) {
    self.molotov_crate_player_at_max_ammo._encstr_96C90D9BA73C2DF751A9E42A555F1A = self.molotov_crate_player_at_max_ammo._encstr_96C90D9BA73C2DF751A9E42A555F1A - 0.05;
    wait 0.05;
  }
}

_encstr_A9ED1897371A5117D6F3FFFBF7C63823E6833569CD0BD7903980() {
  while(isDefined(self)) {
    playFXOnTag(level._effect["_encstr_839D13EBFD13D94B28538A5429E89CB278056F6753"], self, "_encstr_B2BF0708BA770F795B");
    wait 1;
  }
}

_encstr_8F30253F93CB4BE9E8076860AB2A6083123DA5A8EB126F91DB1F5010DB555B47EB64234B85CACF() {
  self.molotov_crate_player_at_max_ammo = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self._id_142D4);
  self.molotov_crate_player_at_max_ammo.angles = (0, self.molotov_cleanup_pool.angles[1], 0);
  self.molotov_crate_player_at_max_ammo setModel(self.molotov_cleanup_pool.get_teaminquiry_alias.modelname);
  self.molotov_crate_player_at_max_ammo setCanDamage(1);
  self.molotov_crate_player_at_max_ammo.health = 999999;
  self.molotov_crate_player_at_max_ammo.ownerteam = "_encstr_9A19040BCDBC";
  self.molotov_crate_player_at_max_ammo.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
  self.molotov_crate_player_at_max_ammo.owner = self.molotov_cleanup_pool.owner;
  self.molotov_crate_player_at_max_ammo.playerzombiecleanuphud = 1;
  self.molotov_crate_player_at_max_ammo thread get_sight_dist_for_vehicle_check();
  self.molotov_crate_player_at_max_ammo thread get_spawncount_from_groupnames();
  self.molotov_crate_player_at_max_ammo linkTo(self.canseedangercircleui);
  self.molotov_cleanup_pool get_too_far_dist_sq();
  self.molotov_cleanup_pool delete();
  thread _encstr_92751E0288D757B3894B96975EB037DC67D02ACA50AB4BE3A0A3739C7D780FE2();
}

_encstr_8C9425A7858A6B7EF30F10E8D709118912E197AEDEA23D41DD6B71E8F73928D71A14AF3FF5DAF3() {
  self.player endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.player endon("_encstr_A59E1516B98D569BC82B39D79BDB1BEDFA1B16CDD8B236");
  self.player endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self.cansnapcamera.animname = "_encstr_9690073295D94B8D59";
  self.cansnapcamera scripts\common\anim::setanimtree();
  self.cansolospawn.animname = "_encstr_9690073295D94B8D59";
  self.cansolospawn scripts\common\anim::setanimtree();
  var_0 = rotatevector((-32.415, 0, 0), self.canseedangercircleui.angles);
  var_1 = 0.4;
  self.player.player_rig moveTo(self.canseedangercircleui.origin + var_0, var_1, 0.1, 0.1);
  var_2 = vectorNormalize(var_0 * -1);
  var_3 = scripts\cp_mp\auto_ascender::vectortoanglessafe(var_2, (0, 0, 1));
  self.player.player_rig rotateTo(var_3, var_1, 0.1, 0.1);

  if(istrue(self.molotov_cleanup_pool.playerzombiecleanuphud)) {
    self.molotov_cleanup_pool endon("_encstr_BE5B0C66315576725DA7C2E34708");
    wait(var_1);
  } else {
    self.player get_spawn_delay(self.molotov_cleanup_pool);
    self.molotov_cleanup_pool.playerzombiecleanuphud = 1;
  }

  if(!istrue(self.isjuggernaut))
    self.player disableoffhandweapons();

  self.player scripted_laser_func();
  self.cansolospawn show();
  self.cansolospawn hidefromplayer(self.player);
  self.cansnapcamera show();
  self.cansnapcamera showonlytoplayer(self.player);
  self.cansnapcamera linkTo(self.player.player_rig, "_encstr_B2AE148D118849F9F696852B6A0702D239A5810FEBC5", (0, 0, 0), (0, 0, 0));
  self.cansolospawn linkTo(self.canseedangercircleui, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  self.player.player_rig linkTo(self.canseedangercircleui, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", (0, 0, 0), (0, 0, 0));
  self.player.player_rig showonlytoplayer(self.player);
  var_4 = self.player.player_rig gettagorigin("_encstr_8AD30BA3E631B1687D87E39838");
  var_5 = self.player.player_rig gettagangles("_encstr_8AD30BA3E631B1687D87E39838");
  self.molotov_clear_fx = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_4);
  self.molotov_clear_fx.angles = var_5;
  self.molotov_clear_fx setModel(self.molotov_cleanup_pool.get_teaminquiry_alias.modelname);
  self.molotov_clear_fx showonlytoplayer(self.player);
  self.molotov_clear_fx.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
  self.molotov_clear_fx.owner = self.molotov_cleanup_pool.owner;
  self.molotov_clear_fx.playerzombiecleanuphud = 1;
  self.molotov_clear_fx linkTo(self.player.player_rig, "_encstr_8AD30BA3E631B1687D87E39838");
  self.molotov_clear_fx thread get_spawncount_from_groupnames();
  self.canseedangercircleui scripts\common\anim::anim_first_frame_solo(self.player.player_rig, "_encstr_82801A611AC33E48A69A2923BF8E500E27421929531FFF983B713F31");
  self.canseedangercircleui thread scripts\mp\anim::anim_player_solo(self.player, self.player.player_rig, "_encstr_82801A611AC33E48A69A2923BF8E500E27421929531FFF983B713F31");
  self.canseedangercircleui thread scripts\common\anim::anim_single_solo(self.cansolospawn, "_encstr_8CDC21276B9E83C990D995DF96781B6AFD9DA3B7F550AABD70804E278E404453471F1B");
  var_6 = getanimlength(level.scr_anim["_encstr_8BB007E03658CBCAE4"]["_encstr_82801A611AC33E48A69A2923BF8E500E27421929531FFF983B713F31"]);
  wait(var_6);
  self.player takeweapon(self.player.currentweapon);
  self.player switchtoweaponimmediate(self.player._id_1286C);
  self.player notify("_encstr_B2AC15AECFCF8B1389672368C0C71F78A012D8A3425977");
  self.player notify("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
}

_encstr_BA2526C1365897CA9CB0DC3695CD236EB52F437BDBB5836358C6598C590BA343D82D37D156375993() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.player endon("_encstr_8EE810C1DB675590C7871717ADAAC82D43D2");
  self.player endon("_encstr_B2AC15AECFCF8B1389672368C0C71F78A012D8A3425977");
  self.player endon("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
  self.player scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");

  if(isDefined(self.player))
    self.player stopanimscriptsceneevent();

  thread cleanupascenduse();
  thread handleteamvisibility();

  if(isDefined(self.molotov_cleanup_pool)) {
    self.molotov_cleanup_pool thread get_subway_train_hit_damage_multiplier(0);

    if(istrue(self.molotov_cleanup_pool.playerzombiecleanuphud))
      self.molotov_cleanup_pool thread get_spotlight_goal_node(self.player);
  }

  if(isDefined(self.player))
    self.player notify("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
}

_encstr_9265295852DAAD60D73A69D511B7E95B05EA20904BF4DFF8873061DFEB373113AE537030E24A5171BB4D76() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.player endon("_encstr_8EE810C1DB675590C7871717ADAAC82D43D2");
  self.player endon("_encstr_B2AC15AECFCF8B1389672368C0C71F78A012D8A3425977");
  self.player endon("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
  self.molotov_cleanup_pool waittill("_encstr_860808CB78E2984063BA");

  if(isDefined(self.player))
    self.player stopanimscriptsceneevent();

  cleanupascenduse();
  handleteamvisibility();

  if(isDefined(self.player))
    self.player notify("_encstr_884F10201BF6FBF8AB257EE03BE7A0BFDF52");
}

_encstr_92751E0288D757B3894B96975EB037DC67D02ACA50AB4BE3A0A3739C7D780FE2() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self.molotov_crate_player_at_max_ammo waittill("_encstr_860808CB78E2984063BA");
  self.car_collision.inuse = 0;

  if(isDefined(self.car_collision._id_134CB) && istrue(self.car_collision._id_134CB.inuse))
    self.car_collision._id_134CB.inuse = 0;

  handleteamvisibility();
}

_encstr_811718664C9FA3CB3D78EF5B82D8D08380CC27346A85DB2B237B() {
  self.car_collision.inuse = undefined;

  if(isDefined(self.player) && istrue(self.player.usingascender)) {
    self.player.usingascender = 0;
    self.player.waittill_player_opens_scavenger_cache = gettime();
    self.player scripts\common\utility::allow_usability(1);
    self.player.shouldskiplaststand = undefined;
    self.player scripts\common\utility::allow_execution_victim(1);
    self.player scripts\common\utility::allow_melee(1);
    self.player scripts\common\utility::allow_ads(1);
    self.player scripts\common\utility::allow_fire(1);

    if(istrue(self.player.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")) {
        var_0 = self.player[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BFC0BC2CBD4F737E0A5E1FD79", "_encstr_BA2F14D80B9BAA6EB2EAACB083B79B414B6C6DD5E0B9")]]();

        if(istrue(var_0))
          self.player enableweaponswitch();
      }
    } else if(!istrue(self.player.inlaststand)) {
      self.player enableoffhandweapons();
      self.player enableweaponswitch();
      self.player scripts\common\utility::allow_killstreaks(1);
    } else
      self.player thread scripts\cp_mp\auto_ascender::watch_for_ashes_achievement();

    self.player.player_rig unlink();
    self.player.get_search_turret_target_player = undefined;
  }

  if(isDefined(self.cansnapcamera)) {
    self.cansnapcamera unlink();
    self.cansnapcamera delete();
    self.cansnapcamera = undefined;
  }

  if(isDefined(self.molotov_clear_fx)) {
    self.molotov_clear_fx delete();
    self.molotov_clear_fx = undefined;
  }

  waitframe();

  if(isDefined(self.player)) {
    if(!self.player hasweapon("_encstr_962A124B7707BE76EADC1B566EDCFA5A3799A5C6"))
      self.player.gunnlessweapon = undefined;

    self.player thread scripts\mp\utility\infilexfil::takegunless();
    self.player notify("_encstr_BE840BF2FFD8B0A4DB6EE31FA1");
  }
}

_encstr_8573267ED59A0B08B57BB8302FFD404922FAEEF268A2CF10834390102F13F9FF0A62E60BC65A8199() {
  if(isDefined(self.canseedangercircleui)) {
    self.canseedangercircleui scripts\cp_mp\ent_manager::deregisterspawn();
    self.canseedangercircleui delete();
    level.initpostmain--;
  }
}