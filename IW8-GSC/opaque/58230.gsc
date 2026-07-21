/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58230.gsc
***********************************************/

get_intel_location_vo() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B", 1);
  var_0.destroycallback = ::get_gunshot_alias;
  var_0._id_13E92 = "_encstr_8E26171D5DE4FACEBAE6F51B85C9B3DBD78EC9EA1B5BD7DA38";
  get_landing_spots_in_current_circle();
  get_invalid_seats_from_module_struct();
  get_laser_combat_logic();
  get_intel_ref();
  get_intel_pickup_vo();
  get_intermission_time();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_88C5055208731B")]]();

  get_last_callout_time();
  get_investigate_alias();
}

get_investigate_alias() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_BAF609D2739647C4853A2B")]]();
}

get_landing_spots_in_current_circle() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B", 1);
  var_0.enterstartcallback = ::get_grenadedanger_alias;
  var_0.enterendcallback = ::get_grenade_fuse_time;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::get_ground_normal;
  var_0.reentercallback = ::get_max_ai_from_infil_name;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 175;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 180;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 68;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 68;
  var_0.exitextents["_encstr_AC190479FF92"] = 138;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (140, 0, 115);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_8FEE0C6E10B7CB6067CD678F0CE3";
  var_0.exitoffsets[var_1] = (65, 23, 115);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_0.exitoffsets[var_1] = (-152, 36, 115);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_82CF0B6862EF3316CB61BC2354";
  var_0.exitoffsets[var_1] = (-109, 36, 115);
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
  var_1 = "_encstr_B69B0589C236B6";
  var_0.exitoffsets[var_1] = (-152, 36, 115);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_8D48079DD59BE65627"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_BAC20FBEE6F88945F163A37BD68409923B", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_AB0A0B99C9DBB98EAFC69533E8", "_encstr_AB6A0AD6342AA38E0CCF60E8", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085"];
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_8D48079DD59BE65627";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_BAC20FBEE6F88945F163A37BD68409923B", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_82CF0B6862EF3316CB61BC2354", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AB0A0B99C9DBB98EAFC69533E8", "_encstr_AA5606FD1AF05085"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4._id_13E8A = getcompleteweaponname("_encstr_8E26171D5DE4FACEBAE6F51B85C9B3DBD78EC9EA1B5BD7DA38");
  var_4._id_13E92 = "_encstr_8E26171D5DE4FACEBAE6F51B85C9B3DBD78EC9EA1B5BD7DA38";
  var_4._id_12023 = "_encstr_A9891440525D07260BBDEB53934BA9AFC77B48380AF2";
}

get_invalid_seats_from_module_struct() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_8D48079DD59BE65627"]);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_A7D708BA0E769358C859", ["_encstr_A96D107BAE9F014632C3DBD39BD901683643", 1, ::get_module_call_count]);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_966C0E37C0B3B9320575CA07DE33BA6D", ["_encstr_8FBE114B21BC6FCA1BC54D55E5B9D2FFD478C3", 1, ::get_module_call_count]);
}

get_laser_combat_logic() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_BAC20FBEE6F88945F163A37BD68409923B", 1);
  var_0.id = 16;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_8D48079DD59BE65627"] = 1;
  var_0._id_12DA2[0] = 0;
  var_0._id_12DA2[1] = 1;
  var_0._id_12DA3["_encstr_9AE307B956E345D0AB"]["_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213"] = 0;
  var_0._id_12DA3["_encstr_9AE307B956E345D0AB"]["_encstr_8E26171D5DE4FACEBAE6F51B85C9B3DBD78EC9EA1B5BD7DA38"] = 1;
  var_0._id_12DA3["_encstr_8D48079DD59BE65627"]["_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213"] = 0;
  var_0._id_12DA3["_encstr_8D48079DD59BE65627"]["_encstr_8E26171D5DE4FACEBAE6F51B85C9B3DBD78EC9EA1B5BD7DA38"] = 1;
}

