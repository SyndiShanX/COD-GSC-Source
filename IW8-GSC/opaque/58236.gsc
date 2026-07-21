/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58236.gsc
***********************************************/

x1stash_removequestinstance() {
  level.watchforhelistatus = getdvarfloat("_encstr_A34B24F3AA5338F0D4FC69A115B148FB8B72CE99D26F70F8EEC361AF2AE910BD279A20A11ADF", 1.0);
  level.watchforlowpopmatchstart = getdvarfloat("_encstr_8EF72B63396E2745288104144B710E079631399A404C6FBF30971CEF7D49D36FB3A8B1530B1743B470EB1AED55", 1.0);
  level.watchforjuggernautgameend = getdvarfloat("_encstr_817E260B20DDE1832D1D5474BDEE73B405F031F2C85FA9F3798E5C7FCE3677FE5B18B90B70011D6B", 1.2);
  level.watchforleapfrogpathdisconnect = getdvarfloat("_encstr_91D52660A7C259C30163C5B5AA87D50B3215A9C9A1CA1907B77FA098A83F7826CB10903AFF4BCFFE", 1.0);
  level.watchforjuggernautdisconnect = getdvarfloat("_encstr_9B39282646BB2718F95B2018E7371183632F88255D825F01D92F2808931FA8CB0AD71BB8B7B9E7A98173", 0.5);
  level.watchforexfilallyturntoside = getdvarfloat("_encstr_877230CDC6E4EB8DD2A3D11B95AF98B49C19AFC86BB3EB660B8DA3ED39BE8C39D29DB29336569B37EBB1DB63C62DDC5AB7DC", 3.0);
  level.watchforpayloadstage = getdvarfloat("_encstr_AA862B1E7E831F10F14328E0EF2F298B6B2780AB55FB0358B33F6958D72FC6F9724A052E6CA2E981B763D048EB", 0.9);
  level.watchfornewdrop = getdvarfloat("_encstr_972E2AB936397D63D2E8A33659EB132DC9327D2D5B835DC6E6B2EB8C5BCE7D1DA139AC371AF61B23AF5B5A46", 0.9);
  level.watchfornearmisswhizby = getdvarfloat("_encstr_A52E2A3380A2711CC3ED7B422107AB639DA8B17B405BF3B9A76FD78AF9196F15D412ED8708978B93E70B82F3", 0.1);
  level.watchformoralespickedup = getdvarfloat("_encstr_A28427CDC627FA1BB4E88E1BCAD798B4E48CAF4BAD07EAB1CD59EB325B3BFACC161BD1BDE4AF1BF677", 0.1);
  level.watchfornagstootherplayers = getdvarfloat("_encstr_A6092B5B01560F6D3069FCFC5359361FFE591162A82FFF25C8A3DFFC6BF0319BAF511B8AD310575C08EF14CF27", 0.2);
  level.watchformoralesunderfire = getdvarfloat("_encstr_93EF2C67B0E3EF726B85DBD5655FCA914B305F97285B1DBA771569CF59C7D12671604B0748164DD2A120AC84B4E1", 0.75);
  level.watchforplayertouchingwater = getdvarfloat("_encstr_995129C2718847D2BBE1D34B3B48FAB95039718F28483F4B83C98753678652E408A63314A3E0DB02E8E183", 55.0);
  level.watchforpayloadtriggersuperwave = getdvarfloat("_encstr_A11F26274FE368A8B9CB5368B7A710BB3BBB8781EF1AD010C1A3B9E0D1524061B2EF7D137F5380C8", 10.0);
  level.watchforscriptabledoorsinradius = getdvarfloat("_encstr_A75725B2685EE14C547BC33AC16FEAF42B74492CF7FAF1591FCB509191B9A5F9C737F19139271E", 0.6);
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", 1);
  var_0.destroycallback = ::x1spyplane;
  var_0.canfly = 1;
  xanimlength();
  x1timehandler();
  xmike109();
  x1stashlootcacheused();
  x1stash_respawn();
  x1timedivision();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_88C5055208731B")]]();

  xmike109projectiles();
  x1unittimedivision();
}

