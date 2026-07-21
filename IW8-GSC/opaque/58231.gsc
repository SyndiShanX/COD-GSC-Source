/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58231.gsc
***********************************************/

get_priority_player() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", 1);
  var_0.destroycallback = ::get_power_ref_from_weapon;
  get_random_impact_point_on_line();
  get_random_circle_direction();
  get_random_leftover_letter();
  get_proximity_alias();
  get_prohibited_weapons_back();
  get_push_force_direction();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_88C5055208731B")]]();

  get_random_notnegative();
  get_random_impact_point();
}

get_random_impact_point() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_BAF609D2739647C4853A2B")]]();
}

get_random_impact_point_on_line() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", 1);
  var_0.enterendcallback = ::get_positions_around_vector;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::get_power_max_charge_in_slot;
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
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_8CF00A181FEBFB5B6A5FCD4E"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_AB0A0B99C9DBB98EAFC69533E8", "_encstr_AB6A0AD6342AA38E0CCF60E8", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_8CF00A181FEBFB5B6A5FCD4E";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085", "_encstr_AB0A0B99C9DBB98EAFC69533E8", "_encstr_AB6A0AD6342AA38E0CCF60E8", "_encstr_974E0A4CB0D85BAFD895998E"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_4.animtag = "_encstr_A70D0BFBD379B6D25977D3700A";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
}

get_random_circle_direction() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_8CF00A181FEBFB5B6A5FCD4E"]);
}

get_random_leftover_letter() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", 1);
  var_0.id = 21;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_8CF00A181FEBFB5B6A5FCD4E"] = 1;
}

get_proximity_alias() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", 2300);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB");
  var_0.class = "_encstr_B846067B175AA56A";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", 12);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", ::get_players_inside_the_plane);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_8FC20FAB0B58176F7853C3BB994A774DA0", 5);
}

get_prohibited_weapons_back() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", 1);
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

get_push_force_direction() {
  level._effect["_encstr_A68819B2A9BE17556971D2DD77E0111F6583FBF9B113834D1049FD"] = loadfx("_encstr_AF502FCE3387E5D2EEE0FA2627F2B4378D857319CBB3560DBCD933C3FA9827CCEBC6A3FA46B2B08EA1F52B0FC1B8EC99F0");
}

get_players_in_mortar_range(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_872B20AB32C3F0C05B0F939354F940209B0963939B371269A51893D9410B6A606F33";
  var_0.targetname = "_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB";
  var_0.vehicletype = "_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_8FC20FAB0B58176F7853C3BB994A774DA0");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

get_power_ref_from_weapon(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread get_players_not_targeted_by_other_battle_station();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8FC20FAB0B58176F7853C3BB994A774DA0");
    playFX(scripts\engine\utility::getfx("_encstr_A68819B2A9BE17556971D2DD77E0111F6583FBF9B113834D1049FD"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

get_players_not_targeted_by_other_battle_station() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

get_players_inside_the_plane(var_0) {
  thread get_power_ref_from_weapon(var_0);
  return 1;
}

get_positions_around_vector(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    get_power_charges_in_slot(var_0, var_1, var_2, var_3, var_4);
}

get_power_charges_in_slot(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

get_power_max_charge_in_slot(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    get_power_name_in_slot(var_0, var_1, var_2, var_3, var_4);
}

get_power_name_in_slot(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4.playerdisconnect))
      var_3 controlsunlink();
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_5) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840")]](var_3);
      else
        var_3 suicide();
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

get_random_notnegative() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::get_precision_use_parameters;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

get_precision_use_parameters() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_ABF215FF783B1F8A69BED34E2A4FE3B3C321273B0BF35E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}