/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58239.gsc
***********************************************/

_id_120D2() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", 1);
  var_0.destroycallback = ::_id_120CB;
  _id_120D8();
  _id_120D6();
  _id_120D9();
  _id_120D4();
  _id_120D3();
  _id_120D5();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_88C5055208731B")]]();

  _id_120DA();
  _id_120D7();
}

_id_120D7() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_BAF609D2739647C4853A2B")]]();
}

_id_120D8() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", 1);
  var_0.enterstartcallback = ::_id_120C8;
  var_0.enterendcallback = ::_id_120C6;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::_id_120C9;
  var_0.reentercallback = ::_id_120E7;
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
  var_2 = ["_encstr_9AE307B956E345D0AB", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3"];
  var_3 = "_encstr_9AE307B956E345D0AB";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_B69B0589C236B6", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (17, 19, 65);
  var_0.exitdirections[var_3] = "_encstr_A5AD056A019C63";
  var_4.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_4.spawnpriority = 4;
  var_3 = "_encstr_8FEE0C6E10B7CB6067CD678F0CE3";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_B69B0589C236B6", "_encstr_9AE307B956E345D0AB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (17, -19, 65);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
  var_4._id_13E8A = getcompleteweaponname("_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0");
  var_4._id_13E92 = "_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0";
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_4.spawnpriority = 3;
  var_3 = "_encstr_974E0A4CB0D85BAFD895998E";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_B69B0589C236B6", "_encstr_BE360B4C0B36B5FA4E5AB386A3", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-24, -19, 65);
  var_0.exitdirections[var_3] = "_encstr_8253060E2B5FE330";
  var_4.viewclamps["_encstr_AC190479FF92"] = 45;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 25;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 120;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 120;
  var_4.animtag = "_encstr_A70D0BFBD379B6D25977D3700A";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.hidestowedweapon = 1;
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_4.spawnpriority = 2;
  var_3 = "_encstr_BE360B4C0B36B5FA4E5AB386A3";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", var_3, 1);
  var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_3, var_2);
  var_4.exitids = [var_3, "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_B69B0589C236B6", "_encstr_9AE307B956E345D0AB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_3] = (-40, 0, 65);
  var_0.exitdirections[var_3] = "_encstr_B69B0589C236B6";
  var_4.viewclamps["_encstr_AC190479FF92"] = 45;
  var_4.viewclamps["_encstr_A146078E65FB5158DD"] = 25;
  var_4.viewclamps["_encstr_A5AD056A019C63"] = 120;
  var_4.viewclamps["_encstr_8253060E2B5FE330"] = 120;
  var_4.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_4.animtag);
  var_4.hidestowedweapon = 1;
  var_4._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_4.spawnpriority = 1;
}

_id_120D6() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_8FEE0C6E10B7CB6067CD678F0CE3", "_encstr_974E0A4CB0D85BAFD895998E", "_encstr_BE360B4C0B36B5FA4E5AB386A3"]);
}

_id_120D9() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", 1);
  var_0.id = 25;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_8FEE0C6E10B7CB6067CD678F0CE3"] = 1;
  var_0.seatids["_encstr_974E0A4CB0D85BAFD895998E"] = 2;
  var_0.seatids["_encstr_BE360B4C0B36B5FA4E5AB386A3"] = 3;
  var_0._id_12DA2[0] = 0;
  var_0._id_12DA2[1] = 1;
  var_0._id_12DA3["_encstr_9AE307B956E345D0AB"]["_encstr_9BC214E7BF293BA9AD583A63A1971EF323A8735F59D3"] = 0;
  var_0._id_12DA3["_encstr_9AE307B956E345D0AB"]["_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0"] = 1;
  var_0._id_12DA3["_encstr_8FEE0C6E10B7CB6067CD678F0CE3"]["_encstr_9BC214E7BF293BA9AD583A63A1971EF323A8735F59D3"] = 0;
  var_0._id_12DA3["_encstr_8FEE0C6E10B7CB6067CD678F0CE3"]["_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0"] = 1;
  var_0._id_12DA3["_encstr_974E0A4CB0D85BAFD895998E"]["_encstr_9BC214E7BF293BA9AD583A63A1971EF323A8735F59D3"] = 0;
  var_0._id_12DA3["_encstr_974E0A4CB0D85BAFD895998E"]["_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0"] = 1;
  var_0._id_12DA3["_encstr_BE360B4C0B36B5FA4E5AB386A3"]["_encstr_9BC214E7BF293BA9AD583A63A1971EF323A8735F59D3"] = 0;
  var_0._id_12DA3["_encstr_BE360B4C0B36B5FA4E5AB386A3"]["_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0"] = 1;
}