x1unittimedivision() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_BAF609D2739647C4853A2B")]]();
}

xanimlength() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", 1);
  var_0.enterstartcallback = ::x1playertransition;
  var_0.enterendcallback = ::x1opsunitrespawnselection;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::x1questmanager;
  var_0.reentercallback = ::z_delta;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 95;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 195;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 55;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 55;
  var_0.exitextents["_encstr_AC190479FF92"] = -5;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 117;
  var_0.allowairexit = 1;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (85, 0, -40);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_8FEE0C6E10B7CB6067CD678F0CE3";
  var_0.exitoffsets[var_1] = (40, -17, -40);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_AF610CB24855FB7558C7ECED5D38";
  var_0.exitoffsets[var_1] = (-40, 17, -45);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_1 = "_encstr_91EC0DAD4B462363AC7D4E4BCE863A";
  var_0.exitoffsets[var_1] = (-40, -17, -45);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_B69B0589C236B6";
  var_0.exitoffsets[var_1] = (-85, 0, -65);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = ["_encstr_A266062032BD7723", "_encstr_9B7408BFEF17BA445893", "_encstr_977A0A6A3B6947CBAE9328F0", "_encstr_92B70AC4B1FACEEACDCD594E"];
  var_3 = "_encstr_A266062032BD7723";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_AF610CB24855FB7558C7ECED5D38", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085", "_encstr_B69B0589C236B6"];
  var_0.exitoffsets[var_3] = (40, 17, -40);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.spawnpriority = 10;
  var_4._id_12023 = "_encstr_A930138F411DE927482F9958FB8D52C7D8D0A078CB";
  var_3 = "_encstr_92B70AC4B1FACEEACDCD594E";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_AF610CB24855FB7558C7ECED5D38", "_encstr_A266062032BD7723", "_encstr_91EC0DAD4B462363AC7D4E4BCE863A", "_encstr_AA5606FD1AF05085", "_encstr_B69B0589C236B6"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4.viewclamps["_encstr_AC190479FF92"] = 180;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 180;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 120;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 105;
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_4._id_13E92 = "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8";
  var_3 = "_encstr_9B7408BFEF17BA445893";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_91EC0DAD4B462363AC7D4E4BCE863A", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AF610CB24855FB7558C7ECED5D38", "_encstr_AA5606FD1AF05085", "_encstr_B69B0589C236B6"];
  var_0.exitoffsets[var_3] = (40, -17, -40);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.viewclamps["_encstr_AC190479FF92"] = 27;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 42;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 125;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 125;
  var_4.animtag = "_encstr_A70D0BFBD379B6D25977D3700A";
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_977A0A6A3B6947CBAE9328F0";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_91EC0DAD4B462363AC7D4E4BCE863A", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AF610CB24855FB7558C7ECED5D38", "_encstr_AA5606FD1AF05085", "_encstr_B69B0589C236B6"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4.viewclamps["_encstr_AC190479FF92"] = 180;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 180;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 105;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 120;
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_4._id_13E92 = "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2";
}

x1timehandler() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_A266062032BD7723", "_encstr_9B7408BFEF17BA445893", "_encstr_92B70AC4B1FACEEACDCD594E", "_encstr_977A0A6A3B6947CBAE9328F0"]);
}

x1stash_respawn() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", 1);
  var_0.challengeevaluator = 1.66666;
  var_0.keycardlocs_chosen = 0.83333;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 7.5;
  var_0.isallowedweapon = 30;
  var_0.isakimbo = 60;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