get_intel_ref() {
  var_0 = getdvarfloat("_encstr_BDB22237C627FA0BC95BED93CA8CEB47E4571BADF5D0ACC21B1D1A7DF63B56399CB44656", 8750);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_BAC20FBEE6F88945F163A37BD68409923B", var_0, undefined, undefined, undefined, 30);
  var_1 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B");
  var_1.class = "_encstr_B846067B175AA56A";
  var_2 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414D("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_B846067B175AA56A");
  var_2._id_12024 = ::get_linked_structs_with_script_noteworthy;
  var_2._id_1202D = ::get_living_agent_count;
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_BAC20FBEE6F88945F163A37BD68409923B");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_BAC20FBEE6F88945F163A37BD68409923B", getdvarint("_encstr_8B981DDC369CD7589CDAF64EFA8E27BAB1DA7DA14B479B7D3ADBD76D5A8DD8", 40));
  scripts\cp_mp\vehicles\vehicle_damage::_id_14175("_encstr_BAC20FBEE6F88945F163A37BD68409923B", ::get_living_agents);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_BAC20FBEE6F88945F163A37BD68409923B", ::get_goal_radius);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14173("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_9AE307B956E345D0AB", getdvarfloat("_encstr_A79D193AFB8D20AB5E1113234EAFD16148ADC24FADF9FEB31355D9", 0.7));
  scripts\cp_mp\vehicles\vehicle_damage::_id_14172("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_9AE307B956E345D0AB", getdvarfloat("_encstr_A955195893B5ED9CFA47C9578DD6D7230BB6587659FAC68DB0B583", 15));
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213", 5);
}

get_intel_pickup_vo() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_BAC20FBEE6F88945F163A37BD68409923B", 1);
  var_0.challengeevaluator = 2.16666;
  var_0.keycardlocs_chosen = 0.70833;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 3.75;
  var_0.isallowedweapon = 7.5;
  var_0.isakimbo = 15;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

get_intermission_time() {
  level._effect["_encstr_873A17FE09B047EAB8F9C3D73F5A11B5F056F780831807128D"] = loadfx("_encstr_A53930DBCDC30E9148EA3185DBB2B6E2934B07CBA3C02356D8EE368EF398E72B768FA7336F9DDA09E0102197AAF87E43C439");
}

get_heli_intro_vo() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B");
  return var_0._id_13E92;
}

get_friendly_convoy_vehicle(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  if(!isDefined(var_0.modelname))
    var_0.modelname = "_encstr_A16C1C56AD10FAC1CB40C2099035C7AF6802C1F43033AE99F788EA12F025";

  var_0.targetname = "_encstr_BAC20FBEE6F88945F163A37BD68409923B";

  if(!isDefined(var_0.vehicletype))
    var_0.vehicletype = "_encstr_B87B11439AA9512A79A760E17BE35A272F5FBF";

  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  var_3 = get_heli_intro_vo();
  var_4 = "_encstr_ACA123AB85E9BF1FE84BE32763A01C714B2AF4A57885C757F198F3DB50DBEF8B033EBA1F5D";

  if(isDefined(var_0.turretmodel))
    var_4 = var_0.turretmodel;

  var_5 = get_health_stage();
  var_6 = get_gas_martyr_grenade_types(var_2, var_3, var_4, var_5.tag, var_5.tagoffset);
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_2, var_6, getcompleteweaponname(var_3));
  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_BAC20FBEE6F88945F163A37BD68409923B", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213");
  var_2._id_13E92 = var_3;
  var_2._id_11B7B = 3;
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  var_7 = scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback;

  if(isDefined(var_0.player_rig_create))
    var_7 = var_0.player_rig_create;

  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, var_7);
  thread get_module_struct_from_level(var_2);
  var_2 thread get_model_for_color_wire_cut(var_2);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

get_health_stage() {
  var_0 = spawnStruct();

  if(getdvarint("_encstr_8B081F6C854ECE7BEBD193AB36B6FAA3BA27C995A3EBD12C9D7D2CCDA5ADC2A359", 0) == 1) {
    iprintlnbold("_encstr_A109195F2A11128B906FF7D267E090A7573892C2090DDF569AF39D");
    var_0.tag = "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118";
    var_0.tagoffset = (58.87, 0, 60.052);
  } else {
    var_0.tag = "_encstr_99FE0B2B19086F6B9DC5D387E1";
    var_0.tagoffset = (0, 0, 0);
  }

  return var_0;
}

