/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\tac_rover.gsc
***********************************************/

tac_rover_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("_encstr_9A120A1D8536F5E4ED3BB293", 1);
  var_0.destroycallback = ::tac_rover_explode;
  tac_rover_initoccupancy();
  tac_rover_initinteract();
  _id_139FB();
  _id_139FA();
  _id_139F9();
  tac_rover_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_88C5055208731B")]]();

  tac_rover_initspawning();
  tac_rover_initlate();
}

tac_rover_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_BAF609D2739647C4853A2B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_BAF609D2739647C4853A2B")]]();
}

tac_rover_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle("_encstr_9A120A1D8536F5E4ED3BB293", 1);
  var_0.enterendcallback = ::tac_rover_enterend;
  var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
  var_0.exitendcallback = ::tac_rover_exitend;
  var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
  var_0.exitextents["_encstr_AA5606FD1AF05085"] = 85;
  var_0.exitextents["_encstr_B69B0589C236B6"] = 82;
  var_0.exitextents["_encstr_A5AD056A019C63"] = 34;
  var_0.exitextents["_encstr_8253060E2B5FE330"] = 34;
  var_0.exitextents["_encstr_AC190479FF92"] = 82;
  var_0.exitextents["_encstr_A146078E65FB5158DD"] = 0;
  var_0.exitoffsets["_encstr_AA5606FD1AF05085"] = (58, 0, 55);
  var_0.exitdirections["_encstr_AA5606FD1AF05085"] = "_encstr_AA5606FD1AF05085";
  var_0.exitoffsets["_encstr_B69B0589C236B6"] = (-65, 0, 65);
  var_0.exitdirections["_encstr_B69B0589C236B6"] = "_encstr_B69B0589C236B6";
  var_1 = [];
  var_1[var_1.size] = "_encstr_9AE307B956E345D0AB";
  var_1[var_1.size] = "_encstr_835A0D59CAAF7B8BF313C773121DAE";
  var_1[var_1.size] = "_encstr_AAC30DBEE0FE0A5FFB6B5D0D19FFAA";
  var_1[var_1.size] = "_encstr_95AD0D981B7DE02C9B37CAB9EC2B4E";
  var_2 = "_encstr_9AE307B956E345D0AB";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_9A120A1D8536F5E4ED3BB293", var_2, 1);
  var_3.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_2, var_1);
  var_3.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
  var_3.animtag = "_encstr_A10D0BA3B27F17C327D98568E0";
  var_3.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_3.animtag);
  var_3.exitids = [var_2, "_encstr_95AD0D981B7DE02C9B37CAB9EC2B4E", "_encstr_B69B0589C236B6", "_encstr_835A0D59CAAF7B8BF313C773121DAE", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_2] = (10, 13, 48);
  var_0.exitdirections[var_2] = "_encstr_A5AD056A019C63";
  var_3.spawnpriority = 10;
  var_3._id_12023 = "_encstr_88F11407A573CEBED9B2A196D863ACD7329C5AB3CAC9";
  var_2 = "_encstr_835A0D59CAAF7B8BF313C773121DAE";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_9A120A1D8536F5E4ED3BB293", var_2, 1);
  var_3.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_2, var_1);
  var_3.exitids = [var_2, "_encstr_AAC30DBEE0FE0A5FFB6B5D0D19FFAA", "_encstr_B69B0589C236B6", "_encstr_9AE307B956E345D0AB", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_2] = (10, -13, 48);
  var_0.exitdirections[var_2] = "_encstr_8253060E2B5FE330";
  var_3.viewclamps["_encstr_AC190479FF92"] = 27;
  var_3.viewclamps["_encstr_A146078E65FB5158DD"] = 42;
  var_3.viewclamps["_encstr_A5AD056A019C63"] = 105;
  var_3.viewclamps["_encstr_8253060E2B5FE330"] = 111;
  var_3.animtag = "_encstr_A70D0BFBD379B6D25977D3700A";
  var_3.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_3.animtag);
  var_3.hidestowedweapon = 1;
  var_3._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_2 = "_encstr_95AD0D981B7DE02C9B37CAB9EC2B4E";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_9A120A1D8536F5E4ED3BB293", var_2, 1);
  var_3.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_2, var_1);
  var_3.exitids = [var_2, "_encstr_9AE307B956E345D0AB", "_encstr_B69B0589C236B6", "_encstr_AAC30DBEE0FE0A5FFB6B5D0D19FFAA", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_2] = (-25, 13, 55);
  var_0.exitdirections[var_2] = "_encstr_A5AD056A019C63";
  var_3.viewclamps["_encstr_AC190479FF92"] = 27;
  var_3.viewclamps["_encstr_A146078E65FB5158DD"] = 42;
  var_3.viewclamps["_encstr_A5AD056A019C63"] = 122;
  var_3.viewclamps["_encstr_8253060E2B5FE330"] = 101;
  var_3.animtag = "_encstr_A30D0B30D3708180E951D37165";
  var_3.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_3.animtag);
  var_3.hidestowedweapon = 1;
  var_3._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
  var_2 = "_encstr_AAC30DBEE0FE0A5FFB6B5D0D19FFAA";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat("_encstr_9A120A1D8536F5E4ED3BB293", var_2, 1);
  var_3.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray(var_2, var_1);
  var_3.exitids = [var_2, "_encstr_835A0D59CAAF7B8BF313C773121DAE", "_encstr_B69B0589C236B6", "_encstr_95AD0D981B7DE02C9B37CAB9EC2B4E", "_encstr_AA5606FD1AF05085"];
  var_0.exitoffsets[var_2] = (-25, -13, 55);
  var_0.exitdirections[var_2] = "_encstr_8253060E2B5FE330";
  var_3.viewclamps["_encstr_AC190479FF92"] = 27;
  var_3.viewclamps["_encstr_A146078E65FB5158DD"] = 42;
  var_3.viewclamps["_encstr_A5AD056A019C63"] = 101;
  var_3.viewclamps["_encstr_8253060E2B5FE330"] = 122;
  var_3.animtag = "_encstr_930D0BB31F7F41CB11C81BAF42";
  var_3.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag(var_3.animtag);
  var_3.hidestowedweapon = 1;
  var_3._id_12023 = "_encstr_834E13FFF2BA6F07A61782F2DF905F591B4B716A3B";
}