xmike109() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", 1);
  var_0.brtruck_initdialog["_encstr_810E07FAF85B0A07E3"] = 1;
  var_0.id = 17;
  var_0.seatids["_encstr_A266062032BD7723"] = 0;
  var_0.seatids["_encstr_9B7408BFEF17BA445893"] = 1;
  var_0.seatids["_encstr_977A0A6A3B6947CBAE9328F0"] = 2;
  var_0.seatids["_encstr_92B70AC4B1FACEEACDCD594E"] = 3;
  var_0._id_12DA2[0] = 0;
  var_0._id_12DA2[1] = 1;
  var_0._id_12DA3["_encstr_A266062032BD7723"]["_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43"] = 0;
  var_0._id_12DA3["_encstr_A266062032BD7723"]["_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8"] = 0;
  var_0._id_12DA3["_encstr_A266062032BD7723"]["_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2"] = 1;
  var_0._id_12DA3["_encstr_9B7408BFEF17BA445893"]["_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43"] = 0;
  var_0._id_12DA3["_encstr_9B7408BFEF17BA445893"]["_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8"] = 0;
  var_0._id_12DA3["_encstr_9B7408BFEF17BA445893"]["_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2"] = 1;
  var_0._id_12DA3["_encstr_977A0A6A3B6947CBAE9328F0"]["_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43"] = 0;
  var_0._id_12DA3["_encstr_977A0A6A3B6947CBAE9328F0"]["_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8"] = 0;
  var_0._id_12DA3["_encstr_977A0A6A3B6947CBAE9328F0"]["_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2"] = 1;
  var_0._id_12DA3["_encstr_92B70AC4B1FACEEACDCD594E"]["_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43"] = 0;
  var_0._id_12DA3["_encstr_92B70AC4B1FACEEACDCD594E"]["_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8"] = 0;
  var_0._id_12DA3["_encstr_92B70AC4B1FACEEACDCD594E"]["_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2"] = 1;
}

x1stashlootcacheused() {
  if(level.gametype == "_encstr_B607038AAB")
    var_0 = 3000;
  else
    var_0 = 2500;

  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", var_0);
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F");
  var_1.class = "_encstr_B6F60D728869C44F3820E0E5C7A387";
  var_2 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414D("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_B846067B175AA56A");
  var_2._id_12024 = ::xyzoffset;
  var_2._id_1202D = ::yaw_delta;
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", 12);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", ::x1opstransbink);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43", 5);
}

x1timedivision() {
  level._effect["_encstr_BD161749A8DBDB65AFCE4108A00F713BC77FEF41137A8FF057"] = loadfx("_encstr_AB643B94D653506B6347B250FB3D1118C77B1E83388B41458DFA58A29397D9AEBBE883108DA7A8F736022819CAAE85A16387B8751D2393C39A9EB3D8A3");
}

x1opsruntoicon(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_8F1922DE15A8424943D84A7170A3FA27C00E42413410978D2151F2BAA88BB6A35978D5FF";
  var_0.targetname = "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F";
  var_0.vehicletype = "_encstr_96FB12BBCD3E1276801EF2FCF248A18A161F2743";
  var_0.cannotbesuspended = 1;
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  var_2.currentdestindex = gettime();
  var_2.flareslive = [];
  var_2.player_is_trying_self_revive = 1;

  if(isDefined(level._encstr_85531EA9C4DB7118F503C8E8E337B0BD12AA1EA31FA23F20DA6FA068E72EA9EF))
    var_2._id_120B4 = level._encstr_85531EA9C4DB7118F503C8E8E337B0BD12AA1EA31FA23F20DA6FA068E72EA9EF;

  if(level.gametype == "_encstr_B607038AAB")
    var_2.player_is_pressing_attack = 35;
  else
    var_2.player_is_pressing_attack = 10;

  var_3 = x1opsspawnnpc(var_2, "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2", "_encstr_A76117DD56C2E0F673FABBD6F56BECBE8C4C36DAD9BE58964E", "_encstr_992611EB3E0F915523B3654343699EF8A7D453", (16, -11, 0));
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_3, getcompleteweaponname("_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2"));
  var_4 = x1opsspawnnpc(var_2, "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8", "_encstr_A76117DD56C2E0F673FABBD6F56BECBE8C4C36DAD9BE58964E", "_encstr_AF901019913711DD37FB9B6183C799880FFC", (16, 0, 0));
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_4, getcompleteweaponname("_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8"));
  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_8AEA073693CA16D12B")]](var_2);

  var_2 thread x1stash_playerdisconnect();
  var_2 thread x1opsnpc();
  return var_2;
}