get_gas_martyr_grenade_types(var_0, var_1, var_2, var_3, var_4) {
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

get_gunshot_alias(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  if(!istrue(level.suppressvehicleexplosion)) {
    self notify("_encstr_8B1A098BD8E134029B657C");
    wait 0.2;
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);

  if(!istrue(level.suppressvehicleexplosion))
    waitframe();

  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread get_grenade_force();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_928912BAA1B60F4D6149DAC57F98196F541ED213");
    playFX(scripts\engine\utility::getfx("_encstr_873A17FE09B047EAB8F9C3D73F5A11B5F056F780831807128D"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_ACF9159DE7F2D810EBDC8D7849C588109A3B0921B75A9D");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

get_grenade_force() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

get_living_agents(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(self, "_encstr_A7B606DA83796F4A"))
    var_0.damage = var_0.damage * get_has_combined_counters_alias();

  if(isDefined(var_0.damage) && var_0.damage > 0)
    self notify("_encstr_B2310D943398AE674DEE4B0270958B", var_0);

  return 1;
}

get_has_combined_counters_alias() {
  return 0.8333;
}

get_goal_radius(var_0) {
  thread get_gunshot_alias(var_0);
  return 1;
}

get_linked_structs_with_script_noteworthy(var_0, var_1) {
  self setscriptablepartstate("_encstr_85BB067A08ABFAD7", "_encstr_BD7D0E1DB0C45B182AB753F0E5780B0D", 0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14163(var_0, var_1);
}

get_living_agent_count(var_0, var_1) {
  self setscriptablepartstate("_encstr_85BB067A08ABFAD7", "_encstr_BA19049F4B2D", 0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14169(var_0, var_1);
}

get_grenadedanger_alias(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_8D48079DD59BE65627") {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, var_0._id_13E92, var_4, 1);
  } else if(isDefined(var_2) && var_2 == "_encstr_8D48079DD59BE65627")
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
}

get_grenade_fuse_time(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    thread get_grenade_settings_from_group(var_0, var_1, var_2, var_3, var_4);
  else if(!istrue(var_4.playerdisconnect) && !istrue(var_4.playerdeath)) {
    if(var_1 == "_encstr_8D48079DD59BE65627")
      get_max_charges(var_3);
  }
}

get_grenade_settings_from_group(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2) && var_2 == "_encstr_8D48079DD59BE65627") {
    var_5 = "_encstr_B87B11439AA9512A79A760E17BE35A272F5FBF";
    var_6 = 6;
  }

  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2, undefined, var_5, var_6);
  } else if(var_1 == "_encstr_8D48079DD59BE65627") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, 0);
    var_7 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_0._id_13E92);
    var_7.owner = var_3;
    var_7 setotherent(var_3);
    var_7 setentityowner(var_3);
    var_7 setsentryowner(var_3);
    var_3 disableturretdismount();
    var_3 controlturreton(var_7);
    get_focus_fire_multipler(var_3);
  }

  thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F6(var_4, 1);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
  get_minigun_path(var_0, undefined);
}

get_ground_normal(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    get_guilty_player_name(var_0, var_1, var_2, var_3, var_4);
}

get_guilty_player_name(var_0, var_1, var_2, var_3, var_4) {
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

    if(!istrue(var_4.playerdisconnect))
      get_max_charges(var_3);
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
  get_minigun_path(var_0, undefined);
}

get_focus_fire_multipler(var_0) {
  if(isDefined(var_0.set_thirdperson)) {
    return;
  }
  var_0.set_thirdperson = 1;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B");

  if(istrue(var_1._id_133D3)) {
    return;
  }
  var_0 scripts\cp_mp\utility\damage_utility::adddamagemodifier("_encstr_9ABD17493B45108C63839D839B88D3E8F3D410012AB5C04D8B", 0.4, 0, ::get_id_based_on_task);
}

get_max_charges(var_0) {
  if(!isDefined(var_0.set_thirdperson)) {
    return;
  }
  var_0.set_thirdperson = undefined;
  var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B");

  if(istrue(var_1._id_133D3)) {
    return;
  }
  var_0 scripts\cp_mp\utility\damage_utility::removedamagemodifier("_encstr_9ABD17493B45108C63839D839B88D3E8F3D410012AB5C04D8B", 0);
}

get_id_based_on_task(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B" && var_4 != "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
    return 1;

  if(!isDefined(var_5))
    return 1;

  switch (var_5.basename) {
    case "_encstr_BD6D15DAA3532F4D50DF1C49A188D32316B892F30E41CB":
    case "_encstr_BE3E15E34720D111A7E99B2A62335DC84FA15D63C7DDF0":
    case "_encstr_81D911B12DB386D14716DC6DBE8EABE4F5ADE0":
    case "_encstr_A16D1149A41A670DD3F123FBF809860E2E01D8":
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
    case "_encstr_8ABB134AEB113F41C8C180B2C79AB2FF83E7E7E51B":
    case "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0":
    case "_encstr_8E26171D5DE4FACEBAE6F51B85C9B3DBD78EC9EA1B5BD7DA38":
    case "_encstr_8BD015B08BF0BF888F4F2D835BE311954F72E0A061FD59":
      return 0;
    default:
      return 1;
  }
}