_id_120D4() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", 2750);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3");
  var_0.class = "_encstr_B6F60D728869C44F3820E0E5C7A387";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", 9);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14176("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", ::_id_120E4);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14175("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", ::_id_120E3);
  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", ::_id_120C4);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1417B("_encstr_9BC214E7BF293BA9AD583A63A1971EF323A8735F59D3", 5);
}

_id_120D3() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", 1);
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

  if(getdvarint("_encstr_BE120A82720A982AA2459C93", 0))
    var_0.setup_techo_lmgs = ::_id_120F1;
}

_id_120D5() {
  level._effect["_encstr_8383190DDBF8BE39F20B2F73172E82FAF880869991E868C2581157"] = loadfx("_encstr_87762DD9CCF0E52DEEC17D5BC1979DB21A5AB1D82B97CE66C37D53ACB2E0EBB6E0D7322BB04743F5AC3C1C7167CC1E");

  if(getdvarint("_encstr_BE120A82720A982AA2459C93", 0))
    level._effect["_encstr_A2C02065870B229780F84F231199612BF990EE916EABAAFD88C84F9798135973A736"] = loadfx("_encstr_B81E30EC9987CBA5EE1CBE6B1C79EC2B862D1BB1CA79B3CCC3D74739B75BCAEDD7DA1CAF8C5BECFA37C12C39B6371767663C");
}

_id_120C2(var_0) {
  var_1 = "_encstr_83A017E3F39CD94F88D08D574B0184B3EE2D2F7BFD28530FE8";
  var_2 = (0, 0, 0);
  var_3 = spawnturret("_encstr_97710C6B2DCD1BAF3AD54E4E598E", var_0 gettagorigin(var_1), "_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0", 0);
  var_3 linkTo(var_0, var_1, var_2, (0, 0, 0));
  var_3 setModel("_encstr_8D58212BFFA3C153B93EE903E18F4EDABD5A1F180DBF5B1B6BE7537B43231804CF7BC5");
  var_3 setmode("_encstr_84FD0F03BB736BB3C36E7AF251911725E0");
  var_3 setsentryowner(undefined);
  var_3 makeunusable();
  var_3 setdefaultdroppitch(0);
  var_3 setturretmodechangewait(1);
  var_3.angles = var_0.angles;
  var_3.vehicle = var_0;
  scripts\cp_mp\vehicles\vehicle::_id_14207(var_0, var_3, getcompleteweaponname("_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0"));
}

_id_120C1(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_2 = getdvarint("_encstr_A5DA2A37D89CF5DB83B2B9FAA959AC0EAF1BB0C9E0F68DF5EA9BACFAB0D8E8D7CE56864B6C1BACBE8EE5C1AC", 0);
  var_0.modelname = "_encstr_812E1A0397B8296E9F9F33234BF136105CAA69393F271025D3B70F0D";
  var_0.targetname = "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3";
  var_0.vehicletype = "_encstr_824A1C7F210D5AE7E001FF827E08E8E3DE8BC7F797A6128258287641D0E0";

  if(var_2 == 1) {} else if(var_2 == 2) {}

  var_3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_3))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_3, "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", var_0);
  _id_120C2(var_3);
  var_3.objweapon = getcompleteweaponname("_encstr_9BC214E7BF293BA9AD583A63A1971EF323A8735F59D3");
  var_4 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414C(var_3, 1);
  var_4.wind_trigger_toggle = "_encstr_B45D180285997DCFDC783B71432503F4A011BDB7310B45B7F4F1";
  var_4._id_11BAE = "_encstr_B2C219C01B8F600382E40D1971FB5B8811E73860474C39DBFA0F0D";
  _calloutmarkerping_predicted_timeout::_id_1412B(var_3);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_3, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_3, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_8AEA073693CA16D12B")]](var_3);

  return var_3;
}

