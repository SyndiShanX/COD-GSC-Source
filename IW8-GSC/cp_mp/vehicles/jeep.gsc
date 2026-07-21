/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\jeep.gsc
***********************************************/

jeep_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_85DE05A6B2AC0E", 1);
  var_0.destroycallback = ::jeep_explode;
  jeep_initoccupancy();
  jeep_initinteract();
  vehicle_damage_getheavystatemaxhealth();
  vehicle_damage_getheavystatehealthadd();
  vehicle_damage_getburndowntime();
  jeep_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85DE05A6B2AC0E", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85DE05A6B2AC0E", "_encstr_88C5055208731B")]]();

  jeep_initspawning();
  jeep_initlate();
}

jeep_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85DE05A6B2AC0E", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85DE05A6B2AC0E", "_encstr_BAF609D2739647C4853A2B")]]();
}

jeep_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_85DE05A6B2AC0E", 1);
  var_0.enterendcallback = ::jeep_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::jeep_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatcabpassengerrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 105;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 105;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 44;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 44;
  var_0.exitextents["_encstr_AC190479FF92"] = 90;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (75, 0, 65);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_B69B0589C236B6";
  var_0.exitoffsets[var_1] = (-90, 0, 65);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_974E0A4CB0D85BAFD895998E"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_85DE05A6B2AC0E", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_B69B0589C236B6", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (17, 19, 65);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_8FEE0C6E10B7CB6067CD678F0CE3";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_85DE05A6B2AC0E", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_B69B0589C236B6", "_encstr_9AE307B956E345D0AB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (17, -19, 65);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.viewclamps["_encstr_AC190479FF92"] = 27;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 42;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 105;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 117;
  var_4.animtag = "_encstr_A70D0BFBD379B6D25977D3700A";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.hidestowedweapon = 1;
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_85DE05A6B2AC0E", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_B69B0589C236B6", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-24, -19, 65);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.viewclamps["_encstr_AC190479FF92"] = 27;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 42;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 101;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 122;
  var_4.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.hidestowedweapon = 1;
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_85DE05A6B2AC0E", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_9AE307B956E345D0AB", "_encstr_B69B0589C236B6", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-24, 19, 65);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.viewclamps["_encstr_AC190479FF92"] = 27;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 42;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 122;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 101;
  var_4.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.hidestowedweapon = 1;
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
}

jeep_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_85DE05A6B2AC0E", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_85DE05A6B2AC0E", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3"]);
}

vehicle_damage_getheavystatemaxhealth() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_85DE05A6B2AC0E", 1);
  var_0.id = 10;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_8FEE0C6E10B7CB6067CD678F0CE3"] = 1;
  var_0.seatids["_encstr_974E0A4CB0D85BAFD895998E"] = 2;
  var_0.seatids["_encstr_BE360B4C0B36B5FA4E5AB386A3"] = 3;
}

vehicle_damage_getheavystatehealthadd() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_85DE05A6B2AC0E", 1500);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_85DE05A6B2AC0E");
  var_0.class = "_encstr_AB5E07609A5B7368E5";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_85DE05A6B2AC0E");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_85DE05A6B2AC0E", 9);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_85DE05A6B2AC0E", ::jeep_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_AB6F081B8D7949AFC813", 3);
}

vehicle_damage_getburndowntime() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_85DE05A6B2AC0E", 1);
  var_0.challengeevaluator = 1.33333;
  var_0.keycardlocs_chosen = 0.91666;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 10;
  var_0.isallowedweapon = 40;
  var_0.isakimbo = 80;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

jeep_initfx() {
  level._effect["_encstr_8F280DF005171937EDAA706BD8E163"] = loadfx("_encstr_87762DD9CCF0E52DEEC17D5BC1979DB21A5AB1D82B97CE66C37D53ACB2E0EBB6E0D7322BB04743F5AC3C1C7167CC1E");
}

jeep_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_2 = scripts\cp_mp\utility\script_utility::_id_140DE("_encstr_B472054FE12550", "_encstr_979A0DD15F81E677754743DB49CEB3", 0);

  if(var_2)
    var_0.modelname = "_encstr_8C842F06DD608AB1A71033B920E5375F99B59B80602E6BC53750CA6388E321533025E53F07101F0A639053C97809694F2A";
  else
    var_0.modelname = "_encstr_9B372CA4C71AE97EF32F3081C306D1EF026F9623DD010D60E733C0E08B39CECD2A931D2072CADB6B89370891F768";

  var_0.targetname = "_encstr_85DE05A6B2AC0E";
  var_0.vehicletype = "_encstr_8275116BD09168F2B7370C409EE30A3BBE08B3";
  var_3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_3))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_3, "_encstr_85DE05A6B2AC0E", var_0);
  var_3.objweapon = getcompleteweaponname("_encstr_AB6F081B8D7949AFC813");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_3);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_3, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_3, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85DE05A6B2AC0E", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85DE05A6B2AC0E", "_encstr_8AEA073693CA16D12B")]](var_3);

  return var_3;
}

vehicle_damage_enginevisualcallback(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_9B372CA4C71AE97EF32F3081C306D1EF026F9623DD010D60E733C0E08B39CECD2A931D2072CADB6B89370891F768";
  var_0.targetname = "_encstr_85DE05A6B2AC0E";
  var_0.vehicletype = "_encstr_A12819D8AA26D1E8776023A35B9751AF81823820B37D53A39F9537";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_85DE05A6B2AC0E", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_AB6F081B8D7949AFC813");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85DE05A6B2AC0E", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85DE05A6B2AC0E", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

jeep_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_AB6F081B8D7949AFC813";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread jeep_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AB6F081B8D7949AFC813");
    playFX(scripts\engine\utility::getfx("_encstr_8F280DF005171937EDAA706BD8E163"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

jeep_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85DE05A6B2AC0E", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85DE05A6B2AC0E", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

jeep_deathcallback(var_0) {
  thread jeep_explode(var_0);
  return 1;
}

jeep_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    jeep_enterendinternal(var_0, var_1, var_2, var_3, var_4);
}

jeep_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

jeep_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    jeep_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

jeep_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

jeep_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_85DE05A6B2AC0E", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::jeep_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85DE05A6B2AC0E", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 105;
  var_0.clearancecheckheight = 90;
  var_0.clearancecheckminradius = 105;
}

jeep_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9B1A0BCA9B29FF2703F3124BE0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}