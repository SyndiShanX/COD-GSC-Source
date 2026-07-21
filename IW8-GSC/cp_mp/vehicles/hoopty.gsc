/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\hoopty.gsc
***********************************************/

hoopty_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_91CD07D045CF0B0BB8", 1);
  var_0.destroycallback = ::hoopty_explode;
  hoopty_initoccupancy();
  hoopty_initinteract();
  spawn_mindia_juggs();
  spawn_manual_turret();
  hoopty_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_91CD07D045CF0B0BB8", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_91CD07D045CF0B0BB8", "_encstr_88C5055208731B")]]();

  hoopty_initspawning();
  hoopty_initlate();
}

hoopty_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_91CD07D045CF0B0BB8", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_91CD07D045CF0B0BB8", "_encstr_BAF609D2739647C4853A2B")]]();
}

hoopty_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_91CD07D045CF0B0BB8", 1);
  var_0.enterendcallback = ::hoopty_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::hoopty_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 95;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 115;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 38;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 38;
  var_0.exitextents["_encstr_AC190479FF92"] = 73;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (90, 0, 54);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_8FEE0C6E10B7CB6067CD678F0CE3";
  var_0.exitoffsets[var_1] = (17, -19, 54);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-84, 19, 54);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_0.exitoffsets[var_1] = (-84, -19, 54);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_8A49119993F69B8E7D27D23B343ABE272BB039", "_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8", "_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB", "_encstr_AFB9108753607653A0D197631948FBB5C8FB"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_91CD07D045CF0B0BB8", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (17, 19, 54);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.damagemodifier = 0.5;
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_3 = "_encstr_AFB9108753607653A0D197631948FBB5C8FB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_91CD07D045CF0B0BB8", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8A49119993F69B8E7D27D23B343ABE272BB039", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-42, 19, 54);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_8A49119993F69B8E7D27D23B343ABE272BB039";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_91CD07D045CF0B0BB8", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AFB9108753607653A0D197631948FBB5C8FB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-84, -19, 54);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.animtag = "_encstr_910D0BD951F7D19EB70A9BE647";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_91CD07D045CF0B0BB8", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_9AE307B956E345D0AB", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-84, 19, 54);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_91CD07D045CF0B0BB8", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-84, -19, 54);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.animtag = "_encstr_8F0D0BA3C2D9FA6EB216D1D7D4";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
}

hoopty_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_91CD07D045CF0B0BB8", 1);
  var_0.seatenterarrays["_encstr_9AE307B956E345D0AB"] = ["_encstr_9AE307B956E345D0AB"];
  var_0.seatenterarrays["_encstr_AFB9108753607653A0D197631948FBB5C8FB"] = ["_encstr_AFB9108753607653A0D197631948FBB5C8FB"];
  var_0.seatenterarrays["_encstr_8A49119993F69B8E7D27D23B343ABE272BB039"] = ["_encstr_8A49119993F69B8E7D27D23B343ABE272BB039"];
  var_0.seatenterarrays["_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB"] = ["_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB"];
  var_0.seatenterarrays["_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8"] = ["_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8"];
}

spawn_mindia_juggs() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_91CD07D045CF0B0BB8", 1);
  var_0.id = 9;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_8FEE0C6E10B7CB6067CD678F0CE3"] = 1;
  var_0.seatids["_encstr_AFB9108753607653A0D197631948FBB5C8FB"] = 2;
  var_0.seatids["_encstr_8A49119993F69B8E7D27D23B343ABE272BB039"] = 3;
  var_0.seatids["_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB"] = 4;
  var_0.seatids["_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8"] = 5;
}

spawn_manual_turret() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_91CD07D045CF0B0BB8", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_91CD07D045CF0B0BB8");
  var_0.class = "_encstr_A37E0DDAAC8C4B5D5BAF1B2DD91AA3";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_91CD07D045CF0B0BB8");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_91CD07D045CF0B0BB8", 6);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_91CD07D045CF0B0BB8", ::hoopty_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_8CBA0AD33D120153A1AFA040", 3);
}

hoopty_initfx() {
  level._effect["_encstr_837E0FCC38A8A08B7B7F2F5349A962EC50"] = loadfx("_encstr_8E09340C5EDBD8939BCF2AE8327427EB1FD21B87A467B9D1470332D01A880F037F6088F5104B200F2A8A381861622399C71E88F466D3");
}

hoopty_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_BE8B29E3254A83B77208AC4105E079B1939782FBB89A294BB318E804216B175B891BC0F8E0C84F03A980D1";
  var_0.targetname = "_encstr_91CD07D045CF0B0BB8";
  var_0.vehicletype = "_encstr_8C9A12074B37465A0BF51CD0F26E5AD8E6FA6BE0";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_91CD07D045CF0B0BB8", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_8CBA0AD33D120153A1AFA040");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_91CD07D045CF0B0BB8", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_91CD07D045CF0B0BB8", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

hoopty_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_8CBA0AD33D120153A1AFA040";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread hoopty_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8CBA0AD33D120153A1AFA040");
    playFX(scripts\engine\utility::getfx("_encstr_837E0FCC38A8A08B7B7F2F5349A962EC50"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

hoopty_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_91CD07D045CF0B0BB8", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_91CD07D045CF0B0BB8", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

hoopty_deathcallback(var_0) {
  thread hoopty_explode(var_0);
  return 1;
}

hoopty_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    hoopty_enterendinternal(var_0, var_1, var_2, var_3, var_4);
}

hoopty_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

hoopty_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    hoopty_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

hoopty_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

hoopty_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_91CD07D045CF0B0BB8", 1);
  var_0.maxinstancecount = 30;
  var_0.priority = 50;
  var_0.getspawnstructscallback = ::hoopty_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_91CD07D045CF0B0BB8", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 118;
  var_0.clearancecheckheight = 70;
  var_0.clearancecheckminradius = 118;
}

hoopty_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_AD8D0DA07A28AAC42337DBB8BB6F45", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}