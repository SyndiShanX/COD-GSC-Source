/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\pickup_truck.gsc
***********************************************/

pickup_truck_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_8FD60D6AA0EAB34083F7C423A0213B", 1);
  var_0.destroycallback = ::pickup_truck_explode;
  pickup_truck_initoccupancy();
  pickup_truck_initinteract();
  _id_12354();
  _id_12353();
  pickup_truck_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_88C5055208731B")]]();

  pickup_truck_initspawning();
  pickup_truck_initlate();
}

pickup_truck_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_BAF609D2739647C4853A2B")]]();
}

pickup_truck_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_8FD60D6AA0EAB34083F7C423A0213B", 1);
  var_0.enterendcallback = ::pickup_truck_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::pickup_truck_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 120;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 120;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 45;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 45;
  var_0.exitextents["_encstr_AC190479FF92"] = 90;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (90, 20, 72);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_8FEE0C6E10B7CB6067CD678F0CE3";
  var_0.exitoffsets[var_1] = (24, -20, 75);
  var_0.exitdirections[var_1] = "_encstr_8253060E2B5FE330";
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-90, 27, 75);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_0.exitoffsets[var_1] = (-90, 27, 75);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = [];
  var_2[var_2.size] = "_encstr_9AE307B956E345D0AB";
  var_2[var_2.size] = "_encstr_A23B08C66A011541892B";
  var_2[var_2.size] = "_encstr_8B520826D8F527CAB027";
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_8FD60D6AA0EAB34083F7C423A0213B", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8B520826D8F527CAB027", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (24, 20, 75);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.damagemodifier = 0.5;
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_8B520826D8F527CAB027";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_8FD60D6AA0EAB34083F7C423A0213B", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_9AE307B956E345D0AB", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_A23B08C66A011541892B", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-66, 27, 75);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_A23B08C66A011541892B";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_8FD60D6AA0EAB34083F7C423A0213B", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_8B520826D8F527CAB027", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-66, -27, 75);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.animtag = "_encstr_8F0D0BA3C2D9FA6EB216D1D7D4";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
}

pickup_truck_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_8FD60D6AA0EAB34083F7C423A0213B", 1);
  var_0.seatenterarrays["_encstr_9AE307B956E345D0AB"] = ["_encstr_9AE307B956E345D0AB"];
  var_0.seatenterarrays["_encstr_8B520826D8F527CAB027"] = ["_encstr_8B520826D8F527CAB027"];
  var_0.seatenterarrays["_encstr_A23B08C66A011541892B"] = ["_encstr_A23B08C66A011541892B"];
}

_id_12354() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_8FD60D6AA0EAB34083F7C423A0213B", 1);
  var_0.id = 7;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_BD0703853A"] = 1;
  var_0.seatids["_encstr_AD5308C815EFE2D77388"] = 2;
  var_0.seatids["_encstr_B4D6083327EB39B2C24E"] = 3;
  var_0.seatids["_encstr_8B520826D8F527CAB027"] = 4;
  var_0.seatids["_encstr_A23B08C66A011541892B"] = 5;
}

_id_12353() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_8FD60D6AA0EAB34083F7C423A0213B", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_8FD60D6AA0EAB34083F7C423A0213B");
  var_0.class = "_encstr_AB5E07609A5B7368E5";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_8FD60D6AA0EAB34083F7C423A0213B");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_8FD60D6AA0EAB34083F7C423A0213B", 6);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_8FD60D6AA0EAB34083F7C423A0213B", ::pickup_truck_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_8A6C1038D236D6D5E0EBA393ABD8DABEAD0E", 3);
}

pickup_truck_initfx() {
  level._effect["_encstr_AB1E1583938E8A4DB0C63B82BB106B0155290B0B77A5D2"] = loadfx("_encstr_A6222F5BB08AA71A7F8B49FD97E7A3B5D0A077BB30C8363299D08AF47637AB68DE38B3EF9079995B91C8D7A8E755530682");
}

pickup_truck_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_9B311E9C7530D17822E7CB76300EBDF6B18049C31F29A329A38EB4120681A382";
  var_0.targetname = "_encstr_8FD60D6AA0EAB34083F7C423A0213B";
  var_0.vehicletype = "_encstr_99931135573AD9E85F3BB0202FB1A12741FDAF";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_8FD60D6AA0EAB34083F7C423A0213B", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_8A6C1038D236D6D5E0EBA393ABD8DABEAD0E");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

pickup_truck_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_8A6C1038D236D6D5E0EBA393ABD8DABEAD0E";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread pickup_truck_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8A6C1038D236D6D5E0EBA393ABD8DABEAD0E");
    playFX(scripts\engine\utility::getfx("_encstr_AB1E1583938E8A4DB0C63B82BB106B0155290B0B77A5D2"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

pickup_truck_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

pickup_truck_deathcallback(var_0) {
  thread pickup_truck_explode(var_0);
  return 1;
}

pickup_truck_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    pickup_truck_enterendinternal(var_0, var_1, var_2, var_3, var_4);
}

pickup_truck_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

pickup_truck_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    pickup_truck_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

pickup_truck_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

pickup_truck_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_8FD60D6AA0EAB34083F7C423A0213B", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::pickup_truck_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FD60D6AA0EAB34083F7C423A0213B", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 120;
  var_0.clearancecheckheight = 90;
  var_0.clearancecheckminradius = 120;
}

pickup_truck_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_8BBC121759BF58D32203D8F86ABCCF134BF91C80", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}