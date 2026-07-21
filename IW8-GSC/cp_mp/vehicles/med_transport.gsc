/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\med_transport.gsc
***********************************************/

med_transport_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", 1);
  var_0.destroycallback = ::med_transport_explode;
  med_transport_initoccupancy();
  med_transport_initinteract();
  _id_11BAA();
  _id_11BA9();
  med_transport_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_88C5055208731B")]]();

  med_transport_initspawning();
  med_transport_initlate();
}

med_transport_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_BAF609D2739647C4853A2B")]]();
}

med_transport_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", 1);
  var_0.enterendcallback = ::med_transport_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::med_transport_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatcabpassengerrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 115;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 115;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 53;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 53;
  var_0.exitextents["_encstr_AC190479FF92"] = 103;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_1 = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets[var_1] = (80, 0, 70);
  var_0.exitdirections[var_1] = "_encstr_AA5606FD1AF05085";
  var_1 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_0.exitoffsets[var_1] = (-85, 22, 89);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_1 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_0.exitoffsets[var_1] = (-85, -22, 89);
  var_0.exitdirections[var_1] = "_encstr_B69B0589C236B6";
  var_2 = [];
  var_2[var_2.size] = "_encstr_9AE307B956E345D0AB";
  var_2[var_2.size] = "_encstr_8A49119993F69B8E7D27D23B343ABE272BB039";
  var_2[var_2.size] = "_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8";
  var_2[var_2.size] = "_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB";
  var_2[var_2.size] = "_encstr_AFB9108753607653A0D197631948FBB5C8FB";
  var_2[var_2.size] = "_encstr_AB0A0B99C9DBB98EAFC69533E8";
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AB0A0B99C9DBB98EAFC69533E8", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (15, -20, 76);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_4.damagemodifier = 0.5;
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.spawnpriority = 10;
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_3 = "_encstr_AB0A0B99C9DBB98EAFC69533E8";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_9AE307B956E345D0AB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (15, 20, 76);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.animtag = "_encstr_A70D0BFBD379B6D25977D3700A";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_AFB9108753607653A0D197631948FBB5C8FB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8A49119993F69B8E7D27D23B343ABE272BB039", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-25, 22, 89);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_8A49119993F69B8E7D27D23B343ABE272BB039";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AFB9108753607653A0D197631948FBB5C8FB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-25, -22, 89);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.animtag = "_encstr_8F0D0BA3C2D9FA6EB216D1D7D4";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_AB0A0B99C9DBB98EAFC69533E8", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-51, 22, 89);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_3 = "_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_9AE307B956E345D0AB", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-51, -22, 89);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.animtag = "_encstr_B80D0BD3FF427EC85F4964AF0A";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
}

med_transport_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", 1);
  var_0.seatenterarrays["_encstr_9AE307B956E345D0AB"] = ["_encstr_9AE307B956E345D0AB"];
  var_0.seatenterarrays["_encstr_AB0A0B99C9DBB98EAFC69533E8"] = ["_encstr_AB0A0B99C9DBB98EAFC69533E8"];
  var_0.seatenterarrays["_encstr_AFB9108753607653A0D197631948FBB5C8FB"] = ["_encstr_AFB9108753607653A0D197631948FBB5C8FB"];
  var_0.seatenterarrays["_encstr_8A49119993F69B8E7D27D23B343ABE272BB039"] = ["_encstr_8A49119993F69B8E7D27D23B343ABE272BB039"];
  var_0.seatenterarrays["_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB"] = ["_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB"];
  var_0.seatenterarrays["_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8"] = ["_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8"];
}

_id_11BAA() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", 1);
  var_0.id = 11;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_AB0A0B99C9DBB98EAFC69533E8"] = 1;
  var_0.seatids["_encstr_AFB9108753607653A0D197631948FBB5C8FB"] = 2;
  var_0.seatids["_encstr_8A49119993F69B8E7D27D23B343ABE272BB039"] = 3;
  var_0.seatids["_encstr_B29D0F114AD7E2A9552D8DD16FBA30BFCB"] = 4;
  var_0.seatids["_encstr_8FEE106A88BBDF394AFB5F800B4F7BFAE0A8"] = 5;
}

_id_11BA9() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", 2000);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301");
  var_0.class = "_encstr_B6F60D728869C44F3820E0E5C7A387";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", 13);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", ::med_transport_deathcallback);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_AF3011DD1D21D7BB459072BB83A7F2B3BEF148", 3);
}

med_transport_initfx() {
  level._effect["_encstr_8CD016ADB2C8AF1D9C2C9B37837B93E8D759E11CB1F68C59"] = loadfx("_encstr_8E09340C5EDBD8939BCF2AE8327427EB1FD21B87A467B9D1470332D01A880F037F6088F5104B200F2A8A381861622399C71E88F466D3");
}

med_transport_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_0.modelname = "_encstr_8B7E20D95634C1D75B4BB1EB36E68CD785DC4B594E3916EBC10DCB6EB48DE6D76B83";
  var_0.targetname = "_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301";
  var_0.vehicletype = "_encstr_93CB134758E8ADEB356709FADB0B337971B047FFD8";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_2))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_2, "_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", var_0);
  var_2.objweapon = getcompleteweaponname("_encstr_AF3011DD1D21D7BB459072BB83A7F2B3BEF148");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_2, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_8AEA073693CA16D12B")]](var_2);

  return var_2;
}

med_transport_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_AF3011DD1D21D7BB459072BB83A7F2B3BEF148";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread med_transport_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AF3011DD1D21D7BB459072BB83A7F2B3BEF148");
    playFX(scripts\engine\utility::getfx("_encstr_8CD016ADB2C8AF1D9C2C9B37837B93E8D759E11CB1F68C59"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

med_transport_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

med_transport_deathcallback(var_0) {
  thread med_transport_explode(var_0);
  return 1;
}

med_transport_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    med_transport_enterendinternal(var_0, var_1, var_2, var_3, var_4);
}

med_transport_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

med_transport_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    med_transport_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

med_transport_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
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

med_transport_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", 1);
  var_0.maxinstancecount = 30;
  var_0.priority = 50;
  var_0.getspawnstructscallback = ::med_transport_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B16011ABE732C3D0ED5103DBC6C628873A1301", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 110;
  var_0.clearancecheckheight = 110;
  var_0.clearancecheckminradius = 110;
}

med_transport_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_969116B695914BD55B8E9C5837DCC1DE4E1DF5E638B0EEDC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}