_id_120CB(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_9BC214E7BF293BA9AD583A63A1971EF323A8735F59D3";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread _id_120C5();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_9BC214E7BF293BA9AD583A63A1971EF323A8735F59D3");
    playFX(scripts\engine\utility::getfx("_encstr_8383190DDBF8BE39F20B2F73172E82FAF880869991E868C2581157"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

_id_120C5() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

_id_120E4(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isselfdamage(self, var_0))
    return 0;

  return 1;
}

_id_120E3(var_0) {
  if(isDefined(var_0.damage) && var_0.damage > 0)
    self notify("_encstr_B2310D943398AE674DEE4B0270958B", var_0);

  return 1;
}

_id_120C4(var_0) {
  thread _id_120CB(var_0);
  return 1;
}

_id_120C8(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_8FEE0C6E10B7CB6067CD678F0CE3")
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(var_3, "_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0", var_4, 1);
}

_id_120C6(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    thread _id_120C7(var_0, var_1, var_2, var_3, var_4);
  else if(!istrue(var_4.playerdisconnect) && !istrue(var_4.playerdeath)) {
    if(var_1 == "_encstr_8FEE0C6E10B7CB6067CD678F0CE3")
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0", var_4, 1);
  }
}

_id_120C7(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
    var_5 = var_0 _meth_87E6();

    if(var_5) {
      var_3 setclientomnvar("_encstr_A602116058C6B31D23A15293106BBFAB131051", 1);
      thread _encstr_A1FE257B832BCDAFA9B295387D1B2C931CB71BD7D6F6DCA5A3DE93EB3707565691FA4CF6B79B8E(var_0, var_3, var_1, var_4);
      thread _encstr_8AFB2D487097C8B7944230A0D9EE83039B07C628EB6B111BFF091350B282917E3FBC5DBF5E877B27E51278781B5D55(var_0, var_3);
    }
  } else if(var_1 == "_encstr_8FEE0C6E10B7CB6067CD678F0CE3") {
    var_6 = 2350;
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(var_3, var_6);
    var_7 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0");
    var_7.owner = var_3;
    var_7 setotherent(var_3);
    var_7 setentityowner(var_3);
    var_7 setsentryowner(var_3);
    var_3 disableturretdismount();
    var_3 controlturreton(var_7);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

_id_120C9(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    _id_120CA(var_0, var_1, var_2, var_3, var_4);
}

_id_120CA(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 notify("_encstr_8BE11DCF4B8980CF9AE54BD3579AC6ED8215738F851BC383299B91C1D1BAA3");
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4.playerdisconnect))
      var_3 controlsunlink();
  } else if(var_1 == "_encstr_8FEE0C6E10B7CB6067CD678F0CE3") {
    var_0 notify("_encstr_ACB11DDFAB97DB81C212C15848932E282AAFA117575D4A78D5EEE6B7E1D43C");
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, "_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0");
    var_5.owner = undefined;

    if(!istrue(var_4.playerdisconnect)) {
      var_3 enableturretdismount();
      var_3 controlturretoff(var_5);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(var_3, var_4.playerdeath);

      if(!istrue(var_4.playerdeath))
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0", var_4, 1);
    }

    var_5 setotherent(undefined);
    var_5 setentityowner(undefined);
    var_5 setsentryowner(undefined);
  }

  if(!istrue(var_4.playerdisconnect)) {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
    var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(var_3, var_2, var_4);

    if(!var_6) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840")]](var_3);
      else
        var_3 suicide();
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(var_0, var_1, var_2, var_3);
}

_id_120E7(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "_encstr_8FEE0C6E10B7CB6067CD678F0CE3")
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(var_3, var_0, "_encstr_8FE517C32BBEF7573845FFCB7328DA6F6E062A0BF617C78AF0", var_4, 1);
}