x1opsnpc() {
  self endon("_encstr_AD75063D571AE108");
  self vehphys_enablecollisioncallback(1);

  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(gettime() - self.currentdestindex < 5000) {
      continue;
    }
    if(isDefined(var_7) && isDefined(var_7.helperdronetype) && var_7.helperdronetype == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC") {
      continue;
    }
    var_9 = 1.0;

    switch (var_8) {
      case 0:
        var_9 = level.watchforhelistatus;
        break;
      case 1:
        var_9 = level.watchforlowpopmatchstart;
        break;
      case 2:
        var_9 = level.watchforjuggernautgameend;
        break;
      case 3:
        var_9 = level.watchforleapfrogpathdisconnect;
        break;
      case 4:
        var_9 = level.watchforjuggernautdisconnect;
        break;
    }

    var_10 = var_6 * var_9;
    var_11 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

    if(!isDefined(var_11))
      var_10 = var_10 * level.watchforexfilallyturntoside;

    var_12 = self.angles[0];

    if(var_12 > 180)
      var_12 = var_12 - 360;

    if(abs(var_12 > level.watchforplayertouchingwater))
      var_10 = var_10 * level.watchforpayloadtriggersuperwave;

    var_13 = self.angles[2];

    if(var_13 > 180)
      var_13 = var_13 - 360;

    if(abs(var_13 > level.watchforplayertouchingwater))
      var_10 = var_10 * level.watchforpayloadtriggersuperwave;

    var_14 = 0;

    if(var_10 > level.watchforpayloadstage)
      var_14 = self.maxhealth;
    else if(var_10 > level.watchfornewdrop) {
      var_15 = level.watchforpayloadstage - level.watchfornewdrop;
      var_16 = (var_10 - level.watchfornewdrop) / var_15;
      var_17 = self.maxhealth * level.watchfornagstootherplayers;
      var_18 = self.maxhealth * level.watchformoralesunderfire;
      var_14 = scripts\engine\math::lerp(var_17, var_18, var_16);
    } else if(var_10 > level.watchfornearmisswhizby)
      var_14 = self.maxhealth * level.watchformoralespickedup;

    if(var_14 > 0) {
      if(isDefined(var_11) && var_3 == 11534336)
        var_14 = var_14 * level.watchforscriptabledoorsinradius;

      scripts\cp_mp\vehicles\vehicle_damage::_id_14143(1);
      self dodamage(var_14, var_4, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
      scripts\cp_mp\vehicles\vehicle_damage::_id_14143(0);
    }

    wait 0.5;
  }
}

x1opsspawnnpc(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0 gettagorigin(var_3), var_1, 0);
  var_5 linkTo(var_0, var_3, var_4, (0, 0, 0));
  var_5 setModel(var_2);
  var_5 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 setturretmodechangewait(1);
  var_5 hidepart("_encstr_8C9C0AE8572FA790765A505B");
  var_5 hidepart("_encstr_86CF0EB8A9E7B94FB019ABF201E9BBB9");
  var_5 hidepart("_encstr_A64114B36627B97E1AC3E7A9D733D010ECFF78A98C84");
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  var_5.maxhealth = 999999;
  var_5.health = var_5.maxhealth;
  return var_5;
}

