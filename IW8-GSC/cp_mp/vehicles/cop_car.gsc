/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\cop_car.gsc
***********************************************/

cop_car_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_8FE608B268BFF756987D", 1);
  var_0.destroycallback = ::cop_car_explode;
  cop_car_initoccupancy();
  cop_car_initinteract();
  ignoreattractions();
  ignoreafkcheck();
  cop_car_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FE608B268BFF756987D", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FE608B268BFF756987D", "_encstr_88C5055208731B")]]();

  cop_car_initspawning();
  cop_car_initlate();
}

cop_car_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FE608B268BFF756987D", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FE608B268BFF756987D", "_encstr_BAF609D2739647C4853A2B")]]();
}

cop_car_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_8FE608B268BFF756987D", 1);
  var_0.enterendcallback = ::cop_car_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::cop_car_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatcabpassengerrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 103;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 103;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 40;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 40;
  var_0.exitextents["_encstr_AC190479FF92"] = 60;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (75, 0, 48);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_B69B0589C236B6";
  var_0.exitoffsets[var_1] = (-75, 0, 48);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_BD0703853A", "_encstr_B607038AAB", "_encstr_8307030610"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_8FE608B268BFF756987D", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8307030610", "_encstr_B69B0589C236B6", "_encstr_BD0703853A", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (7, 14, 48);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.damagemodifier = 0.5;
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_BD0703853A";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_8FE608B268BFF756987D", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_B607038AAB", "_encstr_B69B0589C236B6", "_encstr_9AE307B956E345D0AB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (7, -14, 48);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.damagemodifier = 0.5;
  var_4.animtag = "_encstr_A70D0BFBD379B6D25977D3700A";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_8307030610";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_8FE608B268BFF756987D", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_9AE307B956E345D0AB", "_encstr_B69B0589C236B6", "_encstr_B607038AAB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-28, 14, 48);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.damagemodifier = 0.5;
  var_4.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_B607038AAB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_8FE608B268BFF756987D", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_BD0703853A", "_encstr_B69B0589C236B6", "_encstr_8307030610", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-28, -14, 48);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.damagemodifier = 0.5;
  var_4.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
}

cop_car_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_8FE608B268BFF756987D", 1);
  var_0.seatenterarrays["_encstr_9AE307B956E345D0AB"] = ["_encstr_9AE307B956E345D0AB"];
  var_0.seatenterarrays["_encstr_BD0703853A"] = ["_encstr_BD0703853A"];
  var_0.seatenterarrays["_encstr_8307030610"] = ["_encstr_8307030610"];
  var_0.seatenterarrays["_encstr_B607038AAB"] = ["_encstr_B607038AAB"];
}

ignoreattractions() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_8FE608B268BFF756987D", 1);
  var_0.id = 6;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_BD0703853A"] = 1;
  var_0.seatids["_encstr_8307030610"] = 2;
  var_0.seatids["_encstr_B607038AAB"] = 3;
}

ignoreafkcheck() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_8FE608B268BFF756987D", 1000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_8FE608B268BFF756987D");
  var_0.class = "_encstr_A37E0DDAAC8C4B5D5BAF1B2DD91AA3";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_8FE608B268BFF756987D");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_8FE608B268BFF756987D", 6);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_8FE608B268BFF756987D", ::cop_car_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_B2F60B166F934917E1C5C7BA1B", 3);
}

cop_car_initfx() {
  level._effect["_encstr_AB3210770FB318A0A15A2679C09890484A8F"] = loadfx("_encstr_8E09340C5EDBD8939BCF2AE8327427EB1FD21B87A467B9D1470332D01A880F037F6088F5104B200F2A8A381861622399C71E88F466D3");
}

cop_car_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_A5C729C5B9436A1752FF8B4053EE2D77331811E9CF79BEEB12A0871F1AD7CB57275B5AAB38FA1162902DC8";
  var_0.targetname = "_encstr_8FE608B268BFF756987D";
  var_0.vehicletype = "_encstr_AADB18BFB28ADA8F19F2E018E068C716EBA97370704ECB572A33";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_8FE608B268BFF756987D", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_B2F60B166F934917E1C5C7BA1B");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FE608B268BFF756987D", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FE608B268BFF756987D", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

cop_car_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_B2F60B166F934917E1C5C7BA1B";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread cop_car_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_B2F60B166F934917E1C5C7BA1B");
    playFX(scripts\engine\utility::getfx("_encstr_AB3210770FB318A0A15A2679C09890484A8F"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

cop_car_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8FE608B268BFF756987D", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FE608B268BFF756987D", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

cop_car_deathcallback(var_0) {
  thread cop_car_explode(var_0);
  return 1;
}

cop_car_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    cop_car_enterendinternal(var_0, var_1, var_2, var_3, var_4);
}

cop_car_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

cop_car_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    cop_car_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

cop_car_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

cop_car_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_8FE608B268BFF756987D", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::cop_car_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8FE608B268BFF756987D", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 100;
  var_0.clearancecheckheight = 60;
  var_0.clearancecheckminradius = 100;
}

cop_car_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_B26E0D5E6883E36A4ECFA7A39BF4A2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}