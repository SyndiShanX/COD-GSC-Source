/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58235.gsc
***********************************************/

startarmsracedef2obj() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BE820B53A080CF0245ADFC77B7", 1);
  var_0.destroycallback = ::start_trap_room_combat;
  var_0._id_13E92 = "_encstr_851B12B4B3361710A51AD14A9244E0FC7B2020BB";
  startchallengetimer();
  startbluntwatchvfx();
  startcheck();
  startarmsracedef4obj();
  startarmsracedef3obj();
  startarmsraceopencrateobj();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_88C5055208731B")]]();

  startdeadsilence();
  level.stealth_alert_music = getdvarint("_encstr_AF591FE7636201C63B19C810926F0CC871EB61BB1A4BB99BA3F163D8EADF3720D2", 0);
  level.startmatchobjectiveicons = getdvarint("_encstr_B1ED1D9F728A6E90AB29CB65A20C99BD9771A0DD3A0F665F58228F01314D9F", 1);
  level.staytoasty = getdvarint("_encstr_A5801EAAC69D89E2CB7137238080DF326F66F2A7BDE9C126B0891B27D0F9975A", 75);
  level.stayfrosty = getdvarint("_encstr_8BE522375FF378C89231C038E76128A8D9F7A993FF3A20C0D1D36B704F6F68D752270F2B", 115);
  level.startpayloadexfilobjective = getdvarfloat("_encstr_8FB02A9BC6E4EBC49CD7D2DC32B4B3DBAF76D5DCE6564EFAA34BB6ACFA31B2E877ACB2DCAF2657D88D958EB9", 0.1);
  level.startofxptime = getdvarint("_encstr_884F1BB01AB28F79F31FF3783CC781A751C2D0B8E2CD2316DF4708E702", 1);
  level.stay_on_roof_until_bothered = getdvarint("_encstr_A9B01F37C6C9AF134EAF4BE619D29DDBF5B9F673169CEB378DC2E6BE16DCB33659", 30);
  level.stay_on_roof_until_bothered_internal = getdvarint("_encstr_9BB81F57069B67E21A3F7AC8EBB29768A1AFE2888213D9E69FC6CDBF2083858FF0", 8000);
  level.starttmtylapproach = getdvarfloat("_encstr_920E24620E2531AA83297F5BC8D867FAA71F6C5BE6B989F348D8634F983057B2CFB4F6D555DB", 20);
  level.startusingbomb = getdvarfloat("_encstr_A90D23E66C39AF9827AFA57391A5CEF67D4E7BD88DAFB1DBC61B4B374BB7CDF5CEB01BBAB2", 20);
  level.startpropcirclelogic = getdvarint("_encstr_97D92282EE85910A2389DF3BA8B8C75A07760D7DCDED0A59C8C00F3FE87087C3F19D1777", 70);
  level.start_spawn_camera = getdvarfloat("_encstr_8B8D1F620ECB570985B8EC3BB7A1E95324E76751104952DA274D7BD3309979CF31", 1.0);
  level.start_swivelroom_obj = getdvarfloat("_encstr_83B426EBC03D0177CDF5A9DF184E0BD54F89024258D9C5C31EE5A9D9A196AF5BEB187A0AE07D3F8B", 1.0);
  level.start_static_klaxon_lights = getdvarfloat("_encstr_8B4521FBA1F6AF8CA829819727F917AF94DE2242094D370249138191CDD1DADF45709B", 1.2);
  level.start_static_plane_lights = getdvarfloat("_encstr_8DA321B93639FA96DC46B4CEBDBE32ADECBECC58D847BD39EBD116A5C6F5C9ED3ADBE4", 1.0);
  level.start_spawn_modules = getdvarfloat("_encstr_BA86233EBB4E70B74AC22CCF6829243142FF4687B639FF0808F0A2BA19A22D6140C9982B2B", 0.5);
  level.start_solution_check_timer = getdvarfloat("_encstr_8B662B2E3EB646209D8AABC488EFAC2BACCF84C7492BD0467161AA42BB50BE289773C7718E9FE4016B620412C2", 10.0);
  level.startarmsracedef1obj = getdvarfloat("_encstr_BA0226CDC693D7A53719D2B37BF5B4D60757C69B59D7C8D63BBE3A0DE4566E347B1BC8EB34D2B30D", 0.9);
  level.startarmsraceapproachobj = getdvarfloat("_encstr_992A2597FF53D830EE9FA07945F7F809CB0F311F9FE91D283FB90B902AB57033D2F3A93F1752D5", 0.9);
  level.startarmoryswitchbeeping = getdvarfloat("_encstr_B62A25DF4E7A3E29182C7F97DF0618CF18D57523853777671739ACF260302B49EF7B2A67ECA0EF", 0.1);
  level.start_whack_a_mole_sequence = getdvarfloat("_encstr_8C83223FE8BBA76ADD3554CFA897A22D43F0DBB7A076D41217409F4686B99AFA4EA05FDF", 0.1);
  level.start_with_nvgs = getdvarfloat("_encstr_BD8026AB1EBA317B324B33274F09B3785073B023072FA021DABF1533876388C827CD9859217440E4", 0.2);
  level.start_whack_a_mole_timer = getdvarfloat("_encstr_8B222783A693D678C819834072A183351B5BC8EB5B184CE867E136BFAAE17DDB8F1DCB7A6719386C18", 0.75);
  level.starting_area_init = getdvarfloat("_encstr_A274249BB19CEBA5CD1996B3DBAF196BCED7C14B1D3634AF27BD1BC6BE3AD0272B3786BD368C", 55.0);
  level.startimes = getdvarfloat("_encstr_B8A721C0C63A89EA60F067FF48498CB7502770E981127B36A2F052F9812DA08103A8B2", 10.0);
  level.startingteamcount = getdvarfloat("_encstr_8E2820DCD8E4FAD23746963BBD7DBBDBDB8C7DE6AB9399BE32DAB3D79B6C0BD8C29C", 0.6);
  startbmoexfilprocess();
}