tac_rover_initinteract() {
  var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("_encstr_9A120A1D8536F5E4ED3BB293", 1);
  scripts\cp_mp\vehicles\vehicle_interact::_id_1419D("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_BDDC07EBCCB5CA4BED", ["_encstr_9AE307B956E345D0AB", "_encstr_835A0D59CAAF7B8BF313C773121DAE", "_encstr_95AD0D981B7DE02C9B37CAB9EC2B4E", "_encstr_AAC30DBEE0FE0A5FFB6B5D0D19FFAA"]);
}

_id_139FB() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E("_encstr_9A120A1D8536F5E4ED3BB293", 1);
  var_0.id = 3;
  var_0.seatids["_encstr_9AE307B956E345D0AB"] = 0;
  var_0.seatids["_encstr_835A0D59CAAF7B8BF313C773121DAE"] = 1;
  var_0.seatids["_encstr_95AD0D981B7DE02C9B37CAB9EC2B4E"] = 2;
  var_0.seatids["_encstr_AAC30DBEE0FE0A5FFB6B5D0D19FFAA"] = 3;
}

_id_139FA() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_1416C("_encstr_9A120A1D8536F5E4ED3BB293", 750);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle("_encstr_9A120A1D8536F5E4ED3BB293");
  var_0.class = "_encstr_8FA906CC80677438";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1413D("_encstr_9A120A1D8536F5E4ED3BB293");
  scripts\cp_mp\vehicles\vehicle_damage::_id_14178("_encstr_9A120A1D8536F5E4ED3BB293", 5);

  if(level.gametype == "_encstr_B607038AAB")
    scripts\cp_mp\vehicles\vehicle_damage::_id_14179("_encstr_9A120A1D8536F5E4ED3BB293", 8, "_encstr_A10B13BB213943CF581FC9D16140D45F7FB3F1C22B");

  scripts\cp_mp\vehicles\vehicle_damage::_id_14171("_encstr_9A120A1D8536F5E4ED3BB293", ::tac_rover_deathcallback);
}

_id_139F9() {
  var_0 = _calloutmarkerping_predicted_log::_id_1410F("_encstr_9A120A1D8536F5E4ED3BB293", 1);
  var_0.challengeevaluator = 1.83333;
  var_0.keycardlocs_chosen = 0.79166;
  var_0.is_using_stealth_debug = 350;
  var_0.is_valid_station_name = 525;
  var_0.is_two_hit_melee_weapon = 875;
  var_0.isakimbomeleeweapon = 6.25;
  var_0.isallowedweapon = 25;
  var_0.isakimbo = 50;
  var_0.isattachmentgrenadelauncher = 0;
  var_0.isattachmentselectfire = 0;
  var_0.isassaulting = 0;
}