x1spyplane(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  if(!istrue(level.suppressvehicleexplosion)) {
    self notify("_encstr_8B1A098BD8E134029B657C");
    wait 0.2;
  }

  if(!isDefined(self)) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);

  if(!istrue(level.suppressvehicleexplosion))
    waitframe();

  if(!isDefined(self)) {
    return;
  }
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread x1opstransition();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_8A480B1D0B76D78C9547C21B34");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A1FA123471738359181731B1DB49E14A9FA6BD43");
    playFX(scripts\engine\utility::getfx("_encstr_BD161749A8DBDB65AFCE4108A00F713BC77FEF41137A8FF057"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_9193131BD14BFF9D9875F9D67749E72BEF680242B9");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

x1opstransition() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

x1opstransbink(var_0) {
  thread x1spyplane(var_0);
  return 1;
}

xyzoffset(var_0, var_1) {
  self setscriptablepartstate("_encstr_85BB067A08ABFAD7", "_encstr_BD7D0E1DB0C45B182AB753F0E5780B0D", 0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14163(var_0, var_1);
}

yaw_delta(var_0, var_1) {
  self setscriptablepartstate("_encstr_85BB067A08ABFAD7", "_encstr_BA19049F4B2D", 0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14169(var_0, var_1);
}

x1playertransition(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3.javelin)) {
    if(isDefined(var_3.javelin.state) && var_3.javelin.state != "_encstr_BA19049F4B2D" || isDefined(var_3.javelin.target) || isDefined(var_3.javelin.groundlockonent)) {
      var_4.success = 0;
      return;
    }
  }

  var_3 skydive_setbasejumpingstatus(0);
  var_3 skydive_setdeploymentstatus(0);

  if(isDefined(var_2)) {
    if(var_2 == "_encstr_977A0A6A3B6947CBAE9328F0") {
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
      z_below_check(var_0, var_3, var_4, "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2", var_2, var_1);
    } else if(var_2 == "_encstr_92B70AC4B1FACEEACDCD594E") {
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
      z_below_check(var_0, var_3, var_4, "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8", var_2, var_1);
    } else if(var_1 == "_encstr_92B70AC4B1FACEEACDCD594E" || var_1 == "_encstr_977A0A6A3B6947CBAE9328F0")
      scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
  }

  if(var_1 == "_encstr_977A0A6A3B6947CBAE9328F0")
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2", var_4, 1);
  else if(var_1 == "_encstr_92B70AC4B1FACEEACDCD594E")
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8", var_4, 1);

  if(istrue(var_0.israllypointvehicle)) {
    foreach(var_6 in level.players) {
      if(istrue(var_0.revealed) || var_6.team == var_0.team)
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_6);
    }

    foreach(var_9 in var_0.occupants)
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_9);

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_0.marker.objidnum, var_3);
  }
}

x1opsunitrespawnselection(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    var_3 scripts\cp_mp\parachute::_id_121CA();
    x1playerspawnoverride(var_0, var_1, var_2, var_3, var_4);
  }

  if(!istrue(level.client_activate)) {
    var_3 skydive_setbasejumpingstatus(1);
    var_3 skydive_setdeploymentstatus(1);
  }
}

x1playerspawnoverride(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2)) {
    var_7 = var_2 == "_encstr_92B70AC4B1FACEEACDCD594E" || var_2 == "_encstr_977A0A6A3B6947CBAE9328F0";
    var_8 = var_1 != "_encstr_92B70AC4B1FACEEACDCD594E" && var_1 != "_encstr_977A0A6A3B6947CBAE9328F0";

    if(var_7 && var_8) {
      var_5 = "_encstr_96FB12BBCD3E1276801EF2FCF248A18A161F2743";
      var_6 = 7;
    }
  }

  if(var_1 == "_encstr_A266062032BD7723") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
    var_0 thread x1stash_ontimerexpired(var_3);
  } else if(var_1 == "_encstr_977A0A6A3B6947CBAE9328F0")
    yaw_updater(var_0, var_3, "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2");
  else if(var_1 == "_encstr_92B70AC4B1FACEEACDCD594E")
    yaw_updater(var_0, var_3, "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8");
  else
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);

  thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F6(var_4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_99BF1103D0D4179DFB42DB03358B930DBDB7A1", 0))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_99BF1103D0D4179DFB42DB03358B930DBDB7A1")]](var_0, var_1, var_2, var_3, var_4);
}

yaw_updater(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_2);
  var_3.owner = var_1;
  var_3 setotherent(var_1);
  var_3 setentityowner(var_1);
  var_3 setsentryowner(var_1);
  var_1 disableturretdismount();
  var_1 controlturreton(var_3);
}

x1questmanager(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    x1spawnlocationoverride(var_0, var_1, var_2, var_3, var_4);
}