startbmoexfilprocess() {
  thread _id_1327D();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_BAF609D2739647C4853A2B")]]();

  level._effect["_encstr_9BBE1401B54834EFC096A27A38AED7EFC3318C9FC938"] = loadfx("_encstr_8ACF2D6CCFD30F603FA2C120E30F38EF3AB6E8FD75CB53885F8370E86F9A93A751DC50757C723F56FD93C85223B6AA");
}

startchallengetimer() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_BE820B53A080CF0245ADFC77B7", 1);
  var_0.enterstartcallback = ::start_timer;
  var_0.enterendcallback = ::start_target_move_loop;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::start_trans_1_obj;
  var_0.reentercallback = ::starting_struct;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 175;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 180;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 68;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 68;
  var_0.exitextents["_encstr_AC190479FF92"] = 138;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_0.allowairexit = 1;
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-130, 70, -45);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_1 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_0.exitoffsets[var_1] = (-130, -70, -45);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_B69B0589C236B6";
  var_0.exitoffsets[var_1] = (-255, 0, -45);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = ["_encstr_A266062032BD7723", "_encstr_8D48079DD59BE65627"];
  var_3 = "_encstr_A266062032BD7723";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_BE820B53A080CF0245ADFC77B7", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_B69B0589C236B6"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D8();
  var_4._id_13E8A = getcompleteweaponname("_encstr_851B12B4B3361710A51AD14A9244E0FC7B2020BB");
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4._id_12023 = "_encstr_A930138F411DE927482F9958FB8D52C7D8D0A078CB";
  var_3 = "_encstr_8D48079DD59BE65627";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_BE820B53A080CF0245ADFC77B7", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_B69B0589C236B6"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getpassivepassengerrestrictions();
  var_4.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_4._id_12023 = "_encstr_A9891440525D07260BBDEB53934BA9AFC77B48380AF2";
}

startbluntwatchvfx() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_BE820B53A080CF0245ADFC77B7", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_A266062032BD7723", "_encstr_8D48079DD59BE65627"]);
}

startcheck() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_BE820B53A080CF0245ADFC77B7", 1);
  var_0.id = 27;
  var_0.seatids["_encstr_A266062032BD7723"] = 0;
  var_0.seatids["_encstr_8D48079DD59BE65627"] = 1;
  var_0._id_12DA2[0] = 0;
  var_0._id_12DA2[1] = 1;
  var_0._id_12DA3["_encstr_A266062032BD7723"]["_encstr_88E90F60526BE39B37B026C8BBEA614FB1"] = 0;
  var_0._id_12DA3["_encstr_A266062032BD7723"]["_encstr_851B12B4B3361710A51AD14A9244E0FC7B2020BB"] = 1;
  var_0._id_12DA3["_encstr_8D48079DD59BE65627"]["_encstr_88E90F60526BE39B37B026C8BBEA614FB1"] = 0;
  var_0._id_12DA3["_encstr_8D48079DD59BE65627"]["_encstr_851B12B4B3361710A51AD14A9244E0FC7B2020BB"] = 1;
}

