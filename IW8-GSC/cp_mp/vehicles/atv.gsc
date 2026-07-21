/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\atv.gsc
***********************************************/

atv_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_8C190467402B", 1);
  var_0.destroycallback = ::atv_explode;
  atv_initoccupancy();
  atv_initinteract();
  check_dropped_locations_and_offset();
  check_digit_models_to_create();
  check_crate_unreachable();
  atv_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8C190467402B", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C190467402B", "_encstr_88C5055208731B")]]();

  atv_initspawning();
  atv_initlate();
}

atv_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8C190467402B", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C190467402B", "_encstr_BAF609D2739647C4853A2B")]]();
}

atv_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_8C190467402B", 1);
  var_0.enterendcallback = ::atv_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::atv_exitend;
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 45;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 45;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 28;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 28;
  var_0.exitextents["_encstr_AC190479FF92"] = 45;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_0.exittopcastoffset = 40;
  var_1 = "_encstr_A5AD056A019C63";
  var_0.exitoffsets[var_1] = (-5, 0, 55);
  var_0.exitdirections[var_1] = "_encstr_A5AD056A019C63";
  var_1 = "_encstr_8253060E2B5FE330";
  var_0.exitoffsets[var_1] = (-5, 0, 55);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (29, 0, 55);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_B69B0589C236B6";
  var_0.exitoffsets[var_1] = (-35, 0, 45);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_811F05C0C73103"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_8C190467402B", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_A5AD056A019C63", "_encstr_8253060E2B5FE330", "_encstr_B69B0589C236B6", "_encstr_AA5606FD1AF05085"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_4._id_13345 = 1;
  var_3 = "_encstr_811F05C0C73103";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_8C190467402B", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = ["_encstr_B69B0589C236B6", "_encstr_8253060E2B5FE330", "_encstr_A5AD056A019C63", "_encstr_AA5606FD1AF05085"];
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_4.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_4._id_13345 = 1;
}

atv_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_8C190467402B", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_8C190467402B", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_811F05C0C73103"]);
}

check_dropped_locations_and_offset() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_8C190467402B", 1);
  var_0.id = 4;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_811F05C0C73103"] = 1;
}

check_digit_models_to_create() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_8C190467402B", 500);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_8C190467402B");
  var_0.class = "_encstr_818F0CB9D50E9527EB1B963B3447";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_8C190467402B");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_8C190467402B", 4);

  if(level.gametype == "_encstr_B607038AAB")
    scripts\cp_mp\vehicles\vehicle_damage::_id_14179("_encstr_8C190467402B", 6, "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B");

  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_8C190467402B", ::atv_deathcallback);
}

check_crate_unreachable() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_8C190467402B", 1);
  var_0.challengeevaluator = 1;
  var_0.keycardlocs_chosen = 1;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 12.5;
  var_0.isallowedweapon = 50;
  var_0.isakimbo = 100;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 1;
  var_1 = _calloutmarkerping_predicted_log::_id_1410E();
  var_1.keycardlocs_chosen["_encstr_8C190467402B"] = [];
  var_1.keycardlocs_chosen["_encstr_8C190467402B"]["_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6"] = 2;
}

atv_initfx() {
  level._effect["_encstr_B8C90C97F934F96DC0F3ED3569F0"] = loadfx("_encstr_AFA632AB717358881B603EEB5FE0D7D8CFA5A7930322BE95CA8BD5E6D39B5783F85171AA22B0DBC73B70E848F142B3C0A5E8B391");
}

atv_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_81391FC35302D8A8738989B121F69861E97BB69A27185160335E1B21D8CBE70D71";
  var_0.targetname = "_encstr_8C190467402B";
  var_0.vehicletype = "_encstr_9A981257491E559F356058E910276A60A359D570";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_8C190467402B", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_A7A70785E89DD7AD0E");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8C190467402B", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C190467402B", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

atv_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_A7A70785E89DD7AD0E";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread atv_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A7A70785E89DD7AD0E");
    playFX(scripts\engine\utility::getfx("_encstr_B8C90C97F934F96DC0F3ED3569F0"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_B8FD1290BF6988D9092E5FDE098239B3DC1FB0A8");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

atv_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8C190467402B", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C190467402B", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

atv_deathcallback(var_0) {
  thread atv_explode(var_0);
  return 1;
}

atv_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    atv_enterendinternal(var_0, var_1, var_2, var_3, var_4);
}

atv_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

atv_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    atv_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

atv_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

atv_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_8C190467402B", 1);
  var_0.maxinstancecount = 4;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::atv_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8C190467402B", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 55;
  var_0.clearancecheckheight = 45;
  var_0.clearancecheckminradius = 55;
}

atv_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_BE7E0A0F2843CFA3792F7B35", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}