get_max_ai_from_infil_name(var_0, var_1, var_2, var_3, var_4) {
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F6(var_4);
  thread get_mortar_targets(var_0, var_1, var_2, var_3, var_4);
}

get_mortar_targets(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "_encstr_8D48079DD59BE65627") {
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DC(var_3, var_4);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, var_0._id_13E92, var_4, 1);
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_141F7(var_5);
  }
}

get_module_struct_from_level(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");

  for(;;) {
    var_0 waittill("_encstr_AC5B0D1F53442A27D863BFC2796825", var_1, var_2);

    switch (var_1) {
      case "_encstr_A7B606DA83796F4A":
        get_heli_structs(var_0);
        break;
      case "_encstr_9BB4074B8EEF3942D8":
        get_hover_attack_direction(var_0);
        break;
      case "_encstr_851904B59B34":
        get_huntfirstlost_alias(var_0, var_2);
        break;
      case "_encstr_A19A0772BF43C35FD9":
        get_highest_priority_goal_position(var_0);
        break;
    }

    get_minigun_path(var_0, var_2);
  }
}

get_heli_structs(var_0) {
  var_0 setscriptablepartstate("_encstr_A7B606DA83796F4A", "_encstr_BD1805CB69C063");
  var_0._id_11E06 = 1.0769;
  var_0._id_11E07 = 0.9411;
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_0._id_13E92);
  var_1 setscriptablepartstate("_encstr_A7B606DA83796F4A", "_encstr_BD1805CB69C063");
  var_0 notify("_encstr_829110FBAB98D28AA55BF737B3D653397091", "_encstr_9A5C0FE613B3185B619883F4F6C1731A3D");
}

get_hover_attack_direction(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D6C0FD0DD2B5BCE0DAA07E333C0737B51", "_encstr_88C5055208731B")) {
    if(isDefined(var_0._id_13DDF)) {
      var_0._id_13DDF = 3;
      var_0 notify("_encstr_8891134727DE831AE57D85B65BEDFAE42B33D263D8");
      var_0 notify("_encstr_829110FBAB98D28AA55BF737B3D653397091", "_encstr_8891134727DE831AE57D85B65BEDFAE42B33D263D8");
    } else {
      var_0._id_13DDF = 3;
      var_0 setscriptablepartstate("_encstr_9BB4074B8EEF3942D8", "_encstr_BD1805CB69C063");
      var_1 = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D6C0FD0DD2B5BCE0DAA07E333C0737B51", "_encstr_88C5055208731B");
      var_0 thread[[var_1]](72, 280900, ::_id_13DDA, ::trophy_protectionsuccessful);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_82801EC35AABB318E59D4F01920D488B5790DB2962B3FD113860213FBBF4E840", "_encstr_88C5055208731B"))
        var_0.explosion = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_82801EC35AABB318E59D4F01920D488B5790DB2962B3FD113860213FBBF4E840", "_encstr_88C5055208731B")]](var_0);

      var_0 notify("_encstr_829110FBAB98D28AA55BF737B3D653397091", "_encstr_AFDA114793F6831AF27D168DA32D3B0BD1AC23");
    }
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

get_huntfirstlost_alias(var_0, var_1) {
  get_max_from_call_count(var_0, var_1);
  var_0._id_129C5 = 1;
  var_0 setscriptablepartstate("_encstr_BD1106229198D993", "_encstr_BD1805CB69C063");
  var_0 thread _id_12BF9();
  var_0 notify("_encstr_829110FBAB98D28AA55BF737B3D653397091", "_encstr_92CC0EC5392869C9B611EB63D8A3FA3C");
}

get_max_from_call_count(var_0, var_1) {
  var_2 = getdvarint("_encstr_B47C163A766D59E3922F4048CFFD705F0DA0EBC86DAB9FB5", 0);

  if(var_2 == 0)
    var_0 _meth_87AB();
  else if(isDefined(var_1)) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 linkTo(var_0);
    var_3 makeportableradar(var_1);
    var_0.radar = var_3;
    level thread get_max_ai_per_site(var_0, var_1);
  }
}

get_martyrdom_grenade_types(var_0, var_1) {
  if(isDefined(var_0.radar))
    var_0.radar delete();
  else if(istrue(var_0._id_129C5))
    var_0 _meth_87AC();

  if(istrue(var_0._id_129C5))
    get_max_from_call_count(var_0, var_1);
}