startarmsracedef4obj() {
  level.startplunderextractiontimers = getdvarfloat("_encstr_9A301E9BAA021FE963EF0388AC77313721823828F25B89863FEE1DFE925F99FB", 3950);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_BE820B53A080CF0245ADFC77B7", level.startplunderextractiontimers, undefined, undefined, undefined, 8);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_BE820B53A080CF0245ADFC77B7");
  var_0.class = "_encstr_B846067B175AA56A";
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414D("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_B846067B175AA56A");
  var_1._id_12024 = ::starthacktimer;
  var_1._id_1202D = ::startholowatchvfx;
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_BE820B53A080CF0245ADFC77B7");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_BE820B53A080CF0245ADFC77B7", 17);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14175("_encstr_BE820B53A080CF0245ADFC77B7", ::starting_boxes);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_BE820B53A080CF0245ADFC77B7", ::start_silo_thrust_menu);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14173("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_A266062032BD7723", getdvarfloat("_encstr_96101DA34829E0174F09A767024317716873BF897068A3F252B9F330F89990", 0.7));
  scripts\cp_mp\vehicles\vehicle_damage::_id_14172("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_A266062032BD7723", getdvarfloat("_encstr_86781DE330258BF4F8412F8EFE2BC33E9ECDB6738E733FFF226F3AC8390553", 15));
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_88E90F60526BE39B37B026C8BBEA614FB1", 5);
}

startarmsracedef3obj() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_BE820B53A080CF0245ADFC77B7", 1);
  var_0.challengeevaluator = 2;
  var_0.keycardlocs_chosen = 0.75;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 5;
  var_0.isallowedweapon = 20;
  var_0.isakimbo = 40;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

startarmsraceopencrateobj() {
  level._effect["_encstr_A7B50F5ACDFD770FA05F8D881960D58B95"] = loadfx("_encstr_BD7636BE050805776CDA11CABB68AFCA40F32E343FC0DF3B380BBA73E6168B92814BD6BC2B20E51FB501C2BB28E0EFB850BF57124F686DBB");
}

start_vault_assault_retrieve_saw() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BE820B53A080CF0245ADFC77B7");
  return var_0._id_13E92;
}

start_silo_jump_menu(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_B24E1A70FB28780289771A3F2941E13FEAA7892CD0D488171077EC1A";
  var_0.targetname = "_encstr_BE820B53A080CF0245ADFC77B7";

  if(!isDefined(var_0.vehicletype))
    var_0.vehicletype = "_encstr_92FF0ACAE80C286F30BF58B3";

  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  var_3 = start_vault_assault_retrieve_saw();
  var_4 = start_unstable_rocket_fuel_timer();
  var_5 = start_silo_thrust(var_2, var_3, "_encstr_991A28AE65D8AF12A1396A22C81FCE2F33C0013908A1BFDF2F21B30B6991038B6BB59C97170BB366DFB0", var_4.tag, var_4.tagoffset);
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_5, getcompleteweaponname(var_3));
  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_BE820B53A080CF0245ADFC77B7", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_88E90F60526BE39B37B026C8BBEA614FB1");
  var_2._id_13E92 = var_3;
  var_2._id_11B7B = 3;
  var_2.minigunbackup = level.startmatchobjectiveicons;
  var_2.shouldmodeplayfinalmoments = 0;
  var_2 thread startpayloadreturnobj();
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_8AEA073693CA16D12B")]](var_2);

  var_2 thread helis_assault3_hangar_check_size();
  return var_2;
}

