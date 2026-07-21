/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58232.gsc
***********************************************/

get_num_of_wire_to_cut() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", 1);
  var_0.destroycallback = ::get_num_dogtag_in_kill_zone_or_under_bridge_zone;
  get_pathstruct();
  get_other_active_zone();
  get_pavelow_boss_info();
  get_offset_from_stance();
  get_objective_label();
  get_omnvar_value_based_on_bomb_label();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_88C5055208731B")]]();

  get_pipe_room_spawnpoint();
  get_paired_bombvest_chair();
}

get_paired_bombvest_chair() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_BAF609D2739647C4853A2B")]]();
}

get_pathstruct() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", 1);
  var_0.enterstartcallback = ::get_next_station_on_track_after_index;
  var_0.enterendcallback = ::get_next_spawn_index;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::get_next_track_index;
  var_0.reentercallback = ::get_player_enemy;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 110;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 135;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 48;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 48;
  var_0.exitextents["_encstr_AC190479FF92"] = 100;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (140, 0, 115);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_8FEE0C6E10B7CB6067CD678F0CE3";
  var_0.exitoffsets[var_1] = (65, 23, 115);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_AB0A0B99C9DBB98EAFC69533E8";
  var_0.exitoffsets[var_1] = (65, 23, 115);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-152, 36, 115);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_AB6A0AD6342AA38E0CCF60E8";
  var_0.exitoffsets[var_1] = (-109, 36, 115);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_8D48079DD59BE65627", "_encstr_8CF00A181FEBFB5B6A5FCD4E"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_AB0A0B99C9DBB98EAFC69533E8", "_encstr_AB6A0AD6342AA38E0CCF60E8", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_8CF00A181FEBFB5B6A5FCD4E";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085", "_encstr_AB0A0B99C9DBB98EAFC69533E8", "_encstr_AB6A0AD6342AA38E0CCF60E8", "_encstr_974E0A4CB0D85BAFD895998E"];
  var_4.viewclamps["_encstr_AC190479FF92"] = 24;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 42;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 101;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 122;
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_4.animtag = "_encstr_A70D0BFBD379B6D25977D3700A";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_8D48079DD59BE65627";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_974E0A4CB0D85BAFD895998E", "_encstr_AB6A0AD6342AA38E0CCF60E8", "_encstr_AB0A0B99C9DBB98EAFC69533E8", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4._id_13E8A = getcompleteweaponname("_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A");
  var_4._id_13E92 = "_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A";
  var_4._id_12023 = "_encstr_A9891440525D07260BBDEB53934BA9AFC77B48380AF2";
}

get_other_active_zone() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_8D48079DD59BE65627", "_encstr_8CF00A181FEBFB5B6A5FCD4E"]);
}

get_pavelow_boss_info() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", 1);
  var_0.id = 23;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_8D48079DD59BE65627"] = 1;
  var_0.seatids["_encstr_8CF00A181FEBFB5B6A5FCD4E"] = 2;
  var_0._id_12DA2[0] = 0;
  var_0._id_12DA3["_encstr_9AE307B956E345D0AB"]["_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A"] = 0;
  var_0._id_12DA3["_encstr_8D48079DD59BE65627"]["_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A"] = 0;
}

get_offset_from_stance() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", 2300);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843");
  var_0.class = "_encstr_B846067B175AA56A";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", 12);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", ::get_next_open_stop);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_8FC20FAB0B58176F7853C3BB994A774DA0", 5);
}

get_objective_label() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", 1);
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

get_omnvar_value_based_on_bomb_label() {
  level._effect["_encstr_A3C114362CC976F67D8E395DC6DAD7AC0F388DDB2356"] = loadfx("_encstr_A53930DBCDC30E9148EA3185DBB2B6E2934B07CBA3C02356D8EE368EF398E72B768FA7336F9DDA09E0102197AAF87E43C439");
}