_id_120DA() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::_id_120CF;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784"))
    var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_91F511673FA9BB292DD8BAE321179E73A328F3", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");

  var_0.clearancecheckradius = 105;
  var_0.clearancecheckheight = 90;
  var_0.clearancecheckminradius = 105;
}

_id_120CF() {
  if(isDefined(level._id_1218B))
    var_0 = level._id_1218B;
  else
    var_0 = scripts\engine\utility::getStructArray("_encstr_A6B217B718E7C538388BFD0B079F188E495DF68F9BE056D4BA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}

activate_timed_laser_traps() {}

_id_120EE(var_0, var_1) {
  if(!getdvarint("_encstr_935F299BD827D7ED1C2B37EB4D5995E07DB1B0931CDB1BBEEA38C80BD1B2FA570ED99C168CACBE47B2856B", 1)) {
    return;
  }
  var_2 = _id_120E2(var_0);
  var_3 = _id_120CD(var_0, var_2, var_1);

  if(var_3 == "_encstr_A7A408B9CA5D1D4E2C63") {
    return;
  }
  if(!isDefined(var_0._id_13DF6))
    var_0._id_13DF6 = var_3;

  if(var_0._id_13DF6 == var_3) {
    return;
  }
  var_0._id_13DF6 = var_3;
  var_4 = _id_120E5(var_0, var_1);
  var_0 _id_120E6(var_0, var_4);
}

_id_120E2(var_0) {
  var_1 = var_0.occupants["_encstr_9AE307B956E345D0AB"];

  if(isDefined(var_1))
    return var_1.team;

  var_2 = var_0.occupants["_encstr_8FEE0C6E10B7CB6067CD678F0CE3"];

  if(isDefined(var_2))
    return var_2.team;

  return "_encstr_A7A408B9CA5D1D4E2C63";
}

_id_120CD(var_0, var_1, var_2) {
  if(var_1 != "_encstr_A7A408B9CA5D1D4E2C63")
    return var_1;

  if(isDefined(var_2))
    return var_2.team;

  return var_0.team;
}

_id_120E5(var_0, var_1) {
  if(isDefined(var_1))
    return var_1;

  var_2 = var_0.occupants["_encstr_9AE307B956E345D0AB"];

  if(isDefined(var_2))
    return var_2;

  var_3 = var_0.occupants["_encstr_8FEE0C6E10B7CB6067CD678F0CE3"];

  if(isDefined(var_3))
    return var_3;

  return undefined;
}

_id_120E6(var_0, var_1) {
  if(isDefined(var_0.radar))
    var_0.radar delete();
  else if(istrue(var_0._id_129C5))
    var_0 _meth_87AC();

  if(istrue(var_0._id_129C5))
    _id_120E9(var_0, var_1);
}

_id_120E8(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.radar endon("_encstr_AD75063D571AE108");
  var_2 = var_1.team;
  var_1 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_85881311AA2BD460B48D3D11BC9839992703293B53")]](var_2, 0);
  var_4 = undefined;

  if(isDefined(var_3) && var_3.size > 0)
    var_4 = var_3[0];

  level thread _id_120E6(var_0, var_4);
}

_id_120E9(var_0, var_1) {
  var_2 = getdvarint("_encstr_B47C163A766D59E3922F4048CFFD705F0DA0EBC86DAB9FB5", 0);

  if(var_2 == 0)
    var_0 _meth_87AB();
  else if(isDefined(var_1)) {
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
    var_3 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 linkTo(var_0);
    var_3 makeportableradar(var_1);
    var_0.radar = var_3;
    level thread _id_120E8(var_0, var_1);
  }
}

_id_120F1(var_0, var_1) {
  var_2 = var_0.position[0];
  var_3 = var_0.ent[0];
  var_4 = var_0.velocity[0];

  if(isDefined(var_2) && var_3 _meth_87DC()) {
    var_5 = var_4 * 0.05;
    var_6 = var_2 + var_5;
    playFX(scripts\engine\utility::getfx("_encstr_A2C02065870B229780F84F231199612BF990EE916EABAAFD88C84F9798135973A736"), var_6, anglesToForward(var_3.angles), anglestoup(var_3.angles));
  }
}

_encstr_A1FE257B832BCDAFA9B295387D1B2C931CB71BD7D6F6DCA5A3DE93EB3707565691FA4CF6B79B8E(var_0, var_1, var_2, var_3) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8BE11DCF4B8980CF9AE54BD3579AC6ED8215738F851BC383299B91C1D1BAA3");
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_AD75063D571AE108");
  var_4 = 0;

  if(var_2 == "_encstr_9AE307B956E345D0AB") {
    for(;;) {
      var_5 = max(0, var_0 _meth_87DF());
      var_1 setclientomnvar("_encstr_ABFD148BF829A69AF37F6B17732D61F850238617F088", int(var_5));
      var_6 = var_0 _meth_87E7();
      var_1 setclientomnvar("_encstr_BA44220807FFD17D6113354BA15B81F92DABD108B7978B3949FCB8D886B2F780946F08E0", var_6);
      var_7 = var_0 _meth_87E0();

      if(var_7) {
        if(!var_4) {
          var_0 setscriptablepartstate("_encstr_B6560BF8A305F1917095F0862B", "_encstr_AB0703DBB9");
          _encstr_8CC4247B3859DCD74D2B591CD7D8852738ED8D7D8685CD461BACEB9B7BAE3732EB9B8E5839D1(var_0);
          var_1 setclientomnvar("_encstr_A97717236F39FDF8B9C78BC0ED6578A6724F9FBDF753B190C9", 0);
        }
      } else if(var_4) {
        var_0 setscriptablepartstate("_encstr_B6560BF8A305F1917095F0862B", "_encstr_BA19049F4B2D");
        _encstr_83312358F2BA350E8A4FF848BFDB8145935DC6C84C52ED916467215817E5B891C9C2C568A2(var_0);
        var_1 setclientomnvar("_encstr_A97717236F39FDF8B9C78BC0ED6578A6724F9FBDF753B190C9", 2);
      }

      var_4 = var_7;
      waitframe();
    }
  }
}

_encstr_8AFB2D487097C8B7944230A0D9EE83039B07C628EB6B111BFF091350B282917E3FBC5DBF5E877B27E51278781B5D55(var_0, var_1) {
  scripts\engine\utility::waittill_any_ents(var_0, "_encstr_AD75063D571AE108", var_0, "_encstr_8BE11DCF4B8980CF9AE54BD3579AC6ED8215738F851BC383299B91C1D1BAA3", var_1, "_encstr_8D820B49520F0EC02DDE6367EC", var_1, "_encstr_AD75063D571AE108");
  _encstr_B1BC29D5E36A5A07E28218532FEEA05EBA801EF7B74B5D7911583197252E6350682621F1204DAFD1C03581(var_0, var_1);
  var_0 stoploopsound();
  var_1 setclientomnvar("_encstr_A602116058C6B31D23A15293106BBFAB131051", 0);
}

_encstr_B1BC29D5E36A5A07E28218532FEEA05EBA801EF7B74B5D7911583197252E6350682621F1204DAFD1C03581(var_0, var_1) {
  var_0 setscriptablepartstate("_encstr_B6560BF8A305F1917095F0862B", "_encstr_BA19049F4B2D");
  var_1 setclientomnvar("_encstr_A97717236F39FDF8B9C78BC0ED6578A6724F9FBDF753B190C9", 2);
}

_encstr_8CC4247B3859DCD74D2B591CD7D8852738ED8D7D8685CD461BACEB9B7BAE3732EB9B8E5839D1(var_0) {
  var_0 playsoundonmovingent("_encstr_93F1167C2DEBA6970E7BE01042A955B873C2086093234BF1");
  var_0 playLoopSound("_encstr_829C144BDFE0713E825341773F49F098947210E60540");
}

_encstr_83312358F2BA350E8A4FF848BFDB8145935DC6C84C52ED916467215817E5B891C9C2C568A2(var_0) {
  var_0 playsoundonmovingent("_encstr_867315AE1398096F57A3F30A69A0A37C90A53F3FBBF08F");
  var_0 stoploopsound();
}