helis_assault3_hangar_check_size() {
  self endon("_encstr_AD75063D571AE108");
  self vehphys_enablecollisioncallback(1);

  if(getdvarint("_encstr_BD2919336A93F840D21793E5547C20B87F62281B520B2EC0EE0C83", 0)) {
    return;
  }
  for(;;) {
    self waittill("_encstr_93510A16C71B20636A2AB8B8", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

    if(isDefined(var_7) && isDefined(var_7.helperdronetype) && var_7.helperdronetype == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC") {
      continue;
    }
    if(!istrue(self.shouldmodeplayfinalmoments)) {
      continue;
    }
    var_9 = abs(angleclamp180(self.angles[0]));

    if(var_9 < level.starttmtylapproach && abs(self.angles[2]) < level.startusingbomb && var_7.origin[2] < self.origin[2]) {
      continue;
    }
    var_10 = 1.0;

    switch (var_8) {
      case 0:
        var_10 = level.start_spawn_camera;
        break;
      case 1:
        var_10 = level.start_swivelroom_obj;
        break;
      case 2:
        var_10 = level.start_static_klaxon_lights;
        break;
      case 3:
        var_10 = level.start_static_plane_lights;
        break;
      case 4:
        var_10 = level.start_spawn_modules;
        break;
    }

    var_11 = var_6 * var_10;
    var_12 = self.angles[0];

    if(var_12 > 180)
      var_12 = var_12 - 360;

    if(abs(var_12 > level.starting_area_init))
      var_11 = var_11 * level.startimes;

    var_13 = self.angles[2];

    if(var_13 > 180)
      var_13 = var_13 - 360;

    if(abs(var_13 > level.starting_area_init))
      var_11 = var_11 * level.startimes;

    var_14 = 0;

    if(var_11 > level.startarmsracedef1obj)
      var_14 = self.maxhealth;
    else if(var_11 > level.startarmsraceapproachobj) {
      var_15 = level.startarmsracedef1obj - level.startarmsraceapproachobj;
      var_16 = (var_11 - level.startarmsraceapproachobj) / var_15;
      var_17 = self.maxhealth * level.start_with_nvgs;
      var_18 = self.maxhealth * level.start_whack_a_mole_timer;
      var_14 = scripts\engine\math::lerp(var_17, var_18, var_16);
    } else if(var_11 > level.startarmoryswitchbeeping)
      var_14 = self.maxhealth * level.start_whack_a_mole_sequence;

    var_19 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

    if(!isDefined(var_19))
      var_14 = var_14 * level.start_solution_check_timer;
    else if(self vehicle_getspeed() < level.staytoasty)
      var_14 = 0;
    else if(self vehicle_getspeed() < level.stayfrosty)
      var_14 = 100;

    if(var_14 > 0) {
      if(isDefined(var_19) && var_3 == 11534336)
        var_14 = var_14 * level.startingteamcount;

      scripts\cp_mp\vehicles\vehicle_damage::_id_14143(1);
      self dodamage(var_14, var_4, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
      scripts\cp_mp\vehicles\vehicle_damage::_id_14143(0);
    }

    wait 0.5;
  }
}

start_unstable_rocket_fuel_timer() {
  var_0 = spawnStruct();

  if(getdvarint("_encstr_95C31A5137B997F7F7D95B4398E5AF3B36F5A1D730A1C33C8B30635A", 0) == 1) {
    iprintlnbold("_encstr_A109195F2A11128B906FF7D267E090A7573892C2090DDF569AF39D");
    var_0.tag = "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118";
    var_0.tagoffset = (58.87, 0, 60.052);
  } else {
    var_0.tag = "_encstr_99FE0B2B19086F6B9DC5D387E1";
    var_0.tagoffset = (0, 0, 0);
  }

  return var_0;
}

start_silo_thrust(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0 gettagorigin(var_3), var_1, 0);
  var_5 linkTo(var_0, var_3, var_4, (0, 0, 0));
  var_5 setModel(var_2);
  var_5 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 setturretmodechangewait(1);
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  var_5.maxhealth = 999999;
  var_5.health = var_5.maxhealth;
  return var_5;
}

start_trap_room_combat(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_88E90F60526BE39B37B026C8BBEA614FB1";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  if(!istrue(level.suppressvehicleexplosion)) {
    self notify("_encstr_8B1A098BD8E134029B657C");
    wait 0.2;
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);

  if(!istrue(level.suppressvehicleexplosion))
    waitframe();

  self setscriptablepartstate("_encstr_840703F23B", "_encstr_A29B05E9400E5D");
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread start_smoke_door_fx();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 200, 80, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_88E90F60526BE39B37B026C8BBEA614FB1");
    playFX(scripts\engine\utility::getfx("_encstr_A7B50F5ACDFD770FA05F8D881960D58B95"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

startpayloadreturnobj() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.shouldoperatorhideaccessoryworldmodel = 0;

  for(;;) {
    var_1 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 0);
    var_2 = [var_0];
    var_3 = scripts\engine\trace::ray_trace(var_0.origin, var_0.origin - (0, 0, 250), var_2, var_1, 0);

    if(isDefined(var_3)) {
      if(var_3["_encstr_AA1C0886968EA32FE056"] == "_encstr_AC4B0D3BD013D433491D6125700D8A")
        var_0.shouldmodeplayfinalmoments = 1;
    }

    if(self vehicle_getspeed() < 35) {
      var_0.shouldmodeplayfinalmoments = 0;
      var_0.shouldoperatorhideaccessoryworldmodel = 0;
    }

    if(self vehicle_getspeed() > 35 && var_0.shouldoperatorhideaccessoryworldmodel == 0) {
      var_0 playsoundonmovingent("_encstr_9539162392103423880183F8398398981188B796361B4225");
      var_0.shouldoperatorhideaccessoryworldmodel = 1;
    }

    wait 1.5;
  }
}

start_smoke_door_fx() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

starting_boxes(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(self, "_encstr_A7B606DA83796F4A"))
    var_0.damage = var_0.damage * start_trap_timer();

  if(isDefined(var_0.damage) && var_0.damage > 0)
    self notify("_encstr_B2310D943398AE674DEE4B0270958B", var_0);

  return 1;
}

start_trap_timer() {
  return 0.8333;
}

start_silo_thrust_menu(var_0) {
  thread start_trap_room_combat(var_0);
  return 1;
}

starthacktimer(var_0, var_1) {
  scripts\cp_mp\vehicles\vehicle_damage::_id_14163(var_0, var_1);
}