get_next_cypher_id_from_pool(var_0, var_1, var_2, var_3, var_4) {
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

get_next_available_wire_for_bomb(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_ABF528AB5878274BE928D5CCA91772AE41213B33A0715BB18757DE8207B9EF57E920E753B0698CF9DF6A";
  var_0.targetname = "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843";
  var_0.vehicletype = "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  var_3 = get_next_cypher_id_from_pool(var_2, "_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A", "_encstr_9BF6213B2B1AD7CD43FAB5B48DF536B98CF547D52793CAA3FAE25D1646AF0B85EBEE4F", "_encstr_99FE0B2B19086F6B9DC5D387E1", (0, 0, 0));
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_3, getcompleteweaponname("_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A"));
  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_8FC20FAB0B58176F7853C3BB994A774DA0");
  var_2._id_13E92 = "_encstr_A6ED1BFB4185B0A7A3F98B53D3236D7011DE715BE3A1D0FD9BB261788A";
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  thread get_player_munition_currency(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

get_player_munition_currency(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_3))
    var_0 endon(var_3);

  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;

  for(;;) {
    var_7 = 0;
    var_8 = anglestoup(var_0.angles)[2];

    if(var_8 <= 0.0872) {
      if(!isDefined(var_5))
        var_5 = gettime() + 3000;

      if(gettime() > var_5) {
        var_7 = 1;
        var_5 = undefined;
      }
    } else {
      if(var_4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_141C6(var_0, 1);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_0, 1);
        var_4 = 0;
      }

      var_7 = 0;
      var_5 = undefined;
    }

    if(var_7) {
      if(isDefined(var_1))
        thread[[var_1]](var_0);

      if(!var_4) {
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_141C6(var_0, 0);
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse(var_0, 0);
        var_4 = 1;
      }

      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants(var_0);
      var_9 = 0;
      var_6 = gettime() + 3000;

      for(;;) {
        if(gettime() >= var_6) {
          var_9 = 1;
          break;
        }

        waitframe();
      }

      var_6 = undefined;

      if(isDefined(var_2))
        thread[[var_2]](var_0, var_9);
    }

    waitframe();
  }
}

get_num_dogtag_in_kill_zone_or_under_bridge_zone(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread get_next_rein_group();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0");
    playFX(scripts\engine\utility::getfx("_encstr_A3C114362CC976F67D8E395DC6DAD7AC0F388DDB2356"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

get_next_rein_group() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

get_next_open_stop(var_0) {
  thread get_num_dogtag_in_kill_zone_or_under_bridge_zone(var_0);
  return 1;
}

get_next_station_on_track_after_index(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_8D48079DD59BE65627")
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, var_0._id_13E92, var_4, 1);
}

get_next_spawn_index(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    get_next_station_on_track(var_0, var_1, var_2, var_3, var_4);
}

get_next_station_on_track(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2) && var_2 == "_encstr_8D48079DD59BE65627") {
    var_5 = "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843";
    var_6 = 6;
  }

  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  } else if(var_1 == "_encstr_8D48079DD59BE65627") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_7 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_0._id_13E92);
    var_7.owner = var_3;
    var_7 setotherent(var_3);
    var_7 setentityowner(var_3);
    var_7 setsentryowner(var_3);
    var_3 disableturretdismount();
    var_3 controlturreton(var_7);
  }

  if(var_1 != "_encstr_8D48079DD59BE65627")
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

get_next_track_index(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    get_node_closest_to_target_loc(var_0, var_1, var_2, var_3, var_4);
}

get_node_closest_to_target_loc(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
  }

  var_5 = !isDefined(var_2);

  if(var_1 == "_encstr_8D48079DD59BE65627" || var_5 && var_3 hasweapon(var_0._id_13E92)) {
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
    var_6 setsentryowner(undefined);
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

get_player_enemy(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F6(var_4);
  thread get_player_info_proc(var_0, var_1, var_2, var_3, var_4);
}

get_player_info_proc(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "_encstr_8D48079DD59BE65627") {
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0._id_13E92, var_4, 1);
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F7(var_5);
  }
}

get_pipe_room_spawnpoint() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::get_num_of_valid_players;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

get_num_of_valid_players() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_AFED17935FA3773D094883FA985FF36F9B371937EE4BB7C3D5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}