get_max_ai_per_site(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.radar endon("_encstr_AD75063D571AE108");
  var_2 = var_1.team;
  var_1 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](var_2, 0);
  var_4 = undefined;

  if(isDefined(var_3) && var_3.size > 0)
    var_4 = var_3[0];

  level thread get_martyrdom_grenade_types(var_0, var_4);
}

_id_12BF9() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.radar))
    self.radar delete();
}

get_highest_priority_goal_position(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_0._id_13E92);
  var_1 setscriptablepartstate("_encstr_A19A0772BF43C35FD9", "_encstr_BD1805CB69C063");
  var_2 = getdvarfloat("_encstr_A73F1E437535BAE379F32BF22B7024B18DC987C33BD5829FE839267BA6387BCA", 0.033);
  var_3 = getdvarfloat("_encstr_857820B3F0CB0BDACF4D231AB653E3EF13484723F08145C199ED2E930809EB911B90", 0.155);
  var_1 _meth_87AD(var_2);
  var_1 _meth_87AF(var_3);
  var_0 notify("_encstr_829110FBAB98D28AA55BF737B3D653397091", "_encstr_88AB11564E1A6B3BE8A79FB73449DB032C274D");
}

get_model_for_color_wire_cut(var_0) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0._id_12664 = [];

  for(;;) {
    foreach(var_2 in var_0._id_12664)
    get_module_call_count(var_0, var_2);

    wait 0.1;
  }
}

get_module_call_count(var_0, var_1) {
  var_2 = 0;

  if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(var_0, "_encstr_851904B59B34"))
    var_2 = var_2 + 1;

  if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(var_0, "_encstr_A7B606DA83796F4A"))
    var_2 = var_2 + 2;

  if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(var_0, "_encstr_9BB4074B8EEF3942D8"))
    var_2 = var_2 + 4;

  if(scripts\cp_mp\vehicles\vehicle_interact::_id_141AC(var_0, "_encstr_A19A0772BF43C35FD9"))
    var_2 = var_2 + 8;

  if(isDefined(var_0._id_13DDF) && var_0._id_13DDF == 3)
    var_2 = var_2 + 16;

  if(var_0.health == var_0.maxhealth)
    var_2 = var_2 + 32;

  var_1 _calloutmarkerping_handleluinotify_added::_id_13133("_encstr_8C27180B70F0E7FA6BAF0AE5416983630DA962119B3D9F33E8BF", var_2);
}

get_minigun_path(var_0, var_1) {
  if(!getdvarint("_encstr_AB3D27F3471051073FDBEA52468D0B93C03FA765D7D163935551D3FA2E653BCFA09314F50F70AF9F89", 0)) {
    return;
  }
  var_2 = get_linked_struct_with_script_noteworthy(var_0);
  var_3 = get_gunshotteammate_alias(var_0, var_2, var_1);

  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
    return;
  }
  if(!isDefined(var_0._id_13DF6))
    var_0._id_13DF6 = var_3;

  if(var_0._id_13DF6 == var_3) {
    return;
  }
  var_0._id_13DF6 = var_3;
  var_4 = get_lostsight_alias(var_0, var_1);
  var_0 get_martyrdom_grenade_types(var_0, var_4);
}

get_linked_struct_with_script_noteworthy(var_0) {
  var_1 = var_0.occupants["_encstr_9AE307B956E345D0AB"];

  if(isDefined(var_1))
    return var_1.team;

  var_2 = var_0.occupants["_encstr_8D48079DD59BE65627"];

  if(isDefined(var_2))
    return var_2.team;

  return "_encstr_A7A408B9CA5D1D4E2C63";
}

get_gunshotteammate_alias(var_0, var_1, var_2) {
  if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63")
    return var_1;

  if(isDefined(var_2))
    return var_2.team;

  return var_0.team;
}

get_lostsight_alias(var_0, var_1) {
  if(isDefined(var_1))
    return var_1;

  var_2 = var_0.occupants["_encstr_9AE307B956E345D0AB"];

  if(isDefined(var_2))
    return var_2;

  var_3 = var_0.occupants["_encstr_8D48079DD59BE65627"];

  if(isDefined(var_3))
    return var_3;

  return undefined;
}

get_last_callout_time() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_BAC20FBEE6F88945F163A37BD68409923B", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::get_health_multiplier_relic_mythic;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BAC20FBEE6F88945F163A37BD68409923B", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 185;
  var_0.clearancecheckheight = 138;
  var_0.clearancecheckminradius = 185;
}

get_health_multiplier_relic_mythic() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_8CA71382101B81CD957678373BC8F05F339BD65B7D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}