startholowatchvfx(var_0, var_1) {
  scripts\cp_mp\vehicles\vehicle_damage::_id_14169(var_0, var_1);
}

_id_1327D() {
  level.startjuggdelivery = spawnStruct();
  level.startjuggdelivery.powers = [];
  bhadriotshield(level.startjuggdelivery, "_encstr_8C350C382DD8DB1D76BAB937CA4E", "_encstr_A9E60828803C73F11780", ::startptui);
}

_id_14231(var_0) {
  if(isbot(self)) {
    return;
  }
  foreach(var_6, var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked)
    self notifyonplayercommand(var_6, var_4);
  }
}

_id_14230(var_0) {
  if(isbot(self)) {
    return;
  }
  foreach(var_6, var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked)
    self notifyonplayercommandremove(var_6, var_4);
  }
}

bhadriotshield(var_0, var_1, var_2, var_3) {
  if(isstring(var_2))
    var_2 = [var_2];

  var_0.powers[var_1] = spawnStruct();
  var_0.powers[var_1].clients_hacked = var_2;
  var_0.powers[var_1].func = var_3;
}

startptui(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_2.vehicle)) {
    return;
  }
  var_2.vehicle.turret.turreton = 1;
  var_2.vehicle.turret setmode("_encstr_849007B268BD03DFD8");
  var_2 thread startstruct();
}

startstruct() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_B14B1A9587B4D1B4CDD97D384BD8DBD1FACD2BB01DEB2DB98C96D9F6");
  var_0.vehicle endon("_encstr_AD75063D571AE108");
  var_1 = var_0.vehicle.turret;
  var_2 = 6;

  for(;;) {
    var_1 shootturret("_encstr_A14F0AE336178944BA076F41", var_2);
    wait(level.startpayloadexfilobjective);

    if(!var_0 attackButtonPressed())
      return;
  }
}

_id_12636(var_0, var_1) {
  var_2 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 endon("_encstr_965A0FCA87B4A3D29BD9AFB4B991969DB7");
  var_2 endon("_encstr_B14B1A9587B4D1B4CDD97D384BD8DBD1FACD2BB01DEB2DB98C96D9F6");

  for(;;) {
    var_2 waittill(var_1);
    waittillframeend;
    var_2 thread[[var_0.powers[var_1].func]](var_0, var_1);
  }
}

_id_12635(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_965A0FCA87B4A3D29BD9AFB4B991969DB7");
  var_1 endon("_encstr_B14B1A9587B4D1B4CDD97D384BD8DBD1FACD2BB01DEB2DB98C96D9F6");

  if(isbot(var_1)) {
    return;
  }
  foreach(var_4, var_3 in var_0.powers)
  var_1 thread _id_12636(var_0, var_4);
}

start_timer(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(level.stealth_alert_music) && level.stealth_alert_music > 0)
    var_0.origin = var_0.origin + (0, 0, level.stealth_alert_music);

  if(istrue(level.startofxptime)) {
    var_3 init_respawns();
    var_3 thread _id_1315F();
  }

  var_0 thread start_safehouse_quarry();

  if(var_1 == "_encstr_A266062032BD7723") {
    var_3 thread _id_14231(level.startjuggdelivery);
    var_3 thread _id_12635(level.startjuggdelivery);
    var_3 thread staticcircle();
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, var_0._id_13E92, var_4, 1);
  }

  if(var_1 == "_encstr_8D48079DD59BE65627")
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
  else if(isDefined(var_2) && var_2 == "_encstr_8D48079DD59BE65627")
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
}

start_safehouse_quarry() {
  var_0 = self;
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0.hours = 0;

  for(;;) {
    if(istrue(var_0.hours)) {
      if(var_0 vehicle_getspeed() < level.startpropcirclelogic) {
        var_0.hours = 0;
        var_0 setscriptablepartstate("_encstr_840703F23B", "_encstr_A29B05E9400E5D", 0);
      }
    } else if(var_0 vehicle_getspeed() > level.startpropcirclelogic) {
      var_0.hours = 1;
      var_0 setscriptablepartstate("_encstr_840703F23B", "_encstr_8B6007D127B04BD8E6", 0);
    }

    wait 5;
  }
}

start_target_move_loop(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    thread start_timed_event_on_detection(var_0, var_1, var_2, var_3, var_4);
  else if(!istrue(var_4.playerdisconnect) && !istrue(var_4.playerdeath)) {
    if(var_1 == "_encstr_A266062032BD7723") {
      startingcodephone(var_3);
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0._id_13E92, var_4, 1);
    }
  }
}