tac_rover_initfx() {
  level._effect["_encstr_952C1265066AE71B3F9368A84F4D12F1C22DD565"] = loadfx("_encstr_BE902F0BA153CE2CC0F1D7FD79DA332FF3F8D232A980F3A790D7F4EA6FA0BFBFB0905B89110D671B68EF1DD8298283D34B");
}

tac_rover_create(var_0, var_1) {
  if(!isDefined(var_0.angles))
    var_0.angles = (0, 0, 0);

  var_2 = scripts\cp_mp\utility\script_utility::_id_140DE("_encstr_B472054FE12550", "_encstr_979A0DD15F81E677754743DB49CEB3", 0);

  if(var_2)
    var_0.modelname = "_encstr_B4321BCB8079A8DF3023FCD749B8FB89B9D0C2F238DF3967CB95C7ED5F";
  else
    var_0.modelname = "_encstr_91961F058DFC22706F42402E7A0B956193F2AFBB35E5D12FA37BBB909247C0382A";

  var_0.targetname = "_encstr_9A120A1D8536F5E4ED3BB293";
  var_0.vehicletype = "_encstr_B849127B4D1072C5E07E929C52E8016AF6FF87E3";
  var_3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(var_0, var_1);

  if(!isDefined(var_3))
    return undefined;

  scripts\cp_mp\vehicles\vehicle::_id_14138(var_3, "_encstr_9A120A1D8536F5E4ED3BB293", var_0);
  var_3.objweapon = getcompleteweaponname("_encstr_A7AA0DE816C6D727DBCEB2C9EBB61C");
  _calloutmarkerping_predicted_timeout::_id_1412B(var_3);
  scripts\cp_mp\vehicles\vehicle::_id_14139(var_3, var_0);
  thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped(var_3, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_8AEA073693CA16D12B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_8AEA073693CA16D12B")]](var_3);

  return var_3;
}

tac_rover_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "_encstr_A7AA0DE816C6D727DBCEB2C9EBB61C";
    var_0.meansofdeath = "_encstr_B45C0E2DFF41B17F437FB870E733FBFF";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_14162(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals(undefined, undefined, 1);
  thread tac_rover_deletenextframe();

  if(!istrue(level.suppressvehicleexplosion)) {
    var_2 = self gettagorigin("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_A7AA0DE816C6D727DBCEB2C9EBB61C");
    playFX(scripts\engine\utility::getfx("_encstr_952C1265066AE71B3F9368A84F4D12F1C22DD565"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    playsoundatpos(var_2, "_encstr_BA570CB1859CEB2B0F1CB1F646B2");
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

tac_rover_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_14185(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_A25F0710622DF3B3D7"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_A25F0710622DF3B3D7")]](self);

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_14186(self);
}

tac_rover_deathcallback(var_0) {
  thread tac_rover_explode(var_0);
  return 1;
}

tac_rover_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    tac_rover_enterendinternal(var_0, var_1, var_2, var_3, var_4);
}

tac_rover_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 controlslinkTo(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer(var_0, var_1, var_2);
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(var_0, var_2, var_1, var_3);
}

tac_rover_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success))
    tac_rover_exitendinternal(var_0, var_1, var_2, var_3, var_4);
}

tac_rover_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "_encstr_9AE307B956E345D0AB") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
  }

  if(!istrue(var_4.playerdisconnect)) {
    if(var_1 == "_encstr_9AE307B956E345D0AB")
      var_3 controlsunlink();

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

tac_rover_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("_encstr_9A120A1D8536F5E4ED3BB293", 1);
  var_0.maxinstancecount = 2;
  var_0.priority = 75;
  var_0.getspawnstructscallback = ::tac_rover_getspawnstructscallback;
  var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A120A1D8536F5E4ED3BB293", "_encstr_8EB20E9B286B7B1BF527FCE44E59E784");
  var_0.clearancecheckradius = 120;
  var_0.clearancecheckheight = 82;
  var_0.clearancecheckminradius = 120;
}

tac_rover_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9B910F8E2C36937BD956E47DCDC10BEECD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag(var_0, 1);

    if(var_0.size > 1)
      var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  return var_0;
}