x1spawnlocationoverride(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_A266062032BD7723") {
    var_0 notify("_encstr_8FD4186DA09BAC8821F7D24098C10FF562C2B367F22F4DC0BBCB");
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4.playerdisconnect))
      var_3 controlsunlink();
  }

  var_5 = !isDefined(var_2);
  var_6 = 0;

  if(isDefined(var_3))
    var_6 = var_3 hasweapon("_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2");

  var_7 = 0;

  if(isDefined(var_3))
    var_7 = var_3 hasweapon("_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8");

  if(var_1 == "_encstr_977A0A6A3B6947CBAE9328F0" || var_5 && var_6)
    z_below_check(var_0, var_3, var_4, "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2", var_1, var_2);

  if(var_1 == "_encstr_92B70AC4B1FACEEACDCD594E" || var_5 && var_7)
    z_below_check(var_0, var_3, var_4, "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8", var_1, var_2);

  if(!istrue(var_4.playerdisconnect)) {
    if(istrue(var_4.playerdeath))
      var_3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_8) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840")]](var_3);
      else
        var_3 suicide();
    } else if(istrue(var_0.israllypointvehicle))
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_0.marker.objidnum, var_3);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

z_below_check(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_3);

  if(!istrue(var_2.playerdisconnect)) {
    var_1 enableturretdismount();
    var_1 controlturretoff(var_6);

    if(!istrue(var_2.playerdeath))
      var_1 thread zlimit(var_0, var_2, var_3, 1, var_4, var_5);
  }

  var_6.owner = undefined;
  var_6 setotherent(undefined);
  var_6 setentityowner(undefined);
  var_6 setsentryowner(undefined);
}

z_delta(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F6(var_4);
  thread zdrop(var_0, var_1, var_2, var_3, var_4);
}

zdrop(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.watchforteammaterevivedwhilereviving))
    level.watchforteammaterevivedwhilereviving = getdvarint("_encstr_84DA1C430E5BF9CA66606139A7F0A90FA3B0ED13EBFF52FBAD85B6DB4AD2", 1) > 0;

  if(level.watchforteammaterevivedwhilereviving) {
    var_4.raceendon = "_encstr_952616A3DF33E085A34052535DE38F679F6453D3A347B5A4";
    var_4.raceendnotify = "_encstr_952616A3DF33E085A34052535DE38F679F6453D3A347B5A4";
    var_4.success = 1;

    if(isDefined(var_2)) {
      if(var_2 == "_encstr_977A0A6A3B6947CBAE9328F0") {
        var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2", var_4, 1);

        if(!var_4.success && isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive())
          var_3 suicide();

        scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F7(var_5);
      } else if(var_2 == "_encstr_92B70AC4B1FACEEACDCD594E") {
        var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8", var_4, 1);

        if(!var_4.success && isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive())
          var_3 suicide();

        scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F7(var_5);
      }
    }

    if(isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
      if(var_1 == "_encstr_977A0A6A3B6947CBAE9328F0") {
        var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2", var_4, 1);

        if(!var_4.success && isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive())
          var_3 suicide();
        else
          yaw_updater(var_0, var_3, "_encstr_AF651D23CB5E17B7D8A5DFE44338BB030D26FA7AB33D5FAA4BAF10E417A8C2");

        scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F7(var_5);
      } else if(var_1 == "_encstr_92B70AC4B1FACEEACDCD594E") {
        var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8", var_4, 1);

        if(!var_4.success && isDefined(var_3) && var_3 scripts\cp_mp\utility\player_utility::_isalive())
          var_3 suicide();
        else
          yaw_updater(var_0, var_3, "_encstr_A5BE1CD30523DF4F43C6F7780359C5CD018F1BC0538301CBD5A5218135D8");

        scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F7(var_5);
      }
    }
  }
}