start_timed_event_on_detection(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3.should_hide_buried_mother_corpse))
    var_3.should_hide_buried_mother_corpse = 1;
  else
    var_3.should_hide_buried_mother_corpse = var_3.should_hide_buried_mother_corpse + 1;

  var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_pickup_origin(var_0, var_1, var_2, var_4);
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2) && var_2 == "_encstr_8D48079DD59BE65627") {
    var_5 = "_encstr_92FF0ACAE80C286F30BF58B3";
    var_6 = 3;
  }

  if(var_1 == "_encstr_A266062032BD7723") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);

    if(getdvarint("_encstr_A7EB1ABFB756990AF0B60CD5C97057D2B8E37F33677552C198F8075F", 1))
      var_0 startusbanim(var_3);

    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_7 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_0._id_13E92);
    var_7.owner = var_3;
    var_3.vehicle.turret = var_7;
    start_safehouse_gunshop(var_3);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F6(var_4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

start_trans_1_obj(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    if(isDefined(var_1) && var_1 == "_encstr_A266062032BD7723")
      var_3 notify("_encstr_B14B1A9587B4D1B4CDD97D384BD8DBD1FACD2BB01DEB2DB98C96D9F6");

    var_3 thread _id_14230(level.startjuggdelivery);
    var_3 startlastsurvivorsuavsweep();
    var_3 notify("_encstr_965A0FCA87B4A3D29BD9AFB4B991969DB7");
  } else if(var_2 != "_encstr_A266062032BD7723") {
    var_3 thread _id_14230(level.startjuggdelivery);
    var_3 startlastsurvivorsuavsweep();
    var_3 notify("_encstr_B14B1A9587B4D1B4CDD97D384BD8DBD1FACD2BB01DEB2DB98C96D9F6");
  }

  if(istrue(var_3.startplayer)) {
    var_3 cameraunlink();
    var_3.startplayer = 0;
  }

  if(istrue(var_4.success))
    start_trap_room(var_0, var_1, var_2, var_3, var_4);
}

start_trap_room(var_0, var_1, var_2, var_3, var_4) {
  var_3 _calloutmarkerping_isvehicleoccupiedbyenemy::bot_protect_hq_zone(var_0, var_1, var_2, var_4);

  if(var_1 == "_encstr_A266062032BD7723") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(getdvarint("_encstr_A7EB1ABFB756990AF0B60CD5C97057D2B8E37F33677552C198F8075F", 1))
      var_0 thread startuseweapon();
  }

  var_5 = !isDefined(var_2);

  if(var_1 == "_encstr_A266062032BD7723" || var_5 && var_3 hasweapon(var_0._id_13E92)) {
    var_6 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_0._id_13E92);

    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_6);

      if(!istrue(var_4.playerdeath))
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0._id_13E92, var_4, 1);

      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var_3, var_4.playerdeath);
    }

    var_6.owner = undefined;
    var_6 setotherent(undefined);
    var_6 setentityowner(undefined);
    startingcodephone(var_3);
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 controlsunlink();

    if(istrue(var_4.playerdeath))
      var_3 scripts\cp_mp\vehicles\vehicle_occupancy::allowleaderboardstatsupdates();

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_7) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840")]](var_3);
      else
        var_3 suicide();
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

start_safehouse_gunshop(var_0) {
  if(isDefined(var_0.set_thirdperson)) {
    return;
  }
  var_0.set_thirdperson = 1;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BE820B53A080CF0245ADFC77B7");

  if(istrue(var_1._id_133D3)) {
    return;
  }
  var_0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("_encstr_9ABD17493B45108C63839D839B88D3E8F3D410012AB5C04D8B", 0.4, 0, ::start_waypoint);
}

startingcodephone(var_0) {
  if(!isDefined(var_0.set_thirdperson)) {
    return;
  }
  var_0.set_thirdperson = undefined;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BE820B53A080CF0245ADFC77B7");

  if(istrue(var_1._id_133D3)) {
    return;
  }
  var_0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("_encstr_9ABD17493B45108C63839D839B88D3E8F3D410012AB5C04D8B", 0);
}

start_waypoint(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" && var_4 != "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
    return 1;

  if(!isDefined(var_5))
    return 1;

  switch (var_5.basename) {
    case "_encstr_851B12B4B3361710A51AD14A9244E0FC7B2020BB":
    case "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB":
    case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
    case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
    case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
      return 0;
    default:
      return 1;
  }
}

starting_struct(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F6(var_4);
  thread starting_trigger_fix(var_0, var_1, var_2, var_3, var_4);
}

starting_trigger_fix(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "_encstr_A266062032BD7723") {
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F7(var_5);
  }
}

_id_13DDA() {
  return 1;
}

trophy_protectionsuccessful(var_0) {
  self._id_13DDF--;
  var_1 = var_0.origin;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_993F1C6B20D95C8F7045AF9CE6380BA44381C2B3D08595DFAFBF8A877523", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_993F1C6B20D95C8F7045AF9CE6380BA44381C2B3D08595DFAFBF8A877523", "_encstr_88C5055208731B")]](var_0);

  var_2 = trophy_getbesttag(var_1);
  self setscriptablepartstate("_encstr_9B1910D4B568FFFBA316426AA357E262FCE0", var_2);
  var_3 = vectortoangles(self gettagorigin(var_2) - var_1);
  var_4 = combineangles(var_3, (-90, 0, 0));

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B8A716E847BC384A61F8BFECEBC898A3A04F78F0B1D27D71", "_encstr_88C5055208731B"))
    self.explosion thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B8A716E847BC384A61F8BFECEBC898A3A04F78F0B1D27D71", "_encstr_88C5055208731B")]](var_1, var_4);

  if(self._id_13DDF == 0) {
    self notify("_encstr_829110FBAB98D28AA55BF737B3D653397091", "_encstr_ABF40FA3E09808FA7328154D306B62AD20");
    self waittill("_encstr_8891134727DE831AE57D85B65BEDFAE42B33D263D8");
  } else
    self notify("_encstr_829110FBAB98D28AA55BF737B3D653397091", "_encstr_8EAF11EB3877BA03B238F1E5C9981703B76872");
}

trophy_getbesttag(var_0) {
  var_1 = ["_encstr_A1060DCBA13CEF8B087FD8D84B3982", "_encstr_93060D9119AF8955A3925358DB3F2E", "_encstr_A3060DDB4758481BB8AA276361998E", "_encstr_83060D83B1A0C7D3B65743DB83C81F"];
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_8, var_5 in var_1) {
    var_6 = self gettagorigin(var_5);
    var_7 = distancesquared(var_6, var_0);

    if(var_8 == 0 || var_7 < var_2) {
      var_2 = var_7;
      var_3 = var_5;
    }
  }

  return var_3;
}

startusbanim(var_0) {
  var_1 = self;
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 linkTo(var_1);
  var_2 makeportableradar(var_0);
  var_1.radar = var_2;
}

startuseweapon() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = self;

  if(isDefined(var_0.radar))
    var_0.radar delete();
}

startdeadsilence() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_BE820B53A080CF0245ADFC77B7", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::start_unlock_silo;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

start_unlock_silo() {
  if(isDefined(level._id_1218C) && level._id_1218C.size != 0)
    var_0 = level._id_1218C;
  else
    var_0 = scripts\engine\utility::getStructArray("_encstr_BE820B53A080CF0245ADFC77B7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}

staticcircle() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B14B1A9587B4D1B4CDD97D384BD8DBD1FACD2BB01DEB2DB98C96D9F6");
  var_1 = -40;
  var_2 = -135;
  var_3 = 40;
  var_4 = -135;
  var_0.startpayloadtanksobjective = var_0 _id_12530(var_3, var_4, "_encstr_A5AD056A019C63", "_encstr_8F8D07BB035BDAD5CD", "_encstr_A5C407E1658D3339B3", "_encstr_A146078E65FB5158DD", &"_encstr_A98D1F3920F9E908EF43BBB9B918E4A0ADF32954CD31983721A7869DA311440BF1");

  while(!isDefined(var_0.vehicle))
    wait 0.5;

  var_0 thread stealth_alert_music_index();
}

startlastsurvivorsuavsweep() {
  var_0 = self;

  if(isDefined(var_0.startpayloadtanksobjective))
    var_0.startpayloadtanksobjective destroy();

  var_0.startpayloadtanksobjective = undefined;
}

stealth_alert_music_index() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_B14B1A9587B4D1B4CDD97D384BD8DBD1FACD2BB01DEB2DB98C96D9F6");

  for(;;) {
    if(!isDefined(var_0.vehicle)) {
      return;
    }
    var_1 = 0;

    foreach(var_3 in level.vehicle.instances["_encstr_BE820B53A080CF0245ADFC77B7"]) {
      if(istrue(var_3.shouldmodeplayfinalmoments))
        var_1++;
    }

    var_0.startpayloadtanksobjective setvalue(var_1);
    wait 3;
  }
}

_id_12530(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = init_rpg_spawns("_encstr_8B1608EC43B8D647A113", 1.5);
  var_8.x = var_0;
  var_8.y = var_1;
  var_8.alignx = var_2;
  var_8.aligny = var_3;
  var_8.horzalign = var_4;
  var_8.vertalign = var_5;
  var_8.alpha = 1;
  var_8.glowalpha = 0;
  var_8.hidewheninmenu = 1;
  var_8.archived = 0;

  if(isDefined(var_6))
    var_8.label = var_6;

  if(isDefined(var_7))
    var_8 setvalue(var_7);

  return var_8;
}

init_rpg_spawns(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "_encstr_9779056EEA2583";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2.hidden = 0;
  return var_2;
}