zlimit(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1.raceendon))
    var_1 endon(var_1.raceendon);

  if(istrue(var_3))
    childthread x1stash_entergulag(var_1, 1.5);

  var_6 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_2);
  var_7 = undefined;

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_2)) {
    var_8 = getcompleteweaponname(var_2);
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_8);
    var_7 = 1;
  } else {
    self controlturretoff(var_6);

    if(self hasweapon(var_2)) {
      var_9 = scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_2);

      if(var_9) {
        scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);

        if(!_id_13324(self, var_4, var_5))
          thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
      } else
        thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2, 1);
    }

    var_7 = 1;
  }

  if(isDefined(var_7) && !var_7) {
    var_1.success = 0;
    var_1 notify(var_1.raceendnotify);
  }
}

_id_13324(var_0, var_1, var_2) {
  if(istrue(var_0.isjuggernaut)) {
    if(isDefined(var_1) && var_1 == "_encstr_977A0A6A3B6947CBAE9328F0" && isDefined(var_2) && var_2 == "_encstr_92B70AC4B1FACEEACDCD594E")
      return 1;

    if(isDefined(var_1) && var_1 == "_encstr_92B70AC4B1FACEEACDCD594E" && isDefined(var_2) && var_2 == "_encstr_977A0A6A3B6947CBAE9328F0")
      return 1;
  }

  return 0;
}

x1stash_entergulag(var_0, var_1) {
  wait(var_1);
  var_0.success = 0;
  var_0 notify(var_0.raceendnotify);
}

x1stash_playerdisconnect() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(!self.player_is_trying_self_revive) {
      wait(self.player_is_pressing_attack);
      self.player_is_trying_self_revive = 1;
      var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

      if(isDefined(var_0))
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_810E07FAF85B0A07E3", 1, var_0);
    }

    waitframe();
  }
}

x1stash_ontimerexpired(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8FD4186DA09BAC8821F7D24098C10FF562C2B367F22F4DC0BBCB");
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_A9130DC330104912F19DE1677B831B");
  var_0 notifyonplayercommand("_encstr_81D60C6E0D7BB747F599635893B2", "_encstr_A9E60828803C73F11780");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_810E07FAF85B0A07E3", scripts\engine\utility::ter_op(self.player_is_trying_self_revive, 1, 0), var_0);

  for(;;) {
    var_0 waittill("_encstr_81D60C6E0D7BB747F599635893B2");

    if(!self.player_is_trying_self_revive) {
      self playsoundtoplayer("_encstr_A3BF18A0B642380CCA3F958FC3A2DFE8ED4A4E5B9EAA984BF2B7", var_0);
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_91B007FA68E899B8EB"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_91B007FA68E899B8EB")]]();

    var_1 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB"))
      var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_810E07FAF85B0A07E3", "_encstr_AD830746560EB17BCB")]]();

    if(isDefined(level.missiles)) {
      foreach(var_3 in level.missiles) {
        if(!isDefined(var_3._id_119A0) || var_3._id_119A0 != self) {
          continue;
        }
        var_4 = distance(self.origin, var_3.origin);

        if(var_4 < 4000) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AA8E12846C53FB87468728589F64FF374A558516"))
            var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AA8E12846C53FB87468728589F64FF374A558516")]]("_encstr_95F81EB52C37AB58C6D733362C3959F5ADA5B937B46356D79C2B195AE42B363A");

          scripts\cp_mp\utility\weapon_utility::clearprojectilelockedon(var_3);
          var_3 missile_settargetEnt(var_1);
          var_3 notify("_encstr_922018B6A5DCCD5AD8ACF5C1B04B4E2B46BA2D1DA1916385392B");
        }
      }
    }

    self.player_is_trying_self_revive = 0;
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_810E07FAF85B0A07E3", 0, var_0);
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D2(var_0);
  }
}

xmike109projectiles() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", 1);
  var_0.maxinstancecount = 5;
  var_0.priority = 100;
  var_0.getspawnstructscallback = ::x1stash_detectplayers;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 100;
  var_0.clearancecheckoffsetz = -100;
  var_0.clearancecheckminradius = 185;
}

x1stash_detectplayers() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9938148D4BD13A8D59135A39C8AFDAECBE6E382CBB73", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}