init_respawns() {
  self.startteamcontractchallenge = spawnStruct();
  self.startteamcontractchallenge._id_13A72 = [];
}

_id_1315F() {
  var_0 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");
  wait 2;

  while(isDefined(var_0.vehicle)) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0.team) {
        continue;
      }
      if(isDefined(var_2.vehicle) && isDefined(var_2.vehicle.targetname) && var_2.vehicle.targetname == "_encstr_BE820B53A080CF0245ADFC77B7")
        var_0 thread staticmodelid(var_2);
    }

    [var_5, var_6] = rooftop_active();

    foreach(var_2 in level.players) {
      if(var_2.team == var_0.team) {
        continue;
      }
      if(isDefined(level.startpayloadpunish)) {
        if(var_2[[level.startpayloadpunish]]("_encstr_A94E14B9E0B2D85A2C638E5EEB76AB59E44EA5361BC2") || var_2[[level.startpayloadpunish]]("_encstr_8E0E159E3A72E73079A3A8C8879308359A229530557B8F"))
          continue;
      }

      var_8 = _id_13D9C(var_2.origin, var_0.vehicle.origin, var_5, var_6);

      if(istrue(var_8))
        var_0 thread staticmodelid(var_2);
    }

    wait 5;
  }
}

rooftop_active() {
  var_0 = self;
  var_0 notify("_encstr_A2EF1D8827C4464F520527B6514AAFA83D37A0309F661E0D9A2AA533B602DF");
  var_0 endon("_encstr_A2EF1D8827C4464F520527B6514AAFA83D37A0309F661E0D9A2AA533B602DF");
  var_1 = var_0.vehicle.origin;
  var_2 = anglesToForward(var_0.vehicle.angles);
  var_3 = vectorcross(var_2, (0, 0, 1));
  var_4 = var_2 * level.stay_on_roof_until_bothered_internal * cos(level.stay_on_roof_until_bothered);
  var_5 = level.stay_on_roof_until_bothered_internal * sin(level.stay_on_roof_until_bothered);
  var_6 = [];
  var_7 = (0, 0, 0);
  var_8 = undefined;
  var_9 = undefined;

  for(var_10 = 0; var_10 < 2; var_10++) {
    var_11 = var_10 / 2 * 360;
    var_12 = var_1 + var_4 + var_5 * (var_3 * cos(var_11));
    var_7 = var_12;

    if(isDefined(var_9)) {
      var_8 = var_12;
      continue;
    }

    var_9 = var_12;
  }

  return [var_8, var_9];
}

_id_13D9C(var_0, var_1, var_2, var_3) {
  var_4 = updatescrapassistdataforcecredit(var_0, var_1, var_2, var_3);

  if(var_4)
    return 1;
  else
    return 0;
}

updatescrapassistdataforcecredit(var_0, var_1, var_2, var_3) {
  if(!use_nvg_think(var_0, var_1, var_2))
    return 0;

  if(!use_nvg_think(var_0, var_2, var_3))
    return 0;

  if(!use_nvg_think(var_0, var_3, var_1))
    return 0;

  return 1;
}

use_nvg_think(var_0, var_1, var_2) {
  return (var_2[0] - var_1[0]) * (var_0[1] - var_1[1]) - (var_0[0] - var_1[0]) * (var_2[1] - var_1[1]) < 0;
}

staticmodelid(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 = "_encstr_86A815A15732FA2DB1DEB9BE43ACB08CAFB5584EB5ACC8";
  var_3 = 8;
  var_4 = 1;
  var_5 = 500;
  var_6 = 40000;
  var_1.startteamcontractchallenge._id_13A72[var_0 getentitynumber()] = var_0;
  var_7 = var_0;
  var_7.headicon = var_0 scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_1, var_2, var_3, var_4, var_6, var_5, undefined, 1, 1);
  var_1 station_names(var_0);
  var_1 station_name_chosen_as_starting(var_0);
}

station_names(var_0) {
  var_1 = self;
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 = var_0 getentitynumber();
  var_0 scripts\engine\utility::waittill_notify_or_timeout("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", 4.0);
}

station_name_chosen_as_starting(var_0) {
  var_1 = self;
  var_2 = var_0 getentitynumber();

  if(isDefined(var_1.startteamcontractchallenge) && isDefined(var_1.startteamcontractchallenge._id_13A72)) {
    var_3 = var_1.startteamcontractchallenge._id_13A72[var_2];

    if(isDefined(var_3) && isDefined(var_3.headicon)) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_3.headicon);
      var_1.startteamcontractchallenge._id_13A72[var_2] = undefined;
    }
  }
}

unset_force_aitype_riotshield() {
  var_0 = self;

  if(var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() && isDefined(var_0.targetname) && var_0.targetname == "_encstr_BE820B53A080CF0245ADFC77B7")
    return 1;

  return 0;
}